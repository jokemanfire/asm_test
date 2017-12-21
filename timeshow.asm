assume cs:code,ds:data

data segment
  	db 9,8,7,4,2,0
	db '/','/',' ',':',':',0

code segment
start:	mov ax,data
	mov ds,ax
	
	mov bx,0
	mov si,0
	mov cx,6
	
    s:	push cx
	mov al,[bx]
	out 70h,al
	in al,71h
	
	mov ah,al
	mov cl,4
	shr ah,cl
	and al,00001111b

	add ah,30h
	add al,30h
	
	push bx

	mov bx,0B800h
	mov es,bx

	mov byte ptr es:[160*12+40*2+si],ah
	mov byte ptr es:[160*12+40*2+2+si],al

	
	
	pop bx
	mov ah,2
	mov al,[bx+6]
	mov byte ptr es:[160*12+40*2+si+4],ax
	add si,6
	inc bx

	pop cx
	loop s
	jmp short startend

startend: mov ax,4c00h
	int 21h

code ends

end start