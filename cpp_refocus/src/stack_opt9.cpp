#include "refocus_stack.hpp"
#include "refocus.hpp"
#include "utils.hpp"

#include <algorithm>
#include <cmath>
#include <cstdint>
#include <cstdlib>
#include <immintrin.h>
#include <new>
#include <vector>

/*
 * List of Optimizations:
 *   - all from single focus value up to opt8:
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
 *       - same-bounds buckets
 *       - 4-row vertical-reuse AVX2 pair kernel
 *       - x-loop unrolled by two 16-float chunks in the pair kernel
 *       - reciprocal-count table and fast positive float-to-byte rounding
 */

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
        const size_t bytes = ((want * sizeof(float) + 63u) / 64u) * 64u;
        p = static_cast<float*>(std::aligned_alloc(64u, bytes));
        if (!p) throw std::bad_alloc{};
        n = bytes / sizeof(float);
    }

    ~AlignedFloatBuf() { if (p) std::free(p); }
    float* data() noexcept { return p; }
    const float* data() const noexcept { return p; }
};

constexpr int TILE_H = 8;
constexpr int TILE_W = 2032;

static inline bool same_bounds(const SubParams& a, const SubParams& b) {
    return a.x_begin == b.x_begin && a.x_end == b.x_end &&
           a.y_begin == b.y_begin && a.y_end == b.y_end;
}

static inline bool bounds_less(const SubParams& a, const SubParams& b) {
    if (a.y_begin != b.y_begin) return a.y_begin < b.y_begin;
    if (a.y_end != b.y_end) return a.y_end < b.y_end;
    if (a.x_begin != b.x_begin) return a.x_begin < b.x_begin;
    return a.x_end < b.x_end;
}

static inline unsigned char to_u8_positive(float v) {
    int x = static_cast<int>(v + 0.5f);
    return static_cast<unsigned char>(x > 255 ? 255 : x);
}

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
    acc0L = _mm256_fmadd_ps(cL, t, acc0L);
    acc1L = _mm256_fmadd_ps(aL, t, acc1L);
    t = load_cvt8(SUB + base + 8);
    acc0H = _mm256_fmadd_ps(cL, t, acc0H);
    acc1H = _mm256_fmadd_ps(aL, t, acc1H);
    t = load_cvt8(SUB + base + 3);
    acc0L = _mm256_fmadd_ps(cR, t, acc0L);
    acc1L = _mm256_fmadd_ps(aR, t, acc1L);
    t = load_cvt8(SUB + base + 11);
    acc0H = _mm256_fmadd_ps(cR, t, acc0H);
    acc1H = _mm256_fmadd_ps(aR, t, acc1H);
}

static inline void fma_sub_y4(const unsigned char* __restrict SUB,
                              size_t r0, size_t r1, size_t r2, size_t r3, size_t r4,
                              __m256 A, __m256 B, __m256 C, __m256 D,
                              __m256& a0L, __m256& a0H,
                              __m256& a1L, __m256& a1H,
                              __m256& a2L, __m256& a2H,
                              __m256& a3L, __m256& a3H) {
    fma_row_2w(SUB, r0, A, B, a0L, a0H);
    fma_row_4w(SUB, r1, C, D, A, B, a0L, a0H, a1L, a1H);
    fma_row_4w(SUB, r2, C, D, A, B, a1L, a1H, a2L, a2H);
    fma_row_4w(SUB, r3, C, D, A, B, a2L, a2H, a3L, a3H);
    fma_row_2w(SUB, r4, C, D, a3L, a3H);
}

static inline void add_single_scalar_2rows(const SubParams& p, size_t& r0, size_t& r1, size_t& r2, float*& vp0, float*& vp1) {
    const float r0l = p.SUB[r0], r0r = p.SUB[r0 + 3];
    const float r1l = p.SUB[r1], r1r = p.SUB[r1 + 3];
    const float r2l = p.SUB[r2], r2r = p.SUB[r2 + 3];
    *vp0 += p.A * r0l + p.B * r0r + p.C * r1l + p.D * r1r;
    *vp1 += p.A * r1l + p.B * r1r + p.C * r2l + p.D * r2r;
    ++r0;
    ++r1;
    ++r2;
    ++vp0;
    ++vp1;
}

