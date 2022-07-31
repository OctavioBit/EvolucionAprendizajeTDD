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


!classDefinition: #NonPortableObjectTest category: 'ISW1-2020-2C-2doParcial'!
TestCase subclass: #NonPortableObjectTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!NonPortableObjectTest methodsFor: 'tests' stamp: 'AM 12/10/2020 19:31:53'!
test01NonPortableObjectHasNoStageObjects

	| wardrobe |
	
	wardrobe := NonPortableObject named: 'armario'.
	
	self assert: wardrobe isEmpty.! !

!NonPortableObjectTest methodsFor: 'tests' stamp: 'AM 12/10/2020 19:35:48'!
test02NonPortableObjectCanHaveOneStageObject

	| wardrobe scarf |
	
	wardrobe := NonPortableObject named: 'armario'.
	scarf := NoPointsPortableObject named: 'bufanda' weighing: 10.

	wardrobe add: scarf.
	
	self deny: wardrobe isEmpty.
	self assert: wardrobe stageObjects equals: {scarf} asOrderedCollection.! !

!NonPortableObjectTest methodsFor: 'tests' stamp: 'AM 12/10/2020 21:47:02'!
test03NonPortableObjectCanHaveMoreThanOneStageObjects

	| wardrobe key scarf drawer |
	
	wardrobe := NonPortableObject named: 'armario'.
	
	scarf := PointsPortableObject named: 'bufanda' weighing: 10 worth: 8.
	drawer := NonPortableObject named: 'cajon'.
	key := NoPointsPortableObject named: 'llave' weighing: 10.

	wardrobe add: scarf; add: drawer; add: key.
	
	self assert: wardrobe stageObjects equals: {scarf. drawer. key} asOrderedCollection.! !


