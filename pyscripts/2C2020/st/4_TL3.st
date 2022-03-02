!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #RESTInterfaceTest category: 'TusLibros'!
TestCase subclass: #RESTInterfaceTest
	instanceVariableNames: 'testObjectsFactory clock interface debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RESTInterfaceTest methodsFor: 'tests' stamp: 'GR 11/30/2020 20:40:18'!
test01CreateCartWithValidUsernameAndPasswordReturnsCartID

	self assert: '1' equals: (interface createCartWithUser: 'Crocken321' andPassword: 'lacontraseniamasseguradetodas').! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'GR 11/30/2020 20:40:18'!
test02CanNotCreateCartWithInvalidUsername

	self
		should: [ interface createCartWithUser: 'CheckPoint' andPassword: 'elMatiPiola321' ]
		raise: Error - MessageNotUnderstood 
		withMessageText: RESTInterface invalidUserError! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'GR 11/30/2020 20:40:18'!
test03CanNotCreateCartWithValidUsernameButInvalidPassword

	self
		should: [ interface createCartWithUser: 'Crocken321' andPassword: 'elMatiPiola321' ]
		raise: Error - MessageNotUnderstood 
		withMessageText: RESTInterface invalidUserError! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'GR 11/30/2020 20:40:18'!
test04CreateMoreThanOneCartWithValidUsernameAndPasswordReturnsCartIDForEach

	self assert: '1' equals: (interface createCartWithUser: 'Crocken321' andPassword: 'lacontraseniamasseguradetodas').
	self assert: '2' equals: (interface createCartWithUser: 'ortoPilot' andPassword: 'ilovemusic').! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'GR 11/30/2020 20:40:18'!
test05CartIsCreatedAndSaved

	interface createCartWithUser: 'Crocken321' andPassword: 'lacontraseniamasseguradetodas'.
	
	self assert: (interface isDefinedTheID: '1').! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'GR 12/1/2020 17:26:14'!
