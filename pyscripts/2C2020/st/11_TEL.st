!classDefinition: #TerniLapilliTest category: 'TerniLapilli'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/29/2020 18:15:43'!
test01NewTerniLapilliIsNotOver
	
	|terni|
	terni := TerniLapilli new.
	
	self assert: false equals: terni isOver! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/29/2020 18:16:24'!
test02InNewTerniLapilliPlayerXHasntWon
	
	|terni|
	terni := TerniLapilli new.
	
	self assert: false equals: terni hasPlayerXWon! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/29/2020 18:16:43'!
test03InNewTerniLapilliPlayerOHasntWon
	
	|terni|
	terni := TerniLapilli new.
	
	self assert: false equals: terni hasPlayerOWon! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/29/2020 19:48:57'!
test04InNewTerniLapilliPlayerXStartsPlayingAndTheBoardIsEmpty
	
	|terni|
	terni := TerniLapilli new.
	
	self assert: terni isPlayingX.
	self assert: terni isPlayingO not.
	self assert: 0 equals: terni piecesInPlay.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/31/2020 21:22:17'!
test05AfterPlayerXTurnIsPlayerOTurn
	
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'centro'.
	
	self assert: terni isPlayingX not.
	self assert: terni isPlayingO! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/31/2020 21:22:17'!
test06XCanPutAPieceInXTurn
	
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'centro'.
	
	self assert: 1 equals: terni piecesInPlay.
	self assert: (terni hasAnXPieceIn: 'centro').! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/31/2020 21:22:17'!
test07OCanPutAPieceInOTurn
	
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'centro'.
	terni placePieceIn: 'arribaCentro'.
	
	self assert: 2 equals: terni piecesInPlay.
	self assert: (terni hasAnOPieceIn: 'arribaCentro').! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/29/2020 21:22:44'!
test08AnEmptyBoardDoesNotHaveAnXPieceInTheCenter
	
	|terni|
	terni := TerniLapilli new.
		
	self assert: false equals: (terni hasAnXPieceIn: 'centro').
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/29/2020 21:26:28'!
test09AnEmptyBoardDoesNotHaveAnOPieceInTheCenter
	
	|terni|
	terni := TerniLapilli new.
		
	self assert: false equals: (terni hasAnOPieceIn: 'centro').
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/31/2020 21:22:17'!
test10ABoardWithAPieceInArribaCentroDoesNotHaveAnXOrAnOPieceInCentro
	
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'arribaCentro'.	
	self assert: false equals: (terni hasAnOPieceIn: 'centro').
	self assert: false equals: (terni hasAnXPieceIn: 'centro').	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/31/2020 21:22:17'!
test11TwoPiecesCanNotBePlacedInTheSamePositionAfterThatOCanPlayInADifferentPosition
	
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'arribaCentro'.	
	
	self should: [terni placePieceIn: 'arribaCentro'.	]
		raise: Error - MessageNotUnderstood
		withMessageText: TerniLapilli canNotPutAPieceInAnOccupiedPositionErrorDescription.
	
	self assert: terni isPlayingO.
	
	terni placePieceIn: 'centro'.	
	
	self assert: (terni hasAnOPieceIn: 'centro').	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/31/2020 21:22:17'!
test12TerniLapilliAssertsWithAnInvalidPosition
	
	|terni|
	terni := TerniLapilli new.
	
	self should: [terni placePieceIn: 'arribaDerechaCentro'.	]
		raise: Error - MessageNotUnderstood
		withMessageText: TerniLapilli invalidPositionErrorDescription.
	
	self assert: terni isPlayingX.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/31/2020 22:47:58'!
test13NonOfThePlayersCanPutMoreThanTheMaxAmountOfPiecesPerPlayer
	
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'arribaIzquierda'.	
	terni placePieceIn: 'arribaCentro'.	
	terni placePieceIn: 'arribaDerecha'.	
	terni placePieceIn: 'izquierda'.	
	terni placePieceIn: 'centro'.	
	terni placePieceIn: 'derecha'.	
	
	self should: [terni placePieceIn: 'abajoIzquierda'.	]
		raise: Error - MessageNotUnderstood
		withMessageText: TerniLapilli noMorePiecesAvailableErrorDescription.
	
	self assert: terni isPlayingX.	
	terni movePieceFrom: 'centro' to: 'abajoCentro'.
	
	self should: [terni placePieceIn: 'abajoDerecha'.	]
		raise: Error - MessageNotUnderstood
		withMessageText: TerniLapilli noMorePiecesAvailableErrorDescription.
	
	self assert: terni isPlayingO.		! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/31/2020 21:50:55'!
