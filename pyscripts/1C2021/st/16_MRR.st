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


!classDefinition: #TestObservers category: 'MarsRover-WithHeading'!
TestCase subclass: #TestObservers
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!TestObservers methodsFor: 'tests log' stamp: 'ja 6/6/2021 17:49:21'!
test01LogWhitoutProcessingAnyCommand

	| marsRover log |
	
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	log _ Log new.
	
	marsRover addPositionObserverFor: log.   
	marsRover addHeadingObserverFor: log.
	
	self assert: 0 equals: log size.
	
	! !

!TestObservers methodsFor: 'tests log' stamp: 'ja 6/6/2021 17:49:21'!
test02LogForPositionProcessingOnePositionCommand

	| marsRover log |
	
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	log _ Log new.
	
	marsRover addPositionObserverFor: log.   

	marsRover process: 'f'.
	
	self assert: 1 equals: log size.
	self assert: '1@2' equals: log value first.
	
	! !

!TestObservers methodsFor: 'tests log' stamp: 'ja 6/6/2021 17:49:21'!
test03LogForPositionProcessingOnlyPositionCommands

	| marsRover log |
	
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	log _ Log new.
	
	marsRover addPositionObserverFor: log.   

	marsRover process: 'ff'.
	
	self assert: 2 equals: log size.
	self assert: '1@2' equals: log value first.
	self assert: '1@3' equals: log value second.	
	! !

!TestObservers methodsFor: 'tests log' stamp: 'ja 6/6/2021 17:49:21'!
test04LogForPositionProcessingManyCommands

	| marsRover log |
	
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	log _ Log new.
	
	marsRover addPositionObserverFor: log.   

	marsRover process: 'fbrfb'.
	
	self assert: 4 equals: log size.
	self assert: '1@2' equals: log value first.
	self assert: '1@1' equals: log value second.	
	self assert: '2@1' equals: log value third.	
	self assert: '1@1' equals: log value fourth.		
	
	! !

!TestObservers methodsFor: 'tests log' stamp: 'ja 6/6/2021 17:48:54'!
test05LogForHeadingProcessingOneHeadingCommand

	| marsRover log |
	
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	log _ Log new.
	
	marsRover addHeadingObserverFor: log.   

	marsRover process: 'r'.
	
	self assert: 1 equals: log size.
	self assert: 'East' equals: log value first.
	
	! !

!TestObservers methodsFor: 'tests log' stamp: 'ja 6/6/2021 17:48:54'!
test06LogForHeadingProcessingManyCommands

	| marsRover log |
	
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	log _ Log new.
	
	marsRover addHeadingObserverFor: log.   

	marsRover process: 'rrrfrl'.
	
	self assert: 5 equals: log size.
	self assert: 'East' equals: log value first.
	self assert: 'South' equals: log value second .
	self assert: 'West' equals: log value third .
	self assert: 'North' equals: log value fourth .			
	self assert: 'West' equals: log value fifth.	
	
	! !

!TestObservers methodsFor: 'tests log' stamp: 'ja 6/6/2021 17:49:21'!
test07LogForPositionAndHeadingProcessingManyCommands

	| marsRover log |
	
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	log _ Log new.
	
	marsRover addPositionObserverFor: log.
	marsRover addHeadingObserverFor: log.   

	marsRover process: 'frbrbrfrl'.
	
	self assert: 9 equals: log size.
	self assert: '1@2' equals: log value first.
	self assert: 'East' equals: log value second.
	self assert: '0@2' equals: log value third.
	self assert: 'South' equals: log value fourth.
	self assert: '0@3' equals: log value fifth.			
	self assert: 'West' equals: log value sixth.	
	self assert: '-1@3' equals: log value seventh.	
	self assert: 'North' equals: log value eighth.	
	self assert: 'West' equals: log value ninth.		
	! !


!TestObservers methodsFor: 'tests window' stamp: 'ja 6/6/2021 17:51:42'!
test08WindowWithoutProcessingAnyCommand

	| marsRover window |
	
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	window _ Window new.
	
	marsRover addPositionObserverFor: window.
	marsRover addHeadingObserverFor: window.
	
	self assert: '' equals: window value.	
	
	
	! !

