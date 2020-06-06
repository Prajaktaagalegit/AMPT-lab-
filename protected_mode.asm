; This is a program to enter into protected mode

[BITS 16]
org 0x7c00		; Address of Boot Sector

;Setting Display to VGA mode...

first_boot:
	mov ax, 0x2401
	int 0x15
	mov ax, 0x3
	int 0x10
	cli
	lgdt [gdt_ptr]
	mov eax, cr0
	or eax,0x1
	mov cr0, eax
	jmp CODE_SEG:second_boot


; Global DEscriptor Table Starts entries are used to map virtual to physical memory

global_des_start:
	dq 0x0
global_des_code:
	dw 0xFFFF
	dw 0x0
	db 0x0
	db 10011010b
	db 11001111b
	db 0x0
data:
	dw 0xFFFF
	dw 0x0
	db 0x0
	db 10010010b
	db 11001111b
	db 0x0
global_des_end:
gdt_ptr:
	dw global_des_end - global_des_start
	dd global_des_start

CODE_SEG equ global_des_code - global_des_start
DATA_SEG equ data - global_des_start



bits 32
second_boot:
	mov ax, DATA_SEG
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax
	mov esi, data1
	mov ebx,0xb8000
.loop:
	lodsb
	or al,al
	jz halt
	or eax,0x0100
	mov word [ebx], ax
	add ebx,2
	jmp .loop
halt:
	cli
	hlt

; Printing the Message

data1: db "AMPT (Protected Mode)",0


; Fill rest of sector to 0

times 510 - ($-$$) db 0
dw 0xaa55





