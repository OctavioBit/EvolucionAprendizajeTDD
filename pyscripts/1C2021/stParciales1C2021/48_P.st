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
	instanceVariableNames: 'manoCon123DeEspada manoCon456DeBasto manoDeAnchos manoConCartasDemas manoConCartasDeMenos manoCon456DeCopa'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'nz 7/5/2021 19:34:44'!
setUp

	manoDeAnchos := Bag
		with: CartaDeTruco anchoDeEspada
		with: CartaDeTruco anchoDeEspada
		with: CartaDeTruco anchoDeEspada.
		
	manoCon123DeEspada := Bag
		with: CartaDeTruco anchoDeEspada
		with: (CartaDeTruco espadaCon: 2)
		with: (CartaDeTruco espadaCon: 3).
		
	manoCon456DeBasto := Bag
		with: (CartaDeTruco bastoCon: 5)
		with: (CartaDeTruco bastoCon: 4)
		with: (CartaDeTruco bastoCon: 6).
		
	manoCon456DeCopa := Bag
		with: (CartaDeTruco copaCon: 5)
		with: (CartaDeTruco copaCon: 4)
		with: (CartaDeTruco copaCon: 6).
		
	manoConCartasDemas := Bag
		with: CartaDeTruco anchoDeEspada
		with: CartaDeTruco anchoDeBasto
		with: CartaDeTruco sieteDeOro
		with: CartaDeTruco sieteDeEspada.
		
	manoConCartasDeMenos := Bag
		with: CartaDeTruco anchoDeBasto
		with: CartaDeTruco sieteDeEspada.! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'nz 7/5/2021 19:25:04'!
test01NoSePuedeCrearUnaRondaConCartasRepetidasEnLaMano

	self
		should: [ RondaDeTruco mano: manoDeAnchos pie: manoDeAnchos ]
		raise: Error - MessageNotUnderstood
		withMessageText: RondaDeTruco manoInvalidaErrorDescription.
		! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'nz 7/5/2021 19:30:46'!
test02NoPuedeArrancarJugandoElPie

	| ronda |
	
	ronda := RondaDeTruco mano: manoCon123DeEspada pie: manoCon456DeBasto.
	
	self
		should: [ ronda pieJuega: (CartaDeTruco bastoCon: 5) ]
		raise: Error - MessageNotUnderstood
		withMessageText: RondaDeTruco turnoIncorrectoErrorDescription.
		! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'nz 7/5/2021 19:30:03'!
test03LaManoSePuedeTenerUnaManoDeMasDeTresCartas

	self
		should: [ RondaDeTruco mano: manoConCartasDemas pie: manoCon456DeBasto ]
		raise: Error - MessageNotUnderstood
		withMessageText: RondaDeTruco manoInvalidaErrorDescription.
		! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'nz 7/5/2021 19:30:03'!
test04LaManoNoPuedeTenerUnaManoDeMenosDeTresCartas

	self
		should: [ RondaDeTruco mano: manoConCartasDeMenos pie: manoCon456DeBasto ]
		raise: Error - MessageNotUnderstood
		withMessageText: RondaDeTruco manoInvalidaErrorDescription.
		! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'nz 7/5/2021 19:30:03'!
test05ElPieTieneQueArrancarConTresCartas

	self
		should: [ RondaDeTruco mano: manoCon456DeBasto pie: manoConCartasDeMenos ]
		raise: Error - MessageNotUnderstood
		withMessageText: RondaDeTruco manoInvalidaErrorDescription.
		! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'nz 7/5/2021 19:30:03'!
test06NoPuedeHaberCartasRepetidasEntreLasManos

	self
		should: [ RondaDeTruco mano: manoCon456DeBasto pie: manoConCartasDeMenos ]
		raise: Error - MessageNotUnderstood
		withMessageText: RondaDeTruco manoInvalidaErrorDescription.
		! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'nz 7/5/2021 19:30:46'!
