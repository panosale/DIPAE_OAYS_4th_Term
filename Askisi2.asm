title askisi2
kodikas segment
    assume cs: kodikas, ds: dedomena
    start:
        mov ax, dedomena
        mov ds, ax    
        
        mov cl, 0           ; Initialize tries. Temporary use of cl
        
    start_loop: ; do ... while loop - START
    
    ask_for_number:        
        lea dx, prompt_msg  ; Print message, standard instructions
        mov ah, 9           ; Print message, standard instructions
        int 21h             ; Print message, standard instructions
        
        mov ah, 8h          ; Ask for a number, standard instructions
        int 21h             ; Ask for a number, standard instructions
        
        cmp al, '0'         ; Compare given number to 0
        jb gave_wrong_entry ; Check if given number is below 0
        
        cmp al, '9'         ; Copmare given number to 9
        ja gave_wrong_entry ; Check if given number is above 9
        
        mov dl, al          ; Given number is correct and can be printed
        mov ah, 2h          ; Given number is correct and can be printed
        int 21h             ; Given number is correct and can be printed

        cmp al, '0'         ; Check if given number is zero
        je zero             ; Check if given number is zero
        
        mov bl, 2           ; Check if given number is artios
        mov ah, 0           ; Check if given number is artios
        div bl              ; Check if given number is artios
        cmp ah, 0           ; Check if given number is artios
        je artios           ; Check if given number is artios
        
        jmp perittos        ; If given number is not zero or artios then it means its perittos
        
    gave_wrong_entry:
        lea dx, wrong_entry ; Print message, standard instructions
        mov ah, 9h          ; Print message, standard instructions
        int 21h             ; Print message, standard instructions
        jmp ask_for_number  ; Ask for a new correct number

    zero:
        lea dx, msg_miden   ; Print message, standard instructions
        mov ah, 9h          ; Print message, standard instructions
        int 21h             ; Print message, standard instructions
        jmp continue_loop   ; Ask for a new correct number
        
    artios:
        lea dx, msg_artios  ; Print message, standard instructions
        mov ah, 9h          ; Print message, standard instructions
        int 21h             ; Print message, standard instructions
        jmp continue_loop

    perittos:
        lea dx, msg_perittos; Print message, standard instructions
        mov ah, 9h          ; Print message, standard instructions
        int 21h             ; Print message, standard instructions
        
    continue_loop:      ; do ... while loop
        inc cl              ; Increase number of tries
        cmp cl, max_tries   ; Compare number of tries
        jb start_loop       ; Continue loop if tries are below max_tries

    exit:
        mov ah, 4ch         ; Exit program, standard instructions
        int 21h             ; Exit program, standard instructions

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
