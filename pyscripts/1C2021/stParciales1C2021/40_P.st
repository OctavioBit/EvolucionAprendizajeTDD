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

!RondaDeTrucoTest methodsFor: 'creaciones mazo' stamp: 'TT 7/5/2021 19:54:43'!
defaultMazoMano

	^ OrderedCollection withAll: {
		CartaDeTruco espadaCon: 7.
		CartaDeTruco espadaCon: 6.
		CartaDeTruco espadaCon: 5.}! !

!RondaDeTrucoTest methodsFor: 'creaciones mazo' stamp: 'TT 7/5/2021 19:54:25'!
defaultMazoPie

	^ OrderedCollection withAll: {
		CartaDeTruco oroCon: 7.
		CartaDeTruco oroCon: 6.
		CartaDeTruco oroCon: 5.}! !


!RondaDeTrucoTest methodsFor: 'tests' stamp: 'TT 7/5/2021 19:02:06'!
test01LaManoNoPuedeTenerCartasRepetidas
	
	| mazoMano mazoPie ronda |
	mazoMano := OrderedCollection withAll: {
		CartaDeTruco espadaCon: 7.
		CartaDeTruco espadaCon: 6.
		CartaDeTruco espadaCon: 7}.
	mazoPie := OrderedCollection withAll: {
		CartaDeTruco oroCon: 7.
		CartaDeTruco oroCon: 6.
		CartaDeTruco oroCon: 5}.
	
	self 
		should: [ ronda := RondaDeTruco conCartasMano: mazoMano cartasPie: mazoPie] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :error |
			self assert: RondaDeTruco laManoDeUnJugadorNoPuedeTenerCartasRepetidasErrorDescription equals: error messageText.
		]
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'TT 7/5/2021 19:02:12'!
test02ElPieNoPuedeTenerCartasRepetidas
	
	| mazoMano mazoPie ronda |
	mazoMano := OrderedCollection withAll: {
		CartaDeTruco espadaCon: 7.
		CartaDeTruco espadaCon: 6.
		CartaDeTruco espadaCon: 5}.
	mazoPie := OrderedCollection withAll: {
		CartaDeTruco oroCon: 7.
		CartaDeTruco oroCon: 6.
		CartaDeTruco oroCon: 7}.
	
	self 
		should: [ ronda := RondaDeTruco conCartasMano: mazoMano cartasPie: mazoPie] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :error |
			self assert: RondaDeTruco laManoDeUnJugadorNoPuedeTenerCartasRepetidasErrorDescription equals: error messageText.
		]
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'TT 7/5/2021 19:02:17'!
test03NoPuedeHaberCartasRepetidasEntreLasCartasDeLosJugadores
	
	| mazoMano mazoPie ronda |
	mazoMano := OrderedCollection withAll: {
		CartaDeTruco espadaCon: 7.
		CartaDeTruco espadaCon: 6.
		CartaDeTruco espadaCon: 5}.
	mazoPie := OrderedCollection withAll:  {
		CartaDeTruco oroCon: 7.
		CartaDeTruco oroCon: 6.
		CartaDeTruco espadaCon: 5}.
	
	self 
		should: [ ronda := RondaDeTruco conCartasMano: mazoMano cartasPie: mazoPie] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :error |
			self assert: RondaDeTruco losJugadoresNoPuedenCompartirCartasErrorDescription equals: error messageText.
		]
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'TT 7/5/2021 19:02:24'!
test04LaManoTieneQueEmpezarCon3Cartas
	
	| mazoMano mazoPie ronda |
	mazoMano := OrderedCollection withAll: {
		CartaDeTruco espadaCon: 7.
		CartaDeTruco espadaCon: 6.}.
	mazoPie := OrderedCollection withAll: {
		CartaDeTruco oroCon: 7.
		CartaDeTruco oroCon: 6.
		CartaDeTruco oroCon: 5.}.
	
	self 
		should: [ ronda := RondaDeTruco conCartasMano: mazoMano cartasPie: mazoPie] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :error |
			self assert: RondaDeTruco losJugadoresTienenQueEmpezarCon3CartasErrorDescription equals: error messageText.
		]
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'TT 7/5/2021 19:02:30'!
test05LaManoTieneQueEmpezarCon3Cartas
	
	| mazoMano mazoPie ronda |
	mazoMano := OrderedCollection withAll: {
		CartaDeTruco espadaCon: 7.
		CartaDeTruco espadaCon: 6.
		CartaDeTruco espadaCon: 5.}.
	mazoPie := OrderedCollection withAll: {
		CartaDeTruco oroCon: 7.
		CartaDeTruco oroCon: 6.}.
	
	self 
		should: [ ronda := RondaDeTruco conCartasMano: mazoMano cartasPie: mazoPie] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :error |
			self assert: RondaDeTruco losJugadoresTienenQueEmpezarCon3CartasErrorDescription equals: error messageText.
		]
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'TT 7/5/2021 21:41:17'!
test06AlComenzarLaRondaLosJugadoresTienenTodasSusCartas
	
	| mazoMano mazoPie ronda |
	
	mazoMano := self defaultMazoMano.
	mazoPie := self defaultMazoPie.
	
	ronda := RondaDeTruco conCartasMano: mazoMano cartasPie: mazoPie.
	
	self assert: ronda cartasMano equals: mazoMano.
	self assert: ronda cartasPie equals: mazoPie.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'TT 7/5/2021 21:41:13'!
