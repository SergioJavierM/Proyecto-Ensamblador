;==============================================================
; Nombre  : Maldonado Damian Sergio Javier
; Horario : 10-11 a.m.
; Materia : Lenguajes de interfaz
; Practica: 5. Condicionales (ciclos condicionales while y do-while)
; Descripcion: muestra del 1 al 100 con while (condicion al inicio) y luego con do-while (condicion al final).
;==============================================================
INCLUDE Irvine32.inc

.data
msgWhile   BYTE "--- Ciclo WHILE: condicion al inicio ---",0
msgDo      BYTE "--- Ciclo DO-WHILE: condicion al final ---",0

.code
main PROC

; =========== PARTE A: WHILE (del 1 al 100) ===========
    mov edx, OFFSET msgWhile
    call WriteString
    call Crlf

    mov ebx, 1                  ; EBX = contador
cicloWhile:
    cmp ebx, 100                ; condicion: contador > 100 ?
    jg finWhile                 ; si ya paso de 100, sale del ciclo

    mov eax, ebx
    call WriteDec               ; muestra el contador
    call Crlf

    inc ebx                     ; contador = contador + 1
    jmp cicloWhile              ; vuelve a evaluar la condicion
finWhile:

    call WaitMsg                ; espera una tecla para pasar a la parte B
    call Crlf

; =========== PARTE B: DO-WHILE (del 1 al 100) ===========
    mov edx, OFFSET msgDo
    call WriteString
    call Crlf

    mov ebx, 1                  ; reinicia el contador
cicloDo:
    mov eax, ebx
    call WriteDec               ; el cuerpo se ejecuta al menos una vez
    call Crlf

    inc ebx                     ; contador = contador + 1
    cmp ebx, 100                ; condicion al final del ciclo
    jle cicloDo                 ; si contador <= 100, repite

    exit                        ; termina el programa
main ENDP
END main
