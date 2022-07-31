!classDefinition: #BackpackTest category: 'ISW1-2020-2C-2doParcial'!
TestCase subclass: #BackpackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!BackpackTest methodsFor: 'adding' stamp: 'HAW 10/18/2020 16:29:03'!
assertShouldAddAll: portableObjects withPoints: expectedTotalPoints

	| aBackpack |
	
	aBackpack := Backpack containingUpTo: self backpackWeight limitingPointsTo: 100.

	portableObjects do: [ :aPortableObject | aBackpack add: aPortableObject ].
	
	self assert: aBackpack size equals: portableObjects size.
	self assert: aBackpack totalWeight equals: (portableObjects sum: [ :aPortableObject | aPortableObject weight ]).
	self assert: aBackpack totalPoints equals: expectedTotalPoints.
! !

!BackpackTest methodsFor: 'adding' stamp: 'HAW 10/18/2020 16:28:32'!
assertShouldNotAddPortableObjectIfWeightExceeded: aPortableObject

	| aBackpack |
	aBackpack := Backpack containingUpTo: self backpackWeight limitingPointsTo: 100.

	self
		should: [ aBackpack add: aPortableObject ]
		raise: Error
		withMessageText: Backpack maxWeightExceededErrorDescription.
		
	self assert: aBackpack isEmpty. 
! !

!BackpackTest methodsFor: 'adding' stamp: 'HAW 10/18/2020 16:28:32'!
backpackWeight

	^ 42! !

!BackpackTest methodsFor: 'adding' stamp: 'HAW 10/18/2020 16:28:41'!
test07ShouldNotAddNoPointsPortableObjectIfWeightExceeded

	self assertShouldNotAddPortableObjectIfWeightExceeded: 
		(NoPointsPortableObject named: 'help-wanted sign' weighing: self backpackWeight + 1)
! !

!BackpackTest methodsFor: 'adding' stamp: 'HAW 10/18/2020 16:28:47'!
test08ShouldNotAddPointsPortableObjectIfWeightExceeded

	self assertShouldNotAddPortableObjectIfWeightExceeded: 
		(PointsPortableObject named: 'left-handed hammer' weighing: self backpackWeight + 6 worth: 5) ! !

!BackpackTest methodsFor: 'adding' stamp: 'HAW 10/18/2020 16:26:42'!
test09ShouldAddPortableObjectsIfWeightUnderMaxWeightCapacity

	self 
		assertShouldAddAll: self twoPortableObjects
		withPoints: 5.
! !

!BackpackTest methodsFor: 'adding' stamp: 'HAW 10/18/2020 16:27:27'!
test10ShouldAddPortableObjectsIfWeightEqualsMaxWeightCapacity

	self 
		assertShouldAddAll:  self twoPortableObjects, {(PointsPortableObject named: 'letter' weighing: 1 worth: 5)}
		withPoints: 10.
! !

!BackpackTest methodsFor: 'adding' stamp: 'HAW 10/18/2020 16:27:39'!
twoPortableObjects

	^ {
		(PointsPortableObject named: 'left-handed hammer' weighing: 40 worth: 5).
		(NoPointsPortableObject named: 'help-wanted sign' weighing: 1) }! !


!BackpackTest methodsFor: 'creating' stamp: 'HAW 10/14/2020 14:31:04'!
test01CanNotCreateBackpackWithZeroMaxWeight

	self
		should: [ Backpack containingUpTo: 0 limitingPointsTo: 100 ]
		raise: Error
		withMessageText: Backpack invalidWeightCapacityErrorDescription.
! !

!BackpackTest methodsFor: 'creating' stamp: 'HAW 10/14/2020 14:31:04'!
test02CanNotCreateBackpackWithNegativeMaxWeight

	self
		should: [ Backpack containingUpTo: -1 limitingPointsTo: 100 ]
		raise: Error
		withMessageText: Backpack invalidWeightCapacityErrorDescription.! !

!BackpackTest methodsFor: 'creating' stamp: 'HAW 10/14/2020 14:31:04'!
test03CanNotCreateBackpackWithZeroMaxPoints

	self
		should: [ Backpack containingUpTo: 10 limitingPointsTo: 0 ]
		raise: Error
		withMessageText: Backpack invalidPointsCapacityErrorDescription.
! !

!BackpackTest methodsFor: 'creating' stamp: 'HAW 10/14/2020 14:31:04'!
test04CanNotCreateBackpackWithNegativeMaxPoints

	self
		should: [ Backpack containingUpTo: 10 limitingPointsTo: -1 ]
		raise: Error
		withMessageText: Backpack invalidPointsCapacityErrorDescription.! !

!BackpackTest methodsFor: 'creating' stamp: 'HAW 10/14/2020 14:31:04'!
test05CanNotCreateBackpackWithNoIntegerMaxWeight

	self
		should: [ Backpack containingUpTo: 1.0 limitingPointsTo: 100 ]
		raise: Error
		withMessageText: Backpack weightCapacityMustBeIntegerErrorDescription.
! !

!BackpackTest methodsFor: 'creating' stamp: 'HAW 10/14/2020 14:31:04'!
test06CanNotCreateBackpackWithNoIntegerMaxPoints

	self
		should: [ Backpack containingUpTo: 100 limitingPointsTo: 1.0 ]
		raise: Error
		withMessageText: Backpack pointsCapacityMustBeIntegerErrorDescription.
! !


!BackpackTest methodsFor: 'accessing' stamp: 'HAW 10/14/2020 14:49:20'!
test11ShouldAddZeroWeightWhenEmpty

	| aBackpack |
	aBackpack := Backpack containingUpTo: 42 limitingPointsTo: 100.

	self assert: aBackpack totalWeight equals: 0.
	self assert: aBackpack isEmpty
! !

!BackpackTest methodsFor: 'accessing' stamp: 'HAW 10/14/2020 14:35:57'!
test12ShouldAddWeightWhenAddingPortableObjects

	| aBackpack |
	aBackpack := Backpack containingUpTo: 42 limitingPointsTo: 100.

	aBackpack add: (PointsPortableObject named: 'left-handed hammer' weighing: 10 worth: 5).
	aBackpack add: (NoPointsPortableObject named: 'help-wanted sign' weighing: 10).
	
	self assert: aBackpack size equals: 2.
	self assert: aBackpack totalWeight equals: 20.

