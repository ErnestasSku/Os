C_COURSES = $(wildcard Kernel/*.c Drivers/*.c)
HEADERS = $(wildcard Kernel/*.h Drivers/*.h)

OBJ = ${C_COURSES:.c=.o}

all: os-image.bin

run: all
	qemu-system-x86_64 os-image.bin

os-image.bin: Boot/boot_sect.bin kernel.bin
	cat $^ > os-image.bin

kernel.bin: Kernel/kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 $^ --oformat binary

#TODO: This can me clened up
Kernel/kernel_entry.o: Kernel/kernel_entry.asm
	nasm $< -f elf64 -o $@



%.o: %.c ${HEADERS}
	gcc -ffreestanding -c $< -o $@



%.bin: %.asm
	nasm $< -f bin -I 'Boot/' -o $@


clean:
	rm -fr *.bin *.oformat *.dis *.o *.map
	rm -fr Kernel/*.o Boot/*.bin Drivers/*.o

