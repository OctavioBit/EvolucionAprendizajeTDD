!classDefinition: #TerniLapilliTest category: 'Ejercicio - TerniLapilli'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio - TerniLapilli'!

!TerniLapilliTest methodsFor: 'tests' stamp: 'BT 11/1/2020 23:59:26'!
test01aNewGameIsNotOver

	| aJustStartedMatch |
	aJustStartedMatch := TerniLapilli newGame.
	self deny: aJustStartedMatch isOver.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'BT 11/1/2020 23:59:07'!
test02XstartsPlaying

	| aJustStartedMatch |
	aJustStartedMatch := TerniLapilli newGame.
	self assert: aJustStartedMatch isPlayingX.
	self deny: aJustStartedMatch isPlayingO.
	self deny: aJustStartedMatch isOver.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'CR 11/2/2020 16:45:51'!
test03settingPieceToPositionOutOfRangeRaisesError

	| aJustStartedMatch |
	aJustStartedMatch := TerniLapilli newGame.
	
	self should: [aJustStartedMatch setXAt: -1@0.] 
	raise: Error   
	withMessageText: TerniLapilli errorOutOfRangePosition.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'CR 11/2/2020 05:22:04'!
test04XPlaysAndGameChangesTurnToO

	| aJustStartedMatch |
	aJustStartedMatch := TerniLapilli newGame.
	aJustStartedMatch setXAt: 1@1.
	
	self deny: aJustStartedMatch isPlayingX.
	self assert: aJustStartedMatch isPlayingO.
	self deny: aJustStartedMatch isOver.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'CR 11/2/2020 16:36:49'!
test05playerTryingToPlayOnWrongTurnRaisesError

	| aJustStartedMatch |
	aJustStartedMatch := TerniLapilli newGame.
	
	self should: [aJustStartedMatch setXAt: 1@1. aJustStartedMatch setXAt: 2@1.] 
	raise: Error   
	withMessageText: TerniLapilli errorInvalidPlayer.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'CR 11/2/2020 05:22:17'!
test06raisesErrorWhenOStarts

	| aJustStartedMatch |
	aJustStartedMatch := TerniLapilli newGame.
	
	self should: [aJustStartedMatch setOAt: 1@1.] 
	raise: Error   
	withMessageText: TerniLapilli errorInvalidPlayer.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'CR 11/2/2020 16:37:35'!
test07setPieceOnAlreadyOccupiedPositionRaisesError

	| aJustStartedMatch |
	aJustStartedMatch := TerniLapilli newGame.
	aJustStartedMatch setXAt: 1@1.
	
	self should: [aJustStartedMatch setOAt: 1@1.] 
	raise: Error   
	withMessageText: TerniLapilli errorAlreadyOccupiedPosition.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'CR 11/2/2020 16:38:08'!
test08setPieceWorksCorrectly

	| aMatch |
	aMatch := TerniLapilli newGame.
	aMatch setXAt: 1@1.
	aMatch setOAt: 2@1.
	self assert: (aMatch doesPositionBelongToX: 1@1).
	self assert: (aMatch doesPositionBelongToO: 2@1).
	self deny: aMatch isOver.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'CR 11/2/2020 16:38:46'!
test09addingMoreThanSixPiecesRaisesError

	| aMatch |
	aMatch := TerniLapilli newGame.
	aMatch setXAt: 1@1.
	aMatch setOAt: 3@1.
	aMatch setXAt: 1@3.
	aMatch setOAt: 1@2.
	aMatch setXAt: 3@2.
	aMatch setOAt: 3@3.
	self deny: aMatch isOver.
	self should: [aMatch setXAt: 2@3.] 
	raise: Error   
	withMessageText: TerniLapilli errorCantAddMoreThanSixGamePieces.

	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'CR 11/2/2020 05:47:01'!
