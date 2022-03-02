!classDefinition: #MarsRoverObserverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverObserverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObserverTest methodsFor: 'tests' stamp: 'JPF 6/5/2021 16:43:36'!
test01ObserversShouldNotRegisterChangesMoreThanOnceEvenIfTheyAreAddedMoreThanOnceToMarsRover

	| marsRover positionLog rotationLog positionWindow rotationWindow |
	
	marsRover _ MarsRover at: 0@0 heading: #North.
	
	rotationWindow _ RotationWindow new.
	rotationLog _ RotationLog new.
	
	positionWindow _ PositionWindow new.
	positionLog _ PositionLog new.
	
	marsRover addRotationObserver: rotationLog.
	marsRover addRotationObserver: rotationLog.
	
	marsRover addRotationObserver: rotationWindow.
	marsRover addRotationObserver: rotationWindow.
	
	marsRover addPositionObserver: positionLog.
	marsRover addPositionObserver: positionLog.
	
	marsRover addPositionObserver: positionWindow.
	marsRover addPositionObserver: positionWindow.
	
	marsRover process: 'fr'.
	
	self assert: 'Mars Rover is heading East' equals: rotationWindow showHeading.
	self assert: (OrderedCollection with: 'Mars Rover is heading East') equals: rotationLog log.
	
	self assert: (OrderedCollection with: 'Mars Rover is in position 0@1') equals: positionLog log.
	self assert: 'Mars Rover position is 0@1' equals: positionWindow showPosition
	
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


!classDefinition: #PositionLogTest category: 'MarsRover-WithHeading'!
TestCase subclass: #PositionLogTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionLogTest methodsFor: 'tests' stamp: 'JPF 6/5/2021 16:19:26'!
test01ShouldBeEmptyWhenMarsRoverDidNotChangePosition
	
	| marsRover positionLog |
	
	marsRover _ MarsRover at: 0@0 heading: #North.
	
	positionLog _ PositionLog new.
	
	marsRover addPositionObserver: positionLog.
	
	marsRover process: 'r'.
	
	self assert: OrderedCollection new equals: positionLog log! !

!PositionLogTest methodsFor: 'tests' stamp: 'JPF 6/5/2021 16:19:34'!
test02ShouldHaveAnEntryWhenMarsRoverMoveForward
	
	| marsRover positionLog |
	
	marsRover _ MarsRover at: 0@0 heading: #North.
	
	positionLog _ PositionLog new.
	
	marsRover addPositionObserver: positionLog.
	
	marsRover process: 'f'.
	
	self assert: (OrderedCollection with: 'Mars Rover is in position 0@1') equals: positionLog log
	
	! !

!PositionLogTest methodsFor: 'tests' stamp: 'JPF 6/5/2021 16:19:41'!
test03ShouldHaveTwoEntriesWhenMarsRoverMoveForwardAndBackwards
	
	| marsRover positionLog |
	
	marsRover _ MarsRover at: 0@0 heading: #West.
	
	positionLog _ PositionLog new.
	
	marsRover addPositionObserver: positionLog.
	
	marsRover process: 'fb'.
	
	self
		assert: (OrderedCollection
			with: 'Mars Rover is in position -1@0'
			with: 'Mars Rover is in position 0@0')
		equals: positionLog log
	
	! !


!classDefinition: #PositionWindowTest category: 'MarsRover-WithHeading'!
TestCase subclass: #PositionWindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionWindowTest methodsFor: 'tests' stamp: 'JPF 6/5/2021 16:19:54'!
test01ShouldShowMarsRoverPositionHasNotChangedIfMarsRoverDidNotChangePosition
	
	| marsRover positionWindow |
	
	marsRover _ MarsRover at: 0@0 heading: #North.
	
	positionWindow _ PositionWindow new.
	
	marsRover addPositionObserver: positionWindow.
	
	marsRover process: 'l'.
	
	self assert: 'Mars Rover position has not changed' equals: positionWindow showPosition! !

!PositionWindowTest methodsFor: 'tests' stamp: 'JPF 6/5/2021 16:20:00'!
test02ShouldShowNewMarsRoverPositionWhenMarsRoverMoveForward
	
	| marsRover positionWindow |
	
	marsRover _ MarsRover at: 0@0 heading: #North.
	
	positionWindow _ PositionWindow new.
	
	marsRover addPositionObserver: positionWindow.
	
	marsRover process: 'rf'.
	
	self assert: 'Mars Rover position is 1@0' equals: positionWindow showPosition
	! !

