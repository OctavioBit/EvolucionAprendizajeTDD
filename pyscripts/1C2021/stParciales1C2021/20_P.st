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


!CartaDeTrucoTest methodsFor: 'test - ronda' stamp: 'CS 7/5/2021 19:30:55'!
test21NoSePuedeCrearElJugadorPorCartasRepetidas

	| cartaMano1 cartaMano2 cartaMano3 |
	
	cartaMano1 := CartaDeTruco anchoDeEspada.
	cartaMano2 := CartaDeTruco copaCon: 6.
	cartaMano3 := CartaDeTruco anchoDeEspada.

	self 
		should: [Jugador primerCarta: cartaMano1 segundaCarta: cartaMano2 yTerceraCarta: cartaMano3]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Jugador unJugadorNoPuedeTenerCartasRepetidasDescripcionDeError equals: anError messageText].! !

!CartaDeTrucoTest methodsFor: 'test - ronda' stamp: 'CS 7/5/2021 19:30:33'!
test22NoSePuedeCrearLaRondaPorCartasRepetidasEntreLosJugadores

	| cartaMano1 cartaMano2 cartaMano3 cartaPie1 cartaPie2 cartaPie3 jugadorMano jugadorPie |
	
	cartaMano1 := CartaDeTruco anchoDeEspada.
	cartaMano2 := CartaDeTruco copaCon: 6.
	cartaMano3 := CartaDeTruco espadaCon: 4.

	cartaPie1 := CartaDeTruco anchoDeEspada.
	cartaPie2 := CartaDeTruco anchoDeBasto.
	cartaPie3 := CartaDeTruco copaCon: 3.
	
	jugadorMano := Jugador primerCarta: cartaMano1 segundaCarta: cartaMano2 yTerceraCarta: cartaMano3.
	jugadorPie := Jugador primerCarta: cartaPie1 segundaCarta: cartaPie2 yTerceraCarta: cartaPie3.

	self 
		should: [Ronda entre: jugadorMano y: jugadorPie.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Ronda noSePuedeTenerCartasRepetidasEntreJugadoresDescripcionDeError equals: anError messageText].! !

!CartaDeTrucoTest methodsFor: 'test - ronda' stamp: 'CS 7/5/2021 19:34:00'!
test23SePuedeCrearCorrectamenteLaRondaPorqueNoHayCartasRepetidas

	| cartaMano1 cartaMano2 cartaMano3 cartaPie1 cartaPie2 cartaPie3 jugadorMano jugadorPie |
	
	cartaMano1 := CartaDeTruco bastoCon: 2.
	cartaMano2 := CartaDeTruco copaCon: 6.
	cartaMano3 := CartaDeTruco espadaCon: 4.

	cartaPie1 := CartaDeTruco anchoDeEspada.
	cartaPie2 := CartaDeTruco anchoDeBasto.
	cartaPie3 := CartaDeTruco copaCon: 3.
	
	jugadorMano := Jugador primerCarta: cartaMano1 segundaCarta: cartaMano2 yTerceraCarta: cartaMano3.
	jugadorPie := Jugador primerCarta: cartaPie1 segundaCarta: cartaPie2 yTerceraCarta: cartaPie3.

	self 
		shouldntFail: [Ronda entre: jugadorMano y: jugadorPie]! !

!CartaDeTrucoTest methodsFor: 'test - ronda' stamp: 'CS 7/5/2021 20:22:03'!
test24GanaElPrimerEnfrentamientoElQueEsMano

	| cartaMano1 cartaMano2 cartaMano3 cartaPie1 cartaPie2 cartaPie3 jugadorMano jugadorPie ronda |
	
	cartaMano1 := CartaDeTruco anchoDeBasto.
	cartaMano2 := CartaDeTruco anchoDeEspada.
	cartaMano3 := CartaDeTruco espadaCon: 4.

	cartaPie1 := CartaDeTruco bastoCon: 3.
	cartaPie2 := CartaDeTruco oroCon: 2.
	cartaPie3 := CartaDeTruco copaCon: 3.
	
	jugadorMano := Jugador primerCarta: cartaMano1 segundaCarta: cartaMano2 yTerceraCarta: cartaMano3.
	jugadorPie := Jugador primerCarta: cartaPie1 segundaCarta: cartaPie2 yTerceraCarta: cartaPie3.

	ronda := Ronda entre: jugadorMano y: jugadorPie.
	
	ronda primerEnfrentamientoJuegaElJugador: jugadorMano conLaCarta: cartaMano2 contra: jugadorPie conLaCarta: cartaPie2.

	self assert: (ronda ganoPrimerEnfrentamiento: jugadorMano).

	

	! !

