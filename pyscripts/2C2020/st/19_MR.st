!classDefinition: #MarsRoverTest category: #MarsRover!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'universeSize aliveCells'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'testing' stamp: 'FG 10/24/2020 18:14:35'!
should: aBlockThatShouldFail raisingAnErrorAndAsserting: aVerificationBlock

	[aBlockThatShouldFail value. self fail.]
	on: Error
	do: aVerificationBlock.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FG 10/24/2020 17:28:57'!
test01MarsRoverMantainsPositionAndDirectionAfterLanding

	| marsRover |
	
	marsRover := MarsRover landingIn: 3@3  pointingTo:1@0.
	
	self assert: (marsRover position) equals: 3@3.
	self assert: (marsRover direction) equals: 1@0.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FG 10/24/2020 17:36:53'!
test02MarsRoverMoversForwardInADirection

	| marsRover |
	
	marsRover := MarsRover landingIn: 3@3  pointingTo:1@0.
	marsRover execute: 'f'.
	
	self assert: marsRover position equals: 4@3.
	self assert: marsRover direction equals: 1@0.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FG 10/24/2020 17:41:16'!
test03MarsRoverMovesBackwardsInADirection

	| marsRover |
	
	marsRover := MarsRover landingIn: 3@3  pointingTo:0@1.
	marsRover execute: 'b'.
	
	self assert: marsRover position equals: 3@2.
	self assert: marsRover direction equals: 0@1.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FG 10/24/2020 17:42:28'!
test04MarsRoverTurnsLeft

	| marsRover |
	
	marsRover := MarsRover landingIn: 3@3  pointingTo:0@1.
	marsRover execute: 'l'.
	
	self assert: marsRover position equals: 3@3.
	self assert: marsRover direction equals: -1@0.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FG 10/24/2020 17:43:01'!
test05MarsRoverTurnsRight

	| marsRover |
	
	marsRover := MarsRover landingIn: 3@3  pointingTo:1@0.
	marsRover execute: 'r'.
	
	self assert: marsRover position equals: 3@3.
	self assert: marsRover direction equals: 0@-1.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FG 10/24/2020 17:44:28'!
test06MarsRoverObeysMultipleCommands

	| marsRover |
	
	marsRover := MarsRover landingIn: 3@3  pointingTo:0@1.
	marsRover execute: 'frfflbl'.
	
	self assert: marsRover position equals: 5@3.
	self assert: marsRover direction equals: -1@0.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FG 10/24/2020 18:16:19'!
test07MarsRoverStopsWhenInvalidCommandFound

	| marsRover |
	
	marsRover := MarsRover landingIn: 3@3  pointingTo:0@1.
	
	self should: [marsRover execute: 'frff%lbl'] 
		raisingAnErrorAndAsserting: [:anError |
			self assert: anError messageText  = MarsRover invalidCommandFoundInCommandLine.
			self assert: marsRover position equals: 5@4.
			self assert: marsRover direction equals: 1@0.
		].! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FG 10/24/2020 18:17:05'!
test08MarsRoverDoesntReceiveNonCardinalPointAsDirection

	self should: [MarsRover landingIn: 3@3  pointingTo:0@2] 
	raisingAnErrorAndAsserting: [:anError | self assert: anError messageText  = MarsRover invalidDirectionDuringInitialization .].! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FG 10/24/2020 18:17:42'!
test09MarsRoverDoesntReceiveRationalsPointsAsDirection

	self should: [MarsRover landingIn: 3@3  pointingTo:0.5@0.5. ] 
		raisingAnErrorAndAsserting:  [:anError | self assert: anError messageText  = MarsRover invalidDirectionDuringInitialization.].! !

!MarsRoverTest methodsFor: 'testing' stamp: 'FG 10/24/2020 18:18:17'!
test10MarsRoverDoesntReceiveRationalsPointsAsPosition

	self should: 	[MarsRover landingIn: 3.2@0.5  pointingTo:1@0]
 		raisingAnErrorAndAsserting:  [:anError | self assert: anError messageText  = MarsRover invalidPositionDuringInitialization.]! !


!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'FG 10/24/2020 17:58:38'!
directionIsValid: aDirection
	((aDirection isIntegerPoint) and: [aDirection magnitude = 1]) ifFalse:[^ self error: MarsRover invalidDirectionDuringInitialization].
! !

!MarsRover methodsFor: 'initialization' stamp: 'FG 10/24/2020 17:59:10'!
initializeIn: aPosition pointingTo: aDirection 

	self positionIsValid: aPosition.
	self directionIsValid:  aDirection.
	position := aPosition. 
	direction := aDirection.! !

!MarsRover methodsFor: 'initialization' stamp: 'FG 10/24/2020 17:58:17'!
positionIsValid: aPosition

	(aPosition isIntegerPoint ) ifFalse: [^ self error: MarsRover invalidPositionDuringInitialization].
! !


!MarsRover methodsFor: 'accesing' stamp: 'FG 10/24/2020 18:04:22'!
direction
	^direction! !

!MarsRover methodsFor: 'accesing' stamp: 'FG 10/24/2020 14:38:27'!
position
	^position! !


!MarsRover methodsFor: 'actions' stamp: 'FG 10/24/2020 18:03:54'!
execute: aCommandLine

	aCommandLine do: [:aCommand |  
		('fblr' includes: aCommand) not ifTrue: [ ^ self error: MarsRover invalidCommandFoundInCommandLine ] .  
		aCommand = $f ifTrue:[position := position + direction]. 
		aCommand = $b ifTrue:[position := position - direction].
		aCommand = $l  ifTrue:[direction :=  (direction y = 0) ifTrue: [direction y @ direction x] ifFalse: [(direction y negated) @ direction x]].
		aCommand = $r ifTrue:[direction := (direction x = 0) ifTrue: [direction y @ direction x] ifFalse: [direction y @ (direction x negated)]].
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'FG 10/24/2020 16:06:14'!
invalidCommandFoundInCommandLine
	^ 'Invalid command found in Command line'.! !

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'FG 10/24/2020 17:17:18'!
invalidDirectionDuringInitialization
	^ ' Error - Invalid direction given for initialization'! !

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'FG 10/24/2020 17:17:27'!
invalidPositionDuringInitialization
	^ ' Error - Invalid position given for initialization'! !

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'FG 10/24/2020 17:25:39'!
landingIn: aPosition pointingTo: aDirection 
	^ self basicNew initializeIn: aPosition pointingTo: aDirection.! !
