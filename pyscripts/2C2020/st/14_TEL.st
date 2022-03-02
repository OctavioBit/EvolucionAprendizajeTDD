!classDefinition: #TerniLapilliTest category: #TerniLapilliGame!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliGame'!

!TerniLapilliTest methodsFor: 'test' stamp: 'FS 11/2/2020 14:11:32'!
test01AssertPlayerXStartsPlayingInNewGame
	
	| aTerniLapilliGame |
	
	aTerniLapilliGame _ TerniLapilli new.
	self assertThatGameContinuesAndIsXTurn: aTerniLapilliGame! !

!TerniLapilliTest methodsFor: 'test' stamp: 'FS 11/2/2020 14:11:53'!
test02AssertPlayerOTurnIsAfterPlayerX
	
	| aTerniLapilliGame |
	
	aTerniLapilliGame _ TerniLapilli new.
	aTerniLapilliGame putXAt: 1@1.
	
	self assertThatGameContinuesAndIsOTurn: aTerniLapilliGame .
	self assert: (aTerniLapilliGame isAnXPlayerPosition: 1@1).
	self deny: (aTerniLapilliGame isAnOPlayerPosition: 1@1).
 ! !

!TerniLapilliTest methodsFor: 'test' stamp: 'FS 11/2/2020 14:12:08'!
test03AssertPlayerXTurnIsAfterPlayerO
	
	| aTerniLapilliGame |
	
	aTerniLapilliGame _ TerniLapilli new.
	aTerniLapilliGame putXAt: 1@1.
	aTerniLapilliGame putOAt: 2@2.
	
	self assertThatGameContinuesAndIsXTurn: aTerniLapilliGame .
	self assert: (aTerniLapilliGame isAnXPlayerPosition: 1@1).
	self assert: (aTerniLapilliGame isAnOPlayerPosition: 2@2).
! !

!TerniLapilliTest methodsFor: 'test' stamp: 'FS 11/2/2020 14:16:50'!
test05AssertPlayerWinsWhenPutsLastChipFormingAThreeLinedPattern
	
	| aTerniLapilliGame |
	
	aTerniLapilliGame _ TerniLapilli new.
	aTerniLapilliGame putXAt: 1@1.
	aTerniLapilliGame putOAt: 1@2.
	aTerniLapilliGame putXAt: 3@1.
	aTerniLapilliGame putOAt: 2@2.
	aTerniLapilliGame putXAt: 3@3.
	aTerniLapilliGame putOAt: 3@2.

	self deny: aTerniLapilliGame playerXHasWon.
	self assert: aTerniLapilliGame playerOHasWon.
	self assert: aTerniLapilliGame isOver.
! !

!TerniLapilliTest methodsFor: 'test' stamp: 'FS 11/2/2020 14:17:22'!
test06AssertPlayerXMovesAChipCorrectly
	
	| aTerniLapilliGame |
	
	aTerniLapilliGame _ TerniLapilli new.
	aTerniLapilliGame putXAt: 1@1.
	aTerniLapilliGame putOAt: 3@3.
	aTerniLapilliGame putXAt: 1@2.
	aTerniLapilliGame putOAt: 3@2.
	aTerniLapilliGame putXAt: 2@2.
	aTerniLapilliGame putOAt: 2@3.
	
	aTerniLapilliGame movePlayerXPositionFrom: 2@2 to: 2@1. 

	self deny: (aTerniLapilliGame isAnXPlayerPosition: 2@2).	
	self assert: (aTerniLapilliGame isAnXPlayerPosition: 2@1).
	
	self assertThatGameContinuesAndIsOTurn: aTerniLapilliGame .
	self deny: aTerniLapilliGame playerXHasWon.
	self deny: aTerniLapilliGame playerOHasWon.

	
	
	
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'FS 11/2/2020 14:20:01'!
test07AssertPlayerWinsAfterMovingAChipFormingAThreeLinedPatern
	
	| aTerniLapilliGame |
	
	aTerniLapilliGame _ TerniLapilli new.
	aTerniLapilliGame putXAt: 1@1.
	aTerniLapilliGame putOAt: 2@3.
	aTerniLapilliGame putXAt: 1@2.
	aTerniLapilliGame putOAt: 3@2.
	aTerniLapilliGame putXAt: 2@2.
	aTerniLapilliGame putOAt: 3@1.
	
	aTerniLapilliGame movePlayerXPositionFrom: 2@2 to: 1@3. 

	self deny: (aTerniLapilliGame isAnXPlayerPosition: 2@2).	
	self assert: (aTerniLapilliGame isAnXPlayerPosition: 1@3).
	self deny: aTerniLapilliGame isPlayingO.
	self deny: aTerniLapilliGame isPlayingX.

	self assert: aTerniLapilliGame playerXHasWon .
	self deny: aTerniLapilliGame playerOHasWon .
	self assert: aTerniLapilliGame isOver.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'FS 11/2/2020 13:55:33'!
test08CanNotPutAChipAtInvalidTurn
	
	| aTerniLapilliGame |
	
	aTerniLapilliGame _ TerniLapilli new.
	aTerniLapilliGame putXAt: 1@1.
	
	self 
		should: [ aTerniLapilliGame putXAt: 2@1. ]
		raise: Error
		withMessageText: TerniLapilli invalidTurnErrorDescription.
		
		
	self deny: (aTerniLapilliGame isAnXPlayerPosition: 2@1).	
	self assert: (aTerniLapilliGame isAnXPlayerPosition: 1@1).
	self assert: aTerniLapilliGame isPlayingO.
	self deny: aTerniLapilliGame isPlayingX.
	self deny: aTerniLapilliGame playerXHasWon.
	self deny: aTerniLapilliGame playerOHasWon.
	self deny: aTerniLapilliGame isOver.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'FS 11/2/2020 13:53:57'!
