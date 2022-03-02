!classDefinition: #MarsRoverTest category: #EjercicioMarsRover!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'south north west east forwardOrder backwardOrder rotateRightOrder rotateLeftOrder centerPoint3by3Grid'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRover'!

!MarsRoverTest methodsFor: 'rotating tests' stamp: 'FS 10/26/2020 14:19:20'!
test04rotatingLeftDirectionFromSouthPointsEast
	| Rover|
	Rover _ self RoverIn3by3GridStartingAt: centerPoint3by3Grid pointing: south.
	
	Rover receiveOrder: rotateLeftOrder .
	
	self assertThatOnlyPointsEast: Rover.! !

!MarsRoverTest methodsFor: 'rotating tests' stamp: 'FS 10/26/2020 14:19:43'!
test05rotatingRightDirectionFromSouthPointsWest
	| Rover|
	Rover _ self RoverIn3by3GridStartingAt: centerPoint3by3Grid pointing: south.
	
	Rover receiveOrder: rotateRightOrder .
	
	self assertThatOnlyPointsWest: Rover.! !

!MarsRoverTest methodsFor: 'rotating tests' stamp: 'FS 10/26/2020 14:20:10'!
test08rotatingRightDirectionFromNorthPointsEast
	| Rover|
	Rover _ self RoverIn3by3GridStartingAt: centerPoint3by3Grid pointing: north.
	
	Rover receiveOrder: rotateRightOrder .
	
	self assertThatOnlyPointsEast: Rover
! !

!MarsRoverTest methodsFor: 'rotating tests' stamp: 'FS 10/26/2020 14:20:24'!
test09rotatingLeftDirectionFromNorthPointsWest
	| Rover|
	Rover _ self RoverIn3by3GridStartingAt: centerPoint3by3Grid pointing: north.
	
	Rover receiveOrder: rotateLeftOrder .
	
	self assertThatOnlyPointsWest: Rover
! !

!MarsRoverTest methodsFor: 'rotating tests' stamp: 'FS 10/26/2020 14:20:49'!
test12rotatingRightDirectionFromWestPointsNorth
	| Rover|
	Rover _ self RoverIn3by3GridStartingAt: centerPoint3by3Grid pointing: west.
	
	Rover receiveOrder: rotateRightOrder .
	
	self assertThatOnlyPointsNorth: Rover.! !

!MarsRoverTest methodsFor: 'rotating tests' stamp: 'FS 10/26/2020 14:21:14'!
test13rotatingLeftDirectionFromWestPointsSouth
	| Rover|
	Rover _ self RoverIn3by3GridStartingAt: centerPoint3by3Grid pointing: west.
	
	Rover receiveOrder: rotateLeftOrder .
	
	self assertThatOnlyPointsSouth: Rover.! !

!MarsRoverTest methodsFor: 'rotating tests' stamp: 'FS 10/26/2020 14:21:23'!
test16rotatingRightDirectionFromEastPointsSouth
	| Rover|
	Rover _ self RoverIn3by3GridStartingAt: centerPoint3by3Grid pointing: east.
	
	Rover receiveOrder: rotateRightOrder.
	
	self assertThatOnlyPointsSouth: Rover.! !

!MarsRoverTest methodsFor: 'rotating tests' stamp: 'FS 10/26/2020 14:21:32'!
test17rotatingLeftDirectionFromEastPointsNorth
	| Rover|
	Rover _ self RoverIn3by3GridStartingAt: centerPoint3by3Grid pointing: east.
	
	Rover receiveOrder: rotateLeftOrder .
	
	self assertThatOnlyPointsNorth: Rover.! !


!MarsRoverTest methodsFor: 'movement tests' stamp: 'FS 10/26/2020 14:05:15'!
RoverIn3by3GridStartingAt: aStartingPoint pointing: aCardinalDirection
	 
	^MarsRover startingAt: aStartingPoint pointingTo: aCardinalDirection withMapHeight: 3 withMapWidth: 3.
	
	 ! !

