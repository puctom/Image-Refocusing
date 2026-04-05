#include <algorithm>
#include <chrono>
#include <fstream>
#include <iostream>
#include <numeric>
#include <string>
#include <vector>
#include "algorithm.h"

using Clock = std::chrono::high_resolution_clock;
using Seconds = std::chrono::duration<double>;

static std::vector<float> make_focus_values(int n) {
    std::vector<float> vals(n);
    for (int i = 0; i < n; ++i)
        vals[i] = -50.0f + 100.0f * i / std::max(n - 1, 1);
    return vals;
}

int main(int argc, char **argv) { // run this with "make timing"
    fs::path dir = argv[1];
    int n_focal = std::stoi(argv[2]);
    std::string label = argc > 3 ? argv[3] : "unnamed";
    std::string csv_path = argc > 4 ? argv[4] : "";

    std::cerr << "Loading light field from " << dir << "...\n";
    auto subs = load_subaperture_images(dir);
    const size_t W = subs.front().data.width;
    const size_t H = subs.front().data.height;
    const size_t N = subs.size();
    std::cerr << "  " << N << " sub-apertures, " << W << "x" << H << " px each\n";

    auto focus_vals = make_focus_values(n_focal);

    const int warmup = std::min(2, n_focal);
    for (int i = 0; i < warmup; ++i)
        refocus_shift_and_sum(subs, focus_vals[i]);

    std::vector<double> times(n_focal);
    auto t_total_start = Clock::now();

    for (int i = 0; i < n_focal; ++i) {
        auto t0 = Clock::now();
        refocus_shift_and_sum(subs, focus_vals[i]);
        times[i] = Seconds(Clock::now() - t0).count();
    }

    double total_s = Seconds(Clock::now() - t_total_start).count();
    double per_focal_ms = total_s / n_focal * 1000.0;
    double mpixels_s = (double)W * H * n_focal / total_s / 1e6;

    double min_ms = *std::min_element(times.begin(), times.end()) * 1000.0;
    double max_ms = *std::max_element(times.begin(), times.end()) * 1000.0;
    double median_ms = [&]() {
        std::vector<double> t = times;
        std::nth_element(t.begin(), t.begin() + t.size() / 2, t.end());
        return t[t.size() / 2] * 1000.0;
    }();

    std::cerr << "\n Timing resulsts: \n";
    std::cerr << "flag variant : " << label << "\n";
    std::cerr << "focal lengths amount : " << n_focal << "\n";
    std::cerr << "image size : " << W << "x" << H << "\n";
    std::cerr << "n subapertures : " << N << "\n";
    std::cerr << "total time : " << total_s << " s\n";
    std::cerr << "time per focal : " << per_focal_ms << " ms (med=" << median_ms
              << " min=" << min_ms << " max=" << max_ms << ")\n";
    std::cerr << "throughput : " << mpixels_s << " Mpixels/s\n";

    std::string row = label + "," + std::to_string(n_focal) + ","
    + std::to_string(W) + "," + std::to_string(H) + ","
    + std::to_string(N) + ","
    + std::to_string(total_s) + ","
    + std::to_string(per_focal_ms) + ","
    + std::to_string(median_ms) + ","
    + std::to_string(min_ms) + ","
    + std::to_string(max_ms) + ","
    + std::to_string(mpixels_s) + "\n";

    if (!csv_path.empty()) {
        std::ofstream f(csv_path, std::ios::app);
        f << row;
    } else {
        std::cout << row;
    }

    return 0;
}
