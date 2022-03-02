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


!classDefinition: #MonitoringTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MonitoringTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MonitoringTest methodsFor: 'tests' stamp: 'LM 6/7/2021 10:38:50'!
test01logDoesntChangeUntilCommandsAreProcessed

	| log marsRover |
	
	marsRover := MarsRover at: 0@0 heading: #North.
	log := Log new.
	
	marsRover addMonitorToPosition: log.
	marsRover addMonitorToHeading: log.
	
	self assert: log isEmpty.! !

!MonitoringTest methodsFor: 'tests' stamp: 'LM 6/7/2021 11:08:45'!
test02logRegistersForwardMovement

	| log marsRover logLines |
	
	marsRover := MarsRover at: 0@0 heading: #North.
	log := Log new.
	
	marsRover addMonitorToPosition: log.
	
	marsRover process: 'f'.
	
	logLines := log getLines.	
	self assert: 1 equals: logLines size.
	self assert: '0@1' equals: logLines first.! !

!MonitoringTest methodsFor: 'tests' stamp: 'LM 6/7/2021 11:09:06'!
test03logRegistersBackwardMovement

	| log marsRover logLines |
	
	marsRover := MarsRover at: 0@0 heading: #North.
	log := Log new.
	
	marsRover addMonitorToPosition: log.
	
	marsRover process: 'b'.
	
	logLines := log getLines.	
	self assert: 1 equals: logLines size.
	self assert: '0@-1' equals: logLines first.! !

!MonitoringTest methodsFor: 'tests' stamp: 'LM 6/7/2021 11:09:24'!
test04logRegistersClockwiseRotationToEast

	| log marsRover logLines |
	
	marsRover := MarsRover at: 0@0 heading: #North.
	log := Log new.
	
	marsRover addMonitorToHeading: log.
	
	marsRover process: 'r'.
	
	logLines := log getLines.	
	self assert: 1 equals: logLines size.
	self assert: 'Apuntando al este' equals: logLines first.! !

!MonitoringTest methodsFor: 'tests' stamp: 'LM 6/7/2021 11:09:37'!
test05logRegistersAnticlockwiseRotationToWest

	| log marsRover logLines |
	
	marsRover := MarsRover at: 0@0 heading: #North.
	log := Log new.
	
	marsRover addMonitorToHeading: log.
	
	marsRover process: 'l'.
	
	logLines := log getLines.	
	self assert: 1 equals: logLines size.
	self assert: 'Apuntando al oeste' equals: logLines first.! !

!MonitoringTest methodsFor: 'tests' stamp: 'LM 6/7/2021 11:09:52'!
test06logRegistersClockwiseRotationToSouth

	| log marsRover logLines |
	
	marsRover := MarsRover at: 0@0 heading: #East.
	log := Log new.
	
	marsRover addMonitorToHeading: log.
	
	marsRover process: 'r'.
	
	logLines := log getLines.	
	self assert: 1 equals: logLines size.
	self assert: 'Apuntando al sur' equals: logLines first.! !

!MonitoringTest methodsFor: 'tests' stamp: 'LM 6/7/2021 11:10:11'!
test07logRegistersAnticlockwiseRotationToNorth

	| log marsRover logLines |
	
	marsRover := MarsRover at: 0@0 heading: #East.
	log := Log new.
	
	marsRover addMonitorToHeading: log.
	
	marsRover process: 'l'.
	
	logLines := log getLines.	
	self assert: 1 equals: logLines size.
	self assert: 'Apuntando al norte' equals: logLines first.! !

!MonitoringTest methodsFor: 'tests' stamp: 'LM 6/7/2021 10:39:30'!
test08windowDoesntChangeUntilCommandsAreProcessed

	| window marsRover |
	
	marsRover := MarsRover at: 0@0 heading: #North.
	window := MonitoringWindow new.
	
	marsRover addMonitorToPosition: window.
	marsRover addMonitorToHeading: window.
	
	self assert: window positionTextFieldModel isNil.
	self assert: window headingTextFieldModel isNil.! !

!MonitoringTest methodsFor: 'tests' stamp: 'LM 6/7/2021 10:49:53'!
test09windowRegistersForwardMovement

	| window marsRover |
	
	marsRover := MarsRover at: 0@0 heading: #East.
	window := MonitoringWindow new.
	
	marsRover addMonitorToPosition: window.
	
	marsRover process: 'f'.
	
	self assert: 1@0 equals: window positionTextFieldModel.! !

!MonitoringTest methodsFor: 'tests' stamp: 'LM 6/7/2021 10:50:18'!
test10windowRegistersClockwiseRotationToEast

	| window marsRover |
	
	marsRover := MarsRover at: 0@0 heading: #North.
	window := MonitoringWindow new.
	
	marsRover addMonitorToHeading: window.
	
	marsRover process: 'r'.
	
	self assert: 'Este' equals: window headingTextFieldModel.! !

