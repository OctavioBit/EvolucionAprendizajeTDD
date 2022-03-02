!classDefinition: #MarsRoverTest category: #'MarsRover-Solution'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'north east west south'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solution'!

!MarsRoverTest methodsFor: 'forward' stamp: 'Federico 10/24/2020 22:47:25'!
test01ForwardLookingAtNorthAdvanceOnYAxis
	
	| aMarsRover aCommandSequence |
	
	aCommandSequence := 'f'.
	aMarsRover := MarsRover with: 0@0 lookingAt: north.
	
	aMarsRover execute: aCommandSequence.
	
	self assert: 0@1 equals: aMarsRover whereAreYou.! !

!MarsRoverTest methodsFor: 'forward' stamp: 'Federico 10/24/2020 22:47:22'!
test02ForwardLookingAtEastAdvanceOnXAxis
	
	| aMarsRover aCommandSequence |
	
	aCommandSequence := 'f'.
	aMarsRover := MarsRover with: 0@0 lookingAt: east.
	
	aMarsRover execute: aCommandSequence.
	
	self assert: 1@0 equals: aMarsRover whereAreYou.! !

!MarsRoverTest methodsFor: 'forward' stamp: 'Federico 10/24/2020 22:47:19'!
test03ForwardLookingAtWestBackOnXAxis
	
	| aMarsRover aCommandSequence |
	
	aCommandSequence := 'f'.
	aMarsRover := MarsRover with: 0@0 lookingAt: west.
	
	aMarsRover execute: aCommandSequence.
	
	self assert: -1@0 equals: aMarsRover whereAreYou.! !

!MarsRoverTest methodsFor: 'forward' stamp: 'Federico 10/24/2020 22:47:16'!
test04ForwardLookingAtSouthBackOnYAxis
	
	| aMarsRover aCommandSequence |
	
	aCommandSequence := 'f'.
	aMarsRover := MarsRover with: 0@0 lookingAt: south.
	
	aMarsRover execute: aCommandSequence.
	
	self assert: 0@-1 equals: aMarsRover whereAreYou.! !


!MarsRoverTest methodsFor: 'backward' stamp: 'Federico 10/24/2020 22:47:12'!
test05BackwardLookingAtNorthBackOnYAxis
	
	| aMarsRover aCommandSequence |
	
	aCommandSequence := 'b'.
	aMarsRover := MarsRover with: 0@0 lookingAt: north.
	
	aMarsRover execute: aCommandSequence.
	
	self assert: 0@-1 equals: aMarsRover whereAreYou.! !

!MarsRoverTest methodsFor: 'backward' stamp: 'Federico 10/24/2020 22:47:09'!
test06BackwardLookingAtEastBackOnXAxis
	
	| aMarsRover aCommandSequence |
	
	aCommandSequence := 'b'.
	aMarsRover := MarsRover with: 0@0 lookingAt: east.
	
	aMarsRover execute: aCommandSequence.
	
	self assert: -1@0 equals: aMarsRover whereAreYou.! !

!MarsRoverTest methodsFor: 'backward' stamp: 'Federico 10/24/2020 22:47:01'!
test07BackwardLookingAtWestAdvanceOnXAxis
	
	| aMarsRover aCommandSequence |
	
	aCommandSequence := 'b'.
	aMarsRover := MarsRover with: 0@0 lookingAt: west.
	
	aMarsRover execute: aCommandSequence.
	
	self assert: 1@0 equals: aMarsRover whereAreYou.! !

!MarsRoverTest methodsFor: 'backward' stamp: 'Federico 10/24/2020 22:47:05'!
test08BackwardLookingAtSouthAdvanceOnYAxis
	
	| aMarsRover aCommandSequence |
	
	aCommandSequence := 'b'.
	aMarsRover := MarsRover with: 0@0 lookingAt: south.
	
	aMarsRover execute: aCommandSequence.
	
	self assert: 0@1 equals: aMarsRover whereAreYou.! !


