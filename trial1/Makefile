# Automatically generate list of sources
C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

# TODO make sources dep on all header files

# Create list of object files to build, replace .c with .o
OBJ = ${C_SOURCES:.c=.o}

all: os-image

debug: all
	bochs -f bochs-debug

run: all
	bochs

# The actual disk image of the os, bootsector + kernel
os-image: boot/boot_sect.bin kernel.bin
	cat $^ > $@

# Build the binary of the kernel from 2 object files
#		- kernel_entry which jumps to main() in the kernel
# 	- compiled C kernel

kernel.bin: kernel/kernel_entry.o ${OBJ}
	i686-elf-gcc -T linker.ld -o $@ -ffreestanding -O2 -nostdlib $^ -lgcc

# Generic rule to build 'somefile.o' from 'somefile.c'
# For simplicity, C files depend on all header files
%.o : %.c ${HEADERS}
	i686-elf-gcc -c $< -o $@ -std=c99 -ffreestanding -O2 -Wall -Wextra -g

# Assemble the kernel_entry
%.o : %.asm
	nasm $< -f elf -o $@

%.bin : %.asm
	nasm $< -f bin -I 'boot/' -o $@

kernel.dis: kernel.bin
	ndisasm -b 32 $< > $@
	
clean:
	rm -rf *.bin *.o os-image *.dis
	rm -rf kernel/*.o boot/*.bin drivers/*.o
