!classDefinition: #MarsRoverTest category: 'MarsRover- ElRegreso'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover- ElRegreso'!

!MarsRoverTest methodsFor: 'testing' stamp: 'HAW 7/1/2018 14:23:26'!
test01

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: ''.
	
	self assert: (marsRover isAt: 1@2 heading: #North)! !

!MarsRoverTest methodsFor: 'testing' stamp: 'HAW 7/1/2018 14:23:31'!
test02

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@3 heading: #North)! !

!MarsRoverTest methodsFor: 'testing' stamp: 'HAW 7/1/2018 14:23:34'!
test03

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 1@1 heading: #North)! !

!MarsRoverTest methodsFor: 'testing' stamp: 'HAW 7/1/2018 14:23:38'!
test04

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: #East)! !

!MarsRoverTest methodsFor: 'testing' stamp: 'HAW 7/1/2018 14:23:45'!
test05

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #West)! !

!MarsRoverTest methodsFor: 'testing' stamp: 'HAW 7/1/2018 14:23:50'!
test06

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: #North) ]! !

!MarsRoverTest methodsFor: 'testing' stamp: 'HAW 7/1/2018 14:23:54'!
test07

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'ff'.
	
	self assert: (marsRover isAt: 1@4 heading: #North)! !

!MarsRoverTest methodsFor: 'testing' stamp: 'HAW 7/1/2018 14:23:59'!
test08

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 2@2 heading: #East)! !

!MarsRoverTest methodsFor: 'testing' stamp: 'HAW 7/1/2018 14:24:06'!
test09

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 0@2 heading: #East)! !

!MarsRoverTest methodsFor: 'testing' stamp: 'HAW 7/1/2018 14:24:12'!
test10

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: #South)! !

!MarsRoverTest methodsFor: 'testing' stamp: 'HAW 7/1/2018 14:24:20'!
test11

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #North)! !

!MarsRoverTest methodsFor: 'testing' stamp: 'HAW 7/1/2018 14:24:25'!
test12

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #South.
	
	marsRover process: 'ffbr'.
	
	self assert: (marsRover isAt: 1@1 heading: #West)! !

!MarsRoverTest methodsFor: 'testing' stamp: 'HAW 7/1/2018 14:24:29'!
test13

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #South.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #East)! !

!MarsRoverTest methodsFor: 'testing' stamp: 'HAW 7/1/2018 14:24:33'!
test14

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #West.
	
	marsRover process: 'ffbr'.
	
	self assert: (marsRover isAt: 0@2 heading: #North)! !

!MarsRoverTest methodsFor: 'testing' stamp: 'HAW 7/1/2018 14:24:37'!
test15

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #West.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #South)! !

!MarsRoverTest methodsFor: 'testing' stamp: 'HAW 7/2/2018 16:27:43'!
test16

	self 
		should: [MarsRover at: 1@2 heading: #X ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: MarsRover invalidCardinalPointErrorDescription equals: anError messageText ]! !


!classDefinition: #SubscribersTest category: 'MarsRover- ElRegreso'!
TestCase subclass: #SubscribersTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover- ElRegreso'!

!SubscribersTest methodsFor: 'testing' stamp: 'ms 6/7/2021 16:49:33'!
test01AssertThatLogAddedChangePositionFoward

	self assertMarsRoverHeadingAt: #North processComands: 'f' logPositionMessageAssertion: '0@1'
! !

!SubscribersTest methodsFor: 'testing' stamp: 'ms 6/7/2021 16:49:39'!
test02AssertThatLogAddedChangePositionBackward

	self assertMarsRoverHeadingAt: #North processComands: 'b' logPositionMessageAssertion: '0@-1'
	! !

!SubscribersTest methodsFor: 'testing' stamp: 'ms 6/7/2021 16:49:47'!
test03AssertThatLogAddedChangeHeadingRotateRight

	self assertMarsRoverHeadingAt: #North processComands: 'r'  logHeadingMessageAssertion: 'Apuntando al Este'
! !

!SubscribersTest methodsFor: 'testing' stamp: 'ms 6/7/2021 16:49:55'!
test04AssertThatLogAddedChangeHeadingRotateLeft
	
	self assertMarsRoverHeadingAt: #North processComands: 'l'  logHeadingMessageAssertion: 'Apuntando al Oeste'
	! !

!SubscribersTest methodsFor: 'testing' stamp: 'ms 6/7/2021 16:50:04'!
test05AssertThatLogAddedChangeHeadingRotateLeftStartingHeadingEast
	
	self assertMarsRoverHeadingAt: #East processComands: 'l'  logHeadingMessageAssertion: 'Apuntando al Norte'
	
! !

!SubscribersTest methodsFor: 'testing' stamp: 'ms 6/7/2021 16:50:10'!
test06AssertThatLogAddedChangeHeadingRotateRightStartingHeadingEast

	self assertMarsRoverHeadingAt: #East processComands: 'r'  logHeadingMessageAssertion: 'Apuntando al Sur'
	! !

!SubscribersTest methodsFor: 'testing' stamp: 'ms 6/7/2021 16:50:50'!
test07AssertThatLogAddedChangePositionFowardStartingHeadingEast
	
	self assertMarsRoverHeadingAt: #East processComands: 'f'  logPositionMessageAssertion: '1@0'! !

!SubscribersTest methodsFor: 'testing' stamp: 'ms 6/7/2021 16:50:18'!
test08AssertThatLogAddedChangePositionBackwardsStartingHeadingEast
	
	self assertMarsRoverHeadingAt: #East processComands: 'b'  logPositionMessageAssertion: '-1@0'! !

!SubscribersTest methodsFor: 'testing' stamp: 'ms 6/7/2021 16:12:18'!
test09AssertThatWindowChangePositionFowards

	self assertMarsRoverHeadingAt: #North processComands: 'f' windowPositionMessageAssertion: 0@1! !

!SubscribersTest methodsFor: 'testing' stamp: 'ms 6/7/2021 16:12:40'!
test10AssertThatWindowChangePositionBackwad

	self assertMarsRoverHeadingAt: #North processComands: 'b' windowPositionMessageAssertion: 0@-1.! !

!SubscribersTest methodsFor: 'testing' stamp: 'ms 6/7/2021 16:14:11'!
test11AssertThatWindowChangeHeadingRotateRight


	self assertMarsRoverHeadingAt: #North processComands: 'r' windowHeadingMessageAssertion: 'Este' 
	! !

!SubscribersTest methodsFor: 'testing' stamp: 'ms 6/7/2021 16:14:40'!
test12AssertThatWindowChangeHeadingRotateLeft

	self assertMarsRoverHeadingAt: #North processComands: 'l' windowHeadingMessageAssertion: 'Oeste' ! !

!SubscribersTest methodsFor: 'testing' stamp: 'ms 6/7/2021 16:13:13'!
test13AssertThatWindowChangePositionFowardStartingHeadingEast

	self  assertMarsRoverHeadingAt: #East processComands: 'f' windowPositionMessageAssertion: 1@0.! !

!SubscribersTest methodsFor: 'testing' stamp: 'ms 6/7/2021 16:13:26'!
test14AssertThatWindowChangePositionBackwardStartingHeadingEast

	self  assertMarsRoverHeadingAt: #East processComands: 'b' windowPositionMessageAssertion: -1@0.! !

!SubscribersTest methodsFor: 'testing' stamp: 'ms 6/7/2021 16:15:02'!
test15AssertThatWindowChangeHeadingRotateRightStartingHeadingEast

	self assertMarsRoverHeadingAt: #East processComands: 'r' windowHeadingMessageAssertion: 'Sur' ! !

!SubscribersTest methodsFor: 'testing' stamp: 'ms 6/7/2021 16:15:22'!
test16AssertThatWindowChangeHeadingRotateLeftStartingHeadingEast

	self assertMarsRoverHeadingAt: #East processComands: 'l' windowHeadingMessageAssertion: 'Norte' ! !

!SubscribersTest methodsFor: 'testing' stamp: 'ms 6/7/2021 16:45:34'!
test17assertThatLogAndWindowSupportedAtSameTime

	|marsRover log window|
	
	marsRover := MarsRover at: 0@0 heading: #North.
	log := MarsRoverLog new.
	window := MarsRoverStateWindow new.
	
	marsRover addSubscriptorHeading: log .
	marsRover addSubscriptorPosition: log .
	marsRover addSubscriptorHeading: window.
	marsRover addSubscriptorPosition:window .
	
	marsRover process: 'rfr'.
	
	self assert: 'Sur' equals: window headingTextFieldModel .
	self assert: 1@0 equals: window positionTextFieldModel .
	
	marsRover process: 'bl'.
	
	self assert: 5 equals: (log returnContenList ) size.
	self assert: 'Apuntando al Este' equals: (log returnContenList )first.
	self assert: '1@0' equals: (log returnContenList ) second.
	self assert: 'Apuntando al Sur' equals: (log returnContenList ) third.
	self assert: '1@1' equals: ((log returnContenList ) at: 4).
	self assert: 'Apuntando al Este' equals: ((log returnContenList ) at: 5).
	
	self assert: 'Este' equals: window headingTextFieldModel .
	self assert: 1@1 equals: window positionTextFieldModel .
	! !

!SubscribersTest methodsFor: 'testing' stamp: 'ms 6/7/2021 16:46:59'!
test18AssertWhitoutChangesThereAreNotModels

	|marsRover log window|
	
	marsRover := MarsRover at: 0@0 heading: #North.
	log := MarsRoverLog new.
	window := MarsRoverStateWindow new.
	
	marsRover addSubscriptorPosition: log .
	marsRover addSubscriptorHeading: log .
	marsRover addSubscriptorPosition: window .
	marsRover addSubscriptorHeading: window .
	
	self assert: 0 equals: (log returnContenList ) size.
	
	self assert: nil equals: window headingTextFieldModel .
	self assert: nil equals: window positionTextFieldModel .
	! !


!SubscribersTest methodsFor: 'assertions for log' stamp: 'ms 6/7/2021 16:48:23'!
assertMarsRoverHeadingAt: aHead processComands: comands logHeadingMessageAssertion: aMessage

|marsRover log|
	
	marsRover := MarsRover at: 0@0 heading: aHead.
	log := MarsRoverLog new.
	
	marsRover addSubscriptorHeading: log.
	
	marsRover process: comands .
	
	self assert: 1 equals: (log returnContenList ) size.
	self assert: aMessage equals: (log returnContenList ) first.! !

!SubscribersTest methodsFor: 'assertions for log' stamp: 'ms 6/7/2021 16:48:42'!
assertMarsRoverHeadingAt: aHead processComands: comands logPositionMessageAssertion: aMessage

|marsRover log|
	
	marsRover := MarsRover at: 0@0 heading: aHead.
	log := MarsRoverLog new.
	
	marsRover addSubscriptorPosition: log.
	
	marsRover process: comands .
	
	self assert: 1 equals: (log returnContenList ) size.
	self assert: aMessage equals: (log returnContenList ) first.! !


!SubscribersTest methodsFor: 'assertion for window' stamp: 'ms 6/7/2021 16:47:52'!
assertMarsRoverHeadingAt: aHead processComands: comands windowHeadingMessageAssertion: aMessage

|marsRover window|
	
	marsRover := MarsRover at: 0@0 heading: aHead.
	window := MarsRoverStateWindow new.
	
	marsRover addSubscriptorHeading: window .
	
	marsRover process: comands .
	
	self assert:aMessage equals: window headingTextFieldModel! !

!SubscribersTest methodsFor: 'assertion for window' stamp: 'ms 6/7/2021 16:47:42'!
assertMarsRoverHeadingAt: aHead processComands: comands windowPositionMessageAssertion: aMessage

|marsRover window|
	
	marsRover := MarsRover at: 0@0 heading: aHead.
	window := MarsRoverStateWindow new.
	
	marsRover addSubscriptorPosition: window .
	
	marsRover process: comands .
	
	self assert:aMessage equals: window positionTextFieldModel! !


!classDefinition: #MarsRover category: 'MarsRover- ElRegreso'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head subscribersHeading subscribersPosition'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover- ElRegreso'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'ms 6/7/2021 16:39:05'!
initializeAt: aPosition heading: aHeading

	position := aPosition.
	head := aHeading .
	subscribersHeading := OrderedCollection new.
	subscribersPosition := OrderedCollection new.! !


!MarsRover methodsFor: 'heading' stamp: 'ms 6/7/2021 16:39:18'!
changeHadingTo:  aMarsRoverHeadingNew

	head := aMarsRoverHeadingNew .
	subscribersHeading do: [:anObserver | anObserver headingChangedTo: head.].! !

!MarsRover methodsFor: 'heading' stamp: 'ms 6/4/2021 00:25:30'!
headEast
	
	self changeHadingTo:  MarsRoverHeadingEast new.! !

!MarsRover methodsFor: 'heading' stamp: 'ms 6/4/2021 00:25:40'!
headNorth
	
	self changeHadingTo: MarsRoverHeadingNorth new.! !

!MarsRover methodsFor: 'heading' stamp: 'ms 6/4/2021 00:25:55'!
headSouth
	
		self changeHadingTo:MarsRoverHeadingSouth new.! !

!MarsRover methodsFor: 'heading' stamp: 'ms 6/4/2021 00:26:10'!
headWest
	
	self changeHadingTo: MarsRoverHeadingWest new.! !

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


!MarsRover methodsFor: 'moving' stamp: 'ms 6/7/2021 16:39:37'!
changePositionTo: newPosition

	position  := newPosition .
	
	subscribersPosition do: [: anObserver | anObserver positionChangeTo: position ].! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:20'!
moveBackward
	
	head moveBackward: self! !

!MarsRover methodsFor: 'moving' stamp: 'ms 6/4/2021 00:23:17'!
moveEast
	
	self changePositionTo: position + (1@0).! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:55'!
moveForward
	
	head moveForward: self! !

!MarsRover methodsFor: 'moving' stamp: 'ms 6/4/2021 00:23:27'!
moveNorth
	
	self changePositionTo:position + (0@1).! !

!MarsRover methodsFor: 'moving' stamp: 'ms 6/4/2021 00:23:32'!
moveSouth
	
	self changePositionTo: position + (0@-1).! !

!MarsRover methodsFor: 'moving' stamp: 'ms 6/4/2021 00:23:39'!
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


!MarsRover methodsFor: 'add subscriptors' stamp: 'ms 6/7/2021 16:44:06'!
addSubscriptorHeading: aSubscriptor

	subscribersHeading add: aSubscriptor.
	! !

!MarsRover methodsFor: 'add subscriptors' stamp: 'ms 6/7/2021 16:44:14'!
addSubscriptorPosition: aSubscriptor

	subscribersPosition add: aSubscriptor
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover- ElRegreso'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 8/22/2019 12:01:48'!
at: aPosition heading: aCardinalPoint
	
	^self new initializeAt: aPosition heading: (MarsRoverHeading heading: aCardinalPoint)! !

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 7/2/2018 16:26:14'!
invalidCardinalPointErrorDescription
	
	^'Invalid cardinal point'! !


!classDefinition: #MarsRoverHeading category: 'MarsRover- ElRegreso'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover- ElRegreso'!

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


!MarsRoverHeading methodsFor: 'notify change heading' stamp: 'ms 6/6/2021 11:49:19'!
notifyChangeHeadingToSubscriptor: aSubscriptor

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover- ElRegreso'!
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


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover- ElRegreso'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover- ElRegreso'!

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


!MarsRoverHeadingEast methodsFor: 'notify change heading' stamp: 'ms 6/7/2021 16:26:49'!
notifyChangeHeadingToSubscriptor: aSubscriptor

	^aSubscriptor notifyHeadingEast! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingEast class' category: 'MarsRover- ElRegreso'!
MarsRoverHeadingEast class
	instanceVariableNames: ''!

!MarsRoverHeadingEast class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:01:53'!
cardinalPoint

	^#East! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover- ElRegreso'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover- ElRegreso'!

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


!MarsRoverHeadingNorth methodsFor: 'notify change heading' stamp: 'ms 6/7/2021 16:29:35'!
notifyChangeHeadingToSubscriptor: aSubscriptor

	^aSubscriptor nofityHeadingNorth! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingNorth class' category: 'MarsRover- ElRegreso'!
MarsRoverHeadingNorth class
	instanceVariableNames: ''!

!MarsRoverHeadingNorth class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:11'!
cardinalPoint

	^#North! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover- ElRegreso'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover- ElRegreso'!

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


!MarsRoverHeadingSouth methodsFor: 'notify change heading' stamp: 'ms 6/7/2021 16:27:52'!
notifyChangeHeadingToSubscriptor: aSubscriptor

	^aSubscriptor nofityHeadingSouth! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingSouth class' category: 'MarsRover- ElRegreso'!
MarsRoverHeadingSouth class
	instanceVariableNames: ''!

!MarsRoverHeadingSouth class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:17'!
cardinalPoint

	^#South! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover- ElRegreso'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover- ElRegreso'!

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


!MarsRoverHeadingWest methodsFor: 'notify change heading' stamp: 'ms 6/7/2021 16:29:03'!
notifyChangeHeadingToSubscriptor: aSubscriptor

	^aSubscriptor nofityHeadingWest! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingWest class' category: 'MarsRover- ElRegreso'!
MarsRoverHeadingWest class
	instanceVariableNames: ''!

!MarsRoverHeadingWest class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:23'!
cardinalPoint

	^#West! !


!classDefinition: #MarsRoverLog category: 'MarsRover- ElRegreso'!
Object subclass: #MarsRoverLog
	instanceVariableNames: 'changes'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover- ElRegreso'!

!MarsRoverLog methodsFor: 'initialization' stamp: 'ms 6/6/2021 11:00:54'!
initialize 

	changes := OrderedCollection new! !


!MarsRoverLog methodsFor: 'notify heading' stamp: 'ms 6/7/2021 16:20:06'!
nofityHeadingNorth

	^'Apuntando al Norte'! !

!MarsRoverLog methodsFor: 'notify heading' stamp: 'ms 6/7/2021 16:21:28'!
nofityHeadingSouth

	^ 'Apuntando al Sur'! !

!MarsRoverLog methodsFor: 'notify heading' stamp: 'ms 6/7/2021 16:21:34'!
nofityHeadingWest

	^ 'Apuntando al Oeste'! !

!MarsRoverLog methodsFor: 'notify heading' stamp: 'ms 6/7/2021 16:21:39'!
notifyHeadingEast

	^'Apuntando al Este'! !


!MarsRoverLog methodsFor: 'add changes' stamp: 'ms 6/7/2021 16:21:21'!
headingChangedTo: aHead
	
	changes add: (aHead notifyChangeHeadingToSubscriptor: self).! !

!MarsRoverLog methodsFor: 'add changes' stamp: 'ms 6/6/2021 11:00:54'!
positionChangeTo: aPosition

	changes add: aPosition printString.! !


!MarsRoverLog methodsFor: 'content list' stamp: 'ms 6/6/2021 11:00:54'!
returnContenList

	^ changes ! !


!classDefinition: #MarsRoverStateWindow category: 'MarsRover- ElRegreso'!
Object subclass: #MarsRoverStateWindow
	instanceVariableNames: 'positionTextFieldModel headingTextFieldModel'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover- ElRegreso'!

!MarsRoverStateWindow methodsFor: 'changes' stamp: 'ms 6/6/2021 11:49:19'!
headingChangedTo: aMarsRoverHeading
	aMarsRoverHeading notifyChangeHeadingToSubscriptor:self.
	! !

!MarsRoverStateWindow methodsFor: 'changes' stamp: 'ms 6/6/2021 09:43:09'!
positionChangeTo: aPosition

	positionTextFieldModel := aPosition ! !


!MarsRoverStateWindow methodsFor: 'textFieldsModels' stamp: 'ms 6/4/2021 00:01:27'!
headingTextFieldModel
	
	^headingTextFieldModel! !

!MarsRoverStateWindow methodsFor: 'textFieldsModels' stamp: 'ms 6/6/2021 09:43:14'!
positionTextFieldModel
	
	^positionTextFieldModel! !


!MarsRoverStateWindow methodsFor: 'notify heading' stamp: 'CS 6/7/2021 15:55:46'!
nofityHeadingNorth
	
	headingTextFieldModel := 'Norte'! !

!MarsRoverStateWindow methodsFor: 'notify heading' stamp: 'CS 6/7/2021 15:55:52'!
nofityHeadingSouth
	
	headingTextFieldModel := 'Sur'! !

!MarsRoverStateWindow methodsFor: 'notify heading' stamp: 'CS 6/7/2021 15:55:57'!
nofityHeadingWest
	
	headingTextFieldModel := 'Oeste'! !

!MarsRoverStateWindow methodsFor: 'notify heading' stamp: 'CS 6/7/2021 15:56:03'!
notifyHeadingEast

	headingTextFieldModel := 'Este'! !
