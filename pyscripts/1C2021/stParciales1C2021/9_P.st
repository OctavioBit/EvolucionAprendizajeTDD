!classDefinition: #CartaDeTrucoTest category: 'ISW1-2021-1C-2doParcial'!
TestCase subclass: #CartaDeTrucoTest
	instanceVariableNames: 'mano pie cartasManoDefault cartasPieDefault manoAnchoDeBasto mano3DeOro mano2DeEspada pieAnchoDeEspada pie3DeBasto pie4DeBasto cartaNoDisponibleParaMano rondaDefault cartaNoDisponibleParaPie'
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


!CartaDeTrucoTest methodsFor: 'setUp' stamp: 'JPF 7/5/2021 19:53:52'!
setUp

	mano := JugadorDeTruco new.
	pie := JugadorDeTruco new.
	manoAnchoDeBasto _ CartaDeTruco anchoDeBasto.
	mano3DeOro _ CartaDeTruco oroCon: 3.
	mano2DeEspada _ CartaDeTruco espadaCon: 2.
	cartasManoDefault := {manoAnchoDeBasto. mano3DeOro. mano2DeEspada. }.
	pieAnchoDeEspada _ CartaDeTruco anchoDeEspada.
	pie3DeBasto _ CartaDeTruco bastoCon: 3.
	pie4DeBasto _ CartaDeTruco bastoCon: 4.
	cartasPieDefault := {pieAnchoDeEspada. pie3DeBasto. pie4DeBasto}.
	
	cartaNoDisponibleParaMano := CartaDeTruco oroCon: 1.
	cartaNoDisponibleParaPie := CartaDeTruco anchoDeBasto.
	
	rondaDefault := RondaDeTruco entre: mano comoManoCon: cartasManoDefault y: pie con: cartasPieDefault.
	! !


!CartaDeTrucoTest methodsFor: 'test - ronda - mensajes auxiliares' stamp: 'JPF 7/5/2021 19:33:02'!
cartasManoDefaultComoSet

	^ cartasManoDefault asSet! !

!CartaDeTrucoTest methodsFor: 'test - ronda - mensajes auxiliares' stamp: 'JPF 7/5/2021 19:33:32'!
cartasManoDefaultComoSetMenos: unaCartaDeTrucoAQuitar

	^ self cartasManoDefaultComoSet remove: unaCartaDeTrucoAQuitar ifAbsent: []; yourself! !

!CartaDeTrucoTest methodsFor: 'test - ronda - mensajes auxiliares' stamp: 'JPF 7/5/2021 19:33:10'!
cartasPieDefaultComoSet

	^ cartasPieDefault asSet! !

!CartaDeTrucoTest methodsFor: 'test - ronda - mensajes auxiliares' stamp: 'JPF 7/5/2021 20:07:18'!
cartasPieDefaultComoSetMenos: unaCartaDeTrucoAQuitar

	^ self cartasPieDefaultComoSet remove: unaCartaDeTrucoAQuitar ifAbsent: []; yourself! !


!CartaDeTrucoTest methodsFor: 'test - ronda' stamp: 'JPF 7/5/2021 18:25:00'!
test01NoSePuedeCrearUnaRondaDondeElMismoJugadorSeaManoYPie


	| cartasJugador1 cartasJugador2 |
	
	cartasJugador1 := {CartaDeTruco anchoDeBasto. CartaDeTruco anchoDeEspada. CartaDeTruco sieteDeEspada }.
	cartasJugador2 := {CartaDeTruco sieteDeOro. CartaDeTruco copaCon: 3. CartaDeTruco bastoCon: 3 }.
	
	self 
		should: [ RondaDeTruco entre: mano comoManoCon: cartasJugador1 y: mano con: cartasJugador2 ]
		raise: Error - MessageNotUnderstood 
		withMessageText: RondaDeTruco noSePuedeCrearRondaConElMismoJugadorComoManoYPieDescripcionDeError.! !

