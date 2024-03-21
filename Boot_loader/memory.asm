the_secret:
db "X"

mov ah, 0x0e

;attempt 1

mov al, "1"
int 0x10
mov al,the_secret
int 0x10

;attempt 2

mov al, "2"
int 0x10
mov al, [the_secret]
int 0x10

;attempt 3 correct method but need to add the offset

mov al,"3"
int 0x10
mov bx,the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

times 510-($-$$) db 0
dw 0xaa55
