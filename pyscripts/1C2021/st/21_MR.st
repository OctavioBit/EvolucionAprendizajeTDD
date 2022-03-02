!classDefinition: #MarsRoverTests category: 'MarsRover-Exercise'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: 'north south east west'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverTests methodsFor: 'testing' stamp: 'ENC 5/15/2021 23:55:56'!
setUp

	north := CardinalMarsRoverNorth new.
	south := CardinalMarsRoverSouth new.
	east := CardinalMarsRoverEast new.
	west := CardinalMarsRoverWest new.	! !

!MarsRoverTests methodsFor: 'testing' stamp: 'MS 5/17/2021 14:39:59'!
test01emptyCommandDoesNothing

	| marsRover |
	
	marsRover := MarsRover position: 0@0 cardinal: north.
	marsRover receiveCommands: ''.
	
	self assert: 0@0 equals: marsRover position.
	self assert: marsRover cardinal isNorth.! !

!MarsRoverTests methodsFor: 'testing' stamp: 'MS 5/17/2021 14:41:45'!
test02moveForwardFacingNorthIncrementsYAxis

	| marsRover |
	
	marsRover := MarsRover position: 2@3 cardinal: north.
	marsRover receiveCommands: 'f'.
	
	self assert: 2@4 equals: marsRover position.
	self assert: marsRover cardinal isNorth.! !

!MarsRoverTests methodsFor: 'testing' stamp: 'MS 5/17/2021 14:41:34'!
test03moveBackwardsFacingNorthDecrementsYAxis

	| marsRover |
	
	marsRover := MarsRover position: 2@2 cardinal: north.
	marsRover receiveCommands: 'b'.
	
	self assert: 2@1 equals: marsRover position.
	self assert: marsRover cardinal isNorth.! !

!MarsRoverTests methodsFor: 'testing' stamp: 'MS 5/17/2021 14:42:46'!
test04rotateLeftFacingNorthChangesCardinalToWest

	| marsRover |
	
	marsRover := MarsRover position: 0@0 cardinal: north.
	marsRover receiveCommands: 'l'.
	
	self assert: 0@0 equals: marsRover position.
	self assert: marsRover cardinal isWest.! !

!MarsRoverTests methodsFor: 'testing' stamp: 'MS 5/17/2021 14:43:28'!
test05rotateRightFacingNorthChangesCardinalToEast

	| marsRover |
	
	marsRover := MarsRover position: 0@0 cardinal: north.
	marsRover receiveCommands: 'r'.
	
	self assert: 0@0 equals: marsRover position.
	self assert: marsRover cardinal isEast.! !

!MarsRoverTests methodsFor: 'testing' stamp: 'MS 5/17/2021 14:43:46'!
test06moveForwardFacingEastIncrementsXAxis

	| marsRover |
	
	marsRover := MarsRover position: 2@3 cardinal: east.
	marsRover receiveCommands: 'f'.
	
	self assert: 3@3 equals: marsRover position.
	self assert: marsRover cardinal isEast.! !

!MarsRoverTests methodsFor: 'testing' stamp: 'MS 5/17/2021 14:44:17'!
test07moveForwardFacingSouthDecrementsYAxis

	| marsRover |
	
	marsRover := MarsRover position: 2@3 cardinal: south.
	marsRover receiveCommands: 'f'.
	
	self assert: 2@2 equals: marsRover position.
	self assert: marsRover cardinal isSouth.! !

!MarsRoverTests methodsFor: 'testing' stamp: 'MS 5/17/2021 14:44:36'!
test08moveForwardFacingWestDecrementsXAxis

	| marsRover |
	
	marsRover := MarsRover position: 2@3 cardinal: west.
	marsRover receiveCommands: 'f'.
	
	self assert: 1@3 equals: marsRover position.
	self assert: marsRover cardinal isWest.! !

!MarsRoverTests methodsFor: 'testing' stamp: 'MS 5/17/2021 14:44:59'!
test09moveBackwardsFacingEastDecrementsXAxis

	| marsRover |
	
	marsRover := MarsRover position: 2@3 cardinal: east.
	marsRover receiveCommands: 'b'.
	
	self assert: 1@3 equals: marsRover position.
	self assert: marsRover cardinal isEast.! !

!MarsRoverTests methodsFor: 'testing' stamp: 'MS 5/17/2021 14:45:22'!
test10moveBackwardsFacingSouthIncrementsYAxis

	| marsRover |
	
	marsRover := MarsRover position: 2@3 cardinal: south.
	marsRover receiveCommands: 'b'.
	
	self assert: 2@4 equals: marsRover position.
	self assert: marsRover cardinal isSouth.! !

