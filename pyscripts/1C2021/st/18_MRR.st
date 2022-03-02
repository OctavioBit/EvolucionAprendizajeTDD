!classDefinition: #LogAndWindowTest category: 'MarsRover-WithHeading'!
TestCase subclass: #LogAndWindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!LogAndWindowTest methodsFor: 'as yet unclassified' stamp: 'JR 6/6/2021 17:19:26'!
test01MovingForwardWhenHeadingNorthAppearsInLog

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	log := MarsRoverLog new.
	marsRover addLogToPosition: log.
	
	marsRover process: 'f'.
	
	self assert: 1 equals: log size.
	self assert: '1@2' equals: log first.! !

!LogAndWindowTest methodsFor: 'as yet unclassified' stamp: 'JR 6/6/2021 17:19:32'!
test02MovingBackwardsWhenHeadingNorthAppearsInLog

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	log := MarsRoverLog new.
	marsRover addLogToPosition: log.
	
	marsRover process: 'b'.
	
	self assert: 1 equals: log size.
	self assert: '1@0' equals: log first.! !

!LogAndWindowTest methodsFor: 'as yet unclassified' stamp: 'JR 6/6/2021 17:19:38'!
test03MovingForwardWhenHeadingEastAppearsInLog

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #East.
	log := MarsRoverLog new.
	marsRover addLogToPosition: log.
	
	marsRover process: 'f'.
	
	self assert: 1 equals: log size.
	self assert: '2@1' equals: log first.! !

!LogAndWindowTest methodsFor: 'as yet unclassified' stamp: 'JR 6/6/2021 17:19:46'!
test04MovingBackwardsWhenHeadingEastAppearsInLog

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #East.
	log := MarsRoverLog new.
	marsRover addLogToPosition: log.
	
	marsRover process: 'b'.
	
	self assert: 1 equals: log size.
	self assert: '0@1' equals: log first.! !

!LogAndWindowTest methodsFor: 'as yet unclassified' stamp: 'JR 6/6/2021 17:19:51'!
test05RotatingLeftWhenHeadingNorthAppearsInLog

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	log := MarsRoverLog new.
	marsRover addLogToHeading: log.
	
	marsRover process: 'l'.
	
	self assert: 1 equals: log size.
	self assert: 'West' equals: log first.! !

!LogAndWindowTest methodsFor: 'as yet unclassified' stamp: 'JR 6/6/2021 17:19:57'!
test06RotatingLeftWhenHeadingWestAppearsInLog

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #West.
	log := MarsRoverLog new.
	marsRover addLogToHeading: log.
	
	marsRover process: 'l'.
	
	self assert: 1 equals: log size.
	self assert: 'South' equals: log first.! !

!LogAndWindowTest methodsFor: 'as yet unclassified' stamp: 'JR 6/6/2021 17:20:02'!
test07RotatingLeftWhenHeadingSouthAppearsInLog

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #South.
	log := MarsRoverLog new.
	marsRover addLogToHeading: log.
	
	marsRover process: 'l'.
	
	self assert: 1 equals: log size.
	self assert: 'East' equals: log first.! !

!LogAndWindowTest methodsFor: 'as yet unclassified' stamp: 'JR 6/6/2021 17:20:07'!
test08RotatingLeftWhenHeadingEastAppearsInLog

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #East.
	log := MarsRoverLog new.
	marsRover addLogToHeading: log.
	
	marsRover process: 'l'.
	
	self assert: 1 equals: log size.
	self assert: 'North' equals: log first.! !

!LogAndWindowTest methodsFor: 'as yet unclassified' stamp: 'JR 6/6/2021 17:34:42'!
test09MovingForwardWhenHeadingNorthAppearsInWindow

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	window := MarsRoverWindow new.
	marsRover addWindowToPosition: window. 
	
	marsRover process: 'f'.
	
	self assert: 1@2 equals: window positionTextFieldModel.! !

!LogAndWindowTest methodsFor: 'as yet unclassified' stamp: 'JR 6/6/2021 17:35:42'!
test10MovingBackwardsWhenHeadingNorthAppearsInWindow

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	window := MarsRoverWindow new.
	marsRover addWindowToPosition: window. 
	
	marsRover process: 'b'.
	
	self assert: 1@0 equals: window positionTextFieldModel.! !

!LogAndWindowTest methodsFor: 'as yet unclassified' stamp: 'JR 6/6/2021 17:37:01'!
test11MovingForwardWhenHeadingEastAppearsInWindow

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #East.
	window := MarsRoverWindow new.
	marsRover addWindowToPosition: window. 
	
	marsRover process: 'f'.
	
	self assert: 2@1 equals: window positionTextFieldModel.! !

