CXX        = g++-16
CPPFLAGS  ?= -Iinclude -Ideps -I/opt/intel/oneapi/advisor/latest/sdk/include
BASEFLAGS ?= -O3 -std=c++17 -Wall -Wextra -pedantic
LDLIBS    ?= /opt/intel/oneapi/advisor/latest/sdk/lib64/libittnotify.a

BUILD ?= build
COMMON_SRC ?= src/utils.cpp deps/lodepng.cpp
BENCH_COMMON_SRC := src/bench_common.cpp

VERSIONS := basic basic-opt opt1 opt2 opt3 opt4 opt5 opt6 opt7 opt8 opt_compiler_vec opt9 opt10 opt11 opt12 opt13 opt14 opt15 opt16 opt17

VER_SRC.basic     := basic
VER_SRC.basic-opt := basic
VER_SRC.opt1      := opt1
VER_SRC.opt2      := opt2
VER_SRC.opt3      := opt3
VER_SRC.opt4      := opt4
VER_SRC.opt5      := opt5
VER_SRC.opt6      := opt6
VER_SRC.opt7      := opt7
VER_SRC.opt8      := opt8
VER_SRC.opt9      := opt9
VER_SRC.opt10     := opt10
VER_SRC.opt11     := opt11
VER_SRC.opt12     := opt12
VER_SRC.opt13     := opt13
VER_SRC.opt14     := opt14
VER_SRC.opt15     := opt15
VER_SRC.opt16     := opt16
VER_SRC.opt17     := opt17
# Best compiler vectorization without intrinsics in code:
VER_SRC.opt_compiler_vec      := opt7

VER_FLAGS.basic     := -fno-tree-vectorize
VER_FLAGS.basic-opt := -march=native -ffast-math -fno-tree-vectorize
VER_FLAGS.opt1      := -march=native -ffast-math -fno-tree-vectorize
VER_FLAGS.opt2      := -march=native -ffast-math -fno-tree-vectorize
VER_FLAGS.opt3      := -march=native -ffast-math -fno-tree-vectorize
VER_FLAGS.opt4      := -march=native -ffast-math -fno-tree-vectorize
VER_FLAGS.opt5      := -march=native -ffast-math -fno-tree-vectorize
VER_FLAGS.opt6      := -march=native -ffast-math -fno-tree-vectorize
VER_FLAGS.opt7      := -march=native -ffast-math -fno-tree-vectorize
VER_FLAGS.opt8      := -march=native -ffast-math -fno-tree-vectorize
VER_FLAGS.opt9      := -march=native -ffast-math
VER_FLAGS.opt10     := -march=native -ffast-math
VER_FLAGS.opt11     := -march=native -ffast-math -mavx2 -mfma
VER_FLAGS.opt12     := -march=native -ffast-math -mavx2 -mfma
VER_FLAGS.opt13     := -march=native -ffast-math -mavx2 -mfma
VER_FLAGS.opt14     := -march=native -ffast-math -mavx2 -mfma
VER_FLAGS.opt15     := -march=native -ffast-math -mavx2 -mfma
VER_FLAGS.opt16     := -march=native -ffast-math -mavx2 -mfma
VER_FLAGS.opt17     := -march=native -ffast-math -mavx2 -mfma
VER_FLAGS.opt_compiler_vec	:= -march=native -ffast-math

STACK_BENCH_VERSIONS := stack_basic stack_opt1 stack_opt2 stack_opt3 stack_opt4 stack_opt5 stack_avx stack_opt6 stack_opt7 stack_opt8 stack_opt9 stack_opt10

STACK_BENCH_SRC.stack_basic := src/stack_basic.cpp src/basic.cpp
STACK_BENCH_SRC.stack_opt1  := src/stack_opt1.cpp
STACK_BENCH_SRC.stack_opt2  := src/stack_opt2.cpp
STACK_BENCH_SRC.stack_opt3  := src/stack_opt3.cpp
STACK_BENCH_SRC.stack_opt4  := src/stack_opt4.cpp
STACK_BENCH_SRC.stack_opt5  := src/stack_opt5.cpp
STACK_BENCH_SRC.stack_avx   := src/stack_avx.cpp
STACK_BENCH_SRC.stack_opt6  := src/stack_opt6.cpp
STACK_BENCH_SRC.stack_opt7  := src/stack_opt7.cpp
STACK_BENCH_SRC.stack_opt8  := src/stack_opt8.cpp
STACK_BENCH_SRC.stack_opt9  := src/stack_opt9.cpp
STACK_BENCH_SRC.stack_opt10 := src/stack_opt10.cpp