!CartaDeTrucoTest methodsFor: 'test - ronda' stamp: 'CS 7/5/2021 20:26:34'!
test25NoSePuedeEjecutarElSegundoEnfrentamientoPorqueElPrimeroQueTiroNoEsElQueGanoElAnterior

	| cartaMano1 cartaMano2 cartaMano3 cartaPie1 cartaPie2 cartaPie3 jugadorMano jugadorPie ronda |
	
	cartaMano1 := CartaDeTruco anchoDeBasto.
	cartaMano2 := CartaDeTruco anchoDeEspada.
	cartaMano3 := CartaDeTruco espadaCon: 4.

	cartaPie1 := CartaDeTruco bastoCon: 3.
	cartaPie2 := CartaDeTruco oroCon: 2.
	cartaPie3 := CartaDeTruco copaCon: 3.
	
	jugadorMano := Jugador primerCarta: cartaMano1 segundaCarta: cartaMano2 yTerceraCarta: cartaMano3.
	jugadorPie := Jugador primerCarta: cartaPie1 segundaCarta: cartaPie2 yTerceraCarta: cartaPie3.

	ronda := Ronda entre: jugadorMano y: jugadorPie.
	
	ronda primerEnfrentamientoJuegaElJugador: jugadorMano conLaCarta: cartaMano2 contra: jugadorPie conLaCarta: cartaPie2.

	self 
		should: [	ronda segundoEnfrentamientoJuegaElJugador: jugadorPie conLaCarta: cartaPie3 contra: jugadorMano conLaCarta: cartaMano1]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Ronda noLeTocabaElTurnoAElDescripcionDeError equals: anError messageText].


	

	! !

!CartaDeTrucoTest methodsFor: 'test - ronda' stamp: 'CS 7/5/2021 20:32:44'!
test26GanaLosDosPrimerosEnfrentamientosElQueEraManoYGanaLaPartida

	| cartaMano1 cartaMano2 cartaMano3 cartaPie1 cartaPie2 cartaPie3 jugadorMano jugadorPie ronda |
	
	cartaMano1 := CartaDeTruco anchoDeBasto.
	cartaMano2 := CartaDeTruco anchoDeEspada.
	cartaMano3 := CartaDeTruco espadaCon: 4.

	cartaPie1 := CartaDeTruco bastoCon: 3.
	cartaPie2 := CartaDeTruco oroCon: 2.
	cartaPie3 := CartaDeTruco copaCon: 3.
	
	jugadorMano := Jugador primerCarta: cartaMano1 segundaCarta: cartaMano2 yTerceraCarta: cartaMano3.
	jugadorPie := Jugador primerCarta: cartaPie1 segundaCarta: cartaPie2 yTerceraCarta: cartaPie3.

	ronda := Ronda entre: jugadorMano y: jugadorPie.
	
	ronda primerEnfrentamientoJuegaElJugador: jugadorMano conLaCarta: cartaMano2 contra: jugadorPie conLaCarta: cartaPie2.
	ronda segundoEnfrentamientoJuegaElJugador: jugadorMano conLaCarta: cartaMano2 contra: jugadorPie conLaCarta: cartaPie2.

	self assert: (ronda ganoPrimerEnfrentamiento: jugadorMano).
	self assert: (ronda ganoSegundoEnfrentamiento: jugadorMano).
	self assert: (ronda ganoLaPartida: jugadorMano).



	

	! !

