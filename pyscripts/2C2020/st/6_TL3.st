!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'RL 12/2/2020 19:04:51'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore at: testObjectsFactory currentClock]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'RL 12/2/2020 19:05:00'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore at: testObjectsFactory currentClock.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'RL 12/2/2020 19:02:57'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore at: testObjectsFactory currentClock ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'RL 12/2/2020 19:03:08'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore at: testObjectsFactory currentClock ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'RL 12/2/2020 19:05:06'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore at: testObjectsFactory currentClock.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'RL 12/2/2020 19:03:14'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore at: testObjectsFactory currentClock.
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

!CashierTest methodsFor: 'tests' stamp: 'RL 12/3/2020 16:43:44'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore at: testObjectsFactory currentClock.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: Dictionary new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'RL 12/2/2020 19:15:54'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore at: testObjectsFactory currentClock.
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

!CashierTest methodsFor: 'tests' stamp: 'RL 12/3/2020 16:46:21'!
test04CheckoutRegistersASale

	| cart cashier salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore at: testObjectsFactory currentClock.
	salesBook := Dictionary new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	cashier checkOut.
					
	self assert: salesBook size = 1.! !

!CashierTest methodsFor: 'tests' stamp: 'RL 12/3/2020 16:46:56'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore at: testObjectsFactory currentClock.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := Dictionary new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.! !

!CashierTest methodsFor: 'tests' stamp: 'RL 12/2/2020 19:16:22'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore at: testObjectsFactory currentClock.
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


!classDefinition: #InnerInterfaceTest category: 'TusLibros'!
TestCase subclass: #InnerInterfaceTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InnerInterfaceTest methodsFor: 'adding items' stamp: 'RL 12/2/2020 19:26:44'!
test06AddingItemToUnregisteredCartReturnsErrorMessage
	| interface |
	
	interface := InnerInterface 
				newWith: testObjectsFactory defaultCatalog 
				for: testObjectsFactory clientDictWithOneClient 
				at: testObjectsFactory currentClock
				communicatingWith: self.
		
	self
		should: [ interface add: 1 of: testObjectsFactory itemSellByTheStore toCart: testObjectsFactory invalidCartID. ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InnerInterface invalidCartErrorMessage .
			]! !

!InnerInterfaceTest methodsFor: 'adding items' stamp: 'RL 12/2/2020 20:33:36'!
test20CannotAddItemToCartIfItHasBeenInactiveFor30Minutes
	| interface clock cartID |
	
	clock := testObjectsFactory currentClock .
	interface := InnerInterface 
				newWith: testObjectsFactory defaultCatalog 
				for: testObjectsFactory clientDictWithOneClient 
				at: clock
				communicatingWith: self.
	
	cartID := interface createCartFor: testObjectsFactory defaultClientID1 with: testObjectsFactory defaultPassword1.
	clock moveForwardMinutes: 31.
	
	self
		should: [ interface add: 1 of: testObjectsFactory itemSellByTheStore toCart: cartID ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InnerInterface expiredCartErrorMessage.]! !

!InnerInterfaceTest methodsFor: 'adding items' stamp: 'RL 12/2/2020 19:27:20'!
test22AddingItemToCartUpdatesLastActivityTime
	| interface clock cartID |
	
	clock := testObjectsFactory currentClock .
	interface := InnerInterface 
				newWith: testObjectsFactory defaultCatalog 
				for: testObjectsFactory clientDictWithOneClient 
				at: clock
				communicatingWith: self.
	
	cartID := interface createCartFor: testObjectsFactory defaultClientID1 with: testObjectsFactory defaultPassword1.
	clock moveForwardMinutes: 10.
	interface add: 1 of: testObjectsFactory itemSellByTheStore toCart: cartID.
	clock moveForwardMinutes: 21.
	
	self assert: (interface listCart: cartID) equals: (Bag with: testObjectsFactory itemSellByTheStore)! !

