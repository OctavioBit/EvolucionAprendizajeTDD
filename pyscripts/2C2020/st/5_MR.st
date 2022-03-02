!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'tests - displacement' stamp: 'FR 10/26/2020 09:59:02'!
test02RoverMovesForwardsFacingNorthCorrectly

	self  roverFacing: Orientation north
		afterExecuting: 'f'
		shouldBeInPosition: 0@1
		withOrientationSatisfying: [ :anOrientation | anOrientation isNorth ]
! !

!MarsRoverTest methodsFor: 'tests - displacement' stamp: 'FR 10/26/2020 09:58:59'!
test03RoverMovesForwardsFacingWestCorrectly

	self  roverFacing: Orientation west
		afterExecuting: 'f'
		shouldBeInPosition: -1@0
		withOrientationSatisfying: [ :anOrientation | anOrientation isWest ]! !

!MarsRoverTest methodsFor: 'tests - displacement' stamp: 'FR 10/26/2020 09:58:52'!
test04RoverMovesBackwardsFacingSouthCorrectly

	self  roverFacing: Orientation south
		afterExecuting: 'b'
		shouldBeInPosition: 0@1
		withOrientationSatisfying: [ :anOrientation | anOrientation isSouth ]! !

!MarsRoverTest methodsFor: 'tests - displacement' stamp: 'FR 10/26/2020 09:58:49'!
test05RoverMovesBackwardsFacingEastCorrectly

	self  roverFacing: Orientation east
		afterExecuting: 'b'
		shouldBeInPosition: -1@0
		withOrientationSatisfying: [ :anOrientation | anOrientation isEast ]! !


!MarsRoverTest methodsFor: 'tests - rotation' stamp: 'FR 10/26/2020 10:00:54'!
test06RoverRotatesLeftFacingNorthCorrectly

	self  roverFacing: Orientation north
		afterExecuting: 'l'
		shouldBeInPosition: 0@0
		withOrientationSatisfying: [ :anOrientation | anOrientation isWest ]! !

!MarsRoverTest methodsFor: 'tests - rotation' stamp: 'FR 10/26/2020 10:00:51'!
test07RoverRotatesLeftFacingWestCorrectly

	self  roverFacing: Orientation west
		afterExecuting: 'l'
		shouldBeInPosition: 0@0
		withOrientationSatisfying: [ :anOrientation | anOrientation isSouth ]! !

!MarsRoverTest methodsFor: 'tests - rotation' stamp: 'FR 10/26/2020 10:00:48'!
test08RoverRotatesLeftFacingSouthCorrectly

	self  roverFacing: Orientation south
		afterExecuting: 'l'
		shouldBeInPosition: 0@0
		withOrientationSatisfying: [ :anOrientation | anOrientation isEast ]! !

!MarsRoverTest methodsFor: 'tests - rotation' stamp: 'FR 10/26/2020 10:00:43'!
test09RoverRotatesLeftFacingEastCorrectly

	self  roverFacing: Orientation east
		afterExecuting: 'l'
		shouldBeInPosition: 0@0
		withOrientationSatisfying: [ :anOrientation | anOrientation isNorth ]! !

!MarsRoverTest methodsFor: 'tests - rotation' stamp: 'FR 10/26/2020 10:00:40'!
test10RoverRotatesRightFacingNorthCorrectly

	self  roverFacing: Orientation north
		afterExecuting: 'r'
		shouldBeInPosition: 0@0
		withOrientationSatisfying: [ :anOrientation | anOrientation isEast ]! !

!MarsRoverTest methodsFor: 'tests - rotation' stamp: 'FR 10/26/2020 10:00:37'!
test11RoverRotatesRightFacingEastCorrectly

	self  roverFacing: Orientation east
		afterExecuting: 'r'
		shouldBeInPosition: 0@0
		withOrientationSatisfying: [ :anOrientation | anOrientation isSouth ]! !

!MarsRoverTest methodsFor: 'tests - rotation' stamp: 'FR 10/26/2020 10:00:34'!
test12RoverRotatesRightFacingSouthCorrectly

	self  roverFacing: Orientation south
		afterExecuting: 'r'
		shouldBeInPosition: 0@0
		withOrientationSatisfying: [ :anOrientation | anOrientation isWest ]! !

!MarsRoverTest methodsFor: 'tests - rotation' stamp: 'FR 10/26/2020 10:00:30'!
test13RoverRotatesRightFacingWestCorrectly

	self  roverFacing: Orientation west
		afterExecuting: 'r'
		shouldBeInPosition: 0@0
		withOrientationSatisfying: [ :anOrientation | anOrientation isNorth ]! !


