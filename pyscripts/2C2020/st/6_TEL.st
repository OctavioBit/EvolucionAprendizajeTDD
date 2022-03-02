!classDefinition: #TerniLapilliTests category: 'TerniLapilli'!
TestCase subclass: #TerniLapilliTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTests methodsFor: 'movement' stamp: 'RL 11/2/2020 15:25:22'!
test13ThrowExceptionWhenMovingPiecesWithStillLeftToPut
	| aTerniLapilli |
	aTerniLapilli := TerniLapilli new.	
	aTerniLapilli putXAt: 3@1.
	aTerniLapilli putOAt: 1@2.
	aTerniLapilli putXAt: 2@2.
	aTerniLapilli putOAt: 2@3.
	aTerniLapilli putXAt: 2@1.
	self
		should: [ aTerniLapilli moveOFrom: 2@3 to: 3@3. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli thereArePiecesLeftToPut ]! !

!TerniLapilliTests methodsFor: 'movement' stamp: 'RL 11/2/2020 15:20:08'!
test14ThrowExceptionWhenMovingAPieceToAnOcuppiedPosition
	| aTerniLapilli |
	aTerniLapilli := TerniLapilli new.	
	aTerniLapilli putXAt: 3@1.
	aTerniLapilli putOAt: 1@2.
	aTerniLapilli putXAt: 2@2.
	aTerniLapilli putOAt: 2@3.
	aTerniLapilli putXAt: 2@1.
	aTerniLapilli putOAt: 1@1.	
	self
		should: [ aTerniLapilli moveXFrom: 2@2 to: 1@2. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli notValidPositionErrorMessage ]! !

!TerniLapilliTests methodsFor: 'movement' stamp: 'RL 11/2/2020 15:19:55'!
test15ThrowExceptionWhenMovingAPieceToAnInvalidPosition
	| aTerniLapilli |
	aTerniLapilli := TerniLapilli new.	
	aTerniLapilli putXAt: 3@1.
	aTerniLapilli putOAt: 1@2.
	aTerniLapilli putXAt: 2@2.
	aTerniLapilli putOAt: 2@3.
	aTerniLapilli putXAt: 2@1.
	aTerniLapilli putOAt: 1@1.	
	self
		should: [ aTerniLapilli moveXFrom: 1@2 to: 0@2. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli notValidPositionErrorMessage ]! !

!TerniLapilliTests methodsFor: 'movement' stamp: 'RL 11/2/2020 15:19:41'!
test16ThrowExceptionWhenMovingAPieceNotFromAPlayerPosition
	| aTerniLapilli |
	aTerniLapilli := TerniLapilli new.	
	aTerniLapilli putXAt: 3@1.
	aTerniLapilli putOAt: 1@2.
	aTerniLapilli putXAt: 2@2.
	aTerniLapilli putOAt: 2@3.
	aTerniLapilli putXAt: 2@1.
	aTerniLapilli putOAt: 1@1.	
	self
		should: [ aTerniLapilli moveXFrom: 1@1 to: 3@2. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli notValidPositionErrorMessage ]! !

!TerniLapilliTests methodsFor: 'movement' stamp: 'RL 11/2/2020 15:20:45'!
test17MoveCorrectlyAPieceFrom31To32
	| aTerniLapilli |
	aTerniLapilli := TerniLapilli new.	
	aTerniLapilli putXAt: 3@1.
	aTerniLapilli putOAt: 1@2.
	aTerniLapilli putXAt: 2@2.
	aTerniLapilli putOAt: 2@3.
	aTerniLapilli putXAt: 2@1.
	aTerniLapilli putOAt: 1@1.	
	
	aTerniLapilli moveXFrom: 3@1 to: 3@2.
	self deny: (aTerniLapilli isXAt: 3@1).
	self assert: (aTerniLapilli isXAt: 3@2).! !