static inline void add_single_scalar_1row(const SubParams& p, size_t& r0, size_t& r1, float*& vp) {
    const float r0l = p.SUB[r0], r0r = p.SUB[r0 + 3];
    const float r1l = p.SUB[r1], r1r = p.SUB[r1 + 3];
    *vp += p.A * r0l + p.B * r0r + p.C * r1l + p.D * r1r;
    ++r0;
    ++r1;
    ++vp;
}

static inline void add_pair_scalar_y4(const SubParams& pa, const SubParams& pb,
                                      size_t& ar0, size_t& ar1, size_t& ar2, size_t& ar3, size_t& ar4,
                                      size_t& br0, size_t& br1, size_t& br2, size_t& br3, size_t& br4,
                                      float*& vp0, float*& vp1, float*& vp2, float*& vp3) {
    const float ar0l = pa.SUB[ar0], ar0r = pa.SUB[ar0 + 3];
    const float ar1l = pa.SUB[ar1], ar1r = pa.SUB[ar1 + 3];
    const float ar2l = pa.SUB[ar2], ar2r = pa.SUB[ar2 + 3];
    const float ar3l = pa.SUB[ar3], ar3r = pa.SUB[ar3 + 3];
    const float ar4l = pa.SUB[ar4], ar4r = pa.SUB[ar4 + 3];
    const float br0l = pb.SUB[br0], br0r = pb.SUB[br0 + 3];
    const float br1l = pb.SUB[br1], br1r = pb.SUB[br1 + 3];
    const float br2l = pb.SUB[br2], br2r = pb.SUB[br2 + 3];
    const float br3l = pb.SUB[br3], br3r = pb.SUB[br3 + 3];
    const float br4l = pb.SUB[br4], br4r = pb.SUB[br4 + 3];
    *vp0 += pa.A * ar0l + pa.B * ar0r + pa.C * ar1l + pa.D * ar1r + pb.A * br0l + pb.B * br0r + pb.C * br1l + pb.D * br1r;
    *vp1 += pa.A * ar1l + pa.B * ar1r + pa.C * ar2l + pa.D * ar2r + pb.A * br1l + pb.B * br1r + pb.C * br2l + pb.D * br2r;
    *vp2 += pa.A * ar2l + pa.B * ar2r + pa.C * ar3l + pa.D * ar3r + pb.A * br2l + pb.B * br2r + pb.C * br3l + pb.D * br3r;
    *vp3 += pa.A * ar3l + pa.B * ar3r + pa.C * ar4l + pa.D * ar4r + pb.A * br3l + pb.B * br3r + pb.C * br4l + pb.D * br4r;
    ++ar0;
    ++ar1;
    ++ar2;
    ++ar3;
    ++ar4;
    ++br0;
    ++br1;
    ++br2;
    ++br3;
    ++br4;
    ++vp0;
    ++vp1;
    ++vp2;
    ++vp3;
}

template <bool Aligned>
static inline __m256 load_acc(const float* p) {
    if constexpr (Aligned) {
        return _mm256_load_ps(p);
    } else {
        return _mm256_loadu_ps(p);
    }
}

template <bool Aligned>
static inline void store_acc(float* p, __m256 v) {
    if constexpr (Aligned) {
        _mm256_store_ps(p, v);
    } else {
        _mm256_storeu_ps(p, v);
    }
}

