!classDefinition: #TerniLapilliTest category: 'Terni Lapilli'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliTest methodsFor: 'instance terni lapilli' stamp: 'AM 11/1/2020 17:21:44'!
addAsMoves: aCollectionOfMoves to: aTerniLapilli

	1 to: aCollectionOfMoves size do: [: indexOfMoving | | fromCell toCell |
			fromCell :=  (aCollectionOfMoves at: indexOfMoving) first.
			toCell := (aCollectionOfMoves at: indexOfMoving) second.
			indexOfMoving even ifTrue: [aTerniLapilli moveAnOFrom: fromCell to:  toCell] 
				ifFalse: [aTerniLapilli moveAnXFrom: fromCell to:  toCell].
		].
	
	^aTerniLapilli
	
	
	
	! !

!TerniLapilliTest methodsFor: 'instance terni lapilli' stamp: 'AM 11/1/2020 17:06:37'!
addAsPlaces: aCollectionOfPlaces to: aTerniLapilli
	
	1 to: aCollectionOfPlaces size do: [:indexOfPlacing | | cellToPlace |
			cellToPlace := aCollectionOfPlaces at: indexOfPlacing.
			indexOfPlacing even ifTrue: [aTerniLapilli placeOAt: cellToPlace ] 
				ifFalse: [aTerniLapilli placeXAt: cellToPlace ].
		].
	^aTerniLapilli
	
	
	
	! !

!TerniLapilliTest methodsFor: 'instance terni lapilli' stamp: 'AM 11/1/2020 17:27:41'!
terniLapilliWithPlaces: aCollectionOfPlaces andMoves: aCollectionOfMoves

	| board |
	
	board := TerniLapilli new.
	
	board := self addAsPlaces: aCollectionOfPlaces to: board .
	board := self addAsMoves: aCollectionOfMoves to: board .
	
	^board
	
	
	
	! !


!TerniLapilliTest methodsFor: 'testing cells' stamp: 'AM 11/1/2020 17:27:43'!
test04PlayersShouldNotPlayOnOccupiedCell
	
	| boardTerniLapilli |
	
	boardTerniLapilli := self terniLapilliWithPlaces: { 1@1 } andMoves: { } .
	
	self should: [ boardTerniLapilli placeOAt: 1@1 ]
		raise: Error
		withMessageText: boardTerniLapilli class canNotPlaceChipInOccupiedCellErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing cells' stamp: 'AM 11/1/2020 17:27:43'!
test05ShouldNotPlaceAChipToTheRightOfTheBoard
	
	| boardTerniLapilli |
	
	boardTerniLapilli := self terniLapilliWithPlaces: {} andMoves: {}.
	self should: [boardTerniLapilli placeXAt: 4@2 ]
		raise: Error
		withMessageText: boardTerniLapilli class cellIsOutOfBoundsErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing cells' stamp: 'AM 11/1/2020 17:27:45'!
test07ShouldNotPlaceAChipToTheLeftOfTheBoard
	
	| boardTerniLapilli |
	
	boardTerniLapilli := self terniLapilliWithPlaces: {} andMoves: {}.
	self should: [boardTerniLapilli placeXAt: 0@2 ]
		raise: Error
		withMessageText: boardTerniLapilli class cellIsOutOfBoundsErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing cells' stamp: 'AM 11/1/2020 17:27:42'!
test09ShouldNotPlaceAChipBelowTheBoard
	
	| boardTerniLapilli |
	
	boardTerniLapilli := self terniLapilliWithPlaces: {} andMoves: {}.
	self should: [boardTerniLapilli placeXAt: 2@0 ]
		raise: Error
		withMessageText: boardTerniLapilli class cellIsOutOfBoundsErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing cells' stamp: 'AM 11/1/2020 17:27:42'!
test11ShouldNotPlaceAChipAboveTheBoard
	
	| boardTerniLapilli |
	
	boardTerniLapilli := self terniLapilliWithPlaces: {} andMoves: {}.
	self should: [boardTerniLapilli placeXAt: 2@4 ]
		raise: Error
		withMessageText: boardTerniLapilli class cellIsOutOfBoundsErrorDescription.! !


