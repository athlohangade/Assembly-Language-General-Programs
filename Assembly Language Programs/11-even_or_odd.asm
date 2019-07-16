; Even or odd number

.8086
.model small
.stack 100H
.data
	num db ?
	msg db "Enter the number: ", '$'
	even_no db "Number is EVEN$"
	odd_no db "Number is ODD$"
.code
	include procs.asm
main:
	lea si, msg
	push si
	call str_write
	pop si
	; get the number
	call read_byte
	mov num, al
	call print_newline

	; find if the number is odd or even
	ror al, 01H
	jc skip
	lea si, even_no
	jmp skip2
skip:
	lea si, odd_no
skip2:
	push si
	call str_write
	pop si

	ret
	endp
.startup

	mov ax, @data
	mov ds, ax
	call main
	mov ah, 4cH
	int 21H
	end
