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
* */

struct RGB {
    float r;
    float g;
    float b;
};

RGB sample_bilinear(const SubApertureImage& img, int x, int y, float A, float B, float C, float D){
    const int width = img.data.width;
    float out[3];

    for(int c=0; c<3; ++c){
        const float p00 = img.data.data[(y * width + x) * 3 + c];
        const float p10 = img.data.data[(y * width + x+1) * 3 + c];
        const float p01 = img.data.data[((y+1) * width + x) * 3 + c];
        const float p11 = img.data.data[((y+1) * width + x+1) * 3 + c];

        out[c] = A*p00 + B*p10 + C*p01 + D*p11;
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


    const int w = static_cast<int>(width);
    const int h = static_cast<int>(height);

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

        const int x_begin = std::max(0, -sx);
        const int x_end = std::min(w, w - sx - 1);
        const int y_begin = std::max(0, -sy);
        const int y_end = std::min(h, h - sy - 1);

        if(x_begin >= x_end || y_begin >= y_end) continue;

        for(int y=y_begin; y < y_end; ++y){
            for(int x=x_begin; x < x_end; ++x){
                RGB sample = sample_bilinear(sub, x + sx, y + sy, A, B, C, D);

                const size_t idx = static_cast<size_t>(y) * width + static_cast<size_t>(x);
                vals[idx*3] += sample.r;
                vals[idx*3 + 1] += sample.g;
                vals[idx*3 + 2] += sample.b;
                ++counts[idx];
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

