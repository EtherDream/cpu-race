CXX = clang++
CXXFLAGS ?= -O3 -Wall -std=c++23
WAT2WASM ?= wat2wasm
WATFLAGS ?=

.PHONY: all native wasm base64

all: native wasm

native: mrx

wasm: mrx.wasm

mrx.wasm: mrx.wat Makefile
	$(WAT2WASM) $(WATFLAGS) $< -o $@
