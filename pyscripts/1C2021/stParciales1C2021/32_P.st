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

!RondaDeTrucoTest methodsFor: 'tests creacion' stamp: 'Ciro 7/5/2021 21:52:42'!
test01CrearRondaCon2Jugadores

	| ronda mano pie |
	
	mano _ Mano con: self buenaMano.
	pie _ Pie con: self malaMano.
	ronda _ RondaDeTruco con: mano yCon: pie.
	
	self assert: ronda mano equals: mano.
	self assert: ronda pie equals: pie! !

!RondaDeTrucoTest methodsFor: 'tests creacion' stamp: 'Ciro 7/5/2021 21:52:39'!
test02NoSePuedeCrearRondaCon2JugadoresConManoConMenosDe3Cartas

	| mano pie |
	
	mano _ Mano con: self manoIncorrecta.
	pie _ Pie con: self buenaMano.
	
	self
		should: [ RondaDeTruco con: mano yCon: pie ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RondaDeTruco jugadorNoTiene3CartasDescripcionDeError ]! !

!RondaDeTrucoTest methodsFor: 'tests creacion' stamp: 'Ciro 7/5/2021 21:52:37'!
test03NoSePuedeCrearRondaCon2JugadoresConPieConMenosDe3Cartas

	| mano pie |
	
	mano _ Mano con: self buenaMano.
	pie _ Pie con: self manoIncorrecta.
	
	self
		should: [ RondaDeTruco con: mano yCon: pie ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RondaDeTruco jugadorNoTiene3CartasDescripcionDeError ]! !


!RondaDeTrucoTest methodsFor: 'test primer enfrentamiento' stamp: 'Ciro 7/5/2021 21:52:34'!
test04SePuedeJugarElPrimerEnfrentamientoYGanaMano

	| ronda mano pie |
	
	mano _ Mano con: self buenaMano.
	pie _ Pie con: self malaMano.
	ronda _ RondaDeTruco con: mano yCon: pie.
	ronda jugarPrimerEnfrentamiento.
	
	self assert: ronda numeroDeEnfrentamiento equals: 1.
	self assert: ronda cartasJugadasPorMano size equals: 1.
	self assert: ronda cartasJugadasPorPie size equals: 1.
	self assert: ronda cartasJugadasPorMano first equals: self buenaMano first.
	self assert: ronda cartasJugadasPorPie first equals: self malaMano first.
	self assert: (ronda ganadorDelEnfrentamientoNumero: 1) equals: mano.! !

!RondaDeTrucoTest methodsFor: 'test primer enfrentamiento' stamp: 'Ciro 7/5/2021 21:52:31'!
test05SePuedeJugarElPrimerEnfrentamientoYGanaPie

	| ronda mano pie |
	
	mano _ Mano con: self malaMano.
	pie _ Pie con: self buenaMano.
	ronda _ RondaDeTruco con: mano yCon: pie.
	ronda jugarPrimerEnfrentamiento.
	
	self assert: ronda numeroDeEnfrentamiento equals: 1.
	self assert: ronda cartasJugadasPorMano size equals: 1.
	self assert: ronda cartasJugadasPorPie size equals: 1.
	self assert: ronda cartasJugadasPorMano first equals: self malaMano first.
	self assert: ronda cartasJugadasPorPie first equals: self buenaMano first.
	self assert: (ronda ganadorDelEnfrentamientoNumero: 1) equals: pie.! !

!RondaDeTrucoTest methodsFor: 'test primer enfrentamiento' stamp: 'Ciro 7/5/2021 21:52:30'!
test06SePuedeJugarElPrimerEnfrentamientoYHayParda

	| ronda mano pie |
	
	mano _ Mano con: self malaMano.
	pie _ Pie con: self malaManoPardaPeroGanaSegunda.
	ronda _ RondaDeTruco con: mano yCon: pie.
	ronda jugarPrimerEnfrentamiento.
	
	self assert: ronda numeroDeEnfrentamiento equals: 1.
	self assert: ronda cartasJugadasPorMano size equals: 1.
	self assert: ronda cartasJugadasPorPie size equals: 1.
	self assert: ronda cartasJugadasPorMano first equals: self malaMano first.
	self assert: ronda cartasJugadasPorPie first equals: self malaManoPardaPeroGanaSegunda first.
	self assert: (ronda ganadorDelEnfrentamientoNumero: 1) equals: (Enfrentamiento parda).! !


