[org 0x7c00]    
Kernel_Offset equ 0x1000

mov [Boot_Drive], dl

mov bp, 0x9000
mov sp, bp

mov bx, Msg_Real_Mode
call print_string

call load_kernel

call switch_to_pm

jmp $                  

%include "print_string.asm"         ;Utility functions to help debug easier
%include "disk_load.asm"            ;functions which loads the disk 
%include "print_string_pm.asm"      ;function which prints a string in protected Mode
%include "gdt.asm"                  ;global desrbitor table
%include "switch_to_pm.asm"         ;switches from 16 bit real mode, to protected mode

[bits 16]
load_kernel:
    mov bx, Msg_Load_Kernel
    call print_string

    mov bx, Kernel_Offset
    mov dh, 9                  ;TODO: figure out the problem here
    mov dl, [Boot_Drive]
    call disk_load

    ret

[bits 32]
Begin_PM:
    mov ebx, Msg_Prot_Mode
    call print_string_pm

    call Kernel_Offset ;Jump to the position of the kernel

    jmp $           ;hang


Boot_Drive: db 0
Msg_Load_Kernel db "Loading kernel", 0
Msg_Real_Mode db "Started in 16-bit Real Mode", 0
Msg_Prot_Mode db "Successfully landed in 32-bit Protected Mode", 0

times 510-($-$$) db 0
dw 0xaa55

