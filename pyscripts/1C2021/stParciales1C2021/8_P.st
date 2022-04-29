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

!RondaDeTrucoTest methodsFor: 'instance creation tests' stamp: 'ET 7/5/2021 18:42:09'!
test01NoSePuedeCrearRondaDeTrucoConCartasVacias

	self should: [RondaDeTruco cartasDeMano: {} cartasDePie: {}]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | self assert: anError messageText = RondaDeTruco invalidNumberOfCardsErrorDescription]! !

!RondaDeTrucoTest methodsFor: 'instance creation tests' stamp: 'ET 7/5/2021 18:42:32'!
test02NoSePuedeCrearRondaDeTrucoConCartasDePieVacias

	self should: [RondaDeTruco cartasDeMano: {CartaDeTruco bastoCon: 1. CartaDeTruco bastoCon: 2. CartaDeTruco bastoCon: 3.} cartasDePie: {}]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | self assert: anError messageText = RondaDeTruco invalidNumberOfCardsErrorDescription]! !

!RondaDeTrucoTest methodsFor: 'instance creation tests' stamp: 'ET 7/5/2021 18:43:45'!
test03NoSePuedeCrearRondaDeTrucoConCartasRepetidasEnMano

	self should: [RondaDeTruco cartasDeMano: {CartaDeTruco bastoCon: 1. CartaDeTruco bastoCon: 1. CartaDeTruco bastoCon: 1.} 
		cartasDePie: {CartaDeTruco copaCon: 1. CartaDeTruco copaCon: 2. CartaDeTruco copaCon: 3.}]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | self assert: anError messageText = RondaDeTruco repeatedCardsErrorDescription]! !

!RondaDeTrucoTest methodsFor: 'instance creation tests' stamp: 'ET 7/5/2021 20:43:09'!
test04NoSePuedeCrearRondaDeTrucoConCartasRepetidasEntreManoYPie

	self should: [RondaDeTruco cartasDeMano: {CartaDeTruco bastoCon: 1. CartaDeTruco bastoCon: 2. CartaDeTruco bastoCon: 3.} 
		cartasDePie: {CartaDeTruco bastoCon: 1. CartaDeTruco copaCon: 2. CartaDeTruco copaCon: 3.}]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | self assert: anError messageText = RondaDeTruco repeatedCardsErrorDescription]! !


!RondaDeTrucoTest methodsFor: 'winning tests' stamp: 'ET 7/5/2021 21:43:51'!
test15EmpateEnPrimerEnfrentamientoYManoGanaElSegundoEntoncesManoEsElGanadorDeLaRonda
	|ronda|
	ronda := RondaDeTruco cartasDeMano: {CartaDeTruco bastoCon: 1. CartaDeTruco bastoCon: 2. CartaDeTruco bastoCon: 3.} 
		cartasDePie: {CartaDeTruco copaCon: 1. CartaDeTruco copaCon: 2. CartaDeTruco anchoDeEspada.}.
		
	ronda manoJuegaCarta: 2.
	ronda pieJuegaCarta: 2.
	
	ronda manoJuegaCarta: 1.
	ronda pieJuegaCarta: 1.
	
	self assert: ronda terminoRonda.
	self assert: #empate equals: (ronda ganadorDeEnfrentamientoOEmpate: 1).
	self assert: #mano equals: (ronda ganadorDeEnfrentamientoOEmpate: 2).
	self assert: #mano equals: ronda ganador.
! !

!RondaDeTrucoTest methodsFor: 'winning tests' stamp: 'ET 7/5/2021 20:52:20'!
test16NoHayGanadorAlInicioDeLaPartida
	|ronda|
	ronda := RondaDeTruco cartasDeMano: {CartaDeTruco bastoCon: 1. CartaDeTruco bastoCon: 2. CartaDeTruco bastoCon: 3.} 
		cartasDePie: {CartaDeTruco copaCon: 1. CartaDeTruco copaCon: 2. CartaDeTruco anchoDeEspada.}.
		
	self should: [ ronda ganador.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText = RondaDeTruco rondaTodaviaNoTerminoErrorDescription]
