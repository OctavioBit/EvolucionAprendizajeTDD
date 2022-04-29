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


!classDefinition: #JugadasTest category: 'ISW1-2021-1C-2doParcial'!
TestCase subclass: #JugadasTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!JugadasTest methodsFor: 'as yet unclassified' stamp: 'JRC 7/5/2021 19:49:55'!
test01jugarUnaCartaQuitaCartasDelJugador
	
	| cartas unJugador |
	cartas := OrderedCollection new.

	
	cartas add:  CartaDeTruco anchoDeEspada. 
	cartas add:  CartaDeTruco anchoDeBasto. 
	cartas add:  CartaDeTruco sieteDeEspada. 

	unJugador := JugadorDeTruco crearCon: cartas. 
	self assert: (3 = unJugador cartasRestantes).
	
	self assert: (CartaDeTruco anchoDeEspada = (unJugador jugar: CartaDeTruco anchoDeEspada)).
	self assert:  (2 = unJugador cartasRestantes).
	! !

!JugadasTest methodsFor: 'as yet unclassified' stamp: 'JRC 7/5/2021 19:38:04'!
test02noPuedoJugarUnaCartaQueNoTengo
	| cartas unJugador |
	
	cartas := OrderedCollection new.
	cartas add:  CartaDeTruco anchoDeEspada. 
	cartas add:  CartaDeTruco anchoDeBasto. 
	cartas add:  CartaDeTruco sieteDeEspada. 

	unJugador := JugadorDeTruco crearCon: cartas. 
	self assert: (3 = unJugador cartasRestantes).
	
	self 
		should: [ unJugador jugar: CartaDeTruco sieteDeOro . ]
		raise: Error
		withMessageText:  JugadorDeTruco noPuedoJugarEsaCartaDescription.
	! !

!JugadasTest methodsFor: 'as yet unclassified' stamp: 'JRC 7/5/2021 20:11:20'!
test03JugadorSabeDondeJuega

	| mano pie error jugadorMano jugadorPie unaRondaComun |
	mano := OrderedCollection new.
	pie := OrderedCollection new.
	
	mano add:  CartaDeTruco anchoDeEspada. 
	mano add:  CartaDeTruco anchoDeBasto. 
	mano add:  CartaDeTruco sieteDeEspada. 
	
	pie add:  CartaDeTruco sieteDeOro. 
	pie add:  (CartaDeTruco copaCon: 4).
	pie add:  (CartaDeTruco oroCon: 4).
	
	
	unaRondaComun := RondaDeTruco InitializeWithMano: mano pie: pie.

	jugadorMano := unaRondaComun jugadorMano.
	jugadorPie := unaRondaComun jugadorPie.
	
	self assert: unaRondaComun = jugadorMano dondeJuega .
	self assert: unaRondaComun = jugadorPie dondeJuega .
	
"test03seDebeJugarEnOrden
	
	| mano pie error |
	mano := OrderedCollection new.
	pie := OrderedCollection new.
	
	mano add:  CartaDeTruco anchoDeEspada. 
	mano add:  CartaDeTruco anchoDeBasto. 
	mano add:  CartaDeTruco sieteDeEspada. 
	
	pie add:  CartaDeTruco sieteDeOro. 
	pie add:  (CartaDeTruco copaCon: 4).
	pie add:  (CartaDeTruco oroCon: 4).
	
	
	RondaDeTruco InitializeWithMano: mano pie: pie.
		
	unJugador Nothing more expected ->:= JugadorDeTruco crearCon: cartas en. 
	self assert: (3 = unJugador cartasRestantes).
	
	self 
		should: [ unJugador jugar: CartaDeTruco sieteDeOro . ]
		raise: Error
		withMessageText:  JugadorDeTruco noPuedoJugarEsaCartaDescription.
	"! !

