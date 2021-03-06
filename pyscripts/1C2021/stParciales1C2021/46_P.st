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


!classDefinition: #JugadorDeRondaTest category: 'ISW1-2021-1C-2doParcial'!
TestCase subclass: #JugadorDeRondaTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!JugadorDeRondaTest methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 21:54:04'!
test01NoSePuedeCrearUnJugadorSinExactamente3Cartas

	| anchoDeBasto anchoDeEspada sieteDeEspada sieteDeOro |
	self 
		should: [ JugadorDeRonda conCartas: OrderedCollection new .  ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: JugadorDeRonda cartasEnManoInvalidasErrorDescription equals: anError messageText.
			].

	anchoDeEspada := CartaDeTruco anchoDeEspada.
	anchoDeBasto := CartaDeTruco anchoDeBasto .
	sieteDeEspada := CartaDeTruco sieteDeEspada .
	sieteDeOro := CartaDeTruco sieteDeOro .


	self 
		should: [ JugadorDeRonda conCartas: 
	(OrderedCollection with: anchoDeEspada with: anchoDeBasto with: sieteDeEspada with: sieteDeOro) .  ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: JugadorDeRonda cartasEnManoInvalidasErrorDescription equals: anError messageText.
			].
	 ! !

!JugadorDeRondaTest methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 21:54:04'!
test02NoSePuedeCrearUnJugadorConCartasRepetidas

	| carta |
	carta := CartaDeTruco anchoDeEspada.

	self 
		should: [ JugadorDeRonda conCartas: (OrderedCollection with: carta with: carta with: carta) .   ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: JugadorDeRonda cartasEnManoInvalidasErrorDescription equals: anError messageText.
			]! !

!JugadorDeRondaTest methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 21:54:04'!
test03JugadorTiraLas3CartasEnOrden

	| jugador anchoDeBasto anchoDeEspada primeraCartaTirada segundaCartaTirada sieteDeEspada terceraCartaTirada |
	
	anchoDeEspada := CartaDeTruco anchoDeEspada.
	anchoDeBasto := CartaDeTruco anchoDeBasto .
	sieteDeEspada := CartaDeTruco sieteDeEspada .

	jugador := JugadorDeRonda conCartas: (OrderedCollection with: anchoDeEspada with: anchoDeBasto with: sieteDeEspada) . 

	primeraCartaTirada := jugador tiraCarta.
	segundaCartaTirada := jugador tiraCarta.
	terceraCartaTirada := jugador tiraCarta.

	
	self assert: primeraCartaTirada = anchoDeEspada.
	self assert: segundaCartaTirada = anchoDeBasto.
	self assert: terceraCartaTirada = sieteDeEspada.
	self assert: jugador sinCartas.

	! !

!JugadorDeRondaTest methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 21:54:04'!
test04JugadorNoPuedeTirarCuandoSeQuedaSinCartas

	| jugador anchoDeBasto anchoDeEspada sieteDeEspada |
	
	anchoDeEspada := CartaDeTruco anchoDeEspada.
	anchoDeBasto := CartaDeTruco anchoDeBasto .
	sieteDeEspada := CartaDeTruco sieteDeEspada .

	jugador := JugadorDeRonda conCartas: (OrderedCollection with: anchoDeEspada with: anchoDeBasto with: sieteDeEspada) . 
	
	jugador tiraCarta.
	jugador tiraCarta.
	jugador tiraCarta.
	
	self 
		should: [ jugador tiraCarta ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: JugadorDeRonda sinCartasErrorDescription equals: anError messageText.
			]
	
	
	
	
	
	! !


