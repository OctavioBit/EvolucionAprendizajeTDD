!classDefinition: #MarsRoverTest category: 'MarsRoverExercise'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverExercise'!

!MarsRoverTest methodsFor: 'creation' stamp: 'CR 10/26/2020 16:20:52'!
test01creatingMarsRoverWithInvalidDirectionRaisesError
	self 
		should: [MarsRover withPosition: 0@0 andDirection: 'X'.]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: MarsRover cantCreateMarsRoverWithInvalidDirection ].
	
	! !


!MarsRoverTest methodsFor: 'actions' stamp: 'CR 10/26/2020 16:21:37'!
test02performingEmptyInstructionRaisesError
	| aMarsRover |
	aMarsRover := MarsRover withPosition: 0@0 andDirection: 'N'.
	self 
		should: [aMarsRover performInstructions: '']
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: MarsRover cantPerformInvalidAction ].
	
	! !

!MarsRoverTest methodsFor: 'actions' stamp: 'CR 10/26/2020 16:23:50'!
test03movingForwardOnNorthMovesNorth
	| aMarsRover |
	aMarsRover := MarsRover withPosition: 0@0 andDirection: 'N'.
	aMarsRover performInstructions: 'f'.
	self assert: aMarsRover position equals: 0@1.
	
	! !

!MarsRoverTest methodsFor: 'actions' stamp: 'CR 10/26/2020 16:23:42'!
test04movingBackwardOnNorthMovesSouth
	| aMarsRover |
	aMarsRover := MarsRover withPosition: 0@0 andDirection: 'N'.
	aMarsRover performInstructions: 'b'.
	self assert: aMarsRover position equals: 0@(-1).
	
	! !

!MarsRoverTest methodsFor: 'actions' stamp: 'CR 10/26/2020 16:25:19'!
test05rotatingLeftPointingNorthPointsWest
	| aMarsRover |
	aMarsRover := MarsRover withPosition: 0@0 andDirection: 'N'.
	aMarsRover performInstructions: 'l'.
	self assert: (aMarsRover direction isKindOf: West).
	
	! !

!MarsRoverTest methodsFor: 'actions' stamp: 'CR 10/26/2020 16:25:49'!
test06rotatingRightPointingNorthPointsEast
	| aMarsRover |
	aMarsRover := MarsRover withPosition: 0@0 andDirection: 'N'.
	aMarsRover performInstructions: 'r'.
	self assert: (aMarsRover direction isKindOf: East).
	
	! !

!MarsRoverTest methodsFor: 'actions' stamp: 'CR 10/26/2020 16:26:38'!
test07movingForwardOnEastMovesEast
	| aMarsRover |
	aMarsRover := MarsRover withPosition: 0@0 andDirection: 'E'.
	aMarsRover performInstructions: 'f'.
	self assert: aMarsRover position equals: 1@0.
	
	! !

!MarsRoverTest methodsFor: 'actions' stamp: 'CR 10/26/2020 16:27:03'!
test08movingBackwardOnEastMovesWest
	| aMarsRover |
	aMarsRover := MarsRover withPosition: 0@0 andDirection: 'E'.
	aMarsRover performInstructions: 'b'.
	self assert: aMarsRover position equals: -1@0.
	
	! !

!MarsRoverTest methodsFor: 'actions' stamp: 'CR 10/26/2020 16:27:29'!
test09rotatingLeftOnEastPointsNorth
	| aMarsRover |
	aMarsRover := MarsRover withPosition: 0@0 andDirection: 'E'.
	aMarsRover performInstructions: 'l'.
	self assert: (aMarsRover direction isKindOf: North).
	
	! !

!MarsRoverTest methodsFor: 'actions' stamp: 'CR 10/26/2020 16:28:00'!
test10rotatingRightOnEastPointsToSouth
	| aMarsRover |
	aMarsRover := MarsRover withPosition: 0@0 andDirection: 'E'.
	aMarsRover performInstructions: 'r'.
	self assert: (aMarsRover direction isKindOf: South).
	
	! !

!MarsRoverTest methodsFor: 'actions' stamp: 'CR 10/26/2020 16:31:59'!
test11performManyInstructionsWorksCorrectly
	| aMarsRover |
	aMarsRover := MarsRover withPosition: 0@0 andDirection: 'S'.
	aMarsRover performInstructions: 'rr'.
	self assert: (aMarsRover direction isKindOf: North).
	
	! !

