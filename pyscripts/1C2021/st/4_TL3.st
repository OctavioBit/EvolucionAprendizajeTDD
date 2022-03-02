!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'ET 6/24/2021 13:25:39'!
test01NewCartsAreCreatedEmpty

	self assert: testObjects createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'ET 6/24/2021 13:25:53'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjects createCart.
	
	self 
		should: [ cart add: testObjects itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'ET 6/24/2021 13:25:58'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjects createCart.
	
	cart add: testObjects itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'ET 6/24/2021 13:26:04'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjects createCart.
	
	self 
		should: [cart add: 0 of: testObjects itemSellByTheStore. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'ET 6/24/2021 13:26:09'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjects createCart.
	
	self 
		should: [cart add: 2 of: testObjects itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'ET 6/24/2021 13:26:12'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjects createCart.
	
	cart add: testObjects itemSellByTheStore.
	self assert: (cart includes: testObjects itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'ET 6/24/2021 13:26:16'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjects createCart.
	
	self deny: (cart includes: testObjects itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'ET 6/24/2021 13:26:20'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjects createCart.
	
	cart add: 2 of: testObjects itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjects itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setUp' stamp: 'ET 6/24/2021 13:21:42'!
setUp
	
	testObjects := TestObjects new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'ET 6/24/2021 13:31:26'!
test01CanNotCheckoutEmptyCart

	|cart cashier aSalesBook |

	cart := testObjects createCart.
	
	aSalesBook := OrderedCollection new.
	cashier := self newCashierWithSalesBook: aSalesBook.
	
	self should: [cashier checkout: cart withCreditCard: testObjects validCreditCard.]
	 raise: Error
	 withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier emptyCartErrorDescription. 
			self assert: aSalesBook isEmpty.]! !

!CashierTest methodsFor: 'tests' stamp: 'ET 6/24/2021 13:31:38'!
test02CanNotCheckoutCartWithNonPricedItem

	|cart cashier aSalesBook |
	
	cart := testObjects createCart.
	cart add: testObjects itemSellByTheStore.
	
	aSalesBook := OrderedCollection new.
	
	cashier := self newCashierWithPriceList: Dictionary new salesBook: aSalesBook.
	
	self should: [cashier checkout: cart withCreditCard: testObjects validCreditCard]
	 raise: Error
	 withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier itemNotInPriceListErrorDescription. 
			self assert: aSalesBook isEmpty]! !

!CashierTest methodsFor: 'tests' stamp: 'ET 6/24/2021 13:36:09'!
test03CheckoutCartWithOneItemReturnsThePriceOfThatItem

	|cart cashier aSalesBook sales |
	
	cart := testObjects createCart.
	cart add: testObjects itemSellByTheStore.
	
	
	aSalesBook := OrderedCollection new.
	cashier := self newCashierWithSalesBook: aSalesBook.
	
	sales _ cashier checkout: cart withCreditCard: testObjects validCreditCard.
	self assert: 1 equals: aSalesBook size.
	self assert: aSalesBook first = sales.
	self assert: 1 equals: (sales items occurrencesOf: testObjects itemSellByTheStore).
	self assert: testObjects itemInStorePrice equals: sales totalAmount.! !

!CashierTest methodsFor: 'tests' stamp: 'ET 6/24/2021 13:38:25'!
test04CheckoutCartWithManyItemsReturnsTheSumOfThePricesOfThoseItems

	|cart cashier aSalesBook sales |

	cart := testObjects createCart.
	cart add: 2 of: testObjects itemSellByTheStore.
	
	
	aSalesBook := OrderedCollection new.
	cashier := self newCashierWithSalesBook: aSalesBook.
	sales _ cashier checkout: cart withCreditCard: testObjects validCreditCard.
	self assert: 1 equals: aSalesBook size.
	self assert: aSalesBook first = sales.
	self assert: 2 equals: (sales items occurrencesOf: testObjects itemSellByTheStore ).
	self assert: 2 * testObjects itemInStorePrice equals: sales totalAmount.! !

!CashierTest methodsFor: 'tests' stamp: 'ET 6/24/2021 13:28:22'!
test05CanNotCheckoutWithExpiredCreditCard

	|cart cashier aSalesBook |
	
	cart := testObjects createCart.
	cart add: testObjects itemSellByTheStore.
	
	aSalesBook := OrderedCollection new.
	cashier := self newCashierWithSalesBook: aSalesBook.
	
	self should: [ (cashier checkout: cart withCreditCard: self expiredCreditCard)]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier expiredCreditCardErrorDescription.
			self assert: aSalesBook isEmpty ]	.
		
		
		! !

!CashierTest methodsFor: 'tests' stamp: 'ET 6/24/2021 13:38:31'!
test06CanNotCheckoutIfMerchantProcessorRaisesError

	|cart cashier aSalesBook messageError |

	cart := testObjects createCart.
	cart add: testObjects itemSellByTheStore.

	messageError := 'Something unexpected happened'.
	
	aSalesBook := OrderedCollection new.
	cashier := Cashier with: testObjects defaultPriceList registerSalesOn: aSalesBook merchantProcessor: (self createMerchantProcessorThatRaisesError: messageError).
	
	
	self should: [ (cashier checkout: cart withCreditCard: testObjects validCreditCard )]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
			self assert: anError messageText = messageError.
			self assert: aSalesBook isEmpty ]	.
		
		
		! !


!CashierTest methodsFor: 'setUp' stamp: 'ET 6/24/2021 13:27:43'!
setUp

	testObjects  := TestObjects new.! !


!CashierTest methodsFor: 'support' stamp: 'ET 6/16/2021 18:29:03'!
createMerchantProcessorThatRaisesError: messageError
	|aMerchantProcessor|
	aMerchantProcessor := MerchantProcessorSimulator new.
	aMerchantProcessor raiseErrorOnCharge: messageError.
	^aMerchantProcessor

		
		
		! !

!CashierTest methodsFor: 'support' stamp: 'ET 6/10/2021 20:40:54'!
expiredCreditCard

	^ CreditCard owner: 'owner' number: '1234567891011121' expiration: GregorianMonthOfYear current previous.! !

!CashierTest methodsFor: 'support' stamp: 'ET 6/16/2021 17:19:41'!
newCashierWithPriceList: aPriceList salesBook: aSalesBook
	
	^Cashier with: aPriceList registerSalesOn: aSalesBook merchantProcessor: MerchantProcessorSimulator new.
		
		! !

!CashierTest methodsFor: 'support' stamp: 'ET 6/24/2021 13:32:16'!
newCashierWithSalesBook: aSalesBook
	
	^self newCashierWithPriceList: testObjects defaultPriceList salesBook: aSalesBook.
		
		! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'ET 6/16/2021 17:58:33'!
test01CanNotCreateCreditCardWithIncorrectSizeNumber
	
	self assertCreditCardInstanceCreationRaisesErrorWhenOwnedBy: 'Juan' withNumber: '1234'.! !

!CreditCardTest methodsFor: 'tests' stamp: 'ET 6/16/2021 17:58:33'!
test02CanNotCreateCreditCardWithAlphaNumericNumber

	self assertCreditCardInstanceCreationRaisesErrorWhenOwnedBy: 'Juan' withNumber: '1234567890ABCDEF'.! !

!CreditCardTest methodsFor: 'tests' stamp: 'ET 6/16/2021 17:58:33'!
test03CanNotCreateCreditCardWithBlankOwner

	self assertCreditCardInstanceCreationRaisesErrorWhenOwnedBy: '    ' withNumber: '1234567890123456'.! !

!CreditCardTest methodsFor: 'tests' stamp: 'ET 6/16/2021 20:53:07'!
test04ExpiredCreditCardIsExpired

	| creditCard |
	creditCard := CreditCard owner: 'Juan'  number: '1234567890123456' expiration: GregorianMonthOfYear current previous.
	
	
	self assert: (creditCard isExpiredOn: Date today).
	! !

!CreditCardTest methodsFor: 'tests' stamp: 'ET 6/16/2021 20:53:01'!
test05NonExpiredCreditCardIsNotExpired

	| creditCard |
	creditCard := CreditCard owner: 'Juan'  number: '1234567890123456' expiration: GregorianMonthOfYear current next.
	
	
	self deny: (creditCard isExpiredOn: Date today).
	! !


!CreditCardTest methodsFor: 'assertions' stamp: 'ET 6/16/2021 17:58:33'!
assertCreditCardInstanceCreationRaisesErrorWhenOwnedBy: anOwner withNumber: aStringNumber
	self should: [CreditCard owner: anOwner  number: aStringNumber expiration: GregorianMonthOfYear current]
	 	raise: Error - MessageNotUnderstood
		withExceptionDo:[ :anError| self assert: CreditCard invalidCreditCardErrorDescription equals: anError messageText	] ! !


!classDefinition: #StoreTest category: 'TusLibros'!
TestCase subclass: #StoreTest
	instanceVariableNames: 'testObjects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTest methodsFor: 'setUp' stamp: 'ET 6/24/2021 01:38:48'!
setUp

	testObjects := TestObjects new.! !


!StoreTest methodsFor: 'tests' stamp: 'JA 6/24/2021 09:01:37'!
test01CanNotCreateCartWhenCredentialsCantBeAuthenticated

	| store errorMessage clientAuthenticatorSimulator |
	errorMessage _ 'Username or password invalid'.
	clientAuthenticatorSimulator _ ClientAuthenticatorSimulator new.
	clientAuthenticatorSimulator raiseAuthenticationErrorWithMessage: errorMessage .
	store := Store withClientAuthenticator: clientAuthenticatorSimulator clock: GregorianDateTime now priceList: testObjects defaultPriceList merchantProcessor: MerchantProcessorSimulator new.
	
	
	self should: [		store createCartFor: 123 authenticatedWith: 'passwd'	] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 	self assert: errorMessage  equals: anError messageText.
					self deny: store hasCarts.]
	
	
	
		! !

