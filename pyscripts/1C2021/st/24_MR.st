!classDefinition: #MarsRoverTest category: 'Mars-Rover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRoverTest methodsFor: 'assertions' stamp: 'nz 5/16/2021 23:28:02'!
assertMarsRoverAt: aPosition facing: aDirection receiving: aInstructionPackage endsUpAt: expectedPosition facing: expectedDirection
	| marsRover |

	marsRover _ MarsRover at: aPosition facing: aDirection .
	
	marsRover receivePackage: aInstructionPackage .
	
	self assert: (marsRover isAt: expectedPosition facing: expectedDirection).! !


!MarsRoverTest methodsFor: 'invalid instructions' stamp: 'nz 5/17/2021 00:05:37'!
test20AfterInvalidInstructionStopsProcessing
	
	self assertMarsRoverAt: 0 @ 0 facing: #W
		receiving: 'xb' endsUpAt: 0 @ 0 facing: #W.! !

!MarsRoverTest methodsFor: 'invalid instructions' stamp: 'nz 5/17/2021 00:06:29'!
test21InstructionBeforeTheFirstInvalidInstructionAreProcessed
	
	self assertMarsRoverAt: 0 @ 0 facing: #W
		receiving: 'fxb' endsUpAt: -1 @ 0 facing: #W.
		! !


!MarsRoverTest methodsFor: 'creation' stamp: 'nz 5/17/2021 00:11:51'!
test01MarsRoverIsCreatedSuccessfully
	| marsRover initialPosition initialDirection |
	
	initialPosition _ 0 @ 0.
	initialDirection _ #N.
	
	marsRover _ MarsRover at: initialPosition facing: initialDirection.
	
	self assert: (marsRover isAt: initialPosition facing: initialDirection).! !


!MarsRoverTest methodsFor: 'spinning and baby steps' stamp: 'nz 5/16/2021 23:56:36'!
test16ReceiveInstructionsCombiningRightAndForward
	
	self assertMarsRoverAt: 0 @ 0 facing: #N
		receiving: 'rf' endsUpAt: 1 @ 0 facing: #E.! !

!MarsRoverTest methodsFor: 'spinning and baby steps' stamp: 'nz 5/17/2021 00:02:28'!
test17ReceiveInstructionsCombiningLeftAndForward
	
	self assertMarsRoverAt: 0 @ 0 facing: #N
		receiving: 'lf' endsUpAt: -1 @ 0 facing: #W.! !

!MarsRoverTest methodsFor: 'spinning and baby steps' stamp: 'nz 5/17/2021 00:02:22'!
test18ReceiveInstructionsCombiningRightAndBack
	
	self assertMarsRoverAt: 0 @ 0 facing: #W
		receiving: 'rb' endsUpAt: 0 @ -1 facing: #N.! !

!MarsRoverTest methodsFor: 'spinning and baby steps' stamp: 'nz 5/17/2021 00:03:04'!
test19ReceiveInstructionCombiningLeftAndBack
	
	self assertMarsRoverAt: 0 @ 0 facing: #W
		receiving: 'lb' endsUpAt: 0 @ 1 facing: #S.! !


!MarsRoverTest methodsFor: 'empty package' stamp: 'nz 5/16/2021 23:41:37'!
test02ReceiveEmptyPackageDoNothing

	self assertMarsRoverAt: 0 @ 0 facing: #N
		receiving: '' endsUpAt: 0 @ 0 facing: #N.
! !


!MarsRoverTest methodsFor: 'baby steps' stamp: 'nz 5/16/2021 23:42:50'!
test03ReceiveSingleForwardInstruction

	self assertMarsRoverAt: 0 @ 0 facing: #N
		receiving: 'f' endsUpAt: 0 @ 1 facing: #N.
! !

!MarsRoverTest methodsFor: 'baby steps' stamp: 'nz 5/16/2021 23:44:37'!
test04ReceiveSingleBackwardInstruction

	self assertMarsRoverAt: 0 @ 0 facing: #N
		receiving: 'b' endsUpAt: 0 @ -1 facing: #N.
! !


!MarsRoverTest methodsFor: 'multiple baby steps' stamp: 'nz 5/16/2021 23:52:18'!
test11ReceiveMultipleForwardInstructions
	
	self assertMarsRoverAt: 0 @ 0 facing: #N
		receiving: 'ff' endsUpAt: 0 @ 2 facing: #N.
