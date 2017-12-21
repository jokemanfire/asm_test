assume cs:code

code segment
   table db'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'
 
 start:	mov al,1ah
	jmp short show
	mov ax,4c00h
	int 21h


 show:
	push bx
	push es
	mov ah,al
	shr ah,1
	shr ah,1
	shr ah,1
	shr ah,1
	and al,00001111b
	
	mov bl,ah
	mov bh,0
	mov ah,table[bx]

	mov bx,0b800h
	mov es,bx
	mov es:[160*12+40*2],ah

	mov bl,al
	mov bh,0
	mov al,table[bx]

	mov es:[160*12+40*2+2],al

	pop es
	pop bx
 	
	ret
code ends
end start