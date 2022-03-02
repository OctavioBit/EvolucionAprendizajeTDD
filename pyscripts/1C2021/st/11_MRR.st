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


!classDefinition: #OLogsTests category: 'MarsRover-WithHeading'!
TestCase subclass: #OLogsTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!OLogsTests methodsFor: 'test' stamp: 'ERMC 6/5/2021 23:58:18'!
test01WhenMarsRoverMoveForwardLogsPositionChange
	
	| log marsRover |
	marsRover _ MarsRover at: 1@1 heading: #North.
	log _ Log new.
	
	marsRover addLogToPosition: log.
	
	marsRover process: 'f'.
	
	self assert: 1 equals: log size.
	self assert: '1@2' equals: log logs first.  ! !

!OLogsTests methodsFor: 'test' stamp: 'ERMC 6/5/2021 20:34:43'!
test02WhenMarsRoverMoveBackwardLogsPositionChange
	
	| log marsRover |
	marsRover _ MarsRover at: 1@1 heading: #North.
	log _ Log new.
	
	marsRover addLogToPosition: log.
	
	marsRover process: 'b'.
	
	self assert: 1 equals: log size.
	self assert: '1@0' equals: log logs first.  ! !

!OLogsTests methodsFor: 'test' stamp: 'ERMC 6/5/2021 20:35:38'!
test03WhenMarsRoverRotateRightLogsHeadingChange
	
	| log marsRover |
	marsRover _ MarsRover at: 1@1 heading: #North.
	log _ Log new.
	
	marsRover addLogToHeading: log.
	
	marsRover process: 'r'.
	
	self assert: 1 equals: log size.
	self assert: 'Apuntando al Este' equals: log logs first.  ! !

!OLogsTests methodsFor: 'test' stamp: 'ERMC 6/5/2021 20:35:59'!
test04WhenMarsRoverRotateLeftLogsHeadingChange
	
	| log marsRover |
	marsRover _ MarsRover at: 1@1 heading: #North.
	log _ Log new.
	
	marsRover addLogToHeading: log.
	
	marsRover process: 'l'.
	
	self assert: 1 equals: log size.
	self assert: 'Apuntando al Oeste' equals: log logs first.  ! !

!OLogsTests methodsFor: 'test' stamp: 'ERMC 6/6/2021 00:09:36'!
test05WindowLogsPositionChange
	
	| marsRover window |
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	window _ MarsRoverStateWindow new.
	marsRover addWindowToPosition: window.
	
	marsRover process: 'f'.
	
	self assert: 1@2 equals: window position.! !

!OLogsTests methodsFor: 'test' stamp: 'ERMC 6/6/2021 00:11:09'!
test06WindowLogsPositionChangeBackward
	
	| marsRover window |
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	window _ MarsRoverStateWindow new.
	marsRover addWindowToPosition: window.
	
	marsRover process: 'b'.
	
	self assert: 1@0 equals: window position.! !

!OLogsTests methodsFor: 'test' stamp: 'ERMC 6/6/2021 00:30:44'!
test07WindowLogsHeadingChangeRotateRight
	
	| marsRover window |
	marsRover _ MarsRover at: 1@1 heading: #East.
	
	window _ MarsRoverStateWindow new.
	marsRover addWindowToHeading: window.
	
	marsRover process: 'r'.
	
	self assert: 'Apuntando al Sur' equals: window heading.! !

!OLogsTests methodsFor: 'test' stamp: 'ERMC 6/6/2021 00:30:17'!
test08WindowLogsHeadingChangeRotateLeft
	
	| marsRover window |
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	window _ MarsRoverStateWindow new.
	marsRover addWindowToHeading: window.
	
	marsRover process: 'l'.
	
	self assert: 'Apuntando al Oeste' equals: window heading.! !

!OLogsTests methodsFor: 'test' stamp: 'ERMC 6/6/2021 17:56:45'!
test09LogPositionChangeWhenIsHeadingEastAndWindow
	
	| marsRover window log |
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	window _ MarsRoverStateWindow new.
	log _ Log new.
	
	marsRover addLogToPosition: log.
	marsRover addWindowToHeading: window.
	
	marsRover process: 'rf'.
	
	
	self assert: 1 equals: log size.
	self assert: '2@1' equals: log first. 
	self assert: 'Apuntando al Este' equals: window heading.! !

!OLogsTests methodsFor: 'test' stamp: 'ERMC 6/6/2021 18:13:07'!
test10LogPositionChangeWhenIsHeadingWestAndWindow
	
	| marsRover window log |
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	window _ MarsRoverStateWindow new.
	log _ Log new.
	
	marsRover addLogToPosition: log.
	marsRover addWindowToHeading: window.
	
	marsRover process: 'lf'.
	
	
	self assert: 1 equals: log size.
	self assert: '0@1' equals: log first. 
	self assert: 'Apuntando al Oeste' equals: window heading.! !

