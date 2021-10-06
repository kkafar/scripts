.TARGET: build

SRC_PATH = src
BIN_PATH = build/bin
OBJ_PATH = build/obj

CC = g++
CFLAGS = --std=c++17 -Wall -c
LFLAGS = --std=c++17 -Wall

SOURCES = $(wildcard $(SRC_PATH)/*)
OBJECTS = $(OBJ_PATH)/$(patsubst %.cpp,%.o,$(notdir $(SOURCES)))	
BIN_NAME = main

build: $(OBJECTS)
	$(CC) $(LFLAGS) $^ -o $(BIN_PATH)/$(BIN_NAME)

$(OBJ_PATH)/%.o: $(SRC_PATH)/%.cpp
	$(CC) $(CFLAGS) $^ -o $(OBJ_PATH)/$(notdir $@)

run: build
	./$(BIN_PATH)/$(BIN_NAME)

clean:
	rm -fv $(OBJ_PATH)/* $(BIN_PATH)/*

clean_obj:
	rm -fv $(OBJ_PATH)/*
