#!/usr/bin/env bash
# Compile all AVX reported sources to assembly with source-line correspondence.
# Produces two outputs per file:
#   asm/*.s        — assembly with variable-name comments (-fverbose-asm)
#                    and .loc directives pointing back to source lines (-g)
#   asm/*.annotated.s — source lines interleaved with instructions (objdump -S)
set -euo pipefail

CXX=${CXX:-g++-16}
BASE="-O3 -std=c++17 -Iinclude -Ideps"
SCALAR="-march=native -ffast-math -fno-tree-vectorize"
AVX="-march=native -ffast-math -mavx2 -mfma"

OUT=asm
mkdir -p "$OUT"

# Compile to .s (verbose asm + source loc directives) AND
# compile to .o then objdump -S for true source-interleaved view.
compile() {
    local flags="$1"
    local src="$2"
    local stem="$3"

    echo "  $src  ->  $OUT/${stem}.s  +  $OUT/${stem}.annotated.s"

    # .s with variable-name comments and .loc source-line markers
    $CXX $BASE $flags -S -masm=intel -fverbose-asm -g \
        "$src" -o "$OUT/${stem}.s"

    # object file (needed for objdump -S)
    $CXX $BASE $flags -c -g \
        "$src" -o "$OUT/${stem}.o"

    # interleaved source + asm
    objdump -d -S -M intel --no-show-raw-insn "$OUT/${stem}.o" \
        | c++filt > "$OUT/${stem}.annotated.s"

    rm "$OUT/${stem}.o"
}

echo "=== Scalar / compiler-vectorized ==="
compile "$SCALAR" src/opt7_5.cpp                                                                opt7_5_scalar
compile "$AVX"    src/avx_analysis_code_ablations/opt7_5_abl_compiler_vec.cpp                  opt7_5_abl_compiler_vec

echo "=== Hand-vectorized, no tile ==="
compile "$AVX"    src/avx_analysis_code_ablations/opt9_abl_hand_vec_no_tile.cpp                opt9_abl_hand_vec_no_tile
compile "$AVX"    src/avx_analysis_code_ablations/opt9_abl_hand_vec_no_tile_ilp.cpp            opt9_abl_hand_vec_no_tile_ilp

echo "=== 8x256 tile ==="
compile "$AVX"    src/avx_analysis_code_ablations/opt10_abl_tile_8x256.cpp                     opt10_abl_tile_8x256
compile "$AVX"    src/avx_analysis_code_ablations/opt10_abl_tile_8x256_ilp.cpp                 opt10_abl_tile_8x256_ilp

echo "=== 8x2032 tile + ILP + reuse ==="
compile "$AVX"    src/avx_analysis_code_ablations/opt11_abl_tile_8x2032.cpp                    opt11_abl_tile_8x2032
compile "$AVX"    src/avx_analysis_code_ablations/opt17_0_abl_tile_8x2032_ilp.cpp              opt17_0_abl_tile_8x2032_ilp
compile "$AVX"    src/avx_analysis_code_ablations/opt17_abl_tile_8x2032_ilp_reuse.cpp          opt17_abl_tile_8x2032_ilp_reuse


echo ""
echo "Done. Files written to cpp_refocus/$OUT/"
