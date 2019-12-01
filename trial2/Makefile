CFLAGS=-std=c99 -ffreestanding -O0 -Wall -Wextra -g

all: myos.bin

debug: all
	bochs -f bochs-debug

run: all
	bochs

# The actual disk image of the os, bootsector + kernel
myos.bin: boot.o kernel.o
	i686-elf-gcc -T linker.ld -o $@ -ffreestanding -O0 -nostdlib $^ -lgcc
	mkdir -p isodir/boot/grub
	cp myos.bin isodir/boot/myos.bin
	cp grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o myos.iso isodir

boot.o: boot.s
	i686-elf-as $^ -o $@

kernel.o: kernel.c
	i686-elf-gcc -c $^ -o $@ $(CFLAGS)

clean:
	rm -rf isodir/ myos.iso *.o *.bin .gdb_history peda-session* bochslog.txt
