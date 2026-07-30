CC = gcc
CFLAGS = -Wall -Wextra -O2 -Iinclude -static
LDFLAGS = -static

SRC_DIR = src
INC_DIR = include
BIN_DIR = bin
OBJ_DIR = obj

SRCS = $(shell find $(SRC_DIR) -type f -name '*.c')
OBJS = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRCS))
TARGET = $(BIN_DIR)/init

all: $(BIN_DIR) $(OBJ_DIR) $(TARGET)

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $@ $(LDFLAGS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR)

prepmkinit:
	@sudo mkinitcpio -c ./base/minit-mkinitcpio.conf -g ./base/initramfs.img -k $(shell uname -r)
	@dd if=/dev/zero of=./base/disk.img bs=1M count=512
	@mkfs.ext4 -F ./base/disk.img

	@sudo umount /tmp/_root 2>/dev/null || true
	@mkdir -p /tmp/_root
	@sudo mount -o loop ./base/disk.img /tmp/_root
	@sudo cp -a ./base/rootfs/* /tmp/_root/
	@sudo mkdir /tmp/_root/sbin
	@sudo cp -a ./base/rootfs/init /tmp/_root/sbin/init
	@sudo umount /tmp/_root

.PHONY: all clean prepmkinit