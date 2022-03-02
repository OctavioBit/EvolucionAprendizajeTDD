!classDefinition: #MarsRoverTests category: 'MarsRoverTDD'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!MarsRoverTests methodsFor: 'testing' stamp: 'PJ 10/24/2020 20:17:32'!
test01RoverMovesCorrectly
	| rover initialPoint forwardPoint|
	initialPoint := (0@0).
	forwardPoint := (0@1).
	
	rover := MarsRover startPoint: initialPoint initialOrientation: 'N'.
	rover executeCommandSet: 'f'.
	
	self assert: (rover position) equals: forwardPoint.! !

!MarsRoverTests methodsFor: 'testing' stamp: 'PJ 10/24/2020 20:18:03'!
test02RoverRotatesCorrectly
	| rover initialPoint |
	initialPoint := (0@0).
	
	rover := MarsRover startPoint: initialPoint initialOrientation: 'N'.
	rover executeCommandSet: 'l'.
	
	self assert: (rover position) equals: initialPoint.
	self assert: (rover orientation) equals: 'O'.! !

!MarsRoverTests methodsFor: 'testing' stamp: 'PJ 10/24/2020 20:28:23'!
test03RoverCanExecuteMorethanOneCommand
	| rover initialPoint finalPoint|
	initialPoint := (0@0).
	finalPoint := (-1@0).
	
	rover := MarsRover startPoint: initialPoint initialOrientation: 'N'.
	rover executeCommandSet: 'r'.
	rover executeCommandSet: 'b'.
	
	self assert: (rover position) equals: finalPoint.
	self assert: (rover orientation) equals: 'E'.! !

!MarsRoverTests methodsFor: 'testing' stamp: 'PJ 10/24/2020 20:31:43'!
test04RoverCanExecuteAStringOfCommands
	| rover initialPoint finalPoint |
	initialPoint := (0@0).
	finalPoint := (1@1).
	
	rover := MarsRover startPoint: initialPoint initialOrientation: 'N'.
	rover executeCommandSet: 'frf'.
	
	self assert: (rover position) equals: finalPoint.
	self assert: (rover orientation) equals: 'E'.! !

!MarsRoverTests methodsFor: 'testing' stamp: 'PJ 10/26/2020 13:38:36'!
test05RoverAssertsAndStopsExecutingWhenACommandIsInvalid
	| rover initialPoint finalPoint |
	initialPoint := (0@0).
	finalPoint := (1@1).
	
	rover := MarsRover startPoint: initialPoint initialOrientation: 'N'.
	
	self should: [rover executeCommandSet: 'frfzfflff']
		raise: Error - MessageNotUnderstood
		description: (rover class invalidCommandExceptionDescription: $z).
	
	self assert: (rover position) equals: finalPoint.
	self assert: (rover orientation) equals: 'E'.! !

