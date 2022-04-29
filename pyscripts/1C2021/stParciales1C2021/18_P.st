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

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'TPL 7/5/2021 19:51:08'!
test01DevolverErrorSiJugadorNoTieneTresCartasDiferentes
	| cart1Mano cart2Mano cart3Mano cartas |
	
	cart1Mano := CartaDeTruco bastoCon: 6.
	cart2Mano := CartaDeTruco espadaCon: 6.
	cart3Mano := CartaDeTruco bastoCon: 6.
	
	cartas := OrderedCollection with: cart1Mano with: cart2Mano with: cart3Mano.
	
		self 
		should: [Jugador conNombre:'x' conCartas: cartas]
			raise: Error 
			withExceptionDo: [ :anError |
			self assert: Jugador cartasEnManoRepetidas equals: anError messageText.].

	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'TPL 7/5/2021 19:50:59'!
test02JugadorPodriaDisponerCorrectamenteDeSusCartasSiTieneTresCartasDiferentes
	| cart1Mano cart2Mano cart3Mano jugadorMano unaColeccionDeCartas|
	cart1Mano := CartaDeTruco bastoCon: 6.
	cart2Mano := CartaDeTruco espadaCon: 6.
	cart3Mano := CartaDeTruco oroCon: 6.
	unaColeccionDeCartas := OrderedCollection with: cart1Mano with: cart2Mano with: cart3Mano.
	jugadorMano := Jugador conNombre: 'x' conCartas: unaColeccionDeCartas.
	
	self assert: ((jugadorMano cartas) at:1) = cart1Mano.
	self assert: ((jugadorMano cartas) at:2) = cart2Mano.
	self assert: ((jugadorMano cartas) at:3) = cart3Mano.
	

	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'TPL 7/5/2021 19:50:51'!
test03RondaDeberiaDevolverErrorSiJugadoresTienenCartasRepetidasEntreSi
	| cart1Mano cart2Mano cart3Mano jugadorMano cart1Pie cart2Pie cart3Pie jugadorPie unaColeccionDeCartasDeMano unaColeccionDeCartasDePie|
	cart1Mano := CartaDeTruco bastoCon: 6.
	cart2Mano := CartaDeTruco espadaCon: 6.
	cart3Mano := CartaDeTruco oroCon: 6.
	
	unaColeccionDeCartasDeMano := OrderedCollection with: cart1Mano with: cart2Mano with: cart3Mano.
	jugadorMano := Jugador conNombre: 'x' conCartas: unaColeccionDeCartasDeMano.
	
	cart1Pie := CartaDeTruco bastoCon: 6.
	cart2Pie := CartaDeTruco espadaCon: 6.
	cart3Pie := CartaDeTruco oroCon: 6.
	
	unaColeccionDeCartasDePie := OrderedCollection with: cart1Pie with: cart2Pie with: cart3Pie.
	jugadorPie := Jugador conNombre: 'y' conCartas: unaColeccionDeCartasDePie.
	
	self 
		should: [RondaDeTruco conMano: jugadorMano conPie: jugadorPie]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: RondaDeTruco cartasEnMazoRepetidas equals: anError messageText.].
	
	
	

	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'TPL 7/5/2021 19:50:26'!
test04RondaArmadaConsistentementeSinCartasRepetidasEntreJugadores
	| cart1Mano cart2Mano cart3Mano jugadorMano cart1Pie cart2Pie cart3Pie jugadorPie rondaDeTruco unaColeccionDeCartasDeMano unaColeccionDeCartasDePie|
	
	cart1Mano := CartaDeTruco bastoCon: 6.
	cart2Mano := CartaDeTruco espadaCon: 6.
	cart3Mano := CartaDeTruco oroCon: 6.
	
	unaColeccionDeCartasDeMano := OrderedCollection with: cart1Mano with: cart2Mano with: cart3Mano.
	jugadorMano := Jugador conNombre: 'x' conCartas: unaColeccionDeCartasDeMano.
	
	cart1Pie := CartaDeTruco bastoCon: 1.
	cart2Pie := CartaDeTruco espadaCon: 2.
	cart3Pie := CartaDeTruco oroCon: 3.
	
	unaColeccionDeCartasDePie := OrderedCollection with: cart1Pie with: cart2Pie with: cart3Pie.
	jugadorPie := Jugador conNombre: 'y' conCartas: unaColeccionDeCartasDePie.
	
	rondaDeTruco := RondaDeTruco conMano: jugadorMano conPie: jugadorPie.
	
	self assert: (((rondaDeTruco mano) cartas) at:1) = cart1Mano.
	self assert: (((rondaDeTruco mano) cartas) at:2) = cart2Mano.
	self assert: (((rondaDeTruco mano) cartas) at:3) = cart3Mano.
	self assert: (((rondaDeTruco pie) cartas) at:1) = cart1Pie.
	self assert: (((rondaDeTruco pie) cartas) at:2) = cart2Pie.
	self assert: (((rondaDeTruco pie) cartas) at:3) = cart3Pie.
	

	
	
	

	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'TPL 7/5/2021 19:52:26'!
