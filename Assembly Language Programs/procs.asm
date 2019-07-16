; parameters are passed through the stack and return values are passed through al

read_nibble proc
	; read ascii in al
	mov ah, 01H
	int 21H
	
	; convert ascii to hex
	cmp al, "A"
	jc read_nibble_down
	sub al, 07H
read_nibble_down:
	sub al, 30H
	ret
endp

write_nibble proc
	; get the character to be printed from stack (only lower nibble of that byte)
	push bp
	mov bp, sp
	push dx
	push ax
	mov dx, [bp + 04H]
	
	; convert the character to its ascii value
	and dx, 000FH
	cmp dl, 0AH
	jc write_nibble_down
	add dl, 07H
write_nibble_down:
	add dl, 30H
	
	; print the character
	mov ah, 02H
	int 21H
	pop ax
	pop dx
	pop bp
	ret
endp

str_read proc
	; get the starting address of the location where string is to be stored
	push bp
	mov bp, sp
	push di
	push ax
	mov ax, @data
	mov es, ax
	mov di, [bp + 04H]

	; keep on reading character till we get space	
	mov ah, 01H
str_read_again:
	int 21H
	cmp al, 0DH
	jz str_read_down
	stosb
	jmp str_read_again
	
	; place $ at the end of the string
str_read_down:
	mov al, "$"
	mov [di], al
	pop ax
	pop di
	pop bp
	ret
endp

str_write proc
	; get the starting address of the string from the stack
	push bp
	mov bp, sp
	push dx
	push ax
	mov dx, [bp + 04H]
	
	; print the string
	mov ah, 09H
	int 21H
	pop ax
	pop dx
	pop bp
	ret
endp

read_byte proc
	; read the byte by calling the read_nibble function twice
	push bx
	call read_nibble
	shl al, 04H
	mov bl, al
	call read_nibble
	or al, bl
	pop bx
	ret
endp	

write_byte proc
	;
	push bp
	mov bp, sp
	push bx
	push ax
	mov al, [bp + 04H]
	shr al, 04H
	push ax
	call write_nibble
	pop ax
	mov al, [bp + 04H]
	push ax
	call write_nibble
	pop ax
	pop ax
	pop bx
	pop bp
	ret
endp

print_space proc
	push ax
	push dx
	mov dl, ' '
	mov ah, 02H
	int 21H
	pop dx
	pop ax
	ret
endp

print_newline proc
	push ax
	push dx
	mov dl, 0AH
	mov ah, 02H
	int 21H
	mov dl, 0DH
	mov ah, 02H
	int 21H
	pop dx
	pop ax
	ret
endp
