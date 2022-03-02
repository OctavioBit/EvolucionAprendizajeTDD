!classDefinition: #TerniLapilliTest category: #'Terni Lapilli'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliTest methodsFor: 'auxiliary' stamp: 'FG 10/31/2020 16:45:40'!
should: aBlockThatShouldFail raisingAnErrorAndAsserting: aVerificationBlock

    [aBlockThatShouldFail value. self fail.]
    on: Error
    do: aVerificationBlock.! !


!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 10/29/2020 18:36:58'!
test01PlayerXPutsAPieceInAnEmptyPositionOnTheBoard

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.
	terniLapilli putXAt: 1@1.

	self assert: (terniLapilli ocupiedByX: 1@1) equals: true.
 ! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 10/29/2020 18:36:31'!
test02PlayerXPutsAPieceInAnEmptyAndDifferentPositionOnTheBoard

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.
	terniLapilli putXAt: 3@3.

	self assert: (terniLapilli ocupiedByX: 3@3) equals: true.
	self assert: (terniLapilli ocupiedByX: 1@1) equals: false.
 

! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 10/31/2020 17:30:22'!
test03PlayerOPutsAPieceInAnEmptyPositionOnTheBoard

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.
	terniLapilli putXAt: 3@3.
	terniLapilli putOAt: 1@1.

	self assert: (terniLapilli ocupiedByO: 1@1) equals: true.
 ! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 10/29/2020 18:43:47'!
test04GameIsntOverAtTheBegginnig

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.
	
	self assert: (terniLapilli isOver) equals: false.
 ! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 10/29/2020 19:03:27'!
test05PlayersHadntWonAtTheBegginnig

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.
	
	self assert: (terniLapilli hasPlayerXWon) equals: false.
	self assert: (terniLapilli hasPlayerOWon) equals: false.
 ! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 10/29/2020 19:03:49'!
test06IsTurnOfXAtTheBeggining

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.
	
	self assert: (terniLapilli isPlayingX) equals: true.
 ! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 10/31/2020 17:55:43'!
test07IsTurnOfOAfterXPlayed

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.
	terniLapilli putXAt: 1@1.
	
	self assert: (terniLapilli isPlayingX) equals: false.
	self assert: (terniLapilli isPlayingO) equals: true.
	
	terniLapilli putOAt: 1@2.
	terniLapilli putXAt: 1@3.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 2@1.
	terniLapilli putOAt: 3@3.
	terniLapilli moveXFrom: 2@1 to: 3@1. 
 
	self assert: (terniLapilli isPlayingX) equals: false.
	self assert: (terniLapilli isPlayingO) equals: true.
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 10/31/2020 17:58:33'!
test08IsTurnOfXAfterOPlayed

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 1@2.
	
	self assert: (terniLapilli isPlayingX) equals: true.
	self assert: (terniLapilli isPlayingO) equals: false.
	
	terniLapilli putXAt: 1@3.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 2@1.
	terniLapilli putOAt: 3@3.
	terniLapilli moveXFrom: 2@1 to: 3@1. 
	terniLapilli moveOFrom: 2@2 to: 2@1.  

	self assert: (terniLapilli isPlayingX) equals: true.
	self assert: (terniLapilli isPlayingO) equals: false.
 ! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 10/29/2020 19:19:45'!
