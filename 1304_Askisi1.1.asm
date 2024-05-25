title askisi1
kodikas segment
    assume cs: kodikas, ds: dedomena
    start:
        mov ax, dedomena ; Declaration of data segment standard sequence 
        mov ds, ax ; Declaration of data segment standard sequence 

        mov al, n   ; Store n to al
        mul n       ; Multiply al with n (n*n)
        mov bl, al  ; Temporary store multiply result to bl

        mov al, 2   ; Store 2 to al
        mul n       ; Multiply al with 2 (n*2)
        mov cl, al  ; Temporary store multiply result to cl

        mov al, bl  ; Store bl back to al
        sub al, cl  ; Sub cl from al
        add al, 1   ; Add 1 to al
        mov bl, al  ; Temporary store al to bl because BIOS destroys al value after print message

        lea dx, message; Prepare to print message 
        mov ah, 9; Prepare to print message
        int 21h ; Call 21h function to print on screen

        mov dl, bl ; Move to dl the temporary stored value of bl
        add dl, 48 ; Add 48 to value of dl in order to print number (48 is the ASCII code of 0)
        mov ah, 2 ; Prepare to print number ENSURE THAT 
        int 21h ; Call 21h function to print on screen

        mov ah, 4ch ; End program standard sequence
        int 21h ; End program standard sequence

kodikas ends

dedomena segment
    n db 2
    message db "To apotelesma einai: $"
    ;newline db ".", 10, 13, "$"    ; Gia mellontiki xrisi
dedomena ends
end start