!MarsRoverTest methodsFor: 'left rotation' stamp: 'Federico 10/24/2020 22:07:08'!
test09LeftRotationLookingAtNorthRotateToWest
	
	| aMarsRover aCommandSequence |
	
	aCommandSequence := 'l'.
	aMarsRover := MarsRover with: 0@0 lookingAt: north.
	
	aMarsRover execute: aCommandSequence.
	
	self assert: west equals: aMarsRover whereAreYouLookingAt.! !

!MarsRoverTest methodsFor: 'left rotation' stamp: 'Federico 10/24/2020 22:46:54'!
test10LeftRotationLookingAtWestRotateToSouth
	
	| aMarsRover aCommandSequence |
	
	aCommandSequence := 'l'.
	aMarsRover := MarsRover with: 0@0 lookingAt: west.
	
	aMarsRover execute: aCommandSequence.
	
	self assert: south equals: aMarsRover whereAreYouLookingAt.! !

!MarsRoverTest methodsFor: 'left rotation' stamp: 'Federico 10/24/2020 22:46:51'!
test11LeftRotationLookingAtSouthRotateToEast
	
	| aMarsRover aCommandSequence |
	
	aCommandSequence := 'l'.
	aMarsRover := MarsRover with: 0@0 lookingAt: south.
	
	aMarsRover execute: aCommandSequence.
	
	self assert: east equals: aMarsRover whereAreYouLookingAt.! !

!MarsRoverTest methodsFor: 'left rotation' stamp: 'Federico 10/24/2020 22:46:49'!
test12LeftRotationLookingAtEastRotateToNorth
	
	| aMarsRover aCommandSequence |
	
	aCommandSequence := 'l'.
	aMarsRover := MarsRover with: 0@0 lookingAt: east.
	
	aMarsRover execute: aCommandSequence.
	
	self assert: north equals: aMarsRover whereAreYouLookingAt.! !


!MarsRoverTest methodsFor: 'right rotation' stamp: 'Federico 10/24/2020 22:46:33'!
test13RightRotationLookingAtNorthRotateToEast
	
	| aMarsRover aCommandSequence |
	
	aCommandSequence := 'r'.
	aMarsRover := MarsRover with: 0@0 lookingAt: north.
	
	aMarsRover execute: aCommandSequence.
	
	self assert: east equals: aMarsRover whereAreYouLookingAt.! !

!MarsRoverTest methodsFor: 'right rotation' stamp: 'Federico 10/24/2020 22:46:37'!
test14RightRotationLookingAtEastRotateToSouth
	
	| aMarsRover aCommandSequence |
	
	aCommandSequence := 'r'.
	aMarsRover := MarsRover with: 0@0 lookingAt: east.
	
	aMarsRover execute: aCommandSequence.
	
	self assert: south equals: aMarsRover whereAreYouLookingAt.! !

!MarsRoverTest methodsFor: 'right rotation' stamp: 'Federico 10/24/2020 22:46:40'!
test15RightRotationLookingAtSouthRotateToWest
	
	| aMarsRover aCommandSequence |
	
	aCommandSequence := 'r'.
	aMarsRover := MarsRover with: 0@0 lookingAt: south.
	
	aMarsRover execute: aCommandSequence.
	
	self assert: west equals: aMarsRover whereAreYouLookingAt.! !

!MarsRoverTest methodsFor: 'right rotation' stamp: 'Federico 10/24/2020 22:46:43'!
test16RightRotationLookingAtWestRotateToNorth
	
	| aMarsRover aCommandSequence |
	
	aCommandSequence := 'r'.
	aMarsRover := MarsRover with: 0@0 lookingAt: west.
	
	aMarsRover execute: aCommandSequence.
	
	self assert: north equals: aMarsRover whereAreYouLookingAt.! !


!MarsRoverTest methodsFor: 'command sequences' stamp: 'Federico 10/24/2020 22:46:09'!
test17TwoForwardAndOneBackwardWorkAsOneForward
	
	| aMarsRover aCommandSequence |
	
	aCommandSequence := 'ffb'.
	aMarsRover := MarsRover with: 0@0 lookingAt: north.
	
	aMarsRover execute: aCommandSequence.
	
	self assert: 0@1 equals: aMarsRover whereAreYou.! !