! !

!MarsRoverTest methodsFor: 'multiple baby steps' stamp: 'nz 5/16/2021 23:52:07'!
test12ReceiveMultipleBackwardInstructions
	
	self assertMarsRoverAt: 0 @ 2 facing: #N
		receiving: 'bb' endsUpAt: 0 @ 0 facing: #N.
! !

!MarsRoverTest methodsFor: 'multiple baby steps' stamp: 'nz 5/17/2021 00:12:44'!
test13ReceiveInstructionsToGoBackAndForthEndsUpInTheSamePlace
	
	self assertMarsRoverAt: 0 @ 0 facing: #N
		receiving: 'bf' endsUpAt: 0 @ 0 facing: #N.
! !

!MarsRoverTest methodsFor: 'multiple baby steps' stamp: 'nz 5/16/2021 23:54:18'!
test14ReceiveMultipleTurnLeftInstructions
	
	self assertMarsRoverAt: 0 @ 0 facing: #N
		receiving: 'll' endsUpAt: 0 @ 0 facing: #S.! !

!MarsRoverTest methodsFor: 'multiple baby steps' stamp: 'nz 5/16/2021 23:54:40'!
test15ReceiveMultipleTurnRightInstructions
	
	self assertMarsRoverAt: 0 @ 0 facing: #N
		receiving: 'rr' endsUpAt: 0 @ 0 facing: #S.
! !


!MarsRoverTest methodsFor: 'spinning' stamp: 'nz 5/16/2021 23:48:46'!
test05ReceiveSingleTurnLeftInstructionFacingNorth
	
	self assertMarsRoverAt: 0 @ 0 facing: #N
		receiving: 'l' endsUpAt: 0 @ 0 facing: #W.
! !

!MarsRoverTest methodsFor: 'spinning' stamp: 'nz 5/16/2021 23:45:34'!
test06ReceiveSingleTurnRightInstructionFacingNorth

	self assertMarsRoverAt: 0 @ 0 facing: #N
		receiving: 'r' endsUpAt: 0 @ 0 facing: #E.
! !

!MarsRoverTest methodsFor: 'spinning' stamp: 'nz 5/16/2021 23:46:07'!
test07ReceiveSingleTurnRightInstructionFacingSouth

	self assertMarsRoverAt: 0 @ 0 facing: #S
		receiving: 'r' endsUpAt: 0 @ 0 facing: #W.
! !

!MarsRoverTest methodsFor: 'spinning' stamp: 'nz 5/16/2021 23:46:54'!
test08ReceiveSingleTurnRightInstructionFacingWest
	
	self assertMarsRoverAt: 0 @ 0 facing: #W
		receiving: 'r' endsUpAt: 0 @ 0 facing: #N.
! !

!MarsRoverTest methodsFor: 'spinning' stamp: 'nz 5/16/2021 23:46:39'!
test09ReceiveSingleTurnRightInstructionFacingEast
	
	self assertMarsRoverAt: 0 @ 0 facing: #E
		receiving: 'r' endsUpAt: 0 @ 0 facing: #S.
! !

!MarsRoverTest methodsFor: 'spinning' stamp: 'nz 5/16/2021 23:49:16'!
test10ReceiveSingleTurnLeftInstructionFacingEast
	
	self assertMarsRoverAt: 0 @ 0 facing: #E
		receiving: 'l' endsUpAt: 0 @ 0 facing: #N.
! !


!classDefinition: #MarsRover category: 'Mars-Rover'!
Object subclass: #MarsRover
	instanceVariableNames: 'currentPosition currentDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRover methodsFor: 'initialization' stamp: 'nz 5/16/2021 23:34:54'!
initializeAt: aInitialPosition facing: aDirectionSymbol 

	currentPosition := aInitialPosition.
	currentDirection := MarsRoverDirection for: aDirectionSymbol.! !


!MarsRover methodsFor: 'testing' stamp: 'nz 5/16/2021 23:27:08'!
isAt: aPosition facing: aDirection 
	^currentPosition = aPosition and: [ currentDirection = (MarsRoverDirection for: aDirection) ].! !


!MarsRover methodsFor: 'package processing' stamp: 'nz 5/16/2021 23:00:22'!
processInstruction: aMarsRoverInstruction onError: anErrorBlock

	aMarsRoverInstruction executeWith: self onError: anErrorBlock.
	! !

