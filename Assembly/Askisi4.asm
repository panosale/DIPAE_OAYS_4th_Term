title askisi4
assume cs: kodikas, ds: dedomena, ss: soros
kodikas segment
    main proc near
            mov ax, dedomena            ; Standard instructions for declaration of data segment 1/2
            mov ds, ax                  ; Standard instructions for declaration of data segment 2/2    
            
            mov si, 0                   ; Initialize index
            mov cx, 80                  ; Initialize CX index for loop
            
            lea dx, PROMPT_MSG1         ; Print message, standard instructions 1/3
            mov ah, 9h                  ; Print message, standard instructions 2/3
            int 21h                     ; Print message, standard instructions 3/3
            
        start_loop:                     ; Main prompt for character loop
        
        ask_for_text:        
            mov ah, 1h                  ; Ask for a character, standard instructions 1/2
            int 21h                     ; Ask for a character, standard instructions 2/2
            
            cmp al, '#'                 ; Compare given character with SHARP (#)
            je sharp_pressed            ; Finish the prompt. Exit loop
            
        save_to_buffer:
            mov BUFFER[si], al          ; Save given & checked character to position [si] of BUFFER
            inc si                      ; Increase BUFFER index [si] by 1
            loop start_loop             ; Continue loop until 80 characters have been given (cx = 0)
            
        sharp_pressed:
            cmp si, 0                   ; Check if no text given...
            je no_text_given            ; ...and show message
            call check-given-char       ; ...else continue
            jmp exit            
        no_text_given:
            lea dx, MSG_NO_TEXT         ; Print message, standard instructions 1/3
            mov ah, 9h                  ; Print message, standard instructions 2/3
            int 21h                     ; Print message, standard instructions 3/3
    
        exit:
            mov ah, 4ch                 ; Exit program, standard instructions 1/2
            int 21h                     ; Exit program, standard instructions 2/2
    main endp
    
    check-given-char proc near
        lea dx, PROMPT_MSG2             ; Print message, standard instructions 1/3
        mov ah, 9h                      ; Print message, standard instructions 2/3
        int 21h                         ; Print message, standard instructions 3/3
        
        mov cx, si
        mov bx, 0                       ; Initialize counter for BUFFER print with loop
        mov si, 0                       ; Print BUFFER instructions 
       
        mov ah, 1h                      ; Ask for a character, standard instructions 1/2
        int 21h                         ; Ask for a character, standard instructions 2/2

        loop_elegxou:                   ; Search given character in given text with loop
            mov dl, BUFFER[si]          ; Add character of BUFFER on [si] position to dl
            inc si                      ; Increase BUFFER index [si] by 1

            cmp dl, al                  ; Compare given character with character in BUFFER[si] postion
            jne character_not_found     ; Character not found in current position. Go to next BUFFER position
            inc bx                      ; Character found in current possition, so increase found counter (bx)
            character_not_found:
                loop loop_elegxou       ; Continue search loop
        cmp bx, 0
        je character_not_found_message
                
        mov TMP_CHAR, al                ; Store al to temporary variable     
        mov ax, bx                      ; Store count of found (bx) to al
        ; Standard series for seperate 2 digit number
        mov cl, 10                      ; Move division 2nd operand to cl
        div cl                          ; Div ax by cl (10)
        mov bh, ah                      ; Temporary store div result on ah to bh (remaining)
        mov bl, al                      ; Temporary store div result on al to bl (quotient)

        ; Start printing search result
        lea dx, RESULT_MSG1             ; Print message, standard instructions 1/3
        mov ah, 9h                      ; Print message, standard instructions 2/3
        int 21h                         ; Print message, standard instructions 3/3

        mov ax, 0
        mov al, TMP_CHAR
        lea dx, ax                      ; Print message, standard instructions 1/3
        mov ah, 2h                      ; Print message, standard instructions 2/3
        int 21h                         ; Print message, standard instructions 3/3

        lea dx, RESULT_MSG2             ; Print message, standard instructions 1/3
        mov ah, 9h                      ; Print message, standard instructions 2/3
        int 21h                         ; Print message, standard instructions 3/3

        cmp bl, 0
        jna dont_print_first_digit
            mov dl, bl                  ; Print number standard series (2nd digit) 1/4
            add dl, 48                  ; Print number standard series (2nd digit) 2/4 (Add 48 to it's ASCII code)
            mov ah, 2h                  ; Print number standard series (2nd digit) 3/4
            int 21h                     ; Print number standard series (2nd digit) 4/4

        dont_print_first_digit:        
            mov dl, bh                  ; Print number standard series (2nd digit) 1/4
            add dl, 48                  ; Print number standard series (2nd digit) 2/4 (Add 48 to it's ASCII code)
            mov ah, 2h                  ; Print number standard series (2nd digit) 3/4
            int 21h                     ; Print number standard series (2nd digit) 4/4
        
        lea dx, RESULT_MSG3             ; Print message, standard instructions 1/3
        mov ah, 9h                      ; Print message, standard instructions 2/3
        int 21h                         ; Print message, standard instructions 3/3
        jmp exit_function
        
        character_not_found_message:
            lea dx, CHAR_NOT_FOUND_MSG  ; Print message, standard instructions 1/3
            mov ah, 9h                  ; Print message, standard instructions 2/3
            int 21h                     ; Print message, standard instructions 3/3
        exit_function:
            ret
    check-given-char endp        
    
kodikas ends

dedomena segment     
    BUFFER db 80 dup(0)                 ; Store 80 zeros to array "BUFFER". Means initialization of BUFFER
    TMP_CHAR db 2 dup(0)                ; Store 2 zeros to array "TMP_CHAR". Means initialization of TMP_CHAR
        
    PROMPT_MSG1 db "Dose ena keimeno mexri 80 xaraktires (# = eksodos): $"
    PROMPT_MSG2 db 10, 13, "Dose enan xaraktira gia anazitisi: $"
    RESULT_MSG1 db 10,13, "O charaktiras [$"
    RESULT_MSG2 db "] vrethike [$"
    RESULT_MSG3 db "] fores.$"
    CHAR_NOT_FOUND_MSG db 10,13, "O charaktiras den vrethike.$"
    MSG_NO_TEXT db "Den edoses kanena keimeno.$"
dedomena ends

soros segment stack
    db 256 dup(0)
soros ends

end main

