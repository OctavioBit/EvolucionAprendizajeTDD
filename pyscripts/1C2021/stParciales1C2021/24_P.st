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


!classDefinition: #RondaTest category: 'ISW1-2021-1C-2doParcial'!
TestCase subclass: #RondaTest
	instanceVariableNames: 'manoGanadora manoPerdedora manoGanaPrimerayTercera manoGanaSegunda manoGanaSegundayTercera manoGanaPrimera empardaPrimeraGanaSegunda empardaPrimeraPierdeSegunda'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaTest methodsFor: 'setUp' stamp: 'f 7/5/2021 20:51:37'!
setUp


	manoGanadora := OrderedCollection with: CartaDeTruco anchoDeEspada with: CartaDeTruco anchoDeBasto 
	with: (CartaDeTruco bastoCon: 2).
	manoPerdedora:= OrderedCollection with: (CartaDeTruco oroCon: 4 )with: (CartaDeTruco oroCon: 5 ) 
	with: (CartaDeTruco oroCon: 6 ).
	manoGanaPrimerayTercera := OrderedCollection with: CartaDeTruco anchoDeEspada with: (CartaDeTruco bastoCon: 4) with: CartaDeTruco anchoDeBasto .
	manoGanaSegunda:= OrderedCollection with: (CartaDeTruco oroCon: 4 )with: (CartaDeTruco oroCon: 1 ) 
	with: (CartaDeTruco oroCon: 6 ).
	manoGanaSegundayTercera:= OrderedCollection with: CartaDeTruco anchoDeEspada with: CartaDeTruco anchoDeBasto with: (CartaDeTruco bastoCon: 4). 
	manoGanaPrimera:= OrderedCollection with: (CartaDeTruco oroCon:1 )with: (CartaDeTruco copaCon:4) with: (CartaDeTruco espadaCon: 7). 
	empardaPrimeraGanaSegunda:= OrderedCollection with: (CartaDeTruco oroCon:1 )with: (CartaDeTruco anchoDeBasto ) with: (CartaDeTruco bastoCon: 7). 
	empardaPrimeraPierdeSegunda:= OrderedCollection with: (CartaDeTruco bastoCon: 5)with: (CartaDeTruco bastoCon: 4) with: (CartaDeTruco copaCon: 7). ! !


!RondaTest methodsFor: 'tests' stamp: 'f 7/5/2021 19:36:34'!
test01SoloSePuedeIncializarCon3Cartas
	|ronda|
	self should:[ronda:=Ronda initconLasCartasdelPie: (OrderedCollection with: CartaDeTruco anchoDeEspada) yLasCartasdeLaMano: (OrderedCollection with: CartaDeTruco anchoDeBasto)]
	raise: Error
	withMessageText: Ronda not3cardsInonedeckError.
	
	"JuegaMano solo tira error si el objeto no se creo"
	self should:[ronda juegaMano.]
	raise: Error .
		
	! !

!RondaTest methodsFor: 'tests' stamp: 'f 7/5/2021 20:08:46'!
test02InitializedinInitialState
	|ronda|
	ronda:=Ronda initconLasCartasdelPie:(manoGanadora copy)yLasCartasdeLaMano: (manoPerdedora copy).
	self assert: ((ronda Estado) class)  equals: ((EstadoInicial new)class).
		
	! !

!RondaTest methodsFor: 'tests' stamp: 'f 7/5/2021 21:35:59'!
test03EachPlayerHas3CardsBeforePlaying
	|ronda|
	ronda:=Ronda initconLasCartasdelPie:manoGanadora yLasCartasdeLaMano: manoPerdedora.
	self assertcards: (ronda cartasDelPie ) andcards:  (ronda cartasDeLaMano) haveSize: 3 .
! !

!RondaTest methodsFor: 'tests' stamp: 'f 7/5/2021 20:09:13'!
test04HandStartsPlaying
	|ronda|
	ronda:=Ronda initconLasCartasdelPie:(manoGanadora copy) yLasCartasdeLaMano: (manoPerdedora copy).
	ronda juegaMano.
       self assert:( (ronda cartasDeLaMano) size) equals: 2.
	
	
		
	! !

!RondaTest methodsFor: 'tests' stamp: 'f 7/5/2021 20:09:28'!
test05ErrorIfFootStartsPlaying
	|ronda|
	ronda:=Ronda initconLasCartasdelPie:(manoGanadora copy) yLasCartasdeLaMano: (manoPerdedora copy).
	self should: [ronda juegaPie.]
	raise: Error
	withMessageText: JuegaMano errorTurnoMano.

       self assert:( (ronda cartasDelPie ) size) equals: 3.
	
	
		
	! !

!RondaTest methodsFor: 'tests' stamp: 'f 7/5/2021 20:09:42'!
test06HandCantPlayTwice
	|ronda|
	ronda:=Ronda initconLasCartasdelPie:(manoGanadora copy)yLasCartasdeLaMano: (manoPerdedora copy).
	ronda juegaMano.
	self should: [ronda juegaMano.]
	raise: Error
	withMessageText: JuegaPie errorTurnoPie.

       self assert:( (ronda cartasDeLaMano ) size) equals: 2.
	
	
		
	! !

