%include	'../util.asm'

section		.text
global		_start

_start:
	call	read_int
	
	mov 	rdi, rax
	call 	print_int
	call 	endl
	
	call 	exit   
	
            
section		.data
    nome 	times 100 db 0
