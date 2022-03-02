!classDefinition: #CartTest category: 'TusLibros1-Ejercicio'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros1-Ejercicio'!

!CartTest methodsFor: 'AddBookTests' stamp: 'D S 11/18/2020 15:12:05'!
test02AddingABookToTheCartAppearsInside
	|aCart aCatalog|
	
	aCatalog := OrderedCollection with: 'aBook'.
	aCart := Cart initializeWithCatalog: aCatalog.

	aCart addBook: 'aBook' Quantity: 1.
	self assert: (Bag with: 'aBook') equals: aCart itemsInside.
	self assert: 1 equals: aCart quantityItemsInside.	! !

!CartTest methodsFor: 'AddBookTests' stamp: 'D S 11/18/2020 15:12:06'!
test03AddingMoreThanOneBooksDifferentsBooksAppearsInsideTheCart
	|aCart aCatalog|
	
	aCatalog := OrderedCollection with: 'aBook' with: 'anotherBook'.
	aCart := Cart initializeWithCatalog: aCatalog.
	aCart addBook: 'aBook' Quantity: 1.
	aCart addBook: 'anotherBook' Quantity: 1.
	self assert: (Bag with: 'aBook' with: 'anotherBook') equals: aCart itemsInside.
	self assert: 2 equals: aCart quantityItemsInside.! !

!CartTest methodsFor: 'AddBookTests' stamp: 'D S 11/18/2020 15:12:06'!
test04AddingMoreThanOneBooksThatAreTheSameAppearsInsideTheCart
	|aCart aCatalog|
	
	aCatalog := OrderedCollection with: 'aBook'.
	aCart := Cart initializeWithCatalog: aCatalog.
	aCart addBook: 'aBook' Quantity: 2.
	self assert: (Bag with: 'aBook' with: 'aBook') equals: aCart itemsInside.
	self assert: 2 equals: aCart quantityItemsInside.! !


!CartTest methodsFor: 'InitializationTests' stamp: 'D S 11/18/2020 11:46:35'!
test01NewCartHasNoItemInside
	|aCart aCatalog|
	aCatalog := OrderedCollection new.
	aCart := Cart initializeWithCatalog: aCatalog.
	self assert: 0 equals: aCart quantityItemsInside.
	self assert: (Bag new) equals: aCart itemsInside.! !


!CartTest methodsFor: 'ErrorsTests' stamp: 'D S 11/18/2020 15:12:05'!
test05AddingAQuantityOfZeroRaiseError
	|aCart aCatalog|
	
	aCatalog := OrderedCollection with: 'aBook'.
	aCart := Cart initializeWithCatalog: aCatalog.
	[aCart addBook: 'aBook' Quantity: 0.
	self fail]
	on: Error 
	do: [:anError| self assert: Cart errorDescriptionQuantityMustBePositive equals: anError messageText]! !

!CartTest methodsFor: 'ErrorsTests' stamp: 'D S 11/18/2020 15:12:06'!
test06AddingABookWithEmptyNameRaiseError
	|aCart aCatalog|
	
	aCatalog := OrderedCollection with: 'aBook'.
	aCart := Cart initializeWithCatalog: aCatalog.
	[aCart addBook: '' Quantity: 1.
	self fail]
	on: Error 
	do: [:anError| self assert: Cart errorDescriptionEmptyName equals: anError messageText]! !

!CartTest methodsFor: 'ErrorsTests' stamp: 'D S 11/18/2020 15:12:06'!
test07AddingABookNotInCatalogRaiseError
	|aCart aCatalog|
	aCatalog := OrderedCollection with: 'aBook'.
	aCart := Cart initializeWithCatalog: aCatalog.
	[aCart addBook: 'aBookNotInCatalog' Quantity: 1.
	self fail]
	on: Error 
	do: [:anError| self assert: Cart errorDescriptionBookNotInCatalog equals: anError messageText]! !


!classDefinition: #Cart category: 'TusLibros1-Ejercicio'!
Object subclass: #Cart
	instanceVariableNames: 'items catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros1-Ejercicio'!

!Cart methodsFor: 'adding' stamp: 'D S 11/18/2020 15:12:25'!
addBook: aBook Quantity: aQuantity

	self checkNameIsNotEmptyOfTheBook: aBook.
	self checkQuantityIsPositive: aQuantity.
	self checkBookIsInTheCatalog: aBook.
	aQuantity timesRepeat: [items add: aBook ].! !


!Cart methodsFor: 'accessing' stamp: 'D S 11/17/2020 13:30:53'!
itemsInside

	^items copy
	! !

!Cart methodsFor: 'accessing' stamp: 'D S 11/17/2020 13:34:32'!
quantityItemsInside

	^items size.! !


!Cart methodsFor: 'initialization' stamp: 'D S 11/18/2020 11:49:30'!
initializeWithCatalog: aCatalog

	items := Bag new.
	catalog := aCatalog.! !


!Cart methodsFor: 'testing --Private--' stamp: 'D S 11/18/2020 15:12:35'!
checkBookIsInTheCatalog: aBook

	^ (catalog includes: aBook) ifFalse: [self error: self class errorDescriptionBookNotInCatalog]! !

!Cart methodsFor: 'testing --Private--' stamp: 'D S 11/18/2020 15:12:40'!
checkNameIsNotEmptyOfTheBook: aBook

	^ (aBook = '') ifTrue:[self error: self class errorDescriptionEmptyName ]! !

!Cart methodsFor: 'testing --Private--' stamp: 'D S 11/18/2020 11:54:46'!
checkQuantityIsPositive: aQuantity

	^ (aQuantity < 1) ifTrue:[self error: self class errorDescriptionQuantityMustBePositive ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros1-Ejercicio'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'D S 11/18/2020 11:48:34'!
errorDescriptionBookNotInCatalog

	^'The book dont belong to the catalog'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'D S 11/17/2020 14:01:14'!
errorDescriptionEmptyName

	^'The name of the cannot be empty'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'D S 11/17/2020 13:59:26'!
errorDescriptionQuantityMustBePositive

	^'The quantity must be positive'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'D S 11/18/2020 11:44:15'!
initializeWithCatalog: aCatalog

	^self new initializeWithCatalog: aCatalog! !
