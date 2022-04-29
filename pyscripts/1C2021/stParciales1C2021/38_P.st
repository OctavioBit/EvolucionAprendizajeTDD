!classDefinition: #CartaDeTrucoTest category: 'ISW1-2021-1C-2doParcial'!
TestCase subclass: #CartaDeTrucoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!CartaDeTrucoTest methodsFor: 'test - igualdad'!
test01SonIgualesConMismoPaloYNumero
	self assert: (CartaDeTruco bastoCon: 1) = (CartaDeTruco bastoCon: 1).! !

!CartaDeTrucoTest methodsFor: 'test - igualdad'!
test02SonDistintasConDistintoPalo
	self deny: (CartaDeTruco bastoCon: 1) = (CartaDeTruco oroCon: 1).! !

!CartaDeTrucoTest methodsFor: 'test - igualdad'!
test03SonDistintasConNumeroAunqueIgualPalo
	self deny: (CartaDeTruco bastoCon: 1) = (CartaDeTruco bastoCon: 2).! !

!CartaDeTrucoTest methodsFor: 'test - igualdad'!
test04CartasIgualesTienenElMismoHash
	self
		assert: (CartaDeTruco bastoCon: 1) hash
		equals: (CartaDeTruco bastoCon: 1) hash.! !

!CartaDeTrucoTest methodsFor: 'test - igualdad'!
test05UnaCartaEsDistintaACualquierObjetoQueNoSeaCarta
	self deny: (CartaDeTruco bastoCon: 1) = 1.! !


!CartaDeTrucoTest methodsFor: 'test - creacion'!
test07NoHayCartaDeTrucoConNumeroOcho
	self
		should: [ CartaDeTruco oroCon: 8 ]
		raise: Error
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription.! !

!CartaDeTrucoTest methodsFor: 'test - creacion'!
test08NoHayCartaDeTrucoConNumeroNueve
	self
		should: [ CartaDeTruco oroCon: 9 ]
		raise: Error
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription.! !

!CartaDeTrucoTest methodsFor: 'test - creacion'!
test09LosPalosDeLaCartaDeTrucoSonBastoOroEspadaYCopa
	self
		should: [
			CartaDeTruco
				palo: #otro
				numero: 1 ]
		raise: Error
		withMessageText: CartaDeTruco paloInvalidoErrorDescription.! !

!CartaDeTrucoTest methodsFor: 'test - creacion'!
test10NoSePuedeCrearCartaConNumeroMenorAUno
	self
		should: [ CartaDeTruco espadaCon: 0 ]
		raise: Error
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription.! !

!CartaDeTrucoTest methodsFor: 'test - creacion'!
test11NoSePuedeCrearCartaConNumeroMayorADoce
	self
		should: [ CartaDeTruco espadaCon: 13 ]
		raise: Error
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription.! !

!CartaDeTrucoTest methodsFor: 'test - creacion'!
test12ElNumeroDeLaCartaDebeSerEntero
	self
		should: [ CartaDeTruco espadaCon: 1.1 ]
		raise: Error
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription.! !


!CartaDeTrucoTest methodsFor: 'test - valor y comparacion'!
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
	{3. 2. 12. 11. 10. 6. 5. 4} do: [ :arg1 |
		CartaDeTruco palos do: [ :arg2 |
			self assert:
				((CartaDeTruco espadaCon: arg1) empardaCon:
					(CartaDeTruco
						palo: arg2
						numero: arg1)) ]].! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion'!
test14HayCartasQueNoSonPardas
	self deny: (CartaDeTruco anchoDeEspada empardaCon: CartaDeTruco anchoDeBasto).! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion'!
test15HayCartasQuePierdenConOtras
	self deny: (CartaDeTruco anchoDeBasto mataA: CartaDeTruco anchoDeEspada).! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion'!
test16SieteDeCopasYDeBastoEsSieteFalso
	self assert: (CartaDeTruco copaCon: 7) esSieteFalso.
	self assert: (CartaDeTruco bastoCon: 7) esSieteFalso.! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion'!
test17SieteDeOroYDeEspadaNoSonSieteFalso
	self deny: CartaDeTruco sieteDeOro esSieteFalso.
	self deny: CartaDeTruco sieteDeEspada esSieteFalso.! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion'!
test18AnchoDeOroYDeCopaSonAnchoFalsos
	self assert: (CartaDeTruco oroCon: 1) esAnchoFalso.
	self assert: (CartaDeTruco copaCon: 1) esAnchoFalso.! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion'!
test19AnchoDeEspadaYDeBastosNoSonAnchoFalsos
	self deny: CartaDeTruco anchoDeEspada esAnchoFalso.
	self deny: CartaDeTruco anchoDeBasto esAnchoFalso.! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion'!
