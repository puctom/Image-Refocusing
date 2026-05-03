# Light Field Refocus Project Template

This repository contains the Rust reference implementation for the light field refocus algorithm to be implemented as part of the project and a C++ template for your implementation. Your algorithm should produce the same output as the Rust reference implementation when run on the same input data with the same focus parameter. The C++ template can be modified as required (including the existing C++ code).

### Input Data

The input light fields we use in this project can be found [here](https://graphics.stanford.edu/data/LF/lfs.html). Download the "Rectified and cropped images" zip file and extract the archive. The resulting directory should contain sub-aperture PNG images named like `out_00_00_-780.134705_-3355.331299_.png`; the path to this directory is the input passed to the implementations.

### STREAM Benchmark

Build the STREAM benchmark from STREAM directory with the following command:

```bash
gcc -O3 -march=native -fopenmp -DSTREAM_ARRAY_SIZE=100000000 stream.c -o stream
```

Run the benchmark:

```bash
OMP_NUM_THREADS=1 taskset -c 0 ./stream
```