test10horizontalVictoryWorksCorrectly

	| aMatch |
	aMatch := TerniLapilli newGame.
	aMatch setXAt: 1@1.
	aMatch setOAt: 3@1.
	aMatch setXAt: 1@3.
	aMatch setOAt: 2@2.
	aMatch setXAt: 1@2.
	self assert: aMatch isOver.
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'CR 11/2/2020 05:46:52'!
test11verticalVictoryWorksCorrectly

	| aMatch |
	aMatch := TerniLapilli newGame.
	aMatch setXAt: 1@1.
	aMatch setOAt: 3@3.
	aMatch setXAt: 2@1.
	aMatch setOAt: 2@2.
	aMatch setXAt: 3@1.
	self assert: aMatch isOver.
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'CR 11/2/2020 05:46:43'!
test12diagonalVictoryWorksCorrectly

	| aMatch |
	aMatch := TerniLapilli newGame.
	aMatch setXAt: 2@1.
	aMatch setOAt: 3@1.
	aMatch setXAt: 1@2.
	aMatch setOAt: 2@2.
	aMatch setXAt: 3@2.
	aMatch setOAt: 1@3.
	self assert: aMatch isOver.
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'CR 11/2/2020 17:34:06'!
test13movingNonOwnedPieceRaisesError

	| aMatch |
	aMatch := TerniLapilli newGame.
	aMatch setXAt: 2@1.
	aMatch setOAt: 3@1.
	aMatch setXAt: 1@2.
	aMatch setOAt: 2@2.
	aMatch setXAt: 3@2.
	aMatch setOAt: 2@3.
	self deny: aMatch isOver.
	self should: [aMatch moveXFrom: 2@3 to: 1@3.] 
	raise: Error   
	withMessageText: TerniLapilli errorCurrentPlayerDoesntOwnPosition. 
	
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'CR 11/2/2020 16:39:36'!
test14movingPieceToOccupiedPositionRaisesError

	| aMatch |
	aMatch := TerniLapilli newGame.
	aMatch setXAt: 2@1.
	aMatch setOAt: 3@1.
	aMatch setXAt: 1@2.
	aMatch setOAt: 2@2.
	aMatch setXAt: 3@2.
	aMatch setOAt: 2@3.
	self deny: aMatch isOver.
	self should: [aMatch moveXFrom: 2@1 to: 2@2.] 
	raise: Error   
	withMessageText: TerniLapilli errorAlreadyOccupiedPosition. 
	
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'CR 11/2/2020 16:40:55'!
test15movingPieceWhenNotAllPiecesInGameRaisesError

	| aMatch |
	aMatch := TerniLapilli newGame.
	aMatch setXAt: 2@1.
	aMatch setOAt: 3@1.
	self deny: aMatch isOver.
	self should: [aMatch moveXFrom: 2@1 to: 2@2.] 
	raise: Error   
	withMessageText: TerniLapilli errorNotAllPiecesInGame.
	
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'CR 11/2/2020 16:41:43'!
test16movingAfterVictoryRaisesError

	| aMatch |
	aMatch := TerniLapilli newGame.
	aMatch setXAt: 1@1.
	aMatch setOAt: 3@3.
	aMatch setXAt: 2@1.
	aMatch setOAt: 2@2.
	aMatch setXAt: 3@1.
	self assert: aMatch isOver. 
	self should: [aMatch setOAt: 1@2.] 
	raise: Error   
	withMessageText: TerniLapilli errorGameOver. 
	
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'CR 11/2/2020 16:46:34'!
test17movingToPositionOutOfRangeRaisesError

	| aMatch |
	aMatch := TerniLapilli newGame.
	aMatch setXAt: 2@1.
	aMatch setOAt: 3@1.
	aMatch setXAt: 1@2.
	aMatch setOAt: 2@2.
	aMatch setXAt: 3@2.
	aMatch setOAt: 2@3.
	self deny: aMatch isOver. 
	self should: [aMatch moveXFrom: 3@2 to: -1@2.] 
	raise: Error   
	withMessageText: TerniLapilli errorOutOfRangePosition.
	
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'CR 11/2/2020 17:13:39'!
test18movingToInvalidPositionRaisesError

	| aMatch |
	aMatch := TerniLapilli newGame.
	aMatch setXAt: 2@1.
	aMatch setOAt: 3@1.
	aMatch setXAt: 1@2.
	aMatch setOAt: 2@2.
	aMatch setXAt: 3@2.
	aMatch setOAt: 2@3.
	self deny: aMatch isOver. 
	self should: [aMatch moveXFrom: 3@2 to: 1@3.] 
	raise: Error   
	withMessageText: TerniLapilli errorInvalidMovement.
	
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'CR 11/2/2020 17:31:18'!
test19movingChangesOwnershipCorrectly

	| aMatch |
	aMatch := TerniLapilli newGame.
	aMatch setXAt: 2@1.
	aMatch setOAt: 3@1.
	aMatch setXAt: 1@2.
	aMatch setOAt: 2@2.
	aMatch setXAt: 3@2.
	aMatch setOAt: 2@3.
	aMatch moveXFrom: 3@2 to: 3@3.
	self deny: aMatch isOver. 
	self assert: (aMatch doesPositionBelongToX: 3@3).
	self deny: (aMatch doesPositionBelongToX: 3@2).
	
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'CR 11/2/2020 17:37:27'!
test20winnerIsCorrect

	| aMatch |
	aMatch := TerniLapilli newGame.
	aMatch setXAt: 2@1.
	aMatch setOAt: 3@1.
	aMatch setXAt: 1@2.
	aMatch setOAt: 2@2.
	aMatch setXAt: 3@2.
	aMatch setOAt: 1@3.
	self assert: aMatch isOver.
	self deny: aMatch XWins.
	self assert: aMatch OWins.
	
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'CR 11/2/2020 17:39:28'!
test21thereIsNoWinnerWhenGameIsNotOver

	| aMatch |
	aMatch := TerniLapilli newGame.
	aMatch setXAt: 2@1.
	aMatch setOAt: 3@1.
	aMatch setXAt: 1@2.
	aMatch setOAt: 2@2.
	aMatch setXAt: 3@2.
	self deny: aMatch isOver.
	self deny: aMatch XWins.
	self deny: aMatch OWins.
	
	
	! !


!classDefinition: #TerniLapilli category: 'Ejercicio - TerniLapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'gameState currentPlayer gameBoard piecesInTheGame winner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio - TerniLapilli'!

!TerniLapilli methodsFor: 'signals' stamp: 'CR 11/2/2020 02:05:22'!
signalCantAddMoreThanSixGamePieces

	^ self error: self class errorCantAddMoreThanSixGamePieces.! !

