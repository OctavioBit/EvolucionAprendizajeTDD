!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'empty cart' stamp: 'eb 11/16/2020 18:55:33'!
test01CartIsEmptyAtTheBeginning
	
	| cart |
	
	cart _ Cart new .
	
	self assert: cart isEmpty .! !


!CartTest methodsFor: 'single book cart' stamp: 'ja 11/17/2020 18:24:59'!
test02CanAddToCartABookInCatalogue
	
	| cart catalogue |
	
	cart _ Cart new .
	catalogue _ Set with: 'book1' with: 'book2'.
	
	cart add: 'book1' withOccurrences: 1 from: catalogue .
	
	self deny: cart isEmpty .
	self assert: (cart has: 'book1' times: 1).! !


!CartTest methodsFor: 'multiple books cart' stamp: 'ja 11/17/2020 18:25:05'!
test03CanNotAddToCartABookThatIsNotPresentInCatalogue
	
	| cart catalogue |
	
	cart _ Cart new .
	catalogue _ Set with: 'book1' with: 'book2'.
	
	self should: [ cart add: 'book3' withOccurrences: 1 from: catalogue . self fail.]
		raise: Error
		withMessageText: Cart bookIsNotInCatalogueErrorDescription.
	
	self assert: cart isEmpty .
	self deny: (cart has: 'book3' times: 1).! !

!CartTest methodsFor: 'multiple books cart' stamp: 'ja 11/17/2020 18:25:12'!
test04MultipleBooksInCatalogueCanBeAddedToCart

	| cart catalogue |
	
	cart _ Cart new .
	catalogue _ Set with: 'book1' with: 'book2'.
	
	cart add: 'book1' withOccurrences: 1 from: catalogue .
	cart add: 'book2' withOccurrences: 2 from: catalogue .
	
	self deny: cart isEmpty .
	self assert: (cart has: 'book1' times: 1).
	self assert: (cart has: 'book2' times: 2).	! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'testing' stamp: 'ja 11/17/2020 17:55:05'!
has: aBook times: aQuantity

	^ (books occurrencesOf: aBook) = aQuantity 
	
	! !

!Cart methodsFor: 'testing' stamp: 'eb 11/16/2020 19:14:54'!
isEmpty

	^ books isEmpty .! !


!Cart methodsFor: 'adding' stamp: 'ja 11/17/2020 17:46:57'!
add: aBook withOccurrences: amount from: aCatalogue

	(aCatalogue includes: aBook) ifFalse: [self error: self class bookIsNotInCatalogueErrorDescription].
	
	books add: aBook withOccurrences: amount.
	
	! !


!Cart methodsFor: 'initialization' stamp: 'ja 11/17/2020 17:30:45'!
initialize
	
	books _ Bag new.! !


!Cart methodsFor: 'accesings' stamp: 'ja 11/17/2020 18:09:24'!
books
	
	^books copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error description' stamp: 'ja 11/17/2020 17:45:49'!
bookIsNotInCatalogueErrorDescription
	
	^ 'Book is not in catalogue'.! !
