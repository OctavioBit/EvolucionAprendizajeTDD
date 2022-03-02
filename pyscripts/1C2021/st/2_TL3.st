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


!classDefinition: #StoreTest category: 'TusLibros'!
TestCase subclass: #StoreTest
	instanceVariableNames: 'authenticateBehaviour testObjectFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTest methodsFor: 'merchant processor' stamp: 'GDH 6/23/2021 17:59:45'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!StoreTest methodsFor: 'authenticator' stamp: 'MS 6/21/2021 17:54:56'!
authenticate: aClientId with: aPassword

	^authenticateBehaviour value: aClientId value: aPassword.! !


!StoreTest methodsFor: 'setUp' stamp: 'MS 6/21/2021 18:39:10'!
setUp

	testObjectFactory := StoreTestObjectsFactory new.! !


!StoreTest methodsFor: 'tests' stamp: 'MS 6/21/2021 20:14:40'!
test01CreateCartWithInvalidCredentialsShouldRaiseError

	| store clientId password |
	
	clientId := 'randomId123'.
	password := 'randomPassword123'.
	
	authenticateBehaviour := [ :aClientId :aClientPassword | false ].
	
	store := self createStoreWithDefaultCatalog.
	
	self should: [ store createCartFor: clientId using: password ]
	 	raise:  Error - MessageNotUnderstood
		withMessageText: Store invalidCredentialsErrorMessageDescription.
	
	! !

!StoreTest methodsFor: 'tests' stamp: 'MS 6/21/2021 20:14:40'!
test02CreateCartWithValidCredentialsShouldCreateACart

	| store clientId password cartId |
	
	clientId := 'randomId123'.
	password := 'randomPassword123'.
	
	authenticateBehaviour := [ :aClientId :aClientPassword | true ].
	
	store := self createStoreWithDefaultCatalog.
	
	cartId := store createCartFor: clientId using: password.
	
	self assert: (store listCart: cartId) isEmpty.
	
	
	
	! !

!StoreTest methodsFor: 'tests' stamp: 'MS 6/21/2021 20:14:40'!
test03CreatingManyCartsShouldGiveDifferentCartsIds

	| store clientId password cartId1 cartId2 |
	
	clientId := 'randomId123'.
	password := 'randomPassword123'.
	
	authenticateBehaviour := [ :aClientId :aClientPassword | true ].
	
	store := self createStoreWithDefaultCatalog.
	
	cartId1 := store createCartFor: clientId using: password.
	cartId2 := store createCartFor: clientId using: password.
	
	self deny: cartId1 = cartId2.
	
	
	
	! !

!StoreTest methodsFor: 'tests' stamp: 'MS 6/21/2021 20:14:40'!
test04AddBookToExistingCartShouldExpectBookInCartList

	| store clientId password cartId isbn |
	
	clientId := 'randomId123'.
	password := 'randomPassword123'.
	
	authenticateBehaviour := [ :aClientId :aClientPassword | true ].
	
	store := self createStoreWithDefaultCatalog.
	
	cartId := store createCartFor: clientId using: password.
	
	isbn := testObjectFactory defaultCatalog keys first.
			
	store add: 1 of: isbn to: cartId.
	
	self assert: (store listCart: cartId) includes: isbn
	! !

!StoreTest methodsFor: 'tests' stamp: 'MS 6/21/2021 20:15:39'!
test05AddDifferentBooksToCartsShouldExpectCartListsToBeDifferent

	| store clientId password cartId1 cartId2 isbn1 isbn2 |
	
	clientId := 'randomId123'.
	password := 'randomPassword123'.
	
	authenticateBehaviour := [ :aClientId :aClientPassword | true ].
	
	store := self createStoreWithBigCatalog.
	
	cartId1 := store createCartFor: clientId using: password.

	cartId2 := store createCartFor: clientId using: password.
		
	isbn1 := testObjectFactory bigCatalog keys first.

	isbn2 := testObjectFactory bigCatalog keys second.
			
	store add: 1 of: isbn1 to: cartId1.

	store add: 1 of: isbn2 to: cartId2.	
		
	self assert: (store listCart: cartId1) includes: isbn1.
	self deny: ((store listCart: cartId1) includes: isbn2).

	self assert: (store listCart: cartId2) includes: isbn2.
	self deny: ((store listCart: cartId2) includes: isbn1).
	! !