!StoreTest methodsFor: 'tests' stamp: 'JA 6/24/2021 09:10:24'!
test02StoreHasNewCreatedCart

	| store aCartId |
	store := self store.
	
	aCartId := store createCartFor: self validUserID authenticatedWith: self validUserPassword.	

	self assert: store hasCarts.
	self assert: (store hasCartIdentified: aCartId).

	
	
	
		! !

!StoreTest methodsFor: 'tests' stamp: 'JA 6/23/2021 08:25:49'!
test03StoreOnlyIdentifiesIDsMatchedWithCreatedCarts

	| store |
	store := self store .
	
	
	self deny: store hasCarts.
	self deny: (store hasCartIdentified: -1).

	
	
	
		! !

!StoreTest methodsFor: 'tests' stamp: 'JA 6/24/2021 09:10:10'!
test04NewCreatedCartIsEmpty

	| store aCartId |
	store := self store .
	
	aCartId := store createCartFor: self validUserID authenticatedWith: self validUserPassword.	

	self assert: (store listCart: aCartId) isEmpty.
	
	
	
		! !

!StoreTest methodsFor: 'tests' stamp: 'JA 6/23/2021 08:26:11'!
test05CanNotListNonIdentifiedCart

	| store |
	store := self store .

	self should: [store listCart: -1]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError | self assert: anError messageText = Store invalidCartIDErrorDescription]
	
	
	
		! !

