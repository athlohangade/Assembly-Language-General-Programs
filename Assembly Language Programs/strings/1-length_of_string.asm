; Calculate the length of the string

.8086
.model small
.stack 100H
.data
	data db 100 dup(?)
	len db ?
	msg db "Enter the string: ", '$'
	msg2 db "Length of the string: ", '$'
.code
	include procs.asm
main:
	lea si, msg
	push si
	call str_write
	pop si
	; Read the string
	lea si, data
	push si
	call str_read
	pop si

	; Calculate the length of the string
	cld
	mov cx, 0000H
back:
	lodsb
	inc cx
	cmp al, '$'
	jnz back
	dec cx			; '$' is also counted in length, hence decrement
	mov len, cl

	lea si, msg2
	push si
	call str_write
	pop si
	; Print the length
	push cx
	call write_byte
	pop cx
	ret
	endp

.startup
	mov ax, @data
	mov ds, ax
	call main
	mov ah, 4cH
	int 21H
	end
