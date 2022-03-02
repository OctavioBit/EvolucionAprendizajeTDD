!classDefinition: #TerniLapilliTest category: 'Terni Lapilli'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliTest methodsFor: 'testing' stamp: 'GR 10/31/2020 17:14:51'!
test01GameStartsWithXTurn

	| juego |

	juego := TerniLapilli new.
	
	self assert: (juego isPlaying: juego playerX).
	self assert: juego isEmpty.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'GR 10/31/2020 17:16:03'!
test02AfterXPlaysIsOTurn

	| juego |
	
	juego := TerniLapilli new.
	
	juego putXAt: (0@0).
	
	self assert: (juego isPlaying: juego playerO).
	self deny: (juego isPlaying: juego playerX).
	self assert: (juego isOccupied: (0@0))! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'GR 10/31/2020 17:23:48'!
test03AfterOPlaysIsXTurn

	| juego |
	
	juego := TerniLapilli new.
	
	juego putXAt: (0@0).
	juego putOAt: (0@1).
	
	self assert: (juego isPlaying: juego playerX).
	self deny: (juego isPlaying: juego playerO).
	self assert: (juego isOccupied: (0@1))! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'GR 10/29/2020 19:31:09'!
test04XCanNotPlayInOTurn

	| juego |
	
	juego := TerniLapilli new.
	
	juego putXAt: (0@0).
	
	self 
		should: [ juego putXAt: (0@1). ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: (TerniLapilli canNotPlayInOthersTurn = anError messageText)
			]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'GR 10/29/2020 19:30:42'!
test05OCanNotPlayInXTurn

	| juego |
	
	juego := TerniLapilli new.
	
	self 
		should: [ juego putOAt: (1@1) ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: (TerniLapilli canNotPlayInOthersTurn = anError messageText)
			]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'GR 10/29/2020 19:29:04'!
test06XCanNotPlacePieceOutsideTheBoard

	| juego |
	
	juego := TerniLapilli new.
		
	self 
		should: [ juego putXAt: (4@0) ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: (TerniLapilli canNotPlacePieceInInvalidPosition = anError messageText)
			]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'GR 10/29/2020 19:28:42'!
test07OCanNotPlacePieceOutsideTheBoard

	| juego |
	
	juego := TerniLapilli new.
	
	juego putXAt: (0@0).
	
	self 
		should: [ juego putOAt: (4@0) ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: (TerniLapilli canNotPlacePieceInInvalidPosition = anError messageText)
			]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'GR 10/29/2020 20:09:51'!
test08CanNotPlacePieceOnOccupiedPosition

	| juego |
	
	juego := TerniLapilli new.
	
	juego putXAt: (0@0).
	juego putOAt: (0@1).
	
	self 
		should: [ juego putXAt: (0@0) ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: (TerniLapilli canNotPlacePieceInInvalidPosition = anError messageText)
			]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'GR 10/29/2020 20:12:27'!
test09EachPlayerCanNotPlaceMoreThanThreePieces

	| juego |
	
	juego := TerniLapilli new.
	
	juego putXAt: (0@0).
	juego putOAt: (0@1).
	juego putXAt: (0@-1).
	juego putOAt: (1@1).
	juego putXAt: (-1@1).
	juego putOAt: (1@0).
	
	self 
		should: [ juego putXAt: (1@-1) ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: (TerniLapilli canNotPlaceMoreThanThreePieces = anError messageText)
			]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'MMT 11/1/2020 20:16:31'!
