
; Define the hexadecimal string template
HEX_OUT: db '0x0000', 0  ; Template string for representing hexadecimal values

section .text
    ; Entry point of the program
    global _start

    ; Start of the code segment
_start:
    ; Store the value to print in DX
    mov dx, 0x1fb6

    ; Call the print_hex function
    call print_hex

    ; Exit the program
    mov eax, 1      ; SYS_EXIT system call number
    xor ebx, ebx    ; Exit code 0
    int 0x80        ; Invoke system call

; Function to print a hexadecimal value stored in DX
print_hex:
    ; Load the address of HEX_OUT into BX
    mov bx, HEX_OUT

    ; Extract each hexadecimal digit from DX and convert it to ASCII
    mov cx, 4       ; We have 4 hexadecimal digits to process
    mov si, 12      ; Index of the first hexadecimal digit in HEX_OUT (excluding the '0x' prefix)
extract_digit:
    ; Extract the least significant nibble (4 bits) from DX
    mov ax, dx      ; Move the value of DX into AX for manipulation
    and ax, 0x000F  ; Mask out all bits except the least significant nibble
    add al, '0'     ; Convert the nibble to ASCII
    cmp al, '9'     ; Check if the result is greater than '9' (i.e., if it's a letter)
    jbe store_digit ; Jump if below or equal (i.e., if it's a digit)
    add al, 7       ; Adjust the ASCII code for letters (A-F)
store_digit:
    ; Store the ASCII digit in HEX_OUT
    mov [bx + si], al  ; Store the ASCII character at the appropriate position in HEX_OUT

    ; Move to the next hexadecimal digit in HEX_OUT
    sub si, 2       ; Move two positions to the left (each digit takes up two characters)
    ; Shift right to process the next nibble
    shr dx, 4       ; Shift right by 4 bits to process the next nibble
    loop extract_digit  ; Repeat until all digits are processed

    ; Print the modified HEX_OUT string
    call print_string

    ; Return from the function
    ret

; Function to print a null-terminated string pointed to by BX
print_string:
    ; Print each character until the null terminator is reached
Print_loop:
    mov al, [bx]    ; Load the byte at the address pointed to by BX into AL
    test al, al     ; Check if AL is zero (null terminator)
    jz done         ; If it is, exit the loop
    mov ah, 0x0E    ; Set the AH register for BIOS teletype output
    int 0x10        ; Invoke BIOS interrupt to print character in AL
    inc bx          ; Move to the next character in the string
    jmp Print_loop  ; Repeat the loop
done:
    ret             ; Return from the function

