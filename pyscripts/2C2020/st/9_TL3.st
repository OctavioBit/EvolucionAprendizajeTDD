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

!CartTest methodsFor: 'tests' stamp: 'FD 12/2/2020 18:44:20'!
test09CartExpiresAfter30Minutes

	| cart |
	
	cart := testObjectsFactory createCart.
	
	testObjectsFactory advance30minutes.
	
	
	self should: [cart add: 2 of: testObjectsFactory itemSellByTheStore.] raise: Error - MessageNotUnderstood withMessageText: cart expiredCartErrorMessage.
	! !


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


!classDefinition: #TusLibrosInterfaceTest category: 'TusLibros'!
TestCase subclass: #TusLibrosInterfaceTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'FD 11/28/2020 15:16:18'!
test01CanNotCreateACartWithAnInvalidClientId

	| tusLibrosInterface invalidClientId password |
	
	
	tusLibrosInterface := testObjectsFactory createTusLibrosInterface.
	invalidClientId := testObjectsFactory invalidClientId.
	password := testObjectsFactory invalidPassword.
	
	self should: [ tusLibrosInterface createCartFor: invalidClientId withPassword: password  ]
	raise: Error - MessageNotUnderstood 
	withMessageText: TusLibrosInterface invalidClientIdErrorDescription.! !

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'FD 11/28/2020 15:16:32'!
test02CanNotCreateACartWithAnInvalidPassword

	| tusLibrosInterface validClientId invalidPassword |
	
	
	tusLibrosInterface := testObjectsFactory createTusLibrosInterface.
	validClientId := testObjectsFactory validClientId.
	invalidPassword := testObjectsFactory invalidPassword.
	
	self should: [ tusLibrosInterface createCartFor: validClientId withPassword: invalidPassword  ]
	raise: Error - MessageNotUnderstood 
	withMessageText: TusLibrosInterface invalidPasswordErrorDescription.! !

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'FD 11/28/2020 15:27:10'!
test03CreatesANewCart

	| tusLibrosInterface validClientId validPassword newCartId |
	
	
	tusLibrosInterface := testObjectsFactory createTusLibrosInterface.
	validClientId := testObjectsFactory validClientId.
	validPassword := testObjectsFactory validPassword.
	
	newCartId := tusLibrosInterface createCartFor: validClientId withPassword: validPassword.
	
	self assert: (tusLibrosInterface listCart: newCartId ) isEmpty.
	! !

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'FD 11/28/2020 15:39:27'!
test04CanNotAddItemToAnInvalidCartId

	| tusLibrosInterface invalidCartId validBookISBN validQuantity |
	
	
	tusLibrosInterface := testObjectsFactory createTusLibrosInterface.
	invalidCartId := testObjectsFactory invalidCartId.
	validBookISBN := testObjectsFactory itemSellByTheStore.
	validQuantity := 1.
	
	self should: [ tusLibrosInterface add: validQuantity of: validBookISBN  toCart: invalidCartId.]
	 raise:  Error - MessageNotUnderstood
	withMessageText: TusLibrosInterface invalidCartIdErrorDescription.
	! !

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'FD 11/28/2020 15:55:38'!
test05CanNotAddInvalidItemToCart

	| tusLibrosInterface cartId invalidBookISBN quantity |
	
	
	tusLibrosInterface := testObjectsFactory createTusLibrosInterface.
	invalidBookISBN := testObjectsFactory itemNotSellByTheStore.
	quantity := 1.
	
	cartId := tusLibrosInterface createCartFor: testObjectsFactory validClientId withPassword: testObjectsFactory validPassword.
	
	self should: [ tusLibrosInterface add: quantity of: invalidBookISBN  toCart: cartId.]
	 raise:  Error - MessageNotUnderstood
	withMessageText: TusLibrosInterface invalidItemErrorDescription.
	! !

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'FD 11/28/2020 15:58:07'!
test06CanNotAddInvalidItemQuantityToCart

	| tusLibrosInterface cartId bookISBN quantity |
	
	
	tusLibrosInterface := testObjectsFactory createTusLibrosInterface.
	bookISBN := testObjectsFactory itemSellByTheStore .
	quantity := 0.
	
	cartId := tusLibrosInterface createCartFor: testObjectsFactory validClientId withPassword: testObjectsFactory validPassword.
	
	self should: [ tusLibrosInterface add: quantity of: bookISBN  toCart: cartId.]
	 raise:  Error - MessageNotUnderstood
	withMessageText: TusLibrosInterface invalidItemQuantityErrorDescription.
	! !

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'FD 11/28/2020 16:41:34'!
test07AddsItemsToCart

	| tusLibrosInterface cartId bookISBN quantity |
	
	
	tusLibrosInterface := testObjectsFactory createTusLibrosInterface.
	bookISBN := testObjectsFactory itemSellByTheStore .
	quantity := 2.
	
	cartId := tusLibrosInterface createCartFor: testObjectsFactory validClientId withPassword: testObjectsFactory validPassword.
	
	tusLibrosInterface add: quantity of: bookISBN  toCart: cartId.
	
	self assert: ((tusLibrosInterface listCart: cartId ) occurrencesOf: bookISBN)  = quantity.! !

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'FD 11/28/2020 16:53:19'!
test08OnlyAddsItemsToSpecifiedCart

	| tusLibrosInterface firstCartId secondCartId bookISBN quantity |
	
	
	tusLibrosInterface := testObjectsFactory createTusLibrosInterface.
	bookISBN := testObjectsFactory itemSellByTheStore .
	quantity := 2.
	
	firstCartId := tusLibrosInterface createCartFor: testObjectsFactory validClientId withPassword: testObjectsFactory validPassword.
	secondCartId := tusLibrosInterface createCartFor: testObjectsFactory validClientId withPassword: testObjectsFactory validPassword.
	
	tusLibrosInterface add: quantity of: bookISBN  toCart: firstCartId.
	
	self assert: ((tusLibrosInterface listCart: firstCartId ) occurrencesOf: bookISBN)  = quantity.
	self assert: (tusLibrosInterface listCart: secondCartId) isEmpty.! !

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'FD 11/28/2020 16:59:26'!
test09CanNotListAnInvalidCartId

	| tusLibrosInterface cartId |
	
	
	tusLibrosInterface := testObjectsFactory createTusLibrosInterface.
	
	cartId := testObjectsFactory invalidCartId.

	self should: [tusLibrosInterface listCart: cartId]
	raise:  Error - MessageNotUnderstood 
	withMessageText: TusLibrosInterface invalidCartIdErrorDescription.! !

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'FD 11/28/2020 17:02:33'!
test10CanNotCheckoutAnInvalidCartId

	| tusLibrosInterface cartId creditCard |
	
	
	tusLibrosInterface := testObjectsFactory createTusLibrosInterface.
	
	cartId := testObjectsFactory invalidCartId.
	creditCard := testObjectsFactory notExpiredCreditCard.

	self should: [tusLibrosInterface checkout: cartId with: creditCard]
	raise:  Error - MessageNotUnderstood 
	withMessageText: TusLibrosInterface invalidCartIdErrorDescription.! !

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'FD 11/28/2020 17:21:46'!
test11CanNotCheckoutWithAnExpiredCreditCard

	| tusLibrosInterface cartId creditCard |
	
	
	tusLibrosInterface := testObjectsFactory createTusLibrosInterface.
	
	cartId := tusLibrosInterface createCartFor: testObjectsFactory validClientId withPassword: testObjectsFactory validPassword.
	
	tusLibrosInterface add: 1 of: testObjectsFactory itemSellByTheStore toCart: cartId.
	
	creditCard := testObjectsFactory expiredCreditCard.

	self should: [tusLibrosInterface checkout: cartId with: creditCard]
	raise:  Error - MessageNotUnderstood 
	withMessageText: TusLibrosInterface expiredCreditCardErrorDescription.! !

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'FD 12/2/2020 17:47:26'!
test12CheckoutRegistersASale

	| tusLibrosInterface clientId password cartId creditCard |
	
	
	clientId := testObjectsFactory validClientId.
	password := testObjectsFactory validPassword.
	tusLibrosInterface := testObjectsFactory createTusLibrosInterface.
	
	cartId := tusLibrosInterface createCartFor: clientId withPassword: password.
	
	tusLibrosInterface add: 1 of: testObjectsFactory itemSellByTheStore toCart: cartId.
	
	creditCard := testObjectsFactory notExpiredCreditCard.

	tusLibrosInterface checkout: cartId with: creditCard.
	
	self assert: ((tusLibrosInterface listPurchasesFor: clientId withPassword: password) includesKey: testObjectsFactory itemSellByTheStore).! !

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'FD 11/28/2020 17:50:59'!
test13CanNotListPurchasesWithAnInvalidClientId

		| tusLibrosInterface invalidClientId password |
	
	
	tusLibrosInterface := testObjectsFactory createTusLibrosInterface.
	invalidClientId := testObjectsFactory invalidClientId.
	password := testObjectsFactory validPassword.
	
	self should: [ tusLibrosInterface listPurchasesFor: invalidClientId withPassword: password  ]
	raise: Error - MessageNotUnderstood 
	withMessageText: TusLibrosInterface invalidClientIdErrorDescription.! !

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'FD 11/28/2020 17:50:55'!
test14CanNotListPurchasesWithAnInvalidPassword

		| tusLibrosInterface clientId invalidPassword |
	
	
	tusLibrosInterface := testObjectsFactory createTusLibrosInterface.
	clientId := testObjectsFactory validClientId.
	invalidPassword := testObjectsFactory invalidPassword.
	
	self should: [ tusLibrosInterface listPurchasesFor: clientId withPassword: invalidPassword  ]
	raise: Error - MessageNotUnderstood 
	withMessageText: TusLibrosInterface invalidPasswordErrorDescription .! !

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'FD 12/2/2020 17:27:36'!
test15OnlyListsTotalAmountWhenThereAreNoPurchasesForTheClient

		| tusLibrosInterface clientId validPassword expectedPurchaseList |
	
	
	expectedPurchaseList := Dictionary new.
	expectedPurchaseList at: 'totalAmount' put: 0.
	
	tusLibrosInterface := testObjectsFactory createTusLibrosInterface.
	clientId := testObjectsFactory validClientId.
	validPassword := testObjectsFactory validPassword.
	
	self assert: (tusLibrosInterface listPurchasesFor: clientId withPassword: validPassword) equals: expectedPurchaseList ! !

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'FD 12/2/2020 17:33:42'!
test16ListsAllPurchasesForAClient

		| tusLibrosInterface clientId validPassword expectedPurchaseList cartId creditCard|
	
	
	expectedPurchaseList := Dictionary new.
	expectedPurchaseList at: 'totalAmount' put: testObjectsFactory itemSellByTheStorePrice * 2.
	expectedPurchaseList  at: testObjectsFactory itemSellByTheStore put: 2.
	
	tusLibrosInterface := testObjectsFactory createTusLibrosInterface.
	clientId := testObjectsFactory validClientId.
	validPassword := testObjectsFactory validPassword.
	
		
	cartId := tusLibrosInterface createCartFor: clientId withPassword: validPassword.
	tusLibrosInterface add: 2 of: testObjectsFactory itemSellByTheStore toCart: cartId.
	creditCard := testObjectsFactory notExpiredCreditCard.
	tusLibrosInterface checkout: cartId with: creditCard.
	
	self assert: (tusLibrosInterface listPurchasesFor: clientId withPassword: validPassword) equals: expectedPurchaseList ! !

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'FD 12/2/2020 18:40:11'!
test17ListsPurchasesOnlyListsAClientsPurchases

		| tusLibrosInterface clientId validPassword expectedPurchaseList cartId creditCard|
	
	
	expectedPurchaseList := Dictionary new.
	expectedPurchaseList at: 'totalAmount' put: testObjectsFactory itemSellByTheStorePrice * 2.
	expectedPurchaseList  at: testObjectsFactory itemSellByTheStore put: 2.
	
	tusLibrosInterface := testObjectsFactory createTusLibrosInterface.
	clientId := testObjectsFactory validClientId.
	validPassword := testObjectsFactory validPassword.
	
		
	cartId := tusLibrosInterface createCartFor: clientId withPassword: validPassword.
	tusLibrosInterface add: 2 of: testObjectsFactory itemSellByTheStore toCart: cartId.
	creditCard := testObjectsFactory notExpiredCreditCard.
	tusLibrosInterface checkout: cartId with: creditCard.
	
	cartId := tusLibrosInterface createCartFor: testObjectsFactory anotherValidClientId withPassword: validPassword.
	tusLibrosInterface add: 5 of: testObjectsFactory itemSellByTheStore toCart: cartId.
	creditCard := testObjectsFactory notExpiredCreditCard.
	tusLibrosInterface checkout: cartId with: creditCard.
	
	self assert: (tusLibrosInterface listPurchasesFor: clientId withPassword: validPassword) equals: expectedPurchaseList ! !


