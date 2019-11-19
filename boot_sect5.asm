;
; A boot sector that prints a string using print function
; nasm boot_sect.asm -f bin -o boot_sect.bin
;

[org 0x7c00]

mov bx, HELLO_MSG
call print_string

mov bx, GOODBYE_MSG
call print_string

jmp $

; if we wanted to include the print function in a different file
%include "print_string.asm"

; Data
HELLO_MSG:
  db "Hello, World!", 0

GOODBYE_MSG:
  db "Goodbye!", 0

times 510-($-$$) db 0
dw 0xaa55