!MarsRoverTest methodsFor: 'movement tests' stamp: 'FS 10/26/2020 14:17:39'!
test02movingForwardWithSouthDirectionGoesDownInGrid
	| Rover|
	Rover _ self RoverIn3by3GridStartingAt: centerPoint3by3Grid pointing: south.
	
	Rover receiveOrder: forwardOrder .
	
	self assert: Rover currentPosition equals: 2@3.! !

!MarsRoverTest methodsFor: 'movement tests' stamp: 'FS 10/26/2020 14:17:42'!
test03movingBackwardWithSouthDirectionGoesUpInGrid
	| Rover|
	Rover _ self RoverIn3by3GridStartingAt: centerPoint3by3Grid pointing: south.
	
	Rover receiveOrder: backwardOrder .
	
	self assert: Rover currentPosition equals: 2@1.! !

!MarsRoverTest methodsFor: 'movement tests' stamp: 'FS 10/26/2020 14:17:45'!
test06movingForwardWithNorthDirectionGoesUpInGrid
	| Rover|
	Rover _ self RoverIn3by3GridStartingAt: centerPoint3by3Grid pointing: north.
	
	Rover receiveOrder: forwardOrder.
	
	self assert: Rover currentPosition equals: 2@1.! !

!MarsRoverTest methodsFor: 'movement tests' stamp: 'FS 10/26/2020 14:17:47'!
test07movingBackwardWithNorthDirectionGoesDownInGrid
	| Rover|
	Rover _ self RoverIn3by3GridStartingAt: centerPoint3by3Grid pointing: north.
	
	Rover receiveOrder: backwardOrder .
	
	self assert: Rover currentPosition equals: 2@3.! !

!MarsRoverTest methodsFor: 'movement tests' stamp: 'FS 10/26/2020 14:17:51'!
test10movingForwardWithWestDirectionGoesLeftInGrid
	| Rover|
	Rover _ self RoverIn3by3GridStartingAt: centerPoint3by3Grid pointing: west.
	
	Rover receiveOrder: forwardOrder.
	
	self assert: Rover currentPosition equals: 1@2! !

!MarsRoverTest methodsFor: 'movement tests' stamp: 'FS 10/26/2020 14:17:55'!
test11movingBackwardWithWestDirectionGoesRightInGrid
	| Rover|
	Rover _ self RoverIn3by3GridStartingAt: centerPoint3by3Grid pointing: west.
	
	Rover receiveOrder: backwardOrder .
	
	self assert: Rover currentPosition equals: 3@2! !

!MarsRoverTest methodsFor: 'movement tests' stamp: 'FS 10/26/2020 14:17:58'!
test14movingForwardWithEastDirectionGoesRightInGrid
	| Rover|
	Rover _ self RoverIn3by3GridStartingAt: centerPoint3by3Grid pointing: east.
	
	Rover receiveOrder: forwardOrder .
	
	self assert: Rover currentPosition equals: 3@2.! !

!MarsRoverTest methodsFor: 'movement tests' stamp: 'FS 10/26/2020 14:18:02'!
test15movingBackwardWithEastDirectionGoesLeftInGrid
	| Rover|
	Rover _ self RoverIn3by3GridStartingAt: centerPoint3by3Grid pointing: east.
	
	Rover receiveOrder: backwardOrder .
	
	self assert: Rover currentPosition equals: 1@2.! !


!MarsRoverTest methodsFor: 'movement grid border tests' stamp: 'FS 10/26/2020 14:15:18'!
test18movingForwardWithWestDirectionInWestBorderGoesToEastBorder
	| Rover|
	Rover _ self RoverIn3by3GridStartingAt: 1@1 pointing: west.
	
	Rover receiveOrder: forwardOrder.
	
	self assert: Rover currentPosition equals: 3@1.! !

!MarsRoverTest methodsFor: 'movement grid border tests' stamp: 'FS 10/26/2020 14:15:23'!
test19movingForwardWithNorthDirectionInNorthBorderGoesToSouthBorder
	| Rover|
	Rover _ self RoverIn3by3GridStartingAt: 1@1 pointing: north.
	
	Rover receiveOrder: forwardOrder.
	
	self assert: Rover currentPosition equals: 1@3.! !

