!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testingObjectFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'ENC 6/14/2021 19:42:02'!
setUp

	testingObjectFactory := TestObjectFactory new.! !

!CartTest methodsFor: 'tests' stamp: 'ENC 6/14/2021 19:42:11'!
test01NewCartsAreCreatedEmpty

	self assert: testingObjectFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'ENC 6/14/2021 19:44:36'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testingObjectFactory createCart.
	
	self 
		should: [ cart add: testingObjectFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'ENC 6/14/2021 19:42:41'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testingObjectFactory createCartWith: testingObjectFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'ENC 6/14/2021 19:42:50'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testingObjectFactory createCart.
	
	self 
		should: [cart add: 0 of: testingObjectFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'ENC 6/14/2021 19:42:59'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testingObjectFactory createCart.
	
	self 
		should: [cart add: 2 of: testingObjectFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'ENC 6/14/2021 19:43:16'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testingObjectFactory createCartWith: testingObjectFactory itemSellByTheStore.
	self assert: (cart includes: testingObjectFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'ENC 6/14/2021 19:43:22'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testingObjectFactory createCart.
	
	self deny: (cart includes: testingObjectFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'ENC 6/14/2021 19:43:31'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testingObjectFactory createCart.
	
	cart add: 2 of: testingObjectFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testingObjectFactory itemSellByTheStore) = 2! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testingObjectFactory date mpInnerInterfaceSimulatorValidCard mpInnerInterfaceSimulatorFalseCard mpInnerInterfaceSimulatorStolenCard mpInnerInterfaceSimulatorInsufficientAmountCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'testing - private' stamp: 'ENC 6/17/2021 01:04:17'!
shouldRaiseError: anErrorMessage whileTryingToCheckout: aCart for: anInnerInterfaceSimulator with: aCreditCard

	| cashier |
	
	cashier := testingObjectFactory createCashierWith: anInnerInterfaceSimulator.
	
	self 
		should: [ cashier checkout: aCart with: aCreditCard on: date ] 
		raise: Error 
		withMessageText: anErrorMessage.! !


!CashierTest methodsFor: 'testing' stamp: 'ENC 6/14/2021 19:33:56'!
setUp

	testingObjectFactory := TestObjectFactory new.
	date := GregorianMonthOfYear year: 2021 month: June.
	
	mpInnerInterfaceSimulatorValidCard := MPInnerInterfaceSimulatorValidCard new. 
	mpInnerInterfaceSimulatorFalseCard := MPInnerInterfaceSimulatorFalseCard new.
	mpInnerInterfaceSimulatorStolenCard := MPInnerInterfaceSimulatorStolenCard new.
	mpInnerInterfaceSimulatorInsufficientAmountCard := MPInnerInterfaceSimulatorInsufficientAmountCard new.
! !

!CashierTest methodsFor: 'testing' stamp: 'ENC 6/17/2021 01:00:15'!
test01cannotCheckoutAnEmptyCart
	
	self 
		shouldRaiseError: Cashier checkoutEmptyCartError 
		whileTryingToCheckout: testingObjectFactory createCart 
		for: mpInnerInterfaceSimulatorValidCard 
		with: testingObjectFactory validCard.
	! !

!CashierTest methodsFor: 'testing' stamp: 'ENC 6/17/2021 01:04:17'!
test02checkoutACartReturnsTheTotalPrice

	| cashier cart card |
	
	cart := testingObjectFactory createCartWithValidBook.
	cashier := testingObjectFactory createCashierWith: mpInnerInterfaceSimulatorValidCard.
	card := testingObjectFactory validCard.
		
	self assert: testingObjectFactory itemSellByTheStorePrice equals: (cashier checkout: cart with: card on: date).! !

!CashierTest methodsFor: 'testing' stamp: 'ENC 6/17/2021 01:00:55'!
test03cannotCheckoutACartWithExpiredCard

	self 
		shouldRaiseError: Cashier checkoutExpiredCard 
		whileTryingToCheckout: testingObjectFactory createCartWithValidBook
		for: mpInnerInterfaceSimulatorValidCard 
		with: testingObjectFactory expiredCard.! !

!CashierTest methodsFor: 'testing' stamp: 'ENC 6/17/2021 01:01:07'!
test04cannotCheckoutACartWithCardWithInsufficientAmount

	self 
		shouldRaiseError: MPInnerInterfaceSimulator insufficientAmountCardError 
		whileTryingToCheckout: testingObjectFactory createCartWithValidBook
		for: mpInnerInterfaceSimulatorInsufficientAmountCard
		with: testingObjectFactory validCard.
		! !

!CashierTest methodsFor: 'testing' stamp: 'ENC 6/17/2021 01:01:16'!
test05cannotCheckoutACartWithFalseCard

	self 
		shouldRaiseError: MPInnerInterfaceSimulator falseCardError 
		whileTryingToCheckout: testingObjectFactory createCartWithValidBook
		for: mpInnerInterfaceSimulatorFalseCard
		with: testingObjectFactory validCard.! !

!CashierTest methodsFor: 'testing' stamp: 'ENC 6/17/2021 01:01:23'!
test06cannotCheckoutACartWithStolenCard
	
	self 
		shouldRaiseError: MPInnerInterfaceSimulator stolenCardError 
		whileTryingToCheckout: testingObjectFactory createCartWithValidBook
		for: mpInnerInterfaceSimulatorStolenCard
		with: testingObjectFactory validCard.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'ENC 6/12/2021 23:22:37'!
assertIsValidItem: anItem

	catalog at: anItem ifAbsent: [ ^ self error: self invalidItemErrorMessage ]! !

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

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'checkout' stamp: 'ENC 6/10/2021 22:47:56'!
checkout

	^ items inject: 0 into: [ :partialCheckout :item | partialCheckout + catalog at: item ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'merchantProcessorInterface'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'signaling' stamp: 'ENC 6/12/2021 23:49:54'!
signalCheckoutEmptyCartError
	
	self error: self class checkoutEmptyCartError.! !

!Cashier methodsFor: 'signaling' stamp: 'ENC 6/12/2021 23:50:08'!
signalCheckoutExpiredCard
	
	self error: self class checkoutExpiredCard.! !


!Cashier methodsFor: 'processing' stamp: 'ENC 6/14/2021 19:00:05'!
checkout: aCart with: aCreditCard on: aDate

	| totalPrice |

	aCart isEmpty ifTrue: [ self signalCheckoutEmptyCartError ].
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self signalCheckoutExpiredCard ].
		
	totalPrice := aCart checkout.
		
	merchantProcessorInterface creditPaymentWith: aCreditCard of: totalPrice.
		
	^ totalPrice 
	
	

	! !


!Cashier methodsFor: 'initialization' stamp: 'ENC 6/14/2021 19:20:23'!
initializeWith: aMPInnerInterface
	
	merchantProcessorInterface := aMPInnerInterface.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error descriptions' stamp: 'ENC 6/10/2021 20:07:20'!
checkoutEmptyCartError
	
	^ 'No se puede procesar un carrito vacío.'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'ENC 6/12/2021 23:50:36'!
checkoutExpiredCard
	
	^ 'No se puede pagar con una tarjeta vencida.'! !


!Cashier class methodsFor: 'instance creation' stamp: 'ENC 6/14/2021 19:20:46'!
with: aMPInnerInterfaceSimulator

	^ self new initializeWith: aMPInnerInterfaceSimulator.! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'owner number date'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'ENC 6/14/2021 19:45:35'!
initializeDate: anExpirationDate owner: anOwnerName number: aCreditCardNumber
	
	(anOwnerName withBlanksTrimmed isEmpty) ifTrue: [ self signalEmptyOwnerName ].
	((aCreditCardNumber numberOfDigitsInBase: 10) = 16) ifFalse: [ self signalInvalidCreditCardNumber ].

	owner := anOwnerName.
	number := aCreditCardNumber.
	date := anExpirationDate.! !


!CreditCard methodsFor: 'signaling' stamp: 'ENC 6/13/2021 20:33:11'!
signalEmptyOwnerName

	self error: self class emptyOwnerNameError ! !

!CreditCard methodsFor: 'signaling' stamp: 'ENC 6/13/2021 20:34:06'!
signalInvalidCreditCardNumber

	self error: self class invalidCreditCardNumberError ! !


!CreditCard methodsFor: 'validation' stamp: 'ENC 6/14/2021 18:55:59'!
isExpiredOn: actualDate

	^ date < actualDate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'ENC 6/14/2021 19:45:24'!
date: aDate owner: anOwnerName number: aCreditCardNumber

	^ self new initializeDate: aDate owner: anOwnerName number: aCreditCardNumber! !


!CreditCard class methodsFor: 'error description' stamp: 'ENC 6/13/2021 20:33:43'!
emptyOwnerNameError

	^ 'No puede crearse una tarjeta con nombre vacío'! !

!CreditCard class methodsFor: 'error description' stamp: 'ENC 6/13/2021 20:34:25'!
invalidCreditCardNumberError

	^ 'La tarjeta debe tener número de longitud 16'! !


!classDefinition: #MPInnerInterfaceSimulator category: 'TusLibros'!
Object subclass: #MPInnerInterfaceSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MPInnerInterfaceSimulator methodsFor: 'processing' stamp: 'ENC 6/14/2021 19:19:43'!
creditPaymentWith: aCreditCard of: anAmountOfMoney

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MPInnerInterfaceSimulator class' category: 'TusLibros'!
MPInnerInterfaceSimulator class
	instanceVariableNames: ''!

!MPInnerInterfaceSimulator class methodsFor: 'error description' stamp: 'ENC 6/13/2021 20:58:57'!
falseCardError
	
	^ 'La tarjeta provista es falsa'.! !

!MPInnerInterfaceSimulator class methodsFor: 'error description' stamp: 'ENC 6/13/2021 21:08:25'!
insufficientAmountCardError
	
	^ 'La tarjeta provista no tiene monto disponible'.! !

!MPInnerInterfaceSimulator class methodsFor: 'error description' stamp: 'ENC 6/13/2021 21:05:39'!
stolenCardError
	
	^ 'La tarjeta provista es robada'.! !


!classDefinition: #MPInnerInterfaceSimulatorFalseCard category: 'TusLibros'!
MPInnerInterfaceSimulator subclass: #MPInnerInterfaceSimulatorFalseCard
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MPInnerInterfaceSimulatorFalseCard methodsFor: 'processing' stamp: 'ENC 6/14/2021 19:30:42'!
creditPaymentWith: aCreditCard of: anAmountOfMoney

	self error: self class falseCardError! !


!classDefinition: #MPInnerInterfaceSimulatorInsufficientAmountCard category: 'TusLibros'!
MPInnerInterfaceSimulator subclass: #MPInnerInterfaceSimulatorInsufficientAmountCard
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MPInnerInterfaceSimulatorInsufficientAmountCard methodsFor: 'processing' stamp: 'ENC 6/14/2021 19:30:57'!
creditPaymentWith: aCreditCard of: anAmountOfMoney

	self error: self class insufficientAmountCardError! !


!classDefinition: #MPInnerInterfaceSimulatorStolenCard category: 'TusLibros'!
MPInnerInterfaceSimulator subclass: #MPInnerInterfaceSimulatorStolenCard
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MPInnerInterfaceSimulatorStolenCard methodsFor: 'processing' stamp: 'ENC 6/14/2021 19:31:07'!
creditPaymentWith: aCreditCard of: anAmountOfMoney

	self error: self class stolenCardError! !


!classDefinition: #MPInnerInterfaceSimulatorValidCard category: 'TusLibros'!
MPInnerInterfaceSimulator subclass: #MPInnerInterfaceSimulatorValidCard
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MPInnerInterfaceSimulatorValidCard methodsFor: 'processing' stamp: 'ENC 6/14/2021 19:19:29'!
creditPaymentWith: aCreditCard of: anAmountOfMoney! !


!classDefinition: #TestObjectFactory category: 'TusLibros'!
Object subclass: #TestObjectFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestObjectFactory methodsFor: 'cashier' stamp: 'ENC 6/17/2021 01:04:17'!
createCashierWith: aMPInnerInterfaceSimulator

	^ Cashier with: aMPInnerInterfaceSimulator.! !


!TestObjectFactory methodsFor: 'credit cards' stamp: 'ENC 6/17/2021 01:03:03'!
createACardExpiredAt: anExpirationMonthOfYear

	^ CreditCard date: anExpirationMonthOfYear owner: 'an owner' number: 1234567812345678.! !

!TestObjectFactory methodsFor: 'credit cards' stamp: 'ENC 6/17/2021 01:03:25'!
expiredCard

	^ self createACardExpiredAt: (GregorianMonthOfYear year: 2020 month: June)! !

!TestObjectFactory methodsFor: 'credit cards' stamp: 'ENC 6/17/2021 01:03:40'!
validCard

	^ self createACardExpiredAt: (GregorianMonthOfYear year: 2025 month: June)! !


!TestObjectFactory methodsFor: 'cart' stamp: 'ENC 6/14/2021 19:36:20'!
createCart

	^ Cart acceptingItemsOf: (Dictionary newFrom: self defaultCatalog).! !

!TestObjectFactory methodsFor: 'cart' stamp: 'ENC 6/14/2021 19:36:08'!
createCartWith: aBook

	^ self createCart add: aBook.! !

!TestObjectFactory methodsFor: 'cart' stamp: 'ENC 6/14/2021 19:38:17'!
createCartWithValidBook

	^ self createCart add: self itemSellByTheStore.! !

!TestObjectFactory methodsFor: 'cart' stamp: 'ENC 6/14/2021 19:35:19'!
defaultCatalog

	^ { self itemSellByTheStore -> self itemSellByTheStorePrice }.! !

!TestObjectFactory methodsFor: 'cart' stamp: 'ENC 6/14/2021 19:43:50'!
itemNotSellByTheStore
	
	^ 'invalidBook'! !

!TestObjectFactory methodsFor: 'cart' stamp: 'ENC 6/14/2021 19:35:33'!
itemSellByTheStore
	
	^ 'validBook'! !

!TestObjectFactory methodsFor: 'cart' stamp: 'ENC 6/14/2021 19:35:41'!
itemSellByTheStorePrice
	
	^ 10.! !