!InnerInterfaceTest methodsFor: 'adding items' stamp: 'RL 12/2/2020 20:22:54'!
test25AddingItemToExpiredCartMakesItsIDInvalid
	| interface clock cartID |
	
	clock := testObjectsFactory currentClock .
	interface := InnerInterface 
				newWith: testObjectsFactory defaultCatalog 
				for: testObjectsFactory clientDictWithOneClient 
				at: clock
				communicatingWith: self.
	
	cartID := interface createCartFor: testObjectsFactory defaultClientID1 with: testObjectsFactory defaultPassword1.
	clock moveForwardMinutes: 31.
	
	self
		should: [ interface add: 1 of: testObjectsFactory itemSellByTheStore toCart: cartID. ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InnerInterface expiredCartErrorMessage .
			].
	
	self
		should: [ interface listCart: cartID. ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InnerInterface invalidCartErrorMessage .
			]! !


!InnerInterfaceTest methodsFor: 'listing cart' stamp: 'RL 12/2/2020 19:25:00'!
test01NewCartListsNoItems
	| interface cartID |
	
	interface := InnerInterface 
				newWith: testObjectsFactory defaultCatalog 
				for: testObjectsFactory clientDictWithOneClient 
				at: testObjectsFactory currentClock
				communicatingWith: self.
				
	cartID := interface createCartFor: testObjectsFactory defaultClientID1 with: testObjectsFactory defaultPassword1.
	
	self assert: (interface listCart: cartID) isEmpty.! !

!InnerInterfaceTest methodsFor: 'listing cart' stamp: 'RL 12/2/2020 19:26:25'!
test02OneItemCartListsTheItem
	| interface cartID |
	
	interface := InnerInterface 
				newWith: testObjectsFactory defaultCatalog 
				for: testObjectsFactory clientDictWithOneClient 
				at: testObjectsFactory currentClock
				communicatingWith: self.	
				
	cartID := interface createCartFor: testObjectsFactory defaultClientID1 with: testObjectsFactory defaultPassword1.
	interface add: 1 of: testObjectsFactory itemSellByTheStore toCart: cartID.
		
	self assert: (interface listCart: cartID) equals: (Bag with: testObjectsFactory itemSellByTheStore).! !

!InnerInterfaceTest methodsFor: 'listing cart' stamp: 'RL 12/2/2020 19:26:39'!
test05TwoCartInterfaceListsCartItemsCorrectly
	| interface cart1ID |
	
	interface := InnerInterface 
				newWith: testObjectsFactory defaultCatalog 
				for: testObjectsFactory clientDictWithTwoClients 
				at: testObjectsFactory currentClock
				communicatingWith: self.
	
	cart1ID := interface createCartFor: testObjectsFactory defaultClientID1 with: testObjectsFactory defaultPassword1.
	interface add: 1 of: testObjectsFactory itemSellByTheStore toCart: cart1ID.
	interface createCartFor: testObjectsFactory defaultClientID2 with: testObjectsFactory defaultPassword2.
		
	self assert: (interface listCart: cart1ID) equals: (Bag with: testObjectsFactory itemSellByTheStore).! !

!InnerInterfaceTest methodsFor: 'listing cart' stamp: 'RL 12/2/2020 19:26:48'!
test07ListingUnregisteredCartReturnsErrorMessage
	| interface |
	
	interface := InnerInterface 
				newWith: testObjectsFactory defaultCatalog 
				for: testObjectsFactory clientDictWithOneClient 
				at: testObjectsFactory currentClock
				communicatingWith: self.
				
	self
		should: [ interface listCart: testObjectsFactory invalidCartID. ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InnerInterface invalidCartErrorMessage .
			]! !

!InnerInterfaceTest methodsFor: 'listing cart' stamp: 'RL 12/2/2020 19:27:15'!
test21CannotListCartIfItHasBeenInactiveFor30Minutes
	| interface clock cartID |
	
	clock := testObjectsFactory currentClock .
	interface := InnerInterface 
				newWith: testObjectsFactory defaultCatalog 
				for: testObjectsFactory clientDictWithOneClient 
				at: clock
				communicatingWith: self.
	
	cartID := interface createCartFor: testObjectsFactory defaultClientID1 with: testObjectsFactory defaultPassword1.
	interface add: 1 of: testObjectsFactory itemSellByTheStore toCart: cartID.
	clock moveForwardMinutes: 31.
	
	self
		should: [ interface listCart: cartID ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InnerInterface expiredCartErrorMessage.]! !