!TerniLapilli methodsFor: 'signals' stamp: 'CR 11/2/2020 06:34:20'!
signalCurrentPlayerDoesntOwnPosition

	^ self error: self class errorCurrentPlayerDoesntOwnPosition! !

!TerniLapilli methodsFor: 'signals' stamp: 'CR 11/2/2020 16:49:13'!
signalInvalidMovement

	^ self error: self class errorInvalidMovement! !

!TerniLapilli methodsFor: 'signals' stamp: 'CR 11/2/2020 00:46:26'!
signalInvalidPlayer

	^ self error: self class errorInvalidPlayer.! !

!TerniLapilli methodsFor: 'signals' stamp: 'CR 11/2/2020 15:55:41'!
signalNotAllPiecesInGame

	^ self error: self class errorNotAllPiecesInGame.! !

!TerniLapilli methodsFor: 'signals' stamp: 'CR 11/2/2020 00:46:32'!
signalPointOutOfRange

	^ self error: self class errorOutOfRangePosition.! !

!TerniLapilli methodsFor: 'signals' stamp: 'CR 11/2/2020 01:34:39'!
signalPositionAlreadyOccupied

	^ self error: self class errorAlreadyOccupiedPosition.! !

!TerniLapilli methodsFor: 'signals' stamp: 'CR 11/2/2020 04:19:18'!
signalTheGameIsOver

	^ self error: self class errorGameOver.! !


!TerniLapilli methodsFor: 'verifications' stamp: 'CR 11/2/2020 17:07:27'!
IsCenter: anInitialPosition or: aDestinationPosition

	^ (self isCenter: anInitialPosition) or: [self isCenter: aDestinationPosition ]! !

!TerniLapilli methodsFor: 'verifications' stamp: 'CR 11/2/2020 16:21:58'!
ifAllPiecesInGameThenChangeState
	(piecesInTheGame = 6) ifTrue: [gameState := AllPiecesInGame ofGame: self].! !

!TerniLapilli methodsFor: 'verifications' stamp: 'CR 11/2/2020 15:28:34'!
lastPositionFormsALine: lastPosition

	^ (self checkHorizontally: lastPosition) or: [ (self checkVertically: lastPosition) or: [self checkDiagonals]]! !

!TerniLapilli methodsFor: 'verifications' stamp: 'CR 11/2/2020 17:05:22'!
moveDiagonally: distanceBetweenPoints

	^ distanceBetweenPoints = 2 sqrt! !

!TerniLapilli methodsFor: 'verifications' stamp: 'CR 11/2/2020 17:04:59'!
moveVerticallyOrHorizontally: distanceBetweenPoints

	^ distanceBetweenPoints = 1! !

!TerniLapilli methodsFor: 'verifications' stamp: 'CR 11/2/2020 17:10:56'!
movingDiagonallyIsValidFrom: anInitialPosition to: aDestinationPosition
	| distanceBetweenPoints |
	distanceBetweenPoints := anInitialPosition dist: aDestinationPosition.	
	^ (self moveDiagonally: distanceBetweenPoints) and: [self IsCenter: anInitialPosition or: aDestinationPosition].! !

!TerniLapilli methodsFor: 'verifications' stamp: 'CR 11/2/2020 17:13:21'!
movingVerticallyOrHorizontallyIsValidFrom: anInitialPosition to: aDestinationPosition
	^ (anInitialPosition dist: aDestinationPosition) = 1.! !

!TerniLapilli methodsFor: 'verifications' stamp: 'CR 11/2/2020 04:01:40'!
verifyCurrentPlayerO
	currentPlayer checkAndPlayOnOsTurn.! !

!TerniLapilli methodsFor: 'verifications' stamp: 'CR 11/2/2020 03:58:14'!
verifyCurrentPlayerX
	currentPlayer checkAndPlayOnXsTurn.! !

!TerniLapilli methodsFor: 'verifications' stamp: 'CR 11/2/2020 17:37:42'!
verifyIfCurrentPlayerWins: lastPosition
	| doesCurrentPlayerWin |
	doesCurrentPlayerWin := self lastPositionFormsALine: lastPosition.
	doesCurrentPlayerWin ifTrue: [
		gameState := GameOver ofGame: self.
		winner := currentPlayer.
		]! !

!TerniLapilli methodsFor: 'verifications' stamp: 'CR 11/2/2020 16:50:44'!
verifyItIsAValidOMoveFrom: anInitialPosition to: aDestinationPosition

	self verifyPosition: anInitialPosition and: aDestinationPosition.
	self verifyValidMovementFrom: anInitialPosition to: aDestinationPosition. 
	self verifyCurrentPlayerO.
	self verifyPositionIsOwnedByO: anInitialPosition! !

!TerniLapilli methodsFor: 'verifications' stamp: 'CR 11/2/2020 00:45:12'!
verifyItIsAValidPoint: aPointToCheckRange
	
	^((aPointToCheckRange x between: 1 and: 3) and: [aPointToCheckRange y between: 1 and: 3]) ifFalse: [self signalPointOutOfRange].

	! !

