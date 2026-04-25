CXX       ?= g++
CPPFLAGS  ?= -Iinclude -Ideps
BASEFLAGS ?= -O3 -std=c++17 -Wall -Wextra -pedantic

BUILD ?= build

all: $(BUILD)/basic $(BUILD)/bench $(BUILD)/basic-opt

$(BUILD)/basic: src/main.cpp src/basic.cpp src/utils.cpp deps/lodepng.cpp | $(BUILD)
	$(CXX) $(CPPFLAGS) $(BASEFLAGS) -DBASIC -o $@ $^

$(BUILD)/basic-opt: src/main.cpp src/basic.cpp src/utils.cpp deps/lodepng.cpp | $(BUILD)
	$(CXX) $(CPPFLAGS) $(BASEFLAGS) -march=native -ffast-math -DBASIC -o $@ $^

$(BUILD)/bench: src/bench.cpp src/basic.cpp src/utils.cpp deps/lodepng.cpp | $(BUILD)
	$(CXX) $(CPPFLAGS) $(BASEFLAGS) -g -march=native -ffast-math -DBASIC -o $@ $^
# -g for perf annotate, does not impact the runtime

$(BUILD)/opt1: src/main.cpp src/opt1.cpp deps/lodepng.cpp | $(BUILD)
	$(CXX) $(CPPFLAGS) $(BASEFLAGS) -march=native -ffast-math -DBASIC -o $@ $^

$(BUILD):
	mkdir -p $(BUILD)

clean:
	rm -rf $(BUILD)

.PHONY: all clean