!MarsRoverTest methodsFor: 'actions' stamp: 'CR 10/26/2020 16:34:24'!
test12movingDiagonallyOnWestMovesSouthWest
	| aMarsRover |
	aMarsRover := MarsRover withPosition: 0@0 andDirection: 'W'.
	aMarsRover performInstructions: 'flf'.
	self assert: (aMarsRover direction isKindOf: South).
	self assert: aMarsRover position equals: -1@-1.
	
	! !


!classDefinition: #Direction category: 'MarsRoverExercise'!
Object subclass: #Direction
	instanceVariableNames: 'marsRoverAttachedTo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverExercise'!

!Direction methodsFor: 'marsrover interaction' stamp: 'CR 10/26/2020 01:16:35'!
moveBackward
	self subclassResponsibility.! !

!Direction methodsFor: 'marsrover interaction' stamp: 'CR 10/26/2020 01:16:31'!
moveForward
	self subclassResponsibility.! !

!Direction methodsFor: 'marsrover interaction' stamp: 'CR 10/26/2020 16:17:46'!
rotateLeft
	self subclassResponsibility.! !

!Direction methodsFor: 'marsrover interaction' stamp: 'CR 10/26/2020 16:17:39'!
rotateRight
	self subclassResponsibility.! !


!Direction methodsFor: 'initialization' stamp: 'CR 10/26/2020 01:07:36'!
initializeWith: aMarsRoverToBeAttachedTo
	
	marsRoverAttachedTo := aMarsRoverToBeAttachedTo.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Direction class' category: 'MarsRoverExercise'!
Direction class
	instanceVariableNames: ''!

!Direction class methodsFor: 'instance creation' stamp: 'CR 10/26/2020 01:06:26'!
for: aMarsRoverToBeAttachedTo
	
	^self new initializeWith: aMarsRoverToBeAttachedTo. ! !


!classDefinition: #East category: 'MarsRoverExercise'!
Direction subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverExercise'!

!East methodsFor: 'marsrover interaction' stamp: 'CR 10/26/2020 01:18:33'!
moveBackward
	marsRoverAttachedTo moveWest.! !

!East methodsFor: 'marsrover interaction' stamp: 'CR 10/26/2020 01:17:04'!
moveForward
	marsRoverAttachedTo moveEast.! !

!East methodsFor: 'marsrover interaction' stamp: 'CR 10/26/2020 01:36:22'!
rotateLeft
	marsRoverAttachedTo pointToNorth.! !

!East methodsFor: 'marsrover interaction' stamp: 'CR 10/26/2020 01:36:30'!
rotateRight
	marsRoverAttachedTo pointToSouth.! !


!classDefinition: #North category: 'MarsRoverExercise'!
Direction subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverExercise'!

!North methodsFor: 'marsrover interaction' stamp: 'CR 10/26/2020 01:19:00'!
moveBackward
	marsRoverAttachedTo moveSouth.! !

!North methodsFor: 'marsrover interaction' stamp: 'CR 10/26/2020 01:18:51'!
moveForward
	marsRoverAttachedTo moveNorth.! !

!North methodsFor: 'marsrover interaction' stamp: 'CR 10/26/2020 01:37:22'!
rotateLeft
	marsRoverAttachedTo pointToWest. ! !

!North methodsFor: 'marsrover interaction' stamp: 'CR 10/26/2020 01:37:35'!
rotateRight
	marsRoverAttachedTo pointToEast. ! !


!classDefinition: #South category: 'MarsRoverExercise'!
Direction subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverExercise'!

!South methodsFor: 'marsrover interaction' stamp: 'CR 10/26/2020 16:17:05'!
moveBackward
	marsRoverAttachedTo moveNorth.! !

!South methodsFor: 'marsrover interaction' stamp: 'CR 10/26/2020 16:15:30'!
moveForward
	marsRoverAttachedTo moveSouth.! !

!South methodsFor: 'marsrover interaction' stamp: 'CR 10/26/2020 16:10:07'!
rotateLeft
	marsRoverAttachedTo pointToEast. ! !

