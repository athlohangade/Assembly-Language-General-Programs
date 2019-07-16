; Change the case of the string

.8086
.model small
.stack 100H
.data
	data db 100 dup(?)
	result db 100 dup(?)
	msg1 db "Enter the string: ", '$'
	msg2 db "Result string: ", '$'
.code
	include procs.asm
main:
	lea si, msg1
	push si
	call str_write
	pop si
	; Read the string
	lea di, result
	lea si, data
	push si
	call str_read
	pop si

	; Change the case
	cld
again:
	lodsb
	cmp al, '$'
	jz over
	cmp al, 5bH
	jc skip1
	sub al, 20H
	jmp skip2
skip1:
	add al, 20H
skip2:
	stosb
	jmp again
over:
	lea si, msg2
	push si
	call str_write
	pop si
	; Print the result string
	mov al, '$'
	mov [di], al
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
