!classDefinition: #TerniLapilliTest category: 'Terni Lapilli'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliTest methodsFor: 'Testing Methods' stamp: 'ad 11/2/2020 13:34:46'!
checkThatYouCantPutOutOfBounds

	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	
	self should: [newTerniLapilliGame putXAt: (3@1)] 
		 raise: Error 
		 withMessageText: TerniLapilli cantMoveOrPutChipOutOfBounds .
		
	self should: [newTerniLapilliGame putXAt: (-1@1)] 
		 raise: Error 
		 withMessageText: TerniLapilli cantMoveOrPutChipOutOfBounds.
		
	self should: [newTerniLapilliGame putXAt: (0@3)] 
		 raise: Error 
		 withMessageText: TerniLapilli cantMoveOrPutChipOutOfBounds.
		
	self should: [newTerniLapilliGame putXAt: (1@-1)] 
		 raise: Error 
		 withMessageText: TerniLapilli cantMoveOrPutChipOutOfBounds! !

!TerniLapilliTest methodsFor: 'Testing Methods' stamp: 'ad 11/2/2020 13:31:43'!
createEmptyAndCheckThatPlayerXStarts

	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	self assert: newTerniLapilliGame isEmpty.
	self assert: newTerniLapilliGame isPlayingX.
	self deny: newTerniLapilliGame isPlayingO! !

!TerniLapilliTest methodsFor: 'Testing Methods' stamp: 'ad 11/2/2020 13:32:55'!
createGameAndCheckThatAfterPlayerXGoesPlayerO

	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (1@1).
	self assert: newTerniLapilliGame isPlayingO.
	self deny: newTerniLapilliGame isPlayingX! !

!TerniLapilliTest methodsFor: 'Testing Methods' stamp: 'ad 11/2/2020 13:39:21'!
fillBoardWith2Positions: aCollectionOfPositions in: aTerniLapilliGame 
	
	aTerniLapilliGame putXAt: (aCollectionOfPositions at: 1).
	aTerniLapilliGame putOAt:(aCollectionOfPositions at: 2).! !

!TerniLapilliTest methodsFor: 'Testing Methods' stamp: 'ad 11/2/2020 13:28:09'!
fillBoardWith3Positions: aCollectionOfPositions in: aTerniLapilliGame

	aTerniLapilliGame putXAt: (aCollectionOfPositions at: 1).
	aTerniLapilliGame putOAt:(aCollectionOfPositions at: 2).
	aTerniLapilliGame putXAt: (aCollectionOfPositions at: 3).
	
	
	! !

!TerniLapilliTest methodsFor: 'Testing Methods' stamp: 'ad 11/2/2020 13:27:59'!
fillBoardWith4Positions: aCollectionOfPositions in: aTerniLapilliGame

	aTerniLapilliGame putXAt: (aCollectionOfPositions at: 1).
	aTerniLapilliGame putOAt:(aCollectionOfPositions at: 2).
	aTerniLapilliGame putXAt: (aCollectionOfPositions at: 3).
	aTerniLapilliGame putOAt:(aCollectionOfPositions at: 4).
	
	! !

!TerniLapilliTest methodsFor: 'Testing Methods' stamp: 'ad 11/2/2020 13:27:44'!
fillBoardWith5Positions: aCollectionOfPositions in: aTerniLapilliGame

	aTerniLapilliGame putXAt: (aCollectionOfPositions at: 1).
	aTerniLapilliGame putOAt:(aCollectionOfPositions at: 2).
	aTerniLapilliGame putXAt: (aCollectionOfPositions at: 3).
	aTerniLapilliGame putOAt:(aCollectionOfPositions at: 4).
	aTerniLapilliGame putXAt: (aCollectionOfPositions at: 5).
	! !

!TerniLapilliTest methodsFor: 'Testing Methods' stamp: 'ad 11/2/2020 13:27:30'!
fillBoardWith6Positions: aCollectionOfPositions in: aTerniLapilliGame

	aTerniLapilliGame putXAt: (aCollectionOfPositions at: 1).
	aTerniLapilliGame putOAt:(aCollectionOfPositions at: 2).
	aTerniLapilliGame putXAt: (aCollectionOfPositions at: 3).
	aTerniLapilliGame putOAt:(aCollectionOfPositions at: 4).
	aTerniLapilliGame putXAt: (aCollectionOfPositions at: 5).
	aTerniLapilliGame putOAt:(aCollectionOfPositions at: 6).! !


!TerniLapilliTest methodsFor: 'Tests' stamp: 'ad 11/2/2020 13:31:44'!
test01assertOnStartItsPlayerXTurn
	self createEmptyAndCheckThatPlayerXStarts.! !

!TerniLapilliTest methodsFor: 'Tests' stamp: 'ad 11/2/2020 13:32:55'!
test02assertAfterXTurnGoesO
	self createGameAndCheckThatAfterPlayerXGoesPlayerO.! !

!TerniLapilliTest methodsFor: 'Tests' stamp: 'DB 11/2/2020 02:39:52'!
test03assertPlayerOCantPutChipIfItIsntItsTurn
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	
	self   should: [newTerniLapilliGame putOAt: (1@1)] 
		 raise: Error 
		 withMessageText: TerniLapilli invalidMoveNotYourTurn .! !

!TerniLapilliTest methodsFor: 'Tests' stamp: 'DB 11/2/2020 02:39:02'!
test04assertPlayerOCantPutChipOnAnOccupiedSlot
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (1@1).
	self   should: [newTerniLapilliGame putOAt: (1@1)] 
		 raise: Error 
		 withMessageText: TerniLapilli invalidMoveCantPutChipOnOccupiedSlot .! !