test06CanNotAddProductsToInvalidCart

	interface createCartWithUser: 'Crocken321' andPassword: 'lacontraseniamasseguradetodas'.
	
	self
		should: [ interface addToCart: '4' theProduct: testObjectsFactory itemSellByTheStore withAmount: 10. ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: RESTInterface invalidCartError. 
	
	! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'GR 12/2/2020 15:39:34'!
test07CanListAnEmptyCart

	interface createCartWithUser: 'Crocken321' andPassword: 'lacontraseniamasseguradetodas'.
	
	self assert: Bag new equals: (interface listCart: '1')
	
	! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'GR 12/2/2020 15:40:08'!
test08CanListCartWithValidID

	interface createCartWithUser: 'Crocken321' andPassword: 'lacontraseniamasseguradetodas'.
	
	interface addToCart: '1' theProduct: testObjectsFactory itemSellByTheStore withAmount: 10.
	
	self assert: testObjectsFactory bagWithElements equals: (interface listCart: '1')
	
	! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'GR 12/1/2020 17:25:42'!
test09CanNotListCartWithInvalidID

	interface createCartWithUser: 'Crocken321' andPassword: 'lacontraseniamasseguradetodas'.
	
	interface addToCart: '1' theProduct: testObjectsFactory itemSellByTheStore withAmount: 10.
	
	self
		should: [ interface listCart: '4' ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: RESTInterface invalidCartError.! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'GR 12/1/2020 17:25:33'!
test10CanAddProductsToCartWithCartID

	interface createCartWithUser: 'Crocken321' andPassword: 'lacontraseniamasseguradetodas'.
	
	interface addToCart: '1' theProduct: testObjectsFactory itemSellByTheStore withAmount: 10.
	
	self deny: (interface listCart: '1') isEmpty.! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'GR 11/30/2020 21:18:20'!
test11CanNotCheckoutCartWithInvalidID

	interface createCartWithUser: 'Crocken321' andPassword: 'lacontraseniamasseguradetodas'.
	
	interface addToCart: '1' theProduct: testObjectsFactory itemSellByTheStore withAmount: 10.
	
	self
		should: [ interface checkout: '4' withCCN: '4865642166849654' withCCED: (Month month: 8 year: 2021) withCCO: 'Matias Morales' ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: RESTInterface invalidCartError.! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'GR 11/30/2020 20:40:18'!
test12CanNotAddToCartIf30MinutesPassedSinceLastOperation

	interface createCartWithUser: 'Crocken321' andPassword: 'lacontraseniamasseguradetodas'.
	
	self thirtyMinutesTimeWarp.
	
	self 
		should: [ interface addToCart: '1' theProduct: testObjectsFactory itemSellByTheStore withAmount: 10. ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: RESTInterface cartTimeExceededErrorDescription = anError messageText.
			self deny: (interface isDefinedTheID: '1') ]
	
	
	! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'GR 11/30/2020 21:19:49'!
test13CanNotListCartIf30MinutesPassedSinceLastOperation

	| cartID |
	
	cartID := interface createCartWithUser: 'Crocken321' andPassword: 'lacontraseniamasseguradetodas'.
	
	self thirtyMinutesTimeWarp.
	
	self 
		should: [ interface listCart: cartID ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: RESTInterface cartTimeExceededErrorDescription = anError messageText.
			self deny: (interface isDefinedTheID: cartID) ]
	
	
	! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'GR 11/30/2020 21:21:36'!
test14CanNotCheckoutIf30MinutesPassedSinceLastOperation

	| cartID |
	
	cartID := interface createCartWithUser: 'Crocken321' andPassword: 'lacontraseniamasseguradetodas'.
	
	self thirtyMinutesTimeWarp.
	
	self 
		should: [ interface checkout: cartID withCCN: '4865642166849654' withCCED: (Month month: 8 year: 2021) withCCO: 'Matias Morales' ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: RESTInterface cartTimeExceededErrorDescription = anError messageText.
			self deny: (interface isDefinedTheID: cartID) ]
	
	
	! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'GR 12/1/2020 16:07:02'!
test15CheckoutACartReturnsSaleID

	interface createCartWithUser: 'Crocken321' andPassword: 'lacontraseniamasseguradetodas'.
	
	interface addToCart: '1' theProduct: testObjectsFactory itemSellByTheStore withAmount: 10.
	
	self assert: '2' equals: (interface checkout: '1' withCCN: '4865642166849654' withCCED: (Month month: 8 year: 2021) withCCO: 'Matias Morales')! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'GR 12/1/2020 16:16:46'!
test16CheckOutDeletesTheCart

	interface createCartWithUser: 'Crocken321' andPassword: 'lacontraseniamasseguradetodas'.
	
	interface addToCart: '1' theProduct: testObjectsFactory itemSellByTheStore withAmount: 10.
	
	interface checkout: '1' withCCN: '4865642166849654' withCCED: (Month month: 8 year: 2021) withCCO: 'Matias Morales'.
	
	self deny: (interface isDefinedTheID: '1').! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'GR 12/2/2020 15:31:38'!
test17CanNotListPurchasesOfInvalidUsername

	self
		should: [ interface listPurchasesOfUser: 'Ete Sech' withPassword: 'hola123' ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: RESTInterface invalidUserError.! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'GR 12/2/2020 15:31:38'!
test18CanListPurchasesOfUserWithNoSales
	
	self assert: (OrderedCollection with: Bag new with: 0) equals: (interface listPurchasesOfUser: 'Crocken321' withPassword: 'lacontraseniamasseguradetodas').! !

!RESTInterfaceTest methodsFor: 'tests' stamp: 'GR 12/2/2020 15:31:38'!
test19CanListPurchasesOfUserWithSales
	
	interface createCartWithUser: 'Crocken321' andPassword: 'lacontraseniamasseguradetodas'.
	
	interface addToCart: '1' theProduct: testObjectsFactory itemSellByTheStore withAmount: 10.
	
	interface checkout: '1' withCCN: '4865642166849654' withCCED: (Month month: 8 year: 2021) withCCO: 'Matias Morales'.
	
	self 
		assert: (OrderedCollection with: testObjectsFactory bagWithElements with: testObjectsFactory itemSellByTheStorePrice * 10 ) 
		equals: (interface listPurchasesOfUser: 'Crocken321' withPassword: 'lacontraseniamasseguradetodas').! !


!RESTInterfaceTest methodsFor: 'clock' stamp: 'GR 11/30/2020 20:48:07'!
now
	
	^ clock now.! !

!RESTInterfaceTest methodsFor: 'clock' stamp: 'GR 11/30/2020 20:36:07'!
thirtyMinutesTimeWarp
	
	clock := WarpedClock new.! !


!RESTInterfaceTest methodsFor: 'merchantProcessor' stamp: 'GR 12/1/2020 15:24:40'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard 
	! !


!RESTInterfaceTest methodsFor: 'setUp' stamp: 'GR 12/1/2020 15:16:22'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.
	
	debitBehavior := [ :anAmount :aCreditCard | ].
	
	interface := RESTInterface withUserList: testObjectsFactory userList andCatalog: testObjectsFactory defaultCatalog withMerchantProcessor: self withClock: self.
	
	clock := RealTimeClock new.! !


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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

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


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'accessing' stamp: 'GR 12/1/2020 17:08:25'!
listCart
	
	^ items asBag! !


!Cart methodsFor: 'as yet unclassified' stamp: 'GR 12/1/2020 17:07:30'!
items
	self shouldBeImplemented.
	^items! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total saleID'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'GR 12/1/2020 17:09:02'!
createSale

	^ Sale of: total withID: saleID withItems: cart listCart
! !

!Cashier methodsFor: 'checkout - private' stamp: 'GR 12/2/2020 15:19:46'!
debitTotal
	
	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !

!Cashier methodsFor: 'checkout' stamp: 'GR 12/1/2020 16:13:07'!
checkOutWithID: aSaleID

	self setSaleID: aSaleID.
	
	self checkOut.! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !


!Cashier methodsFor: 'accessing' stamp: 'GR 12/1/2020 16:02:15'!
saleID
	
	^saleID! !


!Cashier methodsFor: 'converting' stamp: 'GR 12/1/2020 16:02:15'!
setSaleID: aSaleID 
	
	saleID := aSaleID.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #Clock category: 'TusLibros'!
Object subclass: #Clock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'time' stamp: 'GR 12/1/2020 17:22:26'!
now

	self subclassResponsibility.! !


!classDefinition: #RealTimeClock category: 'TusLibros'!
Clock subclass: #RealTimeClock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RealTimeClock methodsFor: 'time' stamp: 'GR 11/30/2020 20:58:17'!
now
	
	^ DateAndTime now.! !


!classDefinition: #WarpedClock category: 'TusLibros'!
Clock subclass: #WarpedClock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!WarpedClock methodsFor: 'time' stamp: 'GR 11/30/2020 20:48:51'!
now
	
	^ DateAndTime now + 30 minutes! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'GR 12/2/2020 14:58:26'!
initializeWithNumber: aCCN expiringOn: aMonth withOwner: aCCO  
	
	number := aCCN.
	expiration := aMonth.
	owner := aCCO. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'GR 12/2/2020 14:59:54'!
withNumber: aCCN expiringOn: aMonth withOwner: aCCO 

	(aCCO = '') ifTrue: [ self error: self invalidCreditCardErrorDescription ].
	
	^self new initializeWithNumber: aCCN expiringOn: aMonth withOwner: aCCO! !


!CreditCard class methodsFor: 'error handling' stamp: 'GR 12/2/2020 14:59:54'!
invalidCreditCardErrorDescription

	^ 'Invalid credit card'! !


!classDefinition: #RESTInterface category: 'TusLibros'!
Object subclass: #RESTInterface
	instanceVariableNames: 'userList nextID catalog carts salesBook clock merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RESTInterface methodsFor: 'initialization' stamp: 'GR 12/1/2020 16:46:51'!
initializeWithUserList: aUserList andCatalog: aCatalog withMerchantProcessor: aMerchantProcessor withClock: aClock   
	
	userList := aUserList.
	catalog := aCatalog.
	carts := Dictionary new.
	nextID := 0.
	clock := aClock.
	merchantProcessor := aMerchantProcessor.
	salesBook := Dictionary new.
	userList keysDo: [ :aUsername | salesBook add: aUsername->OrderedCollection new ]! !


!RESTInterface methodsFor: 'timeVerification' stamp: 'GR 11/30/2020 21:11:58'!
checkIfCartTimeExceeded: aCartID

	| cartLastTimeUsed |
	
	cartLastTimeUsed := self lastTimeUsed: aCartID.
	
	(clock now - cartLastTimeUsed ) >= 30 minutes ifTrue: [ 
		carts removeKey: aCartID.
		self error: self class cartTimeExceededErrorDescription ]! !


!RESTInterface methodsFor: 'operations' stamp: 'GR 11/30/2020 21:14:13'!
addToCart: aCartID theProduct: aProduct withAmount: aProductAmount

	(carts includesKey: aCartID) ifFalse: [self error: self class invalidCartError ].
	
	self checkIfCartTimeExceeded: aCartID.
	
	(self cartWithID: aCartID) add: aProductAmount of: aProduct.! !

!RESTInterface methodsFor: 'operations' stamp: 'GR 12/2/2020 14:55:33'!
checkout: aCartID withCCN: aCCN withCCED: aCCED withCCO: aCCO 
	
	| creditCard cashier cart saleID |
	
	(carts includesKey: aCartID) ifFalse: [ self error: self class invalidCartError ].
	
	self checkIfCartTimeExceeded: aCartID.
	
	cart := self cartWithID: aCartID.
	
	creditCard := CreditCard withNumber: aCCN expiringOn: aCCED withOwner: aCCO.
	
	cashier := Cashier 
			toCheckout: cart
			charging: creditCard 
			throught: merchantProcessor 
			on: clock now
			registeringOn: (self salesOfUserWithTheCart: aCartID).
	
	saleID := self getNextID.
	
	cashier checkOutWithID: saleID.
	
	carts removeKey: aCartID.
	
	^ cashier saleID.! !

!RESTInterface methodsFor: 'operations' stamp: 'GR 12/1/2020 15:31:22'!
createCartWithUser: aUsername andPassword: aPassword 
	
	| ID |
	
	self verificateUsername: aUsername andPassword: aPassword.
	
	ID := self getNextID.
	
	carts add: ID->( OrderedCollection with: (Cart acceptingItemsOf: catalog) with: aUsername with: DateAndTime now).
	
	^ ID! !

!RESTInterface methodsFor: 'operations' stamp: 'GR 12/2/2020 15:39:24'!
listCart: aCartID 
	
	| cart |
	
	(carts includesKey: aCartID) ifFalse: [self error: self class invalidCartError ].
	
	self checkIfCartTimeExceeded: aCartID.
	
	cart := self cartWithID: aCartID.
	
	^ cart listCart.! !

!RESTInterface methodsFor: 'operations' stamp: 'GR 12/2/2020 15:31:38'!
listPurchasesOfUser: aUsername withPassword: aPassword

	| purchases total |
	
	self verificateUsername: aUsername andPassword: aPassword.
	
	purchases := (self purchasesOf: aUsername) inject: Bag new addingAll: [ :aSale | aSale purchases].
	
	total := (self purchasesOf: aUsername) inject: 0 into: [ :totalAmount :aSale | totalAmount + aSale total].
	
	^ OrderedCollection with: purchases with: total.! !


!RESTInterface methodsFor: 'operations -- private' stamp: 'GR 12/1/2020 15:31:22'!
getNextID

	nextID := nextID +1.
	^nextID asString! !

!RESTInterface methodsFor: 'operations -- private' stamp: 'GR 11/30/2020 21:16:19'!
verificateUsername: aUsername andPassword: aPassword

	(userList includesKey: aUsername) ifFalse: [ self error: self class invalidUserError ].
	
	(userList at: aUsername) = aPassword ifFalse: [ self error: self class invalidUserError ]! !


!RESTInterface methodsFor: 'accessing' stamp: 'GR 11/30/2020 21:14:13'!
cartWithID: aCartID

	^ (carts at: aCartID) at: 1! !

!RESTInterface methodsFor: 'accessing' stamp: 'GR 11/30/2020 21:13:33'!
lastTimeUsed: aCartID 
	
	^ (carts at: aCartID) at: 3! !

!RESTInterface methodsFor: 'accessing' stamp: 'GR 12/1/2020 17:30:06'!
purchasesOf: aUsername

	^ salesBook at: aUsername! !

!RESTInterface methodsFor: 'accessing' stamp: 'GR 12/1/2020 17:01:00'!
salesOfUserWithTheCart: aCartID

	^ salesBook at: (self userOfCart: aCartID)! !

!RESTInterface methodsFor: 'accessing' stamp: 'GR 12/1/2020 17:02:04'!
userOfCart: aCartID

	^ (carts at: aCartID) at: 2 ! !


!RESTInterface methodsFor: 'testing' stamp: 'GR 11/29/2020 15:22:01'!
isDefinedTheID: aCartID

	^ carts includesKey: aCartID.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RESTInterface class' category: 'TusLibros'!
RESTInterface class
	instanceVariableNames: ''!

!RESTInterface class methodsFor: 'instance creation' stamp: 'GR 11/30/2020 20:43:07'!
withUserList: aUserList andCatalog: aCatalog withMerchantProcessor: aMerchantProcessor withClock: aClock   
	
	^self new initializeWithUserList: aUserList andCatalog: aCatalog withMerchantProcessor: aMerchantProcessor withClock: aClock ! !


!RESTInterface class methodsFor: 'error handling' stamp: 'GR 11/30/2020 20:49:52'!
cartTimeExceededErrorDescription
	
	^ 'Cart time exceeded'! !

!RESTInterface class methodsFor: 'error handling' stamp: 'GR 11/29/2020 15:42:28'!
invalidCartError
	
	^ 'Invalid cart'! !

!RESTInterface class methodsFor: 'error handling' stamp: 'GR 11/26/2020 21:25:26'!
invalidUserError
	
	^ 'Invalid username or password'! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total id items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'GR 12/1/2020 17:06:11'!
initializeOf: aTotal withID: anID withItems: anItemList  
	
	total := aTotal.
	id := anID.
	items := anItemList.! !


!Sale methodsFor: 'accessing' stamp: 'GR 12/1/2020 17:06:23'!
purchases
	
	^ items! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'GR 12/1/2020 17:21:01'!
of: aTotal withID: anID withItems: anItemList  
	
	^self new initializeOf: aTotal withID: anID withItems: anItemList ! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'GR 12/2/2020 14:55:48'!
expiredCreditCard
	
	^CreditCard withNumber: '4852536874523584' expiringOn: (Month month: today monthIndex year: today yearNumber - 1) withOwner: 'Matias Morales'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'GR 12/2/2020 14:55:52'!
notExpiredCreditCard
	
	^CreditCard withNumber: '4852536874523584' expiringOn: (Month month: today monthIndex year: today yearNumber + 1) withOwner: 'Matias Morales'! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'GR 12/1/2020 17:16:07'!
bagWithElements
	
	| bag |
	
	bag := Bag new.
	
	bag add: self itemSellByTheStore withOccurrences: 10.
	
	^ bag.! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'GR 11/29/2020 15:18:46'!
userList

	^ Dictionary 
		with: 'Crocken321'->'lacontraseniamasseguradetodas'
		with: 'ortoPilot'->'ilovemusic'! !