!classDefinition: #PlayableCharacterTest category: 'ISW1-2020-2C-2doParcial'!
TestCase subclass: #PlayableCharacterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!PlayableCharacterTest methodsFor: 'tests' stamp: 'AM 12/10/2020 18:49:13'!
test01_forwardWhenHeadingNorthIncrementsYCoordinate

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #North playingIn: self .

	playableCharacter moveForward.

	self assert: (playableCharacter isAt: 1@3 heading: #North)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'AM 12/10/2020 18:49:12'!
test02_backwardWhenHeadingNorthDecrementsYCoordinate

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #North playingIn: self .

	playableCharacter moveBackward.

	self assert: (playableCharacter isAt: 1@1 heading: #North)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'AM 12/10/2020 18:49:12'!
test03_rotateRightWhenHeadingNorthHeadsEast

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #North playingIn: self .

	playableCharacter rotateRight.

	self assert: (playableCharacter isAt: 1@2 heading: #East)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'AM 12/10/2020 18:49:13'!
test04_rotateLeftWhenHeadingNorthHeadsWest

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #North playingIn: self .

	playableCharacter rotateLeft.

	self assert: (playableCharacter isAt: 1@2 heading: #West)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'AM 12/10/2020 18:49:13'!
test05_movingWhenHeadingEastWorksAsExpected

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #East playingIn: self .

	playableCharacter
		moveForward;
		moveForward;
		moveBackward;
		rotateRight;
		rotateLeft;
		rotateLeft.

	self assert: (playableCharacter isAt: 2@2 heading: #North)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'AM 12/10/2020 18:49:12'!
test06_movingWhenHeadingSouthWorksAsExpected

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #South playingIn: self .

	playableCharacter
		moveForward;
		moveForward;
		moveBackward;
		rotateRight;
		rotateLeft;
		rotateLeft.

	self assert: (playableCharacter isAt: 1@1 heading: #East)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'AM 12/10/2020 18:49:13'!
test07_movingWhenHeadingWestWorksAsExpected

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 2@2 heading: #West playingIn: self .

	playableCharacter
		moveForward;
		moveForward;
		moveBackward;
		rotateRight;
		rotateLeft;
		rotateLeft.

	self assert: (playableCharacter isAt: 1@2 heading: #South)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'AM 12/10/2020 18:49:12'!
test08_canNotCreatePlayableCharacterWhenHeadingIsNotValid

	self
		should: [PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #X playingIn: self ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: PlayableCharacter invalidCardinalPointErrorDescription equals: anError messageText ]! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'AM 12/10/2020 18:49:12'!
test09_canTakePortableObjects

	| playableCharacter paper |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 2@2 heading: #West playingIn: self .
	paper := NoPointsPortableObject named: 'Paper' weighing: 1.
	
	playableCharacter take: paper.
	
	self assert: (playableCharacter backpackIncludes: paper)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'AM 12/10/2020 18:49:13'!
test10_canNotTakeMoreObjectsThanTheBackpackCanCarry

	| playableCharacter paper key |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 2@2 heading: #West playingIn: self .
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


!PlayableCharacterTest methodsFor: 'room simulator' stamp: 'AM 12/10/2020 20:23:49'!
assertCanPlaceAt: aPoint ! !

!PlayableCharacterTest methodsFor: 'room simulator' stamp: 'AM 12/10/2020 21:54:36'!
move: aPlayableCharacter from: anotherPosition to: aPoint! !

!PlayableCharacterTest methodsFor: 'room simulator' stamp: 'AM 12/10/2020 19:27:19'!
place: aPlayableCharacter at: aPoint! !


!PlayableCharacterTest methodsFor: 'as yet unclassified' stamp: 'HAW 12/9/2020 13:53:29'!
defaultBackpack

	^ Backpack containingUpTo: 100 limitingPointsTo: 100 ! !


!classDefinition: #RoomTest category: 'ISW1-2020-2C-2doParcial'!
TestCase subclass: #RoomTest
	instanceVariableNames: 'wardrobe scarf key stone drawer defaultRoom'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!RoomTest methodsFor: 'setUp/tearDown' stamp: 'AM 12/10/2020 21:43:17'!
setUp

	wardrobe := NonPortableObject named: 'armario'.
	drawer := NonPortableObject named: 'cajon'.
	
	defaultRoom := Room ofHeight: 2 andWidth: 2. 
	
	scarf := PointsPortableObject named: 'bufanda' 	weighing: 8 worth: 8.
	key := NoPointsPortableObject named: 'llave' 	weighing: 8.
	stone := PointsPortableObject named: 'piedra' 	weighing: 8 worth: 8.! !


!RoomTest methodsFor: 'test object factory' stamp: 'AM 12/10/2020 21:43:09'!
defaultBackpack  
								
	^ Backpack containingUpTo: 100 limitingPointsTo: 100.! !

!RoomTest methodsFor: 'test object factory' stamp: 'AM 12/10/2020 21:16:31'!
newDefaultPlayer

	^ self newPlayerIn: (Room ofHeight: 2 andWidth: 2) 
		with: (Backpack containingUpTo: 100 limitingPointsTo: 100).	! !

!RoomTest methodsFor: 'test object factory' stamp: 'AM 12/10/2020 21:42:46'!
newPlayerAt: aCoordinate playingIn: aRoom

	^ PlayableCharacter named: 'Agustin' 
								using: self defaultBackpack  
								at: aCoordinate 
								heading: #North 
								playingIn: aRoom! !

!RoomTest methodsFor: 'test object factory' stamp: 'AM 12/10/2020 21:14:48'!
newPlayerIn: room with: backpack

	^ PlayableCharacter named: 'Agustin' using: backpack  at: 1@1 heading: #North playingIn: room! !


!RoomTest methodsFor: 'tests - dimensions' stamp: 'AM 12/10/2020 18:39:39'!
test01HeightOfRoomShouldBePositive
	
	self should: [ Room ofHeight: 0 andWidth: 1 ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Room heightMustBePositiveErrorDescription.! !

!RoomTest methodsFor: 'tests - dimensions' stamp: 'AM 12/10/2020 18:39:28'!
test02WidthOfRoomShouldBePositive
	
	self should: [ Room ofHeight: 1 andWidth: 0 ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Room widthMustBePositiveErrorDescription.! !

!RoomTest methodsFor: 'tests - dimensions' stamp: 'AM 12/10/2020 18:39:04'!
test03HeightOfRoomShouldBeAnInteger

	self should: [ Room ofHeight: 0.5 andWidth: 1 ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Room heightMustBeAnIntegerErrorDescription.! !

!RoomTest methodsFor: 'tests - dimensions' stamp: 'AM 12/10/2020 18:39:17'!
test04WidthOfRoomShouldBeAnInteger

	self should: [ Room ofHeight: 1 andWidth: 0.5 ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Room widthMustBeAnIntegerErrorDescription.! !


!RoomTest methodsFor: 'tests - moving character' stamp: 'AM 12/10/2020 21:23:51'!
test09MovingPlayableCharacterForwardShouldStayWithinRoomBounds

	| room character |
	
	room := Room ofHeight: 2 andWidth: 2.
	character := self newPlayerAt: 1@1 playingIn: room .
	
	self should: [ character moveForward ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: Room positionShouldBeInsideRoomErrorDescription equals: anError messageText.
			self assert: (character isAt: 1@1 heading: #North).
			]! !

!RoomTest methodsFor: 'tests - moving character' stamp: 'AM 12/10/2020 21:25:11'!
test10MovingPlayableCharacterBackwardsShouldStayWithinRoomBounds

	| room character |
	
	room := Room ofHeight: 2 andWidth: 2.
	character := self newPlayerAt: 0@0 playingIn: room. 
	
	self should: [ character moveBackward ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: Room positionShouldBeInsideRoomErrorDescription equals: anError messageText.
			self assert: (character isAt: 0@0 heading: #North).
			]! !

!RoomTest methodsFor: 'tests - moving character' stamp: 'AM 12/10/2020 21:43:59'!
test11ShouldNotMovePlayableCharacterToOccupiedCell

	| room character |
	
	room := Room ofHeight: 2 andWidth: 2.
	room place: scarf at: 0@1.
	
	character := self newPlayerAt: 0@0 playingIn: room. 
	
	self should: [ character moveForward ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: Room shouldNotMoveToOccupiedCellErrorDescription equals: anError messageText.
			self assert: (character isAt: 0@0 heading: #North).
			]! !

!RoomTest methodsFor: 'tests - moving character' stamp: 'AM 12/10/2020 21:26:09'!
test13PlayableCharacterPositionShouldBeTheRoomsPositionForCharacterAfterMoving

	| room character |
	
	room := Room ofHeight: 2 andWidth: 2.
	
	character := self newPlayerAt: 0@0 playingIn: room.
	character moveForward.
	
	self assert: (room at: 0@1 has: character).
	self assert: (character isAt: 0@1 heading: #North).
! !


!RoomTest methodsFor: 'tests - placing' stamp: 'AM 12/10/2020 21:39:59'!
test12ShouldNotPlaceStageObjectInOccupiedCell
	
	defaultRoom place: scarf at: 0@1.
	
	self should: [ defaultRoom place: stone at: 0@1 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: Room shouldNotMoveToOccupiedCellErrorDescription equals: anError messageText.
			self assert: (defaultRoom at: 0@1 has: scarf).
			]! !


!RoomTest methodsFor: 'tests - player initial position' stamp: 'AM 12/10/2020 21:19:58'!
test05PlayableCharacterInitialPositionShouldBeAboveRoomLowerLimit

	| room |
	
	room := Room ofHeight: 2 andWidth: 2.
	
	self should: [ self newPlayerAt: 0@-1 playingIn: room ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: Room positionShouldBeInsideRoomErrorDescription equals: anError messageText.
			self assert: room isEmpty.
			]! !

!RoomTest methodsFor: 'tests - player initial position' stamp: 'AM 12/10/2020 21:19:48'!
test06PlayableCharacterInitialPositionShouldBeBelowRoomUpperLimit

	| room |

	room := Room ofHeight: 2 andWidth: 2.
	
	self should: [  self newPlayerAt: 0@2 playingIn: room  ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: Room positionShouldBeInsideRoomErrorDescription equals: anError messageText.
			self assert: room isEmpty.
			]! !

!RoomTest methodsFor: 'tests - player initial position' stamp: 'AM 12/10/2020 21:20:12'!
test07PlayableCharacterInitialPositionShouldBeToTheRightOfRoomLeftLimit

	| room |

	room := Room ofHeight: 2 andWidth: 2.
	
	self should: [ self newPlayerAt: -1@0 playingIn: room ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: Room positionShouldBeInsideRoomErrorDescription equals: anError messageText.
			self assert: room isEmpty.
			]! !

!RoomTest methodsFor: 'tests - player initial position' stamp: 'AM 12/10/2020 21:20:34'!
test08PlayableCharacterInitialPositionShouldBeToTheLeftOfRoomRightLimit

	| room |
	
	room := Room ofHeight: 2 andWidth: 2.
	
	self should: [ self newPlayerAt: 2@0 playingIn: room ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: Room positionShouldBeInsideRoomErrorDescription equals: anError messageText.
			self assert: room isEmpty.
			]! !


!RoomTest methodsFor: 'tests - take' stamp: 'AM 12/10/2020 20:41:57'!
assertBackpack: aBackpack hasEqualElements: aCollectionOfPortableObjects

	aCollectionOfPortableObjects do: [ :aPortableObject | self assert: aBackpack includes: aPortableObject].
	self assert: aBackpack size equals: aCollectionOfPortableObjects size.! !

!RoomTest methodsFor: 'tests - take' stamp: 'AM 12/10/2020 21:40:18'!
test14PlayableCharacterShouldNotTakeFromACellThatIsOutOfRoomsBound

	| backpack character |
	
	backpack := self defaultBackpack.
	
	character := PlayableCharacter named: 'Agustin' using: backpack  at: 1@1 heading: #North playingIn: defaultRoom .
	
	self should: [ character take ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: Room positionShouldBeInsideRoomErrorDescription equals: anError messageText.
			self assert: backpack isEmpty.
			]! !

!RoomTest methodsFor: 'tests - take' stamp: 'AM 12/10/2020 21:44:54'!
test15PlayableCharacterShouldNotTakeFromACellOccupiedByAnotherPlayableCharacter

	| backpack character anotherCharacter |
	
	backpack := self defaultBackpack.
	
	character := PlayableCharacter named: 'Agustin' using: backpack  at: 1@0 heading: #North playingIn: defaultRoom .
	anotherCharacter := self newPlayerAt: 1@1 playingIn: defaultRoom. .
	
	self should: [ character take ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: PlayableCharacter canNotTakeFromAnotherCharacterErrorDescription equals: anError messageText.
			self assert: backpack isEmpty.
			]! !

!RoomTest methodsFor: 'tests - take' stamp: 'AM 12/10/2020 21:40:53'!
test16PlayableCharacterTakesNothingFromEmptyCell

	| backpack character |
	
	backpack := self defaultBackpack.
	
	character := PlayableCharacter named: 'Agustin' using: backpack  at: 1@0 heading: #North playingIn: defaultRoom .
	character take.
	
	self assert: backpack isEmpty! !

!RoomTest methodsFor: 'tests - take' stamp: 'AM 12/10/2020 21:41:22'!
test17PlayableCharacterTakesOneElementSuccessfully

	| backpack character |
	
	backpack := self defaultBackpack.
	
	defaultRoom place: stone at: 1@1.
	character := PlayableCharacter named: 'Agustin' using: backpack  at: 1@0 heading: #North playingIn: defaultRoom .
	character take.
	
	self assertBackpack: backpack hasEqualElements: {stone}.
	self deny: (defaultRoom hasSomethingAt: 1@1).! !

!RoomTest methodsFor: 'tests - take' stamp: 'AM 12/10/2020 21:41:43'!
test18PlayableCharacterTakesRecursivelySuccessfully

	| backpack character |
	
	backpack := self defaultBackpack.
	
	wardrobe add: stone; add: scarf; add: key; add: drawer.
	
	defaultRoom place: wardrobe at: 1@1.
	character := PlayableCharacter named: 'Agustin' using: backpack  at: 1@0 heading: #North playingIn: defaultRoom .
	
	character take.
	
	self assertBackpack: backpack hasEqualElements: {stone. scarf. key}.
	self assert: (defaultRoom at: 1@1 has: wardrobe).
	self assert: (wardrobe stageObjects hasEqualElements: {drawer} ).! !


!classDefinition: #Backpack category: 'ISW1-2020-2C-2doParcial'!
Object subclass: #Backpack
	instanceVariableNames: 'weightCapacity gamePointsCapacity container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

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


!Backpack methodsFor: 'adding' stamp: 'HAW 10/18/2020 12:28:24'!
add: aPortableObject
	
	aPortableObject assertCanAddTo: self.
	
	container add: aPortableObject.
	! !


!Backpack methodsFor: 'adding - private' stamp: 'HAW 10/18/2020 12:28:48'!
assertCanAddNoPointsPortableObject: aNoPointsPortableObject 
	
	self assertWeightAdding: aNoPointsPortableObject tolerating: 0.
	! !

!Backpack methodsFor: 'adding - private' stamp: 'HAW 10/18/2020 12:29:07'!
assertCanAddPointPortableObject: aPointsPortableObject 
	
	self assertWeightAdding: aPointsPortableObject tolerating: 5.
	self assertPointsAdding: aPointsPortableObject.
	! !


!Backpack methodsFor: 'assertions' stamp: 'FRT 10/12/2020 14:12:36'!
assertPointsAdding: aPointsPortableObject

	(self totalPoints + aPointsPortableObject points) > gamePointsCapacity ifTrue: [ self signalMaxPointsExceeded ]! !

!Backpack methodsFor: 'assertions' stamp: 'FRT 10/15/2020 12:22:34'!
assertWeightAdding: aPortableObject tolerating: aThreshold

	(self totalWeight + aPortableObject weight - weightCapacity) > aThreshold ifTrue: [ self signalMaxWeightExceeded ]! !


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


!Backpack methodsFor: 'testing' stamp: 'HAW 12/9/2020 19:44:17'!
includes: aPortableObject 
	
	^container includes: aPortableObject ! !

!Backpack methodsFor: 'testing' stamp: 'FRT 10/11/2020 18:38:38'!
isEmpty

	^ container isEmpty.! !

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

!PlayableCharacter methodsFor: 'initialization' stamp: 'AM 12/10/2020 20:29:04'!
initializeNamed: aName using: aBackpack at: aPosition heading: aMarsRoverHeading playingIn: aRoom

	room := aRoom.
	name := aName.
	backpack := aBackpack.
	position := aPosition.
	heading := aMarsRoverHeading! !


!PlayableCharacter methodsFor: 'moving' stamp: 'AM 12/10/2020 19:54:32'!
backwardPosition

	^ position - heading forwardPoint! !

!PlayableCharacter methodsFor: 'moving' stamp: 'AM 12/10/2020 19:54:09'!
forwardPosition

	^ position + heading forwardPoint! !

!PlayableCharacter methodsFor: 'moving' stamp: 'AM 12/10/2020 21:56:02'!
moveBackward
	
	room move: self from: position to: self backwardPosition.
	
	position := self backwardPosition ! !

!PlayableCharacter methodsFor: 'moving' stamp: 'AM 12/10/2020 21:55:28'!
moveForward
	
	room move: self from: position to: self forwardPosition.
	
	position := self forwardPosition ! !


!PlayableCharacter methodsFor: 'rotating' stamp: 'HAW 10/11/2019 08:31:55'!
rotateLeft
	
	heading := heading leftHeading! !

!PlayableCharacter methodsFor: 'rotating' stamp: 'HAW 10/11/2019 08:32:04'!
rotateRight
	
	heading := heading rightHeading! !


!PlayableCharacter methodsFor: 'taking objects' stamp: 'AM 12/10/2020 20:55:38'!
addTo: aPlayableCharacter from: aRoom

	self error: self class canNotTakeFromAnotherCharacterErrorDescription! !

!PlayableCharacter methodsFor: 'taking objects' stamp: 'AM 12/10/2020 19:55:09'!
take
	
	room takeFor: self at: self forwardPosition .! !

!PlayableCharacter methodsFor: 'taking objects' stamp: 'HAW 12/9/2020 19:28:57'!
take: aPortableObject

	backpack add: aPortableObject.! !


!PlayableCharacter methodsFor: 'testing' stamp: 'HAW 12/9/2020 19:43:44'!
backpackIncludes: aPortableObject 
	
	^backpack includes: aPortableObject ! !

!PlayableCharacter methodsFor: 'testing' stamp: 'HAW 7/1/2018 14:25:05'!
isAt: aPosition heading: aCardinalPoint

	^position = aPosition and: [ heading cardinalPoint = aCardinalPoint ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayableCharacter class' category: 'ISW1-2020-2C-2doParcial'!
PlayableCharacter class
	instanceVariableNames: 'headings'!


!PlayableCharacter class methodsFor: 'error descriptions' stamp: 'AM 12/10/2020 20:30:09'!
canNotTakeFromAnotherCharacterErrorDescription
	
	^ 'Can not take from another playable character'! !


!PlayableCharacter class methodsFor: 'heading' stamp: 'HAW 7/2/2018 16:28:16'!
headingFor: aCardinalPoint
	
	^headings at: aCardinalPoint ifAbsent: [ self error: self invalidCardinalPointErrorDescription ]! !

!PlayableCharacter class methodsFor: 'heading' stamp: 'HAW 7/2/2018 16:26:14'!
invalidCardinalPointErrorDescription
	
	^'Invalid cardinal point'! !


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


!PlayableCharacter class methodsFor: 'instance creation' stamp: 'AM 12/10/2020 20:24:14'!
named: aName using: aBackpack at: aPosition heading: aCardinalPoint playingIn: aRoom 

	| newHeading newPlayableCharacter |
	
	aRoom assertCanPlaceAt: aPosition.

	newHeading := self headingFor: aCardinalPoint.
	
	newPlayableCharacter := self new initializeNamed: aName using: aBackpack at: aPosition heading: newHeading playingIn: aRoom.
	
	aRoom place: newPlayableCharacter at: aPosition .
	
	^ newPlayableCharacter! !


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
	instanceVariableNames: 'playableCharacter stageObjects height width cells'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!Room methodsFor: 'assertions' stamp: 'AM 12/10/2020 20:24:44'!
assertCanPlaceAt: aPosition

	self assertIsWithinBounds: aPosition.
	self assertNothingAt: aPosition! !

!Room methodsFor: 'assertions' stamp: 'AM 12/10/2020 19:48:08'!
assertIsWithinBounds: aPoint.
	
	((aPoint x between: 0 and: width - 1) and: [ aPoint y between: 0 and: height - 1 ])
		ifFalse: [ self error: self class positionShouldBeInsideRoomErrorDescription ].! !

!Room methodsFor: 'assertions' stamp: 'AM 12/10/2020 20:26:31'!
assertNothingAt: aPosition.

	cells at: aPosition ifPresent: [:anObject | self error: self class shouldNotMoveToOccupiedCellErrorDescription].! !


!Room methodsFor: 'initialization' stamp: 'AM 12/10/2020 18:46:06'!
initializeOfHeight: aHeight andWidth: aWidth 
	
	height := aHeight.
	width := aWidth.
	cells := Dictionary new.! !


!Room methodsFor: 'placing' stamp: 'AM 12/10/2020 21:54:35'!
move: aCharacter from: aStartingPosition to: anEndingPosition
	
	self assertCanPlaceAt: anEndingPosition.
	
	cells removeKey: aStartingPosition.
	cells at: anEndingPosition put: aCharacter.! !

!Room methodsFor: 'placing' stamp: 'AM 12/10/2020 21:56:44'!
place: aCharacterOrStageObject at: aPosition 
	
	self assertCanPlaceAt: aPosition.
	
	cells at: aPosition put: aCharacterOrStageObject.! !


!Room methodsFor: 'removing' stamp: 'AM 12/10/2020 20:57:37'!
remove: aPortableObject 

	cells removeKey: (cells keyAtValue: aPortableObject)
	
	! !


!Room methodsFor: 'taking' stamp: 'AM 12/10/2020 20:51:54'!
takeFor: aPlayableCharacter at: aPosition 
	
	self assertIsWithinBounds: aPosition.
	cells at: aPosition ifPresent: [ :aCharacterOrStageObject | aCharacterOrStageObject addTo: aPlayableCharacter from: self ]! !


!Room methodsFor: 'testing' stamp: 'AM 12/10/2020 19:16:33'!
at: aPoint has: aCharacterOrStageObject 
	
	^ (cells at: aPoint) = aCharacterOrStageObject 
	! !

!Room methodsFor: 'testing' stamp: 'AM 12/10/2020 21:57:11'!
hasSomethingAt: aPosition 
	
	^ cells includesKey: aPosition! !

!Room methodsFor: 'testing' stamp: 'AM 12/10/2020 18:46:43'!
isEmpty
	
	^ cells isEmpty.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Room class' category: 'ISW1-2020-2C-2doParcial'!
Room class
	instanceVariableNames: ''!

!Room class methodsFor: 'error descriptions' stamp: 'AM 12/10/2020 17:45:19'!
heightMustBeAnIntegerErrorDescription
	
	^ 'Height of room must be an integer number.'! !

!Room class methodsFor: 'error descriptions' stamp: 'AM 12/10/2020 17:39:53'!
heightMustBePositiveErrorDescription
	
	^ 'Height of room should be positive'! !

!Room class methodsFor: 'error descriptions' stamp: 'AM 12/10/2020 19:48:08'!
positionShouldBeInsideRoomErrorDescription
	
	^ 'Placing should be done withing board limits.'! !

!Room class methodsFor: 'error descriptions' stamp: 'AM 12/10/2020 20:27:15'!
shouldNotMoveToOccupiedCellErrorDescription
	
	^ 'Should not move to occupied cell'! !

!Room class methodsFor: 'error descriptions' stamp: 'AM 12/10/2020 17:48:01'!
widthMustBeAnIntegerErrorDescription
	
	^ 'Width of room must be an integer number.'! !

!Room class methodsFor: 'error descriptions' stamp: 'AM 12/10/2020 17:42:02'!
widthMustBePositiveErrorDescription
	
	^ 'Width of room should be positive'! !


!Room class methodsFor: 'instance creation' stamp: 'AM 12/10/2020 18:37:59'!
ofHeight: aHeight andWidth: aWidth
	
	aHeight > 0 ifFalse: [ self error: self heightMustBePositiveErrorDescription ].
	aWidth > 0 ifFalse: [ self error: self widthMustBePositiveErrorDescription ].
	
	aHeight isInteger ifFalse: [ self error: self heightMustBeAnIntegerErrorDescription ].
	aWidth isInteger ifFalse: [ self error: self widthMustBeAnIntegerErrorDescription ].
	
	^self new initializeOfHeight: aHeight andWidth: aWidth ! !


!classDefinition: #StageObject category: 'ISW1-2020-2C-2doParcial'!
Object subclass: #StageObject
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!StageObject methodsFor: 'adding' stamp: 'AM 12/10/2020 21:57:58'!
addTo: aPlayableCharacter from: aContainer

	self subclassResponsibility	! !


!classDefinition: #NonPortableObject category: 'ISW1-2020-2C-2doParcial'!
StageObject subclass: #NonPortableObject
	instanceVariableNames: 'name stageObjects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!NonPortableObject methodsFor: 'initialization' stamp: 'AM 12/10/2020 19:41:04'!
initializeNamed: aName 
	
	name := aName.
	stageObjects := OrderedCollection new.! !


!NonPortableObject methodsFor: 'testing' stamp: 'AM 12/10/2020 19:41:52'!
isEmpty
	
	^ stageObjects isEmpty! !


!NonPortableObject methodsFor: 'adding' stamp: 'AM 12/10/2020 19:41:14'!
add: aStageObject 
	
	stageObjects add: aStageObject 
	! !

!NonPortableObject methodsFor: 'adding' stamp: 'AM 12/10/2020 21:12:35'!
addTo: aPlayableCharacter from: aContainer
	
	stageObjects copy do: [ :aStageObject | aStageObject addTo: aPlayableCharacter from: self]! !


!NonPortableObject methodsFor: 'accessing' stamp: 'AM 12/10/2020 19:41:21'!
stageObjects
	
	^ stageObjects ! !


!NonPortableObject methodsFor: 'removing' stamp: 'AM 12/10/2020 20:58:49'!
remove: aPortableObject 
	
	stageObjects remove: 	aPortableObject ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NonPortableObject class' category: 'ISW1-2020-2C-2doParcial'!
NonPortableObject class
	instanceVariableNames: ''!

!NonPortableObject class methodsFor: 'instance creation' stamp: 'AM 12/10/2020 19:32:17'!
named: aName 
	
	^self new initializeNamed: aName ! !


!classDefinition: #PortableObject category: 'ISW1-2020-2C-2doParcial'!
StageObject subclass: #PortableObject
	instanceVariableNames: 'name weight'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!PortableObject methodsFor: 'testing' stamp: 'FRT 10/11/2020 17:54:20'!
doesItAddPoints

	self subclassResponsibility	! !


!PortableObject methodsFor: 'adding' stamp: 'AM 12/10/2020 21:45:34'!
addTo: aPlayableCharacter from: aContainer 
	
	aPlayableCharacter take: self.
	aContainer remove: self.! !

!PortableObject methodsFor: 'adding' stamp: 'HAW 10/18/2020 12:28:24'!
assertCanAddTo: aBackpack

	self subclassResponsibility	! !


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

PlayableCharacter initialize!