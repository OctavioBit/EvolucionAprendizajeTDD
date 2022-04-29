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


!classDefinition: #JugadorTest category: 'ISW1-2021-1C-2doParcial'!
TestCase subclass: #JugadorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!JugadorTest methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 18:28:29'!
test01
	| jugador |
	jugador := Jugador new.
	
	self assert: jugador noTieneCartas.
	
	
	
	! !

!JugadorTest methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 18:31:43'!
test02
	| cartasJugador jugador |
	jugador := Jugador new.
	cartasJugador := (OrderedCollection with: (CartaDeTruco copaCon: 4) with:(CartaDeTruco copaCon: 4) with:(CartaDeTruco copaCon: 4)).
	
	jugador asignarCartas: cartasJugador.
	
	self assert: 3 equals: jugador cantidadDeCartas.
	
	
	
	
	! !

!JugadorTest methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 18:34:28'!
test03
	| cartasJugador jugador |
	jugador := Jugador new.
	"le agrego mas de 3 cartas"
	cartasJugador := (OrderedCollection with: (CartaDeTruco copaCon: 4) with:(CartaDeTruco copaCon: 4) with:(CartaDeTruco copaCon: 4) with:(CartaDeTruco copaCon: 4)).
	
	self should: [jugador asignarCartas: cartasJugador.]
		raise: Error - MessageNotUnderstood 
		withMessageText: Jugador cantidadIncorrectaDeCartasAsignadasErrorMessage.	
	
	
	
	
	
	
	! !


!classDefinition: #RepartidorDeCartasTest category: 'ISW1-2021-1C-2doParcial'!
TestCase subclass: #RepartidorDeCartasTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RepartidorDeCartasTest methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 18:52:47'!
test01
| cartasJugador1 jugador1 jugador2 repartidorDeCartas |
	jugador1 := Jugador new.
	jugador2 := Jugador new.
	repartidorDeCartas := RepartidorDeCartas mano: jugador1 pie: jugador2.
	cartasJugador1 := (OrderedCollection with: (CartaDeTruco copaCon: 4) with:(CartaDeTruco copaCon: 4) with:(CartaDeTruco copaCon: 4)).	
	
	self should: [ 	repartidorDeCartas repartirAMano: cartasJugador1.]
	raise: Error -MessageNotUnderstood 
	withMessageText: RepartidorDeCartas seJuegaConUnSoloMazoErrorMessage.
	
	
	! !

!RepartidorDeCartasTest methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 19:04:34'!
test02
| cartasJugador1 jugador1 jugador2 repartidorDeCartas cartasJugador2 |
	jugador1 := Jugador new.
	jugador2 := Jugador new.
	repartidorDeCartas := RepartidorDeCartas mano: jugador1 pie: jugador2.
	cartasJugador1 := (OrderedCollection with: (CartaDeTruco copaCon: 4) with:(CartaDeTruco copaCon: 5) with:(CartaDeTruco copaCon: 6)).	
	cartasJugador2 := (OrderedCollection with: (CartaDeTruco oroCon: 4) with:(CartaDeTruco oroCon: 5) with:(CartaDeTruco copaCon: 6)).	
	repartidorDeCartas repartirAMano: cartasJugador1.
	
	self should: [ 	repartidorDeCartas repartirAPie: cartasJugador2.]
	raise: Error - MessageNotUnderstood 
	withMessageText: RepartidorDeCartas seJuegaConUnSoloMazoErrorMessage.
	
	
	! !

!RepartidorDeCartasTest methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 19:14:30'!
test03
| cartasJugador1 jugador1 jugador2 repartidorDeCartas cartasJugador2 |
	jugador1 := Jugador new.
	jugador2 := Jugador new.
	repartidorDeCartas := RepartidorDeCartas mano: jugador1 pie: jugador2.
	cartasJugador1 := (OrderedCollection with: (CartaDeTruco copaCon: 4) with:(CartaDeTruco copaCon: 5) with:(CartaDeTruco copaCon: 6)).	
	cartasJugador2 := (OrderedCollection with: (CartaDeTruco oroCon: 4) with:(CartaDeTruco oroCon: 5) with:(CartaDeTruco oroCon: 6)).	
	
	repartidorDeCartas repartirAMano: cartasJugador1.
	repartidorDeCartas repartirAPie: cartasJugador2.
	
	self assert: 3 equals: jugador1 cantidadDeCartas.
	self assert: 3 equals: jugador2 cantidadDeCartas.
	
	
	! !


