;==============================================================
; Nombre  : Maldonado Damian Sergio Javier
; Horario : 10-11 a.m.
; Materia : Lenguajes de interfaz
; Practica: 8. Operaciones aritmeticas
; Tema    : 09 - Operaciones aritmeticas
; Programa: ADD, SUB, MUL, IMUL, DIV, IDIV y banderas CF / OF
; Nota    : los NOP sirven como punto para poner un breakpoint y
;           revisar los registros al depurar.
;==============================================================
INCLUDE Irvine32.inc

.data

.code
main PROC

; ADD y SUB: operaciones de suma y resta
    mov eax, 50
    mov ebx, 20
    add eax, ebx            ; EAX = 50 + 20 = 70
    sub eax, 15             ; EAX = 70 - 15 = 55
    nop

; CF: acarreo en una suma sin signo
    mov eax, 0
    mov al, 255             ; AL esta en su maximo sin signo (255)
    add al, 1               ; se pasa de 255: AL = 0 y se activa CF = 1
    call DumpRegs           ; muestra registros y banderas
    nop

; OF: desbordamiento en una suma con signo
    mov eax, 0
    mov al, 127             ; maximo positivo con signo en 8 bits
    add al, 1               ; 127 + 1 = -128 (se activa OF = 1)
    call DumpRegs
    nop

; MUL: producto de valores de 32 bits sin signo
    mov eax, 25
    mov ebx, 3
    mul ebx                 ; EDX:EAX = EAX * EBX = 75
    nop

; IMUL: producto de valores con signo dentro de 32 bits
    mov eax, -5
    imul eax, eax, 3        ; EAX = -5 * 3 = -15
    nop

; MUL: producto que excede los 32 bits
    mov eax, 65537
    mov ebx, 65537
    mul ebx                 ; resultado de 64 bits: parte alta en EDX, baja en EAX
    nop

; DIV: division de numeros sin signo
    mov eax, 125            ; dividendo
    mov edx, 0              ; EDX debe ser 0 antes de dividir
    mov ebx, 12             ; divisor
    div ebx                 ; EAX = cociente (10), EDX = residuo (5)
    nop

; IDIV: division con numeros negativos
    mov eax, -125           ; dividendo con signo
    cdq                     ; extiende el signo de EAX hacia EDX
    mov ebx, 12             ; divisor
    idiv ebx                ; EAX = cociente (-10), EDX = residuo (-5)
    nop

    exit                    ; termina el programa

main ENDP
END main
