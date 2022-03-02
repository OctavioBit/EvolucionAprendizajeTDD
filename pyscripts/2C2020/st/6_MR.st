!classDefinition: #RoverTests category: 'Rover'!
TestCase subclass: #RoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Rover'!

!RoverTests methodsFor: 'test chain with invalid command' stamp: 'as 10/25/2020 12:54:30'!
test09RoverPositionAndDirectionAreNotUpdatedWhenProcessingInvalidCommand
	|aRover|
	
	aRover := Rover newWithPosition: 1@1 andDirection: $N.
	aRover sendCommands: 'a'.

	self assert: aRover roverPosition equals: 1@1.
	self assert: (aRover roverDirection isKindOf: NorthDirection).
	! !

!RoverTests methodsFor: 'test chain with invalid command' stamp: 'as 10/25/2020 12:55:36'!
test10RoverIgnoresCommandsAfterAnInvalidCommand
	|aRover|
	
	aRover := Rover newWithPosition: 1@1 andDirection: $N.
	aRover sendCommands: 'al'.

	self assert: aRover roverPosition equals: 1@1.
	self assert: (aRover roverDirection isKindOf: NorthDirection).! !

!RoverTests methodsFor: 'test chain with invalid command' stamp: 'as 10/25/2020 12:56:27'!
test11RoverProcessesValidCommandsBeforeAnInvalidCommand
	|aRover|
	
	aRover := Rover newWithPosition: 1@1 andDirection: $N.
	aRover sendCommands: 'la'.

	self assert: aRover roverPosition equals: 1@1.
	self assert: (aRover roverDirection isKindOf: WestDirection).! !


!RoverTests methodsFor: 'test multiple command chain' stamp: 'as 10/25/2020 12:50:34'!
test03RoversPositionAndDirectionAreCorrectlyUpdatedWhenProcessingMultipleForwardCommandsPointingNorth
	|aRover|
	
	aRover := Rover newWithPosition: 1@1 andDirection: $N.
	aRover sendCommands: 'ff'.

	self assert: aRover roverPosition equals: 1@-1.
	self assert: (aRover roverDirection isKindOf: NorthDirection).! !

!RoverTests methodsFor: 'test multiple command chain' stamp: 'as 10/25/2020 12:51:42'!
test06RoversPositionAndDirectionAreCorrectlyUpdatedWhenProcessingMultipleLeftCommandsPointingNorth
	|aRover|
	
	aRover := Rover newWithPosition: 1@1 andDirection: $N.
	aRover sendCommands: 'll'.

	self assert: aRover roverPosition equals: 1@1.
	self assert: (aRover roverDirection isKindOf: SouthDirection).! !

!RoverTests methodsFor: 'test multiple command chain' stamp: 'as 10/25/2020 12:53:36'!
test08RoverPositionAndDirectionAreCorrectlyUpdatedWhenProcessingMultipleRotationCommandsPointingNorth
	|aRover|
	
	aRover := Rover newWithPosition: 1@1 andDirection: $N.
	aRover sendCommands: 'rl'.

	self assert: aRover roverPosition equals: 1@1.
	self assert: (aRover roverDirection isKindOf: NorthDirection).! !

!RoverTests methodsFor: 'test multiple command chain' stamp: 'as 10/25/2020 12:58:19'!
test12RoverPositionAndDirectionAreCorrectlyUpdatedWhenProcessingMixedCommands
	|aRover|
	
	aRover := Rover newWithPosition: 1@1 andDirection: $N.
	aRover sendCommands: 'lf'.

	self assert: aRover roverPosition equals: 0@1.
	self assert: (aRover roverDirection isKindOf: WestDirection).! !


!RoverTests methodsFor: 'test single command chain' stamp: 'as 10/25/2020 12:46:58'!
test01RoverRemainsInSamePositionAndDirectionProcessingEmptyCommandChain
	|aRover|
	
	aRover := Rover newWithPosition: 1@1 andDirection: $N.
	aRover sendCommands: ''.

	self assert: aRover roverPosition equals: 1@1.
	self assert: (aRover roverDirection isKindOf: NorthDirection).! !