!MarsRoverTest methodsFor: 'movement grid border tests' stamp: 'FS 10/26/2020 14:15:26'!
test20movingForwardWithSouthDirectionInSouthBorderGoesToNorthBorder
	| Rover|
	Rover _ self RoverIn3by3GridStartingAt: 1@3 pointing: south.
	
	Rover receiveOrder: forwardOrder.
	
	self assert: Rover currentPosition equals: 1@1.! !

!MarsRoverTest methodsFor: 'movement grid border tests' stamp: 'FS 10/26/2020 14:15:31'!
test21movingForwardWithEastDirectionInEastBorderGoesToWestBorder
	| Rover|
	Rover _ self RoverIn3by3GridStartingAt: 3@1 pointing: east.
	
	Rover receiveOrder: forwardOrder.
	
	self assert: Rover currentPosition equals: 1@1.! !

!MarsRoverTest methodsFor: 'movement grid border tests' stamp: 'FS 10/26/2020 14:15:37'!
test22movingBackwardWithWestDirectionInEastBorderGoesToWestBorder
	| Rover|
	Rover _ self RoverIn3by3GridStartingAt: 3@1 pointing: west.
	
	Rover receiveOrder: backwardOrder .
	
	self assert: Rover currentPosition equals: 1@1.! !

!MarsRoverTest methodsFor: 'movement grid border tests' stamp: 'FS 10/26/2020 14:15:40'!
test23movingBackwardWithNorthDirectionInSouthBorderGoesToNorthBorder
	| Rover|
	Rover _ self RoverIn3by3GridStartingAt: 1@3 pointing: north.
	
	Rover receiveOrder: backwardOrder .
	
	self assert: Rover currentPosition equals: 1@1.! !

!MarsRoverTest methodsFor: 'movement grid border tests' stamp: 'FS 10/26/2020 14:15:44'!
test24movingBackwardWithEastDirectionInWestBorderGoesToEastBorder
	| Rover|
	Rover _ self RoverIn3by3GridStartingAt: 1@1 pointing: east.
	
	Rover receiveOrder: backwardOrder .
	
	self assert: Rover currentPosition equals: 3@1.! !

!MarsRoverTest methodsFor: 'movement grid border tests' stamp: 'FS 10/26/2020 14:15:47'!
test25movingBackwardWithSouthDirectionInNorthBorderGoesToSouthBorder
	| Rover|
	Rover _ self RoverIn3by3GridStartingAt: 1@1 pointing: south.
	
	Rover receiveOrder: backwardOrder .
	
	self assert: Rover currentPosition equals: 1@3.! !


!MarsRoverTest methodsFor: 'multiple orders tests' stamp: 'FS 10/26/2020 14:10:57'!
test26assertValidOrderSequenceGoingForwardAndRotate
	| Rover|
	Rover _ self RoverIn3by3GridStartingAt: 1@1 pointing: south.
	
	Rover receiveOrder: 'ffr'.
	
	self assert: Rover currentPosition equals: 1@3.
	self assert: Rover pointsWest.! !


!MarsRoverTest methodsFor: 'invalid order test' stamp: 'FS 10/26/2020 14:11:08'!
test27assertStopExecutionAtInvalidOrder
	| Rover|
	
	self
		should:[
			Rover _ self RoverIn3by3GridStartingAt: 1@1 pointing: south.
			Rover receiveOrder: 'frNKf'.
			]
		raise: Error
		withMessageText: MarsRover invalidErrorCharacterDescription. 
	
	self assert: Rover currentPosition equals: 1@2.
	self assert: Rover pointsWest .
	
! !


!MarsRoverTest methodsFor: 'setUp' stamp: 'FS 10/26/2020 14:16:46'!
setUp
	south _ SouthDirection new.
	north _ NorthDirection new.
	west _ WestDirection new.
	east _ EastDirection new.
	
	forwardOrder _ 'f'.
	backwardOrder _ 'b'.
	rotateRightOrder _ 'r'.
	rotateLeftOrder _ 'l'.
	
	centerPoint3by3Grid _ 2@2.! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'FS 10/26/2020 14:19:20'!
