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

!CartTest methodsFor: 'tests' stamp: 'FS 12/2/2020 18:11:44'!
test09CanNotAddNonIntegerQuantityOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 1.5 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !


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

!CashierTest methodsFor: 'tests' stamp: 'FS 12/2/2020 00:06:29'!
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
	self assert: salesBook first amount = total.! !

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



!classDefinition: #ClockTest category: 'TusLibros'!
TestCase subclass: #ClockTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ClockTest methodsFor: 'tests' stamp: 'FS 12/3/2020 11:53:59'!
test01TimesMovesForwardsCorrectly
	
	| clock aDateTimetoTest currentTime aTimeToLeapIntoTheFuture |
	
	currentTime _  DateAndTime now.
	aDateTimetoTest _ currentTime.
	aTimeToLeapIntoTheFuture _ 7 minutes.
	clock _ Clock startingAt: currentTime.
	
	clock moveForward: aTimeToLeapIntoTheFuture.
	
	self assert: aDateTimetoTest + aTimeToLeapIntoTheFuture equals: clock now.! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'validNumber validName today futureExpirationDate now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'FS 12/2/2020 02:02:05'!
test01CreditCardNumberShouldOnlyHave16Digits

	self should: [CreditCard withNumber: '123456789123456a' 
						withName: validName 
						expiringOn: futureExpirationDate] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: 
			[:anError | self assert: anError messageText equals: CreditCard invalidCreditCardNumberErrorMessage].! !

!CreditCardTest methodsFor: 'tests' stamp: 'FS 12/2/2020 02:02:05'!
test02CreditCardNameShouldNotBeBlank

	self should: [CreditCard withNumber: validNumber withName: '' expiringOn: futureExpirationDate ] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: 
			[:anError | self assert: anError messageText equals: CreditCard invalidCreditCardName].! !

!CreditCardTest methodsFor: 'tests' stamp: 'FS 12/2/2020 02:02:05'!
test03CanRetrieveCreditCardDataCorrectly

	| creditCard |
	creditCard  _ CreditCard withNumber: validNumber 
						  withName: validName 
						  expiringOn: futureExpirationDate.
						
	self assert: creditCard number equals: validNumber.
	self assert: creditCard owner equals: validName.
	self deny: (creditCard isExpiredOn:  now  ).! !


!CreditCardTest methodsFor: 'setUp' stamp: 'FS 12/2/2020 02:02:05'!
setUp
	validNumber _ '1234567891234567'.
	validName _ 'Jorge Matone'.
	today _ GregorianMonthOfYear current.
	futureExpirationDate _ today next.
	now _ DateAndTime now.! !


!classDefinition: #InternalRestInterfaceTest category: 'TusLibros'!
TestCase subclass: #InternalRestInterfaceTest
	instanceVariableNames: 'interfaceObjectsFactory storeObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalRestInterfaceTest methodsFor: 'setUp' stamp: 'FS 12/1/2020 17:43:28'!
setUp

	interfaceObjectsFactory := InterfaceTestObjectsFactory new.
	storeObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!InternalRestInterfaceTest methodsFor: 'testing - add/list cart' stamp: 'FS 12/2/2020 19:13:57'!
test04CannotAdItemsToNotExistingCart
	
	| interface cartToAddID |
	
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self.
	cartToAddID _ 5.
	
	self should: [interface addToCart: cartToAddID anItem: storeObjectsFactory itemSellByTheStore withQuantity: 1. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | 
							self assert: anError messageText = InternalRestInterface notActiveSessionError .
							self deny: (interface hasRegisteredCart: cartToAddID)
							].
	! !

!InternalRestInterfaceTest methodsFor: 'testing - add/list cart' stamp: 'FS 12/2/2020 19:14:01'!
test05CannotListNotExistingCart
	
	| interface |
	
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self.
	
	self should: [interface listCart: 5. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText = InternalRestInterface notActiveSessionError .
								self deny: (interface hasRegisteredCart: 5)]! !

!InternalRestInterfaceTest methodsFor: 'testing - add/list cart' stamp: 'FS 12/1/2020 17:44:01'!
test06CartHasNoItemsWhenCreated
	
	| interface cartId |
	
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self.
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	
	self assert: (interface listCart: cartId) isEmpty.! !

!InternalRestInterfaceTest methodsFor: 'testing - add/list cart' stamp: 'FS 12/1/2020 17:44:01'!
test07CartRemembersItemsAddedToIt
	
	| interface cartId validBook cartContent aQuantityToAdd |
	
	validBook _ storeObjectsFactory itemSellByTheStore.
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self.
	
	aQuantityToAdd _ 3.
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	interface addToCart: cartId anItem: validBook withQuantity: aQuantityToAdd. 
	
	cartContent _ interface listCart: cartId.
	
	self assert: (cartContent occurrencesOf: validBook) equals: aQuantityToAdd.! !


!InternalRestInterfaceTest methodsFor: 'testing - createCart' stamp: 'FS 12/2/2020 00:16:11'!
test01CannotCreateCartForUnregisteredUser
	
	| interface |
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self
.
	
	self should: [ interface createCartForUser: interfaceObjectsFactory invalidUser withPassword: '000'. ]
			raise: Error
			withExceptionDo: [ :anError | 					self assert: anError messageText =  InternalRestInterface invalidUserErrorMessage.
									  ].! !

!InternalRestInterfaceTest methodsFor: 'testing - createCart' stamp: 'FS 12/2/2020 00:16:26'!
test02CannotCreateCartWithIncorrectPassword
	
	| interface validUser |
	
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self .
	validUser _ interfaceObjectsFactory validUser .
	
	self should: [ interface createCartForUser: validUser withPassword: interfaceObjectsFactory invalidPassword . ]
			raise: Error
			withExceptionDo: [ :anError | 			self assert: anError messageText =  
										InternalRestInterface invalidPasswordErrorMessage.
									  ].! !

