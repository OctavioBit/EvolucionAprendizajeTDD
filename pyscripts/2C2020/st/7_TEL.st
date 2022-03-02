!classDefinition: #TerniLapilliTest category: #'TerniLapilli-Exercise'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 11/2/2020 13:56:29'!
test01AtTheBeginningBoardIsEmptyAndXShouldPlay
	
	self assert: terniLapilli boardIsEmpty.
	
	self assert: terniLapilli isPlayingX .
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 11/2/2020 15:23:23'!
test02OCannotInitGame
		
	self should: [ terniLapilli putOAt: 0@0. self fail. ]
		raise: Error
		withMessageText: terniLapilli class playerXShouldPlayErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 11/2/2020 14:51:50'!
test03OPlaysAfterX
	
	terniLapilli putXAt: 0@0 .
	
	self assert: terniLapilli isPlayingO .
	
	self deny: terniLapilli isPlayingX .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 11/2/2020 14:52:05'!
test04XPlaysAfterO
	
	terniLapilli putXAt: 0@0 .
	
	terniLapilli putOAt: 0@1 .
	
	self assert: terniLapilli isPlayingX .
	
	self deny: terniLapilli isPlayingO .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 11/2/2020 17:48:14'!
test05XShouldPutInAValidPosition
	
	self denyXPutOutsideBoard.
		
	self denyXPutOnNotIntegerPosition.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 11/2/2020 17:49:30'!
test06OShouldPutInAValidPosition
	
	self denyOPutOutsideBoard.
		
	self denyOPutOnNotIntegerPosition.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 11/2/2020 17:57:41'!
test07XShouldPutInAvailablePosition

	terniLapilli putXAt: 0@0 .
	
	terniLapilli putOAt: 1@0.
	
	self denyXPutOnOccupiedPosition .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 11/2/2020 17:50:51'!
test08OShouldPutInAvailablePosition
	
	terniLapilli putXAt: 0@0 .
	
	terniLapilli putOAt: 1@0.
	
	terniLapilli putXAt: 1@1 .
	
	self denyOPutOnOccupiedPosition.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 11/2/2020 15:56:25'!
test09XCannotPutMoreThanThreeTimes

	self fillBoard .
	
	self should: [ terniLapilli putXAt: 2@2. self fail.]
		raise: Error
		withMessageText: terniLapilli class cannotPutMoreThanThreeTokensErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 11/2/2020 15:57:07'!
test10XCanMoveOnlyWithThreeTokens

	terniLapilli putXAt: 0@0 .
	
	terniLapilli putOAt: 0@1 .
	
	terniLapilli putXAt: 1@0.
	
	terniLapilli putOAt: 1@1 .
	
	self should: [ terniLapilli moveXFrom: 0@0 to: 0@1. self fail. ] 
		raise: Error
		withMessageText: terniLapilli class movementsCanOnlyBeDoneWithThreeTokens .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 11/2/2020 15:57:33'!
test11OCanMoveOnlyWithThreeTokens

	terniLapilli putXAt: 0@0 .
	
	terniLapilli putOAt: 0@1 .
	
	terniLapilli putXAt: 1@0.
	
	terniLapilli putOAt: 1@1 .
	
	self should: [ terniLapilli moveOFrom: 0@2 to: 1@2. self fail. ] 
		raise: Error
		withMessageText: terniLapilli class movementsCanOnlyBeDoneWithThreeTokens .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 11/2/2020 17:58:48'!
test12XCannotMoveToOccupiedPositions

	self fillBoard .
	
	self denyXMoveToOccupiedPosition .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 11/2/2020 17:59:20'!
test13OCannotMoveToOcuppiedPositions

	self fillBoard .
	
	terniLapilli moveXFrom: 1@0 to: 2@0.
	
	self denyOMoveToOccupiedPosition .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 11/2/2020 16:53:50'!
test14XCannotMoveTwice

	self fillBoard .
	
	terniLapilli moveXFrom: 1@0 to: 2@0.
	
	self should: [ terniLapilli moveXFrom: 2@0 to: 2@1. self fail. ] 
		raise: Error
		withMessageText: terniLapilli class playerOShouldPlayErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 11/2/2020 16:53:55'!
