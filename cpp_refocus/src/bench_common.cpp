#include "bench_common.hpp"
#include <chrono>
#include <thread>
#include <x86intrin.h>
#include <algorithm>
#include <numeric>
#include <fstream>
#include <iostream>

static const char CSV_HEADER_SINGLE[] =
    "variant,data_source,num_focuses,focus_values,num_reps,img_w,img_h,n_subapertures,"
    "avg_ms,median_ms,min_ms,max_ms,avg_cycles,median_cycles,min_cycles,max_cycles,"
    "cycles_per_pixel,mpixels_s,membw_gbs,"
    "avg_l1d_loads,avg_l1d_misses,avg_l1d_miss_rate,"
    "avg_l1d_stores,"
    "avg_l1i_misses,"
    "avg_dtlb_loads,avg_dtlb_load_misses,avg_dtlb_load_miss_rate,"
    "avg_dtlb_stores,avg_dtlb_store_misses,avg_dtlb_store_miss_rate,"
    "avg_llc_loads,avg_llc_misses,avg_llc_miss_rate,"
    "avg_llc_stores,avg_llc_store_misses,avg_llc_store_miss_rate,"
    "avg_itlb_load_misses,"
    "avg_major_page_faults,avg_minor_page_faults,"
    "avg_branch_instr,avg_branch_misses,branch_miss_rate,avg_instructions,ipc\n";



uint64_t make_TSC(){
    uint64_t tsc0 = _rdtsc();
    auto rn = std::chrono::steady_clock::now();
    std::this_thread::sleep_for(std::chrono::milliseconds(200));
    uint64_t tsc1 = _rdtsc();
    double elapsed_s = std::chrono::duration<double>(std::chrono::steady_clock::now() - rn).count();
    double tsc_per_s = (tsc1 - tsc0) / elapsed_s;
    return tsc_per_s;
}

