!classDefinition: #FollowingTest category: 'MarsRover-WithHeading'!
TestCase subclass: #FollowingTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!FollowingTest methodsFor: 'test' stamp: 'LB 6/5/2021 22:08:21'!
test01LogForwardFromAnyHeading

	| marsRover positionLog |
	
	marsRover := MarsRover at: 0@0 heading: #North.
	positionLog := MarsRoverLog new.
	marsRover addFollower: positionLog for: #Position.
	
	marsRover process: 'frfrfrf'.
	
	self assert: 4 equals: positionLog size.
	self assert: '0@1' equals: (positionLog at: 	1).
	self assert: '1@1' equals: (positionLog at: 	2).
	self assert: '1@0' equals: (positionLog at: 	3).
	self assert: '0@0' equals: (positionLog at: 	4).! !

!FollowingTest methodsFor: 'test' stamp: 'LB 6/5/2021 22:08:21'!
test02LogBackwardsFromAnyHeading

	| marsRover positionLog |
	
	marsRover := MarsRover at: 0@0 heading: #South.
	positionLog := MarsRoverLog new.
	marsRover addFollower: positionLog for: #Position.
	
	marsRover process: 'brbrbrb'.
	
	self assert: 4 equals: positionLog size.
	self assert: '0@1' equals: (positionLog at: 	1).
	self assert: '1@1' equals: (positionLog at: 	2).
	self assert: '1@0' equals: (positionLog at: 	3).
	self assert: '0@0' equals: (positionLog at: 	4).! !

!FollowingTest methodsFor: 'test' stamp: 'LB 6/5/2021 22:08:21'!
test03LogRightRotationFromAnyHeading

	| marsRover rotationLog |
	
	marsRover := MarsRover at: 0@0 heading: #North.
	rotationLog := MarsRoverLog new.
	marsRover addFollower: rotationLog for: #Rotation.
	
	marsRover process: 'rrrr'.
	
	self assert: 4 equals: rotationLog size.
	self assert: 'East.' equals: (rotationLog at: 	1).
	self assert: 'South.' equals: (rotationLog at: 	2).
	self assert: 'West.' equals: (rotationLog at: 	3).
	self assert: 'North.' equals: (rotationLog at: 	4).! !

!FollowingTest methodsFor: 'test' stamp: 'LB 6/5/2021 22:08:21'!
test04LogLeftRotationFromAnyHeading

	| marsRover rotationLog |
	
	marsRover := MarsRover at: 0@0 heading: #North.
	rotationLog := MarsRoverLog new.
	marsRover addFollower: rotationLog for: #Rotation.
	
	marsRover process: 'llll'.
	
	self assert: 4 equals: rotationLog size.
	self assert: 'West.' equals: (rotationLog at: 	1).
	self assert: 'South.' equals: (rotationLog at: 	2).
	self assert: 'East.' equals: (rotationLog at: 	3).
	self assert: 'North.' equals: (rotationLog at: 	4).! !

!FollowingTest methodsFor: 'test' stamp: 'LB 6/5/2021 22:08:21'!
test05WindowUpdatesPositionInForwardMovement

	| marsRover positionWindow |
	
	marsRover := MarsRover at: 0@0 heading: #North.
	positionWindow := MarsRoverWindow new.
	marsRover addFollower: positionWindow for: #Position.
	
	marsRover process: 'f'.
	self assert: '0@1' equals: (positionWindow position).
	marsRover process: 'rf'.
	self assert: '1@1' equals: (positionWindow position).
	marsRover process: 'rf'.
	self assert: '1@0' equals: (positionWindow position).
	marsRover process: 'rf'.
	self assert: '0@0' equals: (positionWindow position).! !

!FollowingTest methodsFor: 'test' stamp: 'LB 6/5/2021 22:08:21'!
test06WindowUpdatesPositionInBackwardsMovement

    | marsRover positionWindow |
    
    marsRover := MarsRover at: 0@0 heading: #South.
    positionWindow := MarsRoverWindow new.
    marsRover addFollower: positionWindow for: #Position.
    
    marsRover process: 'b'.
    self assert: '0@1' equals: (positionWindow position).
    marsRover process: 'rb'.
    self assert: '1@1' equals: (positionWindow position).
    marsRover process: 'rb'.
    self assert: '1@0' equals: (positionWindow position).
    marsRover process: 'rb'.
    self assert: '0@0' equals: (positionWindow position).! !

!FollowingTest methodsFor: 'test' stamp: 'LB 6/5/2021 22:08:21'!
test07WindowUpdatesHeadingInRightRotation

    | marsRover rotationWindow |
    
    marsRover := MarsRover at: 0@0 heading: #North.
    rotationWindow := MarsRoverWindow new.
    marsRover addFollower: rotationWindow for: #Rotation.
    
    marsRover process: 'r'.
    self assert: 'East.' equals: (rotationWindow orientation).
    marsRover process: 'r'.
    self assert: 'South.' equals: (rotationWindow orientation).
    marsRover process: 'r'.
    self assert: 'West.' equals: (rotationWindow orientation).
    marsRover process: 'r'.
    self assert: 'North.' equals: (rotationWindow orientation).! !

