!classDefinition: #MarsRoverTests category: 'MarsRover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTests methodsFor: 'assertions' stamp: 'sgs 5/17/2021 16:10:40'!
assertPositon: aPosition andDirection: aDirection forMarsRover: aRover

	
	self assert: aPosition equals: aRover position.
	self assert: aDirection equals: aRover direction.! !

!MarsRoverTests methodsFor: 'assertions' stamp: 'sgs 5/17/2021 16:31:46'!
test07TurnLeftLookingEast


	| rover |
	rover _ MarsRover at: 0@0 towardsDirection: 'E'.
	rover processCommands: 'l'.
	
	self assertPositon:  0@0 andDirection: (CardinalPoints  initializeWith:'N') forMarsRover: rover


	! !


!MarsRoverTests methodsFor: 'turning' stamp: 'sgs 5/17/2021 16:31:11'!
test04TurnLeftLookingNorth	

	| rover |
	rover _ MarsRover at: 0@0 towardsDirection: 'N'.
	rover processCommands: 'l'.
	
	self assertPositon:  0@0 andDirection: (CardinalPoints  initializeWith:'W') forMarsRover: rover

	
! !

!MarsRoverTests methodsFor: 'turning' stamp: 'sgs 5/17/2021 16:31:24'!
test05TurnLeftLookingWest	

	| rover |
	rover _ MarsRover at: 0@0 towardsDirection:'W'.
	rover processCommands: 'l'.
	
	self assertPositon:  0@0 andDirection: (CardinalPoints  initializeWith:'S') forMarsRover: rover

	
	! !

!MarsRoverTests methodsFor: 'turning' stamp: 'sgs 5/17/2021 16:31:31'!
test06TurnLeftLookingSouth
	

	| rover |
	rover _ MarsRover at: 0@0 towardsDirection: 'S'.
	rover processCommands: 'l'.
	
	
	self assertPositon:  0@0 andDirection: (CardinalPoints  initializeWith:'E') forMarsRover: rover

	! !

!MarsRoverTests methodsFor: 'turning' stamp: 'sgs 5/17/2021 16:32:03'!
test08TurnRight
	|rover|
	
	rover := MarsRover at: 0@0 towardsDirection: 'N'.
	
	rover processCommands: 'r'.	
	self assertPositon:  0@0 andDirection: (CardinalPoints  initializeWith:'E') forMarsRover: rover.

	
	rover processCommands: 'r'.
	self assertPositon:  0@0 andDirection: (CardinalPoints  initializeWith:'S') forMarsRover: rover.

	rover processCommands: 'r'.
	self assertPositon:  0@0 andDirection: (CardinalPoints  initializeWith:'W') forMarsRover: rover.
	
	rover processCommands: 'r'.
	self assertPositon:  0@0 andDirection: (CardinalPoints  initializeWith:'N') forMarsRover: rover.


! !


!MarsRoverTests methodsFor: 'initialization' stamp: 'sgs 5/17/2021 16:16:03'!
test01InstanceCreation
	
	| aCardinalPoint rover startingPoint |
	startingPoint _ 1@1.
	aCardinalPoint _ 'N'.
	

	rover _ MarsRover at: startingPoint towardsDirection: aCardinalPoint.
	
	self assertPositon: startingPoint andDirection: (CardinalPoints  initializeWith:'N') forMarsRover: rover
! !


!MarsRoverTests methodsFor: 'moving' stamp: 'sgs 5/17/2021 16:30:38'!
test02MoveForwardLookingNorth
	
	| rover |
	rover _ MarsRover at: 0@0 towardsDirection: 'N'.
	rover processCommands: 'f'.
	
	self assertPositon:  0@1 andDirection: (CardinalPoints  initializeWith:'N') forMarsRover: rover! !

!MarsRoverTests methodsFor: 'moving' stamp: 'sgs 5/17/2021 16:30:52'!
test03MoveBackwardsLookingNorth	

	| rover |
	rover _ MarsRover at: 0@0 towardsDirection: 'N'.
	rover processCommands: 'b'.
	
	self assertPositon:  0@-1 andDirection: (CardinalPoints  initializeWith:'N') forMarsRover: rover
	! !

