;==============================================================
; Nombre  : Maldonado Damian Sergio Javier
; Horario : 10-11 a.m.
; Materia : Lenguajes de interfaz
; Practica: 9. PUSH y POP
; Descripcion: usa la pila para intercambiar dos valores y para invertir una cadena.
;==============================================================
INCLUDE Irvine32.inc

.data
cadena     BYTE "ENSAMBLADOR",0
invertida  BYTE SIZEOF cadena DUP(0)    ; mismo tamano que la cadena original

msgAntes   BYTE "Antes del intercambio  : EAX = ",0
msgDespues BYTE "Despues del intercambio: EAX = ",0
msgEBX     BYTE "   EBX = ",0
msgOrig    BYTE "Cadena original : ",0
msgInv     BYTE "Cadena invertida: ",0

.code

;--------------------------------------------------------------
; MostrarPar: imprime un mensaje y los valores de EAX y EBX
; Recibe: EDX = mensaje, EAX y EBX = valores
;--------------------------------------------------------------
MostrarPar PROC
    push eax                    ; guarda EAX en la pila
    call WriteString            ; imprime el mensaje
    call WriteDec               ; imprime EAX
    mov edx, OFFSET msgEBX
    call WriteString
    mov eax, ebx
    call WriteDec               ; imprime EBX
    call Crlf
    pop eax                     ; recupera el valor original de EAX
    ret
MostrarPar ENDP

main PROC

; ---- 1) Intercambiar dos valores con PUSH y POP ----
    mov eax, 10
    mov ebx, 20
    mov edx, OFFSET msgAntes
    call MostrarPar

    push eax                    ; la pila guarda 10
    push ebx                    ; la pila guarda 20 (queda arriba)
    pop eax                     ; EAX = 20 (el ultimo en entrar es el primero en salir)
    pop ebx                     ; EBX = 10

    mov edx, OFFSET msgDespues
    call MostrarPar
    call Crlf

; ---- 2) Invertir una cadena usando la pila ----
    mov ecx, LENGTHOF cadena - 1    ; cantidad de caracteres (sin el 0 final)
    mov esi, OFFSET cadena          ; ESI recorre la cadena original
meter:
    movzx eax, BYTE PTR [esi]       ; toma un caracter
    push eax                        ; lo mete en la pila
    inc esi                         ; siguiente caracter
    loop meter

    mov ecx, LENGTHOF cadena - 1
    mov edi, OFFSET invertida       ; EDI recorre la cadena invertida
sacar:
    pop eax                         ; saca un caracter (sale en orden contrario)
    mov [edi], al                   ; lo guarda en la cadena invertida
    inc edi
    loop sacar
    mov BYTE PTR [edi], 0           ; marca el fin de la cadena

    mov edx, OFFSET msgOrig
    call WriteString
    mov edx, OFFSET cadena
    call WriteString
    call Crlf

    mov edx, OFFSET msgInv
    call WriteString
    mov edx, OFFSET invertida
    call WriteString
    call Crlf

    exit                            ; termina el programa
main ENDP
END main
