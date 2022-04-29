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


!classDefinition: #JugadorDeTrucoTest category: 'ISW1-2021-1C-2doParcial'!
TestCase subclass: #JugadorDeTrucoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!JugadorDeTrucoTest methodsFor: 'tests' stamp: 'ja 7/5/2021 17:54:51'!
test01NoSePuedeCrearUnJugadorSinCartas

	self should: [ JugadorDeTruco conCartas: OrderedCollection new]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |  
			self assert: anError messageText equals: JugadorDeTruco noSePuedeCrearUnJugadorSinCartasErrorDescription].! !

!JugadorDeTrucoTest methodsFor: 'tests' stamp: 'ja 7/5/2021 18:13:53'!
test02NoSePuedeCrearJugadorConUnaCantidaDeCartasMenorA3

	| anchoDeBasto anchoDeEspada |
	
	anchoDeBasto _ CartaDeTruco anchoDeBasto.
	anchoDeEspada _ CartaDeTruco anchoDeEspada.

	self should: [ JugadorDeTruco conCartas: (OrderedCollection with: anchoDeBasto with: anchoDeEspada) ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |  
			self assert: anError messageText equals: JugadorDeTruco cantidadDeCartasInvalidasErrorDescription].! !

!JugadorDeTrucoTest methodsFor: 'tests' stamp: 'ja 7/5/2021 18:17:09'!
test03NoSePuedeCrearJugadorConUnaCantidaDeCartasMayorA3

	| anchoDeBasto anchoDeEspada sieteDeEspada sieteDeOro |
	
	anchoDeBasto _ CartaDeTruco anchoDeBasto.
	anchoDeEspada _ CartaDeTruco anchoDeEspada.
	sieteDeEspada _ CartaDeTruco espadaCon: 7.
	sieteDeOro _ CartaDeTruco oroCon: 7.

	self should: [ JugadorDeTruco conCartas: (OrderedCollection with: anchoDeBasto with: anchoDeEspada with: sieteDeEspada with: sieteDeOro) ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |  
			self assert: anError messageText equals: JugadorDeTruco cantidadDeCartasInvalidasErrorDescription].! !

!JugadorDeTrucoTest methodsFor: 'tests' stamp: 'ja 7/5/2021 18:19:26'!
test04NoSePuedeCrearJugadorConCartasRepetidas

	| anchoDeBasto anchoDeEspada |
	
	anchoDeBasto _ CartaDeTruco anchoDeBasto.
	anchoDeEspada _ CartaDeTruco anchoDeEspada.

	self should: [ JugadorDeTruco conCartas: (OrderedCollection with: anchoDeBasto with: anchoDeEspada with: anchoDeEspada) ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |  
			self assert: anError messageText equals: JugadorDeTruco cartasRepetidasErrorDescription].! !

!JugadorDeTrucoTest methodsFor: 'tests' stamp: 'ja 7/5/2021 18:26:25'!
test05SePuedeCrearJugadorCorrectamenteYConoceSusCartas

	| anchoDeBasto anchoDeEspada siesteDeEspada jugadorDeTruco |
	
	anchoDeBasto _ CartaDeTruco anchoDeBasto.
	anchoDeEspada _ CartaDeTruco anchoDeEspada.
	siesteDeEspada _ CartaDeTruco espadaCon: 7.
	
	jugadorDeTruco _ JugadorDeTruco conCartas: (OrderedCollection with: anchoDeBasto with: anchoDeEspada with: siesteDeEspada).
	
	self assert: jugadorDeTruco primerCarta = anchoDeBasto.
	self assert: jugadorDeTruco segundaCarta = anchoDeEspada.
	self assert: jugadorDeTruco tercerCarta = siesteDeEspada.! !


!classDefinition: #RondaDeTrucoTest category: 'ISW1-2021-1C-2doParcial'!
TestCase subclass: #RondaDeTrucoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ja 7/5/2021 20:17:28'!
test01NoSePuedeCrearUnaRondaDeTrucoSiPieNoEsJugadorDeTruco

	| jugadorDeTruco |
	
	jugadorDeTruco _ JugadorDeTruco conCartas: self cartasParaJugadorMano.
	
	 self should: [ RondaDeTruco conMano: jugadorDeTruco yPie: #X]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |  
			self assert: anError messageText equals: RondaDeTruco jugadorInvalidoErrorDescription]. ! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ja 7/5/2021 20:17:55'!
