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

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'VIM 7/5/2021 20:28:14'!
test01CadaJugadorTieneTresCartas

	| aCartasParaMano aCartasParaPie |

	aCartasParaMano := OrderedCollection new.
	aCartasParaPie := OrderedCollection new.
	
	self
		should: [RondaDeTruco para: aCartasParaMano versus: aCartasParaPie.]
		raise: Error
		withMessageText: RondaDeTruco noHayTresCartasParaCadaJugadorDescripcionDeError.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'VIM 7/5/2021 21:46:08'!
test02NoHayCartasRepetidasEnUnMismoJugador

	| aCartasParaMano aCartasParaPie |

	aCartasParaMano := OrderedCollection new.
	aCartasParaPie := OrderedCollection new.
	
	aCartasParaMano add: (CartaDeTruco anchoDeEspada).
	aCartasParaMano add: (CartaDeTruco anchoDeEspada).
	aCartasParaMano add: (CartaDeTruco anchoDeBasto).
	
	aCartasParaPie add: (CartaDeTruco espadaCon: 2).
	aCartasParaPie add: (CartaDeTruco espadaCon: 3).
	aCartasParaPie add: (CartaDeTruco espadaCon: 4).

	self
		should: [RondaDeTruco para: aCartasParaMano versus: aCartasParaPie.]
		raise: Error
		withMessageText: RondaDeTruco hayCartasRepetidasEnLaManoDeUnJugadorDescripcionDeError.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'VIM 7/5/2021 20:28:27'!
test03NoHayCartasRepetidasEntreLosJugadores

	| aCartasParaMano aCartasParaPie |

	aCartasParaMano := OrderedCollection new.
	aCartasParaPie := OrderedCollection new.
	
	aCartasParaMano add: (CartaDeTruco espadaCon: 2).
	aCartasParaMano add: (CartaDeTruco oroCon: 3).
	aCartasParaMano add: (CartaDeTruco oroCon: 4).
	
	aCartasParaPie add: (CartaDeTruco espadaCon: 2).
	aCartasParaPie add: (CartaDeTruco espadaCon: 3).
	aCartasParaPie add: (CartaDeTruco espadaCon: 4).

	self
		should: [RondaDeTruco para: aCartasParaMano versus: aCartasParaPie.]
		raise: Error
		withMessageText: RondaDeTruco hayCartasRepetidasEntreAmbosJugadoresDescripcionDeError ! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'VIM 7/5/2021 20:28:42'!
test04LaManoJuegaPrimeroEnElPrimerEnfrentamiento

	| aCartasParaMano aCartasParaPie ronda |

	aCartasParaMano := OrderedCollection new.
	aCartasParaPie := OrderedCollection new.
	
	aCartasParaMano add: (CartaDeTruco espadaCon: 1).
	aCartasParaMano add: (CartaDeTruco oroCon: 3).
	aCartasParaMano add: (CartaDeTruco oroCon: 4).
	
	aCartasParaPie add: (CartaDeTruco espadaCon: 2).
	aCartasParaPie add: (CartaDeTruco espadaCon: 3).
	aCartasParaPie add: (CartaDeTruco espadaCon: 4).

	ronda := RondaDeTruco para: aCartasParaMano versus: aCartasParaPie.
	
	ronda jugar.
	
	self assert: (ronda primeroEnJugarEnElEnfrentamiento: 1) equals: aCartasParaMano.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'VIM 7/5/2021 21:14:42'!
test05EnElPrimerEnfrentamientoGanaLaMejorCartaQueEsDeLaMano

	| aCartasParaMano aCartasParaPie ronda |

	aCartasParaMano := self cartasParaPerderLosUltimosDosEnfrentamientos.
	aCartasParaPie := self cartasParaGanarLosUltimosDosEfrentamientos .

	ronda := RondaDeTruco para: aCartasParaMano versus: aCartasParaPie.
	
	ronda jugar.
	
	self assert:  aCartasParaMano equals: (ronda ganadorDelEnfrentamiento: 1).! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'VIM 7/5/2021 21:21:03'!