!InternalRestInterfaceTest methodsFor: 'testing - createCart' stamp: 'FS 12/1/2020 17:44:01'!
test03InterfaceRemembersCartsAndCartIDsDontCollide
	
	| interface anotherCartId cartId  |
						
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self .
	
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	anotherCartId _  interfaceObjectsFactory createCartForAnotherValidUserIn: interface.
	
	self assert: (interface hasRegisteredCart: cartId).
	self assert: (interface hasRegisteredCart: anotherCartId).
	self deny: (cartId = anotherCartId).! !


!InternalRestInterfaceTest methodsFor: 'testing - checkout / purchases' stamp: 'FS 12/2/2020 19:16:05'!
test08CannotCheckoutNotCreatedCart
	
	| interface |
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self .
	
	self should: [self checkout: 'invalidCartId' using: interface]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText = InternalRestInterface notActiveSessionError .].! !

!InternalRestInterfaceTest methodsFor: 'testing - checkout / purchases' stamp: 'FS 12/2/2020 15:02:03'!
test09CannotCheckoutEmptyCart
	
	| interface cartId |		
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self .
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	
	self should: [self checkout: cartId using: interface.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText = InternalRestInterface emptyCartErrorMessage.
							    self assert: interface salesBook isEmpty].! !

!InternalRestInterfaceTest methodsFor: 'testing - checkout / purchases' stamp: 'FS 12/2/2020 15:07:19'!
test10ClientStartsWithNoPurchases
	
	| interface userPurchaseHistory |
	
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self .
	
	userPurchaseHistory _  (interface listPurchasesOf: interfaceObjectsFactory validUser 
				                withPassword:  interfaceObjectsFactory validUserPassword) .
											      
	self assert: userPurchaseHistory amountPurchased equals: 0  .
	self assert: userPurchaseHistory itemsPurchased isEmpty  .
! !

!InternalRestInterfaceTest methodsFor: 'testing - checkout / purchases' stamp: 'FS 12/1/2020 17:44:01'!
test11CannotListPurchasesOfUnregisteredUser
	
	| interface |
	
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self .
	
	self should:[ interface listPurchasesOf: interfaceObjectsFactory invalidUser 
					  withPassword: '123']
		raise:Error - MessageNotUnderstood 
		withExceptionDo:[:anError | self assert: anError messageText = InternalRestInterface invalidUserErrorMessage ]
			 		  ! !

!InternalRestInterfaceTest methodsFor: 'testing - checkout / purchases' stamp: 'FS 12/1/2020 17:44:01'!
test12CannotListPurchasesWithInvalidPassword
	
	| interface |
	
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self .
	
	self should:[ interface listPurchasesOf: interfaceObjectsFactory validUser 
					  withPassword: interfaceObjectsFactory invalidPassword]
		raise:Error - MessageNotUnderstood 
		withExceptionDo:[:anError | self assert: anError messageText = InternalRestInterface invalidPasswordErrorMessage ]
			 		  ! !

!InternalRestInterfaceTest methodsFor: 'testing - checkout / purchases' stamp: 'FS 12/2/2020 00:17:43'!
test13TransactionIdsDontCollide

	| cartId interface aQuantityToBuy validBook transactionId anotherTransactionId anotherCartId |
 	
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self .
	
	cartId  _ interfaceObjectsFactory createCartForValidUserIn: interface .
	anotherCartId  _ interfaceObjectsFactory createCartForAnotherValidUserIn: interface .
	
	validBook _ storeObjectsFactory itemSellByTheStore .
	aQuantityToBuy _ 3.
	interface addToCart: cartId anItem: validBook withQuantity: aQuantityToBuy. 
	interface addToCart: anotherCartId anItem: validBook withQuantity: aQuantityToBuy. 
	
	transactionId _ self checkout: cartId using: interface.
	anotherTransactionId _ self checkout: anotherCartId using: interface.
	
	self deny: transactionId = anotherTransactionId.! !

!InternalRestInterfaceTest methodsFor: 'testing - checkout / purchases' stamp: 'FS 12/2/2020 17:06:40'!
test14ListPurchasesCorrectlyAfterCheckout
	| cartId interface userPurchases itemToBuy quantityToBuy  amountBought |
	
	interface _  interfaceObjectsFactory defaultInterfaceThrough: self .
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	itemToBuy _ storeObjectsFactory itemSellByTheStore.
	quantityToBuy _ 7.
	amountBought _ quantityToBuy * storeObjectsFactory itemSellByTheStorePrice .
	
	interface addToCart: cartId anItem: itemToBuy withQuantity: quantityToBuy.
	
	self checkout: cartId using: interface.
	
	userPurchases _ interface listPurchasesOf: interfaceObjectsFactory validUser 
						  withPassword: interfaceObjectsFactory validUserPassword .
	
	self assert: userPurchases amountPurchased equals: amountBought.
	self assert: (userPurchases itemsPurchased at: itemToBuy) equals: quantityToBuy.
! !


!InternalRestInterfaceTest methodsFor: 'checkout -- private' stamp: 'FS 12/2/2020 19:34:20'!
checkout: cartId using: interface

	^ interface checkoutCart: cartId 
							  withCreditCardNumber: interfaceObjectsFactory creditCardNumber 
							  withCreditCardExpiredAt: interfaceObjectsFactory futureDate 
							  withOwnerName: interfaceObjectsFactory ownersName! !


