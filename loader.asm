BITS 32
global loader
extern kmain

	MAGIC_NUMBER equ 0x1BADB002
	FLAGS equ 0x0
	CHECKSUM equ -MAGIC_NUMBER
	STACK_SIZE equ 0x1000

section .text:

align 4
	dd MAGIC_NUMBER
	dd FLAGS
	dd CHECKSUM

loader:
	mov esp, stack + STACK_SIZE
	call kmain
hlt:
	jmp hlt

section .bss
align 4
stack:
	resb STACK_SIZE
