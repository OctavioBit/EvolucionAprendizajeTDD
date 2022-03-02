!classDefinition: #LogTest category: 'MarsRover-WithHeading'!
TestCase subclass: #LogTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!LogTest methodsFor: 'positionLogTest' stamp: 'sc 6/3/2021 21:16:12'!
test01LogDeMarsRoverQueNoSeMueveEsVacio
	|marsRover aLog|
	marsRover := MarsRover at: 0@0 heading: #North.
	aLog := PositionLog newWith: marsRover.
	self assert: aLog isEmpty.
	! !

!LogTest methodsFor: 'positionLogTest' stamp: 'sc 6/3/2021 21:17:18'!
test02LogDeMarsRoverQueSeMueveUnaPosicionHaciaAdelanteLaRegistra
	|marsRover aLog|
	marsRover := MarsRover at: 0@0 heading: #North.
	aLog := PositionLog newWith: marsRover.
	marsRover process: 'f'.
	self deny: aLog isEmpty. 
	self assert: aLog size = 1.
	self assert: (aLog at: 1) equals: '0@1'.
	! !

!LogTest methodsFor: 'positionLogTest' stamp: 'sc 6/5/2021 23:43:38'!
test03LogDeMarsRoverQueSeMueveDosPosicionesHaciaAdelanteLasRegistra
	|marsRover aLog|
	marsRover := MarsRover at: 0@0 heading: #North.
	aLog := PositionLog newWith: marsRover.
	marsRover process: 'ff'.
	self assert: aLog size = 2.
	self assertLog: aLog RegisterEqualsCollection: (OrderedCollection with: '0@1' with: '0@2') .! !

!LogTest methodsFor: 'positionLogTest' stamp: 'sc 6/5/2021 23:44:28'!
test04LogDeMarsRoverQueSeMueveTresPosicionesHaciaAdelanteLasRegistra
	|marsRover aLog|
	marsRover := MarsRover at: 0@0 heading: #North.
	aLog := PositionLog newWith: marsRover.
	marsRover process: 'fff'.
	self assert: aLog size = 3.
	self assertLog: aLog RegisterEqualsCollection: (OrderedCollection with: '0@1' with: '0@2' with: '0@3' ) .
! !

!LogTest methodsFor: 'positionLogTest' stamp: 'sc 6/5/2021 23:45:20'!
test05LogDeMarsRoverQueSeMueveParaAdelanteYLuegoHaciaAtrasRegistraLasPosiciones
	|marsRover aLog|
	marsRover := MarsRover at: 0@0 heading: #North.
	aLog := PositionLog newWith: marsRover.
	marsRover process: 'fffb'.
	self assert: aLog size = 4.
	self assertLog: aLog RegisterEqualsCollection: (OrderedCollection with: '0@1' with: '0@2' with: '0@3' with: '0@2') .! !


!LogTest methodsFor: 'directionLogTest' stamp: 'sc 6/4/2021 10:44:39'!
test06LogDeMarsRoverQueNoCambiaSuDireccionTieneLogDeDireccionesVacio
	|marsRover aLog|
	marsRover := MarsRover at: 0@0 heading: #North.
	aLog := 	DirectionLog newWith: marsRover.
	self assert: aLog isEmpty. 
	! !

!LogTest methodsFor: 'directionLogTest' stamp: 'sc 6/4/2021 10:44:46'!
test07LogDeMarsRoverQueCambiaSuDireccionRegistraElCambio
	|marsRover aLog|
	marsRover := MarsRover at: 0@0 heading: #North.
	aLog := 	DirectionLog newWith: marsRover.
	marsRover process: 'r'.
	self deny: aLog isEmpty. 
	self assert: aLog size = 1.
	self assert: (aLog at: 1) equals: 'East'.
	! !