!TerniLapilliTest methodsFor: 'testing game over' stamp: 'AM 11/1/2020 17:27:45'!
test17InitialGameIsNotOver
	
	| boardTerniLapilli |
	
	boardTerniLapilli := self terniLapilliWithPlaces: {} andMoves: {}.
	self deny: boardTerniLapilli isOver.! !

!TerniLapilliTest methodsFor: 'testing game over' stamp: 'AM 11/1/2020 17:27:43'!
test18FirstRowForXIsWinningGame
	
	| boardTerniLapilli |
	
	boardTerniLapilli := self terniLapilliWithPlaces: { 1@1. 1@2. 2@1. 1@3. 3@1} andMoves: {}.
	
	self assert: boardTerniLapilli isOver.! !

!TerniLapilliTest methodsFor: 'testing game over' stamp: 'AM 11/1/2020 17:27:42'!
test19FirstColumnForOIsWinningGame
	
	| boardTerniLapilli |
	
	boardTerniLapilli := self terniLapilliWithPlaces: {2@3. 1@2. 2@2. 1@3. 3@2. 1@1} andMoves: {}.
	
	self assert: boardTerniLapilli isOver.! !

!TerniLapilliTest methodsFor: 'testing game over' stamp: 'AM 11/1/2020 17:27:45'!
test31XShouldBeDeclaredWinnerIfThreeChipsAligned

	| boardTerniLapilli |
	
	boardTerniLapilli := self terniLapilliWithPlaces: {3@2. 1@1. 2@2. 1@3. 2@3. 1@2} andMoves: {}.
		
	self assert: boardTerniLapilli hasOAlreadyWon.
		
	
	
	
	
	! !


!TerniLapilliTest methodsFor: 'testing placing' stamp: 'AM 11/1/2020 17:27:44'!
test01FirstPlayerIsX
	
	| boardTerniLapilli |
	
	boardTerniLapilli := self terniLapilliWithPlaces: {} andMoves: {}.
	
	self assert: boardTerniLapilli isXPlayingNext.
	self deny: boardTerniLapilli isOPlayingNext.! !

!TerniLapilliTest methodsFor: 'testing placing' stamp: 'AM 11/1/2020 17:27:45'!
test02SecondPlayerIsO
	
	| boardTerniLapilli |
	
	boardTerniLapilli := self terniLapilliWithPlaces: {1@1} andMoves: {}.
	
	self deny: boardTerniLapilli isXPlayingNext.
	self assert: boardTerniLapilli isOPlayingNext.! !

!TerniLapilliTest methodsFor: 'testing placing' stamp: 'AM 11/1/2020 17:27:45'!
test03ThirdPlayerIsX
	
	| boardTerniLapilli |
	
	boardTerniLapilli := self terniLapilliWithPlaces: {1@1. 2@1} andMoves: {}.
	
	self assert: boardTerniLapilli isXPlayingNext.
	self deny: boardTerniLapilli isOPlayingNext.! !

!TerniLapilliTest methodsFor: 'testing placing' stamp: 'AM 11/1/2020 17:11:36'!
test13OShouldNotPlaceWhenItsXsTurn
	
	| boardTerniLapilli |
	
	boardTerniLapilli := TerniLapilli new.
	
	self should: [boardTerniLapilli placeOAt: 2@2.]
		raise: Error
		withMessageText: boardTerniLapilli class canNotPlayOnOtherPlayersTurnErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing placing' stamp: 'AM 11/1/2020 17:27:44'!
test21ShouldNotPlaceWhenGameIsOver
	
	| boardTerniLapilli |
	
	boardTerniLapilli := self terniLapilliWithPlaces: {1@1. 1@2. 2@1. 1@3. 3@1} andMoves: {}.
	
	self should: [boardTerniLapilli placeOAt: 2@2]
		raise: Error
		withMessageText: boardTerniLapilli class canNotPlayWhenGameIsAlreadyOverErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing placing' stamp: 'AM 11/1/2020 17:27:42'!
test30PlayerShouldNotPlaceAfterPlacingThreeChips
	| boardTerniLapilli |
	
	boardTerniLapilli := self terniLapilliWithPlaces: {2@1. 3@1. 1@2. 2@2. 3@2. 1@1} andMoves: {}.
	
	self should: [ boardTerniLapilli placeXAt: 2@3.]
		raise: Error
		withMessageText: boardTerniLapilli class canNotPlaceAChipAfterPlacingThreeChipsErrorDescription.! !


