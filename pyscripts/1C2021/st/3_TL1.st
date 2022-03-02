!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'catalogues' stamp: 'lmalvarez 6/9/2021 23:13:03'!
catalogueWith: aProduct

	| catalogue |
	
	catalogue := Catalogue new.
	
	catalogue add: aProduct.
	
	^ catalogue! !

!CartTest methodsFor: 'catalogues' stamp: 'lmalvarez 6/9/2021 23:18:02'!
catalogueWith: aProduct and: anotherProduct

	| catalogue |
	
	catalogue := Catalogue new.
	
	catalogue add: aProduct.
	catalogue add: anotherProduct.
	
	^ catalogue! !

!CartTest methodsFor: 'catalogues' stamp: 'lmalvarez 6/9/2021 23:15:18'!
emptyCatalogue

	^ Catalogue new.! !


!CartTest methodsFor: 'tests' stamp: 'lmalvarez 6/9/2021 23:15:35'!
test01NewCartShouldBeEmpty
	
	self assert: (Cart with: self emptyCatalogue) isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'lmalvarez 6/9/2021 23:16:30'!
test02OneProductShouldBeInTheCartAfterAddingIt

	| cart product |
	
	product := 'Book'.
	
	cart := Cart with: (self catalogueWith: product).
	
	cart add: 1 of: product.
	
	self deny: cart isEmpty.
	self assert: (cart has: product).! !

!CartTest methodsFor: 'tests' stamp: 'lmalvarez 6/9/2021 23:24:59'!
test03ManyProductsShouldBeInTheCartAfterAddingThem

	| cart productA productB |
	
	productA := 'Book'.
	productB := 'BookOfFairyTales'.
	
	cart := Cart with: ( self catalogueWith: productA and: productB ).
	
	cart add: 1 of: productA.	
	cart add: 1 of: productB.
	
	self deny: cart isEmpty.
	self assert: (cart has: productA).
	self assert: (cart has: productB).! !

!CartTest methodsFor: 'tests' stamp: 'lmalvarez 6/9/2021 23:19:08'!
test04MultipleInstancesOfTheSameProductShouldBeQuantifiedByTheCart

	| cart product |
	
	product := 'Book'.
	cart := Cart with: ( self catalogueWith: product ).
	
	cart add: 5 of: product.	
	
	self deny: cart isEmpty.
	self assert: (cart quantityOf: product) equals: 5.! !

!CartTest methodsFor: 'tests' stamp: 'lmalvarez 6/9/2021 23:14:42'!
test05CannotAddAProductThatIsNotInTheCatalogue

	| cart productA productB |
	
	productA := 'Book'.
	productB := 'BookOfDarkHorrorPower'.
	
	cart := Cart with: (self catalogueWith: productA).
	
	cart add: 1 of: productA.
	
	self deny: cart isEmpty.
	self assert: (cart has: productA).
	
	self should: [cart add: 1 of: productB ] 
		raise: Error
		withMessageText: Cart cannotAddAProductThatIsNotInCatalogueErrorSignal.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'products catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'accessing' stamp: 'lmalvarez 6/9/2021 23:40:10'!
add: anAmount of: aProduct

	self assertThatCatalogueHas: aProduct.
	products add: aProduct withOccurrences: anAmount.
	! !

!Cart methodsFor: 'accessing' stamp: 'lmalvarez 6/9/2021 23:40:45'!
assertThatCatalogueHas: aProduct

	(catalogue has: aProduct) ifFalse: [ self error: self class cannotAddAProductThatIsNotInCatalogueErrorSignal ]! !


!Cart methodsFor: 'initialization' stamp: 'lmalvarez 6/9/2021 23:04:42'!
initializeWith: aCatalogue

	products := Bag new.
	catalogue := aCatalogue.! !


!Cart methodsFor: 'testing' stamp: 'lmalvarez 6/9/2021 22:36:50'!
has: aProduct
	
	^ products includes: aProduct! !

!Cart methodsFor: 'testing' stamp: 'lmalvarez 6/9/2021 22:36:20'!
isEmpty
	^ products isEmpty! !

!Cart methodsFor: 'testing' stamp: 'lmalvarez 6/9/2021 22:49:37'!
quantityOf: aProduct 
	
	^ products occurrencesOf: aProduct.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error signals' stamp: 'lmalvarez 6/9/2021 23:05:48'!
cannotAddAProductThatIsNotInCatalogueErrorSignal

	^ 'Error - Product cannot be added to the catalogue'! !


!Cart class methodsFor: 'instance creation' stamp: 'lmalvarez 6/9/2021 23:03:46'!
with: aCatalogue

	^ self new initializeWith: aCatalogue! !


!classDefinition: #Catalogue category: 'TusLibros'!
Object subclass: #Catalogue
	instanceVariableNames: 'availableProducts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Catalogue methodsFor: 'accessing' stamp: 'lmalvarez 6/9/2021 23:02:41'!
add: aProduct

	availableProducts add: aProduct.! !


!Catalogue methodsFor: 'testing' stamp: 'lmalvarez 6/9/2021 23:08:42'!
has: aProduct

	^ availableProducts includes: aProduct.! !


!Catalogue methodsFor: 'initialization' stamp: 'lmalvarez 6/9/2021 23:03:10'!
initialize

	availableProducts := Set new.! !