template <bool Aligned>
static inline void process_pair_y4_chunk(const SubParams& pa,
                                         const SubParams& pb,
                                         size_t& ar0, size_t& ar1, size_t& ar2, size_t& ar3, size_t& ar4,
                                         size_t& br0, size_t& br1, size_t& br2, size_t& br3, size_t& br4,
                                         __m256 Aa, __m256 Ba, __m256 Ca, __m256 Da,
                                         __m256 Ab, __m256 Bb, __m256 Cb, __m256 Db,
                                         float*& vp0, float*& vp1, float*& vp2, float*& vp3) {
    __m256 a0L = load_acc<Aligned>(vp0);
    __m256 a0H = load_acc<Aligned>(vp0 + 8);
    __m256 a1L = load_acc<Aligned>(vp1);
    __m256 a1H = load_acc<Aligned>(vp1 + 8);
    __m256 a2L = load_acc<Aligned>(vp2);
    __m256 a2H = load_acc<Aligned>(vp2 + 8);
    __m256 a3L = load_acc<Aligned>(vp3);
    __m256 a3H = load_acc<Aligned>(vp3 + 8);
    fma_sub_y4(pa.SUB, ar0, ar1, ar2, ar3, ar4, Aa, Ba, Ca, Da, a0L, a0H, a1L, a1H, a2L, a2H, a3L, a3H);
    fma_sub_y4(pb.SUB, br0, br1, br2, br3, br4, Ab, Bb, Cb, Db, a0L, a0H, a1L, a1H, a2L, a2H, a3L, a3H);
    store_acc<Aligned>(vp0, a0L);
    store_acc<Aligned>(vp0 + 8, a0H);
    store_acc<Aligned>(vp1, a1L);
    store_acc<Aligned>(vp1 + 8, a1H);
    store_acc<Aligned>(vp2, a2L);
    store_acc<Aligned>(vp2 + 8, a2H);
    store_acc<Aligned>(vp3, a3L);
    store_acc<Aligned>(vp3 + 8, a3H);
    vp0 += 16;
    vp1 += 16;
    vp2 += 16;
    vp3 += 16;
    ar0 += 16;
    ar1 += 16;
    ar2 += 16;
    ar3 += 16;
    ar4 += 16;
    br0 += 16;
    br1 += 16;
    br2 += 16;
    br3 += 16;
    br4 += 16;
}

template <bool Aligned>
static inline void process_pair_y4_xloop(const SubParams& pa,
                                         const SubParams& pb,
                                         int x_chan_begin,
                                         int x_chan_stop,
                                         size_t& ar0, size_t& ar1, size_t& ar2, size_t& ar3, size_t& ar4,
                                         size_t& br0, size_t& br1, size_t& br2, size_t& br3, size_t& br4,
                                         __m256 Aa, __m256 Ba, __m256 Ca, __m256 Da,
                                         __m256 Ab, __m256 Bb, __m256 Cb, __m256 Db,
                                         float*& vp0, float*& vp1, float*& vp2, float*& vp3) {
    int x = x_chan_begin;
    for (; x + 32 <= x_chan_stop; x += 32) {
        process_pair_y4_chunk<Aligned>(pa, pb, ar0, ar1, ar2, ar3, ar4, br0, br1, br2, br3, br4, Aa, Ba, Ca, Da, Ab, Bb, Cb, Db, vp0, vp1, vp2, vp3);
        process_pair_y4_chunk<Aligned>(pa, pb, ar0, ar1, ar2, ar3, ar4, br0, br1, br2, br3, br4, Aa, Ba, Ca, Da, Ab, Bb, Cb, Db, vp0, vp1, vp2, vp3);
    }
    for (; x + 16 <= x_chan_stop; x += 16) {
        process_pair_y4_chunk<Aligned>(pa, pb, ar0, ar1, ar2, ar3, ar4, br0, br1, br2, br3, br4, Aa, Ba, Ca, Da, Ab, Bb, Cb, Db, vp0, vp1, vp2, vp3);
    }
    for (; x < x_chan_stop; ++x) {
        add_pair_scalar_y4(pa, pb, ar0, ar1, ar2, ar3, ar4, br0, br1, br2, br3, br4, vp0, vp1, vp2, vp3);
    }
}

