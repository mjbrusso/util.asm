# util.asm
A small set of x64 assembly routines

## Calling Convention

Register | Usage | Saved By
---------|-------|---------------
%rax | 1st return value | No
%rbx | Base pointer | Yes
%rcx | 4th argument | No
%rdx | 3rd argument; 2nd return register| No
%rsp | Stack pointer | Yes
%rbp | Frame pointer | Yes
%rsi | 2nd argument | No
%rdi | 1st argument | No
%r8 | 5th argument | No
%r9 | 6th argument | No
%r10-11 | Temporary | No
%r12-r15 | Temporary |  Yes