!classDefinition: #RondaDeTrucoTest category: 'ISW1-2021-1C-2doParcial'!
TestCase subclass: #RondaDeTrucoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 20:07:35'!
cartas456Copas

	^ OrderedCollection with: (CartaDeTruco copaCon: 4) with:(CartaDeTruco copaCon: 5) with:(CartaDeTruco copaCon: 6)! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 20:08:44'!
cartas456Oro

	^ OrderedCollection with: (CartaDeTruco oroCon: 4) with:(CartaDeTruco oroCon: 5) with:(CartaDeTruco oroCon: 6)! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 19:45:46'!
nuevoJugador

	^ Jugador new! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 20:11:15'!
test01
| jugador1 jugador2 repartidorDeCartas |
	jugador1 := Jugador new.
	jugador2 := Jugador new.
	repartidorDeCartas := RepartidorDeCartas mano: jugador1 pie: jugador2.
	
	repartidorDeCartas repartirAMano: self cartas456Copas.
	repartidorDeCartas repartirAPie: self cartas456Oro.
	
	
	RondaDeTruco mano: jugador1 pie: jugador2.
	
	self should:[ jugador1 jugarCarta: (CartaDeTruco oroCon: 4).		]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error | self assert: Jugador elJugadorNoPoseeLaCartaIndicadaErrorMessage equals: error messageText.
		self assert:3 equals: jugador2 cantidadDeCartas.]
	
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 20:10:50'!
test02
| jugador1 jugador2 repartidorDeCartas |
	jugador1 := Jugador new.
	jugador2 := Jugador new.
	repartidorDeCartas := RepartidorDeCartas mano: jugador1 pie: jugador2.

	repartidorDeCartas repartirAMano: self cartas456Copas.
	repartidorDeCartas repartirAPie: self cartas456Oro.	
	
	RondaDeTruco mano: jugador1 pie: jugador2.
	
	self should:[ jugador2 jugarCarta: (CartaDeTruco oroCon: 4).		]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error | self assert: RondaDeTruco noEsElTurnoDelJugadorErrorMessage equals: error messageText.
		self assert:3 equals: jugador2 cantidadDeCartas.]
	
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 20:10:08'!
test03
| jugador1 jugador2 repartidorDeCartas |
	jugador1 := Jugador new.
	jugador2 := Jugador new.
	repartidorDeCartas := RepartidorDeCartas mano: jugador1 pie: jugador2.
	
	repartidorDeCartas repartirAMano: self cartas456Copas.
	repartidorDeCartas repartirAPie: self cartas456Oro.
	
	
	RondaDeTruco mano: jugador1 pie: jugador2.
	
	jugador1 jugarCarta: (CartaDeTruco copaCon: 4).
	self assert:2 equals: jugador1 cantidadDeCartas.
	
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 20:09:42'!
test04
| jugador1 jugador2 repartidorDeCartas |
	jugador1 := Jugador new.
	jugador2 := Jugador new.
	repartidorDeCartas := RepartidorDeCartas mano: jugador1 pie: jugador2.
	
	repartidorDeCartas repartirAMano: self cartas456Copas.
	repartidorDeCartas repartirAPie: self cartas456Oro.
	
	RondaDeTruco mano: jugador1 pie: jugador2.
	
	jugador1 jugarCarta: (CartaDeTruco copaCon: 4).
		
	self should:[ jugador1 jugarCarta: (CartaDeTruco copaCon: 5).		]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error | self assert: RondaDeTruco noEsElTurnoDelJugadorErrorMessage equals: error messageText.
		self assert:2 equals: jugador1 cantidadDeCartas.]
	
	
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 20:15:11'!
test05
| jugador1 jugador2 repartidorDeCartas ronda |
	jugador1 := Jugador new.
	jugador2 := Jugador new.
	repartidorDeCartas := RepartidorDeCartas mano: jugador1 pie: jugador2.	
	repartidorDeCartas repartirAMano: self cartas456Copas.
	repartidorDeCartas repartirAPie: self cartas456Oro.	
	ronda := RondaDeTruco mano: jugador1 pie: jugador2.
	
	jugador1 jugarCarta: (CartaDeTruco copaCon: 4).
	jugador2 jugarCarta: (CartaDeTruco oroCon: 5).		
	
	self assert: jugador2 equals: ronda ganadorPrimerEnfrentamiento.! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 20:30:44'!
