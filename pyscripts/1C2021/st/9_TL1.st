!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'GR 6/10/2021 16:35:17'!
test01CartShouldBeEmptyWhenCreated
	|cart|
	
	cart := Cart for: BookCatalog new.
	
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'GR 6/10/2021 16:36:39'!
test02CartShouldAddCorrectAmountOfBooks
	|cart catalog book|
	
	book := Book withISBN: 12345678.
	
	catalog := BookCatalog new.
	
	catalog add: book.
	
	cart := Cart for: catalog.
	
	cart addAsMany: 2 books: book.
	
	self deny: cart isEmpty.
	
	self assert: 2 equals: cart amountOfItems.
	
	self assert: 2 equals: (cart howManyCopies: book).! !

!CartTest methodsFor: 'tests' stamp: 'GR 6/10/2021 16:36:56'!
test03CannotAddNotAvailableBook
	|cart catalog book|
	
	book := Book withISBN: 12345678.
	
	catalog := BookCatalog new.
	
	cart := Cart for: catalog.
	
	self
		should: [cart addAsMany: 1 books: book]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: Cart itemNotAvailableErrorMessage equals: anError messageText.
			self assert: cart isEmpty.
		].! !

!CartTest methodsFor: 'tests' stamp: 'GR 6/10/2021 16:39:33'!
test04CannotAddLessThanOneBook
	|cart catalog book|
	
	book := Book withISBN: 12345678.
	
	catalog := BookCatalog new.
	
	catalog add: book.
	
	cart := Cart for: catalog.
	
	self
		should: [cart addAsMany: 0 books: book]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: Cart cannotAddLessThanOneItemsErrorMessage equals: anError messageText.
			self assert: cart isEmpty.
		].! !

!CartTest methodsFor: 'tests' stamp: 'GR 6/10/2021 16:40:01'!
test05EmptyCartShouldReturnEmptyList
	|cart catalog list|
	
	catalog := BookCatalog new.
	cart := Cart for: catalog.
	
	list := cart listItems.
	
	self assert: list isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'GR 6/10/2021 16:44:13'!
test06ListShouldReflectItemsInCart 
	|cart catalog book list|
	
	catalog := BookCatalog new.
	cart := Cart for: catalog.
	book := Book withISBN: 12345678.
	
	catalog add: book.
	cart addAsMany: 2 books: book.	
	list := cart listItems.
	
	self assert: 2 equals: (list at: book).
	self assert: 1 equals: list size.! !


!classDefinition: #Book category: 'TusLibros'!
Object subclass: #Book
	instanceVariableNames: 'ISBN'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Book methodsFor: 'initialization' stamp: 'GR 6/10/2021 15:08:00'!
initializeWithISBN: anISBN 
	
	ISBN := anISBN.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Book class' category: 'TusLibros'!
Book class
	instanceVariableNames: ''!

!Book class methodsFor: 'instance creation' stamp: 'GR 6/10/2021 14:57:42'!
withISBN: anISBN
	^self new initializeWithISBN: anISBN .! !


!classDefinition: #BookCatalog category: 'TusLibros'!
Object subclass: #BookCatalog
	instanceVariableNames: 'contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!BookCatalog methodsFor: 'operations' stamp: 'GR 6/10/2021 14:58:34'!
add: aBook 
	contents add: aBook.! !


!BookCatalog methodsFor: 'accessing' stamp: 'GR 6/10/2021 14:58:14'!
initialize

	contents := OrderedCollection new.! !

!BookCatalog methodsFor: 'accessing' stamp: 'GR 6/10/2021 15:21:41'!
isAvailable: aBook 
	^contents includes: aBook.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'GR 6/10/2021 16:44:28'!
initializeFor: aBookCatalog 
	catalog := aBookCatalog.
	contents := OrderedCollection new.! !


!Cart methodsFor: 'operations' stamp: 'GR 6/10/2021 16:44:28'!
addAsMany: anAmount books: aBook 

	(anAmount = 0) ifTrue: [^self error: self class cannotAddLessThanOneItemsErrorMessage ].

	(catalog isAvailable: aBook) ifFalse: [^self error: self class itemNotAvailableErrorMessage]. 

	anAmount timesRepeat: [contents add: aBook].
	! !


!Cart methodsFor: 'accessing' stamp: 'GR 6/10/2021 15:01:49'!
amountOfItems
	^contents size.! !

!Cart methodsFor: 'accessing' stamp: 'GR 6/10/2021 15:06:56'!
howManyCopies: aBook 
	^contents occurrencesOf: aBook.! !

!Cart methodsFor: 'accessing' stamp: 'GR 6/10/2021 15:02:23'!
includes: aBook 
	^contents includes: aBook .! !

!Cart methodsFor: 'accessing' stamp: 'GR 6/10/2021 15:01:24'!
isEmpty
	^contents isEmpty .! !

!Cart methodsFor: 'accessing' stamp: 'GR 6/10/2021 16:31:36'!
listItems

	|list|
	
	list := Dictionary new.
	
	contents do: [:aBook | (list includesKey: aBook) ifFalse: [list add: aBook -> (self howManyCopies: aBook)]].
	
	^list! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'GR 6/10/2021 14:51:07'!
for: aBookCatalog 
	
 	^self new initializeFor: aBookCatalog.! !


!Cart class methodsFor: 'error messages' stamp: 'GR 6/10/2021 16:39:33'!
cannotAddLessThanOneItemsErrorMessage

	^'Cannot add less than one items to cart'! !

!Cart class methodsFor: 'error messages' stamp: 'GR 6/10/2021 15:19:20'!
itemNotAvailableErrorMessage

	^'Item is not available for sale'! !