test15OCannotMoveTwice

	self fillBoard .
	
	terniLapilli moveXFrom: 1@0 to: 2@0.
	
	terniLapilli moveOFrom: 1@1 to: 2@1.
	
	self should: [ terniLapilli moveOFrom: 2@1 to: 2@2. self fail. ] 
		raise: Error
		withMessageText: terniLapilli class playerXShouldPlayErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 11/2/2020 16:00:17'!
test16XMovementsLengthShouldBeOne

	self fillBoard .
		
	self should: [ terniLapilli moveXFrom: 1@0 to: 2@2. self fail. ] 
		raise: Error
		withMessageText: terniLapilli class movementsLengthShouldBeOneErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 11/2/2020 16:00:21'!
test17OMovementsLengthShouldBeOne

	self fillBoard .
	
	terniLapilli moveXFrom: 1@0 to: 2@0 .
		
	self should: [ terniLapilli moveOFrom: 0@2 to: 2@2. self fail. ] 
		raise: Error
		withMessageText: terniLapilli class movementsLengthShouldBeOneErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 11/2/2020 16:07:06'!
test18XMovesToAValidPositionInTheBoard

	self fillBoard .
	
	self should: [ terniLapilli moveXFrom: 1@0 to: 1@-1. self fail. ] 
		raise: Error
		withMessageText: terniLapilli class positionIsOutsideBoardErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 11/2/2020 16:07:14'!
test19OMovesToAValidPositionInTheBoard

	self fillBoard .
	
	terniLapilli moveXFrom: 1@0 to: 2@0.
	
	self should: [ terniLapilli moveOFrom: 0@2 to: -1@2. self fail. ] 
		raise: Error
		withMessageText: terniLapilli class positionIsOutsideBoardErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 11/2/2020 16:32:27'!
test20XMovesFromSomeOwnToken

	self fillBoard .
		
	self should: [ terniLapilli moveXFrom: 1@1 to: 2@1. self fail. ] 
		raise: Error
		withMessageText: terniLapilli class sourcePositionDoesNotBelongToPlayerErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 11/2/2020 16:32:32'!
test21OMovesFromSomeOwnToken

	self fillBoard .
	
	terniLapilli moveXFrom: 1@0 to: 2@0.
		
	self should: [ terniLapilli moveOFrom: 2@0 to: 1@0. self fail. ] 
		raise: Error
		withMessageText: terniLapilli class sourcePositionDoesNotBelongToPlayerErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 11/2/2020 16:07:30'!
test22XWinsWhenHasThreeTokensInLine

	self fillBoard .
	
	self makeXWin.
	
	self assert: terniLapilli isOver .
	
	self assert: terniLapilli hasPlayerXWon.
	
	self deny: terniLapilli hasPlayerOWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 11/2/2020 16:07:34'!
test23OWinsWhenHasThreeTokensInLine

	self fillBoard .
	
	self makeOWin.
	
	self assert: terniLapilli isOver .
	
	self assert: terniLapilli hasPlayerOWon.
	
	self deny: terniLapilli hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 11/2/2020 16:07:39'!
test24XCannotPlayWhenGameIsOver

	self fillBoard .
	
	self makeOWin.
	
	self should: [ terniLapilli moveXFrom: 1@0 to: 2@0. self fail ]
		raise: Error
		withMessageText: terniLapilli class gameIsOverErrorDescription! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 11/2/2020 16:07:47'!
test25OCannotPlayWhenGameIsOver

	self fillBoard .
	
	self makeXWin.
	
	self should: [ terniLapilli moveOFrom: 2@2 to: 2@1. self fail ]
		raise: Error
		withMessageText: terniLapilli class gameIsOverErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 11/2/2020 16:52:50'!
test26XCannotPutTwice

	terniLapilli putXAt: 0@0.
	
	self should: [ terniLapilli putXAt: 1@1. self fail ]
		raise: Error
		withMessageText: terniLapilli class playerOShouldPlayErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'eb 11/2/2020 16:53:33'!
test27OCannotPutTwice

	terniLapilli putXAt: 0@0.
	
	terniLapilli putOAt: 1@0.
	
	self should: [ terniLapilli putOAt: 1@1. self fail ]
		raise: Error
		withMessageText: terniLapilli class playerXShouldPlayErrorDescription .! !