!TerniLapilliTest methodsFor: 'Tests' stamp: 'ad 11/2/2020 13:34:46'!
test05CantPutChipOutOfBound
	self checkThatYouCantPutOutOfBounds.
		! !

!TerniLapilliTest methodsFor: 'Tests' stamp: 'DB 11/2/2020 14:20:41'!
test06assertPlayerXCantPutChipWhenAllChipsHaveBeenPut
	|newTerniLapilliGame aCollectionOfPositions|
	newTerniLapilliGame := TerniLapilli new.
	aCollectionOfPositions := OrderedCollection with: (1@1) with: (1@2) with: (0@2) with:(2@1) with:(2@2) with:(0@1).
	self fillBoardWith6Positions: aCollectionOfPositions in: newTerniLapilliGame .

	self   should: [newTerniLapilliGame putXAt: (2@0)] 
		 raise: Error 
		 withMessageText: TerniLapilli cantPutIfInMovingPhase .! !

!TerniLapilliTest methodsFor: 'Tests' stamp: 'DB 11/2/2020 14:21:14'!
test07assertPlayerOCantPutChipWhenAllChipsHaveBeenPut
	|newTerniLapilliGame aCollectionOfPositions|
	
	newTerniLapilliGame := TerniLapilli new.
	aCollectionOfPositions := OrderedCollection with: (1@1)with: (1@2) with: (0@2)with: (2@1) with: (2@2)with: (0@1).
	self fillBoardWith6Positions: aCollectionOfPositions in: newTerniLapilliGame .
	
	self   should: [newTerniLapilliGame putOAt: (2@0)] 
		 raise: Error 
		 withMessageText: TerniLapilli cantPutIfInMovingPhase .! !

!TerniLapilliTest methodsFor: 'Tests' stamp: 'DB 11/2/2020 02:39:52'!
test08assertPlayerXCantPutChipIfItIsntItsTurn
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	
	newTerniLapilliGame putXAt: (2@1).
	
	self   should: [newTerniLapilliGame putXAt: (1@1)] 
		 raise: Error 
		 withMessageText: TerniLapilli invalidMoveNotYourTurn .! !

!TerniLapilliTest methodsFor: 'Tests' stamp: 'ad 11/2/2020 13:39:35'!
test09assertPlayerXCantPutChipOnAnOccupiedSlot
	|newTerniLapilliGame aCollectionOfPositions|
	newTerniLapilliGame := TerniLapilli new.
	aCollectionOfPositions := OrderedCollection with: (1@0) with: (1@1).
	self fillBoardWith2Positions: aCollectionOfPositions in: newTerniLapilliGame .
	self   should: [newTerniLapilliGame putXAt: (1@1)] 
		 raise: Error 
		 withMessageText: TerniLapilli invalidMoveCantPutChipOnOccupiedSlot .! !

!TerniLapilliTest methodsFor: 'Tests' stamp: 'ad 11/2/2020 13:40:48'!
test10assertCantMoveMoreThanOnePositionAtATime
	|newTerniLapilliGame aCollectionOfPositions|
	newTerniLapilliGame := TerniLapilli new.
	aCollectionOfPositions := OrderedCollection with: (1@1)with: (1@2) with: (0@2)with: (2@1) with: (2@2)with: (0@0).
	self fillBoardWith6Positions: aCollectionOfPositions in: newTerniLapilliGame .
	
	self   should: [newTerniLapilliGame move: (0@0) to: (2@0)] 
		 raise: Error 
		 withMessageText: TerniLapilli cantMoveMoreThanOnePositionAtATime.! !

!TerniLapilliTest methodsFor: 'Tests' stamp: 'ad 11/2/2020 13:41:37'!
test11assertCantDoInvalidDiagonalMovement
	|newTerniLapilliGame aCollectionOfPositions|
	newTerniLapilliGame := TerniLapilli new.
	aCollectionOfPositions := OrderedCollection with: (0@1)with: (0@0) with: (1@1)with: (2@1) with: (2@2)with: (0@2).
	self fillBoardWith6Positions: aCollectionOfPositions in: newTerniLapilliGame .
	self   should: [newTerniLapilliGame move: (0@1) to: (1@2)] 
		 raise: Error 
		 withMessageText: TerniLapilli cantDoInvalidDiagonalMovement.! !

!TerniLapilliTest methodsFor: 'Tests' stamp: 'ad 11/2/2020 13:42:15'!
test12assertCantMoveAnEmptyPosition
	|newTerniLapilliGame aCollectionOfPositions|
	newTerniLapilliGame := TerniLapilli new.
	aCollectionOfPositions := OrderedCollection with: (0@1)with: (0@0) with: (1@1)with: (2@1) with: (2@2)with: (0@2).
	self fillBoardWith6Positions: aCollectionOfPositions in: newTerniLapilliGame .

	self   should: [newTerniLapilliGame move: (1@0) to: (2@0)] 
		 raise: Error 
		 withMessageText: TerniLapilli cantMoveAnEmptyPosition.! !

!TerniLapilliTest methodsFor: 'Tests' stamp: 'ad 11/2/2020 13:42:34'!
test13assertCantMoveOutOfBounds
	|newTerniLapilliGame aCollectionOfPositions|
	newTerniLapilliGame := TerniLapilli new.
	aCollectionOfPositions := OrderedCollection with: (0@1)with: (0@0) with: (1@1)with: (2@1) with: (2@2)with: (0@2).
	self fillBoardWith6Positions: aCollectionOfPositions in: newTerniLapilliGame .

	self   should: [newTerniLapilliGame move: (0@2) to: (-1@2)] 
		 raise: Error 
		 withMessageText: TerniLapilli cantMoveOrPutChipOutOfBounds.! !

