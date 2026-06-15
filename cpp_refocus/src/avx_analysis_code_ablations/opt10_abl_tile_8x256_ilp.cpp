#include "refocus.hpp"
#include "utils.hpp"
#include <vector>
#include <cmath>
#include <algorithm>
#include <immintrin.h>

/*
*   Ablation 3+ILP: Hand-vectorized AVX2 + prefix-sum counts + 8x256 output tile.
*   Tiling confines the output accumulator to 8*256*3*4 = 24 KB per tile,
*   fitting in L1. Loop order: tile_y -> tile_x -> subaperture -> y -> x.
*   ILP x-unrolling: main loop processes 16 floats per iteration with two independent
*   _lo/_hi AVX accumulator pairs to saturate execution units.
* */

namespace {
struct SubParams {
    int sx, sy;
    float A, B, C, D;
    int x_begin, x_end, y_begin, y_end;
    const unsigned char* SUB;
};
}

static inline __m256 load_cvt8(const unsigned char* ptr) {
    return _mm256_cvtepi32_ps(_mm256_cvtepu8_epi32(
        _mm_loadl_epi64(reinterpret_cast<const __m128i*>(ptr))));
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
    const int TILE_W = 256;

    std::vector<float> tile_vals(TILE_H * TILE_W * 3);

    for (int ty = 0; ty < h; ty += TILE_H) {
        const int tile_y_end    = std::min(ty + TILE_H, h);
        const int tile_h_actual = tile_y_end - ty;

        for (int tx = 0; tx < w; tx += TILE_W) {
            const int tile_x_end    = std::min(tx + TILE_W, w);
            const int tile_w_actual = tile_x_end - tx;
            const size_t tile_row_stride = (size_t)tile_w_actual * 3;

            std::fill(tile_vals.begin(),
                      tile_vals.begin() + tile_h_actual * tile_w_actual * 3,
                      0.0f);

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

                const int x_floats = (x_end - x_begin) * 3;

                for (int y = y_begin; y < y_end; ++y) {
                    const size_t rb0 = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
                    const size_t rb1 = rb0 + width * 3;

                    float* vp = tile_vals.data()
                                + (size_t)(y - ty) * tile_row_stride
                                + (size_t)(x_begin - tx) * 3;
                    int xf = 0;

                    for (; xf + 16 <= x_floats; xf += 16) {
                        __m256 ltop_lo = load_cvt8(p.SUB + rb0 + xf);
                        __m256 ltop_hi = load_cvt8(p.SUB + rb0 + xf + 8);
                        __m256 rtop_lo = load_cvt8(p.SUB + rb0 + xf + 3);
                        __m256 rtop_hi = load_cvt8(p.SUB + rb0 + xf + 11);
                        __m256 lbot_lo = load_cvt8(p.SUB + rb1 + xf);
                        __m256 lbot_hi = load_cvt8(p.SUB + rb1 + xf + 8);
                        __m256 rbot_lo = load_cvt8(p.SUB + rb1 + xf + 3);
                        __m256 rbot_hi = load_cvt8(p.SUB + rb1 + xf + 11);
                        __m256 v_lo = _mm256_loadu_ps(vp + xf);
                        __m256 v_hi = _mm256_loadu_ps(vp + xf + 8);
                        v_lo = _mm256_fmadd_ps(Avx, ltop_lo, v_lo);
                        v_hi = _mm256_fmadd_ps(Avx, ltop_hi, v_hi);
                        v_lo = _mm256_fmadd_ps(Bvx, rtop_lo, v_lo);
                        v_hi = _mm256_fmadd_ps(Bvx, rtop_hi, v_hi);
                        v_lo = _mm256_fmadd_ps(Cvx, lbot_lo, v_lo);
                        v_hi = _mm256_fmadd_ps(Cvx, lbot_hi, v_hi);
                        v_lo = _mm256_fmadd_ps(Dvx, rbot_lo, v_lo);
                        v_hi = _mm256_fmadd_ps(Dvx, rbot_hi, v_hi);
                        _mm256_storeu_ps(vp + xf, v_lo);
                        _mm256_storeu_ps(vp + xf + 8, v_hi);
                    }

                    for (; xf + 8 <= x_floats; xf += 8) {
                        __m256 ltop = load_cvt8(p.SUB + rb0 + xf);
                        __m256 rtop = load_cvt8(p.SUB + rb0 + xf + 3);
                        __m256 lbot = load_cvt8(p.SUB + rb1 + xf);
                        __m256 rbot = load_cvt8(p.SUB + rb1 + xf + 3);
                        __m256 v = _mm256_loadu_ps(vp + xf);
                        v = _mm256_fmadd_ps(Avx, ltop, v);
                        v = _mm256_fmadd_ps(Bvx, rtop, v);
                        v = _mm256_fmadd_ps(Cvx, lbot, v);
                        v = _mm256_fmadd_ps(Dvx, rbot, v);
                        _mm256_storeu_ps(vp + xf, v);
                    }

                    for (int k = 0; k < x_floats - xf; ++k) {
                        float TL = p.SUB[rb0 + xf + k];
                        float TR = p.SUB[rb0 + xf + k + 3];
                        float BL = p.SUB[rb1 + xf + k];
                        float BR = p.SUB[rb1 + xf + k + 3];
                        vp[xf + k] += p.A*TL + p.B*TR + p.C*BL + p.D*BR;
                    }
                }
            }

            for (int y = ty; y < tile_y_end; ++y) {
                const float*   vp   = tile_vals.data() + (size_t)(y - ty) * tile_w_actual * 3;
                unsigned char* outp = output.data.data() + (size_t)(y * width + tx) * 3;
                for (int x = 0; x < tile_w_actual; ++x) {
                    int c = counts[y * width + (tx + x)];
                    if (c == 0) continue;
                    float inv_c = 1.0f / (float)c;
                    outp[x*3    ] = (unsigned char)std::clamp(vp[x*3    ] * inv_c + 0.5f, 0.0f, 255.0f);
                    outp[x*3 + 1] = (unsigned char)std::clamp(vp[x*3 + 1] * inv_c + 0.5f, 0.0f, 255.0f);
                    outp[x*3 + 2] = (unsigned char)std::clamp(vp[x*3 + 2] * inv_c + 0.5f, 0.0f, 255.0f);
                }
            }
        }
    }

    return output;
}
