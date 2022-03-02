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

!CashierTest methodsFor: 'tests' stamp: 'CR 12/2/2020 23:50:27'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			through: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'CR 12/2/2020 23:50:31'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		through: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'CR 12/2/2020 23:50:35'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				through: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'CR 12/2/2020 23:50:39'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		through: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'CR 12/2/2020 23:50:42'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		through: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'CR 12/2/2020 23:50:47'!
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
		through: self
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


!classDefinition: #RestInterfaceTest category: 'TusLibros'!
TestCase subclass: #RestInterfaceTest
	instanceVariableNames: 'testObjectFactory aClientID'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceTest methodsFor: 'checking out' stamp: 'CR 12/3/2020 11:56:37'!
test07CannotCheckOutUnknownCart

	| interface |
	interface := testObjectFactory defaultRestInterface.
	interface createCartForClient:  testObjectFactory defaultCardOwner withPassword: 'defaultPassword'. 
	"
	self should: [ interface checkout: (testObjectFactory createCart) withCreditCard: (testObjectFactory notExpiredCreditCard ) for: (testObjectFactory defaultCardOwner) ]
	raise: Error 
	withMessageText: RestInterface unknownCartErrorMessage.
	"
	
	self should: [ interface checkout: (testObjectFactory createCart) withCreditCard: (testObjectFactory notExpiredCreditCard ) for: (testObjectFactory defaultCardOwner)]
	raise: Error 
	withExceptionDo: [:anError | | clientPurchases |
		clientPurchases := interface listPurchases: (testObjectFactory defaultCardOwner) withPassword: 'defaultPassword'.
		self assert: clientPurchases = 'No purchases'. 
		self assert: anError messageText = RestInterface unknownCartErrorMessage.
		].
	
	
				! !

!RestInterfaceTest methodsFor: 'checking out' stamp: 'CR 12/3/2020 09:05:36'!
test08CannotCheckOutEmptyCart

	| interface cartID  |
	interface := testObjectFactory defaultRestInterface.
	
	cartID := interface createCartForClient: 'aClientID'  withPassword: 'passwordOfClientWhoIsCreatingACart'.
	
	self should: [interface checkout: cartID withCreditCard: (testObjectFactory notExpiredCreditCard ) for: 'aClientID'.] 
	raise: Error
	withExceptionDo: [:anError | | clientPurchases |
		clientPurchases := interface listPurchases: 'aClientID' withPassword: 'passwordOfClientWhoIsCreatingACart'.
		self assert: clientPurchases = 'No purchases'. 
		self assert: anError messageText = RestInterface cannotCheckOutEmptyCart.
		].! !

!RestInterfaceTest methodsFor: 'checking out' stamp: 'BT 12/3/2020 14:52:06'!
test10CheckOutValidCartWorksCorrectly

	| interface cartID itemToAdd clientPurchases purchase |
	interface := testObjectFactory defaultRestInterface.
	
	purchase := '(''validBook''->1 ) Total spent = 10'.
	cartID := interface createCartForClient: 'aClientID'  withPassword: 'passwordOfClientWhoIsCreatingACart'.
	itemToAdd := testObjectFactory itemSellByTheStore.
	interface addToCart: cartID bookISBN: itemToAdd bookQuantity: 1. 
	
	interface checkout: cartID withCreditCard: (testObjectFactory notExpiredCreditCard ) for: 'aClientID'.
	clientPurchases := interface listPurchases: 'aClientID' withPassword: 'passwordOfClientWhoIsCreatingACart'.
	self assert: purchase = clientPurchases.
				! !

!RestInterfaceTest methodsFor: 'checking out' stamp: 'BT 12/3/2020 14:52:06'!
test11TransactionIDOfCheckOutIsUnique

	| interface itemToAdd cartIDOwnedByBelen cartIDOwnedByCeleste transactionIDCeleste transactionIDBelen |
	interface := testObjectFactory defaultRestInterface.
	
	cartIDOwnedByCeleste := interface createCartForClient: 'Celeste'  withPassword: 'celeste123'.
	cartIDOwnedByBelen := interface createCartForClient: 'Belen'  withPassword: 'belen123'.
	itemToAdd := testObjectFactory itemSellByTheStore.
	interface addToCart: cartIDOwnedByCeleste bookISBN: itemToAdd bookQuantity: 1. 
	interface addToCart: cartIDOwnedByBelen bookISBN: itemToAdd bookQuantity: 1. 
	
	transactionIDCeleste := interface checkout: cartIDOwnedByCeleste withCreditCard: (testObjectFactory notExpiredCreditCard ) for: 'Celeste'.
	transactionIDBelen := interface checkout: cartIDOwnedByBelen withCreditCard: (testObjectFactory notExpiredCreditCard ) for: 'Belen'.
	
	self deny: transactionIDCeleste = transactionIDBelen. 
	
	
	
	
				! !


