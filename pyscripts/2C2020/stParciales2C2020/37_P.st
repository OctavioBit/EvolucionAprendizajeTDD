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
	instanceVariableNames: 'testObjects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!PlayableCharacterTest methodsFor: 'tests' stamp: 'AA 12/10/2020 19:37:24'!
test01_forwardWhenHeadingNorthIncrementsYCoordinate

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: testObjects defaultBackpack in: testObjects defaultRoom at: 1@2 heading: #North .

	playableCharacter moveForward.

	self assert: (playableCharacter isAt: 1@3 heading: #North)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'AA 12/10/2020 19:37:21'!
test02_backwardWhenHeadingNorthDecrementsYCoordinate

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: testObjects defaultBackpack in: testObjects defaultRoom at: 1@2 heading: #North .

	playableCharacter moveBackward.

	self assert: (playableCharacter isAt: 1@1 heading: #North)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'AA 12/10/2020 19:37:19'!
test03_rotateRightWhenHeadingNorthHeadsEast

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: testObjects defaultBackpack in: testObjects defaultRoom at: 1@2 heading: #North .

	playableCharacter rotateRight.

	self assert: (playableCharacter isAt: 1@2 heading: #East)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'AA 12/10/2020 19:37:17'!
test04_rotateLeftWhenHeadingNorthHeadsWest

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: testObjects defaultBackpack in: testObjects defaultRoom at: 1@2 heading: #North .

	playableCharacter rotateLeft.

	self assert: (playableCharacter isAt: 1@2 heading: #West)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'AA 12/10/2020 19:37:15'!
test05_movingWhenHeadingEastWorksAsExpected

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: testObjects defaultBackpack in: testObjects defaultRoom at: 1@2 heading: #East .

	playableCharacter
		moveForward;
		moveForward;
		moveBackward;
		rotateRight;
		rotateLeft;
		rotateLeft.

	self assert: (playableCharacter isAt: 2@2 heading: #North)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'AA 12/10/2020 19:37:12'!
test06_movingWhenHeadingSouthWorksAsExpected

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: testObjects defaultBackpack in: testObjects defaultRoom at: 1@2 heading: #South .

	playableCharacter
		moveForward;
		moveForward;
		moveBackward;
		rotateRight;
		rotateLeft;
		rotateLeft.

	self assert: (playableCharacter isAt: 1@1 heading: #East)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'AA 12/10/2020 19:37:09'!
test07_movingWhenHeadingWestWorksAsExpected

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: testObjects defaultBackpack in: testObjects defaultRoom at: 2@2 heading: #West .

	playableCharacter
		moveForward;
		moveForward;
		moveBackward;
		rotateRight;
		rotateLeft;
		rotateLeft.

	self assert: (playableCharacter isAt: 1@2 heading: #South)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'AA 12/10/2020 19:37:07'!
test08_canNotCreatePlayableCharacterWhenHeadingIsNotValid

	self
		should: [PlayableCharacter named: 'Luigi' using: testObjects defaultBackpack in: testObjects defaultRoom at: 1@2 heading: #X ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: PlayableCharacter invalidCardinalPointErrorDescription equals: anError messageText ]! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'AA 12/10/2020 19:37:04'!
test09_canTakePortableObjects

	| playableCharacter paper |

	playableCharacter := PlayableCharacter named: 'Luigi' using: testObjects defaultBackpack in: testObjects defaultRoom at: 2@2 heading: #West .
	paper := NoPointsPortableObject named: 'Paper' weighing: 1.
	
	playableCharacter take: paper.
	
	self assert: (playableCharacter backpackIncludes: paper)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'AA 12/10/2020 19:37:01'!
test10_canNotTakeMoreObjectsThanTheBackpackCanCarry

	| playableCharacter paper key |

	playableCharacter := PlayableCharacter named: 'Luigi' using: testObjects defaultBackpack in: testObjects defaultRoom at: 2@2 heading: #West .
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

!PlayableCharacterTest methodsFor: 'tests' stamp: 'AA 12/10/2020 20:33:51'!
test11_cannotMoveForwardCollidingOnStageObject

	| playableCharacter room |

	room := testObjects roomWithStageObjectAt: 1@3.
	playableCharacter := PlayableCharacter named: 'Luigi' using: testObjects defaultBackpack in: room at: 1@2 heading: #North .

	self
		should: [ playableCharacter moveForward ]
		raise: Error
		withMessageText: (Room cannotStepOnPositionErrorDescription: 1@3).

	self assert: (playableCharacter isAt: 1@2 heading: #North)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'AA 12/10/2020 20:33:48'!
test12_cannotMoveBackwardCollidingOnStageObject

	| playableCharacter room |

	room := testObjects roomWithStageObjectAt: 1@1.
	playableCharacter := PlayableCharacter named: 'Luigi' using: testObjects defaultBackpack in: room at: 1@2 heading: #North .

	self
		should: [ playableCharacter moveBackward ]
		raise: Error
		withMessageText: (Room cannotStepOnPositionErrorDescription: 1@1).

	self assert: (playableCharacter isAt: 1@2 heading: #North)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'AA 12/10/2020 20:33:46'!
test13_cannotMoveCollidingOnMapBoundary

	| playableCharacter room position |

	room := testObjects defaultRoom.
	position := room topRight.
	playableCharacter := PlayableCharacter named: 'Luigi' using: testObjects defaultBackpack in: room at: position heading: #North .

	self
		should: [ playableCharacter moveForward ]
		raise: Error
		withMessageText: (Room cannotStepOnPositionErrorDescription: position + (0@1)).

	self assert: (playableCharacter isAt: position heading: #North)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'AA 12/10/2020 20:33:43'!
test14_cannotCreatePlayerOnTopOfStageObject

	| room |

	room := testObjects roomWithStageObjectAt: 1@2.

	self
		should: [ PlayableCharacter named: 'Luigi' using: testObjects defaultBackpack in: room at: 1@2 heading: #North ]
		raise: Error
		withMessageText: (Room cannotStepOnPositionErrorDescription: 1@2).! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'AA 12/10/2020 20:44:45'!
test15_cannotTakeStageObjectFromEmptyPosition

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: testObjects defaultBackpack in: testObjects defaultRoom at: 1@2 heading: #North.

	self
		should: [ playableCharacter take ]
		raise: Error
		withMessageText: (Room cannotTakeStageObjectFromEmptyPosition).! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'AA 12/10/2020 20:44:31'!
test16_cannotTakeStageObjectFromPositionOutOfBoundaries

	| playableCharacter position room |

	room := testObjects defaultRoom.
	position := room topRight.
	playableCharacter := PlayableCharacter named: 'Luigi' using: testObjects defaultBackpack in: room at: position heading: #North.

	self
		should: [ playableCharacter take ]
		raise: Error
		withMessageText: (Room cannotTakeStageObjectFromPositionOutOfBoundaries).! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'AA 12/10/2020 21:09:10'!
test16_takingPortableObjectFromRoomAddsItToBackpack

	| playableCharacter room paper stageObjects |

	paper := NoPointsPortableObject named: 'Paper' weighing: 1.
	stageObjects := Dictionary new.
	stageObjects at: 1@4 put: paper.
	room := testObjects roomWithStageObjects: stageObjects.
	playableCharacter := PlayableCharacter named: 'Luigi' using: testObjects defaultBackpack in: room at: 1@3 heading: #North.
	
	playableCharacter take.

	self assert: (playableCharacter backpackIncludes: paper).
	self deny: (room hasStageItemAt: 1@4).! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'AA 12/10/2020 21:51:00'!
test17_takingNoPortableObjectFromRoomAddsAllStageObjectsToBackpack

	| playableCharacter room stageObjects wardrobe wardrobeContents |

	wardrobe := testObjects wardrobe.
	wardrobeContents := wardrobe contents.
	stageObjects := Dictionary new.
	stageObjects at: 1@4 put: wardrobe.
	room := testObjects roomWithStageObjects: stageObjects.
	playableCharacter := PlayableCharacter named: 'Luigi' using: testObjects defaultBackpack in: room at: 1@3 heading: #North.
	
	playableCharacter take.
	
	wardrobeContents do: [ :aPortableObject | self assert: (playableCharacter backpackIncludes: aPortableObject) ].
	self assert: (room hasStageItemAt: 1@4).! !


!PlayableCharacterTest methodsFor: 'helpers' stamp: 'AA 12/10/2020 19:33:12'!
setUp
	testObjects := TestObjectsStore new.! !


!classDefinition: #RoomTest category: 'ISW1-2020-2C-2doParcial'!
TestCase subclass: #RoomTest
	instanceVariableNames: 'testObjects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!RoomTest methodsFor: 'tests' stamp: 'AA 12/10/2020 18:31:27'!
test01RoomWidthCannotBeZero

	self
		should: [ Room width: 0 height: 10 stageObjects: Dictionary new ]
		raise: Error
		withMessageText: Room invalidWidthErrorDescription.! !

!RoomTest methodsFor: 'tests' stamp: 'AA 12/10/2020 18:31:32'!
test02RoomWidthCannotBeLessThanZero

	self
		should: [ Room width: -5 height: 10 stageObjects: Dictionary new ]
		raise: Error
		withMessageText: Room invalidWidthErrorDescription.! !

!RoomTest methodsFor: 'tests' stamp: 'AA 12/10/2020 18:31:36'!
test03RoomHeightCannotBeZero

	self
		should: [ Room width: 10 height: 0 stageObjects: Dictionary new ]
		raise: Error
		withMessageText: Room invalidHeightErrorDescription.! !

!RoomTest methodsFor: 'tests' stamp: 'AA 12/10/2020 18:31:39'!
test04RoomHeightCannotBeLessThanZero

	self
		should: [ Room width: 10 height: -3 stageObjects: Dictionary new ]
		raise: Error
		withMessageText: Room invalidHeightErrorDescription.! !

!RoomTest methodsFor: 'tests' stamp: 'AA 12/10/2020 18:31:43'!
test05RoomWidthMustBeAnInteger

	self
		should: [ Room width: 0.7 height: 4 stageObjects: Dictionary new ]
		raise: Error
		withMessageText: Room invalidWidthErrorDescription.! !

!RoomTest methodsFor: 'tests' stamp: 'AA 12/10/2020 18:31:47'!
test06RoomHeightMustBeAnInteger

	self
		should: [ Room width: 4 height: 0.7 stageObjects: Dictionary new ]
		raise: Error
		withMessageText: Room invalidHeightErrorDescription.! !

!RoomTest methodsFor: 'tests' stamp: 'AA 12/10/2020 19:30:40'!
test07RoomStoresWidthAndHeight

	| room |
	room := testObjects defaultRoom.

	self assert: 5 equals: room width.
	self assert: 8 equals: room height.! !

!RoomTest methodsFor: 'tests' stamp: 'AA 12/10/2020 19:31:59'!
test08StageObjectsAreWithinLeftBoundary

	self assertStageObjectOutOfBoundaryRaisesError: testObjects positionBeyondLeftBoundary! !

!RoomTest methodsFor: 'tests' stamp: 'AA 12/10/2020 19:31:43'!
test09StageObjectsAreWithinBottomBoundary

	self assertStageObjectOutOfBoundaryRaisesError: testObjects positionBeyondBottomBoundary! !

!RoomTest methodsFor: 'tests' stamp: 'AA 12/10/2020 19:31:45'!
test10StageObjectsAreWithinRightBoundary

	self assertStageObjectOutOfBoundaryRaisesError: testObjects positionBeyondRightBoundary! !

!RoomTest methodsFor: 'tests' stamp: 'AA 12/10/2020 19:31:49'!
test11StageObjectsAreWithinTopBoundary
	
	self assertStageObjectOutOfBoundaryRaisesError: testObjects positionBeyondTopBoundary! !


!RoomTest methodsFor: 'helpers' stamp: 'AA 12/10/2020 19:44:03'!
assertStageObjectOutOfBoundaryRaisesError: anInvalidPosition

	self
		should: [ testObjects roomWithStageObjectAt: anInvalidPosition ]
		raise: Error
		withMessageText: (Room invalidStageObjectPositionAt: anInvalidPosition)! !

!RoomTest methodsFor: 'helpers' stamp: 'AA 12/10/2020 19:30:19'!
setUp
	testObjects := TestObjectsStore new.! !


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

!PlayableCharacter methodsFor: 'initialization' stamp: 'AA 12/10/2020 20:33:09'!
initializeNamed: aName using: aBackpack in: aRoom at: aPosition heading: aMarsRoverHeading 

	aRoom assertPlayableCharacterCanStepOn: aPosition.

	name := aName.
	backpack := aBackpack.
	room := aRoom.
	position := aPosition.
	heading := aMarsRoverHeading! !


!PlayableCharacter methodsFor: 'testing' stamp: 'HAW 12/9/2020 19:43:44'!
backpackIncludes: aPortableObject 
	
	^backpack includes: aPortableObject ! !

!PlayableCharacter methodsFor: 'testing' stamp: 'HAW 7/1/2018 14:25:05'!
isAt: aPosition heading: aCardinalPoint

	^position = aPosition and: [ heading cardinalPoint = aCardinalPoint ]! !


!PlayableCharacter methodsFor: 'moving' stamp: 'AA 12/10/2020 19:59:16'!
moveBackward

	self moveTo: (position - heading forwardPoint)! !

!PlayableCharacter methodsFor: 'moving' stamp: 'AA 12/10/2020 19:59:08'!
moveForward

	self moveTo: (position + heading forwardPoint).! !

!PlayableCharacter methodsFor: 'moving' stamp: 'AA 12/10/2020 20:33:04'!
moveTo: aPosition
	room assertPlayableCharacterCanStepOn: aPosition.
	position := aPosition.! !


!PlayableCharacter methodsFor: 'rotating' stamp: 'HAW 10/11/2019 08:31:55'!
rotateLeft
	
	heading := heading leftHeading! !

!PlayableCharacter methodsFor: 'rotating' stamp: 'HAW 10/11/2019 08:32:04'!
rotateRight
	
	heading := heading rightHeading! !


!PlayableCharacter methodsFor: 'taking objects' stamp: 'AA 12/10/2020 21:45:21'!
take

	room takeStageObjectAt: position + heading forwardPoint for: self.! !

!PlayableCharacter methodsFor: 'taking objects' stamp: 'HAW 12/9/2020 19:28:57'!
take: aPortableObject

	backpack add: aPortableObject.! !

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


!PlayableCharacter class methodsFor: 'instance creation' stamp: 'AA 12/10/2020 19:23:42'!
named: aName using: aBackpack at: aPosition heading: aCardinalPoint 
	
	| newHeading |

	newHeading := self headingFor: aCardinalPoint.
	
	^self new initializeNamed: aName using: aBackpack in: nil at: aPosition heading: newHeading ! !

!PlayableCharacter class methodsFor: 'instance creation' stamp: 'AA 12/10/2020 19:22:50'!
named: aName using: aBackpack in: aRoom at: aPosition heading: aCardinalPoint 
	
	| newHeading |

	newHeading := self headingFor: aCardinalPoint.
	
	^self new initializeNamed: aName using: aBackpack in: aRoom at: aPosition heading: newHeading ! !


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


!classDefinition: #Room category: 'ISW1-2020-2C-2doParcial'!
Object subclass: #Room
	instanceVariableNames: 'width height stageObjects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!Room methodsFor: 'initialization' stamp: 'AA 12/10/2020 18:57:00'!
initializeWithWidth: aWidth andHeight: aHeight andStageObjects: initalStageObjects

	self assertValidWidth: aWidth.
	self assertValidHeight: aHeight.
	
	width := aWidth.
	height := aHeight.
	
	self assertValidStageObjects: initalStageObjects.

	stageObjects := initalStageObjects.! !


!Room methodsFor: 'accessing' stamp: 'AA 12/10/2020 18:42:01'!
bottomLeft
	^ 0@0! !

!Room methodsFor: 'accessing' stamp: 'AA 12/10/2020 18:01:11'!
height
	^ height! !

!Room methodsFor: 'accessing' stamp: 'AA 12/10/2020 21:40:06'!
removeStageObjectAt: aPosition

	stageObjects removeKey: aPosition.! !

!Room methodsFor: 'accessing' stamp: 'AA 12/10/2020 21:51:29'!
takeStageObjectAt: aPosition for: aPlayableCharacter
	
	| stageObject |

	(self isInBounds: aPosition) ifFalse: [ self error: Room cannotTakeStageObjectFromPositionOutOfBoundaries ].
	(self hasStageItemAt: aPosition) ifFalse: [ self error: Room cannotTakeStageObjectFromEmptyPosition ].
	
	stageObject :=  stageObjects at: aPosition.
	stageObject addToPlayableCharacter: aPlayableCharacter.
	stageObject removeFrom: self at: aPosition.
	
	^ stageObject.! !

!Room methodsFor: 'accessing' stamp: 'AA 12/10/2020 18:45:48'!
topRight
	^ (self width - 1)@(self height - 1)! !

!Room methodsFor: 'accessing' stamp: 'AA 12/10/2020 18:01:07'!
width
	^ width! !


!Room methodsFor: 'validations' stamp: 'AA 12/10/2020 21:02:07'!
assertPlayableCharacterCanStepOn: aPosition

	((self hasStageItemAt: aPosition) or: [ self isOutOfBounds: aPosition ]) ifTrue: [ self error: (self class cannotStepOnPositionErrorDescription: aPosition) ].! !

!Room methodsFor: 'validations' stamp: 'AA 12/10/2020 20:14:46'!
assertPositionInBounds: aPosition

	(self isInBounds: aPosition) ifFalse: [ self error: (self class invalidStageObjectPositionAt: aPosition) ]! !

!Room methodsFor: 'validations' stamp: 'AA 12/10/2020 20:14:43'!
assertValidHeight: aHeight

	(self isPositiveInteger: aHeight) ifFalse: [ self error: self class invalidHeightErrorDescription ]! !

!Room methodsFor: 'validations' stamp: 'AA 12/10/2020 20:14:39'!
assertValidStageObjects: stageObjectsToValidate

	stageObjectsToValidate keys do: [ :aPosition | self assertPositionInBounds: aPosition ].! !

!Room methodsFor: 'validations' stamp: 'AA 12/10/2020 20:14:33'!
assertValidWidth: aWidth

	(self isPositiveInteger: aWidth) ifFalse: [ self error: self class invalidWidthErrorDescription ]! !

!Room methodsFor: 'validations' stamp: 'AA 12/10/2020 21:02:07'!
hasStageItemAt: aPosition
	
	^ stageObjects includesKey: aPosition! !

!Room methodsFor: 'validations' stamp: 'AA 12/10/2020 20:13:50'!
isInBounds: aPosition

	^ aPosition
		between: self bottomLeft
		and: self topRight.! !

!Room methodsFor: 'validations' stamp: 'AA 12/10/2020 20:14:25'!
isOutOfBounds: aPosition

	^ (self isInBounds: aPosition) not.! !

!Room methodsFor: 'validations' stamp: 'AA 12/10/2020 20:14:28'!
isPositiveInteger: aNumber

	^ aNumber strictlyPositive and: [ aNumber isInteger ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Room class' category: 'ISW1-2020-2C-2doParcial'!
Room class
	instanceVariableNames: ''!

!Room class methodsFor: 'as yet unclassified' stamp: 'AA 12/10/2020 20:33:30'!
cannotStepOnPositionErrorDescription: aPoint 
	^ 'Cannot step on ', aPoint asString! !

!Room class methodsFor: 'as yet unclassified' stamp: 'AA 12/10/2020 20:45:14'!
cannotTakeStageObjectFromEmptyPosition
	^ 'Cannot take stage object from empty posistion'.! !

!Room class methodsFor: 'as yet unclassified' stamp: 'AA 12/10/2020 20:45:02'!
cannotTakeStageObjectFromPositionOutOfBoundaries
	^ 'Cannot take stage object from position out of boundaries'! !

!Room class methodsFor: 'as yet unclassified' stamp: 'AA 12/10/2020 17:33:57'!
invalidHeightErrorDescription
	^ 'Invalid height.'! !

!Room class methodsFor: 'as yet unclassified' stamp: 'AA 12/10/2020 18:24:52'!
invalidStageObjectPositionAt: aPoint 
	^ aPoint asString, ' is not a valid position for this room.'! !

!Room class methodsFor: 'as yet unclassified' stamp: 'AA 12/10/2020 17:34:01'!
invalidWidthErrorDescription
	^ 'Invalid width.'! !

!Room class methodsFor: 'as yet unclassified' stamp: 'AA 12/10/2020 18:26:21'!
width: aWidth height: aHeight stageObjects: stageObjects
	^ self new initializeWithWidth: aWidth andHeight: aHeight andStageObjects: stageObjects.! !


!classDefinition: #StageObject category: 'ISW1-2020-2C-2doParcial'!
Object subclass: #StageObject
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!


!classDefinition: #NoPortableObject category: 'ISW1-2020-2C-2doParcial'!
StageObject subclass: #NoPortableObject
	instanceVariableNames: 'name stageObjects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!NoPortableObject methodsFor: 'as yet unclassified' stamp: 'AA 12/10/2020 21:52:25'!
addToPlayableCharacter: aPlayableCharacter

	self contents do: [ :aPortableObject |
		aPlayableCharacter take: aPortableObject.
		self removePortableObject: aPortableObject.
	]! !

!NoPortableObject methodsFor: 'as yet unclassified' stamp: 'AA 12/10/2020 21:24:17'!
contents
	
	| contents |

	contents := OrderedCollection new.
	
	stageObjects do: [ :stageObject | contents addAll: stageObject contents ].
	
	^ contents copy.
	! !

!NoPortableObject methodsFor: 'as yet unclassified' stamp: 'AA 12/10/2020 21:11:25'!
initializeNamed: aName carrying: initialStageObjects.
	name := aName.
	stageObjects := initialStageObjects.! !

!NoPortableObject methodsFor: 'as yet unclassified' stamp: 'AA 12/10/2020 21:34:07'!
noPortableObjects
	^ stageObjects select: [ :aStageObject | aStageObject isMemberOf: NoPortableObject ]
	! !

!NoPortableObject methodsFor: 'as yet unclassified' stamp: 'AA 12/10/2020 21:53:39'!
removeFrom: aRoom at: aPosition
	" Only portable object need to be removed from the room"! !

!NoPortableObject methodsFor: 'as yet unclassified' stamp: 'AA 12/10/2020 21:33:00'!
removePortableObject: aPortableObject
	
	stageObjects remove: aPortableObject ifAbsent: [
		self noPortableObjects do: [ :aNoPortableObject | aNoPortableObject removePortableObject: aPortableObject ]
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NoPortableObject class' category: 'ISW1-2020-2C-2doParcial'!
NoPortableObject class
	instanceVariableNames: ''!

!NoPortableObject class methodsFor: 'as yet unclassified' stamp: 'AA 12/10/2020 21:49:32'!
named: aName carrying: initialStageObjects
	^ self new initializeNamed: aName carrying: initialStageObjects.
! !


!classDefinition: #PortableObject category: 'ISW1-2020-2C-2doParcial'!
StageObject subclass: #PortableObject
	instanceVariableNames: 'name weight'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!PortableObject methodsFor: 'testing' stamp: 'FRT 10/11/2020 17:54:20'!
doesItAddPoints

	self subclassResponsibility	! !


!PortableObject methodsFor: 'adding' stamp: 'HAW 10/18/2020 12:28:24'!
assertCanAddTo: aBackpack

	self subclassResponsibility	! !


!PortableObject methodsFor: 'accessing' stamp: 'AA 12/10/2020 21:44:25'!
addToPlayableCharacter: aPlayableCharacter
	aPlayableCharacter take: self! !

!PortableObject methodsFor: 'accessing' stamp: 'AA 12/10/2020 21:23:13'!
contents

	^ OrderedCollection with: self.! !

!PortableObject methodsFor: 'accessing' stamp: 'AA 12/10/2020 21:39:35'!
removeFrom: aRoom at: aPosition
	aRoom removeStageObjectAt: aPosition ! !

!PortableObject methodsFor: 'accessing' stamp: 'FRT 10/11/2020 18:53:51'!
weight

	^ weight! !


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


!classDefinition: #TestObjectsStore category: 'ISW1-2020-2C-2doParcial'!
Object subclass: #TestObjectsStore
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!TestObjectsStore methodsFor: 'as yet unclassified' stamp: 'AA 12/10/2020 19:32:31'!
defaultBackpack

	^ Backpack containingUpTo: 100 limitingPointsTo: 100 ! !

!TestObjectsStore methodsFor: 'as yet unclassified' stamp: 'AA 12/10/2020 19:43:26'!
defaultRoom

	^ Room
		width: self validRoomWidth
		height: self validRoomHeight
		stageObjects: Dictionary new.! !

!TestObjectsStore methodsFor: 'as yet unclassified' stamp: 'AA 12/10/2020 19:28:35'!
positionBeyondBottomBoundary
	^ 0@-1! !

!TestObjectsStore methodsFor: 'as yet unclassified' stamp: 'AA 12/10/2020 19:29:28'!
positionBeyondLeftBoundary
	^ -1@0! !

!TestObjectsStore methodsFor: 'as yet unclassified' stamp: 'AA 12/10/2020 19:29:35'!
positionBeyondRightBoundary
	^ (self validRoomWidth)@0! !

!TestObjectsStore methodsFor: 'as yet unclassified' stamp: 'AA 12/10/2020 19:29:43'!
positionBeyondTopBoundary
	^ 0@(self validRoomHeight)! !

!TestObjectsStore methodsFor: 'as yet unclassified' stamp: 'AA 12/10/2020 20:57:26'!
roomWithStageObjectAt: aPosition

	| stageObjects |

	stageObjects := Dictionary new.
	stageObjects at: aPosition put: StageObject new.

	^ self roomWithStageObjects: stageObjects.! !

!TestObjectsStore methodsFor: 'as yet unclassified' stamp: 'AA 12/10/2020 20:57:12'!
roomWithStageObjects: stageObjects

	^ Room
		width: self validRoomWidth
		height: self validRoomHeight
		stageObjects: stageObjects.! !

!TestObjectsStore methodsFor: 'as yet unclassified' stamp: 'AA 12/10/2020 19:29:11'!
validRoomHeight
	^ 8! !

!TestObjectsStore methodsFor: 'as yet unclassified' stamp: 'AA 12/10/2020 19:29:07'!
validRoomWidth
	^ 5! !

!TestObjectsStore methodsFor: 'as yet unclassified' stamp: 'AA 12/10/2020 21:16:37'!
wardrobe

	|   paper pen pencil wardrobe box boxContents wardrobeContents |
	
	paper := NoPointsPortableObject named: 'Paper' weighing: 1.
	pencil := NoPointsPortableObject named: 'Pencil' weighing: 2.
	pen := NoPointsPortableObject named: 'Pen' weighing: 3.
		
	boxContents := OrderedCollection with: paper with: pencil.
	box := NoPortableObject named: 'box' carrying: boxContents.
	
	wardrobeContents := OrderedCollection with: box with: pen.
	wardrobe := NoPortableObject named: 'wardrobe' carrying: wardrobeContents.
	
	^ wardrobe! !

PlayableCharacter initialize!