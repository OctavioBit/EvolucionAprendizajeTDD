!classDefinition: #CartTest category: 'Ejercicio TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'priceCatalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio TusLibros'!

!CartTest methodsFor: 'setup' stamp: 'AM 11/24/2020 15:27:02'!
setUp
	
	priceCatalogue := Dictionary new.
	priceCatalogue add: 0001->500; add: 0002->1000.! !


!CartTest methodsFor: 'tests' stamp: 'AM 11/24/2020 15:27:32'!
test01cartIsEmptyWhenCreated

	| cart |
	
	cart := Cart forCatalogue: priceCatalogue .
	 
	self assert: (Bag new) equals: cart listCart.! !

!CartTest methodsFor: 'tests' stamp: 'AM 11/24/2020 15:27:40'!
test02canAddBookCorrectly

	| cart ISBN expectedResult |

	ISBN := 0001.
	cart := Cart forCatalogue: priceCatalogue.
	cart addToCart: ISBN quantity: 1.
	
	expectedResult := Bag with: ISBN.
	
	self assert: expectedResult equals: cart listCart.! !

!CartTest methodsFor: 'tests' stamp: 'AM 11/24/2020 15:27:48'!
test03addingBookAlreadyInCartAddsToTotalBookQuantity

	| cart ISBN expectedResult |
	
	ISBN := 0001.

	cart := Cart forCatalogue: priceCatalogue.
	cart addToCart: ISBN quantity: 1.
	cart addToCart: ISBN quantity: 6.
	
	expectedResult := Bag new.
	expectedResult add: ISBN withOccurrences: 7.
	
	self assert: expectedResult equals: cart listCart.! !

!CartTest methodsFor: 'tests' stamp: 'AM 11/24/2020 15:27:54'!
test04bookOrderQuantityMustAtLeastOne

	| cart ISBN |
	
	ISBN := 0001.
	cart := Cart forCatalogue: priceCatalogue.
	
	self 
		should: [cart addToCart: ISBN quantity: 0]
		raise: Error
		withMessageText: Cart invalidQuantityErrorDescription.! !

!CartTest methodsFor: 'tests' stamp: 'AM 11/24/2020 15:27:59'!
test05bookISBNMustBeValid

	| cart ISBN |
	
	ISBN := 0000.
	cart := Cart forCatalogue: priceCatalogue.
	
	self 
		should: [cart addToCart: ISBN quantity: 1]
		raise: Error
		withMessageText: Cart itemNotInCatalogueErrorDescription.
	
	 ! !


!classDefinition: #CashierTest category: 'Ejercicio TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'priceCatalogue nonExpiredCreditCard succesfulTransactionApiSim expiredCreditCard unsuccessfulTransactionApiSim'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'AM 11/25/2020 20:32:42'!
test01cantCheckOutEmptyCart
	
	| cart cashier|
	cart := Cart forCatalogue: priceCatalogue.
	cashier := Cashier new.
	
	self
		should:[cashier checkOut: cart with: nonExpiredCreditCard through: succesfulTransactionApiSim]
		raise: Error
		withMessageText: Cashier checkOutEmptyCartErrorDescription.
	
! !

!CashierTest methodsFor: 'tests' stamp: 'AM 11/25/2020 20:33:55'!
test02cantCheckOutWithExpiredCreditCard
	
	| cart cashier |
	cart := Cart forCatalogue: priceCatalogue.
	cart addToCart: 1111111111111 quantity: 1.
	cashier := Cashier new.

	self
		should:[cashier checkOut: cart with: expiredCreditCard through: succesfulTransactionApiSim]
		raise: Error
		withMessageText: Cashier expiredCreditCardErrorDescription.
	
! !

!CashierTest methodsFor: 'tests' stamp: 'AM 11/25/2020 21:25:54'!
test03successfulCheckOutForOneItemReturnsCorrectAmount
	
	| cart cashier |
	
	cart := Cart forCatalogue: priceCatalogue.
	cart addToCart: 1111111111111 quantity: 3.
	cashier := Cashier forPriceCatalogue: priceCatalogue.
	
	self assert: 1500 equals: (cashier checkOut: cart with: nonExpiredCreditCard through: succesfulTransactionApiSim).
! !

!CashierTest methodsFor: 'tests' stamp: 'AM 11/25/2020 21:26:09'!
test04successfulCheckOutForMultipleItemsReturnsCorrectAmount
	
	| cart cashier |
	
	cart := Cart forCatalogue: priceCatalogue.
	cart addToCart: 1111111111111 quantity: 3.
	cart addToCart: 9999999999999 quantity: 2.
	cashier := Cashier forPriceCatalogue: priceCatalogue.
	
	self assert: 3500 equals: (cashier checkOut: cart with: nonExpiredCreditCard through: succesfulTransactionApiSim).
! !

