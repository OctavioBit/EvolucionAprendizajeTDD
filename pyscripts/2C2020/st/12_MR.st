!classDefinition: #MarsRoverTest category: 'Mars-Rover-Ejercicio'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Ejercicio'!

!MarsRoverTest methodsFor: 'testing' stamp: 'A C 10/24/2020 14:57:13'!
test01MoveForwardNorth
	|rover|
	rover := MarsRover newStartingAt: 0@0 pointingTo: $N mapHeight: 10 mapWidth: 10.
	rover reciveCommand: 'f'.
	self assert: (rover position = (0@1)).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'A C 10/24/2020 15:03:05'!
test02MoveForwardSouth
	|rover|
	rover := MarsRover newStartingAt: 0@3 pointingTo: $S mapHeight: 10 mapWidth: 10.
	rover reciveCommand: 'f'.
	self assert: (rover position = (0@2)).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'A C 10/24/2020 15:06:05'!
test03MoveForwardEast
	|rover|
	rover := MarsRover newStartingAt: 1@0 pointingTo: $E mapHeight: 10 mapWidth: 10.
	rover reciveCommand: 'f'.
	self assert: (rover position = (2@0)).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'A C 10/24/2020 15:08:33'!
test04MoveForwardWest
	|rover|
	rover := MarsRover newStartingAt: 2@0 pointingTo: $W mapHeight: 10 mapWidth: 10.
	rover reciveCommand: 'f'.
	self assert: (rover position = (1@0)).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'A C 10/24/2020 15:11:27'!
test05MoveBackwardNorth
	|rover|
	rover := MarsRover newStartingAt: 0@1 pointingTo: $N mapHeight: 10 mapWidth: 10.
	rover reciveCommand: 'b'.
	self assert: (rover position = (0@0)).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'A C 10/24/2020 15:17:08'!
test06MoveBackwardSouth
	|rover|
	rover := MarsRover newStartingAt: 0@5 pointingTo: $S mapHeight: 10 mapWidth: 10.
	rover reciveCommand: 'b'.
	self assert: (rover position = (0@6)).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'A C 10/24/2020 15:18:54'!
test07MoveBackwardEast
	|rover|
	rover := MarsRover newStartingAt: 4@0 pointingTo: $E mapHeight: 10 mapWidth: 10.
	rover reciveCommand: 'b'.
	self assert: (rover position = (3@0)).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'A C 10/24/2020 15:23:28'!
test08MoveBackwardWest
	|rover|
	rover := MarsRover newStartingAt: 4@0 pointingTo: $W mapHeight: 10 mapWidth: 10.
	rover reciveCommand: 'b'.
	self assert: (rover position = (5@0)).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'A C 10/24/2020 15:25:48'!
test09RotateLeftNorthToWest
	|rover|
	rover := MarsRover newStartingAt: 0@0 pointingTo: $N mapHeight: 10 mapWidth: 10.
	rover reciveCommand: 'l'.
	self assert: (rover pointingTo = $W).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'A C 10/24/2020 15:28:25'!
test10RotateLeftWestToSouth
	|rover|
	rover := MarsRover newStartingAt: 0@0 pointingTo: $W mapHeight: 10 mapWidth: 10.
	rover reciveCommand: 'l'.
	self assert: (rover pointingTo = $S).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'A C 10/24/2020 15:33:02'!
test11RotateLeftSouthToEast
	|rover|
	rover := MarsRover newStartingAt: 0@0 pointingTo: $S mapHeight: 10 mapWidth: 10.
	rover reciveCommand: 'l'.
	self assert: (rover pointingTo = $E).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'A C 10/24/2020 15:34:25'!
test12RotateLeftEastToNorth
	|rover|
	rover := MarsRover newStartingAt: 0@0 pointingTo: $E mapHeight: 10 mapWidth: 10.
	rover reciveCommand: 'l'.
	self assert: (rover pointingTo = $N).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'A C 10/24/2020 15:37:28'!
