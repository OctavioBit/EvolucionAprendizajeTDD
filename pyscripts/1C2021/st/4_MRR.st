!classDefinition: #MarsRoverObserverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverObserverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObserverTest methodsFor: 'as yet unclassified' stamp: 'JA 6/6/2021 14:38:30'!
test01MoveForwardAddALogEntryIntoPositionLogWithCorrectPosition

	|marsRover log|
	marsRover := MarsRover at: 0@0 heading: #North.	
	log := PositionLog new.	
	marsRover addObserver: log.
	
	marsRover process: 'f'.
	
	self assert: log lines size equals: 1.
	self assert: '0@1' equals: log lines first.
	
	! !

!MarsRoverObserverTest methodsFor: 'as yet unclassified' stamp: 'JA 6/6/2021 14:38:39'!
test02MoveBackwardAddALogEntryIntoPositionLogWithCorrectPosition

	|marsRover log|
	marsRover := MarsRover at: 0@0 heading: #North.	
	log := PositionLog new.	
	marsRover addObserver: log.
	
	marsRover process: 'b'.
	
	self assert: log lines size equals: 1.
	self assert: '0@-1' equals: log lines first.
	
	! !

!MarsRoverObserverTest methodsFor: 'as yet unclassified' stamp: 'JA 6/6/2021 14:48:05'!
test03MoveTwiceAddsTwoLogEntriesIntoPositionLogWithCorrectsPositions

	|marsRover log|
	marsRover := MarsRover at: 0@0 heading: #North.	
	log := PositionLog new.	
	marsRover addObserver: log.
	
	marsRover process: 'ff'.
	
	self assert: log lines size equals: 2.
	self assert: '0@1' equals: log lines first.
	self assert: '0@2' equals: log lines second.	! !

!MarsRoverObserverTest methodsFor: 'as yet unclassified' stamp: 'JA 6/6/2021 14:47:48'!
test04RotateRightTwiceAddsTwoLogEntriesIntoHeadingLogWithCorrectHeadings

	|marsRover log|
	marsRover := MarsRover at: 0@0 heading: #North.	
	log := HeadingLog new.	
	marsRover addObserver: log.
	
	marsRover process: 'rr'.
	
	self assert: log lines size equals: 2.
	self assert: 'East' equals: log lines first.
	self assert: 'South' equals: log lines second.	
	! !

!MarsRoverObserverTest methodsFor: 'as yet unclassified' stamp: 'JA 6/6/2021 14:54:59'!
test05RotateLeftTwiceAddsTwoEntriesIntoHeadingLogWithCorrectHeading

	|marsRover log|
	marsRover := MarsRover at: 0@0 heading: #South.	
	log := HeadingLog new.	
	marsRover addObserver: log.
	
	marsRover process: 'll'.
	
	self assert: log lines size equals: 2.
	self assert: 'East' equals: log lines first.
	self assert: 'North' equals: log lines second.	! !

!MarsRoverObserverTest methodsFor: 'as yet unclassified' stamp: 'JA 6/6/2021 14:50:12'!
test06MoveForwardChangeRoverWindowPositionText

	|marsRover window|
	marsRover := MarsRover at: 0@0 heading: #South.	
	window := RoverWindow new.	
	marsRover addObserver: window.
	
	marsRover process: 'f'.
	
	self assert: window roverPositionText equals: '0@-1'.
	
	
	! !

!MarsRoverObserverTest methodsFor: 'as yet unclassified' stamp: 'JA 6/6/2021 14:52:29'!
test07RotateRightChangeRoverWindowHeadingText

	|marsRover window|
	marsRover := MarsRover at: 0@0 heading: #South.	
	window := RoverWindow new.	
	marsRover addObserver: window.
	
	marsRover process: 'r'.
	
	self assert: window roverHeadingText equals: 'West'.
	
	
	! !

!MarsRoverObserverTest methodsFor: 'as yet unclassified' stamp: 'JA 6/6/2021 14:55:13'!
test08RotateLeftChangeRoverWindowHeadingText

	|marsRover window|
	marsRover := MarsRover at: 0@0 heading: #South.	
	window := RoverWindow new.	
	marsRover addObserver: window.
	
	marsRover process: 'l'.
	
	self assert: window roverHeadingText equals: 'East'.	
	
	! !

!MarsRoverObserverTest methodsFor: 'as yet unclassified' stamp: 'JA 6/6/2021 14:58:10'!
test09MoveAndRotateChangeRoverWindowFields

	|marsRover window|
	marsRover := MarsRover at: 0@0 heading: #South.	
	window := RoverWindow new.	
	marsRover addObserver: window.
	
	marsRover process: 'lf'.
	
	self assert: window roverHeadingText equals: 'East'.
	self assert: window roverPositionText equals: '1@0'.	
	
	! !

