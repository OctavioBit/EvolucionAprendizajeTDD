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


!classDefinition: #ObserversTest category: 'MarsRover-WithHeading'!
TestCase subclass: #ObserversTest
	instanceVariableNames: 'currentPositionMR directionMR'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!ObserversTest methodsFor: 'tests direction' stamp: 'LEC 6/6/2021 19:34:37'!
test03logManyRotationLeftChanges

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	log := Log new.
	marsRover addObserverDirections: log.
	marsRover process: 'll'.
	
	self assert: 'West' equals: log currentDirectionLogs first.
	self assert: 'South' equals: log currentDirectionLogs second.
	self assert: log currentDirectionLogs size equals: 2.
	! !

!ObserversTest methodsFor: 'tests direction' stamp: 'LEC 6/6/2021 19:35:00'!
test04LogManyRotationRightChanges

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #West.
	log := Log new.
	marsRover addObserverDirections: log.
	marsRover process: 'rr'.
	
	self assert: 'North' equals: log currentDirectionLogs first.
	self assert: 'East' equals: log currentDirectionLogs second.
	self assert: log currentDirectionLogs size equals: 2.
	! !

!ObserversTest methodsFor: 'tests direction' stamp: 'LEC 6/6/2021 19:35:56'!
test06windowRotateUpdate
	
	| marsRover window|
	
	marsRover := MarsRover at: 1@1 heading: #North.
	window := MarsRoverWindow new.
	marsRover addObserverDirections: window.
	
	marsRover process: 'r'.
	
	self assert: 'East' equals: window directionTextFieldModel.
	
	! !


!ObserversTest methodsFor: 'test position' stamp: 'LEC 6/6/2021 19:33:01'!
test01logOnePositionChange

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	log := Log new.
	marsRover addObserverPosition: log.
	marsRover process: 'f'.
	
	
	self assert: 1@2 equals: log currentPositionLogs first.
	self assert: log currentPositionLogs size equals: 1.! !

!ObserversTest methodsFor: 'test position' stamp: 'LEC 6/6/2021 19:33:33'!
test02logWithManyPositionsChanges

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	log := Log new.
	marsRover  addObserverPosition: log.
	marsRover process: 'ffb'.
	
	
	self assert: 1@2 equals: log currentPositionLogs first.
	self assert: 1@3 equals: log currentPositionLogs second.
	self assert: 1@2 equals: log currentPositionLogs third.
	self assert: log currentPositionLogs size equals: 3.
	! !

!ObserversTest methodsFor: 'test position' stamp: 'LEC 6/6/2021 19:32:22'!
test05windowUpdatePosition
	
	| marsRover window|
	
	marsRover := MarsRover at: 1@1 heading: #North.
	window := MarsRoverWindow new.
	marsRover addObserverPosition: window.
	
	marsRover process: 'f'.
	
	self assert: 1@2 equals: window positionTextFieldModel.
	
	! !


!classDefinition: #Command category: 'MarsRover-WithHeading'!
Object subclass: #Command
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Command methodsFor: 'mars rover actions' stamp: 'LEC 6/6/2021 19:18:13'!
actionFor: aMarsRover

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Command class' category: 'MarsRover-WithHeading'!
Command class
	instanceVariableNames: ''!

!Command class methodsFor: 'instance creation' stamp: 'LEC 6/6/2021 16:20:51'!
for: aCommand

	^self subclasses 
		detect: [ :aCommandClass | aCommandClass canHandle: aCommand ]
		ifFound: [ :aCommandClass | aCommandClass new ]
		ifNone: [ self error: MarsRover invalidCommandErrorDescription ]! !


!Command class methodsFor: 'can handle' stamp: 'LEC 6/6/2021 16:21:40'!
canHandle: aCommand

	self subclassResponsibility ! !


!classDefinition: #BackwardCommand category: 'MarsRover-WithHeading'!
Command subclass: #BackwardCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!BackwardCommand methodsFor: 'mars rover actions' stamp: 'LEC 6/6/2021 16:24:50'!
actionFor: marsRover

	marsRover moveBackward ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BackwardCommand class' category: 'MarsRover-WithHeading'!
