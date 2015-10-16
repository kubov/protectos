BITS 16
ORG 0x7c00
        jmp main
msg:    db "Hello world"
endmsg:

writestring:
        push bp
        mov bp,sp
        mov ax,0
        mov ds,ax
        cld
        mov cx,1
        mov si, msg             ;use stack
char:   mov ah,2
        int 0x10
        lodsb
        mov ah,9
        int 0x10
        add dl,1
skip:
        cmp si,endmsg
        jne char
        leave
        ret

clear:  push bp
        mov bp,sp
        mov bx, 0x00f
        mov cx,80
        xor dx,dx
        mov al,0x20

row:    mov ah,2
        int 0x10
        mov ah,9
        int 0x10
        add dh,1
        cmp dh,24
        jne row
        xor dx,dx
        mov ah,2
        int 0x10
        leave
        ret
main:
        call clear
        call writestring
hlt:   jmp hlt
