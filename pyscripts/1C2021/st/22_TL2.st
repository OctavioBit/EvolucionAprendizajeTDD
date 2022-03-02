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


!CartTest methodsFor: 'setUp' stamp: 'CD 6/10/2021 21:17:40'!
setUp

	aBook := 'Persuasion'.
	invalidBook := 'Concrete Mathematics'.
	aBook := 'Persuasion'.
	aCatalog := (Dictionary new).
	aCatalog add: aBook -> 10.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'aBook invalidBook aCatalog aValidCreditCard aMerchantProcessor anotherBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'CD 6/10/2021 19:28:15'!
test01CannotCheckoutAnEmptyCart

	| cart |
	cart := Cart initializeWith: aCatalog.
	
	self should: [ Cashier for: cart payingWith: aValidCreditCard withMerchantProcessor: aMerchantProcessor ] raise: Error withMessageText: Cashier invalidCartMessage.
	

	
	

	
! !

!CashierTest methodsFor: 'tests' stamp: 'CD 6/10/2021 20:59:55'!
test02CheckingOutSingleBookGivesBookPriceAsTotal

	| cart cashier |
	cart := Cart initializeWith: aCatalog.
	cart add: 1 copiesOf: aBook.
	cashier := Cashier for: cart payingWith: aValidCreditCard withMerchantProcessor: aMerchantProcessor.
	
	self assert: cashier checkout equals: 10.
	! !

!CashierTest methodsFor: 'tests' stamp: 'CD 6/10/2021 21:05:00'!
test03CheckingOutMultipleBooksGivesSumOfBookPricesAsTotal

	| cart cashier |
	cart := Cart initializeWith: aCatalog.
	cart add: 2 copiesOf: aBook.
	cart add: 1 copiesOf: anotherBook.
	cashier := Cashier for: cart payingWith: aValidCreditCard withMerchantProcessor: aMerchantProcessor.
	
	self assert: cashier checkout equals: 29.5. 
	! !


!CashierTest methodsFor: 'setUp' stamp: 'CD 6/10/2021 21:05:06'!
setUp

	aBook := 'Persuasion'.
	anotherBook := 'Concrete Mathematics'.
	aCatalog := (Dictionary new).
	aCatalog add: aBook -> 10.
	aCatalog add: anotherBook -> 9.5.
	aValidCreditCard := CreditCard withOwner: 'John Gibson' number: '12345678' expirationDate: Date tomorrow. 
! !


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


!Cart methodsFor: 'assertions' stamp: 'CD 6/10/2021 20:46:28'!
assertIsValidBook: aBook

	(catalog includesKey: aBook) ifFalse: [self error: Cart invalidBookMessage].

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


!Cart methodsFor: 'accesors' stamp: 'CD 6/10/2021 20:27:00'!
bookPrice: book

	^ catalog at: book.! !

!Cart methodsFor: 'accesors' stamp: 'CD 6/10/2021 20:27:14'!
items

	^ items.! !


!Cart methodsFor: 'total' stamp: 'CD 6/10/2021 21:12:33'!
total

	^ items sum: [:item | self bookPrice: item].! !

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


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart creditCard merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initializers' stamp: 'CD 6/10/2021 19:31:51'!
for: aCart payingWith: aCreditCard withMerchantProcessor: aMerchantProcessor

	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.! !


!Cashier methodsFor: 'checkout' stamp: 'CD 6/10/2021 21:11:50'!
checkout

	^ cart total. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'initializers' stamp: 'CD 6/10/2021 19:56:38'!
for: cart payingWith: aCreditCard withMerchantProcessor: aMerchantProcessor

	self validateCartIsNotEmpty: cart.
	^ self new for: cart payingWith: aCreditCard withMerchantProcessor: aMerchantProcessor.! !


!Cashier class methodsFor: 'validation-errors' stamp: 'CD 6/10/2021 19:53:40'!
invalidCartMessage

	^ 'Cannot checkout invalid cart'.! !

!Cashier class methodsFor: 'validation-errors' stamp: 'CD 6/10/2021 19:57:45'!
validateCartIsNotEmpty: cart

	^ cart isEmpty ifTrue: [self error: self invalidCartMessage ].! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'owner number expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initializers' stamp: 'CD 6/10/2021 19:19:47'!
withOwner: aPerson number: aNumber expirationDate: aDate

	owner := aPerson.
	number := aNumber.
	expirationDate := aDate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'initializers' stamp: 'CD 6/10/2021 19:18:50'!
withOwner: aPerson number: aNumber expirationDate: aDate

	^ self new withOwner: aPerson number: aNumber expirationDate: aDate.! !
