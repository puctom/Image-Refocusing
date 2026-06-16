#include "refocus.hpp"
#include "utils.hpp"
#include <vector>
#include <cmath>
#include <algorithm>
#include <immintrin.h>
#include <cstdint>

/*
*   List of Optimizations:
*       - Change the loop order to [Subaperture, y, x] for improved locality
*       - Common subexpression elimination
*       - use better bounds for the x-y loops
*       - use unchecked array access
*       - function inlining
*       - unroll channel loop to expose independent scalar ops for ILP
*       - reduce number of loads in innermost loop
*       - use AVX float32 FMA with unaligned loads
*       - use block tiles for better cache performance
*       - calculate counts using prefix sum technique
* */

namespace {
struct SubParams {
    int sx, sy;
    float A, B, C, D;
    int Aq, Bq, Cq, Dq;
    int x_begin, x_end, y_begin, y_end;
    const unsigned char* SUB;
};

constexpr int Q_BITS = 14;
constexpr int Q_SCALE = 1 << Q_BITS;

// Store round(contribution / 2).
// contribution is Q14, so divide by 2 * 2^14 = 2^15.
constexpr int HALF_SHIFT = Q_BITS + 1;
constexpr int HALF_ROUND = 1 << (HALF_SHIFT - 1);

static inline int to_q14(float x) {
    int v = static_cast<int>(std::lround(x * static_cast<float>(Q_SCALE)));
    if (v < 0) return 0;
    if (v > Q_SCALE) return Q_SCALE;
    return v;
}

// Computes 16 lanes:
//
// half_i = round((A*TL_i + B*TR_i + C*BL_i + D*BR_i) / 2)
//
// Input: 16 bytes from each source position.
// Output: 16 x uint16_t in a __m256i.
static inline __m256i weighted_half_contrib_16_avx2(
    __m128i tl_b,
    __m128i tr_b,
    __m128i bl_b,
    __m128i br_b,
    __m256i coeff_ab,
    __m256i coeff_cd
) {
    const __m256i roundv = _mm256_set1_epi32(HALF_ROUND);

    // 16 x u8 -> 16 x u16.
    __m256i tl = _mm256_cvtepu8_epi16(tl_b);
    __m256i tr = _mm256_cvtepu8_epi16(tr_b);
    __m256i bl = _mm256_cvtepu8_epi16(bl_b);
    __m256i br = _mm256_cvtepu8_epi16(br_b);

    // For each 128-bit lane:
    // top_lo: TL0 TR0 TL1 TR1 TL2 TR2 TL3 TR3
    // top_hi: TL4 TR4 TL5 TR5 TL6 TR6 TL7 TR7
    //
    // In the upper 128-bit lane, the same happens for elements 8..15.
    __m256i top_lo = _mm256_unpacklo_epi16(tl, tr);
    __m256i top_hi = _mm256_unpackhi_epi16(tl, tr);
    __m256i bot_lo = _mm256_unpacklo_epi16(bl, br);
    __m256i bot_hi = _mm256_unpackhi_epi16(bl, br);

    // madd_epi16 does:
    // i32 = x0*c0 + x1*c1
    //
    // coeff_ab is A,B,A,B,...
    // coeff_cd is C,D,C,D,...
    __m256i sum_lo = _mm256_add_epi32(
        _mm256_madd_epi16(top_lo, coeff_ab),
        _mm256_madd_epi16(bot_lo, coeff_cd)
    );

    __m256i sum_hi = _mm256_add_epi32(
        _mm256_madd_epi16(top_hi, coeff_ab),
        _mm256_madd_epi16(bot_hi, coeff_cd)
    );

    // Q14 weighted contribution -> round(contribution / 2).
    sum_lo = _mm256_srai_epi32(_mm256_add_epi32(sum_lo, roundv), HALF_SHIFT);
    sum_hi = _mm256_srai_epi32(_mm256_add_epi32(sum_hi, roundv), HALF_SHIFT);

    // packus_epi32 packs per 128-bit lane:
    //
    // lower 128: lanes 0..3 from sum_lo, lanes 0..3 from sum_hi
    // upper 128: lanes 8..11 from sum_lo, lanes 8..11 from sum_hi
    //
    // This gives final order:
    // 0 1 2 3 4 5 6 7 | 8 9 10 11 12 13 14 15
    return _mm256_packus_epi32(sum_lo, sum_hi);
}
}