test13RotateRightNorthToEast
	|rover|
	rover := MarsRover newStartingAt: 0@0 pointingTo: $N mapHeight: 10 mapWidth: 10.
	rover reciveCommand: 'r'.
	self assert: (rover pointingTo = $E).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'A C 10/24/2020 15:37:32'!
test14RotateRightEastToSouth
	|rover|
	rover := MarsRover newStartingAt: 0@0 pointingTo: $E mapHeight: 10 mapWidth: 10.
	rover reciveCommand: 'r'.
	self assert: (rover pointingTo = $S).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'A C 10/24/2020 15:37:38'!
test15RotateRightSouthToWest
	|rover|
	rover := MarsRover newStartingAt: 0@0 pointingTo: $S mapHeight: 10 mapWidth: 10.
	rover reciveCommand: 'r'.
	self assert: (rover pointingTo = $W).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'A C 10/24/2020 15:37:41'!
test16RotateRightWestToNorth
	|rover|
	rover := MarsRover newStartingAt: 0@0 pointingTo: $W mapHeight: 10 mapWidth: 10.
	rover reciveCommand: 'r'.
	self assert: (rover pointingTo = $N).
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'A C 10/24/2020 16:46:02'!
test17LongCommand
	|rover|
	rover := MarsRover newStartingAt: 0@0 pointingTo: $N mapHeight: 10 mapWidth: 10.
	rover reciveCommand: 'fbfblrlr'.
	self assert: (rover pointingTo = $N).
	self assert: (rover position = (0@0)).

	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'A C 10/24/2020 17:10:01'!
test18IncorrectCommand
	|rover|
	rover := MarsRover newStartingAt: 0@0 pointingTo: $N mapHeight: 10 mapWidth: 10.
	rover reciveCommand: 'K'.
	self assert: (rover pointingTo = $N).
	self assert: (rover position = (0@0)).

	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'A C 10/24/2020 17:10:47'!
test19IncorrectLongCommand
	|rover|
	rover := MarsRover newStartingAt: 0@0 pointingTo: $N mapHeight: 10 mapWidth: 10.
	rover reciveCommand: 'flKrb'.
	self assert: (rover pointingTo = $W).
	self assert: (rover position = (0@1)).

	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'A C 10/24/2020 17:19:41'!
test20MoveOutOfBoundsXAxis
	|rover|
	rover := MarsRover newStartingAt: 0@0 pointingTo: $E mapHeight: 10 mapWidth: 10.
	rover reciveCommand: 'b'.
	self assert: (rover pointingTo = $E).
	self assert: (rover position = (9@0)).

	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'A C 10/24/2020 17:19:48'!
test21MoveOutOfBoundsYAxis
	|rover|
	rover := MarsRover newStartingAt: 0@0 pointingTo: $N mapHeight: 10 mapWidth: 10.
	rover reciveCommand: 'b'.
	self assert: (rover pointingTo = $N).
	self assert: (rover position = (0@9)).

	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'A C 10/24/2020 17:29:10'!
test22InitialPositionOutOfBounds
	self
		should: [	MarsRover newStartingAt: 100@100 pointingTo: $N mapHeight: 10 mapWidth: 10.]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = MarsRover InitialPositionOutOfBoundsErrorDescription ]
		

	
	
	
	

	

	! !


!classDefinition: #MarsRover category: 'Mars-Rover-Ejercicio'!
Object subclass: #MarsRover
	instanceVariableNames: 'position pointingTo height width MarsRoverPointingTowards'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Ejercicio'!

!MarsRover methodsFor: 'private' stamp: 'A C 10/24/2020 16:49:24'!
decodeInstruction: aCharacterCommand

	aCharacterCommand = $f ifTrue: [
		MarsRoverPointingTowards foward.
		].
	aCharacterCommand = $b ifTrue: [
		MarsRoverPointingTowards backwards.
		].
	aCharacterCommand = $l ifTrue: [
		MarsRoverPointingTowards rotateLeft.
		].
	aCharacterCommand = $r ifTrue: [
		MarsRoverPointingTowards rotateRight.
		].! !

