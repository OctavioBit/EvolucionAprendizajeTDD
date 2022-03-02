!classDefinition: #MarsRoverTest category: #'MarsRover-Exercise'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'marsRoverInOriginPoitingToNorth marsRoverInOriginPoitingToSouth'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverTest methodsFor: 'private' stamp: 'ja 10/25/2020 13:58:30'!
assertThat: aMarsRover isInPosition: aPosition poitingTo: aCardinalPoint
	
	self assert: (aMarsRover isInPosition: aPosition).
	
	self assert: (aMarsRover isPointingTo: aCardinalPoint).
	! !

!MarsRoverTest methodsFor: 'private' stamp: 'ja 10/25/2020 21:47:04'!
should: aBlockWithInvalidCommand raiseInvalidCommandErrorAsserting: aBlockToAssert 
	
	self should: aBlockWithInvalidCommand 
		raise: Error 
		withMessageText: MarsRover invalidComandErrorDescription.
		
	aBlockToAssert value! !


!MarsRoverTest methodsFor: 'setUp/tearDown' stamp: 'ja 10/25/2020 16:28:14'!
setUp 
	
	marsRoverInOriginPoitingToNorth _ MarsRover inPosition: (0@0) andDirection: $N.
	
	marsRoverInOriginPoitingToSouth _ MarsRover inPosition: (0@0) andDirection: $S.! !


!MarsRoverTest methodsFor: 'testing-composed movements' stamp: 'ja 10/25/2020 14:13:37'!
test07MakesComposedMovementCorrectly
	
	marsRoverInOriginPoitingToNorth move: 'frr'.
	
	marsRoverInOriginPoitingToSouth move: 'frr'.
		
	self assertThat: marsRoverInOriginPoitingToNorth isInPosition: (0@1)  poitingTo: $S.

	self assertThat: marsRoverInOriginPoitingToSouth isInPosition: (0@-1)  poitingTo: $N.
	

	! !

!MarsRoverTest methodsFor: 'testing-composed movements' stamp: 'ja 10/25/2020 21:48:32'!
test08ComposedMovementIsExecutedUntilInvalidCommandFound
	
	| marsRoverThatWillReceiveInvalidCommand marsRoverThatWillNotReceiveInvalidCommand |
	
	marsRoverThatWillReceiveInvalidCommand _ MarsRover inPosition: (0@0) andDirection: $N.
	
	marsRoverThatWillNotReceiveInvalidCommand _ MarsRover inPosition: (0@0) andDirection: $N.
	
	marsRoverThatWillNotReceiveInvalidCommand move: 'frr'.
	
	self should:  [marsRoverThatWillReceiveInvalidCommand move: 'frrjb'. self fail] 
	      raiseInvalidCommandErrorAsserting: [self  assert: marsRoverThatWillReceiveInvalidCommand = marsRoverThatWillNotReceiveInvalidCommand ].
! !


!MarsRoverTest methodsFor: 'testing-simple movements' stamp: 'ja 10/25/2020 14:03:03'!
test02MovesForwardCorrectly
	
	marsRoverInOriginPoitingToNorth move: 'f'.
	
	marsRoverInOriginPoitingToSouth move: 'f'.
	
	self assertThat: marsRoverInOriginPoitingToNorth isInPosition: (0@1)  poitingTo: $N.
	
	self assertThat: marsRoverInOriginPoitingToSouth isInPosition: (0@-1) poitingTo: $S.
	
	
	! !

!MarsRoverTest methodsFor: 'testing-simple movements' stamp: 'ja 10/25/2020 14:04:57'!
test03MovesRigthCorrectly
	
	marsRoverInOriginPoitingToNorth move: 'r'.
	
	marsRoverInOriginPoitingToSouth move: 'r'.
	
	self assertThat: marsRoverInOriginPoitingToNorth isInPosition: (0@0)  poitingTo: $E.
	
	self assertThat: marsRoverInOriginPoitingToSouth isInPosition: (0@0) poitingTo: $W.

	
	! !

