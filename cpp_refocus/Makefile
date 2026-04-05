CXX      ?= g++
CXXFLAGS ?= -O3 -march=native -ffast-math -std=c++17 -Wall -Wextra -pedantic

DEPS_SRC := deps/lodepng.cpp

DATA         ?= ../in/validation
TIMING_CSV   ?= timing_results.csv
TIMING_SIZES ?= 10 50 200 500

all: refocus bench

refocus: src/main.cpp $(DEPS_SRC)
	$(CXX) $(CXXFLAGS) -o $@ $^

bench: src/bench.cpp $(DEPS_SRC)
	$(CXX) $(CXXFLAGS) -o $@ $^

timing:
	@echo "variant,n_focal,img_w,img_h,n_subapertures,total_s,per_focal_ms,median_ms,min_ms,max_ms,mpixels_s" > $(TIMING_CSV)
	@for entry in \
		"O3_native_fast|-O3 -march=native -ffast-math" \
		"O3_native|-O3 -march=native" \
		"O3_novec|-O3 -march=native -fno-tree-vectorize" \
		"O2|-O2"; do \
		label=$$(echo $$entry | cut -d'|' -f1); \
		flags=$$(echo $$entry | cut -d'|' -f2); \
		echo "=== Building $$label ($$flags) ==="; \
		g++ -std=c++17 $$flags -o bench_$$label src/bench.cpp $(DEPS_SRC); \
		for n in $(TIMING_SIZES); do \
			echo "  Running $$label n=$$n..."; \
			./bench_$$label $(DATA) $$n $$label $(TIMING_CSV); \
		done; \
	done
	@column -t -s, $(TIMING_CSV)

clean:
	rm -f refocus bench bench_* $(TIMING_CSV)

.PHONY: all clean timing
