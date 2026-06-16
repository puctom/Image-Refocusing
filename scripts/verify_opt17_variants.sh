#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

VARIANTS=(
    opt17_no_ilp_no_reuse
    opt17_ilp_only
    opt17_row_reuse_only
)

declare -A RESULTS

for variant in "${VARIANTS[@]}"; do
    echo
    echo "============================================================"
    echo "Validating $variant ..."
    echo "============================================================"
    if python3 "$SCRIPT_DIR/validate.py" "$variant"; then
        RESULTS[$variant]=PASS
    else
        RESULTS[$variant]=FAIL
    fi
done

echo
echo "============================================================"
echo "Summary"
echo "============================================================"
all_ok=true
for variant in "${VARIANTS[@]}"; do
    if [[ "${RESULTS[$variant]}" == "PASS" ]]; then
        echo "  $variant: $(tput setaf 2)PASS$(tput sgr0)"
    else
        echo "  $variant: $(tput setaf 1)FAIL$(tput sgr0)"
        all_ok=false
    fi
done

$all_ok
