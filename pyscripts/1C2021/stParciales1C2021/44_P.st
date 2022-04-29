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


!classDefinition: #PartidaDeTrucoTest category: 'ISW1-2021-1C-2doParcial'!
TestCase subclass: #PartidaDeTrucoTest
	instanceVariableNames: 'anchoDeEspada cuatroDeCopas sieteDeOro cuatroDeBasto dosDeEspada cincoDeOro'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!PartidaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 19:36:31'!
test01RepeatedCardsAreNotAllowedIntoTheGame
	|cardsPlayer1 cardsPlayer2|
	cardsPlayer1 :=Array with:anchoDeEspada with:cuatroDeCopas with:sieteDeOro.
	cardsPlayer2 :=Array with:anchoDeEspada with:cuatroDeBasto with:dosDeEspada.
	self 
		should: [ PartidaDeTruco withPlayerACards: cardsPlayer1 andPlayerBCards:cardsPlayer2 andPlayerA:(Player new) andPlayerB:(Player new). ]
		raise: Error 
		withMessageText: PartidaDeTruco invalidDistributedCards.! !

!PartidaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 19:37:04'!
test02LessThan3CardsAreNotAllowedIntoTheGameStart
	|cardsPlayer1 cardsPlayer2|
	cardsPlayer1 :=Array  with:cuatroDeCopas with:sieteDeOro.
	cardsPlayer2 :=Array with:anchoDeEspada with:cuatroDeBasto with:dosDeEspada.
	self 
		should: [ PartidaDeTruco withPlayerACards: cardsPlayer1 andPlayerBCards:cardsPlayer2 andPlayerA:(Player new) andPlayerB:(Player new).. ]
		raise: Error 
		withMessageText: PartidaDeTruco invalidDistributedCards.! !

!PartidaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 19:37:53'!
test03PlayerAWinsFirstMatchIfHisCardIsStronger
	|cardsPlayer1 cardsPlayer2 round playerA playerB winner |
	cardsPlayer1 :=Array  with:cincoDeOro with:cuatroDeCopas with:sieteDeOro.
	cardsPlayer2 :=Array with:anchoDeEspada with:cuatroDeBasto with:dosDeEspada.
	playerA:= PlayerMock initializeWithChosenCard:3.
	playerB:= PlayerMock initializeWithChosenCard:2.
	round :=PartidaDeTruco withPlayerACards: cardsPlayer1 andPlayerBCards:cardsPlayer2 andPlayerA:playerA andPlayerB:playerB.
	
	winner := round playRound.
	self assert: winner equals:'Gano la mano'! !

!PartidaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 19:39:43'!
test04PlayerAEmpardaIfHisCardIsAsStrongAsRival
	|cardsPlayer1 cardsPlayer2 round playerA playerB winner |
	cardsPlayer1 :=Array  with:cincoDeOro with:cuatroDeCopas with:sieteDeOro.
	cardsPlayer2 :=Array with:anchoDeEspada with:cuatroDeBasto with:dosDeEspada.
	playerA:= PlayerMock initializeWithChosenCard:2.
	playerB:= PlayerMock initializeWithChosenCard:2.
	round :=PartidaDeTruco withPlayerACards: cardsPlayer1 andPlayerBCards:cardsPlayer2 andPlayerA:playerA andPlayerB:playerB.
	
	winner := round playRound.
	self assert: winner equals:'Pardas'! !

!PartidaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 20:17:56'!
test05PlayerALosesRoundIfHisCardIsAsWeakerThanRival
	|cardsPlayer1 cardsPlayer2 round playerA playerB winner |
	cardsPlayer1 :=Array  with:cincoDeOro with:cuatroDeCopas with:sieteDeOro.
	cardsPlayer2 :=Array with:anchoDeEspada with:cuatroDeBasto with:dosDeEspada.
	playerA:= PlayerMock initializeWithChosenCard:2.
	playerB:= PlayerMock initializeWithChosenCard:3.
	round :=PartidaDeTruco withPlayerACards: cardsPlayer1 andPlayerBCards:cardsPlayer2 andPlayerA:playerA andPlayerB:playerB.
	
	winner := round playRound.
	self assert: winner equals:'Gana el pie'.! !

!PartidaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 20:33:23'!
test06PlayerAWinsIfHas2ConsecutiveVictories
	|cardsPlayer1 cardsPlayer2 round playerA playerB winner |
	cardsPlayer1 :=Array  with:cincoDeOro with:cuatroDeCopas with:(CartaDeTruco sieteDeEspada).
	cardsPlayer2 :=Array with:anchoDeEspada with:cuatroDeBasto with:dosDeEspada.
	playerA:= PlayerMock initializeWithChosenCard:1.
	playerB:= PlayerMock initializeWithChosenCard:2.
	round :=PartidaDeTruco withPlayerACards: cardsPlayer1 andPlayerBCards:cardsPlayer2 andPlayerA:playerA andPlayerB:playerB.
	round playRound.
	playerA changeChosenCard: 2.
	playerB changeChosenCard: 2.
	winner := round playRound.
	self assert: winner equals:'Gano el Jugador 1!!!!'.! !

!PartidaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 20:42:13'!
test07PlayerAWinsIfHasAWinAndAParda
	|cardsPlayer1 cardsPlayer2 round playerA playerB winner |
	cardsPlayer1 :=Array  with:cincoDeOro with:cuatroDeCopas with:(CartaDeTruco sieteDeEspada).
	cardsPlayer2 :=Array with:anchoDeEspada with:cuatroDeBasto with:dosDeEspada.
	playerA:= PlayerMock initializeWithChosenCard:3.
	playerB:= PlayerMock initializeWithChosenCard:3.
	round :=PartidaDeTruco withPlayerACards: cardsPlayer1 andPlayerBCards:cardsPlayer2 andPlayerA:playerA andPlayerB:playerB.
	round playRound.
	playerA changeChosenCard: 2.
	playerB changeChosenCard: 2.
	winner := round playRound.
	self assert: winner equals:'Gano el Jugador 1!!!!'.! !

!PartidaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 20:43:54'!
test08ThirdRoundNeededIfPlayerAWinsOneAndLosesOne
	|cardsPlayer1 cardsPlayer2 round playerA playerB winner |
	cardsPlayer1 :=Array  with:cincoDeOro with:cuatroDeCopas with:(CartaDeTruco sieteDeEspada).
	cardsPlayer2 :=Array with:anchoDeEspada with:cuatroDeBasto with:dosDeEspada.
	playerA:= PlayerMock initializeWithChosenCard:1.
	playerB:= PlayerMock initializeWithChosenCard:2.
	round :=PartidaDeTruco withPlayerACards: cardsPlayer1 andPlayerBCards:cardsPlayer2 andPlayerA:playerA andPlayerB:playerB.
	round playRound.
	playerA changeChosenCard: 1.
	playerB changeChosenCard: 2.
	winner := round playRound.
	self assert: winner equals:'Empate'.! !

!PartidaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 20:57:20'!
test09PlayerBWinsIfHas2ConsecutiveVictories
	|cardsPlayer1 cardsPlayer2 round playerA playerB winner |
	cardsPlayer1 :=Array  with:cincoDeOro with:cuatroDeCopas with:(CartaDeTruco sieteDeEspada).
	cardsPlayer2 :=Array with:anchoDeEspada with:cuatroDeBasto with:dosDeEspada.
	playerA:= PlayerMock initializeWithChosenCard:2.
	playerB:= PlayerMock initializeWithChosenCard:3.
	round :=PartidaDeTruco withPlayerACards: cardsPlayer1 andPlayerBCards:cardsPlayer2 andPlayerA:playerA andPlayerB:playerB.
	round playRound.
	playerA changeChosenCard: 1.
	playerB changeChosenCard: 1.
	winner := round playRound.
	self assert: winner equals:'Gano el Jugador 2!!!!'.! !

!PartidaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 21:07:51'!
test10ThirdRoundWonByAIfLastGameIsWonByHim
	|cardsPlayer1 cardsPlayer2 round playerA playerB winner |
	cardsPlayer1 :=Array  with:cincoDeOro with:cuatroDeCopas with:anchoDeEspada.
	cardsPlayer2 :=Array with:(CartaDeTruco sieteDeEspada) with:cuatroDeBasto with:dosDeEspada.
	playerA:= PlayerMock initializeWithChosenCard:1.
	playerB:= PlayerMock initializeWithChosenCard:2.
	round :=PartidaDeTruco withPlayerACards: cardsPlayer1 andPlayerBCards:cardsPlayer2 andPlayerA:playerA andPlayerB:playerB.
	round playRound.
	playerA changeChosenCard: 1.
	playerB changeChosenCard: 2.
	round playRound.
	playerA changeChosenCard: 1.
	playerB changeChosenCard: 1.
	winner := round playRound.
	self assert: winner equals:'Gano el Jugador 1!!!!'.! !

!PartidaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 21:18:38'!
test11CannotPlayBeyondThirdRound
	|cardsPlayer1 cardsPlayer2 round playerA playerB |
	cardsPlayer1 :=Array  with:cincoDeOro with:cuatroDeCopas with:anchoDeEspada.
	cardsPlayer2 :=Array with:(CartaDeTruco sieteDeEspada) with:cuatroDeBasto with:dosDeEspada.
	playerA:= PlayerMock initializeWithChosenCard:1.
	playerB:= PlayerMock initializeWithChosenCard:2.
	round :=PartidaDeTruco withPlayerACards: cardsPlayer1 andPlayerBCards:cardsPlayer2 andPlayerA:playerA andPlayerB:playerB.
	round playRound.
	playerA changeChosenCard: 1.
	playerB changeChosenCard: 2.
	round playRound.
	playerA changeChosenCard: 1.
	playerB changeChosenCard: 1.
	round playRound.
	self 
		should: [ round playRound. ]
		raise: Error 
		withMessageText: RondaDeTruco partidaFinalizada.! !

!PartidaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 21:23:03'!
test12PlayerBWinsIfHasAWinAndAParda
	|cardsPlayer1 cardsPlayer2 round playerA playerB winner |
	cardsPlayer1 :=Array  with:cincoDeOro with:cuatroDeCopas with:(CartaDeTruco sieteDeEspada).
	cardsPlayer2 :=Array with:anchoDeEspada with:cuatroDeBasto with:dosDeEspada.
	playerA:= PlayerMock initializeWithChosenCard:1.
	playerB:= PlayerMock initializeWithChosenCard:3.
	round :=PartidaDeTruco withPlayerACards: cardsPlayer1 andPlayerBCards:cardsPlayer2 andPlayerA:playerA andPlayerB:playerB.
	round playRound.
	playerA changeChosenCard: 1.
	playerB changeChosenCard: 2.
	winner := round playRound.
	self assert: winner equals:'Gano el Jugador 2!!!!'.! !

!PartidaDeTrucoTest methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 21:25:52'!
test13ThirdRoundWonByBIfLastGameIsWonByHim
	|cardsPlayer1 cardsPlayer2 round playerA playerB winner |
	cardsPlayer1 :=Array  with:cincoDeOro with:cuatroDeCopas with:anchoDeEspada.
	cardsPlayer2 :=Array with:(CartaDeTruco sieteDeEspada) with:cuatroDeBasto with:dosDeEspada.
	playerA:= PlayerMock initializeWithChosenCard:1.
	playerB:= PlayerMock initializeWithChosenCard:3.
	round :=PartidaDeTruco withPlayerACards: cardsPlayer1 andPlayerBCards:cardsPlayer2 andPlayerA:playerA andPlayerB:playerB.
	round playRound.
	playerA changeChosenCard: 2.
	playerB changeChosenCard: 2.
	round playRound.
	playerA changeChosenCard: 1.
	playerB changeChosenCard: 1.
	winner := round playRound.
	self assert: winner equals:'Gano el Jugador 2!!!!'.! !


!PartidaDeTrucoTest methodsFor: 'setUp/tearDown' stamp: 'DOO 7/5/2021 18:01:20'!
setUp
	anchoDeEspada := CartaDeTruco anchoDeEspada.
	cuatroDeCopas := CartaDeTruco copaCon: 4.
	sieteDeOro := CartaDeTruco oroCon: 7.
	cuatroDeBasto := CartaDeTruco bastoCon: 4.
	dosDeEspada := CartaDeTruco espadaCon: 2.
	cincoDeOro := CartaDeTruco oroCon: 5.! !


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


!classDefinition: #PartidaDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #PartidaDeTruco
	instanceVariableNames: 'storedPlayerACards storedPlayerBCards rondaState storedPlayerA storedPlayerB'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!PartidaDeTruco methodsFor: 'initialization' stamp: 'DOO 7/5/2021 19:34:10'!
withPlayerACards:playerACards andPlayerBCards:playerBCards andPlayerA:playerA andPlayerB:playerB.
	self checkValidityOf:playerACards and: playerBCards.
	storedPlayerACards:= playerACards.
	storedPlayerBCards:= playerBCards.
	storedPlayerA:= playerA.
	storedPlayerB:= playerB.
	rondaState := PrimeraRonda new.! !