test05DevolverErrorSiJugadoresTienenMismoNombre
	| cart1Mano cart2Mano cart3Mano jugadorMano cart1Pie cart2Pie cart3Pie jugadorPie unaColeccionDeCartasDeMano unaColeccionDeCartasDePie|
	
	cart1Mano := CartaDeTruco bastoCon: 1.
	cart2Mano := CartaDeTruco espadaCon: 7.
	cart3Mano := CartaDeTruco oroCon: 6.
	
	unaColeccionDeCartasDeMano := OrderedCollection with: cart1Mano with: cart2Mano with: cart3Mano.
	jugadorMano := Jugador conNombre:'x' conCartas: unaColeccionDeCartasDeMano.
	
	cart1Pie := CartaDeTruco bastoCon: 4.
	cart2Pie := CartaDeTruco espadaCon: 4.
	cart3Pie := CartaDeTruco oroCon: 4.
	
	unaColeccionDeCartasDePie := OrderedCollection with: cart1Pie with: cart2Pie with: cart3Pie.
	jugadorPie := Jugador conNombre:'x' conCartas: unaColeccionDeCartasDePie.
		
	self 
		should: [RondaDeTruco conMano: jugadorMano conPie: jugadorPie]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: RondaDeTruco jugadoresConMismosNombres equals: anError messageText.].

	
	
	

	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'TPL 7/5/2021 19:59:09'!
test06EnfrentamientoUnoDeberiaEmpezarLaMano
	| cart1Mano cart2Mano cart3Mano jugadorMano cart1Pie cart2Pie cart3Pie jugadorPie rondaDeTruco unaColeccionDeCartasDeMano unaColeccionDeCartasDePie|
	
	cart1Mano := CartaDeTruco bastoCon: 1.
	cart2Mano := CartaDeTruco espadaCon: 7.
	cart3Mano := CartaDeTruco oroCon: 6.
	
	unaColeccionDeCartasDeMano := OrderedCollection with: cart1Mano with: cart2Mano with: cart3Mano.
	jugadorMano := Jugador conNombre: 'x' conCartas: unaColeccionDeCartasDeMano.
	
	cart1Pie := CartaDeTruco bastoCon: 4.
	cart2Pie := CartaDeTruco espadaCon: 4.
	cart3Pie := CartaDeTruco oroCon: 4.
	
	unaColeccionDeCartasDePie := OrderedCollection with: cart1Pie with: cart2Pie with: cart3Pie.
	jugadorPie := Jugador conNombre: 'y' conCartas: unaColeccionDeCartasDePie.
	
	rondaDeTruco := RondaDeTruco conMano: jugadorMano conPie: jugadorPie.
	
	self assert: (rondaDeTruco manoEnfrentamiento: 1) equals: 'x'.

	
	
	

	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'TPL 7/5/2021 20:01:03'!
test07EnfrentamientoDosDeberiaEmpezarQuienGanoLaManoUnoQueNoFueParda
	| cart1Mano cart2Mano cart3Mano jugadorMano cart1Pie cart2Pie cart3Pie jugadorPie rondaDeTruco unaColeccionDeCartasDeMano unaColeccionDeCartasDePie|
	
	cart1Mano := CartaDeTruco bastoCon: 4.
	cart2Mano := CartaDeTruco espadaCon: 7.
	cart3Mano := CartaDeTruco oroCon: 6.
	
	unaColeccionDeCartasDeMano := OrderedCollection with: cart1Mano with: cart2Mano with: cart3Mano.
	jugadorMano := Jugador conNombre: 'x' conCartas: unaColeccionDeCartasDeMano.
	
	cart1Pie := CartaDeTruco bastoCon: 5.
	cart2Pie := CartaDeTruco espadaCon: 4.
	cart3Pie := CartaDeTruco oroCon: 4.
	
	unaColeccionDeCartasDePie := OrderedCollection with: cart1Pie with: cart2Pie with: cart3Pie.
	jugadorPie := Jugador conNombre: 'y' conCartas: unaColeccionDeCartasDePie.
	
	rondaDeTruco := RondaDeTruco conMano: jugadorMano conPie: jugadorPie.
	
	self assert: (rondaDeTruco manoEnfrentamiento: 2) equals: 'y'.

	
	
	

	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'TPL 7/5/2021 20:08:45'!
