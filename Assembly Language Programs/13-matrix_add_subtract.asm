; Matrix addition and subtraction

.8086
.model small
.stack 100H
.data
	rows db ?
	cols db ?
	matrix1 db 100 dup(?)
	matrix2 db 100 dup(?)
	matrix3 db 100 dup(?)
	msg1 db "Enter the number of rows and columns of matrix:", 0AH, 0DH, "$"
	msg2 db "Enter matrix1:", 0AH, 0DH, "$"
	msg3 db "Enter matrix2:", 0AH, 0DH, "$"
	msg4 db "Addition matrix :", 0AH, 0DH, "$"
	msg5 db "Subtraction matrix :", 0AH, 0DH, "$"
.code
	include procs.asm
main:
	; accept the dimensions of the matrix
	lea si, msg1
	push si
	call str_write
	pop si
	call read_byte
	mov rows, al
	call print_space
	call read_byte
	mov cols, al
	call print_newline
	lea si, msg2
	push si
	call str_write
	pop si

	; Accept matrix 1
	lea si, matrix1
	mov cl, rows
	mov ch, 00H
again:
	push cx
	mov cl, cols
	mov ch, 00H
back:
	call read_byte
	mov [si], al
	call print_space
	inc si
	loop back
	call print_newline
	pop cx
	loop again

	; A Message on screen
	lea si, msg2
	push si
	call str_write
	pop si
	
	; Accept matrix 2
	lea si, matrix2
	mov cl, rows
	mov ch, 00H
again2:
	push cx
	mov cl, cols
	mov ch, 00H
back2:
	call read_byte
	mov [si], al
	call print_space
	inc si
	loop back2
	call print_newline
	pop cx
	loop again2

	; Add the two matrix
	lea di, matrix3
	lea si, matrix1
	lea bx, matrix2
	mov cl, rows
	mov ch, 00H
again3:
	push cx
	mov cl, cols
	mov ch, 00H
back3:
	mov al, [si]
	add al, [bx]
	mov [di], al
	inc si
	inc di
	inc bx
	loop back3
	pop cx
	loop again3

	; Message on screen
	lea si, msg4
	push si
	call str_write
	pop si
	
	; Print the addition matrix
	lea si, matrix3
	mov cl, rows
	mov ch, 00H
again4:
	push cx
	mov cl, cols
	mov ch, 00H
back4:
	push [si]
	call write_byte
	pop [si]
	call print_space
	inc si
	loop back4
	call print_newline
	pop cx
	loop again4

	; Message on screen
	lea si, msg5
	push si
	call str_write
	pop si 

	; Subtract the second matrix from the first
	lea di, matrix3
	lea si, matrix1
	lea bx, matrix2
	mov cl, rows
	mov ch, 00H
again5:
	push cx
	mov cl, cols
	mov ch, 00H
back5:
	mov al, [si]
	sub al, [bx]
	mov [di], al
	inc si
	inc di
	inc bx
	loop back5
	pop cx
	loop again5

	; Print the subtraction matrix
	lea si, matrix3
	mov cl, rows
	mov ch, 00H
again6:
	push cx
	mov cl, cols
	mov ch, 00H
back6:
	push [si]
	call write_byte
	pop [si]
	call print_space
	inc si
	loop back6
	call print_newline
	pop cx
	loop again6
	ret
	endp
.startup

	mov ax, @data
	mov ds, ax
	call main
	mov ah, 4cH
	int 21H
	end
