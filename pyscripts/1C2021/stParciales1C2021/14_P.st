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
	instanceVariableNames: 'cartasMano cartasPie cartasGanadoras cartasPerdedoras'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'AM 7/5/2021 21:19:37'!
setUp
	
	cartasGanadoras:={CartaDeTruco anchoDeEspada . CartaDeTruco  anchoDeBasto . CartaDeTruco espadaCon: 7} asOrderedCollection .
	cartasPerdedoras :={CartaDeTruco espadaCon: 4. CartaDeTruco  oroCon: 4 . CartaDeTruco bastoCon: 4} asOrderedCollection .! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'AM 7/5/2021 21:20:01'!
test01LaManoNoPuedeJugarUnaCartaQueNoTiene
	|rondaDeTruco|
	
	cartasMano:=cartasGanadoras.
	cartasPie:= cartasPerdedoras.
	
	rondaDeTruco:= RondaDeTruco manoConCartas: cartasMano pieConCartas: cartasPie.
	
	self 
		should: [ rondaDeTruco manoJuegaCarta: (CartaDeTruco espadaCon: 5)]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RondaDeTruco laManoNoTieneEsaCartaError. 
			self assert: rondaDeTruco cartasMano = cartasMano.
			self assert: rondaDeTruco cartasPie = cartasPie.
			
			].
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'AM 7/5/2021 21:20:07'!
test02ElPieNoPuedeEmpezarLaPrimeraRonda
	|rondaDeTruco|
	
	cartasMano:=cartasGanadoras.
	cartasPie:= cartasPerdedoras.
	
	rondaDeTruco:= RondaDeTruco manoConCartas: cartasMano pieConCartas: cartasPie.
	
	self 
		should: [ rondaDeTruco pieJuegaCarta: (cartasPie anyOne)]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RondaDeTruco noEsTurnoDelPie. 
			self assert: rondaDeTruco cartasMano = cartasMano.
			self assert: rondaDeTruco cartasPie = cartasPie.]
	
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'AM 7/5/2021 21:20:15'!
test03LaManoNoPuedeTirarOtraCartaAntesQueElPieEnLaPrimeraRonda
	|rondaDeTruco|
	cartasMano:=cartasGanadoras.
	cartasPie:= cartasPerdedoras.
	
	rondaDeTruco:= RondaDeTruco manoConCartas: cartasMano pieConCartas: cartasPie.
		rondaDeTruco manoJuegaCarta: (cartasMano at: 1).
	
	
	self 
		should: [ rondaDeTruco manoJuegaCarta: (cartasMano at: 2).]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RondaDeTruco noEsTurnoDeLaMano.
			self assert: rondaDeTruco cartasMano = (cartasMano copyFrom: 2 to: 3).
			self assert: rondaDeTruco cartasPie = cartasPie.] 
	
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'AM 7/5/2021 21:21:13'!
test04ElPieNoPuedeJugarUnaCartaQueNoTiene
	|rondaDeTruco|
	
	cartasMano:=cartasGanadoras.
	cartasPie:= cartasPerdedoras.
	
	rondaDeTruco:= RondaDeTruco manoConCartas: cartasMano pieConCartas: cartasPie.
	rondaDeTruco manoJuegaCarta: (cartasMano at:1).
	self 
		should: [ rondaDeTruco pieJuegaCarta: (CartaDeTruco espadaCon: 5)]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RondaDeTruco elPieNoTieneEsaCartaError.
			self assert: rondaDeTruco cartasMano = (cartasMano copyFrom: 2 to: 3).
			self assert: rondaDeTruco cartasPie = cartasPie.
			] 
	
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'AM 7/5/2021 21:21:17'!
test05LaManoNoPuedeJugarDosVecesLaMismaCarta
	|rondaDeTruco|
	
	cartasMano:=cartasGanadoras.
	cartasPie:= cartasPerdedoras.
	
	rondaDeTruco:= RondaDeTruco manoConCartas: cartasMano pieConCartas: cartasPie.
	rondaDeTruco manoJuegaCarta: (cartasMano at: 1).
	rondaDeTruco pieJuegaCarta: (cartasPie at: 1).
	
	self 
		should: [ rondaDeTruco manoJuegaCarta: (cartasMano at: 1).]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RondaDeTruco laManoNoTieneEsaCartaError. 
			self assert: rondaDeTruco cartasMano = (cartasMano copyFrom: 2 to: 3).
			self assert: rondaDeTruco cartasPie = (cartasPie copyFrom: 2 to: 3).
			]
	
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'AM 7/5/2021 21:24:49'!
test06LaManoNoPuedeEmpezarSegundaRondaSiLaPrimeraLaGanaElPie
	|rondaDeTruco|
	
	
	cartasMano :=cartasPerdedoras.
	cartasPie := cartasGanadoras.
	
	
	rondaDeTruco:= RondaDeTruco manoConCartas: cartasMano pieConCartas: cartasPie .
	rondaDeTruco manoJuegaCarta: (cartasMano at:1).
	rondaDeTruco pieJuegaCarta: (cartasPie at: 1).
	
	self 
		should: [ rondaDeTruco manoJuegaCarta: (cartasMano at: 2) ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals:RondaDeTruco noEsTurnoDeLaMano .
			self assert: rondaDeTruco cartasMano = (cartasMano copyFrom: 2 to: 3).
			self assert: rondaDeTruco cartasPie = (cartasPie copyFrom: 2 to: 3).
			 ]
	
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'AM 7/5/2021 21:25:26'!
test07ElPieNoPuedeJugarDosVecesLaMismaCarta
	|rondaDeTruco|
	
	
	cartasMano :=cartasPerdedoras.
	cartasPie := cartasGanadoras.
	rondaDeTruco:= RondaDeTruco manoConCartas: cartasMano pieConCartas: cartasPie .
	rondaDeTruco manoJuegaCarta: (cartasMano at: 1).
	rondaDeTruco pieJuegaCarta: (cartasPie at: 1).
	
	self 
		should: [ rondaDeTruco pieJuegaCarta: (cartasPie at: 1).]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals:RondaDeTruco elPieNoTieneEsaCartaError.
			self assert: rondaDeTruco cartasMano = (cartasMano copyFrom: 2 to: 3).
			self assert: rondaDeTruco cartasPie = (cartasPie copyFrom: 2 to: 3).
			]
	
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'AM 7/5/2021 21:21:29'!
test08ElPieNoPuedeEmpezarSegundaRondaSiLaPrimeraLaGanaLaMano
	|rondaDeTruco|

	cartasMano:=cartasGanadoras.
	cartasPie:= cartasPerdedoras.
	rondaDeTruco:= RondaDeTruco manoConCartas: cartasMano pieConCartas: cartasPie .
	rondaDeTruco manoJuegaCarta: (cartasMano at:1).
	rondaDeTruco pieJuegaCarta: (cartasPie at: 1).
	
	self 
		should: [ rondaDeTruco pieJuegaCarta: (cartasPie at: 2) ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RondaDeTruco noEsTurnoDelPie .
			self assert: rondaDeTruco cartasMano = (cartasMano copyFrom: 2 to: 3).
			self assert: rondaDeTruco cartasPie = (cartasPie copyFrom: 2 to: 3).
			 ]
	
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'AM 7/5/2021 21:25:56'!
test09ElPieNoPuedeEmpezarSegundaRondaSiEmpardaronLaPrimera
	|rondaDeTruco|
	
	
	
	cartasMano:={CartaDeTruco bastoCon: 3. CartaDeTruco bastoCon: 4. CartaDeTruco bastoCon: 6} asOrderedCollection.
	cartasPie:={CartaDeTruco espadaCon: 3. CartaDeTruco espadaCon: 4. CartaDeTruco espadaCon: 6} asOrderedCollection .
	
	rondaDeTruco:= RondaDeTruco manoConCartas: cartasMano pieConCartas: cartasPie .
	rondaDeTruco manoJuegaCarta: (cartasMano at:1).
	rondaDeTruco pieJuegaCarta: (cartasPie at: 1).
	
	self 
		should: [ rondaDeTruco pieJuegaCarta: (cartasPie at: 2) ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals:RondaDeTruco noEsTurnoDelPie
			] 
	
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'AM 7/5/2021 21:21:38'!
test10ElPieNoPuedeJugarDosVecesSeguidasLaSegundaManoSiGanaLaPrimera
	|rondaDeTruco |
	
	cartasMano:=cartasGanadoras.
	cartasPie:= cartasPerdedoras.
	
	
	rondaDeTruco:= RondaDeTruco manoConCartas: cartasPie pieConCartas: cartasMano .
	rondaDeTruco manoJuegaCarta: (cartasPie at:1).
	rondaDeTruco pieJuegaCarta: (cartasMano at: 1).
	rondaDeTruco pieJuegaCarta: (cartasMano at:2).

	self 
		should: [ rondaDeTruco pieJuegaCarta: (cartasMano at: 3) ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RondaDeTruco noEsTurnoDelPie .
			self assert: rondaDeTruco cartasMano = (cartasPie copyFrom: 2 to: 3).
			self assert: rondaDeTruco cartasPie = (cartasMano copyFrom: 3 to: 3).
			 ]
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'AM 7/5/2021 21:26:27'!
test12ElPieNoPuedeEmpezarLaTerceraRondaSiLaPrimeraGanaElPieyLaSegundaLaMano
	|rondaDeTruco |
	
	
	cartasPie :={CartaDeTruco anchoDeBasto . CartaDeTruco oroCon: 3 . CartaDeTruco espadaCon: 5} asOrderedCollection .
	cartasMano :={CartaDeTruco bastoCon: 5. CartaDeTruco  anchoDeBasto . CartaDeTruco espadaCon: 6} asOrderedCollection .
	
	rondaDeTruco:= RondaDeTruco manoConCartas: cartasMano pieConCartas: cartasPie .
	rondaDeTruco manoJuegaCarta: (cartasMano at:1).
	rondaDeTruco pieJuegaCarta: (cartasPie at: 1).
	rondaDeTruco pieJuegaCarta: (cartasPie at:2).
	rondaDeTruco manoJuegaCarta: (cartasMano at:2).

	self 
		should: [ rondaDeTruco pieJuegaCarta: (cartasPie at: 3) ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RondaDeTruco noEsTurnoDelPie .
			self assert: rondaDeTruco cartasMano = (cartasMano copyFrom: 3 to: 3).
			self assert: rondaDeTruco cartasPie = (cartasPie copyFrom: 3 to: 3).
			 ]
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'AM 7/5/2021 21:21:47'!
test13SiLaManoGanaLasPrimerasDosRondaEsLaGanadora
	|rondaDeTruco |
	
	cartasMano:=cartasGanadoras.
	cartasPie:= cartasPerdedoras.
	
	rondaDeTruco:= RondaDeTruco manoConCartas: cartasMano pieConCartas: cartasPie .
	rondaDeTruco manoJuegaCarta: (cartasMano at:1).
	rondaDeTruco pieJuegaCarta: (cartasPie at: 1).
	rondaDeTruco manoJuegaCarta: (cartasMano at:2).
	rondaDeTruco pieJuegaCarta: (cartasPie at:2).

	
	self assert: (rondaDeTruco ganador = 'Mano').
	self assert: rondaDeTruco cartasMano = (cartasMano copyFrom: 3 to: 3).
	self assert: rondaDeTruco cartasPie = (cartasPie copyFrom: 3 to: 3).
	
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'AM 7/5/2021 21:26:42'!
test14SiElPieGanaLasPrimerasDosRondaEsElGanador
	|rondaDeTruco |
	
	
	cartasMano:=cartasGanadoras.
	cartasPie:= cartasPerdedoras.
	
	
	rondaDeTruco:= RondaDeTruco manoConCartas: cartasPie pieConCartas: cartasMano .
	rondaDeTruco manoJuegaCarta: (cartasPie at:1).
	rondaDeTruco pieJuegaCarta: (cartasMano at: 1).
	rondaDeTruco pieJuegaCarta: (cartasMano at:2).
	rondaDeTruco manoJuegaCarta: (cartasPie at:2).

	
	self assert: (rondaDeTruco ganador = 'Pie').
	self assert: rondaDeTruco cartasMano = (cartasPie copyFrom: 3 to: 3).
	self assert: rondaDeTruco cartasPie = (cartasMano copyFrom: 3 to: 3).
	
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'AM 7/5/2021 21:49:10'!
test15SiEmpardanEnLaPrimeraYGanaManoGanaMano
		|rondaDeTruco cartasMano1 cartasPie1 |
		
	cartasMano:=cartasGanadoras.
	cartasPie:= cartasPerdedoras.
	
	cartasPie1 :={CartaDeTruco oroCon: 3. CartaDeTruco oroCon: 3 . CartaDeTruco espadaCon: 5} asOrderedCollection .
	cartasMano1 :={CartaDeTruco bastoCon: 3. CartaDeTruco  anchoDeBasto . CartaDeTruco espadaCon: 6} asOrderedCollection .
	
	rondaDeTruco:= RondaDeTruco manoConCartas: cartasMano1 pieConCartas: cartasPie1 .
	rondaDeTruco manoJuegaCarta: (cartasMano1 at:1).
	rondaDeTruco pieJuegaCarta: (cartasPie1 at: 1).
	rondaDeTruco manoJuegaCarta: (cartasMano1 at:2).
	rondaDeTruco pieJuegaCarta: (cartasPie1 at:2).

	self assert: (rondaDeTruco ganador = 'Mano').! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'AM 7/5/2021 21:21:57'!
