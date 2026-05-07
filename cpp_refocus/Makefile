CXX        = g++-16
CPPFLAGS  ?= -Iinclude -Ideps
BASEFLAGS ?= -O3 -std=c++17 -Wall -Wextra -pedantic

BUILD ?= build
COMMON_SRC ?= src/utils.cpp deps/lodepng.cpp

VERSIONS := basic basic-opt opt1 opt2 opt3 opt4 opt5 opt6 opt7 opt9 opt10 opt11

VER_SRC.basic     := basic
VER_SRC.basic-opt := basic
VER_SRC.opt1      := opt1
VER_SRC.opt2      := opt2
VER_SRC.opt3      := opt3
VER_SRC.opt4      := opt4
VER_SRC.opt5      := opt5
VER_SRC.opt6      := opt6
VER_SRC.opt7      := opt7
VER_SRC.opt9      := opt9
VER_SRC.opt10     := opt10
VER_SRC.opt11     := opt11

VER_FLAGS.basic     := -fno-tree-vectorize
VER_FLAGS.basic-opt := -march=native -ffast-math -fno-tree-vectorize
VER_FLAGS.opt1      := -march=native -ffast-math -fno-tree-vectorize
VER_FLAGS.opt2      := -march=native -ffast-math -fno-tree-vectorize
VER_FLAGS.opt3      := -march=native -ffast-math -fno-tree-vectorize
VER_FLAGS.opt4      := -march=native -ffast-math -fno-tree-vectorize
VER_FLAGS.opt5      := -march=native -ffast-math -fno-tree-vectorize
VER_FLAGS.opt6      := -march=native -ffast-math -fno-tree-vectorize
VER_FLAGS.opt7      := -march=native -ffast-math -fno-tree-vectorize
VER_FLAGS.opt9      := -march=native -ffast-math
VER_FLAGS.opt10     := -march=native -ffast-math
VER_FLAGS.opt11     := -march=native -ffast-math


STACK_BENCH_VERSIONS := stack_basic stack_opt1 stack_opt7
STACK_BENCH_SRC.stack_basic := src/stack_basic.cpp
STACK_BENCH_SRC.stack_opt1  := src/stack_opt1.cpp
STACK_BENCH_SRC.stack_opt7  := src/stack_opt7.cpp

define MAKE_STACK_BENCH_RULES
$(BUILD)/bench-$(1): src/bench.cpp $$(STACK_BENCH_SRC.$(1)) src/basic.cpp $$(COMMON_SRC) | $(BUILD)
	$$(CXX) $$(CPPFLAGS) $$(BASEFLAGS) -g $$(VER_FLAGS.basic-opt) -o $$@ $$^

$(BUILD)/$(1): src/stack_main.cpp $$(STACK_BENCH_SRC.$(1)) src/basic.cpp $$(COMMON_SRC) | $(BUILD)
	$$(CXX) $$(CPPFLAGS) $$(BASEFLAGS) $$(VER_FLAGS.basic-opt) -o $$@ $$^
endef

$(foreach ver,$(STACK_BENCH_VERSIONS),$(eval $(call MAKE_STACK_BENCH_RULES,$(ver))))

.PHONY: all app bench stack clean

all:   app bench stack
app:   $(addprefix $(BUILD)/,$(VERSIONS))
bench: $(addprefix $(BUILD)/bench-,$(VERSIONS))
stack: $(addprefix $(BUILD)/bench-,$(STACK_BENCH_VERSIONS)) $(addprefix $(BUILD)/,$(STACK_BENCH_VERSIONS))

define MAKE_RULES
$(BUILD)/$(1): src/main.cpp $$(COMMON_SRC) src/$$(VER_SRC.$(1)).cpp | $(BUILD)
	$$(CXX) $$(CPPFLAGS) $$(BASEFLAGS) $$(VER_FLAGS.$(1)) -o $$@ $$^

$(BUILD)/bench-$(1): src/bench.cpp $$(COMMON_SRC) src/$$(VER_SRC.$(1)).cpp | $(BUILD)
	$$(CXX) $$(CPPFLAGS) $$(BASEFLAGS) -g $$(VER_FLAGS.$(1)) -o $$@ $$^
endef

$(foreach ver,$(VERSIONS),$(eval $(call MAKE_RULES,$(ver))))

$(BUILD):
	mkdir -p $(BUILD)

clean:
	rm -rf $(BUILD)