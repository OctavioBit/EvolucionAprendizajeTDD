!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:27:37'!
test01emptySequence

	| rover |
	
	rover := MarsRover at: 0@0 facing: North new.
	
	rover process: ''.
	
	self assert: 0@0 equals: rover location.
	self assert: North equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:27:46'!
test02advanceFacingNorth

	| rover |
	
	rover := MarsRover at: 0@0 facing: North new.
	
	rover process: 'f'.
	
	self assert: 0@1 equals: rover location.
	self assert: North equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:27:53'!
test03advanceFacingEast

	| rover |
	
	rover := MarsRover at: 0@0 facing: East new.
	
	rover process: 'f'.
	
	self assert: 1@0 equals: rover location.
	self assert: East equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:28:02'!
test04advanceFacingSouth

	| rover |
	
	rover := MarsRover at: 0@0 facing: South new.
	
	rover process: 'f'.
	
	self assert: 0@-1 equals: rover location.
	self assert: South equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:28:08'!
test05advanceFacingWest

	| rover |
	
	rover := MarsRover at: 0@0 facing: West new.
	
	rover process: 'f'.
	
	self assert: -1@0 equals: rover location.
	self assert: West equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:28:20'!
test06advanceTwiceFacingNorth

	| rover |
	
	rover := MarsRover at: 0@0 facing: North new.
	
	rover process: 'ff'.
	
	self assert: 0@2 equals: rover location.
	self assert: North equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:28:27'!
test07advanceTwiceFacingEast

	| rover |
	
	rover := MarsRover at: 0@0 facing: East new.
	
	rover process: 'ff'.
	
	self assert: 2@0 equals: rover location.
	self assert: East equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:28:39'!
test08advanceTwiceFacingSouth

	| rover |
	
	rover := MarsRover at: 0@0 facing: South new.
	
	rover process: 'ff'.
	
	self assert: 0@-2 equals: rover location.
	self assert: South equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:28:45'!
test09advanceTwiceFacingWest

	| rover |
	
	rover := MarsRover at: 0@0 facing: West new.
	
	rover process: 'ff'.
	
	self assert: -2@0 equals: rover location.
	self assert: West equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:28:52'!
test10advanceBackwardsFacingNorth

	| rover |
	
	rover := MarsRover at: 0@0 facing: North new.
	
	rover process: 'b'.
	
	self assert: 0@-1 equals: rover location.
	self assert: North equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:28:58'!
test11advanceBackwardsTwiceFacingNorth

	| rover |
	
	rover := MarsRover at: 0@0 facing: North new.
	
	rover process: 'bb'.
	
	self assert: 0@-2 equals: rover location.
	self assert: North equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:29:05'!
test12turnRightFromNorth

	| rover |
	
	rover := MarsRover at: 0@0 facing: North new.
	
	rover process: 'r'.
	
	self assert: 0@0 equals: rover location.
	self assert: East equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:29:12'!
test13turnRightFromEast

	| rover |
	
	rover := MarsRover at: 0@0 facing: East new.
	
	rover process: 'r'.
	
	self assert: 0@0 equals: rover location.
	self assert: South equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:29:19'!
test14turnRightFromSouth

	| rover |
	
	rover := MarsRover at: 0@0 facing: South new.
	
	rover process: 'r'.
	
	self assert: 0@0 equals: rover location.
	self assert: West equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:29:25'!
test15turnRightFromWest

	| rover |
	
	rover := MarsRover at: 0@0 facing: West new.
	
	rover process: 'r'.
	
	self assert: 0@0 equals: rover location.
	self assert: North equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:29:32'!
test16turnRightTwiceFromNorth

	| rover |
	
	rover := MarsRover at: 0@0 facing: North new.
	
	rover process: 'rr'.
	
	self assert: 0@0 equals: rover location.
	self assert: South equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:29:39'!
test17turnRightTwiceFromEast

	| rover |
	
	rover := MarsRover at: 0@0 facing: East new.
	
	rover process: 'rr'.
	
	self assert: 0@0 equals: rover location.
	self assert: West equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:29:45'!