test02NoSePuedeCrearUnaRondaDeTrucoSiManoNoEsJugadorDeTruco

	| jugadorDeTruco |
	
	jugadorDeTruco _ JugadorDeTruco conCartas: self cartasParaJugadorMano.
	
	 self should: [ RondaDeTruco conMano: #X yPie: jugadorDeTruco]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |  
			self assert: anError messageText equals: RondaDeTruco jugadorInvalidoErrorDescription]. ! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ja 7/5/2021 18:56:47'!
test03LosJugadoresDeTrucoNoPuedenTenerCartasIguales

	| anchoDeBasto anchoDeEspada siesteDeEspada jugadorMano jugadorPie sieteDeBasto |
	
	anchoDeBasto _ CartaDeTruco anchoDeBasto.
	anchoDeEspada _ CartaDeTruco anchoDeEspada.
	siesteDeEspada _ CartaDeTruco espadaCon: 7.
	sieteDeBasto _ CartaDeTruco bastoCon: 7.
	
	jugadorMano _ JugadorDeTruco conCartas: (OrderedCollection with: anchoDeBasto with: anchoDeEspada with: siesteDeEspada).
	jugadorPie _ JugadorDeTruco conCartas: (OrderedCollection with: sieteDeBasto with: anchoDeEspada with: siesteDeEspada).	
	
	 self should: [ RondaDeTruco conMano: jugadorMano yPie: jugadorPie]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |  
			self assert: anError messageText equals: RondaDeTruco losJugadoresDeTrucoNoPuedenTenerCartasIgualesErrorDescription]. ! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ja 7/5/2021 20:19:34'!
test04JugadorManoNoPuedeJugarVecesConsecutivas

	| jugadorMano jugadorPie ronda |
	
	jugadorMano _ JugadorDeTruco conCartas: self cartasParaJugadorMano.
	jugadorPie _ JugadorDeTruco conCartas: self cartasParaJugadorPie .	
	
	ronda _ RondaDeTruco conMano: jugadorMano yPie: jugadorPie.
	ronda juegaPrimerCarta: jugadorMano.
	
	self should: [ronda juegaPrimerCarta: jugadorMano ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |  
			self assert: anError messageText equals: Enfrentamiento jugadorNoPuedePonerMasDeUnaCartaErrorDescription]. 
	
	
		! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ja 7/5/2021 20:47:26'!
test05NoSePuedeJugarSiSoloUnJugadorTiroUnaCarta

	| jugadorMano jugadorPie ronda |
	
	jugadorMano _ JugadorDeTruco conCartas: self cartasParaJugadorMano.
	jugadorPie _ JugadorDeTruco conCartas: self cartasParaJugadorPie .	
	
	ronda _ RondaDeTruco conMano: jugadorMano yPie: jugadorPie.
	ronda juegaPrimerCarta: jugadorMano.
	
	self should: [ronda jugarPrimerEnfrentamiento]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |  
			self assert: anError messageText equals: Enfrentamiento noSePuedeJugarErrorDescription]. 
	
	
		! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ja 7/5/2021 20:35:14'!
test06LaPrimerCartaDelPrimerEnfrentamientoLaTieneQuePonerLaMano

	| jugadorMano jugadorPie ronda |
	
	jugadorMano _ JugadorDeTruco conCartas: self cartasParaJugadorMano.
	jugadorPie _ JugadorDeTruco conCartas: self cartasParaJugadorPie .	
	
	ronda _ RondaDeTruco conMano: jugadorMano yPie: jugadorPie.
	
	self should: [ronda juegaPrimerCarta: jugadorPie .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |  
			self assert: anError messageText equals: RondaDeTruco manoJuegaPrimeroErrorDescription]. 
	
		
	
		! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ja 7/5/2021 20:47:26'!
test07ManoGanaElPrimerEnfrentamiento

	| jugadorMano jugadorPie ronda ganadorPrimerEnfrentamiento |
	
	jugadorMano _ JugadorDeTruco conCartas: self cartasParaJugadorMano.
	jugadorPie _ JugadorDeTruco conCartas: self cartasParaJugadorPie .	
	
	ronda _ RondaDeTruco conMano: jugadorMano yPie: jugadorPie.
	ronda juegaPrimerCarta: jugadorMano.
	ronda juegaPrimerCarta: jugadorPie.
	
	ganadorPrimerEnfrentamiento _ ronda jugarPrimerEnfrentamiento.
	
	self assert: ganadorPrimerEnfrentamiento = jugadorMano.
		
	
		! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ja 7/5/2021 20:47:26'!
