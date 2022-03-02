!classDefinition: #TerniLapilliTest category: 'TerniLapilli'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 11/1/2020 15:07:57'!
test01PlayerXPlaysFirst
	| partida |
	partida _ TerniLapilli newGame.
	self assert: partida isPlayingX.
	self deny: partida isPlayingO.
	self assert: partida countPiecesPlayed equals: 0.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 11/1/2020 15:08:10'!
test02PlayerOPlaysAfterX
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	self assert: partida isPlayingO.
	self deny: partida isPlayingX.
	self assert: partida countPiecesPlayed equals: 1.
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 11/1/2020 15:08:20'!
test03PlayerXPlaysAfterO
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@0.
	self assert: partida isPlayingX.
	self deny: partida isPlayingO.
	self assert: partida countPiecesPlayed equals: 2.
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 11/1/2020 15:08:43'!
test04NewGameCannotBeOver
	| partida |
	partida _ TerniLapilli newGame.
	self deny: partida isOver.
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 11/1/2020 15:08:52'!
test05NewGameHasNoWinner
	| partida |
	partida _ TerniLapilli newGame.
	self deny: partida hasPlayerXWon.
	self deny: partida hasPlayerOWon.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 11/1/2020 15:45:42'!
test06PlayersCannotPutMoreThan3Pieces
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@0.
	
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	
	partida putXAt: 2@0.
	partida putOAt: 2@1.
	
	self should: [partida putXAt: 2@2.]
	raise: Error
	withExceptionDo: [:anError | 
		self assert: anError  messageText = TerniLapilli cannotPlaceMoreThan3PiecesError.
		self assert: partida countPiecesPlayed equals: 6.
		].
	
	partida moveXFrom: 0@1 To: 0@2.
	
	self should: [partida putOAt: 2@2.]
	raise: Error
	withExceptionDo: [:anError | 
		self assert: anError  messageText = TerniLapilli cannotPlaceMoreThan3PiecesError.
		self assert: partida countPiecesPlayed equals: 6.
		].
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/29/2020 21:27:18'!
test07PlayerOWonByPlacingPieces
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@0.
	
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	
	partida putXAt: 2@0.
	partida putOAt: 1@2.
	
	self assert: partida isOver.
	self assert: partida hasPlayerOWon.
	self deny: partida hasPlayerXWon.
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/29/2020 21:27:23'!
test08PlayerXWonByPlacingPieces
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@0.
	
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	
	partida putXAt: 0@2.
	
	self assert: partida isOver.
	self deny: partida hasPlayerOWon.
	self assert: partida hasPlayerXWon.
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/29/2020 21:26:43'!
test09PlayerXMovesAPieceAndGameContinues
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@0.
	
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	
	partida putXAt: 2@0.
	partida putOAt: 0@2.
	
	partida moveXFrom: 2@0 To: 2@1.
	
	self deny: partida isOver.
	self assert: partida countPiecesPlayed equals: 6.
	self assert: partida isPlayingO.
	self deny: partida isPlayingX.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/29/2020 21:26:51'!
test10PlayerXMovesAPieceAndWins
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@0.
	
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	
	partida putXAt: 1@2.
	partida putOAt: 2@0.
	
	partida moveXFrom: 1@2 To: 0@2.
	
	self assert: partida isOver.
	self assert: partida hasPlayerXWon.
	self deny: partida hasPlayerOWon.
	self assert: partida countPiecesPlayed equals: 6.
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/29/2020 21:23:41'!
test11PlayerOMovesAPieceAndGameContinues
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@0.
	
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	
	partida putXAt: 2@0.
	partida putOAt: 0@2.
	
	partida moveXFrom: 2@0 To: 2@1.
	partida moveOFrom: 1@1 To: 1@2.
	
	self deny: partida isOver.
	self assert: partida countPiecesPlayed equals: 6.
	self deny: partida isPlayingO.
	self assert: partida isPlayingX.! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/29/2020 21:25:47'!
test12PlayerOMovesAPieceAndWins
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@0.
	
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	
	partida putXAt: 2@0.
	partida putOAt: 0@2.
	
	partida moveXFrom: 2@0 To: 2@1.
	partida moveOFrom: 1@0 To: 2@0.
	
	self assert: partida isOver.
	self assert: partida countPiecesPlayed equals: 6.
	self deny: partida hasPlayerXWon .
	self assert: partida hasPlayerOWon .! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 11/1/2020 00:14:58'!
test13PlayerOCannotPutPieceOutOfTurn
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 1@1.
	partida putOAt: 2@2.
	self should: [partida putOAt: 0@0.] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlayOutOfTurn.
		self assert: partida countPiecesPlayed = 2.
		self assert: partida isPlayingX.
		self deny: partida isOver.
		].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 11/1/2020 00:15:18'!
test14PlayerXCannotPutPieceOutOfTurn
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 1@1.
	partida putOAt: 2@2.
	partida putXAt: 0@0.
	self should: [partida putXAt: 0@1.] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlayOutOfTurn .
		self assert: partida countPiecesPlayed = 3.
		self assert: partida isPlayingO.
		self deny: partida isOver.
		].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/31/2020 20:10:01'!
