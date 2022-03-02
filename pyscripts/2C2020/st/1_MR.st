!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'north west south east marsRoverNorth marsRoverWest marsRoverSouth marsRoverEast'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'setUp/tearDown' stamp: 'NNH 10/24/2020 12:07:44'!
setUp

	
	north := 'North'.
	west := 'West'.
	south := 'South'.
	east := 'East'.
	
	marsRoverNorth := MarsRover at: 0@0 heading: north. 
	marsRoverWest := MarsRover at: 0@0 heading: west. 
	marsRoverSouth := MarsRover at: 0@0 heading: south . 
	marsRoverEast := MarsRover at: 0@0 heading: east. ! !


!MarsRoverTest methodsFor: 'testing direction' stamp: 'NNH 10/24/2020 12:22:41'!
should: aMarsRover executing: aListOfCommands beHeading: aCardinalDirection

	aMarsRover execute: aListOfCommands .
	self assert: aCardinalDirection equals: aMarsRover direction.


! !

!MarsRoverTest methodsFor: 'testing direction' stamp: 'AM 10/25/2020 22:32:36'!
test05TurningLeftFromNorthShouldHeadWest

	self should: marsRoverNorth executing: 'l' beHeading: west.


! !

!MarsRoverTest methodsFor: 'testing direction' stamp: 'AM 10/25/2020 22:33:28'!
test06TurningLeftFromWestShouldHeadSouth

	self should: marsRoverWest executing: 'l' beHeading: south.


! !

!MarsRoverTest methodsFor: 'testing direction' stamp: 'AM 10/25/2020 22:33:23'!
test07TurningLeftFromSouthShouldHeadEast

	self should: marsRoverSouth executing: 'l' beHeading: east.


! !

!MarsRoverTest methodsFor: 'testing direction' stamp: 'AM 10/25/2020 22:33:16'!
test08TurningLeftFromEastShouldHeadNorth

	self should: marsRoverEast executing: 'l' beHeading: north.


! !

!MarsRoverTest methodsFor: 'testing direction' stamp: 'AM 10/25/2020 22:33:12'!
test09TurningRightFromNorthShouldHeadEast

	self should: marsRoverNorth executing: 'r' beHeading: east.


! !

!MarsRoverTest methodsFor: 'testing direction' stamp: 'AM 10/25/2020 22:33:08'!
test10TurningRightFromEastShouldHeadSouth

	self should: marsRoverEast executing: 'r' beHeading: south.


! !

!MarsRoverTest methodsFor: 'testing direction' stamp: 'AM 10/25/2020 22:33:03'!
test11TurningRightFromSouthShouldHeadWest

	self should: marsRoverSouth executing: 'r' beHeading: west.

! !

!MarsRoverTest methodsFor: 'testing direction' stamp: 'AM 10/25/2020 22:32:47'!
test12TurningRightFromWestShouldHeadNorth

	self should: marsRoverWest executing: 'r' beHeading: north.

! !


!MarsRoverTest methodsFor: 'testing invalid commands' stamp: 'AM 10/25/2020 22:34:28'!
test21MarsRoverShouldMoveExecutingAnotherListOfCommandsAfterInvalidCommand

	self should: [marsRoverNorth execute: 'x'] raise: Error.
	
	marsRoverNorth execute: 'l'.
	self assert: west equals: marsRoverNorth direction.! !

!MarsRoverTest methodsFor: 'testing invalid commands' stamp: 'AM 10/25/2020 22:34:24'!
test22AfterInvalidCommandMarsRoverDoesNotMove

	self should: [marsRoverNorth execute: 'xflbr'] raise: Error.
	
	self assert: marsRoverNorth location equals: 0@0.
! !


!MarsRoverTest methodsFor: 'testing movement' stamp: 'NNH 10/24/2020 19:52:11'!
should: aMarsRover executing: aListOfCommands beAt: aPosition

	aMarsRover execute: aListOfCommands .
	self assert: aPosition equals: aMarsRover location.