test06
| jugador1 jugador2 repartidorDeCartas ronda |
	jugador1 := Jugador new.
	jugador2 := Jugador new.
	repartidorDeCartas := RepartidorDeCartas mano: jugador1 pie: jugador2.	
	repartidorDeCartas repartirAMano: self cartas456Copas.
	repartidorDeCartas repartirAPie: self cartas456Oro.	
	ronda := RondaDeTruco mano: jugador1 pie: jugador2.
	
	jugador1 jugarCarta: (CartaDeTruco copaCon: 4).
	jugador2 jugarCarta: (CartaDeTruco oroCon: 5).		
			
	self should:[ jugador1 jugarCarta: (CartaDeTruco copaCon: 5).		]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error | self assert: RondaDeTruco noEsElTurnoDelJugadorErrorMessage equals: error messageText.
		self assert:2 equals: jugador1 cantidadDeCartas.]
	
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 20:38:43'!
test07
| jugador1 jugador2 repartidorDeCartas ronda |
	jugador1 := Jugador new.
	jugador2 := Jugador new.
	repartidorDeCartas := RepartidorDeCartas mano: jugador1 pie: jugador2.	
	repartidorDeCartas repartirAMano: self cartas456Copas.
	repartidorDeCartas repartirAPie: self cartas456Oro.	
	ronda := RondaDeTruco mano: jugador1 pie: jugador2.
	
	jugador1 jugarCarta: (CartaDeTruco copaCon: 4).
	jugador2 jugarCarta: (CartaDeTruco oroCon: 5).		
	jugador2 jugarCarta: (CartaDeTruco oroCon: 6).
	jugador1 jugarCarta: (CartaDeTruco copaCon: 5).				
	
	self assert: jugador2 equals: ronda ganadorPrimerEnfrentamiento.
	self assert: jugador2 equals: ronda ganadorSegundoEnfrentamiento.	
	self assert: jugador2 equals: ronda ganador.! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 20:56:40'!
test08
| jugador1 jugador2 repartidorDeCartas ronda |
	jugador1 := Jugador new.
	jugador2 := Jugador new.
	repartidorDeCartas := RepartidorDeCartas mano: jugador1 pie: jugador2.	
	repartidorDeCartas repartirAMano: self cartas456Copas.
	repartidorDeCartas repartirAPie: self cartas456Oro.	
	ronda := RondaDeTruco mano: jugador1 pie: jugador2.
	
	self should: [ronda ganador]
	raise: Error - MessageNotUnderstood 
	withMessageText: RondaDeTruco aunNoHayGanadoresErrorMessage.! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 21:51:01'!
test09
| jugador1 jugador2 repartidorDeCartas ronda |
	jugador1 := Jugador new.
	jugador2 := Jugador new.
	repartidorDeCartas := RepartidorDeCartas mano: jugador1 pie: jugador2.	
	repartidorDeCartas repartirAMano: self cartas456Copas.
	repartidorDeCartas repartirAPie: self cartas456Oro.	
	ronda := RondaDeTruco mano: jugador1 pie: jugador2.
	
	jugador1 jugarCarta: (CartaDeTruco copaCon: 4).
	jugador2 jugarCarta: (CartaDeTruco oroCon: 4).		
	jugador1 jugarCarta: (CartaDeTruco copaCon: 6).
	jugador2 jugarCarta: (CartaDeTruco oroCon: 5).				
	
	self assert: jugador1 equals: ronda ganador.! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 21:39:30'!