test08EnfrentamientoDosDeberiaEmpezarManoSiEnfrentamientoUnoFueParda
	| cart1Mano cart2Mano cart3Mano jugadorMano cart1Pie cart2Pie cart3Pie jugadorPie rondaDeTruco unaColeccionDeCartasDeMano unaColeccionDeCartasDePie|
	
	cart1Mano := CartaDeTruco bastoCon: 4.
	cart2Mano := CartaDeTruco espadaCon: 7.
	cart3Mano := CartaDeTruco oroCon: 6.
	
	unaColeccionDeCartasDeMano := OrderedCollection with: cart1Mano with: cart2Mano with: cart3Mano.
	jugadorMano := Jugador conNombre: 'x' conCartas: unaColeccionDeCartasDeMano.
	
	cart1Pie := CartaDeTruco copaCon: 4.
	cart2Pie := CartaDeTruco espadaCon: 4.
	cart3Pie := CartaDeTruco oroCon: 4.
	
	unaColeccionDeCartasDePie := OrderedCollection with: cart1Pie with: cart2Pie with: cart3Pie.
	jugadorPie := Jugador conNombre: 'y' conCartas: unaColeccionDeCartasDePie.
	
	rondaDeTruco := RondaDeTruco conMano: jugadorMano conPie: jugadorPie.
	
	self assert: (rondaDeTruco manoEnfrentamiento: 2) equals: 'x'.

	
	
	

	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'TPL 7/5/2021 20:36:49'!
test09DevolverErrorSiSePideGanadorDelEnfrentamientoTresSiYaHayGanador
	| cart1Mano cart2Mano cart3Mano jugadorMano cart1Pie cart2Pie cart3Pie jugadorPie rondaDeTruco unaColeccionDeCartasDeMano unaColeccionDeCartasDePie|
	
	cart1Mano := CartaDeTruco bastoCon: 1.
	cart2Mano := CartaDeTruco espadaCon: 1.
	cart3Mano := CartaDeTruco oroCon: 6.
	
	unaColeccionDeCartasDeMano := OrderedCollection with: cart1Mano with: cart2Mano with: cart3Mano.
	jugadorMano := Jugador conNombre: 'x' conCartas: unaColeccionDeCartasDeMano.
	
	cart1Pie := CartaDeTruco copaCon: 4.
	cart2Pie := CartaDeTruco espadaCon: 4.
	cart3Pie := CartaDeTruco oroCon: 4.
	
	unaColeccionDeCartasDePie := OrderedCollection with: cart1Pie with: cart2Pie with: cart3Pie.
	jugadorPie := Jugador conNombre: 'y' conCartas: unaColeccionDeCartasDePie.
	
	rondaDeTruco := RondaDeTruco conMano: jugadorMano conPie: jugadorPie.
	
		self 
		should: [rondaDeTruco manoEnfrentamiento: 3]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: RondaDeTruco rondaTerminadaConAnterioridad equals: anError messageText.].

	
	
	

	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'TPL 7/5/2021 20:39:44'!
test10DevolverGanadorDeLaRondaEnDosManosConPrimeraParda
	| cart1Mano cart2Mano cart3Mano jugadorMano cart1Pie cart2Pie cart3Pie jugadorPie rondaDeTruco unaColeccionDeCartasDeMano unaColeccionDeCartasDePie|
	
	cart1Mano := CartaDeTruco bastoCon: 4.
	cart2Mano := CartaDeTruco espadaCon: 1.
	cart3Mano := CartaDeTruco oroCon: 6.
	
	unaColeccionDeCartasDeMano := OrderedCollection with: cart1Mano with: cart2Mano with: cart3Mano.
	jugadorMano := Jugador conNombre: 'x' conCartas: unaColeccionDeCartasDeMano.
	
	cart1Pie := CartaDeTruco copaCon: 4.
	cart2Pie := CartaDeTruco espadaCon: 4.
	cart3Pie := CartaDeTruco oroCon: 4.
	
	unaColeccionDeCartasDePie := OrderedCollection with: cart1Pie with: cart2Pie with: cart3Pie.
	jugadorPie := Jugador conNombre: 'y' conCartas: unaColeccionDeCartasDePie.
	
	rondaDeTruco := RondaDeTruco conMano: jugadorMano conPie: jugadorPie.
	
	self assert: (rondaDeTruco ganador) equals: 'x'.


	
	
	

	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'TPL 7/5/2021 21:03:19'!
