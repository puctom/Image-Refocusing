#include "refocus_stack.hpp"
#include "refocus.hpp"
#include "utils.hpp"

#include <vector>
#include <cmath>
#include <algorithm>

struct RGB {
    float r;
    float g;
    float b;
};

/*
*   List of Optimizations:
*       - all from single focus value up to opt7:
    *       - Change the loop order to [Subaperture, y, x] for improved locality
    *       - Common subexpression elimination
    *       - use better bounds for the x-y loops
    *       - use unchecked array access
    *       - function inlining
    *       - unroll channel loop to expose independent scalar ops for ILP
    *       - reduce number of loads in innermost loop
* */


std::vector<ImageData> refocus_shift_and_sum_stack(std::vector<SubApertureImage> &subapertures, const std::vector<float>& focuses){
    const size_t W = subapertures.front().data.width;
    const size_t H = subapertures.front().data.height;
    const size_t NF = focuses.size();

    std::vector<std::vector<float>> vals(NF, std::vector<float>(W * H * 3, 0.0f));
    std::vector<std::vector<int16_t>> counts(NF, std::vector<int16_t>(W * H, 0));
    const int w = static_cast<int>(W);
    const int h = static_cast<int>(H);

    for (size_t s = 0; s < subapertures.size(); ++s) {
        const auto& sub = subapertures[s];

        for (size_t f = 0; f < NF; ++f) {
            const float shift_x = focuses[f] * sub.u;
            const float shift_y = focuses[f] * sub.v;

            const int sx = std::floor(shift_x);
            const int sy = std::floor(shift_y);
            const float dx = shift_x - sx;
            const float dy = shift_y - sy;

            const float A = (1 - dx) * (1 - dy);
            const float B = dx * (1 - dy);
            const float C = (1 - dx) * dy;
            const float D = dx * dy;

            const int x_begin = std::max(0, -sx);
            const int x_end = std::min(w, w - sx - 1);
            const int y_begin = std::max(0, -sy);
            const int y_end = std::min(h, h - sy - 1);

            if (x_begin >= x_end || y_begin >= y_end) continue;

            for (int y = y_begin; y < y_end; ++y) {
                size_t ind_top = ((y + sy) * W + (x_begin + sx)) * 3;
                size_t ind_bot = ind_top + W * 3;

                float pTLr = sub.data.data[ind_top];
                float pTLg = sub.data.data[ind_top + 1];
                float pTLb = sub.data.data[ind_top + 2];

                float pBLr = sub.data.data[ind_bot];
                float pBLg = sub.data.data[ind_bot + 1];
                float pBLb = sub.data.data[ind_bot + 2];

                for (int x = x_begin; x < x_end; ++x) {
                    const size_t ind_top_r = ((y + sy) * W + (x + sx + 1)) * 3;
                    const size_t ind_bot_r = ind_top_r + W * 3;

                    const float pTRr = sub.data.data[ind_top_r];
                    const float pTRg = sub.data.data[ind_top_r + 1];
                    const float pTRb = sub.data.data[ind_top_r + 2];

                    const float pBRr = sub.data.data[ind_bot_r];
                    const float pBRg = sub.data.data[ind_bot_r + 1];
                    const float pBRb = sub.data.data[ind_bot_r + 2];

                    const float outr = A*pTLr + B*pTRr + C*pBLr + D*pBRr;
                    const float outg = A*pTLg + B*pTRg + C*pBLg + D*pBRg;
                    const float outb = A*pTLb + B*pTRb + C*pBLb + D*pBRb;

                    const size_t idx = static_cast<size_t>(y) * W + static_cast<size_t>(x);
                    vals[f][idx*3]     += outr;
                    vals[f][idx*3 + 1] += outg;
                    vals[f][idx*3 + 2] += outb;
                    ++counts[f][idx];

                    pTLr = pTRr; pTLg = pTRg; pTLb = pTRb;
                    pBLr = pBRr; pBLg = pBRg; pBLb = pBRb;
                }
            }
        }
    }

    std::vector<ImageData> results;
    results.reserve(NF);

    for (size_t f = 0; f < NF; ++f) {
        ImageData out;
        out.width  = W;
        out.height = H;
        out.data.assign(W * H * 3, 0);

        for (size_t y = 0; y < H; ++y) {
            for (size_t x = 0; x < W; ++x) {
                const size_t idx = y * W + x;
                int16_t c = counts[f][idx];
                if (c == 0) continue;

                out.at(x, y, 0) = (unsigned char) std::clamp(std::round(vals[f][idx*3 + 0] / c), 0.0f, 255.0f);
                out.at(x, y, 1) = (unsigned char) std::clamp(std::round(vals[f][idx*3 + 1] / c), 0.0f, 255.0f);
                out.at(x, y, 2) = (unsigned char) std::clamp(std::round(vals[f][idx*3 + 2] / c), 0.0f, 255.0f);
            }
        }

        results.push_back(std::move(out));
    }

    return results;
}