test10PlayerCanNotMoveMoreThanOnePosition
	
	| juego playerX occupiedXPositions playerO |
	
	juego := TerniLapilli new.
	
	juego putXAt: (0@0).
	juego putOAt: (-1@-1).
	juego putXAt: (0@-1).
	juego putOAt: (1@1).
	juego putXAt: (-1@1).
	juego putOAt: (1@0).
	
	playerX := juego playerX.
	playerO := juego playerO.
	occupiedXPositions := juego occupiedXPositions.
	 
	
	self 
		should: [juego move: playerX PieceFrom: occupiedXPositions In: (0@-1) To: (0@1) AndChangeTurnTo: playerO. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: (TerniLapilli canNotDoAnInvalidMove = anError messageText)
			]
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'MMT 11/1/2020 20:16:31'!
test11PlayerCanNotMoveAPieceOutsideTheBoard
	
	| juego playerX occupiedXPositions playerO |
	
	juego := TerniLapilli new.
	
	juego putXAt: (0@0).
	juego putOAt: (0@1).
	juego putXAt: (0@-1).
	juego putOAt: (1@1).
	juego putXAt: (-1@1).
	juego putOAt: (1@0).
	
	playerX := juego playerX.
	playerO  := juego playerO.
	occupiedXPositions := juego occupiedXPositions.
	
	self 
		should: [juego move: playerX PieceFrom: occupiedXPositions In: (0@0) To: (0@4) AndChangeTurnTo: playerO .]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: (TerniLapilli canNotDoAnInvalidMove = anError messageText)
			]
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'MMT 11/1/2020 20:16:31'!
test12PlayerCanNotMoveAPieceThatIsNotOnTheBoard
	
	| juego occupiedXPositions playerO playerX |
	
	juego := TerniLapilli new.
	
	juego putXAt: (0@0).
	juego putOAt: (0@1).
	juego putXAt: (0@-1).
	juego putOAt: (1@1).
	juego putXAt: (-1@1).
	juego putOAt: (1@0).

	playerX := juego playerX.
	playerO := juego playerO .
	occupiedXPositions := juego occupiedXPositions.
	
	
	self 
		should: [juego move: playerX PieceFrom: occupiedXPositions In: (-1@0) To: (-1@-1) AndChangeTurnTo: playerO.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: (TerniLapilli canNotDoAnInvalidMove = anError messageText)
			]
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'MMT 11/1/2020 20:16:31'!
test13PlayerCanNotMoveAPieceToAnOccupiedPosition
	
	| juego occupiedXPositions playerO playerX |
	
	juego := TerniLapilli new.
	
	juego putXAt: (0@0).
	juego putOAt: (0@1).
	juego putXAt: (0@-1).
	juego putOAt: (1@1).
	juego putXAt: (-1@1).
	juego putOAt: (1@0).
	
	playerX := juego playerX.
	playerO := juego playerO .
	occupiedXPositions := juego occupiedXPositions.
	
	
	
	self 
		should: [juego move: playerX PieceFrom: occupiedXPositions In: (0@0) To: (0@-1) AndChangeTurnTo: playerO .]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: (TerniLapilli canNotDoAnInvalidMove = anError messageText)
			]
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'MMT 11/1/2020 20:16:31'!
test14PlayerCanNotDoADiagonalMoveIfItIsNotFromCenterOrCorner
	
	| juego occupiedXPositions playerO playerX |
	
	juego := TerniLapilli new.
	
	juego putXAt: (0@0).
	juego putOAt: (0@-1).
	juego putXAt: (0@1).
	juego putOAt: (1@1).
	juego putXAt: (-1@1).
	juego putOAt: (-1@-1).
	
	playerX := juego playerX.
	playerO := juego playerO .
	occupiedXPositions := juego occupiedXPositions.
	
	
	self 
		should: [juego move: playerX PieceFrom: occupiedXPositions In: (0@1) To: (-1@0) AndChangeTurnTo: playerO.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: (TerniLapilli canNotDoAnInvalidMove = anError messageText)
			]
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'MMT 11/1/2020 20:16:31'!
test15PlayerCanMoveFromCenterToAnyEmptyPosition
	
	| juego occupiedXPositions playerX playerO|
	
	juego := TerniLapilli new.
	
	juego putXAt: (0@0).
	juego putOAt: (0@-1).
	juego putXAt: (0@1).
	juego putOAt: (1@1).
	juego putXAt: (-1@1).
	juego putOAt: (-1@-1).
	
	playerX := juego playerX.
	playerO := juego playerO .
	occupiedXPositions := juego occupiedXPositions.
	
	
	juego move: playerX PieceFrom: occupiedXPositions In: (0@0) To: (-1@0) AndChangeTurnTo: playerO .
	
	
	
	self assert: (juego isOccupied: (-1@0)).
	self assert: (juego isPlaying: juego playerO)
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'MMT 11/2/2020 01:04:08'!
test16PlayerCanNotMovePieceFromOtherPlayer
	
	| juego occupiedXPositions playerO playerX |
	
	juego := TerniLapilli new.
	
	juego putXAt: (0@0).
	juego putOAt: (0@-1).
	juego putXAt: (0@1).
	juego putOAt: (1@1).
	juego putXAt: (-1@1).
	juego putOAt: (-1@-1).
	
	playerX := juego playerX.
	playerO := juego playerO .
	occupiedXPositions := juego occupiedXPositions.
	
	
	self 
		should: [juego move: playerX PieceFrom: occupiedXPositions In: (-1@-1) To: (-1@0) AndChangeTurnTo: playerO.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: (TerniLapilli canNotDoAnInvalidMove = anError messageText)
			]
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'MMT 11/2/2020 01:04:21'!
test17PlayerCanMoveFromAnywhereToAdjacentPosition
	
	| juego occupiedOPositions occupiedXPositions playerO playerX |
	
	juego := TerniLapilli new.
	
	juego putXAt: (0@0).
	juego putOAt: (0@-1).
	juego putXAt: (0@1).
	juego putOAt: (1@1).
	juego putXAt: (-1@1).
	juego putOAt: (-1@-1).
	
	playerX := juego playerX.
	playerO := juego playerO .
	occupiedXPositions := juego occupiedXPositions.
	occupiedOPositions := juego occupiedOPositions.
	
	
	juego move: playerX PieceFrom: occupiedXPositions In: (0@0) To: (-1@0) AndChangeTurnTo: playerO .
	juego move: playerO PieceFrom: occupiedOPositions In: (1@1) To: (1@0) AndChangeTurnTo: playerX .
	
	self assert: (juego isOccupied: (1@0)).
	self assert: (juego isPlaying: juego playerX)
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'MMT 11/2/2020 01:04:30'!
test18PlayerXWinsVertically
	
	| juego occupiedXPositions playerX |
	
	juego := TerniLapilli new.
	
	juego putXAt: (0@0).
	juego putOAt: (1@-1).
	juego putXAt: (0@1).
	juego putOAt: (1@1).
	juego putXAt: (0@-1).
	
	playerX := juego playerX.
	occupiedXPositions := juego occupiedXPositions. 
	
	self assert: (juego has: playerX WonWith: occupiedXPositions).
	self assert: (juego isOver)
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'MMT 11/2/2020 01:04:39'!
test19PlayerOWinsVertically
	
	| juego occupiedOPositions playerO |
	
	juego := TerniLapilli new.
	
	juego putXAt: (1@-1).
	juego putOAt: (0@0).
	juego putXAt: (1@1).
	juego putOAt: (0@1).
	juego putXAt: (-1@-1).
	juego putOAt: (0@-1).
	
	playerO := juego playerO.
	occupiedOPositions := juego occupiedOPositions. 
	
	self assert: (juego has: playerO WonWith: occupiedOPositions).
	self assert: (juego isOver)
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'MMT 11/2/2020 01:04:48'!
test20PlayerXWinsHorizontally
	
	| juego occupiedXPositions playerX |
	
	juego := TerniLapilli new.
	
	juego putXAt: (0@0).
	juego putOAt: (1@-1).
	juego putXAt: (1@0).
	juego putOAt: (1@1).
	juego putXAt: (-1@0).
	
	playerX := juego playerX.
	occupiedXPositions := juego occupiedXPositions. 
	
	self assert: (juego has: playerX WonWith: occupiedXPositions ).
	self assert: (juego isOver)
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'MMT 11/2/2020 01:04:59'!
test21PlayerWinsDiagonally
	
	| juego occupiedXPositions playerX |
	
	juego := TerniLapilli new.
	
	juego putXAt: (0@0).
	juego putOAt: (1@-1).
	juego putXAt: (-1@-1).
	juego putOAt: (1@0).
	juego putXAt: (1@1).
	
	playerX := juego playerX.
	occupiedXPositions := juego occupiedXPositions. 
	
	self assert: (juego has: playerX WonWith: occupiedXPositions).
	self assert: (juego isOver)
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'MMT 11/2/2020 01:05:07'!
test22PlayerCanWinWithAMovement
	
	| juego occupiedXPositions playerO playerX |
	
	juego := TerniLapilli new.
	
	juego putXAt: (0@0).
	juego putOAt: (1@0).
	juego putXAt: (0@1).
	juego putOAt: (-1@1).
	juego putXAt: (1@-1).
	juego putOAt: (-1@-1).
	
	
	playerX := juego playerX.
	playerO := juego playerO .
	occupiedXPositions := juego occupiedXPositions.
	
	
	juego move: playerX PieceFrom: occupiedXPositions In: (1@-1) To: (0@-1) AndChangeTurnTo: playerO .
	
	
	self assert: (juego has: playerX WonWith: occupiedXPositions ).
	self assert: (juego isOver)
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'MMT 11/2/2020 01:05:13'!
test23PlayerCanNotPlaceAPieceIfGameIsOver
	
	| juego occupiedXPositions playerO playerX |
	
	juego := TerniLapilli new.
	
	juego putXAt: (0@0).
	juego putOAt: (1@-1).
	juego putXAt: (0@1).
	juego putOAt: (1@1).
	juego putXAt: (0@-1).
	
	playerX := juego playerX.
	playerO := juego playerO .
	occupiedXPositions := juego occupiedXPositions.
	
	
	
	self assert: (juego has: playerX WonWith: occupiedXPositions).
	self assert: (juego isOver).
	self
		should: [ juego putOAt: (1@0) ]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: TerniLapilli canNotPlayIfGameIsOver = anError messageText ]
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'MMT 11/2/2020 01:05:20'!
test24PlayerCanNotMoveAPieceIfGameIsOver
	
	| juego occupiedXPositions playerO playerX |
	
	juego := TerniLapilli new.
	
	juego putXAt: (-1@1).
	juego putOAt: (0@0).
	juego putXAt: (1@1).
	juego putOAt: (0@1).
	juego putXAt: (1@-1).
	juego putOAt: (0@-1).
	
	playerX := juego playerX.
	playerO := juego playerO .
	occupiedXPositions := juego occupiedXPositions.
	
	
	self
		should: [juego move: playerX PieceFrom: occupiedXPositions In: (-1@1) To: (-1@0) AndChangeTurnTo: playerO. ]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: TerniLapilli canNotPlayIfGameIsOver = anError messageText ]
	
	! !


