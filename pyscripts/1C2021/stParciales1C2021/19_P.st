!classDefinition: #CartaDeTrucoTest category: 'ISW1-2021-1C-2doParcial'!
TestCase subclass: #CartaDeTrucoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!CartaDeTrucoTest methodsFor: 'test - igualdad' stamp: 'HAW 7/4/2021 17:31:47'!
test01SonIgualesConMismoPaloYNumero

	self assert: (CartaDeTruco bastoCon: 1) = (CartaDeTruco bastoCon: 1) 

	! !

!CartaDeTrucoTest methodsFor: 'test - igualdad' stamp: 'HAW 7/4/2021 17:31:47'!
test02SonDistintasConDistintoPalo

	self deny: (CartaDeTruco bastoCon: 1) = (CartaDeTruco oroCon: 1) 

	! !

!CartaDeTrucoTest methodsFor: 'test - igualdad' stamp: 'HAW 7/4/2021 17:31:47'!
test03SonDistintasConNumeroAunqueIgualPalo

	self deny: (CartaDeTruco bastoCon: 1) = (CartaDeTruco bastoCon: 2) 

	! !

!CartaDeTrucoTest methodsFor: 'test - igualdad' stamp: 'HAW 7/4/2021 17:31:47'!
test04CartasIgualesTienenElMismoHash

	self assert: (CartaDeTruco bastoCon: 1) hash equals: (CartaDeTruco bastoCon: 1) hash

	! !

!CartaDeTrucoTest methodsFor: 'test - igualdad' stamp: 'HAW 7/4/2021 17:31:47'!
test05UnaCartaEsDistintaACualquierObjetoQueNoSeaCarta

	self deny: (CartaDeTruco bastoCon: 1) = 1! !


!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 7/5/2021 11:58:02'!
test07NoHayCartaDeTrucoConNumeroOcho

	self 
		should: [ CartaDeTruco oroCon: 8 ]
		raise: Error
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription! !

!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 7/5/2021 11:58:02'!
test08NoHayCartaDeTrucoConNumeroNueve

	self 
		should: [ CartaDeTruco oroCon: 9 ]
		raise: Error
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription! !

