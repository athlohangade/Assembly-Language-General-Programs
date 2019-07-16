; Division of 16-bit number by an 8-bit number

.8086
.model small
.stack 100H
.data
	num1 dw ?
	num2 db ?
	msg db "Enter the 16-bit and 8-bit number: ", '$'
	Rem db "Remainder : $"
	Quo db "Quotient : $"
.code
	include procs.asm
main:
	lea si, msg
	push si
	call str_write
	pop si
	; get the numbers
	call read_byte
	mov bl, al
	call read_byte
	mov ah, bl
	mov num1, ax
	call print_space
	call read_byte
	mov num2, al
	cmp num2, 00H
	jz over
	call print_newline

	; find the remainder and quotient
	mov ax, num1
	div num2

	; print the result
	lea si, Quo
	push si
	call str_write
	pop si
	mov bh, ah
	push ax
	call write_byte
	pop ax
	call print_newline
	lea si, Rem
	push si
	call str_write
	pop si
	mov al, bh
	push ax
	call write_byte
	pop ax

over:
	ret
	endp

.startup
	mov ax, @data
	mov ds, ax
	call main
	mov ah, 4cH
	int 21H
	end
