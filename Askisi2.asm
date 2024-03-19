title askisi2
kodikas segment
    assume cs: kodikas, ds: dedomena
    start:
        mov ax, dedomena
        mov ds, ax    
        
        mov cl, 0   ; Initialize tries. Temporary use of cl
        
        start_loop: ; do ... while loop
        
        ask_for_number:        
        lea dx, prompt_msg  ; Print message, standard instructions
        mov ah, 9           ; Print message, standard instructions
        int 21h             ; Print message, standard instructions
        
        mov ah, 08h     ; Ask for a number, standard instructions
        int 21h         ; Ask for a number, standard instructions
        
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
        lea dx, wrong_entry ; Print message, standard instructions
        mov ah, 9           ; Print message, standard instructions
        int 21h             ; Print message, standard instructions
        jmp ask_for_number

        zero:
        lea dx, msg_miden   ; Print message, standard instructions
        mov ah, 9           ; Print message, standard instructions
        int 21h             ; Print message, standard instructions
        jmp continue_loop
        
        artios:
        lea dx, msg_artios  ; Print message, standard instructions
        mov ah, 9           ; Print message, standard instructions
        int 21h             ; Print message, standard instructions
        jmp continue_loop

        perittos:
        lea dx, msg_perittos    ; Print message, standard instructions
        mov ah, 9               ; Print message, standard instructions
        int 21h                 ; Print message, standard instructions
        
        continue_loop:      ; do ... while loop
        inc cl              ; Increase number of tries
        cmp cl, max_tries   ; Compare number of tries
        jb start_loop       ; Continue loop if tries not equal to max_tries

        exit:
        mov ah, 4ch ; Exit program, standard instructions
        int 21h     ; Exit program, standard instructions

kodikas ends

dedomena segment               
    max_tries db 5
    wrong_entry db 10, 13, 7, "Lathos eisagogi.", 10, 13, "$"
    prompt_msg db "Dose enan arithmo apo to 0 eos to 9: $"
    msg_miden db 10, 13, "O arithmos einai 0.", 10, 13, "$"
    msg_artios db 10, 13, "O arithmos einai Artios.", 10, 13, "$"
    msg_perittos db 10, 13, "O arithmos einai Perittos.", 10, 13, "$"
dedomena ends
end start