test07LaManoNoPuedeJugarUnaCartaQueNoTiene

	| ronda |
	ronda := RondaDeTruco mano: manoCon123DeEspada pie: manoCon456DeBasto.
	
	self
		should: [ ronda manoJuega: (CartaDeTruco bastoCon: 5) ]
		raise: Error - MessageNotUnderstood
		withMessageText: RondaDeTruco noSePuedeJugarConLoQueNoSeTieneErrorDescription.
		! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'nz 7/5/2021 19:33:32'!
test08SePuedeVerLaUltimaCartaJugada

	|  ronda  |
	
	ronda := RondaDeTruco mano: manoCon123DeEspada pie: manoCon456DeBasto.
	ronda manoJuega: (CartaDeTruco espadaCon: 3).
	
	"De alguna forma el pie tiene que ver a que tiene que ganarle"
	"Siendo dos alcanza con ver la ultima carta"
	self assert: ronda ultimaCartaJugada equals: (CartaDeTruco espadaCon: 3).

	
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'nz 7/5/2021 19:31:48'!
test09EnUnEnfrentamientoDondeLaManoGanaCambiaElResultado

	|  ronda  |
	
	ronda := RondaDeTruco mano: manoCon123DeEspada pie: manoCon456DeBasto.
	ronda manoJuega: (CartaDeTruco espadaCon: 3).
	ronda pieJuega: (CartaDeTruco bastoCon: 4).
	self assert: ronda elUltimoEnfrentamientoLoGanoLaMano.
	self deny: ronda elUltimoEnfrentamientoLoGanoElPie.! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'nz 7/5/2021 19:32:18'!
test10EnUnEnfrentamientoDondeElPieGanaCambiaElResultado

	|  ronda  |
	
		
	ronda := RondaDeTruco mano: manoCon456DeBasto pie: manoCon123DeEspada.
	ronda manoJuega: (CartaDeTruco bastoCon: 6).
	self assert: ronda ultimaCartaJugada equals: (CartaDeTruco bastoCon: 6).
	
	ronda pieJuega: (CartaDeTruco espadaCon: 2).
	self assert: ronda elUltimoEnfrentamientoLoGanoElPie.
	self deny: ronda elUltimoEnfrentamientoLoGanoLaMano.! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'nz 7/5/2021 19:32:25'!
test11RepedidoDel_test09

	|  ronda  |
	
	ronda := RondaDeTruco mano: manoCon123DeEspada pie: manoCon456DeBasto.
	ronda manoJuega: (CartaDeTruco espadaCon: 3).
	ronda pieJuega: (CartaDeTruco bastoCon: 6).
	self assert: ronda elUltimoEnfrentamientoLoGanoLaMano.
	self deny: ronda elUltimoEnfrentamientoLoGanoElPie.! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'nz 7/5/2021 19:32:28'!
test12PieNoPuedeComenzarElSegundoEnfrentamientoSiNoGanoElPrimero

	|  ronda  |
	
	ronda := RondaDeTruco mano: manoCon123DeEspada pie: manoCon456DeBasto.
	ronda manoJuega: (CartaDeTruco espadaCon: 3).
	ronda pieJuega: (CartaDeTruco bastoCon: 6).
	self
		should: [ ronda pieJuega: (CartaDeTruco bastoCon: 5) ]
		raise: Error - MessageNotUnderstood
		withMessageText: RondaDeTruco turnoIncorrectoErrorDescription.
		! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'nz 7/5/2021 19:32:34'!
test13ManoNoPuedeJugarUnaCartaQueJugoEnOtroEnfrentamiento

	|  ronda  |
	
	ronda := RondaDeTruco mano: manoCon123DeEspada pie: manoCon456DeBasto.
	ronda manoJuega: (CartaDeTruco espadaCon: 3).
	ronda pieJuega: (CartaDeTruco bastoCon: 6).
	self
		should: [ ronda manoJuega: (CartaDeTruco espadaCon: 3) ]
		raise: Error - MessageNotUnderstood
		withMessageText: RondaDeTruco noSePuedeJugarConLoQueNoSeTieneErrorDescription.
		! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'nz 7/5/2021 19:33:00'!