!PartidaDeTruco methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 19:11:05'!
checkValidityOf:playerACards and: playerBCards
	((playerACards allSatisfy: [:card | (playerBCards includes: card) not]) and:
	[(((playerACards size) = (playerBCards size)) and: (playerACards size = 3))]) 
	ifFalse:[self error:PartidaDeTruco invalidDistributedCards ].! !

!PartidaDeTruco methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 19:59:00'!
firstPlayerChoice:player withCards:cards
	^player playAsFirstWith:cards! !

!PartidaDeTruco methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 21:03:48'!
playRound
	|chosenCardA chosenCardB|
	chosenCardA := rondaState firstPlayerChoice:self.
	chosenCardB := rondaState secondPlayerChoice:self withRivalChoice:chosenCardA.
	"HICE TREMENDO QUILOMBO EN ESTE PUNTO, DEBERIA USAR EL STATE PARA QUE HAGA ESTO TAMBIEN"
	storedPlayerACards:=storedPlayerACards select:[:card| (card = chosenCardA) not and:(card = chosenCardB) not].
	storedPlayerBCards :=storedPlayerBCards select:[:card| (card = chosenCardA) not and:(card = chosenCardB) not].
	^rondaState defineNewStateWith:chosenCardA and:chosenCardB forMatch:self.! !

!PartidaDeTruco methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 20:04:02'!
playerAAsFirst
	^ self firstPlayerChoice: storedPlayerA withCards: storedPlayerACards! !

!PartidaDeTruco methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 20:13:05'!
playerAAsLastWithRivalCard: aCartaDeTruco 
	^self secondPlayerChoice: storedPlayerA withCards: storedPlayerACards  andRivalChoice: aCartaDeTruco.! !

!PartidaDeTruco methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 20:04:20'!
playerBAsFirst
	^ self firstPlayerChoice: storedPlayerB withCards: storedPlayerBCards! !

!PartidaDeTruco methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 20:12:47'!
playerBAsLastWithRivalCard: aCartaDeTruco 
	^self secondPlayerChoice: storedPlayerB withCards: storedPlayerBCards  andRivalChoice: aCartaDeTruco.! !

!PartidaDeTruco methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 20:01:58'!
secondPlayerChoice:player withCards:cards andRivalChoice:aChosenCard
	^player playAsLastWith: cards andRivalChose: aChosenCard.! !


!PartidaDeTruco methodsFor: 'result actions' stamp: 'DOO 7/5/2021 20:16:05'!
firstRoundIsPardas
	rondaState := RondaDosEnPardas new.
	^'Pardas'! !

!PartidaDeTruco methodsFor: 'result actions' stamp: 'DOO 7/5/2021 20:15:03'!
firstRoundWonByPlayerOne
	rondaState := RondaDosParaJugadorUno new.
	^'Gano la mano'! !

!PartidaDeTruco methodsFor: 'result actions' stamp: 'DOO 7/5/2021 20:20:27'!
firstRoundWonByPlayerTwo
	rondaState := RondaDosParaJugadorDos new.
	^'Gana el pie'! !

!PartidaDeTruco methodsFor: 'result actions' stamp: 'DOO 7/5/2021 20:46:45'!
needsFinalMatchAndPlayerALostSecondRound
	rondaState := TerceraRondaParaJugadorDos new.
	^'Empate'! !

!PartidaDeTruco methodsFor: 'result actions' stamp: 'DOO 7/5/2021 20:48:46'!
needsFinalMatchAndPlayerBLostSecondRound
	rondaState := TerceraRondaParaJugadorUno new.
	^'Empate'! !

!PartidaDeTruco methodsFor: 'result actions' stamp: 'DOO 7/5/2021 20:40:08'!
victoryForPlayerOne
	rondaState := PartidaFinalizada new.
	^'Gano el Jugador 1!!!!'! !

!PartidaDeTruco methodsFor: 'result actions' stamp: 'DOO 7/5/2021 21:05:18'!
victoryForPlayerTwo
	rondaState := PartidaFinalizada new.
	^'Gano el Jugador 2!!!!'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PartidaDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
PartidaDeTruco class
	instanceVariableNames: ''!

!PartidaDeTruco class methodsFor: 'instance creation' stamp: 'DOO 7/5/2021 19:35:25'!
withPlayerACards: playerACards andPlayerBCards:playerBCards andPlayerA:playerA andPlayerB:playerB.
	^self new withPlayerACards: playerACards andPlayerBCards:playerBCards andPlayerA:playerA andPlayerB:playerB.! !


