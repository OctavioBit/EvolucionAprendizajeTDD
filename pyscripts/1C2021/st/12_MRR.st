!classDefinition: #MarsRoverLogTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverLogTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogTest methodsFor: 'tests' stamp: 'jdc 6/7/2021 16:44:57'!
test01logForwardNorthSuccesfully
	| log marsrover |
	log := MarsRoverLog initialize.
	marsrover := MarsRover at: 1@1 heading: #North withDataRecordingDevice: log.
	
	
	marsrover process: 'f'.
	
	self assert: 1 equals: log size.
	self assert: '1@2' equals: log first.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'jdc 6/7/2021 16:45:19'!
test02logBackwardsNorthSuccesfully
	| log marsrover |
	log := MarsRoverLog initialize.
	marsrover := MarsRover at: 1@1 heading: #North withDataRecordingDevice: log.
	
	marsrover process: 'b'.
	
	self assert: 1 equals: log size.
	self assert: '1@0' equals: log first.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'jdc 6/7/2021 16:46:02'!
test03logForwardSouthSuccesfully
	| log marsrover |
	log := MarsRoverLog initialize.
	marsrover := MarsRover at: 1@1 heading: #South withDataRecordingDevice: log.
	
	marsrover process: 'f'.
	
	self assert: 1 equals: log size.
	self assert: '1@0' equals: log first.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'jdc 6/7/2021 16:46:10'!
test04logForwardEastSuccesfully
	| log marsrover |
	log := MarsRoverLog initialize.
	marsrover := MarsRover at: 1@1 heading: #East withDataRecordingDevice: log.
	
	marsrover process: 'f'.
	
	self assert: 1 equals: log size.
	self assert: '2@1' equals: log first.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'jdc 6/7/2021 16:58:07'!
test05logTurnRightFromNorthSuccesfully
	| log marsrover |
	log := MarsRoverLog initialize.
	marsrover := MarsRover at: 1@1 heading: #North withDataRecordingDevice: log.
	
	marsrover process: 'r'.
	
	self assert: 1 equals: log size.
	self assert: 'East' equals: log first.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'jdc 6/7/2021 16:58:10'!
test06logTurnLeftFromNorthSuccesfully
	| log marsrover |
	log := MarsRoverLog initialize.
	marsrover := MarsRover at: 1@1 heading: #North withDataRecordingDevice: log.
	
	marsrover process: 'l'.
	
	self assert: 1 equals: log size.
	self assert: 'West' equals: log first.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'jdc 6/7/2021 16:58:17'!
test07logTurnLeftTwoTimesFromNorth
	| log marsrover |
	log := MarsRoverLog initialize.
	marsrover := MarsRover at: 1@1 heading: #North withDataRecordingDevice: log.
	
	marsrover process: 'll'.
	
	self assert: 2 equals: log size.
	self assert: 'West' equals: log first.
	self assert: 'South' equals: log second.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'jdc 6/7/2021 16:58:22'!
test08logTurnLeftTwoTimesAndAdvancesForwardFromNorth
	| log marsrover |
	log := MarsRoverLog initialize.
	marsrover := MarsRover at: 1@1 heading: #North withDataRecordingDevice: log.
	
	marsrover process: 'llf'.
	
	self assert: 3 equals: log size.
	self assert: 'West' equals: log first.
	self assert: 'South' equals: log second.
	self assert: '1@0' equals: log third.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'jdc 6/7/2021 16:48:49'!
test09windowShowsCurrentPositionAfterForward
	| window marsrover |
	window := MarsRoverWindow initialize.
	marsrover := MarsRover at: 1@1 heading: #North withDataRecordingDevice: window.
	
	marsrover process: 'f'.
	
	"self assert: 'Mars Rover heading North' equals: window getMarsRoverHeading."
	self assert: '1@2' equals: window getCurrentPosition.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'jdc 6/7/2021 16:48:57'!
test10windowShowsCurrentHeading
	| window marsrover |
	window := MarsRoverWindow initialize.
	marsrover := MarsRover at: 1@1 heading: #North withDataRecordingDevice: window.
	
	self assert: 'Mars Rover heading North' equals: window getMarsRoverHeading.
	"self assert: '1@2' equals: window getCurrentPosition."! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'jdc 6/7/2021 16:49:17'!
test11windowShowsCurrentHeadingAfterTurningLeft
	| window marsrover |
	window := MarsRoverWindow initialize.
	marsrover := MarsRover at: 1@1 heading: #North withDataRecordingDevice: window.
	
	marsrover process: 'l'.
	
	self assert: 'Mars Rover heading West' equals: window getMarsRoverHeading.
	"self assert: '1@2' equals: window getCurrentPosition."! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'jdc 6/7/2021 16:49:20'!
test12windowShowsCurrentHeadingAfterTurningRight
	| window marsrover |
	window := MarsRoverWindow initialize.
	marsrover := MarsRover at: 1@1 heading: #North withDataRecordingDevice: window.
	
	marsrover process: 'r'.
	
	self assert: 'Mars Rover heading East' equals: window getMarsRoverHeading.
	"self assert: '1@2' equals: window getCurrentPosition."! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'jdc 6/7/2021 16:49:23'!
