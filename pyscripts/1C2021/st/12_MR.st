!classDefinition: #MarsRoverTests category: 'MarsRoverExercise'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverExercise'!

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDC 5/17/2021 12:21:48'!
test01MarsRoverInitializesWithStartingPosition

	self assert: 200@100 equals: (MarsRover initializeWithNorthDirection) getCurrentPosition.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDC 5/17/2021 12:21:43'!
test02MarsRoverInitializesWithNorthDirection

	self assert: North equals: ((MarsRover initializeWithNorthDirection) getCurrentDirection) class.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDC 5/17/2021 12:21:37'!
test03MarsRoverInitializesWithSouthDirection

	self assert: South equals: ((MarsRover initializeWithSouthDirection) getCurrentDirection) class.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDC 5/17/2021 12:22:04'!
test04MarsRoverInitializesWithEastDirection

	self assert: East equals: ((MarsRover initializeWithEastDirection) getCurrentDirection) class.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDC 5/17/2021 12:22:12'!
test05MarsRoverInitializesWithWestDirection

	self assert: West equals: ((MarsRover initializeWithWestDirection) getCurrentDirection) class.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDC 5/17/2021 12:23:11'!
test06MarsRoverExecutesForwardCommandSuccessfully

	| marsRover |
	marsRover := (MarsRover initializeWithNorthDirection).
	marsRover receiveCommand: 'f'.
	self assert: 200@101 equals:  marsRover getCurrentPosition.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDC 5/17/2021 12:23:21'!
test07MarsRoverExecutesBackCommandSuccessfully

	| marsRover |
	marsRover := (MarsRover initializeWithNorthDirection).
	marsRover receiveCommand: 'b'.
	self assert: 200@99 equals:  marsRover getCurrentPosition.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDC 5/17/2021 12:23:52'!
test08MarsRoverExecutesturnLeftFromNorthCommandSuccessfully

	| marsRover |
	marsRover := (MarsRover initializeWithNorthDirection).
	marsRover receiveCommand: 'l'.
	self assert: West equals:  (marsRover getCurrentDirection) class.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDC 5/17/2021 12:23:59'!
test09MarsRoverExecutesTurnLeftFromWestCommandSuccessfully

	| marsRover |
	marsRover := (MarsRover initializeWithWestDirection).
	marsRover receiveCommand: 'l'.
	self assert: South equals:  (marsRover getCurrentDirection) class.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDC 5/17/2021 12:24:15'!
test10MarsRoverExecutesTurnLeftFromSouthCommandSuccessfully

	| marsRover |
	marsRover := (MarsRover initializeWithSouthDirection).
	marsRover receiveCommand: 'l'.
	self assert: East equals:  (marsRover getCurrentDirection) class.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDC 5/17/2021 12:24:22'!
test11MarsRoverExecutesTurnLeftFromEastCommandSuccessfully

	| marsRover |
	marsRover := (MarsRover initializeWithEastDirection).
	marsRover receiveCommand: 'l'.
	self assert: North equals:  (marsRover getCurrentDirection) class.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDC 5/17/2021 12:24:38'!
test12MarsRoverExecutesTurnRightFromNorthCommandSuccessfully

	| marsRover |
	marsRover := (MarsRover initializeWithNorthDirection).
	marsRover receiveCommand: 'r'.
	self assert: East equals:  (marsRover getCurrentDirection) class.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDC 5/17/2021 12:24:44'!
test13MarsRoverExecutesTurnRightFromWestCommandSuccessfully

	| marsRover |
	marsRover := (MarsRover initializeWithWestDirection).
	marsRover receiveCommand: 'r'.
	self assert: North equals: ( marsRover getCurrentDirection) class.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDC 5/17/2021 12:24:52'!