BackwardCommand class
	instanceVariableNames: ''!

!BackwardCommand class methodsFor: 'can handle' stamp: 'LEC 6/6/2021 16:22:02'!
canHandle: aCommand

	^$b = aCommand! !


!classDefinition: #ForwardCommand category: 'MarsRover-WithHeading'!
Command subclass: #ForwardCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!ForwardCommand methodsFor: 'mars rover actions' stamp: 'LEC 6/6/2021 16:25:28'!
actionFor: marsRover

	marsRover moveForward! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ForwardCommand class' category: 'MarsRover-WithHeading'!
ForwardCommand class
	instanceVariableNames: ''!

!ForwardCommand class methodsFor: 'can handle' stamp: 'LEC 6/6/2021 16:22:11'!
canHandle: aCommand

	^$f = aCommand! !


!classDefinition: #LeftCommand category: 'MarsRover-WithHeading'!
Command subclass: #LeftCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!LeftCommand methodsFor: 'mars rover actions' stamp: 'LEC 6/6/2021 16:26:31'!
actionFor: marsRover

	marsRover rotateLeft! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LeftCommand class' category: 'MarsRover-WithHeading'!
LeftCommand class
	instanceVariableNames: ''!

!LeftCommand class methodsFor: 'can handle' stamp: 'LEC 6/6/2021 16:22:20'!
canHandle: aCommand

	^$l = aCommand! !


!classDefinition: #RightCommand category: 'MarsRover-WithHeading'!
Command subclass: #RightCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!RightCommand methodsFor: 'mars rover actions' stamp: 'LEC 6/6/2021 16:28:51'!
actionFor: marsRover

	marsRover rotateRight! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RightCommand class' category: 'MarsRover-WithHeading'!
RightCommand class
	instanceVariableNames: ''!

!RightCommand class methodsFor: 'can handle' stamp: 'LEC 6/6/2021 16:22:28'!
canHandle: aCommand

	^$r = aCommand! !


!classDefinition: #Log category: 'MarsRover-WithHeading'!
Object subclass: #Log
	instanceVariableNames: 'directionLogs positionLogs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Log methodsFor: 'testing' stamp: 'LEC 6/6/2021 19:09:10'!
currentDirectionLogs
	
	^directionLogs ! !

!Log methodsFor: 'testing' stamp: 'LEC 6/6/2021 19:08:44'!
currentPositionLogs
	
	^positionLogs ! !


!Log methodsFor: 'initialization' stamp: 'LEC 6/6/2021 16:00:03'!
initialize

	directionLogs := OrderedCollection new.
	positionLogs := OrderedCollection new.! !


!Log methodsFor: 'updating' stamp: 'LEC 6/6/2021 19:07:05'!
directionChangedTo: aLog

	directionLogs add: aLog! !

!Log methodsFor: 'updating' stamp: 'LEC 6/6/2021 18:46:47'!
positionChangedTo: aLog

	positionLogs add: aLog! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head observerPositions observerDirections'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'LEC 6/6/2021 19:06:05'!
initializeAt: aPosition heading: aHeading

	position := aPosition.
	head := aHeading .
	observerPositions := OrderedCollection new.
	observerDirections := OrderedCollection new.! !


!MarsRover methodsFor: 'heading' stamp: 'LEC 6/6/2021 18:24:51'!
headEast
	
	head := self stateHeading:#East.! !

!MarsRover methodsFor: 'heading' stamp: 'LEC 6/6/2021 18:25:14'!
headNorth
	
	head := self stateHeading:#North.
	! !

!MarsRover methodsFor: 'heading' stamp: 'LEC 6/6/2021 18:25:37'!
headSouth
	
	head := self stateHeading:#South.! !

!MarsRover methodsFor: 'heading' stamp: 'LEC 6/6/2021 18:25:47'!
headWest
	
	head := self stateHeading:#West.! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:07:11'!
