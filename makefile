dir_libcomfy=/Users/josh/Projekte/libcomfy
LDLIBS=-lglfw3 -lglew -lcomfy -lSOIL
LDLIBS+=-framework Cocoa -framework OpenGL -framework IOKit -framework CoreVideo

CFLAGS=-std=c11 -Iinclude -I$(dir_libcomfy)/include -g
CC=clang

LDFLAGS=-L$(dir_libcomfy) -Llib

all_comfy=$(wildcard src/*.comfy)
all_headers=$(patsubst src/%.comfy,build/%.h,$(all_comfy))
all_c_src=$(patsubst src/%.comfy,build/%.c,$(all_comfy))
all_obj=$(patsubst src/%.comfy,build/%.o,$(all_comfy))

build/meshinator: $(all_obj)


build/%.c: src/%.comfy | $(all_headers)
	comfy $(?F) --source src --target build --c-files

build/%.h: src/%.comfy
	comfy $(?F) --source src --target build --headers

.SECONDARY:

prepare:
	mkdir -p build

clean:
	$(RM) $(all_obj)
	$(RM) $(all_headers)
	$(RM) $(all_c_src)
	$(RM) me2

.PHONY: clean