test11DevolverGanadorDeLaRondaEnDosManosSinPardas
	| cart1Mano cart2Mano cart3Mano jugadorMano cart1Pie cart2Pie cart3Pie jugadorPie rondaDeTruco unaColeccionDeCartasDeMano unaColeccionDeCartasDePie|
	
	cart1Mano := CartaDeTruco bastoCon: 4.
	cart2Mano := CartaDeTruco bastoCon: 6.
	cart3Mano := CartaDeTruco oroCon: 6.
	
	unaColeccionDeCartasDeMano := OrderedCollection with: cart1Mano with: cart2Mano with: cart3Mano.
	jugadorMano := Jugador conNombre: 'x' conCartas: unaColeccionDeCartasDeMano.
	
	cart1Pie := CartaDeTruco copaCon: 5.
	cart2Pie := CartaDeTruco espadaCon: 7.
	cart3Pie := CartaDeTruco oroCon: 4.
	
	unaColeccionDeCartasDePie := OrderedCollection with: cart1Pie with: cart2Pie with: cart3Pie.
	jugadorPie := Jugador conNombre: 'y' conCartas: unaColeccionDeCartasDePie.
	
	rondaDeTruco := RondaDeTruco conMano: jugadorMano conPie: jugadorPie.
	
	self assert: (rondaDeTruco ganador) equals: 'y'.


	
	
	

	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'TPL 7/5/2021 21:11:31'!
test12DevolverGanadorEnTresManos
	| cart1Mano cart2Mano cart3Mano jugadorMano cart1Pie cart2Pie cart3Pie jugadorPie rondaDeTruco unaColeccionDeCartasDeMano unaColeccionDeCartasDePie|
	
	cart1Mano := CartaDeTruco bastoCon: 4.
	cart2Mano := CartaDeTruco bastoCon: 1.
	cart3Mano := CartaDeTruco oroCon: 6.
	
	unaColeccionDeCartasDeMano := OrderedCollection with: cart1Mano with: cart2Mano with: cart3Mano.
	jugadorMano := Jugador conNombre: 'x' conCartas: unaColeccionDeCartasDeMano.
	
	cart1Pie := CartaDeTruco copaCon: 6.
	cart2Pie := CartaDeTruco espadaCon: 7.
	cart3Pie := CartaDeTruco oroCon: 4.
	
	unaColeccionDeCartasDePie := OrderedCollection with: cart1Pie with: cart2Pie with: cart3Pie.
	jugadorPie := Jugador conNombre: 'y' conCartas: unaColeccionDeCartasDePie.
	
	rondaDeTruco := RondaDeTruco conMano: jugadorMano conPie: jugadorPie.
	
	self assert: (rondaDeTruco ganador) equals: 'x'.


	
	
	

	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'TPL 7/5/2021 21:16:22'!
test13DevolverQueNoHayGanadorCuandoHayEmpate
	| cart1Mano cart2Mano cart3Mano jugadorMano cart1Pie cart2Pie cart3Pie jugadorPie rondaDeTruco unaColeccionDeCartasDeMano unaColeccionDeCartasDePie|
	
	cart1Mano := CartaDeTruco espadaCon: 4.
	cart2Mano := CartaDeTruco oroCon: 5.
	cart3Mano := CartaDeTruco bastoCon: 6.
	
	unaColeccionDeCartasDeMano := OrderedCollection with: cart1Mano with: cart2Mano with: cart3Mano.
	jugadorMano := Jugador conNombre: 'x' conCartas: unaColeccionDeCartasDeMano.
	
	cart1Pie := CartaDeTruco copaCon: 4.
	cart2Pie := CartaDeTruco espadaCon: 5.
	cart3Pie := CartaDeTruco oroCon: 6.
	
	unaColeccionDeCartasDePie := OrderedCollection with: cart1Pie with: cart2Pie with: cart3Pie.
	jugadorPie := Jugador conNombre: 'y' conCartas: unaColeccionDeCartasDePie.
	
	rondaDeTruco := RondaDeTruco conMano: jugadorMano conPie: jugadorPie.
	
	self 
	should: [rondaDeTruco ganador]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: RondaDeTruco rondaTerminadaConEmpate equals: anError messageText.].

	
	

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
	instanceVariableNames: 'nombre cartas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Jugador methodsFor: 'estado' stamp: 'TPL 7/5/2021 19:13:27'!
