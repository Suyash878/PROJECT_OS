
disk_load:
	pusha
	;this saves the data for all the general purpose registers.
	
	
	push dx
	;this pushes the data for the dx register onto the stack for later use.
	
	mov ah,0x02 	;used to read sectors from the disk.
	mov al,dh	;for the number of sectors to read.
	mov cl,0x02	;
	mov ch,0x00	;cylinder numbers.
	mov dh,0x00	;disk head (0x0........0xF)
	
	int 0x13	;BIOS Interrupt
	jc disk_error	;jump in case of carry bit is set.
	
	pop dx
	cmp al, dh	;BIOS checks whether the number of sectors read is equal or not.
	jne sectors_error 	;jump if not equal.
	popa 
	ret
	
	
	disk_error:
	mov bx,DISK_ERROR 
	call print_function	
					;call print_function_nl	
	mov dh,ah	;this stores the error code stored in ah in dh.
	call print_hex
	jmp disk_loop	
	
	sectors_error:
	mov bx,SECTORS_ERROR
	call print_function
	
	disk_loop:
		jmp $
	
	DISK_ERROR: db "Disk read error!" , 0
	SECTORS_ERROR db "Incorrect number of sectors read" , 0
	
	
	















