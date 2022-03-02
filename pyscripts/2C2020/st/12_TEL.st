!classDefinition: #MagicSquareTest category: 'TerniLapilli'!
TestCase subclass: #MagicSquareTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!MagicSquareTest methodsFor: 'as yet unclassified' stamp: 'nt 11/1/2020 16:42:09'!
test01
	|magicsquare input|
	magicsquare:=MagicSquare new.
	input:=OrderedCollection new.
	input add:1@0.
	input add:2@2.
	
	self deny:(magicsquare checkGameOver:input)! !


!classDefinition: #TerniLapilliTest category: 'TerniLapilli'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'nt 10/31/2020 17:06:52'!
test01InvalidStartPlayer
	"comment stating purpose of message"

	| terniLapilli|
	terniLapilli:= TerniLapilli new.
	self assert: (terniLapilli isPlayingX).
	self should:[terniLapilli putOAt:0@0]
	raise:Error
	withExceptionDo:[:anError| 
		self assert: anError  messageText=TerniLapilli invalidPlayerErrorDescription]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'nt 10/31/2020 16:33:44'!
test02PutTokenAtOccupiedPosition
	"comment stating purpose of message"

	| terniLapilli|
	terniLapilli:= TerniLapilli new.
	terniLapilli putXAt:0@0.
	self should:[terniLapilli putOAt:0@0]
	raise:Error
	withExceptionDo:[:anError| 
		self assert: anError  messageText=TerniLapilli occupiedPositionErrorDescription]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'nt 10/31/2020 17:35:28'!
test03InvalidPositionOutsideBoardLimits
	

	| terniLapilli|
	terniLapilli:= TerniLapilli new.

	self should:[terniLapilli putXAt:3@3]
	raise:Error
	withExceptionDo:[:anError| 
		self assert: anError  messageText=TerniLapilli positionOutsideBoardLimits]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'nt 10/31/2020 18:20:40'!
test04MaxTokenAmountPerPlayerIsThree
	

	| terniLapilli|
	terniLapilli:= TerniLapilli new.
	terniLapilli putXAt:1@1.
	terniLapilli putOAt:1@2.
	terniLapilli putXAt:0@1.
	terniLapilli putOAt:0@2.
	terniLapilli putXAt:0@0.
	terniLapilli putOAt:1@0.
	
	self should:[terniLapilli putXAt:2@0]
	raise:Error
	withExceptionDo:[:anError| 
		self assert: anError  messageText=TerniLapilli maxAmountOfTokenExedeed]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'nt 10/31/2020 19:41:28'!
test05checkIfGameIsOverBecauseAPlayerWon
	

	| terniLapilli|
	terniLapilli:= TerniLapilli new.
	terniLapilli putXAt:0@0.
	terniLapilli putOAt:2@2.
	terniLapilli putXAt:0@1.
	terniLapilli putOAt:1@0.
	terniLapilli putXAt:0@2.

	self should:[terniLapilli putOAt:2@0]
	raise:Error
	withExceptionDo:[:anError| 
		self assert: anError  messageText=TerniLapilli gameIsOver]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'nt 11/1/2020 17:26:39'!
test06MakeAValidMovement

	| terniLapilli|
	terniLapilli:= TerniLapilli new.
	terniLapilli putXAt:0@0.
	terniLapilli putOAt:2@2.
	terniLapilli putXAt:0@1.
	terniLapilli putOAt:1@0.
	terniLapilli putXAt:2@1.
	terniLapilli putOAt:2@0.
	terniLapilli moveXFrom:0@0To:1@1.
	
	self assert:(terniLapilli isGameWon)! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'nt 11/1/2020 17:56:26'!