assertThatOnlyPointsEast: Rover

	self assert: Rover pointsEast.
	self deny: Rover pointsWest.
	self deny: Rover pointsSouth.
	self deny: Rover pointsNorth! !

!MarsRoverTest methodsFor: 'assertions' stamp: 'FS 10/26/2020 14:20:49'!
assertThatOnlyPointsNorth: Rover

	self deny: Rover pointsEast.
	self deny: Rover pointsWest.
	self deny: Rover pointsSouth.
	self assert: Rover pointsNorth! !

!MarsRoverTest methodsFor: 'assertions' stamp: 'FS 10/26/2020 14:21:14'!
assertThatOnlyPointsSouth: Rover

	self deny: Rover pointsEast.
	self deny: Rover pointsWest.
	self assert: Rover pointsSouth.
	self deny: Rover pointsNorth! !

!MarsRoverTest methodsFor: 'assertions' stamp: 'FS 10/26/2020 14:19:43'!
assertThatOnlyPointsWest: Rover

	self deny: Rover pointsEast.
	self assert: Rover pointsWest.
	self deny: Rover pointsSouth.
	self deny: Rover pointsNorth! !


!classDefinition: #GridCardinalDirection category: #EjercicioMarsRover!
Object subclass: #GridCardinalDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRover'!

!GridCardinalDirection methodsFor: 'movement arithmetic' stamp: 'FS 10/26/2020 13:40:14'!
forwardPointOffset
	self subclassResponsibility.! !


!GridCardinalDirection methodsFor: 'rotating ' stamp: 'HG 10/25/2020 13:08:36'!
rotateLeft
	self subclassResponsibility.! !

!GridCardinalDirection methodsFor: 'rotating ' stamp: 'HG 10/25/2020 13:08:39'!
rotateRight
	self subclassResponsibility.! !


!GridCardinalDirection methodsFor: 'testing' stamp: 'FS 10/26/2020 13:39:07'!
pointsEast
	self subclassResponsibility.! !

!GridCardinalDirection methodsFor: 'testing' stamp: 'FS 10/26/2020 13:39:27'!
pointsNorth
	self subclassResponsibility.! !

!GridCardinalDirection methodsFor: 'testing' stamp: 'FS 10/26/2020 13:39:46'!
pointsSouth
	self subclassResponsibility.! !

!GridCardinalDirection methodsFor: 'testing' stamp: 'FS 10/26/2020 13:39:39'!
pointsWest
	self subclassResponsibility.! !


!classDefinition: #EastDirection category: #EjercicioMarsRover!
GridCardinalDirection subclass: #EastDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRover'!

!EastDirection methodsFor: 'rotating' stamp: 'FS 10/26/2020 13:37:34'!
rotateLeft
	^NorthDirection new.! !

!EastDirection methodsFor: 'rotating' stamp: 'FS 10/26/2020 13:37:40'!
rotateRight
	^SouthDirection new.! !


!EastDirection methodsFor: 'movement arithmetic' stamp: 'FS 10/26/2020 13:53:36'!
forwardPointOffset
	^1@0.! !


!EastDirection methodsFor: 'testing' stamp: 'FS 10/26/2020 13:39:07'!
pointsEast
	^true.! !

!EastDirection methodsFor: 'testing' stamp: 'FS 10/26/2020 13:39:27'!
pointsNorth
	^false.! !

!EastDirection methodsFor: 'testing' stamp: 'FS 10/26/2020 13:39:46'!
pointsSouth
	^false.! !

!EastDirection methodsFor: 'testing' stamp: 'FS 10/26/2020 13:39:39'!
pointsWest
	^false.! !


!classDefinition: #NorthDirection category: #EjercicioMarsRover!
GridCardinalDirection subclass: #NorthDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRover'!

!NorthDirection methodsFor: 'movement arithmetic' stamp: 'FS 10/26/2020 13:53:30'!
forwardPointOffset
	^0@-1.! !


