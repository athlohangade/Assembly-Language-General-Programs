; Performing (a+b)*(c+d) and (a*b)+(c*d)

.8086
.model small
.stack 100H
.data
	a db ?
	b db ?
	c db ?
	d db ?
	msg1 db "Enter the numbers a, b, c, d: ", '$'
	msg2 db "Result1: ",'$'
	msg3 db "Result2: ",'$'
.code
	include procs.asm
main:
	lea si, msg1
	push si
	call str_write
	pop si
	; get the numbers
	call read_byte
	mov a, al
	call print_space
	call read_byte
	mov b, al
	call print_space
	call read_byte
	mov c, al
	call print_space
	call read_byte
	mov d, al
	call print_newline

	; evaluate (a+b)*(c+d)
	mov al, a
	add al, b
	mov bl, c
	add bl, d
	mul bl

	lea si, msg2
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

	; evaluate (a*b)+(c*d)
	mov al, a
	mov bl, b
	mul bl
	mov cx, ax
	mov al, c
	mov bl, d
	mul bl
	add ax, cx

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
	
	ret
	endp
.startup

	mov ax, @data
	mov ds, ax
	call main
	mov ah, 4cH
	int 21H
	end