test07MakeAMovementOutOfTurn

	| terniLapilli|
	terniLapilli:= TerniLapilli new.
	terniLapilli putXAt:0@0.
	terniLapilli putOAt:2@2.
	terniLapilli putXAt:0@1.
	terniLapilli putOAt:1@0.
	terniLapilli putXAt:2@1.
	terniLapilli putOAt:2@0.
		
	self should:[terniLapilli moveOFrom:2@2To:1@1.]
	raise:Error
	withExceptionDo:[:anError| 
		self assert: anError  messageText=TerniLapilli invalidPlayerErrorDescription]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'nt 11/1/2020 17:41:03'!
test08MakeAMovementBeforeFillingTheBoard

	| terniLapilli|
	terniLapilli:= TerniLapilli new.
	terniLapilli putXAt:0@0.
	terniLapilli putOAt:2@2.
	terniLapilli putXAt:0@1.
	terniLapilli putOAt:1@0.
	terniLapilli putXAt:2@1.
		
	self should:[terniLapilli moveOFrom:2@2To:1@1.]
	raise:Error
	withExceptionDo:[:anError| 
		self assert: anError  messageText=TerniLapilli invalidBoardStateErrorDescription]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'nt 11/1/2020 18:05:51'!
test09APlayerTriesToMoveATokenFromAnotherPlayer

	| terniLapilli|
	terniLapilli:= TerniLapilli new.
	terniLapilli putXAt:0@0.
	terniLapilli putOAt:2@2.
	terniLapilli putXAt:0@1.
	terniLapilli putOAt:1@0.
	terniLapilli putXAt:2@1.
	terniLapilli putOAt:2@0.
		
	self should:[terniLapilli moveXFrom:2@2To:1@1.]
	raise:Error
	withExceptionDo:[:anError| 
		self assert: anError  messageText=TerniLapilli invalidBoardStateErrorDescription ]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'nt 11/1/2020 18:08:08'!
test10APlayerTriesToMoveFromAnEmptyPosition

	| terniLapilli|
	terniLapilli:= TerniLapilli new.
	terniLapilli putXAt:0@0.
	terniLapilli putOAt:2@2.
	terniLapilli putXAt:0@1.
	terniLapilli putOAt:1@0.
	terniLapilli putXAt:2@1.
	terniLapilli putOAt:2@0.
		
	self should:[terniLapilli moveXFrom:1@1To:1@2.]
	raise:Error
	withExceptionDo:[:anError| 
		self assert: anError  messageText=TerniLapilli invalidBoardStateErrorDescription ]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'nt 11/1/2020 18:15:32'!
test11MakeAMovementToALongerDistance

	| terniLapilli|
	terniLapilli:= TerniLapilli new.
	terniLapilli putXAt:0@0.
	terniLapilli putOAt:2@0.
	terniLapilli putXAt:0@1.
	terniLapilli putOAt:1@0.
	terniLapilli putXAt:2@1.
	terniLapilli putOAt:0@2.
		
	self should:[terniLapilli moveXFrom:0@0To:2@2.]
	raise:Error
	withExceptionDo:[:anError| 
		self assert: anError  messageText=TerniLapilli invalidBoardStateErrorDescription ]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'nt 11/1/2020 19:00:40'!
test12MakeAMovementToAnOccupiedPosition
	| terniLapilli|
	terniLapilli:= TerniLapilli new.
	terniLapilli putXAt:0@0.
	terniLapilli putOAt:2@0.
	terniLapilli putXAt:0@1.
	terniLapilli putOAt:1@0.
	terniLapilli putXAt:2@1.
	terniLapilli putOAt:0@2.
		
	self should:[terniLapilli moveXFrom:0@0To:0@1.]
	raise:Error
	withExceptionDo:[:anError| 
		self assert: anError  messageText=TerniLapilli occupiedPositionErrorDescription ]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'nt 11/1/2020 19:11:42'!