test14PieNoPuedeJugarUnaCartaQueJugoEnOtroEnfrentamiento

	|  ronda  |
	
	ronda := RondaDeTruco mano: manoCon123DeEspada pie: manoCon456DeBasto.
	ronda manoJuega: (CartaDeTruco espadaCon: 3).
	ronda pieJuega: (CartaDeTruco bastoCon: 6).
	ronda manoJuega: (CartaDeTruco espadaCon: 2).
	self
		should: [ ronda pieJuega: (CartaDeTruco bastoCon: 6) ]
		raise: Error - MessageNotUnderstood
		withMessageText: RondaDeTruco noSePuedeJugarConLoQueNoSeTieneErrorDescription.
		! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'nz 7/5/2021 19:33:12'!
test15ManoNoPuedeComenzarElSegundoEnfrentamientoSiNoGanoElPrimero

	|  ronda  |
	
	ronda := RondaDeTruco mano: manoCon456DeBasto pie: manoCon123DeEspada.
	ronda manoJuega: (CartaDeTruco bastoCon: 6).
	ronda pieJuega: (CartaDeTruco espadaCon: 2).
	
	self
		should: [ ronda manoJuega: (CartaDeTruco bastoCon: 5) ]
		raise: Error - MessageNotUnderstood
		withMessageText: RondaDeTruco turnoIncorrectoErrorDescription.
		! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'nz 7/5/2021 19:37:15'!
test16AlEmpardarLaPrimeraDebeComenzarLaMano

	|  ronda  |
	
	ronda := RondaDeTruco mano: manoCon456DeBasto pie: manoCon456DeCopa.
	ronda manoJuega: (CartaDeTruco bastoCon: 4).
	ronda pieJuega: (CartaDeTruco copaCon: 4).
	self deny: ronda elUltimoEnfrentamientoLoGanoLaMano.
	self deny: ronda elUltimoEnfrentamientoLoGanoElPie.
	
	self
		should: [ ronda pieJuega: (CartaDeTruco copaCon: 5) ]
		raise: Error - MessageNotUnderstood
		withMessageText: RondaDeTruco turnoIncorrectoErrorDescription.
		! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'nz 7/5/2021 20:32:35'!
test17GanaElPieEnElSegundoEnfrentamiento

	|  ronda  |
	
	ronda := RondaDeTruco mano: manoCon456DeBasto pie: manoCon456DeCopa.
	ronda manoJuega: (CartaDeTruco bastoCon: 4).
	ronda pieJuega: (CartaDeTruco copaCon: 5).
	ronda pieJuega: (CartaDeTruco copaCon: 6).
	ronda manoJuega: (CartaDeTruco bastoCon: 5).
	self assert: ronda elUltimoEnfrentamientoLoGanoElPie.
	self assert: ronda ganoElPie.
	self deny: ronda ganoLaMano.
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'nz 7/5/2021 20:32:49'!
test18GanaLaManoEnElTercerEnfrentamiento

	|  ronda  |
	
	ronda := RondaDeTruco mano: manoCon456DeBasto pie: manoCon456DeCopa.
	ronda manoJuega: (CartaDeTruco bastoCon: 4).
	ronda pieJuega: (CartaDeTruco copaCon: 6).
	ronda pieJuega: (CartaDeTruco copaCon: 5).
	ronda manoJuega: (CartaDeTruco bastoCon: 6).
	self assert: ronda elUltimoEnfrentamientoLoGanoLaMano.
	ronda manoJuega: (CartaDeTruco bastoCon: 5).
	ronda pieJuega: (CartaDeTruco copaCon: 4).
	self assert: ronda ganoLaMano.! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'nz 7/5/2021 20:33:05'!
