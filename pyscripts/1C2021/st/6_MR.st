!classDefinition: #MarsRoverTests category: 'Mars-Rover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRoverTests methodsFor: 'tests' stamp: 'BW 5/16/2021 21:34:29'!
test01EmptyPackageShouldntChangePositionNorOrientation 
	
	self assertMarsRoverFacing: self faceNorth afterPackage: '' moved: 0@0 andFaces: [:aMarsRover | aMarsRover facesNorth].! !

!MarsRoverTests methodsFor: 'tests' stamp: 'BW 5/16/2021 21:34:23'!
test02SingleForwardPackageShouldTakeStepForward 
	
	self assertMarsRoverFacing: self faceNorth afterPackage: 'f' moved: 0@1 andFaces: [:aMarsRover | aMarsRover facesNorth].! !

!MarsRoverTests methodsFor: 'tests' stamp: 'BW 5/16/2021 21:34:17'!
test03SingleBackwardsPackageShouldTakeStepBackwards
	
	self assertMarsRoverFacing: self faceNorth afterPackage: 'b' moved: 0@-1 andFaces: [:aMarsRover | aMarsRover facesNorth].! !

!MarsRoverTests methodsFor: 'tests' stamp: 'BW 5/16/2021 21:34:11'!
test04SingleLeftPackageShouldRotateCounterClockwise

	self assertMarsRoverFacing: self faceNorth afterPackage: 'l' moved: 0@0 andFaces: [:aMarsRover | aMarsRover facesWest].! !

!MarsRoverTests methodsFor: 'tests' stamp: 'BW 5/16/2021 21:34:03'!
test05SingleRightPackageShouldRotateClockwise

	self assertMarsRoverFacing: self faceNorth afterPackage: 'r' moved: 0@0 andFaces: [:aMarsRover | aMarsRover facesEast].! !

!MarsRoverTests methodsFor: 'tests' stamp: 'BW 5/16/2021 21:33:57'!
test06MultipleSameTypeOperationsShouldRepeatOperation
	
	self assertMarsRoverFacing: self faceNorth afterPackage: 'fff' moved: 0@3 andFaces: [:aMarsRover | aMarsRover facesNorth].! !

!MarsRoverTests methodsFor: 'tests' stamp: 'BW 5/16/2021 21:33:42'!
test07MultipleDifferentTipeOperationsShouldExecuteInOrder
	
	self assertMarsRoverFacing: self faceNorth afterPackage: 'lb' moved: 1@0 andFaces: [:aMarsRover | aMarsRover facesWest].! !

!MarsRoverTests methodsFor: 'tests' stamp: 'BW 5/16/2021 21:33:35'!
test08MarsRoverShouldIgnoreInstruccionsFollowingAnInvalidOne

	self assertMarsRoverFacing: self faceNorth afterPackage: 'lbylffff' moved: 1@0 andFaces: [:aMarsRover | aMarsRover facesWest].! !


!MarsRoverTests methodsFor: 'orientation creation' stamp: 'BW 5/15/2021 11:22:08'!
faceEast
	^FacingEast new.! !

!MarsRoverTests methodsFor: 'orientation creation' stamp: 'BW 5/15/2021 11:22:17'!
faceNorth
	^FacingNorth new.! !

!MarsRoverTests methodsFor: 'orientation creation' stamp: 'BW 5/15/2021 11:22:27'!
faceSouth
	^FacingSouth new.! !

!MarsRoverTests methodsFor: 'orientation creation' stamp: 'BW 5/15/2021 11:22:37'!
faceWest
	^FacingWest new.! !


!MarsRoverTests methodsFor: 'asserts' stamp: 'BW 5/16/2021 21:38:41'!
assertMarsRoverFacing: anOrientation afterPackage: aPackage moved: aDisplacement andFaces: anOrientationBlock

	|aMarsRover initialPosition|
	
	initialPosition := 0@0.
	
	aMarsRover := MarsRover position: initialPosition orientation: anOrientation. 
	
	aMarsRover processPackage: aPackage.
	
	self assert: initialPosition + aDisplacement equals: aMarsRover position.
	self assert: (anOrientationBlock value: aMarsRover)! !