! !

!BackpackTest methodsFor: 'accessing' stamp: 'HAW 10/14/2020 14:49:31'!
test13ShouldAddZeroPointsWhenEmpty

	| aBackpack |
	aBackpack := Backpack containingUpTo: 42 limitingPointsTo: 100.

	self assert: aBackpack totalPoints equals: 0.
	self assert: aBackpack isEmpty.
! !

!BackpackTest methodsFor: 'accessing' stamp: 'HAW 10/14/2020 14:35:57'!
test14ShouldAddPointsWhenAddingPointsPortableObjects

	| aBackpack |
	aBackpack := Backpack containingUpTo: 42 limitingPointsTo: 100.

	aBackpack add: (PointsPortableObject named: 'left-handed hammer' weighing: 10 worth: 5).
	aBackpack add: (PointsPortableObject named: 'car key' weighing: 10 worth: 20).
	
	self assert: aBackpack size equals: 2.
	self assert: aBackpack totalPoints equals: 25.

! !

!BackpackTest methodsFor: 'accessing' stamp: 'HAW 10/14/2020 14:35:57'!
test15ShouldNotAddPointsWhenAddingNoPointsPortableObjects

	| aBackpack |
	aBackpack := Backpack containingUpTo: 42 limitingPointsTo: 100.

	aBackpack add: (PointsPortableObject named: 'left-handed hammer' weighing: 10 worth: 5).
	aBackpack add: (NoPointsPortableObject named: 'help-wanted sign' weighing: 10).
	aBackpack add: (NoPointsPortableObject named: 'help-wanted sign' weighing: 10).
	
	self assert: aBackpack size equals: 3.
	self assert: aBackpack totalPoints equals: 5.

! !


