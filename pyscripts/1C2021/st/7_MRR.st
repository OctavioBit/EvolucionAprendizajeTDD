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

!MarsRoverTest methodsFor: 'tests' stamp: 'Am 6/6/2021 18:59:37'!
test17LogRegistersOneMoveForward

	| marsRover log|
	
	marsRover := MarsRover at: 1@2 heading: #West.
	log:= Log new.
	
	marsRover addObserverToPosition: log.
	
	marsRover process: 'f'.
	
	self assert: (log console at: 1) equals: ( '0@2').! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Am 6/6/2021 18:59:47'!
test18LogRegistersManyMovesForwardSameDirection

	| marsRover log|
	
	marsRover := MarsRover at: 1@2 heading: #West.
	log:= Log new.
	
	marsRover addObserverToPosition: log.
	
	marsRover process: 'ff'.
	
	self assert: (log console) equals: (OrderedCollection with: '0@2' with: '-1@2').! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Am 6/6/2021 19:00:08'!
test19LogWorksForEveryDirectionForward

	| marsRover log|
	
	marsRover := MarsRover at: 1@2 heading: #West.
	log:= Log new.
	
	marsRover addObserverToPosition: log.
	
	marsRover process: 'frfrfrf'.
	
	self assert: log console equals: (OrderedCollection with: '0@2' with: '0@3' with: '1@3' with: '1@2' ).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Am 6/6/2021 19:00:56'!
test20LogWorksForEveryDirectionBackwards

	| marsRover log|
	
	marsRover := MarsRover at: 1@2 heading: #West.
	log:= Log new.
	
	marsRover addObserverToPosition: log.
	
	marsRover process: 'brbrbrb'.
	
	self assert: log console equals: (OrderedCollection with: '2@2' with: '2@1' with: '1@1' with: '1@2' ).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Am 6/6/2021 19:02:04'!
test21LogRegistersOneHeadingChange

	| marsRover log|
	
	marsRover := MarsRover at: 1@2 heading: #West.
	log:= Log new.
	
	marsRover addObserverToHeading: log.
	
	marsRover process: 'r'.
	
	self assert: log console equals: (OrderedCollection with: 'Facing North' ).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Am 6/6/2021 19:01:42'!
test22LogRegitersEveryHeadingChange

	| marsRover log|
	
	marsRover := MarsRover at: 1@2 heading: #West.
	log:= Log new.
	
	marsRover addObserverToHeading: log.
	
	marsRover process: 'rrrr'.
	
	self assert: log console equals: (OrderedCollection with: 'Facing North' with: 'Facing East' with: 'Facing South' with: 'Facing West').! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Am 6/6/2021 19:02:43'!
test23WindowRegistersOnePositionChangeForward

	| marsRover stateWindow|
	
	marsRover := MarsRover at: 1@2 heading: #West.
	stateWindow:= StateWindow new.
	
	marsRover addObserverToPosition: stateWindow.
	
	marsRover process: 'f'.
	
	self assert: stateWindow positionWindow equals: ('0@2').! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Am 6/6/2021 19:02:58'!
test24WindowRegistersOnePositionChangeBackwards

	| marsRover stateWindow|
	
	marsRover := MarsRover at: 1@2 heading: #West.
	stateWindow:= StateWindow new.
	
	marsRover addObserverToPosition: stateWindow.
	
	marsRover process: 'b'.
	
	self assert: stateWindow positionWindow equals: ('2@2').! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Am 6/6/2021 19:04:57'!
test25WindowRegistersEveryPositionChange

	| marsRover stateWindow|
	
	marsRover := MarsRover at: 1@2 heading: #West.
	stateWindow:= StateWindow new.
	
	marsRover addObserverToPosition: stateWindow.
	
	marsRover process: 'frfbrflf'.
	
	self assert: stateWindow positionWindow equals: ('1@3').! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Am 6/6/2021 19:05:47'!