!StoreTest methodsFor: 'tests' stamp: 'MS 6/21/2021 20:16:05'!
test06AddingBookUsingInvalidCartIdShouldRaiseAnError

	| store isbn |
	
	store := self createStoreWithDefaultCatalog.
		
	isbn := testObjectFactory defaultCatalog keys first.
			
	self should: [ store add: 1 of: isbn to: 10 ] 
	 	raise: Error - MessageNotUnderstood 
		withMessageText: Store invalidCartIdErrorMessageDescription.! !

!StoreTest methodsFor: 'tests' stamp: 'MS 6/21/2021 20:16:17'!
test07ListingCartUsingInvalidCartIdShouldRaiseAnError

	| store |
	
	store := self createStoreWithDefaultCatalog.
		
	self should: [ store listCart: 10 ] 
	 	raise: Error - MessageNotUnderstood 
		withMessageText: Store invalidCartIdErrorMessageDescription.! !

!StoreTest methodsFor: 'tests' stamp: 'MS 6/21/2021 21:07:27'!
test08CheckingOutUsingInvalidCreditCardNumberLengthShouldRaiseAnError
	
	| store cartId isbn cardNumber cardExpiration cardName |
	
	authenticateBehaviour := [ :aClientId :aClientPassword | true ].
	
	store := self createStoreWithDefaultCatalog.
	
	cartId := store createCartFor: 'validUserId' using: 'validPassword'.
	
	isbn := testObjectFactory defaultCatalog keys first.
	
	store add: 1 of: isbn to: cartId.
	
	cardNumber := 123. 
	
	cardExpiration := testObjectFactory nextYear.
	
	cardName := 'matias'.
		
	self should: [ store checkOut: cartId forCco: cardName withCcn: cardNumber expiringOn: cardExpiration ] 
	 	raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard invalidCardLengthErrorMessageDescription .! !

!StoreTest methodsFor: 'tests' stamp: 'MS 6/23/2021 11:14:39'!
test09CheckingOutUsingInvalidCreditCardNameShouldRaiseAnError
	
	| store cartId isbn cardNumber cardExpiration cardName |
	
	authenticateBehaviour := [ :aClientId :aClientPassword | true ].
	
	store := self createStoreWithDefaultCatalog.
	
	cartId := store createCartFor: 'validUserId' using: 'validPassword'.
	
	isbn := testObjectFactory defaultCatalog keys first.
	
	store add: 1 of: isbn to: cartId.
	
	cardNumber := 1111222233334444. 
	
	cardExpiration := testObjectFactory nextYear.
	
	cardName := ''.
		
	self should: [ store checkOut: cartId forCco: cardName withCcn: cardNumber expiringOn: cardExpiration ] 
	 	raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard invalidCardNameErrorMessageDescription .! !

!StoreTest methodsFor: 'tests' stamp: 'MS 6/23/2021 11:31:32'!
test10CheckingOutWithNonExistentIdShouldRaiseAnError
	
	| store cardNumber cardExpiration cardName |
		
	store := self createStoreWithDefaultCatalog.
	
	cardNumber := 1111222233334444. 
	
	cardExpiration := testObjectFactory nextYear.
	
	cardName := 'Matias'.
		
	self should: [ store checkOut: 5 forCco: cardName withCcn: cardNumber expiringOn: cardExpiration ] 
	 	raise: Error - MessageNotUnderstood 
		withMessageText: Store invalidCartIdErrorMessageDescription.! !

