; Mulitiplication 8-bit by 8-bit and 8-bit by 16-bit

.8086
.model small
.stack 100H
.data
	num1 db ?
	num2 db ?
	num3 dw ?
	msg1 db "Enter the two 8-bit numbers: ", '$'
	msg2 db "Enter the 8-bit number and one 16-bit number: ", '$'
	msg3 db "Result: ", '$'
.code
	include procs.asm
main:
	lea si, msg1
	push si
	call str_write
	pop si
	; get the two 8-bit numbers
	call read_byte
	mov num1, al
	call print_space
	call read_byte
	mov num2, al
	call print_newline

	; find the muliplication
	mov al, num1
	mul num2

	lea si, msg3
	push si
	call str_write
	pop si
	; print the result
	mov bl, al
	mov al, ah
	push ax
	call write_byte
	pop ax
	mov al, bl
	push ax
	call write_byte
	pop ax
	call print_newline

	lea si, msg2
	push si
	call str_write
	pop si
	; get the 8-bit number and 16-bit number
	call read_byte
	mov num2, al
	call print_space
	call read_byte
	mov bl, al
	call read_byte
	mov ah, bl
	mov num3, ax
	call print_newline
	mov dx, 0000H

	; find the muliplication
	mov ax, num3
	mov bl, num2
	mov bh, 00H
	mul bx

	lea si, msg3
	push si
	call str_write
	pop si
	; print the result
	mov cl, dl
	mov dl, dh
	push dx
	call write_byte
	pop dx
	mov dl, cl
	push dx
	call write_byte
	pop dx
	mov cl, al
	mov al, ah
	push ax
	call write_byte
	pop ax
	mov al, cl
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