!OLogsTests methodsFor: 'test' stamp: 'sgs 6/7/2021 12:46:16'!
test11LogPositionChangeWhenIsHeadingWestRepeatedlyAndWindow
	
	| marsRover window log |
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	window _ MarsRoverStateWindow new.
	log _ Log new.
	
	marsRover addLogToPosition: log.
	marsRover addWindowToHeading: window.
	
	marsRover process: 'frfrfrf'.
	
	self assert: 4 equals: log size.
	self assert: (log has: '1@2' at: 1).
	self assert: (log has: '2@2' at: 2). 
	self assert: (log has: '2@1' at: 3).
	self assert: (log has: '1@1' at: 4).
	self assert: 'Apuntando al Oeste' equals: window heading.! !

!OLogsTests methodsFor: 'test' stamp: 'sgs 6/7/2021 13:56:32'!
test12LogPositionWhenChangeMarsRoverMoveForwardAndWindow
	
	| marsRover window log |
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	window _ MarsRoverStateWindow new.
	log _ Log new.
	
	marsRover addLogToPosition: log.
	marsRover addWindowToPosition: window.
	
	marsRover process: 'f'.
	
	self assert: '1@2' equals: log logs first. 
	self assert: 1@2 equals: window position.
	! !

!OLogsTests methodsFor: 'test' stamp: 'sgs 6/7/2021 13:57:01'!
test13LogPositionWhenChangeMarsRoverMoveBackwardAndWindow
	
	| marsRover window log |
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	window _ MarsRoverStateWindow new.
	log _ Log new.
	
	marsRover addLogToPosition: log.
	marsRover addWindowToPosition: window.
	
	marsRover process: 'b'.
	
	self assert: '1@0' equals: log logs first. 
	self assert: 1@0 equals: window position.
	! !

!OLogsTests methodsFor: 'test' stamp: 'sgs 6/7/2021 14:23:31'!
test14LogPositionAndHeadingWhenChangeMarsRoverMoveBackward
	
	| marsRover  log |
	marsRover _ MarsRover at: 1@1 heading: #North.
	log _ Log new.
	
	marsRover addLogToPosition: log.
	marsRover addLogToHeading: log.
	
	marsRover process: 'br'.
	
	self assert: 2 equals: log size.
	self assert: '1@0' equals: log logs first. 
	self assert: 'Apuntando al Este' equals: log logs second .  ! !

!OLogsTests methodsFor: 'test' stamp: 'sgs 6/7/2021 14:25:31'!
test14LogPositionAndHeadingWhenChangeMarsRoverMoveBackwardAndHeadingEast

	| marsRover  log |
	marsRover _ MarsRover at: 1@1 heading: #North.
	log _ Log new.
	
	marsRover addLogToPosition: log.
	marsRover addLogToHeading: log.
	
	marsRover process: 'br'.
	
	self assert: 2 equals: log size.
	self assert: '1@0' equals: log logs first. 
	self assert: 'Apuntando al Este' equals: log logs second .  ! !

!OLogsTests methodsFor: 'test' stamp: 'sgs 6/7/2021 14:24:59'!
test15LogPositionAndHeadingWhenChangeMarsRoverMoveForwardAndHeadingWest
	
	| marsRover  log |
	marsRover _ MarsRover at: 1@1 heading: #North.
	log _ Log new.
	
	marsRover addLogToPosition: log.
	marsRover addLogToHeading: log.
	
	marsRover process: 'fl'.
	
	self assert: 2 equals: log size.
	self assert: '1@2' equals: log logs first. 
	self assert: 'Apuntando al Oeste' equals: log logs second .  ! !


!classDefinition: #Log category: 'MarsRover-WithHeading'!
Object subclass: #Log
	instanceVariableNames: 'logs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Log methodsFor: 'heading' stamp: 'ERMC 6/5/2021 20:30:49'!
headingChangedTo: aMarsRoverHeading
	
	logs add: 'Apuntando al ', aMarsRoverHeading printHead.! !


!Log methodsFor: 'position' stamp: 'ERMC 6/5/2021 18:13:55'!
positionChangeTo: aPosition

	logs add: aPosition printString.
	! !


!Log methodsFor: 'log' stamp: 'ERMC 6/3/2021 20:37:10'!
logger: aPoint 
	
	logs add: aPoint! !

!Log methodsFor: 'log' stamp: 'ERMC 6/3/2021 20:41:58'!
logs 
	
	^logs! !


!Log methodsFor: 'initialization' stamp: 'ERMC 6/3/2021 20:38:09'!
initialize
	
	logs _ OrderedCollection new.! !


!Log methodsFor: 'testing' stamp: 'ERMC 6/6/2021 18:14:29'!
at: anIndex
	
	^logs at: anIndex.! !

!Log methodsFor: 'testing' stamp: 'ERMC 6/6/2021 16:38:52'!
first
	
	^logs first! !

