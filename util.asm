;*********************************************************************
; util.asm 
; Author: Marcos José Brusso
; Version: 1.1
; Licensed under the MIT license (see "license.txt"). 
;*********************************************************************

section .text
global	exit, exit0, strlen, itoa, atoi, endl, printstr, printint, readstr, readint	; public symbols

;*********************************************************************
; void exit(int64 code)
; 
; Description:
;   Quit program
; 
; Arguments:
;   rdi: int64 code: Exit code (0=Success, >0=Error) 
; 
; Returns:
;   This function does not return
;
;*********************************************************************
exit:
    mov		rax, 60                 ; rax: system call number (60=exit)
    syscall    
;*********************************************************************

;*********************************************************************
; void exit0()
; 
; Description:
;   Quit program with status code = 0
; 
; Arguments:
;   None
; 
; Returns:
;   This function does not return
;
;*********************************************************************
exit0:
    xor     rdi, rdi    ;   rdi = 0
    jmp     exit        ;   TCO: tail call optimization
;*********************************************************************


;*********************************************************************
; int64 strlen(char *s)
; 
; Description:
;   Calculates the length of string ( excluding the terminating null)
; 
; Arguments:
;   rdi: char *s: address of a null-terminated string (array of chars terminated by 0)
; 
; Returns:
;   rax: int64: string size
; 		
;*********************************************************************
strlen:				
	xor		rax, rax			; rax=0;		 // reset counter
.loop:								; do{
    cmp		byte [rdi], 0		;   if (*s==0);	 // If zero, skip loop
    je		strlen.end			;     break;
    inc		rax					;   rax++; 		 // increment counter
    inc		rdi					; 	s++; 		 // advance to the next char
    jmp		strlen.loop			; }while(true);
.end:
    ret							; return rax;
;*********************************************************************


;*********************************************************************
; void itoa(int64 value, char *s)
; 
; Description:
;   Converts an integer to a null-terminated string.
;
; Arguments:
;   rdi: int64 value: Integer value to convert.
;   rsi: char *s: Memory address where to store the resulting string.
; 
; Returns:
;   rax: int64: string size
; 
;*********************************************************************
itoa:		
        test    rdi, rdi                        ; value = rdi
        jz      itoa.iszero                     ; value==0 has a direct solution
        jns     itoa.notneg                     ; if(value <0 )
        mov     byte [rsi], '-'                 ;       *s = '-'
        neg     rdi                             ;       value = -value
        inc     rsi                             ;       s++
.notneg:
        mov     r9b, 1                          ; bool leftzero=true
        mov     r10, 10                         ; base = 10
        mov     rcx, 1000000000000000000        ; divisor = 1000000000000000000
        mov     r8, 19                          ; cont = 19 // Will repeat 19 times
.loop:                                          ; do{
        mov     rax, rdi                        ;   dividend[0..31] = value
        xor 	rdx, rdx                        ;   dividend[32..63] = 0
        idiv    rcx                             ;   rax=(rdx:rax)/rcx ; rdx=(rdx:rax)%rcx
        test    al, al                          ;   digit = rax[0..7]
        jnz     itoa.notdigit0                    ;   if(digit!=0)
        test    r9b, r9b                        ;        if(leftzero)                       
        jnz     itoa.nextdigit                   ;            continue
        jmp     itoa.digit0
.notdigit0:
        xor     r9b, r9b                        ;   leftzero = false
.digit0:        
        add     eax, 48                         ;   digit = '0' + digit
        mov     rdi, rdx                        ;   value %= divisor
        mov     byte [rsi], al                  ;   *p = digit
        inc     rsi                             ;   p++        
.nextdigit:
        mov     rax, rcx                        ;   dividend[0..31] = value
        xor 	rdx, rdx                        ;   dividend[32..63] = 0
        idiv    r10                             ;   rax=(rdx:rax)/10 ; rdx=(rdx:rax)%10
        mov     rcx, rax                        ;   divisor /= 10
        dec     r8                              ;   cont--
        jne     itoa.loop                       ; }while(cont!=0)
.end:             
        mov     byte [rsi], 0                   ; *p = '\0'
        ret