!TerniLapilliTest methodsFor: 'Tests' stamp: 'DB 11/2/2020 14:11:09'!
test14CantPutWhileMovingPhase
	|newTerniLapilliGame aCollectionOfPositions|
	newTerniLapilliGame := TerniLapilli new.
	aCollectionOfPositions := OrderedCollection with: (0@1)with: (0@0) with: (1@2)with: (2@1) with: (1@1)with: (2@2).
	self fillBoardWith6Positions: aCollectionOfPositions in: newTerniLapilliGame .	
	newTerniLapilliGame move: (1@1) to: (1@0).
	
	self assert: newTerniLapilliGame isMovingPhase.
			
	self   should: [newTerniLapilliGame putOAt: (2@0)] 
		 raise: Error 
		 withMessageText: TerniLapilli cantPutIfInMovingPhase.
		
! !

!TerniLapilliTest methodsFor: 'Tests' stamp: 'DB 11/2/2020 02:39:52'!
test15CantMoveIfIsNotYourTurn
	
	|newTerniLapilliGame|
	newTerniLapilliGame := TerniLapilli new.
	newTerniLapilliGame putXAt: (0@1).
	newTerniLapilliGame putOAt: (0@0).
	newTerniLapilliGame putXAt: (1@1).
	newTerniLapilliGame putOAt: (2@1).
	newTerniLapilliGame putXAt: (2@2).
	newTerniLapilliGame putOAt: (0@2).
	
	self   should: [newTerniLapilliGame move: (2@1) to: (2@0)] 
		 raise: Error 
		 withMessageText: TerniLapilli invalidMoveNotYourTurn.
! !

!TerniLapilliTest methodsFor: 'Tests' stamp: 'ad 11/2/2020 13:44:44'!
test16CantMoveIfNotAllChipHaveBeenPutDown
	
	|newTerniLapilliGame aCollectionOfPositions|
	newTerniLapilliGame := TerniLapilli new.
	aCollectionOfPositions := OrderedCollection with: (0@1)with: (0@0) with: (1@1).
	self fillBoardWith3Positions: aCollectionOfPositions in: newTerniLapilliGame .
	
	self assert: newTerniLapilliGame isPuttingPhase.
	
	self   should: [newTerniLapilliGame move: (1@1) to: (2@1)] 
		 raise: Error 
		 withMessageText: TerniLapilli cantMoveIfInPuttingPhase .! !

!TerniLapilliTest methodsFor: 'Tests' stamp: 'ad 11/2/2020 13:45:28'!
test17InMovementPhasePlayerXStartsThenItIsPlayerOTurn
	
	|newTerniLapilliGame aCollectionOfPositions|
	newTerniLapilliGame := TerniLapilli new.
	aCollectionOfPositions := OrderedCollection with: (0@1)with: (0@0) with: (1@1)with: (2@1) with: (2@2)with: (0@2).
	self fillBoardWith6Positions: aCollectionOfPositions in: newTerniLapilliGame.
	
	newTerniLapilliGame move: (1@1) to: (1@2).
	
	self assert: newTerniLapilliGame isPlayingO.
	
	newTerniLapilliGame move: (0@0) to: (1@0).
	self assert: newTerniLapilliGame isPlayingX.
	
	 ! !

!TerniLapilliTest methodsFor: 'Tests' stamp: 'ad 11/2/2020 13:46:19'!
test18assertCorrectVerticalAndHorizontalMovementAsWellAsCorrectlyPassingTurn

	|newTerniLapilliGame aCollectionOfPositions|
	newTerniLapilliGame := TerniLapilli new.
	aCollectionOfPositions := OrderedCollection with: (0@1)with: (0@0) with: (1@1)with: (2@1) with: (2@2)with: (0@2).
	self fillBoardWith6Positions: aCollectionOfPositions in: newTerniLapilliGame .
	
	newTerniLapilliGame move: (1@1) to: (1@2).
	
	self assert: (newTerniLapilliGame chipXIsInPosition: (1@2)).
	self assert: (newTerniLapilliGame isAnEmptyPosition: (1@1)).
	self assert: newTerniLapilliGame isPlayingO.
	
	newTerniLapilliGame move: (0@0) to: (1@0).
	
	self assert: (newTerniLapilliGame chipOIsInPosition: (1@0)).
	self assert: (newTerniLapilliGame isAnEmptyPosition: (0@0)).
	self assert: newTerniLapilliGame isPlayingX.
	 ! !

!TerniLapilliTest methodsFor: 'Tests' stamp: 'DB 11/2/2020 14:21:42'!
test19assertPlayerXWonHorizontally
	|newTerniLapilliGame aCollectionOfPositions|
	newTerniLapilliGame := TerniLapilli new.
	aCollectionOfPositions := OrderedCollection with: (0@0) with: (1@2) with: (0@1) with:(2@1) with:(0@2).
	
	self fillBoardWith5Positions: aCollectionOfPositions in: newTerniLapilliGame.
	
	self assert: (newTerniLapilliGame hasPlayerXWon).
	self deny: newTerniLapilliGame hasPlayerOWon.
	! !

