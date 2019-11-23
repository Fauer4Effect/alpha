;
; Ensure that we jump to the kernel's entry function
;

; already in protected mode
[bits 32]
; declare that we will be referencing external symbol main
; so that the linker can resolve it
[extern main]

; call kernel main()
call main
; hang when we return from the kernel
jmp $