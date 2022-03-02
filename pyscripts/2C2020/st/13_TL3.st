!classDefinition: #ApiRestTest category: 'TusLibros'!
TestCase subclass: #ApiRestTest
	instanceVariableNames: 'testObjectsFactory debitBehavior clientValidationBehavior simulatedTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ApiRestTest methodsFor: 'check out tests' stamp: 'AM 12/2/2020 23:13:32'!
test01cantCheckOutNonExistingCart

	| api |
	
	api := ApiRest withCatalogue: testObjectsFactory defaultCatalogue salesThrough: self validatingClientsThrough: self keepingTimeWith: self.
	
	self 
		should:[api checkOutCart: 1 charging: testObjectsFactory notExpiredCreditCard]
		raise: Error 
		withMessageText: CartManager cartDoesntExistErrorDescription.
	
	! !

!ApiRestTest methodsFor: 'check out tests' stamp: 'AM 12/3/2020 00:12:53'!
test02checkOutReturnsSaleInformation

	| api cartID sale |
	
	api := ApiRest withCatalogue: testObjectsFactory defaultCatalogue salesThrough: self validatingClientsThrough: self keepingTimeWith: self.
	cartID := api createCartFor: 'client' withPassword: 'password'.
	
	api addToCart: cartID item: (testObjectsFactory itemSoldByTheStore) quantity: 1. 
	sale := api checkOutCart: cartID charging: testObjectsFactory notExpiredCreditCard.
	
	self assert: (sale total) equals: (testObjectsFactory itemSoldByTheStorePrice * 1).
	self assert: (sale soldItems) equals: (OrderedCollection with: testObjectsFactory itemSoldByTheStore).! !

!ApiRestTest methodsFor: 'check out tests' stamp: 'AM 12/3/2020 12:31:44'!
test03differentCheckOutsReturnDifferentSaleIDs

	| api cartID1 cartID2 sale1 sale2 |
	
	api := ApiRest withCatalogue: testObjectsFactory defaultCatalogue 
				salesThrough: self 
				validatingClientsThrough: self 
				keepingTimeWith: self.
				
	cartID1 := api createCartFor: 'client' withPassword: 'password'.
	cartID2 := api createCartFor: 'client' withPassword: 'password'.
	
	api addToCart: cartID1 
		item: (testObjectsFactory itemSoldByTheStore) 
		quantity: 1. 
		
	sale1 := api checkOutCart: cartID1 charging: testObjectsFactory notExpiredCreditCard.
				
	api addToCart: cartID2 
		item: (testObjectsFactory itemSoldByTheStore) 
		quantity: 1. 
		
	sale2 := api checkOutCart: cartID2 charging: testObjectsFactory notExpiredCreditCard.
	
	self deny: (sale1 saleID) = (sale2 saleID).
! !


!ApiRestTest methodsFor: 'set up' stamp: 'AM 12/3/2020 12:37:51'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ].
	clientValidationBehavior := [:aClientID : aPassword | ].
	simulatedTime := DateAndTime now.! !


!ApiRestTest methodsFor: 'authentication protocol' stamp: 'AM 11/30/2020 18:11:22'!
authenticate: aClientID withPassword: aPassword

	clientValidationBehavior value: aClientID value: aPassword.! !


!ApiRestTest methodsFor: 'merchant processor protocol' stamp: 'AM 12/3/2020 12:37:34'!
debit: anAmount from: aCreditCard 
	
	^debitBehavior value: anAmount value: aCreditCard.! !


!ApiRestTest methodsFor: 'cart management tests' stamp: 'AM 12/2/2020 23:13:32'!
test01newCartShouldBeEmpty

	| api cartID expected |
	
	api := ApiRest withCatalogue: testObjectsFactory defaultCatalogue salesThrough: self validatingClientsThrough: self keepingTimeWith: self.
	
	cartID := api createCartFor: 'client' withPassword: 'password'.
	
	expected := OrderedCollection new.
	
	self assert: expected equals: (api listCart: cartID).! !

!ApiRestTest methodsFor: 'cart management tests' stamp: 'AM 12/2/2020 23:14:05'!
test02cantAddItemsToNonExistingCart

	| api |
	
	api := ApiRest withCatalogue: testObjectsFactory defaultCatalogue salesThrough: self validatingClientsThrough: self keepingTimeWith: self.
	
	self 
		should:[api addToCart: 1 item: (testObjectsFactory itemSoldByTheStore) quantity: 1]
		raise: Error 
		withMessageText: CartManager cartDoesntExistErrorDescription.
		
	self assert: (api hasNoActiveCarts).
	! !