!MarsRover methodsFor: 'package processing' stamp: 'nz 5/16/2021 23:23:13'!
receivePackage: anInstructionPackage

	anInstructionPackage do: [:instructionChar | 
		self processInstruction: (MarsRoverInstruction for: instructionChar)
			onError: [ ^nil. ] .
	].
! !


!MarsRover methodsFor: 'movement' stamp: 'nz 5/16/2021 23:24:35'!
goBackward

	currentPosition := currentPosition + (currentDirection getBackwardVector)! !

!MarsRover methodsFor: 'movement' stamp: 'nz 5/16/2021 23:24:27'!
goForward

	currentPosition := currentPosition + currentDirection getForwardVector.
! !

!MarsRover methodsFor: 'movement' stamp: 'AW 5/16/2021 18:33:00'!
turnLeft

	currentDirection _ currentDirection directionToTheLeft.! !

!MarsRover methodsFor: 'movement' stamp: 'AW 5/16/2021 18:29:54'!
turnRight

	currentDirection _ currentDirection directionToTheRight.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Mars-Rover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'nz 5/16/2021 23:34:54'!
at: aInitialPosition facing: aDirectionSymbol 

	^self new initializeAt: aInitialPosition facing: aDirectionSymbol ! !


!classDefinition: #MarsRoverDirection category: 'Mars-Rover'!
Object subclass: #MarsRoverDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRoverDirection methodsFor: 'accessing' stamp: 'AW 5/16/2021 18:36:43'!
directionToTheLeft
	
	self subclassResponsibility.! !

!MarsRoverDirection methodsFor: 'accessing' stamp: 'AW 5/16/2021 18:36:37'!
directionToTheRight
	
	self subclassResponsibility.! !

!MarsRoverDirection methodsFor: 'accessing' stamp: 'AW 5/16/2021 18:25:23'!
getBackwardVector
	
	^self getForwardVector negated.! !

!MarsRoverDirection methodsFor: 'accessing' stamp: 'AW 5/16/2021 18:26:13'!
getForwardVector
	
	self subclassResponsibility.! !


!MarsRoverDirection methodsFor: 'comparing' stamp: 'AW 5/16/2021 18:23:56'!
= otherDirection

	^self class = otherDirection class.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverDirection class' category: 'Mars-Rover'!
MarsRoverDirection class
	instanceVariableNames: ''!

