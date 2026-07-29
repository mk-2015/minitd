CC = gcc
CFLAGS = -Wall -Wextra -O2 -Iinclude -static
LDFLAGS = -static

SRC_DIR = src
INC_DIR = include
BIN_DIR = bin

SRCS = $(wildcard $(SRC_DIR)/*.c)
OBJS = $(SRCS:.c=.o)
TARGET = $(BIN_DIR)/init

all: $(BIN_DIR) $(TARGET)

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(SRC_DIR)/*.o $(TARGET)
	rm -rf $(BIN_DIR)

.PHONY: all clean
