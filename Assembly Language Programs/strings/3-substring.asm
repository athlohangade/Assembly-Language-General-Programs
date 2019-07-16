; Check for the substring

.8086
.model small
.stack 100H
.data
	main_str db 100 dup(?)
	sub_str db 100 dup(?) 
	msg1 db "Enter the main string:", 0AH, 0DH, "$"
	msg2 db "Enter the substring:", 0AH, 0DH, "$"
	msg3 db "FOUND", "$"
	msg4 db "NOT FOUND", "$"
.code
	include procs.asm
main:
	; Read the strings
	lea si, msg1
	push si
	call str_write
	pop si
	lea si, main_str
	push si
	call str_read
	pop si
	lea si, msg2
	push si
	call str_write
	pop si
	lea si, sub_str
	push si
	call str_read
	pop si

	; First calculate length of main string
	mov cx, 0000H
	lea si, main_str
back:
	inc cx
	inc si
	mov al, [si]
	cmp al, '$'
	jnz back

	; Find the substring
	cld
	lea di, main_str
again:
	lea si, sub_str
back2:
	mov al, [si]
	cmp al, '$'		; This jump takes place if the substring is found in the main string
	jz over1
	mov bl, [di]
	cmp bl, '$'		; This jump takes place if the substring is not found in the main string
	jz over2
	inc si
	scasb
	jz back2
	jmp again

	; Printing whether found or not found
over1:
	lea si, msg3
	push si
	call str_write
	pop si
	jmp final
over2:
	lea si, msg4
	push si
	call str_write
	pop si
final:
	ret
	endp
.startup
	mov ax, @data
	mov ds, ax
	mov es, ax
	call main
	mov ah, 4cH
	int 21H
	end
