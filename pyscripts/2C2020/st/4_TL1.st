!classDefinition: #CarritoTest category: 'TusLibros'!
TestCase subclass: #CarritoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CarritoTest methodsFor: 'tests' stamp: 'GR 11/18/2020 14:42:36'!
test01CanCreateNewCartWithNoProducts

	| carrito |
	
	carrito := Carrito withCatalog: (OrderedCollection with: #Libro1).
	
	self assert: 0 equals: carrito productAmount.! !

!CarritoTest methodsFor: 'tests' stamp: 'GR 11/18/2020 14:42:31'!
test02CanAddAProductToCart

	| carrito |
	
	carrito := Carrito withCatalog: (OrderedCollection with: #Libro1).
	
	carrito addToCart: #Libro1 withAmount: 1.
	
	self assert: 1 equals: carrito productAmount.
	self assert: (carrito products includes: #Libro1)! !

!CarritoTest methodsFor: 'tests' stamp: 'GR 11/18/2020 14:42:28'!
test03CanAddAProductToCartMultipleTimes

	| carrito |
	
	carrito := Carrito withCatalog: (OrderedCollection with: #Libro1).
	
	carrito addToCart: #Libro1 withAmount: 3.
	
	self assert: 3 equals: carrito productAmount.
	self assert: 3 equals: (carrito products occurrencesOf: #Libro1)! !

!CarritoTest methodsFor: 'tests' stamp: 'GR 11/18/2020 14:42:24'!
test04AddAProductThatIsAlreadyInTheCart

	| carrito |
	
	carrito := Carrito withCatalog: (OrderedCollection with: #Libro1).
	
	carrito addToCart: #Libro1 withAmount: 3.
	carrito addToCart: #Libro1 withAmount: 1.
	
	self assert: 4 equals: carrito productAmount.
	self assert: 4 equals: (carrito products occurrencesOf: #Libro1)! !

!CarritoTest methodsFor: 'tests' stamp: 'GR 11/18/2020 14:39:36'!
test05CanNotAddABookThatIsNotInTheCatalog

	| carrito |
	
	carrito := Carrito withCatalog: (OrderedCollection with: #Libro1).
	
	carrito addToCart: #Libro1 withAmount: 3.
	
	self
		should: [ carrito addToCart: #Libro2 withAmount: 1. ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Carrito productNotInTheCatalog = anError messageText.
			self assert: 3 equals: carrito productAmount.
			self assert: 0 equals: (carrito products occurrencesOf: #Libro2) ].
	
	
	! !

!CarritoTest methodsFor: 'tests' stamp: 'GR 11/18/2020 15:38:52'!
test06EmptyCartListsNoItems

	| carrito |
	
	carrito := Carrito withCatalog: (OrderedCollection with: #Libro1).
	
	self assert: Dictionary new equals: carrito listCart
	
	
	! !

!CarritoTest methodsFor: 'tests' stamp: 'GR 11/18/2020 15:52:57'!
test07CartCanListEveryProductInIt

	| carrito list |
	
	carrito := Carrito withCatalog: (OrderedCollection with: #Libro1).
	
	carrito addToCart: #Libro1 withAmount: 3.
	
	list := Dictionary with: #Libro1->3.
	
	self assert: list equals: carrito listCart
	
	
	! !

!CarritoTest methodsFor: 'tests' stamp: 'GR 11/19/2020 17:10:20'!
test08CanNotAddNegativeAmountOfProducts

	| carrito |
	
	carrito := Carrito withCatalog: (OrderedCollection with: #Libro1).
	
	self 
		should: [ carrito addToCart: #Libro1 withAmount: -2. ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Carrito invalidAmountOfProductsError 
	
	
	! !

!CarritoTest methodsFor: 'tests' stamp: 'GR 11/19/2020 17:13:33'!
test09CanNotAddCeroAmountOfProducts

	| carrito |
	
	carrito := Carrito withCatalog: (OrderedCollection with: #Libro1).
	
	self 
		should: [ carrito addToCart: #Libro1 withAmount: 0. ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Carrito invalidAmountOfProductsError.
	
	
	! !


!classDefinition: #Carrito category: 'TusLibros'!
Object subclass: #Carrito
	instanceVariableNames: 'products catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Carrito methodsFor: 'accessing' stamp: 'GR 11/18/2020 16:07:04'!
listCart
	
	^ products contents! !

!Carrito methodsFor: 'accessing' stamp: 'GR 11/16/2020 19:43:44'!
productAmount
	
	^ products size.! !

!Carrito methodsFor: 'accessing' stamp: 'GR 11/16/2020 19:08:32'!
products
	
	^products! !


!Carrito methodsFor: 'initialization' stamp: 'GR 11/18/2020 14:40:31'!
initializeWithCatalog: aCatalog 
	
	products := Bag new.
	catalog := aCatalog.! !


!Carrito methodsFor: 'operations' stamp: 'GR 11/19/2020 17:15:01'!
addToCart: aProduct withAmount: aProductAmount 
	
	(aProductAmount <= 0) ifTrue: [ self error: self class invalidAmountOfProductsError ].
	
	(catalog includes: aProduct) ifFalse: [self error: self class productNotInTheCatalog ].
	
	products add: aProduct withOccurrences: aProductAmount.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Carrito class' category: 'TusLibros'!
Carrito class
	instanceVariableNames: ''!

!Carrito class methodsFor: 'instance creation' stamp: 'GR 11/18/2020 14:40:01'!
withCatalog: aCatalog 
	
	^self new initializeWithCatalog: aCatalog ! !


!Carrito class methodsFor: 'error handling' stamp: 'GR 11/19/2020 17:14:17'!
invalidAmountOfProductsError
	
	^ 'You are adding an invalid amount of products to the cart'! !

!Carrito class methodsFor: 'error handling' stamp: 'GR 11/18/2020 14:41:59'!
productNotInTheCatalog
	
	^ 'The book is not in the catalog'! !
