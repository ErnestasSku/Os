print_string:
    push ax
print_string_loop:
    mov al, [bx]
    mov ah, 0x0e    ;BIOS instruction to print charaters to the screen
    int 0x10
    inc bx
    cmp al, 0
    jne print_string_loop
    pop ax
    ret