!RondaDeTrucoTest methodsFor: 'test segundo enfrentamiento' stamp: 'Ciro 7/5/2021 21:52:26'!
test07SePuedeJugarElSegundoEnfrentamientoComenzandoPorManoYGanaManoYGanaLaRonda

	| ronda mano pie |
	
	mano _ Mano con: self buenaMano.
	pie _ Pie con: self malaMano.
	ronda _ RondaDeTruco con: mano yCon: pie.
	ronda jugarPrimerEnfrentamiento.
	ronda jugarSegundoEnfrentamiento.
	
	self assert: ronda numeroDeEnfrentamiento equals: 2.
	self assert: ronda cartasJugadasPorMano size equals: 2.
	self assert: ronda cartasJugadasPorPie size equals: 2.
	self assert: ronda cartasJugadasPorMano first equals: self buenaMano first.
	self assert: ronda cartasJugadasPorMano second equals: self buenaMano second.
	self assert: ronda cartasJugadasPorPie first equals: self malaMano first.
	self assert: ronda cartasJugadasPorPie second equals: self malaMano second.
	self assert: (ronda ganadorDelEnfrentamientoNumero: 2) equals: mano.
	self assert: ronda ordenJugadoresQueComienzanElEnfrentamiento first equals: mano.
	self assert: ronda ordenJugadoresQueComienzanElEnfrentamiento second equals: mano.
	self assert: ronda ganadorDeRonda equals: mano.! !

!RondaDeTrucoTest methodsFor: 'test segundo enfrentamiento' stamp: 'Ciro 7/5/2021 21:52:24'!
test08SePuedeJugarElSegundoEnfrentamientoComenzandoPorPieYGanaPieYGanaLaRonda

	| ronda mano pie |
	
	mano _ Mano con: self malaMano.
	pie _ Pie con: self buenaMano.
	ronda _ RondaDeTruco con: mano yCon: pie.
	ronda jugarPrimerEnfrentamiento.
	ronda jugarSegundoEnfrentamiento.
	
	self assert: ronda numeroDeEnfrentamiento equals: 2.
	self assert: ronda cartasJugadasPorMano size equals: 2.
	self assert: ronda cartasJugadasPorPie size equals: 2.
	self assert: ronda cartasJugadasPorMano first equals: self malaMano first.
	self assert: ronda cartasJugadasPorMano second equals: self malaMano second.
	self assert: ronda cartasJugadasPorPie first equals: self buenaMano first.
	self assert: ronda cartasJugadasPorPie second equals: self buenaMano second.
	self assert: (ronda ganadorDelEnfrentamientoNumero: 2) equals: pie.
	self assert: ronda ordenJugadoresQueComienzanElEnfrentamiento first equals: mano.
	self assert: ronda ordenJugadoresQueComienzanElEnfrentamiento second equals: pie.
	self assert: ronda ganadorDeRonda equals: pie.! !

!RondaDeTrucoTest methodsFor: 'test segundo enfrentamiento' stamp: 'Ciro 7/5/2021 21:52:20'!
test09NoSePuedeJugarElSegundoEnfrentamientoPorqueTodaviaNoJugaronElPrimero

	| ronda mano pie |
	
	mano _ Mano con: self malaMano.
	pie _ Pie con: self buenaMano.
	ronda _ RondaDeTruco con: mano yCon: pie.
	
	self
		should: [ ronda jugarSegundoEnfrentamiento ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: ronda noSeJugoElEnfrentamientoAnteriorDescripcionDeError ]! !

!RondaDeTrucoTest methodsFor: 'test segundo enfrentamiento' stamp: 'Ciro 7/5/2021 21:52:17'!
test10SePuedeJugarElSegundoEnfrentamientoComenzandoPorPieYGanaManoYNoGanaLaRonda

	| ronda mano pie |
	
	mano _ Mano con: self buenaManoParaTercerRonda.
	pie _ Pie con: self malaManoParaTerceraRonda.
	ronda _ RondaDeTruco con: mano yCon: pie.
	ronda jugarPrimerEnfrentamiento.
	ronda jugarSegundoEnfrentamiento.
	
	self assert: ronda numeroDeEnfrentamiento equals: 2.
	self assert: ronda cartasJugadasPorMano size equals: 2.
	self assert: ronda cartasJugadasPorPie size equals: 2.
	self assert: ronda cartasJugadasPorMano first equals: self buenaManoParaTercerRonda first.
	self assert: ronda cartasJugadasPorMano second equals: self buenaManoParaTercerRonda second.
	self assert: ronda cartasJugadasPorPie first equals: self malaManoParaTerceraRonda first.
	self assert: ronda cartasJugadasPorPie second equals: self malaManoParaTerceraRonda second.
	self assert: (ronda ganadorDelEnfrentamientoNumero: 2) equals: mano.
	self assert: ronda ordenJugadoresQueComienzanElEnfrentamiento first equals: mano.
	self assert: ronda ordenJugadoresQueComienzanElEnfrentamiento second equals: pie.
	self assert: ronda ganadorDeRonda equals: RondaDeTruco sinGanador.! !