!ApiRestTest methodsFor: 'cart management tests' stamp: 'AM 12/2/2020 23:13:32'!
test03cantListItemsOfNonExistingCart

	| api |
	
	api := ApiRest withCatalogue: testObjectsFactory defaultCatalogue salesThrough: self validatingClientsThrough: self keepingTimeWith: self.
	
	self 
		should:[api listCart: 1]
		raise: Error 
		withMessageText: CartManager cartDoesntExistErrorDescription.
	
	! !

!ApiRestTest methodsFor: 'cart management tests' stamp: 'AM 12/2/2020 23:13:32'!
test04cantCreateCartForInvalidClientIDPasswordCombination

	| api |
	
	api := ApiRest withCatalogue: testObjectsFactory defaultCatalogue salesThrough: self validatingClientsThrough: self keepingTimeWith: self.
	
	clientValidationBehavior := [:client :password | self error: ApiRest invalidIDOrPasswordErrorDescription].
	
	self
		should:[api createCartFor: 'client' withPassword: 'password']
		raise: Error
		withMessageText: ApiRest invalidIDOrPasswordErrorDescription.
		
	self assert: api hasNoActiveCarts.! !

!ApiRestTest methodsFor: 'cart management tests' stamp: 'AM 12/2/2020 23:14:05'!
test05itemIsAddedToCartCorrectly

	| api cartID expected |
	
	api := ApiRest withCatalogue: testObjectsFactory defaultCatalogue salesThrough: self validatingClientsThrough: self keepingTimeWith: self.
	
	cartID := api createCartFor: 'client' withPassword: 'password'.
	
	api addToCart: cartID item: (testObjectsFactory itemSoldByTheStore) quantity: 1. 
	
	expected := OrderedCollection with: testObjectsFactory itemSoldByTheStore.
	
	self assert: expected equals: (api listCart: cartID).! !

!ApiRestTest methodsFor: 'cart management tests' stamp: 'AM 12/2/2020 23:14:05'!
test06cartIsDeletedAfterCheckOut

	| api cartID |
	
	api := ApiRest withCatalogue: testObjectsFactory defaultCatalogue salesThrough: self validatingClientsThrough: self keepingTimeWith: self.
	
	cartID := api createCartFor: 'client' withPassword: 'password'.
	
	api addToCart: cartID item: (testObjectsFactory itemSoldByTheStore) quantity: 1. 
	api checkOutCart: cartID charging: testObjectsFactory notExpiredCreditCard.
	
	self
		should: [api listCart: cartID]
		raise: Error
		withMessageText: CartManager cartDoesntExistErrorDescription.! !

!ApiRestTest methodsFor: 'cart management tests' stamp: 'AM 12/3/2020 12:34:28'!
test07cartsHaveDifferentIDs

	| api cartID1 cartID2 |
	
	api := ApiRest withCatalogue: testObjectsFactory defaultCatalogue salesThrough: self validatingClientsThrough: self keepingTimeWith: self.
	
	cartID1 := api createCartFor: 'client' withPassword: 'password'.
	cartID2 := api createCartFor: 'client' withPassword: 'password'.
	
	self deny: cartID1 = cartID2.! !


!ApiRestTest methodsFor: 'clock protocol' stamp: 'AM 12/1/2020 17:46:02'!
leap15MinutesIntoTheFuture
	
	simulatedTime := simulatedTime + 15 minutes.! !

!ApiRestTest methodsFor: 'clock protocol' stamp: 'AM 12/1/2020 17:02:17'!
leap30MinutesIntoTheFuture
	
	simulatedTime := simulatedTime + 30 minutes.! !

!ApiRestTest methodsFor: 'clock protocol' stamp: 'AM 12/1/2020 16:58:53'!
now
	
	^simulatedTime.! !