!CartaDeTrucoTest methodsFor: 'test - ronda' stamp: 'JPF 7/5/2021 18:24:09'!
test02NoSePuedeCrearUnaRondaDondeAlgunoDeLos2JugadoresNoTenga3Cartas


	| cartasDeMenos cartasCorrectas cartasDeMas |
	
	cartasDeMenos := {CartaDeTruco anchoDeBasto. CartaDeTruco anchoDeEspada }.
	cartasDeMas := {CartaDeTruco anchoDeBasto. CartaDeTruco anchoDeEspada. CartaDeTruco sieteDeEspada. CartaDeTruco bastoCon: 4}.
	cartasCorrectas := {CartaDeTruco sieteDeOro. CartaDeTruco copaCon: 3. CartaDeTruco bastoCon: 3 }.
	
	self 
		should: [ RondaDeTruco entre: mano comoManoCon: cartasDeMenos y: pie con: cartasCorrectas ]
		raise: Error - MessageNotUnderstood 
		withMessageText: RondaDeTruco noSePuedeCrearRondaSiAlgunoDeLosJugadoresNoTiene3CartasDescripcionDeError.
		
	self 
		should: [ RondaDeTruco entre: mano comoManoCon: cartasCorrectas y: pie con: cartasDeMas ]
		raise: Error - MessageNotUnderstood 
		withMessageText: RondaDeTruco noSePuedeCrearRondaSiAlgunoDeLosJugadoresNoTiene3CartasDescripcionDeError.! !

!CartaDeTrucoTest methodsFor: 'test - ronda' stamp: 'JPF 7/5/2021 18:35:20'!
test03NoSePuedeCrearUnaRondaConAlMenos1CartaRepetidaEntreLasRepartidas


	| cartasMano cartasPie |
	
	cartasMano := {CartaDeTruco anchoDeBasto. CartaDeTruco anchoDeEspada. CartaDeTruco sieteDeEspada. }.
	cartasPie := {CartaDeTruco anchoDeBasto. CartaDeTruco bastoCon: 3. CartaDeTruco bastoCon: 4}.
	
	self 
		should: [ RondaDeTruco entre: mano comoManoCon: cartasMano y: pie con: cartasPie ]
		raise: Error - MessageNotUnderstood 
		withMessageText: RondaDeTruco noSePuedeCrearRondaConUnaCartaRepetidaDescripcionDeError.! !

!CartaDeTrucoTest methodsFor: 'test - ronda' stamp: 'JPF 7/5/2021 19:05:48'!
test04ElPieNoPuedeEmpezarElJuego


	| ronda |
	
	
	
	ronda := RondaDeTruco entre: mano comoManoCon: cartasManoDefault y: pie con: cartasPieDefault.
	
	self 
		should: [ ronda jugar: cartasPieDefault first para: pie ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :error |
			self assert: RondaDeTruco noEsElTurnoDelJugadorQueTiroLaCartaDescripcionDeError equals: error messageText.
			self assert: cartasManoDefault asSet equals: ronda cartasDisponiblesMano.
			self assert: cartasPieDefault asSet equals: ronda cartasDisponiblesPie
			]
		! !

!CartaDeTrucoTest methodsFor: 'test - ronda' stamp: 'JPF 7/5/2021 19:27:51'!
test05LaManoPuedeJugarAlIniciarElJuego


	| ronda |
	
	
	
	ronda := RondaDeTruco entre: mano comoManoCon: cartasManoDefault y: pie con: cartasPieDefault.
	
	ronda jugar: manoAnchoDeBasto para: mano.
	
	self assert: (self cartasManoDefaultComoSetMenos: manoAnchoDeBasto) equals: ronda cartasDisponiblesMano.
	self assert: cartasPieDefault asSet equals: ronda cartasDisponiblesPie
		! !

!CartaDeTrucoTest methodsFor: 'test - ronda' stamp: 'JPF 7/5/2021 19:43:33'!
test06LaManoNoPuedeJugarUnaCartaQueNoTieneDisponible


	self 
		should: [ rondaDefault jugar: cartaNoDisponibleParaMano para: mano. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :error |
			self assert: RondaDeTruco cartaNoDisponibleParaElJugadorDescripcionDeError equals: error messageText.
			self assert: self cartasManoDefaultComoSet equals: rondaDefault cartasDisponiblesMano.
			self assert: self cartasPieDefaultComoSet equals: rondaDefault cartasDisponiblesPie
			]
	
	
	
	
		! !