!TestObservers methodsFor: 'tests window' stamp: 'ja 6/6/2021 17:51:54'!
test09WindowForPositionProcessingOnePositionCommand

	| marsRover window |
	
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	window _ Window new.
	
	marsRover addPositionObserverFor: window .
	marsRover process: 'f'.
	
	self assert: '1@2' equals: window value.	
	
	
	! !

!TestObservers methodsFor: 'tests window' stamp: 'ja 6/6/2021 17:52:08'!
test10WindowForPositionProcessingOnlyPositionCommandsHeadingNorth

	| marsRover window |
	
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	window _ Window new.
	
	marsRover addPositionObserverFor: window .
	marsRover process: 'ffb'.
	
	self assert: '1@2' equals: window value.	
	
	
	! !

!TestObservers methodsFor: 'tests window' stamp: 'ja 6/6/2021 17:52:14'!
test11WindowForPositionProcessingOnlyPositionCommandsHeadingEast

	| marsRover window |
	
	marsRover _ MarsRover at: 1@1 heading: #East.
	
	window _ Window new.
	
	marsRover addPositionObserverFor: window .
	marsRover process: 'ffb'.
	
	self assert: '2@1' equals: window value.	
	
	
	! !

!TestObservers methodsFor: 'tests window' stamp: 'ja 6/6/2021 17:52:19'!
test12WindowForPositionProcessingOnlyPositionCommandsHeadingSouth

	| marsRover window |
	
	marsRover _ MarsRover at: 1@1 heading: #South.
	
	window _ Window new.
	
	marsRover addPositionObserverFor: window .
	marsRover process: 'ffb'.
	
	self assert: '1@0' equals: window value.	
	
	
	! !

!TestObservers methodsFor: 'tests window' stamp: 'ja 6/6/2021 17:52:24'!
test13WindowForPositionProcessingOnlyPositionCommandsHeadingWest

	| marsRover window |
	
	marsRover _ MarsRover at: 1@1 heading: #West.
	
	window _ Window new.
	
	marsRover addPositionObserverFor: window .
	marsRover process: 'ffb'.
	
	self assert: '0@1' equals: window value.	
	
	
	! !

!TestObservers methodsFor: 'tests window' stamp: 'ja 6/6/2021 17:52:30'!
test14WindowForPositionProcessingManyCommands

	| marsRover window |
	
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	window _ Window new.
	
	marsRover addPositionObserverFor: window .
	marsRover process: 'frb'.
	
	self assert: '0@2' equals: window value.	
	
	
	! !

!TestObservers methodsFor: 'tests window' stamp: 'ja 6/6/2021 17:52:38'!
test15WindowForHeadingProcessingOneHeadingCommand

	| marsRover window |
	
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	window _ Window new.
	
	marsRover addHeadingObserverFor: window .
	marsRover process: 'r'.
	
	self assert: 'East' equals: window value.	
	
	
	! !

!TestObservers methodsFor: 'tests window' stamp: 'ja 6/6/2021 17:52:43'!
test16WindowForHeadingProcessingOnlyHeadingCommandsEndingNorth

	| marsRover window |
	
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	window _ Window new.
	
	marsRover addHeadingObserverFor: window .
	marsRover process: 'rl'.
	
	self assert: 'North' equals: window value.	
	
	
	! !

!TestObservers methodsFor: 'tests window' stamp: 'ja 6/6/2021 17:52:51'!
test17WindowForHeadingProcessingOnlyHeadingCommandsEndingEast

	| marsRover window |
	
	marsRover _ MarsRover at: 1@1 heading: #East.
	
	window _ Window new.
	
	marsRover addHeadingObserverFor: window .
	marsRover process: 'rl'.
	
	self assert: 'East' equals: window value.	
	
	
	! !