test10
| jugador1 jugador2 repartidorDeCartas ronda |
	jugador1 := Jugador new.
	jugador2 := Jugador new.
	repartidorDeCartas := RepartidorDeCartas mano: jugador1 pie: jugador2.	
	repartidorDeCartas repartirAMano: self cartas456Copas.
	repartidorDeCartas repartirAPie: self cartas456Oro.	
	ronda := RondaDeTruco mano: jugador1 pie: jugador2.
	
	jugador1 jugarCarta: (CartaDeTruco copaCon: 4).
	jugador2 jugarCarta: (CartaDeTruco oroCon: 5).		
	jugador2 jugarCarta: (CartaDeTruco oroCon: 6).
	jugador1 jugarCarta: (CartaDeTruco copaCon: 6).				
	jugador1 jugarCarta: (CartaDeTruco copaCon: 5).	
	jugador2 jugarCarta: (CartaDeTruco oroCon: 4).	
	
	
	self assert: jugador1 equals: ronda ganador.! !


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


!classDefinition: #Jugador category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #Jugador
	instanceVariableNames: 'cartas rondaDeTruco'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Jugador methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 18:38:26'!
asignarCartas: cartasParaJugar 
	cartasParaJugar size ~=3 ifTrue:[self error: self class cantidadIncorrectaDeCartasAsignadasErrorMessage ].
	cartas := cartasParaJugar .! !

!Jugador methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 18:16:02'!
cantidadDeCartas
	cartas ifNil:[^0].
	^cartas size.! !

!Jugador methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 19:43:54'!
jugarCarta: aCartaDeTruco 
	(cartas includes: aCartaDeTruco) not ifTrue: [self error: self class elJugadorNoPoseeLaCartaIndicadaErrorMessage].
	rondaDeTruco jugador: self tiraCarta: aCartaDeTruco .
	cartas remove: aCartaDeTruco.! !

!Jugador methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 18:13:23'!
noTieneCartas
	cartas ifNil: [^true].
	^false.! !

!Jugador methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 19:31:53'!
participaEnRonda: aRondaDeTruco 
	rondaDeTruco := aRondaDeTruco .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Jugador class' category: 'ISW1-2021-1C-2doParcial'!
Jugador class
	instanceVariableNames: ''!

!Jugador class methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 18:35:31'!
cantidadIncorrectaDeCartasAsignadasErrorMessage
	^ 'Se repartio una cantidad de cartas distinta de 3'! !

!Jugador class methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 19:41:48'!
elJugadorNoPoseeLaCartaIndicadaErrorMessage
	^'El jugador no posee la carta indicada.'! !


!classDefinition: #RepartidorDeCartas category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #RepartidorDeCartas
	instanceVariableNames: 'mano pie cartasRepartidas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RepartidorDeCartas methodsFor: 'initialization' stamp: 'JA 7/5/2021 19:12:59'!
initializeMano: unJugadorMano pie: unJugadorPie 
	mano := unJugadorMano.
	pie := unJugadorPie.
	cartasRepartidas  := OrderedCollection new.! !


!RepartidorDeCartas methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 19:10:25'!
assertCartasUnicas: cartasParaPie

	|pp|
	pp := OrderedCollection withAll: cartasRepartidas.
	pp addAll: cartasParaPie .
	
	(pp anySatisfy: [:carta | (pp occurrencesOf: carta) > 1]) ifTrue: [self error: self class seJuegaConUnSoloMazoErrorMessage ]! !

!RepartidorDeCartas methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 19:15:14'!
repartirAMano: cartasParaMano
	self assertCartasUnicas: cartasParaMano.
	cartasRepartidas addAll: cartasParaMano.
	mano asignarCartas: cartasParaMano.! !

!RepartidorDeCartas methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 19:15:45'!
repartirAPie: cartasParaPie
	self assertCartasUnicas: cartasParaPie.
	cartasRepartidas addAll: cartasParaPie.
	pie asignarCartas: cartasParaPie.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RepartidorDeCartas class' category: 'ISW1-2021-1C-2doParcial'!
RepartidorDeCartas class
	instanceVariableNames: ''!

!RepartidorDeCartas class methodsFor: 'instance creation' stamp: 'JA 7/5/2021 18:55:08'!
mano: unJugadorMano pie: unJugadorPie
	
	^self new initializeMano: unJugadorMano pie: unJugadorPie . ! !