!PositionWindowTest methodsFor: 'tests' stamp: 'JPF 6/5/2021 16:20:07'!
test03ShouldShowLastMarsRoverPositionWhenMarsRoverMoveForwardAndThenBackwards
	
	| marsRover positionWindow |
	
	marsRover _ MarsRover at: 0@0 heading: #North.
	
	positionWindow _ PositionWindow new.
	
	marsRover addPositionObserver: positionWindow.
	
	marsRover process: 'llf'.
	
	self assert: 'Mars Rover position is 0@-1' equals: positionWindow showPosition.
	
	marsRover process: 'b'.
	
	self assert: 'Mars Rover position is 0@0' equals: positionWindow showPosition
	! !


!classDefinition: #RotationLogTest category: 'MarsRover-WithHeading'!
TestCase subclass: #RotationLogTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!RotationLogTest methodsFor: 'tests' stamp: 'JPF 6/5/2021 16:20:25'!
test01ShouldBeEmptyWhenMarsRoverDidNotRotate
	
	| marsRover rotationLog |
	
	marsRover _ MarsRover at: 0@0 heading: #North.
	
	rotationLog _ RotationLog new.
	
	marsRover addRotationObserver: rotationLog.
	
	marsRover process: 'f'.
	
	self assert: OrderedCollection new equals: rotationLog log
	! !

!RotationLogTest methodsFor: 'tests' stamp: 'JPF 6/5/2021 16:20:31'!
test02ShouldHaveWestWhenMarsRoverRotateLeft
	
	| marsRover rotationLog |
	
	marsRover _ MarsRover at: 0@0 heading: #North.
	
	rotationLog _ RotationLog new.
	
	marsRover addRotationObserver: rotationLog.
	
	marsRover process: 'fl'.
	
	self assert: (OrderedCollection with: 'Mars Rover is heading West') equals: rotationLog log
	! !

!RotationLogTest methodsFor: 'tests' stamp: 'JPF 6/5/2021 16:20:36'!
test03ShouldHaveEastWhenMarsRoverRotateRight
	
	| marsRover rotationLog |
	
	marsRover _ MarsRover at: 0@0 heading: #North.
	
	rotationLog _ RotationLog new.
	
	marsRover addRotationObserver: rotationLog.
	
	marsRover process: 'br'.
	
	self assert: (OrderedCollection with: 'Mars Rover is heading East') equals: rotationLog log
	! !

!RotationLogTest methodsFor: 'tests' stamp: 'JPF 6/5/2021 16:20:42'!
test04ShouldHaveTheFourCardinalPointsWhenMarsRoverMakesACompleteTurn
	
	| marsRover rotationLog |
	
	marsRover _ MarsRover at: 0@0 heading: #North.
	
	rotationLog _ RotationLog new.
	
	marsRover addRotationObserver: rotationLog.
	
	marsRover process: 'brrrr'.
	
	self
		assert: (OrderedCollection
			with: 'Mars Rover is heading East'
			with: 'Mars Rover is heading South'
			with: 'Mars Rover is heading West'
			with: 'Mars Rover is heading North')
		equals: rotationLog log
	! !


!classDefinition: #RotationWindowTest category: 'MarsRover-WithHeading'!
TestCase subclass: #RotationWindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!RotationWindowTest methodsFor: 'tests' stamp: 'JPF 6/5/2021 16:20:49'!
test01ShouldShowMarsRoverHeadingHasNotChangedIfMarsRoverDidNotRotate
	
	| marsRover rotationWindow |
	
	marsRover _ MarsRover at: 0@0 heading: #North.
	
	rotationWindow _ RotationWindow new.
	
	marsRover addRotationObserver: rotationWindow.
	
	marsRover process: 'ffb'.
	
	self assert: 'Mars Rover heading has not changed' equals: rotationWindow showHeading! !