!RestInterfaceTest methodsFor: 'time expiration' stamp: 'BT 12/3/2020 14:52:06'!
test13WhenTimePassesCantInteractWithCart

	| interface cartID itemToAdd clock supermarket |
	clock := Clock new.
	supermarket := testObjectFactory defaultSupermarket .
	
	interface := RestInterface for: supermarket withAuthenticator: (testObjectFactory defaultAuthenticator) collaborateWithClock: clock.
	cartID := interface createCartForClient: 'aClientID'  withPassword: 'passwordOfClientWhoIsCreatingACart'.
	
	itemToAdd := testObjectFactory itemSellByTheStore.
	interface addToCart: cartID bookISBN: itemToAdd bookQuantity: 1. 
	
	clock passMinutes: 34.
	
	self should: [interface checkout: cartID withCreditCard: (testObjectFactory notExpiredCreditCard ) for: 'aClientID'.]
	raise: Error
	withExceptionDo: [:anError | | clientPurchases |
		clientPurchases := interface listPurchases: 'aClientID' withPassword: 'passwordOfClientWhoIsCreatingACart'.
		self assert: clientPurchases = 'No purchases'. 
		self assert: anError messageText = RestInterface cartExpiredErrorDescription.
		self deny: (supermarket hasCart: cartID).
		].
	! !


!RestInterfaceTest methodsFor: 'cart creation' stamp: 'BT 12/3/2020 14:48:14'!
test01NewCartsCreatedAreEmpty

	| interface cartID |
	interface := testObjectFactory defaultRestInterface.
	
	cartID := interface createCartForClient: 'aClientID'  withPassword: 'passwordOfClientWhoIsCreatingACart'.
	
	self assert: (interface listCart: cartID) isEmpty.
				! !

!RestInterfaceTest methodsFor: 'cart creation' stamp: 'CR 12/3/2020 11:16:25'!
test02UserIsAuthenticatedWhenCreatesANewCart
	| interface |
	interface := RestInterface for: testObjectFactory defaultSupermarket withAuthenticator: (testObjectFactory invalidClientAuthenticator) collaborateWithClock: Clock new.

	self should: [interface createCartForClient: 'aClientID'  withPassword: 'anInvalidPassword'.]
	 raise: Error 
	 withMessageText: RestInterface invalidClientErrorDescription.
				! !


!RestInterfaceTest methodsFor: 'adding books to cart' stamp: 'BT 12/3/2020 14:52:06'!
test03CannotAddABookToAnUnknownCart

	| interface |
	interface := testObjectFactory defaultRestInterface.
	
	self should: [ interface addToCart: (testObjectFactory createCart ) bookISBN: (testObjectFactory itemSellByTheStore) bookQuantity: 1]
	raise: Error 
	withMessageText: RestInterface unknownCartErrorMessage.
				! !

!RestInterfaceTest methodsFor: 'adding books to cart' stamp: 'BT 12/3/2020 14:52:05'!
test04AddingABookToACreatedCartWorksCorrectly

	| interface cartID itemToAdd itemsListOfCart |
	interface := testObjectFactory defaultRestInterface.
	
	cartID := interface createCartForClient: 'aClientID'  withPassword: 'passwordOfClientWhoIsCreatingACart'.
	itemToAdd := testObjectFactory itemSellByTheStore.
	interface addToCart: cartID bookISBN: itemToAdd bookQuantity: 1. 
	
	itemsListOfCart := interface listCart: cartID.
	
	self assert: itemsListOfCart size = 1.
	self assert: (itemsListOfCart occurrencesOf: itemToAdd) = 1.
				! !

