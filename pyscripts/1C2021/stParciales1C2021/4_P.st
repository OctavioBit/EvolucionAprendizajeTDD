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
test20FallaBuscandoValorDeCartaInv�lida

	"Creo una carta de manera inv�lida para probar la correctitud del la tabla de valores - Hernan"
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

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'GDH 7/5/2021 18:32:59'!
test01CrearRondaConManoDelPrimerJugadorConMenosDeTresCartasDebeTirarError
	
	| manoDelPrimero |
	
	manoDelPrimero := Set with: CartaDeTruco anchoDeBasto .
	
	self should: [ RondaDeTruco conCartasDelPrimero: manoDelPrimero yCartasDeSegundo: self defaultManoSegundo ]
		raise: Error - MessageNotUnderstood 
		withMessageText: 'Las cartas de les jugadores deben tener 3 cartas.'! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'GDH 7/5/2021 18:33:03'!
test02CrearRondaConManoDelSegundoJugadorConMenosDeTresCartasDebeTirarError
	
	| manoDelSegundo |
	
	manoDelSegundo := Set with: CartaDeTruco anchoDeBasto .
	
	self should: [ RondaDeTruco conCartasDelPrimero: self defaultManoPrimero yCartasDeSegundo: manoDelSegundo ]
		raise: Error - MessageNotUnderstood 
		withMessageText: 'Las cartas de les jugadores deben tener 3 cartas.'! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'GDH 7/5/2021 18:33:20'!
test03CrearRondaConManoDelPrimerJugadorConMasDeTresCartasDebeTirarError
	
	| manoDelPrimero |
	
	manoDelPrimero := Set with: CartaDeTruco anchoDeEspada 
					        with: CartaDeTruco sieteDeEspada 
						with: CartaDeTruco sieteDeOro 
						with: (CartaDeTruco espadaCon: 4).
	
	self should: [ RondaDeTruco conCartasDelPrimero: manoDelPrimero yCartasDeSegundo: self defaultManoSegundo ]
		raise: Error - MessageNotUnderstood 
		withMessageText: 'Las cartas de les jugadores deben tener 3 cartas.'! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'GDH 7/5/2021 18:33:36'!
test04CrearRondaConManoDelSegundoJugadorConMasDeTresCartasDebeTirarError
	
	| manoDelSegundo |
	
	manoDelSegundo := Set with: CartaDeTruco anchoDeBasto 
						with: (CartaDeTruco espadaCon: 5)
						with: CartaDeTruco sieteDeOro 
						with: (CartaDeTruco espadaCon: 4).
	
	self should: [ RondaDeTruco conCartasDelPrimero: self defaultManoPrimero yCartasDeSegundo: manoDelSegundo ]
		raise: Error - MessageNotUnderstood 
		withMessageText: 'Las cartas de les jugadores deben tener 3 cartas.'! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'GDH 7/5/2021 18:33:48'!
test05CrearRondaConCartasRepetidasEnManosDebeTirarError

	| mano |
	
	mano := Set with: CartaDeTruco anchoDeEspada 
				with: CartaDeTruco sieteDeEspada 
				with: CartaDeTruco anchoDeBasto .
	
	self should: [ RondaDeTruco conCartasDelPrimero: mano yCartasDeSegundo: mano ]
		raise: Error - MessageNotUnderstood 
		withMessageText: 'Las manos no deben tener cartas repetidas.'! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'GDH 7/5/2021 19:19:40'!
test06JugarUnaCartaDeLaManoDelPrimerJugadorNoDebeEstarMasEnSuMano

	| ronda manoDelPrimero manoDelPrimeroSinAnchoDeEspada |
	
	ronda := self defaultRondaDeTruco.
	
	manoDelPrimero := ronda mirarManoDelPrimerJugador.
	
	manoDelPrimeroSinAnchoDeEspada := ronda mirarManoDelPrimerJugador .
	manoDelPrimeroSinAnchoDeEspada remove: CartaDeTruco anchoDeEspada .
	
	self assert: manoDelPrimero equals: self defaultManoPrimero .
	
	ronda primerJugadorJuega: ( CartaDeTruco anchoDeEspada ).
	
	self assert: ronda mirarManoDelPrimerJugador equals: manoDelPrimeroSinAnchoDeEspada .! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'GDH 7/5/2021 19:24:03'!
