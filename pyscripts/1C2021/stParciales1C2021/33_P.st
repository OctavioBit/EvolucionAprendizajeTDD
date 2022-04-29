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

!JugadorTest methodsFor: 'testing' stamp: 'G.L.S 7/5/2021 21:41:42'!
test01LosJugadoresNoPuedenJugarCartasYaUtilizadas
	
	| jugador1 jugador2 ronda |
	
	jugador1  := Jugador conMano: {CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 3. CartaDeTruco bastoCon: 7.}.
	jugador2 := Jugador conMano: {CartaDeTruco anchoDeBasto. CartaDeTruco espadaCon: 5. CartaDeTruco oroCon: 3.}.
	
	ronda := Ronda mano: jugador1 pie: jugador2.
	
	self should: [
		jugador1 jugarCarta: (CartaDeTruco espadaCon: 3) enRonda: ronda.
		jugador2 jugarCarta: (CartaDeTruco oroCon: 3) enRonda: ronda.
		jugador1 jugarCarta: (CartaDeTruco espadaCon: 3) enRonda: ronda.
		]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText = Jugador errorNoPoseeEsaCarta.
			].! !


!classDefinition: #RondaTest category: 'ISW1-2021-1C-2doParcial'!
TestCase subclass: #RondaTest
	instanceVariableNames: 'jugador1 jugador2 jugadorQueVaAPerder jugadorQueVaAGanar jugadorSinCartas jugadorQueHaceTrampa otroJugadorQueHaceTrampa'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaTest methodsFor: 'testing' stamp: 'G.L.S 7/5/2021 21:32:02'!
test01SoloLaManoPuedeEmpezarLaPrimeraJugada
	
	| ronda |
	
	ronda := Ronda mano: jugador1 pie: jugador2.
	
	self should: [
		jugador2 jugarCarta: (CartaDeTruco oroCon: 3) enRonda: ronda.
		] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText = Ronda errorOrdenDeJugadaIncorrecto.
			].! !

!RondaTest methodsFor: 'testing' stamp: 'G.L.S 7/5/2021 21:31:57'!
test02UnJugadorNoPuedeRealizarDosJugadasSeguidasEnUnEnfrentamiento
	
	| ronda |
	
	ronda := Ronda mano: jugador1 pie: jugador2.
	
	self should: [
		jugador1 jugarCarta: (CartaDeTruco espadaCon: 3) enRonda: ronda.
		jugador1 jugarCarta: CartaDeTruco anchoDeEspada enRonda: ronda.
		] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText = Ronda errorOrdenDeJugadaIncorrecto.
			].! !

!RondaTest methodsFor: 'testing' stamp: 'G.L.S 7/5/2021 21:56:41'!
test03ElJugadorQueGanoElEnfrentamientoAnteriorEsElQueEmpiezaEnElEnfrentamientoSiguiente
	
	| ronda |
	
	ronda := Ronda mano: jugador1 pie: jugador2.
	
	self should: [
		jugador1 jugarCarta: (CartaDeTruco bastoCon: 7) enRonda: ronda.
		jugador2 jugarCarta: CartaDeTruco anchoDeBasto enRonda: ronda.
		jugador1 jugarCarta: (CartaDeTruco anchoDeEspada) enRonda: ronda.
		] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText = Ronda errorOrdenDeJugadaIncorrecto.
			].! !

!RondaTest methodsFor: 'testing' stamp: 'G.L.S 7/5/2021 21:31:08'!
test04SiEmpataronLaPrimerRondaLaManoEsLaQueSigue
	
	| ronda |
	
	ronda := Ronda mano: jugador1 pie: jugador2.
	
	self should: [
		jugador1 jugarCarta: (CartaDeTruco espadaCon: 3) enRonda: ronda.
		jugador2 jugarCarta: (CartaDeTruco oroCon: 3) enRonda: ronda.
		jugador2 jugarCarta: CartaDeTruco anchoDeBasto enRonda: ronda.
		] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText = Ronda errorOrdenDeJugadaIncorrecto.
			].! !

