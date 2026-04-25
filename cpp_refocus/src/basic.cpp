#include "basic.hpp"
#include <cmath>

struct RGB {
    float r;
    float g;
    float b;
};

RGB sample_bilinear(const SubApertureImage& img, float x, float y){
    // Using the convention that if any RGB val is negative it is invalid
    if(x < 0 || x >= img.data.width - 1) return RGB{-1.0f, -1.0f, -1.0f};
    if(y < 0 || y >= img.data.height -1) return RGB{-1.0f, -1.0f, -1.0f};

    const int x0 = std::floor(x);
    const int x1 = std::ceil(x);
    const int y0 = std::floor(y);
    const int y1 = std::ceil(y);

    const float dx = x - x0;
    const float dy = y - y0;

    float out[3];

    for(int channel=0; channel<3; ++channel){
        const float p00 = img.data.at(x0, y0, channel);
        const float p10 = img.data.at(x1, y0, channel);
        const float p01 = img.data.at(x0, y1, channel);
        const float p11 = img.data.at(x1, y1, channel);

        const float top    = (1.0f - dx) * p00 + dx * p10;
        const float bottom = (1.0f - dx) * p01 + dx * p11;
        out[channel] = (1.0f - dy) * top + dy * bottom;
    }

    return RGB{out[0], out[1], out[2]};
}

unsigned char scale_round_clamp(float val, float scale){
    return (unsigned char) std::clamp(std::round(val / scale), (float) 0.0f, (float) 255.0f);
}

ImageData refocus_shift_and_sum(std::vector<SubApertureImage>& subapertures, float focus) {
    const size_t width = subapertures.front().data.width;
    const size_t height = subapertures.front().data.height;
    ImageData output;
    output.width = width;
    output.height = height;
    output.data.assign(width * height * 3, 0);
    for(size_t y=0; y<height; ++y){
        for(size_t x=0; x<width; ++x){
            int count = 0;
            RGB sum{0.0f, 0.0f, 0.0f};
            for(SubApertureImage& sub : subapertures){
                float shift_x = focus * sub.u;
                float shift_y = focus * sub.v;

                RGB sample = sample_bilinear(sub, x + shift_x, y + shift_y);
                if(sample.r < 0) continue;

                sum.r += sample.r;
                sum.g += sample.g;
                sum.b += sample.b;
                ++count;
            }
            if(count == 0) continue;
            output.at(x, y, 0) = scale_round_clamp(sum.r, count);
            output.at(x, y, 1) = scale_round_clamp(sum.g, count);
            output.at(x, y, 2) = scale_round_clamp(sum.b, count);
        }
    }

    return output;
}