test08ElJugadorQuePierdeElPrimerEnfrentamientoNoPuedeEmpezarElSegundoEnfrentamiento

	| jugadorMano jugadorPie ronda ganadorPrimerEnfrentamiento |
	
	jugadorMano _ JugadorDeTruco conCartas: self cartasParaJugadorMano.
	jugadorPie _ JugadorDeTruco conCartas: self cartasParaJugadorPie .	
	
	ronda _ RondaDeTruco conMano: jugadorMano yPie: jugadorPie.
	ronda juegaPrimerCarta: jugadorMano.
	ronda juegaPrimerCarta: jugadorPie.
	
	ganadorPrimerEnfrentamiento _ ronda jugarPrimerEnfrentamiento.
	self assert: ganadorPrimerEnfrentamiento = jugadorMano.
	
	 self should: [ronda juegaSegundaCarta: jugadorPie]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |  
			self assert: anError messageText equals: RondaDeTruco jugadorNoPuedeEmpezarEnfrentamientoErrorDescription].
	
	
		! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ja 7/5/2021 20:49:49'!
test09ManoGanaElPrimerYSegundoEnfrentamientoYGanaLaRonda

	| jugadorMano jugadorPie ronda ganadorPrimerEnfrentamiento ganadorSegundoEnfrentamiento |
	
	jugadorMano _ JugadorDeTruco conCartas: self cartasParaJugadorMano.
	jugadorPie _ JugadorDeTruco conCartas: self cartasParaJugadorPie .	
	
	ronda _ RondaDeTruco conMano: jugadorMano yPie: jugadorPie.
	ronda juegaPrimerCarta: jugadorMano.
	ronda juegaPrimerCarta: jugadorPie.
	
	ganadorPrimerEnfrentamiento _ ronda jugarPrimerEnfrentamiento.
	
	ronda juegaSegundaCarta: ganadorPrimerEnfrentamiento.
	ronda juegaSegundaCarta: jugadorPie.
	
	ganadorSegundoEnfrentamiento _ ronda jugar.
	
	self assert: ganadorPrimerEnfrentamiento = jugadorMano.
	self assert: ganadorSegundoEnfrentamiento = jugadorMano.
	self assert: jugadorMano = ronda ganador.
		! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ja 7/5/2021 21:21:26'!
test10SePuedeEmpardarLaPrimerMano

	| jugadorMano jugadorPie ronda |
	
	jugadorMano _ JugadorDeTruco conCartas: self cartasParaJugadorManoConPardaEnLaPrimerCarta.
	jugadorPie _ JugadorDeTruco conCartas: self cartasParaJugadorPieConPardaEnLaPrimerCarta .	
	
	ronda _ RondaDeTruco conMano: jugadorMano yPie: jugadorPie.
	ronda juegaPrimerCarta: jugadorMano.
	ronda juegaPrimerCarta: jugadorPie.
	
	ronda jugarPrimerEnfrentamiento.
	
	self assert: ronda empardaronLaPrimerMano.
		! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ja 7/5/2021 21:37:29'!
test11SiSeEmpardaElPrimerEnfrentamientoPieNoPuedeJugarPrimero

	| jugadorMano jugadorPie ronda |
	
	jugadorMano _ JugadorDeTruco conCartas: self cartasParaJugadorManoConPardaEnLaPrimerCarta.
	jugadorPie _ JugadorDeTruco conCartas: self cartasParaJugadorPieConPardaEnLaPrimerCarta .	
	
	ronda _ RondaDeTruco conMano: jugadorMano yPie: jugadorPie.
	ronda juegaPrimerCarta: jugadorMano.
	ronda juegaPrimerCarta: jugadorPie.
	
	ronda jugarPrimerEnfrentamiento.
	
	self assert: ronda empardaronLaPrimerMano.
	
	self should: [ronda juegaSegundaCarta: jugadorPie]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |  
			self assert: anError messageText equals: RondaDeTruco jugadorNoPuedeEmpezarEnfrentamientoErrorDescription].
	
		! !


!RondaDeTrucoTest methodsFor: 'cartas' stamp: 'ja 7/5/2021 20:17:00'!
cartasParaJugadorMano

	| anchoDeBasto anchoDeEspada siesteDeEspada |
	
	anchoDeBasto _ CartaDeTruco anchoDeBasto.
	anchoDeEspada _ CartaDeTruco anchoDeEspada.
	siesteDeEspada _ CartaDeTruco espadaCon: 7.
	
	^ OrderedCollection with: anchoDeBasto with: anchoDeEspada with: siesteDeEspada
	
	! !

