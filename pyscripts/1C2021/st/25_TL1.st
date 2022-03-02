!classDefinition: #CartsTest category: 'TusLibros'!
TestCase subclass: #CartsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartsTest methodsFor: 'tests' stamp: 'LM 6/9/2021 18:48:16'!
test01cartIsEmptyWhenCreated

	| cart publisher |
	
	publisher := Publisher withRegisteredISBNs: #().
	cart := Cart for: publisher.
	
	self assert: cart isEmpty.! !

!CartsTest methodsFor: 'tests' stamp: 'LM 6/9/2021 19:25:52'!
test02cartIsNotEmptyAfterAddingABookFromPublisher

	| cart book publisher |
	
	publisher := Publisher withRegisteredISBNs: #('9780262531962').
	cart := Cart for: publisher.
	book := Book isbn: '9780262531962'.
	cart add: 1 of: book.
	
	self deny: cart isEmpty.! !

!CartsTest methodsFor: 'tests' stamp: 'LM 6/9/2021 19:26:02'!
test03severalCopiesOfSameBookFromPublisherCanBeAdded

	| cart book expectedCartBooks publisher |
	
	publisher := Publisher withRegisteredISBNs: #('9780262531962').
	cart := Cart for: publisher.
	book := Book isbn: '9780262531962'.
	expectedCartBooks := OrderedCollection with: book with: book.
	
	cart add: 2 of: book.
	
	self assert: expectedCartBooks equals: cart books.! !

!CartsTest methodsFor: 'tests' stamp: 'LM 6/9/2021 19:25:46'!
test04cannotAddBooksThatDoNotBelongToPublisher

	| cart book publisher |
	
	publisher := Publisher withRegisteredISBNs: #('9780262531962').
	cart := Cart for: publisher.
	book := Book isbn: '9780262531963'.
	
	self should: [cart add: 1 of: book]
		raise: Error - MessageNotUnderstood
		withMessageText: Cart bookNotRegisteredByPublisherErrorDescription.
	self assert: cart isEmpty.! !

!CartsTest methodsFor: 'tests' stamp: 'LM 6/9/2021 19:06:56'!
test05cannotAddANegativeNumberOfBooks

	| cart book publisher |
	
	publisher := Publisher withRegisteredISBNs: #('9780262531962').
	cart := Cart for: publisher.
	book := Book isbn: '9780262531962'.
	
	self should: [cart add: -1 of: book]
		raise: Error - MessageNotUnderstood
		withMessageText: Cart invalidBookQuantityErrorDescription.
	self assert: cart isEmpty.! !

!CartsTest methodsFor: 'tests' stamp: 'LM 6/9/2021 19:11:02'!
test06cannotAddANonIntegerNumberOfBooks

	| cart book publisher |
	
	publisher := Publisher withRegisteredISBNs: #('9780262531962').
	cart := Cart for: publisher.
	book := Book isbn: '9780262531962'.
	
	self should: [cart add: 1.5 of: book]
		raise: Error - MessageNotUnderstood
		withMessageText: Cart invalidBookQuantityErrorDescription.
	self assert: cart isEmpty.! !


!classDefinition: #Book category: 'TusLibros'!
Object subclass: #Book
	instanceVariableNames: 'ISBN'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Book methodsFor: 'initialization' stamp: 'LM 6/9/2021 17:39:31'!
initializeIsbn: anISBN 

	ISBN := anISBN.! !


!Book methodsFor: 'accessing' stamp: 'LM 6/9/2021 18:57:44'!
ISBN

	^ISBN! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Book class' category: 'TusLibros'!
Book class
	instanceVariableNames: ''!

!Book class methodsFor: 'instance creation' stamp: 'LM 6/9/2021 17:38:42'!
isbn: anISBN

	^self new initializeIsbn: anISBN ! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books publisher'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'LM 6/9/2021 17:49:50'!
initialize

	books := OrderedCollection new.! !

!Cart methodsFor: 'initialization' stamp: 'LM 6/9/2021 18:43:33'!
initializeFor: aPublisher

	publisher := aPublisher.! !


!Cart methodsFor: 'adding' stamp: 'LM 6/9/2021 19:18:45'!
add: aQuantity of: aBook 

	self assertCanAdd: aQuantity of: aBook.
	
	aQuantity timesRepeat: [ books add: aBook ].! !


!Cart methodsFor: 'accessing' stamp: 'LM 6/9/2021 18:03:06'!
books

	^books copy! !


!Cart methodsFor: 'testing' stamp: 'LM 6/9/2021 17:50:30'!
isEmpty

	^books isEmpty! !


!Cart methodsFor: 'asserting' stamp: 'LM 6/9/2021 19:22:10'!
assertCanAdd: aQuantity of: aBook

	(publisher isInCatalog: aBook ISBN) ifFalse: [
		self signalBookNotRegisteredError
	].
	(aQuantity > 0 and: [aQuantity is: #Integer]) ifFalse: [
		self signalInvalidBookQuantityError
	].! !

!Cart methodsFor: 'asserting' stamp: 'LM 6/9/2021 19:19:45'!
signalBookNotRegisteredError

	^ self error: self class bookNotRegisteredByPublisherErrorDescription! !

!Cart methodsFor: 'asserting' stamp: 'LM 6/9/2021 19:20:18'!
signalInvalidBookQuantityError

	^ self error: self class invalidBookQuantityErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'LM 6/9/2021 18:41:57'!
for: aPublisher

	^self new initializeFor: aPublisher! !


!Cart class methodsFor: 'error description' stamp: 'LM 6/9/2021 18:45:42'!
bookNotRegisteredByPublisherErrorDescription

	^'El libro que se intenta agregar no está en el catálogo'! !

!Cart class methodsFor: 'error description' stamp: 'LM 6/9/2021 19:08:13'!
invalidBookQuantityErrorDescription

	^'La cantidad de libros a agregar debe ser un entero positivo'! !


!classDefinition: #Publisher category: 'TusLibros'!
Object subclass: #Publisher
	instanceVariableNames: 'catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Publisher methodsFor: 'initialization' stamp: 'LM 6/9/2021 18:41:19'!
initializeWithRegisteredISBNs: aCollectionOfISBNs 

	catalog := OrderedCollection withAll: aCollectionOfISBNs.! !


!Publisher methodsFor: 'testing' stamp: 'LM 6/9/2021 19:00:28'!
isInCatalog: anISBN

	^catalog includes: anISBN.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Publisher class' category: 'TusLibros'!
Publisher class
	instanceVariableNames: ''!

!Publisher class methodsFor: 'instance creation' stamp: 'LM 6/9/2021 18:38:10'!
withRegisteredISBNs: aCollectionOfISBNs

	^self new initializeWithRegisteredISBNs: aCollectionOfISBNs! !