!MarsRover methodsFor: 'private' stamp: 'A C 10/24/2020 17:18:04'!
inBounds
	position := ((position x mod: width) @ (position y mod: height)).! !

!MarsRover methodsFor: 'private' stamp: 'A C 10/24/2020 16:58:36'!
invalidCommand: aCharacterCommand
	'fblr' indexOf: aCharacterCommand ifAbsent: [^true.].
	^false.! !

!MarsRover methodsFor: 'private' stamp: 'A C 10/24/2020 17:16:01'!
move: aBlock
	position := aBlock value: position.
	self inBounds.! !

!MarsRover methodsFor: 'private' stamp: 'A C 10/24/2020 16:27:58'!
pointingToEast

	MarsRoverPointingTowards := PointingTowardsEast newWith: self! !

!MarsRover methodsFor: 'private' stamp: 'A C 10/24/2020 16:28:03'!
pointingToNorth

	MarsRoverPointingTowards := PointingTowardsNorth newWith: self! !

!MarsRover methodsFor: 'private' stamp: 'A C 10/24/2020 16:28:07'!
pointingToSouth

	MarsRoverPointingTowards := PointingTowardsSouth newWith: self! !

!MarsRover methodsFor: 'private' stamp: 'A C 10/24/2020 16:28:10'!
pointingToWest

	MarsRoverPointingTowards := PointingTowardsWest newWith: self! !

!MarsRover methodsFor: 'private' stamp: 'A C 10/24/2020 17:06:45'!
validateCommand: aStringCommand
	|numberOfValidCommands|
	numberOfValidCommands := (aStringCommand findFirst: [:aCharacterCommand | self invalidCommand: aCharacterCommand]) - 1.
	numberOfValidCommands = -1 ifTrue:[numberOfValidCommands := aStringCommand size].
	^aStringCommand copyFrom: 1 to: numberOfValidCommands.! !

!MarsRover methodsFor: 'private' stamp: 'A C 10/24/2020 17:28:27'!
validateInitialPosition
	(position x between: 0 and: width) ifFalse:[self error: MarsRover InitialPositionOutOfBoundsErrorDescription.].
	(position y between: 0 and: height) ifFalse:[self error: MarsRover InitialPositionOutOfBoundsErrorDescription.].! !


!MarsRover methodsFor: 'public' stamp: 'A C 10/24/2020 16:54:27'!
reciveCommand: aStringCommand
	| validatedCommand |
	validatedCommand := self validateCommand: aStringCommand.
	validatedCommand do: [:aCharacterCommand | self decodeInstruction: aCharacterCommand.].
! !


!MarsRover methodsFor: 'testing' stamp: 'A C 10/24/2020 16:34:48'!
pointingTo
	^MarsRoverPointingTowards pointingTo.
	
	! !

!MarsRover methodsFor: 'testing' stamp: 'A C 10/24/2020 15:12:37'!
position
	^position.
	
	! !


!MarsRover methodsFor: 'initialization' stamp: 'A C 10/24/2020 17:26:44'!
initializeNewStartingAt: aPoint pointingTo: aCardinalPoint mapHeight: anIntenger mapWidth: aInteger 
	position := aPoint.
	height := anIntenger.
	width := aInteger.
	self validateInitialPosition.
	aCardinalPoint = $N ifTrue: [self pointingToNorth.].
	aCardinalPoint = $E ifTrue: [self pointingToEast.].
	aCardinalPoint = $S ifTrue: [self pointingToSouth.].
	aCardinalPoint = $W ifTrue: [self pointingToWest.].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Mars-Rover-Ejercicio'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'A C 10/24/2020 17:25:50'!
newStartingAt: aPoint pointingTo: aCardinalPoint mapHeight: anIntenger mapWidth: aInteger 
	^self new initializeNewStartingAt: aPoint pointingTo: aCardinalPoint mapHeight: anIntenger mapWidth: aInteger
! !


!MarsRover class methodsFor: 'error' stamp: 'A C 10/24/2020 17:25:15'!
InitialPositionOutOfBoundsErrorDescription
	'Initial Position out of bounds!!'.! !


