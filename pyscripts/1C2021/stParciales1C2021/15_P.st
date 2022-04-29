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

!RondaDeTrucoTest methodsFor: 'simulating' stamp: 'ijgt 7/5/2021 19:21:22'!
drawCards

	^ {CartaDeTruco anchoDeEspada. CartaDeTruco anchoDeBasto. CartaDeTruco sieteDeEspada.
	CartaDeTruco bastoCon: 4. CartaDeTruco bastoCon: 7. CartaDeTruco bastoCon: 5.}! !


!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ijgt 7/5/2021 19:21:32'!
test01_playersStartWithThreeCards

	|ronda|
	
	ronda := RondaDeTruco with: self.
	
	self assert: ronda  manoNumberOfCards equals: 3.
	self assert: ronda pieNumberOfCards equals: 3! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ijgt 7/5/2021 19:21:41'!
test02_playersCanDrawCardsFromMazo

	| ronda anchoDeEspadas |

	anchoDeEspadas := CartaDeTruco anchoDeEspada . 
	ronda := RondaDeTruco with: self.
	
	self assert: ronda manoCartas includes: anchoDeEspadas.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ijgt 7/5/2021 18:57:12'!
test03_CanNotHaveRepeatedCardsInSameRound

	self should: [RondaDeTruco with: MazoRepetido new.] 
		raise: Error 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: RondaDeTruco cantHaveRepeatedCardsInRoundErrorDescription]! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ijgt 7/5/2021 21:52:35'!
test04_encounterCanBeWon

	| ronda jugadorMano jugadorPie |
	jugadorMano := Mano withCards: {CartaDeTruco anchoDeEspada. CartaDeTruco anchoDeBasto. CartaDeTruco sieteDeEspada.}.
	jugadorPie := Pie withCards: {CartaDeTruco bastoCon: 4. CartaDeTruco bastoCon: 7. CartaDeTruco bastoCon: 5.}.
	ronda := RondaDeTruco with: self for: jugadorMano vs: jugadorPie.
	
	ronda enfrentar.
	
	self assert: ronda firstResult equals: jugadorMano.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ijgt 7/5/2021 20:41:04'!
test05_enfrentamientoGanaPie

	| ronda jugadorMano jugadorPie |
	jugadorPie := Pie withCards: {CartaDeTruco anchoDeEspada. CartaDeTruco anchoDeBasto. CartaDeTruco sieteDeEspada.}.
	jugadorMano := Mano withCards: {CartaDeTruco bastoCon: 4. CartaDeTruco bastoCon: 7. CartaDeTruco bastoCon: 5.}.
	ronda := RondaDeTruco with: self for: jugadorMano vs: jugadorPie.
	
	ronda enfrentar.
	
	self assert: ronda firstResult equals: jugadorPie! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ijgt 7/5/2021 20:41:36'!
test06_enfrentamientoEmparedado

	| ronda jugadorMano jugadorPie |
	jugadorPie := Pie withCards: {CartaDeTruco anchoDeEspada. CartaDeTruco anchoDeBasto. CartaDeTruco sieteDeEspada.}.
	jugadorMano := Mano withCards: {CartaDeTruco anchoDeEspada. CartaDeTruco anchoDeBasto. CartaDeTruco sieteDeEspada.}.
	ronda := RondaDeTruco with: self for: jugadorMano vs: jugadorPie.
	
	ronda enfrentar.
	
	self assert: ronda firstResult equals: #Empate! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ijgt 7/5/2021 21:52:06'!
test07_secondRoundCanBeWon

	| ronda jugadorMano jugadorPie |
	jugadorPie := Pie withCards: {CartaDeTruco bastoCon: 4. CartaDeTruco bastoCon: 7. CartaDeTruco bastoCon: 5.}.
	jugadorMano := Mano withCards: {CartaDeTruco anchoDeEspada. CartaDeTruco anchoDeBasto. CartaDeTruco sieteDeEspada.}.
	ronda := RondaDeTruco with: self for: jugadorMano vs: jugadorPie.
	
	ronda enfrentar.
	ronda enfrentar.
	
	self assert: ronda secondResult equals: jugadorMano.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ijgt 7/5/2021 21:52:54'!