!JugadasTest methodsFor: 'as yet unclassified' stamp: 'JRC 7/5/2021 20:23:09'!
test04seDebeJugarEnOrden
	
	| mano pie error jugadorMano jugadorPie unaRondaComun |
	mano := OrderedCollection new.
	pie := OrderedCollection new.
	
	mano add:  CartaDeTruco anchoDeEspada. 
	mano add:  CartaDeTruco anchoDeBasto. 
	mano add:  CartaDeTruco sieteDeEspada. 
	
	pie add:  CartaDeTruco sieteDeOro. 
	pie add:  (CartaDeTruco copaCon: 4).
	pie add:  (CartaDeTruco oroCon: 4).
	
	unaRondaComun := RondaDeTruco InitializeWithMano: mano pie: pie.

	jugadorMano := unaRondaComun jugadorMano.	
	jugadorPie := unaRondaComun jugadorPie.

	
	self  should: [ jugadorPie jugarEnRonda: CartaDeTruco anchoDeEspada. ]
		raise: Error
		withMessageText:  RondaDeTruco noEraSuTurnoDescription.
	

! !

!JugadasTest methodsFor: 'as yet unclassified' stamp: 'JRC 7/5/2021 20:25:19'!
test05seDebeJugarEnOrden
	
	| mano pie error jugadorMano jugadorPie unaRondaComun |
	mano := OrderedCollection new.
	pie := OrderedCollection new.
	
	mano add:  CartaDeTruco anchoDeEspada. 
	mano add:  CartaDeTruco anchoDeBasto. 
	mano add:  CartaDeTruco sieteDeEspada. 
	
	pie add:  CartaDeTruco sieteDeOro. 
	pie add:  (CartaDeTruco copaCon: 4).
	pie add:  (CartaDeTruco oroCon: 4).
	
	unaRondaComun := RondaDeTruco InitializeWithMano: mano pie: pie.

	jugadorMano := unaRondaComun jugadorMano.	
	jugadorPie := unaRondaComun jugadorPie.

	
	self  should: [ jugadorPie jugarEnRonda: CartaDeTruco anchoDeEspada. ]
		raise: Error
		withMessageText:  RondaDeTruco noEraSuTurnoDescription.
	

! !

!JugadasTest methodsFor: 'as yet unclassified' stamp: 'JRC 7/5/2021 21:35:00'!
test06seDebeGanarUnEnfrentamiento
	
	| mano pie jugadorMano jugadorPie unaRondaComun |
	mano := OrderedCollection new.
	pie := OrderedCollection new.
	
	mano add:  CartaDeTruco anchoDeEspada. 
	mano add:  CartaDeTruco anchoDeBasto. 
	mano add:  CartaDeTruco sieteDeEspada. 
	
	pie add:  CartaDeTruco sieteDeOro. 
	pie add:  (CartaDeTruco copaCon: 4).
	pie add:  (CartaDeTruco oroCon: 4).
	
	unaRondaComun := RondaDeTruco InitializeWithMano: mano pie: pie.

	jugadorMano := unaRondaComun jugadorMano.	
	jugadorPie := unaRondaComun jugadorPie.

	jugadorMano jugarEnRonda: CartaDeTruco anchoDeEspada.
	self assert: jugadorPie  equals: unaRondaComun quienSigue.
	
	jugadorPie jugarEnRonda: CartaDeTruco sieteDeOro.
	self assert: jugadorMano  equals: unaRondaComun quienSigue.
	
	self assert: 2 equals: unaRondaComun enQueEnfrentamientoEstamos .
	self assert: jugadorMano equals: unaRondaComun quienVaGanando .
! !