! !

!RondaDeTrucoTest methodsFor: 'winning tests' stamp: 'ET 7/5/2021 21:36:14'!
test17ManoGanaLaRondaAlGanarLosDosPrimerosEnfrentamientos
	|ronda|
	ronda := RondaDeTruco cartasDeMano: {CartaDeTruco bastoCon: 1. CartaDeTruco bastoCon: 2. CartaDeTruco bastoCon: 3.} 
		cartasDePie: {CartaDeTruco copaCon: 1. CartaDeTruco copaCon: 2. CartaDeTruco anchoDeEspada.}.
		
	ronda manoJuegaCarta: 1.
	ronda pieJuegaCarta: 2.
	
	ronda manoJuegaCarta: 3.
	ronda pieJuegaCarta: 1.
	
	self assert: ronda terminoRonda.
	self assert: #mano equals: (ronda ganadorDeEnfrentamientoOEmpate: 1).
	self assert: #mano equals: (ronda ganadorDeEnfrentamientoOEmpate: 2).
	self assert: #mano equals: ronda ganador.
! !

!RondaDeTrucoTest methodsFor: 'winning tests' stamp: 'ET 7/5/2021 21:36:44'!
test18ManoGanaLaRondaAlGanarElPrimerYUltimoEnfrentamiento
	|ronda|
	ronda := RondaDeTruco cartasDeMano: {CartaDeTruco bastoCon: 1. CartaDeTruco bastoCon: 2. CartaDeTruco bastoCon: 3.} 
		cartasDePie: {CartaDeTruco copaCon: 1. CartaDeTruco copaCon: 2. CartaDeTruco anchoDeEspada.}.
		
	ronda manoJuegaCarta: 1.
	ronda pieJuegaCarta: 2.
	
	ronda manoJuegaCarta: 2.
	ronda pieJuegaCarta: 3.
	
	ronda pieJuegaCarta: 1.
	ronda manoJuegaCarta: 3.
	
	self assert: #mano equals: (ronda ganadorDeEnfrentamientoOEmpate: 1).
	self assert: #pie equals: (ronda ganadorDeEnfrentamientoOEmpate: 2).
	self assert: #mano equals: (ronda ganadorDeEnfrentamientoOEmpate: 3).
	self assert: ronda terminoRonda.
	self assert: #mano equals: ronda ganador.
! !

!RondaDeTrucoTest methodsFor: 'winning tests' stamp: 'ET 7/5/2021 21:37:01'!
test19PieGanaLaRondaAlGanarElPrimerYUltimoEnfrentamiento
	|ronda|
	ronda := RondaDeTruco cartasDeMano: {CartaDeTruco bastoCon: 1. CartaDeTruco bastoCon: 2. CartaDeTruco bastoCon: 3.} 
		cartasDePie: {CartaDeTruco copaCon: 1. CartaDeTruco sieteDeEspada . CartaDeTruco anchoDeEspada.}.
		
	ronda manoJuegaCarta: 1.
	ronda pieJuegaCarta: 3.
	
	ronda pieJuegaCarta: 1.
	ronda manoJuegaCarta: 3.
	
	ronda manoJuegaCarta: 2.
	ronda pieJuegaCarta: 2.
	
	self assert: #pie equals: (ronda ganadorDeEnfrentamientoOEmpate: 1).
	self assert: #mano equals: (ronda ganadorDeEnfrentamientoOEmpate: 2).
	self assert: #pie equals: (ronda ganadorDeEnfrentamientoOEmpate: 3).
	self assert: ronda terminoRonda.
	self assert: #pie equals: ronda ganador.
! !

