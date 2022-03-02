!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'move forward' stamp: 'GR 5/17/2021 17:03:42'!
test03AdvancingNorthShouldIncreaseYCoordinate
|rover orientation position|
	orientation := North new.
	position := Position inX: 0 inY: 0.
	rover := MarsRover in: position orientedTo: orientation.
	rover commandSequence: 'f'.
	
	self assert: (Position inX: 0 inY:1) equals: rover position.! !

!MarsRoverTest methodsFor: 'move forward' stamp: 'GR 5/17/2021 17:10:42'!
test13AdvancingEast
|rover orientation position|
	orientation := North new.
	position := Position inX: 0 inY: 0.
	rover := MarsRover in: position orientedTo: orientation.
	rover commandSequence: 'rf'.
	
	self assert: (Position inX: 1 inY: 0) equals: rover position.! !

!MarsRoverTest methodsFor: 'move forward' stamp: 'GR 5/17/2021 17:10:56'!
test14AdvancingSouth
|rover orientation position|
	orientation := North new.
	position := Position inX: 0 inY: 0.
	rover := MarsRover in: position orientedTo: orientation.
	rover commandSequence: 'rrf'.
	
	self assert: (Position inX: 0 inY: -1) equals: rover position.! !

!MarsRoverTest methodsFor: 'move forward' stamp: 'GR 5/17/2021 17:11:16'!
test15AdvancingWest
|rover orientation position|
	orientation := North new.
	position := Position inX: 0 inY: 0.
	rover := MarsRover in: position orientedTo: orientation.
	rover commandSequence: 'rrrf'.
	
	self assert: (Position inX: -1 inY: 0) equals: rover position.! !


!MarsRoverTest methodsFor: 'rotate left' stamp: 'GR 5/17/2021 17:07:57'!
test09RotatingLeftNorthIsWest
|rover orientation position|
	orientation := North new.
	position := Position inX: 0 inY: 0.
	rover := MarsRover in: position orientedTo: orientation.
	rover commandSequence: 'l'.
	
	self assert: West new equals: rover orientation.! !

!MarsRoverTest methodsFor: 'rotate left' stamp: 'GR 5/17/2021 17:08:22'!
test10RotatingLeftTwiceNorthIsSouth
|rover orientation position|
	orientation := North new.
	position := Position inX: 0 inY: 0.
	rover := MarsRover in: position orientedTo: orientation.
	rover commandSequence: 'll'.
	
	self assert: South new equals: rover orientation.! !

!MarsRoverTest methodsFor: 'rotate left' stamp: 'GR 5/17/2021 17:08:47'!
test11RotatingLeftThreeTimesNorthIsEast
|rover orientation position|
	orientation := North new.
	position := Position inX: 0 inY: 0.
	rover := MarsRover in: position orientedTo: orientation.
	rover commandSequence: 'lll'.
	
	self assert: East new equals: rover orientation.! !

!MarsRoverTest methodsFor: 'rotate left' stamp: 'GR 5/17/2021 17:09:03'!
test12RotatingLeftFourTimesNorthIsNorth
|rover orientation position|
	orientation := North new.
	position := Position inX: 0 inY: 0.
	rover := MarsRover in: position orientedTo: orientation.
	rover commandSequence: 'llll'.
	
	self assert: North new equals: rover orientation.! !


!MarsRoverTest methodsFor: 'rotate right' stamp: 'GR 5/17/2021 17:05:19'!
test05RotatingRightNorthIsEast
|rover orientation position|
	orientation := North new.
	position := Position inX: 0 inY: 0.
	rover := MarsRover in: position orientedTo: orientation.
	rover commandSequence: 'r'.
	
	self assert: East new equals: rover orientation.! !

!MarsRoverTest methodsFor: 'rotate right' stamp: 'GR 5/17/2021 17:05:58'!
test06RotatingRightTwiceNorthIsSouth
|rover orientation position|
	orientation := North new.
	position := Position inX: 0 inY: 0.
	rover := MarsRover in: position orientedTo: orientation.
	rover commandSequence: 'rr'.
	
	self assert: South new equals: rover orientation.! !

