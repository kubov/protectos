all:
	nasm main.asm
	./makefloppy.py main

debug:
	bochs -f bochsrc -q
