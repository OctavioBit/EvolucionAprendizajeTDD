!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'tests' stamp: 'JPF 5/15/2021 11:49:56'!
test01ShouldStayInTheSamePositionThatWasCreated
	
	| marsRover |
	
	marsRover _ MarsRover facingNorthStartingAt: 0@0 .
	
	self assert: (marsRover isFacingNorthAt: 0@0).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JPF 5/15/2021 11:50:08'!
test02ShouldStayInTheSamePositionWhenCommandStringIsEmpty
	
	| marsRover |
	
	marsRover _ MarsRover facingNorthStartingAt: 0@0 .
	
	marsRover processCommands: ''.
	
	self assert: (marsRover isFacingNorthAt: 0@0).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JPF 5/15/2021 11:50:25'!
test03ShouldFaceWestWhenProcessLCommand
	
	| marsRover |
	
	marsRover _ MarsRover facingNorthStartingAt: 0@0 .
	
	marsRover processCommands: 'l'.
	
	self assert: (marsRover isFacingWestAt: 0@0).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JPF 5/15/2021 11:50:41'!
test04ShouldFaceEastWhenProcessRCommand
	
	| marsRover |
	
	marsRover _ MarsRover facingNorthStartingAt: 0@0 .
	
	marsRover processCommands: 'r'.
	
	self assert: (marsRover isFacingEastAt: 0@0).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JPF 5/15/2021 11:50:58'!
test05ShouldMoveForwardWhenProcessFCommand
	
	| marsRover |
	
	marsRover _ MarsRover facingNorthStartingAt: 0@0 .
	
	marsRover processCommands: 'f'.
	
	self assert: (marsRover isFacingNorthAt: 0@1).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JPF 5/15/2021 11:51:18'!
test06ShouldMoveBackwardsWhenProcessBCommand
	
	| marsRover |
	
	marsRover _ MarsRover facingNorthStartingAt: 0@0 .
	
	marsRover processCommands: 'b'.
	
	self assert: (marsRover isFacingNorthAt: 0@-1).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JPF 5/15/2021 11:51:34'!
test07ShouldFaceOppositeDirectionWhenProcessLLCommand
	
	| marsRover |
	
	marsRover _ MarsRover facingNorthStartingAt: 0@0 .
	
	marsRover processCommands: 'll'.
	
	self assert: (marsRover isFacingSouthAt: 0@0).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JPF 5/15/2021 11:51:47'!
test08ShouldFaceOppositeDirectionWhenProcessRRCommand
	
	| marsRover |
	
	marsRover _ MarsRover facingNorthStartingAt: 0@0 .
	
	marsRover processCommands: 'rr'.
	
	self assert: (marsRover isFacingSouthAt: 0@0).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JPF 5/15/2021 11:52:03'!
test09ShouldFaceWestAndAdvance1PositionToWestWhenProcessLFCommand
	
	| marsRover |
	
	marsRover _ MarsRover facingNorthStartingAt: 0@0 .
	
	marsRover processCommands: 'lf'.
	
	self assert: (marsRover isFacingWestAt: -1@0).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JPF 5/15/2021 11:52:21'!
test10ShouldFaceEastAndAdvance1PositionToEastWhenProcessRFCommand
	
	| marsRover |
	
	marsRover _ MarsRover facingNorthStartingAt: 0@0 .
	
	marsRover processCommands: 'rf'.
	
	self assert: (marsRover isFacingEastAt: 1@0).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JPF 5/15/2021 11:52:39'!
test11ShouldFaceWestAndAdvance1PositionToEastWhenProcessLBCommand
	
	| marsRover |
	
	marsRover _ MarsRover facingNorthStartingAt: 0@0 .
	
	marsRover processCommands: 'lb'.
	
	self assert: (marsRover isFacingWestAt: 1@0).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JPF 5/15/2021 11:52:56'!
test12ShouldFaceSouthAndAdvance1PositionToWestAndOnePositionToSouthWhenProcessLFLFCommand
	
	| marsRover |
	
	marsRover _ MarsRover facingNorthStartingAt: 0@0 .
	
	marsRover processCommands: 'lflf'.
	
	self assert: (marsRover isFacingSouthAt: -1@-1).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JPF 5/15/2021 11:53:11'!
test13ShouldProcessCommandsUntilStrangeCommandCharacter
	
	| marsRover |
	
	marsRover _ MarsRover facingNorthStartingAt: 0@0 .
	
	marsRover processCommands: 'lfalf'.
	
	self assert: (marsRover isFacingWestAt: -1@0).! !


!classDefinition: #CardinalDirection category: 'MarsRover'!
Object subclass: #CardinalDirection
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalDirection methodsFor: 'actions' stamp: 'JPF 5/15/2021 10:59:40'!
moveBackwards
	
	self subclassResponsibility! !

!CardinalDirection methodsFor: 'actions' stamp: 'JPF 5/15/2021 10:59:33'!
moveForward
	
	self subclassResponsibility! !

!CardinalDirection methodsFor: 'actions' stamp: 'JPF 5/15/2021 10:59:20'!
turnLeft
	
	self subclassResponsibility! !

!CardinalDirection methodsFor: 'actions' stamp: 'JPF 5/15/2021 10:59:26'!
turnRight
	
	self subclassResponsibility! !


!CardinalDirection methodsFor: 'initialization' stamp: 'JPF 5/15/2021 11:19:36'!
initializeFor: aMarsRover	
	
	marsRover _ aMarsRover.! !


!CardinalDirection methodsFor: 'testing' stamp: 'JPF 5/15/2021 11:57:21'!
isFacingEast

	self subclassResponsibility! !

!CardinalDirection methodsFor: 'testing' stamp: 'JPF 5/15/2021 11:57:26'!
isFacingNorth

	self subclassResponsibility! !

!CardinalDirection methodsFor: 'testing' stamp: 'JPF 5/15/2021 11:57:31'!
isFacingSouth

	self subclassResponsibility! !

!CardinalDirection methodsFor: 'testing' stamp: 'JPF 5/15/2021 11:57:18'!
isFacingWest

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalDirection class' category: 'MarsRover'!
CardinalDirection class
	instanceVariableNames: ''!

!CardinalDirection class methodsFor: 'instance creation' stamp: 'JPF 5/15/2021 11:18:14'!
for: aMarsRover
	
	^ self new initializeFor: aMarsRover.! !


!classDefinition: #EastDirection category: 'MarsRover'!
CardinalDirection subclass: #EastDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!EastDirection methodsFor: 'actions' stamp: 'JPF 5/15/2021 11:27:50'!
moveBackwards
	
	marsRover addDisplacement: -1@0.! !

!EastDirection methodsFor: 'actions' stamp: 'JPF 5/15/2021 11:27:22'!
moveForward
	
	marsRover addDisplacement: 1@0. ! !

!EastDirection methodsFor: 'actions' stamp: 'JPF 5/15/2021 11:01:56'!
turnLeft
	
	marsRover turnLeftWhenFacingEast. ! !

!EastDirection methodsFor: 'actions' stamp: 'JPF 5/15/2021 11:20:42'!
turnRight
	
	marsRover turnRightWhenFacingEast.! !


!EastDirection methodsFor: 'testing' stamp: 'JPF 5/15/2021 11:45:38'!
isFacingEast

	^ true.! !

!EastDirection methodsFor: 'testing' stamp: 'JPF 5/15/2021 11:45:46'!
isFacingNorth

	^ false.! !

!EastDirection methodsFor: 'testing' stamp: 'JPF 5/15/2021 11:45:56'!
isFacingSouth

	^ false.! !

!EastDirection methodsFor: 'testing' stamp: 'JPF 5/15/2021 11:46:02'!
isFacingWest

	^ false.! !


!classDefinition: #NorthDirection category: 'MarsRover'!
CardinalDirection subclass: #NorthDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!NorthDirection methodsFor: 'actions' stamp: 'JPF 5/15/2021 11:28:09'!
moveBackwards
	
	marsRover addDisplacement: 0@-1. ! !

!NorthDirection methodsFor: 'actions' stamp: 'JPF 5/15/2021 11:25:54'!
moveForward
	
	marsRover addDisplacement: 0@1. ! !

!NorthDirection methodsFor: 'actions' stamp: 'JPF 5/15/2021 11:02:19'!
turnLeft
	
	marsRover turnLeftWhenFacingNorth. ! !

!NorthDirection methodsFor: 'actions' stamp: 'JPF 5/15/2021 11:21:03'!
turnRight
	
	marsRover turnRightWhenFacingNorth. ! !


!NorthDirection methodsFor: 'testing' stamp: 'JPF 5/15/2021 11:46:29'!
isFacingEast

	^ false.! !

!NorthDirection methodsFor: 'testing' stamp: 'JPF 5/15/2021 11:46:36'!
isFacingNorth

	^ true.! !

!NorthDirection methodsFor: 'testing' stamp: 'JPF 5/15/2021 11:46:42'!
isFacingSouth

	^ false.! !

!NorthDirection methodsFor: 'testing' stamp: 'JPF 5/15/2021 11:46:47'!
isFacingWest

	^ false.! !


!classDefinition: #SouthDirection category: 'MarsRover'!
CardinalDirection subclass: #SouthDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!SouthDirection methodsFor: 'actions' stamp: 'JPF 5/15/2021 11:28:24'!
moveBackwards
	
	marsRover addDisplacement: 0@1.  ! !

!SouthDirection methodsFor: 'actions' stamp: 'JPF 5/15/2021 11:25:38'!
moveForward
	
	marsRover addDisplacement: 0@-1. ! !

!SouthDirection methodsFor: 'actions' stamp: 'JPF 5/15/2021 11:02:38'!
turnLeft
	
	marsRover turnLeftWhenFacingSouth. ! !

!SouthDirection methodsFor: 'actions' stamp: 'JPF 5/15/2021 11:21:23'!
turnRight
	
	marsRover turnRightWhenFacingSouth. ! !


!SouthDirection methodsFor: 'testing' stamp: 'JPF 5/15/2021 11:46:59'!
isFacingEast

	^ false.! !

!SouthDirection methodsFor: 'testing' stamp: 'JPF 5/15/2021 11:47:05'!
isFacingNorth

	^ false.! !

!SouthDirection methodsFor: 'testing' stamp: 'JPF 5/15/2021 11:47:13'!
isFacingSouth

	^ true.! !

!SouthDirection methodsFor: 'testing' stamp: 'JPF 5/15/2021 11:47:19'!
isFacingWest

	^ false.! !


!classDefinition: #WestDirection category: 'MarsRover'!
CardinalDirection subclass: #WestDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!WestDirection methodsFor: 'actions' stamp: 'JPF 5/15/2021 11:28:39'!
moveBackwards
	
	marsRover addDisplacement: 1@0.   ! !

!WestDirection methodsFor: 'actions' stamp: 'JPF 5/15/2021 11:25:06'!
moveForward
	
	marsRover addDisplacement: -1@0. ! !

!WestDirection methodsFor: 'actions' stamp: 'JPF 5/15/2021 11:02:59'!
turnLeft
	
	marsRover turnLeftWhenFacingWest. ! !

!WestDirection methodsFor: 'actions' stamp: 'JPF 5/15/2021 11:21:41'!
turnRight
	
	marsRover turnRightWhenFacingWest. ! !


!WestDirection methodsFor: 'testing' stamp: 'JPF 5/15/2021 11:47:32'!
isFacingEast

	^ false.! !

!WestDirection methodsFor: 'testing' stamp: 'JPF 5/15/2021 11:47:37'!
isFacingNorth

	^ false.! !

!WestDirection methodsFor: 'testing' stamp: 'JPF 5/15/2021 11:47:43'!
isFacingSouth

	^ false.! !

!WestDirection methodsFor: 'testing' stamp: 'JPF 5/15/2021 11:47:49'!
isFacingWest

	^ true.! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'coordenates direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'JPF 5/15/2021 11:58:46'!
initializeFacingEastStartingAt: aCoordenates  
	
	coordenates := aCoordenates.
	direction := EastDirection for: self.! !

!MarsRover methodsFor: 'initialization' stamp: 'JPF 5/15/2021 11:15:24'!
initializeFacingNorthStartingAt: aCoordenates  
	
	coordenates := aCoordenates.
	direction := NorthDirection for: self.! !

!MarsRover methodsFor: 'initialization' stamp: 'JPF 5/15/2021 11:58:25'!
initializeFacingSouthStartingAt: aCoordenates  
	
	coordenates := aCoordenates.
	direction := SouthDirection for: self.! !

!MarsRover methodsFor: 'initialization' stamp: 'JPF 5/15/2021 11:58:36'!
initializeFacingWestStartingAt: aCoordenates  
	
	coordenates := aCoordenates.
	direction := WestDirection for: self.! !