!RondaDeTrucoTest methodsFor: 'test segundo enfrentamiento' stamp: 'Ciro 7/5/2021 21:52:15'!
test11SePuedeJugarElSegundoEnfrentamientoComenzandoPorManoYGanaPieYNoGanaLaRonda

	| ronda mano pie |
	
	mano _ Mano con: self malaManoParaTerceraRonda.
	pie _ Pie con: self buenaManoParaTercerRonda.
	ronda _ RondaDeTruco con: mano yCon: pie.
	ronda jugarPrimerEnfrentamiento.
	ronda jugarSegundoEnfrentamiento.
	
	self assert: ronda numeroDeEnfrentamiento equals: 2.
	self assert: ronda cartasJugadasPorMano size equals: 2.
	self assert: ronda cartasJugadasPorPie size equals: 2.
	self assert: ronda cartasJugadasPorMano first equals: self malaManoParaTerceraRonda first.
	self assert: ronda cartasJugadasPorMano second equals: self malaManoParaTerceraRonda second.
	self assert: ronda cartasJugadasPorPie first equals: self buenaManoParaTercerRonda first.
	self assert: ronda cartasJugadasPorPie second equals: self buenaManoParaTercerRonda second.
	self assert: (ronda ganadorDelEnfrentamientoNumero: 2) equals: pie.
	self assert: ronda ordenJugadoresQueComienzanElEnfrentamiento first equals: mano.
	self assert: ronda ordenJugadoresQueComienzanElEnfrentamiento second equals: mano.
	self assert: ronda ganadorDeRonda equals: RondaDeTruco sinGanador.! !

!RondaDeTrucoTest methodsFor: 'test segundo enfrentamiento' stamp: 'Ciro 7/5/2021 21:52:12'!
test12SePuedeJugarElSegundoEnfrentamientoComenzandoPorManoYGanaManoYGanaLaRondaPorPardarLaPrimera

	| ronda mano pie |
	
	mano _ Mano con: self malaManoPardaPeroGanaSegunda .
	pie _ Pie con: self malaMano.
	ronda _ RondaDeTruco con: mano yCon: pie.
	ronda jugarPrimerEnfrentamiento.
	ronda jugarSegundoEnfrentamiento.
	
	self assert: ronda numeroDeEnfrentamiento equals: 2.
	self assert: ronda cartasJugadasPorMano size equals: 2.
	self assert: ronda cartasJugadasPorPie size equals: 2.
	self assert: ronda cartasJugadasPorMano first equals: self malaManoPardaPeroGanaSegunda first.
	self assert: ronda cartasJugadasPorMano second equals: self malaManoPardaPeroGanaSegunda second.
	self assert: ronda cartasJugadasPorPie first equals: self malaMano first.
	self assert: ronda cartasJugadasPorPie second equals: self malaMano second.
	self assert: (ronda ganadorDelEnfrentamientoNumero: 2) equals: mano.
	self assert: ronda ordenJugadoresQueComienzanElEnfrentamiento first equals: mano.
	self assert: ronda ordenJugadoresQueComienzanElEnfrentamiento second equals: mano.
	self assert: ronda ganadorDeRonda equals: mano.! !

!RondaDeTrucoTest methodsFor: 'test segundo enfrentamiento' stamp: 'Ciro 7/5/2021 21:52:10'!
test13SePuedeJugarElSegundoEnfrentamientoComenzandoPorManoYGanaPieYGanaLaRondaPorPardarLaPrimera

	| ronda mano pie |
	
	mano _ Mano con: self malaMano.
	pie _ Pie con: self malaManoPardaPeroGanaSegunda.
	ronda _ RondaDeTruco con: mano yCon: pie.
	ronda jugarPrimerEnfrentamiento.
	ronda jugarSegundoEnfrentamiento.
	
	self assert: ronda numeroDeEnfrentamiento equals: 2.
	self assert: ronda cartasJugadasPorMano size equals: 2.
	self assert: ronda cartasJugadasPorPie size equals: 2.
	self assert: ronda cartasJugadasPorMano first equals: self malaMano first.
	self assert: ronda cartasJugadasPorMano second equals: self malaMano second.
	self assert: ronda cartasJugadasPorPie first equals: self malaManoPardaPeroGanaSegunda first.
	self assert: ronda cartasJugadasPorPie second equals: self malaManoPardaPeroGanaSegunda second.
	self assert: (ronda ganadorDelEnfrentamientoNumero: 2) equals: pie.
	self assert: ronda ordenJugadoresQueComienzanElEnfrentamiento first equals: mano.
	self assert: ronda ordenJugadoresQueComienzanElEnfrentamiento second equals: mano.
	self assert: ronda ganadorDeRonda equals: pie.! !