!TerniLapilliTest methodsFor: 'testing-private' stamp: 'eb 11/2/2020 18:01:45'!
denyOMoveToOccupiedPosition

	self should: [ terniLapilli moveOFrom: 1@1 to: 1@2. self fail. ] 
		raise: Error
		withMessageText: terniLapilli class positionIsNotAvailableErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing-private' stamp: 'eb 11/2/2020 17:49:15'!
denyOPutOnNotIntegerPosition

	self denyOPutOnNotIntegerPosition: 0.5@1.
	
	self denyOPutOnNotIntegerPosition: 1@0.5.! !

!TerniLapilliTest methodsFor: 'testing-private' stamp: 'eb 11/2/2020 18:03:24'!
denyOPutOnNotIntegerPosition: aNotIntegerPosition
	
	self should: [ terniLapilli putOAt: aNotIntegerPosition. self fail.]
		raise: Error
		withMessageText: terniLapilli class positionIsInvalidErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing-private' stamp: 'eb 11/2/2020 17:51:56'!
denyOPutOnOccupiedPosition

	self denyOPutOnOccupiedPosition: 0@0.
	
	self denyOPutOnOccupiedPosition: 1@0.! !

!TerniLapilliTest methodsFor: 'testing-private' stamp: 'eb 11/2/2020 17:51:38'!
denyOPutOnOccupiedPosition: anOccupiedPosition

	self should: [ terniLapilli putOAt: anOccupiedPosition. self fail. ]
		raise: Error
		withMessageText: terniLapilli class positionIsNotAvailableErrorDescription.

	
	! !

!TerniLapilliTest methodsFor: 'testing-private' stamp: 'eb 11/2/2020 17:49:46'!
denyOPutOutsideBoard
	
	self denyOPutOutsideBoard: -1@0.

	self denyOPutOutsideBoard: 0@-1.
	
	self denyOPutOutsideBoard: 3@0.
		
	self denyOPutOutsideBoard: 0@3.! !

!TerniLapilliTest methodsFor: 'testing-private' stamp: 'eb 11/2/2020 18:03:08'!
denyOPutOutsideBoard: aPositionOutsideBoard
	
	self should: [ terniLapilli putOAt: aPositionOutsideBoard. self fail.]
		raise: Error
		withMessageText: terniLapilli class positionIsOutsideBoardErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing-private' stamp: 'eb 11/2/2020 18:01:55'!
denyXMoveToOccupiedPosition

	self should: [ terniLapilli moveXFrom: 1@0 to: 1@1. self fail. ] 
		raise: Error
		withMessageText: terniLapilli class positionIsNotAvailableErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing-private' stamp: 'eb 11/2/2020 17:48:41'!
denyXPutOnNotIntegerPosition

	self denyXPutOnNotIntegerPosition: 0.5@1.
	
	self denyXPutOnNotIntegerPosition: 1@0.5.
! !

!TerniLapilliTest methodsFor: 'testing-private' stamp: 'eb 11/2/2020 18:03:37'!
denyXPutOnNotIntegerPosition: aNotIntegerPosition
	
	self should: [ terniLapilli putXAt: aNotIntegerPosition. self fail.]
		raise: Error
		withMessageText: terniLapilli class positionIsInvalidErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing-private' stamp: 'eb 11/2/2020 17:55:09'!
denyXPutOnOccupiedPosition

	self denyXPutOnOccupiedPosition: 0@0.
	
	self denyXPutOnOccupiedPosition: 1@0.! !

!TerniLapilliTest methodsFor: 'testing-private' stamp: 'eb 11/2/2020 18:03:52'!
denyXPutOnOccupiedPosition: anOccupiedPosition

	self should: [ terniLapilli putXAt: anOccupiedPosition. self fail. ]
		raise: Error
		withMessageText: terniLapilli class positionIsNotAvailableErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing-private' stamp: 'eb 11/2/2020 17:50:11'!
denyXPutOutsideBoard

	self denyXPutOutsideBoard: -1@0.

	self denyXPutOutsideBoard: 0@-1.
	
	self denyXPutOutsideBoard: 3@0.
		
	self denyXPutOutsideBoard: 0@3.! !