!classDefinition: #MarsRover category: 'Mars-Rover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position orientation point symbol'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRover methodsFor: 'initialization' stamp: 'BW 5/13/2021 21:36:27'!
initializePosition: aPoint orientation: anOrientation
	position := aPoint.
	orientation := anOrientation.! !


!MarsRover methodsFor: 'packageProcessing' stamp: 'BW 5/16/2021 21:46:30'!
processInstruction: anInstruction
	
	anInstruction = $f ifTrue:[^orientation goForward: self].
	anInstruction = $l  ifTrue: [^orientation rotateLeft: self].	
	anInstruction = $r ifTrue: [^orientation rotateRight: self].
	anInstruction = $b ifTrue: [^orientation goBackwards: self].
	
	self error: self class unknownInstructionErrorMessage.
	
! !

!MarsRover methodsFor: 'packageProcessing' stamp: 'BW 5/16/2021 21:39:01'!
processPackage: aPackage
	
	
	
	[aPackage do: [:anInstruction | self processInstruction: anInstruction]] on: Error do: [:errorMessage | ^errorMessage].
	
	! !


!MarsRover methodsFor: 'testing' stamp: 'BW 5/15/2021 11:42:46'!
facesEast
	^orientation isEast! !

!MarsRover methodsFor: 'testing' stamp: 'BW 5/15/2021 11:42:40'!
facesNorth
	^orientation isNorth! !

!MarsRover methodsFor: 'testing' stamp: 'BW 5/15/2021 11:42:33'!
facesSouth
	^orientation isSouth! !

!MarsRover methodsFor: 'testing' stamp: 'BW 5/15/2021 11:42:54'!
facesWest
	^orientation isWest! !

!MarsRover methodsFor: 'testing' stamp: 'BW 5/13/2021 21:37:54'!
orientation
	
	^orientation! !

!MarsRover methodsFor: 'testing' stamp: 'BW 5/13/2021 21:37:15'!
position
	
	^position! !


!MarsRover methodsFor: 'rotating operations' stamp: 'BW 5/15/2021 11:37:22'!
face: anOrientation
	orientation := anOrientation! !


!MarsRover methodsFor: 'displacement operations' stamp: 'BW 5/15/2021 11:33:26'!
takeStep: aStep

	position := position + aStep.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Mars-Rover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'BW 5/13/2021 21:34:50'!
position: aPoint orientation: aSymbol 
	^self new initializePosition: aPoint orientation: aSymbol ! !


!MarsRover class methodsFor: 'error' stamp: 'BW 5/16/2021 20:41:14'!
unknownInstructionErrorMessage
	^ 'Invalid Instruction Encountered. Stoping execution.'! !


!classDefinition: #MarsRoverOrientationState category: 'Mars-Rover'!
Object subclass: #MarsRoverOrientationState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!MarsRoverOrientationState methodsFor: 'testing' stamp: 'BW 5/15/2021 11:40:38'!
isEast
	^false.! !

!MarsRoverOrientationState methodsFor: 'testing' stamp: 'BW 5/15/2021 11:40:51'!
isNorth
	^false.! !

!MarsRoverOrientationState methodsFor: 'testing' stamp: 'BW 5/15/2021 11:40:55'!
isSouth
	^false.! !

!MarsRoverOrientationState methodsFor: 'testing' stamp: 'BW 5/15/2021 11:40:59'!
isWest
	^false.! !


!MarsRoverOrientationState methodsFor: 'rotating operations' stamp: 'BW 5/15/2021 11:34:26'!
rotateLeft: aMarsRover
	
	self subclassResponsibility .! !

!MarsRoverOrientationState methodsFor: 'rotating operations' stamp: 'BW 5/15/2021 13:22:59'!
rotateRight: aMarsRover
	self subclassResponsibility ! !


!MarsRoverOrientationState methodsFor: 'displacement operations' stamp: 'BW 5/15/2021 11:28:59'!
goBackwards: aMarsRover

	self subclassResponsibility.
	
	
	! !

!MarsRoverOrientationState methodsFor: 'displacement operations' stamp: 'BW 5/15/2021 11:20:45'!
goForward: aMarsRover
	self subclassResponsibility.! !


