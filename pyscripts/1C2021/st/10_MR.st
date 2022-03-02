!classDefinition: #MarsRoverTest category: 'Mars Rover Excersice'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover Excersice'!

!MarsRoverTest methodsFor: 'testing' stamp: 'CS 5/17/2021 16:46:07'!
test01AssertWhenAPackageIsEmpty

	|rover |
	
	rover := MarsRover startPosition: 0@0 pointing: MarsRoverPointingNorth new.
	
	rover processPackage: ''. 
	
	self assert: (rover isPosition: 0@0 pointing: MarsRoverPointingNorth new)
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'CS 5/17/2021 16:46:00'!
test02AssertWhenAMarsRoverMoveFowardStartPointingAtNorth

	|rover|
	
	rover := MarsRover startPosition: 0@0 pointing: MarsRoverPointingNorth new.
	
	rover processPackage: 'f'. 
	self assert: (rover isPosition: 0@1 pointing: MarsRoverPointingNorth new)
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'CS 5/17/2021 16:47:37'!
test03AssertWhenAMarsRoverMoveBackwardsStartPointingAtNorth

	|rover |
	
	rover := MarsRover startPosition: 0@0 pointing: MarsRoverPointingNorth new.
	
	rover processPackage: 'b'. 
	
	self assert: (rover isPosition: 0@-1 pointing: MarsRoverPointingNorth new)
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'ms 5/16/2021 12:08:52'!
test04AssertWhenAMarsRoverRotateLeftStartPointingAtNorth

	|rover |
	
	rover := MarsRover startPosition: 0@0 pointing: MarsRoverPointingNorth new.
	rover processPackage: 'l'. 
	self assert: (rover isPosition: 0@0 pointing: MarsRoverPointingWest new)
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'ms 5/16/2021 12:09:51'!
test05AssertWhenAMarsRoverRotateRightStartPointingAtNorth

	|rover |
	
	rover := MarsRover startPosition: 0@0 pointing: MarsRoverPointingNorth new.
	rover processPackage: 'r'. 
	self assert: (rover isPosition: 0@0 pointing: MarsRoverPointingEast new)
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'CS 5/17/2021 16:28:15'!
test06ShouldThrowAnErrorWhenThereIsACommandInThePackageThatIsNotValid

	|rover|
	
	rover := MarsRover startPosition: 0@0 pointing: MarsRoverPointingNorth new.
	 
