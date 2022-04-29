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


!classDefinition: #RondaDeTrucoTest category: 'ISW1-2021-1C-2doParcial'!
TestCase subclass: #RondaDeTrucoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!


!RondaDeTrucoTest methodsFor: 'orden de juego' stamp: 'BAG 7/5/2021 21:28:32'!
test06ElJugadorManoDebeComenzarPrimero
	| jugadorMano jugadorPie ronda |
	
	jugadorMano := Jugador con:{CartaDeTruco anchoDeBasto. CartaDeTruco anchoDeEspada. CartaDeTruco sieteDeEspada.} .
	jugadorPie := Jugador con:{CartaDeTruco sieteDeOro . CartaDeTruco oroCon: 3. CartaDeTruco bastoCon: 4.} .
	
	ronda:=RondaDeTruco comienzaConMano: jugadorMano yPie: jugadorPie.
	
	self assert: jugadorMano equals: ronda juegaPrimero.! !

!RondaDeTrucoTest methodsFor: 'orden de juego' stamp: 'BAG 7/5/2021 21:28:39'!
test07SiElJugadorManoGanaElPrimerEnfrentamientoJuegaDevueltaPrimero
	| jugadorMano jugadorPie ronda primerEnfrentamiento |
	
	jugadorMano := Jugador con: {CartaDeTruco anchoDeBasto. CartaDeTruco anchoDeEspada. CartaDeTruco sieteDeEspada.} .
	jugadorPie := Jugador con: {CartaDeTruco sieteDeOro . CartaDeTruco oroCon: 3. CartaDeTruco bastoCon: 4.}  .
	
	ronda:=RondaDeTruco comienzaConMano: jugadorMano yPie: jugadorPie.
	
	primerEnfrentamiento := ronda jugar.
	
	self assert: jugadorMano equals: primerEnfrentamiento ganador.
	self assert: jugadorMano equals: ronda juegaPrimero.
	self assert: jugadorPie cantidadDeCartas equals: 2.
	self assert: jugadorMano cantidadDeCartas equals: 2.! !

!RondaDeTrucoTest methodsFor: 'orden de juego' stamp: 'BAG 7/5/2021 21:28:46'!
test08SiElJugadorManoGanaElPrimerEnfrentamientoJuegaDevueltaPrimero
	| jugadorMano jugadorPie ronda primerEnfrentamiento |
	
	jugadorPie := Jugador con: {CartaDeTruco anchoDeBasto. CartaDeTruco anchoDeEspada. CartaDeTruco sieteDeEspada.} .
	jugadorMano := Jugador con: {CartaDeTruco sieteDeOro . CartaDeTruco oroCon: 3. CartaDeTruco bastoCon: 4.}  .
	
	ronda:=RondaDeTruco comienzaConMano: jugadorMano yPie: jugadorPie.
	
	primerEnfrentamiento := ronda jugar.
	
	self assert: jugadorPie equals: primerEnfrentamiento ganador.
	self assert: jugadorPie equals: ronda juegaPrimero.
	self assert: jugadorPie cantidadDeCartas equals: 2.
	self assert: jugadorMano cantidadDeCartas equals: 2.! !

!RondaDeTrucoTest methodsFor: 'orden de juego' stamp: 'BAG 7/5/2021 21:28:53'!
test09SiElPrimerEnfrentamientoEsPardoSigueLaMano
	| jugadorMano jugadorPie ronda primerEnfrentamiento |
	
	jugadorPie := Jugador con: {CartaDeTruco copaCon: 3.CartaDeTruco anchoDeBasto. CartaDeTruco anchoDeEspada.} .
	jugadorMano := Jugador con: {CartaDeTruco oroCon: 3.CartaDeTruco sieteDeOro . CartaDeTruco bastoCon: 4.}  .
	
	ronda:=RondaDeTruco comienzaConMano: jugadorMano yPie: jugadorPie.
	
	primerEnfrentamiento := ronda jugar.
	
	self assert: primerEnfrentamiento esPardo.
	self assert: jugadorMano equals: ronda juegaPrimero.
	self assert: jugadorPie cantidadDeCartas equals: 2.
	self assert: jugadorMano cantidadDeCartas equals: 2.! !

