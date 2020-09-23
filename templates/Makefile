# K. Kafara
# Makefile template for SPOJ problems

.DEFAULT_GOAL: main
.PHONY: clean run

CPP = g++
CPP_STD = --std=c++17
CFLAGS = $(CPP_STD) -Wall -O2 -c
LFLAGS = $(CPP_STD) -Wall -O2
OBJ = main.o
SRC = main.c


main: main.o
	$(CPP) $(LFLAGS) main.o -o main

main.o: main.cpp
	$(CPP) $(CFLAGS) main.cpp -o main.o

run: 
	./main

clean: 
	rm -v *.o main *.aux *.fdb_latexmk *.fls *.log *.gz