!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 7/5/2021 11:58:12'!
test09LosPalosDeLaCartaDeTrucoSonBastoOroEspadaYCopa

	self 
		should: [ CartaDeTruco palo: #otro numero: 1 ]
		raise: Error
		withMessageText: CartaDeTruco paloInvalidoErrorDescription! !

!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 7/5/2021 11:58:02'!
test10NoSePuedeCrearCartaConNumeroMenorAUno

	self 
		should: [ CartaDeTruco espadaCon: 0 ]
		raise: Error 
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription ! !

!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 7/5/2021 11:58:02'!
test11NoSePuedeCrearCartaConNumeroMayorADoce

	self 
		should: [ CartaDeTruco espadaCon: 13 ]
		raise: Error 
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription ! !

!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 7/5/2021 11:58:02'!
test12ElNumeroDeLaCartaDebeSerEntero

	self 
		should: [ CartaDeTruco espadaCon: 1.1 ]
		raise: Error 
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription ! !


!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/5/2021 10:55:30'!
test13LaTablaDeValoresEsCorrecta

	self assert: (CartaDeTruco anchoDeEspada mataA: CartaDeTruco anchoDeBasto).
	self assert: (CartaDeTruco anchoDeBasto mataA: CartaDeTruco sieteDeEspada).
	self assert: (CartaDeTruco sieteDeEspada mataA: CartaDeTruco sieteDeOro).
	self assert: (CartaDeTruco sieteDeOro mataA: (CartaDeTruco espadaCon: 3)).
	self assert: ((CartaDeTruco espadaCon: 3) empardaCon: (CartaDeTruco oroCon: 3)).
	self assert: ((CartaDeTruco espadaCon: 3) mataA: (CartaDeTruco espadaCon: 2)).
	self assert: ((CartaDeTruco espadaCon: 2) empardaCon: (CartaDeTruco oroCon: 2)).
	self assert: ((CartaDeTruco espadaCon: 2) mataA: (CartaDeTruco oroCon: 1)).
	self assert: ((CartaDeTruco oroCon: 1) empardaCon: (CartaDeTruco copaCon: 1)).
	self assert: ((CartaDeTruco oroCon: 1) mataA: (CartaDeTruco espadaCon: 12)).
	self assert: ((CartaDeTruco espadaCon: 12) empardaCon: (CartaDeTruco oroCon: 12)).
	self assert: ((CartaDeTruco espadaCon: 12) mataA: (CartaDeTruco espadaCon: 11)).
	self assert: ((CartaDeTruco espadaCon: 11) empardaCon: (CartaDeTruco oroCon: 11)).
	self assert: ((CartaDeTruco espadaCon: 11) mataA: (CartaDeTruco espadaCon: 10)).
	self assert: ((CartaDeTruco espadaCon: 10) empardaCon: (CartaDeTruco oroCon: 10)).
	self assert: ((CartaDeTruco espadaCon: 10) mataA: (CartaDeTruco copaCon: 7)).
	self assert: ((CartaDeTruco copaCon: 7) empardaCon: (CartaDeTruco bastoCon: 7)).
	self assert: ((CartaDeTruco copaCon: 7) mataA: (CartaDeTruco espadaCon: 6)).
	self assert: ((CartaDeTruco espadaCon: 6) empardaCon: (CartaDeTruco oroCon: 6)).
	self assert: ((CartaDeTruco espadaCon: 6) mataA: (CartaDeTruco espadaCon: 5)).
	self assert: ((CartaDeTruco espadaCon: 5) empardaCon: (CartaDeTruco oroCon: 5)).
	self assert: ((CartaDeTruco espadaCon: 5) mataA: (CartaDeTruco espadaCon: 4)).
	self assert: ((CartaDeTruco espadaCon: 4) empardaCon: (CartaDeTruco oroCon: 4)).

	{ 3. 2. 12. 11. 10. 6. 5. 4 } do: [ :unNumero |
		CartaDeTruco palos do: [ :unPalo | 
			self assert: ((CartaDeTruco espadaCon: unNumero) empardaCon: (CartaDeTruco palo: unPalo numero: unNumero)) ]]
	! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/5/2021 10:49:51'!
test14HayCartasQueNoSonPardas

	self deny: (CartaDeTruco anchoDeEspada empardaCon: CartaDeTruco anchoDeBasto)! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/5/2021 10:49:59'!
test15HayCartasQuePierdenConOtras

	self deny: (CartaDeTruco anchoDeBasto mataA: CartaDeTruco anchoDeEspada)! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/4/2021 17:53:21'!
test16SieteDeCopasYDeBastoEsSieteFalso

	self assert: (CartaDeTruco copaCon: 7) esSieteFalso.
	self assert: (CartaDeTruco bastoCon: 7) esSieteFalso ! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/4/2021 17:54:57'!
test17SieteDeOroYDeEspadaNoSonSieteFalso

	self deny: (CartaDeTruco sieteDeOro) esSieteFalso.
	self deny: (CartaDeTruco sieteDeEspada) esSieteFalso ! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/4/2021 17:55:53'!
test18AnchoDeOroYDeCopaSonAnchoFalsos

	self assert: (CartaDeTruco oroCon: 1) esAnchoFalso.
	self assert: (CartaDeTruco copaCon: 1) esAnchoFalso ! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/4/2021 17:56:28'!
test19AnchoDeEspadaYDeBastosNoSonAnchoFalsos

	self deny: (CartaDeTruco anchoDeEspada) esAnchoFalso.
	self deny: (CartaDeTruco anchoDeBasto) esAnchoFalso ! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/5/2021 11:58:24'!
test20FallaBuscandoValorDeCartaInválida

	"Creo una carta de manera inválida para probar la correctitud del la tabla de valores - Hernan"
	self 
		should: [ CartaDeTruco new initializePalo: #invalido numero: 1; valor ]
		raise: Error 
		withMessageText: CartaDeTruco tablaDeValoresIncorrectaOCartaInvalidaErrorDescription! !


!classDefinition: #JuegoDeTrucoTest category: 'ISW1-2021-1C-2doParcial'!
TestCase subclass: #JuegoDeTrucoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!JuegoDeTrucoTest methodsFor: 'testing' stamp: 'ms 7/5/2021 18:17:05'!
test01NoSePuedeCrearUnaRondaSinCartas
	
	|jugadorMano jugadorPie|
	
	jugadorMano := OrderedCollection new.
	jugadorPie := OrderedCollection new.
	
	self should: [Ronda crearCon: jugadorMano y: jugadorPie.]
	raise: Error - MessageNotUnderstood
	withExceptionDo:[:anError |
		self assert: Ronda noSePuedeCrearUnaRondaSinCartas equals: anError messageText .
		]! !

!JuegoDeTrucoTest methodsFor: 'testing' stamp: 'ms 7/5/2021 19:46:42'!
test02NoSePuedeCrearUnaRondaSinQueCadaJugadorTengaExactamente3Cartas
	
	|jugadorMano jugadorPie|
	
	jugadorMano := OrderedCollection new 
		add: (CartaDeTruco bastoCon: 1); yourself.
	
	jugadorPie := OrderedCollection new 
		add: (CartaDeTruco bastoCon: 2);
		add: (CartaDeTruco espadaCon: 3); 
		add: (CartaDeTruco copaCon: 1);
		add: (CartaDeTruco oroCon: 5); yourself.
	
	self should: [Ronda crearCon: jugadorMano y: jugadorPie.]
	raise: Error - MessageNotUnderstood
	withExceptionDo:[:anError |
		self assert: Ronda noSePuedeCrearUnaRondaSinQueCadaJugadorTengaExactamente3Cartas equals: anError messageText .
		]! !

!JuegoDeTrucoTest methodsFor: 'testing' stamp: 'ms 7/5/2021 19:46:33'!
test03ValidarQueLasCartasNoSeRepitanEnUnMismoJugador
	
	|jugadorMano jugadorPie |
	
	jugadorMano := OrderedCollection new 
		add: (CartaDeTruco bastoCon: 1); 
		add: (CartaDeTruco bastoCon: 1);
		add: (CartaDeTruco oroCon: 2); yourself.
		
	jugadorPie := OrderedCollection new 
		add: (CartaDeTruco bastoCon: 6); 
		add: (CartaDeTruco espadaCon: 3);
		add: (CartaDeTruco oroCon: 5); yourself.
	
	self should: [Ronda crearCon: jugadorMano y: jugadorPie.]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError |
		self assert: Ronda noSePuedeCrearUnaRondaConCartasRepetidas equals: anError messageText .
			]
	! !

!JuegoDeTrucoTest methodsFor: 'testing' stamp: 'ms 7/5/2021 20:11:19'!
test04NoSePuedeTirarUnaCartaQuePertenezcaAlJugadorQueLaTirp
	
	|jugadorMano jugadorPie ronda |
	
	jugadorMano := OrderedCollection new 
		add: (CartaDeTruco bastoCon: 1); 
		add: (CartaDeTruco bastoCon: 2);
		add: (CartaDeTruco oroCon: 2); yourself.
		
	jugadorPie := OrderedCollection new 
		add: (CartaDeTruco bastoCon: 6); 
		add: (CartaDeTruco espadaCon: 3);
		add: (CartaDeTruco oroCon: 5); yourself.
	
	ronda := Ronda crearCon: jugadorMano y: jugadorPie.
	
	
	
	self should: [ronda juegaJugadorManoYTira: (CartaDeTruco espadaCon: 1 ) ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError |
		self assert: Ronda noSePuedeTirarUnaCartaQueNoPertenezcaAlJugador equals: anError messageText .
			]
	! !

!JuegoDeTrucoTest methodsFor: 'testing' stamp: 'ms 7/5/2021 20:11:35'!
test05NoPuedeTirarUnaCartaQuePertenezcaAlJugadorPie
	
	|jugadorMano jugadorPie ronda |
	
	jugadorMano := OrderedCollection new 
		add: (CartaDeTruco bastoCon: 1); 
		add: (CartaDeTruco bastoCon: 2);
		add: (CartaDeTruco oroCon: 2); yourself.
		
	jugadorPie := OrderedCollection new 
		add: (CartaDeTruco bastoCon: 6); 
		add: (CartaDeTruco espadaCon: 3);
		add: (CartaDeTruco oroCon: 5); yourself.
	
	ronda := Ronda crearCon: jugadorMano y: jugadorPie.
	
	
	
	self should: [ronda juegaJugadorPieYTira: (CartaDeTruco espadaCon: 1 ) ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError |
		self assert: Ronda noSePuedeTirarUnaCartaQueNoPertenezcaAlJugador equals: anError messageText .
			]
	! !

!JuegoDeTrucoTest methodsFor: 'testing' stamp: 'ms 7/5/2021 19:58:54'!
test06NoPuedeEmpezarAJugarElJugadorPie
	
	|jugadorMano jugadorPie ronda |
	
	jugadorMano := OrderedCollection new 
		add: (CartaDeTruco bastoCon: 1); 
		add: (CartaDeTruco bastoCon: 2);
		add: (CartaDeTruco oroCon: 2); yourself.
		
	jugadorPie := OrderedCollection new 
		add: (CartaDeTruco bastoCon: 6); 
		add: (CartaDeTruco espadaCon: 3);
		add: (CartaDeTruco oroCon: 5); yourself.
	
	ronda := Ronda crearCon: jugadorMano y: jugadorPie.
	
	self should: [ronda juegaJugadorPieYTira: (CartaDeTruco bastoCon: 6 ).]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError |
		self assert: Ronda noPuedeEmpezarAJugarElJugadorPieEnElEnfrentamiento1 equals: anError messageText .
			].
	
	! !