!classDefinition: #FacingEast category: 'Mars-Rover'!
MarsRoverOrientationState subclass: #FacingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!FacingEast methodsFor: 'testing' stamp: 'BW 5/15/2021 11:41:22'!
isEast
	^true! !


!FacingEast methodsFor: 'rotating operations' stamp: 'BW 5/15/2021 11:36:48'!
rotateLeft: aMarsRover

	aMarsRover face: FacingNorth new. ! !

!FacingEast methodsFor: 'rotating operations' stamp: 'BW 5/15/2021 13:24:37'!
rotateRight: aMarsRover
	
	aMarsRover face: FacingSouth new.! !


!FacingEast methodsFor: 'displacement operations' stamp: 'BW 5/15/2021 11:29:55'!
goBackwards: aMarsRover
	
	aMarsRover takeStep: -1@0.
	
	! !

!FacingEast methodsFor: 'displacement operations' stamp: 'BW 5/15/2021 11:20:56'!
goForward: aMarsRover
	aMarsRover takeStep: 1@0
	! !


!classDefinition: #FacingNorth category: 'Mars-Rover'!
MarsRoverOrientationState subclass: #FacingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!FacingNorth methodsFor: 'testing' stamp: 'BW 5/15/2021 11:41:31'!
isNorth
	^true! !


!FacingNorth methodsFor: 'displacement operations' stamp: 'BW 5/15/2021 11:31:24'!
goBackwards: aMarsRover
	
	aMarsRover takeStep: 0@-1.! !

!FacingNorth methodsFor: 'displacement operations' stamp: 'BW 5/15/2021 11:21:07'!
goForward: aMarsRover
	aMarsRover takeStep: 0@1.! !


!FacingNorth methodsFor: 'rotating operations' stamp: 'BW 5/15/2021 11:37:45'!
rotateLeft: aMarsRover

	aMarsRover face: FacingWest new. ! !

!FacingNorth methodsFor: 'rotating operations' stamp: 'BW 5/15/2021 13:24:59'!
rotateRight: aMarsRover
	
	aMarsRover face: FacingEast new.! !


!classDefinition: #FacingSouth category: 'Mars-Rover'!
MarsRoverOrientationState subclass: #FacingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!FacingSouth methodsFor: 'testing' stamp: 'BW 5/15/2021 11:41:41'!
isSouth
	^true! !


!FacingSouth methodsFor: 'rotating operations' stamp: 'BW 5/15/2021 11:37:57'!
rotateLeft: aMarsRover

	aMarsRover face: FacingEast new. ! !

!FacingSouth methodsFor: 'rotating operations' stamp: 'BW 5/15/2021 13:25:13'!
rotateRight: aMarsRover
	
	aMarsRover face: FacingWest new.! !


!FacingSouth methodsFor: 'displacement operations' stamp: 'BW 5/15/2021 11:31:35'!
goBackwards: aMarsRover
	
	aMarsRover takeStep: 0@1.! !

!FacingSouth methodsFor: 'displacement operations' stamp: 'BW 5/15/2021 11:21:13'!
goForward: aMarsRover
	aMarsRover takeStep: 0@-1
! !


!classDefinition: #FacingWest category: 'Mars-Rover'!
MarsRoverOrientationState subclass: #FacingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover'!

!FacingWest methodsFor: 'displacement operations' stamp: 'BW 5/15/2021 11:31:51'!
goBackwards: aMarsRover
	
	aMarsRover takeStep: 1@0.! !

!FacingWest methodsFor: 'displacement operations' stamp: 'BW 5/15/2021 13:51:38'!
goForward: aMarsRover
	aMarsRover takeStep: -1@0! !


!FacingWest methodsFor: 'rotating operations' stamp: 'BW 5/15/2021 11:38:13'!
rotateLeft: aMarsRover

	aMarsRover face: FacingSouth new. ! !

!FacingWest methodsFor: 'rotating operations' stamp: 'BW 5/15/2021 13:25:22'!
rotateRight: aMarsRover
	
	aMarsRover face: FacingNorth new.! !


!FacingWest methodsFor: 'testing' stamp: 'BW 5/15/2021 11:41:51'!
isWest
	^true.! !
