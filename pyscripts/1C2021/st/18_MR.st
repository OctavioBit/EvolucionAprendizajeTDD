!classDefinition: #MarsRoverTest category: 'Ejercicio-MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-MarsRover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JR 5/17/2021 16:41:35'!
test01ShouldNotMoveIfCommandIsEmpty

	|marsRover|
	
	marsRover := MarsRover at: 0@0 heading: North.
	
	marsRover processCommand: ''.
	
	self assert: (marsRover isAt: 0@0 heading: North)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JR 5/17/2021 16:41:21'!
test02ShouldMoveForwardWithCommandF

	|marsRover|
	
	marsRover := MarsRover at: 0@0 heading: North.
	
	marsRover processCommand: 'f'.
	
	self assert: (marsRover isAt: 1@0 heading: North)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JR 5/17/2021 16:41:55'!
test03ShouldMoveBackwardsWithCommandB

	|marsRover|
	
	marsRover := MarsRover at: 0@0 heading: North.
	
	marsRover processCommand: 'b'.
	
	self assert: (marsRover isAt: -1@0 heading: North)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JR 5/17/2021 16:42:08'!
test04ShouldRotateLeftWithCommandL

	|marsRover|
	
	marsRover := MarsRover at: 0@0 heading: North.
	
	marsRover processCommand: 'l'.
	
	self assert: (marsRover isAt: 0@0 heading: West)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JR 5/17/2021 16:42:23'!
test05ShouldRotateRightWithCommandR

	|marsRover|
	
	marsRover := MarsRover at: 0@0 heading: North.
	
	marsRover processCommand: 'r'.
	
	self assert: (marsRover isAt: 0@0 heading: East)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JR 5/17/2021 16:42:47'!
test06ShouldProcessMultipleCommands

	|marsRover|
	
	marsRover := MarsRover at: 0@0 heading: North.
	
	marsRover processCommand: 'rflb'.
	
	self assert: (marsRover isAt: -1@1 heading: North)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JR 5/17/2021 16:43:05'!
test07ShouldStopProcessingAfterInvalidCommand

	|marsRover|
	
	marsRover := MarsRover at: 0@0 heading: North.
	
	self 
		should: [ marsRover processCommand: 'rlffxbb'.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: MarsRover invalidCommandError equals: anError messageText.
			self assert: (marsRover isAt: 2@0 heading: North) ]! !


!classDefinition: #CardinalPoints category: 'Ejercicio-MarsRover'!
Object subclass: #CardinalPoints
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-MarsRover'!

!CardinalPoints methodsFor: 'actions' stamp: 'JR 5/16/2021 21:08:46'!
left

	self subclassResponsibility ! !

!CardinalPoints methodsFor: 'actions' stamp: 'JR 5/16/2021 21:03:46'!
moveBackwards: aMarsRover

	self subclassResponsibility ! !

!CardinalPoints methodsFor: 'actions' stamp: 'JR 5/16/2021 20:54:00'!
moveForward: aMarsRover

	self subclassResponsibility ! !

!CardinalPoints methodsFor: 'actions' stamp: 'JR 5/16/2021 21:10:37'!
right

	self subclassResponsibility ! !


!classDefinition: #East category: 'Ejercicio-MarsRover'!
CardinalPoints subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-MarsRover'!

!East methodsFor: 'actions' stamp: 'JR 5/16/2021 21:08:58'!
left

	^North! !

!East methodsFor: 'actions' stamp: 'JR 5/16/2021 21:04:05'!
moveBackwards: aMarsRover

	aMarsRover moveBackwardsWhenHeadingEast! !

!East methodsFor: 'actions' stamp: 'JR 5/16/2021 20:55:26'!
moveForward: aMarsRover

	aMarsRover moveForwardWhenHeadingEast! !

!East methodsFor: 'actions' stamp: 'JR 5/16/2021 21:10:54'!
right

	^South! !


!classDefinition: #North category: 'Ejercicio-MarsRover'!
CardinalPoints subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-MarsRover'!

!North methodsFor: 'actions' stamp: 'JR 5/16/2021 21:09:10'!
left

	^West! !

!North methodsFor: 'actions' stamp: 'JR 5/16/2021 21:04:20'!
moveBackwards: aMarsRover

	aMarsRover moveBackwardsWhenHeadingNorth! !

!North methodsFor: 'actions' stamp: 'JR 5/16/2021 20:55:45'!
moveForward: aMarsRover

	aMarsRover moveForwardWhenHeadingNorth! !

!North methodsFor: 'actions' stamp: 'JR 5/16/2021 21:11:05'!
right

	^East! !


