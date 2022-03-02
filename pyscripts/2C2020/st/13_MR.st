!classDefinition: #MarsRoverTest category: 'MarsRover-Exercise'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AM 10/25/2020 20:46:13'!
test01InitializesPositionCorrectly

	| marsRover |
	
	marsRover := MarsRover facingNorthAtCoordinates: 1@1.
	
	self assert: marsRover position equals: 1@1. ! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AM 10/25/2020 20:46:55'!
test02InitializesDirectionCorrectly

	| marsRover |
	
	marsRover := MarsRover facingNorthAtCoordinates: 1@1.
	
	self assert: marsRover direction class equals: FacingNorth. ! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AM 10/25/2020 20:49:30'!
test03fCommandChangesPositionCorrectly

	| marsRover |
	
	marsRover := MarsRover facingNorthAtCoordinates: 1@1.
	
	marsRover recieveCommands: 'f'.
	
	self assert: marsRover position equals: 1@2. ! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AM 10/25/2020 20:50:11'!
test04bCommandChangesPositionCorrectly

	| marsRover |
	
	marsRover := MarsRover facingNorthAtCoordinates: 1@2.
	
	marsRover recieveCommands: 'b'.
	
	self assert: marsRover position equals: 1@1. ! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AM 10/25/2020 20:51:17'!
test05lCommandChangesDirectionCorrectly

	| marsRover |
	
	marsRover := MarsRover facingSouthAtCoordinates: 1@2.
	
	marsRover recieveCommands: 'l'.
	
	self assert: marsRover direction class equals: FacingEast. ! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AM 10/25/2020 20:51:41'!
test06rCommandChangesDirectionCorrectly

	| marsRover |
	
	marsRover := MarsRover facingSouthAtCoordinates: 1@2.
	
	marsRover recieveCommands: 'r'.
	
	self assert: marsRover direction class equals: FacingWest. ! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AM 10/25/2020 20:52:14'!
test07DirectionChangesDoNotChangePosition

	| marsRover |
	
	marsRover := MarsRover facingNorthAtCoordinates: 1@2.
	
	marsRover recieveCommands: 'llr'.
	
	self assert: marsRover position equals: 1@2. ! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AM 10/25/2020 20:52:44'!
test08PositionChangesDoNotChangeDirection

	| marsRover |
	
	marsRover := MarsRover facingNorthAtCoordinates: 1@1.
	
	marsRover recieveCommands: 'fbb'.
	
	self assert: marsRover direction class equals: FacingNorth. ! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AM 10/25/2020 20:54:02'!
test09PositionChangesCorrectlyAfterDirectionChange

	| marsRover |
	
	marsRover := MarsRover facingNorthAtCoordinates: 0@0.
	
	marsRover recieveCommands: 'ffrf'.
	
	self assert: marsRover direction class equals: FacingEast.
	self assert: marsRover position equals: 1@2.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AM 10/25/2020 20:54:36'!
test10InvalidCommandsSignalError

	| marsRover |
	
	marsRover := MarsRover facingNorthAtCoordinates: 0@0.
	
	self 
		should: [marsRover recieveCommands: 'a']
		raise: Error
		withMessageText: MarsRover invalidCommandErrorDescription.
		! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AM 10/25/2020 20:55:17'!
test11CommandsAfterInvalidCommandAreNotExecuted

	| marsRover |
	
	marsRover := MarsRover facingNorthAtCoordinates: 0@0.
	
	self 
		should: [marsRover recieveCommands: 'fflafl']
		raise: Error
		withMessageText: MarsRover invalidCommandErrorDescription.
		
	self assert: 0@2 equals: marsRover position.
	self assert: marsRover direction class equals: FacingWest.
		! !


!classDefinition: #MarsRover category: 'MarsRover-Exercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRover methodsFor: 'initialization' stamp: 'AM 10/24/2020 16:18:46'!
initializeAtCoordinates: aCoordinate facing: aDirection
	
	position := aCoordinate.
	direction := aDirection.! !


!MarsRover methodsFor: 'accessing' stamp: 'AM 10/24/2020 16:58:50'!
direction
	
	^direction! !

