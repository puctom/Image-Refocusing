#pragma once

#include <vector>
#include <string>
#include <cstdint>
#include "utils.hpp" 
#include "hw_counter.hpp"

// for specifying the corresponding value
#define HW_CACHE_CONFIG(id, op, result) \
    ((id) | ((op) << 8) | ((result) << 16))

// L1 data Cache
constexpr uint64_t L1D_LOADS        = HW_CACHE_CONFIG(PERF_COUNT_HW_CACHE_L1D,  PERF_COUNT_HW_CACHE_OP_READ,  PERF_COUNT_HW_CACHE_RESULT_ACCESS);
constexpr uint64_t L1D_LOAD_MISSES  = HW_CACHE_CONFIG(PERF_COUNT_HW_CACHE_L1D,  PERF_COUNT_HW_CACHE_OP_READ,  PERF_COUNT_HW_CACHE_RESULT_MISS);
constexpr uint64_t L1D_STORES       = HW_CACHE_CONFIG(PERF_COUNT_HW_CACHE_L1D,  PERF_COUNT_HW_CACHE_OP_WRITE, PERF_COUNT_HW_CACHE_RESULT_ACCESS);

// L1 instr Cache
constexpr uint64_t L1I_LOAD_MISSES  = HW_CACHE_CONFIG(PERF_COUNT_HW_CACHE_L1I,  PERF_COUNT_HW_CACHE_OP_READ,  PERF_COUNT_HW_CACHE_RESULT_MISS);

// Last Level Cache (LLC)
constexpr uint64_t LLC_LOADS        = HW_CACHE_CONFIG(PERF_COUNT_HW_CACHE_LL,   PERF_COUNT_HW_CACHE_OP_READ,  PERF_COUNT_HW_CACHE_RESULT_ACCESS);
constexpr uint64_t LLC_LOAD_MISSES  = HW_CACHE_CONFIG(PERF_COUNT_HW_CACHE_LL,   PERF_COUNT_HW_CACHE_OP_READ,  PERF_COUNT_HW_CACHE_RESULT_MISS);
constexpr uint64_t LLC_STORES       = HW_CACHE_CONFIG(PERF_COUNT_HW_CACHE_LL,   PERF_COUNT_HW_CACHE_OP_WRITE, PERF_COUNT_HW_CACHE_RESULT_ACCESS);
constexpr uint64_t LLC_STORE_MISSES = HW_CACHE_CONFIG(PERF_COUNT_HW_CACHE_LL,   PERF_COUNT_HW_CACHE_OP_WRITE, PERF_COUNT_HW_CACHE_RESULT_MISS);

// Data TLB
constexpr uint64_t DTLB_LOADS        = HW_CACHE_CONFIG(PERF_COUNT_HW_CACHE_DTLB, PERF_COUNT_HW_CACHE_OP_READ,  PERF_COUNT_HW_CACHE_RESULT_ACCESS);
constexpr uint64_t DTLB_LOAD_MISSES  = HW_CACHE_CONFIG(PERF_COUNT_HW_CACHE_DTLB, PERF_COUNT_HW_CACHE_OP_READ,  PERF_COUNT_HW_CACHE_RESULT_MISS);
constexpr uint64_t DTLB_STORES       = HW_CACHE_CONFIG(PERF_COUNT_HW_CACHE_DTLB, PERF_COUNT_HW_CACHE_OP_WRITE, PERF_COUNT_HW_CACHE_RESULT_ACCESS);
constexpr uint64_t DTLB_STORE_MISSES = HW_CACHE_CONFIG(PERF_COUNT_HW_CACHE_DTLB, PERF_COUNT_HW_CACHE_OP_WRITE, PERF_COUNT_HW_CACHE_RESULT_MISS);

// Instruction TLB
constexpr uint64_t ITLB_LOAD_MISSES  = HW_CACHE_CONFIG(PERF_COUNT_HW_CACHE_ITLB, PERF_COUNT_HW_CACHE_OP_READ,  PERF_COUNT_HW_CACHE_RESULT_MISS);

// shared constants for benchmarks
constexpr int NUM_REPS = 10;
constexpr int WARMUP_ITERATIONS = 1;

// --- Utility Functions ---
uint64_t make_TSC();
std::vector<SubApertureImage> generate_size(size_t new_w, size_t new_h);

// statistics related to cycles
struct CycleStats {
    uint64_t total;
    uint64_t avg;
    uint64_t min;
    uint64_t max;
    uint64_t median;
};

CycleStats compute_cycle_stats(std::vector<uint64_t>& cycles);

struct BenchContext {
    std::string label;
    std::string data_source;
    std::string csv_path;
    size_t W, H, N;
    std::vector<float> focuses; // Replaces NF
    int num_reps;

    size_t NF() const { 
        return focuses.size(); 
    }
    
    bool isStack() const { 
        return focuses.size() > 1; 
    }

    // Helper to format the list of focuses into a single string, e.g: "-2.137;-2.037;-1.987;-1.75"
    std::string get_focus_string(char delimiter = ';') const {
        std::ostringstream oss;
        for (size_t i = 0; i < focuses.size(); ++i) {
            oss << focuses[i];
            if (i < focuses.size() - 1) oss << delimiter;
        }
        return oss.str();
    }
};

// struct for collective gathering of the metrics
struct PerfMonitor {
    
