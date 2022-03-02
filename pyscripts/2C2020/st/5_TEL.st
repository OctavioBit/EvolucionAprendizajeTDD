!classDefinition: #TerniLapilliTest category: 'TerniLapilli'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: 'terniLapilliGame'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTest methodsFor: 'tests - placing validation' stamp: 'FR 11/1/2020 13:14:54'!
test03CantPlaceXOnPositionWithHorizontalValueTooLow
	
	terniLapilliGame := TerniLapilli new.
	
	self  should: [ terniLapilliGame placeXAt: 0@2 ]
		failWith: TerniLapilli targetPositionOutOfBoundariesErrorDescription.! !

!TerniLapilliTest methodsFor: 'tests - placing validation' stamp: 'FR 11/1/2020 13:15:21'!
test04CantPlaceOOnPositionWithHorizontalValueTooHigh
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 2@2.
	
	self  should: [ terniLapilliGame placeOAt: 4@2 ]
		failWith: TerniLapilli targetPositionOutOfBoundariesErrorDescription! !

!TerniLapilliTest methodsFor: 'tests - placing validation' stamp: 'FR 11/1/2020 13:15:31'!
test05CantPlaceXOnPositionWithVerticalValueTooLow
	
	terniLapilliGame := TerniLapilli new.
	
	self  should: [ terniLapilliGame placeXAt: 2@0 ]
		failWith: TerniLapilli targetPositionOutOfBoundariesErrorDescription! !

!TerniLapilliTest methodsFor: 'tests - placing validation' stamp: 'FR 11/1/2020 13:15:42'!
test06CantPlaceOOnPositionWithVerticalValueTooHigh
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 2@2.
	
	self  should: [ terniLapilliGame placeOAt: 2@4 ]
		failWith: TerniLapilli targetPositionOutOfBoundariesErrorDescription! !

!TerniLapilliTest methodsFor: 'tests - placing validation' stamp: 'FR 11/1/2020 13:15:50'!
test08CantPlaceOWhenXIsPlaying
	
	terniLapilliGame := TerniLapilli new.
		
	self  should: [ terniLapilliGame placeOAt: 2@2 ]
		failWith: TerniLapilli notYourTurnErrorDescription! !

!TerniLapilliTest methodsFor: 'tests - placing validation' stamp: 'FR 11/1/2020 13:16:00'!
test09CantPlaceXWhenOIsPlaying
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 2@2.
	
	self  should: [ terniLapilliGame placeXAt: 1@1 ]
		failWith: TerniLapilli notYourTurnErrorDescription! !

!TerniLapilliTest methodsFor: 'tests - placing validation' stamp: 'FR 11/1/2020 13:16:08'!
test10CantPlaceXOnOccupiedPosition
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 2@2.
	terniLapilliGame placeOAt: 1@1.

	self  should: [ terniLapilliGame placeXAt: 1@1 ]
		failWith: TerniLapilli positionOccupiedErrorDescription! !

!TerniLapilliTest methodsFor: 'tests - placing validation' stamp: 'FR 11/1/2020 13:16:16'!
test11CantPlaceOOnOccupiedPosition
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 2@2.

	self  should: [ terniLapilliGame placeOAt: 2@2 ]
		failWith: TerniLapilli positionOccupiedErrorDescription! !

!TerniLapilliTest methodsFor: 'tests - placing validation' stamp: 'FR 11/1/2020 13:16:30'!
test24CantPlaceMoreThanThreeXs
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 1@1.
	terniLapilliGame placeOAt: 3@3.
	terniLapilliGame placeXAt: 1@2.
	terniLapilliGame placeOAt: 3@2.
	terniLapilliGame placeXAt: 2@1.
	terniLapilliGame placeOAt: 2@3.
		
	self  should: [ 	terniLapilliGame placeXAt: 2@2. ]
		failWith: TerniLapilli noPiecesRemainingErrorDescription! !

!TerniLapilliTest methodsFor: 'tests - placing validation' stamp: 'FR 11/1/2020 13:16:37'!
test25CantPlaceMoreThanThreeOs
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 1@1.
	terniLapilliGame placeOAt: 3@3.
	terniLapilliGame placeXAt: 1@2.
	terniLapilliGame placeOAt: 3@2.
	terniLapilliGame placeXAt: 2@1.
	terniLapilliGame placeOAt: 2@3.
	
	terniLapilliGame moveXFrom: 1@2 to: 1@3.
	
	self  should: [ 	terniLapilliGame placeOAt: 2@2. ]
		failWith: TerniLapilli noPiecesRemainingErrorDescription! !


!TerniLapilliTest methodsFor: 'tests - moving functionality' stamp: 'FR 11/1/2020 13:16:53'!
test14OStartsPlayingAfterMovingX
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 1@1.
	terniLapilliGame placeOAt: 3@3.
	terniLapilliGame placeXAt: 1@2.
	terniLapilliGame placeOAt: 3@2.
	terniLapilliGame placeXAt: 2@1.
	terniLapilliGame placeOAt: 2@3.
	
	terniLapilliGame moveXFrom: 1@2 to: 1@3.
	
	self assertOIsPlaying! !

!TerniLapilliTest methodsFor: 'tests - moving functionality' stamp: 'FR 11/1/2020 13:17:24'!
test15XStartsPlayingAfterMovingO
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 1@1.
	terniLapilliGame placeOAt: 3@3.
	terniLapilliGame placeXAt: 1@2.
	terniLapilliGame placeOAt: 3@2.
	terniLapilliGame placeXAt: 2@1.
	terniLapilliGame placeOAt: 2@3.
	
	terniLapilliGame moveXFrom: 1@2 to: 1@3.
	terniLapilliGame moveOFrom: 3@2 to: 3@1.
	
	self assertXIsPlaying! !