test09PlayerXMovesAPiece

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@3.
	terniLapilli putOAt: 3@1.
	terniLapilli putXAt: 1@3.
	terniLapilli putOAt: 3@2.

	terniLapilli moveXFrom: 1@1 to: 1@2.	

	self assert: (terniLapilli ocupiedByX: 1@1) equals: false.
	self assert: (terniLapilli ocupiedByX: 1@2) equals: true.
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 10/29/2020 19:25:33'!
test10PlayerOMovesAPiece

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@3.
	terniLapilli putOAt: 3@1.
	terniLapilli putXAt: 1@3.
	terniLapilli putOAt: 3@2.

	terniLapilli moveXFrom: 1@1 to: 1@2.	
	terniLapilli moveOFrom: 3@1 to: 2@1.

	self assert: (terniLapilli ocupiedByO: 3@1) equals: false.
	self assert: (terniLapilli ocupiedByO: 2@1) equals: true.
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 10/31/2020 15:58:12'!
test11PlayerXWinsWithThreePiecesInARow

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 1@2.
	terniLapilli putOAt: 3@1.
	terniLapilli putXAt: 1@3.

	self assert: (terniLapilli isOver) equals: true.
	self assert: (terniLapilli hasPlayerXWon) equals: true.
	self assert: (terniLapilli hasPlayerOWon) equals: false.
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 10/31/2020 17:16:12'!
test12PlayerXWinsWithThreePiecesInAColumn

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 2@1.
	terniLapilli putOAt: 2@3.
	terniLapilli putXAt: 3@1.

	self assert: (terniLapilli isOver) equals: true.
	self assert: (terniLapilli hasPlayerXWon) equals: true.
	self assert: (terniLapilli hasPlayerOWon) equals: false.
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 10/31/2020 16:20:25'!
test13PlayerXWinsWithThreePiecesInTheIncreasingDiagonal

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@1.
	terniLapilli putXAt: 2@2.
	terniLapilli putOAt: 3@1.
	terniLapilli putXAt: 3@3.

	self assert: (terniLapilli isOver) equals: true.
	self assert: (terniLapilli hasPlayerXWon) equals: true.
	self assert: (terniLapilli hasPlayerOWon) equals: false.
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 10/31/2020 16:23:10'!
test14PlayerXWinsWithThreePiecesInTheDecreasingDiagonal

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.
	
	terniLapilli putXAt: 1@3.
	terniLapilli putOAt: 1@2.
	terniLapilli putXAt: 2@2.
	terniLapilli putOAt: 1@1.
	terniLapilli putXAt: 3@1.

	self assert: (terniLapilli isOver) equals: true.
	self assert: (terniLapilli hasPlayerXWon) equals: true.
	self assert: (terniLapilli hasPlayerOWon) equals: false.
! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 10/31/2020 16:31:13'!
test15PlayerOWinsWithThreePiecesInAWinningCombination

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.
	
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 3@2.
	terniLapilli putXAt: 2@2.
	terniLapilli putOAt: 3@3.
	terniLapilli putXAt: 1@3.
	terniLapilli putOAt: 3@1.

	self assert: (terniLapilli isOver) equals: true.
	self assert: (terniLapilli hasPlayerXWon) equals: false.
	self assert: (terniLapilli hasPlayerOWon) equals: true.
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 11/1/2020 15:40:34'!
test16PlayerXCantPutAPieceInAInvalidPosition

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.
	
	self should: [terniLapilli putXAt: 1@4] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantMovePIeceToAnInvalidPosition ].
	self should: [terniLapilli putXAt: 2.3@3] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantMovePIeceToAnInvalidPosition ].
	

	

	
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 11/1/2020 15:41:07'!
test17PlayerOCantPutAPieceInAInvalidPosition

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.
	terniLapilli putXAt: 1@2. 
	
	self should: [terniLapilli putOAt:0@4] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantMovePIeceToAnInvalidPosition ].
	self should: [terniLapilli putOAt: 2.5@3]
		 raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantMovePIeceToAnInvalidPosition ].
	

	

	
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 11/1/2020 15:41:24'!
test18PlayerXCantPutAPieceInAPositionWithAnotherPiece

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.
	terniLapilli putXAt: 1@2. 
	terniLapilli putOAt:1@3. 
	
	self should: [terniLapilli putXAt: 1@3] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantStackPieces ].
	
	self should: [terniLapilli putXAt: 1@2]
		 raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantStackPieces ].
	

	

	
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 11/1/2020 15:41:44'!
test19PlayerOCantPutAPieceInAPositionWithAnotherPiece

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.
	terniLapilli putXAt: 1@2. 
	
	self should: [terniLapilli putOAt:1@2] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantStackPieces ].
	
	terniLapilli putOAt: 1@3. 
	terniLapilli putXAt: 1@1.
	
	self should: [ terniLapilli putOAt: 1@3]
		 raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantStackPieces ].
	

	

	
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 11/1/2020 15:42:02'!
test20PlayerXCantPutAPieceDuringOTurn

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.
	terniLapilli putXAt: 1@1. 
	
	self should: [terniLapilli putXAt:1@3] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantPlayIfItsNotMyTurn ].
		


	
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 11/1/2020 15:42:11'!
test21PlayerOCantPutAPieceDuringXTurn

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.
	
	self should: [terniLapilli putOAt: 1@2.] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantPlayIfItsNotMyTurn ].

	

	
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 11/1/2020 15:42:37'!
test22PlayerXCantPutMoreThanThreePieces

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 2@1.
	terniLapilli putOAt: 1@3.
	terniLapilli putXAt: 3@3.
	terniLapilli putOAt: 1@2.
	
	self should: [terniLapilli putXAt: 2@3.] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantPutPieceIfThereIsThreePiecesOnBoard ].

	

	
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 11/1/2020 15:42:55'!
test23PlayerOCantPutMoreThanThreePieces

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 2@1.
	terniLapilli putOAt: 1@3.
	terniLapilli putXAt: 3@3.
	terniLapilli putOAt: 1@2.
	terniLapilli moveXFrom: 3@3 to:2@3. 
	
	self should: [terniLapilli putOAt: 3@3.] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantPutPieceIfThereIsThreePiecesOnBoard].

	

	
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 10/31/2020 18:13:09'!
test24PlayerOCantPutAPieceWhenGameIsOver

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 1@2.
	terniLapilli putOAt: 3@3.
	terniLapilli putXAt: 1@3.
	
	self should: [terniLapilli putOAt: 2@3.] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantPlayWhenGameIsOver].

	

	
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 11/1/2020 15:45:06'!
test25PlayerXCantMoveAPieceThatHeDoesntOwn

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.

	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@1.
	terniLapilli putXAt: 3@1.
	terniLapilli putOAt: 1@2.
	terniLapilli putXAt: 1@3.
	terniLapilli putOAt: 2@3.
	
	self should: [terniLapilli moveXFrom: 3@4 to: 2@2 ] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantMoveAPieceYouDontHave ].
	self should: [terniLapilli moveXFrom:  1.3@3 to: 2@2] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantMoveAPieceYouDontHave ].
	self should: [terniLapilli moveXFrom:  3@3 to: 2@2] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantMoveAPieceYouDontHave ].
	self should: [terniLapilli moveXFrom:  1@2 to: 2@2] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantMoveAPieceYouDontHave ].

	

	
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 11/1/2020 15:36:57'!
test26PlayerOCantMoveAPieceThatHeDoesntOwn

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.

	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@1.
	terniLapilli putXAt: 3@1.
	terniLapilli putOAt: 1@2.
	terniLapilli putXAt: 1@3.
	terniLapilli putOAt: 2@3.
	terniLapilli moveXFrom: 3@1 to: 3@2.  
	
	self should: [terniLapilli moveOFrom: 3@4 to: 2@2 ] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantMoveAPieceYouDontHave].
	self should: [terniLapilli moveOFrom:  1.3@3 to: 2@2] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantMoveAPieceYouDontHave].
	self should: [terniLapilli moveOFrom:  3@3 to: 2@2] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantMoveAPieceYouDontHave].
	self should: [terniLapilli moveOFrom:  1@1 to: 2@2] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantMoveAPieceYouDontHave].

	

	
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 11/1/2020 15:36:00'!
test27PlayerXCantMoveAPieceToANonExistentPositionInTheBoard

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.

	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@1.
	terniLapilli putXAt: 3@1.
	terniLapilli putOAt: 1@2.
	terniLapilli putXAt: 1@3.
	terniLapilli putOAt: 2@3.
	
	self should: [terniLapilli moveXFrom: 1@1 to: 0@4 ] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantMovePIeceToAnInvalidPosition].
	self should: [terniLapilli moveXFrom:  1@1 to: 2.3@2] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantMovePIeceToAnInvalidPosition].

	

	
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 11/1/2020 15:35:19'!
test28PlayerOCantMoveAPieceToANonExistentPositionInTheBoard

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.

	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 2@1.
	terniLapilli putXAt: 3@1.
	terniLapilli putOAt: 1@2.
	terniLapilli putXAt: 1@3.
	terniLapilli putOAt: 2@3.
	terniLapilli moveXFrom: 1@1 to: 2@2. 
	
	self should: [terniLapilli moveOFrom: 2@1 to: 0@4 ] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantMovePIeceToAnInvalidPosition].
	self should: [terniLapilli moveOFrom:  2@1 to: 2.3@2] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantMovePIeceToAnInvalidPosition].

	

	
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 11/1/2020 15:33:58'!
test29PlayerXCantMoveAPieceToAPositionOccupiedByAnotherPiece

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.

	terniLapilli putXAt: 2@2.
	terniLapilli putOAt: 2@1.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 1@2.
	terniLapilli putXAt: 1@3.
	terniLapilli putOAt: 2@3.
	
	self should: [terniLapilli moveXFrom: 2@2 to: 2@1 ] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantStackPieces].
	self should: [terniLapilli moveXFrom:  2@2 to: 3@2] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantStackPieces].

	

	
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 11/1/2020 15:33:30'!
test30PlayerOCantMoveAPieceToAPositionOccupiedByAnotherPiece

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.

	terniLapilli putXAt: 2@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 1@2.
	terniLapilli putXAt: 1@3.
	terniLapilli putOAt: 2@3.
	terniLapilli moveXFrom: 2@1 to: 1@1. 
	
	self should: [terniLapilli moveOFrom: 2@2 to: 1@1 ] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantStackPieces ].
	self should: [terniLapilli moveOFrom:  2@2 to: 1@2] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantStackPieces ].

	

	
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 11/1/2020 15:32:45'!
test31PlayerXCantMoveDuringPlayerOTurn

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.

	terniLapilli putXAt: 2@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 1@2.
	terniLapilli putXAt: 1@3.
	
	self should: [terniLapilli moveXFrom: 2@1 to: 1@1 ] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantPlayIfItsNotMyTurn].

	

	
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 11/1/2020 15:32:54'!
test32PlayerOCantMoveDuringPlayerXTurn

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.

	terniLapilli putXAt: 2@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 1@2.
	terniLapilli putXAt: 1@3.
	terniLapilli putOAt: 2@3.
	
	self should: [terniLapilli moveOFrom: 2@2 to: 1@1] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantPlayIfItsNotMyTurn].

	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 11/1/2020 15:32:12'!