!RondaTest methodsFor: 'testing' stamp: 'G.L.S 7/5/2021 21:30:29'!
test05ElGanadorDeLaRondaEsElCorrecto
	
	| ronda |
	
	ronda := Ronda mano: jugadorQueVaAPerder pie: jugadorQueVaAGanar.
	
	jugadorQueVaAPerder jugarCarta: (CartaDeTruco sieteDeEspada) enRonda: ronda.
	jugadorQueVaAGanar jugarCarta: (CartaDeTruco bastoCon: 2) enRonda: ronda.
	jugadorQueVaAPerder jugarCarta: (CartaDeTruco espadaCon: 2) enRonda: ronda.
	jugadorQueVaAGanar jugarCarta: CartaDeTruco anchoDeBasto enRonda: ronda.
	jugadorQueVaAGanar jugarCarta: CartaDeTruco anchoDeEspada enRonda: ronda.
	jugadorQueVaAPerder jugarCarta: (CartaDeTruco oroCon: 2) enRonda: ronda.
	
	self assert: jugadorQueVaAGanar equals: ronda ganador.! !

!RondaTest methodsFor: 'testing' stamp: 'G.L.S 7/5/2021 21:30:29'!
test06NoSePuedeSeguirJugandoUnaVezQueSeDecidioElGanador
	| ronda |
	
	ronda := Ronda mano: jugadorQueVaAPerder pie: jugadorQueVaAGanar.
	
	jugadorQueVaAPerder jugarCarta: (CartaDeTruco espadaCon: 2) enRonda: ronda.
	jugadorQueVaAGanar jugarCarta: CartaDeTruco anchoDeBasto enRonda: ronda.
	jugadorQueVaAGanar jugarCarta: CartaDeTruco anchoDeEspada enRonda: ronda.
	jugadorQueVaAPerder jugarCarta: (CartaDeTruco oroCon: 2) enRonda: ronda.
	
	self assert: jugadorQueVaAGanar equals: ronda ganador.
	
	self should: [
		jugadorQueVaAGanar jugarCarta: (CartaDeTruco bastoCon: 2) enRonda: ronda.
		] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText = Ronda errorLaRondaYaTermino.
			].! !

!RondaTest methodsFor: 'testing' stamp: 'G.L.S 7/5/2021 21:30:29'!
test07LuegoDeUnEmpateElGanadorDelSiguienteEnfrentamientoGanaLaRonda
	
	| ronda |
	
	ronda := Ronda mano: jugador1 pie: jugador2.
	
	jugador1 jugarCarta: (CartaDeTruco espadaCon: 3) enRonda: ronda.
	jugador2 jugarCarta: (CartaDeTruco oroCon: 3) enRonda: ronda.
	jugador1 jugarCarta: CartaDeTruco anchoDeEspada enRonda: ronda.
	jugador2 jugarCarta: CartaDeTruco anchoDeBasto enRonda: ronda.
	
	self assert: jugador1 equals: ronda ganador.! !

!RondaTest methodsFor: 'testing' stamp: 'G.L.S 7/5/2021 21:18:44'!
test08LosJugadoresDebenTenerTresCartasAlIniciarLaRonda

	self should: [
		Ronda mano: jugadorSinCartas pie: jugador2.
		] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText = Ronda errorLosJugadoresNoEmpezaronConTresCartas.
			].
		
	self should: [
		Ronda mano: jugador1 pie: jugadorSinCartas.
		] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText = Ronda errorLosJugadoresNoEmpezaronConTresCartas.
			].
	
	self should: [
		Ronda mano: jugadorQueHaceTrampa pie: jugador2.
		] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText = Ronda errorLosJugadoresNoEmpezaronConTresCartas.
			].
	
	self should: [
		Ronda mano: jugador1 pie: jugadorQueHaceTrampa.
		] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText = Ronda errorLosJugadoresNoEmpezaronConTresCartas.
			].! !

!RondaTest methodsFor: 'testing' stamp: 'G.L.S 7/5/2021 21:19:02'!
test09LosJugadoresNoPuedenTenerCartasIguales

	self should: [
		Ronda mano: otroJugadorQueHaceTrampa pie: jugador2.
		] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText = Ronda errorLosJugadoresTienenCartasIguales.
			].
		
	self should: [
		Ronda mano: jugador2 pie: otroJugadorQueHaceTrampa.
		] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText = Ronda errorLosJugadoresTienenCartasIguales.
			].! !