!MarsRoverTest methodsFor: 'tests - invalid commands' stamp: 'FR 10/26/2020 10:05:09'!
test15RoverExecutesCommandsPreviousToInvalidCommand
	
	self  roverFacing: Orientation north
		inPosition: 1@1
		afterDoing: [
			self  should: [ marsRover execute: 'fx' ]
				raise: Error
				withMessageText: MarsRover invalidCommandErrorDescription.
		]
		shouldBeInPosition: 1@2
		withOrientationSatisfying: [ :anOrientation | anOrientation isNorth ]! !

!MarsRoverTest methodsFor: 'tests - invalid commands' stamp: 'FR 10/26/2020 10:02:12'!
test16RoverDoesNotExecuteCommandsAfterInvalidCommand
	
	self  roverFacing: Orientation north
		inPosition: 1@1
		afterDoing: [
			self  should: [ marsRover execute: 'xf' ]
				raise: Error
				withMessageText: MarsRover invalidCommandErrorDescription.
		]
		shouldBeInPosition: 1@1
		withOrientationSatisfying: [ :anOrientation | anOrientation isNorth ]! !


!MarsRoverTest methodsFor: 'tests - multiple commands' stamp: 'FR 10/26/2020 10:01:04'!
test14RoverExecutesMultipleCommandsCorrectly

	self  roverFacing: Orientation north
		afterExecuting: 'lf'
		shouldBeInPosition: -1@0
		withOrientationSatisfying: [ :anOrientation | anOrientation isWest ]! !


!MarsRoverTest methodsFor: 'private - assertions' stamp: 'FR 10/26/2020 00:14:40'!
roverFacing: initialOrientation afterExecuting: commandsToExecute shouldBeInPosition: expectedFinalPosition withOrientationSatisfying: conditionsOnOrientation
	
	self  roverFacing: initialOrientation
		inPosition: 0@0
		afterDoing: [ marsRover execute: commandsToExecute ]
		shouldBeInPosition: expectedFinalPosition
		withOrientationSatisfying: conditionsOnOrientation! !

!MarsRoverTest methodsFor: 'private - assertions' stamp: 'FR 10/26/2020 00:14:21'!
roverFacing: initialOrientation inPosition: initialPosition afterDoing: aBlock shouldBeInPosition: expectedFinalPosition withOrientationSatisfying: conditionsOnOrientation
		
	marsRover := MarsRover inPosition: initialPosition facing: initialOrientation.
	
	aBlock value.
	
	self assert: marsRover position = expectedFinalPosition.
	self assert: (conditionsOnOrientation value: marsRover orientation)! !


!MarsRoverTest methodsFor: 'tests - empty command' stamp: 'FR 10/26/2020 10:00:23'!
test01RoverDoesntChangeWhenCommandsSentAreEmpty

	self  roverFacing: Orientation north
		afterExecuting: ''
		shouldBeInPosition: 0@0
		withOrientationSatisfying: [ :anOrientation | anOrientation isNorth ]
! !


!classDefinition: #Command category: 'MarsRover'!
Object subclass: #Command
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Command methodsFor: 'execution' stamp: 'FR 10/25/2020 23:31:30'!
executeOn: aMarsRover

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Command class' category: 'MarsRover'!
Command class
	instanceVariableNames: ''!

!Command class methodsFor: 'instance creation' stamp: 'FR 10/25/2020 23:31:13'!
from: aCharacter

	^ (self allSubclasses detect: [ :aCommandSubclass | aCommandSubclass canHandle: aCharacter ]) new! !


!classDefinition: #Backwards category: 'MarsRover'!
Command subclass: #Backwards
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Backwards methodsFor: 'execution' stamp: 'FR 10/25/2020 23:34:28'!
executeOn: aMarsRover

	aMarsRover moveBackwards! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Backwards class' category: 'MarsRover'!
Backwards class
	instanceVariableNames: ''!

!Backwards class methodsFor: 'instance creation' stamp: 'FR 10/25/2020 23:32:40'!
canHandle: aCharacter

	^ aCharacter = $b! !


!classDefinition: #Forwards category: 'MarsRover'!
Command subclass: #Forwards
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Forwards methodsFor: 'execution' stamp: 'FR 10/25/2020 23:34:39'!
executeOn: aMarsRover

	aMarsRover moveForwards! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Forwards class' category: 'MarsRover'!
Forwards class
	instanceVariableNames: ''!

