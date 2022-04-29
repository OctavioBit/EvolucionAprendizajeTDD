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


!classDefinition: #EnfrentamientoDeTrucoTest category: 'ISW1-2021-1C-2doParcial'!
TestCase subclass: #EnfrentamientoDeTrucoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!EnfrentamientoDeTrucoTest methodsFor: 'tests' stamp: 'FG 7/5/2021 18:32:14'!
test01EnfrentamientoEmpiezaJugandoElPrimerJugador

	| enfrentamientoDeTrucoEmpezadaPorMano enfrentamientoDeTrucoEmpezadaPorPie |
	
	enfrentamientoDeTrucoEmpezadaPorMano := EnfrentamientoDeTruco empezandoPor: #Mano.
	enfrentamientoDeTrucoEmpezadaPorPie := EnfrentamientoDeTruco empezandoPor: #Pie.
	
	self assert: enfrentamientoDeTrucoEmpezadaPorMano estaJugandoLaMano.
	self deny: enfrentamientoDeTrucoEmpezadaPorMano estaJugandoElPie.
	
	self assert: enfrentamientoDeTrucoEmpezadaPorPie estaJugandoElPie.
	self deny: enfrentamientoDeTrucoEmpezadaPorPie estaJugandoLaMano.
	! !

!EnfrentamientoDeTrucoTest methodsFor: 'tests' stamp: 'FG 7/5/2021 21:17:07'!
test02PieNoPuedeJugarSiJuegaLaMano

	| rondaDeTruco |
	
	rondaDeTruco := EnfrentamientoDeTruco empezandoPor: #Mano.
	
	self should: [rondaDeTruco pieJuega: (CartaDeTruco copaCon: 4)]
		raise: Error
		withExceptionDo: [:anError | 
				self assert: anError messageText equals:  EnfrentamientoDeTruco errorDeJugadaInvalida.
				self assert: rondaDeTruco estaJugandoLaMano.
			]. ! !

!EnfrentamientoDeTrucoTest methodsFor: 'tests' stamp: 'FG 7/5/2021 21:17:03'!
test03ManoNoPuedeJugarSiJuegaElPie

	| rondaDeTruco |
	
	rondaDeTruco := EnfrentamientoDeTruco empezandoPor: #Pie.
		
	self should: [rondaDeTruco manoJuega: (CartaDeTruco copaCon: 4)]
		raise: Error
		withExceptionDo: [:anError | 
				self assert: anError messageText equals:  EnfrentamientoDeTruco errorDeJugadaInvalida.
				self deny: rondaDeTruco estaJugandoLaMano.
				self assert: rondaDeTruco estaJugandoElPie.
			]. 
	! !

!EnfrentamientoDeTrucoTest methodsFor: 'tests' stamp: 'FG 7/5/2021 18:42:29'!
test04SePasaAlTurnoDelSiguienteJugadorLuegoDeJugarUnaCarta

	| enfrentamientoDeTrucoEmpezandoLaMano enfrentamientoDeTrucoEmpezandoElPie |
	
	enfrentamientoDeTrucoEmpezandoLaMano := EnfrentamientoDeTruco empezandoPor: #Mano.
	enfrentamientoDeTrucoEmpezandoElPie := EnfrentamientoDeTruco empezandoPor: #Pie.
		
	enfrentamientoDeTrucoEmpezandoLaMano manoJuega: CartaDeTruco anchoDeEspada.
	enfrentamientoDeTrucoEmpezandoElPie pieJuega: CartaDeTruco anchoDeEspada.
	
	self assert: enfrentamientoDeTrucoEmpezandoLaMano estaJugandoElPie.
	self deny: enfrentamientoDeTrucoEmpezandoLaMano estaJugandoLaMano.

	self assert: enfrentamientoDeTrucoEmpezandoElPie estaJugandoLaMano.
	self deny: enfrentamientoDeTrucoEmpezandoElPie estaJugandoElPie.

	
	
	! !