!TerniLapilliTest methodsFor: 'Tests' stamp: 'DB 11/2/2020 14:11:30'!
test20assertPlayerOWonHorizontally
	|newTerniLapilliGame aCollectionOfPositions|
	newTerniLapilliGame := TerniLapilli new.
	aCollectionOfPositions := OrderedCollection with: (0@0) with: (1@1) with: (0@1) with:(1@0) with:(2@0) with:(1@2).
	self fillBoardWith6Positions: aCollectionOfPositions in: newTerniLapilliGame .
	self assert: newTerniLapilliGame hasPlayerOWon.
	self deny: newTerniLapilliGame hasPlayerXWon.
	! !

!TerniLapilliTest methodsFor: 'Tests' stamp: 'ad 11/2/2020 13:47:29'!
test21CantWinHorizontalWithLessThanThreeChips
	|newTerniLapilliGame aCollectionOfPositions|
	newTerniLapilliGame := TerniLapilli new.
	aCollectionOfPositions := OrderedCollection with: (0@0)with: (1@1) with: (0@1)with: (1@0).
	self fillBoardWith4Positions: aCollectionOfPositions in: newTerniLapilliGame .
	self deny: newTerniLapilliGame hasPlayerOWon.
	self deny: newTerniLapilliGame hasPlayerXWon.
	! !

!TerniLapilliTest methodsFor: 'Tests' stamp: 'ad 11/2/2020 13:48:04'!
test22CantWinVerticalWithLessThanThreeChips
	|newTerniLapilliGame aCollectionOfPositions|
	newTerniLapilliGame := TerniLapilli new.
	aCollectionOfPositions := OrderedCollection with: (0@0)with: (1@1) with: (1@0)with: (2@0).
	self fillBoardWith4Positions: aCollectionOfPositions in: newTerniLapilliGame .
	self deny: newTerniLapilliGame hasPlayerOWon.
	self deny: newTerniLapilliGame hasPlayerXWon.
	! !

!TerniLapilliTest methodsFor: 'Tests' stamp: 'ad 11/2/2020 13:48:46'!
test23assertPlayerXWonVertically
	|newTerniLapilliGame aCollectionOfPositions|
	newTerniLapilliGame := TerniLapilli new.
	aCollectionOfPositions := OrderedCollection with: (0@0)with: (1@2) with: (1@0)with: (2@1) with: (2@0).
	self fillBoardWith5Positions: aCollectionOfPositions in: newTerniLapilliGame .
	self assert: (newTerniLapilliGame hasPlayerXWon).
	self deny: newTerniLapilliGame hasPlayerOWon.
	! !

!TerniLapilliTest methodsFor: 'Tests' stamp: 'ad 11/2/2020 13:49:21'!
test24assertPlayerOWonVertically
	|newTerniLapilliGame aCollectionOfPositions|
	newTerniLapilliGame := TerniLapilli new.
	aCollectionOfPositions := OrderedCollection with: (0@1)with: (0@0) with: (1@2)with: (1@0) with: (2@1)with: (2@0).
	self fillBoardWith6Positions: aCollectionOfPositions in: newTerniLapilliGame .
	self assert: (newTerniLapilliGame hasPlayerOWon).
	self deny: newTerniLapilliGame hasPlayerXWon.
	! !

!TerniLapilliTest methodsFor: 'Tests' stamp: 'ad 11/2/2020 13:49:48'!
test25XWinsDiagonally
	|newTerniLapilliGame aCollectionOfPositions|
	newTerniLapilliGame := TerniLapilli new.
	aCollectionOfPositions := OrderedCollection with: (2@0)with: (0@0) with: (1@1)with: (1@0) with: (0@2).
	self fillBoardWith5Positions: aCollectionOfPositions in: newTerniLapilliGame .
	
	self assert: (newTerniLapilliGame hasPlayerXWon).
	self deny: newTerniLapilliGame hasPlayerOWon.
	! !

!TerniLapilliTest methodsFor: 'Tests' stamp: 'ad 11/2/2020 13:50:34'!
test26OWinsDiagonally
	|newTerniLapilliGame aCollectionOfPositions|
	newTerniLapilliGame := TerniLapilli new.
	aCollectionOfPositions := OrderedCollection with: (2@0)with: (0@0) with: (2@1)with: (1@1) with: (0@2)with: (2@2).
	self fillBoardWith6Positions: aCollectionOfPositions in: newTerniLapilliGame .
	self assert: (newTerniLapilliGame hasPlayerOWon).
	self deny: newTerniLapilliGame hasPlayerXWon.
	! !

!TerniLapilliTest methodsFor: 'Tests' stamp: 'ad 11/2/2020 13:51:18'!
test27GameDoesNotContinueAfterWinningInPutingPhase
	|newTerniLapilliGame aCollectionOfPositions|
	newTerniLapilliGame := TerniLapilli new.
	aCollectionOfPositions := OrderedCollection with: (2@0)with: (0@0) with: (2@1)with: (1@1) with: (2@2).
	self fillBoardWith5Positions: aCollectionOfPositions in: newTerniLapilliGame.
	self   should: [newTerniLapilliGame putOAt: (1@0)] 
		 raise: Error 
		 withMessageText: TerniLapilli gameIsOver.
	
	self assert: (newTerniLapilliGame hasPlayerXWon).
	self deny: newTerniLapilliGame hasPlayerOWon.
	! !

!TerniLapilliTest methodsFor: 'Tests' stamp: 'ad 11/2/2020 13:52:55'!
test28AfterMovingWin
	|newTerniLapilliGame aCollectionOfPositions|
	newTerniLapilliGame := TerniLapilli new.
	aCollectionOfPositions := OrderedCollection with: (2@0)with: (0@0) with: (1@2)with: (2@1) with: (1@1)with: (2@2).
	self fillBoardWith6Positions: aCollectionOfPositions in: newTerniLapilliGame .
	self assert: newTerniLapilliGame isMovingPhase.
	newTerniLapilliGame move: (2@0) to: (1@0).
	self assert: newTerniLapilliGame isGameOver.