test13MakeAMovementeAfterTheGameIsOverBecauseAPlayerWon
	

	| terniLapilli|
	terniLapilli:= TerniLapilli new.
	terniLapilli putXAt:0@0.
	terniLapilli putOAt:2@2.
	terniLapilli putXAt:0@1.
	terniLapilli putOAt:2@0.
	terniLapilli putXAt:1@2.
	terniLapilli putOAt:2@1.

	self should:[terniLapilli moveXFrom: 1@2 To: 0@2]
	raise:Error
	withExceptionDo:[:anError| 
		self assert: anError  messageText=TerniLapilli gameIsOver]! !


!classDefinition: #MagicSquare category: 'TerniLapilli'!
Object subclass: #MagicSquare
	instanceVariableNames: 'square'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!MagicSquare methodsFor: 'as yet unclassified' stamp: 'nt 11/1/2020 16:46:45'!
checkGameOver:aCollectionOfPositions
	|sum|
	(aCollectionOfPositions size ~=3 ) ifTrue:[^false].
	sum:=0.
	aCollectionOfPositions collect:[:aPosition|sum:=sum+(square at:aPosition)].
	^sum=15! !

!MagicSquare methodsFor: 'as yet unclassified' stamp: 'nt 10/31/2020 20:22:45'!
initialize
	square:=Dictionary new.
	square add:0@0->4.
	square add:1@0->9.
	square add:2@0->2.
	square add:0@1->3.
	square add:0@2->8.
	square add:1@1->5.
	square add:1@2->1.
	square add:2@1->7.
	square add:2@2->6.! !


!classDefinition: #PlayerTurn category: 'TerniLapilli'!
Object subclass: #PlayerTurn
	instanceVariableNames: 'terniLapilliGame'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PlayerTurn methodsFor: 'as yet unclassified' stamp: 'nt 10/31/2020 18:55:13'!
initializeWith:aGame

terniLapilliGame:= aGame ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayerTurn class' category: 'TerniLapilli'!
PlayerTurn class
	instanceVariableNames: ''!


!PlayerTurn class methodsFor: 'as yet unclassified' stamp: 'nt 10/31/2020 19:25:47'!
newWith:aGame
	^self new initializeWith:aGame! !


!classDefinition: #PlayerOTurn category: 'TerniLapilli'!
PlayerTurn subclass: #PlayerOTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PlayerOTurn methodsFor: 'as yet unclassified' stamp: 'nt 10/31/2020 18:44:06'!
isPlayingO
	^true.! !

!PlayerOTurn methodsFor: 'as yet unclassified' stamp: 'nt 10/31/2020 18:44:59'!
isPlayingX
	^false.! !

!PlayerOTurn methodsFor: 'as yet unclassified' stamp: 'nt 11/1/2020 17:19:18'!
moveOFrom: aPoint To: aPoint2 
	terniLapilliGame remove:'O'At:aPoint.
	terniLapilliGame put:'O'At:aPoint2! !

!PlayerOTurn methodsFor: 'as yet unclassified' stamp: 'nt 11/1/2020 17:13:21'!
moveXFrom: aPoint To: aPoint2 
self error: TerniLapilli invalidPlayerErrorDescription! !

!PlayerOTurn methodsFor: 'as yet unclassified' stamp: 'nt 10/31/2020 19:04:56'!
passTurn
	terniLapilliGame playerXTurnStart ! !

!PlayerOTurn methodsFor: 'as yet unclassified' stamp: 'nt 10/31/2020 19:16:17'!
putOAt:aPoint
	terniLapilliGame put: 'O' At:aPoint! !

!PlayerOTurn methodsFor: 'as yet unclassified' stamp: 'nt 10/31/2020 19:09:54'!
putXAt:aPoint
	self error: TerniLapilli invalidPlayerErrorDescription! !


!classDefinition: #PlayerXTurn category: 'TerniLapilli'!
PlayerTurn subclass: #PlayerXTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PlayerXTurn methodsFor: 'as yet unclassified' stamp: 'nt 10/31/2020 18:45:18'!
isPlayingO
	^false.! !

!PlayerXTurn methodsFor: 'as yet unclassified' stamp: 'nt 10/31/2020 18:45:41'!
isPlayingX
	^true.! !

