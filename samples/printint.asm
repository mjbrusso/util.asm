%include '../util.asm'

section    .text
global _start         ;must be declared for using gcc

_start:
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

            