!South methodsFor: 'marsrover interaction' stamp: 'CR 10/26/2020 15:41:06'!
rotateRight
	marsRoverAttachedTo pointToWest.! !


!classDefinition: #West category: 'MarsRoverExercise'!
Direction subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverExercise'!

!West methodsFor: 'marsrover interaction' stamp: 'CR 10/26/2020 16:16:40'!
moveBackward
	marsRoverAttachedTo moveEast.! !

!West methodsFor: 'marsrover interaction' stamp: 'CR 10/26/2020 16:15:11'!
moveForward
	marsRoverAttachedTo moveWest.! !

!West methodsFor: 'marsrover interaction' stamp: 'CR 10/26/2020 16:09:42'!
rotateLeft
	marsRoverAttachedTo pointToSouth.! !

!West methodsFor: 'marsrover interaction' stamp: 'CR 10/26/2020 15:41:43'!
rotateRight
	marsRoverAttachedTo pointToNorth.! !


!classDefinition: #MarsRover category: 'MarsRoverExercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'currentPosition currentDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverExercise'!

!MarsRover methodsFor: 'initialization' stamp: 'CR 10/26/2020 16:37:06'!
initializeWithPosition: aCardinalPointToStartOn andDirection: aCardinalOrientationToPointTo 
	self verifyThatCardinalOrientationIsValid: aCardinalOrientationToPointTo.
	self setDirectionTo: aCardinalOrientationToPointTo.
	currentPosition := aCardinalPointToStartOn.
	! !

!MarsRover methodsFor: 'initialization' stamp: 'CR 10/26/2020 16:37:06'!
setDirectionTo: aCardinalOrientationToPointTo

	(aCardinalOrientationToPointTo = 'N') ifTrue: [self pointToNorth].
	(aCardinalOrientationToPointTo = 'E') ifTrue: [self pointToEast].
	(aCardinalOrientationToPointTo = 'W') ifTrue: [self pointToWest].
	(aCardinalOrientationToPointTo = 'S') ifTrue: [self pointToSouth]! !


!MarsRover methodsFor: 'instruction' stamp: 'CR 10/26/2020 01:20:46'!
moveEast

	currentPosition := (currentPosition x + 1 )@ currentPosition y! !

!MarsRover methodsFor: 'instruction' stamp: 'CR 10/26/2020 01:20:50'!
moveNorth

	currentPosition := currentPosition x @ (currentPosition y + 1)! !

!MarsRover methodsFor: 'instruction' stamp: 'CR 10/26/2020 01:20:53'!
moveSouth

	currentPosition := currentPosition x @ (currentPosition y - 1 )! !

!MarsRover methodsFor: 'instruction' stamp: 'CR 10/26/2020 01:21:19'!
moveWest

	currentPosition := (currentPosition x - 1 ) @ currentPosition y! !

!MarsRover methodsFor: 'instruction' stamp: 'CR 10/26/2020 01:37:57'!
pointToEast
	
	currentDirection := East for: self.! !

!MarsRover methodsFor: 'instruction' stamp: 'CR 10/26/2020 01:36:41'!
pointToNorth
	
	currentDirection := North for: self.! !

!MarsRover methodsFor: 'instruction' stamp: 'CR 10/26/2020 01:34:40'!
pointToSouth
	
	currentDirection := South for: self.! !

!MarsRover methodsFor: 'instruction' stamp: 'CR 10/26/2020 01:37:50'!
pointToWest
	
	currentDirection := West for: self.! !


!MarsRover methodsFor: 'accessing' stamp: 'CR 10/26/2020 00:22:43'!
direction
	^currentDirection.! !

!MarsRover methodsFor: 'accessing' stamp: 'CR 10/26/2020 00:17:45'!
position
	^currentPosition.! !


!MarsRover methodsFor: 'instruction processing' stamp: 'CR 10/26/2020 16:40:27'!
checkIfValidInstructionAndPerform: anInstructionToPerform

		(self isAValidInstruction: anInstructionToPerform) 
		ifTrue: [self performActionWithMarsRover: anInstructionToPerform] 
		ifFalse: 	[self class signalInvalidInstruction.		].! !

!MarsRover methodsFor: 'instruction processing' stamp: 'CR 10/26/2020 16:01:51'!
ifActionIsMoveBackward: anInstructionToPerform

	^ anInstructionToPerform = $b! !

