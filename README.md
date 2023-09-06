# x86-assembly-calculator
A basic arithmetic calculator for 1-digit inputs in Intel x86 assembly. Supports 2-digit outputs, such as 9x9 = 81.
Feel free to use or modify as you wish.

If you want to compile and run it in your own machine, you'll need to install NASM. The provided run.sh script
automatically builds, runs and deletes the program.

debug.sh is just a faster shortcut to run the program with the gdb debugger. You'll need to install gdb to use it,
and I would recommend installing gef, a set of additional features for gdb, to help with debugging.