! !


!classDefinition: #TerniLapilli category: 'Terni Lapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'chipsX chipsO turn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilli methodsFor: 'private movement' stamp: 'DB 11/2/2020 03:54:00'!
moveWhenItIsPlayerOsTurn: aSourcePoint to: aDestinationPoint

	chipsO remove: aSourcePoint.
	chipsO add: aDestinationPoint.
	
	
	
	
	! !

!TerniLapilli methodsFor: 'private movement' stamp: 'DB 11/2/2020 03:53:45'!
moveWhenItIsPlayerXsTurn: aSourcePoint to: aDestinationPoint

	chipsX remove: aSourcePoint.
	chipsX add: aDestinationPoint.
	
	
	
	
	! !

!TerniLapilli methodsFor: 'private movement' stamp: 'DB 11/2/2020 03:20:22'!
nextTurn
	turn := turn + 1	
	
	
	! !


!TerniLapilli methodsFor: 'movement' stamp: 'DB 11/2/2020 03:56:10'!
move: aSourcePoint to: aDestinationPoint
	
	self validateMovementFrom: aSourcePoint to: aDestinationPoint.
	
	self player moveFrom: aSourcePoint to: aDestinationPoint.
	
	self nextTurn 
	
	
	
	
	! !

!TerniLapilli methodsFor: 'movement' stamp: 'DB 11/2/2020 03:34:30'!
put: aPoint 

	self player put: aPoint
! !

!TerniLapilli methodsFor: 'movement' stamp: 'DB 11/2/2020 03:58:25'!
putOAt: aPoint 
	
	self assertPositionAndState: aPoint.
	
	self isPlayingX ifTrue: [^	self class signalErrorInvalidMoveNotYourTurn ].
	chipsO add: aPoint.
	
	self nextTurn 
	
	! !

!TerniLapilli methodsFor: 'movement' stamp: 'DB 11/2/2020 03:57:27'!
putWhenItIsPlayerOsTurn: aPoint 
	chipsO add: aPoint.

	
	! !

!TerniLapilli methodsFor: 'movement' stamp: 'DB 11/2/2020 03:57:34'!
putWhenItIsPlayerXsTurn: aPoint 
	chipsX add: aPoint.

	
	! !

!TerniLapilli methodsFor: 'movement' stamp: 'DB 11/2/2020 03:23:00'!
putXAt: aPoint 
	
	self assertPositionAndState: aPoint.
	
	self isPlayingO ifTrue: [^self class signalErrorInvalidMoveNotYourTurn ].
	chipsX add: aPoint.
	
	self nextTurn ! !


!TerniLapilli methodsFor: 'assertions' stamp: 'DB 11/2/2020 03:45:15'!
assertCorrectTurn: aSourcePoint 

	self player assertCorrectTurn: aSourcePoint.
! !

!TerniLapilli methodsFor: 'assertions' stamp: 'DB 11/2/2020 03:44:53'!
assertCorrectTurnWhenItIsPlayerOsTurn: aSourcePoint 

	(chipsO includes: aSourcePoint) ifFalse: [^self class signalInvalidMoveNotYourTurn ]	! !

!TerniLapilli methodsFor: 'assertions' stamp: 'DB 11/2/2020 03:45:09'!
assertCorrectTurnWhenItIsPlayerXsTurn: aSourcePoint 

	(chipsX includes: aSourcePoint) ifFalse: [^self class signalInvalidMoveNotYourTurn ]	! !

!TerniLapilli methodsFor: 'assertions' stamp: 'DB 11/1/2020 23:56:11'!
assertInBounds: aPoint 

	((aPoint x < 0) or: (aPoint y < 0) or: (aPoint x > 2) or: (aPoint y > 2)) ifTrue: [^self class signalCantMoveOrPutChipOutOfBounds ].
	
	! !

!TerniLapilli methodsFor: 'assertions' stamp: 'DB 11/2/2020 02:55:29'!
assertLengthOfMovementFrom: aSourcePoint to: aDestinationPoint 

	(((aSourcePoint x - aDestinationPoint  x) abs > 1) or:
 	 ((aSourcePoint y - aSourcePoint y) abs > 1)) ifTrue: [
	 	^self class signalCantMoveMoreThanOnePositionAtATime.
	]! !

!TerniLapilli methodsFor: 'assertions' stamp: 'DB 11/1/2020 23:04:34'!
assertNotEmptyPosition: aPoint 
	(self isAnEmptyPosition: aPoint)  ifTrue: [^self class signalCantMoveAnEmptyPosition].! !

!TerniLapilli methodsFor: 'assertions' stamp: 'DB 11/2/2020 02:49:02'!
assertPositionAndState: aPoint 
	
	self state assertPut.
	
	self assertInBounds: aPoint.
	
	(self isAnEmptyPosition: aPoint) ifFalse: 	[^self class signalErrorInvalidMoveCantPutChipOnOccupiedSlot ].
	! !