test14MarsRoverExecutesTurnRightFromSouthCommandSuccessfully

	| marsRover |
	marsRover := (MarsRover initializeWithSouthDirection).
	marsRover receiveCommand: 'r'.
	self assert: West equals:  (marsRover getCurrentDirection) class.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDC 5/17/2021 12:25:10'!
test15MarsRoverExecutesTurnRightFromEastCommandSuccessfully

	| marsRover |
	marsRover := (MarsRover initializeWithEastDirection).
	marsRover receiveCommand: 'r'.
	self assert: South equals: ( marsRover getCurrentDirection) class.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDC 5/17/2021 12:26:30'!
test16MarsRoverEndsUpFacingSouthAfterTurningTwoTimesRightFromNorth

	| marsRover |
	marsRover := (MarsRover initializeWithNorthDirection).
	marsRover receiveCommand: 'rr'.
	self assert: South equals:  (marsRover getCurrentDirection) class.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDC 5/17/2021 12:26:42'!
test17MarsRoverEndsUpFacingSouthAfterTurningTwoTimesLeftFromNorth
	"I didn't expect it to pass"
	| marsRover |
	marsRover := (MarsRover initializeWithNorthDirection).
	marsRover receiveCommand: 'll'.
	self assert: South equals:  (marsRover getCurrentDirection) class.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDC 5/17/2021 12:32:39'!
test18MarsRoverMovesOnXandYAxesWhenChangingDirectionsAndMovingForward
	| marsRover |
	marsRover := (MarsRover initializeWithNorthDirection).
	marsRover receiveCommand: 'ffflfffr'. "197@103" "North"
	self assert: North equals:  (marsRover getCurrentDirection) class.
	self assert: 197@103 equals:  marsRover getCurrentPosition.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDC 5/17/2021 12:33:24'!
test19MarsRoverMovesDownOnYAxisWhenTurningLeftTwoTimesAndMovingForward
	| marsRover |
	marsRover := (MarsRover initializeWithNorthDirection).
	marsRover receiveCommand: 'llf'. 
	self assert: South equals:  (marsRover getCurrentDirection) class.
	self assert: 200@99 equals:  marsRover getCurrentPosition.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDC 5/17/2021 12:33:52'!
test20MarsRoverMovesDownOnYAxisWhenTurningRightTwoTimesAndMovingForward
	| marsRover |
	marsRover := (MarsRover initializeWithNorthDirection).
	marsRover receiveCommand: 'rrf'. 
	self assert: South equals:  (marsRover getCurrentDirection) class.
	self assert: 200@99 equals:  marsRover getCurrentPosition.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDC 5/17/2021 12:35:02'!
test21MarsRoverMovesRightOnXAxisWhenFacingWestAndMovingBackwards
	| marsRover |
	marsRover := (MarsRover initializeWithNorthDirection).
	marsRover receiveCommand: 'lb'. 
	self assert: West equals:  (marsRover getCurrentDirection) class.
	self assert: 201@100 equals:  marsRover getCurrentPosition.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDC 5/17/2021 12:34:50'!
test22MarsRoverMovesLeftOnXAxisWhenFacingEastAndMovingBackwards
	| marsRover |
	marsRover := (MarsRover initializeWithNorthDirection).
	marsRover receiveCommand: 'rb'. 
	self assert: East equals:  (marsRover getCurrentDirection) class.
	self assert: 199@100 equals:  marsRover getCurrentPosition.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'JDC 5/17/2021 12:35:52'!
test23MarsRoverSignalsErrorWhenReceivingIllegalCommandAndStopsExecutingCommands
	"mars rover receives illegal command and stops processing"
	| marsRover |
	marsRover := (MarsRover initializeWithNorthDirection).
	
	self
		should: [marsRover receiveCommand: 'ffrxbl'] "should not do: 200@101" "should do: 200@102"
		raise: Error
		withMessageText: MarsRover invalidCommandErrorDescription.
	self assert: East equals:  (marsRover getCurrentDirection) class.
	self assert: 200@102 equals: marsRover getCurrentPosition! !