test06EnElPrimerEnfrentamientoGanaLaMejorCartaQueEsDelPie

	| aCartasParaMano aCartasParaPie ronda |

	aCartasParaMano := self  cartasParaGanarLosUltimosDosEfrentamientos .
	aCartasParaPie := self cartasParaPerderLosUltimosDosEnfrentamientos .

	ronda := RondaDeTruco para: aCartasParaMano versus: aCartasParaPie.
	
	ronda jugar.
	
	self assert: aCartasParaPie equals: (ronda ganadorDelEnfrentamiento: 1) .! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'VIM 7/5/2021 21:21:18'!
test07EnElSegundoEnfrentamientoJuegaPrimeroElGanadorDelPrimero

	| aCartasParaMano aCartasParaPie ronda |

	aCartasParaMano := self cartasParaPerderLosUltimosDosEnfrentamientos .
	aCartasParaPie := self cartasParaGanarLosUltimosDosEfrentamientos .

	ronda := RondaDeTruco para: aCartasParaMano versus: aCartasParaPie.
	
	ronda jugar.
	
	self assert: aCartasParaMano equals: (ronda primeroEnJugarEnElEnfrentamiento: 2).! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'VIM 7/5/2021 21:21:46'!
test08EnElSegundoEnfrentamientoJuegaPrimeroLaManoSiHuboEmpate

	| aCartasParaMano aCartasParaPie ronda |

	aCartasParaMano := self cartasParaEmpatarElPrimerEnfrentamientoYGanarLosUltimos.
	aCartasParaPie := self cartasParaEmpatarElPrimerEnfrentamientoYPerderLosUltimos.

	ronda := RondaDeTruco para: aCartasParaMano versus: aCartasParaPie.
	
	ronda jugar.
	
	self assert: aCartasParaMano equals: (ronda primeroEnJugarEnElEnfrentamiento: 2).
	
	"Esto lo chequeo solo para el segundo enfrentamiento y hardcodeo la mano por lo aclarado en el momento del examen."! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'VIM 7/5/2021 21:20:42'!
test09EnElSegundoEnfrentamientoGanaLaMejorCartaQueEsDeLaMano

	| aCartasParaMano aCartasParaPie ronda |

	aCartasParaMano := self cartasParaGanarLosUltimosDosEfrentamientos.
	aCartasParaPie := self cartasParaPerderLosUltimosDosEnfrentamientos .

	ronda := RondaDeTruco para: aCartasParaMano versus: aCartasParaPie.
	
	ronda jugar.
	
	self assert: aCartasParaMano equals: (ronda ganadorDelEnfrentamiento: 2).! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'VIM 7/5/2021 21:22:12'!
test10EnElSegundoEnfrentamientoGanaLaMejorCartaQueEsDelPie

	| aCartasParaMano aCartasParaPie ronda |

	aCartasParaMano := self cartasParaPerderLosUltimosDosEnfrentamientos.
	aCartasParaPie := self cartasParaGanarLosUltimosDosEfrentamientos .

	ronda := RondaDeTruco para: aCartasParaMano versus: aCartasParaPie.
	
	ronda jugar.
	
	self assert: aCartasParaPie equals: (ronda ganadorDelEnfrentamiento: 2) .! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'VIM 7/5/2021 21:23:01'!
test11EnElTercerEnfrentamientoJuegaPrimeroElGanadorDelSegundo

	| aCartasParaMano aCartasParaPie ronda |

	aCartasParaMano := self cartasParaPerderLosUltimosDosEnfrentamientos .
	aCartasParaPie := self cartasParaGanarLosUltimosDosEfrentamientos .

	ronda := RondaDeTruco para: aCartasParaMano versus: aCartasParaPie.
	
	ronda jugar.
	
	self assert: aCartasParaPie equals: (ronda primeroEnJugarEnElEnfrentamiento: 3) .! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'VIM 7/5/2021 21:23:48'!
