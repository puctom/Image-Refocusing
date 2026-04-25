#include "refocus.hpp"
#include "utils.hpp"
#include <vector>
#include <cmath>

/*
*   List of Optimizations:
*       - Change the loop order to [Subaperture, y, x] for improved locality
*       - Common subexpression elimination
* */



struct RGB {
    float r;
    float g;
    float b;
};

RGB sample_bilinear(const SubApertureImage& img, int x, int y, float A, float B, float C, float D){
    // Using the convention that if any RGB val is negative it is invalid
    if(x < 0 || x >= img.data.width - 1) return RGB{-1.0f, -1.0f, -1.0f};
    if(y < 0 || y >= img.data.height -1) return RGB{-1.0f, -1.0f, -1.0f};

    float out[3];

    for(int channel=0; channel<3; ++channel){
        const float p00 = img.data.at(x  , y  , channel);
        const float p10 = img.data.at(x+1, y  , channel);
        const float p01 = img.data.at(x  , y+1, channel);
        const float p11 = img.data.at(x+1, y+1, channel);

        out[channel] = A*p00 + B*p10 + C*p01 + D*p11;
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
        float shift_x = focus * sub.u;
        float shift_y = focus * sub.v;

        const int sx = std::floor(shift_x);
        const int sy = std::floor(shift_y);
        float dx = shift_x - sx;
        float dy = shift_y - sy;

        float A = (1 - dx) * (1 - dy);
        float B = dx * (1 - dy);
        float C = (1 - dx) * dy;
        float D = dx * dy;

        for(size_t y=0; y<height; ++y){
            for(size_t x=0; x<width; ++x){
                RGB sample = sample_bilinear(sub, x + sx, y + sy, A, B, C, D);
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