!TusLibrosInterfaceTest methodsFor: 'setup' stamp: 'FD 11/28/2020 17:40:11'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items clock lastActive'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'FD 12/2/2020 18:43:50'!
expiredCartErrorMessage
	
	^ 'Cart has expired'.! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'FD 12/2/2020 19:11:30'!
assertCartIsValid

	| inactiveTime |
	
	inactiveTime := clock now - lastActive.
	
	inactiveTime < (Duration minutes: 30) ifFalse: [ self error: self expiredCartErrorMessage ].
	lastActive := clock now.! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'FD 12/2/2020 18:55:05'!
initializeAcceptingItemsOf: aCatalog withClock: aClock

	catalog := aCatalog.
	items := OrderedCollection new.
	clock := aClock.
	lastActive := clock now.! !


!Cart methodsFor: 'queries' stamp: 'FD 12/2/2020 19:02:42'!
list

	self assertCartIsValid.
	^items.! !

!Cart methodsFor: 'queries' stamp: 'FD 12/2/2020 19:02:50'!
occurrencesOf: anItem

	self assertCartIsValid.
	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'FD 12/2/2020 19:02:57'!
includes: anItem

	self assertCartIsValid.
	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'FD 12/2/2020 19:03:02'!
isEmpty
	
	self assertCartIsValid.
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'FD 12/2/2020 19:03:12'!
total

	self assertCartIsValid.
	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'FD 12/2/2020 19:03:18'!