!classDefinition: #RondaDeTrucoTest category: 'ISW1-2021-1C-2doParcial'!
TestCase subclass: #RondaDeTrucoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 21:54:04'!
test02PieNoPuedeTirarPrimero

	| mano anchoDeBasto anchoDeEspada pie sieteDeEspada ronda sieteDeOro tresDeBasto tresDeCopa |
	anchoDeEspada := CartaDeTruco anchoDeEspada.
	anchoDeBasto := CartaDeTruco anchoDeBasto .
	sieteDeEspada := CartaDeTruco sieteDeEspada .
	mano := JugadorDeRonda conCartas: (OrderedCollection with: anchoDeEspada with: anchoDeBasto with: sieteDeEspada) .
	
	sieteDeOro := CartaDeTruco sieteDeOro.
	tresDeBasto := CartaDeTruco bastoCon: 3.
	tresDeCopa := CartaDeTruco copaCon: 3.
	pie := JugadorDeRonda conCartas: (OrderedCollection with: sieteDeOro with: tresDeBasto with: tresDeCopa) .  
	
	ronda := RondaDeTruco paraMano: mano yPie: pie.
	
	self
		should: [ pie tirarCartaEn: ronda.  ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: RondaDeTruco noEsElTurnoDelJugadorErrorDescription equals: anError messageText.
			]! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 21:54:04'!