test20FallaBuscandoValorDeCartaInválida
	self
		should: [
			CartaDeTruco new
				
					initializePalo: #invalido
					numero: 1;
				valor ]
		raise: Error
		withMessageText: CartaDeTruco tablaDeValoresIncorrectaOCartaInvalidaErrorDescription.! !


!classDefinition: #RondaDeTrucoTest category: 'ISW1-2021-1C-2doParcial'!
TestCase subclass: #RondaDeTrucoTest
	instanceVariableNames: 'jugadorA jugadorB'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 20:22:59'!
setUp

	jugadorA := Jugador llamado: #A.
	jugadorB := Jugador llamado: #B.! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:41:57'!
test01
	| rondaDeTruco |

	rondaDeTruco _ RondaDeTrucoSinRefactor
		entreJugador: jugadorA
		vs: jugadorB primeraParda: true
		.
	
	self assert: rondaDeTruco rondasJugadas equals: 0! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:41:57'!
test02
	| rondaDeTruco |

	rondaDeTruco _ RondaDeTrucoSinRefactor
		entreJugador: jugadorA
		vs: jugadorB primeraParda: true
		.
	
	rondaDeTruco enfrentamientoEntre: CartaDeTruco anchoDeEspada vs: CartaDeTruco anchoDeBasto.
		
		
	self assert: (rondaDeTruco rondasJugadas) equals: 1.
	self assert: (rondaDeTruco enfretamientosGanadosPor: jugadorA) equals: 1.
	self assert: (rondaDeTruco enfretamientosGanadosPor: jugadorB) equals: 0.! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:41:57'!
test03
	| rondaDeTruco |
	
	rondaDeTruco _ RondaDeTrucoSinRefactor
		entreJugador: jugadorA
		vs: jugadorB primeraParda: true
		.
	
	rondaDeTruco enfrentamientoEntre: (CartaDeTruco bastoCon: 2) vs: (CartaDeTruco oroCon: 2) .
	
	self assert: (rondaDeTruco rondasJugadas) equals: 1.
	self assert: (rondaDeTruco enfretamientosGanadosPor: jugadorA) equals: 0.
	self assert: (rondaDeTruco enfretamientosGanadosPor: jugadorB) equals: 0.
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:41:57'!
test04
	| rondaDeTruco |
	

	rondaDeTruco _ RondaDeTrucoSinRefactor
		entreJugador: jugadorA
		vs: jugadorB primeraParda: true
		.
	
	rondaDeTruco enfrentamientoEntre: (CartaDeTruco oroCon: 2) vs: (CartaDeTruco bastoCon: 2).
	rondaDeTruco enfrentamientoEntre: CartaDeTruco anchoDeEspada vs:CartaDeTruco anchoDeBasto. .
	
	self assert: (rondaDeTruco rondasJugadas) equals: 2.
	self assert: (rondaDeTruco enfretamientosGanadosPor: jugadorA) equals: 1.
	self assert: (rondaDeTruco enfretamientosGanadosPor: jugadorB) equals: 0.
	self assert: (rondaDeTruco ganador) equals: jugadorA .! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:41:57'!
test05
	| rondaDeTruco |
	
	rondaDeTruco _ RondaDeTrucoSinRefactor
		entreJugador: jugadorA
		vs: jugadorB primeraParda: true
		.
	
	rondaDeTruco enfrentamientoEntre: (CartaDeTruco bastoCon: 2) vs: (CartaDeTruco oroCon: 2) .
	rondaDeTruco enfrentamientoEntre: CartaDeTruco anchoDeEspada vs: CartaDeTruco anchoDeBasto.
	
	self assert: (rondaDeTruco rondasJugadas) equals: 2.
	self assert: (rondaDeTruco enfretamientosGanadosPor: jugadorA) equals: 1.
	self assert: (rondaDeTruco enfretamientosGanadosPor: jugadorB) equals: 0.
	self assert: (rondaDeTruco ganador) equals: jugadorA .! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:41:57'!
test06
	| rondaDeTruco |
	
	rondaDeTruco _ RondaDeTrucoSinRefactor
		entreJugador: jugadorA
		vs: jugadorB primeraParda: true
		.
	
	rondaDeTruco enfrentamientoEntre: (CartaDeTruco oroCon: 4) vs: (CartaDeTruco oroCon: 2) .
	rondaDeTruco enfrentamientoEntre: CartaDeTruco anchoDeEspada vs: 	CartaDeTruco anchoDeBasto. 
	rondaDeTruco enfrentamientoEntre: (CartaDeTruco copaCon: 3) vs: (CartaDeTruco copaCon: 4) .
	
	self assert: (rondaDeTruco rondasJugadas) equals: 3.
	self assert: (rondaDeTruco enfretamientosGanadosPor: jugadorA) equals: 2.
	self assert: (rondaDeTruco enfretamientosGanadosPor: jugadorB) equals: 1.
	self assert: (rondaDeTruco ganador) equals: jugadorA .! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:41:57'!
