nasm -f elf main.asm -o main.o
ld -m elf_i386 -o main main.o
./main
rm main.o
rm main