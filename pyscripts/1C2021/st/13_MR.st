!classDefinition: #MarsRoverTests category: 'ejercicio_mars_rover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ejercicio_mars_rover'!

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'sc 5/15/2021 12:12:45'!
test01
|rover where|
	rover := MarsRover at: (0@0) facing: North.
	rover process: ''. "decidimos arrancar testeando el comportamiento."
	where := rover position.
	self assert: where equals: (0@0).
	
	
	
	
	! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'sc 5/15/2021 12:12:45'!
test02RoverSabeProcesarCaracterF
|rover where|
	rover := MarsRover at: (0@0) facing: North.
	rover process: 'f'. "decidimos arrancar testeando el comportamiento."
	where := rover position.
	self assert: where equals: (0@1).
	
	
	
	
	! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'sc 5/15/2021 12:12:45'!
test03RoverSabeProcesarCaracterB
|rover where|
	rover := MarsRover at: (0@0) facing: North.
	rover process: 'b'. "decidimos arrancar testeando el comportamiento."
	where := rover position.
	self assert: where equals: (0@-1).
	
	
	
	
	! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'sc 5/15/2021 10:24:37'!
test04noRotaConLaCadenaVacia
|rover roverDirection|
	rover := MarsRover at: (0@0) facing: North.
	rover process: ''.
	roverDirection := rover direction.
	self assert: roverDirection class equals: (North).
	
	
	
	! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'sc 5/15/2021 10:24:30'!
test05RoverCulminaMirandoAlEsteSiIniciaMirandoAlNorteYRotaHaciaLaDerecha
|rover roverDirection|
	rover := MarsRover at: (0@0) facing: North.
	rover process: 'r'.
	roverDirection := rover direction.
	self assert: roverDirection class equals: (East).
	
	
	
	! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'sc 5/15/2021 10:24:21'!
test06RoverCulminaMirandoAlOesteSiIniciaMirandoAlNorteYRotaHaciaLaIzquierda
	|rover roverDirection|
	rover := MarsRover at: (0@0) facing: North.
	rover process: 'l'.
	roverDirection := rover direction.
	self assert: roverDirection class equals: (West).
	
	
	
	! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'sc 5/15/2021 10:24:10'!
test07RoverCulminaMirandoAlSurSiIniciaMirandoAlEsteYRotaHaciaLaDerecha
	|rover roverDirection|
	rover := MarsRover at: (0@0) facing: East.
	rover process: 'r'.
	roverDirection := rover direction.
	self assert: roverDirection class equals: (South).
	
	
	
	! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'sc 5/15/2021 10:23:58'!
test08RoverCulminaMirandoAlOesteSiIniciaMirandoAlSurYRotaHaciaLaDerecha
	|rover roverDirection|
	rover := MarsRover at: (0@0) facing: South.
	rover process: 'r'.
	roverDirection := rover direction.
	self assert: roverDirection class equals: (West).
	
	
	
	! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'sc 5/15/2021 10:23:32'!
test09RoverCulminaMirandoAlNorteSiIniciaMirandoAlOesteYRotaHaciaLaDerecha
	|rover roverDirection|
	rover := MarsRover at: (0@0) facing: West.
	rover process: 'r'.
	roverDirection := rover direction.
	self assert: roverDirection class equals: (North).
	"Proponemos un refactoring. Vamos a usar otra forma de puntos cardinales"
	
	
	
	! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'sc 5/15/2021 10:28:30'!
test10RoverCulminaMirandoAlNorteSiIniciaMirandoAlOesteYRotaHaciaLaIzquierda
	|rover roverDirection|
	rover := MarsRover at: (0@0) facing: West.
	rover process: 'l'.
	roverDirection := rover direction.
	self assert: roverDirection class equals: (South).
	
	
	
	! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'sc 5/15/2021 12:12:45'!
test11RoverSeMueveDosVecesHaciaAdelanteSiLlegaStrinFF
	|rover roverPoint|
	rover := MarsRover at: (0@0) facing: North.
	rover process: 'ff'.
	roverPoint := rover position.
	self assert: roverPoint equals: (0@2).
	
	
	
	! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'sc 5/15/2021 12:12:45'!
test12RoverSeMueveTresVecesHaciaAdelanteSiLlegaStrinFFF
	|rover roverPoint|
	rover := MarsRover at: (0@0) facing: North.
	rover process: 'fff'.
	roverPoint := rover position.
	self assert: roverPoint equals: (0@3).
	
	
	
	! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'sc 5/15/2021 12:12:45'!
test13RoverSeMueveCuatroVecesHaciaAdelanteSiLlegaStringFFFF
	|rover roverPoint|
	rover := MarsRover at: (0@0) facing: North.
	rover process: 'ffff'.
	roverPoint := rover position.
	self assert: roverPoint equals: (0@4).
	
	
	
	! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'sc 5/15/2021 12:12:45'!
test14RoverSeMueveHaciaLaDerechaSiComienzaAlNorteYLlegaStringRF
	|rover roverPoint|
	rover := MarsRover at: (0@0) facing: North.
	rover process: 'rf'.
	roverPoint := rover position.
	self assert: roverPoint equals: (1@0).! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'sc 5/15/2021 12:12:45'!
