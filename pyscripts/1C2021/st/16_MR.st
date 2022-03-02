!classDefinition: #MarsRoverTest category: 'MarsRover-Exercise'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverTest methodsFor: 'testing' stamp: 'ja 5/16/2021 19:33:56'!
test01MarsRoverStartCorrectly

	| marsRover |
	
	marsRover _ MarsRover inPosition: 1@3 heading: #North.
	
	self assert: (marsRover isInPosition: 1@3 heading: #North).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'ja 5/16/2021 19:43:52'!
test02MarsRoverDoesNotStartHeadingToAnInvalidCardinalPoint

	self should: [ MarsRover inPosition: 1@3 heading: #A] 
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: MarsRover invalidCardinalPointErrorDescription].
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'ja 5/16/2021 20:21:50'!
test03MarsRoverMoveForwardCorrectly

	| marsRover |
	
	marsRover _ MarsRover inPosition: 1@3 heading: #North.
	
	marsRover process: 'f'. 
	
	self assert: (marsRover isInPosition: 1@4 heading: #North).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'ja 5/16/2021 20:21:54'!
test04MarsRoverMoveBackwardCorrectly

	| marsRover |
	
	marsRover _ MarsRover inPosition: 1@3 heading: #North.
	
	marsRover process: 'b'. 
	
	self assert: (marsRover isInPosition: 1@2 heading: #North).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'ja 5/16/2021 20:21:58'!
test05MarsRoverTurnRightCorrectly

	| marsRover |
	
	marsRover _ MarsRover inPosition: 1@3 heading: #North.
	
	marsRover process: 'r'. 
	
	self assert: (marsRover isInPosition: 1@3 heading: #East).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'ja 5/16/2021 20:22:02'!
test06MarsRoverTurnLeftCorrectly

	| marsRover |
	
	marsRover _ MarsRover inPosition: 1@3 heading: #North.
	
	marsRover process: 'l'. 
	
	self assert: (marsRover isInPosition: 1@3 heading: #West).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'ja 5/16/2021 20:06:05'!
test07MarsRoverCanNotProcessInvalidCommand

	| marsRover |
	
	marsRover _ MarsRover inPosition: 1@3 heading: #North.
	
	self should: [ marsRover process: 'a' ] 
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isInPosition: 1@3 heading: #North)].! !

!MarsRoverTest methodsFor: 'testing' stamp: 'ja 5/16/2021 20:09:36'!
test08MarsRoverProcessCommandListCorrectly

	| marsRover |
	
	marsRover _ MarsRover inPosition: 1@3 heading: #North.
	
	marsRover process: 'flbrbr'.
	
	self assert: (marsRover isInPosition: 2@3 heading: #East).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'ja 5/16/2021 20:12:09'!
test09MarsRoverProcessCommandsListCorrectlyBeforeProcessingInvalidCommand

	| marsRover |
	
	marsRover _ MarsRover inPosition: 1@3 heading: #North.

	self should: [ 	marsRover process: 'flbrbxr'. ] 
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isInPosition: 2@3 heading: #North)].
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'ja 5/16/2021 20:22:12'!
test10MarsRoverDoesNothingIfItNotReceiveCommands

	| marsRover |
	
	marsRover _ MarsRover inPosition: 1@3 heading: #North.
	
	marsRover process: ''. 
	
	self assert: (marsRover isInPosition: 1@3 heading: #North).! !


!classDefinition: #MarsRover category: 'MarsRover-Exercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRover methodsFor: 'error description' stamp: 'ja 5/15/2021 20:08:41'!
invalidCommandErrorDescription
	
	^ 'Invalid command.'! !


!MarsRover methodsFor: 'initialization' stamp: 'ja 5/15/2021 20:23:53'!
initializeInPosition: aPosition heading: aCardinalPoint 
	
	position _ aPosition.
	head _ MarsRoverHeading for: aCardinalPoint.! !


!MarsRover methodsFor: 'heading' stamp: 'ja 5/16/2021 19:09:10'!
turnLeft

	^ head _ head turnLeft! !

!MarsRover methodsFor: 'heading' stamp: 'ja 5/16/2021 19:09:01'!
turnRight

	^ head _ head turnRight! !


!MarsRover methodsFor: 'moving' stamp: 'ja 5/16/2021 19:08:32'!
moveBackward

	^ position _ position + (head moveBackwardFor: self)! !

!MarsRover methodsFor: 'moving' stamp: 'ja 5/15/2021 21:03:00'!
moveBackwardEast

	^ -1@0! !

!MarsRover methodsFor: 'moving' stamp: 'ja 5/15/2021 21:03:09'!
moveBackwardNorth

	^ 0@-1! !

!MarsRover methodsFor: 'moving' stamp: 'ja 5/15/2021 21:03:17'!
moveBackwardSouth

	^ 0@1! !

!MarsRover methodsFor: 'moving' stamp: 'ja 5/15/2021 21:02:46'!
moveBackwardWest

	^ 1@0! !

!MarsRover methodsFor: 'moving' stamp: 'ja 5/16/2021 19:07:47'!
moveForward

	^ position _ position + (head moveForwardFor: self)! !

!MarsRover methodsFor: 'moving' stamp: 'ja 5/15/2021 21:01:46'!
moveForwardEast

	^ 1@0
	! !

!MarsRover methodsFor: 'moving' stamp: 'ja 5/15/2021 21:02:05'!
moveForwardNorth

	^ 0@1
	! !

!MarsRover methodsFor: 'moving' stamp: 'ja 5/15/2021 21:02:16'!
moveForwardSouth

	^ 0@-1
	! !

!MarsRover methodsFor: 'moving' stamp: 'ja 5/15/2021 21:02:30'!
moveForwardWest

	^ -1@0! !


!MarsRover methodsFor: 'processing' stamp: 'ja 5/16/2021 20:00:22'!
process: aCommandsList
	
	aCommandsList do: [ :aCommand | self processACommand: aCommand ].
	
	
	
	

	! !

!MarsRover methodsFor: 'processing' stamp: 'ja 5/16/2021 19:09:10'!
processACommand: aCommand

	aCommand = $f ifTrue: [ ^ self moveForward ].
	aCommand = $b ifTrue: [ ^ self moveBackward ].
	aCommand = $r ifTrue: [ ^ self turnRight ].
	aCommand = $l ifTrue: [ ^ self turnLeft ].
	
	self error: self invalidCommandErrorDescription.
	

	! !


!MarsRover methodsFor: 'testing' stamp: 'ja 5/15/2021 20:38:30'!
isInPosition: aPoint heading: aCardinalPoint
	
	^ position = aPoint and:[ head isHeading = aCardinalPoint ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-Exercise'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'error descriptions' stamp: 'ja 5/15/2021 20:53:49'!
invalidCardinalPointErrorDescription
	
	^ 'Invalid cardinal point.'! !


!MarsRover class methodsFor: 'instance creation' stamp: 'ja 5/15/2021 20:22:42'!
inPosition: aPosition heading: aCardinalPoint 
	
	^ self new initializeInPosition: aPosition heading: aCardinalPoint! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-Exercise'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'ja 5/15/2021 20:31:37'!
turnLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'ja 5/15/2021 20:29:05'!
turnRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'ja 5/15/2021 21:04:55'!
moveBackwardFor: aMarsRover

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'ja 5/15/2021 21:00:32'!
moveForwardFor: aMarsRover

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'ja 5/15/2021 20:38:48'!
isHeading

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-Exercise'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'ja 5/15/2021 20:58:36'!
for: aCardinalPoint

	aCardinalPoint = #East ifTrue: [ ^ East new].
	aCardinalPoint = #North ifTrue: [ ^ North new].
	aCardinalPoint = #South ifTrue: [ ^ South new].
	aCardinalPoint = #West ifTrue: [ ^ West new].
	
	self error: MarsRover invalidCardinalPointErrorDescription.! !


!classDefinition: #East category: 'MarsRover-Exercise'!
MarsRoverHeading subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!East methodsFor: 'heading' stamp: 'ja 5/15/2021 20:31:22'!
turnLeft

	^ North new.! !

!East methodsFor: 'heading' stamp: 'ja 5/15/2021 20:29:42'!
turnRight

	^ South new.! !


!East methodsFor: 'moving' stamp: 'ja 5/15/2021 21:05:13'!
moveBackwardFor: aMarsRover

	^ aMarsRover moveBackwardEast ! !

!East methodsFor: 'moving' stamp: 'ja 5/15/2021 21:01:04'!
moveForwardFor: aMarsRover

	^ aMarsRover moveForwardEast.! !


!East methodsFor: 'testing' stamp: 'ja 5/15/2021 20:39:03'!
isHeading

	^ #East.! !


!classDefinition: #North category: 'MarsRover-Exercise'!
MarsRoverHeading subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!North methodsFor: 'heading' stamp: 'ja 5/15/2021 20:31:07'!
turnLeft

	^ West new.! !

!North methodsFor: 'heading' stamp: 'ja 5/15/2021 20:29:57'!
turnRight

	^ East new.! !


!North methodsFor: 'moving' stamp: 'ja 5/15/2021 21:05:30'!
moveBackwardFor: aMarsRover

	^ aMarsRover moveBackwardNorth ! !

!North methodsFor: 'moving' stamp: 'ja 5/15/2021 21:03:49'!
moveForwardFor: aMarsRover

	^ aMarsRover moveForwardNorth! !


!North methodsFor: 'testing' stamp: 'ja 5/15/2021 20:39:19'!
isHeading

	^ #North.! !


!classDefinition: #South category: 'MarsRover-Exercise'!
MarsRoverHeading subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!South methodsFor: 'heading' stamp: 'ja 5/15/2021 20:30:55'!
turnLeft

	^ East new.! !

!South methodsFor: 'heading' stamp: 'ja 5/15/2021 20:30:15'!
turnRight

	^ West new.! !


!South methodsFor: 'moving' stamp: 'ja 5/15/2021 21:05:38'!
moveBackwardFor: aMarsRover

	^ aMarsRover moveBackwardSouth ! !

!South methodsFor: 'moving' stamp: 'ja 5/15/2021 21:04:08'!
moveForwardFor: aMarsRover

	^ aMarsRover moveForwardSouth ! !


!South methodsFor: 'testing' stamp: 'ja 5/15/2021 20:39:28'!
isHeading

	^ #South.! !


!classDefinition: #West category: 'MarsRover-Exercise'!
MarsRoverHeading subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!West methodsFor: 'heading' stamp: 'ja 5/15/2021 20:30:42'!
turnLeft

	^ South new.! !

!West methodsFor: 'heading' stamp: 'ja 5/15/2021 20:30:27'!
turnRight

	^ North new.! !


!West methodsFor: 'moving' stamp: 'ja 5/15/2021 21:05:47'!
moveBackwardFor: aMarsRover

	^ aMarsRover moveBackwardWest ! !

!West methodsFor: 'moving' stamp: 'ja 5/15/2021 21:04:16'!
moveForwardFor: aMarsRover

	^ aMarsRover moveForwardWest ! !


!West methodsFor: 'testing' stamp: 'ja 5/15/2021 20:39:35'!
isHeading

	^ #West.! !
