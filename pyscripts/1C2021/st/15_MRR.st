!classDefinition: #MarsRoverObserverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverObserverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObserverTest methodsFor: 'test logger - position' stamp: 'dd 6/5/2021 21:32:09'!
test01OnePositionChangeIsObservedByALogger

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	
	log := MarsRoverLogger new.
	marsRover addPositionObserver: log.
	
	marsRover process: 'f'.
	self assert: 1 equals: log size.
	self assert: 1@2 equals: log first.! !

!MarsRoverObserverTest methodsFor: 'test logger - position' stamp: 'dd 6/5/2021 21:32:09'!
test03AllPositionChangesAreObservedByLogger

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	
	log := MarsRoverLogger new.
	marsRover addPositionObserver: log.
		
	marsRover process: 'rf'.
	self assert: 1 equals: log size.
	self assert: 2@1 equals: (log at:1).
	
	marsRover process: 'llf'.
	self assert: 2 equals: log size.
	self assert: 1@1 equals: (log at:2).
	
	marsRover process: 'lf'.
	self assert: 3 equals: log size.
	self assert: 1@0 equals: (log at: 3).
	
	marsRover process: 'rrf'.
	self assert: 4 equals: log size.
	self assert: 1@1 equals: (log at:4).
	! !


!MarsRoverObserverTest methodsFor: 'test logger - heading' stamp: 'dd 6/5/2021 21:36:35'!
test07OneHeadingChangeIsObservedByALogger

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	
	log := MarsRoverLogger new.
	marsRover addHeadingObserver: log.
	
	marsRover process: 'r'.
	self assert: 1 equals: log size.
	self assert: 'Apuntando al Este' equals: log first.
	! !

!MarsRoverObserverTest methodsFor: 'test logger - heading' stamp: 'dd 6/6/2021 18:47:51'!
test09AllHeadingChangesAreObservedByALogger

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	
	log := MarsRoverLogger new.
	marsRover addHeadingObserver: log.
	
	marsRover process: 'r'.
	self assert: 1 equals: log size.
	self assert: 'Apuntando al Este' equals: (log at:1).
	
	marsRover process: 'r'.
	self assert: 2 equals: log size.
	self assert: 'Apuntando al Sur' equals: (log at:2).
	
	marsRover process: 'r'.
	self assert: 3 equals: log size.
	self assert: 'Apuntando al Oeste' equals: (log at:3).
	
	marsRover process: 'r'.
	self assert: 4 equals: log size.
	self assert: 'Apuntando al Norte' equals: (log at:4).! !


!MarsRoverObserverTest methodsFor: 'test window - position' stamp: 'dd 6/5/2021 21:33:41'!
test02OnePositionChangeIsObservedByWindow

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	window := MarsRoverWindow new.
	marsRover addPositionObserver: window.
	
	marsRover process: 'f'.
	self assert: 1@2 equals: window position.! !

!MarsRoverObserverTest methodsFor: 'test window - position' stamp: 'dd 6/5/2021 21:33:41'!
test04AllPositionChangesAreObservedByWindow

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	window := MarsRoverWindow new.
	marsRover addPositionObserver: window.	
	
	marsRover process: 'rf'.
	self assert: 2@1 equals: window position.
	
	marsRover process: 'llf'.
	self assert: 1@1 equals: window position.
	
	marsRover process: 'lf'.
	self assert: 1@0 equals: window position.
	
	marsRover process: 'rrf'.
	self assert: 1@1 equals: window position.
	
	! !

!MarsRoverObserverTest methodsFor: 'test window - position' stamp: 'dd 6/6/2021 18:48:35'!
test06EmptyWindowRaisesErrorPositionHasNotBeenUpdatedYet

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	
	window := MarsRoverWindow new.
	
	marsRover addPositionObserver: window.
	
	self should: [window position]  
		raise: Error
		withExceptionDo: 	[:error | self assert: MarsRoverWindow positionHasNotBeenUpdatedYet equals: error messageText]
	! !


!MarsRoverObserverTest methodsFor: 'test window - heading' stamp: 'dd 6/5/2021 21:52:53'!
test08OneHeadingChangeIsObservedByAWindow

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	
	window := MarsRoverWindow new.
	marsRover addHeadingObserver: window.
	
	marsRover process: 'r'.
	self assert: 'Apuntando al Este' equals: window heading.
	! !

!MarsRoverObserverTest methodsFor: 'test window - heading' stamp: 'dd 6/6/2021 18:49:03'!
test10AllHeadingChangeAreObservedByAWindow

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	
	window := MarsRoverWindow new.
	marsRover addHeadingObserver: window.
	
	marsRover process: 'r'.
	self assert: 'Apuntando al Este' equals: (window heading).
	
	marsRover process: 'r'.
	self assert: 'Apuntando al Sur' equals: (window heading).
	
	marsRover process: 'r'.
	self assert: 'Apuntando al Oeste' equals: (window heading).
	
	marsRover process: 'r'.
	self assert: 'Apuntando al Norte' equals: (window heading).! !