!StoreTest methodsFor: 'tests' stamp: 'GDH 6/23/2021 18:41:18'!
test11CheckingOutSuccesfullyShouldReturnDifferentTransactionsId
	
	| store transactionId1 cartId1 isbn transactionId2 cartId2 |
		
	store := self createStoreWithDefaultCatalog.
	authenticateBehaviour := [ :aClientId :aClientPassword | true ].
	debitBehavior := [ :anAmount :aCreditCard | ].
	
	cartId1 := store createCartFor: 'validUserId' using: 'validPassword' .
	cartId2 := store createCartFor: 'validUserId' using: 'validPassword' .
	
	isbn := testObjectFactory defaultCatalog keys first .
	
	store add: 1 of: isbn to: cartId1.
	store add: 1 of: isbn to: cartId2.
				
	transactionId1 := store checkOut: cartId1 
					  forCco: 'Matias' 
					  withCcn: 1111222233334444 
					  expiringOn: testObjectFactory nextYear.
	
	transactionId2 := store checkOut: cartId2 
					  forCco: 'Matias' 
					  withCcn: 1111222233334444 
					  expiringOn: testObjectFactory nextYear.
					
	self deny: transactionId1 = transactionId2.
					
		
	! !

!StoreTest methodsFor: 'tests' stamp: 'GDH 6/23/2021 20:51:36'!
test12CheckingOutAndListingPurchasesShouldReturnListOfSales
	
	| store cartId isbn clientId clientPassword expectedSales clientSales |
			
	store := self createStoreWithDefaultCatalog.
	authenticateBehaviour := [ :aClientId :aClientPassword | true ].
	debitBehavior := [ :anAmount :aCreditCard | ].
	
	clientId := 'validUserId'.
	clientPassword := 'validPassword'.
	cartId := store createCartFor: clientId using: clientPassword .
	
	isbn := testObjectFactory defaultCatalog keys first .
	
	store add: 1 of: isbn to: cartId.
	
	expectedSales := (store listCart: cartId) -> testObjectFactory itemSellByTheStorePrice .
				
	store checkOut: cartId 
			forCco: 'Matias' 
			withCcn: 1111222233334444 
			expiringOn: testObjectFactory nextYear.
	
	clientSales := store purchasesListOf: clientId using: clientPassword.
	
	self assert: clientSales = expectedSales .! !

!StoreTest methodsFor: 'tests' stamp: 'GDH 6/23/2021 20:56:50'!
test13ListingPurchasesWithInvalidCredentialsShouldRaiseAnError
	
	| store |
			
	store := self createStoreWithDefaultCatalog.
	authenticateBehaviour := [ :aClientId :aClientPassword | false ].
	
	self should: [ store purchasesListOf: 'validClientId' using: 'invalidPassword']
		 raise: Error - MessageNotUnderstood 
		 withMessageText: Store invalidCredentialsErrorMessageDescription ! !

!StoreTest methodsFor: 'tests' stamp: 'GDH 6/23/2021 21:00:15'!
test14ListingPurchasesOfClientWithoutPurchasesShouldRaiseAnError
	
	| store |
			
	store := self createStoreWithDefaultCatalog.
	authenticateBehaviour := [ :aClientId :aClientPassword | true ].
	
	self should: [ store purchasesListOf: 'validClientId' using: 'validPassword']
		 raise: Error - MessageNotUnderstood 
		 withMessageText: Store clientWithoutPurchasesErrorMessageDescription ! !

!StoreTest methodsFor: 'tests' stamp: 'GDH 6/23/2021 21:42:10'!
test15ListingPurchasesOfDifferentClientsShouldReturnDifferentListsOfSales
	
	| store cartId1 cartId2 client1Sales client2Sales client1 client2 client1Password client2Password isbn |
		
	store := self createStoreWithDefaultCatalog.
	authenticateBehaviour := [ :aClientId :aClientPassword | true ].
	debitBehavior := [ :anAmount :aCreditCard | ].
	
	client1 := 'validUserId1'.
	client2 := 'validUserId2'.
	client1Password :=  'validPassword1'.
	client2Password :=  'validPassword2'.
		
	cartId1 := store createCartFor: client1 using: client1Password .
	cartId2 := store createCartFor: client2 using: client2Password .
	
	isbn := testObjectFactory defaultCatalog keys first .
	
	store add: 1 of: isbn to: cartId1.
	store add: 2 of: isbn to: cartId2.
				
	store checkOut: cartId1 
			forCco: 'Matias' 
			withCcn: 1111222233334444 
			expiringOn: testObjectFactory nextYear.
	
	store checkOut: cartId2 
			forCco: 'Matias' 
			withCcn: 1111222233334444 
			expiringOn: testObjectFactory nextYear.
			
	client1Sales := store purchasesListOf: client1 using: client1Password .
	client2Sales := store purchasesListOf: client2 using: client2Password .	
	
	self deny: client1Sales = client2Sales .
	! !