!classDefinition: #MarsRover category: 'MarsRoverExercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'currentPosition currentDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverExercise'!

!MarsRover methodsFor: 'accessers' stamp: 'JDC 5/17/2021 00:06:13'!
getCurrentDirection

	^currentDirection.! !

!MarsRover methodsFor: 'accessers' stamp: 'JDC 5/17/2021 00:06:00'!
getCurrentPosition

	^currentPosition.! !


!MarsRover methodsFor: 'commands-turning-private' stamp: 'JDC 5/17/2021 11:53:13'!
turnLeftEastDirection

	currentDirection := (North initializeWith: self).! !

!MarsRover methodsFor: 'commands-turning-private' stamp: 'JDC 5/17/2021 11:53:19'!
turnLeftNorthDirection

	currentDirection := (West initializeWith: self).! !

!MarsRover methodsFor: 'commands-turning-private' stamp: 'JDC 5/17/2021 11:53:22'!
turnLeftSouthDirection

	currentDirection := (East initializeWith: self).! !

!MarsRover methodsFor: 'commands-turning-private' stamp: 'JDC 5/17/2021 11:53:25'!
turnLeftWestDirection

	currentDirection := (South initializeWith: self).! !

!MarsRover methodsFor: 'commands-turning-private' stamp: 'JDC 5/17/2021 11:53:29'!
turnRightEastDirection

	currentDirection := (South initializeWith: self).! !

!MarsRover methodsFor: 'commands-turning-private' stamp: 'JDC 5/17/2021 11:53:31'!
turnRightNorthDirection

	currentDirection := (East initializeWith: self).! !

!MarsRover methodsFor: 'commands-turning-private' stamp: 'JDC 5/17/2021 11:53:35'!
turnRightSouthDirection

	currentDirection := (West initializeWith: self).! !

!MarsRover methodsFor: 'commands-turning-private' stamp: 'JDC 5/17/2021 11:53:37'!
turnRightWestDirection

	currentDirection := (North initializeWith: self).! !


!MarsRover methodsFor: 'commands-movement-private' stamp: 'JDC 5/17/2021 11:04:41'!
moveBackEastDirection

	currentPosition := currentPosition -  (1@0).! !

!MarsRover methodsFor: 'commands-movement-private' stamp: 'JDC 5/17/2021 11:05:48'!
moveBackNorthDirection

	currentPosition := currentPosition - (0@1).! !

!MarsRover methodsFor: 'commands-movement-private' stamp: 'JDC 5/17/2021 11:06:55'!
moveBackSouthDirection

	currentPosition := currentPosition + (0@1).! !

!MarsRover methodsFor: 'commands-movement-private' stamp: 'JDC 5/17/2021 11:08:21'!
moveBackWestDirection

	currentPosition := currentPosition + (1@0).! !

!MarsRover methodsFor: 'commands-movement-private' stamp: 'JDC 5/17/2021 11:04:35'!
moveForwardEastDirection

	currentPosition := currentPosition +  (1@0).! !

!MarsRover methodsFor: 'commands-movement-private' stamp: 'JDC 5/17/2021 11:05:57'!
moveForwardNorthDirection

	currentPosition := currentPosition + (0@1).! !

!MarsRover methodsFor: 'commands-movement-private' stamp: 'JDC 5/17/2021 11:06:48'!
moveForwardSouthDirection

	currentPosition := currentPosition - (0@1).! !

!MarsRover methodsFor: 'commands-movement-private' stamp: 'JDC 5/17/2021 11:08:30'!
moveForwardWestDirection

	currentPosition := currentPosition - (1@0).! !


!MarsRover methodsFor: 'error signal' stamp: 'JDC 5/17/2021 12:12:32'!
signalInvalidCommandError

	^self error: self class invalidCommandErrorDescription.! !


