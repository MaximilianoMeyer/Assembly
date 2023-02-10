section .data
    msg1 db 'Digite o primeiro número: ', 0
    msg2 db 'Digite o segundo número: ', 0
    msg3 db 'A soma dos números é: ', 0

section .bss
    num1 resb 2
    num2 resb 2
    result resb 2

section .text
    global _start

_start:
    ; Solicita o primeiro número ao usuário
    mov eax, 4 ; write() system call
    mov ebx, 1 ; stdout
    mov ecx, msg1 ; message
    mov edx, 22 ; message length
    int 0x80 ; make the system call

    ; Lê o primeiro número do usuário
    mov eax, 3 ; read() system call
    mov ebx, 0 ; stdin
    mov ecx, num1 ; buffer
    mov edx, 2 ; buffer length
    int 0x80 ; make the system call

    ; Solicita o segundo número ao usuário
    mov eax, 4 ; write() system call
    mov ebx, 1 ; stdout
    mov ecx, msg2 ; message
    mov edx, 22 ; message length
    int 0x80 ; make the system call

    ; Lê o segundo número do usuário
    mov eax, 3 ; read() system call
    mov ebx, 0 ; stdin
    mov ecx, num2 ; buffer
    mov edx, 2 ; buffer length
    int 0x80 ; make the system call

    ; Converte os números de caractere para inteiros
    mov al, [num1] ; primeiro número
    sub al, 48 ; convert to integer
    mov bl, [num2] ; segundo número
    sub bl, 48 ; convert to integer

    ; Adiciona os números
    add al, bl
    mov [result], al

    ; Exibe o resultado da soma na tela
    mov eax, 4 ; write() system call
    mov ebx, 1 ; stdout
    mov ecx, msg3 ; message
    mov edx, 21 ; message length
    int 0x80 ; make the system call

    mov eax, 4 ; write() system call
    mov ebx, 1 ; stdout
    mov ecx, result ; result
    mov edx, 1 ; result length
    int 0x80 ; make the system call

    ; Encerra o programa
    mov eax, 1 ; exit() system call
    xor ebx, ebx ; return value
    int 0x80 ; make the system call