! !

!MarsRoverTest methodsFor: 'testing movement' stamp: 'AM 10/25/2020 22:34:17'!
test03MovingForwardNorthShouldIncreaseOneYCoordinate

	self should: marsRoverNorth executing: 'f' beAt: 0@1.

! !

!MarsRoverTest methodsFor: 'testing movement' stamp: 'AM 10/25/2020 22:34:13'!
test04MovingBackwardsNorthShouldDecreaseOneYCoordinate

	self should: marsRoverNorth executing: 'b' beAt: 0@-1.

! !

!MarsRoverTest methodsFor: 'testing movement' stamp: 'AM 10/25/2020 22:34:08'!
test13MovingForwardWestShouldDecreaseOneXCoordinate

	self should: marsRoverWest executing: 'f' beAt: -1@0.

! !

!MarsRoverTest methodsFor: 'testing movement' stamp: 'AM 10/25/2020 22:34:05'!
test14MovingForwardSouthShouldDecreaseOneYCoordinate

	self should: marsRoverSouth executing: 'f' beAt: 0@-1.
! !

!MarsRoverTest methodsFor: 'testing movement' stamp: 'AM 10/25/2020 22:34:01'!
test15MovingForwardEastShouldIncreaseOneXCoordinate

	self should: marsRoverEast executing: 'f' beAt: 1@0.

! !

!MarsRoverTest methodsFor: 'testing movement' stamp: 'AM 10/25/2020 22:33:57'!
test16MovingBackwardsWestShouldIncreaseOneXCoordinate

	self should: marsRoverWest executing: 'b' beAt: 1@0.

! !

!MarsRoverTest methodsFor: 'testing movement' stamp: 'AM 10/25/2020 22:33:53'!
test17MovingBackwardsSouthShouldIncreaseOneYCoordinate

	self should: marsRoverSouth executing: 'b' beAt: 0@1.
! !

!MarsRoverTest methodsFor: 'testing movement' stamp: 'AM 10/25/2020 22:33:48'!
test18MovingBackwarsdsEastShouldDecreaseOneXCoordinate

	self should: marsRoverEast executing: 'b' beAt: -1@0.
! !


!MarsRoverTest methodsFor: 'testing multiple commands' stamp: 'AM 10/25/2020 22:33:40'!
test19ExecutingMoreThanOneCommandShouldExecuteThem

	self should: marsRoverNorth executing: 'ff' beAt: 0@2. 
! !

!MarsRoverTest methodsFor: 'testing multiple commands' stamp: 'AM 10/25/2020 22:30:49'!
test24MarsRoverShouldMoveInMoreThanOneDirection

	self should: marsRoverNorth executing: 'ffrffrff' beAt: 2@0. 
! !


!MarsRoverTest methodsFor: 'testing no commands' stamp: 'AM 10/25/2020 22:32:27'!
test01EmptyListOfCommandsShouldNotChangeDirection

	self should: marsRoverNorth executing: '' 	beHeading: north. ! !

!MarsRoverTest methodsFor: 'testing no commands' stamp: 'AM 10/25/2020 22:32:21'!
test02EmptyListOfCommandsShouldNotMoveMarsRover

	self should: marsRoverNorth executing: '' beAt: 0@0.! !


!MarsRoverTest methodsFor: 'testing signals' stamp: 'AM 10/25/2020 22:31:07'!
test20MarsRoverShouldSignalErrorWhenExecutingInvalidCommand

	self should: [marsRoverNorth execute: 'lxl']
	raise: Error 
	withMessageText: MarsRover canNotHandleInvalidCommandErrorDescription.
	
! !

!MarsRoverTest methodsFor: 'testing signals' stamp: 'AM 10/25/2020 22:30:57'!
test23MarsRoverShouldNotHeadToNonCardinalDirection

	self should: [MarsRover at: 0@0 heading: 'Hello'] 
	raise: Error
	withMessageText: MarsRover canNotBeHeadingToNonCardinalDirectionErrorDescription.
! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'location cardinalDirection status'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'accessing' stamp: 'NNH 10/24/2020 10:53:54'!
direction
	^status direction.! !

!MarsRover methodsFor: 'accessing' stamp: 'NNH 10/24/2020 19:51:46'!
location
	^ status location.! !


!MarsRover methodsFor: 'error signaling' stamp: 'NNH 10/25/2020 20:13:16'!
signalCanNotHandleInvalidCommand
	
	self error: self class canNotHandleInvalidCommandErrorDescription.! !


!MarsRover methodsFor: 'executing' stamp: 'NNH 10/24/2020 19:02:29'!
execute: aListOfCommands 

	aListOfCommands do: [ :aCommandAsCharacter | self executeSingleCommand: aCommandAsCharacter.].! !


!MarsRover methodsFor: 'executing - private' stamp: 'NNH 10/24/2020 19:03:08'!
executeSingleCommand: aCommandAsCharacter

	| command | 
	
	command := MarsRoverCommand with: aCommandAsCharacter for: self. 
	command execute! !


!MarsRover methodsFor: 'initializing' stamp: 'NNH 10/24/2020 19:43:49'!
initializeAt: aLocation heading: aCardinalDirection 

	status := MarsRoverStatus at: aLocation heading: aCardinalDirection.! !


!MarsRover methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 13:27:38'!
moveBackwards
	status moveBackwards.! !

!MarsRover methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 13:27:19'!
moveForward 
	status moveForward.! !

!MarsRover methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 13:28:02'!
turnLeft
	status := status turnLeft.! !

!MarsRover methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 13:28:10'!
turnRight
	status := status turnRight.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'NNH 10/24/2020 19:23:46'!
at: aLocation heading: aCardinalDirection
	self assertACardinalDirectionIsValid: aCardinalDirection.
	^self new initializeAt: aLocation heading: aCardinalDirection.! !


!MarsRover class methodsFor: 'error descriptions' stamp: 'NNH 10/24/2020 19:19:35'!
canNotBeHeadingToNonCardinalDirectionErrorDescription
	^'Mars Rover should be heading to a cardinal direction'.! !

!MarsRover class methodsFor: 'error descriptions' stamp: 'NNH 10/25/2020 20:10:46'!
canNotHandleInvalidCommandErrorDescription
	^'Can not handle invalid command error description'.! !


!MarsRover class methodsFor: 'assertions' stamp: 'NNH 10/24/2020 19:26:08'!
assertACardinalDirectionIsValid: aCardinalDirection 
	
	({'North'. 'West'. 'East'. 'South'} includes: aCardinalDirection) ifFalse: [self error: self canNotBeHeadingToNonCardinalDirectionErrorDescription.].! !


!classDefinition: #MarsRoverCommand category: 'MarsRover'!
Object subclass: #MarsRoverCommand
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverCommand methodsFor: 'executing' stamp: 'NNH 10/24/2020 13:22:58'!
execute
	self subclassResponsibility.! !


!MarsRoverCommand methodsFor: 'initializing' stamp: 'NNH 10/24/2020 13:21:46'!
initializeFor: aMarsRover

	marsRover := aMarsRover ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverCommand class' category: 'MarsRover'!
MarsRoverCommand class
	instanceVariableNames: ''!

!MarsRoverCommand class methodsFor: 'instance creation' stamp: 'NNH 10/24/2020 13:20:20'!
with: aCharacterIdentifyingCommand for: aMarsRover
	aCharacterIdentifyingCommand = $f ifTrue: [^MarsRoverCommandForward for: aMarsRover.].
	aCharacterIdentifyingCommand = $b ifTrue: [^MarsRoverCommandBackward for: aMarsRover.].
	aCharacterIdentifyingCommand = $l ifTrue: [^MarsRoverCommandLeft for: aMarsRover.].
	aCharacterIdentifyingCommand = $r ifTrue: [^MarsRoverCommandRight for: aMarsRover.].
	^ MarsRoverCommandInvalidCommand for: aMarsRover.! !


