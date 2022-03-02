!classDefinition: #TerniLapilliGameTest category: 'Terni Lapilli'!
TestCase subclass: #TerniLapilliGameTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliGameTest methodsFor: 'put tokens phase' stamp: 'IO 11/1/2020 20:38:32'!
test01XCanPutAPiece
	"x pone en 0@0"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame putXAt: 0@0.

	self assert: (aGame hasXAt: (0@0)).
! !

!TerniLapilliGameTest methodsFor: 'put tokens phase' stamp: 'IO 11/1/2020 18:23:30'!
test02puttingDoesNotAffectOtherPositions
	"x pone en 0@0 pero no en 0@1"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame putXAt: 0@0.

	self deny: (aGame hasXAt: 0@1).
! !

!TerniLapilliGameTest methodsFor: 'put tokens phase' stamp: 'IO 11/1/2020 18:23:30'!
test03XCanPutInOtherPositions
	"x pone en 0@1"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame putXAt: 0@1.

	self assert: (aGame hasXAt: 0@1).
! !

!TerniLapilliGameTest methodsFor: 'put tokens phase' stamp: 'IO 11/1/2020 18:23:30'!
test04OCanPut
	"o pone en 0@0"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame putXAt: 0@1.
	aGame putOAt: 0@0.

	self assert: (aGame hasOAt: (0@0)).
! !


!TerniLapilliGameTest methodsFor: 'move tokens phase' stamp: 'IO 11/1/2020 18:23:16'!
test05XCanMove
	"movimiento legal desp de haber jugado las tres fichas :D"
	| aGame |
	aGame := self createGameInMovePhase.
	
	aGame moveXFrom: (2@0) to: (1@0).

	self assert: (aGame hasXAt: (1@0)).
! !

!TerniLapilliGameTest methodsFor: 'move tokens phase' stamp: 'IO 11/1/2020 18:23:16'!
test06OCanMove
	"movimiento legal de O desp de haber jugado las tres fichas :D"
	| aGame |
	aGame := self createGameInMovePhase.
	
	aGame moveXFrom: (2@0) to: (1@0).
	aGame moveOFrom: (2@1) to: (1@1).

	self assert: (aGame hasOAt: (1@1)).
! !


!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'IO 11/1/2020 20:17:40'!
test07XWinsWithTheFirstColumn
	"primer posicion ganadora para X, la primer columna"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame putXAt: 0@0.
	aGame putOAt: 0@1.
	aGame putXAt: 1@0.
	aGame putOAt: 1@1.
	aGame putXAt: 2@0.
	
	self assert: aGame hasXPlayerWon.
! !

!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'IO 11/1/2020 20:17:40'!
test08XHasntWonYet
	"X todavia no gano"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame putXAt: 0@0.
	aGame putOAt: 0@1.
	aGame putXAt: 1@0.
	aGame putOAt: 1@1.
	aGame putXAt: 2@2.
	
	self deny: aGame hasXPlayerWon.
! !

!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'IO 11/1/2020 20:17:40'!
test09XWinsWithTheSecondColumn
	"X gana competando la segunda columna"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame putXAt: 0@1.
	aGame putOAt: 0@2.
	aGame putXAt: 1@1.
	aGame putOAt: 1@2.
	aGame putXAt: 2@1.
	
	self assert: aGame hasXPlayerWon.
! !

!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'IO 11/1/2020 20:17:40'!
test10XWinsWithTheThirdColumn
	"ahora X gana competando la tercer columna"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame putXAt: 0@2.
	aGame putOAt: 0@0.
	aGame putXAt: 1@2.
	aGame putOAt: 1@0.
	aGame putXAt: 2@2.
	
	self assert: aGame hasXPlayerWon.
! !

!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'IO 11/1/2020 20:17:40'!
test11XWinsWithTheFirstRow
	"X gana completando la primer fila"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame putXAt: 0@0.
	aGame putOAt: 1@0.
	aGame putXAt: 0@1.
	aGame putOAt: 1@1.
	aGame putXAt: 0@2.
	
	self assert: aGame hasXPlayerWon.
! !

!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'IO 11/1/2020 20:17:40'!
test12XWinsWithTheSecondRow
	"X gana competando la segunda fila"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame putXAt: 1@0.
	aGame putOAt: 2@0.
	aGame putXAt: 1@1.
	aGame putOAt: 2@1.
	aGame putXAt: 1@2.
	
	self assert: aGame hasXPlayerWon.
! !

!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'IO 11/1/2020 20:17:40'!
test13XWinsWithTheThirdRow
	"X gana competando la tercer fila"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame putXAt: 2@0.
	aGame putOAt: 0@0.
	aGame putXAt: 2@1.
	aGame putOAt: 0@1.
	aGame putXAt: 2@2.
	
	self assert: aGame hasXPlayerWon.
! !

!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'IO 11/1/2020 20:17:40'!
test14XWinsWithTheCrescentDiagonal
	"X gana competando la diagonal creciente"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame putXAt: 0@0.
	aGame putOAt: 1@0.
	aGame putXAt: 1@1.
	aGame putOAt: 2@1.
	aGame putXAt: 2@2.
	
	self assert: aGame hasXPlayerWon.
! !

!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'IO 11/1/2020 20:17:40'!
test15XWinsWithTheDescendantDiagonal
	"X gana competando la diagonal decreciente"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame putXAt: 2@0.
	aGame putOAt: 1@0.
	aGame putXAt: 1@1.
	aGame putOAt: 2@1.
	aGame putXAt: 0@2.
	
	self assert: aGame hasXPlayerWon.
