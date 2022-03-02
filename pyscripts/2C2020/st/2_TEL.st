!classDefinition: #TerniLapilliTest category: 'TerniLapilli'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/31/2020 19:00:21'!
test01PlayerXShouldStart
	| game |
	
	game := TerniLapilli new.
	self assert: game isPlayingX.
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/29/2020 17:46:22'!
test02PlayerXShouldEndTurnAfterPlaying
	| game |
	game := TerniLapilli new.
	
	game putXAt: 2@2.
	
	self assert: game isPlayingO.
	self deny: game isPlayingX.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/29/2020 17:46:42'!
test03PlayerOShouldNotBeAbleToPlayAtGameStart
	| game |
	game := TerniLapilli new.
	
	self should: [game putOAt: 2@2] raise: Error withMessageText: TerniLapilli invalidMoveMessage.
	
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/29/2020 18:13:29'!
test04PlayerXShouldGoAfterO
	| game |
	game := TerniLapilli new.
	
	game putXAt: 1@1.
	game putOAt: 2@2.
	
	self assert: game isPlayingX.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/29/2020 18:16:29'!
test05PlayerXShouldNotBeAbleToPlayWhenIsOsTurn
	| game |
	game := TerniLapilli new.
	
	game putXAt: 1@1.
	self should: [game putXAt: 2@2] raise: Error withMessageText: TerniLapilli invalidMoveMessage.
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/29/2020 19:37:54'!
test06XTokenShouldBePlacedOnBoard
	| game |
	game := TerniLapilli new.
	
	game putXAt: 1@1.
	
	self assert: (game isXAt: 1@1).
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/29/2020 19:38:07'!
test07OTokenShouldBePlacedOnBoard
	| game |
	game := TerniLapilli new.
	
	game putXAt: 1@1.
	game putOAt: 2@1.
	
	self assert: (game isOAt: 2@1).
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/29/2020 19:40:25'!
test10OPlayerShouldNotBeAbleToPlayOnOccupiedCell
	| game |
	game := TerniLapilli new.
	
	game putXAt: 1@1.
	self should: [game putOAt: 1@1.] raise: Error withMessageText: TerniLapilli invalidMoveMessage. 
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/29/2020 19:41:02'!
test11XPlayerShouldNotBeAbleToPlayOnOccupiedCell
	| game |
	game := TerniLapilli new.
	
	game putXAt: 1@1.
	game putOAt: 2@1.
	self should: [game putXAt: 1@1.] raise: Error withMessageText: TerniLapilli invalidMoveMessage. 
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/29/2020 20:18:39'!
test12XPlayerShouldNotBeAbleToPlayOnOutOfBoundsCell
	| game |
	game := TerniLapilli new.
	
	self should: [game putXAt: 4@1.] raise: Error withMessageText: TerniLapilli outOfBoundsMoveMessage. 
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/29/2020 20:17:21'!
test13GameShouldNotBeOverAtStart
	| game |
	game := TerniLapilli new.
	
	game putXAt: 1@1.
	
	self deny: game isOver.
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/29/2020 19:42:27'!
test14OPlayerShouldWinWhenCompletingARow
	| game |
	game := TerniLapilli new.
	
	game putXAt: 3@1.
	game putOAt: 1@1.
	game putXAt: 2@2.
	game putOAt: 1@2.
	game putXAt: 3@3.
	game putOAt: 1@3.
	
	self assert: game isOver.
	self assert: game hasPlayerOWon.
	self deny:   game hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/29/2020 20:17:33'!
test15XPlayerShouldWinWhenCompletingARow
	| game |
	game := TerniLapilli new.
	
	game putXAt: 1@1.
	game putOAt: 2@2.
	game putXAt: 1@2.
	game putOAt: 3@3.
	game putXAt: 1@3.
	
	self assert: game isOver.
	self assert: game hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/29/2020 20:37:33'!
test16XPlayerShouldWinWhenCompletingAColumn
	| game |
	game := TerniLapilli new.
	
	game putXAt: 1@1.
	game putOAt: 2@2.
	game putXAt: 2@1.
	game putOAt: 3@3.
	game putXAt: 3@1.
	
	self assert: game isOver.
	self assert: game hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/29/2020 20:37:47'!
