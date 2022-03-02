!classDefinition: #TerniLapilliTest category: 'TerniLapilli'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 18:00:05'!
test01PlayerXStartsPlaying

	| game |
	
	game := TerniLapilli new.
	
	self assert: game isPlayingX.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 17:59:32'!
test02AfterPlayerXgoes0

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	
	self assert: game isPlaying0.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 18:18:54'!
test03AfterPlayer0goesX

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	game put0At: 0@1.
	
	self assert: game isPlayingX.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 18:23:29'!
test04WhenXIsPlaying0IsNot

	| game |
	
	game := TerniLapilli new.
	
	self deny: game isPlaying0.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 18:23:37'!
test05When0IsPlayingXIsNot

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	
	self deny: game isPlayingX.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 18:50:12'!
test06PlayerXCannotPutWhen0IsPlaying

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	
	self should: [ game putXAt: 0@1 ] raise: Error withMessageText: TerniLapilli itsNotPlayersTurnErrorDescription.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 19:00:32'!
test07Player0CannotPutWhenXIsPlaying

	| game |
	
	game := TerniLapilli new.
	
	self should: [ game put0At: 0@1 ] raise: Error withMessageText: TerniLapilli itsNotPlayersTurnErrorDescription.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 19:17:41'!
test08aPlayerCantPutATokenOnAnOccupiedPlace

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	
	
	self should: [ game put0At: 0@0 ] raise: Error withMessageText: TerniLapilli spaceAlreadyOccupied.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 19:26:35'!
test09WhenThereAreNoTokensPlayerXHasNotWon

	| game |
	
	game := TerniLapilli new.
	
	self deny: game hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 19:37:08'!
test10WhenXHasLessThanThreeTokensHeHasNotWon

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	game put0At: 1@0.
	
	game putXAt: 0@1.
	
	self deny: game hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 19:37:59'!
test11When0HasLessThanThreeTokensHeHasNotWon

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	game put0At: 1@0.
	
	game putXAt: 0@1.
	game put0At: 2@0.
	
	self deny: game hasPlayer0Won.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 20:39:15'!
test12WhenARowIsFilledWithXPlayerXWins

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	game put0At: 1@0.
	
	game putXAt: 0@1.
	game put0At: 1@1.
	
	game putXAt: 0@2.

	self assert: game hasPlayerXWon .! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 20:39:54'!
test13WhenARowIsFilledWith0Player0Wins

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	game put0At: 1@0.
	
	game putXAt: 0@1.
	game put0At: 1@1.
	
	game putXAt: 2@2.
	game put0At: 1@2.

	self assert: game hasPlayer0Won .! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 11/1/2020 16:14:39'!
test14WhenAColumnIsFilledWithXPlayerXWins

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	game put0At: 2@1.
	
	game putXAt: 1@0.
	game put0At: 1@1.
	
	game putXAt: 2@0.

	self assert: game hasPlayerXWon .! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 20:56:15'!
test15WhenAColumnIsFilledWith0Player0Wins

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	game put0At: 0@1.
	
	game putXAt: 1@0.
	game put0At: 1@1.
	
	game putXAt: 2@2.
	game put0At: 2@1.

	self assert: game hasPlayer0Won .! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 21:15:11'!
test16WhenADiagonalIsFilledWithXPlayerXWins

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	game put0At: 2@1.
	
	game putXAt: 1@1.
	game put0At: 0@1.
	
	game putXAt: 2@2.

	self assert: game hasPlayerXWon .! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 21:22:18'!
test17WhenADiagonalIsFilledWith0Player0Wins

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 2@1.
	game put0At: 0@2.
	
	game putXAt: 0@1.
	game put0At: 1@1.
	
	game putXAt: 0@0.
	game put0At: 2@0.

	self assert: game hasPlayer0Won .! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 10/29/2020 21:28:07'!
