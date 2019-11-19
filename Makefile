boot_sect.bin: boot_sect.asm
	nasm $^ -f bin -o $@

test: boot_sect.bin
	bochs

clean:
	rm boot_sect.bin
