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


!classDefinition: #TrucoTest category: 'ISW1-2021-1C-2doParcial'!
TestCase subclass: #TrucoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!TrucoTest methodsFor: 'testing' stamp: 'LEC 7/5/2021 17:39:54'!
test01ElJuegoNoEmpiezaSiLosJugadoresNoTienen3Cartas

	| jugador1 jugador2 |
	jugador1 := Jugador conCartas:{}.
	jugador2 := Jugador conCartas:{}.	
	
	self should: [Truco mano:jugador1 pie:jugador2] 
		raise:Error
		withMessageText: Truco invalidAmountOfCardsErrorDescription.! !

!TrucoTest methodsFor: 'testing' stamp: 'LEC 7/5/2021 17:54:11'!
test02ElJugador1NoPuedeTenerCartasRepetidas

	| jugador1 jugador2 |
	jugador1 := Jugador conCartas:{CartaDeTruco bastoCon: 7 .  CartaDeTruco bastoCon: 7 . CartaDeTruco bastoCon: 7}.
	jugador2 := Jugador conCartas:{CartaDeTruco bastoCon: 3 .  CartaDeTruco bastoCon: 1 . CartaDeTruco bastoCon: 2}.	
	
	self should: [Truco mano:jugador1 pie:jugador2] 
		raise:Error
		withMessageText: Truco invalidHandErrorDescription.! !

!TrucoTest methodsFor: 'testing' stamp: 'LEC 7/5/2021 17:59:34'!
test03ElJugador2NoPuedeTenerCartasRepetidas

	| jugador1 jugador2 |
	jugador1 := Jugador conCartas:{CartaDeTruco bastoCon: 3 .  CartaDeTruco bastoCon: 1 . CartaDeTruco bastoCon: 2}.	
	jugador2 := Jugador conCartas:{CartaDeTruco bastoCon: 7 .  CartaDeTruco bastoCon: 7 . CartaDeTruco bastoCon: 7}.
	
	
	self should: [Truco mano:jugador1 pie:jugador2] 
		raise:Error
		withMessageText: Truco invalidHandErrorDescription.! !

!TrucoTest methodsFor: 'testing' stamp: 'LEC 7/5/2021 18:01:37'!
test04LosJugadoresNoRepitenCartasEntreEllos

	| jugador1 jugador2 |
	jugador1 := Jugador conCartas:{CartaDeTruco bastoCon: 1 .  CartaDeTruco bastoCon: 2 . CartaDeTruco bastoCon: 3}.	
	jugador2 := Jugador conCartas:{CartaDeTruco bastoCon: 1 .  CartaDeTruco bastoCon: 2 . CartaDeTruco bastoCon: 3}.
	
	
	self should: [Truco mano:jugador1 pie:jugador2] 
		raise:Error
		withMessageText: Truco invalidHandErrorDescription.! !

!TrucoTest methodsFor: 'testing' stamp: 'LEC 7/5/2021 18:12:06'!
test05Jugador1NoPuedeTirarUnaCartaQueNoLePertenece

	| jugador1 jugador2 truco |
	jugador1 := Jugador conCartas:{CartaDeTruco bastoCon: 1 .  CartaDeTruco bastoCon: 2 . CartaDeTruco bastoCon: 3}.	
	jugador2 := Jugador conCartas:{CartaDeTruco bastoCon: 4 .  CartaDeTruco bastoCon: 5 . CartaDeTruco bastoCon: 6}.
	
	
	truco := Truco mano:jugador1 pie:jugador2.
	
	self should: [truco jugador1Tira: (CartaDeTruco bastoCon: 12)] 
		raise:Error
		withMessageText: Truco elJugadorNoSePuedeCartearErrorDescription.
	! !

!TrucoTest methodsFor: 'testing' stamp: 'LEC 7/5/2021 18:45:15'!
test06elJugador1NoPuedeTirarDosVecesEnLaMismaRonda

	| jugador1 jugador2 truco |
	jugador1 := Jugador conCartas:(OrderedCollection with: (CartaDeTruco bastoCon: 1) with: (CartaDeTruco bastoCon: 2) with:( CartaDeTruco bastoCon: 3)).	.	
	jugador2 := Jugador conCartas:{CartaDeTruco bastoCon: 4 .  CartaDeTruco bastoCon: 5 . CartaDeTruco bastoCon: 6}.
	
	
	truco := Truco mano:jugador1 pie:jugador2.
	truco jugador1Tira: (CartaDeTruco bastoCon: 1).
	self should: [truco jugador1Tira: (CartaDeTruco bastoCon: 2).] 
		raise:Error
		withMessageText: Truco elJugadorNoSePuedeTirarFueraDeTurnoErrorDescription.
	! !

