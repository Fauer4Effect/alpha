;
; A simple boot sector program that loops forever
;

loop:
  jmp loop

times 510 - ($-$$) db 0   ; When compiled our program must fit into 512 bytes
                          ; with the last two bytes being the magic number,
                          ; so we tell the assembler to pad the program with
                          ; enough 0 bytes (db 0) to bring us to 510th byte

dw 0xaa55                 ; Last two bytes (one word) form the magic num
                          ; so BIOS know we are a boot sector