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
		mov	eax, 1	        	; system call number (1=sys_exit)
		int	0x80	        	; system call    
;*********************************************************************

;*********************************************************************
; void endl()
; prints a newline character
; Arguments: none
;  
; Returns: nothing
;*********************************************************************
endl:
	mov ecx, util.endl
	call print_str
	ret
   
;*********************************************************************

;*********************************************************************
; int strlen(char *s)
; Calculate string length (zero terminated)
; Arguments:
; 	ECX: char *s
; Returns string size in EAX
;*********************************************************************
strlen:				
		xor eax, eax			; eax=0			// reset count
strlen.loop:					; do{
		mov dl, byte [ecx]		; 	dl = *s		// get the next char
		cmp dl, 0				;   if (dl==0)	// If zero, skip loop
		je strlen.end			;     break
		inc eax					;   eax++ 		// increment count
		inc ecx					; 	s++ 		// advance to the next char
		jmp strlen.loop			; }while(true)
strlen.end:
		ret						; return eax
;*********************************************************************


;*********************************************************************
; void print_str(char *s)
; Print zero terminated string pointed by s
; Arguments:
; 	ECX: char *s
; Returns: nothing
;*********************************************************************
print_str:
		push ecx			; ecx is 'caller saved'
		call strlen			; get string size in eax
		pop ecx				; ecx: pointer to string
		mov edx, eax		; edx: string size
		push ebx			; ebx is 'callee saved'
		mov ebx, 1			; ebx: file descriptor (1=stdout)
		mov eax, 4			; eax: system call number (4=sys_write)
		int 80h				; system call 
		pop ebx				; restore ebx
		ret
;*********************************************************************



;*********************************************************************
; void print_int(int n)
; Print integer (decimal)
; Arguments:
; 	ECX: int n
; Returns: nothing
;*********************************************************************
print_int:
		push ebx				; ebx is 'callee saved'
		push esi				; esi is 'callee saved'
		push edi				; edi is 'callee saved'
		mov eax, ecx			; eax = n
		xor ebx, ebx			; ebx = 0
		cmp eax, 0			
		je print_int.a1
		mov bh, 1				; if(n!=0) is_not_zero=1
		jg print_int.a1			; if(n<0)
		mov bl, 1				; 	 is_neg=1
		neg eax					;    n = -n
print_int.a1:	
		mov edi, 10				; ebx = 10
		mov esi, util.temps+10	; char *p = &s[10]
print_int.loop:	
		cmp eax, 0				; while (n>0)
		jle print_int.end		; {
		xor edx, edx			;		edx=0 
		div edi					; 		edx=edx:eax%10; eax=edx:eax/10
		add dl, '0'				;		decimal digit
		mov byte [esi], dl		;		*p = edx
		dec esi					; 		p--
		jmp print_int.loop		; }
print_int.end:
		test bl, bl				; if(is_neg)
		jz	print_int.notneg	;   // Prepend minus sign	
		mov byte [esi], '-'		; 	*p = '-'
		dec esi					;	p--
print_int.notneg:		
		movzx ecx, bh			; Move byte to word with zero-extension
		add ecx, esi			; print_str(p+is_not_zero);
		call print_str			; print number
		pop edi					; restore esi
		pop esi					; restore esi
		pop ebx					; restore ebx
		ret
;*********************************************************************


;*********************************************************************
; int read_str(char *s, int max_size)
; Read up to max_size chars from standard input into the string pointed by s.
; Arguments:
; 	ECX: char *s
; 	EDX: max_size
; Returns the number of bytes read in EAX, including the terminating zero 
;*********************************************************************
read_str:
		push ebx			; ebx is 'callee saved'
		mov ebx, 0			; ebx: file descriptor (0=stdin)
		mov eax, 3			; eax: system call number (3=sys_read)
		int 80h				; system call 
		pop ebx				; restore ebx
		ret
;*********************************************************************
		

;*********************************************************************
; int read_int()
; Read up to max_size chars from standard input into the string pointed by s.
; Arguments: none
; Returns The value entered in EAX
;*********************************************************************
read_int:
		mov ecx, util.temps	
		mov edx, 10
		call read_str
; TODO: convert str2int	
		ret
;*********************************************************************



section	.data
    util.temps	db'00000000000',0    	; char util.temps[]="00000000000"
    util.endl   db 10,0					; char util.endl[]="\n"
