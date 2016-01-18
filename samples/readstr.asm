%include	'../util.asm'

section		.text
global		_start

_start:
	lea		rdi, [prompt]
	call	print_str
	
	lea		rdi, [nome]
	mov		rsi, 99
	call	read_str	
		
	mov 	rdi, rax
	call 	print_int
	lea 	rdi, [msg]
	call 	print_str	

	call 	endl
	
	lea 	rdi, [delim]
	call 	print_str	
	lea 	rdi, [nome]
	call 	print_str	
	lea 	rdi, [delim]
	call 	print_str	
	call 	endl
		
	call 	exit   
	
section		.data
    prompt	db 'Nome: ', 0
    delim 	db '"', 0
    msg 	db ' chars', 0
    nome 	times 100 db 0
            
