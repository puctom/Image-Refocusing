#include "refocus_stack.hpp"
#include "refocus.hpp"
#include "utils.hpp"
#include <vector>
#include <cmath>
#include <algorithm>
#include <immintrin.h>

/*
*   List of Optimizations:
*       - all from single focus value up to opt8:
    *       - Change the loop order to [Subaperture, f, y, x] for improved locality
    *       - Common subexpression elimination
    *       - use better bounds for the x-y loops
    *       - use unchecked array access
    *       - function inlining
    *       - unroll channel loop to expose independent scalar ops for ILP
    *       - reduce number of loads in innermost loop
    *       - 2x2 output block unrolling (from opt8)
*           - precompute
*           - AVX + vector ILP unrolling + y - unroll
* */

namespace {

struct SubParams {
    int sx, sy;
    float A, B, C, D;
    int x_begin, x_end, y_begin, y_end;
    const unsigned char* __restrict SUB;
};

constexpr int TILE_H = 8;
constexpr int TILE_W = 256;

static inline __m256 load_cvt8(const unsigned char* ptr) {
    return _mm256_cvtepi32_ps(
        _mm256_cvtepu8_epi32(
            _mm_loadl_epi64(reinterpret_cast<const __m128i*>(ptr))));
}

}

std::vector<ImageData> refocus_shift_and_sum_stack(
    std::vector<SubApertureImage>& subapertures,
    const std::vector<float>& focuses)
{
    const size_t W  = subapertures.front().data.width;
    const size_t H  = subapertures.front().data.height;
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

            p.A = (1.0f - dx) * (1.0f - dy);
            p.B = dx * (1.0f - dy);
            p.C = (1.0f - dx) * dy;
            p.D = dx * dy;

            p.x_begin = std::max(0, -p.sx);
            p.x_end = std::min(w, w - p.sx - 1);
            p.y_begin = std::max(0, -p.sy);
            p.y_end = std::min(h, h - p.sy - 1);
            p.SUB = sub.data.data.data();

            if (p.x_begin >= p.x_end || p.y_begin >= p.y_end)
                continue;

            params[f].push_back(p);
        }
    }

    // flattened counts
    std::vector<int> counts(NF * W * H, 0);

    {
        std::vector<int> diff((W + 1) * (H + 1));
        for (size_t f = 0; f < NF; ++f) {
            std::fill(diff.begin(), diff.end(), 0);
            for (const auto& p : params[f]) {
                diff[p.y_begin * (W + 1) + p.x_begin] += 1;
                diff[p.y_begin * (W + 1) + p.x_end  ] -= 1;
                diff[p.y_end * (W + 1) + p.x_begin] -= 1;
                diff[p.y_end * (W + 1) + p.x_end  ] += 1;
            }
            int* count_base = counts.data() + f * W * H;
            for (int y = 0; y < h; ++y) {
                int row = 0;
                for (int x = 0; x < w; ++x) {
                    row += diff[y * (W + 1) + x];
                    count_base[y * w + x] =
                        row + (y > 0 ? count_base[(y - 1) * w + x] : 0);
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

    std::vector<float> tile_vals(
        NF * TILE_H * TILE_W * 3);

    for (int ty = 0; ty < h; ty += TILE_H) {
        const int tile_y_end = std::min(ty + TILE_H, h);
        const int tile_h = tile_y_end - ty;

        for (int tx = 0; tx < w; tx += TILE_W) {
            const int tile_x_end = std::min(tx + TILE_W, w);
            const int tile_w = tile_x_end - tx;

            const int tile_floats = tile_h * tile_w * 3;
            std::fill(tile_vals.begin(), tile_vals.begin() + NF * tile_floats, 0.0f);

            for (size_t f = 0; f < NF; ++f) {

                float* tile_base = tile_vals.data() + f * tile_floats;

                for (const SubParams& p : params[f]) {
                    const int y_begin = std::max(ty, p.y_begin);
                    const int y_end = std::min(tile_y_end, p.y_end);
                    const int x_begin = std::max(tx, p.x_begin);
                    const int x_end = std::min(tile_x_end, p.x_end);

                    if (x_begin >= x_end || y_begin >= y_end)
                        continue;

                    const __m256 Avx = _mm256_set1_ps(p.A);
                    const __m256 Bvx = _mm256_set1_ps(p.B);
                    const __m256 Cvx = _mm256_set1_ps(p.C);
                    const __m256 Dvx = _mm256_set1_ps(p.D);

                    const int x_chan_begin = (x_begin - tx) * 3;
                    const int x_chan_stop  = (x_end - tx) * 3;
                    const size_t row_stride = W * 3;

                    int y = y_begin;
                    for (; y + 1 < y_end; y += 2) {

                        size_t r0_base =
                            ((y + p.sy) * W + (x_begin + p.sx)) * 3;

                        size_t r1_base = r0_base + row_stride;
                        size_t r2_base = r1_base + row_stride;

                        float* __restrict vp0 = tile_base + (y - ty) * tile_w * 3 + x_chan_begin;

                        float* __restrict vp1 = vp0 + tile_w * 3;

                        int x = x_chan_begin;

                        for (; x + 16 <= x_chan_stop; x += 16) {
                            __m256 r0l_lo = load_cvt8(p.SUB + r0_base);
                            __m256 r0l_hi = load_cvt8(p.SUB + r0_base + 8);
                            __m256 r0r_lo = load_cvt8(p.SUB + r0_base + 3);
                            __m256 r0r_hi = load_cvt8(p.SUB + r0_base + 11);

                            __m256 r1l_lo = load_cvt8(p.SUB + r1_base);
                            __m256 r1l_hi = load_cvt8(p.SUB + r1_base + 8);
                            __m256 r1r_lo = load_cvt8(p.SUB + r1_base + 3);
                            __m256 r1r_hi = load_cvt8(p.SUB + r1_base + 11);

                            __m256 v0_lo = _mm256_loadu_ps(vp0);
                            __m256 v0_hi = _mm256_loadu_ps(vp0 + 8);
                            v0_lo = _mm256_fmadd_ps(Avx, r0l_lo, v0_lo);
                            v0_hi = _mm256_fmadd_ps(Avx, r0l_hi, v0_hi);
                            v0_lo = _mm256_fmadd_ps(Bvx, r0r_lo, v0_lo);
                            v0_hi = _mm256_fmadd_ps(Bvx, r0r_hi, v0_hi);
                            v0_lo = _mm256_fmadd_ps(Cvx, r1l_lo, v0_lo);
                            v0_hi = _mm256_fmadd_ps(Cvx, r1l_hi, v0_hi);
                            v0_lo = _mm256_fmadd_ps(Dvx, r1r_lo, v0_lo);
                            v0_hi = _mm256_fmadd_ps(Dvx, r1r_hi, v0_hi);
                            _mm256_storeu_ps(vp0, v0_lo);
                            _mm256_storeu_ps(vp0 + 8, v0_hi);

                            __m256 r2l_lo = load_cvt8(p.SUB + r2_base);
                            __m256 r2l_hi = load_cvt8(p.SUB + r2_base + 8);
                            __m256 r2r_lo = load_cvt8(p.SUB + r2_base + 3);
                            __m256 r2r_hi = load_cvt8(p.SUB + r2_base + 11);

                            __m256 v1_lo = _mm256_loadu_ps(vp1);
                            __m256 v1_hi = _mm256_loadu_ps(vp1 + 8);
                            v1_lo = _mm256_fmadd_ps(Avx, r1l_lo, v1_lo);
                            v1_hi = _mm256_fmadd_ps(Avx, r1l_hi, v1_hi);
                            v1_lo = _mm256_fmadd_ps(Bvx, r1r_lo, v1_lo);
                            v1_hi = _mm256_fmadd_ps(Bvx, r1r_hi, v1_hi);
                            v1_lo = _mm256_fmadd_ps(Cvx, r2l_lo, v1_lo);
                            v1_hi = _mm256_fmadd_ps(Cvx, r2l_hi, v1_hi);
                            v1_lo = _mm256_fmadd_ps(Dvx, r2r_lo, v1_lo);
                            v1_hi = _mm256_fmadd_ps(Dvx, r2r_hi, v1_hi);

                            _mm256_storeu_ps(vp1, v1_lo);
                            _mm256_storeu_ps(vp1 + 8, v1_hi);

                            vp0 += 16;
                            vp1 += 16;

                            r0_base += 16;
                            r1_base += 16;
                            r2_base += 16;
                        }

                        for (; x < x_chan_stop; ++x) {

                            float r0l = p.SUB[r0_base];
                            float r1l = p.SUB[r1_base];
                            float r2l = p.SUB[r2_base];

                            float r0r = p.SUB[r0_base + 3];
                            float r1r = p.SUB[r1_base + 3];
                            float r2r = p.SUB[r2_base + 3];

                            *vp0 +=
                                p.A * r0l +
                                p.B * r0r +
                                p.C * r1l +
                                p.D * r1r;

                            *vp1 +=
                                p.A * r1l +
                                p.B * r1r +
                                p.C * r2l +
                                p.D * r2r;

                            ++vp0;
                            ++vp1;

                            ++r0_base;
                            ++r1_base;
                            ++r2_base;
                        }
                    }
                }
            }

            for (size_t f = 0; f < NF; ++f) {

                const float* tile_base = tile_vals.data() + f * tile_floats;

                const int* count_base = counts.data() + f * W * H;

                for (int y = ty; y < tile_y_end; ++y) {
                    const float* vp =tile_base +(y - ty) * tile_w * 3;

                    unsigned char* outp = results[f].data.data() + (y * W + tx) * 3;
                    for (int x = 0; x < tile_w; ++x) {
                        int c = count_base[y * w + (tx + x)];
                        if (c == 0)
                            continue;
                        float inv_c = 1.0f / static_cast<float>(c);
                        outp[x * 3] = static_cast<unsigned char>(std::clamp(std::round(vp[x * 3] * inv_c), 0.0f, 255.0f));  
                        outp[x * 3 + 1] = static_cast<unsigned char>(std::clamp(std::round(vp[x * 3 + 1] * inv_c), 0.0f, 255.0f));
                        outp[x * 3 + 2] = static_cast<unsigned char>( std::clamp(std::round(vp[x * 3 + 2] * inv_c),0.0f, 255.0f));
                    }
                }
            }
        }
    }
    return results;
}