!StoreTest methodsFor: 'tests' stamp: 'GDH 6/24/2021 01:34:03'!
test16AddingToCartAfterThirtyMinsOfCreationShouldRaiseAnError
	
	| store cartId isbn advanceableClock |
	
	advanceableClock := testObjectFactory todayClockAdvanceable .
	store := self createStoreWithDefaultCatalogWithClock:  advanceableClock .
	authenticateBehaviour := [ :aClientId :aClientPassword | true ].
		
	cartId := store createCartFor: 'validUserId' using: 'validPassword' .
	
	isbn := testObjectFactory defaultCatalog keys first .
	
	advanceableClock advanceByMinutes: 30.
	
	self should: [ store add: 1 of: isbn to: cartId ]
		 raise: Error - MessageNotUnderstood 
		 withMessageText: Store cartExpiredErrorMessageDescription.
	! !

!StoreTest methodsFor: 'tests' stamp: 'GDH 6/24/2021 01:40:01'!
test17CheckoutCartAfterThirtyMinsOfLastUsageShouldRaiseAnError
	
	| store cartId isbn advanceableClock |
	
	advanceableClock := testObjectFactory todayClockAdvanceable .
	store := self createStoreWithDefaultCatalogWithClock:  advanceableClock .
	authenticateBehaviour := [ :aClientId :aClientPassword | true ].
		
	cartId := store createCartFor: 'validUserId' using: 'validPassword' .
	
	isbn := testObjectFactory defaultCatalog keys first .
	
	store add: 1 of: isbn to: cartId.
	
	advanceableClock advanceByMinutes: 30.
	
	self should: [ store checkOut: cartId forCco: 'Matias' withCcn: '1122334455667788' expiringOn: testObjectFactory nextYear ]
		 raise: Error - MessageNotUnderstood 
		 withMessageText: Store cartExpiredErrorMessageDescription.
	! !

!StoreTest methodsFor: 'tests' stamp: 'GDH 6/24/2021 01:40:08'!
test18ListingACartAfterThirtyMinsOfLastUsageShouldRaiseAnError
	
	| store cartId advanceableClock |
	
	advanceableClock := testObjectFactory todayClockAdvanceable .
	store := self createStoreWithDefaultCatalogWithClock:  advanceableClock .
	authenticateBehaviour := [ :aClientId :aClientPassword | true ].
		
	cartId := store createCartFor: 'validUserId' using: 'validPassword' .
				
	advanceableClock advanceByMinutes: 30.
	
	self should: [ store listCart: cartId ]
		 raise: Error - MessageNotUnderstood 
		 withMessageText: Store cartExpiredErrorMessageDescription.
	! !


!StoreTest methodsFor: 'creation' stamp: 'GDH 6/24/2021 01:33:05'!
createStoreWithBigCatalog

	^Store openStoreOn: testObjectFactory todayClockAdvanceable 
			authenticatingWith: self 
			processingThrough: self 
			acceptingItemsFrom: testObjectFactory bigCatalog .! !

!StoreTest methodsFor: 'creation' stamp: 'GDH 6/24/2021 01:33:12'!
createStoreWithDefaultCatalog

	^Store openStoreOn: testObjectFactory todayClockAdvanceable 
			authenticatingWith: self 
			processingThrough: self 
			acceptingItemsFrom: testObjectFactory defaultCatalog .! !

!StoreTest methodsFor: 'creation' stamp: 'GDH 6/24/2021 01:33:48'!
createStoreWithDefaultCatalogWithClock: aClock

	^Store openStoreOn: aClock 
			authenticatingWith: self 
			processingThrough: self 
			acceptingItemsFrom: testObjectFactory defaultCatalog .! !


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