test07
	| rondaDeTruco |
	
	rondaDeTruco _ RondaDeTrucoSinRefactor
		entreJugador: jugadorA
		vs: jugadorB primeraParda: true
		.
	
	rondaDeTruco enfrentamientoEntre: (CartaDeTruco copaCon: 2) vs:  (CartaDeTruco oroCon: 2).
	rondaDeTruco enfrentamientoEntre: CartaDeTruco anchoDeEspada vs: CartaDeTruco anchoDeBasto.
	
	self assert: (rondaDeTruco rondasJugadas) equals: 2.
	self assert: (rondaDeTruco enfretamientosGanadosPor: jugadorA) equals: 1.
	self assert: (rondaDeTruco enfretamientosGanadosPor: jugadorB) equals: 0.
	self assert: (rondaDeTruco ganador) equals: jugadorA .! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:41:57'!
test08
	| rondaDeTruco |

	rondaDeTruco _ RondaDeTrucoSinRefactor
		entreJugador: jugadorA
		vs: jugadorB primeraParda: true.

	
	self 
		should: [rondaDeTruco enfrentamientoEntre: CartaDeTruco anchoDeBasto vs: CartaDeTruco anchoDeBasto .]
		raise: Error -MessageNotUnderstood 
		withExceptionDo: [:anError|
			self assert: RondaDeTrucoSinRefactor cartaRepetidaError equals: anError messageText .
			self assert: (rondaDeTruco rondasJugadas) equals: 0.
			].
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:41:57'!
test09
	| rondaDeTruco |

	rondaDeTruco _ RondaDeTrucoSinRefactor
		entreJugador: jugadorA
		vs: jugadorB primeraParda: true.
	
	rondaDeTruco enfrentamientoEntre: (CartaDeTruco espadaCon: 3) vs: (CartaDeTruco espadaCon:1 ).
	
	self 
		should: [rondaDeTruco enfrentamientoEntre: CartaDeTruco anchoDeEspada vs: CartaDeTruco anchoDeBasto .]
		raise: Error -MessageNotUnderstood 
		withExceptionDo: [:anError|
			self assert: RondaDeTrucoSinRefactor cartaRepetidaError equals: anError messageText .
			self assert: (rondaDeTruco rondasJugadas) equals: 1.
			].
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:41:57'!
test10
	| rondaDeTruco |

	rondaDeTruco _ RondaDeTrucoSinRefactor
		entreJugador: jugadorA
		vs: jugadorB primeraParda: true.
	
	rondaDeTruco enfrentamientoEntre: (CartaDeTruco espadaCon: 3) vs: (CartaDeTruco espadaCon:1 ).
	
	self 
		should: [rondaDeTruco ganador]
		raise: Error -MessageNotUnderstood 
		withExceptionDo: [:anError|
			self assert: RondaDeTrucoSinRefactor noTerminoLaRondaTodavia equals: anError messageText .
			self assert: (rondaDeTruco rondasJugadas) equals: 1.
			].
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:41:57'!
test11
	| rondaDeTruco |
	
	rondaDeTruco _ RondaDeTrucoSinRefactor
		entreJugador: jugadorA
		vs: jugadorB primeraParda: true
		.
	
	rondaDeTruco enfrentamientoEntre: (CartaDeTruco oroCon: 4) vs: (CartaDeTruco oroCon: 2) .
	rondaDeTruco enfrentamientoEntre: CartaDeTruco anchoDeBasto vs: 	CartaDeTruco anchoDeEspada.
	
	self 
	should: [rondaDeTruco enfrentamientoEntre: (CartaDeTruco copaCon: 3) vs: (CartaDeTruco copaCon: 4)] 
	raise:  Error - MessageNotUnderstood 
	withExceptionDo: [:anError|
		self assert: RondaDeTrucoSinRefactor noSePuedeJugarCuandoYaHayGanadorError equals: anError messageText. 
		self assert: (rondaDeTruco rondasJugadas) equals: 2.
		self assert: (rondaDeTruco enfretamientosGanadosPor: jugadorA) equals: 0.
		self assert: (rondaDeTruco enfretamientosGanadosPor: jugadorB) equals: 2.
		self assert: (rondaDeTruco ganador) equals: jugadorB .]
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:41:57'!
test12
	| rondaDeTruco |
	
	rondaDeTruco _ RondaDeTrucoSinRefactor
		entreJugador: jugadorA
		vs: jugadorB primeraParda: true
		.
	
	rondaDeTruco enfrentamientoEntre: (CartaDeTruco bastoCon: 2) vs: (CartaDeTruco oroCon: 2) .
	rondaDeTruco enfrentamientoEntre: (CartaDeTruco bastoCon: 7) vs: (CartaDeTruco copaCon: 7) .	
	
	self assert: (rondaDeTruco rondasJugadas) equals: 2.
	self assert: (rondaDeTruco enfretamientosGanadosPor: jugadorA) equals: 1.
	self assert: (rondaDeTruco enfretamientosGanadosPor: jugadorB) equals: 0.
	self assert: (rondaDeTruco ganador) equals: jugadorA .
	
	! !

!RondaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:41:57'!
test13
	| rondaDeTruco tresCartasA tresCartasB |
	tresCartasA := OrderedCollection new.
	tresCartasA add: (CartaDeTruco oroCon: 4).
	tresCartasA add: CartaDeTruco anchoDeEspada.
	tresCartasA add: (CartaDeTruco copaCon: 3).
	tresCartasB := OrderedCollection new.
	tresCartasB add: (CartaDeTruco oroCon: 2).
	tresCartasB add: CartaDeTruco anchoDeBasto.
	tresCartasB add: (CartaDeTruco copaCon: 4).
	jugadorA conCartas: tresCartasA.
	jugadorB conCartas: tresCartasB.
	rondaDeTruco _ RondaDeTrucoSinRefactor
		entreJugador: jugadorA
		vs: jugadorB primeraParda: true.
	
	rondaDeTruco jugar.
	
	self assert: (rondaDeTruco rondasJugadas) equals: 3.
	self assert: (rondaDeTruco enfretamientosGanadosPor: jugadorA) equals: 2.
	self assert: (rondaDeTruco enfretamientosGanadosPor: jugadorB) equals: 1.
	self assert: (rondaDeTruco ganador) equals: jugadorA .
	
	! !


!classDefinition: #CartaDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #CartaDeTruco
	instanceVariableNames: 'palo numero'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!CartaDeTruco methodsFor: 'initialization'!
initializePalo: arg1 numero: arg2
	palo _ arg1.
	numero _ arg2.! !


!CartaDeTruco methodsFor: 'comparing'!
= arg1
	^ (arg1 isKindOf: self class) and: [
		(arg1 paloEs: palo) and: [ arg1 numeroEs: numero ]].! !

!CartaDeTruco methodsFor: 'comparing'!
empardaCon: arg1
	^ self valor = arg1 valor.! !

!CartaDeTruco methodsFor: 'comparing'!
hash
	^ palo hash bitXor: numero hash.! !

!CartaDeTruco methodsFor: 'comparing'!
mataA: arg1
	^ self valor < arg1 valor.! !

!CartaDeTruco methodsFor: 'comparing'!
numeroEs: arg1
	^ numero = arg1.! !

!CartaDeTruco methodsFor: 'comparing'!
paloEs: arg1
	^ palo = arg1.! !


!CartaDeTruco methodsFor: 'testing'!
esAncho
	^ self numeroEs: 1.! !

!CartaDeTruco methodsFor: 'testing'!
esAnchoDeBasto
	^ self esAncho and: [ self esDeBasto ].! !

!CartaDeTruco methodsFor: 'testing'!
esAnchoDeEspada
	^ self esAncho and: [ self esDeEspada ].! !

!CartaDeTruco methodsFor: 'testing'!
esAnchoFalso
	^ self esAncho and: [
		self esDeOro or: [ self esDeCopa ]].! !

!CartaDeTruco methodsFor: 'testing'!
esCaballo
	^ self numeroEs: 11.! !

!CartaDeTruco methodsFor: 'testing'!
esDeBasto
	^ self paloEs: self basto.! !

!CartaDeTruco methodsFor: 'testing'!
esDeCopa
	^ self paloEs: self copa.! !

!CartaDeTruco methodsFor: 'testing'!
esDeEspada
	^ self paloEs: self espada.! !

!CartaDeTruco methodsFor: 'testing'!
esDeOro
	^ self paloEs: self oro.! !

!CartaDeTruco methodsFor: 'testing'!
esRey
	^ self numeroEs: 12.! !

!CartaDeTruco methodsFor: 'testing'!
esSiete
	^ self numeroEs: 7.! !

!CartaDeTruco methodsFor: 'testing'!
esSieteDeEspadas
	^ self esSiete and: [ self esDeEspada ].! !

!CartaDeTruco methodsFor: 'testing'!
esSieteDeOro
	^ self esSiete and: [ self esDeOro ].! !

!CartaDeTruco methodsFor: 'testing'!
esSieteFalso
	^ self esSiete and: [
		self esDeCopa or: [ self esDeBasto ]].! !

!CartaDeTruco methodsFor: 'testing'!
esSota
	^ self numeroEs: 10.! !


!CartaDeTruco methodsFor: 'printing'!
printOn: arg1
	arg1
		print: numero;
		nextPutAll: ' de ';
		nextPutAll: palo.! !


!CartaDeTruco methodsFor: 'valor'!
valor
	^ self class valorDe: self.! !


!CartaDeTruco methodsFor: 'palos'!
basto
	^ self class basto.! !

