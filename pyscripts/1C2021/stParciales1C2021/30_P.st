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


!classDefinition: #RondaTest category: 'ISW1-2021-1C-2doParcial'!
TestCase subclass: #RondaTest
	instanceVariableNames: 'cuatroDeOro sieteDeOro anchoDeBasto tresDeBasto anchoDeEspada anchoDeOro cuatroDeBasto'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaTest methodsFor: 'soporte' stamp: 'UC 7/5/2021 18:03:37'!
crearJugadorCon: carta1 con: carta2 con: carta3

	^ Set with: carta1 with: carta2 with: carta3! !

!RondaTest methodsFor: 'soporte' stamp: 'UC 7/5/2021 20:31:52'!
setUp
	cuatroDeOro := (CartaDeTruco oroCon: 4).
	cuatroDeBasto := (CartaDeTruco bastoCon: 4).
	sieteDeOro := CartaDeTruco sieteDeOro.
	anchoDeBasto := CartaDeTruco anchoDeBasto.
	tresDeBasto := (CartaDeTruco bastoCon: 3).
	anchoDeEspada := CartaDeTruco anchoDeEspada.
	anchoDeOro := (CartaDeTruco oroCon: 1).! !


!RondaTest methodsFor: 'tests' stamp: 'UC 7/5/2021 18:33:10'!
test01CuandoUnJugadorTieneMenosDe3CartasDaError
	| sinCartas con3Cartas |
	sinCartas := Set new.
	con3Cartas := self crearJugadorCon: CartaDeTruco anchoDeBasto con: CartaDeTruco anchoDeEspada  con: CartaDeTruco sieteDeEspada.
	
	self should: [Ronda mano: sinCartas pie: con3Cartas. ]
		raise: Error
		withExceptionDo: [:error | self assert: Ronda ambosJugadoresDebenTenerTresCartas equals: error messageText ].
	
	 self should: [Ronda mano: con3Cartas pie: sinCartas. ]
		raise: Error
		withExceptionDo: [:error | self assert: Ronda ambosJugadoresDebenTenerTresCartas equals: error messageText ]
	
	 
	
	! !

!RondaTest methodsFor: 'tests' stamp: 'UC 7/5/2021 18:56:38'!
test02CuandoLasCartasSeRepitenEntreLosJugadoresDaError
	| mano pie |
	
	pie := self crearJugadorCon: anchoDeBasto con: anchoDeOro con: cuatroDeOro .
	
	mano := self crearJugadorCon: anchoDeBasto con: tresDeBasto con: anchoDeEspada.
	
	self should: [Ronda mano: mano pie: pie.]
		raise: Error
		withExceptionDo: [:error | self assert: Ronda esasCartasNoPudieronVenirDeUnSoloMazo equals: error messageText ]
	
	 
	! !

!RondaTest methodsFor: 'tests' stamp: 'UC 7/5/2021 19:06:59'!
test03CuandoLaRondaEmpiezaLeTocaALaMano
	| mano pie ronda |
	
	pie := self crearJugadorCon: anchoDeBasto con: anchoDeOro con: cuatroDeOro.
	
	mano := self crearJugadorCon: sieteDeOro con: tresDeBasto con: anchoDeEspada.
	
	ronda := Ronda mano: mano pie: pie.
	
	self assert: ronda leTocaALaMano.
	self assert: ronda cartasDeLaMano equals: mano.
	self assert: ronda cartasDelPie equals: pie.
	
	! !

!RondaTest methodsFor: 'tests' stamp: 'UC 7/5/2021 18:58:18'!
test04CuandoElPieJuegaEnElPrimerTurnoDaError
	| mano pie ronda |
	
	pie := self crearJugadorCon: anchoDeBasto con: anchoDeOro con: cuatroDeOro.
	
	mano := self crearJugadorCon: sieteDeOro con: tresDeBasto con: anchoDeEspada.
	
	ronda := Ronda mano: mano pie: pie.
	self should: [ronda pieJuega: anchoDeBasto.]
		raise: Error
		withExceptionDo:[:error | self assert: Ronda errorLeTocaAlOponente equals: error messageText ]
	 
	! !