test14CannotMoveAPieceFromAnEmptyPosition
	
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'arribaIzquierda'.	
	terni placePieceIn: 'arribaCentro'.	
	terni placePieceIn: 'arribaDerecha'.	
	terni placePieceIn: 'izquierda'.	
	terni placePieceIn: 'centro'.	
	terni placePieceIn: 'derecha'.	
	
	self should: [terni movePieceFrom: 'abajoIzquierda' to: 'abajoDerecha'.]
		raise: Error - MessageNotUnderstood
		withMessageText: TerniLapilli canNotMoveAPieceFromAnEmptyPositionErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/31/2020 21:51:09'!
test15CannotMoveAPieceIntoATakenPosition
	
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'arribaIzquierda'.	
	terni placePieceIn: 'arribaCentro'.	
	terni placePieceIn: 'arribaDerecha'.	
	terni placePieceIn: 'izquierda'.	
	terni placePieceIn: 'centro'.	
	terni placePieceIn: 'derecha'.	
	
	self should: [terni movePieceFrom: 'arribaIzquierda' to: 'izquierda'.]
		raise: Error - MessageNotUnderstood
		withMessageText: TerniLapilli canNotPutAPieceInAnOccupiedPositionErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/31/2020 22:01:04'!
test16CannotMoveAPieceBeforeAllPiecesAreInGame
	
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'arribaIzquierda'.	
	terni placePieceIn: 'arribaCentro'.	
	terni placePieceIn: 'arribaDerecha'.	
	terni placePieceIn: 'izquierda'.	
	
	self should: [terni movePieceFrom: 'arribaIzquierda' to: 'izquierda'.]
		raise: Error - MessageNotUnderstood
		withMessageText: TerniLapilli canNotMoveAPieceBeforeAllPiecesAreInGameErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/31/2020 22:18:33'!
test17XCannotMoveAnOPiece
	
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'arribaIzquierda'.	
	terni placePieceIn: 'arribaCentro'.	
	terni placePieceIn: 'arribaDerecha'.	
	terni placePieceIn: 'izquierda'.	
	terni placePieceIn: 'centro'.	
	terni placePieceIn: 'derecha'.	
	
	self should: [terni movePieceFrom: 'arribaCentro' to: 'abajoCentro'.]
		raise: Error - MessageNotUnderstood
		withMessageText: TerniLapilli canNotMoveAPieceFromAnotherPlayerErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/31/2020 22:41:53'!
test18CannotMoveAPieceJumpingPositions
	
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'arribaIzquierda'.	
	terni placePieceIn: 'arribaCentro'.	
	terni placePieceIn: 'arribaDerecha'.	
	terni placePieceIn: 'izquierda'.	
	terni placePieceIn: 'centro'.	
	terni placePieceIn: 'derecha'.	
	
	self should: [terni movePieceFrom: 'arribaIzquierda' to: 'abajoCentro'.]
		raise: Error - MessageNotUnderstood
		withMessageText: TerniLapilli canNotMoveAPieceJumpingPositionsErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PJ 10/31/2020 22:51:21'!
test19CannotMoveAPieceIntoTheSamePosition
	
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'arribaIzquierda'.	
	terni placePieceIn: 'arribaCentro'.	
	terni placePieceIn: 'arribaDerecha'.	
	terni placePieceIn: 'izquierda'.	
	terni placePieceIn: 'centro'.	
	terni placePieceIn: 'derecha'.	
	
	self should: [terni movePieceFrom: 'arribaIzquierda' to: 'arribaIzquierda'.]
		raise: Error - MessageNotUnderstood
		withMessageText: TerniLapilli canNotMoveAPieceIntoTheSamePositionErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PGTA 11/2/2020 00:08:42'!
test20XCanWinUsingUpperRowBeforeMovingPhaseTurns
	
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'arribaIzquierda'.	
	terni placePieceIn: 'centro'.	
	terni placePieceIn: 'arribaCentro'.	
	terni placePieceIn: 'derecha'.	
	terni placePieceIn: 'arribaDerecha'.	
	
	self assert: terni hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PGTA 11/1/2020 22:11:12'!
