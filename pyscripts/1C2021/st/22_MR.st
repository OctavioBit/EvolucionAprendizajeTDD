!classDefinition: #MarsRoverTests category: 'MarsRover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: 'north south east west'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTests methodsFor: 'assertions' stamp: 'CD 5/16/2021 23:20:03'!
assertThat: marsRover isAtPosition: position andAtOrientation: orientation
	
	self assert: (marsRover position) equals: position.
	self assert: (marsRover orientation orientationSymbol) equals: orientation.
	! !


!MarsRoverTests methodsFor: 'tests' stamp: 'CD 5/16/2021 23:03:32'!
test01MarsRoverStartsInAnInitialPosition

	| marsRover |
	marsRover := MarsRover withPosition: 0@0 withOrientation: NorthOrientation new.
	 
	marsRover execute: ''.
	
	self assertThat: marsRover  isAtPosition: 0@0 andAtOrientation: north. 
		! !

!MarsRoverTests methodsFor: 'tests' stamp: 'CD 5/16/2021 23:07:06'!
test02MarsRoverMovesUpWhenExecutingForwardAndHeadingNorth

	| marsRover |
	marsRover := MarsRover withPosition: 0@0 withOrientation: NorthOrientation new.
	
	marsRover execute: 'f'.
	
	self assertThat: marsRover isAtPosition: 0@1 andAtOrientation: north.
	
	

		! !

!MarsRoverTests methodsFor: 'tests' stamp: 'CD 5/16/2021 23:08:07'!
test03MarsRoverMovesDownWhenExecutingForwardAndHeadingSouth

	| marsRover |
	marsRover := MarsRover withPosition: 0@0 withOrientation: SouthOrientation new.
	
	marsRover execute: 'f'.
	
	self assertThat: marsRover isAtPosition: 0@-1 andAtOrientation: south.

	
	

		! !

!MarsRoverTests methodsFor: 'tests' stamp: 'CD 5/16/2021 23:08:30'!
test04MarsRoverMovesLeftWhenExecutingForwardAndHeadingWest

	| marsRover |
	marsRover := MarsRover withPosition: 0@0 withOrientation: WestOrientation new.
	
	marsRover execute: 'f'.
	
	self assertThat: marsRover isAtPosition: -1@0 andAtOrientation: west.


		! !

!MarsRoverTests methodsFor: 'tests' stamp: 'CD 5/16/2021 23:08:49'!
test05MarsRoverMovesRightWhenExecutingForwardAndHeadingEast

	| marsRover |
	marsRover := MarsRover withPosition: 0@0 withOrientation: EastOrientation new.
	
	marsRover execute: 'f'.
	
	self assertThat: marsRover isAtPosition: 1@0 andAtOrientation: east.	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'CD 5/16/2021 23:09:05'!
test06MarsRoverMovesDownWhenExecutingBackwardAndHeadingNorth

	| marsRover |
	marsRover := MarsRover withPosition: 0@0 withOrientation: NorthOrientation new.
	
	marsRover execute: 'b'.
	
	self assertThat: marsRover isAtPosition: 0@-1 andAtOrientation: north.

	
	

		! !

!MarsRoverTests methodsFor: 'tests' stamp: 'CD 5/16/2021 23:09:15'!
test07MarsRoverMovesUpWhenExecutingBackwardAndHeadingSouth

	| marsRover |
	marsRover := MarsRover withPosition: 0@0 withOrientation: SouthOrientation new.
	
	marsRover execute: 'b'.
	
	self assertThat: marsRover isAtPosition: 0@1 andAtOrientation: south.

	
	

		! !

!MarsRoverTests methodsFor: 'tests' stamp: 'CD 5/16/2021 23:09:36'!
test08MarsRoverMovesRightWhenExecutingBackwardAndHeadingWest

	| marsRover |
	marsRover := MarsRover withPosition: 0@0 withOrientation: WestOrientation new.
	
	marsRover execute: 'b'.
	
	self assertThat: marsRover isAtPosition: 1@0 andAtOrientation: west.
	
	
	

		! !

!MarsRoverTests methodsFor: 'tests' stamp: 'CD 5/16/2021 23:10:03'!
test09MarsRoverMovesLeftWhenExecutingBackwardAndHeadingEast

	| marsRover |
	marsRover := MarsRover withPosition: 0@0 withOrientation: EastOrientation new.
	
	marsRover execute: 'b'.
	
	self assertThat: marsRover isAtPosition: -1@0 andAtOrientation: east
	
	
	

		! !