test07AlComenzarLaRondaEsElPrimerEnfrentamiento
	
	| mazoMano mazoPie ronda |
	
	mazoMano := self defaultMazoMano.
	mazoPie := self defaultMazoPie.
	
	ronda := RondaDeTruco conCartasMano: mazoMano cartasPie: mazoPie.
	
	self assert: ronda numeroDeEnfrentamiento equals: 1.
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'TT 7/5/2021 21:41:08'!
test08NoPuedeJugarElPiePrimeroAlComenzarLaRonda
	
	| mazoMano mazoPie ronda |
	
	mazoMano := self defaultMazoMano.
	mazoPie := self defaultMazoPie.
	
	ronda := RondaDeTruco conCartasMano: mazoMano cartasPie: mazoPie.
	
	self 
		should: [ ronda juegaPieConCarta: (CartaDeTruco oroCon: 5) ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: RondaDeTruco esteJugadorNoPuedeEmpezarEsteEnfrentamientoErrorDescription equals: error messageText.
		]
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'TT 7/5/2021 21:41:05'!
test09LaManoNoPuedeJugarConUnaCartaQueNoPosee
	
	| mazoMano mazoPie ronda |
	
	mazoMano := self defaultMazoMano.
	mazoPie := self defaultMazoPie.
	
	ronda := RondaDeTruco conCartasMano: mazoMano cartasPie: mazoPie.
	
	self 
		should: [ ronda juegaManoConCarta: (CartaDeTruco oroCon: 5) ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: RondaDeTruco esteJugadorNoPoseeEstaCartaErrorDescription equals: error messageText.
		]
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'TT 7/5/2021 21:41:00'!
test10ElPieNoPuedeJugarConUnaCartaQueNoPosee
	
	| mazoMano mazoPie ronda |
	
	mazoMano := self defaultMazoMano.
	mazoPie := self defaultMazoPie.
	
	ronda := RondaDeTruco conCartasMano: mazoMano cartasPie: mazoPie.
	
	self 
		should: [ 
			ronda juegaManoConCarta: (CartaDeTruco espadaCon: 5).
			ronda juegaPieConCarta: (CartaDeTruco oroCon: 10).
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: RondaDeTruco esteJugadorNoPoseeEstaCartaErrorDescription equals: error messageText.
		]
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'TT 7/5/2021 21:44:15'!
test11LuegoDeJugarManoTieneUnaCartaMenosYEsTurnoDePie
	
	| mazoMano mazoPie ronda |
	
	mazoMano := self defaultMazoMano.
	mazoPie := self defaultMazoPie.
	
	ronda := RondaDeTruco conCartasMano: mazoMano cartasPie: mazoPie.
	
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 5).
	
	self assert: 1 equals: ronda numeroDeEnfrentamiento.
	self assert: 2 equals: ronda cartasMano size.
	self assert: 3 equals: ronda cartasPie size.
	self deny: ronda seTermino.
	self assert: ronda juegaPie.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'TT 7/5/2021 21:44:04'!
test12SiManoGanoPrimerEnfrentamientoEmpiezaElSiguienteManoCon2CartasAmbos
	
	| mazoMano mazoPie ronda |
	
	mazoMano := self defaultMazoMano.
	mazoPie := self defaultMazoPie.
	
	ronda := RondaDeTruco conCartasMano: mazoMano cartasPie: mazoPie.
	
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 6).
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 5).
	
	self assert: 2 equals: ronda numeroDeEnfrentamiento.
	self assert: 2 equals: ronda cartasMano size.
	self assert: 2 equals: ronda cartasPie size.
	self deny: ronda seTermino.
	self assert: ronda juegaMano.
	self deny: ronda juegaPie.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'TT 7/5/2021 21:43:56'!
