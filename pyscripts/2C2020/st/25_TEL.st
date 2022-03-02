!classDefinition: #TableTest category: 'Terni-Lapilli'!
TestCase subclass: #TableTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapilli'!

!TableTest methodsFor: 'GameOverTests' stamp: 'D S 11/1/2020 20:44:32'!
test11XTokensInAscendingDiagonalEndsGame

	|aGame|
	aGame := Game startGame.
	aGame putXAt: 0@0.
	aGame putOAt: 0@1.
	aGame putXAt: 1@1.
	aGame putOAt: 1@2.

	^ [	aGame putXAt: 2@2..	
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (Game menuDescriptionPlayerXWon )).].
! !

!TableTest methodsFor: 'GameOverTests' stamp: 'D S 11/1/2020 20:44:39'!
test12OTokensInAscendingDiagonalEndsGame

	|aGame|
	
	aGame := Game startGame.
	aGame putXAt: 0@1.
	aGame putOAt: 0@0.
	aGame putXAt: 1@2.
	aGame putOAt: 1@1.
	aGame putXAt: 2@1.

	^ [	aGame putOAt: 2@2.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (Game menuDescriptionPlayerOWon )).].! !

!TableTest methodsFor: 'GameOverTests' stamp: 'D S 11/1/2020 20:44:43'!
test13XTokensInDescendingDiagonalEndsGame

	|aGame|
	
	aGame := Game startGame.
	aGame putXAt: 0@2.
	aGame putOAt: 0@0.
	aGame putXAt: 1@1.
	aGame putOAt: 1@2.
	
	^ [	aGame putXAt: 2@0.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (Game menuDescriptionPlayerXWon )).].! !

!TableTest methodsFor: 'GameOverTests' stamp: 'D S 11/1/2020 20:44:50'!
test14OTokensInDescendingDiagonalEndsGame

	|aGame|
	
	aGame := Game startGame.
	aGame putXAt: 0@1.
	aGame putOAt: 0@2.
	aGame putXAt: 1@2.
	aGame putOAt: 1@1.
	aGame putXAt: 2@1.

	^ [	aGame putOAt: 2@0.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (Game menuDescriptionPlayerOWon )).].! !

!TableTest methodsFor: 'GameOverTests' stamp: 'D S 11/1/2020 20:44:55'!
test15ThreeXTokensInMiddleRowEndGame

	|aGame|
	
	aGame := Game startGame.
	aGame putXAt: 1@1.
	aGame putOAt: 0@0.
	aGame putXAt: 0@1.
	aGame putOAt: 1@0.
	^ [	aGame putXAt: 2@1.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (Game menuDescriptionPlayerXWon )).].! !

!TableTest methodsFor: 'GameOverTests' stamp: 'D S 11/1/2020 20:45:03'!
test16ThreeOTokensInMiddleRowEndGame

	|aGame|
	
	aGame := Game startGame.
	aGame putXAt: 0@0.
	aGame putOAt: 1@1.
	aGame putXAt: 1@0.
	aGame putOAt: 0@1.
	aGame putXAt: 2@2.

	^ [	aGame putOAt: 2@1.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (Game menuDescriptionPlayerOWon )).].! !

!TableTest methodsFor: 'GameOverTests' stamp: 'D S 11/1/2020 20:45:10'!
test17ThreeXTokensInBottomRowEndGame

	|aGame|
	
	aGame := Game startGame.
	aGame putXAt: 1@0.
	aGame putOAt: 1@2.
	aGame putXAt: 0@0.
	aGame putOAt: 2@2.
	
	^ [	aGame putXAt: 2@0.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (Game menuDescriptionPlayerXWon )).].! !

!TableTest methodsFor: 'GameOverTests' stamp: 'D S 11/1/2020 18:58:28'!
test18ThreeXTokensInTopRowEndGame

	|aGame|
	
	aGame := Game startGame.
	aGame putXAt: 1@2.
	aGame putOAt: 1@1.
	aGame putXAt: 0@2.
	aGame putOAt: 0@0.

	^ [	aGame putXAt: 2@2.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (Game menuDescriptionPlayerXWon )).].! !

!TableTest methodsFor: 'GameOverTests' stamp: 'D S 11/1/2020 20:45:24'!
test19ThreeOTokensInBottomRowEndGame

	|aGame|
	
	aGame := Game startGame.
	aGame putXAt: 1@1.
	aGame putOAt: 0@0.
	aGame putXAt: 2@2.
	aGame putOAt: 1@0.
	aGame putXAt: 2@1.

	^ [	aGame putOAt: 2@0.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (Game menuDescriptionPlayerOWon )).].! !

!TableTest methodsFor: 'GameOverTests' stamp: 'D S 11/1/2020 20:45:35'!
test20ThreeOTokensInTopRowEndGame

	|aGame|
	
	aGame := Game startGame.
	aGame putXAt: 1@1.
	aGame putOAt: 1@2.
	aGame putXAt: 0@0.
	aGame putOAt: 0@2.
	aGame putXAt: 1@0.
	
	^ [	aGame putOAt: 2@2.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (Game menuDescriptionPlayerOWon )).].! !

!TableTest methodsFor: 'GameOverTests' stamp: 'D S 11/1/2020 20:45:45'!
test21ThreeXTokensInSecondColumnEndGame

	|aGame|
	
	aGame := Game startGame.
	aGame putXAt: 1@1.
	aGame putOAt: 0@0.
	aGame putXAt: 1@2.
	aGame putOAt: 0@2.

	^ [	aGame putXAt: 1@0.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (Game menuDescriptionPlayerXWon )).].! !

!TableTest methodsFor: 'GameOverTests' stamp: 'D S 11/1/2020 20:45:49'!
test22ThreeOTokensInSecondColumnEndGame

	|aGame|
	
	aGame := Game startGame.
	aGame putXAt: 0@0.
	aGame putOAt: 1@1.
	aGame putXAt: 0@2.
	aGame putOAt: 1@2.
	aGame putXAt: 2@2.
	^ [	aGame putOAt: 1@0.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (Game menuDescriptionPlayerOWon )).].! !