!LogTest methodsFor: 'directionLogTest' stamp: 'sc 6/5/2021 23:47:09'!
test08LogDeMarsRoverQueCambiaSuDireccionDosVecesRegistraAmbosCambios
	|marsRover aLog|
	marsRover := MarsRover at: 0@0 heading: #North.
	aLog := 	DirectionLog newWith: marsRover.
	marsRover process: 'rr'.
	self deny: aLog isEmpty. 
	self assert: aLog size = 2.
	self assertLog: aLog RegisterEqualsCollection: (OrderedCollection with: 'East' with:'South').! !

!LogTest methodsFor: 'directionLogTest' stamp: 'sc 6/5/2021 23:47:38'!
test09LogDeMarsRoverQueCambiaSuDireccionParaDiferentesLadosRegistraAmbosCambios
	|marsRover aLog|
	marsRover := MarsRover at: 0@0 heading: #North.
	aLog := 	DirectionLog newWith: marsRover.
	marsRover process: 'rl'.
	self deny: aLog isEmpty. 
	self assert: aLog size = 2.
	self assertLog: aLog RegisterEqualsCollection: (OrderedCollection with: 'East' with:'North').! !


!LogTest methodsFor: 'full LogTest' stamp: 'sc 6/4/2021 10:46:26'!
test10LogDeMarsRoverRegistraUnMovimientoYCambioDeDireccion
	|marsRover aLog|
	marsRover := MarsRover at: 0@0 heading: #North.
	aLog := Log newWith: marsRover.
	marsRover process: 'rf'.
	self deny: aLog isEmpty. 
	self assert: aLog size = 2.
	self assert: (aLog at: 1) equals: 'East'.
	self assert: (aLog at: 2) equals: '1@0'.! !

!LogTest methodsFor: 'full LogTest' stamp: 'sc 6/5/2021 23:52:01'!
test11SePuedenTenerDosLogsFuncionandoSobreUnMismoRover
	|marsRover aLog anotherLog|
	marsRover := MarsRover at: 0@0 heading: #North.
	aLog := Log newWith: marsRover.
	anotherLog := Log newWith: marsRover.
	marsRover process: 'rf'.
	self deny: (aLog isEmpty or: (anotherLog isEmpty)) . 
	self assert: (aLog size = 2 and: anotherLog size = 2).
	self assertLog: aLog RegisterEqualsCollection: (OrderedCollection with: 'East' with: '1@0').
	self assertLog: anotherLog RegisterEqualsCollection: (OrderedCollection with: 'East' with: '1@0').
	
! !


!LogTest methodsFor: 'testing' stamp: 'sc 6/5/2021 23:46:09'!
assertLog: aLog RegisterEqualsCollection: aRoverStateCollection
	1 to: (aLog size) do: [:index |self  assert: (aLog at: index) equals: (aRoverStateCollection  at: index)].! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:26'!