!TrucoTest methodsFor: 'testing' stamp: 'LEC 7/5/2021 18:47:07'!
test07ElJuegoSabeQuienGanoLaRonda1YNoDejaAlGanadorRepetirLaCarta

	| jugador1 jugador2 truco |
	jugador1 := Jugador conCartas:(OrderedCollection with: (CartaDeTruco bastoCon: 1) with: (CartaDeTruco bastoCon: 2) with:( CartaDeTruco bastoCon: 3)).	
	jugador2 := Jugador conCartas:(OrderedCollection with: (CartaDeTruco bastoCon: 4) with: (CartaDeTruco bastoCon: 5) with:( CartaDeTruco bastoCon: 6)).	.
	
	
	truco := Truco mano:jugador1 pie:jugador2.
	truco jugador1Tira: (CartaDeTruco bastoCon: 1).
	truco jugador2Tira: (CartaDeTruco bastoCon:4 ).
	self assert: (truco ganadorRonda:1) equals: jugador1 .
	self should: [truco jugador1Tira: (CartaDeTruco bastoCon:1 ).] 
		raise:Error
		withMessageText: Truco elJugadorNoSePuedeCartearErrorDescription .
	! !

!TrucoTest methodsFor: 'testing' stamp: 'LEC 7/5/2021 18:51:07'!
test08ElJuegoSabeQuienGanoLaRonda2YDejaTirarEnOrdenAlGanador

	| jugador1 jugador2 truco |
	jugador1 := Jugador conCartas:(OrderedCollection with: (CartaDeTruco bastoCon: 4) with: (CartaDeTruco bastoCon: 2) with:( CartaDeTruco bastoCon: 3)).	
	jugador2 := Jugador conCartas:(OrderedCollection with: (CartaDeTruco bastoCon: 1) with: (CartaDeTruco bastoCon: 5) with:( CartaDeTruco bastoCon: 6)).	

	truco := Truco mano:jugador1 pie:jugador2.
	truco jugador1Tira: (CartaDeTruco bastoCon: 4).
	truco jugador2Tira: (CartaDeTruco bastoCon: 1 ).
	
	truco jugador2Tira: (CartaDeTruco bastoCon:5 ).
	truco jugador1Tira: (CartaDeTruco bastoCon:2 ).
	self assert: (truco ganadorRonda:1) equals: jugador2 .
	self assert: (truco ganadorRonda:2) equals: jugador1 .
	
		
	! !

!TrucoTest methodsFor: 'testing' stamp: 'LEC 7/5/2021 21:47:43'!
test09NoSePuedePedirElGanadorDeUnaRondaNoJugadaOTerminada
	| jugador1 jugador2 truco |
	jugador1 := Jugador conCartas:(OrderedCollection with: (CartaDeTruco bastoCon: 4) with: (CartaDeTruco bastoCon: 2) with:( CartaDeTruco bastoCon: 3)).	
	jugador2 := Jugador conCartas:(OrderedCollection with: (CartaDeTruco bastoCon: 1) with: (CartaDeTruco bastoCon: 5) with:( CartaDeTruco bastoCon: 6)).	

	truco := Truco mano:jugador1 pie:jugador2.
	truco jugador1Tira: (CartaDeTruco bastoCon: 4).
	
	self should: [truco ganadorRonda:1] 
		raise:Error
		withMessageText: Truco rondaNoHechaErrorDescription .
	
	self should: [truco ganadorRonda:2] 
		raise:Error
		withMessageText: Truco rondaNoHechaErrorDescription  .

	self should: [truco ganadorRonda:3] 
		raise:Error
		withMessageText: Truco rondaNoHechaErrorDescription  .	
	
	
		
	! !

!TrucoTest methodsFor: 'testing' stamp: 'LEC 7/5/2021 20:01:53'!
test10ElPieNoPuedeEmpezarLaPartida
	| jugador1 jugador2 truco |
	jugador1 := Jugador conCartas:(OrderedCollection with: (CartaDeTruco bastoCon: 4) with: (CartaDeTruco bastoCon: 2) with:( CartaDeTruco bastoCon: 3)).	
	jugador2 := Jugador conCartas:(OrderedCollection with: (CartaDeTruco bastoCon: 1) with: (CartaDeTruco bastoCon: 5) with:( CartaDeTruco bastoCon: 6)).	

	truco := Truco mano:jugador1 pie:jugador2.
	
	
	self should: [truco jugador2Tira: (CartaDeTruco bastoCon: 1).] 
		raise:Error
		withMessageText: Truco noPuedeArrancarElPieErrorDescription .
	
	
		
	! !