! !

!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'IO 11/1/2020 20:16:56'!
test16OWnis
	"ahora gana O!!"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame putXAt: 0@0.
	aGame putOAt: 0@1.
	aGame putXAt: 2@0.
	aGame putOAt: 1@1.
	aGame putXAt: 2@2.
	aGame putOAt: 2@1.
	
	self assert: aGame hasOPlayerWon.
! !


!TerniLapilliGameTest methodsFor: 'ilegal turns' stamp: 'IO 11/1/2020 18:23:00'!
test17OCantStartPutting
	"empieza poniendo X"
	| aGame |
	aGame := TerniLapilliGame new.
	
	self should: [aGame putOAt: (0@0)] raise: Error withMessageText: TerniLapilliGame wrongTurnErrorMessage.


! !

!TerniLapilliGameTest methodsFor: 'ilegal turns' stamp: 'IO 11/1/2020 18:23:30'!
test18XCantPutTwiceInARow
	"despues de X pone Y"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame putXAt: (0@0).
	self should: [aGame putXAt: (0@1)] raise: Error withMessageText: TerniLapilliGame wrongTurnErrorMessage.


! !

!TerniLapilliGameTest methodsFor: 'ilegal turns' stamp: 'IO 11/1/2020 18:23:16'!
test19XCantMoveTwiceInARow
	"x no puede mover dos veces seguidas"
	| aGame |
	aGame := self createGameInMovePhase.
	
	aGame moveXFrom: (2@0) to: (1@0).
	self should: [aGame moveXFrom: (1@0) to: (2@0).] raise: Error withMessageText: TerniLapilliGame wrongTurnErrorMessage.
! !

!TerniLapilliGameTest methodsFor: 'ilegal turns' stamp: 'IO 11/1/2020 18:23:30'!
test20OCantPutTwiceInARow
	"despues de X pone Y"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame putXAt: (0@0).	aGame putOAt:(0@1).

	self should: [aGame putOAt: (0@2)] raise: Error withMessageText: TerniLapilliGame wrongTurnErrorMessage.


! !

!TerniLapilliGameTest methodsFor: 'ilegal turns' stamp: 'IO 11/1/2020 18:23:16'!
test21OCantMoveTwiceInARow
	"x no puede mover dos veces seguidas"
	| aGame |
	aGame := self createGameInMovePhase.
	
	aGame moveXFrom: (2@0) to: (1@0).	aGame moveOFrom: (2@1) to: (1@1).

	self should: [aGame moveOFrom: (1@1) to: (2@1).] raise: Error withMessageText: TerniLapilliGame wrongTurnErrorMessage.
! !


!TerniLapilliGameTest methodsFor: 'utilities' stamp: 'IO 11/1/2020 18:23:30'!
createGameInMovePhase
	"revisar este metodo al usuarlo para usarlo correctamente en los tests ;)"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame putXAt: 0@1.
	aGame putOAt: 0@2.
	aGame putXAt: 1@2.
	aGame putOAt: 2@1.
	aGame putXAt: 2@0.
	aGame putOAt: 2@2.
	
	^aGame
! !


!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'IO 11/1/2020 18:23:16'!
test22XCantMoveOnTheirFirstTurn
	"x no puede mover en su primer turno"
	| aGame |
	aGame := TerniLapilliGame new.
	
	self should: [aGame moveXFrom: (0@0) to: (1@0).] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage.

	! !

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'IO 11/1/2020 18:23:30'!
test23XCantMoveOnTheirSecondTurn
	"x no puede mover en su segundo turno"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame putXAt: 0@0.
	aGame putOAt: 0@1.

	self should: [aGame moveXFrom: (0@0) to: (1@0).] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage.

	! !

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'IO 11/1/2020 18:23:30'!
test24XCantMoveOnTheirThirdTurn
	"x no puede mover en su tercer turno"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame putXAt: 0@0.
	aGame putOAt: 0@1.
	aGame putXAt: 1@0.
	aGame putOAt: 0@2.

	self should: [aGame moveXFrom: (1@0) to: (2@0).] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage.
! !

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'IO 11/1/2020 18:23:30'!
test25OCantMoveOnTheirFirstTurn
	"o no puede mover en su primer turno"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame putXAt: 0@0.

	self should: [aGame moveOFrom: (0@0) to: (1@0).] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage.

	! !

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'IO 11/1/2020 19:08:21'!
test26OCantMoveOnTheirSecondTurn
	"o no puede mover en su segundo turno"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame putXAt: 0@0.
	aGame putOAt: 0@2.
	aGame putXAt: 1@0.

	self should: [aGame moveOFrom: (0@0) to: (0@1).] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage.

	! !

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'IO 11/1/2020 19:08:45'!
test27OCantMoveOnTheirThirdTurn
	"o no puede mover en su tercer turno"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame putXAt: 0@0.
	aGame putOAt: 0@1.
	aGame putXAt: 2@0.
	aGame putOAt: 2@2.
	aGame putXAt: 2@1.

	self should: [aGame moveOFrom: (0@0) to: (1@0).] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage.

	! !

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'IO 11/1/2020 18:23:30'!
test28XCantPutAfterTheirThirdTurn
	"x no puedo poner despues de su tercer turno"
	| aGame |
	aGame := self createGameInMovePhase.
	
	self should: [aGame putXAt: (1@1).] raise: Error withMessageText: TerniLapilliGame cannotPutErrorMessage.

	! !

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'IO 11/1/2020 18:23:16'!
test29OCantPutAfterTheirThirdTurn
	"o no puede poner despues de su tercer turno"
	| aGame |
	aGame := self createGameInMovePhase.

	aGame moveXFrom: (0@1) to: (1@1).
	
	self should: [aGame putOAt: (0@1).] raise: Error withMessageText: TerniLapilliGame cannotPutErrorMessage.

	! !

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'IO 11/1/2020 20:29:10'!
test30OCantPutAfterXWon
	"O no puede poner despues de que X gano"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame putXAt: 0@1.
	aGame putOAt: 0@2.
	aGame putXAt: 1@1.
	aGame putOAt: 1@2.
	aGame putXAt: 2@1.
	
	self should: [aGame putOAt: (2@2).] raise: Error withMessageText: TerniLapilliGame gameOverErrorMessage.
