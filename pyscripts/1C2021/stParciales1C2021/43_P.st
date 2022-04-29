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
	instanceVariableNames: 'cartasDeMano cartasDePie sieteDeOro dosDeEspada anchoDeEspada dosDeOro anchoDeBasto dosDeBasto'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'CD 7/5/2021 19:38:08'!
test01SeArmaUnaRondaSinEmpezar

	| ronda |
	
	ronda := RondaDeTruco cartasMano: cartasDeMano cartasPie: cartasDePie.
	
	self deny: ronda hayGanador.
	self assert: 0 equals: (ronda enfrentamientosJugados). 

	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'CD 7/5/2021 19:38:47'!
test02SeJuegaPrimerEnfrentamientoEmpezandoMano

	| cartasMano cartasPie ronda cartaEnfrentamientoMano cartaEnfrentamientoPie |
	
	cartasMano := cartasDeMano copy.
	cartasPie := cartasDePie copy.
	ronda := RondaDeTruco cartasMano: cartasMano cartasPie: cartasPie.
	cartaEnfrentamientoMano := cartasMano first.
	cartaEnfrentamientoPie := cartasPie first.
	
	ronda enfrentamientoManoCon: cartaEnfrentamientoMano pieCon: cartaEnfrentamientoPie.
	
	self assert: 1 equals: (ronda enfrentamientosJugados).
	self assert: (RondaDeTruco mano) equals: ronda quienEmpezoUltimoEnfrentamiento. 
	self deny: (ronda hayGanador).

	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'CD 7/5/2021 18:52:47'!
test03SeJuegaSegundoEnfrentamientoHabiendoEmpateEnPrimero

	| ronda  |
	ronda := self rondaConPrimerEnfrentamientoEmpatado.
	
	ronda enfrentamientoManoCon: (cartasDeMano first) pieCon: (cartasDePie second).
	
	self assert: 2 equals: (ronda enfrentamientosJugados).
	self assert: (RondaDeTruco mano) equals: ronda quienEmpezoUltimoEnfrentamiento. 

	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'CD 7/5/2021 21:08:59'!
test04SeJuegaSegundoEnfrentamientoHabiendoGanadoPieElAnterior

	| ronda  |
	ronda := self rondaConPrimerEnfrentamientoGanadoPorPie.
	
	ronda enfrentamientoManoCon: (anchoDeEspada) pieCon: (dosDeOro).
	
	self assert: 2 equals: (ronda enfrentamientosJugados).
	self assert: (RondaDeTruco pie) equals: ronda quienEmpezoUltimoEnfrentamiento. 

	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'CD 7/5/2021 20:11:54'!
test05HayGanadorDeRondaCuandoNoHayEmpateEnSegundoYHayEmpateEnPrimero

	| ronda  |
	ronda := self rondaConPrimerEnfrentamientoEmpatado.
	
	ronda enfrentamientoManoCon: sieteDeOro pieCon: anchoDeBasto .
	
	self assert: 2 equals: (ronda enfrentamientosJugados).
	self assert: ronda hayGanador.
	self assert: (ronda ganador) equals: (RondaDeTruco pie).
	
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'CD 7/5/2021 21:25:45'!
test06HayGanadorDeRondaCuandoJugadorGanaPrimerySegundoEnfrentamiento

	| ronda  |
	ronda := ronda := RondaDeTruco cartasMano: cartasDeMano cartasPie: cartasDePie.
	ronda enfrentamientoManoCon: anchoDeEspada pieCon: anchoDeBasto.
	ronda enfrentamientoManoCon: sieteDeOro pieCon: dosDeOro.
	
	self assert: 2 equals: (ronda enfrentamientosJugados).
	self assert: ronda hayGanador.
	self assert: (ronda ganador) equals: (RondaDeTruco mano).
	
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'CD 7/5/2021 21:21:08'!
test07HayGanadorDeRondaAlTercerEnfrentamiento

	| ronda  |
	ronda := self rondaConPrimerosDosEnfrentamientosConGanadorAlternado.
	
	ronda enfrentamientoManoCon: anchoDeEspada pieCon: dosDeBasto.
	
	self assert: 3 equals: (ronda enfrentamientosJugados).
	self assert: ronda hayGanador.
	self assert: (ronda ganador) equals: (RondaDeTruco mano).
	
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'CD 7/5/2021 21:21:16'!
test08NoSePuedeSeguirJugandoRondaCuandoHayGanador

	| ronda  |
	ronda := self rondaConPrimerEnfrentamientoEmpatado.
	ronda enfrentamientoManoCon: sieteDeOro pieCon: anchoDeBasto.
	
	
	self 
		should: [ ronda enfrentamientoManoCon: anchoDeEspada pieCon: dosDeOro]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: RondaDeTruco noSePuedeJugarUnaRondaFinalizada.
			self assert: 2 equals:(ronda enfrentamientosJugados )]
	
	! !