!MarsRover methodsFor: 'asserting' stamp: 'JDC 5/17/2021 12:11:04'!
assertCommandIsValid: aCommand

	| validCommands |
	validCommands := OrderedCollection with: $f with: $b with: $l with: $r.
	validCommands detect: [:aValidCommand | (aValidCommand = aCommand) ] ifNone: [self signalInvalidCommandError]! !


!MarsRover methodsFor: 'commands' stamp: 'JDC 5/17/2021 12:04:33'!
receiveCommand: aCommandString

	aCommandString do: [:aCommandChar | self assertCommandIsValid: aCommandChar.
		currentDirection perform: (aCommandChar asSymbol)
		]! !


!MarsRover methodsFor: 'initialization' stamp: 'JDC 5/17/2021 11:32:40'!
initializeWithPoint: aPoint andDirection: aDirection.

	currentPosition := aPoint.
	currentDirection := aDirection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRoverExercise'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'initialization' stamp: 'JDC 5/17/2021 11:23:53'!
initializeWithEastDirection
	
	| marsRover |
	marsRover := MarsRover new.
	marsRover initializeWithPoint: 200@100 andDirection: (East initializeWith: marsRover).
	^marsRover.! !

!MarsRover class methodsFor: 'initialization' stamp: 'JDC 5/17/2021 11:24:42'!
initializeWithNorthDirection
	
	| marsRover |
	marsRover := MarsRover new.
	marsRover initializeWithPoint: 200@100 andDirection: (North initializeWith: marsRover).
	^marsRover.! !

!MarsRover class methodsFor: 'initialization' stamp: 'JDC 5/17/2021 11:26:17'!
initializeWithSouthDirection
	
	| marsRover |
	marsRover := MarsRover new.
	marsRover initializeWithPoint: 200@100 andDirection: (South initializeWith: marsRover).
	^marsRover.! !

!MarsRover class methodsFor: 'initialization' stamp: 'JDC 5/17/2021 11:26:36'!
initializeWithWestDirection
	
	| marsRover |
	marsRover := MarsRover new.
	marsRover initializeWithPoint: 200@100 andDirection: (West initializeWith: marsRover).
	^marsRover.! !


!MarsRover class methodsFor: 'error' stamp: 'JDC 5/17/2021 12:14:38'!
invalidCommandErrorDescription

	^'Tried to execute an invalid command'! !


!classDefinition: #MarsRoverDirection category: 'MarsRoverExercise'!
Object subclass: #MarsRoverDirection
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverExercise'!

!MarsRoverDirection methodsFor: 'initialization' stamp: 'JDC 5/17/2021 11:27:05'!
initializeWith: aMarsRover

	marsRover := aMarsRover.
	^self.! !


!MarsRoverDirection methodsFor: 'marsRover-commands' stamp: 'JDC 5/17/2021 12:01:03'!
b

	self subclassResponsibility.! !

!MarsRoverDirection methodsFor: 'marsRover-commands' stamp: 'JDC 5/17/2021 12:02:02'!
f

	self subclassResponsibility.! !

!MarsRoverDirection methodsFor: 'marsRover-commands' stamp: 'JDC 5/17/2021 12:02:24'!
l

	self subclassResponsibility.! !

!MarsRoverDirection methodsFor: 'marsRover-commands' stamp: 'JDC 5/17/2021 12:02:39'!
r

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverDirection class' category: 'MarsRoverExercise'!
MarsRoverDirection class
	instanceVariableNames: 'marsRover'!

!MarsRoverDirection class methodsFor: 'initialization' stamp: 'JDC 5/17/2021 11:38:19'!
initializeWith: aMarsRover

	self subclassResponsibility.! !


!classDefinition: #East category: 'MarsRoverExercise'!
MarsRoverDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverExercise'!

!East methodsFor: 'marsRover-commands' stamp: 'JDC 5/17/2021 12:01:03'!
b

	marsRover moveBackEastDirection.! !