self 
		should: [ rover processPackage: ' '. ]
		raise: Error
		withMessageText: MarsRover describeErrorTheCommandIsInvalid.
		
		self assert: (rover isPosition:  0@0 pointing: MarsRoverPointingNorth new). 
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'ms 5/16/2021 12:18:29'!
test07AssertWhenAMarsRoverRotateRightStartPointingAtSouth

	|rover|
	
	rover := MarsRover startPosition: 0@0 pointing: MarsRoverPointingSouth new.
	
	rover processPackage: 'f'. 
	
	self assert: (rover isPosition: 0@-1 pointing: MarsRoverPointingSouth new)
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'ms 5/16/2021 12:18:41'!
test08AssertWhenAMarsRoverRotateRightStartPointingAtEast

	|rover|
	
	rover := MarsRover startPosition: 0@0 pointing: MarsRoverPointingEast new.
	rover processPackage: 'f'. 
	self assert: (rover isPosition: 1@0 pointing: MarsRoverPointingEast new)
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'ms 5/16/2021 12:19:07'!
test09AssertWhenAMarsRoverRotateRightStartPointingAtWest

	|rover|
	
	rover := MarsRover startPosition: 0@0 pointing: MarsRoverPointingWest new.
	rover processPackage: 'f'. 
	self assert: (rover isPosition: -1@0 pointing: MarsRoverPointingWest new)
	"este test paso de una, por que nos dimos cuenta que tmb iba a necesitar el west"
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'ms 5/16/2021 12:19:29'!
test10AssertWhenAMarsRoverMoveBackwardsStartPointingAtWest

	|rover|
	
	rover := MarsRover startPosition: 0@0 pointing: MarsRoverPointingWest new.
	rover processPackage: 'b'. 
	self assert: (rover isPosition: 1@0 pointing: MarsRoverPointingWest new)
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'ms 5/16/2021 12:19:42'!
test11AssertWhenAMarsRoverMoveBackwardsStartPointingAtsouth

	|rover|
	
	rover := MarsRover startPosition: 0@0 pointing: MarsRoverPointingSouth new.
	rover processPackage: 'b'. 
	self assert: (rover isPosition: 0@1 pointing: MarsRoverPointingSouth new)
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'ms 5/16/2021 12:20:23'!
test12AssertWhenAMarsRoverRotateLeftStartPointingAtSouth

	|rover|
	
	rover := MarsRover startPosition: 0@0 pointing: MarsRoverPointingSouth new.
	rover processPackage: 'l'. 
	self assert: (rover isPosition: 0@0 pointing: MarsRoverPointingEast new)
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'ms 5/16/2021 12:20:51'!
test13AssertWhenAMarsRoverRotateLeftStartPointingAtEast

	|rover|
	
	rover := MarsRover startPosition: 0@0 pointing: MarsRoverPointingEast new.
	rover processPackage: 'l'. 
	self assert: (rover isPosition: 0@0 pointing: MarsRoverPointingNorth new)
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'ms 5/16/2021 12:21:02'!
test14AssertWhenAMarsRoverRotateLeftStartPointingAtWest

	|rover|
	
	rover := MarsRover startPosition: 0@0 pointing: MarsRoverPointingWest new.
	rover processPackage: 'l'. 
	self assert: (rover isPosition: 0@0 pointing: MarsRoverPointingSouth new)
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'ms 5/16/2021 12:21:24'!
test15AssertWhenAMarsRoverRotateRightStartPointingAtSouth

	|rover|
	
	rover := MarsRover startPosition: 0@0 pointing: MarsRoverPointingSouth new.
	rover processPackage: 'r'. 
	self assert: (rover isPosition: 0@0 pointing: MarsRoverPointingWest new)
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'ms 5/16/2021 12:21:35'!
test16AssertWhenAMarsRoverRotateRightStartPointingAtWest

	|rover|
	
	rover := MarsRover startPosition: 0@0 pointing: MarsRoverPointingWest new.
	rover processPackage: 'r'. 
	self assert: (rover isPosition: 0@0 pointing: MarsRoverPointingNorth new)
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'ms 5/16/2021 12:21:46'!
test17AssertWhenAMarsRoverRotateRightStartPointingAtEast

	|rover|
	
	rover := MarsRover startPosition: 0@0 pointing: MarsRoverPointingEast new.
	rover processPackage: 'r'. 
	self assert: (rover isPosition: 0@0 pointing: MarsRoverPointingSouth new)
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'CS 5/17/2021 16:40:19'!
test18AssertWhenAComandHasMoreThanOneChar

	|rover|
	
	rover := MarsRover startPosition: 0@0 pointing: MarsRoverPointingNorth new.
	rover processPackage: 'fbbrll'. 
	self assert: (rover isPosition: 0@-1 pointing: MarsRoverPointingWest new)
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'CS 5/17/2021 16:40:27'!
test19CaseSensitiveInCommands

	|rover|
	
	rover := MarsRover startPosition: 0@0 pointing: MarsRoverPointingNorth new.
self 
		should: [ rover processPackage: 'F'. ]
		raise: Error
		withMessageText: MarsRover describeErrorTheCommandIsInvalid.
		
	self assert: (rover isPosition: 0@0 pointing: MarsRoverPointingNorth new)
	! !


!classDefinition: #MarsRover category: 'Mars Rover Excersice'!
Object subclass: #MarsRover
	instanceVariableNames: 'position pointingTo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover Excersice'!

!MarsRover methodsFor: 'movements' stamp: 'ms 5/16/2021 11:01:52'!
moveBackward
	
	pointingTo  moveBackwardTo: self.
	! !

!MarsRover methodsFor: 'movements' stamp: 'ms 5/16/2021 11:01:48'!
moveFoward

	pointingTo  moveFowardTo: self.! !

!MarsRover methodsFor: 'movements' stamp: 'ms 5/16/2021 11:01:43'!
rotateLeft

	pointingTo rotateLeftTo: self! !

!MarsRover methodsFor: 'movements' stamp: 'ms 5/16/2021 11:01:32'!
rotateRight
	
	pointingTo rotateRightTo: self
	! !


!MarsRover methodsFor: 'moveFowardPointing' stamp: 'ms 5/16/2021 10:37:24'!
moveFowardsPointingAtEast

	position := position  + (1@0)! !

!MarsRover methodsFor: 'moveFowardPointing' stamp: 'ms 5/16/2021 10:34:52'!
moveFowardsPointingAtNorth

	position := position  + (0@1).! !

!MarsRover methodsFor: 'moveFowardPointing' stamp: 'ms 5/16/2021 10:36:01'!
moveFowardsPointingAtSouth 

	position := position  - (0@1)! !

!MarsRover methodsFor: 'moveFowardPointing' stamp: 'ms 5/16/2021 10:37:59'!
moveFowardsPointingAtWest

	position := position  - (1@0)! !