!classDefinition: #Player category: 'Terni Lapilli'!
Object subclass: #Player
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!Player methodsFor: 'initialization' stamp: 'GR 10/31/2020 19:07:45'!
initializeNewIn: aTerniLapilli
	
	terniLapilli := aTerniLapilli.! !


!Player methodsFor: 'actions' stamp: 'GR 10/31/2020 19:06:32'!
movesThePieceIn: aPosition to: anotherPosition

	self subclassResponsibility.! !

!Player methodsFor: 'actions' stamp: 'GR 10/31/2020 17:01:34'!
placesAPieceIn: aPosition
	
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Player class' category: 'Terni Lapilli'!
Player class
	instanceVariableNames: ''!

!Player class methodsFor: 'as yet unclassified' stamp: 'GR 10/31/2020 16:28:06'!
newIn: aTerniLapilli

	^self new initializeNewIn: aTerniLapilli! !


!classDefinition: #PlayerO category: 'Terni Lapilli'!
Player subclass: #PlayerO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!PlayerO methodsFor: 'actions' stamp: 'GR 10/31/2020 19:05:07'!
movesThePieceIn: aPosition to: anotherPosition
	
	terniLapilli playerOmovesThePieceIn: aPosition to: anotherPosition.! !

!PlayerO methodsFor: 'actions' stamp: 'GR 10/31/2020 19:05:37'!
placesAPieceIn: aPosition

	terniLapilli playerOPlacesAPieceIn: aPosition.! !


