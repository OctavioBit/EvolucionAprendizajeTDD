!classDefinition: #MarsRoverMicroServiceTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverMicroServiceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!


!classDefinition: #MarsRoverLogTest category: 'MarsRover-WithHeading'!
MarsRoverMicroServiceTest subclass: #MarsRoverLogTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogTest methodsFor: 'test' stamp: 'FG 6/6/2021 22:44:04'!
test01PositionLogShouldRegisterOneFowardCommand

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	log := LogPosition new.
	
	marsRover addMicroService: log.
	
	marsRover process: 'f'.
	
	self assert: log size equals: 1.
	self assert: log first equals:  1@2.
	! !

!MarsRoverLogTest methodsFor: 'test' stamp: 'FG 6/6/2021 22:48:02'!
test02PositionLogShouldRegisterMultipleFowardCommands

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	log := LogPosition new.
	
	marsRover addMicroService: log.
	
	marsRover process: 'ff'.
	
	self assert: log size equals: 2.
	self assert: log first equals:  1@2.
	self assert: log second equals: 1@3.
	! !

!MarsRoverLogTest methodsFor: 'test' stamp: 'FG 6/6/2021 22:48:14'!
test03PositionLogShouldRegisterOneBackwardCommand

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	log := LogPosition new.
	
	marsRover addMicroService: log.
	
	marsRover process: 'b'.
	
	self assert: log size equals: 1.
	self assert: log first equals:  1@0.
	! !

!MarsRoverLogTest methodsFor: 'test' stamp: 'FG 6/6/2021 22:49:23'!
test04HeadingLogShouldRegisterOneLeftCommand

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	log := LogHeading new.
	
	marsRover addMicroService: log.
	
	marsRover process: 'l'.
	
	self assert: log size equals: 1.
	self assert: log first equals:  #West.
	! !

!MarsRoverLogTest methodsFor: 'test' stamp: 'FG 6/6/2021 22:52:19'!
test05HeadingLogShouldRegisterOneRightCommand

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	log := LogHeading new.
	
	marsRover addMicroService: log.
	
	marsRover process: 'r'.
	
	self assert: log size equals: 1.
	self assert: log first equals:  #East.
	! !

!MarsRoverLogTest methodsFor: 'test' stamp: 'FG 6/6/2021 22:52:29'!
test06HeadingLogShouldNotRegisterAFowardCommand

	| marsRover log |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	log := LogHeading new.
	
	marsRover addMicroService: log.
	
	marsRover process: 'f'.
	
	self assert: log size equals: 0.	! !

!MarsRoverLogTest methodsFor: 'test' stamp: 'FG 6/6/2021 22:53:26'!
test07MarsRoverCanHaveMultiplePositionLogs

	| marsRover logA logB|
	
	marsRover := MarsRover at: 1@1 heading: #North.
	logA := LogPosition new.
	logB := LogPosition new.
	
	marsRover addMicroService: logA.
	
	marsRover process: 'f'.

	marsRover addMicroService: logB.
	
	marsRover process: 'f'.
	
	self assert: logA size equals: 2.
	self assert: logA first equals: 1@2.
	self assert: logA second equals: 1@3.
	
	self assert: logB size equals: 1.	
	self assert: logB first equals: 1@3.! !

!MarsRoverLogTest methodsFor: 'test' stamp: 'FG 6/6/2021 22:53:41'!
test08MarsRoverCanHaveMultipleHeadingLogs

	| marsRover logA logB|
	
	marsRover := MarsRover at: 1@1 heading: #North.
	logA := LogHeading new.
	logB := LogHeading new.
	
	marsRover addMicroService: logA.
	
	marsRover process: 'l'.

	marsRover addMicroService: logB.
	
	marsRover process: 'l'.
	
	self assert: logA size equals: 2.
	self assert: logA first equals: #West.
	self assert: logA second equals: #South.
	
	self assert: logB size equals: 1.	
	self assert: logB first equals: #South.! !