!CashierTest methodsFor: 'tests' stamp: 'AM 11/25/2020 21:21:18'!
test05checkOutAfterUnsuccesfulTransactionShouldReturnCorrectAmount
	
	| cart cashier |
	
	cart := Cart forCatalogue: priceCatalogue.
	cart addToCart: 1111111111111 quantity: 1.
	cashier := Cashier forPriceCatalogue: priceCatalogue.
	
	self 
		should:[cashier checkOut: cart with: nonExpiredCreditCard through: unsuccessfulTransactionApiSim ]
		raise: Error
		withMessageText: ApiRestSimulator unsuccessfulTransactionErrorDescription.
		
	self assert: 500 equals: (cashier checkOut: cart with: nonExpiredCreditCard through: succesfulTransactionApiSim).
! !


!CashierTest methodsFor: 'setup' stamp: 'AM 11/25/2020 21:15:16'!
setUp
	
	priceCatalogue := Dictionary new.
	priceCatalogue add: 1111111111111->500; add: 9999999999999->1000.
	succesfulTransactionApiSim := ApiRestSimulator simSuccessfulTransaction.
	unsuccessfulTransactionApiSim := ApiRestSimulator simUnsuccessfulTransaction.
	expiredCreditCard := CreditCard withNumber: 1234678910111213 expirationOn: November,1998 Owner: 'Perez Juan'.  
	nonExpiredCreditCard := CreditCard withNumber: 1234123412341234 expirationOn: (GregorianMonthOfYear current next) Owner: 'Juan Perez'! !


!classDefinition: #CreditCard category: 'Ejercicio TusLibros'!
TestCase subclass: #CreditCard
	instanceVariableNames: 'number expirationDate owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'AM 11/25/2020 19:27:43'!
initializeForNumber: aCreditCardNumber expirationOn: anExpirationDate Owner: anOwnerNameString
	
	number := aCreditCardNumber.
	expirationDate := anExpirationDate.
	owner := anOwnerNameString.! !


!CreditCard methodsFor: 'accessing' stamp: 'AM 11/25/2020 20:00:59'!
expirationDate

	^expirationDate copy.! !

!CreditCard methodsFor: 'accessing' stamp: 'AM 11/25/2020 20:01:30'!
number

	^number.! !

!CreditCard methodsFor: 'accessing' stamp: 'AM 11/25/2020 20:01:42'!
owner

	^owner copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'Ejercicio TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'error descriptions' stamp: 'AM 11/25/2020 19:58:01'!
InvalidCreditCardNumberErrorDescription
	
	^'Credit card number must be a 16 digit number'! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'AM 11/25/2020 20:00:10'!
InvalidExpirationDateErrorDescription

	^'Expiration date must be a month of year'! !


!CreditCard class methodsFor: 'error signals' stamp: 'AM 11/25/2020 19:57:19'!
signalInvalidCreditCardNumber 
	
	self error: self InvalidCreditCardNumberErrorDescription.! !

!CreditCard class methodsFor: 'error signals' stamp: 'AM 11/25/2020 19:58:50'!
signalInvalidExpirationDate
	
	self error: self InvalidExpirationDateErrorDescription.! !


!CreditCard class methodsFor: 'instance creation' stamp: 'AM 11/25/2020 19:56:36'!
withNumber: aCreditCardNumber expirationOn: anExpirationDate Owner: anOwnerNameString

	(aCreditCardNumber decimalDigitLength = 16) ifFalse: [self signalInvalidCreditCardNumber].
	(anExpirationDate isKindOf: GregorianMonthOfYear) ifFalse: [self signalInvalidExpirationDate].
	^self new initializeForNumber: aCreditCardNumber expirationOn: anExpirationDate Owner: anOwnerNameString.
	! !


!classDefinition: #ApiRestSimulator category: 'Ejercicio TusLibros'!
Object subclass: #ApiRestSimulator
	instanceVariableNames: 'messageToSend'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio TusLibros'!

!ApiRestSimulator methodsFor: 'initialization' stamp: 'AM 11/25/2020 20:36:45'!
initializeSuccessfulTransaction
	
	messageToSend := #successfulTransactionFor:! !

!ApiRestSimulator methodsFor: 'initialization' stamp: 'AM 11/25/2020 21:23:07'!
initializeUnsuccessfulTransaction
	
	messageToSend := #signalUnsuccessfulTransactionFor:.! !


!ApiRestSimulator methodsFor: 'debit simulation' stamp: 'AM 11/25/2020 20:20:44'!
debit: value from: aCreditCard

	^self perform: messageToSend with: value.! !

!ApiRestSimulator methodsFor: 'debit simulation' stamp: 'AM 11/25/2020 20:22:40'!
successfulTransactionFor: aValue.
	
	^aValue.! !


!ApiRestSimulator methodsFor: 'error signals' stamp: 'AM 11/25/2020 21:22:17'!
signalUnsuccessfulTransactionFor: aValue

	self error: self class unsuccessfulTransactionErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ApiRestSimulator class' category: 'Ejercicio TusLibros'!
