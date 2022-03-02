!classDefinition: #MarsRoverTest category: 'Mars Rover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!MarsRoverTest methodsFor: 'Backward tests' stamp: 'DB 10/25/2020 20:27:54'!
assertCorrectPositionAfterBackwardMovement: aMarsRover expectPosition: endPosition

	aMarsRover move: 'b'.	
	self assert: ((aMarsRover currentPosition) = (endPosition))! !

!MarsRoverTest methodsFor: 'Backward tests' stamp: 'DB 10/25/2020 20:28:45'!
test02BackwardWhenPointingNorth

	self assertCorrectPositionAfterBackwardMovement: (MarsRover atNorth: 1@1) expectPosition: (1@0).! !

!MarsRoverTest methodsFor: 'Backward tests' stamp: 'DB 10/25/2020 20:29:25'!
test08BackwardWhenPointingEast

	self assertCorrectPositionAfterBackwardMovement: (MarsRover atEast: 1@1) expectPosition: (0@1).
	
! !

!MarsRoverTest methodsFor: 'Backward tests' stamp: 'DB 10/25/2020 21:44:39'!
test09BackwardWhenPointingSouth

	self assertCorrectPositionAfterBackwardMovement: (MarsRover atSouth: 1@1) expectPosition: (1@2)
	! !

!MarsRoverTest methodsFor: 'Backward tests' stamp: 'DB 10/25/2020 20:30:22'!
test10BackwardWhenPointingWest

	self assertCorrectPositionAfterBackwardMovement: (MarsRover atWest: 1@1) expectPosition: (2@1)
	! !


!MarsRoverTest methodsFor: 'Turning Left tests' stamp: 'DB 10/25/2020 20:52:34'!
assertCorrectPositionAfterTurnLeftMovement: aMarsRover expectedDirection: aDirection

	aMarsRover move: 'l'.
	self assert: ((aMarsRover currentCardinalDirection) isKindOf: aDirection )! !

!MarsRoverTest methodsFor: 'Turning Left tests' stamp: 'DB 10/25/2020 20:53:09'!
test03TuringLeftWhenPointingNorth

	self assertCorrectPositionAfterTurnLeftMovement: (MarsRover atNorth: 1@1) expectedDirection: WestDirection
	! !

!MarsRoverTest methodsFor: 'Turning Left tests' stamp: 'DB 10/25/2020 20:36:55'!
test11TuringLeftWhenPointingEast

	self assertCorrectPositionAfterTurnLeftMovement: (MarsRover atEast: 1@1) expectedDirection: NorthDirection
	! !

!MarsRoverTest methodsFor: 'Turning Left tests' stamp: 'DB 10/25/2020 21:44:53'!
test12TuringLeftWhenPointingSouth

	self assertCorrectPositionAfterTurnLeftMovement: (MarsRover atSouth: 1@1) expectedDirection: EastDirection ! !

!MarsRoverTest methodsFor: 'Turning Left tests' stamp: 'DB 10/25/2020 20:37:51'!
test13TuringLeftWhenPointingWest

	self assertCorrectPositionAfterTurnLeftMovement: (MarsRover atWest: 1@1) expectedDirection: SouthDirection! !


!MarsRoverTest methodsFor: 'Turning Right tests' stamp: 'DB 10/25/2020 20:52:42'!
assertCorrectPositionAfterTurnRighttMovement: aMarsRover expectedDirection: aDirection

	aMarsRover move: 'r'.
	self assert: ((aMarsRover currentCardinalDirection) isKindOf: aDirection )! !

!MarsRoverTest methodsFor: 'Turning Right tests' stamp: 'DB 10/25/2020 20:39:09'!
test04TurningRightWhenPointingNorth

	self assertCorrectPositionAfterTurnRighttMovement: (MarsRover atNorth: 1@1) expectedDirection: EastDirection ! !

!MarsRoverTest methodsFor: 'Turning Right tests' stamp: 'DB 10/25/2020 20:39:47'!
test14TurningRightWhenPointingEast

	self assertCorrectPositionAfterTurnRighttMovement: (MarsRover atEast: 1@1) expectedDirection: SouthDirection! !

!MarsRoverTest methodsFor: 'Turning Right tests' stamp: 'DB 10/25/2020 21:45:01'!
test15TurningRightWhenPointingSouth

	self assertCorrectPositionAfterTurnRighttMovement: (MarsRover atSouth: 1@1) expectedDirection: WestDirection! !

