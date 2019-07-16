; Multiplication by rotation

.8086
.model small
.stack 100H
.data
	num1 dw ?
	num2 dw ?
	msg1 db "Enter the two numbers: ", '$'
	msg2 db "Result: ", '$'
.code
	include procs.asm
main:
	lea si, msg1
	push si
	call str_write
	pop si
	; get the numbers
	call read_byte
	mov bh, al
	call read_byte
	mov ah, bh
	mov num1, ax
	call print_space
	call read_byte
	mov bh, al
	call read_byte
	mov ah, bh
	mov num2, ax
	call print_newline

	mov ax, 0000H
	mov cx, num2

back:
	add ax, num1
	loop back

	lea si, msg2
	push si
	call str_write
	pop si
	; result in ax, print the result
	mov dx, ax
	shr ax, 08H
	push ax
	call write_byte
	pop ax
	mov ax, dx
	push ax
	call write_byte
	pop ax

	ret
	endp
.startup

	mov ax, @data
	mov ds, ax
	call main
	mov ah, 4cH
	int 21H
	end