!MarsRoverTests methodsFor: 'testing' stamp: 'MS 5/17/2021 14:45:42'!
test11moveBackwardsFacingWestIncrementsXAxis

	| marsRover |
	
	marsRover := MarsRover position: 2@3 cardinal: west.
	marsRover receiveCommands: 'b'.
	
	self assert: 3@3 equals: marsRover position.
	self assert: marsRover cardinal isWest.! !

!MarsRoverTests methodsFor: 'testing' stamp: 'MS 5/17/2021 14:47:23'!
test12rotateLeftFacingEastChangesCardinalToNorth

	| marsRover |
	
	marsRover := MarsRover position: 2@3 cardinal: east.
	marsRover receiveCommands: 'l'.
	
	self assert: 2@3 equals: marsRover position.
	self assert: marsRover cardinal isNorth.! !

!MarsRoverTests methodsFor: 'testing' stamp: 'MS 5/17/2021 14:47:36'!
test13rotateLeftFacingSouthChangesCardinalToEast

	| marsRover |
	
	marsRover := MarsRover position: 2@3 cardinal: south.
	marsRover receiveCommands: 'l'.
	
	self assert: 2@3 equals: marsRover position.
	self assert: marsRover cardinal isEast.! !

!MarsRoverTests methodsFor: 'testing' stamp: 'MS 5/17/2021 14:47:56'!
test14rotateLeftFacingWestChangesCardinalToSouth

	| marsRover |
	
	marsRover := MarsRover position: 2@3 cardinal: west.
	marsRover receiveCommands: 'l'.
	
	self assert: 2@3 equals: marsRover position.
	self assert: marsRover cardinal isSouth.! !

!MarsRoverTests methodsFor: 'testing' stamp: 'MS 5/17/2021 14:48:18'!
test15rotateRightFacingWestChangesCardinalToNorth

	| marsRover |
	
	marsRover := MarsRover position: 2@3 cardinal: west.
	marsRover receiveCommands: 'r'.
	
	self assert: 2@3 equals: marsRover position.
	self assert: marsRover cardinal isNorth.! !

!MarsRoverTests methodsFor: 'testing' stamp: 'MS 5/17/2021 14:48:51'!
test16rotateRightFacingSouthChangesCardinalToWest

	| marsRover |
	
	marsRover := MarsRover position: 2@3 cardinal: south.
	marsRover receiveCommands: 'r'.
	
	self assert: 2@3 equals: marsRover position.
	self assert: marsRover cardinal isWest.! !

!MarsRoverTests methodsFor: 'testing' stamp: 'MS 5/17/2021 14:49:09'!
test17rotateRightFacingEastChangesCardinalToSouth

	| marsRover |
	
	marsRover := MarsRover position: 2@3 cardinal: east.
	marsRover receiveCommands: 'r'.
	
	self assert: 2@3 equals: marsRover position.
	self assert: marsRover cardinal isSouth.! !

!MarsRoverTests methodsFor: 'testing' stamp: 'MS 5/17/2021 14:50:57'!
test18moveForwardTwiceFacingNorthIncrementsYAxisTwoTimes

	| marsRover |
	
	marsRover := MarsRover position: 2@3 cardinal: north.
	marsRover receiveCommands: 'ff'.
	
	self assert: 2@5 equals: marsRover position.
	self assert: marsRover cardinal isNorth.! !

!MarsRoverTests methodsFor: 'testing' stamp: 'MS 5/17/2021 15:00:12'!
test19moveForwardThriceFacingNorthIncrementsYAxisThreeTimes

	| marsRover |
	
	marsRover := MarsRover position: 2@3 cardinal: north.
	marsRover receiveCommands: 'fff'.
	
	self assert: 2@6 equals: marsRover position.
	self assert: marsRover cardinal isNorth.! !

!MarsRoverTests methodsFor: 'testing' stamp: 'MS 5/17/2021 15:00:30'!
test20InvalidCommandRaiseErrorAndStopExecuting

	| marsRover |
	
	marsRover := MarsRover position: 2@3 cardinal: north.
	
	self
		should: [ marsRover receiveCommands: 'fbrllrbffxblr'. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = MarsRover ErrorNotValidCommand ].
	
	self assert: 2@4 equals: marsRover position.
	self assert: marsRover cardinal isNorth.! !


