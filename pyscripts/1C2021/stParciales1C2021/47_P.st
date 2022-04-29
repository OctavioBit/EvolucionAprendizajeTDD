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


!classDefinition: #ManoTest category: 'ISW1-2021-1C-2doParcial'!
TestCase subclass: #ManoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!ManoTest methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 18:57:17'!
assert: aBlockClosureToEvaluete raiseErrorWithText: aErrorString 

	self should: [ aBlockClosureToEvaluete value. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: aErrorString.
	! !

!ManoTest methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 19:01:22'!
test01	
	
	self assert: [ ManoDeTruco con: CartaDeTruco anchoDeBasto con: CartaDeTruco anchoDeEspada con: CartaDeTruco anchoDeBasto ]
		raiseErrorWithText: ManoDeTruco cartaRepetidaErrorDescription.	
	! !

!ManoTest methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 19:15:12'!
test02
	
	| mano1 mano2 |
	mano1 := ManoDeTruco con: CartaDeTruco anchoDeBasto con: CartaDeTruco anchoDeEspada con: CartaDeTruco sieteDeOro. 
	
	mano2 := ManoDeTruco con: CartaDeTruco anchoDeBasto con: CartaDeTruco anchoDeEspada con: CartaDeTruco sieteDeOro. 
	
	self assert: (mano1 puedeEnfrentarseA: mano2) equals: false.! !

!ManoTest methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 19:20:20'!
test03
	
	| mano1 mano2 |
	mano1 := ManoDeTruco con: CartaDeTruco anchoDeBasto con: CartaDeTruco anchoDeEspada con: CartaDeTruco sieteDeOro. 
	
	mano2 := ManoDeTruco con: (CartaDeTruco oroCon: 4) con: (CartaDeTruco oroCon: 5) con: (CartaDeTruco oroCon: 6). 
	
	self assert: (mano1 puedeEnfrentarseA: mano2) equals: true.! !


!classDefinition: #RondaTest category: 'ISW1-2021-1C-2doParcial'!
TestCase subclass: #RondaTest
	instanceVariableNames: 'stubs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaTest methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 18:10:35'!
assert: aBlockClosureToEvaluete raiseErrorWithText: aErrorString 

	self should: [ aBlockClosureToEvaluete value. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: aErrorString.
	! !

!RondaTest methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 18:06:47'!
setUp

	stubs := TrucoTestStubs new.! !

!RondaTest methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 20:17:16'!
test01ElPieNoJuegaPrimeroEnElPrimerEnfrentamiento
	| manoDeMano manoDePie ronda |
	manoDeMano := stubs mano3Oro12Oro6Espada.
	manoDePie := stubs mano3Basto12Espada6Copa.
	
	ronda := Ronda mano: manoDeMano pie: manoDePie. 

	self assert: [ ronda pieJuega: 	CartaDeTruco anchoDeEspada. ]
		raiseErrorWithText: Enfrentamiento noEsTuTurnoErrorDescription.	
	! !

!RondaTest methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 20:17:45'!
test02LaManoNoPuedeJugar2VecesSeguidas
	| manoDeMano manoDePie ronda |
	manoDeMano := stubs mano3Oro12Oro6Espada .
	manoDePie := stubs mano3Basto12Espada6Copa .
	
	ronda := Ronda mano: manoDeMano pie: manoDePie. 
	ronda manoJuega: 	manoDeMano primera.
	
	self assert: [ ronda manoJuega: 	manoDeMano segunda. ]
		raiseErrorWithText: Enfrentamiento noEsTuTurnoErrorDescription.	
	! !

!RondaTest methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 20:18:56'!
test03ManosIncompatiblesNoPuedenEnfrentarse
	| manoDeMano manoDePie |
	manoDeMano := stubs manoConUnaSolaBuena.
	manoDePie := stubs manoConUnaSolaBuena .
	
	self assert: [ Ronda mano: manoDeMano pie: manoDePie ] 
		raiseErrorWithText: Ronda manosIncompatiblesErrorDescription . ! !

!RondaTest methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 19:29:51'!
test04
	| manoDeMano manoDePie |
	manoDeMano := stubs manoUltraFuerte .
	manoDePie := stubs manoConUnaSolaBuena.
	
	self assert: [ Ronda mano: manoDeMano pie: manoDePie ] 
		raiseErrorWithText: Ronda manosIncompatiblesErrorDescription .! !

!RondaTest methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 20:32:19'!
test05MayorCartaGanaUnEnfrentamiento
	| manoDeMano manoDePie ronda |
	manoDeMano := stubs mano3Oro12Oro6Espada.
	manoDePie := stubs mano3Basto12Espada6Copa.
	
	ronda := Ronda mano: manoDeMano pie: manoDePie.
	
	ronda manoJuega: manoDeMano primera.
	ronda pieJuega: manoDePie segunda.
	
	self assert: ronda ganadasPorMano equals: 1.
	self assert: ronda ganadasPorPie equals: 0.! !

!RondaTest methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 20:42:36'!
test06GanarDosEnfrentamientosSeguidosGanaLaRonda
	| manoDeMano manoDePie ronda |
	manoDeMano := stubs mano3Oro12Oro6Espada.
	manoDePie := stubs mano3Basto12Espada6Copa.
	
	ronda := Ronda mano: manoDeMano pie: manoDePie.
	
	ronda manoJuega: manoDeMano primera.
	ronda pieJuega: manoDePie segunda.
	
	ronda manoJuega: manoDeMano segunda.
	ronda pieJuega: manoDePie tercera.
	
	self assert: ronda ganadasPorMano equals: 2.
	self assert: ronda ganadasPorPie equals: 0.
	self assert: ronda ganoMano equals: true.! !

!RondaTest methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 21:36:34'!
test07
	| manoDeMano manoDePie ronda |
	manoDeMano := stubs mano3Oro12Oro6Espada.
	manoDePie := stubs mano3Basto12Espada6Copa.
	
	ronda := Ronda mano: manoDeMano pie: manoDePie.
	
	ronda manoJuega: manoDeMano segunda.
	ronda pieJuega: manoDePie primera.
	
	ronda pieJuega: manoDePie segunda.
	ronda manoJuega: manoDeMano tercera .
	
	self assert: ronda ganadasPorMano equals: 0.
	self assert: ronda ganadasPorPie equals: 2.
	self assert: ronda ganoPie equals: true.! !


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
	instanceVariableNames: 'juegoMano juegoPie resultado'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Enfrentamiento methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 21:47:24'!
calcularResultado
	
	(juegoMano mataA: juegoPie)	ifTrue: [
		^1
	].

	(juegoPie mataA: juegoMano) 	ifTrue: [
		^-1
	].

	^0.! !

!Enfrentamiento methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 21:51:44'!
empardaron
	^resultado = 0.! !

!Enfrentamiento methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 21:13:37'!
ganoMano
	^resultado = 1.! !

!Enfrentamiento methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 21:51:51'!
ganoPie
	^resultado = -1.! !

!Enfrentamiento methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 21:42:16'!
getNextEnfrentamiento
	
	
	(resultado = -1) ifTrue: [
		^EnfrentamientoEmpiezaPie new.	
	].

	^EnfrentamientoEmpiezaMano new.	

	! !

!Enfrentamiento methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 19:54:59'!
pieJuega: aCartaDeTruco 
	self subclassResponsibility.! !

!Enfrentamiento methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 21:54:55'!
termino
	^(self yaJugoMano) and: (self yaJugoPie).! !

!Enfrentamiento methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 20:37:33'!
yaJugoMano

	^juegoMano ~= nil! !

!Enfrentamiento methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 21:05:41'!
yaJugoPie

	^juegoPie ~= nil.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Enfrentamiento class' category: 'ISW1-2021-1C-2doParcial'!
Enfrentamiento class
	instanceVariableNames: ''!

!Enfrentamiento class methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 19:54:41'!
noEsTuTurnoErrorDescription
	^'No es tu turno!!'.! !


!classDefinition: #EnfrentamientoEmpiezaMano category: 'ISW1-2021-1C-2doParcial'!
Enfrentamiento subclass: #EnfrentamientoEmpiezaMano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!EnfrentamientoEmpiezaMano methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 20:38:51'!
manoJuega: aCartaDeTruco 
	(self yaJugoMano) ifTrue: [ self error: self class noEsTuTurnoErrorDescription ].
	
	juegoMano := 	aCartaDeTruco.! !

!EnfrentamientoEmpiezaMano methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 20:49:14'!
pieJuega: aCartaDeTruco 
	(self yaJugoMano) ifFalse: [ self error: self class noEsTuTurnoErrorDescription.	 ].

	juegoPie := aCartaDeTruco.
	
	
	resultado := self calcularResultado.
	! !


!classDefinition: #EnfrentamientoEmpiezaPie category: 'ISW1-2021-1C-2doParcial'!
Enfrentamiento subclass: #EnfrentamientoEmpiezaPie
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!EnfrentamientoEmpiezaPie methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 21:48:41'!
manoJuega: aCartaDeTruco 
		
	(self yaJugoPie) ifFalse: [ self error: self class noEsTuTurnoErrorDescription ].
	
	juegoMano := 	aCartaDeTruco.
	
	resultado := self calcularResultado.
	! !

!EnfrentamientoEmpiezaPie methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 21:48:12'!
pieJuega: aCartaDeTruco 
	(self yaJugoPie) ifTrue: [ self error: self class noEsTuTurnoErrorDescription.	 ].

	juegoPie := aCartaDeTruco.
! !


!classDefinition: #ManoDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #ManoDeTruco
	instanceVariableNames: 'cartaDeTruco cartaDeTruco2 cartaDeTruco3 mano'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!ManoDeTruco methodsFor: 'initialization' stamp: 'AW 7/5/2021 19:09:46'!
initializeCon: aCartaDeTruco con: aCartaDeTruco2 con: aCartaDeTruco3 
	
	
	mano := OrderedCollection with: aCartaDeTruco with: aCartaDeTruco2 with: aCartaDeTruco3.
	
	(self hayRepetidas) ifTrue: [ self error: self class cartaRepetidaErrorDescription ].
	! !


!ManoDeTruco methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 19:09:05'!
hayRepetidas
	
	^mano asSet size < 3.! !

!ManoDeTruco methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 19:36:59'!
primera
	^mano first.! !

!ManoDeTruco methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 19:17:39'!
puedeEnfrentarseA: aManoDeTruco 
	^(aManoDeTruco tieneAlguna: mano) not.! !

!ManoDeTruco methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 19:36:44'!
segunda
	^mano second.! !

!ManoDeTruco methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 21:02:42'!
tercera
	^mano third.! !

!ManoDeTruco methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 19:18:55'!
tieneAlguna: unaCollecionDeCartasDeTruco 
	^unaCollecionDeCartasDeTruco includesAnyOf: mano.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ManoDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
ManoDeTruco class
	instanceVariableNames: ''!

!ManoDeTruco class methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 18:55:14'!
cartaRepetidaErrorDescription
	^'Hay almenos una carta repetida!!'! !


!ManoDeTruco class methodsFor: 'instance creation' stamp: 'AW 7/5/2021 18:58:55'!
con: aCartaDeTruco con: aCartaDeTruco2 con: aCartaDeTruco3 

	^self new initializeCon: aCartaDeTruco con: aCartaDeTruco2 con: aCartaDeTruco3 ! !


!classDefinition: #Ronda category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #Ronda
	instanceVariableNames: 'manoDeMano manoDePie enfrentamientos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Ronda methodsFor: 'initialization' stamp: 'AW 7/5/2021 19:55:46'!
initializeMano: unaManoDeMano pie: unaManoDePie 
	
	(unaManoDeMano puedeEnfrentarseA: unaManoDePie) ifFalse: [
		^self error: self class manosIncompatiblesErrorDescription. ].

	manoDeMano := unaManoDeMano.
	manoDePie := unaManoDePie.
	enfrentamientos := OrderedCollection with: EnfrentamientoEmpiezaMano new.
	! !


!Ronda methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 19:50:48'!
enfrentamientoActual
	
	^enfrentamientos last.! !

!Ronda methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 21:15:29'!
ganadasPorMano 
	^enfrentamientos sum: [ :enfrentamiento | 
		self puntosParaManoPorEnfrentamiento: enfrentamiento.
	]! !

!Ronda methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 21:50:24'!
ganadasPorPie
	^enfrentamientos sum: [ :enfrentamiento | 
		self puntosParaPiePorEnfrentamiento: enfrentamiento.
	]! !

!Ronda methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 21:32:34'!
ganoMano
	^self ganadasPorMano > 1.! !

!Ronda methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 21:55:24'!
ganoPie
	^self ganadasPorPie > 1.! !

!Ronda methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 21:43:11'!
getNextEnfrentamiento: anEnfrentamiento 
	^anEnfrentamiento getNextEnfrentamiento.! !

!Ronda methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 20:04:12'!
manoGanoPrimera
	
	enfrentamientos first ganoMano.! !

!Ronda methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 20:35:15'!
manoJuega: aCartaDeTruco 
	
	
	self enfrentamientoActual manoJuega: aCartaDeTruco.
	! !

!Ronda methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 21:38:18'!
pieJuega: unaCartaDeTruco 
	
	| enfrentamiento |
	enfrentamiento := self enfrentamientoActual.
	
	enfrentamiento pieJuega: unaCartaDeTruco.
	
	(enfrentamiento termino) ifTrue: [
		enfrentamientos add: (self getNextEnfrentamiento: enfrentamiento).
	]
	! !

!Ronda methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 21:16:11'!
puntosParaManoPorEnfrentamiento: enfrentamiento

	enfrentamiento ganoMano 
		ifTrue: [ ^1 ].
		
	^0.! !

!Ronda methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 21:51:01'!
puntosParaPiePorEnfrentamiento: enfrentamiento

	enfrentamiento ganoPie 
		ifTrue: [ ^1 ].
		
	^0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ronda class' category: 'ISW1-2021-1C-2doParcial'!
Ronda class
	instanceVariableNames: ''!

!Ronda class methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 19:29:16'!
manosIncompatiblesErrorDescription
	
	^'Las manos son incompatibles!!'! !


!Ronda class methodsFor: 'instance creation' stamp: 'AW 7/5/2021 17:45:30'!
mano: manoDeMano pie: manoDePie 


	^self new initializeMano: manoDeMano pie: manoDePie! !


!classDefinition: #TrucoTestStubs category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #TrucoTestStubs
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!TrucoTestStubs methodsFor: 'accessing' stamp: 'AW 7/5/2021 19:21:34'!
manoCon: aCartaDeTruco con: aCartaDeTruco2 con: aCartaDeTruco3 
	^ManoDeTruco con: aCartaDeTruco con: aCartaDeTruco2 con: aCartaDeTruco3.! !

!TrucoTestStubs methodsFor: 'accessing' stamp: 'AW 7/5/2021 19:30:40'!
manoConUnaSolaBuena
	^ManoDeTruco con: CartaDeTruco anchoDeBasto con: (CartaDeTruco oroCon: 6) con: (CartaDeTruco bastoCon: 4).
! !

!TrucoTestStubs methodsFor: 'accessing' stamp: 'AW 7/5/2021 19:30:49'!
manoUltraFuerte
	^ManoDeTruco con: CartaDeTruco anchoDeEspada con: CartaDeTruco sieteDeEspada con: CartaDeTruco anchoDeBasto .
	! !


!TrucoTestStubs methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 19:40:58'!
mano3Basto12Espada6Copa
	^ManoDeTruco con: (CartaDeTruco bastoCon: 3) con: (CartaDeTruco espadaCon: 12) con: (CartaDeTruco copaCon: 6) ! !

!TrucoTestStubs methodsFor: 'as yet unclassified' stamp: 'AW 7/5/2021 19:40:39'!
mano3Oro12Oro6Espada
	^ManoDeTruco con: (CartaDeTruco oroCon: 3) con: (CartaDeTruco oroCon: 12) con: (CartaDeTruco espadaCon: 6) ! !