ImageData refocus_shift_and_sum(std::vector<SubApertureImage>& subapertures, float focus) {
    const size_t width  = subapertures.front().data.width;
    const size_t height = subapertures.front().data.height;
    const int w = static_cast<int>(width);
    const int h = static_cast<int>(height);

    ImageData output;
    output.width = width;
    output.height = height;
    output.data.assign(width * height * 3, 0);

    // Precalculate subaperture parameters
    std::vector<SubParams> params;
    params.reserve(subapertures.size());

    for (auto& sub : subapertures) {
        SubParams p;

        float shift_x = focus * sub.u;
        float shift_y = focus * sub.v;

        p.sx = static_cast<int>(std::floor(shift_x));
        p.sy = static_cast<int>(std::floor(shift_y));

        float dx = shift_x - p.sx;
        float dy = shift_y - p.sy;

        p.A = (1 - dx) * (1 - dy);
        p.B = dx       * (1 - dy);
        p.C = (1 - dx) * dy;
        p.D = dx       * dy;

        p.Aq = to_q14(p.A);
        p.Bq = to_q14(p.B);
        p.Cq = to_q14(p.C);
        p.Dq = to_q14(p.D);

        p.x_begin = std::max(0, -p.sx);
        p.x_end   = std::min(w, w - p.sx - 1);
        p.y_begin = std::max(0, -p.sy);
        p.y_end   = std::min(h, h - p.sy - 1);

        p.SUB = sub.data.data.data();

        if (p.x_begin >= p.x_end || p.y_begin >= p.y_end) continue;
        params.push_back(p);
    }

    // Precalculate counts using 2D difference array / prefix sum.
    std::vector<int> counts(width * height, 0);
    std::vector<int> diff((width + 1) * (height + 1), 0);

    for (const auto& p : params) {
        diff[p.y_begin * (width + 1) + p.x_begin] += 1;
        diff[p.y_begin * (width + 1) + p.x_end  ] -= 1;
        diff[p.y_end   * (width + 1) + p.x_begin] -= 1;
        diff[p.y_end   * (width + 1) + p.x_end  ] += 1;
    }

    for (int y = 0; y < h; ++y) {
        int row = 0;
        for (int x = 0; x < w; ++x) {
            row += diff[y * (width + 1) + x];
            counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
        }
    }

    const int TILE_H = 8;
    const int TILE_W = 256;

    // Stores accumulated round(contribution / 2).
    //
    // For 289 subapertures, worst case is:
    //   round(255 / 2) * 289 = 128 * 289 = 36992
    // which safely fits in uint16_t.
    std::vector<std::uint16_t> tile_vals(TILE_H * TILE_W * 3);

    for (int ty = 0; ty < h; ty += TILE_H) {
        const int tile_y_end = std::min(ty + TILE_H, h);
        const int tile_h_actual = tile_y_end - ty;

        for (int tx = 0; tx < w; tx += TILE_W) {
            const int tile_x_end = std::min(tx + TILE_W, w);
            const int tile_w_actual = tile_x_end - tx;

            std::fill(
                tile_vals.begin(),
                tile_vals.begin() + tile_h_actual * tile_w_actual * 3,
                static_cast<std::uint16_t>(0)
            );

            for (const SubParams& p : params) {
                const int y_begin = std::max(ty, p.y_begin);
                const int y_end   = std::min(tile_y_end, p.y_end);
                const int x_begin = std::max(tx, p.x_begin);
                const int x_end   = std::min(tile_x_end, p.x_end);

                if (x_begin >= x_end || y_begin >= y_end) continue;

                // Each i32 contains two i16 coefficients: low=A, high=B.
                // This creates A,B,A,B,... as signed 16-bit lanes.
                const __m256i coeff_ab = _mm256_set1_epi32((p.Bq << 16) | p.Aq);
                const __m256i coeff_cd = _mm256_set1_epi32((p.Dq << 16) | p.Cq);

                for (int y = y_begin; y < y_end; ++y) {
                    size_t ind_ltop = ((y + p.sy) * width + (x_begin + p.sx)) * 3;
                    size_t ind_lbot = ind_ltop + width * 3;
                    size_t ind_rtop = ind_ltop + 3;
                    size_t ind_rbot = ind_lbot + 3;

                    std::uint16_t* vp = tile_vals.data()
                                      + (y - ty) * tile_w_actual * 3
                                      + (x_begin - tx) * 3;

                    int x = (x_begin - tx) * 3;
                    const int x_stop = (x_end - tx) * 3;

                    uintptr_t dest_addr = reinterpret_cast<uintptr_t>(vp);
                    size_t bytes_to_align = (32 - (dest_addr % 32)) % 32;

                    // Assuming each output element in vp is a 16-bit int (2 bytes)
                    // Adjust this divisor if your vp type is different.
                    size_t elements_to_align = bytes_to_align / sizeof(int16_t); 
                    size_t peel_count = std::min(static_cast<size_t>(x_stop - x), elements_to_align);

                    // Calculate the absolute coordinate where peeling stops
                    size_t peel_target = x + peel_count; 

                    // 2. The Peeling Loop
                    for (; x < peel_target; ++x) {
                        // Perform your scalar equivalent of weighted_half_contrib_16_avx2 here
                        // load ltop, rtop, lbot, rbot individually
                        // accumulate into vp[0]
                        const int TL = p.SUB[ind_ltop];
                        const int TR = p.SUB[ind_rtop];
                        const int BL = p.SUB[ind_lbot];
                        const int BR = p.SUB[ind_rbot];
                        const int sum =
                            TL * p.Aq +
                            TR * p.Bq +
                            BL * p.Cq +
                            BR * p.Dq;

                        const int half = (sum + HALF_ROUND) >> HALF_SHIFT;

                        vp[0] = static_cast<std::uint16_t>(
                            vp[0] + static_cast<std::uint16_t>(half)
                        );

                        // advance all pointers by 1
                        vp++; ind_ltop++; ind_rtop++; ind_lbot++; ind_rbot++;
                    }

                    // 3. The Main Aligned Loop
                    // Now 'vp' is guaranteed to be 32-byte aligned.
                    // We can use aligned loads/stores for 'vp'.
                    size_t vec_stop = x_stop - (x_stop - x) % 16;
                    
                    // Main vector tail: process 16 consecutive channel bytes.
                    for (; x < vec_stop; x += 16) {
                        __m128i ltop_b = _mm_loadu_si128(reinterpret_cast<const __m128i*>(p.SUB + ind_ltop));
                        __m128i rtop_b = _mm_loadu_si128(reinterpret_cast<const __m128i*>(p.SUB + ind_rtop));
                        __m128i lbot_b = _mm_loadu_si128(reinterpret_cast<const __m128i*>(p.SUB + ind_lbot));
                        __m128i rbot_b = _mm_loadu_si128(reinterpret_cast<const __m128i*>(p.SUB + ind_rbot));

                        __m256i addv = weighted_half_contrib_16_avx2(
                            ltop_b, rtop_b, lbot_b, rbot_b, coeff_ab, coeff_cd
                        );

                        // NOW ALIGNED: _mm256_load_si256 instead of loadu
                        __m256i acc = _mm256_load_si256(reinterpret_cast<const __m256i*>(vp));
                        acc = _mm256_add_epi16(acc, addv);
                        
                        // NOW ALIGNED: _mm256_store_si256 instead of storeu
                        _mm256_store_si256(reinterpret_cast<__m256i*>(vp), acc);

                        vp += 16;
                        ind_ltop += 16;
                        ind_rtop += 16;
                        ind_lbot += 16;
                        ind_rbot += 16;
                    }

                    // Scalar tail.
                    const int remaining = x_stop - x;
                    for (int k = 0; k < remaining; ++k) {
                        const int TL = p.SUB[ind_ltop + k];
                        const int TR = p.SUB[ind_rtop + k];
                        const int BL = p.SUB[ind_lbot + k];
                        const int BR = p.SUB[ind_rbot + k];

                        const int sum =
                            TL * p.Aq +
                            TR * p.Bq +
                            BL * p.Cq +
                            BR * p.Dq;

                        const int half = (sum + HALF_ROUND) >> HALF_SHIFT;

                        vp[k] = static_cast<std::uint16_t>(
                            vp[k] + static_cast<std::uint16_t>(half)
                        );
                    }
                }
            }

            for (int y = ty; y < tile_y_end; ++y) {
                const std::uint16_t* vp =
                    tile_vals.data() + (y - ty) * tile_w_actual * 3;

                unsigned char* outp =
                    output.data.data() + (y * width + tx) * 3;

                for (int x = 0; x < tile_w_actual; ++x) {
                    int c = counts[y * width + (tx + x)];

                    if (c == 0) {
                        outp[x * 3]     = 0;
                        outp[x * 3 + 1] = 0;
                        outp[x * 3 + 2] = 0;
                        continue;
                    }

                    for (int ch = 0; ch < 3; ++ch) {
                        int v = (static_cast<int>(vp[x * 3 + ch]) * 2) / c;

                        if (v > 255) v = 255;

                        outp[x * 3 + ch] = static_cast<unsigned char>(v);
                    }
                }
            }
        }
    }

    return output;
}