test13SiPieGanaPrimerEnfrentamientoEmpiezaElSiguienteManoCon2CartasAmbos
	
	| mazoMano mazoPie ronda |
	
	mazoMano := self defaultMazoMano.
	mazoPie := self defaultMazoPie.
	ronda := RondaDeTruco conCartasMano: mazoMano cartasPie: mazoPie.
	
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 5).
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 6).
	
	self assert: 2 equals: ronda numeroDeEnfrentamiento.
	self assert: 2 equals: ronda cartasMano size.
	self assert: 2 equals: ronda cartasPie size.
	self deny: ronda seTermino.
	self assert: ronda juegaPie.
	self deny: ronda juegaMano.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'TT 7/5/2021 21:43:51'!
test14SiManoGanoPrimeraYPieGanaSegundaEmpiezaPie
	
	| mazoMano mazoPie ronda |
	
	mazoMano := self defaultMazoMano.
	mazoPie := self defaultMazoPie.
	
	ronda := RondaDeTruco conCartasMano: mazoMano cartasPie: mazoPie.
	
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 7).
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 5).
	
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 6).
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 7).
	
	self assert: 3 equals: ronda numeroDeEnfrentamiento.
	self assert: 1 equals: ronda cartasMano size.
	self assert: 1 equals: ronda cartasPie size.
	self deny: ronda seTermino.
	self assert: ronda juegaPie.
	self deny: ronda juegaMano.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'TT 7/5/2021 21:42:16'!
test15SiPieGanoPrimeraYManoGanaSegundaEmpiezaMano
	
	| mazoMano mazoPie ronda |
	
	mazoMano := self defaultMazoMano.
	mazoPie := self defaultMazoPie.
	
	ronda := RondaDeTruco conCartasMano: mazoMano cartasPie: mazoPie.
	
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 6).
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 7).
	
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 5).
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 7).
	
	self assert: 3 equals: ronda numeroDeEnfrentamiento.
	self assert: 1 equals: ronda cartasMano size.
	self assert: 1 equals: ronda cartasPie size.
	self deny: ronda seTermino.
	self deny: ronda juegaPie.
	self assert: ronda juegaMano.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'TT 7/5/2021 21:40:39'!
test16NoPuedeJugarLaManoCuandoNoEsSuTurno
	
	| mazoMano mazoPie ronda |
	
	mazoMano := self defaultMazoMano.
	mazoPie := self defaultMazoPie.
	
	ronda := RondaDeTruco conCartasMano: mazoMano cartasPie: mazoPie.
	
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 6).
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 7).
	
	self 
		should: [ ronda juegaManoConCarta: (CartaDeTruco espadaCon: 7) ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: RondaDeTruco esteJugadorNoPuedeEmpezarEsteEnfrentamientoErrorDescription equals: error messageText.
			self assert: 2 equals: ronda numeroDeEnfrentamiento.
			self assert: 2 equals: ronda cartasMano size.
			self assert: 2 equals: ronda cartasPie size.
			self assert: ronda juegaPie.
			self deny: ronda juegaMano.
		]
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'TT 7/5/2021 21:40:35'!
test17SiManoGanoPrimeraYPieGanaSegundaYPieGanaTerceraGanaPieLaRonda
	
	| mazoMano mazoPie ronda |
	
	mazoMano := self defaultMazoMano.
	mazoPie := self defaultMazoPie.
	
	ronda := RondaDeTruco conCartasMano: mazoMano cartasPie: mazoPie.
	
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 7).
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 5).
	
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 6).
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 7).
	
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 6).
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 5).
	
	self assert: ronda seTermino.
	self assert: ronda ganoPie.
	self deny: ronda ganoMano.
	self assert: 0 equals: ronda cartasMano size.
	self assert: 0 equals: ronda cartasPie size.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'TT 7/5/2021 21:40:30'!
test18SiManoGanoPrimeraYPieGanaSegundaYManoGanaTerceraGanaManoLaRonda
	
	| mazoMano mazoPie ronda |
	
	mazoMano := self defaultMazoMano.
	mazoPie := self defaultMazoPie.
	
	ronda := RondaDeTruco conCartasMano: mazoMano cartasPie: mazoPie.
	
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 6).
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 5).
	
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 5).
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 7).
	
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 6).
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 7).
	
	self assert: ronda seTermino.
	self deny: ronda ganoPie.
	self assert: ronda ganoMano.
	self assert: 0 equals: ronda cartasMano size.
	self assert: 0 equals: ronda cartasPie size.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'TT 7/5/2021 21:40:26'!
