#include "refocus.hpp"
#include "utils.hpp"
#include <vector>
#include <cmath>
#include <algorithm>
#include <immintrin.h>

/*
*   Ablation 6: Hand-vectorized AVX2 + 8x2032 tile + ILP x-unrolling + row register reuse.
*   Four output rows are fused per iteration. Each shared input row (e.g. rb[1]) is loaded
*   once and reused as both the "lower" neighbor for row N and the "upper" neighbor for
*   row N+1, eliminating ~37% of input row loads vs. processing rows independently.
*   Fallback 2-row and 1-row blocks handle the remainder.
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

                // 4-row block: rb[i+1] loaded for row i is reused as upper neighbor for row i+1
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
                        __m256 r0_lo = load_cvt8(p.SUB + rb[0] + xf);
                        __m256 r0_hi = load_cvt8(p.SUB + rb[0] + xf +  8);
                        __m256 s0_lo = load_cvt8(p.SUB + rb[0] + xf +  3);
                        __m256 s0_hi = load_cvt8(p.SUB + rb[0] + xf + 11);
                        __m256 r1_lo = load_cvt8(p.SUB + rb[1] + xf);
                        __m256 r1_hi = load_cvt8(p.SUB + rb[1] + xf +  8);
                        __m256 s1_lo = load_cvt8(p.SUB + rb[1] + xf +  3);
                        __m256 s1_hi = load_cvt8(p.SUB + rb[1] + xf + 11);
                        {
                            __m256 v_lo = _mm256_loadu_ps(vp0 + xf);
                            __m256 v_hi = _mm256_loadu_ps(vp0 + xf + 8);
                            v_lo = _mm256_fmadd_ps(Avx, r0_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Avx, r0_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Bvx, s0_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Bvx, s0_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Cvx, r1_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Cvx, r1_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Dvx, s1_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Dvx, s1_hi, v_hi);
                            _mm256_storeu_ps(vp0 + xf,     v_lo);
                            _mm256_storeu_ps(vp0 + xf + 8, v_hi);
                        }
                        __m256 r2_lo = load_cvt8(p.SUB + rb[2] + xf);
                        __m256 r2_hi = load_cvt8(p.SUB + rb[2] + xf +  8);
                        __m256 s2_lo = load_cvt8(p.SUB + rb[2] + xf +  3);
                        __m256 s2_hi = load_cvt8(p.SUB + rb[2] + xf + 11);
                        {
                            __m256 v_lo = _mm256_loadu_ps(vp1 + xf);
                            __m256 v_hi = _mm256_loadu_ps(vp1 + xf + 8);
                            v_lo = _mm256_fmadd_ps(Avx, r1_lo, v_lo);  // r1 reused
                            v_hi = _mm256_fmadd_ps(Avx, r1_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Bvx, s1_lo, v_lo);  // s1 reused
                            v_hi = _mm256_fmadd_ps(Bvx, s1_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Cvx, r2_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Cvx, r2_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Dvx, s2_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Dvx, s2_hi, v_hi);
                            _mm256_storeu_ps(vp1 + xf,     v_lo);
                            _mm256_storeu_ps(vp1 + xf + 8, v_hi);
                        }
                        __m256 r3_lo = load_cvt8(p.SUB + rb[3] + xf);
                        __m256 r3_hi = load_cvt8(p.SUB + rb[3] + xf +  8);
                        __m256 s3_lo = load_cvt8(p.SUB + rb[3] + xf +  3);
                        __m256 s3_hi = load_cvt8(p.SUB + rb[3] + xf + 11);
                        {
                            __m256 v_lo = _mm256_loadu_ps(vp2 + xf);
                            __m256 v_hi = _mm256_loadu_ps(vp2 + xf + 8);
                            v_lo = _mm256_fmadd_ps(Avx, r2_lo, v_lo);  // r2 reused
                            v_hi = _mm256_fmadd_ps(Avx, r2_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Bvx, s2_lo, v_lo);  // s2 reused
                            v_hi = _mm256_fmadd_ps(Bvx, s2_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Cvx, r3_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Cvx, r3_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Dvx, s3_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Dvx, s3_hi, v_hi);
                            _mm256_storeu_ps(vp2 + xf,     v_lo);
                            _mm256_storeu_ps(vp2 + xf + 8, v_hi);
                        }
                        __m256 r4_lo = load_cvt8(p.SUB + rb[4] + xf);
                        __m256 r4_hi = load_cvt8(p.SUB + rb[4] + xf +  8);
                        __m256 s4_lo = load_cvt8(p.SUB + rb[4] + xf +  3);
                        __m256 s4_hi = load_cvt8(p.SUB + rb[4] + xf + 11);
                        {
                            __m256 v_lo = _mm256_loadu_ps(vp3 + xf);
                            __m256 v_hi = _mm256_loadu_ps(vp3 + xf + 8);
                            v_lo = _mm256_fmadd_ps(Avx, r3_lo, v_lo);  // r3 reused
                            v_hi = _mm256_fmadd_ps(Avx, r3_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Bvx, s3_lo, v_lo);  // s3 reused
                            v_hi = _mm256_fmadd_ps(Bvx, s3_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Cvx, r4_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Cvx, r4_hi, v_hi);
                            v_lo = _mm256_fmadd_ps(Dvx, s4_lo, v_lo);
                            v_hi = _mm256_fmadd_ps(Dvx, s4_hi, v_hi);
                            _mm256_storeu_ps(vp3 + xf,     v_lo);
                            _mm256_storeu_ps(vp3 + xf + 8, v_hi);
                        }
                    }
                    if (xf + 8 <= x_floats) {
                        __m256 r0 = load_cvt8(p.SUB + rb[0] + xf);
                        __m256 s0 = load_cvt8(p.SUB + rb[0] + xf + 3);
                        __m256 r1 = load_cvt8(p.SUB + rb[1] + xf);
                        __m256 s1 = load_cvt8(p.SUB + rb[1] + xf + 3);
                        { __m256 v = _mm256_loadu_ps(vp0+xf); v=_mm256_fmadd_ps(Avx,r0,v); v=_mm256_fmadd_ps(Bvx,s0,v); v=_mm256_fmadd_ps(Cvx,r1,v); v=_mm256_fmadd_ps(Dvx,s1,v); _mm256_storeu_ps(vp0+xf,v); }
                        __m256 r2 = load_cvt8(p.SUB + rb[2] + xf);
                        __m256 s2 = load_cvt8(p.SUB + rb[2] + xf + 3);
                        { __m256 v = _mm256_loadu_ps(vp1+xf); v=_mm256_fmadd_ps(Avx,r1,v); v=_mm256_fmadd_ps(Bvx,s1,v); v=_mm256_fmadd_ps(Cvx,r2,v); v=_mm256_fmadd_ps(Dvx,s2,v); _mm256_storeu_ps(vp1+xf,v); }
                        __m256 r3 = load_cvt8(p.SUB + rb[3] + xf);
                        __m256 s3 = load_cvt8(p.SUB + rb[3] + xf + 3);
                        { __m256 v = _mm256_loadu_ps(vp2+xf); v=_mm256_fmadd_ps(Avx,r2,v); v=_mm256_fmadd_ps(Bvx,s2,v); v=_mm256_fmadd_ps(Cvx,r3,v); v=_mm256_fmadd_ps(Dvx,s3,v); _mm256_storeu_ps(vp2+xf,v); }
                        __m256 r4 = load_cvt8(p.SUB + rb[4] + xf);
                        __m256 s4 = load_cvt8(p.SUB + rb[4] + xf + 3);
                        { __m256 v = _mm256_loadu_ps(vp3+xf); v=_mm256_fmadd_ps(Avx,r3,v); v=_mm256_fmadd_ps(Bvx,s3,v); v=_mm256_fmadd_ps(Cvx,r4,v); v=_mm256_fmadd_ps(Dvx,s4,v); _mm256_storeu_ps(vp3+xf,v); }
                        xf += 8;
                    }
                    for (int k = 0; k < x_floats - xf; ++k) {
                        float s0l=p.SUB[rb[0]+xf+k], s0r=p.SUB[rb[0]+xf+k+3];
                        float s1l=p.SUB[rb[1]+xf+k], s1r=p.SUB[rb[1]+xf+k+3];
                        float s2l=p.SUB[rb[2]+xf+k], s2r=p.SUB[rb[2]+xf+k+3];
                        float s3l=p.SUB[rb[3]+xf+k], s3r=p.SUB[rb[3]+xf+k+3];
                        float s4l=p.SUB[rb[4]+xf+k], s4r=p.SUB[rb[4]+xf+k+3];
                        vp0[xf+k] += p.A*s0l+p.B*s0r+p.C*s1l+p.D*s1r;
                        vp1[xf+k] += p.A*s1l+p.B*s1r+p.C*s2l+p.D*s2r;
                        vp2[xf+k] += p.A*s2l+p.B*s2r+p.C*s3l+p.D*s3r;
                        vp3[xf+k] += p.A*s3l+p.B*s3r+p.C*s4l+p.D*s4r;
                    }
                }

                // 2-row fallback
                for (; y + 1 < y_end; y += 2) {
                    size_t rb[3];
                    rb[0] = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
                    rb[1] = rb[0] + width * 3;
                    rb[2] = rb[1] + width * 3;
                    float* vp0 = tile_vals.data() + (size_t)(y - ty)     * tile_row_stride + (size_t)(x_begin - tx) * 3;
                    float* vp1 = vp0 + tile_row_stride;
                    int xf = 0;
                    for (; xf + 16 <= x_floats; xf += 16) {
                        __m256 r0_lo=load_cvt8(p.SUB+rb[0]+xf),   r0_hi=load_cvt8(p.SUB+rb[0]+xf+8);
                        __m256 s0_lo=load_cvt8(p.SUB+rb[0]+xf+3), s0_hi=load_cvt8(p.SUB+rb[0]+xf+11);
                        __m256 r1_lo=load_cvt8(p.SUB+rb[1]+xf),   r1_hi=load_cvt8(p.SUB+rb[1]+xf+8);
                        __m256 s1_lo=load_cvt8(p.SUB+rb[1]+xf+3), s1_hi=load_cvt8(p.SUB+rb[1]+xf+11);
                        { __m256 v_lo=_mm256_loadu_ps(vp0+xf), v_hi=_mm256_loadu_ps(vp0+xf+8);
                          v_lo=_mm256_fmadd_ps(Avx,r0_lo,v_lo); v_hi=_mm256_fmadd_ps(Avx,r0_hi,v_hi);
                          v_lo=_mm256_fmadd_ps(Bvx,s0_lo,v_lo); v_hi=_mm256_fmadd_ps(Bvx,s0_hi,v_hi);
                          v_lo=_mm256_fmadd_ps(Cvx,r1_lo,v_lo); v_hi=_mm256_fmadd_ps(Cvx,r1_hi,v_hi);
                          v_lo=_mm256_fmadd_ps(Dvx,s1_lo,v_lo); v_hi=_mm256_fmadd_ps(Dvx,s1_hi,v_hi);
                          _mm256_storeu_ps(vp0+xf,v_lo); _mm256_storeu_ps(vp0+xf+8,v_hi); }
                        __m256 r2_lo=load_cvt8(p.SUB+rb[2]+xf),   r2_hi=load_cvt8(p.SUB+rb[2]+xf+8);
                        __m256 s2_lo=load_cvt8(p.SUB+rb[2]+xf+3), s2_hi=load_cvt8(p.SUB+rb[2]+xf+11);
                        { __m256 v_lo=_mm256_loadu_ps(vp1+xf), v_hi=_mm256_loadu_ps(vp1+xf+8);
                          v_lo=_mm256_fmadd_ps(Avx,r1_lo,v_lo); v_hi=_mm256_fmadd_ps(Avx,r1_hi,v_hi);  // r1 reused
                          v_lo=_mm256_fmadd_ps(Bvx,s1_lo,v_lo); v_hi=_mm256_fmadd_ps(Bvx,s1_hi,v_hi);  // s1 reused
                          v_lo=_mm256_fmadd_ps(Cvx,r2_lo,v_lo); v_hi=_mm256_fmadd_ps(Cvx,r2_hi,v_hi);
                          v_lo=_mm256_fmadd_ps(Dvx,s2_lo,v_lo); v_hi=_mm256_fmadd_ps(Dvx,s2_hi,v_hi);
                          _mm256_storeu_ps(vp1+xf,v_lo); _mm256_storeu_ps(vp1+xf+8,v_hi); }
                    }
                    if (xf + 8 <= x_floats) {
                        __m256 r0=load_cvt8(p.SUB+rb[0]+xf), s0=load_cvt8(p.SUB+rb[0]+xf+3);
                        __m256 r1=load_cvt8(p.SUB+rb[1]+xf), s1=load_cvt8(p.SUB+rb[1]+xf+3);
                        { __m256 v=_mm256_loadu_ps(vp0+xf); v=_mm256_fmadd_ps(Avx,r0,v); v=_mm256_fmadd_ps(Bvx,s0,v); v=_mm256_fmadd_ps(Cvx,r1,v); v=_mm256_fmadd_ps(Dvx,s1,v); _mm256_storeu_ps(vp0+xf,v); }
                        __m256 r2=load_cvt8(p.SUB+rb[2]+xf), s2=load_cvt8(p.SUB+rb[2]+xf+3);
                        { __m256 v=_mm256_loadu_ps(vp1+xf); v=_mm256_fmadd_ps(Avx,r1,v); v=_mm256_fmadd_ps(Bvx,s1,v); v=_mm256_fmadd_ps(Cvx,r2,v); v=_mm256_fmadd_ps(Dvx,s2,v); _mm256_storeu_ps(vp1+xf,v); }
                        xf += 8;
                    }
                    for (int k = 0; k < x_floats - xf; ++k) {
                        float s0l=p.SUB[rb[0]+xf+k], s0r=p.SUB[rb[0]+xf+k+3];
                        float s1l=p.SUB[rb[1]+xf+k], s1r=p.SUB[rb[1]+xf+k+3];
                        float s2l=p.SUB[rb[2]+xf+k], s2r=p.SUB[rb[2]+xf+k+3];
                        vp0[xf+k] += p.A*s0l+p.B*s0r+p.C*s1l+p.D*s1r;
                        vp1[xf+k] += p.A*s1l+p.B*s1r+p.C*s2l+p.D*s2r;
                    }
                }

                // 1-row remainder
                if (y < y_end) {
                    const size_t rb0 = ((size_t)(y + p.sy) * width + (size_t)(x_begin + p.sx)) * 3;
                    const size_t rb1 = rb0 + width * 3;
                    float* vp = tile_vals.data() + (size_t)(y - ty) * tile_row_stride + (size_t)(x_begin - tx) * 3;
                    int xf = 0;
                    for (; xf + 16 <= x_floats; xf += 16) {
                        __m256 ltop_lo=load_cvt8(p.SUB+rb0+xf),   ltop_hi=load_cvt8(p.SUB+rb0+xf+8);
                        __m256 rtop_lo=load_cvt8(p.SUB+rb0+xf+3), rtop_hi=load_cvt8(p.SUB+rb0+xf+11);
                        __m256 lbot_lo=load_cvt8(p.SUB+rb1+xf),   lbot_hi=load_cvt8(p.SUB+rb1+xf+8);
                        __m256 rbot_lo=load_cvt8(p.SUB+rb1+xf+3), rbot_hi=load_cvt8(p.SUB+rb1+xf+11);
                        __m256 v_lo=_mm256_loadu_ps(vp+xf), v_hi=_mm256_loadu_ps(vp+xf+8);
                        v_lo=_mm256_fmadd_ps(Avx,ltop_lo,v_lo); v_hi=_mm256_fmadd_ps(Avx,ltop_hi,v_hi);
                        v_lo=_mm256_fmadd_ps(Bvx,rtop_lo,v_lo); v_hi=_mm256_fmadd_ps(Bvx,rtop_hi,v_hi);
                        v_lo=_mm256_fmadd_ps(Cvx,lbot_lo,v_lo); v_hi=_mm256_fmadd_ps(Cvx,lbot_hi,v_hi);
                        v_lo=_mm256_fmadd_ps(Dvx,rbot_lo,v_lo); v_hi=_mm256_fmadd_ps(Dvx,rbot_hi,v_hi);
                        _mm256_storeu_ps(vp+xf,v_lo); _mm256_storeu_ps(vp+xf+8,v_hi);
                    }
                    if (xf + 8 <= x_floats) {
                        __m256 ltop=load_cvt8(p.SUB+rb0+xf), rtop=load_cvt8(p.SUB+rb0+xf+3);
                        __m256 lbot=load_cvt8(p.SUB+rb1+xf), rbot=load_cvt8(p.SUB+rb1+xf+3);
                        __m256 v=_mm256_loadu_ps(vp+xf);
                        v=_mm256_fmadd_ps(Avx,ltop,v); v=_mm256_fmadd_ps(Bvx,rtop,v);
                        v=_mm256_fmadd_ps(Cvx,lbot,v); v=_mm256_fmadd_ps(Dvx,rbot,v);
                        _mm256_storeu_ps(vp+xf,v); xf += 8;
                    }
                    for (int k = 0; k < x_floats - xf; ++k) {
                        float TL=p.SUB[rb0+xf+k], TR=p.SUB[rb0+xf+k+3];
                        float BL=p.SUB[rb1+xf+k], BR=p.SUB[rb1+xf+k+3];
                        vp[xf+k] += p.A*TL+p.B*TR+p.C*BL+p.D*BR;
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