!RoverTests methodsFor: 'test single command chain' stamp: 'as 10/25/2020 12:49:34'!
test02RoversPositionAndDirectionAreCorrectlyUpdatedWhenProcessingForwardCommandPointingNorth
	|aRover|
	
	aRover := Rover newWithPosition: 1@1 andDirection: $N.
	aRover sendCommands: 'f'.

	self assert: aRover roverPosition equals: 1@0.
	self assert: (aRover roverDirection isKindOf: NorthDirection).! !

!RoverTests methodsFor: 'test single command chain' stamp: 'as 10/25/2020 12:50:59'!
test04RoversPositionAndDirectionAreCorrectlyUpdatedWhenProcessingBackwardsCommandPointingNorth
	|aRover|
	
	aRover := Rover newWithPosition: 1@1 andDirection: $N.
	aRover sendCommands: 'b'.

	self assert: aRover roverPosition equals: 1@2.
	self assert: (aRover roverDirection isKindOf: NorthDirection).! !

!RoverTests methodsFor: 'test single command chain' stamp: 'as 10/25/2020 12:51:20'!
test05RoversPositionAndDirectionAreCorrectlyUpdatedWhenProcessingLeftCommandPointingNorth
	|aRover|
	
	aRover := Rover newWithPosition: 1@1 andDirection: $N.
	aRover sendCommands: 'l'.

	self assert: aRover roverPosition equals: 1@1.
	self assert: (aRover roverDirection isKindOf: WestDirection).! !

!RoverTests methodsFor: 'test single command chain' stamp: 'as 10/25/2020 12:53:42'!
test07RoverPositionAndDirectionAreCorrectlyUpdatedWhenProcessingRightCommandPointingNorth
	|aRover|
	
	aRover := Rover newWithPosition: 1@1 andDirection: $N.
	aRover sendCommands: 'r'.

	self assert: aRover roverPosition equals: 1@1.
	self assert: (aRover roverDirection isKindOf: EastDirection).! !


!classDefinition: #Command category: 'Rover'!
Object subclass: #Command
	instanceVariableNames: 'commandCharacter'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Rover'!

!Command methodsFor: 'initialization' stamp: 'as 10/25/2020 10:41:29'!
initializeWith: aCommandCharacter
	commandCharacter := aCommandCharacter.! !


!Command methodsFor: 'testing' stamp: 'as 10/25/2020 12:32:38'!
isInvalid
	self subclassResponsibility ! !


!Command methodsFor: 'processing' stamp: 'as 10/25/2020 11:12:20'!
processPointingEast: aRover
	self subclassResponsibility ! !

!Command methodsFor: 'processing' stamp: 'as 10/25/2020 11:12:40'!
processPointingNorth: aRover
	self subclassResponsibility ! !

!Command methodsFor: 'processing' stamp: 'as 10/25/2020 11:12:43'!
processPointingSouth: aRover
	self subclassResponsibility ! !

!Command methodsFor: 'processing' stamp: 'as 10/25/2020 11:12:35'!
processPointingWest: aRover
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Command class' category: 'Rover'!
Command class
	instanceVariableNames: ''!

!Command class methodsFor: 'initialization' stamp: 'as 10/25/2020 11:32:00'!
canHandle: aCommandCharacter
	self subclassResponsibility ! !

!Command class methodsFor: 'initialization' stamp: 'as 10/25/2020 11:30:53'!
newWith: aCommandCharacter
	^(self subclasses detect: [:aCommandClass | aCommandClass canHandle: aCommandCharacter]) new initializeWith: aCommandCharacter.! !


!classDefinition: #BackwardsCommand category: 'Rover'!
Command subclass: #BackwardsCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Rover'!

!BackwardsCommand methodsFor: 'testing' stamp: 'as 10/25/2020 12:32:53'!
isInvalid
	^false! !


!BackwardsCommand methodsFor: 'processing' stamp: 'as 10/25/2020 11:15:55'!
processPointingEast: aRover
	aRover moveBackwardsWithDirectionEast.! !

!BackwardsCommand methodsFor: 'processing' stamp: 'as 10/25/2020 11:16:34'!
processPointingNorth: aRover
	aRover moveBackwardsWithDirectionNorth.! !

!BackwardsCommand methodsFor: 'processing' stamp: 'as 10/25/2020 11:16:22'!
processPointingSouth: aRover
	aRover moveBackwardsWithDirectionSouth.! !