!InnerInterfaceTest methodsFor: 'listing cart' stamp: 'RL 12/2/2020 19:27:24'!
test23ListingCartUpdatesLastActivityTime
	| interface clock cartID |
	
	clock := testObjectsFactory currentClock .
	interface := InnerInterface 
				newWith: testObjectsFactory defaultCatalog 
				for: testObjectsFactory clientDictWithOneClient 
				at: clock
				communicatingWith: self.
	
	cartID := interface createCartFor: testObjectsFactory defaultClientID1 with: testObjectsFactory defaultPassword1.
	interface add: 1 of: testObjectsFactory itemSellByTheStore toCart: cartID.
	clock moveForwardMinutes: 10.
	interface listCart: cartID.
	clock moveForwardMinutes: 21.
	
	self assert: (interface listCart: cartID) equals: (Bag with: testObjectsFactory itemSellByTheStore)! !

!InnerInterfaceTest methodsFor: 'listing cart' stamp: 'RL 12/2/2020 20:21:36'!
test24ListingExpiredCartMakesItsIDInvalid
	| interface clock cartID |
	
	clock := testObjectsFactory currentClock .
	interface := InnerInterface 
				newWith: testObjectsFactory defaultCatalog 
				for: testObjectsFactory clientDictWithOneClient 
				at: clock
				communicatingWith: self.
	
	cartID := interface createCartFor: testObjectsFactory defaultClientID1 with: testObjectsFactory defaultPassword1.
	clock moveForwardMinutes: 31.
	
	self
		should: [ interface listCart: cartID. ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InnerInterface expiredCartErrorMessage .
			].
	
	self
		should: [ interface listCart: cartID. ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InnerInterface invalidCartErrorMessage .
			]! !


!InnerInterfaceTest methodsFor: 'listing purchases' stamp: 'RL 12/2/2020 20:46:23'!
test13ListingPurchasesForInvalidClientReturnsErrorMessage
	| interface |
	
	interface := InnerInterface 
				newWith: testObjectsFactory defaultCatalog 
				for: testObjectsFactory emptyClientDict 
				at: testObjectsFactory currentClock
				communicatingWith: self.
		
	self
		should: [ interface listPurchasesFor: testObjectsFactory defaultClientID1 with: testObjectsFactory defaultPassword1 ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InnerInterface clientNotRegisteredErrorMessage.
			]! !

!InnerInterfaceTest methodsFor: 'listing purchases' stamp: 'RL 12/2/2020 20:48:08'!
test14ListingPurchasesWithInvalidPasswordReturnsErrorMessage
	| interface |
	
	interface := InnerInterface 
				newWith: testObjectsFactory defaultCatalog 
				for: testObjectsFactory clientDictWithOneClient 
				at: testObjectsFactory currentClock
				communicatingWith: self.
	
	self
		should: [ interface listPurchasesFor: testObjectsFactory defaultClientID1 with: testObjectsFactory defaultPassword2 ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InnerInterface wrongPasswordErrorMessage.
			]! !

!InnerInterfaceTest methodsFor: 'listing purchases' stamp: 'RL 12/2/2020 20:53:54'!
test15NewClientHasNoPurchases
	| interface |
	
	interface := InnerInterface 
				newWith: testObjectsFactory defaultCatalog 
				for: testObjectsFactory clientDictWithOneClient 
				at: testObjectsFactory currentClock
				communicatingWith: self.
	
	self
		assert: (interface listPurchasesFor: testObjectsFactory defaultClientID1 with: testObjectsFactory defaultPassword1)
		equals: (OrderedCollection with: 0)! !


!InnerInterfaceTest methodsFor: 'cart creation' stamp: 'RL 12/2/2020 19:26:31'!
test03CreatingCartForInvalidClientReturnsErrorMessage
	| interface |
	
	interface := InnerInterface 
				newWith: testObjectsFactory defaultCatalog 
				for: testObjectsFactory emptyClientDict 
				at: testObjectsFactory currentClock
				communicatingWith: self.
		
	self
		should: [ interface createCartFor: testObjectsFactory defaultClientID1 with: testObjectsFactory defaultPassword1 ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InnerInterface clientNotRegisteredErrorMessage.
			]! !