test33PlayerXMustMoveThroughBoardLines

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.

	terniLapilli putXAt: 2@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 1@1.
	terniLapilli putXAt: 1@3.
	terniLapilli putOAt: 2@3.
	
	self should: [terniLapilli moveXFrom: 2@1 to: 1@2] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantBreakMovementRules].

	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 11/1/2020 15:31:53'!
test34PlayerOMustMoveThroughBoardLines

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.

	terniLapilli putXAt: 2@1.
	terniLapilli putOAt: 2@2.
	terniLapilli putXAt: 3@2.
	terniLapilli putOAt: 1@1.
	terniLapilli putXAt: 1@3.
	terniLapilli putOAt: 2@3.
	terniLapilli moveXFrom: 3@2 to: 3@1.
	
	self should: [terniLapilli moveOFrom: 2@3 to: 1@2] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantBreakMovementRules].

	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 11/1/2020 15:31:04'!
test35PlayerXCantMovePiecesIfThereAreLessThanThreeXPiecesInTheBoard

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.

	terniLapilli putXAt: 1@1.
	terniLapilli  putOAt: 2@2.
	
	self should: [terniLapilli moveXFrom: 1@1 to: 1@2] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantMovePieceBeforeHavingThreePiecesOnTheBoard].

	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 11/1/2020 15:30:40'!
test36PlayerOCantMovePiecesIfThereAreLessThanThreeXPiecesInTheBoard

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.

	terniLapilli putXAt: 1@1.
	terniLapilli  putOAt: 2@2.
	terniLapilli putXAt: 3@3.
	
	self should: [terniLapilli moveOFrom: 2@2 to: 1@2] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantMovePieceBeforeHavingThreePiecesOnTheBoard ].

	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 10/31/2020 19:51:30'!
