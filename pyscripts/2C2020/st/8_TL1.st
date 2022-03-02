!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'catalogue carrito'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'EMI 11/18/2020 18:20:23'!
test01NewCartIsEmpty
	self assert: (carrito isEmpty).! !

!CartTest methodsFor: 'tests' stamp: 'EMI 11/18/2020 18:16:25'!
test02CartCanAddOneBook
	carrito add: 'El principito'.
	self deny: (carrito isEmpty).
	self assert: (carrito productsAmount) equals: 1.! !

!CartTest methodsFor: 'tests' stamp: 'EMI 11/18/2020 18:16:25'!
test03CartCanAddMoreThanOneCopyOfABookAtOnce
	carrito add: 'El principito' amount: 2.
	self deny: (carrito isEmpty).
	self assert: (carrito productsAmount) equals: 2.
	self assert: (carrito copiesOf: 'El principito') equals: 2.! !

!CartTest methodsFor: 'tests' stamp: 'EMI 11/18/2020 18:16:57'!
test04CartCanAddMoreThanOneBook
	carrito add: 'El principito'.
	carrito add: 'El principote'.
	self deny: (carrito isEmpty).
	self assert: (carrito productsAmount) equals: 2.
	self assert: (carrito contains: 'El principito').
	self assert: (carrito contains: 'El principote').! !

!CartTest methodsFor: 'tests' stamp: 'EMI 11/18/2020 18:16:25'!
test05CartCanAddMoreThanOneBookWithDifferentAmountOfCopies
	carrito add: 'El principito'.
	carrito add: 'El principito' amount: 2.
	carrito add: 'El principote'.
	self deny: (carrito isEmpty).
	self assert: (carrito productsAmount) equals: 4.
	self assert: (carrito contains: 'El principito').
	self assert: (carrito contains: 'El principote').
	self assert: (carrito copiesOf: 'El principito') equals: 3.
	self assert: (carrito copiesOf: 'El principote') equals: 1.! !

!CartTest methodsFor: 'tests' stamp: 'EMI 11/18/2020 18:16:25'!
test06CartCanShowContents
	| expectedResult |
	
	carrito add: 'El principito'.
	carrito add: 'El principito' amount: 2.
	carrito add: 'El principote'.
	
	expectedResult _ Bag with: 'El principote'.
	expectedResult add: 'El principito' withOccurrences: 3.
	
	self assert: (carrito contents) equals: expectedResult.! !

!CartTest methodsFor: 'tests' stamp: 'EMI 11/18/2020 18:16:25'!
test07CartCannotAddBookMissingFromCatalogue
	self should: [carrito add: 'La celula'] 
	raise: Error 
	withExceptionDo: [:anError| 
		self assert: anError messageText equals: Cart bookNotFoundInCatalogueMessage.
		self assert: carrito isEmpty.
		].! !


!CartTest methodsFor: 'set up' stamp: 'EMI 11/18/2020 18:16:25'!
setUp
	catalogue _ Set with: 'El principito' with: 'El principote'.
	carrito _ Cart createUsingCatalogue: catalogue.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books amount catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'testing' stamp: 'EMI 11/18/2020 17:33:05'!
contains: aBook 
	^books includes: aBook.! !

!Cart methodsFor: 'testing' stamp: 'EMI 11/16/2020 19:09:19'!
isEmpty
	^amount = 0.! !

!Cart methodsFor: 'testing' stamp: 'EMI 11/16/2020 19:09:25'!
productsAmount
	^amount.! !


!Cart methodsFor: 'initialization' stamp: 'EMI 11/18/2020 18:09:47'!
initialize: aCatalogue
	amount _ 0.
	books _ Bag new.
	catalogue _ aCatalogue.! !


!Cart methodsFor: 'adding' stamp: 'EMI 11/18/2020 18:10:17'!
add: aBook
	(self checkIfBookIsInCatalogue: aBook) ifFalse: [^Error signal: self class bookNotFoundInCatalogueMessage.].
	amount _ amount + 1.
	books add: aBook.
	
	! !

!Cart methodsFor: 'adding' stamp: 'EMI 11/18/2020 18:10:17'!
add: aBook amount: aNumberOfCopies 
	(self checkIfBookIsInCatalogue: aBook) ifFalse: [^Error signal: self class bookNotFoundInCatalogueMessage.].
	amount _ amount + aNumberOfCopies.
	books add: aBook withOccurrences: aNumberOfCopies.! !


!Cart methodsFor: 'private' stamp: 'EMI 11/18/2020 18:11:35'!
checkIfBookIsInCatalogue: aBook
	^catalogue includes: aBook.! !


!Cart methodsFor: 'accessing' stamp: 'EMI 11/18/2020 17:51:15'!
contents
	^books copy.! !

!Cart methodsFor: 'accessing' stamp: 'EMI 11/18/2020 17:36:29'!
copiesOf: aBook
	^books occurrencesOf: aBook.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'EMI 11/18/2020 18:10:17'!
bookNotFoundInCatalogueMessage
	^'Cannot find requested book in catalogue.'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'EMI 11/18/2020 18:09:24'!
createUsingCatalogue: aCatalogue
	^self new initialize: aCatalogue.! !