add: anItem

	self assertCartIsValid.
	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'FD 12/2/2020 19:03:24'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.
	self assertCartIsValid.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'FD 12/2/2020 18:55:32'!
acceptingItemsOf: aCatalog withClock: aClock

	^self new initializeAcceptingItemsOf: aCatalog withClock: aClock! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'FD 12/2/2020 17:37:28'!
createSale

	^ Sale of: total for: cart list
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
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


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

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


!classDefinition: #ClientRecord category: 'TusLibros'!
Object subclass: #ClientRecord
	instanceVariableNames: 'cartList salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ClientRecord methodsFor: 'as yet unclassified' stamp: 'FD 12/2/2020 18:18:11'!
addCart: aCart withId: aCartId 
	
	
	cartList at: aCartId put: aCart.! !

!ClientRecord methodsFor: 'as yet unclassified' stamp: 'FD 12/2/2020 18:39:10'!
cartList

	^ cartList.! !

!ClientRecord methodsFor: 'as yet unclassified' stamp: 'FD 12/2/2020 18:32:34'!
initialize

	cartList := Dictionary new.
	salesBook := OrderedCollection new.! !

!ClientRecord methodsFor: 'as yet unclassified' stamp: 'FD 12/2/2020 18:39:06'!
salesBook

	^ salesBook.! !


