;==============================================================
; Nombre  : Maldonado Damian Sergio Javier
; Horario : 10-11 a.m.
; Materia : Lenguajes de interfaz
; Practica: 6. Decremento e incremento (control de acceso con DEC)
; Tema    : 06 - Control de acceso
; Programa: Validacion de una clave con 3 intentos
; Descripcion: pide la clave; si es correcta permite el acceso,
;              si falla 3 veces bloquea el sistema.
;==============================================================
INCLUDE Irvine32.inc

.data
msgPIN      BYTE "Ingrese la clave: ",0
msgError    BYTE "Clave incorrecta.",0
msgAcceso   BYTE "Acceso permitido.",0
msgBloqueo  BYTE "Sistema bloqueado.",0
msgIntentos BYTE "Intentos restantes: ",0

claveCorrecta = 1234        ; constante con la clave correcta

.code
main PROC

    mov ebx, 3              ; EBX = numero de intentos disponibles

intentar:
    mov edx, OFFSET msgPIN
    call WriteString        ; pide la clave
    call ReadInt            ; lee de consola el PIN ingresado (queda en EAX)

    cmp eax, claveCorrecta  ; compara el PIN ingresado con el correcto
    je acceso               ; si son iguales, da acceso

    mov edx, OFFSET msgError
    call WriteString        ; avisa que la clave es incorrecta
    call Crlf

    dec ebx                 ; descuenta 1 intento
    jz bloqueado            ; si llego a 0, bloquea el sistema

    mov edx, OFFSET msgIntentos
    call WriteString        ; "Intentos restantes: "
    mov eax, ebx            ; EAX = intentos que quedan
    call WriteDec           ; los muestra
    call Crlf

    jmp intentar            ; vuelve a pedir la clave

acceso:
    mov edx, OFFSET msgAcceso
    call WriteString
    call Crlf
    jmp fin

bloqueado:
    mov edx, OFFSET msgBloqueo
    call WriteString
    call Crlf

fin:
    exit                    ; termina el programa

main ENDP
END main