!TerniLapilliTest methodsFor: 'testing moving' stamp: 'AM 11/1/2020 15:24:57'!
test15PlayerShouldNotMoveBeforePlacingThreeChips
	
	| boardTerniLapilli |
	
	boardTerniLapilli := TerniLapilli new.
	self should: [ boardTerniLapilli moveAnXFrom: 2@2 to: 1@2.]
		raise: Error
		withMessageText: boardTerniLapilli class canNotMoveAChipBeforePlacingTheThreeChipsErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing moving' stamp: 'AM 11/1/2020 17:27:42'!
test20ShouldNotMoveChipToOccupiedCell	
	| boardTerniLapilli |
	
	boardTerniLapilli := self terniLapilliWithPlaces: {1@1. 2@1. 3@1. 1@2. 2@2. 3@2} andMoves: {}.
	
	self should: [ boardTerniLapilli moveAnXFrom: 2@2 to: 1@2.]
		raise: Error
		withMessageText: boardTerniLapilli class canNotPlaceChipInOccupiedCellErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing moving' stamp: 'AM 11/1/2020 17:27:43'!
test22GameIsOverAfterOMoves
	
	| boardTerniLapilli |
	
	boardTerniLapilli := self terniLapilliWithPlaces: {1@1. 1@2. 1@3. 2@2. 2@3. 3@1} andMoves: {{2@3. 3@3}. {3@1. 3@2}}.
	
	self assert: boardTerniLapilli isOver.
		! !

!TerniLapilliTest methodsFor: 'testing moving' stamp: 'AM 11/1/2020 17:27:44'!
test23ShouldNotMoveWhenGameIsOver
	
	| boardTerniLapilli |
	
	boardTerniLapilli := self terniLapilliWithPlaces: {2@3. 1@2. 2@1. 1@3. 3@2. 1@1} andMoves: {}.
	
	self should: [boardTerniLapilli moveAnXFrom: 3@2 to: 2@2]
		raise: Error
		withMessageText: boardTerniLapilli class canNotPlayWhenGameIsAlreadyOverErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing moving' stamp: 'AM 11/1/2020 17:27:41'!
test24AfterAMovingOperationOfXIsOTurn
	
	| boardTerniLapilli |
	
	boardTerniLapilli := self terniLapilliWithPlaces: {1@1. 2@1. 3@1. 1@2. 2@2. 3@2} andMoves: {{2@2. 2@3}}.
	
	self deny: boardTerniLapilli isXPlayingNext.
	self assert: boardTerniLapilli isOPlayingNext.! !

!TerniLapilliTest methodsFor: 'testing moving' stamp: 'AM 11/1/2020 17:27:44'!
test25MovingOperationDoesNotAllowPlayingOnOthersTurn
	
	| boardTerniLapilli |
	
	boardTerniLapilli := self terniLapilliWithPlaces: {1@1. 2@1. 3@1. 1@2. 2@2. 3@2} andMoves: {}.
	
	self should: [boardTerniLapilli moveAnOFrom: 3@2 to: 2@3]
		raise: Error
		withMessageText: boardTerniLapilli class canNotPlayOnOtherPlayersTurnErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing moving' stamp: 'AM 11/1/2020 17:27:41'!
test26APlayerShouldNotMoveFromACellWithoutAChipOfItsOwnership
	| boardTerniLapilli |
	
	boardTerniLapilli := self terniLapilliWithPlaces: {1@1. 2@1. 3@1. 1@2. 2@2. 3@2} andMoves: {}.
	
	self should: [ boardTerniLapilli moveAnXFrom: 3@3 to: 2@3.]
		raise: Error
		withMessageText: boardTerniLapilli class canNotMoveFromACellWithoutAChipOfItsOwnershipErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing moving' stamp: 'AM 11/1/2020 17:27:43'!
test27PlayerShouldNotMoveChipToNonAdjacentCell
	| boardTerniLapilli |
	
	boardTerniLapilli := self terniLapilliWithPlaces: {1@1. 2@1. 3@1. 1@2. 2@2. 3@2} andMoves: {}.
	
	self should: [ boardTerniLapilli moveAnXFrom: 3@1 to: 3@3.]
		raise: Error
		withMessageText: boardTerniLapilli class canNotMoveChipToNonAdjacentCellErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing moving' stamp: 'AM 11/1/2020 17:27:41'!
