assume cs:code

code segment
 start:	mov ah,9
	mov al,'a'
	mov bl,7
	mov bh,0
	mov cx,3
	int 10h
	jmp short start
	
	mov ax,4c00h
	int 21h

code ends
end start