!RestInterfaceTest methodsFor: 'adding books to cart' stamp: 'BT 12/3/2020 14:51:40'!
test14CannotAddAnInvalidBookToACreatedCart

	| interface cartID invalidBookToAdd |
	interface := testObjectFactory defaultRestInterface.
	
	cartID := interface createCartForClient: 'aClientID'  withPassword: 'passwordOfClientWhoIsCreatingACart'.
	invalidBookToAdd := testObjectFactory itemNotSellByTheStore.
	
	self should: [ interface addToCart: cartID bookISBN: invalidBookToAdd bookQuantity: 1]
	raise: Error 			
	withMessageText: RestInterface invalidBookAddToCartErrorMessage.
	
	self assert: (interface listCart: cartID) isEmpty.
				! !

!RestInterfaceTest methodsFor: 'adding books to cart' stamp: 'BT 12/3/2020 15:01:59'!
test15CannotAddAnInvalidBookQuantityToACreatedCart

	| interface cartID bookToAdd |
	interface := testObjectFactory defaultRestInterface.
	
	cartID := interface createCartForClient: 'aClientID'  withPassword: 'passwordOfClientWhoIsCreatingACart'.
	bookToAdd := testObjectFactory itemSellByTheStore.
	
	self should: [ interface addToCart: cartID bookISBN: bookToAdd bookQuantity: 0]
	raise: Error 			
	withMessageText: RestInterface invalidQuantityOfBookErrorMessage.
	
	self assert: (interface listCart: cartID) isEmpty.
				! !


!RestInterfaceTest methodsFor: 'listing items of cart' stamp: 'CR 12/3/2020 09:05:20'!
test05CannotListItemsOfAnInvalidCart

	| interface |
	interface := testObjectFactory defaultRestInterface.
	
	self should: [ interface listCart: (testObjectFactory createCart)]
	raise: Error 
	withMessageText: RestInterface unknownCartErrorMessage.
	
	
				! !

!RestInterfaceTest methodsFor: 'listing items of cart' stamp: 'BT 12/3/2020 15:08:29'!
test06ListItemsOfValidCartWorksCorrectly

	| interface cartID itemToAdd |
	interface := testObjectFactory defaultRestInterface.
	
	cartID := interface createCartForClient: 'aClientID'  withPassword: 'passwordOfClientWhoIsCreatingACart'.
	itemToAdd := testObjectFactory itemSellByTheStore.
	interface addToCart: cartID bookISBN: itemToAdd bookQuantity: 1. 
	
	self assert: (interface listCart: cartID) includes: itemToAdd.				! !


!RestInterfaceTest methodsFor: 'listing purchases' stamp: 'CR 12/3/2020 11:17:06'!
test09UserIsAuthenticatedWhenListingPurchases
	| interface |
	interface := RestInterface for: testObjectFactory defaultSupermarket withAuthenticator: (testObjectFactory invalidClientAuthenticator) collaborateWithClock: Clock new.
	
	self should: [interface listPurchases: 'aClientID' withPassword: 'anInvalidPassword'.]
	 raise: Error 
	 withMessageText: RestInterface invalidClientErrorDescription.
				! !

!RestInterfaceTest methodsFor: 'listing purchases' stamp: 'BT 12/3/2020 14:52:06'!
test12PurchasesForClientWhoDidNotCheckOutIsEmpty

	| interface cartID itemToAdd clientPurchases |
	interface := testObjectFactory defaultRestInterface.
	
	cartID := interface createCartForClient: 'aClientID'  withPassword: 'passwordOfClientWhoIsCreatingACart'.
	itemToAdd := testObjectFactory itemSellByTheStore.
	interface addToCart: cartID bookISBN: itemToAdd bookQuantity: 1. 
	
	clientPurchases := interface listPurchases: 'aClientID' withPassword: 'passwordOfClientWhoIsCreatingACart'.
	self assert: 'No purchases' = clientPurchases.
				! !


!RestInterfaceTest methodsFor: 'setup' stamp: 'BT 12/2/2020 10:39:21'!
setUp
	testObjectFactory := StoreTestObjectsFactory new.
	
	! !


