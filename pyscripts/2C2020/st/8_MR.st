!classDefinition: #MarsRoverTests category: 'EjercicioMarsRover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRover'!

!MarsRoverTests methodsFor: 'tests' stamp: 'EMI 10/24/2020 18:37:56'!
test01MarsRoverReceivingNoInstructionsDoesNotMoveNorRotate
	| rover |
	rover _ MarsRover at: 1@1 withOrientation: $N.
	self assert: (rover position = (1@1)).
	self assert: (rover orientation = $N).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'EMI 10/24/2020 18:37:40'!
test02MarsRoverReceivingEmptyInstructionsDoesNotMoveNorRotate
	| rover |
	rover _ MarsRover at: 1@1 withOrientation: $N.
	rover receiveInstructions: ''.
	self assert: (rover position = (1@1)).
	self assert: (rover orientation = $N).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'EMI 10/24/2020 18:39:03'!
test03MarsRoverMovesOneStep
	| rover |
	rover _ MarsRover at: 1@1 withOrientation: $N.
	rover receiveInstructions: 'f'.
	self assert: (rover position = (0@1)).
	self assert: (rover orientation = $N).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'EMI 10/26/2020 16:24:11'!
test04MarsRoverMovesOneStepBackwards
	| rover |
	rover _ MarsRover at: 1@1 withOrientation: $N.
	rover receiveInstructions: 'b'.
	self assert: (rover position = (2@1)).
	self assert: (rover orientation = $N).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'EMI 10/26/2020 16:24:51'!
test05MarsRoverRotates90DegreesLeft
	| rover |
	rover _ MarsRover at: 1@1 withOrientation: $N.
	rover receiveInstructions: 'l'.
	self assert: (rover position = (1@1)).
	self assert: (rover orientation = $W).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'EMI 10/26/2020 16:25:36'!
test06MarsRoverRotates90DegreesRight
	| rover |
	rover _ MarsRover at: 1@1 withOrientation: $N.
	rover receiveInstructions: 'r'.
	self assert: (rover position = (1@1)).
	self assert: (rover orientation = $E).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'EMI 10/26/2020 16:25:25'!
test07MarsRoverMovesMoreThanOneStep
	| rover |
	rover _ MarsRover at: 1@1 withOrientation: $N.
	rover receiveInstructions: 'ff'.
	self assert: (rover position = (-1@1)).
	self assert: (rover orientation = $N).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'EMI 10/26/2020 16:27:51'!
test08MarsRoverMovesMoreThanOneStepBackwards
	| rover |
	rover _ MarsRover at: 1@1 withOrientation: $N.
	rover receiveInstructions: 'bb'.
	self assert: (rover position = (3@1)).
	self assert: (rover orientation = $N).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'EMI 10/26/2020 16:29:09'!
test09MarsRoverRotatesLeftMoreThanOnce
	| rover |
	rover _ MarsRover at: 1@1 withOrientation: $N.
	rover receiveInstructions: 'll'.
	self assert: (rover position = (1@1)).
	self assert: (rover orientation = $S).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'EMI 10/26/2020 16:28:52'!
test10MarsRoverRotatesRightMoreThanOnce
	| rover |
	rover _ MarsRover at: 1@1 withOrientation: $N.
	rover receiveInstructions: 'rr'.
	self assert: (rover position = (1@1)).
	self assert: (rover orientation = $S).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'EMI 10/26/2020 16:29:42'!
test11MarsRoverRotatesAndMovesOneStepOrMore
	| rover |
	rover _ MarsRover at: 1@1 withOrientation: $N.
	rover receiveInstructions: 'lf'.
	self assert: (rover position = (1@0)).
	self assert: (rover orientation = $W).! !

!MarsRoverTests methodsFor: 'tests' stamp: 'EMI 10/26/2020 16:29:52'!
test12CannotCreateMarsRoverWithWrongOrientation
	self should: [MarsRover at: 1@1 withOrientation: $Z.] 
		raise: Error
		withExceptionDo: [:anError| self assert: anError messageText = MarsRover invalidOrientationErrorMessage ].
	
! !

!MarsRoverTests methodsFor: 'tests' stamp: 'EMI 10/26/2020 16:29:59'!
test13MarsRoverStopsProcessingOnInvalidInstruction
	| rover |
	rover _ MarsRover at: 1@1 withOrientation: $N.
	
	self should: [rover receiveInstructions: 'ref'.] 
	raise: Error 
	withExceptionDo: [:anError |
					self assert: anError messageText = MarsRover invalidInstructionErrorMessage.
					self assert: (rover position = (1@1)).
					self assert: (rover orientation = $E)
				].		! !