test19SiManoGanoPrimeraYManoGanoSegundaGanoManoLaRonda
	
	| mazoMano mazoPie ronda |
	
	mazoMano := self defaultMazoMano.
	mazoPie := self defaultMazoPie.
	
	ronda := RondaDeTruco conCartasMano: mazoMano cartasPie: mazoPie.
	
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 7).
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 6).
	
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 6).
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 5).
	
	self assert: ronda seTermino.
	self assert: ronda ganoMano.
	self deny: ronda ganoPie.
	self assert: 1 equals: ronda cartasMano size.
	self assert: 1 equals: ronda cartasPie size.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'TT 7/5/2021 21:40:22'!
test20SiPieGanoPrimeraYManoGanoSegundaYManoGanoTerceraGanaManoLaRonda
	
	| mazoMano mazoPie ronda |
	
	mazoMano := self defaultMazoMano.
	mazoPie := self defaultMazoPie.
	
	ronda := RondaDeTruco conCartasMano: mazoMano cartasPie: mazoPie.
	
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 5).
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 7).
	
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 6).
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 7).
	
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 6).
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 5).
	
	self assert: ronda seTermino.
	self assert: ronda ganoMano.
	self deny: ronda ganoPie.
	self assert: 0 equals: ronda cartasMano size.
	self assert: 0 equals: ronda cartasPie size.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'TT 7/5/2021 21:40:15'!
test21SiPieGanoPrimeraYManoGanoSegundaYPieGanoTerceraPieGanoLaRonda
	
	| mazoMano mazoPie ronda |
	
	mazoMano := self defaultMazoMano.
	mazoPie := self defaultMazoPie.
	
	ronda := RondaDeTruco conCartasMano: mazoMano cartasPie: mazoPie.
	
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 5).
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 6).
	
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 5).
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 7).
	
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 6).
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 7).
	
	self assert: ronda seTermino.
	self deny: ronda ganoMano.
	self assert: ronda ganoPie.
	self assert: 0 equals: ronda cartasMano size.
	self assert: 0 equals: ronda cartasPie size.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'TT 7/5/2021 21:40:05'!
test22SiPieGanoPrimeraYPieGanoSegundaPieGanoLaRonda
	
	| mazoMano mazoPie ronda |
	
	mazoMano := self defaultMazoMano.
	mazoPie := self defaultMazoPie.
	ronda := RondaDeTruco conCartasMano: mazoMano cartasPie: mazoPie.
	
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 5).
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 6).
	
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 7).
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 6).
	
	self assert: ronda seTermino.
	self deny: ronda ganoMano.
	self assert: ronda ganoPie.
	self assert: 1 equals: ronda cartasMano size.
	self assert: 1 equals: ronda cartasPie size.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'TT 7/5/2021 21:39:55'!
test23SiPardanPrimeraEmpiezaManoSegunda
	
	| mazoMano mazoPie ronda |
	
	mazoMano := self defaultMazoMano.
	mazoPie := self defaultMazoPie.
	
	ronda := RondaDeTruco conCartasMano: mazoMano cartasPie: mazoPie.
	
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 5).
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 5).
	
	self 
		should: [ronda juegaPieConCarta: (CartaDeTruco oroCon: 6).]
		raise: Error - MessageNotUnderstood 
	  	withExceptionDo: [ :error |
			self assert: RondaDeTruco esteJugadorNoPuedeEmpezarEsteEnfrentamientoErrorDescription equals: error messageText .
			self deny: ronda seTermino.
			self assert: 2 equals: ronda cartasMano size.
			self assert: 2 equals: ronda cartasPie size.
		]! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'TT 7/5/2021 21:35:56'!
test24SiPardanPrimeraYManoGanoSegundaManoGanoLaRonda
	
	| mazoMano mazoPie ronda |
	
	mazoMano := self defaultMazoMano.
	mazoPie := self defaultMazoPie.
	
	ronda := RondaDeTruco conCartasMano: mazoMano cartasPie: mazoPie.
	
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 5).
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 5).
	
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 7).
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 6).
	
	self assert: ronda seTermino.
	self assert: ronda ganoMano.
	self deny: ronda ganoPie.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'TT 7/5/2021 21:35:56'!
test25SiPardanPrimeraYPieGanoSegundaPieGanoLaRonda
	
	| mazoMano mazoPie ronda |
	
	mazoMano := self defaultMazoMano.
	mazoPie := self defaultMazoPie.
	
	ronda := RondaDeTruco conCartasMano: mazoMano cartasPie: mazoPie.
	
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 5).
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 5).
	
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 6).
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 7).
	
	self assert: ronda seTermino.
	self deny: ronda ganoMano.
	self assert: ronda ganoPie.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'TT 7/5/2021 21:35:55'!
