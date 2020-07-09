%include	'../util.asm'

section		.text
global		_start

_start:
	lea		rdi, [prompt]
	call	printstr	
	call	readint
    mov     r14, rax
  	mov		rdi, rax
	call 	printint
    shl     r14, 1      ;  r14 *= 2     
	lea		rdi, [str2]
	call	printstr	
	mov		rdi, r14
	call 	printint
	call 	endl	
	call 	exit0   
	
            
section		.data
prompt:		db 'Input a number: ', 0
str2:		db ' * 2 = ', 0