test17OPlayerShouldWinWhenCompletingAColumn
	| game |
	game := TerniLapilli new.
	
	game putXAt: 1@2.
	game putOAt: 1@1.
	game putXAt: 2@2.
	game putOAt: 2@1.
	game putXAt: 3@3.
	game putOAt: 3@1.
	
	self assert: game isOver.
	self assert: game hasPlayerOWon.
	self deny:   game hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/29/2020 20:38:05'!
test18XPlayerShouldWinWhenCompletingADiagonal
	| game |
	game := TerniLapilli new.
	
	game putXAt: 1@1.
	game putOAt: 1@2.
	game putXAt: 2@2.
	game putOAt: 2@1.
	game putXAt: 3@3.

	
	self assert: game isOver.
	self assert: game hasPlayerXWon.
	self deny:   game hasPlayerOWon.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/29/2020 20:38:13'!
test19OPlayerShouldWinWhenCompletingADiagonal
	| game |
	game := TerniLapilli new.
	
	game putXAt: 3@1.
	game putOAt: 1@1.
	game putXAt: 1@2.
	game putOAt: 2@2.
	game putXAt: 2@1.
	game putOAt: 3@3.

	
	self assert: game isOver.
	self assert: game hasPlayerOWon.
	self deny:   game hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/29/2020 20:45:32'!
test20XPlayerShouldNotBeAbleToPlayOnGameOver
	| game |
	game := TerniLapilli new.
	
	game putXAt: 3@1.
	game putOAt: 1@1.
	game putXAt: 1@2.
	game putOAt: 2@2.
	game putXAt: 2@1.
	game putOAt: 3@3.
	
	self should: [game putXAt:  2@3] raise: Error withMessageText: TerniLapilli gameOverMessage .
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/29/2020 20:51:34'!
test21XPlayerShouldNotHaveMoreThanThreeTokens
	| game |
	game := TerniLapilli new.
	
	game putXAt: 1@2.
	game putOAt: 2@2.
	game putXAt: 1@3.
	game putOAt: 2@3.
	game putXAt: 3@3.
	game putOAt: 3@1.
	
	self should: [game putXAt:  1@1] raise: Error withMessageText: TerniLapilli tokenLimitExceededMessage .
	
	self deny: game isOver.
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/31/2020 17:21:52'!
test22XPlayerShouldMoveCorrectly
	| game |
	game := TerniLapilli new.
	
	game putXAt: 1@2.
	game putOAt: 2@2.
	game putXAt: 1@3.
	game putOAt: 2@3.
	game putXAt: 3@3.
	game putOAt: 3@1.
	
	game moveXFrom: 1@2 to: 1@1.
	
	self assert: (game isXAt: 1@1).
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/31/2020 17:36:44'!
test23XPlayerShouldNotMoveInvalidToken
	| game |
	game := TerniLapilli new.
	
	game putXAt: 1@2.
	game putOAt: 2@2.
	game putXAt: 1@3.
	game putOAt: 2@3.
	game putXAt: 3@3.
	game putOAt: 3@1.
	
	self should: [game moveXFrom: 2@2 to: 1@1] raise: Error withMessageText: TerniLapilli invalidMoveMessage.	

	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/31/2020 17:22:59'!
test24XPlayerShouldNotOverlapTokens
	| game |
	game := TerniLapilli new.
	
	game putXAt: 1@2.
	game putOAt: 2@2.
	game putXAt: 1@3.
	game putOAt: 2@3.
	game putXAt: 3@3.
	game putOAt: 3@1.
	
	self should: [game moveXFrom: 1@2 to: 2@2] raise: Error withMessageText: TerniLapilli invalidMoveMessage.	

	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/31/2020 17:23:45'!