!MarsRoverTest methodsFor: 'testing-simple movements' stamp: 'ja 10/25/2020 14:06:05'!
test04MovesLeftCorrectly
	
	marsRoverInOriginPoitingToNorth move: 'l'.
	
	marsRoverInOriginPoitingToSouth move: 'l'.
	
	self assertThat: marsRoverInOriginPoitingToNorth isInPosition: (0@0)  poitingTo: $W.
	
	self assertThat: marsRoverInOriginPoitingToSouth isInPosition: (0@0) poitingTo: $E.

	
	! !

!MarsRoverTest methodsFor: 'testing-simple movements' stamp: 'ja 10/25/2020 14:07:27'!
test05MovesBackwardCorrectly
	
	marsRoverInOriginPoitingToNorth move: 'b'.
	
	marsRoverInOriginPoitingToSouth move: 'b'.
	
	self assertThat: marsRoverInOriginPoitingToNorth isInPosition: (0@-1)  poitingTo: $N.
	
	self assertThat: marsRoverInOriginPoitingToSouth isInPosition: (0@1) poitingTo: $S.
	
	! !

!MarsRoverTest methodsFor: 'testing-simple movements' stamp: 'ja 10/25/2020 21:46:57'!
test06OnInvalidCommandDoNothingAndRaiseException

	self should: [marsRoverInOriginPoitingToNorth move: 'k'. self fail] 
	       raiseInvalidCommandErrorAsserting: [self assertThat: marsRoverInOriginPoitingToNorth isInPosition: (0@0) poitingTo: 	$N.	]! !


!MarsRoverTest methodsFor: 'testing-initialization' stamp: 'ja 10/25/2020 14:01:22'!
test01AtTheBeginningHasPositionAndCardinalPoint
	
	self assertThat: marsRoverInOriginPoitingToNorth isInPosition: (0@0)  poitingTo: $N.
	
	self assertThat: marsRoverInOriginPoitingToSouth isInPosition: (0@0)  poitingTo: $S.
	! !


!MarsRoverTest methodsFor: 'testing-input validation' stamp: 'ja 10/25/2020 16:28:38'!
test09PositionShouldBeAPoint

	| invalidMarsRover |
	
	self should: [invalidMarsRover _ MarsRover inPosition: 'something' andDirection: $N. self fail]
	      raise: Error 
	      withMessageText: MarsRover invalidPositionProvidedErrorDescription.
	! !

!MarsRoverTest methodsFor: 'testing-input validation' stamp: 'ja 10/25/2020 16:28:46'!
test10CardinalPointShouldBeValid

	| invalidMarsRover |
	
	self should: [invalidMarsRover _ MarsRover inPosition: (0@0) andDirection: $K. self fail]
	      raise: Error 
	      withMessageText: MarsRover invalidCardinalPointProvidedErrorDescription.
	! !


!classDefinition: #MarsRover category: #'MarsRover-Exercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRover methodsFor: 'initialization' stamp: 'ja 10/25/2020 16:27:01'!
initializeInPosition: aPosition andDirection: aCardinalPoint 
	
	position := aPosition.
	
	direction := aCardinalPoint .! !


!MarsRover methodsFor: 'testing' stamp: 'ja 10/25/2020 14:39:35'!
isInPosition: aPosition 
	
	^ position = aPosition .! !

!MarsRover methodsFor: 'testing' stamp: 'ja 10/25/2020 16:22:57'!
isPointingTo: aCardinalPoint 
	
	^ direction is: aCardinalPoint  .! !


!MarsRover methodsFor: 'accessing' stamp: 'ja 10/25/2020 16:42:32'!
direction
	
	^ direction! !

!MarsRover methodsFor: 'accessing' stamp: 'ja 10/25/2020 13:31:37'!
position
	
	^position! !


!MarsRover methodsFor: 'rotation' stamp: 'ja 10/25/2020 16:22:57'!
pointToEast

	direction _ East new.! !

!MarsRover methodsFor: 'rotation' stamp: 'ja 10/25/2020 16:22:57'!
pointToNorth

	direction _ North new.! !