!FollowingTest methodsFor: 'test' stamp: 'LB 6/5/2021 22:08:21'!
test08WindowUpdatesHeadingInLeftRotation

    | marsRover rotationWindow |
    
    marsRover := MarsRover at: 0@0 heading: #North.
    rotationWindow := MarsRoverWindow new.
    marsRover addFollower: rotationWindow for: #Rotation.
    
    marsRover process: 'l'.
    self assert: 'West.' equals: (rotationWindow orientation).
    marsRover process: 'l'.
    self assert: 'South.' equals: (rotationWindow orientation).
    marsRover process: 'l'.
    self assert: 'East.' equals: (rotationWindow orientation).
    marsRover process: 'l'.
    self assert: 'North.' equals: (rotationWindow orientation).! !

!FollowingTest methodsFor: 'test' stamp: 'LB 6/6/2021 12:49:00'!
test09ObservableStateShouldBeValid

    | marsRover window |
    
    marsRover := MarsRover at: 0@0 heading: #North.
    window := MarsRoverWindow new.

    self 
	should: [marsRover addFollower: window for: #Invalid]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
		self assert: MarsRoverObserver invalidFollowerErrorDescription equals: anError messageText].! !

!FollowingTest methodsFor: 'test' stamp: 'LB 6/6/2021 22:05:08'!
test10FollowerCantObservePositionMoreThanOnce

    | marsRover log |
    
    marsRover := MarsRover at: 0@0 heading: #North.
    log := MarsRoverLog new.
	marsRover addFollower: log for: #Position.

    self 
	should: [marsRover addFollower: log for: #Position]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
		self assert: MarsRoverObserver followerIsAlreadyObservingThisStateErrorDescription equals: anError messageText].! !

!FollowingTest methodsFor: 'test' stamp: 'LB 6/6/2021 22:05:26'!
test11FollowerCantObserveRotationMoreThanOnce

    | marsRover window |
    
    marsRover := MarsRover at: 0@0 heading: #North.
    window := MarsRoverWindow new.
	marsRover addFollower: window for: #Rotation.

    self 
	should: [marsRover addFollower: window for: #Rotation]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
		self assert: MarsRoverObserver followerIsAlreadyObservingThisStateErrorDescription equals: anError messageText].! !

!FollowingTest methodsFor: 'test' stamp: 'LB 6/6/2021 21:15:00'!
test12WindowShouldNotKnowStateWhenCreated

	| marsRover window |
	marsRover := MarsRover at: 0@0 heading: #North.
	window := MarsRoverWindow new.
	marsRover addFollower: window for: #Rotation.

	self assert: 'Unknown.' equals: window orientation.
	self assert: 'Unknown.' equals: window position.! !

!FollowingTest methodsFor: 'test' stamp: 'LB 6/6/2021 21:24:23'!
test13FollowerCantObserveMoreThanOneMarsRover

	| marsRover marsRover2 window |
	marsRover := MarsRover at: 0@0 heading: #North.
	marsRover2 := MarsRover at: 0@0 heading: #North.
	window := MarsRoverWindow new.
	marsRover addFollower: window for: #Rotation.
	self should: [marsRover2 addFollower: window for: #Position]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
		self assert: MarsRoverFollower alreadyFollowingAMarsRoverErrorDescription equals: anError messageText].! !

!FollowingTest methodsFor: 'test' stamp: 'LB 6/6/2021 21:38:48'!
test14FollowerShouldBeAMarsRoverFollower

	| marsRover invalidFollower |
	marsRover := MarsRover at: 0@0 heading: #North.
	invalidFollower := String new.
	
	self should: [marsRover addFollower: invalidFollower for: #Rotation]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
		self assert: MarsRoverObserver invalidFollowerErrorDescription equals: anError messageText].! !

