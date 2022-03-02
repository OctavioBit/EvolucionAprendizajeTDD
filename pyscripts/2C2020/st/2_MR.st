!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'north east south west'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'tests' stamp: 'FC 10/25/2020 18:17:36'!
test01RoverWithNoCommandsRemainsTheSame
	
	| rover |
	
	north := North new.
	
	rover := MarsRover withPosition: 1@1 facing: north.
	rover makeMovements: ''.
	
	self assert: rover currentPosition equals: 1@1.
	self assert: rover currentDirection equals: north.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FC 10/26/2020 15:44:34'!
test02RoverRotatesLeftWhenFacingNorth
	
	| rover |
	
	rover := MarsRover withPosition: 1@1 facing: north.
	
	rover makeMovements: 'l'.
	
	self assert: rover currentPosition equals: 1@1.
	self assert: rover currentDirection equals: west.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FC 10/26/2020 15:44:58'!
test03RoverMovesAndRotatesWhenFacingNorth
	
	| rover |
	
	rover := MarsRover withPosition: 1@1 facing: north.
	rover makeMovements: 'ffbr'.
	
	self assert: rover currentPosition equals: 0@1.
	self assert: rover currentDirection equals: east.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FC 10/26/2020 15:47:19'!
test04RoverRotatesLeftWhenFacingEast
	
	| rover |
	
	rover := MarsRover withPosition: 1@1 facing: east.
	rover makeMovements: 'l'.
	
	self assert: rover currentPosition equals: 1@1.
	self assert: rover currentDirection equals: north.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FC 10/26/2020 15:47:30'!
test05RoverMovesAndRotatesWhenFacingEast
	
	| rover |
	
	rover := MarsRover withPosition: 1@1 facing: east.
	rover makeMovements: 'ffbr'.
	
	self assert: rover currentPosition equals: 1@2.
	self assert: rover currentDirection equals: south.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FC 10/26/2020 15:48:34'!
test06RoverRotatesLeftWhenFacingSouth
	
	| rover |
	
	rover := MarsRover withPosition: 1@1 facing: south.
	rover makeMovements: 'l'.
	
	self assert: rover currentPosition equals: 1@1.
	self assert: rover currentDirection equals: east.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FC 10/26/2020 15:49:10'!
test07RoverMovesAndRotatesWhenFacingSouth
	
	| rover |
	
	rover := MarsRover withPosition: 1@1 facing: south.
	rover makeMovements: 'ffbr'.
	
	self assert: rover currentPosition equals: 2@1.
	self assert: rover currentDirection equals: west.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FC 10/26/2020 15:49:38'!
test08RoverRotatesLeftWhenFacingWest
	
	| rover |
	
	rover := MarsRover withPosition: 1@1 facing: west.
	rover makeMovements: 'l'.
	
	self assert: rover currentPosition equals: 1@1.
	self assert: rover currentDirection equals: south.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FC 10/26/2020 15:50:07'!
test09RoverMovesAndRotatesWhenFacingWest
	
	| rover |
	
	rover := MarsRover withPosition: 1@1 facing: west.
	rover makeMovements: 'ffbr'.
	
	self assert: rover currentPosition equals: 1@0.
	self assert: rover currentDirection equals: north.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FC 10/26/2020 15:50:17'!
test10RoverStopsAfterInvalidCommand
	
	| rover |
	rover := MarsRover withPosition: 1@1 facing: north.
	
	self should: [ rover makeMovements: 'bbbcrff' ]  raise: Error.
	
	self assert: rover currentPosition equals: 4@1.
	self assert: rover currentDirection equals: north.! !


!MarsRoverTest methodsFor: 'setUp/tearDown' stamp: 'FC 10/25/2020 18:05:11'!
setUp
	north := North new.
	east := East new.
	south := South new.
	west := West new.! !


!classDefinition: #CardinalPoint category: 'MarsRover'!
Object subclass: #CardinalPoint
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalPoint methodsFor: 'testing' stamp: 'FC 10/25/2020 18:07:43'!
= anObject
	^self class = anObject class.! !


!CardinalPoint methodsFor: 'operations' stamp: 'FC 10/25/2020 17:41:35'!
facingPoint
	self subclassResponsibility.! !

!CardinalPoint methodsFor: 'operations' stamp: 'FC 10/25/2020 17:41:51'!
leftRotate
	self subclassResponsibility ! !

!CardinalPoint methodsFor: 'operations' stamp: 'FC 10/25/2020 17:41:57'!
rightRotate
	self subclassResponsibility ! !