!RondaDeTrucoTest methodsFor: 'auxiliares - tests' stamp: 'CD 7/5/2021 19:46:50'!
rondaConPrimerEnfrentamientoEmpatado

	| cartaEnfrentamientoMano cartaEnfrentamientoPie ronda |
	
	ronda := RondaDeTruco cartasMano: cartasDeMano cartasPie: cartasDePie.
	cartaEnfrentamientoMano := cartasDeMano second.
	cartaEnfrentamientoPie := cartasDePie second.

	ronda enfrentamientoManoCon: cartaEnfrentamientoMano pieCon: cartaEnfrentamientoPie.
	
	^ ronda.! !

!RondaDeTrucoTest methodsFor: 'auxiliares - tests' stamp: 'CD 7/5/2021 21:22:40'!
rondaConPrimerEnfrentamientoGanadoPorPie

	| ronda |
	
	ronda := RondaDeTruco cartasMano: cartasDeMano cartasPie: cartasDePie.
	ronda enfrentamientoManoCon: dosDeEspada pieCon: anchoDeBasto.
	
	^ ronda.! !

!RondaDeTrucoTest methodsFor: 'auxiliares - tests' stamp: 'CD 7/5/2021 20:09:30'!
rondaConPrimerosDosEnfrentamientosConGanadorAlternado

	| ronda |

	ronda := RondaDeTruco cartasMano: cartasDeMano cartasPie: cartasDePie.
	ronda enfrentamientoManoCon: sieteDeOro pieCon: dosDeOro.
	ronda enfrentamientoManoCon: dosDeEspada pieCon: anchoDeBasto.
	
	^ ronda.! !


!RondaDeTrucoTest methodsFor: 'setUp' stamp: 'CD 7/5/2021 19:50:38'!
setUp
	sieteDeOro := CartaDeTruco sieteDeOro.
	dosDeEspada := CartaDeTruco espadaCon: 2.
	anchoDeEspada := CartaDeTruco anchoDeEspada.
	cartasDeMano := 	 OrderedCollection with: sieteDeOro with: dosDeEspada with: anchoDeEspada.
	
	dosDeOro := CartaDeTruco oroCon: 2.
	dosDeBasto := CartaDeTruco bastoCon: 2.
	anchoDeBasto := CartaDeTruco anchoDeBasto.
	cartasDePie := OrderedCollection with: dosDeOro with: dosDeBasto with: anchoDeBasto.
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
	instanceVariableNames: 'cartaMano cartaPie'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Enfrentamiento methodsFor: 'resultado' stamp: 'CD 7/5/2021 20:49:42'!
ganador
	
	^ (cartaMano mataA: cartaPie) ifFalse: [RondaDeTruco pie] ifTrue: [RondaDeTruco mano]! !