!MarsRoverTest methodsFor: 'Turning Right tests' stamp: 'DB 10/25/2020 20:40:39'!
test16TurningRightWhenPointingWest

	self assertCorrectPositionAfterTurnRighttMovement: (MarsRover atWest: 1@1) expectedDirection: NorthDirection! !


!MarsRoverTest methodsFor: 'Multiple Commands tests' stamp: 'DB 10/25/2020 20:43:43'!
test18MultipleMixedCommandsWhenPointingNorth
	
	| marsRover |
	marsRover := MarsRover atNorth: 1@1.
	
	marsRover move: 'frffr'.
	
	self assert: ((marsRover currentPosition ) = (3@2)).
	self assert: ((marsRover currentCardinalDirection) isKindOf: SouthDirection).! !


!MarsRoverTest methodsFor: 'Invalid commands' stamp: 'DB 10/25/2020 21:11:39'!
test17DoesntContinueExecutingAfterAnInvalidCommand
	
	| marsRover |
	marsRover := MarsRover atNorth: 1@1.
	
	self 
		should: [marsRover move: 'frffr=?xxyffr'.] 
		raise: Error  
		withMessageText: MarsRover invalidCommand. 
	
	self assert: ((marsRover currentPosition ) = (3@2)).
	self assert: ((marsRover currentCardinalDirection) isKindOf: SouthDirection).
	! !


!MarsRoverTest methodsFor: 'Forward tests' stamp: 'DB 10/25/2020 20:32:02'!
assertCorrectPositionAfterForwardMovement: aMarsRover expectPosition: endPosition

	aMarsRover move: 'f'.	
	self assert: ((aMarsRover currentPosition) = (endPosition))	! !

!MarsRoverTest methodsFor: 'Forward tests' stamp: 'DB 10/25/2020 20:32:41'!
test01ForwardWhenPointingNorth

	self assertCorrectPositionAfterForwardMovement: (MarsRover atNorth: 1@1) expectPosition: (1@2).
	! !

!MarsRoverTest methodsFor: 'Forward tests' stamp: 'DB 10/25/2020 20:33:11'!
test05ForwardWhenPointingEast

	self assertCorrectPositionAfterForwardMovement: (MarsRover atEast: 1@1)  expectPosition: (2@1)! !

!MarsRoverTest methodsFor: 'Forward tests' stamp: 'DB 10/25/2020 20:33:36'!
test06ForwardWhenPointingSouth
	
	self assertCorrectPositionAfterForwardMovement: (MarsRover atSouth: 1@1) expectPosition: (1@0)
	! !

!MarsRoverTest methodsFor: 'Forward tests' stamp: 'DB 10/25/2020 20:34:04'!
test07ForwardWhenPointingWest

	self assertCorrectPositionAfterForwardMovement: (MarsRover atWest: 1@1)  expectPosition: (0@1)
	! !


!classDefinition: #CardinalDirection category: 'Mars Rover'!
Object subclass: #CardinalDirection
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!CardinalDirection methodsFor: 'initialization' stamp: 'DB 10/25/2020 18:18:12'!
initializeWith: aMarsRover
	
	marsRover := aMarsRover ! !


!CardinalDirection methodsFor: 'movement' stamp: 'DB 10/25/2020 18:18:34'!
moveBackward
	self subclassResponsibility ! !

!CardinalDirection methodsFor: 'movement' stamp: 'DB 10/25/2020 18:19:14'!
moveForward
	self subclassResponsibility ! !

!CardinalDirection methodsFor: 'movement' stamp: 'DB 10/25/2020 18:19:36'!
turnLeft
	self subclassResponsibility ! !

!CardinalDirection methodsFor: 'movement' stamp: 'DB 10/25/2020 18:19:54'!
turnRight
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalDirection class' category: 'Mars Rover'!
CardinalDirection class
	instanceVariableNames: ''!

!CardinalDirection class methodsFor: 'instance creation' stamp: 'DB 10/25/2020 18:17:20'!
for: aMarsRover

	^self new initializeWith: aMarsRover ! !


!classDefinition: #EastDirection category: 'Mars Rover'!
CardinalDirection subclass: #EastDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!EastDirection methodsFor: 'movement' stamp: 'DB 10/25/2020 18:20:41'!
moveBackward

	marsRover moveBackwardWhenDirectionIsEast ! !

