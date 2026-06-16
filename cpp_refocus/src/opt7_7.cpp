#include "refocus.hpp"
#include "utils.hpp"
#include <vector>
#include <cmath>
#include <algorithm>

/*
*   List of Optimizations:
*       - Change the loop order to [Subaperture, y, x] for improved locality
*       - Common subexpression elimination
*       - use better bounds for the x-y loops
*       - use unchecked array access
*       - function inlining
*       - unroll channel loop to expose independent scalar ops for ILP
*       - reduce number of loads in innermost loop
*       - calculate counts using a 2D difference array and prefix sums
*       - force source-level 4-FMA accumulation and unroll inner x loop by 2
*       - tile output rows so accumulation stays in private cache
* */

namespace {
struct SubParams {
    int sx, sy;
    float A, B, C, D;
    int x_begin, x_end, y_begin, y_end;
    const unsigned char* data;
};
}

ImageData refocus_shift_and_sum(std::vector<SubApertureImage>& subapertures, float focus) {
    const size_t width = subapertures.front().data.width;
    const size_t height = subapertures.front().data.height;
    const int w = static_cast<int>(width);
    const int h = static_cast<int>(height);

    ImageData output;
    output.width = width;
    output.height = height;
    output.data.assign(width * height * 3, 0);

    std::vector<SubParams> params;
    params.reserve(subapertures.size());

    for (SubApertureImage& sub : subapertures) {
        const float shift_x = focus * sub.u;
        const float shift_y = focus * sub.v;

        SubParams p;
        p.sx = std::floor(shift_x);
        p.sy = std::floor(shift_y);

        const float dx = shift_x - p.sx;
        const float dy = shift_y - p.sy;

        p.A = (1 - dx) * (1 - dy);
        p.B = dx * (1 - dy);
        p.C = (1 - dx) * dy;
        p.D = dx * dy;

        p.x_begin = std::max(0, -p.sx);
        p.x_end = std::min(w, w - p.sx - 1);
        p.y_begin = std::max(0, -p.sy);
        p.y_end = std::min(h, h - p.sy - 1);
        p.data = sub.data.data.data();

        if (p.x_begin >= p.x_end || p.y_begin >= p.y_end) continue;
        params.push_back(p);
    }

    std::vector<int> counts(width * height, 0);
    std::vector<int> diff((width + 1) * (height + 1), 0);

    for (const SubParams& p : params) {
        diff[static_cast<size_t>(p.y_begin) * (width + 1) + p.x_begin] += 1;
        diff[static_cast<size_t>(p.y_begin) * (width + 1) + p.x_end] -= 1;
        diff[static_cast<size_t>(p.y_end) * (width + 1) + p.x_begin] -= 1;
        diff[static_cast<size_t>(p.y_end) * (width + 1) + p.x_end] += 1;
    }

    for (int y = 0; y < h; ++y) {
        int row = 0;
        for (int x = 0; x < w; ++x) {
            row += diff[static_cast<size_t>(y) * (width + 1) + x];
            counts[static_cast<size_t>(y) * width + x] =
                row + (y > 0 ? counts[static_cast<size_t>(y - 1) * width + x] : 0);
        }
    }

    // Minimal output-space tiling: keep the accumulation buffer for a few
    // output rows hot in private cache while all subapertures contribute.
    // This is intentionally full-width to keep the indexing simple and to
    // isolate the DRAM-OI effect of tiling the accumulation buffer.
    constexpr int TILE_H = 8;
    std::vector<float> tile_vals(static_cast<size_t>(TILE_H) * width * 3);

    for (int tile_y = 0; tile_y < h; tile_y += TILE_H) {
        const int tile_y_end = std::min(h, tile_y + TILE_H);
        const int tile_h = tile_y_end - tile_y;
        const size_t tile_size = static_cast<size_t>(tile_h) * width * 3;
        std::fill(tile_vals.begin(), tile_vals.begin() + tile_size, 0.0f);

        for (const SubParams& p : params) {
            const int y_start = std::max(p.y_begin, tile_y);
            const int y_stop = std::min(p.y_end, tile_y_end);
            if (y_start >= y_stop) continue;

            for (int y = y_start; y < y_stop; ++y) {
                // Prime the "left column" with x = x_begin.
                size_t ind_top = ((y + p.sy) * width + (p.x_begin + p.sx)) * 3;
                size_t ind_bot = ind_top + width * 3;

                float pTLr = p.data[ind_top];
                float pTLg = p.data[ind_top + 1];
                float pTLb = p.data[ind_top + 2];

                float pBLr = p.data[ind_bot];
                float pBLg = p.data[ind_bot + 1];
                float pBLb = p.data[ind_bot + 2];

                float* vals_row = tile_vals.data()
                    + (static_cast<size_t>(y - tile_y) * width + static_cast<size_t>(p.x_begin)) * 3;

                const unsigned char* top_right = p.data
                    + (((y + p.sy) * width + (p.x_begin + p.sx + 1)) * 3);
                const unsigned char* bot_right = top_right + width * 3;

                int x = p.x_begin;

                // Unroll by 2 pixels. This gives the scheduler six independent
                // scalar accumulation chains (2 pixels x RGB), while preserving
                // the converted-column reuse from opt7/opt7_5.
                for (; x + 1 < p.x_end; x += 2) {
                    // Pixel x: load the new right column.
                    const float pTR0r = top_right[0];
                    const float pTR0g = top_right[1];
                    const float pTR0b = top_right[2];

                    const float pBR0r = bot_right[0];
                    const float pBR0g = bot_right[1];
                    const float pBR0b = bot_right[2];

                    // Pixel x + 1: load the next right column.  The right column
                    // from pixel x is the left column for pixel x + 1.
                    const float pTR1r = top_right[3];
                    const float pTR1g = top_right[4];
                    const float pTR1b = top_right[5];

                    const float pBR1r = bot_right[3];
                    const float pBR1g = bot_right[4];
                    const float pBR1b = bot_right[5];

                    float acc0r = vals_row[0];
                    float acc0g = vals_row[1];
                    float acc0b = vals_row[2];

                    float acc1r = vals_row[3];
                    float acc1g = vals_row[4];
                    float acc1b = vals_row[5];

                    // Force the 4-FMA accumulator form.  The unroll exposes
                    // independent chains so the backend can issue FMAs on both FP
                    // pipes instead of creating a single expression tree per pixel.
                    acc0r = __builtin_fmaf(p.A, pTLr,  acc0r);
                    acc0g = __builtin_fmaf(p.A, pTLg,  acc0g);
                    acc0b = __builtin_fmaf(p.A, pTLb,  acc0b);
                    acc1r = __builtin_fmaf(p.A, pTR0r, acc1r);
                    acc1g = __builtin_fmaf(p.A, pTR0g, acc1g);
                    acc1b = __builtin_fmaf(p.A, pTR0b, acc1b);

                    acc0r = __builtin_fmaf(p.B, pTR0r, acc0r);
                    acc0g = __builtin_fmaf(p.B, pTR0g, acc0g);
                    acc0b = __builtin_fmaf(p.B, pTR0b, acc0b);
                    acc1r = __builtin_fmaf(p.B, pTR1r, acc1r);
                    acc1g = __builtin_fmaf(p.B, pTR1g, acc1g);
                    acc1b = __builtin_fmaf(p.B, pTR1b, acc1b);

                    acc0r = __builtin_fmaf(p.C, pBLr,  acc0r);
                    acc0g = __builtin_fmaf(p.C, pBLg,  acc0g);
                    acc0b = __builtin_fmaf(p.C, pBLb,  acc0b);
                    acc1r = __builtin_fmaf(p.C, pBR0r, acc1r);
                    acc1g = __builtin_fmaf(p.C, pBR0g, acc1g);
                    acc1b = __builtin_fmaf(p.C, pBR0b, acc1b);

                    acc0r = __builtin_fmaf(p.D, pBR0r, acc0r);
                    acc0g = __builtin_fmaf(p.D, pBR0g, acc0g);
                    acc0b = __builtin_fmaf(p.D, pBR0b, acc0b);
                    acc1r = __builtin_fmaf(p.D, pBR1r, acc1r);
                    acc1g = __builtin_fmaf(p.D, pBR1g, acc1g);
                    acc1b = __builtin_fmaf(p.D, pBR1b, acc1b);

                    vals_row[0] = acc0r;
                    vals_row[1] = acc0g;
                    vals_row[2] = acc0b;
                    vals_row[3] = acc1r;
                    vals_row[4] = acc1g;
                    vals_row[5] = acc1b;

                    // Advance the rolling left column to pixel x + 2.
                    pTLr = pTR1r; pTLg = pTR1g; pTLb = pTR1b;
                    pBLr = pBR1r; pBLg = pBR1g; pBLb = pBR1b;

                    vals_row += 6;
                    top_right += 6;
                    bot_right += 6;
                }

                // Scalar tail for an odd number of valid pixels in this row.
                for (; x < p.x_end; ++x) {
                    const float pTRr = top_right[0];
                    const float pTRg = top_right[1];
                    const float pTRb = top_right[2];

                    const float pBRr = bot_right[0];
                    const float pBRg = bot_right[1];
                    const float pBRb = bot_right[2];

                    float acc_r = vals_row[0];
                    float acc_g = vals_row[1];
                    float acc_b = vals_row[2];

                    acc_r = __builtin_fmaf(p.A, pTLr, acc_r);
                    acc_g = __builtin_fmaf(p.A, pTLg, acc_g);
                    acc_b = __builtin_fmaf(p.A, pTLb, acc_b);

                    acc_r = __builtin_fmaf(p.B, pTRr, acc_r);
                    acc_g = __builtin_fmaf(p.B, pTRg, acc_g);
                    acc_b = __builtin_fmaf(p.B, pTRb, acc_b);

                    acc_r = __builtin_fmaf(p.C, pBLr, acc_r);
                    acc_g = __builtin_fmaf(p.C, pBLg, acc_g);
                    acc_b = __builtin_fmaf(p.C, pBLb, acc_b);

                    acc_r = __builtin_fmaf(p.D, pBRr, acc_r);
                    acc_g = __builtin_fmaf(p.D, pBRg, acc_g);
                    acc_b = __builtin_fmaf(p.D, pBRb, acc_b);

                    vals_row[0] = acc_r;
                    vals_row[1] = acc_g;
                    vals_row[2] = acc_b;

                    pTLr = pTRr; pTLg = pTRg; pTLb = pTRb;
                    pBLr = pBRr; pBLg = pBRg; pBLb = pBRb;

                    vals_row += 3;
                    top_right += 3;
                    bot_right += 3;
                }
            }
        }

        // Finalize this tile immediately.  The global vals array is removed;
        // only this tile-sized buffer is divided by counts and written out.
        for (int y = tile_y; y < tile_y_end; ++y) {
            const float* vals_row = tile_vals.data() + static_cast<size_t>(y - tile_y) * width * 3;
            for (int x = 0; x < w; ++x) {
                const int c = counts[static_cast<size_t>(y) * width + x];
                if (c == 0) continue;

                const size_t local_idx = static_cast<size_t>(x) * 3;
                output.at(x, y, 0) = (unsigned char) std::clamp(std::round(vals_row[local_idx]     / c), 0.0f, 255.0f);
                output.at(x, y, 1) = (unsigned char) std::clamp(std::round(vals_row[local_idx + 1] / c), 0.0f, 255.0f);
                output.at(x, y, 2) = (unsigned char) std::clamp(std::round(vals_row[local_idx + 2] / c), 0.0f, 255.0f);
            }
        }
    }

    return output;
}
