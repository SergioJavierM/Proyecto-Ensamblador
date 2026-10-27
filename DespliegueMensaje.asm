;==============================================================
; Nombre  : Maldonado Damian Sergio Javier
; Horario : 10-11 a.m.
; Materia : Lenguajes de interfaz
; Practica: 2. Captura y desplegado de mensaje
; Descripcion: lee un mensaje escrito por el usuario y lo muestra junto con su longitud.
;==============================================================
INCLUDE Irvine32.inc

.data
msgPedir   BYTE "Escribe un mensaje: ",0
msgSalida  BYTE "El mensaje que escribiste es: ",0
msgLong    BYTE "Cantidad de caracteres: ",0

buffer     BYTE 51 DUP(0)       ; buffer: 50 caracteres + 1 para el 0 final
longitud   DWORD ?              ; aqui se guarda cuantos caracteres se leyeron

.code
main PROC

    mov edx, OFFSET msgPedir
    call WriteString            ; pide el mensaje

    mov edx, OFFSET buffer      ; EDX = donde se guardara lo que se escriba
    mov ecx, SIZEOF buffer - 1  ; ECX = maximo de caracteres a leer
    call ReadString             ; EAX = cantidad de caracteres leidos
    mov longitud, eax           ; guarda la longitud

    mov edx, OFFSET msgSalida
    call WriteString
    mov edx, OFFSET buffer      ; EDX apunta al mensaje capturado
    call WriteString            ; lo despliega
    call Crlf

    mov edx, OFFSET msgLong
    call WriteString
    mov eax, longitud
    call WriteDec               ; muestra la longitud
    call Crlf

    exit                        ; termina el programa
main ENDP
END main