!MarsRoverTests methodsFor: 'moving' stamp: 'sgs 5/17/2021 16:40:16'!
test12MoveForwardLookingSouth
	|rover|
	
	rover := MarsRover at: 0@0 towardsDirection: 'S'.
	rover processCommands: 'f'.
	
	self assert: 0@-1 equals: rover position.! !

!MarsRoverTests methodsFor: 'moving' stamp: 'sgs 5/17/2021 16:40:49'!
test13MoveBackwardsLookingSouth
	|rover|
	
	rover := MarsRover at: 0@0 towardsDirection: 'S'.
	rover processCommands: 'b'.
	
	self assert: 0@1 equals: rover position.
! !

!MarsRoverTests methodsFor: 'moving' stamp: 'sgs 5/17/2021 16:41:10'!
test14MoveForwardLookingEast
	|rover|
	
	rover := MarsRover at: 0@0 towardsDirection: 'E'.
	rover processCommands: 'f'.
	
	self assert: 1@0 equals: rover position.! !

!MarsRoverTests methodsFor: 'moving' stamp: 'sgs 5/17/2021 16:41:31'!
test15MoveBackwardsLookingEast
	|rover|
	
	rover := MarsRover at: 0@0 towardsDirection: 'E'.
	rover processCommands: 'b'.
	
	self assert: -1@0 equals: rover position.! !

!MarsRoverTests methodsFor: 'moving' stamp: 'sgs 5/17/2021 16:42:15'!
test16MoveForwardLookingWest
	|rover|
	
	rover := MarsRover at: 0@0 towardsDirection: 'W'.
	rover processCommands: 'f'.
	
	self assert: -1@0 equals: rover position.! !

!MarsRoverTests methodsFor: 'moving' stamp: 'sgs 5/17/2021 16:42:20'!
test17MoveBackwardsLookingWest
	|rover|
	
	rover := MarsRover at: 0@0 towardsDirection: 'W'.
	rover processCommands: 'b'.
	
	self assert: 1@0 equals: rover position.! !


!MarsRoverTests methodsFor: 'errors' stamp: 'sgs 5/17/2021 16:33:02'!
test09InvalidInstructionShouldRaiseError
	|rover|
	
	rover := MarsRover at: 0@0 towardsDirection: 'N'.
	
	self should: [rover  processCommands: 'k'.]
	raise: Error - MessageNotUnderstood 
	withMessageText: 'Instruccion Invalida'
! !

!MarsRoverTests methodsFor: 'errors' stamp: 'sgs 5/17/2021 16:34:48'!
test10ExecuteMoreThanOneInstruction
	|rover|
	
	rover := MarsRover at: 0@0 towardsDirection: 'N'.

	rover processCommands: 'blffrffrffffflbbb'.
	
	self assertPositon:  3@-2 andDirection: (CardinalPoints initializeWith:'N') forMarsRover: rover.

	
"    Esquema de instrucciones testeadas partiendo desde la posición (0,0) utilizando como guía el conjunto de símbolos (x,y)-i d donde:
		* (x,y) hace referencia a la posición del rover.
		* -i hace referencia a la instruccion ejecutada para llegar a la posicion (x,y) más un cambio de dirección si esa es la instrucción siguiente.
		* d hace referencia a la dirección que apunta el rover en cada posición tras la ejecución de las intrucciones i.
	
	         								                     N
	
					  (-2,1)-fr   >             (-1,1)-f  >             (0,1)-f   >           (1,1)-f  >            (2,1)-f  >            (3,1)-fl ^   
					
	O                            (-2,0)-f  ^                                                 (0,0)-   ^                                                                         (3,0)-b  ^                         E
	
					(-2,-1)-fr ^	(-1,-1)-f <	 (0,-1)-bl   <								 (3,-1)-b ^
					
																									  	 (3,-2)-b ^
						
												     	      S                       "! !

!MarsRoverTests methodsFor: 'errors' stamp: 'sgs 5/17/2021 16:35:03'!
test11InvalidInstructionShouldRaiseErrorOnAStringOfInstructions
	|rover|
	
	rover := MarsRover at: 0@0 towardsDirection: 'N'.
	
	self should: [rover processCommands: 'ffkrff'.]
	raise: Error - MessageNotUnderstood 
	withMessageText: 'Instruccion Invalida'.
	
	self assert: (CardinalPoints initializeWith:'N') equals: rover direction.
	self assert: 0@2 equals: rover position.! !