!FollowingTest methodsFor: 'test' stamp: 'LB 6/6/2021 21:59:25'!
test15LogAndWindowCanObserveTheSameObservable

	| marsRover window log |
	marsRover := MarsRover at: 0@0 heading: #North.
	window := MarsRoverWindow new.
	log := MarsRoverLog new.
	
	marsRover addFollower: log for: #Rotation.
	marsRover addFollower: log for: #Position.
	marsRover addFollower: window for: #Rotation.
	marsRover addFollower: window for: #Position.
	
	marsRover process: 'fr'.
	self assert: '0@1' equals: window position.
	self assert: 'East.' equals: window orientation.
	
	marsRover process: 'fr'.
	self assert: '1@1' equals: window position.
	self assert: 'South.' equals: window orientation.
	
	marsRover process: 'fr'.
	self assert: '1@0' equals: window position.
	self assert: 'West.' equals: window orientation.
	
	marsRover process: 'fr'.
	self assert: '0@0' equals: window position.
	self assert: 'North.' equals: window orientation.
	
	self assert: 8 equals: log size.
	self assert: '0@1' equals: (log at: 	1).
	self assert: '1@1' equals: (log at: 	3).
	self assert: '1@0' equals: (log at: 	5).
	self assert: '0@0' equals: (log at: 	7).
	
	self assert: 'East.' equals: (log at: 	2).
	self assert: 'South.' equals: (log at: 	4).
	self assert: 'West.' equals: (log at: 	6).
	self assert: 'North.' equals: (log at: 	8).
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

!MarsRoverTest methodsFor: 'tests' stamp: 'LB 6/6/2021 22:02:46'!
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
	instanceVariableNames: 'position head observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'LB 6/5/2021 22:10:50'!
initializeAt: aPosition heading: aHeading

	position := aPosition.
	head := aHeading.
	observers := MarsRoverObserver for: self.! !


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

!MarsRover methodsFor: 'heading' stamp: 'LB 6/5/2021 22:07:08'!
rotateLeft
	
	head rotateLeft: self.! !

!MarsRover methodsFor: 'heading' stamp: 'LB 6/5/2021 22:07:13'!
rotateRight
	
	head rotateRight: self.! !


!MarsRover methodsFor: 'testing' stamp: 'LB 6/5/2021 21:24:03'!
head
	^head! !

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

!MarsRover methodsFor: 'testing' stamp: 'LB 6/5/2021 21:24:14'!
position
	^position! !


!MarsRover methodsFor: 'moving' stamp: 'LB 6/5/2021 22:07:27'!
moveBackward
	
	head moveBackward: self.! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:01'!
