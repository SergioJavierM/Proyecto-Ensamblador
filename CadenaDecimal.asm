;==============================================================
; Nombre  : Maldonado Damian Sergio Javier
; Horario : 10-11 a.m.
; Materia : Lenguajes de interfaz
; Practica: 10. Cadena con decimal (convertir numeros a texto)
; Fecha   : 12-10-26
; Programa: Avance de una descarga por bloques
; Descripcion: con el tamano total, los bloques recibidos y el
;              tamano de cada bloque calcula: bytes descargados,
;              bytes pendientes, porcentaje entero de avance y
;              grupos completos de 1024 con su residuo. Los
;              numeros se convierten a texto con convertirDecimal.
;==============================================================
INCLUDE Irvine32.inc

.data
    TAMANO_TOTAL    DD 100000       ; tamano total del archivo (bytes)
    BLOQUES_REC     DD 125          ; bloques recibidos
    TAM_BLOQUE      DD 512          ; tamano de cada bloque (bytes)
    TAM_GRUPO       DD 1024         ; tamano de un grupo (bytes)
    bufferDecimal   DB 11 DUP(?), 0h    ; texto del numero convertido

    descargados     DD ?            ; resultado: bytes descargados
    pendientes      DD ?            ; resultado: bytes que faltan
    porcentaje      DD ?            ; resultado: porcentaje entero
    grupos          DD ?            ; resultado: grupos completos de 1024
    residuo         DD ?            ; resultado: residuo de esa division

    msg1    DB "Bytes descargados: ", 0
    msg2    DB "Bytes pendientes (faltan): ", 0
    msg3    DB "Porcentaje entero de avance: ", 0
    msg4    DB "Grupos completos de 1024 y residuo: ", 0
    msg5    DB " y residuo ", 0

.code

;--------------------------------------------------------------
; convertirDecimal
; Convierte un numero a una cadena de texto terminada en 0.
; Recibe : EAX = numero, ESI = direccion del buffer destino
; Regresa: el texto en el buffer (ESI queda apuntando al inicio)
;--------------------------------------------------------------
convertirDecimal PROC
    push edi
    push ebx
    push ecx
    push edx

    mov edi, esi            ; guarda el inicio del buffer
    mov ecx, 0              ; ECX = cantidad de digitos
    mov ebx, 10             ; divisor = 10

extraer:
    mov edx, 0              ; limpia EDX antes de dividir
    div ebx                 ; EAX = EAX / 10, EDX = ultimo digito
    push edx                ; guarda el digito en la pila
    inc ecx                 ; un digito mas
    cmp eax, 0              ; ya no quedan digitos?
    jne extraer             ; si quedan, sigue dividiendo

construir:
    pop edx                 ; saca los digitos en orden correcto
    add dl, '0'             ; convierte el digito a su caracter ASCII
    mov [esi], dl           ; lo guarda en el buffer
    inc esi                 ; siguiente posicion
    dec ecx                 ; un digito menos por escribir
    jnz construir

    mov byte ptr [esi], 00h ; marca el fin de la cadena (0)
    mov esi, edi            ; regresa ESI al inicio del buffer

    pop edx
    pop ecx
    pop ebx
    pop edi
    ret
convertirDecimal ENDP

;--------------------------------------------------------------
; imprimirValor
; Imprime un mensaje seguido de un numero (sin salto de linea)
; Recibe : EDX = direccion del mensaje, EAX = numero
;--------------------------------------------------------------
imprimirValor PROC
    call WriteString                ; imprime el mensaje
    mov esi, OFFSET bufferDecimal   ; destino de la conversion
    call convertirDecimal           ; numero -> texto
    mov edx, OFFSET bufferDecimal
    call WriteString                ; imprime el numero convertido
    ret
imprimirValor ENDP

main PROC

; bytes descargados = bloques recibidos * tamano del bloque
    mov eax, BLOQUES_REC
    mul TAM_BLOQUE
    mov descargados, eax

; bytes pendientes = tamano total - bytes descargados
    mov eax, TAMANO_TOTAL
    sub eax, descargados
    mov pendientes, eax

; porcentaje entero = (descargados * 100) / tamano total
    mov eax, descargados
    mov ebx, 100
    mul ebx                 ; EDX:EAX = descargados * 100 (EDX queda en 0)
    div TAMANO_TOTAL        ; EAX = porcentaje entero
    mov porcentaje, eax

; grupos completos de 1024 y residuo
    mov eax, descargados
    mov edx, 0
    div TAM_GRUPO           ; EAX = grupos completos, EDX = residuo
    mov grupos, eax
    mov residuo, edx

; ----- mostrar resultados -----
    mov edx, OFFSET msg1
    mov eax, descargados
    call imprimirValor
    call Crlf

    mov edx, OFFSET msg2
    mov eax, pendientes
    call imprimirValor
    call Crlf

    mov edx, OFFSET msg3
    mov eax, porcentaje
    call imprimirValor
    call Crlf

    mov edx, OFFSET msg4
    mov eax, grupos
    call imprimirValor
    mov edx, OFFSET msg5
    mov eax, residuo
    call imprimirValor
    call Crlf

    exit                    ; termina el programa

main ENDP
END main
