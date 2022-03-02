!classDefinition: #TestsTusLibros category: 'TusLibros'!
TestCase subclass: #TestsTusLibros
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestsTusLibros methodsFor: 'testsCart' stamp: 'Am 6/10/2021 11:13:17'!
test01createdCartIsInitializedEmpty
	|aCart aCatalog|
	
	aCatalog:= OrderedCollection new.
	aCart:= Cart withCatalog: aCatalog.
	self assert: aCart isEmpty equals: true.! !

!TestsTusLibros methodsFor: 'testsCart' stamp: 'Am 6/10/2021 11:22:13'!
test02addingBookFromCatalogIsRegistered
	|aCart aCatalog ISBNCormen|
	
	ISBNCormen:='9780262033848'.
	aCatalog:= OrderedCollection with: ISBNCormen.
	aCart:= Cart withCatalog: aCatalog.
	aCart addToCart: ISBNCormen withQuantity: 1.
	
	self assert: aCart size equals: 1.
	self assert:( aCart contains: ISBNCormen withQuantity: 1) equals: true.! !

!TestsTusLibros methodsFor: 'testsCart' stamp: 'Am 6/10/2021 11:43:07'!
test03cantAddBookNotFromCatalog
	|aCart aCatalog ISBNCormen ISBNBible|
	
	ISBNCormen:='9780262033848'.
	ISBNBible:= '9780840700551'.
	aCatalog:= OrderedCollection with: ISBNCormen.
	aCart:= Cart withCatalog: aCatalog.
	self 
		should: [	aCart addToCart: ISBNBible withQuantity: 1. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
				self assert: Cart invalidISBNError equals: anError messageText.
				self assert: aCart size = 0.
			]! !

!TestsTusLibros methodsFor: 'testsCart' stamp: 'Am 6/10/2021 12:06:57'!
test04cantAddZeroBooksToCart
	|aCart aCatalog ISBNCormen|
	
	ISBNCormen:='9780262033848'.
	aCatalog:= OrderedCollection with: ISBNCormen.
	aCart:= Cart withCatalog: aCatalog.
	self 
		should: [	aCart addToCart: ISBNCormen withQuantity: 0. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
				self assert: Cart zeroBooksAddedError equals: anError messageText.
				self assert: aCart size = 0.
			]! !

!TestsTusLibros methodsFor: 'testsCart' stamp: 'Am 6/10/2021 12:31:42'!
test05CartCanListAllBooksCorrectly
	|aCart aCatalog ISBNCormen ISBNWatkins|
	
	ISBNCormen:='9780262033848'.
	ISBNWatkins:= '9780470528334'.
	
	
	aCatalog:= OrderedCollection with: ISBNCormen with: ISBNWatkins .
	aCart:= Cart withCatalog: aCatalog.
	
	aCart addToCart: ISBNCormen withQuantity: 3.
	aCart addToCart: ISBNWatkins withQuantity: 2.
	
	self assert: aCart listCart equals:( OrderedCollection with: {ISBNCormen . 3} with: {ISBNWatkins . 2}).! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog cartContent'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'testing' stamp: 'Am 6/10/2021 12:02:37'!
contains: anISBN withQuantity: aNumber 
	
	^aNumber=(cartContent at: anISBN ifAbsent: [0] ).
	! !

!Cart methodsFor: 'testing' stamp: 'Am 6/10/2021 11:30:41'!
isEmpty
	^(self size = 0).! !


!Cart methodsFor: 'accessing' stamp: 'Am 6/10/2021 12:31:54'!
listCart
	|list|
	list:= OrderedCollection new.
	cartContent keysAndValuesDo: [:anISBN :anISBNQuantity | list addLast: {anISBN . anISBNQuantity}].
	^list.! !

!Cart methodsFor: 'accessing' stamp: 'Am 6/10/2021 12:01:15'!
size
	^cartContent sum:[:anISBNQuantity| anISBNQuantity] ifEmpty:[0].! !


!Cart methodsFor: 'adding' stamp: 'Am 6/10/2021 12:03:41'!
addToCart: anISBN withQuantity: aNumber 

	|appearances|
	
	(catalog includes: anISBN) ifFalse:[self error: 	Cart invalidISBNError ].
	(aNumber<1) ifTrue: [self error: 	Cart zeroBooksAddedError ].

	appearances:= cartContent at: anISBN ifAbsent: [0].
	cartContent add: anISBN-> (appearances+aNumber).
	
	 ! !


!Cart methodsFor: 'initialization' stamp: 'Am 6/10/2021 11:49:15'!
initializeWithCatalog: aCatalog 
	catalog := aCatalog.
	cartContent:= Dictionary  new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'initialize' stamp: 'Am 6/10/2021 11:15:00'!
withCatalog: aCatalog 
	^self new initializeWithCatalog: aCatalog.! !


!Cart class methodsFor: 'error' stamp: 'Am 6/10/2021 11:41:16'!
invalidISBNError
	^'Book not in Catalog'! !

!Cart class methodsFor: 'error' stamp: 'Am 6/10/2021 11:46:25'!
zeroBooksAddedError
	^'Must add at least one book'! !