cartas
^cartas! !

!Jugador methodsFor: 'estado' stamp: 'TPL 7/5/2021 19:56:23'!
nombre
^nombre! !


!Jugador methodsFor: 'inicio' stamp: 'TPL 7/5/2021 19:55:25'!
inicializarConNombre: unNombre conCartas: unaColeccionDeCartas.
	nombre:= unNombre.
	cartas:=unaColeccionDeCartas.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Jugador class' category: 'ISW1-2021-1C-2doParcial'!
Jugador class
	instanceVariableNames: ''!

!Jugador class methodsFor: 'mensajes' stamp: 'TPL 7/5/2021 18:14:35'!
cartasEnManoRepetidas
	^'Cartas en mano repetidas'! !


!Jugador class methodsFor: 'inicio' stamp: 'TPL 7/5/2021 19:54:54'!
conNombre: aNombre conCartas: unaColeccionDeCartas
	
	((unaColeccionDeCartas asSet) size == 3) ifFalse:[^self errorCartasDeJugadorRepetidas].
	^self new inicializarConNombre: aNombre conCartas: unaColeccionDeCartas.! !


!Jugador class methodsFor: 'errores' stamp: 'TPL 7/5/2021 18:13:56'!
errorCartasDeJugadorRepetidas
	self error: self cartasEnManoRepetidas! !


!classDefinition: #RondaDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #RondaDeTruco
	instanceVariableNames: 'mano pie'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTruco methodsFor: 'jugadores' stamp: 'TPL 7/5/2021 18:32:50'!
mano
^mano! !

!RondaDeTruco methodsFor: 'jugadores' stamp: 'TPL 7/5/2021 18:32:55'!
pie
^pie! !


!RondaDeTruco methodsFor: 'enfrentamiento' stamp: 'TPL 7/5/2021 21:32:00'!
cantidadEnfrentamientosGanados: unJugador
	|enfrentamientosGanados|
	enfrentamientosGanados _ 0.
	1 to: 3 do: [:e | ((self ganadorEnfrentamiento: e) == (unJugador nombre)) ifTrue:[enfrentamientosGanados _ enfrentamientosGanados + 1]].
	^enfrentamientosGanados.! !

!RondaDeTruco methodsFor: 'enfrentamiento' stamp: 'TPL 7/5/2021 21:27:27'!
ganadorEnfrentamiento: numeroDeEnfrentamiento
(((mano cartas) at: numeroDeEnfrentamiento) mataA: ((pie cartas) at: numeroDeEnfrentamiento)) ifTrue:[^mano nombre].
(((pie cartas) at: numeroDeEnfrentamiento) mataA: ((mano cartas) at: numeroDeEnfrentamiento)) ifTrue:[^pie nombre].

^self class errorSinGanadorEnEnfrentamiento! !

!RondaDeTruco methodsFor: 'enfrentamiento' stamp: 'TPL 7/5/2021 21:25:01'!
manoEnfrentamiento: numeroDeEnfrentamiento
(numeroDeEnfrentamiento==1) ifTrue: [^mano nombre].

(self pardaEnfrentamiento: numeroDeEnfrentamiento - 1) ifTrue:[^ mano nombre].

(self rondaTerminadaAntesDe: numeroDeEnfrentamiento) ifTrue:[^self class errorRondaTerminadaConAnterioridad ].

^self ganadorEnfrentamiento: (numeroDeEnfrentamiento - 1).
! !

!RondaDeTruco methodsFor: 'enfrentamiento' stamp: 'TPL 7/5/2021 20:14:05'!
pardaEnfrentamiento: numeroDeEnfrentamiento
^((mano cartas) at: numeroDeEnfrentamiento) empardaCon: ((pie cartas) at: numeroDeEnfrentamiento)! !


