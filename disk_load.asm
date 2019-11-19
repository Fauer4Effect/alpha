;
; Read the first n sectors following the boot sector from specified disk
;

; load dh sectors to es:bx from drive dl
disk_load:
  push dx         ; store dx so we can recall how many sector to read

  mov ah, 0x02    ; BIOS read sector function
  mov al, dh      ; read dh sectors
  mov ch, 0x00    ; select cylinder 0
  mov dh, 0x00    ; select head 0
  mov cl, 0x02    ; start reading from 2nd sector (after boot sector)

  int 0x13        ; BIOS interrupt

  jc disk_error   ; jump if error (carry flag set)

  pop dx          ; restor dx from stack
  cmp dh, al      ; if al (sectors read) != dh (sectors expected)
  jne disk_error
  ret

disk_error:
  mov bx, DISK_ERROR_MSG  
  call print_string
  jmp $

; Variables
DISK_ERROR_MSG db "Disk read error!", 0