static inline void process_single_sub_range(const SubParams& p,
                                            int y_begin, int y_end,
                                            int x_begin, int x_end,
                                            int tx, int ty, int tile_w,
                                            size_t W,
                                            float* __restrict tile_base) {
    if (x_begin >= x_end || y_begin >= y_end) return;

    const __m256 Av = _mm256_set1_ps(p.A);
    const __m256 Bv = _mm256_set1_ps(p.B);
    const __m256 Cv = _mm256_set1_ps(p.C);
    const __m256 Dv = _mm256_set1_ps(p.D);
    const int x_chan_begin = (x_begin - tx) * 3;
    const int x_chan_stop = (x_end - tx) * 3;
    const size_t row_stride = W * 3;

    int y = y_begin;
    for (; y + 1 < y_end; y += 2) {
        size_t r0 = (static_cast<size_t>(y + p.sy) * W + static_cast<size_t>(x_begin + p.sx)) * 3;
        size_t r1 = r0 + row_stride;
        size_t r2 = r1 + row_stride;
        float* vp0 = tile_base + (y - ty) * tile_w * 3 + x_chan_begin;
        float* vp1 = vp0 + tile_w * 3;
        int x = x_chan_begin;
        for (; x + 16 <= x_chan_stop; x += 16) {
            __m256 acc0L = _mm256_loadu_ps(vp0);
            __m256 acc0H = _mm256_loadu_ps(vp0 + 8);
            __m256 acc1L = _mm256_loadu_ps(vp1);
            __m256 acc1H = _mm256_loadu_ps(vp1 + 8);
            fma_row_2w(p.SUB, r0, Av, Bv, acc0L, acc0H);
            fma_row_4w(p.SUB, r1, Cv, Dv, Av, Bv, acc0L, acc0H, acc1L, acc1H);
            fma_row_2w(p.SUB, r2, Cv, Dv, acc1L, acc1H);
            _mm256_storeu_ps(vp0, acc0L);
            _mm256_storeu_ps(vp0 + 8, acc0H);
            _mm256_storeu_ps(vp1, acc1L);
            _mm256_storeu_ps(vp1 + 8, acc1H);
            vp0 += 16;
            vp1 += 16;
            r0 += 16;
            r1 += 16;
            r2 += 16;
        }
        for (; x < x_chan_stop; ++x) {
            add_single_scalar_2rows(p, r0, r1, r2, vp0, vp1);
        }
    }

    if (y < y_end) {
        size_t r0 = (static_cast<size_t>(y + p.sy) * W + static_cast<size_t>(x_begin + p.sx)) * 3;
        size_t r1 = r0 + row_stride;
        float* vp = tile_base + (y - ty) * tile_w * 3 + x_chan_begin;
        for (int x = x_chan_begin; x < x_chan_stop; ++x) {
            add_single_scalar_1row(p, r0, r1, vp);
        }
    }
}

static inline void process_single_sub(const SubParams& p,
                                      int ty, int tile_y_end,
                                      int tx, int tile_x_end,
                                      int tile_w,
                                      size_t W,
                                      float* __restrict tile_base) {
    const int y_begin = std::max(ty, p.y_begin);
    const int y_end = std::min(tile_y_end, p.y_end);
    const int x_begin = std::max(tx, p.x_begin);
    const int x_end = std::min(tile_x_end, p.x_end);
    process_single_sub_range(p, y_begin, y_end, x_begin, x_end, tx, ty, tile_w, W, tile_base);
}