!RondaDeTrucoTest methodsFor: 'winning tests' stamp: 'ET 7/5/2021 21:49:51'!
test20PieGanaLaRondaAlGanarLosDosPrimerosEnfrentamientos
	|ronda|
	ronda := RondaDeTruco cartasDeMano: {CartaDeTruco bastoCon: 1. CartaDeTruco bastoCon: 2. CartaDeTruco bastoCon: 3.} 
		cartasDePie: {CartaDeTruco copaCon: 1. CartaDeTruco sieteDeEspada. CartaDeTruco anchoDeEspada.}.
		
	ronda manoJuegaCarta: 1.
	ronda pieJuegaCarta: 3.
	
	ronda pieJuegaCarta: 2.
	ronda manoJuegaCarta: 2.
	
	
	self assert: ronda terminoRonda.
	self assert: #pie equals: (ronda ganadorDeEnfrentamientoOEmpate: 1).
	self assert: #pie equals: (ronda ganadorDeEnfrentamientoOEmpate: 2).
	self assert: #pie equals: ronda ganador.
! !

!RondaDeTrucoTest methodsFor: 'winning tests' stamp: 'ET 7/5/2021 21:52:13'!
test21PieNoPuedeJugarSiYaTerminoLaRonda
	|ronda|
	ronda := RondaDeTruco cartasDeMano: {CartaDeTruco bastoCon: 1. CartaDeTruco bastoCon: 2. CartaDeTruco bastoCon: 3.} 
		cartasDePie: {CartaDeTruco copaCon: 1. CartaDeTruco sieteDeEspada. CartaDeTruco anchoDeEspada.}.
		
	ronda manoJuegaCarta: 1.
	ronda pieJuegaCarta: 3.
	
	ronda pieJuegaCarta: 2.
	ronda manoJuegaCarta: 2.
	
	self should: [ronda pieJuegaCarta: 1]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText = RondaDeTruco rondaTerminadaErrorDescription].! !

!RondaDeTrucoTest methodsFor: 'winning tests' stamp: 'ET 7/5/2021 21:52:22'!
test22ManoNoPuedeJugarSiYaTerminoLaRonda
	|ronda|
	ronda := RondaDeTruco cartasDeMano: {CartaDeTruco bastoCon: 1. CartaDeTruco bastoCon: 2. CartaDeTruco bastoCon: 3.} 
		cartasDePie: {CartaDeTruco copaCon: 1. CartaDeTruco copaCon: 2. CartaDeTruco anchoDeEspada.}.
		
	ronda manoJuegaCarta: 1.
	ronda pieJuegaCarta: 2.
	
	ronda manoJuegaCarta: 3.
	ronda pieJuegaCarta: 1.
	
	self should: [ronda manoJuegaCarta: 2]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText = RondaDeTruco rondaTerminadaErrorDescription].
! !


!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ET 7/5/2021 21:11:39'!
test05NuevaRondaDeTrucoNoEstaTerminada
	|ronda|
	ronda := RondaDeTruco cartasDeMano: {CartaDeTruco bastoCon: 1. CartaDeTruco bastoCon: 2. CartaDeTruco bastoCon: 3.} 
		cartasDePie: {CartaDeTruco copaCon: 1. CartaDeTruco copaCon: 2. CartaDeTruco anchoDeEspada.}.
		
	self deny: ronda terminoRonda.
	self assert: 1 equals: ronda ultimoNumeroDeEnfrentamiento.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ET 7/5/2021 21:11:39'!
test06NoLeTocaJugarAPieCuandoSeCreaLaRondaDeTruco
	|ronda|
	ronda := RondaDeTruco cartasDeMano: {CartaDeTruco bastoCon: 1. CartaDeTruco bastoCon: 2. CartaDeTruco bastoCon: 3.} 
		cartasDePie: {CartaDeTruco copaCon: 1. CartaDeTruco copaCon: 2. CartaDeTruco anchoDeEspada.}.
		
	self should: [ronda pieJuegaCarta: 1 ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError | 
		self assert: anError messageText = RondaDeTruco invalidPlayerTurnErrorDescripton.
		self deny: ronda terminoRonda.
		self assert: 1 equals: ronda ultimoNumeroDeEnfrentamiento.]! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ET 7/5/2021 21:11:39'!