!TerniLapilliTest methodsFor: 'tests - moving functionality' stamp: 'FR 11/1/2020 13:07:47'!
test28CanMoveXDiagonalToCenter
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 1@3.
	terniLapilliGame placeOAt: 1@2.
	terniLapilliGame placeXAt: 1@1.
	terniLapilliGame placeOAt: 2@1.
	terniLapilliGame placeXAt: 3@3.
	terniLapilliGame placeOAt: 3@1.
	
	self  shouldnt: [ terniLapilliGame moveXFrom: 1@1 to: 2@2. ]
		raise: Error.! !

!TerniLapilliTest methodsFor: 'tests - moving functionality' stamp: 'FR 11/1/2020 13:07:55'!
test29CanMoveODiagonalFromCenter
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 1@1.
	terniLapilliGame placeOAt: 1@2.
	terniLapilliGame placeXAt: 3@1.
	terniLapilliGame placeOAt: 2@1.
	terniLapilliGame placeXAt: 1@3.
	terniLapilliGame placeOAt: 2@2.
	
	terniLapilliGame moveXFrom: 1@3 to: 2@3.
	
	self  shouldnt: [ terniLapilliGame moveOFrom: 2@2 to: 3@3. ]
		raise: Error.! !

!TerniLapilliTest methodsFor: 'tests - moving functionality' stamp: 'FR 11/1/2020 13:08:06'!
test30MoveXIsDoneCorrectly
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 1@2.
	terniLapilliGame placeOAt: 1@1.
	terniLapilliGame placeXAt: 2@1.
	terniLapilliGame placeOAt: 1@3.
	terniLapilliGame placeXAt: 2@2.
	terniLapilliGame placeOAt: 3@1.
	
	terniLapilliGame moveXFrom: 2@2 to: 3@3. 
	
	self assert: (terniLapilliGame isOccupiedByX: 3@3).
	self deny: (terniLapilliGame isOccupiedByX: 2@2).! !

!TerniLapilliTest methodsFor: 'tests - moving functionality' stamp: 'FR 11/1/2020 13:08:17'!
test31MoveOIsDoneCorrectly
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 1@2.
	terniLapilliGame placeOAt: 1@1.
	terniLapilliGame placeXAt: 2@1.
	terniLapilliGame placeOAt: 1@3.
	terniLapilliGame placeXAt: 2@2.
	terniLapilliGame placeOAt: 3@1.
	
	terniLapilliGame moveXFrom: 2@2 to: 3@3. 
	terniLapilliGame moveOFrom: 1@3 to: 2@3. 

	self assert: (terniLapilliGame isOccupiedByO: 2@3).
	self deny: (terniLapilliGame isOccupiedByO: 1@3).! !


!TerniLapilliTest methodsFor: 'tests - moving validation' stamp: 'FR 11/1/2020 13:17:46'!
test12CantMoveXUntilMovingPhaseOfTheGameStarts
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 2@2.
	terniLapilliGame placeOAt: 1@1.
	
	self  should: [ terniLapilliGame moveXFrom: 2@2 to: 2@1]
		failWith: TerniLapilli cantMovePiecesYetErrorDescription! !

!TerniLapilliTest methodsFor: 'tests - moving validation' stamp: 'FR 11/1/2020 13:17:52'!
test13CantMoveOUntilMovingPhaseOfTheGameStarts
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 2@2.
	terniLapilliGame placeOAt: 1@1.
	terniLapilliGame placeXAt: 3@3.
	
	self  should: [ terniLapilliGame moveOFrom: 1@1 to: 1@2 ]
		failWith: TerniLapilli cantMovePiecesYetErrorDescription! !

!TerniLapilliTest methodsFor: 'tests - moving validation' stamp: 'FR 11/1/2020 13:17:58'!
test16CantMoveOWhenXIsPlaying
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 1@1.
	terniLapilliGame placeOAt: 3@3.
	terniLapilliGame placeXAt: 1@2.
	terniLapilliGame placeOAt: 3@2.
	terniLapilliGame placeXAt: 2@1.
	terniLapilliGame placeOAt: 2@3.
	
	self  should: [ terniLapilliGame moveOFrom: 3@2 to: 3@1 ]
		failWith: TerniLapilli notYourTurnErrorDescription! !

!TerniLapilliTest methodsFor: 'tests - moving validation' stamp: 'FR 11/1/2020 13:18:05'!
test17CantMoveXWhenOIsPlaying
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 1@1.
	terniLapilliGame placeOAt: 3@3.
	terniLapilliGame placeXAt: 1@2.
	terniLapilliGame placeOAt: 3@2.
	terniLapilliGame placeXAt: 2@1.
	terniLapilliGame placeOAt: 2@3.
	
	terniLapilliGame moveXFrom: 1@2 to: 1@3.
	
	self  should: [ terniLapilliGame moveXFrom: 2@1 to: 3@1 ]
		failWith: TerniLapilli notYourTurnErrorDescription! !

!TerniLapilliTest methodsFor: 'tests - moving validation' stamp: 'FR 11/1/2020 13:18:10'!
test18CantMoveXToPositionOutsideBoundaries
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 1@1.
	terniLapilliGame placeOAt: 3@3.
	terniLapilliGame placeXAt: 1@2.
	terniLapilliGame placeOAt: 3@2.
	terniLapilliGame placeXAt: 2@1.
	terniLapilliGame placeOAt: 2@3.
	
	self  should: [ terniLapilliGame moveXFrom: 1@1 to: 0@1. ]
		failWith: TerniLapilli targetPositionOutOfBoundariesErrorDescription! !

!TerniLapilliTest methodsFor: 'tests - moving validation' stamp: 'FR 11/1/2020 13:18:16'!
test19CantMoveOToPositionOutsideBoundaries
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 1@1.
	terniLapilliGame placeOAt: 3@3.
	terniLapilliGame placeXAt: 1@2.
	terniLapilliGame placeOAt: 3@2.
	terniLapilliGame placeXAt: 2@1.
	terniLapilliGame placeOAt: 2@3.
	
	terniLapilliGame moveXFrom: 1@2 to: 1@3.
	
	self  should: [ terniLapilliGame moveOFrom: 3@3 to: 4@3. ]
		failWith: TerniLapilli targetPositionOutOfBoundariesErrorDescription! !