!MarsRover methodsFor: 'rotation' stamp: 'ja 10/25/2020 16:22:56'!
pointToSouth

	direction _ South new.! !

!MarsRover methodsFor: 'rotation' stamp: 'ja 10/25/2020 16:22:56'!
pointToWest

	direction _ West new.! !


!MarsRover methodsFor: 'movement' stamp: 'ja 10/25/2020 16:33:20'!
exec: aCommand
											
	 direction follow: aCommand on: self . ! !

!MarsRover methodsFor: 'movement' stamp: 'ja 10/25/2020 21:31:50'!
move: aCommandCollection
											
	aCommandCollection do: [ :aCommand |  self exec: aCommand  ]! !


!MarsRover methodsFor: 'comparation' stamp: 'ja 10/25/2020 16:42:43'!
= anOtherMarsRover

	^ position = anOtherMarsRover position and: (direction = anOtherMarsRover 	direction).! !


!MarsRover methodsFor: 'translation' stamp: 'ja 10/25/2020 12:45:16'!
decrementPositionX

	position _ position - (1@0).! !

!MarsRover methodsFor: 'translation' stamp: 'ja 10/25/2020 12:45:35'!
decrementPositionY

	position _ position - (0@1).! !

!MarsRover methodsFor: 'translation' stamp: 'ja 10/25/2020 12:45:43'!
incrementPositionX

	position _ position + (1@0).! !

!MarsRover methodsFor: 'translation' stamp: 'ja 10/25/2020 12:45:55'!
incrementPositionY

	position _ position + (0@1).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'MarsRover-Exercise'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'error handling-description' stamp: 'ja 10/25/2020 15:00:02'!
invalidCardinalPointProvidedErrorDescription

	^ 'El punto cardinal es invalido'! !

!MarsRover class methodsFor: 'error handling-description' stamp: 'ja 10/25/2020 13:04:27'!
invalidComandErrorDescription
	
	^ 'Comando invalido'! !

!MarsRover class methodsFor: 'error handling-description' stamp: 'ja 10/25/2020 14:55:06'!
invalidPositionProvidedErrorDescription

	^ 'La posición debe ser un punto'! !


!MarsRover class methodsFor: 'error handling-signal' stamp: 'ja 10/25/2020 15:02:54'!
invalidCardinalPointProvidedErrorSignal
	
	self error: self invalidCardinalPointProvidedErrorDescription .! !

!MarsRover class methodsFor: 'error handling-signal' stamp: 'ja 10/25/2020 13:11:36'!
invalidComandErrorSignal
	
	self error: self invalidComandErrorDescription ! !


!MarsRover class methodsFor: 'private-input validation' stamp: 'ja 10/25/2020 16:48:13'!
shouldBeAPoint: aPosition

	^ (aPosition isKindOf: Point) ifFalse: [ self error: self invalidPositionProvidedErrorDescription ]! !


!MarsRover class methodsFor: 'class initialization' stamp: 'ja 10/25/2020 16:48:13'!
inPosition: aPosition andDirection: aCardinalPoint
	
	| direction |
	
	self shouldBeAPoint: aPosition.
	
	direction _ MarsRoverDirection from: aCardinalPoint .
	
	^ self new initializeInPosition: aPosition andDirection: direction .! !


!classDefinition: #MarsRoverCommand category: #'MarsRover-Exercise'!
Object subclass: #MarsRoverCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverCommand methodsFor: 'execution' stamp: 'ja 10/25/2020 16:37:18'!
execWhenPointingToEastOn: aMarsRover 
	
	self subclassResponsibility ! !

!MarsRoverCommand methodsFor: 'execution' stamp: 'ja 10/25/2020 16:37:36'!
execWhenPointingToNorthOn: aMarsRover 
	
	self subclassResponsibility ! !

!MarsRoverCommand methodsFor: 'execution' stamp: 'ja 10/25/2020 16:37:47'!
execWhenPointingToSouthOn: aMarsRover 
	
	self subclassResponsibility ! !

