PROG=/usr/bin/openscad
FLAGS=
SRC_FILES = $(wildcard *.scad)
STL_FILES = $(SRC_FILES:%.scad=%.stl)


all: $(STL_FILES)


%.stl: %.scad
	$(PROG) -o $@ $^

clean : 
	rm -rf *.stl
