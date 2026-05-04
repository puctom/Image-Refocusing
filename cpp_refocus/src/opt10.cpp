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
*       - remove mults in the innermost loop
* */

ImageData refocus_shift_and_sum(std::vector<SubApertureImage>& subapertures, float focus) {
    const size_t width = subapertures.front().data.width;
    const size_t height = subapertures.front().data.height;
    ImageData output;
    output.width = width;
    output.height = height;
    output.data.assign(width * height * 3, 0);

    std::vector<int16_t> counts(width * height);
    std::vector<float> vals(width * height * 3);
    float contributions[256][4];
    contributions[0][0] = 0;
    contributions[0][1] = 0;
    contributions[0][2] = 0;
    contributions[0][3] = 0;
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
        
        for(int i=2;i<256;i++) {
            contributions[i][0] = A * i;
            contributions[i][1] = B * i;
            contributions[i][2] = C * i;
            contributions[i][3] = D * i;
        }
        contributions[1][0] = A;
        contributions[1][1] = B;
        contributions[1][2] = C;
        contributions[1][3] = D;

        const int x_begin = std::max(0, -sx);
        const int x_end = std::min(w, w - sx - 1);
        const int y_begin = std::max(0, -sy);
        const int y_end = std::min(h, h - sy - 1);

        if(x_begin >= x_end || y_begin >= y_end) continue;

        for (int y = y_begin; y < y_end; ++y) {
            // Prime the "left column" with x = x_begin
            size_t ind_top = ((y + sy) * width + (x_begin + sx)) * 3;
            size_t ind_bot = ind_top + width * 3;

            unsigned char pTLr = sub.data.data[ind_top];
            unsigned char pTLg = sub.data.data[ind_top + 1];
            unsigned char pTLb = sub.data.data[ind_top + 2];

            unsigned char pBLr = sub.data.data[ind_bot];
            unsigned char pBLg = sub.data.data[ind_bot + 1];
            unsigned char pBLb = sub.data.data[ind_bot + 2];

            for (int x = x_begin; x < x_end; ++x) {
                // Load only the right column (the new pixels for this x)
                const size_t ind_top_r = ((y + sy) * width + (x + sx + 1)) * 3;
                const size_t ind_bot_r = ind_top_r + width * 3;

                const unsigned char pTRr = sub.data.data[ind_top_r];
                const unsigned char pTRg = sub.data.data[ind_top_r + 1];
                const unsigned char pTRb = sub.data.data[ind_top_r + 2];

                const unsigned char pBRr = sub.data.data[ind_bot_r];
                const unsigned char pBRg = sub.data.data[ind_bot_r + 1];
                const unsigned char pBRb = sub.data.data[ind_bot_r + 2];

                const float outr = contributions[pTLr][0] + contributions[pTRr][1] + contributions[pBLr][2] + contributions[pBRr][3];
                const float outg = contributions[pTLg][0] + contributions[pTRg][1] + contributions[pBLg][2] + contributions[pBRg][3];
                const float outb = contributions[pTLb][0] + contributions[pTRb][1] + contributions[pBLb][2] + contributions[pBRb][3]; 

                const size_t idx = static_cast<size_t>(y) * width + static_cast<size_t>(x);
                vals[idx*3]     += outr;
                vals[idx*3 + 1] += outg;
                vals[idx*3 + 2] += outb;
                ++counts[idx];

                // Right column becomes left column for next iteration
                pTLr = pTRr; pTLg = pTRg; pTLb = pTRb;
                pBLr = pBRr; pBLg = pBRg; pBLb = pBRb;
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
        }
    }

    return output;
}