test26WindowRegisterOneChangeHeading

	| marsRover stateWindow|
	
	marsRover := MarsRover at: 1@2 heading: #West.
	stateWindow:= StateWindow new.
	
	marsRover addObserverToHeading: stateWindow.
	
	marsRover process: 'r'.
	
	self assert: stateWindow headingWindow equals: ('Facing North').! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Am 6/6/2021 19:07:06'!
test27WindowRegistersEveryHeadingChange

	| marsRover stateWindow|
	
	marsRover := MarsRover at: 1@2 heading: #West.
	stateWindow:= StateWindow new.
	
	marsRover addObserverToHeading: stateWindow.
	
	marsRover process: 'rrrrllllr'.
	
	self assert: stateWindow headingWindow equals: ('Facing North').! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Am 6/6/2021 19:11:28'!
test28LogRegistersPositionAndHeadingChanges

	| marsRover log|
	
	marsRover := MarsRover at: 1@2 heading: #West.
	log:= Log new.
	
	marsRover addObserverToHeading: log.
	marsRover addObserverToPosition: log.

	
	marsRover process: 'rflb'.
	
	self assert: log console equals: (OrderedCollection with: 'Facing North' with: '1@3' with: 'Facing West' with: '2@3').! !


!classDefinition: #Log category: 'MarsRover-WithHeading'!
Object subclass: #Log
	instanceVariableNames: 'logger'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Log methodsFor: 'initialization' stamp: 'Am 6/6/2021 17:26:46'!
initialize
	logger:= OrderedCollection  new.! !


!Log methodsFor: 'printing' stamp: 'Am 6/6/2021 17:39:01'!
console
	^logger! !


!Log methodsFor: 'changes registration' stamp: 'Am 6/6/2021 18:39:00'!
headingChangedToEast
logger add: 'Facing East'! !

!Log methodsFor: 'changes registration' stamp: 'Am 6/6/2021 18:38:46'!
headingChangedToNorth
logger add: 'Facing North'! !

!Log methodsFor: 'changes registration' stamp: 'Am 6/6/2021 18:39:17'!
headingChangedToSouth
logger add: 'Facing South'! !

!Log methodsFor: 'changes registration' stamp: 'Am 6/6/2021 18:39:31'!
headingChangedToWest
logger add: 'Facing West'! !

!Log methodsFor: 'changes registration' stamp: 'Am 6/6/2021 17:39:42'!
positionChangedTo: aPoint 
	logger add: aPoint asString .! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'positionObservers position head headingObservers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'Am 6/6/2021 17:29:17'!
initializeAt: aPosition heading: aHeading

	position := aPosition.
	head := aHeading.
	positionObservers:= OrderedCollection new.
	headingObservers:= OrderedCollection new.! !


!MarsRover methodsFor: 'heading' stamp: 'Am 6/6/2021 18:30:50'!
changeHeadTo: aHeading
	
	head := aHeading.
	headingObservers do: [:aHeadingLog|  head notifyChangeTo: aHeadingLog].! !

!MarsRover methodsFor: 'heading' stamp: 'Am 6/6/2021 17:48:07'!
headEast
	
	self changeHeadTo: MarsRoverHeadingEast new! !

!MarsRover methodsFor: 'heading' stamp: 'Am 6/6/2021 17:48:14'!
headNorth
	
	self changeHeadTo: MarsRoverHeadingNorth new! !

!MarsRover methodsFor: 'heading' stamp: 'Am 6/6/2021 17:48:19'!
headSouth
	
	self changeHeadTo: MarsRoverHeadingSouth new! !

!MarsRover methodsFor: 'heading' stamp: 'Am 6/6/2021 17:48:25'!
headWest
	
	self changeHeadTo: MarsRoverHeadingWest new! !

!MarsRover methodsFor: 'heading' stamp: 'Am 6/6/2021 17:48:35'!
rotateLeft
	
	head rotateLeft: self.
	

		
! !

!MarsRover methodsFor: 'heading' stamp: 'Am 6/6/2021 17:48:48'!
rotateRight
	
	head rotateRight: self.
	
