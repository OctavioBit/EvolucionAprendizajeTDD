!classDefinition: #MarsRoverTest category: #MarsRover!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'tests' stamp: 'MS 10/25/2020 17:52:59'!
test01MarsRoverHasPostionAndDirection

|MyRover|

MyRover := MarsRover initializeInPosition: 0@0 facing: $N.

self assert: MyRover position = (0@0).
self assert: MyRover direction = $N. ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MS 10/25/2020 17:56:18'!
test02CanMoveForward

|MyRover|

MyRover := MarsRover initializeInPosition: 0@0 facing: $N.
MyRover processCommands: 'f'.

self assert: MyRover position = (0@1).
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MS 10/25/2020 17:56:28'!
test03CanMoveBackwards

|MyRover|

MyRover := MarsRover initializeInPosition: 0@0 facing: $N.
MyRover processCommands: 'b'.

self assert: MyRover position = (0@-1).
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MS 10/25/2020 17:56:37'!
test04CanRotateRight

|MyRover|

MyRover := MarsRover initializeInPosition: 0@0 facing: $N.
MyRover processCommands: 'r'.

self assert: MyRover direction = $E.
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MS 10/25/2020 17:56:44'!
test05CanRotateLeft

|MyRover|

MyRover := MarsRover initializeInPosition: 0@0 facing: $N.
MyRover processCommands: 'l'.

self assert: MyRover direction = $O.
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MS 10/25/2020 17:55:53'!
test06MovingDoesNotAlterTheDirection

|MyRover|

MyRover := MarsRover initializeInPosition: 0@0 facing: $N.
MyRover processCommands: 'f'.

self assert: MyRover direction = $N.
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MS 10/25/2020 17:57:13'!
test07RotatingDoesNotAlterPosition

|MyRover|

MyRover := MarsRover initializeInPosition: 0@0 facing: $N.
MyRover processCommands: 'r'.

self assert: MyRover position = (0@0).
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MS 10/25/2020 19:32:26'!
test08DoesNotProcessInvalidCommands

|MyRover|

MyRover := MarsRover initializeInPosition: 0@0 facing: $N.

self should: [MyRover processCommands: 'a']
	
	raise: Error
		withMessageText: MarsRover invalidCommandErrorDescription.


self assert: MyRover position = (0@0).
self assert: MyRover direction = $N.
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MS 10/25/2020 18:52:29'!
test09canProcessMultipleMoveCommands

|MyRover|

MyRover := MarsRover initializeInPosition: 0@0 facing: $N.
MyRover processCommands: 'fb'.

self assert: MyRover position = (0@0).
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MS 10/25/2020 18:53:15'!
test10canProcessMultipleRotateCommands

|MyRover|

MyRover := MarsRover initializeInPosition: 0@0 facing: $N.
MyRover processCommands: 'rr'.

self assert: MyRover direction = $S.
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MS 10/25/2020 18:54:31'!
test11MovesTowardsItsDirection

|MyRover|

MyRover := MarsRover initializeInPosition: 0@0 facing: $E.
MyRover processCommands: 'f'.

self assert: MyRover position = (1@0).
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MS 10/25/2020 19:12:52'!
test12MarsRoverCantHaveAnInvalidPosition

self should: [MarsRover initializeInPosition: 0 facing: $N.]
	
	raise: Error
		withMessageText: MarsRover invalidPositionErrorDescription.
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'MS 10/25/2020 19:34:29'!
test13MarsRoverCantHaveAnInvalidDirection

self should: [MarsRover initializeInPosition: (0@0) facing: 0.]
	
	raise: Error
		withMessageText: MarsRover invalidDirectionErrorDescription.
! !


!classDefinition: #Compass category: #MarsRover!
Object subclass: #Compass
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Compass class' category: #MarsRover!
Compass class
	instanceVariableNames: ''!

!Compass class methodsFor: 'convertions' stamp: 'MS 10/25/2020 20:01:31'!
charToDegree: aChar

	aChar = $N ifTrue:[^0].
	aChar = $E ifTrue:[^90].
	aChar = $S ifTrue:[^180].
	aChar = $O ifTrue:[^270].! !

!Compass class methodsFor: 'convertions' stamp: 'MS 10/25/2020 20:11:19'!
degreeToChar: aDegree

	|NormalizedDegree|

	NormalizedDegree := aDegree \\ 360.
	
	NormalizedDegree = 0 ifTrue:[^$N].
	NormalizedDegree = 90 ifTrue:[^$E].
	NormalizedDegree = 180 ifTrue:[^$S].
	NormalizedDegree = 270 ifTrue:[^$O].! !