!RondaDeTrucoTest methodsFor: 'test tercer enfrentamiento' stamp: 'Ciro 7/5/2021 21:52:07'!
test14SePuedeJugarElTercerEnfrentamientoComanzandoPorManoYGanaManoYGanaLaRonda

	| ronda mano pie |
	
	mano _ Mano con: self buenaManoParaTercerRonda .
	pie _ Pie con: self malaManoParaTerceraRonda .
	ronda _ RondaDeTruco con: mano yCon: pie.
	ronda jugarPrimerEnfrentamiento.
	ronda jugarSegundoEnfrentamiento.
	ronda jugarTercerEnfrentamiento.
	
	self assert: ronda numeroDeEnfrentamiento equals: 3.
	self assert: ronda cartasJugadasPorMano size equals: 3.
	self assert: ronda cartasJugadasPorPie size equals: 3.
	self assert: ronda cartasJugadasPorMano equals: self buenaManoParaTercerRonda.
	self assert: ronda cartasJugadasPorPie equals: self malaManoParaTerceraRonda.
	self assert: (ronda ganadorDelEnfrentamientoNumero: 3) equals: mano.
	self assert: ronda ordenJugadoresQueComienzanElEnfrentamiento first equals: mano.
	self assert: ronda ordenJugadoresQueComienzanElEnfrentamiento second equals: pie.
	self assert: ronda ordenJugadoresQueComienzanElEnfrentamiento third equals: mano.
	self assert: ronda ganadorDeRonda equals: mano.! !

!RondaDeTrucoTest methodsFor: 'test tercer enfrentamiento' stamp: 'Ciro 7/5/2021 21:52:05'!
test15SePuedeJugarElTercerEnfrentamientoComezandoPorPieYGanaPieYGanaLaRonda

	| ronda mano pie |
	
	mano _ Mano con: self malaManoParaTerceraRonda.
	pie _ Pie con: self buenaManoParaTercerRonda.
	ronda _ RondaDeTruco con: mano yCon: pie.
	ronda jugarPrimerEnfrentamiento.
	ronda jugarSegundoEnfrentamiento.
	ronda jugarTercerEnfrentamiento.
	
	self assert: ronda numeroDeEnfrentamiento equals: 3.
	self assert: ronda cartasJugadasPorMano size equals: 3.
	self assert: ronda cartasJugadasPorPie size equals: 3.
	self assert: ronda cartasJugadasPorMano equals: self malaManoParaTerceraRonda.
	self assert: ronda cartasJugadasPorPie equals: self buenaManoParaTercerRonda.
	self assert: (ronda ganadorDelEnfrentamientoNumero: 3) equals: pie.
	self assert: ronda ordenJugadoresQueComienzanElEnfrentamiento first equals: mano.
	self assert: ronda ordenJugadoresQueComienzanElEnfrentamiento second equals: mano.
	self assert: ronda ordenJugadoresQueComienzanElEnfrentamiento third equals: pie.
	self assert: ronda ganadorDeRonda equals: pie.! !

!RondaDeTrucoTest methodsFor: 'test tercer enfrentamiento' stamp: 'Ciro 7/5/2021 21:52:01'!
test16NoSePuedeJugarElTercerEnfrentamientoPorqueNoSeJugaronLosAnteriores

	| ronda mano pie |
	
	mano _ Mano con: self malaManoParaTerceraRonda.
	pie _ Pie con: self buenaManoParaTercerRonda.
	ronda _ RondaDeTruco con: mano yCon: pie.
	
	self
		should: [ ronda jugarTercerEnfrentamiento ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: ronda noSeJugoElEnfrentamientoAnteriorDescripcionDeError ]! !

!RondaDeTrucoTest methodsFor: 'test tercer enfrentamiento' stamp: 'Ciro 7/5/2021 21:51:59'!
test17NoSePuedeJugarElTercerEnfrentamientoPorqueYaHayGanador

	| ronda mano pie |
	
	mano _ Mano con: self buenaMano.
	pie _ Pie con: self malaMano.
	ronda _ RondaDeTruco con: mano yCon: pie.
	ronda jugarPrimerEnfrentamiento .
	ronda jugarSegundoEnfrentamiento .
	
	self
		should: [ ronda jugarTercerEnfrentamiento ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: ronda yaHayGanadorDescripcionDeError.
			self assert: ronda numeroDeEnfrentamiento equals: 2.
			self assert: ronda cartasJugadasPorMano size equals: 2.
			self assert: ronda cartasJugadasPorPie size equals: 2]! !

!RondaDeTrucoTest methodsFor: 'test tercer enfrentamiento' stamp: 'Ciro 7/5/2021 21:51:55'!
test18SePuedeJugarElTercerEnfrentamientoComanzandoPorPieYGanaManoYGanaLaRonda

	| ronda mano pie |
	
	mano _ Mano con: self buenaManoParaTercerRondaComenzandoPorPie .
	pie _ Pie con: self malaManoParaTerceraRondaComenzandoPorPie .
	ronda _ RondaDeTruco con: mano yCon: pie.
	ronda jugarPrimerEnfrentamiento.
	ronda jugarSegundoEnfrentamiento.
	ronda jugarTercerEnfrentamiento.
	
	self assert: ronda numeroDeEnfrentamiento equals: 3.
	self assert: ronda cartasJugadasPorMano size equals: 3.
	self assert: ronda cartasJugadasPorPie size equals: 3.
	self assert: ronda cartasJugadasPorMano equals: self buenaManoParaTercerRondaComenzandoPorPie.
	self assert: ronda cartasJugadasPorPie equals: self malaManoParaTerceraRondaComenzandoPorPie.
	self assert: (ronda ganadorDelEnfrentamientoNumero: 3) equals: mano.
	self assert: ronda ordenJugadoresQueComienzanElEnfrentamiento first equals: mano.
	self assert: ronda ordenJugadoresQueComienzanElEnfrentamiento second equals: mano.
	self assert: ronda ordenJugadoresQueComienzanElEnfrentamiento third equals: pie.
	self assert: ronda ganadorDeRonda equals: mano.! !

