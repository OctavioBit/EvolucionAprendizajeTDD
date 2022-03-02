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
	instanceVariableNames: 'validClientIds validPasswords invalidClientId anotherValidClientId anotherValidPassword validClientId validPassword clientPasswordData objectFactory catalog debitBehavior now anItem anotherItem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTest methodsFor: 'messages' stamp: 'sc 6/24/2021 00:49:59'!
setUp
	objectFactory _ StoreTestObjectsFactory new.
	anItem _ objectFactory itemSellByTheStore.
	anotherItem _ objectFactory  anotherItemSellByTheStore.
	catalog _ objectFactory defaultCatalog. 
	invalidClientId _ 'enzo vigneti'.
	validClientId _ 'santiagoCorley'.
	anotherValidClientId _'santiagoCorleyCuentaBackUp'.
	validPassword _ '1234abcde'.
	anotherValidPassword _ 'abcde1234'.
	debitBehavior := [ :anAmount :aCreditCard | ].
	now _ DateAndTime now.
	
	
	
	! !

!StoreTest methodsFor: 'messages' stamp: 'sc 6/24/2021 00:42:16'!
test00canCreateACartWithValidCredentials
	|store cartId|
	store _ objectFactory createStore: self.
	cartId _ store createNewCartWith: validClientId  and: validPassword onTime: (now).
	self assert: (store listCart: cartId onTime:  now) isEmpty.
	
	
	
	
	
	
	
	! !

!StoreTest methodsFor: 'messages' stamp: 'sc 6/24/2021 00:42:42'!
test01cantCreateACartWithInvalidPassword
	|store|
	store _ objectFactory createStore: self.
	self should: [store createNewCartWith: validClientId  and: validPassword, 'basura para arruinar la contraseña' onTime: now]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError|self assert: (anError messageText) equals: (Store invalidCredentialsErrorMessage)].
	
	
	
	
	! !

!StoreTest methodsFor: 'messages' stamp: 'sc 6/24/2021 00:42:47'!
test02cantCreateACartWithInvalidUser
	|store|
	store _ objectFactory createStore: self.
	self should: [store createNewCartWith: invalidClientId  and: validPassword onTime: (now)]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError|self assert: (anError messageText) equals: (Store invalidCredentialsErrorMessage)].
	
	
	
	
	! !

!StoreTest methodsFor: 'messages' stamp: 'sc 6/24/2021 00:42:51'!
test03canCreateACartWithMultipleValidUsers
	|store cartId|
	store _ objectFactory createStore: self.
	cartId _ store createNewCartWith: anotherValidClientId and: anotherValidPassword onTime: (now).
	self assert: (store listCart: cartId onTime: now) isEmpty .
	
	
	
	
	! !

!StoreTest methodsFor: 'messages' stamp: 'sc 6/24/2021 00:42:56'!
test04cantCreateACartWithValidUserAndAnotherDifferentValidUserPassword
	|store cartId|
	store _ objectFactory createStore: self.
	self should: [cartId _ store createNewCartWith: anotherValidClientId and:validPassword onTime: (now) .]
	raise: Error withExceptionDo:[:anErrorMessage| self assert: (Store invalidCredentialsErrorMessage) 
										equals: (anErrorMessage messageText) ].
	
	
	
	
	! !

!StoreTest methodsFor: 'messages' stamp: 'sc 6/24/2021 00:43:03'!
test05WhenCreatingTwoDifferentCartsTheyHaveDifferentIds
	|store cartId anotherCartsId|
	store _ objectFactory createStore: self.
	cartId  _ store createNewCartWith: validClientId and: validPassword onTime: (now).
	anotherCartsId _ store createNewCartWith: validClientId and: validPassword onTime: (now).
	self assert: (cartId  ~= anotherCartsId).
	
	
	
	
	
	
	! !

!StoreTest methodsFor: 'messages' stamp: 'sc 6/24/2021 00:50:22'!
test06addingElementToCartIsReflectedWhenListingCart
	|store aCartId |
	store _ objectFactory createStore: self.
	aCartId  _ store createNewCartWith: validClientId and: validPassword onTime: (now).
	store addToCart: aCartId  aBook: anItem  withAmount: 1 onTime: now.
	self assert: (store listCart: aCartId onTime: now) equals: (OrderedCollection with: anItem with: 1).
	
	
	
	
	
	
	! !