!EnfrentamientoDeTrucoTest methodsFor: 'tests' stamp: 'FG 7/5/2021 18:47:26'!
test05LuegoDeQueAmbosJugadoresJugaranUnaCartaElEnfrentamientoTermina

	| enfrentamientoDeTruco |
	
	enfrentamientoDeTruco := EnfrentamientoDeTruco empezandoPor: #Mano.
	
	enfrentamientoDeTruco manoJuega: CartaDeTruco anchoDeEspada.
	enfrentamientoDeTruco pieJuega: CartaDeTruco anchoDeBasto.
	
	
	self assert: enfrentamientoDeTruco termino.
	self deny: enfrentamientoDeTruco estaJugandoLaMano.
	self deny: enfrentamientoDeTruco estaJugandoElPie.

	
	
	! !

!EnfrentamientoDeTrucoTest methodsFor: 'tests' stamp: 'FG 7/5/2021 19:20:46'!
test06ElGanadorDelEnfrentamientoEsDecididoPorQuienTieneLaMejorCarta

	| enfrentamientoDeTrucoEnLaQueGanaMano enfrentamientoDeTrucoEnLaQueGanaPie |
	
	enfrentamientoDeTrucoEnLaQueGanaMano := EnfrentamientoDeTruco empezandoPor: #Mano.
	
	enfrentamientoDeTrucoEnLaQueGanaMano manoJuega: CartaDeTruco anchoDeEspada .
	enfrentamientoDeTrucoEnLaQueGanaMano pieJuega: CartaDeTruco anchoDeBasto.	
	
	self assert: enfrentamientoDeTrucoEnLaQueGanaMano termino.
	self assert: enfrentamientoDeTrucoEnLaQueGanaMano ganador equals: #Mano.
	
	
	enfrentamientoDeTrucoEnLaQueGanaPie := EnfrentamientoDeTruco empezandoPor: #Mano.
	
	enfrentamientoDeTrucoEnLaQueGanaPie manoJuega: CartaDeTruco anchoDeBasto.
	enfrentamientoDeTrucoEnLaQueGanaPie pieJuega: CartaDeTruco anchoDeEspada.	
	
	self assert: enfrentamientoDeTrucoEnLaQueGanaPie termino.
	self assert: enfrentamientoDeTrucoEnLaQueGanaPie ganador equals: #Pie.! !

!EnfrentamientoDeTrucoTest methodsFor: 'tests' stamp: 'FG 7/5/2021 19:24:54'!
test07ElEnfrentamientoPuedeTerminarEnEmparde

	| enfrentamientoDeTruco | 
	
	enfrentamientoDeTruco := EnfrentamientoDeTruco empezandoPor: #Mano.
	
	enfrentamientoDeTruco manoJuega: (CartaDeTruco bastoCon: 4).
	enfrentamientoDeTruco pieJuega: (CartaDeTruco copaCon: 4).
	
	self assert: enfrentamientoDeTruco termino.
	self assert: enfrentamientoDeTruco empardado.
	
	! !


!classDefinition: #RondaDeTrucoTest category: 'ISW1-2021-1C-2doParcial'!
TestCase subclass: #RondaDeTrucoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'FG 7/5/2021 20:52:30'!
test01RondaDeTrucoEmpiezaJugandoLaMano

	|rondaDeTruco|
	
	rondaDeTruco := RondaDeTruco new.
	
	self assert: rondaDeTruco estaJugandoLaMano.
	self assert: rondaDeTruco primeraRonda.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'FG 7/5/2021 20:54:22'!