!RondaDeTrucoTest methodsFor: 'orden de juego' stamp: 'BAG 7/5/2021 21:28:58'!
test10SiGanaLosDosPrimerosEnfrentamientosGanaLaRonda
	| jugadorMano jugadorPie ronda primerEnfrentamiento segundoEnfrentamiento |
	
	jugadorPie := Jugador con: {CartaDeTruco anchoDeBasto. CartaDeTruco anchoDeEspada. CartaDeTruco copaCon: 3.} .
	jugadorMano := Jugador con: {CartaDeTruco oroCon: 3.CartaDeTruco sieteDeOro . CartaDeTruco bastoCon: 4.}  .
	
	ronda:=RondaDeTruco comienzaConMano: jugadorMano yPie: jugadorPie.
	
	primerEnfrentamiento := ronda jugar.
	segundoEnfrentamiento := ronda jugar.
	
	self deny: primerEnfrentamiento esPardo.
	self assert: jugadorPie equals: primerEnfrentamiento ganador.
	self assert: jugadorPie equals: segundoEnfrentamiento ganador.
	self assert: jugadorPie equals: ronda ganador.
	self assert: jugadorPie cantidadDeCartas equals: 1.
	self assert: jugadorMano cantidadDeCartas equals: 1.! !

!RondaDeTrucoTest methodsFor: 'orden de juego' stamp: 'BAG 7/5/2021 21:29:06'!
test11SiSeJugoUnEnfrentamientoNoHayGanador
	| jugadorMano jugadorPie ronda primerEnfrentamiento |
	
	jugadorPie := Jugador con: {CartaDeTruco anchoDeBasto. CartaDeTruco anchoDeEspada. CartaDeTruco copaCon: 3.} .
	jugadorMano := Jugador con: {CartaDeTruco oroCon: 3.CartaDeTruco sieteDeOro . CartaDeTruco bastoCon: 4.}  .
	
	ronda:=RondaDeTruco comienzaConMano: jugadorMano yPie: jugadorPie.
	
	primerEnfrentamiento := ronda jugar.
	
	self deny: primerEnfrentamiento esPardo.
	self assert: jugadorPie equals: primerEnfrentamiento ganador.
	self should: [ ronda ganador]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
		self assert: anError messageText equals: RondaDeTruco noHayUnGanadorAunDescripcionDeError.
		self assert: jugadorPie cantidadDeCartas equals: 2.
		self assert: jugadorMano cantidadDeCartas equals: 2.
		]! !

!RondaDeTrucoTest methodsFor: 'orden de juego' stamp: 'BAG 7/5/2021 21:29:15'!
test12SiGanaElPrimeroYElUltimoEsElGanador
	| jugadorMano jugadorPie ronda primerEnfrentamiento segundoEnfrentamiento tercerEnfrentamiento |
	
	jugadorPie := Jugador con: {CartaDeTruco anchoDeBasto. CartaDeTruco copaCon: 3. CartaDeTruco anchoDeEspada.} .
	jugadorMano := Jugador con: {CartaDeTruco sieteDeOro .CartaDeTruco oroCon: 3. CartaDeTruco bastoCon: 4.}  .
	
	ronda:=RondaDeTruco comienzaConMano: jugadorMano yPie: jugadorPie.
	
	primerEnfrentamiento := ronda jugar.
	segundoEnfrentamiento := ronda jugar.
	tercerEnfrentamiento := ronda jugar.
	
	self deny: primerEnfrentamiento esPardo.
	self assert: jugadorPie equals: primerEnfrentamiento ganador.
	self assert: segundoEnfrentamiento esPardo.
	self assert: jugadorPie equals: tercerEnfrentamiento ganador.
	self assert: jugadorPie equals: ronda ganador.
	self assert: jugadorPie cantidadDeCartas equals: 0.
	self assert: jugadorMano cantidadDeCartas equals: 0.! !