!MarsRoverTests methodsFor: 'tests' stamp: 'CD 5/16/2021 23:10:20'!
test10MarsRoverChangesFromNorthToEastWhenRotatingRight

	| marsRover oldPosition |
	marsRover := MarsRover withPosition: 0@0 withOrientation: NorthOrientation new.
	oldPosition := marsRover position.
	
	marsRover execute: 'r'.
	
	self assertThat: marsRover isAtPosition: oldPosition andAtOrientation: east.
	
	
	

		! !

!MarsRoverTests methodsFor: 'tests' stamp: 'CD 5/16/2021 23:10:42'!
test11MarsRoverChangesFromSouthToWestWhenRotatingRight

	| marsRover oldPosition |
	marsRover := MarsRover withPosition: 0@0 withOrientation: SouthOrientation new.
	oldPosition := marsRover position.
	
	marsRover execute: 'r'.
	
	self assertThat: marsRover isAtPosition: oldPosition andAtOrientation: west.

	
	

		! !

!MarsRoverTests methodsFor: 'tests' stamp: 'CD 5/16/2021 23:10:59'!
test12MarsRoverChangesFromEastToSouthWhenRotatingRight

	| marsRover oldPosition |
	marsRover := MarsRover withPosition: 0@0 withOrientation: EastOrientation new.
	oldPosition := marsRover position.
	
	marsRover execute: 'r'.
	
	self assertThat: marsRover isAtPosition: oldPosition andAtOrientation: south.

	
	

		! !

!MarsRoverTests methodsFor: 'tests' stamp: 'CD 5/16/2021 23:11:16'!
test13MarsRoverChangesFromWestToNorthWhenRotatingRight

	| marsRover oldPosition |
	marsRover := MarsRover withPosition: 0@0 withOrientation: WestOrientation new.
	oldPosition := marsRover position.
	
	marsRover execute: 'r'.
	
	self assertThat: marsRover isAtPosition: oldPosition andAtOrientation: north.
	
	

		! !

!MarsRoverTests methodsFor: 'tests' stamp: 'CD 5/16/2021 23:11:34'!
test14MarsRoverChangesFromNorthToWestWhenRotatingLeft

	| marsRover oldPosition |
	marsRover := MarsRover withPosition: 0@0 withOrientation: NorthOrientation new.
	oldPosition := marsRover position.
	
	marsRover execute: 'l'.
	
	self assertThat: marsRover isAtPosition: oldPosition andAtOrientation: west.
	
	
	

		! !

!MarsRoverTests methodsFor: 'tests' stamp: 'CD 5/16/2021 23:11:56'!
test15MarsRoverChangesFromSouthToWestWhenRotatingLeft

	| marsRover oldPosition |
	marsRover := MarsRover withPosition: 0@0 withOrientation: SouthOrientation new.
	oldPosition := marsRover position.
	
	marsRover execute: 'l'.
	
	self assertThat: marsRover isAtPosition: oldPosition andAtOrientation: east.
	
	

		! !

!MarsRoverTests methodsFor: 'tests' stamp: 'CD 5/16/2021 23:12:17'!
test16MarsRoverChangesFromEastToNorthWhenRotatingLeft

	| marsRover oldPosition |
	marsRover := MarsRover withPosition: 0@0 withOrientation: EastOrientation new.
	oldPosition := marsRover position.
	
	marsRover execute: 'l'.
	
	self assertThat: marsRover isAtPosition: oldPosition andAtOrientation: north.
	
	

		! !

!MarsRoverTests methodsFor: 'tests' stamp: 'CD 5/16/2021 23:12:31'!
test17MarsRoverChangesFromWestToSouthWhenRotatingLeft

	| marsRover oldPosition |
	marsRover := MarsRover withPosition: 0@0 withOrientation: WestOrientation new.
	oldPosition := marsRover position.
	
	marsRover execute: 'l'.
	
	self assertThat: marsRover isAtPosition: oldPosition andAtOrientation: south.
	
	

		! !

!MarsRoverTests methodsFor: 'tests' stamp: 'CD 5/16/2021 23:15:19'!
test18MarsRoverDoesNotExecuteInvalidCommand

	| marsRover oldPosition |
	marsRover := MarsRover withPosition: 0@0 withOrientation: NorthOrientation new.
	oldPosition := 0 @ 0.
	
	self 
		should: [ marsRover execute: 'x'. ] 
		raise: Error 
		withMessageText: MarsRover errorMessageForInvalidCommand.
	self assertThat: marsRover isAtPosition: oldPosition andAtOrientation: north.	
	
	

		! !

