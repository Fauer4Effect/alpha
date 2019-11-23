boot_sect.bin: boot_sect.asm
	nasm $^ -f bin -o $@

debug: boot_sect.bin
	bochs -f bochs-debug

run: boot_sect.bin
	bochs

clean:
	rm boot_sect.bin
