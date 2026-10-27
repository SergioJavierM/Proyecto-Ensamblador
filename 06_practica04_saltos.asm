;==============================================================
; Nombre  : Maldonado Damian Sergio Javier
; Horario : 10-11 a.m.
; Materia : Lenguajes de interfaz
; Practica: 4. Saltos
; Programa: Comparacion de un numero contra 10 (CMP y saltos)
; Descripcion: compara el valor de EAX con 10 y muestra si es
;              mayor o si es menor/igual.
;==============================================================
INCLUDE Irvine32.inc

.data
mensaje1 BYTE "El numero es mayor que 10",0          ; se muestra si EAX > 10
mensaje2 BYTE "El numero es menor o igual que 10",0  ; se muestra si EAX <= 10

.code
main PROC

    mov eax, 8              ; numero a evaluar (cambialo para probar)
    cmp eax, 10             ; compara EAX con 10 (actualiza las banderas)

    jg MAYOR                ; salta si EAX > 10 (comparacion con signo)
    jmp MENOR               ; si no salto, EAX <= 10

MAYOR:
    mov edx, OFFSET mensaje1    ; EDX apunta a la cadena a imprimir
    call WriteString            ; imprime la cadena
    jmp FIN                     ; evita caer en el bloque MENOR

MENOR:
    mov edx, OFFSET mensaje2
    call WriteString

FIN:
    call Crlf               ; salto de linea
    exit                    ; termina el programa

main ENDP
END main