test12EnElTercerEnfrentamientoGanaLaMejorCartaQueEsDeLaMano

	| aCartasParaMano aCartasParaPie ronda |

	aCartasParaMano := self cartasParaGanarLosUltimosDosEfrentamientos .
	aCartasParaPie := self cartasParaPerderLosUltimosDosEnfrentamientos.

	ronda := RondaDeTruco para: aCartasParaMano versus: aCartasParaPie.
	
	ronda jugar.
	
	self assert: aCartasParaMano  equals: (ronda ganadorDelEnfrentamiento: 3) .! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'VIM 7/5/2021 21:24:26'!
test13EnElTercerEnfrentamientoGanaLaMejorCartaQueEsDelPie

	| aCartasParaMano aCartasParaPie ronda |

	aCartasParaMano := self cartasParaPerderLosUltimosDosEnfrentamientos .
	aCartasParaPie := self cartasParaGanarLosUltimosDosEfrentamientos .

	ronda := RondaDeTruco para: aCartasParaMano versus: aCartasParaPie.
	
	ronda jugar.
	
	self assert: aCartasParaPie equals: (ronda ganadorDelEnfrentamiento: 3)  .! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'VIM 7/5/2021 21:16:27'!
test14ElQueGanaLosUltimosDosEnfrentamientosGanaLaRonda

	| aCartasParaMano aCartasParaPie ronda |

	aCartasParaMano := self cartasParaPerderLosUltimosDosEnfrentamientos .
	aCartasParaPie := self cartasParaGanarLosUltimosDosEfrentamientos .

	ronda := RondaDeTruco para: aCartasParaMano versus: aCartasParaPie.
	
	ronda jugar.
	
	self assert: aCartasParaPie equals: (ronda ganadorDeLaRonda) .! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'VIM 7/5/2021 21:28:01'!
test15ElQueGanaElPrimerYTercerEnfrentamientoGanaLaRonda

	| aCartasParaMano aCartasParaPie ronda |

	aCartasParaMano := self cartasParaPerderPrimerYUltimoEfrentamientos .
	aCartasParaPie := self cartasParaGanarPrimerYUltimoEfrentamientos.

	ronda := RondaDeTruco para: aCartasParaMano versus: aCartasParaPie.
	
	ronda jugar.
	
	self assert: aCartasParaPie equals: (ronda ganadorDeLaRonda) .! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'VIM 7/5/2021 21:31:41'!
test16ElQueGanaPrimerosDosEnfrentamientosGanaLaRondaYTerminaLaRonda

	| aCartasParaMano aCartasParaPie ronda |

	aCartasParaMano := self cartasParaPerderLosPrimerosDosEnfrentamientos .
	aCartasParaPie := self cartasParaGanarLosPrimerosDosEnfrentamientos .

	ronda := RondaDeTruco para: aCartasParaMano versus: aCartasParaPie.
	
	ronda jugar.
	
	self assert: aCartasParaPie equals: (ronda ganadorDeLaRonda) .
	self assert: (ronda noHuboTercerEnfrentamiento).! !


!RondaDeTrucoTest methodsFor: 'creacion de manos para tests' stamp: 'VIM 7/5/2021 21:18:45'!
cartasParaEmpatarElPrimerEnfrentamientoYGanarLosUltimos
	| cartas |
	cartas := OrderedCollection new.
	
	cartas add: (CartaDeTruco espadaCon: 6).
	cartas add: (CartaDeTruco espadaCon:1).
	cartas add: (CartaDeTruco espadaCon: 7).
	^cartas! !

