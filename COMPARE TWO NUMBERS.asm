;This program prompts the user to input two integers,
 
; compares them using both signed and unsiged comparisons  

;--------------------------------------------------------------------------------


DATA SEGMENT
    prompt1 db 10,13, "Enter the first integer: $" 
                                                     
    prompt2 db 10,13, "Enter the second integer: $"  
    
    result_signed db "Signed comparison: $" 
    
    result_unsigned db "Unsigned comparison: $" 
    
    msg_greater db 10,13,"First is greater$"  
    
    msg_less db 10,13, "First is less$" 
    
    msg_equal db 10,13, "Both are equal$"   
    
    newline db 0Ah, 0Dh, "$"       
    
    prompt_continue db 10,13, "Do you want to enter new numbers? (Y/N): $"
    msg_exit db "Exiting program.$"  
    
    num1 dw 0
    num2 dw 0 
    ;----------------------------------------------------------------------------

 CODE SEGMENT
main:
    ; Initialize data segment
    mov ax, @data
    mov ds, ax

start_loop:
    ; Prompt and read the first integer
    mov ah, 09h
    lea dx, prompt1
    int 21h

    ; Read first number (signed)
    mov ah, 01h
    int 21h
    sub al, '0'
    mov bl, al        ; store first number in BL
    mov num1, bx

    ; Prompt and read the second integer
    mov ah, 09h
    lea dx, prompt2
    int 21h

    ; Read second number (signed)
    mov ah, 01h
    int 21h
    sub al, '0'
    mov bh, al        ; store second number in BH
    mov num2, bx

    ; --- Signed Comparison ---
    ; Compare signed numbers
    mov ax, num1
    mov bx, num2
    cmp ax, bx
    je equal_signed    ; Jump if equal
    ja greater_signed  ; Jump if AX > BX (signed)
    jl less_signed     ; Jump if AX < BX (signed)

greater_signed:
    mov ah, 09h
    lea dx, msg_greater
    int 21h
    jmp newline_output

less_signed:
    mov ah, 09h
    lea dx, msg_less
    int 21h
    jmp newline_output

equal_signed:
    mov ah, 09h
    lea dx, msg_equal
    int 21h
    jmp newline_output

newline_output:
    mov ah, 09h
    lea dx, newline
    int 21h

    ; --- Unsigned Comparison ---
    ; Compare unsigned numbers
    mov ax, num1
    mov bx, num2
    cmp ax, bx
    je equal_unsigned    ; Jump if equal
    ja greater_unsigned  ; Jump if AX > BX (unsigned)
    jb less_unsigned     ; Jump if AX < BX (unsigned)

greater_unsigned:
    mov ah, 09h
    lea dx, msg_greater
    int 21h
    jmp newline_output_unsigned

less_unsigned:
    mov ah, 09h
    lea dx, msg_less
    int 21h
    jmp newline_output_unsigned

equal_unsigned:
    mov ah, 09h
    lea dx, msg_equal
    int 21h
    jmp newline_output_unsigned

newline_output_unsigned:
    mov ah, 09h
    lea dx, newline
    int 21h

    ; Ask user if they want to continue entering new numbers
    mov ah, 09h
    lea dx, prompt_continue
    int 21h

    ; Read user response
    mov ah, 01h
    int 21h

    ; If the user presses 'Y' or 'y', repeat the loop, otherwise exit
    cmp al, 'Y'
    je start_loop
    cmp al, 'y'
    je start_loop

    ; Exit program if user presses anything other than 'Y' or 'y'
    mov ah, 09h
    lea dx, msg_exit
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h
end main
