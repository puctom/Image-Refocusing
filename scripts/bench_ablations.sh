#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

VARIANTS=(
    opt7_5_abl_compiler_vec
    opt9_abl_hand_vec_no_tile
    opt9_abl_hand_vec_no_tile_ilp
    opt10_abl_tile_8x256
    opt10_abl_tile_8x256_ilp
    opt11_abl_tile_8x2032
    opt17_0_abl_tile_8x2032_ilp
    opt17_abl_tile_8x2032_ilp_reuse
)

SIZES="256 512 768 1024 1280 1536 1792 2048 2304 2560 2816 3072"
SIZES="256 512 768 1024  1536  2048  2560  3072"

for variant in "${VARIANTS[@]}"; do
    echo
    echo "============================================================"
    echo "Benchmarking $variant ..."
    echo "============================================================"
    python3 "$SCRIPT_DIR/benchmark.py" "$variant" --sizes $SIZES "$@"
done