!RondaTest methodsFor: 'tests' stamp: 'f 7/5/2021 21:36:26'!
test07HandWiningFirstEncounterReflectsOncardsAndState
	|ronda|
	ronda:=Ronda initconLasCartasdelPie:(manoGanadora copy) yLasCartasdeLaMano: (manoPerdedora copy).
	ronda juegaMano.
	ronda juegaPie.
	

	self assert: ((ronda Estado) class)  equals: ((GanoPrimeraPie new)class).	
	self assertcards: (ronda cartasDelPie ) andcards:  (ronda cartasDeLaMano) haveSize: 2 .
	
		
	! !

!RondaTest methodsFor: 'tests' stamp: 'f 7/5/2021 21:36:38'!
test08FootWiningFirstEncounterReflectsOncardsAndState
	|ronda|
	ronda:=Ronda initconLasCartasdelPie:(manoPerdedora copy) yLasCartasdeLaMano: (manoGanadora copy).
	ronda juegaMano.
	ronda juegaPie.
	

	self assert: ((ronda Estado) class)  equals: ((GanoPrimeraMano new)class).	
	self assertcards: (ronda cartasDelPie ) andcards:  (ronda cartasDeLaMano) haveSize: 2 .
		
	! !

!RondaTest methodsFor: 'tests' stamp: 'f 7/5/2021 21:36:49'!
test09TyingReflectsOncardsAndState
	|ronda|
	ronda:=Ronda initconLasCartasdelPie:(manoPerdedora copy) yLasCartasdeLaMano: (manoPerdedora copy).
	ronda juegaMano.
	ronda juegaPie.
	

	self assert: ((ronda Estado) class)  equals: ((Empardaron new)class).	
	self assertcards: (ronda cartasDelPie ) andcards:  (ronda cartasDeLaMano) haveSize: 2.
	
		
	! !

!RondaTest methodsFor: 'tests' stamp: 'f 7/5/2021 21:36:58'!
test10FootWiningFirstandSecondEncounterReflectsOncardsAndState
	|ronda|
	ronda:=Ronda initconLasCartasdelPie:(manoGanadora copy) yLasCartasdeLaMano: (manoPerdedora copy).
	ronda juegaMano.
	ronda juegaPie.
	ronda juegaPie.
	ronda juegaMano.
	
	self assert: ((ronda Estado) class)  equals: ((GanoRondaPie new)class).	
	self assertcards: (ronda cartasDelPie ) andcards:  (ronda cartasDeLaMano) haveSize: 1.
	! !

!RondaTest methodsFor: 'tests' stamp: 'f 7/5/2021 21:37:06'!
test11HandCantPlayIfFootWonFirstRound
	|ronda|
	ronda:=Ronda initconLasCartasdelPie:(manoGanadora copy) yLasCartasdeLaMano: (manoPerdedora copy).
	ronda juegaMano.
	ronda juegaPie.
	
	self should: [ronda juegaMano.]
	raise: Error
	withMessageText: JuegaPie errorTurnoPie.
	
	self assertcards: (ronda cartasDelPie ) andcards:  (ronda cartasDeLaMano) haveSize: 2 .
	
		
	! !

!RondaTest methodsFor: 'tests' stamp: 'f 7/5/2021 21:37:13'!
test12HandWiningFirstandSecondEncounterReflectsOncardsAndState
	|ronda|
	ronda:=Ronda initconLasCartasdelPie:(manoPerdedora copy) yLasCartasdeLaMano: (manoGanadora copy).
	ronda juegaMano.
	ronda juegaPie.
	
	ronda juegaMano.
	ronda juegaPie.
	
	self assert: ((ronda Estado) class)  equals: ((GanoRondaMano new)class).	
	self assertcards: (ronda cartasDelPie ) andcards:  (ronda cartasDeLaMano) haveSize: 1 .
	
		
	! !

!RondaTest methodsFor: 'tests' stamp: 'f 7/5/2021 21:37:21'!
test13FootCantPlayIfHandWonFirstRound
	|ronda|
	ronda:=Ronda initconLasCartasdelPie:(manoPerdedora copy) yLasCartasdeLaMano: (manoGanadora copy).
	ronda juegaMano.
	ronda juegaPie.
	
	self should: [ronda juegaPie.]
	raise: Error
	withMessageText: JuegaMano errorTurnoMano.
	
	self assertcards: (ronda cartasDelPie ) andcards:  (ronda cartasDeLaMano) haveSize: 2 .
	
		
	! !

!RondaTest methodsFor: 'tests' stamp: 'f 7/5/2021 21:37:39'!
test14FootWiningFirstandThirdEncounterReflectsOncardsAndState
	|ronda|
	ronda:=Ronda initconLasCartasdelPie:(manoGanaPrimerayTercera copy) yLasCartasdeLaMano: (manoGanaSegunda copy).
	ronda juegaMano.
	ronda juegaPie.
	ronda juegaPie.
	ronda juegaMano.
	
	self assert: ((ronda Estado) class)  equals: ((GanoSegundaMano new)class).	
	
	
	ronda juegaMano.
	ronda juegaPie.
	self assert: ((ronda Estado) class)  equals: ((GanoRondaPie new)class).	
	self assertcards: (ronda cartasDelPie ) andcards:  (ronda cartasDeLaMano) haveSize: 0 .
		
	! !