!MarsRoverObserverTest methodsFor: 'test window - heading' stamp: 'dd 6/6/2021 18:17:29'!
test12EmptyWindowRaisesErrorHeadingHasNotBeenUpdatedYet

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	
	window := MarsRoverWindow new.
	
	marsRover addPositionObserver: window.
	
	self should: [window heading]  
		raise: Error
		withExceptionDo: 	[:error | self assert: MarsRoverWindow headingHasNotBeenUpdatedYet equals: error messageText]
	! !


!MarsRoverObserverTest methodsFor: 'test multiple observers' stamp: 'dd 6/5/2021 21:33:41'!
test05AMarsRoverCanHaveMultiplePositionsObservers

	| marsRover log1 log2 window1 window2 |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	
	log1 := MarsRoverLogger new.
	log2 := MarsRoverLogger new.
	marsRover addPositionObserver: log1.
	marsRover addPositionObserver: log2.

	window1 := MarsRoverWindow new.
	window2 := MarsRoverWindow new.
	
	marsRover addPositionObserver: window1.
	marsRover addPositionObserver: window2.

	marsRover process: 'f'.
	self assert: 1 equals: log1 size.
	self assert: 1 equals: log2 size.
	
	self assert: 1@2 equals: log1 first.
	self assert: 1@2 equals: log2 first.
	
	self assert: 1@2 equals: window1 position.
	self assert: 1@2 equals: window2 position.
	
	! !

!MarsRoverObserverTest methodsFor: 'test multiple observers' stamp: 'dd 6/5/2021 22:42:08'!
test11AMarsRoverCanHaveMultipleHeadingObservers

	| marsRover log1 log2 window1 window2 |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	
	log1 := MarsRoverLogger new.
	log2 := MarsRoverLogger new.
	
	marsRover addHeadingObserver: log1.
	marsRover addHeadingObserver: log2.

	window1 := MarsRoverWindow new.
	window2 := MarsRoverWindow new.
	
	marsRover addHeadingObserver: window1.
	marsRover addHeadingObserver: window2.

	marsRover process: 'r'.
	self assert: 1 equals: log1 size.
	self assert: 1 equals: log2 size.
	
	self assert: 'Apuntando al Este' equals: log1 first.
	self assert: 'Apuntando al Este' equals: log2 first.
	
	self assert: 'Apuntando al Este' equals: window1 heading.
	self assert: 'Apuntando al Este' equals: window2 heading.
	
	! !

!MarsRoverObserverTest methodsFor: 'test multiple observers' stamp: 'dd 6/6/2021 18:56:23'!
test13AMarsRoverCanHaveMultipleHeadingObservers

	| marsRover log window |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	
	log := MarsRoverLogger new.
	
	marsRover addPositionObserver: log.
	marsRover addHeadingObserver: log.
	
	window := MarsRoverWindow new.
	
	marsRover addPositionObserver: window.
	marsRover addHeadingObserver: window.

	marsRover process: 'r'.
	self assert: 1 equals: log size.
	self assert: 'Apuntando al Este' equals: log first.
	self assert: 'Apuntando al Este' equals: window heading.
	
	marsRover process: 'f'.
	self assert: 2 equals: log size.
	self assert: 2@1 equals: (log at: 2).
	self assert: 2@1 equals: window position.
	
	! !

!MarsRoverObserverTest methodsFor: 'test multiple observers' stamp: 'dd 6/6/2021 18:57:34'!
test13AMarsRoverObserverCanObserveBothPositionAndHeadingChangesAtTheSameTime

	| marsRover log window |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	
	log := MarsRoverLogger new.
	
	marsRover addPositionObserver: log.
	marsRover addHeadingObserver: log.
	
	window := MarsRoverWindow new.
	
	marsRover addPositionObserver: window.
	marsRover addHeadingObserver: window.

	marsRover process: 'r'.
	self assert: 1 equals: log size.
	self assert: 'Apuntando al Este' equals: log first.
	self assert: 'Apuntando al Este' equals: window heading.
	
	marsRover process: 'f'.
	self assert: 2 equals: log size.
	self assert: 2@1 equals: (log at: 2).
	self assert: 2@1 equals: window position.
	
	! !


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


!MarsRover methodsFor: 'initialization' stamp: 'dd 6/5/2021 21:38:09'!
initializeAt: aPosition heading: aHeading

	position := aPosition.
	head := aHeading.
	positionObservers := OrderedCollection new.
	headingObservers := OrderedCollection  new.! !