!StoreTest methodsFor: 'messages' stamp: 'sc 6/24/2021 00:51:26'!
test07addingTwoElementToCartIsReflectedWhenListingCart
	|store aCartId|
	store _ objectFactory createStore: self.
	aCartId  _ store createNewCartWith: validClientId and: validPassword onTime: (now).
	
	store addToCart: aCartId  aBook: anItem  withAmount: 1 onTime: now.
	store addToCart: aCartId  aBook: anotherItem  withAmount: 1 onTime: now.
	
	self assert: (store listCart: aCartId onTime: now) equals: (OrderedCollection with: anItem with: 1 with: anotherItem with: 1).	
	
	
	
	
	! !

!StoreTest methodsFor: 'messages' stamp: 'sc 6/24/2021 00:52:05'!
test08canAddItemsToDifferentCarts
	|store aCartId anotherCartId |
	store _ objectFactory createStore: self.
	aCartId  _ store createNewCartWith: validClientId and: validPassword onTime: (now).
	anotherCartId _ store createNewCartWith: validClientId and: validPassword onTime: (now).
	
	store addToCart: aCartId  aBook: anItem  withAmount: 1 onTime: now.
	store addToCart: anotherCartId  aBook: anItem  withAmount: 10 onTime: now.
	
	self assert: (store listCart: aCartId onTime:now) equals: (OrderedCollection with: anItem with: 1).
	self assert: (store listCart: anotherCartId onTime: now) equals: (OrderedCollection with: anItem with: 10).
	
	
	
	
	
	
	! !

!StoreTest methodsFor: 'messages' stamp: 'sc 6/24/2021 00:43:33'!
test09listingPurchasingOfClientWithValidCredentialsWithoutPurchasesReturnsEmptyCollection
	|store clientPurchases|
	store _ objectFactory createStore: self.
	store createNewCartWith: validClientId and: validPassword onTime: (now).
	clientPurchases _ store listPurchasesOf: validClientId withPassword: validPassword.
	self assert:  clientPurchases  equals: (OrderedCollection with: 0).
	
	
	
	
	
	
	! !

!StoreTest methodsFor: 'messages' stamp: 'sc 6/24/2021 00:43:38'!
test10listingPurchasingOfInvalidClientRaisesError
	|store |
	store _ objectFactory createStore: self.
	self should: [store listPurchasesOf: invalidClientId withPassword: 'irrelevant password']
	raise: Error
	withExceptionDo: [:anError| self assert: anError messageText equals: Store invalidCredentialsErrorMessage] 
	
	
	
	
	
	
	! !

!StoreTest methodsFor: 'messages' stamp: 'sc 6/24/2021 00:43:44'!
test11listingPurchasingOfValidClientWithInvalidPasswordRaisesError
	|store |
	store _ objectFactory createStore: self.
	self should: [store listPurchasesOf: validClientId withPassword: validPassword, 'garbage meant to ruin password']
	raise: Error
	withExceptionDo: [:anError| self assert: anError messageText equals: Store invalidCredentialsErrorMessage] 
	
	
	
	
	
	
	! !

!StoreTest methodsFor: 'messages' stamp: 'sc 6/24/2021 00:52:28'!
test12listingPurchasingOfClientWithASinglePurchaseContainsIt
	|store cartId aCreditCard|
	store _ objectFactory createStore: self.
	cartId _ store createNewCartWith: validClientId and: validPassword onTime: (now).	
	aCreditCard _ objectFactory notExpiredCreditCard.
	
	store addToCart: cartId aBook:  anItem withAmount: 1 onTime: now.
	store checkOut:cartId  withCard: aCreditCard onTime: now.
	self assert: (store listPurchasesOf: validClientId withPassword: validPassword)
	 equals: (OrderedCollection with: anItem with: 1 with: (catalog at: anItem) ).
	
	
	
	
	
	
	
	! !

