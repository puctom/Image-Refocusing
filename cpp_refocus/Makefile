CXX       ?= g++
CPPFLAGS  ?= -Iinclude -Ideps
BASEFLAGS ?= -O3 -std=c++17 -Wall -Wextra -pedantic

BUILD ?= build

DATA         ?= ../in/validation
TIMING_CSV   ?= timing_results.csv
TIMING_SIZES ?= 10 50 200 500

all: $(BUILD)/basic $(BUILD)/bench $(BUILD)/basic-opt

$(BUILD)/basic: src/main.cpp src/basic.cpp deps/lodepng.cpp | $(BUILD)
	$(CXX) $(CPPFLAGS) $(BASEFLAGS) -DBASIC -o $@ $^

$(BUILD)/basic-opt: src/main.cpp src/basic.cpp deps/lodepng.cpp | $(BUILD)
	$(CXX) $(CPPFLAGS) $(BASEFLAGS) -march=native -ffast-math -DBASIC -o $@ $^

$(BUILD)/bench: src/bench.cpp src/basic.cpp deps/lodepng.cpp | $(BUILD) 
	$(CXX) $(CPPFLAGS) $(BASEFLAGS) -DBASIC -o $@ $^

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
		g++ -std=c++17 $$flags -o build/bench_$$label src/bench.cpp src/basic.cpp deps/lodepng.cpp; \
		for n in $(TIMING_SIZES); do \
			echo "  Running $$label n=$$n..."; \
			./build/bench_$$label $(DATA) $$n $$label $(TIMING_CSV); \
		done; \
	done
	@column -t -s, $(TIMING_CSV)

$(BUILD):
	mkdir -p $(BUILD)

clean:
	rm -rf build

.PHONY: all clean timing
