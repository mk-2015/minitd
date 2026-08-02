CC = gcc
CFLAGS = -static -O2 -Wall -Wextra -I../../include
LDFLAGS = -L../../lib -static
LDLIBS = -lunotifi

TARGET = minitctl
OUTDIR = ../../../bin
SRCS = minitctl.c
OBJS = $(SRCS:.c=.o)

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) -o $@ $^ $(LDFLAGS) $(LDLIBS)
	mkdir -p $(OUTDIR)
	cp $@ $(OUTDIR)/$@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(TARGET) $(OBJS)