test21XCanWinUsingMiddleColumnBeforeMovingPhaseTurns
	
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'arribaCentro'.	
	terni placePieceIn: 'arribaIzquierda'.	
	terni placePieceIn: 'centro'.	
	terni placePieceIn: 'izquierda'.	
	terni placePieceIn: 'abajoCentro'.	
	
	self assert: terni hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PGTA 11/2/2020 00:09:18'!
test22XCanWinUsingMiddleRowBeforeMovingPhaseTurns
	
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'izquierda'.	
	terni placePieceIn: 'arribaCentro'.	
	terni placePieceIn: 'centro'.	
	terni placePieceIn: 'arribaIzquierda'.	
	terni placePieceIn: 'derecha'.	
	
	self assert: terni hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PGTA 11/2/2020 00:09:28'!
test23OCanWinUsingDiagonalsBeforeMovingPhaseTurns
	
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'arribaCentro'.	
	terni placePieceIn: 'centro'.	
	terni placePieceIn: 'arribaDerecha'.	
	terni placePieceIn: 'arribaIzquierda'.	
	terni placePieceIn: 'abajoIzquierda'.	
	terni placePieceIn: 'abajoDerecha'.	
	
	self assert: false equals: terni hasPlayerXWon.
	self assert: terni hasPlayerOWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PGTA 11/2/2020 01:03:18'!
test24XCannotMoveAfterOWins
	
"	O X X
	-  O  -
	X O  -   "
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'arribaCentro'.	
	terni placePieceIn: 'centro'.	
	terni placePieceIn: 'arribaDerecha'.	
	terni placePieceIn: 'arribaIzquierda'.	
	terni placePieceIn: 'abajoIzquierda'.	
	terni placePieceIn: 'abajoCentro'.	
	
	self assert: false equals: terni hasPlayerXWon.
	self assert: false equals: terni hasPlayerOWon.
	
	terni movePieceFrom: 'abajoIzquierda' to: 'izquierda'.
	terni movePieceFrom: 'abajoCentro' to: 'abajoDerecha'.
	
	self assert: false equals: terni hasPlayerXWon.
	self assert: terni hasPlayerOWon.
	
	self should: [terni movePieceFrom: 'izquierda' to: 'abajoIzquierda'.]
		raise: Error - MessageNotUnderstood
		withMessageText: TerniLapilli cannotPerformActionAfterGameOverErrorDescription.
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'PGTA 11/2/2020 01:19:14'!
test25OCannotPlacePieceAfterXWin
	
"	X X X
	-  O  -
	-  O  -   "
	|terni|
	terni := TerniLapilli new.
	terni placePieceIn: 'arribaCentro'.	
	terni placePieceIn: 'centro'.	
	terni placePieceIn: 'arribaDerecha'.	
	terni placePieceIn: 'abajoCentro'.	
	terni placePieceIn: 'arribaIzquierda'.	
	
	self assert: terni hasPlayerXWon.
	self assert: false equals: terni hasPlayerOWon.
	
	self should: [terni placePieceIn: 'abajoIzquierda'.	]
		raise: Error - MessageNotUnderstood
		withMessageText: TerniLapilli cannotPerformActionAfterGameOverErrorDescription.
	! !


!classDefinition: #PosicionesTerniLapilli category: 'TerniLapilli'!
Object subclass: #PosicionesTerniLapilli
	instanceVariableNames: 'valor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PosicionesTerniLapilli methodsFor: 'initialization' stamp: 'PJ 10/31/2020 18:29:17'!
initialize
	valor := ''! !


!PosicionesTerniLapilli methodsFor: 'coordination' stamp: 'PJ 10/31/2020 23:03:54'!
isNeighbourOf: aPosition 
	self subclassResponsibility ! !


!PosicionesTerniLapilli methodsFor: 'accessing' stamp: 'PJ 10/31/2020 17:40:30'!
hasAnO
	^valor = 'O'! !

!PosicionesTerniLapilli methodsFor: 'accessing' stamp: 'PJ 10/31/2020 17:40:23'!
hasAnX
	^valor = 'X'! !