test19ElPieNoPuedeContinuarJugandoCuandoLaRondaTermino

	|  ronda  |
	
	ronda := RondaDeTruco mano: manoCon456DeBasto pie: manoCon456DeCopa.
	ronda manoJuega: (CartaDeTruco bastoCon: 4).
	ronda pieJuega: (CartaDeTruco copaCon: 5).
	ronda pieJuega: (CartaDeTruco copaCon: 6).
	ronda manoJuega: (CartaDeTruco bastoCon: 5).
	
	self
		should: [ ronda pieJuega: (CartaDeTruco copaCon: 4) ]
		raise: Error - MessageNotUnderstood
		withMessageText: RondaDeTruco laRondaYaTerminoErrorDescription.
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'nz 7/5/2021 20:33:21'!
test20LaManoNoPuedeContinuarJugandoCuandoLaRondaTermino

	|  ronda  |
	
	ronda := RondaDeTruco mano: manoCon456DeBasto pie: manoCon456DeCopa.
	ronda manoJuega: (CartaDeTruco bastoCon: 4).
	ronda pieJuega: (CartaDeTruco copaCon: 6).
	ronda pieJuega: (CartaDeTruco copaCon: 5).
	ronda manoJuega: (CartaDeTruco bastoCon: 6).
	ronda manoJuega: (CartaDeTruco bastoCon: 5).
	ronda pieJuega: (CartaDeTruco copaCon: 4).
	
	self
		should: [ ronda pieJuega: (CartaDeTruco copaCon: 3) ]
		raise: Error - MessageNotUnderstood
		withMessageText: RondaDeTruco laRondaYaTerminoErrorDescription.
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'nz 7/5/2021 20:23:54'!
test21AlEmpardarEnElSegundoEnfrentamientoComienzaElGanadorDelPrimerEnfrentamiento

	|  ronda  |
	
	ronda := RondaDeTruco mano: manoCon456DeBasto pie: manoCon456DeCopa.
	ronda manoJuega: (CartaDeTruco bastoCon: 4).
	ronda pieJuega: (CartaDeTruco copaCon: 6).
	ronda pieJuega: (CartaDeTruco copaCon: 5).
	ronda manoJuega: (CartaDeTruco bastoCon: 5).
	
	self
		should: [ ronda manoJuega: (CartaDeTruco bastoCon: 6) ]
		raise: Error - MessageNotUnderstood
		withMessageText: RondaDeTruco turnoIncorrectoErrorDescription.
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'nz 7/5/2021 20:30:05'!
test22SiLaRondaNoTerminoEntoncesNoGanoNadie

	|  ronda  |
	
	ronda := RondaDeTruco mano: manoCon456DeBasto pie: manoCon456DeCopa.
	ronda manoJuega: (CartaDeTruco bastoCon: 4).
	ronda pieJuega: (CartaDeTruco copaCon: 5).
	self deny: ronda ganoLaMano.
	self deny: ronda ganoElPie.! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'nz 7/5/2021 20:42:44'!
test23SiManoGanaLuegoDePardarEnLaPrimeraGanaLaRonda

	|  ronda  |
	
	ronda := RondaDeTruco mano: manoCon456DeBasto pie: manoCon456DeCopa.
	ronda manoJuega: (CartaDeTruco bastoCon: 5).
	ronda pieJuega: (CartaDeTruco copaCon: 5).
	ronda manoJuega: (CartaDeTruco bastoCon: 6).
	ronda pieJuega: (CartaDeTruco copaCon: 4).
	self assert: ronda ganoLaMano.
	self deny: ronda ganoElPie.
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'nz 7/5/2021 20:43:14'!
test24SiElPieGanaLuegoDePardarEnLaPrimeraGanaLaRonda

	|  ronda  |
	
	ronda := RondaDeTruco mano: manoCon456DeBasto pie: manoCon456DeCopa.
	ronda manoJuega: (CartaDeTruco bastoCon: 5).
	ronda pieJuega: (CartaDeTruco copaCon: 5).
	ronda manoJuega: (CartaDeTruco bastoCon: 4).
	ronda pieJuega: (CartaDeTruco copaCon: 6).
	self assert: ronda ganoElPie.
	self deny: ronda ganoLaMano.
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


!classDefinition: #RondaDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #RondaDeTruco
	instanceVariableNames: 'cartasDeLaMano cartasDelPie leTocaJugarALaMano ultimaCartaJugada resultadoUltimoEnfrentamiento manoArrancoElEnfrentamiento rondaEnJuego puntosMano puntosPie'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTruco methodsFor: 'inicializacion' stamp: 'nz 7/5/2021 20:20:28'!