!classDefinition: #CardinalMarsRover category: 'MarsRover-Exercise'!
Object subclass: #CardinalMarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!CardinalMarsRover methodsFor: 'comparing' stamp: 'ENC 5/16/2021 00:09:29'!
isEast
	
	self subclassResponsibility ! !

!CardinalMarsRover methodsFor: 'comparing' stamp: 'ENC 5/16/2021 00:09:22'!
isNorth
	
	self subclassResponsibility ! !

!CardinalMarsRover methodsFor: 'comparing' stamp: 'ENC 5/16/2021 00:09:26'!
isSouth
	
	self subclassResponsibility ! !

!CardinalMarsRover methodsFor: 'comparing' stamp: 'ENC 5/16/2021 00:09:31'!
isWest
	
	self subclassResponsibility ! !


!CardinalMarsRover methodsFor: 'actions' stamp: 'ENC 5/15/2021 23:46:49'!
moveBackward: aMarsRover

	self subclassResponsibility ! !

!CardinalMarsRover methodsFor: 'actions' stamp: 'ENC 5/15/2021 23:46:46'!
moveForward: aMarsRover

	self subclassResponsibility ! !

!CardinalMarsRover methodsFor: 'actions' stamp: 'ENC 5/16/2021 00:26:12'!
rotateLeft: aMarsRover

	self subclassResponsibility ! !

!CardinalMarsRover methodsFor: 'actions' stamp: 'ENC 5/16/2021 00:26:20'!
rotateRight: aMarsRover

	self subclassResponsibility ! !


!classDefinition: #CardinalMarsRoverEast category: 'MarsRover-Exercise'!
CardinalMarsRover subclass: #CardinalMarsRoverEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!CardinalMarsRoverEast methodsFor: 'actions' stamp: 'ENC 5/15/2021 23:47:27'!
moveBackward: aMarsRover

	aMarsRover moveBackwardFacingEast.! !

!CardinalMarsRoverEast methodsFor: 'actions' stamp: 'ENC 5/15/2021 23:47:33'!
moveForward: aMarsRover

	aMarsRover moveForwardFacingEast.! !

!CardinalMarsRoverEast methodsFor: 'actions' stamp: 'ENC 5/16/2021 00:26:37'!
rotateLeft: aMarsRover

	aMarsRover rotateLeftFacingEast.! !

!CardinalMarsRoverEast methodsFor: 'actions' stamp: 'ENC 5/16/2021 00:26:54'!
rotateRight: aMarsRover

	aMarsRover rotateRightFacingEast.! !


!CardinalMarsRoverEast methodsFor: 'comparing' stamp: 'ENC 5/16/2021 00:10:00'!
isEast

	^ true! !

!CardinalMarsRoverEast methodsFor: 'comparing' stamp: 'ENC 5/16/2021 00:09:48'!
isNorth

	^ false! !

!CardinalMarsRoverEast methodsFor: 'comparing' stamp: 'ENC 5/16/2021 00:09:51'!
isSouth

	^ false! !

!CardinalMarsRoverEast methodsFor: 'comparing' stamp: 'ENC 5/16/2021 00:09:54'!
isWest

	^ false! !


!classDefinition: #CardinalMarsRoverNorth category: 'MarsRover-Exercise'!
CardinalMarsRover subclass: #CardinalMarsRoverNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!CardinalMarsRoverNorth methodsFor: 'comparing' stamp: 'ENC 5/16/2021 00:10:35'!
isEast

	^ false! !

!CardinalMarsRoverNorth methodsFor: 'comparing' stamp: 'ENC 5/16/2021 00:10:25'!
isNorth

	^ true! !

!CardinalMarsRoverNorth methodsFor: 'comparing' stamp: 'ENC 5/16/2021 00:10:32'!
isSouth

	^ false! !

!CardinalMarsRoverNorth methodsFor: 'comparing' stamp: 'ENC 5/16/2021 00:10:39'!
isWest

	^ false! !


!CardinalMarsRoverNorth methodsFor: 'actions' stamp: 'ENC 5/15/2021 23:47:06'!
moveBackward: aMarsRover

	aMarsRover moveBackwardFacingNorth.! !

!CardinalMarsRoverNorth methodsFor: 'actions' stamp: 'ENC 5/15/2021 23:47:14'!
moveForward: aMarsRover

	aMarsRover moveForwardFacingNorth.! !

!CardinalMarsRoverNorth methodsFor: 'actions' stamp: 'ENC 5/16/2021 00:27:09'!
rotateLeft: aMarsRover

	aMarsRover rotateLeftFacingNorth.! !