!MarsRoverCommand class methodsFor: 'instance creation - private' stamp: 'NNH 10/24/2020 13:21:01'!
for: aMarsRover

	^self new initializeFor: aMarsRover.! !


!classDefinition: #MarsRoverCommandBackward category: 'MarsRover'!
MarsRoverCommand subclass: #MarsRoverCommandBackward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverCommandBackward methodsFor: 'executing' stamp: 'NNH 10/24/2020 13:24:08'!
execute
	marsRover moveBackwards.! !


!classDefinition: #MarsRoverCommandForward category: 'MarsRover'!
MarsRoverCommand subclass: #MarsRoverCommandForward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverCommandForward methodsFor: 'executing' stamp: 'NNH 10/24/2020 13:24:01'!
execute
	marsRover moveForward.! !


!classDefinition: #MarsRoverCommandInvalidCommand category: 'MarsRover'!
MarsRoverCommand subclass: #MarsRoverCommandInvalidCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverCommandInvalidCommand methodsFor: 'executing' stamp: 'NNH 10/25/2020 20:11:55'!
execute
	marsRover signalCanNotHandleInvalidCommand.! !


!classDefinition: #MarsRoverCommandLeft category: 'MarsRover'!
MarsRoverCommand subclass: #MarsRoverCommandLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverCommandLeft methodsFor: 'executing' stamp: 'NNH 10/24/2020 13:24:34'!
execute
	marsRover turnLeft.! !


!classDefinition: #MarsRoverCommandRight category: 'MarsRover'!
MarsRoverCommand subclass: #MarsRoverCommandRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverCommandRight methodsFor: 'executing' stamp: 'NNH 10/24/2020 13:24:46'!
execute
	marsRover turnRight.! !


!classDefinition: #MarsRoverStatus category: 'MarsRover'!
Object subclass: #MarsRoverStatus
	instanceVariableNames: 'location direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverStatus methodsFor: 'accessing' stamp: 'NNH 10/24/2020 19:08:16'!
direction
	^direction.! !

!MarsRoverStatus methodsFor: 'accessing' stamp: 'NNH 10/24/2020 19:37:12'!
location
	^location! !


!MarsRoverStatus methodsFor: 'initializing' stamp: 'NNH 10/24/2020 19:45:50'!
initializeAt: aLocation
	self subclassResponsibility.! !

!MarsRoverStatus methodsFor: 'initializing' stamp: 'NNH 10/24/2020 19:46:12'!
initializeAt: aLocation heading: aCardinalDirection
	self subclassResponsibility.! !


!MarsRoverStatus methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 11:38:58'!
moveBackwards
	self subclassResponsibility.! !

!MarsRoverStatus methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 11:42:57'!
moveForward

	self subclassResponsibility.! !

!MarsRoverStatus methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 10:42:45'!
turnLeft
	self subclassResponsibility.! !

!MarsRoverStatus methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 11:43:07'!
turnRight
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverStatus class' category: 'MarsRover'!
MarsRoverStatus class
	instanceVariableNames: ''!

!MarsRoverStatus class methodsFor: 'instance creation' stamp: 'NNH 10/24/2020 11:21:43'!
at: aLocation heading: aCardinalDirection 
	aCardinalDirection = 'North' ifTrue: [^MarsRoverStatusHeadingNorth at: aLocation.].
	aCardinalDirection = 'West' ifTrue: [^MarsRoverStatusHeadingWest at: aLocation.].
	aCardinalDirection = 'South' ifTrue: [^MarsRoverStatusHeadingSouth at: aLocation.].
	aCardinalDirection = 'East' ifTrue: [^MarsRoverStatusHeadingEast at: aLocation.].! !


