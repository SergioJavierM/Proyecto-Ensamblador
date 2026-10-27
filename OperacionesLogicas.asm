;==============================================================
; Nombre  : Maldonado Damian Sergio Javier
; Horario : 10-11 a.m.
; Materia : Lenguajes de interfaz
; Practica: 11. Operaciones logicas
; Fecha   : 13-10-26
; Programa: Operaciones logicas AND, OR, XOR y TEST
; Descripcion: se maneja el estado de una computadora con bits:
;                bit 0 = computadora (0 apagada, 1 encendida)
;                bit 1 = alarma      (0 apagada, 1 encendida)
;                bit 2 = internet    (0 sin conexion, 1 conectada)
;              Estado inicial: 0000 0101
;==============================================================
INCLUDE Irvine32.inc

; mascaras para aislar cada bit
COMPUTADORA = 00000001b
ALARMA      = 00000010b
INTERNET    = 00000100b

.data
txtAnd       BYTE "1) AND  (estado AND alarma)      : ",0
txtOr        BYTE "2) OR   (enciende la alarma)     : ",0
txtXor1      BYTE "3) XOR  (apaga la computadora)   : ",0
txtXor2      BYTE "   XOR  (enciende la computadora): ",0
txtTest1     BYTE "4) TEST estado 00000101b -> ",0
txtTest2     BYTE "   TEST estado 00000111b -> ",0
msgAlarmaOn  BYTE "alarma encendida",0
msgAlarmaOff BYTE "alarma apagada",0

.code

;--------------------------------------------------------------
; MostrarAlarma: usa TEST para evaluar el bit de la alarma
; Recibe: AL = estado actual
;--------------------------------------------------------------
MostrarAlarma PROC
    test al, ALARMA             ; hace AND sin guardar resultado, solo afecta ZF
    jz apagada                  ; ZF = 1 -> el bit de la alarma es 0
    mov edx, OFFSET msgAlarmaOn
    jmp mostrar
apagada:
    mov edx, OFFSET msgAlarmaOff
mostrar:
    call WriteString
    call Crlf
    ret
MostrarAlarma ENDP

main PROC

; 1 - AND: evaluacion del estado de la alarma
    mov eax, 0
    mov al, 00000101b           ; estado inicial
    and al, ALARMA              ; deja solo el bit de la alarma
    mov edx, OFFSET txtAnd
    call WriteString
    call WriteBin               ; resultado 0 = la alarma esta apagada
    call Crlf
    nop

; 2 - OR: encender la alarma
    mov eax, 0
    mov al, 00000101b
    or al, ALARMA               ; pone en 1 el bit de la alarma -> 00000111b
    mov edx, OFFSET txtOr
    call WriteString
    call WriteBin
    call Crlf
    nop

; 3 - XOR: apagar y encender la computadora (invierte el bit 0)
    mov eax, 0
    mov al, 00000101b
    xor al, COMPUTADORA         ; 1 -> 0: se apaga -> 00000100b
    mov edx, OFFSET txtXor1
    call WriteString
    call WriteBin
    call Crlf

    xor al, COMPUTADORA         ; 0 -> 1: se enciende -> 00000101b
    mov edx, OFFSET txtXor2
    call WriteString
    call WriteBin
    call Crlf
    nop

; 4 - TEST: evaluar si la alarma esta encendida o apagada
    mov al, 00000101b           ; alarma apagada
    mov edx, OFFSET txtTest1
    call WriteString
    call MostrarAlarma

    mov al, 00000111b           ; alarma encendida
    mov edx, OFFSET txtTest2
    call WriteString
    call MostrarAlarma

    exit                        ; termina el programa

main ENDP
END main
