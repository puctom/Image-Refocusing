#pragma once
#include <linux/perf_event.h>
#include <sys/syscall.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <cstring>
#include <cerrno>
#include <iostream>
#include <stdexcept>
#include <cstdint>

// This file is for having access to hardware performance counters 
// from C++ code, so that we can isolate it to the concrete function

class HWCounter {
    int fd = -1;

    static void warn_unavailable(uint32_t type, uint64_t config, int error) {
        static bool warned = false;
        if (warned) return;
        warned = true;

        std::cerr
            << "Warning: perf_event_open failed for perf counter type=" << type
            << " config=" << config
            << " (errno=" << error << ": " << std::strerror(error) << ").\n"
            << "Timing will continue, but perf counter columns will be reported as 0.\n"
            << "If kernel.perf_event_paranoid is already -1 on Google Cloud, the VM "
            << "probably needs PMU support enabled with --performance-monitoring-unit "
            << "on a supported C4/C4A machine type.\n";
    }

public:
    HWCounter(uint32_t type, uint64_t config) {
        struct perf_event_attr pe;
        std::memset(&pe, 0, sizeof(struct perf_event_attr));
        pe.type = type;
        pe.size = sizeof(struct perf_event_attr);
        pe.config = config;
        pe.disabled = 1;          // Start disabled
        pe.exclude_kernel = 1;    // Don't count OS kernel space events
        pe.exclude_hv = 1;        // Don't count hypervisor events

        // syscall to open the performance counter for the current process/thread
        fd = syscall(__NR_perf_event_open, &pe, 0, -1, -1, 0);
        if (fd == -1) {
            warn_unavailable(type, config, errno);
        }
    }

    ~HWCounter() {
        if (fd != -1) close(fd);
    }

    void start() {
        if (fd == -1) return;
        ioctl(fd, PERF_EVENT_IOC_RESET, 0);
        ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);
    }

    void stop() {
        if (fd == -1) return;
        ioctl(fd, PERF_EVENT_IOC_DISABLE, 0);
    }

    uint64_t read() {
        if (fd == -1) return 0;
        uint64_t count;
        if (::read(fd, &count, sizeof(uint64_t)) == -1) return 0;
        return count;
    }
};
