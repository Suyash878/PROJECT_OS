
mov ah, 0x0e

mov al,[the_secret]
int 0x10

mov bx,0x7c0
mov ds,bx

; from this point onwards all the memory will be offset by 0x7c0 or ds.

mov al,[the_secret]
int 0x10

mov al,[es:the_secret]	;current value of es here is still 0x0000.
int 0x10

mov bx,0x7c0
mov es,bx
mov al,[es:the_secret]	;now the value of es has been offset by 0x7c0. This will correctly print X.
int 0x10


jmp $

the_secret:
	db "X"
	
;magic number
times 510-($-$$) db 0
dw 0xaa55
	

