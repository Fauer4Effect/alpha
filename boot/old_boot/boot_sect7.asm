;
; Boot sector that enters 32-bit protected mode
;

[org 0x7c00]

; set the stack
mov bp, 0x9000
mov sp, bp

mov bx, MSG_REAL_MODE
call print_string

call switch_to_pm         ; never return from here

jmp $

%include "print_string.asm"
%include "gdt.asm"
%include "print_string_protected.asm"
%include "switch_protected.asm"

[bits 32]
; this is were we arrive after switching to an init protected mode
BEGIN_PM:
  mov ebx, MSG_PROT_MODE
  call print_string_pm      ; 32 bit print routine
  ; message will print on the top left of the screen so it might
  ; look like it didn't work if you don't check the right place

  jmp $

MSG_REAL_MODE:
  db "Started in 16-bit Real Mode", 0
  
MSG_PROT_MODE:
  db "Successfully landed in 32-bit protected mode", 0

; bootsector padding
times 510-($-$$) db 0
dw 0xaa55