!RondaDeTrucoTest methodsFor: 'creacion de manos para tests' stamp: 'VIM 7/5/2021 21:19:08'!
cartasParaEmpatarElPrimerEnfrentamientoYPerderLosUltimos
	| cartas |
	cartas := OrderedCollection new.
	
	cartas add: (CartaDeTruco oroCon: 6).
	cartas add: (CartaDeTruco oroCon:4).
	cartas add: (CartaDeTruco oroCon: 5).
	
	^cartas! !

!RondaDeTrucoTest methodsFor: 'creacion de manos para tests' stamp: 'VIM 7/5/2021 21:29:34'!
cartasParaGanarLosPrimerosDosEnfrentamientos
	| cartas |
	cartas := OrderedCollection new.
	
	cartas add: (CartaDeTruco espadaCon: 7).
	cartas add: (CartaDeTruco espadaCon:1).
	cartas add: (CartaDeTruco espadaCon: 4).
	^cartas! !

!RondaDeTrucoTest methodsFor: 'creacion de manos para tests' stamp: 'VIM 7/5/2021 21:13:06'!
cartasParaGanarLosUltimosDosEfrentamientos
	| cartas |
	cartas := OrderedCollection new.
	
	cartas add: (CartaDeTruco espadaCon: 4).
	cartas add: (CartaDeTruco espadaCon:1).
	cartas add: (CartaDeTruco espadaCon: 7).
	^cartas! !

!RondaDeTrucoTest methodsFor: 'creacion de manos para tests' stamp: 'VIM 7/5/2021 21:25:55'!
cartasParaGanarPrimerYUltimoEfrentamientos

	| cartas |
	cartas := OrderedCollection new.
	
	cartas add: (CartaDeTruco espadaCon: 1).
	cartas add: (CartaDeTruco espadaCon:4).
	cartas add: (CartaDeTruco espadaCon: 7).
	^cartas! !

!RondaDeTrucoTest methodsFor: 'creacion de manos para tests' stamp: 'VIM 7/5/2021 21:29:13'!
cartasParaPerderLosPrimerosDosEnfrentamientos
	| cartas |
	cartas := OrderedCollection new.
	
	cartas add: (CartaDeTruco oroCon: 5).
	cartas add: (CartaDeTruco oroCon:6).
	cartas add: (CartaDeTruco oroCon: 7).
	
	^cartas! !

!RondaDeTrucoTest methodsFor: 'creacion de manos para tests' stamp: 'VIM 7/5/2021 21:27:38'!
cartasParaPerderLosUltimosDosEnfrentamientos
	| cartas |
	cartas := OrderedCollection new.
	
	cartas add: (CartaDeTruco oroCon: 7).
	cartas add: (CartaDeTruco oroCon:6).
	cartas add: (CartaDeTruco oroCon: 5).
	
	^cartas! !

!RondaDeTrucoTest methodsFor: 'creacion de manos para tests' stamp: 'VIM 7/5/2021 21:26:27'!
cartasParaPerderPrimerYUltimoEfrentamientos
	| cartas |
	cartas := OrderedCollection new.
	
	cartas add: (CartaDeTruco oroCon: 4).
	cartas add: (CartaDeTruco oroCon:7).
	cartas add: (CartaDeTruco oroCon: 5).
	
	^cartas! !


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
	instanceVariableNames: 'ganador primerJugador segundoJugador numeroDeEnfrentamiento perdedor jugadorMano jugadorPie resultado'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!EnfrentamientoDeTruco methodsFor: 'initialization' stamp: 'VIM 7/5/2021 20:21:46'!
initializeEntrePrimerJugador: aCartasDePrimerJugador versusSegundoJugador: aCartasDeSegundoJugador conJugadorMano: aJugadorMano conJugadorPie: aJugadorPie numeroDeEnfrentamiento: aNumeroDeEnfrentamiento 

	primerJugador := aCartasDePrimerJugador.
	segundoJugador := aCartasDeSegundoJugador.
	numeroDeEnfrentamiento := aNumeroDeEnfrentamiento.
	jugadorMano := aJugadorMano.
	jugadorPie := aJugadorPie.! !