!RondaDeTrucoTest methodsFor: 'test tercer enfrentamiento' stamp: 'Ciro 7/5/2021 21:51:52'!
test19SePuedeJugarElTercerEnfrentamientoComezandoPorManoYGanaPieYGanaLaRonda

	| ronda mano pie |
	
	mano _ Mano con: self malaManoParaTerceraRondaComenzandoPorPie.
	pie _ Pie con: self buenaManoParaTercerRondaComenzandoPorPie.
	ronda _ RondaDeTruco con: mano yCon: pie.
	ronda jugarPrimerEnfrentamiento.
	ronda jugarSegundoEnfrentamiento.
	ronda jugarTercerEnfrentamiento.
	
	self assert: ronda numeroDeEnfrentamiento equals: 3.
	self assert: ronda cartasJugadasPorMano size equals: 3.
	self assert: ronda cartasJugadasPorPie size equals: 3.
	self assert: ronda cartasJugadasPorMano equals: self malaManoParaTerceraRondaComenzandoPorPie.
	self assert: ronda cartasJugadasPorPie equals: self buenaManoParaTercerRondaComenzandoPorPie.
	self assert: (ronda ganadorDelEnfrentamientoNumero: 3) equals: pie.
	self assert: ronda ordenJugadoresQueComienzanElEnfrentamiento first equals: mano.
	self assert: ronda ordenJugadoresQueComienzanElEnfrentamiento second equals: pie.
	self assert: ronda ordenJugadoresQueComienzanElEnfrentamiento third equals: mano.
	self assert: ronda ganadorDeRonda equals: pie.! !


!RondaDeTrucoTest methodsFor: 'objectos para test' stamp: 'Ciro 7/5/2021 17:39:14'!
buenaMano

	^ OrderedCollection 
		with: (CartaDeTruco palo: (CartaDeTruco espada) numero: 1)
		with: (CartaDeTruco palo: (CartaDeTruco basto ) numero: 1)
		with: (CartaDeTruco palo: (CartaDeTruco espada) numero: 7)! !

!RondaDeTrucoTest methodsFor: 'objectos para test' stamp: 'Ciro 7/5/2021 20:26:00'!
buenaManoParaTercerRonda

	^ OrderedCollection 
		with: (CartaDeTruco palo: (CartaDeTruco basto) numero: 4)
		with: (CartaDeTruco palo: (CartaDeTruco espada ) numero: 1)
		with: (CartaDeTruco palo: (CartaDeTruco basto) numero: 1)! !

!RondaDeTrucoTest methodsFor: 'objectos para test' stamp: 'Ciro 7/5/2021 20:25:46'!
buenaManoParaTercerRondaComenzandoPorPie

	^ OrderedCollection 
		with: (CartaDeTruco palo: (CartaDeTruco espada) numero: 1)
		with: (CartaDeTruco palo: (CartaDeTruco basto ) numero: 4)
		with: (CartaDeTruco palo: (CartaDeTruco basto) numero: 1)! !

!RondaDeTrucoTest methodsFor: 'objectos para test' stamp: 'Ciro 7/5/2021 18:43:46'!
malaMano

	^ OrderedCollection 
		with: (CartaDeTruco palo: (CartaDeTruco espada) numero: 4)
		with: (CartaDeTruco palo: (CartaDeTruco basto ) numero: 4)
		with: (CartaDeTruco palo: (CartaDeTruco espada) numero: 5)! !

!RondaDeTrucoTest methodsFor: 'objectos para test' stamp: 'Ciro 7/5/2021 19:29:11'!
malaManoParaTerceraRonda

	^ OrderedCollection 
		with: (CartaDeTruco palo: (CartaDeTruco espada) numero: 7)
		with: (CartaDeTruco palo: (CartaDeTruco copa ) numero: 4)
		with: (CartaDeTruco palo: (CartaDeTruco oro) numero: 4)! !

!RondaDeTrucoTest methodsFor: 'objectos para test' stamp: 'Ciro 7/5/2021 20:26:33'!
malaManoParaTerceraRondaComenzandoPorPie

	^ OrderedCollection 
		with: (CartaDeTruco palo: (CartaDeTruco copa) numero: 4)
		with: (CartaDeTruco palo: (CartaDeTruco espada ) numero: 7)
		with: (CartaDeTruco palo: (CartaDeTruco oro) numero: 4)! !

