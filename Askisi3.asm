
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
        
        cmp al, 13
        je enter_pressed

        cmp al, ' '         ; Compare given character to space
        je save_to_buffer 
        
        cmp al, '.'         ; Compare given character to .
        je save_to_buffer
        
        cmp al, 'A'
        jb start_loop
        
        cmp al, 'Z'
        jbe save_to_buffer

        cmp al, 'a'
        jb ask_for_text
        
        cmp al, 'z'
        jbe save_to_buffer
        
        jmp ask_for_text        
        
    save_to_buffer:
        mov BUFFER[si], al
        inc si
        cmp si, 40
;        je emfanisi ;;; den xreiazetai    ??
        loop start_loop
        
    enter_pressed:
        cmp si, 0
        je no_text_given
        
    emfanisi:
        lea dx, MSG_CONVERTED_TEXT  ; Print message, standard instructions
        mov ah, 9h                  ; Print message, standard instructions
        int 21h                     ; Print message, standard instructions
        mov cx, si
        lea bx, BUFFER     ; Print message, standard instructions
    loop_emfanisis:
        mov dl, [bx]
        inc bx
        
        cmp dl, ' '                 ; Check if current character is space
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
            mov ah, 2h                  ; Print character, standard instructions
            int 21h                     ; Print character, standard instructions
            loop loop_emfanisis
        jmp exit                    
        
    no_text_given:
        lea dx, MSG_NO_TEXT         ; Print message, standard instructions
        mov ah, 9h                  ; Print message, standard instructions
        int 21h                     ; Print message, standard instructions
        jmp exit
                            
;    gave_wrong_entry:
;        lea dx, wrong_entry ; Print message, standard instructions
;        mov ah, 9h          ; Print message, standard instructions
;        int 21h             ; Print message, standard instructions
;        jmp ask_for_number  ; Ask for a new correct number

    ;artios:
;        lea dx, msg_artios  ; Print message, standard instructions
;        mov ah, 9h          ; Print message, standard instructions
;        int 21h             ; Print message, standard instructions
;        jmp continue_loop

;    perittos:
;        lea dx, msg_perittos; Print message, standard instructions
;        mov ah, 9h          ; Print message, standard instructions
;        int 21h             ; Print message, standard instructions
        
;    continue_loop:      ; do ... while loop
;        inc cl              ; Increase number of tries
;        cmp cl, max_tries   ; Compare number of tries
;        jb start_loop       ; Continue loop if tries are below max_tries

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