! !

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'IO 11/1/2020 20:29:10'!
test31OCantMoveAfterXWon
	"O no puede mover despues de que X gano"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame putXAt: 0@0.
	aGame putOAt: 1@0.
	aGame putXAt: 1@1.
	aGame putOAt: 2@1.
	aGame putXAt: 0@2.
	aGame putOAt: 2@2.
	
	aGame moveXFrom: (1@1) to: (0@1).
	
	self should: [aGame moveOFrom: (2@2) to: (1@2)] raise: Error withMessageText: TerniLapilliGame gameOverErrorMessage.
! !

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'IO 11/1/2020 20:29:10'!
test32XCantMoveAfterOWon
	"X no puede mover despues de que O gano"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame putXAt: 0@0.
	aGame putOAt: 2@0.
	aGame putXAt: 1@1.
	aGame putOAt: 2@1.
	aGame putXAt: 0@2.
	aGame putOAt: 2@2.

	self should: [aGame moveXFrom: (1@1) to: (0@1).] raise: Error withMessageText: TerniLapilliGame gameOverErrorMessage.
! !

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'IO 11/1/2020 20:29:10'!
test33XCantPutAfterOWon
	"X no puede poner despues de que O gano"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame putXAt: 0@0.
	aGame putOAt: 2@0.
	aGame putXAt: 1@1.
	aGame putOAt: 2@1.
	aGame putXAt: 0@2.
	aGame putOAt: 2@2.

	self should: [aGame putXAt: (0@1).] raise: Error withMessageText: TerniLapilliGame gameOverErrorMessage.
! !


!TerniLapilliGameTest methodsFor: 'ilegal positions' stamp: 'IO 11/1/2020 18:59:48'!
test34XCantPutInAnOccupiedSpace
	"X no puede poner en un lugar ocupado"
	

	| aGame |
	
	aGame := TerniLapilliGame new.
	
	aGame putXAt: 0@0.
	aGame putOAt: 2@0.

	self should: [	aGame putXAt: 0@0.] raise: Error withMessageText: TerniLapilliGame occupiedPositionErrorMessage.
	self should: [	aGame putXAt: 2@0.] raise: Error withMessageText: TerniLapilliGame occupiedPositionErrorMessage.
! !

!TerniLapilliGameTest methodsFor: 'ilegal positions' stamp: 'IO 11/1/2020 19:00:01'!
test35OCantPutInAnOccupiedSpace
	"O no puede poner en un lugar ocupado"
	

	| aGame |
	
	aGame := TerniLapilliGame new.
	
	aGame putXAt: 0@0.
	aGame putOAt: 0@1.
	aGame putXAt: 0@2.

	self should: [	aGame putOAt: 0@0.] raise: Error withMessageText: TerniLapilliGame occupiedPositionErrorMessage .
	self should: [	aGame putOAt: 0@1.] raise: Error withMessageText: TerniLapilliGame occupiedPositionErrorMessage .
! !

!TerniLapilliGameTest methodsFor: 'ilegal positions' stamp: 'IO 11/1/2020 19:00:13'!
test36XCantMoveToAnOccupiedSpace
	"X no puede mover en un lugar ocupado"
	

	| aGame |
	
	aGame := self createGameInMovePhase .
	
	self should: [	aGame moveXFrom: 1@2 to: 2@1.] raise: Error withMessageText: TerniLapilliGame occupiedPositionErrorMessage .
! !

!TerniLapilliGameTest methodsFor: 'ilegal positions' stamp: 'IO 11/1/2020 19:00:50'!
test37OCantMoveToAnOccupiedSpace
	"O no puede mover en un lugar ocupado"
	

	| aGame |
	
	aGame := self createGameInMovePhase .
	aGame moveXFrom: 0@1 to: 0@0.
	
	self should: [	aGame moveOFrom: 2@1 to: 1@2.] raise: Error withMessageText: TerniLapilliGame occupiedPositionErrorMessage.
! !

!TerniLapilliGameTest methodsFor: 'ilegal positions' stamp: 'IO 11/1/2020 19:00:57'!
test38XCantPutOutsideTheBoardUnderXAxis
	"X no puede poner afuera del tablero por x, por abajo"
	

	| aGame |
	
	aGame := TerniLapilliGame new.
	
	self should: [	aGame putXAt: -1@1.] raise: Error withMessageText: TerniLapilliGame invalidPositionErrorMessage .
! !

!TerniLapilliGameTest methodsFor: 'ilegal positions' stamp: 'IO 11/1/2020 19:01:05'!
test39XCantPutOutsideTheBoardAboveXAxis
	"X no puede poner afuera del tablero por x, por arriba"
	

	| aGame |
	
	aGame := TerniLapilliGame new.
	
	self should: [	aGame putXAt: 3@1.] raise: Error withMessageText: TerniLapilliGame invalidPositionErrorMessage .
! !

