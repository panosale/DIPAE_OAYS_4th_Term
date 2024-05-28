title eksetasi
assume cs: kodikas, ds: dedomena, ss: soros
kodikas segment
    main proc near
        mov ax, dedomena    ; Standard instructions for declaration of data segment 1/2
        mov ds, ax          ; Standard instructions for declaration of data segment 2/2
        
        mov cl, 0           ; Initialize tries. Temporary use of cl
        mov si, 0           ; Initialize buffer index
        
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
        
        ; Given number is correct and can be stored
        save_to_buffer:
            mov BUFFER[si], al          ; Save given & checked character to position [si] of BUFFER
            inc si                      ; Increase BUFFER index [si] by 1

        ; Given number is correct and can be printed
        mov dl, al          ; Print number, standard instructions 1/3
        mov ah, 2h          ; Print number, standard instructions 2/3
        int 21h             ; Print number, standard instructions 3/3

        lea dx, blank_line  ; Print message, standard instructions 1/3
        mov ah, 9h          ; Print message, standard instructions 2/3
        int 21h             ; Print message, standard instructions 3/3

        inc cl              ; Increase number of tries
        cmp cl, max_tries   ; Compare number of tries
        jb start_loop       ; Continue loop if tries are below max_tries
        
;        call find-max-num
         
        jmp exit            ; Exit program
;        jmp continue_loop

    gave_wrong_entry:
        lea dx, wrong_entry ; Print message, standard instructions 1/3
        mov ah, 9h          ; Print message, standard instructions 2/3
        int 21h             ; Print message, standard instructions 3/3
        jmp ask_for_number  ; Ask for a new correct number     

    exit:
        mov ah, 4ch     ; Exit program, standard instructions 1/2
        int 21h         ; Exit program, standard instructions 2/2
            
    main endp

    find-max-num proc near
        mov cl, [1]                    ; Add 1st number of buffer to cl
        
        ret
    find-max-num endp               
;    continue_loop:          ; do ... while loop
    
kodikas ends

dedomena segment               
    max_tries db 5
    max_num db 1
    buffer db 5 dup(0) ; Store 5 zeros to array BUFFER. Means initialization of BUFFER
    wrong_entry db 10, 13, 7, "Lathos eisagogi.", 10, 13, "$"
    prompt_msg db "Dose enan arithmo apo to 0 eos to 9: $"
    blank_line db 10, 13, "$"
dedomena ends

soros segment
    db 256 dup(0)
    
soros ends

end main