!PlayerXTurn methodsFor: 'as yet unclassified' stamp: 'nt 11/1/2020 17:13:33'!
moveOFrom: aPoint To: aPoint2 
self error: TerniLapilli invalidPlayerErrorDescription! !

!PlayerXTurn methodsFor: 'as yet unclassified' stamp: 'nt 11/1/2020 17:20:59'!
moveXFrom: aPoint To: aPoint2 
terniLapilliGame remove:'X'At:aPoint.
terniLapilliGame put:'X'At:aPoint2! !

!PlayerXTurn methodsFor: 'as yet unclassified' stamp: 'nt 10/31/2020 19:06:00'!
passTurn
	terniLapilliGame playerOTurnStart ! !

!PlayerXTurn methodsFor: 'as yet unclassified' stamp: 'nt 10/31/2020 19:10:53'!
putOAt:aPoint
	self error: TerniLapilli invalidPlayerErrorDescription! !

!PlayerXTurn methodsFor: 'as yet unclassified' stamp: 'nt 10/31/2020 19:17:02'!
putXAt:aPoint
	terniLapilliGame put: 'X' At:aPoint! !


!classDefinition: #TerniLapilli category: 'TerniLapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'board playerTurn magicSquare'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'initialization' stamp: 'nt 10/31/2020 20:34:03'!
initialize
	
	board:= Dictionary  new.
	self playerXTurnStart.
	magicSquare:=MagicSquare new.! !


!TerniLapilli methodsFor: 'Private' stamp: 'nt 10/31/2020 18:28:47'!
amountOfTokenPutedByPlayer:aPlayer

	^ board values occurrencesOf: aPlayer ! !

!TerniLapilli methodsFor: 'Private' stamp: 'nt 11/1/2020 18:39:13'!
distanceEquals1From: aPoint To: aPoint2 
	^(aPoint eightNeighbors includes:aPoint2)! !

!TerniLapilli methodsFor: 'Private' stamp: 'nt 10/31/2020 16:48:55'!
isOccupied:aPosition
^board includesKey:aPosition! !

!TerniLapilli methodsFor: 'Private' stamp: 'nt 10/31/2020 18:59:17'!
playerOTurnStart
playerTurn:=PlayerOTurn newWith:self.
	! !

!TerniLapilli methodsFor: 'Private' stamp: 'nt 10/31/2020 18:58:51'!
playerXTurnStart
playerTurn:=PlayerXTurn newWith:self.
	! !

!TerniLapilli methodsFor: 'Private' stamp: 'nt 11/1/2020 15:43:23'!
put:aPlayerToken  At:aPoint
self validatePosition:aPoint.
self validateAmount:aPlayerToken.
self validateGameOver.
board add:(aPoint->aPlayerToken).
playerTurn passTurn! !

!TerniLapilli methodsFor: 'Private' stamp: 'nt 11/1/2020 17:47:13'!
remove: aPlayer At:aPoint.
self validateBoardState:aPlayer At:aPoint.
board removeKey:aPoint
	! !

!TerniLapilli methodsFor: 'Private' stamp: 'nt 11/1/2020 16:13:35'!
tokensOnBoardFromPlayer: aWinner

	^ (board keys select:[:aPosition|(board at:aPosition )=aWinner])! !

!TerniLapilli methodsFor: 'Private' stamp: 'nt 10/31/2020 18:36:45'!
validateAmount: aPlayer

((self amountOfTokenPutedByPlayer:aPlayer) >2) ifTrue:[self error: TerniLapilli maxAmountOfTokenExedeed ]
	! !

!TerniLapilli methodsFor: 'Private' stamp: 'nt 11/1/2020 18:10:49'!
validateBoardState:aPlayer At:aPoint.
(board size=6) ifFalse:[self error: TerniLapilli invalidBoardStateErrorDescription ].
((board at:aPoint ifAbsent:[self error: TerniLapilli invalidBoardStateErrorDescription])=aPlayer) ifFalse:[self error: TerniLapilli invalidBoardStateErrorDescription]. 	
! !

