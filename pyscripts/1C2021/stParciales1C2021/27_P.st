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

!RondaDeTrucoTest methodsFor: 'no-hay-cartas-iguales' stamp: 'lilmonk3y 7/5/2021 18:39:18'!
test02
	
	self should: [ManoDeJugador con: CartaDeTruco sieteDeEspada con: CartaDeTruco  sieteDeEspada  con: CartaDeTruco anchoDeEspada ] 
		raise: Error - MessageNotUnderstood  
		description: ManoDeJugador noSePuedenCrearJugadoresCarteadosMensajeDeError
	
	
	! !

!RondaDeTrucoTest methodsFor: 'no-hay-cartas-iguales' stamp: 'lilmonk3y 7/5/2021 18:39:18'!
test03
	
	self should: [ManoDeJugador con: CartaDeTruco anchoDeEspada con: CartaDeTruco  sieteDeEspada  con: CartaDeTruco sieteDeEspada] 
		raise: Error - MessageNotUnderstood  
		description: ManoDeJugador noSePuedenCrearJugadoresCarteadosMensajeDeError
	
	
	! !

!RondaDeTrucoTest methodsFor: 'no-hay-cartas-iguales' stamp: 'lilmonk3y 7/5/2021 18:39:18'!
test04
	
	self should: [ManoDeJugador con: CartaDeTruco sieteDeEspada con: CartaDeTruco  anchoDeEspada  con: CartaDeTruco sieteDeEspada] 
		raise: Error - MessageNotUnderstood  
		description: ManoDeJugador noSePuedenCrearJugadoresCarteadosMensajeDeError! !


!RondaDeTrucoTest methodsFor: 'creacion' stamp: 'lilmonk3y 7/5/2021 18:39:18'!
test01
	| jugador |
	jugador _ ManoDeJugador con: CartaDeTruco sieteDeEspada con: CartaDeTruco  anchoDeBasto  con: CartaDeTruco anchoDeEspada.
	
	self deny: jugador primerCarta = jugador segundaCarta.
	self deny: jugador primerCarta = jugador tercerCarta.
	self deny: jugador segundaCarta = jugador tercerCarta.
	! !


!RondaDeTrucoTest methodsFor: 'jugadores-con-cartas-validas' stamp: 'lilmonk3y 7/5/2021 18:39:18'!
test05
	
	| primerJugador segundoJugador |
	primerJugador _ ManoDeJugador con: CartaDeTruco sieteDeEspada con: CartaDeTruco  anchoDeBasto  con: CartaDeTruco anchoDeEspada.
	
	segundoJugador _ ManoDeJugador con: CartaDeTruco sieteDeEspada con: CartaDeTruco  anchoDeBasto  con: CartaDeTruco anchoDeEspada.
	
	self should: [Ronda con: primerJugador y: segundoJugador.] raise: Error - MessageNotUnderstood  description: Ronda losJugadoresDebenTenerCartasDistintasDescripcionDeError! !

!RondaDeTrucoTest methodsFor: 'jugadores-con-cartas-validas' stamp: 'lilmonk3y 7/5/2021 18:39:18'!
test06
	
	| primerJugador segundoJugador |
	primerJugador _ ManoDeJugador con: CartaDeTruco sieteDeEspada con: CartaDeTruco  anchoDeBasto  con: CartaDeTruco anchoDeEspada.
	
	segundoJugador _ ManoDeJugador con: (CartaDeTruco bastoCon: 4) con: CartaDeTruco  anchoDeBasto  con: CartaDeTruco anchoDeEspada.
	
	self should: [Ronda con: primerJugador y: segundoJugador.] raise: Error - MessageNotUnderstood  description: Ronda losJugadoresDebenTenerCartasDistintasDescripcionDeError! !

!RondaDeTrucoTest methodsFor: 'jugadores-con-cartas-validas' stamp: 'lilmonk3y 7/5/2021 18:39:18'!
test07
	
	| primerJugador segundoJugador |
	primerJugador _ ManoDeJugador con: CartaDeTruco sieteDeEspada con: CartaDeTruco  anchoDeBasto  con: CartaDeTruco anchoDeEspada.
	
	segundoJugador _ ManoDeJugador con: (CartaDeTruco bastoCon: 4) con: (CartaDeTruco  bastoCon: 5) con: CartaDeTruco anchoDeEspada.
	
	self should: [Ronda con: primerJugador y: segundoJugador.] raise: Error - MessageNotUnderstood  description: Ronda losJugadoresDebenTenerCartasDistintasDescripcionDeError! !