!EastDirection methodsFor: 'movement' stamp: 'DB 10/25/2020 18:21:01'!
moveForward

	marsRover moveForwardWhenDirectionIsEast ! !

!EastDirection methodsFor: 'movement' stamp: 'DB 10/25/2020 18:21:55'!
turnLeft

	marsRover turnLeftWhenDirectionIsEast ! !

!EastDirection methodsFor: 'movement' stamp: 'DB 10/25/2020 19:02:31'!
turnRight

	marsRover turnRightWhenDirectionIsEast ! !


!classDefinition: #NorthDirection category: 'Mars Rover'!
CardinalDirection subclass: #NorthDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!NorthDirection methodsFor: 'movement' stamp: 'DB 10/25/2020 18:22:41'!
moveBackward 
	
	marsRover moveBackwardWhenDirectionIsNorth ! !

!NorthDirection methodsFor: 'movement' stamp: 'DB 10/25/2020 18:22:58'!
moveForward 
	
	marsRover moveForwardWhenDirectionIsNorth ! !

!NorthDirection methodsFor: 'movement' stamp: 'DB 10/25/2020 18:23:43'!
turnLeft
	
	marsRover turnLeftWhenDirectionIsNorth ! !

!NorthDirection methodsFor: 'movement' stamp: 'DB 10/25/2020 18:23:21'!
turnRight 
	
	marsRover turnRightWhenDirectionIsNorth ! !


!classDefinition: #SouthDirection category: 'Mars Rover'!
CardinalDirection subclass: #SouthDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!SouthDirection methodsFor: 'movement' stamp: 'DB 10/25/2020 18:24:34'!
moveBackward
	
	marsRover moveBackwardWhenDirectionIsSouth! !

!SouthDirection methodsFor: 'movement' stamp: 'DB 10/25/2020 18:24:16'!
moveForward
	
	marsRover moveForwardWhenDirectionIsSouth! !

!SouthDirection methodsFor: 'movement' stamp: 'DB 10/25/2020 18:25:02'!
turnLeft
	
	marsRover turnLeftWhenDirectionIsSouth! !

!SouthDirection methodsFor: 'movement' stamp: 'DB 10/25/2020 18:24:49'!
turnRight
	
	marsRover turnRightWhenDirectionIsSouth! !


!classDefinition: #WestDirection category: 'Mars Rover'!
CardinalDirection subclass: #WestDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!WestDirection methodsFor: 'movement' stamp: 'DB 10/25/2020 18:25:47'!
moveBackward

	marsRover moveBackwardWhenDirectionIsWest! !

!WestDirection methodsFor: 'movement' stamp: 'DB 10/25/2020 18:25:34'!
moveForward

	marsRover moveForwardWhenDirectionIsWest! !

!WestDirection methodsFor: 'movement' stamp: 'DB 10/25/2020 18:26:12'!
turnLeft

	marsRover turnLeftWhenDirectionIsWest! !

!WestDirection methodsFor: 'movement' stamp: 'DB 10/25/2020 18:26:27'!
turnRight

	marsRover turnRightWhenDirectionIsWest! !


!classDefinition: #Command category: 'Mars Rover'!
Object subclass: #Command
	instanceVariableNames: 'cardinalDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!Command methodsFor: 'movement' stamp: 'DB 10/25/2020 19:43:33'!
move
	self subclassResponsibility ! !


!Command methodsFor: 'initialization' stamp: 'DB 10/25/2020 20:17:46'!
initilizeFor: aCardinalDirection

	cardinalDirection  := aCardinalDirection ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Command class' category: 'Mars Rover'!
Command class
	instanceVariableNames: ''!

!Command class methodsFor: 'instance creation' stamp: 'DB 10/25/2020 20:08:15'!
for: aCardinalDirection
	
	^self new initilizeFor: aCardinalDirection ! !


!Command class methodsFor: 'command selection' stamp: 'DB 10/25/2020 20:07:28'!
canHandle
	
	self subclassResponsibility ! !

!Command class methodsFor: 'command selection' stamp: 'DB 10/25/2020 20:17:04'!
for: aCommand with: aCardinalDirection ifNone: aNoneCommand

	^self subclasses  
		detect: [ :aCommandClass | aCommandClass canHandle: aCommand ] 
		ifFound: [ :aCommandClass | aCommandClass for: aCardinalDirection ] 
		ifNone: aNoneCommand	
		! !