test37PlayerXCantMoveAPieceWhenGameIsOver

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 3@2.
	terniLapilli putXAt: 1@2.
	terniLapilli putOAt: 3@3.
	terniLapilli putXAt: 2@3.
	terniLapilli putOAt: 3@1.
	
	self should: [terniLapilli moveXFrom: 1@1 to: 2@2 ] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantPlayWhenGameIsOver].

	

	
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'FG 10/31/2020 19:55:56'!
test38PlayerOCantMoveAPieceWhenGameIsOver

	| terniLapilli |

	terniLapilli := TerniLapilli newGame.
	terniLapilli putXAt: 1@1.
	terniLapilli putOAt: 3@2.
	terniLapilli putXAt: 2@2.
	terniLapilli putOAt: 1@2.
	terniLapilli putXAt: 2@3.
	terniLapilli putOAt: 3@1.
	terniLapilli moveXFrom: 2@3 to: 3@3.
	
	self should: [terniLapilli moveOFrom: 1@2  to:1@3] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TerniLapilli cantPlayWhenGameIsOver].

	

	
	
	! !


!classDefinition: #Player category: #'Terni Lapilli'!
Object subclass: #Player
	instanceVariableNames: 'piecesOnBoard playing winning'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!Player methodsFor: 'accessing' stamp: 'FG 11/1/2020 14:04:03'!
hadPieceIn: aPosition
	^ piecesOnBoard includes: aPosition.! !

!Player methodsFor: 'accessing' stamp: 'FG 11/1/2020 12:35:49'!
hadWon 
	^ winning! !

!Player methodsFor: 'accessing' stamp: 'FG 11/1/2020 16:46:33'!
isPlaying
	^ self subclassResponsibility.! !

!Player methodsFor: 'accessing' stamp: 'FG 11/1/2020 11:43:13'!
pieces
	^ piecesOnBoard! !


!Player methodsFor: 'initialization' stamp: 'FG 11/1/2020 16:41:10'!
starting
	piecesOnBoard := Set new.
	winning := false.
	playing := XTurn new.! !


!Player methodsFor: 'action' stamp: 'FG 11/1/2020 12:40:03'!
checkIfWonWith: winningCombinations
	^ winning := (winningCombinations includes: piecesOnBoard). ! !

!Player methodsFor: 'action' stamp: 'FG 11/1/2020 14:13:24'!
movePieceFrom: originPosition to: destinationPosition
	piecesOnBoard remove: originPosition.
	piecesOnBoard add: destinationPosition.! !

!Player methodsFor: 'action' stamp: 'FG 11/1/2020 16:29:26'!
passTurn
	playing := playing passTurn.! !

!Player methodsFor: 'action' stamp: 'FG 11/1/2020 13:37:45'!
putPieceIn: aPosition
	piecesOnBoard add: aPosition.! !


!Player methodsFor: 'error checking' stamp: 'FG 11/1/2020 15:18:54'!
checkThatIHaveLessThanThreePieces
	(piecesOnBoard size < 3) ifFalse: [self error: TerniLapilli cantPutPieceIfThereIsThreePiecesOnBoard ]. ! !

!Player methodsFor: 'error checking' stamp: 'FG 11/1/2020 15:19:13'!
checkThatIHaveThreePieces
	(piecesOnBoard size = 3) ifFalse:[self error: TerniLapilli cantMovePieceBeforeHavingThreePiecesOnTheBoard ].! !

!Player methodsFor: 'error checking' stamp: 'FG 11/1/2020 16:48:42'!
checkThatIsMyTurn
	self subclassResponsibility.! !


!classDefinition: #PlayerO category: #'Terni Lapilli'!
Player subclass: #PlayerO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!PlayerO methodsFor: 'as yet unclassified' stamp: 'FG 11/1/2020 16:44:22'!
checkThatIsMyTurn
	playing checkIfOTurn.! !

!PlayerO methodsFor: 'as yet unclassified' stamp: 'FG 11/1/2020 16:46:40'!
isPlaying
	^ playing isPlayingO.! !