test16SiEmpardanEnLaPrimeraYGanaPieGanaPie
		|rondaDeTruco cartasMano1 cartasPie1 |
	
	
	cartasMano:=cartasGanadoras.
	cartasPie:= cartasPerdedoras.
	cartasMano1 :={CartaDeTruco oroCon: 3. CartaDeTruco oroCon: 3 . CartaDeTruco espadaCon: 5} asOrderedCollection .
	cartasPie1 :={CartaDeTruco bastoCon: 3. CartaDeTruco  anchoDeBasto . CartaDeTruco espadaCon: 6} asOrderedCollection .
	
	rondaDeTruco:= RondaDeTruco manoConCartas: cartasMano1 pieConCartas: cartasPie1 .
	rondaDeTruco manoJuegaCarta: (cartasMano1 at:1).
	rondaDeTruco pieJuegaCarta: (cartasPie1 at: 1).
	rondaDeTruco manoJuegaCarta: (cartasMano1 at:2).
	rondaDeTruco pieJuegaCarta: (cartasPie1 at:2).

	self assert: (rondaDeTruco ganador = 'Pie').! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'AM 7/5/2021 21:43:30'!
test17NoSePuedeSeguirJugandoDespuesDeQueHayUnGanadorParda
		|rondaDeTruco cartasMano1 cartasPie1 |
		
		
	cartasMano:=cartasGanadoras.
	cartasPie:= cartasPerdedoras.
	
	cartasMano1 :={CartaDeTruco oroCon: 3. CartaDeTruco oroCon: 3 . CartaDeTruco espadaCon: 5} asOrderedCollection .
	cartasPie1 :={CartaDeTruco bastoCon: 3. CartaDeTruco  anchoDeBasto . CartaDeTruco espadaCon: 6} asOrderedCollection .
	
	rondaDeTruco:= RondaDeTruco manoConCartas: cartasMano1 pieConCartas: cartasPie1 .
	rondaDeTruco manoJuegaCarta: (cartasMano1 at:1).
	rondaDeTruco pieJuegaCarta: (cartasPie1 at: 1).
	rondaDeTruco manoJuegaCarta: (cartasMano1 at:2).
	rondaDeTruco pieJuegaCarta: (cartasPie1 at:2).

	self 
		should: [ rondaDeTruco pieJuegaCarta: (cartasPie1 at: 3) ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RondaDeTruco rondaFinalizadaError .
			self assert: rondaDeTruco cartasMano = (cartasMano1 copyFrom: 3 to: 3) .
			self assert: rondaDeTruco cartasPie = (cartasPie1 copyFrom: 3 to: 3).
			 ]! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'AM 7/5/2021 21:45:33'!