!MarsRoverLogTest methodsFor: 'test' stamp: 'FG 6/6/2021 22:53:56'!
test09PositionAndHeadingLogShouldRegisterAnyCommand

	| marsRover logA expectedLog |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	logA := LogPositionAndHeading new.
	
	marsRover addMicroService: logA.
	
	marsRover process: 'fblr'.
	
	expectedLog :=  OrderedCollection new.
	expectedLog add: 1@2.
	expectedLog add: 1@1.
	expectedLog add: #West.
	expectedLog add: #North.
	
	self assert: logA size equals: 4.
	self assert: logA log equals: expectedLog.! !

!MarsRoverLogTest methodsFor: 'test' stamp: 'FG 6/6/2021 22:55:18'!
test10MarsRoverCanHaveAnyAmountOfLogsOfAnyType

	| marsRover logA logB logC |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	logA := LogPosition new.
	logB := LogHeading new.
	logC := LogPositionAndHeading new.
	
	marsRover addMicroService: logA.
	marsRover addMicroService: logB.
	marsRover addMicroService: logC.
	
	marsRover process: 'fl'.

	self assert: logA size equals: 1.
	self assert: logA first equals: 1@2.
	
	self assert: logB size equals: 1.
	self assert: logB first equals: #West.
	
	self assert: logC size equals: 2.
	self assert: logC first equals: 1@2.
	self assert: 	logC second equals: #West.! !


!classDefinition: #MarsRoverWindowTest category: 'MarsRover-WithHeading'!
MarsRoverMicroServiceTest subclass: #MarsRoverWindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindowTest methodsFor: 'test' stamp: 'FG 6/6/2021 23:00:51'!
test01PositionWindowShouldChangeWhenMarsRoverReceivesAFowardCommand


	| marsRover window |
	
	marsRover :=  MarsRover at: 1@1 heading: #North.
	window := WindowPosition new.
	
	marsRover addMicroService: window.
	
	self assert: window position equals: 1@1.
	
	marsRover process: 'f'.
	
	self assert: window position equals: 1@2.
	! !

!MarsRoverWindowTest methodsFor: 'test' stamp: 'FG 6/6/2021 23:00:55'!
test02PositionWindowShouldChangeAfterABackwardsCommand

	| marsRover window |
	
	marsRover :=  MarsRover at: 1@1 heading: #North.
	window := WindowPosition new.
	
	marsRover addMicroService: window.
	
	marsRover process: 'b'.
	
	self assert: window position equals: 1@0.
	! !

!MarsRoverWindowTest methodsFor: 'test' stamp: 'FG 6/6/2021 23:01:01'!
test03HeadingWindowShouldChangeAfterALeftCommand

	| marsRover window |
	
	marsRover :=  MarsRover at: 1@1 heading: #North.
	window := WindowHeading new.
	
	marsRover addMicroService: window.
	
	marsRover process: 'l'.
	
	self assert: window heading equals: #West.
	! !

!MarsRoverWindowTest methodsFor: 'test' stamp: 'FG 6/6/2021 23:01:04'!
test04HeadingWindowShouldChangeAfterARightCommand

	| marsRover window |
	
	marsRover :=  MarsRover at: 1@1 heading: #North.
	window := WindowHeading new.
	
	marsRover addMicroService: window.
	
	marsRover process: 'r'.
	
	self assert: window heading equals: #East.
	! !

!MarsRoverWindowTest methodsFor: 'test' stamp: 'FG 6/6/2021 23:01:21'!
test05PositionWindowShouldNotChangeAfterLeftCommand

	| marsRover window |
	
	marsRover :=  MarsRover at: 1@1 heading: #North.
	window := WindowPosition new.
	
	marsRover addMicroService: window.
	
	marsRover process: 'l'.
	
	self assert: window position equals: 1@1.
	! !

!MarsRoverWindowTest methodsFor: 'test' stamp: 'FG 6/6/2021 23:01:27'!
test06MarsRoverCanHaveMultiplePositionWindows

	| marsRover windowA windowB |
	
	marsRover :=  MarsRover at: 1@1 heading: #North.
	windowA := WindowPosition new.
	windowB := WindowPosition new.
	
	marsRover addMicroService: windowA.
	marsRover addMicroService: windowB.
	
	marsRover process: 'f'.
	
	self assert: windowA position equals: 1@2.
	self assert: windowB position equals: 1@2.
	! !