!TerniLapilliTests methodsFor: 'movement' stamp: 'RL 11/2/2020 15:20:54'!
test18ThrowExceptionWhenMovingFrom31to33
	| aTerniLapilli |
	aTerniLapilli := TerniLapilli new.	
	aTerniLapilli putXAt: 3@1.
	aTerniLapilli putOAt: 1@2.
	aTerniLapilli putXAt: 2@2.
	aTerniLapilli putOAt: 2@3.
	aTerniLapilli putXAt: 2@1.
	aTerniLapilli putOAt: 1@1.	
	
	self
		should: [ aTerniLapilli moveXFrom: 3@1 to: 3@3. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli notValidMoveErrorMessage ]! !

!TerniLapilliTests methodsFor: 'movement' stamp: 'RL 11/2/2020 15:32:59'!
test19ThrowExceptionWhenMovingFrom13to33
	| aTerniLapilli |
	aTerniLapilli := TerniLapilli new.	
	aTerniLapilli putXAt: 3@1.
	aTerniLapilli putOAt: 1@2.
	aTerniLapilli putXAt: 2@1.
	aTerniLapilli putOAt: 2@3.
	aTerniLapilli putXAt: 1@3.
	aTerniLapilli putOAt: 1@1.	
	
	self
		should: [ aTerniLapilli moveXFrom: 1@3 to: 3@3. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli notValidMoveErrorMessage ]! !

!TerniLapilliTests methodsFor: 'movement' stamp: 'RL 11/2/2020 15:40:04'!
test20ThrowExceptionWhenMovingFrom12to21
	| aTerniLapilli |
	aTerniLapilli := TerniLapilli new.	
	aTerniLapilli putXAt: 3@1.
	aTerniLapilli putOAt: 1@2.
	aTerniLapilli putXAt: 2@2.
	aTerniLapilli putOAt: 2@3.
	aTerniLapilli putXAt: 1@1.
	aTerniLapilli putOAt: 3@3.	
	
	aTerniLapilli moveXFrom: 3@1 to: 3@2.
	
	self
		should: [ aTerniLapilli moveOFrom: 1@2 to: 2@1. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli notValidMoveErrorMessage ]! !

!TerniLapilliTests methodsFor: 'movement' stamp: 'RL 11/2/2020 16:23:24'!
test21ThrowExceptionWhenMovingFrom23to32
	| aTerniLapilli |
	aTerniLapilli := TerniLapilli new.	
	aTerniLapilli putXAt: 3@1.
	aTerniLapilli putOAt: 2@2.
	aTerniLapilli putXAt: 1@2.
	aTerniLapilli putOAt: 2@3.
	aTerniLapilli putXAt: 1@3.
	aTerniLapilli putOAt: 1@1.	
	
	aTerniLapilli moveXFrom: 3@1 to: 2@1.
	
	self
		should: [ aTerniLapilli moveOFrom: 2@3 to: 3@2. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli notValidMoveErrorMessage ]! !

!TerniLapilliTests methodsFor: 'movement' stamp: 'RL 11/2/2020 15:47:29'!
test22ThrowExceptionWhenPlayerMovesNotInItsTurn
	| aTerniLapilli |
	aTerniLapilli := TerniLapilli new.	
	aTerniLapilli putXAt: 1@2.
	aTerniLapilli putOAt: 3@1.
	aTerniLapilli putXAt: 2@2.
	aTerniLapilli putOAt: 1@3.
	aTerniLapilli putXAt: 2@3.
	aTerniLapilli putOAt: 1@1.	
	
	self
		should: [ aTerniLapilli moveOFrom: 1@1 to: 2@1. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli notPlayersTurn ]
	! !