!classDefinition: #BackwardCommand category: 'Mars Rover'!
Command subclass: #BackwardCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!BackwardCommand methodsFor: 'movement' stamp: 'DB 10/25/2020 19:45:48'!
move

	cardinalDirection moveBackward! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BackwardCommand class' category: 'Mars Rover'!
BackwardCommand class
	instanceVariableNames: ''!

!BackwardCommand class methodsFor: 'as yet unclassified' stamp: 'DB 10/25/2020 20:19:39'!
canHandle: aCommand

	^aCommand = $b! !


!classDefinition: #ForwardCommand category: 'Mars Rover'!
Command subclass: #ForwardCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!ForwardCommand methodsFor: 'movement' stamp: 'DB 10/25/2020 19:46:27'!
move

	cardinalDirection moveForward ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ForwardCommand class' category: 'Mars Rover'!
ForwardCommand class
	instanceVariableNames: ''!

!ForwardCommand class methodsFor: 'as yet unclassified' stamp: 'DB 10/25/2020 20:19:25'!
canHandle: aCommand

	^aCommand = $f! !


!classDefinition: #TurnLeftCommand category: 'Mars Rover'!
Command subclass: #TurnLeftCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!TurnLeftCommand methodsFor: 'movement' stamp: 'DB 10/25/2020 19:46:45'!
move

	cardinalDirection turnLeft ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TurnLeftCommand class' category: 'Mars Rover'!
TurnLeftCommand class
	instanceVariableNames: ''!

!TurnLeftCommand class methodsFor: 'as yet unclassified' stamp: 'DB 10/25/2020 20:19:10'!
canHandle: aCommand

	^aCommand = $l! !


!classDefinition: #TurnRightCommand category: 'Mars Rover'!
Command subclass: #TurnRightCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!TurnRightCommand methodsFor: 'movement' stamp: 'DB 10/25/2020 19:47:10'!
move
	
	cardinalDirection turnRight ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TurnRightCommand class' category: 'Mars Rover'!
TurnRightCommand class
	instanceVariableNames: ''!

!TurnRightCommand class methodsFor: 'as yet unclassified' stamp: 'DB 10/25/2020 20:18:58'!
canHandle: aCommand

	^aCommand = $r! !


!classDefinition: #MarsRover category: 'Mars Rover'!
Object subclass: #MarsRover
	instanceVariableNames: 'currentPosition currentCardinalDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!MarsRover methodsFor: 'initialization' stamp: 'DB 10/25/2020 18:49:04'!
initializeEastAt: aInitialPosition

	currentPosition := aInitialPosition.
	currentCardinalDirection := EastDirection for: self.! !

!MarsRover methodsFor: 'initialization' stamp: 'DB 10/25/2020 18:48:23'!
initializeNorhAt: aInitialPosition

	currentPosition := aInitialPosition.
	currentCardinalDirection := NorthDirection for: self.! !

!MarsRover methodsFor: 'initialization' stamp: 'DB 10/25/2020 18:48:39'!
initializeSouthAt: aInitialPosition

	currentPosition := aInitialPosition.
	currentCardinalDirection := SouthDirection for: self.! !

!MarsRover methodsFor: 'initialization' stamp: 'DB 10/25/2020 18:48:50'!
initializeWestAt: aInitialPosition

	currentPosition := aInitialPosition.
	currentCardinalDirection := WestDirection for: self.! !


!MarsRover methodsFor: 'movement' stamp: 'DB 10/25/2020 20:50:48'!
move: commands 
	commands do: [:aCommand | 
		| aStep | 
		
		aStep := Command for: aCommand with: currentCardinalDirection ifNone: [^self class signalInvalidCommand]. 
		aStep move.
		
	]
	! !


!MarsRover methodsFor: 'private movements' stamp: 'DB 10/25/2020 20:51:09'!
moveBackwardWhenDirectionIsEast
	
	currentPosition := currentPosition - (1@0)
	
! !

!MarsRover methodsFor: 'private movements' stamp: 'DB 10/25/2020 20:51:14'!
moveBackwardWhenDirectionIsNorth
	
	currentPosition := currentPosition - (0@1)
	
	
! !

