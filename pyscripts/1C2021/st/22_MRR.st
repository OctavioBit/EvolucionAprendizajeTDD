!classDefinition: #MarsRoverLogTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverLogTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogTest methodsFor: 'tests' stamp: 'DOO 6/7/2021 00:46:53'!
test01RegularLogPrintsOneActionWithOnlyOneActionExecuted

	|marsRover log|
	
	marsRover  := MarsRover at: 2@0 heading: #North.
	log := ExecutionLog generateLogger.
	
	marsRover addLog: log.
	marsRover process:'f'.
	
	self assert: (log printLog) equals: (OrderedCollection with: '2@1').! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'DOO 6/7/2021 00:46:53'!
test02RegularLogPrintsThreeActionsWithThreeActionsExecuted

	|marsRover log|
	
	marsRover  := MarsRover at: 2@0 heading: #North.
	log := ExecutionLog generateLogger.
	
	marsRover addLog: log.
	marsRover process:'ffb'.
	
	self assert: (log printLog) equals: (OrderedCollection with: '2@1' with: '2@2' with: '2@1'). ! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'DOO 6/7/2021 00:46:53'!
test03RegularLogPrintsEveryActionAtLeastOnce

	|marsRover log actionList|
	
	marsRover  := MarsRover at: 2@0 heading: #North.
	log := ExecutionLog generateLogger.
	actionList:=OrderedCollection with: '2@1' with: '2@2' with: '2@1'with: 'Now heading East'with: 'Now heading South'with: 'Now heading East'.
	marsRover addLog: log.
	marsRover process:'ffbrrl'.
	
	self assert: (log printLog) equals: actionList. ! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'DOO 6/7/2021 02:01:04'!
test04WindowLogPrintsOneActionWithOnlyOneActionExecuted

	|marsRover log|
	
	marsRover  := MarsRover at: 2@0 heading: #North.
	log := WindowLog generateLogger.
	
	marsRover addLog: log.
	marsRover process:'f'.
	
	self assert: (log printLog) equals: 'Currently on 2@1, Now heading North'.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'DOO 6/7/2021 01:27:45'!
test05WindowLogPrintsOnlyLastStateWithEveryActionExecuted

	|marsRover log|
	
	marsRover  := MarsRover at: 2@0 heading: #North.
	log := WindowLog generateLogger.
	marsRover addLog: log.
	marsRover process:'ffbrrl'.
	
	self assert: (log printLog) equals: 'Currently on 2@1, Now heading East'. ! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'DOO 6/7/2021 01:51:48'!
test06MarsRoverCanAcceptMoreThanOneLog

	| marsRover log log2 actionList |
	
	marsRover  := MarsRover at: 2@0 heading: #North.
	log := ExecutionLog generateLogger.
	log2 := WindowLog generateLogger.
	actionList:=OrderedCollection with: '2@1' with: '2@2' with: '2@1'with: 'Now heading East'with: 'Now heading South'with: 'Now heading East'.
	
	marsRover addLog: log.
	marsRover addLog: log2.
	marsRover process:'ffbrrl'.
	
	self assert: (log printLog) equals: actionList. 
	self assert: (log2 printLog) equals: 'Currently on 2@1, Now heading East'. ! !


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


!classDefinition: #BaseLog category: 'MarsRover-WithHeading'!
Object subclass: #BaseLog
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!BaseLog methodsFor: 'as yet unclassified' stamp: 'DOO 6/7/2021 02:12:58'!
printLog
	^self subclassResponsibility.! !

!BaseLog methodsFor: 'as yet unclassified' stamp: 'DOO 6/7/2021 02:13:55'!
saveDirection: aString
	^self subclassResponsibility.! !

!BaseLog methodsFor: 'as yet unclassified' stamp: 'DOO 6/7/2021 02:14:20'!
saveMovement: aString 
	^self subclassResponsibility.! !

!BaseLog methodsFor: 'as yet unclassified' stamp: 'DOO 6/7/2021 02:14:50'!
updateIfNeededWith: aPoint and: aSymbol 
	^self subclassResponsibility.! !


!classDefinition: #ExecutionLog category: 'MarsRover-WithHeading'!
BaseLog subclass: #ExecutionLog
	instanceVariableNames: 'loggedData'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!ExecutionLog methodsFor: 'logging' stamp: 'DOO 6/6/2021 23:59:36'!
printLog
	^loggedData.! !


!ExecutionLog methodsFor: 'initialization' stamp: 'DOO 6/6/2021 23:59:27'!
initialize
	loggedData := OrderedCollection new.! !