test02EnElSegundoEnfrentamientoComienzaElGanadorDelPrimero

	|rondaDeTruco|
	
	rondaDeTruco := RondaDeTruco new.
	
	rondaDeTruco manoJuega: CartaDeTruco anchoDeBasto.
	rondaDeTruco pieJuega: CartaDeTruco anchoDeEspada.
	
	self assert: rondaDeTruco segundaRonda.
	self assert: rondaDeTruco estaJugandoElPie.

	
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'FG 7/5/2021 20:58:14'!
test03EnElTercerEnfrentamientoComienzaElGanadorDelSegundo

	|rondaDeTruco|
	
	rondaDeTruco := RondaDeTruco new.
	
	rondaDeTruco manoJuega: CartaDeTruco anchoDeBasto.
	rondaDeTruco pieJuega: CartaDeTruco anchoDeEspada.
	
	rondaDeTruco pieJuega: (CartaDeTruco oroCon: 7).
	rondaDeTruco manoJuega: (CartaDeTruco espadaCon: 7).
	
	self assert: rondaDeTruco estaJugandoLaMano.

	
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'FG 7/5/2021 19:50:22'!
test04AlTerminarLaTerceraRondaDebeHaberUnGanador

	|rondaDeTruco|
	
	rondaDeTruco := RondaDeTruco new.
	
	rondaDeTruco manoJuega: CartaDeTruco anchoDeBasto.
	rondaDeTruco pieJuega: CartaDeTruco anchoDeEspada.
	
	rondaDeTruco pieJuega: (CartaDeTruco oroCon: 7).
	rondaDeTruco manoJuega: (CartaDeTruco espadaCon: 7).
	
	rondaDeTruco manoJuega: (CartaDeTruco oroCon: 4).
	rondaDeTruco pieJuega: (CartaDeTruco oroCon: 5).
	
	self assert: rondaDeTruco termino.
	self assert: rondaDeTruco ganador equals: #Pie.

	
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'FG 7/5/2021 21:02:02'!
test05JugadorPuedeGanarEnLaSegundaRonda


	|rondaDeTruco|
	
	rondaDeTruco := RondaDeTruco new.
	
	rondaDeTruco manoJuega: CartaDeTruco anchoDeBasto.
	rondaDeTruco pieJuega: CartaDeTruco anchoDeEspada.
	
	rondaDeTruco pieJuega: (CartaDeTruco espadaCon: 7).
	rondaDeTruco manoJuega: (CartaDeTruco oroCon: 7).
	
	self assert: rondaDeTruco termino.
	self assert: rondaDeTruco ganador equals: #Pie.
	
	

	

	
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'FG 7/5/2021 21:03:27'!
test06SegundaRondaDefineSiLaPrimeraFueParda


	|rondaDeTruco|
	
	rondaDeTruco := RondaDeTruco new.
	
	rondaDeTruco manoJuega: (CartaDeTruco oroCon: 5).
	rondaDeTruco pieJuega: (CartaDeTruco espadaCon: 5).
	
	rondaDeTruco manoJuega: (CartaDeTruco oroCon: 7).
	rondaDeTruco pieJuega: (CartaDeTruco espadaCon: 7).
	
	self assert: rondaDeTruco termino.
	self assert: rondaDeTruco ganador equals: #Pie.
	
	

	

	
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'FG 7/5/2021 21:41:11'!
test07NoSePuedeSeguirJugandoLaRondaUnaVezQueTermino

	|rondaDeTruco|
	
	rondaDeTruco := RondaDeTruco new.
	
	rondaDeTruco manoJuega: (CartaDeTruco oroCon: 5).
	rondaDeTruco pieJuega: (CartaDeTruco espadaCon: 5).
	
	rondaDeTruco manoJuega: (CartaDeTruco oroCon: 7).
	rondaDeTruco pieJuega: (CartaDeTruco espadaCon: 7).
	
	self assert: rondaDeTruco termino.
	self assert: rondaDeTruco ganador equals: #Pie.
	
	self should: [rondaDeTruco manoJuega: (CartaDeTruco anchoDeEspada) ]
		raise:  Error
		description: RondaDeTruco errorDeJuegoTerminado.
	
	

	

	
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


!classDefinition: #EnfrentamientoDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #EnfrentamientoDeTruco
	instanceVariableNames: 'estadoEnfrentamiento numeroDeJugadas cartaDeMano cartaDePie'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!EnfrentamientoDeTruco methodsFor: 'acciones privado' stamp: 'FG 7/5/2021 19:17:38'!
