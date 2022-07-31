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

!PlayableCharacterTest methodsFor: 'tests' stamp: 'as 12/10/2020 19:52:57'!
test09_canTakePortableObjects

	| playableCharacter paper objects room|
	
	paper := NoPointsPortableObject named: 'Paper' weighing: 1.

	objects := Dictionary new
			at: 1@2 put: paper;
			yourself.

	room := Room of: 10 for: 10 withObjects: objects.

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 2@2 heading: #West in: room.
	
	playableCharacter take: paper.
	
	self assert: (playableCharacter backpackIncludes: paper)
	
! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'as 12/10/2020 19:57:13'!
test10_canNotTakeMoreObjectsThanTheBackpackCanCarry

	| playableCharacter paper key objects room|
	
	paper := NoPointsPortableObject named: 'Paper' weighing: 100.
	key := NoPointsPortableObject named: 'Key' weighing: 1.
	
	objects := Dictionary new
			at: 2@2 put: paper;
			at: 1@2 put: key;
			yourself.

	room := Room of: 10 for: 10 withObjects: objects.

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 3@2 heading: #West in: room.

	playableCharacter take: paper.
	playableCharacter moveForward.
	
	self 
		should: [ playableCharacter take: key ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: Backpack maxWeightExceededErrorDescription equals: anError messageText.
			self assert: (playableCharacter backpackIncludes: paper).
			self deny: (playableCharacter backpackIncludes: key) ]
	
	! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'as 12/10/2020 20:41:43'!
test11_takingNonPortableObjectsThatDoesntContainPortableObjectsDoesntAddObjectToBackpack

	| room objects playableCharacter table|
	
	table := NonPortableObject named: 'Table' containing: OrderedCollection new.
	objects := Dictionary new
			at: 1@2 put: table;
			yourself.

	room := Room of: 10 for: 10 withObjects: objects.
	
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@1 heading: #North in: room. 
	
	playableCharacter take: table.
	
	self deny: (playableCharacter backpackIncludes: table)
	
	
	
	
	! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'as 12/10/2020 19:28:49'!
test12_canNotTakePortableObjectsThatAreNotInAdjacentPosition

	| room objects playableCharacter key|
	
	key := NoPointsPortableObject named: 'Key' weighing: 1.
	objects := Dictionary new
			at: 5@5 put: key;
			yourself.

	room := Room of: 10 for: 10 withObjects: objects.
	
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@1 heading: #North in: room. 
	
	self 
		should: [ playableCharacter take: key ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: PlayableCharacter cannotTakeDesiredObjectErrorDescription equals: anError messageText.
			self assert: (room roomContains: key at: 5@5) ]
	
	! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'as 12/10/2020 19:59:04'!
test13_canNotTakePortableObjectsThatAreInAdjacentPositionButNotFacedByPlayableCharacter

	| room objects playableCharacter key|
	
	key := NoPointsPortableObject named: 'Key' weighing: 1.
	objects := Dictionary new
			at: 2@1 put: key;
			yourself.

	room := Room of: 10 for: 10 withObjects: objects.
	
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@1 heading: #North in: room. 
	
	self 
		should: [ playableCharacter take: key ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: PlayableCharacter cannotTakeDesiredObjectErrorDescription equals: anError messageText.
			self assert: (room roomContains: key at: 2@1) ]
	
	! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'as 12/10/2020 20:07:08'!
test14_canTakePortableObjectsThatAreInAdjacentPositionAndFacedByPlayableCharacter

	| room objects playableCharacter key|
	
	key := NoPointsPortableObject named: 'Key' weighing: 1.
	objects := Dictionary new
			at: 2@1 put: key;
			yourself.

	room := Room of: 10 for: 10 withObjects: objects.
	
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@1 heading: #East in: room. 
	
	playableCharacter take: key.
	
	self deny: (room roomContains: key).
	self assert: (playableCharacter backpackIncludes: key)
	! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'as 12/10/2020 20:13:27'!
