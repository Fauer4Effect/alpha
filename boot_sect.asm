;
; Simple boot sector to read other sections from disk
;

[org 0x7c00]

mov [BOOT_DRIVE], dl    ; BIOS stores the boot drive in DL

mov bp, 0x8000          ; set the stack up
mov sp, bp

mov bx, 0x9000          ; load 5 sectors to 0x0000(ES):0x9000(BX)
mov dh, 5               ; from boot disk
mov dl, [BOOT_DRIVE]
call disk_load

mov dx, [0x9000]        ; print out 1st loaded word
call print_hex          ; expected 0xdead

mov dx, [0x9000 + 512]  ; also print 1st word from 2nd sector
call print_hex          ; expected 0xbeef

jmp $

; %include "../print/print_string.asm"
; %include "../hex/print_hex.asm"
%include "print_string.asm"
%include "print_hex.asm"
%include "disk_load.asm"

BOOT_DRIVE: 
  db 0

times 510-($-$$) db 0
dw 0xaa55

times 256 dw 0xdead
times 256 dw 0xbeef