!MarsRoverTest methodsFor: 'rotate right' stamp: 'GR 5/17/2021 17:07:06'!
test07RotatingRightThreeTimesNorthIsWest
|rover orientation position|
	orientation := North new.
	position := Position inX: 0 inY: 0.
	rover := MarsRover in: position orientedTo: orientation.
	rover commandSequence: 'rrr'.
	
	self assert: West new equals: rover orientation.! !

!MarsRoverTest methodsFor: 'rotate right' stamp: 'GR 5/17/2021 17:07:35'!
test08RotatingRightFourTimesNorthIsNorth
|rover orientation position|
	orientation := North new.
	position := Position inX: 0 inY: 0.
	rover := MarsRover in: position orientedTo: orientation.
	
	rover commandSequence: 'rrrr'.
	
	self assert: North new equals: rover orientation.! !


!MarsRoverTest methodsFor: 'instance initialization' stamp: 'GR 5/17/2021 17:03:10'!
test01InitializationShouldPreservePosition
|rover orientation position|
	orientation := North new.
	position := Position inX: 0 inY: 0.
	rover := MarsRover in: position orientedTo: orientation.
	
	self assert: position equals: rover position.! !

!MarsRoverTest methodsFor: 'instance initialization' stamp: 'GR 5/17/2021 17:02:46'!
test02InitializationShouldPreserveOrientation
|rover orientation position|
	orientation := North new.
	position := Position inX: 0 inY: 0.
	rover := MarsRover in: position orientedTo: orientation.
	
	self assert: orientation equals: rover orientation.! !


!MarsRoverTest methodsFor: 'move backwards' stamp: 'GR 5/17/2021 17:04:51'!
test04BackwardsNorthShouldDecreaseYCoordinate
|rover orientation position|
	orientation := North new.
	position := Position inX: 0 inY: 0.
	rover := MarsRover in: position orientedTo: orientation.
	rover commandSequence: 'b'.
	
	self assert: (Position inX: 0 inY: -1) equals: rover position.! !

!MarsRoverTest methodsFor: 'move backwards' stamp: 'GR 5/17/2021 17:11:40'!
test16MovingBackwardsEast
|rover orientation position|
	orientation := East new.
	position := Position inX: 0 inY: 0.
	rover := MarsRover in: position orientedTo: orientation.
	rover commandSequence: 'b'.
	
	self assert: (Position inX: -1 inY: 0) equals: rover position.
! !

!MarsRoverTest methodsFor: 'move backwards' stamp: 'GR 5/17/2021 17:12:01'!
test17MovingBackwardsSouth
|rover orientation position|
	orientation := South new.
	position := Position inX: 0 inY: 0.
	rover := MarsRover in: position orientedTo: orientation.
	rover commandSequence: 'b'.
	
	self assert: (Position inX: 0 inY: 1) equals: rover position.! !

!MarsRoverTest methodsFor: 'move backwards' stamp: 'GR 5/17/2021 17:12:14'!
test18MovingBackwardsWest
|rover orientation position|
	orientation := West new.
	position := Position inX: 0 inY: 0.
	rover := MarsRover in: position orientedTo: orientation.
	rover commandSequence: 'b'.
	
	self assert: (Position inX: 1 inY: 0) equals: rover position.! !


!MarsRoverTest methodsFor: 'command processing' stamp: 'GR 5/17/2021 17:12:33'!
test19ShouldNotProcessAfterBadCommand
|rover orientation position|
	orientation := West new.
	position := Position inX: 0 inY: 0.
	rover := MarsRover in: position orientedTo: orientation.
	rover commandSequence: 'bkb'.
	
	self assert: (Position inX: 1 inY: 0) equals: rover position.! !


!classDefinition: #CardinalPoint category: 'MarsRover'!
Object subclass: #CardinalPoint
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalPoint methodsFor: 'comparing' stamp: 'GR 5/17/2021 15:49:00'!
= aCardinalPoint

	^aCardinalPoint isKindOf: self class.! !


