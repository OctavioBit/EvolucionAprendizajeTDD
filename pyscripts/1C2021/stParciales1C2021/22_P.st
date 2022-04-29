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

!RondaDeTrucoTest methodsFor: 'cartas de cada jugador' stamp: 'sgs 7/5/2021 20:33:18'!
repartirUnConjuntoDeCartasValidoALaMano: rondaDeTruco
	
	rondaDeTruco repartirCartaALaMano: (CartaDeTruco bastoCon:  2). 
	rondaDeTruco repartirCartaALaMano: (CartaDeTruco copaCon: 3). 
	rondaDeTruco repartirCartaALaMano: (CartaDeTruco oroCon: 3). 

	
	! !

!RondaDeTrucoTest methodsFor: 'cartas de cada jugador' stamp: 'sgs 7/5/2021 20:35:34'!
repartirUnConjuntoDeCartasValidoAlPie: rondaDeTruco
	
	rondaDeTruco repartirCartaAlPie: (CartaDeTruco copaCon: 2).
	rondaDeTruco repartirCartaAlPie: (CartaDeTruco espadaCon: 10).
	rondaDeTruco repartirCartaAlPie: (CartaDeTruco oroCon: 1). 
	
	! !

!RondaDeTrucoTest methodsFor: 'cartas de cada jugador' stamp: 'sgs 7/5/2021 21:35:12'!
unaCartaDeLaMano
	
	^CartaDeTruco bastoCon:  2! !

!RondaDeTrucoTest methodsFor: 'cartas de cada jugador' stamp: 'sgs 7/5/2021 21:35:15'!
unaCartaDelPie
	
	^CartaDeTruco copaCon: 2! !


!RondaDeTrucoTest methodsFor: 'test' stamp: 'sgs 7/5/2021 20:29:41'!
test01CantidadDeJugadoresDeUnaRondaDeTrucoEsDos
	| rondaDeTruco |
	
	rondaDeTruco _  RondaDeTruco crearRonda.
	
	self assert: 2 equals: rondaDeTruco cantidadDeJugadores.
	
	
	
	
	! !

!RondaDeTrucoTest methodsFor: 'test' stamp: 'sgs 7/5/2021 21:44:15'!
test02NoSePuedenRepartirleAlPieCartasQueYaTieneLaMano
	| rondaDeTruco |
	
	rondaDeTruco _  RondaDeTruco crearRonda.
	
	self repartirUnConjuntoDeCartasValidoALaMano: rondaDeTruco.
	
	self 
		should: [rondaDeTruco repartirCartaAlPie: (CartaDeTruco bastoCon: 2).  ]
		raise: Error -MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: rondaDeTruco losJugadoresNoPuedenTenerCartasIguales equals: anError messageText.
			 ]
	
	
	
	! !

!RondaDeTrucoTest methodsFor: 'test' stamp: 'sgs 7/5/2021 20:43:41'!
test03NoSePuedenRepartirleALaManoCartasQueYaTieneElPie
	| rondaDeTruco |
	"No asigne un  orden para repartir porque no lo pide en el enunciado, por eso es que puedo testear esto, sin necesidad de haber rapartido primero alguna de la mano."
	
	rondaDeTruco _  RondaDeTruco crearRonda.
	
	self repartirUnConjuntoDeCartasValidoAlPie: rondaDeTruco.
	
	self 
		should: [rondaDeTruco repartirCartaALaMano: (CartaDeTruco oroCon: 		1).  ]
		raise: Error -MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: rondaDeTruco losJugadoresNoPuedenTenerCartasIguales equals: anError messageText.
			 ]
	
	
	
	! !

!RondaDeTrucoTest methodsFor: 'test' stamp: 'sgs 7/5/2021 21:26:52'!
test04CantidadDeCartasConLasQueEmpiezaAJugarEsTres

	| rondaDeTruco |
	
	rondaDeTruco _  RondaDeTruco crearRonda.
	
	self 
		should: [rondaDeTruco  jugaManoCon: self unaCartaDeLaMano. ]
		raise: Error -MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: rondaDeTruco noSePuedeComenzarAJugarSinAntesRepartirtTresCartasACadaJugador equals: anError messageText.
			 ]
	
	
	
	
	
	
	! !

!RondaDeTrucoTest methodsFor: 'test' stamp: 'sgs 7/5/2021 20:51:16'!
test05NoSePudeRepartirALaManoMasDeTresCartas

	| rondaDeTruco |
	
	rondaDeTruco _  RondaDeTruco crearRonda.
	
	self repartirUnConjuntoDeCartasValidoALaMano: rondaDeTruco.
	
	self 
		should: [rondaDeTruco repartirCartaALaMano: (CartaDeTruco espadaCon: 11).  ]
		raise: Error -MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: rondaDeTruco noSePuedeComenzarAJugarSinAntesRepartirtTresCartasACadaJugador equals: anError messageText.
			 ]
	
	
	
	
	
	
	! !

