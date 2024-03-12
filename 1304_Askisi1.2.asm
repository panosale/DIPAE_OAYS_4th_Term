title askisi1.2
kodikas segment
    assume cs: kodikas, ds: dedomena
    start:
        mov ax, dedomena
        mov ds, ax

        mov al, n   ; Store n to al
        mul n       ; Multiply al by n (n^2)
        mov bx, ax  ; Temporary store multiply result to bx

        mov ax, 2   ; Store 2 to ax
        mul n       ; Multiply ax by 2 (n*2)
        mov cx, ax  ; Temporary store multiply result to cx

        mov ax, bx  ; Store bx back to ax
        sub ax, cx  ; Sub cx from ax
        add al, 1   ; Add 1 to ax
        mov bx, ax  ; Temporary store ax to bx because BIOS destroys ax value after print message

        ; Standard series for seperate 2 digit number
        mov cl, 10  ; Move division 2nd operand to cl
        div cl      ; Div ax by cl (10)
        mov bh, ah  ; Store div result on ah to bh (remaining)
        mov bl, al  ; Store div result on al to bl (quotient)

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
    n db 5
    msg db "To apotelesma einai: $"
dedomena ends
end start