!TrucoTest methodsFor: 'testing' stamp: 'LEC 7/5/2021 20:14:08'!
test11NoSePuedenTirarMasCartasSiLaPartidaTermino
	| jugador1 jugador2 truco |
	jugador1 := Jugador conCartas:(OrderedCollection with: (CartaDeTruco bastoCon: 1) with: (CartaDeTruco bastoCon: 2) with:( CartaDeTruco bastoCon: 3)).	
	jugador2 := Jugador conCartas:(OrderedCollection with: (CartaDeTruco bastoCon: 4) with: (CartaDeTruco bastoCon: 5) with:( CartaDeTruco bastoCon: 6)).	

	truco := Truco mano:jugador1 pie:jugador2.
	
	truco jugador1Tira: (CartaDeTruco bastoCon: 1).
	truco jugador2Tira: (CartaDeTruco bastoCon: 4 ).
	truco jugador1Tira: (CartaDeTruco bastoCon:2 ).
	truco jugador2Tira: (CartaDeTruco bastoCon:5 ).
	
	
	self should: [truco jugador1Tira: (CartaDeTruco bastoCon: 3).] 
		raise:Error
		withMessageText: Truco noPuedeTirarSiLaPartidaTerminoErrorDescription .
		
	self assert: truco ganadorPartida equals: jugador1 .
	
	
		
	! !

!TrucoTest methodsFor: 'testing' stamp: 'LEC 7/5/2021 20:48:39'!
test12NoSePuedePedirElGanadorSiLaPartidaNoTermino
	| jugador1 jugador2 truco |
	jugador1 := Jugador conCartas:(OrderedCollection with: (CartaDeTruco bastoCon: 1) with: (CartaDeTruco bastoCon: 2) with:( CartaDeTruco bastoCon: 3)).	
	jugador2 := Jugador conCartas:(OrderedCollection with: (CartaDeTruco bastoCon: 4) with: (CartaDeTruco bastoCon: 5) with:( CartaDeTruco bastoCon: 6)).	

	truco := Truco mano:jugador1 pie:jugador2.
	
	truco jugador1Tira: (CartaDeTruco bastoCon: 1).
	truco jugador2Tira: (CartaDeTruco bastoCon: 4 ).
	truco jugador1Tira: (CartaDeTruco bastoCon:2 ).
	
	
	
	self should: [truco ganadorPartida.] 
		raise:Error
		withMessageText: Truco noPuedePedirElGanadorSiNoTerminoLaPartidaErrorDescription .
		
	
	
	
		
	! !

!TrucoTest methodsFor: 'testing' stamp: 'LEC 7/5/2021 20:52:27'!
test13PardaGanaLaMejor
	| jugador1 jugador2 truco |
	jugador1 := Jugador conCartas:(OrderedCollection with: (CartaDeTruco oroCon: 4) with: (CartaDeTruco bastoCon: 2) with:( CartaDeTruco bastoCon: 3)).	
	jugador2 := Jugador conCartas:(OrderedCollection with: (CartaDeTruco bastoCon: 4) with: (CartaDeTruco bastoCon: 5) with:( CartaDeTruco bastoCon: 6)).	

	truco := Truco mano:jugador1 pie:jugador2.
	
	truco jugador1Tira: (CartaDeTruco oroCon: 4).
	truco jugador2Tira: (CartaDeTruco bastoCon: 4 ).
	truco jugador1Tira: (CartaDeTruco bastoCon:2 ).
	truco jugador2Tira: (CartaDeTruco bastoCon:5 ).
	

	self assert: truco hayGanador .
	self assert: truco ganadorPartida equals: jugador1.
	
		
	
	
	
		
	! !