test18WhenAPlayerWinsTheGameEnds

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	game put0At: 1@2.
	
	game putXAt: 0@1.
	game put0At: 2@1.
	
	game putXAt: 0@2.
	
	self should: [game put0At: 2@0 ] raise: Error withMessageText: TerniLapilli gameHasEndedErrorDescription.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 11/1/2020 16:56:17'!
test19APlayerCantPutATokenOutsideTheBoard

	| game |
	
	game := TerniLapilli new.
	
	self should: [game putXAt: 4@4 ] raise: Error withMessageText: TerniLapilli invalidPositionErrorDescription.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 11/1/2020 17:13:31'!
test20APlayerCantMoveATokenIfTheGameHasEnded

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	game put0At: 1@2.
	
	game putXAt: 0@1.
	game put0At: 1@0.
	
	game putXAt: 2@2.
	game put0At: 1@1.
	
	self should: [game moveXfrom: 2@2 to: 2@1 ] raise: Error withMessageText: TerniLapilli gameHasEndedErrorDescription.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 11/1/2020 17:21:01'!
test21APlayerCantMoveATokenFromAnEmptyPosition

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	game put0At: 1@2.
	
	game putXAt: 0@1.
	game put0At: 2@1.
	
	game putXAt: 2@2.
	game put0At: 2@0.
	
	self should: [game moveXfrom: 0@2 to: 1@1 ] raise: Error withMessageText: TerniLapilli spaceIsEmptyErrorDescription .! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 11/1/2020 17:22:09'!
test22APlayerCantMoveATokenToAnOccupiedPosition

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	game put0At: 1@2.
	
	game putXAt: 0@1.
	game put0At: 2@1.
	
	game putXAt: 2@2.
	game put0At: 2@0.
	
	self should: [game moveXfrom: 2@2 to: 2@1 ] raise: Error withMessageText: TerniLapilli spaceAlreadyOccupied .! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 11/1/2020 17:23:55'!
test23APlayerCantMoveATokenIfItIsNotTheirTurn

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	game put0At: 1@2.
	
	game putXAt: 0@1.
	game put0At: 2@1.
	
	game putXAt: 2@2.
	game put0At: 2@0.
	
	self should: [game move0from: 2@0 to: 1@0 ] raise: Error withMessageText: TerniLapilli itsNotPlayersTurnErrorDescription .! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 11/1/2020 17:32:36'!
test24APlayerCantMoveATokenFromAnotherPlayer

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	game put0At: 1@2.
	
	game putXAt: 0@1.
	game put0At: 2@1.
	
	game putXAt: 2@2.
	game put0At: 2@0.
	
	self should: [game moveXfrom: 2@0 to: 1@1 ] raise: Error withMessageText: TerniLapilli tokenIsNotOwnedErrorDescription .! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 11/1/2020 17:35:50'!
test25APlayerCantMoveBeforeTheSixthTurn

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	game put0At: 1@2.

	
	self should: [game moveXfrom: 0@0 to: 1@1 ] raise: Error withMessageText: TerniLapilli cannotMoveYetErrorDescription .! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 11/1/2020 17:39:45'!
test26APlayerCanMoveAToken

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	game put0At: 0@1.
	
	game putXAt: 0@2.
	game put0At: 1@2.
	
	game putXAt: 2@2.
	game put0At: 2@1.
	
	game moveXfrom: 0@0 to: 1@0.
	game move0from: 1@2 to: 1@1.
	
	self assert: game hasPlayer0Won.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 11/1/2020 17:43:11'!
test27APlayerCantMoveOutsideTheBoard

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	game put0At: 0@1.
	
	game putXAt: 0@2.
	game put0At: 1@2.
	
	game putXAt: 2@2.
	game put0At: 2@1.

	
	self should: [game moveXfrom: 0@0 to: -1@-1 ] raise: Error withMessageText: TerniLapilli invalidPositionErrorDescription.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'FD 11/1/2020 17:45:00'!
