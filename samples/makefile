# Makefile for util.asm assembly samples

all:	hello printint readstr

hello:	hello.asm ../util.asm
	nasm -felf64 hello.asm
	ld -o hello hello.o

readstr:	readstr.asm ../util.asm
	nasm -felf64 readstr.asm
	ld -o readstr readstr.o
		
printint:	printint.asm ../util.asm
	nasm -felf64 printint.asm
	ld -o printint printint.o

rebuild:
	make clean
	make all

clean:
	rm -f hello printint readstr
	rm -f *~
	rm -f *.o