!TrucoTest methodsFor: 'testing' stamp: 'LEC 7/5/2021 21:38:46'!
test14LaPartidaConcluye
	| jugador1 jugador2 truco |
	jugador1 := Jugador conCartas:(OrderedCollection with: (CartaDeTruco copaCon: 1) with: (CartaDeTruco bastoCon: 3) with:( CartaDeTruco bastoCon: 5)).	
	jugador2 := Jugador conCartas:(OrderedCollection with: (CartaDeTruco bastoCon: 2) with: (CartaDeTruco bastoCon: 4) with:( CartaDeTruco bastoCon: 6)).	

	truco := Truco mano:jugador1 pie:jugador2.
	
	truco jugador1Tira: (CartaDeTruco copaCon:1 ).
	truco jugador2Tira: (CartaDeTruco bastoCon:2 ).
	
	self should: [truco jugador1Tira: (CartaDeTruco bastoCon:3 ).] 
		raise:Error
		withMessageText: Truco  elJugadorNoSePuedeTirarFueraDeTurnoErrorDescription 

	.
	
		
	
	
	
		
	! !

!TrucoTest methodsFor: 'testing' stamp: 'LEC 7/5/2021 21:29:55'!
test15ElJugador1NoEmpiezaLaSegundaRondaSiPerdioLaPrimera
	| jugador1 jugador2 truco |
	jugador1 := Jugador conCartas:(OrderedCollection with: (CartaDeTruco copaCon: 1) with: (CartaDeTruco bastoCon: 3) with:( CartaDeTruco bastoCon: 5)).	
	jugador2 := Jugador conCartas:(OrderedCollection with: (CartaDeTruco bastoCon: 2) with: (CartaDeTruco bastoCon: 4) with:( CartaDeTruco bastoCon: 6)).	

	truco := Truco mano:jugador1 pie:jugador2.
	
	truco jugador1Tira: (CartaDeTruco copaCon:1 ).
	truco jugador2Tira: (CartaDeTruco bastoCon:2 ).
	
	self should: [truco jugador1Tira: (CartaDeTruco bastoCon:3 ).] 
		raise:Error
		withMessageText: Truco elJugadorNoSePuedeTirarFueraDeTurnoErrorDescription  .

	.
	
		
	
	
	
		
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
	instanceVariableNames: 'cartas cartas_CHANGE_ME'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Jugador methodsFor: 'cartas' stamp: 'LEC 7/5/2021 17:52:24'!
cartas

	^cartas! !


!Jugador methodsFor: 'inicializacion' stamp: 'LEC 7/5/2021 17:36:04'!
initializeConCartas: manoDeCartas

	cartas := manoDeCartas.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Jugador class' category: 'ISW1-2021-1C-2doParcial'!
Jugador class
	instanceVariableNames: ''!

!Jugador class methodsFor: 'instance creation' stamp: 'LEC 7/5/2021 17:35:08'!
conCartas: cartas
	
	^self new initializeConCartas: cartas! !


!classDefinition: #Truco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #Truco
	instanceVariableNames: 'mano pie cartasUsadasPorJugadores'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Truco methodsFor: 'tirar carta accion' stamp: 'LEC 7/5/2021 21:53:03'!
jugador1Tira: carta

	((self jugador: pie  ganoLaRonda: 1) and:[(self cantidadCartasUsadasPor: pie) = 1]) ifTrue:[self error: self class elJugadorNoSePuedeTirarFueraDeTurnoErrorDescription ] .
	self jugador: mano tira: carta
	
	
	! !

!Truco methodsFor: 'tirar carta accion' stamp: 'LEC 7/5/2021 20:09:43'!
jugador2Tira: carta

	((cartasUsadasPorJugadores at:mano) size isZero) ifTrue:[self error: self class noPuedeArrancarElPieErrorDescription ].
	self jugador: pie tira: carta
	! !

!Truco methodsFor: 'tirar carta accion' stamp: 'LEC 7/5/2021 21:14:34'!
jugador: unJugador tira: carta
	
	self assertingPuedeTirarCarta: carta elJugador: unJugador.
	self jugador: unJugador usaCarta: carta.
	! !

!Truco methodsFor: 'tirar carta accion' stamp: 'LEC 7/5/2021 19:30:39'!
jugador: jugador usaCarta: carta.

	
	(cartasUsadasPorJugadores at: jugador) add:carta.
	jugador cartas remove: carta
	! !


!Truco methodsFor: 'assertings' stamp: 'LEC 7/5/2021 21:14:33'!
assertingPuedeTirarCarta: carta elJugador: unJugador

	(unJugador cartas includes: carta) ifFalse:[self error: Truco elJugadorNoSePuedeCartearErrorDescription ].
	(self puedeTirar: unJugador)  ifFalse:[self error: Truco elJugadorNoSePuedeTirarFueraDeTurnoErrorDescription ].
	(self hayGanador) ifTrue:[self error: Truco noPuedeTirarSiLaPartidaTerminoErrorDescription ]! !