.iszero:
        mov     word [rsi], 0x0030              ; *p = "0" (x86 is little endian)
        ret
;*********************************************************************


;*********************************************************************
; int64 atoi(char *s)
; 
; Description:
;   Convert string to integer.
;
; Arguments:
;   rdi: char *s: Address of a null-terminated string (array of chars terminated by 0)
; 
; Returns:
;   rax: int64: integer value
;*********************************************************************
atoi:		
    mov     r12, rdi                    ; rdi is caller saved    
    call    strlen
    lea 	rdi, [r12+rax-1]		    ; char *p = &s[strlen(string)];  //scans string backward
    xor 	rax, rax					; result value
    mov 	rdx, 1						; multiplier
.beginloop:		
    cmp		rdi, rsp				    ; while(p>=s){
    jl		atoi.end					;
    xor		rcx, rcx					;	
    mov 	cl, byte [rdi] 				; 	 cl = current char
    cmp 	cl, '-'						;	 if(cl=='-')
    jne		atoi.notneg				    ;
    neg		rax							;		rax=-rax
    jmp		atoi.end					;
.notneg:					
    cmp		cl, '9'						;	 if(!isdigit(cl)) nextdigit
    jg		atoi.endloop				;
    sub		cl, '0'						;
    jl		atoi.endloop				;
    imul	rcx, rdx					;	 digit_value = current_char * multiplier
    add		rax, rcx					;	 result += digit_value
    imul	rdx, 10						;	 multiplier *= 10
.endloop:
    dec		rdi							;	 previous char //scans string backward
    jmp		atoi.beginloop			    ; }
.end:		
    ret   
;*********************************************************************


;*********************************************************************
; void endl()
; 
; Description:
;   Prints a newline (line break)
; 
; Arguments:
;   None
; 
; Returns:
;   Nothing
; 
;*********************************************************************
endl:
    push    word 0x000A     ; push {'\n', '\0'} on stack (x86 is little endian)
	mov		rdi, rsp        ; print the string
	call	printstr
    add     rsp, 2          ; deallocate the string
	ret
   
;*********************************************************************


;*********************************************************************
; void printstr(char *s)
; 
; Description:
;   Print a string
; 
; Arguments:
;   rdi: char *s: address of a null-terminated string (array of chars terminated by 0)
; 
; Returns:
;   Nothing
; 
;*********************************************************************
printstr:
    push 	rdi			; save copy (rdi should be caller saved)
    call 	strlen
    mov     rdx, rax	; string size
    pop     rsi		    ; string
    mov		rax, 1		; system call number (1=sys_write)
    mov     rdi, 1      ; file descriptor (1=stdout)       
    syscall				; system call            
    ret
;*********************************************************************


;*********************************************************************
; void printint(int64 n)
; 
; Description:
;   Print integer number (decimal)
;
; Arguments:
;   rdi: int64 n: Value to print
;
; Returns:
;   Nothing
;
;*********************************************************************
printint:
    sub     rsp, 40             ; stack allocate a temp string
    mov     rsi, rsp            ; rdi=value, rsi=&str[0]
    call    itoa
    mov     rdi, rsp            ; rdi=&str[0]
    call 	printstr			; print number
    add     rsp, 40             ; deallocate the string
    ret
;*********************************************************************	
	 

;*********************************************************************
; int64 readstr(char *s, int64 maxsize)
; 
; Description:
;   Read up to *maxsize* chars from standard input into a string.
; 
; Arguments:
;   rdi: char *s: address of a string (array of chars)
;   rsi: int64 maxsize: input size limit
; 
; Returns:
;   rax: int64: Number of characters read
; 
;*********************************************************************
readstr:
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
; int64 readint()
; 
; Description:
;   Read int64 from standard input
;
; Arguments:
;   None
;
; Returns:
;   rax: int64: The value entered
;
;*********************************************************************
readint:
    sub     rsp, 40                     ; char s[40]
    mov 	rdi, rsp				    ; rdi = &s[0]
    mov 	rsi, 21						; max input size
    call 	readstr						; read number as string
    mov 	rdi, rsp				    ; 
    call    atoi                        ; rax = atoi(s)
    add     rsp, 40                     ; deallocate s from stack
    ret
;*********************************************************************	

