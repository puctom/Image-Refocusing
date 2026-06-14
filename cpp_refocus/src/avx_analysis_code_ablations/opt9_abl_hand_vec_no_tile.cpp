#include "refocus.hpp"
#include "utils.hpp"
#include <vector>
#include <cmath>
#include <algorithm>
#include <immintrin.h>

/*
*   Ablation 2: Hand-vectorized AVX2 with precomputed prefix-sum counts, NO tiling.
*  
*
*   Vectorization strategy: process 8 adjacent float values (covering ~2.67 RGB pixels)
*   per AVX register, loading from the 4 bilinear-interpolation corner positions.
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

    std::vector<float> vals(width * height * 3, 0.0f);

    for (const SubParams& p : params) {
        const __m256 Avx = _mm256_set1_ps(p.A);
        const __m256 Bvx = _mm256_set1_ps(p.B);
        const __m256 Cvx = _mm256_set1_ps(p.C);
        const __m256 Dvx = _mm256_set1_ps(p.D);

        for (int y = p.y_begin; y < p.y_end; ++y) {
            const size_t rb0 = ((size_t)(y + p.sy) * width + (size_t)(p.x_begin + p.sx)) * 3;
            const size_t rb1 = rb0 + width * 3;
            const int x_floats = (p.x_end - p.x_begin) * 3;

            float* vp = vals.data() + (size_t)y * width * 3 + (size_t)p.x_begin * 3;
            int xf = 0;

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

    for (int y = 0; y < h; ++y) {
        for (int x = 0; x < w; ++x) {
            const int c = counts[y * w + x];
            if (c == 0) continue;
            float inv_c = 1.0f / (float)c;
            const float* vp = vals.data() + ((size_t)y * width + x) * 3;
            unsigned char* outp = output.data.data() + ((size_t)y * width + x) * 3;
            outp[0] = (unsigned char)std::clamp(vp[0] * inv_c + 0.5f, 0.0f, 255.0f);
            outp[1] = (unsigned char)std::clamp(vp[1] * inv_c + 0.5f, 0.0f, 255.0f);
            outp[2] = (unsigned char)std::clamp(vp[2] * inv_c + 0.5f, 0.0f, 255.0f);
        }
    }

    return output;
}
