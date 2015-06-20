PROG=/usr/bin/openscad
FLAGS=
SRC_FILES=bottom_case_b200.scad  bottom_case_b210.scad  case_b200.scad  case_b210.scad  top_case_b200.scad  top_case_b210.scad
#SRC_FILES = $(wildcard *.scad)
STL_FILES = $(SRC_FILES:%.scad=%.stl)


all: $(STL_FILES)


%.stl: %.scad
	$(PROG) -o $@ $^

clean : 
	rm -rf *.stl
