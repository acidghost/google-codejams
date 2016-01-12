CC = gcc
DB = gdb
CFLAGS = -Wall -std=gnu11 -g -O3
SHELL = /bin/bash


sources = $(wildcard *.c)
objects = $(sources:%.c=%)
hs_src = $(wildcard *.hs)
hs_obj = $(hs_src:%.hs=%-hs)


.PHONY: all clean

all: c hask

c: $(objects)

%: %.c
	$(CC) $(CFLAGS) -o $@ $^

hask: $(hs_obj)

%-hs: %.hs
	ghc -O3 -i../ -o $@ $^

clean-hask:
	rm -rf $(hs_obj) $(wildcard *.hi) $(wildcard *.o) *.dSYM

clean-c:
	rm -f $(objects)

clean: clean-c clean-hask