!ExecutionLog methodsFor: 'storing' stamp: 'DOO 6/7/2021 00:21:12'!
save: aString 
	loggedData add:aString.! !

!ExecutionLog methodsFor: 'storing' stamp: 'DOO 6/7/2021 01:57:07'!
saveDirection: aString 
	self save: 'Now heading ',aString.! !

!ExecutionLog methodsFor: 'storing' stamp: 'DOO 6/7/2021 01:08:31'!
saveMovement: aString 
	self save: aString.! !


!ExecutionLog methodsFor: 'as yet unclassified' stamp: 'DOO 6/7/2021 01:32:53'!
updateIfNeededWith: aPoint and: aSymbol! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ExecutionLog class' category: 'MarsRover-WithHeading'!
ExecutionLog class
	instanceVariableNames: ''!

!ExecutionLog class methodsFor: 'instance creation' stamp: 'DOO 6/7/2021 00:46:53'!
generateLogger
	^ExecutionLog new initialize.! !


!classDefinition: #WindowLog category: 'MarsRover-WithHeading'!
BaseLog subclass: #WindowLog
	instanceVariableNames: 'actualPosition actualOrientation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!WindowLog methodsFor: 'initialization' stamp: 'DOO 6/7/2021 00:51:07'!
initializeGenerateLogger
	actualPosition :=''.
	actualOrientation :=''.! !



!WindowLog methodsFor: 'as yet unclassified' stamp: 'DOO 6/7/2021 01:57:49'!
printLog
	^'Currently on ',actualPosition,', Now heading ',actualOrientation.! !

!WindowLog methodsFor: 'as yet unclassified' stamp: 'DOO 6/7/2021 01:17:45'!
saveDirection: aString 
	actualOrientation :=aString.! !

!WindowLog methodsFor: 'as yet unclassified' stamp: 'DOO 6/7/2021 01:11:20'!
saveMovement: aString 
	actualPosition :=aString.! !

!WindowLog methodsFor: 'as yet unclassified' stamp: 'DOO 6/7/2021 02:04:13'!
updateIfNeededWith: aPoint and: aSymbol 
	actualPosition:=aPoint printString.
	actualOrientation :=(aSymbol printString withoutPrefix:'#').! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WindowLog class' category: 'MarsRover-WithHeading'!
WindowLog class
	instanceVariableNames: ''!

!WindowLog class methodsFor: 'instance creation' stamp: 'DOO 6/7/2021 00:48:12'!
generateLogger
	^self new initializeGenerateLogger.! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head logs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'DOO 6/6/2021 23:40:56'!
initializeAt: aPosition heading: aHeading

	logs := OrderedCollection new.
	position := aPosition.
	head := aHeading ! !


!MarsRover methodsFor: 'heading' stamp: 'DOO 6/7/2021 02:29:14'!
announceDirection:aDirection

	^ logs do:[:log | log saveDirection:aDirection]! !

!MarsRover methodsFor: 'heading' stamp: 'DOO 6/7/2021 02:30:07'!
headEast
	
	head := MarsRoverHeadingEast new.
	self announceDirection: 'East'.! !

!MarsRover methodsFor: 'heading' stamp: 'DOO 6/7/2021 02:29:48'!
headNorth
	
	head := MarsRoverHeadingNorth new.
	self announceDirection: 'North'.
	! !

!MarsRover methodsFor: 'heading' stamp: 'DOO 6/7/2021 02:29:29'!
headSouth
	
	head := MarsRoverHeadingSouth new.
	self announceDirection: 'South'.! !

!MarsRover methodsFor: 'heading' stamp: 'DOO 6/7/2021 02:29:59'!
headWest
	
	head := MarsRoverHeadingWest new.
	self announceDirection: 'West'.! !

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


!MarsRover methodsFor: 'moving' stamp: 'DOO 6/7/2021 02:31:08'!
announceMovement

	^ logs do:[:log | log saveMovement: (position printString )]! !

!MarsRover methodsFor: 'moving' stamp: 'DOO 6/7/2021 02:33:01'!
moveBackward
	
	head moveBackward: self.
	self announceMovement.! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:01'!
moveEast
	
	position := position + (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'DOO 6/7/2021 02:32:21'!
moveForward
	
	head moveForward: self.
	self announceMovement.! !

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

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'as yet unclassified' stamp: 'DOO 6/7/2021 01:32:21'!
addLog: aLog 
	aLog updateIfNeededWith:position and: head class cardinalPoint.
	logs add: aLog.! !

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