!MarsRover methodsFor: 'heading' stamp: 'dd 6/6/2021 18:45:33'!
changeHeadingTo: aNewHeading

	head := aNewHeading.
	self notifyHeadingObservers.! !

!MarsRover methodsFor: 'heading' stamp: 'dd 6/5/2021 22:15:45'!
headEast
	
	self changeHeadingTo: MarsRoverHeadingEast new.! !

!MarsRover methodsFor: 'heading' stamp: 'dd 6/5/2021 22:19:34'!
headNorth
	
	self changeHeadingTo: MarsRoverHeadingNorth new.! !

!MarsRover methodsFor: 'heading' stamp: 'dd 6/5/2021 22:20:07'!
headSouth
	
	self changeHeadingTo: MarsRoverHeadingSouth new.! !

!MarsRover methodsFor: 'heading' stamp: 'dd 6/5/2021 22:20:55'!
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


!MarsRover methodsFor: 'moving' stamp: 'dd 6/6/2021 18:45:59'!
changePositionTo: aNewPosition

	position := aNewPosition.
	self notifyPositionObservers.! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:20'!
moveBackward
	
	head moveBackward: self! !

!MarsRover methodsFor: 'moving' stamp: 'dd 6/5/2021 20:59:34'!
moveEast
	
	self changePositionTo: position + (1@0).! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:55'!
moveForward
	
	head moveForward: self! !

!MarsRover methodsFor: 'moving' stamp: 'dd 6/5/2021 20:58:37'!
moveNorth
	
	self changePositionTo: position + (0@1).! !

!MarsRover methodsFor: 'moving' stamp: 'dd 6/5/2021 20:58:52'!
moveSouth
	
	self changePositionTo: position + (0@-1).! !

!MarsRover methodsFor: 'moving' stamp: 'dd 6/5/2021 20:59:16'!
moveWest
	
	self changePositionTo: position + (-1@0).
! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'dd 6/3/2021 20:27:31'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'observers' stamp: 'dd 6/5/2021 21:46:41'!
addHeadingObserver: aMarsRoverLogger 
	headingObservers add: aMarsRoverLogger ! !

!MarsRover methodsFor: 'observers' stamp: 'dd 6/5/2021 21:46:41'!
addPositionObserver: aPositionObserver 
	positionObservers add: aPositionObserver! !

!MarsRover methodsFor: 'observers' stamp: 'dd 6/6/2021 18:45:13'!
notifyHeadingObservers

	^ headingObservers do:[:observer| observer updateHeading: head]! !

!MarsRover methodsFor: 'observers' stamp: 'dd 6/6/2021 18:45:59'!
notifyPositionObservers

	^ positionObservers do: [ :observer | observer updatePosition: position]! !

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


!MarsRoverHeading methodsFor: 'visiting' stamp: 'dd 6/5/2021 22:53:11'!
accept
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


!MarsRoverHeadingEast methodsFor: 'visiting' stamp: 'dd 6/5/2021 23:16:55'!
accept: aMarsRoverObserver
	aMarsRoverObserver visitMarsRoverHeadingEast.! !

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


!MarsRoverHeadingNorth methodsFor: 'visiting' stamp: 'dd 6/5/2021 23:17:06'!
accept: aMarsRoverObserver
	aMarsRoverObserver visitMarsRoverHeadingNorth.! !

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


!MarsRoverHeadingSouth methodsFor: 'visiting' stamp: 'dd 6/5/2021 23:20:46'!
accept: aMarsRoverObserver
	aMarsRoverObserver visitMarsRoverHeadingSouth.! !

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


!MarsRoverHeadingWest methodsFor: 'visiting' stamp: 'dd 6/5/2021 23:21:21'!
accept: aMarsRoverObserver
	aMarsRoverObserver visitMarsRoverHeadingWest.! !

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

!MarsRoverObserver methodsFor: 'update' stamp: 'dd 6/5/2021 22:45:44'!
updateHeading: aNewHeading
	self subclassResponsibility.! !

!MarsRoverObserver methodsFor: 'update' stamp: 'dd 6/5/2021 22:01:54'!
updatePosition: aString 
	self subclassResponsibility.! !


!MarsRoverObserver methodsFor: 'visiting - private' stamp: 'dd 6/5/2021 23:14:06'!
visitMarsRoverHeadingEast
	self subclassResponsibility ! !

!MarsRoverObserver methodsFor: 'visiting - private' stamp: 'dd 6/5/2021 23:13:28'!
visitMarsRoverHeadingNorth
	self subclassResponsibility ! !

!MarsRoverObserver methodsFor: 'visiting - private' stamp: 'dd 6/5/2021 23:13:40'!
visitMarsRoverHeadingSouth
	self subclassResponsibility ! !

