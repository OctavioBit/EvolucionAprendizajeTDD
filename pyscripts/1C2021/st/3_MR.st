!classDefinition: #MarsRoverTest category: 'Mars Rover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!MarsRoverTest methodsFor: 'testing' stamp: 'FG 5/16/2021 18:45:16'!
assert: aMarsRover endsAt: aPosition facing: aDirection whileDoing: aCommandLine

	aMarsRover do: aCommandLine.
	
	self assert: (aMarsRover isAt: aPosition facing: aDirection).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FG 5/16/2021 18:46:40'!
test01StaysInTheSamePositionFacingTheSameDirectionIfItTriesToDoNothing
	
	self assert: (MarsRover at: 1@1 facing: North) endsAt: 1@1  facing: North whileDoing: ''. 
	
	 ! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FG 5/16/2021 18:47:06'!
test02AdvancesOnePositionToTheNorthWhenReceivingAFowardCommandWhileFacingNorth
	
	self assert: (MarsRover at: 1@1 facing: North) endsAt: 1@2  facing: North whileDoing: 'f'. ! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FG 5/16/2021 18:47:24'!
test03StartsAtAnotherPositionAndAdvancesOnePositionToTheNorthWhenReceivingAFowardCommandWhileFacingNorth 
	
	self assert: (MarsRover at: 1@2 facing: North) endsAt: 1@3  facing: North whileDoing: 'f'. ! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FG 5/16/2021 18:47:48'!
test04AdvancesOnePositionToTheWestWhenReceivingAForwardCommandWhileFacingWest

	self assert: (MarsRover at: 1@1 facing: West) endsAt: 0@1  facing: West whileDoing: 'f'. ! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FG 5/16/2021 18:48:13'!
test05AdvancesOnePositionToTheEastWhenReceivingAForwardCommandWhileFacingEast
	
	self assert: (MarsRover at: 1@1 facing: East) endsAt: 2@1  facing: East whileDoing: 'f'. ! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FG 5/16/2021 18:48:59'!
test06AdvancesOnePositionToTheSouthWhenReceivingAForwardCommandWhileFacingSouth

	self assert: (MarsRover at: 1@1 facing: South) endsAt: 1@0  facing: South whileDoing: 'f'. ! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FG 5/16/2021 18:49:18'!
test07BacksOnePositionWhenReceivingABackwardCommand

	self assert: (MarsRover at: 1@1 facing: North) endsAt: 1@0  facing: North whileDoing: 'b'. ! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FG 5/16/2021 18:49:43'!
test08TurnsToTheWestWhenReceivingATurnLeftCommandWhileFacingNorth

	self assert: (MarsRover at: 1@1 facing: North) endsAt: 1@1  facing: West whileDoing: 'l'.  ! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FG 5/16/2021 18:50:06'!
test09TurnsToTheSouthWhenReceivingATurnLeftCommandWhileFacingWest

	self assert: (MarsRover at: 1@1 facing: West) endsAt: 1@1  facing: South whileDoing: 'l'. ! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FG 5/16/2021 18:50:30'!
test10TurnsToTheEastWhenReceivingATurnLeftCommandWhileFacingSouth

	self assert: (MarsRover at: 1@1 facing: South) endsAt: 1@1  facing: East whileDoing: 'l'. ! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FG 5/16/2021 18:50:50'!
test11TurnsToTheNorthWhenReceivingATurnLeftCommandWhileFacingEast

	self assert: (MarsRover at: 1@1 facing: East) endsAt: 1@1  facing: North whileDoing: 'l'. ! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FG 5/16/2021 18:51:09'!
test12TurnsToTheEastWhenReceivingATurnRightCommandWhileFacingNorth

	self assert: (MarsRover at: 1@1 facing: North) endsAt: 1@1  facing: East whileDoing: 'r'. ! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FG 5/16/2021 18:52:13'!
test13TurnsToTheSouthWhenReceivingATurnRightCommandWhileFacingEast

	self assert: (MarsRover at: 1@1 facing: East) endsAt: 1@1  facing: South whileDoing: 'r'. ! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FG 5/16/2021 18:52:52'!
test14TurnsToTheWestWhenReceivingATurnRightCommandWhileFacingSouth

	self assert: (MarsRover at: 1@1 facing: South) endsAt: 1@1  facing: West whileDoing: 'r'. ! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FG 5/16/2021 18:53:56'!
test15TurnsToTheNorthWhenReceivingATurnRightCommandWhileFacingWest

	self assert: (MarsRover at: 1@1 facing: West) endsAt: 1@1  facing: North whileDoing: 'r'. ! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FG 5/16/2021 18:54:48'!