!classDefinition: #CardinalPoints category: 'MarsRover'!
Object subclass: #CardinalPoints
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalPoints methodsFor: 'moving' stamp: 'sgs 5/17/2021 15:29:00'!
moveBackwardsAccordingToCurrentDirection: aRover
	self subclassResponsibility .! !

!CardinalPoints methodsFor: 'moving' stamp: 'sgs 5/17/2021 15:46:20'!
moveForwardAccordingToCurrentDirection: aRover

	self subclassResponsibility ! !


!CardinalPoints methodsFor: 'comparing' stamp: 'sgs 5/17/2021 16:25:07'!
= aDirection 
	
	^ self class = aDirection class.! !


!CardinalPoints methodsFor: 'lateral directions' stamp: 'sgs 5/17/2021 15:46:26'!
left
	self subclassResponsibility ! !

!CardinalPoints methodsFor: 'lateral directions' stamp: 'sgs 5/17/2021 15:46:18'!
right
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalPoints class' category: 'MarsRover'!
CardinalPoints class
	instanceVariableNames: ''!

!CardinalPoints class methodsFor: 'as yet unclassified' stamp: 'sgs 5/17/2021 15:53:34'!
initializeWith: aDirection

	^(self subclasses detect: [:type | type name = aDirection] ifNone: [self error: 'Invalid direction']) new.! !

!CardinalPoints class methodsFor: 'as yet unclassified' stamp: 'sgs 5/17/2021 16:00:35'!
invalidCardinalPoints
	
	^'Punto cardinal invalido'! !


!classDefinition: #E category: 'MarsRover'!
CardinalPoints subclass: #E
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!E methodsFor: 'lateral directions' stamp: 'sgs 5/17/2021 15:46:56'!
left
	^CardinalPoints initializeWith: 'N'! !

!E methodsFor: 'lateral directions' stamp: 'sgs 5/17/2021 15:47:25'!
right
	^CardinalPoints initializeWith: 'S'! !


!E methodsFor: 'moving' stamp: 'sgs 5/17/2021 15:32:34'!
moveBackwardsAccordingToCurrentDirection: aRover

	aRover moveBackwardsLookingEast.! !

!E methodsFor: 'moving' stamp: 'sgs 5/17/2021 15:39:00'!
moveForwardAccordingToCurrentDirection: aRover
	
	aRover moveForwardLookingEast! !


!classDefinition: #N category: 'MarsRover'!
CardinalPoints subclass: #N
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!N methodsFor: 'lateral directions' stamp: 'sgs 5/17/2021 15:47:45'!
left
	^CardinalPoints initializeWith: 'W'! !

!N methodsFor: 'lateral directions' stamp: 'sgs 5/17/2021 15:47:56'!
right
	^CardinalPoints initializeWith: 'E'! !


!N methodsFor: 'moving' stamp: 'sgs 5/17/2021 15:39:21'!
moveBackwardsAccordingToCurrentDirection: aRover

	aRover moveBackwardsLookingNorth! !

!N methodsFor: 'moving' stamp: 'sgs 5/17/2021 15:39:32'!
moveForwardAccordingToCurrentDirection: aRover

	aRover moveForwardLookingNorth! !


!classDefinition: #S category: 'MarsRover'!
CardinalPoints subclass: #S
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!S methodsFor: 'lateral directions' stamp: 'sgs 5/17/2021 15:48:14'!
left
	^CardinalPoints initializeWith: 'E'! !

!S methodsFor: 'lateral directions' stamp: 'sgs 5/17/2021 15:48:28'!
right
	^CardinalPoints initializeWith: 'W'! !


!S methodsFor: 'moving' stamp: 'sgs 5/17/2021 15:39:44'!
moveBackwardsAccordingToCurrentDirection: aRover

	aRover moveBackwardsLookingSouth! !

!S methodsFor: 'moving' stamp: 'sgs 5/17/2021 15:39:52'!
moveForwardAccordingToCurrentDirection: aRover

	aRover moveForwardLookingSouth! !