!classDefinition: #AuthenticatorSimulator category: 'TusLibros'!
Object subclass: #AuthenticatorSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!AuthenticatorSimulator methodsFor: 'authenticate' stamp: 'BT 12/2/2020 11:47:14'!
authenticateUser: aUserToAunthenticate withPassword: aPassword 
	^ self subclassResponsibility.! !


!classDefinition: #AuthenticatorSimulatorOfInvalidClients category: 'TusLibros'!
AuthenticatorSimulator subclass: #AuthenticatorSimulatorOfInvalidClients
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!AuthenticatorSimulatorOfInvalidClients methodsFor: 'authenticate' stamp: 'BT 12/2/2020 11:39:08'!
authenticateUser: aUserToAunthenticate withPassword: aPassword 
	^ false! !


!classDefinition: #AuthenticatorSimulatorOfValidClients category: 'TusLibros'!
AuthenticatorSimulator subclass: #AuthenticatorSimulatorOfValidClients
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!AuthenticatorSimulatorOfValidClients methodsFor: 'authenticate' stamp: 'BT 12/2/2020 11:39:16'!
authenticateUser: aUserToAunthenticate withPassword: aPassword 
	^ true! !


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


!Cart methodsFor: 'initialization' stamp: 'CR 12/3/2020 10:07:12'!
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


!Cart methodsFor: 'user interface' stamp: 'BT 12/2/2020 10:56:32'!
listItems
	^ items asBag.! !

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

!Cashier methodsFor: 'checkout - private' stamp: 'CR 12/3/2020 00:13:02'!
createSale

	^ Sale of: total with: cart listItems.
 ! !

!Cashier methodsFor: 'checkout - private' stamp: 'CR 12/3/2020 00:23:54'!
debitTotal
	
	^ merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'CR 12/3/2020 00:20:32'!
checkOut

	self calculateTotal.
	self registerSale.
	^ self debitTotal.! !


!Cashier methodsFor: 'initialization' stamp: 'CR 12/2/2020 23:49:57'!
initializeToCheckout: aCart charging: aCreditCard through: aMerchantProcessor registeringOn: aSalesBook
	
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


!Cashier class methodsFor: 'instance creation' stamp: 'CR 12/2/2020 23:50:10'!
toCheckout: aCart charging: aCreditCard through: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard through: aMerchantProcessor registeringOn: aSalesBook! !


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
	instanceVariableNames: 'offset'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'accessing' stamp: 'CR 12/3/2020 10:51:41'!
distanceTo: aTime
	^(self now - aTime) minutes.! !

!Clock methodsFor: 'accessing' stamp: 'CR 12/3/2020 11:20:57'!
now
	^ (DateAndTime now) + offset.! !

!Clock methodsFor: 'accessing' stamp: 'CR 12/3/2020 10:39:13'!
passMinutes: minutesToPassBy
	offset := offset + (Duration minutes: minutesToPassBy).! !


!Clock methodsFor: 'initialization' stamp: 'CR 12/3/2020 11:24:16'!
initialize
	offset := Duration minutes: 0.! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration owner number'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'CR 12/3/2020 09:00:41'!
initializeExpiringOn: aMonth owner: ownerName number: cardNumber
	
	expiration := aMonth.
	owner := ownerName.
	number := cardNumber.! !

!CreditCard methodsFor: 'initialization' stamp: 'CR 12/3/2020 11:58:07'!
isCardNumber: aCardNumber
	^ number = aCardNumber! !

!CreditCard methodsFor: 'initialization' stamp: 'CR 12/3/2020 11:57:45'!
isOwner: aClient
	^ owner = aClient! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'CR 12/3/2020 09:15:47'!
expiringOn: aMonth owner: cardOwner number: cardNumber.
	
	^self new initializeExpiringOn: aMonth owner: cardOwner number: cardNumber.! !


!classDefinition: #MerchantProcessor category: 'TusLibros'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'credit card transaction' stamp: 'CR 12/3/2020 08:46:08'!
debit: amount from: creditCard
	self subclassResponsibility.! !


!classDefinition: #MPInvalidTransaction category: 'TusLibros'!
MerchantProcessor subclass: #MPInvalidTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MPInvalidTransaction methodsFor: 'credit card transaction' stamp: 'CR 12/3/2020 00:06:58'!
debit: amount from: creditCard
	self error: self class invalidTransaction.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MPInvalidTransaction class' category: 'TusLibros'!
