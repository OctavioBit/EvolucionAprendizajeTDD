!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'book1 book2 catalogue cart priceList cashier merchantProcessorSimulator validCreditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'MP interaction' stamp: 'as 11/22/2020 13:26:58'!
test13CheckoutWithValidPaymentReturns0
	
	cart add: book1.
	
	MerchantProcessorSimulator compile: '
		processPaymentFor: aCreditCard 
		withAmount: anAmount
		^''0|OK'''.
	 
	self assert: (cashier checkout: cart with: validCreditCard with: merchantProcessorSimulator ) equals: '0|OK'.

! !

!CashierTest methodsFor: 'MP interaction' stamp: 'as 11/22/2020 13:26:58'!
test14CheckoutWithMerchantProcessorErrorReturns1

	cart add: book1.

	MerchantProcessorSimulator compile: '
		processPaymentFor: aCreditCard 
		withAmount: anAmount
		^ Error signal: ''Stolen credit card!!'''.
	 
	self assert: (cashier checkout: cart with: validCreditCard with: merchantProcessorSimulator ) equals: '1|Stolen credit card!!'.

! !


!CashierTest methodsFor: 'credit card validation' stamp: 'as 11/22/2020 13:44:38'!
test05ExpiredCreditCardThrowsException
	
	| expiredCreditCard |
	
	cart add: book1.
	
	expiredCreditCard := CreditCard newOwnedBy: 'rodri' withNumber: '0000000000000000' expiringOn: 10 andYear: 2020.

	self 
		checkoutWith: expiredCreditCard 
		shouldThrow: cashier class expiredCreditCardErrorMessage
		withCashier: cashier.


! !

!CashierTest methodsFor: 'credit card validation' stamp: 'as 11/22/2020 13:44:15'!
test06EmptyCreditCardOwnerThrowsException
	
	| emptyOwnerCreditCard |
	
	cart add: book1.
	
	emptyOwnerCreditCard := CreditCard newOwnedBy: '' withNumber: '0000000000000000' expiringOn: 10 andYear: 2022.
			
	self 
		checkoutWith: emptyOwnerCreditCard 
		shouldThrow: cashier class invalidCreditCardOwnerErrorMessage 
		withCashier: cashier.


! !

!CashierTest methodsFor: 'credit card validation' stamp: 'as 11/22/2020 13:44:53'!
test07CreditCardOwnerLongerThan30CharactersThrowsException
	
	| invalidOwnerCreditCard |
	
	cart add: book1.
	
	invalidOwnerCreditCard := CreditCard newOwnedBy: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa' withNumber: '0000000000000000' expiringOn: 10 andYear: 2022.
	
	self 
		checkoutWith: invalidOwnerCreditCard 
		shouldThrow: cashier class invalidCreditCardOwnerErrorMessage 
		withCashier: cashier.
	

! !

!CashierTest methodsFor: 'credit card validation' stamp: 'as 11/22/2020 13:45:01'!
test08CreditCardNumberWithNotOnlyDigitsThrowsException
	
	| invalidNumberCreditCard |
	
	cart add: book1.
	
	invalidNumberCreditCard := CreditCard newOwnedBy: 'rodri' withNumber: '000000000000000a' expiringOn: 10 andYear: 2022.
	
	self 
		checkoutWith: invalidNumberCreditCard 
		shouldThrow: cashier class invalidCreditCardNumberErrorMessage 
		withCashier: cashier.
	


! !

!CashierTest methodsFor: 'credit card validation' stamp: 'as 11/22/2020 13:42:31'!
test09CreditCardNumberSizeSmallerThan16ThrowsException
	
	| invalidNumberCreditCard |
	
	cart add: book1.
	
	invalidNumberCreditCard := CreditCard newOwnedBy: 'rodri' withNumber: '000000000000000' expiringOn: 10 andYear: 2022.
	
	self 
		checkoutWith: invalidNumberCreditCard 
		shouldThrow: cashier class invalidCreditCardNumberErrorMessage 
		withCashier: cashier.
	

! !

!CashierTest methodsFor: 'credit card validation' stamp: 'as 11/22/2020 13:45:09'!
test10CreditCardNumberSizeBiggerThan16ThrowsException
	
	| invalidNumberCreditCard |
	
	cart add: book1.
	
	invalidNumberCreditCard := CreditCard newOwnedBy: 'rodri' withNumber: '00000000000000000' expiringOn: 10 andYear: 2022.
	
	self 
		checkoutWith: invalidNumberCreditCard 
		shouldThrow: cashier class invalidCreditCardNumberErrorMessage 
		withCashier: cashier.
	