test13windowShowsCurrentPositionAfterBack
	| window marsrover |
	window := MarsRoverWindow initialize.
	marsrover := MarsRover at: 1@1 heading: #North withDataRecordingDevice: window.
	
	marsrover process: 'b'.
	
	"self assert: 'Mars Rover heading North' equals: window getMarsRoverHeading."
	self assert: '1@0' equals: window getCurrentPosition.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'jdc 6/7/2021 16:48:14'!
test14logRetrieveCommandAtFifthPlace
	| log marsrover |
	log := MarsRoverLog initialize.
	marsrover := MarsRover at: 1@1 heading: #North withDataRecordingDevice: log.
	
	marsrover process: 'fffff'.
	
	self assert: 5 equals: log size.
	self assert: '1@6' equals: (log at: 5).! !


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


!classDefinition: #DataRecordingDevice category: 'MarsRover-WithHeading'!
Object subclass: #DataRecordingDevice
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!


!classDefinition: #MarsRoverLog category: 'MarsRover-WithHeading'!
DataRecordingDevice subclass: #MarsRoverLog
	instanceVariableNames: 'collectionLog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLog methodsFor: 'initialization' stamp: 'jdc 6/7/2021 16:25:22'!
initializeWithCollectionLog: anOrderedCollection

	collectionLog := anOrderedCollection.! !

!MarsRoverLog methodsFor: 'initialization' stamp: 'jdc 6/7/2021 16:55:30'!
setCurrentHeading: aPosition
! !

!MarsRoverLog methodsFor: 'initialization' stamp: 'jdc 6/7/2021 16:55:24'!
setCurrentPosition: aPosition
! !


!MarsRoverLog methodsFor: 'indexing' stamp: 'jdc 6/7/2021 16:30:45'!
at: aNumber
	^collectionLog at: aNumber.! !

!MarsRoverLog methodsFor: 'indexing' stamp: 'jdc 6/7/2021 16:28:02'!
first
	^collectionLog first.! !

!MarsRoverLog methodsFor: 'indexing' stamp: 'jdc 6/7/2021 16:28:23'!
second
	^collectionLog second.! !

!MarsRoverLog methodsFor: 'indexing' stamp: 'jdc 6/7/2021 16:28:37'!
third
	^collectionLog third.! !


!MarsRoverLog methodsFor: 'size' stamp: 'jdc 6/7/2021 16:27:08'!
size
	^collectionLog size.! !


!MarsRoverLog methodsFor: 'logging' stamp: 'jdc 6/7/2021 16:22:55'!
add: aString 
	collectionLog add: aString.! !

!MarsRoverLog methodsFor: 'logging' stamp: 'jdc 6/3/2021 21:29:14'!
addHeadingString: aMarsRoverHeading

	self add: (String streamContents: [ :str | str nextPutAll: 'Mars Rover heading '; nextPutAll: aMarsRoverHeading.]).! !

!MarsRoverLog methodsFor: 'logging' stamp: 'jdc 6/7/2021 16:53:55'!
logHeading: aHead 
	collectionLog add: aHead headingAsString.! !

!MarsRoverLog methodsFor: 'logging' stamp: 'jdc 6/7/2021 16:36:02'!
logPosition: aPosition

	collectionLog add: aPosition printString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverLog class' category: 'MarsRover-WithHeading'!
MarsRoverLog class
	instanceVariableNames: ''!

!MarsRoverLog class methodsFor: 'as yet unclassified' stamp: 'jdc 6/7/2021 16:24:09'!
initialize

	^(MarsRoverLog new) initializeWithCollectionLog: OrderedCollection new! !


!classDefinition: #MarsRoverWindow category: 'MarsRover-WithHeading'!
DataRecordingDevice subclass: #MarsRoverWindow
	instanceVariableNames: 'currentPosition currentHeading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindow methodsFor: 'accessing' stamp: 'jdc 6/7/2021 16:41:52'!
getCurrentPosition
	^currentPosition asString.! !

!MarsRoverWindow methodsFor: 'accessing' stamp: 'jdc 6/7/2021 16:41:46'!
getMarsRoverHeading
	^String streamContents: [:str | 
		str nextPutAll: 'Mars Rover heading '; 
		nextPutAll: (currentHeading headingAsString)
		].! !


!MarsRoverWindow methodsFor: 'window' stamp: 'jdc 6/7/2021 16:56:44'!
logHeading: aHeading
	currentHeading := aHeading.! !

!MarsRoverWindow methodsFor: 'window' stamp: 'jdc 6/7/2021 16:42:26'!
logPosition: aPoint 
	currentPosition := aPoint.! !


!MarsRoverWindow methodsFor: 'initialization' stamp: 'jdc 6/7/2021 16:50:06'!
initialize
! !

!MarsRoverWindow methodsFor: 'initialization' stamp: 'jdc 6/7/2021 16:56:06'!
setCurrentHeading: aPosition.

	currentHeading := aPosition.
! !

!MarsRoverWindow methodsFor: 'initialization' stamp: 'jdc 6/7/2021 16:55:58'!
setCurrentPosition: aPosition.

	currentPosition := aPosition.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverWindow class' category: 'MarsRover-WithHeading'!