!TerniLapilliGameTest methodsFor: 'ilegal positions' stamp: 'IO 11/1/2020 19:01:09'!
test40XCantPutOutsideTheBoardUnderNorAboveTheYAxis
	"X no puede poner afuera del tablero por y"
	

	| aGame |
	
	aGame := TerniLapilliGame new.
	
	self should: [	aGame putXAt: 1@-1.] raise: Error withMessageText: TerniLapilliGame invalidPositionErrorMessage .
	self should: [	aGame putXAt: 1@3.] raise: Error withMessageText: TerniLapilliGame invalidPositionErrorMessage .
! !

!TerniLapilliGameTest methodsFor: 'ilegal positions' stamp: 'IO 11/1/2020 18:51:45'!
test41OCantPutOutsideTheBoard
	"O no puede mover hacía afuera del tablero"
	

	| aGame |

	aGame := TerniLapilliGame new.
	aGame putXAt: 0@0.
	
	self should: [	aGame putOAt: 0@3.] raise: Error withMessageText: TerniLapilliGame invalidPositionErrorMessage. 
	self should: [	aGame putOAt: 0@-1.] raise: Error withMessageText: TerniLapilliGame invalidPositionErrorMessage. 
	self should: [	aGame putOAt: 3@0.] raise: Error withMessageText: TerniLapilliGame invalidPositionErrorMessage. 
	self should: [	aGame putOAt: -1@0.] raise: Error withMessageText: TerniLapilliGame invalidPositionErrorMessage. 
! !

!TerniLapilliGameTest methodsFor: 'ilegal positions' stamp: 'IO 11/1/2020 19:24:22'!
test42XCantMoveToOutsideTheBoard
	"X no puede mover hacía afuera del tablero"
	

	| aGame |
	
	aGame := TerniLapilliGame new.
	
	aGame putXAt: 0@0.
	aGame putOAt: 1@1.	
	aGame putXAt: 2@2.
	aGame putOAt: 2@1.
	aGame putXAt: 1@2.
	aGame putOAt: 0@2.

	self should: [	aGame moveXFrom: 0@0 to: -1@0.] raise: Error withMessageText: TerniLapilliGame invalidPositionErrorMessage . 
	self should: [	aGame moveXFrom: 2@2 to: 3@2.] raise: Error withMessageText: TerniLapilliGame invalidPositionErrorMessage . 
	self should: [	aGame moveXFrom: 0@0 to: 1@-1.] raise: Error withMessageText: TerniLapilliGame invalidPositionErrorMessage . 
	self should: [	aGame moveXFrom: 2@2 to: 2@3.] raise: Error withMessageText: TerniLapilliGame invalidPositionErrorMessage . 
! !

!TerniLapilliGameTest methodsFor: 'ilegal positions' stamp: 'IO 11/1/2020 19:24:11'!
test43OCantMoveToOutsideTheBoard
	"O no puede mover hacía afuera del tablero"
	

	| aGame |
	
	aGame := TerniLapilliGame new.

	aGame putXAt: 0@2.
	aGame putOAt: 0@0.
	aGame putXAt: 1@1.	
	aGame putOAt: 2@2.
	aGame putXAt: 2@1.
	aGame putOAt: 1@2.
	aGame moveXFrom: 1@1 to: 0@1.

	self should: [	aGame moveOFrom: 0@0 to: -1@0.] raise: Error withMessageText: TerniLapilliGame invalidPositionErrorMessage . 
	self should: [	aGame moveOFrom: 2@2 to: 3@2.] raise: Error withMessageText: TerniLapilliGame invalidPositionErrorMessage . 
	self should: [	aGame moveOFrom: 0@0 to: 1@-1.] raise: Error withMessageText: TerniLapilliGame invalidPositionErrorMessage . 
	self should: [	aGame moveOFrom: 2@2 to: 2@3.] raise: Error withMessageText: TerniLapilliGame invalidPositionErrorMessage . 

! !

!TerniLapilliGameTest methodsFor: 'ilegal positions' stamp: 'IO 11/1/2020 20:39:10'!
test44XCantMovePiecesThatDontBelongToThem
	"X no puede mover fichas que no sea suyas"
	

	| aGame |

	aGame := self createGameInMovePhase .
	
	self should: [	aGame moveXFrom: 0@2 to: 1@1.] raise: Error withMessageText: TerniLapilliGame noTokenAtPositionErrorMessage.
	self should: [	aGame moveXFrom: 3@2 to: 1@1.] raise: Error withMessageText: TerniLapilliGame noTokenAtPositionErrorMessage.! !

!TerniLapilliGameTest methodsFor: 'ilegal positions' stamp: 'IO 11/1/2020 20:39:15'!
test45OCantMovePiecesThatDontBelongToThem
	"O no puede mover fichas que no sea suyas"
	

	| aGame |

	aGame := self createGameInMovePhase .
	aGame moveXFrom: 0@1 to: 1@1.
	
	self should: [	aGame moveOFrom: 1@1 to: 0@1.] raise: Error withMessageText: TerniLapilliGame noTokenAtPositionErrorMessage.
	self should: [	aGame moveOFrom: 3@1 to: 0@1.] raise: Error withMessageText: TerniLapilliGame noTokenAtPositionErrorMessage.! !

!TerniLapilliGameTest methodsFor: 'ilegal positions' stamp: 'IO 11/1/2020 20:41:14'!
test46XCantMoveaPiecesOutsideItsNeighbors
	"X no puede mover fichas hacia más de 1 vecinidad"
	

	| aGame |

	aGame := self createGameInMovePhase .
	
	self should: [	aGame moveXFrom: 2@0 to: 0@0.] raise: Error withMessageText: TerniLapilliGame invalidDestinationErrorMessage.! !

