!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'CS 11/16/2020 19:21:07'!
test01NewCartHasNoBooks

	|newCart|
	
	newCart:= Cart new.
	
	self assert: newCart books isEmpty.
	
	! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'CS 11/18/2020 16:58:23'!
test02ABookCanBeAddedToTheCart

	|newCart newBook| 
	
	newCart:= Cart  withCatalogue:( OrderedCollection with: 9992158107).
	
	newBook:= 9992158107.
	
	newCart add: newBook.
	
	
	self assert: newCart books size equals: 1.
	self assert: newCart books includes: newBook.
	
	! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'CS 11/18/2020 16:57:30'!
test03ABookCanBeAddedToTheCartMoreThanOnceAtATime

	|newCart newBook| 
	
	newCart:= Cart withCatalogue:( OrderedCollection with: 9992158107).
	
	newBook:= 9992158107.
	
	newCart add: newBook withQuantity: 2.
	
	
	self assert: newCart books size equals: 2.
	self assert: newCart books includes: newBook.
	
	! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'CS 11/18/2020 16:57:39'!
test04ABookThatIsNotIncludedInTheCatalogueCanNotBeAdded

	|newCart newBook| 
	
	newCart:= Cart withCatalogue: OrderedCollection  new.
	
	newBook:= 9992158107.
	
	self should:[ newCart add: newBook] raise: Error withMessageText: Cart bookNotInCatalogueErrorDescription.
	! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'books orderedCollection catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'accessing' stamp: 'CS 11/16/2020 19:38:50'!
books
	
	^books copy.! !


!Cart methodsFor: 'actions' stamp: 'CS 11/16/2020 19:19:13'!
add: aBook 
	
	self add: aBook withQuantity: 1.! !

!Cart methodsFor: 'actions' stamp: 'CS 11/18/2020 17:10:24'!
add: aBook withQuantity: aQuantity 

	self assertBookIsInCatalogue: aBook.

	books add: aBook withOccurrences: aQuantity.! !


!Cart methodsFor: 'assertions' stamp: 'CS 11/18/2020 17:11:45'!
assertBookIsInCatalogue: aBook

	^ (catalogue includes: aBook) ifFalse: [self signalBookNotInCatalogue].! !


!Cart methodsFor: 'initialization' stamp: 'CS 11/16/2020 19:38:58'!
initialize
	
	books:= Bag new.
	! !

!Cart methodsFor: 'initialization' stamp: 'CS 11/18/2020 16:42:13'!
initializeWithCatalogue: anOrderedCollection 
	
	
	catalogue := anOrderedCollection.! !


!Cart methodsFor: 'signals' stamp: 'CS 11/18/2020 17:11:44'!
signalBookNotInCatalogue

	^ self error: self class bookNotInCatalogueErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'CS 11/18/2020 16:41:33'!
withCatalogue: anOrderedCollection
 
	^self new initializeWithCatalogue: anOrderedCollection.! !


!Cart class methodsFor: 'error handling' stamp: 'CS 11/18/2020 16:50:53'!
bookNotInCatalogueErrorDescription
	
	^'The book is not in the catalogue'.! !
