; Guessing game program
 ORG 100h
.model small
.stack 100h

.data
guess db ?
secret db 7
count db 0
msg1 db 'Guess a number between 0 and 9: ', 0Ah, 0Dh, '$'
msg2 db 'Too small.', 0Ah, 0Dh, '$'
msg3 db 'Too big.', 0Ah, 0Dh, '$'
msg4 db 'Invalid input.', 0Ah, 0Dh, '$'
msg5 db 'Correct! You look 4 guess ', 0Ah, 0Dh, '$'

.code
org 100h

main proc
    mov ax, @data
    mov ds, ax

start:
    ; Prompt user for guess
    lea dx, msg1
    mov ah, 9
    int 21h

    ; Read user input
    xor ah, ah
    int 16h

    ; Check for non-digit input
    cmp al, '0'
    jb invalid_input
    cmp al, '9'
    ja invalid_input

    ; Convert ASCII digit to number
    sub al, '0'

    ; Compare guess to secret number
    mov bl, al
    mov al, secret
    cmp bl, al
    je guessed_correctly
    jl guessed_too_small
    jg guessed_too_big

guessed_too_small:
    ; Guess is too small
    lea dx, msg2
    mov ah, 9
    int 21h
    jmp increment_count

guessed_too_big:
    ; Guess is too big
    lea dx, msg3
    mov ah, 9
    int 21h
    jmp increment_count

guessed_correctly:
    ; Guess is correct
    lea dx, msg5
    mov ah, 9
    int 21h

    ; Output number of guesses
    mov al, count
    add al, '0'
    mov ah, 0Eh
    int 10h

    ; End program
    mov ah, 4Ch
    int 21h

invalid_input:
    ; Invalid input
    lea dx, msg4
    mov ah, 9
    int 21h

increment_count:
    ; Increment guess count
    inc count
    jmp start

main endp

end main