!CartaDeTrucoTest methodsFor: 'test - ronda' stamp: 'JPF 7/5/2021 19:49:09'!
test07LaManoNoPuedeJugar2VecesSeguidas

	rondaDefault jugar: manoAnchoDeBasto para: mano.

	self 
		should: [ rondaDefault jugar: mano3DeOro para: mano. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :error |
			self assert: RondaDeTruco noEsElTurnoDelJugadorQueTiroLaCartaDescripcionDeError equals: error messageText.
			self assert: (self cartasManoDefaultComoSetMenos: manoAnchoDeBasto) equals: rondaDefault cartasDisponiblesMano .
			self assert: self cartasPieDefaultComoSet equals: rondaDefault cartasDisponiblesPie
			]
	
	
	
	
		! !

!CartaDeTrucoTest methodsFor: 'test - ronda' stamp: 'JPF 7/5/2021 19:53:16'!
test08ElPieNoPuedeJugarUnaCartaQueNoTieneDisponible

	rondaDefault jugar: manoAnchoDeBasto para: mano.

	self 
		should: [ rondaDefault jugar: cartaNoDisponibleParaPie para: pie. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :error |
			self assert: RondaDeTruco cartaNoDisponibleParaElJugadorDescripcionDeError equals: error messageText.
			self assert: (self cartasManoDefaultComoSetMenos: manoAnchoDeBasto) equals: rondaDefault cartasDisponiblesMano.
			self assert: self cartasPieDefaultComoSet equals: rondaDefault cartasDisponiblesPie
			]
	
	
	
	
		! !

!CartaDeTrucoTest methodsFor: 'test - ronda' stamp: 'JPF 7/5/2021 20:07:56'!
test09ElPiePuedeJugarEnSuTurno

	rondaDefault jugar: manoAnchoDeBasto para: mano.
	rondaDefault jugar: pieAnchoDeEspada para: pie.

	self assert: (self cartasManoDefaultComoSetMenos: manoAnchoDeBasto) equals: rondaDefault cartasDisponiblesMano .
	self assert: (self cartasPieDefaultComoSetMenos: pieAnchoDeEspada ) equals: rondaDefault cartasDisponiblesPie
	
	
	
	
		! !

!CartaDeTrucoTest methodsFor: 'test - ronda' stamp: 'JPF 7/5/2021 20:21:58'!
test10DebeJugarElPieSiGanaElEnfrentamiento

	rondaDefault jugar: manoAnchoDeBasto para: mano.
	rondaDefault jugar: pieAnchoDeEspada para: pie.
	
	self 
		should: [ rondaDefault jugar: mano3DeOro para: mano. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :error |
			self assert: RondaDeTruco noEsElTurnoDelJugadorQueTiroLaCartaDescripcionDeError equals: error messageText.
			self assert: (self cartasManoDefaultComoSetMenos: manoAnchoDeBasto) equals: rondaDefault cartasDisponiblesMano .
			self assert: (self cartasPieDefaultComoSetMenos: pieAnchoDeEspada ) equals: rondaDefault cartasDisponiblesPie
			].
	
	
	
	
		! !

!CartaDeTrucoTest methodsFor: 'test - ronda' stamp: 'JPF 7/5/2021 21:10:45'!
test11ElPieGanaLaRondaSiGana2Enfrentamientos

	rondaDefault jugar: manoAnchoDeBasto para: mano.
	rondaDefault jugar: pieAnchoDeEspada para: pie.
	rondaDefault jugar: pie3DeBasto para: pie.
	rondaDefault jugar: mano2DeEspada para: mano.
	
	self assert: rondaDefault estaTerminada.
	self assert: rondaDefault ganador equals: pie.
			
	
	
	
		! !