!classDefinition: #Clock category: 'TusLibros'!
Object subclass: #Clock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'now' stamp: 'FD 12/2/2020 18:46:37'!
now

	self subclassResponsibility.! !


!classDefinition: #ClockSimulator category: 'TusLibros'!
Clock subclass: #ClockSimulator
	instanceVariableNames: 'offset'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ClockSimulator methodsFor: 'initialization' stamp: 'FD 12/2/2020 19:10:38'!
initialize

	offset := Duration minutes: 0.! !


!ClockSimulator methodsFor: 'now' stamp: 'FD 12/2/2020 19:10:16'!
now

	^ DateAndTime now + offset.! !


!ClockSimulator methodsFor: 'clock manipulation' stamp: 'FD 12/2/2020 19:12:25'!
advanceInTime: minutes

	offset := offset + (Duration minutes: minutes).! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total purchaseList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'FD 12/2/2020 17:39:15'!
initializeTotal: aTotal for: aPurchaseList

	total := aTotal.
	purchaseList := aPurchaseList.! !


!Sale methodsFor: 'purchaseList' stamp: 'FD 12/2/2020 17:39:42'!
purchaseList
	
	^ purchaseList! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'FD 12/2/2020 17:38:42'!
of: aTotal for: aPurchaseList

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal for: aPurchaseList.! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today debitBehavior clock'
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


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'FD 12/2/2020 18:50:13'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog withClock: clock.! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'FD 12/2/2020 18:50:26'!
initialize

	today := DateAndTime now.
	debitBehavior := [ :anAmount :aCreditCard | ].
	clock := ClockSimulator new.! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'tus libros interface' stamp: 'FD 12/2/2020 17:50:16'!