!MarsRover methodsFor: 'instruction processing' stamp: 'CR 10/26/2020 16:01:17'!
ifActionIsMoveForward: anInstructionToPerform

	^ anInstructionToPerform = $f! !

!MarsRover methodsFor: 'instruction processing' stamp: 'CR 10/26/2020 16:02:33'!
ifActionIsRotateLeft: anInstructionToPerform

	^ anInstructionToPerform = $l! !

!MarsRover methodsFor: 'instruction processing' stamp: 'CR 10/26/2020 16:02:53'!
ifActionIsRotateRight: anInstructionToPerform

	^ anInstructionToPerform = $r! !

!MarsRover methodsFor: 'instruction processing' stamp: 'CR 10/26/2020 16:02:58'!
performActionWithMarsRover: anInstructionToPerform

	(self ifActionIsMoveForward: anInstructionToPerform) ifTrue: [currentDirection moveForward.		].
	(self ifActionIsMoveBackward: anInstructionToPerform) ifTrue: [currentDirection moveBackward. ].
	(self ifActionIsRotateLeft: anInstructionToPerform) ifTrue: [currentDirection rotateLeft].
	(self ifActionIsRotateRight: anInstructionToPerform) ifTrue: [currentDirection rotateRight].
			! !

!MarsRover methodsFor: 'instruction processing' stamp: 'CR 10/26/2020 16:40:42'!
performInstructions: instructionsSequenceToPerform

	self verifyThatInstructionsSequenceIsNotEmpty: instructionsSequenceToPerform.
	self processInstructionsSequence: instructionsSequenceToPerform.
	 ! !

!MarsRover methodsFor: 'instruction processing' stamp: 'CR 10/26/2020 15:59:27'!
processInstructionsSequence: instructionsSequenceToPerform

	instructionsSequenceToPerform do: [ : anInstructionToPerform |
		 self checkIfValidInstructionAndPerform: anInstructionToPerform.
	].! !


!MarsRover methodsFor: 'testing' stamp: 'CR 10/26/2020 16:09:05'!
isACardinalPoint: aCardinalOrientationToPointTo

	^ ('NEWS' includes: (aCardinalOrientationToPointTo at: 1)) and: [aCardinalOrientationToPointTo size = 1]! !

!MarsRover methodsFor: 'testing' stamp: 'CR 10/26/2020 15:48:00'!
isAValidInstruction: anInstructionToPerform

	^ 'fbrl' includes: anInstructionToPerform! !

!MarsRover methodsFor: 'testing' stamp: 'CR 10/26/2020 15:47:04'!
verifyThatCardinalOrientationIsValid: aCardinalOrientationToPointTo

	(self isACardinalPoint: aCardinalOrientationToPointTo) ifFalse: [self class signalInvalidDirection ]! !

!MarsRover methodsFor: 'testing' stamp: 'CR 10/26/2020 15:55:33'!
verifyThatInstructionsSequenceIsNotEmpty: instructionSequenceToPerform

	(instructionSequenceToPerform isEmpty) ifTrue: [self class signalInvalidInstruction].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRoverExercise'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'CR 10/25/2020 23:51:59'!
withPosition: aCardinalPointToStartOn andDirection: aCardinalOrientationToPointTo
	
	^self new initializeWithPosition: aCardinalPointToStartOn andDirection: aCardinalOrientationToPointTo.! !


!MarsRover class methodsFor: 'error messages' stamp: 'CR 10/26/2020 15:27:13'!
cantCreateMarsRoverWithInvalidDirection
	
	^'Cant create MarsRover with invalid direction'! !

!MarsRover class methodsFor: 'error messages' stamp: 'CR 10/26/2020 00:02:31'!
cantPerformInvalidAction
	
	^'Cant perform invalid instruction'! !

!MarsRover class methodsFor: 'error messages' stamp: 'CR 10/26/2020 15:27:32'!
signalInvalidDirection
	self error: MarsRover cantCreateMarsRoverWithInvalidDirection.! !

!MarsRover class methodsFor: 'error messages' stamp: 'CR 10/26/2020 00:01:33'!
signalInvalidInstruction
	self error: MarsRover cantPerformInvalidAction.! !