!TestObservers methodsFor: 'tests window' stamp: 'ja 6/6/2021 17:52:55'!
test18WindowForHeadingProcessingOnlyHeadingCommandsEndingSouth

	| marsRover window |
	
	marsRover _ MarsRover at: 1@1 heading: #South.
	
	window _ Window new.
	
	marsRover addHeadingObserverFor: window .
	marsRover process: 'rl'.
	
	self assert: 'South' equals: window value.	
	
	
	! !

!TestObservers methodsFor: 'tests window' stamp: 'ja 6/6/2021 17:52:58'!
test19WindowForHeadingProcessingOnlyHeadingCommandsEndingWest

	| marsRover window |
	
	marsRover _ MarsRover at: 1@1 heading: #West.
	
	window _ Window new.
	
	marsRover addHeadingObserverFor: window .
	marsRover process: 'rl'.
	
	self assert: 'West' equals: window value.	
	
	
	! !

!TestObservers methodsFor: 'tests window' stamp: 'ja 6/6/2021 17:53:03'!
test20WindowForHeadingProcessingManyCommands

	| marsRover window |
	
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	window _ Window new.
	
	marsRover addHeadingObserverFor: window .
	marsRover process: 'rrfl'.
	
	self assert: 'East' equals: window value.	
	
	
	! !

!TestObservers methodsFor: 'tests window' stamp: 'ja 6/6/2021 17:53:08'!
test21WindowForPositionAndHeadingProcessingManyCommands

	| marsRover window |
	
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	window _ Window new.
	
	marsRover addPositionObserverFor: window.
	marsRover addHeadingObserverFor: window.
	marsRover process: 'rrflb'.
	
	self assert: '0@0 East' equals: window value.	
	
	
	! !


!TestObservers methodsFor: 'tests log-window' stamp: 'ja 6/6/2021 17:53:26'!
test22LogAndWindowWithoutProcessingAnyCommand

	| marsRover window log |
	
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	log _ Log new.
	window _ Window new.
	
	marsRover addPositionObserverFor: log.
	marsRover addHeadingObserverFor: log.
	marsRover addPositionObserverFor: window.
	marsRover addHeadingObserverFor: window.
	
	self assert: 0 equals: log size.
	self assert: '' equals: window value.	
	
	
	! !

!TestObservers methodsFor: 'tests log-window' stamp: 'ja 6/6/2021 17:53:38'!
test23LogForPositionAndWindowForPosition

	| marsRover window log |
	
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	log _ Log new.
	window _ Window new.
	
	marsRover addPositionObserverFor: log.
	marsRover addPositionObserverFor: window.
	
	marsRover process: 'fr'.
	
	self assert: 1 equals: log size.
	self assert: '1@2' equals: log value first.
	self assert: '1@2' equals: window value.	
	
	
	! !

!TestObservers methodsFor: 'tests log-window' stamp: 'ja 6/6/2021 17:49:21'!
test24LogForPositionAndWindowForHeading

	| marsRover window log |
	
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	log _ Log new.
	window _ Window new.
	
	marsRover addPositionObserverFor: log.
	marsRover addHeadingObserverFor: window.
	
	marsRover process: 'fr'.
	
	self assert: 1 equals: log size.
	self assert: '1@2' equals: log value first.
	self assert: 'East' equals: window value.	
	
	
	! !

!TestObservers methodsFor: 'tests log-window' stamp: 'ja 6/6/2021 17:49:21'!
test25LogForHeadingAndWindowForPosition

	| marsRover window log |
	
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	log _ Log new.
	window _ Window new.
	
	marsRover addHeadingObserverFor: log.
	marsRover addPositionObserverFor: window.
	
	marsRover process: 'fr'.
	
	self assert: 1 equals: log size.
	self assert: 'East' equals: log value first.
	self assert: '1@2' equals: window value.	
	
	
	! !

