
gdt_start:

gdt_null: ;mandatory NULL describtor
    dd 0x0
    dd 0x0

gdt_code: ;code segment describtor

    ;base=0x0, limit=0xfffff, 
    ;1st flgs: (presnt) 1 (privelage) 00 (desribtor type) -> 1001b
    ;type flags: (code) 1 (conforming) 0 (readable) 11 (64-bit seg)0 (AVL)0 -> 1010b
    ;2nd flags: (granularitty)1 (32-bit default)1 (64bit seg)0 (AVL)0 -> 1100b
    
    dw 0xffff       ;Limit (0-15 bits)
    dw 0x0          ;Base (0-15 bits)
    db 0x0          ;Base (16-23 bits)
    db 10011010b    ;1st flags, type flags
    db 11001111b    ;2nd flags, limit (16-19)
    db 0x0          ;Base (bits 24-31)

gdt_data: ;data segment describtor
    ;Same as code segment but wit different flags
    ;type flags: (code)0 (expand down)0 (writable)1 (accesses)0 -> 0010b

    dw 0xffff       ;limit
    dw 0x0          ;Base
    db 0x0          ;Base
    db 10010010b    ;1st flags, type flags
    db 11001111b    ;2nd flags, Limit
    db 0x0          ;Base

gdt_end:   
;gdt_end label is so thgat we can have assembler calculate the size of the gdt for the gdt describtor

;GDT describtor
gdt_describtor:
    dw gdt_end - gdt_start - 1 ; Size of GDT, always less one than the true size

    dd gdt_start               ;Start address of GDT


Code_Seg equ gdt_code - gdt_start
Data_Seg equ gdt_data - gdt_start