test03ManoTiraPrimero

	| mano anchoDeBasto anchoDeEspada pie sieteDeEspada ronda sieteDeOro tresDeBasto tresDeCopa |
	anchoDeEspada := CartaDeTruco anchoDeEspada.
	anchoDeBasto := CartaDeTruco anchoDeBasto .
	sieteDeEspada := CartaDeTruco sieteDeEspada .
	mano := JugadorDeRonda conCartas: (OrderedCollection with: anchoDeEspada with: anchoDeBasto with: sieteDeEspada) .
	
	sieteDeOro := CartaDeTruco sieteDeOro.
	tresDeBasto := CartaDeTruco bastoCon: 3.
	tresDeCopa := CartaDeTruco copaCon: 3.
	pie := JugadorDeRonda conCartas: (OrderedCollection with: sieteDeOro with: tresDeBasto with: tresDeCopa) .  
	
	ronda := RondaDeTruco paraMano: mano yPie: pie.
	
	mano tirarCartaEn: ronda. 
	
	self assert: mano cantidadDeCartas equals: 2.
	self assert: pie cantidadDeCartas equals: 3.

	
	
	
	
	
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 21:54:04'!
test04PieTiraSegundo

	| mano anchoDeBasto anchoDeEspada pie sieteDeEspada ronda sieteDeOro tresDeBasto tresDeCopa |
	anchoDeEspada := CartaDeTruco anchoDeEspada.
	anchoDeBasto := CartaDeTruco anchoDeBasto .
	sieteDeEspada := CartaDeTruco sieteDeEspada .
	mano := JugadorDeRonda conCartas: (OrderedCollection with: anchoDeEspada with: anchoDeBasto with: sieteDeEspada) .
	
	sieteDeOro := CartaDeTruco sieteDeOro.
	tresDeBasto := CartaDeTruco bastoCon: 3.
	tresDeCopa := CartaDeTruco copaCon: 3.
	pie := JugadorDeRonda conCartas: (OrderedCollection with: sieteDeOro with: tresDeBasto with: tresDeCopa) .  
	
	ronda := RondaDeTruco paraMano: mano yPie: pie.
	
	mano tirarCartaEn: ronda. 
	pie tirarCartaEn: ronda. 

	self assert: mano cantidadDeCartas equals: 2.
	self assert: pie cantidadDeCartas equals: 2.
	self assert: ronda ganadorUltimaManoJugada equals: mano.

	
	
	
	
	
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 21:54:04'!
test05ManoNoPuedeTirarSegundo

	| mano anchoDeBasto anchoDeEspada pie sieteDeEspada ronda sieteDeOro tresDeBasto tresDeCopa |
	anchoDeEspada := CartaDeTruco anchoDeEspada.
	anchoDeBasto := CartaDeTruco anchoDeBasto .
	sieteDeEspada := CartaDeTruco sieteDeEspada .
	mano := JugadorDeRonda conCartas: (OrderedCollection with: anchoDeEspada with: anchoDeBasto with: sieteDeEspada) .
	
	sieteDeOro := CartaDeTruco sieteDeOro.
	tresDeBasto := CartaDeTruco bastoCon: 3.
	tresDeCopa := CartaDeTruco copaCon: 3.
	pie := JugadorDeRonda conCartas: (OrderedCollection with: sieteDeOro with: tresDeBasto with: tresDeCopa) .  
	
	ronda := RondaDeTruco paraMano: mano yPie: pie.
	
	mano tirarCartaEn: ronda. 

	self
		should: [ mano tirarCartaEn: ronda.  ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: RondaDeTruco noEsElTurnoDelJugadorErrorDescription equals: anError messageText.
			]

	
	
	
	
	
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 21:54:04'!
test06PerdedorDePrimeraManoNoPuedeTirarPrimeroEnLaSegunda

	| mano anchoDeBasto anchoDeEspada pie sieteDeEspada ronda sieteDeOro tresDeBasto tresDeCopa |
	anchoDeEspada := CartaDeTruco anchoDeEspada.
	anchoDeBasto := CartaDeTruco anchoDeBasto .
	sieteDeEspada := CartaDeTruco sieteDeEspada .
	mano := JugadorDeRonda conCartas: (OrderedCollection with: anchoDeEspada with: anchoDeBasto with: sieteDeEspada) .
	
	sieteDeOro := CartaDeTruco sieteDeOro.
	tresDeBasto := CartaDeTruco bastoCon: 3.
	tresDeCopa := CartaDeTruco copaCon: 3.
	pie := JugadorDeRonda conCartas: (OrderedCollection with: sieteDeOro with: tresDeBasto with: tresDeCopa) .  
	
	ronda := RondaDeTruco paraMano: mano yPie: pie.
	
	mano tirarCartaEn: ronda. 
	pie tirarCartaEn: ronda. 

	self
		should: [ 	pie tirarCartaEn: ronda.  ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: RondaDeTruco noEsElTurnoDelJugadorErrorDescription equals: anError messageText 
		]

	
	
	
	
	
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 21:54:04'!
test07GanadorDePrimeraManoTiraPrimeroEnLaSegunda

	| mano anchoDeBasto anchoDeEspada pie sieteDeEspada ronda sieteDeOro tresDeBasto tresDeCopa |
	anchoDeEspada := CartaDeTruco anchoDeEspada.
	anchoDeBasto := CartaDeTruco anchoDeBasto .
	sieteDeEspada := CartaDeTruco sieteDeEspada .
	mano := JugadorDeRonda conCartas: (OrderedCollection with: anchoDeEspada with: anchoDeBasto with: sieteDeEspada) .
	
	sieteDeOro := CartaDeTruco sieteDeOro.
	tresDeBasto := CartaDeTruco bastoCon: 3.
	tresDeCopa := CartaDeTruco copaCon: 3.
	pie := JugadorDeRonda conCartas: (OrderedCollection with: sieteDeOro with: tresDeBasto with: tresDeCopa) .  
	
	ronda := RondaDeTruco paraMano: mano yPie: pie.
	
	mano tirarCartaEn: ronda. 
	pie tirarCartaEn: ronda. 
	mano tirarCartaEn: ronda. 
	
	self assert: mano cantidadDeCartas equals: 1.
	self assert: pie cantidadDeCartas equals: 2.
	
	
	
	
	
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 21:54:04'!
test08GanadorDePrimeraManoNoPuedeTirarSegundoEnLaSegunda

	| mano anchoDeBasto anchoDeEspada pie sieteDeEspada ronda sieteDeOro tresDeBasto tresDeCopa |
	anchoDeEspada := CartaDeTruco anchoDeEspada.
	anchoDeBasto := CartaDeTruco anchoDeBasto .
	sieteDeEspada := CartaDeTruco sieteDeEspada .
	mano := JugadorDeRonda conCartas: (OrderedCollection with: anchoDeEspada with: anchoDeBasto with: sieteDeEspada) .
	
	sieteDeOro := CartaDeTruco sieteDeOro.
	tresDeBasto := CartaDeTruco bastoCon: 3.
	tresDeCopa := CartaDeTruco copaCon: 3.
	pie := JugadorDeRonda conCartas: (OrderedCollection with: sieteDeOro with: tresDeBasto with: tresDeCopa) .  
	
	ronda := RondaDeTruco paraMano: mano yPie: pie.
	
	mano tirarCartaEn: ronda. 
	pie tirarCartaEn: ronda. 
	mano tirarCartaEn: ronda.
	self
		should: [ 	mano tirarCartaEn: ronda.  ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: RondaDeTruco noEsElTurnoDelJugadorErrorDescription equals: anError messageText 
		]

	
	
	
	
	
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 21:54:04'!
test09PieNoPuedeTirarPrimeroEnSegundaManoSiLaPrimeraFueParda

	| mano anchoDeBasto anchoDeEspada pie sieteDeEspada ronda sieteDeOro tresDeBasto tresDeOro |
	tresDeOro := CartaDeTruco oroCon: 3.
	anchoDeEspada := CartaDeTruco anchoDeEspada.
	anchoDeBasto := CartaDeTruco anchoDeBasto .
	mano := JugadorDeRonda conCartas: (OrderedCollection with: tresDeOro with: anchoDeEspada with: anchoDeBasto) .
	
	sieteDeOro := CartaDeTruco sieteDeOro.
	tresDeBasto := CartaDeTruco bastoCon: 3.
	sieteDeEspada := CartaDeTruco sieteDeEspada .
	pie := JugadorDeRonda conCartas: (OrderedCollection with: tresDeBasto with: sieteDeOro with: sieteDeEspada) .  
	
	ronda := RondaDeTruco paraMano: mano yPie: pie.
	
	mano tirarCartaEn: ronda. 
	pie tirarCartaEn: ronda. 
	
	self
		should: [ 	pie tirarCartaEn: ronda.  ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: RondaDeTruco noEsElTurnoDelJugadorErrorDescription equals: anError messageText 
		]
	
	
	
	
	
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 21:57:32'!
test10ManoTiraPrimeroEnSegundaManoSiLaPrimeraFueParda

	| mano anchoDeBasto anchoDeEspada pie sieteDeEspada ronda sieteDeOro tresDeBasto tresDeOro |
	tresDeOro := CartaDeTruco oroCon: 3.
	anchoDeEspada := CartaDeTruco anchoDeEspada.
	anchoDeBasto := CartaDeTruco anchoDeBasto .
	mano := JugadorDeRonda conCartas: (OrderedCollection with: tresDeOro with: anchoDeEspada with: anchoDeBasto) .
	
	sieteDeOro := CartaDeTruco sieteDeOro.
	tresDeBasto := CartaDeTruco bastoCon: 3.
	sieteDeEspada := CartaDeTruco sieteDeEspada .
	pie := JugadorDeRonda conCartas: (OrderedCollection with: tresDeBasto with: sieteDeOro with: sieteDeEspada) .  
	
	ronda := RondaDeTruco paraMano: mano yPie: pie.
	
	mano tirarCartaEn: ronda. 
	pie tirarCartaEn: ronda. 
	mano tirarCartaEn: ronda. "Falla por el ganador de la anteultima"
	
	
	self assert: mano cantidadDeCartas equals: 1.
	self assert: pie cantidadDeCartas equals: 2.
	
	
	
	
	
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 21:54:04'!
test11PerdedorDeLaSegundaNoPuedeTirarPrimeroEnLaTercera

	| mano anchoDeBasto anchoDeEspada pie sieteDeEspada ronda sieteDeOro tresDeBasto tresDeOro |
	tresDeOro := CartaDeTruco oroCon: 3.
	anchoDeEspada := CartaDeTruco anchoDeEspada.
	anchoDeBasto := CartaDeTruco anchoDeBasto .
	mano := JugadorDeRonda conCartas: (OrderedCollection with: tresDeOro with: anchoDeEspada with: anchoDeBasto) .
	
	tresDeBasto := CartaDeTruco bastoCon: 3.
	sieteDeOro := CartaDeTruco sieteDeOro.
	sieteDeEspada := CartaDeTruco sieteDeEspada .
	pie := JugadorDeRonda conCartas: (OrderedCollection with:sieteDeOro  with:tresDeBasto  with: sieteDeEspada) .  
	
	ronda := RondaDeTruco paraMano: mano yPie: pie.
	
	mano tirarCartaEn: ronda. 
	pie tirarCartaEn: ronda. 
	pie tirarCartaEn: ronda. 
	mano tirarCartaEn: ronda. 

	self
		should: [ 	pie tirarCartaEn: ronda.  ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: RondaDeTruco noEsElTurnoDelJugadorErrorDescription equals: anError messageText 
		]
	
	
	
	
	
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


