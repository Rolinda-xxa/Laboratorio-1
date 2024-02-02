//******************************************************************************
//Universidad del Valle de GUatemala
//IE023: Programacion de Microcontroladores
//Autor: Astryd Rolinda Magaly Beb Caal
//Proyecto: Laboratorio 1
//Hardware: ATMEGA328P
//Created:

//*****************************************************************************
//Encabezado
//*****************************************************************************
.include "M328PDEF.inc" ; Incluir el archivo de definiciones para el microcontrolador ATmega328P

.cseg
.org 0x00 ; Establecer el inicio del código en la dirección de memoria 0x00

//*****************************************************************************
// Stack Pointer
//*****************************************************************************
LDI R16, LOW(RAMEND) ; Cargar el byte menos significativo de la dirección de final de RAM en R16
OUT SPL, R16 ; Establecer el Stack Pointer (SP) con el byte menos significativo de la dirección de final de RAM

LDI R17, HIGH(RAMEND) ; Cargar el byte más significativo de la dirección de final de RAM en R17
OUT SPH, R17 ; Establecer el Stack Pointer (SP) con el byte más significativo de la dirección de final de RAM

//*****************************************************************************
// Configuraciones
//*****************************************************************************
inicio:
    LDI R16, 0b1000_0000 ; Cargar el valor 0b10000000 en R16
    LDI R16, (1<< CLKPCE) ; Cargar el bit de cambio de reloj en el registro de control de reloj (CLKPCE)
    STS CLKPR, R16 ; Escribir el valor de R16 en el registro de control de reloj (CLKPR) - Habilita el prescaler

    LDI R16, 0B0000_0011 ; Cargar el valor 0b00000011 en R16
    STS CLKPR, R16 ; Escribir el valor de R16 en el registro de control de reloj (CLKPR) - Establecer un prescaler de 8fcpu = 2MHz 

    ; Configuración de puertos
    ; Entradas y pull-up
    LDI R16, (1<<PC3) | (1<<PC2) | (1<<PC1) | (1<<PC0) ; Configurar R16 con los bits PC0, PC1, PC2 y PC3 establecidos
    OUT DDRC, R16 ; Configurar PC0, PC1, PC2 y PC3 como entradas
    OUT PORTC, R16 ; Habilitar las resistencias pull-up en PC0, PC1, PC2 y PC3

    ; Salidas
    ldi R16, (1<<PC5) | (1<<PC4) | (1<<PB2) | (1<<PB1) | (1<<PB0) | (1<<PD7) | (1<<PD6) | (1<<PD5) | (1<<PD4) | (1<<PD3) | (1<<PD2) | (1<<PD0)
    out DDRC, R16 ; Configurar PC4 y PC5 como salidas
    out DDRB, R16 ; Configurar PB2, PB1 y PB0 como salidas
    out DDRD, R16 ; Configurar PD7, PD6, PD5, PD4, PD3, PD2 y PD0 como salidas

    LDI R17, 0 ; Inicializar R17 con 0
    
//*****************************************************************************
///inicio
//*****************************************************************************

MENU:
    IN R16, PINB ; Leer el estado de los pines de entrada de PORTB y almacenar en R16
    SBRS R16, PB5 ; Saltar si el bit 5 de PORTB está limpio (no se ha presionado el botón conectado a PB5)
    DELAYX1:
        LDI R16, 100 ; Cargar 100 en R16 (tiempo de retardo)
        DELAY1:
            DEC R16 ; Decrementar R16
            BRNE DELAY1 ; Saltar al etiquetado DELAY1 si R16 no es cero

    RJMP incremento ; Saltar a la etiqueta incremento
    RJMP MENU ; Volver al bucle MENU
//comparacion del valor del registro 17 
incremento:
	CPI R17, 0x00
	BREQ SALTO1
	CPI R17, 0x01
	RJMP SALTO2
	CPI R17, 0x02
	BREQ SALTO3
	CPI R17, 0x03
	RJMP SALTO4
	CPI R17, 0x04
	BREQ SALTO5
	CPI R17, 0x05
	RJMP SALTO6
	CPI R17, 0x06
	BREQ SALTO7
	CPI R17, 7
	RJMP SALTO8
	CPI R17, 8
	BREQ SALTO9
	CPI R17, 9
	RJMP SALTO10
	CPI R17, 10
	BREQ SALTO11
	CPI R17, 11
	RJMP SALTO12
	CPI R17, 12
	BREQ SALTO13
	CPI R17, 13
	RJMP SALTO14
	CPI R17, 14
	BREQ SALTO15
	CPI R17, 15
	RJMP MENU

	//dependiendo del valor este generará una salida distinta
	SALTO1:
		RJMP CAS1
	SALTO2:
		RJMP CAS2
	SALTO3:
		RJMP CAS3
	SALTO4:
		RJMP CAS4
	SALTO5:
		RJMP CAS5
	SALTO6:
		RJMP CAS6
	SALTO7:
		RJMP CAS7
	SALTO8:
		RJMP CAS8
	SALTO9:
		RJMP CAS9
	SALTO10:
		RJMP CAS10
	SALTO11:
		RJMP CAS11
	SALTO12:
		RJMP CAS12
	SALTO13:
		RJMP CAS13
	SALTO14:
		RJMP CAS14
	SALTO15:
		RJMP CAS15
	