!MarsRoverTests methodsFor: 'tests' stamp: 'CD 5/16/2021 23:12:53'!
test19MarsRoverCanExecuteASequenceOfValidCommands

	| marsRover|
	marsRover := MarsRover withPosition: 0@0 withOrientation: NorthOrientation new.

	marsRover execute: 'rfflffbrr'.
	
	self assertThat: marsRover isAtPosition: 2@1 andAtOrientation: south.
	
	

		! !

!MarsRoverTests methodsFor: 'tests' stamp: 'CD 5/16/2021 23:16:00'!
test20IfInvalidCommandInSequenceItExecutesUntilLastValidCommand

	| marsRover|
	marsRover := MarsRover withPosition: 0@0 withOrientation: NorthOrientation new.
	
	self 
		should: [ marsRover execute: 'rfflffxbrr'. ] 
		raise: Error 
		withMessageText: MarsRover errorMessageForInvalidCommand.
	self assertThat: marsRover isAtPosition: 2@2 andAtOrientation: north.	
	
	

		! !


!MarsRoverTests methodsFor: 'setup' stamp: 'CD 5/16/2021 23:06:45'!
setUp

	north := #North.
	south := #South.
	east := #East.
	west := #West.		! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position orientation commandSymbolTranslator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initializers' stamp: 'CD 5/16/2021 22:40:23'!