test28PlayerShouldNotMoveDiagonallyOutsideMainDiagonals
	| boardTerniLapilli |

	boardTerniLapilli := self terniLapilliWithPlaces: {2@1. 3@1. 1@2. 2@2. 3@2. 1@1} andMoves: {}.
	
	self should: [ boardTerniLapilli moveAnXFrom: 3@2 to: 2@3.]
		raise: Error
		withMessageText: boardTerniLapilli class canNotMoveChipToNonAdjacentCellErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing moving' stamp: 'AM 11/1/2020 17:27:44'!
test29PlayerShouldBeAbleToMoveAlongMainDiagonals
	| boardTerniLapilli |
	
	boardTerniLapilli := self terniLapilliWithPlaces: {3@1. 2@1. 3@2. 1@2. 2@2. 1@1} andMoves: {}.
		
	self shouldnt: [ boardTerniLapilli moveAnXFrom: 2@2 to: 3@3.] 
		raise: Error.
	! !


!classDefinition: #TerniLapilli category: 'Terni Lapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'nextPlayer waitingPlayer cells state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilli methodsFor: 'assertions' stamp: 'NNH 11/1/2020 20:24:26'!
assertThatCellCanBeOccupied: aCell by: aPlayerWantingToPlay
	self assertThatIsWithinBoardLimits: aCell.
	self assertThatItsTheTurnOf: aPlayerWantingToPlay.
	self assertThatIsNotAlreadyOccupied: aCell.! !

