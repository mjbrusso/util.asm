# util.asm
A small set of x64 assembly routines

## Calling Convention

Register | Usage | Saved By
---------|-------|---------------
%rax | 1st return value | Caller
%rbx | Base pointer | Callee
%rcx | 4th argument | Caller
%rdx | 3rd argument; 2nd return register| Caller
%rsp | Stack pointer | Callee
%rbp | Frame pointer | Callee
%rsi | 2nd argument | Caller
%rdi | 1st argument | Caller
%r8 | 5th argument | Caller
%r9 | 6th argument | Caller
%r10-11 | Temporary | Caller
%r12-r15 | Temporary |  Callee