rotateLeft
	
	head rotateLeft: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:14:00'!
rotateRight
	
	head rotateRight: self! !

!MarsRover methodsFor: 'heading' stamp: 'LEC 6/6/2021 19:04:19'!
stateHeading: cardinalPoint

	observerDirections do:[:anObserver| anObserver directionChangedTo: cardinalPoint asString].
	^MarsRoverHeading heading: cardinalPoint! !


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


!MarsRover methodsFor: 'moving' stamp: 'LEC 6/6/2021 19:03:45'!
changePositionTo: aPosition

	position := aPosition .
	observerPositions do:[:anObserver| anObserver positionChangedTo: aPosition].
	
	
	! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:20'!
moveBackward
	
	head moveBackward: self! !

!MarsRover methodsFor: 'moving' stamp: 'LEC 6/6/2021 18:05:58'!
moveEast
	
	self changePositionTo: position + (1@0).
	! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:55'!
moveForward
	
	head moveForward: self! !

!MarsRover methodsFor: 'moving' stamp: 'LEC 6/6/2021 18:05:04'!
moveNorth
	
	self changePositionTo: position + (0@1).
	! !

!MarsRover methodsFor: 'moving' stamp: 'LEC 6/6/2021 18:06:19'!
moveSouth
	
	self changePositionTo: position + (0@-1).
	! !

!MarsRover methodsFor: 'moving' stamp: 'LEC 6/6/2021 18:06:31'!
moveWest
	
	self changePositionTo: position + (-1@0).
	! !


!MarsRover methodsFor: 'command processing' stamp: 'LEC 6/6/2021 19:05:35'!
addObserverDirections: anObserver

	observerDirections add: anObserver 

	

! !

!MarsRover methodsFor: 'command processing' stamp: 'LEC 6/6/2021 19:05:18'!
addObserverPosition: anObserver

	observerPositions add: anObserver 

	

! !

!MarsRover methodsFor: 'command processing' stamp: 'LEC 6/6/2021 16:24:11'!
applyCommand: aCommand

	aCommand actionFor: self
	! !

!MarsRover methodsFor: 'command processing' stamp: 'LEC 6/3/2021 20:32:13'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand].
	
! !

!MarsRover methodsFor: 'command processing' stamp: 'LEC 6/6/2021 19:17:21'!
processCommand: aCommand

	self applyCommand: (Command for: aCommand)
	! !

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

!MarsRover class methodsFor: 'instance creation' stamp: 'LEC 6/6/2021 16:21:09'!
invalidCommandErrorDescription
	
	^'Invalid command'! !


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

!MarsRoverHeadingEast class methodsFor: 'cardinal point' stamp: 'HAW 7/2/2018 17:01:53'!
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

!MarsRoverHeadingNorth class methodsFor: 'cardinal point' stamp: 'HAW 7/2/2018 17:03:11'!
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

!MarsRoverHeadingSouth class methodsFor: 'cardinal point' stamp: 'HAW 7/2/2018 17:03:17'!
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

!MarsRoverHeadingWest class methodsFor: 'cardinal point' stamp: 'HAW 7/2/2018 17:03:23'!
cardinalPoint

	^#West! !


!classDefinition: #MarsRoverWindow category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverWindow
	instanceVariableNames: 'directionMR currentPositionMR'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindow methodsFor: 'debugging' stamp: 'LEC 6/6/2021 19:25:20'!
directionChangedTo: aDirection 
	
	directionMR := aDirection! !

!MarsRoverWindow methodsFor: 'debugging' stamp: 'LEC 6/6/2021 19:25:42'!
directionTextFieldModel
	
	^directionMR! !

!MarsRoverWindow methodsFor: 'debugging' stamp: 'LEC 6/6/2021 19:26:00'!
positionChangedTo: aPoint 
	
	
	currentPositionMR := aPoint ! !

!MarsRoverWindow methodsFor: 'debugging' stamp: 'LEC 6/6/2021 19:26:24'!
positionTextFieldModel
	
	^currentPositionMR ! !