!MarsRoverTests methodsFor: 'testing' stamp: 'PJ 10/26/2020 13:39:06'!
test06RoverAssertsWhenInitializedWithoutAStartingPoint

	self should: [
			MarsRover startPoint: #(1 0) initialOrientation: 'N']
		raise: Error - MessageNotUnderstood
		withMessageText: MarsRover invalidStartingPointExceptionDescription.! !

!MarsRoverTests methodsFor: 'testing' stamp: 'PGTA 10/26/2020 15:55:37'!
test07RoverAssertsWhenInitializedWithAnInvalidOrientation

	self should: [
			MarsRover startPoint: (1@0) initialOrientation: 'H']
		raise: Error - MessageNotUnderstood
		withMessageText: RoverOrientation invalidOrientationErrorDescription.! !


!classDefinition: #MarsRover category: 'MarsRoverTDD'!
Object subclass: #MarsRover
	instanceVariableNames: 'position orientation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!MarsRover methodsFor: 'initialization' stamp: 'PGTA 10/26/2020 15:55:37'!
initializeStartPoint: aPoint initialOrientation: anOrientation 

	position := aPoint.
	orientation := RoverOrientation initializeFor: anOrientation ! !


!MarsRover methodsFor: 'state' stamp: 'PJ 10/24/2020 19:20:37'!
orientation
	^orientation orientationString! !

!MarsRover methodsFor: 'state' stamp: 'PJ 10/24/2020 21:06:32'!
position
	^position.! !


!MarsRover methodsFor: 'commands' stamp: 'PJ 10/24/2020 20:02:59'!
executeCommandSet: aCommandSet
	aCommandSet do: [:aChar |
		(self processCommand: aChar) ifFalse: [^self]]
! !

!MarsRover methodsFor: 'commands' stamp: 'PGTA 10/26/2020 15:53:36'!
processCommand: aCommand
	aCommand = $f
		ifTrue: [ self stepForward. ^true].
	aCommand = $b
		ifTrue: [ self stepBackward. ^true].
		
	aCommand = $l
		ifTrue: [self rotateLeft. ^true].
	aCommand = $r
		ifTrue: [self rotateRight. ^true]
		
		ifFalse: [self error: (self class invalidCommandExceptionDescription: aCommand). ^false].
! !


!MarsRover methodsFor: 'movements' stamp: 'PGTA 10/26/2020 16:22:48'!
rotateLeft

	^ orientation := orientation ninetyDegreeClockwiseRotation! !

!MarsRover methodsFor: 'movements' stamp: 'PGTA 10/26/2020 16:23:10'!
rotateRight

	^ orientation := orientation ninetyDegreeCounterclockwiseRotation! !

!MarsRover methodsFor: 'movements' stamp: 'PGTA 10/26/2020 16:21:36'!
stepBackward

	^ position := position +			orientation backwardPointDisplacement! !

!MarsRover methodsFor: 'movements' stamp: 'PGTA 10/26/2020 16:21:49'!
stepForward

	position := position + orientation forwardPointDisplacement! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRoverTDD'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'exeption descriptions' stamp: 'PJ 10/26/2020 13:38:36'!
invalidCommandExceptionDescription: anInvalidCommand
	^'Rover received an invalid command: ', anInvalidCommand asString! !

!MarsRover class methodsFor: 'exeption descriptions' stamp: 'PJ 10/26/2020 13:39:06'!
invalidStartingPointExceptionDescription
	^'Invalid starting point'! !


!MarsRover class methodsFor: 'instance creation' stamp: 'PJ 10/26/2020 13:39:06'!
startPoint: aPoint initialOrientation: anOrientation
	
	(aPoint isKindOf: Point) ifFalse: [^self error: self invalidStartingPointExceptionDescription].
	
	^self new initializeStartPoint: aPoint initialOrientation: anOrientation! !


!classDefinition: #RoverOrientation category: 'MarsRoverTDD'!
Object subclass: #RoverOrientation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!RoverOrientation methodsFor: 'representation' stamp: 'PJ 10/24/2020 20:40:58'!
orientationString
	self subclassResponsibility ! !


!RoverOrientation methodsFor: 'actions' stamp: 'PGTA 10/26/2020 16:21:35'!
backwardPointDisplacement
	self subclassResponsibility ! !

!RoverOrientation methodsFor: 'actions' stamp: 'PGTA 10/26/2020 16:21:49'!
forwardPointDisplacement
	self subclassResponsibility ! !

!RoverOrientation methodsFor: 'actions' stamp: 'PGTA 10/26/2020 16:22:48'!
ninetyDegreeClockwiseRotation
	self subclassResponsibility ! !

!RoverOrientation methodsFor: 'actions' stamp: 'PGTA 10/26/2020 16:23:10'!
ninetyDegreeCounterclockwiseRotation
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverOrientation class' category: 'MarsRoverTDD'!
RoverOrientation class
	instanceVariableNames: ''!

!RoverOrientation class methodsFor: 'instance creation' stamp: 'PJ 10/26/2020 13:22:17'!
initializeFor: anOrientationString
	
	[^(self subclasses detect: [:anOrientation | anOrientation canHandle: anOrientationString]) new]
		on: Error
		do: [^self error: self invalidOrientationErrorDescription]! !


!RoverOrientation class methodsFor: 'object selection' stamp: 'PJ 10/24/2020 20:57:46'!
canHandle: anOrientationString
	self subclassResponsibility ! !


!RoverOrientation class methodsFor: 'error descriptions' stamp: 'PJ 10/26/2020 13:04:00'!
invalidOrientationErrorDescription
	^'Invalid orientation string'! !


!classDefinition: #East category: 'MarsRoverTDD'!
RoverOrientation subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!East methodsFor: 'representation' stamp: 'PJ 10/24/2020 19:19:04'!
orientationString
	^'E'! !


!East methodsFor: 'actions' stamp: 'PGTA 10/26/2020 16:21:36'!
backwardPointDisplacement
	^-1@0! !

!East methodsFor: 'actions' stamp: 'PGTA 10/26/2020 16:21:49'!
forwardPointDisplacement
	^1@0! !

!East methodsFor: 'actions' stamp: 'PGTA 10/26/2020 16:22:48'!
ninetyDegreeClockwiseRotation
	^North new! !

!East methodsFor: 'actions' stamp: 'PGTA 10/26/2020 16:23:10'!
ninetyDegreeCounterclockwiseRotation
	^South new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'East class' category: 'MarsRoverTDD'!
East class
	instanceVariableNames: ''!

!East class methodsFor: 'object selection' stamp: 'PJ 10/24/2020 20:58:19'!
canHandle: anOrientationString
	^anOrientationString = 'E'! !


!classDefinition: #North category: 'MarsRoverTDD'!
RoverOrientation subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!North methodsFor: 'representation' stamp: 'PJ 10/24/2020 19:19:15'!
orientationString
	^'N'! !


!North methodsFor: 'actions' stamp: 'PGTA 10/26/2020 16:21:35'!
backwardPointDisplacement
	^0@-1! !

!North methodsFor: 'actions' stamp: 'PGTA 10/26/2020 16:21:49'!
forwardPointDisplacement
	^0@1! !

!North methodsFor: 'actions' stamp: 'PGTA 10/26/2020 16:22:48'!
ninetyDegreeClockwiseRotation
	^West new! !

!North methodsFor: 'actions' stamp: 'PGTA 10/26/2020 16:23:10'!
ninetyDegreeCounterclockwiseRotation
	^East new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'North class' category: 'MarsRoverTDD'!
North class
	instanceVariableNames: ''!

!North class methodsFor: 'object selection' stamp: 'PJ 10/24/2020 20:58:27'!
canHandle: anOrientationString
	^anOrientationString = 'N'! !


!classDefinition: #South category: 'MarsRoverTDD'!
RoverOrientation subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!South methodsFor: 'representation' stamp: 'PJ 10/24/2020 19:19:45'!
orientationString
	^'S'! !


!South methodsFor: 'actions' stamp: 'PGTA 10/26/2020 16:21:35'!
backwardPointDisplacement
	^0@1! !

!South methodsFor: 'actions' stamp: 'PGTA 10/26/2020 16:21:49'!
forwardPointDisplacement
	^0@-1! !

!South methodsFor: 'actions' stamp: 'PGTA 10/26/2020 16:22:48'!
ninetyDegreeClockwiseRotation
	^East new! !

!South methodsFor: 'actions' stamp: 'PGTA 10/26/2020 16:23:10'!
ninetyDegreeCounterclockwiseRotation
	^West new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'South class' category: 'MarsRoverTDD'!
South class
	instanceVariableNames: ''!

!South class methodsFor: 'object selection' stamp: 'PJ 10/24/2020 20:58:37'!
canHandle: anOrientationString
	^anOrientationString = 'S'! !


!classDefinition: #West category: 'MarsRoverTDD'!
RoverOrientation subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverTDD'!

!West methodsFor: 'representation' stamp: 'PJ 10/24/2020 19:19:57'!
orientationString
	^'O'! !


!West methodsFor: 'actions' stamp: 'PGTA 10/26/2020 16:21:35'!
backwardPointDisplacement
	^1@0! !

!West methodsFor: 'actions' stamp: 'PGTA 10/26/2020 16:21:49'!
forwardPointDisplacement
	^-1@0! !

!West methodsFor: 'actions' stamp: 'PGTA 10/26/2020 16:22:48'!
ninetyDegreeClockwiseRotation
	^South new! !

!West methodsFor: 'actions' stamp: 'PGTA 10/26/2020 16:23:10'!
ninetyDegreeCounterclockwiseRotation
	^North new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'West class' category: 'MarsRoverTDD'!
West class
	instanceVariableNames: ''!

!West class methodsFor: 'object selection' stamp: 'PJ 10/24/2020 20:58:48'!
canHandle: anOrientationString
	^anOrientationString = 'O'! !