static inline void process_pair_same_bounds_y4(const SubParams& pa,
                                               const SubParams& pb,
                                               int ty, int tile_y_end,
                                               int tx, int tile_x_end,
                                               int tile_w,
                                               size_t W,
                                               float* __restrict tile_base) {
    const int y_begin = std::max(ty, pa.y_begin);
    const int y_end = std::min(tile_y_end, pa.y_end);
    const int x_begin = std::max(tx, pa.x_begin);
    const int x_end = std::min(tile_x_end, pa.x_end);
    if (x_begin >= x_end || y_begin >= y_end) return;

    const __m256 Aa = _mm256_set1_ps(pa.A);
    const __m256 Ba = _mm256_set1_ps(pa.B);
    const __m256 Ca = _mm256_set1_ps(pa.C);
    const __m256 Da = _mm256_set1_ps(pa.D);
    const __m256 Ab = _mm256_set1_ps(pb.A);
    const __m256 Bb = _mm256_set1_ps(pb.B);
    const __m256 Cb = _mm256_set1_ps(pb.C);
    const __m256 Db = _mm256_set1_ps(pb.D);
    const int x_chan_begin = (x_begin - tx) * 3;
    const int x_chan_stop = (x_end - tx) * 3;
    const int tile_stride = tile_w * 3;
    const size_t row_stride = W * 3;
    const bool aligned_path = ((reinterpret_cast<uintptr_t>(tile_base) & 31u) == 0u) && ((x_chan_begin & 7) == 0) && ((tile_stride & 7) == 0);

    int y = y_begin;
    for (; y + 3 < y_end; y += 4) {
        size_t ar0 = (static_cast<size_t>(y + pa.sy) * W + static_cast<size_t>(x_begin + pa.sx)) * 3;
        size_t ar1 = ar0 + row_stride;
        size_t ar2 = ar1 + row_stride;
        size_t ar3 = ar2 + row_stride;
        size_t ar4 = ar3 + row_stride;
        size_t br0 = (static_cast<size_t>(y + pb.sy) * W + static_cast<size_t>(x_begin + pb.sx)) * 3;
        size_t br1 = br0 + row_stride;
        size_t br2 = br1 + row_stride;
        size_t br3 = br2 + row_stride;
        size_t br4 = br3 + row_stride;
        float* vp0 = tile_base + (y - ty) * tile_stride + x_chan_begin;
        float* vp1 = vp0 + tile_stride;
        float* vp2 = vp1 + tile_stride;
        float* vp3 = vp2 + tile_stride;
        if (aligned_path) {
            process_pair_y4_xloop<true>(pa, pb, x_chan_begin, x_chan_stop, ar0, ar1, ar2, ar3, ar4, br0, br1, br2, br3, br4, Aa, Ba, Ca, Da, Ab, Bb, Cb, Db, vp0, vp1, vp2, vp3);
        } else {
            process_pair_y4_xloop<false>(pa, pb, x_chan_begin, x_chan_stop, ar0, ar1, ar2, ar3, ar4, br0, br1, br2, br3, br4, Aa, Ba, Ca, Da, Ab, Bb, Cb, Db, vp0, vp1, vp2, vp3);
        }
    }

    if (y < y_end) {
        process_single_sub_range(pa, y, y_end, x_begin, x_end, tx, ty, tile_w, W, tile_base);
        process_single_sub_range(pb, y, y_end, x_begin, x_end, tx, ty, tile_w, W, tile_base);
    }
}

}