//casos en los cuales se tendran el incremento en los leds
		

CAS0:
	IN  R16, PIND
	LDI R16, 0B0000_0000
	IN  R16, PINB
	LDI R16, 0B0000_00000
	OUT PORTD, R16
	OUT PORTB, R16
	INC R17 
	RJMP MENU
	
	
	

CAS1:
	IN  R16, PINB
	OUT PINB,R16
	LDI R16, 0B0000_0100
	OUT PORTB, R16
	
	INC R17            ; Incrementa el valor de r17 por el paso definido
	RJMP MENU

CAS2:
	IN  R16, PINB
	LDI R16, 0B0000_0010
	OUT PORTB, R16
	INC R17            ; Incrementa el valor de r17 por el paso definido
	RJMP MENU
CAS3:
	IN  R16, PINB
	LDI R16, 0B0000_0110
	OUT PORTB, R16
	INC R17            ; Incrementa el valor de r17 por el paso definido
	RJMP MENU
CAS4:
	IN  R16, PINB
	LDI R16, 0B0000_0001
	OUT PORTB, R16
	INC R17            ; Incrementa el valor de r17 por el paso definido
	RJMP MENU
CAS5:
	IN  R16, PINB
	LDI R16, 0B0000_0101
	OUT PORTB, R16
	INC R17            ; Incrementa el valor de r17 por el paso definido
	RJMP MENU
CAS6:
	IN  R16, PINB
	LDI R16, 0B0000_0011
	OUT PORTB, R16
	INC R17            ; Incrementa el valor de r17 por el paso definido
	RJMP MENU
CAS7:
	IN  R16, PINB
	LDI R16, 0B0000_0111
	OUT PORTB, R16  
	INC R17            ; Incrementa el valor de r17 por el paso definido
	RJMP MENU

CAS8:
	IN  R16, PIND
	LDI R16, 0B1000_0000
	OUT PORTD, R16
	LDI R16, 0B0000_0000
	OUT PORTB, R16  
	INC R17            ; Incrementa el valor de r17 por el paso definido
	RJMP MENU            ; Almacena el nuevo valor de la variable en su dirección de memoria

CAS9:
	IN  R16, PIND
	LDI R16, 0B1000_0000
	IN  R16, PINB
	LDI R16, 0B0000_0100
	OUT PORTD, R16
	OUT PORTB, R16
	LDI R16, 0B0000_0000
	OUT PORTB, R16
	OUT PORTD, R16 
	INC R17            ; Incrementa el valor de r17 por el paso definido
	RJMP MENU

CAS10:
	IN  R16, PIND
	LDI R16, 0B1000_0000
	IN  R16, PINB
	LDI R16, 0B0000_0010
	OUT PORTD, R16
	OUT PORTB, R16
	LDI R16, 0B0000_0000
	OUT PORTB, R16
	OUT PORTD, R16  
	INC R17            ; Incrementa el valor de r17 por el paso definido
	RJMP MENU

CAS11:
	IN  R16, PIND
	LDI R16, 0B1000_0000
	IN  R16, PINB
	LDI R16, 0B0000_0110
	OUT PIND, R16
	OUT PORTB, R16
	LDI R16, 0B0000_0000
	OUT PORTB, R16
	OUT PORTD, R16
	INC R17            ; Incrementa el valor de r17 por el paso definido
	RJMP MENU

CAS12:
	IN  R16, PIND
	LDI R16, 0B1000_0000
	IN  R16, PINB
	LDI R16, 0B0000_0001
	OUT PORTD, R16
	OUT PORTB, R16
	LDI R16, 0B0000_0000
	OUT PORTB, R16
	OUT PORTD, R16  
	INC R17            ; Incrementa el valor de r17 por el paso definido
	RJMP MENU

CAS13:
	IN  R16, PIND
	LDI R16, 0B1000_0000
	IN  R16, PINB
	LDI R16, 0B0000_0101
	OUT PORTD, R16
	OUT PORTB, R16
	LDI R16, 0B0000_0000
	OUT PORTB, R16
	OUT PORTD, R16 
	INC R17            ; Incrementa el valor de r17 por el paso definidA
	RJMP MENU

CAS14:
	IN  R16, PIND
	LDI R16, 0B1000_0000
	IN  R16, PINB
	LDI R16, 0B0000_0011
	OUT PORTD, R16
	OUT PORTB, R16
	LDI R16, 0B0000_0000
	OUT PORTB, R16
	OUT PORTD, R16 
	INC R17            ; Incrementa el valor de r17 por el paso definido
	RJMP MENU

CAS15:
	IN  R16, PIND
	LDI R16, 0B1000_0000
	IN  R16, PINB
	LDI R16, 0B0000_0111
	OUT PORTD, R16
	OUT PORTB, R16
	LDI R16, 0B0000_0000
	OUT PORTB, R16
	OUT PORTD, R16
	INC R17            ; Incrementa el valor de r17 por el paso definido
	RJMP MENU


	