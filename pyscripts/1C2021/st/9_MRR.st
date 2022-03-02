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


!classDefinition: #MarsRoverTrackStatusTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTrackStatusTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTrackStatusTest methodsFor: 'tests' stamp: 'TPL 6/7/2021 15:37:49'!
test01FrontBackEastWestLogStatus
	| log marsRover |
	marsRover:= MarsRover at: 1@1 heading: #East.
	log := Log new.
	marsRover addObserverToPosition: log.
	
	marsRover process: 'f'.
	
	self assert: 1 equals: log size.
	self assert: '2@1' equals: log first.
	
	marsRover process: 'b'.
	
	self assert: 2 equals: log size.
	self assert: '1@1' equals: log last.! !

!MarsRoverTrackStatusTest methodsFor: 'tests' stamp: 'TPL 6/7/2021 15:42:33'!
test02FrontBackNorthSouthLogStatus
	| log marsRover |
	marsRover:= MarsRover at: 1@1 heading: #North.
	log := Log new.
	marsRover addObserverToPosition: log.
	
	marsRover process: 'f'.
	
	self assert: 1 equals: log size.
	self assert: '1@2' equals: log first.
	
	marsRover process: 'b'.
	
	self assert: 2 equals: log size.
	self assert: '1@1' equals: log last.! !

!MarsRoverTrackStatusTest methodsFor: 'tests' stamp: 'TPL 6/7/2021 15:37:49'!
test03FrontBackWindowStatus
	| window marsRover |
	marsRover:= MarsRover at: 1@1 heading: #North.
	window := MarsRoverStateWindow new.
	marsRover addObserverToPosition: window.
	
	marsRover process: 'f'.
	
	self assert: 1@2 equals: window positionTextFieldModel.
	
	marsRover process: 'b'.
	
	self assert: 1@1 equals: window positionTextFieldModel.! !

!MarsRoverTrackStatusTest methodsFor: 'tests' stamp: 'TPL 6/7/2021 15:42:54'!
test04RightLeftLogStatus
	| log marsRover |
	marsRover:= MarsRover at: 1@1 heading: #North.
	log := Log new.
	marsRover addObserverToHeading: log.
	
	marsRover process: 'r'.
	
	self assert: 1 equals: log size.
	self assert: 'Apuntando al Este' equals: log first.
	
	marsRover process: 'r'.
	
	self assert: 2 equals: log size.
	self assert: 'Apuntando al Sur' equals: log last.
	
	marsRover process: 'r'.
	
	self assert: 3 equals: log size.
	self assert: 'Apuntando al Oeste' equals: log last.
	
	marsRover process: 'r'.
	
	self assert: 4 equals: log size.
	self assert: 'Apuntando al Norte' equals: log last.
	
	marsRover process: 'l'.
	
	self assert: 5 equals: log size.
	self assert: 'Apuntando al Oeste' equals: log last.
	
	marsRover process: 'l'.
	
	self assert: 6 equals: log size.
	self assert: 'Apuntando al Sur' equals: log last.
	
	marsRover process: 'l'.
	
	self assert: 7 equals: log size.
	self assert: 'Apuntando al Este' equals: log last.
	
	marsRover process: 'l'.
	
	self assert: 8 equals: log size.
	self assert: 'Apuntando al Norte' equals: log last.! !

!MarsRoverTrackStatusTest methodsFor: 'tests' stamp: 'TPL 6/7/2021 15:37:49'!
test05FrontBackUpdateLogAndWindowStatusAtSameTime
	| log marsRover window |
	marsRover:= MarsRover at: 1@1 heading: #North.
	log := Log new.
	window := MarsRoverStateWindow new.
	marsRover addObserverToPosition: log.
	marsRover addObserverToPosition: window.
	
	marsRover process: 'b'.
	
	self assert: 1 equals: log size.
	self assert: '1@0' equals: log first.
	self assert: 1@0 equals: window positionTextFieldModel .
	
	marsRover process: 'f'.
	
	self assert: 2 equals: log size.
	self assert: '1@1' equals: log last.
	self assert: 1@1 equals: window positionTextFieldModel .
	
	
	
	! !