!StoreTest methodsFor: 'tests' stamp: 'JA 6/24/2021 09:22:48'!
test06StoreCanCreateMoreThanOneCart

	| store cartID1 cartID2 |
	store := self store .
	
	cartID1 := store createCartFor: self validUserID authenticatedWith: self validUserPassword.	
	cartID2 := store createCartFor: self validUserID authenticatedWith: self validUserPassword.	
	
	self deny: cartID1 = cartID2.
	self assert: (store hasCartIdentified: cartID1).
	self assert: (store hasCartIdentified: cartID2).

	
	
	
		! !

!StoreTest methodsFor: 'tests' stamp: 'JA 6/24/2021 09:20:45'!
test07CartIsInvalidAfter30MinOfItsCreation

	| store cartID1 aClockSimulator |
	aClockSimulator:= self clockSimulator.
	store := Store withClientAuthenticator: ClientAuthenticatorSimulator new clock: aClockSimulator priceList: testObjects defaultPriceList merchantProcessor: MerchantProcessorSimulator new.
	cartID1 := self createValidCartIn: store.	

	aClockSimulator addMinutes: 31.

	self deny: (store hasCartIdentified: cartID1).
		! !

!StoreTest methodsFor: 'tests' stamp: 'JA 6/24/2021 09:28:16'!
test08CannotAddToCartAfter30MinOfItsCreation

	| store cartID1 aClockSimulator |
	aClockSimulator:= self clockSimulator.
	store := Store withClientAuthenticator: ClientAuthenticatorSimulator new clock: aClockSimulator priceList: testObjects defaultPriceList merchantProcessor: MerchantProcessorSimulator new.
	cartID1 := self createValidCartIn: store.	
	aClockSimulator addMinutes: 31.
	
	
	self should: [store addToCart: cartID1 item: testObjects itemSellByTheStore  quantity: 10.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError | self assert: anError messageText = Store invalidCartIDErrorDescription]	! !

!StoreTest methodsFor: 'tests' stamp: 'JA 6/24/2021 09:18:24'!
test09ItemsAddedToCartAreListed

	| store cartID cartList |
	store := self store .
	cartID := self createValidCartIn: store.	
	
	
	store addToCart: cartID item: testObjects itemSellByTheStore quantity:10.
	cartList := store listCart: cartID .
	
	self assert: 10 equals: (cartList size).
	self assert: 10 equals: (cartList occurrencesOf: testObjects itemSellByTheStore).
	! !

!StoreTest methodsFor: 'tests' stamp: 'JA 6/24/2021 09:08:50'!
test10PurchaseListOfUserWithoutPurchasesIsEmpty

	| store purchases |
	store := self store .
	
	purchases := store listPurchasesOf: self validUserID password: self validUserPassword.
	self assert: purchases isEmpty.
	self assert: 0 equals: purchases totalAmount .
	! !

!StoreTest methodsFor: 'tests' stamp: 'JA 6/24/2021 09:26:12'!
test11CanNotListPurchasesWhenCredentialsCantBeAuthenticated

	| store clientAuthenticatorSimulator errorMessage |
	store := self store .		
	errorMessage _ 'Username or password invalid'.
	clientAuthenticatorSimulator _ ClientAuthenticatorSimulator new.
	clientAuthenticatorSimulator raiseAuthenticationErrorWithMessage: errorMessage .
	store := Store withClientAuthenticator: clientAuthenticatorSimulator clock: self clockSimulator priceList: testObjects defaultPriceList merchantProcessor: MerchantProcessorSimulator new .
	
	
	self should: [
		store listPurchasesOf: self validUserID password: self validUserPassword .
	] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :exception | 	
		self assert: errorMessage  equals: exception messageText.
		self deny: store hasCarts.
	]
	
	
	
			! !

!StoreTest methodsFor: 'tests' stamp: 'JA 6/24/2021 09:25:40'!
test12CheckoutUpdatesPurchaseListOfUserWithTheSales

	| store purchases cartID1 |
	store := self store .
	cartID1 := self createValidCartIn: store.	
	store addToCart: cartID1 item: testObjects itemSellByTheStore quantity: 10.
	
	store checkoutCart: cartID1 creditCard: testObjects validCreditCard .
	
	purchases := store listPurchasesOf: self validUserID password: self validUserPassword .
	self assert: 10 equals: purchases list size.
	self assert: 10 equals: (purchases list occurrencesOf: testObjects itemSellByTheStore).
	self assert: 10 * testObjects itemInStorePrice equals: purchases totalAmount.	! !

!StoreTest methodsFor: 'tests' stamp: 'ET 6/24/2021 01:41:10'!
test13CannotCheckoutWithInvalidCartID

	| store |
	store := self store .
	
	self should:  [store checkoutCart: -1 creditCard: testObjects validCreditCard .]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:exception | self assert: Store invalidCartIDErrorDescription equals: exception messageText]
	
	
	! !

!StoreTest methodsFor: 'tests' stamp: 'JA 6/24/2021 09:15:11'!
test14CheckoutInvalidatesCartId

	| store cartID1 |
	store := self store .
	cartID1 := self createValidCartIn: store.	
	store addToCart: cartID1 item: testObjects itemSellByTheStore quantity: 10.
		
	store checkoutCart: cartID1 creditCard: testObjects validCreditCard .
	
	self deny: (store hasCartIdentified: cartID1).! !

!StoreTest methodsFor: 'tests' stamp: 'JA 6/24/2021 09:27:20'!
test15CheckoutCartReturnsUniqueTransactionIDs

	| store cartID1 cartID2 transactionID1 transactionID2 |
	store := self store .
	cartID1 := self createValidCartIn: store.	
	cartID2 := self createValidCartIn: store.		
	store addToCart: cartID1 item: testObjects itemSellByTheStore quantity: 10.
	store addToCart: cartID2 item: testObjects itemSellByTheStore quantity: 10.		
	
	transactionID1 := store checkoutCart: cartID1 creditCard: testObjects validCreditCard .
	transactionID2 := store checkoutCart: cartID2 creditCard: testObjects validCreditCard .	
	
	self deny: transactionID1 = transactionID2.! !

!StoreTest methodsFor: 'tests' stamp: 'JA 6/24/2021 09:13:42'!
test16UseCartUpdatesTimeLimit

	| store cartID1 aClockSimulator |
	aClockSimulator:= self clockSimulator.
	store := Store withClientAuthenticator: ClientAuthenticatorSimulator new clock: aClockSimulator priceList: testObjects defaultPriceList merchantProcessor: MerchantProcessorSimulator new.
	cartID1 := self createValidCartIn: store.	

	aClockSimulator addMinutes: 30.
	store addToCart: cartID1 item: testObjects itemSellByTheStore quantity:10.
	aClockSimulator addMinutes: 1.
	store listCart: cartID1.								
	aClockSimulator addMinutes: 30.
	store listCart: cartID1.
	aClockSimulator addMinutes: 31.
	
	self should: [store addToCart: cartID1 item: testObjects itemSellByTheStore quantity: 10.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError | self assert: anError messageText = Store invalidCartIDErrorDescription]	! !


!StoreTest methodsFor: 'support' stamp: 'JA 6/23/2021 09:45:12'!
clockSimulator

	^ ClockSimulator with: self dateForTesting! !

!StoreTest methodsFor: 'support' stamp: 'JA 6/24/2021 09:13:42'!
createValidCartIn: store

	^ store createCartFor: self validUserID authenticatedWith: self validUserPassword! !

!StoreTest methodsFor: 'support' stamp: 'JA 6/23/2021 09:40:30'!
dateForTesting

	^ GregorianDateTime date: (FixedGregorianDate yearNumber: 2004 month: GregorianMonth january dayNumber: 1) timeOfDay: 00:00:00! !

!StoreTest methodsFor: 'support' stamp: 'JA 6/24/2021 09:01:37'!
store
	
	^ Store withClientAuthenticator: ClientAuthenticatorSimulator new clock: self clockSimulator priceList: testObjects defaultPriceList merchantProcessor: MerchantProcessorSimulator new.! !

!StoreTest methodsFor: 'support' stamp: 'JA 6/24/2021 09:06:14'!
validUserID

	^ 123! !

!StoreTest methodsFor: 'support' stamp: 'JA 6/24/2021 09:06:34'!
validUserPassword

	^ 'passwd'! !


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


!Cart methodsFor: 'queries' stamp: 'ET 6/10/2021 20:09:25'!
do: aBlockClosure

	items do: aBlockClosure.! !

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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'priceList salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'ET 6/16/2021 17:43:07'!
initializeWith: aPriceList registerSalesOn: aSalesBook merchantProcessor: aMerchantProcessor 
	
	priceList := aPriceList.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.! !


!Cashier methodsFor: 'checkout' stamp: 'ET 6/24/2021 01:58:58'!
checkout: aCart withCreditCard: aCreditCard 
	|totalPrice items sales|
	self assertCartIsNotEmpty: aCart.
	self assertCreditCardIsNotExpired: aCreditCard.
	totalPrice := 0.
	items := OrderedCollection new.
	aCart do: [:anItem | totalPrice := totalPrice + priceList at: anItem ifAbsent: [self raiseItemNotInPriceListError].
		items add: anItem].
	merchantProcessor charge: totalPrice  on: aCreditCard .
	sales := Sales withItems: items totalAmount: totalPrice.
	salesBook add: sales.
	^sales.! !


!Cashier methodsFor: 'raise error' stamp: 'ET 6/16/2021 17:42:04'!
raiseItemNotInPriceListError

	^ self error: self class itemNotInPriceListErrorDescription! !


!Cashier methodsFor: 'assertions' stamp: 'ET 6/16/2021 17:39:23'!
assertCartIsNotEmpty: aCart

	^ aCart isEmpty ifTrue: [	self error: self class emptyCartErrorDescription]! !

!Cashier methodsFor: 'assertions' stamp: 'ET 6/16/2021 20:56:27'!
assertCreditCardIsNotExpired: aCreditCard
	
	(aCreditCard isExpiredOn: Date today) ifTrue: [self error: self class expiredCreditCardErrorDescription].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'ET 6/16/2021 17:43:19'!
with: aPriceList registerSalesOn: aSalesBook merchantProcessor: aMerchantProcessor 
	^self new initializeWith: aPriceList registerSalesOn: aSalesBook merchantProcessor: aMerchantProcessor ! !


!Cashier class methodsFor: 'error messages' stamp: 'ET 6/16/2021 17:39:23'!
emptyCartErrorDescription
	^'The cart is empty'.! !

!Cashier class methodsFor: 'error messages' stamp: 'ET 6/16/2021 17:39:07'!
expiredCreditCardErrorDescription
	^'The credit card is expired'.! !

!Cashier class methodsFor: 'error messages' stamp: 'ET 6/16/2021 17:38:56'!
itemNotInPriceListErrorDescription
	^'An item in the cart is not in the price list'.! !


!classDefinition: #ClientAuthenticatorSimulator category: 'TusLibros'!
Object subclass: #ClientAuthenticatorSimulator
	instanceVariableNames: 'raiseAuthenticationError authenticationErrorMessage'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ClientAuthenticatorSimulator methodsFor: 'as yet unclassified' stamp: 'ET 6/24/2021 01:06:57'!