!classDefinition: #East category: 'MarsRover'!
CardinalPoint subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'operations' stamp: 'FC 10/25/2020 17:43:14'!
facingPoint
	^0@1! !

!East methodsFor: 'operations' stamp: 'FC 10/25/2020 17:58:28'!
leftRotate
	^North new.! !

!East methodsFor: 'operations' stamp: 'FC 10/25/2020 17:58:31'!
rightRotate
	^South new.! !


!classDefinition: #North category: 'MarsRover'!
CardinalPoint subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'operations' stamp: 'FC 10/25/2020 17:43:28'!
facingPoint
	^-1@0.! !

!North methodsFor: 'operations' stamp: 'FC 10/25/2020 17:58:19'!
leftRotate
	^West new.! !

!North methodsFor: 'operations' stamp: 'FC 10/25/2020 17:58:23'!
rightRotate
	^East new.! !


!classDefinition: #South category: 'MarsRover'!
CardinalPoint subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'operations' stamp: 'FC 10/25/2020 17:43:45'!
facingPoint
	^1@0.! !

!South methodsFor: 'operations' stamp: 'FC 10/25/2020 17:58:13'!
leftRotate
	^East new.! !

!South methodsFor: 'operations' stamp: 'FC 10/25/2020 17:58:10'!
rightRotate
	^West new.! !


!classDefinition: #West category: 'MarsRover'!
CardinalPoint subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'operations' stamp: 'FC 10/25/2020 17:43:58'!
facingPoint
	^0@-1.! !

!West methodsFor: 'operations' stamp: 'FC 10/25/2020 17:58:00'!
leftRotate
	^South new.! !

!West methodsFor: 'operations' stamp: 'FC 10/25/2020 17:58:04'!
rightRotate
	^North new.! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialize' stamp: 'FC 10/25/2020 17:19:00'!
initializeWithPosition: aCoordinate facing: aCardinalPoint 
	position := aCoordinate.
	direction := aCardinalPoint.! !


!MarsRover methodsFor: 'operations' stamp: 'FC 10/25/2020 18:26:24'!
makeMovements: aCommandSequence
	
	aCommandSequence do: [ :aCommand |
		self makeMove: aCommand.
	]! !


!MarsRover methodsFor: 'operations - private' stamp: 'FC 10/26/2020 15:52:48'!
errorInvalidCommand

	^ self error: self class invalidCommandMessage! !

!MarsRover methodsFor: 'operations - private' stamp: 'FC 10/26/2020 15:52:48'!
makeMove: aCommand	
	(self isValidCommand: aCommand) ifTrue: [
		(self isMovement: aCommand)
		 ifTrue: [
			self moveBasedOnDirection: aCommand
			].
		
		aCommand = $r 
		ifTrue: [
			direction := direction rightRotate.
			].
		
		aCommand = $l
		ifTrue: [
			direction := direction leftRotate.
			].
	]
	ifFalse: [
		self errorInvalidCommand.
		]! !

!MarsRover methodsFor: 'operations - private' stamp: 'FC 10/25/2020 18:11:41'!
moveBasedOnDirection: aCommand 
	
	|directionToMove|
	
	directionToMove := direction facingPoint.
	
	aCommand = $f ifTrue: [ position := position + directionToMove ]
				  ifFalse:[ position := position  - directionToMove ] ! !


!MarsRover methodsFor: 'accessing' stamp: 'FC 10/25/2020 17:24:54'!
currentDirection
	^direction.! !

!MarsRover methodsFor: 'accessing' stamp: 'FC 10/25/2020 17:18:50'!
currentPosition
 	^position.! !


!MarsRover methodsFor: 'testing - private' stamp: 'FC 10/25/2020 18:15:21'!
isMovement: aCommand

	^ aCommand = $f or: [ aCommand = $b ]! !

!MarsRover methodsFor: 'testing - private' stamp: 'FC 10/25/2020 18:33:44'!
isValidCommand: aCommand

	^ self class validCommands includes: aCommand.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'error' stamp: 'FC 10/25/2020 18:21:17'!
invalidCommandMessage
	^'Comando inválido'.! !


!MarsRover class methodsFor: 'instance creation' stamp: 'FC 10/25/2020 17:14:14'!
withPosition: aCoordinate facing: aCardinalPoint 

	^self new initializeWithPosition: aCoordinate facing: aCardinalPoint ! !


!MarsRover class methodsFor: 'private' stamp: 'FC 10/25/2020 18:32:58'!
validCommands

	^ 'fbrl'! !