!RondaTest methodsFor: 'tests' stamp: 'f 7/5/2021 21:37:47'!
test15FootCantPlayIfHandWonSecond
	|ronda|
	ronda:=Ronda initconLasCartasdelPie:(manoGanaPrimerayTercera copy) yLasCartasdeLaMano: (manoGanaSegunda copy).
	ronda juegaMano.
	ronda juegaPie.
	ronda juegaPie.
	ronda juegaMano.
	self should: [ronda juegaPie.]
	raise: Error
	withMessageText: JuegaMano errorTurnoMano.
	
	self assertcards: (ronda cartasDelPie ) andcards:  (ronda cartasDeLaMano) haveSize: 1 .
		
	! !

!RondaTest methodsFor: 'tests' stamp: 'f 7/5/2021 21:37:58'!
test16HandWiningFirstandThirdEncounterReflectsOncardsAndState
	|ronda|
	ronda:=Ronda initconLasCartasdelPie: (manoGanaSegunda copy) yLasCartasdeLaMano: (manoGanaPrimerayTercera copy).
	ronda juegaMano.
	ronda juegaPie.
	ronda juegaMano.
	ronda juegaPie.
	
	
	self assert: ((ronda Estado) class)  equals: ((GanoSegundaPie new)class).	
	
	ronda juegaPie.
	ronda juegaMano.
	
	self assert: ((ronda Estado) class)  equals: ((GanoRondaMano new)class).	
	self assertcards: (ronda cartasDelPie ) andcards:  (ronda cartasDeLaMano) haveSize: 0 .
	
		
	! !

!RondaTest methodsFor: 'tests' stamp: 'f 7/5/2021 21:38:13'!
test17HandCantPlayIfFootWonSecond
	|ronda|
	ronda:=Ronda initconLasCartasdelPie:  (manoGanaSegunda copy) yLasCartasdeLaMano:(manoGanaPrimerayTercera copy).
	ronda juegaMano.
	ronda juegaPie.
	ronda juegaMano.
	ronda juegaPie.
	
	self should: [ronda juegaMano.]
	raise: Error
	withMessageText: JuegaPie errorTurnoPie.
	
	self assertcards: (ronda cartasDelPie ) andcards:  (ronda cartasDeLaMano) haveSize: 1.
		
	! !

!RondaTest methodsFor: 'tests' stamp: 'f 7/5/2021 21:38:20'!
test18FootWiningSecondandThirdEncounterReflectsOncardsAndState
	|ronda|
	ronda:=Ronda initconLasCartasdelPie:(manoGanaSegundayTercera copy) yLasCartasdeLaMano: (manoGanaPrimera copy).
	ronda juegaMano.
	ronda juegaPie.
	ronda juegaMano.
	ronda juegaPie.

	
	self assert: ((ronda Estado) class)  equals: ((GanoSegundaPie new)class).	
	
	ronda juegaPie.
	ronda juegaMano.
	
	self assert: ((ronda Estado) class)  equals: ((GanoRondaPie new)class).	
	self assertcards: (ronda cartasDelPie ) andcards:  (ronda cartasDeLaMano) haveSize: 0 .
	
		
	! !

!RondaTest methodsFor: 'tests' stamp: 'f 7/5/2021 21:38:47'!
test19HandWiningSecondandThirdEncounterReflectsOncardsAndState
	|ronda|
	ronda:=Ronda initconLasCartasdelPie: (manoGanaPrimera copy) yLasCartasdeLaMano: (manoGanaSegundayTercera copy).
	ronda juegaMano.
	ronda juegaPie.
	ronda juegaPie.
	ronda juegaMano.
	

	
	self assert: ((ronda Estado) class)  equals: ((GanoSegundaMano new)class).	
	
	ronda juegaMano.
	ronda juegaPie.
	
	self assert: ((ronda Estado) class)  equals: ((GanoRondaMano new)class).	
	self assertcards: (ronda cartasDelPie ) andcards:  (ronda cartasDeLaMano) haveSize: 0 .
	
		
	! !

!RondaTest methodsFor: 'tests' stamp: 'f 7/5/2021 21:40:20'!
test20FootWinningIsShownCorrectly
	|ronda|
	ronda:=Ronda initconLasCartasdelPie: (manoGanaSegundayTercera copy) yLasCartasdeLaMano: (manoGanaPrimera copy).
	ronda juegaMano.
	ronda juegaPie.
	
	ronda juegaMano.
	ronda juegaPie.
	
	ronda juegaPie.
	ronda juegaMano.
	
	
	self assert: (ronda Ganador )  equals: ('Pie').	
	
	
		
	! !

!RondaTest methodsFor: 'tests' stamp: 'f 7/5/2021 21:39:33'!
test21HandWinningIsShownCorrectly
	|ronda|
	ronda:=Ronda initconLasCartasdelPie: (manoGanaPrimera copy) yLasCartasdeLaMano: (manoGanaSegundayTercera copy).
	ronda juegaMano.
	ronda juegaPie.
	
	ronda juegaPie.
	ronda juegaMano.
	
	ronda juegaMano.
	ronda juegaPie.
	
	self assert: (ronda Ganador )  equals: ('Mano').	
	
	
		
	! !

