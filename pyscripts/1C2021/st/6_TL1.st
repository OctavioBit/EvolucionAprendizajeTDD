!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'catalog book1 book2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'test' stamp: 'BW 6/9/2021 22:10:38'!
test01NewCartShouldBeEmpty
	| cart |
	cart := Cart withCatalog: catalog.
	
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'test' stamp: 'BW 6/9/2021 22:10:38'!
test02CartShouldRecognizeASingleAddedBook
	| cart expectedProducts |
	
	expectedProducts := Dictionary new.
	cart := Cart withCatalog: catalog.
	
	cart add: book1.
	 
	expectedProducts at: book1 put: 1.
	
	self assert: 1 equals: cart size.
	self assert: expectedProducts equals: cart products.! !

!CartTest methodsFor: 'test' stamp: 'BW 6/9/2021 22:10:38'!
test03CartShouldRecognizeDifferentAddedBooks
	| cart expectedProducts |
	cart := Cart withCatalog: catalog.
	 
	
	cart add: book1.
	cart add: book2.
	
	expectedProducts := Dictionary new.
	expectedProducts at: book1 put: 1.
	expectedProducts at: book2 put: 1.
	
	self assert: 2 equals: cart size.
	self assert: (Dictionary newFromPairs: (OrderedCollection with: book1 with: 1 with: book2 with: 1 )) equals: cart products.! !

!CartTest methodsFor: 'test' stamp: 'BW 6/9/2021 22:10:38'!
test04CartShouldRecognizeDifferentAddedBooksQuantities
	| cart   expectedProducts |
	cart := Cart withCatalog: catalog.
	
	 
	cart add: book1 quantity: 3.
	cart add: book2.
	
	expectedProducts := Dictionary new.
	expectedProducts at: book1 put: 3.
	expectedProducts at: book2 put: 1.
	
	self assert: 4 equals: cart size.
	self assert: expectedProducts equals: cart products.! !

!CartTest methodsFor: 'test' stamp: 'BW 6/9/2021 22:10:38'!
test05AddingAlreadyExistingBookShouldIncreaseItsQuantity
	| cart  expectedProducts |
	cart := Cart withCatalog: catalog.
	
	cart add: book1 quantity: 3.
	cart add: book1 quantity: 2.
	
	expectedProducts := Dictionary new.
	expectedProducts at: book1 put: 5.

	
	self assert: 5 equals: cart size.
	self assert: expectedProducts equals: cart products.! !

!CartTest methodsFor: 'test' stamp: 'BW 6/9/2021 22:15:04'!
test06BookQuantityShouldBePositive
	| cart  |
	cart := Cart withCatalog: catalog.
	
	
	self should: [cart add: book1 quantity: 0] raise: Error - MessageNotUnderstood withMessageText: Cart quantityShouldBeNaturalErrorMessage.
	
	! !

!CartTest methodsFor: 'test' stamp: 'BW 6/9/2021 22:15:04'!
test07BookQuantityShouldBeInteger
	| cart  |
	cart := Cart withCatalog: catalog.
	
	
	self should: [cart add: book1 quantity: 10/3] raise: Error - MessageNotUnderstood withMessageText: Cart quantityShouldBeNaturalErrorMessage.
	
	! !

!CartTest methodsFor: 'test' stamp: 'BW 6/9/2021 22:12:19'!
test08CannotAddNonCatalogedBook
	| cart book |
	
	cart := Cart withCatalog: catalog.
	book := Book withISBN: 5.
	
	self should: [cart add: book] raise: Error - MessageNotUnderstood withMessageText: Catalogo bookIsNotInCatalogErrorMessage.
	
	! !


!CartTest methodsFor: 'initialization' stamp: 'BW 6/9/2021 22:10:38'!
setUp
	catalog := Catalogo new.
	catalog add: 1.
	catalog add: 2.
	
	book1 := Book withISBN: 1.
	book2 := Book withISBN: 2.! !


!classDefinition: #Book category: 'TusLibros'!
Object subclass: #Book
	instanceVariableNames: 'isbn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Book methodsFor: 'initialization' stamp: 'BW 6/9/2021 17:56:58'!
initializeWithISBN: anISBN
	
	isbn := anISBN.! !


!Book methodsFor: 'testing' stamp: 'BW 6/9/2021 19:00:57'!
isbn
	^isbn! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Book class' category: 'TusLibros'!
Book class
	instanceVariableNames: ''!

!Book class methodsFor: 'instance creation' stamp: 'BW 6/9/2021 17:56:01'!
withISBN: aSmallInteger 
	^self new initializeWithISBN: aSmallInteger ! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'products catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'testing' stamp: 'BW 6/9/2021 18:02:33'!
isEmpty
	^products isEmpty.! !

!Cart methodsFor: 'testing' stamp: 'BW 6/9/2021 18:17:09'!
size
	^products values inject: 0 into: [:aTotal :aQuantity | aTotal + aQuantity].
	! !


!Cart methodsFor: 'adding' stamp: 'BW 6/9/2021 18:14:35'!
add: aBook 
	self add: aBook quantity: 1.! !

!Cart methodsFor: 'adding' stamp: 'BW 6/9/2021 18:57:48'!
add: aBook quantity: aQuantity
	
	self validateQuantity: aQuantity.
	catalog validate: aBook.
	
	products at: aBook 
		      ifPresent: [:currentQuantity | products at: aBook put: (currentQuantity + aQuantity)] 
		      ifAbsent: [products at: aBook put: aQuantity].
! !

!Cart methodsFor: 'adding' stamp: 'BW 6/9/2021 22:15:04'!
validateQuantity: aQuantity

	^ ((aQuantity isKindOf: Integer) not or: [aQuantity < 1]) ifTrue: [self error: self class quantityShouldBeNaturalErrorMessage ]! !


!Cart methodsFor: 'products' stamp: 'BW 6/9/2021 18:14:53'!
products
	^products! !


!Cart methodsFor: 'initialization' stamp: 'BW 6/9/2021 22:13:27'!
initializeWithCatalog: aCatalog 
	catalog := aCatalog.
	products := Dictionary new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error handling' stamp: 'BW 6/9/2021 22:15:04'!
quantityShouldBeNaturalErrorMessage
	^'la cantidad de libros agregados al carrito debe ser positiva'! !


!Cart class methodsFor: 'instance creation' stamp: 'BW 6/9/2021 18:55:25'!
withCatalog: aCatalog
	
	^self new initializeWithCatalog: aCatalog ! !


!classDefinition: #Catalogo category: 'TusLibros'!
Object subclass: #Catalogo
	instanceVariableNames: 'isbns'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Catalogo methodsFor: 'initialization' stamp: 'BW 6/9/2021 21:55:31'!
initialize
	isbns := OrderedCollection new.! !


!Catalogo methodsFor: 'inventory' stamp: 'BW 6/9/2021 21:55:47'!
add: aISBN
	isbns add: aISBN
	! !

!Catalogo methodsFor: 'inventory' stamp: 'BW 6/9/2021 21:55:31'!
validate: aBook
	(isbns includes: aBook isbn) ifFalse: [self error: self class bookIsNotInCatalogErrorMessage ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Catalogo class' category: 'TusLibros'!
Catalogo class
	instanceVariableNames: ''!

!Catalogo class methodsFor: 'error handling' stamp: 'BW 6/9/2021 18:58:38'!
bookIsNotInCatalogErrorMessage
	^'error: book is not in catalog'! !