test08_secondRoundWinForPreviousWinnerEndsGame

	| ronda jugadorMano jugadorPie |
	jugadorPie := Pie withCards: {CartaDeTruco bastoCon: 4. CartaDeTruco bastoCon: 7. CartaDeTruco bastoCon: 5.}.
	jugadorMano := Mano withCards: {CartaDeTruco anchoDeEspada. CartaDeTruco anchoDeBasto. CartaDeTruco sieteDeEspada.}.
	ronda := RondaDeTruco with: self for: jugadorMano vs: jugadorPie.
	
	ronda enfrentar.
	ronda enfrentar.
	
	self assert: ronda secondResult equals: jugadorMano.
	self should: [ronda enfrentar] 
		raise: Error 
		withMessageText: [ronda cantHaveAnEncounterOnFinishedGameErrorDescription]! !


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
	instanceVariableNames: 'primero segundo round'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Enfrentamiento methodsFor: 'decide' stamp: 'ijgt 7/5/2021 21:14:40'!
enfrentar

	|cartaFirst cartaSecond|
	
	cartaFirst := primero useCard.
	cartaSecond := segundo useCard.
	(cartaFirst mataA: cartaSecond) ifTrue: [^ round registerWinFor: primero].
	(cartaSecond mataA: cartaFirst) ifTrue: [^ round registerWinFor: segundo].
	round registerTie.! !


!Enfrentamiento methodsFor: 'initialize' stamp: 'ijgt 7/5/2021 20:54:12'!
initializeFor: aRound with: primerJugador vs: segundoJugador

	primero := primerJugador.
	segundo := segundoJugador.
	round := aRound.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Enfrentamiento class' category: 'ISW1-2021-1C-2doParcial'!
Enfrentamiento class
	instanceVariableNames: ''!

!Enfrentamiento class methodsFor: 'creation' stamp: 'ijgt 7/5/2021 20:54:12'!
for: aRound with: primerJugador vs: segundoJugador

	^ self new initializeFor: aRound with: primerJugador vs: segundoJugador! !


!classDefinition: #Jugador category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #Jugador
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Jugador methodsFor: 'testing' stamp: 'ijgt 7/5/2021 18:22:58'!
cartas

	self subclassResponsibility ! !

!Jugador methodsFor: 'testing' stamp: 'ijgt 7/5/2021 18:11:50'!
numberOfCards

	self subclassResponsibility ! !


!Jugador methodsFor: 'takeCards' stamp: 'ijgt 7/5/2021 19:07:57'!
takeCards

	self subclassResponsibility ! !


!classDefinition: #Mano category: 'ISW1-2021-1C-2doParcial'!
Jugador subclass: #Mano
	instanceVariableNames: 'cartas ronda'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Mano methodsFor: 'takeCards' stamp: 'ijgt 7/5/2021 19:58:25'!
takeCards: aCollectionOfCards

	cartas := aCollectionOfCards asOrderedCollection .! !


!Mano methodsFor: 'testing' stamp: 'ijgt 7/5/2021 18:22:45'!
cartas

	^ cartas! !

!Mano methodsFor: 'testing' stamp: 'ijgt 7/5/2021 18:34:39'!
numberOfCards

	^ cartas size! !


!Mano methodsFor: 'initialize' stamp: 'ijgt 7/5/2021 19:07:22'!
initializePlayingIn: aRonda

	ronda := aRonda.! !

!Mano methodsFor: 'initialize' stamp: 'ijgt 7/5/2021 19:58:13'!
initializeWithCards: aCollectionOfCards

	cartas := aCollectionOfCards asOrderedCollection.! !


!Mano methodsFor: 'useCard' stamp: 'ijgt 7/5/2021 19:55:07'!
useCard
	
	|card|
	
	card := cartas first.
	cartas removeFirst.
	^ card! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Mano class' category: 'ISW1-2021-1C-2doParcial'!
Mano class
	instanceVariableNames: ''!

!Mano class methodsFor: 'creation' stamp: 'ijgt 7/5/2021 18:28:12'!
playingIn: aRonda

	^ self new initializePlayingIn: aRonda! !

!Mano class methodsFor: 'creation' stamp: 'ijgt 7/5/2021 19:44:04'!
withCards: aCollectionOfCards

	^ self new initializeWithCards: aCollectionOfCards ! !


