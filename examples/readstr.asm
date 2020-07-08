%include	'../util.asm'

section		.text
global		_start

_start:
	lea		rdi, [prompt]
	call	printstr
	lea		rdi, [nome]
	mov		rsi, 99
	call	readstr			
	mov 	rdi, rax    ; readstr returns the umber of characters read
	call 	printint
	lea 	rdi, [msg]
	call 	printstr		
	lea 	rdi, [delim]
	call 	printstr	
	lea 	rdi, [nome]
	call 	printstr	
	lea 	rdi, [delim]
	call 	printstr	
	call 	endl		
	call 	exit0   
	
section		.data
prompt:		db 'Input a text: ', 0
delim:		db '"', 0
msg:		db ' char(s): ', 0

section     .bss
nome:		resb 100
            