!classDefinition: #PlayerX category: 'Terni Lapilli'!
Player subclass: #PlayerX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!PlayerX methodsFor: 'actions' stamp: 'GR 10/31/2020 19:06:17'!
movesThePieceIn: aPosition to: anotherPosition
	
	terniLapilli playerXmovesThePieceIn: aPosition to: anotherPosition! !

!PlayerX methodsFor: 'actions' stamp: 'GR 10/31/2020 19:00:45'!
placesAPieceIn: aPosition

	terniLapilli playerXPlacesAPieceIn: aPosition.! !


!classDefinition: #TerniLapilli category: 'Terni Lapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'turn playerX playerO occupiedXPositions occupiedOPositions isOver'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilli methodsFor: 'initialization' stamp: 'GR 10/31/2020 19:45:02'!
initialize

	playerX  := PlayerX newIn: self.
	playerO  := PlayerO newIn: self.
	occupiedXPositions  := Set new.
	occupiedOPositions  := Set new.
	isOver := false.
	turn := playerX.! !


!TerniLapilli methodsFor: 'operations' stamp: 'MMT 11/1/2020 20:28:25'!
beforeWinning: aPlayer PlacesPieceTo: aPosition AndPutItIn: hisOccupiedPieces AndChangeTurnTo: anotherPlayer
	
	
	self thePlayer: aPlayer canPlaceAPieceIn: aPosition.
	
	hisOccupiedPieces add: aPosition.
	
	turn := anotherPlayer.
	
	self seeIfCertainPlayerWon: aPlayer with: hisOccupiedPieces .! !