!PartidaDeTruco class methodsFor: 'error-messages' stamp: 'DOO 7/5/2021 17:42:53'!
invalidDistributedCards
	^'The cards distributed have invalid copies.'! !


!classDefinition: #Player category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #Player
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Player methodsFor: 'actions' stamp: 'DOO 7/5/2021 18:54:03'!
playAsFirstWith: anArray 
	self subclassResponsibility.! !

!Player methodsFor: 'actions' stamp: 'DOO 7/5/2021 18:53:51'!
playAsLastWith: storedPlayerBCards andRivalChose:chosenCardA
	self subclassResponsibility.! !


!classDefinition: #PlayerMock category: 'ISW1-2021-1C-2doParcial'!
Player subclass: #PlayerMock
	instanceVariableNames: 'chosenCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!PlayerMock methodsFor: 'initialization' stamp: 'DOO 7/5/2021 18:59:40'!
initializeInitializeWithChosenCard: chosenCardIndex 
	chosenCard := chosenCardIndex.! !


!PlayerMock methodsFor: 'actions' stamp: 'DOO 7/5/2021 20:29:51'!
changeChosenCard:aNewIndex
	chosenCard :=aNewIndex.! !

!PlayerMock methodsFor: 'actions' stamp: 'DOO 7/5/2021 19:01:52'!
playAsFirstWith: myCards
	^myCards at:chosenCard.
	! !

!PlayerMock methodsFor: 'actions' stamp: 'DOO 7/5/2021 19:02:41'!
playAsLastWith: myCards andRivalChose:chosenCardA
	^myCards at:chosenCard.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayerMock class' category: 'ISW1-2021-1C-2doParcial'!
PlayerMock class
	instanceVariableNames: ''!

!PlayerMock class methodsFor: 'instance creation' stamp: 'DOO 7/5/2021 18:58:56'!
initializeWithChosenCard: chosenCardIndex
	^self new initializeInitializeWithChosenCard: chosenCardIndex ! !


!classDefinition: #RondaDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #RondaDeTruco
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTruco methodsFor: 'state action' stamp: 'DOO 7/5/2021 19:42:34'!
defineNewStateWith: firstPlayerCard and: secondPlayerCard forMatch: aTrucoMatch
	self subclassResponsibility.! !


!RondaDeTruco methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 20:08:41'!
firstPlayerChoice: aPartidaDeTruco 
	self subclassResponsibility.! !

!RondaDeTruco methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 20:07:57'!
secondPlayerChoice: aPartidaDeTruco withRivalChoice: aPrimeraRonda 
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RondaDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco class
	instanceVariableNames: ''!

!RondaDeTruco class methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 20:52:19'!
partidaFinalizada
	^'Partida finalizada'! !


!classDefinition: #PartidaFinalizada category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco subclass: #PartidaFinalizada
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!PartidaFinalizada methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 20:53:09'!
defineNewStateWith: firstPlayerCard and: secondPlayerCard forMatch: aTrucoMatch
	self error:RondaDeTruco partidaFinalizada.! !

!PartidaFinalizada methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 20:53:37'!
firstPlayerChoice: aPartidaDeTruco 
	self error:RondaDeTruco partidaFinalizada.! !

!PartidaFinalizada methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 20:54:14'!
secondPlayerChoice: aPartidaDeTruco withRivalChoice: aPrimeraRonda 
	self error:RondaDeTruco partidaFinalizada.! !


!classDefinition: #PrimeraRonda category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco subclass: #PrimeraRonda
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!PrimeraRonda methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 19:46:20'!
defineNewStateWith: firstPlayerCard and: secondPlayerCard forMatch: aTrucoMatch
	(firstPlayerCard empardaCon: secondPlayerCard) ifTrue:[^aTrucoMatch firstRoundIsPardas.].
	(firstPlayerCard mataA: secondPlayerCard) ifTrue:[^aTrucoMatch firstRoundWonByPlayerOne.].
	^aTrucoMatch firstRoundWonByPlayerTwo.! !

!PrimeraRonda methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 20:09:37'!
firstPlayerChoice:aPartidaDeTruco
	^aPartidaDeTruco playerAAsFirst.! !

!PrimeraRonda methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 20:11:27'!
secondPlayerChoice: aPartidaDeTruco withRivalChoice: cardChoice 
	^aPartidaDeTruco playerBAsLastWithRivalCard:cardChoice.! !