std::vector<SubApertureImage> generate_size(size_t new_w, size_t new_h) {
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

CycleStats compute_cycle_stats(std::vector<uint64_t>& cycles) {
    CycleStats stats;
    stats.total = std::accumulate(cycles.begin(), cycles.end(), 0ULL);
    stats.avg = stats.total / cycles.size();
    stats.min = *std::min_element(cycles.begin(), cycles.end());
    stats.max = *std::max_element(cycles.begin(), cycles.end());
    
    // Sort to find median
    std::sort(cycles.begin(), cycles.end());
    stats.median = cycles[cycles.size() / 2];
    
    return stats;
}

void PerfMonitor::compute(const BenchContext& ctx, 
                                     const CycleStats& stats, 
                                     uint64_t tsc_per_s) {
    double avg_cycles_per_pixel = static_cast<double>(stats.avg) / (ctx.NF() * ctx.W * ctx.H);

    double total_s = static_cast<double>(stats.total) / tsc_per_s;
    double avg_ms = total_s / NUM_REPS * 1000.0;
    double mpixels_s = (double)ctx.NF() * ctx.W * ctx.H * NUM_REPS / total_s / 1e6;
    double bandwidth = (double)ctx.NF() * ctx.N * ctx.W * ctx.H * 3 / (total_s / NUM_REPS) / 1e9;

    double min_ms = static_cast<double>(stats.min) / tsc_per_s * 1000.0;
    double max_ms = static_cast<double>(stats.max) / tsc_per_s * 1000.0;
    double median_ms = static_cast<double>(stats.median) / tsc_per_s * 1000.0;

    // general hardware events
    double avg_l1d_loads = static_cast<double>(total_l1d_loads) / NUM_REPS;
    double avg_l1d_misses = static_cast<double>(total_l1d_misses) / NUM_REPS;
    double avg_l1d_stores = static_cast<double>(total_l1d_stores) / NUM_REPS;
    double avg_l1i_misses = static_cast<double>(total_l1i_misses) / NUM_REPS;
    double avg_llc_loads = static_cast<double>(total_llc_loads) / NUM_REPS;
    double avg_llc_misses = static_cast<double>(total_llc_misses) / NUM_REPS;
    double avg_llc_stores = static_cast<double>(total_llc_stores) / NUM_REPS;
    double avg_llc_store_misses = static_cast<double>(total_llc_store_misses) / NUM_REPS;

    double avg_dtlb_loads = static_cast<double>(total_dtlb_loads) / NUM_REPS;
    double avg_dtlb_load_misses = static_cast<double>(total_dtlb_load_misses) / NUM_REPS;
    double avg_dtlb_stores = static_cast<double>(total_dtlb_stores) / NUM_REPS;
    double avg_dtlb_store_misses = static_cast<double>(total_dtlb_store_misses) / NUM_REPS;

    double avg_itlb_load_misses = static_cast<double>(total_itlb_load_misses) / NUM_REPS;

    double avg_major_faults = static_cast<double>(total_major_faults) / NUM_REPS;
    double avg_minor_faults = static_cast<double>(total_minor_faults) / NUM_REPS;


    double avg_branch_instr = static_cast<double>(total_branch_instr) / NUM_REPS;
    double avg_branch_misses = static_cast<double>(total_branch_misses) / NUM_REPS;
    
    double avg_instructions = static_cast<double>(total_instructions) / NUM_REPS;
    double ipc = avg_instructions / stats.avg;

    // convenience figures for insights:
    double cache_l1d_load_miss_rate = total_l1d_loads > 0 ? 
                             (static_cast<double>(total_l1d_misses) / total_l1d_loads) : 0.0;
    (void)0; // no L1D store-miss counter available
    double cache_llc_load_miss_rate = total_llc_loads > 0 ? 
                             (static_cast<double>(total_llc_misses) / total_llc_loads) : 0.0;
    double cache_llc_store_miss_rate = total_llc_stores > 0 ?
                             (static_cast<double>(total_llc_store_misses) / total_llc_stores) : 0.0;
    double branch_miss_rate = total_branch_instr > 0 ? 
                              (static_cast<double>(total_branch_misses) / total_branch_instr) : 0.0;

    double dtlb_load_miss_rate = total_dtlb_loads > 0 ?
                                (static_cast<double>(total_dtlb_load_misses) / total_dtlb_loads) : 0.0;
    double dtlb_store_miss_rate = total_dtlb_stores > 0 ?
                                 (static_cast<double>(total_dtlb_store_misses) / total_dtlb_stores) : 0.0;


                          
    if (ctx.csv_path.empty()) {
        throw std::runtime_error("Error: no CSV path provided");
    }       
    std::ofstream csv(ctx.csv_path, std::ios::app);
    // If the file is empty, append the header first
    if (csv.tellp() == 0) { 
        csv << CSV_HEADER_SINGLE ;
    }

    std::cerr << std::fixed << std::setprecision(3);
    std::cerr << "\n Timing results: \n";
    std::cerr << "variant : " << ctx.label << "\n";
    std::cerr << "data source : " << ctx.data_source << "\n";
    if (ctx.isStack()) {
        std::cerr << "Stack: focuses : " << ctx.NF() << " ([" << ctx.get_focus_string(',') << "])\n";
    } else {
        std::cerr << "focus : " << ctx.focuses[0] << "\n";
    }    
    std::cerr << "runs : " << NUM_REPS << "\n";
    std::cerr << "image size : " << ctx.W << "x" << ctx.H << "\n";
    std::cerr << "n subapertures : " << ctx.N << "\n";
    std::cerr << "time: " << total_s << " s (avg = "<< avg_ms <<"ms med=" << median_ms << " min=" << min_ms << " max=" << max_ms << ")\n";
    std::cerr << "cycles/whole image: total: "<<stats.total<<", avg: " << stats.avg << " (med=" << stats.median << " min=" << stats.min << " max=" << stats.max << ")\n";
    std::cerr << "cycles/pixel : avg: " << avg_cycles_per_pixel << "\n";
    std::cerr << "throughput : " << mpixels_s << " Mpixels/s\n";
    std::cerr << "mem bandwidth : " << bandwidth << " GB/s (est)\n";
    std::cerr << "avg_instructions : " << avg_instructions << " (IPC: " << ipc << ")\n";
    std::cerr << "cache L1D: loads=" << avg_l1d_loads << " misses=" << avg_l1d_misses 
              << " (miss rate: " << (cache_l1d_load_miss_rate * 100.0) << "%)\n";
    std::cerr << "cache L1D (stores): stores=" << avg_l1d_stores << "\n";
    std::cerr << "L1I: load misses=" << avg_l1i_misses << "\n";
    std::cerr << "cache LLC: loads=" << avg_llc_loads << " misses=" << avg_llc_misses 
              << " (miss rate: " << (cache_llc_load_miss_rate * 100.0) << "%)\n";
    std::cerr << "cache LLC (stores): stores=" << avg_llc_stores << " misses=" << avg_llc_store_misses
              << " (miss rate: " << (cache_llc_store_miss_rate * 100.0) << "%)\n";
    std::cerr << "DTLB: loads=" << avg_dtlb_loads << " misses=" << avg_dtlb_load_misses
              << " (miss rate: " << (dtlb_load_miss_rate * 100.0) << "%), stores=" << avg_dtlb_stores
              << " misses=" << avg_dtlb_store_misses << " (miss rate: " << (dtlb_store_miss_rate * 100.0) << "%)\n";
    std::cerr << "ITLB: load misses=" << avg_itlb_load_misses << "\n";
    std::cerr << "page faults: major=" << avg_major_faults << " minor=" << avg_minor_faults << "\n";
    std::cerr << "branches : instr=" << avg_branch_instr << " misses=" << avg_branch_misses 
              << " (miss rate: " << (branch_miss_rate * 100.0) << "%)\n";

    csv << std::fixed << std::setprecision(6);
    csv << ctx.label << ","
        << ctx.data_source << ","
        << ctx.NF() << ","
        << "\"" << ctx.get_focus_string(';') << "\","
        << ctx.num_reps << ","
        << ctx.W << "," << ctx.H << ","
        << ctx.N << ","
        << avg_ms << ","
        << median_ms << ","
        << min_ms << ","
        << max_ms << ","
        << stats.avg << ","
        << stats.median << ","
        << stats.min << ","
        << stats.max << ","
        << avg_cycles_per_pixel << ","
        << mpixels_s << ","
        << bandwidth << ","
        << avg_l1d_loads << ","
        << avg_l1d_misses << ","
        << cache_l1d_load_miss_rate << ","
        << avg_l1d_stores << ","
        << avg_l1i_misses << ","
        << avg_dtlb_loads << ","
        << avg_dtlb_load_misses << ","
        << dtlb_load_miss_rate << ","
        << avg_dtlb_stores << ","
        << avg_dtlb_store_misses << ","
        << dtlb_store_miss_rate << ","
        << avg_llc_loads << ","
        << avg_llc_misses << ","
        << cache_llc_load_miss_rate << ","
        << avg_llc_stores << ","
        << avg_llc_store_misses << ","
        << cache_llc_store_miss_rate << ","
        << avg_itlb_load_misses << ","
        << avg_major_faults << ","
        << avg_minor_faults << ","
        << avg_branch_instr << ","
        << avg_branch_misses << ","
        << branch_miss_rate << ","
        << avg_instructions << ","
        << ipc << "\n";

}