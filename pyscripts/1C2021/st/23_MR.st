!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 15:23:43'!
test01CreateRoverAtPositionPointing

	| rover |

	rover := MarsRover at: (0 @ 0) facing: North.
	
	self assert: (rover isAt: (0 @ 0) facing: North).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 16:30:18'!
test02RoverProcessEmptyPackage

	| rover |

	rover := MarsRover at: (0 @ 0) facing: North.
	rover processPackage: ''.
	
	self assert: (rover isAt: (0 @ 0) facing: North).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 15:24:09'!
test03RoverProcessForwardsPackageFacingNorth

	| rover |

	rover := MarsRover at: (0 @ 0) facing: North.
	rover processPackage: 'f'.	

	self assert: (rover isAt: (0 @ 1) facing: North).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 15:24:15'!
test04RoverProcessBackwardsPackageFacingNorth

	| rover |

	rover := MarsRover at: (0 @ 0) facing: North.
	rover processPackage: 'b'.	

	self assert: (rover isAt: (0 @ -1) facing: North).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 15:24:22'!
test05RoverProcessBackwardsPackageFacingSouth

	| rover |

	rover := MarsRover at: (0 @ 0) facing: South.
	rover processPackage: 'b'.	

	self assert: (rover isAt: (0 @ 1) facing: South).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 15:24:26'!
test06RoverProcessForwardsPackageFacingSouth

	| rover |

	rover := MarsRover at: (0 @ 0) facing: South.
	rover processPackage: 'f'.	

	self assert: (rover isAt: (0 @ -1) facing: South).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 15:24:31'!
test07RoverProcessBackwardsPackageFacingEast

	| rover |

	rover := MarsRover at: (0 @ 0) facing: East.
	rover processPackage: 'b'.	

	self assert: (rover isAt: (-1 @ 0) facing: East).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 15:24:37'!
test08RoverProcessForwardsPackageFacingEast

	| rover |

	rover := MarsRover at: (0 @ 0) facing: East.
	rover processPackage: 'f'.	

	self assert: (rover isAt: (1 @ 0) facing: East).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 15:24:43'!
test09RoverProcessForwardsPackageFacingWest

	| rover |

	rover := MarsRover at: (0 @ 0) facing: West.
	rover processPackage: 'f'.	

	self assert: (rover isAt: (-1 @ 0) facing: West).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 15:24:47'!
test10RoverProcessBackwardsPackageFacingWest

	| rover |

	rover := MarsRover at: (0 @ 0) facing: West.
	rover processPackage: 'b'.	

	self assert: (rover isAt: (1 @ 0) facing: West).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 15:42:10'!
test11RoverProcessRotateLeftFacingNorth

	| rover |

	rover := MarsRover at: (0 @ 0) facing: North.
	rover processPackage: 'l'.	

	self assert: (rover isAt: (0 @ 0) facing: West).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 15:43:10'!
test12RoverProcessRotateRightFacingNorth

	| rover |

	rover := MarsRover at: (0 @ 0) facing: North.
	rover processPackage: 'r'.	

	self assert: (rover isAt: (0 @ 0) facing: East).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 15:44:14'!
test13RoverProcessRotateLeftFacingSouth

	| rover |

	rover := MarsRover at: (0 @ 0) facing: South.
	rover processPackage: 'l'.	

	self assert: (rover isAt: (0 @ 0) facing: East).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 15:46:01'!
test14RoverProcessRotateRightFacingSouth

	| rover |

	rover := MarsRover at: (0 @ 0) facing: South.
	rover processPackage: 'r'.	

	self assert: (rover isAt: (0 @ 0) facing: West).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 15:46:08'!
test15RoverProcessRotateLeftFacingEast

	| rover |

	rover := MarsRover at: (0 @ 0) facing: East.
	rover processPackage: 'l'.	

	self assert: (rover isAt: (0 @ 0) facing: North).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 15:48:32'!
test16RoverProcessRotateRightFacingEast

	| rover |

	rover := MarsRover at: (0 @ 0) facing: East.
	rover processPackage: 'r'.	

	self assert: (rover isAt: (0 @ 0) facing: South).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 15:48:19'!
test17RoverProcessRotateLeftFacingWest

	| rover |

	rover := MarsRover at: (0 @ 0) facing: West.
	rover processPackage: 'l'.	

	self assert: (rover isAt: (0 @ 0) facing: South).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 15:48:53'!
test18RoverProcessRotateRightFacingWest

	| rover |

	rover := MarsRover at: (0 @ 0) facing: West.
	rover processPackage: 'r'.	

	self assert: (rover isAt: (0 @ 0) facing: North).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 16:17:15'!
test19RoverProcessInvalidPackage

	| rover |

	rover := MarsRover at: (0 @ 0) facing: North.
			
	self should: [ rover processPackage: 'x' ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: ( anError messageText = MarsRover marsRoverInvalidActionDescription )].
	self assert: (rover isAt: (0 @ 0) facing: North).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 16:18:43'!