!BackwardsCommand methodsFor: 'processing' stamp: 'as 10/25/2020 11:16:08'!
processPointingWest: aRover
	aRover moveBackwardsWithDirectionWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BackwardsCommand class' category: 'Rover'!
BackwardsCommand class
	instanceVariableNames: ''!

!BackwardsCommand class methodsFor: 'initialization' stamp: 'as 10/25/2020 11:37:03'!
canHandle: aCommandCharacter
	^aCommandCharacter  = $b! !


!classDefinition: #ForwardCommand category: 'Rover'!
Command subclass: #ForwardCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Rover'!

!ForwardCommand methodsFor: 'testing' stamp: 'as 10/25/2020 12:33:05'!
isInvalid
	^false! !


!ForwardCommand methodsFor: 'processing' stamp: 'as 10/25/2020 11:17:21'!
processPointingEast: aRover
	aRover moveForwardWithDirectionEast.! !

!ForwardCommand methodsFor: 'processing' stamp: 'as 10/25/2020 11:17:07'!
processPointingNorth: aRover
	aRover moveForwardWithDirectionNorth.! !

!ForwardCommand methodsFor: 'processing' stamp: 'as 10/25/2020 11:16:58'!
processPointingSouth: aRover
	aRover moveForwardWithDirectionSouth.! !

!ForwardCommand methodsFor: 'processing' stamp: 'as 10/25/2020 11:17:32'!
processPointingWest: aRover
	aRover moveForwardWithDirectionWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ForwardCommand class' category: 'Rover'!
ForwardCommand class
	instanceVariableNames: ''!

!ForwardCommand class methodsFor: 'initialization' stamp: 'as 10/25/2020 11:37:16'!
canHandle: aCommandCharacter
	^aCommandCharacter  = $f! !


!classDefinition: #InvalidRoverCommand category: 'Rover'!
Command subclass: #InvalidRoverCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Rover'!

!InvalidRoverCommand methodsFor: 'testing' stamp: 'as 10/25/2020 12:33:12'!
isInvalid
	^true! !


!InvalidRoverCommand methodsFor: 'processing' stamp: 'as 10/25/2020 12:43:50'!
processPointingEast: aRover! !

!InvalidRoverCommand methodsFor: 'processing' stamp: 'as 10/25/2020 12:43:44'!
processPointingNorth: aRover! !

!InvalidRoverCommand methodsFor: 'processing' stamp: 'as 10/25/2020 12:43:32'!
processPointingSouth: aRover! !

!InvalidRoverCommand methodsFor: 'processing' stamp: 'as 10/25/2020 12:43:36'!
processPointingWest: aRover! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InvalidRoverCommand class' category: 'Rover'!
InvalidRoverCommand class
	instanceVariableNames: ''!

!InvalidRoverCommand class methodsFor: 'initialization' stamp: 'as 10/25/2020 11:38:03'!
canHandle: aCommandCharacter
	^('fbrl' includes: aCommandCharacter) not! !


!classDefinition: #LeftCommand category: 'Rover'!
Command subclass: #LeftCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Rover'!

!LeftCommand methodsFor: 'testing' stamp: 'as 10/25/2020 12:33:16'!
isInvalid
	^false! !


!LeftCommand methodsFor: 'processing' stamp: 'as 10/25/2020 11:18:04'!
processPointingEast: aRover
	aRover turnLeftWithDirectionEast.! !

!LeftCommand methodsFor: 'processing' stamp: 'as 10/25/2020 11:18:13'!
processPointingNorth: aRover
	aRover turnLeftWithDirectionNorth.! !

!LeftCommand methodsFor: 'processing' stamp: 'as 10/25/2020 11:18:29'!
processPointingSouth: aRover
	aRover turnLeftWithDirectionSouth.! !

!LeftCommand methodsFor: 'processing' stamp: 'as 10/25/2020 11:17:53'!
processPointingWest: aRover
	aRover turnLeftWithDirectionWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LeftCommand class' category: 'Rover'!
LeftCommand class
	instanceVariableNames: ''!

!LeftCommand class methodsFor: 'initialization' stamp: 'as 10/25/2020 11:37:23'!
canHandle: aCommandCharacter
	^aCommandCharacter  = $l! !


!classDefinition: #RightCommand category: 'Rover'!
Command subclass: #RightCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Rover'!

