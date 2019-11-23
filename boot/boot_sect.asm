;
; Boot sector that boots a C kernel in 32-bit protected mode
;

[org 0x7c00]

; memory offset where we will load the kernel
KERNEL_OFFSET equ 0x1000

; BIOS store the boot drive in DL, store for later
mov [BOOT_DRIVE], dl

; setup stack
mov bp, 0x9000
mov sp, bp

mov bx, MSG_REAL_MODE
call print_string

; load the kernel
call load_kernel

; switch to protected mode, NO RETURN
call switch_to_pm

jmp $

%include "print/print_string.asm"
%include "disk/disk_load.asm"
%include "pm/gdt.asm"
%include "pm/print_string_protected.asm"
%include "pm/switch_protected.asm"

[bits 16]

; load kernel
load_kernel:
  mov bx, MSG_LOAD_KERNEL
  call print_string

  ; setup parameters for disk_load
  ; load first 15 sectors (excluding boot) from the boot disk
  ; to address KERNEL_OFFSET
  mov bx, KERNEL_OFFSET
  mov dh, 15
  mov dl, [BOOT_DRIVE]
  call disk_load

  ret

[bits 32]
; this is where we arrive after switching to protected mode
BEGIN_PM:
  mov ebx, MSG_PROT_MODE
  call print_string_pm

  ; jump to the address of the loaded kernel
  call KERNEL_OFFSET

  ; hang
  jmp $


; GLOBALS
BOOT_DRIVE:
  db 0
MSG_REAL_MODE:
  db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE:
  db "Sucessfully landed in 32-bit Protected Mode", 0
MSG_LOAD_KERNEL:
  db "Loading kernel into memory", 0

; padding
times 510-($-$$) db 0
dw 0xaa55