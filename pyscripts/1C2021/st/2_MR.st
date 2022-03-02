!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/16/2021 18:31:45'!
test01MarsRoverCoordsAreInitialWhenDidNotMove
	
	| marsRover initialPosition |
	
	initialPosition := 1@0.
	marsRover := MarsRover initAt: initialPosition heading: South new.
	marsRover processCommands: ''.
	
	self assert: marsRover position = initialPosition.
	self assert: (marsRover headsTo isKindOf: South).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/16/2021 18:31:37'!
test02MoveForwardSouthDecreasesYAxis
	
	| marsRover initialPosition |
	
	initialPosition := 1@0.
	marsRover := MarsRover initAt: initialPosition heading: South new.
	marsRover processCommands: 'f'.
	
	self assert: marsRover position = (1@-1).
	self assert: (marsRover headsTo isKindOf: South).	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/16/2021 18:31:28'!
test03MoveBackwardsSouthIncreasesYAxis
	
	| marsRover initialPosition |
	
	initialPosition := 1@0.
	marsRover := MarsRover initAt: initialPosition heading: South new.
	marsRover processCommands: 'b'.
	
	self assert: marsRover position = (1@1).
	self assert: (marsRover headsTo isKindOf: South).	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/16/2021 18:31:18'!
test04MoveForwardNorthIncreasesYAxis
	
	| marsRover initialPosition |
	
	initialPosition := 1@0.
	marsRover := MarsRover initAt: initialPosition heading: North new.
	marsRover processCommands: 'f'.
	
	self assert: marsRover position = (1@1).
	self assert: (marsRover headsTo isKindOf: North).	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/16/2021 18:31:10'!
test05MoveBackwardNorthDecreasesYAxis
	
	| marsRover initialPosition |
	
	initialPosition := 1@0.
	marsRover := MarsRover initAt: initialPosition heading: North new.
	marsRover processCommands: 'b'.
	
	self assert: marsRover position = (1@-1).
	self assert: (marsRover headsTo isKindOf: North).	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/16/2021 18:31:05'!
test06MoveForwardEastIncreasesXAxis
	
	| marsRover initialPosition |
	
	initialPosition := 1@0.
	marsRover := MarsRover initAt: initialPosition heading: East new.
	marsRover processCommands: 'f'.
	
	self assert: marsRover position = (2@0).
	self assert: (marsRover headsTo isKindOf: East).	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/16/2021 18:30:58'!
test07MoveBackwardEastDecreasesXAxis
	
	| marsRover initialPosition |
	
	initialPosition := 1@0.
	marsRover := MarsRover initAt: initialPosition heading: East new.
	marsRover processCommands: 'b'.
	
	self assert: marsRover position = (0@0).
	self assert: (marsRover headsTo isKindOf: East).	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/16/2021 18:30:49'!
test08MoveForwardWestDecreasesXAxis
	
	| marsRover initialPosition |
	
	initialPosition := 1@0.
	marsRover := MarsRover initAt: initialPosition heading: West new.
	marsRover processCommands: 'f'.
	
	self assert: marsRover position = (0@0).
	self assert: (marsRover headsTo isKindOf: West).	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/16/2021 18:30:40'!