test28APlayerCantMoveToNonAdjacentPositions

	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 0@0.
	game put0At: 0@1.
	
	game putXAt: 0@2.
	game put0At: 1@2.
	
	game putXAt: 2@2.
	game put0At: 2@1.

	
	self should: [game moveXfrom: 0@0 to: 2@0 ] raise: Error withMessageText: TerniLapilli positionNotAdjacentErrorDescription.! !



!classDefinition: #Player category: 'TerniLapilli'!
Object subclass: #Player
	instanceVariableNames: 'tokens name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!Player methodsFor: 'accessing' stamp: 'FD 11/1/2020 18:41:45'!
name

	^name.! !

!Player methodsFor: 'accessing' stamp: 'FD 11/1/2020 18:41:53'!
tokens

	^tokens.! !


!Player methodsFor: 'initialization' stamp: 'FD 11/1/2020 18:41:29'!
initializeWithName: aName

	name := aName.
	tokens := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Player class' category: 'TerniLapilli'!
Player class
	instanceVariableNames: ''!

!Player class methodsFor: 'initialization' stamp: 'FD 11/1/2020 18:41:12'!
named: aName

	^self new initializeWithName: aName! !


!classDefinition: #TerniLapilli category: 'TerniLapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'currentlyPlaying players'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'assertions' stamp: 'FD 11/1/2020 18:25:12'!
assert: aPlayer canMoveFrom: anOccupiedPoint to: anAdjacentUnoccupiedPoint.
	
	self assertAllTokensAreOnTheBoard.
	self assertGameIsInProgress.

	self assertIsPlayersTurn: aPlayer.

	self assertIsValidTargetPosition: anAdjacentUnoccupiedPoint.

	self assertIsValidSourcePosition: anOccupiedPoint for: aPlayer.

	self assertIs: anAdjacentUnoccupiedPoint adjacentTo: anOccupiedPoint .

	! !

!TerniLapilli methodsFor: 'assertions' stamp: 'FD 11/1/2020 18:25:56'!
assert: aPlayer canPutAt: aPoint 
	
	self assertGameIsInProgress.

	self assertIsPlayersTurn: aPlayer.
	self assertIsValidTargetPosition: aPoint.! !

!TerniLapilli methodsFor: 'assertions' stamp: 'FD 11/1/2020 18:46:57'!
assertAllTokensAreOnTheBoard
	(players allSatisfy: [ :aPlayer | aPlayer tokens size = 3]) ifFalse: [self signalCannotMoveYet ]! !

!TerniLapilli methodsFor: 'assertions' stamp: 'FD 11/1/2020 18:22:50'!
assertGameAllowsMovement
	
	self assertAllTokensAreOnTheBoard.
	self assertGameIsInProgress.

	! !

!TerniLapilli methodsFor: 'assertions' stamp: 'FD 11/1/2020 16:12:58'!
assertGameIsInProgress
	(self hasPlayer0Won  or: [self hasPlayerXWon]) ifTrue: [self signalGameHasEnded]! !

!TerniLapilli methodsFor: 'assertions' stamp: 'FD 11/1/2020 17:55:22'!
assertIs: aPoint adjacentTo: anotherPoint

	((anotherPoint fourNeighbors includes: aPoint) or: [aPoint = (1@1)]) ifFalse: [ self signalPositionNotAdjacent ]! !

!TerniLapilli methodsFor: 'assertions' stamp: 'FD 11/1/2020 18:16:14'!
assertIsPlayersTurn: aPlayer

	currentlyPlaying  = aPlayer ifFalse: [ self signalItsNotThatPlayersTurn  ].


	! !

!TerniLapilli methodsFor: 'assertions' stamp: 'FD 11/1/2020 17:01:07'!
assertIsValidPosition: aPoint

	(aPoint between: 0@0 and: 2@2) ifFalse: [ self signalInvalidPosition ]! !

!TerniLapilli methodsFor: 'assertions' stamp: 'FD 11/1/2020 18:24:25'!
assertIsValidSourcePosition: anOccupiedPoint for: aPlayer
	
	self assertSpaceIsOccupied: anOccupiedPoint.
	self assertToken: anOccupiedPoint belongsTo: aPlayer.

	! !

