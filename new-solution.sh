#!/bin/bash

solution="$1"

if [ -d "$solution" ]; then
	echo "$solution already exists..."
	exit 1
else
	printf "Creating $solution..."
	mkdir -p $solution
	printf "include ../Makefile.inc\n" > $solution/Makefile
	printf $solution"\n"$solution"-hs\n" > $solution/.gitignore
	printf "...done\n"
fi