!RondaDeTrucoTest methodsFor: 'cartas' stamp: 'ja 7/5/2021 21:23:47'!
cartasParaJugadorManoConPardaEnLaPrimerCarta

	| anchoDeEspada siesteDeEspada cuatroDeEspada |
	
	cuatroDeEspada _ CartaDeTruco espadaCon: 4.
	anchoDeEspada _ CartaDeTruco anchoDeEspada.
	siesteDeEspada _ CartaDeTruco espadaCon: 7.
	
	^ OrderedCollection with: cuatroDeEspada with: anchoDeEspada with: siesteDeEspada
	
	! !

!RondaDeTrucoTest methodsFor: 'cartas' stamp: 'ja 7/5/2021 20:19:11'!
cartasParaJugadorPie

	| sieteDeBasto cuatroDeCopa cuatroDeOro |
	
	sieteDeBasto _ CartaDeTruco bastoCon: 7.
	cuatroDeCopa _ CartaDeTruco copaCon: 4.
	cuatroDeOro _ CartaDeTruco oroCon: 4.
	
	^ OrderedCollection with: sieteDeBasto with: cuatroDeCopa with: cuatroDeOro.
		! !

!RondaDeTrucoTest methodsFor: 'cartas' stamp: 'ja 7/5/2021 21:22:46'!
cartasParaJugadorPieConPardaEnLaPrimerCarta

	| cuatroDeOro cuatroDeCopa cuatroDeBasto |
	
	cuatroDeBasto _ CartaDeTruco bastoCon: 4.
	cuatroDeCopa _ CartaDeTruco copaCon: 4.
	cuatroDeOro _ CartaDeTruco oroCon: 4.
	
	^ OrderedCollection with: cuatroDeBasto with: cuatroDeCopa with: cuatroDeOro
	
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


!classDefinition: #Enfrentamiento category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #Enfrentamiento
	instanceVariableNames: 'primerJugador segundoJugador cartaPrimerJugador cartaSegundoJugador'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Enfrentamiento methodsFor: 'initialization' stamp: 'ja 7/5/2021 19:55:26'!
initializeCon: unJugadorDeTruco 

	primerJugador _ unJugadorDeTruco ! !


!Enfrentamiento methodsFor: 'as yet unclassified' stamp: 'ja 7/5/2021 20:29:22'!
agregarSegundoJugador: otroJugadorDeTruco poniendo: unaCarta

	(primerJugador = otroJugadorDeTruco ) ifTrue: [ self error: self class jugadorNoPuedePonerMasDeUnaCartaErrorDescription ].
	
	segundoJugador _ otroJugadorDeTruco.
	cartaPrimerJugador _ unaCarta value: primerJugador .
	cartaSegundoJugador _ unaCarta value: segundoJugador.! !

!Enfrentamiento methodsFor: 'as yet unclassified' stamp: 'ja 7/5/2021 21:17:12'!
jugar

	(primerJugador isNil or:[ segundoJugador isNil]) ifTrue:[self error: self class noSePuedeJugarErrorDescription.].
	
	(cartaPrimerJugador mataA: cartaSegundoJugador) ifTrue:[ ^ primerJugador ].
	(cartaPrimerJugador empardaCon: cartaSegundoJugador) ifTrue:[^ nil].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Enfrentamiento class' category: 'ISW1-2021-1C-2doParcial'!
Enfrentamiento class
	instanceVariableNames: ''!

!Enfrentamiento class methodsFor: 'as yet unclassified' stamp: 'ja 7/5/2021 19:54:38'!
conPrimerJugador: unJugadorDeTruco 
	
	^ self new initializeCon: unJugadorDeTruco ! !

!Enfrentamiento class methodsFor: 'as yet unclassified' stamp: 'ja 7/5/2021 19:59:49'!
jugadorNoPuedePonerMasDeUnaCartaErrorDescription
	
	^  'Jugador No Puede Poner Mas De Una Carta' ! !

!Enfrentamiento class methodsFor: 'as yet unclassified' stamp: 'ja 7/5/2021 20:11:28'!
noSePuedeJugarErrorDescription
	
	^   'No se puede jugar si solo un jugador tiro una carta.' ! !


!classDefinition: #JugadorDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #JugadorDeTruco
	instanceVariableNames: 'cartas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!JugadorDeTruco methodsFor: 'initialization' stamp: 'ja 7/5/2021 17:57:13'!
