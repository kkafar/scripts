.TARGET: build

SRC_PATH = src
BIN_PATH = build/bin
OBJ_PATH = build/obj

CC = gcc
CFLAGS = -Wall -c
LFLAGS = -Wall

SOURCES = $(wildcard $(SRC_PATH)/*)
OBJECTS = $(OBJ_PATH)/$(patsubst %.c,%.o,$(notdir $(SOURCES)))	
BIN_NAME = main

build: $(OBJECTS)
	$(CC) $(LFLAGS) $^ -o $(BIN_PATH)/$(BIN_NAME)

compile: $(OBJ_PATH)/%.o
	$(CC) $(CFLAGS) $^ -o $(OBJ_PATH)/$(notdir $@)


$(OBJ_PATH)/%.o: $(SRC_PATH)/%.c
	$(CC) $(CFLAGS) $^ -o $(OBJ_PATH)/$(notdir $@)

run: build
	./$(BIN_PATH)/$(BIN_NAME)

clean:
	rm -fv $(OBJ_PATH)/* $(BIN_PATH)/*

clean_obj:
	rm -fv $(OBJ_PATH)/*
