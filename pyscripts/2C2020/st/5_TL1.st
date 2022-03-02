!classDefinition: #ShoppingCartTest category: 'TusLibros'!
TestCase subclass: #ShoppingCartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ShoppingCartTest methodsFor: 'tests - adding' stamp: 'FR 11/18/2020 17:23:56'!
test02ShoppingCartIsNotEmptyAfterAddingABook

	self  assertCartIsNotEmptyAfterDoing: [ :cart | cart addToCart: self aBook ]
		to: self aShoppingCartWithABookInCatalog! !

!ShoppingCartTest methodsFor: 'tests - adding' stamp: 'FR 11/18/2020 17:30:01'!
test03ShoppingCartIsNotEmptyAfterAddingSeveralBooks

	self  assertCartIsNotEmptyAfterDoing: [ :cart | cart addToCart: 4 of: self aDifferentBook ]
		to: self aShoppingCartWithADifferentBookInCatalog! !


!ShoppingCartTest methodsFor: 'tests - creation' stamp: 'FR 11/18/2020 17:28:42'!
test01ShoppingCartStartsEmpty

	self assert: self aShoppingCartWithEmptyCatalog isEmpty! !


!ShoppingCartTest methodsFor: 'tests - list' stamp: 'FR 11/19/2020 15:42:57'!
test04ShoppingCartListsBookCorrectlyAfterAddingOne

	self  assertCartListIs: {self aBook} asBag
		afterDoing: [ :cart | cart addToCart: self aBook]
		to: self aShoppingCartWithABookInCatalog! !

!ShoppingCartTest methodsFor: 'tests - list' stamp: 'FR 11/19/2020 15:42:31'!
test05ShoppingCartListsBooksCorrectlyAfterAddingMultiple

	self  assertCartListIs: { self aBook. self aBook. self aBook. self aBook} asBag
		afterDoing: [ :cart | cart addToCart: 4 of: self aBook]
		to: self aShoppingCartWithABookInCatalog! !


!ShoppingCartTest methodsFor: 'private - instances' stamp: 'FR 11/18/2020 17:06:57'!
aBook

	^ 9! !

!ShoppingCartTest methodsFor: 'private - instances' stamp: 'FR 11/18/2020 17:07:12'!
aDifferentBook

	^ 8! !

!ShoppingCartTest methodsFor: 'private - instances' stamp: 'FR 11/18/2020 17:23:55'!
aShoppingCartWithABookInCatalog

	^ ShoppingCart withCatalog: (Set with: self aBook)! !

!ShoppingCartTest methodsFor: 'private - instances' stamp: 'FR 11/18/2020 17:23:47'!
aShoppingCartWithADifferentBookInCatalog

	^ ShoppingCart withCatalog: (Set with: self aDifferentBook)! !

!ShoppingCartTest methodsFor: 'private - instances' stamp: 'FR 11/18/2020 17:28:42'!
aShoppingCartWithEmptyCatalog

	^ ShoppingCart new! !


!ShoppingCartTest methodsFor: 'tests - errors' stamp: 'FR 11/19/2020 15:35:12'!
test06CantAddBookNotInCatalogue

	self  assertAdding: self aDifferentBook
		withAmount: 1
		shouldFailWith: ShoppingCart bookNotCataloguedErrorDesciption! !

!ShoppingCartTest methodsFor: 'tests - errors' stamp: 'FR 11/19/2020 15:35:17'!
test07CantAddANegativeAmountOfBooks

	self  assertAdding: self aBook
		withAmount: -3
		shouldFailWith: ShoppingCart invalidAmountErrorDesciption! !

!ShoppingCartTest methodsFor: 'tests - errors' stamp: 'FR 11/19/2020 15:35:20'!
test08CantAddZeroBooks

	self  assertAdding: self aBook
		withAmount: 0
		shouldFailWith: ShoppingCart invalidAmountErrorDesciption! !


!ShoppingCartTest methodsFor: 'private - assertions' stamp: 'FR 11/18/2020 17:25:36'!
assert: anAssertionOnTheCart afterDoing: aBlock to: aShoppingCart

	| shoppingCart |
	
	shoppingCart := aShoppingCart.
	
	aBlock value: shoppingCart.
		
	self assert: (anAssertionOnTheCart value: shoppingCart)! !