!PosicionesTerniLapilli methodsFor: 'accessing' stamp: 'PJ 10/31/2020 17:39:56'!
isEmpty
	^valor = ''! !


!PosicionesTerniLapilli methodsFor: 'game actions' stamp: 'PJ 10/31/2020 21:17:18'!
freePosition
	valor := ''! !

!PosicionesTerniLapilli methodsFor: 'game actions' stamp: 'PGTA 11/2/2020 15:17:04'!
storeAnO
	valor := 'O'! !

!PosicionesTerniLapilli methodsFor: 'game actions' stamp: 'PGTA 11/2/2020 15:16:59'!
storeAnX
	valor := 'X'! !


!PosicionesTerniLapilli methodsFor: 'private management' stamp: 'PJ 10/31/2020 18:10:39'!
canHandle: aPositionIdentifier
	self subclassResponsibility ! !


!classDefinition: #AbajoCentro category: 'TerniLapilli'!
PosicionesTerniLapilli subclass: #AbajoCentro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!AbajoCentro methodsFor: 'coordination' stamp: 'PJ 10/31/2020 22:59:23'!
isNeighbourOf: aPosition 
	^(aPosition isKindOf: AbajoIzquierda ) or: (aPosition isKindOf: AbajoDerecha ) or: (aPosition isKindOf: Centro).! !


!AbajoCentro methodsFor: 'private management' stamp: 'PJ 10/31/2020 18:11:25'!
canHandle: aPositionIdentifier
	
	^aPositionIdentifier = 'abajoCentro'! !


!classDefinition: #AbajoDerecha category: 'TerniLapilli'!
PosicionesTerniLapilli subclass: #AbajoDerecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!AbajoDerecha methodsFor: 'coordination' stamp: 'PJ 10/31/2020 22:59:59'!
isNeighbourOf: aPosition 
	^(aPosition isKindOf: AbajoCentro ) or: (aPosition isKindOf: Derecha ) or: (aPosition isKindOf: Centro).! !


!AbajoDerecha methodsFor: 'private management' stamp: 'PJ 10/31/2020 18:11:44'!
canHandle: aPositionIdentifier
	
	^aPositionIdentifier = 'abajoDerecha'! !


!classDefinition: #AbajoIzquierda category: 'TerniLapilli'!
PosicionesTerniLapilli subclass: #AbajoIzquierda
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!AbajoIzquierda methodsFor: 'coordination' stamp: 'PJ 10/31/2020 23:00:33'!
isNeighbourOf: aPosition 
	^(aPosition isKindOf: AbajoCentro) or: (aPosition isKindOf: Izquierda) or: (aPosition isKindOf: Centro).! !


!AbajoIzquierda methodsFor: 'private management' stamp: 'PJ 10/31/2020 18:12:00'!
canHandle: aPositionIdentifier
	
	^aPositionIdentifier = 'abajoIzquierda'! !


!classDefinition: #ArribaCentro category: 'TerniLapilli'!
PosicionesTerniLapilli subclass: #ArribaCentro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!ArribaCentro methodsFor: 'coordination' stamp: 'PJ 10/31/2020 23:01:11'!
isNeighbourOf: aPosition 
	^(aPosition isKindOf: ArribaIzquierda ) or: (aPosition isKindOf: ArribaDerecha) or: (aPosition isKindOf: Centro).! !


!ArribaCentro methodsFor: 'private management' stamp: 'PJ 10/31/2020 18:12:24'!
canHandle: aPositionIdentifier
	
	^aPositionIdentifier = 'arribaCentro'! !


!classDefinition: #ArribaDerecha category: 'TerniLapilli'!
PosicionesTerniLapilli subclass: #ArribaDerecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!ArribaDerecha methodsFor: 'coordination' stamp: 'PJ 10/31/2020 23:01:50'!
isNeighbourOf: aPosition 
	^(aPosition isKindOf: ArribaCentro) or: (aPosition isKindOf: Derecha) or: (aPosition isKindOf: Centro).! !


!ArribaDerecha methodsFor: 'private management' stamp: 'PJ 10/31/2020 18:12:36'!
canHandle: aPositionIdentifier
	
	^aPositionIdentifier = 'arribaDerecha'! !