!CartaDeTrucoTest methodsFor: 'test - ronda' stamp: 'JPF 7/5/2021 21:14:56'!
test12LaManoGanaLaRondaSiGana2EnfrentamientosDe3

	rondaDefault jugar: manoAnchoDeBasto para: mano.
	rondaDefault jugar: pie3DeBasto para: pie.
	rondaDefault jugar: mano2DeEspada para: mano.
	rondaDefault jugar: pieAnchoDeEspada para: pie.
	rondaDefault jugar: pie4DeBasto para: pie.
	rondaDefault jugar: mano3DeOro para: mano.
	
	
	self assert: rondaDefault estaTerminada.
	self assert: rondaDefault ganador equals: mano.
			
	
	
	
		! !

!CartaDeTrucoTest methodsFor: 'test - ronda' stamp: 'JPF 7/5/2021 21:04:02'!
test13NoSePuedeSeguirJugandoEnUnaRondaTerminada

	rondaDefault jugar: manoAnchoDeBasto para: mano.
	rondaDefault jugar: pieAnchoDeEspada para: pie.
	rondaDefault jugar: pie3DeBasto para: pie.
	rondaDefault jugar: mano2DeEspada para: mano.
	
	self 
		should: [ rondaDefault jugar: pie4DeBasto para: pie. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :error |
			self assert: RondaDeTruco noSePuedeJugarEnUnaRondaTerminada equals: error messageText 
			].
			
	
	
	
		! !

!CartaDeTrucoTest methodsFor: 'test - ronda' stamp: 'JPF 7/5/2021 21:32:28'!
test14LaManoGanaLaRondaSiEmpardaElPrimerEnfrentamientoYGanaElSegundo

	rondaDefault jugar: mano3DeOro para: mano.
	rondaDefault jugar: pie3DeBasto para: pie.
	rondaDefault jugar: manoAnchoDeBasto para: mano.
	rondaDefault jugar: pie4DeBasto para: pie.
	
	self assert: rondaDefault estaTerminada.
	self assert: rondaDefault ganador equals: mano.
			
	
	
	
		! !


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


!classDefinition: #JugadorDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #JugadorDeTruco
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!


!classDefinition: #RondaDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #RondaDeTruco
	instanceVariableNames: 'jugadorMano cartasDeLaMano jugadorPie cartasDelPie proximoJugadorAJugar cartasJugadas cartaEnfrentamientoMano cartaEnfrentamientoPie terminada ganador pieGanoEnfrentamiento manoGanoEnfrentamiento'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTruco methodsFor: 'inicializacion' stamp: 'JPF 7/5/2021 18:30:41'!
asertarQue: unJugadorMano esDiferenteA: unJugadorPie

	^ unJugadorMano = unJugadorPie ifTrue: [ self error: self class noSePuedeCrearRondaConElMismoJugadorComoManoYPieDescripcionDeError ]! !

!RondaDeTruco methodsFor: 'inicializacion' stamp: 'JPF 7/5/2021 18:31:44'!
asertarQue: lasCartasDeLaMano tiene3cartasAlIgualQue: lasCartasDelPie

	^ (lasCartasDeLaMano size ~= 3 or: [ lasCartasDelPie size ~= 3]) ifTrue: [ self error: self class noSePuedeCrearRondaSiAlgunoDeLosJugadoresNoTiene3CartasDescripcionDeError ]! !

!RondaDeTruco methodsFor: 'inicializacion' stamp: 'JPF 7/5/2021 18:32:42'!
asertarQueEsValidoCrearUnaRondaEntre: unJugadorMano comoManoCon: lasCartasDeLaMano y: unJugadorPie comoPieCon: lasCartasDelPie

	self asertarQue: unJugadorMano esDiferenteA: unJugadorPie.
	self asertarQue: lasCartasDeLaMano tiene3cartasAlIgualQue: lasCartasDelPie.
	self asertarQueNoHayRepetidasEntre: lasCartasDelPie y: lasCartasDeLaMano! !

!RondaDeTruco methodsFor: 'inicializacion' stamp: 'JPF 7/5/2021 18:57:58'!
asertarQueNoHayRepetidasEntre: lasCartasDelPie y: lasCartasDeLaMano

	(lasCartasDeLaMano asSet 
		addAll: lasCartasDelPie; 
		yourself) size < 6 ifTrue: [ self error: self class noSePuedeCrearRondaConUnaCartaRepetidaDescripcionDeError ]! !