test15_cannotTakePortableObjectsThatAreNotInRoom

	| room objects playableCharacter key|
	
	key := NoPointsPortableObject named: 'Key' weighing: 1.
	objects := Dictionary new.
	room := Room of: 10 for: 10 withObjects: objects.
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@1 heading: #East in: room. 
	
	self 
		should: [ playableCharacter take: key ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: PlayableCharacter cannotTakeDesiredObjectErrorDescription equals: anError messageText.
			self deny: (playableCharacter backpackIncludes: key)
	 ]
	! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'as 12/10/2020 20:33:07'!
test16_canTakePortableObjectContainedInAReachableNonPortableObject

	| room objects playableCharacter key table|
	
	key := NoPointsPortableObject named: 'Key' weighing: 1.
	table := NonPortableObject named: 'Table' containing: (OrderedCollection with: key).
	objects := Dictionary new
			at: 2@1 put: table;
			yourself.
	room := Room of: 10 for: 10 withObjects: objects.
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@1 heading: #East in: room. 
	
	playableCharacter take: table.
	
	self assert: (playableCharacter backpackIncludes: key).
	self deny: (table contains: key)
	! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'as 12/10/2020 21:11:44'!
test17_canTakePortableObjectContainedInATwoLevelCompositionOfReachablePortableObject

	| room objects playableCharacter key table drawer|
	
	key := NoPointsPortableObject named: 'Key' weighing: 1.
	drawer := NonPortableObject named: 'Drawer' containing: (OrderedCollection with: key).
	table := NonPortableObject named: 'Table' containing: (OrderedCollection with: drawer).
	objects := Dictionary new
			at: 2@1 put: table;
			yourself.
	room := Room of: 10 for: 10 withObjects: objects.
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@1 heading: #East in: room. 
	
	playableCharacter take: table.
	
	self assert: (playableCharacter backpackIncludes: key).
	self deny: (drawer contains: key).
	self deny: (table contains: key)
	! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'as 12/10/2020 21:54:52'!
test18_canTakeAllThePortableObjectsContainedInNonPortableObjectIfTheBackpackCanCarryThem

	| room objects playableCharacter |
	
	"key := NoPointsPortableObject named: 'Key' weighing: 1.
	paper := NoPointsPortableObject named: 'Paper' weighing: 1.
	table := NonPortableObject named: 'Table' containing: (OrderedCollection with: key with: paper)."
	
	objects := Dictionary new
			at: 2@1 put: self twoObjectTable ;
			yourself.
	room := Room of: 10 for: 10 withObjects: objects.
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@1 heading: #East in: room. 
	
	playableCharacter take: self twoObjectTable .
	
	self deny: (self twoObjectTable contains: self key).
	self deny: (self twoObjectTable contains: self paper).
	self assert: (playableCharacter backpackIncludes: self key).
	self assert: (playableCharacter backpackIncludes: self paper).
	
	"no me dio el tiempo para entender porque falla este test, con los objetos creados dentro del test falla agregar ambos objetos
	
	si hubiese tenido tiempo crearia mensajes de creacion para todos los objetos recurrentes de los tests en la categoria test objects y sacaria el codigo repetido
	
	"

	! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'as 12/10/2020 21:51:08'!
test19_cannotTakeAllThePortableObjectsContainedInNonPortableObjectIfTheBackpackCannotCarryThemAll

	| room objects playableCharacter key table paper|
	
	key := NoPointsPortableObject named: 'Key' weighing: 1.
	paper := NoPointsPortableObject named: 'Paper' weighing: 100.
	table := NonPortableObject named: 'Table' containing: (OrderedCollection with: key with: paper).
	
	objects := Dictionary new
			at: 2@1 put: table;
			yourself.
	room := Room of: 10 for: 10 withObjects: objects.
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@1 heading: #East in: room. 
	
	playableCharacter take: table.
	
	self deny: (table contains: key).
	self assert: (table contains: paper).
	self assert: (playableCharacter backpackIncludes: key).
	self deny: (playableCharacter backpackIncludes: paper).

	! !


