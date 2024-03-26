
title askisi3
kodikas segment
    assume cs: kodikas, ds: dedomena
    start:
        mov ax, dedomena
        mov ds, ax    
        
        mov si, 0           ; Initialize index
        
        lea dx, prompt_msg  ; Print message, standard instructions
        mov ah, 9           ; Print message, standard instructions
        int 21h             ; Print message, standard instructions
        
    start_loop: ; do ... while loop - START
    
    ask_for_text:        
        mov ah, 1h          ; Ask for a character, standard instructions
        int 21h             ; Ask for a character, standard instructions
        
        cmp al, dh
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
        jb start_loop
        
        cmp al, 'z'
        jbe save_to_buffer
        
    save_to_buffer:
        mov BUFFER[si], al
        inc si
        jmp ask_for_text
        
    gave_wrong_entry:
;        lea dx, wrong_entry ; Print message, standard instructions
;        mov ah, 9h          ; Print message, standard instructions
;        int 21h             ; Print message, standard instructions
;        jmp ask_for_number  ; Ask for a new correct number

    emfanisi:
        lea dx, msg_converted_text  ; Print message, standard instructions
        mov ah, 9h                  ; Print message, standard instructions
        int 21h                     ; Print message, standard instructions
        jmp exit                    
        
    enter_pressed:
        lea dx, msg_no_text         ; Print message, standard instructions
        mov ah, 9h                  ; Print message, standard instructions
        int 21h                     ; Print message, standard instructions
        jmp exit                    

    artios:
;        lea dx, msg_artios  ; Print message, standard instructions
;        mov ah, 9h          ; Print message, standard instructions
;        int 21h             ; Print message, standard instructions
;        jmp continue_loop

    perittos:
;        lea dx, msg_perittos; Print message, standard instructions
;        mov ah, 9h          ; Print message, standard instructions
;        int 21h             ; Print message, standard instructions
        
    continue_loop:      ; do ... while loop
;        inc cl              ; Increase number of tries
;        cmp cl, max_tries   ; Compare number of tries
;        jb start_loop       ; Continue loop if tries are below max_tries

    exit:
        mov ah, 4ch         ; Exit program, standard instructions
        int 21h             ; Exit program, standard instructions

kodikas ends

dedomena segment               
    BUFFER db 40 dup(0)
    prompt_msg db "Eisagete keimeno (A-Z, a-z,teleia, space): $"
    msg_converted_text db 10, 13, "To keimeno meta tin metatropi: $"
    msg_no_text db "Den dosate kanena keimeno.", 10, 13, "$"
dedomena ends
end start