!Cart methodsFor: 'accessing' stamp: 'MS 6/21/2021 19:29:58'!
items

	^items.! !


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

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


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

!Cashier methodsFor: 'checkout - private' stamp: 'GDH 6/23/2021 20:28:06'!
createSale

	^ Sale of: cart costing: total
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


!classDefinition: #Clock category: 'TusLibros'!
Object subclass: #Clock
	instanceVariableNames: 'dateAndTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'time' stamp: 'GDH 6/24/2021 01:23:59'!
now
	
	^DateAndTime now. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Clock class' category: 'TusLibros'!
Clock class
	instanceVariableNames: 'dateAndTime'!


!classDefinition: #AdvanceableClock category: 'TusLibros'!
Clock subclass: #AdvanceableClock
	instanceVariableNames: 'minutesToAdvance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!AdvanceableClock methodsFor: 'advance' stamp: 'GDH 6/24/2021 01:04:53'!
advanceByMinutes: aMinutesAmount
	
	minutesToAdvance := minutesToAdvance + aMinutesAmount .! !


!AdvanceableClock methodsFor: 'initialization' stamp: 'GDH 6/24/2021 01:04:32'!
initializeFor: aDateAndTime
	
	minutesToAdvance := 0.
	dateAndTime := aDateAndTime .! !


!AdvanceableClock methodsFor: 'time' stamp: 'GDH 6/24/2021 01:04:41'!
now
	
	^dateAndTime + ( Duration minutes: minutesToAdvance ).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AdvanceableClock class' category: 'TusLibros'!
AdvanceableClock class
	instanceVariableNames: 'minutesToAdvance'!

!AdvanceableClock class methodsFor: 'instance creation' stamp: 'GDH 6/24/2021 01:34:38'!
from: aDateAndTime
	
	^self new initializeFor: aDateAndTime.! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'MS 6/23/2021 11:16:00'!
initializeExpiringOn: aMonth withCcn: aCreditCardNumber withCco: aCreditCardName   
	
	expiration := aMonth.
	number := aCreditCardNumber.
	name := aCreditCardName.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'MS 6/23/2021 11:18:37'!
expiringOn: aMonth withCcn: aCreditCardNumber withCco: aCreditCardName   
	
	self assertCardNumberLengthEquals16: aCreditCardNumber.
	
	self assertCardNameIsNotEmpty: aCreditCardName.
	
	^self new initializeExpiringOn: aMonth withCcn: aCreditCardNumber withCco: aCreditCardName.! !


!CreditCard class methodsFor: 'assertions' stamp: 'MS 6/23/2021 11:18:22'!
assertCardNameIsNotEmpty: aCreditCardName
	
	aCreditCardName isEmpty ifTrue: [ self error: self invalidCardNameErrorMessageDescription ].
	! !

!CreditCard class methodsFor: 'assertions' stamp: 'MS 6/23/2021 11:17:07'!
assertCardNumberLengthEquals16: aCreditCardNumber

	(aCreditCardNumber numberOfDigitsInBase: 10) = 16 ifFalse: [ self error: self invalidCardLengthErrorMessageDescription ].
	! !


!CreditCard class methodsFor: 'exceptions' stamp: 'MS 6/21/2021 21:06:40'!
invalidCardLengthErrorMessageDescription

	^'Invalid Credit Card length'.! !

!CreditCard class methodsFor: 'exceptions' stamp: 'MS 6/23/2021 11:08:15'!
invalidCardNameErrorMessageDescription
	^'Invalid card Name'! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'items' stamp: 'GDH 6/23/2021 20:35:52'!
items
	
	^cart items ! !


!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'GDH 6/23/2021 20:35:34'!
initializeTotal: aTotal andCart: aCart

	total := aTotal.
	cart := aCart.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'GDH 6/23/2021 20:27:49'!
of: aCart costing: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal andCart: aCart ! !


!classDefinition: #Store category: 'TusLibros'!
Object subclass: #Store
	instanceVariableNames: 'authenticator nextCartId catalog cartsById merchantProcessor clock nextTransactionId clientByCartId salesByClientId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Store methodsFor: 'creation' stamp: 'GDH 6/24/2021 01:18:59'!