MarsRoverWindow class
	instanceVariableNames: ''!

!MarsRoverWindow class methodsFor: 'initialization' stamp: 'jdc 6/7/2021 16:50:17'!
initialize

	^self new.! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head log window dataRecordingDevice'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'HAW 8/22/2019 12:02:37'!
initializeAt: aPosition heading: aHeading

	position := aPosition.
	head := aHeading ! !

!MarsRover methodsFor: 'initialization' stamp: 'jdc 6/7/2021 16:55:01'!
initializeAt: aPosition heading: aHeading withDataRecordingDevice: aDataRecordingDevice

	position := aPosition.
	head := aHeading.
	dataRecordingDevice := aDataRecordingDevice.
	dataRecordingDevice setCurrentPosition: position.
	dataRecordingDevice setCurrentHeading: head.! !


!MarsRover methodsFor: 'heading' stamp: 'jdc 6/7/2021 16:52:13'!
headEast
	
	head := MarsRoverHeadingEast new.
	dataRecordingDevice logHeading: head.
	"(log class = MarsRoverLog) ifTrue: [log addHeadingString: head headingAsString].
	(window class = MarsRoverWindow) ifTrue: []."! !

!MarsRover methodsFor: 'heading' stamp: 'jdc 6/7/2021 16:52:22'!
headNorth
	
	head := MarsRoverHeadingNorth new.
	dataRecordingDevice logHeading: head.! !

!MarsRover methodsFor: 'heading' stamp: 'jdc 6/7/2021 16:52:26'!
headSouth
	
	head := MarsRoverHeadingSouth new.
		dataRecordingDevice logHeading: head.! !

!MarsRover methodsFor: 'heading' stamp: 'jdc 6/7/2021 16:52:29'!
headWest
	
	head := MarsRoverHeadingWest new.
		dataRecordingDevice logHeading: head.! !

!MarsRover methodsFor: 'heading' stamp: 'jdc 6/7/2021 16:33:15'!
rotateLeft
	
	head rotateLeft: self.
	! !

!MarsRover methodsFor: 'heading' stamp: 'jdc 6/7/2021 16:33:34'!
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


!MarsRover methodsFor: 'moving' stamp: 'jdc 6/7/2021 16:32:22'!
moveBackward
	
	head moveBackward: self.! !

!MarsRover methodsFor: 'moving' stamp: 'jdc 6/7/2021 16:34:25'!
moveEast
	
	position := position + (1@0).
	dataRecordingDevice logPosition: position.! !

!MarsRover methodsFor: 'moving' stamp: 'jdc 6/7/2021 16:32:48'!
moveForward
	
	head moveForward: self.! !

!MarsRover methodsFor: 'moving' stamp: 'jdc 6/7/2021 16:34:48'!
moveNorth
	
	position := position + (0@1).
	dataRecordingDevice logPosition: position.! !

!MarsRover methodsFor: 'moving' stamp: 'jdc 6/7/2021 16:35:21'!
moveSouth
	
	position := position + (0@-1).
	dataRecordingDevice logPosition: position.! !

!MarsRover methodsFor: 'moving' stamp: 'jdc 6/7/2021 16:36:20'!
moveWest
	
	position := position + (-1@0).
	dataRecordingDevice logPosition: position.! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'jdc 6/3/2021 21:01:23'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'accessing' stamp: 'jdc 6/7/2021 16:01:29'!
getCurrentHeading
	^head.! !

!MarsRover methodsFor: 'accessing' stamp: 'jdc 6/7/2021 15:56:59'!
getCurrentPosition
	^position! !


!MarsRover methodsFor: 'recordingDevices' stamp: 'jdc 6/7/2021 16:37:44'!
addDataRecordingDevice: aDataRecordingDevice
	dataRecordingDevice := aDataRecordingDevice.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 8/22/2019 12:01:48'!
at: aPosition heading: aCardinalPoint
	
	^self new initializeAt: aPosition heading: (MarsRoverHeading heading: aCardinalPoint)! !

!MarsRover class methodsFor: 'instance creation' stamp: 'jdc 6/7/2021 16:44:28'!
at: aPosition heading: aCardinalPoint withDataRecordingDevice: aDataRecordingDevice
	
	^self new initializeAt: aPosition heading: (MarsRoverHeading heading: aCardinalPoint) withDataRecordingDevice: aDataRecordingDevice.! !

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 7/2/2018 16:26:14'!
invalidCardinalPointErrorDescription
	
	^'Invalid cardinal point'! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'jdc 6/3/2021 21:19:36'!
headingAsString

	self subclassResponsibility.! !

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


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'jdc 6/3/2021 21:19:57'!
headingAsString

	^'East'.! !

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


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'jdc 6/3/2021 21:20:14'!
headingAsString

	^'North'.! !

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


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'jdc 6/3/2021 21:20:23'!
headingAsString

	^'South'.! !

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


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'jdc 6/3/2021 21:20:30'!
headingAsString

	^'West'.! !

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

MarsRoverLog initialize!
MarsRoverWindow initialize!