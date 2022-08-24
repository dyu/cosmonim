#!/bin/sh

set -e

GCC=../cosmopolitan/o/third_party/gcc/bin/x86_64-linux-musl-gcc
OBJCOPY=../cosmopolitan/o/third_party/gcc/bin/x86_64-linux-musl-objcopy

#BIN_DIR=/nix/store/kia8xygy2r9iblwbjrl163j4bpz84wz7-gcc-wrapper-11.3.0/bin
#[ -e $BIN_DIR ] && GCC=$BIN_DIR/gcc && OBJCOPY=$BIN_DIR/objcopy && echo "Using gcc and objcopy from $BIN_DIR"

EXAMPLE=hello
DIR=cosmopolitan

[ ! -e dist/$DIR/cosmopolitan.a ] && mkdir -p dist && cd dist && tar -xvzf ../../cosmopolitan/dist/cosmopolitan.tar.gz && cd ..

# Compile an ELF binary
nim c --os:linux -d:danger --compileOnly:on --nimcache:nim-cache $EXAMPLE.nim

$GCC -g -static -nostdlib -nostdinc -fno-pie -no-pie -mno-red-zone \
  -fno-omit-frame-pointer -pg -mnop-mcount -mno-tls-direct-seg-refs -Wno-error=maybe-uninitialized \
  -o dist/$EXAMPLE.com.dbg nim-cache/*.c -fuse-ld=bfd -Wl,-T,dist/$DIR/ape.lds -Wl,--gc-sections \
  -include dist/$DIR/cosmopolitan.h -Idist/$DIR -I/data/dyu/dotdirs/choosenim/toolchains/nim-1.6.6/lib -Istubs \
  dist/$DIR/crt.o dist/$DIR/ape-no-modify-self.o dist/$DIR/cosmopolitan.a

$OBJCOPY -S -O binary dist/$EXAMPLE.com.dbg dist/$EXAMPLE.com