!TerniLapilli methodsFor: 'assertions' stamp: 'FD 11/1/2020 18:23:37'!
assertIsValidTargetPosition: anUnoccupiedPoint
	
	self assertIsValidPosition: anUnoccupiedPoint.
	self assertSpaceIsEmpty: anUnoccupiedPoint .

	! !

!TerniLapilli methodsFor: 'assertions' stamp: 'FD 11/1/2020 18:17:01'!
assertSpaceIsEmpty: aPoint

	^ (self isOccupied: aPoint) ifTrue: [ self signalSpaceAlreadyOccupied ]! !

!TerniLapilli methodsFor: 'assertions' stamp: 'FD 11/1/2020 18:19:06'!
assertSpaceIsOccupied: aPoint

	(self isOccupied: aPoint) ifFalse: [ self signalSpaceIsEmpty ].! !

!TerniLapilli methodsFor: 'assertions' stamp: 'FD 11/1/2020 17:30:57'!
assertToken: anOccupiedPoint belongsTo: aPlayer.
	
	((self getOccupiedCellsBy: aPlayer) includes: anOccupiedPoint) ifFalse: [self signalTokenIsNotOwned ]! !


!TerniLapilli methodsFor: 'testing' stamp: 'FD 11/1/2020 18:53:10'!
hasPlayer0Won

	^self occupiedCellsMeetWinCondition: (self getOccupiedCellsBy: self player0).! !

!TerniLapilli methodsFor: 'testing' stamp: 'FD 11/1/2020 18:53:55'!
hasPlayerXWon
	^ self occupiedCellsMeetWinCondition: (self getOccupiedCellsBy: self playerX).! !

!TerniLapilli methodsFor: 'testing' stamp: 'FD 11/1/2020 18:59:34'!
isPlaying0
	^currentlyPlaying = self player0.! !

!TerniLapilli methodsFor: 'testing' stamp: 'FD 11/1/2020 18:59:19'!
isPlayingX
	^currentlyPlaying = self playerX.! !


!TerniLapilli methodsFor: 'testing -- private' stamp: 'FD 11/1/2020 16:39:15'!
cellsHaveCompleteColumn: aCollectionOfOccupiedCells
	^((self isColumn: 0 CompletedIn: aCollectionOfOccupiedCells ) 
	or: [( self isColumn: 1 CompletedIn: aCollectionOfOccupiedCells)])
	or: [( self isColumn: 2 CompletedIn: aCollectionOfOccupiedCells) ]! !

!TerniLapilli methodsFor: 'testing -- private' stamp: 'FD 11/1/2020 16:40:47'!
cellsHaveCompleteDiagonal: aCollectionOfOccupiedCells
	^ (self isFirstDiagonalCompletedIn: aCollectionOfOccupiedCells)
	or: [self  isSecondDiagonalCompletedIn: aCollectionOfOccupiedCells]! !

!TerniLapilli methodsFor: 'testing -- private' stamp: 'FD 11/1/2020 16:42:51'!
cellsHaveCompleteRow: aCollectionOfOccupiedCells
	^ ((self isRow: 0 CompletedIn: aCollectionOfOccupiedCells )
	or: [( self isRow: 1 CompletedIn: aCollectionOfOccupiedCells)])
	or: [( self isRow: 2 CompletedIn: aCollectionOfOccupiedCells) ]! !

!TerniLapilli methodsFor: 'testing -- private' stamp: 'FD 11/1/2020 16:43:25'!
isColumn: aColumn CompletedIn: aCollectionOfOccupiedCells

	^((aCollectionOfOccupiedCells includes: 0@aColumn) and: [
		aCollectionOfOccupiedCells includes: 1@aColumn
		] and: [aCollectionOfOccupiedCells includes: 2@aColumn]).! !

