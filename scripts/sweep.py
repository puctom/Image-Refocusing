#!/usr/bin/env python3
"""wandb sweep entry point for tile-size optimization."""
import csv
import subprocess
import sys
from pathlib import Path

import wandb

SCRIPT_DIR   = Path(__file__).resolve().parent
PROJECT_ROOT = SCRIPT_DIR.parent
CPP_DIR      = PROJECT_ROOT / "cpp_refocus"
BUILD_DIR    = CPP_DIR / "build"

# sweep config
TARGET     = "opt11"   # bench target name
IMAGE_SIZE = 2048
FOCUS      = 6.7

def main():
    wandb.init()
    tile_h = int(wandb.config.tile_h)
    tile_w = int(wandb.config.tile_w)

    # build and run the benchmark
    subprocess.run(["make", f"build/bench-{TARGET}"], cwd=CPP_DIR, check=True)

    timing_csv = SCRIPT_DIR / "timing_results" / f"sweep_{wandb.run.id}.csv"
    timing_csv.parent.mkdir(parents=True, exist_ok=True)

    label = f"sweep_{tile_h}x{tile_w}"
    cmd = [
        str(BUILD_DIR / f"bench-{TARGET}"),
        "--generate", str(IMAGE_SIZE), str(IMAGE_SIZE),
        str(FOCUS), label, str(timing_csv),
        str(tile_h), str(tile_w),
    ]
    print("Running:", " ".join(cmd))
    subprocess.run(cmd, check=True, cwd=CPP_DIR)

    # parse timing csv
    with open(timing_csv) as f:
        rows = list(csv.DictReader(f))
    if not rows:
        wandb.log({"median_cycles": float("inf")})
        sys.exit(1)

    median_cycles = int(rows[-1]["median_cycles"])

    wandb.log({
        "median_cycles": median_cycles,
        "tile_h":     tile_h,
        "tile_w":     tile_w,
        "image_size": IMAGE_SIZE,
        "tile_bytes": tile_h * tile_w * 3 * 4,   # useful for visualizing L1 fit
    })

if __name__ == "__main__":
    main()