!LogAndWindowTest methodsFor: 'as yet unclassified' stamp: 'JR 6/6/2021 17:37:34'!
test12MovingBackwardsWhenHeadingEastAppearsInWindow

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #East.
	window := MarsRoverWindow new.
	marsRover addWindowToPosition: window. 
	
	marsRover process: 'b'.
	
	self assert: 0@1 equals: window positionTextFieldModel.! !

!LogAndWindowTest methodsFor: 'as yet unclassified' stamp: 'JR 6/6/2021 17:41:18'!
test13RotatingLeftWhenHeadingNorthAppearsInWindow

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	window := MarsRoverWindow new.
	marsRover addWindowToHeading: window. 
	
	marsRover process: 'l'.
	
	self assert: 'West' equals: window headingTextFieldModel.! !

!LogAndWindowTest methodsFor: 'as yet unclassified' stamp: 'JR 6/6/2021 17:42:07'!
test14RotatingLeftWhenHeadingWestAppearsInWindow

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #West.
	window := MarsRoverWindow new.
	marsRover addWindowToHeading: window. 
	
	marsRover process: 'l'.
	
	self assert: 'South' equals: window headingTextFieldModel.! !

!LogAndWindowTest methodsFor: 'as yet unclassified' stamp: 'JR 6/6/2021 17:42:54'!
test15RotatingLeftWhenHeadingSouthAppearsInWindow

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #South.
	window := MarsRoverWindow new.
	marsRover addWindowToHeading: window. 
	
	marsRover process: 'l'.
	
	self assert: 'East' equals: window headingTextFieldModel.! !

!LogAndWindowTest methodsFor: 'as yet unclassified' stamp: 'JR 6/6/2021 17:43:39'!
test16RotatingLeftWhenHeadingEastAppearsInWindow

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #East.
	window := MarsRoverWindow new.
	marsRover addWindowToHeading: window. 
	
	marsRover process: 'l'.
	
	self assert: 'North' equals: window headingTextFieldModel.! !


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


!MarsRover methodsFor: 'initialization' stamp: 'JR 6/6/2021 18:02:38'!
initializeAt: aPosition heading: aHeading

	position := aPosition.
	head := aHeading.
	
	positionObservers := OrderedCollection new.
	headingObservers := OrderedCollection new.
	! !


!MarsRover methodsFor: 'heading' stamp: 'JR 6/6/2021 18:19:07'!
changeHeadingTo: aNewHeading

	head := aNewHeading .
	headingObservers do: [:anObserver | anObserver headingChangeTo: aNewHeading] 
	! !

!MarsRover methodsFor: 'heading' stamp: 'JR 6/6/2021 18:18:46'!
headEast
	
	self changeHeadingTo: MarsRoverHeadingEast new.
	! !

!MarsRover methodsFor: 'heading' stamp: 'JR 6/6/2021 18:18:10'!
headNorth
	
	self changeHeadingTo: MarsRoverHeadingNorth new.! !

!MarsRover methodsFor: 'heading' stamp: 'JR 6/6/2021 18:18:22'!
headSouth
	
	self changeHeadingTo:  MarsRoverHeadingSouth new.! !

!MarsRover methodsFor: 'heading' stamp: 'JR 6/6/2021 18:18:35'!
headWest
	
	self changeHeadingTo: MarsRoverHeadingWest new.! !

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


!MarsRover methodsFor: 'moving' stamp: 'JR 6/6/2021 17:58:30'!
changePositionTo: aNewPosition

	position := aNewPosition .
	positionObservers do: [:anObserver | anObserver positionChangeTo: position]! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:20'!
moveBackward
	
	head moveBackward: self! !

!MarsRover methodsFor: 'moving' stamp: 'JR 6/6/2021 17:53:13'!
moveEast
	
	self changePositionTo: position + (1@0).
	! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:55'!
moveForward
	
	head moveForward: self! !

!MarsRover methodsFor: 'moving' stamp: 'JR 6/6/2021 17:54:22'!
moveNorth
	
	self changePositionTo: position + (0@1). 
	! !

!MarsRover methodsFor: 'moving' stamp: 'JR 6/6/2021 17:54:28'!
moveSouth
	
	self changePositionTo: position + (0@-1).
	! !

!MarsRover methodsFor: 'moving' stamp: 'JR 6/6/2021 17:54:34'!
moveWest
	
	self changePositionTo: position + (-1@0).
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