anotherValidClientId

	^90.! !

!StoreTestObjectsFactory methodsFor: 'tus libros interface' stamp: 'FD 11/28/2020 17:40:54'!
createTusLibrosInterface

	^ TusLibrosInterface withClientList: self defaultClientList withCatalog: self defaultCatalog withMerchantProcessor: self.! !

!StoreTestObjectsFactory methodsFor: 'tus libros interface' stamp: 'FD 12/2/2020 17:50:52'!
defaultClientList

	^Dictionary new
		at: self validClientId put: self validPassword;
		at: self anotherValidClientId  put: self validPassword;
		yourself ! !

!StoreTestObjectsFactory methodsFor: 'tus libros interface' stamp: 'FD 11/28/2020 17:52:54'!
invalidCartId
	^ -9.! !

!StoreTestObjectsFactory methodsFor: 'tus libros interface' stamp: 'FD 11/28/2020 15:04:21'!
invalidClientId

	^1.! !

!StoreTestObjectsFactory methodsFor: 'tus libros interface' stamp: 'FD 11/28/2020 15:04:29'!
invalidPassword

	^1.! !

!StoreTestObjectsFactory methodsFor: 'tus libros interface' stamp: 'FD 11/28/2020 15:05:59'!
validClientId

	^0.! !

!StoreTestObjectsFactory methodsFor: 'tus libros interface' stamp: 'FD 11/28/2020 15:13:32'!
validPassword

	^0.! !


!StoreTestObjectsFactory methodsFor: 'merchant processor protocol' stamp: 'FD 11/28/2020 17:39:50'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!StoreTestObjectsFactory methodsFor: 'clock' stamp: 'FD 12/2/2020 19:11:50'!
advance30minutes

	clock advanceInTime: 30.! !


!classDefinition: #TusLibrosInterface category: 'TusLibros'!
Object subclass: #TusLibrosInterface
	instanceVariableNames: 'clientList catalog merchantProcessor clientRecords lastCartId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInterface methodsFor: 'actions' stamp: 'FD 12/2/2020 18:24:54'!
add: aQuantity of: anItem toCart: aCartId
	
	| cart |

	cart := (self findClientRecordHolding: aCartId ) cartList at: aCartId.
	
	self handleAction: [cart add: aQuantity of: anItem.]
	      onError: (self handleErrorforCart: cart).! !

!TusLibrosInterface methodsFor: 'actions' stamp: 'FD 12/2/2020 18:25:57'!
checkout: aCartId with: aCreditCard 
	
	self assertValidCartId: aCartId.
	
	self handleAction: [self handleCheckoutCart: aCartId withCreditCard: aCreditCard ]
	      onError: self handleCashierError.! !

