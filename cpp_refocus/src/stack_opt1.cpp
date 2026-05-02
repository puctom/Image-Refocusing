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

static inline RGB sample_bilinear(const SubApertureImage& img, float x, float y){
    if(x < 0 || x >= img.data.width - 1) return {-1.0f, -1.0f, -1.0f};
    if(y < 0 || y >= img.data.height -1) return {-1.0f, -1.0f, -1.0f};

    const int x0 = std::floor(x);
    const int x1 = std::ceil(x);
    const int y0 = std::floor(y);
    const int y1 = std::ceil(y);

    const float dx = x - x0;
    const float dy = y - y0;

    float out[3];

    for(int c = 0; c < 3; ++c){
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

static inline unsigned char scale_round_clamp(float val, float scale){
    return (unsigned char) std::clamp(std::round(val / scale), 0.0f, 255.0f);
}

std::vector<ImageData> refocus_shift_and_sum_stack(std::vector<SubApertureImage> &subapertures, const std::vector<float>& focuses){
    const size_t W = subapertures.front().data.width;
    const size_t H = subapertures.front().data.height;
    const size_t NF = focuses.size();

    std::vector<std::vector<float>> vals(NF, std::vector<float>(W * H * 3, 0.0f));
    std::vector<std::vector<int16_t>> counts(NF, std::vector<int16_t>(W * H, 0));

    for (size_t s = 0; s < subapertures.size(); ++s) {
        const auto& sub = subapertures[s];

        std::vector<float> shift_x(NF), shift_y(NF);
        for (size_t f = 0; f < NF; ++f) {
            shift_x[f] = focuses[f] * sub.u;
            shift_y[f] = focuses[f] * sub.v;
        }

        for (size_t y = 0; y < H; ++y) {
            for (size_t x = 0; x < W; ++x) {

                const size_t idx = y * W + x;

                for (size_t f = 0; f < NF; ++f) {
                    RGB sample = sample_bilinear(
                        sub,
                        x + shift_x[f],
                        y + shift_y[f]
                    );

                    if (sample.r < 0) continue;

                    vals[f][idx*3 + 0] += sample.r;
                    vals[f][idx*3 + 1] += sample.g;
                    vals[f][idx*3 + 2] += sample.b;
                    counts[f][idx]     += 1;
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

                out.at(x, y, 0) = scale_round_clamp(vals[f][idx*3 + 0], c);
                out.at(x, y, 1) = scale_round_clamp(vals[f][idx*3 + 1], c);
                out.at(x, y, 2) = scale_round_clamp(vals[f][idx*3 + 2], c);
            }
        }

        results.push_back(std::move(out));
    }

    return results;
}