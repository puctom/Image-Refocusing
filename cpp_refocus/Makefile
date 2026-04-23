CXX       ?= g++
CPPFLAGS  ?= -Iinclude -Ideps
BASEFLAGS ?= -O3 -std=c++17 -Wall -Wextra -pedantic

BUILD ?= build

DATA         ?= /home/team15/project/in/validation
TIMING_CSV   ?= timing_results.csv
TIMING_SIZES ?= 1 5 10
TIMING_GENERATION_WH ?= 128 256 512 1024 2048 4096

all: $(BUILD)/basic $(BUILD)/bench $(BUILD)/basic-opt

$(BUILD)/basic: src/main.cpp src/basic.cpp deps/lodepng.cpp | $(BUILD)
	$(CXX) $(CPPFLAGS) $(BASEFLAGS) -DBASIC -o $@ $^

$(BUILD)/basic-opt: src/main.cpp src/basic.cpp deps/lodepng.cpp | $(BUILD)
	$(CXX) $(CPPFLAGS) $(BASEFLAGS) -march=native -ffast-math -DBASIC -o $@ $^

$(BUILD)/bench: src/bench.cpp src/basic.cpp deps/lodepng.cpp | $(BUILD) 
	$(CXX) $(CPPFLAGS) $(BASEFLAGS) -march=native -ffast-math -DBASIC -o $@ $^

timing: $(BUILD)/bench
	@echo "variant,data_source,n_focal,img_w,img_h,n_subapertures,total_s,per_focal_ms,median_ms,min_ms,max_ms,mpixels_s,cycles_per_focal" > $(TIMING_CSV)
	@echo "Running real dataset..."
	@for n in $(TIMING_SIZES); do \
		./$(BUILD)/bench $(DATA) $$n real_n$$n $(TIMING_CSV); \
	done
	@echo "Running generated dataset..."
	@for wh in $(TIMING_GENERATION_WH); do \
		for n in $(TIMING_SIZES); do \
			./$(BUILD)/bench --generate $$wh $$wh $$n gen_$${wh}_$${n} $(TIMING_CSV); \
		done; \
	done
	@column -t -s, $(TIMING_CSV)

$(BUILD):
	mkdir -p $(BUILD)

clean:
	rm -rf $(BUILD)

.PHONY: all clean timing