!NorthDirection methodsFor: 'rotating' stamp: 'FS 10/26/2020 13:37:47'!
rotateLeft
	^WestDirection new.! !

!NorthDirection methodsFor: 'rotating' stamp: 'FS 10/26/2020 13:37:26'!
rotateRight
	^EastDirection new.! !


!NorthDirection methodsFor: 'testing' stamp: 'FS 10/26/2020 13:39:07'!
pointsEast
	^false.! !

!NorthDirection methodsFor: 'testing' stamp: 'FS 10/26/2020 13:39:27'!
pointsNorth
	^true.! !

!NorthDirection methodsFor: 'testing' stamp: 'FS 10/26/2020 13:39:46'!
pointsSouth
	^false.! !

!NorthDirection methodsFor: 'testing' stamp: 'FS 10/26/2020 13:39:39'!
pointsWest
	^false.! !


!classDefinition: #SouthDirection category: #EjercicioMarsRover!
GridCardinalDirection subclass: #SouthDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRover'!

!SouthDirection methodsFor: 'movement arithmetic' stamp: 'FS 10/26/2020 13:53:26'!
forwardPointOffset
	^0@1.! !


!SouthDirection methodsFor: 'rotating' stamp: 'FS 10/26/2020 13:37:26'!
rotateLeft
	^EastDirection new.! !

!SouthDirection methodsFor: 'rotating' stamp: 'FS 10/26/2020 13:37:47'!
rotateRight
	^WestDirection new.! !


!SouthDirection methodsFor: 'testing' stamp: 'FS 10/26/2020 13:39:07'!
pointsEast	
	^false.! !

!SouthDirection methodsFor: 'testing' stamp: 'FS 10/26/2020 13:39:27'!
pointsNorth
	^false.! !

!SouthDirection methodsFor: 'testing' stamp: 'FS 10/26/2020 13:39:46'!
pointsSouth
	^true.! !

!SouthDirection methodsFor: 'testing' stamp: 'FS 10/26/2020 13:39:39'!
pointsWest	
	^false.! !


!classDefinition: #WestDirection category: #EjercicioMarsRover!
GridCardinalDirection subclass: #WestDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRover'!

!WestDirection methodsFor: 'rotating' stamp: 'FS 10/26/2020 13:37:40'!
rotateLeft
	^SouthDirection new.! !

!WestDirection methodsFor: 'rotating' stamp: 'FS 10/26/2020 13:37:34'!
rotateRight
	^NorthDirection new.! !


!WestDirection methodsFor: 'movement arithmetic' stamp: 'FS 10/26/2020 13:53:19'!
forwardPointOffset
	^-1@0.! !


!WestDirection methodsFor: 'testing' stamp: 'FS 10/26/2020 13:39:07'!
pointsEast	
	^false.! !

!WestDirection methodsFor: 'testing' stamp: 'FS 10/26/2020 13:39:27'!
pointsNorth
	^false.! !

!WestDirection methodsFor: 'testing' stamp: 'FS 10/26/2020 13:39:46'!
pointsSouth
	^false.! !

!WestDirection methodsFor: 'testing' stamp: 'FS 10/26/2020 13:39:39'!
pointsWest	
	^true.! !


!classDefinition: #MarsRover category: #EjercicioMarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction mapHeight mapWidth validOrders'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'FS 10/26/2020 13:55:57'!
initializeStartingAt: aStartingPoint pointingTo: aCardinalPoint MapHeight: aMapHeight MapWidth: aMapWidth 
	position := aStartingPoint.
	direction := aCardinalPoint.
	mapHeight := aMapHeight.
	mapWidth := aMapWidth.
	
	validOrders _ {
		$f -> self forwardOperationBlock.
		$b -> self backwardOperationBlock.
		$r -> self rotateRightOperationBlock.
		$l -> self rotateLeftOperationBlock.
	} asDictionary.! !


!MarsRover methodsFor: 'movement - private' stamp: 'FS 10/26/2020 14:25:21'!
fixPositionWhenOutsideBorder

	self fixYCoordinateWhenOutsideGrid.
	self fixXCoordinateWhenOutsideGrid.! !