!EnfrentamientoDeTruco methodsFor: 'accessing' stamp: 'VIM 7/5/2021 19:41:41'!
ganador
	^ganador ! !

!EnfrentamientoDeTruco methodsFor: 'accessing' stamp: 'VIM 7/5/2021 19:57:14'!
perdedor
	^perdedor! !

!EnfrentamientoDeTruco methodsFor: 'accessing' stamp: 'VIM 7/5/2021 20:21:46'!
primeroEnJugar
	^primerJugador .! !


!EnfrentamientoDeTruco methodsFor: 'ganar y empatar' stamp: 'VIM 7/5/2021 20:51:29'!
ganaElPrimero
	ganador := primerJugador.
	perdedor := segundoJugador.! !

!EnfrentamientoDeTruco methodsFor: 'ganar y empatar' stamp: 'VIM 7/5/2021 20:50:36'!
ganaElSegundo
	ganador := segundoJugador  .
	perdedor :=  primerJugador.! !

!EnfrentamientoDeTruco methodsFor: 'ganar y empatar' stamp: 'VIM 7/5/2021 20:50:40'!
huboEmpate
	ganador := jugadorMano.
	perdedor := jugadorPie.! !


!EnfrentamientoDeTruco methodsFor: 'enfrentarse' stamp: 'VIM 7/5/2021 20:23:15'!
enfrentarse
	((primerJugador at: numeroDeEnfrentamiento) empardaCon: (segundoJugador at: numeroDeEnfrentamiento )) ifTrue: [self huboEmpate] ifFalse: [	((primerJugador at: numeroDeEnfrentamiento) mataA: (segundoJugador at: numeroDeEnfrentamiento )) ifTrue: [self ganaElPrimero] ifFalse: [self ganaElSegundo]].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnfrentamientoDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
EnfrentamientoDeTruco class
	instanceVariableNames: ''!

!EnfrentamientoDeTruco class methodsFor: 'initialization' stamp: 'VIM 7/5/2021 20:17:34'!
entre: aCartasDePrimerJugador versus: aCartasDeSegundoJugador conJugadorMano: aJugadorMano conJugadorPie: aJugadorPie numeroDeEnfrentamiento: aNumeroDeEnfrentamiento
	 
	^self new initializeEntrePrimerJugador: aCartasDePrimerJugador versusSegundoJugador: aCartasDeSegundoJugador conJugadorMano: aJugadorMano conJugadorPie: aJugadorPie numeroDeEnfrentamiento: aNumeroDeEnfrentamiento.! !


!classDefinition: #RondaDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #RondaDeTruco
	instanceVariableNames: 'cartasParaMano cartasParaPie enfrentamientos ganadorDeLaRonda'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTruco methodsFor: 'initialization' stamp: 'VIM 7/5/2021 19:15:52'!
initializePara: aCartasParaMano versus: aCartasParaPie 
	cartasParaMano := aCartasParaMano.
	cartasParaPie := aCartasParaPie.
	enfrentamientos := OrderedCollection new.! !


!RondaDeTruco methodsFor: 'calcular puntajes' stamp: 'VIM 7/5/2021 20:59:41'!
calcularPuntajeJugadorMano

	^ (enfrentamientos select: [:anEnfrentamiento | (anEnfrentamiento ganador) = cartasParaMano.]) size! !

!RondaDeTruco methodsFor: 'calcular puntajes' stamp: 'VIM 7/5/2021 20:59:51'!
calcularPuntajeJugadorPie

	^ (enfrentamientos select: [:anEnfrentamiento | (anEnfrentamiento ganador) = cartasParaPie.]) size! !


!RondaDeTruco methodsFor: 'accessing' stamp: 'VIM 7/5/2021 20:37:09'!
ganadorDeLaRonda

	^ganadorDeLaRonda.! !

