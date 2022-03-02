!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'plp 6/9/2021 17:24:54'!
test01NewCartHasNoItems

	| cart |
	cart := Cart new.
	
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'plp 6/9/2021 17:51:51'!
test02AddingOneBookToEmptyCartIsNoLongerEmpty

	| cart book |
	cart := Cart new.
	book := '978-0-07-575212-7' . " ISBN string "
	
	cart addBook: book quantity: 1.
	
	self deny: cart isEmpty.
	self assert: #( '978-0-07-575212-7' ) asOrderedCollection equals: cart books.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'plp 6/9/2021 17:52:02'!
test03AddingMultipleBooksToEmptyCartIsNoLongerEmpty

	| cart firstBook secondBook addedBooks |
	cart := Cart new.
	firstBook := '978-0-07-575212-7' . " ISBN string "
	secondBook := '978-0-07-587291-7' .
	
	cart addBook: firstBook quantity: 1.
	cart addBook: secondBook quantity: 1.
	
	addedBooks := OrderedCollection new.
	addedBooks add: firstBook .
	addedBooks add: secondBook .

	self assert: addedBooks equals: cart books.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'plp 6/9/2021 17:49:19'!
test04AddingOneBookMultipleTimesToEmptyCart

	| cart book addedBooks |
	cart := Cart new.
	book := '978-0-07-575212-7' . " ISBN string "

	cart addBook: book quantity: 5.
	
	addedBooks := OrderedCollection new.
	5 timesRepeat: [ addedBooks add: book ].

	self assert: addedBooks equals: cart books.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'plp 6/9/2021 17:58:23'!
test05AddingInvalidQuantityRaisesError

	| cart book |
	cart := Cart new.
	book := '978-0-07-575212-7' . " ISBN string "

	self should: [ cart addBook: book quantity: 0. ]
	      raise: Error
	      description: [ :error | self assert: error description equals: Cart invalidQuantityErrorDescription ].! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'book books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'plp 6/9/2021 17:54:18'!
addBook: anISBN quantity: aQuantity 
	
	self assertValidQuantity: aQuantity .
	aQuantity timesRepeat: [ books add: anISBN ]
	! !

!Cart methodsFor: 'as yet unclassified' stamp: 'plp 6/9/2021 17:55:10'!
assertValidQuantity: aQuantity

	aQuantity < 1 ifTrue: [ self error: self class invalidQuantityErrorDescription ]
	! !

!Cart methodsFor: 'as yet unclassified' stamp: 'plp 6/9/2021 17:42:08'!
books
	
	^ books! !

!Cart methodsFor: 'as yet unclassified' stamp: 'plp 6/9/2021 17:43:18'!
initialize

	books := OrderedCollection new.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'plp 6/9/2021 17:43:28'!
isEmpty
	
	^ books isEmpty.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'plp 6/9/2021 17:55:51'!
invalidQuantityErrorDescription

	^ 'Quantity must be greater or equal than 1'! !
