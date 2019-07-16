; Block transfer

.8086
.model small
.stack 100h
.data
	len db ?
	msg1 db "Enter the length of the block: ", '$'
	msg2 db "Enter the block: ", '$'
	msg3 db "Block is: ", '$'
	msg4 db "Transferred block is: ", '$'
	blk1 db 100 dup(?)
	blk2 db 100 dup(?)
.code
	include procs.asm
main:
	lea si, msg1
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

	lea si, msg2
	push si
	call str_write
	pop si
	lea si, blk1
	; get the block of the data
again:
	call read_byte
	mov [si], al
	inc si
	call print_space
	loop again
	call print_newline
	
	; transfer the block of data to another block
	mov si, offset blk1
	mov cl, len
	mov ch, 00h
back:
	mov al, [si]
	mov [bx], al
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