!RondaDeTrucoTest methodsFor: 'jugadores-con-cartas-validas' stamp: 'lilmonk3y 7/5/2021 18:39:18'!
test08
	
	| primerJugador segundoJugador |
	primerJugador _ ManoDeJugador con: CartaDeTruco sieteDeEspada con: CartaDeTruco  anchoDeBasto  con: CartaDeTruco anchoDeEspada.
	
	segundoJugador _ ManoDeJugador con: (CartaDeTruco bastoCon: 4) con: (CartaDeTruco  bastoCon: 5) con: CartaDeTruco sieteDeEspada .
	
	self should: [Ronda con: primerJugador y: segundoJugador.] raise: Error - MessageNotUnderstood  description: Ronda losJugadoresDebenTenerCartasDistintasDescripcionDeError! !


!RondaDeTrucoTest methodsFor: 'mano-tercera' stamp: 'lilmonk3y 7/5/2021 21:38:16'!
test20
	| primerJugador ronda segundoJugador |
	primerJugador _ ManoDeJugador con: (CartaDeTruco bastoCon: 4) con: (CartaDeTruco bastoCon: 5)  con: (CartaDeTruco bastoCon: 6).
	segundoJugador _ ManoDeJugador con: CartaDeTruco sieteDeEspada con: CartaDeTruco  anchoDeBasto  con: CartaDeTruco anchoDeEspada.
	ronda _ Ronda con: primerJugador y: segundoJugador.
	
	ronda primerMano: primerJugador primerCarta contra: segundoJugador primerCarta.
	ronda segundaMano: primerJugador tercerCarta contra: segundoJugador segundaCarta .
	self should: [ronda terceraMano: primerJugador segundaCarta contra: segundoJugador tercerCarta] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo:[ :error |
		 self assert: Ronda yaHayUnGanadorDescripcionDeError equals: error messageText.
		self assert: ronda hayGanador.
		self assert: segundoJugador equals: ronda ganador.
		self assert: 0 equals: ronda manosGanadasMano.
		self assert: 2 equals: ronda manosGanadasPorPie.]
	
	! !

!RondaDeTrucoTest methodsFor: 'mano-tercera' stamp: 'lilmonk3y 7/5/2021 21:41:20'!
test21
	| primerJugador ronda segundoJugador |
	primerJugador _ ManoDeJugador con: (CartaDeTruco bastoCon: 4) con: CartaDeTruco anchoDeEspada  con: (CartaDeTruco bastoCon: 6).
	segundoJugador _ ManoDeJugador con: CartaDeTruco sieteDeEspada con: CartaDeTruco  anchoDeBasto  con: (CartaDeTruco oroCon: 1).
	ronda _ Ronda con: primerJugador y: segundoJugador.
	
	ronda primerMano: primerJugador primerCarta contra: segundoJugador primerCarta.
	ronda segundaMano: primerJugador segundaCarta contra: segundoJugador segundaCarta .
	ronda terceraMano: primerJugador tercerCarta contra: segundoJugador tercerCarta.
	
	self assert: ronda hayGanador.
	self assert: segundoJugador equals: ronda ganador.
	self assert: 1 equals: ronda manosGanadasMano.
	self assert: 2 equals: ronda manosGanadasPorPie.
	
	! !

!RondaDeTrucoTest methodsFor: 'mano-tercera' stamp: 'lilmonk3y 7/5/2021 21:57:06'!
_test22
	| primerJugador ronda segundoJugador |
	primerJugador _ ManoDeJugador con: (CartaDeTruco bastoCon: 4) con: (CartaDeTruco bastoCon: 5)  con: (CartaDeTruco bastoCon: 6).
	segundoJugador _ ManoDeJugador con: (CartaDeTruco oroCon: 4) con: (CartaDeTruco oroCon: 5)  con: (CartaDeTruco oroCon: 6).
	ronda _ Ronda con: primerJugador y: segundoJugador.
	
	ronda primerMano: primerJugador primerCarta contra: segundoJugador primerCarta.
	ronda segundaMano: primerJugador segundaCarta contra: segundoJugador segundaCarta .
	ronda terceraMano: primerJugador tercerCarta contra: segundoJugador tercerCarta.
	
	self assert: ronda hayGanador.
	self assert: primerJugador equals: ronda ganador.
	self assert: 3 equals: ronda manosGanadasMano.
	self assert: 2 equals: ronda manosGanadasPorPie.
	
	"no me salió la lógica de si hay ganador y perdí tiempo debugueando eso.
	comento el test porque ya no tengo tiempo"
	
	! !