!RightCommand methodsFor: 'processing' stamp: 'as 10/25/2020 11:18:57'!
processPointingEast: aRover
	aRover turnRightWithDirectionEast.! !

!RightCommand methodsFor: 'processing' stamp: 'as 10/25/2020 11:19:10'!
processPointingNorth: aRover
	aRover turnRightWithDirectionNorth.! !

!RightCommand methodsFor: 'processing' stamp: 'as 10/25/2020 11:19:21'!
processPointingSouth: aRover
	aRover turnRightWithDirectionSouth.! !

!RightCommand methodsFor: 'processing' stamp: 'as 10/25/2020 11:18:48'!
processPointingWest: aRover
	aRover turnRightWithDirectionWest.! !


!RightCommand methodsFor: 'testing' stamp: 'as 10/25/2020 12:33:20'!
isInvalid
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RightCommand class' category: 'Rover'!
RightCommand class
	instanceVariableNames: ''!

!RightCommand class methodsFor: 'initialization' stamp: 'as 10/25/2020 11:37:30'!
canHandle: aCommandCharacter
	^aCommandCharacter  = $r! !


!classDefinition: #Direction category: 'Rover'!
Object subclass: #Direction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Rover'!

!Direction methodsFor: 'processing' stamp: 'as 10/25/2020 11:08:54'!
processCommand: aCommand for: aRover
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Direction class' category: 'Rover'!
Direction class
	instanceVariableNames: ''!

!Direction class methodsFor: 'initialization' stamp: 'as 10/25/2020 11:06:40'!
canHandle: aDirection

	self subclassResponsibility ! !

!Direction class methodsFor: 'initialization' stamp: 'as 10/25/2020 11:39:58'!
newWith: aDirection
	^(self subclasses detect: [:aDirectionClass | aDirectionClass canHandle: aDirection]) new! !


!classDefinition: #EastDirection category: 'Rover'!
Direction subclass: #EastDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Rover'!

!EastDirection methodsFor: 'processing' stamp: 'as 10/25/2020 11:11:09'!
processCommand: aCommand for: aRover
	aCommand processPointingEast: aRover. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EastDirection class' category: 'Rover'!
EastDirection class
	instanceVariableNames: ''!

!EastDirection class methodsFor: 'initialization' stamp: 'as 10/25/2020 11:07:17'!
canHandle: aDirection

	^aDirection = $E.! !


!classDefinition: #NorthDirection category: 'Rover'!
Direction subclass: #NorthDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Rover'!

!NorthDirection methodsFor: 'processing' stamp: 'as 10/25/2020 11:11:21'!
processCommand: aCommand for: aRover
	aCommand processPointingNorth: aRover. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NorthDirection class' category: 'Rover'!
NorthDirection class
	instanceVariableNames: ''!

!NorthDirection class methodsFor: 'initialization' stamp: 'as 10/25/2020 11:07:25'!
canHandle: aDirection

	^aDirection = $N.! !


!classDefinition: #SouthDirection category: 'Rover'!
Direction subclass: #SouthDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Rover'!

!SouthDirection methodsFor: 'processing' stamp: 'as 10/25/2020 11:11:30'!
processCommand: aCommand for: aRover
	aCommand processPointingSouth: aRover. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SouthDirection class' category: 'Rover'!
SouthDirection class
	instanceVariableNames: ''!

!SouthDirection class methodsFor: 'initialization' stamp: 'as 10/25/2020 11:07:31'!
canHandle: aDirection

	^aDirection = $S.! !


!classDefinition: #WestDirection category: 'Rover'!
Direction subclass: #WestDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Rover'!

!WestDirection methodsFor: 'processing' stamp: 'as 10/25/2020 11:11:39'!
processCommand: aCommand for: aRover
	aCommand processPointingWest: aRover. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WestDirection class' category: 'Rover'!
WestDirection class
	instanceVariableNames: ''!

!WestDirection class methodsFor: 'initialization' stamp: 'as 10/25/2020 11:07:39'!
canHandle: aDirection

	^aDirection = $O.! !


!classDefinition: #Rover category: 'Rover'!
Object subclass: #Rover
	instanceVariableNames: 'direction position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Rover'!

