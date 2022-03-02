!classDefinition: #CartTest category: 'TusLibros - Exercise - I'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - I'!

!CartTest methodsFor: 'utils' stamp: 'fr 11/18/2020 18:16:17'!
bookInCatalogue

	^ '978-92-8001-4214-3'! !

!CartTest methodsFor: 'utils' stamp: 'fr 11/18/2020 18:17:29'!
bookNotInCatalogue

	^ '975-95-8351-4584-1'! !

!CartTest methodsFor: 'utils' stamp: 'fr 11/18/2020 18:56:16'!
catalogue

	^ {self bookInCatalogue}! !

!CartTest methodsFor: 'utils' stamp: 'fr 11/18/2020 18:15:44'!
newCart

	^ Cart withCatalogue: self catalogue! !


!CartTest methodsFor: 'tests' stamp: 'fr 11/18/2020 18:41:43'!
test01NewCartIsEmpty

	self assert: self newCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'fr 11/18/2020 18:42:04'!
test02CartIsNotEmptyAfterAddingAnItem
	
	| cart |
	cart _ self newCart.
	cart add: 1 of: self bookInCatalogue.
	self deny: cart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'fr 11/18/2020 18:42:25'!
test03CartIncludesAddedItems
	
	| cart |
	cart _ self newCart.
	cart add: 1 of: self bookInCatalogue.
	self assert: (cart includes: self bookInCatalogue)! !

!CartTest methodsFor: 'tests' stamp: 'fr 11/18/2020 18:42:37'!
test04CartDoesNotIncludeNotAddedItems

	self deny: (self newCart includes: self bookInCatalogue)! !

!CartTest methodsFor: 'tests' stamp: 'fr 11/18/2020 18:44:41'!
test05CartRegistersQuantitiesOfAddedItemsProperly
	
	| cart |
	cart _ self newCart.
	cart add: 2 of: self bookInCatalogue.
	self assert: (cart occurrencesOf: self bookInCatalogue) equals: 2! !

!CartTest methodsFor: 'tests' stamp: 'fr 11/18/2020 18:45:31'!
test06CarDoesNotRegisterQuantitiesOfNotAddedItems

	self assert: (self newCart occurrencesOf: self bookInCatalogue) equals: 0! !

!CartTest methodsFor: 'tests' stamp: 'fr 11/18/2020 18:45:57'!
test07AddingQuantityMustBeStrictlyPositive
	
	| cart |
	cart _ self newCart.
	self should: [cart add: 0 of: self bookInCatalogue]
	      raise:  Error - MessageNotUnderstood 
	      withExceptionDo: [:anError |
								self assert: anError messageText equals: Cart invalidQuantityErrorDescription.
								self assert: cart isEmpty.
					  ]
! !

!CartTest methodsFor: 'tests' stamp: 'fr 11/18/2020 18:46:23'!
test08CanNotAddItemsThatAreNotInCatalogue
	
	| cart |
	cart _ self newCart.

	self should: [cart add: 2 of: self bookNotInCatalogue]
	      raise: Error - MessageNotUnderstood 
	      withExceptionDo: [:anError | 
								self assert: anError messageText equals: Cart invalidItemErrorDescription.
								self assert: cart isEmpty.
					  ] 
! !

!CartTest methodsFor: 'tests' stamp: 'fr 11/18/2020 18:46:52'!
test09ListForANewCartIsEmpty
	
	self assert: self newCart listCart isEmpty
	
! !

!CartTest methodsFor: 'tests' stamp: 'fr 11/18/2020 18:47:22'!
test10ListHoldsAddedItemsWithCorrectQuantities
	
	| cart list |
	cart _ self newCart.
	cart add: 2 of: self bookInCatalogue.
	list _ cart listCart.
	
	self assert:  (list occurrencesOf: self bookInCatalogue) equals: 2.
	self assert: list size equals: 2
	
! !


!classDefinition: #Cart category: 'TusLibros - Exercise - I'!
Object subclass: #Cart
	instanceVariableNames: 'items catalog catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - I'!

!Cart methodsFor: 'testing' stamp: 'fr 11/18/2020 18:47:46'!
includes: anItem

	^items includes: anItem
	
	! !

!Cart methodsFor: 'testing' stamp: 'fr 11/18/2020 18:47:46'!
isEmpty
	
	^items isEmpty! !

!Cart methodsFor: 'testing' stamp: 'fr 11/18/2020 18:47:46'!
occurrencesOf: anItem

	^items occurrencesOf: anItem	
	! !


!Cart methodsFor: 'adding' stamp: 'fr 11/18/2020 18:47:46'!
add: aQuantity of: anItem

	self validateQuantity: aQuantity.
	self validateItem: anItem.
	
	items add: anItem withOccurrences: aQuantity 
	
	! !


!Cart methodsFor: 'error' stamp: 'fr 11/18/2020 18:18:55'!
signalInvalidItemError

	^ self error: self class invalidItemErrorDescription! !

!Cart methodsFor: 'error' stamp: 'fr 11/18/2020 18:18:40'!
signalInvalidQuantityError

	^ self error: self class invalidQuantityErrorDescription! !


!Cart methodsFor: 'validation' stamp: 'fr 11/18/2020 18:58:00'!
validateItem: anItem

	^ (catalogue includes: anItem) ifFalse: [self signalInvalidItemError]! !

!Cart methodsFor: 'validation' stamp: 'fr 11/18/2020 18:19:06'!
validateQuantity: aQuantity

	^ aQuantity <= 0 ifTrue: [self signalInvalidQuantityError]! !


!Cart methodsFor: 'initialization' stamp: 'fr 11/18/2020 18:47:46'!
initializeWithCatalogue: aCatalogue 

	items _ Bag new.
	catalogue _ aCatalogue.! !


!Cart methodsFor: 'listing' stamp: 'fr 11/18/2020 18:47:46'!
listCart
	
	^items copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros - Exercise - I'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'fr 11/18/2020 18:13:08'!
withCatalogue: aCatalogue 
	
	^self new initializeWithCatalogue: aCatalogue ! !


!Cart class methodsFor: 'error description' stamp: 'fr 11/18/2020 18:09:20'!
invalidItemErrorDescription
	
	^'Item is not in catalogue'! !

!Cart class methodsFor: 'error description' stamp: 'fr 11/18/2020 18:05:17'!
invalidQuantityErrorDescription
	
	^'Quantity must be strictly positive'! !