!MarsRoverDirection class methodsFor: 'instance creation' stamp: 'AW 5/16/2021 18:08:40'!
for: aDirection 
	
	(aDirection = #S) ifTrue: [		^MarsRoverSouthDirection new.	].
	(aDirection = #E) ifTrue: [		^MarsRoverEastDirection new. ].
	(aDirection = #N) ifTrue: [		^MarsRoverNorthDirection new. ].
	(aDirection = #W) ifTrue: [		^MarsRoverWestDirection new.	].
	
	^self error: self invalidDirectionDescription.	! !


!MarsRoverDirection class methodsFor: 'errors' stamp: 'AW 5/16/2021 18:09:14'!
invalidDirectionDescription

	^'Direccion invalida, intente de nuevo por favor'.! !


!classDefinition: #MarsRoverEastDirection category: 'Mars-Rover'!
MarsRoverDirection subclass: #MarsRoverEastDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRoverEastDirection methodsFor: 'accessing' stamp: 'AW 5/16/2021 18:35:57'!
directionToTheLeft
	^MarsRoverDirection for: #N.! !

!MarsRoverEastDirection methodsFor: 'accessing' stamp: 'AW 5/16/2021 18:35:37'!
directionToTheRight
	^MarsRoverDirection for: #S.! !

!MarsRoverEastDirection methodsFor: 'accessing' stamp: 'AW 5/16/2021 18:26:37'!
getForwardVector

	^1 @ 0! !


!classDefinition: #MarsRoverNorthDirection category: 'Mars-Rover'!
MarsRoverDirection subclass: #MarsRoverNorthDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRoverNorthDirection methodsFor: 'accessing' stamp: 'AW 5/16/2021 18:33:40'!
directionToTheLeft
	
	^MarsRoverDirection for: #W.! !

!MarsRoverNorthDirection methodsFor: 'accessing' stamp: 'nz 5/17/2021 00:14:37'!
directionToTheRight

	^MarsRoverDirection for: #E.! !

!MarsRoverNorthDirection methodsFor: 'accessing' stamp: 'AW 5/16/2021 18:26:48'!
getForwardVector

	^0 @ 1! !


!classDefinition: #MarsRoverSouthDirection category: 'Mars-Rover'!
MarsRoverDirection subclass: #MarsRoverSouthDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRoverSouthDirection methodsFor: 'accessing' stamp: 'AW 5/16/2021 18:37:15'!
directionToTheLeft
	^MarsRoverDirection for: #E.! !

!MarsRoverSouthDirection methodsFor: 'accessing' stamp: 'AW 5/16/2021 18:34:27'!
directionToTheRight
	^MarsRoverDirection for: #W.! !

!MarsRoverSouthDirection methodsFor: 'accessing' stamp: 'AW 5/16/2021 18:27:07'!
getForwardVector

	^0 @ -1! !


!classDefinition: #MarsRoverWestDirection category: 'Mars-Rover'!
MarsRoverDirection subclass: #MarsRoverWestDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRoverWestDirection methodsFor: 'accessing' stamp: 'AW 5/16/2021 18:34:00'!
directionToTheLeft
	^MarsRoverDirection for: #S.! !

!MarsRoverWestDirection methodsFor: 'accessing' stamp: 'AW 5/16/2021 18:34:54'!
directionToTheRight
	^MarsRoverDirection for: #N.! !

!MarsRoverWestDirection methodsFor: 'accessing' stamp: 'AW 5/16/2021 18:27:15'!
getForwardVector

	^-1 @ 0! !


!classDefinition: #MarsRoverInstruction category: 'Mars-Rover'!
Object subclass: #MarsRoverInstruction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRoverInstruction methodsFor: 'execution' stamp: 'nz 5/16/2021 23:28:59'!
executeWith: aMarsRover onError: anErrorBlock 
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverInstruction class' category: 'Mars-Rover'!
MarsRoverInstruction class
	instanceVariableNames: ''!

!MarsRoverInstruction class methodsFor: 'instance creation' stamp: 'nz 5/16/2021 23:03:24'!
for: aCharacter 
		
	(aCharacter = $f) ifTrue: [ ^MarsRoverGoForwardInstruction new. ].
	(aCharacter = $b) ifTrue: [ ^MarsRoverGoBackwardInstruction new. ].
	(aCharacter = $l) ifTrue: [ ^MarsRoverTurnLeftInstruction new. ].
	(aCharacter = $r) ifTrue: [ ^MarsRoverTurnRightInstruction new. ].
	^MarsRoverInvalidInstruction new.! !


!classDefinition: #MarsRoverGoBackwardInstruction category: 'Mars-Rover'!
MarsRoverInstruction subclass: #MarsRoverGoBackwardInstruction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRoverGoBackwardInstruction methodsFor: 'execution' stamp: 'nz 5/16/2021 23:29:10'!
executeWith: aMarsRover onError: anErrorBlock 
	aMarsRover goBackward! !


!classDefinition: #MarsRoverGoForwardInstruction category: 'Mars-Rover'!
MarsRoverInstruction subclass: #MarsRoverGoForwardInstruction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRoverGoForwardInstruction methodsFor: 'execution' stamp: 'nz 5/16/2021 23:29:15'!
executeWith: aMarsRover onError: anErrorBlock 
	aMarsRover goForward! !


!classDefinition: #MarsRoverInvalidInstruction category: 'Mars-Rover'!
MarsRoverInstruction subclass: #MarsRoverInvalidInstruction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRoverInvalidInstruction methodsFor: 'execution' stamp: 'nz 5/16/2021 23:29:21'!
executeWith: aMarsRover onError: anErrorBlock 
	anErrorBlock value.! !


!classDefinition: #MarsRoverTurnLeftInstruction category: 'Mars-Rover'!
MarsRoverInstruction subclass: #MarsRoverTurnLeftInstruction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRoverTurnLeftInstruction methodsFor: 'execution' stamp: 'nz 5/16/2021 23:29:24'!
executeWith: aMarsRover onError: anErrorBlock 
	aMarsRover turnLeft! !


!classDefinition: #MarsRoverTurnRightInstruction category: 'Mars-Rover'!
MarsRoverInstruction subclass: #MarsRoverTurnRightInstruction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRoverTurnRightInstruction methodsFor: 'execution' stamp: 'nz 5/16/2021 23:29:27'!
executeWith: aMarsRover onError: anErrorBlock 
	aMarsRover turnRight! !