!MarsRoverCommand methodsFor: 'execution' stamp: 'ja 10/25/2020 16:37:59'!
execWhenPointingToWestOn: aMarsRover 
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverCommand class' category: #'MarsRover-Exercise'!
MarsRoverCommand class
	instanceVariableNames: 'uniqueInstance'!

!MarsRoverCommand class methodsFor: 'class initialization' stamp: 'ja 10/25/2020 15:36:55'!
from: aCommand

	aCommand = $f ifTrue: [^ Forward  new].
	aCommand = $b ifTrue: [^ Backward new].
	aCommand = $r ifTrue: [^ Rigth new].
	aCommand = $l ifTrue: [^ Left new].
	
	MarsRover invalidComandErrorSignal.
	
! !

!MarsRoverCommand class methodsFor: 'class initialization' stamp: 'ja 10/25/2020 15:37:29'!
new

	uniqueInstance ifNil: [ uniqueInstance _  self basicNew ].
	^ uniqueInstance  ! !


!classDefinition: #Backward category: #'MarsRover-Exercise'!
MarsRoverCommand subclass: #Backward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!Backward methodsFor: 'execution' stamp: 'ja 10/25/2020 16:37:18'!
execWhenPointingToEastOn: aMarsRover 

	^ aMarsRover decrementPositionX .! !

!Backward methodsFor: 'execution' stamp: 'ja 10/25/2020 16:37:36'!
execWhenPointingToNorthOn: aMarsRover 
	
	^ aMarsRover decrementPositionY .! !

!Backward methodsFor: 'execution' stamp: 'ja 10/25/2020 16:37:47'!
execWhenPointingToSouthOn: aMarsRover 

	^ aMarsRover incrementPositionY .! !

!Backward methodsFor: 'execution' stamp: 'ja 10/25/2020 16:37:59'!
execWhenPointingToWestOn: aMarsRover 

	^ aMarsRover incrementPositionX ! !


!classDefinition: #Forward category: #'MarsRover-Exercise'!
MarsRoverCommand subclass: #Forward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!Forward methodsFor: 'execution' stamp: 'ja 10/25/2020 16:37:18'!
execWhenPointingToEastOn: aMarsRover 

	^ aMarsRover incrementPositionX ! !

!Forward methodsFor: 'execution' stamp: 'ja 10/25/2020 16:37:36'!
execWhenPointingToNorthOn: aMarsRover 
	
	^ aMarsRover incrementPositionY.! !

!Forward methodsFor: 'execution' stamp: 'ja 10/25/2020 16:37:47'!
execWhenPointingToSouthOn: aMarsRover 
	
	^ aMarsRover decrementPositionY .! !

!Forward methodsFor: 'execution' stamp: 'ja 10/25/2020 16:37:59'!
execWhenPointingToWestOn: aMarsRover 

	^ aMarsRover decrementPositionX .! !


!classDefinition: #Left category: #'MarsRover-Exercise'!
MarsRoverCommand subclass: #Left
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!Left methodsFor: 'execution' stamp: 'ja 10/25/2020 16:37:18'!
execWhenPointingToEastOn: aMarsRover 
	
	^ aMarsRover pointToNorth .! !

!Left methodsFor: 'execution' stamp: 'ja 10/25/2020 16:37:36'!
execWhenPointingToNorthOn: aMarsRover 

	^ aMarsRover pointToWest .! !

!Left methodsFor: 'execution' stamp: 'ja 10/25/2020 16:37:47'!
execWhenPointingToSouthOn: aMarsRover 

	^ aMarsRover  pointToEast .! !

!Left methodsFor: 'execution' stamp: 'ja 10/25/2020 16:37:59'!
execWhenPointingToWestOn: aMarsRover 

	^ aMarsRover  pointToSouth .! !


!classDefinition: #Rigth category: #'MarsRover-Exercise'!
MarsRoverCommand subclass: #Rigth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!Rigth methodsFor: 'execution' stamp: 'ja 10/25/2020 16:37:18'!
execWhenPointingToEastOn: aMarsRover 

	^ aMarsRover pointToSouth .! !

