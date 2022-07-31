!classDefinition: #AdventureGameTest category: 'ISW1-2020-2C-2doParcial'!
TestCase subclass: #AdventureGameTest
	instanceVariableNames: 'factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!AdventureGameTest methodsFor: 'assertions' stamp: 'CJ 12/10/2020 15:51:57'!
assertDimensionIsInvalid: aDimension

	self assertInvalidWidth: aDimension andHeight: 1.
	self assertInvalidWidth: 1 andHeight: aDimension.! !

!AdventureGameTest methodsFor: 'assertions' stamp: 'CJ 12/10/2020 16:39:09'!
assertInvalidPositionWhenRunning: aBlockToRun
	
	self
		should: aBlockToRun
		raise: Error
		withMessageText: Room invalidPositionErrorMessage! !

!AdventureGameTest methodsFor: 'assertions' stamp: 'CJ 12/10/2020 15:52:06'!
assertInvalidWidth: aWidth andHeight: aHeight

	self
		should: [ Room width: aWidth height: aHeight ]
		raise: Error
		withMessageText: Room invalidRoomDimensionsErrorMessage! !


!AdventureGameTest methodsFor: 'tests - accessing and placing' stamp: 'CJ 12/10/2020 16:01:41'!
test05CanPlaceObjectInsideRoomBounds

	| room object |
	
	room := Room width: 1 height: 1.
	object := NoPointsPortableObject named: 'Paper' weighing: 1.
	
	room placeObject: object at: 0@0.
	
	self deny: (room isEmptyAt: 0@0).
	self assert: object equals: (room atPosition: 0@0)! !

!AdventureGameTest methodsFor: 'tests - accessing and placing' stamp: 'CJ 12/10/2020 17:14:13'!
test06CannotPlaceObjectOutsideRoomBounds

	| room object |
	
	room := Room width: 1 height: 1.
	object := NoPointsPortableObject named: 'Paper' weighing: 1.
	
	self assertInvalidPositionWhenRunning: [ room placeObject: object at: 1@0 ].
	self assertInvalidPositionWhenRunning: [ room placeObject: object at: 0@-1 ]! !

!AdventureGameTest methodsFor: 'tests - accessing and placing' stamp: 'CJ 12/10/2020 16:39:49'!
test07CannotAccessRoomOutsideBounds

	| room |
	
	room := Room width: 1 height: 1.
	
	self assertInvalidPositionWhenRunning: [ room isEmptyAt: 1@1 ]! !

!AdventureGameTest methodsFor: 'tests - accessing and placing' stamp: 'CJ 12/10/2020 16:40:24'!
test08CannotPlaceObjectOrAccessRoomAtNonIntegerPosition

	| room object |
	
	room := Room width: 2 height: 2.
	object := NoPointsPortableObject named: 'Paper' weighing: 1.
	
	self assertInvalidPositionWhenRunning: [ room isEmptyAt: 0.5@0 ].
	self assertInvalidPositionWhenRunning: [ room placeObject: object at: 0@0.5 ]! !

!AdventureGameTest methodsFor: 'tests - accessing and placing' stamp: 'CJ 12/10/2020 16:35:16'!
test09CannotPlaceObjectAtNonEmptyPosition

	| room object anotherObject |
	
	room := Room width: 1 height: 1.
	object := NoPointsPortableObject named: 'Paper' weighing: 1.
	anotherObject := NoPointsPortableObject named: 'Pen' weighing: 1.
	
	room placeObject: object at: 0@0.
	
	self
		should: [ room placeObject: anotherObject at: 0@0 ]
		raise: Error
		withMessageText: Room positionNotEmptyErrorMessage.
	self assert: object equals: (room atPosition: 0@0)! !