!classDefinition: #PlayerX category: #'Terni Lapilli'!
Player subclass: #PlayerX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!PlayerX methodsFor: 'as yet unclassified' stamp: 'FG 11/1/2020 16:44:31'!
checkThatIsMyTurn
	playing checkIfXTurn.! !

!PlayerX methodsFor: 'as yet unclassified' stamp: 'FG 11/1/2020 16:46:47'!
isPlaying
	^ playing isPlayingX.! !


!classDefinition: #TerniLapilli category: #'Terni Lapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'playerX playerO gameEnded winningCombinations'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilli methodsFor: 'initialization' stamp: 'FG 11/1/2020 17:03:57'!
createCombinationsForEachColumn

	|boardLines combinationsForEachColumn|
	
	boardLines := 	#(1 2 3).
	
	boardLines do:[ :column |
		     combinationsForEachColumn := Set new. 
		     boardLines do: [:row | combinationsForEachColumn add: row@column].
		     winningCombinations add: combinationsForEachColumn.
		].
	
	^ combinationsForEachColumn.
	
	
	
	! !

!TerniLapilli methodsFor: 'initialization' stamp: 'FG 11/1/2020 14:54:13'!
createCombinationsForEachRow	
	
	|boardLines combinationsForEachRow|
	
	boardLines := 	#(1 2 3).
	
	boardLines do:[ :row |
		     combinationsForEachRow := Set new. 
		     boardLines do: [:column | combinationsForEachRow add: row@column].
		     winningCombinations add: combinationsForEachRow.
		].
	
	^ combinationsForEachRow.
	
	
	
	! !

!TerniLapilli methodsFor: 'initialization' stamp: 'FG 11/1/2020 15:00:50'!
createWinningCombinations

	winningCombinations := Set new.
	
	winningCombinations add: self createCombinationsForEachRow.
	winningCombinations add: self createCombinationsForEachColumn. 
	
	winningCombinations add: (Set with: 1@1 with: 2@2 with: 3@3).
	winningCombinations add: (Set with: 1@3 with: 2@2 with: 3@1).
	
	
	
	! !

!TerniLapilli methodsFor: 'initialization' stamp: 'FG 11/1/2020 16:58:51'!
initializeGame

	gameEnded  := false.
	playerX := PlayerX new starting.
	playerO := PlayerO new starting.
       self createWinningCombinations.! !


!TerniLapilli methodsFor: 'error check' stamp: 'FG 11/1/2020 17:09:23'!
checkIf: destinationPosition isNotOneOfThe4NeighborsOf: originPosition	
	
	^ (originPosition fourNeighbors includes: destinationPosition) not ! !

!TerniLapilli methodsFor: 'error check' stamp: 'FG 11/1/2020 17:14:25'!
checkIfMovementRulesAreRespectedByMovingFrom: originPosition to: destinationPosition.

	( (self checkIf: destinationPosition  isNotOneOfThe4NeighborsOf: originPosition) and: [self checkThatCenterPositionIsNot: destinationPosition Or: originPosition]) 
			ifTrue: [self error: 	TerniLapilli cantBreakMovementRules].! !

!TerniLapilli methodsFor: 'error check' stamp: 'FG 11/1/2020 16:09:11'!
checkIfValidPosition: aPosition
	(aPosition isIntegerPoint and: [aPosition between: 1@1 and: 3@3]) 
		ifFalse: [self error: TerniLapilli cantMovePIeceToAnInvalidPosition].! !

!TerniLapilli methodsFor: 'error check' stamp: 'FG 11/1/2020 17:12:24'!
checkThatCenterPositionIsNot: originPosition Or: destinationPosition

	^ ((originPosition = (2@2)) or: [destinationPosition  = (2@2)]) not 
! !

!TerniLapilli methodsFor: 'error check' stamp: 'FG 11/1/2020 13:31:54'!
checkThatGameIsNotOver
	gameEnded ifTrue:[self error: TerniLapilli cantPlayWhenGameIsOver]. ! !

