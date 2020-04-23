%include	'../util.asm'

section		.text
global		_start

_start:
	lea		rdi, [msg]
	call	printstr
	call	endl
	call	exit   

section		.data
msg:		db	'Hello, World!', 0	
            
