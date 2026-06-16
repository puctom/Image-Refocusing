#!/usr/bin/env python3
import argparse
from pathlib import Path

try:
    from PIL import Image, ImageChops
except ImportError as exc:
    raise SystemExit(
        "Pillow is required. Install project dependencies with "
        "`python3 -m pip install -r ../requirements.txt` or use `../venv/bin/python`."
    ) from exc


SCRIPT_DIR = Path(__file__).resolve().parent
PROJECT_ROOT = SCRIPT_DIR.parent
DEFAULT_OUT_DIR = PROJECT_ROOT / "in"
DEFAULT_SIZES = [256, 384, 512, 768, 1024, 1536, 2048]
GRID_SIZE = 17


def make_row(width, y):
    row = bytearray(width * 3)
    y_term = y & 0xFF
    for x in range(width):
        base = (x + y_term) & 0xFF
        idx = x * 3
        row[idx] = base
        row[idx + 1] = ((x * 3 + y * 2) >> 1) & 0xFF
        row[idx + 2] = ((x ^ y) + (x // 17) + (y // 19)) & 0xFF
    return row


def make_base_image(size):
    data = bytearray(size * size * 3)
    offset = 0
    for y in range(size):
        row = make_row(size, y)
        data[offset:offset + len(row)] = row
        offset += len(row)
    return Image.frombytes("RGB", (size, size), bytes(data))


def make_aperture_image(base_image, aperture_x, aperture_y):
    center = GRID_SIZE // 2
    shift_x = (aperture_x - center) * 2
    shift_y = (aperture_y - center) * 2
    return ImageChops.offset(base_image, shift_x, shift_y)


def filename_for(aperture_x, aperture_y):
    # The C++ loader parses v from field 3 and u from field 4 in:
    # out_<row>_<col>_<v>_<u>_.png
    center = (GRID_SIZE - 1) / 2.0
    spacing = 9.0
    v = (aperture_y - center) * spacing
    u = (aperture_x - center) * spacing
    return f"out_{aperture_y:02d}_{aperture_x:02d}_{v:.6f}_{u:.6f}_.png"


def generate_dataset(size, out_dir, overwrite):
    dataset_dir = out_dir / f"mock_{size}"
    dataset_dir.mkdir(parents=True, exist_ok=True)
    base_image = make_base_image(size)

    written = 0
    skipped = 0
    for aperture_y in range(GRID_SIZE):
        for aperture_x in range(GRID_SIZE):
            path = dataset_dir / filename_for(aperture_x, aperture_y)
            if path.exists() and not overwrite:
                skipped += 1
                continue

            image = make_aperture_image(base_image, aperture_x, aperture_y)
            image.save(path, optimize=True)
            written += 1

    return dataset_dir, written, skipped


def parse_args():
    parser = argparse.ArgumentParser(
        description="Generate mock 17x17 light-field PNG datasets under the project in/ directory."
    )
    parser.add_argument(
        "--out-dir",
        type=Path,
        default=DEFAULT_OUT_DIR,
        help=f"Output directory for generated datasets (default: {DEFAULT_OUT_DIR})",
    )
    parser.add_argument(
        "--sizes",
        type=int,
        nargs="+",
        default=DEFAULT_SIZES,
        help="Square image sizes to generate.",
    )
    parser.add_argument(
        "--overwrite",
        action="store_true",
        help="Regenerate files that already exist.",
    )
    return parser.parse_args()


def main():
    args = parse_args()
    args.out_dir.mkdir(parents=True, exist_ok=True)

    for size in args.sizes:
        if size <= 0:
            raise ValueError(f"Image size must be positive, got {size}")
        dataset_dir, written, skipped = generate_dataset(size, args.out_dir, args.overwrite)
        print(f"{dataset_dir}: wrote {written} PNGs, skipped {skipped}")


if __name__ == "__main__":
    main()