! !


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


!MarsRover methodsFor: 'moving' stamp: 'Am 6/6/2021 17:32:20'!
moveBackward
	
	head moveBackward: self.! !

!MarsRover methodsFor: 'moving' stamp: 'Am 6/6/2021 17:31:27'!
moveEast
	self positionSetTo: position + (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'Am 6/6/2021 17:30:32'!
moveForward
	
	head moveForward: self.! !

!MarsRover methodsFor: 'moving' stamp: 'Am 6/6/2021 17:32:42'!
moveNorth
	
	self positionSetTo: position + (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'Am 6/6/2021 17:33:09'!
moveSouth
	
	self positionSetTo: position + (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'Am 6/6/2021 17:33:19'!
moveWest
	
	self positionSetTo: position + (-1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'Am 6/6/2021 17:34:54'!
positionSetTo: aPosition
	position := aPosition.
	positionObservers do:[:anObserver| anObserver positionChangedTo: position].! !


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


!MarsRover methodsFor: 'Observer' stamp: 'Am 6/6/2021 18:44:07'!
addObserverToHeading:anObserver 
	headingObservers add: anObserver! !

!MarsRover methodsFor: 'Observer' stamp: 'Am 6/6/2021 18:44:23'!
addObserverToPosition:anObserver 
	positionObservers add: anObserver! !

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


!MarsRoverHeading methodsFor: 'Observer' stamp: 'Am 6/6/2021 18:32:37'!
notifyChangeTo: aHeadingObserver
	self subclassResponsibility .! !

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


!MarsRoverHeadingEast methodsFor: 'Observer' stamp: 'Am 6/6/2021 18:33:12'!
notifyChangeTo: aHeadingObserver
	aHeadingObserver headingChangedToEast.! !

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


!MarsRoverHeadingNorth methodsFor: 'Observer' stamp: 'Am 6/6/2021 18:34:06'!
notifyChangeTo: aHeadingObserver
	aHeadingObserver headingChangedToNorth.! !

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


!MarsRoverHeadingSouth methodsFor: 'Observer' stamp: 'Am 6/6/2021 18:34:38'!
notifyChangeTo: aHeadingObserver
	aHeadingObserver headingChangedToSouth.! !

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


!MarsRoverHeadingWest methodsFor: 'Observer' stamp: 'Am 6/6/2021 18:34:59'!
notifyChangeTo: aHeadingObserver
	aHeadingObserver headingChangedToWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingWest class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingWest class
	instanceVariableNames: ''!

!MarsRoverHeadingWest class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:23'!
cardinalPoint

	^#West! !


!classDefinition: #StateWindow category: 'MarsRover-WithHeading'!
Object subclass: #StateWindow
	instanceVariableNames: 'position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!StateWindow methodsFor: 'changes registration' stamp: 'Am 6/6/2021 18:37:21'!
headingChangedToEast
heading:= 'Facing East'! !

!StateWindow methodsFor: 'changes registration' stamp: 'Am 6/6/2021 18:37:03'!
headingChangedToNorth
	heading:= 'Facing North'! !

!StateWindow methodsFor: 'changes registration' stamp: 'Am 6/6/2021 18:37:38'!
headingChangedToSouth
heading:= 'Facing South'! !

!StateWindow methodsFor: 'changes registration' stamp: 'Am 6/6/2021 18:37:55'!
headingChangedToWest
heading:= 'Facing West'! !

!StateWindow methodsFor: 'changes registration' stamp: 'Am 6/6/2021 18:08:50'!
positionChangedTo: aMarsRoverPosition 
	position := aMarsRoverPosition asString.! !


!StateWindow methodsFor: 'access' stamp: 'Am 6/6/2021 18:13:31'!
headingWindow
	^heading! !

!StateWindow methodsFor: 'access' stamp: 'Am 6/6/2021 18:05:42'!
positionWindow
	^position asString.! !