!TerniLapilli methodsFor: 'assertions' stamp: 'DB 11/1/2020 22:50:10'!
checkDiagonalMovementFrom: aSourcePoint to: aDestinationPoint

	"(0@1) no me puedo mover para (1@0) o (1@2)"
	aSourcePoint = (0@1) ifTrue: [
		(aDestinationPoint = (1@0) or:aDestinationPoint = (1@2)) ifTrue: [^self class signalCantDoInvalidDiagonalMovement.]
	].

	"(1@0) no me puedo mover para (0@1) o (2@1)"
	aSourcePoint =(1@0) ifTrue: [
		(aDestinationPoint = (0@1) or:aDestinationPoint = (2@1)) ifTrue: [^self class signalCantDoInvalidDiagonalMovement.]
	].

	"(1@2) no me puedo mover para (0@1) o (2@1)  "
	aSourcePoint = (1@2) ifTrue: [
		(aDestinationPoint = (0@1)  or:aDestinationPoint = (2@1)) ifTrue: [^self class signalCantDoInvalidDiagonalMovement.]
	].

	"(2@1) no me puedo mover en la (1@2) o (1@0)  "
	aSourcePoint = (2@1) ifTrue: [
		(aDestinationPoint =(1@2) or:aDestinationPoint = (1@0)) ifTrue: [^self class signalCantDoInvalidDiagonalMovement.]
	].

	
	! !

!TerniLapilli methodsFor: 'assertions' stamp: 'DB 11/2/2020 02:46:48'!
validateMovementFrom: aSourcePoint to: aDestinationPoint

	self state assertMove.
	
	self assertLengthOfMovementFrom: aSourcePoint to: aDestinationPoint .
	
	self assertInBounds: aDestinationPoint.	
	
	self assertNotEmptyPosition: aSourcePoint.
	
	self assertCorrectTurn: aSourcePoint.
	
	self checkDiagonalMovementFrom: aSourcePoint to: aDestinationPoint.
	
	

	
	
	
	! !


!TerniLapilli methodsFor: 'initialization' stamp: 'DB 11/2/2020 03:48:45'!
initialize
	chipsX := OrderedCollection new.
	chipsO := OrderedCollection new.
	turn := 1! !


!TerniLapilli methodsFor: 'phases' stamp: 'DB 11/2/2020 00:14:13'!
isGameOver
	^(self hasPlayerOWon) or: (self hasPlayerXWon)! !

!TerniLapilli methodsFor: 'phases' stamp: 'DB 11/2/2020 01:33:04'!
isMovingPhase
	 ^(self hasPlayerOWon not) and: (self hasPlayerXWon not) and: (self isBoardFull)! !

!TerniLapilli methodsFor: 'phases' stamp: 'DB 11/2/2020 01:33:15'!
isPuttingPhase
	^(self hasPlayerOWon not) and: (self hasPlayerXWon not) and: ((chipsX size) + (chipsO size) < 6)! !

!TerniLapilli methodsFor: 'phases' stamp: 'DB 11/2/2020 03:33:39'!
player
	^TerniLapilliPlayer stateFor: self
! !

!TerniLapilli methodsFor: 'phases' stamp: 'DB 11/2/2020 01:29:18'!
state
	^TerniLapilliPhase stateFor: self
! !


!TerniLapilli methodsFor: 'testing' stamp: 'DB 11/1/2020 21:03:56'!
chipOIsInPosition: aPosition

	^chipsO includes: aPosition.! !

!TerniLapilli methodsFor: 'testing' stamp: 'DB 11/1/2020 21:03:47'!
chipXIsInPosition: aPosition

	^chipsX includes: aPosition.! !


!TerniLapilli methodsFor: 'winning' stamp: 'DB 11/1/2020 22:12:18'!
hasPlayerOWon
	^(self wonHorizontal: chipsO) or: (self wonVertical: chipsO) or: (self wonDiagonal: chipsO)! !

!TerniLapilli methodsFor: 'winning' stamp: 'DB 11/1/2020 21:51:39'!
hasPlayerXWon
	^(self wonHorizontal: chipsX) or: (self wonVertical: chipsX) or: (self wonDiagonal: chipsX)
	
		! !

!TerniLapilli methodsFor: 'winning' stamp: 'DB 11/1/2020 21:55:33'!
wonDiagonal: Positions
	^(self wonFallingDiagonal: Positions) or: (self wonUpwardsDiagonal: Positions ).! !

!TerniLapilli methodsFor: 'winning' stamp: 'DB 11/1/2020 22:11:28'!
wonFallingDiagonal: Positions

	| fallingDiagonal |
	fallingDiagonal := OrderedCollection with: (0@0) with: (1@1) with: (2@2).

	^Positions includesAllOf: fallingDiagonal.
	! !

!TerniLapilli methodsFor: 'winning' stamp: 'DB 11/1/2020 21:38:39'!
wonHorizontal: positions
	^(positions size = 3) and: (positions allSatisfy: [:aPosition | (aPosition x) = ((positions first) x)]).
	
	
	! !

!TerniLapilli methodsFor: 'winning' stamp: 'DB 11/1/2020 22:13:34'!
wonUpwardsDiagonal: Positions
 
	| upwardsDiagonal |
	upwardsDiagonal := OrderedCollection with: (2@0) with: (1@1) with: (0@2).
	
	^Positions includesAllOf: upwardsDiagonal .! !

!TerniLapilli methodsFor: 'winning' stamp: 'DB 11/1/2020 21:46:33'!
wonVertical: positions

	^(positions size = 3) and: (positions allSatisfy: [:aPosition | (aPosition y) = ((positions first) y)]).
	
	! !


!TerniLapilli methodsFor: 'comparing' stamp: 'DB 11/1/2020 21:14:18'!
isAnEmptyPosition: aPoint 
	^ ((chipsX includes: aPoint) or: (chipsO includes: aPoint)) not
! !

!TerniLapilli methodsFor: 'comparing' stamp: 'DB 11/2/2020 14:12:51'!
isBoardFull
	^(chipsX size = 3) and: (chipsO size = 3)! !