authenticateUser: aSmallInteger withPassword: aString 
	authenticationErrorMessage ifNotNil: [self error: authenticationErrorMessage].! !

!ClientAuthenticatorSimulator methodsFor: 'as yet unclassified' stamp: 'JA 6/17/2021 21:11:34'!
raiseAuthenticationErrorWithMessage: anErrorMessage
	authenticationErrorMessage := anErrorMessage .! !


!classDefinition: #ClockSimulator category: 'TusLibros'!
Object subclass: #ClockSimulator
	instanceVariableNames: 'dateTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ClockSimulator methodsFor: 'initialization' stamp: 'JA 6/23/2021 09:27:11'!
initializeWith: aDateTime
	dateTime := aDateTime .! !


!ClockSimulator methodsFor: 'adding' stamp: 'ET 6/24/2021 00:24:58'!
addMinutes: anAmountOfMinutes
	dateTime := dateTime next: (TimeUnits minute with: anAmountOfMinutes).! !


!ClockSimulator methodsFor: 'testing' stamp: 'JA 6/23/2021 09:27:43'!
now
	^ dateTime ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ClockSimulator class' category: 'TusLibros'!
ClockSimulator class
	instanceVariableNames: ''!

!ClockSimulator class methodsFor: 'as yet unclassified' stamp: 'JA 6/23/2021 09:26:51'!
with: aDateTime
	^ self new initializeWith: aDateTime.! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'ownerString creditCardNumberString expirationMonthOfYear'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'ET 6/16/2021 20:57:10'!
initializeOwner: anOwnerString number: aCreditCardNumberString expiration: aGregorianMonthOfYear 

	ownerString := anOwnerString.
	creditCardNumberString := aCreditCardNumberString.
	expirationMonthOfYear := aGregorianMonthOfYear.! !


!CreditCard methodsFor: 'as yet unclassified' stamp: 'ET 6/16/2021 20:57:10'!
isExpiredOn: aDate 
	
	^(GregorianMonthOfYear yearNumber: aDate yearNumber monthNumber: aDate monthIndex) > expirationMonthOfYear.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'JA 6/14/2021 19:59:51'!
owner: anOwnerString number: aCreditCardNumberString expiration: aGregorianMonthOfYear 
	self assertCreditCardNumberIsValid: aCreditCardNumberString.
	self assertNonBlankOwner: anOwnerString.
	^self new initializeOwner: anOwnerString number: aCreditCardNumberString expiration: aGregorianMonthOfYear ! !


!CreditCard class methodsFor: 'assertions' stamp: 'ET 6/16/2021 17:44:16'!
assertCreditCardNumberIsValid: aString 
	
	aString size = 16 ifFalse: [self error: self invalidCreditCardErrorDescription ].
	(aString allSatisfy: [:aDigit | aDigit isDigit]	) ifFalse: [self error: self invalidCreditCardErrorDescription ].! !

!CreditCard class methodsFor: 'assertions' stamp: 'ET 6/16/2021 17:44:16'!
assertNonBlankOwner: anOwnerString
	anOwnerString withBlanksTrimmed isEmpty ifTrue: [self error: self invalidCreditCardErrorDescription ]
	
	! !


!CreditCard class methodsFor: 'error messages' stamp: 'ET 6/16/2021 17:44:16'!
invalidCreditCardErrorDescription
	^'Los datos de la tarjeta de crédito son inválidos'! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'messageError'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'charge' stamp: 'JA 6/14/2021 19:21:11'!
charge: aCharge on: aCreditCard 
	messageError ifNotNil: [	self error: messageError].! !


!MerchantProcessorSimulator methodsFor: 'error simulation' stamp: 'JA 6/14/2021 19:20:19'!
raiseErrorOnCharge: aMessageError 
	messageError := aMessageError.! !


!classDefinition: #PurchaseList category: 'TusLibros'!
Object subclass: #PurchaseList
	instanceVariableNames: 'itemList priceList amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!PurchaseList methodsFor: 'initialization' stamp: 'ET 6/24/2021 02:18:45'!
initializeWithItems: anItemList totalAmount: anAmount 
	itemList := anItemList.
	amount := anAmount.! !


!PurchaseList methodsFor: 'accessing' stamp: 'JA 6/23/2021 20:22:34'!
list
	^ itemList copy.! !

!PurchaseList methodsFor: 'accessing' stamp: 'ET 6/24/2021 02:19:10'!
totalAmount
	^amount.! !


