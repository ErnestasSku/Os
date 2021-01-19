
disk_load:
    push dx

    mov ah, 0x02   ;BIOS read sector function
    mov al, dh     ;Read dh sectors
    mov ch, 0x00   ;Select cylinder 0
    mov dh, 0x00   ;Select head 0
    mov cl, 0x02   ;Start reading from second sector
    int 0x13

    jc disk_error
   
    pop dx
    ;cmp dh, al    ;If al != dh (if read sectors is not eqal the same as we were supposed to read -> error)
    ;jne disk_error
    ret

disk_error:

    mov bx, disk_error_message
    call print_string
    jmp $

disk_success_message db "Disk read correctly", 0
disk_error_message db "Disk read error!", 0