!TerniLapilliGameTest methodsFor: 'ilegal positions' stamp: 'IO 11/1/2020 20:41:20'!
test47OCantMoveAPiecesOutsideItsNeighbors
	"O no puede mover fichas hacia más de 1 vecinidad"
	

	| aGame |

	aGame := self createGameInMovePhase .
	aGame moveXFrom: 0@1 to: 0@0.
	
	self should: [	aGame moveOFrom: 2@1 to: 0@1.] raise: Error withMessageText: TerniLapilliGame invalidDestinationErrorMessage.! !


!classDefinition: #TerniLapilliGame category: 'Terni Lapilli'!
Object subclass: #TerniLapilliGame
	instanceVariableNames: 'state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliGame methodsFor: 'initialization' stamp: 'IO 11/1/2020 16:18:09'!
initialize

	"intialize a new game"

	state := TerniLapilliGameState new.

! !


!TerniLapilliGame methodsFor: 'testing' stamp: 'IO 11/1/2020 20:35:27'!
hasOAt: aPosition

	"returns true if a board position has a piece placed by O player or not"

	^state hasOAt: aPosition.
! !

!TerniLapilliGame methodsFor: 'testing' stamp: 'IO 11/1/2020 20:17:17'!
hasOPlayerWon

	"returns true if O has won or not"

	^state hasOPlayerWon.
! !

!TerniLapilliGame methodsFor: 'testing' stamp: 'IO 11/1/2020 20:35:33'!
hasXAt: aPosition

	"returns true if a board position has a piece placed by O player or not"

	^state hasXAt: aPosition.
! !

!TerniLapilliGame methodsFor: 'testing' stamp: 'IO 11/1/2020 20:18:04'!
hasXPlayerWon

	"returns true if x has won or not"

	^state hasXPlayerWon.
! !

!TerniLapilliGame methodsFor: 'testing' stamp: 'IO 11/1/2020 20:35:50'!
includes: aPosition

	"returns true if a board position has a piece placed or not"

	^(state hasOAt: aPosition) or: (state hasXAt: aPosition).
! !


!TerniLapilliGame methodsFor: 'moves' stamp: 'IO 11/1/2020 20:35:56'!
moveOFrom: aPosition to: aDestination

	"move O's piece from a given position of the board to another given position"

	self validateTargetPosition: aDestination.
	state := state moveOFrom: aPosition to: aDestination.
! !

!TerniLapilliGame methodsFor: 'moves' stamp: 'IO 11/1/2020 20:35:58'!
moveXFrom: aPosition to: aDestination

	"move O's piece from a given position of the board to another given position"

	self validateTargetPosition: aDestination.
	state := state moveXFrom: aPosition to: aDestination.
	
	
! !

!TerniLapilliGame methodsFor: 'moves' stamp: 'IO 11/1/2020 20:36:01'!
putOAt: aPosition

	"put an O piece in a given position of the board"

	self validateTargetPosition: aPosition.
	state := state putOAt: aPosition.
! !

!TerniLapilliGame methodsFor: 'moves' stamp: 'IO 11/1/2020 20:36:04'!
putXAt: aPosition

	"put an O piece in a given position of the board"

	self validateTargetPosition: aPosition.
	state := state putXAt: aPosition.
! !


!TerniLapilliGame methodsFor: 'validation' stamp: 'IO 11/1/2020 19:33:04'!
validateTargetPosition: aPosition

	"put an O token in a given position of the board"

	(self includes: aPosition ) ifTrue: [^self error: TerniLapilliGame occupiedPositionErrorMessage].

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliGame class' category: 'Terni Lapilli'!
TerniLapilliGame class
	instanceVariableNames: ''!

!TerniLapilliGame class methodsFor: 'instance creation' stamp: 'IO 11/1/2020 18:03:54'!
new

	"create a new game"

	^self basicNew initialize.
! !


!TerniLapilliGame class methodsFor: 'error messages' stamp: 'IO 11/1/2020 18:04:04'!
cannotMoveErrorMessage

	^'Cannot move tokens. You need to put 3 tokens first'.
! !

!TerniLapilliGame class methodsFor: 'error messages' stamp: 'IO 11/1/2020 17:16:35'!
cannotPutErrorMessage

	^'Cannot put tokens. You have already put the 3 tokens.'.
! !

!TerniLapilliGame class methodsFor: 'error messages' stamp: 'IO 11/1/2020 20:29:10'!
gameOverErrorMessage

	^'Game over!!'.
! !

!TerniLapilliGame class methodsFor: 'error messages' stamp: 'IO 11/1/2020 19:02:52'!
invalidDestinationErrorMessage

	^'The given destination is not 1 step from the source position'.
! !

!TerniLapilliGame class methodsFor: 'error messages' stamp: 'IO 11/1/2020 18:43:06'!
invalidPositionErrorMessage

	^'The given position is invalid'.
! !

!TerniLapilliGame class methodsFor: 'error messages' stamp: 'IO 11/1/2020 18:58:49'!
noTokenAtPositionErrorMessage

	^'You dont own a token at the given position'.
! !

!TerniLapilliGame class methodsFor: 'error messages' stamp: 'IO 11/1/2020 18:55:31'!
occupiedPositionErrorMessage

	^'The given position is occupied by another token'.
! !

!TerniLapilliGame class methodsFor: 'error messages' stamp: 'IO 11/1/2020 17:17:20'!
wrongTurnErrorMessage

	^'Cannot play now. It is not your turn'.