test07JugarUnaCartaDeLaManoDelPrimerJugadorQueNoEstaDebeTirarUnError

	| ronda |
	
	ronda := self defaultRondaDeTruco.
	
	self should: [ ronda primerJugadorJuega: CartaDeTruco anchoDeBasto. ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: 'No se puede jugar una carta que el jugador no tiene.'! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'GDH 7/5/2021 19:39:52'!
test08JugarUnaCartaDeLaManoDelSegundoJugadorNoDebeEstarMasEnSuMano

	| ronda manoDelSegundo manoDelSegundoSinAnchoDeBasto |
	
	ronda := self defaultRondaDeTruco.
	
	manoDelSegundo := ronda mirarManoDelSegundoJugador.
	
	manoDelSegundoSinAnchoDeBasto := ronda mirarManoDelSegundoJugador .
	manoDelSegundoSinAnchoDeBasto remove: CartaDeTruco anchoDeBasto .
	
	self assert: manoDelSegundo equals: self defaultManoSegundo .
	
	ronda primerJugadorJuega: CartaDeTruco anchoDeEspada .
	ronda segundoJugadorJuega: CartaDeTruco anchoDeBasto.
	
	self assert: ronda mirarManoDelSegundoJugador equals: manoDelSegundoSinAnchoDeBasto .! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'GDH 7/5/2021 19:24:43'!
test09JugarUnaCartaDeLaManoDelSegundoJugadorQueNoEstaDebeTirarUnError

	| ronda |
	
	ronda := self defaultRondaDeTruco.
	
	ronda primerJugadorJuega: CartaDeTruco anchoDeEspada.
	
	self should: [ ronda segundoJugadorJuega: CartaDeTruco anchoDeEspada. ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: 'No se puede jugar una carta que el jugador no tiene.'! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'GDH 7/5/2021 19:38:19'!
test10SegundoJugadorJuegaPrimeroEnPrimerEnfrentamientoDebeTirarError

	| ronda |
	
	ronda := self defaultRondaDeTruco.
		
	self should: [ ronda segundoJugadorJuega: CartaDeTruco anchoDeBasto . ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: 'Debe jugar el otro jugador primero.'! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'GDH 7/5/2021 20:16:39'!
test11SiSegundoJugadorGanoLaRondaAnteriorDebeJugarElSegundoJugador

	| ronda |
	
	ronda := self defaultRondaDeTruco.
	
	ronda primerJugadorJuega: CartaDeTruco sieteDeEspada .
	ronda segundoJugadorJuega: CartaDeTruco anchoDeBasto .
		
	self should: [ ronda primerJugadorJuega: CartaDeTruco anchoDeEspada . ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: 'Debe jugar el otro jugador primero.'! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'GDH 7/5/2021 21:30:08'!
test12SiPrimerJugadorGanoLaRondaAnteriorDebeJugarElPrimerJugador

	| ronda |
	
	ronda := self defaultRondaDeTruco.
	
	ronda primerJugadorJuega: CartaDeTruco anchoDeEspada .
	ronda segundoJugadorJuega: CartaDeTruco anchoDeBasto .
		
	self should: [ ronda segundoJugadorJuega: (CartaDeTruco oroCon: 3). ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: 'Debe jugar el otro jugador primero.'! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'GDH 7/5/2021 21:30:19'!
test13SiPardaElPrimerEnfrentamientoJuegaElPrimerJugador

	| ronda |
	
	ronda := self defaultRondaDeTruco.
	
	ronda primerJugadorJuega: (CartaDeTruco oroCon: 4).
	ronda segundoJugadorJuega: (CartaDeTruco copaCon: 4) .
		
	self should: [ ronda segundoJugadorJuega: (CartaDeTruco oroCon: 3). ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: 'Debe jugar el otro jugador primero.'! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'GDH 7/5/2021 21:31:50'!
test14SiPrimerJugadorGanaDosEnfrentamientosDebeGanarElPrimerJugador

	| ronda |
	
	ronda := self defaultRondaDeTruco.
	
	ronda primerJugadorJuega: CartaDeTruco anchoDeEspada .
	ronda segundoJugadorJuega: CartaDeTruco anchoDeBasto .
	
	ronda primerJugadorJuega: CartaDeTruco sieteDeEspada .
	ronda segundoJugadorJuega: (CartaDeTruco oroCon: 3).
	
	self assert: ronda ganoElPrimerJugador.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'GDH 7/5/2021 21:35:15'!
test15SiSegundoJugadorGanaDosEnfrentamientosDebeGanarElSegundoJugador

	| ronda |
	
	ronda := self defaultRondaDeTruco.
	
	ronda primerJugadorJuega: CartaDeTruco sieteDeEspada .
	ronda segundoJugadorJuega: CartaDeTruco anchoDeBasto .
	
	ronda segundoJugadorJuega: (CartaDeTruco oroCon: 3).
	ronda primerJugadorJuega: (CartaDeTruco oroCon: 4) .
	
	self assert: ronda ganoElSegundoJugador .! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'GDH 7/5/2021 21:36:50'!
test16SiUnJugadorYaGanoNoSeDebeSeguirJugando

	| ronda |
	
	ronda := self defaultRondaDeTruco.
	
	ronda primerJugadorJuega: CartaDeTruco sieteDeEspada .
	ronda segundoJugadorJuega: CartaDeTruco anchoDeBasto .
	
	ronda segundoJugadorJuega: (CartaDeTruco oroCon: 3).
	ronda primerJugadorJuega: (CartaDeTruco oroCon: 4) .
	
	self should: [ ronda segundoJugadorJuega: (CartaDeTruco copaCon: 4). ] 
	 	raise: Error - MessageNotUnderstood 
		withMessageText: 'La ronda ya termino.'
	! !


!RondaDeTrucoTest methodsFor: 'test instance creation' stamp: 'GDH 7/5/2021 18:33:57'!
defaultManoPrimero
	
	^Set with: (CartaDeTruco anchoDeEspada ) 
		with: (CartaDeTruco sieteDeEspada )
		with: (CartaDeTruco oroCon: 4)! !

!RondaDeTrucoTest methodsFor: 'test instance creation' stamp: 'GDH 7/5/2021 18:34:04'!
defaultManoSegundo

	^Set with: (CartaDeTruco oroCon: 3) 
		with: (CartaDeTruco copaCon: 4)
		with: (CartaDeTruco anchoDeBasto )! !

!RondaDeTrucoTest methodsFor: 'test instance creation' stamp: 'GDH 7/5/2021 18:36:28'!
defaultRondaDeTruco

	^RondaDeTruco conCartasDelPrimero: self defaultManoPrimero yCartasDeSegundo: self defaultManoSegundo ! !


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
	
	self assertN�meroEsV�lido: unNumero.
	self assertPaloEsV�lido: unPalo.
	
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
	
	"Cuanto m�s chico sea el �ndice de la carta en esta colecci�n, m�s valor tiene - Hernan"
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
	
	^'Error de programaci�n: Tabla de valores incorrecta o carta inv�lida'! !


!CartaDeTruco class methodsFor: 'assertions' stamp: 'HAW 7/5/2021 11:58:02'!
assertN�meroEsV�lido: unNumero

	unNumero < 1 ifTrue: [ self error: self numeroDeCartaInvalidoErrorDescription ].
	unNumero > 12 ifTrue: [ self error: self numeroDeCartaInvalidoErrorDescription ].
	(unNumero between: 8 and: 9) ifTrue: [ self error: self numeroDeCartaInvalidoErrorDescription ].
	unNumero isInteger ifFalse: [ self error: self numeroDeCartaInvalidoErrorDescription ]! !

!CartaDeTruco class methodsFor: 'assertions' stamp: 'HAW 7/5/2021 11:58:12'!
assertPaloEsV�lido: unPalo

	^ (self palos includes: unPalo) ifFalse: [ self error: self paloInvalidoErrorDescription ]! !


!classDefinition: #EnfrentamientoDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #EnfrentamientoDeTruco
	instanceVariableNames: 'cartaJugadaDelSegundoJugador cantidadDeJugadasDeEnfrentamiento cartaJugadaDelPrimerJugador ronda'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!EnfrentamientoDeTruco methodsFor: 'enfrentar' stamp: 'GDH 7/5/2021 21:38:21'!
determinarSiguienteJugador
	
	(cartaJugadaDelSegundoJugador empardaCon: cartaJugadaDelPrimerJugador) 
		ifTrue: [ ronda parda ] 
		ifFalse: [ (cartaJugadaDelSegundoJugador mataA: cartaJugadaDelPrimerJugador) 
				ifTrue: [ ronda ganaEnfrentamientoSegundo ] 
				ifFalse: [ ronda ganaEnfrentamientoPrimero ]
		]
	! !

!EnfrentamientoDeTruco methodsFor: 'enfrentar' stamp: 'GDH 7/5/2021 21:20:47'!
primerJugadorJuega: unaCartaDeTruco
	
	^self subclassResponsibility ! !

!EnfrentamientoDeTruco methodsFor: 'enfrentar' stamp: 'GDH 7/5/2021 20:52:59'!
segundoJugadorJuega: unaCartaDeTruco
	
	^self subclassResponsibility ! !


!EnfrentamientoDeTruco methodsFor: 'initialization' stamp: 'GDH 7/5/2021 21:22:53'!
intializePara: unaRondaDeTruco
	
	ronda := unaRondaDeTruco .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnfrentamientoDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
EnfrentamientoDeTruco class
	instanceVariableNames: ''!

!EnfrentamientoDeTruco class methodsFor: 'as yet unclassified' stamp: 'GDH 7/5/2021 21:24:27'!
para: unaRondaDeTruco
	
	^self new intializePara: unaRondaDeTruco .! !


!classDefinition: #EmpiezaPrimero category: 'ISW1-2021-1C-2doParcial'!
EnfrentamientoDeTruco subclass: #EmpiezaPrimero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!EmpiezaPrimero methodsFor: 'enfrentar' stamp: 'GDH 7/5/2021 21:26:06'!
primerJugadorJuega: unaCartaDeTruco
	
	ronda siguienteTurno: (TerminaSegundo para: ronda JuegaContra: unaCartaDeTruco) .! !

!EmpiezaPrimero methodsFor: 'enfrentar' stamp: 'GDH 7/5/2021 21:01:37'!
segundoJugadorJuega: unaCartaDeTruco
	
	ronda debeJugarOtroJugador.! !


!classDefinition: #EmpiezaSegundo category: 'ISW1-2021-1C-2doParcial'!
EnfrentamientoDeTruco subclass: #EmpiezaSegundo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!EmpiezaSegundo methodsFor: 'enfrentar' stamp: 'GDH 7/5/2021 21:02:10'!
primerJugadorJuega: unaCartaDeTruco
	
	ronda debeJugarOtroJugador.! !

!EmpiezaSegundo methodsFor: 'enfrentar' stamp: 'GDH 7/5/2021 21:26:12'!
segundoJugadorJuega: unaCartaDeTruco
	
	ronda siguienteTurno: (TerminaPrimero para: ronda JuegaContra: unaCartaDeTruco) .! !


!classDefinition: #TerminaPrimero category: 'ISW1-2021-1C-2doParcial'!
EnfrentamientoDeTruco subclass: #TerminaPrimero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!TerminaPrimero methodsFor: 'initialization' stamp: 'GDH 7/5/2021 21:26:44'!
initializePara: unaRondaDeTruco JugandoContra: unaCartaDeTruco
	
	ronda := unaRondaDeTruco .
	cartaJugadaDelSegundoJugador := unaCartaDeTruco .! !


!TerminaPrimero methodsFor: 'enfrentar' stamp: 'GDH 7/5/2021 21:14:09'!
primerJugadorJuega: unaCartaDeTruco
	
	cartaJugadaDelPrimerJugador := unaCartaDeTruco .
	
	self determinarSiguienteJugador .! !

!TerminaPrimero methodsFor: 'enfrentar' stamp: 'GDH 7/5/2021 21:02:26'!
segundoJugadorJuega: unaCartaDeTruco
	
	ronda debeJugarOtroJugador.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerminaPrimero class' category: 'ISW1-2021-1C-2doParcial'!
TerminaPrimero class
	instanceVariableNames: ''!

!TerminaPrimero class methodsFor: 'instance creation' stamp: 'GDH 7/5/2021 21:26:50'!
para: unaRondaDeTruco JuegaContra: unaCartaDeTruco
	
	^self new initializePara: unaRondaDeTruco JugandoContra: unaCartaDeTruco .! !


!classDefinition: #TerminaSegundo category: 'ISW1-2021-1C-2doParcial'!
EnfrentamientoDeTruco subclass: #TerminaSegundo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!TerminaSegundo methodsFor: 'initialization' stamp: 'GDH 7/5/2021 21:26:33'!
initializePara: unaRondaDeTruco JugandoContra: unaCartaDeTruco
	
	ronda := unaRondaDeTruco .
	cartaJugadaDelPrimerJugador := unaCartaDeTruco .! !


!TerminaSegundo methodsFor: 'enfrentar' stamp: 'GDH 7/5/2021 21:02:39'!
primerJugadorJuega: unaCartaDeTruco
	
	ronda debeJugarOtroJugador.! !

!TerminaSegundo methodsFor: 'enfrentar' stamp: 'GDH 7/5/2021 21:14:04'!
segundoJugadorJuega: unaCartaDeTruco
	
	cartaJugadaDelSegundoJugador := unaCartaDeTruco .
	
	self determinarSiguienteJugador .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerminaSegundo class' category: 'ISW1-2021-1C-2doParcial'!
TerminaSegundo class
	instanceVariableNames: ''!

!TerminaSegundo class methodsFor: 'instance creation' stamp: 'GDH 7/5/2021 21:25:46'!
para: unaRondaDeTruco JuegaContra: unaCartaDeTruco
	
	^self new initializePara: unaRondaDeTruco JugandoContra: unaCartaDeTruco .! !


!classDefinition: #RondaDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #RondaDeTruco
	instanceVariableNames: 'manoDelPrimero manoDelSegundo siguienteJugador cartaJugadaDelSegundoJugador cantidadDeJugadasDeEnfrentamiento cartaJugadaDelPrimerJugador estadoDeEnfrentamiento ganadasDelSegundo ganadasDelPrimero'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTruco methodsFor: 'instance creation' stamp: 'GDH 7/5/2021 21:23:03'!
initializeConCartasDeMano: unaManoDeCartasDelPrimero yCartasDeSegundo: unaManoDeCartasDelSegundo

	manoDelPrimero := unaManoDeCartasDelPrimero.
	manoDelSegundo := unaManoDeCartasDelSegundo.
	
	estadoDeEnfrentamiento := EmpiezaPrimero para: self.
	ganadasDelPrimero := 0.
	ganadasDelSegundo := 0.
	
	"siguienteJugador := #Primero.
	
	cantidadDeJugadasDeEnfrentamiento := 0."! !


!RondaDeTruco methodsFor: 'manos' stamp: 'GDH 7/5/2021 19:17:04'!
mirarManoDelPrimerJugador

	^manoDelPrimero copy! !

!RondaDeTruco methodsFor: 'manos' stamp: 'GDH 7/5/2021 19:26:47'!
mirarManoDelSegundoJugador

	^manoDelSegundo copy! !


!RondaDeTruco methodsFor: 'error messages' stamp: 'GDH 7/5/2021 19:38:52'!
mensajeDeErrorDebeJugarOtroJugador
	
	^'Debe jugar el otro jugador primero.'! !

!RondaDeTruco methodsFor: 'error messages' stamp: 'GDH 7/5/2021 19:22:43'!
mensajeDeErrorJugarCartaQueJugadorNoTiene
	
	^'No se puede jugar una carta que el jugador no tiene.'! !

!RondaDeTruco methodsFor: 'error messages' stamp: 'GDH 7/5/2021 21:40:42'!
mensajeDeErrorTerminoLaRonda

	^'La ronda ya termino.'! !


!RondaDeTruco methodsFor: 'avanzar' stamp: 'GDH 7/5/2021 21:13:31'!
siguienteTurno: unEnfrentamientoDeTruco
	
	estadoDeEnfrentamiento := unEnfrentamientoDeTruco .! !


!RondaDeTruco methodsFor: 'enfrentar' stamp: 'GDH 7/5/2021 21:28:58'!
ganaEnfrentamientoPrimero
	
	ganadasDelPrimero := ganadasDelPrimero + 1.
	
	estadoDeEnfrentamiento := EmpiezaPrimero para: self.! !

!RondaDeTruco methodsFor: 'enfrentar' stamp: 'GDH 7/5/2021 21:29:02'!
ganaEnfrentamientoSegundo
	
	ganadasDelSegundo := ganadasDelSegundo + 1.
	
	estadoDeEnfrentamiento := EmpiezaSegundo para: self.! !

!RondaDeTruco methodsFor: 'enfrentar' stamp: 'GDH 7/5/2021 21:37:12'!
parda
	
	estadoDeEnfrentamiento := EmpiezaPrimero para: self.! !

!RondaDeTruco methodsFor: 'enfrentar' stamp: 'GDH 7/5/2021 21:41:56'!
primerJugadorJuega: unaCartaDeTruco 
	
	self assertNoTerminoLaRonda.
	self assertLaMano: manoDelPrimero TieneLaCartaAJugar: unaCartaDeTruco.
	
	estadoDeEnfrentamiento primerJugadorJuega: unaCartaDeTruco .! !

!RondaDeTruco methodsFor: 'enfrentar' stamp: 'GDH 7/5/2021 21:42:11'!
segundoJugadorJuega: unaCartaDeTruco 

	self assertNoTerminoLaRonda.
	self assertLaMano: manoDelSegundo TieneLaCartaAJugar: unaCartaDeTruco.
	
	estadoDeEnfrentamiento segundoJugadorJuega: unaCartaDeTruco .! !


!RondaDeTruco methodsFor: 'assertions' stamp: 'GDH 7/5/2021 21:41:51'!
assertLaMano: unaMano TieneLaCartaAJugar: unaCartaDeTruco
	
	unaMano remove: unaCartaDeTruco ifAbsent: [ ^self error: self mensajeDeErrorJugarCartaQueJugadorNoTiene ].
	! !

!RondaDeTruco methodsFor: 'assertions' stamp: 'GDH 7/5/2021 21:40:11'!
assertNoTerminoLaRonda
	
	(self ganoElPrimerJugador or: [ self ganoElSegundoJugador ]) ifTrue: [ self error: self mensajeDeErrorTerminoLaRonda ]! !


!RondaDeTruco methodsFor: 'errors' stamp: 'GDH 7/5/2021 21:06:00'!
debeJugarOtroJugador
	
	self error: self mensajeDeErrorDebeJugarOtroJugador .! !


!RondaDeTruco methodsFor: 'testing' stamp: 'GDH 7/5/2021 21:32:10'!
ganoElPrimerJugador
	
	^ganadasDelPrimero = 2.! !

!RondaDeTruco methodsFor: 'testing' stamp: 'GDH 7/5/2021 21:32:23'!
ganoElSegundoJugador
	
	^ganadasDelSegundo = 2.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RondaDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco class
	instanceVariableNames: ''!

!RondaDeTruco class methodsFor: 'instance creation' stamp: 'GDH 7/5/2021 19:12:30'!
conCartasDelPrimero: unaManoDeCartasDelPrimero yCartasDeSegundo: unaManoDeCartasDelSegundo 
	
	self assertManosSonDeTresCartasCon: unaManoDeCartasDelPrimero y: unaManoDeCartasDelSegundo.
	self assertMano: unaManoDeCartasDelPrimero esDisjuntaCon: unaManoDeCartasDelSegundo.
	
	^self new initializeConCartasDeMano: unaManoDeCartasDelPrimero yCartasDeSegundo: unaManoDeCartasDelSegundo! !


!RondaDeTruco class methodsFor: 'error messages' stamp: 'GDH 7/5/2021 18:31:57'!
mensajeDeErrorManosNoDisjuntas
	
	^'Las manos no deben tener cartas repetidas.'! !

!RondaDeTruco class methodsFor: 'error messages' stamp: 'GDH 7/5/2021 18:01:06'!
mensajeDeErrorTama�oDeMano
	
	^'Las cartas de les jugadores deben tener 3 cartas.'! !


!RondaDeTruco class methodsFor: 'assertions' stamp: 'GDH 7/5/2021 18:31:24'!
assertMano: unaManoDelPrimero esDisjuntaCon: unaManoDelSegundo 
	
	( unaManoDelPrimero union: unaManoDelSegundo ) size = 6 ifFalse: [ ^self error: self mensajeDeErrorManosNoDisjuntas ].! !

!RondaDeTruco class methodsFor: 'assertions' stamp: 'GDH 7/5/2021 18:07:44'!
assertManosSonDeTresCartasCon: unaManoDelPrimero y: unaManoDelSegundo

	unaManoDelPrimero size = 3 ifFalse: [ ^self error: self mensajeDeErrorTama�oDeMano ].
	unaManoDelSegundo size = 3 ifFalse: [ ^self error: self mensajeDeErrorTama�oDeMano ].
	
	! !
