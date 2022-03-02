!classDefinition: #TerniLapilliTest category: 'TerniLapilli'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 10/29/2020 17:37:44'!
test01NewGameIsNotOver

	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	self deny: terniLapilli isOver.	
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 10/29/2020 18:12:50'!
test02XStartsPlaying

	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	self deny: terniLapilli isPlayingO.
	self assert: terniLapilli isPlayingX.	
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 10/29/2020 18:54:46'!
test03OPlaysAfterX

	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	terniLapilli putXat: 1@2.
	
	self deny: terniLapilli isPlayingX.
	self assert: terniLapilli isPlayingO.	
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 10/29/2020 18:54:41'!
test04XPlaysAfterO

	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	terniLapilli putXat: 1@2.
	terniLapilli putOat: 1@3.
	
	self deny: terniLapilli isPlayingO.
	self assert: terniLapilli isPlayingX.	
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 10/29/2020 18:54:30'!
test05CantPlayOnOtherPlayersTurn

	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	self
		should: [ terniLapilli putOat: 1@2]
		raise: Error
		withMessageText: TerniLapilli incorrectPlayerTurnErrorDescription.
		
	terniLapilli putXat: 1@2.
	
	self
		should: [ terniLapilli putXat: 1@3]
		raise: Error
		withMessageText: TerniLapilli incorrectPlayerTurnErrorDescription.
		
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 10/29/2020 18:54:17'!
test06XCanPlaceCorrectly

	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	terniLapilli putXat: 1@1.
	
	self assert: (terniLapilli atPosition: 1@1)	 equals: #X.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 10/29/2020 18:54:08'!
test07OCanPlaceCorrectly

	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	terniLapilli putXat: 1@1.
	terniLapilli putOat: 2@2.
	
	self assert: (terniLapilli atPosition: 2@2)	 equals: #O.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 10/29/2020 19:09:52'!
test08OCantPlaceOnOccupiedPostition

	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	terniLapilli putXat: 1@1.
	
	self 
		should: [terniLapilli putOat: 1@1]
		raise: Error
		withMessageText: TerniLapilli invalidPlacePositionErrorDescription.
		
	self assert: (terniLapilli atPosition: 1@1) equals: #X.	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 10/29/2020 19:10:46'!
test09XCantPlaceOnOccupiedPostition

	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	terniLapilli putXat: 1@1.
	terniLapilli putOat: 2@2.
	self 
		should: [terniLapilli putXat: 2@2]
		raise: Error
		withMessageText: TerniLapilli invalidPlacePositionErrorDescription.
		
	self assert: (terniLapilli atPosition: 2@2) equals: #O.	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 10/29/2020 19:47:36'!
test10XCantPlaceOutOfBounds

	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	self 
		should: [terniLapilli putXat: 4@4]
		raise: Error
		withMessageText: TerniLapilli outOfBoundsPlacePositionErrorDescription.
			! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 10/29/2020 19:48:34'!
test11OCantPlaceOutOfBounds

	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	terniLapilli putXat: 1@1.
	
	self 
		should: [terniLapilli putOat: 4@4]
		raise: Error
		withMessageText: TerniLapilli outOfBoundsPlacePositionErrorDescription.
			! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 10/29/2020 19:49:33'!
test12CantPlaceMoreThanSixPieces

	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	terniLapilli putXat: 1@1; putOat: 1@2; putXat: 1@3; putOat: 2@1; putXat: 2@2; putOat: 2@3.
	
	self 
		should: [terniLapilli putXat: 3@1]
		raise: Error
		withMessageText: TerniLapilli maxAmountOfPiecesOnBoardErrorDescription.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 18:36:44'!
test13XCanMovePiece

	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	terniLapilli putXat: 1@1; putOat: 1@2; putXat: 1@3; putOat: 2@1; putXat: 2@2; putOat: 2@3.
	
	terniLapilli moveXFrom: 2@2 to: 3@2.
	
	self assert: (terniLapilli atPosition: 3@2) equals: #X.
	self assert: (terniLapilli atPosition: 2@2) equals: #E.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 20:03:23'!