!MarsRover methodsFor: 'rotateLeftPointing' stamp: 'ms 5/16/2021 10:58:13'!
rotateLeftPointingAtEast

	pointingTo := MarsRoverPointingNorth new! !

!MarsRover methodsFor: 'rotateLeftPointing' stamp: 'ms 5/16/2021 10:58:03'!
rotateLeftPointingAtNorth

	pointingTo := MarsRoverPointingWest new! !

!MarsRover methodsFor: 'rotateLeftPointing' stamp: 'ms 5/16/2021 10:58:23'!
rotateLeftPointingAtSouth

	pointingTo := MarsRoverPointingEast new! !

!MarsRover methodsFor: 'rotateLeftPointing' stamp: 'ms 5/16/2021 10:58:33'!
rotateLeftPointingAtWest

	pointingTo := MarsRoverPointingSouth new! !


!MarsRover methodsFor: 'rotateRightPointing' stamp: 'ms 5/16/2021 10:58:40'!
rotateRightPointingAtEast

	pointingTo  := MarsRoverPointingSouth new! !

!MarsRover methodsFor: 'rotateRightPointing' stamp: 'ms 5/16/2021 10:58:48'!
rotateRightPointingAtNorth

	pointingTo  := MarsRoverPointingEast new! !

!MarsRover methodsFor: 'rotateRightPointing' stamp: 'ms 5/16/2021 10:58:52'!
rotateRightPointingAtSouth

	pointingTo  := MarsRoverPointingWest new! !

!MarsRover methodsFor: 'rotateRightPointing' stamp: 'ms 5/16/2021 10:58:58'!
rotateRightPointingAtWest

	pointingTo  := MarsRoverPointingNorth new! !


!MarsRover methodsFor: 'moveBackwardPointng' stamp: 'ms 5/16/2021 11:04:36'!
moveBackwardPointingAtEast

	position:= position - (1@0)! !

!MarsRover methodsFor: 'moveBackwardPointng' stamp: 'ms 5/16/2021 11:04:39'!
moveBackwardPointingAtNorth

	position:= position - (0@1)! !

!MarsRover methodsFor: 'moveBackwardPointng' stamp: 'ms 5/16/2021 11:04:41'!
moveBackwardPointingAtSouth

	position:= position + (0@1)! !

!MarsRover methodsFor: 'moveBackwardPointng' stamp: 'ms 5/16/2021 11:04:44'!
moveBackwardPointingAtWest

	position:= position + (1@0)! !


!MarsRover methodsFor: 'initialization' stamp: 'ms 5/16/2021 11:04:49'!
initialize: aStartPosition with: aCardinalPoint.

	position:= aStartPosition.
	pointingTo := aCardinalPoint.  
	! !


!MarsRover methodsFor: 'comparingPositionAndWhereIsPointing' stamp: 'ms 5/16/2021 10:23:27'!
isPosition: aPosition pointing: aCardinalPoint.

	^((aPosition = position) and: (pointingTo class = aCardinalPoint class))! !


!MarsRover methodsFor: 'processPackage' stamp: 'CS 5/17/2021 16:26:56'!
processPackage: commands

	commands do: [ :command | self processCommand: command].
	! !


!MarsRover methodsFor: 'private - processPackage' stamp: 'CS 5/17/2021 16:27:18'!
processCommand: aCommand

	(aCommand = $f) ifTrue: [^ self moveFoward].
	(aCommand = $b) ifTrue: [^ self moveBackward].
	(aCommand  = $l) ifTrue: [^ self rotateLeft].
	(aCommand  = $r) ifTrue: [^ self rotateRight].
	
	^Error signal: self class describeErrorTheCommandIsInvalid.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Mars Rover Excersice'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'describeErrors' stamp: 'CS 5/17/2021 16:35:36'!
describeErrorTheCommandIsInvalid

	^'The command is invalid'! !


!MarsRover class methodsFor: 'initialization' stamp: 'ms 5/13/2021 21:30:06'!
startPosition: aStartPosition pointing: aCardinalPoint.

	^ MarsRover new initialize: aStartPosition with: aCardinalPoint.! !


!classDefinition: #MarsRoverPointing category: 'Mars Rover Excersice'!
Object subclass: #MarsRoverPointing
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover Excersice'!

!MarsRoverPointing methodsFor: 'movements' stamp: 'ms 5/16/2021 10:46:41'!
moveBackwardTo: aMarsRover

	self subclassResponsibility ! !

!MarsRoverPointing methodsFor: 'movements' stamp: 'ms 5/16/2021 10:46:46'!
moveFowardTo: aMarsRover

	self subclassResponsibility ! !