!TusLibrosInterface methodsFor: 'actions' stamp: 'FD 12/2/2020 18:07:40'!
createCartFor: aClientId withPassword: aPassword
	
	self assertValidPassword: aPassword forClient: aClientId.
	
	^ self createCartAndGetIdFor: aClientId.
	! !

!TusLibrosInterface methodsFor: 'actions' stamp: 'FD 12/2/2020 18:23:23'!
listCart: aCartId 
	
	^((self findClientRecordHolding: aCartId) cartList at: aCartId) list.! !

!TusLibrosInterface methodsFor: 'actions' stamp: 'FD 12/2/2020 18:37:27'!
listPurchasesFor: aClientId withPassword: aPassword

	| purchaseList totalAmount clientRecord |
	
	self assertValidPassword:  aPassword forClient: aClientId.
	
	clientRecord := self clientRecordFor: aClientId.
	totalAmount := clientRecord salesBook sum: [ :sale | sale total ] ifEmpty: 0.
	
	purchaseList := Dictionary new.
	purchaseList at: 'totalAmount' put: totalAmount.
	
	clientRecord salesBook do: [ :sale | sale purchaseList do: [ :product | purchaseList at: product put: (sale purchaseList occurrencesOf: product) ]].
	
	^purchaseList.! !


!TusLibrosInterface methodsFor: 'actions -- private' stamp: 'FD 12/2/2020 18:56:06'!
createCartAndGetIdFor: aClientId

	| newCartId |
	
	newCartId := self getNewCartId.
	
	(self clientRecordFor: aClientId) addCart: (Cart acceptingItemsOf: catalog withClock: DateAndTime) withId: newCartId.
	
	^newCartId.
		! !

!TusLibrosInterface methodsFor: 'actions -- private' stamp: 'FD 12/2/2020 18:17:05'!
getNewCartId

	lastCartId := lastCartId + 1.
	^lastCartId
	! !

!TusLibrosInterface methodsFor: 'actions -- private' stamp: 'FD 11/28/2020 18:08:38'!
handleAction: anAction onError: errorHandler
	
	[anAction value]
	on: Error
	do: errorHandler.! !

!TusLibrosInterface methodsFor: 'actions -- private' stamp: 'FD 12/2/2020 18:31:53'!
handleCheckoutCart: aCartId withCreditCard: aCreditCard
	
		| clientRecord cart salesBook|
		
		clientRecord := self findClientRecordHolding: aCartId.
		cart := clientRecord cartList at: aCartId.
		salesBook := clientRecord salesBook.
	
		(Cashier toCheckout: cart 
		charging: aCreditCard
		throught: merchantProcessor 
		on: DateAndTime today
		registeringOn: salesBook) checkOut.
		! !

!TusLibrosInterface methodsFor: 'actions -- private' stamp: 'FD 12/2/2020 17:55:21'!
salesBookForClient: aClientId
	
		^salesBooks at: aClientId ifAbsent: [^salesBooks at: aClientId put: OrderedCollection new]
		! !


!TusLibrosInterface methodsFor: 'assertions' stamp: 'FD 12/2/2020 18:24:12'!
assertValidCartId: aCartId

	self findClientRecordHolding: aCartId.! !

!TusLibrosInterface methodsFor: 'assertions' stamp: 'FD 12/2/2020 17:51:30'!
assertValidClientId: aClientId

	^ (clientList includesKey: aClientId) ifFalse: self signalInvalidClientId! !

!TusLibrosInterface methodsFor: 'assertions' stamp: 'FD 11/28/2020 16:32:58'!
assertValidPassword: aPassword forClient: aClientId

	self assertValidClientId: aClientId.
	
	((clientList at: aClientId) = aPassword ) ifFalse: self signalInvalidPassword.! !


!TusLibrosInterface methodsFor: 'error handling' stamp: 'FD 11/28/2020 18:30:21'!
handleCashierError

		
		^[ :anError | 
			(anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage) ifTrue: self signalExpiredCreditCard.
			self error: anError.
		].
	! !