!TerniLapilli methodsFor: 'error check' stamp: 'FG 11/1/2020 16:10:39'!
checkThatImNotStackingPiecesIn: aPosition 
	((playerX pieces union: playerO pieces) includes: aPosition) ifTrue: [self error: TerniLapilli cantStackPieces].
	
	! !

!TerniLapilli methodsFor: 'error check' stamp: 'FG 11/1/2020 15:26:49'!
checkThatPlayer: aPlayer isNotBreakingAnyRulesWhileMovingAPieceFrom: originPosition to: destinationPosition

	aPlayer checkThatIHaveThreePieces.
	(aPlayer hadPieceIn: originPosition) ifFalse: [self error: TerniLapilli cantMoveAPieceYouDontHave].
	self checkIfMovementRulesAreRespectedByMovingFrom: originPosition to: destinationPosition.! !

!TerniLapilli methodsFor: 'error check' stamp: 'FG 11/1/2020 14:24:47'!
checkThatPlayer: aPlayer isNotBreakingAnyRulesWhileMovingOrPutingAPieceInto: aPosition

	self checkIfValidPosition: aPosition.
	self checkThatImNotStackingPiecesIn: aPosition.
	self checkThatGameIsNotOver.
	aPlayer checkThatIsMyTurn.! !


!TerniLapilli methodsFor: 'testing' stamp: 'FG 11/1/2020 13:43:34'!
hasPlayerOWon
	 ^ playerO hadWon.! !

!TerniLapilli methodsFor: 'testing' stamp: 'FG 11/1/2020 13:43:25'!
hasPlayerXWon
	^ playerX hadWon.! !

!TerniLapilli methodsFor: 'testing' stamp: 'FG 10/29/2020 20:25:50'!
isOver
	 ^ gameEnded.! !

!TerniLapilli methodsFor: 'testing' stamp: 'FG 11/1/2020 13:45:52'!
isPlayingO
	^ playerO isPlaying.! !

!TerniLapilli methodsFor: 'testing' stamp: 'FG 11/1/2020 13:46:05'!
isPlayingX
	^ playerX isPlaying.! !

!TerniLapilli methodsFor: 'testing' stamp: 'FG 11/1/2020 14:04:52'!
ocupiedByO: aPosition 
	^ playerO hadPieceIn: aPosition.! !

!TerniLapilli methodsFor: 'testing' stamp: 'FG 11/1/2020 14:04:30'!
ocupiedByX: aPosition 
	^ playerX hadPieceIn: aPosition.! !


!TerniLapilli methodsFor: 'action' stamp: 'FG 11/1/2020 15:47:14'!
moveFrom: originPosition to: destinationPosition by: aPlayer

	self checkThatPlayer: aPlayer isNotBreakingAnyRulesWhileMovingOrPutingAPieceInto: destinationPosition.
	self checkThatPlayer: aPlayer isNotBreakingAnyRulesWhileMovingAPieceFrom: originPosition  to: destinationPosition. 
	
	aPlayer movePieceFrom: originPosition to: destinationPosition. 
	self passTurn.
	gameEnded := aPlayer checkIfWonWith: winningCombinations.! !

!TerniLapilli methodsFor: 'action' stamp: 'FG 11/1/2020 15:48:07'!
moveOFrom: originPosition to: destinationPosition 

	self moveFrom: originPosition to: destinationPosition by: playerO. ! !

!TerniLapilli methodsFor: 'action' stamp: 'FG 11/1/2020 15:48:20'!
moveXFrom: originPosition to: destinationPosition

	self moveFrom: originPosition to: destinationPosition by: playerX. ! !

!TerniLapilli methodsFor: 'action' stamp: 'FG 11/1/2020 14:27:43'!
passTurn
	playerX passTurn.
	playerO passTurn.
	! !

!TerniLapilli methodsFor: 'action' stamp: 'FG 11/1/2020 15:49:15'!
putAt: aPosition by: aPlayer

	self checkThatPlayer: aPlayer isNotBreakingAnyRulesWhileMovingOrPutingAPieceInto: aPosition. 
	aPlayer checkThatIHaveLessThanThreePieces.
	
	aPlayer putPieceIn: aPosition.
	self passTurn.
	gameEnded := aPlayer checkIfWonWith: winningCombinations.! !

