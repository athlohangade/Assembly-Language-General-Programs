; Copy the string

.8086
.model small
.stack 100H
.data
	data db 100 dup(?)
	result db 100 dup(?)
	msg db "Enter the string: ", '$'
	msg2 db "Copied string: ", '$'
.code
	include procs.asm
main:
	lea si, msg
	push si
	call str_write
	pop si
	; Read the string
	lea di, result
	lea si, data
	push si
	call str_read
	pop si

	; Copy the string
	cld
back:
	mov al, [si]
	movsb
	cmp al, '$'
	jz over
	jmp back

over:
	lea si, msg2
	push si
	call str_write
	pop si
	; Print the copied string
	lea di, result
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