MPInvalidTransaction class
	instanceVariableNames: ''!

!MPInvalidTransaction class methodsFor: 'error messages' stamp: 'CR 12/3/2020 00:07:17'!
invalidTransaction
	^'Invalid transaction!!'! !


!classDefinition: #MPValidTransaction category: 'TusLibros'!
MerchantProcessor subclass: #MPValidTransaction
	instanceVariableNames: 'transactionID'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MPValidTransaction methodsFor: 'initialization' stamp: 'CR 12/3/2020 00:26:15'!
initialize
	transactionID := 0. ! !


!MPValidTransaction methodsFor: 'credit card transaction' stamp: 'CR 12/3/2020 08:47:37'!
debit: amount from: creditCard
	transactionID := transactionID + 1.
	^ transactionID. ! !


!classDefinition: #RestInterface category: 'TusLibros'!
Object subclass: #RestInterface
	instanceVariableNames: 'supermarket authenticator cartsByClient timestamps clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterface methodsFor: 'authentication' stamp: 'BT 12/2/2020 11:42:44'!
validateUser: aUserToAuthenticate withPassword: aPassword
	(authenticator authenticateUser: aUserToAuthenticate withPassword: aPassword) ifFalse: [self error: self class invalidClientErrorDescription].
	! !


!RestInterface methodsFor: 'create cart private' stamp: 'CR 12/3/2020 11:01:00'!
assignNewCart: newCartID toClient: aClientID

	(cartsByClient at: aClientID ifAbsentPut: [OrderedCollection new]) add: newCartID.
	timestamps at: newCartID put: clock now. ! !


!RestInterface methodsFor: 'signals' stamp: 'CR 12/3/2020 10:59:41'!
signalCartExpired
	^ self error: self class cartExpiredErrorDescription.! !

!RestInterface methodsFor: 'signals' stamp: 'CR 12/3/2020 09:35:18'!
signalInvalidClient

	^ self error: self class invalidClientErrorDescription! !

!RestInterface methodsFor: 'signals' stamp: 'CR 12/3/2020 09:37:04'!
signalUnknownCart

	^ self error: self class unknownCartErrorMessage! !


!RestInterface methodsFor: 'verification' stamp: 'CR 12/3/2020 12:23:22'!
removeCartFromActives: aCartID
	cartsByClient associationsDo: [: association | | cartsOfSomeClient someClientID |
		cartsOfSomeClient := association value.
		someClientID := association key.
		(cartsOfSomeClient includes: aCartID) 
			ifTrue: [(cartsByClient at: someClientID ) remove: aCartID]].
	timestamps removeKey: aCartID.
	supermarket removeCart: aCartID.! !

!RestInterface methodsFor: 'verification' stamp: 'CR 12/3/2020 09:38:10'!
verifyCart: aCartToCheckOut isAssignedTo: clientID

	^ ((cartsByClient at: clientID) includes: aCartToCheckOut) ifFalse: [self signalUnknownCart ]! !

!RestInterface methodsFor: 'verification' stamp: 'CR 12/3/2020 11:41:22'!
verifyCartExists: aCartID
	(supermarket hasCart: aCartID) ifFalse: [self signalUnknownCart].! !

!RestInterface methodsFor: 'verification' stamp: 'CR 12/3/2020 12:20:39'!
verifyCartStillActive: aCartID
	| timeSinceLastInteractionInMinutes |
	timeSinceLastInteractionInMinutes := clock distanceTo: (timestamps at: aCartID).
	(timeSinceLastInteractionInMinutes > 30) 
		ifTrue: [
			self removeCartFromActives: aCartID.
			self signalCartExpired.] 
		ifFalse: [
			timestamps at: aCartID put: clock now.
			].! !

!RestInterface methodsFor: 'verification' stamp: 'CR 12/3/2020 09:43:24'!
verifyClientExists: clientID andCartIsAssignedToHim: aCartToCheckOut

	cartsByClient at: clientID ifAbsent: [self signalInvalidClient].
	self verifyCart:  aCartToCheckOut isAssignedTo: clientID.! !