test18NoSePuedeSeguirJugandoDespuesDeQueHayUnGanadorDosManosSeguidas
		|rondaDeTruco |
		
		
	cartasMano:=cartasGanadoras.
	cartasPie:= cartasPerdedoras.

	
	rondaDeTruco:= RondaDeTruco manoConCartas: cartasMano pieConCartas: cartasPie .
	rondaDeTruco manoJuegaCarta: (cartasMano at:1).
	rondaDeTruco pieJuegaCarta: (cartasPie at: 1).
	rondaDeTruco manoJuegaCarta: (cartasMano at:2).
	rondaDeTruco pieJuegaCarta: (cartasPie at:2).

	self 
		should: [ rondaDeTruco pieJuegaCarta: (cartasPie at: 3) ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RondaDeTruco rondaFinalizadaError .
			self assert: rondaDeTruco cartasMano = (cartasMano copyFrom: 3 to: 3) .
			self assert: rondaDeTruco cartasPie = (cartasPie copyFrom: 3 to: 3).
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


!classDefinition: #EnfrentamientoDeTrucoEmpiezaState category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #EnfrentamientoDeTrucoEmpiezaState
	instanceVariableNames: 'rondaDeTruco'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!EnfrentamientoDeTrucoEmpiezaState methodsFor: 'initialization' stamp: 'AM 7/5/2021 19:31:38'!
initializeParaRonda: aRondaDeTruco 
	rondaDeTruco := aRondaDeTruco.! !


!EnfrentamientoDeTrucoEmpiezaState methodsFor: 'jugar' stamp: 'AM 7/5/2021 21:37:09'!
manoJuegaCarta: aCartaDeTruco 
	self subclassResponsibility ! !

!EnfrentamientoDeTrucoEmpiezaState methodsFor: 'jugar' stamp: 'AM 7/5/2021 21:37:34'!
pieJuegaCarta: aCartaDeTruco 
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnfrentamientoDeTrucoEmpiezaState class' category: 'ISW1-2021-1C-2doParcial'!
EnfrentamientoDeTrucoEmpiezaState class
	instanceVariableNames: ''!

!EnfrentamientoDeTrucoEmpiezaState class methodsFor: 'instance creation' stamp: 'AM 7/5/2021 19:31:19'!
paraRonda: aRondaDeTruco 
	^self new initializeParaRonda: aRondaDeTruco ! !


!classDefinition: #EnfrentamientoDeTrucoEmpiezaMano category: 'ISW1-2021-1C-2doParcial'!
EnfrentamientoDeTrucoEmpiezaState subclass: #EnfrentamientoDeTrucoEmpiezaMano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!EnfrentamientoDeTrucoEmpiezaMano methodsFor: 'jugar' stamp: 'AM 7/5/2021 20:14:16'!
manoJuegaCarta: aCartaDeTruco 
	rondaDeTruco manoJugoCarta: aCartaDeTruco.! !

!EnfrentamientoDeTrucoEmpiezaMano methodsFor: 'jugar' stamp: 'AM 7/5/2021 19:53:59'!
pieJuegaCarta: aCartaDeTruco 
	rondaDeTruco signalNoEsTurnoDelPieError .! !


!classDefinition: #EnfrentamientoDeTrucoEmpiezaPie category: 'ISW1-2021-1C-2doParcial'!
EnfrentamientoDeTrucoEmpiezaState subclass: #EnfrentamientoDeTrucoEmpiezaPie
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!EnfrentamientoDeTrucoEmpiezaPie methodsFor: 'jugar' stamp: 'AM 7/5/2021 20:04:31'!
manoJuegaCarta: aCartaDeTruco 
	rondaDeTruco signalNoEsTurnoDeLaManoError .! !

!EnfrentamientoDeTrucoEmpiezaPie methodsFor: 'jugar' stamp: 'AM 7/5/2021 20:14:08'!
pieJuegaCarta: aCartaDeTruco
	rondaDeTruco pieJugoCarta: aCartaDeTruco .! !


!classDefinition: #EnfrentamientoDeTrucoPardoEmpiezaMano category: 'ISW1-2021-1C-2doParcial'!
EnfrentamientoDeTrucoEmpiezaState subclass: #EnfrentamientoDeTrucoPardoEmpiezaMano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!EnfrentamientoDeTrucoPardoEmpiezaMano methodsFor: 'jugar' stamp: 'AM 7/5/2021 20:48:41'!
manoJuegaCarta: aCartaDeTruco 
	rondaDeTruco manoJuegaCartaEnEnfrentamientoPardo: aCartaDeTruco .! !

!EnfrentamientoDeTrucoPardoEmpiezaMano methodsFor: 'jugar' stamp: 'AM 7/5/2021 20:57:49'!
pieJuegaCarta: aCartaDeTruco 
	rondaDeTruco signalNoEsTurnoDelPieError .! !


!classDefinition: #EnfrentamientoDeTrucoTerminaState category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #EnfrentamientoDeTrucoTerminaState
	instanceVariableNames: 'rondaDeTruco cartaJugada'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!EnfrentamientoDeTrucoTerminaState methodsFor: 'initialization' stamp: 'AM 7/5/2021 20:12:01'!
initializeCartaJugada: aCartaDeTruco paraRonda: aRondaDeTruco 
	cartaJugada := aCartaDeTruco.
	rondaDeTruco := aRondaDeTruco.! !


!EnfrentamientoDeTrucoTerminaState methodsFor: 'jugar' stamp: 'AM 7/5/2021 21:36:49'!
manoJuegaCarta: aCartaDeTruco 
		self subclassResponsibility.! !

!EnfrentamientoDeTrucoTerminaState methodsFor: 'jugar' stamp: 'AM 7/5/2021 21:37:44'!
pieJuegaCarta: aCartaDeTruco 
	self subclassResponsibility .! !


!EnfrentamientoDeTrucoTerminaState methodsFor: 'private' stamp: 'AM 7/5/2021 21:33:48'!
siGana: aCartaDeTruco contra: aCartaJugada hacer: winBlock sino: looseBlock

	(aCartaDeTruco empardaCon: aCartaJugada ) ifTrue: [rondaDeTruco empardaron] ifFalse:[
	(aCartaDeTruco mataA: aCartaJugada) ifTrue: winBlock ifFalse: looseBlock]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnfrentamientoDeTrucoTerminaState class' category: 'ISW1-2021-1C-2doParcial'!
EnfrentamientoDeTrucoTerminaState class
	instanceVariableNames: ''!

!EnfrentamientoDeTrucoTerminaState class methodsFor: 'instance creation' stamp: 'AM 7/5/2021 20:11:45'!
cartaJugada: aCartaDeTruco paraRonda: aRondaDeTruco 

	^self new initializeCartaJugada: aCartaDeTruco paraRonda: aRondaDeTruco ! !


!classDefinition: #EnfrentamientoDeTrucoTerminaMano category: 'ISW1-2021-1C-2doParcial'!
EnfrentamientoDeTrucoTerminaState subclass: #EnfrentamientoDeTrucoTerminaMano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!


!EnfrentamientoDeTrucoTerminaMano methodsFor: 'as yet unclassified' stamp: 'AM 7/5/2021 21:35:27'!
manoJuegaCarta: aCartaDeTruco 

	self  siGana: aCartaDeTruco contra: cartaJugada hacer: [rondaDeTruco  ganoManoEnfrentamiento ] sino: [rondaDeTruco ganoPieEnfrentamiento ].! !

!EnfrentamientoDeTrucoTerminaMano methodsFor: 'as yet unclassified' stamp: 'AM 7/5/2021 19:48:35'!
pieJuegaCarta: aCartaDeTruco 
	rondaDeTruco signalNoEsTurnoDelPieError .! !


!classDefinition: #EnfrentamientoDeTrucoTerminaPardoPie category: 'ISW1-2021-1C-2doParcial'!
EnfrentamientoDeTrucoTerminaState subclass: #EnfrentamientoDeTrucoTerminaPardoPie
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!EnfrentamientoDeTrucoTerminaPardoPie methodsFor: 'jugar' stamp: 'AM 7/5/2021 21:36:10'!
pieJuegaCarta: aCartaDeTruco 
	self  siGana: aCartaDeTruco contra: cartaJugada hacer: [rondaDeTruco  ganoPieRonda ] sino: [rondaDeTruco ganoManoRonda ].! !


!classDefinition: #EnfrentamientoDeTrucoTerminaPie category: 'ISW1-2021-1C-2doParcial'!
EnfrentamientoDeTrucoTerminaState subclass: #EnfrentamientoDeTrucoTerminaPie
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!


!EnfrentamientoDeTrucoTerminaPie methodsFor: 'jugar' stamp: 'AM 7/5/2021 19:54:19'!
manoJuegaCarta: aCartaDeTruco 
	rondaDeTruco signalNoEsTurnoDeLaManoError .! !

!EnfrentamientoDeTrucoTerminaPie methodsFor: 'jugar' stamp: 'AM 7/5/2021 21:34:53'!
pieJuegaCarta: aCartaDeTruco.
	 
	self  siGana: aCartaDeTruco contra: cartaJugada hacer: [rondaDeTruco  ganoPieEnfrentamiento] sino: [rondaDeTruco ganoManoEnfrentamiento].! !


!classDefinition: #RondaDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #RondaDeTruco
	instanceVariableNames: 'cartasMano cartasPie enfrentamientoActual ganadasPie ganadasMano ganador'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTruco methodsFor: 'initialization' stamp: 'AM 7/5/2021 20:35:28'!
initializeManoConCartas: cartasDeLaMano pieConCartas: cartasDelPie 
	cartasMano := cartasDeLaMano copy.
	cartasPie := cartasDelPie copy.
	enfrentamientoActual:= EnfrentamientoDeTrucoEmpiezaMano paraRonda: self .
	ganadasPie :=0.
	ganadasMano :=0.! !


!RondaDeTruco methodsFor: 'jugar' stamp: 'AM 7/5/2021 21:47:37'!
assertNoFinalizo

	^ (ganador isNil) ifFalse:[self signalRondaFInalizada ]! !

!RondaDeTruco methodsFor: 'jugar' stamp: 'AM 7/5/2021 21:47:37'!
manoJuegaCarta: aCartaDeTruco 
	self assertNoFinalizo.
	(cartasMano includes: aCartaDeTruco) ifFalse:[self signalManoNoTieneEsaCarta ].
	enfrentamientoActual manoJuegaCarta: aCartaDeTruco .
	cartasMano remove: aCartaDeTruco ! !

!RondaDeTruco methodsFor: 'jugar' stamp: 'AM 7/5/2021 21:47:44'!
pieJuegaCarta: aCartaDeTruco 
	self assertNoFinalizo.
	(cartasPie includes: aCartaDeTruco) ifFalse:[self signalPieNoTieneEsaCarta ].
	enfrentamientoActual pieJuegaCarta: aCartaDeTruco .
	cartasPie remove: aCartaDeTruco .! !


!RondaDeTruco methodsFor: 'error' stamp: 'AM 7/5/2021 17:44:54'!
signalManoNoTieneEsaCarta
	self error: self class laManoNoTieneEsaCartaError .! !

!RondaDeTruco methodsFor: 'error' stamp: 'AM 7/5/2021 17:58:54'!
signalNoEsTurnoDeLaManoError
	self error: self class noEsTurnoDeLaMano .! !

!RondaDeTruco methodsFor: 'error' stamp: 'AM 7/5/2021 17:48:41'!
signalNoEsTurnoDelPieError
	self error: self class noEsTurnoDelPie ! !

!RondaDeTruco methodsFor: 'error' stamp: 'AM 7/5/2021 18:03:17'!
signalPieNoTieneEsaCarta
	self error: self class elPieNoTieneEsaCartaError .! !


!RondaDeTruco methodsFor: 'accessing' stamp: 'AM 7/5/2021 18:50:08'!
cartasMano
	^cartasMano ! !

!RondaDeTruco methodsFor: 'accessing' stamp: 'AM 7/5/2021 18:50:14'!
cartasPie
	^cartasPie ! !

!RondaDeTruco methodsFor: 'accessing' stamp: 'AM 7/5/2021 20:57:12'!
ganador
	
	^ganador! !


!RondaDeTruco methodsFor: 'private' stamp: 'AM 7/5/2021 20:45:23'!
empardaron
	enfrentamientoActual := EnfrentamientoDeTrucoPardoEmpiezaMano paraRonda: self.! !

!RondaDeTruco methodsFor: 'private' stamp: 'AM 7/5/2021 20:49:32'!
manoJuegaCartaEnEnfrentamientoPardo: aCartaDeTruco 
	enfrentamientoActual := EnfrentamientoDeTrucoTerminaPardoPie cartaJugada: aCartaDeTruco  paraRonda: self.! !

!RondaDeTruco methodsFor: 'private' stamp: 'AM 7/5/2021 20:54:29'!
manoJugoCarta: aCartaDeTruco 
	enfrentamientoActual := EnfrentamientoDeTrucoTerminaPie cartaJugada: aCartaDeTruco paraRonda: self .! !

!RondaDeTruco methodsFor: 'private' stamp: 'AM 7/5/2021 20:11:23'!
pieJugoCarta: aCartaDeTruco 
	enfrentamientoActual := EnfrentamientoDeTrucoTerminaMano cartaJugada: aCartaDeTruco paraRonda: self .
	! !

!RondaDeTruco methodsFor: 'private' stamp: 'AM 7/5/2021 21:12:52'!
signalRondaFInalizada
	self error: self class rondaFinalizadaError! !


!RondaDeTruco methodsFor: 'finalizacion' stamp: 'AM 7/5/2021 20:56:49'!
ganoManoEnfrentamiento
	enfrentamientoActual := EnfrentamientoDeTrucoEmpiezaMano paraRonda: self.
	ganadasMano := ganadasMano +1.
	(ganadasMano = 2) ifTrue:[self ganoManoRonda].! !

!RondaDeTruco methodsFor: 'finalizacion' stamp: 'AM 7/5/2021 21:09:38'!
ganoManoRonda
	ganador:= 'Mano'.! !

!RondaDeTruco methodsFor: 'finalizacion' stamp: 'AM 7/5/2021 21:50:44'!
ganoPieEnfrentamiento
	enfrentamientoActual := EnfrentamientoDeTrucoEmpiezaPie paraRonda: self. 
	ganadasPie :=ganadasPie +1.
	(ganadasPie = 2) ifTrue:[self ganoPieRonda]! !

!RondaDeTruco methodsFor: 'finalizacion' stamp: 'AM 7/5/2021 20:51:47'!
ganoPieRonda
	ganador:= 'Pie'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RondaDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco class
	instanceVariableNames: ''!

!RondaDeTruco class methodsFor: 'instance creation' stamp: 'AM 7/5/2021 17:41:28'!
manoConCartas: cartasDeLaMano pieConCartas: cartasDelPie 
	^self new initializeManoConCartas: cartasDeLaMano pieConCartas: cartasDelPie ! !


!RondaDeTruco class methodsFor: 'error' stamp: 'AM 7/5/2021 18:00:08'!
elPieNoTieneEsaCartaError
	^'El pie no tiene esa carta'.! !

!RondaDeTruco class methodsFor: 'error' stamp: 'AM 7/5/2021 17:43:30'!
laManoNoTieneEsaCartaError
	^ 'La mano no tiene esa carta'! !

!RondaDeTruco class methodsFor: 'error' stamp: 'AM 7/5/2021 17:55:28'!
noEsTurnoDeLaMano
	^'No es el turno de la mano'.! !

!RondaDeTruco class methodsFor: 'error' stamp: 'AM 7/5/2021 17:47:51'!
noEsTurnoDelPie
	^'No es el turno del pie'.! !

!RondaDeTruco class methodsFor: 'error' stamp: 'AM 7/5/2021 21:13:10'!
rondaFinalizadaError
	^'Ronda Finalizada'.! !
