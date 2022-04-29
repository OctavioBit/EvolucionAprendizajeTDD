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

!JugadorTest methodsFor: 'tests - juego' stamp: 'dv 7/5/2021 19:51:30'!
test03NoSePuedeJugarUnaCartaQueNoSeTenga
	 	|mano pie ronda |
	mano :=Jugador conCartas: {CartaDeTruco anchoDeEspada. 
			CartaDeTruco anchoDeBasto . 
			CartaDeTruco sieteDeEspada.}.
	pie := Jugador conCartas: {CartaDeTruco espadaCon: 3. 
			CartaDeTruco oroCon: 3. 
			CartaDeTruco sieteDeOro}.
	
	ronda := Ronda mano: mano yPie: pie.

	self should: [mano juegaCarta: (CartaDeTruco espadaCon: 4) enRonda: ronda]
	raise: Error
	withMessageText: Jugador noSePuedeJugarUnaCartaQueNoSeTiene.! !

!JugadorTest methodsFor: 'tests - juego' stamp: 'dv 7/5/2021 20:44:56'!
test04LuegoDeJugarUnaCartaEstaNoSeTieneMas
	 	|mano pie ronda |
	mano :=Jugador conCartas: {CartaDeTruco anchoDeEspada. 
			CartaDeTruco anchoDeBasto . 
			CartaDeTruco sieteDeEspada.}.
	pie := Jugador conCartas: {CartaDeTruco espadaCon: 3. 
			CartaDeTruco oroCon: 3. 
			CartaDeTruco sieteDeOro}.
	
	ronda := Ronda mano: mano yPie: pie.

	mano juegaCarta: CartaDeTruco anchoDeEspada enRonda: ronda.
	self assert: 2 equals: mano cantidadDeCartas.
	self assert: (mano tiene: CartaDeTruco anchoDeBasto).
	self assert: (mano tiene: CartaDeTruco sieteDeEspada).
	
	! !


!JugadorTest methodsFor: 'tests - creacion' stamp: 'dv 7/5/2021 19:46:55'!
test01NoSePuedeCrearUnJugadorSin3Cartas
			
	self should: [Jugador conCartas: {}]
	raise: Error
	withMessageText: Jugador noSePuedeCrearUnJugadorSin3Cartas.
	
	self should: [Jugador conCartas: {CartaDeTruco espadaCon: 3.}]
	raise: Error
	withMessageText: Jugador noSePuedeCrearUnJugadorSin3Cartas.
	
	self should: [Jugador conCartas: {CartaDeTruco espadaCon: 3.
							     CartaDeTruco oroCon: 3}]
	raise: Error
	withMessageText: Jugador noSePuedeCrearUnJugadorSin3Cartas.
	
	self should: [Jugador conCartas: {CartaDeTruco espadaCon: 3.
							     CartaDeTruco oroCon: 3.
							     CartaDeTruco anchoDeBasto.
							     CartaDeTruco anchoDeEspada.}]
	raise: Error
	withMessageText: Jugador noSePuedeCrearUnJugadorSin3Cartas.! !

!JugadorTest methodsFor: 'tests - creacion' stamp: 'dv 7/5/2021 19:47:18'!
test02NoSePuedeCrearUnJugadorConCartasRepetidas
	
	self should: [Jugador conCartas: {CartaDeTruco espadaCon: 3. 
							     CartaDeTruco espadaCon: 3.
							     CartaDeTruco anchoDeEspada.}]
	raise: Error
	withMessageText: Jugador noSePuedeCrearUnJugadorConCartasRepetidas .
	! !