STACK_VER_FLAGS.stack_basic := -march=native -ffast-math -fno-tree-vectorize
STACK_VER_FLAGS.stack_opt1  := -march=native -ffast-math -fno-tree-vectorize
STACK_VER_FLAGS.stack_opt2  := -march=native -ffast-math -fno-tree-vectorize
STACK_VER_FLAGS.stack_opt3  := -march=native -ffast-math -fno-tree-vectorize
STACK_VER_FLAGS.stack_opt4  := -march=native -ffast-math -fno-tree-vectorize
STACK_VER_FLAGS.stack_opt5  := -march=native -ffast-math -fno-tree-vectorize
STACK_VER_FLAGS.stack_avx   := -march=native -ffast-math -mavx2 -mfma
STACK_VER_FLAGS.stack_opt6  := -march=native -ffast-math -mavx2 -mfma
STACK_VER_FLAGS.stack_opt7  := -march=native -ffast-math -mavx2 -mfma
STACK_VER_FLAGS.stack_opt8  := -march=native -ffast-math -mavx2 -mfma
STACK_VER_FLAGS.stack_opt9  := -march=native -ffast-math -mavx2 -mfma
STACK_VER_FLAGS.stack_opt10 := -march=native -ffast-math -mavx2 -mfma

define MAKE_STACK_RULES
# `src/basic.cpp` included to link against bench_basic.cpp
$(BUILD)/$(1): src/stack_main.cpp $$(STACK_BENCH_SRC.$(1)) $$(COMMON_SRC) src/basic.cpp | $(BUILD)
	$$(CXX) $$(CPPFLAGS) $$(BASEFLAGS) $$(STACK_VER_FLAGS.$(1)) -o $$@ $$^ $$(LDLIBS)

$(BUILD)/bench-$(1): src/bench_stack.cpp $$(STACK_BENCH_SRC.$(1)) $$(BENCH_COMMON_SRC) $$(COMMON_SRC) src/basic.cpp | $(BUILD)
	$$(CXX) $$(CPPFLAGS) $$(BASEFLAGS) -g $$(STACK_VER_FLAGS.$(1)) -o $$@ $$^ $$(LDLIBS)
endef

$(foreach ver,$(STACK_BENCH_VERSIONS),$(eval $(call MAKE_STACK_RULES,$(ver))))

.PHONY: all app bench stack clean

all:   app bench stack
app:   $(addprefix $(BUILD)/,$(VERSIONS))
bench: $(addprefix $(BUILD)/bench-,$(VERSIONS))
stack: $(addprefix $(BUILD)/bench-,$(STACK_BENCH_VERSIONS)) $(addprefix $(BUILD)/,$(STACK_BENCH_VERSIONS))

define MAKE_RULES
$(BUILD)/$(1): src/main.cpp $$(COMMON_SRC) src/$$(VER_SRC.$(1)).cpp | $(BUILD)
	$$(CXX) $$(CPPFLAGS) $$(BASEFLAGS) $$(VER_FLAGS.$(1)) -o $$@ $$^ $$(LDLIBS)

$(BUILD)/bench-$(1): src/bench.cpp $$(COMMON_SRC) $$(BENCH_COMMON_SRC) src/$$(VER_SRC.$(1)).cpp | $(BUILD)
	$$(CXX) $$(CPPFLAGS) $$(BASEFLAGS) -g $$(VER_FLAGS.$(1)) -o $$@ $$^ $$(LDLIBS)
endef

$(foreach ver,$(VERSIONS),$(eval $(call MAKE_RULES,$(ver))))

$(BUILD):
	mkdir -p $(BUILD)

clean:
	rm -rf $(BUILD)