!TerniLapilli methodsFor: 'Private' stamp: 'nt 11/1/2020 15:45:27'!
validateGameOver

(self isGameWon) ifTrue:[self error: TerniLapilli gameIsOver ]
	! !

!TerniLapilli methodsFor: 'Private' stamp: 'nt 10/31/2020 17:44:39'!
validatePosition:aPosition
(self isOccupied:aPosition)  ifTrue:[self error: TerniLapilli occupiedPositionErrorDescription ].
((aPosition x between:0 and:2) and:(aPosition y between:0 and:2)) ifFalse: [self error: TerniLapilli positionOutsideBoardLimits]! !


!TerniLapilli methodsFor: 'Public' stamp: 'nt 11/1/2020 15:31:55'!
gameWonBy:aWinner

	^ magicSquare checkGameOver:(self tokensOnBoardFromPlayer: aWinner)! !

!TerniLapilli methodsFor: 'Public' stamp: 'nt 11/1/2020 15:34:33'!
isGameWon
^(self gameWonBy:'O') or:( self gameWonBy:'X')! !

!TerniLapilli methodsFor: 'Public' stamp: 'nt 10/31/2020 19:22:33'!
isPlayingO
	^playerTurn isPlayingO ! !

!TerniLapilli methodsFor: 'Public' stamp: 'nt 10/31/2020 19:22:52'!
isPlayingX
	^playerTurn isPlayingX! !

!TerniLapilli methodsFor: 'Public' stamp: 'nt 11/1/2020 18:29:53'!
moveOFrom: aPoint To: aPoint2 
(self distanceEquals1From: aPoint To: aPoint2) ifFalse:[self error: 	TerniLapilli invalidBoardStateErrorDescription ] .
playerTurn moveOFrom: aPoint To: aPoint2.! !

!TerniLapilli methodsFor: 'Public' stamp: 'nt 11/1/2020 18:31:08'!
moveXFrom: aPoint To: aPoint2 
(self distanceEquals1From: aPoint To: aPoint2) ifFalse:[self error: 	TerniLapilli invalidBoardStateErrorDescription ].
playerTurn moveXFrom: aPoint To: aPoint2! !

!TerniLapilli methodsFor: 'Public' stamp: 'nt 10/31/2020 19:19:15'!
putOAt:aPoint
playerTurn putOAt:aPoint! !

!TerniLapilli methodsFor: 'Public' stamp: 'nt 10/31/2020 19:20:06'!
putXAt:aPoint
playerTurn putXAt:aPoint! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: 'TerniLapilli'!
TerniLapilli class
	instanceVariableNames: 'board'!

!TerniLapilli class methodsFor: 'Error' stamp: 'nt 10/31/2020 19:42:51'!
gameIsOver
^'El juego ya terminó'.! !

!TerniLapilli class methodsFor: 'Error' stamp: 'nt 11/1/2020 17:58:20'!
invalidBoardStateErrorDescription
^'Movimiento inválido.'! !

!TerniLapilli class methodsFor: 'Error' stamp: 'nt 10/31/2020 16:14:21'!
invalidPlayerErrorDescription	
^'A player try to make a move in a wrong turn'.! !

!TerniLapilli class methodsFor: 'Error' stamp: 'nt 10/31/2020 18:19:43'!
maxAmountOfTokenExedeed
^'La cantidad máxima de fichas por jugador es 3'.! !

!TerniLapilli class methodsFor: 'Error' stamp: 'nt 10/31/2020 16:22:58'!
occupiedPositionErrorDescription
	^'La posición ya está ocupada'! !

!TerniLapilli class methodsFor: 'Error' stamp: 'nt 10/31/2020 17:37:45'!
positionOutsideBoardLimits
	
	^'La posición está fuera de los límites del tablero'! !