!classDefinition: #RondaTest category: 'ISW1-2021-1C-2doParcial'!
TestCase subclass: #RondaTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaTest methodsFor: 'tests creacion' stamp: 'dv 7/5/2021 20:06:21'!
test01NoSePuedeCrearRondaConCantidadDeCartasInvalidas
 	|jugadorA jugadorB ronda |
	jugadorB := Jugador conCartas: {CartaDeTruco anchoDeEspada. 
			CartaDeTruco anchoDeBasto . 
			CartaDeTruco sieteDeEspada.
			} .
	jugadorA := Jugador conCartas: {CartaDeTruco espadaCon: 3.  
			CartaDeTruco sieteDeOro.
			CartaDeTruco oroCon: 3}.
			
	ronda := Ronda mano: jugadorA yPie: jugadorB.
	jugadorA juegaCarta: (CartaDeTruco  sieteDeOro ) enRonda: ronda.
	
	self should: [Ronda mano: jugadorA yPie: jugadorB]
	raise: Error
	withMessageText: Ronda noSePuedeCrearUnaRondaConCantidadDeCartasInvalidas.
				
	self should: [Ronda mano: jugadorB yPie: jugadorA]
	raise: Error
	withMessageText: Ronda noSePuedeCrearUnaRondaConCantidadDeCartasInvalidas.
	
	! !

!RondaTest methodsFor: 'tests creacion' stamp: 'dv 7/5/2021 20:11:42'!
test02NoSePuedeCrearRondasConCartasRepetidas
 	|jugador |
	jugador := Jugador conCartas: {CartaDeTruco espadaCon: 4. 
			CartaDeTruco espadaCon: 3. 
			CartaDeTruco sieteDeOro}.
			
	self should: [Ronda mano: jugador  yPie: jugador]
	raise: Error
	withMessageText: Ronda noSePuedeCrearUnaRondaConCartasRepetidas.
	
	self should: [Ronda mano: jugador yPie: jugador.]
	raise: Error
	withMessageText: Ronda noSePuedeCrearUnaRondaConCartasRepetidas.
	! !


!RondaTest methodsFor: 'tests - juego' stamp: 'dv 7/5/2021 20:27:30'!
test03LaPrimeraRondaNoLaPuedeEmpezarElPie
 	|mano pie ronda |
	mano :=Jugador conCartas: {CartaDeTruco anchoDeEspada. 
			CartaDeTruco anchoDeBasto . 
			CartaDeTruco sieteDeEspada.}.
	pie := Jugador conCartas: {CartaDeTruco espadaCon: 3. 
			CartaDeTruco oroCon: 3. 
			CartaDeTruco sieteDeOro}.
	
	ronda := Ronda mano: mano yPie: pie.

	self should: [pie juegaCarta: (CartaDeTruco espadaCon: 3) enRonda: ronda]
	raise: Error
	withMessageText: Ronda noEsElTurnoCorrecto.! !

!RondaTest methodsFor: 'tests - juego' stamp: 'dv 7/5/2021 20:27:30'!
test04UnJugadorNoPuedeJugarDosVecesSeguidas
 	|mano pie ronda |
	mano :=Jugador conCartas: {CartaDeTruco anchoDeEspada. 
			CartaDeTruco anchoDeBasto . 
			CartaDeTruco sieteDeEspada.}.
	pie := Jugador conCartas: {CartaDeTruco espadaCon: 3. 
			CartaDeTruco oroCon: 3. 
			CartaDeTruco sieteDeOro}.
	
	ronda := Ronda mano: mano yPie: pie.
	mano juegaCarta: (CartaDeTruco anchoDeBasto) enRonda: ronda.
	self should: [mano juegaCarta: (CartaDeTruco sieteDeEspada) enRonda: ronda]
	raise: Error
	withMessageText: Ronda noEsElTurnoCorrecto.! !

!RondaTest methodsFor: 'tests - juego' stamp: 'dv 7/5/2021 21:04:39'!
test05ElPerdedorNoPuedeIniciarElProximoEnfrentamiento
 	|mano pie ronda |
	mano :=Jugador conCartas: {CartaDeTruco oroCon: 3.
			CartaDeTruco anchoDeEspada. 
			CartaDeTruco anchoDeBasto .}.
	pie := Jugador conCartas: {CartaDeTruco espadaCon: 3. 
			CartaDeTruco sieteDeEspada. 
			CartaDeTruco sieteDeOro}.
	
	ronda := Ronda mano: mano yPie: pie.
	mano juegaCarta: (CartaDeTruco oroCon: 3) enRonda: ronda.
	pie juegaCarta: (CartaDeTruco sieteDeEspada ) enRonda: ronda.
	self should: [mano juegaCarta: (CartaDeTruco anchoDeEspada ) enRonda: ronda]
	raise: Error
	withMessageText: Ronda noEsElTurnoCorrecto.! !