!RondaTest methodsFor: 'setUp/tearDown' stamp: 'G.L.S 7/5/2021 21:15:26'!
setUp

	jugador1  := Jugador conMano: {CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 3. CartaDeTruco bastoCon: 7.}.
	jugador2 := Jugador conMano: {CartaDeTruco anchoDeBasto. CartaDeTruco espadaCon: 5. CartaDeTruco oroCon: 3.}.
	
	jugadorQueVaAPerder := Jugador conMano: {CartaDeTruco espadaCon: 2. CartaDeTruco oroCon: 2. CartaDeTruco sieteDeEspada}.
	jugadorQueVaAGanar := Jugador conMano: {CartaDeTruco anchoDeBasto. CartaDeTruco anchoDeEspada. CartaDeTruco bastoCon: 2}.
	
	jugadorSinCartas  := Jugador conMano: {}.
	jugadorQueHaceTrampa := Jugador conMano: {CartaDeTruco anchoDeBasto. CartaDeTruco anchoDeEspada. CartaDeTruco bastoCon: 2. 
											CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 3. CartaDeTruco bastoCon: 7.}.
											
	otroJugadorQueHaceTrampa := Jugador conMano: {CartaDeTruco anchoDeEspada. CartaDeTruco anchoDeBasto. CartaDeTruco bastoCon: 7.}! !


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
	instanceVariableNames: 'manoActual'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Jugador methodsFor: 'initialization' stamp: 'G.L.S 7/5/2021 21:54:09'!
initializeConMano: unaManoDeCartas

	manoActual := Bag new.
	manoActual addAll: unaManoDeCartas.! !



!Jugador methodsFor: 'acciones' stamp: 'G.L.S 7/5/2021 21:43:37'!
asegurarQueSeTieneLaCarta: unaCartaDeTruco
	
	(self tiene: unaCartaDeTruco) ifFalse: [self error: self class errorNoPoseeEsaCarta].
! !

!Jugador methodsFor: 'acciones' stamp: 'G.L.S 7/5/2021 21:45:27'!
jugarCarta: unaCartaDeTruco enRonda: unaRonda
	
	self asegurarQueSeTieneLaCarta: unaCartaDeTruco.
	
	unaRonda registrarJugador: self jugada: unaCartaDeTruco.
	
	self removerCarta: unaCartaDeTruco.! !

!Jugador methodsFor: 'acciones' stamp: 'G.L.S 7/5/2021 21:45:44'!
removerCarta: unaCartaDeTruco

	manoActual remove: unaCartaDeTruco.! !


!Jugador methodsFor: 'mano' stamp: 'G.L.S 7/5/2021 21:05:16'!
tieneActualmente: unaCantidad
	^manoActual size = unaCantidad.! !


!Jugador methodsFor: 'private' stamp: 'G.L.S 7/5/2021 21:12:56'!
comparteCartasCon: unJugador
	
	| comparte |
	comparte := false.
	
	manoActual do: [:carta |
		(unJugador tiene: carta) ifTrue:[comparte := true].
		].
	
	^comparte! !

!Jugador methodsFor: 'private' stamp: 'G.L.S 7/5/2021 21:13:22'!
tiene: unaCarta

	^manoActual includes: unaCarta.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Jugador class' category: 'ISW1-2021-1C-2doParcial'!
Jugador class
	instanceVariableNames: ''!

!Jugador class methodsFor: 'instance creation' stamp: 'G.L.S 7/5/2021 18:13:48'!
conMano: unaManoDeCartas
	^self new initializeConMano: unaManoDeCartas.! !


!Jugador class methodsFor: 'errors' stamp: 'G.L.S 7/5/2021 21:44:25'!
errorNoPoseeEsaCarta
	^'Error - El Jugador no posee esta carta'.! !


!classDefinition: #Ronda category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #Ronda
	instanceVariableNames: 'mano pie jugadorSiguiente jugadas victoriasMano victoriasPie'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Ronda methodsFor: 'initialization' stamp: 'G.L.S 7/5/2021 21:33:32'!
initializeWithMano: unJugador pie: otroJugador

	self asegurarQueJugadorTieneLaCantidadCorrectaDeCartas: unJugador.
	self asegurarQueJugadorTieneLaCantidadCorrectaDeCartas: otroJugador.
	
	self asegurarQueJugador: unJugador noComparteCartasCon: otroJugador.

	mano := unJugador.
	pie := otroJugador.
	
	victoriasMano := 0.
	victoriasPie := 0.
	
	jugadorSiguiente  := mano.
	jugadas := Dictionary new.! !


!Ronda methodsFor: 'registro jugadas' stamp: 'G.L.S 7/5/2021 20:05:46'!
calcularGanadorDeJugada

	| carta1 carta2 |
	carta1 := (jugadas at: mano).
	carta2 := (jugadas at: pie).
			
	(carta1 mataA: carta2) ifTrue: [^self ganoLaMano].
	(carta1 empardaCon: carta2) ifFalse: [^self ganoElPie].
	
	self empataronElEnfrentamiento.
	! !

