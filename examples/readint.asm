%include	'../util.asm'

section		.text
global		_start

_start:
	lea		rdi, [prompt]
	call	printstr	
	call	readint
	shl     rax, 1      ;  rax *= 2     
  	mov		rdi, rax    
	call 	printint
	call 	endl	
	call 	exit0   
	            
section		.data
prompt:		db 'Input a number: ', 0