test09CanNotPutAChipInOccupiedPosition
	
	| aTerniLapilliGame |
	
	aTerniLapilliGame _ TerniLapilli new.
	aTerniLapilliGame putXAt: 1@1.
	
	self 
		should: [ aTerniLapilliGame putOAt: 1@1. ]
		raise: Error
		withMessageText: TerniLapilli occupiedPositionErrorDescription.
		
	self assert: (aTerniLapilliGame isAnXPlayerPosition: 1@1).	
	self deny: (aTerniLapilliGame isAnOPlayerPosition: 1@1).
	self assert: aTerniLapilliGame isPlayingO.
	self deny: aTerniLapilliGame isPlayingX.
	self deny: aTerniLapilliGame playerXHasWon.
	self deny: aTerniLapilliGame playerOHasWon.
	self deny: aTerniLapilliGame isOver.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'FS 11/2/2020 13:55:33'!
test10CanNotMoveAChipAtInvalidTurn
	
	| aTerniLapilliGame |
	
	aTerniLapilliGame _ TerniLapilli new.
	aTerniLapilliGame putXAt: 1@1.
	aTerniLapilliGame putOAt: 3@3.
	aTerniLapilliGame putXAt: 2@1.
	aTerniLapilliGame putOAt: 3@2.
	aTerniLapilliGame putXAt: 1@2.
	aTerniLapilliGame putOAt: 2@2.
	
	self 
		should: [ aTerniLapilliGame movePlayerOPositionFrom: 3@3 to: 2@3.  ]
		raise: Error
		withMessageText: TerniLapilli invalidTurnErrorDescription.
		
		
	self deny: (aTerniLapilliGame isAnOPlayerPosition: 2@3).	
	self assert: (aTerniLapilliGame isAnOPlayerPosition: 3@3).
	self deny: aTerniLapilliGame isPlayingO.
	self assert: aTerniLapilliGame isPlayingX.
	self deny: aTerniLapilliGame playerXHasWon.
	self deny: aTerniLapilliGame playerOHasWon.
	self deny: aTerniLapilliGame isOver.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'FS 11/2/2020 13:55:08'!
test11CanNotMoveAChipFromInvalidSourcePosition
	
	| aTerniLapilliGame |
	
	aTerniLapilliGame _ TerniLapilli new.
	aTerniLapilliGame putXAt: 1@1.
	aTerniLapilliGame putOAt: 3@3.
	aTerniLapilliGame putXAt: 2@1.
	aTerniLapilliGame putOAt: 3@2.
	aTerniLapilliGame putXAt: 1@2.
	aTerniLapilliGame putOAt: 2@2.
	
	self 
		should: [ aTerniLapilliGame movePlayerXPositionFrom: 3@3 to: 2@3.  ]
		raise: Error
		withMessageText: TerniLapilli invalidSourcePositionToMove.
		
			
	self assert: (aTerniLapilliGame isAnOPlayerPosition: 3@3).
	self deny: aTerniLapilliGame isPlayingO.
	self assert: aTerniLapilliGame isPlayingX.
	self deny: aTerniLapilliGame playerXHasWon.
	self deny: aTerniLapilliGame playerOHasWon.
	self deny: aTerniLapilliGame isOver.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'FS 11/2/2020 13:53:57'!