createCartFor: aClientId using: aPassword 

	| cartId cartWithCreationTime |

	self assertAuthenticationFor: aClientId using: aPassword.
	
	cartId := self getNextTransactionId .
	
	cartWithCreationTime := (Cart acceptingItemsOf: catalog) -> clock now.
	cartsById add: cartId -> cartWithCreationTime.
	
	clientByCartId at: cartId put: aClientId .
	
	^cartId.
	
	! !

!Store methodsFor: 'creation' stamp: 'GDH 6/23/2021 23:07:03'!
getNextCartId
	
	| cartId |
	
	cartId := nextCartId.
	nextCartId := nextCartId + 1.
	
	^cartId.
	
	! !


!Store methodsFor: 'initialization' stamp: 'GDH 6/24/2021 01:17:27'!
initializeAuthenticatingWith: anAuthenticator processingThrough: aMerchantProcessor acceptingItemsFrom: aCatalog on: aClock .

	nextCartId := 1.
	nextTransactionId := 1.
	cartsById := Dictionary new.
	clientByCartId := Dictionary new.
	salesByClientId := Dictionary new.
	
	authenticator := anAuthenticator.
	merchantProcessor := aMerchantProcessor.
	catalog := aCatalog.
	clock := aClock.! !


!Store methodsFor: 'accessing' stamp: 'GDH 6/24/2021 00:23:32'!
listCart: aCartId 

	^(self cartFor: aCartId) items.! !

!Store methodsFor: 'accessing' stamp: 'GDH 6/23/2021 23:05:30'!
purchasesListOf: aClientId using: aClientPassword

	| sales |

	self assertAuthenticationFor: aClientId using: aClientId.
	self assertSalesOfClientExistAndAreNotEmpty: aClientId .
	
	sales := salesByClientId at: aClientId.
	
	^ (self itemsSoldOf: sales) -> (self totalAmountOf: sales)! !


!Store methodsFor: 'accessing - private' stamp: 'GDH 6/24/2021 01:17:14'!
cartFor: aCartId 
	
	| cartWithLastUpdateTime |
	
	cartWithLastUpdateTime := cartsById at: aCartId ifAbsent: [ self error: self class invalidCartIdErrorMessageDescription ].
	
	self assertTimeElapsedHasNotExceededMaximum: cartWithLastUpdateTime value.
	
	cartWithLastUpdateTime := cartWithLastUpdateTime key -> clock now.
	
	cartsById at: aCartId put: cartWithLastUpdateTime.
	
	^cartWithLastUpdateTime key
	
	
	
	
! !

!Store methodsFor: 'accessing - private' stamp: 'GDH 6/23/2021 22:30:33'!
getNextTransactionId
	
	| transactionId |
	
	transactionId := nextTransactionId .
	nextTransactionId := nextTransactionId + 1 .
	
	^transactionId.
			

	! !

!Store methodsFor: 'accessing - private' stamp: 'GDH 6/23/2021 23:02:42'!
itemsSoldOf: aSalesCollection
	
	^( aSalesCollection collect: [ :aSale | aSale items ] ) flatten! !

!Store methodsFor: 'accessing - private' stamp: 'GDH 6/23/2021 23:04:41'!
totalAmountOf: aSalesCollection

	^( aSalesCollection collect: [ :aSale | aSale total ] ) sum ! !


!Store methodsFor: 'assertions' stamp: 'MS 6/21/2021 20:11:11'!
assertAuthenticationFor: aClientId using: aPassword 

	(authenticator authenticate: aClientId with: aPassword) ifFalse: [ self error: self class invalidCredentialsErrorMessageDescription ].
	
	! !

!Store methodsFor: 'assertions' stamp: 'GDH 6/23/2021 22:53:08'!
assertSalesOfClientExistAndAreNotEmpty: aClientId
	
	| sales |
	
	sales := salesByClientId at: aClientId ifAbsent: [ self error: self class clientWithoutPurchasesErrorMessageDescription ].
	
	sales ifEmpty: [ self error: self class clientWithoutPurchasesErrorMessageDescription ].! !

