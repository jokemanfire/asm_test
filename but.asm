
code segment
assume cs:code
start:  mov ax,install2
    mov es,ax
    mov bx,0
    
    mov al,1
    mov ch,0
    mov cl,2
    mov dl,0
    mov dh,0
    mov ah,3

    int 13h
    

    mov ax,install1
    mov es,ax
    mov bx,0
    
    mov al,1
    mov ch,0
    mov cl,1
    mov dl,0
    mov dh,0
    mov ah,3

    int 13h
    mov ax,4c00h
    int 21h
code ends

install1 segment
assume cs:install1
        mov ax,2000h
        mov es,ax
        mov bx,0h
        
        mov al,3
        mov ch,0
        mov cl,2
        mov dl,0
        mov dh,0
        
        mov ah,2
        int 13h

        mov ax,2000h
        push ax
        mov ax,0
        push ax
        retf
        mov ax,4c00h
        int 21h
install1 ends


install2 segment 
assume cs:install2
function:  jmp  main
        choices dw reset,windows,clock

main:   call show
        in al,60h
        
    cmp al,01
    je main
        cmp al,04
        ja main
        sub al,2
        mov bl,al
        mov bh,0
        add bl,bl
        call word ptr choices[bx]
    jmp function

show:   mov ax,0b800h
        mov es,ax
        mov bx,0
        mov cx,16
        mov di,offset str
        mov ax,cs
        mov ds,ax
        jmp showstr
    str: db'reset computer:1'
         db'into windows:2  '
         db'show oclock:3   '

showstr:    
        mov ax,[di]
        mov es:[160*12 + 20*2+ bx],ax
    mov dx,5
    mov es:[160*12 + 20*2 + bx +1],dx
        mov ax,[di+16]
        mov es:[160*13 + 20*2 + bx],ax
    mov es:[160*13 + 20*2 + bx +1],dx
        mov ax,[di+32]
        mov es:[160*14 + 20*2 + bx],ax
    mov es:[160*14 + 20*2 + bx +1],dx
        add bx,2
        inc di
        loop showstr
        ret

reset:  mov ax,0ffffh
        mov bx,0
    push ax
    push bx
    mov ax,ss
    mov es,ax
    mov bx,sp
        jmp dword ptr es:[bx]
        ret

windows:    mov ax,0
            mov es,ax
            mov bx,7c00h

            mov al,1
            mov ch,0
            mov cl,1
            mov dl,80h
            mov dh,0
            mov ah,2
            int 13h
        mov ax,0  
            push ax  
            mov ax,7c00h  
            push ax  
            retf

clock:  jmp short clockshow
style: db 9,8,7,4,2,0,'/','/',' ',':',':',0

clockshow:mov ax,cs
        mov ds,ax
    
        mov bx,offset style
        mov si,0
        mov cx,6
        
        s:  push cx
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
        mov word ptr es:[160*12+40*2+si+4],ax
        add si,6
        inc bx
        pop cx
        loop s
    call isright
        ret 
   j:   pop ax
        jmp clock

isright:in al,60h
        cmp al,01
        jne j
    int 16h
        ret

install2 ends
end start