!classDefinition: #MarsRoverPointingTowardsState category: 'Mars-Rover-Ejercicio'!
Object subclass: #MarsRoverPointingTowardsState
	instanceVariableNames: 'MarsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Ejercicio'!

!MarsRoverPointingTowardsState methodsFor: 'private' stamp: 'A C 10/24/2020 16:16:51'!
decrementXaxis
	MarsRover move: [:position | position - (1@0)].! !

!MarsRoverPointingTowardsState methodsFor: 'private' stamp: 'A C 10/24/2020 16:17:19'!
decrementYaxis
	MarsRover move: [:position | position - (0@1)].! !

!MarsRoverPointingTowardsState methodsFor: 'private' stamp: 'A C 10/24/2020 16:17:33'!
incrementXaxis
	MarsRover move: [:position | position + (1@0)].! !

!MarsRoverPointingTowardsState methodsFor: 'private' stamp: 'A C 10/24/2020 16:17:52'!
incrementYaxis
	MarsRover move: [:position | position + (0@1)].! !


!MarsRoverPointingTowardsState methodsFor: 'subclass' stamp: 'A C 10/24/2020 15:48:43'!
backwards
	self subclassResponsibility.! !

!MarsRoverPointingTowardsState methodsFor: 'subclass' stamp: 'A C 10/24/2020 15:48:55'!
foward
	self subclassResponsibility.! !

!MarsRoverPointingTowardsState methodsFor: 'subclass' stamp: 'A C 10/24/2020 16:29:11'!
pointingTo
	self subclassResponsibility.! !

!MarsRoverPointingTowardsState methodsFor: 'subclass' stamp: 'A C 10/24/2020 15:49:07'!
rotateLeft
	self subclassResponsibility.! !

!MarsRoverPointingTowardsState methodsFor: 'subclass' stamp: 'A C 10/24/2020 15:49:16'!
rotateRight
	self subclassResponsibility.! !


!classDefinition: #PointingTowardsEast category: 'Mars-Rover-Ejercicio'!
MarsRoverPointingTowardsState subclass: #PointingTowardsEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Ejercicio'!

!PointingTowardsEast methodsFor: 'initialization' stamp: 'A C 10/24/2020 16:11:02'!
initializeWith: aMarsRover
	MarsRover := aMarsRover.! !


!PointingTowardsEast methodsFor: 'public' stamp: 'A C 10/24/2020 16:19:16'!
backwards
	self decrementXaxis.! !

!PointingTowardsEast methodsFor: 'public' stamp: 'A C 10/24/2020 16:19:29'!
foward
	self incrementXaxis.! !

!PointingTowardsEast methodsFor: 'public' stamp: 'A C 10/24/2020 16:29:30'!
pointingTo
	^$E.! !

!PointingTowardsEast methodsFor: 'public' stamp: 'A C 10/24/2020 16:31:32'!
rotateLeft
	MarsRover pointingToNorth.! !

!PointingTowardsEast methodsFor: 'public' stamp: 'A C 10/24/2020 16:31:50'!
rotateRight
	MarsRover pointingToSouth.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PointingTowardsEast class' category: 'Mars-Rover-Ejercicio'!
PointingTowardsEast class
	instanceVariableNames: ''!

!PointingTowardsEast class methodsFor: 'as yet unclassified' stamp: 'A C 10/24/2020 16:03:30'!
newWith: aMarsRover
	^self new initializeWith: aMarsRover! !


!classDefinition: #PointingTowardsNorth category: 'Mars-Rover-Ejercicio'!
MarsRoverPointingTowardsState subclass: #PointingTowardsNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Ejercicio'!

!PointingTowardsNorth methodsFor: 'initialization' stamp: 'A C 10/24/2020 16:11:02'!
initializeWith: aMarsRover
	MarsRover := aMarsRover.! !


!PointingTowardsNorth methodsFor: 'public' stamp: 'A C 10/24/2020 16:17:19'!
backwards
	self decrementYaxis.! !