!StoreTest methodsFor: 'messages' stamp: 'sc 6/24/2021 00:58:18'!
test13listingPurchasingOfClientWithMultiplePurchasesInSameCartContainsIt
	|store cartId aCreditCard expectedPurchases|
	store _ objectFactory createStore: self.
	cartId _ store createNewCartWith: validClientId and: validPassword onTime: (now).	
	aCreditCard _ objectFactory notExpiredCreditCard.
	
	store addToCart: cartId aBook:  anItem withAmount: 1 onTime: now.
	store addToCart: cartId aBook:  anotherItem withAmount: 1 onTime: now.
	
	store checkOut:cartId  withCard: aCreditCard onTime: now.
	expectedPurchases _ OrderedCollection with: anItem with: 1.
	expectedPurchases add: anotherItem; add: 1; add: ( (catalog at: anItem) +  (catalog at: anotherItem)).
	self assert: (store listPurchasesOf: validClientId withPassword: validPassword)
	 equals: (expectedPurchases ).
	
	
	
	
	
	
	
	! !

!StoreTest methodsFor: 'messages' stamp: 'sc 6/24/2021 00:53:59'!
test14listingPurchasingOfTwoClientsWithOnePurchaseEachWorksProperly
	|store cartId anotherCartId aCreditCard|
	store _ objectFactory createStore: self.
	aCreditCard _ objectFactory notExpiredCreditCard.
	cartId _ store createNewCartWith: validClientId and: validPassword onTime: (now).	
	anotherCartId _ store createNewCartWith: anotherValidClientId and: anotherValidPassword onTime: (now) .
	
	store addToCart: cartId aBook:  anItem withAmount: 1 onTime: now.
	store addToCart: anotherCartId aBook:  anotherItem withAmount: 1 onTime: now.
	store checkOut: cartId withCard: aCreditCard onTime: now.
	store checkOut: anotherCartId withCard: aCreditCard onTime: now.
	
	self assert: (store listPurchasesOf: validClientId withPassword: validPassword)
	 equals: (OrderedCollection with: anItem with:1 with: (catalog at: anItem)).
	
	self assert: (store listPurchasesOf: anotherValidClientId withPassword: anotherValidPassword)
	 equals: (OrderedCollection with: anotherItem with:1 with: (catalog at: anotherItem)).
	
	
	
	
	
	
	
	! !

!StoreTest methodsFor: 'messages' stamp: 'sc 6/24/2021 00:54:20'!
test15ListingACartIdOfARecentlyCheckedOutCartProvidesEmptyList
	|store aCartId aCreditCard|
	store _ objectFactory createStore: self.
	aCartId  _ store createNewCartWith:validClientId  and: validPassword onTime: (now).
	aCreditCard  _ objectFactory notExpiredCreditCard.
	
	store addToCart: aCartId aBook: anItem  withAmount: 1 onTime: now.
	store checkOut: aCartId withCard: aCreditCard onTime: now.
	self assert: (store listCart: aCartId onTime: now) isEmpty .
	
	
	
	
	
	
	! !

!StoreTest methodsFor: 'messages' stamp: 'sc 6/24/2021 00:54:37'!
test16CheckingOutWithAnExpiredCreditCardRaisesError
	|store aCartId aCreditCard|
	store _ objectFactory createStore: self.
	aCartId  _ store createNewCartWith:validClientId  and: validPassword onTime: (now).
	aCreditCard  _ objectFactory expiredCreditCard.
	
	store addToCart: aCartId aBook: anItem  withAmount: 1 onTime: now.
	self should: [store checkOut: aCartId withCard: aCreditCard onTime: now.]
	raise: Error
	withExceptionDo:
	[:anError| self assert: anError messageText  equals: Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: (store listCart: aCartId onTime: now) equals: (OrderedCollection with: anItem with:1)].
	
	
	
	
	
	
	
	! !

!StoreTest methodsFor: 'messages' stamp: 'sc 6/24/2021 00:44:16'!
test17aStoreWithoutSalesHasZeroRegisteredSales
	|store |
	store _ objectFactory createStore: self.
	self assert: store registeredSalesAmount equals: 0.
	self deny: (store hasRegisteredSaleFor: 1)
	
	
	
	
	
	
	! !

!StoreTest methodsFor: 'messages' stamp: 'sc 6/24/2021 00:54:53'!
test18aCheckOutOfACartWithAnItemIsReflectedInSalesBook
	|store cartId  aCreditCard |
	store _ objectFactory createStore: self.
	cartId _ store createNewCartWith: validClientId and: validPassword onTime: (now).
	aCreditCard _ objectFactory notExpiredCreditCard .
	
	store addToCart: cartId aBook:  anItem withAmount: 1 onTime: now.
	store checkOut: cartId withCard:  aCreditCard onTime: now.
	self assert: (store hasRegisteredSaleFor: (catalog at: anItem)).
	self assert: store registeredSalesAmount equals: 1.
	
	
	
	
	
	
	! !