!JugadasTest methodsFor: 'as yet unclassified' stamp: 'JRC 7/5/2021 21:13:33'!
test07siSeEmpardaLaPrimeraJuegaMano
	
	| mano pie jugadorMano jugadorPie unaRondaComun |
	mano := OrderedCollection new.
	pie := OrderedCollection new.
	
	mano add:  CartaDeTruco anchoDeEspada. 
	mano add:  CartaDeTruco anchoDeBasto. 
	mano add:  (CartaDeTruco bastoCon: 4). 
	
	pie add:  CartaDeTruco sieteDeOro. 
	pie add:  (CartaDeTruco copaCon: 4).
	pie add:  (CartaDeTruco oroCon: 4).
	
	unaRondaComun := RondaDeTruco InitializeWithMano: mano pie: pie.

	jugadorMano := unaRondaComun jugadorMano.	
	jugadorPie := unaRondaComun jugadorPie.

	jugadorMano jugarEnRonda: (CartaDeTruco bastoCon: 4).
	jugadorPie jugarEnRonda: (CartaDeTruco oroCon: 4).
	
	self assert: jugadorMano  equals: unaRondaComun quienSigue.
	
	self assert: 2 equals: unaRondaComun enQueEnfrentamientoEstamos .
	self assert: 'empatados' equals: unaRondaComun quienVaGanando .
! !

!JugadasTest methodsFor: 'as yet unclassified' stamp: 'JRC 7/5/2021 21:41:37'!
test08elJuegoDebeTerminaAlGanar
	
	| mano pie jugadorMano jugadorPie unaRondaComun |
	mano := OrderedCollection new.
	pie := OrderedCollection new.
	
	mano add:  CartaDeTruco anchoDeEspada. 
	mano add:  CartaDeTruco anchoDeBasto. 
	mano add:  (CartaDeTruco bastoCon: 4). 
	
	pie add:  CartaDeTruco sieteDeOro. 
	pie add:  (CartaDeTruco copaCon: 4).
	pie add:  (CartaDeTruco oroCon: 4).
	
	unaRondaComun := RondaDeTruco InitializeWithMano: mano pie: pie.

	jugadorMano := unaRondaComun jugadorMano.	
	jugadorPie := unaRondaComun jugadorPie.

	jugadorMano jugarEnRonda: (CartaDeTruco bastoCon: 4).
	jugadorPie jugarEnRonda: (CartaDeTruco oroCon: 4).
	self assert: false equals: unaRondaComun juegoTerminado.
	
	jugadorMano jugarEnRonda: CartaDeTruco anchoDeBasto.
	jugadorPie jugarEnRonda: (CartaDeTruco copaCon: 4).
	
	self assert: jugadorMano  equals: unaRondaComun quienSigue.
	self assert: 3 equals: unaRondaComun enQueEnfrentamientoEstamos .
	self assert: jugadorMano equals: unaRondaComun quienVaGanando .
	
	jugadorMano jugarEnRonda:  CartaDeTruco anchoDeEspada.
	jugadorPie jugarEnRonda: CartaDeTruco sieteDeOro. 
	
	self assert: true equals: unaRondaComun juegoTerminado.
	self assert: jugadorMano equals: unaRondaComun quienVaGanando .

! !


!classDefinition: #RondaDeTrucoTest category: 'ISW1-2021-1C-2doParcial'!
TestCase subclass: #RondaDeTrucoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'JRC 7/5/2021 17:57:32'!
test01RondaDeTrucoSinCartasDebeSerInvalida
	
	| mano pie |
	mano := OrderedCollection new.
	pie := OrderedCollection new.

	self 
		should: [ RondaDeTruco InitializeWithMano: mano pie: pie. ]
		raise: Error
		withMessageText:  RondaDeTruco cartasDeJugadoresInvalidasDescription.! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'JRC 7/5/2021 18:30:42'!
test02RondaDeTrucoNoPuedeRepartirMismaCartaAAmbos
	
	| mano pie |
	mano := OrderedCollection new.
	pie := OrderedCollection new.
	
	mano add:  CartaDeTruco anchoDeEspada.
	pie add:  CartaDeTruco anchoDeEspada.
	
	self 
		should: [ RondaDeTruco InitializeWithMano: mano pie: pie. ]
		raise: Error
		withMessageText:  RondaDeTruco cartasDeJugadoresInvalidasDescription.! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'JRC 7/5/2021 18:17:34'!
