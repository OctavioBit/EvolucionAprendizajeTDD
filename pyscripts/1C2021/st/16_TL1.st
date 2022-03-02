!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'private' stamp: 'ja 6/8/2021 17:04:09'!
catalogue

	^ OrderedCollection with: 'aValidItem'.! !


!CartTest methodsFor: 'tests' stamp: 'ja 6/8/2021 17:03:27'!
test01CreateEmptyCart

	| cart |
	
	cart _ Cart with: self catalogue.
	
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'ja 6/8/2021 17:06:44'!
test02ANewItemCanBeAddedToTheCart

	| cart |
	
	cart _ Cart with: self catalogue.
	
	cart add: 'aValidItem' times: 1.
		
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'ja 6/8/2021 17:06:48'!
test03CanNotAddANumberOfItemsLessThanOne

	| cart |
	
	cart _ Cart with: self catalogue.
	
	self 
		should:  [	cart add: 'aValidItem' times: 0.]
		raise: Error
	  	withExceptionDo: [:anError | 
			self assert: anError messageText equals: cart invalidQuantityOfItemsErrorDescription.
			self assert: cart isEmpty. ]
		
! !

!CartTest methodsFor: 'tests' stamp: 'ja 6/8/2021 17:14:35'!
test04AllAddedItemsCanBeListed

	| cart item list |
	
	cart _ Cart with: self catalogue.
	item _ 'aValidItem'.
	cart add: item times: 3.
	list _ cart list.
	
	self deny: cart isEmpty.
	self assert: cart includes: item.
	self assert: item equals: list first.
	self assert: item equals: list second.
	self assert: item equals: list third.! !

!CartTest methodsFor: 'tests' stamp: 'ja 6/8/2021 17:07:24'!
test05CartDoesNotKnowNotAddedItems

	| cart item notAddedItem list |
	
	cart _ Cart with: self catalogue.
	item _ 'aValidItem'.
	notAddedItem _ 'aNotAddedItem'.
	cart add: item times: 1.
	list _ cart list.
	
	self deny: cart isEmpty.
	self assert: item equals: list first.
	self deny: (cart includes: notAddedItem). ! !

!CartTest methodsFor: 'tests' stamp: 'ja 6/8/2021 17:07:27'!
test06CartKnowNumberOfOccurrencesOfAnItem

	| cart item |
	
	cart _ Cart with: self catalogue.
	item _ 'aValidItem'.
	cart add: item times: 3.
	
	self assert: (cart occurrencesOf: item) equals: 3
	! !

!CartTest methodsFor: 'tests' stamp: 'ja 6/8/2021 17:10:00'!
test07CanNotAddAnItemThatDoNotBelongToTheCatalogue

	| cart item |
	
	cart _ Cart with: self catalogue.
	item _ 'anInvalidItem'.
	
	self 
		should:  [	cart add: item times: 1.]
		raise: Error
	  	withExceptionDo: [:anError | 
			self assert: anError messageText equals: cart invalidItemErrorDescription.
			self assert: cart isEmpty. 
			self deny: (cart includes: item)]! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'items catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'ja 6/8/2021 17:05:49'!
initializeWith: aCatalogue
	
	items _ OrderedCollection new.
	catalogue _ aCatalogue ! !


!Cart methodsFor: 'error description' stamp: 'ja 6/8/2021 17:11:14'!
invalidItemErrorDescription

	^'Invalid item.'! !

!Cart methodsFor: 'error description' stamp: 'ja 6/8/2021 16:35:50'!
invalidQuantityOfItemsErrorDescription

 	^'Invalid quantity of items'! !


!Cart methodsFor: 'testing' stamp: 'ja 6/8/2021 16:54:47'!
includes: anItem 
	
	^ items includes: anItem .
	! !

!Cart methodsFor: 'testing' stamp: 'ja 6/8/2021 16:15:52'!
isEmpty
	
	^ items isEmpty ! !

!Cart methodsFor: 'testing' stamp: 'ja 6/8/2021 17:00:19'!
occurrencesOf: anItem 
	
	^ items occurrencesOf: anItem .! !


!Cart methodsFor: 'assertions' stamp: 'ja 6/8/2021 17:11:34'!
assertItem: anItem

	^ (catalogue includes: anItem) ifFalse: [self error: self invalidItemErrorDescription]! !

!Cart methodsFor: 'assertions' stamp: 'ja 6/8/2021 16:37:24'!
assertQuantity: aQuantity

	^ aQuantity < 1 ifTrue: [self error: self invalidQuantityOfItemsErrorDescription]! !


!Cart methodsFor: 'accessing' stamp: 'ja 6/8/2021 17:15:40'!
add: anItem times: aQuantity 

	self assertQuantity: aQuantity.
	self assertItem: anItem.
	
	1 to: aQuantity do: [:aNumber | items add: anItem ].! !

!Cart methodsFor: 'accessing' stamp: 'ja 6/9/2021 19:46:15'!
list
	
	^ items copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'ja 6/8/2021 17:15:50'!
with: aCatalogue 
	
	^ self new initializeWith: aCatalogue ! !
