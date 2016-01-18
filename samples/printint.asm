%include '../util.asm'

section    .text
global _start         

_start:
	mov rdi, 1234567890
	call print_int
	call endl

	mov rdi, 123456789
	call print_int
	call endl
	
	mov rdi, 12345678
	call print_int
	call endl
	
	mov rdi, 1234567
	call print_int
	call endl
	
	mov rdi, 123456
	call print_int
	call endl
	
	mov rdi, 23456
	call print_int
	call endl
	
	mov rdi, 3456
	call print_int
	call endl
	
	mov rdi, 99
	call print_int
	call endl
	
	mov rdi, 0
	call print_int
	call endl

	mov rdi, -9988776655
	call print_int
	call endl

	mov rdi, -443322
	call print_int
	call endl

	mov rdi, -9
	call print_int
	call endl
	
	mov rdi, -9223372036854775808 ;; _I64_MIN
	call print_int
	call endl

	mov rdi, 9223372036854775807 ;; _I64_MAX
	call print_int
	call endl
	
	mov rbx, 100
ini: mov rdi, rbx
	call print_int
	mov rdi, tab	
	call print_str
	dec rbx
	cmp rbx, -100
	jge ini
	
	call endl
	call exit   

section	.data
    tab	db	',', 0	
            
