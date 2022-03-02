!classDefinition: #TusLibrosCartTest category: #TusLibros!
TestCase subclass: #TusLibrosCartTest
	instanceVariableNames: 'includedISBN anotherIncludedISBN nonIncludedISBN aCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosCartTest methodsFor: 'setUp' stamp: 'HG 11/18/2020 17:41:51'!
setUp
	
	includedISBN _ 'XXXX'.
	anotherIncludedISBN _ 'YYYY'.
	
	nonIncludedISBN _ 'ZZZZ'.
	
	aCatalog _ { includedISBN . anotherIncludedISBN }! !


!TusLibrosCartTest methodsFor: 'tests' stamp: 'HG 11/18/2020 18:17:37'!
test01CartHasZeroProductsWhenCreated
	
	| cart |
	cart _ MarketCart withCatalog: aCatalog.
	
	self assert: 0 equals: (cart totalQuantity).
	! !

!TusLibrosCartTest methodsFor: 'tests' stamp: 'HG 11/18/2020 18:17:17'!
test02AddBookToCartAffectsCartListCorrectly
	
	| aProductISBN cart |
	cart _ MarketCart withCatalog: aCatalog.
	aProductISBN _ includedISBN.
	
	cart add: aProductISBN withQuantity: 1.
	
	self assert: 1 equals: (cart totalQuantity).
	self assert: (cart hasProduct: aProductISBN withQuantity: 1).
	! !

!TusLibrosCartTest methodsFor: 'tests' stamp: 'HG 11/18/2020 18:20:19'!
test03AddMultipleBooksAffectsCartListCorrectly
	
	|  cart  aProductISBN anotherProductISBN |
	cart _ MarketCart withCatalog: aCatalog.
	
	aProductISBN _ includedISBN.
	anotherProductISBN _ anotherIncludedISBN.

	cart add: aProductISBN withQuantity: 1.
	cart add: anotherProductISBN withQuantity: 1.
	
	self assert: 2 equals: (cart totalQuantity).
	self assert: (cart hasProduct: aProductISBN withQuantity: 1).
	self assert: (cart hasProduct: anotherProductISBN withQuantity: 1).
	! !

!TusLibrosCartTest methodsFor: 'tests' stamp: 'HG 11/18/2020 18:21:55'!
test04AddBooksWithMultipleQuantityAffectsCartListCorrectly
	
	|  cart  aProductISBN anotherProductISBN |
	cart _ MarketCart withCatalog: aCatalog.
	
	aProductISBN _ includedISBN.
	anotherProductISBN _ anotherIncludedISBN.

	cart add: aProductISBN withQuantity: 3.
	cart add: anotherProductISBN withQuantity: 4.
	
	self assert: 7 equals: (cart totalQuantity).
	self assert: (cart hasProduct: aProductISBN withQuantity: 3).
	self assert: (cart hasProduct: anotherProductISBN withQuantity: 4).
	self deny: (cart hasProduct: aProductISBN withQuantity: 4).
	self deny: (cart hasProduct: anotherProductISBN withQuantity: 3).
	! !

!TusLibrosCartTest methodsFor: 'tests' stamp: 'HG 11/18/2020 18:21:20'!
test05CanNotAddANonListedProduct
	
	|  cart  aProductISBN anotherProductISBN aNotListedProductISBN |
	cart _ MarketCart withCatalog: aCatalog.
	
	aProductISBN _ includedISBN.
	anotherProductISBN _ anotherIncludedISBN.
	aNotListedProductISBN _ nonIncludedISBN.

	cart add: aProductISBN withQuantity: 2.
	cart add: anotherProductISBN withQuantity: 1.
	
	self 
		should: [ cart add: aNotListedProductISBN withQuantity: 3. ]
		raise: Error
		withMessageText: MarketCart nonListedProductErrorDescription.
	
	self assert: 3 equals: (cart totalQuantity).
	self assert: (cart hasProduct: aProductISBN withQuantity: 2).
	self assert: (cart hasProduct: anotherProductISBN withQuantity: 1).
	self deny: (cart hasProduct: aNotListedProductISBN withQuantity: 3).
	! !