test15PlayerXCannotPutPieceInOccupiedPosition
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 1@1.
	partida putOAt: 2@2.
	partida putXAt: 0@0.
	partida putOAt: 0@2.
	self should: [partida putXAt: 2@2.] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlacePieceInOccupiedPosition.
		self assert: partida countPiecesPlayed = 4.
		self assert: partida isPlayingX.
		self deny: partida isOver.
		].
	self should: [partida putXAt: 1@1.] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlacePieceInOccupiedPosition.
		self assert: partida countPiecesPlayed = 4.
		self assert: partida isPlayingX.
		self deny: partida isOver.
		].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/31/2020 20:13:00'!
test16PlayerOCannotPutPieceInOccupiedPosition
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@2.
	partida putOAt: 2@2.
	partida putXAt: 2@0.
	partida putOAt: 1@2.
	partida putXAt: 0@0.
	self should: [partida putOAt: 0@2.] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlacePieceInOccupiedPosition.
		self assert: partida countPiecesPlayed = 5.
		self assert: partida isPlayingO.
		self deny: partida isOver.
		].
	self should: [partida putOAt: 2@2.] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlacePieceInOccupiedPosition.
		self assert: partida countPiecesPlayed = 5.
		self assert: partida isPlayingO.
		self deny: partida isOver.
		].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/31/2020 20:24:18'!
test17PlayerOCannotMoveBeforePlacing3Pieces
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@2.
	partida putOAt: 2@2.
	partida putXAt: 2@0.
	partida putOAt: 1@2.
	partida putXAt: 0@0.
	self should: [partida moveOFrom: 1@2 To: 0@2.] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotMovePieceBeforePlacingAllPieces.
		self assert: partida isPlayingO.
		self deny: partida isOver.
		].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/31/2020 20:28:10'!
test18PlayerXCannotMoveBeforePlacing3Pieces
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@2.
	partida putOAt: 2@2.
	partida putXAt: 2@0.
	partida putOAt: 1@2.
	self should: [partida moveXFrom: 2@0 To: 1@0.] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotMovePieceBeforePlacingAllPieces.
		self assert: partida isPlayingX.
		self deny: partida isOver.
		].! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/31/2020 20:34:13'!
