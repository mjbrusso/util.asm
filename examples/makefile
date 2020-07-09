# Makefile for util.asm assembly samples

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
	FORMAT = elf64
endif
ifeq ($(UNAME_S),Darwin)
	FORMAT = macho64
endif


all:	hello printint readstr readint

hello:	hello.asm ../util.asm
	nasm -f $(FORMAT) hello.asm
	ld -o hello hello.o

readstr:	readstr.asm ../util.asm
	nasm -f $(FORMAT) readstr.asm
	ld -o readstr readstr.o
		
printint:	printint.asm ../util.asm
	nasm -f $(FORMAT) printint.asm
	ld -o printint printint.o

readint:	readint.asm ../util.asm
	nasm -f $(FORMAT) readint.asm
	ld -o readint readint.o
	
rebuild:
	make clean
	make all

clean:
	rm -f hello printint readstr readint
	rm -f *~
	rm -f *.o