!TerniLapilliTest methodsFor: 'testing-private' stamp: 'eb 11/2/2020 18:04:40'!
denyXPutOutsideBoard: aPositionOutsideBoard
	
	self should: [ terniLapilli putXAt: aPositionOutsideBoard. self fail.]
		raise: Error
		withMessageText: terniLapilli class positionIsOutsideBoardErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing-private' stamp: 'eb 11/2/2020 15:27:22'!
fillBoard

	terniLapilli putXAt: 0@0 .
	
	terniLapilli putOAt: 0@1 .
	
	terniLapilli putXAt: 1@0.
	
	terniLapilli putOAt: 1@1 .
	
	terniLapilli putXAt: 1@2 .
	
	terniLapilli putOAt: 0@2! !

!TerniLapilliTest methodsFor: 'testing-private' stamp: 'eb 11/2/2020 15:35:00'!
makeOWin

	terniLapilli moveXFrom: 1@0 to: 2@0.
	
	terniLapilli moveOFrom: 1@1 to: 2@1.
	
	terniLapilli moveXFrom: 1@2 to: 2@2.
	
	terniLapilli moveOFrom: 0@2 to: 1@2.
	
	terniLapilli moveXFrom: 2@0  to: 1@0.
	
	terniLapilli moveOFrom: 1@2 to: 1@1.! !

!TerniLapilliTest methodsFor: 'testing-private' stamp: 'eb 11/2/2020 15:30:45'!
makeXWin

	terniLapilli moveXFrom: 1@0 to: 2@0.
	
	terniLapilli moveOFrom: 1@1 to: 2@1.
	
	terniLapilli moveXFrom: 1@2 to: 1@1.
	
	terniLapilli moveOFrom: 2@1 to: 2@2.
	
	terniLapilli moveXFrom: 1@1 to: 1@0! !


!TerniLapilliTest methodsFor: 'setUp/tearDown' stamp: 'eb 11/2/2020 13:56:04'!
setUp
	
	terniLapilli _ TerniLapilli new .! !


!classDefinition: #TerniLapilli category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'XTokens OTokens isPlayingX'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilli methodsFor: 'accessing' stamp: 'eb 11/2/2020 16:41:00'!
allTokens
	
	^ XTokens union: OTokens .! !

!TerniLapilli methodsFor: 'accessing' stamp: 'eb 10/29/2020 20:34:03'!
board
	
	^ 0@0 corner: 3@3 .! !

!TerniLapilli methodsFor: 'accessing' stamp: 'eb 11/2/2020 17:02:58'!
notPrincipalDiagonal
	
	^ #(0@2. 1@1. 2@0.).! !

!TerniLapilli methodsFor: 'accessing' stamp: 'eb 11/2/2020 16:12:59'!
principalDiagonal
	
	^ #(0@0. 1@1. 2@2.) .! !


!TerniLapilli methodsFor: 'initialization' stamp: 'eb 11/2/2020 08:53:05'!
initialize

	XTokens _ Set new .
	
	OTokens _ Set new .
		
	isPlayingX _ true .! !


!TerniLapilli methodsFor: 'testing' stamp: 'eb 11/2/2020 17:03:13'!
boardIsEmpty
	
	^ self allTokens isEmpty .! !

!TerniLapilli methodsFor: 'testing' stamp: 'eb 11/2/2020 16:14:37'!
isInSomeDiagonal: aPosition
	
	^ (self principalDiagonal includes: aPosition) or: [ self notPrincipalDiagonal includes: aPosition].! !

!TerniLapilli methodsFor: 'testing' stamp: 'eb 10/29/2020 19:28:36'!
isPlayingO
	
	^ isPlayingX not .! !

!TerniLapilli methodsFor: 'testing' stamp: 'eb 10/29/2020 17:52:57'!
isPlayingX

	^ isPlayingX.! !


!TerniLapilli methodsFor: 'asserting' stamp: 'eb 11/2/2020 16:35:59'!
assertThat: aPosition isInto: aPositionCollection
		
	(aPositionCollection includes: aPosition) ifFalse: [ self error: self class sourcePositionDoesNotBelongToPlayerErrorDescription ] .! !