!MarsRoverObserverTest methodsFor: 'as yet unclassified' stamp: 'JA 6/6/2021 15:03:55'!
test10MoveAndRotateAddsJustOneLogEntryIntoHeadingLog

	|marsRover log|
	marsRover := MarsRover at: 0@0 heading: #South.	
	log := HeadingLog new.	
	marsRover addObserver: log.
	
	marsRover process: 'lf'.
	
	self assert: log lines size equals: 1.
	self assert: 'East' equals: log lines first.
	
	
	! !

!MarsRoverObserverTest methodsFor: 'as yet unclassified' stamp: 'JA 6/6/2021 15:05:24'!
test11MoveTwiceAndRotateAddsTwoLogEntriesIntoPositionLog

	|marsRover log|
	marsRover := MarsRover at: 0@0 heading: #North.	
	log := PositionLog new.	
	marsRover addObserver: log.
	
	marsRover process: 'ffr'.
	
	self assert: log lines size equals: 2.
	self assert: '0@1' equals: log lines first.
	self assert: '0@2' equals: log lines second.	! !

!MarsRoverObserverTest methodsFor: 'as yet unclassified' stamp: 'JA 6/6/2021 15:07:59'!
test12MoveAndRotateNotifyAllObservers

	|marsRover aHeadingLog aPositionLog aRoverWindow |
	marsRover := MarsRover at: 0@0 heading: #North.	
	aPositionLog := PositionLog new.
	aHeadingLog := HeadingLog  new.
	aRoverWindow := RoverWindow  new.				
	marsRover addObserver: aPositionLog.
	marsRover addObserver: aHeadingLog.	
	marsRover addObserver: aRoverWindow .		
	
	marsRover process: 'fr'.
	
	self assert: aPositionLog lines size equals: 1.
	self assert: '0@1' equals: aPositionLog lines first.
	self assert: aHeadingLog lines size equals: 1.
	self assert: 'East' equals: aHeadingLog lines first.
	self assert: aRoverWindow roverHeadingText equals: 'East'.
	self assert: aRoverWindow roverPositionText equals: '0@1'.	! !


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


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head xxxx observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'initialization' stamp: 'JA 6/6/2021 13:21:39'!
initializeAt: aPosition heading: aHeading

	position := aPosition.
	head := aHeading.
	
	observers := OrderedCollection new.! !


!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'heading' stamp: 'ET 6/3/2021 20:49:14'!
headEast
	
	head := MarsRoverHeadingEast new.! !

!MarsRover methodsFor: 'heading' stamp: 'ET 6/3/2021 20:49:10'!
headNorth
	
	head := MarsRoverHeadingNorth new.! !

!MarsRover methodsFor: 'heading' stamp: 'ET 6/3/2021 20:49:06'!
headSouth
	
	head := MarsRoverHeadingSouth new.! !

!MarsRover methodsFor: 'heading' stamp: 'ET 6/3/2021 20:49:01'!
headWest
	
	head := MarsRoverHeadingWest new.! !

!MarsRover methodsFor: 'heading' stamp: 'JA 6/6/2021 13:24:02'!
rotateLeft
	
	head rotateLeft: self.
	self notifyHeadingChanged.! !

!MarsRover methodsFor: 'heading' stamp: 'JA 6/6/2021 13:24:36'!
rotateRight
	
	head rotateRight: self.
	self notifyHeadingChanged.! !


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


!MarsRover methodsFor: 'moving' stamp: 'JA 6/6/2021 13:24:53'!
moveBackward
	
	head moveBackward: self.
	self notifyPositionChanged.! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:01'!