!TerniLapilliTest methodsFor: 'tests - moving validation' stamp: 'FR 11/1/2020 13:18:24'!
test20CantMoveXToOccupiedPosition
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 1@1.
	terniLapilliGame placeOAt: 1@3.
	terniLapilliGame placeXAt: 1@2.
	terniLapilliGame placeOAt: 2@2.
	terniLapilliGame placeXAt: 2@1.
	terniLapilliGame placeOAt: 3@1.
	
	self  should: [ terniLapilliGame moveXFrom: 1@2 to: 1@3. ]
		failWith: TerniLapilli positionOccupiedErrorDescription! !

!TerniLapilliTest methodsFor: 'tests - moving validation' stamp: 'FR 11/1/2020 15:06:52'!
test21CantMoveOToOccupiedPosition
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 1@3.
	terniLapilliGame placeOAt: 1@1.
	terniLapilliGame placeXAt: 3@3.
	terniLapilliGame placeOAt: 1@2.
	terniLapilliGame placeXAt: 3@1.
	terniLapilliGame placeOAt: 2@1.
	
	terniLapilliGame moveXFrom: 3@3 to: 2@3.
	
	self  should: [ terniLapilliGame moveOFrom: 1@2 to: 1@3. ]
		failWith: TerniLapilli positionOccupiedErrorDescription! !

!TerniLapilliTest methodsFor: 'tests - moving validation' stamp: 'FR 11/1/2020 13:18:38'!
test22CantMoveXFromPositionWhereAnXIsNotPlaced
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 1@1.
	terniLapilliGame placeOAt: 3@3.
	terniLapilliGame placeXAt: 1@2.
	terniLapilliGame placeOAt: 3@2.
	terniLapilliGame placeXAt: 2@1.
	terniLapilliGame placeOAt: 2@3.
		
	self  should: [ terniLapilliGame moveXFrom: 2@3 to: 1@3. ]
		failWith: TerniLapilli youDontHaveAPieceThereErrorDescription! !

!TerniLapilliTest methodsFor: 'tests - moving validation' stamp: 'FR 11/1/2020 13:18:45'!
test23CantMoveOFromPositionWhereAnOIsNotPlaced
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 1@1.
	terniLapilliGame placeOAt: 3@3.
	terniLapilliGame placeXAt: 1@2.
	terniLapilliGame placeOAt: 3@2.
	terniLapilliGame placeXAt: 2@1.
	terniLapilliGame placeOAt: 2@3.
	
	terniLapilliGame moveXFrom: 1@2 to: 1@3.
	
	self  should: [ terniLapilliGame moveOFrom: 2@1 to: 3@1. ]
		failWith: TerniLapilli youDontHaveAPieceThereErrorDescription! !

!TerniLapilliTest methodsFor: 'tests - moving validation' stamp: 'FR 11/1/2020 13:18:52'!
test26CantMoveXTwoPositionsVertically
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 1@1.
	terniLapilliGame placeOAt: 1@2.
	terniLapilliGame placeXAt: 1@3.
	terniLapilliGame placeOAt: 2@1.
	terniLapilliGame placeXAt: 3@1.
	terniLapilliGame placeOAt: 2@2.
	
	self  should: [ 	terniLapilliGame moveXFrom: 3@1 to: 3@3. ]
		failWith: TerniLapilli invalidMoveErrorDescription! !

!TerniLapilliTest methodsFor: 'tests - moving validation' stamp: 'FR 11/1/2020 13:19:04'!
test27CantMoveOTwoPositionsHorizontally
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 2@1.
	terniLapilliGame placeOAt: 3@1.
	terniLapilliGame placeXAt: 3@2.
	terniLapilliGame placeOAt: 1@1.
	terniLapilliGame placeXAt: 2@2.
	terniLapilliGame placeOAt: 3@3.
	
	terniLapilliGame moveXFrom: 2@2 to: 1@2.
	
	self  should: [ 	terniLapilliGame moveOFrom: 3@3 to: 1@3. ]
		failWith: TerniLapilli invalidMoveErrorDescription! !


!TerniLapilliTest methodsFor: 'tests - winning' stamp: 'FR 11/1/2020 13:22:14'!
test32XWinsWithUpperHorizontalLine
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 1@3.
	terniLapilliGame placeOAt: 1@2.
	terniLapilliGame placeXAt: 2@3.
	terniLapilliGame placeOAt: 2@2.
	terniLapilliGame placeXAt: 3@3.

	self assertXWon! !

!TerniLapilliTest methodsFor: 'tests - winning' stamp: 'FR 11/1/2020 13:22:00'!
test33OWinsWithMiddleHorizontalLine
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 1@1.
	terniLapilliGame placeOAt: 1@2.
	terniLapilliGame placeXAt: 1@3.
	terniLapilliGame placeOAt: 2@2.
	terniLapilliGame placeXAt: 2@1.
	terniLapilliGame placeOAt: 3@2.

	self assertOWon! !

!TerniLapilliTest methodsFor: 'tests - winning' stamp: 'FR 11/1/2020 13:22:10'!
test34XWinsWithLowerHorizontalLine
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 1@1.
	terniLapilliGame placeOAt: 1@3.
	terniLapilliGame placeXAt: 2@1.
	terniLapilliGame placeOAt: 2@3.
	terniLapilliGame placeXAt: 3@1.

	self assertXWon! !