test07ManoNoPuedeJugarDosVecesSeguidasEnElPrimerEnfrentamiento
	|ronda|
	ronda := RondaDeTruco cartasDeMano: {CartaDeTruco bastoCon: 1. CartaDeTruco bastoCon: 2. CartaDeTruco bastoCon: 3.} 
		cartasDePie: {CartaDeTruco copaCon: 1. CartaDeTruco copaCon: 2. CartaDeTruco anchoDeEspada.}.
		
	ronda manoJuegaCarta: 1.
	
	self should: [ronda manoJuegaCarta: 2 ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError | 
		self assert: anError messageText = RondaDeTruco invalidPlayerTurnErrorDescripton.
		self deny: ronda terminoRonda.
		self assert: 1 equals: ronda ultimoNumeroDeEnfrentamiento.]! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ET 7/5/2021 20:42:21'!
test08PieNoPuedeEmpezarElSegundoEnfrentamientoSiManoGanoElPrimero
	|ronda|
	ronda := RondaDeTruco cartasDeMano: {CartaDeTruco bastoCon: 1. CartaDeTruco bastoCon: 2. CartaDeTruco bastoCon: 3.} 
		cartasDePie: {CartaDeTruco copaCon: 1. CartaDeTruco copaCon: 2. CartaDeTruco anchoDeEspada.}.
		
	ronda manoJuegaCarta: 1.
	ronda pieJuegaCarta: 1.
	
	self should: [ronda pieJuegaCarta: 2]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError | self assert: anError messageText = RondaDeTruco invalidPlayerTurnErrorDescripton]! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ET 7/5/2021 21:11:39'!
test09ManoNoPuedeUsarLaMismaCartaDosVeces
	|ronda|
	ronda := RondaDeTruco cartasDeMano: {CartaDeTruco bastoCon: 1. CartaDeTruco bastoCon: 2. CartaDeTruco bastoCon: 3.} 
		cartasDePie: {CartaDeTruco copaCon: 1. CartaDeTruco copaCon: 2. CartaDeTruco anchoDeEspada.}.
		
	ronda manoJuegaCarta: 1.
	ronda pieJuegaCarta: 1.
	
	self should: [ronda manoJuegaCarta: 1]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError | 
		self assert: anError messageText = RondaDeTruco invalidCardSelectionErrorDescription.
		self deny: ronda terminoRonda.
		self assert: 2 equals: ronda ultimoNumeroDeEnfrentamiento.]! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ET 7/5/2021 21:11:39'!
test10PieNoPuedeUsarLaMismaCartaDosVeces
	|ronda|
	ronda := RondaDeTruco cartasDeMano: {CartaDeTruco bastoCon: 1. CartaDeTruco bastoCon: 2. CartaDeTruco bastoCon: 3.} 
		cartasDePie: {CartaDeTruco copaCon: 1. CartaDeTruco copaCon: 2. CartaDeTruco anchoDeEspada.}.
		
	ronda manoJuegaCarta: 1.
	ronda pieJuegaCarta: 1.
	ronda manoJuegaCarta: 2.
	self should: [ronda pieJuegaCarta: 1]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError | 
		self assert: anError messageText = RondaDeTruco invalidCardSelectionErrorDescription.
		self deny: ronda terminoRonda.
		self assert: 2 equals: ronda ultimoNumeroDeEnfrentamiento.]! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ET 7/5/2021 21:11:39'!
test11ManoJuegaCartaConMayorValorQueLaCartaDePieGanaEnfrentamientoMano
	|ronda|
	ronda := RondaDeTruco cartasDeMano: {CartaDeTruco bastoCon: 1. CartaDeTruco bastoCon: 2. CartaDeTruco bastoCon: 3.} 
		cartasDePie: {CartaDeTruco copaCon: 1. CartaDeTruco copaCon: 2. CartaDeTruco anchoDeEspada.}.
		
	ronda manoJuegaCarta: 1.
	ronda pieJuegaCarta: 1.

	self assert: #mano equals: (ronda ganadorDeEnfrentamientoOEmpate: 1).
	self deny: ronda terminoRonda.
	self assert: 2 equals: ronda ultimoNumeroDeEnfrentamiento. ! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ET 7/5/2021 21:11:39'!
