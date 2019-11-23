;
; Simple flat model GDT
;

gdt_start:

; manadatory null descriptor
gdt_null:
  dd 0x0
  dd 0x0

; code segment descriptor
gdt_code:
  ; base=0x0, limit=0xfffff
  ; 1st flags: (present)1 (privilege)00  (descriptor type)1 -> 1001b
  ; type flags: (code)1 (conforming)0 (readable)1 (accessed)0 -> 1010b
  ; 2nd flags: (granularity)1 (32-bit default) 1 (64-bit seg)0 (AVL)0 -> 1100b
  dw 0xffff           ; limit (bits 0-15)
  dw 0x0              ; base (bits 0-15)
  db 0x0              ; base (bits 16-23)
  db 10011010b        ; 1st flags, type flags
  db 11001111b        ; 2nd flags, limit (bits 16-19)
  db 0x0              ; base (bits 24-31)

; data segment descriptor
gdt_data:
  ; same as code segment except for type flags
  ; type flags: (code)0 (expand down)0 (writeable)1 (accessed)0 -> 0010b
  dw 0xffff           ; limit (bits 0-15)
  dw 0x0              ; base (bits 0-15)
  db 0x0              ; base (bits 16-23)
  db 10010010b        ; 1st flags, type flags
  db 11001111b        ; 2nd flags, limit (bits 16-19)
  db 0x0              ; base (bits 24-31)

; put a label at the end of GDT to have the assembler
; calculate the size of the GDT for the GDT descriptor
gdt_end:

; GDT descriptor
gdt_descriptor:
  ; size of the GDT, always less one of the true size
  dw gdt_end - gdt_start - 1
  ; start address of the GDT
  dd gdt_start

; helpful constants for GDT segment descriptor offsets
; what segment registers must contain when in protected mode
; ie set DS=0x10 in PM, cpu knows that you mean to use segment
; described at offset 0x10 in the GDT (DATA segment in thie example)
; 0x0 -> NULL 0x08 -> CODE 0x10 -> DATA
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start