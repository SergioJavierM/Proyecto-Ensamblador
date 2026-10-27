;==============================================================
; Nombre  : Maldonado Damian Sergio Javier
; Horario : 10-11 a.m.
; Materia : Lenguajes de interfaz
; Practica: 7. Validacion de formato
; Fecha   : 01-Oct-26
; Programa: Validacion del formato AAA-NNN (7 caracteres)
; Descripcion: lee una cadena y revisa que tenga 3 letras
;              mayusculas, un guion y 3 digitos. Ejemplo: ABC-123
;==============================================================
INCLUDE Irvine32.inc

.data
msgInicio   BYTE "Escribe un texto (AAA-NNN): ",0
msgValido   BYTE "Formato Valido",0
msgInvalido BYTE "Formato Invalido",0

cadena BYTE 20 DUP(0)       ; buffer donde se guarda lo capturado

.code
main PROC

    mov edx, OFFSET msgInicio
    call WriteString            ; pide la cadena

    mov edx, OFFSET cadena      ; EDX = donde se guardara la cadena
    mov ecx, SIZEOF cadena - 1  ; ECX = maximo de caracteres (deja 1 para el 0 final)
    call ReadString             ; EAX = cuantos caracteres se escribieron

    cmp eax, 7                  ; debe tener exactamente 7 caracteres
    jne FormatoInvalido

    mov esi, OFFSET cadena      ; ESI apunta al inicio de la cadena

; posicion 0: letra mayuscula
    mov al, [esi]
    cmp al, 'A'
    jb FormatoInvalido          ; menor que 'A' -> invalido
    cmp al, 'Z'
    ja FormatoInvalido          ; mayor que 'Z' -> invalido

; posicion 1: letra mayuscula
    mov al, [esi+1]
    cmp al, 'A'
    jb FormatoInvalido
    cmp al, 'Z'
    ja FormatoInvalido

; posicion 2: letra mayuscula
    mov al, [esi+2]
    cmp al, 'A'
    jb FormatoInvalido
    cmp al, 'Z'
    ja FormatoInvalido

; posicion 3: debe ser el guion "-"
    mov al, [esi+3]
    cmp al, '-'
    jne FormatoInvalido

; posicion 4: digito
    mov al, [esi+4]
    cmp al, '0'
    jb FormatoInvalido
    cmp al, '9'
    ja FormatoInvalido

; posicion 5: digito
    mov al, [esi+5]
    cmp al, '0'
    jb FormatoInvalido
    cmp al, '9'
    ja FormatoInvalido

; posicion 6: digito
    mov al, [esi+6]
    cmp al, '0'
    jb FormatoInvalido
    cmp al, '9'
    ja FormatoInvalido

; si paso todas las validaciones, el formato es correcto
    mov edx, OFFSET msgValido
    call WriteString
    jmp fin

FormatoInvalido:
    mov edx, OFFSET msgInvalido
    call WriteString

fin:
    call Crlf
    exit                        ; termina el programa

main ENDP
END main