!Truco methodsFor: 'assertings' stamp: 'LEC 7/5/2021 21:53:03'!
puedeTirar:jugador

	^((cartasUsadasPorJugadores at: (self otroJugador:jugador)) size) >= ((cartasUsadasPorJugadores at: jugador) size) or:[(self ronda = 1 and:[jugador = pie]) or:[ self jugador: jugador ganoLaRonda: self ronda]]! !


!Truco methodsFor: 'testing' stamp: 'LEC 7/5/2021 21:53:03'!
hayGanador

	^((self rondasGanadasPor: mano) = 2) or:[(self rondasGanadasPor: pie) = 2] 
	or:[(self huboEmpateEnRonda: 1) 
		and:[(self jugador: mano ganoLaRonda: 2) 
			or: [self jugador: pie ganoLaRonda: 2]]]
	! !

!Truco methodsFor: 'testing' stamp: 'LEC 7/5/2021 21:53:03'!
rondasGanadasPor: jugador
	
	| ganadasJugador rondaQueVer |
	ganadasJugador := 0.
	rondaQueVer :=  1.
	(self ronda) timesRepeat: [
		(self jugador: jugador ganoLaRonda: rondaQueVer) 
			ifTrue:[ganadasJugador := ganadasJugador + 1] 	.
			rondaQueVer := rondaQueVer  + 1.
		].
	^ganadasJugador! !


!Truco methodsFor: 'estado juego/ronda' stamp: 'LEC 7/5/2021 21:16:07'!
ganadorPartida
	
	((self rondasGanadasPor: mano) = 2) ifTrue:[^mano].
	((self rondasGanadasPor: pie) = 2) ifTrue:[^pie].
	[^self ganadorRonda:2]
	on: Error
	do:[^self error: self class noPuedePedirElGanadorSiNoTerminoLaPartidaErrorDescription ]! !

!Truco methodsFor: 'estado juego/ronda' stamp: 'LEC 7/5/2021 21:47:43'!
ganadorRonda: numeroRonda
	
	| cartasJugadasJ1 cartasJugadasJ2 |
	cartasJugadasJ1 :=  cartasUsadasPorJugadores at: mano.
	cartasJugadasJ2 :=  cartasUsadasPorJugadores at: pie.
	
	[((cartasJugadasJ1 at: numeroRonda) mataA: (cartasJugadasJ2 at: numeroRonda))
		ifTrue:[^mano]
		ifFalse:[^pie]		
	]on: Error
	do:[self error: self class rondaNoHechaErrorDescription ]
	! !

!Truco methodsFor: 'estado juego/ronda' stamp: 'LEC 7/5/2021 21:00:26'!
huboEmpateEnRonda: unaRonda

	| primeraCartaJ1 primeraCartaJ2 |
	[ primeraCartaJ1 := (cartasUsadasPorJugadores at: mano) at: unaRonda.
	primeraCartaJ2 := (cartasUsadasPorJugadores at: pie) at: unaRonda.
	^(primeraCartaJ1) valor = (primeraCartaJ2 valor)
	] on:Error
	do:[^false]
	
	! !

!Truco methodsFor: 'estado juego/ronda' stamp: 'LEC 7/5/2021 21:53:03'!
jugador: jugador ganoLaRonda: unaRonda

	| cartasJugadasJ1 cartasJugadasJ2 |
	cartasJugadasJ1 := cartasUsadasPorJugadores at: jugador.
	cartasJugadasJ2 := cartasUsadasPorJugadores at: (self otroJugador: jugador) .
	
	[(cartasJugadasJ1 at: unaRonda) mataA: (cartasJugadasJ2 at:unaRonda) ]	
	on:Error
	do:[^false ].
	^(cartasJugadasJ1 at: unaRonda) mataA: (cartasJugadasJ2 at:unaRonda)
! !

!Truco methodsFor: 'estado juego/ronda' stamp: 'LEC 7/5/2021 21:12:33'!
jugadorGanadorRonda: unaRonda

	| cartasJugadasJ1 cartasJugadasJ2 |
	cartasJugadasJ1 := cartasUsadasPorJugadores at: mano.
	cartasJugadasJ2 := cartasUsadasPorJugadores at: pie .
	
	
	((cartasJugadasJ1 at: unaRonda) mataA: (cartasJugadasJ2 at:unaRonda))
		ifTrue:[^mano]
		ifFalse:[^pie]
! !

