;
; A simple boot sector program that demonstrates addressing.
;

; If we included this line we wouldn't have to do the addition in the
; 3rd attempt because the assembler would know where we expect it to be
; loaded
; [org 0x7c00]

mov ah, 0x0e      ; scrolling teletype BIOS routine

; First attempt
; Won't work because it tries to load the immediate offset
; into al as the character to print, but you want to print the character
; at the offset instead of the offset itself
mov al, the_secret
int 0x10

; Second attempt
; Fails because the offset gets compiled directly, maybe would work in real
; assembly but not when writing a boot sector
mov al, [the_secret]
int 0x10

; Third attempt
mov bx, the_secret
add bx, 0x7c00        ; Address where BIOS always loads the boot sector
mov al, [bx]
int 0x10

; Fourth attempt
mov al, [0x7c1e]      ; Same as 3rd but manually made the offset
int 0x10

jmp $

the_secret:
  db "X"

times 510-($-$$) db 0
dw 0xaa55