!PlayableCharacterTest methodsFor: 'test objects' stamp: 'HAW 12/9/2020 13:53:29'!
defaultBackpack

	^ Backpack containingUpTo: 100 limitingPointsTo: 100 ! !

!PlayableCharacterTest methodsFor: 'test objects' stamp: 'as 12/10/2020 21:47:06'!
key
	
	^NoPointsPortableObject named: 'Key' weighing: 1.! !

!PlayableCharacterTest methodsFor: 'test objects' stamp: 'as 12/10/2020 21:47:34'!
paper
	^NoPointsPortableObject named: 'Paper' weighing: 100.! !

!PlayableCharacterTest methodsFor: 'test objects' stamp: 'as 12/10/2020 21:48:05'!
twoObjectTable
	^NonPortableObject named: 'Table' containing: (OrderedCollection with: self key with: self paper).! !


!classDefinition: #RoomTest category: 'ISW1-2020-2C-2doParcial'!
TestCase subclass: #RoomTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!RoomTest methodsFor: 'tests' stamp: 'as 12/10/2020 21:45:43'!
test01CannotCreateRoomWithNProportionSmallerThan1
		
	self
		should: [ Room of: 0 for: 10 withObjects: Dictionary new ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Room invalidRoomProportionsErrorDescription ]
	! !

!RoomTest methodsFor: 'tests' stamp: 'as 12/10/2020 18:31:10'!
test02CannotCreateRoomWithMProportionSmallerThan1
		
	self
		should: [ Room of: 10 for: 0 withObjects: Dictionary new ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Room invalidRoomProportionsErrorDescription ]
	! !

!RoomTest methodsFor: 'tests' stamp: 'as 12/10/2020 18:30:58'!
test03CannotCreateRoomWithNonIntegerProportions
		
	self
		should: [ Room of: 1.6 for: 10 withObjects: Dictionary new]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Room invalidRoomProportionsErrorDescription ]
	! !