!CartaDeTrucoTest methodsFor: 'test - ronda' stamp: 'CS 7/5/2021 20:48:06'!
test27GanaDosEnfrentamientosAlternadosElQueEraManoYGanaLaPartida

	| cartaMano1 cartaMano2 cartaMano3 cartaPie1 cartaPie2 cartaPie3 jugadorMano jugadorPie ronda |
	
	cartaMano1 := CartaDeTruco anchoDeBasto.
	cartaMano2 := CartaDeTruco anchoDeEspada.
	cartaMano3 := CartaDeTruco oroCon: 6.

	cartaPie1 := CartaDeTruco bastoCon: 3.
	cartaPie2 := CartaDeTruco oroCon: 2.
	cartaPie3 := CartaDeTruco copaCon: 3.
	
	jugadorMano := Jugador primerCarta: cartaMano1 segundaCarta: cartaMano2 yTerceraCarta: cartaMano3.
	jugadorPie := Jugador primerCarta: cartaPie1 segundaCarta: cartaPie2 yTerceraCarta: cartaPie3.

	ronda := Ronda entre: jugadorMano y: jugadorPie.
	
	ronda primerEnfrentamientoJuegaElJugador: jugadorMano conLaCarta: cartaMano2 contra: jugadorPie conLaCarta: cartaPie2.
	ronda segundoEnfrentamientoJuegaElJugador: jugadorMano conLaCarta: cartaMano3 contra: jugadorPie conLaCarta: cartaPie3.
	ronda tercerEnfrentamientoJuegaElJugador: jugadorPie conLaCarta: cartaPie1 contra: jugadorMano conLaCarta: cartaMano1.

	self assert: (ronda ganoPrimerEnfrentamiento: jugadorMano).
	self deny: (ronda ganoSegundoEnfrentamiento: jugadorMano).
	self assert: (ronda ganoTercerEnfrentamiento: jugadorMano).

	self assert: (ronda ganoLaPartida: jugadorMano).



	

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


!classDefinition: #Jugador category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #Jugador
	instanceVariableNames: 'primerCarta segundaCarta terceraCarta cartas puntaje'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Jugador methodsFor: 'inicializacion' stamp: 'CS 7/5/2021 20:38:34'!
initializePrimerCarta: carta1 segundaCarta: carta2 yTerceraCarta: carta3 

	primerCarta := carta1.
	segundaCarta := carta2.
	terceraCarta := carta3.
	
	cartas := OrderedCollection new.
	cartas add: primerCarta.
	cartas add: segundaCarta.
	cartas add: terceraCarta.
	
	puntaje := 0.! !


!Jugador methodsFor: 'cartas' stamp: 'CS 7/5/2021 18:51:53'!
cartas

	^ cartas ! !


!Jugador methodsFor: 'puntaje' stamp: 'CS 7/5/2021 20:36:24'!
incrementarPuntaje

	puntaje := puntaje + 1! !

!Jugador methodsFor: 'puntaje' stamp: 'CS 7/5/2021 20:35:53'!
puntaje

	^ puntaje! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Jugador class' category: 'ISW1-2021-1C-2doParcial'!
Jugador class
	instanceVariableNames: ''!

!Jugador class methodsFor: 'creaciones de instancias' stamp: 'CS 7/5/2021 19:27:13'!
primerCarta: carta1 segundaCarta: carta2 yTerceraCarta: carta3 

	| cartas |
	cartas := Bag new.
	cartas add: carta1.
	cartas add: carta2.
	cartas add: carta3.
	
	(cartas anySatisfy: [ :carta | (cartas occurrencesOf: carta) > 1]) ifTrue: [ ^ self error: self unJugadorNoPuedeTenerCartasRepetidasDescripcionDeError].

	^self new initializePrimerCarta: carta1 segundaCarta: carta2 yTerceraCarta: carta3 ! !


!Jugador class methodsFor: 'descripciones de errores' stamp: 'CS 7/5/2021 19:25:29'!
unJugadorNoPuedeTenerCartasRepetidasDescripcionDeError

	^ 'Un jugador no puede tener cartas repetidas'! !


!classDefinition: #Ronda category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #Ronda
	instanceVariableNames: 'jugadorUno jugadorDos primerEnfrentamiento segundoEnfrentamiento jugadores tercerEnfrentamiento'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Ronda methodsFor: 'initialization' stamp: 'CS 7/5/2021 20:46:24'!
initializeEntre: jugador1 y: jugador2 

	jugadorUno := jugador1.
	jugadorDos := jugador2.
	jugadores := OrderedCollection new.
	jugadores add: jugador1.
	jugadores add: jugador2.

	primerEnfrentamiento := Dictionary new.
	segundoEnfrentamiento := Dictionary new.
	tercerEnfrentamiento := Dictionary new.! !