!TerniLapilliTests methodsFor: 'movement' stamp: 'RL 11/1/2020 13:29:52'!
test25ThrowExceptionWhenMovingPieceWithAlreadyFinishedGame
	| aTerniLapilli |
	aTerniLapilli := TerniLapilli new.	
	aTerniLapilli putXAt: 1@1.
	aTerniLapilli putOAt: 2@1.
	aTerniLapilli putXAt: 1@2.
	aTerniLapilli putOAt: 2@2.
	aTerniLapilli putXAt: 3@3.
	aTerniLapilli putOAt: 2@3.
	
	self assert: aTerniLapilli isOver.
	self
		should: [ aTerniLapilli moveXFrom: 3@3 to: 3@2]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli gameIsOverErrorMessage
			]! !


!TerniLapilliTests methodsFor: 'positionment' stamp: 'RL 11/1/2020 11:24:50'!
test02PlayerXPutAtCorrectPosition
	| aTerniLapilli |
	aTerniLapilli := TerniLapilli new.
	aTerniLapilli putXAt: 1@1.
	self assert: (aTerniLapilli isXAt: 1@1).! !

!TerniLapilliTests methodsFor: 'positionment' stamp: 'rl 10/31/2020 13:28:09'!
test03ThrowExceptionWhenPlayerPutOnInvalidPosition
	| aTerniLapilli |
	aTerniLapilli := TerniLapilli new.	
	self
		should: [ aTerniLapilli putXAt: 4@4 ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli notValidPositionErrorMessage ]
	! !

!TerniLapilliTests methodsFor: 'positionment' stamp: 'rl 10/31/2020 13:29:15'!
test05PlayerOPutAtCorrectPosition
	| aTerniLapilli |
	aTerniLapilli := TerniLapilli new.	
	aTerniLapilli putXAt: 1@1.
	aTerniLapilli putOAt: 1@2.
	self assert: (aTerniLapilli isOAt: 1@2).
	! !

!TerniLapilliTests methodsFor: 'positionment' stamp: 'rl 10/31/2020 13:29:35'!
test06ThrowExceptionWhenPlayerPutAtAnAlreadyTakenPosition
	| aTerniLapilli |
	aTerniLapilli := TerniLapilli new.	
	aTerniLapilli putXAt: 1@1.
	self
		should: [ aTerniLapilli putOAt: 1@1 ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli notValidPositionErrorMessage ]
	! !


!TerniLapilliTests methodsFor: 'winning' stamp: 'RL 11/1/2020 13:09:07'!
test08AssertPlayerWinsWithThreeOnFirstColumnAndGameIsOver
	| aTerniLapilli |
	aTerniLapilli := TerniLapilli new.	
	aTerniLapilli putXAt: 1@1.
	aTerniLapilli putOAt: 2@1.
	aTerniLapilli putXAt: 1@2.
	aTerniLapilli putOAt: 2@2.
	aTerniLapilli putXAt: 1@3.
	self assert: aTerniLapilli playerXHasWon.	
	self assert: aTerniLapilli isOver.! !

!TerniLapilliTests methodsFor: 'winning' stamp: 'RL 11/1/2020 10:34:22'!
test09AssertPlayerWinsWithThreeOnMiddleColumn
	| aTerniLapilli |
	aTerniLapilli := TerniLapilli new.	
	aTerniLapilli putXAt: 2@1.
	aTerniLapilli putOAt: 1@2.
	aTerniLapilli putXAt: 2@2.
	aTerniLapilli putOAt: 1@3.
	aTerniLapilli putXAt: 2@3.
	self assert: aTerniLapilli playerXHasWon.	! !

!TerniLapilliTests methodsFor: 'winning' stamp: 'RL 11/1/2020 10:35:00'!
test10AssertPlayerWinsWithThreeOnFirstRow
	| aTerniLapilli |
	aTerniLapilli := TerniLapilli new.	
	aTerniLapilli putXAt: 1@1.
	aTerniLapilli putOAt: 1@2.
	aTerniLapilli putXAt: 2@1.
	aTerniLapilli putOAt: 2@2.
	aTerniLapilli putXAt: 3@1.
	self assert: aTerniLapilli playerXHasWon.	! !

