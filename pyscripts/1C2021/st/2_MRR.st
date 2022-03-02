!classDefinition: #MarsRoverLoggerTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverLoggerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'GDH 6/7/2021 15:32:11'!
test01LogsPositionWhenMovingNorth

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	log := MarsRoverLogger new.
	marsRover observePosition: log.
	
	marsRover process: 'f'.

	self assert: 1 equals: log size.
	self assert: '1@2' equals: log first.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'GDH 6/7/2021 15:32:11'!
test02LogsPositionWhenMovingEast

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #West.
	log := MarsRoverLogger new.
	marsRover observePosition: log.
	
	marsRover process: 'b'.

	self assert: 1 equals: log size.
	self assert: '2@1' equals: log first.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'GDH 6/7/2021 15:32:11'!
test03LogsPositionWhenMovingSouth

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	log := MarsRoverLogger new.
	marsRover observePosition: log.
	
	marsRover process: 'b'.

	self assert: 1 equals: log size.
	self assert: '1@0' equals: log first.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'GDH 6/7/2021 15:32:11'!
test04LogsPositionWhenMovingWest

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #East.
	log := MarsRoverLogger new.
	marsRover observePosition: log.
	
	marsRover process: 'b'.

	self assert: 1 equals: log size.
	self assert: '0@1' equals: log first.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'GDH 6/7/2021 15:32:36'!
test05LogsHeadingWhenRotatingHeadingNorth

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #East.
	log := MarsRoverLogger new.
	marsRover observeHeading: log.
	
	marsRover process: 'l'.
	
	self assert: 1 equals: log size.
	self assert: 'Apuntando al Norte' equals: log first.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'GDH 6/7/2021 15:32:36'!
test06LogsHeadingWhenRotatingHeadingEast

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	log := MarsRoverLogger new.
	marsRover observeHeading: log.
	
	marsRover process: 'r'.
	
	self assert: 1 equals: log size.
	self assert: 'Apuntando al Este' equals: log first.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'GDH 6/7/2021 15:32:36'!
test07LogsHeadingWhenRotatingHeadingSouth

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #East.
	log := MarsRoverLogger new.
	marsRover observeHeading: log.
	
	marsRover process: 'r'.
	
	self assert: 1 equals: log size.
	self assert: 'Apuntando al Sur' equals: log first.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'GDH 6/7/2021 15:32:36'!
test08LogsHeadingWhenRotatingHeadingWest

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #South.
	log := MarsRoverLogger new.
	marsRover observeHeading: log.
	
	marsRover process: 'r'.
	
	self assert: 1 equals: log size.
	self assert: 'Apuntando al Oeste' equals: log first.! !


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


!classDefinition: #MarsRoverWindowLogTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverWindowLogTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindowLogTest methodsFor: 'tests' stamp: 'GDH 6/7/2021 15:32:11'!
test01WindowUpdatesPositionWhenMovingNorth

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	window := MarsRoverWindowLog new.
	marsRover observePosition: window.
	
	marsRover process: 'f'.

	self assert: 1@2 equals: window currentPosition.
	! !

!MarsRoverWindowLogTest methodsFor: 'tests' stamp: 'GDH 6/7/2021 15:32:11'!
test02WindowUpdatesPositionWhenMovingEast

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #West.
	window := MarsRoverWindowLog new.
	marsRover observePosition: window.
	
	marsRover process: 'b'.

	self assert: 2@1 equals: window currentPosition.
! !

!MarsRoverWindowLogTest methodsFor: 'tests' stamp: 'GDH 6/7/2021 15:32:11'!
test03WindowUpdatesPositionWhenMovingSouth

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	window := MarsRoverWindowLog new.
	marsRover observePosition: window.
	
	marsRover process: 'b'.

	self assert: 1@0 equals: window currentPosition.! !

!MarsRoverWindowLogTest methodsFor: 'tests' stamp: 'GDH 6/7/2021 15:32:11'!
test04WindowUpdatesPositionWhenMovingWest

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #East.
	window := MarsRoverWindowLog new.
	marsRover observePosition: window.
	
	marsRover process: 'b'.

	self assert: 0@1 equals: window currentPosition.! !