test26SiLaRondaTerminoNoPuedeSeguirTirandoCartasPie
	
	| mazoMano mazoPie ronda |
	
	mazoMano := self defaultMazoMano.
	mazoPie := self defaultMazoPie.
	
	ronda := RondaDeTruco conCartasMano: mazoMano cartasPie: mazoPie.
	
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 5).
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 5).
	
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 6).
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 7).
	
	self
	should: [ ronda juegaPieConCarta: (CartaDeTruco oroCon: 6) ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :error | 
		self assert: RondaDeTruco noSePuedeSeguirJugandoCuandoLaRondaTerminaErrorDescription equals: error messageText.
		self assert: ronda seTermino.
		self deny: ronda ganoMano.
		self assert: ronda ganoPie.
	]! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'TT 7/5/2021 21:35:55'!
test27SiLaRondaTerminoNoPuedeSeguirTirandoCartasMano
	
	| mazoMano mazoPie ronda |
	
	mazoMano := self defaultMazoMano.
	mazoPie := self defaultMazoPie.
	
	ronda := RondaDeTruco conCartasMano: mazoMano cartasPie: mazoPie.
	
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 5).
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 5).
	
	ronda juegaManoConCarta: (CartaDeTruco espadaCon: 7).
	ronda juegaPieConCarta: (CartaDeTruco oroCon: 6).
	
	self
	should: [ ronda juegaManoConCarta: (CartaDeTruco espadaCon: 6) ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :error | 
		self assert: RondaDeTruco noSePuedeSeguirJugandoCuandoLaRondaTerminaErrorDescription equals: error messageText.
		self assert: ronda seTermino.
		self assert: ronda ganoMano.
		self deny: ronda ganoPie.
	]! !


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


!classDefinition: #EnfrentamientoState category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #EnfrentamientoState
	instanceVariableNames: 'ronda'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!EnfrentamientoState methodsFor: 'enfrentamiento' stamp: 'TT 7/5/2021 21:36:30'!
esTurnoDeMano

	self subclassResponsibility ! !

!EnfrentamientoState methodsFor: 'enfrentamiento' stamp: 'TT 7/5/2021 21:36:33'!
esTurnoDePie

	self subclassResponsibility ! !

!EnfrentamientoState methodsFor: 'enfrentamiento' stamp: 'TT 7/5/2021 21:36:47'!
juegaMano: aCartaDeTruco
	
	self subclassResponsibility ! !

!EnfrentamientoState methodsFor: 'enfrentamiento' stamp: 'TT 7/5/2021 21:36:50'!
juegaPie: aCartaDeTruco
	
	self subclassResponsibility ! !


!EnfrentamientoState methodsFor: 'initialization' stamp: 'TT 7/5/2021 21:01:49'!
initializeWithRonda: aRonda

	ronda := aRonda.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnfrentamientoState class' category: 'ISW1-2021-1C-2doParcial'!
EnfrentamientoState class
	instanceVariableNames: ''!

!EnfrentamientoState class methodsFor: 'initilization' stamp: 'TT 7/5/2021 21:02:14'!
withRonda: aRonda

	^self new initializeWithRonda: aRonda! !


!classDefinition: #ManoJuegaState category: 'ISW1-2021-1C-2doParcial'!
EnfrentamientoState subclass: #ManoJuegaState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!ManoJuegaState methodsFor: 'enfrentamiento' stamp: 'TT 7/5/2021 21:20:14'!
esTurnoDeMano
	
	^ronda esTurnoDeMano! !

!ManoJuegaState methodsFor: 'enfrentamiento' stamp: 'TT 7/5/2021 21:20:02'!
esTurnoDePie
	
	^ronda noEsTurnoDePie! !

!ManoJuegaState methodsFor: 'enfrentamiento' stamp: 'TT 7/5/2021 21:11:15'!
juegaMano: aCartaDeTruco
	
	ronda juegaEnSuTurnoMano: aCartaDeTruco! !

!ManoJuegaState methodsFor: 'enfrentamiento' stamp: 'TT 7/5/2021 21:11:12'!
juegaPie: aCartaDeTruco

	ronda noJuegaEnSuTurnoPie: aCartaDeTruco! !


!classDefinition: #PieJuegaState category: 'ISW1-2021-1C-2doParcial'!
EnfrentamientoState subclass: #PieJuegaState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!PieJuegaState methodsFor: 'enfrentamiento' stamp: 'TT 7/5/2021 21:20:42'!
esTurnoDeMano
	
	^ronda noEsTurnoDePie! !