!RondaDeTrucoTest methodsFor: 'orden de juego' stamp: 'BAG 7/5/2021 21:29:21'!
test13SiElPrimerEnfrentamientoEsPardoElQueGanaElSegundoGanaLaRonda
	| jugadorMano jugadorPie ronda primerEnfrentamiento segundoEnfrentamiento |
	
	jugadorPie := Jugador con: { CartaDeTruco copaCon: 3. CartaDeTruco sieteDeOro . CartaDeTruco anchoDeEspada.} .
	jugadorMano := Jugador con: {CartaDeTruco oroCon: 3. CartaDeTruco anchoDeBasto. CartaDeTruco bastoCon: 4.}  .
	
	ronda:=RondaDeTruco comienzaConMano: jugadorMano yPie: jugadorPie.
	
	primerEnfrentamiento := ronda jugar.
	segundoEnfrentamiento := ronda jugar.
	
	self assert: primerEnfrentamiento esPardo.
	self deny: segundoEnfrentamiento esPardo.
	self assert: jugadorMano equals: segundoEnfrentamiento ganador.
	self assert: jugadorMano equals: ronda ganador.
	self assert: jugadorPie cantidadDeCartas equals: 1.
	self assert: jugadorMano cantidadDeCartas equals: 1.! !

!RondaDeTrucoTest methodsFor: 'orden de juego' stamp: 'BAG 7/5/2021 21:29:26'!
test14SiYaHayUnGanadorNoSePuedeSeguirJugando
	| jugadorMano jugadorPie ronda primerEnfrentamiento segundoEnfrentamiento |
	
	jugadorPie := Jugador con: { CartaDeTruco copaCon: 3. CartaDeTruco sieteDeOro . CartaDeTruco anchoDeEspada.} .
	jugadorMano := Jugador con: {CartaDeTruco oroCon: 3. CartaDeTruco anchoDeBasto. CartaDeTruco bastoCon: 4.}  .
	
	ronda:=RondaDeTruco comienzaConMano: jugadorMano yPie: jugadorPie.
	
	primerEnfrentamiento := ronda jugar.
	segundoEnfrentamiento := ronda jugar.
	
	self assert: primerEnfrentamiento esPardo.
	self deny: segundoEnfrentamiento esPardo.
	self assert: jugadorMano equals: segundoEnfrentamiento ganador.
	self assert: jugadorMano equals: ronda ganador.
	
	self should: [ronda jugar]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: RondaDeTruco noSePuedeSeguirJugandoCuandoHayUnGanador.
		self assert: jugadorPie cantidadDeCartas equals: 1.
		self assert: jugadorMano cantidadDeCartas equals: 1.
		].! !


!RondaDeTrucoTest methodsFor: 'juegos validos' stamp: 'BAG 7/5/2021 21:27:56'!
test01ElJugadorManoSoloDebeTener3Cartas 
	
	| jugadorMano jugadorPie |
	jugadorMano := Jugador con: {CartaDeTruco anchoDeBasto. CartaDeTruco anchoDeEspada. CartaDeTruco sieteDeEspada. CartaDeTruco sieteDeEspada.}.
	jugadorPie := Jugador con: {CartaDeTruco sieteDeOro . CartaDeTruco bastoCon: 4. CartaDeTruco oroCon: 3. CartaDeTruco sieteDeEspada.}.
	
	self should: [RondaDeTruco comienzaConMano: jugadorMano yPie: jugadorPie]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: RondaDeTruco algunJugadorNoTiene3CartasDescripcionDeError.
		].! !

!RondaDeTrucoTest methodsFor: 'juegos validos' stamp: 'BAG 7/5/2021 21:28:03'!
test02ElJugadorPieSoloDebeTener3Cartas 
	
	| jugadorMano jugadorPie |
	jugadorMano := Jugador con:{CartaDeTruco anchoDeBasto. CartaDeTruco anchoDeEspada. CartaDeTruco sieteDeEspada.} .
	jugadorPie := Jugador con:{CartaDeTruco sieteDeOro . CartaDeTruco bastoCon: 4. CartaDeTruco oroCon: 3. CartaDeTruco copaCon: 4.} .
	
	self should: [RondaDeTruco comienzaConMano: jugadorMano yPie: jugadorPie]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: RondaDeTruco algunJugadorNoTiene3CartasDescripcionDeError.
		].! !