!TusLibrosCartTest methodsFor: 'tests' stamp: 'HG 11/18/2020 18:21:29'!
test06CanNotAddProductWithNonPositiveQuantity
	
	|  cart  aProductISBN |
	cart _ MarketCart withCatalog: aCatalog.
	
	aProductISBN _ includedISBN.
	
	self 
		should: [ cart add: aProductISBN withQuantity: -1. ]
		raise: Error
		withMessageText: MarketCart nonPositiveQuantityAddingErrorDescription..
	
	self assert: 0 equals: (cart totalQuantity).
	self deny: (cart hasProduct: aProductISBN withQuantity: 1).
	! !

!TusLibrosCartTest methodsFor: 'tests' stamp: 'HG 11/18/2020 18:21:34'!
test07CartCanListItsOwnProducts
	
	|  cart  aProductISBN anotherProductISBN products |
	cart _ MarketCart withCatalog: aCatalog.
	
	aProductISBN _ includedISBN.
	anotherProductISBN _ anotherIncludedISBN.
	
	cart add: aProductISBN withQuantity: 5. 
	cart add: anotherProductISBN withQuantity: 7. 
	
	products _ cart productList.
	
	self assert: (products size) equals: 12.
	self assert: (products occurrencesOf: aProductISBN) equals: 5.
	self assert: (products occurrencesOf: anotherProductISBN) equals: 7.! !


!classDefinition: #MarketCart category: #TusLibros!
Object subclass: #MarketCart
	instanceVariableNames: 'product products catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MarketCart methodsFor: 'adding' stamp: 'HG 11/18/2020 17:51:47'!
add: aMarketProduct withQuantity: aQuantity

	self assertThatProductIsListed: aMarketProduct.
	self assertThatPositiveQuantityToAdd: aQuantity.
	
	products add: aMarketProduct withOccurrences: aQuantity.! !


!MarketCart methodsFor: 'accesing' stamp: 'HG 11/18/2020 18:17:17'!
totalQuantity
	^products size.! !


!MarketCart methodsFor: 'assertions' stamp: 'HG 11/18/2020 18:02:26'!
assertThatPositiveQuantityToAdd: aQuantity

	^ (aQuantity <= 0) 
		ifTrue: [ self signalNonPositiveQuantity. ]! !

!MarketCart methodsFor: 'assertions' stamp: 'HG 11/18/2020 18:02:18'!
assertThatProductIsListed: aMarketProduct

	^ (catalog includes: aMarketProduct) 
		ifFalse: [ self signalProductNotListed. ]! !


!MarketCart methodsFor: 'testing' stamp: 'HG 11/18/2020 17:24:04'!
hasProduct: aMarketProduct withQuantity: aQuantity
	^(products occurrencesOf: aMarketProduct) = aQuantity. ! !


!MarketCart methodsFor: 'initialization' stamp: 'HG 11/18/2020 17:38:57'!
initializeWithCatalog: aISBNCatalog
	products _ Bag new.
	catalog _ Set newFrom: aISBNCatalog.! !


!MarketCart methodsFor: 'error handling' stamp: 'HG 11/18/2020 17:49:30'!
signalNonPositiveQuantity
	^self error: self class nonPositiveQuantityAddingErrorDescription . ! !

!MarketCart methodsFor: 'error handling' stamp: 'HG 11/18/2020 17:37:57'!
signalProductNotListed
	^self error: self class nonListedProductErrorDescription. ! !


!MarketCart methodsFor: 'accessing' stamp: 'HG 11/18/2020 17:57:40'!
productList
	^products copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarketCart class' category: #TusLibros!
MarketCart class
	instanceVariableNames: 'products'!

!MarketCart class methodsFor: 'error description' stamp: 'HG 11/18/2020 17:33:15'!
nonListedProductErrorDescription
	^'The product is not listed'.! !

!MarketCart class methodsFor: 'error description' stamp: 'HG 11/18/2020 17:48:26'!
nonPositiveQuantityAddingErrorDescription
	^'Can not add a non positive quantity book.'.! !


!MarketCart class methodsFor: 'instance creation' stamp: 'HG 11/18/2020 17:39:29'!
withCatalog: aCatalog
	^self new initializeWithCatalog: aCatalog.! !
