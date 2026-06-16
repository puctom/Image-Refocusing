#include "refocus.hpp"
#include "utils.hpp"
#include <vector>
#include <cmath>
#include <algorithm>
#include <immintrin.h>

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
*       - unroll the main vectorized loop to increase ILP for independent vectors accumulations
*       - 2-row y unroll
*       - hoist A, B, C, D into broadcasted AVX registers
*       - fuse multiple output rows (2-row and 4-row processing blocks)
* */

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
    int v = static_cast<int>(std::lround(x * static_cast<float>(Q_SCALE)));// TODO: check if other rounding is etter
    if (v < 0) return 0; // TODO: branches to be removed, never can happen
    if (v > Q_SCALE) return Q_SCALE;
    return v;
}

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

static inline __m128i load_16bit_ints(const unsigned char* ptr) {
    return 
        _mm_loadu_si128(reinterpret_cast<const __m128i*>(ptr));
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
        p.A = (1.0f - dx) * (1.0f - dy);
        p.B = dx           * (1.0f - dy);
        p.C = (1.0f - dx) * dy;
        p.D = dx           * dy;

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

    std::vector<int> counts(width * height, 0);
    {
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
    }

    const int TILE_H = 8;
    const int TILE_W = 2032;

    std::vector<std::uint16_t> tile_vals(TILE_H * TILE_W * 3);

    for (int ty = 0; ty < h; ty += TILE_H) {
        const int tile_y_end    = std::min(ty + TILE_H, h);
        const int tile_h_actual = tile_y_end - ty;

        for (int tx = 0; tx < w; tx += TILE_W) {
            const int tile_x_end    = std::min(tx + TILE_W, w);
            const int tile_w_actual = tile_x_end - tx;
            const size_t tile_row_stride = (size_t)tile_w_actual * 3;

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

                // const __m256 Avx = _mm256_set1_ps(p.A);
                // const __m256 Bvx = _mm256_set1_ps(p.B);
                // const __m256 Cvx = _mm256_set1_ps(p.C);
                // const __m256 Dvx = _mm256_set1_ps(p.D);
                const __m256i coeff_ab = _mm256_set1_epi32((p.Bq << 16) | p.Aq);
                const __m256i coeff_cd = _mm256_set1_epi32((p.Dq << 16) | p.Cq);

                const int x_floats = (x_end - x_begin) * 3;

                int y = y_begin;

                for (; y + 3 < y_end; y += 4) {
                    size_t rb[5];
                    rb[0] = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
                    rb[1] = rb[0] + width * 3;
                    rb[2] = rb[1] + width * 3;
                    rb[3] = rb[2] + width * 3;
                    rb[4] = rb[3] + width * 3;

                    std::uint16_t* vp0 = tile_vals.data() + (size_t)(y     - ty) * tile_row_stride + (size_t)(x_begin - tx) * 3;
                    std::uint16_t* vp1 = vp0 + tile_row_stride;
                    std::uint16_t* vp2 = vp1 + tile_row_stride;
                    std::uint16_t* vp3 = vp2 + tile_row_stride;

                    int xf = 0;

                    for (; xf + 32 <= x_floats; xf += 32) {
                        __m128i rl0_lo = load_16bit_ints(p.SUB + rb[0] + xf);
                        __m128i rr0_lo = load_16bit_ints(p.SUB + rb[0] + xf +  3);
                        __m128i rl1_lo = load_16bit_ints(p.SUB + rb[1] + xf);
                        __m128i rr1_lo = load_16bit_ints(p.SUB + rb[1] + xf +  3);

                        __m128i rl0_hi = load_16bit_ints(p.SUB + rb[0] + xf +  8 + 8);
                        __m128i rr0_hi = load_16bit_ints(p.SUB + rb[0] + xf + 11 + 8);
                        __m128i rl1_hi = load_16bit_ints(p.SUB + rb[1] + xf +  8 + 8);
                        __m128i rr1_hi = load_16bit_ints(p.SUB + rb[1] + xf + 11 + 8);
                        

                        __m256i addv0 = weighted_half_contrib_16_avx2(rl0_lo, rr0_lo, rl1_lo, rr1_lo, coeff_ab, coeff_cd);
                        __m256i acc0 = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(vp0 + xf));
                        acc0 = _mm256_add_epi16(acc0, addv0);
                        _mm256_storeu_si256(reinterpret_cast<__m256i*>(vp0 + xf), acc0);
                        
                        __m256i addv1 = weighted_half_contrib_16_avx2(rl0_hi, rr0_hi, rl1_hi, rr1_hi, coeff_ab, coeff_cd);
                        __m256i acc1 = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(vp0 + xf + 16));
                        acc1 = _mm256_add_epi16(acc1, addv1);
                        _mm256_storeu_si256(reinterpret_cast<__m256i*>(vp0 + xf + 16), acc1);

                        __m128i rl2_lo = load_16bit_ints(p.SUB + rb[2] + xf);
                        __m128i rl2_hi = load_16bit_ints(p.SUB + rb[2] + xf +  8 + 8);
                        __m128i rr2_lo = load_16bit_ints(p.SUB + rb[2] + xf +  3);
                        __m128i rr2_hi = load_16bit_ints(p.SUB + rb[2] + xf + 11 + 8);

                        __m256i addv2 = weighted_half_contrib_16_avx2(rl1_lo, rr1_lo, rl2_lo, rr2_lo, coeff_ab, coeff_cd);
                        __m256i acc2 = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(vp1 + xf));
                        acc2 = _mm256_add_epi16(acc2, addv2);
                        _mm256_storeu_si256(reinterpret_cast<__m256i*>(vp1 + xf), acc2);

                        
                        __m256i addv3 = weighted_half_contrib_16_avx2(rl1_hi, rr1_hi, rl2_hi, rr2_hi, coeff_ab, coeff_cd);
                        __m256i acc3 = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(vp1 + xf + 16));
                        acc3 = _mm256_add_epi16(acc3, addv3);
                        _mm256_storeu_si256(reinterpret_cast<__m256i*>(vp1 + xf + 16), acc3);
                      
                        __m128i rl3_lo = load_16bit_ints(p.SUB + rb[3] + xf);
                        __m128i rl3_hi = load_16bit_ints(p.SUB + rb[3] + xf +  8 + 8);
                        __m128i rr3_lo = load_16bit_ints(p.SUB + rb[3] + xf +  3);
                        __m128i rr3_hi = load_16bit_ints(p.SUB + rb[3] + xf + 11 + 8);
                        

                        __m256i addv4 = weighted_half_contrib_16_avx2(rl2_lo, rr2_lo, rl3_lo, rr3_lo, coeff_ab, coeff_cd);
                        __m256i acc4 = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(vp2 + xf));
                        acc4 = _mm256_add_epi16(acc4, addv4);
                        _mm256_storeu_si256(reinterpret_cast<__m256i*>(vp2 + xf), acc4);

                        
                        __m256i addv5 = weighted_half_contrib_16_avx2(rl2_hi, rr2_hi, rl3_hi, rr3_hi, coeff_ab, coeff_cd);
                        __m256i acc5 = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(vp2 + xf + 16));
                        acc5 = _mm256_add_epi16(acc5, addv5);
                        _mm256_storeu_si256(reinterpret_cast<__m256i*>(vp2 + xf + 16), acc5);


                        __m128i rl4_lo = load_16bit_ints(p.SUB + rb[4] + xf);
                        __m128i rl4_hi = load_16bit_ints(p.SUB + rb[4] + xf +  8 + 8);
                        __m128i rr4_lo = load_16bit_ints(p.SUB + rb[4] + xf +  3);
                        __m128i rr4_hi = load_16bit_ints(p.SUB + rb[4] + xf + 11 + 8);
                        

                        __m256i addv6 = weighted_half_contrib_16_avx2(rl3_lo, rr3_lo, rl4_lo, rr4_lo, coeff_ab, coeff_cd);
                        __m256i acc6 = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(vp3 + xf));
                        acc6 = _mm256_add_epi16(acc6, addv6);
                        _mm256_storeu_si256(reinterpret_cast<__m256i*>(vp3 + xf), acc6);

                        
                        __m256i addv7 = weighted_half_contrib_16_avx2(rl3_hi, rr3_hi, rl4_hi, rr4_hi, coeff_ab, coeff_cd);
                        __m256i acc7 = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(vp3 + xf + 16));
                        acc7 = _mm256_add_epi16(acc7, addv7);
                        _mm256_storeu_si256(reinterpret_cast<__m256i*>(vp3 + xf + 16), acc7);

                    }

                    if (xf + 16 <= x_floats) {
                        __m128i rl0 = load_16bit_ints(p.SUB + rb[0] + xf);
                        __m128i rr0 = load_16bit_ints(p.SUB + rb[0] + xf + 3);
                        __m128i rl1 = load_16bit_ints(p.SUB + rb[1] + xf);
                        __m128i rr1 = load_16bit_ints(p.SUB + rb[1] + xf + 3);
                        
                        
                        
                        __m256i addv0 = weighted_half_contrib_16_avx2(rl0, rr0, rl1, rr1, coeff_ab, coeff_cd);
                        __m256i acc0 = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(vp0 + xf));
                        acc0 = _mm256_add_epi16(acc0, addv0);
                        _mm256_storeu_si256(reinterpret_cast<__m256i*>(vp0 + xf), acc0);


                        __m128i rl2 = load_16bit_ints(p.SUB + rb[2] + xf);
                        __m128i rr2 = load_16bit_ints(p.SUB + rb[2] + xf + 3);
                        
                        
                        __m256i addv1 = weighted_half_contrib_16_avx2(rl1, rr1, rl2, rr2, coeff_ab, coeff_cd);
                        __m256i acc1 = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(vp1 + xf));
                        acc1 = _mm256_add_epi16(acc1, addv1);
                        _mm256_storeu_si256(reinterpret_cast<__m256i*>(vp1 + xf), acc1);

                        __m128i rl3 = load_16bit_ints(p.SUB + rb[3] + xf);
                        __m128i rr3 = load_16bit_ints(p.SUB + rb[3] + xf + 3);
                       
                        __m256i addv2 = weighted_half_contrib_16_avx2(rl2, rr2, rl3, rr3, coeff_ab, coeff_cd);
                        __m256i acc2 = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(vp2 + xf));
                        acc2 = _mm256_add_epi16(acc2, addv2);
                        _mm256_storeu_si256(reinterpret_cast<__m256i*>(vp2 + xf), acc2);
                        

                        __m128i rl4 = load_16bit_ints(p.SUB + rb[4] + xf);
                        __m128i rr4 = load_16bit_ints(p.SUB + rb[4] + xf + 3);
                       
                        
                        __m256i addv3 = weighted_half_contrib_16_avx2(rl3, rr3, rl4, rr4, coeff_ab, coeff_cd);
                        __m256i acc3 = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(vp3 + xf));
                        acc3 = _mm256_add_epi16(acc3, addv3);
                        _mm256_storeu_si256(reinterpret_cast<__m256i*>(vp3 + xf), acc3);

                        xf += 16;
                    }

                    for (int k = 0; k < x_floats - xf; ++k) {
                        const int s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
                        const int s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
                        const int s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
                        const int s3l = p.SUB[rb[3]+xf+k], s3r = p.SUB[rb[3]+xf+k+3];
                        const int s4l = p.SUB[rb[4]+xf+k], s4r = p.SUB[rb[4]+xf+k+3];
                        
                        int sum0 = s0l * p.Aq + s0r * p.Bq + s1l * p.Cq + s1r * p.Dq;
                        vp0[xf+k] = static_cast<std::uint16_t>(vp0[xf+k] + static_cast<std::uint16_t>((sum0 + HALF_ROUND) >> HALF_SHIFT));
                        
                        int sum1 = s1l * p.Aq + s1r * p.Bq + s2l * p.Cq + s2r * p.Dq;
                        vp1[xf+k] = static_cast<std::uint16_t>(vp1[xf+k] + static_cast<std::uint16_t>((sum1 + HALF_ROUND) >> HALF_SHIFT));
                        
                        int sum2 = s2l * p.Aq + s2r * p.Bq + s3l * p.Cq + s3r * p.Dq;
                        vp2[xf+k] = static_cast<std::uint16_t>(vp2[xf+k] + static_cast<std::uint16_t>((sum2 + HALF_ROUND) >> HALF_SHIFT));
                        
                        int sum3 = s3l * p.Aq + s3r * p.Bq + s4l * p.Cq + s4r * p.Dq;
                        vp3[xf+k] = static_cast<std::uint16_t>(vp3[xf+k] + static_cast<std::uint16_t>((sum3 + HALF_ROUND) >> HALF_SHIFT));
                    }
                }

                for (; y + 1 < y_end; y += 2) {
                    size_t rb[3];
                    rb[0] = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
                    rb[1] = rb[0] + width * 3;
                    rb[2] = rb[1] + width * 3;

                    std::uint16_t* vp0 = tile_vals.data() + (size_t)(y - ty)     * tile_row_stride + (size_t)(x_begin - tx) * 3;
                    std::uint16_t* vp1 = vp0 + tile_row_stride;

                    int xf = 0;

                    for (; xf + 32 <= x_floats; xf += 32) {
                        __m128i rl0_lo = load_16bit_ints(p.SUB + rb[0] + xf);
                        __m128i rr0_lo = load_16bit_ints(p.SUB + rb[0] + xf +  3);
                        __m128i rl1_lo = load_16bit_ints(p.SUB + rb[1] + xf);
                        __m128i rr1_lo = load_16bit_ints(p.SUB + rb[1] + xf +  3);

                        __m128i rl0_hi = load_16bit_ints(p.SUB + rb[0] + xf +  8 + 8);
                        __m128i rr0_hi = load_16bit_ints(p.SUB + rb[0] + xf + 11 + 8);
                        __m128i rl1_hi = load_16bit_ints(p.SUB + rb[1] + xf +  8 + 8);
                        __m128i rr1_hi = load_16bit_ints(p.SUB + rb[1] + xf + 11 + 8);     

                        __m256i addv0 = weighted_half_contrib_16_avx2(rl0_lo, rr0_lo, rl1_lo, rr1_lo, coeff_ab, coeff_cd);
                        __m256i acc0 = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(vp0 + xf));
                        acc0 = _mm256_add_epi16(acc0, addv0);
                        _mm256_storeu_si256(reinterpret_cast<__m256i*>(vp0 + xf), acc0);
                        
                        __m256i addv1 = weighted_half_contrib_16_avx2(rl0_hi, rr0_hi, rl1_hi, rr1_hi, coeff_ab, coeff_cd);
                        __m256i acc1 = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(vp0 + xf + 16));
                        acc1 = _mm256_add_epi16(acc1, addv1);
                        _mm256_storeu_si256(reinterpret_cast<__m256i*>(vp0 + xf + 16), acc1);

                        __m128i rl2_lo = load_16bit_ints(p.SUB + rb[2] + xf);
                        __m128i rl2_hi = load_16bit_ints(p.SUB + rb[2] + xf +  8 + 8);
                        __m128i rr2_lo = load_16bit_ints(p.SUB + rb[2] + xf +  3);
                        __m128i rr2_hi = load_16bit_ints(p.SUB + rb[2] + xf + 11 + 8);

                        __m256i addv2 = weighted_half_contrib_16_avx2(rl1_lo, rr1_lo, rl2_lo, rr2_lo, coeff_ab, coeff_cd);
                        __m256i acc2 = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(vp1 + xf));
                        acc2 = _mm256_add_epi16(acc2, addv2);
                        _mm256_storeu_si256(reinterpret_cast<__m256i*>(vp1 + xf), acc2);

                        
                        __m256i addv3 = weighted_half_contrib_16_avx2(rl1_hi, rr1_hi, rl2_hi, rr2_hi, coeff_ab, coeff_cd);
                        __m256i acc3 = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(vp1 + xf + 16));
                        acc3 = _mm256_add_epi16(acc3, addv3);
                        _mm256_storeu_si256(reinterpret_cast<__m256i*>(vp1 + xf + 16), acc3);
                    }

                    if (xf + 16 <= x_floats) {
                        __m128i rl0 = load_16bit_ints(p.SUB + rb[0] + xf);
                        __m128i rr0 = load_16bit_ints(p.SUB + rb[0] + xf + 3);
                        __m128i rl1 = load_16bit_ints(p.SUB + rb[1] + xf);
                        __m128i rr1 = load_16bit_ints(p.SUB + rb[1] + xf + 3);
                        
                        
                        
                        __m256i addv0 = weighted_half_contrib_16_avx2(rl0, rr0, rl1, rr1, coeff_ab, coeff_cd);
                        __m256i acc0 = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(vp0 + xf));
                        acc0 = _mm256_add_epi16(acc0, addv0);
                        _mm256_storeu_si256(reinterpret_cast<__m256i*>(vp0 + xf), acc0);

                        __m128i rl2 = load_16bit_ints(p.SUB + rb[2] + xf);
                        __m128i rr2 = load_16bit_ints(p.SUB + rb[2] + xf + 3);
                        
                        __m256i addv1 = weighted_half_contrib_16_avx2(rl1, rr1, rl2, rr2, coeff_ab, coeff_cd);
                        __m256i acc1 = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(vp1 + xf));
                        acc1 = _mm256_add_epi16(acc1, addv1);
                        _mm256_storeu_si256(reinterpret_cast<__m256i*>(vp1 + xf), acc1);
                        
                        xf += 16;
                    }

                    for (int k = 0; k < x_floats - xf; ++k) {
                        const int s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
                        const int s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
                        const int s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
                        
                        int sum0 = s0l * p.Aq + s0r * p.Bq + s1l * p.Cq + s1r * p.Dq;
                        vp0[xf+k] = static_cast<std::uint16_t>(vp0[xf+k] + static_cast<std::uint16_t>((sum0 + HALF_ROUND) >> HALF_SHIFT));
                        
                        int sum1 = s1l * p.Aq + s1r * p.Bq + s2l * p.Cq + s2r * p.Dq;
                        vp1[xf+k] = static_cast<std::uint16_t>(vp1[xf+k] + static_cast<std::uint16_t>((sum1 + HALF_ROUND) >> HALF_SHIFT));
                    }
                }

                if (y < y_end) {
                    size_t rb0 = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
                    size_t rb1 = rb0 + width * 3;

                    std::uint16_t* vp = tile_vals.data() + (size_t)(y - ty) * tile_row_stride + (size_t)(x_begin - tx) * 3;

                    int xf = 0;

                    for (; xf + 32 <= x_floats; xf += 32) {
                        __m128i rl0_lo = load_16bit_ints(p.SUB + rb0 + xf);
                        __m128i rr0_lo = load_16bit_ints(p.SUB + rb0 + xf +  3);
                        __m128i rl1_lo = load_16bit_ints(p.SUB + rb1 + xf);
                        __m128i rr1_lo = load_16bit_ints(p.SUB + rb1 + xf +  3);

                        __m128i rl0_hi = load_16bit_ints(p.SUB + rb0 + xf +  8 + 8);
                        __m128i rr0_hi = load_16bit_ints(p.SUB + rb0 + xf + 11 + 8);
                        __m128i rl1_hi = load_16bit_ints(p.SUB + rb1 + xf +  8 + 8);
                        __m128i rr1_hi = load_16bit_ints(p.SUB + rb1 + xf + 11 + 8);
                        

                        __m256i addv0 = weighted_half_contrib_16_avx2(rl0_lo, rr0_lo, rl1_lo, rr1_lo, coeff_ab, coeff_cd);
                        __m256i acc0 = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(vp + xf));
                        acc0 = _mm256_add_epi16(acc0, addv0);
                        _mm256_storeu_si256(reinterpret_cast<__m256i*>(vp + xf), acc0);
                        
                        __m256i addv1 = weighted_half_contrib_16_avx2(rl0_hi, rr0_hi, rl1_hi, rr1_hi, coeff_ab, coeff_cd);
                        __m256i acc1 = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(vp + xf + 16));
                        acc1 = _mm256_add_epi16(acc1, addv1);
                        _mm256_storeu_si256(reinterpret_cast<__m256i*>(vp + xf + 16), acc1);

                    }

                    if (xf + 16 <= x_floats) {
                        __m128i rl0 = load_16bit_ints(p.SUB + rb0 + xf);
                        __m128i rr0 = load_16bit_ints(p.SUB + rb0 + xf + 3);
                        __m128i rl1 = load_16bit_ints(p.SUB + rb1 + xf);
                        __m128i rr1 = load_16bit_ints(p.SUB + rb1 + xf + 3);
                        
                        __m256i addv0 = weighted_half_contrib_16_avx2(rl0, rr0, rl1, rr1, coeff_ab, coeff_cd);
                        __m256i acc0 = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(vp + xf));
                        acc0 = _mm256_add_epi16(acc0, addv0);
                        _mm256_storeu_si256(reinterpret_cast<__m256i*>(vp + xf), acc0);
                        xf += 16;
                    }

                    for (int k = 0; k < x_floats - xf; ++k) {
                        const int s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
                        const int s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
                        
                        const int sum = s0l * p.Aq + s0r * p.Bq + s1l * p.Cq + s1r * p.Dq;
                        vp[xf+k] = static_cast<std::uint16_t>(vp[xf+k] + static_cast<std::uint16_t>((sum + HALF_ROUND) >> HALF_SHIFT));
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