!MarsRover methodsFor: 'movement - private' stamp: 'FS 10/26/2020 14:24:49'!
fixXCoordinateWhenOutsideGrid

	position x <1 ifTrue: [position _ mapWidth@(position y)].
	position x > mapWidth ifTrue: [position _ 1@(position y)]! !

!MarsRover methodsFor: 'movement - private' stamp: 'FS 10/26/2020 14:25:00'!
fixYCoordinateWhenOutsideGrid

	position y <1 ifTrue:[position _ (position x)@(mapHeight)].
	position y > mapHeight ifTrue:[position _ (position x)@1]! !


!MarsRover methodsFor: 'actions' stamp: 'FS 10/26/2020 14:25:21'!
executeValidOrder: aValidOrderToExecute
	| OrderOperationBlock |
	
	OrderOperationBlock := validOrders at: aValidOrderToExecute.
	(OrderOperationBlock) value.
	
	self fixPositionWhenOutsideBorder.! !

!MarsRover methodsFor: 'actions' stamp: 'HG 10/25/2020 19:59:32'!
receiveOrder: aSequenceOfOrders 
						
	aSequenceOfOrders do: [:anOrder | (self shouldBeExecuted: anOrder) 
									ifTrue: [ self executeValidOrder: anOrder ] 
									ifFalse: [ self class signalInvalidOrderCharacter. ]].! !

!MarsRover methodsFor: 'actions' stamp: 'FS 10/26/2020 13:52:31'!
shouldBeExecuted: anOrderToExecute

	^validOrders includesKey: anOrderToExecute  .
	 ! !


!MarsRover methodsFor: 'accessing' stamp: 'FS 10/24/2020 20:06:55'!
currentPosition
	^position ! !


!MarsRover methodsFor: 'testing' stamp: 'FS 10/26/2020 13:39:07'!
pointsEast
	^direction pointsEast.! !

!MarsRover methodsFor: 'testing' stamp: 'FS 10/26/2020 13:39:27'!
pointsNorth
	^direction pointsNorth.! !

!MarsRover methodsFor: 'testing' stamp: 'FS 10/26/2020 13:39:46'!
pointsSouth
	^ direction pointsSouth.! !

!MarsRover methodsFor: 'testing' stamp: 'FS 10/26/2020 13:39:39'!
pointsWest
	^direction pointsWest.! !


!MarsRover methodsFor: 'initialization - private' stamp: 'FS 10/26/2020 13:55:32'!
backwardOperationBlock

	^ [position _ position - (direction forwardPointOffset).]! !

!MarsRover methodsFor: 'initialization - private' stamp: 'FS 10/26/2020 13:55:17'!
forwardOperationBlock

	^ [position _ position + (direction forwardPointOffset).]! !

!MarsRover methodsFor: 'initialization - private' stamp: 'FS 10/26/2020 13:55:57'!
rotateLeftOperationBlock

	^ [direction _ direction rotateLeft.]! !

!MarsRover methodsFor: 'initialization - private' stamp: 'FS 10/26/2020 13:55:46'!
rotateRightOperationBlock

	^ [direction _ direction rotateRight.]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #EjercicioMarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'FS 10/24/2020 21:06:18'!
startingAt: aStartingPoint pointingTo: aCardinalPoint withMapHeight: aMapHeight withMapWidth: aMapWidth

	^self new initializeStartingAt: aStartingPoint pointingTo: aCardinalPoint MapHeight: aMapHeight MapWidth: aMapWidth! !


!MarsRover class methodsFor: 'actions' stamp: 'FS 10/24/2020 20:05:44'!
receiveOrder
	^nil! !


!MarsRover class methodsFor: 'exceptions' stamp: 'HG 10/25/2020 19:53:25'!
signalInvalidOrderCharacter
	
	self error: self invalidErrorCharacterDescription.! !


!MarsRover class methodsFor: 'error messages' stamp: 'HG 10/25/2020 19:54:18'!
invalidErrorCharacterDescription
	
	^'Invalid Order Character Error'! !