test19PlayersCannotPlacePieceOutsideBoard
	| partida |
	partida _ TerniLapilli newGame.
	self should: [partida putXAt: (-1@0)] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlacePiecesOutsideBoard.
		self assert: partida countPiecesPlayed equals: 0.
		self assert: partida isPlayingX.
		self deny: partida isOver.
		].
	
	partida putXAt: 0@2.
	
	self should: [partida putOAt: (-1@0)] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlacePiecesOutsideBoard.
		self assert: partida countPiecesPlayed equals: 1.
		self assert: partida isPlayingO.
		self deny: partida isOver.
		].
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 11/1/2020 00:12:30'!
test20PlayersCannotMovePieceOutsideBoard
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@0.
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	partida putXAt: 2@0.
	partida putOAt: 0@2.
	
	self should: [partida moveXFrom: 0@0 To: -1@0 ] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlacePiecesOutsideBoard.
		self assert: partida isPlayingX.
		self deny: partida isOver.
		].
	
	partida moveXFrom: 2@0 To: 2@1.

	self should: [partida moveOFrom: (1@0) To: (1@-1)] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlacePiecesOutsideBoard.
		self assert: partida isPlayingO.
		self deny: partida isOver.
		].
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/31/2020 20:51:06'!
test21PlayersCanOnlyMoveOwnedPieces
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@0.
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	partida putXAt: 2@0.
	partida putOAt: 0@2.
	
	self should: [partida moveXFrom: 0@2 To: 1@2 ] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotMovePiecesPlayerDoesntOwn.
		self assert: partida isPlayingX.
		self deny: partida isOver.
		].
	
	partida moveXFrom: 2@0 To: 2@1.

	self should: [partida moveOFrom: (1@-1) To: (1@0)] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotMovePiecesPlayerDoesntOwn.
		self assert: partida isPlayingO.
		self deny: partida isOver.
		].
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 11/1/2020 00:12:10'!
test22PlayerXCannotMovePieceToOccupiedPosition
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@0.
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	partida putXAt: 2@0.
	partida putOAt: 0@2.
	
	self should: [partida moveXFrom: 0@0 To: 1@0 ] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlacePieceInOccupiedPosition.
		self assert: partida isPlayingX.
		self deny: partida isOver.
		].

	self should: [partida moveXFrom: 0@0 To: 0@1] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlacePieceInOccupiedPosition.
		self assert: partida isPlayingX.
		self deny: partida isOver.
		].
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 11/1/2020 00:11:51'!
test23PlayerOCannotMovePieceToOccupiedPosition
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@0.
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	partida putXAt: 2@0.
	partida putOAt: 0@2.
	partida moveXFrom: 2@0 To: 2@1.
	
	self should: [partida moveOFrom: 1@0 To: 0@0 ] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlacePieceInOccupiedPosition .
		self assert: partida isPlayingO.
		self deny: partida isOver.
		].

	self should: [partida moveOFrom: 1@0 To: 1@1] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlacePieceInOccupiedPosition .
		self assert: partida isPlayingO.
		self deny: partida isOver.
		].
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/31/2020 23:17:23'!
test24PlayerXCanOnlyMoveToNeighbour
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@0.
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	partida putXAt: 2@0.
	partida putOAt: 0@2.
	
	self should: [partida moveXFrom: 0@0 To: 1@2 ] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotMovePieceMoreThanOneSpace.
		self assert: partida isPlayingX.
		self deny: partida isOver.
		].
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/31/2020 23:21:40'!
test25PlayerOCanOnlyMoveToNeighbour
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@0.
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	partida putXAt: 2@0.
	partida putOAt: 0@2.
	partida moveXFrom: 2@0 To: 2@1.
	
	self should: [partida moveOFrom: 1@0 To: 2@2 ] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotMovePieceMoreThanOneSpace .
		self assert: partida isPlayingO.
		self deny: partida isOver.
		].
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 11/1/2020 00:16:20'!
test26PlayerXCannotMoveByInvalidDiagonal
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@2.
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	partida putXAt: 2@0.
	partida putOAt: 0@2.
	
	self should: [partida moveXFrom: 0@1 To: 1@0 ] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotMovePieceByInvalidDiagonal.
		self assert: partida isPlayingX.
		self deny: partida isOver.
		].
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 10/31/2020 23:27:43'!
test27PlayerOCannotMoveByInvalidDiagonal
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 0@1.
	partida putXAt: 1@1.
	partida putOAt: 2@1.
	partida putXAt: 0@2.
	partida putOAt: 1@0.
	partida moveXFrom: 1@1 To: 2@0.
	
	self should: [partida moveOFrom: 2@1 To: 1@2 ] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotMovePieceByInvalidDiagonal .
		self assert: partida isPlayingO.
		self deny: partida isOver.
		].
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 11/1/2020 00:17:28'!
test28PlayerOCannotMoveOutOfTurn
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@2.
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	partida putXAt: 2@0.
	partida putOAt: 0@2.
	
	self should: [partida moveOFrom: 1@2 To: 2@2 ] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlayOutOfTurn .
		self assert: partida isPlayingX.
		self deny: partida isOver.
		].
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 11/1/2020 00:18:47'!
test29PlayerXCannotMoveOutOfTurn
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 0@1.
	partida putXAt: 1@1.
	partida putOAt: 2@1.
	partida putXAt: 0@2.
	partida putOAt: 1@0.
	partida moveXFrom: 1@1 To: 2@0.
	
	self should: [partida moveXFrom: 2@0 To: 1@1 ] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlayOutOfTurn.
		self assert: partida isPlayingO.
		self deny: partida isOver.
		].
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'EMI 11/1/2020 15:07:07'!
test30PlayersCannotPlayAfterGameIsOver
	| partida |
	partida _ TerniLapilli newGame.
	partida putXAt: 0@0.
	partida putOAt: 1@0.
	
	partida putXAt: 0@1.
	partida putOAt: 1@1.
	
	partida putXAt: 2@0.
	partida putOAt: 1@2.
	
	self assert: partida isOver.
	self assert: partida hasPlayerOWon.
	self deny: partida hasPlayerXWon.
	
	self should: [partida moveXFrom: 0@1 To: 0@2 ] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlayWhenGameOver.
		self assert: partida isOver.
		self assert: partida hasPlayerOWon.
		self deny: partida hasPlayerXWon.
		].
	
	self should: [partida moveOFrom: 1@2 To: 2@2 ] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText = TerniLapilli cannotPlayWhenGameOver.
		self assert: partida isOver.
		self assert: partida hasPlayerOWon.
		self deny: partida hasPlayerXWon.
		].
	! !


!classDefinition: #TerniLapilli category: 'TerniLapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'piecesX piecesO gameState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'testing' stamp: 'EMI 10/29/2020 19:21:52'!
countPiecesPlayed
	^piecesX size + piecesO size.! !

!TerniLapilli methodsFor: 'testing' stamp: 'EMI 11/1/2020 13:15:07'!
hasPlayerOWon
	^gameState hasPlayerOWon.! !

!TerniLapilli methodsFor: 'testing' stamp: 'EMI 11/1/2020 13:15:18'!
hasPlayerXWon
	^gameState hasPlayerXWon.! !

!TerniLapilli methodsFor: 'testing' stamp: 'EMI 11/1/2020 13:15:28'!
isOver
	^gameState isOver.! !

!TerniLapilli methodsFor: 'testing' stamp: 'EMI 11/1/2020 13:15:40'!
isPlayingO
	^gameState isPlayingO .! !

!TerniLapilli methodsFor: 'testing' stamp: 'EMI 11/1/2020 13:15:48'!
isPlayingX
	^gameState isPlayingX.! !


!TerniLapilli methodsFor: 'player actions' stamp: 'EMI 11/1/2020 13:20:35'!
moveOFrom: aOriginPosition To: aDestinationPosition
	gameState moveOFrom: aOriginPosition To: aDestinationPosition.
! !

!TerniLapilli methodsFor: 'player actions' stamp: 'EMI 11/1/2020 13:21:11'!
moveXFrom: aOriginPosition To: aDestinationPosition
	gameState moveXFrom: aOriginPosition To: aDestinationPosition .! !

!TerniLapilli methodsFor: 'player actions' stamp: 'EMI 11/1/2020 13:19:36'!
putOAt: aPosition
	gameState putOAt: aPosition.


	! !

!TerniLapilli methodsFor: 'player actions' stamp: 'EMI 11/1/2020 13:18:47'!
putXAt: aPosition
	gameState putXAt: aPosition.! !


