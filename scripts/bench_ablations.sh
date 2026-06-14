#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

VARIANTS=(
    abl_compiler_vec
    abl_hand_vec_no_tile
    abl_tile_8x256
    abl_tile_8x2032
    abl_tile_8x2032_ilp
    abl_tile_8x2032_ilp_reuse
)

SIZES="256 384 512 768 1024 1536 2048 3072 4096"

for variant in "${VARIANTS[@]}"; do
    echo
    echo "============================================================"
    echo "Benchmarking $variant ..."
    echo "============================================================"
    python3 "$SCRIPT_DIR/benchmark.py" "$variant" --sizes $SIZES "$@"
done