!InnerInterfaceTest methodsFor: 'cart creation' stamp: 'RL 12/2/2020 19:26:35'!
test04CreatingCartWithInvalidPasswordReturnsErrorMessage
	| interface |
	
	interface := InnerInterface 
				newWith: testObjectsFactory defaultCatalog 
				for: testObjectsFactory clientDictWithOneClient 
				at: testObjectsFactory currentClock
				communicatingWith: self.
	
	self
		should: [ interface createCartFor: testObjectsFactory defaultClientID1 with: testObjectsFactory defaultPassword2 ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InnerInterface wrongPasswordErrorMessage.
			]! !


!InnerInterfaceTest methodsFor: 'setUp' stamp: 'RL 11/28/2020 09:30:32'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!InnerInterfaceTest methodsFor: 'mp protocol' stamp: 'RL 12/2/2020 19:37:08'!
debit: anAmount from: aCreditCard ! !


!InnerInterfaceTest methodsFor: 'checking out' stamp: 'RL 12/2/2020 19:33:57'!
test08CheckoutWithEmptyCCOwnerNameReturnsErrorMessage
	| interface cartID |
	
	interface := InnerInterface 
				newWith: testObjectsFactory defaultCatalog 
				for: testObjectsFactory clientDictWithOneClient 
				at: testObjectsFactory currentClock 
				communicatingWith: self.
	
	cartID := interface createCartFor: testObjectsFactory defaultClientID1 with: testObjectsFactory defaultPassword1 .
	
	self
		should: [ 
			interface checkoutCart: cartID 
				withCCNumber: '1111111111111111'
				expiring: (Month month: testObjectsFactory today monthIndex year: testObjectsFactory today yearNumber + 1) 
				ownedBy: ''.
			 ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InnerInterface emptyOwnerNameErrorMessage .
			]
	! !

!InnerInterfaceTest methodsFor: 'checking out' stamp: 'RL 12/2/2020 19:41:01'!
test09CheckoutWithCCOwnerNameLongerThan30CharactersReturnsErrorMessage
	| interface cartID |
	
	interface := InnerInterface 
				newWith: testObjectsFactory defaultCatalog 
				for: testObjectsFactory clientDictWithOneClient 
				at: testObjectsFactory currentClock 
				communicatingWith: self.
	
	cartID := interface createCartFor: testObjectsFactory defaultClientID1 with: testObjectsFactory defaultPassword1 .
	
	self
		should: [ 
			interface checkoutCart: cartID 
				withCCNumber: '1111111111111111'
				expiring: (Month month: testObjectsFactory today monthIndex year: testObjectsFactory today yearNumber + 1) 
				ownedBy: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'.
			 ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InnerInterface ownerNameLongerThan30ErrorMessage .
			]
	! !

!InnerInterfaceTest methodsFor: 'checking out' stamp: 'RL 12/2/2020 20:00:23'!
test10CheckingOutWithANonNumericCCNumberReturnsErrorMessage
	| interface cartID |
	
	interface := InnerInterface 
				newWith: testObjectsFactory defaultCatalog 
				for: testObjectsFactory clientDictWithOneClient 
				at: testObjectsFactory currentClock 
				communicatingWith: self.
	
	cartID := interface createCartFor: testObjectsFactory defaultClientID1 with: testObjectsFactory defaultPassword1 .
	
	self
		should: [ 
			interface checkoutCart: cartID 
				withCCNumber: '111111111111111a'
				expiring: (Month month: testObjectsFactory today monthIndex year: testObjectsFactory today yearNumber + 1) 
				ownedBy: 'Alan Kay'.
			 ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InnerInterface nonNumericCCNumberErrorMessage .
			]
	! !

!InnerInterfaceTest methodsFor: 'checking out' stamp: 'RL 12/2/2020 20:01:05'!
test11CheckingOutWithACCNumberLengthDifferentFrom16ReturnsErrorMessage
	| interface cartID |
	
	interface := InnerInterface 
				newWith: testObjectsFactory defaultCatalog 
				for: testObjectsFactory clientDictWithOneClient 
				at: testObjectsFactory currentClock 
				communicatingWith: self.
	
	cartID := interface createCartFor: testObjectsFactory defaultClientID1 with: testObjectsFactory defaultPassword1 .
	
	self
		should: [ 
			interface checkoutCart: cartID 
				withCCNumber: '111111111111111'
				expiring: (Month month: testObjectsFactory today monthIndex year: testObjectsFactory today yearNumber + 1) 
				ownedBy: 'Alan Kay'.
			 ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InnerInterface invalidCCNumberLengthErrorMessage .
			]
	! !