!classDefinition: #W category: 'MarsRover'!
CardinalPoints subclass: #W
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!W methodsFor: 'lateral directions' stamp: 'sgs 5/17/2021 15:48:45'!
left
	^CardinalPoints initializeWith: 'S'! !

!W methodsFor: 'lateral directions' stamp: 'sgs 5/17/2021 15:49:22'!
right
	^CardinalPoints initializeWith: 'N'! !


!W methodsFor: 'moving' stamp: 'sgs 5/17/2021 15:40:04'!
moveBackwardsAccordingToCurrentDirection: aRover

	aRover moveBackwardsLookingWest! !

!W methodsFor: 'moving' stamp: 'sgs 5/17/2021 15:40:17'!
moveForwardAccordingToCurrentDirection: aRover

	aRover moveForwardLookingWest! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'location data' stamp: 'sgs 5/17/2021 16:18:16'!
direction

	^direction! !

!MarsRover methodsFor: 'location data' stamp: 'ERMC 5/16/2021 22:37:49'!
position

	^position! !


!MarsRover methodsFor: 'initialization' stamp: 'sgs 5/17/2021 15:57:18'!
initializeAtPosition: aPoint towardsDirection: aCardinalPoint 

	position _ aPoint.
	direction _ CardinalPoints initializeWith: aCardinalPoint.
	! !


!MarsRover methodsFor: 'moving looking north' stamp: 'sgs 5/17/2021 15:40:47'!
moveBackwardsLookingNorth

	position _ position x @ (position y -1)! !

!MarsRover methodsFor: 'moving looking north' stamp: 'sgs 5/17/2021 15:41:37'!
moveForwardLookingNorth

	position _ position x @ (position y +1)! !


!MarsRover methodsFor: 'moving looking east' stamp: 'sgs 5/17/2021 15:37:58'!
moveBackwardsLookingEast

	position _ position x -1 @ position y! !

!MarsRover methodsFor: 'moving looking east' stamp: 'sgs 5/17/2021 15:38:18'!
moveForwardLookingEast
	
	position _ position x +1 @ position y! !


!MarsRover methodsFor: 'moving looking south' stamp: 'sgs 5/17/2021 15:40:54'!
moveBackwardsLookingSouth

	position _ position x @ (position y +1)! !

!MarsRover methodsFor: 'moving looking south' stamp: 'sgs 5/17/2021 15:41:45'!
moveForwardLookingSouth

	position _ position x @ (position y -1)! !