!PieJuegaState methodsFor: 'enfrentamiento' stamp: 'TT 7/5/2021 21:21:02'!
esTurnoDePie
	
	^ronda esTurnoDePie! !

!PieJuegaState methodsFor: 'enfrentamiento' stamp: 'TT 7/5/2021 21:11:06'!
juegaMano: aCartaDeTruco
	
	ronda noJuegaEnSuTurnoMano: aCartaDeTruco! !

!PieJuegaState methodsFor: 'enfrentamiento' stamp: 'TT 7/5/2021 21:10:59'!
juegaPie: aCartaDeTruco

	ronda juegaEnSuTurnoPie: aCartaDeTruco! !


!classDefinition: #RondaDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #RondaDeTruco
	instanceVariableNames: 'cartasMano cartasPie enfrentamiento ultimaCartaDeMano ultimaCartaDePie ultimaCartaJugada enfrentamientosGanadosPorMano enfrentamientosGanadosPorPie pardaPrimera enfrentamientoState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTruco methodsFor: 'initialization' stamp: 'TT 7/5/2021 21:23:37'!
initializeConCartasMano: aCartasMano cartasPie: aCartasPie 
	
	cartasMano := OrderedCollection withAll: aCartasMano.
	cartasPie := OrderedCollection withAll: aCartasPie.
	enfrentamiento := 1.
	ultimaCartaDeMano := nil.
	ultimaCartaDePie := nil.
	enfrentamientosGanadosPorMano := 0.
	enfrentamientosGanadosPorPie := 0.
	pardaPrimera := false.
	enfrentamientoState := ManoJuegaState withRonda: self.! !


!RondaDeTruco methodsFor: 'assertions' stamp: 'TT 7/5/2021 21:50:47'!
assertLaRondaTermino

	self seTermino ifTrue: [ self signalNoSePuedeSeguirJugandoCuandoLaRondaTermina ]! !

!RondaDeTruco methodsFor: 'assertions' stamp: 'TT 7/5/2021 21:39:29'!
assertManoTieneLaCarta: aCartaDeTruco

	self assertTieneLaCarta: aCartaDeTruco elJugador: cartasMano.! !

!RondaDeTruco methodsFor: 'assertions' stamp: 'TT 7/5/2021 21:38:38'!
assertPieTieneLaCarta: aCartaDeTruco
	
	self assertTieneLaCarta: aCartaDeTruco elJugador: cartasPie.! !

!RondaDeTruco methodsFor: 'assertions' stamp: 'TT 7/5/2021 21:51:06'!
assertTieneLaCarta: aCartaDeTruco elJugador: aJugador 
	(aJugador includes: aCartaDeTruco) ifFalse: [self signalEsteJugadorNoPoseeEstaCartaErrorDescription]! !


!RondaDeTruco methodsFor: 'accessing' stamp: 'TT 7/5/2021 18:18:50'!
cartasMano
	
	^cartasMano! !

!RondaDeTruco methodsFor: 'accessing' stamp: 'TT 7/5/2021 18:18:59'!
cartasPie
	
	^cartasPie! !

!RondaDeTruco methodsFor: 'accessing' stamp: 'TT 7/5/2021 21:32:47'!
numeroDeEnfrentamiento
	
	^enfrentamiento! !


!RondaDeTruco methodsFor: 'estado de ronda' stamp: 'TT 7/5/2021 20:06:11'!
ganoMano

	^enfrentamientosGanadosPorMano > enfrentamientosGanadosPorPie ! !

!RondaDeTruco methodsFor: 'estado de ronda' stamp: 'TT 7/5/2021 20:05:57'!
ganoPie
	
	^enfrentamientosGanadosPorPie > enfrentamientosGanadosPorMano ! !

!RondaDeTruco methodsFor: 'estado de ronda' stamp: 'TT 7/5/2021 21:35:55'!
seTermino

	^(pardaPrimera and: (enfrentamiento = 3)) or: (enfrentamientosGanadosPorMano = 2 or: enfrentamientosGanadosPorPie = 2)! !



!RondaDeTruco methodsFor: 'estado de enfrentamiento - private' stamp: 'TT 7/5/2021 21:49:38'!
chequearFinDeEnfrentamiento

	((ultimaCartaDeMano isNil) or: (ultimaCartaDePie isNil)) ifFalse: [
		self finEnfrentamiento.
	].
	! !

!RondaDeTruco methodsFor: 'estado de enfrentamiento - private' stamp: 'TT 7/5/2021 21:21:51'!
esTurnoDeMano

	^true! !

