void kernel_main() {
  // point at the first text cell of the video memory
  char* video_memory = (char *) 0xb8000;
  // put an X there
  *video_memory = '$';
}

// This is the linking we eventually want to use
// i686-elf-gcc -T linker.ld -o myos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc