!classDefinition: #MarsRoverTest category: 'Ejercicio-16-MARS-ROVER'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-16-MARS-ROVER'!

!MarsRoverTest methodsFor: 'test' stamp: 'IO 10/25/2020 19:01:58'!
test01marsRoverMovesForward
	self assertAMarsRoverStartsPointingTo: South andMovesForwardTo: -1@0.
! !

!MarsRoverTest methodsFor: 'test' stamp: 'IO 10/25/2020 18:54:00'!
test02marsRoverMovesBackwards
	| aMarsRover |
	aMarsRover := MarsRover at: 0@0 pointingTo: South.

	aMarsRover execute: 'b'.
	
	self assert: 1@0 equals: aMarsRover position.
! !

!MarsRoverTest methodsFor: 'test' stamp: 'IO 10/25/2020 19:03:56'!
test03marsRoverMovesForwardToNorth
	self assertAMarsRoverStartsPointingTo: North andMovesForwardTo: 1@0.! !

!MarsRoverTest methodsFor: 'test' stamp: 'IO 10/25/2020 19:04:09'!
test04marsRoverMovesForwardToEast
	self assertAMarsRoverStartsPointingTo: East andMovesForwardTo: 0@1.
! !

!MarsRoverTest methodsFor: 'test' stamp: 'IO 10/25/2020 19:04:26'!
test05marsRoverMovesForwardToWest
	self assertAMarsRoverStartsPointingTo: West andMovesForwardTo: 0@-1.
! !

!MarsRoverTest methodsFor: 'test' stamp: 'IO 10/25/2020 19:10:04'!
test06marsRoverRotatesLeftFromSouth
	self assertAMarsRoverStartsOrientedTo: South andRotatesLeftTo: West.
! !

!MarsRoverTest methodsFor: 'test' stamp: 'IO 10/25/2020 19:09:44'!
test07marsRoverRotatesLeftFromWest
	self assertAMarsRoverStartsOrientedTo: West andRotatesLeftTo: North.
! !

!MarsRoverTest methodsFor: 'test' stamp: 'IO 10/25/2020 19:10:09'!
test08marsRoverRotatesLeftFromNorth
	self assertAMarsRoverStartsOrientedTo: North andRotatesLeftTo: East.
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'IO 10/25/2020 19:10:14'!
test09marsRoverRotatesLeftFromEast
	self assertAMarsRoverStartsOrientedTo: East andRotatesLeftTo: South.
! !

!MarsRoverTest methodsFor: 'test' stamp: 'IO 10/25/2020 19:15:39'!
test10marsRoverRotatesRigthFromEast
	self assertAMarsRoverStartsOrientedTo: East andRotatesRightTo: North.
! !

!MarsRoverTest methodsFor: 'test' stamp: 'IO 10/25/2020 19:15:45'!
test11marsRoverRotatesRigthFromNorth
	self assertAMarsRoverStartsOrientedTo: North andRotatesRightTo: West.
! !

!MarsRoverTest methodsFor: 'test' stamp: 'IO 10/25/2020 19:15:58'!
test12marsRoverRotatesRigthFromWest
	self assertAMarsRoverStartsOrientedTo: West andRotatesRightTo: South.
! !

!MarsRoverTest methodsFor: 'test' stamp: 'IO 10/25/2020 19:16:09'!
test13marsRoverRotatesRigthFromSouth
	self assertAMarsRoverStartsOrientedTo: South andRotatesRightTo: East.
! !

!MarsRoverTest methodsFor: 'test' stamp: 'IO 10/25/2020 19:22:36'!
test14marsRoverExecutesPacksWithMoreThanOneCommand
	| aMarsRover |
	aMarsRover := MarsRover at: 0@0 pointingTo: South.

	aMarsRover execute: 'ff'.
	
	self assert: -2@0 equals: aMarsRover position.
	self assert: South equals: aMarsRover orientation.
! !

