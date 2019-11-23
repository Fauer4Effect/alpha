;
; Simple boot sector that uses segment offsetting
;

mov ah, 0x0e

mov bx, 0x7c0         ; 16bit real mode can't set ds directly
mov ds, bx
mov al, [the_secret]  ; cpu implicitly uses ds
int 0x10

; mov al, [es:the_secret] ; tell to use es not ds register

the_secret:
  db "X"

times 510-($-$$) db 0
dw 0xaa55