test25XPlayerShouldNotMoveWhenIsOTurn
	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 1@2.
	game putOAt: 2@2.
	game putXAt: 1@3.
	game putOAt: 2@3.
	game putXAt: 3@3.
	game putOAt: 3@1.
	game moveXFrom: 1@2 to: 1@1.
	
	self should: [	game moveXFrom: 1@1 to: 1@2] raise: Error withMessageText: TerniLapilli invalidMoveMessage.
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/31/2020 18:14:01'!
test26XPlayerShouldNotMoveMoreThanOneSlot
	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 1@2.
	game putOAt: 2@2.
	game putXAt: 1@3.
	game putOAt: 2@3.
	game putXAt: 3@3.
	game putOAt: 3@1.
	
	self should: [game moveXFrom: 1@2 to: 3@2] raise: Error withMessageText: TerniLapilli invalidMoveMessage.
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/31/2020 18:14:20'!
test27XPlayerShouldNotMoveBeforePlacingAllTokens
	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 1@2.
	game putOAt: 2@2.
	game putXAt: 1@3.
	game putOAt: 2@3.
	
	self should: [game moveXFrom: 1@2 to: 1@1] raise: Error withMessageText: TerniLapilli invalidMoveMessage.
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/31/2020 18:15:14'!
test28OPlayerShouldMoveCorrectly
	| game |
	game := TerniLapilli new.
	
	game putXAt: 1@2.
	game putOAt: 2@2.
	game putXAt: 1@3.
	game putOAt: 2@3.
	game putXAt: 3@3.
	game putOAt: 3@1.
	
	game moveXFrom: 1@2 to: 1@1.
	game moveOFrom: 3@1 to: 3@2.
	self assert: (game isOAt: 3@2).
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/31/2020 18:20:59'!
test29OPlayerShouldNotMoveInvalidToken
	| game |
	game := TerniLapilli new.
	
	game putXAt: 1@2.
	game putOAt: 2@2.
	game putXAt: 1@3.
	game putOAt: 2@3.
	game putXAt: 3@3.
	game putOAt: 3@1.
	
	game moveXFrom: 1@2 to: 1@1.
	self should: [game moveOFrom: 3@3 to: 3@2] raise: Error withMessageText: TerniLapilli invalidMoveMessage.
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/31/2020 18:22:47'!
test30OPlayerShouldNotOverlapTokens
	| game |
	game := TerniLapilli new.
	
	game putXAt: 1@2.
	game putOAt: 2@2.
	game putXAt: 1@3.
	game putOAt: 2@3.
	game putXAt: 3@3.
	game putOAt: 3@1.
	
	game moveXFrom: 1@2 to: 1@1.
	
	self should: [ game moveOFrom: 2@2 to: 2@3 ] raise: Error withMessageText: TerniLapilli invalidMoveMessage.	

	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/31/2020 18:23:55'!
test31OPlayerShouldNotMoveWhenIsXTurn
	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 1@2.
	game putOAt: 2@2.
	game putXAt: 1@3.
	game putOAt: 2@3.
	game putXAt: 3@3.
	game putOAt: 3@1.
	
	self should: [	game moveOFrom: 2@2 to: 3@2] raise: Error withMessageText: TerniLapilli invalidMoveMessage.
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/31/2020 18:24:52'!
test32OPlayerShouldNotMoveMoreThanOneSlot
	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 1@2.
	game putOAt: 2@2.
	game putXAt: 1@3.
	game putOAt: 2@3.
	game putXAt: 3@3.
	game putOAt: 3@1.
	
	game moveXFrom: 1@2 to: 1@1.
	
	self should: [game moveOFrom: 3@1 to: 1@2] raise: Error withMessageText: TerniLapilli invalidMoveMessage.
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FC 10/31/2020 18:25:30'!
test33OPlayerShouldNotMoveBeforePlacingAllTokens
	| game |
	
	game := TerniLapilli new.
	
	game putXAt: 1@2.
	game putOAt: 2@2.
	game putXAt: 1@3.
	
	self should: [game moveOFrom: 2@2 to: 1@1] raise: Error withMessageText: TerniLapilli invalidMoveMessage.
	! !


!classDefinition: #TerniLapilli category: 'TerniLapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'xTokens oTokens state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'initialization' stamp: 'FC 10/31/2020 18:48:49'!
initialize 
	xTokens := OrderedCollection new.
	oTokens := OrderedCollection new.
	state := XPlacingState for: self.! !


!TerniLapilli methodsFor: 'testing' stamp: 'FC 10/29/2020 20:36:02'!
hasPlayerOWon
	^ self hasOWinningRow or: [self hasOWinningColumn  or: [ self hasOWinningDiagonal ]].! !

!TerniLapilli methodsFor: 'testing' stamp: 'FC 10/29/2020 20:31:21'!
hasPlayerXWon
	^self hasXWinningRow or: [self hasXWinningColumn or: [ self hasXWinningDiagonal ]].! !

!TerniLapilli methodsFor: 'testing' stamp: 'FC 10/29/2020 18:30:42'!
isOAt: aPoint 
	^oTokens includes: aPoint.! !

!TerniLapilli methodsFor: 'testing' stamp: 'FC 10/31/2020 17:11:38'!
isOver
	^state isOver.! !

