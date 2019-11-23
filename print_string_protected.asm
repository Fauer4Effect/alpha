;
; Print string to VGA without using BIOS.
; Downside is that it will just print to the top left
; and overwrite everything that came previously
;

[bits 32]
; Define some constants
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

; prints a null-terminated string pointed to by EBX
print_string_pm:
  pusha
  mov edx, VIDEO_MEMORY

print_string_pm_loop:
  mov al, [ebx]             ; store the char at EBX in AL
  mov ah, WHITE_ON_BLACK    ; store the attributes in AH

  cmp al, 0                 ; if (al == 0) end of string
  je print_string_pm_done

  mov [edx], ax             ; store char and attributes at current char cell

  add ebx, 1                ; increment ebx to next char in string
  add edx, 2                ; move to next char cell in vid mem

  jmp print_string_pm_loop

print_string_pm_done:
  popa
  ret