!TableTest methodsFor: 'GameOverTests' stamp: 'D S 11/1/2020 20:45:54'!
test23ThreeXTokensInFirstColumnEndGame

	|aGame|
	
	aGame := Game startGame.
	aGame putXAt: 0@1.
	aGame putOAt: 1@0.
	aGame putXAt: 0@2.
	aGame putOAt: 1@2.

	^ [	aGame putXAt: 0@0.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (Game menuDescriptionPlayerXWon )).].! !

!TableTest methodsFor: 'GameOverTests' stamp: 'D S 11/1/2020 20:45:59'!
test24ThreeOTokensInFirstColumnEndGame

	|aGame|
	
	aGame := Game startGame.
	aGame putXAt: 1@1.
	aGame putOAt: 0@1.
	aGame putXAt: 1@2.
	aGame putOAt: 0@2.
	aGame putXAt: 2@2.
	
	^ [	aGame putOAt: 0@0.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (Game menuDescriptionPlayerOWon )).].! !

!TableTest methodsFor: 'GameOverTests' stamp: 'D S 11/1/2020 20:46:03'!
test25ThreeXTokensInThirdColumnEndGame

	|aGame|
	
	aGame := Game startGame.
	aGame putXAt: 2@1.
	aGame putOAt: 1@0.
	aGame putXAt: 2@2.
	aGame putOAt: 1@2.

	^ [	aGame putXAt: 2@0.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (Game menuDescriptionPlayerXWon )).].! !

!TableTest methodsFor: 'GameOverTests' stamp: 'D S 11/1/2020 20:46:10'!
test26ThreeOTokensInThirdColumnEndGame

	|aGame|
	
	aGame := Game startGame.
	aGame putXAt: 1@1.
	aGame putOAt: 2@0.
	aGame putXAt: 1@2.
	aGame putOAt: 2@2.
	aGame putXAt: 0@0.
	
	^ [	aGame putOAt: 2@1.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (Game menuDescriptionPlayerOWon )).].! !


!TableTest methodsFor: 'MoveTokenTests' stamp: 'D S 11/2/2020 14:31:01'!
test09PlayerXMovesTokenCorrectly

	|aGame|
	
	aGame := Game startGame.
	aGame putXAt: 0@2.
	aGame putOAt: 0@1.
	aGame putXAt: 1@1.
	aGame putOAt: 0@0.
	aGame putXAt: 2@1.
	aGame putOAt: 2@2.
	aGame xMoveTokenFrom: 0@2 to: 1@2.

	self assert: (aGame playerXHasATokenIn: (1@2)).
	self assert: (aGame playerXHasATokenIn: (1@1)).
	self assert: (aGame playerXHasATokenIn: (2@1)).! !

!TableTest methodsFor: 'MoveTokenTests' stamp: 'D S 11/2/2020 14:30:57'!
test10PlayerOMovesTokenCorrectly

	|aGame|
	
	aGame := Game startGame.
	aGame putXAt: 0@1.
	aGame putOAt: 0@2.
	aGame putXAt: 0@0.
	aGame putOAt: 1@1.
	aGame putXAt: 2@2.
	aGame putOAt: 2@1.
	aGame xMoveTokenFrom: 0@0 to: 1@0.
	aGame oMoveTokenFrom: 0@2 to: 1@2.
	
	self assert: (aGame playerOHasATokenIn: (1@2)).
	self assert: (aGame playerOHasATokenIn: (1@1)).
	self assert: (aGame playerOHasATokenIn: (2@1)).
! !

!TableTest methodsFor: 'MoveTokenTests' stamp: 'D S 11/1/2020 20:54:35'!
test39RaiseErrorWhenMovingTokenXWhereThereIsATokenO
	|aGame|
	aGame := Game startGame.
	aGame putXAt: 0@2.
	aGame putOAt: 2@0.
	aGame putXAt: 1@1.
	aGame putOAt: 0@0.
	aGame putXAt: 2@1.
	aGame putOAt: 2@2.
	^ [aGame xMoveTokenFrom: 2@1 to: 2@2.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (Game errorDescriptionOponentTokenInPosition)).].

	! !

!TableTest methodsFor: 'MoveTokenTests' stamp: 'D S 11/1/2020 20:54:40'!
test40RaiseErrorWhenMovingTokenXWhereThereIsATokenX
	|aGame|
	aGame := Game startGame.
	aGame putXAt: 0@2.
	aGame putOAt: 2@0.
	aGame putXAt: 1@1.
	aGame putOAt: 0@0.
	aGame putXAt: 2@1.
	aGame putOAt: 2@2.
	^ [aGame xMoveTokenFrom: 2@1 to: 1@1.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (PlayerX errorDescriptionOwnTokenThere )).].

	! !

!TableTest methodsFor: 'MoveTokenTests' stamp: 'D S 11/1/2020 20:54:45'!
test41RaiseErrorWhenMovingTokenOWhereThereIsATokenX
	|aGame|
	aGame := Game startGame.
	aGame putXAt: 0@2.
	aGame putOAt: 2@0.
	aGame putXAt: 1@1.
	aGame putOAt: 0@0.
	aGame putXAt: 2@1.
	aGame putOAt: 2@2.
	aGame xMoveTokenFrom: 1@1 to: 1@2.
	^ [aGame oMoveTokenFrom: 2@2 to: 2@1.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (Game errorDescriptionOponentTokenInPosition)).].

	! !

!TableTest methodsFor: 'MoveTokenTests' stamp: 'D S 11/1/2020 20:54:50'!
test42RaiseErrorWhenMovingTokenOWhereThereIsATokenO
	|aGame|
	aGame := Game startGame.
	aGame putXAt: 0@1.
	aGame putOAt: 2@1.
	aGame putXAt: 1@1.
	aGame putOAt: 0@0.
	aGame putXAt: 2@0.
	aGame putOAt: 2@2.
	aGame xMoveTokenFrom: 1@1 to: 1@2.
	^ [aGame oMoveTokenFrom: 2@2 to: 2@1.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (PlayerO errorDescriptionOwnTokenThere )).].

	! !