!ShoppingCartTest methodsFor: 'private - assertions' stamp: 'FR 11/18/2020 17:23:56'!
assertAdding: bookToAdd withAmount: anAmount shouldFailWith: errorMessage
	
	self  should: [ self aShoppingCartWithABookInCatalog addToCart: anAmount of: bookToAdd ]
		raise: Error - MessageNotUnderstood
		withMessageText: errorMessage! !

!ShoppingCartTest methodsFor: 'private - assertions' stamp: 'FR 11/19/2020 15:41:15'!
assertCartIsNotEmptyAfterDoing: aBlock to: aShoppingCart

	self  assert: [ :cart | cart isEmpty not ]
		afterDoing: aBlock
		to: aShoppingCart! !

!ShoppingCartTest methodsFor: 'private - assertions' stamp: 'FR 11/19/2020 15:41:19'!
assertCartListIs: expectedCartList afterDoing: aBlock to: aShoppingCart
	
	self  assert: [ :cart | cart list = expectedCartList ]
		afterDoing: aBlock
		to: aShoppingCart! !


!classDefinition: #ShoppingCart category: 'TusLibros'!
Object subclass: #ShoppingCart
	instanceVariableNames: 'contents catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ShoppingCart methodsFor: 'testing' stamp: 'FR 11/18/2020 16:48:40'!
isEmpty
	
	^ contents isEmpty! !


!ShoppingCart methodsFor: 'adding' stamp: 'FR 11/18/2020 16:44:35'!
addToCart: aBook

	self addToCart: 1 of: aBook! !

!ShoppingCart methodsFor: 'adding' stamp: 'FR 11/18/2020 16:56:21'!
addToCart: anAmount of: aBook 

	self assertIsInCatalog: aBook.
	self assertIsValidAmount: anAmount.
	
	contents add: aBook withOccurrences: anAmount ! !


!ShoppingCart methodsFor: 'initialization' stamp: 'FR 11/18/2020 16:51:15'!
initialize

	self initializeWith: Set new! !

!ShoppingCart methodsFor: 'initialization' stamp: 'FR 11/18/2020 16:50:48'!
initializeWith: aCatalog

	catalog := aCatalog.
	contents := Bag new! !


!ShoppingCart methodsFor: 'private - errors' stamp: 'FR 11/18/2020 16:57:54'!
invalidAmountError

	^ self error: self class invalidAmountErrorDesciption! !

!ShoppingCart methodsFor: 'private - errors' stamp: 'FR 11/18/2020 16:57:42'!
notCataloguedError

	^ self error: self class bookNotCataloguedErrorDesciption! !


!ShoppingCart methodsFor: 'accessing' stamp: 'FR 11/18/2020 16:48:32'!
list
	
	^ contents copy! !


!ShoppingCart methodsFor: 'private - assertions' stamp: 'FR 11/18/2020 16:57:42'!
assertIsInCatalog: aBook

	^ (catalog includes: aBook) ifFalse: [ self notCataloguedError ]! !

!ShoppingCart methodsFor: 'private - assertions' stamp: 'FR 11/18/2020 16:57:54'!
assertIsValidAmount: anAmount

	^ anAmount <= 0 ifTrue: [ self invalidAmountError ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCart class' category: 'TusLibros'!
ShoppingCart class
	instanceVariableNames: ''!

!ShoppingCart class methodsFor: 'instance creation' stamp: 'FR 11/18/2020 16:50:29'!
withCatalog: aCatalog
	
	^ self new initializeWith: aCatalog! !


!ShoppingCart class methodsFor: 'error description' stamp: 'FR 11/18/2020 16:49:46'!
bookNotCataloguedErrorDesciption
	
	^ 'This book is not available!!'! !

!ShoppingCart class methodsFor: 'error description' stamp: 'FR 11/18/2020 16:55:26'!
invalidAmountErrorDesciption
	
	^ 'Amount must not be zero!!'! !