!RestInterface methodsFor: 'api' stamp: 'BT 12/3/2020 14:58:38'!
addToCart: aCartID bookISBN: aBook bookQuantity: bookQuantityToAdd
	supermarket verifyItIsASellingBook: aBook ifNot: [self error: self class invalidBookAddToCartErrorMessage].
	self verifyValidBookQuantity: bookQuantityToAdd.
	supermarket addBook: aBook toCart: 	aCartID bookQuantity: bookQuantityToAdd ifAbsent: [self error: self class  unknownCartErrorMessage].
	self verifyCartStillActive: aCartID.
! !

!RestInterface methodsFor: 'api' stamp: 'CR 12/3/2020 11:55:40'!
checkout: aCartToCheckOut withCreditCard: cardToPayWith for: clientID 
	self verifyClientExists: clientID andCartIsAssignedToHim: aCartToCheckOut.
	self verifyCartStillActive: aCartToCheckOut.
	^ supermarket checkout: aCartToCheckOut withCreditCard: cardToPayWith for: clientID at: (clock now).! !

!RestInterface methodsFor: 'api' stamp: 'CR 12/3/2020 01:32:40'!
createCartForClient: aClientID withPassword: passwordOfClientWhoIsCreatingACart
	| newCartID |
	self validateUser: aClientID withPassword: passwordOfClientWhoIsCreatingACart.
	newCartID := supermarket newCartForClient: aClientID.
	self assignNewCart: newCartID toClient: aClientID.
	^newCartID.! !

!RestInterface methodsFor: 'api' stamp: 'CR 12/3/2020 11:42:08'!
listCart: aCartID 
	self verifyCartExists: aCartID.
	self verifyCartStillActive: aCartID.
	^ supermarket listCartsItemsOf: aCartID.! !

!RestInterface methodsFor: 'api' stamp: 'CR 12/3/2020 02:01:20'!
listPurchases: clientID withPassword: clientPassword
	| clientSalesBook |
	self validateUser: clientID withPassword: clientPassword.
	clientSalesBook := supermarket salesBookFor: clientID.
	^ self purchasesGivenSalesBook: clientSalesBook.! !

!RestInterface methodsFor: 'api' stamp: 'BT 12/3/2020 15:06:18'!
verifyValidBookQuantity: bookQuantityToAdd.
	^ (bookQuantityToAdd > 0) ifFalse: [self error: self class invalidQuantityOfBookErrorMessage].! !


!RestInterface methodsFor: 'initialization' stamp: 'CR 12/3/2020 11:19:50'!
initializeWith: aSupermarket withAuthenticator: anAuthenticator collaborateWithClock: aClock
	supermarket := aSupermarket.
	authenticator := anAuthenticator.
	cartsByClient := Dictionary new.
	timestamps := Dictionary new.
	clock := aClock.
! !


!RestInterface methodsFor: 'list purchases private' stamp: 'CR 12/3/2020 06:31:29'!
addItemsFromSalesBook: clientSalesBook To: allItems

	clientSalesBook do: [: sale | allItems addAll: (sale items) ]! !

!RestInterface methodsFor: 'list purchases private' stamp: 'CR 12/3/2020 06:24:36'!
asStringItemsFrom: allItems

	^ allItems contents asString withoutPrefix: 'a Dictionary'! !

!RestInterface methodsFor: 'list purchases private' stamp: 'CR 12/3/2020 06:25:47'!
itemsAsString: allItems

	^ allItems contents asString withoutPrefix: 'a Dictionary'! !

!RestInterface methodsFor: 'list purchases private' stamp: 'CR 12/3/2020 06:31:39'!
purchasesGivenSalesBook: clientSalesBook
	|  totalSpent allItems |
	(clientSalesBook isEmpty) ifTrue: [^'No purchases'].
	
	totalSpent := self sumTotalSpentFor: clientSalesBook.
	allItems := Bag new.
	self addItemsFromSalesBook: clientSalesBook To: allItems.
	^ (self itemsAsString: allItems), (self totalSpentAsString: totalSpent).! !

!RestInterface methodsFor: 'list purchases private' stamp: 'CR 12/3/2020 06:22:18'!
sumTotalSpentFor: clientSalesBook

	^ clientSalesBook sum: [: sale | sale total ] ifEmpty: [0]! !