!TerniLapilliTest methodsFor: 'tests - winning' stamp: 'FR 11/1/2020 13:22:22'!
test35XWinsWithLeftVerticalLine
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 1@1.
	terniLapilliGame placeOAt: 2@1.
	terniLapilliGame placeXAt: 1@2.
	terniLapilliGame placeOAt: 2@2.
	terniLapilliGame placeXAt: 1@3.

	self assertXWon! !

!TerniLapilliTest methodsFor: 'tests - winning' stamp: 'FR 11/1/2020 13:22:32'!
test36OWinsWithMiddleVerticalLine
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 1@1.
	terniLapilliGame placeOAt: 2@1.
	terniLapilliGame placeXAt: 1@2.
	terniLapilliGame placeOAt: 2@2.
	terniLapilliGame placeXAt: 3@1.
	terniLapilliGame placeOAt: 2@3.

	self assertOWon! !

!TerniLapilliTest methodsFor: 'tests - winning' stamp: 'FR 11/1/2020 13:22:41'!
test37XWinsWithRightVerticalLine
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 3@1.
	terniLapilliGame placeOAt: 1@1.
	terniLapilliGame placeXAt: 3@2.
	terniLapilliGame placeOAt: 1@2.
	terniLapilliGame placeXAt: 3@3.

	self assertXWon! !

!TerniLapilliTest methodsFor: 'tests - winning' stamp: 'FR 11/1/2020 13:22:47'!
test38XWinsWithAscendingDiagonal
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 1@1.
	terniLapilliGame placeOAt: 1@2.
	terniLapilliGame placeXAt: 2@2.
	terniLapilliGame placeOAt: 1@3.
	terniLapilliGame placeXAt: 3@3.

	self assertXWon! !

!TerniLapilliTest methodsFor: 'tests - winning' stamp: 'FR 11/1/2020 13:22:55'!
test39OWinsWithDescendingDiagonal
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 1@1.
	terniLapilliGame placeOAt: 1@3.
	terniLapilliGame placeXAt: 1@2.
	terniLapilliGame placeOAt: 2@2.
	terniLapilliGame placeXAt: 2@1.
	terniLapilliGame placeOAt: 3@1.

	self assertOWon! !


!TerniLapilliTest methodsFor: 'tests - start of game' stamp: 'FR 11/1/2020 13:12:32'!
test01GameStartsWithNoPiecesPlacedAndXPlaying

	terniLapilliGame := TerniLapilli new.
	
	self assert: terniLapilliGame noPiecesPlaced.
	self assertXIsPlaying.
	self assertGameIsNotOver.! !


!TerniLapilliTest methodsFor: 'tests - placing functionality' stamp: 'FR 11/1/2020 13:12:47'!
test02OStartsPlayingAfterPlacingX

	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 2@2.
	
	self assertOIsPlaying.! !

!TerniLapilliTest methodsFor: 'tests - placing functionality' stamp: 'FR 11/1/2020 13:23:17'!
test07XStartsPlayingAfterPlacingO
	
	terniLapilliGame := TerniLapilli new.
	
	terniLapilliGame placeXAt: 2@2.
	terniLapilliGame placeOAt: 1@1.
	
	self assertXIsPlaying! !


!TerniLapilliTest methodsFor: 'private - assertions' stamp: 'FR 11/1/2020 13:12:32'!
assertGameIsNotOver

	self deny: terniLapilliGame isOver.
	self deny: terniLapilliGame XHasWon.
	self deny: terniLapilliGame OHasWon! !

!TerniLapilliTest methodsFor: 'private - assertions' stamp: 'FR 11/1/2020 13:19:21'!
assertGameIsOver

	self assert: terniLapilliGame isOver.
	self deny: terniLapilliGame XIsPlaying.
	self deny: terniLapilliGame OIsPlaying! !

!TerniLapilliTest methodsFor: 'private - assertions' stamp: 'FR 11/1/2020 13:12:47'!
assertOIsPlaying

	self deny: terniLapilliGame XIsPlaying.
	self assert: terniLapilliGame OIsPlaying! !

!TerniLapilliTest methodsFor: 'private - assertions' stamp: 'FR 11/1/2020 13:21:41'!
assertOWon

	self deny: terniLapilliGame XHasWon.
	self assert: terniLapilliGame OHasWon.
	self assertGameIsOver.! !

!TerniLapilliTest methodsFor: 'private - assertions' stamp: 'FR 11/1/2020 13:12:20'!
assertXIsPlaying

	self assert: terniLapilliGame XIsPlaying.
	self deny: terniLapilliGame OIsPlaying! !

!TerniLapilliTest methodsFor: 'private - assertions' stamp: 'FR 11/1/2020 13:20:01'!
assertXWon

	self assert: terniLapilliGame XHasWon.
	self deny: terniLapilliGame OHasWon.
	self assertGameIsOver.! !

!TerniLapilliTest methodsFor: 'private - assertions' stamp: 'FR 11/1/2020 13:14:20'!
should: aBlock failWith: expectedErrorMessageText

	self  should: aBlock
		raise: Error
		withMessageText: expectedErrorMessageText! !


!classDefinition: #TerniLapilli category: 'TerniLapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'turnNumber xPositions oPositions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'private - placing' stamp: 'FR 11/1/2020 14:55:54'!
placeOWhenOIsPlacingAt: aPosition

	oPositions add: aPosition.
	turnNumber := turnNumber + 1! !

!TerniLapilli methodsFor: 'private - placing' stamp: 'FR 11/1/2020 14:44:26'!
placeOWhenXIsPlacingAt: aPosition

	self error: self class notYourTurnErrorDescription! !

!TerniLapilli methodsFor: 'private - placing' stamp: 'FR 11/1/2020 16:39:17'!
placeWhenGameHasEnded

	self error: self class gameHasEndedErrorDescription! !

!TerniLapilli methodsFor: 'private - placing' stamp: 'FR 11/1/2020 14:41:56'!
placeWhenInMovingPhase

	self error: self class noPiecesRemainingErrorDescription! !