!RondaTest methodsFor: 'tests' stamp: 'UC 7/5/2021 18:58:22'!
test05CuandoLaManoJuegaUnaCartaQueNoTieneDaError
	| mano pie ronda |
	
	pie := self crearJugadorCon: anchoDeBasto con: anchoDeOro con: cuatroDeOro.
	
	mano := self crearJugadorCon: sieteDeOro con: tresDeBasto con: anchoDeEspada.
	
	ronda := Ronda mano: mano pie: pie.
	self should: [ronda manoJuega: anchoDeBasto.]
		raise: Error
		withExceptionDo:[:error | self assert: Ronda noTenesEsaCarta equals: error messageText ]
	! !

!RondaTest methodsFor: 'tests' stamp: 'UC 7/5/2021 19:08:58'!
test06CuandoLaManoJuegaUnaCartaLeTocaAlPieYLaManoPierdeLaCartaJugada
	| mano pie ronda |
	
	pie := self crearJugadorCon: anchoDeBasto con: anchoDeOro con: cuatroDeOro.
	
	mano := self crearJugadorCon: sieteDeOro con: tresDeBasto con: anchoDeEspada.
	
	ronda := Ronda mano: mano pie: pie.
	ronda manoJuega: sieteDeOro.
	
	self deny: ronda leTocaALaMano.
	self deny: (ronda cartasDeLaMano includes: CartaDeTruco sieteDeOro).
	! !

!RondaTest methodsFor: 'tests' stamp: 'UC 7/5/2021 18:58:31'!
test07CuandoLaManoJuegaLosDosPrimerosTurnosDaError
	| mano pie ronda |
	
	pie := self crearJugadorCon: anchoDeBasto con: anchoDeOro con: cuatroDeOro.
	
	mano := self crearJugadorCon: sieteDeOro con: tresDeBasto con: anchoDeEspada.
	
	ronda := Ronda mano: mano pie: pie.
	ronda manoJuega: sieteDeOro.
	
	self should: [ronda manoJuega: CartaDeTruco anchoDeEspada] 
		raise: Error
		withExceptionDo: [:error | self assert: Ronda errorLeTocaAlOponente equals: error messageText ]
	! !

!RondaTest methodsFor: 'tests' stamp: 'UC 7/5/2021 19:08:50'!
test08CuandoElPiePierdePrimeraLeTocaALaManoYElPiePierdeLaCartaJugada
	| mano pie ronda |
	
	pie := self crearJugadorCon: anchoDeBasto con: anchoDeOro con: cuatroDeOro.
	
	mano := self crearJugadorCon: sieteDeOro con: tresDeBasto con: anchoDeEspada.
	
	ronda := Ronda mano: mano pie: pie.
	ronda manoJuega: sieteDeOro.
	ronda pieJuega: cuatroDeOro.
	
	self deny: (ronda cartasDelPie includes: cuatroDeOro).
	self assert: ronda leTocaALaMano.
	self should: [ronda pieJuega: anchoDeOro.] 
		raise: Error
		withExceptionDo: [:error | self assert: Ronda errorLeTocaAlOponente equals: error messageText ].! !

!RondaTest methodsFor: 'tests' stamp: 'UC 7/5/2021 19:10:25'!
test09CuandoElPieJuegaUnaCartaQueNoTieneDaError
	| mano pie ronda |
	
	pie := self crearJugadorCon: anchoDeBasto con: anchoDeOro con: cuatroDeOro.
	
	mano := self crearJugadorCon: sieteDeOro con: tresDeBasto con: anchoDeEspada.
	
	ronda := Ronda mano: mano pie: pie.
	ronda manoJuega: sieteDeOro.
	
	self should: [ronda pieJuega: sieteDeOro.] 
		raise: Error
		withExceptionDo: [:error | self assert: Ronda noTenesEsaCarta equals: error messageText ].! !