!RondaDeTrucoTest methodsFor: 'objectos para test' stamp: 'Ciro 7/5/2021 19:31:17'!
malaManoPardaPeroGanaSegunda

	^ OrderedCollection 
		with: (CartaDeTruco palo: (CartaDeTruco copa) numero: 4)
		with: (CartaDeTruco palo: (CartaDeTruco espada ) numero: 1)
		with: (CartaDeTruco palo: (CartaDeTruco basto) numero: 1)! !

!RondaDeTrucoTest methodsFor: 'objectos para test' stamp: 'Ciro 7/5/2021 17:42:04'!
manoIncorrecta

	^ OrderedCollection 
		with: (CartaDeTruco palo: (CartaDeTruco espada) numero: 4)
		with: (CartaDeTruco palo: (CartaDeTruco basto ) numero: 4)! !


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
	instanceVariableNames: 'jugadorInicial jugadorSiguiente numeroDeEnfrentamiento ganador'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Enfrentamiento methodsFor: 'inicializacion' stamp: 'Ciro 7/5/2021 18:10:51'!
inicializarSiendoElNumero: unNumero con: unJugador yCon: otroJugador

	numeroDeEnfrentamiento _ unNumero.
	jugadorInicial  _ unJugador.
	jugadorSiguiente  _ otroJugador! !


!Enfrentamiento methodsFor: 'contenido' stamp: 'Ciro 7/5/2021 21:22:42'!
ganador

	^ ganador
	! !

!Enfrentamiento methodsFor: 'contenido' stamp: 'Ciro 7/5/2021 21:17:30'!
huboParda

	^ ganador = Enfrentamiento parda
	! !

!Enfrentamiento methodsFor: 'contenido' stamp: 'Ciro 7/5/2021 20:10:50'!
jugadorInicial

	^ jugadorInicial
	! !


!Enfrentamiento methodsFor: 'privado' stamp: 'Ciro 7/5/2021 21:37:20'!
determinarGanadorSiLoHayEntre: cartaJugadorInicial y: cartaJugadorSiguiente

	(cartaJugadorInicial empardaCon: cartaJugadorSiguiente) ifTrue: [^ Enfrentamiento parda].
	(cartaJugadorInicial mataA: cartaJugadorSiguiente) ifTrue: [
			jugadorInicial aumentarContadorEnfrentamientos.
			^ jugadorInicial]
		ifFalse: [
			jugadorSiguiente aumentarContadorEnfrentamientos.
			^ jugadorSiguiente].
	! !


!Enfrentamiento methodsFor: 'jugar' stamp: 'Ciro 7/5/2021 21:53:30'!
jugar

	ganador _ self determinarGanadorSiLoHayEntre: 	(jugadorInicial cartaNumero: numeroDeEnfrentamiento) 
		y: (jugadorSiguiente cartaNumero: numeroDeEnfrentamiento).
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Enfrentamiento class' category: 'ISW1-2021-1C-2doParcial'!
Enfrentamiento class
	instanceVariableNames: ''!

!Enfrentamiento class methodsFor: 'creacion de instancia' stamp: 'Ciro 7/5/2021 18:10:19'!
numero: unNumero con: unJugador yCon: otroJugador

	^ self new inicializarSiendoElNumero: unNumero con: unJugador yCon: otroJugador! !


!Enfrentamiento class methodsFor: 'mensajes' stamp: 'Ciro 7/5/2021 18:36:36'!
parda

	^ 'parda'! !


!classDefinition: #Jugador category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #Jugador
	instanceVariableNames: 'cartas enfrentamientosGanados'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Jugador methodsFor: 'inicializacion' stamp: 'Ciro 7/5/2021 21:35:40'!
inicializarCon: unaColecionDeCartas
	
	cartas _ unaColecionDeCartas.
	enfrentamientosGanados _ 0! !


!Jugador methodsFor: 'cartas' stamp: 'Ciro 7/5/2021 21:37:00'!
aumentarContadorEnfrentamientos

	enfrentamientosGanados _ enfrentamientosGanados + 1! !

!Jugador methodsFor: 'cartas' stamp: 'Ciro 7/5/2021 18:22:05'!
cantidadDeCartasJugadas: unNumero

	| cartasJugadas |
	
	cartasJugadas _ OrderedCollection new.
	cartasJugadas _ cartas copyFrom: 1 to: unNumero.
	^ cartasJugadas. 
	
	! !

!Jugador methodsFor: 'cartas' stamp: 'Ciro 7/5/2021 18:31:34'!
cartaNumero: unNumero

	^ cartas at: unNumero.
	
	! !

!Jugador methodsFor: 'cartas' stamp: 'Ciro 7/5/2021 17:57:02'!
tiene3Cartas

	^ cartas size = 3! !

!Jugador methodsFor: 'cartas' stamp: 'Ciro 7/5/2021 21:50:18'!
yaGano

	^ enfrentamientosGanados = 2.
	
	! !