!classDefinition: #Pie category: 'ISW1-2021-1C-2doParcial'!
Jugador subclass: #Pie
	instanceVariableNames: 'cartas ronda'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Pie methodsFor: 'testing' stamp: 'ijgt 7/5/2021 18:23:13'!
cartas

	^ cartas! !

!Pie methodsFor: 'testing' stamp: 'ijgt 7/5/2021 18:34:47'!
numberOfCards

	^ cartas size! !


!Pie methodsFor: 'takeCards' stamp: 'ijgt 7/5/2021 19:01:57'!
takeCards: aCollectionOfCards

	cartas := aCollectionOfCards.! !


!Pie methodsFor: 'initialize' stamp: 'ijgt 7/5/2021 19:02:21'!
initializePlayingIn: aRonda

	ronda := aRonda.! !

!Pie methodsFor: 'initialize' stamp: 'ijgt 7/5/2021 19:58:03'!
initializeWithCards: aCollectionOfCards

	cartas := aCollectionOfCards asOrderedCollection.! !


!Pie methodsFor: 'useCard' stamp: 'ijgt 7/5/2021 19:55:27'!
useCard
	
	|card|
	
	card := cartas first.
	cartas removeFirst.
	^ card! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Pie class' category: 'ISW1-2021-1C-2doParcial'!
Pie class
	instanceVariableNames: ''!

!Pie class methodsFor: 'creation' stamp: 'ijgt 7/5/2021 18:28:37'!
playingIn: aRonda

	^ self new initializePlayingIn: aRonda! !

!Pie class methodsFor: 'creation' stamp: 'ijgt 7/5/2021 19:44:13'!
withCards: aCollectionOfCards

	^ self new initializeWithCards: aCollectionOfCards ! !


!classDefinition: #Mazo category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #Mazo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!


!classDefinition: #MazoRepetido category: 'ISW1-2021-1C-2doParcial'!
Mazo subclass: #MazoRepetido
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!MazoRepetido methodsFor: 'drawCards' stamp: 'ijgt 7/5/2021 18:59:26'!
drawCards

	^ {CartaDeTruco anchoDeEspada. CartaDeTruco anchoDeBasto. CartaDeTruco sieteDeEspada.
	CartaDeTruco anchoDeEspada. CartaDeTruco anchoDeBasto. CartaDeTruco sieteDeEspada.}! !


!classDefinition: #NumberOfRound category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #NumberOfRound
	instanceVariableNames: 'round'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!NumberOfRound methodsFor: 'initialize' stamp: 'ijgt 7/5/2021 21:44:30'!
intitalizeFor: aRound

	self subclassResponsibility ! !


!NumberOfRound methodsFor: 'register' stamp: 'ijgt 7/5/2021 21:23:25'!
registerTie

	self subclassResponsibility! !

!NumberOfRound methodsFor: 'register' stamp: 'ijgt 7/5/2021 21:23:38'!
registerWinFor: aPlayer

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NumberOfRound class' category: 'ISW1-2021-1C-2doParcial'!
NumberOfRound class
	instanceVariableNames: ''!

!NumberOfRound class methodsFor: 'creation' stamp: 'ijgt 7/5/2021 21:45:51'!
for: aRound

	^ self new intitalizeFor: aRound! !


!classDefinition: #Ended category: 'ISW1-2021-1C-2doParcial'!
NumberOfRound subclass: #Ended
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Ended methodsFor: 'as yet unclassified' stamp: 'ijgt 7/5/2021 21:44:35'!
intitalizeFor: aRound

	round := aRound! !

!Ended methodsFor: 'as yet unclassified' stamp: 'ijgt 7/5/2021 21:40:36'!
registerTie

	round gameHasEnded! !

!Ended methodsFor: 'as yet unclassified' stamp: 'ijgt 7/5/2021 21:40:51'!
registerWinFor: aPlayer

	round gameHasEnded! !


!classDefinition: #Final category: 'ISW1-2021-1C-2doParcial'!
NumberOfRound subclass: #Final
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Final methodsFor: 'as yet unclassified' stamp: 'ijgt 7/5/2021 21:44:41'!
intitalizeFor: aRound

	round := aRound! !