!MarsRoverWindowLogTest methodsFor: 'tests' stamp: 'GDH 6/7/2021 15:32:36'!
test05WindowUpdatesHeadingWhenRotatingHeadingNorth

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #West.
	window := MarsRoverWindowLog new.
	marsRover observeHeading: window.
	
	marsRover process: 'r'.
	
	self assert: 'Apuntando al Norte' equals: window currentHeading.! !

!MarsRoverWindowLogTest methodsFor: 'tests' stamp: 'GDH 6/7/2021 15:32:36'!
test06WindowUpdatesHeadingWhenRotatingHeadingEast

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	window := MarsRoverWindowLog new.
	marsRover observeHeading: window.
	
	marsRover process: 'r'.
	
	self assert: 'Apuntando al Este' equals: window currentHeading.! !

!MarsRoverWindowLogTest methodsFor: 'tests' stamp: 'GDH 6/7/2021 15:32:36'!
test07WindowUpdatesHeadingWhenRotatingHeadingSouth

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #East.
	window := MarsRoverWindowLog new.
	marsRover observeHeading: window.
	
	marsRover process: 'r'.
	
	self assert: 'Apuntando al Sur' equals: window currentHeading.! !

!MarsRoverWindowLogTest methodsFor: 'tests' stamp: 'GDH 6/7/2021 15:32:36'!
test08WindowUpdatesHeadingWhenRotatingHeadingWest

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #South.
	window := MarsRoverWindowLog new.
	marsRover observeHeading: window.
	
	marsRover process: 'r'.
	
	self assert: 'Apuntando al Oeste' equals: window currentHeading.! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head headingObservers positionObservers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'MS 6/6/2021 20:10:30'!
initializeAt: aPosition heading: aHeading

	position := aPosition.
	head := aHeading.
	
	headingObservers := OrderedCollection new.
	
	positionObservers := OrderedCollection new.! !


!MarsRover methodsFor: 'heading' stamp: 'MS 6/6/2021 20:14:02'!
headEast
	self headingChangedTo: MarsRoverHeadingEast new.
		! !

!MarsRover methodsFor: 'heading' stamp: 'MS 6/6/2021 20:14:16'!
headNorth
		self headingChangedTo: MarsRoverHeadingNorth new.

! !

!MarsRover methodsFor: 'heading' stamp: 'MS 6/6/2021 20:14:27'!
headSouth
		self headingChangedTo: MarsRoverHeadingSouth new.

	! !

!MarsRover methodsFor: 'heading' stamp: 'MS 6/6/2021 20:14:39'!
headWest
		self headingChangedTo: MarsRoverHeadingWest new.! !

!MarsRover methodsFor: 'heading' stamp: 'GDH 6/7/2021 15:37:14'!
headingChangedTo: newHeading
	head := newHeading.
	headingObservers do: [ :anObserver | head notifyObserver: anObserver ].
	! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:07:11'!
rotateLeft
	
	head rotateLeft: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:14:00'!
rotateRight
	
	head rotateRight: self! !


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


!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:20'!
moveBackward
	
	head moveBackward: self! !

!MarsRover methodsFor: 'moving' stamp: 'MS 6/6/2021 20:12:45'!
moveEast
	self positionChangedTo: position + (1@0).
	! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:55'!
moveForward
	
	head moveForward: self! !

!MarsRover methodsFor: 'moving' stamp: 'MS 6/6/2021 20:12:57'!
moveNorth
	self positionChangedTo: position + (0@1).
		! !

!MarsRover methodsFor: 'moving' stamp: 'MS 6/6/2021 20:13:14'!
moveSouth
		self positionChangedTo: position + (0@-1).
! !

!MarsRover methodsFor: 'moving' stamp: 'MS 6/6/2021 20:13:27'!
moveWest
	self positionChangedTo: position + (-1@0).
! !

!MarsRover methodsFor: 'moving' stamp: 'GDH 6/7/2021 15:38:52'!
positionChangedTo: newPosition
	position := newPosition.
	positionObservers do: [ :anObserver | anObserver notifyPositionChangedTo: position].
	! !


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


!MarsRover methodsFor: 'observation' stamp: 'GDH 6/7/2021 15:32:36'!
observeHeading: anObserver 

	headingObservers add: anObserver.
	! !