!RondaTest methodsFor: 'tests' stamp: 'f 7/5/2021 21:41:04'!
test22cantPlayAfterFinishingRound
	|ronda|
	ronda:=Ronda initconLasCartasdelPie: (manoGanaSegundayTercera copy)  yLasCartasdeLaMano:  (manoGanaPrimera copy).
	ronda juegaMano.
	ronda juegaPie.
	ronda juegaMano.
	ronda juegaPie.
	
	ronda juegaPie.
	ronda juegaMano.
	
	
	self should: [ronda juegaPie]
	raise: Error
	withMessageText: GanoRondaPie RondaYaTermino.
	
		self should: [ronda juegaMano]
	raise: Error
	withMessageText: GanoRondaPie RondaYaTermino.
	
		self assertcards: (ronda cartasDelPie ) andcards:  (ronda cartasDeLaMano) haveSize: 0 .

	
	
		
	! !

!RondaTest methodsFor: 'tests' stamp: 'f 7/5/2021 20:47:24'!
test23CantAskForAWinnerBeforeEndingRound
	|ronda|
	ronda:=Ronda initconLasCartasdelPie:(manoGanadora copy) yLasCartasdeLaMano: (manoPerdedora copy).
	ronda juegaMano.
	ronda juegaPie.
	

	self should: [ronda Ganador ]
	raise: Error
	withMessageText: EstadoDelaRonda rondaSigueEnJuego.
	
		
	! !

!RondaTest methodsFor: 'tests' stamp: 'f 7/5/2021 21:41:18'!
test24FootWinningAfterTyingReflectOnCardAndState
	|ronda|
	ronda:=Ronda initconLasCartasdelPie:(empardaPrimeraGanaSegunda copy) yLasCartasdeLaMano: (empardaPrimeraPierdeSegunda copy).
	ronda juegaMano.
	ronda juegaPie.
	ronda juegaMano.
	ronda juegaPie.
	
	

	self assert: ((ronda Estado) class)  equals: ((GanoRondaPie new)class).	
	self assertcards: (ronda cartasDelPie ) andcards:  (ronda cartasDeLaMano) haveSize: 1 .

	
		
	! !

!RondaTest methodsFor: 'tests' stamp: 'f 7/5/2021 21:41:26'!
test25FootCantPlayFirstAfterTying
	|ronda|
	ronda:=Ronda initconLasCartasdelPie:(empardaPrimeraGanaSegunda copy) yLasCartasdeLaMano: (empardaPrimeraPierdeSegunda copy).
	ronda juegaMano.
	ronda juegaPie.
	self should:[ronda juegaPie]
	raise: Error
	withMessageText: JuegaMano errorTurnoMano.
	
	
	self assertcards: (ronda cartasDelPie ) andcards:  (ronda cartasDeLaMano) haveSize: 2 .

	
		
	! !

!RondaTest methodsFor: 'tests' stamp: 'f 7/5/2021 20:57:15'!
test26CantPlayAfterTyingandFinishingGame
	|ronda|
	ronda:=Ronda initconLasCartasdelPie:(empardaPrimeraGanaSegunda copy) yLasCartasdeLaMano: (empardaPrimeraPierdeSegunda copy).
	ronda juegaMano.
	ronda juegaPie.
	ronda juegaMano.
	ronda juegaPie.
	
	self should: [ronda juegaPie]
	raise: Error
	withMessageText: GanoRondaPie RondaYaTermino.
	
		self should: [ronda juegaMano]
	raise: Error
	withMessageText: GanoRondaPie RondaYaTermino.
	
	
	
		
	! !

!RondaTest methodsFor: 'tests' stamp: 'f 7/5/2021 21:18:17'!
test27PlayerDoesntHaveCardAfterUsingIt
	|ronda carta manorestante|
	ronda:=Ronda initconLasCartasdelPie:(empardaPrimeraGanaSegunda copy) yLasCartasdeLaMano: (empardaPrimeraPierdeSegunda copy).
	ronda juegaMano.
	carta := ronda cartadeLaManoEnElEncuentroActual.
	manorestante := ronda cartasDeLaMano.
	self deny: (manorestante includes:  carta).
	
	
	
	
	
	
		
	! !


!RondaTest methodsFor: 'abstraction' stamp: 'f 7/5/2021 21:35:49'!
assertcards: aCollectionOfCards andcards: anotherCollectionOfCards haveSize: anInteger 


	self assert: (aCollectionOfCards ) size  equals: (anotherCollectionOfCards) size.
	self assert: (anotherCollectionOfCards) size equals: anInteger.! !


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


!classDefinition: #EstadoDelaRonda category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #EstadoDelaRonda
	instanceVariableNames: 'estadodelEnfrentamiento ronda cartaDeLaMano cartaDelPie'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!EstadoDelaRonda methodsFor: 'inicializacion' stamp: 'f 7/5/2021 18:59:55'!
initializeFor: aRound
		^self subclassResponsibility 

! !


!EstadoDelaRonda methodsFor: 'errores' stamp: 'f 7/5/2021 19:29:42'!
raiseRondaNoTermino

	^self error: self class rondaSigueEnJuego! !

!EstadoDelaRonda methodsFor: 'errores' stamp: 'f 7/5/2021 19:00:31'!
raiseRondaTerminadaError

	^self subclassResponsibility ! !


!EstadoDelaRonda methodsFor: 'estado' stamp: 'f 7/5/2021 19:00:00'!
juegaMano	
	^self subclassResponsibility 

! !

!EstadoDelaRonda methodsFor: 'estado' stamp: 'f 7/5/2021 18:59:49'!
juegaPie	
	^self subclassResponsibility 

! !