!TerniLapilli methodsFor: 'board consults - private' stamp: 'EMI 11/2/2020 16:27:00'!
checkDiagonalLine: aPiecesCollection
	| diagonalInversa diagonal |
	
	(aPiecesCollection includes: self class centerPosition) ifFalse:[^false.].
	
	diagonal  _ (aPiecesCollection includes: (self class bottomRightPosition)) and: [aPiecesCollection includes: (self class topLeftPosition)].
	diagonalInversa _ (aPiecesCollection includes: (self class bottomLeftPosition)) and: [aPiecesCollection includes:  (self class topRightPosition)].
	
	^diagonal or:[diagonalInversa].! !

!TerniLapilli methodsFor: 'board consults - private' stamp: 'EMI 10/29/2020 20:58:06'!
checkHorizontalLine: aPiecesCollection
	|first estanALaIzq estanALaDer estanAmbosLados|
	first _ aPiecesCollection first.
	
	estanAmbosLados  _ (aPiecesCollection includes: (first + (0@1))) and: [aPiecesCollection includes: first - (0@1)].
	estanALaDer _ (aPiecesCollection includes: (first + (0@1))) and: [aPiecesCollection includes: first + (0@2)].
	estanALaIzq _ (aPiecesCollection includes: (first - (0@1))) and: [aPiecesCollection includes: first - (0@2)].
	
	^estanAmbosLados or:[estanALaDer or:[estanALaIzq]].! !

!TerniLapilli methodsFor: 'board consults - private' stamp: 'EMI 11/2/2020 16:29:03'!
checkIfIsInvalidDiagonalMoveFrom: aOriginPosition To: anEmptyDestinationPosition
	^(self class invalidDiagonalPositions includes: aOriginPosition) and:[self class invalidDiagonalPositions includes: anEmptyDestinationPosition ]
! !

!TerniLapilli methodsFor: 'board consults - private' stamp: 'EMI 11/2/2020 16:38:29'!
checkIfMoveIsValidFrom: aOriginPosition To: anEmptyDestinationPosition
	(self checkIfPosition: aOriginPosition isNeighbourOf: anEmptyDestinationPosition) ifFalse:[^Error signal: self class 	cannotMovePieceMoreThanOneSpace ].
	
	(self checkIfIsInvalidDiagonalMoveFrom: aOriginPosition To: anEmptyDestinationPosition ) ifTrue:[^Error signal: self class cannotMovePieceByInvalidDiagonal ].
! !

!TerniLapilli methodsFor: 'board consults - private' stamp: 'EMI 11/1/2020 14:50:37'!
checkIfPlayerOWon
	^self checkIfPlayerWon: piecesO.! !

!TerniLapilli methodsFor: 'board consults - private' stamp: 'EMI 11/1/2020 14:50:10'!
checkIfPlayerWon: aPlayerPiecesCollection
	^((self checkHorizontalLine: aPlayerPiecesCollection) or: [(self checkVerticalLine: aPlayerPiecesCollection) or:[self checkDiagonalLine: aPlayerPiecesCollection]]).! !

!TerniLapilli methodsFor: 'board consults - private' stamp: 'EMI 11/1/2020 14:50:28'!
checkIfPlayerXWon
	^self checkIfPlayerWon: piecesX.! !

!TerniLapilli methodsFor: 'board consults - private' stamp: 'EMI 11/2/2020 16:38:29'!
checkIfPosition: aOriginPosition isNeighbourOf: anEmptyDestinationPosition
	^ aOriginPosition eightNeighbors includes: anEmptyDestinationPosition! !

!TerniLapilli methodsFor: 'board consults - private' stamp: 'EMI 10/29/2020 20:58:35'!
checkVerticalLine: aPiecesCollection
	|first estanArriba estanAbajo estanAmbosLados|
	first _ aPiecesCollection first.
	
	estanAmbosLados  _ (aPiecesCollection includes: (first + (1@0))) and: [aPiecesCollection includes: first - (1@0)].
	estanAbajo _ (aPiecesCollection includes: (first + (1@0))) and: [aPiecesCollection includes: first + (2@0)].
	estanArriba _ (aPiecesCollection includes: (first - (1@0))) and: [aPiecesCollection includes: first - (2@0)].
	
	^estanAmbosLados or:[estanAbajo or:[estanArriba]].! !

!TerniLapilli methodsFor: 'board consults - private' stamp: 'EMI 11/2/2020 16:03:40'!
hasPlayerXPlacedAllPieces

	^ piecesX size = 3! !

!TerniLapilli methodsFor: 'board consults - private' stamp: 'EMI 10/31/2020 20:37:59'!
isInsideBoard: aPosition
	^ ((aPosition x) between: 0 and: 2) and: [(aPosition y) between: 0 and: 2].! !

!TerniLapilli methodsFor: 'board consults - private' stamp: 'EMI 11/1/2020 15:42:06'!
isPositionEmpty: aPosition
	^((piecesO includes: aPosition ) or: [piecesX includes: aPosition ]).
! !


!TerniLapilli methodsFor: 'initialize - private' stamp: 'EMI 11/1/2020 14:57:14'!
initialize
	piecesX _ OrderedCollection new.
	piecesO _ OrderedCollection new.
	gameState _ TerniLapilliPlayerXPutPieceState ofGame: self.! !


