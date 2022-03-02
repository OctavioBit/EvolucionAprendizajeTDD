!classDefinition: #CartTest category: 'Tus-Libros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'isbn1 isbn2 catalog1 cart1'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!CartTest methodsFor: 'setUp/tearDown' stamp: 'PJ 11/18/2020 22:05:04'!
setUp
	
	isbn1 := 12345.
	isbn2 := 123456.
	
	catalog1 :=Set with: isbn1 with: isbn2.
	
	cart1 := Cart withCatalog: catalog1.
	! !


!CartTest methodsFor: 'tests' stamp: 'PJ 11/18/2020 22:05:25'!
test01_newCartIsAnEmptyCart
	
	self assert: cart1 isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'PJ 11/18/2020 22:05:44'!
test02_cartWithOneBookIsNotEmpty

	cart1 addBookISBN: isbn1 quantity: 1.
	self assert: (cart1 isEmpty not).! !

!CartTest methodsFor: 'tests' stamp: 'PJ 11/18/2020 22:06:19'!
test03_cannotAddISBNOutsideTheCatalogIntoCart
	
	cart1 addBookISBN: isbn1 quantity: 1.
	cart1 addBookISBN: isbn2 quantity: 1.
	
	self should: [cart1 addBookISBN: 1234567 quantity: 1] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Cart ISBNNotInCatalogErrorDescription.! !

!CartTest methodsFor: 'tests' stamp: 'PJ 11/18/2020 22:06:39'!
test04_cartContainsAllAddedBooksISBN
	
	cart1 addBookISBN: isbn1 quantity: 1.
	cart1 addBookISBN: isbn2 quantity: 1.
	
	self assert: (cart1 content includesKey: isbn1).
	self assert: (cart1 content includesKey: isbn2).! !

!CartTest methodsFor: 'tests' stamp: 'PJ 11/18/2020 22:06:55'!
test05_aCartCanAddANumberOfCopiesOfTheSameBookISBN
	
	cart1 addBookISBN: isbn1 quantity: 2.
	cart1 addBookISBN: isbn2 quantity: 5.
	
	self assert: 2 equals: (cart1 content at: isbn1).
	self assert: 5 equals: (cart1 content at: isbn2).! !

!CartTest methodsFor: 'tests' stamp: 'PJ 11/18/2020 22:07:07'!
test06_theNumberOfCopiesToAddOfABookISBNMustBePositive
	
	self should: [cart1 addBookISBN: isbn1 quantity: 0]
		raise: Error - MessageNotUnderstood
		withMessageText: Cart numberOfCopiesMustBePositiveErrorDescription.! !


!classDefinition: #Cart category: 'Tus-Libros'!
Object subclass: #Cart
	instanceVariableNames: 'content catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!Cart methodsFor: 'testing' stamp: 'PGTA 11/16/2020 19:24:57'!
hasBook: aBook 
	^content includes: aBook.! !

!Cart methodsFor: 'testing' stamp: 'PGTA 11/16/2020 19:25:24'!
isEmpty
	^content isEmpty.! !


!Cart methodsFor: 'initialization' stamp: 'PJ 11/18/2020 21:19:01'!
initializeWithCatalog: aCatalog
	
	content := Bag new.
	catalog := aCatalog.! !


!Cart methodsFor: 'cart operations' stamp: 'PJ 11/18/2020 21:40:16'!
addBookISBN: anISBN quantity: aNumberOfCopies 
	
	(catalog includes: anISBN) ifFalse: [ ^self error: self class ISBNNotInCatalogErrorDescription ].
	(aNumberOfCopies > 0) ifFalse: [ ^self error: self class numberOfCopiesMustBePositiveErrorDescription ].
	content add: anISBN withOccurrences: aNumberOfCopies.! !


!Cart methodsFor: 'list cart' stamp: 'PJ 11/18/2020 21:21:55'!
content
	^content contents copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'Tus-Libros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'errors' stamp: 'PGTA 11/18/2020 19:09:26'!
ISBNNotInCatalogErrorDescription
	^'ISBN not in catalog.'! !

!Cart class methodsFor: 'errors' stamp: 'PJ 11/18/2020 21:38:16'!
numberOfCopiesMustBePositiveErrorDescription
	^'Number of copies must be positive'! !


!Cart class methodsFor: 'instance creation' stamp: 'PGTA 11/18/2020 19:10:57'!
withCatalog: aCatalog

	^self new initializeWithCatalog: aCatalog ! !