!RestInterface methodsFor: 'list purchases private' stamp: 'CR 12/3/2020 06:37:32'!
totalSpentAsString: totalSpent

	^ ' Total spent = ', totalSpent asString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterface class' category: 'TusLibros'!
RestInterface class
	instanceVariableNames: ''!

!RestInterface class methodsFor: 'instance creation' stamp: 'CR 12/3/2020 11:16:12'!
for: aSupermarket withAuthenticator: anAuthenticator collaborateWithClock: aClock
	^ self new initializeWith: aSupermarket withAuthenticator: anAuthenticator collaborateWithClock: aClock. ! !


!RestInterface class methodsFor: 'error messages' stamp: 'CR 12/3/2020 06:52:28'!
cannotCheckOutEmptyCart
	^ 'Can not check out empty cart!!'.! !

!RestInterface class methodsFor: 'error messages' stamp: 'CR 12/3/2020 10:59:56'!
cartExpiredErrorDescription
	^ 'The cart is no longer active!!'.! !

!RestInterface class methodsFor: 'error messages' stamp: 'CR 12/2/2020 23:27:33'!
expiredCreditCard
	^ 'The credit card is expired'.! !

!RestInterface class methodsFor: 'error messages' stamp: 'BT 12/3/2020 14:52:50'!
invalidBookAddToCartErrorMessage
	^ 'cannot add an invalid book'! !

!RestInterface class methodsFor: 'error messages' stamp: 'BT 12/2/2020 11:32:00'!
invalidClientErrorDescription
	^ 'Invalid client!!'.! !

!RestInterface class methodsFor: 'error messages' stamp: 'BT 12/3/2020 15:02:32'!
invalidQuantityOfBookErrorMessage
	^ 'invalid quantity of book!!'! !

!RestInterface class methodsFor: 'error messages' stamp: 'CR 12/3/2020 09:21:08'!
unknownCartErrorMessage
	^ 'cant add items to an unknown cart!!'.! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'items' stamp: 'CR 12/3/2020 01:48:43'!
items
	
	^ items ! !


!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'CR 12/3/2020 00:14:37'!
initializeTotal: aTotal withItems: boughtItems.

	total := aTotal.
	items := boughtItems.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'CR 12/3/2020 00:19:21'!
of: aTotal with: boughtItems

	(aTotal <= 0) ifTrue: [self hasToBeNonNegative].
	^self new initializeTotal: aTotal withItems: boughtItems.! !


!Sale class methodsFor: 'error messages' stamp: 'CR 12/3/2020 00:18:51'!
hasToBeNonNegative
	^'Sale amount has to be non negative!!'! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today timeNow'
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


!StoreTestObjectsFactory methodsFor: 'cashier' stamp: 'BT 12/2/2020 10:22:21'!
defaultCashier
	^ true! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'CR 12/2/2020 22:50:13'!
defaultCardNumber
	^'245323'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'CR 12/3/2020 09:15:59'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1) owner: self defaultCardOwner number: self defaultCardNumber.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'CR 12/3/2020 09:15:05'!
notExpiredCreditCard
	
	^CreditCard expiringOn:  (Month month: today monthIndex year: today yearNumber + 1) owner: self defaultCardOwner number: self defaultCardNumber.
	! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'CR 12/2/2020 22:51:57'!
defaultExpirationDate
	
	^ today + 1! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'CR 12/3/2020 07:02:21'!
now
	
	^ timeNow! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'supermarket' stamp: 'CR 12/3/2020 01:07:27'!
defaultSupermarket
	^ Supermarket withCatalog: self defaultCatalog through: MPValidTransaction new.! !


!StoreTestObjectsFactory methodsFor: 'interface' stamp: 'CR 12/3/2020 11:18:23'!
defaultRestInterface
	^ RestInterface for: self defaultSupermarket withAuthenticator: self defaultAuthenticator collaborateWithClock: Clock new.! !


!StoreTestObjectsFactory methodsFor: 'interface - authenticator' stamp: 'BT 12/2/2020 11:26:31'!
defaultAuthenticator
	^ AuthenticatorSimulatorOfValidClients new! !

!StoreTestObjectsFactory methodsFor: 'interface - authenticator' stamp: 'BT 12/2/2020 11:30:57'!
invalidClientAuthenticator
	^ AuthenticatorSimulatorOfInvalidClients new.! !