test12CanNotMoveAChipToAnOccupiedPosition
	
	| aTerniLapilliGame |
	
	aTerniLapilliGame _ TerniLapilli new.
	aTerniLapilliGame putXAt: 1@1.
	aTerniLapilliGame putOAt: 3@3.
	aTerniLapilliGame putXAt: 2@1.
	aTerniLapilliGame putOAt: 3@2.
	aTerniLapilliGame putXAt: 1@2.
	aTerniLapilliGame putOAt: 2@2.

	self 
		should: [ aTerniLapilliGame movePlayerXPositionFrom: 1@1 to: 2@2.  ]
		raise: Error
		withMessageText: TerniLapilli occupiedPositionErrorDescription.
		
			
	self assert: (aTerniLapilliGame isAnOPlayerPosition: 3@3).
	self deny: aTerniLapilliGame isPlayingO.
	self assert: aTerniLapilliGame isPlayingX.
	self deny: aTerniLapilliGame playerXHasWon.
	self deny: aTerniLapilliGame playerOHasWon.
	self deny: aTerniLapilliGame isOver.
	
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'FS 11/2/2020 13:53:57'!
test13CanNotMoveChipsBeforeAllChipsOnBoard
	
	| aTerniLapilliGame |
	
	aTerniLapilliGame _ TerniLapilli new.
	aTerniLapilliGame putXAt: 1@1.
	aTerniLapilliGame putOAt: 1@2.
	
	self 
		should: [ aTerniLapilliGame movePlayerXPositionFrom: 1@1 to: 2@2.  ]
		raise: Error
		withMessageText: TerniLapilli cantMoveBeforePuttingAllChipsOnBoardErrorDescription.
		
			
	self assert: (aTerniLapilliGame isAnXPlayerPosition: 1@1).
	self deny: aTerniLapilliGame isPlayingO.
	self assert: aTerniLapilliGame isPlayingX.
	self deny: aTerniLapilliGame playerXHasWon.
	self deny: aTerniLapilliGame playerOHasWon.
	self deny: aTerniLapilliGame isOver.
	
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'FS 11/2/2020 13:53:57'!
test14CanNotMoveChipIfMovementIsTooLong
	
	| aTerniLapilliGame |
	
	aTerniLapilliGame _ TerniLapilli new.
	aTerniLapilliGame putXAt: 1@1.
	aTerniLapilliGame putOAt: 3@3.
	aTerniLapilliGame putXAt: 2@1.
	aTerniLapilliGame putOAt: 3@2.
	aTerniLapilliGame putXAt: 1@2.
	aTerniLapilliGame putOAt: 2@2.
	
	self 
		should: [ aTerniLapilliGame movePlayerXPositionFrom: 1@1 to: 3@1.  ]
		raise: Error
		withMessageText: TerniLapilli invalidMovementErrorDescription .
		
			
	self assert: (aTerniLapilliGame isAnXPlayerPosition: 1@1).
	self deny: (aTerniLapilliGame isAnXPlayerPosition: 3@1).

	self deny: aTerniLapilliGame isPlayingO.
	self assert: aTerniLapilliGame isPlayingX.
	self deny: aTerniLapilliGame playerXHasWon.
	self deny: aTerniLapilliGame playerOHasWon.
	self deny: aTerniLapilliGame isOver.
	
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'FS 11/2/2020 13:53:57'!
test15CanNotMoveChipIfMovementIsFakeDiagonal
	
	| aTerniLapilliGame |
	
	aTerniLapilliGame _ TerniLapilli new.
	aTerniLapilliGame putXAt: 2@1.
	aTerniLapilliGame putOAt: 3@3.
	aTerniLapilliGame putXAt: 2@2.
	aTerniLapilliGame putOAt: 3@2.
	aTerniLapilliGame putXAt: 1@3.
	aTerniLapilliGame putOAt: 1@1.
	
	self 
		should: [ aTerniLapilliGame movePlayerXPositionFrom: 2@1 to: 1@2.  ]
		raise: Error
		withMessageText: TerniLapilli invalidMovementErrorDescription .
		
			
	self assert: (aTerniLapilliGame isAnXPlayerPosition: 2@1).
	self deny: (aTerniLapilliGame isAnXPlayerPosition: 1@2).

	self deny: aTerniLapilliGame isPlayingO.
	self assert: aTerniLapilliGame isPlayingX.
	self deny: aTerniLapilliGame playerXHasWon.
	self deny: aTerniLapilliGame playerOHasWon.
	self deny: aTerniLapilliGame isOver.
	
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'FS 11/2/2020 14:18:38'!
test16CanNotPutChipsOutsideTheBoard
	
	| aTerniLapilliGame |
	
	aTerniLapilliGame _ TerniLapilli new.
	
	self 
		should: [ aTerniLapilliGame putXAt: 0@0.  ]
		raise: Error
		withMessageText: TerniLapilli invalidBoardPosition .
		
			
	self deny: (aTerniLapilliGame isAnXPlayerPosition: 0@0).
	self assert: aTerniLapilliGame isPlayingX.
	self deny: aTerniLapilliGame playerXHasWon.
	self deny: aTerniLapilliGame playerOHasWon.
	self deny: aTerniLapilliGame isOver.
	
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'FS 11/2/2020 13:53:57'!
test17CanNotMoveChipsAfterGameIsOver
	
	| aTerniLapilliGame |
	
	aTerniLapilliGame _ TerniLapilli new.
	aTerniLapilliGame putXAt: 2@2.
	aTerniLapilliGame putOAt: 1@1.
	aTerniLapilliGame putXAt: 2@3.
	aTerniLapilliGame putOAt: 1@2.
	aTerniLapilliGame putXAt: 3@3.
	aTerniLapilliGame putOAt: 1@3.
	
	self assert: aTerniLapilliGame playerOHasWon.
	self deny: aTerniLapilliGame playerXHasWon.
	self assert: aTerniLapilliGame isOver.
	
	self 
		should: [ aTerniLapilliGame movePlayerXPositionFrom: 2@2 to: 2@1.  ]
		raise: Error
		withMessageText: TerniLapilli gameAlreadyOverErrorDescription.
		
	self deny: (aTerniLapilliGame isAnXPlayerPosition: 2@1).! !

!TerniLapilliTest methodsFor: 'test' stamp: 'HG 11/2/2020 10:52:44'!
test18CanNotPutChipsAfterGameIsOver
	
	| aTerniLapilliGame |
	
	aTerniLapilliGame _ TerniLapilli new.
	aTerniLapilliGame putXAt: 1@1.
	aTerniLapilliGame putOAt: 3@3.
	aTerniLapilliGame putXAt: 1@2.
	aTerniLapilliGame putOAt: 3@2.
	aTerniLapilliGame putXAt: 2@1.
	aTerniLapilliGame putOAt: 2@3.
	
	self 
		should: [ aTerniLapilliGame putXAt: 2@2  ]
		raise: Error
		withMessageText: TerniLapilli allChipsAlreadyOnTheBoardErrorDescription.
		
! !


!TerniLapilliTest methodsFor: 'assertions' stamp: 'FS 11/2/2020 14:10:34'!
assertThatGameContinuesAndIsOTurn: aTerniLapilliGame

	self assert: aTerniLapilliGame isPlayingO. 
	self deny: aTerniLapilliGame isPlayingX.
	self deny: aTerniLapilliGame isOver! !

!TerniLapilliTest methodsFor: 'assertions' stamp: 'FS 11/2/2020 14:09:03'!
assertThatGameContinuesAndIsXTurn: aTerniLapilliGame

	self assert: aTerniLapilliGame isPlayingX. 
	self deny: aTerniLapilliGame isPlayingO.
	self deny: aTerniLapilliGame isOver! !


!classDefinition: #TerniLapilli category: #TerniLapilliGame!
Object subclass: #TerniLapilli
	instanceVariableNames: 'xPlayerPositions oPlayerPositions turnState gameplayState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliGame'!

!TerniLapilli methodsFor: 'testing -- private' stamp: 'HG 11/2/2020 10:58:29'!
allChipsOnBoard
	^(self allChipsOnBoardFromPlayer: xPlayerPositions) 
		and: (self allChipsOnBoardFromPlayer: oPlayerPositions).! !

!TerniLapilli methodsFor: 'testing -- private' stamp: 'HG 11/2/2020 10:58:04'!
allChipsOnBoardFromPlayer: aPlayerPositionList
	^aPlayerPositionList size = 3! !

!TerniLapilli methodsFor: 'testing -- private' stamp: 'HG 11/2/2020 11:00:10'!
checkConditionsToMoveForPlayerOFrom: aSourceBoardPosition to: aDestinationBoardPosition
	
	(self isAnOPlayerPosition: aSourceBoardPosition)
		ifFalse: [ self signalInvalidSourcePosition. ].
		
	(self isValidPlayerMovementFrom: aSourceBoardPosition to: aDestinationBoardPosition )
		ifFalse:[ self signalInvalidMovement. ]! !