!JuegoDeTrucoTest methodsFor: 'testing' stamp: 'ms 7/5/2021 20:35:42'!
test07GanaLaManoEnElPrimerEnfrentamiento
	
	|jugadorMano jugadorPie ronda |
	
	jugadorMano := OrderedCollection new 
		add: (CartaDeTruco bastoCon: 1); 
		add: (CartaDeTruco bastoCon: 2);
		add: (CartaDeTruco oroCon: 2); yourself.
		
	jugadorPie := OrderedCollection new 
		add: (CartaDeTruco bastoCon: 6); 
		add: (CartaDeTruco espadaCon: 3);
		add: (CartaDeTruco oroCon: 5); yourself.
	
	ronda := Ronda crearCon: jugadorMano y: jugadorPie.
	ronda juegaJugadorManoYTira: (CartaDeTruco bastoCon: 1).
	ronda juegaJugadorPieYTira: (CartaDeTruco bastoCon: 6 ).
			
	self assert: (ronda ganoEnElEnfrentamiento: 1) equals: jugadorMano ."ojo con los nombres y poner quien sigue despues"
	self assert: (ronda cartasDelJugadorMano) equals: {CartaDeTruco bastoCon: 2. CartaDeTruco oroCon: 2} asOrderedCollection .
	self assert: (ronda cartasDelJugadorPie) equals: {CartaDeTruco espadaCon: 3. CartaDeTruco oroCon: 5. }asOrderedCollection.
	
	! !

!JuegoDeTrucoTest methodsFor: 'testing' stamp: 'ms 7/5/2021 21:01:06'!
test08SiGanaLaManoEnElPrimerEnfrentamientoNoDebeEmpezarElPie
	
	|jugadorMano jugadorPie ronda |
	
	jugadorMano := OrderedCollection new 
		add: (CartaDeTruco bastoCon: 1); 
		add: (CartaDeTruco bastoCon: 2);
		add: (CartaDeTruco oroCon: 2); yourself.
		
	jugadorPie := OrderedCollection new 
		add: (CartaDeTruco bastoCon: 6); 
		add: (CartaDeTruco espadaCon: 3);
		add: (CartaDeTruco oroCon: 5); yourself.
	
	ronda := Ronda crearCon: jugadorMano y: jugadorPie.
	ronda juegaJugadorManoYTira: (CartaDeTruco bastoCon: 1).
	ronda juegaJugadorPieYTira: (CartaDeTruco bastoCon: 6 ).
	ronda ganoEnElEnfrentamiento: 1.
	
	self should: [ronda juegaJugadorPieYTira: (CartaDeTruco espadaCon: 3 ).]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError |
		self assert: Ronda noDebeEmpezarAJugarElJugadorPiePuesPerdioElAnteriorEnfrentamiento equals: anError messageText .
		self assert: (ronda cartasDelJugadorPie) equals: {CartaDeTruco espadaCon: 3. CartaDeTruco oroCon: 5. }asOrderedCollection.
			].
	
	
	! !