!Rover methodsFor: 'public operations' stamp: 'as 10/25/2020 12:40:30'!
sendCommands: aCommandChain

	aCommandChain do: [
		:aCharacter |
		
		|commandToProcess|
		
		commandToProcess := Command newWith: aCharacter.
		
		commandToProcess isInvalid ifTrue: [^ self class invalidCommandErrorDescription ].
		
		direction processCommand: commandToProcess for: self.
	]
		! !


!Rover methodsFor: 'private command processing' stamp: 'as 10/25/2020 11:24:13'!
moveBackwardsWithDirectionEast
	self moveForwardWithDirectionWest. ! !

!Rover methodsFor: 'private command processing' stamp: 'as 10/25/2020 11:23:51'!
moveBackwardsWithDirectionNorth
	self moveForwardWithDirectionSouth. ! !

!Rover methodsFor: 'private command processing' stamp: 'as 10/25/2020 11:23:39'!
moveBackwardsWithDirectionSouth
	self moveForwardWithDirectionNorth. ! !

!Rover methodsFor: 'private command processing' stamp: 'as 10/25/2020 11:24:23'!
moveBackwardsWithDirectionWest
	self moveForwardWithDirectionEast. ! !

!Rover methodsFor: 'private command processing' stamp: 'as 10/25/2020 11:21:33'!
moveForwardWithDirectionEast
	position := position + (1@0)! !

!Rover methodsFor: 'private command processing' stamp: 'as 10/25/2020 11:21:43'!
moveForwardWithDirectionNorth
	position := position - (0@1)! !

!Rover methodsFor: 'private command processing' stamp: 'as 10/25/2020 11:21:49'!
moveForwardWithDirectionSouth
	position := position + (0@1)! !

!Rover methodsFor: 'private command processing' stamp: 'as 10/25/2020 11:21:24'!
moveForwardWithDirectionWest
	position := position - (1@0)! !

!Rover methodsFor: 'private command processing' stamp: 'as 10/25/2020 11:26:15'!
turnLeftWithDirectionEast
	direction := Direction newWith: $N.! !

!Rover methodsFor: 'private command processing' stamp: 'as 10/25/2020 11:25:56'!
turnLeftWithDirectionNorth
	direction := Direction newWith: $O.! !

!Rover methodsFor: 'private command processing' stamp: 'as 10/25/2020 11:25:42'!
turnLeftWithDirectionSouth
	direction := Direction newWith: $E.! !

!Rover methodsFor: 'private command processing' stamp: 'as 10/25/2020 11:26:33'!
turnLeftWithDirectionWest
	direction := Direction newWith: $S.! !

!Rover methodsFor: 'private command processing' stamp: 'as 10/25/2020 11:27:41'!
turnRightWithDirectionEast
	self turnLeftWithDirectionWest! !

!Rover methodsFor: 'private command processing' stamp: 'as 10/25/2020 11:27:57'!
turnRightWithDirectionNorth
	self turnLeftWithDirectionSouth! !

!Rover methodsFor: 'private command processing' stamp: 'as 10/25/2020 11:27:50'!
turnRightWithDirectionSouth
	self turnLeftWithDirectionNorth! !

!Rover methodsFor: 'private command processing' stamp: 'as 10/25/2020 11:27:23'!
turnRightWithDirectionWest
	self turnLeftWithDirectionEast! !


!Rover methodsFor: 'initialization' stamp: 'as 10/25/2020 11:03:20'!
initializeWith: aPosition andDirection: aDirection
	position := aPosition. 
	direction := Direction newWith: aDirection.! !


!Rover methodsFor: 'accessing' stamp: 'as 10/24/2020 11:33:49'!
roverDirection
	^direction.! !

!Rover methodsFor: 'accessing' stamp: 'as 10/24/2020 11:07:06'!
roverPosition
	^position.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Rover class' category: 'Rover'!
Rover class
	instanceVariableNames: ''!

!Rover class methodsFor: 'initialization' stamp: 'as 10/24/2020 10:58:38'!
newWithPosition: aPosition andDirection: aDirection
	^self new initializeWith: aPosition andDirection: aDirection.! !


!Rover class methodsFor: 'error messages' stamp: 'as 10/24/2020 12:10:17'!
invalidCommandErrorDescription
	^'Invalid command, the processing has stopped!!'.! !
