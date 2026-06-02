#!/usr/bin/env bash
# Extra arguments are forwarded to benchmark.py, e.g.:
#   ./bench_opt17_variants.sh --sizes 256 512 1024 --exclude-real
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

VARIANTS=(
    opt17_no_ilp_no_reuse
    opt17_ilp_only
    opt17_row_reuse_only
)

for variant in "${VARIANTS[@]}"; do
    echo
    echo "============================================================"
    echo "Benchmarking $variant ..."
    echo "============================================================"
    python3 "$SCRIPT_DIR/benchmark.py" "$variant" "$@"
done