!InnerInterfaceTest methodsFor: 'checking out' stamp: 'RL 12/2/2020 20:03:34'!
test12CheckoutWithAnInvalidCartIDReturnsErrorMessage
	| interface |
	
	interface := InnerInterface 
				newWith: testObjectsFactory defaultCatalog 
				for: testObjectsFactory clientDictWithOneClient 
				at: testObjectsFactory currentClock 
				communicatingWith: self.
	
	interface createCartFor: testObjectsFactory defaultClientID1 with: testObjectsFactory defaultPassword1 .
	
	self
		should: [ 
			interface checkoutCart: testObjectsFactory invalidCartID 
				withCCNumber: '1111111111111111'
				expiring: (Month month: testObjectsFactory today monthIndex year: testObjectsFactory today yearNumber + 1) 
				ownedBy: 'Alan Kay'.
			 ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InnerInterface invalidCartErrorMessage .
			]
	! !

!InnerInterfaceTest methodsFor: 'checking out' stamp: 'RL 12/2/2020 21:17:48'!
test16CheckingOutAddsAPurchaseToTheClient
	| interface cartID |
	
	interface := InnerInterface 
				newWith: testObjectsFactory defaultCatalog 
				for: testObjectsFactory clientDictWithOneClient 
				at: testObjectsFactory currentClock
				communicatingWith: self.
				
	cartID := interface createCartFor: testObjectsFactory defaultClientID1 with: testObjectsFactory defaultPassword1 .
	interface add: 1 of: testObjectsFactory itemSellByTheStore toCart: cartID.
	interface checkoutCart: cartID 
		withCCNumber: '1111111111111111'
		expiring: (Month month: testObjectsFactory today monthIndex year: testObjectsFactory today yearNumber + 1) 
		ownedBy: 'Alan Kay'.
	
	self
		assert: (interface listPurchasesFor: testObjectsFactory defaultClientID1 with: testObjectsFactory defaultPassword1)
		equals: 
			(OrderedCollection 
				with: testObjectsFactory itemSellByTheStore 
				with: 1 
				with: (testObjectsFactory defaultCatalog at: testObjectsFactory itemSellByTheStore ))! !

!InnerInterfaceTest methodsFor: 'checking out' stamp: 'RL 12/3/2020 16:52:04'!
test17CheckingOutExpiredCartMakesItsIDInvalid
	| interface clock cartID |
	
	clock := testObjectsFactory currentClock .
	interface := InnerInterface 
				newWith: testObjectsFactory defaultCatalog 
				for: testObjectsFactory clientDictWithOneClient 
				at: clock
				communicatingWith: self.
	
	cartID := interface createCartFor: testObjectsFactory defaultClientID1 with: testObjectsFactory defaultPassword1.
	clock moveForwardMinutes: 31.
	
	self
		should: [ 
			interface checkoutCart: cartID 
				withCCNumber: '1111111111111111'
				expiring: (Month month: testObjectsFactory today monthIndex year: testObjectsFactory today yearNumber + 1) 
				ownedBy: 'Alan Kay'. 
			]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InnerInterface expiredCartErrorMessage .
			].
	
	self
		should: [ interface listCart: cartID. ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InnerInterface invalidCartErrorMessage .
			]! !

!InnerInterfaceTest methodsFor: 'checking out' stamp: 'RL 12/3/2020 16:52:10'!
test18CheckingOutCartMakesItsIDInvalid
	| interface clock cartID |
	
	clock := testObjectsFactory currentClock .
	interface := InnerInterface 
				newWith: testObjectsFactory defaultCatalog 
				for: testObjectsFactory clientDictWithOneClient 
				at: clock
				communicatingWith: self.
	
	cartID := interface createCartFor: testObjectsFactory defaultClientID1 with: testObjectsFactory defaultPassword1.
	interface add: 1 of: testObjectsFactory itemSellByTheStore toCart: cartID.
	interface checkoutCart: cartID 
		withCCNumber: '1111111111111111'
		expiring: (Month month: testObjectsFactory today monthIndex year: testObjectsFactory today yearNumber + 1) 
		ownedBy: 'Alan Kay'.
	
	self
		should: [ interface listCart: cartID. ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InnerInterface invalidCartErrorMessage .
			]! !

