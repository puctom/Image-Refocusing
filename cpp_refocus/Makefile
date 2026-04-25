CXX       ?= g++
CPPFLAGS  ?= -Iinclude -Ideps
BASEFLAGS ?= -O3 -std=c++17 -Wall -Wextra -pedantic

BUILD ?= build
COMMON_SRC ?= src/utils.cpp deps/lodepng.cpp

VERSIONS := basic basic-opt opt1 opt2 opt3 opt4

VER_SRC.basic     := basic
VER_SRC.basic-opt := basic
VER_SRC.opt1      := opt1
VER_SRC.opt2      := opt2
VER_SRC.opt3      := opt3
VER_SRC.opt4      := opt4

VER_FLAGS.basic     := 
VER_FLAGS.basic-opt := -march=native -ffast-math
VER_FLAGS.opt1      := -march=native -ffast-math
VER_FLAGS.opt2      := -march=native -ffast-math
VER_FLAGS.opt3      := -march=native -ffast-math
VER_FLAGS.opt4      := -march=native -ffast-math


.PHONY: all app bench clean

all:   app bench
app:  $(addprefix $(BUILD)/,$(VERSIONS))
bench: $(addprefix $(BUILD)/bench-,$(VERSIONS))

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

