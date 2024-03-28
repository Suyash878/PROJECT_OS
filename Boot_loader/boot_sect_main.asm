
[org 0x7c00]		;offset

mov bp,0x8000		;moving the stack pointer away so that it doesn't lead to overflow.
mov sp,bp		;moving the bp to the sp location.

mov bx,0x9000		
mov dh,2 		;read 2 sectors.

call disk_load

mov dx,[0x9000]		;retrieve the first loaded word since the dereference operator '[]' is used here 
			;that means we will access the word and not the address.
call print_hex

			;call print_nl

mov dx,[0x9000+512]		;to the second loaded sector.
call print_hex			;print the address in hexadecimal format.
jmp $				;jumps to the current address.		


%include "boot_sect_disk.asm"
%include "print_function.asm"
%include "print_hex.asm"

;magic number
times 510 - ($-$$) db 0
dw 0xaa55

times 256 dw 0xdada	
times 256 dw 0xface 

