!TerniLapilliTests methodsFor: 'winning' stamp: 'RL 11/1/2020 10:36:48'!
test11AssertPlayerWinsWithThreeOn11to33Diagonal
	| aTerniLapilli |
	aTerniLapilli := TerniLapilli new.	
	aTerniLapilli putXAt: 1@1.
	aTerniLapilli putOAt: 1@2.
	aTerniLapilli putXAt: 2@2.
	aTerniLapilli putOAt: 2@3.
	aTerniLapilli putXAt: 3@3.
	self assert: aTerniLapilli playerXHasWon.! !

!TerniLapilliTests methodsFor: 'winning' stamp: 'RL 11/1/2020 10:37:22'!
test12AssertPlayerWinsWithThreeOn31to13Diagonal
	| aTerniLapilli |
	aTerniLapilli := TerniLapilli new.	
	aTerniLapilli putXAt: 3@1.
	aTerniLapilli putOAt: 1@2.
	aTerniLapilli putXAt: 2@2.
	aTerniLapilli putOAt: 2@3.
	aTerniLapilli putXAt: 1@3.
	self assert: aTerniLapilli playerXHasWon.	! !


!TerniLapilliTests methodsFor: 'game state logic' stamp: 'RL 10/29/2020 18:20:25'!
test01PlayerXStartsGame
	| aTerniLapilli |
	aTerniLapilli := TerniLapilli new.
	self assert: aTerniLapilli isXTurn.! !

!TerniLapilliTests methodsFor: 'game state logic' stamp: 'rl 10/31/2020 13:28:31'!
test04PlayerOHasSecondTurn
	| aTerniLapilli |
	aTerniLapilli := TerniLapilli new.	
	aTerniLapilli putXAt: 1@1.
	self deny: aTerniLapilli isXTurn.
	! !

!TerniLapilliTests methodsFor: 'game state logic' stamp: 'rl 10/31/2020 13:29:56'!
test07ThrowExceptionWhenPlayerPlaysNotInItsTurn
	| aTerniLapilli |
	aTerniLapilli := TerniLapilli new.	
	self
		should: [ aTerniLapilli putOAt: 1@1 ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli notPlayersTurn ]
	! !

!TerniLapilliTests methodsFor: 'game state logic' stamp: 'RL 11/1/2020 13:12:45'!
test23AssertGameIsNotOverIfNoPlayerWon
	| aTerniLapilli |
	aTerniLapilli := TerniLapilli new.	
	aTerniLapilli putXAt: 1@1.
	aTerniLapilli putOAt: 2@1.
	aTerniLapilli putXAt: 1@2.
	aTerniLapilli putOAt: 2@2.
	self deny: aTerniLapilli playerXHasWon.	
	self deny: aTerniLapilli playerOHasWon.	
	self deny: aTerniLapilli isOver.! !

!TerniLapilliTests methodsFor: 'game state logic' stamp: 'RL 11/1/2020 13:25:35'!
test24ThrowExceptionWhenPuttingPieceWithAlreadyFinishedGame
	| aTerniLapilli |
	aTerniLapilli := TerniLapilli new.	
	aTerniLapilli putXAt: 1@1.
	aTerniLapilli putOAt: 2@1.
	aTerniLapilli putXAt: 1@2.
	aTerniLapilli putOAt: 2@2.
	aTerniLapilli putXAt: 1@3.
	
	self assert: aTerniLapilli isOver.
	self
		should: [ aTerniLapilli putOAt: 3@1 ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli gameIsOverErrorMessage
			]! !

!TerniLapilliTests methodsFor: 'game state logic' stamp: 'RL 11/2/2020 16:25:15'!
test26MovingAPieceChangesThePlayerTurn
	| aTerniLapilli |
	aTerniLapilli := TerniLapilli new.	
	aTerniLapilli putXAt: 3@1.
	aTerniLapilli putOAt: 1@2.
	aTerniLapilli putXAt: 2@2.
	aTerniLapilli putOAt: 2@3.
	aTerniLapilli putXAt: 2@1.
	aTerniLapilli putOAt: 1@1.	
	
	aTerniLapilli moveXFrom: 3@1 to: 3@2.
	self deny: aTerniLapilli isXTurn.! !


