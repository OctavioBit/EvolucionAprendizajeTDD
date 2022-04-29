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
	instanceVariableNames: 'anchoDeBasto cuatroDeOro sieteDeOro anchoDeEspadas seisDeOro cuatroDeBastos ochoDeOro'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ERMC 7/5/2021 21:32:15'!
test02_CadaJugadorArrancaCon3CartasExactamente
	
	| rondaDeTruco |
	
	rondaDeTruco _ RondaDeTruco con: self crearCartasParaLaMano y: self crearCartasParaElPie .
	
	self assert: rondaDeTruco cartasDelJugadorMano size equals: 3.
	self assert: rondaDeTruco cartasDelJugadorPie size equals: 3.
	self assert: rondaDeTruco esTurnoDelJugadorMano.
	self deny: rondaDeTruco esTurnoDelJugadorPie.
	self deny: rondaDeTruco laRondaTermino.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ERMC 7/5/2021 18:53:10'!
test03_NingunJugadorPuedeEmpezarConMenosOMasCartasQueTres
	
	| unaCarta |
	
	unaCarta _ OrderedCollection with: anchoDeBasto.
	
	self 
		should: [RondaDeTruco con: unaCarta y: self crearCuatroCartas.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: RondaDeTruco laCantidadDeCartasParaElJugadorEsInvalidaDescripcionDeError equals: anError messageText]
	
! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ERMC 7/5/2021 19:11:57'!
test04_UnJugadorNoPuedetenerCartasRepetidas
		
	self 
		should: [RondaDeTruco con: self setConCartasRepetidas y: self crearCartasParaLaMano .]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: RondaDeTruco noPuedenHaberCartasRepetidasDescripcionDeError equals: anError messageText]
	
! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ERMC 7/5/2021 19:27:23'!
test05_NoPuedenHaberCartasRepetidasEnLaRonda
		
	self 
		should: [RondaDeTruco con: self setConAnchoDeEspada y: self otroSetConAnchoDeEspada .]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: RondaDeTruco noPuedenHaberCartasRepetidasDescripcionDeError equals: anError messageText]
	
! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ERMC 7/5/2021 21:51:10'!
test06_ElPrimerEnfrentamientoLoJuegaPrimeroLaManoSeguidoDelPie
	
	| rondaDeTruco cartasDelJugadorMano cartasdelJugadorPie |
	
	cartasDelJugadorMano _ self crearCartasParaLaMano.
	cartasdelJugadorPie _ self crearCartasParaElPie.
	
	rondaDeTruco _ RondaDeTruco con: cartasDelJugadorMano y: cartasdelJugadorPie.
	
	rondaDeTruco juegaManoCon: anchoDeEspadas.
	
	self assert: rondaDeTruco cartaJugadaPorMano  equals: anchoDeEspadas.
	self assert: rondaDeTruco esTurnoDelJugadorPie.
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ERMC 7/5/2021 21:46:04'!
test07_ElJugadorPieNoPuedeEmpezarLaRonda
	
	| rondaDeTruco cartasDelJugadorMano cartasdelJugadorPie |
	
	cartasDelJugadorMano _ self crearCartasParaLaMano.
	cartasdelJugadorPie _ self crearCartasParaElPie.
	
	rondaDeTruco _ RondaDeTruco con: cartasDelJugadorMano y: cartasdelJugadorPie.
	
	self 
		should: [	rondaDeTruco juegaPiecon: anchoDeBasto.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: rondaDeTruco esElTurnoDelJugadorManoDescripcionDeError equals: anError messageText]
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ERMC 7/5/2021 21:23:57'!
test08_ElJugadorManoNoPuedeUsarCartasQueNoTiene
	
	| rondaDeTruco cartasDelJugadorMano cartasdelJugadorPie |
	
	cartasDelJugadorMano _ self crearCartasParaLaMano.
	cartasdelJugadorPie _ self crearCartasParaElPie.
	
	rondaDeTruco _ RondaDeTruco con: cartasDelJugadorMano y: cartasdelJugadorPie.
	
	self 
		should: [	rondaDeTruco juegaManoCon: cuatroDeOro.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: rondaDeTruco noSePuedeJugarConCartasQueNoSeTieneDescripcionDeError equals: anError messageText]
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ERMC 7/5/2021 21:26:56'!
test09_ElJugadorPieNoPuedeUsarCartasQueNoTiene
	
	| rondaDeTruco cartasDelJugadorMano cartasdelJugadorPie |
	
	cartasDelJugadorMano _ self crearCartasParaLaMano.
	cartasdelJugadorPie _ self crearCartasParaElPie.
	
	rondaDeTruco _ RondaDeTruco con: cartasDelJugadorMano y: cartasdelJugadorPie.
	
	rondaDeTruco juegaManoCon: anchoDeEspadas.
	
	self 
		should: [	rondaDeTruco juegaPiecon: anchoDeEspadas .]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: rondaDeTruco noSePuedeJugarConCartasQueNoSeTieneDescripcionDeError equals: anError messageText]
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'ERMC 7/5/2021 21:55:24'!
test10_ElJugadorManoEmpiezaLaRondaJuegaElPieYJuegaDeNuevoElGanadorDelPrimerEnfrentamiento
	
	| rondaDeTruco cartasDelJugadorMano cartasdelJugadorPie |
	
	cartasDelJugadorMano _ self crearCartasParaLaMano.
	cartasdelJugadorPie _ self crearCartasParaElPie.
	
	rondaDeTruco _ RondaDeTruco con: cartasDelJugadorMano y: cartasdelJugadorPie.
	
	rondaDeTruco juegaManoCon: anchoDeEspadas.
	rondaDeTruco juegaPiecon: anchoDeBasto.
	
	self assert: rondaDeTruco esTurnoDelJugadorMano.
	self assert: rondaDeTruco ganadorDelEnfrentamiento equals: #Mano.
	self assert: (rondaDeTruco enfrentamientosGanados: #Mano) equals: 1.
	self assert: (rondaDeTruco enfrentamientosGanados: #Pie) equals: 0.
	
	
	"Hasta aqui llegue. No tome buenas decisiones de diseño =( y no me dio tiempo de reificar"! !


!RondaDeTrucoTest methodsFor: 'objetos del test' stamp: 'ERMC 7/5/2021 18:51:46'!
crearCartasParaElPie

	^ OrderedCollection with: anchoDeBasto with: cuatroDeOro with: sieteDeOro.! !

!RondaDeTrucoTest methodsFor: 'objetos del test' stamp: 'ERMC 7/5/2021 18:52:22'!
crearCartasParaLaMano

	^OrderedCollection with: anchoDeEspadas with: seisDeOro with: cuatroDeBastos! !

!RondaDeTrucoTest methodsFor: 'objetos del test' stamp: 'ERMC 7/5/2021 18:52:49'!
crearCuatroCartas

	^OrderedCollection with: anchoDeEspadas with: anchoDeBasto with: seisDeOro with: cuatroDeBastos ! !

!RondaDeTrucoTest methodsFor: 'objetos del test' stamp: 'ERMC 7/5/2021 19:28:31'!
otroSetConAnchoDeEspada

	^OrderedCollection with: anchoDeEspadas with: cuatroDeOro with: seisDeOro! !

!RondaDeTrucoTest methodsFor: 'objetos del test' stamp: 'ERMC 7/5/2021 19:28:01'!
setConAnchoDeEspada

	^OrderedCollection with: anchoDeEspadas with: seisDeOro with: cuatroDeBastos! !

!RondaDeTrucoTest methodsFor: 'objetos del test' stamp: 'ERMC 7/5/2021 19:11:39'!
setConCartasRepetidas

	^OrderedCollection with: anchoDeEspadas with: anchoDeEspadas with: seisDeOro! !

!RondaDeTrucoTest methodsFor: 'objetos del test' stamp: 'ERMC 7/5/2021 18:58:01'!
setDeCartasConElOcho

	^ OrderedCollection with: anchoDeBasto with: cuatroDeOro with: sieteDeOro.! !


!RondaDeTrucoTest methodsFor: 'set-up' stamp: 'ERMC 7/5/2021 19:24:29'!
setUp

	anchoDeBasto _ CartaDeTruco anchoDeBasto.
	cuatroDeOro _ CartaDeTruco oroCon: 4.
	sieteDeOro _ CartaDeTruco oroCon: 7.
	
	anchoDeEspadas _ CartaDeTruco anchoDeEspada.
	seisDeOro _ CartaDeTruco oroCon: 6.
	cuatroDeBastos _ CartaDeTruco bastoCon: 4.	! !


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


!classDefinition: #EstadoRondaDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #EstadoRondaDeTruco
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!


!classDefinition: #JuegaMano category: 'ISW1-2021-1C-2doParcial'!
EstadoRondaDeTruco subclass: #JuegaMano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!


!classDefinition: #JuegaPie category: 'ISW1-2021-1C-2doParcial'!
EstadoRondaDeTruco subclass: #JuegaPie
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!


!classDefinition: #RondaDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #RondaDeTruco
	instanceVariableNames: 'cartasDelJugadorMano cartasDelJugadorPie estado cartasJugadas cartaJugadaPorMano ganadorDelEnfrentamiento puntosMano puntosPie'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTruco methodsFor: 'asertions' stamp: 'ERMC 7/5/2021 21:43:45'!
esTurnoDelJugadorMano
	
	^ estado = #Mano ! !

!RondaDeTruco methodsFor: 'asertions' stamp: 'ERMC 7/5/2021 20:00:15'!
esTurnoDelJugadorPie
	
	^ estado = #Pie.! !

!RondaDeTruco methodsFor: 'asertions' stamp: 'ERMC 7/5/2021 21:31:55'!
laRondaTermino
	
	^false ! !


!RondaDeTruco methodsFor: 'initialization' stamp: 'ERMC 7/5/2021 21:43:17'!
initializeCon: unaColeccionDeCartas y: otraColeccionDeCartas 

	cartasDelJugadorMano _ unaColeccionDeCartas.
	cartasDelJugadorPie _ otraColeccionDeCartas.
	
	puntosMano _ 0.
	puntosPie _ 0.
	
	cartasJugadas _ OrderedCollection new.
	estado _ #Mano! !


!RondaDeTruco methodsFor: 'accessing' stamp: 'ERMC 7/5/2021 21:51:10'!
cartaJugadaPorMano
	
	^cartaJugadaPorMano ! !

!RondaDeTruco methodsFor: 'accessing' stamp: 'ERMC 7/5/2021 18:34:58'!
cartasDelJugadorMano

	^cartasDelJugadorMano! !

!RondaDeTruco methodsFor: 'accessing' stamp: 'ERMC 7/5/2021 18:35:07'!
cartasDelJugadorPie

	^cartasDelJugadorPie! !

!RondaDeTruco methodsFor: 'accessing' stamp: 'ERMC 7/5/2021 19:58:36'!
cartasJugadas

	^cartasJugadas! !

!RondaDeTruco methodsFor: 'accessing' stamp: 'ERMC 7/5/2021 21:21:11'!
enfrentamientosGanados: jugador
	
	(jugador = #Mano)  ifTrue: [^puntosMano].
	(jugador = #Pie)  ifTrue: [^puntosPie]
	
	! !

!RondaDeTruco methodsFor: 'accessing' stamp: 'ERMC 7/5/2021 21:20:08'!
ganadorDelEnfrentamiento

	^ganadorDelEnfrentamiento! !


!RondaDeTruco methodsFor: 'ronda de juego' stamp: 'ERMC 7/5/2021 21:47:19'!
juegaManoCon: cartaDeTruco 
	
	(estado = #Mano) ifFalse: [self error: self esElTurnoDelJugadorPieDescripcionDeError].
	(cartasDelJugadorMano includes: cartaDeTruco ) ifFalse: [self error: self noSePuedeJugarConCartasQueNoSeTieneDescripcionDeError].
	cartaJugadaPorMano _ cartaDeTruco.
	
	estado _ #Pie! !

!RondaDeTruco methodsFor: 'ronda de juego' stamp: 'ERMC 7/5/2021 21:26:19'!
juegaPiecon: cartaDeTruco 
	
	(estado = #Pie) ifFalse: [self error: self esElTurnoDelJugadorManoDescripcionDeError].
	(cartasDelJugadorPie includes: cartaDeTruco ) ifFalse: [self error: self noSePuedeJugarConCartasQueNoSeTieneDescripcionDeError].


	(ganadorDelEnfrentamiento isNil )	 ifTrue: [^ (cartaJugadaPorMano mataA: cartaDeTruco )
			ifTrue: [ganadorDelEnfrentamiento _ #Mano.
				self sumarPuntoAMano.
				estado _ #Mano]]
	! !

!RondaDeTruco methodsFor: 'ronda de juego' stamp: 'ERMC 7/5/2021 21:18:24'!
sumarPuntoAMano
	
	puntosMano _ puntosMano + 1! !


!RondaDeTruco methodsFor: 'errores' stamp: 'ERMC 7/5/2021 20:05:43'!
esElTurnoDelJugadorManoDescripcionDeError

	^ 'No podes jugar, es el turno de la mano'! !

!RondaDeTruco methodsFor: 'errores' stamp: 'ERMC 7/5/2021 21:53:04'!
esElTurnoDelJugadorPieDescripcionDeError

	^ 'No podes jugar, es el turno del pie'! !

!RondaDeTruco methodsFor: 'errores' stamp: 'ERMC 7/5/2021 21:25:23'!
noSePuedeJugarConCartasQueNoSeTieneDescripcionDeError
	
	^'No se puede jugar con cartas que no se tiene en la mano'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RondaDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco class
	instanceVariableNames: ''!

!RondaDeTruco class methodsFor: 'instance creation' stamp: 'ERMC 7/5/2021 19:31:35'!
con: unaColeccionDeCartas y: otraColeccionDeCartas 
	
	(unaColeccionDeCartas size = 3) ifFalse: [^self error: self laCantidadDeCartasParaElJugadorEsInvalidaDescripcionDeError].
	(otraColeccionDeCartas size = 3) ifFalse: [^self error: self laCantidadDeCartasParaElJugadorEsInvalidaDescripcionDeError].
	
	(self contieneAlgunaCartaRepetida: unaColeccionDeCartas, otraColeccionDeCartas ) ifTrue: [^self error: self noPuedenHaberCartasRepetidasDescripcionDeError].
		
	^self new initializeCon: unaColeccionDeCartas y: otraColeccionDeCartas ! !


!RondaDeTruco class methodsFor: 'error' stamp: 'ERMC 7/5/2021 18:46:55'!
laCantidadDeCartasParaElJugadorEsInvalidaDescripcionDeError
	
	^' Cada jugador deberia arrancar con exactamente 3 cartas'! !



!RondaDeTruco class methodsFor: 'as yet unclassified' stamp: 'ERMC 7/5/2021 19:33:47'!
contieneAlgunaCartaRepetida: coleccionDeCartas
	
	coleccionDeCartas do: [:unaCarta |
		((coleccionDeCartas occurrencesOf: unaCarta) = 1) ifFalse: [^true]].
	
	^false. ! !

!RondaDeTruco class methodsFor: 'as yet unclassified' stamp: 'ERMC 7/5/2021 19:18:29'!
noPuedenHaberCartasRepetidasDescripcionDeError
	
	^' No pueden existir dos cartas iguales en el juego, solo hay un mazo'! !