!MarsRoverObserver methodsFor: 'visiting - private' stamp: 'dd 6/5/2021 23:13:53'!
visitMarsRoverHeadingWest
	self subclassResponsibility ! !


!classDefinition: #MarsRoverLogger category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverLogger
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogger methodsFor: 'initialization' stamp: 'dd 6/3/2021 20:26:49'!
initialize
	log := OrderedCollection new.! !


!MarsRoverLogger methodsFor: 'update' stamp: 'dd 6/6/2021 18:37:22'!
updateHeading: aMarsRoverHeading
	aMarsRoverHeading accept: self.
	! !

!MarsRoverLogger methodsFor: 'update' stamp: 'dd 6/6/2021 18:37:05'!
updatePosition: 	aPosition
	log add: aPosition! !


!MarsRoverLogger methodsFor: 'accessing' stamp: 'dd 6/3/2021 21:21:56'!
at:aSize
	^log at:aSize ! !

!MarsRoverLogger methodsFor: 'accessing' stamp: 'dd 6/5/2021 22:04:10'!
first
	^self at:1! !

!MarsRoverLogger methodsFor: 'accessing' stamp: 'dd 6/3/2021 20:31:28'!
size
	^log size! !


!MarsRoverLogger methodsFor: 'visiting - private' stamp: 'dd 6/5/2021 23:12:43'!
visitMarsRoverHeadingEast
	log add: 'Apuntando al Este'	! !

!MarsRoverLogger methodsFor: 'visiting - private' stamp: 'dd 6/5/2021 23:14:15'!
visitMarsRoverHeadingNorth
	log add: 'Apuntando al Norte'	! !

!MarsRoverLogger methodsFor: 'visiting - private' stamp: 'dd 6/5/2021 23:15:01'!
visitMarsRoverHeadingSouth
	log add: 'Apuntando al Sur'
	! !

!MarsRoverLogger methodsFor: 'visiting - private' stamp: 'dd 6/5/2021 23:15:38'!
visitMarsRoverHeadingWest
	log add: 'Apuntando al Oeste'
	! !


!classDefinition: #MarsRoverWindow category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverWindow
	instanceVariableNames: 'position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindow methodsFor: 'update' stamp: 'dd 6/6/2021 18:39:37'!
updateHeading: aMarsRoverHeading
	aMarsRoverHeading accept: self.	! !

!MarsRoverWindow methodsFor: 'update' stamp: 'dd 6/5/2021 21:55:08'!
updatePosition: aPosition
	position := aPosition ! !


!MarsRoverWindow methodsFor: 'assertions' stamp: 'dd 6/6/2021 18:19:20'!
assertHeadingHasBeenUpdated

	^ heading isNil ifTrue: [self error: self class headingHasNotBeenUpdatedYet ]! !

!MarsRoverWindow methodsFor: 'assertions' stamp: 'dd 6/5/2021 21:24:02'!
assertPositionHasBeenUpdated

	^ position isNil ifTrue: [self error: self class positionHasNotBeenUpdatedYet ]! !


!MarsRoverWindow methodsFor: 'accessing' stamp: 'dd 6/6/2021 18:19:45'!
heading
	self assertHeadingHasBeenUpdated.
	^heading! !

!MarsRoverWindow methodsFor: 'accessing' stamp: 'dd 6/5/2021 21:24:02'!
position
	self assertPositionHasBeenUpdated.
	^position! !


!MarsRoverWindow methodsFor: 'visiting - private' stamp: 'dd 6/5/2021 23:26:02'!
visitMarsRoverHeadingEast
	heading := 'Apuntando al Este'	! !

!MarsRoverWindow methodsFor: 'visiting - private' stamp: 'dd 6/5/2021 23:26:34'!
visitMarsRoverHeadingNorth
	heading := 'Apuntando al Norte'! !

!MarsRoverWindow methodsFor: 'visiting - private' stamp: 'dd 6/5/2021 23:26:53'!
visitMarsRoverHeadingSouth
	heading := 'Apuntando al Sur'	! !

!MarsRoverWindow methodsFor: 'visiting - private' stamp: 'dd 6/5/2021 23:27:18'!
visitMarsRoverHeadingWest
	heading := 'Apuntando al Oeste'	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverWindow class' category: 'MarsRover-WithHeading'!
MarsRoverWindow class
	instanceVariableNames: ''!

!MarsRoverWindow class methodsFor: 'error' stamp: 'dd 6/6/2021 18:17:05'!
headingHasNotBeenUpdatedYet
	^'Mars Rover heading has not been updated for the first time yet.'! !

!MarsRoverWindow class methodsFor: 'error' stamp: 'dd 6/5/2021 21:20:21'!
positionHasNotBeenUpdatedYet
	^'Mars Rover position has not been updated for the first time yet.'! !