!TerniLapilli methodsFor: 'operations' stamp: 'MMT 11/1/2020 20:08:03'!
beforeWinning: aPlayer movesFrom: hisPieces ThePieceIn: aPosition to: anotherPosition AndChangeTurnTo: anotherPlayer
	
	(self isValidMoveFrom: aPosition to: anotherPosition) ifFalse: [ self error: TerniLapilli canNotDoAnInvalidMove ].
	
	hisPieces remove: aPosition ifAbsent: [self error: TerniLapilli canNotDoAnInvalidMove].
	
	hisPieces add: anotherPosition.
	
	turn := anotherPlayer.
	
	self seeIfCertainPlayerWon: aPlayer with: hisPieces .! !

!TerniLapilli methodsFor: 'operations' stamp: 'MMT 11/1/2020 20:16:43'!
move: aPlayer PieceFrom: hisPieces In: aPosition To: anotherPosition AndChangeTurnTo: anotherPlayer
	
	^ self state move: aPlayer PieceFrom: hisPieces In: aPosition To: anotherPosition AndChangeTurnTo: anotherPlayer.
	
	! !

!TerniLapilli methodsFor: 'operations' stamp: 'MMT 11/1/2020 20:28:49'!
place: aPlayer PieceTo: aPosition AndPutItIn: hisOccupiedPieces AndChangeTurnTo: anotherPlayer
	
	
	^ self state place: aPlayer PieceTo: aPosition AndPutItIn: hisOccupiedPieces AndChangeTurnTo: anotherPlayer.! !