!InternalRestInterfaceTest methodsFor: 'testing - session' stamp: 'FS 12/2/2020 19:13:48'!
test15CannotListCartAfterSessionExpired

	| interface cartId clock |
	
	clock _ interfaceObjectsFactory clock.
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self .
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	
	clock moveForward: 30 minutes.
	
	self should: [interface listCart: cartId]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:anError | self assert: anError messageText = InternalRestInterface notActiveSessionError ]. 
					! !

!InternalRestInterfaceTest methodsFor: 'testing - session' stamp: 'FS 12/2/2020 19:13:44'!
test16CannotAddToCartAfterSessionExpired

	| interface cartId clock |
	
	clock _ interfaceObjectsFactory clock.
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self .
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	
	clock moveForward: 30 minutes.
	
	self should: [interface addToCart: cartId anItem: storeObjectsFactory itemSellByTheStore withQuantity: 1]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:anError | self assert: anError messageText = InternalRestInterface notActiveSessionError .]. 
					! !

!InternalRestInterfaceTest methodsFor: 'testing - session' stamp: 'FS 12/2/2020 19:13:40'!
test17CannotCheckoutCartAfterSessionExpired

	| interface cartId clock |
	
	clock _ interfaceObjectsFactory clock.
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self .
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	interface addToCart: cartId anItem: storeObjectsFactory itemSellByTheStore withQuantity: 1.
	clock moveForward: 30 minutes.
	
	self should: [self checkout: cartId using: interface]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:anError | 
								self assert: anError messageText = InternalRestInterface notActiveSessionError . 
								self assert:  interface salesBook isEmpty]. 
					! !

!InternalRestInterfaceTest methodsFor: 'testing - session' stamp: 'FS 12/1/2020 17:44:01'!
test18AddingToCartRefreshesSession

	| interface cartId clock |
	
	clock _ interfaceObjectsFactory clock.
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self .
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	
	clock moveForward: 20 minutes.
	interface listCart: cartId.
	clock moveForward: 20 minutes.
	
	self shouldntFail: [interface listCart:cartId.].! !

!InternalRestInterfaceTest methodsFor: 'testing - session' stamp: 'FS 12/1/2020 17:44:01'!
test19ListingCartRefreshesSession

	| interface cartId clock product cartContents |
	
	product _ storeObjectsFactory itemSellByTheStore.
	clock _ interfaceObjectsFactory clock.
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self .
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	clock moveForward: 20 minutes.
	interface addToCart: cartId anItem: product withQuantity: 1.
	clock moveForward: 20 minutes.
	
	self shouldntFail: [cartContents _ interface listCart: cartId].
	self assert: (cartContents occurrencesOf: product) equals: 1.! !

!InternalRestInterfaceTest methodsFor: 'testing - session' stamp: 'FS 12/2/2020 19:13:33'!
test20CheckingOutACartKillsSession

	| interface cartId product |
	
	product _ storeObjectsFactory itemSellByTheStore.
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self .
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	
	interface addToCart: cartId anItem: product withQuantity: 1.
	self checkout: cartId using: interface.
	
	self should: [interface listCart: cartId]
		 raise: Error - MessageNotUnderstood
		 withExceptionDo: [:anError | self assert: anError messageText = InternalRestInterface notActiveSessionError ].! !


!InternalRestInterfaceTest methodsFor: 'merchant processor protocol' stamp: 'FS 12/1/2020 17:40:06'!
debit: anAmount from: aCreditCard
	^debitBehavior value: anAmount value: aCreditCard! !


!classDefinition: #PurchaseHistoryTest category: 'TusLibros'!
TestCase subclass: #PurchaseHistoryTest
	instanceVariableNames: 'testObjectFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!PurchaseHistoryTest methodsFor: 'setUp' stamp: 'FS 12/2/2020 14:10:08'!
setUp
	testObjectFactory  _ StoreTestObjectsFactory new.! !


!PurchaseHistoryTest methodsFor: 'tests' stamp: 'FS 12/3/2020 12:04:23'!
test01HistoryUpdatesCorrectly
	| purchaseHistory newPurchase itemPurchased itemPurchasedPrice quantityPurchased totalPurchased |
	itemPurchased _ testObjectFactory itemSellByTheStore .
	itemPurchasedPrice _ testObjectFactory itemSellByTheStorePrice .
	quantityPurchased _ 7.
	totalPurchased _ quantityPurchased * itemPurchasedPrice.
	
	purchaseHistory _ PurchaseHistory using: testObjectFactory defaultCatalog.
	
	newPurchase _ Bag new  add: itemPurchased withOccurrences: quantityPurchased; yourself.
	purchaseHistory newPurchaseOf: newPurchase.
	
	self assert: (purchaseHistory itemsPurchased at: itemPurchased) equals: quantityPurchased.
	self assert: (purchaseHistory amountPurchased) equals: totalPurchased
	
	

	! !

!PurchaseHistoryTest methodsFor: 'tests' stamp: 'FS 12/3/2020 12:04:23'!
test02CannotUpdateWithItemsNotPresentInCatalog
	| purchaseHistory newPurchase itemNotInCatalog |

	itemNotInCatalog _ testObjectFactory itemNotSellByTheStore .
	
	purchaseHistory _ PurchaseHistory using: testObjectFactory defaultCatalog.
	
	newPurchase _ Bag new  add: itemNotInCatalog withOccurrences: 3; yourself.
	
	self should:[purchaseHistory newPurchaseOf: newPurchase.]
		raise: Error - MessageNotUnderstood
		withExceptionDo:[:anError| self assert: anError messageText = PurchaseHistory cannotUpdateWithItemNotInCatalog.
							  self assert: purchaseHistory amountPurchased equals: 0]
	
	
	

	! !

