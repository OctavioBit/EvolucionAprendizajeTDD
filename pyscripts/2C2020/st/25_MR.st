!classDefinition: #MarsRoverTest category: 'MarsRovers - Exercise'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers - Exercise'!

!MarsRoverTest methodsFor: 'initialization' stamp: 'D S 10/24/2020 22:48:41'!
initializeWithLocationX2Y2AndCardinalPoint: aCardinalPoint

	^MarsRover deployInLocation: 2@2 andPointing: aCardinalPoint. ! !


!MarsRoverTest methodsFor: 'tests' stamp: 'D S 10/24/2020 22:49:27'!
test01InitializeWithIndicatedLocation
	| aMarsRover aCardinalPoint|
	aCardinalPoint := 'N'.
	aMarsRover := self initializeWithLocationX2Y2AndCardinalPoint: aCardinalPoint.
	
	self assert: (aMarsRover location) equals: 2@2 ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'D S 10/24/2020 22:49:53'!
test02InitializeWithIndicatedCardinalPoint
	| aMarsRover aCardinalPoint|
	
	aCardinalPoint := 'N'.
	aMarsRover := self initializeWithLocationX2Y2AndCardinalPoint: aCardinalPoint	.
	
	self assert: (aMarsRover pointing) equals: 'N' ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'D S 10/24/2020 22:50:05'!
test03SendingfCommandWhilePointingNorthIncreaseXCoordinateByOne
	| aMarsRover aCardinalPoint|
	aCardinalPoint := 'N'.
	aMarsRover := self initializeWithLocationX2Y2AndCardinalPoint: aCardinalPoint	.
	
	aMarsRover sendCommands: 'f'.
	self assert: aMarsRover location equals: 3@2. ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'D S 10/24/2020 22:50:35'!
test04SendingfCommandWhilePointingSouthDecreaseXCoordinateByOne
	| aMarsRover aCardinalPoint|
	aCardinalPoint := 'S'.
	aMarsRover := self initializeWithLocationX2Y2AndCardinalPoint: aCardinalPoint	.
	
	aMarsRover sendCommands: 'f'.
	self assert: aMarsRover location equals: 1@2. ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'D S 10/24/2020 22:51:07'!
test05SendingfCommandWhilePointingWestDecreaseYCoordinateByOne
	| aMarsRover aCardinalPoint|
	aCardinalPoint := 'O'.
	aMarsRover := self initializeWithLocationX2Y2AndCardinalPoint: aCardinalPoint	.
	
	aMarsRover sendCommands: 'f'.
	self assert: aMarsRover location equals: 2@1. ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'D S 10/24/2020 22:51:13'!
test06SendingfCommandWhilePointingEastIncreaseYCoordinateByOne
	| aMarsRover aLocation aCardinalPoint|
	aCardinalPoint := 'E'.
	aMarsRover := self initializeWithLocationX2Y2AndCardinalPoint: aCardinalPoint	.
	
	aMarsRover sendCommands: 'f'.
	self assert: aMarsRover location equals: 2@3. ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'D S 10/24/2020 22:51:21'!
test07SendingbCommandWhilePointingNorthDecreaseXCoordinateByOne
	| aMarsRover aCardinalPoint|
	aCardinalPoint := 'N'.
	aMarsRover := self initializeWithLocationX2Y2AndCardinalPoint: aCardinalPoint	.
	
	aMarsRover sendCommands: 'b'.
	self assert: aMarsRover location equals: 1@2. ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'D S 10/24/2020 22:51:27'!
test08SendingbCommandWhilePointingSouthIncreaseXCoordinateByOne
	| aMarsRover aCardinalPoint|
	aCardinalPoint := 'S'.
	aMarsRover := self initializeWithLocationX2Y2AndCardinalPoint: aCardinalPoint	.
	
	aMarsRover sendCommands: 'b'.
	self assert: aMarsRover location equals: 3@2. ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'D S 10/24/2020 22:51:35'!
test09SendingbCommandWhilePointingWestIncreaseYCoordinateByOne
	| aMarsRover aCardinalPoint|
	aCardinalPoint := 'O'.
	aMarsRover := self initializeWithLocationX2Y2AndCardinalPoint: aCardinalPoint	.
	
	aMarsRover sendCommands: 'b'.
	self assert: aMarsRover location equals: 2@3. ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'D S 10/24/2020 22:51:45'!
test10SendingbCommandWhilePointingEastDecreaseYCoordinateByOne
	| aMarsRover aCardinalPoint|
	aCardinalPoint := 'E'.
	aMarsRover := self initializeWithLocationX2Y2AndCardinalPoint: aCardinalPoint	.
	
	aMarsRover sendCommands: 'b'.
	self assert: aMarsRover location equals: 2@1. ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'D S 10/24/2020 22:51:51'!