!MonitoringTest methodsFor: 'tests' stamp: 'LM 6/7/2021 10:51:25'!
test11windowRegistersAnticlockwiseRotationToWest

	| window marsRover |
	
	marsRover := MarsRover at: 0@0 heading: #North.
	window := MonitoringWindow new.
	
	marsRover addMonitorToHeading: window.
	
	marsRover process: 'l'.
	
	self assert: 'Oeste' equals: window headingTextFieldModel.! !

!MonitoringTest methodsFor: 'tests' stamp: 'LM 6/7/2021 10:52:33'!
test12windowRegistersClockwiseRotationToSouth

	| window marsRover |
	
	marsRover := MarsRover at: 0@0 heading: #East.
	window := MonitoringWindow new.
	
	marsRover addMonitorToHeading: window.
	
	marsRover process: 'r'.
	
	self assert: 'Sur' equals: window headingTextFieldModel.! !

!MonitoringTest methodsFor: 'tests' stamp: 'LM 6/7/2021 10:53:34'!
test13windowRegistersAnticlockwiseRotationToNorth

	| window marsRover |
	
	marsRover := MarsRover at: 0@0 heading: #East.
	window := MonitoringWindow new.
	
	marsRover addMonitorToHeading: window.
	
	marsRover process: 'l'.
	
	self assert: 'Norte' equals: window headingTextFieldModel.! !


!classDefinition: #Log category: 'MarsRover-WithHeading'!
Object subclass: #Log
	instanceVariableNames: 'contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Log methodsFor: 'initialization' stamp: 'LM 6/6/2021 19:27:23'!
initialize

	contents := OrderedCollection new.! !


!Log methodsFor: 'monitoring - heading' stamp: 'LM 6/7/2021 10:21:15'!
headingChangedTo: aMarsRoverHeading

	aMarsRoverHeading reportTo: self.! !

!Log methodsFor: 'monitoring - heading' stamp: 'LM 6/7/2021 10:19:30'!
registerEast

	contents add: 'Apuntando al este'.! !

!Log methodsFor: 'monitoring - heading' stamp: 'LM 6/7/2021 10:19:22'!
registerNorth

	contents add: 'Apuntando al norte'.! !

!Log methodsFor: 'monitoring - heading' stamp: 'LM 6/7/2021 10:19:39'!
registerSouth

	contents add: 'Apuntando al sur'.! !

!Log methodsFor: 'monitoring - heading' stamp: 'LM 6/7/2021 10:19:47'!
registerWest

	contents add: 'Apuntando al oeste'.! !


!Log methodsFor: 'monitoring - position' stamp: 'LM 6/6/2021 19:57:59'!
positionChangedTo: aPosition

	contents add: aPosition asString.! !


!Log methodsFor: 'testing' stamp: 'LM 6/6/2021 20:32:42'!
isEmpty

	^contents isEmpty! !


!Log methodsFor: 'accessing' stamp: 'LM 6/7/2021 11:12:34'!
getLines

	^contents copy! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head positionMonitors headingMonitors'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'LM 6/7/2021 10:02:30'!
initializeAt: aPosition heading: aHeading

	position := aPosition.
	head := aHeading.
	positionMonitors := OrderedCollection new.
	headingMonitors := OrderedCollection new.! !


!MarsRover methodsFor: 'heading' stamp: 'LM 6/7/2021 10:01:46'!
changeHeadTo: aMarsRoverHeading

	head := aMarsRoverHeading.
	headingMonitors do: [ :headingMonitor | headingMonitor headingChangedTo: head ].! !

!MarsRover methodsFor: 'heading' stamp: 'LM 6/7/2021 10:32:46'!
headEast

	self changeHeadTo: MarsRoverHeadingEast new.! !

!MarsRover methodsFor: 'heading' stamp: 'LM 6/7/2021 10:32:56'!
headNorth

	self changeHeadTo: MarsRoverHeadingNorth new.! !

!MarsRover methodsFor: 'heading' stamp: 'LM 6/7/2021 10:33:05'!
headSouth

	self changeHeadTo: MarsRoverHeadingSouth new.! !

!MarsRover methodsFor: 'heading' stamp: 'LM 6/7/2021 10:33:14'!
headWest

	self changeHeadTo: MarsRoverHeadingWest new.! !

!MarsRover methodsFor: 'heading' stamp: 'LM 6/7/2021 09:53:55'!
rotateLeft
	
	head rotateLeft: self.! !

