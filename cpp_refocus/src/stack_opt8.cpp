#include "refocus_stack.hpp"
#include "refocus.hpp"
#include "utils.hpp"
#include <vector>
#include <cmath>
#include <algorithm>
#include <initializer_list>
#include <immintrin.h>
#include <cstdlib>

/* DOESNT PASS VALIDATION
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
    *       - precompute
    *       - AVX + vector ILP unrolling + y - unroll
    *       - more unrolling + process 2 subapts at a time + alignment
* */

namespace {

struct SubParams {
    int sx, sy;
    float A, B, C, D;
    int x_begin, x_end, y_begin, y_end;
    const unsigned char* __restrict SUB;
};

struct AlignedFloatBuf {
    float* p = nullptr;
    size_t n = 0;

    void resize(size_t want) {
        if (want <= n) return;
        if (p) std::free(p);
        size_t bytes = ((want * sizeof(float) + 63u) / 64u) * 64u;
        p = static_cast<float*>(std::aligned_alloc(64u, bytes));
        if (!p) throw std::bad_alloc{};
        n = bytes / sizeof(float);
    }

    ~AlignedFloatBuf() { if (p) std::free(p); }
    float* data() noexcept { return p; }
    const float* data() const noexcept { return p; }
};

constexpr int TILE_H = 6;
constexpr int TILE_W = 2032;

static inline __m256 load_cvt8(const unsigned char* ptr) {
    return _mm256_cvtepi32_ps(_mm256_cvtepu8_epi32(_mm_loadl_epi64(reinterpret_cast<const __m128i*>(ptr))));
}

static inline void fma_row_2w(const unsigned char* __restrict SUB, size_t base, __m256 wL, __m256 wR, __m256& accL, __m256& accH) {
    accL = _mm256_fmadd_ps(wL, load_cvt8(SUB + base), accL);
    accH = _mm256_fmadd_ps(wL, load_cvt8(SUB + base + 8), accH);
    accL = _mm256_fmadd_ps(wR, load_cvt8(SUB + base + 3), accL);
    accH = _mm256_fmadd_ps(wR, load_cvt8(SUB + base + 11), accH);
}

static inline void fma_row_4w(const unsigned char* __restrict SUB, size_t base, __m256 cL, __m256 cR, __m256 aL, __m256 aR, __m256& acc0L, __m256& acc0H, __m256& acc1L, __m256& acc1H) {
    __m256 t = load_cvt8(SUB + base);
    acc0L = _mm256_fmadd_ps(cL, t, acc0L); acc1L = _mm256_fmadd_ps(aL, t, acc1L);
    t = load_cvt8(SUB + base + 8);
    acc0H = _mm256_fmadd_ps(cL, t, acc0H); acc1H = _mm256_fmadd_ps(aL, t, acc1H);
    t = load_cvt8(SUB + base + 3);
    acc0L = _mm256_fmadd_ps(cR, t, acc0L); acc1L = _mm256_fmadd_ps(aR, t, acc1L);
    t = load_cvt8(SUB + base + 11);
    acc0H = _mm256_fmadd_ps(cR, t, acc0H); acc1H = _mm256_fmadd_ps(aR, t, acc1H);
}

}

