#include "refocus.hpp"
#include "utils.hpp"
#include <vector>
#include <cmath>
#include <algorithm>
#include <cstdint>
#include <iostream>

/*
*   List of Optimizations:
*       - Change the loop order to [Subaperture, y, x] for improved locality
*       - Common subexpression elimination
*       - use better bounds for the x-y loops
*       - use unchecked array access
*       - function inlining
*       - unroll channel loop to expose independent scalar ops for ILP
* */

ImageData refocus_shift_and_sum(std::vector<SubApertureImage>& subapertures, float focus) {
    uint64_t int_to_float_conversions = 0;
    uint64_t muls = 0;
    uint64_t adds = 0;

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
        muls += 2;

        const int sx = std::floor(shift_x);
        const int sy = std::floor(shift_y);
        float dx = shift_x - sx;
        float dy = shift_y - sy;
        int_to_float_conversions += 2;
        adds += 2;

        float A = (1 - dx) * (1 - dy);
        float B = dx * (1 - dy);
        float C = (1 - dx) * dy;
        float D = dx * dy;
        muls += 4;
        adds += 4;

        const int x_begin = std::max(0, -sx);
        const int x_end = std::min(w, w - sx - 1);
        const int y_begin = std::max(0, -sy);
        const int y_end = std::min(h, h - sy - 1);

        if(x_begin >= x_end || y_begin >= y_end) continue;

        for(int y=y_begin; y < y_end; ++y){
            for(int x=x_begin; x < x_end; ++x){
                // sample bilinear inlining
                const size_t ind00 = ((y + sy) * width + (x + sx)) * 3;
                const size_t ind10 = ind00 + 3;
                const size_t ind01 = ind00 + width * 3;
                const size_t ind11 = ind01 + 3;

                const float p00r = sub.data.data[ind00];
                const float p00g = sub.data.data[ind00 + 1];
                const float p00b = sub.data.data[ind00 + 2];

                const float p10r = sub.data.data[ind10];
                const float p10g = sub.data.data[ind10 + 1];
                const float p10b = sub.data.data[ind10 + 2];

                const float p01r = sub.data.data[ind01];
                const float p01g = sub.data.data[ind01 + 1];
                const float p01b = sub.data.data[ind01 + 2];

                const float p11r = sub.data.data[ind11];
                const float p11g = sub.data.data[ind11 + 1];
                const float p11b = sub.data.data[ind11 + 2];
                int_to_float_conversions += 12;

                const float outr = A*p00r + B*p10r + C*p01r + D*p11r;
                const float outg = A*p00g + B*p10g + C*p01g + D*p11g;
                const float outb = A*p00b + B*p10b + C*p01b + D*p11b;

                const size_t idx = static_cast<size_t>(y) * width + static_cast<size_t>(x);
                vals[idx*3]     += outr;
                vals[idx*3 + 1] += outg;
                vals[idx*3 + 2] += outb;
                ++counts[idx];
                muls += 12;
                adds += 12;
            }
        }
    }

    for(size_t y=0; y<height; ++y){
        for(size_t x=0; x<width; ++x){
            int16_t c = counts[y * width + x];
            if(c == 0) continue;

            // scale_round_clamp inlining
            output.at(x, y, 0) = (unsigned char) std::clamp(std::round(vals[(y*width + x)*3]     / c), 0.0f, 255.0f);
            output.at(x, y, 1) = (unsigned char) std::clamp(std::round(vals[(y*width + x)*3 + 1] / c), 0.0f, 255.0f);
            output.at(x, y, 2) = (unsigned char) std::clamp(std::round(vals[(y*width + x)*3 + 2] / c), 0.0f, 255.0f);
            int_to_float_conversions += 3;
        }
    }

    std::cout << "int_to_float_conversions: " << int_to_float_conversions << '\n'
              << "muls: " << muls << '\n'
              << "adds: " << adds << '\n';

    return output;
}