!TerniLapilli methodsFor: 'asserting' stamp: 'eb 11/2/2020 15:49:53'!
assertThat: aSourcePosition isWithinOneUnitDistanceTo: aTargetPosition
	
	| dX dY verticalDistanceIsOne horizontalDistanceIsOne diagonalDistanceIsOne |
	
	dX _ (aSourcePosition x - aTargetPosition x) abs.
	
	dY _ (aSourcePosition y - aTargetPosition y) abs.
	
	verticalDistanceIsOne _ (dX = 0 and: [dY = 1]) .
	
	horizontalDistanceIsOne _ (dX = 1 and: [dY = 0]).
	
	diagonalDistanceIsOne _ (dX = 1 and: [dY = 1] and: [self isInSomeDiagonal: aSourcePosition] and: [self isInSomeDiagonal: aTargetPosition ]).
	
	(verticalDistanceIsOne or: horizontalDistanceIsOne or: diagonalDistanceIsOne) ifFalse: 
		[ self error: self class movementsLengthShouldBeOneErrorDescription .]! !

!TerniLapilli methodsFor: 'asserting' stamp: 'eb 11/2/2020 17:04:25'!
assertThatMovementCanBeDoneFrom: aSourcePosition to: aTargetPosition using: aPositionCollection

	self assertThatThereAreThreeTokensInto: aPositionCollection .
	
	self assertThatPositionIsAvailable: aTargetPosition.
		
	self assertThat: aSourcePosition isWithinOneUnitDistanceTo: aTargetPosition.
	
	self assertThat: aSourcePosition isInto: aPositionCollection .
	
	self assertThatPositionIsIntoTheBoard: aTargetPosition .
	
	self isOver ifTrue: [ self error: self class gameIsOverErrorDescription ].! !

!TerniLapilli methodsFor: 'asserting' stamp: 'eb 11/2/2020 17:01:53'!
assertThatPlayerCanPutTokenInto: aPosition

	self assertThatPositionIsIntoTheBoard: aPosition.
	
	self assertThatPositionIsInteger: aPosition.
	
	self assertThatPositionIsAvailable: aPosition .! !

!TerniLapilli methodsFor: 'asserting' stamp: 'eb 11/2/2020 17:01:42'!
assertThatPositionIsAvailable: aPosition

	(self allTokens includes: aPosition)  ifTrue: [self error: self class positionIsNotAvailableErrorDescription ].! !

!TerniLapilli methodsFor: 'asserting' stamp: 'eb 11/2/2020 17:10:28'!
assertThatPositionIsInteger: aPosition

	aPosition isIntegerPoint ifFalse: [self error: self class positionIsInvalidErrorDescription ]! !

!TerniLapilli methodsFor: 'asserting' stamp: 'eb 11/2/2020 16:45:03'!
assertThatPositionIsIntoTheBoard: aPosition

	(self board containsPoint: aPosition) ifFalse: [ self error: self class positionIsOutsideBoardErrorDescription ]! !

!TerniLapilli methodsFor: 'asserting' stamp: 'eb 11/2/2020 17:02:34'!
assertThatThereAreThreeTokensInto: aPositionCollection

	(aPositionCollection size < 3) ifTrue: [ self error: self class movementsCanOnlyBeDoneWithThreeTokens. ]! !


!TerniLapilli methodsFor: 'playing' stamp: 'eb 11/2/2020 16:12:02'!
hasPlayerOWon
	
	^ self lookForVictoryIn: OTokens .! !

!TerniLapilli methodsFor: 'playing' stamp: 'eb 11/2/2020 16:12:21'!
hasPlayerXWon

	^ self lookForVictoryIn: XTokens .! !

!TerniLapilli methodsFor: 'playing' stamp: 'eb 11/2/2020 13:28:14'!
isOver
	
	^ self hasPlayerOWon or: [ self hasPlayerXWon ].! !

!TerniLapilli methodsFor: 'playing' stamp: 'eb 11/2/2020 17:04:38'!
moveOFrom: aSourcePosition to: aTargetPosition
	
	self assertThatMovementCanBeDoneFrom: aSourcePosition to: aTargetPosition using: OTokens.
	
	self isPlayingX ifTrue: [ self error: self class playerXShouldPlayErrorDescription ].
	
	self moveFrom: aSourcePosition to: aTargetPosition using: OTokens .
	
	isPlayingX _ true .! !