test11SendinglCommandChangeNorthCardinalPointToWest
	| aMarsRover aCardinalPoint|
	aCardinalPoint := 'N'.
	aMarsRover := self initializeWithLocationX2Y2AndCardinalPoint: aCardinalPoint	.
	
	aMarsRover sendCommands: 'l'.
	self assert: aMarsRover pointing equals: 'O'. ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'D S 10/24/2020 22:51:57'!
test12SendinglCommandChangeWestCardinalPointToSouth
	| aMarsRover aCardinalPoint|
	aCardinalPoint := 'O'.
	aMarsRover := self initializeWithLocationX2Y2AndCardinalPoint: aCardinalPoint	.
	
	aMarsRover sendCommands: 'l'.
	self assert: aMarsRover pointing equals: 'S'. ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'D S 10/24/2020 22:52:03'!
test13SendinglCommandChangeSouthCardinalPointToEast
	| aMarsRover aCardinalPoint|
	aCardinalPoint := 'S'.
	aMarsRover := self initializeWithLocationX2Y2AndCardinalPoint: aCardinalPoint	.
	
	aMarsRover sendCommands: 'l'.
	self assert: aMarsRover pointing equals: 'E'. ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'D S 10/24/2020 22:52:09'!
test14SendinglCommandChangeEastCardinalPointToNorth
	| aMarsRover aCardinalPoint|
	aCardinalPoint := 'E'.
	aMarsRover := self initializeWithLocationX2Y2AndCardinalPoint: aCardinalPoint	.
	
	aMarsRover sendCommands: 'l'.
	self assert: aMarsRover pointing equals: 'N'. ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'D S 10/24/2020 22:52:14'!
test15SendingrCommandChangeNorthCardinalPointToEast
	| aMarsRover aCardinalPoint|
	aCardinalPoint := 'N'.
	aMarsRover := self initializeWithLocationX2Y2AndCardinalPoint: aCardinalPoint	.
	
	aMarsRover sendCommands: 'r'.
	self assert: aMarsRover pointing equals: 'E'. ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'D S 10/24/2020 22:52:21'!
test16SendingrCommandChangeEastCardinalPointToSouth
	| aMarsRover aCardinalPoint|
	aCardinalPoint := 'E'.
	aMarsRover := self initializeWithLocationX2Y2AndCardinalPoint: aCardinalPoint	.
	
	aMarsRover sendCommands: 'r'.
	self assert: aMarsRover pointing equals: 'S'. ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'D S 10/24/2020 22:52:27'!
test17SendingrCommandChangeSouthCardinalPointToWest
	| aMarsRover aCardinalPoint|
	aCardinalPoint := 'S'.
	aMarsRover := self initializeWithLocationX2Y2AndCardinalPoint: aCardinalPoint	.
	
	aMarsRover sendCommands: 'r'.
	self assert: aMarsRover pointing equals: 'O'. ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'D S 10/24/2020 22:52:33'!
test18SendingrCommandChangeWestCardinalPointToNorth
	| aMarsRover aCardinalPoint|
	aCardinalPoint := 'O'.
	aMarsRover := self initializeWithLocationX2Y2AndCardinalPoint: aCardinalPoint	.
	
	aMarsRover sendCommands: 'r'.
	self assert: aMarsRover pointing equals: 'N'. ! !

!MarsRoverTest methodsFor: 'tests' stamp: 'D S 10/24/2020 22:52:39'!
test19SendingMoreThanOneCommandExecutesCorrectly
	| aMarsRover aCardinalPoint|
	aCardinalPoint := 'N'.
	aMarsRover := self initializeWithLocationX2Y2AndCardinalPoint: aCardinalPoint	.
	
	aMarsRover sendCommands: 'rf'.
	self assert: 'E' equals: aMarsRover pointing.
	self assert: (2@3) equals: aMarsRover location.

! !

!MarsRoverTest methodsFor: 'tests' stamp: 'D S 10/24/2020 22:52:47'!
test20SendingInvalidCommandsStopsExecutionOfCommandsAndGenerateError
	| aMarsRover aCardinalPoint|
	aCardinalPoint := 'N'.
	aMarsRover := self initializeWithLocationX2Y2AndCardinalPoint: aCardinalPoint	.
	
	
	^ [aMarsRover sendCommands: 'r$%&f'.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (MarsRover invalidCommand: $$)).
			self assert: 'E' equals: aMarsRover pointing.
			self assert: (2@2) equals: aMarsRover location .
].
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'D S 10/24/2020 22:33:52'!
test21RaiseErrorWhenInitializingWithInvalidCardinalPoint
	| aLocation aCardinalPoint|
	aLocation := 2@2.
	aCardinalPoint := 'NonValid'.	
	
	^ [MarsRover deployInLocation: aLocation andPointing: aCardinalPoint.	
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (MarsRover invalidCardinalPoint: aCardinalPoint)).
].
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'D S 10/24/2020 22:34:00'!
test22RaiseErrorWhenInitializingWithInvalidLocation
	| aLocation aCardinalPoint|
	aLocation := 'NotAValidLocation'.
	aCardinalPoint := 'N'.	
	
	^ [MarsRover deployInLocation: aLocation andPointing: aCardinalPoint.	
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: (anError messageText = (MarsRover invalidLocation)).
].
! !


