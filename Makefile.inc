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
	ghc -O3 -o $@ $^

clean-hask:
	rm -f $(hs_obj) $(wildcard *.hi) $(wildcard *.o)

clean-c:
	rm -f $(objects)

clean: clean-c clean-hask
