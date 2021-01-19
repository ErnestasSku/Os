[bits 16]

switch_to_pm:

cli

lgdt [gdt_describtor] ;Load global describtor table which defines the protected mode segments

mov eax, cr0       
or eax, 0x1
mov cr0, eax

jmp Code_Seg:init_pm ; make a far jump to a new segment (32bit) code segment. This will force the CPU to
                     ; flish its cache of pre-fetched and real-mode decoded instructions which can cause problems

[bits 32]

init_pm:

    mov ax, Data_Seg    ;In PM, old segments are meaningless, so we point to the data selector defined in gdt
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000
    mov esp, ebp

    
    call Begin_PM 