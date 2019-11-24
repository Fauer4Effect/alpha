void kernel_main() {
  // point at the first text cell of the video memory
  char* video_memory = (char *) 0xb8000;
  // put an X there
  *video_memory = '$';
}
