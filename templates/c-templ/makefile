.TARGET: build

SRC_PATH = src
BIN_PATH = build/bin
OBJ_PATH = build/obj

CC = gcc
CFLAGS = -Wall
LFLAGS = -Wall

SOURCES = $(wildcard $(SRC_PATH)/*.c)
OBJECTS = $(addprefix $(OBJ_PATH)/,$(patsubst %.c,%.o,$(notdir $(SOURCES))))
BIN_NAME = main

build: $(OBJECTS)
	$(CC) -o $(BIN_PATH)/$(BIN_NAME) $(LFLAGS) $^

$(OBJ_PATH)/%.o: $(SRC_PATH)/%.c
	$(CC) -o $(OBJ_PATH)/$(notdir $@) -c $^ $(CFLAGS)

run: build
	./$(BIN_PATH)/$(BIN_NAME)

clean:
	rm -fv $(OBJ_PATH)/* $(BIN_PATH)/*

clean_obj:
	rm -fv $(OBJ_PATH)/*
