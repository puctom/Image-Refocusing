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
*       - tile the value accumulator across row bands to improve cache reuse
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

    const int TILE_H = 8;
    std::vector<float> tile_vals(static_cast<size_t>(TILE_H) * width * 3);

    for (int ty = 0; ty < h; ty += TILE_H) {
        const int tile_y_end = std::min(ty + TILE_H, h);
        const int tile_h = tile_y_end - ty;

        std::fill(tile_vals.begin(), tile_vals.begin() + static_cast<size_t>(tile_h) * width * 3, 0.0f);

        for (const SubParams& p : params) {
            const int y_begin = std::max(ty, p.y_begin);
            const int y_end = std::min(tile_y_end, p.y_end);
            if (y_begin >= y_end) continue;

            for (int y = y_begin; y < y_end; ++y) {
                // Prime the "left column" with x = x_begin.
                size_t ind_top = ((y + p.sy) * width + (p.x_begin + p.sx)) * 3;
                size_t ind_bot = ind_top + width * 3;

                float pTLr = p.data[ind_top];
                float pTLg = p.data[ind_top + 1];
                float pTLb = p.data[ind_top + 2];

                float pBLr = p.data[ind_bot];
                float pBLg = p.data[ind_bot + 1];
                float pBLb = p.data[ind_bot + 2];

                float* tile_row = tile_vals.data()
                    + (static_cast<size_t>(y - ty) * width + static_cast<size_t>(p.x_begin)) * 3;

                for (int x = p.x_begin; x < p.x_end; ++x) {
                    // Load only the right column (the new pixels for this x).
                    const size_t ind_top_r = ((y + p.sy) * width + (x + p.sx + 1)) * 3;
                    const size_t ind_bot_r = ind_top_r + width * 3;

                    const float pTRr = p.data[ind_top_r];
                    const float pTRg = p.data[ind_top_r + 1];
                    const float pTRb = p.data[ind_top_r + 2];

                    const float pBRr = p.data[ind_bot_r];
                    const float pBRg = p.data[ind_bot_r + 1];
                    const float pBRb = p.data[ind_bot_r + 2];

                    tile_row[0] += p.A*pTLr + p.B*pTRr + p.C*pBLr + p.D*pBRr;
                    tile_row[1] += p.A*pTLg + p.B*pTRg + p.C*pBLg + p.D*pBRg;
                    tile_row[2] += p.A*pTLb + p.B*pTRb + p.C*pBLb + p.D*pBRb;

                    // Right column becomes left column for next iteration.
                    pTLr = pTRr; pTLg = pTRg; pTLb = pTRb;
                    pBLr = pBRr; pBLg = pBRg; pBLb = pBRb;
                    tile_row += 3;
                }
            }
        }

        for (int y = ty; y < tile_y_end; ++y) {
            const float* tile_row = tile_vals.data() + static_cast<size_t>(y - ty) * width * 3;
            for (int x = 0; x < w; ++x) {
                const int c = counts[static_cast<size_t>(y) * width + static_cast<size_t>(x)];
                if (c == 0) continue;

                const size_t tile_idx = static_cast<size_t>(x) * 3;
                // scale_round_clamp inlining
                output.at(x, y, 0) = (unsigned char) std::clamp(std::round(tile_row[tile_idx]     / c), 0.0f, 255.0f);
                output.at(x, y, 1) = (unsigned char) std::clamp(std::round(tile_row[tile_idx + 1] / c), 0.0f, 255.0f);
                output.at(x, y, 2) = (unsigned char) std::clamp(std::round(tile_row[tile_idx + 2] / c), 0.0f, 255.0f);
            }
        }
    }

    return output;
}