!classDefinition: #ArribaIzquierda category: 'TerniLapilli'!
PosicionesTerniLapilli subclass: #ArribaIzquierda
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!ArribaIzquierda methodsFor: 'coordination' stamp: 'PJ 10/31/2020 22:45:07'!
isNeighbourOf: aPosition 
	^(aPosition isKindOf: ArribaCentro) or: (aPosition isKindOf: Izquierda) or: (aPosition isKindOf: Centro).! !


!ArribaIzquierda methodsFor: 'private management' stamp: 'PJ 10/31/2020 18:12:47'!
canHandle: aPositionIdentifier
	
	^aPositionIdentifier = 'arribaIzquierda'! !


!classDefinition: #Centro category: 'TerniLapilli'!
PosicionesTerniLapilli subclass: #Centro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!Centro methodsFor: 'coordination' stamp: 'PJ 10/31/2020 22:49:24'!
isNeighbourOf: aPosition 
	^true.! !


!Centro methodsFor: 'private management' stamp: 'PJ 10/31/2020 18:13:24'!
canHandle: aPositionIdentifier
	
	^aPositionIdentifier = 'centro'! !


!classDefinition: #Derecha category: 'TerniLapilli'!
PosicionesTerniLapilli subclass: #Derecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!Derecha methodsFor: 'coordination' stamp: 'PJ 10/31/2020 23:02:44'!
isNeighbourOf: aPosition 
	^(aPosition isKindOf: ArribaDerecha ) or: (aPosition isKindOf: AbajoDerecha) or: (aPosition isKindOf: Centro).! !


!Derecha methodsFor: 'private management' stamp: 'PJ 10/31/2020 18:13:15'!
canHandle: aPositionIdentifier
	
	^aPositionIdentifier = 'derecha'! !


!classDefinition: #Izquierda category: 'TerniLapilli'!
PosicionesTerniLapilli subclass: #Izquierda
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!Izquierda methodsFor: 'coordination' stamp: 'PJ 10/31/2020 23:03:15'!
isNeighbourOf: aPosition 
	^(aPosition isKindOf: ArribaIzquierda) or: (aPosition isKindOf: AbajoIzquierda) or: (aPosition isKindOf: Centro).! !


!Izquierda methodsFor: 'private management' stamp: 'PJ 10/31/2020 18:13:37'!
canHandle: aPositionIdentifier
	
	^aPositionIdentifier = 'izquierda'! !


!classDefinition: #TerniLapilli category: 'TerniLapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'isXTurn piecesInPlay board'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'game actions' stamp: 'PGTA 11/2/2020 01:32:20'!
movePieceFrom: aTakenPosition to: anEmptyPosition 

	|boardTakenPosition boardEmptyPosition|
	
	self isOver ifTrue:[^self error: self class cannotPerformActionAfterGameOverErrorDescription].
	
	self areAllPiecesInGame ifFalse: [^self error: self class canNotMoveAPieceBeforeAllPiecesAreInGameErrorDescription].
	(aTakenPosition = anEmptyPosition ) ifTrue: [^self error: self class canNotMoveAPieceIntoTheSamePositionErrorDescription].
	
	boardTakenPosition := self getBoardPositionFor: aTakenPosition.
	(self isPositionEmpty: boardTakenPosition ) ifTrue: [^self error: self class canNotMoveAPieceFromAnEmptyPositionErrorDescription].
	
	boardEmptyPosition := self getBoardPositionFor: anEmptyPosition.
	(self isPositionTaken: boardEmptyPosition) ifTrue: [^self error: self class canNotPutAPieceInAnOccupiedPositionErrorDescription].
	
	(self isPositionTakenByAnotherPlayer: boardTakenPosition) ifTrue: [^self error: self class canNotMoveAPieceFromAnotherPlayerErrorDescription].
	
	(boardTakenPosition isNeighbourOf: boardEmptyPosition) ifTrue: [
		boardTakenPosition freePosition.
		self placePieceInBoard: boardEmptyPosition.
	
		self alternateTurn.
	]
	ifFalse: [^self error: self class canNotMoveAPieceJumpingPositionsErrorDescription].! !

