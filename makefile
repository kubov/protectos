all: loader.asm
	nasm -f elf32 loader.asm
	ld -T link.ld -melf_i386 loader.o -o kernel.elf

image.bin: kernel.elf
	@rm image.bin || true
	@dd if=/dev/zero of=image.bin count=16000
	@/sbin/mkfs.vfat image.bin
	@syslinux image.bin
	@mcopy -i image.bin kernel.elf ::kernel.elf
	@mcopy -i image.bin syslinux.cfg ::syslinux.cfg
	@mcopy -i image.bin /usr/lib/syslinux/mboot.c32 ::mboot.c32

debug: image.bin
	qemu-system-i386 -s -S image.bin