    HWCounter l1d_load_counter{PERF_TYPE_HW_CACHE, L1D_LOADS};
    HWCounter l1d_miss_counter{PERF_TYPE_HW_CACHE, L1D_LOAD_MISSES};
    HWCounter llc_load_counter{PERF_TYPE_HW_CACHE, LLC_LOADS};
    HWCounter llc_miss_counter{PERF_TYPE_HW_CACHE, LLC_LOAD_MISSES};

    HWCounter l1d_store_counter{PERF_TYPE_HW_CACHE, L1D_STORES};

    HWCounter l1i_miss_counter{PERF_TYPE_HW_CACHE, L1I_LOAD_MISSES};

    HWCounter llc_store_counter{PERF_TYPE_HW_CACHE, LLC_STORES};
    HWCounter llc_store_miss_counter{PERF_TYPE_HW_CACHE, LLC_STORE_MISSES};

    HWCounter dtlb_load_counter{PERF_TYPE_HW_CACHE, DTLB_LOADS};
    HWCounter dtlb_load_miss_counter{PERF_TYPE_HW_CACHE, DTLB_LOAD_MISSES};
    HWCounter dtlb_store_counter{PERF_TYPE_HW_CACHE, DTLB_STORES};
    HWCounter dtlb_store_miss_counter{PERF_TYPE_HW_CACHE, DTLB_STORE_MISSES};

    HWCounter itlb_load_miss_counter{PERF_TYPE_HW_CACHE, ITLB_LOAD_MISSES};

    HWCounter instr_counter{PERF_TYPE_HARDWARE, PERF_COUNT_HW_INSTRUCTIONS};
    HWCounter branch_miss_counter{PERF_TYPE_HARDWARE, PERF_COUNT_HW_BRANCH_MISSES};
    HWCounter branch_instr_counter{PERF_TYPE_HARDWARE, PERF_COUNT_HW_BRANCH_INSTRUCTIONS};

    HWCounter major_fault_counter{PERF_TYPE_SOFTWARE, PERF_COUNT_SW_PAGE_FAULTS_MAJ};
    HWCounter minor_fault_counter{PERF_TYPE_SOFTWARE, PERF_COUNT_SW_PAGE_FAULTS_MIN};
    
    uint64_t total_l1d_loads = 0;
    uint64_t total_l1d_misses = 0;
    uint64_t total_llc_loads = 0;
    uint64_t total_llc_misses = 0;
    uint64_t total_l1d_stores = 0;
    uint64_t total_l1i_misses = 0;
    uint64_t total_llc_stores = 0;
    uint64_t total_llc_store_misses = 0;
    uint64_t total_dtlb_loads = 0;
    uint64_t total_dtlb_load_misses = 0;
    uint64_t total_dtlb_stores = 0;
    uint64_t total_dtlb_store_misses = 0;
    uint64_t total_itlb_load_misses = 0;
    uint64_t total_major_faults = 0;
    uint64_t total_minor_faults = 0;
    uint64_t total_instructions = 0;
    uint64_t total_branch_misses = 0;
    uint64_t total_branch_instr = 0;

    __attribute__((always_inline)) void start() {
        instr_counter.start();
        branch_instr_counter.start();
        branch_miss_counter.start();
        l1d_load_counter.start();
        l1d_miss_counter.start();
        l1d_store_counter.start();
        l1i_miss_counter.start();
        llc_store_counter.start();
        llc_store_miss_counter.start();
        dtlb_load_counter.start();
        dtlb_load_miss_counter.start();
        dtlb_store_counter.start();
        dtlb_store_miss_counter.start();
        itlb_load_miss_counter.start();
        major_fault_counter.start();
        minor_fault_counter.start();
        llc_load_counter.start();
        llc_miss_counter.start();
    }

    __attribute__((always_inline)) void stop() {
        instr_counter.stop();
        l1d_load_counter.stop();
        l1d_miss_counter.stop();
        l1d_store_counter.stop();
        l1i_miss_counter.stop();
        llc_store_counter.stop();
        llc_store_miss_counter.stop();
        dtlb_load_counter.stop();
        dtlb_load_miss_counter.stop();
        dtlb_store_counter.stop();
        dtlb_store_miss_counter.stop();
        itlb_load_miss_counter.stop();
        major_fault_counter.stop();
        minor_fault_counter.stop();
        llc_load_counter.stop();
        llc_miss_counter.stop();
        branch_instr_counter.stop();
        branch_miss_counter.stop();
    }

    __attribute__((always_inline)) void accumulate() {
        total_l1d_loads += l1d_load_counter.read();
        total_l1d_misses += l1d_miss_counter.read();
        total_l1d_stores += l1d_store_counter.read();
        total_l1i_misses += l1i_miss_counter.read();
        total_llc_loads += llc_load_counter.read();
        total_llc_misses += llc_miss_counter.read();
        total_llc_stores += llc_store_counter.read();
        total_llc_store_misses += llc_store_miss_counter.read();
        total_dtlb_loads += dtlb_load_counter.read();
        total_dtlb_load_misses += dtlb_load_miss_counter.read();
        total_dtlb_stores += dtlb_store_counter.read();
        total_dtlb_store_misses += dtlb_store_miss_counter.read();
        total_itlb_load_misses += itlb_load_miss_counter.read();
        total_major_faults += major_fault_counter.read();
        total_minor_faults += minor_fault_counter.read();
        total_instructions += instr_counter.read();
        total_branch_instr += branch_instr_counter.read();
        total_branch_misses += branch_miss_counter.read();
    }
    void (const BenchContext& ctx, 
                            const CycleStats& stats, 
                            uint64_t tsc_freq);
};