moveEast
	
	position := position + (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'LB 6/5/2021 22:07:22'!
moveForward
	
	head moveForward: self.! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:12'!
moveNorth
	
	position := position + (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:34'!
moveSouth
	
	position := position + (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:32'!
moveWest
	
	position := position + (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'LB 6/5/2021 22:06:31'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand. observers update]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'following' stamp: 'LB 6/5/2021 22:08:21'!
addFollower: aFollower for: anObservable 
	observers add: aFollower for: anObservable.! !

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


!classDefinition: #MarsRoverFollower category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverFollower
	instanceVariableNames: 'marsRoverObserver'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverFollower methodsFor: 'updating' stamp: 'LB 6/6/2021 21:36:02'!
attachTo: aMarsRoverObserver
	marsRoverObserver ifNil: [marsRoverObserver := aMarsRoverObserver].
	(marsRoverObserver ~= aMarsRoverObserver) ifTrue: [^self error: self class alreadyFollowingAMarsRoverErrorDescription].! !

!MarsRoverFollower methodsFor: 'updating' stamp: 'LB 6/6/2021 21:09:09'!
headingAsString: aHead
	(aHead isHeading: #East) ifTrue: [^'East.'].
	(aHead isHeading: #South) ifTrue: [^'South.'].
	(aHead isHeading: #West) ifTrue: [^'West.'].
	(aHead isHeading: #North) ifTrue: [^'North.'].! !

!MarsRoverFollower methodsFor: 'updating' stamp: 'LB 6/5/2021 13:03:38'!
notifyPositionChange: aPosition
	self subclassResponsibility.! !

!MarsRoverFollower methodsFor: 'updating' stamp: 'LB 6/5/2021 13:03:30'!
notifyRotationChange: aHeading
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverFollower class' category: 'MarsRover-WithHeading'!
MarsRoverFollower class
	instanceVariableNames: ''!

!MarsRoverFollower class methodsFor: 'error' stamp: 'LB 6/6/2021 21:33:21'!
alreadyFollowingAMarsRoverErrorDescription
	^'already following a different MarsRover'! !


!classDefinition: #MarsRoverLog category: 'MarsRover-WithHeading'!
MarsRoverFollower subclass: #MarsRoverLog
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLog methodsFor: 'testing' stamp: 'LB 6/5/2021 11:36:18'!
at: anIndex
	^log at: anIndex.! !

!MarsRoverLog methodsFor: 'testing' stamp: 'LB 6/5/2021 11:35:03'!
size
	^log size.! !


!MarsRoverLog methodsFor: 'updating' stamp: 'LB 6/5/2021 12:57:37'!
notifyPositionChange: aPosition
	^log add: aPosition asString.! !

!MarsRoverLog methodsFor: 'updating' stamp: 'LB 6/6/2021 21:09:33'!
notifyRotationChange: aHead
	log add: (self headingAsString: aHead).! !


!MarsRoverLog methodsFor: 'initialization' stamp: 'LB 6/5/2021 11:35:45'!
initialize
	log := OrderedCollection new.! !


!classDefinition: #MarsRoverWindow category: 'MarsRover-WithHeading'!
MarsRoverFollower subclass: #MarsRoverWindow
	instanceVariableNames: 'position orientation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindow methodsFor: 'testing' stamp: 'LB 6/6/2021 19:11:53'!
orientation
	^orientation! !

!MarsRoverWindow methodsFor: 'testing' stamp: 'LB 6/6/2021 22:12:02'!
position
	^position! !


!MarsRoverWindow methodsFor: 'updating' stamp: 'LB 6/6/2021 22:12:07'!
notifyPositionChange: aPosition 
	position := aPosition asString.! !

!MarsRoverWindow methodsFor: 'updating' stamp: 'LB 6/6/2021 21:10:02'!
notifyRotationChange: aHead
	orientation := self headingAsString: aHead.! !


!MarsRoverWindow methodsFor: 'initialization' stamp: 'LB 6/6/2021 21:15:42'!
initialize
	orientation := 'Unknown.'.
	position := 'Unknown.'.! !


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


!classDefinition: #MarsRoverObserver category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverObserver
	instanceVariableNames: 'positionFollowers rotationFollowers marsRover currentPosition currentHead'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObserver methodsFor: 'assert' stamp: 'LB 6/6/2021 21:41:25'!
assertValidFollower: aFollower
	(aFollower isKindOf: MarsRoverFollower) ifFalse: [^self error: self class invalidFollowerErrorDescription.]! !


!MarsRoverObserver methodsFor: 'adding' stamp: 'LB 6/6/2021 21:44:22'!
add: aFollower for: anObservable
	self assertValidFollower: aFollower.
	aFollower attachTo: self.
	self attach: aFollower toObservable: anObservable.! !

!MarsRoverObserver methodsFor: 'adding' stamp: 'LB 6/6/2021 22:08:00'!
addPositionFollower: aFollower
	(positionFollowers includes: aFollower) ifTrue: [^self error: self class followerIsAlreadyObservingThisStateErrorDescription].
	positionFollowers add: aFollower.! !

!MarsRoverObserver methodsFor: 'adding' stamp: 'LB 6/6/2021 22:08:10'!
addRotationFollower: aFollower 
	(rotationFollowers includes: aFollower) ifTrue: [^self error: self class followerIsAlreadyObservingThisStateErrorDescription].
	rotationFollowers add: aFollower.! !

!MarsRoverObserver methodsFor: 'adding' stamp: 'LB 6/6/2021 21:44:15'!
attach: aFollower toObservable: anObservable.
	(anObservable = #Position) ifTrue: [^self addPositionFollower: aFollower].
	(anObservable = #Rotation) ifTrue: [^self addRotationFollower: aFollower].
	
	^self error: self class invalidFollowerErrorDescription.! !


!MarsRoverObserver methodsFor: 'initialization' stamp: 'LB 6/6/2021 22:08:40'!
initializeFor: aMarsRover
	marsRover  := aMarsRover.
	currentPosition := marsRover position.
	currentHead := marsRover head.
	positionFollowers := OrderedCollection new.
	rotationFollowers := OrderedCollection new.! !


!MarsRoverObserver methodsFor: 'updating' stamp: 'LB 6/6/2021 22:08:40'!
update
	(marsRover head = currentHead) ifFalse: [self updateHeading].
	(marsRover position = currentPosition) ifFalse: [self updatePosition].! !

!MarsRoverObserver methodsFor: 'updating' stamp: 'LB 6/6/2021 22:08:40'!
updateHeading
	currentHead := marsRover head.
	rotationFollowers do: [:anObserver | anObserver notifyRotationChange: currentHead.]! !

!MarsRoverObserver methodsFor: 'updating' stamp: 'LB 6/6/2021 22:08:34'!
updatePosition
	currentPosition := marsRover position.
	positionFollowers do: [:anObserver | anObserver notifyPositionChange: currentPosition].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverObserver class' category: 'MarsRover-WithHeading'!
MarsRoverObserver class
	instanceVariableNames: ''!

!MarsRoverObserver class methodsFor: 'error' stamp: 'LB 6/6/2021 12:54:34'!
followerIsAlreadyObservingThisStateErrorDescription
	^'Error follower is already observing this state.'! !

!MarsRoverObserver class methodsFor: 'error' stamp: 'LB 6/6/2021 12:46:15'!
invalidFollowerErrorDescription
	^'Error Invalid Follower'! !


!MarsRoverObserver class methodsFor: 'instance creation' stamp: 'LB 6/5/2021 21:42:33'!
for: aMarsRover
	^self new initializeFor: aMarsRover ! !