!TableTest methodsFor: 'MoveTokenTests' stamp: 'D S 11/1/2020 20:54:56'!
test43RaiseErrorWhenPlayerXTryAnInvalidMovement
	|aGame|
	aGame := Game startGame.
	aGame putXAt: 1@2.
	aGame putOAt: 0@1.
	aGame putXAt: 1@1.
	aGame putOAt: 0@0.
	aGame putXAt: 2@0.
	aGame putOAt: 2@2.
	
	^ [aGame xMoveTokenFrom: 1@2 to: 2@1.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (PlayerX errorDescriptionInvalidMovement)).].

	! !

!TableTest methodsFor: 'MoveTokenTests' stamp: 'D S 11/1/2020 20:55:01'!
test44RaiseErrorWhenPlayerOTryAnInvalidMovement
	|aGame|
	aGame := Game startGame.
	aGame putXAt: 0@1.
	aGame putOAt: 1@2.
	aGame putXAt: 0@0.
	aGame putOAt: 1@1.
	aGame putXAt: 2@2.
	aGame putOAt: 2@0.
	aGame xMoveTokenFrom: 0@1 to: 0@	2.
	^ [aGame oMoveTokenFrom: 1@2 to: 2@1.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (PlayerX errorDescriptionInvalidMovement)).].

	! !

!TableTest methodsFor: 'MoveTokenTests' stamp: 'D S 11/1/2020 20:55:08'!
test45RaiseErrorWhenPlayerXIsMovingTokenToFarFromOrigin

	|aGame|
	
	aGame := Game startGame.
	aGame putXAt: 0@1.
	aGame putOAt: 0@2.
	aGame putXAt: 0@0.
	aGame putOAt: 1@1.
	aGame putXAt: 1@0.
	aGame putOAt: 2@2.
	^ [aGame xMoveTokenFrom: 0@0 to: 2@1.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (PlayerX errorDescriptionInvalidMovement )).].
! !

!TableTest methodsFor: 'MoveTokenTests' stamp: 'D S 11/1/2020 20:55:13'!
test46RaiseErrorWhenPlayerOIsMovingTokenToFarFromOrigin

	|aGame|
	
	aGame := Game startGame.
	aGame putXAt: 0@1.
	aGame putOAt: 0@2.
	aGame putXAt: 0@0.
	aGame putOAt: 1@1.
	aGame putXAt: 2@2.
	aGame putOAt: 2@1.
	aGame xMoveTokenFrom: 0@0 to: 1@0.
	^ [aGame oMoveTokenFrom: 2@1 to: 0@0.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (PlayerO errorDescriptionInvalidMovement )).].
! !

!TableTest methodsFor: 'MoveTokenTests' stamp: 'D S 11/1/2020 20:55:19'!
test47RaiseErrorWhenPlayerXMoveATokenOutOfTheBoard
	|aGame|
	aGame := Game startGame.
	aGame putXAt: 1@2.
	aGame putOAt: 0@1.
	aGame putXAt: 1@1.
	aGame putOAt: 0@0.
	aGame putXAt: 2@0.
	aGame putOAt: 2@2.
	
	^ [aGame xMoveTokenFrom: 2@0 to: 3@0.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (PlayerX errorDescriptionOutOfRange)).].

	! !

!TableTest methodsFor: 'MoveTokenTests' stamp: 'D S 11/1/2020 20:55:24'!
test48RaiseErrorWhenPlayerOMoveATokenOutOfTheBoard
	|aGame|
	aGame := Game startGame.
	aGame putXAt: 1@2.
	aGame putOAt: 0@1.
	aGame putXAt: 1@1.
	aGame putOAt: 0@0.
	aGame putXAt: 2@0.
	aGame putOAt: 2@2.
	aGame xMoveTokenFrom: 1@1 to: 1@0.
	
	^ [aGame oMoveTokenFrom: 2@2 to: 3@2.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (PlayerO errorDescriptionOutOfRange)).].

	! !

!TableTest methodsFor: 'MoveTokenTests' stamp: 'D S 11/1/2020 20:55:30'!
test49RaiseErrorWhenPlayerXInsertATokenLocationWithoutToken
	|aGame|
	aGame := Game startGame.
	aGame putXAt: 0@0.
	aGame putOAt: 1@0.
	aGame putXAt: 0@1.
	aGame putOAt: 1@1.
	aGame putXAt: 2@0.	
	aGame putOAt: 2@2.
	^[aGame xMoveTokenFrom: 2@2 to: 2@1.
		self fail]
		on: Error
		do: [:anError| self assert: (anError messageText = (PlayerX errorDescriptionNoTokenThere )).].	! !

!TableTest methodsFor: 'MoveTokenTests' stamp: 'D S 11/1/2020 20:55:37'!
test50RaiseErrorWhenPlayerOInsertATokenLocationWithoutToken
	|aGame|
	aGame := Game startGame.
	aGame putXAt: 0@0.
	aGame putOAt: 0@2.
	aGame putXAt: 0@1.
	aGame putOAt: 1@1.
	aGame putXAt: 2@0.	
	aGame putOAt: 2@2.
	aGame xMoveTokenFrom: 2@0 to: 2@1.
	^[aGame oMoveTokenFrom: 2@0 to: 1@0.
		self fail]
		on: Error
		do: [:anError| self assert: (anError messageText = (PlayerO errorDescriptionNoTokenThere )).].	! !

!TableTest methodsFor: 'MoveTokenTests' stamp: 'D S 11/1/2020 20:55:42'!
test51RaiseErrorWhenPlayerXTryMoveAOpponentToken
	|aGame|
	aGame := Game startGame.
	aGame putXAt: 0@0.
	aGame putOAt: 1@0.
	aGame putXAt: 0@1.
	aGame putOAt: 1@1.
	aGame putXAt: 2@0.	
	aGame putOAt: 2@2.
	^[aGame oMoveTokenFrom: 2@0 to: 2@1.
		self fail]
		on: Error
		do: [:anError| self assert: (anError messageText = (PlayerX errorDescriptionCantMoveOpponentTokens )).].	! !

!TableTest methodsFor: 'MoveTokenTests' stamp: 'D S 11/1/2020 20:55:47'!
test52RaiseErrorWhenPlayerOTryMoveOpponentToken
	|aGame|
	aGame := Game startGame.
	aGame putXAt: 0@0.
	aGame putOAt: 1@0.
	aGame putXAt: 0@1.
	aGame putOAt: 1@1.
	aGame putXAt: 2@0.	
	aGame putOAt: 2@2.
	aGame xMoveTokenFrom: 2@0 to: 2@1.
	^[aGame xMoveTokenFrom: 2@1 to: 2@0.
		self fail]
		on: Error
		do: [:anError| self assert: (anError messageText = (PlayerO errorDescriptionCantMoveOpponentTokens )).].	! !