!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'direction position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'MS 10/25/2020 20:02:57'!
initializeInPosition: aPoint facing: aDirection 
	
	position := aPoint.
	direction := Compass charToDegree: aDirection.! !


!MarsRover methodsFor: 'accessing' stamp: 'MS 10/25/2020 20:03:20'!
direction

	^Compass degreeToChar: direction.! !

!MarsRover methodsFor: 'accessing' stamp: 'MS 10/25/2020 20:30:03'!
getMovementFromFacingDirection

	|xAxis yAxis|
	
	xAxis := (direction/90) odd ifTrue:[1] ifFalse: [0]	.
	yAxis := (direction/90) even ifTrue:[1] ifFalse:[0].
	
	^(xAxis@yAxis)! !

!MarsRover methodsFor: 'accessing' stamp: 'MS 10/25/2020 16:34:26'!
position
	^position.! !


!MarsRover methodsFor: 'testing' stamp: 'MS 10/25/2020 18:21:12'!
isMovementCommand: aCommand

	^ aCommand = $f or: [aCommand = $b]! !

!MarsRover methodsFor: 'testing' stamp: 'MS 10/25/2020 18:21:27'!
isRotationCommand: aCommand

	^ aCommand = $r or: [aCommand = $l]! !


!MarsRover methodsFor: 'actions--private' stamp: 'MS 10/25/2020 20:14:53'!
RotateLeft

	direction := direction -90.! !

!MarsRover methodsFor: 'actions--private' stamp: 'MS 10/25/2020 20:14:26'!
RotateRight

	direction := direction + 90.! !

!MarsRover methodsFor: 'actions--private' stamp: 'MS 10/25/2020 20:29:38'!
move: aDirection

	^ aDirection = $f 
			ifTrue: [position:= position + self getMovementFromFacingDirection]
			ifFalse: [position := position - self getMovementFromFacingDirection]! !

!MarsRover methodsFor: 'actions--private' stamp: 'MS 10/25/2020 18:30:24'!
rotate: aDirection

	^ aDirection = $l 
				ifTrue: [self RotateLeft]
				ifFalse: [self RotateRight]! !


!MarsRover methodsFor: 'actions' stamp: 'MS 10/25/2020 18:23:43'!
processCommands: aString 
	
	aString do:[:aCommand |
		self assertIsValidCommand: aCommand.
	
		(self isMovementCommand: aCommand) 
			ifTrue: [self move: aCommand].
		(self isRotationCommand: aCommand) 
			ifTrue: [ self rotate: aCommand]].! !


!MarsRover methodsFor: 'signals' stamp: 'MS 10/25/2020 17:47:04'!
signalInvalidCommand

	self error: self class invalidCommandErrorDescription! !


!MarsRover methodsFor: 'assertions' stamp: 'MS 10/25/2020 18:22:22'!
assertIsValidCommand: aCommand 
	
	((self isMovementCommand: aCommand) or: [self isRotationCommand: aCommand]) ifFalse: [self signalInvalidCommand].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'MS 10/25/2020 19:35:11'!
initializeInPosition: aPoint facing: aDirection 

	self assertIsValidPosition: aPoint.
	self assertIsValidDirection: aDirection.

	^self new initializeInPosition: aPoint facing: aDirection. ! !


!MarsRover class methodsFor: 'error handling' stamp: 'MS 10/25/2020 17:45:17'!
invalidCommandErrorDescription
	
	^'Invalid Command'.! !

!MarsRover class methodsFor: 'error handling' stamp: 'MS 10/25/2020 19:33:37'!
invalidDirectionErrorDescription
	
	^'Invalid Direction'.! !

!MarsRover class methodsFor: 'error handling' stamp: 'MS 10/25/2020 19:12:24'!
invalidPositionErrorDescription
	
	^'Invalid position'! !


!MarsRover class methodsFor: 'assertions' stamp: 'MS 10/25/2020 19:39:53'!
assertIsValidDirection: aDirection 
	(aDirection = $N or:[aDirection = $E or: [aDirection = $S or:[aDirection =  $W]]])
		ifFalse:[self error: self invalidDirectionErrorDescription].! !

!MarsRover class methodsFor: 'assertions' stamp: 'MS 10/25/2020 19:12:24'!
assertIsValidPosition: aPoint 
	
	(aPoint isKindOf: Point) ifFalse:[self error: self invalidPositionErrorDescription].! !