!StoreTest methodsFor: 'messages' stamp: 'sc 6/24/2021 01:06:32'!
test19CreatedCartCantListCartAfter30minutesUnused
	
	self whenExecutingAfter30MinutesOnACartExpectError:[
		:cartId :aTimeStamp :store| store listCart: cartId onTime: aTimeStamp]
	
	
	
	
	! !

!StoreTest methodsFor: 'messages' stamp: 'sc 6/24/2021 01:08:25'!
test20CreatedCartCantAddAnythingAfter30minutesUnused
	self whenExecutingAfter30MinutesOnACartExpectError:[
		:cartId :aTimeStamp :store| store addToCart: cartId  aBook: anItem withAmount: 1 onTime: aTimeStamp]
	
	
	
	
	
	! !

!StoreTest methodsFor: 'messages' stamp: 'sc 6/24/2021 01:11:44'!
test21CreatedCartCantCheckOutAfter30minutesUnused
	|creditCard|
	self whenExecutingAfter30MinutesOnACartExpectError:[:cartId :aTimeStamp :store|
		store addToCart: cartId  aBook: anItem withAmount: 1 onTime: now. 
		creditCard _ objectFactory notExpiredCreditCard.
		store checkOut: cartId withCard:creditCard onTime: aTimeStamp].

	
	
	
	
	
	! !

!StoreTest methodsFor: 'messages' stamp: 'sc 6/24/2021 01:01:00'!
test22CartClockResetsWhenOperatingWithIt
	|store cartId aTimeStamp anEarlierTimeStamp|
	store _ objectFactory createStore: self.
	cartId  _ store createNewCartWith: validClientId and: validPassword onTime: (now).	
	aTimeStamp _ now  + 40 minutes	.
	anEarlierTimeStamp _ now + 25 minutes.
	
	self assert: (store listCart: cartId onTime: anEarlierTimeStamp) isEmpty.
	self assert:  (store listCart: cartId onTime: aTimeStamp) isEmpty.
	
	
	
	
	
	
	
	! !


!StoreTest methodsFor: 'simulator' stamp: 'sc 6/23/2021 23:08:18'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!StoreTest methodsFor: 'time assertions' stamp: 'sc 6/24/2021 01:07:44'!
whenExecutingAfter30MinutesOnACartExpectError: aClosure 
	|store cartId aTimeStamp|
	store _ objectFactory createStore: self.
	cartId  _ store createNewCartWith: validClientId and: validPassword onTime: (now).
	
	aTimeStamp _ now  + 30 minutes	.
	self should: [aClosure value: cartId value: aTimeStamp value: store]
	raise: Error
	withExceptionDo:
	[:anError| self assert: anError messageText  equals: Cart canNotOperateWhenUnusedFor30Min].! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items client lastUseTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !

!Cart methodsFor: 'error messages' stamp: 'sc 6/24/2021 00:34:21'!
raiseErrorIfUnusedFor30minutes: timeStamp. 
	(timeStamp - lastUseTime ) > 29 minutes ifTrue: [self error: self class canNotOperateWhenUnusedFor30Min]
	ifFalse:[lastUseTime _ timeStamp].
	! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'sc 6/23/2021 23:54:19'!
initializeAcceptingItemsOf: aCatalog forClient: aClientId onTime: aTimeStamp.

	catalog := aCatalog.
	items := OrderedCollection new.
	client _ aClientId.
	lastUseTime _ aTimeStamp .! !


!Cart methodsFor: 'queries' stamp: 'sc 6/23/2021 22:38:22'!
discardItems
	items _ OrderedCollection new.! !

!Cart methodsFor: 'queries' stamp: 'sc 6/23/2021 18:24:26'!
list
    |listedElements|
    listedElements _ OrderedCollection new.
    items do: [:aBook| self addWithOcurrencesIfFirstAparition: aBook into: listedElements].
    ^listedElements.
  ! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'sc 6/23/2021 21:01:16'!
registerPurchaseOn: aStore
	aStore addTotal: self total fromUser: client. 
	aStore addPurchase: self list fromUser: client.! !


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