!MarsRoverTest methodsFor: 'command sequences' stamp: 'Federico 10/25/2020 22:04:43'!
test18UnkonwnCommandSendsMessageErrorAndStopsExecution
	
	| aMarsRover aCommandSequence |
	
	aCommandSequence := 'far'.
	aMarsRover := MarsRover with: 0@0 lookingAt: north.
	
	self 
		should: [ aMarsRover execute: aCommandSequence. ]
		raise: Error
		withMessageText: MarsRover unknownCommandErrorDescription.
		
	self assert: 0@1 equals: aMarsRover whereAreYou.
	self assert: north equals: aMarsRover whereAreYouLookingAt.! !


!MarsRoverTest methodsFor: 'setup' stamp: 'Federico 10/24/2020 22:01:31'!
setUp
	north := North new.
	south := South new.
	east := East new.
	west := West new.! !


!classDefinition: #MarsRover category: #'MarsRover-Solution'!
Object subclass: #MarsRover
	instanceVariableNames: 'point direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solution'!

!MarsRover methodsFor: 'initialize' stamp: 'Federico 10/24/2020 20:58:57'!
initializeWith: aPoint lookingAt: aMarsRoverDirection
	point := aPoint.
	direction := aMarsRoverDirection.! !


!MarsRover methodsFor: 'accessing' stamp: 'Federico 10/24/2020 16:19:33'!
whereAreYou
	^point.! !

!MarsRover methodsFor: 'accessing' stamp: 'Federico 10/24/2020 20:33:39'!
whereAreYouLookingAt
	^direction ! !


!MarsRover methodsFor: 'command' stamp: 'Federico 10/24/2020 22:45:05'!
backward
	point := point + direction pointingBackwards.! !

!MarsRover methodsFor: 'command' stamp: 'Federico 10/24/2020 22:45:14'!
forward
	point := point + direction pointingForward.! !

!MarsRover methodsFor: 'command' stamp: 'Federico 10/24/2020 22:45:17'!
leftRotation
	direction := direction rotateLeft.! !

!MarsRover methodsFor: 'command' stamp: 'Federico 10/24/2020 22:45:20'!
rightRotation
	direction := direction rotateRight.! !


!MarsRover methodsFor: 'command testing' stamp: 'Federico 10/25/2020 22:14:01'!
isBackwardCommand: aCommand

	^ aCommand = $b! !

!MarsRover methodsFor: 'command testing' stamp: 'Federico 10/25/2020 22:13:45'!
isForwardCommand: aCommand

	^ aCommand = $f! !

!MarsRover methodsFor: 'command testing' stamp: 'Federico 10/25/2020 22:14:14'!
isLeftRotationCommand: aCommand

	^ aCommand = $l! !

!MarsRover methodsFor: 'command testing' stamp: 'Federico 10/25/2020 22:14:33'!
isRightRotationCommand: aCommand

	^ aCommand = $r! !

!MarsRover methodsFor: 'command testing' stamp: 'Federico 10/25/2020 22:14:53'!
isValidCommand: aCommand

	^{$f. $b. $l. $r} includes: aCommand! !


!MarsRover methodsFor: 'executing' stamp: 'Federico 10/25/2020 21:52:15'!
execute: aCommandSequence

	aCommandSequence do: [ :aCommand | 
		self executeCommand: aCommand.
		].
	
	! !

!MarsRover methodsFor: 'executing' stamp: 'Federico 10/25/2020 22:14:34'!
executeCommand: aCommand

	(self isValidCommand: aCommand) ifFalse: [self error: self class unknownCommandErrorDescription.].
	
	(self isForwardCommand: aCommand) ifTrue: [self forward].
	(self isBackwardCommand: aCommand) ifTrue: [self backward].
	(self isLeftRotationCommand: aCommand) ifTrue: [self leftRotation].
	(self isRightRotationCommand: aCommand) ifTrue: [self rightRotation].

	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'MarsRover-Solution'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'Federico 10/25/2020 21:57:53'!
