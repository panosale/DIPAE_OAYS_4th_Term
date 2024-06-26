title askisi3
start:
assume cs: kodikas, ds: dedomena
kodikas segment
        mov ax, dedomena            ; Standard instructions for declaration of data segment 1/2
        mov ds, ax                  ; Standard instructions for declaration of data segment 2/2    
        
        mov si, 0                   ; Initialize given text index
        mov cx, 40                  ; Initialize CX index for loop
        
        lea dx, PROMPT_MSG          ; Print message, standard instructions 1/3
        mov ah, 9                   ; Print message, standard instructions 2/3
        int 21h                     ; Print message, standard instructions 3/3
        
    start_loop:                     ; Main prompt for character loop
    
    ask_for_text:        
        mov ah, 1h                  ; Ask for a character, standard instructions 1/2
        int 21h                     ; Ask for a character, standard instructions 2/2
        
        ; Given character stored in al and now start checks below
        cmp al, 0dh                 ; Compare given character with ENTER (asci 13, or odh)
        je enter_pressed            ; Finish the prompt. Exit loop

        cmp al, ' '                 ; Compare given character with SPACE...
        je save_to_buffer           ; ...and save it to BUFFER 
        
        cmp al, '.'                 ; Compare given character with POINT(.)...
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
        lea dx, MSG_CONVERTED_TEXT  ; Print message, standard instructions 1/3
        mov ah, 9h                  ; Print message, standard instructions 2/3
        int 21h                     ; Print message, standard instructions 3/3

        ; Start print BUFFER procedure
        mov cx, si                  ; Initialize counter for BUFFER print with loop
        lea bx, BUFFER              ; Print BUFFER instructions 
        
    loop_emfanisis:
        mov dl, [bx]                ; Add content of bx address to dl (next BUFFER character)
        inc bx                      ; Increase bx address by 1 (prepare bx for next BUFFER character)
        
        cmp dl, ' '                 ; Check if current character is SPACE...
        je emfanisi_charaktira 
        cmp dl, '.'                 ; ...else check if current character is POINT(.)...
        je emfanisi_charaktira
        
        cmp dl, 'a'                 ; ...else check if character is in lowercase
        jae convert_to_uppercase    ; If in lowercase then convert to uppercase...
        add dl, 32                  ; ...else convert current character to lowercase (ascii + 32)
        jmp emfanisi_charaktira
        
        convert_to_uppercase:       
            sub dl, 32              ; Convert current character to uppercase (ascii - 32)
             
        emfanisi_charaktira:
            mov ah, 2h              ; Print character, standard instructions 1/2
            int 21h                 ; Print character, standard instructions 2/2
        loop loop_emfanisis         ; Continue loop until all characters finish (cx = 0)
            
        jmp exit                    ; Print finished. End program                    
        
    no_text_given:
        lea dx, MSG_NO_TEXT         ; Print message, standard instructions 1/3
        mov ah, 9h                  ; Print message, standard instructions 2/3
        int 21h                     ; Print message, standard instructions 3/3
        ; ...and continue to exit procedure

    exit:
        mov ah, 4ch                 ; Exit program, standard instructions 1/2
        int 21h                     ; Exit program, standard instructions 2/2

kodikas ends

dedomena segment     
    BUFFER db 40 dup(0)              ; Store 40 zeros to array "BUFFER". Means initialization of BUFFER
    PROMPT_MSG db "Eisagete keimeno (A-Z, a-z,teleia, space): $"
    MSG_CONVERTED_TEXT db 10, 13, "To keimeno meta tin metatropi: $"
    MSG_NO_TEXT db 10, 13, "Den dosate kanena keimeno.$"
dedomena ends
end start