!MarsRoverWindowTest methodsFor: 'test' stamp: 'FG 6/6/2021 23:01:34'!
test07MarsRoverCanHaveMultipleHeadingWindows

	| marsRover windowA windowB |
	
	marsRover :=  MarsRover at: 1@1 heading: #North.
	windowA := WindowHeading new.
	windowB := WindowHeading new.
	
	marsRover addMicroService: windowA.
	marsRover addMicroService: windowB.
	
	marsRover process: 'l'.
	
	self assert: windowA heading equals: #West.
	self assert: windowB heading equals: #West.
	! !

!MarsRoverWindowTest methodsFor: 'test' stamp: 'FG 6/6/2021 23:01:38'!
test08PositionAndHeadingWindowShouldRegisterAnyCommand

	| marsRover window|
	
	marsRover :=  MarsRover at: 1@1 heading: #North.
	window := WindowPositionAndHeading new.
	
	marsRover addMicroService: window.
	
	marsRover process: 'fl'.
	
	self assert: window position equals: 1@2.
	self assert: window heading equals: #West.
	! !

!MarsRoverWindowTest methodsFor: 'test' stamp: 'FG 6/6/2021 23:01:45'!
test09MarsRoverCanHaveAnyAmountOfWindowsOfAnyType

	| marsRover windowA windowB windowC |
	
	marsRover :=  MarsRover at: 1@1 heading: #North.
	windowA := WindowPosition new.
	windowB := WindowHeading new.
	windowC := WindowPositionAndHeading  new.
	
	marsRover addMicroService: windowA.
	marsRover addMicroService: windowB.
	marsRover addMicroService: windowC.
	
	marsRover process: 'fl'.
	
	self assert: windowA position equals: 1@2.
	self assert: windowB heading equals: #West.
	
	self assert: windowC position equals: 1@2.
	self assert: windowC heading equals: #West.
	! !

!MarsRoverWindowTest methodsFor: 'test' stamp: 'FG 6/6/2021 23:20:33'!
test10PositionWindowCantAnswerForAHeading

	| marsRover window|
	
	marsRover :=  MarsRover at: 1@1 heading: #North.
	window := WindowPosition new.
	
	marsRover addMicroService: window.
	
	self should: [window heading]
		raise: Error
		withMessageText: WindowPosition cantAskForHeadingErrorSignal.! !

!MarsRoverWindowTest methodsFor: 'test' stamp: 'FG 6/6/2021 23:21:16'!
test11HeadingWindowCantAnswerForAPosition

	| marsRover window|
	
	marsRover :=  MarsRover at: 1@1 heading: #North.
	window := WindowHeading new.
	
	marsRover addMicroService: window.
	
	self should: [window position]
		raise: Error
		withMessageText: WindowPosition cantAskForPositionErrorSignal.! !


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
	instanceVariableNames: 'position head microServices'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'FG 6/6/2021 23:05:57'!
initializeAt: aPosition heading: aHeading

	microServices := OrderedCollection new.
	position := aPosition.
	head := aHeading ! !


!MarsRover methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:14:20'!
headEast
	
	head := MarsRoverHeadingEast new! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:16:30'!
headNorth
	
	head := MarsRoverHeadingNorth new! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:16:05'!
headSouth
	
	head := MarsRoverHeadingSouth new! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:14:38'!
headWest
	
	head := MarsRoverHeadingWest new! !

!MarsRover methodsFor: 'heading' stamp: 'FG 6/6/2021 23:05:25'!
rotateLeft
	
	head rotateLeft: self.
	
	microServices do:[:aMicroService | aMicroService updateHeading: head class cardinalPoint].! !

!MarsRover methodsFor: 'heading' stamp: 'FG 6/6/2021 23:05:29'!
rotateRight
	
	head rotateRight: self.
	
	microServices do:[:aMicroService | aMicroService updateHeading: head class cardinalPoint].! !


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