!TerniLapilli methodsFor: 'assertions' stamp: 'AM 11/1/2020 15:07:14'!
assertThatIsNotAlreadyOccupied: aCell

	^ (((cells at: #X) includes: aCell)
		or: [(cells at: #O) includes: aCell]) 
		ifTrue: [ self signalCanNotPlaceChipInOccupiedCell ]! !

!TerniLapilli methodsFor: 'assertions' stamp: 'AM 11/1/2020 15:05:15'!
assertThatIsWithinBoardLimits: aCell

	^ (self isWithinBoardLimits: aCell) ifFalse: [ self signalCellIsOutOfBounds ]! !

!TerniLapilli methodsFor: 'assertions' stamp: 'AM 11/1/2020 15:06:47'!
assertThatItsTheTurnOf: aPlayerWantingToPlay

	^ nextPlayer = aPlayerWantingToPlay ifFalse: [ self signalCanNotPlayOnOtherPlayersTurn ]! !

!TerniLapilli methodsFor: 'assertions' stamp: 'AM 11/1/2020 16:03:35'!
assertThatMovementIsValidFrom: anOccupiedCell to: aFreeCell
	((self is: aFreeCell adjacentTo: anOccupiedCell ) 	
		and: [  (self isInAMainDiagonal: anOccupiedCell) or: [self isInAMainDiagonal: aFreeCell] ]) 
			ifFalse: [self signalCanNotMoveChipToNonAdjacentCell ].
! !


!TerniLapilli methodsFor: 'board plays' stamp: 'AM 11/1/2020 16:32:26'!
moveAnOFrom: anOccupiedCell to: aFreeCell

	state moveFrom: anOccupiedCell to: aFreeCell by: #O.! !

!TerniLapilli methodsFor: 'board plays' stamp: 'AM 11/1/2020 16:32:33'!
moveAnXFrom: anOccupiedCell to: aFreeCell

	state moveFrom: anOccupiedCell to: aFreeCell by: #X.! !

!TerniLapilli methodsFor: 'board plays' stamp: 'NNH 11/1/2020 20:24:26'!
moveFrom: anOccupiedCell to: aFreeCell by: aPlayerWantingToPlay

	self assertThatCellCanBeOccupied: aFreeCell by: aPlayerWantingToPlay.
	self assertThatMovementIsValidFrom: anOccupiedCell to: aFreeCell .
	
	(cells at: aPlayerWantingToPlay ) remove: anOccupiedCell 
		ifAbsent: [self signalCanNotMoveFromACellWithoutAChipOfItsOwnership ].
	(cells at: aPlayerWantingToPlay) add: aFreeCell .
	
	self updateState.
! !

!TerniLapilli methodsFor: 'board plays' stamp: 'NNH 11/1/2020 20:24:26'!
placeAt: aCell by: aPlayerWantingToPlay

	self assertThatCellCanBeOccupied: aCell by: aPlayerWantingToPlay.
	
	(cells at: aPlayerWantingToPlay) add: aCell.
	self updateState.! !

!TerniLapilli methodsFor: 'board plays' stamp: 'AM 11/1/2020 16:24:30'!
placeOAt: aCell 

	state placeAt: aCell by: #O.! !

!TerniLapilli methodsFor: 'board plays' stamp: 'AM 11/1/2020 16:24:36'!
placeXAt: aCell 

	state placeAt: aCell by: #X.
! !


!TerniLapilli methodsFor: 'error signals' stamp: 'AM 11/1/2020 15:02:46'!
signalCanNotMoveAChipBeforePlacingTheThreeChips
	self error: self class canNotMoveAChipBeforePlacingTheThreeChipsErrorDescription ! !

!TerniLapilli methodsFor: 'error signals' stamp: 'AM 11/1/2020 14:57:39'!
signalCanNotMoveChipToNonAdjacentCell

	^ self error: self class canNotMoveChipToNonAdjacentCellErrorDescription! !

!TerniLapilli methodsFor: 'error signals' stamp: 'AM 11/1/2020 16:23:20'!
signalCanNotMoveFromACellWithoutAChipOfItsOwnership

	^ self error: self class canNotMoveFromACellWithoutAChipOfItsOwnershipErrorDescription! !

!TerniLapilli methodsFor: 'error signals' stamp: 'AM 11/1/2020 15:01:31'!
signalCanNotPlaceAChipAfterPlacingThreeChips
	self error: self class canNotPlaceAChipAfterPlacingThreeChipsErrorDescription! !

!TerniLapilli methodsFor: 'error signals' stamp: 'AM 11/1/2020 14:54:33'!
signalCanNotPlaceChipInOccupiedCell

	^ self error: self class canNotPlaceChipInOccupiedCellErrorDescription! !

!TerniLapilli methodsFor: 'error signals' stamp: 'AM 11/1/2020 14:59:47'!
signalCanNotPlayOnOtherPlayersTurn

	^ self error: self class canNotPlayOnOtherPlayersTurnErrorDescription! !

!TerniLapilli methodsFor: 'error signals' stamp: 'AM 11/1/2020 15:00:11'!
signalCanNotPlayWhenGameIsAlreadyOver

	^ self 	error: self class canNotPlayWhenGameIsAlreadyOverErrorDescription 
! !

!TerniLapilli methodsFor: 'error signals' stamp: 'AM 11/1/2020 14:53:48'!
signalCellIsOutOfBounds

	^ self error: self class cellIsOutOfBoundsErrorDescription! !


!TerniLapilli methodsFor: 'initializing' stamp: 'NNH 11/1/2020 20:55:25'!
initialize
	
	cells := Dictionary new.
	cells add: #X -> OrderedCollection new; add: #O -> OrderedCollection new.
	
	nextPlayer := #X.
	waitingPlayer := #O.
	
	state := TerniLapilliState for: self.! !


!TerniLapilli methodsFor: 'state update' stamp: 'AM 11/1/2020 15:18:49'!
changeTurns
	
	| temporaryPlayer |
	
	temporaryPlayer := nextPlayer.
	nextPlayer := waitingPlayer.
	waitingPlayer  := temporaryPlayer.! !

!TerniLapilli methodsFor: 'state update' stamp: 'NNH 11/1/2020 20:36:43'!
updateState

	state := TerniLapilliState for: self.
	self changeTurns ! !


!TerniLapilli methodsFor: 'testing' stamp: 'AM 11/1/2020 16:00:19'!
hasOAlreadyWon
	^self hasAlreadyWon: #O! !

!TerniLapilli methodsFor: 'testing' stamp: 'AM 11/1/2020 16:00:05'!
hasXAlreadyWon
	^self hasAlreadyWon: #X! !

!TerniLapilli methodsFor: 'testing' stamp: 'AM 10/31/2020 10:18:00'!
isOPlayingNext
	^nextPlayer = #O! !

!TerniLapilli methodsFor: 'testing' stamp: 'AM 10/30/2020 21:12:37'!
isOver
	
	^ state isOver! !

!TerniLapilli methodsFor: 'testing' stamp: 'AM 10/31/2020 10:32:15'!
isXPlayingNext
	^nextPlayer = #X! !


!TerniLapilli methodsFor: 'testing cells -- private' stamp: 'AM 11/1/2020 16:05:09'!
is: aCell adjacentTo: anotherCell

	^ aCell eightNeighbors includes: anotherCell! !

!TerniLapilli methodsFor: 'testing cells -- private' stamp: 'AM 11/1/2020 16:05:22'!
isInAMainDiagonal: aCell

	^ (aCell x + aCell y) even! !

!TerniLapilli methodsFor: 'testing cells -- private' stamp: 'AM 11/1/2020 16:05:35'!
isWithinBoardLimits: aCell

	^((aCell x) between: 1 and: 3) and: 
		[(aCell y) between: 1 and: 3]! !


!TerniLapilli methodsFor: 'testing players -- private' stamp: 'NNH 11/1/2020 20:53:06'!
hasAPlayerAlreadyWon

	^ self hasXAlreadyWon or: [self hasOAlreadyWon].! !

!TerniLapilli methodsFor: 'testing players -- private' stamp: 'AM 11/1/2020 15:59:53'!
hasAlreadyWon: aPlayer
	
	^ (((self hasPlayedThreeChips: aPlayer) and:
		[ self hasThreeAlignedChips: aPlayer ]))! !

!TerniLapilli methodsFor: 'testing players -- private' stamp: 'AM 10/31/2020 10:36:13'!
hasPlayedThreeChips: aPlayer

	^ (cells at: aPlayer) size = 3! !

!TerniLapilli methodsFor: 'testing players -- private' stamp: 'AM 11/1/2020 16:25:19'!
hasThreeAlignedChips: aPlayer

	^ ((cells at: aPlayer) allSatisfy: [:aCell | 3 * aCell ~= (cells at: aPlayer) sum ]) not! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: 'Terni Lapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'AM 10/29/2020 19:34:22'!
canNotMoveAChipBeforePlacingTheThreeChipsErrorDescription
	^ 'Can not move a chip before placing the three chips on the board'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'AM 10/31/2020 09:30:39'!
canNotMoveChipToNonAdjacentCellErrorDescription
	^'Can not move a chip to a non adjacent cell.'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'AM 11/1/2020 15:33:08'!
canNotMoveFromACellWithoutAChipOfItsOwnershipErrorDescription
	^'Can not move from a cell that does not have a chip belonging to you'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'AM 10/31/2020 10:31:34'!
canNotPlaceAChipAfterPlacingThreeChipsErrorDescription
	^'Can no place a chip after sixth turn.'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'AM 10/29/2020 18:44:59'!
canNotPlaceChipInOccupiedCellErrorDescription
	^ 'Chip can not be placed in an occupied cell.'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'AM 10/29/2020 19:18:09'!
canNotPlayOnOtherPlayersTurnErrorDescription
	^'Can not play when it is not your turn.'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'AM 10/30/2020 20:37:43'!
canNotPlayWhenGameIsAlreadyOverErrorDescription
	^'Can not play when game is already over.'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'AM 10/29/2020 19:00:08'!
cellIsOutOfBoundsErrorDescription
	^'Cell is out of the board'! !


!classDefinition: #TerniLapilliState category: 'Terni Lapilli'!
Object subclass: #TerniLapilliState
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliState methodsFor: 'board operations' stamp: 'AM 11/1/2020 16:30:33'!
moveFrom: anOccupiedCell to: aFreeCell by: aPlayerWantingToPlay
	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'board operations' stamp: 'AM 11/1/2020 16:30:12'!
placeAt: aCell by: aPlayerWantingToPlay
	self subclassResponsibility ! !


!TerniLapilliState methodsFor: 'initializing' stamp: 'NNH 11/1/2020 20:35:57'!
initializeFor: aTerniLapilli

	terniLapilli := aTerniLapilli.
! !


!TerniLapilliState methodsFor: 'testing' stamp: 'AM 11/1/2020 16:29:55'!
isOver
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliState class' category: 'Terni Lapilli'!
TerniLapilliState class
	instanceVariableNames: ''!

!TerniLapilliState class methodsFor: 'instance creation' stamp: 'NNH 11/1/2020 20:45:25'!
canHandle: aTerniLapilli
	
	self subclassResponsibility.! !

!TerniLapilliState class methodsFor: 'instance creation' stamp: 'NNH 11/1/2020 20:48:34'!
for: aTerniLapilli

	| subclass |
	
	subclass := self allSubclasses detect: [:aSubclass | aSubclass canHandle: aTerniLapilli ].
	
	^subclass new initializeFor: aTerniLapilli.
	! !


!classDefinition: #TerniLapilliStateGameOver category: 'Terni Lapilli'!
TerniLapilliState subclass: #TerniLapilliStateGameOver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliStateGameOver methodsFor: 'board operations' stamp: 'AM 11/1/2020 16:31:33'!
moveFrom: anOccupiedCell to: aFreeCell by: aPlayerWantingToPlay
	terniLapilli signalCanNotPlayWhenGameIsAlreadyOver.
! !

!TerniLapilliStateGameOver methodsFor: 'board operations' stamp: 'AM 11/1/2020 16:08:06'!
placeAt: aCell by: aPlayerWantingToPlayer
	terniLapilli signalCanNotPlayWhenGameIsAlreadyOver! !


!TerniLapilliStateGameOver methodsFor: 'testing' stamp: 'AM 10/30/2020 21:12:55'!
isOver
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliStateGameOver class' category: 'Terni Lapilli'!
TerniLapilliStateGameOver class
	instanceVariableNames: ''!

!TerniLapilliStateGameOver class methodsFor: 'instance creation' stamp: 'NNH 11/1/2020 20:53:06'!
canHandle: aTerniLapilli
	
	^ aTerniLapilli hasAPlayerAlreadyWon.! !


!classDefinition: #TerniLapilliStateMoving category: 'Terni Lapilli'!
TerniLapilliState subclass: #TerniLapilliStateMoving
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliStateMoving methodsFor: 'board operations' stamp: 'AM 11/1/2020 16:31:50'!
moveFrom: anOccupiedCell to: aFreeCell by: aPlayerWantingToPlay
	terniLapilli moveFrom: anOccupiedCell to: aFreeCell by: aPlayerWantingToPlay 
! !

!TerniLapilliStateMoving methodsFor: 'board operations' stamp: 'AM 11/1/2020 16:15:21'!
placeAt: aCell by: aPlayerWantingToPlay
	terniLapilli signalCanNotPlaceAChipAfterPlacingThreeChips 
! !


!TerniLapilliStateMoving methodsFor: 'testing' stamp: 'AM 10/30/2020 21:13:03'!
isOver
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliStateMoving class' category: 'Terni Lapilli'!
TerniLapilliStateMoving class
	instanceVariableNames: ''!

!TerniLapilliStateMoving class methodsFor: 'instance creation' stamp: 'NNH 11/1/2020 20:53:06'!
canHandle: aTerniLapilli

	^ (aTerniLapilli hasPlayedThreeChips: #O) and: [
		aTerniLapilli hasAPlayerAlreadyWon not
		]
	
	! !


!classDefinition: #TerniLapilliStatePlacing category: 'Terni Lapilli'!
TerniLapilliState subclass: #TerniLapilliStatePlacing
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliStatePlacing methodsFor: 'board operations' stamp: 'AM 11/1/2020 16:32:05'!
moveFrom: anOccupiedCell to: aFreeCell by: aPlayerWantingToPlayer
	terniLapilli signalCanNotMoveAChipBeforePlacingTheThreeChips
! !

!TerniLapilliStatePlacing methodsFor: 'board operations' stamp: 'AM 11/1/2020 16:09:29'!
placeAt: aCell by: aPlayerWantingToPlay
	terniLapilli placeAt: aCell by: aPlayerWantingToPlay ! !


!TerniLapilliStatePlacing methodsFor: 'testing' stamp: 'AM 10/30/2020 21:13:12'!
isOver
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliStatePlacing class' category: 'Terni Lapilli'!
TerniLapilliStatePlacing class
	instanceVariableNames: ''!

!TerniLapilliStatePlacing class methodsFor: 'instance creation' stamp: 'NNH 11/1/2020 20:53:06'!
canHandle: aTerniLapilli
	
	^ aTerniLapilli hasAPlayerAlreadyWon not and: [
		(aTerniLapilli hasPlayedThreeChips: #O) not]! !
