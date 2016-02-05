# util.asm NASM Library
A small set of x64 assembly routines for The Netwide Assembler (NASM).

## Calling Convention

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

For more information see [System V Application Binary Interface](http://www.x86-64.org/documentation/abi.pdf).

Arguments are passed left to right:  

```
fn(rdi, rsi, rdx, rcx, r8, r9)
```

## Library functions

### exit
Quit program

#####Arguments: 
*   None

#####Returns: 
*   This function does not return

- - -

### printstr
Print a string
#####Arguments: 
*   `rdi`: address of a null-terminated string (array of chars terminated by 0)
   
#####Returns: 
*   Nothing

- - -

### printint
Print a integer number (decimal)

#####Arguments: 
*   `rdi`: number
Returns: 
*   Nothing

- - -

### readstr
Read up to max_size chars from standard input into a string.

#####Arguments: 
*   `rdi`: address of a string (array of chars)
*   `rsi`: max_size (input size limit)

#####Returns: 
*   `rax`: the number of read chars

- - -

### readint
Read a int64 from standard input

#####Arguments: 
*   None

#####Returns: 
*   `rax`: The value entered

- - -

### endl
Prints a newline character

#####Arguments: 
*   None

#####Returns:
*   Nothing

- - -

### strlen
Calculates the length of string s

#####Arguments: 
*   `rdi`: address of a null-terminated string (array of chars terminated by 0)
  
#####Returns: 
*   `rax`: string size
		
- - -

