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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaTest methodsFor: 'initialization' stamp: 'LB 7/5/2021 20:41:58'!
cartasMano 
	^OrderedCollection with: (CartaDeTruco espadaCon: 4) with: 	(CartaDeTruco espadaCon: 3) with: (CartaDeTruco espadaCon: 6).
	! !

!RondaTest methodsFor: 'initialization' stamp: 'LB 7/5/2021 21:07:43'!
cartasPie 
	^OrderedCollection with: (CartaDeTruco oroCon: 1) with: 	(CartaDeTruco oroCon: 2) with: (CartaDeTruco oroCon: 5).! !

!RondaTest methodsFor: 'initialization' stamp: 'LB 7/5/2021 21:05:59'!
defaultRonda 
	^Ronda withMano: self cartasMano pie: self cartasPie.
	! !


!RondaTest methodsFor: 'tests - incio ronda' stamp: 'LB 7/5/2021 20:36:13'!
test01_ManoIniciaCon3CartasDeTrucoDistintas	

	| mano |
	mano := OrderedCollection with: CartaDeTruco anchoDeBasto with: 	CartaDeTruco anchoDeBasto with: CartaDeTruco anchoDeEspada.
	
	self should: [Ronda withMano: mano pie: self cartasPie]
		raise: Error - MessageNotUnderstood 
		withMessageText: Ronda cartasRepetidasErrorDescription.! !

!RondaTest methodsFor: 'tests - incio ronda' stamp: 'LB 7/5/2021 20:25:40'!
test02_PieIniciaCon3CartasDeTrucoDistintas	

	| mano pie |
	mano := OrderedCollection with: CartaDeTruco anchoDeBasto with: 	CartaDeTruco sieteDeEspada with: CartaDeTruco anchoDeEspada.
	pie := OrderedCollection with: CartaDeTruco anchoDeBasto with: 	CartaDeTruco anchoDeBasto with: CartaDeTruco anchoDeEspada.
	
	self should: [Ronda withMano: mano pie: pie]
		raise: Error - MessageNotUnderstood 
		withMessageText: Ronda cartasRepetidasErrorDescription.! !

!RondaTest methodsFor: 'tests - incio ronda' stamp: 'LB 7/5/2021 20:25:49'!
test03_ManoyPieDebenTenerCartasDistintas

	| mano pie |
	mano := OrderedCollection with: CartaDeTruco anchoDeBasto with: 	CartaDeTruco sieteDeEspada with: CartaDeTruco anchoDeEspada.
	pie := OrderedCollection with: CartaDeTruco anchoDeBasto with: 	CartaDeTruco sieteDeEspada with: CartaDeTruco anchoDeEspada.
	
	self should: [Ronda withMano: mano pie: pie]
		raise: Error - MessageNotUnderstood 
		withMessageText: Ronda cartasRepetidasErrorDescription.! !

!RondaTest methodsFor: 'tests - incio ronda' stamp: 'LB 7/5/2021 20:52:35'!
test04_ManoyPieDebenTenerCartasDeTruco

	| mano pie |
	mano := OrderedCollection with: 1 with: 	2 with: 3.
	pie := OrderedCollection with: 4 with: 	5 with: 6.
	
	self should: [Ronda withMano: mano pie: self cartasPie]
		raise: Error - MessageNotUnderstood 
		withMessageText: Ronda cartasInvalidasErrorDescription.
		
	self should: [Ronda withMano: self cartasMano pie: pie]
		raise: Error - MessageNotUnderstood 
		withMessageText: Ronda cartasInvalidasErrorDescription.! !

!RondaTest methodsFor: 'tests - incio ronda' stamp: 'LB 7/5/2021 21:06:21'!
test05_RondaIniciaSinCartasJugadas

	| ronda |
	ronda := self defaultRonda.
	self assert: 0 equals: ronda mesa size.! !

!RondaTest methodsFor: 'tests - incio ronda' stamp: 'LB 7/5/2021 21:06:32'!
test06_ManoTiraPrimero

	| ronda |
	ronda := self defaultRonda.
	
	self assert: #Mano equals: ronda turno.! !