!TerniLapilli methodsFor: 'verifications' stamp: 'CR 11/2/2020 16:50:53'!
verifyItIsAValidXMoveFrom: aDestinationPosition to: anInitialPosition
	
	self verifyPosition: anInitialPosition and: aDestinationPosition.			
	self verifyValidMovementFrom: anInitialPosition to: aDestinationPosition. 
	self verifyCurrentPlayerX.
	self verifyPositionIsOwnedByX: anInitialPosition! !

!TerniLapilli methodsFor: 'verifications' stamp: 'BT 11/2/2020 12:49:58'!
verifyPosition: anInitialPosition and: aDestinationPosition

	self verifyItIsAValidPoint: anInitialPosition.
	self verifyItIsAValidPoint: aDestinationPosition! !

!TerniLapilli methodsFor: 'verifications' stamp: 'CR 11/2/2020 17:40:22'!
verifyPositionIsOwnedByO: aPositionToBeCheckedItsOwnership
	(gameBoard at: aPositionToBeCheckedItsOwnership) failIfNotOwnedByO. 
	
! !

!TerniLapilli methodsFor: 'verifications' stamp: 'CR 11/2/2020 17:40:29'!
verifyPositionIsOwnedByX: aPositionToBeCheckedItsOwnership
	(gameBoard at: aPositionToBeCheckedItsOwnership) failIfNotOwnedByX. 
	
! !

!TerniLapilli methodsFor: 'verifications' stamp: 'CR 11/2/2020 17:10:03'!
verifyValidMovementFrom: anInitialPosition to: aDestinationPosition
	| distanceBetweenPoints |
	distanceBetweenPoints := anInitialPosition dist: aDestinationPosition.
	(self movingVerticallyOrHorizontallyIsValidFrom: anInitialPosition to: aDestinationPosition) ifFalse: [
			(self movingDiagonallyIsValidFrom: anInitialPosition to: aDestinationPosition) ifFalse: [self signalInvalidMovement].
		]
		! !


!TerniLapilli methodsFor: 'testing' stamp: 'CR 11/2/2020 17:36:52'!
OWins
	^ winner isO. ! !

!TerniLapilli methodsFor: 'testing' stamp: 'CR 11/2/2020 17:36:43'!
XWins
	^ winner isX. ! !

!TerniLapilli methodsFor: 'testing' stamp: 'CR 11/2/2020 04:00:15'!
failBecauseItsNotMyTurn
	self signalInvalidPlayer.! !

!TerniLapilli methodsFor: 'testing' stamp: 'CR 11/2/2020 17:40:58'!
isCenter: aPositionToCheckIfItsTheCenterOfBoard
	^ aPositionToCheckIfItsTheCenterOfBoard = 2@2.
		! !

!TerniLapilli methodsFor: 'testing' stamp: 'CR 11/2/2020 15:47:12'!
isOver
	^ gameState isOver.! !

!TerniLapilli methodsFor: 'testing' stamp: 'CR 11/2/2020 04:05:28'!
isPlayingO
	^ currentPlayer isO.! !

!TerniLapilli methodsFor: 'testing' stamp: 'CR 11/2/2020 04:05:44'!
isPlayingX
	^ self isPlayingO not.! !


!TerniLapilli methodsFor: 'game - actions' stamp: 'CR 11/2/2020 16:14:24'!
move: anInitialPosition to: aDestinationPosition

	self moveOccupyingFrom: aDestinationPosition to: anInitialPosition.
	gameState updateGame: aDestinationPosition.! !

!TerniLapilli methodsFor: 'game - actions' stamp: 'CR 11/2/2020 15:59:55'!
moveOFrom: anInitialPosition to: aDestinationPosition
	gameState checkIfAllPiecesInGame.
	self verifyItIsAValidOMoveFrom: aDestinationPosition to: anInitialPosition.
	self move: anInitialPosition to: aDestinationPosition.
! !

!TerniLapilli methodsFor: 'game - actions' stamp: 'CR 11/2/2020 16:00:03'!
moveXFrom: anInitialPosition to: aDestinationPosition
	gameState checkIfAllPiecesInGame.
	self verifyItIsAValidXMoveFrom: aDestinationPosition to: anInitialPosition.
	self move: anInitialPosition to: aDestinationPosition.	
! !

!TerniLapilli methodsFor: 'game - actions' stamp: 'CR 11/2/2020 16:02:27'!
setOAt: aDestinationPosition 
	gameState checkIfNotAllPiecesInGame.
	self verifyCurrentPlayerO.
	self IfPossibleUpdateGameBySettingPlayerAt: aDestinationPosition.	
			
! !

!TerniLapilli methodsFor: 'game - actions' stamp: 'CR 11/2/2020 15:53:08'!
setXAt: aDestinationPosition
	gameState checkIfNotAllPiecesInGame.
	self verifyCurrentPlayerX.
	self IfPossibleUpdateGameBySettingPlayerAt: aDestinationPosition.	
	! !


!TerniLapilli methodsFor: 'initialization' stamp: 'BT 11/2/2020 12:37:53'!
initializeBoard
	gameBoard := Dictionary new.
	1 to: 3 do: [ :row |
		1 to: 3 do: [ :column |
			gameBoard at: row@column put: (TerniLapilliPosition onRow: row onColumn: column ofGame: self). 	
			]
		]
	! !

