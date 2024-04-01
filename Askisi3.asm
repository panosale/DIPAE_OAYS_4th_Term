
title askisi3
kodikas segment
    assume cs: kodikas, ds: dedomena
    start:
        mov ax, dedomena
        mov ds, ax    
        
        mov si, 0                   ; Initialize index
        mov cx, 40                  ; Initialize CX index for loop
        
        lea dx, PROMPT_MSG          ; Print message, standard instructions
        mov ah, 9                   ; Print message, standard instructions
        int 21h                     ; Print message, standard instructions
        
    start_loop:                     ; Main prompt for character loop
    
    ask_for_text:        
        mov ah, 1h                  ; Ask for a character, standard instructions
        int 21h                     ; Ask for a character, standard instructions
        
        cmp al, 13                  ; Compare given character with Enter
        je enter_pressed            ; Finish the prompt. Exit loop

        cmp al, ' '                 ; Compare given character with Space...
        je save_to_buffer           ; ...and save it to BUFFER 
        
        cmp al, '.'                 ; Compare given character with Point(.)...
        je save_to_buffer           ; ...and save it to BUFFER
        
        cmp al, 'A'                 ; Check if given character is below 'A'...
        jb start_loop               ; ...and ask again
        
        cmp al, 'Z'                 ; Check if given character is below or equal to 'Z'...
        jbe save_to_buffer          ; ...and save it to BUFFER

        cmp al, 'a'                 ; Check if given character is below 'a'...
        jb ask_for_text             ; ...and ask again
        
        cmp al, 'z'                 ; Check if given character is below or equal to 'z'...
        jbe save_to_buffer          ; ...and save it to BUFFER
        
        jmp ask_for_text            ; None of above happened so continue to ask for characters            
        
    save_to_buffer:
        mov BUFFER[si], al          ; Save given & checked character to position [si] of BUFFER
        inc si                      ; Increase BUFFER index [si] by 1
        loop start_loop             ; Continue loop until 40 characters have been given (cx = 0)
        
    enter_pressed:
        cmp si, 0                   ; Check if no text given...
        je no_text_given            ; ...and show message
                                    ; ...else continue on showing converted text
    emfanisi:
        lea dx, MSG_CONVERTED_TEXT  ; Print message, standard instructions
        mov ah, 9h                  ; Print message, standard instructions
        int 21h                     ; Print message, standard instructions

                                    ; Start print BUFFER procedure
        mov cx, si                  ; Initialize counter for BUFFER print with loop
        lea bx, BUFFER              ; Print BUFFER instructions 
        
    loop_emfanisis:
        mov dl, [bx]                ; Add content of bx address to dl
        inc bx                      ; Increase bx address by 1
        
        cmp dl, ' '                 ; Check if current character is Space...
        je emfanisi_allagmenou_charaktira 
        cmp dl, '.'                 ; ...else check if current character is Point(.)...
        je emfanisi_allagmenou_charaktira
        
        cmp dl, 'a'                 ; ...else check if character is in lowercase
        jae convert_to_uppercase    ; If in lowercase then convert to uppercase...
        add dl, 32                  ; ...else convert current character to lowercase (ascii + 32)
        jmp emfanisi_allagmenou_charaktira
        
        convert_to_uppercase:       
            sub dl, 32              ; Convert current character to uppercase (ascii - 32)
             
        emfanisi_allagmenou_charaktira:
            mov ah, 2h              ; Print character, standard instructions
            int 21h                 ; Print character, standard instructions
        loop loop_emfanisis         ; Continue loop until all characters finish (cx = 0)
            
        jmp exit                    ; Print finished. End program                    
        
    no_text_given:
        lea dx, MSG_NO_TEXT         ; Print message, standard instructions
        mov ah, 9h                  ; Print message, standard instructions
        int 21h                     ; Print message, standard instructions

    exit:
        mov ah, 4ch                 ; Exit program, standard instructions
        int 21h                     ; Exit program, standard instructions

kodikas ends

dedomena segment     
    MAX_BUFFER_SIZE db 40          
    BUFFER db 40 dup(0)
    
    PROMPT_MSG db "Eisagete keimeno (A-Z, a-z,teleia, space): $"
    MSG_CONVERTED_TEXT db 10, 13, "To keimeno meta tin metatropi: $"
    MSG_NO_TEXT db 10, 13, "Den dosate kanena keimeno.$"
dedomena ends
end start
