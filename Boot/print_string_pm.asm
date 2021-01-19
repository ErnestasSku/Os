[bits 32]

Video_Memory equ 0xb8000
White_On_Black equ 0x0f

print_string_pm:
    pusha
    mov edx, Video_Memory

print_sting_loop:
    mov al, [ebx]
    mov ah, White_On_Black

    cmp al, 0 
    je done

    mov [edx], ax

    add ebx, 1
    add edx, 2

    jmp print_sting_loop

done:
    popa
    ret