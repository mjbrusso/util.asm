%include '../util.asm'

section    .text
global _start         ;must be declared for using gcc

_start:
	lea rdi, [msg]
	call print_str
	call endl
	call exit   
section	.data
    msg	db	'Hello, World!', 0	
            