!JuegoDeTrucoTest methodsFor: 'testing' stamp: 'ms 7/5/2021 21:14:23'!
test09NoDebeEmpezarLaManoEnElSegundoEnfrentamientoSiGanaElPieEnElPrimerEnfrentamiento
	
	|jugadorMano jugadorPie ronda |
	
	jugadorMano := OrderedCollection new 
		add: (CartaDeTruco bastoCon: 1); 
		add: (CartaDeTruco bastoCon: 2);
		add: (CartaDeTruco oroCon: 2); yourself.
		
	jugadorPie := OrderedCollection new 
		add: (CartaDeTruco bastoCon: 6); 
		add: (CartaDeTruco espadaCon: 1);
		add: (CartaDeTruco oroCon: 5); yourself.
	
	ronda := Ronda crearCon: jugadorMano y: jugadorPie.
	ronda juegaJugadorManoYTira: (CartaDeTruco bastoCon: 1).
	ronda juegaJugadorPieYTira: (CartaDeTruco espadaCon: 1).
	ronda ganoEnElEnfrentamiento: 1.
		
	self should: [ronda juegaJugadorManoYTira: (CartaDeTruco bastoCon: 2).]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError |
		self assert: Ronda noDebeEmpezarAJugarElJugadorManoPuesPerdioElAnteriorEnfrentamiento equals: anError messageText .
		self assert: (ronda cartasDelJugadorMano) equals: {CartaDeTruco bastoCon: 2. CartaDeTruco oroCon: 2. }asOrderedCollection.
			].
	
	
	! !

!JuegoDeTrucoTest methodsFor: 'testing' stamp: 'ms 7/5/2021 21:14:07'!
test10GanaLaManoEnElSegundoEnfrentamientoYNoDebeEpezarElPieEnElTercero
	
	|jugadorMano jugadorPie ronda |
	
	jugadorMano := OrderedCollection new 
		add: (CartaDeTruco bastoCon: 1); 
		add: (CartaDeTruco bastoCon: 2);
		add: (CartaDeTruco espadaCon: 1); yourself.
		
	jugadorPie := OrderedCollection new 
		add: (CartaDeTruco bastoCon: 6); 
		add: (CartaDeTruco espadaCon: 3);
		add: (CartaDeTruco oroCon: 5); yourself.
	
	ronda := Ronda crearCon: jugadorMano y: jugadorPie.
	ronda juegaJugadorManoYTira: (CartaDeTruco bastoCon: 1).
	ronda juegaJugadorPieYTira: (CartaDeTruco bastoCon: 6).
	ronda ganoEnElEnfrentamiento: 1.
	
	ronda juegaJugadorManoYTira: (CartaDeTruco espadaCon: 1).
	ronda juegaJugadorPieYTira: (CartaDeTruco oroCon: 5).
	ronda ganoEnElEnfrentamiento: 2.
		
	self should: [ronda juegaJugadorPieYTira: (CartaDeTruco espadaCon: 3).]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError |
		self assert: Ronda noDebeEmpezarAJugarElJugadorPiePuesPerdioElAnteriorEnfrentamiento equals: anError messageText .
		self assert: (ronda cartasDelJugadorPie) equals: {CartaDeTruco espadaCon: 3 }asOrderedCollection.
			].
	
	
	! !

!JuegoDeTrucoTest methodsFor: 'testing' stamp: 'ms 7/5/2021 21:17:59'!
test11GanaElPieEnElSegundoEnfrentamientoYNoDebeEpezarLaManoEnElTercero
	
	|jugadorMano jugadorPie ronda |
	
	jugadorMano := OrderedCollection new 
		add: (CartaDeTruco bastoCon: 1); 
		add: (CartaDeTruco espadaCon: 6);
		add: (CartaDeTruco espadaCon: 1); yourself.
		
	jugadorPie := OrderedCollection new 
		add: (CartaDeTruco bastoCon: 6); 
		add: (CartaDeTruco espadaCon: 3);
		add: (CartaDeTruco oroCon: 1); yourself.
	
	ronda := Ronda crearCon: jugadorMano y: jugadorPie.
	ronda juegaJugadorManoYTira: (CartaDeTruco bastoCon: 1).
	ronda juegaJugadorPieYTira: (CartaDeTruco bastoCon: 6).
	ronda ganoEnElEnfrentamiento: 1.
	
	ronda juegaJugadorManoYTira: (CartaDeTruco espadaCon: 6).
	ronda juegaJugadorPieYTira: (CartaDeTruco oroCon:1).
	ronda ganoEnElEnfrentamiento: 2.
		
	self should: [ronda juegaJugadorManoYTira: (CartaDeTruco espadaCon: 1).]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError |
		self assert: Ronda noDebeEmpezarAJugarElJugadorManoPuesPerdioElAnteriorEnfrentamiento equals: anError messageText .
		self assert: (ronda cartasDelJugadorMano) equals: {CartaDeTruco espadaCon: 1 }asOrderedCollection.
			].
	
	
	! !