! !


!classDefinition: #TerniLapilliGameState category: 'Terni Lapilli'!
Object subclass: #TerniLapilliGameState
	instanceVariableNames: 'xPieces oPieces'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliGameState methodsFor: 'moves' stamp: 'IO 11/1/2020 20:36:11'!
moveOFrom: aPositon to: aDestination

	"returns the next state when O moves a piece"

	oPieces moveFrom: aPositon to: aDestination.
	^self passTurn.
! !

!TerniLapilliGameState methodsFor: 'moves' stamp: 'IO 11/1/2020 20:36:14'!
moveXFrom: aPositon to: aDestination

	"returns the next state when X moves a piece"

	xPieces moveFrom: aPositon to: aDestination.
	^self passTurn.
! !

!TerniLapilliGameState methodsFor: 'moves' stamp: 'IO 11/1/2020 17:01:05'!
passTurn

	"
		prepare and return the next state after a turn was played
		implementation details: this is a factory method with different strategies for preparing the next state
	"

	^self subclassResponsibility.
! !

!TerniLapilliGameState methodsFor: 'moves' stamp: 'IO 11/1/2020 20:36:22'!
putOAt: aPosition

	"returns the next state when O puts a piece"

	oPieces put: aPosition.
	^self passTurn.

! !

!TerniLapilliGameState methodsFor: 'moves' stamp: 'IO 11/1/2020 20:36:26'!
putXAt: aPosition

	"returns the next state when X puts a piece"

	xPieces put: aPosition.
	^self passTurn.
! !


!TerniLapilliGameState methodsFor: 'testing' stamp: 'IO 11/1/2020 20:36:32'!
hasOAt: aPosition

	"returns true if the current state has O's piece placed at a given position"

	^oPieces has: aPosition.

! !

!TerniLapilliGameState methodsFor: 'testing' stamp: 'IO 11/1/2020 20:33:20'!
hasOPlayerWon

	"returns true if the current state is in a winning position for O. if true, the state is final"

	^oPieces areInWinningPosition.
! !

!TerniLapilliGameState methodsFor: 'testing' stamp: 'IO 11/1/2020 20:36:41'!
hasXAt: aPosition

	"returns true if the current state has X's piece placed at a given position"

	^xPieces has: aPosition.
! !

!TerniLapilliGameState methodsFor: 'testing' stamp: 'IO 11/1/2020 20:33:14'!
hasXPlayerWon

	"returns true if the current state is in a winning position for X. if true, the state is final"

	^xPieces areInWinningPosition.
! !


!TerniLapilliGameState methodsFor: 'initializtion' stamp: 'IO 11/1/2020 20:47:08'!
initialize

	"intialize the first state"

	xPieces := TerniLapilliPlayerPieces new.
	oPieces := TerniLapilliPlayerPieces new.
! !

!TerniLapilliGameState methodsFor: 'initializtion' stamp: 'IO 11/1/2020 20:36:57'!
intializeWithXPieces: nextXTokens oPieces: nextOTokens.

	"initialize the next state with the given pieces for X and O. this method is used by all the next state factories"

	xPieces := nextXTokens.
	oPieces := nextOTokens.
! !


!TerniLapilliGameState methodsFor: 'error singaling' stamp: 'IO 11/1/2020 16:42:00'!
errorCannotMove

	"signal when a player is trying to move a token when is still ilegal"

	^self error: TerniLapilliGame cannotMoveErrorMessage.
! !

!TerniLapilliGameState methodsFor: 'error singaling' stamp: 'IO 11/1/2020 16:42:41'!
errorCannotPut

	"signal when a player is trying to put a token when they has already put their trhee tokens"

	^self error: TerniLapilliGame cannotPutErrorMessage.
! !

!TerniLapilliGameState methodsFor: 'error singaling' stamp: 'IO 11/1/2020 20:29:10'!
errorGameOver

	"signal when a player is trying to move or put after the game has ended"

	^self error: TerniLapilliGame gameOverErrorMessage.
! !

!TerniLapilliGameState methodsFor: 'error singaling' stamp: 'IO 11/1/2020 16:43:02'!
errorIlegalTurn

	"signal when a player is trying to play when is not their turn"

	^self error: TerniLapilliGame wrongTurnErrorMessage.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliGameState class' category: 'Terni Lapilli'!
TerniLapilliGameState class
	instanceVariableNames: ''!

!TerniLapilliGameState class methodsFor: 'instance creation' stamp: 'IO 11/1/2020 18:33:38'!
new

	"create the initial state of the game"

	^XPuts new initialize.
! !

!TerniLapilliGameState class methodsFor: 'instance creation' stamp: 'IO 11/1/2020 20:43:54'!
nextStateWithXPieces: nextXPieces andOPieces: nextOPieces.

	"create the next state"

	^self subclassResponsibility.
! !


!classDefinition: #GameOver category: 'Terni Lapilli'!
TerniLapilliGameState subclass: #GameOver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!GameOver methodsFor: 'moves' stamp: 'IO 11/1/2020 20:21:09'!
moveOFrom: aPosition to: aDestination

	"see superimplementor"

	^self errorGameOver.
! !

!GameOver methodsFor: 'moves' stamp: 'IO 11/1/2020 20:21:09'!
moveXFrom: aPosition to: aDestination

	"see superimplementor"

	^self errorGameOver.

! !

!GameOver methodsFor: 'moves' stamp: 'IO 11/1/2020 20:21:09'!
putOAt: aPosition

	"see superimplementor"

	^self errorGameOver.
! !