!TerniLapilli methodsFor: 'testing -- private' stamp: 'FD 11/1/2020 16:43:01'!
isFirstDiagonalCompletedIn: aCollectionOfOccupiedCells
	^((aCollectionOfOccupiedCells includes: 0@0) and: [
		aCollectionOfOccupiedCells includes: 1@1
		] and: [aCollectionOfOccupiedCells includes: 2@2]).! !

!TerniLapilli methodsFor: 'testing -- private' stamp: 'FD 11/1/2020 18:49:37'!
isOccupied: aPoint 
	
	^ (self player0 tokens includes: aPoint) or: [self playerX tokens includes: aPoint ].! !

!TerniLapilli methodsFor: 'testing -- private' stamp: 'FD 11/1/2020 16:33:58'!
isRow: aRow CompletedIn: aCollection

	^((aCollection includes: aRow@0) and: [
		aCollection includes: aRow@1
		] and: [aCollection includes: aRow@2]).! !

!TerniLapilli methodsFor: 'testing -- private' stamp: 'FD 11/1/2020 16:43:33'!
isSecondDiagonalCompletedIn: aCollectionOfOccupiedCells
	^((aCollectionOfOccupiedCells includes: 0@2) and: [
		aCollectionOfOccupiedCells includes: 1@1
		] and: [aCollectionOfOccupiedCells includes: 2@0]).! !

!TerniLapilli methodsFor: 'testing -- private' stamp: 'FD 11/1/2020 16:51:41'!
occupiedCellsMeetWinCondition: aCollectionOfOccupiedCells

	^((self cellsHaveCompleteRow: aCollectionOfOccupiedCells)
	or: [self cellsHaveCompleteColumn: aCollectionOfOccupiedCells ])
	or: [self cellsHaveCompleteDiagonal: aCollectionOfOccupiedCells ].! !


!TerniLapilli methodsFor: 'actions' stamp: 'FD 11/1/2020 18:50:58'!
move0from: anOccupiedPoint to: anAdjacentUnoccupiedPoint 
	
	self move: self player0 from: anOccupiedPoint to: anAdjacentUnoccupiedPoint.! !

!TerniLapilli methodsFor: 'actions' stamp: 'FD 11/1/2020 18:50:53'!
moveXfrom: anOccupiedPoint to: anAdjacentUnoccupiedPoint 
	
	self move: self playerX from: anOccupiedPoint to: anAdjacentUnoccupiedPoint.! !

!TerniLapilli methodsFor: 'actions' stamp: 'FD 11/1/2020 18:50:34'!
put0At: aPoint 
	
	self put: self player0 at: aPoint ! !

!TerniLapilli methodsFor: 'actions' stamp: 'FD 11/1/2020 18:50:43'!
putXAt: aPoint 
	
	self put: self playerX at: aPoint ! !


!TerniLapilli methodsFor: 'actions -- private' stamp: 'FD 11/1/2020 18:09:56'!
move: aPlayer from: anOccupiedPoint to: anAdjacentUnoccupiedPoint 
	
	self assert: aPlayer canMoveFrom: anOccupiedPoint to: anAdjacentUnoccupiedPoint.
	
	(self getOccupiedCellsBy: aPlayer) remove: anOccupiedPoint.
	(self getOccupiedCellsBy: aPlayer)  add: anAdjacentUnoccupiedPoint.
	
	currentlyPlaying := self getOtherPlayer: aPlayer ! !

!TerniLapilli methodsFor: 'actions -- private' stamp: 'FD 11/1/2020 18:05:56'!
put: aPlayer at: aPoint 
	
	self assert: aPlayer canPutAt: aPoint.
	
	(self getOccupiedCellsBy: aPlayer) add: aPoint.
	currentlyPlaying := self getOtherPlayer: aPlayer.! !


!TerniLapilli methodsFor: 'initialization' stamp: 'FD 11/1/2020 18:52:11'!
initialize


	players := OrderedCollection new.
	
	players add: (Player named: $X).
	players add: (Player named: $0).
	
	currentlyPlaying := self playerX.! !