test15RoverSeMueveHaciaAtrasSiComienzaAlNorteYLlegaStringRRF
	|rover roverPoint|
	rover := MarsRover at: (0@0) facing: North.
	rover process: 'rrf'.
	roverPoint := rover position.
	self assert: roverPoint equals: (0@-1).! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'sc 5/15/2021 12:12:45'!
test16RoverSeMueveHaciaLaIzquierdaSiComienzaAlNorteYLlegaStringRRRF
	|rover roverPoint|
	rover := MarsRover at: (0@0) facing: North.
	rover process: 'rrrf'.
	roverPoint := rover position.
	self assert: roverPoint equals: (-1@0).! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'sc 5/15/2021 12:12:45'!
test17RoverSeMueveHaciaLaDerechaSiComienzaAlNorteYLlegaStringRRRB
	|rover roverPoint|
	rover := MarsRover at: (0@0) facing: North.
	rover process: 'rrrb'.
	roverPoint := rover position.
	self assert: roverPoint equals: (1@0).! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'sc 5/15/2021 12:12:45'!
test18RoverSeMueveHaciaAdelanteSiComienzaAlNorteYLlegaStringRRB
	|rover roverPoint|
	rover := MarsRover at: (0@0) facing: North.
	rover process: 'rrb'.
	roverPoint := rover position.
	self assert: roverPoint equals: (0@1).! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'sc 5/15/2021 12:12:45'!
test19RoverSeMueveHaciaIzquierdaSiComienzaAlNorteYLlegaStringRB
	|rover roverPoint|
	rover := MarsRover at: (0@0) facing: North.
	rover process: 'rb'.
	roverPoint := rover position.
	self assert: roverPoint equals: (-1@0).
	"Acá hacemos un nuevo refactoring"! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'sc 5/15/2021 12:12:45'!
test20NoSeMueveConUnComandoErroneo
	|rover roverPoint roverDirection|
	rover := MarsRover at: (0@0) facing: North.
	rover process: 'z'.
	roverPoint := rover position.
	roverDirection := rover direction.
	self assert: roverPoint equals: (0@0).
	self assert: roverDirection class equals: North .! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'sc 5/15/2021 12:12:45'!
test21RoverDetieneSuEjecucionAnteUnComandoErroneo
	|rover roverPoint roverDirection|
	rover := MarsRover at: (0@0) facing: North.
	rover process: 'rzr'.
	roverPoint := rover position.
	roverDirection := rover direction.
	self assert: roverPoint equals: (0@0).
	self assert: roverDirection class equals: East.! !

!MarsRoverTests methodsFor: 'as yet unclassified' stamp: 'sc 5/15/2021 12:12:45'!
test22RoverDetieneSuEjecucionAnteOtroComandoErroneo
	|rover roverPoint roverDirection|
	rover := MarsRover at: (0@0) facing: South.
	rover process: 'rxxr'.
	roverPoint := rover position.
	roverDirection := rover direction.
	self assert: roverPoint equals: (0@0).
	self assert: roverDirection class equals: West.! !


!classDefinition: #MarsRover category: 'ejercicio_mars_rover'!
Object subclass: #MarsRover
	instanceVariableNames: 'point direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ejercicio_mars_rover'!

!MarsRover methodsFor: 'initialize' stamp: 'sc 5/15/2021 09:13:58'!
initializeAt: aPoint facing: aDirection 
	point := aPoint.
	direction := aDirection.! !


!MarsRover methodsFor: 'actions' stamp: 'sc 5/15/2021 12:09:36'!
process: anIinstructionSequence
	|comandosValidos|
	comandosValidos := OrderedCollection with: $f with: $b with: $l with: $r.
	anIinstructionSequence do: [:anInstructionCharacter | 
						   (comandosValidos includes: anInstructionCharacter) ifFalse: [^ self].
						   self processInstruction: anInstructionCharacter].
	! !

!MarsRover methodsFor: 'actions' stamp: 'sc 5/15/2021 11:50:12'!
processInstruction: anInstruction
	anInstruction = $f ifTrue: [point := point + (direction FowardDirectionFor: self)].
	anInstruction = $b ifTrue: [point := point + (direction BackwardsDirectionFor: self)].
					
	anInstruction = $r ifTrue: [direction := direction pointAt90DegreesRight].
	anInstruction = $l ifTrue: [direction := direction pointAt90DegreesLeft]! !


!MarsRover methodsFor: 'accessing' stamp: 'sc 5/15/2021 09:29:35'!
direction
	^direction! !

!MarsRover methodsFor: 'accessing' stamp: 'sc 5/15/2021 12:12:44'!
position
	^point! !


!MarsRover methodsFor: 'movements' stamp: 'sc 5/15/2021 11:42:51'!
EastBackwards
	^(-1@0).! !

!MarsRover methodsFor: 'movements' stamp: 'sc 5/15/2021 11:36:22'!
EastForward
	^(1@0).! !

