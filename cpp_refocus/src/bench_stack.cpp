#include <algorithm>
#include <chrono>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>
#include "utils.hpp"
#include "refocus_stack.hpp"
#include <thread>
#include <x86intrin.h>
#include <filesystem>
#include <numeric>
#include "hw_counter.hpp"
#include "bench_common.hpp"

// Run this as follows:
// Focal stack: bench-stack <directory> <label> <csv> <focus1> <focus2> ...
// Or with generation of an image: bench-stack --generate <W> <H> <label> <csv> <focus1> <focus2> ...

int main(int argc, char **argv) {
    bool isGenerated = argc > 1 && std::string(argv[1]) == "--generate";
    std::vector<SubApertureImage> subs;
    std::string data_source;
    std::string label;
    std::string csv_path;
    std::vector<float> focuses;

    int focus_start_idx = 0;

    if (isGenerated) {
        if(argc < 7){
            std::cerr << "Usage: bench-stack --generate <W> <H> <label> <csv> <f1> [f2...]\n";
            return 1;
        }
        size_t W = std::stoul(argv[2]);
        size_t H = std::stoul(argv[3]);
        label = argv[4];
        csv_path = argv[5];
        focus_start_idx = 6;

        data_source = "generated " + std::to_string(W) + "*" + std::to_string(H);
        subs = generate_size(W, H);
    }
    else {
        if (argc < 5) {
            std::cerr << "Usage: bench-stack <directory> <label> <csv> <f1> [f2...]\n";
            return 1;
        }
        fs::path dir = argv[1];
        label = argv[2];
        csv_path = argv[3];
        focus_start_idx = 4;
        data_source = "real";
        subs = load_subaperture_images(dir);
    }

    // Extract argument focus values
    for (int i = focus_start_idx; i < argc; ++i) {
        focuses.push_back(std::stof(argv[i]));
    }

    const size_t W = subs.front().data.width;
    const size_t H = subs.front().data.height;
    const size_t N = subs.size();
    std::cerr << "  " << N << " sub-apertures, " << W << "x" << H << " px each\n";

    BenchContext ctx{label, data_source, csv_path, W, H, N, focuses, NUM_REPS};
    uint64_t tsc_per_s = make_TSC();
    std::cerr << "TSC frequency: " << tsc_per_s / 1e9 << " GHz\n";

    // Warmup
    const int WARMUP_ITERATIONS = 1;
    for (int i = 0; i < WARMUP_ITERATIONS; ++i) {
        refocus_shift_and_sum_stack(subs, focuses);
    }

    std::vector<uint64_t> n_cycles(NUM_REPS);
    PerfMonitor perf;

    for (int i = 0; i < NUM_REPS; ++i) {
        flush_caches();
        perf.start();
        uint64_t t0 = _rdtsc();

        refocus_shift_and_sum_stack(subs, focuses);

        n_cycles[i] = _rdtsc() - t0;
        
        perf.stop();
        perf.accumulate();
    }

    CycleStats stats = compute_cycle_stats(n_cycles);
    perf.compute_and_report(ctx, stats, tsc_per_s);

    return 0;
}