!TusLibrosInterface methodsFor: 'error handling' stamp: 'FD 11/28/2020 18:15:10'!
handleErrorforCart: aCart

		^[:anError | 
			(anError messageText = aCart invalidItemErrorMessage) ifTrue: self signalInvalidItem.
			(anError messageText = aCart invalidQuantityErrorMessage) ifTrue: self signalInvalidItemQuantity.
			self error: anError.
		]
	! !


!TusLibrosInterface methodsFor: 'initialization' stamp: 'FD 12/2/2020 18:17:14'!
initializeWithClientList: aClientList withCatalog: aCatalog withMerchantProcessor: aMerchantProcessor

	clientList := aClientList.
	catalog := aCatalog.
	merchantProcessor := aMerchantProcessor.
	clientRecords := Dictionary new.
	lastCartId := 0.! !


!TusLibrosInterface methodsFor: 'signal' stamp: 'FD 11/28/2020 18:04:37'!
signalExpiredCreditCard

	^ [self error: self class expiredCreditCardErrorDescription ]! !

!TusLibrosInterface methodsFor: 'signal' stamp: 'FD 11/28/2020 17:54:56'!
signalInvalidCartId

	^ [self error: self class invalidCartIdErrorDescription.]! !

!TusLibrosInterface methodsFor: 'signal' stamp: 'FD 11/28/2020 16:28:42'!
signalInvalidClientId

	^ [self error: self class invalidClientIdErrorDescription.]! !

!TusLibrosInterface methodsFor: 'signal' stamp: 'FD 11/28/2020 17:56:10'!
signalInvalidItem

	^ [self error: self class invalidItemErrorDescription]! !

!TusLibrosInterface methodsFor: 'signal' stamp: 'FD 11/28/2020 17:56:24'!
signalInvalidItemQuantity

	^ [self error: self class invalidItemQuantityErrorDescription]! !

!TusLibrosInterface methodsFor: 'signal' stamp: 'FD 11/28/2020 16:31:33'!
signalInvalidPassword

	^ [self error: self class invalidPasswordErrorDescription]! !


!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'FD 12/2/2020 18:14:22'!
clientRecordFor: aClientId

	^ clientRecords at: aClientId ifAbsent: [ ^clientRecords at: aClientId put: ClientRecord new].! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'FD 12/2/2020 18:22:49'!
findClientRecordHolding: aCartId 
	
	^clientRecords values detect: [ :clientRecord | clientRecord cartList includesKey: aCartId ] ifNone: self signalInvalidCartId.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosInterface class' category: 'TusLibros'!
TusLibrosInterface class
	instanceVariableNames: ''!

!TusLibrosInterface class methodsFor: 'error messages' stamp: 'FD 11/28/2020 17:09:37'!
expiredCreditCardErrorDescription
	^ 'Credit card has expired'.! !

!TusLibrosInterface class methodsFor: 'error messages' stamp: 'FD 11/28/2020 15:39:48'!
invalidCartIdErrorDescription
	^ 'Invalid Cart Id'.! !

!TusLibrosInterface class methodsFor: 'error messages' stamp: 'FD 11/28/2020 15:00:41'!
invalidClientIdErrorDescription
	^ 'Invalid client id'! !

!TusLibrosInterface class methodsFor: 'error messages' stamp: 'FD 11/28/2020 15:42:34'!
invalidItemErrorDescription
	
	^ 'Invalid Item'.! !

!TusLibrosInterface class methodsFor: 'error messages' stamp: 'FD 11/28/2020 15:58:24'!
invalidItemQuantityErrorDescription
	^ 'Invalid item quantity'! !

!TusLibrosInterface class methodsFor: 'error messages' stamp: 'FD 11/28/2020 15:06:25'!
invalidPasswordErrorDescription
	^ 'Invalid password'.! !


!TusLibrosInterface class methodsFor: 'instance creation' stamp: 'FD 11/28/2020 17:20:46'!
withClientList: aClientList withCatalog: aCatalog withMerchantProcessor: aMerchantProcessor

	^self new initializeWithClientList: aClientList withCatalog: aCatalog withMerchantProcessor: aMerchantProcessor .! !
