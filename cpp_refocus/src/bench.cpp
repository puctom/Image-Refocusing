#include <algorithm>
#include <chrono>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>
#include "utils.hpp"
#include "basic.hpp"
#include <thread>
#include<x86intrin.h>
#include <filesystem>

namespace fs = std::filesystem;

static std::vector<float> make_focus_values(int n) {
    std::vector<float> vals(n);
    for (int i = 0; i < n; ++i)
        vals[i] = -50.0f + 100.0f * i / std::max(n - 1, 1);
    return vals;
}

static uint64_t make_TSC(){
    uint64_t tsc0 = _rdtsc();
    auto rn = std::chrono::steady_clock::now();
    std::this_thread::sleep_for(std::chrono::milliseconds(200));
    uint64_t tsc1 = _rdtsc();
    double elapsed_s = std::chrono::duration<double>(std::chrono::steady_clock::now() - rn).count();
    double tsc_per_s = (tsc1 - tsc0) / elapsed_s;
    return tsc_per_s;
}

static std::vector<SubApertureImage> generate_size(size_t new_w, size_t new_h) {
    const int grid = 17;
    std::vector<SubApertureImage> subs;
    subs.reserve(grid * grid);
    for (int v = 0; v < grid; ++v) {
        for (int u = 0; u < grid; ++u) {
            SubApertureImage sub;
            sub.u = (u-grid/2) / (0.9f / (grid -1));
            sub.v = (v-grid/2) / (0.9f / (grid -1));
            sub.data.width = new_w;
            sub.data.height = new_h;
            sub.data.data.resize(new_w * new_h * 3);
            for(size_t i = 0; i < new_h; i++){
                for(size_t j = 0; j < new_w; j++){
                    sub.data.data[3*(i*new_w + j) + 0] = (i+j+u) & 0xFF;
                    sub.data.data[3*(i*new_w + j) + 1] = (i+j+v) & 0xFF;
                    sub.data.data[3*(i*new_w + j) + 2] = (i+j) & 0xFF;
                }
            }
            subs.push_back(std::move(sub));
        }
    }
    return subs;
}

int main(int argc, char **argv) { // run this with "make timing"
    bool isGenerated = argc > 1 && std::string(argv[1]) == "--generate";
    std::vector<SubApertureImage> subs;
    std::string data_source;
    int n_focal;
    std::string label;
    std::string csv_path;

    if (isGenerated) {
        if(argc != 7){
            std::cerr << "Usage: bench --generate <W> <H> <n_focal> <label> <csv> \n";
            return 1;
        }
        size_t W = std::stoul(argv[2]);
        size_t H = std::stoul(argv[3]);
        n_focal = std::stoi(argv[4]);
        label = argv[5];
        csv_path = argv[6];

        data_source = "generated " + std::to_string(W) + "*" + std::to_string(H);
        subs = generate_size(W, H);
    } 
    else{
        if (argc < 5) {
            std::cerr << "Usage: bench <directory> <n_focal> <label> <csv>\n";
            return 1;
        }
        fs::path dir = argv[1];
        n_focal = std::stoi(argv[2]);
        label = argv[3];
        csv_path = argv[4];
        data_source = "real";
        subs = load_subaperture_images(dir);
    }

    const size_t W = subs.front().data.width;
    const size_t H = subs.front().data.height;
    const size_t N = subs.size();
    std::cerr << "  " << N << " sub-apertures, " << W << "x" << H << " px each\n";

    uint64_t tsc_per_s = make_TSC();
    std::cerr << "TSC frequency: " << tsc_per_s / 1e9 << " GHz\n";

    auto focus_vals = make_focus_values(n_focal);

    const int warmup = std::min(2, n_focal);
    for (int i = 0; i < warmup; ++i)
        refocus_shift_and_sum(subs, focus_vals[i]);

    std::vector<double> times(n_focal);
    uint64_t start = _rdtsc();

    for (int i = 0; i < n_focal; ++i) {
        uint64_t t0 = _rdtsc();
        refocus_shift_and_sum(subs, focus_vals[i]);
        uint64_t t1 = _rdtsc();
        times[i] = static_cast<double>(t1 - t0) / tsc_per_s;
    }

    uint64_t end = _rdtsc() - start;

    double total_s = static_cast<double>(end) / tsc_per_s;
    double per_focal_ms = total_s / n_focal * 1000.0;
    double mpixels_s = (double)W * H * n_focal / total_s / 1e6;
    uint64_t cycles_per_focal = end / n_focal;

    double min_ms = *std::min_element(times.begin(), times.end()) * 1000.0;
    double max_ms = *std::max_element(times.begin(), times.end()) * 1000.0;
    double median_ms = [&]() {
        std::vector<double> t = times;
        std::nth_element(t.begin(), t.begin() + t.size() / 2, t.end());
        return t[t.size() / 2] * 1000.0;
    }();

    std::cerr << "\n Timing resulsts: \n";
    std::cerr << "variant : " << label << "\n";
    std::cerr << "data source : " << data_source << "\n";
    std::cerr << "focal lengths : " << n_focal << "\n";
    std::cerr << "image size : " << W << "x" << H << "\n";
    std::cerr << "n subapertures : " << N << "\n";
    std::cerr << "total time : " << total_s << " s\n";
    std::cerr << "time per focal : " << per_focal_ms << " ms (med=" << median_ms
              << " min=" << min_ms << " max=" << max_ms << ")\n";
    std::cerr << "throughput : " << mpixels_s << " Mpixels/s\n";
    std::cerr << "cycles per focal : " << cycles_per_focal << " cycles\n";

    std::string row = label + "," 
    + data_source + ", " 
    + std::to_string(n_focal) + ","
    + std::to_string(W) + "," + std::to_string(H) + ","
    + std::to_string(N) + ","
    + std::to_string(total_s) + ","
    + std::to_string(per_focal_ms) + ","
    + std::to_string(median_ms) + ","
    + std::to_string(min_ms) + ","
    + std::to_string(max_ms) + ","
    + std::to_string(mpixels_s) + ","
    + std::to_string(cycles_per_focal) + "\n";

    if (!csv_path.empty()) {
        std::ofstream f(csv_path, std::ios::app);
        f << row;
    } else {
        std::cout << row;
    }

    return 0;
}