moveEast
	
	position := position + (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'JA 6/6/2021 13:25:14'!
moveForward
	
	head moveForward: self.
	self notifyPositionChanged.! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:12'!
moveNorth
	
	position := position + (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:34'!
moveSouth
	
	position := position + (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:32'!
moveWest
	
	position := position + (-1@0)! !


!MarsRover methodsFor: 'observers notifications' stamp: 'JA 6/6/2021 13:31:47'!
notifyHeadingChanged

	^ observers do: [:observer | observer headingChangedTo: head ]! !

!MarsRover methodsFor: 'observers notifications' stamp: 'JA 6/6/2021 13:42:40'!
notifyPositionChanged

	^ observers do: [:observer | observer positionChangedTo: position]! !


!MarsRover methodsFor: 'command processing' stamp: 'ET 6/3/2021 20:34:14'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ].
	
	
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'observers' stamp: 'JA 6/6/2021 13:21:10'!
addObserver: aMarsRoverObserver
	
	observers add: aMarsRoverObserver.! !

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


!MarsRoverHeading methodsFor: 'observer notification' stamp: 'ET 6/6/2021 20:03:07'!
notifyObserver: aMarsRoverObserver
	
	self subclassResponsibility.! !

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


!MarsRoverHeadingEast methodsFor: 'observer notification' stamp: 'ET 6/6/2021 19:53:43'!
notifyObserver: aMarsRoverObserver
	
	aMarsRoverObserver headingChangedToEast: self.! !

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


!MarsRoverHeadingNorth methodsFor: 'observer notification' stamp: 'ET 6/6/2021 19:53:58'!
notifyObserver: aMarsRoverObserver
	
	aMarsRoverObserver headingChangedToNorth: self.! !


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


!MarsRoverHeadingSouth methodsFor: 'observer notification' stamp: 'ET 6/6/2021 19:54:07'!
notifyObserver: aMarsRoverObserver
	
	aMarsRoverObserver headingChangedToSouth: self.! !


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


!MarsRoverHeadingWest methodsFor: 'observer notification' stamp: 'ET 6/6/2021 19:54:17'!
notifyObserver: aMarsRoverObserver
	
	aMarsRoverObserver headingChangedToWest: self.! !


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


!classDefinition: #MarsRoverObserver category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverObserver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObserver methodsFor: 'notifications' stamp: 'ET 6/6/2021 19:51:06'!
headingChangedTo: aMarsRoverHeading

	aMarsRoverHeading notifyObserver: self.! !

!MarsRoverObserver methodsFor: 'notifications' stamp: 'ET 6/6/2021 19:57:22'!
headingChangedToEast: aMarsRoverHeadingEast! !

!MarsRoverObserver methodsFor: 'notifications' stamp: 'ET 6/6/2021 19:57:19'!
headingChangedToNorth: aMarsRoverHeadingNorth! !

!MarsRoverObserver methodsFor: 'notifications' stamp: 'ET 6/6/2021 19:57:15'!
headingChangedToSouth: aMarsRoverHeadingSouth! !

!MarsRoverObserver methodsFor: 'notifications' stamp: 'ET 6/6/2021 19:57:10'!
headingChangedToWest: aMarsRoverHeadingWest! !

!MarsRoverObserver methodsFor: 'notifications' stamp: 'JA 6/6/2021 13:06:28'!
positionChangedTo: aMarsRoverPosition! !


!classDefinition: #HeadingLog category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #HeadingLog
	instanceVariableNames: 'lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HeadingLog methodsFor: 'accessing' stamp: 'JA 6/6/2021 12:25:42'!
lines
	^lines! !


!HeadingLog methodsFor: 'notifications' stamp: 'ET 6/6/2021 19:56:03'!
headingChangedToEast: aMarsRoverHeadingEast
	lines add: 'East'.! !

!HeadingLog methodsFor: 'notifications' stamp: 'ET 6/6/2021 19:56:40'!
headingChangedToNorth: aMarsRoverHeadingNorth
	lines add: 'North'.! !

!HeadingLog methodsFor: 'notifications' stamp: 'ET 6/6/2021 19:56:28'!
headingChangedToSouth: aMarsRoverHeadingSouth
	lines add: 'South'.! !

!HeadingLog methodsFor: 'notifications' stamp: 'ET 6/6/2021 19:56:15'!
headingChangedToWest: aMarsRoverHeadingWest
	lines add: 'West'.! !


!HeadingLog methodsFor: 'initialization' stamp: 'JA 6/6/2021 12:25:25'!
initialize
	lines := OrderedCollection new! !


!classDefinition: #PositionLog category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #PositionLog
	instanceVariableNames: 'lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionLog methodsFor: 'accessing' stamp: 'JA 6/6/2021 12:16:37'!
lines
	^lines! !


!PositionLog methodsFor: 'initialization' stamp: 'JA 6/6/2021 12:16:21'!
initialize
	lines := OrderedCollection new! !


!PositionLog methodsFor: 'notifications' stamp: 'ET 6/6/2021 19:58:27'!
positionChangedTo: aMarsRoverPosition 
	lines add: aMarsRoverPosition  printString.! !


!classDefinition: #RoverWindow category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #RoverWindow
	instanceVariableNames: 'position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!RoverWindow methodsFor: 'notifications' stamp: 'ET 6/6/2021 19:59:05'!
headingChangedToEast: aMarsRoverHeadingEast
	heading := 'East'.! !

!RoverWindow methodsFor: 'notifications' stamp: 'ET 6/6/2021 19:59:36'!
headingChangedToNorth: aMarsRoverHeadingNorth
	heading := 'North'.! !

!RoverWindow methodsFor: 'notifications' stamp: 'ET 6/6/2021 20:00:00'!
headingChangedToSouth: aMarsRoverHeadingSouth
	heading := 'South'.! !

!RoverWindow methodsFor: 'notifications' stamp: 'ET 6/6/2021 19:59:26'!
headingChangedToWest: aMarsRoverHeadingWest
	heading := 'West'.! !

!RoverWindow methodsFor: 'notifications' stamp: 'ET 6/6/2021 20:00:35'!
positionChangedTo: aMarsRoverPosition 
	position := aMarsRoverPosition printString.! !


!RoverWindow methodsFor: 'accessing' stamp: 'ET 6/3/2021 21:19:29'!
roverHeadingText
	^heading.! !

!RoverWindow methodsFor: 'accessing' stamp: 'ET 6/3/2021 21:14:00'!
roverPositionText
	^position.! !