!RondaDeTrucoTest methodsFor: 'test' stamp: 'sgs 7/5/2021 20:54:05'!
test06NoSePudeRepartirAlPieMasDeTresCartas

	| rondaDeTruco |
	
	rondaDeTruco _  RondaDeTruco crearRonda.
	
	self repartirUnConjuntoDeCartasValidoAlPie: rondaDeTruco.
	
	self 
		should: [rondaDeTruco repartirCartaAlPie: (CartaDeTruco espadaCon: 11).  ]
		raise: Error -MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: rondaDeTruco noSePuedeComenzarAJugarSinAntesRepartirtTresCartasACadaJugador equals: anError messageText.
			 ]
	
	
	
	
	
	
	! !

!RondaDeTrucoTest methodsFor: 'test' stamp: 'sgs 7/5/2021 21:25:27'!
test07ElPieNoPuedeEmpezarAJugar
	| rondaDeTruco |
	
	rondaDeTruco _  RondaDeTruco crearRonda.
	
	self repartirUnConjuntoDeCartasValidoALaMano: rondaDeTruco.
	self repartirUnConjuntoDeCartasValidoAlPie: rondaDeTruco.
	
	self 
		should: [rondaDeTruco jugaPieCon: self unaCartaDelPie.]
		raise: Error -MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: rondaDeTruco noPuedeComenzarAJugarPieAlComienzoDeLaRonda equals: anError messageText.
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
	instanceVariableNames: 'cantidadDeJugadores estado cartasDeMano cartasDePie'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTruco methodsFor: 'initializacion' stamp: 'sgs 7/5/2021 21:37:11'!
initialize
	
	cartasDeMano _ OrderedCollection new.
	cartasDePie _ OrderedCollection new.
	estado _ #Mano
	 
	! !


!RondaDeTruco methodsFor: 'repartir cartas' stamp: 'sgs 7/5/2021 21:50:37'!
repartirCartaALaMano: unaCarta
"Tengo que sacar este codigo repetido que también aparece en el pie, probablemente tenga que crear la clase JugadorDeTruco y las subclases Pie y Mano para poder sacar el codigo repetido y hacer doble dispach"
	(cartasDeMano size > 2) ifTrue: [^self error: self noSePuedeComenzarAJugarSinAntesRepartirtTresCartasACadaJugador ].
	(cartasDePie includes: unaCarta) ifTrue: [^self error: self losJugadoresNoPuedenTenerCartasIguales].
	 cartasDeMano add: unaCarta.! !

!RondaDeTruco methodsFor: 'repartir cartas' stamp: 'sgs 7/5/2021 20:55:05'!
repartirCartaAlPie: unaCarta

	(cartasDePie size > 2) ifTrue: [^self error: self noSePuedeComenzarAJugarSinAntesRepartirtTresCartasACadaJugador ].
	(cartasDeMano includes: unaCarta) ifTrue: [^self error: self losJugadoresNoPuedenTenerCartasIguales].
	cartasDePie add: unaCarta.! !


!RondaDeTruco methodsFor: 'as yet unclassified' stamp: 'sgs 7/5/2021 18:59:18'!
cantidadDeCartasDeMano
	 
	^ cartasDeMano size.
	! !

!RondaDeTruco methodsFor: 'as yet unclassified' stamp: 'sgs 7/5/2021 18:59:46'!
cantidadDeCartasDePie
	 
	^ cartasDePie size.
	! !

!RondaDeTruco methodsFor: 'as yet unclassified' stamp: 'sgs 7/5/2021 20:29:48'!
cantidadDeJugadores
	
	^ 2 ! !


!RondaDeTruco methodsFor: 'jugar' stamp: 'sgs 7/5/2021 21:52:53'!
jugaManoCon:  unaCarta
	^ self error: self noSePuedeComenzarAJugarSinAntesRepartirtTresCartasACadaJugador
! !

!RondaDeTruco methodsFor: 'jugar' stamp: 'sgs 7/5/2021 21:31:19'!
jugaPieCon:  unaCarta

	^self error: self noPuedeComenzarAJugarPieAlComienzoDeLaRonda.! !


!RondaDeTruco methodsFor: 'excepciones' stamp: 'sgs 7/5/2021 20:37:06'!
losJugadoresNoPuedenTenerCartasIguales
	^'Solo jugamos con un maso, por lo tanto los jugadores no pueden tener cartas iguales.'! !

!RondaDeTruco methodsFor: 'excepciones' stamp: 'sgs 7/5/2021 21:23:54'!
noPuedeComenzarAJugarPieAlComienzoDeLaRonda

	^ 'El pie no puede comenzar a jugar al comienzo de la ronda.'	
	! !

!RondaDeTruco methodsFor: 'excepciones' stamp: 'sgs 7/5/2021 20:48:21'!
noSePuedeComenzarAJugarSinAntesRepartirtTresCartasACadaJugador

	^ 'Aun quedan cartas por repartir.'	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RondaDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco class
	instanceVariableNames: ''!

!RondaDeTruco class methodsFor: 'as yet unclassified' stamp: 'sgs 7/5/2021 18:44:04'!
crearRonda
	
	^ self new initialize.! !