!RondaDeTrucoTest methodsFor: 'juegos validos' stamp: 'BAG 7/5/2021 21:28:10'!
test03ElJugadorManoNoDebeTenerCartasRepetidas
	
	| jugadorMano jugadorPie |
	jugadorMano := Jugador con: {CartaDeTruco anchoDeBasto. CartaDeTruco anchoDeEspada. CartaDeTruco anchoDeEspada.} .
	jugadorPie := Jugador con: {CartaDeTruco sieteDeOro . CartaDeTruco bastoCon: 4. CartaDeTruco oroCon: 3.} .
	
	self should: [RondaDeTruco comienzaConMano: jugadorMano yPie: jugadorPie]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: RondaDeTruco noSePuedeJugarConMasDeUnMazoDescripcionDeError.
		].! !

!RondaDeTrucoTest methodsFor: 'juegos validos' stamp: 'BAG 7/5/2021 21:28:17'!
test04ElJugadorPieNoDebeTenerCartasRepetidas
	
	| jugadorMano jugadorPie |
	jugadorMano := Jugador con: {CartaDeTruco anchoDeBasto. CartaDeTruco anchoDeEspada. CartaDeTruco sieteDeEspada.} .
	jugadorPie := Jugador con: {CartaDeTruco sieteDeOro . CartaDeTruco oroCon: 3. CartaDeTruco oroCon: 3.} .
	
	self should: [RondaDeTruco comienzaConMano: jugadorMano yPie: jugadorPie]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: RondaDeTruco noSePuedeJugarConMasDeUnMazoDescripcionDeError.
		].! !

!RondaDeTrucoTest methodsFor: 'juegos validos' stamp: 'BAG 7/5/2021 21:28:24'!
test05NoDebeHaberCartasRepetidasEntreJugadores
	
	| jugadorMano jugadorPie |
	jugadorMano := Jugador con: {CartaDeTruco anchoDeBasto. CartaDeTruco anchoDeEspada. CartaDeTruco sieteDeEspada.} .
	jugadorPie := Jugador con: {CartaDeTruco sieteDeOro . CartaDeTruco sieteDeEspada. CartaDeTruco anchoDeEspada.} .
	
	self should: [RondaDeTruco comienzaConMano: jugadorMano yPie: jugadorPie]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: RondaDeTruco noSePuedeJugarConMasDeUnMazoDescripcionDeError.
		].! !


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
	instanceVariableNames: 'cartas victorias'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Jugador methodsFor: 'operaciones' stamp: 'BAG 7/5/2021 20:51:39'!
incrementarVictorias
	
	victorias := victorias +1.! !


!Jugador methodsFor: 'testing' stamp: 'BAG 7/5/2021 19:53:00'!
cantidadDeCartas
	
	^cartas size! !

!Jugador methodsFor: 'testing' stamp: 'BAG 7/5/2021 19:36:31'!
juegaCon: cantidadDeCartas
	^cantidadDeCartas = cartas size! !

!Jugador methodsFor: 'testing' stamp: 'BAG 7/5/2021 19:27:49'!
noTieneCartasDe: unaColeccionDeCartas
	^unaColeccionDeCartas noneSatisfy: [:carta | cartas includes: carta].
	! !

!Jugador methodsFor: 'testing' stamp: 'BAG 7/5/2021 19:37:08'!
noTieneCartasRepetidas 
	^cartas allSatisfy: [:carta | (cartas occurrencesOf: carta) = 1] ! !


!Jugador methodsFor: 'accesing' stamp: 'BAG 7/5/2021 19:25:56'!
cartas
	
	^cartas! !

!Jugador methodsFor: 'accesing' stamp: 'BAG 7/5/2021 20:51:25'!
victorias
	
	^victorias! !


!Jugador methodsFor: 'initialization' stamp: 'BAG 7/5/2021 21:41:04'!
initializeCon: unaColeccionDeCartas
	cartas := unaColeccionDeCartas asOrderedCollection .
	victorias:=0. ! !


!Jugador methodsFor: 'jugar' stamp: 'BAG 7/5/2021 21:35:39'!
esUnJuegoPardoContra: unJugador
	^self jugarCarta empardaCon: unJugador jugarCarta ! !

!Jugador methodsFor: 'jugar' stamp: 'BAG 7/5/2021 21:35:22'!
juegaUnaCarta
	| cartaAJugar |
	cartaAJugar := self jugarCarta.
	cartas remove: cartaAJugar.
	
	^cartaAJugar ! !