!MarsRover methodsFor: 'testing' stamp: 'JPF 5/15/2021 11:49:03'!
isFacingEastAt: aCoordenates

	^ coordenates = aCoordenates and: [ direction isFacingEast ].! !

!MarsRover methodsFor: 'testing' stamp: 'JPF 5/15/2021 11:48:21'!
isFacingNorthAt: aCoordenates

	^ coordenates = aCoordenates and: [ direction isFacingNorth ].! !

!MarsRover methodsFor: 'testing' stamp: 'JPF 5/15/2021 11:48:39'!
isFacingSouthAt: aCoordenates

	^ coordenates = aCoordenates and: [ direction isFacingSouth ].! !

!MarsRover methodsFor: 'testing' stamp: 'JPF 5/15/2021 11:48:49'!
isFacingWestAt: aCoordenates

	^ coordenates = aCoordenates and: [ direction isFacingWest ].! !

!MarsRover methodsFor: 'testing' stamp: 'JPF 5/15/2021 10:46:15'!
isInvalidCommand: aCommand

	^ aCommand ~= $l and: [
		aCommand ~= $r and: [
			aCommand ~= $f and: [
				aCommand ~= $b] ] ].
	
	! !


!MarsRover methodsFor: 'private actions' stamp: 'JPF 5/15/2021 11:31:09'!
addDisplacement: aDisplacementCoordenates
	
	coordenates _ coordenates + aDisplacementCoordenates.! !

!MarsRover methodsFor: 'private actions' stamp: 'JPF 5/15/2021 10:18:20'!
processSingleCommand: aCommand

	aCommand = $l ifTrue: [^ self turnLeft ].
	aCommand = $r ifTrue: [^ self turnRight ].
	aCommand = $f ifTrue: [^ self moveForward ].
	aCommand = $b ifTrue: [^ self moveBackwards ].! !

!MarsRover methodsFor: 'private actions' stamp: 'JPF 5/15/2021 11:07:04'!
turnLeftWhenFacingEast
	
	direction _ NorthDirection for: self.! !

!MarsRover methodsFor: 'private actions' stamp: 'JPF 5/15/2021 11:06:30'!
turnLeftWhenFacingNorth
	
	direction _ WestDirection for: self.! !

!MarsRover methodsFor: 'private actions' stamp: 'JPF 5/15/2021 11:06:40'!
turnLeftWhenFacingSouth
	
	direction _ EastDirection for: self.! !

!MarsRover methodsFor: 'private actions' stamp: 'JPF 5/15/2021 11:06:49'!
turnLeftWhenFacingWest
	
	direction _ SouthDirection for: self.! !

!MarsRover methodsFor: 'private actions' stamp: 'JPF 5/15/2021 11:29:26'!
turnRightWhenFacingEast
	
	direction _ SouthDirection for: self.! !

!MarsRover methodsFor: 'private actions' stamp: 'JPF 5/15/2021 11:29:41'!
turnRightWhenFacingNorth
	
	direction _ EastDirection for: self.! !

!MarsRover methodsFor: 'private actions' stamp: 'JPF 5/15/2021 11:29:56'!
turnRightWhenFacingSouth
	
	direction _ WestDirection for: self.! !

!MarsRover methodsFor: 'private actions' stamp: 'JPF 5/15/2021 11:30:16'!
turnRightWhenFacingWest
	
	direction _ NorthDirection for: self.! !


!MarsRover methodsFor: 'actions' stamp: 'JPF 5/15/2021 11:55:28'!
moveBackwards
	
	direction moveBackwards.! !

!MarsRover methodsFor: 'actions' stamp: 'JPF 5/15/2021 11:55:22'!
moveForward
	
	direction moveForward.! !

!MarsRover methodsFor: 'actions' stamp: 'JPF 5/15/2021 10:45:06'!
processCommands: aStringOfCommands

	aStringOfCommands do: [:aCommand |
		(self isInvalidCommand: aCommand) ifTrue: [^ self ].
		self processSingleCommand: aCommand.
		].! !

!MarsRover methodsFor: 'actions' stamp: 'JPF 5/15/2021 11:55:08'!
turnLeft

	direction turnLeft.! !

!MarsRover methodsFor: 'actions' stamp: 'JPF 5/15/2021 11:55:15'!
turnRight

	direction turnRight.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'JPF 5/15/2021 11:16:25'!
facingNorthStartingAt: aCoordenates 
	
	
	^self new initializeFacingNorthStartingAt: aCoordenates .! !
