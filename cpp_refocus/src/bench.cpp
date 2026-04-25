#include <algorithm>
#include <chrono>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>
#include "utils.hpp"
#include "refocus.hpp"
#include <thread>
#include<x86intrin.h>
#include <filesystem>
#include <numeric>
#include "hw_counter.hpp"

// Number of repetitions to run per a given focus parameter (later TODO: extend to a focal stack)
// to acheive more stable measurements (median)
const int NUM_REPS = 10;
static const char CSV_HEADER[] =
    "variant,data_source,focus_parameter,num_reps,img_w,img_h,n_subapertures,"
    "avg_ms,median_ms,min_ms,max_ms,avg_cycles,median_cycles,min_cycles,max_cycles,"
    "cycles_per_pixel,mpixels_s,membw_gbs,avg_cache_refs,avg_cache_misses,cache_miss_rate,"
    "avg_branch_instr,avg_branch_misses,branch_miss_rate,avg_instructions,ipc\n";

namespace fs = std::filesystem;

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
            sub.u = (u-grid/2) * (0.9f / (grid -1));
            sub.v = (v-grid/2) * (0.9f / (grid -1));
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

    if (csv_path.empty()) {
        std::cerr << "Error: no CSV path provided\n";
        return 1;
    }
    std::ofstream csv(csv_path, std::ios::app);
    // If the file is empty, append the header first
    if (csv.tellp() == 0) { 
        csv << CSV_HEADER;
    }

    const size_t W = subs.front().data.width;
    const size_t H = subs.front().data.height;
    const size_t N = subs.size();
    std::cerr << "  " << N << " sub-apertures, " << W << "x" << H << " px each\n";

    uint64_t tsc_per_s = make_TSC();
    std::cerr << "TSC frequency: " << tsc_per_s / 1e9 << " GHz\n";

    // Warmup
    const int WARMUP_ITERATIONS = 1;
    for (int i = 0; i < WARMUP_ITERATIONS; ++i) {
        refocus_shift_and_sum(subs, focus);
    }


    HWCounter cache_miss_counter(PERF_TYPE_HARDWARE, PERF_COUNT_HW_CACHE_MISSES);
    HWCounter instr_counter(PERF_TYPE_HARDWARE, PERF_COUNT_HW_INSTRUCTIONS);
    HWCounter branch_miss_counter(PERF_TYPE_HARDWARE, PERF_COUNT_HW_BRANCH_MISSES);
    HWCounter cache_ref_counter(PERF_TYPE_HARDWARE, PERF_COUNT_HW_CACHE_REFERENCES);
    HWCounter branch_instr_counter(PERF_TYPE_HARDWARE, PERF_COUNT_HW_BRANCH_INSTRUCTIONS);

    std::vector<uint64_t> n_cycles(NUM_REPS);
    uint64_t total_cache_misses = 0;
    uint64_t total_cache_refs = 0;
    uint64_t total_instructions = 0;
    uint64_t total_branch_misses = 0;
    uint64_t total_branch_instr = 0;

    for (int i = 0; i < NUM_REPS; ++i) {
        instr_counter.start();
        cache_ref_counter.start();
        cache_miss_counter.start();
        branch_instr_counter.start();
        branch_miss_counter.start();
        uint64_t t0 = _rdtsc();

        refocus_shift_and_sum(subs, focus);
        
        n_cycles[i] = _rdtsc() - t0;
        
        cache_ref_counter.stop();
        cache_miss_counter.stop();
        instr_counter.stop();
        branch_instr_counter.stop();
        branch_miss_counter.stop();
        
        total_cache_refs += cache_ref_counter.read();
        total_cache_misses += cache_miss_counter.read();
        total_instructions += instr_counter.read();
        total_branch_instr += branch_instr_counter.read();
        total_branch_misses += branch_miss_counter.read();
    }

    uint64_t total_cycles = std::accumulate(n_cycles.begin(), n_cycles.end(), 0ULL);
    uint64_t avg_cycles = total_cycles / NUM_REPS;

    uint64_t min_cycles = *std::min_element(n_cycles.begin(), n_cycles.end());
    uint64_t max_cycles = *std::max_element(n_cycles.begin(), n_cycles.end());
    uint64_t median_cycles = [&]() {
        std::vector<uint64_t> c = n_cycles;
        std::sort(c.begin(), c.end());
        return c[c.size() / 2];
    }();

    double avg_cycles_per_pixel = static_cast<double>(avg_cycles) / (W * H);

    double total_s = static_cast<double>(total_cycles) / tsc_per_s;
    double avg_ms = total_s / NUM_REPS * 1000.0;
    double mpixels_s = (double)W * H * NUM_REPS / total_s / 1e6;
    double bandwidth = (double)N * W * H * 3 / (total_s / NUM_REPS) / 1e9;

    double min_ms = static_cast<double>(min_cycles) / tsc_per_s * 1000.0;
    double max_ms = static_cast<double>(max_cycles) / tsc_per_s * 1000.0;
    double median_ms = static_cast<double>(median_cycles) / tsc_per_s * 1000.0;

    // general hardware events
    double avg_cache_refs = static_cast<double>(total_cache_refs) / NUM_REPS;
    double avg_cache_misses = static_cast<double>(total_cache_misses) / NUM_REPS;
    double avg_branch_instr = static_cast<double>(total_branch_instr) / NUM_REPS;
    double avg_branch_misses = static_cast<double>(total_branch_misses) / NUM_REPS;
    
    double avg_instructions = static_cast<double>(total_instructions) / NUM_REPS;
    double ipc = avg_instructions / avg_cycles;

    // convenience figures for insights:
    double cache_miss_rate = total_cache_refs > 0 ? 
                             (static_cast<double>(total_cache_misses) / total_cache_refs) : 0.0;
    double branch_miss_rate = total_branch_instr > 0 ? 
                              (static_cast<double>(total_branch_misses) / total_branch_instr) : 0.0;

    std::cerr << "\n Timing results: \n";
    std::cerr << "variant : " << label << "\n";
    std::cerr << "data source : " << data_source << "\n";
    std::cerr << "focus : " << focus << "\n";
    std::cerr << "runs : " << NUM_REPS << "\n";
    std::cerr << "image size : " << W << "x" << H << "\n";
    std::cerr << "n subapertures : " << N << "\n";
    std::cerr << "time: " << total_s << " s (avg = "<< avg_ms <<"ms med=" << median_ms << " min=" << min_ms << " max=" << max_ms << ")\n";
    std::cerr << "cycles/whole image: total: "<<total_cycles<<", avg: " << avg_cycles << " (med=" << median_cycles << " min=" << min_cycles << " max=" << max_cycles << ")\n";
    std::cerr << "cycles/pixel : avg: " << avg_cycles_per_pixel << "\n";
    std::cerr << "throughput : " << mpixels_s << " Mpixels/s\n";
    std::cerr << "mem bandwidth : " << bandwidth << " GB/s (est)\n";
    std::cerr << "avg_instructions : " << avg_instructions << " (IPC: " << ipc << ")\n";
    std::cerr << "cache : refs=" << avg_cache_refs << " misses=" << avg_cache_misses 
              << " (miss rate: " << (cache_miss_rate * 100.0) << "%)\n";
    std::cerr << "branches : instr=" << avg_branch_instr << " misses=" << avg_branch_misses 
              << " (miss rate: " << (branch_miss_rate * 100.0) << "%)\n";

    std::string row = label + ","
    + data_source + ","
    + std::to_string(focus) + ","
    + std::to_string(NUM_REPS) + ","
    + std::to_string(W) + "," + std::to_string(H) + ","
    + std::to_string(N) + ","
    + std::to_string(avg_ms) + ","
    + std::to_string(median_ms) + ","
    + std::to_string(min_ms) + ","
    + std::to_string(max_ms) + ","
    + std::to_string(avg_cycles) + ","
    + std::to_string(median_cycles) + ","
    + std::to_string(min_cycles) + ","
    + std::to_string(max_cycles) + ","
    + std::to_string(avg_cycles_per_pixel) + ","
    + std::to_string(mpixels_s) + ","
    + std::to_string(bandwidth) + ","
    + std::to_string(avg_cache_refs) + ","
    + std::to_string(avg_cache_misses) + ","
    + std::to_string(cache_miss_rate) + ","
    + std::to_string(avg_branch_instr) + ","
    + std::to_string(avg_branch_misses) + ","
    + std::to_string(branch_miss_rate) + ","
    + std::to_string(avg_instructions) + ","
    + std::to_string(ipc) + "\n";

    csv << row;

    return 0;
}