!CartaDeTruco methodsFor: 'palos'!
copa
	^ self class copa.! !

!CartaDeTruco methodsFor: 'palos'!
espada
	^ self class espada.! !

!CartaDeTruco methodsFor: 'palos'!
oro
	^ self class oro.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartaDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
CartaDeTruco class
	instanceVariableNames: 'ordenDePrioridad'!

!CartaDeTruco class methodsFor: 'instance creation'!
anchoDeBasto
	^ self bastoCon: 1.! !

!CartaDeTruco class methodsFor: 'instance creation'!
anchoDeEspada
	^ self espadaCon: 1.! !

!CartaDeTruco class methodsFor: 'instance creation'!
bastoCon: arg1
	^ self
		palo: self basto
		numero: arg1.! !

!CartaDeTruco class methodsFor: 'instance creation'!
copaCon: arg1
	^ self
		palo: self copa
		numero: arg1.! !

!CartaDeTruco class methodsFor: 'instance creation'!
espadaCon: arg1
	^ self
		palo: self espada
		numero: arg1.! !

!CartaDeTruco class methodsFor: 'instance creation'!
oroCon: arg1
	^ self
		palo: self oro
		numero: arg1.! !

!CartaDeTruco class methodsFor: 'instance creation'!
palo: arg1 numero: arg2
	self assertNúmeroEsVálido: arg2.
	self assertPaloEsVálido: arg1.
	^ self new
		initializePalo: arg1
		numero: arg2.! !

!CartaDeTruco class methodsFor: 'instance creation'!
sieteDeEspada
	^ self espadaCon: 7.! !

!CartaDeTruco class methodsFor: 'instance creation'!
sieteDeOro
	^ self oroCon: 7.! !


!CartaDeTruco class methodsFor: 'palos'!
basto
	^ #basto.! !

!CartaDeTruco class methodsFor: 'palos'!
copa
	^ #copa.! !

!CartaDeTruco class methodsFor: 'palos'!
espada
	^ #espada.! !

!CartaDeTruco class methodsFor: 'palos'!
oro
	^ #oro.! !

!CartaDeTruco class methodsFor: 'palos'!
palos
	^ #(#espada #basto #oro #copa ).! !


!CartaDeTruco class methodsFor: 'initialization'!
initializeOrdenDePrioridad
	ordenDePrioridad _ OrderedCollection new.
	ordenDePrioridad
		add: [ :arg1 |
			arg1 esAnchoDeEspada ];
		add: [ :arg1 |
			arg1 esAnchoDeBasto ];
		add: [ :arg1 |
			arg1 esSieteDeEspadas ];
		add: [ :arg1 |
			arg1 esSieteDeOro ];
		add: [ :arg1 |
			arg1 numeroEs: 3 ];
		add: [ :arg1 |
			arg1 numeroEs: 2 ];
		add: [ :arg1 |
			arg1 esAnchoFalso ];
		add: [ :arg1 |
			arg1 esRey ];
		add: [ :arg1 |
			arg1 esCaballo ];
		add: [ :arg1 |
			arg1 esSota ];
		add: [ :arg1 |
			arg1 esSieteFalso ];
		add: [ :arg1 |
			arg1 numeroEs: 6 ];
		add: [ :arg1 |
			arg1 numeroEs: 5 ];
		add: [ :arg1 |
			arg1 numeroEs: 4 ];
		yourself.! !


!CartaDeTruco class methodsFor: 'valor'!
ordenDePrioridad
	^ ordenDePrioridad ifNil: [ self initializeOrdenDePrioridad ].! !

!CartaDeTruco class methodsFor: 'valor'!
valorDe: arg1
	self ordenDePrioridad withIndexDo: [ :arg2 :arg3 |
		(arg2 value: arg1) ifTrue: [ ^ arg3 ].
		nil ].
	self error: self tablaDeValoresIncorrectaOCartaInvalidaErrorDescription.! !


!CartaDeTruco class methodsFor: 'error descriptions'!
numeroDeCartaInvalidoErrorDescription
	^ 'El truco no se puede jugar con ochos ni con nueves'.! !

!CartaDeTruco class methodsFor: 'error descriptions'!
paloInvalidoErrorDescription
	^ 'Los palos de la carta solo pueden ser espada, basto, oro y copa'.! !

!CartaDeTruco class methodsFor: 'error descriptions'!
tablaDeValoresIncorrectaOCartaInvalidaErrorDescription
	^ 'Error de programación: Tabla de valores incorrecta o carta inválida'.! !


!CartaDeTruco class methodsFor: 'assertions'!
assertNúmeroEsVálido: arg1
	arg1 < 1 ifTrue: [ self error: self numeroDeCartaInvalidoErrorDescription ].
	arg1 > 12 ifTrue: [ self error: self numeroDeCartaInvalidoErrorDescription ].
	(arg1
		between: 8
		and: 9) ifTrue: [ self error: self numeroDeCartaInvalidoErrorDescription ].
	arg1 isInteger ifFalse: [ self error: self numeroDeCartaInvalidoErrorDescription ].! !