!Jugador methodsFor: 'jugar' stamp: 'BAG 7/5/2021 21:35:22'!
jugarCarta

	^ cartas first! !

!Jugador methodsFor: 'jugar' stamp: 'BAG 7/5/2021 21:53:06'!
jugarContra: unJugador enEnfrentamiento: unEnfrentamiento
	| primerCarta segundaCarta |
	primerCarta := self juegaUnaCarta.
	segundaCarta := unJugador juegaUnaCarta.
	
	( primerCarta empardaCon: segundaCarta) ifTrue:[unEnfrentamiento esUnEnfrentamientoPardo].
	(primerCarta mataA: segundaCarta) ifTrue:[
		unEnfrentamiento ganeYo: self. 
		self incrementarVictorias.
	] ifFalse:[	
		unJugador incrementarVictorias. 
		unEnfrentamiento ganeYo: unJugador
		]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Jugador class' category: 'ISW1-2021-1C-2doParcial'!
Jugador class
	instanceVariableNames: ''!

!Jugador class methodsFor: 'as yet unclassified' stamp: 'BAG 7/5/2021 19:21:57'!
con: unaColeccionDeCartas
	^self new initializeCon: unaColeccionDeCartas .! !


!classDefinition: #Truco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #Truco
	instanceVariableNames: 'juegaPrimero juegaSegundo ganador'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Truco methodsFor: 'accesing' stamp: 'BAG 7/5/2021 20:22:38'!
ganador
	^ganador! !

!Truco methodsFor: 'accesing' stamp: 'BAG 7/5/2021 20:14:53'!
juegaPrimero
	^juegaPrimero ! !


!Truco methodsFor: 'initialization' stamp: 'BAG 7/5/2021 20:20:26'!
comienza: unJugadorMano ySigue: unJugadorPie 
	juegaPrimero := unJugadorMano.
	juegaSegundo := unJugadorPie.! !


!Truco methodsFor: 'jugar' stamp: 'BAG 7/5/2021 20:16:24'!
jugar
	self subclassResponsibility ! !


!classDefinition: #Enfrentamiento category: 'ISW1-2021-1C-2doParcial'!
Truco subclass: #Enfrentamiento
	instanceVariableNames: 'esPardo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Enfrentamiento methodsFor: 'jugar' stamp: 'BAG 7/5/2021 21:38:15'!
ganeYo: unJugador
	ganador := unJugador.
	
	juegaSegundo = unJugador ifTrue:[juegaSegundo := juegaPrimero. juegaPrimero:= unJugador].
	
	! !

!Enfrentamiento methodsFor: 'jugar' stamp: 'BAG 7/5/2021 21:50:58'!
jugar
	juegaPrimero jugarContra: juegaSegundo enEnfrentamiento:self. 
	
	
	
	
	
	! !


!Enfrentamiento methodsFor: 'resultado' stamp: 'BAG 7/5/2021 20:42:24'!
esPardo
	esPardo ifNil: [esPardo := false].
	^esPardo ! !

!Enfrentamiento methodsFor: 'resultado' stamp: 'BAG 7/5/2021 21:50:35'!
esUnEnfrentamientoPardo
	esPardo := true.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Enfrentamiento class' category: 'ISW1-2021-1C-2doParcial'!
Enfrentamiento class
	instanceVariableNames: ''!

!Enfrentamiento class methodsFor: 'instance creation' stamp: 'BAG 7/5/2021 20:19:39'!
entre: unJugadorMano y: unJugadorPie 
	^self new comienza: unJugadorMano ySigue: unJugadorPie ! !


!classDefinition: #RondaDeTruco category: 'ISW1-2021-1C-2doParcial'!
Truco subclass: #RondaDeTruco
	instanceVariableNames: 'enfrentamientos hayGanador'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTruco methodsFor: 'validaciones' stamp: 'BAG 7/5/2021 21:26:57'!
assertHayGanador
	self hayGanador ifFalse:[self error: self class noHayUnGanadorAunDescripcionDeError ].! !

!RondaDeTruco methodsFor: 'validaciones' stamp: 'BAG 7/5/2021 19:44:36'!
esUnJugadorValido: unJugador
	(unJugador juegaCon: 3) ifFalse:[self error: self class algunJugadorNoTiene3CartasDescripcionDeError].
	(unJugador noTieneCartasRepetidas) ifFalse:[self error: self class noSePuedeJugarConMasDeUnMazoDescripcionDeError.]

	
	! !