!MarsRoverTrackStatusTest methodsFor: 'tests' stamp: 'TPL 6/7/2021 15:39:09'!
test06RightLeftUpdateLogAndWindowStatusAtSameTime
	| log marsRover window|
	marsRover:= MarsRover at: 1@1 heading: #North.
	log := Log new.
	window := MarsRoverStateWindow new.
	marsRover addObserverToHeading: log.
	marsRover addObserverToHeading: window.
	
	marsRover process: 'l'.
	
	self assert: 1 equals: log size.
	self assert: 'Apuntando al Oeste' equals: log last.
	self assert: 'Oeste' equals: window headingTextFieldModel .
	
	marsRover process: 'l'.
	
	self assert: 2 equals: log size.
	self assert: 'Apuntando al Sur' equals: log last.
	self assert: 'Sur' equals: window headingTextFieldModel .
	
	marsRover process: 'l'.
	
	self assert: 3 equals: log size.
	self assert: 'Apuntando al Este' equals: log last.
	self assert: 'Este' equals: window headingTextFieldModel .
	
	marsRover process: 'l'.
	
	self assert: 4 equals: log size.
	self assert: 'Apuntando al Norte' equals: log last.
	self assert: 'Norte' equals: window headingTextFieldModel .
	
	marsRover process: 'r'.
	
	self assert: 5 equals: log size.
	self assert: 'Apuntando al Este' equals: log last.
	self assert: 'Este' equals: window headingTextFieldModel .

	marsRover process: 'r'.
	
	self assert: 6 equals: log size.
	self assert: 'Apuntando al Sur' equals: log last.
	self assert: 'Sur' equals: window headingTextFieldModel .	
	
	marsRover process: 'r'.
	
	self assert: 7 equals: log size.
	self assert: 'Apuntando al Oeste' equals: log last.
	self assert: 'Oeste' equals: window headingTextFieldModel .	
	
	marsRover process: 'r'.

	self assert: 8 equals: log size.
	self assert: 'Apuntando al Norte' equals: log last.
	self assert: 'Norte' equals: window headingTextFieldModel .	! !

!MarsRoverTrackStatusTest methodsFor: 'tests' stamp: 'TPL 6/7/2021 15:43:40'!
test07RightLeftWindowStatus
	| window marsRover |
	marsRover:= MarsRover at: 1@1 heading: #North.
	window := MarsRoverStateWindow new.
	marsRover addObserverToHeading: window.
	
	marsRover process: 'r'.
	
	self assert: 'Este' equals: window headingTextFieldModel.
	
	marsRover process: 'r'.
	
	self assert: 'Sur' equals: window headingTextFieldModel.
	
	marsRover process: 'r'.
	
	self assert: 'Oeste' equals: window headingTextFieldModel.
	
	marsRover process: 'r'.
	
	self assert: 'Norte' equals: window headingTextFieldModel.
	
	marsRover process: 'l'.
	
	self assert: 'Oeste' equals: window headingTextFieldModel.
	
	marsRover process: 'l'.
	
	self assert: 'Sur' equals: window headingTextFieldModel.
	
	marsRover process: 'l'.
	
	self assert: 'Este' equals: window headingTextFieldModel.
	
	marsRover process: 'l'.
	
	self assert: 'Norte' equals: window headingTextFieldModel.! !


!classDefinition: #Log category: 'MarsRover-WithHeading'!
Object subclass: #Log
	instanceVariableNames: 'contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Log methodsFor: 'as yet unclassified' stamp: 'TPL 6/7/2021 01:36:31'!
first
	^contents first.! !

!Log methodsFor: 'as yet unclassified' stamp: 'TPL 6/7/2021 03:40:54'!
headingChangeToHead: aMarsRoverHeading
	contents add: 'Apuntando al ', (aMarsRoverHeading getHeadingFrom: self).! !

!Log methodsFor: 'as yet unclassified' stamp: 'TPL 6/7/2021 01:35:38'!
initialize
	contents:= OrderedCollection new.! !

!Log methodsFor: 'as yet unclassified' stamp: 'TPL 6/7/2021 12:58:33'!
last
	^contents last.! !

!Log methodsFor: 'as yet unclassified' stamp: 'TPL 6/7/2021 01:34:04'!
positionChangeTo: aPosition 
	contents add: aPosition printString! !

!Log methodsFor: 'as yet unclassified' stamp: 'TPL 6/7/2021 03:31:07'!
printEast
^'Este'.! !

!Log methodsFor: 'as yet unclassified' stamp: 'TPL 6/7/2021 03:31:28'!
printNorth
^'Norte'.! !

!Log methodsFor: 'as yet unclassified' stamp: 'TPL 6/7/2021 03:31:22'!
printSouth
^'Sur'.! !

!Log methodsFor: 'as yet unclassified' stamp: 'TPL 6/7/2021 03:31:16'!
printWest
^'Oeste'.! !

!Log methodsFor: 'as yet unclassified' stamp: 'TPL 6/7/2021 01:36:14'!
size
	^contents size.! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head headingLog headingWindow positionObservers headingObservers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'TPL 6/7/2021 03:38:53'!