!TerniLapilli methodsFor: 'testing -- private' stamp: 'HG 11/2/2020 11:00:10'!
checkConditionsToMoveForPlayerXFrom: aSourceBoardPosition to: aDestinationBoardPosition
	
	(self isAnXPlayerPosition: aSourceBoardPosition)
		ifFalse: [ self signalInvalidSourcePosition. ].
		
	(self isValidPlayerMovementFrom: aSourceBoardPosition to: aDestinationBoardPosition )
		ifFalse:[ self signalInvalidMovement. ]! !

!TerniLapilli methodsFor: 'testing -- private' stamp: 'HG 11/2/2020 11:00:42'!
isCenterPosition: aSourceBoardPosition

	^ aSourceBoardPosition = (2@2)! !

!TerniLapilli methodsFor: 'testing -- private' stamp: 'HG 11/2/2020 11:01:53'!
isValidPlayerMovementFrom: aSourceBoardPosition to: aDestinationBoardPosition 
	((self isCenterPosition: aSourceBoardPosition) or: (self isCenterPosition: aDestinationBoardPosition)) 
			ifTrue:[ ^aSourceBoardPosition eightNeighbors includes: aDestinationBoardPosition ].
							
	^aSourceBoardPosition fourNeighbors includes: aDestinationBoardPosition.
					! !

!TerniLapilli methodsFor: 'testing -- private' stamp: 'HG 11/2/2020 11:05:25'!
occupiedBoardPositionCheck: aBoardPosition
	^ (self isAnOccupiedPosition: aBoardPosition)
		ifTrue: [ self signalOccupiedPosition. ]! !

!TerniLapilli methodsFor: 'testing -- private' stamp: 'HG 11/1/2020 20:57:39'!
playerOWinsByDiagonal
	^self playerOWinsByRightDiagonal or: self playerOWinsByLeftDiagonal.! !

!TerniLapilli methodsFor: 'testing -- private' stamp: 'HG 11/1/2020 20:59:39'!
playerOWinsByHorizontalRow
	| oWins boardRowIndexs |
	oWins _ false.
	boardRowIndexs _ (1 to: 3).
	boardRowIndexs do: [:aRowIndex | (self playerWinsByRowIndex: aRowIndex withPositions: oPlayerPositions ) ifTrue: [ oWins _ true. ]].
	^oWins.! !

!TerniLapilli methodsFor: 'testing -- private' stamp: 'FS 11/2/2020 13:52:45'!
playerOWinsByLeftDiagonal

	^ ((oPlayerPositions intersection: self rightBoardDiagonal) size) =3! !

!TerniLapilli methodsFor: 'testing -- private' stamp: 'FS 11/2/2020 13:52:56'!
playerOWinsByRightDiagonal

	^ ((oPlayerPositions intersection: self leftBoardDiagonal) size) =3! !

!TerniLapilli methodsFor: 'testing -- private' stamp: 'HG 11/1/2020 21:00:56'!
playerOWinsByVerticalColumn
	
	| oWins boardColumnIndexs |
	oWins _ false.
	boardColumnIndexs _ (1 to: 3).
	boardColumnIndexs do: [:aColumnIndex | (self playerWinsByColumnIndex: aColumnIndex withPositions: oPlayerPositions) ifTrue: [ oWins _ true. ]].
	^oWins.! !

!TerniLapilli methodsFor: 'testing -- private' stamp: 'HG 11/1/2020 21:00:29'!
playerWinsByColumnIndex: aColumnIndex withPositions: aPositionList
	^(aPositionList intersection: (self getColumn: aColumnIndex)) size = 3.! !

!TerniLapilli methodsFor: 'testing -- private' stamp: 'HG 11/1/2020 20:59:03'!
playerWinsByRowIndex: aRowIndex withPositions: aPositionList
	^(aPositionList intersection: (self getRow: aRowIndex)) size = 3.! !

!TerniLapilli methodsFor: 'testing -- private' stamp: 'HG 11/1/2020 20:56:46'!
playerXWinsByDiagonal
	^self playerXWinsByLeftDiagonal or: self playerXWinsByRightDiagonal.! !

!TerniLapilli methodsFor: 'testing -- private' stamp: 'HG 11/1/2020 21:00:01'!
playerXWinsByHorizontalRow
	| xWins boardRowIndexs |
	xWins _ false.
	boardRowIndexs _ (1 to: 3).
	boardRowIndexs do: [:aRowIndex | (self playerWinsByRowIndex: aRowIndex withPositions: xPlayerPositions ) ifTrue: [ xWins _ true. ]].
	^xWins.! !

!TerniLapilli methodsFor: 'testing -- private' stamp: 'FS 11/2/2020 13:52:56'!
playerXWinsByLeftDiagonal

	^ ((xPlayerPositions intersection: self leftBoardDiagonal) size) =3! !

!TerniLapilli methodsFor: 'testing -- private' stamp: 'FS 11/2/2020 13:52:45'!
playerXWinsByRightDiagonal

	^ ((xPlayerPositions intersection: self rightBoardDiagonal) size) =3! !

!TerniLapilli methodsFor: 'testing -- private' stamp: 'HG 11/1/2020 21:01:42'!
playerXWinsByVerticalColumn

	| xWins boardColumnIndexs |
	xWins _ false.
	boardColumnIndexs _ (1 to: 3).
	boardColumnIndexs do: [:aColumnIndex | (self playerWinsByColumnIndex: aColumnIndex withPositions: xPlayerPositions) ifTrue: [ xWins _ true. ]].
	^xWins.! !

!TerniLapilli methodsFor: 'testing -- private' stamp: 'FS 11/2/2020 13:58:42'!
validBoardPositionCheck: aBoardPosition

	^ (self class assertValidBoardPosition: aBoardPosition) 
		ifFalse: [ self signalInvalidBoardPosition. ]! !


!TerniLapilli methodsFor: 'testing' stamp: 'HG 10/29/2020 18:33:26'!
isAnOPlayerPosition: aBoardPosition 
	^oPlayerPositions includes: aBoardPosition.! !

