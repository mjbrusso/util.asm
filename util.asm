;*********************************************************************
; util.asm
; by Marcos José Brusso
;
;*********************************************************************

section .text

;*********************************************************************
; exit
;
; Quit program
; Arguments: 
;		None
; Returns: 
; 		This function does not return
;*********************************************************************
exit:
        mov		rax, 60                 ; rax: system call number (60=exit)
        xor     rdi, rdi                ; rdi: exit code (0)
        syscall    
;*********************************************************************

;*********************************************************************
; endl
;
; prints a newline character
; Arguments: 
;		None
; Returns: 
;		Nothing
;*********************************************************************
endl:
	mov		rdi, util.endl
	call	print_str
	ret
   
;*********************************************************************

;*********************************************************************
; strlen
;
; Calculates the length of string s
; Arguments:
; 		rdi: address of a null-terminated string (array of chars terminated by 0)
; Returns:
;		rax: string size
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
; print_str
;
; Print a string
; Arguments:
; 		rdi: address of a null-terminated string (array of chars terminated by 0)
; Returns: 
;		Nothing
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
; read_str
;
; Read up to max_size chars from standard input into a string.
; Arguments:
; 		rdi: address of a string (array of chars)
; 		rsi: max_size - limit input size
; Returns:
;		rax: the number of bytes read
;*********************************************************************
read_str:
		mov		r8, rdi				; copy of buffer address
		mov		rax, 0				; system call number (0=sys_read)
		mov 	rdx, rsi			; pointer to buffer
		mov 	rsi, rdi			; max size
		mov 	rdi, 0				; file descriptor (0=stdin)		
		syscall						; system call 
		dec 	rax					; removing trailing newline char
		mov		byte [r8+rax], 0	; replace with '\0'
		ret
;*********************************************************************
	


;*********************************************************************
; print_int
;
; Print a integer number (decimal)
; Arguments:
; 	rdi: 	number
; Returns: 
;			Nothing
;*********************************************************************
print_int:
		mov		rax, rdi			; rax = n	
		xor 	rcx, rcx			; is_neg = false
		cmp 	rax, 0				;
		jge		print_int.nn  		; if(n<0)	  
		not 	rcx					; 		is_neg = true
		neg 	rax					;     	n = -n
print_int.nn:	
		mov 	r10, 10				; r10 = 10
		mov 	rdi, util.temps+20	; char *p = &s[10]
print_int.loop:						; do{
		xor 	rdx, rdx			;		rdx=0 
		div 	r10					; 		rdx=rdx:rax%10; rax=rdx:rax/10
		add 	dl, '0'				;		decimal digit
		mov 	byte [rdi], dl		;		*p = digit in dl
		dec 	rdi					; 		p--
		cmp 	rax, 0				; 
		jg 		print_int.loop		; }while (n>0)

		test 	rcx, rcx			; if(is_neg)
		jz		print_int.notneg	;   	// Prepend minus sign	
		mov 	byte [rdi], '-'		; 		*p = '-'
		dec 	rdi					;		p--
print_int.notneg:		
		inc 	rdi					; p++
		call 	print_str			; print number
		ret
;*********************************************************************	
	 
	

;*********************************************************************
; read_int
;
; Read a int64 from standard input
; Arguments: 
;		None
; Returns:
;		rax: The value entered
;*********************************************************************
read_int:
		mov 	rdi, util.temps				; temp string address	
		mov 	rsi, 20						; max input size
		call 	read_str					; read number as string
		lea 	rdi, [rax+util.temps-1]		; char *p = &s[strlen(string)];  //scans string backward
		xor 	rax, rax					; result value
		mov 	rdx, 1						; multiplier
read_int.beginloop:		
		cmp		rdi, util.temps				; while(p>=s){
		jl		read_int.end				;
		xor		rcx, rcx					;	
		mov 	cl, byte [rdi] 				; 	 cl = current char
		cmp 	cl, '-'						;	 if(cl=='-')
		jne		read_int.notneg				;
		neg		rax							;		rax=-rax
		jmp		read_int.end				;
read_int.notneg:					
		cmp		cl, '9'						;	 if(!isdigit(cl)) continue
		jg		read_int.endloop			;
		sub		cl, '0'						;
		jl		read_int.endloop			;
		imul	rcx, rdx					;	 digit_value = current_char * multiplier
		add		rax, rcx					;	 result += digit_value
		imul	rdx, 10						;	 multiplier *= 10
read_int.endloop:
		dec		rdi							;	 previous char //scans string backward
		jmp		read_int.beginloop			; }
read_int.end:		
		ret

section	.data
    util.temps	db	'000000000000000000000',0    	; char util.temps[]="00000000000"
    util.endl   db 	10,0							; char util.endl[]="\n"