!RondaDeTruco methodsFor: 'estado de enfrentamiento - private' stamp: 'TT 7/5/2021 21:21:35'!
esTurnoDePie

	^true! !

!RondaDeTruco methodsFor: 'estado de enfrentamiento - private' stamp: 'TT 7/5/2021 21:23:33'!
finEnfrentamiento
	
	(ultimaCartaDeMano mataA: ultimaCartaDePie) ifTrue: [ 
		enfrentamientosGanadosPorMano := enfrentamientosGanadosPorMano + 1.
		enfrentamientoState := ManoJuegaState withRonda: self.
	].
	(ultimaCartaDePie mataA: ultimaCartaDeMano) ifTrue: [ 
		enfrentamientosGanadosPorPie := enfrentamientosGanadosPorPie + 1.
		enfrentamientoState := PieJuegaState withRonda: self.
	].
	(ultimaCartaDeMano empardaCon: ultimaCartaDePie) ifTrue: [ 
		pardaPrimera := true.
		enfrentamientoState := ManoJuegaState withRonda: self.
	].
	ultimaCartaDeMano := nil.
	ultimaCartaDePie := nil.
	enfrentamiento := enfrentamiento + 1! !

!RondaDeTruco methodsFor: 'estado de enfrentamiento - private' stamp: 'TT 7/5/2021 21:49:51'!
juegaEnSuTurnoMano: aCartaDeTruco
	
	cartasMano remove: aCartaDeTruco.
	ultimaCartaDeMano := aCartaDeTruco.
	enfrentamientoState := PieJuegaState withRonda: self.
	
	self chequearFinDeEnfrentamiento.
	! !

!RondaDeTruco methodsFor: 'estado de enfrentamiento - private' stamp: 'TT 7/5/2021 21:49:22'!
juegaEnSuTurnoPie: aCartaDeTruco
	
	cartasPie remove: aCartaDeTruco.
	ultimaCartaDePie := aCartaDeTruco.
	enfrentamientoState := ManoJuegaState withRonda: self.
	
	self chequearFinDeEnfrentamiento.
	! !

!RondaDeTruco methodsFor: 'estado de enfrentamiento - private' stamp: 'TT 7/5/2021 21:11:32'!
juegaManoConCarta: aCartaDeTruco 
	
	self assertManoTieneLaCarta: aCartaDeTruco.
	self assertLaRondaTermino.
	
	enfrentamientoState juegaMano: aCartaDeTruco.
	! !

!RondaDeTruco methodsFor: 'estado de enfrentamiento - private' stamp: 'TT 7/5/2021 21:30:45'!
juegaPieConCarta: aCartaDeTruco 
	
	self assertPieTieneLaCarta: aCartaDeTruco.
	self assertLaRondaTermino.
	
	enfrentamientoState juegaPie: aCartaDeTruco.
	
	! !

!RondaDeTruco methodsFor: 'estado de enfrentamiento - private' stamp: 'TT 7/5/2021 21:22:01'!
noEsTurnoDeMano

	^false! !

!RondaDeTruco methodsFor: 'estado de enfrentamiento - private' stamp: 'TT 7/5/2021 21:22:52'!
noEsTurnoDePie

	^false! !

!RondaDeTruco methodsFor: 'estado de enfrentamiento - private' stamp: 'TT 7/5/2021 21:29:22'!
noJuegaEnSuTurnoMano: aCartaDeTruco
	
	self signalEsteJugadorNoPuedeEmpezarEsteEnfrentamiento! !

!RondaDeTruco methodsFor: 'estado de enfrentamiento - private' stamp: 'TT 7/5/2021 21:29:15'!
noJuegaEnSuTurnoPie: aCartaDeTruco
	
	self signalEsteJugadorNoPuedeEmpezarEsteEnfrentamiento! !


!RondaDeTruco methodsFor: 'signals' stamp: 'TT 7/5/2021 21:51:06'!
signalEsteJugadorNoPoseeEstaCartaErrorDescription

	^ self error: self class esteJugadorNoPoseeEstaCartaErrorDescription! !

!RondaDeTruco methodsFor: 'signals' stamp: 'TT 7/5/2021 21:29:15'!
signalEsteJugadorNoPuedeEmpezarEsteEnfrentamiento

	^ self error: self class esteJugadorNoPuedeEmpezarEsteEnfrentamientoErrorDescription! !

!RondaDeTruco methodsFor: 'signals' stamp: 'TT 7/5/2021 21:50:47'!
signalNoSePuedeSeguirJugandoCuandoLaRondaTermina

	^ self error: self class noSePuedeSeguirJugandoCuandoLaRondaTerminaErrorDescription! !


