# Makefile for uil.asm assembly samples

all:	hello printint readstr

hello:	hello.asm
	nasm -felf64 hello.asm
	ld -o hello hello.o

printint:	printint.asm
	nasm -felf64 printint.asm
	ld -o printint printint.o

readstr:	readstr.asm
	nasm -felf64 readstr.asm
	ld -o readstr readstr.o
		
rebuild:
	make clean
	make all

clean:
	rm -f hello printint readstr
	rm -f *~
	rm -f *.o
