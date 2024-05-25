title askisi1.2             ; Calculate n^2-2*n+1 with 2 digits result
assume cs: kodikas, ds: dedomena
start:
kodikas segment
        mov ax, dedomena    ; Standard sequence for declaration of data segment 1/2
        mov ds, ax          ; Standard sequence for declaration of data segment 1/2

        mov al, n           ; Store n to al
        mul n               ; Multiply al by n (n^2)
        mov bx, ax          ; Temporary store multiply result to bx

        mov ax, 2           ; Store 2 to ax
        mul n               ; Multiply ax by 2 (n*2)
        mov cx, ax          ; Temporary store multiply result to cx

        mov ax, bx          ; Store bx back to ax
        sub ax, cx          ; Sub cx from ax
        inc ax              ; Increase ax by 1
        ; or
        ;add ax, 1   ; Add 1 to ax

        ; Standard instructions for seperate 2 digit number
        mov cl, 10          ; Move division 2nd operand (10) to cl
        div cl              ; Div ax by cl (10)
        mov bh, ah          ; Temporary store div result on ah to bh (remaining)
        mov bl, al          ; Temporary store div result on al to bl (quotient)
        ; or
        ;mov bx, ax  ; Temporary store ax to bx because BIOS destroys ax value after print message

        lea dx, msg         ; Print message standard instructions 1/3
        mov ah, 9h          ; Print message standard instructions 2/3
        int 21h             ; Print message standard instructions 3/3

        mov dl, bl          ; Print number standard instructions (1st digit) 1/4
        add dl, 48          ; Print number standard instructions (1st digit) 2/4
        mov ah, 2h          ; Print number standard instructions (1st digit) 3/4
        int 21h             ; Print number standard instructions (1st digit) 4/4

        mov dl, bh          ; Print number standard instructions (2nd digit) 1/4
        add dl, 48          ; Print number standard instructions (2nd digit) 2/4
        mov ah, 2h          ; Print number standard instructions (2nd digit) 3/4
        int 21h             ; Print number standard instructions (2nd digit) 4/4

        mov ah, 4ch         ; Standard instructions to exit the program 1/2
        int 21h             ; Standard instructions to exit the program 1/2

kodikas ends

dedomena segment
    n db 6                              ; Store 6 to variable n
    msg db "To apotelesma einai: $"     ; Store output message to msg
dedomena ends
end start