!Log methodsFor: 'testing' stamp: 'ERMC 6/6/2021 18:17:29'!
has: aString at: anIndex
 
	^aString = (logs at: anIndex) ! !

!Log methodsFor: 'testing' stamp: 'ERMC 6/3/2021 20:39:56'!
size
	
	^logs size! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head positionObservers headingObservers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'ERMC 6/6/2021 17:31:47'!
initializeAt: aPosition heading: aHeading

	position := aPosition.
	head := aHeading.
	
	positionObservers _ OrderedCollection new.
	headingObservers _ OrderedCollection new.! !


!MarsRover methodsFor: 'heading' stamp: 'ERMC 6/6/2021 17:37:39'!
changeHeadTo: newHeading

	head _ newHeading.
	
	headingObservers do: [:aLog | aLog headingChangedTo: head]
 ! !

!MarsRover methodsFor: 'heading' stamp: 'ERMC 6/6/2021 17:23:42'!
headEast
	
	self changeHeadTo: MarsRoverHeadingEast new.

! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:16:30'!
headNorth
	
	head := MarsRoverHeadingNorth new! !

!MarsRover methodsFor: 'heading' stamp: 'ERMC 6/6/2021 00:38:55'!
headSouth
	
	 self changeHeadTo: MarsRoverHeadingSouth new.

	! !

!MarsRover methodsFor: 'heading' stamp: 'ERMC 6/6/2021 00:37:48'!
headWest
	
	self changeHeadTo: MarsRoverHeadingWest new.
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


!MarsRover methodsFor: 'moving' stamp: 'ERMC 6/6/2021 17:20:26'!
changePositionTo: newPosition

	position  _ newPosition.
	
	positionObservers do: [:aLog | aLog positionChangeTo: position]! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:20'!
moveBackward
	
	head moveBackward: self! !

!MarsRover methodsFor: 'moving' stamp: 'ERMC 6/6/2021 17:19:28'!
moveEast
	
	self changePositionTo: position + (1@0).! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:55'!
moveForward
	
	head moveForward: self! !

!MarsRover methodsFor: 'moving' stamp: 'ERMC 6/6/2021 00:34:49'!
moveNorth
	
	self changePositionTo: position + (0@1).
! !

!MarsRover methodsFor: 'moving' stamp: 'ERMC 6/6/2021 00:36:33'!
moveSouth
	
	self changePositionTo: position + (0@-1).! !

!MarsRover methodsFor: 'moving' stamp: 'ERMC 6/6/2021 17:19:44'!
moveWest
	
	self changePositionTo: position + (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'ERMC 6/5/2021 18:11:47'!
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


!MarsRover methodsFor: 'as yet unclassified' stamp: 'ERMC 6/6/2021 17:35:10'!
addLogToHeading: aLog 
	
	headingObservers add: aLog! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ERMC 6/6/2021 17:33:53'!
addLogToPosition: aLog 
	
	positionObservers add: aLog! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ERMC 6/6/2021 17:35:04'!
addWindowToHeading: aMarsRoverStateWindow 
	
	headingObservers add: aMarsRoverStateWindow ! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ERMC 6/6/2021 17:33:07'!
addWindowToPosition: aMarsRoverStateWindow 
	
	positionObservers add: aMarsRoverStateWindow ! !

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


!MarsRoverHeadingEast methodsFor: 'as yet unclassified' stamp: 'ERMC 6/5/2021 20:31:56'!
printHead
	
	^'Este'! !

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


!MarsRoverHeadingSouth methodsFor: 'as yet unclassified' stamp: 'ERMC 6/5/2021 20:32:48'!
printHead
	
	^'Sur'.! !

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


!MarsRoverHeadingWest methodsFor: 'as yet unclassified' stamp: 'ERMC 6/5/2021 20:32:28'!
printHead
	
	^'Oeste'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingWest class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingWest class
	instanceVariableNames: ''!

!MarsRoverHeadingWest class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:23'!
cardinalPoint

	^#West! !


!classDefinition: #MarsRoverStateWindow category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverStateWindow
	instanceVariableNames: 'position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverStateWindow methodsFor: 'position' stamp: 'ERMC 6/5/2021 21:14:56'!
position
	
	^position ! !

!MarsRoverStateWindow methodsFor: 'position' stamp: 'ERMC 6/5/2021 21:16:32'!
positionChangeTo: aPoint 

	position  _ aPoint ! !


!MarsRoverStateWindow methodsFor: 'heading' stamp: 'ERMC 6/6/2021 00:25:35'!
heading

	^heading ! !

!MarsRoverStateWindow methodsFor: 'heading' stamp: 'ERMC 6/6/2021 00:21:50'!
headingChangedTo: aMarsRoverHeading 
	
	heading _ 'Apuntando al ', aMarsRoverHeading printHead.! !