!RondaDeTruco methodsFor: 'inicio' stamp: 'TPL 7/5/2021 18:32:28'!
inicializarRondaConJugadorMano: unJugadorMano yUnJugadorPie: unJugadorPie
	mano:=unJugadorMano.
	pie:= unJugadorPie.! !


!RondaDeTruco methodsFor: 'resultado' stamp: 'TPL 7/5/2021 21:16:03'!
ganador
((self pardaEnfrentamiento: 1) and: ((self pardaEnfrentamiento: 2) not)) ifTrue:[^self ganadorEnfrentamiento: 2].
((self pardaEnfrentamiento: 1) and: (self pardaEnfrentamiento: 2) and: ((self pardaEnfrentamiento: 3) not)) ifTrue:[^self ganadorEnfrentamiento: 3].
((self pardaEnfrentamiento: 1) and: (self pardaEnfrentamiento: 2) and: (self pardaEnfrentamiento: 3)) ifTrue:[^self class errorRondaTerminadaConEmpate].
((self cantidadEnfrentamientosGanados: mano) > (self cantidadEnfrentamientosGanados: pie)) ifTrue: [^mano nombre].
^pie nombre! !


!RondaDeTruco methodsFor: 'auxiliares' stamp: 'TPL 7/5/2021 21:25:35'!
rondaTerminadaAntesDe: unNumeroDeEnfrentamiento
^(unNumeroDeEnfrentamiento == 3) and: ((self pardaEnfrentamiento: 1) or: ((self ganadorEnfrentamiento: 1) == (self ganadorEnfrentamiento: 2)))! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RondaDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco class
	instanceVariableNames: ''!

!RondaDeTruco class methodsFor: 'errores' stamp: 'TPL 7/5/2021 18:13:19'!
errorCartasMazoRepetidas
	self error: self cartasEnMazoRepetidas! !

!RondaDeTruco class methodsFor: 'errores' stamp: 'TPL 7/5/2021 19:53:15'!
errorNombreDeJugadoresRepetidos
	self error: self jugadoresConMismosNombres ! !

!RondaDeTruco class methodsFor: 'errores' stamp: 'TPL 7/5/2021 20:23:47'!
errorRondaTerminadaConAnterioridad
	self error: self rondaTerminadaConAnterioridad ! !

!RondaDeTruco class methodsFor: 'errores' stamp: 'TPL 7/5/2021 21:15:36'!
errorRondaTerminadaConEmpate
	self error: self rondaTerminadaConEmpate ! !

!RondaDeTruco class methodsFor: 'errores' stamp: 'TPL 7/5/2021 21:27:41'!
errorSinGanadorEnEnfrentamiento
	self error: self sinGanadorEnEnfrentamiento ! !


!RondaDeTruco class methodsFor: 'inicio' stamp: 'TPL 7/5/2021 19:54:08'!
conMano: unJugadorMano conPie: unJugadorPie
	|cartasDeRonda|
	cartasDeRonda:=Set new.

	unJugadorMano cartas do: [:a | cartasDeRonda add: a].
	unJugadorPie cartas do: [:a | cartasDeRonda add: a].
	(cartasDeRonda size == 6) ifFalse:[^self errorCartasMazoRepetidas].
	
	(unJugadorMano nombre == unJugadorPie nombre) ifTrue:[^self errorNombreDeJugadoresRepetidos].
	
	^self new inicializarRondaConJugadorMano: unJugadorMano yUnJugadorPie: unJugadorPie .! !


!RondaDeTruco class methodsFor: 'mensajes' stamp: 'TPL 7/5/2021 18:13:04'!
cartasEnMazoRepetidas
	^'Cartas repetidas'! !

!RondaDeTruco class methodsFor: 'mensajes' stamp: 'TPL 7/5/2021 19:52:53'!
jugadoresConMismosNombres
	^'Nombres de jugadores repetidos'! !

!RondaDeTruco class methodsFor: 'mensajes' stamp: 'TPL 7/5/2021 20:23:28'!
rondaTerminadaConAnterioridad
	^'Ronda terminada con anterioridad'! !

!RondaDeTruco class methodsFor: 'mensajes' stamp: 'TPL 7/5/2021 21:15:10'!
rondaTerminadaConEmpate
	^'Empate'! !

!RondaDeTruco class methodsFor: 'mensajes' stamp: 'TPL 7/5/2021 21:27:57'!
sinGanadorEnEnfrentamiento
	^'Sin ganador en enfrentamiento'.! !