!TerniLapilli methodsFor: 'testing' stamp: 'FC 10/31/2020 17:04:44'!
isPlayingO
	^state isPlayingO.! !

!TerniLapilli methodsFor: 'testing' stamp: 'FC 10/31/2020 17:04:36'!
isPlayingX
	^state isPlayingX.! !

!TerniLapilli methodsFor: 'testing' stamp: 'FC 10/29/2020 18:28:55'!
isXAt: aPoint 
	^xTokens includes: aPoint.! !


!TerniLapilli methodsFor: 'movements' stamp: 'FC 10/31/2020 18:46:51'!
moveOFrom: aPointSource to: aPointDestiny 
	
	state moveOFrom: aPointSource to: aPointDestiny.! !

!TerniLapilli methodsFor: 'movements' stamp: 'FC 10/31/2020 18:46:19'!
moveXFrom: aPointSource to: aPointDestiny 
	
	state moveXFrom: aPointSource to: aPointDestiny.! !

!TerniLapilli methodsFor: 'movements' stamp: 'FC 10/31/2020 17:01:10'!
putOAt: aPoint 
	state putOAt: aPoint.! !

!TerniLapilli methodsFor: 'movements' stamp: 'FC 10/31/2020 17:10:57'!
putXAt: aPoint 
	state putXAt: aPoint.
! !


!TerniLapilli methodsFor: 'testing - private' stamp: 'FC 10/31/2020 18:53:10'!
hasOWinningColumn

	^(1 to: 3) anySatisfy: [ :colNumber | (self isOAt: 1@colNumber) and: [ (self isOAt: 2@colNumber) and: [ self isOAt: 3@colNumber ] ] ].! !

!TerniLapilli methodsFor: 'testing - private' stamp: 'FC 10/29/2020 20:35:23'!
hasOWinningDiagonal

	^((1 to: 3) allSatisfy: [ :n | self isOAt: n@n  ]) or: [ 
		(1 to: 3) allSatisfy:  [ :n | self isOAt: n@(4-n)]
		].! !

!TerniLapilli methodsFor: 'testing - private' stamp: 'FC 10/29/2020 18:59:27'!
hasOWinningRow

	^(1 to: 3) anySatisfy: [ :rowNumber | (self isOAt: rowNumber@1) and: [ (self isOAt: rowNumber@2) and: [ self isOAt: rowNumber@3 ] ] ].! !

!TerniLapilli methodsFor: 'testing - private' stamp: 'FC 10/29/2020 20:24:54'!
hasXWinningColumn

	^(1 to: 3) anySatisfy: [ :colNumber | (self isXAt: 1@colNumber) and: [ (self isXAt: 2@colNumber) and: [ self isXAt: 3@colNumber ] ] ].! !

!TerniLapilli methodsFor: 'testing - private' stamp: 'FC 10/29/2020 20:35:03'!
hasXWinningDiagonal

	^((1 to: 3) allSatisfy: [ :n | self isXAt: n@n  ]) or: [ 
		(1 to: 3) allSatisfy:  [ :n | self isXAt: n@(4-n)]
		].! !

!TerniLapilli methodsFor: 'testing - private' stamp: 'FC 10/29/2020 18:55:35'!
hasXWinningRow

	^(1 to: 3) anySatisfy: [ :rowNumber | (self isXAt: rowNumber@1) and: [ (self isXAt: rowNumber@2) and: [ self isXAt: rowNumber@3 ] ] ].! !

!TerniLapilli methodsFor: 'testing - private' stamp: 'FC 10/31/2020 16:37:33'!
isOccupied: aPoint
	^(self isXAt: aPoint) or: [self isOAt: aPoint ]! !

!TerniLapilli methodsFor: 'testing - private' stamp: 'FC 10/29/2020 20:20:38'!
isValidPosition: aPoint 
	^ (aPoint x between: 1 and: 3) and: [ aPoint y between: 1 and: 3 ]. ! !


!TerniLapilli methodsFor: 'movements - private' stamp: 'FC 10/31/2020 18:46:39'!
moveOWhenValidFrom: aPointSource to: aPointDestiny 
	
	self validateMoveFrom: aPointSource to: aPointDestiny.
	(self isOAt: aPointSource) ifFalse: [self error: self class invalidMoveMessage ].
		
	oTokens remove: aPointSource. 
	oTokens add: aPointDestiny.
	
	self hasPlayerOWon 
	ifTrue: 
		[ state := GameOverState for: self] 
	ifFalse: 
		[state := XMovingState for: self.		]! !

