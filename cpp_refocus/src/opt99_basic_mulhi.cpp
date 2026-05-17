#include "refocus.hpp"
#include "utils.hpp"
#include <vector>
#include <cmath>
#include <algorithm>
#include <immintrin.h>
#include <cstdint>

// Force inline to ensure the compiler perfectly interleaves the 
// instructions of the unrolled loop in register space.
#if defined(_MSC_VER)
#define FORCE_INLINE __forceinline
#else
#define FORCE_INLINE inline __attribute__((always_inline))
#endif

struct SubParams {
    int sx, sy;
    float A, B, C, D;
    unsigned int Aq, Bq, Cq, Dq;
    int x_begin, x_end, y_begin, y_end;
    const unsigned char* SUB;
};

constexpr int Q_BITS = 16;
constexpr int Q_SCALE = 1 << Q_BITS;

static inline unsigned int to_q16(float x) {
    int v = static_cast<int>(std::floor(x * static_cast<float>(Q_SCALE)));
    if (v < 0) return 0;
    if (v >= Q_SCALE) return Q_SCALE - 1; 
    return static_cast<unsigned int>(v);
}

static FORCE_INLINE __m256i weighted_contrib_16_avx2(
    __m128i tl_b,
    __m128i tr_b,
    __m128i bl_b,
    __m128i br_b,
    __m256i coeff_aa,
    __m256i coeff_bb,
    __m256i coeff_cc,
    __m256i coeff_dd
) {
    // 16 x u8 -> 16 x u16.
    __m256i tl = _mm256_cvtepu8_epi16(tl_b);
    __m256i tr = _mm256_cvtepu8_epi16(tr_b);
    __m256i bl = _mm256_cvtepu8_epi16(bl_b);
    __m256i br = _mm256_cvtepu8_epi16(br_b);

    // _mm256_mulhi_epu16 inherently shifts the 32-bit product right by 16
    __m256i tl_downscaled = _mm256_mulhi_epu16(tl, coeff_aa);
    __m256i tr_downscaled = _mm256_mulhi_epu16(tr, coeff_bb);
    __m256i bl_downscaled = _mm256_mulhi_epu16(bl, coeff_cc);
    __m256i br_downscaled = _mm256_mulhi_epu16(br, coeff_dd);

    // ILP OPTIMIZATION: Tree-based addition (A+B) + (C+D)
    // Allows the first two additions to execute in parallel on different ports.
    __m256i sum_top = _mm256_add_epi16(tl_downscaled, tr_downscaled);
    __m256i sum_bot = _mm256_add_epi16(bl_downscaled, br_downscaled);
    __m256i result  = _mm256_add_epi16(sum_top, sum_bot);

    return result;
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

        p.Aq = to_q16(p.A);
        p.Bq = to_q16(p.B);
        p.Cq = to_q16(p.C);
        p.Dq = to_q16(p.D);

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

    // Worst case is 240 apertures * 255 = 61200, fits perfectly in uint16_t
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
                
                // Casting to short here silences compiler warnings; the raw bit pattern 
                // is correctly interpreted as unsigned 16-bit by the _epu16 operations.
                const __m256i coeff_aa = _mm256_set1_epi16(static_cast<short>(p.Aq));      
                const __m256i coeff_bb = _mm256_set1_epi16(static_cast<short>(p.Bq));      
                const __m256i coeff_cc = _mm256_set1_epi16(static_cast<short>(p.Cq));      
                const __m256i coeff_dd = _mm256_set1_epi16(static_cast<short>(p.Dq));

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

                    // ILP OPTIMIZATION: 2x Unrolled loop.
                    // Processing 32 bytes concurrently masks the 5-cycle latency of the vector ALUs.
                    for (; x + 32 <= x_stop; x += 32) {
                        // Stream 0: First 16 channel bytes
                        __m128i ltop_b_0 = _mm_loadu_si128(reinterpret_cast<const __m128i*>(p.SUB + ind_ltop));
                        __m128i rtop_b_0 = _mm_loadu_si128(reinterpret_cast<const __m128i*>(p.SUB + ind_rtop));
                        __m128i lbot_b_0 = _mm_loadu_si128(reinterpret_cast<const __m128i*>(p.SUB + ind_lbot));
                        __m128i rbot_b_0 = _mm_loadu_si128(reinterpret_cast<const __m128i*>(p.SUB + ind_rbot));

                        // Stream 1: Next 16 channel bytes (offset by 16)
                        __m128i ltop_b_1 = _mm_loadu_si128(reinterpret_cast<const __m128i*>(p.SUB + ind_ltop + 16));
                        __m128i rtop_b_1 = _mm_loadu_si128(reinterpret_cast<const __m128i*>(p.SUB + ind_rtop + 16));
                        __m128i lbot_b_1 = _mm_loadu_si128(reinterpret_cast<const __m128i*>(p.SUB + ind_lbot + 16));
                        __m128i rbot_b_1 = _mm_loadu_si128(reinterpret_cast<const __m128i*>(p.SUB + ind_rbot + 16));

                        // Execute math pipelines independently
                        __m256i addv_0 = weighted_contrib_16_avx2(ltop_b_0, rtop_b_0, lbot_b_0, rbot_b_0, coeff_aa, coeff_bb, coeff_cc, coeff_dd);
                        __m256i addv_1 = weighted_contrib_16_avx2(ltop_b_1, rtop_b_1, lbot_b_1, rbot_b_1, coeff_aa, coeff_bb, coeff_cc, coeff_dd);

                        // Load Accumulators
                        __m256i acc_0 = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(vp));
                        __m256i acc_1 = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(vp + 16));

                        // Add
                        acc_0 = _mm256_add_epi16(acc_0, addv_0);
                        acc_1 = _mm256_add_epi16(acc_1, addv_1);

                        // Store
                        _mm256_storeu_si256(reinterpret_cast<__m256i*>(vp), acc_0);
                        _mm256_storeu_si256(reinterpret_cast<__m256i*>(vp + 16), acc_1);

                        // Advance by 32
                        vp += 32;
                        ind_ltop += 32;
                        ind_rtop += 32;
                        ind_lbot += 32;
                        ind_rbot += 32;
                    }

                    // 1x Vector Tail: Processes remaining 16-byte chunk if any
                    for (; x + 16 <= x_stop; x += 16) {
                        __m128i ltop_b = _mm_loadu_si128(reinterpret_cast<const __m128i*>(p.SUB + ind_ltop));
                        __m128i rtop_b = _mm_loadu_si128(reinterpret_cast<const __m128i*>(p.SUB + ind_rtop));
                        __m128i lbot_b = _mm_loadu_si128(reinterpret_cast<const __m128i*>(p.SUB + ind_lbot));
                        __m128i rbot_b = _mm_loadu_si128(reinterpret_cast<const __m128i*>(p.SUB + ind_rbot));

                        __m256i addv = weighted_contrib_16_avx2(ltop_b, rtop_b, lbot_b, rbot_b, coeff_aa, coeff_bb, coeff_cc, coeff_dd);

                        __m256i acc = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(vp));
                        acc = _mm256_add_epi16(acc, addv);
                        _mm256_storeu_si256(reinterpret_cast<__m256i*>(vp), acc);

                        vp += 16;
                        ind_ltop += 16;
                        ind_rtop += 16;
                        ind_lbot += 16;
                        ind_rbot += 16;
                    }

                    // Scalar tail mathematically aligned with mulhi behavior
                    const int remaining = x_stop - x;
                    for (int k = 0; k < remaining; ++k) {
                        const int TL = p.SUB[ind_ltop + k];
                        const int TR = p.SUB[ind_rtop + k];
                        const int BL = p.SUB[ind_lbot + k];
                        const int BR = p.SUB[ind_rbot + k];

                        // Explicit parentheses match the truncating behavior of mulhi_epu16
                        const int sum =
                            ((TL * p.Aq) >> Q_BITS) +
                            ((TR * p.Bq) >> Q_BITS) +
                            ((BL * p.Cq) >> Q_BITS) +
                            ((BR * p.Dq) >> Q_BITS);

                        vp[k] = static_cast<std::uint16_t>(
                            vp[k] + static_cast<std::uint16_t>(sum)
                        );
                    }
                }
            }

            // Final Write Output Loop
            for (int y = ty; y < tile_y_end; ++y) {
                const std::uint16_t* vp = tile_vals.data() + (y - ty) * tile_w_actual * 3;
                unsigned char* outp = output.data.data() + (y * width + tx) * 3;

                for (int x = 0; x < tile_w_actual; ++x) {
                    int c = counts[y * width + (tx + x)];

                    if (c == 0) {
                        outp[x * 3]     = 0;
                        outp[x * 3 + 1] = 0;
                        outp[x * 3 + 2] = 0;
                        continue;
                    }

                    for (int ch = 0; ch < 3; ++ch) {
                        // Directly divide accumulated 16-bit pixel values by count
                        int v = (static_cast<int>(vp[x * 3 + ch])) / c;

                        if (v > 255) v = 255;

                        outp[x * 3 + ch] = static_cast<unsigned char>(v);
                    }
                }
            }
        }
    }

    return output;
}