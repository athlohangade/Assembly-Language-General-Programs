; Multiplication by rotation

.8086
.model small
.stack 100H
.data
	num1 db ?
	num2 db ?
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
	mov num1, al
	call print_space
	call read_byte
	mov num2, al
	call print_newline

	; We right shift the second number and check the carry flag, also we left shift the first number. If the carry flag is one then the left shifted first number is added to the second number. This is done until the second number becomes zero
	mov ax, 0000H
	mov cl, num1
	mov ch, 00H
	mov bl, num2
	mov bh, 00H
back:
	shr bx, 01H
	jnc skip
	add ax, cx
skip:
	shl cx, 01H
	cmp cl, 00H
	jnz back

	lea si, msg2
	push si
	call str_write
	pop si
	; result in ax, print the result
	mov bl, al
	mov al, ah
	push ax
	call write_byte
	pop ax
	mov al, bl
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
