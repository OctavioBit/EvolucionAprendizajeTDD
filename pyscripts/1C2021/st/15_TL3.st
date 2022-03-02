!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'DV 6/14/2021 14:32:33'!
setUp 
	testObjects := StoreTestObjects  new! !

!CartTest methodsFor: 'tests' stamp: 'UC 6/16/2021 23:03:59'!
test01NewCartsAreCreatedEmpty

	self assert: testObjects emptyCartWithDefaultCatalogue isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'DV 6/17/2021 13:50:27'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjects emptyCartWithDefaultCatalogue.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: Cart invalidItemErrorMessage equals: anError messageText.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'UC 6/16/2021 23:04:11'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjects emptyCartWithDefaultCatalogue.
	
	cart add: testObjects itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'DV 6/17/2021 13:50:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjects emptyCartWithDefaultCatalogue.
	
	self 
		should: [cart add: 0 of: testObjects itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert:   Cart invalidQuantityErrorMessage equals: anError messageText.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'DV 6/17/2021 13:50:49'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjects emptyCartWithDefaultCatalogue.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: Cart invalidItemErrorMessage equals: anError messageText .
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'UC 6/19/2021 17:03:36'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjects emptyCartWithDefaultCatalogue.
	
	cart add: testObjects itemSellByTheStore.
	self assert: (cart includes: testObjects itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'UC 6/16/2021 23:04:31'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjects emptyCartWithDefaultCatalogue.
	
	self deny: (cart includes: testObjects itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'UC 6/16/2021 23:04:35'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjects emptyCartWithDefaultCatalogue.
	
	cart add: 2 of: testObjects itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjects itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'UC 6/16/2021 23:04:41'!
test09EmptyCartTotalIsZero

	| cart |
	
	cart := testObjects emptyCartWithDefaultCatalogue.
	
	self assert: 0 equals: cart total.! !

!CartTest methodsFor: 'tests' stamp: 'UC 6/20/2021 18:58:01'!
test10CartCanotUseCatalogueWIthNonPositivePrices

	| cart 	 catalogueWithZero catalogueWithNegativePrice |
	catalogueWithZero:=  Dictionary new.
	catalogueWithZero at: 'validBook' put: 0.

	self 
		should: [ cart := Cart  acceptingItemsOf:  catalogueWithZero forClient: testObjects sampleClientId createdOn: DateAndTime today. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: Cart invalidCatalogueMessage equals: anError messageText.
			self assert: cart isNil].
		
	catalogueWithNegativePrice:=  Dictionary new.
	catalogueWithNegativePrice at: 'validBook' put: -1.

	self 
		should: [ cart := Cart  acceptingItemsOf: catalogueWithNegativePrice forClient: testObjects sampleClientId createdOn: DateAndTime today. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: Cart invalidCatalogueMessage equals: anError messageText.
			self assert: cart isNil].! !


!CartTest methodsFor: 'support' stamp: 'DV 6/14/2021 14:34:34'!
itemNotSellByTheStore
	
	^ 'InvalidBook'! !


!classDefinition: #CashierPerSaleTest category: 'TusLibros'!
TestCase subclass: #CashierPerSaleTest
	instanceVariableNames: 'testObjects today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierPerSaleTest methodsFor: 'tests' stamp: 'UC 6/16/2021 23:06:53'!
setUp
	testObjects := StoreTestObjects new.! !

!CashierPerSaleTest methodsFor: 'tests' stamp: 'UC 6/16/2021 23:05:38'!
test01CreatingACashierPerSaleWithEmptyCartRaisesError

	| salesBook |
	salesBook := OrderedCollection new.
	self should: [self 
		cashierWith: testObjects emptyCartWithDefaultCatalogue 
		registeringOn: salesBook 
	] raise: Error 
	withExceptionDo:[:error | self assert: error messageText equals: CashierPerSale cannotCheckoutEmptyCart].
	
	self assert: salesBook isEmpty.
	! !

!CashierPerSaleTest methodsFor: 'tests' stamp: 'DV 6/24/2021 14:42:32'!
test02CheckOutOfMultipleCashiersReturnsDifferentSalesReceipts
	| multipleItemCart salesBook newCatalogue saleReceipt1 saleReceipt2 |

	newCatalogue :=  testObjects defaultCatalogue. 
	newCatalogue at: 'anotherBook' put: 200.
	
	salesBook := OrderedCollection new.
	multipleItemCart := Cart acceptingItemsOf: newCatalogue forClient: testObjects sampleClientId createdOn: DateAndTime today.
	
	multipleItemCart add: testObjects itemSellByTheStore.
	2 timesRepeat: [multipleItemCart add: 'anotherBook'].
	
	saleReceipt1 := (self cashierWith: multipleItemCart 
				registeringOn: salesBook) checkout.
	saleReceipt2 := (self cashierWith: self oneItemCart 
				registeringOn: salesBook) checkout .
				
	self assert: saleReceipt1 ~= saleReceipt2.
	self assert: saleReceipt1 id ~= saleReceipt2 id.! !

!CashierPerSaleTest methodsFor: 'tests' stamp: 'UC 6/16/2021 21:06:40'!
test03CreatingACashierPerSaleWithExpiredCreditCardRaisesError

	| oneItemCart salesBook |
	salesBook := OrderedCollection new.
	oneItemCart := self oneItemCart.

	self 
		should: [self 
				cashierWith: oneItemCart 
				chargingTo: self expiredCard 
				registeringOn: salesBook 
				with: MPSimulator answerWithOk 
			]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: CashierPerSale cannotCheckoutWithExpiredCard equals: anError messageText
		].
	self assert: salesBook isEmpty ! !

!CashierPerSaleTest methodsFor: 'tests' stamp: 'UC 6/16/2021 21:30:36'!
test04CheckOutClearsCart

	| cashier oneItemCart salesBook |
	salesBook := OrderedCollection new.
	oneItemCart := self oneItemCart.

	cashier := self cashierWith: oneItemCart 
				registeringOn: salesBook.
	cashier checkout.
	
	self assert: oneItemCart isEmpty! !

!CashierPerSaleTest methodsFor: 'tests' stamp: 'DV 6/24/2021 14:43:06'!
test05CheckOutRegistersASale
	| cashier oneItemCart salesBook receipt |
	salesBook := OrderedCollection new.
	oneItemCart := self oneItemCart.

	cashier := self cashierWith: oneItemCart 
				registeringOn: salesBook.
				
	receipt := cashier checkout.
	
	self assert: 1 equals: salesBook size.
	self assert:  receipt total equals: salesBook first total.
	! !

!CashierPerSaleTest methodsFor: 'tests' stamp: 'UC 6/16/2021 21:31:00'!
test06CheckingOutWIthCashierPerSaleTwiceRaisesError

	| oneItemCart salesBook cashier |
	salesBook := OrderedCollection new.
	oneItemCart := self oneItemCart.
	cashier := self cashierWith: oneItemCart 
				registeringOn: salesBook.
				
	cashier checkout.
	self 
		should: [ cashier checkout ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: CashierPerSale cannotCheckoutTwice equals: anError messageText
		].
	
	self assert: 1 equals: salesBook size! !

!CashierPerSaleTest methodsFor: 'tests' stamp: 'UC 6/17/2021 20:42:02'!
test07CheckOutWithFailingMerchantProcessorLeavesUntouchedSalesbookAndFullCart

	| cashier oneItemCart salesBook |
	
	salesBook := OrderedCollection new.
	oneItemCart := self oneItemCart.
	cashier := self cashierWith: oneItemCart 
				registeringOn: salesBook 
				with: MPSimulator answerWithError.
	
	self should: [	cashier checkout.] 
		raise: Error
		      withExceptionDo: [:anError | self assert: MPSimulator errorProcessingPayment equals: anError messageText].
		
	self assert: salesBook isEmpty.
	self assert: oneItemCart isEmpty not.! !


!CashierPerSaleTest methodsFor: 'support' stamp: 'UC 6/20/2021 19:30:19'!
cashierWith: aCart chargingTo: aCreditCard registeringOn: aSalesbook with: aMerchantProcessor 
	^ CashierPerSale 
		forCheckoutWith: aCart 
		chargingTo: aCreditCard 
		onDate: GregorianDateTime now
		registeringOn: aSalesbook 
		with: aMerchantProcessor ! !

!CashierPerSaleTest methodsFor: 'support' stamp: 'UC 6/20/2021 19:30:15'!
cashierWith: aCart registeringOn: aSalesbook
	^ CashierPerSale 
		forCheckoutWith: aCart 
		chargingTo: testObjects validCreditCard 
		onDate: GregorianDateTime now
		registeringOn: aSalesbook 
		with: MPSimulator answerWithOk! !

!CashierPerSaleTest methodsFor: 'support' stamp: 'UC 6/20/2021 19:30:11'!
cashierWith: aCart registeringOn: aSalesbook with: aMerchantProcessor 
	^ CashierPerSale 
		forCheckoutWith: aCart 
		chargingTo: testObjects validCreditCard
		onDate: GregorianDateTime now
		registeringOn: aSalesbook 
		with: aMerchantProcessor 
		! !

!CashierPerSaleTest methodsFor: 'support' stamp: 'UC 6/16/2021 23:08:45'!
expiredCard
	^ CreditCard withName: testObjects validCardName withNumber: testObjects validCardNumber withExpirationDate: testObjects expiredMonthOfYear ! !

!CashierPerSaleTest methodsFor: 'support' stamp: 'UC 6/16/2021 23:07:50'!
oneItemCart

	^ testObjects emptyCartWithDefaultCatalogue add: testObjects itemSellByTheStore! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'testObjects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'UC 6/16/2021 23:06:53'!
setUp
	testObjects := StoreTestObjects new.! !

!CreditCardTest methodsFor: 'tests' stamp: 'UC 6/16/2021 23:05:45'!
test01CreatingACardWithANameLongerThan30CharactersRaisesError

	self should:[CreditCard 
				withName:  'ABSAKJHAFSKJASFAJKSHFKJSAHFASKJFHSAFKJHSAFKJH'
				withNumber:  testObjects validCardNumber 
				withExpirationDate: testObjects notExpiredMonthOfYear
			] 
		raise: Error 
		withExceptionDo:[:anError |self assert: CreditCard invalidNameErrorMessage equals: anError messageText].
		
	
	! !

!CreditCardTest methodsFor: 'tests' stamp: 'UC 6/16/2021 23:05:50'!
test02CreatingACardWithEmptyNameRaisesError


	self should:[
			CreditCard withName:  ''
					    	withNumber: testObjects validCardNumber 
					 	withExpirationDate: testObjects notExpiredMonthOfYear 
		] 
		raise: Error 
		withExceptionDo:[:anError |self assert: anError messageText equals: CreditCard invalidNameErrorMessage]
! !

!CreditCardTest methodsFor: 'tests' stamp: 'UC 6/16/2021 23:06:01'!
test03CreatingACardWithANumberDifferentThan16DigitsRaisesError

	self should:[ 
			CreditCard withName: testObjects validCardName
				withNumber: 44546
				withExpirationDate: testObjects notExpiredMonthOfYear
		] 		
		raise: Error 
		withExceptionDo:[:anError |self assert: anError messageText equals: CreditCard invalidNumberErrorMessage].
	
	self should:[
			CreditCard withName: testObjects validCardName
				withNumber: 4454666678364872364327846327846324786
				withExpirationDate: testObjects notExpiredMonthOfYear
		] 		
		raise: Error 
		withExceptionDo:[:anError |self assert: anError messageText equals: CreditCard invalidNumberErrorMessage]! !

!CreditCardTest methodsFor: 'tests' stamp: 'UC 6/16/2021 23:05:33'!
test04CreatingACardWithValidNameAndValidNumberAndValidDateIsCorrect

	|card|
	
	card := testObjects  validCreditCard.
	
	self assert: testObjects validCardName equals: card name.
	self assert: testObjects validCardNumber equals: card number.
	self assert: testObjects notExpiredMonthOfYear equals: card date.! !


!classDefinition: #StoreFacadeTest category: 'TusLibros'!
TestCase subclass: #StoreFacadeTest
	instanceVariableNames: 'loginWithSuccess testObjects isTheFuture'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreFacadeTest methodsFor: 'stubbing' stamp: 'UC 6/17/2021 21:20:19'!
login: aClientId with: aPassword
	loginWithSuccess ifFalse: [self error: StoreFacade invalidClientIdOrPassword]! !

!StoreFacadeTest methodsFor: 'stubbing' stamp: 'UC 6/20/2021 19:43:35'!
now	
	^isTheFuture ifTrue: [GregorianDateTime now next: (30*minute) + (1*millisecond)]ifFalse:[GregorianDateTime now].
	
	! !

!StoreFacadeTest methodsFor: 'stubbing' stamp: 'UC 6/20/2021 19:31:14'!
setClockToFutureDate

	^ isTheFuture := true! !

!StoreFacadeTest methodsFor: 'stubbing' stamp: 'UC 6/19/2021 15:07:53'!
setLoginToFail

	^ loginWithSuccess := false! !


!StoreFacadeTest methodsFor: 'support' stamp: 'UC 6/19/2021 16:51:27'!
sampleCheckoutIn: store for: id

	^ store checkoutCart: id withCardNumber: testObjects validCardNumber expiring: testObjects notExpiredMonthOfYear ownedBy: testObjects validCardName! !

!StoreFacadeTest methodsFor: 'support' stamp: 'UC 6/20/2021 19:08:10'!
sampleStore
	^ self sampleStoreWithClock: GregorianDateTime ! !

!StoreFacadeTest methodsFor: 'support' stamp: 'UC 6/20/2021 18:49:14'!
sampleStoreWithClock: aClock
	^ StoreFacade with: self catalogue: testObjects defaultCatalogue merchantProcessor: MPSimulator answerWithOk clock: aClock! !


!StoreFacadeTest methodsFor: 'tests' stamp: 'UC 6/20/2021 19:24:10'!
setUp
	loginWithSuccess := true.
	isTheFuture := false.
	testObjects := StoreTestObjects new.! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'UC 6/20/2021 17:26:40'!
test01CreateCartWithInvalidClientIdOrPasswordRaisesError
	| store |
	
	self setLoginToFail.
	store := self sampleStore.
	self 
		should: [ 
			store createCartWithClientId: testObjects sampleClientId andPassword: testObjects samplePassword.
		]
		raise: Error
		withExceptionDo: [:error | self assert: StoreFacade invalidClientIdOrPassword equals: error messageText  ]	
	! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'UC 6/20/2021 17:27:42'!
test02ListCreatedCartReturnsEmptyCart
	| store id |
	store := self sampleStore.
	id := store createCartWithClientId: testObjects sampleClientId andPassword: testObjects samplePassword.
	self assert: (store listCart: id) isEmpty.
	! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'UC 6/20/2021 17:27:47'!
test03AddedItemToOneCartIsListedById
	| store id |
	store := self sampleStore.
	id := store createCartWithClientId: testObjects sampleClientId andPassword: testObjects samplePassword.
	store add: 1 of: testObjects itemSellByTheStore toCart: id.
	self assert: 1 equals: (store listCart: id) size.
	self assert: (store listCart: id) includes: testObjects itemSellByTheStore.
	! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'UC 6/20/2021 17:28:05'!
test04AddedItemsToMultipleCartsAreListedById
	| store cartId1 cartId2 |
	store := self sampleStore.
	cartId1 := store createCartWithClientId: testObjects sampleClientId andPassword: testObjects samplePassword.
	cartId2 := store createCartWithClientId: 'david' andPassword: 'yy'.
	
	store add: 2 of: testObjects itemSellByTheStore toCart: cartId1.
	store add: 2 of: testObjects itemSellByTheStore toCart: cartId2.
	
	self assert: 2 equals: (store listCart: cartId1) size.
	self assert: 2 equals: ((store listCart: cartId1) occurrencesOf: testObjects itemSellByTheStore).
	
	self assert: 2 equals: (store listCart: cartId2) size.
	self assert: 2 equals: ((store listCart: cartId2) occurrencesOf: testObjects itemSellByTheStore).
	! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'UC 6/19/2021 15:35:37'!
test05ListCartForAbsentCartIdRaisesError
	| store |
	store := self sampleStore.
	
	self should: [store listCart: 1]
	raise: Error
	withExceptionDo: [:error | self assert: StoreFacade cannotFindCartForThatId equals: error messageText ].
	! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'UC 6/19/2021 15:35:32'!
test06AddItemForAbsentCartIdRaisesError
	| store id |
	store := self sampleStore.
	
	self should: [store add: 1 of: testObjects itemSellByTheStore toCart: 1]
		raise: Error
		withExceptionDo: [:error | self assert: StoreFacade cannotFindCartForThatId equals: error messageText ].! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'UC 6/19/2021 16:51:49'!
test07CheckoutForAbsentCartIdRaisesError
	| store |
	store := self sampleStore.
	
	self should: [self sampleCheckoutIn: store for: 1]
		raise: Error
		withExceptionDo: [:error | self assert: StoreFacade cannotFindCartForThatId equals: error messageText ].! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'UC 6/20/2021 17:28:42'!
test08ListPurchasesForInvalidClientIdOrPasswordRaisesError
	| store |
	self setLoginToFail.
	store := self sampleStore.
	self should: [store listPurchasesFor: testObjects sampleClientId withPassword: testObjects samplePassword ] 
		raise: Error 
		withExceptionDo: [:error | self assert: StoreFacade invalidClientIdOrPassword equals: error messageText ]
	
	! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'UC 6/22/2021 21:50:32'!
test09ListPurchasesOfClientWithoutPurchasesReturnsValidTotal
	| store purchases |
	store := self sampleStore.
	purchases := (store listPurchasesFor: testObjects sampleClientId withPassword: testObjects samplePassword).
	self assert: 2 equals: purchases keys size.
	self assert: 0 equals: (purchases at: 'total').
	self assert: 0 equals: (purchases at: 'items') size.! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'UC 6/20/2021 17:29:22'!
test10ListPurchasesOfClientWithOnePurchaseReturnsTotalAndItems
	| store id purchases purchasedItems |
	store := self sampleStore.
	id := store createCartWithClientId:testObjects sampleClientId andPassword: testObjects samplePassword.
	store add: 1 of: testObjects itemSellByTheStore toCart: id.
	self sampleCheckoutIn: store for: id.
	purchases := store listPurchasesFor: testObjects sampleClientId withPassword: testObjects samplePassword.
	purchasedItems := purchases at: 'items'.
	
	self assert: 2 equals: purchases keys size.
	self assert: 100 equals: (purchases at: 'total').
	self assert: 1 equals: purchasedItems size.
	self assert: 1 equals: (purchasedItems occurrencesOf: testObjects itemSellByTheStore).
	! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'UC 6/20/2021 18:12:57'!
test11ListPurchasesOfClientWithManyPurchaseReturnsTotalAndItems
	| store id purchases purchasedItems |
	store := self sampleStore.
	id := store createCartWithClientId: testObjects sampleClientId andPassword: testObjects samplePassword.
	store add: 1 of: testObjects itemSellByTheStore toCart: id.
	self sampleCheckoutIn: store for: id.
	
	id := store createCartWithClientId: testObjects sampleClientId andPassword: testObjects samplePassword.
	store add: 1 of: testObjects itemSellByTheStore toCart: id.
	self sampleCheckoutIn: store for: id.
	
	purchases := store listPurchasesFor: testObjects sampleClientId withPassword: testObjects samplePassword.
	purchasedItems := (purchases at: 'items').
	self assert: 200 equals: (purchases at: 'total').
	self assert: 2 equals: purchasedItems size.
	self assert: 2 equals: (purchasedItems occurrencesOf: testObjects itemSellByTheStore ).
	! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'UC 6/20/2021 19:33:07'!
test12ListPurchasesOfClientInSalesbookWithManyClientsReturnsTotalAndItems
	| store id purchases purchasedItems |
	store := self sampleStore.
	id := store createCartWithClientId: 'uriel' andPassword: 'xx'.
	store add: 1 of: testObjects itemSellByTheStore toCart: id.
	self sampleCheckoutIn: store for: id.
	
	id := store createCartWithClientId: 'david' andPassword: 'xx'.
	store add: 1 of: testObjects itemSellByTheStore toCart: id.
	self sampleCheckoutIn: store for: id.
	
	purchases := store listPurchasesFor: 'uriel' withPassword: 'xx'.
	purchasedItems := (purchases at: 'items').
	self assert: 100 equals: (purchases at: 'total').
	self assert: 1 equals: purchasedItems size.
	self assert: 1 equals: (purchasedItems occurrencesOf: testObjects itemSellByTheStore ).

	purchases := store listPurchasesFor: 'david' withPassword: 'xx'.
	purchasedItems := (purchases at: 'items').
	self assert: 100 equals: (purchases at: 'total').
	self assert: 1 equals: purchasedItems size.
	self assert: 1 equals: (purchasedItems occurrencesOf: testObjects itemSellByTheStore ).	! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'UC 6/22/2021 21:50:51'!
test13CheckoutOfExpiredCartRaisesError
	| store id purchases |
	store := self sampleStoreWithClock: self.
	
	id := store createCartWithClientId: 'david' andPassword: 'xx'.
	store add: 1 of: testObjects itemSellByTheStore toCart: id.
	
	self setClockToFutureDate.
	self should: [self sampleCheckoutIn: store for: id.] 
		raise: Error
		withExceptionDo: [ :error | 
			self assert: StoreFacade cannotCheckoutCartAfter30minutes equals: error messageText.
		].
	purchases := (store listPurchasesFor: testObjects sampleClientId withPassword: testObjects samplePassword).
	self assert: 2 equals: purchases keys size.
	self assert: 0 equals: (purchases at: 'total').
	self assert: 0 equals: (purchases at: 'items') size.
	
	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items client creationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'assertions' stamp: 'DV 6/17/2021 13:45:43'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self class invalidItemErrorMessage]! !

!Cart methodsFor: 'assertions' stamp: 'DV 6/17/2021 13:40:39'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self class invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'UC 6/20/2021 18:59:20'!
initializeAcceptingItemsOf: aCatalog forClient: aClientId createdOn: aCreationDate  

	catalog := aCatalog.
	items := Bag new.
	client := aClientId.
	creationDate := aCreationDate.! !


!Cart methodsFor: 'queries' stamp: 'UC 6/19/2021 17:05:51'!
clear
	items := Bag new.
	^items! !

!Cart methodsFor: 'queries' stamp: 'UC 6/20/2021 17:33:05'!
client
	^client! !

!Cart methodsFor: 'queries' stamp: 'UC 6/20/2021 19:35:00'!
isExpiredOn: aDateTime
	^((creationDate distanceTo: aDateTime) convertTo: minute) > (30*minute)! !

!Cart methodsFor: 'queries' stamp: 'UC 6/19/2021 15:03:50'!
items
	^items copy! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'DV 6/10/2021 20:42:53'!
total
	^items sum: [:item| catalog at: item] ifEmpty: 0! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'UC 6/19/2021 17:04:45'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'UC 6/20/2021 18:59:03'!
acceptingItemsOf: aCatalog forClient: aClientId createdOn: aCreationDate  
	self assertCatalogueHasOnlyPositivePrices: aCatalog.
	^self new initializeAcceptingItemsOf: aCatalog forClient: aClientId createdOn: aCreationDate  ! !


!Cart class methodsFor: 'error messages' stamp: 'DV 6/17/2021 13:38:05'!
invalidCatalogueMessage
	
	^'El catalogo no debe contener precios con valores no positivos.'! !

!Cart class methodsFor: 'error messages' stamp: 'DV 6/17/2021 13:37:32'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'DV 6/17/2021 13:37:39'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart class methodsFor: 'assertions' stamp: 'DV 6/17/2021 13:48:54'!
assertCatalogueHasOnlyPositivePrices: aCatalogue
	aCatalogue do: [ :value | value strictlyPositive ifFalse:[self error: self invalidCatalogueMessage ]]

	 ! !


!classDefinition: #CashierPerSale category: 'TusLibros'!
Object subclass: #CashierPerSale
	instanceVariableNames: 'catalog items priceChart cart creditCard salesbook used merchantProcessor total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierPerSale methodsFor: 'initialization' stamp: 'DV 6/16/2021 18:43:10'!
initializeWith: aCart chargingTo: aCreditCard registeringOn: aSalesbook with: aMerchantProcessor

	cart := aCart.
	creditCard := aCreditCard. 
	salesbook := aSalesbook.
	merchantProcessor := aMerchantProcessor.
	used := false.! !


!CashierPerSale methodsFor: 'checkout' stamp: 'DV 6/16/2021 16:15:37'!
assertHasNotBeenUsedBefore.
	used ifTrue:[self error: self class cannotCheckoutTwice]! !

!CashierPerSale methodsFor: 'checkout' stamp: 'UC 6/20/2021 19:01:34'!
checkout
	self assertHasNotBeenUsedBefore.
	
	total := cart total.
	merchantProcessor charge: total on: creditCard.
	
	^self registerEndOfCheckout.
! !

!CashierPerSale methodsFor: 'checkout' stamp: 'DV 6/24/2021 14:52:15'!
registerEndOfCheckout
	| saleReceipt |
	used := true.
	saleReceipt:= (SaleReceipt for: total withItems: cart items forClient: cart client).
	salesbook add: saleReceipt.
	cart clear.
	^saleReceipt! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CashierPerSale class' category: 'TusLibros'!
CashierPerSale class
	instanceVariableNames: ''!

!CashierPerSale class methodsFor: 'instance creation' stamp: 'DV 6/16/2021 18:42:22'!
forCheckoutWith: aCart chargingTo: aCreditCard onDate: aDate registeringOn:aSalesbook with: aMerchantProcessor 
	self assertACartIsNotEmpty: aCart.
	self assertCardDateIsNotExpired: aCreditCard onDate: aDate.
	
	^ self new initializeWith: aCart chargingTo: aCreditCard registeringOn: aSalesbook with: aMerchantProcessor.! !


!CashierPerSale class methodsFor: 'error' stamp: 'DV 6/10/2021 20:18:19'!
cannotCheckoutEmptyCart
	^'No se puede facturar un carrito vacio'.! !

!CashierPerSale class methodsFor: 'error' stamp: 'DV 6/16/2021 16:13:20'!
cannotCheckoutTwice
	^'El cajero por venta se puede usar solo una vez'.! !

!CashierPerSale class methodsFor: 'error' stamp: 'DV 6/13/2021 14:49:27'!
cannotCheckoutWithExpiredCard
	^'No se puede facturar una tarjeta vencida'.! !


!CashierPerSale class methodsFor: 'assertions' stamp: 'DV 6/16/2021 13:35:10'!
assertACartIsNotEmpty: aCart

	aCart isEmpty ifTrue:[self error: self cannotCheckoutEmptyCart]! !

!CashierPerSale class methodsFor: 'assertions' stamp: 'UC 6/20/2021 19:20:51'!
assertCardDateIsNotExpired: aCard onDate: aDate
	| monthOfYear |
	monthOfYear:= aDate monthOfYear.
	(aCard isExpiredOn: monthOfYear) ifTrue: [self error: self cannotCheckoutWithExpiredCard]! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'name number date'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'DV 6/14/2021 11:10:19'!
initializeWithName: aName withNumber: aNumber withDate: aDate 
	name := aName.
	number := aNumber.
	date := aDate.! !


!CreditCard methodsFor: 'accessing' stamp: 'DV 6/14/2021 12:13:13'!
date
	^date! !

!CreditCard methodsFor: 'accessing' stamp: 'DV 6/14/2021 17:46:14'!
isExpiredOn: aMonthOfYear
	^(date < aMonthOfYear)! !

!CreditCard methodsFor: 'accessing' stamp: 'DV 6/14/2021 11:10:49'!
name 
	^name! !

!CreditCard methodsFor: 'accessing' stamp: 'DV 6/14/2021 12:12:58'!
number
	^number! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'DV 6/16/2021 15:20:42'!
withName: aName withNumber: aNumber withExpirationDate: aDate
	self assertCardNameIsNotEmptyAndNotLongerThan30Characters: aName.
	self assertCardNumberSizeis16Digits: aNumber.
	^self new initializeWithName: aName withNumber: aNumber withDate: aDate.! !


!CreditCard class methodsFor: 'error messages' stamp: 'DV 6/16/2021 14:30:55'!
invalidNameErrorMessage
	^'El nombre debe contener como máximo 30 caracteres y no ser vacío.'! !

!CreditCard class methodsFor: 'error messages' stamp: 'DV 6/14/2021 11:40:55'!
invalidNumberErrorMessage
	^'El número de tarjeta debe ser un NÚMERO con 16 dígitos.'! !


!CreditCard class methodsFor: 'assertions' stamp: 'DV 6/16/2021 14:44:51'!
assertCardNameIsNotEmpty:aName
	(aName withBlanksTrimmed isEmpty) ifTrue: [self error: self invalidNameErrorMessage]! !

!CreditCard class methodsFor: 'assertions' stamp: 'DV 6/16/2021 15:20:42'!
assertCardNameIsNotEmptyAndNotLongerThan30Characters: aName
	self assertCardNameIsNotEmpty:aName.
	self assertCardNameIsNotLongerThan30Characters: aName.! !

!CreditCard class methodsFor: 'assertions' stamp: 'DV 6/16/2021 14:44:36'!
assertCardNameIsNotLongerThan30Characters: aName

	(aName size > 30) ifTrue: [self error: self invalidNameErrorMessage]! !

!CreditCard class methodsFor: 'assertions' stamp: 'DV 6/16/2021 15:16:56'!
assertCardNumberSizeis16Digits: aNumber
	((aNumber numberOfDigitsInBase: 10) ~= 16) ifTrue: [self error: self invalidNumberErrorMessage]! !


!classDefinition: #ListPurchases category: 'TusLibros'!
Object subclass: #ListPurchases
	instanceVariableNames: 'salesBook client purchases accumulatedItems total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ListPurchases methodsFor: 'as yet unclassified' stamp: 'UC 6/23/2021 18:08:32'!
accumulateSale: aSale

	^ (aSale isForClient: client) ifTrue: [
			total := aSale addTotalTo: total.
			aSale addAllItemsTo: accumulatedItems.
		]! !

!ListPurchases methodsFor: 'as yet unclassified' stamp: 'UC 6/23/2021 18:10:07'!
compute
	
	accumulatedItems := Bag new.
	total := 0.
	
	salesBook do: [:aSale |
		self accumulateSale: aSale
	].

	^self createPurchasesDictionary.
	! !

!ListPurchases methodsFor: 'as yet unclassified' stamp: 'UC 6/23/2021 18:10:14'!
createPurchasesDictionary

	purchases := Dictionary new.
	purchases at: 'total' put: total.
	purchases at: 'items' put: accumulatedItems.
	^purchases! !

!ListPurchases methodsFor: 'as yet unclassified' stamp: 'UC 6/23/2021 18:05:43'!
initializeFor: aClientId with: aSalesBook
	client := aClientId.
	salesBook := aSalesBook.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ListPurchases class' category: 'TusLibros'!
ListPurchases class
	instanceVariableNames: ''!

!ListPurchases class methodsFor: 'as yet unclassified' stamp: 'UC 6/23/2021 18:05:15'!
for: aClientId with: aSalesBook
	^self new initializeFor: aClientId with: aSalesBook! !


!classDefinition: #MPSimulator category: 'TusLibros'!
Object subclass: #MPSimulator
	instanceVariableNames: 'stolenCards answerOk answerFake errorMessage'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!
!MPSimulator commentStamp: '<historical>' prior: 0!
Merchant Procesor Simulator!


!MPSimulator methodsFor: 'operations' stamp: 'UC 6/17/2021 20:41:32'!
charge: anAmount on: aCreditCard
	answerOk ifFalse: [ self error: self class errorProcessingPayment].! !


!MPSimulator methodsFor: 'initialization' stamp: 'UC 6/17/2021 20:40:44'!
initializeWithError
	answerOk := false! !

!MPSimulator methodsFor: 'initialization' stamp: 'UC 6/16/2021 20:27:50'!
initializeWithOk
	answerOk := true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MPSimulator class' category: 'TusLibros'!
MPSimulator class
	instanceVariableNames: ''!

!MPSimulator class methodsFor: 'instance creation' stamp: 'UC 6/17/2021 20:40:25'!
answerWithError
	^ self new initializeWithError! !

!MPSimulator class methodsFor: 'instance creation' stamp: 'DV 6/16/2021 18:40:32'!
answerWithOk
	^ self new initializeWithOk! !


!MPSimulator class methodsFor: 'error messages' stamp: 'UC 6/17/2021 20:42:27'!
errorProcessingPayment
	^'Hubo un error procesando el pago con su tarjeta'.! !


!classDefinition: #SaleReceipt category: 'TusLibros'!
Object subclass: #SaleReceipt
	instanceVariableNames: 'total items client id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SaleReceipt methodsFor: 'initialization' stamp: 'DV 6/24/2021 13:41:40'!
initializeFor: aTotal withItems: anItemList forClient: aClient withId: anId
	total := aTotal.
	items := anItemList.
	client := aClient.
	id:= anId! !


!SaleReceipt methodsFor: 'accessing' stamp: 'UC 6/22/2021 21:47:44'!
addAllItemsTo: aBag
	^aBag addAll: items.! !

!SaleReceipt methodsFor: 'accessing' stamp: 'UC 6/22/2021 21:48:11'!
addTotalTo: aNumber
	^aNumber + total.
	! !

!SaleReceipt methodsFor: 'accessing' stamp: 'DV 6/24/2021 13:42:14'!
id
	^id! !

!SaleReceipt methodsFor: 'accessing' stamp: 'UC 6/22/2021 21:46:06'!
isForClient: aClientId
	^client = aClientId ! !

!SaleReceipt methodsFor: 'accessing' stamp: 'UC 6/19/2021 16:40:43'!
total
	^total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SaleReceipt class' category: 'TusLibros'!
SaleReceipt class
	instanceVariableNames: 'uniqueId'!

!SaleReceipt class methodsFor: 'instance creation' stamp: 'DV 6/24/2021 13:39:07'!
for: aTotal withItems: anItemList forClient: aClient  
	self incrementIdCounter.
	^self new initializeFor: aTotal withItems: anItemList forClient: aClient withId: uniqueId! !

!SaleReceipt class methodsFor: 'instance creation' stamp: 'DV 6/24/2021 13:40:33'!
incrementIdCounter
	uniqueId ifNil: [uniqueId :=0].			
	uniqueId:= uniqueId +1.! !


!classDefinition: #StoreFacade category: 'TusLibros'!
Object subclass: #StoreFacade
	instanceVariableNames: 'clientAuthenticator catalogue carts cartId salesBook merchantProcessor clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreFacade methodsFor: 'initialize' stamp: 'DV 6/24/2021 14:54:27'!
initializeWith: aClientAuthenticator catalogue: aCatalogue merchantProcessor: aMerchantProcessor clock: aClock  
	clientAuthenticator := aClientAuthenticator.
	catalogue := aCatalogue.
	cartId := 0.
	carts := Dictionary new.
	salesBook := OrderedCollection new.
	merchantProcessor := aMerchantProcessor.
	clock := aClock.! !


!StoreFacade methodsFor: 'assertions' stamp: 'DV 6/24/2021 11:37:33'!
assertIsNotExpired: cart

	^ (cart isExpiredOn: clock now) ifTrue: [ self error: self class cannotCheckoutCartAfter30minutes ]! !


!StoreFacade methodsFor: 'interface' stamp: 'UC 6/19/2021 15:25:11'!
add: anAmount of: anItem toCart: aCartId 
	(self findCartById: aCartId) add: anAmount of: anItem.
	! !

!StoreFacade methodsFor: 'interface' stamp: 'DV 6/24/2021 15:07:42'!
checkoutCart: aCartId withCardNumber: aCardNumber expiring: anExpirationMonthOfYear ownedBy: anOwnerName
	| cart creditCard |
	
	cart := self findCartById: aCartId.
	
	self assertIsNotExpired: cart.
	
	creditCard := CreditCard 
		withName:  anOwnerName 
		withNumber:  aCardNumber 
		withExpirationDate: anExpirationMonthOfYear.
	^(CashierPerSale 
			forCheckoutWith:  cart
			chargingTo:  creditCard
			onDate:  clock now
			registeringOn:  salesBook
			with: merchantProcessor) checkout.
	
	
	! !

!StoreFacade methodsFor: 'interface' stamp: 'UC 6/20/2021 19:16:25'!
createCartWithClientId: aClientId andPassword: aPassword
	clientAuthenticator login: aClientId with: aPassword.
	cartId := cartId + 1.
	carts at: cartId put: (Cart acceptingItemsOf: catalogue forClient: aClientId createdOn: clock now).
	^cartId! !

!StoreFacade methodsFor: 'interface' stamp: 'UC 6/19/2021 15:24:54'!
listCart: aCartId 
	^(self findCartById: aCartId) items.! !

!StoreFacade methodsFor: 'interface' stamp: 'UC 6/23/2021 18:06:19'!
listPurchasesFor: aClientId withPassword: aPassword 
	
	clientAuthenticator login: aClientId with: aPassword.
	^(ListPurchases for: aClientId with: salesBook) compute! !


!StoreFacade methodsFor: 'interface - private' stamp: 'UC 6/19/2021 15:24:54'!
findCartById: aCartId

	^ carts at: aCartId ifAbsent: [self error: self class cannotFindCartForThatId ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StoreFacade class' category: 'TusLibros'!
StoreFacade class
	instanceVariableNames: ''!

!StoreFacade class methodsFor: 'error messages' stamp: 'UC 6/20/2021 19:03:15'!
cannotCheckoutCartAfter30minutes
	^'No se puede facturar un carrito después de 30 minutos de crearlo'! !

!StoreFacade class methodsFor: 'error messages' stamp: 'UC 6/19/2021 15:21:53'!
cannotFindCartForThatId
	^'No se encontró un carrito activo para ese Id'! !

!StoreFacade class methodsFor: 'error messages' stamp: 'UC 6/17/2021 20:55:12'!
invalidClientIdOrPassword
	^'Contraseña o id de cliente inválido. Porfavor, intente de nuevo'! !


!StoreFacade class methodsFor: 'instance creation' stamp: 'UC 6/20/2021 18:49:43'!
with: aClientAuthenticator catalogue: aCatalogue merchantProcessor: aMerchantProcessor clock: aClock  
	^self new initializeWith: aClientAuthenticator catalogue: aCatalogue merchantProcessor: aMerchantProcessor clock: aClock.! !


!classDefinition: #StoreTestObjects category: 'TusLibros'!
Object subclass: #StoreTestObjects
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!
!StoreTestObjects commentStamp: '<historical>' prior: 0!
Simulador del Merchant Procesor!


!StoreTestObjects methodsFor: 'cart' stamp: 'UC 6/16/2021 23:02:52'!
defaultCatalogue
	| dict |
	dict:=  Dictionary new.
	dict at: self itemSellByTheStore put: self itemSellByTheStorePrice.
	^dict! !

!StoreTestObjects methodsFor: 'cart' stamp: 'UC 6/20/2021 18:57:20'!
emptyCartWithDefaultCatalogue
	^Cart acceptingItemsOf: self defaultCatalogue forClient: self sampleClientId createdOn: DateAndTime today! !

!StoreTestObjects methodsFor: 'cart' stamp: 'UC 6/16/2021 23:03:18'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjects methodsFor: 'cart' stamp: 'UC 6/16/2021 23:03:21'!
itemSellByTheStorePrice
	
	^ 100! !


!StoreTestObjects methodsFor: 'dates' stamp: 'UC 6/16/2021 23:03:14'!
expiredMonthOfYear
	^GregorianMonthOfYear yearNumber: (Date today yearNumber) - 5 monthNumber: (Date today month monthIndex)! !

!StoreTestObjects methodsFor: 'dates' stamp: 'UC 6/16/2021 23:03:26'!
notExpiredMonthOfYear
	^GregorianMonthOfYear yearNumber: (Date today yearNumber) + 5 monthNumber: (Date today month monthIndex)! !


!StoreTestObjects methodsFor: 'card' stamp: 'UC 6/20/2021 17:26:26'!
sampleClientId
	^ 'davidYUriel'! !

!StoreTestObjects methodsFor: 'card' stamp: 'UC 6/20/2021 17:27:14'!
samplePassword
	
	^ 'EstaEsUnaContraseñaBienDivertid@'! !

!StoreTestObjects methodsFor: 'card' stamp: 'UC 6/16/2021 23:03:35'!
validCardName
	^ 'Simón Bolívar'! !

!StoreTestObjects methodsFor: 'card' stamp: 'UC 6/16/2021 23:03:41'!
validCardNumber
	^5555555555554444 ! !

!StoreTestObjects methodsFor: 'card' stamp: 'UC 6/16/2021 23:03:45'!
validCreditCard
	
	^ CreditCard withName: self validCardName withNumber: self validCardNumber withExpirationDate: self notExpiredMonthOfYear ! !
