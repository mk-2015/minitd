CC      = gcc
CFLAGS  = -Wall -Wextra -O2 -Iinclude -Ilibs/include -static
LDFLAGS = -static

SRC_DIR = src
INC_DIR = include
BIN_DIR = bin
OBJ_DIR = obj

LIBS_DIR    = libs
LIB_OUT_DIR = $(LIBS_DIR)/lib

SRCS   = $(shell find $(SRC_DIR) -type f -name '*.c')
OBJS   = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRCS))
TARGET = $(BIN_DIR)/init

LIB_NAMES := $(notdir $(wildcard $(LIBS_DIR)/src/*))

LDFLAGS += -L$(LIB_OUT_DIR) $(patsubst %,-l:%.a,$(LIB_NAMES))

all: libs $(BIN_DIR) $(OBJ_DIR) $(TARGET)
libs:
	$(MAKE) -C $(LIBS_DIR) static

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(TARGET): $(OBJS) libs
	$(CC) $(CFLAGS) $(OBJS) -o $@ $(LDFLAGS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR)
	$(MAKE) -C $(LIBS_DIR) clean

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

.PHONY: all clean prepmkinit libs