!MarsRover methodsFor: 'commands' stamp: 'sgs 5/17/2021 15:09:31'!
execute: aCommand

	|instruccionActual|

	instruccionActual := MarsRoverCommands initializeWith: aCommand.
	
	instruccionActual sendInstructionTo: self.
	"
	(commandsPackedInString = 'f') ifTrue: [position _ (position x)@(position y +1)].
	(commandsPackedInString = 'b') ifTrue: [position _ (position x)@(position y -1)].
	
	(commandsPackedInString = 'l' and: cardinalPoint = #N) ifTrue: [cardinalPoint _  #W] ifFalse: [
	(cardinalPoint = #W) ifTrue: [cardinalPoint _  #S] ifFalse: [
	(cardinalPoint = #S) ifTrue: [cardinalPoint _  #E] ifFalse: [
	(cardinalPoint = #E) ifTrue: [cardinalPoint _  #N]]]].

	(commandsPackedInString = 'r' and: cardinalPoint = #N) ifTrue: [cardinalPoint _  #E] ifFalse: [
	(cardinalPoint = #E) ifTrue: [cardinalPoint _  #S] ifFalse: [
	(cardinalPoint = #S) ifTrue: [cardinalPoint _  #W] ifFalse: [
	(cardinalPoint = #W) ifTrue: [cardinalPoint _  #N]]]].

"! !

!MarsRover methodsFor: 'commands' stamp: 'sgs 5/17/2021 15:28:41'!
moveBackwards

	direction moveBackwardsAccordingToCurrentDirection:self.! !

!MarsRover methodsFor: 'commands' stamp: 'sgs 5/17/2021 15:41:18'!
moveForward

	direction moveForwardAccordingToCurrentDirection:self.! !

!MarsRover methodsFor: 'commands' stamp: 'sgs 5/17/2021 15:08:49'!
processCommands: commandsPackedInString

	commandsPackedInString do:[:aCommand| self execute: aCommand].
	"
	(commandsPackedInString = 'f') ifTrue: [position _ (position x)@(position y +1)].
	(commandsPackedInString = 'b') ifTrue: [position _ (position x)@(position y -1)].
	
	(commandsPackedInString = 'l' and: cardinalPoint = #N) ifTrue: [cardinalPoint _  #W] ifFalse: [
	(cardinalPoint = #W) ifTrue: [cardinalPoint _  #S] ifFalse: [
	(cardinalPoint = #S) ifTrue: [cardinalPoint _  #E] ifFalse: [
	(cardinalPoint = #E) ifTrue: [cardinalPoint _  #N]]]].

	(commandsPackedInString = 'r' and: cardinalPoint = #N) ifTrue: [cardinalPoint _  #E] ifFalse: [
	(cardinalPoint = #E) ifTrue: [cardinalPoint _  #S] ifFalse: [
	(cardinalPoint = #S) ifTrue: [cardinalPoint _  #W] ifFalse: [
	(cardinalPoint = #W) ifTrue: [cardinalPoint _  #N]]]].

"! !

!MarsRover methodsFor: 'commands' stamp: 'sgs 5/17/2021 15:45:46'!
turnLeft
	direction := direction left! !

!MarsRover methodsFor: 'commands' stamp: 'sgs 5/17/2021 15:45:54'!
turnRight
	direction := direction right! !


!MarsRover methodsFor: 'moving looking west' stamp: 'sgs 5/17/2021 15:41:05'!
moveBackwardsLookingWest

	position _ position x +1 @ position y! !

!MarsRover methodsFor: 'moving looking west' stamp: 'sgs 5/17/2021 15:41:55'!
moveForwardLookingWest

	position _ position x -1 @ position y! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'sgs 5/17/2021 15:55:39'!
at: aPoint towardsDirection: aCardinalPoint 
	
	^self new initializeAtPosition: aPoint towardsDirection: aCardinalPoint. 
! !


!classDefinition: #MarsRoverCommands category: 'MarsRover'!
Object subclass: #MarsRoverCommands
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverCommands methodsFor: 'forwarding instructions to rover' stamp: 'sgs 5/17/2021 15:17:08'!
sendInstructionTo: aRover
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverCommands class' category: 'MarsRover'!
MarsRoverCommands class
	instanceVariableNames: ''!

!MarsRoverCommands class methodsFor: 'as yet unclassified' stamp: 'sgs 5/17/2021 15:12:22'!
initializeWith: aCommand

	^(self subclasses detect: [:type | type name = aCommand asString capitalized] ifNone: [self error: self invalidCommand]) new.! !

!MarsRoverCommands class methodsFor: 'as yet unclassified' stamp: 'sgs 5/17/2021 16:33:22'!
invalidCommand
	
	^'Instruccion Invalida'! !


!classDefinition: #B category: 'MarsRover'!
MarsRoverCommands subclass: #B
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!B methodsFor: 'forwarding instructions to rover' stamp: 'sgs 5/17/2021 15:17:34'!
sendInstructionTo: aRover
	aRover moveBackwards.! !


!classDefinition: #F category: 'MarsRover'!
MarsRoverCommands subclass: #F
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!F methodsFor: 'forwarding instructions to rover' stamp: 'sgs 5/17/2021 15:17:54'!
sendInstructionTo: aRover
	aRover moveForward.! !


!classDefinition: #L category: 'MarsRover'!
MarsRoverCommands subclass: #L
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!L methodsFor: 'forwarding instructions to rover' stamp: 'sgs 5/17/2021 15:18:09'!
sendInstructionTo: aRover
	aRover turnLeft.! !


!classDefinition: #R category: 'MarsRover'!
MarsRoverCommands subclass: #R
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!R methodsFor: 'forwarding instructions to rover' stamp: 'sgs 5/17/2021 15:18:20'!
sendInstructionTo: aRover
	aRover turnRight.! !