test16CanFollowCorrectlyAMultipleCommandLineWithoutInvalidCommands

	self assert: (MarsRover at: 1@1 facing: North) endsAt: 0@4  facing: North whileDoing: 'fflbrrbblf'. ! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FG 5/16/2021 18:55:24'!
test17IfAnInvalidCommandIsFoundInLineStopsExecutionAndRetrievesAnError

	| marsRover |
	
	marsRover :=  MarsRover at: 1@1 facing: North.
	
	self should: [marsRover do: 'f$f']
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: MarsRover invalidCommandErrorSignal.
			self assert: (marsRover isAt: 1@2 facing: North) 
		].! !


!classDefinition: #CardinalPoint category: 'Mars Rover'!
Object subclass: #CardinalPoint
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!CardinalPoint methodsFor: 'accessing' stamp: 'FG 5/16/2021 17:21:06'!
left
	self subclassResponsibility .
	! !

!CardinalPoint methodsFor: 'accessing' stamp: 'FG 5/16/2021 17:21:02'!
right
	self subclassResponsibility .
	! !

!CardinalPoint methodsFor: 'accessing' stamp: 'FG 5/16/2021 17:20:58'!
value
	self subclassResponsibility.! !


!classDefinition: #East category: 'Mars Rover'!
CardinalPoint subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!East methodsFor: 'accessing' stamp: 'FG 5/16/2021 17:38:42'!
left
	^ North new.! !

!East methodsFor: 'accessing' stamp: 'FG 5/16/2021 17:39:02'!
right
	^ South new.! !

!East methodsFor: 'accessing' stamp: 'FG 5/16/2021 17:25:32'!
value
	^ 1@0.! !


!classDefinition: #North category: 'Mars Rover'!
CardinalPoint subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!North methodsFor: 'accessing' stamp: 'FG 5/16/2021 17:38:53'!
left
	^ West new.
	! !

!North methodsFor: 'accessing' stamp: 'FG 5/16/2021 17:39:10'!
right
	^ East new.
	! !

!North methodsFor: 'accessing' stamp: 'FG 5/16/2021 17:23:55'!
value
	^ 0@1.
	! !


!classDefinition: #South category: 'Mars Rover'!
CardinalPoint subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!South methodsFor: 'accessing' stamp: 'FG 5/16/2021 17:39:10'!
left
	^ East new.! !

!South methodsFor: 'accessing' stamp: 'FG 5/16/2021 17:38:54'!
right
	^ West new.! !

!South methodsFor: 'accessing' stamp: 'FG 5/16/2021 17:26:11'!
value
	^ 0@-1.! !


!classDefinition: #West category: 'Mars Rover'!
CardinalPoint subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!West methodsFor: 'accessing' stamp: 'FG 5/16/2021 17:39:02'!
left
	^ South new.! !

!West methodsFor: 'accessing' stamp: 'FG 5/16/2021 17:38:43'!
right
	^ North new.! !

!West methodsFor: 'accessing' stamp: 'FG 5/16/2021 17:27:18'!
value
	^ -1@0.! !


!classDefinition: #MarsRover category: 'Mars Rover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction knownCommands'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!MarsRover methodsFor: 'initialization' stamp: 'FG 5/16/2021 18:02:02'!
initializeAt: aPosition facing: aDirection

	position := aPosition.
	direction := aDirection.
	knownCommands := OrderedCollection with: $f with: $b with: $l with: $r.! !


!MarsRover methodsFor: 'do' stamp: 'FG 5/16/2021 18:06:50'!
do: aCommandLine

	aCommandLine do: [:aCommand |
		(knownCommands includes: aCommand) not ifTrue: [self error: self class invalidCommandErrorSignal].
		self doOneCommand: aCommand
		].! !

!MarsRover methodsFor: 'do' stamp: 'FG 5/16/2021 17:53:16'!
doOneCommand: aCommand

	(aCommand = $f) ifTrue:[ position := position + direction value].
	(aCommand = $b) ifTrue:[ position := position - direction value].
	(aCommand = $l) ifTrue:[ direction := direction left 		].
	(aCommand = $r) ifTrue:[ direction := direction right ].
	! !


!MarsRover methodsFor: 'accessing' stamp: 'FG 5/16/2021 17:35:25'!
isAt: aPosition facing: aDirection 

	^ (position = aPosition) and: [ direction class =  aDirection ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Mars Rover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'FG 5/16/2021 17:34:51'!
at: aPosition facing: aDirection

	^ self new initializeAt: aPosition facing: aDirection new. 	! !


!MarsRover class methodsFor: 'error handling' stamp: 'FG 5/16/2021 18:04:15'!
invalidCommandErrorSignal
	^ 'Error - Invalid Command'! !
