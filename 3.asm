assume cs:code

code segment

start: 	mov ax,cs
	mov ds,ax
	mov si,offset do
	mov cx,offset doend- offset do
	
	mov ax,0
	mov es,ax
	mov di,200h
	cld
	rep movsb
	
	mov ax,0
	mov ds,ax
	mov ax,ds:[0]
	mov dx,ds:[0+2]
	mov word ptr ds:[0],0
	mov word ptr ds:[0+2],200h
	int 0
	mov word ptr ds:[0],ax
	mov word ptr ds:[0+2],dx
	mov ax,4c00h
	int 21h 

do:	jmp short dostart
	db"overflow!!"
	

dostart:mov ax,cs
	mov ds,ax
	mov si,202h
	
	mov ax,0b800h
	mov es,ax
	mov cx,10
	mov di,160*12+36*2

  s:	mov al,[si]
	mov es:[di],al
	inc si
	add di,2	
	loop s
	mov ax,4c00h
	int 21h

doend:
	nop

code ends

end start