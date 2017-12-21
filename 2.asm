
assume cs:code

code segment
	mov al,2
 	out 70h,al
	in al,71h
code ends

end