!Final methodsFor: 'as yet unclassified' stamp: 'ijgt 7/5/2021 21:25:59'!
registerTie

	round thirdRoundWasTied! !

!Final methodsFor: 'as yet unclassified' stamp: 'ijgt 7/5/2021 21:25:43'!
registerWinFor: aPlayer

	round thirdRoundWasWonBy: aPlayer! !


!classDefinition: #First category: 'ISW1-2021-1C-2doParcial'!
NumberOfRound subclass: #First
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!First methodsFor: 'as yet unclassified' stamp: 'ijgt 7/5/2021 21:44:47'!
intitalizeFor: aRound

	round := aRound! !

!First methodsFor: 'as yet unclassified' stamp: 'ijgt 7/5/2021 21:24:32'!
registerTie

	round firstRoundWasTied! !

!First methodsFor: 'as yet unclassified' stamp: 'ijgt 7/5/2021 21:25:03'!
registerWinFor: aPlayer

	round firstRoundWasWonBy: aPlayer! !


!classDefinition: #Second category: 'ISW1-2021-1C-2doParcial'!
NumberOfRound subclass: #Second
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Second methodsFor: 'as yet unclassified' stamp: 'ijgt 7/5/2021 21:44:52'!
intitalizeFor: aRound

	round := aRound! !

!Second methodsFor: 'as yet unclassified' stamp: 'ijgt 7/5/2021 21:26:19'!
registerTie

	round secondRoundWasTied! !

!Second methodsFor: 'as yet unclassified' stamp: 'ijgt 7/5/2021 21:25:28'!
registerWinFor: aPlayer

	round secondRoundWasWonBy: aPlayer! !


!classDefinition: #RondaDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #RondaDeTruco
	instanceVariableNames: 'mazo mano pie firstResult secondResult state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTruco methodsFor: 'initialize' stamp: 'ijgt 7/5/2021 21:43:44'!
initializeWith: unMazo

	mazo := unMazo.
	mano := Mano playingIn: self.
	pie := Pie playingIn: self.
	state := First for: self.
	self dealCards.! !

!RondaDeTruco methodsFor: 'initialize' stamp: 'ijgt 7/5/2021 21:43:51'!
initializeWith: unMazo for: jugadorMano vs: jugadorPie

	mazo := unMazo.
	mano := jugadorMano.
	pie := jugadorPie.
	state := First for: self.! !


!RondaDeTruco methodsFor: 'testing' stamp: 'ijgt 7/5/2021 18:45:10'!
manoCartas

	^ mano cartas! !

!RondaDeTruco methodsFor: 'testing' stamp: 'ijgt 7/5/2021 18:35:35'!
manoNumberOfCards

	^ mano numberOfCards! !

!RondaDeTruco methodsFor: 'testing' stamp: 'ijgt 7/5/2021 18:45:16'!
pieCartas

	^ pie cartas! !

!RondaDeTruco methodsFor: 'testing' stamp: 'ijgt 7/5/2021 18:35:45'!
pieNumberOfCards

	^ pie numberOfCards! !


!RondaDeTruco methodsFor: 'drawCards' stamp: 'ijgt 7/5/2021 19:10:22'!
dealCards

	|cardsInPlay|
	
	cardsInPlay := mazo drawCards.
	self assertCardsInPlayAreValid: cardsInPlay.
	
	mano takeCards: (cardsInPlay first: 3).
	pie takeCards: (cardsInPlay last: 3)! !


!RondaDeTruco methodsFor: 'assertions' stamp: 'ijgt 7/5/2021 19:20:07'!
assertCardsInPlayAreValid: cardsInPlay

	(self thereAreRepeatedCardsIn: cardsInPlay) ifTrue: [self error: self class cantHaveRepeatedCardsInRoundErrorDescription ]! !

!RondaDeTruco methodsFor: 'assertions' stamp: 'ijgt 7/5/2021 19:19:00'!
thereAreRepeatedCardsIn: cardsInPlay

	"No encontre una funcion apropiada para verificar que no se repitan elementos."
	cardsInPlay do: [:aCard | 
		cardsInPlay do: [:aSecondCard | ( (aCard = aSecondCard) and: (aCard == aSecondCard) not ) ifTrue: [^true]]
		].
	^ false! !


