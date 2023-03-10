#!/usr/bin/env -vS make -f

PREFIX?=/usr/local

PROG = nzcc

CC ?= gcc
CXX ?= g++
CFLAGS = -W -Wall
CXXFLAGS = -std=c++11 $(CFLAGS)
OPTS = -O3 -fpermissive -ggdb3 -fverbose-asm -mtune=generic 
LD = $(CXX)
LFLAGS = -static

DEFS = -DNDEBUG -DSTRICT
DEFS += -D"__extern_always_inline=extern __always_inline" -D_aligned_malloc=_mm_malloc -D_aligned_free=_mm_free
INCS = -I.
CXXFLAGS += $(OPTS) $(INCS) $(DEFS) -Wfatal-errors

SRCS = nzcc.cpp
OBJS = nzcc.o

.c.o:
	$(CC) $(CFLAGS) -c -o $@ $<
.cpp.o:
	$(CXX) $(CXXFLAGS) -c -o $@ $<

all: $(PROG)

$(PROG): $(OBJS)
	$(LD) $(LFLAGS) -o $@ $^

install: all
	mkdir -p -v "$(PREFIX)"/bin/
	install -p -m 0755 -v nzcc "$(PREFIX)"/bin/

clean:
	$(RM) $(PROG) $(OBJS)