!classDefinition: #MarsRover category: 'MarsRovers - Exercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'location cardinalPoint'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers - Exercise'!

!MarsRover methodsFor: 'initialization' stamp: 'D S 10/24/2020 12:51:30'!
initializeMarsRoverInLocation: aLocation andPointing: aCardinalPoint 
	
	location := aLocation.
	cardinalPoint:= aCardinalPoint! !


!MarsRover methodsFor: 'accessing' stamp: 'D S 10/24/2020 12:46:36'!
location

	^location.! !

!MarsRover methodsFor: 'accessing' stamp: 'D S 10/24/2020 12:53:51'!
pointing

	^cardinalPoint .! !


!MarsRover methodsFor: 'movement --PRIVATE--' stamp: 'D S 10/24/2020 22:43:45'!
executeCommandb

	cardinalPoint = 'N' ifTrue:[location := (location x) - 1 @ (location y)].
	cardinalPoint = 'S' ifTrue:[location := (location x) + 1 @ (location y)].
	cardinalPoint = 'O' ifTrue:[location := (location x) @ ((location y) + 1)].
	cardinalPoint = 'E' ifTrue:[location := (location x) @ ((location y) - 1)].
! !

!MarsRover methodsFor: 'movement --PRIVATE--' stamp: 'D S 10/24/2020 22:43:57'!
executeCommandf

	cardinalPoint = 'N' ifTrue:[location := (location x) + 1 @ (location y)].
	cardinalPoint = 'S' ifTrue:[location := (location x) - 1 @ (location y)].
	cardinalPoint = 'O' ifTrue:[location := (location x) @ ((location y) - 1)].
	cardinalPoint = 'E' ifTrue:[location := (location x) @ ((location y) + 1)].
! !

!MarsRover methodsFor: 'movement --PRIVATE--' stamp: 'D S 10/24/2020 22:44:07'!
executeCommandl

	cardinalPoint = 'E' ifTrue:[cardinalPoint := 'N']
	ifFalse:[
		cardinalPoint = 'S' ifTrue:[cardinalPoint := 'E'].
		cardinalPoint = 'O' ifTrue:[cardinalPoint := 'S'].
		cardinalPoint = 'N' ifTrue:[cardinalPoint := 'O'].
	]
! !

!MarsRover methodsFor: 'movement --PRIVATE--' stamp: 'D S 10/24/2020 22:44:42'!
executeCommandr

	cardinalPoint = 'O' ifTrue: [cardinalPoint := 'N']
	ifFalse:[
		cardinalPoint = 'S' ifTrue: [cardinalPoint := 'O'].
		cardinalPoint = 'E' ifTrue: [cardinalPoint := 'S'].
		cardinalPoint = 'N' ifTrue: [cardinalPoint := 'E'].
	]
	
! !


!MarsRover methodsFor: 'movement' stamp: 'D S 10/24/2020 22:45:08'!
sendCommands: aStringOfCommands
	
	aStringOfCommands do: [: aCharacter |
		aCharacter = $f ifTrue:[self executeCommandf	].
		aCharacter = $b ifTrue: [self executeCommandb].	
	
		aCharacter = $l ifTrue: [self executeCommandl].
		aCharacter = $r ifTrue:[self executeCommandr		].
		(aCharacter ~= $r and: (aCharacter ~= $l and: (aCharacter ~= $f and: (aCharacter ~= $b)))) 
		ifTrue:[	self error: (self class invalidCommand: aCharacter).].
	]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRovers - Exercise'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'D S 10/24/2020 18:26:38'!
deployInLocation: aLocation andPointing: aCardinalPoint 
	
	(aCardinalPoint ~= 'N' and: aCardinalPoint ~= 'S' and: aCardinalPoint ~= 'E' and: aCardinalPoint ~= 'O') ifTrue:
		[self error: (self invalidCardinalPoint: aCardinalPoint)].
	(aLocation class ~~ Point) ifTrue: [self error: (self invalidLocation)].	
	^self new initializeMarsRoverInLocation: aLocation andPointing: aCardinalPoint.! !


!MarsRover class methodsFor: 'error description' stamp: 'D S 10/24/2020 18:16:24'!
invalidCardinalPoint: aCardinalPoint

	^'Invalid Cardinal Point: ' , (aCardinalPoint).! !

!MarsRover class methodsFor: 'error description' stamp: 'D S 10/24/2020 16:05:01'!
invalidCommand: aCharacter

	^'Invalid Command ' , (aCharacter asString).! !

!MarsRover class methodsFor: 'error description' stamp: 'D S 10/24/2020 18:25:43'!
invalidLocation

	^'Invalid Location'! !
