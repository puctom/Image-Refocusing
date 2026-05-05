import os
import sys
import subprocess
from pathlib import Path

from PIL import Image

SCRIPT_DIR = Path(__file__).resolve().parent
PROJECT_ROOT = SCRIPT_DIR.parent
CPP_DIR = PROJECT_ROOT / "cpp_refocus"
sys.path.insert(0, str(SCRIPT_DIR))
import validate as v

FOCUS_VALUES = v.FOCUS_VALUES
EPSILON      = v.EPSILON

def build_cpp(target):
    subprocess.run(["make", f"build/{target}"], cwd=CPP_DIR, check=True)

def run_stack(stack_target: str, output_dir: Path):
    binary_path = CPP_DIR / "build" / stack_target
    args = [str(binary_path), str(v.PATH), str(output_dir)] + [str(f) for f in FOCUS_VALUES]
    subprocess.run(args, check=True)

def compare_single(focus, stack_out_dir: Path):
    idx = FOCUS_VALUES.index(focus)
    fname = str(focus).replace(".", "_") + ".png"
    rust = Image.open(v.OUT / "rust" / fname)
    cpp  = Image.open(stack_out_dir / f"stack_{idx}.png")

    rust_data = rust.get_flattened_data()
    cpp_data  = cpp.get_flattened_data()

    if len(rust_data) != len(cpp_data):
        raise RuntimeError(f"Rust and CPP versions of {fname} have different sizes!")

    for i in range(len(rust_data)):
        for band in range(3):
            diff = abs(rust_data[i][band] - cpp_data[i][band])  # type: ignore
            if diff > EPSILON:
                print(f"Rust and CPP pixel values differ by {diff} on position {i} band {band} in image {fname}")
                return False
    return True

def main():
    if len(sys.argv) != 2:
        print("Usage: python validate_stack.py <cpp_target_name>")
        sys.exit(1)

    target = sys.argv[1]
    if not v.validation_data_exists():
        print("Validation data not found, downloading...")
        v.download_test_images()

    build_cpp(target)

    stack_out = v.OUT / "cpp_stack"
    os.makedirs(stack_out, exist_ok=True)
    run_stack(target, stack_out)

    if not v.rust_results_exist():
        v.run_rust()

    results = []
    for f in FOCUS_VALUES:
        ok = compare_single(f, stack_out)
        results.append(ok)
    if all(results):
        print("\u001b[32mVALIDATION SUCCESSFUL\u001b[0m")
    else:
        print("\u001b[31mVALIDATION FAILED\u001b[0m")
        sys.exit(1)

if __name__ == "__main__":
    main()