!Ronda methodsFor: 'segundo enfrentamiento' stamp: 'CS 7/5/2021 20:33:51'!
ganoSegundoEnfrentamiento: jugador

	^ (segundoEnfrentamiento at: jugador).! !

!Ronda methodsFor: 'segundo enfrentamiento' stamp: 'CS 7/5/2021 20:37:51'!
segundoEnfrentamientoJuegaElJugador: jugador1 conLaCarta: cartaDelJugador1 contra: jugador2 conLaCarta: cartaDelJugador2 

	(primerEnfrentamiento at: jugador1) ifFalse: [ ^ self error: self class noLeTocabaElTurnoAElDescripcionDeError].

	segundoEnfrentamiento at: jugador1 put: (cartaDelJugador1 mataA: cartaDelJugador2).
	segundoEnfrentamiento at: jugador2 put: (cartaDelJugador2 mataA: cartaDelJugador1).

	(cartaDelJugador1 mataA: cartaDelJugador2) ifTrue: [jugador1 incrementarPuntaje] ifFalse: [jugador2 incrementarPuntaje]! !


!Ronda methodsFor: 'primer enfrentamiento' stamp: 'CS 7/5/2021 20:22:23'!
ganoPrimerEnfrentamiento: jugador 

	^ (primerEnfrentamiento at: jugador).! !

!Ronda methodsFor: 'primer enfrentamiento' stamp: 'CS 7/5/2021 20:37:39'!
primerEnfrentamientoJuegaElJugador: jugador1 conLaCarta: cartaDelJugador1 contra: jugador2 conLaCarta: cartaDelJugador2 

	primerEnfrentamiento at: jugador1 put: (cartaDelJugador1 mataA: cartaDelJugador2).
	primerEnfrentamiento at: jugador2 put: (cartaDelJugador2 mataA: cartaDelJugador1).
	
	(cartaDelJugador1 mataA: cartaDelJugador2) ifTrue: [jugador1 incrementarPuntaje] ifFalse: [jugador2 incrementarPuntaje]! !


!Ronda methodsFor: 'ganador' stamp: 'CS 7/5/2021 20:41:11'!
ganoLaPartida: jugador 

	^ (jugador puntaje) >= 2.! !


!Ronda methodsFor: 'tercer enfrentamiento' stamp: 'CS 7/5/2021 20:47:02'!
ganoTercerEnfrentamiento: jugador

	^ (tercerEnfrentamiento at: jugador).! !

!Ronda methodsFor: 'tercer enfrentamiento' stamp: 'CS 7/5/2021 20:46:00'!
tercerEnfrentamientoJuegaElJugador: jugador1 conLaCarta: cartaDelJugador1 contra: jugador2 conLaCarta: cartaDelJugador2 

	(segundoEnfrentamiento at: jugador1) ifFalse: [ ^ self error: self class noLeTocabaElTurnoAElDescripcionDeError].

	tercerEnfrentamiento at: jugador1 put: (cartaDelJugador1 mataA: cartaDelJugador2).
	tercerEnfrentamiento at: jugador2 put: (cartaDelJugador2 mataA: cartaDelJugador1).

	(cartaDelJugador1 mataA: cartaDelJugador2) ifTrue: [jugador1 incrementarPuntaje] ifFalse: [jugador2 incrementarPuntaje]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ronda class' category: 'ISW1-2021-1C-2doParcial'!
Ronda class
	instanceVariableNames: ''!

!Ronda class methodsFor: 'creaciones de instancias' stamp: 'CS 7/5/2021 19:21:22'!
entre: jugador1 y: jugador2 

	((jugador1 cartas) anySatisfy: [ :carta | (jugador2 cartas) includes: carta]) ifTrue: [ ^ self error: self noSePuedeTenerCartasRepetidasEntreJugadoresDescripcionDeError].
	
	^self new initializeEntre: jugador1 y: jugador2.! !


!Ronda class methodsFor: 'descripciones de errores' stamp: 'CS 7/5/2021 20:28:24'!
noLeTocabaElTurnoAElDescripcionDeError

	^ 'No le tocaba el turno a el'! !

!Ronda class methodsFor: 'descripciones de errores' stamp: 'CS 7/5/2021 19:21:22'!
noSePuedeTenerCartasRepetidasEntreJugadoresDescripcionDeError

	^ 'No se pueden tener cartas repetidas entre jugadores'! !