!MarsRover methodsFor: 'window' stamp: 'JR 6/6/2021 18:02:59'!
addWindowToHeading: aWindow
	
	headingObservers add: aWindow.
	! !

!MarsRover methodsFor: 'window' stamp: 'JR 6/6/2021 18:01:05'!
addWindowToPosition: aWindow
	
	positionObservers add: aWindow.
	! !


!MarsRover methodsFor: 'log' stamp: 'JR 6/6/2021 18:02:48'!
addLogToHeading: aLog
	
	headingObservers add: aLog.
! !

!MarsRover methodsFor: 'log' stamp: 'JR 6/6/2021 18:01:30'!
addLogToPosition: aLog
	
	positionObservers add: aLog.
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


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'JR 6/6/2021 18:20:52'!
addToHeadingObserver: aHeadingObserver

	self subclassResponsibility ! !

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


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'JR 6/6/2021 18:22:33'!
addToHeadingObserver: aHeadingObserver

	aHeadingObserver addEast! !

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


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'JR 6/6/2021 18:22:20'!
addToHeadingObserver: aHeadingObserver

	aHeadingObserver addNorth! !

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


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'JR 6/6/2021 18:22:43'!
addToHeadingObserver: aHeadingObserver

	aHeadingObserver addSouth! !

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


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'JR 6/6/2021 18:22:52'!
addToHeadingObserver: aHeadingObserver

	aHeadingObserver addWest! !

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


!classDefinition: #MarsRoverLog category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverLog
	instanceVariableNames: 'contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLog methodsFor: 'initialization' stamp: 'JR 6/6/2021 17:18:39'!
initialize

	contents := OrderedCollection new! !


!MarsRoverLog methodsFor: 'accessing' stamp: 'JR 6/6/2021 17:19:15'!
first

	^contents first! !

!MarsRoverLog methodsFor: 'accessing' stamp: 'JR 6/6/2021 18:41:50'!
showLog

	^contents! !

!MarsRoverLog methodsFor: 'accessing' stamp: 'JR 6/6/2021 17:19:08'!
size

	^contents size! !


!MarsRoverLog methodsFor: 'position' stamp: 'JR 6/6/2021 17:58:55'!
positionChangeTo: aPosition

	contents add: aPosition printString! !


!MarsRoverLog methodsFor: 'heading' stamp: 'JR 6/6/2021 18:23:51'!
addEast
	
	contents add: 'East'
! !

!MarsRoverLog methodsFor: 'heading' stamp: 'JR 6/6/2021 18:23:35'!
addNorth
	
	contents add: 'North'
! !

!MarsRoverLog methodsFor: 'heading' stamp: 'JR 6/6/2021 18:23:44'!
addSouth
	
	contents add: 'South'
! !

!MarsRoverLog methodsFor: 'heading' stamp: 'JR 6/6/2021 18:23:58'!
addWest
	
	contents add: 'West'
! !

!MarsRoverLog methodsFor: 'heading' stamp: 'JR 6/6/2021 18:20:00'!
headingChangeTo: aHeading

	aHeading addToHeadingObserver: self! !


!classDefinition: #MarsRoverWindow category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverWindow
	instanceVariableNames: 'positionTextFieldModel headingTextFieldModel'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindow methodsFor: 'position' stamp: 'JR 6/6/2021 17:34:06'!
positionChangeTo: aPosition
	
	positionTextFieldModel := aPosition ! !

!MarsRoverWindow methodsFor: 'position' stamp: 'JR 6/6/2021 17:34:24'!
positionTextFieldModel
	
	^positionTextFieldModel! !


!MarsRoverWindow methodsFor: 'heading' stamp: 'JR 6/6/2021 18:24:20'!
addEast
	
	headingTextFieldModel := 'East'! !

!MarsRoverWindow methodsFor: 'heading' stamp: 'JR 6/6/2021 18:24:36'!
addNorth
	
	headingTextFieldModel := 'North'! !

!MarsRoverWindow methodsFor: 'heading' stamp: 'JR 6/6/2021 18:24:29'!
addSouth
	
	headingTextFieldModel := 'South'! !

!MarsRoverWindow methodsFor: 'heading' stamp: 'JR 6/6/2021 18:24:15'!
addWest
	
	headingTextFieldModel := 'West'! !

!MarsRoverWindow methodsFor: 'heading' stamp: 'JR 6/6/2021 18:20:12'!
headingChangeTo: aHeading
	
	aHeading addToHeadingObserver: self! !

!MarsRoverWindow methodsFor: 'heading' stamp: 'JR 6/6/2021 17:40:55'!
headingTextFieldModel
	
	^headingTextFieldModel! !