!TerniLapilli methodsFor: 'error handling' stamp: 'FD 11/1/2020 17:34:08'!
signalCannotMoveYet
	self error: self class cannotMoveYetErrorDescription ! !

!TerniLapilli methodsFor: 'error handling' stamp: 'FD 11/1/2020 16:13:39'!
signalGameHasEnded
	self error: self class gameHasEndedErrorDescription ! !

!TerniLapilli methodsFor: 'error handling' stamp: 'FD 11/1/2020 17:01:40'!
signalInvalidPosition
	self error: self class invalidPositionErrorDescription ! !

!TerniLapilli methodsFor: 'error handling' stamp: 'FD 10/29/2020 18:57:55'!
signalItsNotThatPlayersTurn
	self error: self class itsNotPlayersTurnErrorDescription.! !

!TerniLapilli methodsFor: 'error handling' stamp: 'FD 11/1/2020 17:45:59'!
signalPositionNotAdjacent
	self error: self class positionNotAdjacentErrorDescription ! !

!TerniLapilli methodsFor: 'error handling' stamp: 'FD 10/29/2020 19:09:49'!
signalSpaceAlreadyOccupied
	self error: self class spaceAlreadyOccupied .! !

!TerniLapilli methodsFor: 'error handling' stamp: 'FD 11/1/2020 17:17:25'!
signalSpaceIsEmpty
	self error: self class spaceIsEmptyErrorDescription ! !

!TerniLapilli methodsFor: 'error handling' stamp: 'FD 11/1/2020 17:30:37'!
signalTokenIsNotOwned
	self error: self class tokenIsNotOwnedErrorDescription ! !


!TerniLapilli methodsFor: 'accessing' stamp: 'FD 11/1/2020 18:42:31'!
getOccupiedCellsBy: aPlayer 
	
	^aPlayer tokens! !

!TerniLapilli methodsFor: 'accessing' stamp: 'FD 11/1/2020 18:58:36'!
getOtherPlayer: aPlayer
	
	^ (players select: [ :player | player ~= aPlayer ]) first.! !

!TerniLapilli methodsFor: 'accessing' stamp: 'FD 11/1/2020 18:58:42'!
player0
	
	^ (players select: [ :player | player name = $0 ]) first.! !

!TerniLapilli methodsFor: 'accessing' stamp: 'FD 11/1/2020 18:58:47'!
playerX
	
	^ (players select: [ :player | player name = $X ]) first.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: 'TerniLapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error handling' stamp: 'FD 11/1/2020 17:33:50'!
cannotMoveYetErrorDescription
	^ 'cannot move before the sixth turn'! !

!TerniLapilli class methodsFor: 'error handling' stamp: 'FD 11/1/2020 18:10:23'!
gameHasEndedErrorDescription
	^ 'game has already ended'! !

!TerniLapilli class methodsFor: 'error handling' stamp: 'FD 11/1/2020 18:10:34'!
invalidPositionErrorDescription
	^'invalid position'! !

!TerniLapilli class methodsFor: 'error handling' stamp: 'FD 11/1/2020 18:11:01'!
itsNotPlayersTurnErrorDescription
	^ 'it is not that players turn'.! !

!TerniLapilli class methodsFor: 'error handling' stamp: 'FD 11/1/2020 17:45:26'!
positionNotAdjacentErrorDescription
	^ 'position not adjacent'! !

!TerniLapilli class methodsFor: 'error handling' stamp: 'FD 10/29/2020 19:04:23'!
spaceAlreadyOccupied
	^ 'space already occupied'! !

!TerniLapilli class methodsFor: 'error handling' stamp: 'FD 11/1/2020 17:17:25'!
spaceIsEmptyErrorDescription
	^ 'position is empty'! !

!TerniLapilli class methodsFor: 'error handling' stamp: 'FD 11/1/2020 17:30:21'!
tokenIsNotOwnedErrorDescription
	^ 'token is not owned'! !
