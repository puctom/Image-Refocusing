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
*       - use AVX-512 float32 FMA with unaligned loads
*       - use block tiles for better cache performance
*       - calculate counts using prefix sum technique
*       - 2-row y unroll (shared middle row)
*       - AVX-512
* */

namespace {
struct SubParams {
    int sx, sy;
    float A, B, C, D;
    int x_begin, x_end, y_begin, y_end;
    const unsigned char* SUB;
};
}

static inline __m512 load_cvt16(const unsigned char* ptr) {
    return _mm512_cvtepi32_ps(_mm512_cvtepu8_epi32(
        _mm_loadu_si128(reinterpret_cast<const __m128i*>(ptr))));
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
        p.B = dx * (1 - dy);
        p.C = (1 - dx) * dy;
        p.D = dx * dy;
        p.x_begin = std::max(0, -p.sx);
        p.x_end   = std::min(w, w - p.sx - 1);
        p.y_begin = std::max(0, -p.sy);
        p.y_end   = std::min(h, h - p.sy - 1);
        p.SUB = sub.data.data.data();
        if (p.x_begin >= p.x_end || p.y_begin >= p.y_end) continue;
        params.push_back(p);
    }

    std::vector<int> counts(width * height, 0);
    std::vector<int> diff((width + 1) * (height + 1), 0);

    for (const auto& p : params) {
        diff[p.y_begin * (width + 1) + p.x_begin] += 1;
        diff[p.y_begin * (width + 1) + p.x_end] -= 1;
        diff[p.y_end * (width + 1) + p.x_begin] -= 1;
        diff[p.y_end * (width + 1) + p.x_end] += 1;
    }

    for (int y = 0; y < h; ++y) {
        int row = 0;
        for (int x = 0; x < w; ++x) {
            row += diff[y * (width + 1) + x];
            counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
        }
    }

    const int TILE_H = 6;
    const int TILE_W = 2032;

    std::vector<float> tile_vals(TILE_H * TILE_W * 3);

    for (int ty = 0; ty < h; ty += TILE_H) {
        const int tile_y_end = std::min(ty + TILE_H, h);
        const int tile_h_actual = tile_y_end - ty;

        for (int tx = 0; tx < w; tx += TILE_W) {
            const int tile_x_end = std::min(tx + TILE_W, w);
            const int tile_w_actual = tile_x_end - tx;

            std::fill(tile_vals.begin(), tile_vals.begin() + tile_h_actual * tile_w_actual * 3, 0.0f);

            for (const SubParams& p : params) {
                const int y_begin = std::max(ty, p.y_begin);
                const int y_end = std::min(tile_y_end, p.y_end);
                const int x_begin = std::max(tx, p.x_begin);
                const int x_end = std::min(tile_x_end, p.x_end);
                if (x_begin >= x_end || y_begin >= y_end) continue;

                const __m512 Avx = _mm512_set1_ps(p.A);
                const __m512 Bvx = _mm512_set1_ps(p.B);
                const __m512 Cvx = _mm512_set1_ps(p.C);
                const __m512 Dvx = _mm512_set1_ps(p.D);

                int y = y_begin;

                // 2-row y-unroll
                for (; y + 1 < y_end; y += 2) {
                    size_t ind_ltop = ((y + p.sy) * width + (x_begin + p.sx)) * 3;
                    size_t ind_lbot = ind_ltop + width * 3;
                    size_t ind_rtop = ind_ltop + 3;
                    size_t ind_rbot = ind_lbot + 3;

                    float* vp0 = tile_vals.data()
                                + (y - ty) * tile_w_actual * 3
                                + (x_begin - tx) * 3;

                    float* vp1 = vp0 + tile_w_actual * 3;

                    int x = (x_begin - tx) * 3;
                    const int x_stop = (x_end - tx) * 3;
                    for (; x + 16 <= x_stop; x += 16) {
                        __m512 r0l = load_cvt16(p.SUB + ind_ltop);
                        __m512 r0r = load_cvt16(p.SUB + ind_rtop);
                        __m512 r1l = load_cvt16(p.SUB + ind_lbot);
                        __m512 r1r = load_cvt16(p.SUB + ind_rbot);
                        __m512 v0 = _mm512_loadu_ps(vp0);

                        v0 = _mm512_fmadd_ps(Avx, r0l, v0);
                        v0 = _mm512_fmadd_ps(Bvx, r0r, v0);
                        v0 = _mm512_fmadd_ps(Cvx, r1l, v0);
                        v0 = _mm512_fmadd_ps(Dvx, r1r, v0);

                        _mm512_storeu_ps(vp0, v0);

                        __m512 r2l = load_cvt16(p.SUB + ind_lbot + width * 3);
                        __m512 r2r = load_cvt16(p.SUB + ind_rbot + width * 3);
                        __m512 v1 = _mm512_loadu_ps(vp1);

                        v1 = _mm512_fmadd_ps(Avx, r1l, v1);
                        v1 = _mm512_fmadd_ps(Bvx, r1r, v1);
                        v1 = _mm512_fmadd_ps(Cvx, r2l, v1);
                        v1 = _mm512_fmadd_ps(Dvx, r2r, v1);

                        _mm512_storeu_ps(vp1, v1);

                        vp0 += 16;
                        vp1 += 16;

                        ind_ltop += 16;
                        ind_lbot += 16;
                        ind_rtop += 16;
                        ind_rbot += 16;
                    }

                    int remaining = x_stop - x;
                    for (int k = 0; k < remaining; ++k) {
                        float r0l = p.SUB[ind_ltop + k];
                        float r0r = p.SUB[ind_rtop + k];

                        float r1l = p.SUB[ind_lbot + k];
                        float r1r = p.SUB[ind_rbot + k];

                        float r2l = p.SUB[ind_lbot + width * 3 + k];
                        float r2r = p.SUB[ind_rbot + width * 3 + k];

                        vp0[k] += p.A * r0l + p.B * r0r + p.C * r1l + p.D * r1r;
                        vp1[k] += p.A * r1l + p.B * r1r + p.C * r2l + p.D * r2r;
                    }
                }

                if (y < y_end) {
                    size_t ind_ltop = ((y + p.sy) * width + (x_begin + p.sx)) * 3;
                    size_t ind_lbot = ind_ltop + width * 3;
                    size_t ind_rtop = ind_ltop + 3;
                    size_t ind_rbot = ind_lbot + 3;

                    float* vp = tile_vals.data() + (y - ty) * tile_w_actual * 3 + (x_begin - tx) * 3;

                    int x = (x_begin - tx) * 3;
                    const int x_stop = (x_end - tx) * 3;

                    for (; x + 16 <= x_stop; x += 16) {
                        __m512 ltop_f = load_cvt16(p.SUB + ind_ltop);
                        __m512 lbot_f = load_cvt16(p.SUB + ind_lbot);
                        __m512 rtop_f = load_cvt16(p.SUB + ind_rtop);
                        __m512 rbot_f = load_cvt16(p.SUB + ind_rbot);

                        __m512 val = _mm512_loadu_ps(vp);

                        val = _mm512_fmadd_ps(Avx, ltop_f, val);
                        val = _mm512_fmadd_ps(Bvx, rtop_f, val);
                        val = _mm512_fmadd_ps(Cvx, lbot_f, val);
                        val = _mm512_fmadd_ps(Dvx, rbot_f, val);

                        _mm512_storeu_ps(vp, val);

                        vp += 16;

                        ind_ltop += 16;
                        ind_lbot += 16;
                        ind_rtop += 16;
                        ind_rbot += 16;
                    }

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

            for (int y = ty; y < tile_y_end; ++y) {
                const float* vp = tile_vals.data() + (y - ty) * tile_w_actual * 3;
                unsigned char* outp = output.data.data() + (y * width + tx) * 3;
                for (int x = 0; x < tile_w_actual; ++x) {
                    int c = counts[y * width + (tx + x)];
                    if (c == 0) {
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