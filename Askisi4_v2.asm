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
            jmp exit            
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

        loop_elegxou:
            mov dl, BUFFER[si]              ; Add content of bx address to dl
            inc si                          ; Increase bx address by 1

            cmp dl, al
            jne character_not_found
            inc bx            
            character_not_found:
        loop loop_elegxou
        
        mov TMP_CHAR, al
        mov TMP_RESULT_H, bh
        mov TMP_RESULT_L, bl
        mov ax, bx
        ; Standard series for seperate 2 digit number
        mov cl, 10  ; Move division 2nd operand to cl
        div cl      ; Div ax by cl (10)
        mov bh, ah  ; Temporary store div result on ah to bh (remaining)
        mov bl, al  ; Temporary store div result on al to bl (quotient)

        lea dx, RESULT_MSG1             ; Print message, standard instructions
        mov ah, 9                       ; Print message, standard instructions
        int 21h                         ; Print message, standard instructions

        mov ax, 0
        mov al, TMP_CHAR
        lea dx, ax         
        mov ah, 2                       ; Print message, standard instructions
        int 21h                         ; Print message, standard instructions

        lea dx, RESULT_MSG2             ; Print message, standard instructions
        mov ah, 9                       ; Print message, standard instructions
        int 21h                         ; Print message, standard instructions

        mov dl, bh  ; Print number standard series (2nd digit)
        add dl, 48  ; Print number standard series (2nd digit)
        mov ah, 2   ; Print number standard series (2nd digit)
        int 21h     ; Print number standard series (2nd digit)

        mov ah, TMP_RESULT_H
        mov al, TMP_RESULT_L
        cmp ax, '9'
        jbe dont_print_second_character

        mov dl, bl  ; Print number standard series (1st digit)
        add dl, 48  ; Print number standard series (1st digit)
        mov ah, 2   ; Print number standard series (1st digit)
        int 21h     ; Print number standard series (1st digit)

    dont_print_second_character:        
        lea dx, RESULT_MSG3             ; Print message, standard instructions
        mov ah, 9                       ; Print message, standard instructions
        int 21h                         ; Print message, standard instructions
        ret        
    check-given-char endp        
    
kodikas ends

dedomena segment     
    BUFFER db 80 dup(0)
    TMP_RESULT_L db 1 dup(0)
    TMP_RESULT_H db 1 dup(0)
    TMP_CHAR db 1 dup(0)
        
    PROMPT_MSG1 db "Dose ena keimeno mexri 80 xaraktires (# = eksodos): $"
    PROMPT_MSG2 db 10, 13, "Dose enan xaraktira gia anazitisi: $"
    RESULT_MSG1 db 10,13, "O charaktiras [$"
    RESULT_MSG2 db "] vrethike [$"
    RESULT_MSG3 db "] fores.$"
    MSG_NO_TEXT db "Den dosate kanena keimeno.$"
dedomena ends

soros segment stack
    db 256 dup(0)
soros ends

end main

