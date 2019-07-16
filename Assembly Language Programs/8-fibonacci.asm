; Fibonacci Series

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
	;get the number 
	call read_byte
	call print_newline
	mov num, al
	mov cl, al
	mov ch, 00H
	mov al, 00H
	mov bl, 01H

	lea si, msg2
	push si
	call str_write
	pop si
	;print the fibonacci series
back:
	push ax
	call write_byte
	pop ax
	mov ah, al
	mov al, bl
	add bl, ah
	call print_space
	loop back
	ret
	endp

.startup
	mov ax, @data
	mov ds, ax
	call main
	mov ah, 4cH
	int 21H
	end