!TerniLapilli methodsFor: 'player actions - private' stamp: 'EMI 11/1/2020 14:55:23'!
moveOWhenPlayerIsOFrom: aOriginPosition To: aDestinationPosition
	self movePieceOf: piecesO From: aOriginPosition To: aDestinationPosition.
	self checkIfPlayerOWon 
	ifTrue: [gameState _ TerniLapilliGameOverState ofGame: self hasXWon: false.]
	ifFalse: [gameState _ TerniLapilliPlayerXMovePieceState ofGame: self.]
! !

!TerniLapilli methodsFor: 'player actions - private' stamp: 'EMI 11/2/2020 16:37:24'!
movePieceOf: aPiecesCollection From: aOriginPosition To: aDestinationPosition
	(self isInsideBoard: aDestinationPosition ) ifFalse:[^Error signal: self class cannotPlacePiecesOutsideBoard ].
	(aPiecesCollection includes: aOriginPosition) ifFalse: [^Error signal: self class cannotMovePiecesPlayerDoesntOwn].
	(self isPositionEmpty: aDestinationPosition)  ifTrue: [^Error signal: self class cannotPlacePieceInOccupiedPosition ].
	self checkIfMoveIsValidFrom: aOriginPosition To: aDestinationPosition.
	
	aPiecesCollection remove: aOriginPosition.
	aPiecesCollection add: aDestinationPosition.! !

!TerniLapilli methodsFor: 'player actions - private' stamp: 'EMI 11/1/2020 14:54:47'!
moveXWhenPlayerIsXFrom: aOriginPosition To: aDestinationPosition
	self movePieceOf: piecesX From: aOriginPosition To: aDestinationPosition.
	self checkIfPlayerXWon 
	ifTrue: [gameState _ TerniLapilliGameOverState ofGame: self hasXWon: true.]
	ifFalse: [gameState _ TerniLapilliPlayerOMovePieceState ofGame: self.]! !

!TerniLapilli methodsFor: 'player actions - private' stamp: 'EMI 11/2/2020 16:35:07'!
putOWhenPlayerIsOAt: aPosition
	self putValidPiece: aPosition In: piecesO.
	self checkIfPlayerOWon 
	ifTrue: [gameState _ TerniLapilliGameOverState ofGame: self hasXWon: false]
	ifFalse: [
		self hasPlayerXPlacedAllPieces 
		ifTrue:[gameState _ TerniLapilliPlayerXMovePieceState ofGame: self]
		ifFalse:[gameState _ TerniLapilliPlayerXPutPieceState ofGame: self]
	].


	! !

!TerniLapilli methodsFor: 'player actions - private' stamp: 'EMI 11/2/2020 16:35:07'!
putValidPiece: aPosition In: aPiecesCollection
	(self isInsideBoard: aPosition) ifFalse:[^Error signal: self class cannotPlacePiecesOutsideBoard ].
	(self isPositionEmpty: aPosition) ifTrue: [^Error signal: self class cannotPlacePieceInOccupiedPosition ].
	
	aPiecesCollection add: aPosition.! !

!TerniLapilli methodsFor: 'player actions - private' stamp: 'EMI 11/2/2020 16:35:07'!
putXWhenPlayerIsXAt: aPosition
	self putValidPiece: aPosition In: piecesX.
	self checkIfPlayerXWon 
	ifTrue:[gameState _ TerniLapilliGameOverState ofGame: self hasXWon: true]
	ifFalse:[gameState _ TerniLapilliPlayerOPutPieceState ofGame: self].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: 'TerniLapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'initialization' stamp: 'EMI 10/29/2020 18:33:58'!
newGame
	^self new initialize .! !


!TerniLapilli class methodsFor: 'error messages' stamp: 'EMI 10/31/2020 20:25:03'!
cannotMovePieceBeforePlacingAllPieces
	^'Cannot move piece before placing all pieces'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'EMI 10/31/2020 23:28:04'!
cannotMovePieceByInvalidDiagonal
	^'Cannot move piece by invalid diagonal'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'EMI 10/31/2020 23:17:49'!
cannotMovePieceMoreThanOneSpace
	^'Cannot move piece more than one space'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'EMI 10/31/2020 20:51:43'!
cannotMovePiecesPlayerDoesntOwn
	^'Player doesnt have a piece in that position'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'EMI 10/29/2020 18:48:51'!
cannotPlaceMoreThan3PiecesError
	^'Cannot place more than 3 pieces per player'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'EMI 10/31/2020 20:25:24'!
cannotPlacePieceInOccupiedPosition
	^'Cannot place piece in occupied position'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'EMI 10/31/2020 20:34:50'!
cannotPlacePiecesOutsideBoard
	^'Cannot place piece outside board'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'EMI 11/1/2020 00:09:33'!
cannotPlayOutOfTurn
	^'Cannot place piece out of turn'.! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'EMI 11/1/2020 15:02:34'!
cannotPlayWhenGameOver
	^'Cannot put piece or move piece when game is over'.! !


!TerniLapilli class methodsFor: 'constants - private' stamp: 'EMI 11/2/2020 16:24:13'!
bottomCenterPosition

	^ 2@1! !

!TerniLapilli class methodsFor: 'constants - private' stamp: 'EMI 11/2/2020 16:24:37'!
bottomLeftPosition

	^ 2@0! !