unknownCommandErrorDescription
	^'El comando no es conocido por MarsRover'! !

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'Federico 10/24/2020 20:58:40'!
with: aPoint lookingAt: aMarsRoverDirection

	^self new initializeWith: aPoint lookingAt: aMarsRoverDirection.! !


!classDefinition: #MarsRoverDirection category: #'MarsRover-Solution'!
Object subclass: #MarsRoverDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solution'!

!MarsRoverDirection methodsFor: 'mars rover moves' stamp: 'Federico 10/24/2020 22:44:10'!
pointingBackwards
	self subclassResponsibility.! !

!MarsRoverDirection methodsFor: 'mars rover moves' stamp: 'Federico 10/24/2020 22:44:43'!
pointingForward
	self subclassResponsibility.! !


!MarsRoverDirection methodsFor: 'mars rover rotations' stamp: 'Federico 10/24/2020 20:52:03'!
rotateLeft
	self subclassResponsibility.! !

!MarsRoverDirection methodsFor: 'mars rover rotations' stamp: 'Federico 10/24/2020 20:52:07'!
rotateRight
	self subclassResponsibility.! !


!MarsRoverDirection methodsFor: 'testing' stamp: 'Federico 10/25/2020 22:05:54'!
= aMarsRoverDirection
	^self class = aMarsRoverDirection class.! !


!classDefinition: #East category: #'MarsRover-Solution'!
MarsRoverDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solution'!

!East methodsFor: 'mars rover moves' stamp: 'Federico 10/24/2020 22:44:11'!
pointingBackwards
	^-1@0! !

!East methodsFor: 'mars rover moves' stamp: 'Federico 10/24/2020 22:44:44'!
pointingForward
	^1@0! !


!East methodsFor: 'mars rover rotations' stamp: 'Federico 10/24/2020 21:09:39'!
rotateLeft
	^North new.! !

!East methodsFor: 'mars rover rotations' stamp: 'Federico 10/24/2020 21:09:43'!
rotateRight
	^South new.! !


!classDefinition: #North category: #'MarsRover-Solution'!
MarsRoverDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solution'!

!North methodsFor: 'mars rover moves' stamp: 'Federico 10/24/2020 22:44:11'!
pointingBackwards
	^0@-1! !

!North methodsFor: 'mars rover moves' stamp: 'Federico 10/24/2020 22:44:43'!
pointingForward
	^0@1! !


!North methodsFor: 'mars rover rotations' stamp: 'Federico 10/24/2020 22:05:08'!
rotateLeft
	^West new.! !

!North methodsFor: 'mars rover rotations' stamp: 'Federico 10/24/2020 22:05:04'!
rotateRight
	^East new.! !


!classDefinition: #South category: #'MarsRover-Solution'!
MarsRoverDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solution'!

!South methodsFor: 'mars rover moves' stamp: 'Federico 10/24/2020 22:44:11'!
pointingBackwards
	^0@1! !

!South methodsFor: 'mars rover moves' stamp: 'Federico 10/24/2020 22:44:44'!
pointingForward
	^0@-1! !


!South methodsFor: 'mars rover rotations' stamp: 'Federico 10/24/2020 22:05:39'!
rotateLeft
	^East new.! !

!South methodsFor: 'mars rover rotations' stamp: 'Federico 10/24/2020 22:05:35'!
rotateRight
	^West new.! !


!classDefinition: #West category: #'MarsRover-Solution'!
MarsRoverDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solution'!

!West methodsFor: 'mars rover moves' stamp: 'Federico 10/24/2020 22:44:11'!
pointingBackwards
	^1@0! !

!West methodsFor: 'mars rover moves' stamp: 'Federico 10/24/2020 22:44:43'!
pointingForward
	^-1@0! !


!West methodsFor: 'mars rover rotations' stamp: 'Federico 10/24/2020 22:05:44'!
rotateLeft
	^South new.! !

!West methodsFor: 'mars rover rotations' stamp: 'Federico 10/24/2020 22:05:47'!
rotateRight
	^North new.! !
