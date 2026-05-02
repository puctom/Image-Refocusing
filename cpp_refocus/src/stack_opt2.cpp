#include "refocus_stack.hpp"
#include "refocus.hpp"
#include "utils.hpp"

#include <vector>
#include <cmath>
#include <algorithm>

/*
*   List of Optimizations:
*       - tiling to fit in cache
* */

struct RGB {
    float r;
    float g;
    float b;
};

static inline RGB sample_bilinear(const SubApertureImage& img, float x, float y) {
    if (x < 0 || x >= img.data.width - 1 || y < 0 || y >= img.data.height - 1) {
        return {-1.0f, -1.0f, -1.0f};
    }
    const int x0 = static_cast<int>(std::floor(x));
    const int x1 = x0 + 1;
    const int y0 = static_cast<int>(std::floor(y));
    const int y1 = y0 + 1;

    const float dx = x - x0;
    const float dy = y - y0;

    float out[3];
    for (int c = 0; c < 3; ++c) {
        const float p00 = img.data.at(x0, y0, c);
        const float p10 = img.data.at(x1, y0, c);
        const float p01 = img.data.at(x0, y1, c);
        const float p11 = img.data.at(x1, y1, c);
        const float top    = (1.0f - dx) * p00 + dx * p10;
        const float bottom = (1.0f - dx) * p01 + dx * p11;
        out[c] = (1.0f - dy) * top + dy * bottom;
    }

    return {out[0], out[1], out[2]};
}

static inline unsigned char scale_round_clamp(float val, float scale) {
    return static_cast<unsigned char>(std::clamp(std::round(val / scale), 0.0f, 255.0f));
}

std::vector<ImageData> refocus_shift_and_sum_stack(std::vector<SubApertureImage> &subapertures, const std::vector<float>& focuses) {
    const int W = static_cast<int>(subapertures.front().data.width);
    const int H = static_cast<int>(subapertures.front().data.height);
    const int NF = static_cast<int>(focuses.size());
    const int TILE_SIZE = 32;
    std::vector<ImageData> results(NF);
    for (int f = 0; f < NF; ++f) {
        results[f].width = W;
        results[f].height = H;
        results[f].data.assign(W * H * 3, 0);
    }

    for (int ty = 0; ty < H; ty += TILE_SIZE) {
        int y_end = std::min(ty + TILE_SIZE, H);
        for (int tx = 0; tx < W; tx += TILE_SIZE) {
            int x_end = std::min(tx + TILE_SIZE, W);
            std::vector<float> tile_vals(NF * TILE_SIZE * TILE_SIZE * 3, 0.0f);
            std::vector<int16_t> tile_counts(NF * TILE_SIZE * TILE_SIZE, 0);

            for (const auto& sub : subapertures) {
                for (int f = 0; f < NF; ++f) {
                    const float shift_x = focuses[f] * sub.u;
                    const float shift_y = focuses[f] * sub.v;

                    for (int y = ty; y < y_end; ++y) {
                        for (int x = tx; x < x_end; ++x) {
                            RGB sample = sample_bilinear(sub, x + shift_x, y + shift_y);

                            if (sample.r >= 0) {
                                int local_idx = (y - ty) * TILE_SIZE + (x - tx);
                                int val_idx = (f * TILE_SIZE * TILE_SIZE + local_idx) * 3;

                                tile_vals[val_idx + 0] += sample.r;
                                tile_vals[val_idx + 1] += sample.g;
                                tile_vals[val_idx + 2] += sample.b;
                                tile_counts[f * TILE_SIZE * TILE_SIZE + local_idx] += 1;
                            }
                        }
                    }
                }
            }

            for (int f = 0; f < NF; ++f) {
                for (int y = ty; y < y_end; ++y) {
                    for (int x = tx; x < x_end; ++x) {
                        int local_idx = (y - ty) * TILE_SIZE + (x - tx);
                        int count = tile_counts[f * TILE_SIZE * TILE_SIZE + local_idx];

                        if (count > 0) {
                            int val_idx = (f * TILE_SIZE * TILE_SIZE + local_idx) * 3;
                            results[f].at(x, y, 0) = scale_round_clamp(tile_vals[val_idx + 0], count);
                            results[f].at(x, y, 1) = scale_round_clamp(tile_vals[val_idx + 1], count);
                            results[f].at(x, y, 2) = scale_round_clamp(tile_vals[val_idx + 2], count);
                        }
                    }
                }
            }
        }
    }

    return results;
}