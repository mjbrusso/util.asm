; nasm -f elf main.asm && ld -m elf_i386 -s -o main *.o

%include 'util.asm'

section    .text
global _start         ;must be declared for using gcc

_start:
	mov ecx, msg
	call print_str
	mov ecx, 550044
	call print_int
	mov ecx, endl
	call print_str
	call exit
    
section	.data
    ;msg	db	'Este um teste!', 10, 0	
    msg	db	'Valor: ', 0	
    endl db 10,0
    

