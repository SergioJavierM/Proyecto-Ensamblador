;==============================================================
; Nombre  : Maldonado Damian Sergio Javier
; Horario : 10-11 a.m.
; Materia : Lenguajes de interfaz
; Practica: 1. Ciclos numericos
; Descripcion: usa la instruccion LOOP (ECX es el contador) para contar, sumar y contar en regresiva.
;==============================================================
INCLUDE Irvine32.inc

.data
msgAsc   BYTE "Conteo del 1 al 10: ",0
msgDesc  BYTE "Conteo del 10 al 1: ",0
msgSuma  BYTE "Suma de 1 a 10: ",0

.code
main PROC

; ---- Conteo ascendente: 1 al 10 ----
    mov edx, OFFSET msgAsc
    call WriteString
    mov ecx, 10                 ; LOOP repite mientras ECX sea distinto de 0
    mov ebx, 1                  ; EBX = numero a mostrar
asc:
    mov eax, ebx
    call WriteDec               ; muestra el numero
    mov al, ' '
    call WriteChar              ; espacio entre numeros
    inc ebx                     ; siguiente numero
    loop asc                    ; ECX = ECX - 1 y repite si ECX != 0
    call Crlf

; ---- Conteo descendente: 10 al 1 ----
    mov edx, OFFSET msgDesc
    call WriteString
    mov ecx, 10                 ; ECX baja de 10 a 1, asi que se usa directo
desc:
    mov eax, ecx
    call WriteDec
    mov al, ' '
    call WriteChar
    loop desc
    call Crlf

; ---- Suma de 1 a 10 ----
    mov eax, 0                  ; EAX = acumulador de la suma
    mov ecx, 10
suma:
    add eax, ecx                ; suma 10, 9, 8 ... 1
    loop suma
    mov edx, OFFSET msgSuma
    call WriteString
    call WriteDec               ; muestra 55
    call Crlf

    exit                        ; termina el programa
main ENDP
END main