!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'CR 12/2/2020 22:51:27'!
defaultCardOwner
	^ 'BelenT'! !


!classDefinition: #Supermarket category: 'TusLibros'!
Object subclass: #Supermarket
	instanceVariableNames: 'catalog cashier carts salesBookByClient merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Supermarket methodsFor: 'initialization' stamp: 'BT 12/2/2020 10:19:01'!
createIDforCart: needingIDCart
	^ needingIDCart.! !

!Supermarket methodsFor: 'initialization' stamp: 'CR 12/3/2020 01:41:47'!
createSaleBookForClientIfAbsent: aClientID
	salesBookByClient at: aClientID ifAbsentPut: [Bag new].
	! !

!Supermarket methodsFor: 'initialization' stamp: 'CR 12/3/2020 01:23:42'!
initializeWithCatalog: aCatalog through: aMerchantProcessor
	catalog := aCatalog.
	carts := IdentityDictionary new.
	salesBookByClient := Dictionary new.
	merchantProcessor := aMerchantProcessor.! !

!Supermarket methodsFor: 'initialization' stamp: 'CR 12/3/2020 01:37:49'!
newCartForClient: aClientID
	| newCart IDForNewCart |
	newCart := Cart acceptingItemsOf: catalog.
	IDForNewCart := self createIDforCart: newCart.
	carts at: IDForNewCart put: newCart.
	self createSaleBookForClientIfAbsent: aClientID.
	^ IDForNewCart.
	! !


!Supermarket methodsFor: 'interface - interaction' stamp: 'CR 12/3/2020 11:44:27'!
checkout: cartID withCreditCard: creditCardToPayWith for: clientID at: timeNow
	| aCartToCheckOut aCashierToPayWith |
	aCartToCheckOut := carts at: cartID.
	self verifyCartIsNonEmpty: aCartToCheckOut.
	aCashierToPayWith := Cashier toCheckout: aCartToCheckOut charging: creditCardToPayWith through: merchantProcessor on: timeNow registeringOn: (salesBookByClient at: clientID). 
	^ aCashierToPayWith checkOut.
	
	

	! !

!Supermarket methodsFor: 'interface - interaction' stamp: 'CR 12/3/2020 11:40:27'!
hasCart: aCartID
	^ carts includesKey: aCartID.! !

!Supermarket methodsFor: 'interface - interaction' stamp: 'CR 12/3/2020 11:42:25'!
listCartsItemsOf: aCartID
	^ carts at: aCartID ifPresent: [:cart | cart listItems ] ! !

!Supermarket methodsFor: 'interface - interaction' stamp: 'CR 12/3/2020 12:21:44'!
removeCart: aCartID
	carts removeKey: aCartID.
! !

!Supermarket methodsFor: 'interface - interaction' stamp: 'CR 12/3/2020 02:01:47'!
salesBookFor: clientID
	^ salesBookByClient at: clientID.! !


!Supermarket methodsFor: 'cart' stamp: 'BT 12/3/2020 14:47:22'!
addBook: aBook toCart: aCartID bookQuantity: bookQuantityToAdd ifAbsent: errorBlock 
	| cart |
	cart := carts at: aCartID ifAbsent: errorBlock.
	cart add: aBook.
	! !


!Supermarket methodsFor: 'verifications' stamp: 'CR 12/3/2020 06:52:44'!
verifyCartIsNonEmpty: aCartToCheckOut

	^ (aCartToCheckOut isEmpty) ifTrue: [self error: RestInterface cannotCheckOutEmptyCart]! !

!Supermarket methodsFor: 'verifications' stamp: 'BT 12/3/2020 15:05:17'!
verifyItIsASellingBook: aBook ifNot: errorBlock
	^ catalog at: aBook ifAbsent: errorBlock.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Supermarket class' category: 'TusLibros'!
Supermarket class
	instanceVariableNames: ''!

!Supermarket class methodsFor: 'instance creation' stamp: 'CR 12/3/2020 01:05:23'!
withCatalog: aCatalog through: aMerchantProcessor
	^ self new initializeWithCatalog: aCatalog through: aMerchantProcessor.! !
