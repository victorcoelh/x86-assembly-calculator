;Calculadora em Assembly
;----------------------------------------------------
;funciona para entradas de 1 dígito, mas
;suporta saídas de até 2 dígitos (9x9, por exemplo).
;não funciona para subtrações cujo resultado é negativo.

%macro print 2
    ;printa a mensagem %1 de tamanho %2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 0x80
%endmacro

%macro read 2
    ;armazena a entrada %1 de tamanho %2
    mov eax, 3
    mov ebx, 0
    mov ecx, %1
    mov edx, %2
    int 0x80
%endmacro

%macro exit 0
    ;finaliza o programa
    print newline, 1
	mov	eax, 1
	int	0x80
%endmacro

section	.text
	global _start
	
_start:
    ;lê a operação
    print prompt3, 75
    read operacao, 2

    ;lê o primeiro número
    print prompt1, 27
    read num1, 1
    read temp, 1
    
    ;lê o segundo número
    print prompt2, 26
    read num2, 1
    read temp, 1
    
    ;armazena os números no eax e ebx
    mov ax, [num1]
    and ah, 0
    sub eax, '0'
    mov ebx, [num2]
    sub ebx, '0'

    ;verifica qual operação realizar
    mov ecx, 0
    mov cl, [operacao]
    sub cl, '0'

    cmp ecx, 1
    je soma

    cmp ecx, 2
    je subtrai

    cmp ecx, 3
    je multi

    cmp ecx, 4
    je divide

    ;caso uma operação invalida seja lida, sai do programa
    exit

soma:
    ;soma dois números e printa o resultado
    ;como o resultado pode ser >10, precisamos dividir por 10,
    ;para obter a dezena (quociente) e a unidade (resto)
    add eax, ebx
    mov bl, byte 10
    div bl

    add al, '0'
    add ah, '0'
    mov [res], al
    mov [temp], ah
    print res_soma, 6
    print res, 1
    print temp, 1
    
    exit

subtrai:
    ;subtrai dois números e printa o resultado
    ;não funciona para situações em que o primeiro número
    ;é menor que o segundo (resultado negativo)
    sub eax, ebx
    add eax, '0'
    mov [res], eax

    print res_sub, 13
    print res, 2

    exit

multi:
    ;multiplica dois números e printa o resultado
    ;como o resultado pode ser >10, precisamos dividir por 10,
    ;para obter a dezena (quociente) e a unidade (resto)
    mul bl
    mov bl, byte 10
    div bl

    add al, '0'
    add ah, '0'
    mov [res], al
    mov [temp], ah
    print res_multi, 17
    print res, 1
    print temp, 1

    exit

divide:
    ;divide dois números e printa o resultado
    mov edx, 0
    div ebx

    add eax, '0'
    add edx, '0'
    mov [res], eax
    mov [temp], edx
    print res_div, 11
    print res, 2
    print newline, 1
    print res_div2, 7
    print temp, 2

    exit

section	.bss
    num1 resb 2
    num2 resb 2
    res resb 2
    operacao resb 2
    temp resb 2
    
section .data
    prompt1 db 'Insira o primeiro número: '
    prompt2 db 'Insira o segundo número: '
    prompt3 db 'Qual operação? 1- Soma, 2- Subtração, 3- Multiplicação, 4- Divisão: '
    res_soma db 'Soma: '
    res_sub db 'Subtração: '
    res_multi db 'Multiplicação: '
    res_div db 'Quociente: '
    res_div2 db 'Resto: '
    newline db 0ah