!TableTest methodsFor: 'PutTokenTests' stamp: 'D S 11/2/2020 14:28:22'!
test04XTokenIsPlacedCorrectly

	|aGame|
	aGame := Game startGame.
	aGame putXAt: 0@0.
	
	self assert: (aGame playerXHasATokenIn: (0@0))! !

!TableTest methodsFor: 'PutTokenTests' stamp: 'D S 11/2/2020 14:28:50'!
test05OTokenIsPlacedCorrectly

	|aGame|
	aGame := Game startGame.
	aGame putXAt: 0@0.
	aGame putOAt: 1@1.

	self assert: (aGame playerOHasATokenIn: (1@1)).! !

!TableTest methodsFor: 'PutTokenTests' stamp: 'D S 11/1/2020 20:46:38'!
test27PuttingXTokenReduceRemainingXTokensCorrectly

	|aGame|
	
	aGame := Game startGame.
	aGame putXAt: 2@1.

	self assert: 2 equals: aGame playerXRemainingTokens .! !

!TableTest methodsFor: 'PutTokenTests' stamp: 'D S 11/1/2020 20:46:44'!
test28PuttingOTokenReduceRemainingOCorrectly

	|aGame|
	
	aGame := Game startGame.
	aGame putXAt: 2@1.
	aGame putOAt: 1@1.

	self assert: 2 equals: aGame playerORemainingTokens .! !

!TableTest methodsFor: 'PutTokenTests' stamp: 'D S 11/1/2020 20:47:56'!
test29RaiseErrorWhenPuttingOTokenInTurnOfPlayerX
	|aGame|
	aGame := Game startGame.
	
	^ [aGame putOAt: 0@0.	
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (PlayerX errorDescriptionTurnX)).].

	! !

!TableTest methodsFor: 'PutTokenTests' stamp: 'D S 11/1/2020 20:48:03'!
test30RaiseErrorWhenPuttingXTokenInTurnOfPlayerO
	|aGame|
	aGame := Game startGame.
	aGame putXAt: 1@1.
	^ [aGame putXAt: 0@0.	
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (PlayerO errorDescriptionTurnO)).].

	! !

!TableTest methodsFor: 'PutTokenTests' stamp: 'D S 11/1/2020 20:48:09'!
test31RaiseErrorWhenPuttingTokenXWhereThereIsATokenO
	|aGame|
	aGame := Game startGame.
	aGame putXAt: 0@0.
	
	^ [aGame putOAt: 0@0.	
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (Game errorDescriptionOponentTokenInPosition)).].

	! !

!TableTest methodsFor: 'PutTokenTests' stamp: 'D S 11/1/2020 20:48:13'!
test32RaiseErrorWhenPuttingTokenOWhereThereIsATokenX
	|aGame|
	aGame := Game startGame.
	aGame putXAt: 0@0.
	aGame putOAt: 1@1.
	
	^ [aGame putXAt: 1@1.	
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (Game errorDescriptionOponentTokenInPosition)).].

	! !

!TableTest methodsFor: 'PutTokenTests' stamp: 'D S 11/1/2020 20:48:19'!
test33RaiseErrorWhenPuttingTokenXWhereThereIsATokenX
	|aGame|
	aGame := Game startGame.
	aGame putXAt: 0@0.
	aGame putOAt: 1@1.
	
	^ [aGame putXAt: 0@0.	
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (PlayerX errorDescriptionOwnTokenThere)).].

	! !

!TableTest methodsFor: 'PutTokenTests' stamp: 'D S 11/1/2020 20:48:26'!
test34RaiseErrorWhenPuttingTokenOWhereThereIsATokenO
	|aGame|
	aGame := Game startGame.
	aGame putXAt: 0@0.
	aGame putOAt: 1@1.
	aGame putXAt: 2@2.
	^ [aGame putOAt: 1@1.	
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (PlayerO errorDescriptionOwnTokenThere)).].

	! !

!TableTest methodsFor: 'PutTokenTests' stamp: 'D S 11/1/2020 20:48:34'!
test35RaiseErrorWhenTryingToPutAFourthXToken
	|aGame|
	aGame := Game startGame.
	aGame putXAt: 0@1.
	aGame putOAt: 2@1.
	aGame putXAt: 1@1.
	aGame putOAt: 0@0.
	aGame putXAt: 2@0.
	aGame putOAt: 2@2.
	^ [aGame putXAt: 1@1.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (PlayerX errorDescriptionNoMoreTokens )).].

	! !

!TableTest methodsFor: 'PutTokenTests' stamp: 'D S 11/1/2020 20:48:39'!
test36RaiseErrorWhenTryingToPutAFourthOToken
	|aGame|
	aGame := Game startGame.
	aGame putXAt: 1@0.
	aGame putOAt: 2@1.
	aGame putXAt: 1@1.
	aGame putOAt: 0@0.
	aGame putXAt: 2@0.
	aGame putOAt: 2@2.
	aGame xMoveTokenFrom: 1@1 to: 1@2.
	^ [aGame putOAt: 0@1.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (PlayerO errorDescriptionNoMoreTokens )).].

	! !

!TableTest methodsFor: 'PutTokenTests' stamp: 'D S 11/1/2020 20:49:10'!
test37RaiseErrorWhenPlayerOPutATokenOutOfTheBoard
	|aGame|
	aGame := Game startGame.
	aGame := aGame putXAt: 1@1.
	^ [aGame putOAt: 3@1.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (PlayerO errorDescriptionOutOfRange)).].

! !

!TableTest methodsFor: 'PutTokenTests' stamp: 'D S 11/1/2020 20:49:15'!
test38RaiseErrorWhenPlayerXPutATokenOutOfTheBoard
	|aGame|
	aGame := Game startGame.
	^ [aGame putXAt: 3@1.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (PlayerX errorDescriptionOutOfRange)).].

	! !