!TerniLapilli methodsFor: 'initialization' stamp: 'CR 11/2/2020 17:37:12'!
initializeGame
	piecesInTheGame := 0.
	currentPlayer := PlayerX ofGame: self.
	gameState := NotAllPiecesInGame ofGame: self.
	winner := Nobody ofGame: self.
	self initializeBoard.! !


!TerniLapilli methodsFor: 'private' stamp: 'CR 11/2/2020 16:14:46'!
IfPossibleUpdateGameBySettingPlayerAt: aDestinationPosition

	self verifyItIsAValidPoint: aDestinationPosition.
	self occupyPositionByCurrentPlayerIfPossible: aDestinationPosition.
	gameState updateGame: aDestinationPosition.! !

!TerniLapilli methodsFor: 'private' stamp: 'CR 11/2/2020 16:09:46'!
changeTurn
	currentPlayer changePlayer.! !

!TerniLapilli methodsFor: 'private' stamp: 'BT 11/2/2020 12:16:33'!
changeTurnToO
	currentPlayer := PlayerO ofGame: self.! !

!TerniLapilli methodsFor: 'private' stamp: 'BT 11/2/2020 12:18:22'!
changeTurnToX
	currentPlayer := PlayerX ofGame: self.! !

!TerniLapilli methodsFor: 'private' stamp: 'CR 11/2/2020 15:31:13'!
checkDiagonals
	| diagonalPositions isADiagonalVictory |
	
	diagonalPositions := OrderedCollection new.
	diagonalPositions add: (gameBoard at: 1@1).
	diagonalPositions add: (gameBoard at: 2@2).
	diagonalPositions add: (gameBoard at: 3@3).
	isADiagonalVictory := self setGameOverIfBelongToCurrentPlayerPositions: diagonalPositions.
	
	diagonalPositions removeAll. 
	
	diagonalPositions add: (gameBoard at: 1@3).
	diagonalPositions add: ( gameBoard at: 2@2).
	diagonalPositions add: (gameBoard at: 3@1).
	isADiagonalVictory := isADiagonalVictory or: [self setGameOverIfBelongToCurrentPlayerPositions: diagonalPositions].
	^ isADiagonalVictory.! !

!TerniLapilli methodsFor: 'private' stamp: 'CR 11/2/2020 16:20:18'!
checkForVictoryOrChangeTurn: aDestinationPosition
	self ifPlayerWinsThenGameOverElseChangeTurn: aDestinationPosition. 
	! !

!TerniLapilli methodsFor: 'private' stamp: 'CR 11/2/2020 15:25:33'!
checkHorizontally: lastPosition
	| lastPositionRow positionsToCheck|
	positionsToCheck := OrderedCollection new.
	lastPositionRow := lastPosition x.
	positionsToCheck add: (gameBoard at: lastPositionRow@1).
	positionsToCheck add: (gameBoard at: lastPositionRow@2).
	positionsToCheck add: (gameBoard at: lastPositionRow@3).
	
	^ self setGameOverIfBelongToCurrentPlayerPositions: positionsToCheck.! !

!TerniLapilli methodsFor: 'private' stamp: 'CR 11/2/2020 15:25:39'!
checkVertically: lastPosition
	| lastPositionColumn positionsToCheck|
	positionsToCheck := OrderedCollection new.
	lastPositionColumn := lastPosition y.
	
	positionsToCheck add: (gameBoard at: 1@lastPositionColumn).
	positionsToCheck add: (gameBoard at: 2@lastPositionColumn).
	positionsToCheck add: (gameBoard at: 3@lastPositionColumn).
	
	^ self setGameOverIfBelongToCurrentPlayerPositions: positionsToCheck.! !

!TerniLapilli methodsFor: 'private' stamp: 'CR 11/2/2020 06:23:17'!
freePreviousPosition: aPositionToRelease
	(gameBoard at: aPositionToRelease) free.
! !

!TerniLapilli methodsFor: 'private' stamp: 'CR 11/2/2020 16:08:50'!
ifPlayerWinsThenGameOverElseChangeTurn: aDestinationPosition
	self verifyIfCurrentPlayerWins: aDestinationPosition. 
	gameState ifNotOverThenChangeTurn. 
	! !

!TerniLapilli methodsFor: 'private' stamp: 'BT 11/2/2020 13:49:43'!
moveOccupyingFrom: aDestinationPosition to: anInitialPosition

	self occupyPositionByCurrentPlayerIfPossible: aDestinationPosition.
	self freePreviousPosition: anInitialPosition! !

!TerniLapilli methodsFor: 'private' stamp: 'BT 11/2/2020 13:52:25'!
occupyByCurrentPlayerPosition: aPosition
	(gameBoard at: aPosition) setOwnerTo: currentPlayer. 
	piecesInTheGame := piecesInTheGame + 1.! !

!TerniLapilli methodsFor: 'private' stamp: 'BT 11/2/2020 13:53:59'!
occupyPositionByCurrentPlayerIfPossible: aPositionToBeOccupiedByCurrentPlayer 
	(gameBoard at: aPositionToBeOccupiedByCurrentPlayer) failIfOccupied.
	self occupyByCurrentPlayerPosition: aPositionToBeOccupiedByCurrentPlayer.! !