!EstadoDelaRonda methodsFor: 'enfrentamientos' stamp: 'f 7/5/2021 19:00:13'!
seEnfrentanLasCartas

	^self subclassResponsibility ! !


!EstadoDelaRonda methodsFor: 'atributos' stamp: 'f 7/5/2021 21:15:24'!
cartadeLaMano
	^cartaDeLaMano ! !

!EstadoDelaRonda methodsFor: 'atributos' stamp: 'f 7/5/2021 21:14:46'!
cartadelPie

	^cartaDelPie ! !

!EstadoDelaRonda methodsFor: 'atributos' stamp: 'f 7/5/2021 19:32:58'!
ganador

	^self raiseRondaNoTermino! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EstadoDelaRonda class' category: 'ISW1-2021-1C-2doParcial'!
EstadoDelaRonda class
	instanceVariableNames: ''!

!EstadoDelaRonda class methodsFor: 'as yet unclassified' stamp: 'f 7/5/2021 19:50:27'!
initFor: aRound

	^self new initializeFor: aRound.! !

!EstadoDelaRonda class methodsFor: 'as yet unclassified' stamp: 'f 7/5/2021 19:30:06'!
rondaSigueEnJuego

	^'Ronda sigue en juego todavia no hay ganador'! !


!classDefinition: #Empardaron category: 'ISW1-2021-1C-2doParcial'!
EstadoDelaRonda subclass: #Empardaron
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Empardaron methodsFor: 'enfrentamientos' stamp: 'f 7/5/2021 18:53:43'!
seEnfrentanLasCartas


	ronda DespuesdeEmpardarseEnfrentanCartaDelPie: cartaDelPie  contraCartaDeLaMano: cartaDeLaMano .
	! !


!Empardaron methodsFor: 'estado' stamp: 'f 7/5/2021 18:51:58'!
juegaMano


	estadodelEnfrentamiento assertPuedeJugarMano.
	estadodelEnfrentamiento := JuegaPie new.
	cartaDeLaMano := ronda getCartaMano.
	! !

!Empardaron methodsFor: 'estado' stamp: 'f 7/5/2021 18:53:13'!
juegaPie


	estadodelEnfrentamiento assertPuedeJugarPie.
	cartaDelPie := ronda getCartaPie.
	self seEnfrentanLasCartas .
	

	! !


!Empardaron methodsFor: 'inicializacion' stamp: 'f 7/5/2021 18:51:46'!
initializeFor: aRound

	estadodelEnfrentamiento :=  JuegaMano new.
	ronda:= aRound.! !


!classDefinition: #EstadoInicial category: 'ISW1-2021-1C-2doParcial'!
EstadoDelaRonda subclass: #EstadoInicial
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!EstadoInicial methodsFor: 'inicializacion' stamp: 'f 7/5/2021 18:24:48'!
initializeFor: aRound

	estadodelEnfrentamiento :=  JuegaMano new.
	ronda:= aRound.! !


!EstadoInicial methodsFor: 'estado' stamp: 'f 7/5/2021 18:25:22'!
juegaMano


	estadodelEnfrentamiento assertPuedeJugarMano.
	estadodelEnfrentamiento := JuegaPie new.
	cartaDeLaMano := ronda getCartaMano.
	! !

!EstadoInicial methodsFor: 'estado' stamp: 'f 7/5/2021 18:25:35'!
juegaPie


	estadodelEnfrentamiento assertPuedeJugarPie.
	cartaDelPie := ronda getCartaPie.
	self seEnfrentanLasCartas .
	

	! !


!EstadoInicial methodsFor: 'enfrentamientos' stamp: 'f 7/5/2021 18:28:27'!
seEnfrentanLasCartas


	ronda EnLaFaseInicialseEnfrentanCartaDelPie: cartaDelPie  contraCartaDeLaMano: cartaDeLaMano .
	! !


!classDefinition: #GanoPrimeraMano category: 'ISW1-2021-1C-2doParcial'!
EstadoDelaRonda subclass: #GanoPrimeraMano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!GanoPrimeraMano methodsFor: 'inicializacion' stamp: 'f 7/5/2021 18:36:22'!
initializeFor: aRound

	estadodelEnfrentamiento :=  JuegaMano new.
	ronda:= aRound.! !


!GanoPrimeraMano methodsFor: 'estado' stamp: 'f 7/5/2021 18:36:44'!
juegaMano


	estadodelEnfrentamiento assertPuedeJugarMano.
	estadodelEnfrentamiento := JuegaPie new.
	cartaDeLaMano := ronda getCartaMano.
	! !

!GanoPrimeraMano methodsFor: 'estado' stamp: 'f 7/5/2021 18:37:11'!
juegaPie


	estadodelEnfrentamiento assertPuedeJugarPie.
	cartaDelPie := ronda getCartaPie.
	self seEnfrentanLasCartas .
	! !


!GanoPrimeraMano methodsFor: 'enfrentamientos' stamp: 'f 7/5/2021 18:37:43'!
seEnfrentanLasCartas


	ronda GanoPrimeraManoYseEnfrentanCartaDelPie: cartaDelPie  contraCartaDeLaMano: cartaDeLaMano .
	! !


