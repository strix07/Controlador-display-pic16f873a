# Visualizador de 7 segmentos controlado por teclado de 12 teclas utilizando el pic16F873

 El presente apartado se enfocará en la realización de un programa en lenguaje ensamblador capaz de tomar los valores de numéricos de un teclado y mostrarlos en un display 7 segmentos, este programa se realizará para el PIC16F873A, posteriormente se realizará la simulación del circuito necesario para el programa y por último el armado y prueba del circuito real en el laboratorio.

## INSTRUCCIONES
 
  Se quiere hacer un circuito basado en un PIC 16F873A que tenga una entrada de un teclado de 12 teclas y una salida de 1 visualizador de 7 segmentos.

  El sistema comienza con el display apagado, al presionar una de las teclas con un número se presenta en el display y se muestra por aproximadamente un segundo, luego se apaga esperando que se presione otra tecla. Si se presiona alguna tecla durante el tiempo que el display muestra el número se ignorará. El tiempo en el cual se está mostrando el dígito se debe regular a través del timer TMR0.


![image](https://github.com/strix07/Controlador-display-pic16f873a/assets/142692042/44d5a5fa-d9a4-4f01-9407-29f94c4bbefd)



Figura 1.  Montaje del circuito 


## CIRCUITO SIMULADO

El circuito simulado es el que vemos en la figura de abajo:

![image](https://github.com/strix07/Controlador-display-pic16f873a/assets/142692042/8809500c-df66-4fbb-89b3-15f51796357b)


Figura 2.  Circuito diseñado - Imagen realizada con proteus

  Como vemos es exactamente el mismo esquema dado por el profesor con la diferencia que se simuló el teclado con pulsadores para hacer más didáctica la simulación. 

## TIMER0


 Antes de empezar el diseño del programa veremos aspectos generales para la configuración del timer0. El pic16F873A tiene dos maneras de trabajar con Timer0 como temporizador y como contador. Como temporizador se implementa por medio de un contador que determina un tiempo entre el valor deseado y el desbordamiento.
Presclaer

Es el divisor de frecuencia, el cual se encarga de aumentar la duración de los tiempos dividendo la frecuencia para prolongar las temporizaciones
OPTION_REG

Es el registro que se encarga de configurar la función del TMR0. En la librería del pic16f873a se define como OPTION_REG. Tiene 8 bits los cuales se configuran de la siguiente manera:

![image](https://github.com/strix07/Controlador-display-pic16f873a/assets/142692042/9cb6b1f0-afd3-421a-9ec4-1798131f8e82)



RBPU - PORTB Pull-up enable bit (resistencia Pull Up del puerto PORTB)
0 - Resistencias pull-up del puerto PORTB están deshabilitadas.
1 - Pines del puerto PORTB pueden estar conectados a las resistencias pull-up.

INTEDG - Interrupt Edge Select bit (bit selector de flanco activo de la interrupción externa)
0 - Interrupción por flanco ascendente en el pin INT (0-1).
1 - Interrupción por flanco descendente en el pin INT (1-0).

T0CS - TMR0 Clock Select bit (bit selector de tipo de reloj para el Timer0)
0 - Los pulsos se llevan a la entrada del temporizador/contador Timer0 por el pin RA4.
1 - El temporizador utiliza los pulsos de reloj internos (Fosc/4).

T0SE - TMR0 Source Edge Select bit (bit selector de tipo de flanco)
0 - Incrementa en flanco descendente en el pin TMR0.
1 - Incrementa en flanco ascendente en el pin TMR0.
PSA - Prescaler Assignment bit (bit de asignación del pre-escalador)
0 - Pre-escalador se le asigna al WDT.
1 - Pre-escalador se le asigna al temporizador/contador Timer0.

PS2, PS1, PS0 - Prescaler Rate Select bit (bit selector del valor del divisor de frecuencias)
  El valor del divisor de frecuencias se ajusta al combinar estos bits. Como se muestra en la tabla a la derecha, la misma combinación de bits proporciona los diferentes valores del divisor de frecuencias para el temporizador/contador y el temporizador perro guardián, respectivamente.

![image](https://github.com/strix07/Controlador-display-pic16f873a/assets/142692042/c7b39426-ccb0-4dfb-bf3e-4c4c384a0e81)


## INTCON

  Registro de 8 bits ubicado en el banco 0, por el momento sólo veremos un solo bit de este registro. El cual indica un desbordamiento en el timer0
  
TMR0IF Flag de interrupción del TMR0 
TMR0IF= 0 -> El TMR0 no se ha desbordado 
TMR0IF = 1 -> El TMR0 se ha desbordado (se borra por software)

## TMR0 como Temporizador

Para esto es necesario siempre calcular el tiempo de temporización: 

T = Tcm x Prescaler(256-TMR0)
T = Tiempo deseado
Tcm = Periodo de ciclo de máquina = 4 /Fosc
Prescaler = Rango de divisor de frecuencia
256 = número total de impulsos a contar en TMR0

  El tiempo máximo que se puede generar con el timer será:
  
T = (4/4M) x 256 (256-0)
T=65.5ms

  Despejando la ecuación anterior para calcular el timer0 para 50ms:
TMR0=256-((Tiempo x Fosc)/(4 x preescaler))

  Por lo cual si queremos que nuestro timer trabaje para 50ms:
  
TMR0=256-((50m x 4M)/(4 x 256))
TMR0=256-(195)=61

  Este último será el valor que colocaremos en el programa para realizar el temporizador.

DIAGRAMA DE FLUJO DEL PROGRAMA


![image](https://github.com/strix07/Controlador-display-pic16f873a/assets/142692042/d6d0c429-18a6-47a5-a793-ff3e29c5e5a8)


Video de la simulación del programa en proteus

https://drive.google.com/file/d/1wvG3vs9kd9k-xRlRICuhM9RMAcjKIaCn/view?usp=drive_web













