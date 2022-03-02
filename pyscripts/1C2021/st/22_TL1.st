!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'aBook invalidBook aCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'CD 6/8/2021 18:45:40'!
test01NewCartIsEmpty

	| cart |
	cart := Cart initializeWith: aCatalog.

	self assert: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'CD 6/8/2021 18:45:52'!
test02CartIsNonEmptyAfterAddingAnItem

	| cart |
	cart := Cart initializeWith: aCatalog.
	
	cart add: 1 copiesOf: aBook.
	
	self deny: cart isEmpty.
! !

!CartTest methodsFor: 'tests' stamp: 'CD 6/8/2021 23:32:52'!
test03CannotAddToCartItemsThatNotBelongToTheCatalog

	| cart |
	cart := Cart initializeWith: aCatalog.
	
	self should: [ cart add: 1 copiesOf: invalidBook ] raise: Error withMessageText: Cart invalidBookMessage.
	self assert: cart isEmpty. 
	
! !

!CartTest methodsFor: 'tests' stamp: 'CD 6/8/2021 23:31:35'!
test04CannotAddToCartANonPositiveQuantityOfItems

	| cart |
	cart := Cart initializeWith: aCatalog.
	
	self should: [ cart add: 0 copiesOf: aBook] raise: Error withMessageText: Cart invalidQuantity.
	self assert: cart isEmpty.
	self should: [ cart add: -2 copiesOf: aBook] raise: Error withMessageText: Cart invalidQuantity.
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'CD 6/8/2021 23:37:47'!
test05CanAddDuplicatedCopiesOfBook

	| cart |
	cart := Cart initializeWith: aCatalog.
	
	cart add: 3 copiesOf: aBook.
	
	self assert: cart includes: aBook.
	self assert: cart totalItems equals: 3.! !


!CartTest methodsFor: 'setUp' stamp: 'CD 6/8/2021 10:44:27'!
setUp

	aBook := 'Persuasion'.
	invalidBook := 'Concrete Mathematics'.
	aCatalog := OrderedCollection with: aBook.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'items catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'add' stamp: 'CD 6/8/2021 23:26:09'!
add: aNumber copiesOf: aBook
	
	self assertIsValidBook: aBook.
	self assertIsValidQuantity: aNumber.
	items add: aBook withOccurrences: aNumber.! !


!Cart methodsFor: 'initializers' stamp: 'CD 6/8/2021 18:44:40'!
initializeWith: aCatalog
	
	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'assertions' stamp: 'CD 6/8/2021 23:23:31'!
assertIsValidBook: aBook

	(catalog includes: aBook) ifFalse: [self error: Cart invalidBookMessage].

	! !

!Cart methodsFor: 'assertions' stamp: 'CD 6/8/2021 23:31:01'!
assertIsValidQuantity: aNumber

	(aNumber strictlyPositive) ifFalse: [self error: Cart invalidQuantity].
 
	! !

!Cart methodsFor: 'assertions' stamp: 'CD 6/8/2021 10:38:16'!
isEmpty

	^ items isEmpty.! !


!Cart methodsFor: 'auxiliars' stamp: 'CD 6/8/2021 23:38:34'!
includes: aBook

	^ items includes: aBook.! !

!Cart methodsFor: 'auxiliars' stamp: 'CD 6/8/2021 23:40:26'!
totalItems

	^ items size.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'initializers' stamp: 'CD 6/8/2021 18:45:12'!
initializeWith: aCatalog

	^ self new initializeWith: aCatalog.! !


!Cart class methodsFor: 'error-messages' stamp: 'CD 6/8/2021 23:30:48'!
invalidBookMessage

	^ 'Book is not in catalog'.! !

!Cart class methodsFor: 'error-messages' stamp: 'CD 6/8/2021 23:30:44'!
invalidQuantity

	^ 'Quantity of items must be strictly positive'.! !