!TerniLapilli methodsFor: 'operations' stamp: 'MMT 11/1/2020 19:44:27'!
playerTriesToPlayWhenGameIsOver

	self error: TerniLapilli canNotPlayIfGameIsOver.! !

!TerniLapilli methodsFor: 'operations' stamp: 'MMT 11/1/2020 20:26:42'!
putOAt: aPosition
	
	
	self place: playerO PieceTo: aPosition AndPutItIn: occupiedOPositions AndChangeTurnTo: playerX. 
	! !

!TerniLapilli methodsFor: 'operations' stamp: 'MMT 11/1/2020 20:26:42'!
putXAt: aPosition
	
	self place: playerX PieceTo: aPosition AndPutItIn: occupiedXPositions AndChangeTurnTo: playerO.! !


!TerniLapilli methodsFor: 'testing' stamp: 'MMT 11/1/2020 17:58:38'!
has: aPlayer WonWith: aCertainPiecesInBoard
	
	| anOccupiedPosition |
	
	(aCertainPiecesInBoard size < 3) ifTrue: [ ^false ].
	
	anOccupiedPosition := aCertainPiecesInBoard detect: [ :aPosition | true].
	
	^ (aCertainPiecesInBoard allSatisfy: [ :aPosition | (anOccupiedPosition x = aPosition x)])  or:
		(aCertainPiecesInBoard allSatisfy: [ :aPosition | (anOccupiedPosition y = aPosition y)]) or:
		(self winsDiagonally: aCertainPiecesInBoard)! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 10/31/2020 16:24:26'!
isAValidPosition: aPosition

	^(self isInTheBoard: aPosition) and: (self isOccupied: aPosition) not! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 10/31/2020 19:16:06'!
isEmpty
	
	^ occupiedXPositions isEmpty.! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 10/31/2020 19:16:33'!
isOccupied: aPosition 
	
	^(occupiedXPositions includes: aPosition) or: (occupiedOPositions includes: aPosition)! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 10/31/2020 19:44:33'!
isOver
	
	^ isOver! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 10/29/2020 19:58:25'!
isPlaying: aPlayer

	^ turn = aPlayer
	
	! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 10/31/2020 16:00:15'!
isValidMoveFrom: aPosition to: anotherPosition
	
	(self isAValidPosition: anotherPosition) ifFalse: [ ^false ].
	
	(self isOccupied: aPosition) ifFalse: [ ^false ].
	
	(aPosition = (0@0)) ifTrue: [ ^ true ].
	
	(self distanceIsGreaterThanOnePositionGoingFrom: aPosition to: anotherPosition) ifTrue: [ ^false ].
	
	(self doesADiagonalMoveGoingFrom: anotherPosition to: aPosition) ifTrue: [ ^false ].
	
	^true
	
	
	
	! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 10/31/2020 16:43:47'!
thePlayer: aPlayer canPlaceAPieceIn: aPosition

	(self totalPiecesPlayed = 6) ifTrue: [self error: TerniLapilli canNotPlaceMoreThanThreePieces].
	
	(self isPlaying: aPlayer) ifFalse: [ self error: TerniLapilli canNotPlayInOthersTurn ].
	
	(self isAValidPosition: aPosition) ifFalse: [ self error: TerniLapilli canNotPlacePieceInInvalidPosition ].! !

!TerniLapilli methodsFor: 'testing' stamp: 'GR 10/31/2020 19:17:52'!
totalPiecesPlayed
	
	^ occupiedXPositions size + occupiedOPositions size.! !


!TerniLapilli methodsFor: 'private' stamp: 'GR 10/31/2020 15:18:48'!
distanceIsGreaterThanOnePositionGoingFrom: aPosition to: anotherPosition

	^((aPosition - anotherPosition) abs <= (1@1)) not! !

!TerniLapilli methodsFor: 'private' stamp: 'GR 10/31/2020 16:08:36'!
doesADiagonalMoveGoingFrom: aPosition to: anotherPosition

	^ aPosition x ~= anotherPosition x and: (aPosition y ~= anotherPosition y)! !