!TestObservers methodsFor: 'tests log-window' stamp: 'ja 6/6/2021 17:48:54'!
test26LogForHeadingAndWindowForHeading

	| marsRover window log |
	
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	log _ Log new.
	window _ Window new.
	
	marsRover addHeadingObserverFor: log.
	marsRover addHeadingObserverFor: window.
	
	marsRover process: 'fr'.
	
	self assert: 1 equals: log size.
	self assert: 'East' equals: log value first.
	self assert: 'East' equals: window value.	
	
	
	! !

!TestObservers methodsFor: 'tests log-window' stamp: 'ja 6/6/2021 17:49:21'!
test27LogForPositionAndHeadingAndWindowForHeading

	| marsRover window log |
	
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	log _ Log new.
	window _ Window new.
	
	marsRover addPositionObserverFor: log.
	marsRover addHeadingObserverFor: log.
	marsRover addHeadingObserverFor: window.
	
	marsRover process: 'fr'.
	
	self assert: 2 equals: log size.
	self assert: '1@2' equals: log value first.
	self assert: 'East' equals: log value second .
	self assert: 'East' equals: window value.	
	
	
	! !

!TestObservers methodsFor: 'tests log-window' stamp: 'ja 6/6/2021 17:49:21'!
test28LogForPositionAndHeadingAndWindowForPosition

	| marsRover window log |
	
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	log _ Log new.
	window _ Window new.
	
	marsRover addPositionObserverFor: log.
	marsRover addHeadingObserverFor: log.
	marsRover addPositionObserverFor: window.
	
	marsRover process: 'fr'.
	
	self assert: 2 equals: log size.
	self assert: '1@2' equals: log value first.
	self assert: 'East' equals: log value second .
	self assert: '1@2' equals: window value.	
	
	
	! !

!TestObservers methodsFor: 'tests log-window' stamp: 'ja 6/6/2021 17:49:21'!
test29LogForPositionAndWindowForPositionAndHeading

	| marsRover window log |
	
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	log _ Log new.
	window _ Window new.
	
	marsRover addPositionObserverFor: log.
	marsRover addPositionObserverFor: window.
	marsRover addHeadingObserverFor: window.
	
	marsRover process: 'fr'.
	
	self assert: 1 equals: log size.
	self assert: '1@2' equals: log value first.
	self assert: '1@2 East' equals: window value.	
	
	
	! !

!TestObservers methodsFor: 'tests log-window' stamp: 'ja 6/6/2021 17:49:21'!
test30LogForHeadingAndWindowForPositionAndHeading

	| marsRover window log |
	
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	log _ Log new.
	window _ Window new.
	
	marsRover addHeadingObserverFor: log.
	marsRover addPositionObserverFor: window.
	marsRover addHeadingObserverFor: window.
	
	marsRover process: 'fr'.
	
	self assert: 1 equals: log size.
	self assert: 'East' equals: log value first.
	self assert: '1@2 East' equals: window value.	
	
	
	! !

!TestObservers methodsFor: 'tests log-window' stamp: 'ja 6/6/2021 17:49:21'!
test31LogForPositionAndHeadingAndWindowForPositionAndHeading

	| marsRover window log |
	
	marsRover _ MarsRover at: 1@1 heading: #North.
	
	log _ Log new.
	window _ Window new.
	
	marsRover addPositionObserverFor: log.
	marsRover addHeadingObserverFor: log.
	marsRover addPositionObserverFor: window.
	marsRover addHeadingObserverFor: window.
	
	marsRover process: 'fr'.
	
	self assert: 2 equals: log size.
	self assert: '1@2' equals: log value first.
	self assert: 'East' equals: log value second.
	self assert: '1@2 East' equals: window value.	
	
	
	! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'ja 6/5/2021 17:32:50'!
initializeAt: aPosition heading: aHeading

	position := aPosition.
	head := aHeading.
	observers _ OrderedCollection new.
	! !


!MarsRover methodsFor: 'heading' stamp: 'ja 6/5/2021 17:36:29'!
headEast
	
	head := MarsRoverHeadingEast new.
	self notifyHeading .! !

!MarsRover methodsFor: 'heading' stamp: 'ja 6/5/2021 17:36:36'!
headNorth
	
	head := MarsRoverHeadingNorth new.
	self notifyHeading .! !

