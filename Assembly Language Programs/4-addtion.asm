; 8/16/32 bit addition

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
	; addition and printing the result
	mov al, num1
	add al, num2
	jnc skip
	mov bl, 01H
	push bx
	call write_nibble
	pop bx
skip:
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
	; addition and printing the result
	mov ax, num3
	add ax, num4
	jnc skip2		; print the carry if generated
	mov bl, 01H
	push bx
	call write_nibble
	pop bx
skip2:
	mov cx, ax		; addition in ax
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

	; addition and printing the result
	mov ax, num4		; first add the lower 16-bit of both the numbers
	add ax, num6
	mov dx, ax
	mov ax, num3
	adc ax, num5		; add with carry the higher 16-bit of both the numbers
	jnc skip3		; print final carry if generated
	mov bl, 01H
	push bx
	call write_nibble
	pop bx
skip3:
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