!TerniLapilli methodsFor: 'testing' stamp: 'HG 11/2/2020 10:55:28'!
isAnOccupiedPosition: aBoardPosition 
	^(self isAnOPlayerPosition: aBoardPosition) or: (self isAnXPlayerPosition: aBoardPosition).! !

!TerniLapilli methodsFor: 'testing' stamp: 'HG 10/29/2020 18:33:15'!
isAnXPlayerPosition: aBoardPosition 
	^xPlayerPositions includes: aBoardPosition.! !

!TerniLapilli methodsFor: 'testing' stamp: 'FS 11/2/2020 13:53:57'!
isOver
	^self playerOHasWon or: (self playerXHasWon).! !

!TerniLapilli methodsFor: 'testing' stamp: 'FS 11/2/2020 14:12:59'!
isPlayingO
	^turnState isPlayingO and: self isOver not.! !

!TerniLapilli methodsFor: 'testing' stamp: 'FS 11/2/2020 14:13:05'!
isPlayingX
	^turnState isPlayingX and: self isOver not.! !

!TerniLapilli methodsFor: 'testing' stamp: 'FS 11/2/2020 13:53:44'!
playerOHasWon
	^self playerOWinsByHorizontalRow or: self playerOWinsByDiagonal or: self playerOWinsByVerticalColumn.! !

!TerniLapilli methodsFor: 'testing' stamp: 'FS 11/2/2020 13:53:57'!
playerXHasWon
	^self playerXWinsByHorizontalRow or: self playerXWinsByDiagonal or: self playerXWinsByVerticalColumn.! !


!TerniLapilli methodsFor: 'exceptions' stamp: 'FS 11/1/2020 22:55:22'!
signalAllChipsAlreadyOnBoard
	^self error: self class allChipsAlreadyOnTheBoardErrorDescription ! !

!TerniLapilli methodsFor: 'exceptions' stamp: 'HG 11/1/2020 22:12:14'!
signalGameIsAlreadyOver

	^ self error: self class gameAlreadyOverErrorDescription.! !

!TerniLapilli methodsFor: 'exceptions' stamp: 'HG 11/1/2020 19:17:56'!
signalInvalidBoardPosition

	^ self error: self class invalidBoardPosition! !

!TerniLapilli methodsFor: 'exceptions' stamp: 'HG 11/1/2020 19:41:35'!
signalInvalidMovement

	^ self error: self class invalidMovementErrorDescription! !

!TerniLapilli methodsFor: 'exceptions' stamp: 'FS 11/2/2020 13:55:08'!
signalInvalidSourcePosition

	^ self error: self class invalidSourcePositionToMove! !

!TerniLapilli methodsFor: 'exceptions' stamp: 'FS 11/2/2020 13:55:33'!
signalInvalidTurn

	^ self error: self class invalidTurnErrorDescription! !

!TerniLapilli methodsFor: 'exceptions' stamp: 'HG 11/1/2020 19:39:44'!
signalMovingBeforeAllChipsOnBoard

	^ self error: self class cantMoveBeforePuttingAllChipsOnBoardErrorDescription! !

!TerniLapilli methodsFor: 'exceptions' stamp: 'HG 11/1/2020 19:27:12'!
signalOccupiedPosition

	^ self error: self class occupiedPositionErrorDescription! !


!TerniLapilli methodsFor: 'game actions' stamp: 'HG 11/1/2020 19:44:01'!
movePlayerOPositionFrom: aSourceBoardPosition to: aDestinationBoardPosition 
	
	self checkConditionsToMoveForPlayerOFrom: aSourceBoardPosition to: aDestinationBoardPosition.
		
	self putOAt: aDestinationBoardPosition. 
	oPlayerPositions remove: aSourceBoardPosition.
	
	
	! !

!TerniLapilli methodsFor: 'game actions' stamp: 'HG 11/1/2020 21:55:50'!
movePlayerXPositionFrom: aSourceBoardPosition to: aDestinationBoardPosition 
	
	turnState movePlayerXPositionFrom: aSourceBoardPosition to: aDestinationBoardPosition.
	
	" 
	self gameplayState movePlayerXPositionFrom: aSourceBoardPosition to: aDestinationBoardPosition.
	"! !

!TerniLapilli methodsFor: 'game actions' stamp: 'HG 11/1/2020 19:19:33'!
putOAt: aBoardPosition 
	
	self validBoardPositionCheck: aBoardPosition.	
	turnState putOAt: aBoardPosition.

	
	
	! !

!TerniLapilli methodsFor: 'game actions' stamp: 'HG 11/1/2020 19:19:25'!
putXAt: aBoardPosition 
	
	self validBoardPositionCheck: aBoardPosition.
	turnState putXAt: aBoardPosition.
	
	
	! !


!TerniLapilli methodsFor: 'initialization' stamp: 'HG 11/1/2020 20:08:31'!
initialize
	turnState _ XPlayerTurn with: self.
	gameplayState _ PlacingStage with: self.
	self initializePlayersPositions.! !

!TerniLapilli methodsFor: 'initialization' stamp: 'HG 11/1/2020 20:08:31'!
initializePlayersPositions

	oPlayerPositions _ OrderedCollection new.
	xPlayerPositions _ OrderedCollection new! !


!TerniLapilli methodsFor: 'game actions -- private' stamp: 'HG 11/1/2020 22:04:45'!
moveAtMovingStagePlayerOFrom: aSourceBoardPosition to:  aDestinationBoardPosition
	
	self checkConditionsToMoveForPlayerOFrom: aSourceBoardPosition  to: aDestinationBoardPosition.
	self playerOMovesToDestination: aDestinationBoardPosition.
	oPlayerPositions remove: aSourceBoardPosition.! !

!TerniLapilli methodsFor: 'game actions -- private' stamp: 'HG 11/1/2020 22:05:09'!
moveAtMovingStagePlayerXFrom: aSourceBoardPosition to: aDestinationBoardPosition
	
	self checkConditionsToMoveForPlayerXFrom: aSourceBoardPosition to: aDestinationBoardPosition.
	self playerXMovesToDestination: aDestinationBoardPosition.
	xPlayerPositions remove: aSourceBoardPosition.! !