!AdventureGameTest methodsFor: 'tests - character interaction' stamp: 'CJ 12/10/2020 17:05:01'!
test10CharacterCanEnterRoomAtValidPosition

	| room playableCharacter |
	
	room := Room width: 1 height: 1.
	playableCharacter := PlayableCharacter named: 'Luigi' using: factory defaultBackpack at: 2@2 heading: #West.
	
	playableCharacter enterRoom: room at: 0@0 heading: #North.
	
	self assert: playableCharacter equals: (room atPosition: 0@0).
	self assert: (playableCharacter isAt: 0@0 heading: #North)! !

!AdventureGameTest methodsFor: 'tests - character interaction' stamp: 'CJ 12/10/2020 17:43:51'!
test11CharacterCannotEnterRoomAtInvalidOrNonEmptyPosition

	| room playableCharacter |
	
	room := Room width: 3 height: 3.
	playableCharacter := PlayableCharacter named: 'Luigi' using: factory defaultBackpack at: 2@2 heading: #West.
	
	self assertInvalidPositionWhenRunning: [ playableCharacter enterRoom: room at: 3@3 heading: #North ].
	self assert: (playableCharacter isAt: 2@2 heading: #West)! !

!AdventureGameTest methodsFor: 'tests - character interaction' stamp: 'CJ 12/10/2020 17:28:36'!
test12CharacterCannotMoveToInvalidOrNonEmptyPosition

	| room playableCharacter object |
	
	room := Room width: 3 height: 3.
	playableCharacter := PlayableCharacter named: 'Luigi' using: factory defaultBackpack at: 2@2 heading: #West.
	object := NoPointsPortableObject named: 'Paper' weighing: 1.
	
	room placeObject: object at: 0@1.
	playableCharacter enterRoom: room at: 0@0 heading: #North.
	
	self assertInvalidPositionWhenRunning: [ playableCharacter moveBackward ].
	self
		should: [ playableCharacter moveForward ]
		raise: Error
		withMessageText: Room positionNotEmptyErrorMessage! !

!AdventureGameTest methodsFor: 'tests - character interaction' stamp: 'CJ 12/10/2020 17:45:33'!
test13CharacterCannotTakeFromEmptyPosition

	| room playableCharacter |
	
	room := Room width: 3 height: 3.
	playableCharacter := PlayableCharacter named: 'Luigi' using: factory defaultBackpack at: 2@2 heading: #West.

	playableCharacter enterRoom: room at: 0@0 heading: #North.
	
	self
		should: [ playableCharacter take ]
		raise: Error
		withMessageText: Room cannotTakeFromEmptyPositionErrorMessage! !

!AdventureGameTest methodsFor: 'tests - character interaction' stamp: 'CJ 12/10/2020 18:24:17'!
test14CharacterCanTakePortableObject

	| room playableCharacter object |
	
	room := Room width: 3 height: 3.
	playableCharacter := PlayableCharacter named: 'Luigi' using: factory defaultBackpack at: 2@2 heading: #West.
	object := NoPointsPortableObject named: 'Paper' weighing: 1.
	
	room placeObject: object at: 0@1.
	playableCharacter enterRoom: room at: 0@0 heading: #North.
	playableCharacter take.
	
	self assert: (playableCharacter backpackIncludes: object).
	self assert: (room isEmptyAt: 0@1)! !


!AdventureGameTest methodsFor: 'tests - room creation' stamp: 'CJ 12/10/2020 15:47:07'!
test01NewRoomPositionIsEmpty

	| room |
	
	room := Room width: 1 height: 1.
	
	self assert: (room isEmptyAt: 0@0)! !

!AdventureGameTest methodsFor: 'tests - room creation' stamp: 'CJ 12/10/2020 15:49:23'!
test02RoomDimensionsCannotBeNegative

	self assertDimensionIsInvalid: -1.! !

!AdventureGameTest methodsFor: 'tests - room creation' stamp: 'CJ 12/10/2020 15:49:42'!
test03RoomDimensionsCannotBeZero

	self assertDimensionIsInvalid: 0.! !

!AdventureGameTest methodsFor: 'tests - room creation' stamp: 'CJ 12/10/2020 15:55:56'!
test04RoomDimensionsCannotBeNonIntegers

	self assertDimensionIsInvalid: 1.5.! !


!AdventureGameTest methodsFor: 'tests - non-portable objects' stamp: 'CJ 12/10/2020 19:24:29'!
test15CharacterCannotTakeFromEmptyNonPortableObject

	| room playableCharacter object |
	
	room := Room width: 3 height: 3.
	playableCharacter := PlayableCharacter named: 'Luigi' using: factory defaultBackpack at: 2@2 heading: #West.
	object := NonPortableObject named: 'Wardrobe'.
	
	room placeObject: object at: 0@1.
	playableCharacter enterRoom: room at: 0@0 heading: #North.
	
	self
		should: [ playableCharacter take ]
		raise: Error
		withMessageText: NonPortableObject cannotTakeFromEmptyObjectErrorMessage.
	self deny: (playableCharacter backpackIncludes: object)! !

!AdventureGameTest methodsFor: 'tests - non-portable objects' stamp: 'CJ 12/10/2020 19:16:36'!
test16CharacterCanTakePortableObjectsFromNonPortableObject

	| room playableCharacter nonPortableObject portableObject |
	
	room := Room width: 3 height: 3.
	playableCharacter := PlayableCharacter named: 'Luigi' using: factory defaultBackpack at: 2@2 heading: #West.
	nonPortableObject := NonPortableObject named: 'Wardrobe'.
	portableObject := NoPointsPortableObject named: 'Coat' weighing: 10.
	
	room placeObject: nonPortableObject at: 0@1.
	nonPortableObject addObject: portableObject.
	playableCharacter enterRoom: room at: 0@0 heading: #North.
	playableCharacter take.
	
	self assert: (playableCharacter backpackIncludes: portableObject).
	self deny: (nonPortableObject includes: portableObject)! !

!AdventureGameTest methodsFor: 'tests - non-portable objects' stamp: 'CJ 12/10/2020 19:16:45'!
test17CharacterCanTakeNestedPortableObjectsFromNonPortableObject

	| room playableCharacter outerNonPortableObject innerNonPortableObject portableObject |
	
	room := Room width: 3 height: 3.
	playableCharacter := PlayableCharacter named: 'Luigi' using: factory defaultBackpack at: 2@2 heading: #West.
	outerNonPortableObject := NonPortableObject named: 'Wardrobe'.
	innerNonPortableObject := NonPortableObject named: 'Box'.
	portableObject := NoPointsPortableObject named: 'Coat' weighing: 10.
	
	room placeObject: outerNonPortableObject at: 0@1.
	innerNonPortableObject addObject: portableObject.
	outerNonPortableObject addObject: innerNonPortableObject.
	playableCharacter enterRoom: room at: 0@0 heading: #North.
	playableCharacter take.
	
	self assert: (playableCharacter backpackIncludes: portableObject).
	self assert: (outerNonPortableObject includes: innerNonPortableObject)! !

!AdventureGameTest methodsFor: 'tests - non-portable objects' stamp: 'CJ 12/10/2020 19:33:53'!
test18CharacterCanTakeFromNonPortableObjectWhenThereIsAnEmptyObjectInside

	| room playableCharacter outerNonPortableObject innerNonPortableObject portableObject |
	
	room := Room width: 3 height: 3.
	playableCharacter := PlayableCharacter named: 'Luigi' using: factory defaultBackpack at: 2@2 heading: #West.
	outerNonPortableObject := NonPortableObject named: 'Wardrobe'.
	innerNonPortableObject := NonPortableObject named: 'Box'.
	portableObject := NoPointsPortableObject named: 'Coat' weighing: 10.
	
	room placeObject: outerNonPortableObject at: 0@1.
	outerNonPortableObject addObject: portableObject.
	outerNonPortableObject addObject: innerNonPortableObject.
	playableCharacter enterRoom: room at: 0@0 heading: #North.
	playableCharacter take.
	
	self assert: (playableCharacter backpackIncludes: portableObject)! !

!AdventureGameTest methodsFor: 'tests - non-portable objects' stamp: 'CJ 12/10/2020 19:31:50'!
test19CharacterCannotTakeFromNonPortableObjectWithOnlyEmptyObjects

	| room playableCharacter outerNonPortableObject innerNonPortableObject |
	
	room := Room width: 3 height: 3.
	playableCharacter := PlayableCharacter named: 'Luigi' using: factory defaultBackpack at: 2@2 heading: #West.
	outerNonPortableObject := NonPortableObject named: 'Wardrobe'.
	innerNonPortableObject := NonPortableObject named: 'Box'.
	
	room placeObject: outerNonPortableObject at: 0@1.
	outerNonPortableObject addObject: innerNonPortableObject.
	playableCharacter enterRoom: room at: 0@0 heading: #North.
	
	self
		should: [ playableCharacter take ]
		raise: Error
		withMessageText: NonPortableObject cannotTakeFromEmptyObjectErrorMessage! !

!AdventureGameTest methodsFor: 'tests - non-portable objects' stamp: 'CJ 12/10/2020 19:49:25'!
test20CharacterCanTakePortableObjectsAsLongAsBackpackHasRoom

	| room playableCharacter nonPortableObject objectToTake anotherObjectToTake tooHeavyObject |
	
	room := Room width: 3 height: 3.
	playableCharacter := PlayableCharacter named: 'Luigi' using: factory defaultBackpack at: 2@2 heading: #West.
	nonPortableObject := NonPortableObject named: 'Wardrobe'.
	objectToTake := NoPointsPortableObject named: 'Coat' weighing: 10.
	anotherObjectToTake := PointsPortableObject named: 'Dragon Ball' weighing: 90 worth: 100.
	tooHeavyObject := NoPointsPortableObject named: 'A real live horse' weighing: 91.
	
	room placeObject: nonPortableObject at: 0@1.
	nonPortableObject addObject: objectToTake.
	nonPortableObject addObject: tooHeavyObject.
	nonPortableObject addObject: anotherObjectToTake.
	playableCharacter enterRoom: room at: 0@0 heading: #North.
	playableCharacter take.
	
	self assert: (playableCharacter backpackIncludes: objectToTake).
	self assert: (playableCharacter backpackIncludes: anotherObjectToTake).
	self deny: (playableCharacter backpackIncludes: tooHeavyObject)! !


!AdventureGameTest methodsFor: 'set up / tear down' stamp: 'CJ 12/10/2020 16:59:40'!
setUp

	factory := AdventureGameTestObjectFactory new! !


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

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/9/2020 19:36:13'!
test01_forwardWhenHeadingNorthIncrementsYCoordinate

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #North .

	playableCharacter moveForward.

	self assert: (playableCharacter isAt: 1@3 heading: #North)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/9/2020 19:36:13'!
test02_backwardWhenHeadingNorthDecrementsYCoordinate

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #North .

	playableCharacter moveBackward.

	self assert: (playableCharacter isAt: 1@1 heading: #North)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/9/2020 19:36:13'!
test03_rotateRightWhenHeadingNorthHeadsEast

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #North .

	playableCharacter rotateRight.

	self assert: (playableCharacter isAt: 1@2 heading: #East)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/9/2020 19:36:13'!
test04_rotateLeftWhenHeadingNorthHeadsWest

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #North .

	playableCharacter rotateLeft.

	self assert: (playableCharacter isAt: 1@2 heading: #West)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/9/2020 19:36:13'!
test05_movingWhenHeadingEastWorksAsExpected

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #East .

	playableCharacter
		moveForward;
		moveForward;
		moveBackward;
		rotateRight;
		rotateLeft;
		rotateLeft.

	self assert: (playableCharacter isAt: 2@2 heading: #North)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/9/2020 19:36:13'!
test06_movingWhenHeadingSouthWorksAsExpected

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #South .

	playableCharacter
		moveForward;
		moveForward;
		moveBackward;
		rotateRight;
		rotateLeft;
		rotateLeft.

	self assert: (playableCharacter isAt: 1@1 heading: #East)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/9/2020 19:36:13'!
test07_movingWhenHeadingWestWorksAsExpected

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 2@2 heading: #West .

	playableCharacter
		moveForward;
		moveForward;
		moveBackward;
		rotateRight;
		rotateLeft;
		rotateLeft.

	self assert: (playableCharacter isAt: 1@2 heading: #South)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/9/2020 19:36:13'!
test08_canNotCreatePlayableCharacterWhenHeadingIsNotValid

	self
		should: [PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #X ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: PlayableCharacter invalidCardinalPointErrorDescription equals: anError messageText ]! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/9/2020 19:43:14'!
test09_canTakePortableObjects

	| playableCharacter paper |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 2@2 heading: #West .
	paper := NoPointsPortableObject named: 'Paper' weighing: 1.
	
	playableCharacter take: paper.
	
	self assert: (playableCharacter backpackIncludes: paper)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/9/2020 19:47:21'!
test10_canNotTakeMoreObjectsThanTheBackpackCanCarry

	| playableCharacter paper key |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 2@2 heading: #West .
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


!PlayableCharacterTest methodsFor: 'as yet unclassified' stamp: 'HAW 12/9/2020 13:53:29'!
defaultBackpack

	^ Backpack containingUpTo: 100 limitingPointsTo: 100 ! !


!classDefinition: #AbstractRoom category: 'ISW1-2020-2C-2doParcial'!
Object subclass: #AbstractRoom
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!
!AbstractRoom commentStamp: '<historical>' prior: 0!
Esta clase debería tener definidos los métodos polimórficos entre NullRoom y Room, pero por cuestiones de tiempo no llegué a hacerlos. Lo mismo vale para StageObject y los métodos polimórficos entre PortableObject y NonPortableObject.!



!classDefinition: #NullRoom category: 'ISW1-2020-2C-2doParcial'!
AbstractRoom subclass: #NullRoom
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!NullRoom methodsFor: 'assertions' stamp: 'CJ 12/10/2020 17:38:22'!
assertPositionCanBeOccupied: aPosition
	
	"Do nothing"! !


!classDefinition: #Room category: 'ISW1-2020-2C-2doParcial'!
AbstractRoom subclass: #Room
	instanceVariableNames: 'width height contents maxXCoordinate maxYCoordinate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!Room methodsFor: 'initialization' stamp: 'CJ 12/10/2020 16:02:10'!
initialize

	contents := Dictionary new! !

!Room methodsFor: 'initialization' stamp: 'CJ 12/10/2020 16:20:59'!
initializeWidth: aWidth height: aHeight 
	
	width := aWidth.
	height := aHeight.
	maxXCoordinate := aWidth - 1.
	maxYCoordinate := aHeight - 1.! !


!Room methodsFor: 'testing' stamp: 'CJ 12/10/2020 17:15:28'!
isEmptyAt: aPosition
	
	self assertValidPosition: aPosition.
	
	^ (self atPosition: aPosition) isNil! !

!Room methodsFor: 'testing' stamp: 'CJ 12/10/2020 17:13:17'!
positionInsideBounds: aPosition

	^ aPosition between: 0@0 and: maxXCoordinate@maxYCoordinate ! !


!Room methodsFor: 'objects' stamp: 'CJ 12/10/2020 19:30:34'!
objectAt: positionToTakeObjectFrom

	| object |
	
	self assertValidPosition: positionToTakeObjectFrom.
	self assertObjectAt: positionToTakeObjectFrom.
	
	object := 	self atPosition: positionToTakeObjectFrom.
	contents removeKey: positionToTakeObjectFrom.
	^ object! !

!Room methodsFor: 'objects' stamp: 'CJ 12/10/2020 17:19:49'!
placeObject: anObject at: aPosition
	
	self assertPositionCanBeOccupied: aPosition.
	
	contents at: aPosition put: anObject! !


!Room methodsFor: 'accessing' stamp: 'CJ 12/10/2020 16:15:50'!
atPosition: aPosition

	^ contents at: aPosition ifAbsent: [ nil ]! !


!Room methodsFor: 'exceptions' stamp: 'CJ 12/10/2020 17:47:44'!
signalCannotTakeFromEmptyPosition
	
	self error: self class cannotTakeFromEmptyPositionErrorMessage ! !

!Room methodsFor: 'exceptions' stamp: 'CJ 12/10/2020 16:21:30'!
signalInvalidPosition
	
	self error: self class invalidPositionErrorMessage! !

!Room methodsFor: 'exceptions' stamp: 'CJ 12/10/2020 16:38:06'!
signalNotEmptyPosition
	
	self error: self class positionNotEmptyErrorMessage ! !


!Room methodsFor: 'assertions' stamp: 'CJ 12/10/2020 19:30:27'!
assertObjectAt: positionToTakeObjectFrom

	(self isEmptyAt: positionToTakeObjectFrom) ifTrue: [ self signalCannotTakeFromEmptyPosition ]! !

!Room methodsFor: 'assertions' stamp: 'CJ 12/10/2020 17:19:32'!
assertPositionCanBeOccupied: aPosition

	self assertValidPosition: aPosition.
	self assertPositionIsEmpty: aPosition! !

!Room methodsFor: 'assertions' stamp: 'CJ 12/10/2020 16:37:34'!
assertPositionIsEmpty: aPosition

	(self isEmptyAt: aPosition) ifFalse: [ self signalNotEmptyPosition ]! !

!Room methodsFor: 'assertions' stamp: 'CJ 12/10/2020 16:32:03'!
assertValidPosition: aPosition

	((self positionInsideBounds: aPosition) and: (aPosition x isInteger and: [aPosition y isInteger]))
		ifFalse: [ self signalInvalidPosition ]! !


!Room methodsFor: 'character interactions' stamp: 'CJ 12/10/2020 17:20:04'!
receiveCharacter: aPlayableCharacter at: aPosition

	self assertPositionCanBeOccupied: aPosition.
	
	contents at: aPosition put: aPlayableCharacter ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Room class' category: 'ISW1-2020-2C-2doParcial'!
Room class
	instanceVariableNames: ''!

!Room class methodsFor: 'error messages' stamp: 'CJ 12/10/2020 17:46:18'!
cannotTakeFromEmptyPositionErrorMessage
	
	^ 'Cannot take an object from an empty position'! !

!Room class methodsFor: 'error messages' stamp: 'CJ 12/10/2020 16:18:17'!
invalidPositionErrorMessage
	
	^ 'Invalid position'! !

!Room class methodsFor: 'error messages' stamp: 'CJ 12/10/2020 15:37:57'!
invalidRoomDimensionsErrorMessage
	
	^ 'Both room dimensions must be positive integers'! !

!Room class methodsFor: 'error messages' stamp: 'CJ 12/10/2020 16:36:05'!
positionNotEmptyErrorMessage
	
	^ 'Position not empty'! !


!Room class methodsFor: 'instance creation' stamp: 'CJ 12/10/2020 15:55:36'!
assertIntegerWidth: aHeight andHeight: aWidth

	^ (aWidth isInteger and: [aHeight isInteger]) ifFalse: [ self signalInvalidRoomDimensions ]! !

!Room class methodsFor: 'instance creation' stamp: 'CJ 12/10/2020 15:54:15'!
assertPositiveWidth: aWidth andHeight: aHeight

	^ (aWidth < 1 or: [aHeight < 1]) ifTrue: [ self signalInvalidRoomDimensions ]! !

!Room class methodsFor: 'instance creation' stamp: 'CJ 12/10/2020 15:55:42'!
width: aWidth height: aHeight 
	
	self assertPositiveWidth: aWidth andHeight: aHeight.
	self assertIntegerWidth: aHeight andHeight: aWidth.
	
	^ self new initializeWidth: aWidth height: aHeight ! !


!Room class methodsFor: 'exceptions' stamp: 'CJ 12/10/2020 15:39:59'!
signalInvalidRoomDimensions
	
	self error: self invalidRoomDimensionsErrorMessage ! !


!classDefinition: #AdventureGameTestObjectFactory category: 'ISW1-2020-2C-2doParcial'!
Object subclass: #AdventureGameTestObjectFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!AdventureGameTestObjectFactory methodsFor: 'objects' stamp: 'CJ 12/10/2020 16:59:12'!
defaultBackpack

	^ Backpack containingUpTo: 100 limitingPointsTo: 100 ! !


!classDefinition: #Backpack category: 'ISW1-2020-2C-2doParcial'!
Object subclass: #Backpack
	instanceVariableNames: 'weightCapacity gamePointsCapacity container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!Backpack methodsFor: 'exceptions' stamp: 'CJ 12/10/2020 18:11:13'!
signalCannotTakeNonPortableObject
	
	self error: self class cannotTakeNonPortableObjectErrorMessage! !

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


!Backpack methodsFor: 'adding' stamp: 'CJ 12/10/2020 18:56:10'!
add: aStageObject
	
	aStageObject addTo: self! !

!Backpack methodsFor: 'adding' stamp: 'CJ 12/10/2020 18:58:11'!
addPortable: aStageObject
	
	aStageObject assertCanAddTo: self.
	
	container add: aStageObject.
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

!Backpack methodsFor: 'adding - private' stamp: 'CJ 12/10/2020 18:10:36'!
assertCanAddNonPortableObject: aNonPortableObject 
	
	self signalCannotTakeNonPortableObject! !

!Backpack methodsFor: 'adding - private' stamp: 'HAW 10/18/2020 12:29:07'!
assertCanAddPointPortableObject: aPointsPortableObject 
	
	self assertWeightAdding: aPointsPortableObject tolerating: 5.
	self assertPointsAdding: aPointsPortableObject.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Backpack class' category: 'ISW1-2020-2C-2doParcial'!
Backpack class
	instanceVariableNames: ''!

!Backpack class methodsFor: 'error messages' stamp: 'CJ 12/10/2020 18:11:32'!
cannotTakeNonPortableObjectErrorMessage
	
	^ 'Cannot take a non-portable object'! !

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

!PlayableCharacter methodsFor: 'initialization' stamp: 'CJ 12/10/2020 17:37:29'!
initializeNamed: aName using: aBackpack at: aPosition heading: aMarsRoverHeading 

	name := aName.
	backpack := aBackpack.
	position := aPosition.
	heading := aMarsRoverHeading.
	room := NullRoom new! !


!PlayableCharacter methodsFor: 'testing' stamp: 'HAW 12/9/2020 19:43:44'!
backpackIncludes: aPortableObject 
	
	^backpack includes: aPortableObject ! !

!PlayableCharacter methodsFor: 'testing' stamp: 'HAW 7/1/2018 14:25:05'!
isAt: aPosition heading: aCardinalPoint

	^position = aPosition and: [ heading cardinalPoint = aCardinalPoint ]! !


!PlayableCharacter methodsFor: 'moving' stamp: 'CJ 12/10/2020 17:01:24'!
enterRoom: aRoom at: aPosition 
	
	aRoom receiveCharacter: self at: aPosition ! !

!PlayableCharacter methodsFor: 'moving' stamp: 'CJ 12/10/2020 17:32:34'!
enterRoom: aRoom at: aPosition heading: aCardinalPoint

	| newHeading |
	
	"If the cardinal point is invalid, we want this to raise an error
	BEFORE putting the character in the room!!"
	newHeading := (self class headingFor: aCardinalPoint).
	
	aRoom receiveCharacter: self at: aPosition.
	
	position := aPosition.
	heading := newHeading.
	room := aRoom! !

!PlayableCharacter methodsFor: 'moving' stamp: 'CJ 12/10/2020 17:42:50'!
moveBackward
	
	self setPositionIfValidAndFree: position - heading forwardPoint! !

!PlayableCharacter methodsFor: 'moving' stamp: 'CJ 12/10/2020 17:43:17'!
moveForward
	
	self setPositionIfValidAndFree: position + heading forwardPoint! !

!PlayableCharacter methodsFor: 'moving' stamp: 'CJ 12/10/2020 17:50:33'!
positionInFront
	
	^ position + heading forwardPoint! !

!PlayableCharacter methodsFor: 'moving' stamp: 'CJ 12/10/2020 17:42:30'!
setPositionIfValidAndFree: blockToSetNewPosition
	
	| newPosition |
	
	newPosition := blockToSetNewPosition value.
	room assertPositionCanBeOccupied: newPosition.
	position := newPosition ! !


!PlayableCharacter methodsFor: 'rotating' stamp: 'HAW 10/11/2019 08:31:55'!
rotateLeft
	
	heading := heading leftHeading! !

!PlayableCharacter methodsFor: 'rotating' stamp: 'HAW 10/11/2019 08:32:04'!
rotateRight
	
	heading := heading rightHeading! !


!PlayableCharacter methodsFor: 'taking objects' stamp: 'CJ 12/10/2020 17:57:59'!
take
	
	| object |
	
	object := room objectAt: self positionInFront.
	self take: object! !

!PlayableCharacter methodsFor: 'taking objects' stamp: 'CJ 12/10/2020 18:32:45'!
take: aStageObject

	backpack add: aStageObject.! !

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


!PlayableCharacter class methodsFor: 'instance creation' stamp: 'HAW 12/9/2020 19:36:13'!
named: aName using: aBackpack at: aPosition heading: aCardinalPoint 
	
	| newHeading |

	newHeading := self headingFor: aCardinalPoint.
	
	^self new initializeNamed: aName using: aBackpack at: aPosition heading: newHeading ! !


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


!classDefinition: #StageObject category: 'ISW1-2020-2C-2doParcial'!
Object subclass: #StageObject
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!


!classDefinition: #NonPortableObject category: 'ISW1-2020-2C-2doParcial'!
StageObject subclass: #NonPortableObject
	instanceVariableNames: 'name weight objectsInside'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!NonPortableObject methodsFor: 'initialization' stamp: 'CJ 12/10/2020 18:30:25'!
initializeNamed: aName
	
	name := aName.
	objectsInside := OrderedCollection new! !


!NonPortableObject methodsFor: 'adding' stamp: 'CJ 12/10/2020 19:16:10'!
addObject: aStageObjectToAdd

	objectsInside add: aStageObjectToAdd ! !

!NonPortableObject methodsFor: 'adding' stamp: 'CJ 12/10/2020 19:27:20'!
addTo: aBackpack 
	
	self hasPortableObjects ifFalse: [ self signalCannotTakeFromEmptyObject ].
	
	self addContentsTo: aBackpack! !


!NonPortableObject methodsFor: 'testing' stamp: 'CJ 12/10/2020 18:38:28'!
includes: aStageObject

	^ objectsInside includes: aStageObject ! !


!NonPortableObject methodsFor: 'exceptions' stamp: 'CJ 12/10/2020 19:01:29'!
signalCannotTakeFromEmptyObject
	
	self error: self class cannotTakeFromEmptyObjectErrorMessage ! !


!NonPortableObject methodsFor: 'adding - private' stamp: 'CJ 12/10/2020 19:41:47'!
addContentsTo: aBackpack 
	
	| toRemove |
	
	"Recursive helper method to addTo. It was needed because addTo is supposed to raise an error
	if the outermost non-portable object is empty, but it should be possible to have
	empty inner non-portable objects and take all the portable ones in the same composite."
	
	toRemove := OrderedCollection new.
	objectsInside do: [ :anObject |
		[ anObject addContentsTo: aBackpack.
		(anObject isKindOf: PortableObject) ifTrue: [ toRemove add: anObject ] ] on: Error do: []
		].
	objectsInside removeAll: toRemove! !

!NonPortableObject methodsFor: 'adding - private' stamp: 'CJ 12/10/2020 19:28:43'!
hasPortableObjects
	
	^ objectsInside anySatisfy: [ :anObject | anObject hasPortableObjects ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NonPortableObject class' category: 'ISW1-2020-2C-2doParcial'!
NonPortableObject class
	instanceVariableNames: ''!

!NonPortableObject class methodsFor: 'as yet unclassified' stamp: 'CJ 12/10/2020 18:28:53'!
named: aName
	
	^ self new initializeNamed: aName! !


!NonPortableObject class methodsFor: 'error messages' stamp: 'CJ 12/10/2020 18:54:52'!
cannotTakeFromEmptyObjectErrorMessage
	
	^ 'Cannot take anything from an empty object'! !


!classDefinition: #PortableObject category: 'ISW1-2020-2C-2doParcial'!
StageObject subclass: #PortableObject
	instanceVariableNames: 'name weight'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!PortableObject methodsFor: 'testing' stamp: 'FRT 10/11/2020 17:54:20'!
doesItAddPoints

	self subclassResponsibility	! !


!PortableObject methodsFor: 'adding' stamp: 'CJ 12/10/2020 18:58:16'!
addTo: aBackpack 
	
	aBackpack addPortable: self! !

!PortableObject methodsFor: 'adding' stamp: 'HAW 10/18/2020 12:28:24'!
assertCanAddTo: aBackpack

	self subclassResponsibility	! !


!PortableObject methodsFor: 'accessing' stamp: 'FRT 10/11/2020 18:53:51'!
weight

	^ weight! !


!PortableObject methodsFor: 'adding - private' stamp: 'CJ 12/10/2020 19:19:09'!
addContentsTo: aBackpack 
	
	self addTo: aBackpack! !

!PortableObject methodsFor: 'adding - private' stamp: 'CJ 12/10/2020 19:29:10'!
hasPortableObjects
	
	^ true! !


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

!NoPointsPortableObject class methodsFor: 'instance creation' stamp: 'CJ 12/10/2020 18:06:55'!
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