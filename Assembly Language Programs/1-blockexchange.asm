; Block exchange

.8086
.model small
.stack 100h
.data
	len db ?
	blk1 db 100 dup(?)
	blk2 db 100 dup(?)
	len1 db 'Enter block length: ', '$'
	msg1 db 'Enter first block: ', '$'
	msg2 db 'Enter second block: ', '$'
	msg3 db 'New first block: ', '$'
	msg4 db 'New second block: ', '$'
.code
	include procs.asm
main:
	lea si, len1
	push si
	call str_write
	pop si

	; get the length of the block
	call read_byte
	mov si, offset len
	mov [si], al
	mov si, offset blk1
	mov bx, offset blk2
	mov cl, len
	mov ch, 00H
	call print_newline

	lea si, msg1
	push si
	call str_write
	pop si
	
	; get the first block of the data
	lea si, blk1
again:
	call read_byte
	mov [si], al
	inc si
	call print_space
	loop again
	call print_newline

	lea si, msg2
	push si
	call str_write
	pop si	
	; get the second block of the data
	mov cl, len
	mov ch, 00h
again1:
	call read_byte
	mov [bx], al
	inc bx
	call print_space
	loop again1
	call print_newline

	; exchange the block of data with other block
	mov si, offset blk1
	mov bx, offset blk2
	mov cl, len
	mov ch, 00h
back:
	mov al, [si]
	mov ah, [bx]
	mov [bx], al
	mov [si], ah
	inc si
	inc bx
	loop back
	
	lea si, msg3
	push si
	call str_write
	pop si

	;printing the first block
	mov si, offset blk1
	mov cl, len
	mov ch, 00h
back1:
	push [si]
	call write_byte
	pop [si]
	call print_space
	inc si
	loop back1
	call print_newline

	lea si, msg4
	push si
	call str_write
	pop si

	; printing the next block
	mov si, offset blk2
	mov cl, len
	mov ch, 00h
back2:
	push [si]
	call write_byte
	pop [si]
	call print_space
	inc si
	loop back2

	ret
	endp
.startup
	mov ax, @data
	mov ds, ax
	call main
	mov ah, 4cH
	int 21H
	end
