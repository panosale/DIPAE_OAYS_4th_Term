title askisi1
kodikas segment
    assume cs: kodikas, ds: dedomena
    start:
        mov ax, dedomena
        mov ds, ax

        mov al, n   ; Store n to al
        mul n       ; Multiply al with n (n^2)
        mov bl, al  ; Temporary store multiply result to bl

        mov al, 2   ; Store n to al again
        mul n       ; Multiply al with 2 (n*2)
        mov cl, al  ; Temporary store multiply result to cl

        mov al, bl  ; Store bl back to al
        sub al, cl  ; Sub cl from al
        add al, 1   ; Add 1 to al
        mov bl, al  ; Temporary store al to bl because BIOS destroys al value after print message


        lea dx, message
        mov ah, 9
        int 21h

        mov dl, bl
        add dl, 48
        mov ah, 2
        int 21h

        mov ah, 4ch
        int 21h

kodikas ends

dedomena segment
    n db 2
    message db "To apotelesma einai: $"
    newline db ".", 10, 13, "$"
dedomena ends
end start

