title askisi4
assume cs: kodikas, ds: dedomena, ss: soros
kodikas segment
    main proc near
            mov ax, dedomena
            mov ds, ax    
            
            mov si, 0                   ; Initialize index
            mov cx, 80                  ; Initialize CX index for loop
            
            lea dx, PROMPT_MSG1         ; Print message, standard instructions
            mov ah, 9                   ; Print message, standard instructions
            int 21h                     ; Print message, standard instructions
            
        start_loop:                     ; Main prompt for character loop
        
        ask_for_text:        
            mov ah, 1h                  ; Ask for a character, standard instructions
            int 21h                     ; Ask for a character, standard instructions
            
            cmp al, '#'                 ; Compare given character with Sharp (#)
            je sharp_pressed            ; Finish the prompt. Exit loop
            
        save_to_buffer:
            mov BUFFER[si], al          ; Save given & checked character to position [si] of BUFFER
            inc si                      ; Increase BUFFER index [si] by 1
            loop start_loop             ; Continue loop until 80 characters have been given (cx = 0)
            
        sharp_pressed:
            cmp si, 0                   ; Check if no text given...
            je no_text_given            ; ...and show message
            call check-given-char       ; ...else continue
            
        no_text_given:
            lea dx, MSG_NO_TEXT         ; Print message, standard instructions
            mov ah, 9h                  ; Print message, standard instructions
            int 21h                     ; Print message, standard instructions
    
        exit:
            mov ah, 4ch                 ; Exit program, standard instructions
            int 21h                     ; Exit program, standard instructions
    main endp
    
    check-given-char proc near
        lea dx, PROMPT_MSG2             ; Print message, standard instructions
        mov ah, 9                       ; Print message, standard instructions
        int 21h                         ; Print message, standard instructions
        
        mov cx, si
        mov bx, 0                       ; Initialize counter for BUFFER print with loop
        mov si, 0                       ; Print BUFFER instructions 
       
        mov ah, 1h                      ; Ask for a character, standard instructions
        int 21h                         ; Ask for a character, standard instructions

        mov dl, BUFFER[si]              ; Add content of bx address to dl
        loop_elegxou:
            cmp dl, al
            je character_found
            loop loop_elegxou
        character_found:
            inc bx
        mov dl, BUFFER[si]              ; Add content of bx address to dl
        inc si                          ; Increase bx address by 1
        loop loop_elegxou        
    check-given-char endp        
    
kodikas ends

soros segment stack
    db 256 dup(0)
soros ends

dedomena segment     
    BUFFER db 80 dup(0)
    
    PROMPT_MSG1 db "Dose ena keimeno mexri 80 xaraktires (# = eksodos): $"
    PROMPT_MSG2 db 10, 13, "Dose enan xaraktira gia anazitisi: $"
    MSG_NO_TEXT db 10, 13, "Den dosate kanena keimeno.$"
dedomena ends
end main

; NO USE. FOR DEL
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
        