!ApiRestTest methodsFor: 'time keeping tests' stamp: 'AM 12/2/2020 23:14:05'!
test01cantCheckOutCart30MinutesAfterLastAction

	| api cartID |
	
	api := ApiRest withCatalogue: testObjectsFactory defaultCatalogue salesThrough: self validatingClientsThrough: self keepingTimeWith: self.
	
	cartID := api createCartFor: 'client' withPassword: 'password'.
	api addToCart: cartID item: testObjectsFactory itemSoldByTheStore quantity: 1.
	
	self leap30MinutesIntoTheFuture.
	
	self
		should: [api checkOutCart: cartID charging: testObjectsFactory notExpiredCreditCard]
		raise: Error
		withMessageText: CartManager cartExpiredErrorDescription.
	
	self assert: (api listPurchasesFor: 'client') isEmpty.
	
	! !

!ApiRestTest methodsFor: 'time keeping tests' stamp: 'AM 12/2/2020 23:13:32'!
test02cantListCart30MinutesAfterLastAction

	| api cartID |
	
	api := ApiRest withCatalogue: testObjectsFactory defaultCatalogue salesThrough: self validatingClientsThrough: self keepingTimeWith: self.
	
	cartID := api createCartFor: 'client' withPassword: 'password'.
	
	self leap30MinutesIntoTheFuture.
	
	self
		should: [api listCart: cartID]
		raise: Error
		withMessageText: CartManager cartExpiredErrorDescription.

	
	! !

!ApiRestTest methodsFor: 'time keeping tests' stamp: 'AM 12/2/2020 23:14:05'!
test03cantAddItemsToCart30MinutesAfterLastAction

	| api cartID |
	
	api := ApiRest withCatalogue: testObjectsFactory defaultCatalogue salesThrough: self validatingClientsThrough: self keepingTimeWith: self.
	
	cartID := api createCartFor: 'client' withPassword: 'password'.
	
	self leap30MinutesIntoTheFuture.
	
	self
		should: [api addToCart: cartID item: testObjectsFactory itemSoldByTheStore quantity: 1]
		raise: Error
		withMessageText: CartManager cartExpiredErrorDescription.

	
	! !

!ApiRestTest methodsFor: 'time keeping tests' stamp: 'AM 12/2/2020 23:14:04'!
test04addingItemsToCartResetsExpirationDeadline

	| api cartID expected |
	
	api := ApiRest withCatalogue: testObjectsFactory defaultCatalogue salesThrough: self validatingClientsThrough: self keepingTimeWith: self.
	
	cartID := api createCartFor: 'client' withPassword: 'password'.
	self leap15MinutesIntoTheFuture.
	
	api addToCart: cartID item: testObjectsFactory itemSoldByTheStore quantity: 1.
	self leap15MinutesIntoTheFuture.
	
	expected := OrderedCollection with: (testObjectsFactory itemSoldByTheStore).	
	self assert: (api listCart: cartID) equals: expected.
	
	! !

!ApiRestTest methodsFor: 'time keeping tests' stamp: 'AM 12/2/2020 23:13:32'!
test05listingCartResetsExpirationDeadline

	| api cartID expected |
	
	api := ApiRest withCatalogue: testObjectsFactory defaultCatalogue salesThrough: self validatingClientsThrough: self keepingTimeWith: self.
	
	cartID := api createCartFor: 'client' withPassword: 'password'.
	self leap15MinutesIntoTheFuture.
	
	api listCart: cartID.
	self leap15MinutesIntoTheFuture.
	
	expected := OrderedCollection new.	
	self assert: (api listCart: cartID) equals: expected.
	
	! !


!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'AM 12/2/2020 23:14:50'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'AM 12/2/2020 23:14:05'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSoldByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'AM 12/2/2020 23:14:04'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'AM 12/2/2020 23:14:50'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSoldByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'AM 12/2/2020 23:14:05'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSoldByTheStore.
	self assert: (cart includes: testObjectsFactory itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'AM 12/2/2020 23:14:05'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'AM 12/2/2020 23:14:05'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSoldByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSoldByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'AM 12/3/2020 00:04:50'!
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

!CashierTest methodsFor: 'tests' stamp: 'AM 12/3/2020 00:04:50'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSoldByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		through: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSoldByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'AM 12/3/2020 00:04:50'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSoldByTheStore.
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

!CashierTest methodsFor: 'tests' stamp: 'AM 12/3/2020 00:04:50'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSoldByTheStore.
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

!CashierTest methodsFor: 'tests' stamp: 'AM 12/3/2020 00:04:50'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSoldByTheStore.
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

!CashierTest methodsFor: 'tests' stamp: 'AM 12/3/2020 00:04:50'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSoldByTheStore.
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


!CashierTest methodsFor: 'setup' stamp: 'AM 12/3/2020 12:36:20'!
setUp 
	
	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ].! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'AM 12/3/2020 12:36:33'!
