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
*       - use AVX float32 FMA with unaligned loads
*       - use block tiles for better cache performance
*       - calculate counts using prefix sum technique
*       - unroll the main vectorized loop to increase ILP for independent vectors accumulations
*       - 2-row y unroll
*       - hoist A, B, C, D into broadcasted AVX registers
*       - fuse multiple output rows (2-row and 4-row processing blocks)
* */

#ifdef COUNT_FLOPS
// C++17 inline global: zero overhead, no ODR (One Definition Rule) violations
inline unsigned long long total_flops = 0;

// Simple macro to increment
#define ADD_FLOPS(n) total_flops += (n)

#else
// Safety against some more nasty preprocessing traps
#define ADD_FLOPS(n) do {} while(0)
#endif

struct SubParams {
    int sx, sy;
    float A, B, C, D;
    int x_begin, x_end, y_begin, y_end;
    const unsigned char* SUB;
};

static inline __m256 load_cvt8(const unsigned char* ptr) {
    // 32bit int -> 32bit single precision float: 8 
    ADD_FLOPS(8);
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
        ADD_FLOPS(2);
        p.sx = static_cast<int>(std::floor(shift_x));
        ADD_FLOPS(2); // floor + cast
        p.sy = static_cast<int>(std::floor(shift_y));
        ADD_FLOPS(2); // floor + cast
        float dx = shift_x - p.sx;
        float dy = shift_y - p.sy;
        ADD_FLOPS(2);
        p.A = (1.0f - dx) * (1.0f - dy);
        p.B = dx           * (1.0f - dy);
        p.C = (1.0f - dx) * dy;
        p.D = dx           * dy;
        ADD_FLOPS(8); // depends on how it is compiled 
        p.x_begin = std::max(0, -p.sx);
        p.x_end   = std::min(w, w - p.sx - 1);
        p.y_begin = std::max(0, -p.sy);
        p.y_end   = std::min(h, h - p.sy - 1);
        ADD_FLOPS(10); // counting the - as a FLOP 
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
    const int TILE_W = 2032;

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

                int y = y_begin;

                for (; y + 3 < y_end; y += 4) {
                    size_t rb[5];
                    rb[0] = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
                    rb[1] = rb[0] + width * 3;
                    rb[2] = rb[1] + width * 3;
                    rb[3] = rb[2] + width * 3;
                    rb[4] = rb[3] + width * 3;

                    float* vp0 = tile_vals.data() + (size_t)(y     - ty) * tile_row_stride + (size_t)(x_begin - tx) * 3;
                    float* vp1 = vp0 + tile_row_stride;
                    float* vp2 = vp1 + tile_row_stride;
                    float* vp3 = vp2 + tile_row_stride;

                    int xf = 0;

                    for (; xf + 16 <= x_floats; xf += 16) {
                        __m256 rl0_lo = load_cvt8(p.SUB + rb[0] + xf);
                        __m256 rl0_hi = load_cvt8(p.SUB + rb[0] + xf +  8);
                        __m256 rr0_lo = load_cvt8(p.SUB + rb[0] + xf +  3);
                        __m256 rr0_hi = load_cvt8(p.SUB + rb[0] + xf + 11);

                        __m256 rl1_lo = load_cvt8(p.SUB + rb[1] + xf);
                        __m256 rl1_hi = load_cvt8(p.SUB + rb[1] + xf +  8);
                        __m256 rr1_lo = load_cvt8(p.SUB + rb[1] + xf +  3);
                        __m256 rr1_hi = load_cvt8(p.SUB + rb[1] + xf + 11);

                        {
                            __m256 v_lo = _mm256_loadu_ps(vp0 + xf);
                            __m256 v_hi = _mm256_loadu_ps(vp0 + xf + 8);
                            v_lo = _mm256_fmadd_ps(Avx, rl0_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Avx, rl0_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Bvx, rr0_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Bvx, rr0_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Cvx, rl1_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Cvx, rl1_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Dvx, rr1_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Dvx, rr1_hi, v_hi);
                            ADD_FLOPS(8 * 8 * 2);
                            _mm256_storeu_ps(vp0 + xf,     v_lo);
                            _mm256_storeu_ps(vp0 + xf + 8, v_hi);
                        }

                        __m256 rl2_lo = load_cvt8(p.SUB + rb[2] + xf);
                        __m256 rl2_hi = load_cvt8(p.SUB + rb[2] + xf +  8);
                        __m256 rr2_lo = load_cvt8(p.SUB + rb[2] + xf +  3);
                        __m256 rr2_hi = load_cvt8(p.SUB + rb[2] + xf + 11);

                        {
                            __m256 v_lo = _mm256_loadu_ps(vp1 + xf);
                            __m256 v_hi = _mm256_loadu_ps(vp1 + xf + 8);
                            v_lo = _mm256_fmadd_ps(Avx, rl1_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Avx, rl1_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Bvx, rr1_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Bvx, rr1_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Cvx, rl2_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Cvx, rl2_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Dvx, rr2_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Dvx, rr2_hi, v_hi);
                            ADD_FLOPS(8 * 8 * 2);
                            _mm256_storeu_ps(vp1 + xf,     v_lo);
                            _mm256_storeu_ps(vp1 + xf + 8, v_hi);
                        }

                        __m256 rl3_lo = load_cvt8(p.SUB + rb[3] + xf);
                        __m256 rl3_hi = load_cvt8(p.SUB + rb[3] + xf +  8);
                        __m256 rr3_lo = load_cvt8(p.SUB + rb[3] + xf +  3);
                        __m256 rr3_hi = load_cvt8(p.SUB + rb[3] + xf + 11);

                        {
                            __m256 v_lo = _mm256_loadu_ps(vp2 + xf);
                            __m256 v_hi = _mm256_loadu_ps(vp2 + xf + 8);
                            v_lo = _mm256_fmadd_ps(Avx, rl2_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Avx, rl2_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Bvx, rr2_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Bvx, rr2_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Cvx, rl3_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Cvx, rl3_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Dvx, rr3_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Dvx, rr3_hi, v_hi);
                            ADD_FLOPS(8 * 8 * 2);
                            _mm256_storeu_ps(vp2 + xf,     v_lo);
                            _mm256_storeu_ps(vp2 + xf + 8, v_hi);
                        }

                        __m256 rl4_lo = load_cvt8(p.SUB + rb[4] + xf);
                        __m256 rl4_hi = load_cvt8(p.SUB + rb[4] + xf +  8);
                        __m256 rr4_lo = load_cvt8(p.SUB + rb[4] + xf +  3);
                        __m256 rr4_hi = load_cvt8(p.SUB + rb[4] + xf + 11);

                        {
                            __m256 v_lo = _mm256_loadu_ps(vp3 + xf);
                            __m256 v_hi = _mm256_loadu_ps(vp3 + xf + 8);
                            v_lo = _mm256_fmadd_ps(Avx, rl3_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Avx, rl3_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Bvx, rr3_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Bvx, rr3_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Cvx, rl4_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Cvx, rl4_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Dvx, rr4_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Dvx, rr4_hi, v_hi);
                            ADD_FLOPS(8 * 8 * 2);
                            _mm256_storeu_ps(vp3 + xf,     v_lo);
                            _mm256_storeu_ps(vp3 + xf + 8, v_hi);
                        }
                    }

                    if (xf + 8 <= x_floats) {
                        __m256 rl0 = load_cvt8(p.SUB + rb[0] + xf);
                        __m256 rr0 = load_cvt8(p.SUB + rb[0] + xf + 3);
                        __m256 rl1 = load_cvt8(p.SUB + rb[1] + xf);
                        __m256 rr1 = load_cvt8(p.SUB + rb[1] + xf + 3);
                        {
                            __m256 v = _mm256_loadu_ps(vp0 + xf);
                            v = _mm256_fmadd_ps(Avx, rl0, v);
                            v = _mm256_fmadd_ps(Bvx, rr0, v);
                            v = _mm256_fmadd_ps(Cvx, rl1, v);
                            v = _mm256_fmadd_ps(Dvx, rr1, v);
                            ADD_FLOPS(4 * 8 * 2);
                            _mm256_storeu_ps(vp0 + xf, v);
                        }
                        __m256 rl2 = load_cvt8(p.SUB + rb[2] + xf);
                        __m256 rr2 = load_cvt8(p.SUB + rb[2] + xf + 3);
                        {
                            __m256 v = _mm256_loadu_ps(vp1 + xf);
                            v = _mm256_fmadd_ps(Avx, rl1, v);
                            v = _mm256_fmadd_ps(Bvx, rr1, v);
                            v = _mm256_fmadd_ps(Cvx, rl2, v);
                            v = _mm256_fmadd_ps(Dvx, rr2, v);
                            ADD_FLOPS(4 * 8 * 2);
                            _mm256_storeu_ps(vp1 + xf, v);
                        }
                        __m256 rl3 = load_cvt8(p.SUB + rb[3] + xf);
                        __m256 rr3 = load_cvt8(p.SUB + rb[3] + xf + 3);
                        {
                            __m256 v = _mm256_loadu_ps(vp2 + xf);
                            v = _mm256_fmadd_ps(Avx, rl2, v);
                            v = _mm256_fmadd_ps(Bvx, rr2, v);
                            v = _mm256_fmadd_ps(Cvx, rl3, v);
                            v = _mm256_fmadd_ps(Dvx, rr3, v);
                            ADD_FLOPS(4 * 8 * 2);
                            _mm256_storeu_ps(vp2 + xf, v);
                        }
                        __m256 rl4 = load_cvt8(p.SUB + rb[4] + xf);
                        __m256 rr4 = load_cvt8(p.SUB + rb[4] + xf + 3);
                        {
                            __m256 v = _mm256_loadu_ps(vp3 + xf);
                            v = _mm256_fmadd_ps(Avx, rl3, v);
                            v = _mm256_fmadd_ps(Bvx, rr3, v);
                            v = _mm256_fmadd_ps(Cvx, rl4, v);
                            v = _mm256_fmadd_ps(Dvx, rr4, v);
                            ADD_FLOPS(4 * 8 * 2);
                            _mm256_storeu_ps(vp3 + xf, v);
                        }
                        xf += 8;
                    }

                    for (int k = 0; k < x_floats - xf; ++k) {
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
                        float s3l = p.SUB[rb[3]+xf+k], s3r = p.SUB[rb[3]+xf+k+3];
                        float s4l = p.SUB[rb[4]+xf+k], s4r = p.SUB[rb[4]+xf+k+3];
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
                        vp2[xf+k] += p.A*s2l + p.B*s2r + p.C*s3l + p.D*s3r;
                        vp3[xf+k] += p.A*s3l + p.B*s3r + p.C*s4l + p.D*s4r;
                        ADD_FLOPS(8 * 4);
                    }
                }

                for (; y + 1 < y_end; y += 2) {
                    size_t rb[3];
                    rb[0] = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
                    rb[1] = rb[0] + width * 3;
                    rb[2] = rb[1] + width * 3;

                    float* vp0 = tile_vals.data() + (size_t)(y - ty)     * tile_row_stride + (size_t)(x_begin - tx) * 3;
                    float* vp1 = vp0 + tile_row_stride;

                    int xf = 0;

                    for (; xf + 16 <= x_floats; xf += 16) {
                        __m256 rl0_lo = load_cvt8(p.SUB + rb[0] + xf);
                        __m256 rl0_hi = load_cvt8(p.SUB + rb[0] + xf +  8);
                        __m256 rr0_lo = load_cvt8(p.SUB + rb[0] + xf +  3);
                        __m256 rr0_hi = load_cvt8(p.SUB + rb[0] + xf + 11);
                        __m256 rl1_lo = load_cvt8(p.SUB + rb[1] + xf);
                        __m256 rl1_hi = load_cvt8(p.SUB + rb[1] + xf +  8);
                        __m256 rr1_lo = load_cvt8(p.SUB + rb[1] + xf +  3);
                        __m256 rr1_hi = load_cvt8(p.SUB + rb[1] + xf + 11);
                        {
                            __m256 v_lo = _mm256_loadu_ps(vp0 + xf);
                            __m256 v_hi = _mm256_loadu_ps(vp0 + xf + 8);
                            v_lo = _mm256_fmadd_ps(Avx, rl0_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Avx, rl0_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Bvx, rr0_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Bvx, rr0_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Cvx, rl1_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Cvx, rl1_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Dvx, rr1_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Dvx, rr1_hi, v_hi);
                            ADD_FLOPS(8 * 8 * 2);
                            _mm256_storeu_ps(vp0 + xf,     v_lo);
                            _mm256_storeu_ps(vp0 + xf + 8, v_hi);
                        }
                        __m256 rl2_lo = load_cvt8(p.SUB + rb[2] + xf);
                        __m256 rl2_hi = load_cvt8(p.SUB + rb[2] + xf +  8);
                        __m256 rr2_lo = load_cvt8(p.SUB + rb[2] + xf +  3);
                        __m256 rr2_hi = load_cvt8(p.SUB + rb[2] + xf + 11);
                        {
                            __m256 v_lo = _mm256_loadu_ps(vp1 + xf);
                            __m256 v_hi = _mm256_loadu_ps(vp1 + xf + 8);
                            v_lo = _mm256_fmadd_ps(Avx, rl1_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Avx, rl1_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Bvx, rr1_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Bvx, rr1_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Cvx, rl2_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Cvx, rl2_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Dvx, rr2_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Dvx, rr2_hi, v_hi);
                            ADD_FLOPS(8 * 8 * 2);
                            _mm256_storeu_ps(vp1 + xf,     v_lo);
                            _mm256_storeu_ps(vp1 + xf + 8, v_hi);
                        }
                    }

                    if (xf + 8 <= x_floats) {
                        __m256 rl0 = load_cvt8(p.SUB + rb[0] + xf);
                        __m256 rr0 = load_cvt8(p.SUB + rb[0] + xf + 3);
                        __m256 rl1 = load_cvt8(p.SUB + rb[1] + xf);
                        __m256 rr1 = load_cvt8(p.SUB + rb[1] + xf + 3);
                        {
                            __m256 v = _mm256_loadu_ps(vp0 + xf);
                            v = _mm256_fmadd_ps(Avx, rl0, v);
                            v = _mm256_fmadd_ps(Bvx, rr0, v);
                            v = _mm256_fmadd_ps(Cvx, rl1, v);
                            v = _mm256_fmadd_ps(Dvx, rr1, v);
                            ADD_FLOPS(4 * 8 * 2);
                            _mm256_storeu_ps(vp0 + xf, v);
                        }
                        __m256 rl2 = load_cvt8(p.SUB + rb[2] + xf);
                        __m256 rr2 = load_cvt8(p.SUB + rb[2] + xf + 3);
                        {
                            __m256 v = _mm256_loadu_ps(vp1 + xf);
                            v = _mm256_fmadd_ps(Avx, rl1, v);
                            v = _mm256_fmadd_ps(Bvx, rr1, v);
                            v = _mm256_fmadd_ps(Cvx, rl2, v);
                            v = _mm256_fmadd_ps(Dvx, rr2, v);
                            ADD_FLOPS(4 * 8 * 2);
                            _mm256_storeu_ps(vp1 + xf, v);
                        }
                        xf += 8;
                    }

                    for (int k = 0; k < x_floats - xf; ++k) {
                        float s0l = p.SUB[rb[0]+xf+k], s0r = p.SUB[rb[0]+xf+k+3];
                        float s1l = p.SUB[rb[1]+xf+k], s1r = p.SUB[rb[1]+xf+k+3];
                        float s2l = p.SUB[rb[2]+xf+k], s2r = p.SUB[rb[2]+xf+k+3];
                        vp0[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
                        vp1[xf+k] += p.A*s1l + p.B*s1r + p.C*s2l + p.D*s2r;
                        ADD_FLOPS(2 * 8);
                    }
                }

                if (y < y_end) {
                    size_t rb0 = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
                    size_t rb1 = rb0 + width * 3;

                    float* vp = tile_vals.data() + (size_t)(y - ty) * tile_row_stride + (size_t)(x_begin - tx) * 3;

                    int xf = 0;

                    for (; xf + 16 <= x_floats; xf += 16) {
                        __m256 rl0_lo = load_cvt8(p.SUB + rb0 + xf);
                        __m256 rl0_hi = load_cvt8(p.SUB + rb0 + xf +  8);
                        __m256 rr0_lo = load_cvt8(p.SUB + rb0 + xf +  3);
                        __m256 rr0_hi = load_cvt8(p.SUB + rb0 + xf + 11);
                        __m256 rl1_lo = load_cvt8(p.SUB + rb1 + xf);
                        __m256 rl1_hi = load_cvt8(p.SUB + rb1 + xf +  8);
                        __m256 rr1_lo = load_cvt8(p.SUB + rb1 + xf +  3);
                        __m256 rr1_hi = load_cvt8(p.SUB + rb1 + xf + 11);
                        __m256 v_lo = _mm256_loadu_ps(vp + xf);
                        __m256 v_hi = _mm256_loadu_ps(vp + xf + 8);
                        v_lo = _mm256_fmadd_ps(Avx, rl0_lo, v_lo);
                        v_hi = _mm256_fmadd_ps(Avx, rl0_hi, v_hi);
                        v_lo = _mm256_fmadd_ps(Bvx, rr0_lo, v_lo);
                        v_hi = _mm256_fmadd_ps(Bvx, rr0_hi, v_hi);
                        v_lo = _mm256_fmadd_ps(Cvx, rl1_lo, v_lo);
                        v_hi = _mm256_fmadd_ps(Cvx, rl1_hi, v_hi);
                        v_lo = _mm256_fmadd_ps(Dvx, rr1_lo, v_lo);
                        v_hi = _mm256_fmadd_ps(Dvx, rr1_hi, v_hi);
                        ADD_FLOPS(8 * 8 * 2);
                        _mm256_storeu_ps(vp + xf,     v_lo);
                        _mm256_storeu_ps(vp + xf + 8, v_hi);
                    }

                    if (xf + 8 <= x_floats) {
                        __m256 rl0 = load_cvt8(p.SUB + rb0 + xf);
                        __m256 rr0 = load_cvt8(p.SUB + rb0 + xf + 3);
                        __m256 rl1 = load_cvt8(p.SUB + rb1 + xf);
                        __m256 rr1 = load_cvt8(p.SUB + rb1 + xf + 3);
                        __m256 v = _mm256_loadu_ps(vp + xf);
                        v = _mm256_fmadd_ps(Avx, rl0, v);
                        v = _mm256_fmadd_ps(Bvx, rr0, v);
                        v = _mm256_fmadd_ps(Cvx, rl1, v);
                        v = _mm256_fmadd_ps(Dvx, rr1, v);
                        ADD_FLOPS(4 * 8 * 2);
                        _mm256_storeu_ps(vp + xf, v);
                        xf += 8;
                    }

                    for (int k = 0; k < x_floats - xf; ++k) {
                        float s0l = p.SUB[rb0+xf+k], s0r = p.SUB[rb0+xf+k+3];
                        float s1l = p.SUB[rb1+xf+k], s1r = p.SUB[rb1+xf+k+3];
                        vp[xf+k] += p.A*s0l + p.B*s0r + p.C*s1l + p.D*s1r;
                        ADD_FLOPS(8);
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
                    ADD_FLOPS(1);
                    outp[x*3    ] = (unsigned char)std::clamp(vp[x*3    ] * inv_c + 0.5f, 0.0f, 255.0f);
                    outp[x*3 + 1] = (unsigned char)std::clamp(vp[x*3 + 1] * inv_c + 0.5f, 0.0f, 255.0f);
                    outp[x*3 + 2] = (unsigned char)std::clamp(vp[x*3 + 2] * inv_c + 0.5f, 0.0f, 255.0f);
                    ADD_FLOPS(6); // is clamp just one?
                }
            }
        }
    }
    #ifdef COUNT_FLOPS
    std::cout << "Total Algorithmic FLOPs: " << total_flops << "\n";
    total_flops = 0; // reset if you run multiple benchmark iterations
    #endif

    return output;
}