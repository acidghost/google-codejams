include ../Makefile.inc

sources = $(shell find -name *.c)
objects = $(sources:%.c=%)

.PHONY: all clean

all: main-build

main-build: $(objects)

%: %.c
	$(CC) $(CFLAGS) -o $@ $^

clean:
	rm -f $(objects)
