assume cs:code

code segment 
 start:	mov ax,0B800h
	mov es,ax
	mov bh,'a'
   s:	mov es:[160*12+40*2],bh
	call delay
	inc bh
	cmp bh,'z'
	jna s
	mov ax,4c00h
	int 21h

  delay:push ax
	push bx
	mov bx,1000h
	mov ax,0
   s1:	sub ax,1
	sbb bx,0
	cmp ax,0
	jne s1
	cmp bx,0
	jne s1
	pop bx
	pop ax
	ret	
	
code ends
end start
	