!TerniLapilli class methodsFor: 'constants - private' stamp: 'EMI 11/2/2020 16:24:46'!
bottomRightPosition

	^ 2@2! !

!TerniLapilli class methodsFor: 'constants - private' stamp: 'EMI 11/2/2020 16:24:57'!
centerLeftPosition

	^ 1@0! !

!TerniLapilli class methodsFor: 'constants - private' stamp: 'EMI 11/2/2020 16:25:05'!
centerPosition

	^ 1@1! !

!TerniLapilli class methodsFor: 'constants - private' stamp: 'EMI 11/2/2020 16:25:11'!
centerRightPosition

	^ 1@2! !

!TerniLapilli class methodsFor: 'constants - private' stamp: 'EMI 11/2/2020 16:30:19'!
invalidDiagonalPositions
	^OrderedCollection with: (self centerLeftPosition) with: (self topCenterPosition)  with:(self centerRightPosition) with:(self bottomCenterPosition).! !

!TerniLapilli class methodsFor: 'constants - private' stamp: 'EMI 11/2/2020 16:25:22'!
topCenterPosition

	^ 0@1! !

!TerniLapilli class methodsFor: 'constants - private' stamp: 'EMI 11/2/2020 16:25:28'!
topLeftPosition

	^ 0@0! !

!TerniLapilli class methodsFor: 'constants - private' stamp: 'EMI 11/2/2020 16:25:34'!
topRightPosition

	^ 0@2! !


!classDefinition: #TerniLapilliState category: 'TerniLapilli'!
Object subclass: #TerniLapilliState
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliState methodsFor: 'testing' stamp: 'EMI 11/1/2020 12:32:36'!
hasPlayerOWon
	^self subclassResponsibility.! !

!TerniLapilliState methodsFor: 'testing' stamp: 'EMI 11/1/2020 12:32:33'!
hasPlayerXWon
	^self subclassResponsibility.! !

!TerniLapilliState methodsFor: 'testing' stamp: 'EMI 11/1/2020 12:32:13'!
isOver
	^self subclassResponsibility.! !

!TerniLapilliState methodsFor: 'testing' stamp: 'EMI 11/1/2020 12:32:19'!
isPlayingO
	^self subclassResponsibility.! !

!TerniLapilliState methodsFor: 'testing' stamp: 'EMI 11/1/2020 12:32:23'!
isPlayingX
	^self subclassResponsibility.! !


!TerniLapilliState methodsFor: 'player actions' stamp: 'EMI 11/1/2020 12:35:27'!
moveOFrom: aOriginPosition To: aDestinationPosition
	^self subclassResponsibility.! !

!TerniLapilliState methodsFor: 'player actions' stamp: 'EMI 11/1/2020 12:35:24'!
moveXFrom: aOriginPosition To: aDestinationPosition
	^self subclassResponsibility.! !

!TerniLapilliState methodsFor: 'player actions' stamp: 'EMI 11/1/2020 12:35:01'!
putOAt: aPosition
	^self subclassResponsibility.! !

!TerniLapilliState methodsFor: 'player actions' stamp: 'EMI 11/1/2020 12:34:59'!
putXAt: aPosition
	^self subclassResponsibility.! !


!TerniLapilliState methodsFor: 'initialization - private' stamp: 'EMI 11/1/2020 12:57:09'!
initialize: aTerniLapilliGame
	game _ aTerniLapilliGame.! !


!classDefinition: #TerniLapilliGameOverState category: 'TerniLapilli'!
TerniLapilliState subclass: #TerniLapilliGameOverState
	instanceVariableNames: 'xWon'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliGameOverState methodsFor: 'testing' stamp: 'EMI 11/1/2020 12:38:34'!
hasPlayerOWon
	^xWon not.! !

!TerniLapilliGameOverState methodsFor: 'testing' stamp: 'EMI 11/1/2020 12:38:22'!
hasPlayerXWon
	^xWon.! !

!TerniLapilliGameOverState methodsFor: 'testing' stamp: 'EMI 11/1/2020 12:37:05'!
isOver
	^true.! !

!TerniLapilliGameOverState methodsFor: 'testing' stamp: 'EMI 11/1/2020 12:37:20'!
isPlayingO
	^false.! !

!TerniLapilliGameOverState methodsFor: 'testing' stamp: 'EMI 11/1/2020 12:37:16'!
isPlayingX
	^false.! !


!TerniLapilliGameOverState methodsFor: 'player actions' stamp: 'EMI 11/1/2020 15:03:01'!
moveOFrom: aOriginPosition To: aDestinationPosition
	^Error signal: game class cannotPlayWhenGameOver.! !

!TerniLapilliGameOverState methodsFor: 'player actions' stamp: 'EMI 11/1/2020 15:03:06'!
moveXFrom: aOriginPosition To: aDestinationPosition
	^Error signal: game class cannotPlayWhenGameOver.! !

!TerniLapilliGameOverState methodsFor: 'player actions' stamp: 'EMI 11/1/2020 15:03:10'!
putOAt: aPosition
	^Error signal: game class cannotPlayWhenGameOver.! !

!TerniLapilliGameOverState methodsFor: 'player actions' stamp: 'EMI 11/1/2020 15:03:16'!
putXAt: aPosition
	^Error signal: game class cannotPlayWhenGameOver.! !