!TerniLapilli methodsFor: 'private - placing' stamp: 'FR 11/1/2020 14:41:09'!
placeXWhenOIsPlacingAt: aPosition

	self error: self class notYourTurnErrorDescription! !

!TerniLapilli methodsFor: 'private - placing' stamp: 'FR 11/1/2020 14:56:05'!
placeXWhenXIsPlacingAt: aPosition

	xPositions add: aPosition.
	turnNumber := turnNumber + 1! !


!TerniLapilli methodsFor: 'private - moving' stamp: 'FR 11/1/2020 14:56:12'!
moveOWhenOIsMovingFrom: previousPosition to: newPosition

	oPositions remove: previousPosition.
	oPositions add: newPosition.
	turnNumber := turnNumber + 1! !

!TerniLapilli methodsFor: 'private - moving' stamp: 'FR 11/1/2020 14:45:40'!
moveOWhenXIsMovingFrom: previousPosition to: newPosition

	self error: self class notYourTurnErrorDescription! !

!TerniLapilli methodsFor: 'private - moving' stamp: 'FR 11/1/2020 16:39:29'!
moveWhenGameHasEnded

	self error: self class gameHasEndedErrorDescription! !

!TerniLapilli methodsFor: 'private - moving' stamp: 'FR 11/1/2020 14:43:24'!
moveWhenInPlacingPhase

	self error: self class cantMovePiecesYetErrorDescription! !

!TerniLapilli methodsFor: 'private - moving' stamp: 'FR 11/1/2020 14:45:37'!
moveXWhenOIsMovingFrom: previousPosition to: newPosition

	self error: self class notYourTurnErrorDescription! !

!TerniLapilli methodsFor: 'private - moving' stamp: 'FR 11/1/2020 14:56:16'!
moveXWhenXIsMovingFrom: previousPosition to: newPosition

	xPositions remove: previousPosition.
	xPositions add: newPosition.
	turnNumber := turnNumber + 1! !


!TerniLapilli methodsFor: 'testing' stamp: 'FR 11/1/2020 12:31:05'!
OHasWon
	
	^ self piecesInWinningPosition: oPositions! !

!TerniLapilli methodsFor: 'testing' stamp: 'FR 11/1/2020 14:59:48'!
OIsPlaying
	
	^ self state OIsPlaying! !

!TerniLapilli methodsFor: 'testing' stamp: 'FR 11/1/2020 12:31:15'!
XHasWon
	
	^ self piecesInWinningPosition: xPositions! !

!TerniLapilli methodsFor: 'testing' stamp: 'FR 11/1/2020 14:59:52'!
XIsPlaying
	
	^ self state XIsPlaying! !

!TerniLapilli methodsFor: 'testing' stamp: 'FR 11/1/2020 11:38:48'!
isOccupiedByO: aPosition

	^ oPositions includes: aPosition! !

!TerniLapilli methodsFor: 'testing' stamp: 'FR 11/1/2020 11:38:33'!
isOccupiedByX: aPosition

	^ xPositions includes: aPosition! !

!TerniLapilli methodsFor: 'testing' stamp: 'FR 11/1/2020 15:00:10'!
isOver
	
	^ self state isOver! !

!TerniLapilli methodsFor: 'testing' stamp: 'FR 11/1/2020 22:26:06'!
noPiecesPlaced
	
	^ (xPositions union: oPositions) isEmpty! !


!TerniLapilli methodsFor: 'private - turns' stamp: 'FR 11/1/2020 14:52:14'!
turnNumber

	^ turnNumber copy! !


!TerniLapilli methodsFor: 'placing' stamp: 'FR 11/1/2020 16:45:33'!
placeOAt: aPosition
	
	self validateForPlacing: aPosition.
	
	self state placeOAt: aPosition.! !

!TerniLapilli methodsFor: 'placing' stamp: 'FR 11/1/2020 16:45:40'!
placeXAt: aPosition

	self validateForPlacing: aPosition.
	
	self state placeXAt: aPosition.
	! !


!TerniLapilli methodsFor: 'initialization' stamp: 'FR 11/1/2020 14:53:45'!
initialize

	xPositions := Set new.
	oPositions := Set new.
	turnNumber := 1.! !


!TerniLapilli methodsFor: 'assertions' stamp: 'FR 11/1/2020 12:04:33'!
assertIsValidMoveFrom: previousPosition to: newPosition

	(({previousPosition. newPosition.} includes: 2@2) or: [ (previousPosition - newPosition) r <= 1 ]) ifFalse: [ self error: self class invalidMoveErrorDescription ]! !

!TerniLapilli methodsFor: 'assertions' stamp: 'FR 11/1/2020 11:33:15'!
assertNotOccupied: aPosition

	^ ((xPositions union: oPositions) includes: aPosition) ifTrue: [ self error: self class positionOccupiedErrorDescription ]! !

!TerniLapilli methodsFor: 'assertions' stamp: 'FR 11/1/2020 11:38:48'!
assertOccupiedByO: aPosition

	^ (self isOccupiedByO: aPosition) ifFalse: [ self error: self class youDontHaveAPieceThereErrorDescription ]! !

!TerniLapilli methodsFor: 'assertions' stamp: 'FR 11/1/2020 14:50:23'!
assertOccupiedByX: aPosition

	^ (self isOccupiedByX: aPosition) ifFalse: [ self error: self class youDontHaveAPieceThereErrorDescription ]! !

!TerniLapilli methodsFor: 'assertions' stamp: 'FR 11/1/2020 10:52:10'!
assertWithinBoundaries: aPosition

	(aPosition between: 1@1 and: 3@3) ifFalse: [ self error: self class targetPositionOutOfBoundariesErrorDescription ].! !


!TerniLapilli methodsFor: 'private - validation' stamp: 'FR 11/1/2020 16:45:32'!
validateForPlacing: aPosition

	self assertNotOccupied: aPosition.
	self assertWithinBoundaries: aPosition! !

