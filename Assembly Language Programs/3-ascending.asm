; Ascending order

.8086
.model small
.stack 100H
.data
	len db ?
	array db 50 dup(?)
	msg1 db "Enter the length of the block: ", "$"
	msg2 db "Enter the block: ", '$'
	msg3 db 'Ascending block: ', '$'
.code
	include procs.asm
main:
	lea si, msg1
	push si
	call str_write
	pop si
	; get the length
	lea si, array
	call read_byte
	call print_newline
	mov len, al
	mov cl, al
	mov ch, 00H

	lea si, msg2
	push si
	call str_write
	pop si
	lea si, array
	; get the array elements
back:
	call read_byte
	call print_space
	mov [si], al
	inc si
	loop back
	call print_newline

	; sorting in ascending order
again:
	mov cl, len
	dec cl
	lea si, array
back2:
	mov al, [si]
	cmp al, [si+01H]
	jc skip
	jz skip
	xchg al, [si+01H]
	mov [si], al
	jmp again
skip:
	inc si
	dec cl
	jnz back2

	lea si, msg3
	push si
	call str_write
	pop si
	; printing the sorted order
	lea si, array
	mov cl, len
	mov ch, 00H
back3:
	push [si]
	call write_byte
	pop [si]
	call print_space
	inc si
	loop back3
	ret
	endp

.startup
	mov ax, @data
	mov ds, ax
	call main
	mov ah, 4cH
	int 21H
	end