!CartaDeTruco class methodsFor: 'assertions'!
assertPaloEsVálido: arg1
	^ (self palos includes: arg1) ifFalse: [ self error: self paloInvalidoErrorDescription ].! !


!classDefinition: #Jugador category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #Jugador
	instanceVariableNames: 'nombre cartas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Jugador methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 20:35:50'!
cartas
	^cartas ! !

!Jugador methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 20:22:48'!
conCartas: tresCartas

	cartas addAll: tresCartas .! !

!Jugador methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 20:22:17'!
initializeWith: unNombre
	nombre := unNombre.
	cartas := OrderedCollection new.! !

!Jugador methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 20:23:40'!
nombre
	^nombre! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Jugador class' category: 'ISW1-2021-1C-2doParcial'!
Jugador class
	instanceVariableNames: ''!

!Jugador class methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 20:28:08'!
llamado: unNombre
	
	^self new initializeWith: unNombre! !


!classDefinition: #NumeroRondaDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #NumeroRondaDeTruco
	instanceVariableNames: 'jugadorA jugadorB ronda jugadores primerRondaParda cartasUsadas partida'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!


!NumeroRondaDeTruco methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:17:45'!
enfretamientosGanadosPor: unJugador 
	
	^jugadores occurrencesOf: unJugador nombre.! !

!NumeroRondaDeTruco methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:49:06'!
ganador
	
	ronda ganador.! !

!NumeroRondaDeTruco methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:17:45'!
jugadorMano
	^jugadorA nombre! !

!NumeroRondaDeTruco methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:40:36'!
jugar
	
	jugadores add: (ronda enfrentamientoEntre: jugadorA cartas first vs: jugadorB cartas first).
	
	jugadores add: (ronda enfrentamientoEntre: jugadorA cartas second vs: 	 jugadorB cartas second). 
	
	jugadores add: (ronda enfrentamientoEntre: jugadorA cartas third vs:  jugadorB cartas third).! !

!NumeroRondaDeTruco methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:34:57'!
rondasJugadas
	^ronda numero! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NumeroRondaDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
NumeroRondaDeTruco class
	instanceVariableNames: ''!

!NumeroRondaDeTruco class methodsFor: 'instance creation' stamp: 'pc 7/5/2021 21:19:29'!
entreJugador: unJugador vs: otroJugador unaPartida: unaPartidaDeTruco
	
	^self new initializeEntreJugador: unJugador vs: otroJugador unaPartida: unaPartidaDeTruco! !


!NumeroRondaDeTruco class methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:17:45'!
cartaRepetidaError
	^'la carta quese quiere usar ya fue usada'! !

!NumeroRondaDeTruco class methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:17:45'!
noSePuedeJugarCuandoYaHayGanadorError
	^'no se puede continuar el partido una vez finalizado'! !

!NumeroRondaDeTruco class methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:17:45'!
noTerminoLaRondaTodavia
	
	^'no se puede saber el ganador antes de que termine la ronda'! !


!classDefinition: #Ronda1 category: 'ISW1-2021-1C-2doParcial'!
NumeroRondaDeTruco subclass: #Ronda1
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Ronda1 methodsFor: 'initialization' stamp: 'pc 7/5/2021 21:49:48'!
ganador
	^self error: partida class noTerminoLaRondaTodavia.! !

!Ronda1 methodsFor: 'initialization' stamp: 'pc 7/5/2021 21:20:43'!
initializeEntreJugador: unJugador vs: otroJugador unaPartida: unaPartidaDeTruco 
	
	partida:=unaPartidaDeTruco .
	jugadorA := unJugador .
	jugadorB := otroJugador .! !


!Ronda1 methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:39:50'!
enfrentamientoEntre: cartaDeTrucoA vs: cartaDeTrucoB
	
	self revisarCartasRepetidasEntre: cartaDeTrucoA y: cartaDeTrucoB.
	
	cartasUsadas add: cartaDeTrucoA.
	cartasUsadas add: cartaDeTrucoB.

	partida cambiarDeRonda.
	(cartaDeTrucoA mataA: cartaDeTrucoB) ifTrue: [^jugadorA nombre]. 
	(cartaDeTrucoB mataA: cartaDeTrucoA) ifTrue: [^jugadorB nombre].
	(cartaDeTrucoB empardaCon: cartaDeTrucoA) ifTrue: [partida priviaRondaParda].
! !

!Ronda1 methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:35:12'!
numero 
	^1! !

!Ronda1 methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:22:26'!
revisarCartasRepetidasEntre: cartaDeTrucoA y: cartaDeTrucoB.
	