!RondaTest methodsFor: 'tests - juego' stamp: 'dv 7/5/2021 21:12:41'!
test06NoSePuedePreguntarElGanadorDeUnaPartidaEnCurso
 	|mano pie ronda |
	mano :=Jugador conCartas: {CartaDeTruco oroCon: 3.
			CartaDeTruco anchoDeEspada.  
			CartaDeTruco sieteDeOro		.}.
	pie := Jugador conCartas: {CartaDeTruco espadaCon: 3. 
			CartaDeTruco sieteDeEspada. 
			CartaDeTruco anchoDeBasto}.
	
	ronda := Ronda mano: mano yPie: pie.
	mano juegaCarta: (CartaDeTruco oroCon: 3) enRonda: ronda.
	pie juegaCarta: (CartaDeTruco sieteDeEspada ) enRonda: ronda.

	self should: [ronda ganador]
	raise: Error
	withMessageText: Ronda aunNoTermina.! !

!RondaTest methodsFor: 'tests - juego' stamp: 'dv 7/5/2021 22:03:15'!
xtest07LuegoDeDosEnfrentamientosGanadosTerminaLaPartida
 	|mano pie ronda |
	"No pude terminar el test por falta de tiempo, sorry"
	mano :=Jugador conCartas: {CartaDeTruco oroCon: 3.
			CartaDeTruco anchoDeBasto. 
			CartaDeTruco sieteDeOro		}.
	pie := Jugador conCartas: {CartaDeTruco espadaCon: 3. 
			CartaDeTruco sieteDeEspada. 
			CartaDeTruco anchoDeEspada.}.
	
	ronda := Ronda mano: mano yPie: pie.
	mano juegaCarta: (CartaDeTruco oroCon: 3) enRonda: ronda.
	pie juegaCarta: (CartaDeTruco sieteDeEspada ) enRonda: ronda.
	pie juegaCarta: (CartaDeTruco anchoDeEspada) enRonda: ronda.
	mano juegaCarta: (CartaDeTruco anchoDeBasto ) enRonda: ronda.
	
	self should: [pie juegaCarta: (CartaDeTruco espadaCon: 3) enRonda: ronda.]
	raise: Error
	withMessageText: Ronda laRondaTermino.! !


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
	instanceVariableNames: 'cartas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Jugador methodsFor: 'initialization' stamp: 'dv 7/5/2021 20:21:17'!
initializeConCartas: unasCartas 
	cartas := OrderedCollection newFrom: unasCartas.! !


!Jugador methodsFor: 'testing' stamp: 'dv 7/5/2021 20:41:29'!
tiene: unaCarta
	^ cartas includes: unaCarta ! !


!Jugador methodsFor: 'accessing' stamp: 'dv 7/5/2021 18:38:35'!
cantidadDeCartas
	^ cartas size! !

!Jugador methodsFor: 'accessing' stamp: 'dv 7/5/2021 18:46:28'!
muestraLasCartas
	^cartas! !


!Jugador methodsFor: 'assertions' stamp: 'dv 7/5/2021 20:41:41'!
assertTiene: cartaDeTruco

	^ (self tiene: cartaDeTruco)  ifFalse:[self error: self class noSePuedeJugarUnaCartaQueNoSeTiene ]! !


!Jugador methodsFor: 'as yet unclassified' stamp: 'dv 7/5/2021 20:42:36'!
juegaCarta: cartaDeTruco enRonda: unaRonda
	self assertTiene: cartaDeTruco.
	unaRonda recibeCarta: cartaDeTruco de: self.
	cartas remove: cartaDeTruco.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Jugador class' category: 'ISW1-2021-1C-2doParcial'!