!MarsRover methodsFor: 'heading' stamp: 'ja 6/5/2021 17:36:41'!
headSouth
	
	head := MarsRoverHeadingSouth new.
	self notifyHeading .
	
	! !

!MarsRover methodsFor: 'heading' stamp: 'ja 6/5/2021 17:36:46'!
headWest
	
	head := MarsRoverHeadingWest new.
	self notifyHeading .
	! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:07:11'!
rotateLeft
	
	head rotateLeft: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:14:00'!
rotateRight
	
	head rotateRight: self! !


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


!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:20'!
moveBackward
	
	head moveBackward: self! !

!MarsRover methodsFor: 'moving' stamp: 'ja 6/5/2021 17:35:58'!
moveEast
	
	position := position + (1@0).
	self notifyPosition.! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:55'!
moveForward
	
	head moveForward: self! !

!MarsRover methodsFor: 'moving' stamp: 'ja 6/5/2021 17:35:58'!
moveNorth
	
	position := position + (0@1).
	self notifyPosition.! !

!MarsRover methodsFor: 'moving' stamp: 'ja 6/5/2021 17:35:58'!
moveSouth
	
	position := position + (0@-1).
	self notifyPosition.! !

!MarsRover methodsFor: 'moving' stamp: 'ja 6/5/2021 17:35:58'!
moveWest
	
	position := position + (-1@0).
	self notifyPosition.! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'ja 6/3/2021 20:51:01'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].
	
	self signalInvalidCommand.! !


!MarsRover methodsFor: 'tracking' stamp: 'ja 6/6/2021 17:50:13'!
addHeadingObserverFor: aMarsRoverTracking 
	
	observers add: aMarsRoverTracking createObserverHeading.! !

!MarsRover methodsFor: 'tracking' stamp: 'ja 6/6/2021 17:50:05'!
addPositionObserverFor: aMarsRoverTracking 
	
	observers add: aMarsRoverTracking createObserverPosition.! !

!MarsRover methodsFor: 'tracking' stamp: 'ja 6/6/2021 15:47:11'!
notifyHeading

	observers do: [:anObserver | anObserver updateHeading: head]! !

!MarsRover methodsFor: 'tracking' stamp: 'ja 6/5/2021 18:42:04'!
notifyPosition

	observers do: [:anObserver | anObserver updatePosition: position]! !

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

!MarsRoverHeading methodsFor: 'heading' stamp: 'ja 6/6/2021 15:46:56'!
heading
	
	self subclassResponsibility ! !

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


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'ja 6/6/2021 15:46:05'!
heading
	
	^'East'! !

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


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'ja 6/6/2021 15:46:45'!
heading
	
	^'North'! !

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


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'ja 6/6/2021 15:46:36'!
heading
	
	^'South'! !

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


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'ja 6/6/2021 15:46:27'!
heading
	
	^'West'! !

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


!classDefinition: #MarsRoverTracking category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverTracking
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTracking methodsFor: 'initialization' stamp: 'ja 6/6/2021 16:53:25'!
initialize

	self subclassResponsibility ! !


!MarsRoverTracking methodsFor: 'observer creation' stamp: 'ja 6/6/2021 16:52:49'!
createObserverHeading

	^ ObserverHeading with: self! !

!MarsRoverTracking methodsFor: 'observer creation' stamp: 'ja 6/6/2021 16:52:58'!
createObserverPosition

	^ ObserverPosition with: self! !


!MarsRoverTracking methodsFor: 'update' stamp: 'ja 6/6/2021 16:53:50'!
updateHeading: aHeadingUpdate

	self subclassResponsibility ! !

!MarsRoverTracking methodsFor: 'update' stamp: 'ja 6/6/2021 16:54:00'!
updatePosition: aPositonUpdate

	self subclassResponsibility ! !


!MarsRoverTracking methodsFor: 'accesing' stamp: 'ja 6/6/2021 16:59:20'!
value

	self subclassResponsibility ! !