!RondaTest methodsFor: 'tests - enfrentamientos' stamp: 'LB 7/5/2021 21:06:36'!
test07_ManoSoloPuedeJugarUnaCartaSuya

	| ronda |
	ronda := self defaultRonda.
	
	self should: [ronda juega: #Mano carta: (CartaDeTruco oroCon: 4).]
		raise: Error - MessageNotUnderstood
		withMessageText: Ronda cartaInvalidaErrorDescription.! !

!RondaTest methodsFor: 'tests - enfrentamientos' stamp: 'LB 7/5/2021 21:06:40'!
test08_RondaConoceLaCartaJugada

	| ronda |
	ronda := self defaultRonda.
	ronda juega: #Mano carta: (self cartasMano at: 1).
	
	self assert: (ronda mesa at: #Mano) equals: (self cartasMano at: 1).
	self assert: 1 equals: ronda mesa size.! !

!RondaTest methodsFor: 'tests - enfrentamientos' stamp: 'LB 7/5/2021 21:06:42'!
test09_LuegoDeJugarManoEsTurnoDePie

	| ronda |
	ronda := self defaultRonda.
	
	ronda juega: #Mano carta: (self cartasMano at: 1).
	
	self assert: #Pie equals: ronda turno.! !

!RondaTest methodsFor: 'tests - enfrentamientos' stamp: 'LB 7/5/2021 21:06:46'!
test10_ManoSoloPuedeTirarEnSuTurno

	| ronda |
	ronda := self defaultRonda.
	
	ronda juega: #Mano carta: (self cartasMano at: 1).
	
	self should: [ronda juega: #Mano carta: (self cartasMano at: 2).]
		raise: Error - MessageNotUnderstood
		withMessageText: Ronda noEsTuTurnoErrorDescription.! !

!RondaTest methodsFor: 'tests - enfrentamientos' stamp: 'LB 7/5/2021 21:06:49'!
test11_PieSoloPuedeTirarEnSuTurno

	| ronda |
	ronda := self defaultRonda.
	
	self should: [ronda juega: #Pie carta: (self cartasPie at: 1).]
		raise: Error - MessageNotUnderstood
		withMessageText: Ronda noEsTuTurnoErrorDescription.! !

!RondaTest methodsFor: 'tests - enfrentamientos' stamp: 'LB 7/5/2021 21:06:53'!
test12_PieSoloPuedeJugarUnaCartaSuya
	
	| ronda |
	ronda := self defaultRonda.
	ronda juega: #Mano carta: (self cartasMano at: 1).
	
	self should: [ronda juega: #Pie carta: (self cartasMano at: 1).]
		raise: Error - MessageNotUnderstood
		withMessageText: Ronda cartaInvalidaErrorDescription.! !

!RondaTest methodsFor: 'tests - enfrentamientos' stamp: 'LB 7/5/2021 21:06:57'!
test13_SeLimpiaLaMesaAlFinalizarElEnfrentamiento
	| ronda |
	ronda := self defaultRonda.
	ronda juega: #Mano carta: (self cartasMano at: 1).
	ronda juega: #Pie carta: (self cartasPie at: 1).

	self assert: 0 equals: ronda mesa size.! !

!RondaTest methodsFor: 'tests - enfrentamientos' stamp: 'LB 7/5/2021 21:07:00'!
test14_GanadorManoComienzaElSiguienteEnfrentamiento

	| ronda |
	ronda := self defaultRonda.
	ronda juega: #Mano carta: (self cartasMano at: 2). "3 de espada"
	ronda juega: #Pie carta: (self cartasPie at: 1). "1 de oro"
	
	self assert: #Mano equals: ronda turno.! !

!RondaTest methodsFor: 'tests - enfrentamientos' stamp: 'LB 7/5/2021 21:07:03'!
test15_GanadorPieComienzaElSiguienteEnfrentamiento

	| ronda |
	ronda := self defaultRonda.
	ronda juega: #Mano carta: (self cartasMano at: 1). "4 de espada"
	ronda juega: #Pie carta: (self cartasPie at: 1). "1 de oro"
	
	self assert: #Pie equals: ronda turno.! !

!RondaTest methodsFor: 'tests - enfrentamientos' stamp: 'LB 7/5/2021 21:27:26'!
test16_GanadorDeEnfrentamientoGana1Punto

	| ronda |
	ronda := self defaultRonda.
	ronda juega: #Mano carta: (self cartasMano at: 2). "3 de espada"
	ronda juega: #Pie carta: (self cartasPie at: 1). "1 de oro"
	
	self assert: 0 equals: (ronda puntos: #Pie).
	self assert: 1 equals: (ronda puntos: #Mano).
	
	ronda juega: #Mano carta: (self cartasMano at: 1). "4 de espada"
	ronda juega: #Pie carta: (self cartasPie at: 2). "2 de espada"
	
	self assert: 1 equals: (ronda puntos: #Pie).
	self assert: 1 equals: (ronda puntos: #Mano).! !

!RondaTest methodsFor: 'tests - enfrentamientos' stamp: 'LB 7/5/2021 21:27:39'!
test17_ManoGanaEnSegundaRondaAlSumar2Puntos
	
	| ronda |
	ronda := self defaultRonda.
	ronda juega: #Mano carta: (self cartasMano at: 2). "3 de espada"
	ronda juega: #Pie carta: (self cartasPie at: 1). "1 de oro"
	ronda juega: #Mano carta: (self cartasMano at: 3). "6 de espada"
	ronda juega: #Pie carta: (self cartasPie at: 3). "5 de oro"
	
	self assert: 0 equals: (ronda puntos: #Pie).
	self assert: 2 equals: (ronda puntos: #Mano).! !

!RondaTest methodsFor: 'tests - enfrentamientos' stamp: 'LB 7/5/2021 21:27:56'!
test18_PieGanaEnTercerRondaAlSumar2Puntos
	
	| ronda |
	ronda := self defaultRonda.
	ronda juega: #Mano carta: (self cartasMano at: 2). "3 de espada"
	ronda juega: #Pie carta: (self cartasPie at: 3). "5 de oro"
	ronda juega: #Mano carta: (self cartasMano at: 3). "6 de espada"
	ronda juega: #Pie carta: (self cartasPie at: 1). "1 de oro"
	ronda juega: #Pie carta: (self cartasPie at: 2). "2 de oro"
	ronda juega: #Mano carta: (self cartasMano at: 1). "4 de espada"
	
	self assert: 2 equals: (ronda puntos: #Pie).
	self assert: 1 equals: (ronda puntos: #Mano).
	self assert: #Pie equals: ronda ganador.! !

!RondaTest methodsFor: 'tests - enfrentamientos' stamp: 'LB 7/5/2021 21:13:18'!
test19_NoSePuedeVolverAJugarLaMismaCarta

	| ronda |
	ronda := self defaultRonda.
	ronda juega: #Mano carta: (self cartasMano at: 2). "3 de espada"
	ronda juega: #Pie carta: (self cartasPie at: 3). "5 de oro"

	
	self should: [ronda juega: #Mano carta: (self cartasMano at: 2)]
		raise: Error - MessageNotUnderstood 
		withMessageText: Ronda cartaInvalidaErrorDescription.
! !

!RondaTest methodsFor: 'tests - enfrentamientos' stamp: 'LB 7/5/2021 21:28:01'!
test20_CartasDelMismoValorDefinenPardaYElTurnoSiguienteLoTieneMano

	| mano pie ronda |
	mano := OrderedCollection with: (CartaDeTruco espadaCon: 4) with: 	(CartaDeTruco oroCon: 5) with: (CartaDeTruco oroCon: 6).
	pie := OrderedCollection with: (CartaDeTruco oroCon: 4) with: 	(CartaDeTruco oroCon: 2) with: (CartaDeTruco oroCon: 3).
	ronda := Ronda withMano: mano pie: pie.
	
	ronda juega: #Mano carta: (CartaDeTruco espadaCon: 4).
	ronda juega: #Pie carta: (CartaDeTruco oroCon: 4).

	self assert: 1 equals: (ronda puntos: #Pie).
	self assert: 1 equals: (ronda puntos: #Mano).
	self assert: #Mano equals: ronda turno.! !

!RondaTest methodsFor: 'tests - enfrentamientos' stamp: 'LB 7/5/2021 20:51:12'!
test21_NoExisteGanadorAntesDeFinalizarRonda

	| ronda |
	ronda := Ronda withMano: self cartasMano pie: self cartasPie.
	ronda juega: #Mano carta: (self cartasMano at: 2). "3 de espada"
	ronda juega: #Pie carta: (self cartasPie at: 1). "1 de oro"
	
	self assert: Ronda aunNoHayGanador equals: ronda ganador.! !

!RondaTest methodsFor: 'tests - enfrentamientos' stamp: 'LB 7/5/2021 21:14:00'!
test22_NoSePuedeSeguirJugandoUnaVezFinalizadaLaRonda

	| ronda |
	ronda := self defaultRonda.
	ronda juega: #Mano carta: (self cartasMano at: 2). "3 de espada"
	ronda juega: #Pie carta: (self cartasPie at: 1). "1 de oro"
	ronda juega: #Mano carta: (self cartasMano at: 3). "6 de espada"
	ronda juega: #Pie carta: (self cartasPie at: 3). "5 de oro"
	
	"gana mano"
	
	self should: [ronda juega: #Mano carta: (CartaDeTruco oroCon: 3)]
		raise: Error - MessageNotUnderstood 
		withMessageText: Ronda haFinalizadoLaRondaErrorDescription.! !


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


!classDefinition: #Ronda category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #Ronda
	instanceVariableNames: 'cartasJugadas turno puntosPie puntosMano cartas puntos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Ronda methodsFor: 'inicialization' stamp: 'LB 7/5/2021 21:29:33'!
initializeWithMano: mano pie: pie.

	cartas := Dictionary new.
	cartas at: #Mano put: mano.
	cartas at: #Pie put: pie.
	
	cartasJugadas := Dictionary new.
	turno := #Mano.
	
	puntos := Dictionary new.
	puntos at: #Mano put: 0.
	puntos at: #Pie put: 0.! !


!Ronda methodsFor: 'testing' stamp: 'LB 7/5/2021 21:31:41'!
ganador
	(self gano: #Mano) ifTrue: [^#Mano].
	(self gano: #Pie) ifTrue: [^#Pie].
	^ self class aunNoHayGanador.! !

!Ronda methodsFor: 'testing' stamp: 'LB 7/5/2021 21:31:12'!
gano: unJugador
	^(puntos at: unJugador) = 2! !

!Ronda methodsFor: 'testing' stamp: 'LB 7/5/2021 19:05:49'!
mesa
	^cartasJugadas! !

!Ronda methodsFor: 'testing' stamp: 'LB 7/5/2021 21:26:15'!
puntos: unJugador
	^puntos at: unJugador! !

!Ronda methodsFor: 'testing' stamp: 'LB 7/5/2021 19:08:21'!
turno
	^turno! !


!Ronda methodsFor: 'private' stamp: 'LB 7/5/2021 21:35:16'!
assertAunNoFinalizoLaRonda
	((self ganador = #Pie) or: [self ganador = #Mano]) ifTrue: [^self error: self class haFinalizadoLaRondaErrorDescription ].! !

!Ronda methodsFor: 'private' stamp: 'LB 7/5/2021 21:16:34'!
assertEsTurnoDe: unJugador
	(turno = unJugador) ifFalse: [^self error: self class noEsTuTurnoErrorDescription ].! !

!Ronda methodsFor: 'private' stamp: 'LB 7/5/2021 20:06:32'!
jugadorOpuesto: unJugador
	(unJugador = #Pie) ifTrue: [^#Mano].
	(unJugador = #Mano) ifTrue: [^#Pie].! !

!Ronda methodsFor: 'private' stamp: 'LB 7/5/2021 21:21:33'!
turnoSiguiente: unJugador
	turno := unJugador! !


!Ronda methodsFor: 'enfrentamiento' stamp: 'LB 7/5/2021 21:40:38'!
checkFinDeEnfrentamiento
	
	(self mesa size = 2) ifTrue: [
		self sumarPuntosAlGanador.
		cartasJugadas removeAll.
	]! !

!Ronda methodsFor: 'enfrentamiento' stamp: 'LB 7/5/2021 21:37:08'!
enfrentamientoEmparda
	self turnoSiguiente: #Mano. 
	self sumarPuntos: #Pie.
	self sumarPuntos: #Mano! !

!Ronda methodsFor: 'enfrentamiento' stamp: 'LB 7/5/2021 21:37:03'!
ganaEnfrentamiento: unJugador
	self turnoSiguiente: unJugador.  
	self sumarPuntos: unJugador! !

!Ronda methodsFor: 'enfrentamiento' stamp: 'LB 7/5/2021 21:25:54'!
sumarPuntos: unJugador
	puntos at: unJugador put: (puntos at: unJugador) + 1.
	! !

!Ronda methodsFor: 'enfrentamiento' stamp: 'LB 7/5/2021 21:40:38'!
sumarPuntosAlGanador
	
	((self mesa at: #Mano) mataA: (self mesa at: #Pie)) ifTrue: [^self ganaEnfrentamiento: #Mano].
	((self mesa at: #Pie) mataA: (self mesa at: #Mano)) ifTrue: [^self ganaEnfrentamiento: #Pie].
	^self enfrentamientoEmparda
	! !


!Ronda methodsFor: 'play' stamp: 'LB 7/5/2021 21:35:16'!
juega: unJugador carta: unaCarta
	self assertAunNoFinalizoLaRonda.
	self assertEsTurnoDe: unJugador.
	
	((cartas at: unJugador) includes: unaCarta) ifFalse: [^self error: self class cartaInvalidaErrorDescription].
	cartasJugadas at: unJugador put: unaCarta.
	(cartas at: unJugador) remove: unaCarta.
	
	self turnoSiguiente: (self jugadorOpuesto: unJugador).
	self checkFinDeEnfrentamiento.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ronda class' category: 'ISW1-2021-1C-2doParcial'!
Ronda class
	instanceVariableNames: ''!

!Ronda class methodsFor: 'asserts' stamp: 'LB 7/5/2021 21:48:24'!
assertCartasValidasEn: mano y: pie
	|cartas|
	cartas := OrderedCollection new.
	cartas addAll: mano.
	cartas addAll: pie.
	
	self assertNoHayCartasRepetidasEn: cartas.
	self assertNoHayCartasInvalidasEn: cartas.
	
	! !

!Ronda class methodsFor: 'asserts' stamp: 'LB 7/5/2021 21:47:34'!
assertNoHayCartasInvalidasEn: cartas
	(cartas anySatisfy: [:carta | carta class ~= CartaDeTruco]) ifTrue: [^self error: self cartasInvalidasErrorDescription ].! !

!Ronda class methodsFor: 'asserts' stamp: 'LB 7/5/2021 21:47:47'!
assertNoHayCartasRepetidasEn: cartas
	
	(cartas anySatisfy: [:carta | (cartas occurrencesOf: carta) > 1]) ifTrue: [^self error: self cartasRepetidasErrorDescription].! !


!Ronda class methodsFor: 'instance creation' stamp: 'LB 7/5/2021 21:48:38'!
withMano: mano pie: pie
	
	self assertCartasValidasEn: mano y: pie.

	^ self new initializeWithMano: mano pie: pie.! !


!Ronda class methodsFor: 'messages' stamp: 'LB 7/5/2021 20:51:32'!
aunNoHayGanador
	^'Aun no hay ganador'! !


!Ronda class methodsFor: 'error' stamp: 'LB 7/5/2021 18:56:09'!
cartaInvalidaErrorDescription
	^'No tienes esa carta'! !

!Ronda class methodsFor: 'error' stamp: 'LB 7/5/2021 18:43:54'!
cartasInvalidasErrorDescription
	^'Cartas invalidas'! !

!Ronda class methodsFor: 'error' stamp: 'LB 7/5/2021 18:37:40'!
cartasRepetidasErrorDescription
	^'error las cartas no pueden repetirse'! !

!Ronda class methodsFor: 'error' stamp: 'LB 7/5/2021 21:02:40'!
haFinalizadoLaRondaErrorDescription
	^'Error la ronda ya ha finalizado.'! !

!Ronda class methodsFor: 'error' stamp: 'LB 7/5/2021 18:53:54'!
noEsTuTurnoErrorDescription
	^'Error es el turno del otro jugador'! !
