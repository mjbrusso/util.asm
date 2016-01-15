# util.asm
A small set of x64 assembly routines

## Calling Convention

Register | Usage | Saved By
---------|-------|---------------
%rax | 1st return register |No
%rbx | Base pointer | callee-saved
%rcx | 4th argument | No
%rdx | 3rd argument; 2nd return register| No
%rsp | stack pointer | Yes
%rbp | Frame pointer | callee-saved
%rsi | 2nd argumentNo
%rdi | 1st argument | No
%r8 | 5th argument | No
%r9 | 6th argument | No
%r10-11 | Temporary register | No
%r12-r15 | |  callee-saved