!CardinalPoint methodsFor: 'operations' stamp: 'GR 5/17/2021 16:09:49'!
advanceAtPosition: aPosition
	^self subclassResponsibility.! !

!CardinalPoint methodsFor: 'operations' stamp: 'GR 5/17/2021 16:43:30'!
moveBackwardsAtPosition: aPosition
	^self subclassResponsibility.! !

!CardinalPoint methodsFor: 'operations' stamp: 'GR 5/17/2021 15:37:06'!
rotateLeft

	^self subclassResponsibility.! !

!CardinalPoint methodsFor: 'operations' stamp: 'GR 5/17/2021 15:21:36'!
rotateRight

	^self subclassResponsibility.! !


!classDefinition: #East category: 'MarsRover'!
CardinalPoint subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'operations' stamp: 'GR 5/17/2021 16:10:37'!
advanceAtPosition: aPosition
	aPosition advanceEast.! !

!East methodsFor: 'operations' stamp: 'GR 5/17/2021 16:44:16'!
moveBackwardsAtPosition: aPosition
	aPosition moveBackwardsEast.! !

!East methodsFor: 'operations' stamp: 'GR 5/17/2021 15:37:25'!
rotateLeft
	^North new.! !

!East methodsFor: 'operations' stamp: 'GR 5/17/2021 15:21:08'!
rotateRight
	^South new.! !


!classDefinition: #North category: 'MarsRover'!
CardinalPoint subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'operations' stamp: 'GR 5/17/2021 16:10:54'!
advanceAtPosition: aPosition
	aPosition advanceNorth.! !

!North methodsFor: 'operations' stamp: 'GR 5/17/2021 16:44:28'!
moveBackwardsAtPosition: aPosition
	aPosition moveBackwardsNorth.! !

!North methodsFor: 'operations' stamp: 'GR 5/17/2021 15:37:42'!
rotateLeft
	^West new.! !

!North methodsFor: 'operations' stamp: 'GR 5/17/2021 15:21:57'!
rotateRight
	^East new.! !


!classDefinition: #South category: 'MarsRover'!
CardinalPoint subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'operations' stamp: 'GR 5/17/2021 16:11:21'!
advanceAtPosition: aPosition
	aPosition advanceSouth.! !

!South methodsFor: 'operations' stamp: 'GR 5/17/2021 16:44:41'!
moveBackwardsAtPosition: aPosition
	aPosition moveBackwardsSouth.! !

!South methodsFor: 'operations' stamp: 'GR 5/17/2021 15:37:54'!
rotateLeft
	^East new.! !

!South methodsFor: 'operations' stamp: 'GR 5/17/2021 15:22:17'!
rotateRight
	^West new.! !


!classDefinition: #West category: 'MarsRover'!
CardinalPoint subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'operations' stamp: 'GR 5/17/2021 16:11:34'!
advanceAtPosition: aPosition
	aPosition advanceWest.! !

!West methodsFor: 'operations' stamp: 'GR 5/17/2021 16:44:51'!
moveBackwardsAtPosition: aPosition
	aPosition moveBackwardsWest.! !

!West methodsFor: 'operations' stamp: 'GR 5/17/2021 15:38:06'!
rotateLeft
	^South new.! !

!West methodsFor: 'operations' stamp: 'GR 5/17/2021 15:35:56'!
rotateRight

	^North new.! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position orientation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'operations - private' stamp: 'GR 5/17/2021 16:42:50'!
moveBackwards
	orientation moveBackwardsAtPosition: position.! !

!MarsRover methodsFor: 'operations - private' stamp: 'GR 5/17/2021 16:26:02'!
moveForward

	orientation advanceAtPosition: position.
		! !

!MarsRover methodsFor: 'operations - private' stamp: 'GR 5/17/2021 16:54:39'!
processCommand: aCommand
	(aCommand = $f) ifTrue:[
		self moveForward.
	].
	(aCommand = $b) ifTrue:[
		self moveBackwards.
	].
	(aCommand = $r) ifTrue:[
		self rotateRight.
	].
	(aCommand = $l) ifTrue:[
		self rotateLeft.
	].
		! !

