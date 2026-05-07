#include "refocus_stack.hpp"
#include "refocus.hpp"
#include "utils.hpp"

#include <vector>
#include <cmath>
#include <algorithm>
#include <immintrin.h>

/*
*   stack AVX implementation:
*     - prefix-sum counts (from single-focus opt11)
*     - tile-local accumulator fitting in L1 (from single-focus opt11)
*     - AVX2 FMA kernel (from single-focus opt11)
*     - precomputed per(sub, f) parameters
*     - loop order: tile_y, tile_x, f, sub, y, x
*       tile_vals (24 KB) stays in L1 across all subapertures for one focus value. 
*     - fixed normalization: uses round + clamp
*/

namespace {

struct SubParams {
    int sx, sy;
    float A, B, C, D;
    int x_begin, x_end, y_begin, y_end;
    const unsigned char* SUB;
};

constexpr int TILE_H = 8;
constexpr int TILE_W = 256;

}

std::vector<ImageData> refocus_shift_and_sum_stack(
    std::vector<SubApertureImage>& subapertures,
    const std::vector<float>& focuses) {
    const size_t W = subapertures.front().data.width;
    const size_t H = subapertures.front().data.height;
    const size_t NF = focuses.size();
    const int w = static_cast<int>(W);
    const int h = static_cast<int>(H);

    std::vector<std::vector<SubParams>> params(NF);
    for (size_t f = 0; f < NF; ++f) {
        params[f].reserve(subapertures.size());
        for (auto& sub : subapertures) {
            SubParams p;
            float shift_x = focuses[f] * sub.u;
            float shift_y = focuses[f] * sub.v;
            p.sx = static_cast<int>(std::floor(shift_x));
            p.sy = static_cast<int>(std::floor(shift_y));
            float dx = shift_x - p.sx;
            float dy = shift_y - p.sy;
            p.A = (1 - dx) * (1 - dy);
            p.B = dx * (1 - dy);
            p.C = (1 - dx) * dy;
            p.D = dx * dy;
            p.x_begin = std::max(0,-p.sx);
            p.x_end = std::min(w, w - p.sx - 1);
            p.y_begin = std::max(0,-p.sy);
            p.y_end = std::min(h, h - p.sy - 1);
            p.SUB = sub.data.data.data();
            if (p.x_begin >= p.x_end || p.y_begin >= p.y_end) continue;
            params[f].push_back(p);
        }
    }

    std::vector<std::vector<int>> counts(NF, std::vector<int>(W * H, 0));
     {
        std::vector<int> diff((W + 1) * (H + 1));
        for (size_t f = 0; f < NF; ++f) {
            std::fill(diff.begin(), diff.end(), 0);
            for (const auto& p : params[f]) {
                diff[p.y_begin * (W + 1) + p.x_begin] += 1;
                diff[p.y_begin * (W + 1) + p.x_end] -= 1;
                diff[p.y_end * (W + 1) + p.x_begin] -= 1;
                diff[p.y_end * (W + 1) + p.x_end] += 1;
            }
            for (int y = 0; y < h; ++y) {
                int row = 0;
                for (int x = 0; x < w; ++x) {
                    row += diff[y * (W + 1) + x];
                    counts[f][y * w + x] = row + (y > 0 ? counts[f][(y - 1) * w + x] : 0);
                }
            }
        }
    }

    std::vector<ImageData> results(NF);
    for (size_t f = 0; f < NF; ++f) {
        results[f].width  = W;
        results[f].height = H;
        results[f].data.assign(W * H * 3, 0);
    }

    std::vector<float> tile_vals(TILE_H * TILE_W * 3);

    for (int ty = 0; ty < h; ty += TILE_H) {
        const int tile_y_end = std::min(ty + TILE_H, h);
        const int tile_h = tile_y_end - ty;

        for (int tx = 0; tx < w; tx += TILE_W) {
            const int tile_x_end = std::min(tx + TILE_W, w);
            const int tile_w = tile_x_end - tx;

            for (size_t f = 0; f < NF; ++f) {
                const int tile_floats = tile_h * tile_w * 3;
                std::fill(tile_vals.begin(), tile_vals.begin() + tile_floats, 0.0f);
                for (const SubParams& p : params[f]) {
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
                        size_t ind_ltop = ((y + p.sy) * W + (x_begin + p.sx)) * 3;
                        size_t ind_lbot = ind_ltop + W * 3;
                        size_t ind_rtop = ind_ltop + 3;
                        size_t ind_rbot = ind_lbot + 3;

                        float* vp = tile_vals.data()+ (y - ty) * tile_w * 3+ (x_begin - tx) * 3;

                        int x = (x_begin - tx) * 3;
                        const int x_stop = (x_end - tx) * 3;

                        for (; x + 8 <= x_stop; x += 8) {
                            __m128i ltop_b = _mm_loadl_epi64(
                                reinterpret_cast<const __m128i*>(p.SUB + ind_ltop));
                            __m128i lbot_b = _mm_loadl_epi64(
                                reinterpret_cast<const __m128i*>(p.SUB + ind_lbot));
                            __m128i rtop_b = _mm_loadl_epi64(
                                reinterpret_cast<const __m128i*>(p.SUB + ind_rtop));
                            __m128i rbot_b = _mm_loadl_epi64(
                                reinterpret_cast<const __m128i*>(p.SUB + ind_rbot));

                            __m256 ltop_f = _mm256_cvtepi32_ps(
                                _mm256_cvtepu8_epi32(ltop_b));
                            __m256 lbot_f = _mm256_cvtepi32_ps(
                                _mm256_cvtepu8_epi32(lbot_b));
                            __m256 rtop_f = _mm256_cvtepi32_ps(
                                _mm256_cvtepu8_epi32(rtop_b));
                            __m256 rbot_f = _mm256_cvtepi32_ps(
                                _mm256_cvtepu8_epi32(rbot_b));

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

                        const int remaining = x_stop - x;
                        for (int k = 0; k < remaining; ++k) {
                            float TL = p.SUB[ind_ltop + k];
                            float TR = p.SUB[ind_rtop + k];
                            float BL = p.SUB[ind_lbot + k];
                            float BR = p.SUB[ind_rbot + k];
                            vp[k] += p.A * TL + p.B * TR + p.C * BL + p.D * BR;
                        }
                    }
                }

                for (int y = ty; y < tile_y_end; ++y) {
                    const float* vp = tile_vals.data() + (y - ty) * tile_w * 3;
                    unsigned char* outp = results[f].data.data() + (y * W + tx) * 3;
                    for (int x = 0; x < tile_w; ++x) {
                        int c = counts[f][y * w + (tx + x)];
                        if (c == 0) continue;
                        float inv_c = 1.0f / static_cast<float>(c);
                        outp[x * 3]     = static_cast<unsigned char>(std::clamp(std::round(vp[x * 3]     * inv_c), 0.0f, 255.0f));
                        outp[x * 3 + 1] = static_cast<unsigned char>(std::clamp(std::round(vp[x * 3 + 1] * inv_c), 0.0f, 255.0f));
                        outp[x * 3 + 2] = static_cast<unsigned char>(std::clamp(std::round(vp[x * 3 + 2] * inv_c), 0.0f, 255.0f));
                    }
                }
            }
        }
    }
    return results;
}