!MarsRover methodsFor: 'moving' stamp: 'FG 6/6/2021 23:05:40'!
moveBackward
	
	head moveBackward: self.
	
	microServices do: [:aMicroService | aMicroService updatePosition: position].! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:01'!
moveEast
	
	position := position + (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'FG 6/6/2021 23:05:35'!
moveForward
	
	head moveForward: self.
	
	microServices do: [:aMicroService | aMicroService updatePosition: position].! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:12'!
moveNorth
	
	position := position + (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:34'!
moveSouth
	
	position := position + (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:32'!
moveWest
	
	position := position + (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'FG 6/6/2021 22:45:33'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'add micro service' stamp: 'FG 6/6/2021 22:35:27'!
addMicroService: aMicroService

	aMicroService initializeWith: position and: head class cardinalPoint.
 	microServices add: aMicroService.! !

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


!classDefinition: #MicroServices category: 'MarsRover-WithHeading'!
Object subclass: #MicroServices
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MicroServices methodsFor: 'initialization' stamp: 'FG 6/6/2021 23:14:26'!
initializeWith: aPosition and: aHeading

	self subclassResponsibility.! !


!MicroServices methodsFor: 'update' stamp: 'FG 6/6/2021 23:14:38'!
updateHeading: aHeading
	self subclassResponsibility.! !

!MicroServices methodsFor: 'update' stamp: 'FG 6/6/2021 23:14:52'!
updatePosition: aPosition
	self subclassResponsibility.! !


!classDefinition: #Log category: 'MarsRover-WithHeading'!
MicroServices subclass: #Log
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Log methodsFor: 'testing' stamp: 'FG 6/3/2021 20:22:22'!
first

	^ log first.! !

!Log methodsFor: 'testing' stamp: 'FG 6/6/2021 20:39:02'!
log
	^ log copy.! !

!Log methodsFor: 'testing' stamp: 'FG 6/3/2021 20:43:03'!
second

	^ log second.! !

!Log methodsFor: 'testing' stamp: 'FG 6/3/2021 20:22:10'!
size 

	^ log size.! !


!Log methodsFor: 'initialization' stamp: 'FG 6/3/2021 20:21:37'!
initialize
	
	log := OrderedCollection new.! !

!Log methodsFor: 'initialization' stamp: 'FG 6/6/2021 22:57:11'!
initializeWith: aPosition and: aHeading! !


!Log methodsFor: 'update' stamp: 'FG 6/6/2021 23:00:02'!
updateHeading: aHeading
	self subclassResponsibility.! !

!Log methodsFor: 'update' stamp: 'FG 6/6/2021 22:59:49'!
updatePosition: aPosition
	self subclassResponsibility.! !


!classDefinition: #LogHeading category: 'MarsRover-WithHeading'!
Log subclass: #LogHeading
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!LogHeading methodsFor: 'update' stamp: 'FG 6/6/2021 22:51:06'!
updateHeading: aHeading

	log add: aHeading.! !

!LogHeading methodsFor: 'update' stamp: 'FG 6/6/2021 22:52:58'!
updatePosition: aPosition! !


!classDefinition: #LogPosition category: 'MarsRover-WithHeading'!
Log subclass: #LogPosition
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!LogPosition methodsFor: 'update' stamp: 'FG 6/6/2021 22:52:47'!
updateHeading: aHeading! !

!LogPosition methodsFor: 'update' stamp: 'FG 6/6/2021 22:47:24'!
updatePosition: aPosition

	log add: aPosition.! !


!classDefinition: #LogPositionAndHeading category: 'MarsRover-WithHeading'!
Log subclass: #LogPositionAndHeading
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!LogPositionAndHeading methodsFor: 'update' stamp: 'FG 6/6/2021 22:54:39'!
updateHeading: aHeading

	log add: aHeading.
! !

!LogPositionAndHeading methodsFor: 'update' stamp: 'FG 6/6/2021 22:54:22'!
updatePosition: aPosition

	log add: aPosition.
! !


!classDefinition: #Window category: 'MarsRover-WithHeading'!
MicroServices subclass: #Window
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Window methodsFor: 'initialization' stamp: 'FG 6/6/2021 23:03:44'!
initializeWith: aPosition and: aHeading
	
	self subclassResponsibility.! !


!Window methodsFor: 'update' stamp: 'FG 6/6/2021 22:13:11'!
updateHeading: aHeading
	self subclassResponsibility.! !

!Window methodsFor: 'update' stamp: 'FG 6/6/2021 22:13:28'!
updatePosition: aPosition
	self subclassResponsibility.! !


!Window methodsFor: 'testing' stamp: 'FG 6/6/2021 23:09:11'!
heading
	self subclassResponsibility.! !

!Window methodsFor: 'testing' stamp: 'FG 6/6/2021 23:09:04'!
position

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Window class' category: 'MarsRover-WithHeading'!
Window class
	instanceVariableNames: ''!

!Window class methodsFor: 'error signal' stamp: 'FG 6/6/2021 23:11:27'!
cantAskForHeadingErrorSignal

 	^ 'Error - Can not answer heading'! !

!Window class methodsFor: 'error signal' stamp: 'FG 6/6/2021 23:11:08'!
cantAskForPositionErrorSignal

 	^ 'Error - Can not answer position'! !


!classDefinition: #WindowHeading category: 'MarsRover-WithHeading'!
Window subclass: #WindowHeading
	instanceVariableNames: 'heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!WindowHeading methodsFor: 'initialization' stamp: 'FG 6/6/2021 23:03:44'!
initializeWith: aPosition and: aHeading

	heading := aHeading.! !


!WindowHeading methodsFor: 'update' stamp: 'FG 6/6/2021 22:06:46'!
updateHeading: aHeading
	heading := aHeading.! !

!WindowHeading methodsFor: 'update' stamp: 'FG 6/6/2021 22:13:45'!
updatePosition: aPosition
! !


!WindowHeading methodsFor: 'testing' stamp: 'FG 6/6/2021 22:06:31'!
heading
	^ heading.
! !

!WindowHeading methodsFor: 'testing' stamp: 'FG 6/6/2021 23:12:24'!
position
	
	self error: self class cantAskForPositionErrorSignal.! !


!classDefinition: #WindowPosition category: 'MarsRover-WithHeading'!
Window subclass: #WindowPosition
	instanceVariableNames: 'position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!WindowPosition methodsFor: 'initialization' stamp: 'FG 6/6/2021 23:03:44'!
initializeWith: aPosition and: aHeading

	position := aPosition.! !


!WindowPosition methodsFor: 'update' stamp: 'FG 6/6/2021 22:13:55'!
updateHeading: aHeading! !

!WindowPosition methodsFor: 'update' stamp: 'FG 6/6/2021 22:02:14'!
updatePosition: aPosition

	position := aPosition.! !


!WindowPosition methodsFor: 'testing' stamp: 'FG 6/6/2021 23:13:16'!
heading

	self error: self class cantAskForHeadingErrorSignal.! !

!WindowPosition methodsFor: 'testing' stamp: 'FG 6/6/2021 21:03:35'!
position
	^ position.! !


!classDefinition: #WindowPositionAndHeading category: 'MarsRover-WithHeading'!
Window subclass: #WindowPositionAndHeading
	instanceVariableNames: 'position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!WindowPositionAndHeading methodsFor: 'update' stamp: 'FG 6/6/2021 22:30:09'!
updateHeading: aHeading

	heading := aHeading.! !

!WindowPositionAndHeading methodsFor: 'update' stamp: 'FG 6/6/2021 22:29:52'!
updatePosition: aPosition

	position := aPosition.! !


!WindowPositionAndHeading methodsFor: 'testing' stamp: 'FG 6/6/2021 22:29:29'!
heading
	^ heading.! !

!WindowPositionAndHeading methodsFor: 'testing' stamp: 'FG 6/6/2021 22:29:21'!
position
	^ position! !


!WindowPositionAndHeading methodsFor: 'initialization' stamp: 'FG 6/6/2021 23:03:44'!
initializeWith: aPosition and: aHeading

	position := aPosition.
	heading := aHeading.! !