!MarsRover methodsFor: 'observation' stamp: 'GDH 6/7/2021 15:32:11'!
observePosition: anObserver

	positionObservers add: anObserver.! !

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


!MarsRoverHeading methodsFor: 'notifications' stamp: 'MS 6/6/2021 20:23:12'!
notifyObserver: anObserver
	
	^self subclassResponsibility.! !

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


!MarsRoverHeadingEast methodsFor: 'notifications' stamp: 'MS 6/6/2021 20:24:09'!
notifyObserver: anObserver

	anObserver notifyHeadingEast.! !

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


!MarsRoverHeadingNorth methodsFor: 'notifications' stamp: 'MS 6/6/2021 20:23:34'!
notifyObserver: anObserver

	anObserver notifyHeadingNorth.! !

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


!MarsRoverHeadingSouth methodsFor: 'notifications' stamp: 'MS 6/6/2021 20:24:20'!
notifyObserver: anObserver

	anObserver notifyHeadingSouth.! !

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


!MarsRoverHeadingWest methodsFor: 'notifications' stamp: 'MS 6/6/2021 20:24:28'!
notifyObserver: anObserver

	anObserver notifyHeadingWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingWest class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingWest class
	instanceVariableNames: ''!

!MarsRoverHeadingWest class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:23'!
cardinalPoint

	^#West! !


!classDefinition: #MarsRoverLogger category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverLogger
	instanceVariableNames: 'contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogger methodsFor: 'accessing' stamp: 'MS 6/4/2021 20:33:27'!
first

	^contents first.! !


!MarsRoverLogger methodsFor: 'position' stamp: 'GDH 6/7/2021 15:39:15'!
notifyPositionChangedTo: aPosition
	
	contents add: aPosition printString.! !


!MarsRoverLogger methodsFor: 'initialization' stamp: 'MS 6/4/2021 20:30:38'!
initialize

	contents := OrderedCollection new.! !


!MarsRoverLogger methodsFor: 'size' stamp: 'MS 6/4/2021 20:30:38'!
size

	^contents size.! !


!MarsRoverLogger methodsFor: 'heading' stamp: 'MS 6/6/2021 20:19:53'!
notifyHeadingEast

	contents add: 'Apuntando al Este'
	
	! !

!MarsRoverLogger methodsFor: 'heading' stamp: 'MS 6/6/2021 20:19:47'!
notifyHeadingNorth

	contents add: 'Apuntando al Norte'
	
	! !

!MarsRoverLogger methodsFor: 'heading' stamp: 'MS 6/6/2021 20:20:00'!
notifyHeadingSouth

	contents add: 'Apuntando al Sur'
	
	! !

!MarsRoverLogger methodsFor: 'heading' stamp: 'MS 6/6/2021 20:20:04'!
notifyHeadingWest

	contents add: 'Apuntando al Oeste'
	
	! !


!classDefinition: #MarsRoverWindowLog category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverWindowLog
	instanceVariableNames: 'position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindowLog methodsFor: 'position' stamp: 'GDH 6/7/2021 15:39:55'!
notifyPositionChangedTo: aPosition
	position := aPosition.! !


!MarsRoverWindowLog methodsFor: 'heading' stamp: 'MS 6/6/2021 20:26:29'!
notifyHeadingEast

	heading := 'Apuntando al Este'
	

	! !

!MarsRoverWindowLog methodsFor: 'heading' stamp: 'MS 6/6/2021 20:26:22'!
notifyHeadingNorth

	heading := 'Apuntando al Norte'
	

	! !

!MarsRoverWindowLog methodsFor: 'heading' stamp: 'MS 6/6/2021 20:26:35'!
notifyHeadingSouth

	heading := 'Apuntando al Sur'
	

	! !

!MarsRoverWindowLog methodsFor: 'heading' stamp: 'MS 6/6/2021 20:26:41'!
notifyHeadingWest

	heading := 'Apuntando al Oeste'
	

	! !


!MarsRoverWindowLog methodsFor: 'accessing' stamp: 'MS 6/6/2021 19:51:50'!
currentHeading
	^heading! !

!MarsRoverWindowLog methodsFor: 'accessing' stamp: 'MS 6/6/2021 19:29:30'!
currentPosition
	^position.! !