!classDefinition: #MarsRover category: 'EjercicioMarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position orientation rotationsCounterClockwise rotationsClockwise'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRover'!

!MarsRover methodsFor: 'initialize' stamp: 'EMI 10/24/2020 18:54:29'!
initializeAt: aPoint withOrientation: aCardinalCharacter 
	position _ aPoint.
	(#($N $W $S $E) includes: aCardinalCharacter) ifFalse: [^Error signal: self class invalidOrientationErrorMessage.].
	orientation _ aCardinalCharacter.
	
	rotationsCounterClockwise _ Dictionary new.
	rotationsCounterClockwise at:$N put:$W.
	rotationsCounterClockwise at:$W put:$S.
	rotationsCounterClockwise at:$S put:$E.
	rotationsCounterClockwise at:$E put:$N.
	
	rotationsClockwise _ Dictionary new.
	rotationsClockwise at:$N put:$E.
	rotationsClockwise at:$E put:$S.
	rotationsClockwise at:$S put:$W.
	rotationsClockwise at:$W put:$N.! !


!MarsRover methodsFor: 'accessing' stamp: 'EMI 10/23/2020 19:28:06'!
orientation
	^orientation.! !

!MarsRover methodsFor: 'accessing' stamp: 'EMI 10/23/2020 19:27:32'!
position
	^position! !


!MarsRover methodsFor: 'instructions - private' stamp: 'EMI 10/26/2020 16:31:41'!
moveOnAxisX: anXAxisOffset andAxisY: anYAxisOffset
	position _ position + (anXAxisOffset@anYAxisOffset).
! !

!MarsRover methodsFor: 'instructions - private' stamp: 'EMI 10/24/2020 19:18:27'!
oneStep: anInstructionsCharacter
	| stepOverAxis |
	stepOverAxis _ anInstructionsCharacter = $f ifTrue:[1] ifFalse:[-1].
	orientation = $W ifTrue:[self moveOnAxisX: 0 andAxisY: stepOverAxis negated].
	orientation = $N ifTrue: [self moveOnAxisX: stepOverAxis negated andAxisY: 0 ].
	orientation = $S ifTrue: [self moveOnAxisX: stepOverAxis andAxisY: 0].
	orientation = $E ifTrue: [self moveOnAxisX: 0 andAxisY: stepOverAxis].
! !

!MarsRover methodsFor: 'instructions - private' stamp: 'EMI 10/24/2020 17:54:59'!
oneStepBackwards
	self oneStep: $b.! !

!MarsRover methodsFor: 'instructions - private' stamp: 'EMI 10/24/2020 17:54:49'!
oneStepFoward
	self oneStep: $f.! !

!MarsRover methodsFor: 'instructions - private' stamp: 'EMI 10/24/2020 18:03:07'!
rotate: aRotationsDictionary
	orientation _ aRotationsDictionary at: orientation.
! !

!MarsRover methodsFor: 'instructions - private' stamp: 'EMI 10/24/2020 18:03:32'!
rotateLeft
	self rotate: rotationsCounterClockwise.
! !

!MarsRover methodsFor: 'instructions - private' stamp: 'EMI 10/24/2020 19:00:02'!
rotateRight
	self rotate: rotationsClockwise.
! !


!MarsRover methodsFor: 'instructions' stamp: 'EMI 10/26/2020 08:54:32'!
receiveInstructions: anInstructionsString
	anInstructionsString isEmpty 
	ifFalse:[
		anInstructionsString do: [:aCharacter |
			(#($f $b $l $r) includes: aCharacter) ifFalse:[^Error signal: self class invalidInstructionErrorMessage ].
			aCharacter = $f ifTrue: [self oneStepFoward.].
			aCharacter = $b ifTrue: [self oneStepBackwards.].
			aCharacter = $l ifTrue: [self rotateLeft.].
			aCharacter = $r ifTrue: [self rotateRight.].
		].
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'EjercicioMarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'EMI 10/24/2020 18:54:49'!
at: aPoint withOrientation: aCardinalCharacter
	^self new initializeAt: aPoint withOrientation: aCardinalCharacter. ! !


!MarsRover class methodsFor: 'error messages' stamp: 'EMI 10/26/2020 08:53:48'!
invalidInstructionErrorMessage
	^'Invalid instruction detected'.! !

!MarsRover class methodsFor: 'error messages' stamp: 'EMI 10/24/2020 18:20:02'!
invalidOrientationErrorMessage
	^'Invalid orientation, should be N, S, W or E'.! !