Jugador class
	instanceVariableNames: ''!

!Jugador class methodsFor: 'instance creation' stamp: 'dv 7/5/2021 19:44:26'!
conCartas: unasCartas
	(unasCartas size = 3) ifFalse:[self error: self noSePuedeCrearUnJugadorSin3Cartas ].
	unasCartas do: [:elem | ((unasCartas select:[:elem2|elem = elem2]) size >1) ifTrue:[self error: self noSePuedeCrearUnJugadorConCartasRepetidas ]].

	^self new initializeConCartas: unasCartas! !


!Jugador class methodsFor: 'error messages' stamp: 'dv 7/5/2021 19:12:33'!
noSePuedeCrearUnJugadorConCartasRepetidas
	^'No se pueden repetir cartas porque hay un solo mazo. Deja la trampa'! !

!Jugador class methodsFor: 'error messages' stamp: 'dv 7/5/2021 19:44:49'!
noSePuedeCrearUnJugadorSin3Cartas
	^'No se puede crear un jugador con una cantidad de cartas diferentes a 3. Que no sabes jugar al truco?'! !

!Jugador class methodsFor: 'error messages' stamp: 'dv 7/5/2021 19:50:42'!
noSePuedeJugarUnaCartaQueNoSeTiene
	^'Y de donde sacaste esa carta? No podes jugar una carta que no tenes.'! !


!classDefinition: #Ronda category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #Ronda
	instanceVariableNames: 'mano pie jugadorEnTurno cartaAnterior terminoPartida ganador scoreboard puntajeMano puntajePie'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Ronda methodsFor: 'instance creation' stamp: 'dv 7/5/2021 21:30:58'!
mano: aMano yPie: aPie 
	mano:= aMano.
	pie:=aPie.
	puntajeMano:=0.
	puntajePie:=0.
	jugadorEnTurno := mano.
	cartaAnterior:= nil.
	terminoPartida := false.
	ganador:= nil.! !


!Ronda methodsFor: 'assertions' stamp: 'dv 7/5/2021 21:41:46'!
assertAunNoSeAcaboElJuego
	(self terminoPartida) ifTrue:[self error: self class laRondaTermino ]
	! !

!Ronda methodsFor: 'assertions' stamp: 'dv 7/5/2021 20:52:55'!
assertEsElTurnoDe: unJugador.
	(unJugador ~= jugadorEnTurno) ifTrue:[
	self error: self class noEsElTurnoCorrecto ]! !

!Ronda methodsFor: 'assertions' stamp: 'dv 7/5/2021 21:14:29'!
assertRondaTermino.
	self terminoPartida ifFalse:[self error: self class aunNoTermina ]! !


!Ronda methodsFor: 'turnos' stamp: 'dv 7/5/2021 20:59:38'!
cambiarTurnoAlGanador: unJugador 
	jugadorEnTurno := unJugador.
	cartaAnterior := nil.! !

!Ronda methodsFor: 'turnos' stamp: 'dv 7/5/2021 20:56:09'!
rotarElTurno: unJugador

	^ (unJugador = mano) ifTrue: [jugadorEnTurno := pie] ifFalse:[ jugadorEnTurno := mano]! !


!Ronda methodsFor: 'status' stamp: 'dv 7/5/2021 21:13:52'!
ganador
	self assertRondaTermino.
	^ ganador.! !

!Ronda methodsFor: 'status' stamp: 'dv 7/5/2021 21:11:10'!
terminoPartida 
	^terminoPartida! !


!Ronda methodsFor: 'juego' stamp: 'dv 7/5/2021 21:29:10'!
ganaLaCarta: unaCarta
	^(cartaAnterior isNil not and: [unaCarta mataA: cartaAnterior])! !

!Ronda methodsFor: 'juego' stamp: 'dv 7/5/2021 21:26:39'!
ganoEnfrentamiento: unJugador
	self incrementarPuntuacion: unJugador.
	self revisarSiEsGanador:unJugador.
	self cambiarTurnoAlGanador: unJugador ! !