!Store methodsFor: 'assertions' stamp: 'GDH 6/24/2021 01:19:31'!
assertTimeElapsedHasNotExceededMaximum: aCreationDateAndTime.
	
	clock now - (Duration minutes: 30) < aCreationDateAndTime ifFalse: [ ^self error: self class cartExpiredErrorMessageDescription ].
	
	
	
	
! !


!Store methodsFor: 'adding' stamp: 'GDH 6/24/2021 00:23:13'!
add: aQuantity of: anIsbn to: aCartId 

	| cart |
	
	cart := (self cartFor: aCartId).
	
	cart add: aQuantity of: anIsbn.
	! !


!Store methodsFor: 'checkout - private' stamp: 'GDH 6/23/2021 22:38:43'!
salesOfClientAssociatedWith: aCartId
	
	| clientId |
	
	clientId := clientByCartId at: aCartId .
	
	^salesByClientId at: clientId ifAbsentPut: [ OrderedCollection new ]. 
	

	! !


!Store methodsFor: 'checkout' stamp: 'GDH 6/24/2021 01:19:59'!
checkOut: aCartId forCco: aCreditCardOwner withCcn: aCreditCardNumber expiringOn: aCreditCardExpirationMonthOfYear 
	
	| cart creditCard cashier |
	
	cart := self cartFor: aCartId.

	creditCard := CreditCard expiringOn: aCreditCardExpirationMonthOfYear withCcn: aCreditCardNumber withCco: aCreditCardOwner.	
	 
	cashier := Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: merchantProcessor
		on: clock now
		registeringOn: (self salesOfClientAssociatedWith: aCartId ).
		
	cashier checkOut.
	
	^self getNextTransactionId .
			

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Store class' category: 'TusLibros'!
Store class
	instanceVariableNames: ''!

!Store class methodsFor: 'exceptions' stamp: 'GDH 6/23/2021 20:59:50'!
clientWithoutPurchasesErrorMessageDescription
	^'Client has no purchases in the store'! !

!Store class methodsFor: 'exceptions' stamp: 'MS 6/21/2021 20:05:00'!
invalidCartIdErrorMessageDescription
	^'Invalid Cart Id'! !

!Store class methodsFor: 'exceptions' stamp: 'MS 6/21/2021 17:44:08'!
invalidCredentialsErrorMessageDescription
	^'Credenciales Invalidas'.! !


!Store class methodsFor: 'instance creation' stamp: 'GDH 6/23/2021 19:06:01'!
openStoreOn: aDateAndTime authenticatingWith: anAuthenticator processingThrough: aMerchantProcessor acceptingItemsFrom:  aCatalog

	^Store new initializeAuthenticatingWith: anAuthenticator processingThrough: aMerchantProcessor acceptingItemsFrom: aCatalog on: aDateAndTime.! !


!Store class methodsFor: 'as yet unclassified' stamp: 'GDH 6/23/2021 23:25:20'!
cartExpiredErrorMessageDescription
	
	^'The cart has expired after 30 mins of no usage'! !


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

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'GDH 6/23/2021 20:40:15'!
secondItemSellByTheStorePrice
	
	^20! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'GDH 6/23/2021 20:40:26'!
bigCatalog
	
	^ Dictionary new
		add: 'libro1'->1;
		add: 'libro2'->2;
		yourself ! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'MS 6/21/2021 19:17:47'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'MS 6/23/2021 11:10:06'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1) withCcn: self validCreditCardNumber withCco: 'Matias'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'MS 6/23/2021 11:10:06'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1) withCcn: self validCreditCardNumber withCco: 'Matias'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'MS 6/21/2021 20:59:53'!
validCreditCardNumber

	^1111222233334444! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'MS 6/21/2021 20:40:04'!
nextYear
	
	^Month month: today monthIndex year: today yearNumber + 1.! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'GDH 6/24/2021 01:34:38'!
todayClock
	
	^ Clock from: today.! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'GDH 6/24/2021 01:34:38'!
todayClockAdvanceable
	
	^ AdvanceableClock from: today.! !
