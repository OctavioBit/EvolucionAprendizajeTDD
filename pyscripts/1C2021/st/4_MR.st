!classDefinition: #MarsRoverTests category: 'MarsRover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTests methodsFor: 'test position tests' stamp: 'JA 5/16/2021 20:42:35'!
test01IsAtIsTrueWhenTestingForOriginalPositionAndProcessinEmptyPackage

	| aMarsRover |
	aMarsRover:=MarsRover at:0@0 facing: North new.
	
	aMarsRover processPackage: ''.
	
	self assert: (aMarsRover isAt: 0@0 facing: North).! !

!MarsRoverTests methodsFor: 'test position tests' stamp: 'JA 5/16/2021 20:42:01'!
test02IsAtIsFalseWhenTestingForNotOriginalPositionAndProcesingEmptyPackage

	| aMarsRover |
	aMarsRover:=MarsRover at:0@0 facing: North new.
	
	aMarsRover processPackage: ''.
	
	self deny: (aMarsRover isAt: 1@0 facing: North).! !

!MarsRoverTests methodsFor: 'test position tests' stamp: 'JA 5/16/2021 20:44:58'!
test03IsAtIsFalseWhenTestingOriginalPositionButDifferentOrientationProcessingEmptyPackage

	| aMarsRover |
	aMarsRover:=MarsRover at:0@0 facing: South new.
	
	aMarsRover processPackage: ''.
	
	self deny: (aMarsRover isAt: 0@0 facing: North).! !


!MarsRoverTests methodsFor: 'multiple chars tests' stamp: 'JA 5/16/2021 20:24:44'!
test20ProcessFFFacingNorthAddsTwoToY

	| aMarsRover |
	aMarsRover:=MarsRover at:0@0 facing: North new.
	
	aMarsRover processPackage: 'ff'.
	
	self assert: (aMarsRover isAt: 0@2 facing: North).! !

!MarsRoverTests methodsFor: 'multiple chars tests' stamp: 'JA 5/16/2021 20:25:18'!
test21ProcessFBNotChangePosition

	| aMarsRover |
	aMarsRover:=MarsRover at:0@0 facing: North new.
	
	aMarsRover processPackage: 'fb'.
	
	self assert: (aMarsRover isAt: 0@0 facing: North).! !

!MarsRoverTests methodsFor: 'multiple chars tests' stamp: 'JA 5/16/2021 20:27:42'!
test22ProcessRFFacingNorthChangeRotationToEastAndAddsOneToX

	| aMarsRover |
	aMarsRover:=MarsRover at:0@0 facing: North new.
	
	aMarsRover processPackage: 'rf'.
	
	self assert: (aMarsRover isAt: 1@0 facing: East).! !

!MarsRoverTests methodsFor: 'multiple chars tests' stamp: 'JA 5/16/2021 20:32:14'!
test24ProcessPackageCanProcessMultipleChars

	| aMarsRover |
	aMarsRover:=MarsRover at:0@0 facing: North new.
	
	aMarsRover processPackage: 'rflb'.
	
	self assert: (aMarsRover isAt: 1@-1 facing: North).! !

!MarsRoverTests methodsFor: 'multiple chars tests' stamp: 'JA 5/16/2021 20:33:42'!
test25InvalidCharInPackageInterruptProcessing

	| aMarsRover |
	aMarsRover:=MarsRover at:0@0 facing: North new.
	
	aMarsRover processPackage: 'ffxff'.
	
	self assert: (aMarsRover isAt: 0@2 facing: North).! !


!MarsRoverTests methodsFor: 'turn rigth tests' stamp: 'JA 5/16/2021 20:20:23'!
test16ProcessSingleCharRFacingNorthChangeOrientationToEast

	| aMarsRover |
	aMarsRover:=MarsRover at:0@0 facing: North new.
	
	aMarsRover processPackage: 'r'.
	
	self assert: (aMarsRover isAt: 0@0 facing: East).! !

!MarsRoverTests methodsFor: 'turn rigth tests' stamp: 'JA 5/16/2021 20:21:03'!
test17ProcessSingleCharRFacingEastChangeOrientationToSouth

	| aMarsRover |
	aMarsRover:=MarsRover at:0@0 facing: East new.
	
	aMarsRover processPackage: 'r'.
	
	self assert: (aMarsRover isAt: 0@0 facing: South).! !

!MarsRoverTests methodsFor: 'turn rigth tests' stamp: 'JA 5/16/2021 20:22:26'!
test18ProcessSingleCharRFacingSouthChangeOrientationToWest

	| aMarsRover |
	aMarsRover:=MarsRover at:0@0 facing: South new.
	
	aMarsRover processPackage: 'r'.
	
	self assert: (aMarsRover isAt: 0@0 facing: West).! !

!MarsRoverTests methodsFor: 'turn rigth tests' stamp: 'JA 5/16/2021 20:23:24'!
test19ProcessSingleCharRFacingWestChangeOrientationToNorth

	| aMarsRover |
	aMarsRover:=MarsRover at:0@0 facing: West new.
	
	aMarsRover processPackage: 'r'.
	
	self assert: (aMarsRover isAt: 0@0 facing: North).! !