!MarsRoverStatus class methodsFor: 'instance creation - private' stamp: 'NNH 10/24/2020 11:24:34'!
at: aLocation 
	^self new initializeAt: aLocation.! !


!classDefinition: #MarsRoverStatusHeadingEast category: 'MarsRover'!
MarsRoverStatus subclass: #MarsRoverStatusHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverStatusHeadingEast methodsFor: 'initializing' stamp: 'NNH 10/24/2020 19:09:35'!
initializeAt: aLocation 
	location := aLocation.
	direction := 'East'.! !


!MarsRoverStatusHeadingEast methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 11:42:18'!
moveBackwards
	location := -1@0 + location.! !

!MarsRoverStatusHeadingEast methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 11:35:30'!
moveForward
	location := 1@0 + location.! !

!MarsRoverStatusHeadingEast methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 19:14:27'!
turnLeft
	^MarsRoverStatusHeadingNorth at: location.! !

!MarsRoverStatusHeadingEast methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 19:14:37'!
turnRight
	^MarsRoverStatusHeadingSouth at: location.! !


!classDefinition: #MarsRoverStatusHeadingNorth category: 'MarsRover'!
MarsRoverStatus subclass: #MarsRoverStatusHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverStatusHeadingNorth methodsFor: 'initializing' stamp: 'NNH 10/24/2020 19:10:45'!
initializeAt: aLocation 
	location := aLocation.
	direction := 'North'.! !


!MarsRoverStatusHeadingNorth methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 11:40:08'!
moveBackwards
	location := 0@-1 + location.! !

!MarsRoverStatusHeadingNorth methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 11:30:05'!
moveForward
	location := 0@1 + location.! !

!MarsRoverStatusHeadingNorth methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 19:15:17'!
turnLeft
	^MarsRoverStatusHeadingWest at: location.! !

!MarsRoverStatusHeadingNorth methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 19:15:21'!
turnRight
	^MarsRoverStatusHeadingEast at: location.! !


!classDefinition: #MarsRoverStatusHeadingSouth category: 'MarsRover'!
MarsRoverStatus subclass: #MarsRoverStatusHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverStatusHeadingSouth methodsFor: 'initializing' stamp: 'NNH 10/24/2020 19:10:32'!
initializeAt: aLocation 
	location := aLocation.
	direction := 'South'.! !


!MarsRoverStatusHeadingSouth methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 11:41:44'!
moveBackwards
	location := 0@1 + location.! !

!MarsRoverStatusHeadingSouth methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 11:34:34'!
moveForward
	^location := 0@-1 + location! !

!MarsRoverStatusHeadingSouth methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 19:15:29'!
turnLeft
	^MarsRoverStatusHeadingEast at: location.! !

!MarsRoverStatusHeadingSouth methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 19:15:35'!
turnRight
	^MarsRoverStatusHeadingWest at: location.! !


!classDefinition: #MarsRoverStatusHeadingWest category: 'MarsRover'!
MarsRoverStatus subclass: #MarsRoverStatusHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverStatusHeadingWest methodsFor: 'initializing' stamp: 'NNH 10/24/2020 19:36:36'!
initializeAt: aLocation 
	location := aLocation.
	direction := 'West'.! !


!MarsRoverStatusHeadingWest methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 11:40:43'!
moveBackwards
	location := 1@0 + location.! !

!MarsRoverStatusHeadingWest methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 11:18:22'!
moveForward
	location := -1@0 + location.! !

!MarsRoverStatusHeadingWest methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 19:15:47'!
turnLeft
	^MarsRoverStatusHeadingSouth at: location.! !

!MarsRoverStatusHeadingWest methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 19:15:40'!
turnRight
	^MarsRoverStatusHeadingNorth at: location.! !