!RotationWindowTest methodsFor: 'tests' stamp: 'JPF 6/5/2021 16:20:55'!
test02ShouldShowTheLastMarsRoverHeadingWhenMarsRoverMakesACompleteTurnToBothSides
	
	| marsRover rotationWindow |
	
	marsRover _ MarsRover at: 0@0 heading: #North.
	
	rotationWindow _ RotationWindow new.
	
	marsRover addRotationObserver: rotationWindow.
	
	marsRover process: 'l'.
	self assert: 'Mars Rover is heading West' equals: rotationWindow showHeading.
	
	marsRover process: 'l'.
	self assert: 'Mars Rover is heading South' equals: rotationWindow showHeading.
	
	marsRover process: 'l'.
	self assert: 'Mars Rover is heading East' equals: rotationWindow showHeading.
	
	marsRover process: 'l'.
	self assert: 'Mars Rover is heading North' equals: rotationWindow showHeading.
	
	marsRover process: 'r'.
	self assert: 'Mars Rover is heading East' equals: rotationWindow showHeading.
	
	marsRover process: 'r'.
	self assert: 'Mars Rover is heading South' equals: rotationWindow showHeading.
	
	marsRover process: 'r'.
	self assert: 'Mars Rover is heading West' equals: rotationWindow showHeading.
	
	marsRover process: 'r'.
	self assert: 'Mars Rover is heading North' equals: rotationWindow showHeading.
	! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head positionLog rotationLog positionWindow rotationWindow positionObservers rotationObservers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'JPF 6/5/2021 16:42:34'!
initializeAt: aPosition heading: aHeading

	position := aPosition.
	head := aHeading.
	positionObservers := Set new.
	rotationObservers := Set new.! !


!MarsRover methodsFor: 'heading' stamp: 'JPF 6/5/2021 16:21:40'!
head: newMarsRoverHeading

	head _ newMarsRoverHeading.
	rotationObservers do: [ :rotationObserver | rotationObserver rotationDone: newMarsRoverHeading ]! !

!MarsRover methodsFor: 'heading' stamp: 'JPF 6/5/2021 14:36:04'!
headEast
	
	self head: MarsRoverHeadingEast new.! !

!MarsRover methodsFor: 'heading' stamp: 'JPF 6/5/2021 14:36:16'!
headNorth
	
	self head: MarsRoverHeadingNorth new! !

!MarsRover methodsFor: 'heading' stamp: 'JPF 6/5/2021 14:36:26'!
headSouth
	
	self head: MarsRoverHeadingSouth new! !

!MarsRover methodsFor: 'heading' stamp: 'JPF 6/5/2021 14:36:39'!
headWest
	
	self head: MarsRoverHeadingWest new! !

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


!MarsRover methodsFor: 'position' stamp: 'JPF 6/6/2021 22:43:17'!
addToPosition: aDeltaToAdd
	
	position _ position + aDeltaToAdd.
	positionObservers do: [ :positionObserver | positionObserver positionChanged: position ]
	! !


!MarsRover methodsFor: 'moving' stamp: 'JPF 6/5/2021 14:24:32'!
moveBackward
	
	head moveBackward: self! !