!MarsRoverTests methodsFor: 'turn left tests' stamp: 'JA 5/16/2021 20:16:09'!
test12ProcessSingleCharLFacingNorthChangeOrientationToWest

	| aMarsRover |
	aMarsRover:=MarsRover at:0@0 facing: North new.
	
	aMarsRover processPackage: 'l'.
	
	self assert: (aMarsRover isAt: 0@0 facing: West).! !

!MarsRoverTests methodsFor: 'turn left tests' stamp: 'JA 5/16/2021 20:17:19'!
test13ProcessSingleCharLFacingWestChangeOrientationToSouth

	| aMarsRover |
	aMarsRover:=MarsRover at:0@0 facing: West new.
	
	aMarsRover processPackage: 'l'.
	
	self assert: (aMarsRover isAt: 0@0 facing: South).! !

!MarsRoverTests methodsFor: 'turn left tests' stamp: 'JA 5/16/2021 20:18:25'!
test14ProcessSingleCharLFacingSouthChangeOrientationToEast

	| aMarsRover |
	aMarsRover:=MarsRover at:0@0 facing: South new.
	
	aMarsRover processPackage: 'l'.
	
	self assert: (aMarsRover isAt: 0@0 facing: East).! !

!MarsRoverTests methodsFor: 'turn left tests' stamp: 'JA 5/16/2021 20:19:15'!
test15ProcessSingleCharLFacingEastChangeOrientationToNorth

	| aMarsRover |
	aMarsRover:=MarsRover at:0@0 facing: East new.
	
	aMarsRover processPackage: 'l'.
	
	self assert: (aMarsRover isAt: 0@0 facing: North).! !


!MarsRoverTests methodsFor: 'backward tests' stamp: 'JA 5/16/2021 20:07:31'!
test08ProcessSingleCharBFacingNorthSubstractOneToY

	| aMarsRover |
	aMarsRover:=MarsRover at:0@0 facing: North new.
	
	aMarsRover processPackage: 'b'.
	
	self assert: (aMarsRover isAt: 0@-1 facing: North).! !

!MarsRoverTests methodsFor: 'backward tests' stamp: 'JA 5/16/2021 20:08:33'!
test09ProcessSingleCharBFacingSouthAddsOneToY

	| aMarsRover |
	aMarsRover:=MarsRover at:0@0 facing:  South new.
	
	aMarsRover processPackage: 'b'.
	
	self assert: (aMarsRover isAt: 0@1 facing: South).! !

!MarsRoverTests methodsFor: 'backward tests' stamp: 'JA 5/16/2021 20:09:19'!
test10ProcessSingleCharBFacingEastSubstractOneToX

	| aMarsRover |
	aMarsRover:=MarsRover at:0@0 facing: East new.
	
	aMarsRover processPackage: 'b'.
	
	self assert: (aMarsRover isAt: -1@0 facing: East).! !

!MarsRoverTests methodsFor: 'backward tests' stamp: 'JA 5/16/2021 20:11:00'!
test11ProcessSingleCharBFacingWestAddsOneToX

	| aMarsRover |
	aMarsRover:=MarsRover at:0@0 facing: West new.
	
	aMarsRover processPackage: 'b'.
	
	self assert: (aMarsRover isAt: 1@0 facing: West).! !


!MarsRoverTests methodsFor: 'forward tests' stamp: 'JA 5/16/2021 20:01:46'!
test04ProcessSingleCharFFacingNorthAddsOneToY

	| aMarsRover |
	aMarsRover:=MarsRover at:0@0 facing: North new.
	
	aMarsRover processPackage: 'f'.
	
	self assert: (aMarsRover isAt: 0@1 facing: North).! !

!MarsRoverTests methodsFor: 'forward tests' stamp: 'JA 5/16/2021 20:03:45'!
test05ProcessSingleCharFFacingSouthSubstractOneToY

	| aMarsRover |
	aMarsRover:=MarsRover at:1@1 facing: South new.
	
	aMarsRover processPackage: 'f'.
	
	self assert: (aMarsRover isAt: 1@0 facing: South).! !

!MarsRoverTests methodsFor: 'forward tests' stamp: 'JA 5/16/2021 20:04:43'!
test06ProcessSingleCharFFacingEastAddsOneToX

	| aMarsRover |
	aMarsRover:=MarsRover at:1@1 facing: East new.
	
	aMarsRover processPackage: 'f'.
	
	self assert: (aMarsRover isAt: 2@1 facing: East).! !

!MarsRoverTests methodsFor: 'forward tests' stamp: 'JA 5/16/2021 20:06:26'!
test07ProcessSingleCharFFacingWestSubstractOneToX

	| aMarsRover |
	aMarsRover:=MarsRover at:1@1 facing: West new.
	
	aMarsRover processPackage: 'f'.
	
	self assert: (aMarsRover isAt: 0@1 facing: West).! !


