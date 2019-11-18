print_string:
  pusha
  mov ah, 0x0e
  xor cx, cx
  mov dx, bx

  loop:
    ; bx gets clobbered so we have to move the value in repeatedly
    mov bx, dx
    add bx, cx
    mov al, [bx]
    cmp al, 0
    je done
    int 0x10
    add cx, 1
    jmp loop

  done:
    ; line feed and carriage return
    mov al, 0x0a
    int 0x10
    mov al, 0x0d
    int 0x10
    popa
    ret