!classDefinition: #Log category: 'MarsRover-WithHeading'!
MarsRoverTracking subclass: #Log
	instanceVariableNames: 'records'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Log methodsFor: 'accesing' stamp: 'ja 6/3/2021 20:55:27'!
size

	^ records size ! !

!Log methodsFor: 'accesing' stamp: 'ja 6/6/2021 16:59:37'!
value

	^ records copy! !


!Log methodsFor: 'initialization' stamp: 'ja 6/5/2021 18:00:18'!
initialize
	
	records _ OrderedCollection new.! !


!Log methodsFor: 'private' stamp: 'ja 6/5/2021 18:43:07'!
update: anUpdate

	records add: anUpdate 

	! !


!Log methodsFor: 'update' stamp: 'ja 6/6/2021 16:23:00'!
updateHeading: aHeadingUpdate

	self update: aHeadingUpdate 

	! !

!Log methodsFor: 'update' stamp: 'ja 6/6/2021 16:22:43'!
updatePosition: aPositonUpdate

	self update: aPositonUpdate 

	! !


!classDefinition: #Window category: 'MarsRover-WithHeading'!
MarsRoverTracking subclass: #Window
	instanceVariableNames: 'headingView positionView'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Window methodsFor: 'accesing' stamp: 'ja 6/6/2021 17:02:32'!
value
	
	^self buildValue! !


!Window methodsFor: 'initialization' stamp: 'ja 6/6/2021 16:28:42'!
initialize

	positionView _ ''.
	headingView _ ''! !


!Window methodsFor: 'update' stamp: 'ja 6/6/2021 16:26:31'!
updateHeading: aHeadingUpdate
	
	headingView _ aHeadingUpdate 
	! !

!Window methodsFor: 'update' stamp: 'ja 6/6/2021 16:26:40'!
updatePosition: aPositionUpdate
	
	positionView _ aPositionUpdate ! !


!Window methodsFor: 'private' stamp: 'ja 6/6/2021 17:02:22'!
buildValue

	positionView  ifEmpty: [^ headingView].
	headingView ifEmpty: [^ positionView].
	^ positionView ,' ', headingView ! !


!classDefinition: #MarsRoversObserver category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoversObserver
	instanceVariableNames: 'tracker'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoversObserver methodsFor: 'initialization' stamp: 'ja 6/6/2021 17:55:34'!
initializeWith: aTracker 

	tracker _ aTracker ! !


!MarsRoversObserver methodsFor: 'update' stamp: 'ja 6/6/2021 16:45:01'!
updateHeading: aHeading

	self subclassResponsibility ! !

!MarsRoversObserver methodsFor: 'update' stamp: 'ja 6/6/2021 16:44:42'!
updatePosition: aPosition

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoversObserver class' category: 'MarsRover-WithHeading'!
MarsRoversObserver class
	instanceVariableNames: ''!

!MarsRoversObserver class methodsFor: 'instance creation' stamp: 'ja 6/6/2021 17:55:18'!
with: aTracker
	
	^ self new initializeWith: aTracker ! !


!classDefinition: #ObserverHeading category: 'MarsRover-WithHeading'!
MarsRoversObserver subclass: #ObserverHeading
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!ObserverHeading methodsFor: 'update' stamp: 'ja 6/6/2021 17:55:34'!
updateHeading: aHeading

	tracker updateHeading: aHeading heading ! !

!ObserverHeading methodsFor: 'update' stamp: 'ja 6/5/2021 18:51:51'!
updatePosition: aPosition

	! !


!classDefinition: #ObserverPosition category: 'MarsRover-WithHeading'!
MarsRoversObserver subclass: #ObserverPosition
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!ObserverPosition methodsFor: 'update' stamp: 'ja 6/5/2021 18:49:29'!
updateHeading: aHeading
! !

!ObserverPosition methodsFor: 'update' stamp: 'ja 6/6/2021 17:55:34'!
updatePosition: aPosition

	tracker updatePosition: aPosition asString ! !
