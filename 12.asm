assume cs:code

code segment
	mov al,12
 	out 70h,al
	in al,71h
	mov ah,0
	mov ax,4c00h
	int 21h
code ends

end 