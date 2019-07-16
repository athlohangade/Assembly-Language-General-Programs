; Smallest element of an array

.8086
.model small
.stack 100H
.data
	len db ?
	array db 100 dup (?)
	msg1 db "Enter length of block: ", "$"
	msg2 db "Enter the block: ", "$"
	msg3 db "Smallest Element: ", "$"
.code
	include procs.asm
main:
	lea si, msg1
	push si
	call str_write
	pop si
	; get the length of array
	call read_byte
	mov len, al
	call print_newline

	lea si, msg2
	push si
	call str_write
	pop si
	; get the array elements
	mov cl, len
	mov ch, 00H
	mov si, offset array
main_again1:
	call read_byte
	mov [si], al
	call print_space
	inc si
	loop main_again1
	call print_newline
	
	; find the minimum
	mov si, offset array
	mov cl, len
	mov ch, 00H
	dec cl
	mov al, [si]
main_again2:
	inc si
	cmp al, [si]
	jc main_down
	mov al, [si]
main_down:
	loop main_again2
	
	lea si, msg3
	push si
	call str_write
	pop si
	; print the minimum
	push ax
	call write_byte
	pop ax
	
	mov ah, 4cH
	int 21H
	ret
	endp

.startup
	mov ax, @data
	mov ds, ax
	call main
	mov ah, 21H
	int 21H
	end