initializeCon: unaColeccionDeCartas 
	
	cartas := unaColeccionDeCartas.! !


!JugadorDeTruco methodsFor: 'accessing' stamp: 'ja 7/5/2021 18:57:06'!
cartas

	^ cartas copy.! !

!JugadorDeTruco methodsFor: 'accessing' stamp: 'ja 7/5/2021 18:28:09'!
primerCarta

	^ cartas first.! !

!JugadorDeTruco methodsFor: 'accessing' stamp: 'ja 7/5/2021 18:28:21'!
segundaCarta

	^ cartas second .! !

!JugadorDeTruco methodsFor: 'accessing' stamp: 'ja 7/5/2021 18:28:28'!
tercerCarta

	^ cartas third .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'JugadorDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
JugadorDeTruco class
	instanceVariableNames: ''!

!JugadorDeTruco class methodsFor: 'instance creation' stamp: 'ja 7/5/2021 21:33:02'!
conCartas: unaColeccionDeCartas 
	
	
	self verificarCantidadDeCartasDe: unaColeccionDeCartas.
	self verificarQueNoHayaCartasRepetidasEn: unaColeccionDeCartas.
	
	^self new initializeCon: unaColeccionDeCartas ! !


!JugadorDeTruco class methodsFor: 'error description' stamp: 'ja 7/5/2021 18:09:38'!
cantidadDeCartasInvalidasErrorDescription
	
	^   'Cantidad de cartas invalidas.' ! !

!JugadorDeTruco class methodsFor: 'error description' stamp: 'ja 7/5/2021 18:20:28'!
cartasRepetidasErrorDescription
	
	^  'Cartas repetidas.' ! !

!JugadorDeTruco class methodsFor: 'error description' stamp: 'ja 7/5/2021 17:58:59'!
noSePuedeCrearUnJugadorSinCartasErrorDescription
	
	^  'No se puede crear un jugador sin cartas.' ! !


!JugadorDeTruco class methodsFor: 'assertions' stamp: 'ja 7/5/2021 21:31:21'!
verificarCantidadDeCartasDe: unaColeccionDeCartas

	unaColeccionDeCartas ifEmpty: [self error: self noSePuedeCrearUnJugadorSinCartasErrorDescription].
	((unaColeccionDeCartas size < 3) or:[unaColeccionDeCartas size > 3]) ifTrue: [self error: self cantidadDeCartasInvalidasErrorDescription]! !

!JugadorDeTruco class methodsFor: 'assertions' stamp: 'ja 7/5/2021 21:32:14'!
verificarQueNoHayaCartasRepetidasEn: unaColeccionDeCartas 
	
	| posiblesCartasRepetidas |
	
	posiblesCartasRepetidas _ unaColeccionDeCartas select:[:unaCarta | (unaColeccionDeCartas occurrencesOf: unaCarta) > 1].
	posiblesCartasRepetidas ifNotEmpty: [self error: self cartasRepetidasErrorDescription].
	! !


!classDefinition: #RondaDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #RondaDeTruco
	instanceVariableNames: 'mano pie primerEnfrentamiento ganadorPrimerEnfrentamiento segundoEnfrentamiento ganadorSegundoEnfrentamiento ganador empardaron tercerEnfrentamiento'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTruco methodsFor: 'juego' stamp: 'ja 7/5/2021 20:35:06'!
juegaPrimerCarta: unJugador

	primerEnfrentamiento ifNil:[ 
		(unJugador = mano) ifFalse:[ self error: self class manoJuegaPrimeroErrorDescription].
		primerEnfrentamiento _ Enfrentamiento conPrimerJugador: unJugador]
					ifNotNil:[primerEnfrentamiento agregarSegundoJugador: unJugador poniendo:[:jugador | jugador primerCarta]].
					
	! !

!RondaDeTruco methodsFor: 'juego' stamp: 'ja 7/5/2021 21:51:30'!
juegaSegundaCarta: unJugador

	segundoEnfrentamiento ifNil:[ 
		(unJugador = ganadorPrimerEnfrentamiento ) ifFalse:[ self error: self class jugadorNoPuedeEmpezarEnfrentamientoErrorDescription].
		(empardaron and:[(unJugador = ganadorPrimerEnfrentamiento) not]) ifTrue:[self error: self class jugadorNoPuedeEmpezarEnfrentamientoErrorDescription].
		segundoEnfrentamiento _ Enfrentamiento conPrimerJugador: unJugador]
					ifNotNil:[segundoEnfrentamiento agregarSegundoJugador: unJugador poniendo:[:jugador | jugador segundaCarta ]].
					
	! !