cartaDeTrucoA = cartaDeTrucoB ifTrue: [^self error: self class cartaRepetidaError].
! !


!classDefinition: #Ronda2 category: 'ISW1-2021-1C-2doParcial'!
NumeroRondaDeTruco subclass: #Ronda2
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Ronda2 methodsFor: 'initialization' stamp: 'pc 7/5/2021 21:20:43'!
initializeEntreJugador: unJugador vs: otroJugador unaPartida: unaPartidaDeTruco 
	
	partida:=unaPartidaDeTruco .
	jugadorA := unJugador .
	jugadorB := otroJugador .! !

!Ronda2 methodsFor: 'initialization' stamp: 'pc 7/5/2021 21:35:27'!
numero 
	^2! !


!Ronda2 methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:47:31'!
enfrentamientoEntre: cartaDeTrucoA vs: cartaDeTrucoB
	
	self revisarFinalizacionDeRonda.
	
	self revisarCartasRepetidasEntre: cartaDeTrucoA y: cartaDeTrucoB.
	
	cartasUsadas add: cartaDeTrucoA.
	cartasUsadas add: cartaDeTrucoB.

	(cartaDeTrucoA mataA: cartaDeTrucoB) ifTrue: [^jugadorA nombre]. 
	(cartaDeTrucoB mataA: cartaDeTrucoA) ifTrue: [^jugadorB nombre].
	((cartaDeTrucoB empardaCon: cartaDeTrucoA) and: primerRondaParda) ifTrue: [jugadores add: self jugadorMano].
	(cartaDeTrucoB empardaCon: cartaDeTrucoA) ifTrue: [primerRondaParda := true].
! !

!Ronda2 methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:21:57'!
revisarCartasRepetidasEntre: cartaDeTrucoA y: cartaDeTrucoB.
	
		((cartasUsadas includes: cartaDeTrucoA) or: [(cartasUsadas includes: cartaDeTrucoB) or: [cartaDeTrucoA = cartaDeTrucoB ]]) ifTrue: [^self error: self class cartaRepetidaError].
! !

!Ronda2 methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:22:50'!
revisarFinalizacionDeRonda.
	
	((self enfretamientosGanadosPor: jugadorA ) = 2 or: [(self enfretamientosGanadosPor: jugadorB ) =2] ) ifTrue: [self error: self class noSePuedeJugarCuandoYaHayGanadorError].
! !


!classDefinition: #Ronda3 category: 'ISW1-2021-1C-2doParcial'!
NumeroRondaDeTruco subclass: #Ronda3
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Ronda3 methodsFor: 'initialization' stamp: 'pc 7/5/2021 21:20:43'!
initializeEntreJugador: unJugador vs: otroJugador unaPartida: unaPartidaDeTruco 
	
	partida:=unaPartidaDeTruco .
	jugadorA := unJugador .
	jugadorB := otroJugador .! !


!Ronda3 methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:20:52'!
enfrentamientoEntre: cartaDeTrucoA vs: cartaDeTrucoB
	
	self revisarFinalizacionDeRonda.
	
	self revisarCartasRepetidasEntre: cartaDeTrucoA y: cartaDeTrucoB.
	
	cartasUsadas add: cartaDeTrucoA.
	cartasUsadas add: cartaDeTrucoB.

	ronda := ronda + 1.
	(cartaDeTrucoA mataA: cartaDeTrucoB) ifTrue: [jugadores add: jugadorA nombre]. 
	(cartaDeTrucoB mataA: cartaDeTrucoA) ifTrue: [jugadores add:jugadorB nombre].
	((cartaDeTrucoB empardaCon: cartaDeTrucoA) and: primerRondaParda) ifTrue: [jugadores add: self jugadorMano].
	(cartaDeTrucoB empardaCon: cartaDeTrucoA) ifTrue: [primerRondaParda := true].
! !

!Ronda3 methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:35:31'!
numero 
	^3! !

!Ronda3 methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:21:57'!
revisarCartasRepetidasEntre: cartaDeTrucoA y: cartaDeTrucoB.
	
		((cartasUsadas includes: cartaDeTrucoA) or: [(cartasUsadas includes: cartaDeTrucoB) or: [cartaDeTrucoA = cartaDeTrucoB ]]) ifTrue: [^self error: self class cartaRepetidaError].
! !

!Ronda3 methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 21:22:50'!
revisarFinalizacionDeRonda.
	
	((self enfretamientosGanadosPor: jugadorA ) = 2 or: [(self enfretamientosGanadosPor: jugadorB ) =2] ) ifTrue: [self error: self class noSePuedeJugarCuandoYaHayGanadorError].
! !


!classDefinition: #RondaDeTrucoSinRefactor category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #RondaDeTrucoSinRefactor
	instanceVariableNames: 'jugadorA jugadorB ronda jugadores primerRondaParda cartasUsadas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTrucoSinRefactor methodsFor: 'initialization' stamp: 'pc 7/5/2021 20:47:41'!
