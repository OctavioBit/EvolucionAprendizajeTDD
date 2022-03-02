!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'tests' stamp: 'uc 5/15/2021 16:45:42'!
test01processEmptyDoesNotMove
	|rover|
	rover := self createAMarsRover.
	rover process: ''.
	self assert: (rover isAt: 0@0 facing: North).
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'uc 5/15/2021 16:45:38'!
test02processForwardMovesForward
	|rover|
	rover := self createAMarsRover.
	rover process: 'f'.
	self assert: (rover isAt: 0@1 facing: North).
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'uc 5/15/2021 16:45:33'!
test03processBackwardsMovesBackwards
	|rover|
	rover := self createAMarsRover.
	rover process: 'b'.
	self assert: (rover isAt: (0@(-1)) facing: North).
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'uc 5/15/2021 16:45:28'!
test04processLeftRotatesLeft
	|rover|
	rover := self createAMarsRover.
	rover process: 'l'.
	self assert: (rover isAt: (0@0) facing: West).
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'uc 5/15/2021 16:45:22'!
test05processRightRotatesRight
	|rover|
	rover := self createAMarsRover.
	rover process: 'r'.
	self assert: (rover isAt: (0@0) facing: East).
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'uc 5/15/2021 16:45:14'!
test06processOneInvalidCommandDoesNotMove
	|rover|
	rover := self createAMarsRover.
	rover process: 'z'.
	self assert: (rover isAt: (0@0) facing: North).
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'uc 5/15/2021 16:50:23'!
test07processMultipleMoveCommands
	|rover|
	rover := self createAMarsRover.
	rover process: 'ff'.
	self assert: (rover isAt: (0@2) facing: North).
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'uc 5/15/2021 16:48:59'!
test08doesNotProcessCommandsAfterInvalidCommand
	|rover|
	rover := self createAMarsRover.
	rover process: 'zf'.
	self assert: (rover isAt: (0@0) facing: North).
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'uc 5/16/2021 19:15:52'!
test09processMoveAfterDirectionChange
	|rover|
	rover := self createAMarsRover.
	rover process: 'rf'.
	self assert: (rover isAt: (1@0) facing: East).
	! !


!MarsRoverTest methodsFor: 'mars rover creation' stamp: 'uc 5/15/2021 16:44:40'!
createAMarsRover

	^ MarsRover startingAt: 0@0 facing: North! !


!classDefinition: #CardinalDirection category: 'MarsRover'!
Object subclass: #CardinalDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalDirection class' category: 'MarsRover'!
CardinalDirection class
	instanceVariableNames: ''!

!CardinalDirection class methodsFor: 'rotations' stamp: 'uc 5/15/2021 15:32:18'!
rotateLeft
	self subclassResponsibility.! !

!CardinalDirection class methodsFor: 'rotations' stamp: 'uc 5/15/2021 15:32:13'!
rotateRight
	self subclassResponsibility.! !


!CardinalDirection class methodsFor: 'coordinates' stamp: 'uc 5/16/2021 19:18:54'!
stepCoordinates
	self subclassResponsibility.! !


!classDefinition: #East category: 'MarsRover'!
CardinalDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'East class' category: 'MarsRover'!
East class
	instanceVariableNames: ''!

!East class methodsFor: 'rotations' stamp: 'uc 5/15/2021 15:30:37'!
rotateLeft
	^North.! !

!East class methodsFor: 'rotations' stamp: 'uc 5/15/2021 15:30:47'!
rotateRight
	^South.! !


!East class methodsFor: 'coordinates' stamp: 'uc 5/16/2021 19:20:02'!
stepCoordinates
	^1@0! !


!classDefinition: #North category: 'MarsRover'!
CardinalDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'North class' category: 'MarsRover'!
North class
	instanceVariableNames: ''!

!North class methodsFor: 'rotations' stamp: 'uc 5/15/2021 15:30:58'!
rotateLeft
	^West! !

!North class methodsFor: 'rotations' stamp: 'uc 5/15/2021 15:31:06'!
rotateRight
	^East! !


!North class methodsFor: 'coordinates' stamp: 'uc 5/16/2021 19:20:27'!
stepCoordinates
	^0@1! !


!classDefinition: #South category: 'MarsRover'!
CardinalDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'South class' category: 'MarsRover'!
South class
	instanceVariableNames: ''!

!South class methodsFor: 'rotations' stamp: 'uc 5/15/2021 15:31:34'!
rotateLeft
	^East! !

!South class methodsFor: 'rotations' stamp: 'uc 5/15/2021 15:31:27'!
rotateRight
	^West! !


!South class methodsFor: 'coordinates' stamp: 'uc 5/16/2021 19:20:49'!
stepCoordinates
	^0@-1! !


!classDefinition: #West category: 'MarsRover'!
CardinalDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'West class' category: 'MarsRover'!
West class
	instanceVariableNames: ''!

!West class methodsFor: 'rotations' stamp: 'uc 5/15/2021 15:31:53'!
rotateLeft
	^South! !

!West class methodsFor: 'rotations' stamp: 'uc 5/15/2021 15:31:47'!
rotateRight
	^North! !


!West class methodsFor: 'coordinates' stamp: 'uc 5/16/2021 19:21:05'!
stepCoordinates
	^-1@0! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'uc 5/15/2021 14:58:07'!
initializeAt: aStarterPoint facing: aDirection 
	position := aStarterPoint.
	direction := aDirection.! !


!MarsRover methodsFor: 'testing' stamp: 'uc 5/15/2021 14:58:07'!
isAt: aPoint facing: aDirection 
	^(position = aPoint) and: [direction = aDirection]! !


!MarsRover methodsFor: 'command processing' stamp: 'uc 5/15/2021 16:40:39'!
process: aSequenceOfCommands
	(aSequenceOfCommands isEmpty) ifTrue: [^self.].
	
	self processCommand: (aSequenceOfCommands first) ifInvalid: [^self].
	
	self process: aSequenceOfCommands allButFirst.
	! !

!MarsRover methodsFor: 'command processing' stamp: 'uc 5/15/2021 16:39:37'!
processCommand: aCommand ifInvalid: anErrorHandlingBlock
	(aCommand = $b) ifTrue: [ ^self moveBackwards.].
	(aCommand = $l) ifTrue: [ ^self rotateLeft.].
	(aCommand = $r) ifTrue: [ ^self rotateRight.].
	(aCommand = $f) ifTrue: [ ^self moveForwards.].
	anErrorHandlingBlock value! !


!MarsRover methodsFor: 'movements' stamp: 'uc 5/16/2021 19:21:32'!
moveBackwards
	position := position - direction stepCoordinates.! !

!MarsRover methodsFor: 'movements' stamp: 'uc 5/16/2021 19:18:33'!
moveForwards
	position := position + direction stepCoordinates.! !


!MarsRover methodsFor: 'rotations' stamp: 'uc 5/15/2021 15:44:51'!
rotateLeft

	^ direction := direction rotateLeft! !

!MarsRover methodsFor: 'rotations' stamp: 'uc 5/15/2021 15:45:02'!
rotateRight

	^ direction := direction rotateRight! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'uc 5/13/2021 21:35:27'!
startingAt: aStarterPoint facing: aDirection
	^MarsRover new initializeAt: aStarterPoint facing: aDirection.
	! !