!MarsRover methodsFor: 'operations - private' stamp: 'GR 5/17/2021 15:54:04'!
rotateLeft
	
	orientation := orientation rotateLeft.
		! !

!MarsRover methodsFor: 'operations - private' stamp: 'GR 5/17/2021 15:47:21'!
rotateRight
		
	orientation := orientation rotateRight.
		! !


!MarsRover methodsFor: 'operations' stamp: 'GR 5/17/2021 16:56:53'!
commandSequence: aCommandSequence
	|validCommands|
	validCommands := #($f $b $l $r).
	aCommandSequence do: [:command | (validCommands includes: command) ifFalse: [^self].
		self processCommand: command ].! !

!MarsRover methodsFor: 'operations' stamp: 'GR 5/17/2021 13:28:27'!
orientation
	^orientation.! !

!MarsRover methodsFor: 'operations' stamp: 'GR 5/17/2021 16:19:56'!
position
	^position.! !


!MarsRover methodsFor: 'instance initialization' stamp: 'GR 5/17/2021 16:14:35'!
initializeIn: aPosition orientedTo: anOrientation 
	position := aPosition.
	orientation := anOrientation.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'GR 5/17/2021 16:16:41'!
in: aPosition orientedTo: anOrientation 
	^self new initializeIn: aPosition orientedTo: anOrientation.! !


!classDefinition: #Position category: 'MarsRover'!
Object subclass: #Position
	instanceVariableNames: 'xCoordinate yCoordinate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Position methodsFor: 'move backwards' stamp: 'GR 5/17/2021 16:46:00'!
moveBackwardsEast

	xCoordinate := xCoordinate - 1.

	! !

!Position methodsFor: 'move backwards' stamp: 'GR 5/17/2021 16:45:32'!
moveBackwardsNorth

	yCoordinate := yCoordinate - 1.

	! !

!Position methodsFor: 'move backwards' stamp: 'GR 5/17/2021 16:45:41'!
moveBackwardsSouth

	yCoordinate := yCoordinate + 1.

	! !

!Position methodsFor: 'move backwards' stamp: 'GR 5/17/2021 16:45:52'!
moveBackwardsWest

	xCoordinate := xCoordinate + 1.

	! !


!Position methodsFor: 'comparing' stamp: 'GR 5/17/2021 16:28:47'!
= aPosition
	^xCoordinate = (aPosition xCoordinate) and: yCoordinate = (aPosition yCoordinate).! !


!Position methodsFor: 'getters' stamp: 'GR 5/17/2021 16:29:25'!
xCoordinate
	^xCoordinate.! !

!Position methodsFor: 'getters' stamp: 'GR 5/17/2021 16:29:20'!
yCoordinate
	^yCoordinate.! !


!Position methodsFor: 'initialization' stamp: 'GR 5/17/2021 16:07:51'!
initializeInX: anXCoordinate inY: aYCoordinate

	xCoordinate := anXCoordinate.
	yCoordinate  := aYCoordinate.! !


!Position methodsFor: 'move forward' stamp: 'GR 5/17/2021 16:26:55'!
advanceEast

	xCoordinate := xCoordinate + 1.! !

!Position methodsFor: 'move forward' stamp: 'GR 5/17/2021 16:25:24'!
advanceNorth

	yCoordinate := yCoordinate + 1.! !

!Position methodsFor: 'move forward' stamp: 'GR 5/17/2021 16:26:26'!
advanceSouth

	yCoordinate := yCoordinate - 1.! !

!Position methodsFor: 'move forward' stamp: 'GR 5/17/2021 16:26:39'!
advanceWest

	xCoordinate := xCoordinate - 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Position class' category: 'MarsRover'!
Position class
	instanceVariableNames: ''!

!Position class methodsFor: 'instance creation' stamp: 'GR 5/17/2021 16:06:47'!
inX: anXCoordinate inY: aYCoordinate
	
	^self new initializeInX: anXCoordinate inY: aYCoordinate .! !