!PurchaseHistoryTest methodsFor: 'tests' stamp: 'FS 12/2/2020 14:39:53'!
test03CannotCreateHistoryWithEmptyCatalog
	
	self should:[PurchaseHistory using: Dictionary new.]
		raise: Error - MessageNotUnderstood
		withExceptionDo:[:anError | self assert: anError messageText = PurchaseHistory cannotCreateHistoryOnEmptyCatalog.
							     ] 
	
	
	
	

	! !


!classDefinition: #SaleTest category: 'TusLibros'!
TestCase subclass: #SaleTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SaleTest methodsFor: 'tests' stamp: 'FS 12/2/2020 14:58:02'!
test01AmountShouldBePositive
	
	self should: [Sale for: -1 ]
	 raise: Error - MessageNotUnderstood
	 withExceptionDo: [:anError | self assert: anError messageText = 
										Sale amountShouldBePositive]
	
	 ! !


!classDefinition: #SessionCartTest category: 'TusLibros'!
TestCase subclass: #SessionCartTest
	instanceVariableNames: 'storeObjectFactory interfaceObjectFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SessionCartTest methodsFor: 'tests' stamp: 'FS 12/2/2020 18:56:26'!
test01SessionExpiresSessionCorrectly
	|   cartSession expirationTime |
 	expirationTime _ 30 minutes.
	cartSession _ SessionCart        with: Cart new usedLastOn: (storeObjectFactory today) 
						    ownedBy: 'User' 
						    for:(interfaceObjectFactory defaultInterfaceThrough:self) . 
						
	self assert: cartSession owner equals: 'User'.
	self deny: (cartSession isExpiredOn: (storeObjectFactory today)).
	self assert: (cartSession isExpiredOn: (storeObjectFactory today + expirationTime)).! !

!SessionCartTest methodsFor: 'tests' stamp: 'FS 12/2/2020 18:56:26'!
test02SessionUpdatesLastUsedTimeCorrectly
	| cartSession expirationTime |
 
	expirationTime _ 30 minutes.
	cartSession _  SessionCart        with: Cart new usedLastOn: (storeObjectFactory today) 
						    ownedBy: 'User' 
						    for:(interfaceObjectFactory defaultInterfaceThrough:self) . 
						
	cartSession updateLastTimeUsed: storeObjectFactory today + 10 minutes.
	self deny: (cartSession isExpiredOn: (storeObjectFactory today + expirationTime)).! !