initializeWithPosition: aCoordinate withOrientation: aDirection
	
	orientation := aDirection.
	position := aCoordinate.
	commandSymbolTranslator := Dictionary new.
	commandSymbolTranslator add: (#f -> #moveForward).
	commandSymbolTranslator add: (#b-> #moveBackward).
	commandSymbolTranslator add: (#l-> #rotateLeft).
	commandSymbolTranslator add: (#r-> #rotateRight). ! !


!MarsRover methodsFor: 'private' stamp: 'CD 5/16/2021 22:21:14'!
moveBackward

	position := self orientation updateBackward: position.! !

!MarsRover methodsFor: 'private' stamp: 'CD 5/16/2021 22:21:03'!
moveForward

	position := self orientation updateForward: position.! !

!MarsRover methodsFor: 'private' stamp: 'CD 5/16/2021 22:21:33'!
rotateLeft

	orientation := self orientation orientationToLeft. ! !

!MarsRover methodsFor: 'private' stamp: 'CD 5/16/2021 22:21:46'!
rotateRight

	orientation := self orientation orientationToRight. ! !

!MarsRover methodsFor: 'private' stamp: 'CD 5/16/2021 22:40:01'!
translateSymbolToCommand: command
	^ commandSymbolTranslator at: (command asSymbol) ifAbsent: [self error: MarsRover errorMessageForInvalidCommand].
	! !


!MarsRover methodsFor: 'public' stamp: 'CD 5/16/2021 22:50:43'!
execute: aSequenceOfCommands
	aSequenceOfCommands do: [:element |  
		self perform: (self translateSymbolToCommand: element) ].
	! !

!MarsRover methodsFor: 'public' stamp: 'CD 5/16/2021 22:51:17'!
orientation

	^orientation.! !

!MarsRover methodsFor: 'public' stamp: 'CD 5/16/2021 22:51:08'!
position

	^position.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'initializers' stamp: 'CD 5/16/2021 19:55:07'!
withPosition: aCoordinate withOrientation: aDirection
	
	^ self new initializeWithPosition: aCoordinate withOrientation: aDirection.! !


!MarsRover class methodsFor: 'as yet unclassified' stamp: 'CD 5/16/2021 22:02:38'!
errorMessageForInvalidCommand
	
	^ 'Invalid command'.! !


!classDefinition: #Orientation category: 'MarsRover'!
Object subclass: #Orientation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Orientation methodsFor: 'as yet unclassified' stamp: 'CD 5/16/2021 20:06:07'!
orientationSymbol

	^ self subclassResponsibility.! !

!Orientation methodsFor: 'as yet unclassified' stamp: 'CD 5/16/2021 21:12:01'!
orientationToLeft

	^ self subclassResponsibility.! !

!Orientation methodsFor: 'as yet unclassified' stamp: 'CD 5/16/2021 21:09:50'!
orientationToRight

	^ self subclassResponsibility.! !

!Orientation methodsFor: 'as yet unclassified' stamp: 'CD 5/16/2021 19:42:10'!
updateBackward: position

	^ self subclassResponsibility.! !

!Orientation methodsFor: 'as yet unclassified' stamp: 'CD 5/16/2021 19:41:43'!
updateForward: position

	^ self subclassResponsibility.! !


!classDefinition: #EastOrientation category: 'MarsRover'!
Orientation subclass: #EastOrientation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!EastOrientation methodsFor: 'as yet unclassified' stamp: 'CD 5/16/2021 20:06:27'!
orientationSymbol

	^ #East.! !

!EastOrientation methodsFor: 'as yet unclassified' stamp: 'CD 5/16/2021 21:13:47'!
orientationToLeft

	^ NorthOrientation new.! !

!EastOrientation methodsFor: 'as yet unclassified' stamp: 'CD 5/16/2021 21:10:39'!
orientationToRight

	^ SouthOrientation new.! !

!EastOrientation methodsFor: 'as yet unclassified' stamp: 'CD 5/16/2021 19:47:28'!
updateBackward: position

	^ position + (-1 @ 0).! !

!EastOrientation methodsFor: 'as yet unclassified' stamp: 'CD 5/16/2021 19:48:21'!
updateForward: position

	^ position + (1 @ 0).! !


!classDefinition: #NorthOrientation category: 'MarsRover'!
Orientation subclass: #NorthOrientation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!NorthOrientation methodsFor: 'as yet unclassified' stamp: 'CD 5/16/2021 20:06:37'!
orientationSymbol

	^ #North.! !

!NorthOrientation methodsFor: 'as yet unclassified' stamp: 'CD 5/16/2021 21:14:07'!
orientationToLeft

	^ WestOrientation new.! !

!NorthOrientation methodsFor: 'as yet unclassified' stamp: 'CD 5/16/2021 21:10:58'!
orientationToRight

	^ EastOrientation new.! !

!NorthOrientation methodsFor: 'as yet unclassified' stamp: 'CD 5/16/2021 19:48:39'!
updateBackward: position

	^ position + (0 @ -1).! !

!NorthOrientation methodsFor: 'as yet unclassified' stamp: 'CD 5/16/2021 19:45:07'!
updateForward: position

	^ position + (0 @ 1).! !


!classDefinition: #SouthOrientation category: 'MarsRover'!
Orientation subclass: #SouthOrientation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!SouthOrientation methodsFor: 'as yet unclassified' stamp: 'CD 5/16/2021 20:06:49'!
orientationSymbol

	^ #South.! !

!SouthOrientation methodsFor: 'as yet unclassified' stamp: 'CD 5/16/2021 21:14:38'!
orientationToLeft

	^ EastOrientation new.! !

!SouthOrientation methodsFor: 'as yet unclassified' stamp: 'CD 5/16/2021 21:11:14'!
orientationToRight

	^ WestOrientation new.! !

!SouthOrientation methodsFor: 'as yet unclassified' stamp: 'CD 5/16/2021 19:49:00'!
updateBackward: position

	^ position + (0 @ 1).! !

!SouthOrientation methodsFor: 'as yet unclassified' stamp: 'CD 5/16/2021 19:45:37'!
updateForward: position

	^ position + (0 @ -1).! !


!classDefinition: #WestOrientation category: 'MarsRover'!
Orientation subclass: #WestOrientation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!WestOrientation methodsFor: 'as yet unclassified' stamp: 'CD 5/16/2021 20:07:03'!
orientationSymbol

	^ #West.! !

!WestOrientation methodsFor: 'as yet unclassified' stamp: 'CD 5/16/2021 21:14:47'!
orientationToLeft

	^ SouthOrientation new.! !

!WestOrientation methodsFor: 'as yet unclassified' stamp: 'CD 5/16/2021 21:11:35'!
orientationToRight

	^ NorthOrientation new.! !

!WestOrientation methodsFor: 'as yet unclassified' stamp: 'CD 5/16/2021 19:47:52'!
updateBackward: position

	^ position + (1 @ 0).! !

!WestOrientation methodsFor: 'as yet unclassified' stamp: 'CD 5/16/2021 19:48:07'!
updateForward: position

	^ position + (-1 @ 0).! !