!classDefinition: #GanoPrimeraPie category: 'ISW1-2021-1C-2doParcial'!
EstadoDelaRonda subclass: #GanoPrimeraPie
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!GanoPrimeraPie methodsFor: 'inicializacion' stamp: 'f 7/5/2021 18:38:08'!
initializeFor: aRound

	estadodelEnfrentamiento :=  JuegaPie new.
	ronda:= aRound.! !


!GanoPrimeraPie methodsFor: 'estado' stamp: 'f 7/5/2021 18:39:53'!
juegaMano


	estadodelEnfrentamiento assertPuedeJugarMano.
	cartaDeLaMano := ronda getCartaMano.
	self seEnfrentanLasCartas .
	! !

!GanoPrimeraPie methodsFor: 'estado' stamp: 'f 7/5/2021 18:39:05'!
juegaPie


	estadodelEnfrentamiento assertPuedeJugarPie.
	estadodelEnfrentamiento := JuegaMano new.
	cartaDelPie := ronda getCartaPie.
	
	! !


!GanoPrimeraPie methodsFor: 'enfrentamientos' stamp: 'f 7/5/2021 18:42:39'!
seEnfrentanLasCartas


		ronda GanoPrimeraPieYseEnfrentanCartaDelPie: cartaDelPie  contraCartaDeLaMano: cartaDeLaMano .! !


!classDefinition: #GanoRondaMano category: 'ISW1-2021-1C-2doParcial'!
EstadoDelaRonda subclass: #GanoRondaMano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!


!GanoRondaMano methodsFor: 'estado' stamp: 'f 7/5/2021 18:56:07'!
juegaMano

	^self raiseRondaTerminadaError! !

!GanoRondaMano methodsFor: 'estado' stamp: 'f 7/5/2021 18:56:13'!
juegaPie
	^self raiseRondaTerminadaError! !


!GanoRondaMano methodsFor: 'errores' stamp: 'f 7/5/2021 18:56:17'!
raiseRondaTerminadaError

	^self error: self class RondaYaTermino! !


!GanoRondaMano methodsFor: 'atributos' stamp: 'f 7/5/2021 19:31:23'!
ganador

	^'Mano'! !


!GanoRondaMano methodsFor: 'inicializacion' stamp: 'f 7/5/2021 18:56:23'!
initializeFor: aRound
! !

!GanoRondaMano methodsFor: 'inicializacion' stamp: 'f 7/5/2021 18:57:35'!
seEnfrentanLasCartas
	"Si el diseño es correcto nunca se deberia llegar a este error"
	
	^self raiseRondaTerminadaError ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GanoRondaMano class' category: 'ISW1-2021-1C-2doParcial'!
GanoRondaMano class
	instanceVariableNames: ''!

!GanoRondaMano class methodsFor: 'as yet unclassified' stamp: 'f 7/5/2021 18:55:36'!
RondaYaTermino

	'Ronda ya termino no se puede seguir jugando'! !


!classDefinition: #GanoRondaPie category: 'ISW1-2021-1C-2doParcial'!
EstadoDelaRonda subclass: #GanoRondaPie
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!GanoRondaPie methodsFor: 'enfrentamientos' stamp: 'f 7/5/2021 18:58:41'!
seEnfrentanLasCartas
	"Si el diseño es correcto nunca se deberia llegar a este error"
	
	^self raiseRondaTerminadaError ! !


!GanoRondaPie methodsFor: 'atributos' stamp: 'f 7/5/2021 19:31:09'!
ganador

	^'Pie'! !


!GanoRondaPie methodsFor: 'inicializacion' stamp: 'f 7/5/2021 18:58:01'!
initializeFor: aRound
! !


!GanoRondaPie methodsFor: 'errores' stamp: 'f 7/5/2021 18:58:32'!
raiseRondaTerminadaError

	^self error: self class RondaYaTermino! !


!GanoRondaPie methodsFor: 'estado' stamp: 'f 7/5/2021 18:58:11'!
juegaMano

	^self raiseRondaTerminadaError! !

!GanoRondaPie methodsFor: 'estado' stamp: 'f 7/5/2021 18:58:22'!
juegaPie
	^self raiseRondaTerminadaError! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GanoRondaPie class' category: 'ISW1-2021-1C-2doParcial'!
GanoRondaPie class
	instanceVariableNames: ''!

!GanoRondaPie class methodsFor: 'as yet unclassified' stamp: 'f 7/5/2021 18:57:53'!
RondaYaTermino

	'Ronda ya termino no se puede seguir jugando'! !


!classDefinition: #GanoSegundaMano category: 'ISW1-2021-1C-2doParcial'!
EstadoDelaRonda subclass: #GanoSegundaMano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!GanoSegundaMano methodsFor: 'inicializacion' stamp: 'f 7/5/2021 18:50:29'!
initializeFor: aRound

	estadodelEnfrentamiento :=  JuegaMano new.
	ronda:= aRound.! !


!GanoSegundaMano methodsFor: 'estado' stamp: 'f 7/5/2021 18:50:46'!
juegaMano


	estadodelEnfrentamiento assertPuedeJugarMano.
	estadodelEnfrentamiento := JuegaPie new.
	cartaDeLaMano := ronda getCartaMano.
	! !

!GanoSegundaMano methodsFor: 'estado' stamp: 'f 7/5/2021 18:51:00'!
juegaPie


	estadodelEnfrentamiento assertPuedeJugarPie.
	cartaDelPie := ronda getCartaPie.
	self seEnfrentanLasCartas .
	! !