!MarsRover methodsFor: 'private movements' stamp: 'DB 10/25/2020 20:51:18'!
moveBackwardWhenDirectionIsSouth
	
	currentPosition := currentPosition + (0@1)
	
! !

!MarsRover methodsFor: 'private movements' stamp: 'DB 10/25/2020 20:51:41'!
moveBackwardWhenDirectionIsWest
	
	currentPosition := currentPosition + (1@0)
	
	
! !

!MarsRover methodsFor: 'private movements' stamp: 'DB 10/25/2020 20:51:49'!
moveForwardWhenDirectionIsEast
	
	currentPosition := currentPosition + (1@0)! !

!MarsRover methodsFor: 'private movements' stamp: 'DB 10/25/2020 19:05:49'!
moveForwardWhenDirectionIsNorth

	currentPosition := currentPosition + (0@1)
	! !

!MarsRover methodsFor: 'private movements' stamp: 'DB 10/25/2020 19:06:14'!
moveForwardWhenDirectionIsSouth
	
	currentPosition := currentPosition - (0@1)! !

!MarsRover methodsFor: 'private movements' stamp: 'DB 10/25/2020 19:06:17'!
moveForwardWhenDirectionIsWest

	currentPosition := currentPosition - (1@0)
	! !

!MarsRover methodsFor: 'private movements' stamp: 'DB 10/25/2020 18:30:36'!
turnLeftWhenDirectionIsEast

	currentCardinalDirection := NorthDirection for: self
				! !

!MarsRover methodsFor: 'private movements' stamp: 'DB 10/25/2020 18:29:58'!
turnLeftWhenDirectionIsNorth

	currentCardinalDirection := WestDirection for: self! !

!MarsRover methodsFor: 'private movements' stamp: 'DB 10/25/2020 18:31:23'!
turnLeftWhenDirectionIsSouth

	currentCardinalDirection := EastDirection for: self! !

!MarsRover methodsFor: 'private movements' stamp: 'DB 10/25/2020 18:31:55'!
turnLeftWhenDirectionIsWest
	
	currentCardinalDirection := SouthDirection for: self
	! !

!MarsRover methodsFor: 'private movements' stamp: 'DB 10/25/2020 19:03:51'!
turnRightWhenDirectionIsEast
		
	currentCardinalDirection := SouthDirection for: self
	
! !

!MarsRover methodsFor: 'private movements' stamp: 'DB 10/25/2020 18:34:09'!
turnRightWhenDirectionIsNorth

	currentCardinalDirection := EastDirection for: self
! !

!MarsRover methodsFor: 'private movements' stamp: 'DB 10/25/2020 18:33:37'!
turnRightWhenDirectionIsSouth
		
	currentCardinalDirection := WestDirection for: self
! !

!MarsRover methodsFor: 'private movements' stamp: 'DB 10/25/2020 18:35:58'!
turnRightWhenDirectionIsWest

	currentCardinalDirection := NorthDirection for: self
! !


!MarsRover methodsFor: 'accessing' stamp: 'DB 10/25/2020 20:43:43'!
currentCardinalDirection

	^currentCardinalDirection ! !

!MarsRover methodsFor: 'accessing' stamp: 'DB 10/25/2020 16:04:48'!
currentPosition
	
	^currentPosition! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Mars Rover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'DB 10/25/2020 18:50:08'!
atEast: aInitialPosition 
	^self new initializeEastAt: aInitialPosition ! !

!MarsRover class methodsFor: 'instance creation' stamp: 'DB 10/25/2020 18:49:48'!
atNorth: aInitialPosition 
	^self new initializeNorhAt: aInitialPosition ! !

!MarsRover class methodsFor: 'instance creation' stamp: 'DB 10/25/2020 18:49:59'!
atSouth: aInitialPosition 
	^self new initializeSouthAt: aInitialPosition ! !

!MarsRover class methodsFor: 'instance creation' stamp: 'DB 10/25/2020 18:50:18'!
atWest: aInitialPosition 
	^self new initializeWestAt: aInitialPosition ! !

!MarsRover class methodsFor: 'instance creation' stamp: 'DB 10/25/2020 19:19:43'!
invalidCommand

	^'Invalid command'! !

!MarsRover class methodsFor: 'instance creation' stamp: 'DB 10/25/2020 19:19:48'!
signalInvalidCommand

	self error: self invalidCommand! !
