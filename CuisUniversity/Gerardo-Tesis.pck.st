'From Cuis 5.0 [latest update: #4384] on 11 June 2021 at 9:05:13 am'!
'Description '!
!provides: 'Gerardo-Tesis' 1 3!



!AnalysisResultWindow methodsFor: '*Gerardo-Tesis' stamp: 'GF 6/11/2021 08:10:07'!
appendToExport: fileName

	| exportLines file |

	exportLines := self buildExportLinesFromEvents: tddGuru analysisResult timeline events.		
	file := fileName asFileEntry.			
	exportLines do:[ :line | file appendContents: line ].! !

!AnalysisResultWindow methodsFor: '*Gerardo-Tesis' stamp: 'GF 4/27/2021 09:29:21'!
buildDataFromFileName

	| parts data changesFileName indexRepository indexStudent indexExercise |

	indexRepository :=1.
	indexStudent := 2.	
	indexExercise :=4.
		
	parts := OrderedCollection new.
	data :=''.
	
	changesFileName := (FileSystemEntry withPathName: tddGuru changesFile) name.
	
	"Split string by character '_' "
	changesFileName do: [ :c |
		c = $_ ifTrue:[ parts add: data. data := ''. ] 
		          ifFalse:[ data := data,(c asString). ].	
	].

	^ (parts at:indexExercise )	,',',
	   (parts at:indexRepository),',',
	   (parts at:indexStudent).
	
	! !

!AnalysisResultWindow methodsFor: '*Gerardo-Tesis' stamp: 'GF 5/12/2021 21:23:45'!
buildExportFileName

	| date time fileName datePrintFormat |

	date := Time dateAndTimeNow at:1.
	time := Time dateAndTimeNow at:2.
	datePrintFormat := #(3 2 1 0 1 1 2).
	fileName := 'TDDGuruExport\',
			   (date printFormat: datePrintFormat),
	                  time hour asString, 
	  		   time minute asString,
	                  time second asString,
			   '_TDDGuruResult.csv'.

	^fileName.! !

!AnalysisResultWindow methodsFor: '*Gerardo-Tesis' stamp: 'GF 5/14/2021 21:06:57'!
buildExportLinesFromEvents: events

	| currentTime currentState currentStatus exportLines |
				
	currentTime := '0'.
       currentState := ''.
       currentStatus := ''.

	exportLines := OrderedCollection new.
	exportLines add:''.
		
	events do:[ :event | 
				
                event type = #change ifTrue: [ currentTime := event secondsWithPreviousChange].

                event type = #stateTransition ifTrue: [ event stateTo isCorrect ifTrue:[ currentStatus := '1' ] 
	                                                                                                      ifFalse:[ currentStatus := '0' ].
										   currentState := self exportStateCode: event stateTo.
										    exportLines removeLast.].		

		 exportLines add: (self buildDataFromFileName,',',currentState,',',currentStatus,',',currentTime,String newLineString).		
	].

	^ exportLines.! !

!AnalysisResultWindow methodsFor: '*Gerardo-Tesis' stamp: 'GF 3/28/2021 00:56:50'!
buttonExport
	| buttonColor exportButton |
	
	buttonColor _ Color r:0.15 g:0.24 b:0.15.	
	exportButton := PluggableButtonMorph 
					model: self
					stateGetter: nil
					action: #export.
	exportButton color: buttonColor.
	exportButton label: 'Export'.	
	
	^ exportButton! !

!AnalysisResultWindow methodsFor: '*Gerardo-Tesis' stamp: 'GF 5/13/2021 20:01:43'!
export

	| exportLines |

	exportLines := self buildExportLinesFromEvents: tddGuru analysisResult timeline events.	
	
	self saveExportFile: exportLines.
		
	self inform: ('File 'append: (self buildExportFileName append:' was succesfully exported!!')).! !

!AnalysisResultWindow methodsFor: '*Gerardo-Tesis' stamp: 'GF 5/14/2021 21:05:43'!
exportDirectory

 | fileName |

 fileName := '\TDDGuruExport\TDDGuruExport.csv'.

'F:\data\Tesis\data\Analisis\ejercicios\' asDirectoryEntry allFilesDo: [ :file | AnalysisResultWindow exportChanges: file asString 
                                                                                                      toFile: fileName].

self inform: ('File 'append: (fileName append:' was succesfully exported!!')).! !

!AnalysisResultWindow methodsFor: '*Gerardo-Tesis' stamp: 'GF 4/25/2021 22:22:41'!
exportStateCode: aState
	
	aState = Green ifTrue: [ ^ 'GR' ].
	aState = MoreThanOneTestWritten ifTrue: [ ^ 'MO' ].
	aState = NotDoingTDD ifTrue: [ ^ 'NT' ].
	aState = NotStarted ifTrue: [ ^ 'NS' ].
	aState = Red ifTrue: [ ^ 'RE' ].
	aState = Refactor ifTrue: [ ^ 'RF' ].
	aState = WritingAFailingTest ifTrue: [ ^ 'WR' ].

	^ 'error'.! !

!AnalysisResultWindow methodsFor: '*Gerardo-Tesis' stamp: 'GF 4/30/2021 00:13:14'!
saveExportFile: aLineCollection
	
	| fileName file fileStream  |
	
	fileName := self buildExportFileName.
	file := fileName asFileEntry.
	fileStream := file writeStream.
	[ aLineCollection do:[ :line | fileStream nextPutAll: line ] ] ensure: [ fileStream close.	 ].! !

!AnalysisResultWindow class methodsFor: '*Gerardo-Tesis' stamp: 'GF 5/13/2021 20:42:09'!
exportChanges: userChangesFileName toFile:exportedFileName
	
	| window analysisResult tddGuru |
	
	tddGuru := TDDGuru on: userChangesFileName.
	analysisResult := tddGuru run.			
	window := AnalysisResultWindow new.
	window analyzedBy: tddGuru.

	window appendToExport:exportedFileName.! !

!AnalysisResultWindow class methodsFor: '*Gerardo-Tesis' stamp: 'GF 6/11/2021 08:12:11'!
exportDirectory

   | exercisesPath fileExport fileTo |

   exercisesPath := 'F:\data\Tesis\data\Analisis\ejercicios\'.
   fileExport := 'TDDGuruExport.csv'.
  
   fileTo := fileExport asFileEntry.

   "File headers"
   fileTo appendContents:'Exercise,Repository,Student,State,IsCorrect,Time'.
   fileTo appendContents:String newLineString.

   exercisesPath asDirectoryEntry allFilesDo: [ :file | AnalysisResultWindow exportChanges: file asString 
                                                                                                      toFile:fileExport ].! !

!TDDGuru methodsFor: '*Gerardo-Tesis' stamp: 'GF 6/11/2021 01:43:07'!
changesFile
	^changesFile.
	! !

!ChangeEvent methodsFor: '*Gerardo-Tesis' stamp: 'GF 6/11/2021 01:45:06'!
secondsWithPreviousChange
	| previousEvent timeDifference seconds|
	
	previousEvent := self previousEvent.
	previousEvent ifNil: [ ^ '0' ].

	timeDifference := self change time distanceFrom: previousEvent change time.
	seconds := ((timeDifference convertTo: TimeUnits second) floor) amount.
			
	 ^seconds abs asString.! !