test18turnRightTwiceFromSouth

	| rover |
	
	rover := MarsRover at: 0@0 facing: South new.
	
	rover process: 'rr'.
	
	self assert: 0@0 equals: rover location.
	self assert: North equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:29:53'!
test19turnRightTwiceFromWest

	| rover |
	
	rover := MarsRover at: 0@0 facing: West new.
	
	rover process: 'rr'.
	
	self assert: 0@0 equals: rover location.
	self assert: East equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:30:00'!
test20turnRightThriceFromNorth

	| rover |
	
	rover := MarsRover at: 0@0 facing: North new.
	
	rover process: 'rrr'.
	
	self assert: 0@0 equals: rover location.
	self assert: West equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:30:07'!
test21turnLeftFromNorth

	| rover |
	
	rover := MarsRover at: 0@0 facing: North new.
	
	rover process: 'l'.
	
	self assert: 0@0 equals: rover location.
	self assert: West equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:30:13'!
test22turnLeftTwiceFromNorth

	| rover |
	
	rover := MarsRover at: 0@0 facing: North new.
	
	rover process: 'll'.
	
	self assert: 0@0 equals: rover location.
	self assert: South equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:30:21'!
test23turnLeftThriceFromNorth

	| rover |
	
	rover := MarsRover at: 0@0 facing: North new.
	
	rover process: 'lll'.
	
	self assert: 0@0 equals: rover location.
	self assert: East equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:30:28'!
test24turnRightFromNorthAndAdvance

	| rover |
	
	rover := MarsRover at: 0@0 facing: North new.
	
	rover process: 'rf'.
	
	self assert: 1@0 equals: rover location.
	self assert: East equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:30:37'!
test25turnRightFromEastAndAdvance

	| rover |
	
	rover := MarsRover at: 0@0 facing: East new.
	
	rover process: 'rf'.
	
	self assert: 0@-1 equals: rover location.
	self assert: South equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:30:45'!
test26turnRightFromSouthAndAdvance

	| rover |
	
	rover := MarsRover at: 0@0 facing: South new.
	
	rover process: 'rf'.
	
	self assert: -1@0 equals: rover location.
	self assert: West equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:30:51'!
test27turnRightFromWestAndAdvance

	| rover |
	
	rover := MarsRover at: 0@0 facing: West new.
	
	rover process: 'rf'.
	
	self assert: 0@1 equals: rover location.
	self assert: North equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:30:58'!
test28turnLeftFromNorthAndAdvance

	| rover |
	
	rover := MarsRover at: 0@0 facing: North new.
	
	rover process: 'lf'.
	
	self assert: -1@0 equals: rover location.
	self assert: West equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:31:05'!
test29advanceTurnRightFromNorthAndAdvance

	| rover |
	
	rover := MarsRover at: 0@0 facing: North new.
	
	rover process: 'frf'.
	
	self assert: 1@1 equals: rover location.
	self assert: East equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:31:12'!
test30advanceTurnRightFromEastAndAdvance

	| rover |
	
	rover := MarsRover at: 0@0 facing: East new.
	
	rover process: 'frf'.
	
	self assert: 1@-1 equals: rover location.
	self assert: South equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:31:19'!
test31advanceTurnRightFromSouthAndAdvance

	| rover |
	
	rover := MarsRover at: 0@0 facing: South new.
	
	rover process: 'frf'.
	
	self assert: -1@-1 equals: rover location.
	self assert: West equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:31:26'!
test32advanceTurnRightFromWestAndAdvance

	| rover |
	
	rover := MarsRover at: 0@0 facing: West new.
	
	rover process: 'frf'.
	
	self assert: -1@1 equals: rover location.
	self assert: North equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:31:33'!
test33singleInvalidCommand

	| rover |
	
	rover := MarsRover at: 0@0 facing: North new.
	
	rover process: 's'.
	
	self assert: 0@0 equals: rover location.
	self assert: North equals: rover direction class.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'LM 5/17/2021 16:31:41'!