initializeMano: lasCartasDeLaMano pie: lasCartasDelPie 
	
	cartasDeLaMano := lasCartasDeLaMano.
	cartasDelPie := lasCartasDelPie.
	leTocaJugarALaMano := true.
	manoArrancoElEnfrentamiento := true.
	rondaEnJuego := true.
	puntosMano := 0.
	puntosPie := 0.! !


!RondaDeTruco methodsFor: 'testing' stamp: 'nz 7/5/2021 18:49:32'!
elUltimoEnfrentamientoLoGanoElPie
	^resultadoUltimoEnfrentamiento = #ganoPie.! !

!RondaDeTruco methodsFor: 'testing' stamp: 'nz 7/5/2021 18:49:59'!
elUltimoEnfrentamientoLoGanoLaMano
	^resultadoUltimoEnfrentamiento = #ganoMano.! !

!RondaDeTruco methodsFor: 'testing' stamp: 'nz 7/5/2021 20:30:54'!
ganoElPie
	^rondaEnJuego not and: [ puntosPie > puntosMano ].! !

!RondaDeTruco methodsFor: 'testing' stamp: 'nz 7/5/2021 20:31:15'!
ganoLaMano
	^rondaEnJuego not and: [ puntosMano > puntosPie ].! !

!RondaDeTruco methodsFor: 'testing' stamp: 'nz 7/5/2021 19:17:36'!
leTocaALaMano
	^leTocaJugarALaMano .! !

!RondaDeTruco methodsFor: 'testing' stamp: 'nz 7/5/2021 18:35:45'!
leTocaAlPie
	^leTocaJugarALaMano not.! !


!RondaDeTruco methodsFor: 'playing' stamp: 'nz 7/5/2021 20:45:00'!
manoJuega: unaCartaDeTruco 

	rondaEnJuego ifFalse: [
		self error: self class laRondaYaTerminoErrorDescription ].

	self leTocaALaMano ifFalse: [
		self error: self class turnoIncorrectoErrorDescription ].

	cartasDeLaMano remove: unaCartaDeTruco ifAbsent: [
		self error: self class noSePuedeJugarConLoQueNoSeTieneErrorDescription ].
	
	manoArrancoElEnfrentamiento ifFalse: [
		self resolverEnfrentamientoEntreMano: unaCartaDeTruco yPie: ultimaCartaJugada.
	] ifTrue: [
		leTocaJugarALaMano := false.
		ultimaCartaJugada := unaCartaDeTruco.
	].

	
	
	! !

!RondaDeTruco methodsFor: 'playing' stamp: 'nz 7/5/2021 20:44:49'!
pieJuega: unaCartaDeTruco 

	rondaEnJuego ifFalse: [
		self error: self class laRondaYaTerminoErrorDescription ].

	self leTocaAlPie ifFalse: [
		self error: self class turnoIncorrectoErrorDescription ].

	cartasDelPie remove: unaCartaDeTruco ifAbsent: [
		self error: self class noSePuedeJugarConLoQueNoSeTieneErrorDescription ].
	
	manoArrancoElEnfrentamiento ifTrue: [
		self resolverEnfrentamientoEntreMano: ultimaCartaJugada yPie: unaCartaDeTruco.
	] ifFalse: [
		leTocaJugarALaMano := true.
		ultimaCartaJugada := unaCartaDeTruco.
	].
	
	! !

!RondaDeTruco methodsFor: 'playing' stamp: 'nz 7/5/2021 18:44:37'!
ultimaCartaJugada
	^ultimaCartaJugada.! !


!RondaDeTruco methodsFor: 'private' stamp: 'nz 7/5/2021 18:25:23'!
cartasDeLaMano
	
	^cartasDeLaMano.! !

!RondaDeTruco methodsFor: 'private' stamp: 'nz 7/5/2021 18:37:08'!
cartasDelPie
	
	^cartasDelPie! !