!TableTest methodsFor: 'TurnTests' stamp: 'D S 11/2/2020 14:12:02'!
test06PlayerXDoesntMoveSecond

	|aGame|
	aGame := Game startGame.
	aGame putXAt: 0@0.

	self deny: aGame isPlayingX .! !

!TableTest methodsFor: 'TurnTests' stamp: 'D S 10/31/2020 13:46:36'!
test07PlayerOMoveSecond

	|aGame|
	aGame := Game startGame.
	aGame putXAt: 0@0.

	self assert: aGame isPlayingO.! !

!TableTest methodsFor: 'TurnTests' stamp: 'D S 10/31/2020 13:46:39'!
test08PlayerXMovesAfterPlayerO

	|aGame|
	aGame := Game startGame.
	aGame putXAt: 0@0.
	aGame putOAt: 1@1.

	self assert: aGame isPlayingX.! !


!TableTest methodsFor: 'initializationTests' stamp: 'D S 10/31/2020 13:46:14'!
test01PlayersHave3TokenWhenGameStarts

	|aGame|
	aGame := Game startGame.
	
	self assert: 3 equals: aGame playerXRemainingTokens.
	self assert: 3 equals: aGame playerORemainingTokens.! !

!TableTest methodsFor: 'initializationTests' stamp: 'D S 10/31/2020 13:46:18'!
test02PlayerXMovesFirst

	|aGame|
	aGame := Game startGame.
	
	self assert: aGame isPlayingX.! !

!TableTest methodsFor: 'initializationTests' stamp: 'D S 10/31/2020 13:46:22'!
test03PlayerODoesntMovesFirst

	|aGame|
	aGame := Game startGame.
	
	self deny: aGame isPlayingO.! !


!classDefinition: #Game category: 'Terni-Lapilli'!
Object subclass: #Game
	instanceVariableNames: 'playerX playerO playerMoving'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapilli'!

!Game methodsFor: 'initialize' stamp: 'D S 10/31/2020 14:09:10'!
initializeGame

	playerO := PlayerO readyPlayer.
	playerX := PlayerX readyPlayer.
	playerMoving := playerX.! !


!Game methodsFor: 'accessing' stamp: 'D S 11/1/2020 12:31:30'!
isPlayingO
	"Se usa == porque se espera que sean el mismo objeto, no que representen lo mismo"
	^(playerMoving == playerO).! !

!Game methodsFor: 'accessing' stamp: 'D S 11/1/2020 12:31:34'!
isPlayingX
	"Se usa == porque se espera que sean el mismo objeto, no que representen lo mismo"
	^playerMoving == playerX.! !

!Game methodsFor: 'accessing' stamp: 'D S 10/31/2020 14:09:50'!
playerORemainingTokens
	
	^playerO remainingTokens! !

!Game methodsFor: 'accessing' stamp: 'D S 11/2/2020 14:27:02'!
playerOhasTokenInPosition: aPoint
	
	^playerO hasTokenInPosition: aPoint.! !

!Game methodsFor: 'accessing' stamp: 'D S 10/31/2020 14:09:46'!
playerXRemainingTokens
	
	^playerX remainingTokens! !

!Game methodsFor: 'accessing' stamp: 'D S 11/2/2020 14:26:56'!
playerXhasTokenInPosition: aPoint
	
	^playerX hasTokenInPosition: aPoint.! !

!Game methodsFor: 'accessing' stamp: 'D S 10/31/2020 14:09:33'!
positionOTokens
	
	^playerO positionToken ! !

!Game methodsFor: 'accessing' stamp: 'D S 10/31/2020 14:09:22'!
positionXTokens
	
	^playerX positionToken ! !


!Game methodsFor: 'actions --Private--' stamp: 'D S 11/2/2020 14:05:22'!
If: aPlayer WonDo: aClosureIfTrue ifNotDo: aClosureIfFalse.
	
	^ (self hasPlayerWon: aPlayer) ifTrue: aClosureIfTrue
					ifFalse: aClosureIfFalse.! !

!Game methodsFor: 'actions --Private--' stamp: 'D S 11/2/2020 14:37:18'!
checkPlayer:aPlayer HasATokenIn: aPoint

	^ (aPlayer hasTokenInPosition: aPoint) ifTrue:[self error: self class errorDescriptionOponentTokenInPosition]! !

!Game methodsFor: 'actions --Private--' stamp: 'D S 11/1/2020 12:33:31'!
playerOHasATokenIn: aPoint2

	^ (playerO positionToken) includes: aPoint2! !

!Game methodsFor: 'actions --Private--' stamp: 'D S 11/1/2020 12:34:39'!
playerXHasATokenIn: aPoint2

	^ (playerX positionToken) includes: aPoint2! !


!Game methodsFor: 'actions' stamp: 'D S 11/2/2020 14:37:49'!
oMoveTokenFrom: aPointOfAOToken to: aDestinationPoint 
	
	self checkPlayer: playerX HasATokenIn: aDestinationPoint.
	playerMoving oMoveTokenFrom: aPointOfAOToken to: aDestinationPoint. 
	self If: playerO WonDo: [self error: self class menuDescriptionPlayerOWon.] ifNotDo:[playerMoving := playerX.].! !

!Game methodsFor: 'actions' stamp: 'D S 11/2/2020 14:37:37'!
putOAt: aPoint
	
	self checkPlayer: playerX HasATokenIn: aPoint.
	playerMoving putOAt: aPoint.
	self If: playerO WonDo: [self error: self class menuDescriptionPlayerOWon.] ifNotDo:[playerMoving := playerX.].! !

!Game methodsFor: 'actions' stamp: 'D S 11/2/2020 14:37:42'!
putXAt: aPoint
	
	self checkPlayer: playerO HasATokenIn: aPoint.
	playerMoving putXAt: aPoint.
	self If: playerX WonDo: [self error: self class menuDescriptionPlayerXWon.] ifNotDo:[playerMoving := playerO.].! !

!Game methodsFor: 'actions' stamp: 'D S 11/2/2020 14:38:05'!
xMoveTokenFrom: aPointOfAXToken to: aDestinationPoint 
	
	self checkPlayer: playerO HasATokenIn: aDestinationPoint.
	playerMoving xMoveTokenFrom: aPointOfAXToken to: aDestinationPoint.
	self If: playerX WonDo: [self error: self class menuDescriptionPlayerXWon.] ifNotDo:[playerMoving := playerO.].! !


