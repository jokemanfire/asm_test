assume cs:code

data segment

  db	'Welcome to masm!',0
data ends

code segment

start:	mov dh,8
	mov dl,3
	mov cl,2
	mov ax,data
	mov ds,ax
	mov si,0
	call show_str

	mov ax,4c00h
	int 21h

show_str:
	mov ax,0B800H
	mov es,ax
	mov ax,0A0H
	sub dh,1
	mul dh
	mov bl,cl
	mov si,ax
	mov ax,2
	mul dl
	mov al,dl
	mov ah,0
	mov dl,2
	mul dl
	add si,ax
	mov di,0
	mov cx,16

  s:	mov al,[di]
	mov es:[si],al
	mov es:[si+1],bl
	inc di
	inc si
	inc si
	loop s
	ret
	
code ends
end start