!TerniLapilli methodsFor: 'comparing' stamp: 'DB 10/29/2020 20:28:51'!
isEmpty
	^(chipsX isEmpty) and: (chipsO isEmpty)! !

!TerniLapilli methodsFor: 'comparing' stamp: 'DB 11/2/2020 03:22:22'!
isPlayingO
	^turn even.! !

!TerniLapilli methodsFor: 'comparing' stamp: 'DB 11/2/2020 03:22:18'!
isPlayingX
	^turn odd.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: 'Terni Lapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'signals' stamp: 'DB 11/2/2020 02:36:54'!
signalCantDoInvalidDiagonalMovement

	self error: self cantDoInvalidDiagonalMovement.! !

!TerniLapilli class methodsFor: 'signals' stamp: 'DB 11/2/2020 02:37:17'!
signalCantMoveAnEmptyPosition

	self error: self cantMoveAnEmptyPosition.! !

!TerniLapilli class methodsFor: 'signals' stamp: 'DB 11/2/2020 02:43:15'!
signalCantMoveIfInPuttingPhase

	self error: self cantMoveIfInPuttingPhase .! !

!TerniLapilli class methodsFor: 'signals' stamp: 'DB 11/2/2020 02:37:33'!
signalCantMoveMoreThanOnePositionAtATime

	self error: self cantMoveMoreThanOnePositionAtATime.! !

!TerniLapilli class methodsFor: 'signals' stamp: 'DB 11/2/2020 02:37:47'!
signalCantMoveOrPutChipOutOfBounds

	self error: self 	cantMoveOrPutChipOutOfBounds.! !

!TerniLapilli class methodsFor: 'signals' stamp: 'DB 11/2/2020 02:38:02'!
signalCantPutIfInMovingPhase

	self error: self cantPutIfInMovingPhase .! !

!TerniLapilli class methodsFor: 'signals' stamp: 'DB 11/2/2020 02:39:02'!
signalErrorInvalidMoveCantPutChipOnOccupiedSlot

	self error: self invalidMoveCantPutChipOnOccupiedSlot .! !

!TerniLapilli class methodsFor: 'signals' stamp: 'DB 11/2/2020 02:39:32'!
signalErrorInvalidMoveCantPutChipWhenGameIsOver

	self error: self invalidMoveCantPutChipWhenGameIsOver .! !

!TerniLapilli class methodsFor: 'signals' stamp: 'DB 11/2/2020 02:39:52'!
signalErrorInvalidMoveNotYourTurn

	self error: self invalidMoveNotYourTurn .! !

!TerniLapilli class methodsFor: 'signals' stamp: 'DB 11/2/2020 02:38:23'!
signalGameIsOver

	self error: self gameIsOver.! !

!TerniLapilli class methodsFor: 'signals' stamp: 'DB 11/2/2020 02:39:52'!
signalInvalidMoveNotYourTurn

	self error: self invalidMoveNotYourTurn ! !


!TerniLapilli class methodsFor: 'error messages' stamp: 'DB 11/2/2020 02:36:54'!
cantDoInvalidDiagonalMovement
	^'You cant do invalidad diagonal movement'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'DB 11/2/2020 02:37:17'!
cantMoveAnEmptyPosition
	^'You cant move an empty position'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'DB 11/2/2020 02:42:54'!
cantMoveIfInPuttingPhase
	^'you cant move if in Moving phase'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'DB 11/2/2020 02:37:33'!
cantMoveMoreThanOnePositionAtATime
	^'You cant move more than one position at a time'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'DB 11/2/2020 02:37:47'!
cantMoveOrPutChipOutOfBounds
	^'You cant move or put a chip out of bounds'
! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'DB 11/2/2020 02:38:02'!
cantPutIfInMovingPhase
	^'you cant put if in Moving phase'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'DB 11/2/2020 02:38:23'!
gameIsOver
	^'Cant continue playing because the game is over!!!!!!'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'DB 11/2/2020 02:39:02'!
invalidMoveCantPutChipOnOccupiedSlot
	^'Cant put chip in an occupied slot'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'DB 11/2/2020 02:39:32'!
invalidMoveCantPutChipWhenGameIsOver

	^'Cant put chip because the game is already over'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'DB 11/2/2020 02:39:52'!
invalidMoveNotYourTurn

	^'It must be your turn to be able to move or put down a chip'.! !


!classDefinition: #TerniLapilliPhase category: 'Terni Lapilli'!
Object subclass: #TerniLapilliPhase
	instanceVariableNames: 'terniLapilliGame'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliPhase methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 02:47:10'!
assertMove

	self subclassResponsibility ! !

!TerniLapilliPhase methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 02:49:02'!
assertPut

	self subclassResponsibility ! !

!TerniLapilliPhase methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 00:06:14'!
initializeFor: aTerniLapilliGame
	terniLapilliGame := aTerniLapilliGame 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliPhase class' category: 'Terni Lapilli'!
TerniLapilliPhase class
	instanceVariableNames: ''!

!TerniLapilliPhase class methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 00:03:19'!
canHandle: aTerniLapilliGame
	self subclassResponsibility ! !

!TerniLapilliPhase class methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 00:03:44'!
for: aTerniLapilliGame
	^self new initializeFor: aTerniLapilliGame ! !

!TerniLapilliPhase class methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 00:04:57'!
stateFor: aTerniLapilliGame
	^(self subclasses detect: [:aTerniLapilliPhaseClass | aTerniLapilliPhaseClass canHandle: aTerniLapilliGame ]) for: aTerniLapilliGame.! !