!classDefinition: #CardinalPoint category: 'MarsRover'!
Object subclass: #CardinalPoint
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalPoint methodsFor: 'move offset' stamp: 'JA 5/15/2021 15:56:40'!
backwardOffset
	self subclassResponsibility ! !

!CardinalPoint methodsFor: 'move offset' stamp: 'JA 5/15/2021 15:53:16'!
forwardOffset
	self subclassResponsibility ! !


!CardinalPoint methodsFor: 'rotation' stamp: 'JA 5/15/2021 15:52:58'!
turnLeft
	self subclassResponsibility ! !

!CardinalPoint methodsFor: 'rotation' stamp: 'JA 5/15/2021 15:53:05'!
turnRight
	self subclassResponsibility ! !


!classDefinition: #East category: 'MarsRover'!
CardinalPoint subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'rotation' stamp: 'JA 5/15/2021 15:57:30'!
turnLeft
	^ North new! !

!East methodsFor: 'rotation' stamp: 'JA 5/15/2021 15:57:50'!
turnRight
	^ South new! !


!East methodsFor: 'move offset' stamp: 'JA 5/15/2021 16:05:06'!
backwardOffset
	^ (-1@0)! !

!East methodsFor: 'move offset' stamp: 'JA 5/15/2021 15:58:29'!
forwardOffset
	^ (1@0)! !


!classDefinition: #North category: 'MarsRover'!
CardinalPoint subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'rotation' stamp: 'JA 5/15/2021 16:06:08'!
turnLeft
	^ West new! !

!North methodsFor: 'rotation' stamp: 'JA 5/15/2021 16:06:40'!
turnRight
	^ East new! !


!North methodsFor: 'move offset' stamp: 'JA 5/15/2021 16:07:38'!
backwardOffset
	^(0@-1)! !

!North methodsFor: 'move offset' stamp: 'JA 5/15/2021 16:07:26'!
forwardOffset
	^(0@1)! !


!classDefinition: #South category: 'MarsRover'!
CardinalPoint subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'rotation' stamp: 'JA 5/15/2021 16:09:16'!
turnLeft
	^ East new! !

!South methodsFor: 'rotation' stamp: 'JA 5/15/2021 16:09:07'!
turnRight
	^ West new! !


!South methodsFor: 'move offset' stamp: 'JA 5/15/2021 16:10:09'!
backwardOffset
	^ (0@1)! !

!South methodsFor: 'move offset' stamp: 'JA 5/15/2021 16:10:01'!
forwardOffset
	^ (0@-1)! !


!classDefinition: #West category: 'MarsRover'!
CardinalPoint subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'move offset' stamp: 'JA 5/15/2021 16:13:27'!
backwardOffset
	^(1@0)! !

!West methodsFor: 'move offset' stamp: 'JA 5/15/2021 16:13:46'!
forwardOffset
	^(-1@0)! !


!West methodsFor: 'rotation' stamp: 'JA 5/15/2021 16:11:04'!
turnLeft
	^ South new! !

!West methodsFor: 'rotation' stamp: 'JA 5/15/2021 16:12:03'!
turnRight
	^ North new! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'point cardinalPoint'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'JA 5/13/2021 22:04:27'!
initializeAt: aPoint facing: aCardinalPoint 
	point := aPoint.
	cardinalPoint := aCardinalPoint.! !


!MarsRover methodsFor: 'accessing' stamp: 'JA 5/15/2021 17:14:33'!
isAt: aPoint facing: aCardinalPointType 
	^ aPoint = point and: (cardinalPoint isKindOf: aCardinalPointType )! !


!MarsRover methodsFor: 'private' stamp: 'JA 5/15/2021 16:55:45'!
changeOrientationUsing: anOrientationCommand

	anOrientationCommand = $l ifTrue:[cardinalPoint := cardinalPoint turnLeft].
	anOrientationCommand = $r ifTrue:[cardinalPoint := cardinalPoint turnRight].! !

!MarsRover methodsFor: 'private' stamp: 'JA 5/15/2021 17:00:48'!
changePositionUsing: aPotentialMoveCommand
	
	point := point + (self offsetFromMoveCommand: aPotentialMoveCommand).! !

!MarsRover methodsFor: 'private' stamp: 'JA 5/15/2021 16:55:17'!
offsetFromMoveCommand: aMoveCommand

	aMoveCommand = $f ifTrue: [^ cardinalPoint forwardOffset ].
	aMoveCommand = $b ifTrue: [^ cardinalPoint backwardOffset ].
	^ 0@0! !


!MarsRover methodsFor: 'evaluating' stamp: 'JA 5/15/2021 17:15:18'!
processPackage: aPackage
	aPackage do: [ :command| 
		#($f $b $l $r) detect: [:aPotentialCommand| aPotentialCommand = command.] ifNone: [^ self ].
		self changeOrientationUsing: command .
		self changePositionUsing: command.
	]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'JA 5/13/2021 22:03:47'!
at: aPoint facing: aCardinalPoint 
	^self new initializeAt: aPoint facing: aCardinalPoint ! !