!Jugador methodsFor: 'enfrentamiento' stamp: 'Ciro 7/5/2021 20:57:18'!
comenzaElSiguienteEnfrentamientoDe: unaRonda

	self subclassResponsibility 
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Jugador class' category: 'ISW1-2021-1C-2doParcial'!
Jugador class
	instanceVariableNames: ''!

!Jugador class methodsFor: 'creacion de intancia' stamp: 'Ciro 7/5/2021 17:40:50'!
con: unaColeccionDeCartas
	
	^ self new inicializarCon: unaColeccionDeCartas! !


!classDefinition: #Mano category: 'ISW1-2021-1C-2doParcial'!
Jugador subclass: #Mano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Mano methodsFor: 'enfrentamiento' stamp: 'Ciro 7/5/2021 20:57:53'!
comenzaElSiguienteEnfrentamientoDe: unaRonda

	unaRonda jugarEnfrentamientoEmpezandoPorMano 
	! !


!classDefinition: #Pie category: 'ISW1-2021-1C-2doParcial'!
Jugador subclass: #Pie
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Pie methodsFor: 'enfrentamiento' stamp: 'Ciro 7/5/2021 20:58:00'!
comenzaElSiguienteEnfrentamientoDe: unaRonda

	unaRonda jugarEnfrentamientoEmpezandoPorPie! !


!classDefinition: #RondaDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #RondaDeTruco
	instanceVariableNames: 'mano pie numeroDeEnfrentamientos enfrentamientos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTruco methodsFor: 'jugar' stamp: 'Ciro 7/5/2021 21:02:30'!
jugarEnfrentamiento

	| ganador |
	
	ganador _ (enfrentamientos at: numeroDeEnfrentamientos) ganador.
	ganador = (Enfrentamiento parda) ifTrue: [^ self jugarEnfrentamientoEmpezandoPorMano ].
	
	ganador comenzaElSiguienteEnfrentamientoDe: self

	! !

!RondaDeTruco methodsFor: 'jugar' stamp: 'Ciro 7/5/2021 20:51:23'!
jugarEnfrentamientoEmpezandoPorMano

	| enfrentamiento |
	
	numeroDeEnfrentamientos _ numeroDeEnfrentamientos + 1.
	enfrentamiento _ Enfrentamiento numero: numeroDeEnfrentamientos con: mano yCon: pie.
	enfrentamientos add: (enfrentamiento jugar)

	! !

!RondaDeTruco methodsFor: 'jugar' stamp: 'Ciro 7/5/2021 20:51:26'!
jugarEnfrentamientoEmpezandoPorPie

	| enfrentamiento |
	
	numeroDeEnfrentamientos _ numeroDeEnfrentamientos + 1.
	enfrentamiento _ Enfrentamiento numero: numeroDeEnfrentamientos con: pie yCon: mano.
	enfrentamientos add: (enfrentamiento jugar)

	! !

!RondaDeTruco methodsFor: 'jugar' stamp: 'Ciro 7/5/2021 19:59:48'!
jugarPrimerEnfrentamiento

	self jugarEnfrentamientoEmpezandoPorMano

	! !

!RondaDeTruco methodsFor: 'jugar' stamp: 'Ciro 7/5/2021 19:53:13'!
jugarSegundoEnfrentamiento

	self verificarQueSeJugoEnfrentamientoAnterior: 2.
	
	self jugarEnfrentamiento ! !

!RondaDeTruco methodsFor: 'jugar' stamp: 'Ciro 7/5/2021 19:53:19'!
jugarTercerEnfrentamiento

	self verificarQueSeJugoEnfrentamientoAnterior: 3.
	
	self verificarQueNoHayaGanador.
	
	self jugarEnfrentamiento ! !


!RondaDeTruco methodsFor: 'para test' stamp: 'Ciro 7/5/2021 20:05:39'!
cartasJugadasPorMano

	^ mano cantidadDeCartasJugadas: numeroDeEnfrentamientos! !

!RondaDeTruco methodsFor: 'para test' stamp: 'Ciro 7/5/2021 20:05:39'!
cartasJugadasPorPie
	
	^ pie cantidadDeCartasJugadas: numeroDeEnfrentamientos! !

!RondaDeTruco methodsFor: 'para test' stamp: 'Ciro 7/5/2021 21:50:01'!
ganadorDeRonda

	| retorno ultimoGanador  |
	
	retorno _ self verificarSiHuboParda.
	
	ultimoGanador _ (enfrentamientos at: numeroDeEnfrentamientos) ganador.
	
	ultimoGanador yaGano ifTrue: [ retorno _ ultimoGanador ].
	
	^ retorno
	
	
	
	! !

!RondaDeTruco methodsFor: 'para test' stamp: 'Ciro 7/5/2021 18:26:36'!
ganadorDelEnfrentamientoNumero: unNumero

	^ (enfrentamientos at: unNumero) ganador
	
	! !