test14XCantMovePieceOutOfBounds

	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	terniLapilli putXat: 1@1; putOat: 1@2; putXat: 1@3; putOat: 2@1; putXat: 2@2; putOat: 2@3.
	
	self
	should: [terniLapilli moveXFrom: 2@2 to: 4@2]
	raise: Error
	withMessageText: TerniLapilli outOfBoundsPositionErrorDescription.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 20:07:40'!
test15OCantMovePieceOutOfBounds

	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	terniLapilli putXat: 1@1; putOat: 1@2; putXat: 1@3; putOat: 2@1; putXat: 2@2; putOat: 2@3.
	
	self
	should: [terniLapilli moveOFrom: 2@2 to: 4@2]
	raise: Error
	withMessageText: TerniLapilli outOfBoundsPositionErrorDescription.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 19:56:54'!
test16XCantMoveOnInvalidDiagonal
	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	terniLapilli putXat: 1@2; putOat: 3@1; putXat: 1@3; putOat: 2@1; putXat: 2@2; putOat: 3@3.
	
	self
	should: [terniLapilli moveXFrom: 1@2 to: 2@3]
	raise: Error
	withMessageText: TerniLapilli invalidMoveDestinationErrorDescription.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 20:07:34'!
test17OCantMoveOnInvalidDiagonal
	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	terniLapilli putXat: 1@2; putOat: 3@1; putXat: 1@3; putOat: 2@1; putXat: 2@2; putOat: 3@3.
	
	self
	should: [terniLapilli moveOFrom: 2@1 to: 3@2]
	raise: Error
	withMessageText: TerniLapilli invalidMoveDestinationErrorDescription.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 20:10:28'!
test18CantMoveAfterGameIsOver
	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	terniLapilli putXat: 1@1; putOat: 2@1; putXat: 1@2; putOat: 2@2; putXat: 2@3; putOat: 3@1.
	terniLapilli moveXFrom: 2@3 to: 1@3.
	self
	should: [terniLapilli moveOFrom: 2@1 to: 3@1]
	raise: Error
	withMessageText: TerniLapilli invalidActionErrorDescription.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 20:18:36'!
test19CantMoveOnOtherPlayersTurn
	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	terniLapilli putXat: 1@1; putOat: 2@1; putXat: 1@2; putOat: 2@2; putXat: 2@3; putOat: 3@1.
	self
	should: [terniLapilli moveOFrom: 2@2 to: 3@2]
	raise: Error
	withMessageText: TerniLapilli incorrectPlayerTurnErrorDescription.
	
	terniLapilli moveXFrom: 2@3 to: 3@3.
	
	self
	should: [terniLapilli moveXFrom: 3@3 to: 2@3]
	raise: Error
	withMessageText: TerniLapilli incorrectPlayerTurnErrorDescription.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 20:24:29'!
