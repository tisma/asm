#!/bin/bash

nasm -f elf -o test.o test.s
ld -m elf_i386 -o test test.o