!Ronda methodsFor: 'registro jugadas' stamp: 'G.L.S 7/5/2021 20:53:23'!
empataronElEnfrentamiento
	
	jugadorSiguiente := mano.
	victoriasPie := victoriasPie + 1.
	victoriasMano := victoriasMano + 1.
	
	jugadas removeAll.
	! !

!Ronda methodsFor: 'registro jugadas' stamp: 'G.L.S 7/5/2021 20:43:24'!
ganoElPie

	jugadorSiguiente := pie.
	victoriasPie := victoriasPie + 1.
	
	jugadas removeAll.
	! !

!Ronda methodsFor: 'registro jugadas' stamp: 'G.L.S 7/5/2021 20:43:19'!
ganoLaMano

	jugadorSiguiente := mano.
	victoriasMano := victoriasMano + 1.
	
	jugadas removeAll.! !

!Ronda methodsFor: 'registro jugadas' stamp: 'G.L.S 7/5/2021 19:08:12'!
jugaronTodos
	
	^(jugadas size = 2).	! !

!Ronda methodsFor: 'registro jugadas' stamp: 'G.L.S 7/5/2021 21:40:09'!
registrarJugador: aJugador jugada: aCartaDeTruco 
	
	self asegurarQueLaRondaNoHayaTerminado.
	self asegurarQueSeaElJugadorCorrecto: aJugador.
	
	jugadas add: aJugador -> aCartaDeTruco.
	
	self jugaronTodos 
		ifTrue: [self calcularGanadorDeJugada.] 
		ifFalse: [self esperarAJugadorQueSigueA: aJugador.].
	
	
	! !


!Ronda methodsFor: 'private' stamp: 'G.L.S 7/5/2021 21:19:59'!
asegurarQueJugador: unJugador noComparteCartasCon: otroJugador

	(unJugador comparteCartasCon: otroJugador) ifTrue: [self error: self class errorLosJugadoresTienenCartasIguales].! !

!Ronda methodsFor: 'private' stamp: 'G.L.S 7/5/2021 21:20:15'!
asegurarQueJugadorTieneLaCantidadCorrectaDeCartas: unJugador

	(unJugador tieneActualmente: 3) ifFalse: [self error: self class errorLosJugadoresNoEmpezaronConTresCartas].
! !

!Ronda methodsFor: 'private' stamp: 'G.L.S 7/5/2021 20:49:39'!
asegurarQueLaRondaNoHayaTerminado

	((victoriasMano = 2) or: [(victoriasPie = 2)]) ifTrue: [self error: self class errorLaRondaYaTermino].

	! !

!Ronda methodsFor: 'private' stamp: 'G.L.S 7/5/2021 18:22:11'!
asegurarQueSeaElJugadorCorrecto: aJugador 
	
	(jugadorSiguiente = aJugador) ifFalse: [self error: self class errorOrdenDeJugadaIncorrecto]! !

!Ronda methodsFor: 'private' stamp: 'G.L.S 7/5/2021 19:33:33'!
esperarAJugadorQueSigueA: aJugador 
	(mano = aJugador) ifTrue: [jugadorSiguiente := pie. ^self].
	jugadorSiguiente := mano.! !


!Ronda methodsFor: 'ganador' stamp: 'G.L.S 7/5/2021 20:23:49'!
ganador

	(victoriasMano = 2) ifTrue:[^mano].
	(victoriasPie = 2) ifTrue:[^pie].
	
	"Posible error acá".! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ronda class' category: 'ISW1-2021-1C-2doParcial'!
Ronda class
	instanceVariableNames: ''!

!Ronda class methodsFor: 'instance creation' stamp: 'G.L.S 7/5/2021 18:09:37'!
mano: unJugador pie: otroJugador

	^self new initializeWithMano: unJugador pie: otroJugador.! !


!Ronda class methodsFor: 'errors' stamp: 'G.L.S 7/5/2021 20:50:15'!
errorLaRondaYaTermino
	^'Error - La ronda ya terminó, no se pueden realizar más jugadas'.! !

!Ronda class methodsFor: 'errors' stamp: 'G.L.S 7/5/2021 21:06:02'!
errorLosJugadoresNoEmpezaronConTresCartas
	^'Error - Algún jugador no tiene exactamente 3 cartas en mano'.! !

!Ronda class methodsFor: 'errors' stamp: 'G.L.S 7/5/2021 21:09:09'!
errorLosJugadoresTienenCartasIguales
	^'Error - Los jugadores tienen la misma carta'.! !

!Ronda class methodsFor: 'errors' stamp: 'G.L.S 7/5/2021 18:23:26'!
errorOrdenDeJugadaIncorrecto
	^'Error - Se realizó una jugada en el orden incorrecto'.! !