!TerniLapilli methodsFor: 'game actions -- private' stamp: 'HG 11/1/2020 21:58:20'!
moveOnOPlayerTurnFrom: aSourceBoardPosition to: aDestinationBoardPosition
	self gameplayState movePlayerOPositionFrom: aSourceBoardPosition to: aDestinationBoardPosition.! !

!TerniLapilli methodsFor: 'game actions -- private' stamp: 'HG 11/1/2020 21:58:14'!
moveOnXPlayerTurnFrom: aSourceBoardPosition to: aDestinationBoardPosition
	self gameplayState movePlayerXPositionFrom: aSourceBoardPosition to: aDestinationBoardPosition.! !

!TerniLapilli methodsFor: 'game actions -- private' stamp: 'HG 11/1/2020 22:04:45'!
playerOMovesToDestination: aDestinationBoardPosition

	self occupiedBoardPositionCheck: aDestinationBoardPosition.
	
	turnState _ XPlayerTurn with: self.
	oPlayerPositions add: aDestinationBoardPosition! !

!TerniLapilli methodsFor: 'game actions -- private' stamp: 'HG 11/1/2020 22:04:50'!
playerXMovesToDestination: aDestinationBoardPosition

	self occupiedBoardPositionCheck: aDestinationBoardPosition.
	
	turnState _ OPlayerTurn with: self.
	xPlayerPositions add: aDestinationBoardPosition! !

!TerniLapilli methodsFor: 'game actions -- private' stamp: 'HG 11/1/2020 22:09:38'!
putOPlayerOnPlacingStageAt: aBoardPosition
	
	self occupiedBoardPositionCheck: aBoardPosition.
	
	turnState _ XPlayerTurn with: self.
	oPlayerPositions add: aBoardPosition.! !

!TerniLapilli methodsFor: 'game actions -- private' stamp: 'HG 11/1/2020 21:09:11'!
putOnOPlayerTurnAt: aBoardPosition
	
	self gameplayState putOnOPlayerTurnAt: aBoardPosition.
	
	"
	self occupiedBoardPositionCheck: aBoardPosition.
	
	turnState _ XPlayerTurn with: self.
	oPlayerPositions add: aBoardPosition.
	"! !

!TerniLapilli methodsFor: 'game actions -- private' stamp: 'HG 11/1/2020 22:07:27'!
putOnXPlayerTurnAt: aBoardPosition
	
	self gameplayState putOnXPlayerTurnAt: aBoardPosition.

	"
	self occupiedBoardPositionCheck: aBoardPosition.
		
	turnState _ OPlayerTurn with: self.
	xPlayerPositions add: aBoardPosition.
	"! !

!TerniLapilli methodsFor: 'game actions -- private' stamp: 'HG 11/1/2020 22:09:52'!
putXPlayerOnPlacingStageAt: aBoardPosition
	
	self occupiedBoardPositionCheck: aBoardPosition.
		
	turnState _ OPlayerTurn with: self.
	xPlayerPositions add: aBoardPosition.! !


!TerniLapilli methodsFor: 'private' stamp: 'HG 11/1/2020 20:26:39'!
gameplayState
	^TerniLapilliGameplay stateFor: self! !


!TerniLapilli methodsFor: 'accessing -- private' stamp: 'FS 10/31/2020 19:25:02'!
getColumn: aColumnIndex
	 |indexedColumn|
	 indexedColumn _ OrderedCollection new.
	 1 to: 3 do:[ :aRowIndex | indexedColumn add: (aColumnIndex@aRowIndex )].
	^indexedColumn ! !

!TerniLapilli methodsFor: 'accessing -- private' stamp: 'FS 10/31/2020 19:27:25'!
getRow: aRowIndex
	 |indexedRow|
	 indexedRow _ OrderedCollection new.
	 1 to: 3 do:[ :aColumnIndex | indexedRow add: (aColumnIndex@aRowIndex )].
	 ^indexedRow ! !

!TerniLapilli methodsFor: 'accessing -- private' stamp: 'FS 11/2/2020 13:52:56'!
leftBoardDiagonal
	^{1@3},{2@2},{3@1}! !

!TerniLapilli methodsFor: 'accessing -- private' stamp: 'FS 11/2/2020 13:52:45'!
rightBoardDiagonal
	^{1@1},{2@2},{3@3}! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #TerniLapilliGame!
TerniLapilli class
	instanceVariableNames: 'validPositions'!

!TerniLapilli class methodsFor: 'error description' stamp: 'FS 11/1/2020 22:51:18'!
allChipsAlreadyOnTheBoardErrorDescription
	^'Cant place any more chips, all chips already on board'! !

!TerniLapilli class methodsFor: 'error description' stamp: 'HG 10/31/2020 18:01:02'!
cantMoveBeforePuttingAllChipsOnBoardErrorDescription
	^'You cant move a chip before put all chips on board'.! !

!TerniLapilli class methodsFor: 'error description' stamp: 'HG 11/1/2020 21:41:34'!
gameAlreadyOverErrorDescription
	^'Game is already over'.! !

!TerniLapilli class methodsFor: 'error description' stamp: 'FS 11/2/2020 13:56:55'!
invalidActionWhenFinishedGame
	^'You cant add or move when the game is already finished.'.! !

!TerniLapilli class methodsFor: 'error description' stamp: 'FS 10/31/2020 18:56:59'!
invalidBoardPosition
	^'position is outside board!!'! !

!TerniLapilli class methodsFor: 'error description' stamp: 'FS 10/31/2020 18:54:00'!
invalidMovementErrorDescription
	^'Invalid movement error'! !

!TerniLapilli class methodsFor: 'error description' stamp: 'FS 11/2/2020 13:58:08'!
invalidSourcePositionToMove
	^'Position is not owned by that player'! !

!TerniLapilli class methodsFor: 'error description' stamp: 'FS 11/2/2020 13:56:28'!
invalidTurnErrorDescription
	^'Player cannot play when isnt his turn'.! !