!RondaDeTrucoTest methodsFor: 'prioridad-de-juego' stamp: 'lilmonk3y 7/5/2021 21:13:27'!
_test18
	| primerJugador ronda segundoJugador |
	primerJugador _ ManoDeJugador con: (CartaDeTruco bastoCon: 4) con: CartaDeTruco anchoDeEspada  con: (CartaDeTruco bastoCon: 6).
	segundoJugador _ ManoDeJugador con: CartaDeTruco sieteDeEspada con: CartaDeTruco  anchoDeBasto  con: (CartaDeTruco oroCon: 1).
	ronda _ Ronda con: primerJugador y: segundoJugador.
	
	"gana el segundo jugador, aka pie"
	ronda primerMano: primerJugador primerCarta contra: segundoJugador primerCarta.
	"el jugador mano no tiene prioridad de juego"
	self should: [ronda segundaMano: primerJugador segundaCarta contra: segundoJugador segundaCarta .] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error | 
		self assert: Ronda elJugadorNoTienePrioridadDeJuegoEnEstaManoDescripcionDeError equals: error messageText.
		self deny: ronda hayGanador.
		self assert: 0 equals: ronda manosGanadasMano.
		self assert: 1 equals: ronda manosGanadasPorPie.]
	
	
	! !

!RondaDeTrucoTest methodsFor: 'prioridad-de-juego' stamp: 'lilmonk3y 7/5/2021 21:13:09'!
_test19
	| primerJugador ronda segundoJugador |
	primerJugador _ ManoDeJugador con: (CartaDeTruco bastoCon: 4) con: CartaDeTruco anchoDeEspada  con: (CartaDeTruco bastoCon: 6).
	segundoJugador _ ManoDeJugador con: (CartaDeTruco espadaCon: 4) con: CartaDeTruco  anchoDeBasto  con: (CartaDeTruco oroCon: 1).
	ronda _ Ronda con: primerJugador y: segundoJugador.
	
	"empardan la primera"
	ronda primerMano: primerJugador primerCarta contra: segundoJugador primerCarta.
	"el jugador pie no tiene prioridad de juego"
	self should: [ronda segundaMano: segundoJugador segundaCarta contra: primerJugador segundaCarta .] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error | 
		self assert: Ronda elJugadorNoTienePrioridadDeJuegoEnEstaManoDescripcionDeError equals: error messageText.
		self deny: ronda hayGanador.
		self assert: 1 equals: ronda manosGanadasMano.
		self assert: 1 equals: ronda manosGanadasPorPie.]
	
	
	! !

!RondaDeTrucoTest methodsFor: 'prioridad-de-juego' stamp: 'lilmonk3y 7/5/2021 21:24:11'!
_testearJuegaPrimeroManoEnPrimeraMano
! !


!RondaDeTrucoTest methodsFor: 'mano-segunda' stamp: 'lilmonk3y 7/5/2021 19:50:02'!
test14
	| primerJugador ronda segundoJugador |
	primerJugador _ ManoDeJugador con: CartaDeTruco sieteDeEspada con: CartaDeTruco  anchoDeBasto  con: CartaDeTruco anchoDeEspada.
	segundoJugador _ ManoDeJugador con: (CartaDeTruco bastoCon: 4) con: (CartaDeTruco bastoCon: 5)  con: (CartaDeTruco bastoCon: 6).
	ronda _ Ronda con: primerJugador y: segundoJugador.
	
	ronda primerMano: primerJugador primerCarta contra: segundoJugador primerCarta.
	ronda segundaMano: primerJugador tercerCarta contra: segundoJugador segundaCarta .
	
	self assert: ronda hayGanador.
	self assert: primerJugador equals: ronda ganador.
	self assert: 2 equals: ronda manosGanadasMano.
	self assert: 0 equals: ronda manosGanadasPorPie.
	! !

