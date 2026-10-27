;==============================================================
; Nombre  : Maldonado Damian Sergio Javier
; Horario : 10-11 a.m.
; Materia : Lenguajes de interfaz
; Practica: 3. Comparacion y prueba (CMP y TEST)
; Descripcion: CMP compara dos valores y actualiza las banderas; TEST hace un AND sin guardar el resultado.
;==============================================================
INCLUDE Irvine32.inc

.data
msgIguales  BYTE "CMP 5,5 (iguales): ZF=1",0
msgMenor    BYTE "CMP 3,7 (3 menor que 7): CF=1 y SF=1",0
msgMayor    BYTE "CMP 9,4 (9 mayor que 4): ZF=0 y CF=0",0
msgPar      BYTE " es par (el bit 0 es 0)",0
msgImpar    BYTE " es impar (el bit 0 es 1)",0

.code

;--------------------------------------------------------------
; EvaluarParidad: usa TEST para saber si un numero es par o impar
; Recibe: EAX = numero
;--------------------------------------------------------------
EvaluarParidad PROC
    call WriteDec               ; muestra el numero (conserva EAX)
    test al, 1                  ; AND con 1 sin guardar; solo afecta las banderas
    jz esPar                    ; ZF = 1 -> el bit 0 es 0 -> par
    mov edx, OFFSET msgImpar
    jmp mostrar
esPar:
    mov edx, OFFSET msgPar
mostrar:
    call WriteString
    call Crlf
    ret
EvaluarParidad ENDP

main PROC

; ---- CMP: valores iguales ----
    mov edx, OFFSET msgIguales
    call WriteString
    call Crlf
    mov eax, 5
    mov ebx, 5
    cmp eax, ebx                ; EAX - EBX = 0 -> ZF = 1
    call DumpRegs               ; muestra registros y banderas

; ---- CMP: primero menor que el segundo ----
    mov edx, OFFSET msgMenor
    call WriteString
    call Crlf
    mov eax, 3
    mov ebx, 7
    cmp eax, ebx                ; 3 - 7 es negativo -> CF = 1, SF = 1
    call DumpRegs

; ---- CMP: primero mayor que el segundo ----
    mov edx, OFFSET msgMayor
    call WriteString
    call Crlf
    mov eax, 9
    mov ebx, 4
    cmp eax, ebx                ; 9 - 4 = 5 -> ZF = 0, CF = 0
    call DumpRegs

; ---- TEST: par o impar ----
    call Crlf
    mov eax, 7
    call EvaluarParidad
    mov eax, 10
    call EvaluarParidad

    exit                        ; termina el programa
main ENDP
END main