!TerniLapilli class methodsFor: 'error description' stamp: 'HG 11/1/2020 19:15:48'!
occupiedPositionErrorDescription
	^'Is an occupied position to put a chip on board'.! !


!TerniLapilli class methodsFor: 'instance creation' stamp: 'FS 10/31/2020 19:22:07'!
new
	validPositions _ {1@1} , {1@2},{1@3},{2@1} , {2@2},{2@3},{3@1} , {3@2},{3@3}..
	^(self basicNew) initialize! !


!TerniLapilli class methodsFor: 'accessing' stamp: 'FS 11/2/2020 13:58:42'!
assertValidBoardPosition: aBoardPosition
	^validPositions includes: aBoardPosition ! !


!classDefinition: #TerniLapilliGameplay category: #TerniLapilliGame!
Object subclass: #TerniLapilliGameplay
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliGame'!

!TerniLapilliGameplay methodsFor: 'initialization' stamp: 'HG 11/1/2020 20:05:17'!
initializeWithGame: aTerniLapilliGame
	game _ aTerniLapilliGame.! !


!TerniLapilliGameplay methodsFor: 'game actions' stamp: 'HG 11/2/2020 10:54:47'!
movePlayerOPositionFrom: aSourceBoardPosition to: aDestinationBoardPosition 
	self subclassResponsibility.! !

!TerniLapilliGameplay methodsFor: 'game actions' stamp: 'HG 11/2/2020 10:54:49'!
movePlayerXPositionFrom: aSourceBoardPosition to: aDestinationBoardPosition 
	self subclassResponsibility.! !

!TerniLapilliGameplay methodsFor: 'game actions' stamp: 'HG 11/2/2020 10:54:34'!
putOnOPlayerTurnAt: aBoardPosition
	self subclassResponsibility.! !

!TerniLapilliGameplay methodsFor: 'game actions' stamp: 'HG 11/2/2020 10:54:31'!
putOnXPlayerTurnAt: aBoardPosition
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliGameplay class' category: #TerniLapilliGame!
TerniLapilliGameplay class
	instanceVariableNames: ''!

!TerniLapilliGameplay class methodsFor: 'instance creation' stamp: 'HG 11/1/2020 20:04:43'!
with: aTerniLapilliGame
	^self new initializeWithGame: aTerniLapilliGame.! !


!TerniLapilliGameplay class methodsFor: 'state selection' stamp: 'HG 11/1/2020 20:15:12'!
canHandle: aTerniLapilliGame
	self subclassResponsibility. ! !

!TerniLapilliGameplay class methodsFor: 'state selection' stamp: 'HG 11/1/2020 20:26:53'!
stateFor: aTerniLapilliGame
	^(self subclasses detect: [:aGameplayClass | aGameplayClass canHandle: aTerniLapilliGame ]) with: aTerniLapilliGame! !


!classDefinition: #GameOver category: #TerniLapilliGame!
TerniLapilliGameplay subclass: #GameOver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliGame'!

!GameOver methodsFor: 'game actions' stamp: 'HG 11/1/2020 21:43:19'!
movePlayerOPositionFrom: aSourceBoardPosition to: aDestinationBoardPosition 
	game signalGameIsAlreadyOver.! !

!GameOver methodsFor: 'game actions' stamp: 'HG 11/1/2020 21:43:21'!
movePlayerXPositionFrom: aSourceBoardPosition to: aDestinationBoardPosition 
	game signalGameIsAlreadyOver.! !

!GameOver methodsFor: 'game actions' stamp: 'HG 11/1/2020 21:46:31'!
putOnOPlayerTurnAt: aBoardPosition
	game signalGameIsAlreadyOver.! !

!GameOver methodsFor: 'game actions' stamp: 'HG 11/1/2020 21:46:29'!
putOnXPlayerTurnAt: aBoardPosition
	game signalGameIsAlreadyOver.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameOver class' category: #TerniLapilliGame!
GameOver class
	instanceVariableNames: ''!

!GameOver class methodsFor: 'state selection' stamp: 'HG 11/1/2020 20:20:12'!
canHandle: aTerniLapilliGame
	^aTerniLapilliGame isOver.! !


!classDefinition: #MovingStage category: #TerniLapilliGame!
TerniLapilliGameplay subclass: #MovingStage
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliGame'!

!MovingStage methodsFor: 'game actions' stamp: 'HG 11/1/2020 20:33:01'!
movePlayerOPositionFrom: aSourceBoardPosition to: aDestinationBoardPosition 
	game moveAtMovingStagePlayerOFrom: aSourceBoardPosition to: aDestinationBoardPosition.! !

!MovingStage methodsFor: 'game actions' stamp: 'HG 11/1/2020 20:33:13'!
movePlayerXPositionFrom: aSourceBoardPosition to: aDestinationBoardPosition 
	game moveAtMovingStagePlayerXFrom: aSourceBoardPosition to: aDestinationBoardPosition! !

!MovingStage methodsFor: 'game actions' stamp: 'FS 11/1/2020 22:52:49'!
putOnOPlayerTurnAt: aBoardPosition
	game signalAllChipsAlreadyOnBoard.! !

!MovingStage methodsFor: 'game actions' stamp: 'FS 11/1/2020 22:52:58'!
putOnXPlayerTurnAt: aBoardPosition
	game signalAllChipsAlreadyOnBoard..! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MovingStage class' category: #TerniLapilliGame!
MovingStage class
	instanceVariableNames: ''!

!MovingStage class methodsFor: 'state selection' stamp: 'HG 11/1/2020 20:19:48'!
canHandle: aTerniLapilliGame
	^((aTerniLapilliGame allChipsOnBoard) and: (aTerniLapilliGame isOver not)).! !


!classDefinition: #PlacingStage category: #TerniLapilliGame!
TerniLapilliGameplay subclass: #PlacingStage
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliGame'!