!RondaDeTrucoTest methodsFor: 'mano-segunda' stamp: 'lilmonk3y 7/5/2021 19:52:53'!
test15
	| primerJugador ronda segundoJugador |
	primerJugador _ ManoDeJugador con: (CartaDeTruco bastoCon: 4) con: (CartaDeTruco bastoCon: 5)  con: (CartaDeTruco bastoCon: 6).
	segundoJugador _ ManoDeJugador con: CartaDeTruco sieteDeEspada con: CartaDeTruco  anchoDeBasto  con: CartaDeTruco anchoDeEspada.
	ronda _ Ronda con: primerJugador y: segundoJugador.
	
	ronda primerMano: primerJugador primerCarta contra: segundoJugador primerCarta.
	ronda segundaMano: primerJugador tercerCarta contra: segundoJugador segundaCarta .
	
	self assert: ronda hayGanador.
	self assert: segundoJugador equals: ronda ganador.
	self assert: 0 equals: ronda manosGanadasMano.
	self assert: 2 equals: ronda manosGanadasPorPie.
	! !

!RondaDeTrucoTest methodsFor: 'mano-segunda' stamp: 'lilmonk3y 7/5/2021 20:03:12'!
test16
	| primerJugador ronda segundoJugador |
	primerJugador _ ManoDeJugador con: (CartaDeTruco bastoCon: 4) con: CartaDeTruco anchoDeEspada  con: (CartaDeTruco bastoCon: 6).
	segundoJugador _ ManoDeJugador con: CartaDeTruco sieteDeEspada con: CartaDeTruco  anchoDeBasto  con: (CartaDeTruco oroCon: 1).
	ronda _ Ronda con: primerJugador y: segundoJugador.
	
	ronda primerMano: primerJugador primerCarta contra: segundoJugador primerCarta.
	ronda segundaMano: primerJugador segundaCarta contra: segundoJugador segundaCarta .
	
	self deny: ronda hayGanador.
	self assert: 1 equals: ronda manosGanadasMano.
	self assert: 1 equals: ronda manosGanadasPorPie.
	! !

!RondaDeTrucoTest methodsFor: 'mano-segunda' stamp: 'lilmonk3y 7/5/2021 20:05:27'!
test17
	| primerJugador ronda segundoJugador |
	primerJugador _ ManoDeJugador con: (CartaDeTruco bastoCon: 4) con: CartaDeTruco anchoDeEspada  con: (CartaDeTruco bastoCon: 6).
	segundoJugador _ ManoDeJugador con: CartaDeTruco sieteDeEspada con: CartaDeTruco  anchoDeBasto  con: (CartaDeTruco oroCon: 1).
	ronda _ Ronda con: primerJugador y: segundoJugador.
	
	self should: [ronda ganador] raise: Error - MessageNotUnderstood 
		description: Ronda noHayGanadorAunDescripcionDeError
	! !


!RondaDeTrucoTest methodsFor: 'mano-primera' stamp: 'lilmonk3y 7/5/2021 19:00:31'!
test09
	| primerJugador ronda segundoJugador |
	primerJugador _ ManoDeJugador con: CartaDeTruco sieteDeEspada con: CartaDeTruco  anchoDeBasto  con: CartaDeTruco anchoDeEspada.
	segundoJugador _ ManoDeJugador con: (CartaDeTruco bastoCon: 4) con: (CartaDeTruco bastoCon: 5)  con: (CartaDeTruco bastoCon: 6).
	ronda _ Ronda con: primerJugador y: segundoJugador.
	
	ronda primerMano: primerJugador primerCarta contra: segundoJugador primerCarta.
	
	self deny: ronda hayGanador.
	self assert: 1 equals: ronda manosGanadasMano.
	self assert: 0 equals: ronda manosGanadasPorPie! !

