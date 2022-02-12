#!/bin/sh

set -e

[ -e cosmopolitan/cosmopolitan.a ] || tar -xvzf ../cosmopolitan/dist/cosmopolitan.tar.gz

# Compile an ELF binary
nim c -d:danger --opt:size -o:hello.elf hello.nim

# Get the actual portable executable
objcopy -SO binary hello.elf hello.com