!TerniLapilli methodsFor: 'movements - private' stamp: 'FC 10/31/2020 18:45:53'!
moveXWhenValidFrom: aPointSource to: aPointDestiny 
	
	self validateMoveFrom: aPointSource to: aPointDestiny.
	(self isXAt: aPointSource) ifFalse: [self error: self class invalidMoveMessage ].
		
	xTokens remove: aPointSource. 
	xTokens add: aPointDestiny.
	
	self hasPlayerXWon 
	ifTrue: 
		[ state := GameOverState for: self] 
	ifFalse: 
		[state := OMovingState for: self.		]! !

!TerniLapilli methodsFor: 'movements - private' stamp: 'FC 10/31/2020 18:54:17'!
putOAtWhenValid: aPoint 

	self validatePlacement: aPoint for: oTokens. 
	oTokens add: aPoint.
	self hasPlayerOWon 
	ifTrue: 
		[ state := GameOverState for: self] 
	ifFalse: 
		[	xTokens size < 3 ifTrue: [
				state := XPlacingState for: self.		
			] ifFalse: [
				state := XMovingState for: self.
			]
		]! !

!TerniLapilli methodsFor: 'movements - private' stamp: 'FC 10/31/2020 18:54:28'!
putXAtWhenValid: aPoint 

	self validatePlacement: aPoint for: xTokens.
	xTokens add: aPoint.
	self hasPlayerXWon 
	ifTrue: 
		[ state := GameOverState for: self] 
	ifFalse: 
		[	oTokens size < 3 ifTrue: [
				state := OPlacingState for: self.		
			] ifFalse: [
				state := OMovingState for: self.
			]
		]! !


!TerniLapilli methodsFor: 'validations' stamp: 'FC 10/31/2020 18:45:37'!
validateMoveFrom: aPointSource to: aPointDestiny

	(((aPointDestiny dist: aPointSource) = 1) or: [aPointDestiny = (2@2) or: [aPointSource = (2@2)]]) ifFalse: [ self error: self class invalidMoveMessage] .
	(self isOccupied: aPointDestiny) ifTrue: [self error: self class invalidMoveMessage ]! !

!TerniLapilli methodsFor: 'validations' stamp: 'FC 10/31/2020 18:53:55'!
validatePlacement: aPoint for: tokens

	(self isValidPosition: aPoint) ifFalse: [ self error: self class outOfBoundsMoveMessage ]. 
	(self isOccupied: aPoint) ifTrue: [ 		self error: self class invalidMoveMessage. ].
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: 'TerniLapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error' stamp: 'FC 10/29/2020 20:42:29'!
gameOverMessage
	^'Game is over'.! !

!TerniLapilli class methodsFor: 'error' stamp: 'FC 10/29/2020 17:43:27'!
invalidMoveMessage
	^'Movete bien gato'.! !

!TerniLapilli class methodsFor: 'error' stamp: 'FC 10/29/2020 20:19:00'!
outOfBoundsMoveMessage
	^'Movete bien gato'.! !

!TerniLapilli class methodsFor: 'error' stamp: 'FC 10/29/2020 20:48:38'!
tokenLimitExceededMessage
	^'Ya hay 3 piezas'! !


!classDefinition: #TerniLapilliState category: 'TerniLapilli'!
Object subclass: #TerniLapilliState
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliState methodsFor: 'as yet unclassified' stamp: 'FC 10/31/2020 16:47:27'!
initializeFor: aTerniLapilli
	game := aTerniLapilli.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliState class' category: 'TerniLapilli'!
TerniLapilliState class
	instanceVariableNames: ''!

!TerniLapilliState class methodsFor: 'nil' stamp: 'FC 10/31/2020 17:03:01'!
for: aTerniLapilli
	^self new initializeFor: aTerniLapilli! !


!classDefinition: #GameOverState category: 'TerniLapilli'!
TerniLapilliState subclass: #GameOverState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!GameOverState methodsFor: 'testing' stamp: 'FC 10/31/2020 16:58:58'!
isOver
	 ^true.
	! !


!GameOverState methodsFor: 'movements' stamp: 'FC 10/31/2020 17:20:52'!
moveOFrom: aPoint to: aPoint2 
	self error: TerniLapilli gameOverMessage.! !

!GameOverState methodsFor: 'movements' stamp: 'FC 10/31/2020 17:20:48'!
moveXFrom: aPoint to: aPoint2 
	self error: TerniLapilli gameOverMessage.! !

