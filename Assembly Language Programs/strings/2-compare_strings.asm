; Compare two strings

.8086
.model small
.stack 100H
.data
	data1 db 100 dup(?)
	data2 db 100 dup(?)
	msg4 db "Enter the String 1: ", '$'
	msg5 db "Enter the String 2: ", '$'
	msg1 db "String 1 is greater than String 2", "$"
	msg2 db "String 2 is greater than String 1", "$"
	msg3 db "String 1 is equal to String 2", "$"
.code
	include procs.asm
main:
	lea si, msg4
	push si
	call str_write
	pop si
	; Read the strings
	lea si, data1
	push si
	call str_read
	pop si
	lea si, msg5
	push si
	call str_write
	pop si
	lea si, data2
	push si
	call str_read
	pop si

	; Compare the two strings
	lea si, data1
	lea di, data2
back:
	mov al, [si]
	mov bl, [di]
	inc si
	inc di
	cmp al, bl
	jnz down
	cmp al, '$'
	jnz back
	lea si, msg3
	jmp skip2
down:
	jc skip
	lea si, msg1
	jmp skip2
skip:
	lea si, msg2
skip2:
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
