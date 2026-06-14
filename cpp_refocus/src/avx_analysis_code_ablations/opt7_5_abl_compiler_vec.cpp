#include "refocus.hpp"
#include "utils.hpp"
#include <vector>
#include <cmath>
#include <algorithm>

/*
*   Ablation 1: Best scalar code (opt7_5) for compilation with -ftree-vectorize.
*   
*
*   Compile flags: -march=native -ffast-math -mavx2 -mfma
*   (no -fno-tree-vectorize, so -ftree-vectorize is active via -O3)
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
        p.sx = static_cast<int>(std::floor(shift_x));
        p.sy = static_cast<int>(std::floor(shift_y));

        const float dx = shift_x - p.sx;
        const float dy = shift_y - p.sy;

        p.A = (1.0f - dx) * (1.0f - dy);
        p.B = dx           * (1.0f - dy);
        p.C = (1.0f - dx) * dy;
        p.D = dx           * dy;

        p.x_begin = std::max(0, -p.sx);
        p.x_end   = std::min(w, w - p.sx - 1);
        p.y_begin = std::max(0, -p.sy);
        p.y_end   = std::min(h, h - p.sy - 1);
        p.data    = sub.data.data.data();

        if (p.x_begin >= p.x_end || p.y_begin >= p.y_end) continue;
        params.push_back(p);
    }

    std::vector<int> counts(width * height, 0);
    {
        std::vector<int> diff((width + 1) * (height + 1), 0);
        for (const SubParams& p : params) {
            diff[p.y_begin * (width + 1) + p.x_begin] += 1;
            diff[p.y_begin * (width + 1) + p.x_end  ] -= 1;
            diff[p.y_end   * (width + 1) + p.x_begin] -= 1;
            diff[p.y_end   * (width + 1) + p.x_end  ] += 1;
        }
        for (int y = 0; y < h; ++y) {
            int row = 0;
            for (int x = 0; x < w; ++x) {
                row += diff[y * (width + 1) + x];
                counts[y * w + x] = row + (y > 0 ? counts[(y - 1) * w + x] : 0);
            }
        }
    }

    std::vector<float> vals(width * height * 3, 0.0f);

    for (const SubParams& p : params) {
        for (int y = p.y_begin; y < p.y_end; ++y) {
            size_t ind_top = ((size_t)(y + p.sy) * width + (size_t)(p.x_begin + p.sx)) * 3;
            size_t ind_bot = ind_top + width * 3;

            float pTLr = p.data[ind_top    ];
            float pTLg = p.data[ind_top + 1];
            float pTLb = p.data[ind_top + 2];
            float pBLr = p.data[ind_bot    ];
            float pBLg = p.data[ind_bot + 1];
            float pBLb = p.data[ind_bot + 2];

            float* vrow = vals.data() + ((size_t)y * width + (size_t)p.x_begin) * 3;

            for (int x = p.x_begin; x < p.x_end; ++x) {
                const size_t ir = ((size_t)(y + p.sy) * width + (size_t)(x + p.sx + 1)) * 3;
                const size_t br = ir + width * 3;

                const float pTRr = p.data[ir    ];
                const float pTRg = p.data[ir + 1];
                const float pTRb = p.data[ir + 2];
                const float pBRr = p.data[br    ];
                const float pBRg = p.data[br + 1];
                const float pBRb = p.data[br + 2];

                vrow[0] += p.A*pTLr + p.B*pTRr + p.C*pBLr + p.D*pBRr;
                vrow[1] += p.A*pTLg + p.B*pTRg + p.C*pBLg + p.D*pBRg;
                vrow[2] += p.A*pTLb + p.B*pTRb + p.C*pBLb + p.D*pBRb;

                pTLr = pTRr; pTLg = pTRg; pTLb = pTRb;
                pBLr = pBRr; pBLg = pBRg; pBLb = pBRb;
                vrow += 3;
            }
        }
    }

    for (int y = 0; y < h; ++y) {
        for (int x = 0; x < w; ++x) {
            const int c = counts[y * w + x];
            if (c == 0) continue;
            float inv_c = 1.0f / (float)c;
            const float* vp = vals.data() + ((size_t)y * width + x) * 3;
            unsigned char* outp = output.data.data() + ((size_t)y * width + x) * 3;
            outp[0] = (unsigned char)std::clamp(vp[0] * inv_c + 0.5f, 0.0f, 255.0f);
            outp[1] = (unsigned char)std::clamp(vp[1] * inv_c + 0.5f, 0.0f, 255.0f);
            outp[2] = (unsigned char)std::clamp(vp[2] * inv_c + 0.5f, 0.0f, 255.0f);
        }
    }

    return output;
}