!classDefinition: #JugadorDeRonda category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #JugadorDeRonda
	instanceVariableNames: 'cartas estado cartasJugadas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!JugadorDeRonda methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 20:16:45'!
cantidadDeCartas

	^ cartas size .! !

!JugadorDeRonda methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 21:26:59'!
initializeWith: coleccionDeCartas

	cartas := coleccionDeCartas.
	cartasJugadas := OrderedCollection new.! !

!JugadorDeRonda methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 18:37:39'!
sinCartas

	^ cartas isEmpty .! !

!JugadorDeRonda methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 21:26:34'!
tiraCarta
	
	
	self sinCartas ifTrue: [ self error: self class sinCartasErrorDescription ].
	
	^ self tiraPrimerCarta.
	! !

!JugadorDeRonda methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 21:26:47'!
tiraPrimerCarta

	| carta |
	carta := cartas first.
	cartas removeFirst.
	cartasJugadas add: carta.
	^ carta.
	! !

!JugadorDeRonda methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 21:11:48'!
tirarCartaEn: ronda	
	
	ronda recibeCartaDe: self.
	
	
	! !

!JugadorDeRonda methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 21:49:11'!
ultimaCartaJugada
	
	^ cartasJugadas last.
	
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'JugadorDeRonda class' category: 'ISW1-2021-1C-2doParcial'!
JugadorDeRonda class
	instanceVariableNames: ''!

