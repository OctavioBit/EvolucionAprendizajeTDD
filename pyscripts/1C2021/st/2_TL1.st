!classDefinition: #ProductsCatalogTest category: 'TusLibros'!
TestCase subclass: #ProductsCatalogTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ProductsCatalogTest methodsFor: 'as yet unclassified' stamp: 'GDH 6/9/2021 22:45:10'!
test01WhenAssertingInvalidProductShouldRaiseAnError
	
	| productsCatalog |
	
	productsCatalog := ProductsCatalog for: (OrderedCollection with: 'VALID-ISBN').
		
	self should: [ productsCatalog assertProductIsValid: 'INVALID-ISBN' ]
		raise: Error - MessageNotUnderstood 
		withMessageText: [ ProductsCatalog productIsNotInCatalogErrorMessage ]! !

!ProductsCatalogTest methodsFor: 'as yet unclassified' stamp: 'GDH 6/9/2021 22:48:36'!
test02AddingProductToCatalogShouldMakeItValid
	
	| productsCatalog |
	
	productsCatalog := ProductsCatalog for: (OrderedCollection with: 'VALID-ISBN').
	productsCatalog addProduct: 'VALID-ISBN-2'.
	
	productsCatalog assertProductIsValid: 'VALID-ISBN-2'.! !


!classDefinition: #ShoppingCartTest category: 'TusLibros'!
TestCase subclass: #ShoppingCartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ShoppingCartTest methodsFor: 'tests' stamp: 'GDH 6/9/2021 22:40:03'!
test01NewlyCreatedShoppingCartShouldBeEmpty
	
	| shoppingCart productsCatalog |
	
	productsCatalog := ProductsCatalog for: (OrderedCollection with: 'ISBN-1').
	
	shoppingCart := ShoppingCart for: productsCatalog .
	
	self assert: shoppingCart isEmpty.
	! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'GDH 6/9/2021 22:40:29'!
test02AddingProductToShoppingCartShouldMakeCartNotEmpty
	
	| shoppingCart productsCatalog |
	
	productsCatalog := ProductsCatalog for: (OrderedCollection with: 'ISBN-1').
	
	shoppingCart := ShoppingCart for: productsCatalog .
	
	shoppingCart addProduct: 'ISBN-1'.
	
	self deny: shoppingCart isEmpty.! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'GDH 6/9/2021 20:26:50'!
test03AddingProductWithEmptyIdShouldThrowAnError
	
	| shoppingCart |
	
	shoppingCart := ShoppingCart new.
	
	self should: [ shoppingCart addProduct: '' ]
		raise: Error
		withMessageText: ShoppingCart productIdCanNotBeEmptyErrorMessage.! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'GDH 6/9/2021 22:40:59'!
test04ObtainingProductsShouldReturnAllAddedProducts
	
	| shoppingCart productsToAdd productsCatalog |
	
	productsCatalog := ProductsCatalog for: (OrderedCollection with: 'ISBN-1' with: 'ISBN-2').
	
	shoppingCart := ShoppingCart for: productsCatalog .
		
	productsToAdd := OrderedCollection with: 'ISBN-1' with: 'ISBN-1' with: 'ISBN-2'.
	
	productsToAdd do: [ :aProductId | shoppingCart addProduct: aProductId ].
	
	self assert: (shoppingCart productsContained includesAllOf: productsToAdd) .! !


!classDefinition: #ProductsCatalog category: 'TusLibros'!
Object subclass: #ProductsCatalog
	instanceVariableNames: 'validProducts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ProductsCatalog methodsFor: 'initialization' stamp: 'GDH 6/9/2021 22:36:22'!
assertProductIsValid: aProductId
	
	^(validProducts includes: aProductId) ifFalse: [ self error: ProductsCatalog productIsNotInCatalogErrorMessage ].! !

!ProductsCatalog methodsFor: 'initialization' stamp: 'GDH 6/9/2021 22:33:18'!
initialize
	
	validProducts := OrderedCollection new.! !

!ProductsCatalog methodsFor: 'initialization' stamp: 'GDH 6/9/2021 22:46:21'!
initializeFor: aValidProductsCollection
	
	validProducts := aValidProductsCollection .! !


!ProductsCatalog methodsFor: 'adding' stamp: 'GDH 6/9/2021 22:49:20'!
addProduct: aProduct
	 
	validProducts add: aProduct .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ProductsCatalog class' category: 'TusLibros'!
ProductsCatalog class
	instanceVariableNames: ''!

!ProductsCatalog class methodsFor: 'error messages' stamp: 'GDH 6/9/2021 22:37:13'!
productIsNotInCatalogErrorMessage
	
	^'No se puede agregar un producto que no pertence a la empresa'! !


!ProductsCatalog class methodsFor: 'initialization' stamp: 'GDH 6/9/2021 22:32:11'!
for: aValidProductsCollection
	
	^self new initializeFor: aValidProductsCollection .! !


!classDefinition: #ShoppingCart category: 'TusLibros'!
Object subclass: #ShoppingCart
	instanceVariableNames: 'products catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ShoppingCart methodsFor: 'testing' stamp: 'GDH 6/9/2021 19:50:05'!
isEmpty

	^products isEmpty.! !


!ShoppingCart methodsFor: 'assertions' stamp: 'GDH 6/9/2021 22:49:57'!
assertProductIdIsValid: aProductId
	
	(aProductId isEmpty) ifTrue: [ self error: ShoppingCart productIdCanNotBeEmptyErrorMessage ].
	
	catalog assertProductIsValid: aProductId .! !


!ShoppingCart methodsFor: 'initialization' stamp: 'GDH 6/9/2021 22:49:57'!
initializeFor: aProductsCatalog
	
	products := OrderedCollection new.
	catalog := aProductsCatalog.! !


!ShoppingCart methodsFor: 'adding' stamp: 'GDH 6/9/2021 22:22:13'!
addProduct: aProductId 
	
	self assertProductIdIsValid: aProductId .
			
	^products add: aProductId .! !


!ShoppingCart methodsFor: 'inspecting' stamp: 'GDH 6/9/2021 21:56:07'!
productsContained

	^products! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCart class' category: 'TusLibros'!
ShoppingCart class
	instanceVariableNames: ''!

!ShoppingCart class methodsFor: 'error messages' stamp: 'GDH 6/9/2021 20:19:56'!
productIdCanNotBeEmptyErrorMessage

	^'No se puede agregar un producto con id vacío.'! !


!ShoppingCart class methodsFor: 'initialization' stamp: 'GDH 6/9/2021 22:39:10'!
for: aProductsCatalog
	
	^self new initializeFor: aProductsCatalog .! !