test09MoveBackwardWestIncrementsXAxis
	
	| marsRover initialPosition |
	
	initialPosition := 1@0.
	marsRover := MarsRover initAt: initialPosition heading: West new.
	marsRover processCommands: 'b'.
	
	self assert: marsRover position = (2@0).
	self assert: (marsRover headsTo isKindOf: West).
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/16/2021 18:30:33'!
test10TurningRightWhenHeadingNorthShouldHeadEast
	
	| marsRover initialPosition |
	
	initialPosition := 1@0.
	marsRover := MarsRover initAt: initialPosition heading: North new.
	marsRover processCommands: 'r'.
	
	self assert: marsRover position = (1@0).
	self assert: (marsRover headsTo isKindOf: East).
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/16/2021 18:30:26'!
test11TurningLeftWhenHeadingNorthShouldHeadWest
	
	| marsRover initialPosition |
	
	initialPosition := 1@0.
	marsRover := MarsRover initAt: initialPosition heading: North new.
	marsRover processCommands: 'l'.
	
	self assert: marsRover position = (1@0).
	self assert: (marsRover headsTo isKindOf: West).
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/16/2021 18:30:19'!
test12TurningRightWhenHeadingEastShouldHeadSouth
	
	| marsRover initialPosition |
	
	initialPosition := 1@0.
	marsRover := MarsRover initAt: initialPosition heading: East new.
	marsRover processCommands: 'r'.
	
	self assert: marsRover position = (1@0).
	self assert: (marsRover headsTo isKindOf: South).
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/16/2021 18:30:12'!
test13TurningLeftWhenHeadingEastShouldHeadNorth
	
	| marsRover initialPosition |
	
	initialPosition := 1@0.
	marsRover := MarsRover initAt: initialPosition heading: East new.
	marsRover processCommands: 'l'.
	
	self assert: marsRover position = (1@0).
	self assert: (marsRover headsTo isKindOf: North).
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/16/2021 18:30:05'!
test14TurningRightWhenHeadingSouthShouldHeadWest
	
	| marsRover initialPosition |
	
	initialPosition := 1@0.
	marsRover := MarsRover initAt: initialPosition heading: South new.
	marsRover processCommands: 'r'.
	
	self assert: marsRover position = (1@0).
	self assert: (marsRover headsTo isKindOf: West).
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/16/2021 18:29:58'!
test15TurningLeftWhenHeadingSouthShouldHeadEast
	
	| marsRover initialPosition |
	
	initialPosition := 1@0.
	marsRover := MarsRover initAt: initialPosition heading: South new.
	marsRover processCommands: 'l'.
	
	self assert: marsRover position = (1@0).
	self assert: (marsRover headsTo isKindOf: East).
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/16/2021 18:29:50'!
test16TurningRightWhenHeadingWestShouldHeadNorth
	
	| marsRover initialPosition |
	
	initialPosition := 1@0.
	marsRover := MarsRover initAt: initialPosition heading: West new.
	marsRover processCommands: 'r'.
	
	self assert: marsRover position = (1@0).
	self assert: (marsRover headsTo isKindOf: North).
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/16/2021 18:29:45'!
test17TurningLeftWhenHeadingWestShouldHeadSouth
	
	| marsRover initialPosition |
	
	initialPosition := 1@0.
	marsRover := MarsRover initAt: initialPosition heading: West new.
	marsRover processCommands: 'l'.
	
	self assert: marsRover position = (1@0).
	self assert: (marsRover headsTo isKindOf: South).
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/16/2021 18:29:33'!
test18ExecutesMoreThanOneValidCommand
	
	| marsRover initialPosition |
	
	initialPosition := 0@0.
	marsRover := MarsRover initAt: initialPosition heading: North new.
	marsRover processCommands: 'bb'.
	
	self assert: marsRover position = (0@-2).
	self assert: (marsRover headsTo isKindOf: North).
	
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'MS 5/16/2021 18:29:15'!
test19StopsExecutingAfterInvalidCommand
	
	| marsRover initialPosition |
	
	initialPosition := 0@0.
	marsRover := MarsRover initAt: initialPosition heading: North new.
	marsRover processCommands: 'bbmb'.
	
	self assert: marsRover position = (0@-2).
	self assert: (marsRover headsTo isKindOf: North).
	
	! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'GDH 5/13/2021 21:39:06'!
positionAt: aPosition heading: aCardinal

	position := aPosition.
	heading := aCardinal. 
	
	! !


!MarsRover methodsFor: 'processing commands' stamp: 'MS 5/16/2021 17:46:29'!
processCommands: aCommandLine

	
	aCommandLine do: [ :aCommand | 
		self processCommand: aCommand ifInvalid: [^self]].
		! !


!MarsRover methodsFor: 'processing commands - private' stamp: 'MS 5/16/2021 18:39:43'!
processCommand: aCommand ifInvalid: aClosure 
	
	self assertIsValid: aCommand ifInvalid: aClosure.
	
	heading process: aCommand for: self.
	
	
	
	! !

!MarsRover methodsFor: 'processing commands - private' stamp: 'MS 5/16/2021 18:53:41'!
processCommandWhenHeadingEast: aCommand

	(aCommand = $f) ifTrue: [self moveEast].
	(aCommand = $b) ifTrue: [self moveWest].
	(aCommand = $r) ifTrue: [self rotateSouth].
	(aCommand = $l) ifTrue: [self rotateNorth].
	! !

!MarsRover methodsFor: 'processing commands - private' stamp: 'MS 5/16/2021 18:53:38'!
processCommandWhenHeadingNorth: aCommand

	(aCommand = $f) ifTrue: [self moveNorth].
	(aCommand = $b) ifTrue: [self moveSouth].
	(aCommand = $r) ifTrue: [self rotateEast].
	(aCommand = $l) ifTrue: [self rotateWest].
	! !