!TerniLapilliGameOverState methodsFor: 'initialize' stamp: 'EMI 11/1/2020 12:51:20'!
initialize: aTerniLapilliGame hasXWon: xIsWinnerBoolean 
	game _ aTerniLapilliGame.
	xWon _ xIsWinnerBoolean.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliGameOverState class' category: 'TerniLapilli'!
TerniLapilliGameOverState class
	instanceVariableNames: ''!

!TerniLapilliGameOverState class methodsFor: 'as yet unclassified' stamp: 'EMI 11/1/2020 12:49:12'!
ofGame: aTerniLapilliGame hasXWon: xIsWinnerBoolean
	^self new initialize: aTerniLapilliGame hasXWon: xIsWinnerBoolean.
	! !


!classDefinition: #TerniLapilliPlayerOMovePieceState category: 'TerniLapilli'!
TerniLapilliState subclass: #TerniLapilliPlayerOMovePieceState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliPlayerOMovePieceState methodsFor: 'testing' stamp: 'EMI 11/1/2020 13:06:57'!
hasPlayerOWon
	^false! !

!TerniLapilliPlayerOMovePieceState methodsFor: 'testing' stamp: 'EMI 11/1/2020 13:06:54'!
hasPlayerXWon
	^false! !

!TerniLapilliPlayerOMovePieceState methodsFor: 'testing' stamp: 'EMI 11/1/2020 13:06:49'!
isOver
	^false! !

!TerniLapilliPlayerOMovePieceState methodsFor: 'testing' stamp: 'EMI 11/1/2020 13:07:10'!
isPlayingO
	^true! !

!TerniLapilliPlayerOMovePieceState methodsFor: 'testing' stamp: 'EMI 11/1/2020 13:06:45'!
isPlayingX
	^false! !


!TerniLapilliPlayerOMovePieceState methodsFor: 'player actions' stamp: 'EMI 11/1/2020 13:21:56'!
moveOFrom: aOriginPosition To: aDestinationPosition
	game moveOWhenPlayerIsOFrom: aOriginPosition To: aDestinationPosition.! !

!TerniLapilliPlayerOMovePieceState methodsFor: 'player actions' stamp: 'EMI 11/1/2020 13:08:22'!
moveXFrom: aOriginPosition To: aDestinationPosition
	^Error signal: game class cannotPlayOutOfTurn.! !

!TerniLapilliPlayerOMovePieceState methodsFor: 'player actions' stamp: 'EMI 11/1/2020 13:07:54'!
putOAt: aPosition
	^Error signal: game class cannotPlaceMoreThan3PiecesError.! !

!TerniLapilliPlayerOMovePieceState methodsFor: 'player actions' stamp: 'EMI 11/1/2020 13:07:40'!
putXAt: aPosition
	^Error signal: game class cannotPlayOutOfTurn.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliPlayerOMovePieceState class' category: 'TerniLapilli'!
TerniLapilliPlayerOMovePieceState class
	instanceVariableNames: ''!

!TerniLapilliPlayerOMovePieceState class methodsFor: 'initialize' stamp: 'EMI 11/1/2020 13:09:07'!
ofGame: aTerniLapilliGame
	^self new initialize: aTerniLapilliGame.! !


!classDefinition: #TerniLapilliPlayerOPutPieceState category: 'TerniLapilli'!
TerniLapilliState subclass: #TerniLapilliPlayerOPutPieceState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliPlayerOPutPieceState methodsFor: 'testing' stamp: 'EMI 11/1/2020 12:59:26'!
hasPlayerOWon
	^false.! !

!TerniLapilliPlayerOPutPieceState methodsFor: 'testing' stamp: 'EMI 11/1/2020 12:59:23'!
hasPlayerXWon
	^false.! !

!TerniLapilliPlayerOPutPieceState methodsFor: 'testing' stamp: 'EMI 11/1/2020 12:58:34'!
isOver
	^false.! !

!TerniLapilliPlayerOPutPieceState methodsFor: 'testing' stamp: 'EMI 11/1/2020 12:59:13'!
isPlayingO
	^true.! !

!TerniLapilliPlayerOPutPieceState methodsFor: 'testing' stamp: 'EMI 11/1/2020 12:59:03'!
isPlayingX
	^false.! !


!TerniLapilliPlayerOPutPieceState methodsFor: 'player actions' stamp: 'EMI 11/1/2020 13:01:19'!
moveOFrom: aOriginPosition To: aDestinationPosition
	^Error signal: game class cannotMovePieceBeforePlacingAllPieces.
	
	! !

!TerniLapilliPlayerOPutPieceState methodsFor: 'player actions' stamp: 'EMI 11/1/2020 13:01:10'!
moveXFrom: aOriginPosition To: aDestinationPosition
	^Error signal: game class cannotPlayOutOfTurn.
	
	! !

!TerniLapilliPlayerOPutPieceState methodsFor: 'player actions' stamp: 'EMI 11/1/2020 13:19:50'!
putOAt: aPosition
	game putOWhenPlayerIsOAt: aPosition.! !

!TerniLapilliPlayerOPutPieceState methodsFor: 'player actions' stamp: 'EMI 11/1/2020 13:00:11'!
putXAt: aPosition
	^Error signal: game class cannotPlayOutOfTurn.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliPlayerOPutPieceState class' category: 'TerniLapilli'!