!TerniLapilli methodsFor: 'private' stamp: 'GR 10/31/2020 16:24:54'!
isInTheBoard: aPosition

	^ ((0@0) eightNeighbors includes: aPosition) or: aPosition = (0@0)! !

!TerniLapilli methodsFor: 'private' stamp: 'MMT 11/1/2020 19:56:22'!
state 

	^TerniLapilliState stateFor: self! !


!TerniLapilli methodsFor: 'accessing' stamp: 'MMT 11/1/2020 18:20:32'!
occupiedOPositions

 	^ occupiedOPositions! !

!TerniLapilli methodsFor: 'accessing' stamp: 'MMT 11/1/2020 18:20:21'!
occupiedXPositions

 	^ occupiedXPositions! !

!TerniLapilli methodsFor: 'accessing' stamp: 'GR 10/31/2020 17:23:24'!
playerO
	
	^playerO! !

!TerniLapilli methodsFor: 'accessing' stamp: 'GR 10/31/2020 17:15:08'!
playerX
	
	^ playerX! !


!TerniLapilli methodsFor: 'private -- testing' stamp: 'MMT 11/1/2020 18:07:15'!
seeIfCertainPlayerWon: aPlayer with: certainPiecesOcuppied
	
	isOver := self has: aPlayer WonWith: certainPiecesOcuppied
	.! !

!TerniLapilli methodsFor: 'private -- testing' stamp: 'GR 10/31/2020 20:13:55'!
winsDiagonally: aPlayerPieces

	^ (aPlayerPieces allSatisfy: [ :aPosition | aPosition x abs = aPosition y abs])  and: (aPlayerPieces includes: (0@0))! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: 'Terni Lapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error handling' stamp: 'GR 10/29/2020 20:30:50'!
canNotDoAnInvalidMove
	
	^ 'You can not do that move!!'! !

!TerniLapilli class methodsFor: 'error handling' stamp: 'GR 10/29/2020 20:15:58'!
canNotPlaceMoreThanThreePieces
	
	^ 'You can not play more than three pieces!!'! !

!TerniLapilli class methodsFor: 'error handling' stamp: 'GR 10/29/2020 19:24:32'!
canNotPlacePieceInInvalidPosition
	
	^ 'You are placing a piece in an invalid position!!'! !

!TerniLapilli class methodsFor: 'error handling' stamp: 'GR 10/31/2020 19:41:07'!
canNotPlayIfGameIsOver

	^ 'Game is over!!'! !

!TerniLapilli class methodsFor: 'error handling' stamp: 'GR 10/29/2020 19:34:15'!
canNotPlayInOthersTurn
	
	^ 'You can not play in the other player turn!!'! !


!TerniLapilli class methodsFor: 'initialization' stamp: 'MMT 11/1/2020 17:31:01'!
canHandle: aTerniLapilli

	^ self subclassResponsibility 
! !

!TerniLapilli class methodsFor: 'initialization' stamp: 'MMT 11/1/2020 17:32:07'!
for: aTerniLapilli

	^ self new initializeFor: aTerniLapilli 

! !

!TerniLapilli class methodsFor: 'initialization' stamp: 'MMT 11/1/2020 17:33:15'!
stateFor: aTerniLapilli

	^(self subclasses detect: [:aTerniLapilliClass | aTerniLapilliClass canHandle: aTerniLapilli ]) for: aTerniLapilli! !


!classDefinition: #TerniLapilliState category: 'Terni Lapilli'!
Object subclass: #TerniLapilliState
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliState methodsFor: 'initialization' stamp: 'MMT 11/1/2020 17:43:12'!
initializeFor: aTerniLapilli

	terniLapilli := aTerniLapilli ! !


