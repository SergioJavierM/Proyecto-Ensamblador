;==============================================================
; Nombre  : Maldonado Damian Sergio Javier
; Horario : 10-11 a.m.
; Materia : Lenguajes de interfaz
; Practica: 4.1 Mayor, menor o igual con entrada del usuario
; Descripcion: pide un numero y lo compara contra 10 con saltos condicionales.
;==============================================================
INCLUDE Irvine32.inc

.data
msgPedir BYTE "Escribe un numero: ",0
msgMayor BYTE "El numero es mayor que 10",0
msgMenor BYTE "El numero es menor que 10",0
msgIgual BYTE "El numero es igual a 10",0

.code
main PROC

    mov edx, OFFSET msgPedir
    call WriteString            ; pide el numero
    call ReadInt                ; lo lee (con signo); queda en EAX

    cmp eax, 10                 ; compara el numero con 10
    jg MAYOR                    ; salta si es mayor
    jl MENOR                    ; salta si es menor
                                ; si no salto, es igual
    mov edx, OFFSET msgIgual
    jmp MOSTRAR

MAYOR:
    mov edx, OFFSET msgMayor
    jmp MOSTRAR

MENOR:
    mov edx, OFFSET msgMenor

MOSTRAR:
    call WriteString            ; muestra el mensaje elegido
    call Crlf

    exit                        ; termina el programa
main ENDP
END main