!RondaDeTruco methodsFor: 'para test' stamp: 'Ciro 7/5/2021 17:34:56'!
mano

	^ mano! !

!RondaDeTruco methodsFor: 'para test' stamp: 'Ciro 7/5/2021 20:05:39'!
numeroDeEnfrentamiento
	
	^ numeroDeEnfrentamientos! !

!RondaDeTruco methodsFor: 'para test' stamp: 'Ciro 7/5/2021 20:11:14'!
ordenJugadoresQueComienzanElEnfrentamiento

	| jugadores |
	
	jugadores _ OrderedCollection new.
	
	enfrentamientos do: [ :unEnfrentamiento | jugadores add: (unEnfrentamiento jugadorInicial)].
	
	^ jugadores ! !

!RondaDeTruco methodsFor: 'para test' stamp: 'Ciro 7/5/2021 17:34:59'!
pie

	^ pie! !


!RondaDeTruco methodsFor: 'privado' stamp: 'Ciro 7/5/2021 19:38:48'!
hayGanadorPorParda: unJugador

	^ unJugador
	
	! !


!RondaDeTruco methodsFor: 'verificacion' stamp: 'Ciro 7/5/2021 19:49:29'!
verificarQueNoHayaGanador

	self ganadorDeRonda = RondaDeTruco sinGanador ifFalse: [ self yaHayGanadorAviso ].! !

!RondaDeTruco methodsFor: 'verificacion' stamp: 'Ciro 7/5/2021 20:05:39'!
verificarQueSeJugoEnfrentamientoAnterior: numeroDeEnfrentamientoAJugar

	(numeroDeEnfrentamientos +1) < numeroDeEnfrentamientoAJugar ifTrue: [ self noSeJugoEnfrentamientoAnteriorAviso].! !

!RondaDeTruco methodsFor: 'verificacion' stamp: 'Ciro 7/5/2021 21:47:37'!
verificarSiHuboParda

	(enfrentamientos at: 1) huboParda ifTrue: [ ^ ((enfrentamientos at: 2) ganador ) ]
		ifFalse: [^ RondaDeTruco sinGanador ]
	
	! !


!RondaDeTruco methodsFor: 'avisos' stamp: 'Ciro 7/5/2021 18:57:37'!
noSeJugoEnfrentamientoAnteriorAviso

	self error: self noSeJugoElEnfrentamientoAnteriorDescripcionDeError! !

!RondaDeTruco methodsFor: 'avisos' stamp: 'Ciro 7/5/2021 19:49:44'!
yaHayGanadorAviso

	self error: self yaHayGanadorDescripcionDeError! !


!RondaDeTruco methodsFor: 'descripciones de errores' stamp: 'Ciro 7/5/2021 18:57:57'!
noSeJugoElEnfrentamientoAnteriorDescripcionDeError

	^ 'No se jugo el enfrentamiento anterior'! !

!RondaDeTruco methodsFor: 'descripciones de errores' stamp: 'Ciro 7/5/2021 19:50:03'!
yaHayGanadorDescripcionDeError

	^ 'Ya hay ganador'! !


!RondaDeTruco methodsFor: 'inicializacion' stamp: 'Ciro 7/5/2021 20:05:40'!
inicializarCon: unJugador yCon: otroJugador
	
	mano _ unJugador.
	pie _ otroJugador.
	numeroDeEnfrentamientos _ 0.
	enfrentamientos _ OrderedCollection new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RondaDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco class
	instanceVariableNames: ''!

!RondaDeTruco class methodsFor: 'creacion de instancia' stamp: 'Ciro 7/5/2021 17:51:01'!
con: unJugador yCon: otroJugador

	self verificarTienen3Cartas: unJugador y: otroJugador.

	^ self new inicializarCon: unJugador yCon: otroJugador! !


!RondaDeTruco class methodsFor: 'mensajes' stamp: 'Ciro 7/5/2021 19:06:56'!
sinGanador

	^ 'Sin ganador'! !


!RondaDeTruco class methodsFor: 'verificacion' stamp: 'Ciro 7/5/2021 17:54:52'!
verificarTiene3Cartas: unJugador

	unJugador tiene3Cartas ifFalse: [self jugadorNotiene3CartasAviso ]! !

!RondaDeTruco class methodsFor: 'verificacion' stamp: 'Ciro 7/5/2021 17:51:41'!
verificarTienen3Cartas: unJugador y: otroJugador

	self verificarTiene3Cartas: unJugador.
	self verificarTiene3Cartas: otroJugador.! !


!RondaDeTruco class methodsFor: 'descripcion de error' stamp: 'Ciro 7/5/2021 17:55:46'!
jugadorNoTiene3CartasDescripcionDeError

	^ 'Jugador no tiene 3 cartas'! !


!RondaDeTruco class methodsFor: 'avisos' stamp: 'Ciro 7/5/2021 17:55:01'!
jugadorNotiene3CartasAviso

	self error: self jugadorNoTiene3CartasDescripcionDeError! !