TerniLapilliPlayerOPutPieceState class
	instanceVariableNames: ''!

!TerniLapilliPlayerOPutPieceState class methodsFor: 'initialization' stamp: 'EMI 11/1/2020 13:02:15'!
ofGame: aTerniLapilliGame
	^self new initialize: aTerniLapilliGame.! !


!classDefinition: #TerniLapilliPlayerXMovePieceState category: 'TerniLapilli'!
TerniLapilliState subclass: #TerniLapilliPlayerXMovePieceState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliPlayerXMovePieceState methodsFor: 'testing' stamp: 'EMI 11/1/2020 13:02:57'!
hasPlayerOWon
	^false! !

!TerniLapilliPlayerXMovePieceState methodsFor: 'testing' stamp: 'EMI 11/1/2020 13:02:54'!
hasPlayerXWon
	^false! !

!TerniLapilliPlayerXMovePieceState methodsFor: 'testing' stamp: 'EMI 11/1/2020 13:02:48'!
isOver
	^false! !

!TerniLapilliPlayerXMovePieceState methodsFor: 'testing' stamp: 'EMI 11/1/2020 13:03:05'!
isPlayingO
	^false! !

!TerniLapilliPlayerXMovePieceState methodsFor: 'testing' stamp: 'EMI 11/1/2020 13:03:09'!
isPlayingX
	^true! !


!TerniLapilliPlayerXMovePieceState methodsFor: 'player actions' stamp: 'EMI 11/1/2020 13:04:57'!
moveOFrom: aOriginPosition To: aDestinationPosition
	^Error signal: game class cannotPlayOutOfTurn.
	! !

!TerniLapilliPlayerXMovePieceState methodsFor: 'player actions' stamp: 'EMI 11/1/2020 13:21:43'!
moveXFrom: aOriginPosition To: aDestinationPosition
	game moveXWhenPlayerIsXFrom: aOriginPosition To: aDestinationPosition.
	! !

!TerniLapilliPlayerXMovePieceState methodsFor: 'player actions' stamp: 'EMI 11/1/2020 13:04:23'!
putOAt: aPosition
	^Error signal: game class cannotPlayOutOfTurn.
	! !

!TerniLapilliPlayerXMovePieceState methodsFor: 'player actions' stamp: 'EMI 11/1/2020 13:04:06'!
putXAt: aPosition
	^Error signal: game class cannotPlaceMoreThan3PiecesError
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliPlayerXMovePieceState class' category: 'TerniLapilli'!
TerniLapilliPlayerXMovePieceState class
	instanceVariableNames: ''!

!TerniLapilliPlayerXMovePieceState class methodsFor: 'initialization' stamp: 'EMI 11/1/2020 13:05:48'!
ofGame: aTerniLapilliGame
	^self new initialize: aTerniLapilliGame.! !


!classDefinition: #TerniLapilliPlayerXPutPieceState category: 'TerniLapilli'!
TerniLapilliState subclass: #TerniLapilliPlayerXPutPieceState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliPlayerXPutPieceState methodsFor: 'testing' stamp: 'EMI 11/1/2020 12:44:57'!
hasPlayerOWon
	^false.! !

!TerniLapilliPlayerXPutPieceState methodsFor: 'testing' stamp: 'EMI 11/1/2020 12:44:53'!
hasPlayerXWon
	^false.! !

!TerniLapilliPlayerXPutPieceState methodsFor: 'testing' stamp: 'EMI 11/1/2020 12:44:30'!
isOver
	^false.! !

!TerniLapilliPlayerXPutPieceState methodsFor: 'testing' stamp: 'EMI 11/1/2020 12:44:45'!
isPlayingO
	^false.! !

!TerniLapilliPlayerXPutPieceState methodsFor: 'testing' stamp: 'EMI 11/1/2020 12:44:40'!
isPlayingX
	^true.! !


!TerniLapilliPlayerXPutPieceState methodsFor: 'player actions' stamp: 'EMI 11/1/2020 12:54:10'!
moveOFrom: aOriginPosition To: aDestinationPosition
	^Error signal: game class cannotPlayOutOfTurn.
	! !

!TerniLapilliPlayerXPutPieceState methodsFor: 'player actions' stamp: 'EMI 11/1/2020 13:01:38'!
moveXFrom: aOriginPosition To: aDestinationPosition
	^Error signal: game class cannotMovePieceBeforePlacingAllPieces.
	! !

!TerniLapilliPlayerXPutPieceState methodsFor: 'player actions' stamp: 'EMI 11/1/2020 12:52:56'!
putOAt: aPosition
	^Error signal: game class cannotPlayOutOfTurn.
	! !

!TerniLapilliPlayerXPutPieceState methodsFor: 'player actions' stamp: 'EMI 11/1/2020 13:18:28'!
putXAt: aPosition
	game putXWhenPlayerIsXAt: aPosition.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliPlayerXPutPieceState class' category: 'TerniLapilli'!
TerniLapilliPlayerXPutPieceState class
	instanceVariableNames: ''!

!TerniLapilliPlayerXPutPieceState class methodsFor: 'as yet unclassified' stamp: 'EMI 11/1/2020 12:55:40'!
ofGame: aTerniLapilliGame
	^self new initialize: aTerniLapilliGame.! !