!Enfrentamiento methodsFor: 'resultado' stamp: 'CD 7/5/2021 19:07:38'!
hayEmpate

	^ cartaMano empardaCon: cartaPie.! !

!Enfrentamiento methodsFor: 'resultado' stamp: 'CD 7/5/2021 20:50:06'!
hayGanador 

	^ self hayEmpate not.! !


!Enfrentamiento methodsFor: 'initializers' stamp: 'CD 7/5/2021 18:37:03'!
cartaMano: cartaDeMano cartaPie: cartaDePie

	cartaMano := cartaDeMano.
	cartaPie := cartaDePie.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Enfrentamiento class' category: 'ISW1-2021-1C-2doParcial'!
Enfrentamiento class
	instanceVariableNames: ''!

!Enfrentamiento class methodsFor: 'initializers' stamp: 'CD 7/5/2021 18:38:23'!
cartaMano: cartaDeMano cartaPie: cartaDePie 

	^ self new cartaMano: cartaDeMano cartaPie: cartaDePie.
! !


!classDefinition: #RondaDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #RondaDeTruco
	instanceVariableNames: 'cartasMano cartasPie historialEnfrentamientos turno'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTruco methodsFor: 'initializers' stamp: 'CD 7/5/2021 18:57:56'!
cartasMano: cartasDeMano cartasPie: cartasDePie 
	cartasMano := cartasDeMano.
	cartasPie := cartasDePie.
	historialEnfrentamientos := OrderedCollection new.
	turno := ''.! !


!RondaDeTruco methodsFor: 'enfrentamientos' stamp: 'CD 7/5/2021 21:18:46'!
agregarJugadaDeMano: cartaDeTrucoMano yDePie: cartaDeTrucoPie

	historialEnfrentamientos add: (Enfrentamiento cartaMano: cartaDeTrucoMano cartaPie: cartaDeTrucoPie).
	self jugadoresUsanCartasConMano: cartaDeTrucoPie yConPie: cartaDeTrucoMano.! !

!RondaDeTruco methodsFor: 'enfrentamientos' stamp: 'CD 7/5/2021 21:19:43'!
enfrentamientoManoCon: cartaDeTrucoMano pieCon: cartaDeTrucoPie
	self asertarRondaNoFinalizada.
	
	turno := self aQuienLeTocaEmpezar. 
	self agregarJugadaDeMano: cartaDeTrucoMano yDePie: cartaDeTrucoPie.
	
	! !

!RondaDeTruco methodsFor: 'enfrentamientos' stamp: 'CD 7/5/2021 19:08:50'!
ganadorEnUltimoEnfrentamiento

	^ (historialEnfrentamientos last) ganador.! !

!RondaDeTruco methodsFor: 'enfrentamientos' stamp: 'CD 7/5/2021 21:17:10'!
jugadoresUsanCartasConMano: cartaDeTrucoPie yConPie: cartaDeTrucoMano

	cartasMano remove: cartaDeTrucoMano.
	cartasPie remove: cartaDeTrucoPie! !


!RondaDeTruco methodsFor: 'testing' stamp: 'CD 7/5/2021 18:31:39'!
enfrentamientosJugados
	^ historialEnfrentamientos size.! !

!RondaDeTruco methodsFor: 'testing' stamp: 'CD 7/5/2021 19:12:44'!
quienEmpezoUltimoEnfrentamiento
	^ turno.! !


!RondaDeTruco methodsFor: 'turno' stamp: 'CD 7/5/2021 21:27:03'!
aQuienLeTocaEmpezar

	^ (self empiezaTurnoMano) ifTrue: [RondaDeTruco mano] ifFalse: [self ganadorEnUltimoEnfrentamiento].! !

!RondaDeTruco methodsFor: 'turno' stamp: 'CD 7/5/2021 21:27:03'!
empiezaTurnoMano

	^ self juegoNoEmpezo or: [self huboEmpateEnPrimerEnfrentamiento ]! !