!RondaDeTruco methodsFor: 'private' stamp: 'nz 7/5/2021 21:56:42'!
resolverEnfrentamientoEntreMano: laCartaDeLaMano yPie: laCartaDelPie 

	"HOHOHO, deje el paso 3 para ultimo momento mientras alimentaba esta maraña de ifs"
	"Cuando quise comenzar a refactorizar se me fue el tiempo pensando en como separarlo :("
		(laCartaDeLaMano empardaCon: laCartaDelPie)
			ifTrue: [
				resultadoUltimoEnfrentamiento ifNil: [
					leTocaJugarALaMano := true.
					manoArrancoElEnfrentamiento := true.
				] ifNotNil: [
					(resultadoUltimoEnfrentamiento = #ganoPie) ifTrue: [ 
						leTocaJugarALaMano := false.
						manoArrancoElEnfrentamiento := true.
					] ifFalse: [
						leTocaJugarALaMano := true.
						manoArrancoElEnfrentamiento := true.
					].
				].
				resultadoUltimoEnfrentamiento := #parda.		
				^nil.
			].
		
		(laCartaDeLaMano mataA: laCartaDelPie)
			ifTrue: [ 
				(resultadoUltimoEnfrentamiento notNil and: [resultadoUltimoEnfrentamiento ~= #ganoPie])
					ifTrue: [ rondaEnJuego := false ].
				resultadoUltimoEnfrentamiento := #ganoMano.
				puntosMano := puntosMano + 1.
				leTocaJugarALaMano := true.
				manoArrancoElEnfrentamiento := true.
			]
			ifFalse: [ 
				(resultadoUltimoEnfrentamiento notNil and: [resultadoUltimoEnfrentamiento ~= #ganoMano])
					ifTrue: [ rondaEnJuego := false ].
				resultadoUltimoEnfrentamiento := #ganoPie.		
				puntosPie := puntosPie + 1.
				leTocaJugarALaMano := false.
				manoArrancoElEnfrentamiento := false.
			].! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RondaDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco class
	instanceVariableNames: ''!

!RondaDeTruco class methodsFor: 'errores garrafales' stamp: 'nz 7/5/2021 17:40:12'!
manoInvalidaErrorDescription
	^ 'Mano inválida, alguien se está carteando!!'.! !


!RondaDeTruco class methodsFor: 'instance creation' stamp: 'nz 7/5/2021 18:06:16'!
mano: lasCartasDeLaMano pie: lasCartasDelPie 

	"Falta validar varias cosas"
	
	self asegurarseDeQueLasCartasSeRepartieronBienPara: lasCartasDeLaMano y: lasCartasDelPie.
	
	^self new initializeMano: lasCartasDeLaMano pie: lasCartasDelPie.! !


!RondaDeTruco class methodsFor: 'as yet unclassified' stamp: 'nz 7/5/2021 18:06:38'!
asegurarseDeQueLasCartasSeRepartieronBienPara: lasCartasDeLaMano y: lasCartasDelPie 
	
	| cartasEnJuego |
	(lasCartasDeLaMano size ~= 3)
		ifTrue: [ self error: self manoInvalidaErrorDescription ].
		
	(lasCartasDelPie size ~= 3)
		ifTrue: [ self error: self manoInvalidaErrorDescription ].
		
	cartasEnJuego := lasCartasDelPie copy.
	cartasEnJuego addAll: lasCartasDeLaMano.
	(cartasEnJuego allSatisfy: [ :carta | (cartasEnJuego occurrencesOf: carta) = 1 ])
	ifFalse: [ self error: self manoInvalidaErrorDescription ].
! !

!RondaDeTruco class methodsFor: 'as yet unclassified' stamp: 'nz 7/5/2021 19:59:54'!
laRondaYaTerminoErrorDescription
	^'La ronda ya termino, no se puede seguir jugando cartas!!'.! !

!RondaDeTruco class methodsFor: 'as yet unclassified' stamp: 'nz 7/5/2021 18:15:26'!
noSePuedeJugarConLoQueNoSeTieneErrorDescription
	^'Se intentó jugar una carta que el jugador no tenia!!'.! !

!RondaDeTruco class methodsFor: 'as yet unclassified' stamp: 'nz 7/5/2021 17:52:16'!
turnoIncorrectoErrorDescription
	
	^'Epa, che!! No le toca a este jugador!!'! !