test34invalidCommandAtTheBeginning

	| rover |
	
	rover := MarsRover at: 0@0 facing: North new.
	
	rover process: 'sffr'.
	
	self assert: 0@0 equals: rover location.
	self assert: North equals: rover direction class.! !


!classDefinition: #CardinalPoint category: 'MarsRover'!
Object subclass: #CardinalPoint
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalPoint methodsFor: 'converting' stamp: 'LM 5/17/2021 16:24:46'!
asVector

	self subclassResponsibility! !


!CardinalPoint methodsFor: 'rotate' stamp: 'LM 5/17/2021 16:24:51'!
rotateAntiClockwise

	self subclassResponsibility! !

!CardinalPoint methodsFor: 'rotate' stamp: 'LM 5/17/2021 16:24:54'!
rotateClockwise

	self subclassResponsibility! !


!classDefinition: #East category: 'MarsRover'!
CardinalPoint subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'converting' stamp: 'LM 5/17/2021 16:25:13'!
asVector

	^1@0! !


!East methodsFor: 'rotate' stamp: 'LM 5/17/2021 16:34:17'!
rotateAntiClockwise

	^North new! !

!East methodsFor: 'rotate' stamp: 'LM 5/17/2021 16:34:22'!
rotateClockwise

	^South new! !


!classDefinition: #North category: 'MarsRover'!
CardinalPoint subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'converting' stamp: 'LM 5/17/2021 16:25:26'!
asVector

	^0@1! !


!North methodsFor: 'rotate' stamp: 'LM 5/17/2021 16:34:29'!
rotateAntiClockwise

	^West new! !

!North methodsFor: 'rotate' stamp: 'LM 5/17/2021 16:34:34'!
rotateClockwise

	^East new! !


!classDefinition: #South category: 'MarsRover'!
CardinalPoint subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'converting' stamp: 'LM 5/17/2021 16:25:38'!
asVector

	^0@-1! !


!South methodsFor: 'rotate' stamp: 'LM 5/17/2021 16:34:39'!
rotateAntiClockwise

	^East new! !

!South methodsFor: 'rotate' stamp: 'LM 5/17/2021 16:34:43'!
rotateClockwise

	^West new! !


!classDefinition: #West category: 'MarsRover'!
CardinalPoint subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'converting' stamp: 'LM 5/17/2021 16:25:52'!
asVector

	^-1@0! !


!West methodsFor: 'rotate' stamp: 'LM 5/17/2021 16:34:48'!
rotateAntiClockwise

	^South new! !

!West methodsFor: 'rotate' stamp: 'LM 5/17/2021 16:34:52'!
rotateClockwise

	^North new! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'location direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'LM 5/16/2021 17:23:46'!
initializeAt: aLocation facing: aDirection 

	location := aLocation.
	direction := aDirection.! !


!MarsRover methodsFor: 'processing' stamp: 'LM 5/16/2021 22:08:27'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:command |
		(#($f $b $r $l) includes: command) ifTrue: [
			self processSingleCommand: command
		] ifFalse: [
			^self
		].
	].! !

!MarsRover methodsFor: 'processing' stamp: 'LM 5/16/2021 22:01:50'!
processSingleCommand: aCommand

	aCommand = $f ifTrue: [^location := location + direction asVector].
	aCommand = $b ifTrue: [^location := location - direction asVector].
	aCommand = $r ifTrue: [^direction := direction rotateClockwise	].
	aCommand = $l ifTrue: [^direction := direction rotateAntiClockwise	].! !


!MarsRover methodsFor: 'accessing' stamp: 'LM 5/16/2021 17:25:09'!
direction

	^direction! !

!MarsRover methodsFor: 'accessing' stamp: 'LM 5/16/2021 17:24:54'!
location

	^location! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'LM 5/16/2021 17:23:07'!
at: aLocation facing: aDirection

	^self new initializeAt: aLocation facing: aDirection! !