!SessionCartTest methodsFor: 'tests' stamp: 'FS 12/2/2020 18:56:26'!
test03SessionOwnerNameShouldNotBeBlank
 
	self should: [ SessionCart  with: Cart new usedLastOn: (storeObjectFactory today) 
				           ownedBy: '' 
				           for:(interfaceObjectFactory defaultInterfaceThrough:self) .  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo:[:anError | self assert: anError messageText = SessionCart cannotCreateSessionWithBlankOwnersName]		
						
 ! !


!SessionCartTest methodsFor: 'merchant processor protocol' stamp: 'FS 12/2/2020 17:46:50'!
debit: anAmount from: aCreditCard
	^debitBehavior value: anAmount value:aCreditCard ! !


!SessionCartTest methodsFor: 'setUp' stamp: 'FS 12/2/2020 17:46:06'!
setUp
	storeObjectFactory _ StoreTestObjectsFactory new.
	interfaceObjectFactory _ InterfaceTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


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

!Cart methodsFor: 'assertions' stamp: 'FS 12/2/2020 18:13:22'!
assertIsValidQuantity: aQuantity
	
	
	(aQuantity strictlyPositive and: aQuantity isInteger) ifFalse: [ self error: self invalidQuantityErrorMessage ].
! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'FS 12/2/2020 02:47:24'!
contents
	^items copy asBag ! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'FS 12/2/2020 14:38:12'!
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

!Cashier methodsFor: 'checkout - private' stamp: 'FS 12/2/2020 14:38:37'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'FS 12/2/2020 13:42:37'!
createSale

	^ Sale for: total
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
	instanceVariableNames: 'clockCurrentTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'accesing' stamp: 'FS 12/3/2020 11:53:05'!
now
	^clockCurrentTime. ! !


!Clock methodsFor: 'time control' stamp: 'FS 12/3/2020 11:53:05'!
moveForward: aTimelapseToMoveForward
	^clockCurrentTime _ clockCurrentTime + aTimelapseToMoveForward.! !


!Clock methodsFor: 'initialization' stamp: 'FS 12/3/2020 11:53:05'!
initializeStartingAt: aDateAndTimeToStartFrom 
	clockCurrentTime := aDateAndTimeToStartFrom.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Clock class' category: 'TusLibros'!
Clock class
	instanceVariableNames: ''!

!Clock class methodsFor: 'instance creation' stamp: 'HG 12/1/2020 11:01:58'!
startingAt: aDateAndTime 
	^self new initializeStartingAt: aDateAndTime ! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration cardNumber ownersName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'FS 12/2/2020 02:05:51'!
isExpiredOn: aDateTime
	
	^expiration  < (GregorianMonthOfYear yearNumber: aDateTime yearNumber monthNumber: aDateTime monthIndex )! !


!CreditCard methodsFor: 'initialization' stamp: 'FS 12/2/2020 00:43:09'!
initializeWithNumber: aCardNumber withName: anOwnersName expiringOn: aMonthOfYear 
	cardNumber := aCardNumber.
	ownersName := anOwnersName.
	expiration := aMonthOfYear.! !


!CreditCard methodsFor: 'accessing' stamp: 'FS 12/2/2020 18:22:48'!
number
	^cardNumber copy! !

!CreditCard methodsFor: 'accessing' stamp: 'FS 12/2/2020 18:22:45'!
owner
	^ownersName copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'assertions' stamp: 'FS 12/2/2020 00:40:06'!
assertIsAValidCreditCardNumber: aCreditCardNumber
	
	(self isAValidCreditCardNumber: aCreditCardNumber) ifFalse: [self error: self invalidCreditCardNumberErrorMessage ]. ! !

!CreditCard class methodsFor: 'assertions' stamp: 'FS 12/2/2020 00:40:13'!
assertIsValidOwnerName: anOwnerName

	( anOwnerName isEmpty ) ifTrue: [self error: self invalidCreditCardName ].
	! !


!CreditCard class methodsFor: 'testing' stamp: 'FS 12/2/2020 00:34:45'!
isAValidCreditCardNumber: aCreditCardNumber

	^ (aCreditCardNumber size = 16) and: [ aCreditCardNumber allSatisfy: [:aDigit | aDigit isDigit]].! !


!CreditCard class methodsFor: 'instance creation' stamp: 'FS 12/2/2020 00:42:40'!
withNumber: aCardNumber withName: anOwnersName  expiringOn: aMonthOfYear 
	
	self assertIsAValidCreditCardNumber: aCardNumber.
	self assertIsValidOwnerName: anOwnersName.
	
	^self new initializeWithNumber: aCardNumber withName: anOwnersName expiringOn: aMonthOfYear! !


!CreditCard class methodsFor: 'error description' stamp: 'FS 12/2/2020 00:39:27'!
invalidCreditCardName
	^'Credit card name should not be blank'! !

!CreditCard class methodsFor: 'error description' stamp: 'FS 12/2/2020 00:39:04'!
invalidCreditCardNumberErrorMessage
	^'Credit card number is invalid'! !


!classDefinition: #InterfaceTestObjectsFactory category: 'TusLibros'!
Object subclass: #InterfaceTestObjectsFactory
	instanceVariableNames: 'clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InterfaceTestObjectsFactory methodsFor: 'cart' stamp: 'FS 12/1/2020 16:09:04'!
createCartForAnotherValidUserIn: aRestInterface

	^aRestInterface createCartForUser: self anotherValidUser withPassword: self anotherValidUserPassword.! !

!InterfaceTestObjectsFactory methodsFor: 'cart' stamp: 'FS 12/1/2020 00:05:23'!
createCartForValidUserIn: aRestInterface

	^aRestInterface createCartForUser: self validUser withPassword: self validUserPassword.! !


!InterfaceTestObjectsFactory methodsFor: 'users' stamp: 'FS 12/1/2020 16:08:13'!
anotherValidUser 
	^  'Usuario2' ! !

!InterfaceTestObjectsFactory methodsFor: 'users' stamp: 'FS 12/1/2020 16:08:25'!
anotherValidUserPassword
	^  '456' ! !

!InterfaceTestObjectsFactory methodsFor: 'users' stamp: 'FS 12/2/2020 02:19:06'!
defaultInterfaceThrough: aMerchantProcessor
	^InternalRestInterface 
		withValidUsers: self defaultUsers 
		withCatalog: StoreTestObjectsFactory new defaultCatalog
		using: clock
		through: aMerchantProcessor 
		withSessionExpirationTime: 30 minutes.! !

!InterfaceTestObjectsFactory methodsFor: 'users' stamp: 'FS 12/1/2020 16:08:04'!
defaultUsers
	^ Dictionary new 
		at: self validUser put: self validUserPassword;
		at: self anotherValidUser put: self anotherValidUserPassword;  yourself.! !

!InterfaceTestObjectsFactory methodsFor: 'users' stamp: 'FS 12/1/2020 02:01:25'!
invalidPassword
	^'invalidPassword'! !

!InterfaceTestObjectsFactory methodsFor: 'users' stamp: 'FS 12/1/2020 00:05:57'!
invalidUser
	
	^ 'invalidUser'! !

!InterfaceTestObjectsFactory methodsFor: 'users' stamp: 'FS 12/1/2020 00:06:06'!
validUser 
	^  'Usuario1' ! !

!InterfaceTestObjectsFactory methodsFor: 'users' stamp: 'FS 12/1/2020 00:06:16'!
validUserPassword
	^  '123' ! !


!InterfaceTestObjectsFactory methodsFor: 'credit card' stamp: 'FS 12/1/2020 01:31:32'!
creditCardNumber
	^'1232323232323232'! !

!InterfaceTestObjectsFactory methodsFor: 'credit card' stamp: 'FS 12/2/2020 19:34:20'!
futureDate
	^GregorianMonthOfYear current next! !

!InterfaceTestObjectsFactory methodsFor: 'credit card' stamp: 'FS 12/1/2020 01:19:56'!
ownersName
	^'Jorge Matone'! !


!InterfaceTestObjectsFactory methodsFor: 'initialization' stamp: 'FS 12/2/2020 02:00:40'!
initialize
	clock _ Clock startingAt: DateAndTime now.! !


!InterfaceTestObjectsFactory methodsFor: 'clock' stamp: 'HG 12/1/2020 14:41:14'!
clock
	^clock.! !


!classDefinition: #InternalRestInterface category: 'TusLibros'!
Object subclass: #InternalRestInterface
	instanceVariableNames: 'validUsers sessions lastCartId catalog lastTransactionId clock merchantProcessor usersHistory expirationTime salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalRestInterface methodsFor: 'initialization' stamp: 'FS 12/2/2020 19:35:36'!
initializeUsersHistory 
	usersHistory _ Dictionary new.
	validUsers keysDo: [:anUser | usersHistory at: anUser put: (PurchaseHistory using: catalog) ].
	
	! !

!InternalRestInterface methodsFor: 'initialization' stamp: 'FS 12/2/2020 18:58:20'!
initializeWithValidUsers: aValidUsersList withCatalog: aCatalog withClock: aClock through: aMerchantProcessor
withExpirationTime: aTimeForSessionToExpire.
	validUsers := aValidUsersList.
	
	lastCartId _ 1.
	lastTransactionId _ 0.

	merchantProcessor _ aMerchantProcessor .
	catalog _ aCatalog.
	clock _ aClock.
	expirationTime _ aTimeForSessionToExpire .
	
	sessions _ Dictionary new.
	self initializeUsersHistory.
	salesBook _ OrderedCollection new.
	! !


!InternalRestInterface methodsFor: 'authentication' stamp: 'FS 12/3/2020 11:55:39'!
authenticateUser: anUser withPassword: anUserPassword

	| validUserPassword |
	
	validUserPassword _ validUsers at: anUser 
								ifAbsent: [self error: self class invalidUserErrorMessage.]. 
								
	(validUserPassword = anUserPassword) 
								ifFalse: [ self error: self class invalidPasswordErrorMessage. ]! !


!InternalRestInterface methodsFor: 'cart creation' stamp: 'FS 12/3/2020 11:55:50'!
createCartForUser: anUser withPassword: anUserPassword
	
	| newCartId cart |
	self authenticateUser: anUser withPassword: anUserPassword.
		
	newCartId _ self generateCartId.
	cart _ Cart acceptingItemsOf: catalog.

	sessions at: newCartId put: (SessionCart with: cart usedLastOn: clock now
						   ownedBy: anUser
						   for: self).	
	^newCartId copy.! !

!InternalRestInterface methodsFor: 'cart creation' stamp: 'HG 12/1/2020 10:03:32'!
generateCartId
	lastCartId _ lastCartId + 1.
	^lastCartId asString.! !


!InternalRestInterface methodsFor: 'testing' stamp: 'FS 12/3/2020 11:56:55'!
hasRegisteredCart: aCartIDToTest 
	^sessions includesKey: aCartIDToTest.! !


!InternalRestInterface methodsFor: 'session' stamp: 'FS 12/3/2020 11:57:05'!
updateSessionOf: aCartID with: aDateTime

	^ (sessions at: aCartID) updateLastTimeUsed: aDateTime. ! !

!InternalRestInterface methodsFor: 'session' stamp: 'FS 12/3/2020 11:57:18'!
userOwnerOf: aCartID
	^(sessions at: aCartID) owner! !


!InternalRestInterface methodsFor: 'adding' stamp: 'FS 12/3/2020 11:58:58'!
addToCart: aCartID anItem: anItem withQuantity: aQuantity 
	
	| aCartToAdd |
	aCartToAdd _ self cartWithID: aCartID.
	self updateSessionOf: aCartID with: clock now.
	
	aCartToAdd add: aQuantity of: anItem.! !


!InternalRestInterface methodsFor: 'accessing -- private' stamp: 'FS 12/3/2020 11:59:08'!
cartWithID: aCartID

	| sessionCart |
	sessionCart _  sessions at: aCartID 		ifAbsent: [self error: self class notActiveSessionError ].
	self assertSessionNotExpiredOf: sessionCart.
	
	^sessionCart.! !

!InternalRestInterface methodsFor: 'accessing -- private' stamp: 'FS 12/2/2020 17:42:49'!
expirationTime
	^expirationTime ! !

!InternalRestInterface methodsFor: 'accessing -- private' stamp: 'FS 12/2/2020 15:02:39'!
salesBook
	^salesBook copy! !


!InternalRestInterface methodsFor: 'accessing' stamp: 'FS 12/3/2020 12:01:19'!
listCart: aCartID 
	
	| aCartToListContents |
	aCartToListContents _ self cartWithID: aCartID.
	self updateSessionOf: aCartID with: clock now.
	
	^aCartToListContents contents.! !

!InternalRestInterface methodsFor: 'accessing' stamp: 'FS 12/2/2020 19:35:36'!
listPurchasesOf: anUsername withPassword: aPassword 

	self authenticateUser: anUsername withPassword: aPassword.
	
	^usersHistory at: anUsername! !


!InternalRestInterface methodsFor: 'checkout' stamp: 'FS 12/3/2020 12:08:31'!
checkoutCart: aCartID   withCreditCardNumber: aCreditCardNumber 
					withCreditCardExpiredAt: anExpirationDate 
					withOwnerName: aName 
	| cartToCheckOut  |
	
	cartToCheckOut _ self cartWithID: aCartID.
	
	self assertIsNotEmpty: cartToCheckOut .
		
	self processSaleOf: cartToCheckOut withCreditCardNumber: aCreditCardNumber
					                       withCreditCardExpiredAt: anExpirationDate 
					                       withOwnerName: aName .
	
	self updateUserHistoryWhoOwns: aCartID andPurchased: cartToCheckOut.
	
	sessions removeKey: aCartID.

	^self generateTransactionId copy.
	! !


!InternalRestInterface methodsFor: 'assertions' stamp: 'FS 12/3/2020 11:54:52'!
assertIsNotEmpty: aCartToTest

	^ aCartToTest isEmpty ifTrue: [self error: self class emptyCartErrorMessage]! !

!InternalRestInterface methodsFor: 'assertions' stamp: 'FS 12/3/2020 11:54:57'!
assertSessionNotExpiredOf: aCartSessionToTest
	
	(aCartSessionToTest isExpiredOn: clock now) ifTrue: [^self error: self class notActiveSessionError ].! !


!InternalRestInterface methodsFor: 'user history -- private' stamp: 'FS 12/3/2020 12:09:52'!
updateHistoryOf: anUserToUpdateHistory whoPurchased: itemsSold
	| userPurchasesHistory |
	
	userPurchasesHistory _ usersHistory at: anUserToUpdateHistory . 
	userPurchasesHistory newPurchaseOf: itemsSold .

	! !

!InternalRestInterface methodsFor: 'user history -- private' stamp: 'FS 12/3/2020 12:09:59'!
updateUserHistoryWhoOwns: aCartID andPurchased: aCartSold
	| userCheckingOut |
	
	userCheckingOut _ self userOwnerOf: aCartID.
	self updateHistoryOf: userCheckingOut whoPurchased: aCartSold contents.
	! !


!InternalRestInterface methodsFor: 'checkout -- private' stamp: 'HG 12/1/2020 10:03:59'!
generateTransactionId
	lastTransactionId _ lastTransactionId + 1.
	^lastTransactionId asString.! !

!InternalRestInterface methodsFor: 'checkout -- private' stamp: 'FS 12/2/2020 20:17:13'!
processSaleOf: aCartToCheckOut withCreditCardNumber: aCreditCardNumber
					              withCreditCardExpiredAt: anExpirationDate 
					              withOwnerName: aName 
	| cashierToCheckoutOn userCreditCard |
	
	userCreditCard _ CreditCard withNumber: aCreditCardNumber  withName: aName expiringOn: anExpirationDate.
	
	cashierToCheckoutOn _ Cashier toCheckout: aCartToCheckOut charging: userCreditCard 
					throught: merchantProcessor 
					on: clock now 
					registeringOn: salesBook .
	cashierToCheckoutOn checkOut.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InternalRestInterface class' category: 'TusLibros'!
InternalRestInterface class
	instanceVariableNames: ''!

!InternalRestInterface class methodsFor: 'instance creation' stamp: 'FS 12/2/2020 15:41:59'!
withValidUsers: aValidUsersList withCatalog: aCatalog using: aClock through: aMerchantProcessor 
withSessionExpirationTime: aTimeForASessionToExpire

	^self new initializeWithValidUsers: aValidUsersList 
			withCatalog: aCatalog 
			withClock: aClock
			through:aMerchantProcessor 
			withExpirationTime: aTimeForASessionToExpire.! !


!InternalRestInterface class methodsFor: 'error description' stamp: 'HG 12/1/2020 00:45:13'!
emptyCartErrorMessage
	^'Carrito vacío para checkout'.! !

!InternalRestInterface class methodsFor: 'error description' stamp: 'HG 11/30/2020 19:15:07'!
invalidPasswordErrorMessage
	^'Contraseña inválida'.! !

!InternalRestInterface class methodsFor: 'error description' stamp: 'HG 11/30/2020 18:54:54'!
invalidUserErrorMessage
	^'Usuario inválido'.! !

!InternalRestInterface class methodsFor: 'error description' stamp: 'FS 12/2/2020 19:11:07'!
notActiveSessionError
	^'Cart has no active session'.! !


!classDefinition: #PurchaseHistory category: 'TusLibros'!
Object subclass: #PurchaseHistory
	instanceVariableNames: 'totalAmount itemsBought priceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!PurchaseHistory methodsFor: 'initialization' stamp: 'FS 12/3/2020 12:12:33'!
initializeUsing: aCatalog
	priceList  _ aCatalog.
	itemsBought _ Dictionary new.
	totalAmount _ 0.
	! !


!PurchaseHistory methodsFor: 'accessing -- private' stamp: 'FS 12/3/2020 12:12:42'!
priceOf: anItemPurchased
	^ priceList at: anItemPurchased .! !


!PurchaseHistory methodsFor: 'adding -- private' stamp: 'FS 12/3/2020 12:13:15'!
addItemPurchasedToHistory: anItemPurchased

	|previousQuantityPurchased|
			previousQuantityPurchased _ itemsBought at: anItemPurchased ifAbsent:[0] .
			itemsBought at: anItemPurchased put: 1 + previousQuantityPurchased! !


!PurchaseHistory methodsFor: 'updating -- private' stamp: 'FS 12/3/2020 12:13:04'!
updateHistoryUsing: aCollectionOfItemsSold

	^ aCollectionOfItemsSold do: [:anItemSold | 						self addItemPurchasedToHistory: anItemSold.						]! !

!PurchaseHistory methodsFor: 'updating -- private' stamp: 'FS 12/3/2020 12:19:31'!
updateTotalAmountUsing: aCollectionOfItemsPurchased .
	
	totalAmount  _ aCollectionOfItemsPurchased inject: totalAmount 
								      into:[ :subTotal :nextItem | subTotal + (self priceOf: nextItem)]
	! !


!PurchaseHistory methodsFor: 'updating' stamp: 'FS 12/3/2020 12:19:47'!
newPurchaseOf: aCollectionOfItemsPurchased
	
	self assertItemsAreInPriceList: aCollectionOfItemsPurchased .
	
	self updateHistoryUsing: aCollectionOfItemsPurchased .
	self updateTotalAmountUsing: aCollectionOfItemsPurchased .
	
	! !


!PurchaseHistory methodsFor: 'accessing' stamp: 'FS 12/2/2020 15:06:42'!
amountPurchased
	^totalAmount ! !

!PurchaseHistory methodsFor: 'accessing' stamp: 'FS 12/2/2020 15:07:19'!
itemsPurchased
	^itemsBought copy! !


!PurchaseHistory methodsFor: 'testing -- private' stamp: 'FS 12/3/2020 12:16:20'!
itemIsInPriceList: anItemPurchased

	^ priceList includesKey: anItemPurchased! !


!PurchaseHistory methodsFor: 'assertions' stamp: 'FS 12/3/2020 12:15:46'!
assertItemsAreInPriceList: aCollectionOfItemsPurchased
	(aCollectionOfItemsPurchased allSatisfy: [:anItemPurchased | self itemIsInPriceList: anItemPurchased])
					ifFalse:[self error: self class cannotUpdateWithItemNotInCatalog ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PurchaseHistory class' category: 'TusLibros'!
PurchaseHistory class
	instanceVariableNames: ''!

!PurchaseHistory class methodsFor: 'assertions' stamp: 'FS 12/2/2020 14:50:05'!
assertPriceListNotEmpty: aPriceList 
	(aPriceList isEmpty) ifTrue:[self error: self cannotCreateHistoryOnEmptyCatalog ]! !


!PurchaseHistory class methodsFor: 'instance creation' stamp: 'FS 12/2/2020 14:48:56'!
using: aPriceList
	self assertPriceListNotEmpty: aPriceList.
	^self new initializeUsing: aPriceList! !


!PurchaseHistory class methodsFor: 'error description' stamp: 'FS 12/2/2020 14:40:18'!
cannotCreateHistoryOnEmptyCatalog
	^'Cannot create history on empty catalog'! !

!PurchaseHistory class methodsFor: 'error description' stamp: 'FS 12/2/2020 14:40:41'!
cannotUpdateWithItemNotInCatalog
	^'Cannot update with Item not present in price list'! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'amount itemsSold'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'initialization' stamp: 'FS 12/2/2020 14:55:48'!
initializeFor:	 anAmount.
	amount  _ anAmount .
! !


!Sale methodsFor: 'accessing' stamp: 'FS 12/1/2020 21:50:01'!
amount
	^amount! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'assertions' stamp: 'FS 12/2/2020 14:57:24'!
assertAmountIsPositive: anAmount
	(anAmount >0) ifFalse: [self error: self amountShouldBePositive]! !


!Sale class methodsFor: 'instance creation' stamp: 'FS 12/2/2020 14:57:33'!
for: anAmount
	self assertAmountIsPositive: anAmount.
	
	^self new initializeFor: anAmount .
	! !


!Sale class methodsFor: 'error description' stamp: 'FS 12/2/2020 14:57:46'!
amountShouldBePositive
	^'Cannot create receipt for non positive amount'! !


!classDefinition: #SessionCart category: 'TusLibros'!
Object subclass: #SessionCart
	instanceVariableNames: 'cart lastTimeUsed nameOwner interfaceOwningSession'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SessionCart methodsFor: 'initialization' stamp: 'FS 12/3/2020 11:31:54'!
initializeWith: aCart usedLastOn: aTimeWhenWasLastUsed ownedBy: aNameOwner for: anInterface 
	lastTimeUsed := aTimeWhenWasLastUsed.
	nameOwner := aNameOwner.
	interfaceOwningSession := anInterface.
	cart _ aCart.! !


!SessionCart methodsFor: 'accessing' stamp: 'FS 12/2/2020 18:21:19'!
owner
	^nameOwner copy! !


!SessionCart methodsFor: 'testing' stamp: 'FS 12/3/2020 11:31:54'!
isExpiredOn: aDateAndTime 
	^aDateAndTime - lastTimeUsed >= interfaceOwningSession expirationTime ! !


!SessionCart methodsFor: 'updating' stamp: 'FS 12/2/2020 02:59:21'!
updateLastTimeUsed: aDateAndTime 
	lastTimeUsed _ aDateAndTime ! !


!SessionCart methodsFor: 'cart adding' stamp: 'FS 12/2/2020 18:53:13'!
add: anItem
	cart add: anItem! !

!SessionCart methodsFor: 'cart adding' stamp: 'FS 12/2/2020 18:52:44'!
add: aQuantity of: anItem
	cart add: aQuantity of: anItem.! !


!SessionCart methodsFor: 'cart queries' stamp: 'FS 12/2/2020 18:54:28'!
contents
	^cart contents! !


!SessionCart methodsFor: 'cart testing' stamp: 'FS 12/2/2020 18:55:16'!
isEmpty
	^cart isEmpty! !


!SessionCart methodsFor: 'cart total' stamp: 'FS 12/2/2020 19:05:21'!
total
	^cart total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SessionCart class' category: 'TusLibros'!
SessionCart class
	instanceVariableNames: ''!

!SessionCart class methodsFor: 'error description' stamp: 'FS 12/2/2020 16:24:16'!
cannotCreateSessionWithBlankOwnersName
	^'Cannot create session with blank owners name'! !


!SessionCart class methodsFor: 'assertions' stamp: 'FS 12/2/2020 16:25:53'!
assertNameNotBlank: aOwnersName
	(aOwnersName isEmpty) ifTrue: [self error: self cannotCreateSessionWithBlankOwnersName ]! !


!SessionCart class methodsFor: 'instance creation' stamp: 'FS 12/2/2020 18:56:45'!
with: aCart usedLastOn: aTimeWhenWasLastUsed ownedBy: aNameOwner for: anInterface 
	self assertNameNotBlank: aNameOwner.
	^self new initializeWith: aCart usedLastOn: aTimeWhenWasLastUsed ownedBy: aNameOwner for: anInterface ! !


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


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'FS 12/2/2020 02:04:15'!
expiredCreditCard
	
	^CreditCard withNumber: '1234567891234567' withName: 'Jorge' 
											expiringOn: (GregorianMonthOfYear yearNumber: today yearNumber
											 monthNumber: today monthIndex ) 
											 previous.
		 ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'FS 12/2/2020 02:03:38'!
notExpiredCreditCard
	
	^CreditCard withNumber: '1234567891234567' 
			     withName:  'Jorge' 
			     expiringOn: (GregorianMonthOfYear yearNumber: today yearNumber
											 monthNumber: today monthIndex ) 
											 next.! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