!InnerInterfaceTest methodsFor: 'checking out' stamp: 'RL 12/3/2020 16:52:32'!
test19CannotCheckOutCartIfItHasBeenInactiveFor30Minutes
	| interface clock cartID |
	
	clock := testObjectsFactory currentClock .
	interface := InnerInterface 
				newWith: testObjectsFactory defaultCatalog 
				for: testObjectsFactory clientDictWithOneClient 
				at: clock
				communicatingWith: self.
	
	cartID := interface createCartFor: testObjectsFactory defaultClientID1 with: testObjectsFactory defaultPassword1.
	clock moveForwardMinutes: 31.
	
	self
		should: [ 
			interface checkoutCart: cartID 
				withCCNumber: '1111111111111111'
				expiring: (Month month: testObjectsFactory today monthIndex year: testObjectsFactory today yearNumber + 1) 
				ownedBy: 'Alan Kay'. 
			]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InnerInterface expiredCartErrorMessage.]! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items lastActivityTime clientID'
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


!Cart methodsFor: 'initialization' stamp: 'RL 12/2/2020 21:14:28'!
initializeAcceptingItemsOf: aCatalog at: aClock for: aClientID
	clientID := aClientID .
	catalog := aCatalog.
	items := OrderedCollection new.
	lastActivityTime := aClock currentTime.! !


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


!Cart methodsFor: 'adding' stamp: 'RL 12/2/2020 19:04:13'!
add: anItem at: aClock

	^ self add: 1 of: anItem at: aClock.! !

!Cart methodsFor: 'adding' stamp: 'RL 12/2/2020 19:05:35'!
add: aQuantity of: anItem at: aClock

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ].
	self updateLastActivityTime: aClock.! !


!Cart methodsFor: 'as yet unclassified' stamp: 'RL 12/2/2020 21:30:34'!
clientID
	^clientID ! !

!Cart methodsFor: 'as yet unclassified' stamp: 'RL 12/2/2020 21:09:40'!
listItems
	^items! !

!Cart methodsFor: 'as yet unclassified' stamp: 'RL 12/2/2020 21:09:23'!
listItemsAt: aClock
	self updateLastActivityTime: aClock.
	^self listItems.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'RL 12/2/2020 19:07:03'!
updateLastActivityTime: aClock

	lastActivityTime := aClock currentTime.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'RL 12/2/2020 19:07:11'!
validateCartExpiracyAt: aClock
	^aClock currentTime - (Duration minutes: 30) > lastActivityTime.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'RL 12/2/2020 21:15:19'!
acceptingItemsOf: aCatalog at: aClock for: aClientID

	^self new initializeAcceptingItemsOf: aCatalog at: aClock for: aClientID! !


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

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'RL 12/3/2020 16:12:42'!
registerSale
	| itemBag resultingSales |
	itemBag := cart listItems asBag.
	resultingSales := (salesBook at: cart clientID ifAbsent: [ Bag new ]) addAll: itemBag.
	salesBook at: cart clientID put: resultingSales.! !


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
	instanceVariableNames: 'minuteShift'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'clock operations' stamp: 'RL 11/30/2020 20:45:31'!
currentTime
	"^DateAndTime now + (minuteShift * minute)."
	^DateAndTime now + (Duration minutes: minuteShift).! !

!Clock methodsFor: 'clock operations' stamp: 'RL 11/30/2020 20:49:08'!
moveForwardMinutes: aNumberOfMinutes
	minuteShift := minuteShift + aNumberOfMinutes! !


!Clock methodsFor: 'initialization' stamp: 'RL 11/30/2020 20:31:54'!
initialize
	minuteShift := 0! !


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


!classDefinition: #InnerInterface category: 'TusLibros'!
Object subclass: #InnerInterface
	instanceVariableNames: 'catalog carts registeredClients nextCartID clock cartsLastActivityTime merchantProcessor salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InnerInterface methodsFor: 'public interface' stamp: 'RL 12/3/2020 16:26:37'!
