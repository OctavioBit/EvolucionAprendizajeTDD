!classDefinition: #CarritoTest category: #TusLibros!
TestCase subclass: #CarritoTest
	instanceVariableNames: 'catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CarritoTest methodsFor: 'setUp/tearDown' stamp: 'ET 6/9/2021 19:19:06'!
setUp

	catalogue := BookCatalog new.! !


!CarritoTest methodsFor: 'tests - private' stamp: 'ET 6/9/2021 19:34:45'!
emptyCart
	
	^Cart withCatalog: catalogue.! !


!CarritoTest methodsFor: 'tests' stamp: 'ET 6/9/2021 19:37:57'!
test01NewCartIsEmpty

	|cart|
	
	cart := self emptyCart.
	
	self assert: cart isEmpty.! !

!CarritoTest methodsFor: 'tests' stamp: 'ET 6/9/2021 19:38:21'!
test02NewCartIsAddedABookAndItHasThatBook

	|cart book |
	
	book := Book new.
	catalogue addBook: book.
	cart := self emptyCart.
	
	cart addBook: book.
	
	self deny: cart isEmpty.
	self assert: (cart hasBook: book).! !

!CarritoTest methodsFor: 'tests' stamp: 'ET 6/9/2021 19:22:03'!
test03NewCartIsAddedTwoDifferentBooksAndItsListHasThoseBooks

	|cart book1 book2 |
	
	book1 := Book new.
	book2 := Book new.
	catalogue 
		addBook: book1;
		addBook: book2.

	cart := self emptyCart.
	cart addBook: book1;
		addBook: book2.
	
	self assert: cart bookList size equals: 2.
	self assert: (cart bookList includes: book1).
	self assert: (cart bookList includes: book2).! !

!CarritoTest methodsFor: 'tests' stamp: 'ET 6/9/2021 19:26:02'!
test04NewCartIsAddedTheSameBookTwiceAndItsListHasThoseBooks

	|cart book |
	
	book := Book new.
	catalogue addBook: book.
	cart := self emptyCart.
	
	cart addBook: book;
		addBook: book.
	
	self assert: cart bookList size equals: 2.
	self assert: (cart bookList occurrencesOf: book) equals: 2.! !

!CarritoTest methodsFor: 'tests' stamp: 'ET 6/9/2021 19:33:05'!
test05NewCartCannotAddBookThatIsNotInTheCatalog

	|cart book |
	
	cart := self emptyCart.
	book := Book new.
	
	self should:[cart addBook: book]
	raise: Error 
	withExceptionDo: [ :anError | self assert: anError messageText equals: (Cart canNotAddBookThatIsNotInTheCatalog) ].
	
	
! !


!classDefinition: #Book category: #TusLibros!
Object subclass: #Book
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!classDefinition: #BookCatalog category: #TusLibros!
Object subclass: #BookCatalog
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!BookCatalog methodsFor: 'initialization' stamp: 'ET 6/9/2021 19:04:20'!
initialize

	books := Set new.! !


!BookCatalog methodsFor: 'testing' stamp: 'ET 6/9/2021 19:08:51'!
hasBook: aBook

	^books includes: aBook.! !


!BookCatalog methodsFor: 'adding' stamp: 'ET 6/9/2021 19:03:59'!
addBook: aBook

	books add: aBook.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'books bookCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'testing' stamp: 'ET 6/9/2021 18:36:27'!
hasBook: aBook 
	^books includes: aBook.! !

!Cart methodsFor: 'testing' stamp: 'ET 6/9/2021 18:39:35'!
isEmpty
	
	^books isEmpty.! !


!Cart methodsFor: 'assertions' stamp: 'ET 6/9/2021 19:05:55'!
assertBookIsInCatalog: aBook

	(bookCatalog hasBook: aBook) ifFalse: [self error: self class canNotAddBookThatIsNotInTheCatalog ].! !


!Cart methodsFor: 'adding' stamp: 'ET 6/9/2021 18:58:19'!
addBook: aBook 

	self assertBookIsInCatalog: aBook.

	books add: aBook.! !


!Cart methodsFor: 'book list' stamp: 'ET 6/9/2021 18:43:53'!
bookList
	^books copy.! !


!Cart methodsFor: 'initialization' stamp: 'ET 6/9/2021 19:34:15'!
initializeWithCatalog: aBookCatalog 

	bookCatalog := aBookCatalog.
	books := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'ET 6/9/2021 19:34:45'!
withCatalog: aBookCatalog 
	
	^self new initializeWithCatalog: aBookCatalog.! !


!Cart class methodsFor: 'message error' stamp: 'ET 6/9/2021 18:59:07'!
canNotAddBookThatIsNotInTheCatalog
	
	^'No se puede agregar un libro que no está en el catálogo de compras'.! !