!RondaDeTruco methodsFor: 'inicializacion' stamp: 'JPF 7/5/2021 21:48:23'!
initializeEntre: unJugadorMano comoManoCon: lasCartasDeLaMano y: unJugadorPie con: lasCartasDelPie

	self 
		asertarQueEsValidoCrearUnaRondaEntre: unJugadorMano
		comoManoCon: lasCartasDeLaMano
		y: unJugadorPie 
		comoPieCon: lasCartasDelPie .
	
	jugadorMano := unJugadorMano.
	cartasDeLaMano := lasCartasDeLaMano copy asSet.
	jugadorPie := unJugadorPie.
	cartasDelPie := lasCartasDelPie copy asSet.
	proximoJugadorAJugar := jugadorMano.
	cartasJugadas := 0.
	pieGanoEnfrentamiento := false.
	manoGanoEnfrentamiento := false.
	terminada := false.
	ganador := nil.! !


!RondaDeTruco methodsFor: 'aserciones' stamp: 'JPF 7/5/2021 19:50:01'!
asertarQueJuegaElJugadorQueCorresponde: unJugadorDeTruco

	^ (proximoJugadorAJugar ~= unJugadorDeTruco) ifTrue: [ self error: self class noEsElTurnoDelJugadorQueTiroLaCartaDescripcionDeError ]! !

!RondaDeTruco methodsFor: 'aserciones' stamp: 'JPF 7/5/2021 21:35:43'!
asertarQueLaRondaNoEstaTerminada

	^ terminada ifTrue: [ self error: self class noSePuedeJugarEnUnaRondaTerminada ]! !


!RondaDeTruco methodsFor: 'juego' stamp: 'JPF 7/5/2021 21:50:08'!
jugar: unaCartaDeTruco para: unJugadorDeTruco

	self asertarQueLaRondaNoEstaTerminada.
	self asertarQueJuegaElJugadorQueCorresponde: unJugadorDeTruco.
	
	self jugar: unaCartaDeTruco.
	self terminoEnfrentamiento ifTrue: [ self evaluarEnfrentamiento ].! !


!RondaDeTruco methodsFor: 'juego - private' stamp: 'JPF 7/5/2021 21:49:40'!
evaluarEnfrentamiento
	
	(cartaEnfrentamientoPie mataA: cartaEnfrentamientoMano) ifTrue: [ self pieGanaEnfrentamiento ].
	(cartaEnfrentamientoMano mataA: cartaEnfrentamientoPie) ifTrue: [ self manoGanaEnfrentamiento ]! !

!RondaDeTruco methodsFor: 'juego - private' stamp: 'JPF 7/5/2021 20:58:06'!
gana: unJugadorDeTruco

	terminada := true.
	ganador := unJugadorDeTruco.

	
	
	
	! !

!RondaDeTruco methodsFor: 'juego - private' stamp: 'JPF 7/5/2021 21:38:13'!
jugar: unaCartaDeTruco

	proximoJugadorAJugar = jugadorMano 
		ifTrue: [ self jugarParaMano: unaCartaDeTruco ] 
		ifFalse: [ self jugarParaPie: unaCartaDeTruco ].
	cartasJugadas := cartasJugadas + 1.! !

!RondaDeTruco methodsFor: 'juego - private' stamp: 'JPF 7/5/2021 20:38:49'!
jugarParaMano: unaCartaDeTruco

	cartasDeLaMano remove: unaCartaDeTruco ifAbsent: [ self error: self class cartaNoDisponibleParaElJugadorDescripcionDeError].
	cartaEnfrentamientoMano := unaCartaDeTruco.
	proximoJugadorAJugar := jugadorPie! !

!RondaDeTruco methodsFor: 'juego - private' stamp: 'JPF 7/5/2021 20:39:17'!
jugarParaPie: unaCartaDeTruco

	cartasDelPie remove: unaCartaDeTruco ifAbsent: [ self error: self class cartaNoDisponibleParaElJugadorDescripcionDeError].
	cartaEnfrentamientoPie := unaCartaDeTruco.
	proximoJugadorAJugar := jugadorMano! !