!PurchaseList methodsFor: 'testing' stamp: 'JA 6/23/2021 20:28:21'!
isEmpty
	^ itemList isEmpty .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PurchaseList class' category: 'TusLibros'!
PurchaseList class
	instanceVariableNames: ''!

!PurchaseList class methodsFor: 'as yet unclassified' stamp: 'ET 6/24/2021 02:18:11'!
withItems: anItemList totalAmount: anAmount.
	^ self new initializeWithItems: anItemList totalAmount: anAmount .! !


!classDefinition: #Sales category: 'TusLibros'!
Object subclass: #Sales
	instanceVariableNames: 'userID amount items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sales methodsFor: 'initialization' stamp: 'ET 6/24/2021 02:03:22'!
initializeWithItems: aCollectionOfItems totalAmount: anAmount 

	items := aCollectionOfItems.
	amount := anAmount.! !


!Sales methodsFor: 'amount' stamp: 'ET 6/24/2021 02:03:34'!
totalAmount
	^amount.! !


!Sales methodsFor: 'user' stamp: 'ET 6/24/2021 02:09:59'!
userID
	^userID.! !

!Sales methodsFor: 'user' stamp: 'ET 6/24/2021 02:09:52'!
userID: aUserID
	userID := aUserID.! !


!Sales methodsFor: 'list' stamp: 'ET 6/24/2021 02:03:44'!
items
	^items! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sales class' category: 'TusLibros'!
Sales class
	instanceVariableNames: ''!

!Sales class methodsFor: 'instance creation' stamp: 'ET 6/24/2021 02:02:18'!
withItems: items totalAmount: anAmount

	^self new initializeWithItems: items totalAmount: anAmount.! !


!classDefinition: #Store category: 'TusLibros'!
Object subclass: #Store
	instanceVariableNames: 'clientAuthenticator carts lastTimeCartUsed clock priceList cartOwner salesBook cashier currentCartID'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Store methodsFor: 'initialization' stamp: 'JA 6/24/2021 09:02:04'!
initializeWithClientAuthenticator: aClientAuthenticator clock: aClock priceList: aPriceList merchantProcessor: aMerchantProcessor  
	clientAuthenticator := aClientAuthenticator.
	clock := aClock.
	priceList := aPriceList.
	carts := Dictionary new.
	lastTimeCartUsed := Dictionary new.
	cartOwner := Dictionary new.
	salesBook := OrderedCollection new.
	cashier := Cashier with: priceList registerSalesOn: salesBook merchantProcessor: aMerchantProcessor .
	currentCartID := 0.
	
! !


!Store methodsFor: 'assertion' stamp: 'JA 6/23/2021 21:57:33'!
assertCartIDIsValid: cartID
	
	(self hasCartIdentified: cartID)
	ifFalse: [self error: self class invalidCartIDErrorDescription ]! !


!Store methodsFor: 'checkout' stamp: 'ET 6/24/2021 13:20:14'!
checkoutCart: aCartId creditCard: aCreditCard 
	| userID sales|
	self assertCartIDIsValid: aCartId.
	
	sales := cashier checkout: (carts at: aCartId) withCreditCard: aCreditCard.
	userID := cartOwner at: aCartId. 
	sales userID: userID.
	
	self invalidateCartId: aCartId.

	^salesBook size.! !


!Store methodsFor: 'testing' stamp: 'ET 6/24/2021 01:21:20'!
hasCartIdentified: aCartId 
	
 	carts at: aCartId ifAbsent: [^ false].
	(self expiredCart: aCartId) 
		ifTrue: [self invalidateCartId: aCartId.
			^false].
	^true.
	! !

!Store methodsFor: 'testing' stamp: 'JA 6/17/2021 21:25:00'!
hasCarts
	^ carts isEmpty not.! !


!Store methodsFor: 'private' stamp: 'JA 6/23/2021 09:58:46'!
expiredCart: aCartId

	^ ((lastTimeCartUsed at: aCartId) next: (TimeUnits minute with: self maxInactiveTimeInMinutes)) < clock now! !

!Store methodsFor: 'private' stamp: 'ET 6/24/2021 01:21:48'!
invalidateCartId: aCartID
	carts removeKey: aCartID.
	lastTimeCartUsed removeKey: aCartID.
	cartOwner removeKey: aCartID.! !

!Store methodsFor: 'private' stamp: 'JA 6/24/2021 09:34:35'!
itemCatalog

	^ priceList keys! !

