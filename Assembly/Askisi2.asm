title askisi2
start:
assume cs: kodikas, ds: dedomena
kodikas segment
        mov ax, dedomena    ; Standard instructions for declaration of data segment 1/2
        mov ds, ax          ; Standard instructions for declaration of data segment 2/2
        
        mov cl, 0           ; Initialize tries. Temporary use of cl
        
    start_loop:             ; do ... while loop - START
    
    ask_for_number:        
        lea dx, prompt_msg  ; Print message, standard instructions 1/3
        mov ah, 9h          ; Print message, standard instructions 2/3
        int 21h             ; Print message, standard instructions 3/3
        
        mov ah, 8h          ; Ask for a number, standard instructions 1/2
        int 21h             ; Ask for a number, standard instructions 2/2
        
        cmp al, '0'         ; Compare given number to 0
        jb gave_wrong_entry ; Check if given number is below 0 (compares ASCII codes)
        
        cmp al, '9'         ; Copmare given number to 9
        ja gave_wrong_entry ; Check if given number is above 9 (compares ASCII codes)
        
        ; Given number is correct and can be printed
        mov dl, al          ; Print number, standard instructions 1/3
        mov ah, 2h          ; Print number, standard instructions 2/3
        int 21h             ; Print number, standard instructions 3/3

        cmp al, '0'         ; Check if given number is zero
        je zero             ; If given number is zero jump to "zero"
        
        ; Check if given number is artios
        mov bl, 2           ; Store 2 to bl 
        mov ah, 0           ; Initialize ah with 0
        div bl              ; Divide ah by bh (2)
        cmp ah, 0           ; Compare if ah (remaining) is 0 
        je artios           ; If remaining (ah) is 0 then given number is even (artios)
        
        jmp perittos        ; If given number is not zero or artios then it means its odd (perittos)
        
    gave_wrong_entry:
        lea dx, wrong_entry ; Print message, standard instructions 1/3
        mov ah, 9h          ; Print message, standard instructions 2/3
        int 21h             ; Print message, standard instructions 3/3
        jmp ask_for_number  ; Ask for a new correct number

    zero:
        lea dx, msg_miden   ; Print message, standard instructions 1/3
        mov ah, 9h          ; Print message, standard instructions 2/3
        int 21h             ; Print message, standard instructions 3/3
        jmp continue_loop   ; Ask for a new correct number
        
    artios:
        lea dx, msg_artios  ; Print message, standard instructions 1/3
        mov ah, 9h          ; Print message, standard instructions 2/3
        int 21h             ; Print message, standard instructions 3/3
        jmp continue_loop

    perittos:
        lea dx, msg_perittos; Print message, standard instructions 1/3
        mov ah, 9h          ; Print message, standard instructions 2/3
        int 21h             ; Print message, standard instructions 3/3
        
    continue_loop:          ; do ... while loop
        inc cl              ; Increase number of tries
        cmp cl, max_tries   ; Compare number of tries
        jb start_loop       ; Continue loop if tries are below max_tries

    exit:
        mov ah, 4ch         ; Exit program, standard instructions 1/2
        int 21h             ; Exit program, standard instructions 2/2

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
