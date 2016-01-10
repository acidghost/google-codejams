include ../Makefile.inc

sources = $(shell find -name *.c)
objects = $(sources:%.c=%)
hs_src = $(shell find -name *.hs)
hs_obj = $(hs_src:%.hs=%-hs)

.PHONY: all clean

all: c hask

c: $(objects)

%: %.c
	$(CC) $(CFLAGS) -o $@ $^

hask: $(hs_src)

%.hs: %
	ghc -O3 -o $(^)-hs $@

clean:
	rm -f $(objects) $(hs_obj) $(wildcard *.hi) $(wildcard *.o)