!MarsRoverTest methodsFor: 'test' stamp: 'IO 10/25/2020 19:29:09'!
test15marsRoverSignalsOnErrorAndStopsExecuting
	self assertReturnsAMarsRoverThatMovedForwardAndFailed.

! !

!MarsRoverTest methodsFor: 'test' stamp: 'IO 10/25/2020 19:29:02'!
test16marsRoverStartsExecutingAgainOnNewPackAfterError
	| aMarsRover |
	aMarsRover := 	self assertReturnsAMarsRoverThatMovedForwardAndFailed.

	aMarsRover execute: 'f'.	

	self assert: -2@0 equals: aMarsRover position.
	self assert: South equals: aMarsRover orientation.
	! !


!MarsRoverTest methodsFor: 'test tools' stamp: 'IO 10/25/2020 19:18:41'!
assertAMarsRoverStartsOrientedTo: aCardinalDirection andRotateWith: aRotationCommandPack To: anotherCardinalDirection

	"
		create a Mars Rover at 0@0 oriented to a given position. Will execute the rotation command pack (that has a single
		command of orientation rotation) and assert it is finally oriented to the other given cardinal direction.
	"

	|aMarsRover|
	aMarsRover := MarsRover at: 0@0 pointingTo: aCardinalDirection.
	aMarsRover execute: aRotationCommandPack.
	
	self assert: anotherCardinalDirection equals: aMarsRover orientation.
	! !

!MarsRoverTest methodsFor: 'test tools' stamp: 'IO 10/25/2020 19:20:36'!
assertAMarsRoverStartsOrientedTo: aCardinalDirection andRotatesLeftTo: anotherCardinalDirection

	"
		see assertAMarsRoverStartsOrientedTo:andRotateWith:To: implementation
		will execute 'l' command pack
	"

	self assertAMarsRoverStartsOrientedTo: aCardinalDirection andRotateWith: 'l' To: anotherCardinalDirection
	! !

!MarsRoverTest methodsFor: 'test tools' stamp: 'IO 10/25/2020 19:20:28'!
assertAMarsRoverStartsOrientedTo: aCardinalDirection andRotatesRightTo: anotherCardinalDirection

	"
		see assertAMarsRoverStartsOrientedTo:andRotateWith:To: implementation
		will execute 'r' command pack
	"

	self assertAMarsRoverStartsOrientedTo: aCardinalDirection andRotateWith: 'r' To: anotherCardinalDirection
	! !

!MarsRoverTest methodsFor: 'test tools' stamp: 'IO 10/25/2020 19:03:10'!
assertAMarsRoverStartsPointingTo: aCardinalDirection andMovesForwardTo: aPosition

	"
		create a Mars Rover at 0@0 oriented to a given position. Will execute 'f' command pack and assert
		it finally steps on a given position.
	"

	| aMarsRover |
	aMarsRover := MarsRover at: 0@0 pointingTo: aCardinalDirection.

	aMarsRover execute: 'f'.
	
	self assert: aPosition equals: aMarsRover position.
	! !

!MarsRoverTest methodsFor: 'test tools' stamp: 'IO 10/25/2020 19:30:30'!
assertReturnsAMarsRoverThatMovedForwardAndFailed

	"
		create a new mars rover and execute a pack that will move the mars rover forward once, and then execute a
		failling command.
		Implementaiton details: this method returns the Mars Rover to be tested after received package failures.
	"

	| aMarsRover |
	aMarsRover := MarsRover at: 0@0 pointingTo: South.

	self
		should: [	aMarsRover execute: 'fxf'.]
		raise: Error
		withMessageText: MarsRover invalidCommandError.

	self assert: -1@0 equals: aMarsRover position.
	self assert: South equals: aMarsRover orientation.
	
	^aMarsRover.

! !


!MarsRoverTest methodsFor: 'integration test' stamp: 'IO 10/25/2020 21:27:00'!
test17marsRoverIntegration

	"this test was built without TDD"
	
	| aMarsRover |
	aMarsRover := MarsRover at: 0@0 pointingTo: North.


	self
		should: [	aMarsRover execute: 'fflfxrb'.]
		raise: Error
		withMessageText: MarsRover invalidCommandError.
		
	self assert: 2@1 equals: aMarsRover position.
	self assert: East equals: aMarsRover orientation.
	
	aMarsRover execute: 'rb'.
	
	self assert: 1@1 equals: aMarsRover position.
	self assert: North equals: aMarsRover orientation.
	
	aMarsRover execute: 'rfffrb'.
	
	self assert: 2@-2 equals: aMarsRover position.
	self assert: South equals: aMarsRover orientation.

! !


!classDefinition: #CardinalDirection category: 'Ejercicio-16-MARS-ROVER'!
Object subclass: #CardinalDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-16-MARS-ROVER'!

!CardinalDirection methodsFor: 'rotation operations' stamp: 'IO 10/25/2020 18:02:39'!
clockwise90degrees

	"return the cardinal direction when rotating 90 degrees clockwise"

	self subclassResponsibility.
! !

!CardinalDirection methodsFor: 'rotation operations' stamp: 'IO 10/25/2020 18:02:42'!
counterclockwise90degrees

	"return the cardinal direction when rotating 90 degrees counterclockwise"

	self subclassResponsibility.
! !


!CardinalDirection methodsFor: 'converting' stamp: 'IO 10/25/2020 18:34:39'!
asPoint

	"
		returns the point representing this cardinal direction.
		Implementation details: we consider a Cardinal Direction can be represented by a point indicating
		the direction as a 1 unit from the 0@0. This is useful when operating movements over different
		directions
	"

	self subclassResponsibility.
! !


!classDefinition: #East category: 'Ejercicio-16-MARS-ROVER'!
CardinalDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-16-MARS-ROVER'!

!East methodsFor: 'converters' stamp: 'IO 10/25/2020 17:57:30'!
asPoint

	"see superimplementor"
	
	^0@1.
! !


!East methodsFor: 'rotation operations' stamp: 'IO 10/25/2020 17:57:52'!
clockwise90degrees

	"see superimplementor"

	^North new.
! !

!East methodsFor: 'rotation operations' stamp: 'IO 10/25/2020 17:57:57'!
counterclockwise90degrees

	"see superimplementor"

	^South new.
! !


!classDefinition: #North category: 'Ejercicio-16-MARS-ROVER'!
CardinalDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-16-MARS-ROVER'!

!North methodsFor: 'converters' stamp: 'IO 10/25/2020 18:57:21'!
asPoint

	"see superimplementor"

	^1@0.
! !


!North methodsFor: 'rotation operations' stamp: 'IO 10/25/2020 18:00:01'!
clockwise90degrees

	"see superimplementor"

	^West new.
! !

!North methodsFor: 'rotation operations' stamp: 'IO 10/25/2020 18:00:06'!
counterclockwise90degrees

	"see superimplementor"

	^East new.
! !


!classDefinition: #South category: 'Ejercicio-16-MARS-ROVER'!
CardinalDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-16-MARS-ROVER'!

!South methodsFor: 'converters' stamp: 'IO 10/25/2020 18:00:39'!
asPoint

	"see superimplementor"

	^-1@0.
! !


!South methodsFor: 'rotation operations' stamp: 'IO 10/25/2020 18:00:52'!
clockwise90degrees

	"see superimplementor"

	^East new.! !

!South methodsFor: 'rotation operations' stamp: 'IO 10/25/2020 18:00:56'!
counterclockwise90degrees

	"see superimplementor"

	^West new.! !


!classDefinition: #West category: 'Ejercicio-16-MARS-ROVER'!
CardinalDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-16-MARS-ROVER'!

!West methodsFor: 'converters' stamp: 'IO 10/25/2020 18:01:25'!
asPoint

	"see superimplementor"

	^0@-1.! !