!GanoSegundaMano methodsFor: 'enfrentamientos' stamp: 'f 7/5/2021 18:51:31'!
seEnfrentanLasCartas


	ronda GanoSegundaManoYseEnfrentanCartaDelPie: cartaDelPie  contraCartaDeLaMano: cartaDeLaMano .
	! !


!classDefinition: #GanoSegundaPie category: 'ISW1-2021-1C-2doParcial'!
EstadoDelaRonda subclass: #GanoSegundaPie
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!GanoSegundaPie methodsFor: 'inicializacion' stamp: 'f 7/5/2021 18:47:36'!
initializeFor: aRound

	estadodelEnfrentamiento :=  JuegaPie new.
	ronda:= aRound.! !


!GanoSegundaPie methodsFor: 'estado' stamp: 'f 7/5/2021 18:49:47'!
juegaMano


	estadodelEnfrentamiento assertPuedeJugarMano.
	cartaDeLaMano := ronda getCartaMano.
	self seEnfrentanLasCartas .
	! !

!GanoSegundaPie methodsFor: 'estado' stamp: 'f 7/5/2021 18:49:23'!
juegaPie


	estadodelEnfrentamiento assertPuedeJugarPie.
	estadodelEnfrentamiento := JuegaMano new.
	cartaDelPie := ronda getCartaPie.
	
	! !


!GanoSegundaPie methodsFor: 'enfrentamientos' stamp: 'f 7/5/2021 18:50:08'!
seEnfrentanLasCartas


		ronda GanoSegundaPieYseEnfrentanCartaDelPie: cartaDelPie  contraCartaDeLaMano: cartaDeLaMano .! !


!classDefinition: #EstadoEnfrentamiento category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #EstadoEnfrentamiento
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!EstadoEnfrentamiento methodsFor: 'assertions' stamp: 'f 7/5/2021 19:01:29'!
assertPuedeJugarMano

	^self subclassResponsibility ! !

!EstadoEnfrentamiento methodsFor: 'assertions' stamp: 'f 7/5/2021 19:01:35'!
assertPuedeJugarPie

	^self subclassResponsibility ! !


!EstadoEnfrentamiento methodsFor: 'errors' stamp: 'f 7/5/2021 19:01:55'!
raiseDeberiaJugarMano
	
	^self subclassResponsibility ! !

!EstadoEnfrentamiento methodsFor: 'errors' stamp: 'f 7/5/2021 19:02:20'!
raiseDeberiaJugarPie
	
	^self subclassResponsibility ! !


!classDefinition: #JuegaMano category: 'ISW1-2021-1C-2doParcial'!
EstadoEnfrentamiento subclass: #JuegaMano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!JuegaMano methodsFor: 'errors' stamp: 'f 7/5/2021 18:14:52'!
raiseDeberiaJugarMano

	^self error: self class errorTurnoMano! !


!JuegaMano methodsFor: 'assertions' stamp: 'f 7/5/2021 18:12:24'!
assertPuedeJugarMano! !

!JuegaMano methodsFor: 'assertions' stamp: 'f 7/5/2021 19:01:10'!
assertPuedeJugarPie

 	^self raiseDeberiaJugarMano! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'JuegaMano class' category: 'ISW1-2021-1C-2doParcial'!
JuegaMano class
	instanceVariableNames: ''!

!JuegaMano class methodsFor: 'as yet unclassified' stamp: 'f 7/5/2021 18:15:26'!
errorTurnoMano

	^'Deberia jugar mano'! !


!classDefinition: #JuegaPie category: 'ISW1-2021-1C-2doParcial'!
EstadoEnfrentamiento subclass: #JuegaPie
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!JuegaPie methodsFor: 'assertions' stamp: 'f 7/5/2021 18:14:09'!
assertPuedeJugarMano

	^self raiseDeberiaJugarPie

	! !

!JuegaPie methodsFor: 'assertions' stamp: 'f 7/5/2021 18:12:41'!
assertPuedeJugarPie

	! !


!JuegaPie methodsFor: 'errors' stamp: 'f 7/5/2021 18:15:41'!
raiseDeberiaJugarPie

	^self error:self class errorTurnoPie! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'JuegaPie class' category: 'ISW1-2021-1C-2doParcial'!
JuegaPie class
	instanceVariableNames: ''!

!JuegaPie class methodsFor: 'as yet unclassified' stamp: 'f 7/5/2021 18:15:31'!
errorTurnoPie

	^'Pie deberia jugar'! !


!classDefinition: #Ronda category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #Ronda
	instanceVariableNames: 'estado mano pie'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Ronda methodsFor: 'enfrentamientos' stamp: 'f 7/5/2021 19:06:25'!
DespuesdeEmpardarseEnfrentanCartaDelPie: cartaDelPie  contraCartaDeLaMano: cartaDeLaMano

	(cartaDelPie mataA: cartaDeLaMano) ifTrue:[estado:=GanoRondaPie initFor:self].
	(cartaDeLaMano mataA: cartaDelPie ) ifTrue:[estado:=GanoRondaMano initFor:self].

	"No chequeo El caso de que empardan devuelta por lo hablado en clase"
	
! !

