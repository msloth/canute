#
# Makefile para canute.c - Por C2H5OH
#
# Use 'make' para compilar tanto la versi�n POSIX como win32
#

CC     ?= /usr/bin/gcc
CCROSS ?= /usr/bin/i586-mingw32msvc-gcc
CFLAGS  := -O2 -Wall -pipe -fomit-frame-pointer
LDFLAGS := -Wl,-s,-O1
ARCH    := -march=pentium-m

all: canute canute.exe

install: $(HOME)/bin/canute

$(HOME)/bin/canute: canute
	@cp -fv $< $@

canute: canute.o
	$(CC) $(LDFLAGS) -o $@ $^

canute.exe: canute.obj
	$(CCROSS) -L/usr/i586-mingw32msvc/lib $(LDFLAGS) -o $@ $^ -lwsock32

%.o: %.c
	$(CC) $(CFLAGS) $(ARCH) -c $^

%.obj: %.c
	$(CCROSS) $(CFLAGS) -c -o $@ $^ 

.PHONY: clean
clean:
	@-rm -fv *.o *.obj canute canute.exe