test20XCanWinOnFifthMove
	
	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	terniLapilli putXat: 1@1; putOat: 2@1; putXat: 1@2; putOat: 2@2; putXat: 1@3.
	
	self assert: (terniLapilli hasWon: #X).! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 20:25:41'!
test21OCanWinOnSixthMove
	
	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	terniLapilli putXat: 1@1; putOat: 2@1; putXat: 1@2; putOat: 2@2; putXat: 3@3; putOat: 2@3.
	
	self assert: (terniLapilli hasWon: #O).! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 20:27:41'!
test22OCantPlaceAfterGameIsOver
	
	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	terniLapilli putXat: 1@1; putOat: 2@1; putXat: 1@2; putOat: 2@2; putXat: 1@3.
	
	self
	should: [terniLapilli putOat: 3@3]
	raise: Error
	withMessageText: TerniLapilli invalidActionErrorDescription.! !


!classDefinition: #TerniLapilli category: 'TerniLapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'playerTurn board gameStage piecesPlaced'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'testing' stamp: 'AM 10/29/2020 20:50:17'!
hasWon: aPlayerSymbol

	| hasWon |
	
	hasWon := false.
	
	"Horizontales"
	
	1 to: 3 do: [:row | hasWon := hasWon or: 
									[aPlayerSymbol = (board at: row@1) 
											and: [(board at: row@1) = (board at: row@2) 
												and: [(board at: row@2) = (board at: row@3)]]]].
	
	"Verticales"
	
	1 to: 3 do: [:column | hasWon := hasWon or: 
									[aPlayerSymbol = (board at: 1@column)
											and: [(board at: 1@column) = (board at: 2@column) 
												and: [(board at: 2@column) = (board at: 3@column)]]]].
	
	"Diagonal1"
	
	hasWon := hasWon or: 
					[aPlayerSymbol = (board at: 1@1) 
							and: [(board at: 1@1) = (board at: 2@2)
								and: [(board at: 2@2) = (board at: 3@3)]]].
						
	"Diagonal2"
	
	hasWon := hasWon or: 
					[aPlayerSymbol = (board at: 1@3) 
							and: [(board at: 1@3) = (board at: 2@2)
								and: [(board at: 2@2) = (board at: 3@1)]]].
						
	^hasWon.! !

!TerniLapilli methodsFor: 'testing' stamp: 'AM 10/29/2020 20:53:42'!
isOver
	
	^(self hasWon: #X) or: [self hasWon: #O].! !

!TerniLapilli methodsFor: 'testing' stamp: 'AM 11/1/2020 18:34:00'!
isPlayingO
	
	^(playerTurn class= O).! !

!TerniLapilli methodsFor: 'testing' stamp: 'AM 11/1/2020 18:34:08'!
isPlayingX
	
	^(playerTurn class = X).! !

!TerniLapilli methodsFor: 'testing' stamp: 'AM 10/29/2020 20:17:33'!
isTied

	| sum |
	
	sum := 0.
	
	board do: [:piece | ((piece = #X) or: [piece = #O]) ifTrue: [sum := sum + 1]].
	
	^(6 = sum).! !


!TerniLapilli methodsFor: 'initialization' stamp: 'AM 11/1/2020 18:19:37'!
initialize
	
	board := Array2D newSize: 3@3.
	board fillWithArrayOfArrays: #(#(#E #E #E) #(#E #E #E) #(#E #E #E)).
	gameStage := PiecePlacingStage for: self.
	playerTurn := X for: self.
	piecesPlaced := 0.! !


!TerniLapilli methodsFor: 'error signals' stamp: 'AM 10/29/2020 18:36:36'!
signalIncorrectPlayerTurn

	^self error: self class incorrectPlayerTurnErrorDescription.! !

!TerniLapilli methodsFor: 'error signals' stamp: 'AM 11/1/2020 19:51:28'!
signalInvalidAction

	^self error: self class invalidActionErrorDescription.! !

!TerniLapilli methodsFor: 'error signals' stamp: 'AM 10/29/2020 21:17:03'!
signalInvalidMoveDestination

	^self error: self class invalidMoveDestinationErrorDescription.! !

!TerniLapilli methodsFor: 'error signals' stamp: 'AM 10/29/2020 21:15:11'!
signalInvalidMoveOrigin

	^self error: self class invalidMoveOriginErrorDescription.! !

!TerniLapilli methodsFor: 'error signals' stamp: 'AM 10/29/2020 19:05:43'!
signalInvalidPlacePosition

	^self error: self class invalidPlacePositionErrorDescription.! !

!TerniLapilli methodsFor: 'error signals' stamp: 'AM 10/29/2020 19:38:34'!
signalMaxAmountOfPieces

 	^self error: self class maxAmountOfPiecesOnBoardErrorDescription.! !

!TerniLapilli methodsFor: 'error signals' stamp: 'AM 11/1/2020 18:44:41'!
signalOutOfBoundsPosition

	^self error: self class outOfBoundsPlacePositionErrorDescription.! !


!TerniLapilli methodsFor: 'assertions' stamp: 'AM 11/1/2020 18:44:41'!
assertBoardAt: aPoint has: aPlayerSymbol ifNone: failureBlock

	(((aPoint x) between: 1 and: 3) and: [(aPoint y) between: 1 and: 3]) ifFalse:[self signalOutOfBoundsPosition].
	(board at: aPoint) = aPlayerSymbol ifFalse: failureBlock.! !

!TerniLapilli methodsFor: 'assertions' stamp: 'AM 11/1/2020 20:06:07'!
assertInRange: anOriginPoint and: aDestinationPoint

	(((anOriginPoint x) between: 1 and: 3) and: [(anOriginPoint y) between: 1 and: 3]) ifFalse: [self signalOutOfBoundsPosition].
	(((aDestinationPoint x) between: 1 and: 3) and: [(aDestinationPoint y) between: 1 and: 3]) ifFalse: [self signalOutOfBoundsPosition].! !

!TerniLapilli methodsFor: 'assertions' stamp: 'AM 11/1/2020 18:44:41'!
assertPointIsInRange: aPoint

	(((aPoint x) between: 1 and: 3) and: [(aPoint y) between: 1 and: 3]) ifFalse:[self signalOutOfBoundsPosition].
	! !

!TerniLapilli methodsFor: 'assertions' stamp: 'AM 11/1/2020 19:48:17'!
assertValidMove: anOriginPoint and: aDestinationPoint

	| isDiagonal centerAndCornerPoints|
	
	centerAndCornerPoints := OrderedCollection with: 1@1 with: 1@3 with: 2@2 with: 3@1 with: 3@3.
		
	((((anOriginPoint x - aDestinationPoint x) abs) < 2) and: [((anOriginPoint y- aDestinationPoint y) abs) < 2]) ifFalse: [self signalInvalidMoveDestination ].
	
	isDiagonal := (((anOriginPoint x - aDestinationPoint x) abs) + ((anOriginPoint y- aDestinationPoint y) abs)) = 2.
	
	isDiagonal ifTrue: [centerAndCornerPoints detect: [:point | aDestinationPoint = point] ifNone: [self signalInvalidMoveDestination]].! !

!TerniLapilli methodsFor: 'assertions' stamp: 'AM 11/1/2020 18:44:41'!
assertValidPlacePostition: aPoint

	(((aPoint x) between: 1 and: 3) and: [(aPoint y) between: 1 and: 3]) ifFalse:[self signalOutOfBoundsPosition].
	(board at: aPoint) = #E ifFalse: [self signalInvalidPlacePosition].! !


!TerniLapilli methodsFor: 'actions' stamp: 'AM 11/1/2020 19:58:58'!
moveOFrom: anOriginPoint to: aDestinationPoint
	
	gameStage moveO: anOriginPoint to: aDestinationPoint.
	
	! !

!TerniLapilli methodsFor: 'actions' stamp: 'AM 11/1/2020 19:58:51'!
moveXFrom: anOriginPoint to: aDestinationPoint
	
	gameStage moveX: anOriginPoint to: aDestinationPoint.
	
	! !

!TerniLapilli methodsFor: 'actions' stamp: 'AM 11/1/2020 18:17:06'!
putOat: aPoint 
	
	gameStage putOat: aPoint.! !

!TerniLapilli methodsFor: 'actions' stamp: 'AM 11/1/2020 18:10:23'!
putXat: aPoint 
	
	gameStage putXat: aPoint.! !


!TerniLapilli methodsFor: 'accessing' stamp: 'AM 10/29/2020 18:58:08'!
atPosition: aPoint 
	
	^board at: aPoint.! !


!TerniLapilli methodsFor: 'actions private' stamp: 'AM 11/1/2020 18:28:26'!
changeStageIfGameOverReached

	(self isOver) ifTrue: [gameStage := GameOverStage for: self]! !

!TerniLapilli methodsFor: 'actions private' stamp: 'AM 11/1/2020 18:24:43'!
changeStateIfMaxPiecesReached
	
	(piecesPlaced = 6) ifTrue: [gameStage := PieceMovingStage for: self]! !

!TerniLapilli methodsFor: 'actions private' stamp: 'AM 11/1/2020 19:28:47'!
moveOAssertingTurn: anOriginPoint to: aDestinationPoint

	playerTurn moveO: anOriginPoint to: aDestinationPoint.! !

!TerniLapilli methodsFor: 'actions private' stamp: 'AM 11/1/2020 19:25:41'!
moveXAssertingTurn: anOriginPoint to: aDestinationPoint

	playerTurn moveX: anOriginPoint to: aDestinationPoint.! !

!TerniLapilli methodsFor: 'actions private' stamp: 'AM 11/1/2020 18:22:14'!
place: aPiece at: aPoint
	
	piecesPlaced := piecesPlaced + 1.
	board at: aPoint put: aPiece.! !

!TerniLapilli methodsFor: 'actions private' stamp: 'AM 11/1/2020 18:17:49'!
putOatAssertingTurn: aPoint

	playerTurn putOat: aPoint.! !

!TerniLapilli methodsFor: 'actions private' stamp: 'AM 11/1/2020 18:12:59'!
putXatAssertingTurn: aPoint

	playerTurn putXat: aPoint.! !

!TerniLapilli methodsFor: 'actions private' stamp: 'AM 11/1/2020 18:32:38'!
setPlayerOTurn

	playerTurn := O for: self.! !

!TerniLapilli methodsFor: 'actions private' stamp: 'AM 11/1/2020 18:32:32'!
setPlayerXTurn

	playerTurn := X for: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: 'TerniLapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error messages' stamp: 'AM 10/29/2020 18:32:14'!
incorrectPlayerTurnErrorDescription
	
	^'Its not players turn' ! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'AM 11/1/2020 19:52:21'!
invalidActionErrorDescription

	^'Cant perform this action at this stage'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'AM 11/1/2020 19:56:20'!
invalidMoveDestinationErrorDescription

	^'Move destination is invalid'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'AM 11/1/2020 17:40:11'!
invalidMoveErrorDescription
	
	^'Move is out of bounds or invalid'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'AM 10/29/2020 21:16:22'!
invalidMoveOriginErrorDescription

	^'Trying to move an invalid piece'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'AM 10/29/2020 19:02:26'!
invalidPlacePositionErrorDescription
	
	^'Postition already occupied'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'AM 10/29/2020 19:29:43'!
maxAmountOfPiecesOnBoardErrorDescription
	
	^'No more pieces can be place, a piece should be moved'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'AM 10/29/2020 19:13:49'!
outOfBoundsPlacePositionErrorDescription
	
	^'Position is out of bounds'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'AM 11/1/2020 18:43:26'!
outOfBoundsPositionErrorDescription
	
	^'Position is out of bounds'! !


!classDefinition: #TerniLapilliGameStage category: 'TerniLapilli'!
Object subclass: #TerniLapilliGameStage
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliGameStage methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 17:47:51'!
initializeFor: aTerniLapilli

	terniLapilli := aTerniLapilli.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliGameStage class' category: 'TerniLapilli'!
TerniLapilliGameStage class
	instanceVariableNames: ''!

!TerniLapilliGameStage class methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 17:47:12'!
for: aTerniLapilli

	^self new initializeFor: aTerniLapilli.! !


!classDefinition: #GameOverStage category: 'TerniLapilli'!
TerniLapilliGameStage subclass: #GameOverStage
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!GameOverStage methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 19:52:43'!
moveO: anOriginPoint to: aDestinationPoint

	^terniLapilli signalInvalidAction.! !

!GameOverStage methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 19:52:51'!
moveX: anOriginPoint to: aDestinationPoint

	^terniLapilli signalInvalidAction.! !

!GameOverStage methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 20:29:53'!
putOat: aPoint

	terniLapilli signalInvalidAction.! !

!GameOverStage methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 20:28:35'!
putXat: aPoint

	terniLapilli signalInvalidAction.! !


!classDefinition: #PieceMovingStage category: 'TerniLapilli'!
TerniLapilliGameStage subclass: #PieceMovingStage
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PieceMovingStage methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 19:33:39'!
moveO: anOriginPoint to: aDestinationPoint
	
	terniLapilli assertInRange: anOriginPoint and: aDestinationPoint.
	terniLapilli assertValidMove: anOriginPoint and: aDestinationPoint.
	terniLapilli assertBoardAt: anOriginPoint has: #O ifNone: [self signalInvalidMoveOrigin].
	terniLapilli assertBoardAt: aDestinationPoint has: #E ifNone: [self signalInvalidMoveDestination].
	terniLapilli moveOAssertingTurn: anOriginPoint to: 	aDestinationPoint.
	
	
! !

!PieceMovingStage methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 19:33:22'!
moveX: anOriginPoint to: aDestinationPoint
	
	terniLapilli assertInRange: anOriginPoint and: aDestinationPoint.
	terniLapilli assertValidMove: anOriginPoint and: aDestinationPoint. 
	terniLapilli assertBoardAt: anOriginPoint has: #X ifNone: [self signalInvalidMoveOrigin].
	terniLapilli assertBoardAt: aDestinationPoint has: #E ifNone: [self signalInvalidMoveDestination].
	terniLapilli moveXAssertingTurn: anOriginPoint to: 	aDestinationPoint.
	
	
! !

!PieceMovingStage methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 17:53:02'!
putOat: aPoint

	terniLapilli signalMaxAmountOfPieces.! !

!PieceMovingStage methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 17:52:55'!
putXat: aPoint

	terniLapilli signalMaxAmountOfPieces.! !


!classDefinition: #PiecePlacingStage category: 'TerniLapilli'!
TerniLapilliGameStage subclass: #PiecePlacingStage
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PiecePlacingStage methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 19:51:47'!
moveO: anOriginPoint to: aDestinationPoint

	^terniLapilli signalInvalidAction.! !

!PiecePlacingStage methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 19:51:43'!
moveX: anOriginPoint to: aDestinationPoint

	^terniLapilli signalInvalidAction.! !

!PiecePlacingStage methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 18:18:07'!
putOat: aPoint

	terniLapilli assertBoardAt: aPoint has: #E ifNone: [terniLapilli signalInvalidPlacePosition].
	terniLapilli putOatAssertingTurn: aPoint.
	! !

!PiecePlacingStage methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 18:16:13'!
putXat: aPoint

	terniLapilli assertBoardAt: aPoint has: #E ifNone: [terniLapilli signalInvalidPlacePosition].
	terniLapilli putXatAssertingTurn: aPoint.
	! !


!classDefinition: #TerniLapilliPlayer category: 'TerniLapilli'!
Object subclass: #TerniLapilliPlayer
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliPlayer methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 18:04:36'!
initializeFor: aTerniLapilli

	terniLapilli := aTerniLapilli.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliPlayer class' category: 'TerniLapilli'!
TerniLapilliPlayer class
	instanceVariableNames: ''!

!TerniLapilliPlayer class methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 18:04:09'!
for: aTerniLapilli

	^self new initializeFor: aTerniLapilli.! !


!classDefinition: #O category: 'TerniLapilli'!
TerniLapilliPlayer subclass: #O
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!O methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 20:20:41'!
moveO: anOriginPoint to: aDestinationPoint

		terniLapilli place: #E at: anOriginPoint.
		terniLapilli place: #O at: aDestinationPoint.
		terniLapilli setPlayerXTurn.
		terniLapilli changeStageIfGameOverReached.! !

!O methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 19:27:32'!
moveX: anOriginPoint to: aDestinationPoint

	^terniLapilli signalIncorrectPlayerTurn.! !

!O methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 18:32:54'!
putOat: aPoint
	
	terniLapilli place: #O at: aPoint.
	terniLapilli changeStageIfGameOverReached.
	terniLapilli changeStateIfMaxPiecesReached.
	terniLapilli setPlayerXTurn.! !

!O methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 18:05:20'!
putXat: aPoint

	^terniLapilli signalIncorrectPlayerTurn.! !


!classDefinition: #X category: 'TerniLapilli'!
TerniLapilliPlayer subclass: #X
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!X methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 19:29:20'!
moveO: anOriginPoint to: aDestinationPoint
	
	^terniLapilli signalIncorrectPlayerTurn.! !

!X methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 20:20:34'!
moveX: anOriginPoint to: aDestinationPoint
	
	terniLapilli place: #E at: anOriginPoint .
	terniLapilli place: #X at: aDestinationPoint.
	terniLapilli setPlayerOTurn.
	terniLapilli changeStageIfGameOverReached.! !

!X methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 18:15:23'!
putOat: aPoint

	^terniLapilli signalIncorrectPlayerTurn ! !

!X methodsFor: 'as yet unclassified' stamp: 'AM 11/1/2020 18:33:06'!
putXat: aPoint
	
	terniLapilli place: #X at: aPoint. 
	terniLapilli changeStageIfGameOverReached.
	terniLapilli setPlayerOTurn.! !