!RoomTest methodsFor: 'tests' stamp: 'as 12/10/2020 18:30:32'!
test04PlayableCharacterIsCreatedInAPositionInsideHisRoomProportions

	| room |
			
	room := Room of: 10 for: 10 withObjects: Dictionary new.
	
	self
		should: [ PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@15 heading: #North in: room ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = PlayableCharacter invalidInitialPositionErrorDescription ]
	
	! !

!RoomTest methodsFor: 'tests' stamp: 'as 12/10/2020 18:29:13'!
test05PlayableCharacterIsCreatedInAPositionNotOccupiedByAnObject
	
	| room objects|
	
	objects := Dictionary new
			at: 1@2 put: (NoPointsPortableObject named: 'help-wanted sign' weighing: 1);
			yourself.
			
	room := Room of: 10 for: 10 withObjects: objects.
	
	self
		should: [ PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #North in: room ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = PlayableCharacter invalidInitialPositionErrorDescription ]
	
	! !

!RoomTest methodsFor: 'tests' stamp: 'as 12/10/2020 18:51:54'!
test06PlayableCharacterCannotMoveForwardsToAPositionOccupiedByAnObject
	
	| room objects playableCharacter|
	
	objects := Dictionary new
			at: 1@2 put: (NoPointsPortableObject named: 'help-wanted sign' weighing: 1);
			yourself.
			
	room := Room of: 10 for: 10 withObjects: objects.
	
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@1 heading: #North in: room. 
	
	self
		should: [ playableCharacter moveForward ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = PlayableCharacter cannotMoveToDesiredPositionErrorDescription.
			self assert: (playableCharacter isAt: 1@1 heading: #North) ]
	
	! !

!RoomTest methodsFor: 'tests' stamp: 'as 12/10/2020 18:47:28'!
test07PlayableCharacterCannotMoveBackwardsToAPositionOccupiedByAnObject
	
	| room objects playableCharacter|
	
	objects := Dictionary new
			at: 1@2 put: (NoPointsPortableObject named: 'help-wanted sign' weighing: 1);
			yourself.
			
	room := Room of: 10 for: 10 withObjects: objects.
	
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@3 heading: #North in: room. 
	
	self
		should: [ playableCharacter moveBackward ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = PlayableCharacter cannotMoveToDesiredPositionErrorDescription.
			self assert: (playableCharacter isAt: 1@3 heading: #North) ]
	
	! !

!RoomTest methodsFor: 'tests' stamp: 'as 12/10/2020 18:52:40'!
test08PlayableCharacterCanOnlyMoveForwardsToAPositionInsideHisRoomProportions
	
	| room objects playableCharacter|
	
	objects := Dictionary new.
			
	room := Room of: 10 for: 10 withObjects: objects.
	
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 0@0 heading: #South in: room. 
	
	self
		should: [ playableCharacter moveForward ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = PlayableCharacter cannotMoveToDesiredPositionErrorDescription.
			self assert: (playableCharacter isAt: 0@0 heading: #South) ]
	
	! !

!RoomTest methodsFor: 'tests' stamp: 'as 12/10/2020 19:13:41'!
test09CannotCreateARoomWithObjectsNotInsideTheRoomsProportions
	
	| room objects playableCharacter|
	
	objects := Dictionary new
			at: 100@100 put: (NoPointsPortableObject named: 'help-wanted sign' weighing: 1);
			yourself.
			
	self
		should: [room := Room of: 10 for: 10 withObjects: objects ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Room invalidRoomObjectsCreationErrorMessage.]
	
	! !


!RoomTest methodsFor: 'test objects' stamp: 'as 12/10/2020 18:12:53'!
defaultBackpack

	^ Backpack containingUpTo: 100 limitingPointsTo: 100 ! !


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

!PlayableCharacter methodsFor: 'initialization' stamp: 'as 12/10/2020 17:59:37'!
initializeNamed: aName using: aBackpack at: aPosition heading: aMarsRoverHeading in: aRoom

	name := aName.
	backpack := aBackpack.
	position := aPosition.
	heading := aMarsRoverHeading.
	room := aRoom ! !


!PlayableCharacter methodsFor: 'testing' stamp: 'HAW 12/9/2020 19:43:44'!
backpackIncludes: aPortableObject 
	
	^backpack includes: aPortableObject ! !

!PlayableCharacter methodsFor: 'testing' stamp: 'HAW 7/1/2018 14:25:05'!
isAt: aPosition heading: aCardinalPoint

	^position = aPosition and: [ heading cardinalPoint = aCardinalPoint ]! !


!PlayableCharacter methodsFor: 'moving' stamp: 'as 12/10/2020 18:59:08'!
moveBackward
	
	| nextPosition |
	
	nextPosition := position - heading forwardPoint.
	
	self validatePlayableCharacterCanMoveTo: nextPosition.
	
	position := nextPosition.! !

!PlayableCharacter methodsFor: 'moving' stamp: 'as 12/10/2020 18:58:50'!
moveForward
	
	| nextPosition |
	
	nextPosition := position + heading forwardPoint.
	
	self validatePlayableCharacterCanMoveTo: nextPosition.
	
	position := nextPosition.! !


!PlayableCharacter methodsFor: 'rotating' stamp: 'HAW 10/11/2019 08:31:55'!
rotateLeft
	
	heading := heading leftHeading! !

!PlayableCharacter methodsFor: 'rotating' stamp: 'HAW 10/11/2019 08:32:04'!
rotateRight
	
	heading := heading rightHeading! !


!PlayableCharacter methodsFor: 'taking objects' stamp: 'as 12/10/2020 19:41:30'!
take: aStageObject

	aStageObject takeByAPlayableCharacter: self.
! !


!PlayableCharacter methodsFor: 'taking private operations' stamp: 'as 12/10/2020 21:31:13'!
takePortableObject: aPortableObject

	self validatePositionOf: aPortableObject.
	room takeObject: aPortableObject.
	backpack add: aPortableObject ! !


!PlayableCharacter methodsFor: 'validation' stamp: 'as 12/10/2020 18:58:24'!
validatePlayableCharacterCanMoveTo: aPosition

	(room isPositionValidForPlayableCharacter: aPosition) ifFalse: [^self error: self class cannotMoveToDesiredPositionErrorDescription ].! !

!PlayableCharacter methodsFor: 'validation' stamp: 'as 12/10/2020 21:30:22'!
validatePositionOf: aPortableObject
	(room object: aPortableObject isAtPosition: position + heading forwardPoint ) ifFalse: [self error: self class cannotTakeDesiredObjectErrorDescription ].! !

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


!PlayableCharacter class methodsFor: 'instance creation' stamp: 'as 12/10/2020 19:49:24'!
named: aName using: aBackpack at: aPosition heading: aCardinalPoint 
	
	| newHeading room|

	newHeading := self headingFor: aCardinalPoint.
	room := Room of: 10 for: 10 withObjects: Dictionary new.
	
	^self new initializeNamed: aName using: aBackpack at: aPosition heading: newHeading in: room. ! !

!PlayableCharacter class methodsFor: 'instance creation' stamp: 'as 12/10/2020 18:45:11'!
named: aName using: aBackpack at: aPosition heading: aCardinalPoint in: aRoom
	
	| newHeading |

	newHeading := self headingFor: aCardinalPoint.
	
	(aRoom isPositionValidForPlayableCharacter: aPosition) ifFalse: [^self error: self invalidInitialPositionErrorDescription ]. 
	
	^self new initializeNamed: aName using: aBackpack at: aPosition heading: newHeading in: aRoom.! !


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


!PlayableCharacter class methodsFor: 'CATEGORIZAR' stamp: 'as 12/10/2020 18:39:10'!
cannotMoveToDesiredPositionErrorDescription
	^'The playable character cannot move to the desired position!!'! !

!PlayableCharacter class methodsFor: 'CATEGORIZAR' stamp: 'as 12/10/2020 19:24:32'!
cannotTakeDesiredObjectErrorDescription
	^'The playable character cannot take the desired object!!'! !

!PlayableCharacter class methodsFor: 'CATEGORIZAR' stamp: 'as 12/10/2020 19:31:33'!
cannotTakeNonPortableObjectErrorDescription
	^'The playable character cannot take a non portable object!!'! !

!PlayableCharacter class methodsFor: 'CATEGORIZAR' stamp: 'as 12/10/2020 18:01:51'!
invalidInitialPositionErrorDescription
	^'The playable characters position is invalid for his room!!'! !


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
	instanceVariableNames: 'MProportion NProportion roomObjects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!Room methodsFor: 'initialization' stamp: 'as 12/10/2020 18:29:23'!
intitializeWithProportions: Nproportion for: Mproportion withObjects: aDictionaryOfRoomObjects
	
	NProportion := Nproportion.
	MProportion := Mproportion.
	roomObjects := aDictionaryOfRoomObjects.! !


!Room methodsFor: 'assertions' stamp: 'as 12/10/2020 21:34:28'!
isPositionValidForPlayableCharacter: aPosition
	
	^ (self positionIsInsideRoomProportions: aPosition) and: [ (self positionOccupiedByObject: aPosition) not].! !

!Room methodsFor: 'assertions' stamp: 'as 12/10/2020 21:32:33'!
object: aPortableObject isAtPosition: aPosition

	^ (roomObjects at: aPosition ifAbsent: [^false]) containsObject: aPortableObject.! !

!Room methodsFor: 'assertions' stamp: 'as 12/10/2020 19:01:00'!
positionIsInsideRoomProportions: aPosition

	^ (aPosition x between: 0 and: (NProportion - 1)) and: [(aPosition y between: 0 and: (MProportion - 1))] ! !

!Room methodsFor: 'assertions' stamp: 'as 12/10/2020 21:34:12'!
positionOccupiedByObject: aPosition

	 ^ roomObjects includesKey: aPosition 
	! !

!Room methodsFor: 'assertions' stamp: 'as 12/10/2020 20:06:26'!
roomContains: anObject
	
	^roomObjects includes: anObject! !

!Room methodsFor: 'assertions' stamp: 'as 12/10/2020 21:39:22'!
roomContains: anObject at: aPosition
	
	^ (self objectAtPosition: aPosition) = anObject.! !


!Room methodsFor: 'actions' stamp: 'as 12/10/2020 21:37:19'!
removeObject: aPortableObject
	
	roomObjects removeKey: (self positionOf: aPortableObject) .! !

!Room methodsFor: 'actions' stamp: 'as 12/10/2020 21:34:56'!
takeObject: aPortableObject

	aPortableObject takeFromRoom: self.! !


!Room methodsFor: 'queries' stamp: 'as 12/10/2020 21:38:46'!
objectAtPosition: aPosition
	^(roomObjects at: aPosition ifAbsent: [^nil])! !

!Room methodsFor: 'queries' stamp: 'as 12/10/2020 21:36:54'!
positionOf: aPortableObject
	^roomObjects keyAtValue: aPortableObject! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Room class' category: 'ISW1-2020-2C-2doParcial'!
Room class
	instanceVariableNames: ''!

!Room class methodsFor: 'initialization' stamp: 'as 12/10/2020 19:21:28'!
of: Nproportion for: Mproportion withObjects: roomObjects
	
	self validateProportions: Nproportion and: Mproportion.
	
	self validateRoomObjects: roomObjects ForRoomWithProportions: Nproportion and: Mproportion.
		
	^ self new intitializeWithProportions: Nproportion for: Mproportion withObjects: roomObjects.
	! !


!Room class methodsFor: 'as yet unclassified' stamp: 'as 12/10/2020 19:14:02'!
invalidRoomObjectsCreationErrorMessage
	^'The room objects are invalid for this room!!'! !

!Room class methodsFor: 'as yet unclassified' stamp: 'as 12/10/2020 17:41:40'!
invalidRoomProportionsErrorDescription
	^'The room proportions are invalid!!'! !

!Room class methodsFor: 'as yet unclassified' stamp: 'as 12/10/2020 19:16:26'!
positionIsInsideRoomProportions: aPosition for: nProportion and: mProportion

	^ (aPosition x between: 0 and: (nProportion - 1)) and: [(aPosition y between: 0 and: (mProportion - 1))] ! !

!Room class methodsFor: 'as yet unclassified' stamp: 'as 12/10/2020 19:19:57'!
validateProportions: Nproportion and: Mproportion

	(Nproportion < 1 or: [ Mproportion < 1 ]) ifTrue: [^ self error: self invalidRoomProportionsErrorDescription ].
	
	(Nproportion isInteger not or: [ Mproportion isInteger not ]) ifTrue: [^ self error: self invalidRoomProportionsErrorDescription ].! !

!Room class methodsFor: 'as yet unclassified' stamp: 'as 12/10/2020 19:21:01'!
validateRoomObjects: roomObjects ForRoomWithProportions: Nproportion and: Mproportion

	(roomObjects keys allSatisfy: [:aPosition | self positionIsInsideRoomProportions: aPosition for: Nproportion and: Mproportion]) ifFalse: [^ self error: self invalidRoomObjectsCreationErrorMessage ].! !


!classDefinition: #StageObject category: 'ISW1-2020-2C-2doParcial'!
Object subclass: #StageObject
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!StageObject methodsFor: 'actions' stamp: 'as 12/10/2020 19:33:50'!
addTo: aBackpack
	self subclassResponsibility ! !

!StageObject methodsFor: 'actions' stamp: 'as 12/10/2020 19:36:43'!
takeByAPlayableCharacter: aPlayableCharacter
	self subclassResponsibility ! !


!StageObject methodsFor: 'queries' stamp: 'as 12/10/2020 20:45:54'!
containsObject: aStageObject

	self subclassResponsibility ! !


!classDefinition: #NonPortableObject category: 'ISW1-2020-2C-2doParcial'!
StageObject subclass: #NonPortableObject
	instanceVariableNames: 'name objects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!NonPortableObject methodsFor: 'private operations' stamp: 'as 12/10/2020 20:58:44'!
addContainer: aContainer! !

!NonPortableObject methodsFor: 'private operations' stamp: 'as 12/10/2020 20:57:05'!
removeObject: aPortableObject
	
	objects remove: aPortableObject ! !

!NonPortableObject methodsFor: 'private operations' stamp: 'as 12/10/2020 21:18:11'!
takeByAPlayableCharacter: aPlayableCharacter
	
	objects do: [:aContainedObject | aPlayableCharacter take: aContainedObject]! !

!NonPortableObject methodsFor: 'private operations' stamp: 'as 12/10/2020 20:30:48'!
takeContainedObjectsBy: aPlayableCharacter
	objects do: [:object | aPlayableCharacter take: object]! !


!NonPortableObject methodsFor: 'queries' stamp: 'as 12/10/2020 20:29:17'!
contains: aPortableObject
	^objects includes: aPortableObject! !

!NonPortableObject methodsFor: 'queries' stamp: 'as 12/10/2020 20:47:21'!
containsObject: aStageObject
	
	^objects anySatisfy: [:object | object containsObject: aStageObject].! !


!NonPortableObject methodsFor: 'initialization' stamp: 'as 12/10/2020 20:58:34'!
initializeNamed: aName containing: stageObjects
	
	name := aName.
	objects := stageObjects.
	
	objects do: [:object | object addContainer: self]! !


!NonPortableObject methodsFor: 'actions' stamp: 'as 12/10/2020 19:36:22'!
addTo: aBackpack
	
	^self error: self class cannotTakeNonPortableObjects. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NonPortableObject class' category: 'ISW1-2020-2C-2doParcial'!
NonPortableObject class
	instanceVariableNames: ''!

!NonPortableObject class methodsFor: 'as yet unclassified' stamp: 'as 12/10/2020 19:35:02'!
cannotTakeNonPortableObjects
	^'Cannot take non portable objects!!'! !

!NonPortableObject class methodsFor: 'as yet unclassified' stamp: 'as 12/10/2020 20:22:50'!
named: aName containing: stageObjects
	
	^ self new initializeNamed: aName containing: stageObjects! !


!classDefinition: #PortableObject category: 'ISW1-2020-2C-2doParcial'!
StageObject subclass: #PortableObject
	instanceVariableNames: 'name weight container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!PortableObject methodsFor: 'testing' stamp: 'FRT 10/11/2020 17:54:20'!
doesItAddPoints

	self subclassResponsibility	! !


!PortableObject methodsFor: 'adding' stamp: 'HAW 10/18/2020 12:28:24'!
assertCanAddTo: aBackpack

	self subclassResponsibility	! !


!PortableObject methodsFor: 'accessing' stamp: 'FRT 10/11/2020 18:53:51'!
weight

	^ weight! !


!PortableObject methodsFor: 'private operations' stamp: 'as 12/10/2020 20:59:03'!
addContainer: aContainer
	container := aContainer ! !

!PortableObject methodsFor: 'private operations' stamp: 'as 12/10/2020 19:37:56'!
takeByAPlayableCharacter: aPlayableCharacter
	
	aPlayableCharacter takePortableObject: self.! !

!PortableObject methodsFor: 'private operations' stamp: 'as 12/10/2020 21:08:19'!
takeFromRoom: aRoom
	
	container ifNil: [aRoom removeObject: self].
	container ifNotNil: [container removeObject: self]! !


!PortableObject methodsFor: 'queries' stamp: 'as 12/10/2020 20:46:48'!
containsObject: aStageObject
	
	^ self = aStageObject ! !


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