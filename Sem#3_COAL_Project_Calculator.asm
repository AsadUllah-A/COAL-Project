; Macro to display a string
display macro var9
    lea dx, var9      ; Load the address of the variable into DX
    mov ah, 9         ; DOS interrupt service for displaying a string
    int 21h           ; Call interrupt 21h to print the string
endm

.model small
.stack 100h
.data
    var db "!!!< Calculator >!!!$"
    var1 db "1. Add (a+b)$"
    var2 db "2. Multiply (a*b)$"
    var3 db "3. Subtract (a-b)$"
    var4 db "4. Divide (a/b)$"
    var5 db "5. Square (a^2)$"
    var6 db "6. Modulus (a%b)$" 
    var7 db "7. Factorial (a!)$"
    var8 db "8. Exit$"        
    var9 db "Enter your choice (1-8): $" 
    var10 db "Enter first number: $" 
    resultLabel db 0dh,0ah, "Result: $"
    thanksMessage db 0dh,0ah, "Thanks for using the calculator!!!$"
    num1 db 0
    num2 db 0
    result db 0
.code
main proc
    mov ax, @data
    mov ds, ax

menu:
    ; Display menu
    call new_line
    display var
    call new_line 
    call new_line
    display var1
    call new_line
    display var2
    call new_line
    display var3
    call new_line
    display var4
    call new_line
    display var5
    call new_line
    display var6      
    call new_line 
    display var7
    call new_line
    display var8
    call new_line
    call new_line
    display var9

    ; Select operation
    mov ah, 1        ; Input for which option add, sub, or div
    int 21h
    sub al, '0'      ; Convert ASCII to integer
    cmp al, 1        ; Check if addition
    je Addition
    cmp al, 2        ; Check if multiplication
    je Multiplication
    cmp al, 3        ; Check if subtraction
    je Subtraction
    cmp al, 4        ; Check if division
    je Division
    cmp al, 5        ; Check if square
    je Square
    cmp al, 6        ; Check if modulus
    je Modulus
    cmp al, 7        ; Check if factorial
    je Factorial    
    cmp al, 8        ; Check if exit
    je ExitProgram   

    ; If invalid choice, go back to menu
    jmp menu

Addition proc
    ; Input first number
    call new_line
    call new_line
    display var10
    call get_number
    mov num1, al

    ; Input second number
    call new_line
    display var10
    call get_number
    mov num2, al

    ; Perform addition
    call new_line
    mov al, num1
    add al, num2
    mov result, al

    ; Display result
    call new_line
    display resultLabel
    call display_result
    call new_line
    jmp menu
Addition endp    

Subtraction proc
    ; Input first number
    call new_line 
    call new_line
    display var10
    call get_number
    mov num1, al

    ; Input second number
    call new_line
    display var10
    call get_number
    mov num2, al

    ; Perform subtraction
    mov al, num1
    sub al, num2
    mov result, al

    ; Display result
    call new_line
    display resultLabel
    call display_result
    call new_line
    jmp menu
Subtraction endp

Multiplication proc
    ; Input first number
    call new_line  
    call new_line
    display var10
    call get_number
    mov num1, al

    ; Input second number
    call new_line
    display var10
    call get_number
    mov num2, al

    ; Perform multiplication
    mov al, num1
    mov ah, 0
    mul num2
    mov result, al

    ; Display result
    call new_line
    display resultLabel
    call display_result
    call new_line
    jmp menu
Multiplication endp

Division proc
    ; Input first number
    call new_line 
    call new_line
    display var10
    call get_number
    mov num1, al

    ; Input second number
    call new_line
    display var10
    call get_number
    mov num2, al

    ; Perform division if num2 is not zero
    mov al, num1
    mov ah, 0
    div num2
    mov result, al

    ; Display result
    call new_line
    display resultLabel
    call display_result
    call new_line
    jmp menu
Division endp

Square proc
    ; Input number
    call new_line
    call new_line
    display var10
    call get_number
    mov num1, al

    ; Perform square (x^2)
    mov al, num1
    mov ah, 0
    mul num1
    mov result, al

    ; Display result
    call new_line
    display resultLabel
    call display_result
    call new_line
    jmp menu
Square endp

Modulus proc
    ; Input first number
    call new_line
    call new_line
    display var10
    call get_number
    mov num1, al

    ; Input second number
    call new_line
    display var10
    call get_number
    mov num2, al

    ; Perform modulus operation (remainder of division)
    mov al, num1
    mov ah, 0
    div num2
    mov result, ah   ; Remainder after division is stored in AH

    ; Display result
    call new_line
    display resultLabel
    call display_result
    call new_line
    jmp menu
Modulus endp

Factorial proc
    ; Input number
    call new_line
    call new_line
    display var10
    call get_number
    mov num1, al

    ; Compute factorial
    mov al, 1           ; Start with 1
    mov bl, num1        ; Load num1 into bl
factorial_loop:
    mul bl              ; Multiply AL by BL
    dec bl              ; Decrease BL by 1
    jnz factorial_loop  ; Repeat until BL is 0

    mov result, al      ; Store the result in the result variable

    ; Display result
    call new_line
    display resultLabel
    call display_result
    call new_line
    jmp menu
Factorial endp

ExitProgram proc
    ; Display exit message
    display thanksMessage
    call new_line
    ; Exit the program
    mov ah, 4Ch
    int 21h
ExitProgram endp

get_number proc
    ; Read a single digit (0-9)
    mov ah, 1
    int 21h
    sub al, '0'    ; Convert ASCII to integer
    ret
get_number endp

display_result proc
    ; Display the result as an ASCII character
    add result, '0'   ; Convert to ASCII
    mov dl, result
    mov ah, 2         ; Display the character in DL
    int 21h
    ret
display_result endp

new_line proc
    mov dl, 13
    mov ah, 2
    int 21h
    mov dl, 10
    mov ah, 2
    int 21h 
    ret
new_line endp

end main