!Ronda methodsFor: 'juego' stamp: 'dv 7/5/2021 21:30:22'!
incrementarPuntuacion: unJugador

	^ (unJugador = mano) ifTrue:[puntajeMano:=puntajeMano+1]ifFalse:[puntajePie:=puntajePie+1]! !

!Ronda methodsFor: 'juego' stamp: 'dv 7/5/2021 21:58:45'!
recibeCarta: unaCarta de: unJugador
	self assertAunNoSeAcaboElJuego.
	self assertEsElTurnoDe: unJugador.
	
	(self ganaLaCarta: unaCarta) ifTrue: [ ^ self ganoEnfrentamiento: unJugador] 
	ifFalse: [	cartaAnterior := unaCarta. self rotarElTurno: unJugador]! !

!Ronda methodsFor: 'juego' stamp: 'dv 7/5/2021 22:02:01'!
revisarSiEsGanador: unJugador
	"Falto quitar codigo repetido por falta de tiempo"
	(puntajeMano= 2) ifTrue:[					ganador:= mano .	
						self seAcaboLaRonda].
	(puntajePie= 2) ifTrue:[			ganador:= pie .	
						self seAcaboLaRonda].
	"((puntajePie + puntajeMano) = 3) ifTrue:[	'esEmparedado'
						self seAcaboLaRonda]. 
					
	 No lo agregue porque me faltaba un test"
					
				
	! !

!Ronda methodsFor: 'juego' stamp: 'dv 7/5/2021 21:43:25'!
seAcaboLaRonda

	terminoPartida := true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ronda class' category: 'ISW1-2021-1C-2doParcial'!
Ronda class
	instanceVariableNames: ''!

!Ronda class methodsFor: 'error messages' stamp: 'dv 7/5/2021 21:13:08'!
aunNoTermina
	^'Sigue la partida'! !

!Ronda class methodsFor: 'error messages' stamp: 'dv 7/5/2021 21:36:04'!
laRondaTermino
	^'Se acabo che'! !

!Ronda class methodsFor: 'error messages' stamp: 'dv 7/5/2021 20:27:30'!
noEsElTurnoCorrecto
	^'La ronda la empieza la mano ehh'! !

!Ronda class methodsFor: 'error messages' stamp: 'dv 7/5/2021 17:57:43'!
noSePuedeCrearUnaRondaConCantidadDeCartasInvalidas
	^'Cada ronda debe tener 3 cartas por jugador al Inicio'! !

!Ronda class methodsFor: 'error messages' stamp: 'dv 7/5/2021 18:07:19'!
noSePuedeCrearUnaRondaConCartasRepetidas
	^'Dado que solo hay unmazo, no se pueden repetir cartas en la ronda. Deja la trampa!!'! !


!Ronda class methodsFor: 'assertions' stamp: 'dv 7/5/2021 20:51:11'!
assertNoSeRepitenCartasEntreMano: aMano yPie:aPie

	aMano muestraLasCartas do: [ :cartaMano| 
		(aPie muestraLasCartas includes: cartaMano) ifTrue:
		[self error: self noSePuedeCrearUnaRondaConCartasRepetidas]].
! !

!Ronda class methodsFor: 'assertions' stamp: 'dv 7/5/2021 20:49:51'!
assertTienenCantidadesDeCartaValidasMano: aMano yPie:aPie
	
	(aMano cantidadDeCartas = 3 and:[aPie cantidadDeCartas = 3]) 
		ifFalse:[	self error: self noSePuedeCrearUnaRondaConCantidadDeCartasInvalidas].
	! !


!Ronda class methodsFor: 'initialize' stamp: 'dv 7/5/2021 20:50:43'!
mano:aMano yPie: aPie

	self assertTienenCantidadesDeCartaValidasMano: aMano yPie:aPie.
	self assertNoSeRepitenCartasEntreMano: aMano yPie:aPie.

	^ self new mano: aMano yPie:aPie.! !