ganadorDelEnfrentamiento

	^ (cartaDeMano mataA: cartaDePie) 
			ifTrue: [#Mano]
			ifFalse: [#Pie]
	! !

!EnfrentamientoDeTruco methodsFor: 'acciones privado' stamp: 'FG 7/5/2021 18:09:15'!
jugadorJuegaCuandoNoEsSuTurno 

	self error: EnfrentamientoDeTruco errorDeJugadaInvalida.

	! !

!EnfrentamientoDeTruco methodsFor: 'acciones privado' stamp: 'FG 7/5/2021 21:23:54'!
manoJuegaEnSuTurno: unaCarta

	numeroDeJugadas := numeroDeJugadas + 1.
	cartaDeMano := unaCarta.
	(numeroDeJugadas < 2) 
		ifTrue: [estadoEnfrentamiento := JugandoPie de: self.]
		ifFalse: [ self terminarEnfrentamiento			].
	! !

!EnfrentamientoDeTruco methodsFor: 'acciones privado' stamp: 'FG 7/5/2021 21:23:40'!
pieJuegaEnSuTurno: unaCarta

	numeroDeJugadas := numeroDeJugadas + 1.
	cartaDePie := unaCarta.
	(numeroDeJugadas < 2) 
		ifTrue: [estadoEnfrentamiento := JugandoMano de: self.]
		ifFalse: [self terminarEnfrentamiento.]

	
	! !

!EnfrentamientoDeTruco methodsFor: 'acciones privado' stamp: 'FG 7/5/2021 21:22:20'!
terminarEnfrentamiento

	^ (cartaDeMano empardaCon: cartaDePie) 
					ifTrue: [ 	estadoEnfrentamiento := EnfrentamientoEmpardado de: self. ]
					ifFalse: [ estadoEnfrentamiento := EnfrentamientoConGanador de: self ganadoPor: self ganadorDelEnfrentamiento]! !


!EnfrentamientoDeTruco methodsFor: 'acciones' stamp: 'FG 7/5/2021 18:15:18'!
manoJuega: unaCarta 

	estadoEnfrentamiento manoJuega: unaCarta.
	! !

!EnfrentamientoDeTruco methodsFor: 'acciones' stamp: 'FG 7/5/2021 18:15:30'!
pieJuega: unaCarta

	estadoEnfrentamiento pieJuega: unaCarta.! !


!EnfrentamientoDeTruco methodsFor: 'initialization' stamp: 'FG 7/5/2021 21:18:18'!
initializeWith: unJugador

	numeroDeJugadas := 0.
	estadoEnfrentamiento := EstadoDeEnfrentamiento de: self dondeEmpieza: unJugador.! !


!EnfrentamientoDeTruco methodsFor: 'testing' stamp: 'FG 7/5/2021 19:23:36'!
empardado

	^ estadoEnfrentamiento empardado.! !

!EnfrentamientoDeTruco methodsFor: 'testing' stamp: 'FG 7/5/2021 18:05:12'!
estaJugandoElPie
	
	^ estadoEnfrentamiento estaJugandoElPie.! !

!EnfrentamientoDeTruco methodsFor: 'testing' stamp: 'FG 7/5/2021 18:05:23'!
estaJugandoLaMano

	^ estadoEnfrentamiento estaJugandoLaMano.! !

!EnfrentamientoDeTruco methodsFor: 'testing' stamp: 'FG 7/5/2021 19:19:16'!
ganador 

	^ estadoEnfrentamiento ganador.! !

!EnfrentamientoDeTruco methodsFor: 'testing' stamp: 'FG 7/5/2021 19:45:45'!
termino 

	^ estadoEnfrentamiento termino.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnfrentamientoDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
EnfrentamientoDeTruco class
	instanceVariableNames: ''!

!EnfrentamientoDeTruco class methodsFor: 'errores' stamp: 'FG 7/5/2021 17:45:34'!
errorDeJugadaInvalida

	^ 'Error - Jugada Invalida'! !

!EnfrentamientoDeTruco class methodsFor: 'errores' stamp: 'FG 7/5/2021 21:21:17'!
errorEnfrentamientoSinGanador

	^ 'Error - Enfrentamiento sin ganador'! !


!EnfrentamientoDeTruco class methodsFor: 'instance creation' stamp: 'FG 7/5/2021 18:28:39'!
empezandoPor: unJugador
	
	^ self new initializeWith: unJugador.! !


!classDefinition: #EstadoDeEnfrentamiento category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #EstadoDeEnfrentamiento
	instanceVariableNames: 'enfrentamiento'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!EstadoDeEnfrentamiento methodsFor: 'testing' stamp: 'FG 7/5/2021 19:24:28'!
empardado
	^ false.! !

!EstadoDeEnfrentamiento methodsFor: 'testing' stamp: 'FG 7/5/2021 21:25:52'!
estaJugandoElPie

	^ false.! !

!EstadoDeEnfrentamiento methodsFor: 'testing' stamp: 'FG 7/5/2021 21:35:36'!
estaJugandoLaMano

	^ false.! !

!EstadoDeEnfrentamiento methodsFor: 'testing' stamp: 'FG 7/5/2021 21:21:03'!
ganador 

	self error: EnfrentamientoDeTruco errorEnfrentamientoSinGanador.! !

!EstadoDeEnfrentamiento methodsFor: 'testing' stamp: 'FG 7/5/2021 18:47:41'!
termino 

	^ false.! !


!EstadoDeEnfrentamiento methodsFor: 'acciones' stamp: 'FG 7/5/2021 21:33:03'!
manoJuega: unaCarta

	enfrentamiento jugadorJuegaCuandoNoEsSuTurno.! !

!EstadoDeEnfrentamiento methodsFor: 'acciones' stamp: 'FG 7/5/2021 21:33:15'!
pieJuega: unaCarta

	enfrentamiento jugadorJuegaCuandoNoEsSuTurno.! !


!EstadoDeEnfrentamiento methodsFor: 'initialization' stamp: 'FG 7/5/2021 18:13:49'!
initializeWith: unEnfrentamiento

	enfrentamiento  := unEnfrentamiento.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EstadoDeEnfrentamiento class' category: 'ISW1-2021-1C-2doParcial'!
EstadoDeEnfrentamiento class
	instanceVariableNames: ''!

!EstadoDeEnfrentamiento class methodsFor: 'errror' stamp: 'FG 7/5/2021 18:26:59'!
jugadorInvalido 

	^ 'Error - Jugador Invalido'
	! !


!EstadoDeEnfrentamiento class methodsFor: 'instance creation' stamp: 'FG 7/5/2021 18:27:33'!
de: unEnfrentamiento 

	^ self new initializeWith: unEnfrentamiento.
	! !

!EstadoDeEnfrentamiento class methodsFor: 'instance creation' stamp: 'FG 7/5/2021 18:27:52'!
de: unEnfrentamiento dondeEmpieza: unJugador

	^ self subclasses 
		detect: [:unEstadoDeEnfrentamiento | unEstadoDeEnfrentamiento jugador = unJugador]   
		ifFound: [:unEstadoDeEnfrentamiento | unEstadoDeEnfrentamiento new initializeWith: unEnfrentamiento]  
		ifNone: [self error: EstadoDeEnfrentamiento jugadorInvalido]

	! !


!classDefinition: #EnfrentamientoTerminado category: 'ISW1-2021-1C-2doParcial'!
EstadoDeEnfrentamiento subclass: #EnfrentamientoTerminado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!EnfrentamientoTerminado methodsFor: 'testing' stamp: 'FG 7/5/2021 18:47:53'!
termino 

	^ true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnfrentamientoTerminado class' category: 'ISW1-2021-1C-2doParcial'!
EnfrentamientoTerminado class
	instanceVariableNames: ''!

!EnfrentamientoTerminado class methodsFor: 'jugador' stamp: 'FG 7/5/2021 18:22:02'!
jugador

	^ #Ninguno! !


!classDefinition: #EnfrentamientoConGanador category: 'ISW1-2021-1C-2doParcial'!
EnfrentamientoTerminado subclass: #EnfrentamientoConGanador
	instanceVariableNames: 'ganador'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!EnfrentamientoConGanador methodsFor: 'ganador' stamp: 'FG 7/5/2021 21:30:31'!
ganador 

	^ ganador! !

!EnfrentamientoConGanador methodsFor: 'ganador' stamp: 'FG 7/5/2021 21:36:56'!
initializeDe: unEnfrentamiento GanadoPor: unGanador

	enfrentamiento := unEnfrentamiento.
	ganador := unGanador.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnfrentamientoConGanador class' category: 'ISW1-2021-1C-2doParcial'!
EnfrentamientoConGanador class
	instanceVariableNames: ''!

!EnfrentamientoConGanador class methodsFor: 'instance creation' stamp: 'FG 7/5/2021 21:27:30'!
de: unEnfrentamiento ganadoPor: unGanador

	^ self new initializeDe: unEnfrentamiento GanadoPor: unGanador.! !


!classDefinition: #EnfrentamientoEmpardado category: 'ISW1-2021-1C-2doParcial'!
EnfrentamientoTerminado subclass: #EnfrentamientoEmpardado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!EnfrentamientoEmpardado methodsFor: 'empardado' stamp: 'FG 7/5/2021 21:16:08'!
empardado

	^ true.! !


!classDefinition: #JugandoMano category: 'ISW1-2021-1C-2doParcial'!
EstadoDeEnfrentamiento subclass: #JugandoMano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!JugandoMano methodsFor: 'testing' stamp: 'FG 7/5/2021 18:02:22'!
estaJugandoLaMano
	^ true.! !


!JugandoMano methodsFor: 'acciones' stamp: 'FG 7/5/2021 18:11:51'!
manoJuega: unaCarta

	enfrentamiento manoJuegaEnSuTurno: unaCarta.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'JugandoMano class' category: 'ISW1-2021-1C-2doParcial'!
JugandoMano class
	instanceVariableNames: ''!

!JugandoMano class methodsFor: 'jugador' stamp: 'FG 7/5/2021 18:22:12'!
jugador

	^ #Mano! !


!classDefinition: #JugandoPie category: 'ISW1-2021-1C-2doParcial'!
EstadoDeEnfrentamiento subclass: #JugandoPie
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!JugandoPie methodsFor: 'testing' stamp: 'FG 7/5/2021 18:03:04'!
estaJugandoElPie
	^ true.! !


!JugandoPie methodsFor: 'acciones' stamp: 'FG 7/5/2021 18:12:41'!
pieJuega: unaCarta

	enfrentamiento pieJuegaEnSuTurno: unaCarta.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'JugandoPie class' category: 'ISW1-2021-1C-2doParcial'!
JugandoPie class
	instanceVariableNames: ''!

!JugandoPie class methodsFor: 'jugador' stamp: 'FG 7/5/2021 18:22:21'!
jugador

	^ #Pie! !


!classDefinition: #EstadoDeRonda category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #EstadoDeRonda
	instanceVariableNames: 'ronda'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!EstadoDeRonda methodsFor: 'testing' stamp: 'FG 7/5/2021 19:58:16'!
estaJugandoElPie

	^ false.! !

!EstadoDeRonda methodsFor: 'testing' stamp: 'FG 7/5/2021 19:58:07'!
estaJugandoLaMano

	^ false.! !

!EstadoDeRonda methodsFor: 'testing' stamp: 'FG 7/5/2021 20:52:58'!
primeraRonda

	^ false.! !

!EstadoDeRonda methodsFor: 'testing' stamp: 'FG 7/5/2021 20:54:46'!
segundaRonda

	^ false.! !

!EstadoDeRonda methodsFor: 'testing' stamp: 'FG 7/5/2021 20:58:45'!
termino

	^ false.! !


!EstadoDeRonda methodsFor: 'acciones' stamp: 'FG 7/5/2021 21:43:47'!
manoJuega: unaCarta

	self subclassResponsibility.! !

!EstadoDeRonda methodsFor: 'acciones' stamp: 'FG 7/5/2021 21:44:16'!
pieJuega: unaCarta

	self subclassResponsibility.! !


!classDefinition: #EnEnfrentamiento category: 'ISW1-2021-1C-2doParcial'!
EstadoDeRonda subclass: #EnEnfrentamiento
	instanceVariableNames: 'enfrentamiento'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!EnEnfrentamiento methodsFor: 'testing' stamp: 'FG 7/5/2021 19:57:43'!
estaJugandoElPie

	^ enfrentamiento estaJugandoElPie.! !

!EnEnfrentamiento methodsFor: 'testing' stamp: 'FG 7/5/2021 19:57:32'!
estaJugandoLaMano

	^ enfrentamiento estaJugandoLaMano.! !

!EnEnfrentamiento methodsFor: 'testing' stamp: 'FG 7/5/2021 20:25:17'!
ganador
	
	^ enfrentamiento ganador.! !


!EnEnfrentamiento methodsFor: 'initialization' stamp: 'FG 7/5/2021 20:47:09'!
initializeEmpezandoPor: unJugador de: unaRonda

	ronda  := unaRonda.
	enfrentamiento := EnfrentamientoDeTruco empezandoPor: unJugador.! !


!EnEnfrentamiento methodsFor: 'terminar enfrentamiento' stamp: 'FG 7/5/2021 20:12:49'!
enfrentamientoTerminado 

	^ enfrentamiento termino.! !

!EnEnfrentamiento methodsFor: 'terminar enfrentamiento' stamp: 'FG 7/5/2021 21:11:07'!
terminarEnfrentamiento

	^ self subclassResponsibility.! !


!EnEnfrentamiento methodsFor: 'acciones' stamp: 'FG 7/5/2021 20:08:38'!
manoJuega: unaCarta

	enfrentamiento manoJuega: unaCarta.! !

!EnEnfrentamiento methodsFor: 'acciones' stamp: 'FG 7/5/2021 20:08:52'!
pieJuega: unaCarta

	enfrentamiento pieJuega: unaCarta.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnEnfrentamiento class' category: 'ISW1-2021-1C-2doParcial'!
EnEnfrentamiento class
	instanceVariableNames: ''!

!EnEnfrentamiento class methodsFor: 'instance creation' stamp: 'FG 7/5/2021 20:46:44'!
empezandoPor: unJugador de: unaRonda

	^ self new initializeEmpezandoPor: unJugador de: unaRonda. ! !


!classDefinition: #EnfrentamientoFinal category: 'ISW1-2021-1C-2doParcial'!
EnEnfrentamiento subclass: #EnfrentamientoFinal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!EnfrentamientoFinal methodsFor: 'terminar enfrentamiento' stamp: 'FG 7/5/2021 20:55:40'!
terminarEnfrentamiento

	ronda terminarRondaFinalLuegoDe: enfrentamiento.! !


!classDefinition: #PrimeraRonda category: 'ISW1-2021-1C-2doParcial'!
EnEnfrentamiento subclass: #PrimeraRonda
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!PrimeraRonda methodsFor: 'testing' stamp: 'FG 7/5/2021 20:53:10'!
primeraRonda 

	^ true.! !


!PrimeraRonda methodsFor: 'terminar enfrentamiento' stamp: 'FG 7/5/2021 20:44:09'!
terminarEnfrentamiento

	ronda terminarPrimeraRondaLuegoDe: enfrentamiento.! !


!classDefinition: #SegundaRonda category: 'ISW1-2021-1C-2doParcial'!
EnEnfrentamiento subclass: #SegundaRonda
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!SegundaRonda methodsFor: 'testing' stamp: 'FG 7/5/2021 20:55:04'!
segundaRonda

	^ true.! !


!SegundaRonda methodsFor: 'terminar enfrentamiento' stamp: 'FG 7/5/2021 20:56:16'!
terminarEnfrentamiento

	ronda terminarSegundaRondaLuegoDe: enfrentamiento.! !


!classDefinition: #RondaTerminada category: 'ISW1-2021-1C-2doParcial'!
EstadoDeRonda subclass: #RondaTerminada
	instanceVariableNames: 'ganador'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaTerminada methodsFor: 'testing' stamp: 'FG 7/5/2021 21:00:42'!
ganador

	^ ganador.! !

!RondaTerminada methodsFor: 'testing' stamp: 'FG 7/5/2021 20:58:59'!
termino 

	^ true.! !


!RondaTerminada methodsFor: 'acciones' stamp: 'FG 7/5/2021 21:43:29'!
manoJuega: unaCarta

	ronda jugarCuandoRondaTerminada.! !

!RondaTerminada methodsFor: 'acciones' stamp: 'FG 7/5/2021 21:43:32'!
pieJuega: unaCarta

	ronda jugarCuandoRondaTerminada.! !


!RondaTerminada methodsFor: 'initialization' stamp: 'FG 7/5/2021 20:49:01'!
initializeConGanador: unGanador de: unaRonda 

	ganador := unGanador.
	ronda := unaRonda.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RondaTerminada class' category: 'ISW1-2021-1C-2doParcial'!
RondaTerminada class
	instanceVariableNames: ''!

!RondaTerminada class methodsFor: 'instance creation' stamp: 'FG 7/5/2021 20:48:28'!
conGanador: unGanador de: unaRonda

	^ self new initializeConGanador: unGanador de: unaRonda ! !


!classDefinition: #RondaDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #RondaDeTruco
	instanceVariableNames: 'estadoDeRonda ventaja'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTruco methodsFor: 'terminar ronda' stamp: 'FG 7/5/2021 21:06:12'!
chequearSiLaRondaTermino

	^ (estadoDeRonda enfrentamientoTerminado)
		ifTrue: [ estadoDeRonda terminarEnfrentamiento]! !

!RondaDeTruco methodsFor: 'terminar ronda' stamp: 'FG 7/5/2021 21:04:52'!
terminarPrimeraRondaLuegoDe: unEnfrentamiento

	unEnfrentamiento empardado 
		ifTrue: [ estadoDeRonda := EnfrentamientoFinal empezandoPor: #Mano de: self ]
		ifFalse: [ 
			ventaja := unEnfrentamiento ganador.
			estadoDeRonda := SegundaRonda empezandoPor: unEnfrentamiento ganador de: self
		].! !

!RondaDeTruco methodsFor: 'terminar ronda' stamp: 'FG 7/5/2021 20:46:22'!
terminarRondaFinalLuegoDe: unEnfrentamiento

	estadoDeRonda := RondaTerminada conGanador: unEnfrentamiento ganador de: self.! !

!RondaDeTruco methodsFor: 'terminar ronda' stamp: 'FG 7/5/2021 20:44:28'!
terminarSegundaRondaLuegoDe: unEnfrentamiento

	unEnfrentamiento ganador = ventaja 
		ifTrue: [estadoDeRonda := RondaTerminada conGanador: unEnfrentamiento ganador de: self]
		ifFalse: [estadoDeRonda := EnfrentamientoFinal empezandoPor: unEnfrentamiento ganador de: self]! !


!RondaDeTruco methodsFor: 'acciones' stamp: 'FG 7/5/2021 21:43:13'!
jugarCuandoRondaTerminada

	self error: RondaDeTruco errorDeJuegoTerminado.! !

!RondaDeTruco methodsFor: 'acciones' stamp: 'FG 7/5/2021 21:06:12'!
manoJuega: unaCarta

	estadoDeRonda manoJuega: unaCarta.
	
	self chequearSiLaRondaTermino.! !

!RondaDeTruco methodsFor: 'acciones' stamp: 'FG 7/5/2021 20:45:43'!
pieJuega: unaCarta

	estadoDeRonda pieJuega: unaCarta.
	
	(estadoDeRonda enfrentamientoTerminado)
		ifTrue: [ 	estadoDeRonda terminarEnfrentamiento]. ! !


!RondaDeTruco methodsFor: 'testing' stamp: 'FG 7/5/2021 20:05:51'!
estaJugandoElPie

 	^ estadoDeRonda estaJugandoElPie.! !

!RondaDeTruco methodsFor: 'testing' stamp: 'FG 7/5/2021 20:06:02'!
estaJugandoLaMano

 	^ estadoDeRonda estaJugandoLaMano.! !

!RondaDeTruco methodsFor: 'testing' stamp: 'FG 7/5/2021 21:00:02'!
ganador

	^ estadoDeRonda ganador.! !

!RondaDeTruco methodsFor: 'testing' stamp: 'FG 7/5/2021 20:53:53'!
primeraRonda

	^ estadoDeRonda primeraRonda.! !

!RondaDeTruco methodsFor: 'testing' stamp: 'FG 7/5/2021 20:54:36'!
segundaRonda

	^ estadoDeRonda segundaRonda.! !

!RondaDeTruco methodsFor: 'testing' stamp: 'FG 7/5/2021 20:59:05'!
termino

	^ estadoDeRonda termino! !


!RondaDeTruco methodsFor: 'initialization' stamp: 'FG 7/5/2021 20:51:06'!
initialize

	ventaja := #NingunJugador.
	estadoDeRonda := PrimeraRonda empezandoPor: #Mano de: self. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RondaDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco class
	instanceVariableNames: ''!

!RondaDeTruco class methodsFor: 'errors' stamp: 'FG 7/5/2021 21:41:21'!
errorDeJuegoTerminado

	^ 'Error - Juego Terminado'! !