!East methodsFor: 'marsRover-commands' stamp: 'JDC 5/17/2021 12:02:02'!
f

	marsRover moveForwardEastDirection.! !

!East methodsFor: 'marsRover-commands' stamp: 'JDC 5/17/2021 12:02:24'!
l

	marsRover turnLeftEastDirection.! !

!East methodsFor: 'marsRover-commands' stamp: 'JDC 5/17/2021 12:02:39'!
r

	marsRover turnRightEastDirection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'East class' category: 'MarsRoverExercise'!
East class
	instanceVariableNames: ''!

!East class methodsFor: 'initialization' stamp: 'JDC 5/17/2021 11:39:19'!
initializeWith: aMarsRover

	^(East new) initializeWith: aMarsRover.! !


!classDefinition: #North category: 'MarsRoverExercise'!
MarsRoverDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverExercise'!

!North methodsFor: 'marsRover-commands' stamp: 'JDC 5/17/2021 12:01:03'!
b

	marsRover moveBackNorthDirection.! !

!North methodsFor: 'marsRover-commands' stamp: 'JDC 5/17/2021 12:02:02'!
f
	
	marsRover moveForwardNorthDirection.! !

!North methodsFor: 'marsRover-commands' stamp: 'JDC 5/17/2021 12:02:24'!
l

	marsRover turnLeftNorthDirection.! !

!North methodsFor: 'marsRover-commands' stamp: 'JDC 5/17/2021 12:02:39'!
r

	marsRover turnRightNorthDirection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'North class' category: 'MarsRoverExercise'!
North class
	instanceVariableNames: ''!

!North class methodsFor: 'initialization' stamp: 'JDC 5/17/2021 11:39:26'!
initializeWith: aMarsRover

	^(North new) initializeWith: aMarsRover.! !


!classDefinition: #South category: 'MarsRoverExercise'!
MarsRoverDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverExercise'!

!South methodsFor: 'marsRover-commands' stamp: 'JDC 5/17/2021 12:01:03'!
b

	marsRover moveBackSouthDirection! !

!South methodsFor: 'marsRover-commands' stamp: 'JDC 5/17/2021 12:02:02'!
f

	marsRover moveForwardSouthDirection.! !

!South methodsFor: 'marsRover-commands' stamp: 'JDC 5/17/2021 12:02:24'!
l

	marsRover turnLeftSouthDirection.! !

!South methodsFor: 'marsRover-commands' stamp: 'JDC 5/17/2021 12:02:39'!
r

	marsRover turnRightSouthDirection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'South class' category: 'MarsRoverExercise'!
South class
	instanceVariableNames: ''!

!South class methodsFor: 'initialization' stamp: 'JDC 5/17/2021 11:39:31'!
initializeWith: aMarsRover

	^(South new) initializeWith: aMarsRover.! !


!classDefinition: #West category: 'MarsRoverExercise'!
MarsRoverDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverExercise'!

!West methodsFor: 'marsRover-Commands' stamp: 'JDC 5/17/2021 12:01:03'!
b

	marsRover moveBackWestDirection.! !

!West methodsFor: 'marsRover-Commands' stamp: 'JDC 5/17/2021 12:02:02'!
f

	marsRover moveForwardWestDirection.! !

!West methodsFor: 'marsRover-Commands' stamp: 'JDC 5/17/2021 12:02:24'!
l

	marsRover turnLeftWestDirection.! !

!West methodsFor: 'marsRover-Commands' stamp: 'JDC 5/17/2021 12:02:39'!
r

	marsRover turnRightWestDirection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'West class' category: 'MarsRoverExercise'!
West class
	instanceVariableNames: ''!

!West class methodsFor: 'initialization' stamp: 'JDC 5/17/2021 11:39:35'!
initializeWith: aMarsRover

	^(West new) initializeWith: aMarsRover.! !