!PointingTowardsNorth methodsFor: 'public' stamp: 'A C 10/24/2020 16:19:42'!
foward
	self incrementYaxis.! !

!PointingTowardsNorth methodsFor: 'public' stamp: 'A C 10/24/2020 16:29:40'!
pointingTo
	^$N.! !

!PointingTowardsNorth methodsFor: 'public' stamp: 'A C 10/24/2020 16:32:14'!
rotateLeft
	MarsRover pointingToWest.! !

!PointingTowardsNorth methodsFor: 'public' stamp: 'A C 10/24/2020 16:32:30'!
rotateRight
	MarsRover pointingToEast.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PointingTowardsNorth class' category: 'Mars-Rover-Ejercicio'!
PointingTowardsNorth class
	instanceVariableNames: ''!

!PointingTowardsNorth class methodsFor: 'as yet unclassified' stamp: 'A C 10/24/2020 16:03:29'!
newWith: aMarsRover
	^self new initializeWith: aMarsRover! !


!classDefinition: #PointingTowardsSouth category: 'Mars-Rover-Ejercicio'!
MarsRoverPointingTowardsState subclass: #PointingTowardsSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Ejercicio'!

!PointingTowardsSouth methodsFor: 'initialization' stamp: 'A C 10/24/2020 16:11:02'!
initializeWith: aMarsRover
	MarsRover := aMarsRover.! !


!PointingTowardsSouth methodsFor: 'public' stamp: 'A C 10/24/2020 16:20:02'!
backwards
	self incrementYaxis.! !

!PointingTowardsSouth methodsFor: 'public' stamp: 'A C 10/24/2020 16:17:19'!
foward
	self decrementYaxis.! !

!PointingTowardsSouth methodsFor: 'public' stamp: 'A C 10/24/2020 16:29:51'!
pointingTo
	^$S.! !

!PointingTowardsSouth methodsFor: 'public' stamp: 'A C 10/24/2020 16:37:18'!
rotateLeft
	MarsRover pointingToEast.! !

!PointingTowardsSouth methodsFor: 'public' stamp: 'A C 10/24/2020 16:37:28'!
rotateRight
	MarsRover pointingToWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PointingTowardsSouth class' category: 'Mars-Rover-Ejercicio'!
PointingTowardsSouth class
	instanceVariableNames: ''!

!PointingTowardsSouth class methodsFor: 'as yet unclassified' stamp: 'A C 10/24/2020 16:03:30'!
newWith: aMarsRover
	^self new initializeWith: aMarsRover! !


!classDefinition: #PointingTowardsWest category: 'Mars-Rover-Ejercicio'!
MarsRoverPointingTowardsState subclass: #PointingTowardsWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Ejercicio'!

!PointingTowardsWest methodsFor: 'initialization' stamp: 'A C 10/24/2020 16:11:02'!
initializeWith: aMarsRover
	MarsRover := aMarsRover.! !


!PointingTowardsWest methodsFor: 'public' stamp: 'A C 10/24/2020 16:20:27'!
backwards
	self incrementXaxis.! !

!PointingTowardsWest methodsFor: 'public' stamp: 'A C 10/24/2020 16:20:42'!
foward
	self decrementXaxis.! !

!PointingTowardsWest methodsFor: 'public' stamp: 'A C 10/24/2020 16:30:04'!
pointingTo
	^$W.! !

!PointingTowardsWest methodsFor: 'public' stamp: 'A C 10/24/2020 16:33:37'!
rotateLeft
	MarsRover pointingToSouth.! !

!PointingTowardsWest methodsFor: 'public' stamp: 'A C 10/24/2020 16:33:57'!
rotateRight
	MarsRover pointingToNorth.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PointingTowardsWest class' category: 'Mars-Rover-Ejercicio'!
PointingTowardsWest class
	instanceVariableNames: ''!

!PointingTowardsWest class methodsFor: 'as yet unclassified' stamp: 'A C 10/24/2020 16:03:30'!
newWith: aMarsRover
	^self new initializeWith: aMarsRover! !