!TerniLapilli methodsFor: 'playing' stamp: 'eb 11/2/2020 17:04:16'!
moveXFrom: aSourcePosition to: aTargetPosition

	self assertThatMovementCanBeDoneFrom: aSourcePosition to:  aTargetPosition using: XTokens .
	
	self isPlayingO ifTrue: [ self error: self class playerOShouldPlayErrorDescription ].
		
	self moveFrom: aSourcePosition to: aTargetPosition using: XTokens .
	
	isPlayingX _ false .
	
! !

!TerniLapilli methodsFor: 'playing' stamp: 'eb 11/2/2020 16:42:38'!
putOAt: aPosition 

	self assertThatPlayerCanPutTokenInto: aPosition.
			
	isPlayingX ifTrue: [ self error: self class playerXShouldPlayErrorDescription ].
	
	OTokens add: aPosition .
		
	isPlayingX _ true .! !

!TerniLapilli methodsFor: 'playing' stamp: 'eb 11/2/2020 16:48:39'!
putXAt: aPosition 
	
	self assertThatPlayerCanPutTokenInto: aPosition.
	
	isPlayingX ifFalse: [ self error: self class playerOShouldPlayErrorDescription ].
		
	(XTokens size = 3) ifTrue: [self error: self class cannotPutMoreThanThreeTokensErrorDescription ].
	
	XTokens add: aPosition .
	
	isPlayingX _ false .! !


!TerniLapilli methodsFor: 'playing-private' stamp: 'eb 11/2/2020 16:13:24'!
lookForVictoryIn: aPositionCollection

	| verticalWin horizontalWin diagonalWin |
	
	(aPositionCollection size < 3) ifTrue: [ ^false ].
	
	verticalWin _ aPositionCollection allSatisfy: [ :each | aPositionCollection asArray first x = each x.].
	
	horizontalWin _ aPositionCollection allSatisfy: [ :each | aPositionCollection asArray first y = each y. ].
	
	diagonalWin _ aPositionCollection = self principalDiagonal or: aPositionCollection = self notPrincipalDiagonal .
	
	^ verticalWin or: horizontalWin or: diagonalWin.! !

!TerniLapilli methodsFor: 'playing-private' stamp: 'eb 11/2/2020 16:36:52'!
moveFrom: aSourcePosition to: aTargetPosition using: aPositionCollection
	
	aPositionCollection remove: aSourcePosition .
	
	aPositionCollection add: aTargetPosition .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'TerniLapilli-Exercise'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'eb 10/31/2020 14:48:02'!
cannotMoveTwiceErrorDescription

	^ 'Player cannot move twice'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'eb 11/2/2020 13:51:11'!
cannotPutMoreThanThreeTokensErrorDescription
	
	^ 'Cannot put more than three tokens into board' .! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'eb 11/2/2020 15:37:58'!
gameIsOverErrorDescription
	
	^ 'Game is over'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'eb 11/1/2020 19:57:40'!
movementDestinationIsInvalidErrorDescription
	
	^ 'Movement destination is invalid'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'eb 11/1/2020 19:53:17'!
movementDestinationIsOutsideBoardErrorDescription
	
	^ 'Movement destination is outside board'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'eb 10/29/2020 21:20:13'!
movementsCanOnlyBeDoneWithThreeTokens
	
	^ 'Movements can only be done with three tokens'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'eb 10/31/2020 15:17:55'!
movementsLengthShouldBeOneErrorDescription

	^ 'Movements length should be one'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'eb 11/2/2020 16:52:05'!
playerOShouldPlayErrorDescription
	
	^ 'Player O should play'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'eb 10/29/2020 19:38:22'!
playerXShouldPlayErrorDescription

	^ 'Player X should play' .! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'eb 10/31/2020 15:44:58'!
positionIsInvalidErrorDescription

	^ 'Position is invalid'.
! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'eb 10/29/2020 20:50:12'!
positionIsNotAvailableErrorDescription
	
	^ 'Position is not available'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'eb 10/31/2020 15:45:39'!
positionIsOutsideBoardErrorDescription
	
	^ 'Position is outside board'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'eb 11/2/2020 16:31:29'!
sourcePositionDoesNotBelongToPlayerErrorDescription

	^ 'Source position does not belong to player'.! !
