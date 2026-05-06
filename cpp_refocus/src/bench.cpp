#include <algorithm>
#include <chrono>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>
#include "utils.hpp"
#include "refocus.hpp"
#include <thread>
#include <x86intrin.h>
#include <filesystem>
#include <numeric>
#include "hw_counter.hpp"
#include "bench_common.hpp"

// Number of repetitions to run per a given focus parameter
// to acheive more stable measurements (median)

namespace fs = std::filesystem;

// Run this as follows:
// bench <directory> <focus> <label> <csv>
// Or with generation of an image: bench --generate <W> <H> <focus> <label> <csv>
int main(int argc, char **argv) { // run this with "make timing"
    bool isGenerated = argc > 1 && std::string(argv[1]) == "--generate";
    std::vector<SubApertureImage> subs;
    std::string data_source;
    float focus = 0.0f;
    std::string label;
    std::string csv_path;

    if (isGenerated) {
        if(argc != 7){
            std::cerr << "Usage: bench --generate <W> <H> <focus> <label> <csv> \n";
            return 1;
        }
        size_t W = std::stoul(argv[2]);
        size_t H = std::stoul(argv[3]);
        focus = std::stof(argv[4]);
        label = argv[5];
        csv_path = argv[6];

        data_source = "generated " + std::to_string(W) + "*" + std::to_string(H);
        subs = generate_size(W, H);
    } 
    else{
        if (argc < 5) {
            std::cerr << "Usage: bench <directory> <focus> <label> <csv>\n";
            return 1;
        }
        fs::path dir = argv[1];
        focus = std::stof(argv[2]);
        label = argv[3];
        csv_path = argv[4];
        data_source = "real";
        subs = load_subaperture_images(dir);
    }


    const size_t W = subs.front().data.width;
    const size_t H = subs.front().data.height;
    const size_t N = subs.size();
    std::cerr << "  " << N << " sub-apertures, " << W << "x" << H << " px each\n";
    
    BenchContext ctx{label, data_source, csv_path, W, H, N, {focus}, NUM_REPS};
    uint64_t tsc_per_s = make_TSC();
    std::cerr << "TSC frequency: " << tsc_per_s / 1e9 << " GHz\n";

    // Warmup
    const int WARMUP_ITERATIONS = 1;
    for (int i = 0; i < WARMUP_ITERATIONS; ++i) {
        refocus_shift_and_sum(subs, focus);
    }



    std::vector<uint64_t> n_cycles(NUM_REPS);
    PerfMonitor perf;


    for (int i = 0; i < NUM_REPS; ++i) {
        flush_caches();
        perf.start();
        uint64_t t0 = _rdtsc();

        refocus_shift_and_sum(subs, focus);
        
        n_cycles[i] = _rdtsc() - t0;
        perf.stop();
        perf.accumulate();
               
    }
    
    CycleStats stats = compute_cycle_stats(n_cycles);
    perf.compute(ctx, stats, tsc_per_s);

    return 0;
}