!Forwards class methodsFor: 'instance creation' stamp: 'FR 10/25/2020 23:32:48'!
canHandle: aCharacter

	^ aCharacter = $f! !


!classDefinition: #Invalid category: 'MarsRover'!
Command subclass: #Invalid
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Invalid methodsFor: 'execution' stamp: 'FR 10/25/2020 23:34:52'!
executeOn: aMarsRover

	aMarsRover invalidCommand! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Invalid class' category: 'MarsRover'!
Invalid class
	instanceVariableNames: ''!

!Invalid class methodsFor: 'instance creation' stamp: 'FR 10/25/2020 23:37:51'!
canHandle: aCharacter

	^ (#($f $b $l $r) includes: aCharacter) not! !


!classDefinition: #Left category: 'MarsRover'!
Command subclass: #Left
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Left methodsFor: 'execution' stamp: 'FR 10/25/2020 23:35:03'!
executeOn: aMarsRover

	aMarsRover rotateLeft! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Left class' category: 'MarsRover'!
Left class
	instanceVariableNames: ''!

!Left class methodsFor: 'instance creation' stamp: 'FR 10/25/2020 23:32:55'!
canHandle: aCharacter

	^ aCharacter = $l! !


!classDefinition: #Right category: 'MarsRover'!
Command subclass: #Right
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Right methodsFor: 'execution' stamp: 'FR 10/25/2020 23:35:11'!
executeOn: aMarsRover

	aMarsRover rotateRight! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Right class' category: 'MarsRover'!
Right class
	instanceVariableNames: ''!

!Right class methodsFor: 'instance creation' stamp: 'FR 10/25/2020 23:33:01'!
canHandle: aCharacter

	^ aCharacter = $r! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position orientation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'execution' stamp: 'FR 10/25/2020 23:36:04'!
execute: stringOfCommands

	stringOfCommands do: [ :aCharacter | 
		(Command from: aCharacter) executeOn: self.
	]! !


!MarsRover methodsFor: 'accessing' stamp: 'FR 10/25/2020 22:12:02'!
orientation
	
	^ orientation! !

!MarsRover methodsFor: 'accessing' stamp: 'FR 10/25/2020 22:11:52'!
position

	^ position! !


!MarsRover methodsFor: 'initialization' stamp: 'FR 10/25/2020 22:10:27'!
initializeInPosition: aPosition facing: anOrientation 

	position := aPosition.
	orientation := anOrientation.! !


!MarsRover methodsFor: 'displacement' stamp: 'FR 10/25/2020 22:55:11'!
moveBackwards

	position := position - orientation direction.! !

!MarsRover methodsFor: 'displacement' stamp: 'FR 10/25/2020 22:55:19'!
moveForwards

	position := position + orientation direction.! !


!MarsRover methodsFor: 'rotation' stamp: 'FR 10/25/2020 23:12:40'!
rotateLeft

	orientation := orientation rotateLeft! !

!MarsRover methodsFor: 'rotation' stamp: 'FR 10/25/2020 23:12:45'!
rotateRight

	orientation := orientation rotateRight! !


!MarsRover methodsFor: 'errors' stamp: 'FR 10/25/2020 23:35:43'!
invalidCommand

	self error: self class invalidCommandErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'FR 10/25/2020 22:10:08'!
inPosition: aPosition facing: anOrientation 

	^self new initializeInPosition: aPosition facing: anOrientation! !


!MarsRover class methodsFor: 'error descriptions' stamp: 'FR 10/25/2020 23:25:49'!
invalidCommandErrorDescription
	
	^ 'Found invalid command in string of commands!! Execution stopped.'! !


!classDefinition: #Orientation category: 'MarsRover'!
Object subclass: #Orientation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Orientation methodsFor: 'testing' stamp: 'FR 10/25/2020 22:51:44'!
isEast

	self subclassResponsibility! !

!Orientation methodsFor: 'testing' stamp: 'FR 10/25/2020 22:51:37'!
isNorth

	self subclassResponsibility! !

!Orientation methodsFor: 'testing' stamp: 'FR 10/25/2020 22:51:41'!
isSouth

	self subclassResponsibility! !

!Orientation methodsFor: 'testing' stamp: 'FR 10/25/2020 22:51:46'!
isWest

	self subclassResponsibility! !


!Orientation methodsFor: 'rotation' stamp: 'FR 10/25/2020 23:10:24'!
rotateLeft

	self subclassResponsibility! !

!Orientation methodsFor: 'rotation' stamp: 'FR 10/25/2020 23:10:27'!
rotateRight

	self subclassResponsibility! !


!Orientation methodsFor: 'accessing' stamp: 'FR 10/25/2020 22:51:01'!
direction

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Orientation class' category: 'MarsRover'!
Orientation class
	instanceVariableNames: ''!

!Orientation class methodsFor: 'instance creation' stamp: 'FR 10/25/2020 22:50:13'!
east

	^ East new! !

!Orientation class methodsFor: 'instance creation' stamp: 'FR 10/25/2020 22:50:03'!
north

	^ North new! !

!Orientation class methodsFor: 'instance creation' stamp: 'FR 10/25/2020 22:50:08'!
south

	^ South new! !

!Orientation class methodsFor: 'instance creation' stamp: 'FR 10/25/2020 22:50:18'!
west

	^ West new! !


!classDefinition: #East category: 'MarsRover'!
Orientation subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'testing' stamp: 'FR 10/25/2020 22:53:08'!
isEast

	^ true! !

!East methodsFor: 'testing' stamp: 'FR 10/25/2020 22:52:57'!
isNorth

	^ false! !

!East methodsFor: 'testing' stamp: 'FR 10/25/2020 22:53:01'!
isSouth

	^ false! !

!East methodsFor: 'testing' stamp: 'FR 10/25/2020 22:53:04'!
isWest

	^ false! !


!East methodsFor: 'accessing' stamp: 'FR 10/25/2020 22:52:25'!
direction

	^ 1@0! !


!East methodsFor: 'rotation' stamp: 'FR 10/25/2020 23:10:46'!
rotateLeft

	^ Orientation north! !

!East methodsFor: 'rotation' stamp: 'FR 10/25/2020 23:10:53'!
rotateRight

	^ Orientation south! !


!classDefinition: #North category: 'MarsRover'!
Orientation subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'testing' stamp: 'FR 10/25/2020 22:53:24'!
isEast

	^ false! !

!North methodsFor: 'testing' stamp: 'FR 10/25/2020 22:53:17'!
isNorth

	^ true! !

!North methodsFor: 'testing' stamp: 'FR 10/25/2020 22:53:22'!
isSouth

	^ false! !

!North methodsFor: 'testing' stamp: 'FR 10/25/2020 22:53:26'!
isWest

	^ false! !


!North methodsFor: 'accessing' stamp: 'FR 10/25/2020 22:52:34'!
direction

	^ 0@1! !


!North methodsFor: 'rotation' stamp: 'FR 10/25/2020 23:11:07'!
rotateLeft

	^ Orientation west! !

!North methodsFor: 'rotation' stamp: 'FR 10/25/2020 23:11:14'!
rotateRight

	^ Orientation east! !


!classDefinition: #South category: 'MarsRover'!
Orientation subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'testing' stamp: 'FR 10/25/2020 22:53:41'!
isEast

	^ false! !

!South methodsFor: 'testing' stamp: 'FR 10/25/2020 22:53:33'!
isNorth

	^ false! !

!South methodsFor: 'testing' stamp: 'FR 10/25/2020 22:53:46'!
isSouth

	^ true! !

!South methodsFor: 'testing' stamp: 'FR 10/25/2020 22:53:36'!
isWest

	^ false! !


!South methodsFor: 'accessing' stamp: 'FR 10/25/2020 22:52:41'!
direction

	^ 0@-1! !


!South methodsFor: 'rotation' stamp: 'FR 10/25/2020 23:11:30'!
rotateLeft

	^ Orientation east! !

!South methodsFor: 'rotation' stamp: 'FR 10/25/2020 23:11:37'!
rotateRight

	^ Orientation west! !


!classDefinition: #West category: 'MarsRover'!
Orientation subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'testing' stamp: 'FR 10/25/2020 22:54:00'!
isEast

	^ false! !

!West methodsFor: 'testing' stamp: 'FR 10/25/2020 22:53:55'!
isNorth

	^ false! !

!West methodsFor: 'testing' stamp: 'FR 10/25/2020 22:53:57'!
isSouth

	^ false! !

!West methodsFor: 'testing' stamp: 'FR 10/25/2020 22:54:05'!
isWest

	^ true! !


!West methodsFor: 'accessing' stamp: 'FR 10/25/2020 22:52:49'!
direction

	^ -1@0! !


!West methodsFor: 'rotation' stamp: 'FR 10/25/2020 23:11:49'!
rotateLeft

	^ Orientation south! !

!West methodsFor: 'rotation' stamp: 'FR 10/25/2020 23:11:54'!
rotateRight

	^ Orientation north! !
