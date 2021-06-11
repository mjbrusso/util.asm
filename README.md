util.asm NASM Library
------

**util.asm** is a small set of x64 assembly routines for The Netwide Assembler ([NASM](https://www.nasm.us/)). It is under development and aims to be used as a tool to learn Assembly Programming, without need to link the *libc*. 

In the current version (1.2) the following functions are available:

 - [exit](#void-exitint64-code)
 - [exit0](#void-exit0)
 - [strlen](#int64-strlenchar-s)
 - [itoa](#void-itoaint64-value-char-s)
 - [atoi](#int64-atoichar-s)
 - [endl](#void-endl)
 - [printstr](#void-printstrchar-s)
 - [printint](#void-printintint64-n)
 - [readstr](#int64-readstrchar-s-int64-maxsize)
 - [readint](#int64-readint)


# Part I - NASM

## Using NASM

### Installing

- GNU/Linux Ubuntu, Debian, Mint:  `sudo apt install nasm`
- GNU/Linux Fedora, Red Hat, SUSE: `sudo dfn install nasm` or `sudo yum install nasm`
- Others (macOS, ...): Download and unzip the latest stable version from the [NASM web site](https://www.nasm.us/)

### Assembling, linking  and running a program

#### GNU/Linux
```
nasm -felf64 hello.asm
ld hello.o -o hello 
./hello
```

### macOS

```
nasm -fmacho64 hello.asm
gcc hello.o -o hello 
./hello
```

## x64 Assembly (Intel syntax)

### Comments
`; Line comment`


### Literals
```nasm
mov     rax, 200          ; decimal 
mov     rax, 0200d        ; decimal 
mov     rax, 0d200        ; decimal 
mov     rax, ffh          ; hex 
mov     rax, 0xc8         ; hex 
mov     rax, 0hc8         ; hex 
mov     rax, 310o         ; octal
mov     rax, 0o310        ; octal
mov     rax, 11001000b    ; binary 
mov     rax, 0b11001000   ; binary
```

### Program sections 
- `.text` :  Program code (instructions)
- `.data` :  Initialized data
- `.bss` 	:   Uninitialized data


### Initialized data examples
```nasm
section .data

b1:     db	100          ; 1 byte, value=100
b2:     db	10, 20       ; two sequential bytes
b3:     times 10 db 0        ; 10 bytes, value=0
c1:     db	'a','b'      ; two chars
c2:     db	'hello',0    ; zero terminated string 
i:      dw	1234         ; 16 bits integer
j:      dd	0x1234       ; 32 bits integer
k:      dq	50000000000  ; 64 bits integer
n:      equ	0xF0         ; constant 
```

### Uninitialized data examples 
```nasm
section .bss

str:    resb 100      ; reserve 100 uninitialized bytes 
vet:    resd 10       ; reserve 10 uninitialized dwords (10*32 bits)
```

# Part II - The Library

## Installing

Just clone this repository to use `util.asm`:

```bash
git clone https://github.com/mjbrusso/util.asm.git
cd util.asm
```

### Hello World 
```nasm
%include	'../util.asm'

section		.text
global		_start

_start:
    lea     rdi, [msg]      ; rdi = &msg[0]
    call    printstr        ; printstr(msg)
    call    endl            ; endl()
    xor     rdi, rdi        ; rdi = 0
    call    exit            ; exit(0)

section     .data
msg:        db	'Hello, World!', 0	
```

### Examples

We provide a few examples.

```bash
cd examples
make all
```

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

## Library functions

### `void exit(int64 code)`

**Description:** 
Quit program

**Arguments:** 

- `rdi: int64 code`: Exit code (0=Success, >0=Error) 

**Returns:**
  
- This function does not return

- - -
  
### `void exit0()`

**Description:** 
Quit program with status code = 0

**Arguments:** 

- None

**Returns:**
  
- This function does not return

- - -

### `int64 strlen(char *s)`

**Description:** 
Calculates the length of string ( excluding the terminating null)

**Arguments:** 

- `rdi: char *s`: address of a null-terminated string (array of chars terminated by 0)

**Returns:**
 
- `rax: int64`: string size
		
- - -

### `void itoa(int64 value, char *s)`

**Description:** 
Converts an integer to a null-terminated string.

**Arguments:** 
- `rdi: int64 value`: Integer value to convert.
- `rsi: char *s`: Memory address where to store the resulting string.

**Returns:**

- `rax: int64`: string size

- - - 

### `int64 atoi(char *s)`

**Description:** 
Convert string to integer.

**Arguments:** 
- `rdi: char *s`: Address of a null-terminated string (array of chars terminated by 0)

**Returns:**
- `rax: int64`: integer value

- - - 

  
### `void endl()`

**Description:** 
Prints a newline (line break)

**Arguments:** 
 
- None

**Returns:**
  
- Nothing

---

### `void printstr(char *s)`

**Description:** 
Print a string

**Arguments:** 

- `rdi: char *s`: address of a null-terminated string (array of chars terminated by 0)

**Returns:**
 
- Nothing

- - -

### `void printint(int64 n)`

**Description:** 
Print integer number (decimal)

**Arguments:** 

- `rdi: int64 n`: Value to print

**Returns:**
 
- Nothing

- - -

### `int64 readstr(char *s, int64 maxsize)`

**Description:** Read up to *maxsize* chars from standard input into a string.

**Arguments:** 

- `rdi: char *s`: address of a string (array of chars)
- `rsi: int64 maxsize`: input size limit

**Returns:**
 
- `rax: int64`: Number of characters read

- - -

### `int64 readint()`

**Description:** 
Read int64 from standard input

**Arguments:** 

- None

**Returns:**
 
- `rax: int64`: The value entered

- - -


## License

Licensed under the [MIT license](https://github.com/mjbrusso/util.asm/blob/master/license.txt).

## Thanks

[AlessandroFonseca](https://github.com/AlessandroFonseca) : macOS port
