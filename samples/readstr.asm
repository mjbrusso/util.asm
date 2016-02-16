%include	'../util.asm'

section		.text
global		_start

_start:
	lea		rdi, [prompt]
	call	printstr
	
	lea		rdi, [nome]
	mov		rsi, 99
	call	readstr	
		
	mov 	rdi, rax
	call 	printint
	lea 	rdi, [msg]
	call 	printstr	

	call 	endl
	
	lea 	rdi, [delim]
	call 	printstr	
	lea 	rdi, [nome]
	call 	printstr	
	lea 	rdi, [delim]
	call 	printstr	
	call 	endl
		
	call 	exit   
	
section		.data
    prompt	db 'Nome: ', 0
    delim 	db '"', 0
    msg 	db ' chars', 0
    nome 	times 100 db 0
            