!JuegoDeTrucoTest methodsFor: 'testing' stamp: 'ms 7/5/2021 21:28:46'!
test12GanaLaManoLaRonda
	
	|jugadorMano jugadorPie ronda |
	
	jugadorMano := OrderedCollection new 
		add: (CartaDeTruco bastoCon: 1); 
		add: (CartaDeTruco espadaCon: 6);
		add: (CartaDeTruco espadaCon: 1); yourself.
		
	jugadorPie := OrderedCollection new 
		add: (CartaDeTruco bastoCon: 6); 
		add: (CartaDeTruco espadaCon: 3);
		add: (CartaDeTruco oroCon: 1); yourself.
	
	ronda := Ronda crearCon: jugadorMano y: jugadorPie.
	ronda juegaJugadorManoYTira: (CartaDeTruco bastoCon: 1).
	ronda juegaJugadorPieYTira: (CartaDeTruco bastoCon: 6).
	ronda ganoEnElEnfrentamiento: 1.
	
	ronda juegaJugadorManoYTira: (CartaDeTruco espadaCon: 6).
	ronda juegaJugadorPieYTira: (CartaDeTruco oroCon:1).
	ronda ganoEnElEnfrentamiento: 2.
	
	ronda juegaJugadorPieYTira: (CartaDeTruco espadaCon: 3).
	ronda juegaJugadorManoYTira: (CartaDeTruco espadaCon: 1).
	ronda ganoEnElEnfrentamiento: 3.
		
	self assert: (ronda ganadorDeLaRonda) equals: jugadorMano .
	self assert: (ronda cartasDelJugadorMano) isEmpty .
	self assert: (ronda cartasDelJugadorPie) isEmpty 
	
	
	! !

!JuegoDeTrucoTest methodsFor: 'testing' stamp: 'ms 7/5/2021 21:38:30'!
test13EmpardaLaManoNoHayGanador

	|jugadorMano jugadorPie ronda |
	
	jugadorMano := OrderedCollection new 
		add: (CartaDeTruco bastoCon: 1); 
		add: (CartaDeTruco oroCon: 3);
		add: (CartaDeTruco espadaCon: 1); yourself.
		
	jugadorPie := OrderedCollection new 
		add: (CartaDeTruco bastoCon: 6); 
		add: (CartaDeTruco espadaCon: 3);
		add: (CartaDeTruco oroCon: 1); yourself.
	
	ronda := Ronda crearCon: jugadorMano y: jugadorPie.
	ronda juegaJugadorManoYTira: (CartaDeTruco bastoCon: 1).
	ronda juegaJugadorPieYTira: (CartaDeTruco bastoCon: 6).
	ronda ganoEnElEnfrentamiento: 1.
	
	ronda juegaJugadorManoYTira: (CartaDeTruco oroCon: 3).
	ronda juegaJugadorPieYTira: (CartaDeTruco espadaCon:3).
	.
		
	self assert: (ronda ganoEnElEnfrentamiento: 2)  isEmpty .
	self assert: (ronda cartasDelJugadorMano) equals:{(CartaDeTruco espadaCon: 1)} asOrderedCollection .
	self assert: (ronda cartasDelJugadorPie) equals: {(CartaDeTruco oroCon: 1)} asOrderedCollection  
	
	
	! !

!JuegoDeTrucoTest methodsFor: 'testing' stamp: 'ms 7/5/2021 21:47:07'!
test14EmpardaLaPrimerManoGanaLaRondaElGanadorDelSegundaEnfrentamiento

	"|jugadorMano jugadorPie ronda |
	
	jugadorMano := OrderedCollection new 
		add: (CartaDeTruco bastoCon: 1); 
		add: (CartaDeTruco oroCon: 3);
		add: (CartaDeTruco espadaCon: 1); yourself.
		
	jugadorPie := OrderedCollection new 
		add: (CartaDeTruco bastoCon: 6); 
		add: (CartaDeTruco espadaCon: 3);
		add: (CartaDeTruco oroCon: 1); yourself.
	
	ronda := Ronda crearCon: jugadorMano y: jugadorPie.
	ronda juegaJugadorManoYTira: (CartaDeTruco oroCon: 3).
	ronda juegaJugadorPieYTira: (CartaDeTruco espadaCon:3).
	ronda ganoEnElEnfrentamiento: 1.
	
	ronda juegaJugadorManoYTira: (CartaDeTruco bastoCon: 1).
	ronda juegaJugadorPieYTira: (CartaDeTruco bastoCon: 6).
		
	self assert: (ronda ganadorDeLaRonda ) equals: jugadorMano .
	self assert: (ronda cartasDelJugadorMano) equals:{(CartaDeTruco espadaCon: 1)} asOrderedCollection .
	self assert: (ronda cartasDelJugadorPie) equals: {(CartaDeTruco oroCon: 1)} asOrderedCollection  
	
	NO LLEGUE A HACER ESTE TEST POR EL TIEMPO"
	
	
	! !


!classDefinition: #CartaDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #CartaDeTruco
	instanceVariableNames: 'palo numero'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!CartaDeTruco methodsFor: 'initialization' stamp: 'HAW 7/3/2021 15:27:51'!
initializePalo: unPalo numero: unNumero 
	
	palo := unPalo.
	numero := unNumero.! !


!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 7/2/2021 11:44:36'!
= unaCarta 
	
	^(unaCarta isKindOf: self class) and: [(unaCarta paloEs: palo) and: [ unaCarta numeroEs: numero ]]! !

!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 7/5/2021 10:49:51'!
empardaCon: cartaParda

	^self valor = cartaParda valor! !

!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 7/2/2021 11:43:24'!
hash
	
	^palo hash bitXor: numero hash ! !

!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 7/5/2021 10:49:59'!
mataA: cartaPerdedora

	^self valor < cartaPerdedora valor! !