!RondaTest methodsFor: 'tests' stamp: 'UC 7/5/2021 19:35:58'!
test10CuandoGanaElPieLeTocaAlPie
	| mano pie ronda |
	
	pie := self crearJugadorCon: anchoDeBasto con: anchoDeOro con: cuatroDeOro.
	
	mano := self crearJugadorCon: sieteDeOro con: tresDeBasto con: anchoDeEspada.
	
	ronda := Ronda mano: mano pie: pie.
	ronda manoJuega: tresDeBasto.
	ronda pieJuega: anchoDeBasto.
	
	self deny: ronda leTocaALaMano.
	
	"Aca no puedo testear que la mano gane porque eso pasaria de una (al menos en mi implementacion acutal) . Eso lo voy a testear en la segunda mano"! !

!RondaTest methodsFor: 'tests' stamp: 'UC 7/5/2021 19:40:38'!
test11CuandoElPieGanaLaPrimeraYElPieJuegaLeTocaALaMano
	| mano pie ronda |
	
	pie := self crearJugadorCon: anchoDeBasto con: anchoDeOro con: tresDeBasto.
	
	mano := self crearJugadorCon: sieteDeOro con: cuatroDeOro con: anchoDeEspada.
	
	ronda := Ronda mano: mano pie: pie.
	ronda manoJuega: cuatroDeOro.
	ronda pieJuega: anchoDeBasto.
	ronda pieJuega: anchoDeOro.
	
	self assert: ronda leTocaALaMano.! !

!RondaTest methodsFor: 'tests' stamp: 'UC 7/5/2021 20:18:51'!
test12CuandoElPieGanaLaPrimeraYLaManoGanaLaSegundaLeTocaALaMano
	| mano pie ronda |
	
	pie := self crearJugadorCon: anchoDeBasto con: anchoDeOro con: tresDeBasto.
	
	mano := self crearJugadorCon: sieteDeOro con: cuatroDeOro con: anchoDeEspada.
	
	ronda := Ronda mano: mano pie: pie.
	ronda manoJuega: cuatroDeOro.
	ronda pieJuega: tresDeBasto.
	ronda pieJuega: anchoDeOro.
	ronda manoJuega: sieteDeOro.
	
	self assert: ronda leTocaALaMano.! !

!RondaTest methodsFor: 'tests' stamp: 'UC 7/5/2021 20:26:51'!
test13CuandoElPieGanaLaPrimeraLaManoGanaLaSegundaYLaManoJuegaLeTocaAlPie
	| mano pie ronda |
	
	pie := self crearJugadorCon: anchoDeBasto con: anchoDeOro con: tresDeBasto.
	
	mano := self crearJugadorCon: sieteDeOro con: cuatroDeOro con: anchoDeEspada.
	
	ronda := Ronda mano: mano pie: pie.
	
	ronda manoJuega: cuatroDeOro.
	ronda pieJuega: anchoDeOro.
	
	ronda pieJuega: tresDeBasto.
	ronda manoJuega: sieteDeOro.
	
	ronda manoJuega: anchoDeEspada.
	
	
	self deny: ronda leTocaALaMano.! !

!RondaTest methodsFor: 'tests' stamp: 'UC 7/5/2021 20:32:48'!
test14CuandoElPieEmpardaConLaManoLeTocaALaMano
	| mano pie ronda |
	
	pie := self crearJugadorCon: anchoDeBasto con: cuatroDeBasto con: tresDeBasto.
	
	mano := self crearJugadorCon: sieteDeOro con: cuatroDeOro con: anchoDeEspada.
	
	ronda := Ronda mano: mano pie: pie.
	
	ronda manoJuega: cuatroDeOro.
	ronda pieJuega: cuatroDeBasto.
	
	self assert: ronda leTocaALaMano.! !

