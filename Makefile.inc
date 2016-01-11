CC = gcc
DB = gdb
CFLAGS = -Wall -std=gnu11 -g -O3
SHELL = /bin/bash


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