!RondaDeTruco methodsFor: 'ganador' stamp: 'CD 7/5/2021 19:58:15'!
ganador

	^ (historialEnfrentamientos last) ganador.! !

!RondaDeTruco methodsFor: 'ganador' stamp: 'CD 7/5/2021 21:14:26'!
hayGanador

	^ self alguienGanoMasDeUnEnfrentamiento or: [self huboEmpateEnPrimeraYGanadorEnSegunda].! !


!RondaDeTruco methodsFor: 'aserciones' stamp: 'CD 7/5/2021 21:03:10'!
alguienGanoMasDeUnEnfrentamiento

	^ (self huboMasDeUnEnfrentamientoJugado) and: [self algunJugadorGanoMasDeUnEnfrentamiento]! !

!RondaDeTruco methodsFor: 'aserciones' stamp: 'CD 7/5/2021 20:33:59'!
algunJugadorGanoMasDeUnEnfrentamiento

	^ (self jugadorGanoMasDeUnEnfrentamiento: RondaDeTruco mano) or: [self jugadorGanoMasDeUnEnfrentamiento: RondaDeTruco pie].! !

!RondaDeTruco methodsFor: 'aserciones' stamp: 'CD 7/5/2021 20:23:01'!
asertarRondaNoFinalizada

	^ (self hayGanador) ifTrue: [self error: RondaDeTruco noSePuedeJugarUnaRondaFinalizada].! !

!RondaDeTruco methodsFor: 'aserciones' stamp: 'CD 7/5/2021 21:14:08'!
huboEmpateEnPrimerEnfrentamiento

	^ (self huboEnfrentamientos) and: [(historialEnfrentamientos first) hayEmpate]. ! !

!RondaDeTruco methodsFor: 'aserciones' stamp: 'CD 7/5/2021 21:05:28'!
huboEmpateEnPrimeraYGanadorEnSegunda

	^self huboMasDeUnEnfrentamientoJugado and: [self huboEmpateEnPrimerEnfrentamiento].! !

!RondaDeTruco methodsFor: 'aserciones' stamp: 'CD 7/5/2021 20:29:05'!
huboEnfrentamientos

	^ historialEnfrentamientos notEmpty! !

!RondaDeTruco methodsFor: 'aserciones' stamp: 'CD 7/5/2021 19:31:59'!
huboMasDeUnEnfrentamientoJugado

	^ 1 < historialEnfrentamientos size.! !

!RondaDeTruco methodsFor: 'aserciones' stamp: 'CD 7/5/2021 19:05:33'!
juegoNoEmpezo

	^ historialEnfrentamientos isEmpty.! !

!RondaDeTruco methodsFor: 'aserciones' stamp: 'CD 7/5/2021 20:51:27'!
jugadorGanoMasDeUnEnfrentamiento: unJugador

	^ 1 < ((historialEnfrentamientos select: [: enfrentamiento | enfrentamiento hayGanador and: [enfrentamiento ganador = unJugador]]) size).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RondaDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco class
	instanceVariableNames: 'cartasPie cartasMano'!

!RondaDeTruco class methodsFor: 'initializers' stamp: 'CD 7/5/2021 18:24:35'!
cartasMano: cartasDeMano cartasPie: cartasDePie 
	^ self new cartasMano: cartasDeMano cartasPie: cartasDePie.! !


!RondaDeTruco class methodsFor: 'jugadores' stamp: 'CD 7/5/2021 18:32:09'!
mano
	^ 'mano'.! !

!RondaDeTruco class methodsFor: 'jugadores' stamp: 'CD 7/5/2021 18:53:50'!
pie
	^ 'pie'.! !


!RondaDeTruco class methodsFor: 'mensajes de error' stamp: 'CD 7/5/2021 20:20:07'!
noSePuedeJugarUnaRondaFinalizada

	^ 'No se puede jugar en una ronda de truco que ha finalizado'.! !
