title askisi1 ; Calculate (n^2-2*n)+1 with 1 digit result
start:
assume cs: kodikas, ds: dedomena
kodikas segment
        mov ax, dedomena    ; Standard instructions for declaration of data segment 1/2
        mov ds, ax          ; Standard instructions for declaration of data segment 2/2

        mov al, n           ; Store n to al
        mul n               ; Multiply al with n (n*n)
        mov bl, al          ; Temporary store multiply result to bl

        mov al, 2           ; Store 2 to al
        mul n               ; Multiply al with 2 (n*2)
        mov cx, ax          ; Temporary store multiply result to cl

        mov al, bl          ; Store bl back to al
        sub al, cl          ; Sub cl from al
        add al, 1           ; Add 1 to al
        mov bl, al          ; Temporary store al to bl because BIOS destroys al value after print message

        lea dx, message     ; Prepare to print message, standard instructions 1/3 
        mov ah, 9h          ; Prepare to print message, standard instructions 2/3
        int 21h             ; Call 21h function to print on screen 3/3

        mov dl, bl          ; Move to dl the temporary stored value of bl
        add dl, 48          ; Add 48 to value of dl in order to print number (48 is the ASCII code of 0)
        mov ah, 2h          ; Prepare to print number 
        int 21h             ; Call 21h function to print on screen

        mov ah, 4ch         ; End program standard instructions 1/2
        int 21h             ; End program standard instructions 2/2

kodikas ends

dedomena segment
    n db 2                              ; Store 2 to variable "n"
    message db "To apotelesma einai: $" ; Store output message to "message"
    ;newline db ".", 10, 13, "$"        ; Gia mellontiki xrisi
dedomena ends
end start