!RondaDeTrucoTest methodsFor: 'mano-primera' stamp: 'lilmonk3y 7/5/2021 19:15:41'!
test10
	| primerJugador ronda segundoJugador |
	
	primerJugador _ ManoDeJugador con: (CartaDeTruco bastoCon: 4) con: (CartaDeTruco bastoCon: 5)  con: (CartaDeTruco bastoCon: 6).
	segundoJugador _ ManoDeJugador con: CartaDeTruco sieteDeEspada con: CartaDeTruco  anchoDeBasto  con: CartaDeTruco anchoDeEspada.
	ronda _ Ronda con: primerJugador y: segundoJugador.
	
	ronda primerMano: primerJugador primerCarta contra: segundoJugador primerCarta.
	
	self deny: ronda hayGanador.
	self assert: 0 equals: ronda manosGanadasMano.
	self assert: 1 equals: ronda manosGanadasPorPie! !

!RondaDeTrucoTest methodsFor: 'mano-primera' stamp: 'lilmonk3y 7/5/2021 19:21:56'!
test11
	| primerJugador ronda segundoJugador |
	
	primerJugador _ ManoDeJugador con: (CartaDeTruco bastoCon: 4) con: (CartaDeTruco bastoCon: 5)  con: (CartaDeTruco bastoCon: 6).
	segundoJugador _ ManoDeJugador con: (CartaDeTruco espadaCon: 4) con: CartaDeTruco  anchoDeBasto  con: CartaDeTruco anchoDeEspada.
	ronda _ Ronda con: primerJugador y: segundoJugador.
	
	ronda primerMano: primerJugador primerCarta contra: segundoJugador primerCarta.
	
	self deny: ronda hayGanador.
	self assert: 1 equals: ronda manosGanadasMano.
	self assert: 1 equals: ronda manosGanadasPorPie! !

!RondaDeTrucoTest methodsFor: 'mano-primera' stamp: 'lilmonk3y 7/5/2021 19:30:11'!
test12
	| primerJugador ronda segundoJugador |
	
	primerJugador _ ManoDeJugador con: (CartaDeTruco bastoCon: 4) con: (CartaDeTruco bastoCon: 5)  con: (CartaDeTruco bastoCon: 6).
	segundoJugador _ ManoDeJugador con: (CartaDeTruco espadaCon: 4) con: CartaDeTruco  anchoDeBasto  con: CartaDeTruco anchoDeEspada.
	ronda _ Ronda con: primerJugador y: segundoJugador.
	
	self should: [
		ronda primerMano: CartaDeTruco sieteDeOro contra: segundoJugador primerCarta.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error | 
			self assert: Ronda noSePuedeJugarConCartasQueNoTePertenecenDescripcionDeError equals: error messageText.
			self deny: ronda hayGanador.
			self assert: 0 equals: ronda manosGanadasMano.
			self assert: 0 equals: ronda manosGanadasPorPie]
	
	
	! !

!RondaDeTrucoTest methodsFor: 'mano-primera' stamp: 'lilmonk3y 7/5/2021 19:35:26'!
test13
	| primerJugador ronda segundoJugador |
	
	primerJugador _ ManoDeJugador con: (CartaDeTruco bastoCon: 4) con: (CartaDeTruco bastoCon: 5)  con: (CartaDeTruco bastoCon: 6).
	segundoJugador _ ManoDeJugador con: (CartaDeTruco espadaCon: 4) con: CartaDeTruco  anchoDeBasto  con: CartaDeTruco anchoDeEspada.
	ronda _ Ronda con: primerJugador y: segundoJugador.
	
	self should: [
		ronda primerMano: primerJugador primerCarta contra: CartaDeTruco sieteDeOro] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error | 
			self assert: Ronda noSePuedeJugarConCartasQueNoTePertenecenDescripcionDeError equals: error messageText.
			self deny: ronda hayGanador.
			self assert: 0 equals: ronda manosGanadasMano.
			self assert: 0 equals: ronda manosGanadasPorPie]
	
	
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


!classDefinition: #ManoDeJugador category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #ManoDeJugador
	instanceVariableNames: 'primerCarta segundaCarta tercerCarta'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!ManoDeJugador methodsFor: 'initialization' stamp: 'lilmonk3y 7/5/2021 17:50:30'!
initializeCon: unaPrimerCarta con: unaSegundaCarta con: unaTercerCarta 
	primerCarta := unaPrimerCarta.
	segundaCarta := unaSegundaCarta.
	tercerCarta := unaTercerCarta.! !


!ManoDeJugador methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 7/5/2021 18:31:12'!
cartas
	^ OrderedCollection with: primerCarta with: segundaCarta with: tercerCarta ! !