!classDefinition: #TerniLapilliGameOverPhase category: 'Terni Lapilli'!
TerniLapilliPhase subclass: #TerniLapilliGameOverPhase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliGameOverPhase methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 02:47:10'!
assertMove
	^terniLapilliGame class signalGameIsOver ! !

!TerniLapilliGameOverPhase methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 02:49:02'!
assertPut
	^terniLapilliGame class signalGameIsOver ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliGameOverPhase class' category: 'Terni Lapilli'!
TerniLapilliGameOverPhase class
	instanceVariableNames: ''!

!TerniLapilliGameOverPhase class methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 00:07:17'!
canHandle: aTerniLapilliGame
	^aTerniLapilliGame isGameOver ! !


!classDefinition: #TerniLapilliMovingPhase category: 'Terni Lapilli'!
TerniLapilliPhase subclass: #TerniLapilliMovingPhase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliMovingPhase methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 02:47:10'!
assertMove
	
! !

!TerniLapilliMovingPhase methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 02:49:02'!
assertPut
	^terniLapilliGame class signalCantPutIfInMovingPhase 
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliMovingPhase class' category: 'Terni Lapilli'!
TerniLapilliMovingPhase class
	instanceVariableNames: ''!

!TerniLapilliMovingPhase class methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 00:08:00'!
canHandle: aTerniLapilliGame
	^aTerniLapilliGame isMovingPhase ! !


!classDefinition: #TerniLapilliPuttingPhase category: 'Terni Lapilli'!
TerniLapilliPhase subclass: #TerniLapilliPuttingPhase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliPuttingPhase methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 02:47:10'!
assertMove

	terniLapilliGame class signalCantMoveIfInPuttingPhase 
! !

!TerniLapilliPuttingPhase methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 02:49:02'!
assertPut
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliPuttingPhase class' category: 'Terni Lapilli'!
TerniLapilliPuttingPhase class
	instanceVariableNames: ''!

!TerniLapilliPuttingPhase class methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 00:08:15'!
canHandle: aTerniLapilliGame
	^aTerniLapilliGame isPuttingPhase ! !


!classDefinition: #TerniLapilliPlayer category: 'Terni Lapilli'!
Object subclass: #TerniLapilliPlayer
	instanceVariableNames: 'terniLapilliGame'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliPlayer methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 03:41:04'!
assertCorrectTurn: aSourcePosition
	self subclassResponsibility ! !

!TerniLapilliPlayer methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 03:46:03'!
initializeFor: aTerniLapilliGame
	terniLapilliGame := aTerniLapilliGame 
	! !

!TerniLapilliPlayer methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 03:37:06'!
moveFrom: aSourcePosition to: aDestinationPosition
	self subclassResponsibility ! !

!TerniLapilliPlayer methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 03:36:05'!
put: aPosition
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliPlayer class' category: 'Terni Lapilli'!
TerniLapilliPlayer class
	instanceVariableNames: ''!

!TerniLapilliPlayer class methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 03:30:07'!
canHandle: aTerniLapilliGame
	self subclassResponsibility ! !

!TerniLapilliPlayer class methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 03:31:26'!
for: aTerniLapilliGame
	^self new initializeFor: aTerniLapilliGame ! !

!TerniLapilliPlayer class methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 03:31:56'!
stateFor: aTerniLapilliGame
	^(self subclasses detect: [:aTerniLapilliPhaseClass | aTerniLapilliPhaseClass canHandle: aTerniLapilliGame ]) for: aTerniLapilliGame.! !


!classDefinition: #TerniLapilliPlayerO category: 'Terni Lapilli'!
TerniLapilliPlayer subclass: #TerniLapilliPlayerO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliPlayerO methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 03:47:37'!
assertCorrectTurn: aSourcePosition
	terniLapilliGame assertCorrectTurnWhenItIsPlayerOsTurn: aSourcePosition 
! !

!TerniLapilliPlayerO methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 03:52:05'!
moveFrom: aSourcePosition to: aDestinationPosition
	 terniLapilliGame moveWhenItIsPlayerOsTurn: aSourcePosition to: aDestinationPosition ! !

!TerniLapilliPlayerO methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 03:39:11'!
put: aPosition
	terniLapilliGame putOAt: aPosition
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliPlayerO class' category: 'Terni Lapilli'!
TerniLapilliPlayerO class
	instanceVariableNames: ''!

!TerniLapilliPlayerO class methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 03:30:27'!
canHandle: aTerniLapilliGame

	^aTerniLapilliGame isPlayingO 
	! !


!classDefinition: #TerniLapilliPlayerX category: 'Terni Lapilli'!
TerniLapilliPlayer subclass: #TerniLapilliPlayerX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliPlayerX methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 03:47:06'!
assertCorrectTurn: aSourcePosition
	 terniLapilliGame assertCorrectTurnWhenItIsPlayerXsTurn: aSourcePosition ! !

!TerniLapilliPlayerX methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 03:52:33'!
moveFrom: aSourcePosition to: aDestinationPosition
	  terniLapilliGame moveWhenItIsPlayerXsTurn: aSourcePosition to: aDestinationPosition ! !

!TerniLapilliPlayerX methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 03:36:20'!
put: aPosition
	terniLapilliGame putXAt: aPosition
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliPlayerX class' category: 'Terni Lapilli'!
TerniLapilliPlayerX class
	instanceVariableNames: ''!

!TerniLapilliPlayerX class methodsFor: 'as yet unclassified' stamp: 'DB 11/2/2020 03:31:08'!
canHandle: aTerniLapilliGame
	^aTerniLapilliGame isPlayingX ! !