debit: anAmount from: aCreditCard 
	
	^debitBehavior value: anAmount value: aCreditCard.! !


!classDefinition: #ApiRest category: 'TusLibros'!
Object subclass: #ApiRest
	instanceVariableNames: 'priceCatalogue activeCarts merchantProcessor clientPasswordValidator salesBook ownerForCart cartManager clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ApiRest methodsFor: 'initialization' stamp: 'AM 12/1/2020 17:37:10'!
initializeWithCatalogue: aPriceCatalogue salesThrough: aMerchantProcessor validatingClientsThrough: aClientPasswordValidator keepingTimeWith: aClock  
	
	priceCatalogue := aPriceCatalogue.
	merchantProcessor := aMerchantProcessor.
	salesBook := Dictionary new.
	cartManager := CartManager for: self.
	clientPasswordValidator := aClientPasswordValidator.
	clock := aClock.! !


!ApiRest methodsFor: 'testing' stamp: 'AM 12/1/2020 16:29:21'!
hasNoActiveCarts
	
	^cartManager hasNoActiveCarts.! !


!ApiRest methodsFor: 'cart' stamp: 'AM 12/3/2020 00:05:36'!
addToCart: aCartID item: anItemID quantity: aQuantity

	cartManager addToCart: aCartID 
				item: anItemID 
				quantity: aQuantity.
	
	! !

!ApiRest methodsFor: 'cart' stamp: 'AM 12/1/2020 17:38:21'!
createCartFor: aClientID withPassword: aPassword
	
	clientPasswordValidator authenticate: aClientID withPassword: aPassword.
	^cartManager addCart: (Cart acceptingItemsOf: priceCatalogue) forClient: aClientID .
	
	
	
	! !

!ApiRest methodsFor: 'cart' stamp: 'AM 12/1/2020 16:29:45'!
listCart: aCartId
	
	^cartManager listCart: aCartId.! !


!ApiRest methodsFor: 'check out' stamp: 'AM 12/3/2020 12:30:27'!
checkOutCart: aCartID charging: aCreditCard 
	
	| cashier cartOwner sale|
	
	cartOwner := cartManager ownerIDForCart: aCartID.
	
	cashier := Cashier toCheckout: (cartManager cartWithID: aCartID)
					charging: aCreditCard 
					through: merchantProcessor on: (clock now) 
					registeringOn: (self salesBookForClient: cartOwner).
	cashier checkOut.
	
	cartManager removeCart: aCartID.
	
	sale := (self lastSaleForClient: cartOwner) registerID: aCartID.
	^sale.
	 ! !

!ApiRest methodsFor: 'check out' stamp: 'AM 12/3/2020 00:01:53'!
salesBookForClient: cartOwner

	^ salesBook at: cartOwner ifAbsent: [salesBook at: cartOwner put: OrderedCollection new]! !


!ApiRest methodsFor: 'clients' stamp: 'AM 12/3/2020 00:07:48'!
lastSaleForClient: aClientID
	
	^(self salesBookForClient: aClientID) last.! !

!ApiRest methodsFor: 'clients' stamp: 'AM 12/3/2020 00:07:05'!
listPurchasesFor: aClientID

	^self salesBookForClient: aClientID.! !


!ApiRest methodsFor: 'time keeping protocol' stamp: 'AM 12/1/2020 17:33:14'!
timeNow
	
	^clock now.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ApiRest class' category: 'TusLibros'!
ApiRest class
	instanceVariableNames: ''!

!ApiRest class methodsFor: 'instance creation' stamp: 'AM 12/3/2020 00:05:12'!
withCatalogue: aPriceCatalogue salesThrough: aMerchantProcessor validatingClientsThrough: aClientPasswordValidator keepingTimeWith: aClock 
	
	^self new initializeWithCatalogue: aPriceCatalogue 
					salesThrough: aMerchantProcessor 
					validatingClientsThrough: aClientPasswordValidator 
					keepingTimeWith: aClock.! !


!ApiRest class methodsFor: 'error descriptions' stamp: 'AM 11/29/2020 16:16:24'!
invalidIDOrPasswordErrorDescription
	
	^'ID or password is invalid'! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalogue items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'AM 12/2/2020 23:38:06'!