!TerniLapilli methodsFor: 'private' stamp: 'CR 11/2/2020 15:32:52'!
setGameOverIfBelongToCurrentPlayerPositions: positionsToCheck.
	
	^ positionsToCheck allSatisfy: [:aPosition | (aPosition owner) isKindOf: currentPlayer class].
	! !

!TerniLapilli methodsFor: 'private' stamp: 'CR 11/2/2020 16:07:26'!
updateGame: aDestinationPosition
	self ifPlayerWinsThenGameOverElseChangeTurn: aDestinationPosition. 
	! !


!TerniLapilli methodsFor: 'accessing' stamp: 'CR 11/2/2020 17:27:26'!
doesPositionBelongToO: aPointToVerifyOwnerShip 
	^ (gameBoard at: aPointToVerifyOwnerShip) itsOwnerIsO.! !

!TerniLapilli methodsFor: 'accessing' stamp: 'CR 11/2/2020 17:27:33'!
doesPositionBelongToX: aPointToVerifyOwnerShip 
	^ (gameBoard at: aPointToVerifyOwnerShip) itsOwnerIsX.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: 'Ejercicio - TerniLapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'instance creation' stamp: 'BT 11/2/2020 00:22:16'!
newGame
	^ self new initializeGame.! !


!TerniLapilli class methodsFor: 'error messages' stamp: 'CR 11/2/2020 06:35:37'!
errorAlreadyOccupiedPosition
	^ 'This position is already occupied!!'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'CR 11/2/2020 02:05:38'!
errorCantAddMoreThanSixGamePieces
	^ 'Error!! Cant add more than more than 6 game pieces'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'CR 11/2/2020 06:35:17'!
errorCurrentPlayerDoesntOwnPosition
	^ 'This position doesnt belong to current player!!'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'CR 11/2/2020 04:19:40'!
errorGameOver
	^ 'Error!! The game has already ended'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'CR 11/2/2020 16:48:58'!
errorInvalidMovement
	^ 'This movement is invalid!!'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'BT 11/2/2020 00:19:28'!
errorInvalidPlayer
	^ 'Wrong turn, unexpected player is playing!!'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'CR 11/2/2020 15:56:04'!
errorNotAllPiecesInGame
	^ 'Cant move pieces if not all pieces in game!!'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'BT 11/2/2020 00:32:34'!
errorOutOfRangePosition
	^ 'Out of range position!!'.! !


!classDefinition: #TerniLapilliPlayer category: 'Ejercicio - TerniLapilli'!
Object subclass: #TerniLapilliPlayer
	instanceVariableNames: 'terniLapilliGame'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio - TerniLapilli'!

!TerniLapilliPlayer methodsFor: 'initialization' stamp: 'CR 11/2/2020 03:39:14'!
initializeWithGame: aTLGameToBeAttachedTo

	terniLapilliGame := aTLGameToBeAttachedTo.! !


!TerniLapilliPlayer methodsFor: 'accessing' stamp: 'CR 11/2/2020 03:45:27'!
isO
	self subclassResponsibility ! !

!TerniLapilliPlayer methodsFor: 'accessing' stamp: 'CR 11/2/2020 03:46:07'!
isSomebody
	self subclassResponsibility ! !


!TerniLapilliPlayer methodsFor: 'testing' stamp: 'CR 11/2/2020 03:45:47'!
ifItsSomebodyThenFail: aPositionOwnedByMe
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliPlayer class' category: 'Ejercicio - TerniLapilli'!
TerniLapilliPlayer class
	instanceVariableNames: ''!

!TerniLapilliPlayer class methodsFor: 'instance creation' stamp: 'CR 11/2/2020 03:38:53'!
ofGame: aTLGameToBeAttachedTo
	^self new initializeWithGame: aTLGameToBeAttachedTo.! !


!classDefinition: #Nobody category: 'Ejercicio - TerniLapilli'!
TerniLapilliPlayer subclass: #Nobody
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio - TerniLapilli'!

!Nobody methodsFor: 'accessing' stamp: 'CR 11/2/2020 02:59:42'!
isO
	^false.! !

!Nobody methodsFor: 'accessing' stamp: 'CR 11/2/2020 03:33:38'!
isSomebody
	^false.! !

!Nobody methodsFor: 'accessing' stamp: 'CR 11/2/2020 17:29:02'!
isX
	^false.! !


!Nobody methodsFor: 'testing' stamp: 'CR 11/2/2020 06:31:49'!
failIfNotOwnedByO: aPositionOwnedByMe
	aPositionOwnedByMe failBecauseOnlyMyOwnerCanMoveMe. ! !

!Nobody methodsFor: 'testing' stamp: 'CR 11/2/2020 06:31:46'!
failIfNotOwnedByX: aPositionOwnedByMe
	aPositionOwnedByMe failBecauseOnlyMyOwnerCanMoveMe. ! !

!Nobody methodsFor: 'testing' stamp: 'CR 11/2/2020 03:44:22'!
ifItsSomebodyThenFail: aPositionOwnedByMe! !


!classDefinition: #PlayerO category: 'Ejercicio - TerniLapilli'!
TerniLapilliPlayer subclass: #PlayerO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio - TerniLapilli'!