!RondaDeTruco methodsFor: 'accessing' stamp: 'VIM 7/5/2021 19:42:16'!
ganadorDelEnfrentamiento: aNumeroDeEnfrentamiento
	
	^(enfrentamientos at: aNumeroDeEnfrentamiento) ganador.! !

!RondaDeTruco methodsFor: 'accessing' stamp: 'VIM 7/5/2021 21:01:03'!
jugadorQueGanoMasEnfrentamientos: anEnfrentamientos
	
	| puntosParaMano puntosParaPie |
	
	puntosParaMano := self calcularPuntajeJugadorMano.
	puntosParaPie := self calcularPuntajeJugadorPie.
	
	(puntosParaMano > puntosParaPie ) ifTrue: [^cartasParaMano ] ifFalse: [(puntosParaMano < puntosParaPie ) ifTrue: [^cartasParaPie ]].! !

!RondaDeTruco methodsFor: 'accessing' stamp: 'VIM 7/5/2021 21:32:05'!
noHuboTercerEnfrentamiento
	^enfrentamientos size = 2.! !

!RondaDeTruco methodsFor: 'accessing' stamp: 'VIM 7/5/2021 19:23:43'!
primeroEnJugarEnElEnfrentamiento: anEnfrentamiento

	^(enfrentamientos at: anEnfrentamiento) primeroEnJugar.! !


!RondaDeTruco methodsFor: 'jugar' stamp: 'VIM 7/5/2021 20:20:47'!
enfrentarseEntre: aPrimerJugador versus: aSegundoJugador numeroDeEnfrentamiento: aNumeroDeEnfrentamiento
	
	| enfrentamiento |
	enfrentamiento := EnfrentamientoDeTruco entre: aPrimerJugador versus: aSegundoJugador conJugadorMano: cartasParaMano conJugadorPie: cartasParaPie numeroDeEnfrentamiento: aNumeroDeEnfrentamiento.
	
	enfrentamiento enfrentarse.
	
	^enfrentamiento.! !

!RondaDeTruco methodsFor: 'jugar' stamp: 'VIM 7/5/2021 21:08:59'!
ganarRondaEnDosEnfrentamientos: aGanadorDeLaRonda
	ganadorDeLaRonda := aGanadorDeLaRonda.
	^ganadorDeLaRonda ! !

!RondaDeTruco methodsFor: 'jugar' stamp: 'VIM 7/5/2021 21:36:30'!
jugar
	self jugarPrimerEnfrentamiento.
	self jugarSegundoEnfrentamiento.
	((enfrentamientos at: 2) ganador) = ((enfrentamientos at: 1) ganador) ifTrue: [^self terminarEnDosEnfrentamientos].
	self jugarTercerEnfrentamiento.
	
	ganadorDeLaRonda := self jugadorQueGanoMasEnfrentamientos: enfrentamientos.
	^ ganadorDeLaRonda ! !

!RondaDeTruco methodsFor: 'jugar' stamp: 'VIM 7/5/2021 21:35:27'!
jugarPrimerEnfrentamiento

	^ enfrentamientos add: (self enfrentarseEntre: cartasParaMano versus: cartasParaPie numeroDeEnfrentamiento: 1)! !

!RondaDeTruco methodsFor: 'jugar' stamp: 'VIM 7/5/2021 21:35:37'!
jugarSegundoEnfrentamiento

	^ enfrentamientos add: (self enfrentarseEntre: ((enfrentamientos at: 1) ganador) versus: ((enfrentamientos at: 1) perdedor) numeroDeEnfrentamiento: 2)! !

!RondaDeTruco methodsFor: 'jugar' stamp: 'VIM 7/5/2021 21:35:51'!
jugarTercerEnfrentamiento

	^ enfrentamientos add: (self enfrentarseEntre: ((enfrentamientos at: 2) ganador) versus: ((enfrentamientos at: 2) perdedor) numeroDeEnfrentamiento: 3)! !