assertIsValidItem: anItem

	(catalogue includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'AM 12/2/2020 23:38:06'!
initializeAcceptingItemsOf: aCatalog

	catalogue := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'item queries' stamp: 'AM 11/30/2020 18:54:03'!
items

	^items copy.! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'AM 12/2/2020 23:38:06'!
total

	^ items sum: [ :anItem | catalogue at: anItem ]! !


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


!classDefinition: #CartManager category: 'TusLibros'!
Object subclass: #CartManager
	instanceVariableNames: 'activeCarts cartLastActionTimestamp nextCartID api'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartManager methodsFor: 'time keeping protocol' stamp: 'AM 12/2/2020 23:26:39'!
assertIfExpiredAndRemoveIfTrue: aCartID

	((cartLastActionTimestamp at: aCartID) > ((api timeNow) - 30 minutes)) ifFalse: [ activeCarts removeKey: aCartID.
														     			cartLastActionTimestamp removeKey: aCartID.
																	self signalCartExpired.]! !

!CartManager methodsFor: 'time keeping protocol' stamp: 'AM 12/1/2020 18:01:55'!
updateTimeFor: aCartID

	^ cartLastActionTimestamp at: aCartID put: api timeNow.! !


!CartManager methodsFor: 'cart queries' stamp: 'AM 12/2/2020 23:26:39'!
cartWithID: aCartID
	
	| cart |
	
	cart := (activeCarts at: aCartID ifAbsent: [self signalNonExistentCart]) value.
	self assertIfExpiredAndRemoveIfTrue: aCartID.
	^cart.! !

!CartManager methodsFor: 'cart queries' stamp: 'AM 12/1/2020 18:00:58'!
listCart: aCartID
	
	| cartToList |
	
	cartToList := self cartWithID: aCartID.
	self updateTimeFor: aCartID.
	
	^cartToList items.! !

!CartManager methodsFor: 'cart queries' stamp: 'AM 12/1/2020 16:49:16'!
ownerIDForCart: aCartID

	^(activeCarts at: aCartID ifAbsent: [self signalNonExistentCart]) key.! !


!CartManager methodsFor: 'adding/removing' stamp: 'AM 12/1/2020 18:01:25'!
addCart: aCart forClient: aClientID  

	| cartID |
	
	cartID := nextCartID.
	nextCartID := nextCartID + 1.
	
	self updateTimeFor: cartID.
	activeCarts at: cartID put: aClientID->aCart.
	^cartID.
	! !

!CartManager methodsFor: 'adding/removing' stamp: 'AM 12/2/2020 23:26:39'!
addToCart: aCartID item: anItemID quantity: aQuantity

	| cart |
	
	cart := (activeCarts at: aCartID ifAbsent: [self signalNonExistentCart]) value.
	self assertIfExpiredAndRemoveIfTrue: aCartID.
	self updateTimeFor: aCartID.
	cart add: aQuantity of: anItemID.! !

!CartManager methodsFor: 'adding/removing' stamp: 'AM 12/1/2020 18:18:32'!
removeCart: aCartID

	activeCarts removeKey: aCartID.
	cartLastActionTimestamp removeKey: aCartID.! !


!CartManager methodsFor: 'testing' stamp: 'AM 12/1/2020 16:29:10'!
hasNoActiveCarts
	
	^activeCarts isEmpty.! !


!CartManager methodsFor: 'initialization' stamp: 'AM 12/1/2020 18:19:23'!
initializeFor: anApi
	
	api := anApi.
	activeCarts := Dictionary new.
	cartLastActionTimestamp := Dictionary new.
	nextCartID := 0.! !


!CartManager methodsFor: 'error signaling' stamp: 'AM 12/1/2020 17:32:43'!
signalCartExpired

	self error: self class cartExpiredErrorDescription.! !

!CartManager methodsFor: 'error signaling' stamp: 'AM 12/1/2020 16:41:35'!
signalNonExistentCart

	self error: self class cartDoesntExistErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartManager class' category: 'TusLibros'!
CartManager class
	instanceVariableNames: ''!

!CartManager class methodsFor: 'error descriptions' stamp: 'AM 12/1/2020 16:40:10'!
cartDoesntExistErrorDescription

	^'There is no cart with provided ID'.! !

!CartManager class methodsFor: 'error descriptions' stamp: 'AM 12/1/2020 17:10:32'!
cartExpiredErrorDescription
	
	^'Cart is expired'! !


!CartManager class methodsFor: 'instance creation' stamp: 'AM 12/1/2020 17:24:16'!
for: anApi

	^self new initializeFor: anApi.! !


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

!Cashier methodsFor: 'checkout - private' stamp: 'AM 12/3/2020 12:18:20'!
createSale
	
	^Sale forCart: cart .
! !

!Cashier methodsFor: 'checkout - private' stamp: 'AM 12/3/2020 12:36:46'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	
	
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'AM 11/30/2020 19:26:49'!
registerSale

	^salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'AM 12/2/2020 23:46:43'!
checkOut
	
	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total.! !


!Cashier methodsFor: 'initialization' stamp: 'AM 12/2/2020 23:16:26'!
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


!Cashier class methodsFor: 'instance creation' stamp: 'AM 12/3/2020 00:04:50'!
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


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'number expirationDate owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'AM 12/2/2020 23:03:19'!
isExpiredOn: aDate 
	
	^expirationDate start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'AM 12/2/2020 23:02:39'!
initializeForNumber: aCreditCardNumber expirationOn: anExpirationDate Owner: anOwnerNameString
	
	number := aCreditCardNumber.
	expirationDate := anExpirationDate.
	owner := anOwnerNameString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'AM 12/2/2020 23:20:02'!
withNumber: aCreditCardNumber expirationOn: anExpirationDate Owner: anOwnerNameString

	self assertValidNumber: aCreditCardNumber.
	self assertValidOwnerName: anOwnerNameString.
	
	^self new initializeForNumber: aCreditCardNumber expirationOn: anExpirationDate Owner: anOwnerNameString.! !


!CreditCard class methodsFor: 'error descriptions' stamp: 'AM 12/2/2020 23:19:26'!
InvalidCreditCardNumberErrorDescription
	
	^'Credit card number must be a 16 digit number'.! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'AM 12/2/2020 23:24:36'!
invalidOwnerNameErrorDescription

	^'Owner name can not be empty'! !


!CreditCard class methodsFor: 'assertions' stamp: 'AM 12/2/2020 23:23:13'!
assertValidNumber: aCreditCardNumber
	
	| isValid |

	isValid := (aCreditCardNumber size) = 16 and: [aCreditCardNumber allSatisfy: [:char | char isAlphaNumeric]].
	
	isValid ifFalse: [self error: self InvalidCreditCardNumberErrorDescription.].! !

!CreditCard class methodsFor: 'assertions' stamp: 'AM 12/2/2020 23:24:04'!
assertValidOwnerName: anOwnerNameString

	anOwnerNameString isEmpty ifTrue: [self error: self invalidOwnerNameErrorDescription].! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total soldItems ID'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'transaction ID' stamp: 'AM 12/3/2020 12:32:50'!
registerID: aSaleID

	ID := aSaleID.! !

!Sale methodsFor: 'transaction ID' stamp: 'AM 12/3/2020 12:23:01'!
saleID

	^ID.! !


!Sale methodsFor: 'items' stamp: 'AM 11/30/2020 18:49:03'!
soldItems

	^soldItems copy.! !


!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'AM 12/3/2020 12:28:19'!
initializeSaleOf: aCart 

	total := aCart total.
	soldItems := aCart items.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'AM 12/3/2020 12:28:19'!
forCart: aCart 
	
	^self new initializeSaleOf: aCart .
	! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'AM 12/2/2020 23:14:50'!
itemNotSoldByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'AM 12/2/2020 23:14:04'!
itemSoldByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'AM 12/2/2020 23:14:32'!
itemSoldByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'AM 12/2/2020 23:13:32'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalogue! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'AM 12/2/2020 23:14:32'!
defaultCatalogue
	
	^ Dictionary new
		at: self itemSoldByTheStore put: self itemSoldByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AM 12/2/2020 23:12:11'!
expiredCreditCard
	
	^CreditCard withNumber: '1234123412341234' expirationOn: (Month month: today monthIndex year: today yearNumber - 1) Owner: 'Juan Perez'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AM 12/2/2020 23:10:41'!
notExpiredCreditCard
	
	^CreditCard withNumber: '1234123412341234' expirationOn: (Month month: today monthIndex year: today yearNumber + 1) Owner: 'Juan Perez'! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
