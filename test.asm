assume cs:code

code segment 
	in al,60h
	mov bx,40h
	mov ax,4c00h
	int 21h
code ends

end