!RondaDeTruco methodsFor: 'validaciones' stamp: 'BAG 7/5/2021 21:26:33'!
hayGanador

	^ juegaPrimero victorias = 2 or: juegaSegundo victorias = 2 or: hayGanador! !

!RondaDeTruco methodsFor: 'validaciones' stamp: 'BAG 7/5/2021 21:26:48'!
sePuedeSeguirJugando
	self hayGanador ifTrue:[self error: self class noSePuedeSeguirJugandoCuandoHayUnGanador ].! !

!RondaDeTruco methodsFor: 'validaciones' stamp: 'BAG 7/5/2021 19:43:08'!
sonValidosJugadorMano: unJugadorMano jugadorPie: unJugadorPie
	self esUnJugadorValido: unJugadorMano.
	self esUnJugadorValido: unJugadorPie.
	
	(unJugadorMano noTieneCartasDe:unJugadorPie cartas) ifFalse:[self error: self class noSePuedeJugarConMasDeUnMazoDescripcionDeError ].! !


!RondaDeTruco methodsFor: 'initialization' stamp: 'BAG 7/5/2021 21:25:35'!
comienza: unJugadorMano ySigue: unJugadorPie 
	self sonValidosJugadorMano: unJugadorMano jugadorPie: unJugadorPie.
		
	juegaPrimero := unJugadorMano.
	juegaSegundo := unJugadorPie.
	enfrentamientos:= OrderedCollection new.
	hayGanador := false.
	! !


!RondaDeTruco methodsFor: 'accessing' stamp: 'BAG 7/5/2021 21:20:21'!
ganador
	self assertHayGanador.
	hayGanador ifTrue:[^ganador].
	juegaPrimero victorias = 2 ifTrue:[^juegaPrimero].
	^juegaSegundo.! !

!RondaDeTruco methodsFor: 'accessing' stamp: 'BAG 7/5/2021 20:14:41'!
juegaPrimero
	^enfrentamientos size = 0 ifTrue:[ juegaPrimero ] ifFalse: [enfrentamientos last juegaPrimero].! !


!RondaDeTruco methodsFor: 'jugar' stamp: 'BAG 7/5/2021 21:24:15'!
jugar
	| enfrentamientoActual |
	self sePuedeSeguirJugando.
	
	enfrentamientoActual := (Enfrentamiento entre: juegaPrimero y: juegaSegundo).
	enfrentamientoActual jugar.
	enfrentamientos add: enfrentamientoActual. 
	
	(enfrentamientos first esPardo and: enfrentamientos size = 2) ifTrue: [ hayGanador := true. ganador := enfrentamientoActual ganador. ].
	
	^enfrentamientoActual. 
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RondaDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco class
	instanceVariableNames: ''!

!RondaDeTruco class methodsFor: 'instance creation' stamp: 'BAG 7/5/2021 21:40:45'!
comienzaConMano: unJugadorMano yPie: unJugadorPie 
	^self new comienza: unJugadorMano  ySigue: unJugadorPie! !


!RondaDeTruco class methodsFor: 'descripcion de errores' stamp: 'BAG 7/5/2021 18:01:56'!
algunJugadorNoTiene3CartasDescripcionDeError
	^'No se puede comenzar la ronda si algún jugador no tiene exactamente 3 cartas'! !

!RondaDeTruco class methodsFor: 'descripcion de errores' stamp: 'BAG 7/5/2021 20:56:32'!
noHayUnGanadorAunDescripcionDeError
	^'Todavía no hay un ganador en la ronda'! !

!RondaDeTruco class methodsFor: 'descripcion de errores' stamp: 'BAG 7/5/2021 18:19:50'!
noSePuedeJugarConMasDeUnMazoDescripcionDeError
	^'No se puede jugar con más de un mazo, en otras palabras, no puede haber cartas repetidas'! !

!RondaDeTruco class methodsFor: 'descripcion de errores' stamp: 'BAG 7/5/2021 21:23:05'!
noSePuedeSeguirJugandoCuandoHayUnGanador
	 ^'No se puede seguir jugando cuando hay un ganador'! !