!MarsRover methodsFor: 'processing commands - private' stamp: 'MS 5/16/2021 18:53:34'!
processCommandWhenHeadingSouth: aCommand

	(aCommand = $f) ifTrue: [self moveSouth ].
	(aCommand = $b) ifTrue: [self moveNorth ].
	(aCommand = $r) ifTrue: [self rotateWest ].
	(aCommand = $l) ifTrue: [self rotateEast ].
	! !

!MarsRover methodsFor: 'processing commands - private' stamp: 'MS 5/16/2021 18:53:29'!
processCommandWhenHeadingWest: aCommand

	(aCommand = $f) ifTrue: [self moveWest ].
	(aCommand = $b) ifTrue: [self moveEast ].
	(aCommand = $r) ifTrue: [self rotateNorth ].
	(aCommand = $l) ifTrue: [self rotateSouth ].
	
! !


!MarsRover methodsFor: 'assertions - private' stamp: 'MS 5/16/2021 18:33:40'!
assertIsValid: aCommand ifInvalid: aClosure.
	
	( (aCommand = $f) | (aCommand = $b) | (aCommand = $r) | (aCommand = $l) ) ifFalse: [aClosure value].
	
	
	! !


!MarsRover methodsFor: 'moving - private' stamp: 'MS 5/16/2021 18:48:22'!
moveEast

	position :=  (position x + 1) @ position y.! !

!MarsRover methodsFor: 'moving - private' stamp: 'MS 5/16/2021 18:49:52'!
moveNorth

	position :=  position x @ (position y + 1).! !

!MarsRover methodsFor: 'moving - private' stamp: 'MS 5/16/2021 18:50:17'!
moveSouth

	position :=  position x @ ( position y - 1 ).! !

!MarsRover methodsFor: 'moving - private' stamp: 'MS 5/16/2021 18:48:38'!
moveWest

	position :=  (position x - 1) @ position y.! !

!MarsRover methodsFor: 'moving - private' stamp: 'MS 5/16/2021 18:49:08'!
rotateEast

	heading := East new! !

!MarsRover methodsFor: 'moving - private' stamp: 'MS 5/16/2021 18:49:17'!
rotateNorth

	heading := North new! !

!MarsRover methodsFor: 'moving - private' stamp: 'MS 5/16/2021 18:49:22'!
rotateSouth

	heading := South new! !

!MarsRover methodsFor: 'moving - private' stamp: 'MS 5/16/2021 18:49:29'!
rotateWest

	heading := West new! !


!MarsRover methodsFor: 'testing' stamp: 'GDH 5/13/2021 21:40:57'!
headsTo

	^heading! !

!MarsRover methodsFor: 'testing' stamp: 'GDH 5/13/2021 21:40:26'!
position
	
	^position! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'MS 5/16/2021 18:16:35'!
initAt: aPosition heading: aCardinalDirection 

	^self new positionAt: aPosition heading: aCardinalDirection! !


!classDefinition: #MarsRoverCardinalDirection category: 'MarsRover'!
Object subclass: #MarsRoverCardinalDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverCardinalDirection methodsFor: 'command processing' stamp: 'MS 5/16/2021 18:39:43'!
process: aCommand for: aMarsRover

	^self subclassResponsibility.! !


!classDefinition: #East category: 'MarsRover'!
MarsRoverCardinalDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'command processing' stamp: 'MS 5/16/2021 18:39:43'!
process: aCommand for: aMarsRover

	aMarsRover processCommandWhenHeadingEast: aCommand.! !


!classDefinition: #North category: 'MarsRover'!
MarsRoverCardinalDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'command processing' stamp: 'MS 5/16/2021 18:39:43'!
process: aCommand for: aMarsRover

	aMarsRover processCommandWhenHeadingNorth: aCommand.! !


!classDefinition: #South category: 'MarsRover'!
MarsRoverCardinalDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'command processing' stamp: 'MS 5/16/2021 18:39:43'!
process: aCommand for: aMarsRover

	aMarsRover processCommandWhenHeadingSouth: aCommand.! !


!classDefinition: #West category: 'MarsRover'!
MarsRoverCardinalDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'command processing' stamp: 'MS 5/16/2021 18:39:43'!
process: aCommand for: aMarsRover

	aMarsRover processCommandWhenHeadingWest: aCommand.! !