!RondaTest methodsFor: 'tests' stamp: 'UC 7/5/2021 21:23:12'!
test15CuandoLaManoGanaDosEnfrentamientosLaManoGanaLaRondaYNoSePuedeSeguirJugando
	| mano pie ronda |
	
	pie := self crearJugadorCon: anchoDeBasto con: cuatroDeBasto con: tresDeBasto.
	
	mano := self crearJugadorCon: sieteDeOro con: cuatroDeOro con: anchoDeEspada.
	
	ronda := Ronda mano: mano pie: pie.
	
	ronda manoJuega: sieteDeOro.
	ronda pieJuega: cuatroDeBasto.
	
	ronda manoJuega: anchoDeEspada.
	ronda pieJuega: anchoDeBasto.
	
	
	self assert: ronda termino.
	self assert: ronda ganoLaMano.
	self deny: ronda ganoElPie.
	self should: [ronda manoJuega: cuatroDeOro] 
		raise: Error 
		withExceptionDo: [:error | 
			self assert: Ronda noSePuedeJugarPorquelaPartidaYaTermino equals: error messageText.
			self assert: ronda cartasDeLaMano includes: cuatroDeOro.
		]! !

!RondaTest methodsFor: 'tests' stamp: 'UC 7/5/2021 21:28:31'!
test16CuandoElPieGanaDosEnfrentamientoElPieGanaLaRonda
	| mano pie ronda |
	
	pie := self crearJugadorCon: anchoDeBasto con: cuatroDeBasto con: anchoDeEspada.
	
	mano := self crearJugadorCon: sieteDeOro con: cuatroDeOro con: tresDeBasto .
	
	ronda := Ronda mano: mano pie: pie.
	
	ronda manoJuega: sieteDeOro.
	ronda pieJuega: cuatroDeBasto.
	
	ronda manoJuega: cuatroDeOro.
	ronda pieJuega: anchoDeBasto.
	
	ronda pieJuega: anchoDeEspada.
	ronda manoJuega: tresDeBasto.
	
	
	self assert: ronda termino.
	self deny: ronda ganoLaMano.
	self assert: ronda ganoElPie.
	
	
	"En este caso puedo testear que no se pueda seguir jugando pero igual fallar�a ya que no est� permitido tener m�s de 3 cartas y los jugadores ya jugaron todas sus cartas. De todos modos el assert de que termin� la partida est� primero y salta eso."
	self should: [ronda pieJuega: cuatroDeOro] 
		raise: Error 
		withExceptionDo: [:error | 
			self assert: Ronda noSePuedeJugarPorquelaPartidaYaTermino equals: error messageText.
		]
	! !