!GameOverState methodsFor: 'movements' stamp: 'FC 10/31/2020 17:05:52'!
putOAt: aPoint
	self error: TerniLapilli gameOverMessage
	! !

!GameOverState methodsFor: 'movements' stamp: 'FC 10/31/2020 17:05:41'!
putXAt: aPoint
	self error: TerniLapilli gameOverMessage
	! !


!classDefinition: #OTurnState category: 'TerniLapilli'!
TerniLapilliState subclass: #OTurnState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!OTurnState methodsFor: 'testing' stamp: 'FC 10/31/2020 16:59:17'!
isOver
	^false.! !

!OTurnState methodsFor: 'testing' stamp: 'FC 10/31/2020 17:03:36'!
isPlayingO
	^true.! !

!OTurnState methodsFor: 'testing' stamp: 'FC 10/31/2020 17:03:41'!
isPlayingX
	^false.! !


!OTurnState methodsFor: 'movements' stamp: 'FC 10/31/2020 18:49:46'!
moveXFrom: aPointSource to: aPointDestiny 
	self error: TerniLapilli invalidMoveMessage.! !

!OTurnState methodsFor: 'movements' stamp: 'FC 10/31/2020 16:49:33'!
putXAt: aPoint
	self error: TerniLapilli invalidMoveMessage.! !


!classDefinition: #OMovingState category: 'TerniLapilli'!
OTurnState subclass: #OMovingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!OMovingState methodsFor: 'movements' stamp: 'FC 10/31/2020 18:50:22'!
moveOFrom: aPointSource to: aPointDestiny 
	game moveOWhenValidFrom: aPointSource  to: aPointDestiny. ! !

!OMovingState methodsFor: 'movements' stamp: 'FC 10/31/2020 18:43:35'!
putOAt: aPoint
	self error: TerniLapilli tokenLimitExceededMessage.! !


!classDefinition: #OPlacingState category: 'TerniLapilli'!
OTurnState subclass: #OPlacingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!OPlacingState methodsFor: 'movements' stamp: 'FC 10/31/2020 18:50:33'!
moveOFrom: aPointSource to: aPointDestiny 
	self error: TerniLapilli invalidMoveMessage.! !

!OPlacingState methodsFor: 'movements' stamp: 'FC 10/31/2020 18:32:09'!
putOAt: aPoint
	game putOAtWhenValid: aPoint.! !


!classDefinition: #XTurnState category: 'TerniLapilli'!
TerniLapilliState subclass: #XTurnState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!XTurnState methodsFor: 'movements' stamp: 'FC 10/31/2020 18:49:29'!
moveOFrom: aPointSource to: aPointDestiny 
	self error: TerniLapilli invalidMoveMessage.! !

!XTurnState methodsFor: 'movements' stamp: 'FC 10/31/2020 18:48:13'!
putOAt: aPoint 
	self error: TerniLapilli invalidMoveMessage.! !


!XTurnState methodsFor: 'testing' stamp: 'FC 10/31/2020 16:59:22'!
isOver
	^false.! !

!XTurnState methodsFor: 'testing' stamp: 'FC 10/31/2020 17:03:57'!
isPlayingO
	^false.! !

!XTurnState methodsFor: 'testing' stamp: 'FC 10/31/2020 17:03:53'!
isPlayingX
	^true.! !


!classDefinition: #XMovingState category: 'TerniLapilli'!
XTurnState subclass: #XMovingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!XMovingState methodsFor: 'movements' stamp: 'FC 10/31/2020 18:50:47'!
moveXFrom: aPointSource to: aPointDestiny 
	game moveXWhenValidFrom: aPointSource  to: aPointDestiny. ! !

!XMovingState methodsFor: 'movements' stamp: 'FC 10/31/2020 18:44:31'!
putXAt: aPoint
	self error: TerniLapilli tokenLimitExceededMessage.! !


!classDefinition: #XPlacingState category: 'TerniLapilli'!
XTurnState subclass: #XPlacingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!XPlacingState methodsFor: 'movements' stamp: 'FC 10/31/2020 18:44:24'!
moveXFrom: aPoint to: aPoint2 
	self error: TerniLapilli invalidMoveMessage.! !

!XPlacingState methodsFor: 'movements' stamp: 'FC 10/31/2020 18:37:26'!
putXAt: aPoint
	game putXAtWhenValid: aPoint.! !
