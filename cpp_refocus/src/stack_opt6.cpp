#include "refocus_stack.hpp"
#include "refocus.hpp"
#include "utils.hpp"
#include <vector>
#include <cmath>
#include <algorithm>
#include <immintrin.h>

namespace {

struct SubParams {
    int sx, sy;
    float A, B, C, D;
    int x_begin, x_end, y_begin, y_end;
    const unsigned char* SUB;
};

constexpr int TILE_H = 8;
constexpr int TILE_W = 256;

inline __m256 load_cvt(const unsigned char* ptr) {
    return _mm256_cvtepi32_ps(_mm256_cvtepu8_epi32(
        _mm_loadl_epi64(reinterpret_cast<const __m128i*>(ptr))));
}

inline void fma4_split(__m256& val, __m256 A, __m256 ltop, __m256 B, __m256 rtop, __m256 C, __m256 lbot, __m256 D, __m256 rbot) {
    __m256 ab = _mm256_fmadd_ps(A, ltop, _mm256_mul_ps(B, rtop));
    __m256 cd = _mm256_fmadd_ps(C, lbot, _mm256_mul_ps(D, rbot));
    val = _mm256_add_ps(val, _mm256_add_ps(ab, cd));
}

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
            p.x_begin = std::max(0, -p.sx);
            p.x_end = std::min(w, w - p.sx - 1);
            p.y_begin = std::max(0, -p.sy);
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
        results[f].width = W;
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
                    const int y_end = std::min(tile_y_end, p.y_end);
                    const int x_begin = std::max(tx, p.x_begin);
                    const int x_end = std::min(tile_x_end, p.x_end);
                    if (x_begin >= x_end || y_begin >= y_end) continue;

                    const __m256 Avx = _mm256_set1_ps(p.A);
                    const __m256 Bvx = _mm256_set1_ps(p.B);
                    const __m256 Cvx = _mm256_set1_ps(p.C);
                    const __m256 Dvx = _mm256_set1_ps(p.D);

                    const int x_chan_begin = (x_begin - tx) * 3;
                    const int x_chan_stop = (x_end - tx) * 3;
                    const size_t row_stride = W * 3;

                    int y = y_begin;
                    for (; y + 1 < y_end; y += 2) {
                        size_t r0_base = ((y + p.sy) * W + (x_begin + p.sx)) * 3;
                        size_t r1_base = r0_base + row_stride;
                        size_t r2_base = r1_base + row_stride;

                        float* vp0 = tile_vals.data() + (y - ty) * tile_w * 3 + x_chan_begin;
                        float* vp1 = vp0 + tile_w * 3;
                        int x = x_chan_begin;

                        for (; x + 8 <= x_chan_stop; x += 8) {
                            __m256 row0l = load_cvt(p.SUB + r0_base);
                            __m256 row1l = load_cvt(p.SUB + r1_base);
                            __m256 row2l = load_cvt(p.SUB + r2_base);
                            __m256 row0r = load_cvt(p.SUB + r0_base + 3);
                            __m256 row1r = load_cvt(p.SUB + r1_base + 3);
                            __m256 row2r = load_cvt(p.SUB + r2_base + 3);
                            __m256 v0 = _mm256_loadu_ps(vp0);
                            __m256 v1 = _mm256_loadu_ps(vp1);

                            fma4_split(v0, Avx, row0l, Bvx, row0r, Cvx, row1l, Dvx, row1r);
                            fma4_split(v1, Avx, row1l, Bvx, row1r, Cvx, row2l, Dvx, row2r);

                            _mm256_storeu_ps(vp0, v0);
                            _mm256_storeu_ps(vp1, v1);

                            vp0 += 8; vp1 += 8;
                            r0_base += 8; r1_base += 8; r2_base += 8;
                        }

                        for (; x < x_chan_stop; ++x) {
                            float r0l = p.SUB[r0_base];
                            float r1l = p.SUB[r1_base];
                            float r2l = p.SUB[r2_base];
                            float r0r = p.SUB[r0_base + 3];
                            float r1r = p.SUB[r1_base + 3];
                            float r2r = p.SUB[r2_base + 3];
                            *vp0 += p.A * r0l + p.B * r0r + p.C * r1l + p.D * r1r;
                            *vp1 += p.A * r1l + p.B * r1r + p.C * r2l + p.D * r2r;
                            ++vp0; ++vp1;
                            ++r0_base; ++r1_base; ++r2_base;
                        }
                    }

                    if (y < y_end) {
                        size_t ind_ltop = ((y + p.sy) * W + (x_begin + p.sx)) * 3;
                        size_t ind_lbot = ind_ltop + row_stride;
                        size_t ind_rtop = ind_ltop + 3;
                        size_t ind_rbot = ind_lbot + 3;

                        float* vp = tile_vals.data() + (y - ty) * tile_w * 3 + x_chan_begin;
                        int x = x_chan_begin;

                        for (; x + 8 <= x_chan_stop; x += 8) {
                            __m256 ltop_f = load_cvt(p.SUB + ind_ltop);
                            __m256 lbot_f = load_cvt(p.SUB + ind_lbot);
                            __m256 rtop_f = load_cvt(p.SUB + ind_rtop);
                            __m256 rbot_f = load_cvt(p.SUB + ind_rbot);
                            __m256 val = _mm256_loadu_ps(vp);
                            fma4_split(val, Avx, ltop_f, Bvx, rtop_f, Cvx, lbot_f, Dvx, rbot_f);
                            _mm256_storeu_ps(vp, val);
                            vp += 8;
                            ind_ltop += 8; ind_lbot += 8;
                            ind_rtop += 8; ind_rbot += 8;
                        }

                        for (; x < x_chan_stop; ++x) {
                            float TL = p.SUB[ind_ltop];
                            float TR = p.SUB[ind_rtop];
                            float BL = p.SUB[ind_lbot];
                            float BR = p.SUB[ind_rbot];
                            *vp += p.A * TL + p.B * TR + p.C * BL + p.D * BR;
                            ++vp;
                            ++ind_ltop; ++ind_lbot; ++ind_rtop; ++ind_rbot;
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
                        outp[x * 3] = static_cast<unsigned char>(std::clamp(std::round(vp[x * 3] * inv_c), 0.0f, 255.0f));
                        outp[x * 3 + 1] = static_cast<unsigned char>(std::clamp(std::round(vp[x * 3 + 1] * inv_c), 0.0f, 255.0f));
                        outp[x * 3 + 2] = static_cast<unsigned char>(std::clamp(std::round(vp[x * 3 + 2] * inv_c), 0.0f, 255.0f));
                    }
                }
            }
        }
    }
    return results;
}