!PlayerO methodsFor: 'accessing' stamp: 'CR 11/2/2020 02:41:40'!
isO
	^true.! !

!PlayerO methodsFor: 'accessing' stamp: 'CR 11/2/2020 03:33:27'!
isSomebody
	^true.! !

!PlayerO methodsFor: 'accessing' stamp: 'CR 11/2/2020 17:28:46'!
isX
	^false.! !


!PlayerO methodsFor: 'testing' stamp: 'CR 11/2/2020 03:52:44'!
changePlayer
	terniLapilliGame changeTurnToX.! !

!PlayerO methodsFor: 'testing' stamp: 'CR 11/2/2020 04:01:49'!
checkAndPlayOnOsTurn! !

!PlayerO methodsFor: 'testing' stamp: 'CR 11/2/2020 03:59:30'!
checkAndPlayOnXsTurn
	terniLapilliGame failBecauseItsNotMyTurn.! !

!PlayerO methodsFor: 'testing' stamp: 'CR 11/2/2020 06:29:48'!
failIfNotOwnedByO: aPositionOwnedByMe! !

!PlayerO methodsFor: 'testing' stamp: 'CR 11/2/2020 06:29:39'!
failIfNotOwnedByX: aPositionOwnedByMe
	aPositionOwnedByMe failBecauseOnlyMyOwnerCanMoveMe. ! !

!PlayerO methodsFor: 'testing' stamp: 'CR 11/2/2020 03:44:01'!
ifItsSomebodyThenFail: aPositionOwnedByMe
	aPositionOwnedByMe failBecauseItsAlreadyOccupied.! !


!classDefinition: #PlayerX category: 'Ejercicio - TerniLapilli'!
TerniLapilliPlayer subclass: #PlayerX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio - TerniLapilli'!

!PlayerX methodsFor: 'accessing' stamp: 'CR 11/2/2020 03:09:03'!
isO
	^false.! !

!PlayerX methodsFor: 'accessing' stamp: 'CR 11/2/2020 03:33:20'!
isSomebody
	^true.! !

!PlayerX methodsFor: 'accessing' stamp: 'CR 11/2/2020 17:28:53'!
isX
	^true.! !


!PlayerX methodsFor: 'testing' stamp: 'CR 11/2/2020 03:52:54'!
changePlayer
	terniLapilliGame changeTurnToO.! !

!PlayerX methodsFor: 'testing' stamp: 'CR 11/2/2020 04:01:57'!
checkAndPlayOnOsTurn
	terniLapilliGame failBecauseItsNotMyTurn.! !

!PlayerX methodsFor: 'testing' stamp: 'CR 11/2/2020 03:58:25'!
checkAndPlayOnXsTurn! !

!PlayerX methodsFor: 'testing' stamp: 'CR 11/2/2020 06:29:26'!
failIfNotOwnedByO: aPositionOwnedByMe
	aPositionOwnedByMe failBecauseOnlyMyOwnerCanMoveMe. ! !

!PlayerX methodsFor: 'testing' stamp: 'CR 11/2/2020 06:30:03'!
failIfNotOwnedByX: aPositionOwnedByMe! !

!PlayerX methodsFor: 'testing' stamp: 'CR 11/2/2020 03:44:11'!
ifItsSomebodyThenFail: aPositionOwnedByMe
	aPositionOwnedByMe failBecauseItsAlreadyOccupied.! !


!classDefinition: #TerniLapilliPosition category: 'Ejercicio - TerniLapilli'!
Object subclass: #TerniLapilliPosition
	instanceVariableNames: 'terniLapilliGame owner row column'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio - TerniLapilli'!

!TerniLapilliPosition methodsFor: 'game interaction' stamp: 'CR 11/2/2020 06:12:21'!
free
	owner := Nobody ofGame: terniLapilliGame.! !

!TerniLapilliPosition methodsFor: 'game interaction' stamp: 'CR 11/2/2020 04:07:36'!
setOwnerTo: aPlayerToBeAttachedTo
	owner  := aPlayerToBeAttachedTo.! !


!TerniLapilliPosition methodsFor: 'testing' stamp: 'CR 11/2/2020 03:45:00'!
failBecauseItsAlreadyOccupied
	terniLapilliGame signalPositionAlreadyOccupied. ! !

!TerniLapilliPosition methodsFor: 'testing' stamp: 'CR 11/2/2020 06:34:31'!
failBecauseOnlyMyOwnerCanMoveMe
	terniLapilliGame signalCurrentPlayerDoesntOwnPosition.! !

!TerniLapilliPosition methodsFor: 'testing' stamp: 'CR 11/2/2020 06:38:42'!
failIfNotOwnedByO
	^owner failIfNotOwnedByO: self.! !

!TerniLapilliPosition methodsFor: 'testing' stamp: 'CR 11/2/2020 06:38:20'!
failIfNotOwnedByX
	^owner failIfNotOwnedByX: self.! !

!TerniLapilliPosition methodsFor: 'testing' stamp: 'CR 11/2/2020 03:41:28'!
failIfOccupied
	^owner ifItsSomebodyThenFail: self.! !