!RondaDeTruco methodsFor: 'juego - private' stamp: 'JPF 7/5/2021 21:48:23'!
manoGanaEnfrentamiento

	(manoGanoEnfrentamiento or: [ cartasJugadas >= 4 and: [pieGanoEnfrentamiento not ]] )ifTrue: [ self gana: jugadorMano ].
	manoGanoEnfrentamiento := true.
	proximoJugadorAJugar := jugadorMano.

	
	
	
	! !

!RondaDeTruco methodsFor: 'juego - private' stamp: 'JPF 7/5/2021 21:47:53'!
pieGanaEnfrentamiento
	
	pieGanoEnfrentamiento ifTrue: [ self gana: jugadorPie ].
	pieGanoEnfrentamiento := true.
	proximoJugadorAJugar := jugadorPie.


	
	
	
	! !

!RondaDeTruco methodsFor: 'juego - private' stamp: 'JPF 7/5/2021 21:27:24'!
terminoEnfrentamiento

	^ cartasJugadas \\\ 2 = 0! !


!RondaDeTruco methodsFor: 'accessing' stamp: 'JPF 7/5/2021 19:01:42'!
cartasDisponiblesMano

	^ cartasDeLaMano copy! !

!RondaDeTruco methodsFor: 'accessing' stamp: 'JPF 7/5/2021 19:04:10'!
cartasDisponiblesPie

	^ cartasDelPie copy! !

!RondaDeTruco methodsFor: 'accessing' stamp: 'JPF 7/5/2021 20:59:37'!
ganador
	
	^ganador! !


!RondaDeTruco methodsFor: 'testing' stamp: 'JPF 7/5/2021 20:51:08'!
estaTerminada
	
	^ terminada! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RondaDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco class
	instanceVariableNames: ''!

!RondaDeTruco class methodsFor: 'descripciones de error' stamp: 'JPF 7/5/2021 19:39:39'!
cartaNoDisponibleParaElJugadorDescripcionDeError
	
	^ 'Carta no disponible para el jugador'! !

!RondaDeTruco class methodsFor: 'descripciones de error' stamp: 'JPF 7/5/2021 19:00:29'!
noEsElTurnoDelJugadorQueTiroLaCartaDescripcionDeError
	
	^ 'No es el turno del jugador que tiro la carta'! !

!RondaDeTruco class methodsFor: 'descripciones de error' stamp: 'JPF 7/5/2021 18:08:18'!
noSePuedeCrearRondaConElMismoJugadorComoManoYPieDescripcionDeError
	
	^ 'El Jugador mano de la ronda tiene que ser diferente al jugador pie'! !

!RondaDeTruco class methodsFor: 'descripciones de error' stamp: 'JPF 7/5/2021 18:14:53'!
noSePuedeCrearRondaConUnaCartaRepetidaDescripcionDeError
	
	^ 'No se puede crear una ronda con una carta repetida'! !

!RondaDeTruco class methodsFor: 'descripciones de error' stamp: 'JPF 7/5/2021 18:08:43'!
noSePuedeCrearRondaSiAlgunoDeLosJugadoresNoTiene3CartasDescripcionDeError
	
	^ 'Ambos jugadores deben tener exactamente 3 cartas para empezar la ronda'! !

!RondaDeTruco class methodsFor: 'descripciones de error' stamp: 'JPF 7/5/2021 21:07:11'!
noSePuedeJugarEnUnaRondaTerminada
	
	^ 'No se puede jugar en una ronda terminada'! !


!RondaDeTruco class methodsFor: 'instance creation' stamp: 'JPF 7/5/2021 17:56:47'!
entre: unJugadorMano comoManoCon: lasCartasDeLaMano y: unJugadorPie con: lasCartasDelPie 
	
	^self new initializeEntre: unJugadorMano comoManoCon: lasCartasDeLaMano y: unJugadorPie con: lasCartasDelPie ! !