!TerniLapilli methodsFor: 'action' stamp: 'FG 11/1/2020 15:49:54'!
putOAt: aPosition 

	self putAt: aPosition by: playerO. ! !

!TerniLapilli methodsFor: 'action' stamp: 'FG 11/1/2020 15:50:19'!
putXAt: aPosition

	self putAt: aPosition by: playerX. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'Terni Lapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error text' stamp: 'FG 11/1/2020 15:27:29'!
cantBreakMovementRules
	 ^ 'Error - You are performing a movement against the rules'.! !

!TerniLapilli class methodsFor: 'error text' stamp: 'FG 11/1/2020 15:26:23'!
cantMoveAPieceYouDontHave
	^'Error - Can not move piece because you dont have it'.! !

!TerniLapilli class methodsFor: 'error text' stamp: 'FG 11/1/2020 15:21:24'!
cantMovePIeceToAnInvalidPosition
	^ 'Error - Can not put piece in this position'! !

!TerniLapilli class methodsFor: 'error text' stamp: 'FG 11/1/2020 15:15:45'!
cantMovePieceBeforeHavingThreePiecesOnTheBoard
	^ 'Error - Can not move pieces before having three pieces on the board'! !

!TerniLapilli class methodsFor: 'error text' stamp: 'FG 11/1/2020 15:16:49'!
cantPlayIfItsNotMyTurn
	^ 'Error - You are trying to play in another player turn'! !

!TerniLapilli class methodsFor: 'error text' stamp: 'FG 10/31/2020 18:12:36'!
cantPlayWhenGameIsOver
	^ 'Error - You cant play when the game is already over'! !

!TerniLapilli class methodsFor: 'error text' stamp: 'FG 11/1/2020 15:14:26'!
cantPutPieceIfThereIsThreePiecesOnBoard
	^ 'Error - Can not put more pieces in the board'! !

!TerniLapilli class methodsFor: 'error text' stamp: 'FG 11/1/2020 15:23:00'!
cantStackPieces
	^ 'Error - Piece already in this position'! !


!TerniLapilli class methodsFor: 'initialization' stamp: 'FG 10/29/2020 18:30:19'!
newGame
	^ self basicNew initializeGame! !


!classDefinition: #Turn category: #'Terni Lapilli'!
Object subclass: #Turn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!


!classDefinition: #OTurn category: #'Terni Lapilli'!
Turn subclass: #OTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!OTurn methodsFor: 'error checking' stamp: 'FG 11/1/2020 16:42:26'!
checkIfOTurn! !

!OTurn methodsFor: 'error checking' stamp: 'FG 11/1/2020 16:42:12'!
checkIfXTurn
	self error: TerniLapilli cantPlayIfItsNotMyTurn.! !


!OTurn methodsFor: 'accessing' stamp: 'FG 11/1/2020 16:47:09'!
isPlayingO
	^ true.! !

!OTurn methodsFor: 'accessing' stamp: 'FG 11/1/2020 16:47:03'!
isPlayingX
	^ false.! !


!OTurn methodsFor: 'action' stamp: 'FG 11/1/2020 16:30:22'!
passTurn 
	^ XTurn new.! !


!classDefinition: #XTurn category: #'Terni Lapilli'!
Turn subclass: #XTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!XTurn methodsFor: 'error checking' stamp: 'FG 11/1/2020 16:43:17'!
checkIfOTurn
	self error: TerniLapilli cantPlayIfItsNotMyTurn.! !

!XTurn methodsFor: 'error checking' stamp: 'FG 11/1/2020 16:43:27'!
checkIfXTurn! !


!XTurn methodsFor: 'action' stamp: 'FG 11/1/2020 16:30:37'!
passTurn
	^ OTurn new.! !


!XTurn methodsFor: 'accessing' stamp: 'FG 11/1/2020 16:47:55'!
isPlayingO
	^false.
	! !

!XTurn methodsFor: 'accessing' stamp: 'FG 11/1/2020 16:47:48'!
isPlayingX
	^true.
	! !
