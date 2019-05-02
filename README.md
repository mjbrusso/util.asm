util.asm NASM Library
------

**util.asm** is a small set of x64 assembly routines for The Netwide Assembler (NASM). It's under development and aims to be used as a tool to learn Assembly Programming. 

## Functions

In the current version the following functions are available:

 - exit
 - endl
 - strlen
 - printstr
 - readstr
 - printint
 - readint

For full documentation, see the project's [Tutorial](https://github.com/mjbrusso/util.asm/blob/master/Tutorial.md).




Part I - NASM
---

### Installing NASM on Ubuntu/Debian Linux

`sudo apt-get install nasm `

### Assembling, linking  and running a program
```
nasm -felf64 hello.asm
ld hello.o -o hello 
./hello
```

### Comments
`; Line comment`

### Program sections 
- `.text` :  Program code (instructions)
- `.data` :  Initialized data
- `.bss` 	:   Uninitialized data

### Initialized data examples
```nasm
    section .data
b1: db	100          ; 1 byte, value=100
b2: db	10, 20       ; two sequential bytes
b3: db	0 times 10   ; 10 bytes, value=0
c1: db	'a','b'      ; two chars
c2: db	'hello',0    ; zero terminated string 
i:  dw	1234         ; 16 bits integer
j:  dd	0x1234       ; 32 bits integer
k:  dq	50000000000  ; 64 bits integer
n:  equ	12           ; constant 
```
### Uninitialized data examples 
```nasm
     section .bss
str: resb 100      ; reserve 100 uninitialized bytes 
vet: resd 10       ; reserve 10 uninitialized words (10*32 bits)
```
### Literals
```nasm
mov     ax,200          ; decimal 
mov     ax,0200d        ; decimal 
mov     ax,0d200        ; decimal 
mov     ax,ffh          ; hex 
mov     ax,0xc8         ; hex 
mov     ax,0hc8         ; hex 
mov     ax,310o         ; octal
mov     ax,0o310        ; octal
mov     ax,11001000b    ; binary 
mov     ax,0b11001000   ; binary
```

### Hello World 
```nasm
%include '../util.asm'		; Includes the library

section .text				; Program code
global  _start          	; Entry point
_start:
	lea	rdi, [msg]			; Load msg address in rdi (1st function argument)
	call	printstr		; Show the string
	call	endl			; Line break
	call	exit			; Quit program   

section .data				; Program initialized data
msg	db	'Hello, World!', 0	; String terminated by zero	
```
----------
Part II - The Library
---

### Calling Convention

Register | Usage | Preserved across function calls (Callee saved?)
---------|-------|---------------
rax | Return value | No
rbx | Free | Yes
rcx | 4th argument | No
rdx | 3rd argument | No
rsp | Stack pointer | Yes
rbp | Free (the frame pointer is omitted) | No
rsi | 2nd argument | No
rdi | 1st argument | No
r8 | 5th argument | No
r9 | 6th argument | No
r10-11 | Free | No
r12-r15 | Free |  Yes

For more information, see [System V Application Binary Interface](https://software.intel.com/sites/default/files/article/402129/mpx-linux64-abi.pdf).

Arguments are passed left to right:  

```C
fn(rdi, rsi, rdx, rcx, r8, r9)
```

### Library functions

### `exit`

Quit program

**Arguments:** 

- None

**Returns:**
  
- This function does not return

- - -

### `endl`

**Description:** 
Prints a newline (line break)

**Arguments:** 
 
- None

**Returns:**
  
- Nothing

---

### `printstr`

**Description:** 
Print a string

**Arguments:** 

- `rdi`: address of a null-terminated string (array of chars terminated by 0)

**Returns:**
 
- Nothing

- - -

### `printint`

**Description:** 
Print integer number (decimal)

**Arguments:** 

- `rdi`: number

**Returns:**
 
- Nothing

- - -

### `readstr`

**Description:** Read up to _max_size_ chars from standard input into a string.

**Arguments:** 

- `rdi`: address of a string (array of chars)
- `rsi`: input size limit (_max_size_)

**Returns:**
 
- `rax`: Number of characters read

- - -

### `readint`

**Description:** 
Read int64 from standard input

**Arguments:** 

- None

**Returns:**
 
- `rax`: The value entered

- - -

### `strlen`

**Description:** 
Calculates the length of string ( excluding the terminating null)

**Arguments:** 

- `rdi`: address of a null-terminated string (array of chars terminated by 0)

**Returns:**
 
- `rax`: string size
		
- - -



## License

Licensed under the [MIT license](https://github.com/mjbrusso/util.asm/blob/master/license.txt).