!MarsRover methodsFor: 'accessing' stamp: 'AM 10/24/2020 15:22:02'!
position
	
	^position! !


!MarsRover methodsFor: 'actions' stamp: 'AM 10/24/2020 17:54:37'!
recieveCommands: aCommandsString
	
	aCommandsString do: [:command | self assertValidCommand: command. 
								direction perform: (command asSymbol)].! !


!MarsRover methodsFor: 'actions private' stamp: 'AM 10/25/2020 20:24:17'!
turnEast
	
	direction := FacingEast for: self.! !

!MarsRover methodsFor: 'actions private' stamp: 'AM 10/25/2020 20:24:33'!
turnNorth
	
	direction := FacingNorth for: self.! !

!MarsRover methodsFor: 'actions private' stamp: 'AM 10/25/2020 20:24:48'!
turnSouth
	
	direction := FacingSouth for: self.! !

!MarsRover methodsFor: 'actions private' stamp: 'AM 10/25/2020 20:24:57'!
turnWest
	
	direction := FacingWest for: self.! !

!MarsRover methodsFor: 'actions private' stamp: 'AM 10/24/2020 17:07:53'!
xCoordinateMinusOne
	
	position := position - (1@0).! !

!MarsRover methodsFor: 'actions private' stamp: 'AM 10/24/2020 17:07:44'!
xCoordinatePlusOne
	
	position := position + (1@0).! !

!MarsRover methodsFor: 'actions private' stamp: 'AM 10/24/2020 16:53:51'!
yCoordinateMinusOne
	
	position := position - (0@1).! !

!MarsRover methodsFor: 'actions private' stamp: 'AM 10/24/2020 16:16:20'!
yCoordinatePlusOne
	
	position := position + (0@1).! !


!MarsRover methodsFor: 'exeptions' stamp: 'AM 10/24/2020 17:44:35'!
signalInvalidCommand

	^self error: self class invalidCommandErrorDescription.! !


!MarsRover methodsFor: 'testing' stamp: 'AM 10/25/2020 20:27:06'!
assertValidCommand: aCommandChar

	| validCommands |
	
	validCommands := OrderedCollection with: $f with: $b with: $l with: $r.
	
	validCommands detect: [:validCommand | (validCommand = aCommandChar)] ifNone: [^self signalInvalidCommand].
	
		! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-Exercise'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'AM 10/25/2020 20:24:17'!
facingEastAtCoordinates: aCoordinate
	
	| aMarsRover |
	
	aMarsRover := MarsRover new.
	
	aMarsRover initializeAtCoordinates: aCoordinate facing: (FacingEast for: aMarsRover). 
	
	^aMarsRover.! !

!MarsRover class methodsFor: 'instance creation' stamp: 'AM 10/25/2020 20:24:33'!
facingNorthAtCoordinates: aCoordinate
	
	| aMarsRover |
	
	aMarsRover := MarsRover new.
	
	aMarsRover initializeAtCoordinates: aCoordinate facing: (FacingNorth for: aMarsRover). 
	
	^aMarsRover.! !

!MarsRover class methodsFor: 'instance creation' stamp: 'AM 10/25/2020 20:24:48'!
facingSouthAtCoordinates: aCoordinate
	
	| aMarsRover |
	
	aMarsRover := MarsRover new.
	
	aMarsRover initializeAtCoordinates: aCoordinate facing: (FacingSouth for: aMarsRover). 
	
	^aMarsRover.! !

!MarsRover class methodsFor: 'instance creation' stamp: 'AM 10/25/2020 20:24:57'!
facingWestAtCoordinates: aCoordinate
	
	| aMarsRover |
	
	aMarsRover := MarsRover new.
	
	aMarsRover initializeAtCoordinates: aCoordinate facing: (FacingWest for: aMarsRover). 
	
	^aMarsRover.! !


!MarsRover class methodsFor: 'error messages' stamp: 'AM 10/24/2020 17:24:59'!
invalidCommandErrorDescription
	
	^'Commands string contains an invalid command'! !


