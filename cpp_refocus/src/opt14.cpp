#include "refocus.hpp"
#include "utils.hpp"

#include <vector>
#include <cmath>
#include <algorithm>
#include <immintrin.h>

/*
* AVX-512 version of opt13 with vertical load reuse and SIMD normalization
*/

namespace {

struct SubParams {
    int sx, sy;
    float A, B, C, D;
    int x_begin, x_end, y_begin, y_end;
    const unsigned char* SUB;
};

static inline __m512 load_cvt16(const unsigned char* ptr) {
    __m128i bytes = _mm_loadu_si128(reinterpret_cast<const __m128i*>(ptr));
    __m512i ints = _mm512_cvtepu8_epi32(bytes);
    return _mm512_cvtepi32_ps(ints);
}

static inline __m512 load_cvt16_masked(
    const unsigned char* ptr,
    __mmask16 mask
) {
    __m128i bytes = _mm_maskz_loadu_epi8(mask, ptr);
    __m512i ints = _mm512_cvtepu8_epi32(bytes);
    return _mm512_cvtepi32_ps(ints);
}

}

ImageData refocus_shift_and_sum(
    std::vector<SubApertureImage>& subapertures,
    float focus
) {
    const size_t width  = subapertures.front().data.width;
    const size_t height = subapertures.front().data.height;

    const int w = static_cast<int>(width);
    const int h = static_cast<int>(height);

    ImageData output;
    output.width  = width;
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

    constexpr int TILE_H = 6;
    constexpr int TILE_W = 2032;

    std::vector<float> tile_vals(TILE_H * TILE_W * 3);
    
    std::vector<__m512> cache_L((TILE_W * 3) / 16 + 2);
    std::vector<__m512> cache_R((TILE_W * 3) / 16 + 2);

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

                if (x_begin >= x_end || y_begin >= y_end)
                    continue;

                const __m512 Avx = _mm512_set1_ps(p.A);
                const __m512 Bvx = _mm512_set1_ps(p.B);
                const __m512 Cvx = _mm512_set1_ps(p.C);
                const __m512 Dvx = _mm512_set1_ps(p.D);

                for (int y = y_begin; y < y_end; ++y) {
                    size_t ind_ltop = ((y + p.sy) * width + (x_begin + p.sx)) * 3;
                    size_t ind_lbot = ind_ltop + width * 3;
                    size_t ind_rtop = ind_ltop + 3;
                    size_t ind_rbot = ind_lbot + 3;

                    float* vp = tile_vals.data() + (y - ty) * tile_w_actual * 3 + (x_begin - tx) * 3;
                    int x = (x_begin - tx) * 3;
                    const int x_stop = (x_end - tx) * 3;
                    int c_idx = 0;

                    for (; x + 32 <= x_stop; x += 32) {
                        __m512 TL0, TR0, TL1, TR1;
                            if (y > y_begin) {
                            TL0 = cache_L[c_idx];
                            TR0 = cache_R[c_idx];
                            TL1 = cache_L[c_idx + 1];
                            TR1 = cache_R[c_idx + 1];
                        } else {
                            TL0 = load_cvt16(p.SUB + ind_ltop);
                            TR0 = load_cvt16(p.SUB + ind_rtop);
                            TL1 = load_cvt16(p.SUB + ind_ltop + 16);
                            TR1 = load_cvt16(p.SUB + ind_rtop + 16);
                        }

                        __m512 BL0 = load_cvt16(p.SUB + ind_lbot);
                        __m512 BR0 = load_cvt16(p.SUB + ind_rbot);
                        __m512 BL1 = load_cvt16(p.SUB + ind_lbot + 16);
                        __m512 BR1 = load_cvt16(p.SUB + ind_rbot + 16);

                        cache_L[c_idx] = BL0; cache_R[c_idx] = BR0;
                        cache_L[c_idx + 1] = BL1; cache_R[c_idx + 1] = BR1;

                        __m512 V0 = _mm512_loadu_ps(vp);
                        V0 = _mm512_fmadd_ps(Avx, TL0, V0);
                        V0 = _mm512_fmadd_ps(Bvx, TR0, V0);
                        V0 = _mm512_fmadd_ps(Cvx, BL0, V0);
                        V0 = _mm512_fmadd_ps(Dvx, BR0, V0);
                        _mm512_storeu_ps(vp, V0);

                        __m512 V1 = _mm512_loadu_ps(vp + 16);
                        V1 = _mm512_fmadd_ps(Avx, TL1, V1);
                        V1 = _mm512_fmadd_ps(Bvx, TR1, V1);
                        V1 = _mm512_fmadd_ps(Cvx, BL1, V1);
                        V1 = _mm512_fmadd_ps(Dvx, BR1, V1);
                        _mm512_storeu_ps(vp + 16, V1);

                        vp += 32; ind_ltop += 32; ind_lbot += 32; ind_rtop += 32; ind_rbot += 32;
                        c_idx += 2;
                    }

                    for (; x + 16 <= x_stop; x += 16) {
                        __m512 TL, TR;
                        if (y > y_begin) {
                            TL = cache_L[c_idx]; TR = cache_R[c_idx];
                        } else {
                            TL = load_cvt16(p.SUB + ind_ltop); TR = load_cvt16(p.SUB + ind_rtop);
                        }
                        __m512 BL = load_cvt16(p.SUB + ind_lbot);
                        __m512 BR = load_cvt16(p.SUB + ind_rbot);

                        cache_L[c_idx] = BL; cache_R[c_idx] = BR;

                        __m512 V = _mm512_loadu_ps(vp);
                        V = _mm512_fmadd_ps(Avx, TL, V);
                        V = _mm512_fmadd_ps(Bvx, TR, V);
                        V = _mm512_fmadd_ps(Cvx, BL, V);
                        V = _mm512_fmadd_ps(Dvx, BR, V);
                        _mm512_storeu_ps(vp, V);

                        vp += 16; ind_ltop += 16; ind_lbot += 16; ind_rtop += 16; ind_rbot += 16;
                        c_idx++;
                    }

                    int remain = x_stop - x;
                    if (remain > 0) {
                        __mmask16 mask = (1ULL << remain) - 1;
                        __m512 TL, TR;
                        if (y > y_begin) {
                            TL = cache_L[c_idx]; TR = cache_R[c_idx];
                        } else {
                            TL = load_cvt16_masked(p.SUB + ind_ltop, mask);
                            TR = load_cvt16_masked(p.SUB + ind_rtop, mask);
                        }
                        __m512 BL = load_cvt16_masked(p.SUB + ind_lbot, mask);
                        __m512 BR = load_cvt16_masked(p.SUB + ind_rbot, mask);
                        cache_L[c_idx] = BL; cache_R[c_idx] = BR;

                        __m512 V = _mm512_maskz_loadu_ps(mask, vp);
                        V = _mm512_fmadd_ps(Avx, TL, V);
                        V = _mm512_fmadd_ps(Bvx, TR, V);
                        V = _mm512_fmadd_ps(Cvx, BL, V);
                        V = _mm512_fmadd_ps(Dvx, BR, V);
                        _mm512_mask_storeu_ps(vp, mask, V);
                    }
                }
            }

            // normalize simd
            const __m512 v_zero = _mm512_setzero_ps();
            const __m512 v_255 = _mm512_set1_ps(255.0f);
            
            // permutation indices for RGB
            __m512i v_idx0 = _mm512_set_epi32(5, 4, 4, 4, 3, 3, 3, 2, 2, 2, 1, 1, 1, 0, 0, 0);
            __m512i v_idx1 = _mm512_set_epi32(10, 10, 9, 9, 9, 8, 8, 8, 7, 7, 7, 6, 6, 6, 5, 5);
            __m512i v_idx2 = _mm512_set_epi32(15, 15, 15, 14, 14, 14, 13, 13, 13, 12, 12, 12, 11, 11, 11, 10);

            for (int y = ty; y < tile_y_end; ++y) {
                const float* vp = tile_vals.data() + (y - ty) * tile_w_actual * 3;
                unsigned char* outp = output.data.data() + (y * width + tx) * 3;
                const int* cp = &counts[y * width + tx];

                int x = 0;
                for (; x + 16 <= tile_w_actual; x += 16) {
                    __m512i c_vec = _mm512_loadu_si512(cp + x);
                    __m512 inv_c = _mm512_div_ps(_mm512_set1_ps(1.0f), _mm512_cvtepi32_ps(c_vec));

                    // broadcast inv_c to RGB components
                    __m512 inv0 = _mm512_permutexvar_ps(v_idx0, inv_c);
                    __m512 inv1 = _mm512_permutexvar_ps(v_idx1, inv_c);
                    __m512 inv2 = _mm512_permutexvar_ps(v_idx2, inv_c);

                    auto process_chunk = [&](int offset, __m512 inv_vals) {
                        __m512 v = _mm512_loadu_ps(vp + x * 3 + offset);
                        v = _mm512_mul_ps(v, inv_vals);
                        v = _mm512_min_ps(_mm512_max_ps(v, v_zero), v_255);
                        __m512i vi = _mm512_cvtps_epi32(v);
                        _mm_storeu_si128(reinterpret_cast<__m128i*>(outp + x * 3 + offset), _mm512_cvtepi32_epi8(vi));
                    };

                    process_chunk(0, inv0);
                    process_chunk(16, inv1);
                    process_chunk(32, inv2);
                }

                for (; x < tile_w_actual; ++x) {
                    int c = cp[x];
                    if (c == 0) continue;
                    float inv_c = 1.0f / static_cast<float>(c);
                    for (int ch = 0; ch < 3; ++ch) {
                        float v = vp[x * 3 + ch] * inv_c;
                        outp[x * 3 + ch] = static_cast<unsigned char>(std::clamp(v, 0.0f, 255.0f));
                    }
                }
            }
        }
    }

    return output;
}