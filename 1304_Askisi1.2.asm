title askisi1.2 ; Calculate (n^2-2*n)+1 with 2 digits result
kodikas segment
    assume cs: kodikas, ds: dedomena
    start:
        mov ax, dedomena ; Declaration of data segment standard sequence 
        mov ds, ax ; Declaration of data segment standard sequence 

        mov al, n   ; Store n to al
        mul n       ; Multiply al by n (n^2)
        mov bx, ax  ; Temporary store multiply result to bx

        mov ax, 2   ; Store 2 to ax
        mul n       ; Multiply ax by 2 (n*2)
        mov cx, ax  ; Temporary store multiply result to cx

        mov ax, bx  ; Store bx back to ax
        sub ax, cx  ; Sub cx from ax
        inc ax      ; Increase ax by 1
        ; or
        ;add ax, 1   ; Add 1 to ax

        ; Standard series for seperate 2 digit number
        mov cl, 10  ; Move division 2nd operand (10) to cl
        div cl      ; Div ax by cl (10)
        mov bh, ah  ; Temporary store div result on ah to bh (remaining)
        mov bl, al  ; Temporary store div result on al to bl (quotient)
        ; or
        ;mov bx, ax  ; Temporary store ax to bx because BIOS destroys ax value after print message

        lea dx, msg ; Print message standard series
        mov ah, 9   ; Print message standard series
        int 21h     ; Print message standard series

        mov dl, bl  ; Print number standard series (1st digit)
        add dl, 48  ; Print number standard series (1st digit)
        mov ah, 2   ; Print number standard series (1st digit)
        int 21h     ; Print number standard series (1st digit)

        mov dl, bh  ; Print number standard series (2nd digit)
        add dl, 48  ; Print number standard series (2nd digit)
        mov ah, 2   ; Print number standard series (2nd digit)
        int 21h     ; Print number standard series (2nd digit)

        mov ah, 4ch ; Exit program standard series
        int 21h     ; Exit program standard series

kodikas ends

dedomena segment
    n db 6 ; Store 6 to variable n
    msg db "To apotelesma einai: $" ; Store output message to msg
dedomena ends
end start
