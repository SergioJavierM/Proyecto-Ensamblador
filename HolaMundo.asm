;==============================================================
; Nombre  : Maldonado Damian Sergio Javier
; Horario : 10-11 a.m.
; Materia : Lenguajes de interfaz
; Practica: Hola Mundo en Visual Studio 2022 CON Irvine32
; Descripcion: muestra Hola Mundo usando la libreria Irvine32.
;==============================================================
INCLUDE Irvine32.inc

.data
mensaje BYTE "Hola Mundo",0     ; cadena terminada en 0

.code
main PROC
    mov edx, OFFSET mensaje     ; EDX apunta a la cadena
    call WriteString            ; la imprime
    call Crlf                   ; salto de linea
    exit                        ; termina el programa
main ENDP
END main