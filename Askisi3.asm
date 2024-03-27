
title askisi3
kodikas segment
    assume cs: kodikas, ds: dedomena
    start:
        mov ax, dedomena
        mov ds, ax    
        
        mov si, 0       ; Initialize index
        mov cx, 40      ; Initialize CX index for loop
        
        lea dx, PROMPT_MSG  ; Print message, standard instructions
        mov ah, 9           ; Print message, standard instructions
        int 21h             ; Print message, standard instructions
        
    start_loop: ; do ... while loop - START
    
    ask_for_text:        
        mov ah, 1h          ; Ask for a character, standard instructions
        int 21h             ; Ask for a character, standard instructions
        
        cmp al, 13          ; Compare given character to Enter
        je enter_pressed    ; Finish the prompt

        cmp al, ' '         ; Compare given character to Space
        je save_to_buffer   ; And save it to baffer 
        
        cmp al, '.'         ; Compare given character to .
        je save_to_buffer   ; And save it to baffer
        
        cmp al, 'A'         ; Check if given character is below 'A'
        jb start_loop       ; And ask again
        
        cmp al, 'Z'         ; Check if given character is below or equal to 'Z'
        jbe save_to_buffer  ; And save it to baffer

        cmp al, 'a'         ; Check if given character is below 'a'
        jb ask_for_text     ; And ask again
        
        cmp al, 'z'
        jbe save_to_buffer  ; And save it to baffer
        
        jmp ask_for_text            
        
    save_to_buffer:
        mov BUFFER[si], al
        inc si
        cmp si, 40
        loop start_loop
        
    enter_pressed:
        cmp si, 0
        je no_text_given
        
    emfanisi:
        lea dx, MSG_CONVERTED_TEXT  ; Print message, standard instructions
        mov ah, 9h                  ; Print message, standard instructions
        int 21h                     ; Print message, standard instructions
        
                                    ; Start print BUFFER procedure
        mov cx, si                  ; Initialize counter for BUFFER print with loop
        lea bx, BUFFER              ; Print BUFFER instructions
    loop_emfanisis:
        mov dl, [bx]
        inc bx
        
        cmp dl, ' '                 ; Check if current character is Space
        je emfanisi_allagmenou_charaktira 
        cmp dl, '.'                 ; Check if current character is .
        je emfanisi_allagmenou_charaktira
        
        cmp dl, 'a'                 ; Check if character is in lowercase
        jae convert_to_uppercase    ; If in lowercase then convert to uppercase
        add dl, 32                  ; Else convert current character to lowerercase
        jmp emfanisi_allagmenou_charaktira
        
        convert_to_uppercase:       ; Convert current character to uppercase
            sub dl, 32
             
        emfanisi_allagmenou_charaktira:
            mov ah, 2h              ; Print character, standard instructions
            int 21h                 ; Print character, standard instructions
            loop loop_emfanisis
            
        jmp exit                    
        
    no_text_given:
        lea dx, MSG_NO_TEXT         ; Print message, standard instructions
        mov ah, 9h                  ; Print message, standard instructions
        int 21h                     ; Print message, standard instructions

    exit:
        mov ah, 4ch         ; Exit program, standard instructions
        int 21h             ; Exit program, standard instructions

kodikas ends

dedomena segment     
    MAX_BUFFER_SIZE db 40          
    BUFFER db 40 dup(0)
    
    PROMPT_MSG db "Eisagete keimeno (A-Z, a-z,teleia, space): $"
    MSG_CONVERTED_TEXT db 10, 13, "To keimeno meta tin metatropi: $"
    MSG_NO_TEXT db 10, 13, "Den dosate kanena keimeno.$"
dedomena ends
end start
