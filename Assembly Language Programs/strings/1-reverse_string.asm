; Reverse the string

.8086
.model small
.stack 100H
.data
	data db 100 dup(?)
	len db ?
	rev db 100 dup(?)
	msg1 db "Enter the string: ", '$'
	msg2 db "Reversed string: ", '$'
.code
	include procs.asm
main:
	lea si, msg1
	push si
	call str_write
	pop si
	; Read the string
	lea si, data
	push si
	call str_read
	pop si
	lea di, rev

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
	dec si
	dec si

	; Store the reverse string
	std
back2:
	movsb
	add di, 0002H
	loop back2
	mov al, '$'
	mov [di], al

	lea si, msg2
	push si
	call str_write
	pop si
	; Print the reversed string
	lea di, rev
	push di
	call str_write
	pop di

	ret
	endp

.startup
	mov ax, @data
	mov ds, ax
	mov es, ax
	call main
	mov ah, 4cH
	int 21H
	end