test12PieJuegaCartaConMayorValorQueLaCartaDeManoGanaEnfrentamientoPie
	|ronda|
	ronda := RondaDeTruco cartasDeMano: {CartaDeTruco bastoCon: 1. CartaDeTruco bastoCon: 2. CartaDeTruco bastoCon: 3.} 
		cartasDePie: {CartaDeTruco copaCon: 1. CartaDeTruco copaCon: 2. CartaDeTruco anchoDeEspada.}.
		
	ronda manoJuegaCarta: 2.
	ronda pieJuegaCarta: 3.

	self assert: #pie equals: (ronda ganadorDeEnfrentamientoOEmpate: 1).
	self deny: ronda terminoRonda.
	self assert: 2 equals: ronda ultimoNumeroDeEnfrentamiento. ! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ET 7/5/2021 21:11:39'!
test13PieYManoJueganCartaConMismoValorEntoncesEmpatanElEnfrentamiento
	|ronda|
	ronda := RondaDeTruco cartasDeMano: {CartaDeTruco bastoCon: 1. CartaDeTruco bastoCon: 2. CartaDeTruco bastoCon: 3.} 
		cartasDePie: {CartaDeTruco copaCon: 1. CartaDeTruco copaCon: 2. CartaDeTruco anchoDeEspada.}.
		
	ronda manoJuegaCarta: 2.
	ronda pieJuegaCarta: 2.

	self assert: #empate equals: (ronda ganadorDeEnfrentamientoOEmpate: 1).
	self deny: ronda terminoRonda.
	self assert: 2 equals: ronda ultimoNumeroDeEnfrentamiento. ! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ET 7/5/2021 20:49:06'!
test14EmpateEnPrimerEnfrentamientoSignificaQueManoEmpiezaElSegundoEnfrentamiento
	|ronda|
	ronda := RondaDeTruco cartasDeMano: {CartaDeTruco bastoCon: 1. CartaDeTruco bastoCon: 2. CartaDeTruco bastoCon: 3.} 
		cartasDePie: {CartaDeTruco copaCon: 1. CartaDeTruco copaCon: 2. CartaDeTruco anchoDeEspada.}.
		
	ronda manoJuegaCarta: 2.
	ronda pieJuegaCarta: 2.

	self should: [ronda pieJuegaCarta: 1]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError | 
		self assert: anError messageText = RondaDeTruco invalidPlayerTurnErrorDescripton.]! !


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


!classDefinition: #EnfrentamientoDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #EnfrentamientoDeTruco
	instanceVariableNames: 'cartaJugadaPorPie cartaJugadaPorMano'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!EnfrentamientoDeTruco methodsFor: 'jugar carta' stamp: 'ET 7/5/2021 19:35:43'!
cartaMano: cartaDeTrucoJugadaPorMano
	cartaJugadaPorMano := cartaDeTrucoJugadaPorMano.! !

!EnfrentamientoDeTruco methodsFor: 'jugar carta' stamp: 'ET 7/5/2021 19:31:24'!
cartaPie: cartaDeTrucoJugadaPorPie
	
	cartaJugadaPorPie := cartaDeTrucoJugadaPorPie.! !