!RepartidorDeCartas class methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 18:56:31'!
seJuegaConUnSoloMazoErrorMessage
	^ 'No se permiten cartas duplicadas. Se juega con un solo mazo.'! !


!classDefinition: #RondaDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #RondaDeTruco
	instanceVariableNames: 'mano pie jugadorEnTurno ganadorPrimerEnfrentamiento cartaEnfrentamientoActual ganadorPorEnfrentamiento enfrentamientoActual turnosPorEnfrentamiento parda'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTruco methodsFor: 'initialization' stamp: 'JA 7/5/2021 21:44:36'!
initializeMano: unJugadorMano pie: unJugadorPie 
	mano := unJugadorMano.
	mano participaEnRonda: self.
	pie := unJugadorPie.
	pie participaEnRonda: self.
	jugadorEnTurno := mano.
	ganadorPorEnfrentamiento  := OrderedCollection new.
	enfrentamientoActual := 1.
	turnosPorEnfrentamiento := OrderedCollection with: OrderedCollection new with: OrderedCollection new with: OrderedCollection new.
	parda := false.! !


!RondaDeTruco methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 21:44:14'!
ganador	
	((ganadorPorEnfrentamiento occurrencesOf: mano) = 2) ifTrue:[^ mano].
	((ganadorPorEnfrentamiento occurrencesOf: pie) = 2) ifTrue:[^ pie].
	parda ifTrue:[^ganadorPorEnfrentamiento last].
	self error: self class aunNoHayGanadoresErrorMessage.! !

!RondaDeTruco methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 20:27:32'!
ganadorPrimerEnfrentamiento
	^ganadorPorEnfrentamiento at:1.! !

!RondaDeTruco methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 20:50:46'!
ganadorSegundoEnfrentamiento
	^ganadorPorEnfrentamiento at:2! !

!RondaDeTruco methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 21:49:00'!
jugador: aJugador tiraCarta: aCartaDeTruco 
	aJugador ~= jugadorEnTurno ifTrue:[self error: self class noEsElTurnoDelJugadorErrorMessage].
	
	
	(turnosPorEnfrentamiento at: enfrentamientoActual) add: aJugador.  
	cartaEnfrentamientoActual ifNil:[		
		cartaEnfrentamientoActual := aCartaDeTruco. 		
		mano = aJugador ifTrue:[jugadorEnTurno := pie.]		
		ifFalse: [jugadorEnTurno := mano.].		
		 ]	  
	ifNotNil:[		
		(aCartaDeTruco mataA: cartaEnfrentamientoActual) 
		ifTrue: [ganadorPorEnfrentamiento add: aJugador.
			jugadorEnTurno := aJugador.
			]
		ifFalse: [
			(aCartaDeTruco empardaCon: cartaEnfrentamientoActual) 
			ifTrue:[ parda := true.
				enfrentamientoActual = 1 ifTrue: [jugadorEnTurno := mano]
				ifFalse: [
				(((turnosPorEnfrentamiento at: (enfrentamientoActual - 1)) at: 1) = mano)
					ifTrue: [jugadorEnTurno := mano]
					ifFalse:[jugadorEnTurno := pie].
				]]
			ifFalse:[
			mano = aJugador ifTrue:[
			ganadorPorEnfrentamiento add: pie.
			jugadorEnTurno := pie]
			ifFalse: [ganadorPorEnfrentamiento add: mano.
			jugadorEnTurno := mano]
			]].
		enfrentamientoActual  := enfrentamientoActual +1.
		cartaEnfrentamientoActual := nil.
	]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RondaDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco class
	instanceVariableNames: ''!

!RondaDeTruco class methodsFor: 'instance creation' stamp: 'JA 7/5/2021 18:04:17'!
mano: unJugadorMano pie: unJugadorPie
	
	^self new initializeMano: unJugadorMano pie: unJugadorPie .! !


!RondaDeTruco class methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 20:57:17'!
aunNoHayGanadoresErrorMessage
	^'Aun No Hay ganadores'! !

!RondaDeTruco class methodsFor: 'as yet unclassified' stamp: 'JA 7/5/2021 19:35:56'!
noEsElTurnoDelJugadorErrorMessage
	^'No es el turno del jugador.'! !
