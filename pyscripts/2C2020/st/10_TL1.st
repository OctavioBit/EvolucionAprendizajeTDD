!classDefinition: #CartTest category: 'Tus Libros.com'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus Libros.com'!


!CartTest methodsFor: 'cart-tests' stamp: 'DB 11/18/2020 19:54:31'!
test01EmptyCartHasNoItems

	| cart |
	cart := Cart new.
	
	self assert: 0 equals: cart amountOfItems.! !

!CartTest methodsFor: 'cart-tests' stamp: 'DB 11/18/2020 19:56:20'!
test02ACartWithOneItemHasOneItem

	| cart aCatalog |
	aCatalog := OrderedCollection new.
	aCatalog add: '978-3-9820137-0-1'.
	cart := Cart with: aCatalog.
	
	cart add:  '978-3-9820137-0-1'.
	self assert: 1 equals: (cart amountOfItems).
	! !

!CartTest methodsFor: 'cart-tests' stamp: 'DB 11/18/2020 19:57:07'!
test03ACartWithMoreThanOneItemHasTheCorrectAmountOfItems

	| cart aCatalog |
	aCatalog := OrderedCollection new.
	aCatalog add: '978-3-9820137-0-1'.
	aCatalog add: '978-3-9820137-0-2'.
	cart := Cart with: aCatalog.
	
	cart add: '978-3-9820137-0-1' amount: 5.
	cart add: '978-3-9820137-0-2' amount: 3.
	
	self assert: 8 equals: (cart amountOfItems).! !

!CartTest methodsFor: 'cart-tests' stamp: 'DB 11/18/2020 19:39:50'!
test04CannotAddABookWithNonValidISBN

	| cart aCatalog |
	aCatalog := OrderedCollection new.
	aCatalog add: '978-3-9820137-0-2'.
	cart := Cart with: aCatalog.
	
	self  should: [cart add: '978-3-9820137-X-X' amount: 5.] 
		 raise: Error 
		 withMessageText: Cart ISBNDoesntBelongToCatalogErrorDescription.
	! !

!CartTest methodsFor: 'cart-tests' stamp: 'DB 11/18/2020 20:00:52'!
test05CannotAddABookWithNegativeOrZeroAmount

	| aCatalog cart |
	aCatalog := OrderedCollection new.
	aCatalog add: '978-3-9820137-0-2'.
	cart := Cart with: aCatalog.
	
	self  should: [cart add: '978-3-9820137-0-1' amount: -5.] 
		 raise: Error 
		 withMessageText: Cart doesntAllowNegativeOrZeroAmountToBeAddedErrorDescription.! !

!CartTest methodsFor: 'cart-tests' stamp: 'DB 11/18/2020 20:01:45'!
test06ListItemsOfEmptyCartReturnsAnEmptyList

	| cart items |
	cart := Cart new.
	
	items := cart listItems.
	
	self assert: items isEmpty.! !

!CartTest methodsFor: 'cart-tests' stamp: 'DB 11/18/2020 20:02:25'!
test07ListItemsOfACartWithOneItemReturnsAListWithAllBooksAdded

	| cart aCatalog items |
	aCatalog := OrderedCollection new.
	aCatalog add: '978-3-9820137-0-1'.
	cart := Cart with: aCatalog.
	
	cart add: '978-3-9820137-0-1'.
	
	items := cart listItems.
	
	self assert: 1 equals: items size.
	self assert: items includes: '978-3-9820137-0-1'.
	self assert: 1 equals: (items occurrencesOf: '978-3-9820137-0-1').! !

!CartTest methodsFor: 'cart-tests' stamp: 'DB 11/18/2020 20:02:33'!
test08ListItemsOfACartWithMoreThanOneItemReturnsAListWithAllBooksAdded

	| cart aCatalog items |
	aCatalog := OrderedCollection new.
	aCatalog add: '978-3-9820137-0-1'.
	aCatalog add: '978-3-9820137-0-2'.
	aCatalog add: '978-3-9820137-0-3'.
	cart := Cart with: aCatalog.
	cart add: '978-3-9820137-0-1' amount: 2.
	cart add: '978-3-9820137-0-2' amount: 3.
	cart add: '978-3-9820137-0-3' amount: 5.
	
	items := cart listItems.
	
	self assert: 10 equals: items size.
	self assert: items includes: '978-3-9820137-0-1'.
	self assert: 2 equals: (items occurrencesOf: '978-3-9820137-0-1').
	self assert: items includes: '978-3-9820137-0-2' .
	self assert: 3 equals: (items occurrencesOf: '978-3-9820137-0-2').
	self assert: items includes: '978-3-9820137-0-3'.
	self assert: 5 equals: (items occurrencesOf: '978-3-9820137-0-3').
	
	
	
	! !


!classDefinition: #Cart category: 'Tus Libros.com'!
Object subclass: #Cart
	instanceVariableNames: 'items catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus Libros.com'!

!Cart methodsFor: 'testing' stamp: 'DB 11/16/2020 19:11:13'!
amountOfItems
	^items size! !


!Cart methodsFor: 'operations' stamp: 'DB 11/16/2020 19:12:45'!
add: aBook 
	self add: aBook amount: 1
	! !

!Cart methodsFor: 'operations' stamp: 'DB 11/18/2020 19:44:15'!
add: aBook amount: anAmount 

	self assertCanAdd: aBook amount: anAmount.

	items add: aBook withOccurrences: anAmount! !

!Cart methodsFor: 'operations' stamp: 'DB 11/18/2020 19:36:29'!
listItems
	^items copy! !


!Cart methodsFor: 'operations private' stamp: 'DB 11/18/2020 19:43:54'!
assertCanAdd: aBook amount: anAmount

	(anAmount <= 0) ifTrue: [^self class signalDoesntAllowNegativeOrZeroAmountToBeAdded ].
	(catalog includes: aBook) ifFalse: [^self class signalISBNDoesntBelongToCatalog].

! !


!Cart methodsFor: 'initialization' stamp: 'DB 11/17/2020 18:17:04'!
initialize
	catalog := Bag new.
	items := Bag new.! !

!Cart methodsFor: 'initialization' stamp: 'DB 11/18/2020 19:37:36'!
initializeWith: aCatalog
	catalog := aCatalog.
	items := Bag new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'Tus Libros.com'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'DB 11/17/2020 18:17:47'!
ISBNDoesntBelongToCatalogErrorDescription
	^'ISBN doesnt belong to catalog'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'DB 11/17/2020 18:31:31'!
doesntAllowNegativeOrZeroAmountToBeAddedErrorDescription
	^'doesnt allow negative or zero amount to be added'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'DB 11/17/2020 18:32:01'!
signalDoesntAllowNegativeOrZeroAmountToBeAdded
	self error: self doesntAllowNegativeOrZeroAmountToBeAddedErrorDescription ! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'DB 11/17/2020 18:19:27'!
signalISBNDoesntBelongToCatalog
	self error: self ISBNDoesntBelongToCatalogErrorDescription ! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'DB 11/18/2020 19:37:18'!
with: aCatalog
	^self new initializeWith: aCatalog ! !