!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 7/2/2021 11:41:53'!
numeroEs: unNumero

	^numero = unNumero ! !

!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 7/2/2021 11:41:39'!
paloEs: unPalo

	^palo = unPalo ! !


!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/4/2021 17:50:20'!
esAncho

	^ self numeroEs: 1! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/4/2021 17:50:31'!
esAnchoDeBasto
	
	^self esAncho and: [ self esDeBasto ]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/4/2021 17:50:41'!
esAnchoDeEspada
	
	^self esAncho and: [ self esDeEspada ]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/4/2021 17:50:20'!
esAnchoFalso
	
	^self esAncho and: [ self esDeOro or: [ self esDeCopa ]]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:19:32'!
esCaballo
	
	^self numeroEs: 11! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:25:29'!
esDeBasto
	
	^self paloEs: self basto! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:26:09'!
esDeCopa
	
	^self paloEs: self copa! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:26:18'!
esDeEspada
	
	^self paloEs: self espada ! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:26:35'!
esDeOro
	
	^self paloEs: self oro! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:19:22'!
esRey
	
	^self numeroEs: 12! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:16:57'!
esSiete
	
	^self numeroEs: 7! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:27:00'!
esSieteDeEspadas
	
	^self esSiete and: [ self esDeEspada ]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:27:15'!
esSieteDeOro
	
	^self esSiete and: [ self esDeOro ]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:26:09'!
esSieteFalso
	
	^self esSiete and: [ self esDeCopa or: [ self esDeBasto ]]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:19:43'!
esSota
	
	^self numeroEs: 10! !


!CartaDeTruco methodsFor: 'printing' stamp: 'HAW 7/3/2021 15:14:43'!
printOn: aStream

	aStream 
		print: numero;
		nextPutAll: ' de ';
		nextPutAll: 	palo ! !


!CartaDeTruco methodsFor: 'valor' stamp: 'HAW 7/3/2021 14:51:09'!
valor
	
	^self class valorDe: self! !


!CartaDeTruco methodsFor: 'palos' stamp: 'HAW 7/3/2021 15:24:33'!
basto
	
	^self class basto! !

!CartaDeTruco methodsFor: 'palos' stamp: 'HAW 7/3/2021 15:24:44'!
copa

	^ self class copa! !

!CartaDeTruco methodsFor: 'palos' stamp: 'HAW 7/3/2021 15:24:08'!
espada
	
	^self class espada! !

!CartaDeTruco methodsFor: 'palos' stamp: 'HAW 7/3/2021 15:26:27'!
oro

	^ self class oro! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartaDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
CartaDeTruco class
	instanceVariableNames: 'ordenDePrioridad'!

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/4/2021 17:49:37'!
anchoDeBasto
	
	^self bastoCon: 1! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/4/2021 17:49:57'!
anchoDeEspada
	
	^self espadaCon: 1! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/3/2021 14:57:03'!
bastoCon: unNumero

	^self palo: self basto numero: unNumero! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/3/2021 14:57:08'!
copaCon: unNumero

	^self palo: self copa numero: unNumero! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/3/2021 14:57:16'!
espadaCon: unNumero

	^self palo: self espada numero: unNumero ! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/3/2021 14:57:34'!
oroCon: unNumero

	^self palo: self oro numero: unNumero ! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/4/2021 18:06:08'!
palo: unPalo numero: unNumero 
	
	self assertNúmeroEsVálido: unNumero.
	self assertPaloEsVálido: unPalo.
	
	^self new initializePalo: unPalo numero: unNumero ! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/3/2021 15:12:50'!
sieteDeEspada
	
	^self espadaCon: 7! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/3/2021 15:17:44'!
sieteDeOro
	
	^self oroCon: 7! !


!CartaDeTruco class methodsFor: 'palos' stamp: 'HAW 7/3/2021 14:56:25'!
basto
	
	^#basto! !

!CartaDeTruco class methodsFor: 'palos' stamp: 'HAW 7/3/2021 14:57:25'!
copa
	
	^#copa! !

!CartaDeTruco class methodsFor: 'palos' stamp: 'HAW 7/3/2021 14:55:44'!
espada
	
	^#espada! !

!CartaDeTruco class methodsFor: 'palos' stamp: 'HAW 7/3/2021 14:57:43'!
oro
	
	^#oro! !

!CartaDeTruco class methodsFor: 'palos' stamp: 'HAW 7/4/2021 18:07:36'!
palos

	"No se puede acceder a self en backtick, por eso se usa CartaDeTruco como receiver - Hernan"
	^ `{CartaDeTruco espada. CartaDeTruco basto. CartaDeTruco oro. CartaDeTruco copa }`! !


!CartaDeTruco class methodsFor: 'initialization' stamp: 'HAW 7/5/2021 10:52:07'!
initializeOrdenDePrioridad
	
	"Cuanto más chico sea el índice de la carta en esta colección, más valor tiene - Hernan"
	ordenDePrioridad := OrderedCollection new.
	
	ordenDePrioridad 
		add: [ :carta | carta esAnchoDeEspada ];
		add: [ :carta | carta esAnchoDeBasto ];
		add: [ :carta | carta esSieteDeEspadas ];
		add: [ :carta | carta esSieteDeOro ];
		add: [ :carta | carta numeroEs: 3 ];
		add: [ :carta | carta numeroEs: 2 ];
		add: [ :carta | carta esAnchoFalso ];
		add: [ :carta | carta esRey ];
		add: [ :carta | carta esCaballo ];
		add: [ :carta | carta esSota ];
		add: [ :carta | carta esSieteFalso ];
		add: [ :carta | carta numeroEs: 6 ];
		add: [ :carta | carta numeroEs: 5 ];
		add: [ :carta | carta numeroEs: 4 ];
		yourself.
	
	! !