!classDefinition: #PlayableCharacterTest category: 'ISW1-2020-2C-2doParcial'!
TestCase subclass: #PlayableCharacterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!PlayableCharacterTest methodsFor: 'tests' stamp: 'NNH 12/10/2020 20:39:35'!
test01_forwardWhenHeadingNorthIncrementsYCoordinate

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #North room: self defaultRoom .

	playableCharacter moveForward.

	self assert: (playableCharacter isAt: 1@3 heading: #North)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'NNH 12/10/2020 20:39:44'!
test02_backwardWhenHeadingNorthDecrementsYCoordinate

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #North room: self defaultRoom .

	playableCharacter moveBackward.

	self assert: (playableCharacter isAt: 1@1 heading: #North)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'NNH 12/10/2020 20:39:48'!
test03_rotateRightWhenHeadingNorthHeadsEast

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #North room: self defaultRoom .

	playableCharacter rotateRight.

	self assert: (playableCharacter isAt: 1@2 heading: #East)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'NNH 12/10/2020 20:39:53'!
test04_rotateLeftWhenHeadingNorthHeadsWest

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #North room: self defaultRoom .

	playableCharacter rotateLeft.

	self assert: (playableCharacter isAt: 1@2 heading: #West)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'NNH 12/10/2020 20:39:58'!
test05_movingWhenHeadingEastWorksAsExpected

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #East room: self defaultRoom .

	playableCharacter
		moveForward;
		moveForward;
		moveBackward;
		rotateRight;
		rotateLeft;
		rotateLeft.

	self assert: (playableCharacter isAt: 2@2 heading: #North)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'NNH 12/10/2020 20:40:03'!
test06_movingWhenHeadingSouthWorksAsExpected

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #South room: self defaultRoom .

	playableCharacter
		moveForward;
		moveForward;
		moveBackward;
		rotateRight;
		rotateLeft;
		rotateLeft.

	self assert: (playableCharacter isAt: 1@1 heading: #East)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'NNH 12/10/2020 20:40:07'!
test07_movingWhenHeadingWestWorksAsExpected

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 2@2 heading: #West room: self defaultRoom .

	playableCharacter
		moveForward;
		moveForward;
		moveBackward;
		rotateRight;
		rotateLeft;
		rotateLeft.

	self assert: (playableCharacter isAt: 1@2 heading: #South)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'NNH 12/10/2020 20:40:12'!
test08_canNotCreatePlayableCharacterWhenHeadingIsNotValid

	self
		should: [PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #X room: self defaultRoom ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: PlayableCharacter invalidCardinalPointErrorDescription equals: anError messageText ]! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'NNH 12/10/2020 20:40:16'!
test09_canTakePortableObjects

	| playableCharacter paper |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 2@2 heading: #West room: self defaultRoom .
	paper := NoPointsPortableObject named: 'Paper' weighing: 1.
	
	playableCharacter take: paper.
	
	self assert: (playableCharacter backpackIncludes: paper)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'NNH 12/10/2020 20:40:22'!
test10_canNotTakeMoreObjectsThanTheBackpackCanCarry

	| playableCharacter paper key |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 2@2 heading: #West room: self defaultRoom .
	paper := NoPointsPortableObject named: 'Paper' weighing: 100.
	key := NoPointsPortableObject named: 'Key' weighing: 1.
	
	playableCharacter take: paper.
	self 
		should: [ playableCharacter take: key ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: Backpack maxWeightExceededErrorDescription equals: anError messageText.
			self assert: (playableCharacter backpackIncludes: paper).
			self deny: (playableCharacter backpackIncludes: key) ]
	
	! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'NNH 12/10/2020 20:40:26'!
test11_canTakeEmptyNonPortableObjectContents

	| playableCharacter box |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 2@2 heading: #West room: self defaultRoom .
	box := NonPortableObject named: 'Box' containing: OrderedCollection new.
	
	playableCharacter take: box.

	self deny: ( playableCharacter backpackIncludes: box).! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'NNH 12/10/2020 20:40:31'!
test12_canTakeContentsOfNonPortableObjectWithOneElement

	| playableCharacter paper box |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 2@2 heading: #West room: self defaultRoom .
	paper := PointsPortableObject named: 'Paper' weighing: 10 worth: 10. 
	box := NonPortableObject named: 'Box' containing: ( OrderedCollection with: paper ).
	
	playableCharacter take: box.

	self assert: ( playableCharacter backpackIncludes: paper).
	self deny: ( playableCharacter backpackIncludes: box).! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'NNH 12/10/2020 20:40:41'!
test13_canTakeContentsOfNonPortableObjectWithManyElements

	| playableCharacter paper box laser |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 2@2 heading: #West room: self defaultRoom .
	paper := PointsPortableObject named: 'Paper' weighing: 10 worth: 10. 
	laser := PointsPortableObject named: 'Laser' weighing: 20 worth: 50. 
	box := NonPortableObject named: 'Box' containing: ( OrderedCollection with: laser with: paper ).

	playableCharacter take: box.

	self assert: ( playableCharacter backpackIncludes: paper ).
	self assert: ( playableCharacter backpackIncludes: laser ).
	self deny: ( playableCharacter backpackIncludes: box).! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'NNH 12/10/2020 20:40:46'!
test14_canTakeContentsOfNonPortableObjectContainingNonPortableObjects

	| playableCharacter paper box laser envelope |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 2@2 heading: #West room: self defaultRoom .
	paper := PointsPortableObject named: 'Paper' weighing: 10 worth: 10. 
	laser := PointsPortableObject named: 'Laser' weighing: 20 worth: 50. 
	envelope := NonPortableObject named: 'Envelope' containing: ( OrderedCollection with: paper ).
	box := NonPortableObject named: 'Box' containing: ( OrderedCollection with: laser with: envelope ).

	playableCharacter take: box.

	self assert: ( playableCharacter backpackIncludes: paper ).
	self assert: ( playableCharacter backpackIncludes: laser ).
	self deny: ( playableCharacter backpackIncludes: box ).
	self deny: ( playableCharacter backpackIncludes: envelope ).! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'NNH 12/10/2020 20:40:51'!
test15_cannotTakeNonPortableWithContentsExceedingBackpackWeight

	| playableCharacter box wormHole |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 2@2 heading: #West room: self defaultRoom .
	wormHole := PointsPortableObject named: 'Worm Hole' weighing: 110 worth: 10. 
	box := NonPortableObject named: 'Box' containing: ( OrderedCollection with: wormHole ).

	self should: [ playableCharacter take: box ]
	raise: Error
	withMessageText: Backpack maxWeightExceededErrorDescription .
! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'NNH 12/10/2020 20:56:22'!
test16_shouldNotGoForwardBeyondRoomBoundaries

	| playableCharacter xCoordinateOnTheEdge |

	xCoordinateOnTheEdge := self defaultRoomWidth - 1.
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: xCoordinateOnTheEdge@0 heading: #East room: self defaultRoom .

	self should: [ playableCharacter moveForward ]
	raise: Error
	withMessageText: PlayableCharacter cannotMoveOutsideRoomBoundariesErrorDescription.
! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'NNH 12/10/2020 20:57:57'!
test17_shouldNotGoBackwardBeyondRoomBoundaries

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 0@0 heading: #North room: self defaultRoom .

	self should: [ playableCharacter moveBackward ]
	raise: Error
	withMessageText: PlayableCharacter cannotMoveOutsideRoomBoundariesErrorDescription.
! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'NNH 12/10/2020 21:31:47'!
test18_shouldTakeElementInFrontOfPlayer

	| playableCharacter paper aRoom |


	aRoom := self defaultRoom .
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 2@2 heading: #North room: aRoom .
	paper := NoPointsPortableObject named: 'Paper' weighing: 1.
	aRoom place: paper at: 2@3. 
	
	playableCharacter takeElementInFront.
	
	self assert: (playableCharacter backpackIncludes: paper)
! !


!PlayableCharacterTest methodsFor: 'as yet unclassified' stamp: 'HAW 12/9/2020 13:53:29'!
defaultBackpack

	^ Backpack containingUpTo: 100 limitingPointsTo: 100 ! !

!PlayableCharacterTest methodsFor: 'as yet unclassified' stamp: 'NNH 12/10/2020 20:38:24'!
defaultRoom

	^ Room forWidth: self defaultRoomWidth height: self defaultRoomHeight .
 ! !

!PlayableCharacterTest methodsFor: 'as yet unclassified' stamp: 'NNH 12/10/2020 20:38:10'!
defaultRoomHeight

	^ 10
 ! !

!PlayableCharacterTest methodsFor: 'as yet unclassified' stamp: 'NNH 12/10/2020 20:38:07'!
defaultRoomWidth

	^ 10
 ! !


!classDefinition: #RoomTest category: 'ISW1-2020-2C-2doParcial'!
TestCase subclass: #RoomTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!RoomTest methodsFor: 'as yet unclassified' stamp: 'NNH 12/10/2020 21:22:01'!
defaultBackpack

	^ Backpack containingUpTo: 100 limitingPointsTo: 100 ! !

!RoomTest methodsFor: 'as yet unclassified' stamp: 'NNH 12/10/2020 17:55:19'!
test01RoomShouldHaveImmutableWidthAndHeight

	| aRoom |
	
	aRoom := Room forWidth: 10 height: 10.
	
	self assert: aRoom width equals: 10.
	self assert: aRoom height equals: 10.! !

!RoomTest methodsFor: 'as yet unclassified' stamp: 'NNH 12/10/2020 17:52:49'!
test02RoomShouldNotHaveNonPositiveWidth
	
	self should: [ Room forWidth: 0 height: 10 ]
	raise: Error 
	withMessageText: Room widthMustBeAPositiveIntegerErrorDescription.
! !

!RoomTest methodsFor: 'as yet unclassified' stamp: 'NNH 12/10/2020 17:53:07'!
test03RoomShouldNotHaveNonPositiveHeight
	
	self should: [ Room forWidth: 10 height: 0 ]
	raise: Error 
	withMessageText: Room heightMustBeAPositiveIntegerErrorDescription.
! !

!RoomTest methodsFor: 'as yet unclassified' stamp: 'NNH 12/10/2020 17:53:23'!
test04RoomShouldNotHaveNonIntegerWidth
	
	self should: [ Room forWidth: 1.5 height: 10 ]
	raise: Error 
	withMessageText: Room widthMustBeAPositiveIntegerErrorDescription .
! !

!RoomTest methodsFor: 'as yet unclassified' stamp: 'NNH 12/10/2020 17:53:39'!
test05RoomShouldNotHaveNonIntegerHeight
	
	self should: [ Room forWidth: 10 height: 1.5 ]
	raise: Error 
	withMessageText: Room heightMustBeAPositiveIntegerErrorDescription .
! !

!RoomTest methodsFor: 'as yet unclassified' stamp: 'NNH 12/10/2020 18:27:43'!
test06RoomCellsShouldContainOneObjectPlaced
	
	| aRoom |
	
	aRoom := Room forWidth: 10 height: 10.
	aRoom place: 'Scarf' at: 0@0.
	
	self assert: ( aRoom cellContentAt: 0@0 ) equals: 'Scarf'.
	
	 ! !

!RoomTest methodsFor: 'as yet unclassified' stamp: 'NNH 12/10/2020 18:29:54'!
test07ShouldNotPlaceAnObjectAtNegativeX
	
	| aRoom |
	
	aRoom := Room forWidth: 10 height: 10.
	
	self should: [ aRoom place: 'Scarf' at: -1@0 ]
	raise: Error
	withMessageText: Room cannotPlaceAnObjectOutsideRoomBoundariesErrorDescription.

	
	 ! !

!RoomTest methodsFor: 'as yet unclassified' stamp: 'NNH 12/10/2020 18:30:49'!
test08ShouldNotPlaceAnObjectAtNegativeY
	
	| aRoom |
	
	aRoom := Room forWidth: 10 height: 10.
	
	self should: [ aRoom place: 'Scarf' at: 0@-1 ]
	raise: Error
	withMessageText: Room cannotPlaceAnObjectOutsideRoomBoundariesErrorDescription.

	
	 ! !

!RoomTest methodsFor: 'as yet unclassified' stamp: 'NNH 12/10/2020 18:30:38'!
test09ShouldNotPlaceAnObjectBeyondMaxWidth
	
	| aRoom |
	
	aRoom := Room forWidth: 10 height: 10.
	
	self should: [ aRoom place: 'Scarf' at: 10@0 ]
	raise: Error
	withMessageText: Room cannotPlaceAnObjectOutsideRoomBoundariesErrorDescription.

	
	 ! !

!RoomTest methodsFor: 'as yet unclassified' stamp: 'NNH 12/10/2020 18:31:05'!
test10ShouldNotPlaceAnObjectBeyondMaxHeight
	
	| aRoom |
	
	aRoom := Room forWidth: 10 height: 10.
	
	self should: [ aRoom place: 'Scarf' at: 0@10 ]
	raise: Error
	withMessageText: Room cannotPlaceAnObjectOutsideRoomBoundariesErrorDescription.

	
	 ! !

!RoomTest methodsFor: 'as yet unclassified' stamp: 'NNH 12/10/2020 18:28:55'!
test11RoomCellsShouldContainMoreThanOneObjectPlaced
	
	| aRoom |
	
	aRoom := Room forWidth: 10 height: 10.
	aRoom place: 'Scarf' at: 0@0.
	aRoom place: 'Knife' at: 1@0.
	
	self assert: ( aRoom cellContentAt: 0@0 ) equals: 'Scarf'.
	self assert: ( aRoom cellContentAt: 1@0 ) equals: 'Knife'.

	 ! !

!RoomTest methodsFor: 'as yet unclassified' stamp: 'NNH 12/10/2020 18:38:31'!
test12ShouldNotPlaceAnObjectOnOccupiedPosition
	
	| aRoom |
	
	aRoom := Room forWidth: 10 height: 10.
	aRoom place: 'Scarf' at: 0@0.
	self should: [ aRoom place: 'Knife' at: 0@0 ]
	raise: Error
	withMessageText: Room cannotPlaceAnObjectOnOccupiedCellErrorDescription .
	

	 ! !

!RoomTest methodsFor: 'as yet unclassified' stamp: 'NNH 12/10/2020 21:36:08'!
test13CellHasNothingOnEmptyCell
	
	| aRoom |
	
	aRoom := Room forWidth: 10 height: 10.
		
	self assert: ( aRoom cellContentAt: 0@0 ifNothing: [ 'Nothing' ] ) equals: 'Nothing'.
	
	 ! !

!RoomTest methodsFor: 'as yet unclassified' stamp: 'NNH 12/10/2020 21:36:45'!
test14CellRetrievesContentOnNonEmptyCell
	
	| aRoom |
	
	aRoom := Room forWidth: 10 height: 10.
	aRoom place: 'Scarf' at: 0@0.
	
	self assert: ( aRoom cellContentAt: 0@0 ifNothing: [ 'Nothing' ] ) equals: 'Scarf'.
	
	 ! !

!RoomTest methodsFor: 'as yet unclassified' stamp: 'NNH 12/10/2020 21:37:02'!
test15ShouldNotRemoveEmptyCell
	
	| aRoom |
	
	aRoom := Room forWidth: 10 height: 10.
	
	self should: [ aRoom removeObjectAt: 0@0 ]
	raise: Error
	withMessageText: Room cannotRemoveEmptyCellErrorDescription.
	
	 ! !

!RoomTest methodsFor: 'as yet unclassified' stamp: 'NNH 12/10/2020 21:21:49'!
test16RoomShouldContainPlayer

	| playableCharacter startingPoint aRoom |

	startingPoint := 0@0.
	aRoom := Room forWidth: 10 height: 10.
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: startingPoint heading: #North room: aRoom .

	self assert: (aRoom cellContentAt: startingPoint) equals: playableCharacter 
	
	 ! !

!RoomTest methodsFor: 'as yet unclassified' stamp: 'NNH 12/10/2020 21:26:34'!
test17RoomShouldContainPlayerWhenItMovesForward

	| playableCharacter startingPoint aRoom |

	startingPoint := 0@0.
	aRoom := Room forWidth: 10 height: 10.
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: startingPoint heading: #North room: aRoom .
	playableCharacter moveForward.

	self assert: (aRoom cellContentAt: startingPoint ifNothing: [ 'Nothing' ] ) equals: 'Nothing'. 
	self assert: (aRoom cellContentAt: startingPoint + (0@1) ) equals: playableCharacter.

	 ! !

!RoomTest methodsFor: 'as yet unclassified' stamp: 'NNH 12/10/2020 21:26:38'!
test18RoomShouldContainPlayerWhenItMovesBackwards

	| playableCharacter startingPoint aRoom |

	startingPoint := 0@0.
	aRoom := Room forWidth: 10 height: 10.
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: startingPoint heading: #South room: aRoom .
	playableCharacter moveBackward .

	self assert: (aRoom cellContentAt: startingPoint ifNothing: [ 'Nothing' ] ) equals: 'Nothing'. 
	self assert: (aRoom cellContentAt: startingPoint + (0@1) ) equals: playableCharacter.

	 ! !

!RoomTest methodsFor: 'as yet unclassified' stamp: 'NNH 12/10/2020 21:35:41'!
test19RoomShouldNotContainTakenPortableObject

	| playableCharacter aRoom paper |

	aRoom := Room forWidth: 10 height: 10.
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 0@0 heading: #North room: aRoom .
	paper := NoPointsPortableObject named: 'Paper' weighing: 1.
	aRoom place: paper at: 0@1. 
	
	playableCharacter takeElementInFront.
	
	self assert: (aRoom cellContentAt: 0@1 ifNothing: [ 'Nothing' ] ) equals: 'Nothing'. 

	

	 ! !

!RoomTest methodsFor: 'as yet unclassified' stamp: 'NNH 12/10/2020 21:57:03'!
test20RoomShouldContainTakenNonPortableObject

	| playableCharacter aRoom paper box |

	aRoom := Room forWidth: 10 height: 10.
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 0@0 heading: #North room: aRoom .
	paper := PointsPortableObject named: 'Paper' weighing: 10 worth: 10. 
	box := NonPortableObject named: 'Box' containing: ( OrderedCollection with: paper ).
	aRoom place: box at: 0@1. 
	
	playableCharacter takeElementInFront.
	
	self assert: (aRoom cellContentAt: 0@1 ifNothing: [ 'Nothing' ] ) equals: box.
	

	

	 ! !


!classDefinition: #Backpack category: 'ISW1-2020-2C-2doParcial'!
Object subclass: #Backpack
	instanceVariableNames: 'weightCapacity gamePointsCapacity container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!Backpack methodsFor: 'exceptions' stamp: 'FRT 10/8/2020 18:02:29'!
signalMaxPointsExceeded

	self error: self class maxPointsExceededErrorDescription ! !

!Backpack methodsFor: 'exceptions' stamp: 'FRT 10/8/2020 18:02:47'!
signalMaxWeightExceeded

	self error: self class maxWeightExceededErrorDescription ! !


!Backpack methodsFor: 'initialization' stamp: 'HAW 10/14/2020 14:31:56'!
initializeContainingUpTo: aWeightCapacity limitingPointsTo: pointsCapacity

	weightCapacity := aWeightCapacity.
	gamePointsCapacity := pointsCapacity.
	
	container := OrderedCollection new.
	
	
	! !


!Backpack methodsFor: 'accessing' stamp: 'FRT 10/11/2020 19:14:47'!
size

	^ container size.! !

!Backpack methodsFor: 'accessing' stamp: 'HAW 10/18/2020 12:20:52'!
totalPoints
		
	^(container select: [ :portableObject | portableObject doesItAddPoints ])	
		sum: [ :portableObject | portableObject points ]
		ifEmpty: [ 0 ]! !

!Backpack methodsFor: 'accessing' stamp: 'HAW 10/18/2020 12:20:20'!
totalWeight
	
	^container 
		sum: [ :portableObject | portableObject weight ]
		ifEmpty: [ 0 ]
		! !


!Backpack methodsFor: 'assertions' stamp: 'FRT 10/12/2020 14:12:36'!
assertPointsAdding: aPointsPortableObject

	(self totalPoints + aPointsPortableObject points) > gamePointsCapacity ifTrue: [ self signalMaxPointsExceeded ]! !

!Backpack methodsFor: 'assertions' stamp: 'FRT 10/15/2020 12:22:34'!
assertWeightAdding: aPortableObject tolerating: aThreshold

	(self totalWeight + aPortableObject weight - weightCapacity) > aThreshold ifTrue: [ self signalMaxWeightExceeded ]! !


!Backpack methodsFor: 'adding' stamp: 'HAW 10/18/2020 12:28:24'!
add: aPortableObject
	
	aPortableObject assertCanAddTo: self.
	
	container add: aPortableObject.
	! !


!Backpack methodsFor: 'testing' stamp: 'HAW 12/9/2020 19:44:17'!
includes: aPortableObject 
	
	^container includes: aPortableObject ! !

!Backpack methodsFor: 'testing' stamp: 'FRT 10/11/2020 18:38:38'!
isEmpty

	^ container isEmpty.! !


!Backpack methodsFor: 'adding - private' stamp: 'HAW 10/18/2020 12:28:48'!
assertCanAddNoPointsPortableObject: aNoPointsPortableObject 
	
	self assertWeightAdding: aNoPointsPortableObject tolerating: 0.
	! !

!Backpack methodsFor: 'adding - private' stamp: 'HAW 10/18/2020 12:29:07'!
assertCanAddPointPortableObject: aPointsPortableObject 
	
	self assertWeightAdding: aPointsPortableObject tolerating: 5.
	self assertPointsAdding: aPointsPortableObject.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Backpack class' category: 'ISW1-2020-2C-2doParcial'!
Backpack class
	instanceVariableNames: ''!

!Backpack class methodsFor: 'error messages' stamp: 'NNH 12/10/2020 19:44:14'!
cannotAddNonPortableObjectErrorDescription
	
	^ 'Cannot add a non portable object to a backpack'! !

!Backpack class methodsFor: 'error messages' stamp: 'FRT 10/11/2020 18:27:33'!
invalidPointsCapacityErrorDescription

	^ 'Points capacity must be positive'! !

!Backpack class methodsFor: 'error messages' stamp: 'FRT 10/11/2020 18:21:04'!
invalidWeightCapacityErrorDescription

	^ 'Weight capacity must be positive'! !

!Backpack class methodsFor: 'error messages' stamp: 'FRT 10/8/2020 17:36:29'!
maxPointsExceededErrorDescription

	^ 'Maximum points has been exceeded'! !

!Backpack class methodsFor: 'error messages' stamp: 'FRT 10/8/2020 17:36:17'!
maxWeightExceededErrorDescription

	^ 'Maximum weight has been exceeded'! !

!Backpack class methodsFor: 'error messages' stamp: 'FRT 10/8/2020 17:43:00'!
pointsCapacityMustBeIntegerErrorDescription

	^ 'Points capacity must be integer'! !

!Backpack class methodsFor: 'error messages' stamp: 'FRT 10/8/2020 17:42:48'!
weightCapacityMustBeIntegerErrorDescription

	^ 'Weight capacity must be integer'! !


!Backpack class methodsFor: 'exceptions' stamp: 'FRT 10/11/2020 18:27:16'!
signalInvalidPointsCapacity

	self error: self invalidPointsCapacityErrorDescription 
! !

!Backpack class methodsFor: 'exceptions' stamp: 'FRT 10/11/2020 18:21:51'!
signalInvalidWeightCapacity

	self error: self invalidWeightCapacityErrorDescription 
! !

!Backpack class methodsFor: 'exceptions' stamp: 'FRT 10/8/2020 17:41:06'!
signalPointsCapacityMustBeInteger

	self error: self pointsCapacityMustBeIntegerErrorDescription
! !

!Backpack class methodsFor: 'exceptions' stamp: 'FRT 10/8/2020 17:40:47'!
signalWeightCapacityMustBeInteger

	self error: self weightCapacityMustBeIntegerErrorDescription
! !


!Backpack class methodsFor: 'instance creation' stamp: 'HAW 10/14/2020 14:31:56'!
containingUpTo: aWeightCapacity limitingPointsTo: pointsCapacity

	aWeightCapacity strictlyPositive  ifFalse: [ self signalInvalidWeightCapacity ].
	pointsCapacity strictlyPositive ifFalse: [ self signalInvalidPointsCapacity ].
	
	aWeightCapacity isInteger ifFalse: [ self signalWeightCapacityMustBeInteger ].
	pointsCapacity isInteger ifFalse: [ self signalPointsCapacityMustBeInteger ].
	
	^ self new initializeContainingUpTo: aWeightCapacity limitingPointsTo: pointsCapacity.
! !


!classDefinition: #PlayableCharacter category: 'ISW1-2020-2C-2doParcial'!
Object subclass: #PlayableCharacter
	instanceVariableNames: 'position heading backpack name room'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!PlayableCharacter methodsFor: 'initialization' stamp: 'NNH 12/10/2020 21:01:30'!
initializeNamed: aName using: aBackpack at: aPosition heading: aMarsRoverHeading room: aRoom  

	name := aName.
	backpack := aBackpack.
	position := aPosition.
	heading := aMarsRoverHeading.
	room := aRoom.
	room place: self at: position.! !


!PlayableCharacter methodsFor: 'testing' stamp: 'HAW 12/9/2020 19:43:44'!
backpackIncludes: aPortableObject 
	
	^backpack includes: aPortableObject ! !

!PlayableCharacter methodsFor: 'testing' stamp: 'HAW 7/1/2018 14:25:05'!
isAt: aPosition heading: aCardinalPoint

	^position = aPosition and: [ heading cardinalPoint = aCardinalPoint ]! !


!PlayableCharacter methodsFor: 'moving' stamp: 'NNH 12/10/2020 21:14:36'!
moveBackward
	
	(room isInsideRoom: position - heading forwardPoint) ifFalse: [ self error: self class cannotMoveOutsideRoomBoundariesErrorDescription ].

	room removeObjectAt: position.
	
	position := position - heading forwardPoint.
	
	room place: self at: position.! !

!PlayableCharacter methodsFor: 'moving' stamp: 'NNH 12/10/2020 21:15:21'!
moveForward
	
	(room isInsideRoom: position + heading forwardPoint) ifFalse: [ self error: self class cannotMoveOutsideRoomBoundariesErrorDescription ].
	
	room removeObjectAt: position.
	
	position := position + heading forwardPoint.
	
	room place: self at: position. ! !


!PlayableCharacter methodsFor: 'rotating' stamp: 'HAW 10/11/2019 08:31:55'!
rotateLeft
	
	heading := heading leftHeading! !

!PlayableCharacter methodsFor: 'rotating' stamp: 'HAW 10/11/2019 08:32:04'!
rotateRight
	
	heading := heading rightHeading! !


!PlayableCharacter methodsFor: 'taking objects' stamp: 'NNH 12/10/2020 20:06:50'!
take: aPortableObject

	aPortableObject addToBackpack: backpack.! !

!PlayableCharacter methodsFor: 'taking objects' stamp: 'NNH 12/10/2020 21:48:28'!
takeElementInFront
	
	| elementInFront positionInFront |
	
	positionInFront := position + heading forwardPoint.
	elementInFront := room cellContentAt: positionInFront.
	self take: elementInFront.
	elementInFront removeFromRoom: room atPosition: positionInFront.
	elementInFront emptyContents.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayableCharacter class' category: 'ISW1-2020-2C-2doParcial'!
PlayableCharacter class
	instanceVariableNames: 'headings'!

!PlayableCharacter class methodsFor: 'heading' stamp: 'HAW 7/2/2018 16:28:16'!
headingFor: aCardinalPoint
	
	^headings at: aCardinalPoint ifAbsent: [ self error: self invalidCardinalPointErrorDescription ]! !

!PlayableCharacter class methodsFor: 'heading' stamp: 'HAW 7/2/2018 16:26:14'!
invalidCardinalPointErrorDescription
	
	^'Invalid cardinal point'! !


!PlayableCharacter class methodsFor: 'instance creation' stamp: 'NNH 12/10/2020 20:37:02'!
named: aName using: aBackpack at: aPosition heading: aCardinalPoint room: aRoom  
	
	| newHeading |

	newHeading := self headingFor: aCardinalPoint.
	
	^self new initializeNamed: aName using: aBackpack at: aPosition heading: newHeading room: aRoom! !


!PlayableCharacter class methodsFor: 'initialization' stamp: 'HAW 10/11/2019 08:37:25'!
forHeadingAt: aCardinalPoint leftIs: aLeftCardinalPoint rightIs: aRightCardinalPoint
	
	(headings at: aCardinalPoint) leftHeading: (headings at: aLeftCardinalPoint) rightHeading: (headings at: aRightCardinalPoint).
	! !

!PlayableCharacter class methodsFor: 'initialization' stamp: 'HAW 7/2/2018 15:27:41'!
initialize

	self initializeHeadings! !

!PlayableCharacter class methodsFor: 'initialization' stamp: 'HAW 12/9/2020 19:31:43'!
initializeHeadings

	headings := Dictionary new.
	
	(OrderedCollection 
		with: (PlayableCharacterHeading for: #North forwardWith: 0@1 )	
		with: (PlayableCharacterHeading for: #East forwardWith: 1@0 )
		with: (PlayableCharacterHeading for: #South forwardWith: 0@-1 )
		with: (PlayableCharacterHeading for: #West forwardWith: -1@0 ))
			do: [ :heading | headings at: heading cardinalPoint put: heading ].
	
	self 
		forHeadingAt: #North leftIs: #West rightIs: #East;
		forHeadingAt: #South leftIs: #East rightIs: #West;
		forHeadingAt: #East leftIs: #North rightIs: #South;
		forHeadingAt: #West leftIs: #South rightIs: #North.
	! !



!PlayableCharacter class methodsFor: 'error descriptions' stamp: 'NNH 12/10/2020 20:46:10'!
cannotMoveOutsideRoomBoundariesErrorDescription
	
	^ 'Cannot move outside room boundaries'.! !


!classDefinition: #PlayableCharacterHeading category: 'ISW1-2020-2C-2doParcial'!
Object subclass: #PlayableCharacterHeading
	instanceVariableNames: 'cardinalPoint forwardPoint rightHeading leftHeading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!PlayableCharacterHeading methodsFor: 'accessing' stamp: 'HAW 7/2/2018 15:29:44'!
cardinalPoint
	
	^cardinalPoint! !

!PlayableCharacterHeading methodsFor: 'accessing' stamp: 'HAW 7/2/2018 15:30:39'!
forwardPoint
	
	^forwardPoint! !

!PlayableCharacterHeading methodsFor: 'accessing' stamp: 'HAW 10/11/2019 08:31:33'!
leftHeading
	
	^leftHeading! !

!PlayableCharacterHeading methodsFor: 'accessing' stamp: 'HAW 10/11/2019 08:31:27'!
rightHeading
	
	^rightHeading! !


!PlayableCharacterHeading methodsFor: 'initialization' stamp: 'HAW 10/11/2019 08:27:25'!
initializeFor: aCardinalPoint forwardWith: aForwardPoint  
	
	cardinalPoint := aCardinalPoint.
	forwardPoint := aForwardPoint.
! !

!PlayableCharacterHeading methodsFor: 'initialization' stamp: 'HAW 10/11/2019 08:31:33'!
leftHeading: aLeftHeading rightHeading: aRightHeading
 
	leftHeading := aLeftHeading.
	rightHeading := aRightHeading ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayableCharacterHeading class' category: 'ISW1-2020-2C-2doParcial'!
PlayableCharacterHeading class
	instanceVariableNames: ''!

!PlayableCharacterHeading class methodsFor: 'instance creation' stamp: 'HAW 10/11/2019 08:27:46'!
for: aCardinalPoint forwardWith: aForwardPoint  

	^self new initializeFor: aCardinalPoint forwardWith: aForwardPoint ! !


!classDefinition: #Room category: 'ISW1-2020-2C-2doParcial'!
Object subclass: #Room
	instanceVariableNames: 'width height contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!Room methodsFor: 'initialization' stamp: 'NNH 12/10/2020 18:12:43'!
initializeForWidth: aWidth height: aHeight 
	
	width := aWidth.
	height := aHeight.
	contents := Dictionary new.! !


!Room methodsFor: 'accessing' stamp: 'NNH 12/10/2020 18:49:34'!
cellContentAt: aPosition
		
	^ self cellContentAt: aPosition ifNothing: [] .! !

!Room methodsFor: 'accessing' stamp: 'NNH 12/10/2020 18:49:14'!
cellContentAt: aPosition ifNothing: aClosure 
	
	^ contents at: aPosition ifAbsent: [ ^ aClosure value ].! !

!Room methodsFor: 'accessing' stamp: 'NNH 12/10/2020 17:41:49'!
height
	
	^ height! !

!Room methodsFor: 'accessing' stamp: 'NNH 12/10/2020 20:52:29'!
isInsideRoom: aPosition
	
	^ ( aPosition x between: 0 and: width - 1 ) and: [ aPosition y between: 0 and: height - 1 ] 
	! !

!Room methodsFor: 'accessing' stamp: 'NNH 12/10/2020 17:41:38'!
width
	
	^ width! !


!Room methodsFor: 'adding' stamp: 'NNH 12/10/2020 20:52:58'!
place: aStageObject at: aPosition
	
	( self isInsideRoom: aPosition ) ifFalse: [self error: self class cannotPlaceAnObjectOutsideRoomBoundariesErrorDescription ].
	
	( contents includesKey: aPosition ) ifTrue: [ self error: self class cannotPlaceAnObjectOnOccupiedCellErrorDescription ] .
	
	contents at: aPosition put: aStageObject.
	! !


!Room methodsFor: 'removing' stamp: 'NNH 12/10/2020 21:12:58'!
removeObjectAt: aPosition
	
	contents removeKey: aPosition ifAbsent: [ self error: self class cannotRemoveEmptyCellErrorDescription ]. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Room class' category: 'ISW1-2020-2C-2doParcial'!
Room class
	instanceVariableNames: ''!

!Room class methodsFor: 'instance creation' stamp: 'NNH 12/10/2020 17:51:48'!
forWidth: aWidth height: aHeight
	
	(aWidth >= 1 and: [ aWidth isInteger ]) ifFalse: [ self error: self widthMustBeAPositiveIntegerErrorDescription ].
	(aHeight >= 1 and: [ aHeight isInteger ]) ifFalse: [ self error: self heightMustBeAPositiveIntegerErrorDescription ].

	^self new initializeForWidth: aWidth height: aHeight. ! !


!Room class methodsFor: 'error descriptions' stamp: 'NNH 12/10/2020 18:33:05'!
cannotPlaceAnObjectOnOccupiedCellErrorDescription
	
	^ 'Cannot place an object on an already occupied cell' .! !

!Room class methodsFor: 'error descriptions' stamp: 'NNH 12/10/2020 18:17:30'!
cannotPlaceAnObjectOutsideRoomBoundariesErrorDescription
	
	^ 'Cannot place an object outside a rooms boundaries'! !

!Room class methodsFor: 'error descriptions' stamp: 'NNH 12/10/2020 21:12:01'!
cannotRemoveEmptyCellErrorDescription
	
	^ 'Cannot remove an empty cell'! !

!Room class methodsFor: 'error descriptions' stamp: 'NNH 12/10/2020 17:46:57'!
heightMustBeAPositiveIntegerErrorDescription
	
	^ 'A rooms height must be a positive integer'.! !

!Room class methodsFor: 'error descriptions' stamp: 'NNH 12/10/2020 17:44:41'!
widthMustBeAPositiveIntegerErrorDescription
	
	^ 'A rooms width must be a positive integer'! !


!classDefinition: #StageObject category: 'ISW1-2020-2C-2doParcial'!
Object subclass: #StageObject
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!


!classDefinition: #NonPortableObject category: 'ISW1-2020-2C-2doParcial'!
StageObject subclass: #NonPortableObject
	instanceVariableNames: 'name elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!NonPortableObject methodsFor: 'initialization' stamp: 'NNH 12/10/2020 19:20:04'!
initializeNamed: aName containing: aCollectionOfStageObjects 
	
	name := aName.
	elements := aCollectionOfStageObjects.! !


!NonPortableObject methodsFor: 'accessing' stamp: 'NNH 12/10/2020 21:51:24'!
elements
	
	^ elements .! !


!NonPortableObject methodsFor: 'adding' stamp: 'NNH 12/10/2020 20:15:40'!
addToBackpack: aBackpack
	
	elements do: [:anElement | anElement addToBackpack: aBackpack ].! !


!NonPortableObject methodsFor: 'as yet unclassified' stamp: 'NNH 12/10/2020 21:53:17'!
emptyContents

	elements do: [:anElement | anElement emptyContents ].! !

!NonPortableObject methodsFor: 'as yet unclassified' stamp: 'NNH 12/10/2020 21:47:39'!
removeFromRoom: aRoom
	aRoom ! !

!NonPortableObject methodsFor: 'as yet unclassified' stamp: 'NNH 12/10/2020 21:48:51'!
removeFromRoom: aRoom atPosition: aPosition
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NonPortableObject class' category: 'ISW1-2020-2C-2doParcial'!
NonPortableObject class
	instanceVariableNames: ''!

!NonPortableObject class methodsFor: 'instance creation' stamp: 'NNH 12/10/2020 19:18:51'!
named: aName containing: aCollectionOfStageObjects 

	^ self new initializeNamed: aName containing: aCollectionOfStageObjects. ! !


!classDefinition: #PortableObject category: 'ISW1-2020-2C-2doParcial'!
StageObject subclass: #PortableObject
	instanceVariableNames: 'name weight parent'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!PortableObject methodsFor: 'testing' stamp: 'FRT 10/11/2020 17:54:20'!
doesItAddPoints

	self subclassResponsibility	! !


!PortableObject methodsFor: 'adding' stamp: 'NNH 12/10/2020 20:08:27'!
addToBackpack: aBackpack
	
	aBackpack add: self.! !

!PortableObject methodsFor: 'adding' stamp: 'HAW 10/18/2020 12:28:24'!
assertCanAddTo: aBackpack

	self subclassResponsibility	! !


!PortableObject methodsFor: 'accessing' stamp: 'FRT 10/11/2020 18:53:51'!
weight

	^ weight! !


!PortableObject methodsFor: 'as yet unclassified' stamp: 'NNH 12/10/2020 21:56:51'!
emptyContents
	
	"Aqui tengo que eliminarme del Non portable Object que me contiene, si hay tal, pero no tuve tiempo para implementarlo :("
	
	! !

!PortableObject methodsFor: 'as yet unclassified' stamp: 'NNH 12/10/2020 21:49:24'!
removeFromRoom: aRoom atPosition: aPosition
	
	aRoom removeObjectAt: aPosition.! !


!classDefinition: #NoPointsPortableObject category: 'ISW1-2020-2C-2doParcial'!
PortableObject subclass: #NoPointsPortableObject
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!NoPointsPortableObject methodsFor: 'initialization' stamp: 'HAW 10/14/2020 14:34:36'!
initializeNamed: aName weighing: aWeight
	
	name := aName.
	weight := aWeight.! !


!NoPointsPortableObject methodsFor: 'testing' stamp: 'FRT 10/11/2020 17:54:20'!
doesItAddPoints	

	^ false! !


!NoPointsPortableObject methodsFor: 'adding' stamp: 'HAW 10/18/2020 12:28:48'!
assertCanAddTo: aBackpack 
	
	^aBackpack assertCanAddNoPointsPortableObject: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NoPointsPortableObject class' category: 'ISW1-2020-2C-2doParcial'!
NoPointsPortableObject class
	instanceVariableNames: ''!

!NoPointsPortableObject class methodsFor: 'instance creation' stamp: 'HAW 10/14/2020 14:34:36'!
named: aName weighing: aWeight
	
	^ self new initializeNamed: aName weighing: aWeight. ! !


!classDefinition: #PointsPortableObject category: 'ISW1-2020-2C-2doParcial'!
PortableObject subclass: #PointsPortableObject
	instanceVariableNames: 'points'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!PointsPortableObject methodsFor: 'testing' stamp: 'FRT 10/11/2020 17:54:20'!
doesItAddPoints

	^ true! !


!PointsPortableObject methodsFor: 'initialization' stamp: 'HAW 10/14/2020 14:36:26'!
initializeNamed: aName weighing: aWeight worth: gamePoints
	
	name := aName.
	weight := aWeight.
	points := gamePoints.! !


!PointsPortableObject methodsFor: 'accessing' stamp: 'FRT 10/11/2020 19:06:57'!
points

	^ points! !


!PointsPortableObject methodsFor: 'adding' stamp: 'HAW 10/18/2020 12:29:07'!
assertCanAddTo: aBackpack 
	
	^aBackpack assertCanAddPointPortableObject: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PointsPortableObject class' category: 'ISW1-2020-2C-2doParcial'!
PointsPortableObject class
	instanceVariableNames: ''!

!PointsPortableObject class methodsFor: 'instance creation' stamp: 'HAW 10/14/2020 14:36:26'!
named: aName weighing: aWeight worth: gamePoints
	
	^ self new initializeNamed: aName weighing: aWeight worth: gamePoints.! !

PlayableCharacter initialize!