!Store methodsFor: 'private' stamp: 'JA 6/23/2021 09:59:25'!
maxInactiveTimeInMinutes

	^ 30! !


!Store methodsFor: 'lists' stamp: 'JA 6/24/2021 09:36:40'!
listCart: cartID
	
	| cartList |
	self assertCartIDIsValid: cartID.
	
	cartList := OrderedCollection new.
	(carts at: cartID) do: [:anItem | cartList add: anItem].
	
	self updateLastTimeUsedFor: cartID.
	
	^ cartList.! !

!Store methodsFor: 'lists' stamp: 'JA 6/24/2021 08:41:30'!
listPurchasesOf: aUserId password: aPassword
	
	clientAuthenticator authenticateUser: aUserId withPassword: aPassword. 
	
	^ self purchaseListFor: aUserId 
	! !

!Store methodsFor: 'lists' stamp: 'JA 6/24/2021 08:41:01'!
purchaseListFor: aUserID
	|userIDSales items totalAmount|	
	userIDSales := salesBook select: [:aSales | aSales userID = aUserID].
	items := OrderedCollection new.
	userIDSales do: [:aSales | items addAll: aSales items].
	totalAmount := userIDSales sum: [:aSales | aSales totalAmount] ifEmpty: 0.
	^PurchaseList withItems: items totalAmount: totalAmount.
	! !

!Store methodsFor: 'lists' stamp: 'JA 6/24/2021 08:42:51'!
updateLastTimeUsedFor: cartID

	^ lastTimeCartUsed at: cartID put: clock now! !


!Store methodsFor: 'adding' stamp: 'JA 6/24/2021 08:44:03'!
addToCart: aCartID item: anItem quantity: aQuantity

	self assertCartIDIsValid: aCartID	.	
	(carts at: aCartID) add: aQuantity of: anItem.	
	self updateLastTimeUsedFor: aCartID.! !

!Store methodsFor: 'adding' stamp: 'JA 6/24/2021 09:34:35'!
createCartFor: userID authenticatedWith: aPassword
	|cartID|
	clientAuthenticator authenticateUser: userID withPassword: aPassword. 
	
	cartID := self nextFreeCartID.
	carts add: cartID -> (Cart acceptingItemsOf: self itemCatalog).
	cartOwner add: cartID -> userID.
	
	self updateLastTimeUsedFor: cartID .
	^cartID
	
	! !

!Store methodsFor: 'adding' stamp: 'JA 6/24/2021 08:56:06'!
nextFreeCartID
	
	currentCartID := currentCartID + 1.	
	^ currentCartID 
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Store class' category: 'TusLibros'!
Store class
	instanceVariableNames: ''!

!Store class methodsFor: 'instance creation' stamp: 'JA 6/24/2021 09:01:49'!
withClientAuthenticator: aClientAuthenticator clock: aClock priceList: priceList merchantProcessor: aMerchantProcessor    
	^self new initializeWithClientAuthenticator: aClientAuthenticator clock: aClock priceList: priceList merchantProcessor: aMerchantProcessor .! !


!Store class methodsFor: 'error messages' stamp: 'ET 6/22/2021 00:50:04'!
invalidCartIDErrorDescription
	^'Cart ID is not in the system'! !


!classDefinition: #TestObjects category: 'TusLibros'!
Object subclass: #TestObjects
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestObjects methodsFor: 'as yet unclassified' stamp: 'ET 6/24/2021 13:29:41'!
createCart

	^Cart acceptingItemsOf: self defaultCatalog.! !

!TestObjects methodsFor: 'as yet unclassified' stamp: 'JA 6/23/2021 08:10:29'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!TestObjects methodsFor: 'as yet unclassified' stamp: 'JA 6/23/2021 19:14:46'!
defaultPriceList

	^Dictionary with: self itemSellByTheStore -> self itemInStorePrice.! !

!TestObjects methodsFor: 'as yet unclassified' stamp: 'JA 6/23/2021 19:15:05'!
itemInStorePrice
	^ 10! !

!TestObjects methodsFor: 'as yet unclassified' stamp: 'ET 6/24/2021 13:24:48'!
itemNotSellByTheStore
	
	^ 'invalidBook'! !

!TestObjects methodsFor: 'as yet unclassified' stamp: 'JA 6/23/2021 08:10:56'!
itemSellByTheStore
	
	^ 'validBook'! !

!TestObjects methodsFor: 'as yet unclassified' stamp: 'JA 6/23/2021 18:45:50'!
validCreditCard

	^ CreditCard owner: 'owner' number: '1234567891011121' expiration: GregorianMonthOfYear current next! !