test03RondaDeTrucoNoPuedeRepartirMismaCartaAUnJugador
	
	| mano pie |
	mano := OrderedCollection new.
	pie := OrderedCollection new.
	
	mano add:  CartaDeTruco anchoDeEspada.
	mano add:  CartaDeTruco anchoDeEspada.
	pie add:  CartaDeTruco anchoDeBasto .
	pie add:  CartaDeTruco anchoDeBasto .
	
	self 
		should: [ RondaDeTruco InitializeWithMano: mano pie: pie. ]
		raise: Error
		withMessageText:  RondaDeTruco cartasDeJugadoresInvalidasDescription.! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'JRC 7/5/2021 18:29:37'!
test04RondaDeTrucoSoloPermiteCartasDeTruco
	
	| mano pie |
	mano := OrderedCollection new.
	pie := OrderedCollection new.
	
	mano add:  1.
	pie add: 2.

	self 
		should: [ RondaDeTruco InitializeWithMano: mano pie: pie. ]
		raise: Error
		withMessageText:  RondaDeTruco cartasDeJugadoresInvalidasDescription.! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'JRC 7/5/2021 18:48:54'!
test05RondaDeTrucoNoDebeTenerCantDeCartasDistintasA3PorJugador
	
	| mano pie |
	mano := OrderedCollection new.
	pie := OrderedCollection new.
	
	mano add:  CartaDeTruco anchoDeEspada. 
	pie add:  CartaDeTruco anchoDeBasto. 

	self 
		should: [ RondaDeTruco InitializeWithMano: mano pie: pie. ]
		raise: Error
		withMessageText:  RondaDeTruco cartasDeJugadoresInvalidasDescription.! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'JRC 7/5/2021 19:13:41'!
