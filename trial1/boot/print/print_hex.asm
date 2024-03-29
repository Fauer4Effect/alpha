;
; prints the value of DX as hex
;

print_hex:
  mov ax, dx
  xor cx, cx

; manipulate the chars at HEX_OUT to reflect dx
get_chars:
  ; this chunk of code will get the last 4 bits
  ; and get the ascii code for that
  mov dx, ax
  and dx, 0xf
  cmp dx, 0x0a
  jge char
  
  add dx, 0x30

move:
  ; put bx at the end of hex_out
  mov bx, HEX_OUT
  add bx, 5
  ; move back however far we need to
  sub bx, cx
  ; put ascii value of the number into that location
  mov [bx], dl
  
  ; get the next 4 bits
  shr ax, 4
  add cx, 1
  cmp cx, 4
  jl get_chars

  mov bx, HEX_OUT
  call print_string
  ret

char:
  add dx, 0x57
  jmp move

; global variables
HEX_OUT:
  db "0x0000", 0