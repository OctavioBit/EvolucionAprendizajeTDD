!classDefinition: #CartTest category: 'Ejercicio TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio TusLibros'!

!CartTest methodsFor: 'setup' stamp: 'AM 11/19/2020 15:57:31'!
setUp

	catalogue := OrderedCollection with: 0000.! !


!CartTest methodsFor: 'tests' stamp: 'AM 11/19/2020 15:57:18'!
test01cartIsEmptyWhenCreated

	| cart |
	
	cart := Cart forCatalogue: catalogue.
	 
	self assert: (Bag new) equals: cart listCart.! !

!CartTest methodsFor: 'tests' stamp: 'AM 11/19/2020 15:58:11'!
test02canAddBookCorrectly

	| cart ISBN expectedResult |

	ISBN := 0001.
	cart := Cart forCatalogue: catalogue.
	cart addToCart: ISBN quantity: 1.
	
	expectedResult := Bag with: ISBN.
	
	self assert: expectedResult equals: cart listCart.! !

!CartTest methodsFor: 'tests' stamp: 'AM 11/19/2020 15:58:41'!
test03addingBookAlreadyInCartAddsToTotalBookQuantity

	| cart ISBN expectedResult |
	
	ISBN := 0001.

	cart := Cart forCatalogue: catalogue.
	cart addToCart: ISBN quantity: 1.
	cart addToCart: ISBN quantity: 6.
	
	expectedResult := Bag new.
	expectedResult add: ISBN withOccurrences: 7.
	
	self assert: expectedResult equals: cart listCart.! !

!CartTest methodsFor: 'tests' stamp: 'AM 11/19/2020 15:59:06'!
test04bookOrderQuantityMustAtLeastOne

	| cart ISBN |
	
	ISBN := 0001.
	cart := Cart forCatalogue: catalogue.
	
	self 
		should: [cart addToCart: ISBN quantity: -1]
		raise: Error
		withMessageText: Cart invalidQuantityErrorDescription.! !

!CartTest methodsFor: 'tests' stamp: 'AM 11/19/2020 16:04:02'!
test05bookISBNMustBeValid

	| cart ISBN |
	
	ISBN := 0001.
	cart := Cart forCatalogue: catalogue.
	
	self 
		should: [cart addToCart: ISBN quantity: 1]
		raise: Error
		withMessageText: Cart itemNotInCatalogueErrorDescription.
	
	 ! !


!classDefinition: #Cart category: 'Ejercicio TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'items itemCatalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'AM 11/19/2020 15:54:44'!
initializeForCatalogue: aCatalogue  
	
	itemCatalogue := aCatalogue.
	items := Bag new.! !


!Cart methodsFor: 'accessing' stamp: 'AM 11/19/2020 15:54:44'!
listCart
	
	^items copy.! !


!Cart methodsFor: 'error signaling' stamp: 'AM 11/17/2020 16:23:23'!
signalInvalidOrderQuantity

	^self error: self class invalidQuantityErrorDescription.! !

!Cart methodsFor: 'error signaling' stamp: 'AM 11/19/2020 16:03:01'!
signalItemNotInCatalogue

	^self error: self class itemNotInCatalogueErrorDescription.! !


!Cart methodsFor: 'adding' stamp: 'AM 11/19/2020 16:00:16'!
addToCart: anItem quantity: aQuantity 
	
	self assertValidOrderQuantity: aQuantity.
	self assertItemInCatalogue: anItem.
	items add: anItem withOccurrences: aQuantity.	! !


!Cart methodsFor: 'assertions' stamp: 'AM 11/19/2020 16:02:18'!
assertItemInCatalogue: anItem

	(itemCatalogue includes: anItem) ifFalse: [self signalItemNotInCatalogue].! !

!Cart methodsFor: 'assertions' stamp: 'AM 11/17/2020 16:22:29'!
assertValidOrderQuantity: aQuantity

	(aQuantity > 0) ifFalse: [self signalInvalidOrderQuantity].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'Ejercicio TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'AM 11/19/2020 15:55:27'!
forCatalogue: aCatalogue 
	
	^self new initializeForCatalogue: aCatalogue .! !


!Cart class methodsFor: 'error descriptions' stamp: 'AM 11/17/2020 16:19:01'!
invalidQuantityErrorDescription
	
	^'Order quantity must be at least one'! !

!Cart class methodsFor: 'error descriptions' stamp: 'AM 11/19/2020 16:03:16'!
itemNotInCatalogueErrorDescription
	
	^'Only items belonging to catalogue can be added to the cart'! !