!GameOver methodsFor: 'moves' stamp: 'IO 11/1/2020 20:21:09'!
putXAt: aPosition

	"see superimplementor"

	^self errorGameOver.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameOver class' category: 'Terni Lapilli'!
GameOver class
	instanceVariableNames: ''!

!GameOver class methodsFor: 'instance creation' stamp: 'IO 11/1/2020 20:44:32'!
nextStateWithXPieces: nextXPieces andOPieces: nextOPieces

	"see superimplementor"

	^self basicNew intializeWithXPieces: nextXPieces oPieces: nextOPieces.
! !


!classDefinition: #OTurn category: 'Terni Lapilli'!
TerniLapilliGameState subclass: #OTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!OTurn methodsFor: 'moves' stamp: 'IO 11/1/2020 18:36:14'!
moveXFrom: aPosition to: aDestination

	"see superimplementor"

	self errorIlegalTurn.
! !

!OTurn methodsFor: 'moves' stamp: 'IO 11/1/2020 20:43:12'!
passTurn

	"see superimplementor"

	^XTurn nextStateWithXPieces: xPieces andOPieces: oPieces.
! !

!OTurn methodsFor: 'moves' stamp: 'IO 11/1/2020 18:23:30'!
putXAt: aPosition

	"see superimplementor"

	self errorIlegalTurn.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OTurn class' category: 'Terni Lapilli'!
OTurn class
	instanceVariableNames: ''!

!OTurn class methodsFor: 'instance creation' stamp: 'IO 11/1/2020 21:13:55'!
nextStateWithXPieces: nextXPieces andOPieces: nextOPieces

	"create the next state of O's turn"
	
	(nextXPieces areInWinningPosition) ifTrue: [^GameOver nextStateWithXPieces: nextXPieces andOPieces: nextOPieces].
	(nextOPieces tokensAlreadyPut < 3) ifTrue: [^OPuts nextStateWithXPieces: nextXPieces andOPieces: nextOPieces].
	^OMoves nextStateWithXPieces: nextXPieces andOPieces: nextOPieces.

! !


!classDefinition: #OMoves category: 'Terni Lapilli'!
OTurn subclass: #OMoves
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!OMoves methodsFor: 'moves' stamp: 'IO 11/1/2020 18:23:00'!
putOAt: aPosition

	"see superimplementor"

	^self errorCannotPut.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OMoves class' category: 'Terni Lapilli'!
OMoves class
	instanceVariableNames: ''!

!OMoves class methodsFor: 'instance creation' stamp: 'IO 11/1/2020 20:46:46'!
nextStateWithXPieces: nextXPieces andOPieces: nextOPieces

	"create the next state of O's turn after they has put the 3 pieces"

	^self basicNew intializeWithXPieces: nextXPieces oPieces: nextOPieces.
! !


!classDefinition: #OPuts category: 'Terni Lapilli'!
OTurn subclass: #OPuts
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!OPuts methodsFor: 'moves' stamp: 'IO 11/1/2020 18:36:43'!
moveOFrom: aPosition to: aDestination

	"see superimplementor"

	^self errorCannotMove.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OPuts class' category: 'Terni Lapilli'!
OPuts class
	instanceVariableNames: ''!

!OPuts class methodsFor: 'instance creation' stamp: 'IO 11/1/2020 20:46:42'!
nextStateWithXPieces: nextXPieces andOPieces: nextOPieces

	"create the next state of O's turn before they has put the 3 pieces"

	^self basicNew intializeWithXPieces: nextXPieces oPieces: nextOPieces.
! !


!classDefinition: #XTurn category: 'Terni Lapilli'!
TerniLapilliGameState subclass: #XTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!


!XTurn methodsFor: 'moves' stamp: 'IO 11/1/2020 18:36:51'!
moveOFrom: aPosition to: aDestination

	"see superimplementor"

	self errorIlegalTurn.
! !

!XTurn methodsFor: 'moves' stamp: 'IO 11/1/2020 20:43:12'!
passTurn

	"see superimplementor"

	^OTurn nextStateWithXPieces: xPieces andOPieces: oPieces.
! !

!XTurn methodsFor: 'moves' stamp: 'IO 11/1/2020 18:23:00'!
putOAt: aPosition

	"see superimplementor"

	self errorIlegalTurn.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XTurn class' category: 'Terni Lapilli'!
XTurn class
	instanceVariableNames: ''!

!XTurn class methodsFor: 'instance creation' stamp: 'IO 11/1/2020 17:57:56'!
new

	"create the first state of the game. it is X turn"

	^self basicNew.
! !

!XTurn class methodsFor: 'instance creation' stamp: 'IO 11/1/2020 20:55:09'!
nextStateWithXPieces: nextXPieces andOPieces: nextOPieces

	"create the next state of O's turn"
	
	(nextOPieces areInWinningPosition) ifTrue: [^GameOver nextStateWithXPieces: nextXPieces andOPieces: nextOPieces].
	(nextXPieces tokensAlreadyPut < 3) ifTrue: [^XPuts nextStateWithXPieces: nextXPieces andOPieces: nextOPieces].
	^XMoves nextStateWithXPieces: nextXPieces andOPieces: nextOPieces.
! !


!classDefinition: #XMoves category: 'Terni Lapilli'!
XTurn subclass: #XMoves
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!XMoves methodsFor: 'moves' stamp: 'IO 11/1/2020 18:23:30'!
putXAt: aPosition

	"see superimplementor"

	^self errorCannotPut.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XMoves class' category: 'Terni Lapilli'!
XMoves class
	instanceVariableNames: ''!