!RondaDeTruco methodsFor: 'jugar' stamp: 'VIM 7/5/2021 21:34:15'!
terminarEnDosEnfrentamientos

	^ self ganarRondaEnDosEnfrentamientos: ((enfrentamientos at: 1) ganador)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RondaDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco class
	instanceVariableNames: ''!

!RondaDeTruco class methodsFor: 'instance creation' stamp: 'VIM 7/5/2021 21:39:30'!
para: aCartasParaMano versus: aCartasParaPie

	(aCartasParaMano size = 3) ifFalse: [self signalNoTieneTresCartas].
	(aCartasParaPie size = 3) ifFalse: [self signalNoTieneTresCartas].
	
	self assertNoTieneCartasRepetidas: aCartasParaMano.
	self assertNoTieneCartasRepetidas: aCartasParaPie.
	self assertNoTienenCartasRepetidasEntre: aCartasParaMano y: aCartasParaPie.

	^self new initializePara: aCartasParaMano versus: aCartasParaPie ! !


!RondaDeTruco class methodsFor: 'error handling' stamp: 'VIM 7/5/2021 18:31:16'!
hayCartasRepetidasEnLaManoDeUnJugadorDescripcionDeError
	
	^'Hay cartas repetidas en la mano de uno de los jugadores.'! !

!RondaDeTruco class methodsFor: 'error handling' stamp: 'VIM 7/5/2021 18:40:59'!
hayCartasRepetidasEntreAmbosJugadoresDescripcionDeError
	
	^'Hay cartas repetidas (en común) entre las manos de ambos jugadores.'! !

!RondaDeTruco class methodsFor: 'error handling' stamp: 'VIM 7/5/2021 18:41:38'!
noHayTresCartasParaCadaJugadorDescripcionDeError
	
	^'Cada jugador debe tener exactamente tres cartas!!'! !

!RondaDeTruco class methodsFor: 'error handling' stamp: 'VIM 7/5/2021 18:39:32'!
signalHayCartasRepetidasEnLaManoDeUnJugador

	^self error: self hayCartasRepetidasEnLaManoDeUnJugadorDescripcionDeError.! !

!RondaDeTruco class methodsFor: 'error handling' stamp: 'VIM 7/5/2021 18:40:26'!
signalHayCartasRepetidasEntreAmbosJugadores

	^self error: self hayCartasRepetidasEntreAmbosJugadoresDescripcionDeError.! !

!RondaDeTruco class methodsFor: 'error handling' stamp: 'VIM 7/5/2021 18:41:38'!
signalNoTieneTresCartas

	^self error: self noHayTresCartasParaCadaJugadorDescripcionDeError.! !


!RondaDeTruco class methodsFor: 'assertions' stamp: 'VIM 7/5/2021 21:58:35'!
assertNoTieneCartasRepetidas: aManoDeCartasParaUnJugador
	
	((aManoDeCartasParaUnJugador at: 1) = 	(aManoDeCartasParaUnJugador at: 2)) ifTrue: [^self signalHayCartasRepetidasEnLaManoDeUnJugador ].	
	((aManoDeCartasParaUnJugador at: 1) = 	(aManoDeCartasParaUnJugador at: 3)) ifTrue: [^self signalHayCartasRepetidasEnLaManoDeUnJugador ].
	((aManoDeCartasParaUnJugador at: 3) = 	(aManoDeCartasParaUnJugador at: 2)) ifTrue: [^self signalHayCartasRepetidasEnLaManoDeUnJugador ].
! !

!RondaDeTruco class methodsFor: 'assertions' stamp: 'VIM 7/5/2021 21:39:30'!
assertNoTienenCartasRepetidasEntre: aCartasParaMano y: aCartasParaPie.

	((aCartasParaMano intersection: aCartasParaPie) isEmpty ) ifFalse: [self signalHayCartasRepetidasEntreAmbosJugadores.].! !
