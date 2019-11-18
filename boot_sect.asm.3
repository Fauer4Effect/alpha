;
; Simple boot sector that prints a string
;

[org 0x7c00]

mov ah, 0x0e
xor cx, cx

loop:
  mov bx, my_string
  add bx, cx
  mov al, [bx]

  cmp al, 0
  je done
  
  int 0x10
  add cx, 1
  jmp loop
  
done:
  jmp $

my_string:
  db "Booting OS", 0

times 510-($-$$) db 0
dw 0xaa55