!RondaTest methodsFor: 'tests' stamp: 'UC 7/5/2021 21:31:24'!
test17CuandoHayPardaEnLaPrimeraElQueGanaLaSegundaGana
	| mano pie ronda |
	
	pie := self crearJugadorCon: tresDeBasto con: cuatroDeBasto con: anchoDeEspada.
	
	mano := self crearJugadorCon: sieteDeOro con: cuatroDeOro con: anchoDeBasto .
	
	ronda := Ronda mano: mano pie: pie.
	
	ronda manoJuega: cuatroDeOro.
	ronda pieJuega: cuatroDeBasto.
	
	ronda manoJuega: sieteDeOro.
	ronda pieJuega: tresDeBasto.
	
	
	self assert: ronda termino.
	self assert: ronda ganoLaMano.
	self deny: ronda ganoElPie.
	
	
	"En este caso puedo testear que no se pueda seguir jugando pero igual fallar�a ya que no est� permitido tener m�s de 3 cartas y los jugadores ya jugaron todas sus cartas. De todos modos el assert de que termin� la partida est� primero y salta eso."
	self should: [ronda pieJuega: cuatroDeOro] 
		raise: Error 
		withExceptionDo: [:error | 
			self assert: Ronda noSePuedeJugarPorquelaPartidaYaTermino equals: error messageText.
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


!classDefinition: #Ronda category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #Ronda
	instanceVariableNames: 'cartasMano cartasPie leTocaALaMano cartaQueJugoElOponente elOponenteJugoEstaRonda enfrentamientosGanadosPorLaMano enfrentamientosGanadosPorElPie'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Ronda methodsFor: 'informe de estado' stamp: 'UC 7/5/2021 18:45:16'!
cartasDeLaMano
	^cartasMano ! !

!Ronda methodsFor: 'informe de estado' stamp: 'UC 7/5/2021 18:45:26'!
cartasDelPie
	^cartasPie! !

!Ronda methodsFor: 'informe de estado' stamp: 'UC 7/5/2021 21:15:36'!
ganoElPie

	^ enfrentamientosGanadosPorElPie = 2! !

!Ronda methodsFor: 'informe de estado' stamp: 'UC 7/5/2021 21:15:30'!
ganoLaMano

	^ enfrentamientosGanadosPorLaMano = 2! !

!Ronda methodsFor: 'informe de estado' stamp: 'UC 7/5/2021 18:40:14'!
leTocaALaMano
	^leTocaALaMano! !

!Ronda methodsFor: 'informe de estado' stamp: 'UC 7/5/2021 21:15:36'!
termino
	^self ganoLaMano or: self ganoElPie! !


!Ronda methodsFor: 'informe de estado - privado' stamp: 'UC 7/5/2021 21:35:45'!
enfrentamientosJugados
	^enfrentamientosGanadosPorLaMano + enfrentamientosGanadosPorElPie ! !


!Ronda methodsFor: 'validaciones' stamp: 'UC 7/5/2021 19:52:36'!
jugar: unaCarta siLaTengoEn: misCartas.
	(misCartas includes: unaCarta) ifFalse: [self error: self class noTenesEsaCarta.].
	misCartas remove: unaCarta.
	! !

!Ronda methodsFor: 'validaciones' stamp: 'UC 7/5/2021 20:42:52'!
verificarQueMeToque: meToca
	meToca ifFalse: [self error: self class errorLeTocaAlOponente.]! !

!Ronda methodsFor: 'validaciones' stamp: 'UC 7/5/2021 21:13:22'!
verificarQueNoHayaTerminadoLaRonda

	^ self termino ifTrue: [self error: self class noSePuedeJugarPorquelaPartidaYaTermino]! !


!Ronda methodsFor: 'manejo del estado - privado' stamp: 'UC 7/5/2021 21:36:35'!
actualizarLosContadoresCuando: ganoElEnfrentamientoLaMano y: huboParda
	(self enfrentamientosJugados = 0 and: huboParda) ifTrue: [
		enfrentamientosGanadosPorLaMano := enfrentamientosGanadosPorLaMano + 1.
		enfrentamientosGanadosPorElPie := enfrentamientosGanadosPorElPie + 1
	] ifFalse:[
		ganoElEnfrentamientoLaMano 
			ifTrue: [enfrentamientosGanadosPorLaMano := enfrentamientosGanadosPorLaMano + 1]
			ifFalse: [enfrentamientosGanadosPorElPie := enfrentamientosGanadosPorElPie + 1]
	]! !

!Ronda methodsFor: 'manejo del estado - privado' stamp: 'UC 7/5/2021 21:50:30'!
avisarleAlOponenteQueJugue: unaCarta
	elOponenteJugoEstaRonda := elOponenteJugoEstaRonda not.
	cartaQueJugoElOponente := unaCarta.
	! !

!Ronda methodsFor: 'manejo del estado - privado' stamp: 'UC 7/5/2021 21:07:33'!
initializeMano: unasCartasDeUnaMano pie: unasCartasDeUnPie
	(unasCartasDeUnaMano anySatisfy: [:cartaMano | unasCartasDeUnPie includes: cartaMano]) ifTrue: [
		self error: self class esasCartasNoPudieronVenirDeUnSoloMazo 
	].
	(unasCartasDeUnaMano size = 3 and: (unasCartasDeUnPie size =  3)) ifFalse: [
		self error: self class ambosJugadoresDebenTenerTresCartas.
	].

	leTocaALaMano := true.
	elOponenteJugoEstaRonda := false.
	enfrentamientosGanadosPorLaMano := 0.
	enfrentamientosGanadosPorElPie := 0.
	
	cartasMano:= unasCartasDeUnaMano copy.
	cartasPie := unasCartasDeUnPie copy.! !


!Ronda methodsFor: 'juego' stamp: 'UC 7/5/2021 21:54:53'!
manoJuega: unaCarta
	self verificarQueNoHayaTerminadoLaRonda.
	self verificarQueMeToque: leTocaALaMano.
	self jugar: unaCarta siLaTengoEn: cartasMano.
	
	"Este codigo esta bastante similar al de pieJuega:, con mas tiempo encontraria una abstraccion mas linda"
	leTocaALaMano := elOponenteJugoEstaRonda 
			ifTrue: [ 
				| ganoElEnfrentamientoLaMano |
				ganoElEnfrentamientoLaMano := (unaCarta mataA: cartaQueJugoElOponente).
				self actualizarLosContadoresCuando: ganoElEnfrentamientoLaMano y: false.
				ganoElEnfrentamientoLaMano.
			] 
			ifFalse: [false].
	self avisarleAlOponenteQueJugue: unaCarta.
	! !

!Ronda methodsFor: 'juego' stamp: 'UC 7/5/2021 21:55:01'!
pieJuega: unaCarta
	self verificarQueNoHayaTerminadoLaRonda.
	self verificarQueMeToque: leTocaALaMano not.
	self jugar: unaCarta siLaTengoEn: cartasPie.
	
	"Este codigo esta bastante similar al de manoJuega:, con mas tiempo encontraria una abstraccion mas linda"
	leTocaALaMano :=  elOponenteJugoEstaRonda 
				ifTrue: [ 
					| ganoElEnfrentamientoLaMano empardo |
					ganoElEnfrentamientoLaMano := cartaQueJugoElOponente mataA: unaCarta .
					empardo := cartaQueJugoElOponente empardaCon: unaCarta.
					self actualizarLosContadoresCuando: ganoElEnfrentamientoLaMano y: empardo.
					ganoElEnfrentamientoLaMano or: empardo.
				] ifFalse: [true].
	self avisarleAlOponenteQueJugue: unaCarta.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ronda class' category: 'ISW1-2021-1C-2doParcial'!
Ronda class
	instanceVariableNames: ''!

!Ronda class methodsFor: 'mensajes de error' stamp: 'UC 7/5/2021 18:20:29'!
ambosJugadoresDebenTenerTresCartas
	^'Ambos jugadores deben tener 3 cartas'.! !

!Ronda class methodsFor: 'mensajes de error' stamp: 'UC 7/5/2021 18:26:33'!
errorLeTocaAlOponente
	^'Le toca al oponente. Espere su turno para jugar'! !

!Ronda class methodsFor: 'mensajes de error' stamp: 'UC 7/5/2021 17:48:09'!
esasCartasNoPudieronVenirDeUnSoloMazo
	^'Matufia che!! Esas cartas no pudieron venir de un solo mazo'
! !

!Ronda class methodsFor: 'mensajes de error' stamp: 'UC 7/5/2021 20:43:43'!
noSePuedeJugarPorquelaPartidaYaTermino
	^'No se puede jugar porque la partida ya termin�'.! !

!Ronda class methodsFor: 'mensajes de error' stamp: 'UC 7/5/2021 18:28:24'!
noTenesEsaCarta
	^'No tenes esa carta'! !


!Ronda class methodsFor: 'creacion de instancia' stamp: 'UC 7/5/2021 17:50:42'!
mano: unJugadorMano pie: unJugadorPie
	^self new initializeMano: unJugadorMano pie: unJugadorPie.! !