! !


!CashierTest methodsFor: 'cart validation' stamp: 'as 11/22/2020 13:26:58'!
test01CannotCheckoutEmptyCart
	
	self 
		should: [cashier checkout: cart with: validCreditCard with: merchantProcessorSimulator ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = cashier class emptyCartErrorMessage.]


! !


!CashierTest methodsFor: 'setUp' stamp: 'as 11/22/2020 13:26:58'!
setUp
	
	book1 := 'validBook'.
	book2 := 'validBook2'.
	catalogue := Array with: book1 with: book2.
	
	cart := Cart acceptingItemsOf: catalogue.
	
	priceList := Dictionary new.			
	priceList add: book1 -> 100.
	cashier := Cashier newWith: priceList.	
	
	merchantProcessorSimulator := MerchantProcessorSimulator new.
	
	validCreditCard := CreditCard newOwnedBy: 'rodri' withNumber: '0000000000000000' expiringOn: 12 andYear: 2022.
	
	! !


!CashierTest methodsFor: 'cost calculation' stamp: 'as 11/22/2020 13:26:52'!
test02CashierCalculatesCostOfCartWithOneProduct
	
	cart add: book1.
	
	self assert: (cashier calculateCostFor: cart) equals: 100.
	! !

!CashierTest methodsFor: 'cost calculation' stamp: 'as 11/22/2020 13:26:52'!
test03CashierCalculatesCostOfCartWithTwoIdenticalProducts
	
	cart add: 2 of: book1.
	
	self assert: (cashier calculateCostFor: cart) equals: 200.
	! !

!CashierTest methodsFor: 'cost calculation' stamp: 'as 11/22/2020 13:26:48'!
test04CashierCalculatesCostOfCartWithTwoDifferentProducts
	
	| cashier2 |
	cart add: book1.
	cart add: book2.	
	
	priceList add: book2 -> 50.
	cashier2 := Cashier newWith: priceList.	
	
	self assert: (cashier2 calculateCostFor: cart) equals: 150.
	! !

!CashierTest methodsFor: 'cost calculation' stamp: 'as 11/22/2020 13:42:42'!
test11PaymentAmountWholeNumberPartExceedingLimitThrowsException
	
	| cashier2  |
	
	cart add: book1.
	
	priceList add: book1 -> 9999999999999999.
	cashier2 := Cashier newWith: priceList.	
	
	
	self 
		checkoutWith: validCreditCard 
		shouldThrow: cashier2 class invalidPaymentAmountErrorMessage
		withCashier: cashier2.
	

! !

!CashierTest methodsFor: 'cost calculation' stamp: 'as 11/22/2020 13:43:23'!
test12CartItemPresentInCatalogueButNotInPriceListThrowsException
	
	| emptyPriceList cashier2|
	
	cart add: book1.
	
	emptyPriceList := Dictionary new.
	cashier2 := Cashier newWith: emptyPriceList.	
	
	self 
		checkoutWith: validCreditCard 
		shouldThrow: cashier2 class notPricedItemErrorMessage
		withCashier: cashier2.
	
! !


!CashierTest methodsFor: 'exception assertion' stamp: 'as 11/22/2020 13:41:40'!
checkoutWith: aCreditCard shouldThrow: anErrorMessage withCashier: aCashier
	self 
		should: [aCashier checkout: cart with: aCreditCard with: merchantProcessorSimulator ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError receiver = aCashier.	 "nos aseguramos que el cashier es el que tira la excepcion y no el simulador"
			self assert: anError messageText = anErrorMessage.]! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'as 11/22/2020 11:52:42'!
items
	^items.! !


!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'as 11/19/2020 21:12:48'!
isEmpty
	^items isEmpty! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'as 11/16/2020 19:22:00'!
invalidBookErrorMessage
	^'Invalid book!!'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'as 11/19/2020 16:18:04'!
newWith: aCatalogue
	^self new initializeWith: aCatalogue.! !


!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'priceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'validations' stamp: 'as 11/22/2020 12:37:46'!
maximumExceededFor: aPaymentCost
	^aPaymentCost > 999999999999999.! !