!TerniLapilliState methodsFor: 'operations' stamp: 'MMT 11/1/2020 20:10:48'!
move: aPlayer PieceFrom: hisPieces In: aPosition To: anotherPosition AndChangeTurnTo: anotherPlayer

	^ self subclassResponsibility.! !

!TerniLapilliState methodsFor: 'operations' stamp: 'MMT 11/1/2020 20:26:42'!
place: aPlayer PieceTo: hisPieces AndPutItIn: aPosition AndChangeTurnTo: anotherPlayer

	^ self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliState class' category: 'Terni Lapilli'!
TerniLapilliState class
	instanceVariableNames: ''!

!TerniLapilliState class methodsFor: 'initialization' stamp: 'MMT 11/1/2020 17:39:21'!
canHandle: aTerniLapilli

	^ self subclassResponsibility.! !

!TerniLapilliState class methodsFor: 'initialization' stamp: 'MMT 11/1/2020 17:40:29'!
for: aTerniLapilli

	^ self new initializeFor: aTerniLapilli! !

!TerniLapilliState class methodsFor: 'initialization' stamp: 'MMT 11/1/2020 17:42:38'!
stateFor: aTerniLapilli

	^ (self subclasses detect: [:aTerniLapilliState | aTerniLapilliState canHandle: aTerniLapilli]) for: aTerniLapilli. 
	
	! !


!classDefinition: #FinishedTerniLapilliState category: 'Terni Lapilli'!
TerniLapilliState subclass: #FinishedTerniLapilliState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!FinishedTerniLapilliState methodsFor: 'as yet unclassified' stamp: 'MMT 11/1/2020 19:53:12'!
move: aPlayer PieceFrom: hisPieces In: aPosition To: anotherPosition AndChangeTurnTo: anotherPlayer

	^ terniLapilli playerTriesToPlayWhenGameIsOver.! !

!FinishedTerniLapilliState methodsFor: 'as yet unclassified' stamp: 'MMT 11/1/2020 20:27:00'!
place: aPlayer PieceTo: aPosition AndPutItIn: hisPieces AndChangeTurnTo: anotherPlayer

	^ terniLapilli playerTriesToPlayWhenGameIsOver.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FinishedTerniLapilliState class' category: 'Terni Lapilli'!
FinishedTerniLapilliState class
	instanceVariableNames: ''!

!FinishedTerniLapilliState class methodsFor: 'as yet unclassified' stamp: 'MMT 11/1/2020 17:44:18'!
canHandle: aTerniLapilli

	^ aTerniLapilli isOver.! !


!classDefinition: #NotFinishedTerniLapilliState category: 'Terni Lapilli'!
TerniLapilliState subclass: #NotFinishedTerniLapilliState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!NotFinishedTerniLapilliState methodsFor: 'as yet unclassified' stamp: 'MMT 11/1/2020 20:08:03'!
move: aPlayer PieceFrom: hisPieces In: aPosition To: anotherPosition AndChangeTurnTo: anotherPlayer

	

	^ terniLapilli beforeWinning: aPlayer movesFrom: hisPieces ThePieceIn: aPosition to: anotherPosition  
	                  AndChangeTurnTo:anotherPlayer. ! !

!NotFinishedTerniLapilliState methodsFor: 'as yet unclassified' stamp: 'MMT 11/1/2020 20:30:24'!
place: aPlayer PieceTo: aPosition AndPutItIn: hisPieces AndChangeTurnTo: anotherPlayer

	^ terniLapilli beforeWinning: aPlayer PlacesPieceTo: aPosition  AndPutItIn: hisPieces AndChangeTurnTo: anotherPlayer. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NotFinishedTerniLapilliState class' category: 'Terni Lapilli'!
NotFinishedTerniLapilliState class
	instanceVariableNames: ''!

!NotFinishedTerniLapilliState class methodsFor: 'as yet unclassified' stamp: 'MMT 11/1/2020 17:45:35'!
canHandle: aTerniLapilli

	^ aTerniLapilli  isOver not.! !
