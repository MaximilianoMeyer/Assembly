section .data
    filename db 'file.txt', 0

section .bss
    filehandle dq ?
    buffer resb 1024
    nlines dd ?

section .text
    global _start

_start:
    ; Abre o arquivo
    mov eax, 5
    mov ebx, filename
    mov ecx, 0
    int 0x80
    mov [filehandle], eax

    ; Lê o arquivo linha por linha
    mov edx, buffer
    mov ecx, 1024
read_loop:
    mov eax, 3
    mov ebx, [filehandle]
    int 0x80
    cmp eax, 0
    je end_of_file

    ; Conta o número de novas linhas
    mov esi, edx
    mov edi, edx + eax
    mov al, 0x0a
    mov [edi], al
    add edi, 1
find_newline:
    cmp byte [esi], 0x0a
    je found_newline
    inc esi
    cmp esi, edi
    jne find_newline
    jmp read_loop

found_newline:
    inc nlines
    jmp read_loop

end_of_file:
    ; Fecha o arquivo
    mov eax, 6
    mov ebx, [filehandle]
    int 0x80

    ; Exibe o número de linhas
    mov eax, 4
    mov ebx, 1
    mov ecx, nlines
    mov edx, 4
    int 0x80

    ; Encerra o programa
    mov eax, 1
    xor ebx, ebx
    int 0x80
