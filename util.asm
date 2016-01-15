;*********************************************************************
; util.asm
; by Marcos José Brusso
;
;*********************************************************************

section .text

;*********************************************************************
; void exit()
; Quit program
;  
; This function does not return
;*********************************************************************
exit:
        mov		rax, 60                 ; rax: system call number (60=exit)
        xor     rdi, rdi                ; rdi: exit code
        syscall    
;*********************************************************************

;*********************************************************************
; void endl()
; prints a newline character
; Arguments: none
;  
; Returns: nothing
;*********************************************************************
endl:
	mov		rdi, util.endl
	call	print_str
	ret
   
;*********************************************************************

;*********************************************************************
; int strlen(char *s)
; Calculate string length (zero terminated)
; Arguments:
; 	rdi: char *s
; Returns string size in rax
;*********************************************************************
strlen:				
		xor		rax, rax			; rax=0			// reset count
strlen.loop:						; do{
		cmp		byte [rdi], 0		;   if (*s==0)	// If zero, skip loop
		je		strlen.end			;     break
		inc		rax					;   rax++ 		// increment count
		inc		rdi					; 	s++ 		// advance to the next char
		jmp		strlen.loop			; }while(true)
strlen.end:
		ret							; return rax
;*********************************************************************


;*********************************************************************
; void print_str(char *s)
; Print zero terminated string pointed by s
; Arguments:
; 	rdi: char *s
; Returns: nothing
;*********************************************************************
print_str:
		mov 	rcx, rdi
		call 	strlen
		mov     rdx, rax	; string size
		mov     rsi, rcx    ; string
        mov		rax, 1		; system call number (1=sys_write)
        mov     rdi, 1      ; file descriptor (1=stdout)       
        syscall				; system call    
		ret
;*********************************************************************


;*********************************************************************
; int read_str(char *s, int max_size)
; Read up to max_size chars from standard input into the string pointed by s.
; Arguments:
; 	rdi: char *s
; 	rsi: max_size
; Returns the number of bytes read in rax, including the terminating zero 
;*********************************************************************
read_str:
		mov r8, rdi				; copy of buffer address
		mov rax, 0				; system call number (0=sys_read)
		mov rdx, rsi			; pointer to buffer
		mov rsi, rdi			; max size
		mov rdi, 0				; file descriptor (0=stdin)		
		syscall					; system call 
		dec rax					; removing trailing newline char
		mov byte [r8+rax], 0	; replace with '\0'
		ret
;*********************************************************************
	

%if 0

;*********************************************************************
; void print_int(int n)
; Print integer (decimal)
; Arguments:
; 	rdi: int n
; Returns: nothing
;*********************************************************************
print_int:
		push rbx				; rbx is 'callee saved'
		push esi				; esi is 'callee saved'
		push edi				; edi is 'callee saved'
		mov rax, rcx			; rax = n
		xor rbx, rbx			; rbx = 0
		cmp rax, 0			
		je print_int.a1
		mov bh, 1				; if(n!=0) is_not_zero=1
		jg print_int.a1			; if(n<0)
		mov bl, 1				; 	 is_neg=1
		neg rax					;    n = -n
print_int.a1:	
		mov edi, 10				; rbx = 10
		mov esi, util.temps+10	; char *p = &s[10]
print_int.loop:	
		cmp rax, 0				; while (n>0)
		jle print_int.end		; {
		xor rdx, rdx			;		rdx=0 
		div edi					; 		rdx=rdx:rax%10; rax=rdx:rax/10
		add dl, '0'				;		decimal digit
		mov byte [esi], dl		;		*p = rdx
		dec esi					; 		p--
		jmp print_int.loop		; }
print_int.end:
		test bl, bl				; if(is_neg)
		jz	print_int.notneg	;   // Prepend minus sign	
		mov byte [esi], '-'		; 	*p = '-'
		dec esi					;	p--
print_int.notneg:		
		movzx rcx, bh			; Move byte to word with zero-extension
		add rcx, esi			; print_str(p+is_not_zero);
		call print_str			; print number
		pop edi					; restore esi
		pop esi					; restore esi
		pop rbx					; restore rbx
		ret
;*********************************************************************
	

;*********************************************************************
; int read_int()
; Read up to max_size chars from standard input into the string pointed by s.
; Arguments: none
; Returns The value entered in rax
;*********************************************************************
read_int:
		mov rcx, util.temps	
		mov rdx, 10
		call read_str
; TODO: convert str2int	
		ret
;*********************************************************************

%endif

section	.data
    util.temps	db'00000000000',0    	; char util.temps[]="00000000000"
    util.endl   db 10,0					; char util.endl[]="\n"