!CardinalMarsRoverNorth methodsFor: 'actions' stamp: 'ENC 5/16/2021 00:27:18'!
rotateRight: aMarsRover

	aMarsRover rotateRightFacingNorth.! !


!classDefinition: #CardinalMarsRoverSouth category: 'MarsRover-Exercise'!
CardinalMarsRover subclass: #CardinalMarsRoverSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!CardinalMarsRoverSouth methodsFor: 'comparing' stamp: 'ENC 5/16/2021 00:11:23'!
isEast
	
	^ false! !

!CardinalMarsRoverSouth methodsFor: 'comparing' stamp: 'ENC 5/16/2021 00:11:19'!
isNorth
	
	^ false! !

!CardinalMarsRoverSouth methodsFor: 'comparing' stamp: 'ENC 5/16/2021 00:11:33'!
isSouth
	
	^ true! !

!CardinalMarsRoverSouth methodsFor: 'comparing' stamp: 'ENC 5/16/2021 00:11:27'!
isWest
	
	^ false! !


!CardinalMarsRoverSouth methodsFor: 'actions' stamp: 'ENC 5/15/2021 23:47:49'!
moveBackward: aMarsRover

	aMarsRover moveBackwardFacingSouth.! !

!CardinalMarsRoverSouth methodsFor: 'actions' stamp: 'ENC 5/15/2021 23:47:39'!
moveForward: aMarsRover

	aMarsRover moveForwardFacingSouth.! !

!CardinalMarsRoverSouth methodsFor: 'actions' stamp: 'ENC 5/16/2021 00:27:58'!
rotateLeft: aMarsRover

	aMarsRover rotateLeftFacingSouth.! !

!CardinalMarsRoverSouth methodsFor: 'actions' stamp: 'ENC 5/16/2021 00:28:13'!
rotateRight: aMarsRover

	aMarsRover rotateRightFacingSouth.! !


!classDefinition: #CardinalMarsRoverWest category: 'MarsRover-Exercise'!
CardinalMarsRover subclass: #CardinalMarsRoverWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!CardinalMarsRoverWest methodsFor: 'comparing' stamp: 'ENC 5/16/2021 00:11:55'!
isEast

	^ false! !

!CardinalMarsRoverWest methodsFor: 'comparing' stamp: 'ENC 5/16/2021 00:11:46'!
isNorth

	^ false! !

!CardinalMarsRoverWest methodsFor: 'comparing' stamp: 'ENC 5/16/2021 00:11:51'!
isSouth

	^ false! !

!CardinalMarsRoverWest methodsFor: 'comparing' stamp: 'ENC 5/16/2021 00:12:00'!
isWest

	^ true! !


!CardinalMarsRoverWest methodsFor: 'actions' stamp: 'ENC 5/15/2021 23:48:09'!
moveBackward: aMarsRover

	aMarsRover moveBackwardFacingWest.! !

!CardinalMarsRoverWest methodsFor: 'actions' stamp: 'ENC 5/15/2021 23:48:19'!
moveForward: aMarsRover

	aMarsRover moveForwardFacingWest.! !

!CardinalMarsRoverWest methodsFor: 'actions' stamp: 'ENC 5/16/2021 00:28:29'!
rotateLeft: aMarsRover

	aMarsRover rotateLeftFacingWest.! !

!CardinalMarsRoverWest methodsFor: 'actions' stamp: 'ENC 5/16/2021 00:28:42'!
rotateRight: aMarsRover

	aMarsRover rotateRightFacingWest.! !


!classDefinition: #MarsRover category: 'MarsRover-Exercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'position cardinal'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRover methodsFor: 'initialization' stamp: 'ENC 5/15/2021 23:10:17'!
initializePosition: aPosition cardinal: aCardinal 
	
	position := aPosition.
	cardinal := aCardinal.! !


!MarsRover methodsFor: 'actions - private' stamp: 'ENC 5/16/2021 00:47:17'!
decrementPositionX

	position := position - (1@0)! !

!MarsRover methodsFor: 'actions - private' stamp: 'ENC 5/16/2021 00:47:22'!
decrementPositionY

	position := position - (0@1)! !

!MarsRover methodsFor: 'actions - private' stamp: 'ENC 5/16/2021 00:47:09'!
incrementPositionX

	position := position + (1@0)! !

