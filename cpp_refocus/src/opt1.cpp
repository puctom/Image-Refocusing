#include "refocus.hpp"
#include "utils.hpp"
#include <vector>

/*
*   List of Optimizations:
*       - Change the loop order to [Subaperture, y, x] for improved locality
* */



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
    return (unsigned char) std::clamp(std::round(val / scale), 0.0f, 255.0f);
}

ImageData refocus_shift_and_sum(std::vector<SubApertureImage>& subapertures, float focus) {
    const size_t width = subapertures.front().data.width;
    const size_t height = subapertures.front().data.height;
    ImageData output;
    output.width = width;
    output.height = height;
    output.data.assign(width * height * 3, 0);

    std::vector<int16_t> counts(width * height);
    std::vector<float> vals(width * height * 3);

    for(SubApertureImage& sub : subapertures){
        for(size_t y=0; y<height; ++y){
            for(size_t x=0; x<width; ++x){
                float shift_x = focus * sub.u;
                float shift_y = focus * sub.v;
                RGB sample = sample_bilinear(sub, x + shift_x, y + shift_y);
                if(sample.r < 0) continue;

                vals[(y*width + x)*3] += sample.r;
                vals[(y*width + x)*3 + 1] += sample.g;
                vals[(y*width + x)*3 + 2] += sample.b;
                ++counts[y*width + x];
            }
        }
    }

    for(size_t y=0; y<height; ++y){
        for(size_t x=0; x<width; ++x){
            int16_t c = counts[y * width + x];
            if(c == 0) continue;

            output.at(x, y, 0) = scale_round_clamp(vals[(y*width + x)*3], c);
            output.at(x, y, 1) = scale_round_clamp(vals[(y*width + x)*3 + 1], c);
            output.at(x, y, 2) = scale_round_clamp(vals[(y*width + x)*3 + 2], c);
        }
    }

    return output;
}


