; 1's complement and 2's complement of a number

.8086
.model small
.stack 100H
.data
	num db ?
	msg db "Enter the number: ", '$'
	msg2 db "1's complement: ", '$'
	msg3 db "2's complement: ", '$'
.code
	include procs.asm
main:
	lea si, msg
	push si
	call str_write
	pop si
	; get the number 
	call read_byte
	call print_newline
	mov num, al
	not al

	lea si, msg2
	push si
	call str_write
	pop si
	push ax
	call write_byte
	pop ax
	call print_newline
	mov al, num
	neg al

	lea si, msg3
	push si
	call str_write
	pop si
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