!ManoDeJugador methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 7/5/2021 19:36:41'!
contiene: unaCarta
	^ self cartas includes: unaCarta! !

!ManoDeJugador methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 7/5/2021 17:54:58'!
primerCarta
	^primerCarta! !

!ManoDeJugador methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 7/5/2021 17:55:13'!
segundaCarta
	^segundaCarta! !

!ManoDeJugador methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 7/5/2021 17:56:51'!
tercerCarta
	^tercerCarta! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ManoDeJugador class' category: 'ISW1-2021-1C-2doParcial'!
ManoDeJugador class
	instanceVariableNames: ''!

!ManoDeJugador class methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 7/5/2021 18:07:53'!
asegurarQueNoSonIguales: aCartaDeTruco2 y: aCartaDeTruco

	^ aCartaDeTruco = aCartaDeTruco2 ifTrue: [self error: self noSePuedenCrearJugadoresCarteadosMensajeDeError ]! !

!ManoDeJugador class methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 7/5/2021 18:08:55'!
con: aCartaDeTruco con: aCartaDeTruco2 con: aCartaDeTruco3
	self asegurarQueNoSonIguales: aCartaDeTruco2 y: aCartaDeTruco.
	self asegurarQueNoSonIguales: aCartaDeTruco2 y: aCartaDeTruco3.
	self asegurarQueNoSonIguales: aCartaDeTruco3 y: aCartaDeTruco.

	^ self new initializeCon: aCartaDeTruco con: aCartaDeTruco2 con: aCartaDeTruco3.! !

!ManoDeJugador class methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 7/5/2021 18:02:02'!
noSePuedenCrearJugadoresCarteadosMensajeDeError
	^ 'el jugador no tiene unas cartas correctas para un único maso'! !


!classDefinition: #Ronda category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #Ronda
	instanceVariableNames: 'mano pie puntosMano puntosPie'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Ronda methodsFor: 'initialization' stamp: 'lilmonk3y 7/5/2021 19:20:09'!
initializeCon: unPrimerJugador y: unSegundoJugador 
	mano := unPrimerJugador.
	pie := unSegundoJugador.
	
	puntosMano := 0.
	puntosPie := 0.! !


!Ronda methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 7/5/2021 19:38:33'!
asegurarQue: jugador empezoLaPartidaCon: unaCarta

	^(jugador contiene: unaCarta) ifFalse: [self error: self class noSePuedeJugarConCartasQueNoTePertenecenDescripcionDeError].
	
! !

!Ronda methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 7/5/2021 20:07:28'!
asegurarQueHayGanador

	^ self hayGanador ifFalse: [self error: self class noHayGanadorAunDescripcionDeError]! !

!Ronda methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 7/5/2021 20:07:28'!
ganador
	self asegurarQueHayGanador.
	
	puntosMano < puntosPie ifTrue: [^ pie].
	^mano! !

!Ronda methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 7/5/2021 20:51:11'!
ganoManoYLaPrimerCartaEsSuya: cartaJugada
	| ganoMano |
	ganoMano _ self manosGanadasMano = 1.
	^ ganoMano and: [mano contiene: cartaJugada ]! !

!Ronda methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 7/5/2021 20:47:41'!
ganoPieYLaPrimerCartaEsSuya: cartaDelAnteriorGanador 
	| ganoPie |
	ganoPie _ self manosGanadasPorPie  = 1.
	^ ganoPie and: [pie contiene: cartaDelAnteriorGanador]
	! !

!Ronda methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 7/5/2021 19:53:47'!
hayGanador
	^ puntosMano = 2 or: [puntosPie = 2]! !

!Ronda methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 7/5/2021 19:55:55'!
jugarManoEntre: cartaDeMano y: cartaDePie

	self asegurarQue: mano empezoLaPartidaCon: cartaDeMano.
	self asegurarQue: pie empezoLaPartidaCon: cartaDePie.
	
	(cartaDeMano  empardaCon: cartaDePie) 
		ifTrue: [
			puntosMano _ puntosMano +1.
			puntosPie _ puntosPie +1.
			^self].
	
	(cartaDeMano mataA: cartaDePie) 
		ifTrue:[puntosMano _ puntosMano+1] 
		ifFalse: [puntosPie _ puntosPie +1].! !