!PlacingStage methodsFor: 'game actions' stamp: 'HG 11/1/2020 20:30:08'!
movePlayerOPositionFrom: aSourceBoardPosition to: aDestinationBoardPosition 
	game signalMovingBeforeAllChipsOnBoard.
! !

!PlacingStage methodsFor: 'game actions' stamp: 'HG 11/1/2020 21:58:42'!
movePlayerXPositionFrom: aSourceBoardPosition to: aDestinationBoardPosition 
	game signalMovingBeforeAllChipsOnBoard.
! !

!PlacingStage methodsFor: 'game actions' stamp: 'HG 11/1/2020 22:08:52'!
putOnOPlayerTurnAt: aBoardPosition
	game putOPlayerOnPlacingStageAt: aBoardPosition.! !

!PlacingStage methodsFor: 'game actions' stamp: 'HG 11/1/2020 22:09:07'!
putOnXPlayerTurnAt: aBoardPosition
	game putXPlayerOnPlacingStageAt: aBoardPosition.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlacingStage class' category: #TerniLapilliGame!
PlacingStage class
	instanceVariableNames: ''!

!PlacingStage class methodsFor: 'state selection' stamp: 'HG 11/1/2020 20:19:19'!
canHandle: aTerniLapilliGame
	^((aTerniLapilliGame allChipsOnBoard) or: (aTerniLapilliGame isOver)) not.
	! !


!classDefinition: #TerniLapilliTurnState category: #TerniLapilliGame!
Object subclass: #TerniLapilliTurnState
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliGame'!

!TerniLapilliTurnState methodsFor: 'initialization' stamp: 'HG 11/1/2020 18:55:28'!
initializeWithGame: aTerniLapilliGame
	game _ aTerniLapilliGame. ! !


!TerniLapilliTurnState methodsFor: 'turn actions' stamp: 'HG 11/1/2020 19:24:58'!
movePlayerOPositionFrom: aSourceBoardPosition to: aDestinationBoardPosition 
	self subclassResponsibility. ! !

!TerniLapilliTurnState methodsFor: 'turn actions' stamp: 'HG 11/1/2020 19:25:04'!
movePlayerXPositionFrom: aSourceBoardPosition to: aDestinationBoardPosition 
	self subclassResponsibility. ! !

!TerniLapilliTurnState methodsFor: 'turn actions' stamp: 'HG 11/1/2020 18:59:25'!
putOAt: aGameBoardPosition
	self subclassResponsibility. ! !

!TerniLapilliTurnState methodsFor: 'turn actions' stamp: 'HG 11/1/2020 18:59:27'!
putXAt: aGameBoardPosition
	self subclassResponsibility. ! !


!TerniLapilliTurnState methodsFor: 'testing' stamp: 'HG 11/2/2020 11:06:01'!
isPlayingO
	self subclassResponsibility. ! !

!TerniLapilliTurnState methodsFor: 'testing' stamp: 'HG 11/2/2020 11:06:02'!
isPlayingX
	self subclassResponsibility. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliTurnState class' category: #TerniLapilliGame!
TerniLapilliTurnState class
	instanceVariableNames: ''!

!TerniLapilliTurnState class methodsFor: 'instance creation' stamp: 'HG 11/1/2020 19:46:49'!
with: aTerniLapilliGame
	^self new initializeWithGame: aTerniLapilliGame.! !


!classDefinition: #OPlayerTurn category: #TerniLapilliGame!
TerniLapilliTurnState subclass: #OPlayerTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliGame'!

!OPlayerTurn methodsFor: 'turn actions' stamp: 'HG 11/1/2020 22:11:23'!
movePlayerOPositionFrom: aSourceBoardPosition to: aDestinationBoardPosition
	game moveOnOPlayerTurnFrom: aSourceBoardPosition to: aDestinationBoardPosition! !

!OPlayerTurn methodsFor: 'turn actions' stamp: 'HG 11/1/2020 21:56:08'!
movePlayerXPositionFrom: aSourceBoardPosition to: aDestinationBoardPosition
	game signalInvalidTurn.! !

!OPlayerTurn methodsFor: 'turn actions' stamp: 'HG 11/1/2020 22:07:04'!
putOAt: aGameBoardPosition
	game putOnOPlayerTurnAt: aGameBoardPosition.! !

!OPlayerTurn methodsFor: 'turn actions' stamp: 'HG 11/1/2020 19:26:55'!
putXAt: aGameBoardPosition
	game signalInvalidTurn.! !


!OPlayerTurn methodsFor: 'testing' stamp: 'HG 11/1/2020 19:49:33'!
isPlayingO
	^true.! !

!OPlayerTurn methodsFor: 'testing' stamp: 'HG 11/1/2020 19:49:44'!
isPlayingX
	^false.! !


!classDefinition: #XPlayerTurn category: #TerniLapilliGame!
TerniLapilliTurnState subclass: #XPlayerTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliGame'!

!XPlayerTurn methodsFor: 'turn actions' stamp: 'HG 11/1/2020 21:56:34'!
movePlayerOPositionFrom: aSourceBoardPosition to: aDestinationBoardPosition	
	game signalInvalidTurn.! !

!XPlayerTurn methodsFor: 'turn actions' stamp: 'HG 11/1/2020 22:11:18'!
movePlayerXPositionFrom: aSourceBoardPosition to: aDestinationBoardPosition	
	game moveOnXPlayerTurnFrom: aSourceBoardPosition to: aDestinationBoardPosition! !

!XPlayerTurn methodsFor: 'turn actions' stamp: 'HG 11/1/2020 19:26:55'!
putOAt: aGameBoardPosition
	game signalInvalidTurn.! !

!XPlayerTurn methodsFor: 'turn actions' stamp: 'HG 11/1/2020 21:55:05'!
putXAt: aGameBoardPosition
	game putOnXPlayerTurnAt: aGameBoardPosition.! !


!XPlayerTurn methodsFor: 'testing' stamp: 'HG 11/2/2020 11:05:46'!
isPlayingO
	^false.! !

!XPlayerTurn methodsFor: 'testing' stamp: 'HG 11/1/2020 19:48:02'!
isPlayingX
	^true.! !