!Ronda methodsFor: 'enfrentamientos' stamp: 'f 7/5/2021 19:05:33'!
EnLaFaseInicialseEnfrentanCartaDelPie: cartaDelPie  contraCartaDeLaMano: cartaDeLaMano

	(cartaDelPie mataA: cartaDeLaMano) ifTrue:[estado:=GanoPrimeraPie initFor:self].
	(cartaDeLaMano mataA: cartaDelPie ) ifTrue:[estado:=GanoPrimeraMano initFor:self].
	(cartaDeLaMano empardaCon: cartaDelPie) ifTrue: [estado:=Empardaron initFor:self]

	! !

!Ronda methodsFor: 'enfrentamientos' stamp: 'f 7/5/2021 19:07:25'!
GanoPrimeraManoYseEnfrentanCartaDelPie: cartaDelPie  contraCartaDeLaMano: cartaDeLaMano

	(cartaDelPie mataA: cartaDeLaMano) ifTrue:[estado:=GanoSegundaPie initFor:self].
	(cartaDeLaMano mataA: cartaDelPie ) ifTrue:[estado:=GanoRondaMano initFor:self].
! !

!Ronda methodsFor: 'enfrentamientos' stamp: 'f 7/5/2021 19:08:06'!
GanoPrimeraPieYseEnfrentanCartaDelPie: cartaDelPie  contraCartaDeLaMano: cartaDeLaMano

	(cartaDelPie mataA: cartaDeLaMano) ifTrue:[estado:=GanoRondaPie initFor:self].
	(cartaDeLaMano mataA: cartaDelPie ) ifTrue:[estado:=GanoSegundaMano initFor:self].
! !

!Ronda methodsFor: 'enfrentamientos' stamp: 'f 7/5/2021 19:09:00'!
GanoSegundaManoYseEnfrentanCartaDelPie: cartaDelPie  contraCartaDeLaMano: cartaDeLaMano

	(cartaDelPie mataA: cartaDeLaMano) ifTrue:[estado:=GanoRondaPie initFor:self].
	(cartaDeLaMano mataA: cartaDelPie ) ifTrue:[estado:=GanoRondaMano initFor:self].
! !

!Ronda methodsFor: 'enfrentamientos' stamp: 'f 7/5/2021 19:09:31'!
GanoSegundaPieYseEnfrentanCartaDelPie: cartaDelPie  contraCartaDeLaMano: cartaDeLaMano

	(cartaDelPie mataA: cartaDeLaMano) ifTrue:[estado:=GanoRondaPie initFor:self].
	(cartaDeLaMano mataA: cartaDelPie ) ifTrue:[estado:=GanoRondaMano initFor:self].
! !


!Ronda methodsFor: 'atributos' stamp: 'f 7/5/2021 19:45:03'!
Estado

	^estado! !

!Ronda methodsFor: 'atributos' stamp: 'f 7/5/2021 19:31:34'!
Ganador

	^estado ganador.! !

!Ronda methodsFor: 'atributos' stamp: 'f 7/5/2021 21:14:25'!
cartadeLaManoEnElEncuentroActual
	
	^estado cartadeLaMano
	! !

!Ronda methodsFor: 'atributos' stamp: 'f 7/5/2021 21:11:44'!
cartadelPieEnElEncuentroActual
	
	^estado cartadelPie
	! !

!Ronda methodsFor: 'atributos' stamp: 'f 7/5/2021 19:48:55'!
cartasDeLaMano

	^mano! !

!Ronda methodsFor: 'atributos' stamp: 'f 7/5/2021 19:48:44'!
cartasDelPie

	^pie! !

!Ronda methodsFor: 'atributos' stamp: 'f 7/5/2021 18:20:15'!
getCartaMano

	|carta|
	carta := mano last.
	mano removeLast.
	^carta
	! !

!Ronda methodsFor: 'atributos' stamp: 'f 7/5/2021 18:20:28'!
getCartaPie

	|carta|
	carta := pie last.
	pie removeLast.
	^carta
	! !


!Ronda methodsFor: 'jugada' stamp: 'f 7/5/2021 19:03:11'!
juegaMano

	estado juegaMano.

	! !

!Ronda methodsFor: 'jugada' stamp: 'f 7/5/2021 19:03:00'!
juegaPie

	estado juegaPie.

	! !


!Ronda methodsFor: 'inicializacion' stamp: 'f 7/5/2021 19:26:31'!
initWithPie: anOrderedCollectionWithcards andHand: anotherOrderedCollectionWithCards

	pie:= anOrderedCollectionWithcards.
	mano:= anotherOrderedCollectionWithCards.
	estado:= EstadoInicial initFor:self.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ronda class' category: 'ISW1-2021-1C-2doParcial'!
Ronda class
	instanceVariableNames: ''!

!Ronda class methodsFor: 'inicializacion' stamp: 'f 7/5/2021 19:47:14'!
initconLasCartasdelPie: anOrderedCollectionWithcards yLasCartasdeLaMano:anotherOrderedCollectionWithCards
		
	((anOrderedCollectionWithcards size = 3) and: [anotherOrderedCollectionWithCards size = 3]) 
	ifFalse:[^self error: Ronda not3cardsInonedeckError.].
	
	
	^self new initWithPie: anOrderedCollectionWithcards andHand: anotherOrderedCollectionWithCards.
	
	! !


!Ronda class methodsFor: 'errores' stamp: 'f 7/5/2021 17:47:36'!
not3cardsInonedeckError

	^'Al menos una de las dos manos tiene mas o menos de tres cartas'! !
