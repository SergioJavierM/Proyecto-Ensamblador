;==============================================================
; Nombre  : Maldonado Damian Sergio Javier
; Horario : 10-11 a.m.
; Materia : Lenguajes de interfaz
; Practica: 5.1 Repetir hasta que el usuario ingrese 0
; Programa: Lee numeros y se detiene cuando se captura un 0
; Descripcion: pide un numero, lo muestra y repite hasta que el
;              usuario escribe 0.
;==============================================================
INCLUDE Irvine32.inc

.data
mensaje BYTE "Introduce un numero (0 para terminar): ",0

.code
main PROC

Ciclo:
    mov edx, OFFSET mensaje     ; EDX apunta al mensaje
    call WriteString            ; lo imprime

    call ReadInt                ; lee un entero con signo; queda en EAX

    cmp eax, 0                  ; el numero capturado es 0 ?
    je Fin                      ; si es 0, termina el programa

    call WriteInt               ; muestra el numero (con signo)
    call Crlf                   ; salto de linea

    jmp Ciclo                   ; vuelve a pedir otro numero

Fin:
    exit                        ; termina el programa

main ENDP
END main
