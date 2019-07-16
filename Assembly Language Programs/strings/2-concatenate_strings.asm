; Concatenate two strings

.8086
.model small
.stack 100H
.data
	data db 100 dup(?)
	data2 db 100 dup(?)
	result db 100 dup(?)
	msg1 db "Enter the String 1: ", '$'
	msg2 db "Enter the String 2: ", '$'
	r db "Concatenated string: ", '$'
.code
	include procs.asm
main:
	lea si, msg1
	push si
	call str_write
	pop si
	; Read the strings
	lea si, data
	push si
	call str_read
	pop si
	lea si, msg2
	push si
	call str_write
	pop si
	lea si, data2
	push si
	call str_read
	pop si

	; First copy the first string
	lea si, data
	lea di, result
	cld
back:
	lodsb
	stosb
	cmp al, '$'
	jnz back
	dec di

	; Now copy the next string i.e. concatenate it with first string
	lea si, data2
back2:
	lodsb
	stosb
	cmp al, '$'
	jnz back2

	lea si, r
	push si
	call str_write
	pop si
	; Print the concatenated string
	lea si, result
	push si
	call str_write
	pop si

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