!TerniLapilliPosition methodsFor: 'testing' stamp: 'CR 11/2/2020 03:34:01'!
isOccupied
	^owner isSomebody.! !

!TerniLapilliPosition methodsFor: 'testing' stamp: 'CR 11/2/2020 03:46:59'!
itsOwnerIsO
	^owner isO.! !

!TerniLapilliPosition methodsFor: 'testing' stamp: 'CR 11/2/2020 17:28:35'!
itsOwnerIsX
	^owner isX.! !


!TerniLapilliPosition methodsFor: 'initialization' stamp: 'CR 11/2/2020 04:08:13'!
initializeWithRow: aTLPositionRow andColumn: aTLPositionColumn ofGame: aTLGameToBeAttachedTo
	row := aTLPositionRow.
	column := aTLPositionColumn.
	terniLapilliGame := aTLGameToBeAttachedTo.
	owner := Nobody ofGame: terniLapilliGame.! !


!TerniLapilliPosition methodsFor: 'accessing' stamp: 'BT 11/2/2020 14:06:43'!
owner
	^owner.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliPosition class' category: 'Ejercicio - TerniLapilli'!
TerniLapilliPosition class
	instanceVariableNames: ''!

!TerniLapilliPosition class methodsFor: 'as yet unclassified' stamp: 'CR 11/2/2020 03:49:19'!
onRow: row onColumn: column ofGame: aTLGameToBeAttachedTo
	^self new initializeWithRow: row andColumn: column ofGame: aTLGameToBeAttachedTo.! !


!classDefinition: #TerniLapilliState category: 'Ejercicio - TerniLapilli'!
Object subclass: #TerniLapilliState
	instanceVariableNames: 'terniLapilliGame'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio - TerniLapilli'!

!TerniLapilliState methodsFor: 'initialization' stamp: 'CR 11/2/2020 15:42:37'!
initializeWithGame: aTerniLapilliGameToBeAttachedTo
	terniLapilliGame := aTerniLapilliGameToBeAttachedTo.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliState class' category: 'Ejercicio - TerniLapilli'!
TerniLapilliState class
	instanceVariableNames: ''!

!TerniLapilliState class methodsFor: 'as yet unclassified' stamp: 'CR 11/2/2020 15:42:20'!
ofGame: aTerniLapilliGameToBeAttachedTo
	^self new initializeWithGame: aTerniLapilliGameToBeAttachedTo.! !


!classDefinition: #GameOver category: 'Ejercicio - TerniLapilli'!
TerniLapilliState subclass: #GameOver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio - TerniLapilli'!

!GameOver methodsFor: 'accessing' stamp: 'CR 11/2/2020 15:47:22'!
isOver
	^true.! !


!GameOver methodsFor: 'game interaction' stamp: 'CR 11/2/2020 15:51:59'!
checkIfNotAllPiecesInGame
	terniLapilliGame signalTheGameIsOver. ! !

!GameOver methodsFor: 'game interaction' stamp: 'CR 11/2/2020 16:09:06'!
ifNotOverThenChangeTurn! !


!classDefinition: #NonOverGame category: 'Ejercicio - TerniLapilli'!
TerniLapilliState subclass: #NonOverGame
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio - TerniLapilli'!

!NonOverGame methodsFor: 'accessing' stamp: 'CR 11/2/2020 15:47:28'!
isOver
	^false.! !


!NonOverGame methodsFor: 'game interaction' stamp: 'CR 11/2/2020 16:09:55'!
ifNotOverThenChangeTurn
	terniLapilliGame changeTurn.! !


!classDefinition: #AllPiecesInGame category: 'Ejercicio - TerniLapilli'!
NonOverGame subclass: #AllPiecesInGame
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio - TerniLapilli'!

!AllPiecesInGame methodsFor: 'game interaction' stamp: 'CR 11/2/2020 15:54:27'!
checkIfAllPiecesInGame! !

!AllPiecesInGame methodsFor: 'game interaction' stamp: 'CR 11/2/2020 15:51:10'!
checkIfNotAllPiecesInGame
	terniLapilliGame signalCantAddMoreThanSixGamePieces. ! !

!AllPiecesInGame methodsFor: 'game interaction' stamp: 'CR 11/2/2020 16:20:28'!
updateGame: aDestinationPosition
	terniLapilliGame checkForVictoryOrChangeTurn: aDestinationPosition.! !


!classDefinition: #NotAllPiecesInGame category: 'Ejercicio - TerniLapilli'!
NonOverGame subclass: #NotAllPiecesInGame
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio - TerniLapilli'!

!NotAllPiecesInGame methodsFor: 'game interaction' stamp: 'CR 11/2/2020 15:55:14'!
checkIfAllPiecesInGame
	terniLapilliGame signalNotAllPiecesInGame.! !

!NotAllPiecesInGame methodsFor: 'game interaction' stamp: 'CR 11/2/2020 15:51:04'!
checkIfNotAllPiecesInGame! !

!NotAllPiecesInGame methodsFor: 'game interaction' stamp: 'CR 11/2/2020 16:29:08'!
updateGame: aDestinationPosition
	terniLapilliGame ifAllPiecesInGameThenChangeState.
	terniLapilliGame checkForVictoryOrChangeTurn: aDestinationPosition.! !