!RondaDeTruco methodsFor: 'results' stamp: 'ijgt 7/5/2021 20:41:04'!
firstResult
	
	^ firstResult! !

!RondaDeTruco methodsFor: 'results' stamp: 'ijgt 7/5/2021 20:51:12'!
secondResult

	^ secondResult! !


!RondaDeTruco methodsFor: 'finish' stamp: 'ijgt 7/5/2021 21:50:16'!
finishGame

	state := Ended for: self.! !

!RondaDeTruco methodsFor: 'finish' stamp: 'ijgt 7/5/2021 21:41:37'!
gameHasEnded

	self error: self cantHaveAnEncounterOnFinishedGameErrorDescription! !


!RondaDeTruco methodsFor: 'encounters - private' stamp: 'ijgt 7/5/2021 21:51:35'!
firstRoundWasTied

	state := Final for: self.
	firstResult := #Empate.! !

!RondaDeTruco methodsFor: 'encounters - private' stamp: 'ijgt 7/5/2021 21:32:22'!
firstRoundWasWonBy: aPlayer

	state := Second for: self.
	firstResult := aPlayer! !

!RondaDeTruco methodsFor: 'encounters - private' stamp: 'ijgt 7/5/2021 21:30:28'!
secondRoundWasTied

	self error: self cantTieSecondRoundErrorDescription! !

!RondaDeTruco methodsFor: 'encounters - private' stamp: 'ijgt 7/5/2021 21:37:58'!
secondRoundWasWonBy: aPlayer

	state := Second for: self.
	secondResult := aPlayer.
	(secondResult = firstResult) ifTrue: [self finishGame]! !

!RondaDeTruco methodsFor: 'encounters - private' stamp: 'ijgt 7/5/2021 21:30:40'!
thirdRoundWasTied

	self error: self cantTieThirdRoundErrorDescription! !

!RondaDeTruco methodsFor: 'encounters - private' stamp: 'ijgt 7/5/2021 21:38:34'!
thirdRoundWasWonBy: aPlayer

	self finishGame! !


!RondaDeTruco methodsFor: 'encounters' stamp: 'ijgt 7/5/2021 20:51:49'!
enfrentar
	
	(Enfrentamiento for: self with: mano vs: pie) enfrentar.! !

!RondaDeTruco methodsFor: 'encounters' stamp: 'ijgt 7/5/2021 21:22:55'!
registerTie

	state registerTie.! !

!RondaDeTruco methodsFor: 'encounters' stamp: 'ijgt 7/5/2021 21:16:30'!
registerWinFor: aPlayer

	state registerWinFor: aPlayer.! !


!RondaDeTruco methodsFor: 'error descriptions' stamp: 'ijgt 7/5/2021 21:42:04'!
cantHaveAnEncounterOnFinishedGameErrorDescription

	^ 'Cant have an encounter in a finished game.'! !

!RondaDeTruco methodsFor: 'error descriptions' stamp: 'ijgt 7/5/2021 21:31:05'!
cantTieSecondRoundErrorDescription

	^ 'Second round cant be tied.'! !

!RondaDeTruco methodsFor: 'error descriptions' stamp: 'ijgt 7/5/2021 21:30:57'!
cantTieThirdRoundErrorDescription

	^ 'Third round cant be tied.'! !

!RondaDeTruco methodsFor: 'error descriptions' stamp: 'ijgt 7/5/2021 20:21:43'!
thereWasNoWinnerInTheFirstEncounterErrorDescription

	^ 'There was no winner in the first encounter.'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RondaDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco class
	instanceVariableNames: ''!

!RondaDeTruco class methodsFor: 'instance creation' stamp: 'ijgt 7/5/2021 18:33:26'!
with: unMazo

	^ self new initializeWith: unMazo.! !

!RondaDeTruco class methodsFor: 'instance creation' stamp: 'ijgt 7/5/2021 17:54:05'!
with: unMazo for: jugadorMano vs: jugadorPie

	^ self new initializeWith: unMazo for: jugadorMano vs: jugadorPie.! !


!RondaDeTruco class methodsFor: 'error handling' stamp: 'ijgt 7/5/2021 18:58:01'!
cantHaveRepeatedCardsInRoundErrorDescription

	^ 'Cant have repeated cards in the same round.'! !