initializeEntreJugador: unJugador vs: otroJugador 
	
	primerRondaParda := false.
	ronda := 0 .
	jugadorA := unJugador .
	jugadorB := otroJugador .
	jugadores := Bag new.
	cartasUsadas := OrderedCollection new.! !


!RondaDeTrucoSinRefactor methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 20:55:02'!
enfrentamientoEntre: cartaDeTrucoA vs: cartaDeTrucoB
	
	self revisarFinalizacionDeRonda.
	
	self revisarCartasRepetidasEntre: cartaDeTrucoA y: cartaDeTrucoB.
	
	cartasUsadas add: cartaDeTrucoA.
	cartasUsadas add: cartaDeTrucoB.

	ronda := ronda + 1.
	(cartaDeTrucoA mataA: cartaDeTrucoB) ifTrue: [jugadores add: jugadorA nombre]. 
	(cartaDeTrucoB mataA: cartaDeTrucoA) ifTrue: [jugadores add:jugadorB nombre].
	((cartaDeTrucoB empardaCon: cartaDeTrucoA) and: primerRondaParda) ifTrue: [jugadores add: self jugadorMano].
	(cartaDeTrucoB empardaCon: cartaDeTrucoA) ifTrue: [primerRondaParda := true].
! !

!RondaDeTrucoSinRefactor methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 20:24:37'!
enfretamientosGanadosPor: unJugador 
	
	^jugadores occurrencesOf: unJugador nombre.! !

!RondaDeTrucoSinRefactor methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 20:39:39'!
ganador
	
	ronda = 3 ifTrue:[
		((jugadores occurrencesOf: jugadorA nombre) > (jugadores occurrencesOf: jugadorB nombre)) ifTrue: [^jugadorA  ] ifFalse: [^jugadorB ]].
	(ronda = 2 and: [primerRondaParda or: [(self enfretamientosGanadosPor: jugadorA ) = 2 or: [(self enfretamientosGanadosPor: jugadorB ) =2]]])
		ifTrue:[
		((jugadores occurrencesOf: jugadorA nombre) > (jugadores occurrencesOf: jugadorB nombre)) ifTrue: [^jugadorA  ] ifFalse: [^jugadorB ]].
	
	self error: self class noTerminoLaRondaTodavia.! !

!RondaDeTrucoSinRefactor methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 20:26:49'!
jugadorMano
	^jugadorA nombre! !

!RondaDeTrucoSinRefactor methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 20:55:02'!
jugar
	
	self enfrentamientoEntre: jugadorA cartas first vs: jugadorB cartas first.
	self enfrentamientoEntre: jugadorA cartas second vs: 	 jugadorB cartas second. 
	self enfrentamientoEntre: jugadorA cartas third vs:  jugadorB cartas third.! !

!RondaDeTrucoSinRefactor methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 20:03:00'!
revisarCartasRepetidasEntre: cartaDeTrucoA y: cartaDeTrucoB.
	
		((cartasUsadas includes: cartaDeTrucoA) or: [(cartasUsadas includes: cartaDeTrucoB) or: [cartaDeTrucoA = cartaDeTrucoB ]]) ifTrue: [^self error: self class cartaRepetidaError].
! !

!RondaDeTrucoSinRefactor methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 20:44:01'!
revisarFinalizacionDeRonda.
	
	((self enfretamientosGanadosPor: jugadorA ) = 2 or: [(self enfretamientosGanadosPor: jugadorB ) =2] ) ifTrue: [self error: self class noSePuedeJugarCuandoYaHayGanadorError].
! !

!RondaDeTrucoSinRefactor methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 18:20:23'!
rondasJugadas
	^ronda! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RondaDeTrucoSinRefactor class' category: 'ISW1-2021-1C-2doParcial'!
RondaDeTrucoSinRefactor class
	instanceVariableNames: ''!

!RondaDeTrucoSinRefactor class methodsFor: 'instance creation' stamp: 'pc 7/5/2021 20:51:48'!
entreJugador: unJugador vs: otroJugador primeraParda: rondaPreviaParda   
	
	^self new initializeEntreJugador: unJugador vs: otroJugador ! !


!RondaDeTrucoSinRefactor class methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 19:15:14'!
cartaRepetidaError
	^'la carta quese quiere usar ya fue usada'! !

!RondaDeTrucoSinRefactor class methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 19:36:41'!
noSePuedeJugarCuandoYaHayGanadorError
	^'no se puede continuar el partido una vez finalizado'! !

!RondaDeTrucoSinRefactor class methodsFor: 'as yet unclassified' stamp: 'pc 7/5/2021 19:20:44'!
noTerminoLaRondaTodavia
	
	^'no se puede saber el ganador antes de que termine la ronda'! !
