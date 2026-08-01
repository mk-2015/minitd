CC = gcc
CFLAGS = -O2 -Wall -Wextra -I../../include
LDFLAGS = -L../../lib -lunotifi -static
TARGET = minitctl
OUTDIR = ../../../bin
SRCS = minitctl.c
OBJS = $(SRCS:.c=.o)

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^
	mkdir -p $(OUTDIR)
	cp $@ $(OUTDIR)/$@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(TARGET) $(OBJS)
