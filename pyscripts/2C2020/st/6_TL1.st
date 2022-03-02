!classDefinition: #CartTests category: 'TusLibros-Ejercicio'!
TestCase subclass: #CartTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!CartTests methodsFor: 'as yet unclassified' stamp: 'as 11/19/2020 16:23:21'!
test01NewCartIsEmpty
	
	|cart|
	cart := Cart newWith: (OrderedCollection with: 'Harry Potter y la piedra filosofal').
	
	self assert: cart isEmpty.! !

!CartTests methodsFor: 'as yet unclassified' stamp: 'as 11/19/2020 16:23:16'!
test02CartWithOneBookIsNotEmpty
	
	|cart|
	cart := Cart newWith: (OrderedCollection with: 'Harry Potter y la piedra filosofal').
	cart addToCart: 'Harry Potter y la piedra filosofal'.
	
	self assert: cart isEmpty not.! !

!CartTests methodsFor: 'as yet unclassified' stamp: 'as 11/19/2020 16:23:10'!
test03ListEmptyCartReturnsEmptyOrderedCollection
	
	|cart|
	cart := Cart newWith: (OrderedCollection with: 'Harry Potter y la piedra filosofal').
	
	self assert: cart listCart equals: OrderedCollection new.! !

!CartTests methodsFor: 'as yet unclassified' stamp: 'as 11/19/2020 16:23:03'!
test04ListNotEmptyCartReturnsBooksInCart
	
	|cart|
	cart := Cart newWith: (OrderedCollection with: 'Harry Potter y la piedra filosofal').
	cart addToCart: 'Harry Potter y la piedra filosofal'.
	
	self assert: cart listCart equals: (OrderedCollection with: 'Harry Potter y la piedra filosofal').! !

!CartTests methodsFor: 'as yet unclassified' stamp: 'as 11/19/2020 16:24:36'!
test05CannotAddToCartBookNotPresentInCatalogue
	
	|cart|
	cart := Cart newWith: (OrderedCollection with: 'Harry Potter y la piedra filosofal').

	self 
		should: [ cart addToCart: 'Harry Potter y la camara secreta' ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: Cart invalidBookErrorMessage equals: anError messageText. ]
	
	! !


!classDefinition: #Cart category: 'TusLibros-Ejercicio'!
Object subclass: #Cart
	instanceVariableNames: 'booksInCart catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Cart methodsFor: 'as yet unclassified' stamp: 'as 11/16/2020 19:36:21'!
addToCart: aBook
	(catalogue includes: aBook) ifFalse: [^Error signal: self class invalidBookErrorMessage ].
	booksInCart add: aBook.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'as 11/19/2020 16:14:17'!
initializeWith: aCatalogue
	booksInCart := OrderedCollection new.
	catalogue := aCatalogue.
	! !

!Cart methodsFor: 'as yet unclassified' stamp: 'as 11/16/2020 19:07:54'!
isEmpty
	^booksInCart isEmpty.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'as 11/16/2020 19:14:12'!
listCart
	^booksInCart.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros-Ejercicio'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'as 11/16/2020 19:22:00'!
invalidBookErrorMessage
	^'Invalid book!!'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'as 11/19/2020 16:18:04'!
newWith: aCatalogue
	^self new initializeWith: aCatalogue.! !