test01

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: ''.
	
	self assert: (marsRover isAt: 1@2 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:31'!
test02

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@3 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:34'!
test03

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 1@1 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:38'!
test04

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: #East)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:45'!
test05

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #West)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:50'!
test06

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: #North) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:54'!
test07

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'ff'.
	
	self assert: (marsRover isAt: 1@4 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:59'!
test08

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 2@2 heading: #East)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:06'!
test09

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 0@2 heading: #East)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:12'!
test10

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: #South)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:20'!
test11

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:25'!
test12

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #South.
	
	marsRover process: 'ffbr'.
	
	self assert: (marsRover isAt: 1@1 heading: #West)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:29'!
test13

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #South.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #East)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:33'!
test14

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #West.
	
	marsRover process: 'ffbr'.
	
	self assert: (marsRover isAt: 0@2 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:37'!
test15

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #West.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #South)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/2/2018 16:27:43'!
test16

	self 
		should: [MarsRover at: 1@2 heading: #X ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: MarsRover invalidCardinalPointErrorDescription equals: anError messageText ]! !


!classDefinition: #WindowTest category: 'MarsRover-WithHeading'!
TestCase subclass: #WindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!WindowTest methodsFor: 'direction window test' stamp: 'sc 6/5/2021 10:38:12'!
test00UnWindowSabeLaDireccionDeUnRoverQueComienzaMirandoAlNorteYNoSeMueve
	|rover window|
	rover _ MarsRover at: (0@0) heading: #North. 
	window _ RoverDirectionWindow newWith: rover .
	self assert: window direction equals: #North.! !

!WindowTest methodsFor: 'direction window test' stamp: 'sc 6/5/2021 10:29:42'!
test01UnWindowSabeLaDireccionDeUnRoverQueComienzaMirandoAlSurYNoSeMueve
	|rover window|
	rover _ MarsRover at: (0@0) heading: #South. 
	window _ RoverDirectionWindow newWith: rover.
	self assert: window direction equals: #South.! !

!WindowTest methodsFor: 'direction window test' stamp: 'sc 6/5/2021 10:40:08'!
test02UnWindowSabeLaDireccionDeUnRoverQueComienzaMirandoAlNorteYRotaALaDerecha
	|rover window|
	rover _ MarsRover at: (0@0) heading: #North.
	window _ RoverDirectionWindow newWith: rover.
	rover process: 'r'.
	self assert: window direction equals: #East! !

!WindowTest methodsFor: 'direction window test' stamp: 'sc 6/5/2021 10:44:45'!
test03UnWindowSabeLaDireccionDeUnRoverQueComienzaMirandoAlNorteYRotaALaIzquierda
	|rover window|
	rover _ MarsRover at: (0@0) heading: #North.
	window _ RoverDirectionWindow newWith: rover.
	rover process: 'l'.
	self assert: window direction equals: #West.! !


!WindowTest methodsFor: 'directonAndPositionWindow' stamp: 'sc 6/5/2021 23:56:23'!
test00WindowConocePosiciónDeRoverQueComienzaMirandoNorteYEnOrigen
	|rover window|
	rover _ MarsRover at: (0@0) heading: #North.
	window _ RoverWindow newWith: rover.
	self assert: window positionEquals: (0@0) andDirectionEquals: (#North).! !

!WindowTest methodsFor: 'directonAndPositionWindow' stamp: 'sc 6/5/2021 23:56:41'!
test01WindowConocePosiciónDeRoverQueComienzaMirandoNorteYEnOrigenYSeMueveHaciaAdelante
	|rover window|
	rover _ MarsRover at: (0@0) heading: #North.
	window _ RoverWindow newWith: rover.
	rover process: 'f'.
	self assert: window positionEquals: (0@1) andDirectionEquals: (#North).! !

!WindowTest methodsFor: 'directonAndPositionWindow' stamp: 'sc 6/5/2021 23:56:56'!
test02WindowConocePosiciónDeRoverQueComienzaMirandoNorteYEnOrigenYSeMueveHaciaAtras
	|rover window|
	rover _ MarsRover at: (0@0) heading: #North.
	window _ RoverWindow newWith: rover.
	rover process: 'b'.
	self assert: window positionEquals: (0@-1) andDirectionEquals: (#North).! !

!WindowTest methodsFor: 'directonAndPositionWindow' stamp: 'sc 6/5/2021 23:57:09'!
test03WindowConocePosiciónDeRoverQueComienzaMirandoNorteYEnOrigenYGiraHaciaLaDerecha
	|rover window|
	rover _ MarsRover at: (0@0) heading: #North.
	window _ RoverWindow newWith: rover.
	rover process: 'r'.
	self assert: window positionEquals: (0@0) andDirectionEquals: (#East).! !

!WindowTest methodsFor: 'directonAndPositionWindow' stamp: 'sc 6/5/2021 23:57:22'!
test04WindowConocePosiciónDeRoverQueComienzaMirandoNorteYEnOrigenYGiraHaciaLaIzquierda
	|rover window|
	rover _ MarsRover at: (0@0) heading: #North.
	window _ RoverWindow newWith: rover.
	rover process: 'l'.
	self assert: window positionEquals: (0@0) andDirectionEquals: (#West).! !

!WindowTest methodsFor: 'directonAndPositionWindow' stamp: 'sc 6/5/2021 23:58:20'!
test05SePuedenTenerDosLogsFuncionandoSobreUnMismoRover
	|rover aWindow anotherWindow|
	rover _ MarsRover at: (0@0) heading: #North.
	aWindow _ RoverWindow newWith: rover.
	anotherWindow _ RoverWindow newWith: rover.
	rover process: 'llbr'.
	self assert: aWindow positionEquals: (0@1) andDirectionEquals: (#West).
	self assert: anotherWindow positionEquals: (0@1) andDirectionEquals: (#West).! !


!WindowTest methodsFor: 'position window test' stamp: 'sc 6/5/2021 10:13:23'!
test00UnWindowSabeLaPosicionDelRoverSiNoSeMueveYComienzaEnElOrigen
	|rover window|
	rover _ MarsRover at: (0@0) heading: #North.
	window _ RoverPositionWindow newWith: rover.
	self assert: window position equals: (0@0).
	
	
	! !

!WindowTest methodsFor: 'position window test' stamp: 'sc 6/5/2021 10:13:58'!
test01UnWindowSabeLaPosicionDelRoverSiNoSeMueveYComienzaEnOtraPosición
	|rover window|
	rover _ MarsRover at: (0@1) heading: #North.
	window _ RoverPositionWindow newWith: rover.
	self assert: window position equals: (0@1).
	
	
	! !

!WindowTest methodsFor: 'position window test' stamp: 'sc 6/5/2021 10:08:03'!
test02UnWindowSabeLaPosicionDeUnRoverQueComienzaEnElOrigenYSeMueveHaciaAdelante
	|rover window|
	rover _ MarsRover at: (0@0) heading: #North.
	window _ RoverPositionWindow newWith: rover.
	rover process: 'f'.
	self assert: window position equals: (0@1).
	
	
	! !

!WindowTest methodsFor: 'position window test' stamp: 'sc 6/5/2021 10:10:40'!
test03UnWindowSabeLaPosicionDeUnRoverQueComienzaEnElOrigenYSeMueveHaciaAtras
	|rover window|
	rover _ MarsRover at: (0@0) heading: #North.
	window _ RoverPositionWindow newWith: rover.
	rover process: 'b'.
	self assert: window position equals: (0@-1).
	
	
	! !


!WindowTest methodsFor: 'testing' stamp: 'sc 6/5/2021 23:54:53'!
assert: aWindow positionEquals: aPosition andDirectionEquals: aDirection
	self assert: aWindow position equals: (aPosition).
	self assert: aWindow direction equals: (aDirection). ! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head observerCollection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'sc 6/5/2021 23:20:31'!
initializeAt: aPosition heading: aHeading

	position := aPosition.
	head := aHeading.
	observerCollection := OrderedCollection  new.! !


!MarsRover methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:14:20'!
headEast
	
	head := MarsRoverHeadingEast new! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:16:30'!
headNorth
	
	head := MarsRoverHeadingNorth new! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:16:05'!
headSouth
	
	head := MarsRoverHeadingSouth new! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:14:38'!
headWest
	
	head := MarsRoverHeadingWest new! !

!MarsRover methodsFor: 'heading' stamp: 'sc 6/5/2021 23:22:33'!
rotateLeft
	
	head rotateLeft: self.
	self updateObservers.! !

!MarsRover methodsFor: 'heading' stamp: 'sc 6/5/2021 23:22:37'!
rotateRight
	
	head rotateRight: self.
	self updateObservers.! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 8/22/2019 12:00:30'!
isAt: aPosition heading: aCardinalPoint

	^position = aPosition and: [ head isHeading: aCardinalPoint ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'sc 6/5/2021 23:22:23'!
moveBackward
	
	head moveBackward: self.
	self updateObservers.
	! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:01'!
moveEast
	
	position := position + (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'sc 6/5/2021 23:22:28'!
moveForward
	
	head moveForward: self.
	self updateObservers.! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:12'!
moveNorth
	
	position := position + (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:34'!
moveSouth
	
	position := position + (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:32'!
moveWest
	
	position := position + (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'observer related' stamp: 'sc 6/5/2021 23:17:50'!
add: aRoverObserver
	observerCollection add: aRoverObserver.
	aRoverObserver provideStartingPosition: position andDirection: head class cardinalPoint .! !

!MarsRover methodsFor: 'observer related' stamp: 'sc 6/5/2021 23:29:17'!
updateObserverDirection: aWindow
		aWindow registerDirection: head class cardinalPoint.! !

!MarsRover methodsFor: 'observer related' stamp: 'sc 6/5/2021 23:29:35'!
updateObserverPosition: aWindow
		aWindow registerPosition: position.! !

!MarsRover methodsFor: 'observer related' stamp: 'sc 6/5/2021 23:21:51'!
updateObservers
		observerCollection do:[:aRoverObserver| aRoverObserver update].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 8/22/2019 12:01:48'!
at: aPosition heading: aCardinalPoint
	
	^self new initializeAt: aPosition heading: (MarsRoverHeading heading: aCardinalPoint)! !

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 7/2/2018 16:26:14'!
invalidCardinalPointErrorDescription
	
	^'Invalid cardinal point'! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:06:17'!
rotateLeft: aMarsRover

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:08:23'!
rotateRight: aMarsRover

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 7/2/2018 19:07:42'!
isHeading: aCardinalPoint

	^self class isFor: aCardinalPoint! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:20'!
moveBackward: aMarsRover

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:54'!
moveForward: aMarsRover

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'cardinal point' stamp: 'HAW 7/2/2018 19:07:01'!
cardinalPoint

	self subclassResponsibility ! !


!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 8/22/2019 12:02:00'!
heading: aCardinalPoint

	^self subclasses 
		detect: [ :aMarsRoverPositionClass | aMarsRoverPositionClass isFor: aCardinalPoint ]
		ifFound: [ :aMarsRoverPositionClass | aMarsRoverPositionClass new ]
		ifNone: [ self error: MarsRover invalidCardinalPointErrorDescription ]! !


!MarsRoverHeading class methodsFor: 'testing' stamp: 'HAW 7/2/2018 17:01:33'!
isFor: aCardinalPoint

	^self cardinalPoint = aCardinalPoint ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:09:19'!
moveBackward: aMarsRover
	
	^aMarsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:09:28'!
moveForward: aMarsRover
	
	^aMarsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:09:42'!
rotateLeft: aMarsRover
	
	^aMarsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:09:54'!
rotateRight: aMarsRover
	
	^aMarsRover headSouth! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingEast class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingEast class
	instanceVariableNames: ''!

!MarsRoverHeadingEast class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:01:53'!
cardinalPoint

	^#East! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:10:12'!
moveBackward: aMarsRover
	
	^aMarsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:10:23'!
moveForward: aMarsRover
	
	^aMarsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:10:40'!
rotateLeft: aMarsRover
	
	^aMarsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:10:51'!
rotateRight: aMarsRover
	
	^aMarsRover headEast! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingNorth class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingNorth class
	instanceVariableNames: ''!

!MarsRoverHeadingNorth class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:11'!
cardinalPoint

	^#North! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:11:15'!
moveBackward: aMarsRover
	
	^aMarsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:11:25'!
moveForward: aMarsRover
	
	^aMarsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:11:55'!
rotateLeft: aMarsRover
	
	^aMarsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:11:50'!
rotateRight: aMarsRover
	
	^aMarsRover headWest! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingSouth class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingSouth class
	instanceVariableNames: ''!

!MarsRoverHeadingSouth class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:17'!
cardinalPoint

	^#South! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:12:07'!
moveBackward: aMarsRover

	^aMarsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:12:15'!
moveForward: aMarsRover
	
	^aMarsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:12:26'!
rotateLeft: aMarsRover
	
	^aMarsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:12:41'!
rotateRight: aMarsRover
	
	^aMarsRover headNorth! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingWest class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingWest class
	instanceVariableNames: ''!

!MarsRoverHeadingWest class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:23'!
cardinalPoint

	^#West! !


!classDefinition: #RoverObserver category: 'MarsRover-WithHeading'!
Object subclass: #RoverObserver
	instanceVariableNames: 'rover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!RoverObserver methodsFor: 'initialization' stamp: 'sc 6/5/2021 23:01:30'!
initializeWith: aMarsRover 
	self subclassResponsibility .
	! !

!RoverObserver methodsFor: 'initialization' stamp: 'sc 6/5/2021 23:16:50'!
provideStartingPosition:aPosition andDirection: aDirection
	self subclassResponsibility.! !


!RoverObserver methodsFor: 'operations' stamp: 'sc 6/5/2021 23:26:05'!
registerDirection: aDirection
	self subclassResponsibility ! !

!RoverObserver methodsFor: 'operations' stamp: 'sc 6/5/2021 23:25:52'!
registerPosition: aPosition
	self subclassResponsibility ! !

!RoverObserver methodsFor: 'operations' stamp: 'sc 6/5/2021 22:59:28'!
update
	self subclassResponsibility ! !


!classDefinition: #Log category: 'MarsRover-WithHeading'!
RoverObserver subclass: #Log
	instanceVariableNames: 'changesRegister lastKnownPosition lastKnownDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Log methodsFor: 'initialization' stamp: 'sc 6/5/2021 23:18:54'!
initializeWith: aMarsRover 
	aMarsRover add:  self.
	rover := aMarsRover.
	changesRegister := OrderedCollection new.! !

!Log methodsFor: 'initialization' stamp: 'sc 6/5/2021 23:10:52'!
provideStartingPosition: aPosition andDirection: aDirection
	lastKnownPosition _ aPosition .
	lastKnownDirection _ aDirection.! !


!Log methodsFor: 'operations' stamp: 'sc 6/4/2021 10:35:02'!
at: aPosition
	^changesRegister at: aPosition.! !

!Log methodsFor: 'operations' stamp: 'sc 6/5/2021 23:26:44'!
registerDirection: aDirection
	lastKnownDirection = aDirection ifFalse:[
		changesRegister add: aDirection asString.
		lastKnownDirection := aDirection.
		]! !

!Log methodsFor: 'operations' stamp: 'sc 6/5/2021 23:32:39'!
registerPosition: aPosition.
	lastKnownPosition = aPosition ifFalse:[
		changesRegister add: aPosition asString.
		lastKnownPosition  := aPosition
		]
	! !

!Log methodsFor: 'operations' stamp: 'sc 6/4/2021 10:32:30'!
size
	^changesRegister size ! !

!Log methodsFor: 'operations' stamp: 'sc 6/5/2021 23:30:34'!
update
	rover updateObserverDirection: self.
	rover updateObserverPosition: self.! !


!Log methodsFor: 'testing' stamp: 'sc 6/4/2021 10:32:30'!
isEmpty
	^changesRegister isEmpty .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Log class' category: 'MarsRover-WithHeading'!
Log class
	instanceVariableNames: ''!

!Log class methodsFor: 'instance creation' stamp: 'sc 6/3/2021 20:44:49'!
newWith: aMarsRover 
	^self new initializeWith: aMarsRover.! !


!classDefinition: #DirectionLog category: 'MarsRover-WithHeading'!
Log subclass: #DirectionLog
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!DirectionLog methodsFor: 'operations' stamp: 'sc 6/5/2021 23:27:08'!
registerPosition: aDirection
	self shouldNotHappen! !

!DirectionLog methodsFor: 'operations' stamp: 'sc 6/5/2021 23:31:17'!
update
	rover updateObserverDirection: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DirectionLog class' category: 'MarsRover-WithHeading'!
DirectionLog class
	instanceVariableNames: ''!

!DirectionLog class methodsFor: 'as yet unclassified' stamp: 'sc 6/4/2021 10:06:16'!
newWith: aMarsRover.
	^self new initializeWith: aMarsRover.
! !


!classDefinition: #PositionLog category: 'MarsRover-WithHeading'!
Log subclass: #PositionLog
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionLog methodsFor: 'operations' stamp: 'sc 6/5/2021 23:26:44'!
registerDirection: aDirection
	self shouldNotHappen! !

!PositionLog methodsFor: 'operations' stamp: 'sc 6/5/2021 23:30:59'!
update
	rover updateObserverPosition: self.! !


!classDefinition: #RoverWindow category: 'MarsRover-WithHeading'!
RoverObserver subclass: #RoverWindow
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!RoverWindow methodsFor: 'operations' stamp: 'sc 6/5/2021 11:21:35'!
direction
	 ^ direction ! !

!RoverWindow methodsFor: 'operations' stamp: 'sc 6/5/2021 11:07:12'!
position
	^position ! !

!RoverWindow methodsFor: 'operations' stamp: 'sc 6/5/2021 23:25:28'!
provideStartingPosition:aPosition andDirection: aDirection
	self registerDirection: aDirection .
	self registerPosition: aPosition.! !

!RoverWindow methodsFor: 'operations' stamp: 'sc 6/5/2021 23:24:52'!
registerDirection: aDirection
	direction _ aDirection ! !

!RoverWindow methodsFor: 'operations' stamp: 'sc 6/5/2021 23:25:28'!
registerPosition: aPosition
	position _ aPosition ! !

!RoverWindow methodsFor: 'operations' stamp: 'sc 6/5/2021 23:29:35'!
update
	rover updateObserverPosition: self.
	rover updateObserverDirection: self.! !


!RoverWindow methodsFor: 'initialization' stamp: 'sc 6/5/2021 23:18:17'!
initializeWith: aMarsRover 
	rover _ aMarsRover.
	aMarsRover add: self.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverWindow class' category: 'MarsRover-WithHeading'!
RoverWindow class
	instanceVariableNames: ''!

!RoverWindow class methodsFor: 'instance creation' stamp: 'sc 6/5/2021 10:57:31'!
newWith: aMarsRover 
	^self new initializeWith: aMarsRover ! !


!classDefinition: #RoverDirectionWindow category: 'MarsRover-WithHeading'!
RoverWindow subclass: #RoverDirectionWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!RoverDirectionWindow methodsFor: 'operations' stamp: 'sc 6/5/2021 23:24:52'!
provideStartingPosition:aPosition andDirection: aDirection
	self registerDirection: aDirection .! !

!RoverDirectionWindow methodsFor: 'operations' stamp: 'sc 6/5/2021 23:25:28'!
registerPosition: aPosition
	self shouldNotHappen ! !

!RoverDirectionWindow methodsFor: 'operations' stamp: 'sc 6/5/2021 23:29:17'!
update
	rover updateObserverDirection: self.! !


!classDefinition: #RoverPositionWindow category: 'MarsRover-WithHeading'!
RoverWindow subclass: #RoverPositionWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!RoverPositionWindow methodsFor: 'operations' stamp: 'sc 6/5/2021 23:25:28'!
provideStartingPosition:aPosition andDirection: aDirection
	self registerPosition: aPosition.! !

!RoverPositionWindow methodsFor: 'operations' stamp: 'sc 6/5/2021 23:24:52'!
registerDirection: aCardinalPoint
	self shouldNotHappen ! !

!RoverPositionWindow methodsFor: 'operations' stamp: 'sc 6/5/2021 23:29:35'!
update
	rover updateObserverPosition: self. ! !