initializeAt: aPosition heading: aHeading

	position := aPosition.
	head := aHeading.
	positionObservers := OrderedCollection new.
	headingObservers := OrderedCollection  new.! !


!MarsRover methodsFor: 'heading' stamp: 'TPL 6/7/2021 03:34:55'!
headEast
	self changeHeadTo: MarsRoverHeadingEast new.
! !

!MarsRover methodsFor: 'heading' stamp: 'TPL 6/7/2021 03:36:25'!
headNorth
		self changeHeadTo: MarsRoverHeadingNorth new.! !

!MarsRover methodsFor: 'heading' stamp: 'TPL 6/7/2021 03:36:52'!
headSouth
	self changeHeadTo: MarsRoverHeadingSouth new.! !

!MarsRover methodsFor: 'heading' stamp: 'TPL 6/7/2021 03:37:16'!
headWest
	self changeHeadTo: MarsRoverHeadingWest new.! !

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

!MarsRover methodsFor: 'moving' stamp: 'TPL 6/7/2021 15:39:43'!
moveEast
	
	self changePositionTo: (position + (1@0)).! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:55'!
moveForward
	
	head moveForward: self! !

!MarsRover methodsFor: 'moving' stamp: 'TPL 6/7/2021 02:19:27'!
moveNorth
	
	self changePositionTo: (position + (0@1)).! !

!MarsRover methodsFor: 'moving' stamp: 'TPL 6/7/2021 02:20:47'!
moveSouth
	
	self changePositionTo: (position + (0@-1)).! !

!MarsRover methodsFor: 'moving' stamp: 'TPL 6/7/2021 15:39:54'!
moveWest
	
	self changePositionTo: (position + (-1@0)).! !


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


!MarsRover methodsFor: 'tracking' stamp: 'TPL 6/7/2021 15:39:09'!
addObserverToHeading: aLoger 
	headingObservers add: aLoger ! !

!MarsRover methodsFor: 'tracking' stamp: 'TPL 6/7/2021 15:37:49'!
addObserverToPosition: aLoger 
	positionObservers add: aLoger ! !

!MarsRover methodsFor: 'tracking' stamp: 'TPL 6/7/2021 03:38:30'!
changeHeadTo: aHead
	head := aHead.
	headingObservers do: [ :anObserver | anObserver headingChangeToHead: head].
! !

!MarsRover methodsFor: 'tracking' stamp: 'TPL 6/7/2021 02:25:13'!
changePositionTo: aPosition
	position:=aPosition.
	positionObservers do: [ :anObserver | anObserver positionChangeTo: position].! !

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

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'TPL 6/7/2021 03:54:17'!
getHeadingFrom: aKindOfLogger
	^aKindOfLogger printEast .! !

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

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'TPL 6/7/2021 03:54:02'!
getHeadingFrom: aKindOfLogger
	^aKindOfLogger printNorth.! !

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

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'TPL 6/7/2021 03:54:24'!
getHeadingFrom: aKindOfLogger
	^aKindOfLogger printSouth .! !

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

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'TPL 6/7/2021 03:54:32'!
getHeadingFrom: aKindOfLogger
	^aKindOfLogger printWest.! !

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


!classDefinition: #MarsRoverStateWindow category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverStateWindow
	instanceVariableNames: 'positionTextFieldModel headingTextFieldModel'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverStateWindow methodsFor: 'print' stamp: 'TPL 6/7/2021 03:23:43'!
printEast
^'Este'.! !

!MarsRoverStateWindow methodsFor: 'print' stamp: 'TPL 6/7/2021 03:43:19'!
printNorth
^'Norte'.! !

!MarsRoverStateWindow methodsFor: 'print' stamp: 'TPL 6/7/2021 03:43:13'!
printSouth
^'Sur'.! !

!MarsRoverStateWindow methodsFor: 'print' stamp: 'TPL 6/7/2021 03:23:55'!
printWest
^'Oeste'.! !


!MarsRoverStateWindow methodsFor: 'tracking' stamp: 'TPL 6/7/2021 03:30:14'!
headingChangeToHead: aMarsRoverHeading 
	headingTextFieldModel:= aMarsRoverHeading getHeadingFrom: self.! !

!MarsRoverStateWindow methodsFor: 'tracking' stamp: 'TPL 6/7/2021 02:01:12'!
headingTextFieldModel
	^headingTextFieldModel.! !

!MarsRoverStateWindow methodsFor: 'tracking' stamp: 'TPL 6/7/2021 01:54:38'!
positionChangeTo: aPosition 
	positionTextFieldModel:= aPosition! !

!MarsRoverStateWindow methodsFor: 'tracking' stamp: 'TPL 6/7/2021 01:55:17'!
positionTextFieldModel
	
	^positionTextFieldModel! !