!MarsRover methodsFor: 'moving' stamp: 'JPF 6/5/2021 14:28:42'!
moveEast
	
	self addToPosition: (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'JPF 6/5/2021 14:27:09'!
moveForward
	
	head moveForward: self! !

!MarsRover methodsFor: 'moving' stamp: 'JPF 6/5/2021 14:28:34'!
moveNorth
	
	self addToPosition: (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'JPF 6/5/2021 14:28:25'!
moveSouth
	
	self addToPosition: (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'JPF 6/5/2021 14:27:40'!
moveWest
	
	self addToPosition: (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'JPF 6/3/2021 21:21:56'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward. ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward. ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight. ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft. ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'observers' stamp: 'JPF 6/5/2021 16:15:01'!
addPositionObserver: aPositionObserver

	positionObservers add: aPositionObserver! !

!MarsRover methodsFor: 'observers' stamp: 'JPF 6/5/2021 16:15:29'!
addRotationObserver: aRotationObserver

	rotationObservers add: aRotationObserver! !

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

!MarsRoverHeading methodsFor: 'heading' stamp: 'JPF 6/6/2021 22:42:40'!
headingFor: anObserver
	
	self subclassResponsibility! !

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


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'JPF 6/6/2021 22:42:40'!
headingFor: anObserver
	
	anObserver marsRoverHeadingEast! !

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


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'JPF 6/6/2021 22:42:40'!
headingFor: anObserver
	
	anObserver marsRoverHeadingNorth! !

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


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'JPF 6/6/2021 22:42:40'!
headingFor: anObserver
	
	anObserver marsRoverHeadingSouth! !

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


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'JPF 6/6/2021 22:42:40'!
headingFor: anObserver
	
	anObserver marsRoverHeadingWest! !

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


!classDefinition: #MarsRoverPositionObserver category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverPositionObserver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverPositionObserver methodsFor: 'positionChanged' stamp: 'JPF 6/5/2021 16:25:04'!
positionChanged: newPosition

	self subclassResponsibility! !


!classDefinition: #MarsRoverRotationObserver category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverRotationObserver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverRotationObserver methodsFor: 'rotationDone' stamp: 'JPF 6/5/2021 16:25:37'!
rotationDone: newMarsRoverHeading

	self subclassResponsibility! !


!classDefinition: #PositionLog category: 'MarsRover-WithHeading'!
Object subclass: #PositionLog
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionLog methodsFor: 'log' stamp: 'JPF 6/3/2021 20:40:25'!
log
	^ log! !


!PositionLog methodsFor: 'initialization' stamp: 'JPF 6/3/2021 20:37:21'!
initialize
	
	log := OrderedCollection new! !


!PositionLog methodsFor: 'observer' stamp: 'JPF 6/5/2021 15:09:09'!
positionChanged: newPosition

	log add: 'Mars Rover is in position ' , newPosition asString! !


!classDefinition: #PositionWindow category: 'MarsRover-WithHeading'!
Object subclass: #PositionWindow
	instanceVariableNames: 'position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionWindow methodsFor: 'position' stamp: 'JPF 6/5/2021 15:45:31'!
showPosition
	position
		ifNil: [ ^ 'Mars Rover position has not changed' ]
		ifNotNil: [ ^ 'Mars Rover position is ' , position asString ]! !


!PositionWindow methodsFor: 'observer' stamp: 'JPF 6/5/2021 15:32:35'!
positionChanged: newPosition
	
	position _ newPosition! !


!classDefinition: #RotationLog category: 'MarsRover-WithHeading'!
Object subclass: #RotationLog
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!RotationLog methodsFor: 'initialization' stamp: 'JPF 6/3/2021 21:13:50'!
initialize
	
	log _ OrderedCollection new.! !


!RotationLog methodsFor: 'observer' stamp: 'JPF 6/5/2021 16:12:08'!
marsRoverHeadingEast

	log add: 'Mars Rover is heading East'! !

!RotationLog methodsFor: 'observer' stamp: 'JPF 6/5/2021 16:12:00'!
marsRoverHeadingNorth

	log add: 'Mars Rover is heading North'! !

!RotationLog methodsFor: 'observer' stamp: 'JPF 6/5/2021 16:11:51'!
marsRoverHeadingSouth

	log add: 'Mars Rover is heading South'! !

!RotationLog methodsFor: 'observer' stamp: 'JPF 6/5/2021 16:11:43'!
marsRoverHeadingWest

	log add: 'Mars Rover is heading West'! !

!RotationLog methodsFor: 'observer' stamp: 'JPF 6/6/2021 22:48:14'!
rotationDone: newMarsRoverHeading

	newMarsRoverHeading headingFor: self

	! !


!RotationLog methodsFor: 'log' stamp: 'JPF 6/3/2021 21:14:10'!
log
	^ log! !


!classDefinition: #RotationWindow category: 'MarsRover-WithHeading'!
Object subclass: #RotationWindow
	instanceVariableNames: 'headingMessage'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!RotationWindow methodsFor: 'heading' stamp: 'JPF 6/5/2021 16:09:16'!
showHeading
	^ headingMessage! !


!RotationWindow methodsFor: 'initialization' stamp: 'JPF 6/5/2021 16:09:03'!
initialize

	headingMessage _ 'Mars Rover heading has not changed'! !


!RotationWindow methodsFor: 'observer' stamp: 'JPF 6/5/2021 16:07:33'!
marsRoverHeadingEast

	headingMessage _ 'Mars Rover is heading East'! !

!RotationWindow methodsFor: 'observer' stamp: 'JPF 6/5/2021 16:07:11'!
marsRoverHeadingNorth

	headingMessage _ 'Mars Rover is heading North'! !

!RotationWindow methodsFor: 'observer' stamp: 'JPF 6/5/2021 16:06:39'!
marsRoverHeadingSouth

	headingMessage _ 'Mars Rover is heading South'! !

!RotationWindow methodsFor: 'observer' stamp: 'JPF 6/5/2021 16:07:23'!
marsRoverHeadingWest

	headingMessage _ 'Mars Rover is heading West'! !

!RotationWindow methodsFor: 'observer' stamp: 'JPF 6/6/2021 22:42:40'!
rotationDone: newMarsRoverHeading

	newMarsRoverHeading headingFor: self! !
