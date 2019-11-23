all: os-image

boot_sect.bin: boot_sect.asm
	nasm $^ -f bin -o $@

kernel.o: kernel.c
	i686-elf-gcc -c $^ -o $@ -std=c99 -ffreestanding -O2 -Wall -Wextra -g

# This is the linking we eventually want to use
# i686-elf-gcc -T linker.ld -o myos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc
kernel.bin: kernel_entry.o kernel.o
	i686-elf-ld -o $@ -Ttext 0x1000 $^ --oformat binary

kernel_entry.o: kernel_entry.asm
	nasm $^ -f elf -o $@

os-image: boot_sect.bin kernel.bin
	cat $^ > $@

debug: all
	bochs -f bochs-debug

run: all
	bochs

kernel.dis: kernel.bin
	ndisasm -b 32 $< > $@
	
clean:
	rm *.bin *.o os-image *.dis