!Rigth methodsFor: 'execution' stamp: 'ja 10/25/2020 16:37:36'!
execWhenPointingToNorthOn: aMarsRover 

	^ aMarsRover pointToEast .! !

!Rigth methodsFor: 'execution' stamp: 'ja 10/25/2020 16:37:47'!
execWhenPointingToSouthOn: aMarsRover 

	^ aMarsRover pointToWest .! !

!Rigth methodsFor: 'execution' stamp: 'ja 10/25/2020 16:37:59'!
execWhenPointingToWestOn: aMarsRover 

	^ aMarsRover pointToNorth .! !


!classDefinition: #MarsRoverDirection category: #'MarsRover-Exercise'!
Object subclass: #MarsRoverDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverDirection methodsFor: 'movement' stamp: 'ja 10/25/2020 16:34:27'!
follow: aCommand on: aMarsRover

	self subclassResponsibility ! !


!MarsRoverDirection methodsFor: 'testing' stamp: 'ja 10/25/2020 12:24:51'!
is: aCardinalPoint 
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverDirection class' category: #'MarsRover-Exercise'!
MarsRoverDirection class
	instanceVariableNames: 'uniqueInstance'!

!MarsRoverDirection class methodsFor: 'class initialization' stamp: 'ja 10/25/2020 16:46:27'!
from: aCardinalPoint

	aCardinalPoint = $N ifTrue: [ ^ North new ].
	aCardinalPoint = $S ifTrue: [ ^ South new ].
	aCardinalPoint = $E ifTrue: [ ^ East new ].
	aCardinalPoint = $W ifTrue: [ ^ West new ].
	
	MarsRover invalidCardinalPointProvidedErrorSignal .
	! !

!MarsRoverDirection class methodsFor: 'class initialization' stamp: 'ja 10/25/2020 13:36:00'!
new

	uniqueInstance ifNil: [ uniqueInstance _  self basicNew ].
	^ uniqueInstance  ! !


!classDefinition: #East category: #'MarsRover-Exercise'!
MarsRoverDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!East methodsFor: 'movement' stamp: 'ja 10/25/2020 16:38:53'!
follow: aCommand on: aMarsRover
	
	^ (MarsRoverCommand from: aCommand) execWhenPointingToEastOn: aMarsRover .
	
! !


!East methodsFor: 'testing' stamp: 'ja 10/25/2020 12:25:37'!
is: aCardinalPoint 
	
	^ aCardinalPoint = $E! !


!classDefinition: #North category: #'MarsRover-Exercise'!
MarsRoverDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!North methodsFor: 'testing' stamp: 'ja 10/25/2020 12:26:06'!
is: aCardinalPoint 
	
	^ aCardinalPoint = $N! !


!North methodsFor: 'movement' stamp: 'ja 10/25/2020 16:39:06'!
follow: aCommand on: aMarsRover

	^ (MarsRoverCommand from: aCommand) execWhenPointingToNorthOn: aMarsRover .! !


!classDefinition: #South category: #'MarsRover-Exercise'!
MarsRoverDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!South methodsFor: 'testing' stamp: 'ja 10/25/2020 12:26:12'!
is: aCardinalPoint 
	
	^ aCardinalPoint = $S! !


!South methodsFor: 'movement' stamp: 'ja 10/25/2020 16:39:13'!
follow: aCommand on: aMarsRover

	^ (MarsRoverCommand from: aCommand) execWhenPointingToSouthOn: aMarsRover .! !


!classDefinition: #West category: #'MarsRover-Exercise'!
MarsRoverDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!West methodsFor: 'testing' stamp: 'ja 10/25/2020 12:26:17'!
is: aCardinalPoint 
	
	^ aCardinalPoint = $W! !


!West methodsFor: 'movement' stamp: 'ja 10/25/2020 16:39:18'!
follow: aCommand on: aMarsRover

	^ (MarsRoverCommand from: aCommand) execWhenPointingToWestOn: aMarsRover .! !