ApiRestSimulator class
	instanceVariableNames: ''!

!ApiRestSimulator class methodsFor: 'instance creation' stamp: 'AM 11/25/2020 21:15:56'!
simSuccessfulTransaction
	
	^self new initializeSuccessfulTransaction.! !

!ApiRestSimulator class methodsFor: 'instance creation' stamp: 'AM 11/25/2020 21:15:52'!
simUnsuccessfulTransaction

	^self new initializeUnsuccessfulTransaction.! !


!ApiRestSimulator class methodsFor: 'error descriptions' stamp: 'AM 11/25/2020 21:18:42'!
unsuccessfulTransactionErrorDescription
	
	^'Transaction with merchant processor was unsuccessful'! !


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


!Cart methodsFor: 'assertions' stamp: 'AM 11/24/2020 15:26:19'!
assertItemInCatalogue: anItem

	(itemCatalogue includesKey: anItem) ifFalse: [self signalItemNotInCatalogue].! !

!Cart methodsFor: 'assertions' stamp: 'AM 11/25/2020 19:14:41'!
assertValidOrderQuantity: aQuantity

	((aQuantity isKindOf: Integer) and: (aQuantity > 0)) ifFalse: [self signalInvalidOrderQuantity].! !


!Cart methodsFor: 'cashier - private' stamp: 'AM 11/25/2020 21:30:32'!
valueFor: aCashier

	^items sum: [:item | aCashier valueForItem: item].! !


!Cart methodsFor: 'testing' stamp: 'AM 11/19/2020 19:28:41'!
isEmpty
	
	^items isEmpty.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'Ejercicio TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'AM 11/19/2020 15:55:27'!
forCatalogue: aCatalogue 
	
	^self new initializeForCatalogue: aCatalogue .! !


!Cart class methodsFor: 'error descriptions' stamp: 'AM 11/25/2020 19:15:40'!
invalidQuantityErrorDescription
	
	^'Order quantity must be at least one and discrete'! !

!Cart class methodsFor: 'error descriptions' stamp: 'AM 11/19/2020 16:03:16'!
itemNotInCatalogueErrorDescription
	
	^'Only items belonging to catalogue can be added to the cart'! !


!classDefinition: #Cashier category: 'Ejercicio TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'priceCatalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio TusLibros'!

!Cashier methodsFor: 'error signaling' stamp: 'AM 11/19/2020 18:56:35'!
signalCheckOutEmptyCart
	
	^self error: self class checkOutEmptyCartErrorDescription.! !

!Cashier methodsFor: 'error signaling' stamp: 'AM 11/19/2020 19:25:02'!
signalExpiredCreditCard
	
	^self error: self class expiredCreditCardErrorDescription.! !


!Cashier methodsFor: 'initialization' stamp: 'AM 11/25/2020 20:18:25'!
initializeForPriceCatalogue: aPriceCatalogue

	priceCatalogue := aPriceCatalogue.
! !


!Cashier methodsFor: 'value' stamp: 'AM 11/25/2020 21:28:56'!
valueForCart: anItemCart
	
	^anItemCart valueFor: self.
	
	
	! !

!Cashier methodsFor: 'value' stamp: 'AM 11/25/2020 21:28:27'!
valueForItem: anItem
	
	^priceCatalogue at: anItem.
	
	
	! !


!Cashier methodsFor: 'check out' stamp: 'AM 11/25/2020 21:28:39'!
checkOut: anItemCart with: aCreditCard through: anApi
	
	| value |
	
	self assertCartHasItems: anItemCart.
	self assertNotExpired: aCreditCard.
	value := self valueForCart: anItemCart.
	
	^anApi debit: value from: aCreditCard.
! !


!Cashier methodsFor: 'assertions' stamp: 'AM 11/25/2020 20:08:05'!
assertCartHasItems: anItemCart

	(anItemCart isEmpty) ifTrue: [self signalCheckOutEmptyCart].! !

!Cashier methodsFor: 'assertions' stamp: 'AM 11/25/2020 20:08:38'!
assertNotExpired: aCreditCard
	
	(GregorianMonthOfYear current < aCreditCard expirationDate) ifFalse: [self signalExpiredCreditCard].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'Ejercicio TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error descriptions' stamp: 'AM 11/19/2020 18:54:38'!
checkOutEmptyCartErrorDescription
	
	^'Cant check out empty cart'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'AM 11/19/2020 19:22:38'!
expiredCreditCardErrorDescription
	
	^'Credit card is expired'! !


!Cashier class methodsFor: 'instance creation' stamp: 'AM 11/19/2020 19:56:36'!
forPriceCatalogue: aPriceCatalogue

	^self new initializeForPriceCatalogue: aPriceCatalogue.! !
