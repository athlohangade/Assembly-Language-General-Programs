; 8/16/32 bit subtraction

.8086
.model small
.stack 100H
.data
	num1 db ?
	num2 db ?
	num3 dw ?
	num4 dw ?
	num5 dw ?
	num6 dw ?
	msg1 db "Enter two 8-bit numbers: ", '$'
	msg2 db "Enter two 16-bit numbers: ", '$'
	msg3 db "Enter two 32-bit numbers: ", '$'
	msg4 db "Result: ", "$"
.code
	include procs.asm
main:
	lea si, msg1
	push si
	call str_write
	pop si
	; get the two 8-bit numbers
	call read_byte
	call print_space
	mov num1, al
	call read_byte
	call print_newline
	mov num2, al

	lea si, msg4
	push si
	call str_write
	pop si
	; subtraction and printing the result
	mov al, num1
	sub al, num2
	push ax
	call write_byte
	pop ax
	call print_newline

	lea si, msg2
	push si
	call str_write
	pop si
	; get the two 16-bit numbers
	; get the first 16-bit number
	call read_byte
	mov bl, al
	call read_byte
	mov ah, bl
	mov num3, ax
	call print_space

	; get the second 16-bit number
	call read_byte
	mov bl, al
	call read_byte
	mov ah, bl
	mov num4, ax
	call print_newline

	lea si, msg4
	push si
	call str_write
	pop si
	; subtraction and printing the result
	mov ax, num3
	sub ax, num4
	mov cx, ax		; subtraction in ax
	shr ax, 08H		; right shift the result to print higher byte first
	push ax
	call write_byte
	pop ax
	mov ax, cx
	push ax
	call write_byte
	pop ax
	call print_newline

	lea si, msg3
	push si
	call str_write
	pop si
	; get the two 32-bit numbers
	; get the first 32-bit number
	call read_byte
	mov bl, al
	call read_byte
	mov ah, bl
	mov num3, ax		; num3 contains higher 16-bit of first number
	call read_byte
	mov bl, al
	call read_byte
	mov ah, bl
	mov num4, ax		; num4 contains lower 16-bit of first number
	call print_space

	; get the second 32-bit number
	call read_byte
	mov bl, al
	call read_byte
	mov ah, bl
	mov num5, ax		; num4 contains higher 16-bit of second number
	call read_byte
	mov bl, al
	call read_byte
	mov ah, bl
	mov num6, ax		; num6 contains lower 16-bit of first number
	call print_newline

	lea si, msg4
	push si
	call str_write
	pop si
	; subtraction and printing the result
	mov ax, num4
	sub ax, num6		; first subtract the lower 16-bit of second number from first
	mov dx, ax
	mov ax, num3
	sbb ax, num5		; subtract with borrow the higher 16-bit of second number from the first

	mov cx, ax
	shr ax, 08H
	push ax
	call write_byte
	pop ax
	mov ax, cx
	push ax
	call write_byte
	pop ax
	mov ax, dx
	mov cx, ax
	shr ax, 08H
	push ax
	call write_byte
	pop ax
	mov ax, cx
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