add: aQuantity of: anItem toCart: aCartID
	| cart |
	cart := self validCartForID: aCartID.
	cart add: aQuantity of: anItem at: clock.! !

!InnerInterface methodsFor: 'public interface' stamp: 'RL 12/3/2020 16:31:27'!
checkoutCart: cartID withCCNumber: aCCNumber expiring: anExpiringDate ownedBy: anOwnerName
	| cart cashier |
	cart := self validCartForID: cartID.
	self validateCCOwnerName: anOwnerName.
	self validateCCNumber: aCCNumber.
		
	cashier := Cashier
		toCheckout: cart
		charging: (CreditCard expiringOn: anExpiringDate)
		throught: merchantProcessor 
		on: DateAndTime now 
		registeringOn: salesBook.
	
	cashier checkOut.
		
	carts removeKey: cartID.! !

!InnerInterface methodsFor: 'public interface' stamp: 'RL 12/3/2020 16:35:20'!
createCartFor: clientID with: clientPassword
	self authenticate: clientID with: clientPassword.
	^self generateCartIDFor: clientID! !

!InnerInterface methodsFor: 'public interface' stamp: 'RL 12/3/2020 16:27:44'!
listCart: cartID
	| cart |
	cart := self validCartForID: cartID.
	^(cart listItemsAt: clock) asBag.! !

!InnerInterface methodsFor: 'public interface' stamp: 'RL 12/3/2020 16:39:59'!
listPurchasesFor: clientID with: clientPassword
	self authenticate: clientID with: clientPassword. 
	^self generatePurchasesListFor: clientID.! !


!InnerInterface methodsFor: 'private operations' stamp: 'RL 12/3/2020 16:32:12'!
authenticate: clientID with: clientPassword
	(registeredClients includesKey: clientID) ifFalse: [ ^Error signal: self class clientNotRegisteredErrorMessage ].
	((registeredClients at: clientID) = clientPassword) ifFalse: [^Error signal: self class wrongPasswordErrorMessage ].! !

!InnerInterface methodsFor: 'private operations' stamp: 'RL 12/3/2020 16:35:02'!
generateCartIDFor: clientID
	nextCartID := nextCartID + 1.	
	carts add: nextCartID->(self newCartFor: clientID).
	^nextCartID copy.! !

!InnerInterface methodsFor: 'private operations' stamp: 'RL 12/3/2020 16:37:37'!
generatePurchasesListFor: clientID
	| clientPurchases itemList total |
	clientPurchases := salesBook at: clientID ifAbsent: [ ^OrderedCollection with: 0 ].
	itemList := OrderedCollection new.
	total := 0.
	clientPurchases sortedElements do: [ :itemAssociation |
			total := total + (itemAssociation value * (catalog at: itemAssociation key)).
			itemList add: itemAssociation key.
			itemList add: itemAssociation value.
		 ].
	itemList add: total.
	^itemList ! !

!InnerInterface methodsFor: 'private operations' stamp: 'RL 12/3/2020 16:33:22'!
newCartFor: clientID
	^Cart acceptingItemsOf: catalog at: clock for: clientID.! !


!InnerInterface methodsFor: 'validations' stamp: 'RL 12/3/2020 16:27:26'!
validCartForID: aCartID
	| cart |
	cart := carts at: aCartID ifAbsent: [ ^Error signal: self class invalidCartErrorMessage ].
	self validateExpiracyFor: cart with: aCartID.
	^cart! !

!InnerInterface methodsFor: 'validations' stamp: 'RL 12/3/2020 16:30:17'!
validateCCNumber: aCCNumber
	aCCNumber do: [:digit | (digit asciiValue between: 48 and: 57) 
		ifFalse: [ ^Error signal: self class nonNumericCCNumberErrorMessage ]].
	aCCNumber size ~= 16 ifTrue: [ ^Error signal: self class invalidCCNumberLengthErrorMessage ].! !

!InnerInterface methodsFor: 'validations' stamp: 'RL 12/3/2020 16:29:13'!
validateCCOwnerName: anOwnerName
	anOwnerName isEmpty ifTrue: [ ^Error signal: self class emptyOwnerNameErrorMessage ].
	anOwnerName size > 30 ifTrue: [ ^Error signal: self class ownerNameLongerThan30ErrorMessage ].! !

