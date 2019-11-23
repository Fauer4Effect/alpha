;
; Switch from 16 bit real to 32 bit protected mode
;

[bits 16]
switch_to_pm:
  ; switch off interrupts until you have set up the 
  ; protected mode interrupt vector
  cli

  ; load the global descriptor table which defines the
  ; protected mode segments
  lgdt [gdt_descriptor]

  ; to switch to protected mode, set first bit of cr0
  mov eax, cr0
  or eax, 0x1
  mov cr0, eax

  ; Make a far jump (to a new segment) to the 32 bit code
  ; this forces the CPU to flush it cache of pre-fetched and
  ; real-mode decoded instructions
  jmp CODE_SEG:init_pm

[bits 32]
init_pm:
  ; old segments are not meaningless so we point our segment
  ; registers to the data selector in the GDT
  mov ax, DATA_SEG
  mov ds, ax
  mov ss, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  mov ebp, 0x90000      ; update stack position to top of free space
  mov esp, ebp

  call BEGIN_PM         ; call a well-known label