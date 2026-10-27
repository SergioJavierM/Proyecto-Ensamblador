;==============================================================
; Nombre  : Maldonado Damian Sergio Javier
; Horario : 10-11 a.m.
; Materia : Lenguajes de interfaz
; Practica: 6.1 Control de ocupacion de un estacionamiento (INC y DEC)
; Programa: Control de un estacionamiento de 10 carros
; Descripcion: 1 = entra un carro, 2 = sale un carro, 0 = salir.
;              Avisa cuando el estacionamiento se llena y no
;              permite mas entradas; avisa cuando esta vacio.
;==============================================================
INCLUDE Irvine32.inc

CAPACIDAD = 10              ; maximo de carros

.data
mensaje0   BYTE "0 - Salir del programa", 0
mensaje1   BYTE "1 - Entra carro", 0
mensaje2   BYTE "2 - Sale carro", 0
mensaje3   BYTE "Carros actuales: ", 0
lleno      BYTE "Estacionamiento lleno. No se permite el acceso.", 0
llenoAhora BYTE "Se lleno el estacionamiento (10 carros).", 0
vacio      BYTE "Estacionamiento vacio.", 0
entrada    BYTE "Ingrese una opcion: ", 0
invalida   BYTE "Opcion no valida.", 0

.code
main PROC

    mov ebx, 0              ; EBX = cantidad de carros dentro

inicio:
    call Crlf
    mov edx, OFFSET mensaje3
    call WriteString        ; "Carros actuales: "
    mov eax, ebx
    call WriteDec           ; muestra la cantidad de carros
    call Crlf

    mov edx, OFFSET mensaje1
    call WriteString        ; menu: 1 - Entra carro
    call Crlf
    mov edx, OFFSET mensaje2
    call WriteString        ; menu: 2 - Sale carro
    call Crlf
    mov edx, OFFSET mensaje0
    call WriteString        ; menu: 0 - Salir
    call Crlf

    mov edx, OFFSET entrada
    call WriteString
    call ReadInt            ; opcion elegida queda en EAX

    cmp eax, 1
    je entraCarro           ; opcion 1: entra un carro
    cmp eax, 2
    je saleCarro            ; opcion 2: sale un carro
    cmp eax, 0
    je fin                  ; opcion 0: termina el programa

    mov edx, OFFSET invalida    ; cualquier otra opcion es invalida
    call WriteString
    call Crlf
    jmp inicio

entraCarro:
    cmp ebx, CAPACIDAD      ; ya esta lleno?
    jae estacionLleno       ; si ya hay 10 (o mas), no deja entrar

    inc ebx                 ; entra un carro: contador + 1
    cmp ebx, CAPACIDAD      ; con este carro se lleno?
    je acabaDeLlenarse      ; si, avisa que se lleno
    jmp inicio              ; si no, regresa al menu

saleCarro:
    cmp ebx, 0              ; esta vacio?
    je estacionVacio        ; si no hay carros, no puede salir ninguno

    dec ebx                 ; sale un carro: contador - 1
    cmp ebx, 0              ; quedo vacio?
    je estacionVacio        ; si, avisa que esta vacio
    jmp inicio              ; si no, regresa al menu

acabaDeLlenarse:
    mov edx, OFFSET llenoAhora
    call WriteString
    call Crlf
    jmp inicio

estacionLleno:
    mov edx, OFFSET lleno   ; intento de entrar con el estacionamiento lleno
    call WriteString
    call Crlf
    jmp inicio

estacionVacio:
    mov edx, OFFSET vacio
    call WriteString
    call Crlf
    jmp inicio

fin:
    exit

main ENDP
END main
