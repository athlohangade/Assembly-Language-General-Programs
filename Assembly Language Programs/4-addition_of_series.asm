; Addition of series of numbers

.8086
.model small
.stack 100h
.data
	len db ?
	array db 100 dup(?)
	msg1 db "Enter the length of the block: ", "$"
	msg2 db "Enter the block: ", '$'
	msg3 db 'Addition of the numbers: ', '$'
.code
	
	include procs.asm
main:
	lea si, msg1
	push si
	call str_write
	pop si
	; get the length of the array
	call read_byte
	mov len, al
	mov cl, al
	mov ch, 00H
	lea si, array
	call print_newline

	lea si, msg2
	push si
	call str_write
	pop si
	lea si, array
	; get the array elements
again:
	call read_byte
	mov [si], al
	inc si
	call print_space
	loop again
	call print_newline

	; add the array elements
	mov si, offset array
	mov cl, len
	mov ch, 00H
	mov al, 00H
back:
	add al, [si]
	inc si
	loop back

	lea si, msg3
	push si
	call str_write
	pop si
	; printing the addition of all elements
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