!TerniLapilli methodsFor: 'game actions' stamp: 'PGTA 11/2/2020 01:32:46'!
placePieceIn: aPositionIdentifier 
	
	|boardPosition|
	
	self isOver ifTrue:[^self error: self class cannotPerformActionAfterGameOverErrorDescription].
	
	self playerHasAvailablePiecesToPlay ifFalse: [^self error: self class noMorePiecesAvailableErrorDescription].
	
	boardPosition := self getBoardPositionFor: aPositionIdentifier.
	(self isPositionTaken: boardPosition) ifTrue: [^self error: self class canNotPutAPieceInAnOccupiedPositionErrorDescription].
	 
	self placePieceInBoard: boardPosition.
	self alternateTurn.
	piecesInPlay := piecesInPlay + 1.! !


!TerniLapilli methodsFor: 'private management' stamp: 'PJ 10/31/2020 20:03:09'!
alternateTurn
	isXTurn := isXTurn not.! !

!TerniLapilli methodsFor: 'private management' stamp: 'PJ 10/31/2020 22:07:51'!
areAllPiecesInGame
	^self playerHasAvailablePiecesToPlay not! !

!TerniLapilli methodsFor: 'private management' stamp: 'PJ 10/31/2020 20:26:58'!
getBoardPositionFor: aPositionIdentifier 
	
	^board  detect: [:aBoardPosition | aBoardPosition canHandle: aPositionIdentifier]
		ifNone: [^self error: self class invalidPositionErrorDescription].! !

!TerniLapilli methodsFor: 'private management' stamp: 'PJ 10/31/2020 21:55:01'!
isPositionEmpty: aBoardPosition
	^aBoardPosition isEmpty! !

!TerniLapilli methodsFor: 'private management' stamp: 'PJ 10/31/2020 20:00:23'!
isPositionTaken: aBoardPosition 
	^aBoardPosition isEmpty not! !

!TerniLapilli methodsFor: 'private management' stamp: 'PJ 10/31/2020 22:29:14'!
isPositionTakenByAnotherPlayer: aBoardPosition 
	^(self isPlayingX and: [aBoardPosition hasAnO]) or: [self isPlayingO and: [aBoardPosition hasAnX]].! !

!TerniLapilli methodsFor: 'private management' stamp: 'PGTA 11/2/2020 15:15:44'!
placePieceInBoard: aBoardPosition.
	isXTurn ifTrue: [aBoardPosition storeAnX] ifFalse: [aBoardPosition storeAnO]! !

!TerniLapilli methodsFor: 'private management' stamp: 'PJ 10/31/2020 21:07:01'!
playerHasAvailablePiecesToPlay
	^piecesInPlay < 6! !


!TerniLapilli methodsFor: 'game testing' stamp: 'PJ 10/31/2020 18:38:56'!
hasAnOPieceIn: aPositionIdentifier
	|boardPosition|
	boardPosition := self getBoardPositionFor: aPositionIdentifier.
	^boardPosition hasAnO! !

!TerniLapilli methodsFor: 'game testing' stamp: 'PJ 10/31/2020 18:39:11'!
hasAnXPieceIn: aPositionIdentifier
	|boardPosition|
	boardPosition := self getBoardPositionFor: aPositionIdentifier.
	^boardPosition hasAnX! !

!TerniLapilli methodsFor: 'game testing' stamp: 'PGTA 11/2/2020 14:54:44'!
hasPlayerOWon
	^self playerHasAWinningLine: [:position | self hasAnOPieceIn: position].! !

!TerniLapilli methodsFor: 'game testing' stamp: 'PGTA 11/2/2020 14:54:29'!
hasPlayerXWon
	^self playerHasAWinningLine: [:position | self hasAnXPieceIn: position].! !

!TerniLapilli methodsFor: 'game testing' stamp: 'PJ 10/31/2020 18:24:56'!
initialize
	isXTurn := true.
	piecesInPlay := 0.
	board := OrderedCollection new.
	board add: ArribaIzquierda new.
	board add: ArribaCentro new.
	board add: ArribaDerecha new.
	board add: Izquierda new.
	board add: Centro new.
	board add: Derecha new.
	board add: AbajoIzquierda new.
	board add: AbajoCentro new.
	board add: AbajoDerecha new.! !

!TerniLapilli methodsFor: 'game testing' stamp: 'PGTA 11/2/2020 01:32:30'!
isOver
	^(self hasPlayerXWon or: self hasPlayerOWon)! !

!TerniLapilli methodsFor: 'game testing' stamp: 'PJ 10/29/2020 18:55:10'!
isPlayingO
	^isXTurn not! !