!TerniLapilli methodsFor: 'private - validation' stamp: 'FR 11/1/2020 16:46:17'!
validateMovingFrom: previousPosition to: newPosition

	self assertIsValidMoveFrom: previousPosition to: newPosition.
	self assertNotOccupied: newPosition.
	self assertWithinBoundaries: newPosition! !


!TerniLapilli methodsFor: 'moving' stamp: 'FR 11/1/2020 16:46:17'!
moveOFrom: previousPosition to: newPosition

	self validateMovingFrom: previousPosition to: newPosition.
	self assertOccupiedByO: previousPosition.

	self state moveOFrom: previousPosition to: newPosition.! !

!TerniLapilli methodsFor: 'moving' stamp: 'FR 11/1/2020 16:46:39'!
moveXFrom: previousPosition to: newPosition

	self validateMovingFrom: previousPosition to: newPosition.
	self assertOccupiedByX: previousPosition.

	self state moveXFrom: previousPosition to: newPosition.! !


!TerniLapilli methodsFor: 'private - pieces' stamp: 'FR 11/1/2020 12:30:00'!
hasAscendingDiagonalLine: piecePositions

	^(piecePositions select: [ :aPosition | aPosition x = aPosition y ] ) size = 3! !

!TerniLapilli methodsFor: 'private - pieces' stamp: 'FR 11/1/2020 12:29:44'!
hasDescendingDiagonalLine: piecePositions

	^(piecePositions select: [ :aPosition | aPosition x = (4 - aPosition y) ] ) size = 3! !

!TerniLapilli methodsFor: 'private - pieces' stamp: 'FR 11/1/2020 12:15:28'!
hasHorizontalLine: piecePositions

	^(1 to: 3) anySatisfy: [ :aValue | (piecePositions select: [ :aPosition | aPosition y = aValue ]) size = 3 ]! !

!TerniLapilli methodsFor: 'private - pieces' stamp: 'FR 11/1/2020 12:19:33'!
hasVerticalLine: piecePositions

	^(1 to: 3) anySatisfy: [ :aValue | (piecePositions select: [ :aPosition | aPosition x = aValue ]) size = 3 ]! !

!TerniLapilli methodsFor: 'private - pieces' stamp: 'FR 11/1/2020 12:30:50'!
piecesInWinningPosition: piecesPositions

	^ (self hasHorizontalLine: piecesPositions) or: [
		(self hasVerticalLine: piecesPositions) or: [
			(self hasAscendingDiagonalLine: piecesPositions) or: [
				self hasDescendingDiagonalLine: piecesPositions
			]
		]
	]! !


!TerniLapilli methodsFor: 'private - state' stamp: 'FR 11/1/2020 14:54:43'!
state

	^(TerniLapilliState for: self)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: 'TerniLapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'FR 11/1/2020 11:18:09'!
cantMovePiecesYetErrorDescription
	
	^'Cannot move pieces until the moving phase of the game begins'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'FR 11/1/2020 16:38:55'!
gameHasEndedErrorDescription
	
	^'Game has already ended!!'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'FR 11/1/2020 11:52:40'!
invalidMoveErrorDescription
	
	^'This type of move is not allowed'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'FR 11/1/2020 11:39:55'!
noPiecesRemainingErrorDescription
	
	^'Cannot place more than three pieces'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'FR 11/1/2020 11:04:32'!
notYourTurnErrorDescription
	
	^'Cannot play when it is not your turn'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'FR 11/1/2020 11:11:02'!
positionOccupiedErrorDescription
	
	^'Target position is invalid because it is already occupied'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'FR 11/1/2020 10:48:33'!
targetPositionOutOfBoundariesErrorDescription
	
	^'Target position is invalid because it is outside the boundaries of the board'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'FR 11/1/2020 11:31:22'!
youDontHaveAPieceThereErrorDescription
	
	^'Cannot move from a position where there isn`t a piece of yours'! !


!classDefinition: #TerniLapilliState category: 'TerniLapilli'!
Object subclass: #TerniLapilliState
	instanceVariableNames: 'terniLapilliGame'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliState methodsFor: 'initialization' stamp: 'FR 11/1/2020 15:18:01'!
initializeWith: aTerniLapilliGame

	terniLapilliGame := aTerniLapilliGame! !


!TerniLapilliState methodsFor: 'testing' stamp: 'FR 11/1/2020 13:37:33'!
OIsPlaying

	self subclassResponsibility! !

!TerniLapilliState methodsFor: 'testing' stamp: 'FR 11/1/2020 13:37:31'!
XIsPlaying

	self subclassResponsibility! !

!TerniLapilliState methodsFor: 'testing' stamp: 'FR 11/1/2020 15:00:21'!
isOver

	self subclassResponsibility! !


!TerniLapilliState methodsFor: 'placing' stamp: 'FR 11/1/2020 13:37:05'!
placeOAt: aPosition

	self subclassResponsibility! !

!TerniLapilliState methodsFor: 'placing' stamp: 'FR 11/1/2020 13:37:03'!
placeXAt: aPosition

	self subclassResponsibility! !


!TerniLapilliState methodsFor: 'moving' stamp: 'FR 11/1/2020 13:37:22'!
moveOFrom: previousPosition to: newPosition

	self subclassResponsibility! !

!TerniLapilliState methodsFor: 'moving' stamp: 'FR 11/1/2020 13:37:19'!
moveXFrom: previousPosition to: newPosition

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliState class' category: 'TerniLapilli'!
TerniLapilliState class
	instanceVariableNames: ''!

!TerniLapilliState class methodsFor: 'instance creation' stamp: 'FR 11/1/2020 13:29:23'!
for: aTerniLapilliGame

	^(self subclasses detect: [ :aSubclass | aSubclass canHandle: aTerniLapilliGame ]) for: aTerniLapilliGame.! !