!Cart methodsFor: 'private' stamp: 'sc 6/23/2021 18:25:26'!
addWithOcurrencesIfFirstAparition: aBook into: listedElements
	(listedElements includes: aBook) ifFalse:
                        [listedElements add: aBook. 
                        listedElements add: (items occurrencesOf: aBook) ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'errorMessages' stamp: 'sc 6/24/2021 00:02:47'!
canNotOperateWhenUnusedFor30Min
	^'Si no me tocas en 30 min no esperes que te esté esperando amigo, no soy como vos con tu ex'! !


!Cart class methodsFor: 'instance creation' stamp: 'sc 6/23/2021 23:53:40'!
acceptingItemsOf: aCatalog forClient: aClientId onTime: aTimeStamp  

	^self new initializeAcceptingItemsOf: aCatalog forClient: aClientId onTime: aTimeStamp.! !


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

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
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
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #Store category: 'TusLibros'!
Object subclass: #Store
	instanceVariableNames: 'clientsCredentialData lastIdAssigned carts catalog purchasesListByClient moneySpentByClient salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Store methodsFor: 'cartCreation' stamp: 'sc 6/23/2021 23:56:14'!
createNewCartWith: aClientId and: aPassword onTime: aTimeStamp  
	self raiseInvalidCredentialsError: aClientId andWith: aPassword.
	carts add: (Cart acceptingItemsOf: catalog forClient: aClientId onTime: aTimeStamp ).
	lastIdAssigned _ lastIdAssigned+1 .
	^lastIdAssigned .
	! !


!Store methodsFor: 'initialization' stamp: 'sc 6/23/2021 23:22:56'!
initializeWithClientDatabase: clientData withCatalog: aCatalog withMerchantProcessor: aMerchantProcessor   .
	clientsCredentialData _ clientData.
	lastIdAssigned _ 0.
	catalog _ aCatalog.
	salesBook _ OrderedCollection new.
	carts _ OrderedCollection new.
	purchasesListByClient _ Dictionary new.
	moneySpentByClient _ Dictionary new.
	merchantProcessor _ aMerchantProcessor.! !


!Store methodsFor: 'operations' stamp: 'sc 6/23/2021 23:22:56'!
addPurchase:aPurchaseList fromUser: aUserId
	(purchasesListByClient includesKey: aUserId) ifFalse:[purchasesListByClient at: aUserId put: OrderedCollection new].
	(purchasesListByClient at: aUserId) addAll:  aPurchaseList .! !

!Store methodsFor: 'operations' stamp: 'sc 6/24/2021 00:20:45'!
addToCart: aCartId  aBook: aBook  withAmount: anAmount onTime: aTimeStamp .
	self checkIfCart: aCartId IsStillValidAt:  aTimeStamp.
	(carts at: aCartId) add: anAmount of: aBook.! !

!Store methodsFor: 'operations' stamp: 'sc 6/23/2021 23:22:27'!
addTotal:aTotal fromUser: aUserId
	(moneySpentByClient includesKey: aUserId) ifFalse:[moneySpentByClient at: aUserId put: 0].
	moneySpentByClient at: aUserId put: ((moneySpentByClient at: aUserId) + aTotal).! !

!Store methodsFor: 'operations' stamp: 'sc 6/24/2021 00:27:41'!
checkOut: aCartId withCard: aCreditCard onTime: aTimeStamp 
	|cashier|
	self checkIfCart: aCartId IsStillValidAt: aTimeStamp.
	self registerPurchase: aCartId.
	cashier _ Cashier toCheckout: (carts at: aCartId ) 
		charging: aCreditCard 
		throught: merchantProcessor
		on: (Date today)
		registeringOn: salesBook.
	cashier checkOut.
	(carts at: aCartId) discardItems.! !

!Store methodsFor: 'operations' stamp: 'sc 6/24/2021 00:20:17'!
listCart: cartId onTime: timeStamp 
	self checkIfCart: cartId IsStillValidAt:  timeStamp.
	^ (carts at: cartId) list.
	! !

!Store methodsFor: 'operations' stamp: 'sc 6/23/2021 23:22:56'!
listPurchasesOf: aClientId withPassword: aPassword 
	|finalListPurchases|
	self raiseInvalidCredentialsError: aClientId  andWith: aPassword.
	finalListPurchases _ OrderedCollection new.
	finalListPurchases addAll: (purchasesListByClient at: aClientId ifAbsent:[OrderedCollection new]).
	finalListPurchases add: (moneySpentByClient at: aClientId ifAbsent:[0]).
	^finalListPurchases.
! !


!Store methodsFor: 'errorHandling' stamp: 'sc 6/21/2021 16:29:26'!
raiseErrorIfClientIsNotInDatabase: aClientId.
	(clientsCredentialData includesKey: aClientId) ifFalse:[ self error: self class invalidCredentialsErrorMessage]! !

!Store methodsFor: 'errorHandling' stamp: 'sc 6/21/2021 16:32:17'!
raiseErrorIfClientPasswordDoesNotMatch: aClientId  and: aPassword.

	((clientsCredentialData at: aClientId)  = aPassword ) ifFalse:[
		self error: self class invalidCredentialsErrorMessage]! !

!Store methodsFor: 'errorHandling' stamp: 'sc 6/21/2021 16:30:08'!
raiseInvalidCredentialsError: aClientId andWith: aPassword

	self raiseErrorIfClientIsNotInDatabase: aClientId.
	self raiseErrorIfClientPasswordDoesNotMatch: aClientId  and: aPassword.! !


!Store methodsFor: 'private' stamp: 'sc 6/24/2021 00:19:34'!
checkIfCart: cartId IsStillValidAt:  timeStamp
	(carts at: cartId) raiseErrorIfUnusedFor30minutes: timeStamp. ! !

!Store methodsFor: 'private' stamp: 'sc 6/23/2021 21:50:53'!
registerPurchase:aCartId
	 (carts at: aCartId) registerPurchaseOn: self.
	! !


!Store methodsFor: 'sales registration' stamp: 'sc 6/23/2021 23:28:00'!
hasRegisteredSaleFor: aSaleAmount 
	^salesBook anySatisfy: [:aSale| aSale total = aSaleAmount]! !

!Store methodsFor: 'sales registration' stamp: 'sc 6/23/2021 23:21:15'!
registeredSalesAmount
	^salesBook size.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Store class' category: 'TusLibros'!
Store class
	instanceVariableNames: ''!

!Store class methodsFor: 'instance creation' stamp: 'sc 6/23/2021 23:11:11'!
newWith: clientsData withCatalog: aCatalog withMerchantProcessor: aMerchantProcessor   
	^self new initializeWithClientDatabase: clientsData withCatalog: aCatalog withMerchantProcessor: aMerchantProcessor.! !


!Store class methodsFor: 'error' stamp: 'sc 6/21/2021 15:15:25'!
invalidCredentialsErrorMessage
	^'si no te acordas el usuario o los datos anotatelos en un papelito maestro'! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'sc 6/21/2021 18:09:58'!
anotherItemSellByTheStore
	
	^ 'anotherValidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'sc 6/21/2021 18:13:08'!
anotherItemSellByTheStorePrice
	
	^11! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'sc 6/24/2021 00:01:47'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog forClient: 'aDefaultClient' onTime: DateAndTime now.! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'sc 6/21/2021 18:12:51'!
defaultCatalog
	|catalog|
	
	catalog _  Dictionary new.
	catalog 	at: self itemSellByTheStore put: self itemSellByTheStorePrice.
	catalog at: self anotherItemSellByTheStore  put: self anotherItemSellByTheStorePrice.
	^catalog.
	
	! !


!StoreTestObjectsFactory methodsFor: 'store' stamp: 'sc 6/24/2021 00:38:57'!
createStore: aMerchantProcessor
	^ Store newWith: self defaultUserData withCatalog: self defaultCatalog withMerchantProcessor: aMerchantProcessor.! !


!StoreTestObjectsFactory methodsFor: 'userData' stamp: 'sc 6/24/2021 00:41:33'!
defaultUserData
	| anotherValidClientId anotherValidPassword clientPasswordData invalidClientId validClientId validPassword |
	validClientId _ 'santiagoCorley'.
	anotherValidClientId _'santiagoCorleyCuentaBackUp'.
	validPassword _ '1234abcde'.
	anotherValidPassword _ 'abcde1234'.
	^clientPasswordData _ Dictionary with: (validClientId-> validPassword ) with: (anotherValidClientId -> 	anotherValidPassword).! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
