AS:=nasm
ASFLAGS:=-f elf32

CC:=gcc
CFLAGS:= -m32 -nostdlib -nostdinc -fno-builtin -nostartfiles -nodefaultlibs -c

OBJ:=kmain.o loader.o

all: kernel.elf

kernel.elf: $(OBJ)
	ld -T link.ld -melf_i386 $(OBJ) -o kernel.elf

image.bin: kernel.elf
	@rm image.bin || true
	@dd if=/dev/zero of=image.bin count=16000
	@/sbin/mkfs.vfat image.bin
	@syslinux image.bin
	@mcopy -i image.bin kernel.elf ::kernel.elf
	@mcopy -i image.bin syslinux.cfg ::syslinux.cfg
	@mcopy -i image.bin /usr/lib/syslinux/mboot.c32 ::mboot.c32
%.o: %.c
	$(CC) $(CFLAGS)  $< -o $@

%.o: %.asm
	$(AS) $(ASFLAGS) $< -o $@

clean:
	@rm -rf *.o kernel.elf image.bin

debug: image.bin
	qemu-system-i386 -s -S image.bin
