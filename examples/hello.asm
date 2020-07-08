%include	'../util.asm'

section		.text
global		_start

_start:
	lea		rdi, [msg]      ; rdi = &msg[0]
	call	printstr        ; printstr(msg)
	call	endl            ; endl()
    xor     rdi, rdi        ; rdi = 0
	call	exit            ; exit(0)

section		.data
msg:		db	'Hello, World!', 0	
            
