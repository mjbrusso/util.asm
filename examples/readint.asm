%include	'../util.asm'

section		.text
global		_start

_start:
	mov		rdi, prompt
	call	printstr	
	call	readint
	mov     r14, rax
    shl     r14, 1      ;  r14 *= 2     
	mov		rdi, msg2
	call	printstr	
	mov		rdi, r14
	call 	printint
	call 	endl	
	call 	exit   
	
            
section		.data
prompt:		db 'Input a number: ', 0
msg2:		db 'Twice: ', 0