!classDefinition: #EndOfGamePhase category: 'TerniLapilli'!
TerniLapilliState subclass: #EndOfGamePhase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!EndOfGamePhase methodsFor: 'testing' stamp: 'FR 11/1/2020 13:37:59'!
OIsPlaying

	^false! !

!EndOfGamePhase methodsFor: 'testing' stamp: 'FR 11/1/2020 13:37:55'!
XIsPlaying

	^false! !

!EndOfGamePhase methodsFor: 'testing' stamp: 'FR 11/1/2020 15:00:29'!
isOver

	^true! !


!EndOfGamePhase methodsFor: 'placing' stamp: 'FR 11/1/2020 16:39:44'!
placeOAt: aPosition

	terniLapilliGame placeWhenGameHasEnded! !

!EndOfGamePhase methodsFor: 'placing' stamp: 'FR 11/1/2020 16:39:47'!
placeXAt: aPosition

	terniLapilliGame placeWhenGameHasEnded! !


!EndOfGamePhase methodsFor: 'moving' stamp: 'FR 11/1/2020 16:40:10'!
moveOFrom: previousPosition to: newPosition

	terniLapilliGame moveWhenGameHasEnded! !

!EndOfGamePhase methodsFor: 'moving' stamp: 'FR 11/1/2020 16:40:14'!
moveXFrom: previousPosition to: newPosition

	terniLapilliGame moveWhenGameHasEnded! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EndOfGamePhase class' category: 'TerniLapilli'!
EndOfGamePhase class
	instanceVariableNames: ''!

!EndOfGamePhase class methodsFor: 'instance creation' stamp: 'FR 11/1/2020 13:34:30'!
canHandle: aTerniLapilliGame

	^ aTerniLapilliGame XHasWon or: [ aTerniLapilliGame OHasWon ].! !

!EndOfGamePhase class methodsFor: 'instance creation' stamp: 'FR 11/1/2020 13:31:25'!
for: aTerniLapilliGame

	^ self new initializeWith: aTerniLapilliGame! !


!classDefinition: #MovingPhase category: 'TerniLapilli'!
TerniLapilliState subclass: #MovingPhase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!MovingPhase methodsFor: 'testing' stamp: 'FR 11/1/2020 14:31:53'!
OIsPlaying

	self subclassResponsibility! !

!MovingPhase methodsFor: 'testing' stamp: 'FR 11/1/2020 14:31:51'!
XIsPlaying

	self subclassResponsibility! !

!MovingPhase methodsFor: 'testing' stamp: 'FR 11/1/2020 15:00:40'!
isOver

	^false! !


!MovingPhase methodsFor: 'placing' stamp: 'FR 11/1/2020 15:18:01'!
placeOAt: aPosition

	terniLapilliGame placeWhenInMovingPhase! !

!MovingPhase methodsFor: 'placing' stamp: 'FR 11/1/2020 15:18:01'!
placeXAt: aPosition

	terniLapilliGame placeWhenInMovingPhase! !


!MovingPhase methodsFor: 'moving' stamp: 'FR 11/1/2020 14:34:48'!
moveOFrom: previousPosition to: newPosition

	self subclassResponsibility! !

!MovingPhase methodsFor: 'moving' stamp: 'FR 11/1/2020 14:34:46'!
moveXFrom: previousPosition to: newPosition

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MovingPhase class' category: 'TerniLapilli'!
MovingPhase class
	instanceVariableNames: ''!

!MovingPhase class methodsFor: 'instance creation' stamp: 'FR 11/1/2020 13:35:36'!
canHandle: aTerniLapilliGame

	^ ((aTerniLapilliGame XHasWon or: [ aTerniLapilliGame OHasWon ]) not) and: [ aTerniLapilliGame turnNumber > 6 ].! !

!MovingPhase class methodsFor: 'instance creation' stamp: 'FR 11/1/2020 13:31:38'!
for: aTerniLapilliGame

	^(self subclasses detect: [ :aSubclass | aSubclass canHandle: aTerniLapilliGame ]) for: aTerniLapilliGame.! !


!classDefinition: #OIsMoving category: 'TerniLapilli'!
MovingPhase subclass: #OIsMoving
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!OIsMoving methodsFor: 'testing' stamp: 'FR 11/1/2020 14:35:13'!
OIsPlaying

	^true! !

!OIsMoving methodsFor: 'testing' stamp: 'FR 11/1/2020 14:35:07'!
XIsPlaying

	^false! !


!OIsMoving methodsFor: 'moving' stamp: 'FR 11/1/2020 15:18:01'!
moveOFrom: previousPosition to: newPosition

	terniLapilliGame moveOWhenOIsMovingFrom: previousPosition to: newPosition! !

!OIsMoving methodsFor: 'moving' stamp: 'FR 11/1/2020 15:18:01'!
moveXFrom: previousPosition to: newPosition

	terniLapilliGame moveXWhenOIsMovingFrom: previousPosition to: newPosition! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OIsMoving class' category: 'TerniLapilli'!
OIsMoving class
	instanceVariableNames: ''!

!OIsMoving class methodsFor: 'instance creation' stamp: 'FR 11/1/2020 15:03:42'!
canHandle: aTerniLapilliGame

	^ aTerniLapilliGame turnNumber even! !

!OIsMoving class methodsFor: 'instance creation' stamp: 'FR 11/1/2020 13:32:05'!
for: aTerniLapilliGame

	^ self new initializeWith: aTerniLapilliGame ! !


!classDefinition: #XIsMoving category: 'TerniLapilli'!
MovingPhase subclass: #XIsMoving
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!XIsMoving methodsFor: 'moving' stamp: 'FR 11/1/2020 15:18:01'!
moveOFrom: previousPosition to: newPosition

	terniLapilliGame moveOWhenXIsMovingFrom: previousPosition to: newPosition! !