test06RondaDeTrucoConCartasCorrectasNoDebeFallar
	"aplicando tdd este test pasa de entrada, pero me parece muy util tener un test que pase por positivo, y me sirva por si en futuro un test me rompe el caso positivo"
	
	| mano pie error |
	mano := OrderedCollection new.
	pie := OrderedCollection new.
	
	mano add:  CartaDeTruco anchoDeEspada. 
	mano add:  CartaDeTruco anchoDeBasto. 
	mano add:  CartaDeTruco sieteDeEspada. 
	
	pie add:  CartaDeTruco sieteDeOro. 
	pie add:  (CartaDeTruco copaCon: 4).
	pie add:  (CartaDeTruco oroCon: 4).
	
	error := #NoHubo.
	[RondaDeTruco InitializeWithMano: mano pie: pie.] on: Error do: [ error := #SiHubo.].
	self assert: #NoHubo = error .! !


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


!classDefinition: #JugadorDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #JugadorDeTruco
	instanceVariableNames: 'misCartas miRonda'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!JugadorDeTruco methodsFor: 'initialize' stamp: 'JRC 7/5/2021 20:04:46'!
initializeCrearCon: unasCartas enRonda: unaRonda 
	
	misCartas := unasCartas.
	miRonda := unaRonda.! !


!JugadorDeTruco methodsFor: 'private' stamp: 'JRC 7/5/2021 19:36:53'!
jugar: unaCartaDeTruco 
	misCartas remove: unaCartaDeTruco  ifAbsent: [self enviarErrorNoPuedoJugarEsaCarta].		
	^unaCartaDeTruco.! !


!JugadorDeTruco methodsFor: 'testing' stamp: 'JRC 7/5/2021 19:28:39'!
cartasRestantes
	^misCartas size.! !

!JugadorDeTruco methodsFor: 'testing' stamp: 'JRC 7/5/2021 20:08:41'!
dondeJuega
	^miRonda! !

!JugadorDeTruco methodsFor: 'testing' stamp: 'JRC 7/5/2021 19:27:27'!
initializeCrearCon: unasCartas 
	
	misCartas := unasCartas.! !


!JugadorDeTruco methodsFor: 'enviarErrores' stamp: 'JRC 7/5/2021 19:37:53'!
enviarErrorNoPuedoJugarEsaCarta
	^ self error: self class noPuedoJugarEsaCartaDescription.! !


!JugadorDeTruco methodsFor: 'juego' stamp: 'JRC 7/5/2021 20:16:03'!
jugarEnRonda: unaCartaDeTruco 
	
	miRonda jugador: self jugo:  unaCartaDeTruco. 
	^self jugar: unaCartaDeTruco 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'JugadorDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
JugadorDeTruco class
	instanceVariableNames: ''!

!JugadorDeTruco class methodsFor: 'instance creation' stamp: 'JRC 7/5/2021 19:26:40'!
crearCon: cartas
	
	^self new initializeCrearCon: cartas ! !

!JugadorDeTruco class methodsFor: 'instance creation' stamp: 'JRC 7/5/2021 20:02:17'!
crearCon: cartas enRonda: unaRonda
	
	^self new initializeCrearCon: cartas  enRonda: unaRonda! !


!JugadorDeTruco class methodsFor: 'as yet unclassified' stamp: 'JRC 7/5/2021 19:35:06'!
noPuedoJugarEsaCartaDescription
	^'No puedo jugar con esta carta!!'! !


!classDefinition: #RondaDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #RondaDeTruco
	instanceVariableNames: 'cartasMano cartasPie jugadorMano jugadorPie quienDebeJugar pasarEnfrentamientoEn enfrentamientoActual cartaDeMano cartaDePie quienVaGanando victoriasDeMano victoriasDePie juegoYaFinalizo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTruco methodsFor: 'private' stamp: 'JRC 7/5/2021 21:52:58'!
jugadaAFinalDeEnfrentamiento
	(pasarEnfrentamientoEn = 0 ) ifTrue:[ 
		(cartaDeMano mataA: cartaDePie) ifTrue:[ victoriasDeMano := victoriasDeMano +1.
										quienDebeJugar := jugadorMano ].
		(cartaDePie mataA: cartaDeMano) ifTrue:[ victoriasDePie := victoriasDePie +1.
										quienDebeJugar := jugadorPie	].
		( (cartaDePie empardaCon: cartaDeMano) and: (enfrentamientoActual=1)) ifTrue: [quienDebeJugar := jugadorMano].
		enfrentamientoActual  := enfrentamientoActual +1.
		pasarEnfrentamientoEn := 2.
		].! !

!RondaDeTruco methodsFor: 'private' stamp: 'JRC 7/5/2021 21:53:02'!
jugadaAMitadDeEnfrentamiento
	(pasarEnfrentamientoEn = 0 ) ifFalse:[ 
		(quienDebeJugar = jugadorMano ) ifFalse:[quienDebeJugar := jugadorPie].
		(quienDebeJugar = jugadorMano ) ifTrue:[quienDebeJugar := jugadorPie].
		].
	! !


!RondaDeTruco methodsFor: 'initialize' stamp: 'JRC 7/5/2021 21:50:42'!
cartasValidasdeMano: cartasParaMano dePie: cartasParaPie.
	(cartasParaMano isEmpty or: [cartasParaPie isEmpty] ) ifTrue: [ self enviarErrorCartaInvalida.].

	(cartasParaMano allSatisfy: [:carta |  (cartasParaPie includes: carta) not  ] ) ifFalse: [ self enviarErrorCartaInvalida.].
	
	(cartasParaMano allSatisfy: [:carta |  (cartasParaMano occurrencesOf: carta) =1  ] ) ifFalse: [ self enviarErrorCartaInvalida.].
	(cartasParaPie allSatisfy: [:carta |  (cartasParaPie occurrencesOf: carta) =1  ] ) ifFalse: [ self enviarErrorCartaInvalida.].
	
	(cartasParaMano allSatisfy: [:carta |  carta isKindOf: CartaDeTruco ] ) ifFalse: [ self enviarErrorCartaInvalida.].
	(cartasParaPie allSatisfy: [:carta |  carta isKindOf: CartaDeTruco ] ) ifFalse: [ self enviarErrorCartaInvalida.].
	
	(cartasParaMano size = 3  and: [cartasParaPie size = 3] )ifFalse: [ self enviarErrorCartaInvalida.].! !

!RondaDeTruco methodsFor: 'initialize' stamp: 'JRC 7/5/2021 21:51:08'!
crearRondaWithMano: cartasParaMano pie: cartasParaPie

	self cartasValidasdeMano: cartasParaMano dePie: cartasParaPie.
	
	jugadorMano := JugadorDeTruco crearCon: cartasParaMano enRonda: self.
	jugadorPie := JugadorDeTruco crearCon: cartasParaPie enRonda: self.
	
	quienDebeJugar := jugadorMano.
	pasarEnfrentamientoEn := 2.
	enfrentamientoActual := 1.
	quienVaGanando := 'nadie'.
	victoriasDeMano := 0.
	victoriasDePie := 0.
	juegoYaFinalizo  := false.! !


!RondaDeTruco methodsFor: 'enviarErrores' stamp: 'JRC 7/5/2021 18:34:53'!
enviarErrorCartaInvalida

	^ self error: self class cartasDeJugadoresInvalidasDescription! !

!RondaDeTruco methodsFor: 'enviarErrores' stamp: 'JRC 7/5/2021 20:24:52'!
enviarNoEraSuTurno

	^ self error: self class noEraSuTurnoDescription ! !


!RondaDeTruco methodsFor: 'jugadores' stamp: 'JRC 7/5/2021 20:07:46'!
jugadorMano
	^jugadorMano.! !

!RondaDeTruco methodsFor: 'jugadores' stamp: 'JRC 7/5/2021 20:11:20'!
jugadorPie
	^jugadorPie.! !


!RondaDeTruco methodsFor: 'testing' stamp: 'JRC 7/5/2021 20:44:54'!
enQueEnfrentamientoEstamos
	^enfrentamientoActual.! !

!RondaDeTruco methodsFor: 'testing' stamp: 'JRC 7/5/2021 21:25:36'!
juegoTerminado
	^juegoYaFinalizo! !

!RondaDeTruco methodsFor: 'testing' stamp: 'JRC 7/5/2021 20:42:53'!
quienSigue
	^quienDebeJugar! !

!RondaDeTruco methodsFor: 'testing' stamp: 'JRC 7/5/2021 21:04:28'!
quienVaGanando


	victoriasDeMano  > victoriasDePie ifTrue: [^jugadorMano ].
	victoriasDeMano  < victoriasDePie ifTrue: [^jugadorPie ].
	^'empatados'
	
	! !


!RondaDeTruco methodsFor: 'jugar' stamp: 'JRC 7/5/2021 21:53:16'!
jugador: unJugador jugo: unaCarta

	(quienDebeJugar =  unJugador) ifFalse: [self enviarNoEraSuTurno ].
	(quienDebeJugar = jugadorMano) ifTrue: [cartaDeMano := unaCarta].
	(quienDebeJugar = jugadorMano) ifFalse: [cartaDePie := unaCarta].
	
	pasarEnfrentamientoEn := pasarEnfrentamientoEn -1.
	
	self jugadaAMitadDeEnfrentamiento.
	
	self jugadaAFinalDeEnfrentamiento.
	
	enfrentamientoActual = 4 ifTrue:[juegoYaFinalizo	 := true]
		! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RondaDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco class
	instanceVariableNames: ''!

!RondaDeTruco class methodsFor: 'instance creation' stamp: 'JRC 7/5/2021 18:43:18'!
InitializeWithMano: CartasParaMano pie: CartasParaPie
	
	^self new crearRondaWithMano: CartasParaMano  pie: CartasParaPie ! !


!RondaDeTruco class methodsFor: 'ErrorDescription' stamp: 'JRC 7/5/2021 17:57:42'!
cartasDeJugadoresInvalidasDescription
	^'Las cartas de los jugadores deben ser validas!!'! !


!RondaDeTruco class methodsFor: 'as yet unclassified' stamp: 'JRC 7/5/2021 20:23:46'!
noEraSuTurnoDescription
	^'No era turno de ese jugador'! !