!RondaDeTruco methodsFor: 'estado de enfrentamiento' stamp: 'TT 7/5/2021 21:21:25'!
juegaMano
	
	^enfrentamientoState esTurnoDeMano ! !

!RondaDeTruco methodsFor: 'estado de enfrentamiento' stamp: 'TT 7/5/2021 21:21:22'!
juegaPie
	
	^enfrentamientoState esTurnoDePie ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RondaDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco class
	instanceVariableNames: ''!

!RondaDeTruco class methodsFor: 'instance creation' stamp: 'TT 7/5/2021 18:10:30'!
conCartasMano: aCartasMano cartasPie: aCartasPie
	
	self assertTienenTresCartasLaMano: aCartasMano elPie: aCartasPie.
	self assertNoPuedenTenerCartasRepetidasLaMano: aCartasMano elPie: aCartasPie.
	self assertNoPuedenCompartirCartasLaMano: aCartasMano elPie: aCartasPie.
	
	^self new initializeConCartasMano: aCartasMano cartasPie: aCartasPie ! !


!RondaDeTruco class methodsFor: 'as yet unclassified' stamp: 'TT 7/5/2021 18:11:29'!
assertNoPuedenCompartirCartasLaMano: aCartasMano elPie: aCartasPie 
	| cartasManoUnicas cartasPieUnicas |
	
	cartasManoUnicas := Set withAll: aCartasMano.
	cartasPieUnicas := Set withAll: aCartasPie.

	(cartasManoUnicas intersection: cartasPieUnicas) isEmpty ifFalse: [
		self error: self losJugadoresNoPuedenCompartirCartasErrorDescription
	].
	.! !

!RondaDeTruco class methodsFor: 'as yet unclassified' stamp: 'TT 7/5/2021 18:09:48'!
assertNoPuedenTenerCartasRepetidasLaMano: aCartasMano elPie: aCartasPie 
	| cartasManoUnicas cartasPieUnicas |
	
	cartasManoUnicas := Set withAll: aCartasMano .
	cartasManoUnicas size < 3 ifTrue: [ self error: self laManoDeUnJugadorNoPuedeTenerCartasRepetidasErrorDescription].
	
	cartasPieUnicas := Set withAll: aCartasPie .
	cartasPieUnicas size < 3 ifTrue: [ self error: self laManoDeUnJugadorNoPuedeTenerCartasRepetidasErrorDescription].! !

!RondaDeTruco class methodsFor: 'as yet unclassified' stamp: 'TT 7/5/2021 18:07:55'!
assertTienenTresCartasLaMano: aCartasMano elPie: aCartasPie 
	
	aCartasMano size < 3 ifTrue: [self error: self losJugadoresTienenQueEmpezarCon3CartasErrorDescription ].
	aCartasPie size < 3 ifTrue: [self error: self losJugadoresTienenQueEmpezarCon3CartasErrorDescription ].
	! !

!RondaDeTruco class methodsFor: 'as yet unclassified' stamp: 'TT 7/5/2021 18:29:21'!
esteJugadorNoPoseeEstaCartaErrorDescription
	
	^'Este jugador no puede jugar esta carta porque no la posee'! !

!RondaDeTruco class methodsFor: 'as yet unclassified' stamp: 'TT 7/5/2021 18:24:40'!
esteJugadorNoPuedeEmpezarEsteEnfrentamientoErrorDescription
	
	^'Este jugador no debe empezar este enfrentamiento'! !

!RondaDeTruco class methodsFor: 'as yet unclassified' stamp: 'TT 7/5/2021 17:53:51'!
laManoDeUnJugadorNoPuedeTenerCartasRepetidasErrorDescription
	
	^'La mano inicial de un jugador no puede tener cartas repetidas'! !

!RondaDeTruco class methodsFor: 'as yet unclassified' stamp: 'TT 7/5/2021 18:02:34'!
losJugadoresNoPuedenCompartirCartasErrorDescription
	
	^'Los jugadores no pueden tener cartas iguales'! !

!RondaDeTruco class methodsFor: 'as yet unclassified' stamp: 'TT 7/5/2021 18:05:05'!
losJugadoresTienenQueEmpezarCon3CartasErrorDescription
	
	^'Los jugadores tienen que empezar con 3 cartas'! !

!RondaDeTruco class methodsFor: 'as yet unclassified' stamp: 'TT 7/5/2021 20:37:57'!
noSePuedeSeguirJugandoCuandoLaRondaTerminaErrorDescription
	
	^'No se puede seguir jugando porque la ronda termino'! !
