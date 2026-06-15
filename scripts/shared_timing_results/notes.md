Example output using perf stat

```
$ perf stat -d ./cpp_refocus/build/bench ./in/validation/ 3.234 "real_data1_perf" ./scripts/timing_results/time_perf_test.csv
  289 sub-apertures, 1024x512 px each
TSC frequency: 2.4192 GHz

 Timing results: 
variant : real_data1_perf
data source : real
focus : 3.234
runs : 10
image size : 1024x512
n subapertures : 289
time: 36.1257 s (avg = 3612.57ms med=3612.85 min=3611.04 max=3613.62)
cycles/whole image: total: 87395158740, avg: 8739515874 (med=8740188147 min=8735804979 max=8742048828)
cycles/pixel : avg: 16669.3
throughput : 0.145129 Mpixels/s
mem bandwidth : 0.125827 GB/s (est)
avg_cache_misses : 6.86536e+06 
avg_instructions : 1.53891e+10
instructions per cycle : 1.76087

 Performance counter stats for './cpp_refocus/build/bench ./in/validation/ 3.234 real_data1_perf ./scripts/timing_results/time_perf_test.csv':

         44,034.26 msec task-clock                       #    0.995 CPUs utilized             
               524      context-switches                 #   11.900 /sec                      
                 0      cpu-migrations                   #    0.000 /sec                      
           112,970      page-faults                      #    2.566 K/sec                     
   105,157,830,029      cycles                           #    2.388 GHz                         (77.80%)
   273,778,383,369      instructions                     #    2.60  insn per cycle              (79.45%)
    22,313,898,664      branches                         #  506.740 M/sec                       (79.45%)
        86,265,872      branch-misses                    #    0.39% of all branches             (71.50%)
                        TopdownL1                 #     10.8 %  tma_backend_bound      
                                                  #     75.7 %  tma_bad_speculation    
                                                  #      1.9 %  tma_frontend_bound     
                                                  #     11.6 %  tma_retiring             (79.43%)
    52,995,366,627      L1-dcache-loads                  #    1.204 G/sec                       (79.43%)
     4,999,502,308      L1-dcache-load-misses            #    9.43% of all L1-dcache accesses   (79.44%)
        13,887,705      LLC-loads                        #  315.384 K/sec                       (79.44%)
         7,076,163      LLC-load-misses                  #   50.95% of all LL-cache accesses    (79.43%)

      44.245940940 seconds time elapsed

      43.838624000 seconds user
       0.195975000 seconds sys

```