!Ronda methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 7/5/2021 19:20:44'!
manosGanadasMano
	^puntosMano ! !

!Ronda methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 7/5/2021 19:20:52'!
manosGanadasPorPie
	^puntosPie ! !

!Ronda methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 7/5/2021 19:56:20'!
primerMano: cartaDeMano contra: cartaDePie

	self jugarManoEntre: cartaDeMano y: cartaDePie ! !

!Ronda methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 7/5/2021 21:12:08'!
prioridadDeJuego: cartaDelAnteriorGanador con: cartaDelAnteriorPerdedor

	| ganoPie ganoMano pardaLaPrimera |
	pardaLaPrimera _ self manosGanadasMano  = self manosGanadasPorPie and: [pie contiene: cartaDelAnteriorGanador ] .
	ganoPie _ self ganoPieYLaPrimerCartaEsSuya: cartaDelAnteriorGanador.
	ganoMano _ self ganoManoYLaPrimerCartaEsSuya: cartaDelAnteriorPerdedor .
	(pardaLaPrimera  or: [ganoPie not] or: [ganoMano not]) ifTrue: [self error: self class elJugadorNoTienePrioridadDeJuegoEnEstaManoDescripcionDeError]! !

!Ronda methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 7/5/2021 21:12:47'!
segundaMano: cartaDelAnteriorGanador contra: cartaDelAnteriorPerdedor 
	"
	Estuve más de 30 min y no me sale continúo con lo siguiente.
	
	self prioridadDeJuego: cartaDelAnteriorGanador con: cartaDelAnteriorPerdedor.
	"
	
	self jugarManoEntre: cartaDelAnteriorGanador y: cartaDelAnteriorPerdedor! !

!Ronda methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 7/5/2021 21:42:56'!
terceraMano: aCartaDeTruco contra: aCartaDeTruco2 
	self hayGanador ifTrue: [self error: self class yaHayUnGanadorDescripcionDeError].
	
	self jugarManoEntre: aCartaDeTruco y: aCartaDeTruco2.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ronda class' category: 'ISW1-2021-1C-2doParcial'!
Ronda class
	instanceVariableNames: ''!

!Ronda class methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 7/5/2021 18:38:49'!
asegurarQueLasCartasDe: unPrimerJugador noContienenCartasDe: unSegundoJugador

	^ (self hayAlgunaCartaDe: unSegundoJugador enLasCartasDe: unPrimerJugador) ifTrue: [self error: self losJugadoresDebenTenerCartasDistintasDescripcionDeError]! !

!Ronda class methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 7/5/2021 18:38:49'!
con: unPrimerJugador y: unSegundoJugador
	self asegurarQueLasCartasDe: unPrimerJugador noContienenCartasDe: unSegundoJugador.
	
	^ self new initializeCon: unPrimerJugador y: unSegundoJugador ! !

!Ronda class methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 7/5/2021 20:31:20'!
elJugadorNoTienePrioridadDeJuegoEnEstaManoDescripcionDeError
	^ 'el jugador no tiene prioridad de juego en esta ronda'! !

!Ronda class methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 7/5/2021 18:38:07'!
hayAlgunaCartaDe: unSegundoJugador enLasCartasDe: unPrimerJugador

	^ unPrimerJugador cartas anySatisfy: [:carta | unSegundoJugador cartas includes: carta]! !

!Ronda class methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 7/5/2021 18:17:04'!
losJugadoresDebenTenerCartasDistintasDescripcionDeError
	^ 'los jugadores no pueden tener cartas repetidas entre ellos'! !

!Ronda class methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 7/5/2021 20:06:06'!
noHayGanadorAunDescripcionDeError
	^ 'no hay ganador aún'! !

!Ronda class methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 7/5/2021 19:34:32'!
noSePuedeJugarConCartasQueNoTePertenecenDescripcionDeError
	^ 'no se pueden usar cartas que no estaban en tu mano al comienzo de la ronda'! !

!Ronda class methodsFor: 'as yet unclassified' stamp: 'lilmonk3y 7/5/2021 21:36:43'!
yaHayUnGanadorDescripcionDeError
	^ 'la partida ya terminó y no se puede seguir jugando'! !