!InnerInterface methodsFor: 'validations' stamp: 'RL 12/3/2020 16:23:43'!
validateExpiracyFor: aCart with: aCartID
	(aCart validateCartExpiracyAt: clock) ifTrue: [ 
		carts removeKey: aCartID.
		^Error signal: self class expiredCartErrorMessage 
		].! !


!InnerInterface methodsFor: 'initialization' stamp: 'RL 12/3/2020 15:03:22'!
initializeWith: aCatalog for: clients at: aClock communicatingWith: aMerchantProcessor
	catalog := aCatalog.
	carts := Dictionary new.
	registeredClients := clients.
	nextCartID := 1.
	clock := aClock .
	merchantProcessor := aMerchantProcessor. 
	salesBook := Dictionary new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InnerInterface class' category: 'TusLibros'!
InnerInterface class
	instanceVariableNames: ''!

!InnerInterface class methodsFor: 'as yet unclassified' stamp: 'RL 12/1/2020 16:12:18'!
clientNotRegisteredErrorMessage
	^'Not registered client.'! !

!InnerInterface class methodsFor: 'as yet unclassified' stamp: 'RL 12/2/2020 19:33:12'!
emptyOwnerNameErrorMessage
	^'Credit card owner name is empty.'! !

!InnerInterface class methodsFor: 'as yet unclassified' stamp: 'RL 11/30/2020 19:40:30'!
expiredCartErrorMessage
	^'Cart has expired.'! !

!InnerInterface class methodsFor: 'as yet unclassified' stamp: 'RL 12/2/2020 19:52:11'!
invalidCCNumberLengthErrorMessage
	^'Credit card length is invalid.'! !

!InnerInterface class methodsFor: 'as yet unclassified' stamp: 'RL 12/1/2020 16:08:21'!
invalidCartErrorMessage
	^'Invalid Cart ID.'! !

!InnerInterface class methodsFor: 'as yet unclassified' stamp: 'RL 12/2/2020 19:23:41'!
newWith: aCatalog for: clients at: aClock communicatingWith: aMerchantProcessor
	^self new initializeWith:  aCatalog for: clients at: aClock communicatingWith: aMerchantProcessor! !

!InnerInterface class methodsFor: 'as yet unclassified' stamp: 'RL 12/2/2020 19:46:02'!
nonNumericCCNumberErrorMessage
	^'Credit card number is non numeric.'! !

!InnerInterface class methodsFor: 'as yet unclassified' stamp: 'RL 12/2/2020 19:41:32'!
ownerNameLongerThan30ErrorMessage
	^'Credit card owner name has more than 30 characters.'! !

!InnerInterface class methodsFor: 'as yet unclassified' stamp: 'RL 12/1/2020 16:13:23'!
wrongPasswordErrorMessage
	^'Wrong password.'! !


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


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'RL 12/2/2020 21:16:25'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog at: self currentClock for: self defaultClientID1 ! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'RL 12/2/2020 18:35:09'!
invalidCartID
	^'invalidCart'! !


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


!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'RL 12/1/2020 17:58:45'!
clientDictWithOneClient
	| clients |
	clients := Dictionary new.
	clients add: self defaultClientID1 -> self defaultPassword1.
	^clients! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'RL 12/1/2020 18:09:48'!
clientDictWithTwoClients
	| clients |
	clients := Dictionary new.
	clients add: self defaultClientID1 -> self defaultPassword1.
	clients add: self defaultClientID2 -> self defaultPassword2.
	^clients! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'RL 12/1/2020 17:58:23'!
defaultClientID1
	^'client1'! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'RL 12/1/2020 18:09:24'!
defaultClientID2
	^'client2'! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'RL 12/1/2020 17:58:50'!
defaultPassword1
	^'password1'! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'RL 12/1/2020 18:08:40'!
defaultPassword2
	^'password2'! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'RL 12/1/2020 18:04:56'!
emptyClientDict
	^Dictionary new.! !


!StoreTestObjectsFactory methodsFor: 'clock' stamp: 'RL 12/1/2020 17:52:07'!
currentClock
	
	^ Clock new.! !