!MarsRover methodsFor: 'actions - private' stamp: 'ENC 5/16/2021 00:47:02'!
incrementPositionY

	position := position + (0@1)! !

!MarsRover methodsFor: 'actions - private' stamp: 'ENC 5/16/2021 00:49:31'!
moveBackwardFacingEast

	self decrementPositionX.! !

!MarsRover methodsFor: 'actions - private' stamp: 'ENC 5/16/2021 00:49:37'!
moveBackwardFacingNorth

	self decrementPositionY.! !

!MarsRover methodsFor: 'actions - private' stamp: 'ENC 5/16/2021 00:48:25'!
moveBackwardFacingSouth

	self incrementPositionY.! !

!MarsRover methodsFor: 'actions - private' stamp: 'ENC 5/16/2021 00:48:14'!
moveBackwardFacingWest

	self incrementPositionX.! !

!MarsRover methodsFor: 'actions - private' stamp: 'ENC 5/16/2021 01:01:34'!
moveForwardFacingEast

	self incrementPositionX.! !

!MarsRover methodsFor: 'actions - private' stamp: 'ENC 5/16/2021 01:01:38'!
moveForwardFacingNorth

	self incrementPositionY.! !

!MarsRover methodsFor: 'actions - private' stamp: 'ENC 5/16/2021 00:50:24'!
moveForwardFacingSouth

	self decrementPositionY.! !

!MarsRover methodsFor: 'actions - private' stamp: 'ENC 5/16/2021 00:50:50'!
moveForwardFacingWest

	self decrementPositionX.! !

!MarsRover methodsFor: 'actions - private' stamp: 'ENC 5/16/2021 00:30:25'!
rotateLeftFacingEast

	cardinal := CardinalMarsRoverNorth new.! !

!MarsRover methodsFor: 'actions - private' stamp: 'ENC 5/16/2021 00:30:42'!
rotateLeftFacingNorth

	cardinal := CardinalMarsRoverWest new.! !

!MarsRover methodsFor: 'actions - private' stamp: 'ENC 5/16/2021 00:31:11'!
rotateLeftFacingSouth

	cardinal := CardinalMarsRoverEast new.! !

!MarsRover methodsFor: 'actions - private' stamp: 'ENC 5/16/2021 00:30:51'!
rotateLeftFacingWest

	cardinal := CardinalMarsRoverSouth new.! !

!MarsRover methodsFor: 'actions - private' stamp: 'ENC 5/16/2021 00:32:25'!
rotateRightFacingEast

	cardinal := CardinalMarsRoverSouth new.! !

!MarsRover methodsFor: 'actions - private' stamp: 'ENC 5/16/2021 00:31:51'!
rotateRightFacingNorth

	cardinal := CardinalMarsRoverEast new.! !

!MarsRover methodsFor: 'actions - private' stamp: 'ENC 5/16/2021 00:31:34'!
rotateRightFacingSouth

	cardinal := CardinalMarsRoverWest new.! !

!MarsRover methodsFor: 'actions - private' stamp: 'ENC 5/16/2021 00:31:43'!
rotateRightFacingWest

	cardinal := CardinalMarsRoverNorth new.! !


!MarsRover methodsFor: 'actions' stamp: 'ENC 5/16/2021 00:53:33'!
receiveCommand: aCommand 

	aCommand = $f ifTrue: [ ^ cardinal moveForward: self ].
	aCommand = $b ifTrue: [ ^ cardinal moveBackward: self ].
	aCommand = $l ifTrue: [ ^ cardinal rotateLeft: self ].
	aCommand = $r ifTrue: [ ^ cardinal rotateRight: self ].
	
	^ self error: self class ErrorNotValidCommand.! !

!MarsRover methodsFor: 'actions' stamp: 'ENC 5/16/2021 00:43:46'!
receiveCommands: aString 

	aString do: [ :aCommand | self receiveCommand: aCommand ].		! !


!MarsRover methodsFor: 'information' stamp: 'ENC 5/15/2021 23:11:36'!
cardinal
	
	^ cardinal! !

!MarsRover methodsFor: 'information' stamp: 'ENC 5/15/2021 23:11:10'!
position
	
	^ position! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-Exercise'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'ENC 5/15/2021 23:09:29'!
position: aPosition cardinal: aCardinal 
	
	^ self new initializePosition: aPosition cardinal: aCardinal ! !


!MarsRover class methodsFor: 'errors descriptions' stamp: 'ENC 5/16/2021 00:55:10'!
ErrorNotValidCommand

	^ 'El comando recibido no es válido'.! !