std::vector<ImageData> refocus_shift_and_sum_stack(std::vector<SubApertureImage>& subapertures, const std::vector<float>& focuses) {
    const size_t W = subapertures.front().data.width, H = subapertures.front().data.height, NF = focuses.size();
    const int w = static_cast<int>(W), h = static_cast<int>(H);

    std::vector<std::vector<SubParams>> params(NF);
    for (size_t f = 0; f < NF; ++f) {
        params[f].reserve(subapertures.size());
        for (auto& sub : subapertures) {
            SubParams p;
            float shift_x = focuses[f] * sub.u, shift_y = focuses[f] * sub.v;
            p.sx = static_cast<int>(std::floor(shift_x)); p.sy = static_cast<int>(std::floor(shift_y));
            float dx = shift_x - p.sx, dy = shift_y - p.sy;
            p.A = (1.0f - dx) * (1.0f - dy); p.B = dx * (1.0f - dy); p.C = (1.0f - dx) * dy; p.D = dx * dy;
            p.x_begin = std::max(0, -p.sx); p.x_end = std::min(w, w - p.sx - 1);
            p.y_begin = std::max(0, -p.sy); p.y_end = std::min(h, h - p.sy - 1);
            p.SUB = sub.data.data.data();
            if (p.x_begin < p.x_end && p.y_begin < p.y_end) params[f].push_back(p);
        }
    }

    std::vector<int> counts(NF * W * H, 0);
    {
        std::vector<int> diff((W + 1) * (H + 1));
        for (size_t f = 0; f < NF; ++f) {
            std::fill(diff.begin(), diff.end(), 0);
            for (const auto& p : params[f]) {
                diff[p.y_begin * (W + 1) + p.x_begin] += 1; diff[p.y_begin * (W + 1) + p.x_end] -= 1;
                diff[p.y_end * (W + 1) + p.x_begin] -= 1; diff[p.y_end * (W + 1) + p.x_end] += 1;
            }
            int* cb = counts.data() + f * W * H;
            for (int y = 0; y < h; ++y) {
                int row = 0;
                for (int x = 0; x < w; ++x) { row += diff[y * (W + 1) + x]; cb[y * w + x] = row + (y > 0 ? cb[(y - 1) * w + x] : 0); }
            }
        }
    }

    std::vector<ImageData> results(NF);
    for (size_t f = 0; f < NF; ++f) { results[f].width = W; results[f].height = H; results[f].data.assign(W * H * 3, 0); }

    AlignedFloatBuf tile_buf;
    tile_buf.resize(static_cast<size_t>(NF) * TILE_H * TILE_W * 3);

    for (int ty = 0; ty < h; ty += TILE_H) {
        const int tile_y_end = std::min(ty + TILE_H, h), tile_h = tile_y_end - ty;
        for (int tx = 0; tx < w; tx += TILE_W) {
            const int tile_x_end = std::min(tx + TILE_W, w), tile_w = tile_x_end - tx, tile_floats = tile_h * tile_w * 3;
            std::fill(tile_buf.data(), tile_buf.data() + static_cast<size_t>(NF) * tile_floats, 0.0f);

            for (size_t f = 0; f < NF; ++f) {
                float* __restrict tile_base = tile_buf.data() + f * tile_floats;
                const auto& plist = params[f];
                const size_t Np = plist.size();

                auto do_single_sub = [&](const SubParams& p) {
                    const int y_begin = std::max(ty, p.y_begin), y_end = std::min(tile_y_end, p.y_end);
                    const int x_begin = std::max(tx, p.x_begin), x_end = std::min(tile_x_end, p.x_end);
                    if (x_begin >= x_end || y_begin >= y_end) return;

                    const __m256 Av = _mm256_set1_ps(p.A), Bv = _mm256_set1_ps(p.B), Cv = _mm256_set1_ps(p.C), Dv = _mm256_set1_ps(p.D);
                    const int x_chan_begin = (x_begin - tx) * 3, x_chan_stop = (x_end - tx) * 3;
                    const size_t row_stride = W * 3;

                    for (int y = y_begin; y + 1 < y_end; y += 2) {
                        size_t r0 = ((y + p.sy) * W + (x_begin + p.sx)) * 3, r1 = r0 + row_stride, r2 = r1 + row_stride;
                        float* __restrict vp0 = tile_base + (y - ty) * tile_w * 3 + x_chan_begin;
                        float* __restrict vp1 = vp0 + tile_w * 3;
                        int x = x_chan_begin;

                        for (; x + 16 <= x_chan_stop; x += 16) {
                            __m256 acc0L = _mm256_loadu_ps(vp0), acc0H = _mm256_loadu_ps(vp0 + 8);
                            __m256 acc1L = _mm256_loadu_ps(vp1), acc1H = _mm256_loadu_ps(vp1 + 8);
                            fma_row_2w(p.SUB, r0, Av, Bv, acc0L, acc0H);
                            fma_row_4w(p.SUB, r1, Cv, Dv, Av, Bv, acc0L, acc0H, acc1L, acc1H);
                            fma_row_2w(p.SUB, r2, Cv, Dv, acc1L, acc1H);
                            _mm256_storeu_ps(vp0, acc0L); _mm256_storeu_ps(vp0 + 8, acc0H);
                            _mm256_storeu_ps(vp1, acc1L); _mm256_storeu_ps(vp1 + 8, acc1H);
                            vp0 += 16; vp1 += 16; r0 += 16; r1 += 16; r2 += 16;
                        }

                        for (; x < x_chan_stop; ++x) {
                            float r0l = p.SUB[r0], r0r = p.SUB[r0 + 3], r1l = p.SUB[r1], r1r = p.SUB[r1 + 3], r2l = p.SUB[r2], r2r = p.SUB[r2 + 3];
                            *vp0 += p.A * r0l + p.B * r0r + p.C * r1l + p.D * r1r;
                            *vp1 += p.A * r1l + p.B * r1r + p.C * r2l + p.D * r2r;
                            ++vp0; ++vp1; ++r0; ++r1; ++r2;
                        }
                    }

                    if ((y_end - y_begin) & 1) {
                        int y = y_end - 1;
                        size_t r0 = ((y + p.sy) * W + (x_begin + p.sx)) * 3, r1 = r0 + row_stride;
                        float* __restrict vp0 = tile_base + (y - ty) * tile_w * 3 + x_chan_begin;
                        for (int x = x_chan_begin; x < x_chan_stop; ++x) {
                            float r0l = p.SUB[r0], r0r = p.SUB[r0 + 3], r1l = p.SUB[r1], r1r = p.SUB[r1 + 3];
                            *vp0 += p.A * r0l + p.B * r0r + p.C * r1l + p.D * r1r;
                            ++vp0; ++r0; ++r1;
                        }
                    }
                };

                size_t i = 0;
                for (; i + 1 < Np; i += 2) {
                    const SubParams& pa = plist[i]; const SubParams& pb = plist[i + 1];
                    const int y_begin = std::max({ty, pa.y_begin, pb.y_begin}), y_end = std::min({tile_y_end, pa.y_end, pb.y_end});
                    const int x_begin = std::max({tx, pa.x_begin, pb.x_begin}), x_end = std::min({tile_x_end, pa.x_end, pb.x_end});
                    const bool same_bounds = pa.y_begin == pb.y_begin && pa.y_end == pb.y_end && pa.x_begin == pb.x_begin && pa.x_end == pb.x_end;

                    if (x_begin < x_end && y_begin < y_end) {
                        const __m256 Aa = _mm256_set1_ps(pa.A), Ba = _mm256_set1_ps(pa.B), Ca = _mm256_set1_ps(pa.C), Da = _mm256_set1_ps(pa.D);
                        const __m256 Ab = _mm256_set1_ps(pb.A), Bb = _mm256_set1_ps(pb.B), Cb = _mm256_set1_ps(pb.C), Db = _mm256_set1_ps(pb.D);
                        const int x_chan_begin = (x_begin - tx) * 3, x_chan_stop = (x_end - tx) * 3;
                        const size_t row_stride = W * 3;
                        const bool aligned_path = ((reinterpret_cast<uintptr_t>(tile_base) & 31u) == 0) && ((x_chan_begin & 7u) == 0u);

                        if (i + 3 < Np) {
                            const SubParams& na = plist[i + 2]; const SubParams& nb = plist[i + 3];
                            int py = std::max({ty, na.y_begin, nb.y_begin}), px = std::max({tx, na.x_begin, nb.x_begin}), pxe = std::min({tile_x_end, na.x_end, nb.x_end});
                            if (px < pxe) {
                                _mm_prefetch(reinterpret_cast<const char*>(na.SUB + ((py + na.sy) * W + (px + na.sx)) * 3), _MM_HINT_T1);
                                _mm_prefetch(reinterpret_cast<const char*>(nb.SUB + ((py + nb.sy) * W + (px + nb.sx)) * 3), _MM_HINT_T1);
                            }
                        }

                        for (int y = y_begin; y + 1 < y_end; y += 2) {
                            size_t ar0 = ((y + pa.sy) * W + (x_begin + pa.sx)) * 3, ar1 = ar0 + row_stride, ar2 = ar1 + row_stride;
                            size_t br0 = ((y + pb.sy) * W + (x_begin + pb.sx)) * 3, br1 = br0 + row_stride, br2 = br1 + row_stride;
                            float* __restrict vp0 = tile_base + (y - ty) * tile_w * 3 + x_chan_begin;
                            float* __restrict vp1 = vp0 + tile_w * 3;
                            int x = x_chan_begin;

                            for (; x + 32 <= x_chan_stop; x += 32) {
                                __m256 a0L0, a0H0, a1L0, a1H0, a0L1, a0H1, a1L1, a1H1;
                                if (aligned_path) {
                                    a0L0 = _mm256_load_ps(vp0); a0H0 = _mm256_load_ps(vp0 + 8); a0L1 = _mm256_load_ps(vp0 + 16); a0H1 = _mm256_load_ps(vp0 + 24);
                                    a1L0 = _mm256_load_ps(vp1); a1H0 = _mm256_load_ps(vp1 + 8); a1L1 = _mm256_load_ps(vp1 + 16); a1H1 = _mm256_load_ps(vp1 + 24);
                                } else {
                                    a0L0 = _mm256_loadu_ps(vp0); a0H0 = _mm256_loadu_ps(vp0 + 8); a0L1 = _mm256_loadu_ps(vp0 + 16); a0H1 = _mm256_loadu_ps(vp0 + 24);
                                    a1L0 = _mm256_loadu_ps(vp1); a1H0 = _mm256_loadu_ps(vp1 + 8); a1L1 = _mm256_loadu_ps(vp1 + 16); a1H1 = _mm256_loadu_ps(vp1 + 24);
                                }

                                fma_row_2w(pa.SUB, ar0, Aa, Ba, a0L0, a0H0); fma_row_4w(pa.SUB, ar1, Ca, Da, Aa, Ba, a0L0, a0H0, a1L0, a1H0); fma_row_2w(pa.SUB, ar2, Ca, Da, a1L0, a1H0);
                                fma_row_2w(pa.SUB, ar0 + 16, Aa, Ba, a0L1, a0H1); fma_row_4w(pa.SUB, ar1 + 16, Ca, Da, Aa, Ba, a0L1, a0H1, a1L1, a1H1); fma_row_2w(pa.SUB, ar2 + 16, Ca, Da, a1L1, a1H1);
                                fma_row_2w(pb.SUB, br0, Ab, Bb, a0L0, a0H0); fma_row_4w(pb.SUB, br1, Cb, Db, Ab, Bb, a0L0, a0H0, a1L0, a1H0); fma_row_2w(pb.SUB, br2, Cb, Db, a1L0, a1H0);
                                fma_row_2w(pb.SUB, br0 + 16, Ab, Bb, a0L1, a0H1); fma_row_4w(pb.SUB, br1 + 16, Cb, Db, Ab, Bb, a0L1, a0H1, a1L1, a1H1); fma_row_2w(pb.SUB, br2 + 16, Cb, Db, a1L1, a1H1);

                                if (aligned_path) {
                                    _mm256_store_ps(vp0, a0L0); _mm256_store_ps(vp0 + 8, a0H0); _mm256_store_ps(vp0 + 16, a0L1); _mm256_store_ps(vp0 + 24, a0H1);
                                    _mm256_store_ps(vp1, a1L0); _mm256_store_ps(vp1 + 8, a1H0); _mm256_store_ps(vp1 + 16, a1L1); _mm256_store_ps(vp1 + 24, a1H1);
                                } else {
                                    _mm256_storeu_ps(vp0, a0L0); _mm256_storeu_ps(vp0 + 8, a0H0); _mm256_storeu_ps(vp0 + 16, a0L1); _mm256_storeu_ps(vp0 + 24, a0H1);
                                    _mm256_storeu_ps(vp1, a1L0); _mm256_storeu_ps(vp1 + 8, a1H0); _mm256_storeu_ps(vp1 + 16, a1L1); _mm256_storeu_ps(vp1 + 24, a1H1);
                                }

                                vp0 += 32; vp1 += 32; ar0 += 32; ar1 += 32; ar2 += 32; br0 += 32; br1 += 32; br2 += 32;
                            }

                            for (; x + 16 <= x_chan_stop; x += 16) {
                                __m256 a0L = _mm256_loadu_ps(vp0), a0H = _mm256_loadu_ps(vp0 + 8), a1L = _mm256_loadu_ps(vp1), a1H = _mm256_loadu_ps(vp1 + 8);
                                fma_row_2w(pa.SUB, ar0, Aa, Ba, a0L, a0H); fma_row_4w(pa.SUB, ar1, Ca, Da, Aa, Ba, a0L, a0H, a1L, a1H); fma_row_2w(pa.SUB, ar2, Ca, Da, a1L, a1H);
                                fma_row_2w(pb.SUB, br0, Ab, Bb, a0L, a0H); fma_row_4w(pb.SUB, br1, Cb, Db, Ab, Bb, a0L, a0H, a1L, a1H); fma_row_2w(pb.SUB, br2, Cb, Db, a1L, a1H);
                                _mm256_storeu_ps(vp0, a0L); _mm256_storeu_ps(vp0 + 8, a0H); _mm256_storeu_ps(vp1, a1L); _mm256_storeu_ps(vp1 + 8, a1H);
                                vp0 += 16; vp1 += 16; ar0 += 16; ar1 += 16; ar2 += 16; br0 += 16; br1 += 16; br2 += 16;
                            }

                            for (; x < x_chan_stop; ++x) {
                                float ar0l = pa.SUB[ar0], ar0r = pa.SUB[ar0 + 3], ar1l = pa.SUB[ar1], ar1r = pa.SUB[ar1 + 3], ar2l = pa.SUB[ar2], ar2r = pa.SUB[ar2 + 3];
                                float br0l = pb.SUB[br0], br0r = pb.SUB[br0 + 3], br1l = pb.SUB[br1], br1r = pb.SUB[br1 + 3], br2l = pb.SUB[br2], br2r = pb.SUB[br2 + 3];
                                *vp0 += pa.A * ar0l + pa.B * ar0r + pa.C * ar1l + pa.D * ar1r + pb.A * br0l + pb.B * br0r + pb.C * br1l + pb.D * br1r;
                                *vp1 += pa.A * ar1l + pa.B * ar1r + pa.C * ar2l + pa.D * ar2r + pb.A * br1l + pb.B * br1r + pb.C * br2l + pb.D * br2r;
                                ++vp0; ++vp1; ++ar0; ++ar1; ++ar2; ++br0; ++br1; ++br2;
                            }
                        }

                        if ((y_end - y_begin) & 1) {
                            int y = y_end - 1;
                            size_t ar0 = ((y + pa.sy) * W + (x_begin + pa.sx)) * 3, ar1 = ar0 + row_stride;
                            size_t br0 = ((y + pb.sy) * W + (x_begin + pb.sx)) * 3, br1 = br0 + row_stride;
                            float* __restrict vp0 = tile_base + (y - ty) * tile_w * 3 + x_chan_begin;
                            for (int x = x_chan_begin; x < x_chan_stop; ++x) {
                                float ar0l = pa.SUB[ar0], ar0r = pa.SUB[ar0 + 3], ar1l = pa.SUB[ar1], ar1r = pa.SUB[ar1 + 3];
                                float br0l = pb.SUB[br0], br0r = pb.SUB[br0 + 3], br1l = pb.SUB[br1], br1r = pb.SUB[br1 + 3];
                                *vp0 += pa.A * ar0l + pa.B * ar0r + pa.C * ar1l + pa.D * ar1r + pb.A * br0l + pb.B * br0r + pb.C * br1l + pb.D * br1r;
                                ++vp0; ++ar0; ++ar1; ++br0; ++br1;
                            }
                        }
                    }

                    if (!same_bounds && (x_begin >= x_end || y_begin >= y_end)) { do_single_sub(pa); do_single_sub(pb); }
                }

                if (i < Np) do_single_sub(plist[i]);
            }

            for (size_t f = 0; f < NF; ++f) {
                const float* __restrict vbase = tile_buf.data() + f * tile_floats;
                const int* __restrict cbase = counts.data() + f * W * H;
                for (int y = ty; y < tile_y_end; ++y) {
                    const float* vp = vbase + (y - ty) * tile_w * 3;
                    unsigned char* outp = results[f].data.data() + (y * W + tx) * 3;
                    for (int x = 0; x < tile_w; ++x) {
                        int c = cbase[y * w + (tx + x)];
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