!CartaDeTruco class methodsFor: 'valor' stamp: 'HAW 7/3/2021 14:54:01'!
ordenDePrioridad
	
	^ordenDePrioridad ifNil: [ self initializeOrdenDePrioridad ] ! !

!CartaDeTruco class methodsFor: 'valor' stamp: 'HAW 7/5/2021 11:58:24'!
valorDe: unaCarta 
	
	self ordenDePrioridad withIndexDo: [ :bloqueDeVerificacion :index |
		(bloqueDeVerificacion value: unaCarta) ifTrue: [ ^index ]].
	
	self error: self tablaDeValoresIncorrectaOCartaInvalidaErrorDescription! !


!CartaDeTruco class methodsFor: 'error descriptions' stamp: 'HAW 7/5/2021 11:58:02'!
numeroDeCartaInvalidoErrorDescription
	
	^'El truco no se puede jugar con ochos ni con nueves'! !

!CartaDeTruco class methodsFor: 'error descriptions' stamp: 'HAW 7/5/2021 11:58:12'!
paloInvalidoErrorDescription
	
	^'Los palos de la carta solo pueden ser espada, basto, oro y copa'! !

!CartaDeTruco class methodsFor: 'error descriptions' stamp: 'HAW 7/5/2021 11:58:24'!
tablaDeValoresIncorrectaOCartaInvalidaErrorDescription
	
	^'Error de programación: Tabla de valores incorrecta o carta inválida'! !


!CartaDeTruco class methodsFor: 'assertions' stamp: 'HAW 7/5/2021 11:58:02'!
assertNúmeroEsVálido: unNumero

	unNumero < 1 ifTrue: [ self error: self numeroDeCartaInvalidoErrorDescription ].
	unNumero > 12 ifTrue: [ self error: self numeroDeCartaInvalidoErrorDescription ].
	(unNumero between: 8 and: 9) ifTrue: [ self error: self numeroDeCartaInvalidoErrorDescription ].
	unNumero isInteger ifFalse: [ self error: self numeroDeCartaInvalidoErrorDescription ]! !

!CartaDeTruco class methodsFor: 'assertions' stamp: 'HAW 7/5/2021 11:58:12'!
assertPaloEsVálido: unPalo

	^ (self palos includes: unPalo) ifFalse: [ self error: self paloInvalidoErrorDescription ]! !


!classDefinition: #Ronda category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #Ronda
	instanceVariableNames: 'jugadorMano jugadorPie cartasJugadasDelJugadorMano cartasJugadasDelJugadorPie elUltimoGanador enfrentamientos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Ronda methodsFor: 'cartas de los jugadores' stamp: 'ms 7/5/2021 20:17:14'!
cartasDelJugadorMano

	^jugadorMano 

	! !

!Ronda methodsFor: 'cartas de los jugadores' stamp: 'ms 7/5/2021 20:17:22'!
cartasDelJugadorPie

	^jugadorPie 

	! !


!Ronda methodsFor: 'intancializacion' stamp: 'ms 7/5/2021 21:26:08'!
iniciarRondaConUn: cartasJugadorMano yUn: cartasJugadorPie
 
	self validarCartasDelJugador: cartasJugadorMano .
	self validarCartasDelJugador: cartasJugadorPie .
	
	self validarQueNoHayCartasRepetidasEn: (cartasJugadorMano asSet addAll: cartasJugadorPie; yourself).
	
	jugadorMano := cartasJugadorMano .
	jugadorPie := cartasJugadorPie .
	cartasJugadasDelJugadorMano := OrderedCollection new.
	cartasJugadasDelJugadorPie := OrderedCollection new.
	elUltimoGanador := jugadorMano.
	enfrentamientos := Bag new.! !


!Ronda methodsFor: 'validaciones' stamp: 'ms 7/5/2021 19:46:42'!
validarCartasDelJugador: lasCartasDelJugador
 	
	(lasCartasDelJugador isEmpty) ifTrue: [^Error signal: self class noSePuedeCrearUnaRondaSinCartas].	
	
	(lasCartasDelJugador size ~= 3) ifTrue: [^Error signal: self class noSePuedeCrearUnaRondaSinQueCadaJugadorTengaExactamente3Cartas].
	! !

!Ronda methodsFor: 'validaciones' stamp: 'ms 7/5/2021 19:46:33'!
validarQueNoHayCartasRepetidasEn: lasCartasEnJuego
 	

	(lasCartasEnJuego size = 6) ifFalse: [^Error signal: self class noSePuedeCrearUnaRondaConCartasRepetidas].! !


!Ronda methodsFor: 'ganador del enfrentamiento' stamp: 'ms 7/5/2021 21:46:42'!
ganoEnElEnfrentamiento: numeroDeEnfrentamiento
|cartaJugadorMano cartaJugadorPie|

	cartaJugadorMano := cartasJugadasDelJugadorMano at: numeroDeEnfrentamiento.
	cartaJugadorPie := cartasJugadasDelJugadorPie at: numeroDeEnfrentamiento.
	
	(cartaJugadorMano mataA: cartaJugadorPie) 
	ifTrue: [
		elUltimoGanador := jugadorMano.
		   enfrentamientos add: elUltimoGanador.]
	ifFalse: [
		(cartaJugadorPie empardaCon: cartaJugadorMano)
		ifTrue: [
			   elUltimoGanador := jugadorMano.
			   ^OrderedCollection new]
		ifFalse:[elUltimoGanador := jugadorPie .
			  enfrentamientos add: elUltimoGanador.]
		].
	
	^elUltimoGanador! !