!XIsMoving methodsFor: 'moving' stamp: 'FR 11/1/2020 15:18:01'!
moveXFrom: previousPosition to: newPosition

	terniLapilliGame moveXWhenXIsMovingFrom: previousPosition to: newPosition! !


!XIsMoving methodsFor: 'testing' stamp: 'FR 11/1/2020 14:36:26'!
OIsPlaying

	^false! !

!XIsMoving methodsFor: 'testing' stamp: 'FR 11/1/2020 14:36:23'!
XIsPlaying

	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XIsMoving class' category: 'TerniLapilli'!
XIsMoving class
	instanceVariableNames: ''!

!XIsMoving class methodsFor: 'instance creation' stamp: 'FR 11/1/2020 15:03:51'!
canHandle: aTerniLapilliGame

	^ aTerniLapilliGame turnNumber odd! !

!XIsMoving class methodsFor: 'instance creation' stamp: 'FR 11/1/2020 13:32:14'!
for: aTerniLapilliGame

	^ self new initializeWith: aTerniLapilliGame ! !


!classDefinition: #PlacingPhase category: 'TerniLapilli'!
TerniLapilliState subclass: #PlacingPhase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PlacingPhase methodsFor: 'testing' stamp: 'FR 11/1/2020 14:37:21'!
OIsPlaying

	self subclassResponsibility! !

!PlacingPhase methodsFor: 'testing' stamp: 'FR 11/1/2020 14:37:19'!
XIsPlaying

	self subclassResponsibility! !

!PlacingPhase methodsFor: 'testing' stamp: 'FR 11/1/2020 15:00:46'!
isOver

	^false! !


!PlacingPhase methodsFor: 'placing' stamp: 'FR 11/1/2020 14:38:03'!
placeOAt: aPosition

	self subclassResponsibility! !

!PlacingPhase methodsFor: 'placing' stamp: 'FR 11/1/2020 14:38:00'!
placeXAt: aPosition

	self subclassResponsibility! !


!PlacingPhase methodsFor: 'moving' stamp: 'FR 11/1/2020 15:18:01'!
moveOFrom: previousPosition to: newPosition

	terniLapilliGame moveWhenInPlacingPhase! !

!PlacingPhase methodsFor: 'moving' stamp: 'FR 11/1/2020 15:18:01'!
moveXFrom: previousPosition to: newPosition

	terniLapilliGame moveWhenInPlacingPhase! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlacingPhase class' category: 'TerniLapilli'!
PlacingPhase class
	instanceVariableNames: ''!

!PlacingPhase class methodsFor: 'instance creation' stamp: 'FR 11/1/2020 13:35:46'!
canHandle: aTerniLapilliGame

	^ ((aTerniLapilliGame XHasWon or: [ aTerniLapilliGame OHasWon ]) not) and: [ aTerniLapilliGame turnNumber <= 6 ].! !

!PlacingPhase class methodsFor: 'instance creation' stamp: 'FR 11/1/2020 13:31:44'!
for: aTerniLapilliGame

	^(self subclasses detect: [ :aSubclass | aSubclass canHandle: aTerniLapilliGame ]) for: aTerniLapilliGame.! !


!classDefinition: #OIsPlacing category: 'TerniLapilli'!
PlacingPhase subclass: #OIsPlacing
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!OIsPlacing methodsFor: 'placing' stamp: 'FR 11/1/2020 15:18:01'!
placeOAt: aPosition

	terniLapilliGame placeOWhenOIsPlacingAt: aPosition! !

!OIsPlacing methodsFor: 'placing' stamp: 'FR 11/1/2020 15:18:01'!
placeXAt: aPosition

	terniLapilliGame placeXWhenOIsPlacingAt: aPosition! !


!OIsPlacing methodsFor: 'testing' stamp: 'FR 11/1/2020 14:39:14'!
OIsPlaying

	^true! !

!OIsPlacing methodsFor: 'testing' stamp: 'FR 11/1/2020 14:39:09'!
XIsPlaying

	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OIsPlacing class' category: 'TerniLapilli'!
OIsPlacing class
	instanceVariableNames: ''!

!OIsPlacing class methodsFor: 'instance creation' stamp: 'FR 11/1/2020 15:03:54'!
canHandle: aTerniLapilliGame

	^ aTerniLapilliGame turnNumber even! !

!OIsPlacing class methodsFor: 'instance creation' stamp: 'FR 11/1/2020 13:32:23'!
for: aTerniLapilliGame

	^ self new initializeWith: aTerniLapilliGame ! !


!classDefinition: #XIsPlacing category: 'TerniLapilli'!
PlacingPhase subclass: #XIsPlacing
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!XIsPlacing methodsFor: 'testing' stamp: 'FR 11/1/2020 14:39:28'!
OIsPlaying

	^false! !

!XIsPlacing methodsFor: 'testing' stamp: 'FR 11/1/2020 14:39:24'!
XIsPlaying

	^true! !


!XIsPlacing methodsFor: 'placing' stamp: 'FR 11/1/2020 15:18:01'!
placeOAt: aPosition

	terniLapilliGame placeOWhenXIsPlacingAt: aPosition! !

!XIsPlacing methodsFor: 'placing' stamp: 'FR 11/1/2020 15:18:01'!
placeXAt: aPosition

	terniLapilliGame placeXWhenXIsPlacingAt: aPosition! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XIsPlacing class' category: 'TerniLapilli'!
XIsPlacing class
	instanceVariableNames: ''!

!XIsPlacing class methodsFor: 'instance creation' stamp: 'FR 11/1/2020 15:03:59'!
canHandle: aTerniLapilliGame

	^ aTerniLapilliGame turnNumber odd! !

!XIsPlacing class methodsFor: 'instance creation' stamp: 'FR 11/1/2020 13:32:29'!
for: aTerniLapilliGame

	^ self new initializeWith: aTerniLapilliGame ! !