!classDefinition: #MarsRoverDirection category: 'MarsRover-Exercise'!
Object subclass: #MarsRoverDirection
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverDirection methodsFor: 'initialization' stamp: 'AM 10/24/2020 16:07:12'!
initializeFor: aMarsRover

	marsRover := aMarsRover.! !


!MarsRoverDirection methodsFor: 'position actions' stamp: 'AM 10/25/2020 20:42:41'!
b

	self subclassResponsibility.! !

!MarsRoverDirection methodsFor: 'position actions' stamp: 'AM 10/25/2020 20:42:37'!
f

	self subclassResponsibility.! !


!MarsRoverDirection methodsFor: 'direction actions' stamp: 'AM 10/25/2020 20:42:05'!
l

	self subclassResponsibility.! !

!MarsRoverDirection methodsFor: 'direction actions' stamp: 'AM 10/25/2020 20:42:12'!
r

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverDirection class' category: 'MarsRover-Exercise'!
MarsRoverDirection class
	instanceVariableNames: ''!

!MarsRoverDirection class methodsFor: 'instance creation' stamp: 'AM 10/24/2020 16:05:51'!
for: aMarsRover

	^self new initializeFor: aMarsRover.! !


!classDefinition: #FacingEast category: 'MarsRover-Exercise'!
MarsRoverDirection subclass: #FacingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!FacingEast methodsFor: 'position actions' stamp: 'AM 10/24/2020 17:07:27'!
b
	
	marsRover xCoordinateMinusOne.! !

!FacingEast methodsFor: 'position actions' stamp: 'AM 10/24/2020 17:07:03'!
f

	marsRover xCoordinatePlusOne.! !


!FacingEast methodsFor: 'direction actions' stamp: 'AM 10/24/2020 17:11:03'!
l

	marsRover turnNorth.! !

!FacingEast methodsFor: 'direction actions' stamp: 'AM 10/24/2020 17:11:14'!
r

	marsRover turnSouth.! !


!classDefinition: #FacingNorth category: 'MarsRover-Exercise'!
MarsRoverDirection subclass: #FacingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!FacingNorth methodsFor: 'direction actions' stamp: 'AM 10/24/2020 17:11:33'!
l

	marsRover turnWest.! !

!FacingNorth methodsFor: 'direction actions' stamp: 'AM 10/24/2020 17:11:44'!
r

	marsRover turnEast.! !


!FacingNorth methodsFor: 'position actions' stamp: 'AM 10/24/2020 16:53:39'!
b

	marsRover yCoordinateMinusOne.! !

!FacingNorth methodsFor: 'position actions' stamp: 'AM 10/24/2020 16:15:22'!
f 

	marsRover yCoordinatePlusOne.! !


!classDefinition: #FacingSouth category: 'MarsRover-Exercise'!
MarsRoverDirection subclass: #FacingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!FacingSouth methodsFor: 'position actions' stamp: 'AM 10/24/2020 16:54:30'!
b

	marsRover yCoordinatePlusOne.! !

!FacingSouth methodsFor: 'position actions' stamp: 'AM 10/24/2020 16:54:20'!
f

	marsRover yCoordinateMinusOne.! !


!FacingSouth methodsFor: 'direction actions' stamp: 'AM 10/24/2020 17:03:23'!
l
	marsRover turnEast.! !

!FacingSouth methodsFor: 'direction actions' stamp: 'AM 10/24/2020 17:09:55'!
r
	
	marsRover turnWest.! !


!classDefinition: #FacingWest category: 'MarsRover-Exercise'!
MarsRoverDirection subclass: #FacingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!FacingWest methodsFor: 'position actions' stamp: 'AM 10/25/2020 20:48:31'!
b

	marsRover xCoordinatePlusOne.! !

!FacingWest methodsFor: 'position actions' stamp: 'AM 10/24/2020 17:08:10'!
f

	marsRover xCoordinateMinusOne.! !


!FacingWest methodsFor: 'direction actions' stamp: 'AM 10/25/2020 20:37:36'!
l

	marsRover turnSouth.! !

!FacingWest methodsFor: 'direction actions' stamp: 'AM 10/24/2020 17:12:00'!
r

	marsRover turnNorth.! !
