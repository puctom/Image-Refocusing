#include "refocus.hpp"
#include "utils.hpp"
#include <vector>
#include <cmath>
#include <algorithm>
#include <immintrin.h>

/*
*   Ablation: identical to opt11.cpp but with TILE_W=2032 instead of 256.
*   Shows the effect of a wider tile that fits the full width of common images in one pass.
*
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
    int x_begin, x_end, y_begin, y_end;
    const unsigned char* SUB;
};
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
        p.x_begin = std::max(0, -p.sx);
        p.x_end   = std::min(w, w - p.sx - 1);
        p.y_begin = std::max(0, -p.sy);
        p.y_end   = std::min(h, h - p.sy - 1);
        p.SUB = sub.data.data.data();
        if (p.x_begin >= p.x_end || p.y_begin >= p.y_end) continue;  // skip degenerate
        params.push_back(p);
    }

    // Precalculate counts
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

    // vals_tile = TILE_H * TILE_W * 3 * 4 B
    // TODO: play around with these values, the tile should fit in L1
    const int TILE_H = 8;
    const int TILE_W = 2032;

    // Per-tile vals accumulator
    std::vector<float> tile_vals(TILE_H * TILE_W * 3);

    for (int ty = 0; ty < h; ty += TILE_H) {
        const int tile_y_end = std::min(ty + TILE_H, h);
        const int tile_h_actual = tile_y_end - ty;

        for (int tx = 0; tx < w; tx += TILE_W) {
            const int tile_x_end = std::min(tx + TILE_W, w);
            const int tile_w_actual = tile_x_end - tx;

            // Zero the tile accumulator
            std::fill(tile_vals.begin(),
                      tile_vals.begin() + tile_h_actual * tile_w_actual * 3,
                      0.0f);

            // Subaperture inner loop over this tile
            for (const SubParams& p : params) {
                const int y_begin = std::max(ty, p.y_begin);
                const int y_end   = std::min(tile_y_end, p.y_end);
                const int x_begin = std::max(tx, p.x_begin);
                const int x_end   = std::min(tile_x_end, p.x_end);
                if (x_begin >= x_end || y_begin >= y_end) continue;

                const __m256 Avx = _mm256_set1_ps(p.A);
                const __m256 Bvx = _mm256_set1_ps(p.B);
                const __m256 Cvx = _mm256_set1_ps(p.C);
                const __m256 Dvx = _mm256_set1_ps(p.D);

                for (int y = y_begin; y < y_end; ++y) {
                    size_t ind_ltop = ((y + p.sy) * width + (x_begin + p.sx)) * 3;
                    size_t ind_lbot = ind_ltop + width * 3;
                    size_t ind_rtop = ind_ltop + 3;
                    size_t ind_rbot = ind_lbot + 3;

                    // tile_vals row pointer for output row y, starting at column x_begin
                    float* vp = tile_vals.data()
                                + (y - ty) * tile_w_actual * 3
                                + (x_begin - tx) * 3;

                    int x = (x_begin - tx) * 3;
                    const int x_stop = (x_end - tx) * 3;

                    // Main loop
                    for (; x + 8 <= x_stop; x += 8) {
                        __m128i ltop_b = _mm_loadl_epi64(reinterpret_cast<const __m128i*>(p.SUB + ind_ltop));
                        __m128i lbot_b = _mm_loadl_epi64(reinterpret_cast<const __m128i*>(p.SUB + ind_lbot));
                        __m128i rtop_b = _mm_loadl_epi64(reinterpret_cast<const __m128i*>(p.SUB + ind_rtop));
                        __m128i rbot_b = _mm_loadl_epi64(reinterpret_cast<const __m128i*>(p.SUB + ind_rbot));

                        __m256 ltop_f = _mm256_cvtepi32_ps(_mm256_cvtepu8_epi32(ltop_b));
                        __m256 lbot_f = _mm256_cvtepi32_ps(_mm256_cvtepu8_epi32(lbot_b));
                        __m256 rtop_f = _mm256_cvtepi32_ps(_mm256_cvtepu8_epi32(rtop_b));
                        __m256 rbot_f = _mm256_cvtepi32_ps(_mm256_cvtepu8_epi32(rbot_b));

                        __m256 val = _mm256_loadu_ps(vp);
                        val = _mm256_fmadd_ps(Avx, ltop_f, val);
                        val = _mm256_fmadd_ps(Bvx, rtop_f, val);
                        val = _mm256_fmadd_ps(Cvx, lbot_f, val);
                        val = _mm256_fmadd_ps(Dvx, rbot_f, val);
                        _mm256_storeu_ps(vp, val);

                        vp += 8;
                        ind_ltop += 8; ind_lbot += 8;
                        ind_rtop += 8; ind_rbot += 8;
                    }

                    // Handle tail
                    int remaining = x_stop - x;
                    for (int k = 0; k < remaining; ++k) {
                        float TL = p.SUB[ind_ltop + k];
                        float TR = p.SUB[ind_rtop + k];
                        float BL = p.SUB[ind_lbot + k];
                        float BR = p.SUB[ind_rbot + k];
                        vp[k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
                    }
                }
            }

            // Tile complete: write to output
            for (int y = ty; y < tile_y_end; ++y) {
                const float* vp = tile_vals.data() + (y - ty) * tile_w_actual * 3;
                unsigned char* outp = output.data.data() + (y * width + tx) * 3;
                for (int x = 0; x < tile_w_actual; ++x) {
                    int c = counts[y * width + (tx + x)];
                    if (c == 0) {
                        outp[x*3] = outp[x*3+1] = outp[x*3+2] = 0;
                        continue;
                    }
                    float inv_c = 1.0f / static_cast<float>(c);
                    for (int ch = 0; ch < 3; ++ch) {
                        float v = vp[x*3 + ch] * inv_c;
                        outp[x*3 + ch] = static_cast<unsigned char>(v);
                    }
                }
            }
        }
    }

    return output;
}