!EnfrentamientoDeTruco methodsFor: 'testing' stamp: 'ET 7/5/2021 19:44:00'!
ganador
	(cartaJugadaPorPie mataA: cartaJugadaPorMano) ifTrue: [^#pie].
	(cartaJugadaPorMano mataA: cartaJugadaPorPie) ifTrue: [^#mano].
	
	self error: self class noWinnerErrorDescription.! !

!EnfrentamientoDeTruco methodsFor: 'testing' stamp: 'ET 7/5/2021 19:40:06'!
huboEmpate
	^cartaJugadaPorPie empardaCon: cartaJugadaPorMano.! !

!EnfrentamientoDeTruco methodsFor: 'testing' stamp: 'ET 7/5/2021 19:38:15'!
terminoEnfrentamiento
	
	^cartaJugadaPorMano notNil and: cartaJugadaPorPie notNil! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnfrentamientoDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
EnfrentamientoDeTruco class
	instanceVariableNames: ''!

!EnfrentamientoDeTruco class methodsFor: 'as yet unclassified' stamp: 'ET 7/5/2021 21:41:32'!
noWinnerErrorDescription

	^'Faltan cartas por jugar'.! !


!classDefinition: #RondaDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #RondaDeTruco
	instanceVariableNames: 'cartasDeMano cartasDePie turno cartasJugadas enfrentamientos terminoRonda'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTruco methodsFor: 'initialization' stamp: 'ET 7/5/2021 20:23:17'!
initializeWithCartasDeMano: mano cartasDePie: pie 
	cartasDeMano := mano.
	cartasDePie := pie.
	cartasJugadas := OrderedCollection new.
	turno := #mano.
	enfrentamientos := OrderedCollection with: EnfrentamientoDeTruco new.! !


!RondaDeTruco methodsFor: 'testing' stamp: 'ET 7/5/2021 21:39:19'!
ganador
	
	self terminoRonda ifFalse: [self error: self class rondaTodaviaNoTerminoErrorDescription].
	
	^enfrentamientos last ganador.! !

!RondaDeTruco methodsFor: 'testing' stamp: 'ET 7/5/2021 20:37:35'!
ganadorDeEnfrentamientoOEmpate: numeroDeEnfrentamiento
	|enfrentamiento|
	enfrentamiento := enfrentamientos at: numeroDeEnfrentamiento.
	enfrentamiento huboEmpate ifTrue: [^#empate].
	^enfrentamiento ganador.! !

!RondaDeTruco methodsFor: 'testing' stamp: 'ET 7/5/2021 21:17:42'!
terminoRonda
	
	self ultimoNumeroDeEnfrentamiento = 1 ifTrue: [^false].
	
	^self terminoRondaEnSegundoEnfrentamiento or: [self ultimoNumeroDeEnfrentamiento = 3 and: enfrentamientos last terminoEnfrentamiento].! !

!RondaDeTruco methodsFor: 'testing' stamp: 'ET 7/5/2021 21:11:39'!
terminoRondaEnSegundoEnfrentamiento

	self ultimoNumeroDeEnfrentamiento = 2 ifFalse: [^false].

	enfrentamientos second terminoEnfrentamiento ifTrue: [
		^enfrentamientos first huboEmpate or: [enfrentamientos first ganador = enfrentamientos second ganador]
		].
	^false.

	! !

!RondaDeTruco methodsFor: 'testing' stamp: 'ET 7/5/2021 21:11:39'!
ultimoNumeroDeEnfrentamiento
	^enfrentamientos size.! !


!RondaDeTruco methodsFor: 'assertions' stamp: 'ET 7/5/2021 19:02:27'!
assertCartaAJugarNoFueJugadaAntes: aCard

	(cartasJugadas includes: aCard) ifTrue: [self error: self class invalidCardSelectionErrorDescription]! !

!RondaDeTruco methodsFor: 'assertions' stamp: 'ET 7/5/2021 20:16:12'!
assertTurnoEsDe: jugador
	
	turno = jugador ifFalse: [self error: self class invalidPlayerTurnErrorDescripton]! !


!RondaDeTruco methodsFor: 'jugar' stamp: 'ET 7/5/2021 21:48:24'!
assertRondaNoEstaTerminada
	
	self terminoRonda ifTrue: [self error: self class rondaTerminadaErrorDescription]! !

!RondaDeTruco methodsFor: 'jugar' stamp: 'ET 7/5/2021 21:51:54'!
manoJuegaCarta: numeroDeCarta

	|cartaAJugar enfrentamiento|
	cartaAJugar := cartasDeMano at: numeroDeCarta.
	self assertRondaNoEstaTerminada.
	self assertTurnoEsDe: #mano.
	self assertCartaAJugarNoFueJugadaAntes: cartaAJugar.
	enfrentamiento := enfrentamientos last.
	enfrentamiento cartaMano: cartaAJugar.
	enfrentamiento  terminoEnfrentamiento ifTrue: [
		self terminoRonda ifFalse: [enfrentamientos add: EnfrentamientoDeTruco new].
		turno := enfrentamiento ganador] ifFalse: [turno := #pie].
	cartasJugadas add: cartaAJugar.
	
	! !

!RondaDeTruco methodsFor: 'jugar' stamp: 'ET 7/5/2021 21:47:24'!
pieJuegaCarta: numeroDeCarta
	|cartaAJugar enfrentamiento|
	cartaAJugar := cartasDePie at: numeroDeCarta.
	self assertRondaNoEstaTerminada.
	self assertTurnoEsDe: #pie.
	self assertCartaAJugarNoFueJugadaAntes: cartaAJugar.
	enfrentamiento := enfrentamientos last.
	enfrentamiento cartaPie: cartaAJugar.
	enfrentamiento terminoEnfrentamiento ifTrue: [
		self terminoRonda ifFalse: [enfrentamientos add: EnfrentamientoDeTruco new].
		enfrentamiento huboEmpate ifTrue: [turno := #mano] ifFalse: [turno := enfrentamiento ganador]
		] ifFalse: [turno := #mano].
	cartasJugadas add: cartaAJugar.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RondaDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco class
	instanceVariableNames: ''!

!RondaDeTruco class methodsFor: 'instance creation' stamp: 'ET 7/5/2021 18:00:32'!
cartasDeMano: cartasDeMano cartasDePie: cartasDePie

	self assertNumberOfCards: cartasDeMano.
	self assertNumberOfCards: cartasDePie.
	
	self assertNoHayCartasRepetidasEntreMano: cartasDeMano yPie: cartasDePie.

	^self new initializeWithCartasDeMano: cartasDeMano cartasDePie: cartasDePie.! !


!RondaDeTruco class methodsFor: 'assertions' stamp: 'ET 7/5/2021 18:11:17'!
assertNoHayCartasRepetidasEntreMano: cartasDeMano yPie: cartasDePie
	|cartas|
	cartas := cartasDeMano asSet.
	cartas addAll: cartasDePie.
	cartas size = 6 ifFalse: [self error: self repeatedCardsErrorDescription].! !

!RondaDeTruco class methodsFor: 'assertions' stamp: 'ET 7/5/2021 18:02:59'!
assertNumberOfCards: cards 
	
	cards size = 3 ifFalse: [self error: self invalidNumberOfCardsErrorDescription].! !


!RondaDeTruco class methodsFor: 'error messages' stamp: 'ET 7/5/2021 18:58:18'!
invalidCardSelectionErrorDescription
	
	^'La carta seleccionada ya ha sido jugada'! !

!RondaDeTruco class methodsFor: 'error messages' stamp: 'ET 7/5/2021 17:52:51'!
invalidNumberOfCardsErrorDescription
	
	^'Alguno de los jugadores no tiene tres cartas'.! !

!RondaDeTruco class methodsFor: 'error messages' stamp: 'ET 7/5/2021 18:26:42'!
invalidPlayerTurnErrorDescripton
	
	^'Es el turno del otro jugador'.! !

!RondaDeTruco class methodsFor: 'error messages' stamp: 'ET 7/5/2021 17:58:05'!
repeatedCardsErrorDescription
	
	
	^'Hay cartas repetidas'.! !

!RondaDeTruco class methodsFor: 'error messages' stamp: 'ET 7/5/2021 21:48:45'!
rondaTerminadaErrorDescription

	^'La ronda ya ha terminado'.! !

!RondaDeTruco class methodsFor: 'error messages' stamp: 'ET 7/5/2021 20:46:46'!
rondaTodaviaNoTerminoErrorDescription
	
	
	^'La ronda todavía continua'.! !
