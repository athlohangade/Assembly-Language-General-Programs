; Check if the string is palindrome or not

.8086
.model small
.stack 100H
.data
	data db 100 dup(?)
	ans db 100 dup(?)
	msg db "Enter the string: ", '$'
	msg1 db "Palindrome", "$"
	msg2 db "Not a Palindrome", "$"
.code
	include procs.asm
main:
	; Read the string
	lea si, data
	push si
	call str_read
	pop si

	; Calculate length of the main string
	lea si, data
	lea di, ans
	mov cx, 0000H
back:
	mov al, [si]
	cmp al, '$'
	jz down
	inc si
	inc cl
	jmp back
down:
	dec si
	mov bx, cx

	; Storing the main string in reverse order
back1 :
	mov al, [si]
	mov [di], al
	inc di
	dec si
	loop back1
	mov dl, [di]
	mov [di], dl

	mov cx, bx
	lea si, data
	lea di, ans

	; Check if the main string and reversed string are same
back2:
	mov al, [si]
	cmp al, [di]
	jnz finish
	inc si
	inc di
	loop back2

	; if cx = 0000H, then the string are matched and it is a palindrome else not palindrome
finish:
	cmp cx, 0000H
	jz match
	mov si, offset msg2
	jmp down1
match:
	mov si, offset msg1
down1:
	push si
	call str_write
	pop si

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
