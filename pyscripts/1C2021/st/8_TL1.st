!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'test' stamp: 'LEC 6/9/2021 17:14:58'!
test01EmptyCart

	| carrito catalogue |
	catalogue := Dictionary new.
	carrito := Cart with:catalogue.
	
	self assert: carrito isEmpty.
	
	! !

!CartTest methodsFor: 'test' stamp: 'LEC 6/9/2021 18:17:55'!
test02CannotAddUncataloguedItem
	| carrito catalogue |
	catalogue := Dictionary new at: 'un libro' put: 15;yourself.
	carrito := Cart with:catalogue.
	
	self 	should: [carrito add: 'otro libro' amount: 15. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: carrito invalidItemErrorDescription.
			self assert: carrito isEmpty ]
	
	
	! !

!CartTest methodsFor: 'test' stamp: 'LEC 6/9/2021 18:19:47'!
test03CartHasTheItemAndItsAmount
	| carrito catalogue |
	catalogue := Dictionary new at: 'un libro' put: 15;yourself.
	carrito := Cart with:catalogue.
	
	carrito add: 'un libro' amount: 15.
	
	self assert: (carrito items size) equals:1.
	self assert: (carrito items includes: 'un libro').
	self assert: (carrito amountOf:'un libro') equals: 15.
		
	
	
	! !

!CartTest methodsFor: 'test' stamp: 'LEC 6/9/2021 18:21:09'!
test04CannotAddAnItemWithNegativeAmount
	| carrito catalogue |
	catalogue := Dictionary new at: 'un libro' put: 15;yourself.
	carrito := Cart with:catalogue.
	carrito add: 'un libro' amount: 2.
	self 	should: [carrito add: 'un libro' amount: -1. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: carrito invalidAmountErrorDescription.
			self assert: (carrito amountOf:'un libro') equals: 2]
	
	
	! !

!CartTest methodsFor: 'test' stamp: 'LEC 6/9/2021 18:21:52'!
test05CartCalculateTotalPriceForAnItem
	| carrito catalogue |
	catalogue := Dictionary new at: 'un libro' put: 15;yourself.
	carrito := Cart with:catalogue.

	carrito add: 'un libro' amount: 15.
	
	
	self assert: carrito totalPrice equals: 15*15.
	
	
	! !

!CartTest methodsFor: 'test' stamp: 'LEC 6/9/2021 18:23:43'!
test06CartCalculateTotalPriceForManyItems
	| carrito catalogue |
	catalogue := Dictionary new at: 'un libro' put: 15; at: 'otro libro' put: 25;yourself.
	carrito := Cart with:catalogue.

	carrito add: 'un libro' amount: 15.
	carrito add: 'otro libro' amount: 25.	
	
	self assert: carrito totalPrice equals: (15*15) + (25*25).
	
	
	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalogue contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'LEC 6/9/2021 17:21:51'!
initializeWith: aCatalogue
	
	catalogue := aCatalogue .
	contents := Dictionary new.! !


!Cart methodsFor: 'testing' stamp: 'LEC 6/9/2021 17:43:55'!
amountOf: anItem
	
	^contents at:anItem.! !

!Cart methodsFor: 'testing' stamp: 'LEC 6/9/2021 17:22:56'!
isEmpty
	
	^contents isEmpty ! !

!Cart methodsFor: 'testing' stamp: 'LEC 6/9/2021 17:40:42'!
items
	^contents keys ! !


!Cart methodsFor: 'total price' stamp: 'LEC 6/9/2021 18:14:17'!
totalPrice
	
	^contents keys sum:[:anItem|(contents at:anItem) * (catalogue at:anItem)] ifEmpty: [0]! !


!Cart methodsFor: 'errors descriptions' stamp: 'LEC 6/9/2021 17:49:00'!
invalidAmountErrorDescription

	^'The amount must be a positive number.'
	
	! !

!Cart methodsFor: 'errors descriptions' stamp: 'LEC 6/9/2021 17:29:00'!
invalidItemErrorDescription
	
	^'This item is not in the catalogue'! !


!Cart methodsFor: 'assertions' stamp: 'LEC 6/9/2021 17:48:16'!
assertAmountValid: anAmount

	^(anAmount isKindOf: SmallInteger) and:[anAmount > 0].! !

!Cart methodsFor: 'assertions' stamp: 'LEC 6/9/2021 17:40:05'!
assertItemValid: anItem

	^catalogue includesKey: anItem ! !

!Cart methodsFor: 'assertions' stamp: 'LEC 6/9/2021 17:51:36'!
assertValidItem: anItem withAmount: anAmount

	(self assertItemValid: anItem) ifFalse:[self error: self invalidItemErrorDescription ].
	(self assertAmountValid: anAmount) ifFalse:[self error: self invalidAmountErrorDescription ]! !


!Cart methodsFor: 'add' stamp: 'LEC 6/9/2021 17:51:36'!
add: anItem amount: anAmount

	self assertValidItem: anItem withAmount: anAmount.
	
	contents at: anItem put:anAmount! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'LEC 6/9/2021 17:12:59'!
with: aDictionary 
	
	^self new initializeWith: aDictionary ! !
