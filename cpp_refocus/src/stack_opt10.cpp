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
    *       - loop order: tile → subaperture → focus block → spatial
    *       - Common subexpression elimination
    *       - use better bounds for the x-y loops
    *       - use unchecked array access
    *       - function inlining
    *       - unroll channel loop to expose independent scalar ops for ILP
    *       - reduce number of loads in innermost loop
    *       - 2x2 output block unrolling (from opt8)
*           - precompute
*           - 4‑row y‑unrolling with full ILP exposure
*           - AVX2 SIMD with vector ILP (16‑float main path, 8‑float tail, scalar remainder)
* */

namespace {

struct SubParams {
    int sx, sy;
    float A, B, C, D;
    int x_begin, x_end, y_begin, y_end;
    const unsigned char* __restrict SUB;
};

constexpr int TILE_H = 12;
constexpr int TILE_W = 1056;
constexpr int FOCUS_BLOCK = 4;

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
            p.x_end   = std::min(w, w - p.sx - 1);
            p.y_begin = std::max(0, -p.sy);
            p.y_end   = std::min(h, h - p.sy - 1);
            p.SUB = sub.data.data.data();

            if (p.x_begin >= p.x_end || p.y_begin >= p.y_end)
                continue;
            params[f].push_back(p);
        }
    }

    std::vector<int> counts(NF * W * H, 0);
    {
        std::vector<int> diff((W + 1) * (H + 1));
        for (size_t f = 0; f < NF; ++f) {
            std::fill(diff.begin(), diff.end(), 0);
            for (const auto& p : params[f]) {
                diff[p.y_begin * (W + 1) + p.x_begin] += 1;
                diff[p.y_begin * (W + 1) + p.x_end  ] -= 1;
                diff[p.y_end   * (W + 1) + p.x_begin] -= 1;
                diff[p.y_end   * (W + 1) + p.x_end  ] += 1;
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

    const size_t max_tile_floats = static_cast<size_t>(TILE_H) * TILE_W * 3;
    std::vector<float> tile_vals(FOCUS_BLOCK * max_tile_floats);

    for (int ty = 0; ty < h; ty += TILE_H) {
        const int tile_y_end = std::min(ty + TILE_H, h);
        const int tile_h     = tile_y_end - ty;

        for (int tx = 0; tx < w; tx += TILE_W) {
            const int tile_x_end = std::min(tx + TILE_W, w);
            const int tile_w     = tile_x_end - tx;
            const size_t tile_floats = static_cast<size_t>(tile_h) * tile_w * 3;

            for (size_t fb = 0; fb < NF; fb += FOCUS_BLOCK) {
                const size_t f_end = std::min(fb + FOCUS_BLOCK, NF);
                const size_t block_sz = f_end - fb;
                const size_t block_floats = block_sz * tile_floats;

                std::fill(tile_vals.begin(), tile_vals.begin() + block_floats, 0.0f);

                for (size_t s = 0; s < subapertures.size(); ++s) {
                    const unsigned char* __restrict SUB = subapertures[s].data.data.data();

                    for (size_t f = fb; f < f_end; ++f) {
                        const SubParams& p = params[f][s];
                        if (p.x_begin >= p.x_end || p.y_begin >= p.y_end)
                            continue;

                        const int y_begin = std::max(ty, p.y_begin);
                        const int y_end   = std::min(tile_y_end, p.y_end);
                        const int x_begin = std::max(tx, p.x_begin);
                        const int x_end   = std::min(tile_x_end, p.x_end);
                        if (x_begin >= x_end || y_begin >= y_end)
                            continue;

                        const size_t f_local = f - fb;
                        float* __restrict tile_base = tile_vals.data() + f_local * tile_floats;

                        const __m256 Avx = _mm256_set1_ps(p.A);
                        const __m256 Bvx = _mm256_set1_ps(p.B);
                        const __m256 Cvx = _mm256_set1_ps(p.C);
                        const __m256 Dvx = _mm256_set1_ps(p.D);

                        const int x_chan_begin = (x_begin - tx) * 3;
                        const int x_chan_end   = (x_end   - tx) * 3;
                        const int x_floats     = x_chan_end - x_chan_begin;
                        const size_t row_stride = W * 3;

                        int y = y_begin;

                        for (; y + 3 < y_end; y += 4) {
                            size_t rb[5];
                            rb[0] = ((size_t)(y + p.sy) * W + (size_t)(x_begin + p.sx)) * 3;
                            rb[1] = rb[0] + row_stride;
                            rb[2] = rb[1] + row_stride;
                            rb[3] = rb[2] + row_stride;
                            rb[4] = rb[3] + row_stride;

                            _mm_prefetch((const char*)(SUB + rb[0] + 64), _MM_HINT_T0);
                            _mm_prefetch((const char*)(SUB + rb[1] + 64), _MM_HINT_T0);
                            _mm_prefetch((const char*)(SUB + rb[2] + 64), _MM_HINT_T0);
                            _mm_prefetch((const char*)(SUB + rb[3] + 64), _MM_HINT_T0);
                            _mm_prefetch((const char*)(SUB + rb[4] + 64), _MM_HINT_T0);

                            float* __restrict vp0 = tile_base + (size_t)(y - ty) * tile_w * 3 + x_chan_begin;
                            float* __restrict vp1 = vp0 + tile_w * 3;
                            float* __restrict vp2 = vp1 + tile_w * 3;
                            float* __restrict vp3 = vp2 + tile_w * 3;

                            int xf = 0;
                            for (; xf + 16 <= x_floats; xf += 16) {
                                _mm_prefetch((const char*)(SUB + rb[0] + xf + 64), _MM_HINT_T0);
                                _mm_prefetch((const char*)(SUB + rb[1] + xf + 64), _MM_HINT_T0);
                                _mm_prefetch((const char*)(SUB + rb[2] + xf + 64), _MM_HINT_T0);
                                _mm_prefetch((const char*)(SUB + rb[3] + xf + 64), _MM_HINT_T0);
                                _mm_prefetch((const char*)(SUB + rb[4] + xf + 64), _MM_HINT_T0);

                                __m256 r0l_lo = load_cvt8(SUB + rb[0] + xf);
                                __m256 r0l_hi = load_cvt8(SUB + rb[0] + xf +  8);
                                __m256 r0r_lo = load_cvt8(SUB + rb[0] + xf +  3);
                                __m256 r0r_hi = load_cvt8(SUB + rb[0] + xf + 11);

                                __m256 r1l_lo = load_cvt8(SUB + rb[1] + xf);
                                __m256 r1l_hi = load_cvt8(SUB + rb[1] + xf +  8);
                                __m256 r1r_lo = load_cvt8(SUB + rb[1] + xf +  3);
                                __m256 r1r_hi = load_cvt8(SUB + rb[1] + xf + 11);

                                {
                                    __m256 v_lo = _mm256_loadu_ps(vp0 + xf);
                                    __m256 v_hi = _mm256_loadu_ps(vp0 + xf + 8);
                                    v_lo = _mm256_fmadd_ps(Avx, r0l_lo, v_lo);
                                    v_hi = _mm256_fmadd_ps(Avx, r0l_hi, v_hi);
                                    v_lo = _mm256_fmadd_ps(Bvx, r0r_lo, v_lo);
                                    v_hi = _mm256_fmadd_ps(Bvx, r0r_hi, v_hi);
                                    v_lo = _mm256_fmadd_ps(Cvx, r1l_lo, v_lo);
                                    v_hi = _mm256_fmadd_ps(Cvx, r1l_hi, v_hi);
                                    v_lo = _mm256_fmadd_ps(Dvx, r1r_lo, v_lo);
                                    v_hi = _mm256_fmadd_ps(Dvx, r1r_hi, v_hi);
                                    _mm256_storeu_ps(vp0 + xf,     v_lo);
                                    _mm256_storeu_ps(vp0 + xf + 8, v_hi);
                                }

                                __m256 r2l_lo = load_cvt8(SUB + rb[2] + xf);
                                __m256 r2l_hi = load_cvt8(SUB + rb[2] + xf +  8);
                                __m256 r2r_lo = load_cvt8(SUB + rb[2] + xf +  3);
                                __m256 r2r_hi = load_cvt8(SUB + rb[2] + xf + 11);

                                {
                                    __m256 v_lo = _mm256_loadu_ps(vp1 + xf);
                                    __m256 v_hi = _mm256_loadu_ps(vp1 + xf + 8);
                                    v_lo = _mm256_fmadd_ps(Avx, r1l_lo, v_lo);
                                    v_hi = _mm256_fmadd_ps(Avx, r1l_hi, v_hi);
                                    v_lo = _mm256_fmadd_ps(Bvx, r1r_lo, v_lo);
                                    v_hi = _mm256_fmadd_ps(Bvx, r1r_hi, v_hi);
                                    v_lo = _mm256_fmadd_ps(Cvx, r2l_lo, v_lo);
                                    v_hi = _mm256_fmadd_ps(Cvx, r2l_hi, v_hi);
                                    v_lo = _mm256_fmadd_ps(Dvx, r2r_lo, v_lo);
                                    v_hi = _mm256_fmadd_ps(Dvx, r2r_hi, v_hi);
                                    _mm256_storeu_ps(vp1 + xf,     v_lo);
                                    _mm256_storeu_ps(vp1 + xf + 8, v_hi);
                                }

                                __m256 r3l_lo = load_cvt8(SUB + rb[3] + xf);
                                __m256 r3l_hi = load_cvt8(SUB + rb[3] + xf +  8);
                                __m256 r3r_lo = load_cvt8(SUB + rb[3] + xf +  3);
                                __m256 r3r_hi = load_cvt8(SUB + rb[3] + xf + 11);

                                {
                                    __m256 v_lo = _mm256_loadu_ps(vp2 + xf);
                                    __m256 v_hi = _mm256_loadu_ps(vp2 + xf + 8);
                                    v_lo = _mm256_fmadd_ps(Avx, r2l_lo, v_lo);
                                    v_hi = _mm256_fmadd_ps(Avx, r2l_hi, v_hi);
                                    v_lo = _mm256_fmadd_ps(Bvx, r2r_lo, v_lo);
                                    v_hi = _mm256_fmadd_ps(Bvx, r2r_hi, v_hi);
                                    v_lo = _mm256_fmadd_ps(Cvx, r3l_lo, v_lo);
                                    v_hi = _mm256_fmadd_ps(Cvx, r3l_hi, v_hi);
                                    v_lo = _mm256_fmadd_ps(Dvx, r3r_lo, v_lo);
                                    v_hi = _mm256_fmadd_ps(Dvx, r3r_hi, v_hi);
                                    _mm256_storeu_ps(vp2 + xf,     v_lo);
                                    _mm256_storeu_ps(vp2 + xf + 8, v_hi);
                                }

                                __m256 r4l_lo = load_cvt8(SUB + rb[4] + xf);
                                __m256 r4l_hi = load_cvt8(SUB + rb[4] + xf +  8);
                                __m256 r4r_lo = load_cvt8(SUB + rb[4] + xf +  3);
                                __m256 r4r_hi = load_cvt8(SUB + rb[4] + xf + 11);

                                {
                                    __m256 v_lo = _mm256_loadu_ps(vp3 + xf);
                                    __m256 v_hi = _mm256_loadu_ps(vp3 + xf + 8);
                                    v_lo = _mm256_fmadd_ps(Avx, r3l_lo, v_lo);
                                    v_hi = _mm256_fmadd_ps(Avx, r3l_hi, v_hi);
                                    v_lo = _mm256_fmadd_ps(Bvx, r3r_lo, v_lo);
                                    v_hi = _mm256_fmadd_ps(Bvx, r3r_hi, v_hi);
                                    v_lo = _mm256_fmadd_ps(Cvx, r4l_lo, v_lo);
                                    v_hi = _mm256_fmadd_ps(Cvx, r4l_hi, v_hi);
                                    v_lo = _mm256_fmadd_ps(Dvx, r4r_lo, v_lo);
                                    v_hi = _mm256_fmadd_ps(Dvx, r4r_hi, v_hi);
                                    _mm256_storeu_ps(vp3 + xf,     v_lo);
                                    _mm256_storeu_ps(vp3 + xf + 8, v_hi);
                                }
                            }

                            if (xf + 8 <= x_floats) {
                                __m256 r0l = load_cvt8(SUB + rb[0] + xf);
                                __m256 r0r = load_cvt8(SUB + rb[0] + xf + 3);
                                __m256 r1l = load_cvt8(SUB + rb[1] + xf);
                                __m256 r1r = load_cvt8(SUB + rb[1] + xf + 3);
                                {
                                    __m256 v = _mm256_loadu_ps(vp0 + xf);
                                    v = _mm256_fmadd_ps(Avx, r0l, v);
                                    v = _mm256_fmadd_ps(Bvx, r0r, v);
                                    v = _mm256_fmadd_ps(Cvx, r1l, v);
                                    v = _mm256_fmadd_ps(Dvx, r1r, v);
                                    _mm256_storeu_ps(vp0 + xf, v);
                                }
                                __m256 r2l = load_cvt8(SUB + rb[2] + xf);
                                __m256 r2r = load_cvt8(SUB + rb[2] + xf + 3);
                                {
                                    __m256 v = _mm256_loadu_ps(vp1 + xf);
                                    v = _mm256_fmadd_ps(Avx, r1l, v);
                                    v = _mm256_fmadd_ps(Bvx, r1r, v);
                                    v = _mm256_fmadd_ps(Cvx, r2l, v);
                                    v = _mm256_fmadd_ps(Dvx, r2r, v);
                                    _mm256_storeu_ps(vp1 + xf, v);
                                }
                                __m256 r3l = load_cvt8(SUB + rb[3] + xf);
                                __m256 r3r = load_cvt8(SUB + rb[3] + xf + 3);
                                {
                                    __m256 v = _mm256_loadu_ps(vp2 + xf);
                                    v = _mm256_fmadd_ps(Avx, r2l, v);
                                    v = _mm256_fmadd_ps(Bvx, r2r, v);
                                    v = _mm256_fmadd_ps(Cvx, r3l, v);
                                    v = _mm256_fmadd_ps(Dvx, r3r, v);
                                    _mm256_storeu_ps(vp2 + xf, v);
                                }
                                __m256 r4l = load_cvt8(SUB + rb[4] + xf);
                                __m256 r4r = load_cvt8(SUB + rb[4] + xf + 3);
                                {
                                    __m256 v = _mm256_loadu_ps(vp3 + xf);
                                    v = _mm256_fmadd_ps(Avx, r3l, v);
                                    v = _mm256_fmadd_ps(Bvx, r3r, v);
                                    v = _mm256_fmadd_ps(Cvx, r4l, v);
                                    v = _mm256_fmadd_ps(Dvx, r4r, v);
                                    _mm256_storeu_ps(vp3 + xf, v);
                                }
                                xf += 8;
                            }

                            for (int k = 0; k < x_floats - xf; ++k) {
                                float s0l = SUB[rb[0]+xf+k], s0r = SUB[rb[0]+xf+k+3];
                                float s1l = SUB[rb[1]+xf+k], s1r = SUB[rb[1]+xf+k+3];
                                float s2l = SUB[rb[2]+xf+k], s2r = SUB[rb[2]+xf+k+3];
                                float s3l = SUB[rb[3]+xf+k], s3r = SUB[rb[3]+xf+k+3];
                                float s4l = SUB[rb[4]+xf+k], s4r = SUB[rb[4]+xf+k+3];
                                vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
                                vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
                                vp2[xf+k] += p.A*s2l + p.B*s2r + p.C*s3l + p.D*s3r;
                                vp3[xf+k] += p.A*s3l + p.B*s3r + p.C*s4l + p.D*s4r;
                            }
                        }

                        for (; y + 1 < y_end; y += 2) {
                            size_t rb[3];
                            rb[0] = ((size_t)(y + p.sy) * W + (size_t)(x_begin + p.sx)) * 3;
                            rb[1] = rb[0] + row_stride;
                            rb[2] = rb[1] + row_stride;

                            _mm_prefetch((const char*)(SUB + rb[0] + 64), _MM_HINT_T0);
                            _mm_prefetch((const char*)(SUB + rb[1] + 64), _MM_HINT_T0);
                            _mm_prefetch((const char*)(SUB + rb[2] + 64), _MM_HINT_T0);

                            float* __restrict vp0 = tile_base + (size_t)(y - ty) * tile_w * 3 + x_chan_begin;
                            float* __restrict vp1 = vp0 + tile_w * 3;

                            int xf = 0;
                            for (; xf + 16 <= x_floats; xf += 16) {
                                _mm_prefetch((const char*)(SUB + rb[0] + xf + 64), _MM_HINT_T0);
                                _mm_prefetch((const char*)(SUB + rb[1] + xf + 64), _MM_HINT_T0);
                                _mm_prefetch((const char*)(SUB + rb[2] + xf + 64), _MM_HINT_T0);

                                __m256 r0l_lo = load_cvt8(SUB + rb[0] + xf);
                                __m256 r0l_hi = load_cvt8(SUB + rb[0] + xf +  8);
                                __m256 r0r_lo = load_cvt8(SUB + rb[0] + xf +  3);
                                __m256 r0r_hi = load_cvt8(SUB + rb[0] + xf + 11);

                                __m256 r1l_lo = load_cvt8(SUB + rb[1] + xf);
                                __m256 r1l_hi = load_cvt8(SUB + rb[1] + xf +  8);
                                __m256 r1r_lo = load_cvt8(SUB + rb[1] + xf +  3);
                                __m256 r1r_hi = load_cvt8(SUB + rb[1] + xf + 11);

                                {
                                    __m256 v_lo = _mm256_loadu_ps(vp0 + xf);
                                    __m256 v_hi = _mm256_loadu_ps(vp0 + xf + 8);
                                    v_lo = _mm256_fmadd_ps(Avx, r0l_lo, v_lo);
                                    v_hi = _mm256_fmadd_ps(Avx, r0l_hi, v_hi);
                                    v_lo = _mm256_fmadd_ps(Bvx, r0r_lo, v_lo);
                                    v_hi = _mm256_fmadd_ps(Bvx, r0r_hi, v_hi);
                                    v_lo = _mm256_fmadd_ps(Cvx, r1l_lo, v_lo);
                                    v_hi = _mm256_fmadd_ps(Cvx, r1l_hi, v_hi);
                                    v_lo = _mm256_fmadd_ps(Dvx, r1r_lo, v_lo);
                                    v_hi = _mm256_fmadd_ps(Dvx, r1r_hi, v_hi);
                                    _mm256_storeu_ps(vp0 + xf,     v_lo);
                                    _mm256_storeu_ps(vp0 + xf + 8, v_hi);
                                }

                                __m256 r2l_lo = load_cvt8(SUB + rb[2] + xf);
                                __m256 r2l_hi = load_cvt8(SUB + rb[2] + xf +  8);
                                __m256 r2r_lo = load_cvt8(SUB + rb[2] + xf +  3);
                                __m256 r2r_hi = load_cvt8(SUB + rb[2] + xf + 11);

                                {
                                    __m256 v_lo = _mm256_loadu_ps(vp1 + xf);
                                    __m256 v_hi = _mm256_loadu_ps(vp1 + xf + 8);
                                    v_lo = _mm256_fmadd_ps(Avx, r1l_lo, v_lo);
                                    v_hi = _mm256_fmadd_ps(Avx, r1l_hi, v_hi);
                                    v_lo = _mm256_fmadd_ps(Bvx, r1r_lo, v_lo);
                                    v_hi = _mm256_fmadd_ps(Bvx, r1r_hi, v_hi);
                                    v_lo = _mm256_fmadd_ps(Cvx, r2l_lo, v_lo);
                                    v_hi = _mm256_fmadd_ps(Cvx, r2l_hi, v_hi);
                                    v_lo = _mm256_fmadd_ps(Dvx, r2r_lo, v_lo);
                                    v_hi = _mm256_fmadd_ps(Dvx, r2r_hi, v_hi);
                                    _mm256_storeu_ps(vp1 + xf,     v_lo);
                                    _mm256_storeu_ps(vp1 + xf + 8, v_hi);
                                }
                            }

                            if (xf + 8 <= x_floats) {
                                __m256 r0l = load_cvt8(SUB + rb[0] + xf);
                                __m256 r0r = load_cvt8(SUB + rb[0] + xf + 3);
                                __m256 r1l = load_cvt8(SUB + rb[1] + xf);
                                __m256 r1r = load_cvt8(SUB + rb[1] + xf + 3);
                                {
                                    __m256 v = _mm256_loadu_ps(vp0 + xf);
                                    v = _mm256_fmadd_ps(Avx, r0l, v);
                                    v = _mm256_fmadd_ps(Bvx, r0r, v);
                                    v = _mm256_fmadd_ps(Cvx, r1l, v);
                                    v = _mm256_fmadd_ps(Dvx, r1r, v);
                                    _mm256_storeu_ps(vp0 + xf, v);
                                }
                                __m256 r2l = load_cvt8(SUB + rb[2] + xf);
                                __m256 r2r = load_cvt8(SUB + rb[2] + xf + 3);
                                {
                                    __m256 v = _mm256_loadu_ps(vp1 + xf);
                                    v = _mm256_fmadd_ps(Avx, r1l, v);
                                    v = _mm256_fmadd_ps(Bvx, r1r, v);
                                    v = _mm256_fmadd_ps(Cvx, r2l, v);
                                    v = _mm256_fmadd_ps(Dvx, r2r, v);
                                    _mm256_storeu_ps(vp1 + xf, v);
                                }
                                xf += 8;
                            }

                            for (int k = 0; k < x_floats - xf; ++k) {
                                float s0l = SUB[rb[0]+xf+k], s0r = SUB[rb[0]+xf+k+3];
                                float s1l = SUB[rb[1]+xf+k], s1r = SUB[rb[1]+xf+k+3];
                                float s2l = SUB[rb[2]+xf+k], s2r = SUB[rb[2]+xf+k+3];
                                vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
                                vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
                            }
                        }

                        if (y < y_end) {
                            size_t rb0 = ((size_t)(y + p.sy) * W + (size_t)(x_begin + p.sx)) * 3;
                            size_t rb1 = rb0 + row_stride;

                            _mm_prefetch((const char*)(SUB + rb0 + 64), _MM_HINT_T0);
                            _mm_prefetch((const char*)(SUB + rb1 + 64), _MM_HINT_T0);

                            float* __restrict vp = tile_base + (size_t)(y - ty) * tile_w * 3 + x_chan_begin;

                            int xf = 0;
                            for (; xf + 16 <= x_floats; xf += 16) {
                                _mm_prefetch((const char*)(SUB + rb0 + xf + 64), _MM_HINT_T0);
                                _mm_prefetch((const char*)(SUB + rb1 + xf + 64), _MM_HINT_T0);

                                __m256 r0l_lo = load_cvt8(SUB + rb0 + xf);
                                __m256 r0l_hi = load_cvt8(SUB + rb0 + xf +  8);
                                __m256 r0r_lo = load_cvt8(SUB + rb0 + xf +  3);
                                __m256 r0r_hi = load_cvt8(SUB + rb0 + xf + 11);
                                __m256 r1l_lo = load_cvt8(SUB + rb1 + xf);
                                __m256 r1l_hi = load_cvt8(SUB + rb1 + xf +  8);
                                __m256 r1r_lo = load_cvt8(SUB + rb1 + xf +  3);
                                __m256 r1r_hi = load_cvt8(SUB + rb1 + xf + 11);

                                __m256 v_lo = _mm256_loadu_ps(vp + xf);
                                __m256 v_hi = _mm256_loadu_ps(vp + xf + 8);
                                v_lo = _mm256_fmadd_ps(Avx, r0l_lo, v_lo);
                                v_hi = _mm256_fmadd_ps(Avx, r0l_hi, v_hi);
                                v_lo = _mm256_fmadd_ps(Bvx, r0r_lo, v_lo);
                                v_hi = _mm256_fmadd_ps(Bvx, r0r_hi, v_hi);
                                v_lo = _mm256_fmadd_ps(Cvx, r1l_lo, v_lo);
                                v_hi = _mm256_fmadd_ps(Cvx, r1l_hi, v_hi);
                                v_lo = _mm256_fmadd_ps(Dvx, r1r_lo, v_lo);
                                v_hi = _mm256_fmadd_ps(Dvx, r1r_hi, v_hi);
                                _mm256_storeu_ps(vp + xf,     v_lo);
                                _mm256_storeu_ps(vp + xf + 8, v_hi);
                            }

                            if (xf + 8 <= x_floats) {
                                __m256 r0l = load_cvt8(SUB + rb0 + xf);
                                __m256 r0r = load_cvt8(SUB + rb0 + xf + 3);
                                __m256 r1l = load_cvt8(SUB + rb1 + xf);
                                __m256 r1r = load_cvt8(SUB + rb1 + xf + 3);
                                __m256 v = _mm256_loadu_ps(vp + xf);
                                v = _mm256_fmadd_ps(Avx, r0l, v);
                                v = _mm256_fmadd_ps(Bvx, r0r, v);
                                v = _mm256_fmadd_ps(Cvx, r1l, v);
                                v = _mm256_fmadd_ps(Dvx, r1r, v);
                                _mm256_storeu_ps(vp + xf, v);
                                xf += 8;
                            }

                            for (int k = 0; k < x_floats - xf; ++k) {
                                float s0l = SUB[rb0+xf+k], s0r = SUB[rb0+xf+k+3];
                                float s1l = SUB[rb1+xf+k], s1r = SUB[rb1+xf+k+3];
                                vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
                            }
                        }
                    }
                }

                for (size_t f = fb; f < f_end; ++f) {
                    const size_t f_local = f - fb;
                    const float* tile_base = tile_vals.data() + f_local * tile_floats;
                    const int* count_base = counts.data() + f * W * H;

                    for (int y = ty; y < tile_y_end; ++y) {
                        const float* __restrict vp = tile_base + (y - ty) * tile_w * 3;
                        unsigned char* __restrict outp = results[f].data.data() + (y * W + tx) * 3;

                        for (int x = 0; x < tile_w; ++x) {
                            int c = count_base[y * w + (tx + x)];
                            if (c == 0) continue;
                            float inv_c = 1.0f / static_cast<float>(c);
                            outp[x*3  ] = static_cast<unsigned char>(std::clamp(std::round(vp[x*3  ] * inv_c), 0.0f, 255.0f));
                            outp[x*3+1] = static_cast<unsigned char>(std::clamp(std::round(vp[x*3+1] * inv_c), 0.0f, 255.0f));
                            outp[x*3+2] = static_cast<unsigned char>(std::clamp(std::round(vp[x*3+2] * inv_c), 0.0f, 255.0f));
                        }
                    }
                }
            }
        }
    }

    return results;
}