!XMoves class methodsFor: 'instance creation' stamp: 'IO 11/1/2020 20:46:33'!
nextStateWithXPieces: nextXPieces andOPieces: nextOPieces

	"create the next state of X's turn after they has put the 3 pieces"

	^self basicNew intializeWithXPieces: nextXPieces oPieces: nextOPieces.! !


!classDefinition: #XPuts category: 'Terni Lapilli'!
XTurn subclass: #XPuts
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!XPuts methodsFor: 'moves' stamp: 'IO 11/1/2020 18:37:13'!
moveXFrom: aPosition to: aDestination

	"see superimplementor"

	^self errorCannotMove.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XPuts class' category: 'Terni Lapilli'!
XPuts class
	instanceVariableNames: ''!

!XPuts class methodsFor: 'instance creation' stamp: 'IO 11/1/2020 20:46:26'!
nextStateWithXPieces: nextXPieces andOPieces: nextOPieces

	"create the next state of O's turn before they has put the 3 pieces"

	^self basicNew intializeWithXPieces: nextXPieces oPieces: nextOPieces.! !


!classDefinition: #TerniLapilliPlayerPieces category: 'Terni Lapilli'!
Object subclass: #TerniLapilliPlayerPieces
	instanceVariableNames: 'tokens'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliPlayerPieces methodsFor: 'moves' stamp: 'IO 11/1/2020 20:37:43'!
moveFrom: aPosition to: aDestination

	"move a piece form a given position of the board to another position"

	self validateMoveFrom: aPosition to: aDestination.

	tokens remove: aPosition.
	tokens add: aDestination.
! !

!TerniLapilliPlayerPieces methodsFor: 'moves' stamp: 'IO 11/1/2020 20:37:45'!
put: aPosition

	"add a piece in a given position of the board"

	self validatePosition: aPosition.

	tokens add: aPosition.
! !


!TerniLapilliPlayerPieces methodsFor: 'testing' stamp: 'IO 11/1/2020 20:37:50'!
areInWinningPosition

	"return true if the pieces are in a winning position"

	^(
		(
			(self areInWinningPositionByColumn: 0) or:
			(self areInWinningPositionByColumn: 1) or:
			(self areInWinningPositionByColumn: 2)
		) or: (
			(self areInWinningPositionByRow: 0) or:
			(self areInWinningPositionByRow: 1) or:
			(self areInWinningPositionByRow: 2)
		) or: (
			self areInWinningPositionByDiagonal
		)
	).
! !

!TerniLapilliPlayerPieces methodsFor: 'testing' stamp: 'IO 11/1/2020 20:37:53'!
areInWinningPositionByColumn: columnNumber

	"return true if the pieces are in a winning position over a given column"

	^(tokens includes: (0@columnNumber)) and: (tokens includes: (1@columnNumber)) and: (tokens includes: (2@columnNumber))! !

!TerniLapilliPlayerPieces methodsFor: 'testing' stamp: 'IO 11/1/2020 20:37:55'!
areInWinningPositionByDiagonal

	"return true if the pieces are in a winning position over a diagonal"

	^(tokens includes: (1@1)) and: (
		((tokens includes: (0@0)) and: (tokens includes: (2@2))) or: (
		(tokens includes: (2@0)) and: (tokens includes: (0@2))
	)).
! !

!TerniLapilliPlayerPieces methodsFor: 'testing' stamp: 'IO 11/1/2020 20:37:58'!
areInWinningPositionByRow: rowNumber

	"return true if the pieces are in a winning position over a given row"

	^(tokens includes: (rowNumber@0)) and: (tokens includes: (rowNumber@1)) and: (tokens includes: (rowNumber@2)).
! !

!TerniLapilliPlayerPieces methodsFor: 'testing' stamp: 'IO 11/1/2020 20:38:02'!
has: aPosition

	"returns true if a piece is placed in a given position"

	^tokens includes: aPosition.
! !

!TerniLapilliPlayerPieces methodsFor: 'testing' stamp: 'IO 11/1/2020 20:38:05'!
tokensAlreadyPut

	"return the amount of pieces placed"

	^tokens size.
! !


!TerniLapilliPlayerPieces methodsFor: 'initializtion' stamp: 'IO 11/1/2020 20:38:12'!
initialize

	"initialize the pieces for a player of the gam"

	tokens := Set new.
! !


!TerniLapilliPlayerPieces methodsFor: 'validations' stamp: 'IO 11/1/2020 20:38:17'!
validateMoveFrom: sourcePosition to: destinationPosition

	"signal when a piece cannot be moved from a given position to another"

	(self has: sourcePosition) ifFalse: [
		^self error: TerniLapilliGame noTokenAtPositionErrorMessage].
	(sourcePosition eightNeighbors includes: destinationPosition) ifFalse: [
		^self error: TerniLapilliGame invalidDestinationErrorMessage].

	self validatePosition: destinationPosition.
! !

!TerniLapilliPlayerPieces methodsFor: 'validations' stamp: 'IO 11/1/2020 19:35:40'!
validatePosition: aPosition

	"signal when a position is invalid with a given error message"

	(
		(aPosition x < 3) and:
		(aPosition x >= 0) and:
		(aPosition y < 3) and:
		(aPosition y >=0)
	) ifFalse: [^self error: TerniLapilliGame invalidPositionErrorMessage].
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliPlayerPieces class' category: 'Terni Lapilli'!
TerniLapilliPlayerPieces class
	instanceVariableNames: ''!

!TerniLapilliPlayerPieces class methodsFor: 'instance creation' stamp: 'IO 11/1/2020 20:46:20'!
new

	"create the pieces for player"

	^self basicNew initialize.
! !