!West methodsFor: 'rotation operations' stamp: 'IO 10/25/2020 18:01:31'!
clockwise90degrees

	"see superimplementor"

	^South new.
! !

!West methodsFor: 'rotation operations' stamp: 'IO 10/25/2020 18:01:36'!
counterclockwise90degrees

	"see superimplementor"

	^North new.
! !


!classDefinition: #MarsRover category: 'Ejercicio-16-MARS-ROVER'!
Object subclass: #MarsRover
	instanceVariableNames: 'position orientationState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-16-MARS-ROVER'!

!MarsRover methodsFor: 'initialization' stamp: 'IO 10/25/2020 18:24:10'!
initializeAt: aPosition pointingTo: aCardinalDirection

	position := aPosition.
	orientationState := MarsRoverOrientationState pointingTo: aCardinalDirection.
! !


!MarsRover methodsFor: 'command receiving' stamp: 'IO 10/25/2020 18:50:41'!
execute: aCommandPack

	"execute each command in the pack"

	aCommandPack do: [ :aCommand | self executeOne: aCommand].
! !


!MarsRover methodsFor: 'accessing' stamp: 'IO 10/25/2020 18:23:21'!
orientation
	^orientationState orientation.
! !

!MarsRover methodsFor: 'accessing' stamp: 'IO 10/25/2020 18:21:43'!
position
	^position.
! !


!MarsRover methodsFor: 'command execution' stamp: 'IO 10/25/2020 18:51:47'!
executeOne: command

	"
		execute a given command. If the command is invalid will signal an error.
	"

	command = $f ifTrue: [^position := position + orientationState asPoint].
	command = $b ifTrue: [^position := position - orientationState asPoint].
	command = $l ifTrue: [^orientationState rotateLeft].
	command = $r ifTrue: [^orientationState rotateRight].

	self error: self class invalidCommandError.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Ejercicio-16-MARS-ROVER'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'LH 10/24/2020 21:07:31'!
at: aPoint pointingTo: aCardinalDirection

	^self new initializeAt: aPoint pointingTo: aCardinalDirection ! !


!MarsRover class methodsFor: 'error messages' stamp: 'IO 10/25/2020 18:46:49'!
invalidCommandError
	^'The Mars ROver received an invalid command.'.
! !


!classDefinition: #MarsRoverOrientationState category: 'Ejercicio-16-MARS-ROVER'!
Object subclass: #MarsRoverOrientationState
	instanceVariableNames: 'orientation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-16-MARS-ROVER'!

!MarsRoverOrientationState methodsFor: 'accessing' stamp: 'IO 10/25/2020 18:25:47'!
orientation

	"
		Implementation details: we consider Cardinal Directions are unique (only one North exists), so we use the
		class representing the Cardinal Direction instead of the instance.
	"

	^orientation class.
! !


!MarsRoverOrientationState methodsFor: 'rotation operations' stamp: 'IO 10/25/2020 17:00:20'!
rotateLeft
	orientation := orientation counterclockwise90degrees.
! !

!MarsRoverOrientationState methodsFor: 'rotation operations' stamp: 'IO 10/25/2020 17:01:28'!
rotateRight
	orientation := orientation clockwise90degrees.
! !


!MarsRoverOrientationState methodsFor: 'initializtion' stamp: 'IO 10/25/2020 16:49:25'!
withOrientation: aCardinalDirection
	orientation := aCardinalDirection new.
! !


!MarsRoverOrientationState methodsFor: 'converting' stamp: 'IO 10/25/2020 16:52:30'!
asPoint
	^orientation asPoint.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverOrientationState class' category: 'Ejercicio-16-MARS-ROVER'!
MarsRoverOrientationState class
	instanceVariableNames: ''!

!MarsRoverOrientationState class methodsFor: 'as yet unclassified' stamp: 'IO 10/25/2020 16:48:37'!
pointingTo: aCardinalDirection
	^self basicNew withOrientation: aCardinalDirection.
! !