!Ronda methodsFor: 'ganador de la ronda' stamp: 'ms 7/5/2021 21:28:01'!
ganadorDeLaRonda

	((enfrentamientos occurrencesOf: jugadorMano) > (enfrentamientos occurrencesOf: jugadorPie))
	ifTrue: [^jugadorMano ]
	ifFalse:[^jugadorPie ]! !


!Ronda methodsFor: 'tirar cartas' stamp: 'ms 7/5/2021 21:50:42'!
juegaJugadorManoYTira: unaCarta 
	
	(jugadorMano includes: unaCarta) ifFalse: [^Error signal: self class noSePuedeTirarUnaCartaQueNoPertenezcaAlJugador].
	
	(jugadorMano size < jugadorPie size) ifTrue: [^Error signal: self class noDebeEmpezarAJugarElJugadorManoPuesPerdioElAnteriorEnfrentamiento].
	
	(jugadorPie size = jugadorMano size) ifTrue:
		 [(elUltimoGanador isNotEqualTo: jugadorMano) ifTrue: [^Error signal: self class noDebeEmpezarAJugarElJugadorManoPuesPerdioElAnteriorEnfrentamiento]].
		
	cartasJugadasDelJugadorMano add: unaCarta.
	
	jugadorMano remove: unaCarta ifAbsent: [Error signal: self class noPuedeRemoverUnaCartaQueNoTengaElJugador].
	
	! !

!Ronda methodsFor: 'tirar cartas' stamp: 'ms 7/5/2021 21:35:04'!
juegaJugadorPieYTira: unaCarta 
	
	(jugadorPie includes: unaCarta) ifFalse: [^Error signal: self class noSePuedeTirarUnaCartaQueNoPertenezcaAlJugador]. 
	
	cartasJugadasDelJugadorMano isEmpty ifTrue: [^Error signal: self class noPuedeEmpezarAJugarElJugadorPieEnElEnfrentamiento1].
	
	(jugadorPie size < jugadorMano size) ifTrue: [^Error signal: self class noDebeEmpezarAJugarElJugadorPiePuesPerdioElAnteriorEnfrentamiento].
	
	(jugadorPie size = jugadorMano size) ifTrue:
		 [(elUltimoGanador isNotEqualTo: jugadorPie) ifTrue: [^Error signal: self class noDebeEmpezarAJugarElJugadorPiePuesPerdioElAnteriorEnfrentamiento]].
	
	cartasJugadasDelJugadorPie add: unaCarta.
	jugadorPie remove: unaCarta ifAbsent: [^Error signal: self class noPuedeRemoverUnaCartaQueNoTengaElJugador]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ronda class' category: 'ISW1-2021-1C-2doParcial'!
Ronda class
	instanceVariableNames: ''!

!Ronda class methodsFor: 'creacion de instancia' stamp: 'ms 7/5/2021 17:39:24'!
crearCon: jugadorMano y: jugadorPie 
	
	
	^self new iniciarRondaConUn: jugadorMano yUn: jugadorPie! !


!Ronda class methodsFor: 'error Messages' stamp: 'ms 7/5/2021 21:05:59'!
noDebeEmpezarAJugarElJugadorManoPuesPerdioElAnteriorEnfrentamiento
	^'no Debe Empezar A Jugar El Jugador Mano Pues Perdio El Anterior Enfrentamiento'! !

!Ronda class methodsFor: 'error Messages' stamp: 'ms 7/5/2021 20:26:31'!
noDebeEmpezarAJugarElJugadorPiePuesPerdioElAnteriorEnfrentamiento
	
	^'No Debe Empezar A Jugar El Jugador Pie Pues Perdio El Anterior Enfrentamiento'! !

!Ronda class methodsFor: 'error Messages' stamp: 'ms 7/5/2021 20:05:23'!
noPuedeEmpezarAJugarElJugadorPieEnElEnfrentamiento1

	^'No Puede Empezar A Jugar El Jugador Pie En El Enfrentamiento 1'! !

!Ronda class methodsFor: 'error Messages' stamp: 'ms 7/5/2021 21:35:13'!
noPuedeRemoverUnaCartaQueNoTengaElJugador

	^'noPuedeRemoverUnaCartaQueNoTengaElJugador'! !

!Ronda class methodsFor: 'error Messages' stamp: 'ms 7/5/2021 19:46:33'!
noSePuedeCrearUnaRondaConCartasRepetidas

	^'No Se Puede Crear Una Ronda Con Cartas Repetidas'! !

!Ronda class methodsFor: 'error Messages' stamp: 'ms 7/5/2021 17:35:09'!
noSePuedeCrearUnaRondaSinCartas
	
	^ 'No Se Puede Crear Una Ronda Sin Cartas'! !

!Ronda class methodsFor: 'error Messages' stamp: 'ms 7/5/2021 19:46:42'!
noSePuedeCrearUnaRondaSinQueCadaJugadorTengaExactamente3Cartas
	
	^'No Se Puede Crear Una Ronda Sin Que Cada Jugador Tenga Exactamente 3 Cartas'! !

!Ronda class methodsFor: 'error Messages' stamp: 'ms 7/5/2021 19:46:21'!
noSePuedeTirarUnaCartaQueNoPertenezcaAlJugador

^'no Se Puede Tirar Una Carta Que No Pertenezca Al jugador'! !
