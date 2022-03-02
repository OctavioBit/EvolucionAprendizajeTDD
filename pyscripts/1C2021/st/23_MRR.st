!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:26'!
test01

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: ''.
	
	self assert: (marsRover isAt: 1@2 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:31'!
test02

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@3 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:34'!
test03

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 1@1 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:38'!
test04

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: #East)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:45'!
test05

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #West)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:50'!
test06

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: #North) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:54'!
test07

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'ff'.
	
	self assert: (marsRover isAt: 1@4 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:59'!
test08

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 2@2 heading: #East)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:06'!
test09

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 0@2 heading: #East)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:12'!
test10

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: #South)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:20'!
test11

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:25'!
test12

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #South.
	
	marsRover process: 'ffbr'.
	
	self assert: (marsRover isAt: 1@1 heading: #West)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:29'!
test13

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #South.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #East)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:33'!
test14

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #West.
	
	marsRover process: 'ffbr'.
	
	self assert: (marsRover isAt: 0@2 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:37'!
test15

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #West.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #South)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/2/2018 16:27:43'!
test16

	self 
		should: [MarsRover at: 1@2 heading: #X ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: MarsRover invalidCardinalPointErrorDescription equals: anError messageText ]! !


!classDefinition: #ObserverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #ObserverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!ObserverTest methodsFor: 'testing' stamp: 'plp 6/5/2021 16:02:37'!
test01WindowAndLogSimultaneous

	| rover window log positionLog |
	
	rover := MarsRover at: 1@2 heading: #North.
	log := Log new.
	positionLog := PositionLog new.
	window := Window new.
	
	rover addObserver: log .
	rover addObserver: positionLog .
	rover addObserver: window .
	
	rover process: 'fbrfbrfbrfbr'.
	
	self assert: log size equals: 12.
	self assert: log printLog equals: #( '1@3' '1@2' 'East' '2@2' '1@2' 'South' '1@1' '1@2' 'West' '0@2' '1@2' 'North' ) asOrderedCollection.
	
	self assert: positionLog size equals: 8.
	self assert: positionLog printLog equals: #( '1@3' '1@2' '2@2' '1@2' '1@1' '1@2' '0@2' '1@2' ) asOrderedCollection.
	
	self assert: window roverPosition equals: 1@2.
	self assert: window roverHeading equals: #North.
! !


!classDefinition: #LogTest category: 'MarsRover-WithHeading'!
ObserverTest subclass: #LogTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!LogTest methodsFor: 'testing' stamp: 'plp 6/5/2021 16:17:44'!
test01LogForwardMovementFacingNorth

	| positionLog |
	
	positionLog := PositionLog new.
	self testRoverLog: positionLog afterProcessing: 'f' thenAssertLogSize: 1 andLogCollection: #( '1@3' )! !

!LogTest methodsFor: 'testing' stamp: 'plp 6/5/2021 16:17:44'!
test02LogBackwardsMovementFacingNorth

	| positionLog |
	
	positionLog := PositionLog new.
	self testRoverLog: positionLog afterProcessing: 'fb' thenAssertLogSize: 2 andLogCollection: #( '1@3' '1@2' )! !

!LogTest methodsFor: 'testing' stamp: 'plp 6/5/2021 16:17:44'!
test03LogAllMovementsForAllDirections

	| positionLog |
	
	positionLog := PositionLog new.
	self testRoverLog: positionLog afterProcessing: 'fbrfbrfbrfb' thenAssertLogSize: 8 andLogCollection: #( '1@3' '1@2' '2@2' '1@2' '1@1' '1@2' '0@2' '1@2' )! !

!LogTest methodsFor: 'testing' stamp: 'plp 6/5/2021 16:17:44'!
test04LogHeadingRotationRightFacingNorth

	| headingLog |
	
	headingLog := HeadingLog new.
	self testRoverLog: headingLog afterProcessing: 'r' thenAssertLogSize: 1 andLogCollection: #( 'East' )! !

!LogTest methodsFor: 'testing' stamp: 'plp 6/5/2021 16:17:44'!
test05LogHeadingRotationLeftFacingNorth

	| headingLog |
	
	headingLog := HeadingLog new.
	self testRoverLog: headingLog afterProcessing: 'l' thenAssertLogSize: 1 andLogCollection: #( 'West' )! !

!LogTest methodsFor: 'testing' stamp: 'plp 6/5/2021 16:17:44'!
test06LogAllHeadingRotationsForAPosition

	| headingLog |
	
	headingLog := HeadingLog new.
	self testRoverLog: headingLog afterProcessing: 'rrrrllll' thenAssertLogSize: 8 andLogCollection: #( 'East' 'South' 'West' 'North' 'West' 'South' 'East' 'North' )! !

!LogTest methodsFor: 'testing' stamp: 'plp 6/5/2021 16:17:44'!
test07LogAllEvents

	| log |
	
	log := Log new.
	self testRoverLog: log afterProcessing: 'fbrfbrfbrfbr' thenAssertLogSize: 12 andLogCollection: #( '1@3' '1@2' 'East' '2@2' '1@2' 'South' '1@1' '1@2' 'West' '0@2' '1@2' 'North' )! !


!LogTest methodsFor: 'test - private' stamp: 'plp 6/5/2021 16:17:44'!
testRoverLog: aLog afterProcessing: aStringToProcess thenAssertLogSize: aSize andLogCollection: aLogCollection

	| rover |
	
	rover := MarsRover at: 1@2 heading: #North.		
	rover addObserver: aLog.
	rover process: aStringToProcess.
	
	self assert: aLog size equals: aSize.
	self assert: aLog printLog equals: aLogCollection asOrderedCollection.! !


!classDefinition: #WindowTest category: 'MarsRover-WithHeading'!
ObserverTest subclass: #WindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!WindowTest methodsFor: 'testing' stamp: 'plp 6/5/2021 16:20:22'!
test01UpdatePositionForwardFacingNorth

	| window |
	
	window := Window new.	
	self testRoverWindow: window afterProcessing: 'f' thenAssertPosition: 1@3 andHeading: #North! !

!WindowTest methodsFor: 'testing' stamp: 'plp 6/5/2021 16:20:41'!
test02UpdatePositionBackwardFacingNorth

	| window |
	
	window := Window new.
	self testRoverWindow: window afterProcessing: 'fb' thenAssertPosition: 1@2 andHeading: #North! !

!WindowTest methodsFor: 'testing' stamp: 'plp 6/5/2021 16:21:05'!
test03UpdateHeadingRotationRight

	| window |
	
	window := Window new.
	self testRoverWindow: window afterProcessing: 'r' thenAssertPosition: 1@2 andHeading: #East! !

!WindowTest methodsFor: 'testing' stamp: 'plp 6/5/2021 16:21:20'!
test04InitialPositionAfterAddWindow

	| window |
	
	window := Window new.
	self testRoverWindow: window afterProcessing: '' thenAssertPosition: 1@2 andHeading: #North! !


!WindowTest methodsFor: 'test - private' stamp: 'plp 6/5/2021 16:19:45'!
testRoverWindow: aWindow afterProcessing: aStringToProcess thenAssertPosition: aPosition andHeading: aHeading

	| rover |
	
	rover := MarsRover at: 1@2 heading: #North.		
	rover addObserver: aWindow.
	rover process: aStringToProcess.
	
	self assert: aWindow roverPosition equals: aPosition.
	self assert: aWindow roverHeading equals: aHeading.! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'plp 6/5/2021 15:26:31'!
initializeAt: aPosition heading: aHeading

	position := aPosition.
	head := aHeading.
	
	observers := OrderedCollection new.! !


!MarsRover methodsFor: 'heading' stamp: 'plp 6/5/2021 15:05:01'!
headEast
	
	self headRoverTo: MarsRoverHeadingEast! !

!MarsRover methodsFor: 'heading' stamp: 'plp 6/5/2021 15:05:07'!
headNorth
	
	self headRoverTo: MarsRoverHeadingNorth! !

!MarsRover methodsFor: 'heading' stamp: 'plp 6/5/2021 15:49:58'!
headRoverTo: aNewHeading

	head := aNewHeading new.
	
	observers do: [ :observer | observer updateHeading: head class cardinalPoint ]! !

!MarsRover methodsFor: 'heading' stamp: 'plp 6/5/2021 15:05:13'!
headSouth
	
	self headRoverTo: MarsRoverHeadingSouth! !

!MarsRover methodsFor: 'heading' stamp: 'plp 6/5/2021 15:05:16'!
headWest
	
	self headRoverTo: MarsRoverHeadingWest! !

!MarsRover methodsFor: 'heading' stamp: 'plp 6/5/2021 15:04:45'!
rotateLeft
	
	head rotateLeft: self.! !

!MarsRover methodsFor: 'heading' stamp: 'plp 6/5/2021 15:04:42'!
rotateRight
	
	head rotateRight: self.! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 8/22/2019 12:00:30'!
isAt: aPosition heading: aCardinalPoint

	^position = aPosition and: [ head isHeading: aCardinalPoint ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'plp 6/5/2021 14:56:05'!
moveBackward
	
	head moveBackward: self.! !

!MarsRover methodsFor: 'moving' stamp: 'plp 6/5/2021 14:57:19'!
moveEast
	
	self moveRoverBy: (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'plp 6/5/2021 14:56:08'!
moveForward
	
	head moveForward: self.! !

!MarsRover methodsFor: 'moving' stamp: 'plp 6/5/2021 14:57:28'!
moveNorth
	
	self moveRoverBy: (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'plp 6/5/2021 15:30:46'!
moveRoverBy: aPosition
	
	position := position + aPosition.
	
	observers do: [ :observer | observer updatePosition: position ]! !

!MarsRover methodsFor: 'moving' stamp: 'plp 6/5/2021 14:57:31'!
moveSouth
	
	self moveRoverBy: (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'plp 6/5/2021 14:57:36'!
moveWest
	
	self moveRoverBy: (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'observing' stamp: 'plp 6/5/2021 15:57:59'!
addObserver: anObserver 
	
	observers add: anObserver.
	
	anObserver initialPosition: position andHeading: head class cardinalPoint.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 8/22/2019 12:01:48'!
at: aPosition heading: aCardinalPoint
	
	^self new initializeAt: aPosition heading: (MarsRoverHeading heading: aCardinalPoint)! !

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 7/2/2018 16:26:14'!
invalidCardinalPointErrorDescription
	
	^'Invalid cardinal point'! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:06:17'!
rotateLeft: aMarsRover

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:08:23'!
rotateRight: aMarsRover

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 7/2/2018 19:07:42'!
isHeading: aCardinalPoint

	^self class isFor: aCardinalPoint! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:20'!
moveBackward: aMarsRover

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:54'!
moveForward: aMarsRover

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'cardinal point' stamp: 'HAW 7/2/2018 19:07:01'!
cardinalPoint

	self subclassResponsibility ! !


!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 8/22/2019 12:02:00'!
heading: aCardinalPoint

	^self subclasses 
		detect: [ :aMarsRoverPositionClass | aMarsRoverPositionClass isFor: aCardinalPoint ]
		ifFound: [ :aMarsRoverPositionClass | aMarsRoverPositionClass new ]
		ifNone: [ self error: MarsRover invalidCardinalPointErrorDescription ]! !


!MarsRoverHeading class methodsFor: 'testing' stamp: 'HAW 7/2/2018 17:01:33'!
isFor: aCardinalPoint

	^self cardinalPoint = aCardinalPoint ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:09:19'!
moveBackward: aMarsRover
	
	^aMarsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:09:28'!
moveForward: aMarsRover
	
	^aMarsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:09:42'!
rotateLeft: aMarsRover
	
	^aMarsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:09:54'!
rotateRight: aMarsRover
	
	^aMarsRover headSouth! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingEast class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingEast class
	instanceVariableNames: ''!

!MarsRoverHeadingEast class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:01:53'!
cardinalPoint

	^#East! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:10:12'!
moveBackward: aMarsRover
	
	^aMarsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:10:23'!
moveForward: aMarsRover
	
	^aMarsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:10:40'!
rotateLeft: aMarsRover
	
	^aMarsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:10:51'!
rotateRight: aMarsRover
	
	^aMarsRover headEast! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingNorth class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingNorth class
	instanceVariableNames: ''!

!MarsRoverHeadingNorth class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:11'!
cardinalPoint

	^#North! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:11:15'!
moveBackward: aMarsRover
	
	^aMarsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:11:25'!
moveForward: aMarsRover
	
	^aMarsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:11:55'!
rotateLeft: aMarsRover
	
	^aMarsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:11:50'!
rotateRight: aMarsRover
	
	^aMarsRover headWest! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingSouth class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingSouth class
	instanceVariableNames: ''!

!MarsRoverHeadingSouth class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:17'!
cardinalPoint

	^#South! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:12:07'!
moveBackward: aMarsRover

	^aMarsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:12:15'!
moveForward: aMarsRover
	
	^aMarsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:12:26'!
rotateLeft: aMarsRover
	
	^aMarsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:12:41'!
rotateRight: aMarsRover
	
	^aMarsRover headNorth! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingWest class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingWest class
	instanceVariableNames: ''!

!MarsRoverHeadingWest class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:23'!
cardinalPoint

	^#West! !


!classDefinition: #Observer category: 'MarsRover-WithHeading'!
Object subclass: #Observer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Observer methodsFor: 'initialization' stamp: 'plp 6/5/2021 16:03:30'!
initialPosition: aPosition andHeading: aHeading 
	
	self subclassResponsibility ! !


!Observer methodsFor: 'tracing' stamp: 'plp 6/5/2021 16:03:13'!
updateHeading: aPosition
	
	self subclassResponsibility ! !

!Observer methodsFor: 'tracing' stamp: 'plp 6/5/2021 15:39:06'!
updatePosition: aPosition
	
	self subclassResponsibility ! !


!classDefinition: #Log category: 'MarsRover-WithHeading'!
Observer subclass: #Log
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Log methodsFor: 'initialization' stamp: 'plp 6/5/2021 15:58:23'!
initialPosition: aPosition andHeading: aHeading! !

!Log methodsFor: 'initialization' stamp: 'plp 6/5/2021 14:46:59'!
initialize

	log := OrderedCollection new.! !


!Log methodsFor: 'tracing' stamp: 'plp 6/5/2021 15:50:07'!
updateHeading: aNewHeading

	log add: aNewHeading asString .! !

!Log methodsFor: 'tracing' stamp: 'plp 6/5/2021 15:30:08'!
updatePosition: aPosition
	
	log add: aPosition asString.! !


!Log methodsFor: 'testing' stamp: 'plp 6/5/2021 14:51:04'!
printLog

	^ log! !

!Log methodsFor: 'testing' stamp: 'plp 6/5/2021 14:49:49'!
size

	^ log size.! !


!classDefinition: #HeadingLog category: 'MarsRover-WithHeading'!
Log subclass: #HeadingLog
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HeadingLog methodsFor: 'tracing' stamp: 'plp 6/5/2021 15:40:57'!
updatePosition: aNewPosition! !


!classDefinition: #PositionLog category: 'MarsRover-WithHeading'!
Log subclass: #PositionLog
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionLog methodsFor: 'tracing' stamp: 'plp 6/5/2021 15:41:02'!
updateHeading: aNewHeading! !


!classDefinition: #Window category: 'MarsRover-WithHeading'!
Observer subclass: #Window
	instanceVariableNames: 'position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Window methodsFor: 'initialization' stamp: 'plp 6/5/2021 15:53:02'!
initialPosition: aPosition andHeading: aHeading 
	
	position := aPosition.
	heading := aHeading! !


!Window methodsFor: 'tracing' stamp: 'plp 6/5/2021 15:50:18'!
updateHeading: aHeading
	
	heading := aHeading .! !

!Window methodsFor: 'tracing' stamp: 'plp 6/5/2021 15:12:16'!
updatePosition: aPosition
	
	position := aPosition! !


!Window methodsFor: 'testing' stamp: 'plp 6/5/2021 15:21:49'!
roverHeading
	
	^ heading ! !

!Window methodsFor: 'testing' stamp: 'plp 6/5/2021 15:12:31'!
roverPosition
	
	^ position! !