!Cashier methodsFor: 'validations' stamp: 'as 11/22/2020 12:29:11'!
validateCart: aCart
	aCart isEmpty ifTrue: [^Error signal: self class emptyCartErrorMessage.].! !

!Cashier methodsFor: 'validations' stamp: 'as 11/22/2020 12:26:54'!
validateCreditCard: aCreditCard

	aCreditCard hasExpired ifTrue: [ ^Error signal: self class expiredCreditCardErrorMessage.].
	
	aCreditCard invalidOwner ifTrue: [^Error signal: self class invalidCreditCardOwnerErrorMessage.].
	
	aCreditCard invalidNumber ifTrue: [^Error signal: self class invalidCreditCardNumberErrorMessage.].! !

!Cashier methodsFor: 'validations' stamp: 'as 11/22/2020 12:38:13'!
validatePaymentCost: aPaymentCost
	(self maximumExceededFor: aPaymentCost) ifTrue: [^Error signal: self class invalidPaymentAmountErrorMessage.].! !


!Cashier methodsFor: 'check out' stamp: 'as 11/22/2020 11:56:28'!
calculateCostFor: aCart
	
	^ aCart items sum: [:item | priceList at: item ifAbsent: [^Error signal: self class notPricedItemErrorMessage ]].! !

!Cashier methodsFor: 'check out' stamp: 'as 11/22/2020 12:32:03'!
checkout: aCart with: aCreditCard with: aMerchantProcessorSimulator
	
	| paymentCost |
	
	self validateCart: aCart.
	
	self validateCreditCard: aCreditCard.
	
	paymentCost := self calculateCostFor: aCart.
	
	self validatePaymentCost: paymentCost.
		
	[^aMerchantProcessorSimulator processPaymentFor: aCreditCard withAmount: paymentCost] 
		on: Error
		do: [:anError | ^self merchantProcessorErrorMessageFor: anError].

	
	
	
	! !

!Cashier methodsFor: 'check out' stamp: 'as 11/22/2020 12:31:48'!
merchantProcessorErrorMessageFor: anError
	^1 asString, '|', anError messageText.! !


!Cashier methodsFor: 'initialization' stamp: 'as 11/19/2020 19:20:57'!
initializeWith: aPriceList
	priceList := aPriceList.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'as 11/19/2020 19:07:22'!
emptyCartErrorMessage
	^'The cart is empty!!'
! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'as 11/19/2020 19:51:52'!
expiredCreditCardErrorMessage
	^'The card is expired!!'
! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'as 11/22/2020 11:10:24'!
invalidCreditCardNumberErrorMessage
	^'The credit card numbers is invalid!!'
! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'as 11/22/2020 11:02:34'!
invalidCreditCardOwnerErrorMessage
	^'The credit card owner is invalid!!'
! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'as 11/22/2020 11:34:29'!
invalidPaymentAmountErrorMessage
	^'The payment amount is invalid!!'
! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'as 11/19/2020 19:21:21'!
newWith: aPriceList
	^self new initializeWith: aPriceList.! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'as 11/22/2020 11:48:19'!
notPricedItemErrorMessage
	^'The item is not present in the price list!!'
! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationMonth expirationYear owner number'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'as 11/19/2020 21:43:37'!
hasExpired
	^(Date today yearNumber > expirationYear) or: [Date today yearNumber = expirationYear and: [Date today monthIndex > expirationMonth ]]! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'as 11/19/2020 21:49:07'!
initializeOwnedBy: anOwner withNumber: aNumber expiringOn: aMonth andYear: aYear
	owner := anOwner.
	number := aNumber.
	expirationMonth := aMonth.
	expirationYear := aYear.! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'as 11/22/2020 11:22:18'!
invalidNumber
	number size ~= 16 ifTrue: [^true].
	number do: [:digit | (digit asciiValue between: 48 and: 57) ifFalse: [^true]].
	^false.
	! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'as 11/22/2020 11:08:03'!
invalidOwner
	^owner isEmpty or: [owner size > 30].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'as 11/19/2020 21:50:07'!
newOwnedBy: anOwner withNumber: aNumber expiringOn: aMonth andYear: aYear
	^self new initializeOwnedBy: anOwner withNumber: aNumber expiringOn: aMonth andYear: aYear. ! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'payment processing' stamp: 'as 11/22/2020 13:45:52'!
processPaymentFor: aCreditCard 
		withAmount: anAmount
		^ Error signal: 'Stolen credit card!!'! !