!Game methodsFor: 'accessing --Private--' stamp: 'D S 11/2/2020 15:45:13'!
hasPlayerWon: aPlayer
	
	^(aPlayer tokensPlaced ) = 3 and: ((aPlayer hasThreeInAColumn) | (aPlayer hasThreeInADiagonal) | (aPlayer hasThreeInARow)).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Game class' category: 'Terni-Lapilli'!
Game class
	instanceVariableNames: ''!

!Game class methodsFor: 'instance creation' stamp: 'D S 10/31/2020 22:16:42'!
errorDescriptionGameOver

	^'The Game Already Ended'! !

!Game class methodsFor: 'instance creation' stamp: 'D S 10/31/2020 15:01:07'!
errorDescriptionOponentTokenInPosition

	^'The opponent have a token There!!'! !

!Game class methodsFor: 'instance creation' stamp: 'D S 10/31/2020 23:28:15'!
menuDescriptionPlayerOWon

	^'The player O Won'! !

!Game class methodsFor: 'instance creation' stamp: 'D S 10/31/2020 23:19:01'!
menuDescriptionPlayerXWon

	^'The player X Won'! !

!Game class methodsFor: 'instance creation' stamp: 'D S 10/29/2020 17:46:11'!
startGame
	
	^self new initializeGame.! !


!classDefinition: #PlayerO category: 'Terni-Lapilli'!
Game subclass: #PlayerO
	instanceVariableNames: 'remainingTokens positionTokens'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapilli'!

!PlayerO methodsFor: 'accessing' stamp: 'D S 10/31/2020 14:03:24'!
positionToken

	^positionTokens.! !

!PlayerO methodsFor: 'accessing' stamp: 'D S 10/31/2020 14:10:04'!
remainingTokens

	^remainingTokens.! !

!PlayerO methodsFor: 'accessing' stamp: 'D S 11/1/2020 12:40:37'!
tokensPlaced

	^positionTokens size! !


!PlayerO methodsFor: 'actions' stamp: 'D S 11/1/2020 19:52:15'!
oMoveTokenFrom: aPointOfAOToken to: aDestinationPoint
	
	self checkNotAlreadyATokenThere: aDestinationPoint.
	self checkIfValidMovingFrom: aPointOfAOToken to: aDestinationPoint.
	self checkDestinationIsNotOutOfBoard: aDestinationPoint.
	positionTokens remove: aPointOfAOToken ifAbsent:[^self error: self class errorDescriptionNoTokenThere].
	positionTokens add: aDestinationPoint.! !

!PlayerO methodsFor: 'actions' stamp: 'D S 11/1/2020 12:56:59'!
putOAt: aPoint 

	self checkHaveTokenToPut.	
	self checkNotAlreadyATokenThere: aPoint.
	self checkDestinationIsNotOutOfBoard: aPoint.
	positionTokens add: aPoint.
	remainingTokens := remainingTokens - 1.
	! !

!PlayerO methodsFor: 'actions' stamp: 'D S 10/31/2020 14:48:19'!
putXAt: aPoint

	^self error: self class errorDescriptionTurnO.! !

!PlayerO methodsFor: 'actions' stamp: 'D S 11/1/2020 13:01:35'!
xMoveTokenFrom: aPointOfAOToken to: aDestinationPoint
	
	self error: self class errorDescriptionCantMoveOpponentTokens ! !


!PlayerO methodsFor: 'actions --Private--' stamp: 'D S 11/2/2020 15:49:34'!
checkDestinationIsNotOutOfBoard: aDestinationPoint
	"El tablero es 3x3"
	^ ((aDestinationPoint x) > 2 or: (aDestinationPoint y) > 2 or: (aDestinationPoint x) < 0 or: (aDestinationPoint y) < 0) 
		ifTrue:[^self error: self class errorDescriptionOutOfRange ]! !

!PlayerO methodsFor: 'actions --Private--' stamp: 'D S 11/1/2020 15:59:58'!
checkHaveTokenToPut

	^ (remainingTokens = 0) ifTrue: [^self error: self class errorDescriptionNoMoreTokens ]! !

!PlayerO methodsFor: 'actions --Private--' stamp: 'D S 11/1/2020 20:03:38'!
checkIfValidMovingFrom: aPoint to: aPoint2
	"Todo movimiento validos aumenta o reduce la distancia al centro en 1 o 2. Si se mantiene igual es invalido ya que serian movimientos de la posicion 1@2 a 0@1, 0@1 a 1@0, 1@0 a 2@1 o 2@1 a 1@2 "

	^((self diferenciaAlCentroEsIgualDe: aPoint Y: aPoint2) or: (self distanciaEntreElPunto: aPoint EsMayorA2ComparandoloCon: aPoint2)) ifTrue: [^self error: self class errorDescriptionInvalidMovement].! !

!PlayerO methodsFor: 'actions --Private--' stamp: 'D S 11/2/2020 15:49:12'!
checkNotAlreadyATokenThere: aDestinationPoint

	^ (positionTokens includes: aDestinationPoint) ifTrue:[^self error: self class errorDescriptionOwnTokenThere ]! !

!PlayerO methodsFor: 'actions --Private--' stamp: 'D S 10/31/2020 21:27:08'!
diferenciaAlCentroEsIgualDe: aPoint Y: aPoint2
	
	^((((aPoint  x) -1 + (aPoint y) -1) abs) = (((aPoint2 x) - 1 + (aPoint2 y) -1) abs))! !

!PlayerO methodsFor: 'actions --Private--' stamp: 'D S 11/1/2020 20:02:05'!
distanciaEntreElPunto: aPoint EsMayorA2ComparandoloCon: aPoint2 
	
	^((((aPoint  x) - (aPoint2 x)) + ((aPoint y) - (aPoint2 y))) abs) > 2! !

!PlayerO methodsFor: 'actions --Private--' stamp: 'D S 11/2/2020 15:41:16'!
hasThreeInAColumn

	^((self threeTokensInColumn:0) or: 	(self threeTokensInColumn:1 ) or: (self threeTokensInColumn:2 ))! !