test20RoverProcessLargePackageFacingNorth

	| rover |

	rover := MarsRover at: (0 @ 0) facing: North.
			
	rover processPackage: 'ffrff'.
	
	self assert: (rover isAt: (2 @ 2) facing: East).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 16:31:34'!
test21RoverProcessInvalidLargePackageFacingNorth

	| rover |

	rover := MarsRover at: (0 @ 0) facing: North.
			
	self should: [ rover processPackage: 'bbblxbb'. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: ( anError messageText = MarsRover marsRoverInvalidActionDescription )].
	
	self assert: (rover isAt: (0 @ -3) facing: West).! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'plp 5/17/2021 15:22:42'!
initializeAt: aPosition facing: aCardinal 
	
	position := aPosition.
	direction := aCardinal new.! !


!MarsRover methodsFor: 'validation' stamp: 'plp 5/17/2021 15:23:25'!
isAt: aPosition facing: aCardinal 
	
	^ ( position = aPosition ) and: ( direction class = aCardinal ).
	! !


!MarsRover methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 16:41:33'!
faceEast

	^ direction := East new.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 16:41:44'!
faceNorth

	^ direction := North new.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 16:41:58'!
faceSouth

	^ direction := South new.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 16:42:08'!
faceWest

	^ direction := West new.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 16:03:24'!
invalidPackageError

	^ self error: self class marsRoverInvalidActionDescription! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 16:42:43'!
moveFacingEast: anAction

	anAction = $f ifTrue: [ ^ self moveRelativeRight ].
	anAction = $b ifTrue: [ ^ self moveRelativeLeft ].
	anAction = $l ifTrue: [ ^ self faceNorth ].
	anAction = $r ifTrue: [ ^ self faceSouth ]
		ifFalse: [ ^ self invalidPackageError ]! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 16:43:06'!
moveFacingNorth: anAction

	anAction = $f ifTrue: [ ^ self moveRelativeUp ].
	anAction = $b ifTrue: [ ^ self moveRelativeDown ].
	anAction = $l ifTrue: [ ^ self faceWest ].
	anAction = $r ifTrue: [ ^ self faceEast ]
		ifFalse: [ ^ self invalidPackageError ]! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 16:43:01'!
moveFacingSouth: anAction

	anAction = $f ifTrue: [ ^ self moveRelativeDown ].
	anAction = $b ifTrue: [ ^ self moveRelativeUp ].
	anAction = $l ifTrue: [ ^ self faceEast ].
	anAction = $r ifTrue: [ ^ self faceWest ]
		ifFalse: [ ^ self invalidPackageError ]! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 16:42:35'!
moveFacingWest: anAction

	anAction = $f ifTrue: [ ^ self moveRelativeLeft ].
	anAction = $b ifTrue: [ ^ self moveRelativeRight ].
	anAction = $l ifTrue: [ ^ self faceSouth ].
	anAction = $r ifTrue: [ ^ self faceNorth ]
		ifFalse: [ ^ self invalidPackageError ]! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 16:39:38'!
moveRelativeDown

	^ position := position + (0 @ -1)! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 16:39:04'!
moveRelativeLeft

	^ position := position + (-1 @ 0)! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 16:39:14'!
moveRelativeRight

	^ position := position + (1 @ 0)! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 16:39:56'!
moveRelativeUp

	^ position := position + (0 @ 1)! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 16:30:02'!
processPackage: aString 

	aString = '' ifFalse: [	
			aString do: [ :char |
			direction move: self to: char	
		]
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'plp 5/17/2021 15:23:04'!
at: aPosition facing: aCardinal 
	
	^self new initializeAt: aPosition facing: aCardinal ! !

!MarsRover class methodsFor: 'instance creation' stamp: 'plp 5/17/2021 16:00:18'!
marsRoverInvalidActionDescription

	^ 'The action is invalid'! !


!classDefinition: #MarsRoverCardinal category: 'MarsRover'!
Object subclass: #MarsRoverCardinal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverCardinal methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 15:38:13'!
move: aRover to: anAction

	^ self subclassResponsibility ! !


!classDefinition: #East category: 'MarsRover'!
MarsRoverCardinal subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 16:34:10'!
move: aRover to: anAction

	aRover moveFacingEast: anAction.! !


!classDefinition: #North category: 'MarsRover'!
MarsRoverCardinal subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 16:34:23'!
move: aRover to: anAction

	aRover moveFacingNorth: anAction.! !


!classDefinition: #South category: 'MarsRover'!
MarsRoverCardinal subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 16:34:52'!
move: aRover to: anAction

	aRover moveFacingSouth: anAction.! !


!classDefinition: #West category: 'MarsRover'!
MarsRoverCardinal subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'as yet unclassified' stamp: 'plp 5/17/2021 16:35:01'!
move: aRover to: anAction

	aRover moveFacingWest: anAction.! !