!Truco methodsFor: 'estado juego/ronda' stamp: 'LEC 7/5/2021 19:41:56'!
otroJugador: aJugador 
	
	aJugador = mano ifTrue:[^pie].
	^mano! !


!Truco methodsFor: 'inicializacion' stamp: 'LEC 7/5/2021 19:08:20'!
initializeCon: jugador1 y:jugador2

	mano := jugador1.
	pie := jugador2.
	cartasUsadasPorJugadores := Dictionary new.
	cartasUsadasPorJugadores at:mano put:OrderedCollection new .
	cartasUsadasPorJugadores at:pie put:OrderedCollection new.! !


!Truco methodsFor: 'ronda / cartas usadas' stamp: 'LEC 7/5/2021 21:43:22'!
cantidadCartasUsadasPor: jugador

     ^(cartasUsadasPorJugadores at: jugador) size! !

!Truco methodsFor: 'ronda / cartas usadas' stamp: 'LEC 7/5/2021 20:07:49'!
ronda

	^(OrderedCollection with:((cartasUsadasPorJugadores at:mano) size) with: ((cartasUsadasPorJugadores at:mano) size) with:1) max! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Truco class' category: 'ISW1-2021-1C-2doParcial'!
Truco class
	instanceVariableNames: ''!

!Truco class methodsFor: 'error handling' stamp: 'LEC 7/5/2021 18:14:40'!
elJugadorNoSePuedeCartearErrorDescription
	
	^'El jugador no tenia dicha carta antes de empezar el juego'! !

!Truco class methodsFor: 'error handling' stamp: 'LEC 7/5/2021 18:26:17'!
elJugadorNoSePuedeTirarFueraDeTurnoErrorDescription

	^'no es el turno del jugador'! !

!Truco class methodsFor: 'error handling' stamp: 'LEC 7/5/2021 17:36:36'!
invalidAmountOfCardsErrorDescription
	
	^'Cada jugador tiene que tener 3 cartas'! !

!Truco class methodsFor: 'error handling' stamp: 'LEC 7/5/2021 17:54:11'!
invalidHandErrorDescription
	
	^'Los jugadores no pueden tener cartas repetidas'! !

!Truco class methodsFor: 'error handling' stamp: 'LEC 7/5/2021 20:02:18'!
noPuedeArrancarElPieErrorDescription
	
	^'Tiene que arrancar jugando la mano'! !

!Truco class methodsFor: 'error handling' stamp: 'LEC 7/5/2021 20:49:07'!
noPuedePedirElGanadorSiNoTerminoLaPartidaErrorDescription
	
	^'Error partida aun no terminada'! !

!Truco class methodsFor: 'error handling' stamp: 'LEC 7/5/2021 20:23:46'!
noPuedeTirarSiLaPartidaTerminoErrorDescription
	^'No se puede tirar mas si la partida terminó'! !

!Truco class methodsFor: 'error handling' stamp: 'LEC 7/5/2021 21:47:43'!
rondaNoHechaErrorDescription
	
	^'La ronda pedida aun no empezó/terminó'! !


!Truco class methodsFor: 'instance creation' stamp: 'LEC 7/5/2021 18:13:02'!
mano:jugador1 pie:jugador2

	(self assertCantidadCorrectasCartas: jugador1 yJugador: jugador2) ifFalse:[	self error: self invalidAmountOfCardsErrorDescription ].
	((self tieneCartasRepetidasParaJugar: jugador1) or:[(self tieneCartasRepetidasParaJugar: jugador2) or:[self tieneCartasRepetidasEntre: jugador1 y:jugador2 ]]) ifTrue:[	self error: self invalidHandErrorDescription ].
	
	^self new initializeCon: jugador1 y:jugador2! !


!Truco class methodsFor: 'asserts' stamp: 'LEC 7/5/2021 17:51:44'!
assertCantidadCorrectasCartas: jugador1 yJugador: jugador2

	^jugador1 cartas size = 3 and:[jugador1 cartas size = 3]! !

!Truco class methodsFor: 'asserts' stamp: 'LEC 7/5/2021 18:06:52'!
tieneCartasRepetidasEntre: jugador1 y:jugador2

	^(jugador1 cartas asSet union: jugador2 cartas) size ~= 6! !

!Truco class methodsFor: 'asserts' stamp: 'LEC 7/5/2021 17:58:43'!
tieneCartasRepetidasParaJugar: jugador1

	^(jugador1 cartas size) ~= (jugador1 cartas asSet size)! !