!PlayerO methodsFor: 'actions --Private--' stamp: 'D S 11/2/2020 15:37:35'!
hasThreeInADiagonal

	^((self threeTokensInAscendingDiagonal) or: (self threeTokensInDescendingDiagonal))! !

!PlayerO methodsFor: 'actions --Private--' stamp: 'D S 11/2/2020 15:40:57'!
hasThreeInARow

	^((self threeTokensInRow: 0) or: 	(self threeTokensInRow:1 ) or: 	(self threeTokensInRow:2)).! !

!PlayerO methodsFor: 'actions --Private--' stamp: 'D S 11/2/2020 14:27:31'!
hasTokenInPosition: aPoint

	^positionTokens includes: aPoint.! !

!PlayerO methodsFor: 'actions --Private--' stamp: 'D S 11/2/2020 15:36:25'!
threeTokensInAscendingDiagonal

	^positionTokens = (Set with: 0@0 with: 1@1 with: 2@2)! !

!PlayerO methodsFor: 'actions --Private--' stamp: 'D S 11/2/2020 15:40:23'!
threeTokensInColumn: aColumnNumber

	^ positionTokens allSatisfy: [:aTokenPosition | (aTokenPosition y)=aColumnNumber]! !

!PlayerO methodsFor: 'actions --Private--' stamp: 'D S 11/2/2020 15:36:57'!
threeTokensInDescendingDiagonal

	^((positionTokens = (Set with: 2@0 with: 1@1 with: 0@2))).! !

!PlayerO methodsFor: 'actions --Private--' stamp: 'D S 11/2/2020 15:40:38'!
threeTokensInRow: aRowNumber

	^ positionTokens allSatisfy: [:aTokenPosition | (aTokenPosition x)=aRowNumber]! !


!PlayerO methodsFor: 'initialize' stamp: 'D S 10/31/2020 14:10:44'!
ready

	remainingTokens := 3.
	positionTokens  := Set new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayerO class' category: 'Terni-Lapilli'!
PlayerO class
	instanceVariableNames: ''!

!PlayerO class methodsFor: 'as yet unclassified' stamp: 'D S 11/1/2020 11:37:43'!
errorDescriptionCantMoveOpponentTokens

	^'You cant move oponent tokens!!'! !

!PlayerO class methodsFor: 'as yet unclassified' stamp: 'D S 10/31/2020 21:47:25'!
errorDescriptionInvalidMovement

	^'That movement is invalid!!'! !

!PlayerO class methodsFor: 'as yet unclassified' stamp: 'D S 10/31/2020 15:32:36'!
errorDescriptionNoMoreTokens

	^'No more tokens left'! !

!PlayerO class methodsFor: 'as yet unclassified' stamp: 'D S 11/1/2020 15:56:11'!
errorDescriptionNoTokenThere

	^'You dont have a token there'! !

!PlayerO class methodsFor: 'as yet unclassified' stamp: 'D S 10/31/2020 21:47:36'!
errorDescriptionOutOfRange

	^'La posicion indicada es invalida (fuera del tablero)'! !

!PlayerO class methodsFor: 'as yet unclassified' stamp: 'D S 10/31/2020 15:15:19'!
errorDescriptionOwnTokenThere

	^'You already have a token There!!'! !

!PlayerO class methodsFor: 'as yet unclassified' stamp: 'D S 11/1/2020 19:39:16'!
errorDescriptionTokenAlreadyThere

	^'The indicated token is already there'! !

!PlayerO class methodsFor: 'as yet unclassified' stamp: 'D S 10/31/2020 14:47:46'!
errorDescriptionTurnO

	^'Es el turno del jugador O'! !

!PlayerO class methodsFor: 'as yet unclassified' stamp: 'D S 10/31/2020 14:12:16'!
readyPlayer

	^self new ready.! !


!classDefinition: #PlayerX category: 'Terni-Lapilli'!
Game subclass: #PlayerX
	instanceVariableNames: 'remainingTokens positionTokens'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni-Lapilli'!

!PlayerX methodsFor: 'accessing' stamp: 'D S 10/31/2020 14:03:32'!
positionToken

	^positionTokens.! !

!PlayerX methodsFor: 'accessing' stamp: 'D S 10/31/2020 14:10:12'!
remainingTokens

	^remainingTokens.! !

!PlayerX methodsFor: 'accessing' stamp: 'D S 11/1/2020 12:40:30'!
tokensPlaced

	^ positionTokens size! !


!PlayerX methodsFor: 'actions' stamp: 'D S 11/1/2020 12:59:53'!
oMoveTokenFrom: aPointOfAOToken to: aDestinationPoint 
	
	self error: self class errorDescriptionCantMoveOpponentTokens! !

!PlayerX methodsFor: 'actions' stamp: 'D S 10/31/2020 14:46:03'!
putOAt: aPoint

	^self error: self class errorDescriptionTurnX.! !

!PlayerX methodsFor: 'actions' stamp: 'D S 11/1/2020 13:15:09'!
putXAt: aPoint
	
	self checkHaveTokenToPut.	
	self checkNotAlreadyATokenThere: aPoint.
	self checkDestinationIsNotOutOfBoard: aPoint.
	positionTokens add: aPoint.
	remainingTokens := remainingTokens - 1.
	
! !

!PlayerX methodsFor: 'actions' stamp: 'D S 11/1/2020 15:51:44'!
xMoveTokenFrom: aPointOfAXToken to: aDestinationPoint
	
	self checkNotAlreadyATokenThere: aDestinationPoint.
	self checkIfValidMovingFrom: aPointOfAXToken to: aDestinationPoint.
	self checkDestinationIsNotOutOfBoard: aDestinationPoint.
	positionTokens remove: aPointOfAXToken ifAbsent: [self error: self class errorDescriptionNoTokenThere].
	positionTokens add: aDestinationPoint.! !


!PlayerX methodsFor: 'actions --Private--' stamp: 'D S 11/2/2020 15:50:12'!
checkDestinationIsNotOutOfBoard: aDestinationPoint
	"El tablero es 3x3"
	^ ((aDestinationPoint x) > 2 or: (aDestinationPoint y) > 2 or: (aDestinationPoint x) < 0 or: (aDestinationPoint y) < 0) 
		ifTrue:[^self error: self class errorDescriptionOutOfRange ]! !