!MarsRoverPointing methodsFor: 'movements' stamp: 'ms 5/16/2021 10:51:00'!
rotateLeftTo: aMarsRover

	self subclassResponsibility ! !

!MarsRoverPointing methodsFor: 'movements' stamp: 'ms 5/16/2021 10:55:33'!
rotateRightTo: aMarsRover

	self subclassResponsibility ! !


!classDefinition: #MarsRoverPointingEast category: 'Mars Rover Excersice'!
MarsRoverPointing subclass: #MarsRoverPointingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover Excersice'!

!MarsRoverPointingEast methodsFor: 'movements' stamp: 'ms 5/16/2021 10:49:24'!
moveBackwardTo: aMarsRover

	aMarsRover moveBackwardPointingAtEast! !

!MarsRoverPointingEast methodsFor: 'movements' stamp: 'ms 5/16/2021 10:36:58'!
moveFowardTo: aMarsRover

	aMarsRover moveFowardsPointingAtEast! !

!MarsRoverPointingEast methodsFor: 'movements' stamp: 'ms 5/16/2021 10:53:35'!
rotateLeftTo: aMarsRover

	aMarsRover rotateLeftPointingAtEast ! !

!MarsRoverPointingEast methodsFor: 'movements' stamp: 'ms 5/16/2021 10:56:13'!
rotateRightTo: aMarsRover

	aMarsRover rotateRightPointingAtEast ! !


!classDefinition: #MarsRoverPointingNorth category: 'Mars Rover Excersice'!
MarsRoverPointing subclass: #MarsRoverPointingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover Excersice'!

!MarsRoverPointingNorth methodsFor: 'movements' stamp: 'ms 5/16/2021 10:49:14'!
moveBackwardTo: aMarsRover

	aMarsRover moveBackwardPointingAtNorth! !

!MarsRoverPointingNorth methodsFor: 'movements' stamp: 'ms 5/16/2021 10:35:18'!
moveFowardTo: aMarsRover

	aMarsRover moveFowardsPointingAtNorth

	! !

!MarsRoverPointingNorth methodsFor: 'movements' stamp: 'ms 5/16/2021 10:52:22'!
rotateLeftTo: aMarsRover

	aMarsRover rotateLeftPointingAtNorth! !

!MarsRoverPointingNorth methodsFor: 'movements' stamp: 'ms 5/16/2021 10:55:54'!
rotateRightTo: aMarsRover

	aMarsRover rotateRightPointingAtNorth ! !


!classDefinition: #MarsRoverPointingSouth category: 'Mars Rover Excersice'!
MarsRoverPointing subclass: #MarsRoverPointingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover Excersice'!

!MarsRoverPointingSouth methodsFor: 'movements' stamp: 'ms 5/16/2021 10:49:36'!
moveBackwardTo: aMarsRover

	aMarsRover moveBackwardPointingAtSouth ! !

!MarsRoverPointingSouth methodsFor: 'movements' stamp: 'ms 5/16/2021 10:36:25'!
moveFowardTo: aMarsRover

	aMarsRover moveFowardsPointingAtSouth! !

!MarsRoverPointingSouth methodsFor: 'movements' stamp: 'ms 5/16/2021 10:53:20'!
rotateLeftTo: aMarsRover

	aMarsRover rotateLeftPointingAtSouth! !

!MarsRoverPointingSouth methodsFor: 'movements' stamp: 'ms 5/16/2021 10:56:20'!
rotateRightTo: aMarsRover

	aMarsRover rotateRightPointingAtSouth ! !


!classDefinition: #MarsRoverPointingWest category: 'Mars Rover Excersice'!
MarsRoverPointing subclass: #MarsRoverPointingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover Excersice'!

!MarsRoverPointingWest methodsFor: 'movements' stamp: 'ms 5/16/2021 10:49:43'!
moveBackwardTo: aMarsRover

	aMarsRover moveBackwardPointingAtWest ! !

!MarsRoverPointingWest methodsFor: 'movements' stamp: 'ms 5/16/2021 10:38:14'!
moveFowardTo: aMarsRover

	aMarsRover moveFowardsPointingAtWest! !

!MarsRoverPointingWest methodsFor: 'movements' stamp: 'ms 5/16/2021 10:53:41'!
rotateLeftTo: aMarsRover

	aMarsRover rotateLeftPointingAtWest ! !

!MarsRoverPointingWest methodsFor: 'movements' stamp: 'ms 5/16/2021 10:56:29'!
rotateRightTo: aMarsRover

	aMarsRover rotateRightPointingAtWest ! !
