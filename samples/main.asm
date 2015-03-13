; nasm -f elf main.asm && ld -m elf_i386 -s -o main *.o

%include '../util.asm'

section    .text
global _start         ;must be declared for using gcc

_start:
	;mov ecx, msg
	;call print_str
	;mov ecx, 550044
	;call endl
	;call print_str
	
	;mov ecx, msgn
	;call print_str
	
	;mov ecx, nome
	;mov edx, 99
	;call read_str	
	
	;mov ecx, eax
	;call print_int
	
	mov ecx, 123456789
	call print_int
	call endl

	mov ecx, -87654321
	call print_int
	call endl
	
	mov ecx, 505050
	call print_int
	call endl
	
	mov ecx, 33033
	call print_int
	call endl
	
	mov ecx, 222
	call print_int
	call endl
	
	mov ecx, 90
	call print_int
	call endl
	
	mov ecx, -1
	call print_int
	call endl
	
	mov ecx, 6
	call print_int
	call endl
	
	call exit   
section	.data
    ; msg	db	'Este um teste!', 10, 0	
    ; msg	db	'Valor: ', 0	
    msgn	db	'Nome: ', 0
    nome times 100 db 0
            