!PlayerX methodsFor: 'actions --Private--' stamp: 'D S 11/1/2020 16:00:19'!
checkHaveTokenToPut

	^ (remainingTokens = 0) ifTrue: [^self error: self class errorDescriptionNoMoreTokens ]! !

!PlayerX methodsFor: 'actions --Private--' stamp: 'D S 11/1/2020 20:05:45'!
checkIfValidMovingFrom: aPoint to: aPoint2
	"Todo movimiento validos aumenta o reduce la distancia al centro en 1 o 2. Si se mantiene igual es invalido ya que serian movimientos de la posicion 1@2 a 0@1, 0@1 a 1@0, 1@0 a 2@1 o 2@1 a 1@2 "
	^ ((self diferenciaAlCentroEsIgualDe: aPoint Y: aPoint2) or: (self distanciaEntreElPunto: aPoint EsMayorA2ComparandoloCon: aPoint2)) ifTrue: [^self error: self class errorDescriptionInvalidMovement]! !

!PlayerX methodsFor: 'actions --Private--' stamp: 'D S 11/2/2020 15:49:01'!
checkNotAlreadyATokenThere: aDestinationPoint
	
	^ (positionTokens includes: aDestinationPoint) ifTrue:[^self error: self class errorDescriptionOwnTokenThere ]! !

!PlayerX methodsFor: 'actions --Private--' stamp: 'D S 10/31/2020 21:23:40'!
diferenciaAlCentroEsIgualDe: aPoint Y: aPoint2
	
	^((((aPoint  x) -1 + (aPoint y) -1) abs) = (((aPoint2 x) - 1 + (aPoint2 y) -1) abs))! !

!PlayerX methodsFor: 'actions --Private--' stamp: 'D S 11/1/2020 20:06:34'!
distanciaEntreElPunto: aPoint EsMayorA2ComparandoloCon: aPoint2 
	
	^((((aPoint  x) - (aPoint2 x)) + ((aPoint y) - (aPoint2 y))) abs) > 2! !

!PlayerX methodsFor: 'actions --Private--' stamp: 'D S 11/2/2020 15:42:36'!
hasThreeInAColumn

	^((self threeTokensInColumn: 0) or: 	(self threeTokensInColumn: 1 ) or: (self threeTokensInColumn: 2 ))! !

!PlayerX methodsFor: 'actions --Private--' stamp: 'D S 11/2/2020 15:38:16'!
hasThreeInADiagonal

	^((self threeTokensInAscendingDiagonal) or: (self threeTokensInDescendingDiagonal))! !

!PlayerX methodsFor: 'actions --Private--' stamp: 'D S 11/2/2020 15:42:22'!
hasThreeInARow

	^((self threeTokensInRow: 0) or: 	(self threeTokensInRow: 1 ) or: 	(self threeTokensInRow: 2)).! !

!PlayerX methodsFor: 'actions --Private--' stamp: 'D S 11/2/2020 14:27:41'!
hasTokenInPosition: aPoint

	^positionTokens includes: aPoint.! !

!PlayerX methodsFor: 'actions --Private--' stamp: 'D S 11/2/2020 15:38:45'!
threeTokensInAscendingDiagonal

	^positionTokens = (Set with: 0@0 with: 1@1 with: 2@2)! !

!PlayerX methodsFor: 'actions --Private--' stamp: 'D S 11/2/2020 15:41:42'!
threeTokensInColumn: aColumnNumber

	^ positionTokens allSatisfy: [:aTokenPosition | (aTokenPosition y)=aColumnNumber]! !

!PlayerX methodsFor: 'actions --Private--' stamp: 'D S 11/2/2020 15:38:51'!
threeTokensInDescendingDiagonal

	^((positionTokens = (Set with: 2@0 with: 1@1 with: 0@2))).! !

!PlayerX methodsFor: 'actions --Private--' stamp: 'D S 11/2/2020 15:41:59'!
threeTokensInRow: aRowNumber

	^ positionTokens allSatisfy: [:aTokenPosition | (aTokenPosition x)=aRowNumber]! !


!PlayerX methodsFor: 'initialize' stamp: 'D S 10/31/2020 14:10:49'!
ready

	remainingTokens := 3.
	positionTokens := Set new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayerX class' category: 'Terni-Lapilli'!
PlayerX class
	instanceVariableNames: ''!

!PlayerX class methodsFor: 'as yet unclassified' stamp: 'D S 11/1/2020 11:34:37'!
errorDescriptionCantMoveOpponentTokens

	^'You cant move oponent tokens!!'! !

!PlayerX class methodsFor: 'as yet unclassified' stamp: 'D S 10/31/2020 21:04:34'!
errorDescriptionInvalidMovement

	^'That movement is invalid!!'! !

!PlayerX class methodsFor: 'as yet unclassified' stamp: 'D S 10/31/2020 15:29:04'!
errorDescriptionNoMoreTokens

	^'No more tokens left'! !

!PlayerX class methodsFor: 'as yet unclassified' stamp: 'D S 11/1/2020 15:52:03'!
errorDescriptionNoTokenThere

	^'You dont have a token there'! !

!PlayerX class methodsFor: 'as yet unclassified' stamp: 'D S 10/31/2020 21:31:59'!
errorDescriptionOutOfRange

	^'La posicion indicada es invalida (fuera del tablero)'! !

!PlayerX class methodsFor: 'as yet unclassified' stamp: 'D S 10/31/2020 15:16:07'!
errorDescriptionOwnTokenThere

	^'You already have a token There!!'! !

!PlayerX class methodsFor: 'as yet unclassified' stamp: 'D S 11/2/2020 15:47:19'!
errorDescriptionTokenAlreadyThere

	^'The indicated token is already there'! !

!PlayerX class methodsFor: 'as yet unclassified' stamp: 'D S 10/31/2020 14:46:53'!
errorDescriptionTurnX

	^'Es el turno del jugador X'! !

!PlayerX class methodsFor: 'as yet unclassified' stamp: 'D S 10/31/2020 14:12:22'!
readyPlayer

	^self new ready.! !
