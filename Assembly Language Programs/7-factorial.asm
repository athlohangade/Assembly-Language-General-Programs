;Factorial of a number

.8086
.model small
.stack 100H
.data
	num db ?
	msg db "Enter the number: ", '$'
	msg2 db "Result: ", '$'
.code
	include procs.asm
main:
	lea si, msg
	push si
	call str_write
	pop si
	; get the number 
	call read_byte
	call print_newline
	mov num, al
	mov cl, al
	mov ch, 00H
	mov al, 01H
	mov bl, al
	mov ah, 00H
	mov bh, ah

	; calculate the factorial of the number
back:
	mul bx
	inc bx
	loop back

	lea si, msg2
	push si
	call str_write
	pop si
	; print the factorial of the number
	mov cx, ax
	mov al, ah
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