std::vector<ImageData> refocus_shift_and_sum_stack(std::vector<SubApertureImage>& subapertures, const std::vector<float>& focuses) {
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
            const float shift_x = focuses[f] * sub.u;
            const float shift_y = focuses[f] * sub.v;
            p.sx = static_cast<int>(std::floor(shift_x));
            p.sy = static_cast<int>(std::floor(shift_y));
            const float dx = shift_x - p.sx;
            const float dy = shift_y - p.sy;
            p.A = (1.0f - dx) * (1.0f - dy);
            p.B = dx * (1.0f - dy);
            p.C = (1.0f - dx) * dy;
            p.D = dx * dy;
            p.x_begin = std::max(0, -p.sx);
            p.x_end = std::min(w, w - p.sx - 1);
            p.y_begin = std::max(0, -p.sy);
            p.y_end = std::min(h, h - p.sy - 1);
            p.SUB = sub.data.data.data();
            if (p.x_begin < p.x_end && p.y_begin < p.y_end) params[f].push_back(p);
        }
        std::stable_sort(params[f].begin(), params[f].end(), bounds_less);
    }

    std::vector<int> counts(NF * W * H, 0);
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
            int* __restrict cb = counts.data() + f * W * H;
            int row = 0;
            const int* __restrict first_diff = diff.data();
            for (int x = 0; x < w; ++x) {
                row += first_diff[x];
                cb[x] = row;
            }
            for (int y = 1; y < h; ++y) {
                row = 0;
                const int* __restrict diff_row = diff.data() + static_cast<size_t>(y) * (W + 1);
                const int* __restrict prev = cb + static_cast<size_t>(y - 1) * W;
                int* __restrict out = cb + static_cast<size_t>(y) * W;
                for (int x = 0; x < w; ++x) {
                    row += diff_row[x];
                    out[x] = row + prev[x];
                }
            }
        }
    }

    std::vector<float> inv_counts(subapertures.size() + 1, 0.0f);
    for (size_t i = 1; i < inv_counts.size(); ++i) inv_counts[i] = 1.0f / static_cast<float>(i);

    std::vector<ImageData> results(NF);
    for (size_t f = 0; f < NF; ++f) {
        results[f].width = W;
        results[f].height = H;
        results[f].data.assign(W * H * 3, 0);
    }

    AlignedFloatBuf tile_buf;
    tile_buf.resize(static_cast<size_t>(NF) * TILE_H * TILE_W * 3);

    for (int ty = 0; ty < h; ty += TILE_H) {
        const int tile_y_end = std::min(ty + TILE_H, h);
        const int tile_h = tile_y_end - ty;
        for (int tx = 0; tx < w; tx += TILE_W) {
            const int tile_x_end = std::min(tx + TILE_W, w);
            const int tile_w = tile_x_end - tx;
            const int tile_floats = tile_h * tile_w * 3;
            std::fill(tile_buf.data(), tile_buf.data() + static_cast<size_t>(NF) * tile_floats, 0.0f);

            for (size_t f = 0; f < NF; ++f) {
                float* __restrict tile_base = tile_buf.data() + f * tile_floats;
                const auto& plist = params[f];
                const size_t Np = plist.size();
                size_t i = 0;
                while (i < Np) {
                    size_t j = i + 1;
                    while (j < Np && same_bounds(plist[i], plist[j])) ++j;
                    size_t k = i;
                    for (; k + 1 < j; k += 2) {
                        process_pair_same_bounds_y4(plist[k], plist[k + 1], ty, tile_y_end, tx, tile_x_end, tile_w, W, tile_base);
                    }
                    if (k < j) {
                        process_single_sub(plist[k], ty, tile_y_end, tx, tile_x_end, tile_w, W, tile_base);
                    }
                    i = j;
                }
            }

            for (size_t f = 0; f < NF; ++f) {
                const float* __restrict vbase = tile_buf.data() + f * tile_floats;
                const int* __restrict cbase = counts.data() + f * W * H;
                for (int y = ty; y < tile_y_end; ++y) {
                    const float* __restrict vp = vbase + (y - ty) * tile_w * 3;
                    unsigned char* __restrict outp = results[f].data.data() + (static_cast<size_t>(y) * W + tx) * 3;
                    const int* __restrict cp = cbase + static_cast<size_t>(y) * W + tx;
                    for (int x = 0; x < tile_w; ++x) {
                        const int c = cp[x];
                        if (c == 0) continue;
                        const float inv_c = inv_counts[c];
                        const int xo = x * 3;
                        outp[xo] = to_u8_positive(vp[xo] * inv_c);
                        outp[xo + 1] = to_u8_positive(vp[xo + 1] * inv_c);
                        outp[xo + 2] = to_u8_positive(vp[xo + 2] * inv_c);
                    }
                }
            }
        }
    }

    return results;
}