!classDefinition: #South category: 'Ejercicio-MarsRover'!
CardinalPoints subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-MarsRover'!

!South methodsFor: 'actions' stamp: 'JR 5/16/2021 21:09:18'!
left

	^East! !

!South methodsFor: 'actions' stamp: 'JR 5/16/2021 21:04:32'!
moveBackwards: aMarsRover

	aMarsRover moveBackwardsWhenHeadingSouth! !

!South methodsFor: 'actions' stamp: 'JR 5/16/2021 20:55:54'!
moveForward: aMarsRover

	aMarsRover moveForwardWhenHeadingSouth! !

!South methodsFor: 'actions' stamp: 'JR 5/16/2021 21:11:14'!
right

	^West! !


!classDefinition: #West category: 'Ejercicio-MarsRover'!
CardinalPoints subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-MarsRover'!

!West methodsFor: 'actions' stamp: 'JR 5/16/2021 21:09:25'!
left

	^South! !

!West methodsFor: 'actions' stamp: 'JR 5/16/2021 21:04:42'!
moveBackwards: aMarsRover

	aMarsRover moveBackwardsWhenHeadingWest! !

!West methodsFor: 'actions' stamp: 'JR 5/16/2021 20:56:04'!
moveForward: aMarsRover

	aMarsRover moveForwardWhenHeadingWest! !

!West methodsFor: 'actions' stamp: 'JR 5/16/2021 21:11:22'!
right

	^North! !


!classDefinition: #MarsRover category: 'Ejercicio-MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'cardinalPoint position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'JR 5/16/2021 21:01:50'!
initializeAt: aPoint heading: aCardinalPoint 
	
	position := aPoint.
	cardinalPoint := aCardinalPoint.! !


!MarsRover methodsFor: 'actions' stamp: 'JR 5/16/2021 21:05:54'!
moveBackwardsWhenHeadingEast

	position := position - (0@1)! !

!MarsRover methodsFor: 'actions' stamp: 'JR 5/16/2021 21:05:25'!
moveBackwardsWhenHeadingNorth

	position := position - (1@0)! !

!MarsRover methodsFor: 'actions' stamp: 'JR 5/16/2021 21:05:35'!
moveBackwardsWhenHeadingSouth

	position := position + (1@0)! !

!MarsRover methodsFor: 'actions' stamp: 'JR 5/16/2021 21:06:05'!
moveBackwardsWhenHeadingWest

	position := position + (0@1)! !

!MarsRover methodsFor: 'actions' stamp: 'JR 5/16/2021 20:57:15'!
moveForwardWhenHeadingEast

	position := position + (0@1)! !

!MarsRover methodsFor: 'actions' stamp: 'JR 5/16/2021 20:56:53'!
moveForwardWhenHeadingNorth

	position := position + (1@0)
	! !

!MarsRover methodsFor: 'actions' stamp: 'JR 5/16/2021 20:57:03'!
moveForwardWhenHeadingSouth

	position := position - (1@0)! !

!MarsRover methodsFor: 'actions' stamp: 'JR 5/16/2021 20:57:25'!
moveForwardWhenHeadingWest

	position := position - (0@1)

	! !

!MarsRover methodsFor: 'actions' stamp: 'JR 5/16/2021 20:43:32'!
processCommand: aPackedCommand 

	aPackedCommand do: [:command | self processNextCommand: command]! !

!MarsRover methodsFor: 'actions' stamp: 'JR 5/16/2021 21:20:49'!
processNextCommand: aCommand 

	(aCommand = $f) ifTrue: [ ^cardinalPoint new moveForward: self].
	(aCommand = $b) ifTrue: [ ^cardinalPoint new moveBackwards: self].
	(aCommand = $l) ifTrue: [ ^cardinalPoint := cardinalPoint new left].
	(aCommand =  $r) ifTrue: [ ^cardinalPoint := cardinalPoint new right].
	
	self error: self class invalidCommandError

	

		! !


!MarsRover methodsFor: 'accessing' stamp: 'JR 5/16/2021 20:11:15'!
isAt: aPoint heading: aCardinalPoint
	
	^(position = aPoint) and: [cardinalPoint = aCardinalPoint]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Ejercicio-MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'error descriptions' stamp: 'JR 5/16/2021 21:22:01'!
invalidCommandError

	^'invalid command'! !


!MarsRover class methodsFor: 'instance creation' stamp: 'JR 5/16/2021 20:08:10'!
at: aPoint heading: aCardinalPoint 
	
	^self new initializeAt: aPoint heading: aCardinalPoint ! !