!classDefinition: #RondaDosEnPardas category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco subclass: #RondaDosEnPardas
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDosEnPardas methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 21:09:57'!
defineNewStateWith: firstPlayerCard and: secondPlayerCard forMatch: aTrucoMatch
	(firstPlayerCard mataA: secondPlayerCard) ifTrue:[^aTrucoMatch firstRoundWonByPlayerOne.].
	^aTrucoMatch firstRoundWonByPlayerTwo.! !

!RondaDosEnPardas methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 21:09:18'!
firstPlayerChoice:aPartidaDeTruco
	^aPartidaDeTruco playerAAsFirst.! !

!RondaDosEnPardas methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 21:09:31'!
secondPlayerChoice: aPartidaDeTruco withRivalChoice: cardChoice 
	^aPartidaDeTruco playerBAsLastWithRivalCard:cardChoice.! !


!classDefinition: #RondaDosParaJugadorDos category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco subclass: #RondaDosParaJugadorDos
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDosParaJugadorDos methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 21:04:35'!
defineNewStateWith: firstPlayerCard and: secondPlayerCard forMatch: aTrucoMatch
	(secondPlayerCard mataA: firstPlayerCard ) ifTrue:[^aTrucoMatch needsFinalMatchAndPlayerBLostSecondRound .].
	^aTrucoMatch victoryForPlayerTwo.! !

!RondaDosParaJugadorDos methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 20:58:14'!
firstPlayerChoice:aPartidaDeTruco
	^aPartidaDeTruco playerBAsFirst.! !

!RondaDosParaJugadorDos methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 20:58:35'!
secondPlayerChoice: aPartidaDeTruco withRivalChoice: cardChoice 
	^aPartidaDeTruco playerAAsLastWithRivalCard:cardChoice.! !


!classDefinition: #RondaDosParaJugadorUno category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco subclass: #RondaDosParaJugadorUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDosParaJugadorUno methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 20:50:04'!
defineNewStateWith: firstPlayerCard and: secondPlayerCard forMatch: aTrucoMatch
	(secondPlayerCard mataA: firstPlayerCard) ifTrue:[^aTrucoMatch needsFinalMatchAndPlayerALostSecondRound .].
	^aTrucoMatch victoryForPlayerOne.! !

!RondaDosParaJugadorUno methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 20:33:54'!
firstPlayerChoice:aPartidaDeTruco
	^aPartidaDeTruco playerAAsFirst.! !

!RondaDosParaJugadorUno methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 20:34:42'!
secondPlayerChoice: aPartidaDeTruco withRivalChoice: cardChoice 
	^aPartidaDeTruco playerBAsLastWithRivalCard:cardChoice.! !


!classDefinition: #TerceraRondaParaJugadorDos category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco subclass: #TerceraRondaParaJugadorDos
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!TerceraRondaParaJugadorDos methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 21:14:48'!
defineNewStateWith: firstPlayerCard and: secondPlayerCard forMatch: aTrucoMatch
	(firstPlayerCard mataA: secondPlayerCard) ifTrue:[^aTrucoMatch victoryForPlayerTwo .].
	^aTrucoMatch victoryForPlayerOne.! !

!TerceraRondaParaJugadorDos methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 21:10:35'!
firstPlayerChoice:aPartidaDeTruco
	^aPartidaDeTruco playerBAsFirst.! !

!TerceraRondaParaJugadorDos methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 21:10:47'!
secondPlayerChoice: aPartidaDeTruco withRivalChoice: cardChoice 
	^aPartidaDeTruco playerAAsLastWithRivalCard:cardChoice.! !


!classDefinition: #TerceraRondaParaJugadorUno category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco subclass: #TerceraRondaParaJugadorUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!TerceraRondaParaJugadorUno methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 21:15:04'!
defineNewStateWith: firstPlayerCard and: secondPlayerCard forMatch: aTrucoMatch
	(firstPlayerCard mataA: secondPlayerCard) ifTrue:[^aTrucoMatch victoryForPlayerOne.].
	^aTrucoMatch victoryForPlayerTwo.! !

!TerceraRondaParaJugadorUno methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 21:12:14'!
firstPlayerChoice:aPartidaDeTruco
	^aPartidaDeTruco playerAAsFirst.! !

!TerceraRondaParaJugadorUno methodsFor: 'as yet unclassified' stamp: 'DOO 7/5/2021 21:12:29'!
secondPlayerChoice: aPartidaDeTruco withRivalChoice: cardChoice 
	^aPartidaDeTruco playerBAsLastWithRivalCard:cardChoice.! !