!MarsRover methodsFor: 'heading' stamp: 'LM 6/7/2021 09:53:58'!
rotateRight
	
	head rotateRight: self.! !


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


!MarsRover methodsFor: 'moving' stamp: 'LM 6/7/2021 09:59:22'!
changePositionTo: aPosition

	position := aPosition.
	positionMonitors do: [ :positionMonitor | positionMonitor positionChangedTo: position ].! !

!MarsRover methodsFor: 'moving' stamp: 'LM 6/6/2021 20:51:08'!
moveBackward
	
	head moveBackward: self.! !

!MarsRover methodsFor: 'moving' stamp: 'LM 6/6/2021 20:51:42'!
moveEast
	
	self changePositionTo: position + (1@0).! !

!MarsRover methodsFor: 'moving' stamp: 'LM 6/6/2021 20:51:11'!
moveForward
	
	head moveForward: self.! !

!MarsRover methodsFor: 'moving' stamp: 'LM 6/6/2021 20:51:50'!
moveNorth
	
	self changePositionTo: position + (0@1).! !

!MarsRover methodsFor: 'moving' stamp: 'LM 6/6/2021 20:52:03'!
moveSouth
	
	self changePositionTo: position + (0@-1).! !

!MarsRover methodsFor: 'moving' stamp: 'LM 6/6/2021 20:52:11'!
moveWest
	
	self changePositionTo: position + (-1@0).! !


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


!MarsRover methodsFor: 'monitoring' stamp: 'LM 6/7/2021 10:05:22'!
addMonitorToHeading: aHeadingMonitor 

	headingMonitors add: aHeadingMonitor.! !

!MarsRover methodsFor: 'monitoring' stamp: 'LM 6/7/2021 10:05:50'!
addMonitorToPosition: aPositionMonitor 

	positionMonitors add: aPositionMonitor.! !

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


!MarsRoverHeading methodsFor: 'monitoring' stamp: 'LM 6/7/2021 10:23:07'!
reportTo: aHeadingMonitor

	self subclassResponsibility! !


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


!MarsRoverHeadingEast methodsFor: 'monitoring' stamp: 'LM 6/7/2021 10:23:31'!
reportTo: aHeadingMonitor

	aHeadingMonitor registerEast.! !

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


!MarsRoverHeadingNorth methodsFor: 'monitoring' stamp: 'LM 6/7/2021 10:23:42'!
reportTo: aHeadingMonitor

	aHeadingMonitor registerNorth.! !

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


!MarsRoverHeadingSouth methodsFor: 'monitoring' stamp: 'LM 6/7/2021 10:23:52'!
reportTo: aHeadingMonitor

	aHeadingMonitor registerSouth.! !

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


!MarsRoverHeadingWest methodsFor: 'monitoring' stamp: 'LM 6/7/2021 10:24:03'!
reportTo: aHeadingMonitor

	aHeadingMonitor registerWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingWest class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingWest class
	instanceVariableNames: ''!

!MarsRoverHeadingWest class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:23'!
cardinalPoint

	^#West! !


!classDefinition: #MonitoringWindow category: 'MarsRover-WithHeading'!
Object subclass: #MonitoringWindow
	instanceVariableNames: 'positionTextFieldModel headingTextFieldModel'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MonitoringWindow methodsFor: 'monitoring - heading' stamp: 'LM 6/7/2021 10:26:19'!
headingChangedTo: aMarsRoverHeading 

	aMarsRoverHeading reportTo: self.! !

!MonitoringWindow methodsFor: 'monitoring - heading' stamp: 'LM 6/7/2021 10:25:43'!
registerEast

	headingTextFieldModel := 'Este'.! !

!MonitoringWindow methodsFor: 'monitoring - heading' stamp: 'LM 6/7/2021 10:25:12'!
registerNorth

	headingTextFieldModel := 'Norte'.! !

!MonitoringWindow methodsFor: 'monitoring - heading' stamp: 'LM 6/7/2021 10:26:00'!
registerSouth

	headingTextFieldModel := 'Sur'.! !

!MonitoringWindow methodsFor: 'monitoring - heading' stamp: 'LM 6/7/2021 10:25:51'!
registerWest

	headingTextFieldModel := 'Oeste'.! !


!MonitoringWindow methodsFor: 'monitoring - position' stamp: 'LM 6/7/2021 09:30:50'!
positionChangedTo: aPosition 

	positionTextFieldModel := aPosition.! !


!MonitoringWindow methodsFor: 'accessing' stamp: 'LM 6/7/2021 09:38:54'!
headingTextFieldModel

	^headingTextFieldModel! !

!MonitoringWindow methodsFor: 'accessing' stamp: 'LM 6/7/2021 09:29:18'!
positionTextFieldModel

	^positionTextFieldModel! !