!MarsRover methodsFor: 'movements' stamp: 'sc 5/15/2021 11:42:39'!
NorthBackwards
	^(0@-1).! !

!MarsRover methodsFor: 'movements' stamp: 'sc 5/15/2021 11:36:32'!
NorthForward
	^(0@1).! !

!MarsRover methodsFor: 'movements' stamp: 'sc 5/15/2021 11:42:28'!
SouthBackwards
	^(0@1).! !

!MarsRover methodsFor: 'movements' stamp: 'sc 5/15/2021 11:36:45'!
SouthForward
	^(0@-1).! !

!MarsRover methodsFor: 'movements' stamp: 'sc 5/15/2021 11:42:00'!
WestBackwards
	^(1@0).! !

!MarsRover methodsFor: 'movements' stamp: 'sc 5/15/2021 11:36:15'!
WestForward
	^(-1@0).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'ejercicio_mars_rover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'sc 5/15/2021 10:15:47'!
at: aPoint facing: aDirection
	^self new initializeAt: aPoint facing: aDirection new! !


!classDefinition: #MarsRoverCardinalDirection category: 'ejercicio_mars_rover'!
Object subclass: #MarsRoverCardinalDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ejercicio_mars_rover'!

!MarsRoverCardinalDirection methodsFor: 'movement' stamp: 'sc 5/15/2021 11:45:16'!
BackwardsDirectionFor: rover
	self subclassResponsibility ! !

!MarsRoverCardinalDirection methodsFor: 'movement' stamp: 'sc 5/15/2021 11:44:36'!
FowardDirectionFor: rover
	self subclassResponsibility ! !


!MarsRoverCardinalDirection methodsFor: 'rotating' stamp: 'sc 5/15/2021 10:06:26'!
pointAt90DegreesLeft
                         self subclassResponsibility ! !

!MarsRoverCardinalDirection methodsFor: 'rotating' stamp: 'sc 5/15/2021 10:05:35'!
pointAt90DegreesRight
                         self subclassResponsibility ! !


!classDefinition: #East category: 'ejercicio_mars_rover'!
MarsRoverCardinalDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ejercicio_mars_rover'!

!East methodsFor: 'rotating' stamp: 'sc 5/15/2021 10:07:28'!
pointAt90DegreesLeft
                         ^North new! !

!East methodsFor: 'rotating' stamp: 'sc 5/15/2021 10:07:44'!
pointAt90DegreesRight
                         ^South new! !


!East methodsFor: 'movement' stamp: 'sc 5/15/2021 11:45:32'!
BackwardsDirectionFor: rover
	^rover EastBackwards .! !

!East methodsFor: 'movement' stamp: 'sc 5/15/2021 11:44:00'!
FowardDirectionFor: rover
	^rover EastForward.! !


!classDefinition: #North category: 'ejercicio_mars_rover'!
MarsRoverCardinalDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ejercicio_mars_rover'!

!North methodsFor: 'movement' stamp: 'sc 5/15/2021 11:48:01'!
BackwardsDirectionFor: rover
	^rover NorthBackwards .! !

!North methodsFor: 'movement' stamp: 'sc 5/15/2021 11:47:23'!
FowardDirectionFor: rover
	^rover NorthForward.! !


!North methodsFor: 'rotating' stamp: 'sc 5/15/2021 10:08:23'!
pointAt90DegreesLeft
                         ^West new! !

!North methodsFor: 'rotating' stamp: 'sc 5/15/2021 10:08:36'!
pointAt90DegreesRight
                         ^East new! !


!classDefinition: #South category: 'ejercicio_mars_rover'!
MarsRoverCardinalDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ejercicio_mars_rover'!

!South methodsFor: 'rotating' stamp: 'sc 5/15/2021 10:09:32'!
pointAt90DegreesLeft
                         ^East new! !

!South methodsFor: 'rotating' stamp: 'sc 5/15/2021 10:09:23'!
pointAt90DegreesRight
                         ^West new! !


!South methodsFor: 'movement' stamp: 'sc 5/15/2021 11:48:16'!
BackwardsDirectionFor: rover
	^rover SouthBackwards .! !

!South methodsFor: 'movement' stamp: 'sc 5/15/2021 11:47:24'!
FowardDirectionFor: rover
	^rover SouthForward.! !


!classDefinition: #West category: 'ejercicio_mars_rover'!
MarsRoverCardinalDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ejercicio_mars_rover'!

!West methodsFor: 'movement' stamp: 'sc 5/15/2021 11:52:00'!
BackwardsDirectionFor: rover
	^rover WestBackwards .! !

!West methodsFor: 'movement' stamp: 'sc 5/15/2021 11:47:23'!
FowardDirectionFor: rover
	^rover WestForward.! !


!West methodsFor: 'rotating' stamp: 'sc 5/15/2021 10:17:41'!
pointAt90DegreesLeft
                         ^South new! !

!West methodsFor: 'rotating' stamp: 'sc 5/15/2021 10:17:33'!
pointAt90DegreesRight
                         ^North new! !
