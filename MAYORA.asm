;===========================================================
; TECLADO
list p=16f873a 
include <p16f873a.inc> 
__CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_ON & _BOREN_ON & _LVP_OFF & _CPD_OFF & _WRT_OFF & _CP_OFF

;===========================================================
;Librerias 
		CBLOCK 0Ch
		endc 
;===========================================================
;Configuracion de puertos
	
	ORG 0
	BCF STATUS,RP1			;
	BSF STATUS,RP0			;coloco en 1 el bit RP0 (seleccion banco 1)
  	CLRF TRISB				;PUERTO B como salia
    MOVLW B'00001111'
    MOVWF PORTC				;mitad del puerto C entradas y mitad salidas
    CLRF PORTA
	MOVLW b'00000111'		;
	MOVWF OPTION_REG		;configuro el timer0
	BCF STATUS,RP0			;coloco en 0 el bit RP0 (seleccion banco 0)	
	MOVLW 0FFh
   	MOVWF PORTB				;apago el display

;===========================================================
;Programa principal
	
INICIO

		MOVLW 0FFh
   		MOVWF PORTC			;descelecciono todas la colunas y filas

		BCF		PORTC,4 	;coloca en bajo el pin B4 (escaneo culmna 1)
		BTFSS	PORTC,0 	;si el pin C0=0 envia el numero 0 de lo contrario salta fila siguiente
		GOTO	UNO
		BTFSS	PORTC,1 	;si el pin C1=0 envia el numero 2 de lo contrario salta fila siguiente
		GOTO	DOS
		BTFSS	PORTC,2		;si el pin C2=0 envia el numero 4 de lo contrario salta fila siguiente
		GOTO	TRES
		
		BSF		PORTC,4  	;coloco en alto el pin B4 
		BCF		PORTC,5  	;coloco en B5 el pin B4 (escaneo columna 2)
		BTFSS	PORTC,0		;repito lo mismo que en la columna 1 
		GOTO	CUATRO
		BTFSS	PORTC,1
		GOTO	CINCO
		BTFSS	PORTC,2
		GOTO	SEIS
	

		BSF		PORTC,5  
		BCF		PORTC,6
		BTFSS	PORTC,0
		GOTO	SIETE
		BTFSS	PORTC,1
		GOTO	OCHO
		BTFSS	PORTC,2
		GOTO	NUEVE
	
		BSF		PORTC,6
		BCF		PORTC,7
		BTFSS	PORTC,0
		GOTO	GUION
		BTFSS	PORTC,1
		GOTO	CERO
		BTFSS	PORTC,2
		GOTO	GUION
		BSF		PORTC,7
		GOTO	INICIO		;vuelvo a inicio

;===========================================================
;Subrutina a 7 segmentos 

CERO 	movlw B'11000000'	;
		movwf PORTB			;muestro codigo 7seg en el display
		call Retardo_2s		;creo un retardoo
		movlw 0FFh			;
		movwf PORTB			;apago el display
		goto ESPERAR		;vuelvo al inicio

UNO	 	movlw B'11111001'	;repito para el resito de casos
		movwf PORTB
		call Retardo_2s	
		movlw 0FFh
		movwf PORTB
		goto ESPERAR

DOS		movlw B'10100100'
		movwf PORTB
		call Retardo_2s
		movlw 0FFh
		movwf PORTB
		goto ESPERAR

TRES	movlw B'10110000'
		movwf PORTB
		call Retardo_2s
		movlw 0FFh
		movwf PORTB
		goto ESPERAR

CUATRO 	movlw B'10011001'
		movwf PORTB
		call Retardo_2s
		movlw 0FFh
		movwf PORTB
		goto ESPERAR

CINCO	movlw B'10010010'
		movwf PORTB
		call Retardo_2s
		movlw 0FFh
		movwf PORTB
		goto ESPERAR

SEIS	movlw B'10000010'
		movwf PORTB
		call Retardo_2s
		movlw 0FFh
		movwf PORTB
		goto ESPERAR

SIETE	movlw B'11111000'
		movwf PORTB
		call Retardo_2s
		movlw 0FFh
		movwf PORTB
		goto ESPERAR

OCHO	movlw B'00000000'
		movwf PORTB
		call Retardo_2s
		call Retardo_2s
		movlw 0FFh
		movwf PORTB
		goto ESPERAR

NUEVE	movlw B'00010000'
		movwf PORTB
		call Retardo_2s
		movlw 0FFh
		movwf PORTB
		goto ESPERAR

GUION 	movlw B'10111111'
		movwf PORTB
		call Retardo_2s
		movlw 0FFh
		movwf PORTB
		goto ESPERAR

;================================================================================
;Esta subrutina funciona para que si se deja precioad el boton de una tecla solo 
;se muestre 1 vez el digito en el teclado

ESPERAR
		movf PORTC,W
		andlw 07h
		sublw B'00000111'
		btfss STATUS,Z			;salta un espacio si el resultado no es 0
		goto ESPERAR			;
		call Retardo_2s			
		GOTO INICIO		

	include <RETARDOS.inc>

	END

