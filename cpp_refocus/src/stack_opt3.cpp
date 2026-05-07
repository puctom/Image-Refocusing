#include "refocus_stack.hpp"
#include "refocus.hpp"
#include "utils.hpp"
#include <vector>
#include <cmath>
#include <algorithm>

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
    *       - 2x2 output block unrolling
    *       - precompute vals and counts
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
        const unsigned char* pixels = sub.data.data.data();

        for (size_t f = 0; f < NF; ++f) {
            const float shift_x = focuses[f] * sub.u;
            const float shift_y = focuses[f] * sub.v;

            const int sx = static_cast<int>(std::floor(shift_x));
            const int sy = static_cast<int>(std::floor(shift_y));
            const float dx = shift_x - sx;
            const float dy = shift_y - sy;

            const float A = (1 - dx) * (1 - dy);
            const float B = dx * (1 - dy);
            const float C = (1 - dx) * dy;
            const float D = dx * dy;

            const int x_begin = std::max(0, -sx);
            const int x_end   = std::min(w, w - sx - 1);
            const int y_begin = std::max(0, -sy);
            const int y_end   = std::min(h, h - sy - 1);

            if (x_begin >= x_end || y_begin >= y_end) continue;

            float* vals_f = vals[f].data();
            int16_t* counts_f = counts[f].data();

            int y = y_begin;
            for (; y + 1 < y_end; y += 2) {
                const unsigned char* r0 = pixels + (static_cast<size_t>(y + sy) * W + static_cast<size_t>(x_begin + sx)) * 3;
                const unsigned char* r1 = pixels + (static_cast<size_t>(y + sy + 1) * W + static_cast<size_t>(x_begin + sx)) * 3;
                const unsigned char* r2 = pixels + (static_cast<size_t>(y + sy + 2) * W + static_cast<size_t>(x_begin + sx)) * 3;

                float* vp0 = vals_f + (static_cast<size_t>(y) * W + static_cast<size_t>(x_begin)) * 3;
                float* vp1 = vals_f + (static_cast<size_t>(y + 1) * W + static_cast<size_t>(x_begin)) * 3;
                int16_t* cp0 = counts_f + static_cast<size_t>(y) * W + static_cast<size_t>(x_begin);
                int16_t* cp1 = counts_f + static_cast<size_t>(y + 1) * W + static_cast<size_t>(x_begin);

                float p00r = r0[0], p00g = r0[1], p00b = r0[2];
                float p10r = r1[0], p10g = r1[1], p10b = r1[2];
                float p20r = r2[0], p20g = r2[1], p20b = r2[2];

                int x = x_begin;
                for (; x + 1 < x_end;
                    x += 2, r0 += 6, r1 += 6, r2 += 6,
                    vp0 += 6, vp1 += 6, cp0 += 2, cp1 += 2) {
                    const float p01r = r0[3], p01g = r0[4], p01b = r0[5];
                    const float p02r = r0[6], p02g = r0[7], p02b = r0[8];
                    const float p11r = r1[3], p11g = r1[4], p11b = r1[5];
                    const float p12r = r1[6], p12g = r1[7], p12b = r1[8];
                    const float p21r = r2[3], p21g = r2[4], p21b = r2[5];
                    const float p22r = r2[6], p22g = r2[7], p22b = r2[8];

                    vp0[0] += A*p00r + B*p01r + C*p10r + D*p11r;
                    vp0[1] += A*p00g + B*p01g + C*p10g + D*p11g;
                    vp0[2] += A*p00b + B*p01b + C*p10b + D*p11b;
                    ++cp0[0];

                    vp0[3] += A*p01r + B*p02r + C*p11r + D*p12r;
                    vp0[4] += A*p01g + B*p02g + C*p11g + D*p12g;
                    vp0[5] += A*p01b + B*p02b + C*p11b + D*p12b;
                    ++cp0[1];

                    vp1[0] += A*p10r + B*p11r + C*p20r + D*p21r;
                    vp1[1] += A*p10g + B*p11g + C*p20g + D*p21g;
                    vp1[2] += A*p10b + B*p11b + C*p20b + D*p21b;
                    ++cp1[0];

                    vp1[3] += A*p11r + B*p12r + C*p21r + D*p22r;
                    vp1[4] += A*p11g + B*p12g + C*p21g + D*p22g;
                    vp1[5] += A*p11b + B*p12b + C*p21b + D*p22b;
                    ++cp1[1];
                    p00r = p02r; p00g = p02g; p00b = p02b;
                    p10r = p12r; p10g = p12g; p10b = p12b;
                    p20r = p22r; p20g = p22g; p20b = p22b;
                }

                if (x < x_end) {
                    const float p01r = r0[3], p01g = r0[4], p01b = r0[5];
                    const float p11r = r1[3], p11g = r1[4], p11b = r1[5];
                    const float p21r = r2[3], p21g = r2[4], p21b = r2[5];

                    vp0[0] += A*p00r +B*p01r + C*p10r + D*p11r;
                    vp0[1] += A*p00g + B*p01g + C*p10g + D*p11g;
                    vp0[2] += A*p00b + B*p01b + C*p10b + D*p11b;
                    ++cp0[0];

                    vp1[0] += A*p10r + B*p11r + C*p20r + D*p21r;
                    vp1[1] += A*p10g + B*p11g + C*p20g + D*p21g;
                    vp1[2] += A*p10b + B*p11b + C*p20b + D*p21b;
                    ++cp1[0];
                }
            }

            if (y < y_end) {
                const size_t ind_top = (static_cast<size_t>(y + sy)* W + static_cast<size_t>(x_begin + sx)) * 3;
                const size_t ind_bot = (static_cast<size_t>(y + sy + 1) * W + static_cast<size_t>(x_begin + sx)) * 3;

                float pTLr = pixels[ind_top], pTLg = pixels[ind_top + 1], pTLb = pixels[ind_top + 2];
                float pBLr = pixels[ind_bot],pBLg = pixels[ind_bot + 1], pBLb = pixels[ind_bot + 2];
                float* vp = vals_f + (static_cast<size_t>(y) * W + static_cast<size_t>(x_begin)) * 3;
                int16_t* cp = counts_f + static_cast<size_t>(y) * W + static_cast<size_t>(x_begin);

                for (int x = x_begin; x < x_end; ++x, vp += 3, ++cp) {
                    const size_t itr = (static_cast<size_t>(y + sy) * W + static_cast<size_t>(x + sx + 1)) * 3;
                    const size_t ibr = (static_cast<size_t>(y + sy + 1) * W + static_cast<size_t>(x + sx + 1)) * 3;
                    const float pTRr = pixels[itr], pTRg = pixels[itr + 1], pTRb = pixels[itr + 2];
                    const float pBRr = pixels[ibr], pBRg = pixels[ibr + 1], pBRb = pixels[ibr + 2];

                    vp[0] += A*pTLr + B*pTRr + C*pBLr + D*pBRr;
                    vp[1] += A*pTLg + B*pTRg + C*pBLg + D*pBRg;
                    vp[2] += A*pTLb + B*pTRb + C*pBLb + D*pBRb;
                    ++(*cp);

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