!RondaDeTruco methodsFor: 'juego' stamp: 'ja 7/5/2021 21:44:06'!
juegaTercerCarta: unJugador

	tercerEnfrentamiento ifNil:[ 
		(unJugador = ganadorSegundoEnfrentamiento) ifFalse:[ self error: self class jugadorNoPuedeEmpezarEnfrentamientoErrorDescription].
		
		tercerEnfrentamiento _ Enfrentamiento conPrimerJugador: unJugador]
					ifNotNil:[tercerEnfrentamiento agregarSegundoJugador: unJugador poniendo:[:jugador | jugador tercerCarta ]].
					
	! !

!RondaDeTruco methodsFor: 'juego' stamp: 'ja 7/5/2021 21:01:49'!
jugar

	ganadorSegundoEnfrentamiento _ segundoEnfrentamiento jugar.
	
	(ganadorPrimerEnfrentamiento = ganadorSegundoEnfrentamiento) ifTrue: [^ ganador _ ganadorPrimerEnfrentamiento]
					
	! !

!RondaDeTruco methodsFor: 'juego' stamp: 'ja 7/5/2021 21:18:31'!
jugarPrimerEnfrentamiento

	ganadorPrimerEnfrentamiento _ primerEnfrentamiento jugar.
					
	ganadorPrimerEnfrentamiento ifNil:[empardaron _ true]
							ifNotNil: [^ ganadorPrimerEnfrentamiento ]! !


!RondaDeTruco methodsFor: 'initialization' stamp: 'ja 7/5/2021 21:19:11'!
initializeConMano: unJugadorMano yPie: unJugadorPie 

	mano _ unJugadorMano.
	pie _ unJugadorPie.
	empardaron _ false! !


!RondaDeTruco methodsFor: 'testing' stamp: 'ja 7/5/2021 21:18:53'!
empardaronLaPrimerMano
	
	^ empardaron ! !

!RondaDeTruco methodsFor: 'testing' stamp: 'ja 7/5/2021 21:02:15'!
ganador
	
	^ganador! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RondaDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco class
	instanceVariableNames: ''!

!RondaDeTruco class methodsFor: 'assertions' stamp: 'ja 7/5/2021 21:36:14'!
verificarQueNoHayaCartasRepetidasDe: unJugadorMano en: unJugadorPie
	
	| cartasDePie |
	
	cartasDePie _ unJugadorPie cartas.
	unJugadorMano cartas do:[:unaCarta | (cartasDePie includes: unaCarta) ifTrue:[self error: self losJugadoresDeTrucoNoPuedenTenerCartasIgualesErrorDescription]].
	! !

!RondaDeTruco class methodsFor: 'assertions' stamp: 'ja 7/5/2021 21:34:34'!
verificarQueSeanJugadores: unJugadorMano y: unJugadorPie
	
	((unJugadorPie isKindOf: JugadorDeTruco) 
	and:[unJugadorMano isKindOf: JugadorDeTruco] ) ifFalse:[ self error: self jugadorInvalidoErrorDescription].
	! !


!RondaDeTruco class methodsFor: 'instance creation' stamp: 'ja 7/5/2021 21:36:27'!
conMano: unJugadorMano yPie: unJugadorPie
	
	self verificarQueSeanJugadores: unJugadorMano y: unJugadorPie.
	self verificarQueNoHayaCartasRepetidasDe: unJugadorMano en: unJugadorPie.
	
	^self new initializeConMano: unJugadorMano yPie: unJugadorPie ! !


!RondaDeTruco class methodsFor: 'error description' stamp: 'ja 7/5/2021 18:39:33'!
jugadorInvalidoErrorDescription
	
	^ 'Jugador invalido'! !

!RondaDeTruco class methodsFor: 'error description' stamp: 'ja 7/5/2021 20:43:53'!
jugadorNoPuedeEmpezarEnfrentamientoErrorDescription
	
	^  'Jugador no puede empezar enfrentamiento'! !

!RondaDeTruco class methodsFor: 'error description' stamp: 'ja 7/5/2021 18:51:44'!
losJugadoresDeTrucoNoPuedenTenerCartasIgualesErrorDescription
	
	^  'Los jugadores de truco no pueden tener cartas iguales.' ! !

!RondaDeTruco class methodsFor: 'error description' stamp: 'ja 7/5/2021 20:35:31'!
manoJuegaPrimeroErrorDescription

	^ 'Mano juega primero'! !