!classDefinition: #Player category: 'TerniLapilli'!
Object subclass: #Player
	instanceVariableNames: 'pieces'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!Player methodsFor: 'initialization' stamp: 'RL 11/1/2020 10:56:30'!
initialize
	pieces := OrderedCollection new.! !


!Player methodsFor: 'queries' stamp: 'RL 11/2/2020 15:08:13'!
firstPieceIsAlignedOver: anAxisAsSymbol with: aPieceIndex
	^((pieces at: 1) perform: anAxisAsSymbol) = ((pieces at: aPieceIndex) perform: anAxisAsSymbol)! !

!Player methodsFor: 'queries' stamp: 'rl 10/31/2020 12:09:35'!
hasPieceAt: aPosition
	^pieces includes: aPosition .! !

!Player methodsFor: 'queries' stamp: 'RL 11/2/2020 15:12:31'!
hasWon
	^
	(pieces size = 3) and:
		[(self hasWonWithLineInAxis: #x)
		or:
		[ self hasWonWithLineInAxis: #y]
		or:
		[ self hasWonWithDiagonalFrom: 1@1 to: 3@3 ]
		or:
		[ self hasWonWithDiagonalFrom: 3@1 to: 1@3 ]].! !

!Player methodsFor: 'queries' stamp: 'RL 11/2/2020 14:54:11'!
hasWonWithDiagonalFrom: position1 to: position2
	^(pieces includes: position1) and: [pieces includes: 2@2] and: [pieces includes: position2].! !

!Player methodsFor: 'queries' stamp: 'RL 11/2/2020 15:09:05'!
hasWonWithLineInAxis: anAxisAsSymbol
	^(self firstPieceIsAlignedOver: anAxisAsSymbol with: 2)
	and:
	[ self firstPieceIsAlignedOver: anAxisAsSymbol with: 3 ].! !

!Player methodsFor: 'queries' stamp: 'RL 11/2/2020 14:36:27'!
isPlayerTurn: aTurn
	self subclassResponsibility ! !

!Player methodsFor: 'queries' stamp: 'rl 10/31/2020 13:17:19'!
numberOfPiecesOnGame
	^pieces size.! !


!Player methodsFor: 'operations' stamp: 'RL 11/2/2020 14:36:01'!
addPieceOnOturnAt: aPosition
	self subclassResponsibility ! !

!Player methodsFor: 'operations' stamp: 'RL 11/2/2020 14:36:14'!
addPieceOnXturnAt: aPosition
	self subclassResponsibility ! !

!Player methodsFor: 'operations' stamp: 'RL 11/2/2020 14:36:43'!
movePieceOnOturnFrom: aPosition to: anotherPosition
	self subclassResponsibility ! !

!Player methodsFor: 'operations' stamp: 'RL 11/2/2020 14:36:47'!
movePieceOnXturnFrom: aPosition to: anotherPosition
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Player class' category: 'TerniLapilli'!
Player class
	instanceVariableNames: 'playerX playerO'!

!Player class methodsFor: 'as yet unclassified' stamp: 'rl 10/31/2020 13:09:36'!
newAs: aPlayerType
	^self new initializeAs: aPlayerType .! !


!classDefinition: #PlayerO category: 'TerniLapilli'!
Player subclass: #PlayerO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PlayerO methodsFor: 'operations' stamp: 'RL 11/1/2020 11:22:05'!
addPieceOnOturnAt: aPosition
	pieces add: aPosition! !

!PlayerO methodsFor: 'operations' stamp: 'RL 11/1/2020 11:22:09'!
addPieceOnXturnAt: aPosition
	^Error signal: TerniLapilli notPlayersTurn! !

!PlayerO methodsFor: 'operations' stamp: 'RL 11/1/2020 12:57:52'!
movePieceOnOturnFrom: aPosition to: anotherPosition
	pieces remove: aPosition.
	pieces add: anotherPosition.! !

!PlayerO methodsFor: 'operations' stamp: 'RL 11/1/2020 12:56:06'!
movePieceOnXturnFrom: aPosition to: anotherPosition
	^Error signal: TerniLapilli notPlayersTurn! !


!PlayerO methodsFor: 'queries' stamp: 'RL 11/1/2020 11:04:53'!
isPlayerTurn: aTurn
	^aTurn isPlayerOTurn.! !


!classDefinition: #PlayerX category: 'TerniLapilli'!
Player subclass: #PlayerX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PlayerX methodsFor: 'operations' stamp: 'RL 11/1/2020 11:22:33'!
addPieceOnOturnAt: aPosition
	^Error signal: TerniLapilli notPlayersTurn! !

!PlayerX methodsFor: 'operations' stamp: 'RL 11/1/2020 11:21:38'!
addPieceOnXturnAt: aPosition
	pieces add: aPosition! !

!PlayerX methodsFor: 'operations' stamp: 'RL 11/1/2020 12:58:06'!
movePieceOnOturnFrom: aPosition to: anotherPosition
	^Error signal: TerniLapilli notPlayersTurn! !

!PlayerX methodsFor: 'operations' stamp: 'RL 11/1/2020 12:57:07'!
movePieceOnXturnFrom: aPosition to: anotherPosition
	pieces remove: aPosition.
	pieces add: anotherPosition.! !


!PlayerX methodsFor: 'queries' stamp: 'RL 11/1/2020 11:04:32'!
isPlayerTurn: aTurn
	^aTurn isPlayerXTurn.! !


!classDefinition: #TerniLapilli category: 'TerniLapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'turn playerX playerO'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'queries' stamp: 'RL 11/2/2020 15:59:59'!
arePiecesLeftToPut
	^playerX numberOfPiecesOnGame + playerO numberOfPiecesOnGame < 6! !

!TerniLapilli methodsFor: 'queries' stamp: 'RL 11/2/2020 15:55:47'!
checkIf: destination isNeighbourOf: origin with: numberOfNeighboursAsSymbol 
	((origin perform: numberOfNeighboursAsSymbol) includes: destination) 
		ifFalse: [ ^Error signal: self class notValidMoveErrorMessage ]! !

!TerniLapilli methodsFor: 'queries' stamp: 'RL 11/1/2020 10:40:10'!
is: aPlayer at: aPosition
	^aPlayer hasPieceAt: aPosition.! !

!TerniLapilli methodsFor: 'queries' stamp: 'rl 10/31/2020 13:27:42'!
isOAt: aPosition
	^self is: playerO at: aPosition.! !

!TerniLapilli methodsFor: 'queries' stamp: 'RL 11/1/2020 11:07:42'!
isOTurn
	^self isXTurn not.! !

!TerniLapilli methodsFor: 'queries' stamp: 'RL 11/1/2020 13:17:09'!
isOver
	^playerX hasWon or: [ playerO hasWon ].! !

!TerniLapilli methodsFor: 'queries' stamp: 'RL 11/2/2020 16:08:39'!
isPositionTaken: aPosition
	^(playerX hasPieceAt: aPosition) or: [playerO hasPieceAt: aPosition]! !

!TerniLapilli methodsFor: 'queries' stamp: 'RL 11/1/2020 11:03:38'!
isTurnOfPlayer: aPlayer
	^aPlayer isPlayerTurn: turn.! !

!TerniLapilli methodsFor: 'queries' stamp: 'rl 10/31/2020 13:27:36'!
isXAt: aPosition
	^self is: playerX at: aPosition.! !

!TerniLapilli methodsFor: 'queries' stamp: 'RL 11/1/2020 11:07:13'!
isXTurn
	^self isTurnOfPlayer: playerX.! !

!TerniLapilli methodsFor: 'queries' stamp: 'RL 11/1/2020 10:40:59'!
playerOHasWon
	^playerO hasWon. ! !

!TerniLapilli methodsFor: 'queries' stamp: 'RL 11/1/2020 10:41:06'!
playerXHasWon
	^playerX hasWon. ! !


!TerniLapilli methodsFor: 'validation' stamp: 'RL 11/2/2020 16:07:07'!
validPositionOnTerniLapilliGrid: aPosition
	^(aPosition x between: 1 and: 3) and: [aPosition y between: 1 and: 3]! !

!TerniLapilli methodsFor: 'validation' stamp: 'RL 11/2/2020 16:19:18'!
validateMoveFrom: origin to: destination
	(origin x + origin y) even
		ifTrue: [self checkIf: destination isNeighbourOf: origin with: #eightNeighbors ]
		ifFalse: [self checkIf: destination isNeighbourOf: origin with: #fourNeighbors].! !

!TerniLapilli methodsFor: 'validation' stamp: 'RL 11/2/2020 16:10:00'!
validatePosition: aPosition
	((self validPositionOnTerniLapilliGrid: aPosition) not
	or:	
	[self isPositionTaken: aPosition])
	ifTrue: 
	[^Error signal: self class notValidPositionErrorMessage ].! !

!TerniLapilli methodsFor: 'validation' stamp: 'RL 11/2/2020 16:15:35'!
validateTerniLapilliConditionsFor: aPlayer movingFrom: aPosition.
	self isOver ifTrue: [ ^Error signal: self class gameIsOverErrorMessage ].
	self arePiecesLeftToPut 	ifTrue: [ ^Error signal: self class thereArePiecesLeftToPut ].
	(aPlayer hasPieceAt: aPosition) ifFalse: [ ^Error signal: self class notValidPositionErrorMessage ].! !


!TerniLapilli methodsFor: 'private operations' stamp: 'RL 11/2/2020 16:26:06'!
move: aPlayer from: aPosition to: anotherPosition
	self validateTerniLapilliConditionsFor: aPlayer movingFrom: aPosition.
	self validatePosition: anotherPosition.
	self validateMoveFrom: aPosition to: anotherPosition.
	turn validate: aPlayer andMoveFrom: aPosition to: anotherPosition.
	self nextTurn.! !

!TerniLapilli methodsFor: 'private operations' stamp: 'RL 11/1/2020 11:11:13'!
nextTurn
	turn := turn next.! !

!TerniLapilli methodsFor: 'private operations' stamp: 'RL 11/1/2020 13:27:39'!
put: aPlayer at: aPosition
	self isOver ifTrue: [ ^Error signal: self class gameIsOverErrorMessage ].
	self validatePosition: aPosition.
	turn validate: aPlayer andAddPieceAt: aPosition.
	self nextTurn.! !


!TerniLapilli methodsFor: 'operations' stamp: 'RL 11/1/2020 11:27:51'!
moveOFrom: aPosition to: anotherPosition
	self move: playerO from: aPosition to: anotherPosition! !

!TerniLapilli methodsFor: 'operations' stamp: 'RL 11/1/2020 11:27:40'!
moveXFrom: aPosition to: anotherPosition
	self move: playerX from: aPosition to: anotherPosition! !

!TerniLapilli methodsFor: 'operations' stamp: 'rl 10/31/2020 13:26:30'!
putOAt: aPosition
	self put: playerO at: aPosition.! !

!TerniLapilli methodsFor: 'operations' stamp: 'rl 10/31/2020 13:26:09'!
putXAt: aPosition
	self put: playerX at: aPosition.! !


!TerniLapilli methodsFor: 'initialization' stamp: 'RL 11/1/2020 10:57:32'!
initialize
	playerX  := PlayerX new.
	playerO  := PlayerO new.
	turn := TerniLapilliPlayerXTurn new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: 'TerniLapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'RL 11/1/2020 13:26:00'!
gameIsOverErrorMessage
	^'The game is over!!'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'RL 10/29/2020 20:28:26'!
notPlayersTurn
	^'Its not your turn!!'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'RL 11/1/2020 12:08:33'!
notValidMoveErrorMessage
	^'This move is not valid!!'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'RL 10/29/2020 18:39:04'!
notValidPositionErrorMessage
	^'Position not valid!!'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'RL 10/29/2020 21:12:41'!
thereArePiecesLeftToPut
	^'There are pieces left to put!!'! !


!classDefinition: #TerniLapilliTurnState category: 'TerniLapilli'!
Object subclass: #TerniLapilliTurnState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTurnState methodsFor: 'operations' stamp: 'RL 11/2/2020 16:27:15'!
next
	self subclassResponsibility ! !


!TerniLapilliTurnState methodsFor: 'queries' stamp: 'RL 11/2/2020 16:26:54'!
isPlayerOTurn
	self subclassResponsibility ! !

!TerniLapilliTurnState methodsFor: 'queries' stamp: 'RL 11/2/2020 16:26:58'!
isPlayerXTurn
	self subclassResponsibility ! !


!TerniLapilliTurnState methodsFor: 'validation' stamp: 'RL 11/2/2020 16:27:11'!
validate: aPlayer andAddPieceAt: aPosition
	self subclassResponsibility ! !

!TerniLapilliTurnState methodsFor: 'validation' stamp: 'RL 11/2/2020 16:27:35'!
validate: aPlayer andMoveFrom: aPosition to: anotherPosition
	self subclassResponsibility ! !


!classDefinition: #TerniLapilliPlayerOTurn category: 'TerniLapilli'!
TerniLapilliTurnState subclass: #TerniLapilliPlayerOTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliPlayerOTurn methodsFor: 'validation' stamp: 'RL 11/1/2020 11:18:56'!
validate: aPlayer andAddPieceAt: aPosition
	aPlayer addPieceOnOturnAt: aPosition.! !

!TerniLapilliPlayerOTurn methodsFor: 'validation' stamp: 'RL 11/1/2020 12:55:26'!
validate: aPlayer andMoveFrom: aPosition to: anotherPosition
	aPlayer movePieceOnOturnFrom: aPosition to: anotherPosition.! !


!TerniLapilliPlayerOTurn methodsFor: 'queries' stamp: 'RL 11/1/2020 11:05:32'!
isPlayerOTurn
	^true.! !

!TerniLapilliPlayerOTurn methodsFor: 'queries' stamp: 'RL 11/1/2020 11:05:39'!
isPlayerXTurn
	^false.! !


!TerniLapilliPlayerOTurn methodsFor: 'operations' stamp: 'RL 11/1/2020 11:10:43'!
next
	^TerniLapilliPlayerXTurn new.! !


!classDefinition: #TerniLapilliPlayerXTurn category: 'TerniLapilli'!
TerniLapilliTurnState subclass: #TerniLapilliPlayerXTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliPlayerXTurn methodsFor: 'validation' stamp: 'RL 11/1/2020 11:19:17'!
validate: aPlayer andAddPieceAt: aPosition
	aPlayer addPieceOnXturnAt: aPosition.! !

!TerniLapilliPlayerXTurn methodsFor: 'validation' stamp: 'RL 11/1/2020 12:55:45'!
validate: aPlayer andMoveFrom: aPosition to: anotherPosition
	aPlayer movePieceOnXturnFrom: aPosition to: anotherPosition.! !


!TerniLapilliPlayerXTurn methodsFor: 'queries' stamp: 'RL 11/1/2020 11:05:56'!
isPlayerOTurn
	^false.! !

!TerniLapilliPlayerXTurn methodsFor: 'queries' stamp: 'RL 11/1/2020 11:06:03'!
isPlayerXTurn
	^true.! !


!TerniLapilliPlayerXTurn methodsFor: 'operations' stamp: 'RL 11/1/2020 11:10:58'!
next
	^TerniLapilliPlayerOTurn new.! !
