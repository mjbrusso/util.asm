# util.asm NASM Library
A small set of x64 assembly routines.

## Calling Convention

Register | Usage | Saved By
---------|-------|---------------
%rax | 1st return value | Caller
%rbx | Free | Callee
%rcx | 4th argument | Caller
%rdx | 3rd argument | Caller
%rsp | Stack pointer | Callee
%rbp | Frame pointer | Callee
%rsi | 2nd argument | Caller
%rdi | 1st argument | Caller
%r8 | 5th argument | Caller
%r9 | 6th argument | Caller
%r10-11 | Free | Caller
%r12-r15 | Free |  Callee

Arguments are passed left to right:  

```
fn(%rdi, %rsi, %rdx, %rcx, %r8, %r9)
```

## Library functions

### exit
Quit program

Arguments: 

	None
	
Returns:

	This function does not return


### print_str
Print a string
Arguments:
	rdi: address of a null-terminated string (array of chars terminated by 0)
 Returns: 
	Nothing

### print_int
Print a integer number (decimal)
Arguments:
 	rdi: 	number
Returns: 
			Nothing

### read_str
Read up to max_size chars from standard input into a string.
Arguments:
 		rdi: address of a string (array of chars)
 		rsi: max_size (input size limit)
Returns:
		rax: the number of bytes read

### read_int
Read a int64 from standard input
Arguments: 
		None
 Returns:
		rax: The value entered

### endl
Prints a newline character
Arguments: 
		None
Returns: 
		Nothing

### strlen
Calculates the length of string s
Arguments:
 		rdi: address of a null-terminated string (array of chars terminated by 0)
Returns:
		rax: string size
		