!TerniLapilli methodsFor: 'game testing' stamp: 'PJ 10/29/2020 18:55:20'!
isPlayingX
	^isXTurn! !

!TerniLapilli methodsFor: 'game testing' stamp: 'PJ 10/29/2020 20:09:40'!
piecesInPlay
	^piecesInPlay! !

!TerniLapilli methodsFor: 'game testing' stamp: 'PGTA 11/2/2020 14:51:23'!
playerHasAWinningLine: aPlayerPositionCheck
	 "rows"
	^(	((aPlayerPositionCheck value: 'arribaIzquierda') and: (aPlayerPositionCheck value: 'arribaCentro') and: (aPlayerPositionCheck value: 'arribaDerecha'))
	or: 	((aPlayerPositionCheck value: 'izquierda') and: (aPlayerPositionCheck value: 'centro') and: (aPlayerPositionCheck value: 'derecha'))
	or: 	((aPlayerPositionCheck value: 'abajoIzquierda') and: (aPlayerPositionCheck value: 'abajoCentro') and: (aPlayerPositionCheck value: 'abajoDerecha'))
	)"columns"
	or:( 	((aPlayerPositionCheck value: 'arribaIzquierda') and: (aPlayerPositionCheck value: 'izquierda') and: (aPlayerPositionCheck value: 'abajoIzquierda'))
	or: 	((aPlayerPositionCheck value: 'arribaCentro') and: (aPlayerPositionCheck value: 'centro') and: (aPlayerPositionCheck value: 'abajoCentro'))
	or: 	((aPlayerPositionCheck value: 'arribaDerecha') and: (aPlayerPositionCheck value: 'derecha') and: (aPlayerPositionCheck value: 'abajoDerecha'))
	)"diagonals"
	or:( 	((aPlayerPositionCheck value: 'arribaIzquierda') and: (aPlayerPositionCheck value: 'centro') and: (aPlayerPositionCheck value: 'abajoDerecha'))
	or: 	((aPlayerPositionCheck value: 'arribaDerecha') and: (aPlayerPositionCheck value: 'centro') and: (aPlayerPositionCheck value: 'abajoIzquierda'))
	)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: 'TerniLapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'exception descriptions' stamp: 'PJ 10/31/2020 22:01:59'!
canNotMoveAPieceBeforeAllPiecesAreInGameErrorDescription
	^'cannot Move A Piece Before All Pieces Are In Game'! !

!TerniLapilli class methodsFor: 'exception descriptions' stamp: 'PJ 10/31/2020 21:52:07'!
canNotMoveAPieceFromAnEmptyPositionErrorDescription
	^'cannot Move A Piece From An Empty Position'! !

!TerniLapilli class methodsFor: 'exception descriptions' stamp: 'PJ 10/31/2020 22:20:03'!
canNotMoveAPieceFromAnotherPlayerErrorDescription
	^'cannot Move A Piece From Another Player'! !

!TerniLapilli class methodsFor: 'exception descriptions' stamp: 'PJ 10/31/2020 22:52:20'!
canNotMoveAPieceIntoTheSamePositionErrorDescription
	^'cannot Move A Piece Into The Same Position' ! !

!TerniLapilli class methodsFor: 'exception descriptions' stamp: 'PJ 10/31/2020 22:33:44'!
canNotMoveAPieceJumpingPositionsErrorDescription
	^'cannot Move A Piece Jumping Positions'! !

!TerniLapilli class methodsFor: 'exception descriptions' stamp: 'PJ 10/31/2020 20:07:17'!
canNotPutAPieceInAnOccupiedPositionErrorDescription
	^'cannot Put A Piece In An Occupied Position'.! !

!TerniLapilli class methodsFor: 'exception descriptions' stamp: 'PJ 10/31/2020 20:24:17'!
invalidPositionErrorDescription
	^'Invalid Position'! !

!TerniLapilli class methodsFor: 'exception descriptions' stamp: 'PJ 10/31/2020 20:53:50'!
noMorePiecesAvailableErrorDescription
	^'No More Pieces Available'! !


!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'PGTA 11/2/2020 01:02:48'!
cannotPerformActionAfterGameOverErrorDescription
	^'cannot Perform Action After Game Over'! !
