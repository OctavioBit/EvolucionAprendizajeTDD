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

!RondaDeTrucoTest methodsFor: 'test' stamp: 'DB 7/5/2021 19:41:32'!
test01_arrancaJugandoSiempreLaMano

	| ronda |
	ronda := self crearRondaDeTrucoConCartasDeLaMano: self repartirParaLaMano yCartasDelPie: self repartirParaElPie .
	self assert: ronda esElTurnoDeLaMano.
! !

!RondaDeTrucoTest methodsFor: 'test' stamp: 'DB 7/5/2021 19:14:42'!
test02_noSePuedeCrearUnaRondaSiLaManoTieneMenosDeTresCartas

	| cartasDeLaMano |
	cartasDeLaMano := OrderedCollection with: CartaDeTruco anchoDeBasto.
	
	self 
		should: [self crearRondaDeTrucoConCartasDeLaMano: cartasDeLaMano yCartasDelPie: self repartirParaElPie ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: RondaDeTruco jugadorConCantidadIncorrectasDeCartasErrorDescription.! !

!RondaDeTrucoTest methodsFor: 'test' stamp: 'DB 7/5/2021 19:13:33'!
test03_noSePuedeCrearUnaRondaSiElPieTieneMenosDeTresCartas

	| cartasDelPie |
	cartasDelPie := OrderedCollection with: CartaDeTruco anchoDeBasto.
	
	self 
		should: [self crearRondaDeTrucoConCartasDeLaMano: self repartirParaLaMano yCartasDelPie:  cartasDelPie] 
		raise: Error - MessageNotUnderstood 
		withMessageText: RondaDeTruco jugadorConCantidadIncorrectasDeCartasErrorDescription.! !

!RondaDeTrucoTest methodsFor: 'test' stamp: 'DB 7/5/2021 19:14:52'!
test04_lasCartasDeLaManoTienenQueSerCartasDeTruco

	| cartasDeLaMano |
	cartasDeLaMano := OrderedCollection with: 1 with: CartaDeTruco anchoDeBasto with: 'el ancho'.
	
	self 
		should: [self crearRondaDeTrucoConCartasDeLaMano: cartasDeLaMano yCartasDelPie: self repartirParaElPie ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: RondaDeTruco lasCartasNoSonCartasDeTrucoErrorDescription.! !

!RondaDeTrucoTest methodsFor: 'test' stamp: 'DB 7/5/2021 19:13:33'!
test05_lasCartasDelPieTienenQueSerCartasDeTruco

	| cartasDelPie |
	cartasDelPie := OrderedCollection with: 1 with: CartaDeTruco anchoDeBasto with: 'el ancho'.
	
	self 
		should: [self crearRondaDeTrucoConCartasDeLaMano: self repartirParaLaMano yCartasDelPie: cartasDelPie] 
		raise: Error - MessageNotUnderstood 
		withMessageText: RondaDeTruco lasCartasNoSonCartasDeTrucoErrorDescription.! !

!RondaDeTrucoTest methodsFor: 'test' stamp: 'DB 7/5/2021 19:15:16'!
test06_noSePuedeCrearUnaRondaSiLaManoTieneMasDeTresCartas

	| cartasDeLaMano |
	cartasDeLaMano := OrderedCollection 
		with: CartaDeTruco anchoDeBasto 
		with: CartaDeTruco anchoDeEspada 
		with: CartaDeTruco sieteDeEspada 
		with: CartaDeTruco sieteDeOro.
	
	self 
		should: [self crearRondaDeTrucoConCartasDeLaMano: cartasDeLaMano yCartasDelPie: self repartirParaElPie ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: RondaDeTruco jugadorConCantidadIncorrectasDeCartasErrorDescription.! !

!RondaDeTrucoTest methodsFor: 'test' stamp: 'DB 7/5/2021 19:13:32'!
test07_noSePuedeCrearUnaRondaSiElPieTieneMasDeTresCartas

	| cartasDelPie |
	cartasDelPie := OrderedCollection 
		with: CartaDeTruco anchoDeBasto 
		with: CartaDeTruco anchoDeEspada 
		with: CartaDeTruco sieteDeEspada 
		with: CartaDeTruco sieteDeOro.
	
	self 
		should: [self crearRondaDeTrucoConCartasDeLaMano: self repartirParaLaMano yCartasDelPie: cartasDelPie] 
		raise: Error - MessageNotUnderstood 
		withMessageText: RondaDeTruco jugadorConCantidadIncorrectasDeCartasErrorDescription.! !

!RondaDeTrucoTest methodsFor: 'test' stamp: 'DB 7/5/2021 19:15:31'!
test08_laManoNoPuedeTenerCartasDuplicadas

	| cartasDeLaMano |
	cartasDeLaMano := OrderedCollection 
		with: CartaDeTruco anchoDeBasto 
		with: CartaDeTruco anchoDeEspada 
		with: CartaDeTruco anchoDeBasto.
	
	self 
		should: [self crearRondaDeTrucoConCartasDeLaMano: cartasDeLaMano yCartasDelPie: self repartirParaElPie ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: RondaDeTruco lasCartasNoPuedenEstarDuplicadasErrorDescription.! !

!RondaDeTrucoTest methodsFor: 'test' stamp: 'DB 7/5/2021 19:13:33'!
test09_elPieNoPuedeTenerCartasDuplicadas

	| cartasDelPie |
	cartasDelPie := OrderedCollection 
		with: CartaDeTruco anchoDeBasto 
		with: CartaDeTruco anchoDeEspada 
		with: CartaDeTruco anchoDeBasto.
	
	self 
		should: [self crearRondaDeTrucoConCartasDeLaMano: self repartirParaLaMano yCartasDelPie: cartasDelPie ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: RondaDeTruco lasCartasNoPuedenEstarDuplicadasErrorDescription.! !

!RondaDeTrucoTest methodsFor: 'test' stamp: 'DB 7/5/2021 19:15:45'!
test10_lasCartasRepartidasNoPuedenTenerDuplicados

	| cartasDelPie cartasDeLaMano |
	cartasDelPie := OrderedCollection 
		with: CartaDeTruco anchoDeBasto 
		with: CartaDeTruco anchoDeEspada 
		with: CartaDeTruco sieteDeEspada.
		
	cartasDeLaMano := OrderedCollection 
		with: CartaDeTruco sieteDeOro 
		with: CartaDeTruco anchoDeBasto 
		with: (CartaDeTruco bastoCon: 3).
	
	self 
		should: [self crearRondaDeTrucoConCartasDeLaMano: cartasDeLaMano yCartasDelPie: cartasDelPie ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: RondaDeTruco lasCartasNoPuedenEstarDuplicadasErrorDescription.! !

!RondaDeTrucoTest methodsFor: 'test' stamp: 'DB 7/5/2021 19:46:11'!
test11_cuandoArrancaElJuegoElPieEsperaSuTurno

	|  ronda |
	ronda := self crearRondaDeTrucoConCartasDeLaMano: self repartirParaLaMano yCartasDelPie: self repartirParaElPie.
	
	self 
		should: [ronda tiraElPie: CartaDeTruco anchoDeBasto] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: RondaDeTruco noEsTuTurnoErrorDescription equals: anError messageText .
			self assert: ronda esElTurnoDeLaMano	]! !

!RondaDeTrucoTest methodsFor: 'test' stamp: 'DB 7/5/2021 19:48:05'!
test12_laManoNoPuedeTirarCartasQueNoTenga

	|  ronda |
	ronda := self crearRondaDeTrucoConCartasDeLaMano: self repartirParaLaMano yCartasDelPie: self repartirParaElPie.
	
	self 
		should: [ronda tiraLaMano: CartaDeTruco anchoDeBasto] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: RondaDeTruco laCartaSeleccionadaNoEstaEntreTusCartas equals: anError messageText .
			self assert: ronda esElTurnoDeLaMano	]! !

!RondaDeTrucoTest methodsFor: 'test' stamp: 'DB 7/5/2021 20:09:18'!
test13_elPieNoPuedeTirarCartasQueNoTenga

	|  ronda |
	ronda := self crearRondaDeTrucoConCartasDeLaMano: self repartirParaLaMano yCartasDelPie: self repartirParaElPie.
	ronda tiraLaMano: (CartaDeTruco bastoCon: 3).
	
	self 
		should: [ronda tiraElPie: (CartaDeTruco bastoCon: 4) ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: RondaDeTruco laCartaSeleccionadaNoEstaEntreTusCartas equals: anError messageText .
			self assert: ronda esElTurnoDelPie 	]! !

!RondaDeTrucoTest methodsFor: 'test' stamp: 'DB 7/5/2021 20:25:32'!
test14_despuesQueSeJuegaElPrimerEnfrentamientoYGanaLaManoElTurnoSigueSiendoDeLaMano

	|  ronda |
	ronda := self crearRondaDeTrucoConCartasDeLaMano: self repartirParaLaMano yCartasDelPie: self repartirParaElPie.
	ronda tiraLaMano: (CartaDeTruco bastoCon: 3).
	ronda tiraElPie: (CartaDeTruco espadaCon: 2).
	
	self assert: ronda primerEnfrentamientoFinalizado.
	self assert: ronda esElTurnoDeLaMano.
	self deny: ronda esElTurnoDelPie.
	self assert: ronda ganoPrimerEnfrentamientoLaMano.
	self deny: ronda ganoPrimerEnfrentamientoElPie.
	! !

!RondaDeTrucoTest methodsFor: 'test' stamp: 'DB 7/5/2021 20:33:22'!
test15_despuesQueSeJuegaElPrimerEnfrentamientoYGanaElPieElProximoTurnoEsDelPie

	|  ronda |
	ronda := self crearRondaDeTrucoConCartasDeLaMano: self repartirParaLaMano yCartasDelPie: self repartirParaElPie.
	ronda tiraLaMano: (CartaDeTruco bastoCon: 3).
	ronda tiraElPie: (CartaDeTruco anchoDeBasto).
	
	self assert: ronda primerEnfrentamientoFinalizado.
	self deny: ronda esElTurnoDeLaMano.
	self assert: ronda esElTurnoDelPie.
	self deny: ronda ganoPrimerEnfrentamientoLaMano.
	self assert: ronda ganoPrimerEnfrentamientoElPie.
	! !

!RondaDeTrucoTest methodsFor: 'test' stamp: 'DB 7/5/2021 21:11:41'!
test16_siElPrimerEnfrentamientoEsPardoElTurnoEsParaLaMano

	|  ronda |
	ronda := self crearRondaDeTrucoConCartasDeLaMano: self repartirParaLaMano yCartasDelPie: self repartirParaElPie.
	ronda tiraLaMano: (CartaDeTruco bastoCon: 2).
	ronda tiraElPie: (CartaDeTruco espadaCon: 2).
	
	self assert: ronda primerEnfrentamientoFinalizado.
	self assert: ronda primerEnfrentamientoPardo.
	self assert: ronda esElTurnoDeLaMano.
	self deny: ronda esElTurnoDelPie.
	self deny: ronda ganoPrimerEnfrentamientoLaMano.
	self deny: ronda ganoPrimerEnfrentamientoElPie.
	
	! !

!RondaDeTrucoTest methodsFor: 'test' stamp: 'DB 7/5/2021 21:16:50'!
test17_siElPrimerEnfrentamientoEsPardoYLaManoGanaFinalizaElJuego

	|  ronda |
	ronda := self crearRondaDeTrucoConCartasDeLaMano: self repartirParaLaMano yCartasDelPie: self repartirParaElPie.
	ronda tiraLaMano: (CartaDeTruco bastoCon: 2).
	ronda tiraElPie: (CartaDeTruco espadaCon: 2).
	
	ronda tiraLaMano: (CartaDeTruco bastoCon: 3).
	ronda tiraElPie: (CartaDeTruco copaCon: 2).
		
	self assert: ronda primerEnfrentamientoFinalizado.
	self assert: ronda primerEnfrentamientoPardo.
	self assert: ronda segundoEnfrentamientoFinalizado.
	self assert: ronda juegoFinalizado.
	self deny: ronda esElTurnoDeLaMano.
	self deny: ronda esElTurnoDelPie.
	self assert: ronda ganoLaPartidaLaMano.
	self deny: ronda ganoLaPartidaElPie.
	
	! !

!RondaDeTrucoTest methodsFor: 'test' stamp: 'DB 7/5/2021 21:34:52'!
test18_siElPrimerEnfrentamientoEsPardoYElPieGanaFinalizaElJuego

	|  ronda |
	ronda := self crearRondaDeTrucoConCartasDeLaMano: self repartirParaLaMano yCartasDelPie: self repartirParaElPie.
	ronda tiraLaMano: (CartaDeTruco bastoCon: 2).
	ronda tiraElPie: (CartaDeTruco espadaCon: 2).
	
	ronda tiraLaMano: (CartaDeTruco bastoCon: 3).
	ronda tiraElPie: (CartaDeTruco anchoDeBasto).
		
	self assert: ronda primerEnfrentamientoFinalizado.
	self assert: ronda primerEnfrentamientoPardo.
	self assert: ronda segundoEnfrentamientoFinalizado.
	self assert: ronda juegoFinalizado.
	self deny: ronda esElTurnoDeLaMano.
	self deny: ronda esElTurnoDelPie.
	self deny: ronda ganoLaPartidaLaMano.
	self assert: ronda ganoLaPartidaElPie.
	
	! !

!RondaDeTrucoTest methodsFor: 'test' stamp: 'DB 7/5/2021 21:50:41'!
test19_noSePuedeSeguirJugandoLaRondaSiHayUnGanador

	|  ronda |
	ronda := self crearRondaDeTrucoConCartasDeLaMano: self repartirParaLaMano yCartasDelPie: self repartirParaElPie.
	ronda tiraLaMano: (CartaDeTruco bastoCon: 2).
	ronda tiraElPie: (CartaDeTruco espadaCon: 2).
	
	ronda tiraLaMano: (CartaDeTruco bastoCon: 3).
	ronda tiraElPie: (CartaDeTruco anchoDeBasto).
		
	self assert: ronda primerEnfrentamientoFinalizado.
	self assert: ronda primerEnfrentamientoPardo.
	self assert: ronda segundoEnfrentamientoFinalizado.
	self assert: ronda juegoFinalizado.
	self deny: ronda esElTurnoDeLaMano.
	self deny: ronda esElTurnoDelPie.
	self deny: ronda ganoLaPartidaLaMano.
	self assert: ronda ganoLaPartidaElPie.
	
	self 
		should: [ronda tiraLaMano: (CartaDeTruco bastoCon: 4) ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: RondaDeTruco elJuegoEstaFinalizadoErrorDescription.
	
	
	
	! !

!RondaDeTrucoTest methodsFor: 'test' stamp: 'DB 7/5/2021 21:41:38'!
_test19_siNoHayPardaEnLaPrimerElJuegoSeDefineEnLaTercera

	|  ronda |
	ronda := self crearRondaDeTrucoConCartasDeLaMano: self repartirParaLaMano yCartasDelPie: self repartirParaElPie.
	ronda tiraLaMano: (CartaDeTruco bastoCon: 3).
	ronda tiraElPie: (CartaDeTruco copaCon: 2).
	
	ronda tiraLaMano: (CartaDeTruco bastoCon: 4).
	ronda tiraElPie: (CartaDeTruco anchoDeBasto).
	
	ronda tiraElPie: (CartaDeTruco espadaCon: 2).
	ronda tiraLaMano:(CartaDeTruco bastoCon: 2). 
		
	self assert: ronda primerEnfrentamientoFinalizado.
	self deny: ronda primerEnfrentamientoPardo.
	self assert: ronda segundoEnfrentamientoFinalizado.
	self assert:  ronda juegoFinalizado.
	self deny: ronda esElTurnoDeLaMano.
	self deny: ronda esElTurnoDelPie.
	self deny: ronda ganoLaPartidaLaMano.
	self assert: ronda ganoLaPartidaElPie.
	
	! !


!RondaDeTrucoTest methodsFor: 'private' stamp: 'DB 7/5/2021 18:17:46'!
crearRondaDeTrucoConCartasDeLaMano: unasCartasDeLaMano yCartasDelPie: unasCartasDelPie 
	^RondaDeTruco cartasDeLaMano: unasCartasDeLaMano cartasDelPie: unasCartasDelPie.
! !

!RondaDeTrucoTest methodsFor: 'private' stamp: 'DB 7/5/2021 21:13:24'!
repartirParaElPie

	^OrderedCollection with: (CartaDeTruco anchoDeBasto ) with: (CartaDeTruco copaCon: 2 ) with: (CartaDeTruco espadaCon: 2)! !

!RondaDeTrucoTest methodsFor: 'private' stamp: 'DB 7/5/2021 20:13:12'!
repartirParaLaMano

	^OrderedCollection with: (CartaDeTruco bastoCon: 2) with: (CartaDeTruco bastoCon: 3) with: (CartaDeTruco bastoCon: 4)! !


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


!classDefinition: #EstadoDeLaRonda category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #EstadoDeLaRonda
	instanceVariableNames: 'ronda'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!EstadoDeLaRonda methodsFor: 'as yet unclassified' stamp: 'DB 7/5/2021 20:06:15'!
esElTurnoDeLaMano
	self subclassResponsibility .! !

!EstadoDeLaRonda methodsFor: 'as yet unclassified' stamp: 'DB 7/5/2021 20:08:28'!
esElTurnoDelPie
	self subclassResponsibility .! !

!EstadoDeLaRonda methodsFor: 'as yet unclassified' stamp: 'DB 7/5/2021 21:23:26'!
initializeFor: aRonda
	
	ronda := aRonda .! !

!EstadoDeLaRonda methodsFor: 'as yet unclassified' stamp: 'DB 7/5/2021 21:26:07'!
juegoFinalizado
	self subclassResponsibility ! !


!classDefinition: #JuegaElPie category: 'ISW1-2021-1C-2doParcial'!
EstadoDeLaRonda subclass: #JuegaElPie
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!JuegaElPie methodsFor: 'as yet unclassified' stamp: 'DB 7/5/2021 20:04:47'!
esElTurnoDeLaMano
	^false! !

!JuegaElPie methodsFor: 'as yet unclassified' stamp: 'DB 7/5/2021 20:08:24'!
esElTurnoDelPie
	^true! !

!JuegaElPie methodsFor: 'as yet unclassified' stamp: 'DB 7/5/2021 21:25:47'!
juegoFinalizado
	^false! !


!classDefinition: #JuegaLaMano category: 'ISW1-2021-1C-2doParcial'!
EstadoDeLaRonda subclass: #JuegaLaMano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!JuegaLaMano methodsFor: 'as yet unclassified' stamp: 'DB 7/5/2021 20:04:38'!
esElTurnoDeLaMano
	^true! !

!JuegaLaMano methodsFor: 'as yet unclassified' stamp: 'DB 7/5/2021 20:08:19'!
esElTurnoDelPie
	^false! !

!JuegaLaMano methodsFor: 'as yet unclassified' stamp: 'DB 7/5/2021 21:18:15'!
juegoFinalizado
	^false! !


!classDefinition: #JuegoFinalizado category: 'ISW1-2021-1C-2doParcial'!
EstadoDeLaRonda subclass: #JuegoFinalizado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!JuegoFinalizado methodsFor: 'as yet unclassified' stamp: 'DB 7/5/2021 21:27:28'!
esElTurnoDeLaMano
	^false! !

!JuegoFinalizado methodsFor: 'as yet unclassified' stamp: 'DB 7/5/2021 21:24:49'!
esElTurnoDelPie
	^false! !

!JuegoFinalizado methodsFor: 'as yet unclassified' stamp: 'DB 7/5/2021 21:25:35'!
juegoFinalizado
	^true! !


!classDefinition: #RondaDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #RondaDeTruco
	instanceVariableNames: 'cartasDeLaMano cartasDelPie state cartasJugadasPorLaMano cartasJugadasPorElPie'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTruco methodsFor: 'turnos' stamp: 'DB 7/5/2021 21:21:34'!
proximoTurno
	
	cartasJugadasPorLaMano size = cartasJugadasPorElPie size ifTrue: [
			
		((cartasJugadasPorLaMano at: 1) empardaCon: (cartasJugadasPorElPie at: 1)) ifTrue: [
			self segundoEnfrentamientoFinalizado ifTrue: [
				^state := JuegoFinalizado new initializeFor: self.
			].
			^state := JuegaLaMano new initializeFor: self.].
		
		((cartasJugadasPorElPie at: 1) mataA: (cartasJugadasPorLaMano at: 1	)) 
			ifTrue: [state := JuegaElPie new initializeFor: self]
			ifFalse: [state := JuegaLaMano new initializeFor: self].
	]
	! !

!RondaDeTruco methodsFor: 'turnos' stamp: 'DB 7/5/2021 21:52:21'!
tiraElPie: aCartaDeTruco 

	state juegoFinalizado ifTrue: [self error: self class elJuegoEstaFinalizadoErrorDescription].

	state esElTurnoDelPie ifFalse: [	self error: self class noEsTuTurnoErrorDescription].
	
	(cartasDelPie includes: aCartaDeTruco) ifFalse: [	self error: self class laCartaSeleccionadaNoEstaEntreTusCartas].
	
	cartasJugadasPorElPie add: aCartaDeTruco .
	
	self proximoTurno ! !

!RondaDeTruco methodsFor: 'turnos' stamp: 'DB 7/5/2021 21:52:55'!
tiraLaMano: aCartaDeTruco 

	state juegoFinalizado ifTrue: [self error: self class elJuegoEstaFinalizadoErrorDescription].

	(cartasDeLaMano includes: aCartaDeTruco) ifFalse: [	self error: self class laCartaSeleccionadaNoEstaEntreTusCartas].
	
	cartasJugadasPorLaMano add: aCartaDeTruco.
	
	state := JuegaElPie new	 initializeFor: self.! !


!RondaDeTruco methodsFor: 'estados enfrentamientos' stamp: 'DB 7/5/2021 21:09:29'!
ganoLaManoEn: enfrentamientoNumero
	^ (cartasJugadasPorLaMano at: enfrentamientoNumero) mataA: (cartasJugadasPorElPie at: enfrentamientoNumero)! !

!RondaDeTruco methodsFor: 'estados enfrentamientos' stamp: 'DB 7/5/2021 21:33:38'!
ganoLaPartidaElPie
	^self primerEnfrentamientoFinalizado 
	and: self primerEnfrentamientoPardo 
	and: (self ganoLaManoEn: 2) not! !

!RondaDeTruco methodsFor: 'estados enfrentamientos' stamp: 'DB 7/5/2021 21:32:15'!
ganoLaPartidaLaMano
		
	^self primerEnfrentamientoFinalizado 
	and: self primerEnfrentamientoPardo 
	and: (self ganoLaManoEn: 2).! !

!RondaDeTruco methodsFor: 'estados enfrentamientos' stamp: 'DB 7/5/2021 21:11:19'!
ganoPrimerEnfrentamientoElPie
	^self ganoPrimerEnfrentamientoLaMano not and: self noEmpardaron ! !

!RondaDeTruco methodsFor: 'estados enfrentamientos' stamp: 'DB 7/5/2021 21:09:50'!
ganoPrimerEnfrentamientoLaMano
	^self primerEnfrentamientoFinalizado
		and: self noEmpardaron 
		and: (self ganoLaManoEn: 1).! !

!RondaDeTruco methodsFor: 'estados enfrentamientos' stamp: 'DB 7/5/2021 21:07:08'!
noEmpardaron

	^ ((cartasJugadasPorLaMano at: 1) empardaCon: (cartasJugadasPorElPie at: 1)) not! !

!RondaDeTruco methodsFor: 'estados enfrentamientos' stamp: 'DB 7/5/2021 20:51:38'!
primerEnfrentamientoFinalizado
	^cartasJugadasPorLaMano size >= 1 and: cartasJugadasPorElPie size >= 1.! !

!RondaDeTruco methodsFor: 'estados enfrentamientos' stamp: 'DB 7/5/2021 20:59:28'!
primerEnfrentamientoPardo
	^true! !

!RondaDeTruco methodsFor: 'estados enfrentamientos' stamp: 'DB 7/5/2021 21:17:40'!
segundoEnfrentamientoFinalizado
	^cartasJugadasPorLaMano size >= 2 and: cartasJugadasPorElPie size >= 2.! !


!RondaDeTruco methodsFor: 'test' stamp: 'DB 7/5/2021 21:05:14'!
esElTurnoDeLaMano

	^state esElTurnoDeLaMano! !

!RondaDeTruco methodsFor: 'test' stamp: 'DB 7/5/2021 20:14:10'!
esElTurnoDelPie

	^state esElTurnoDelPie ! !


!RondaDeTruco methodsFor: 'initialization' stamp: 'DB 7/5/2021 20:39:23'!
initializeWith: lasCartasDeLaMano and: lasCartasDelPie 

	cartasDeLaMano := lasCartasDeLaMano.
	cartasDelPie := lasCartasDelPie.
	
	state := JuegaLaMano new initializeFor: self.
	cartasJugadasPorLaMano := OrderedCollection new.
	cartasJugadasPorElPie := OrderedCollection new.! !

!RondaDeTruco methodsFor: 'initialization' stamp: 'DB 7/5/2021 21:27:00'!
juegoFinalizado
	^state juegoFinalizado! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RondaDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco class
	instanceVariableNames: ''!

!RondaDeTruco class methodsFor: 'error descriptions' stamp: 'DB 7/5/2021 18:47:19'!
jugadorConCantidadIncorrectasDeCartasErrorDescription
	^'No se puede crear una si el jugador tiene menos de tres cartas'! !

!RondaDeTruco class methodsFor: 'error descriptions' stamp: 'DB 7/5/2021 19:49:45'!
laCartaSeleccionadaNoEstaEntreTusCartas
	^'La carta seleccionada no está entre tus cartas'! !

!RondaDeTruco class methodsFor: 'error descriptions' stamp: 'DB 7/5/2021 18:51:04'!
lasCartasNoPuedenEstarDuplicadasErrorDescription
	^'Las cartas no pueden estar duplicadas'! !

!RondaDeTruco class methodsFor: 'error descriptions' stamp: 'DB 7/5/2021 18:26:55'!
lasCartasNoSonCartasDeTrucoErrorDescription
	^'Las cartas dada no son cartas de truco'! !

!RondaDeTruco class methodsFor: 'error descriptions' stamp: 'DB 7/5/2021 19:43:43'!
noEsTuTurnoErrorDescription
	^'No es tu turno'! !


!RondaDeTruco class methodsFor: 'assertions' stamp: 'DB 7/5/2021 18:47:19'!
laCantidadDeCartasTieneQueSerTres: cartas

	^ (cartas size = 3) ifFalse: [	self error: self jugadorConCantidadIncorrectasDeCartasErrorDescription]! !

!RondaDeTruco class methodsFor: 'assertions' stamp: 'DB 7/5/2021 18:40:44'!
tienenQueSerCartasDeTruco: cartas

	^ cartas do: [:carta | (carta isKindOf: CartaDeTruco) not ifTrue: [self error: self lasCartasNoSonCartasDeTrucoErrorDescription ]]! !


!RondaDeTruco class methodsFor: 'instance creation' stamp: 'DB 7/5/2021 19:55:22'!
cartasDeLaMano: cartasDeLaMano cartasDelPie: cartasDelPie 
	
	
	self laCantidadDeCartasTieneQueSerTres: cartasDeLaMano.
	self laCantidadDeCartasTieneQueSerTres: cartasDelPie.
	
	self tienenQueSerCartasDeTruco: cartasDeLaMano.
	self tienenQueSerCartasDeTruco: cartasDelPie.
	
	self noPuedenHaberCartasDuplicadas: cartasDeLaMano con: cartasDelPie.
	
	^self new initializeWith: cartasDeLaMano and: cartasDelPie.! !

!RondaDeTruco class methodsFor: 'instance creation' stamp: 'DB 7/5/2021 19:12:10'!
noPuedenHaberCartasDuplicadas: cartasDeLaMano con: cartasDelPie  
	
	| mazo |
	mazo := Bag new.
	
	cartasDeLaMano do: [:carta | mazo add: carta.		].
	cartasDelPie do: [:carta | mazo add: carta.].
	
	mazo do: [:carta |
		(mazo occurrencesOf: carta) = 1 ifFalse: [self error: self lasCartasNoPuedenEstarDuplicadasErrorDescription ]
	]! !


!RondaDeTruco class methodsFor: 'as yet unclassified' stamp: 'DB 7/5/2021 21:53:19'!
elJuegoEstaFinalizadoErrorDescription
	^'El juego esta finalizado'! !