!JugadorDeRonda class methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 19:07:20'!
cartasEnManoInvalidasErrorDescription

	^'Jugador de ronda solo puede arrancar con exactamente 3 cartas distintas.'! !

!JugadorDeRonda class methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 21:54:04'!
conCartas: coleccionDeCartas  
	
	coleccionDeCartas asSet size = 3 ifFalse: [ self error: self cartasEnManoInvalidasErrorDescription. ].
	
	^ self new initializeWith: coleccionDeCartas.! !

!JugadorDeRonda class methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 18:28:45'!
sinCartasErrorDescription
	
	^'El jugador no tiene cartas para tirar'.! !


!classDefinition: #RondaDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #RondaDeTruco
	instanceVariableNames: 'turno mano pie manoCartasJugadas pieCartasJugadas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTruco methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 21:57:08'!
ganadorUltimaManoJugada

	(mano ultimaCartaJugada mataA: pie ultimaCartaJugada) ifTrue: [^mano].
	(pie ultimaCartaJugada mataA: mano ultimaCartaJugada) ifTrue: [^pie]. 
	^#Parda "Aca deberia devolver el ganador de la anteultima pero no llego con el tiempo"

! !

!RondaDeTruco methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 20:33:18'!
initializeWithMano: jugadorMano andPie: jugadorPie

	mano := jugadorMano.
	pie := jugadorPie.! !

!RondaDeTruco methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 21:53:38'!
jugadorTurno
	mano cantidadDeCartas = 3 ifTrue: [^mano].
	(mano cantidadDeCartas = pie cantidadDeCartas) ifTrue: [^self ganadorUltimaManoJugada].
	(mano cantidadDeCartas < pie cantidadDeCartas) ifTrue: [^pie] ifFalse: [^mano].
! !

!RondaDeTruco methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 21:16:08'!
recibeCartaDe: jugador
	
	(self jugadorTurno) = jugador ifFalse: [ 
		self error: RondaDeTruco noEsElTurnoDelJugadorErrorDescription
		 ].
	jugador tiraCarta.

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RondaDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco class
	instanceVariableNames: ''!

!RondaDeTruco class methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 19:57:02'!
assertCartasRepetidas: coleccionDeCartas

	coleccionDeCartas asSet size = 6 ifFalse: [ self error: self cartasInvalidasErrorDescription ].! !

!RondaDeTruco class methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 19:45:18'!
cartasInvalidasErrorDescription

	^'La cantidad de cartas es invalida'! !

!RondaDeTruco class methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 20:13:22'!
noEsElTurnoDelJugadorErrorDescription

	^'No es el turno del jugador'! !

!RondaDeTruco class methodsFor: 'as yet unclassified' stamp: 'JN 7/5/2021 20:33:01'!
paraMano: jugadorMano yPie: jugadorPie

	^ self new initializeWithMano: jugadorMano andPie: jugadorPie.
	
! !
