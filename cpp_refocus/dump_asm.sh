#!/usr/bin/env bash
# Compile all ablation-chain sources to Intel-syntax assembly.
# Run from cpp_refocus/:  bash dump_asm.sh
set -euo pipefail

CXX=${CXX:-g++-16}
COMMON="-O3 -std=c++17 -Iinclude -Ideps -S -masm=intel"
SCALAR="-march=native -ffast-math -fno-tree-vectorize"
AVX="-march=native -ffast-math -mavx2 -mfma"

OUT=asm
mkdir -p "$OUT"

compile() {
    local flags="$1"
    local src="$2"
    local out="$3"
    echo "  $src  ->  $OUT/$out"
    $CXX $COMMON $flags "$src" -o "$OUT/$out"
}

echo "=== Scalar / compiler-vectorized ==="
compile "$SCALAR" src/opt7_5.cpp                                                            opt7_5_scalar.s
compile "$AVX"    src/avx_analysis_code_ablations/opt7_5_abl_compiler_vec.cpp              opt7_5_compiler_vec.s

echo "=== Hand-vectorized, no tile ==="
compile "$AVX"    src/avx_analysis_code_ablations/opt9_abl_hand_vec_no_tile.cpp            opt9_hand_vec_no_tile.s

echo "=== Tiling ablations ==="
compile "$AVX"    src/avx_analysis_code_ablations/opt10_abl_tile_8x256.cpp                 opt10_tile_8x256.s
compile "$AVX"    src/avx_analysis_code_ablations/opt11_abl_tile_8x2032.cpp                opt11_tile_8x2032.s

echo "=== ILP + register-reuse ablations ==="
compile "$AVX"    src/avx_analysis_code_ablations/opt17_0_abl_tile_8x2032_ilp.cpp         opt17_0_tile_ilp.s
compile "$AVX"    src/avx_analysis_code_ablations/opt17_abl_tile_8x2032_ilp_reuse.cpp     opt17_tile_ilp_reuse.s

echo "=== Reference opt17 variants ==="
compile "$AVX"    src/opt17_no_ilp_no_reuse.cpp                                            opt17_no_ilp_no_reuse.s
compile "$AVX"    src/opt17_ilp_only.cpp                                                   opt17_ilp_only.s
compile "$AVX"    src/opt17_row_reuse_only.cpp                                             opt17_row_reuse_only.s
compile "$AVX"    src/opt17.cpp                                                             opt17.s

echo ""
echo "Done. Assembly files written to cpp_refocus/$OUT/"
echo "Tip: search for 'refocus_shift_and_sum' in each .s file to find the hot function."
