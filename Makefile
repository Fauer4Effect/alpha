boot_sect.bin: boot_sect.asm
	nasm $^ -f bin -o $@

kernel.o: kernel.c
	i686-elf-gcc -c $^ -o $@ -std=c99 -ffreestanding -O2 -Wall -Wextra -g

kernel.bin: kernel.o
	# This is the linking we eventually want to use
	# i686-elf-gcc -T linker.ld -o myos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc
	i686-elf-ld -o $@ -Ttext 0x1000 $^ --oformat binary

debug: boot_sect.bin
	bochs -f bochs-debug

run: boot_sect.bin
	bochs

all: boot_sect.bin kernel.bin
	cat boot_sect.bin kernel.bin > os-image
	
clean:
	rm *.bin *.o os-image
