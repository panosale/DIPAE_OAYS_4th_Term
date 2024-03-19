title askisi2
kodikas segment
    assume cs: kodikas, ds: dedomena
    start:
        mov ax, dedomena
        mov ds, ax
        
        ask_for_number:        
        lea dx, prompt_msg  ; Print message standard series
        mov ah, 9           ; Print message standard series
        int 21h             ; Print message standard series
        
        mov ah, 08h     ; Ask for a number standard series
        int 21h         ; Ask for a number standard series
        
        cmp al, '0'
        jb gave_wrong_entry
        
        cmp al, '9'
        ja gave_wrong_entry

        cmp al, '0'     ; Check if given number is zero
        je zero         ; Check if given number is zero
        
        mov bl, 2       ; Check if given number is artios
        mov ah, 0       ; Check if given number is artios
        div bl          ; Check if given number is artios
        cmp ah, 0       ; Check if given number is artios
        je artios       ; Check if given number is artios
        
        jmp perittos    ; If givern numer is not zero or artios means its perittos
        
        gave_wrong_entry:
        lea dx, wrong_entry ; Print message standard series
        mov ah, 9           ; Print message standard series
        int 21h             ; Print message standard series
        jmp ask_for_number

        zero:
        lea dx, msg_miden   ; Print message standard series
        mov ah, 9           ; Print message standard series
        int 21h             ; Print message standard series
        jmp exit
        
        artios:
        lea dx, msg_artios  ; Print message standard series
        mov ah, 9           ; Print message standard series
        int 21h             ; Print message standard series
        jmp exit

        perittos:
        lea dx, msg_perittos    ; Print message standard series
        mov ah, 9               ; Print message standard series
        int 21h                 ; Print message standard series

        exit:
        mov ah, 4ch ; Exit program standard series
        int 21h     ; Exit program standard series

kodikas ends

dedomena segment
    wrong_entry db 10, 13, 7, "Lathos eisagogi.$", 10, 13
    prompt_msg db "Dose enan arithmo apo to 0 eos to 9: $"
    msg_miden db 10, 13, "O arithmos einai 0. $"
    msg_artios db 10, 13, "O arithmos einai Artios. $"
    msg_perittos db 10, 13, "O arithmos einai Perittos. $"
dedomena ends
end start
