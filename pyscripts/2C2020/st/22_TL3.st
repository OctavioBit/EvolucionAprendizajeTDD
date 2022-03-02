!classDefinition: #CartTest category: 'TusLibros - Exercise - III'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - III'!

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


!classDefinition: #CashierTest category: 'TusLibros - Exercise - III'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - III'!

!CashierTest methodsFor: 'tests' stamp: 'fr 12/3/2020 04:50:32'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook
			for: testObjectsFactory validUser]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'fr 12/3/2020 04:50:37'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new
		for: testObjectsFactory validUser.
		
	self assert: cashier checkOut total = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'fr 12/3/2020 04:50:41'!
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
				registeringOn: salesBook
				for: testObjectsFactory validUser ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'fr 12/3/2020 04:50:45'!
test04CheckoutRegistersASale

	| cart cashier salesBook receipt |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook
		for: testObjectsFactory validUser.
		
	receipt := cashier checkOut total.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = receipt.! !

!CashierTest methodsFor: 'tests' stamp: 'fr 12/3/2020 04:50:49'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook receipt creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook
		for: testObjectsFactory validUser.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	receipt := cashier checkOut total.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = receipt.! !

!CashierTest methodsFor: 'tests' stamp: 'fr 12/3/2020 04:50:54'!
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
		registeringOn: salesBook
		for: testObjectsFactory validUser.
		
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


!classDefinition: #TusLibrosFacadeTest category: 'TusLibros - Exercise - III'!
TestCase subclass: #TusLibrosFacadeTest
	instanceVariableNames: 'facade objectFactory salesBook clock credentials merchantProcessorTransactionId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - III'!

!TusLibrosFacadeTest methodsFor: 'tests - create cart' stamp: 'fr 12/3/2020 02:01:05'!
test01CanCreateNewCartWithValidCredentials

	| cartId  |
	cartId _ facade newCartForUser: objectFactory validUser andPassword: objectFactory validPassword.
	
	self assert: (facade listCart: cartId) isEmpty! !

!TusLibrosFacadeTest methodsFor: 'tests - create cart' stamp: 'fr 12/3/2020 05:08:26'!
test02CanNotCreateNewCartForInvalidUser
		
	self assertCreatingACartFailsForUser: objectFactory invalidUser withPassword: objectFactory validPassword.
		! !

!TusLibrosFacadeTest methodsFor: 'tests - create cart' stamp: 'fr 12/3/2020 05:08:54'!
test03CanNotCreateNewCartForInvalidPassword
		
	self assertCreatingACartFailsForUser: objectFactory validUser withPassword: objectFactory invalidPassword.

		! !


!TusLibrosFacadeTest methodsFor: 'tests - list cart' stamp: 'fr 12/3/2020 05:10:47'!
test04CanNotListNonexistentCart
		
	self assertBlockFailsForInvalidCart: [facade listCart: objectFactory invalidCartId]! !

!TusLibrosFacadeTest methodsFor: 'tests - list cart' stamp: 'fr 12/3/2020 00:15:32'!
test14CanNotListAnExpiredCart

	| cartId |
	cartId _ facade newCartForUser: objectFactory validUser andPassword: objectFactory validPassword.	
	clock advanceHalfAnHour.
	self  should: [facade listCart: cartId]
		raise: Error - MessageNotUnderstood
		description: TusLibrosFacade cartExpiredErrorDescription
	
	
	
	
	! !


!TusLibrosFacadeTest methodsFor: 'tests - add' stamp: 'fr 12/3/2020 05:24:00'!
test05AddingAnItemIsReflectedWhenListingTheCart

	self assertListingACartReflectsAddedProductsWithAmount: 1
! !

!TusLibrosFacadeTest methodsFor: 'tests - add' stamp: 'fr 12/3/2020 05:24:36'!
test06AddingMultipleItemsIsReflectedWhenListingTheCart

	self assertListingACartReflectsAddedProductsWithAmount: 2
! !

!TusLibrosFacadeTest methodsFor: 'tests - add' stamp: 'fr 12/3/2020 05:24:40'!
test07CanNotAddItemsToNonexistentCarts
		
	self assertBlockFailsForInvalidCart: [facade add: 2 of: objectFactory itemSellByTheStore toCart: objectFactory invalidCartId]
! !

!TusLibrosFacadeTest methodsFor: 'tests - add' stamp: 'fr 12/3/2020 11:19:21'!
test13CanNotAddItemsToAnExpiredCart

	| cartId |
	cartId _ facade newCartForUser: objectFactory validUser andPassword: objectFactory validPassword.	
	clock advanceHalfAnHour.
	self  should: [facade add: 1 of: objectFactory itemSellByTheStore toCart: cartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
				self assert: anError messageText equals: TusLibrosFacade cartExpiredErrorDescription.
				clock goBackHalfAnHour.
				self assert: (facade listCart: cartId) isEmpty
			]
	
	
	
	
	! !


!TusLibrosFacadeTest methodsFor: 'tests - checkout' stamp: 'fr 12/3/2020 07:39:35'!
test08CanCheckoutAValidCart

	| transactionId |
	transactionId _ self createNewCartForValidCredentialsAndCheckoutAfterAddingProducts.
	
	self assert: (facade lastTransactionWas: transactionId)
	! !

!TusLibrosFacadeTest methodsFor: 'tests - checkout' stamp: 'fr 12/3/2020 05:17:53'!
test09CanNotCheckoutANonexistentCart
				
	self should: [facade 
			checkoutCart: objectFactory invalidCartId 
			withCard: objectFactory cardNumber 
			expiringOn: objectFactory cardExpirationDate 
			forOwner: objectFactory cardOwner.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
							self assert: anError messageText equals: TusLibrosFacade invalidCartIdErrorDescription.
							self assert: salesBook isEmpty
			]
	! !

!TusLibrosFacadeTest methodsFor: 'tests - checkout' stamp: 'fr 12/3/2020 03:46:21'!
test15CanNotCheckoutAnExpiredCart

	| cartId |
	cartId _ facade newCartForUser: objectFactory validUser andPassword: objectFactory validPassword.	
	facade add: 1 of: objectFactory itemSellByTheStore toCart: cartId.
	clock advanceHalfAnHour.
	self  should: [facade 
			checkoutCart: cartId 
			withCard: objectFactory cardNumber 
			expiringOn: objectFactory cardExpirationDate 
			forOwner: objectFactory cardOwner]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |  
			self assert: anError messageText equals: TusLibrosFacade cartExpiredErrorDescription.
			self assert: (facade listPurchasesOfUser: objectFactory validUser withPassword: objectFactory validPassword) first isEmpty
			]
	
	
	
	
	! !

!TusLibrosFacadeTest methodsFor: 'tests - checkout' stamp: 'fr 12/3/2020 05:34:52'!
test16CanNotPerformAnyOperationWithACartAfterCheckout

	| cartId |
				
	cartId _ facade newCartForUser: objectFactory validUser andPassword: objectFactory validPassword.
	facade add: 1 of: objectFactory itemSellByTheStore toCart: cartId.
	facade 
		checkoutCart: cartId 
		withCard: objectFactory cardNumber 
		expiringOn: objectFactory cardExpirationDate 
		forOwner: objectFactory cardOwner.
		
	self  should: [facade listCart: cartId] 
		raise: Error - MessageNotUnderstood  
		withMessageText: TusLibrosFacade invalidCartIdErrorDescription 
		
	
	! !


!TusLibrosFacadeTest methodsFor: 'tests - purchases list' stamp: 'fr 12/3/2020 05:31:28'!
test10PurchaseListHasTheCorrectQuantityOfItemsAndTotal

	| purchasesList |
				
	self createNewCartForValidCredentialsAndCheckoutAfterAddingProducts.
	purchasesList _ facade listPurchasesOfUser: objectFactory validUser withPassword: objectFactory validPassword.
	
	self assert: (purchasesList first at: objectFactory itemSellByTheStore) equals: 2.
	self assert: purchasesList second equals: objectFactory itemSellByTheStorePrice * 2
	
	! !

!TusLibrosFacadeTest methodsFor: 'tests - purchases list' stamp: 'fr 12/3/2020 05:33:30'!
test11CanNotListPurchasesForInvalidUsername
		
	self  assertListingPurchasesAfterCheckingOutACartForAValidUserFailsForUser: objectFactory invalidUser 
		andPassword: objectFactory validPassword 
	
	! !

!TusLibrosFacadeTest methodsFor: 'tests - purchases list' stamp: 'fr 12/3/2020 05:33:53'!
test12CanNotListPurchasesForInvalidPassword
		
	self  assertListingPurchasesAfterCheckingOutACartForAValidUserFailsForUser: objectFactory validUser 
		andPassword: objectFactory invalidPassword 
	
	! !


!TusLibrosFacadeTest methodsFor: 'setup' stamp: 'fr 12/3/2020 07:41:12'!
setUp
	
	objectFactory _ StoreTestObjectsFactory new.
	
	credentials _ objectFactory defaultCredentials.
	salesBook _ objectFactory defaultSalesBook.
	clock _ objectFactory defaultClock.

	facade _ TusLibrosFacade 
			acceptingItemsOf: objectFactory defaultCatalog 
			validatingUsersThrough: self 
			registeringSalesOn: salesBook
			chargingThrough: self
			withClock: clock.
! !


!TusLibrosFacadeTest methodsFor: 'merchant processor' stamp: 'fr 12/3/2020 07:33:55'!
debit: anAmount from: aCreditCard 
	
! !


!TusLibrosFacadeTest methodsFor: 'utils' stamp: 'fr 12/3/2020 05:10:10'!
assertBlockFailsForInvalidCart: aBlock
		
	self  should: aBlock
		raise: Error - MessageNotUnderstood 
		withMessageText: TusLibrosFacade invalidCartIdErrorDescription! !

!TusLibrosFacadeTest methodsFor: 'utils' stamp: 'fr 12/3/2020 05:07:56'!
assertCreatingACartFailsForUser: aUsername withPassword: aPassword

	self  should: [facade newCartForUser: aUsername andPassword: aPassword]
		raise: Error - MessageNotUnderstood 
		withMessageText: TusLibrosFacade invalidCredentialsErrorDescription
		! !

!TusLibrosFacadeTest methodsFor: 'utils' stamp: 'fr 12/3/2020 11:08:29'!
assertListingACartReflectsAddedProductsWithAmount: anAmount

	| cartId |
	cartId _ facade newCartForUser: objectFactory validUser andPassword: objectFactory validPassword.
	facade add: anAmount of: objectFactory itemSellByTheStore toCart: cartId.
	self assert: ((facade listCart: cartId) at: objectFactory itemSellByTheStore) equals: anAmount.! !

!TusLibrosFacadeTest methodsFor: 'utils' stamp: 'fr 12/3/2020 05:32:35'!
assertListingPurchasesAfterCheckingOutACartForAValidUserFailsForUser: aUsername andPassword: aPassword
			
	self createNewCartForValidCredentialsAndCheckoutAfterAddingProducts.
	
	self  should: [facade listPurchasesOfUser: aUsername withPassword: aPassword] 
		raise: Error - MessageNotUnderstood
		description: TusLibrosFacade invalidCredentialsErrorDescription 
	
	! !

!TusLibrosFacadeTest methodsFor: 'utils' stamp: 'fr 12/3/2020 07:41:32'!
createNewCartForValidCredentialsAndCheckoutAfterAddingProducts

	| cartId |

facade _ TusLibrosFacade 
			acceptingItemsOf: objectFactory defaultCatalog 
			validatingUsersThrough: self 
			registeringSalesOn: salesBook
			chargingThrough: self
			withClock: clock.



	cartId _ facade newCartForUser: objectFactory validUser andPassword: objectFactory validPassword.
	facade add: 2 of: objectFactory itemSellByTheStore toCart: cartId.
	^facade 
		checkoutCart: cartId 
		withCard: objectFactory cardNumber 
		expiringOn: objectFactory cardExpirationDate 
		forOwner: objectFactory cardOwner.
			
	! !


!TusLibrosFacadeTest methodsFor: 'authenticator' stamp: 'fr 12/3/2020 16:24:04'!
signalInvalidCredentialsError

	^ self error: TusLibrosFacade invalidCredentialsErrorDescription! !

!TusLibrosFacadeTest methodsFor: 'authenticator' stamp: 'fr 12/3/2020 16:24:04'!
validateUsername: aUsername withPassword: aPassword 
	
	(self validateUsernameAndObtainPasswordFor: aUsername) = aPassword ifFalse: [self signalInvalidCredentialsError].
	! !

!TusLibrosFacadeTest methodsFor: 'authenticator' stamp: 'fr 12/3/2020 16:24:15'!
validateUsernameAndObtainPasswordFor: aUsername

	^ credentials at: aUsername ifAbsent: [self signalInvalidCredentialsError]! !


!classDefinition: #Cart category: 'TusLibros - Exercise - III'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - III'!

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


!Cart methodsFor: 'initialization' stamp: 'fr 12/3/2020 16:39:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


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

!Cart methodsFor: 'adding' stamp: 'fr 12/3/2020 16:40:58'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity! !


!Cart methodsFor: 'listing' stamp: 'fr 12/3/2020 16:40:01'!
listCart
	
	^items contents 
	! !


!Cart methodsFor: 'enumerating' stamp: 'fr 12/3/2020 16:40:17'!
itemsQuantitiesAndPricesDo: aBlock 
	
	items contents keysAndValuesDo: [:anItem :aQuantity | aBlock value: anItem value: aQuantity value: (catalog at: anItem)]
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros - Exercise - III'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartSession category: 'TusLibros - Exercise - III'!
Object subclass: #CartSession
	instanceVariableNames: 'cart facade lastUsed user'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - III'!

!CartSession methodsFor: 'initialization' stamp: 'fr 12/3/2020 03:48:18'!
initializeFor: aCart on: aFacade user: aUsername 
	
	cart _ aCart.
	facade _ aFacade.
	user _ aUsername.
	lastUsed _ facade now! !


!CartSession methodsFor: 'validation' stamp: 'fr 12/3/2020 16:26:05'!
assertCartHasNotExpired

	^self cartHasExpired ifTrue: [self error: TusLibrosFacade cartExpiredErrorDescription]! !

!CartSession methodsFor: 'validation' stamp: 'fr 12/3/2020 16:25:59'!
cartHasExpired

	^ facade now - lastUsed >= facade sessionDuration! !


!CartSession methodsFor: 'cart management' stamp: 'fr 12/3/2020 03:01:42'!
add: aQuantity of: anItem 

	self cartDoIfNotExpired: [cart add: aQuantity of: anItem]
	
	
	
	
	! !

!CartSession methodsFor: 'cart management' stamp: 'fr 12/3/2020 03:10:19'!
cartDoIfNotExpired: aCartBlock

	self assertCartHasNotExpired.
	
	^aCartBlock ensure: [lastUsed _ facade now]! !

!CartSession methodsFor: 'cart management' stamp: 'fr 12/3/2020 03:48:18'!
checkoutWithCard: aCardNumber expiringOn: anExpirationDate forOwner: aCardOwner through: aMerchantProcessor registeringOn: aSalesBook 
	
	^self cartDoIfNotExpired:[(Cashier toCheckout: cart 
				 		charging: (CreditCard expiringOn: anExpirationDate withNumber: aCardNumber ownedBy: aCardOwner) 
						throught: aMerchantProcessor 
						on: facade currentMonth 
						registeringOn: aSalesBook
						for: user) checkOut transactionId
					    ]! !

!CartSession methodsFor: 'cart management' stamp: 'fr 12/3/2020 03:08:15'!
listCart
		
	^self cartDoIfNotExpired: [cart listCart]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: 'TusLibros - Exercise - III'!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'instance creation' stamp: 'fr 12/3/2020 03:32:52'!
for: aCart on: aFacade user: aUsername 
	
	^self new initializeFor: aCart on: aFacade user: aUsername ! !


!classDefinition: #Cashier category: 'TusLibros - Exercise - III'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard receipt customer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - III'!

!Cashier methodsFor: 'checkout - private' stamp: 'fr 11/30/2020 02:22:23'!
collectReceiptEntriesInto: ticketEntries 
	
	cart itemsQuantitiesAndPricesDo: [:anItem :aQuantity :aPrice | 
		ticketEntries add: (SaleReceiptEntry for: aQuantity of: anItem costing: aPrice)
	]! !

!Cashier methodsFor: 'checkout - private' stamp: 'fr 12/3/2020 07:36:15'!
createReceipt
	
	| receiptEntries |
	receiptEntries _ OrderedCollection new.
	self collectReceiptEntriesInto: receiptEntries.
	receipt _ SaleReceipt for: customer containing: receiptEntries! !

!Cashier methodsFor: 'checkout - private' stamp: 'fr 11/30/2020 02:24:09'!
createSale

	^Sale for: receipt
! !

!Cashier methodsFor: 'checkout - private' stamp: 'fr 12/3/2020 03:35:06'!
debitTotal

	^merchantProcessor debit: cart total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'fr 12/3/2020 07:35:31'!
checkOut

	self createReceipt.
	self debitTotal.
	self registerSale.

	^ receipt! !


!Cashier methodsFor: 'initialization' stamp: 'fr 12/3/2020 03:17:55'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook for: aCustomer 
	
	cart _ aCart.
	creditCard _ aCreditCard.
	merchantProcessor _ aMerchantProcessor.
	salesBook _ aSalesBook.
	customer _ aCustomer.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros - Exercise - III'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'fr 12/3/2020 03:17:36'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook for: aCustomer 
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook for: aCustomer ! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #Clock category: 'TusLibros - Exercise - III'!
Object subclass: #Clock
	instanceVariableNames: 'now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - III'!

!Clock methodsFor: 'time' stamp: 'fr 12/2/2020 21:03:59'!
currentMonth
	
	^self now month ! !

!Clock methodsFor: 'time' stamp: 'fr 12/3/2020 11:19:42'!
goBackHalfAnHour
	
	now _ now - 30 minutes! !

!Clock methodsFor: 'time' stamp: 'fr 12/3/2020 01:58:26'!
now
	
	^now! !


!Clock methodsFor: 'initialization' stamp: 'fr 12/3/2020 03:10:59'!
initializeFor: aTimePoint 
	
	now _ aTimePoint.! !


!Clock methodsFor: 'clock manipulation' stamp: 'fr 12/3/2020 02:01:45'!
advanceHalfAnHour
	
	now _ now + 30 minutes! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Clock class' category: 'TusLibros - Exercise - III'!
Clock class
	instanceVariableNames: ''!

!Clock class methodsFor: 'instance creation' stamp: 'fr 12/3/2020 01:59:06'!
for: aTimePoint 
	
	^self new initializeFor: aTimePoint ! !


!classDefinition: #CreditCard category: 'TusLibros - Exercise - III'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - III'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'fr 12/2/2020 19:57:57'!
initializeExpiringOn: anExpirationDate withNumber: aCreditCardNumber ownedBy: aCreditCardOwner 
	
	expiration _ anExpirationDate.
	number _ aCreditCardNumber.
	owner _ aCreditCardOwner.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros - Exercise - III'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'fr 12/2/2020 19:57:15'!
expiringOn: anExpirationDate withNumber: aCreditCardNumber ownedBy: aCreditCardOwner 
	
	^self new initializeExpiringOn: anExpirationDate withNumber: aCreditCardNumber ownedBy: aCreditCardOwner ! !


!classDefinition: #Sale category: 'TusLibros - Exercise - III'!
Object subclass: #Sale
	instanceVariableNames: 'receipt'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - III'!

!Sale methodsFor: 'total' stamp: 'fr 11/30/2020 02:19:42'!
total
	
	^ receipt total! !


!Sale methodsFor: 'initialization' stamp: 'fr 11/30/2020 01:56:27'!
initializeFor: aSaleReceipt 
	
	receipt _ aSaleReceipt.! !


!Sale methodsFor: 'testing' stamp: 'fr 11/30/2020 02:00:26'!
doneFor: aUsername 

	^receipt customer = aUsername! !


!Sale methodsFor: 'listing' stamp: 'fr 11/30/2020 02:05:57'!
itemsWithCounts
	
	| items |
	items _ Bag new.
	receipt collectItemsWithCountsInto: items.
	^items! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros - Exercise - III'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'fr 11/30/2020 01:55:41'!
for: aSaleReceipt 
	
	^self new initializeFor: aSaleReceipt ! !


!classDefinition: #SaleReceipt category: 'TusLibros - Exercise - III'!
Object subclass: #SaleReceipt
	instanceVariableNames: 'receiptEntries customer transactionId salesReceiptEntriesList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - III'!

!SaleReceipt methodsFor: 'initialization' stamp: 'fr 12/3/2020 07:37:33'!
initializeFor: aCustomer containing: aSalesReceiptEntriesList 
	
	customer _ aCustomer.
	receiptEntries _ aSalesReceiptEntriesList.! !


!SaleReceipt methodsFor: 'accessing' stamp: 'fr 11/30/2020 02:01:21'!
customer
	
	^customer! !

!SaleReceipt methodsFor: 'accessing' stamp: 'fr 12/3/2020 03:37:29'!
transactionId
	
	^transactionId! !


!SaleReceipt methodsFor: 'private' stamp: 'fr 11/30/2020 03:04:26'!
collectItemsWithCountsInto: aListOfItemsWithOccurrences 
	
	receiptEntries do: [:aReceiptEntry | aListOfItemsWithOccurrences add: aReceiptEntry item withOccurrences: aReceiptEntry quantity]! !


!SaleReceipt methodsFor: 'total' stamp: 'fr 11/30/2020 02:11:40'!
total
	
	^receiptEntries sum: [:aReceiptEntry | aReceiptEntry subtotal]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SaleReceipt class' category: 'TusLibros - Exercise - III'!
SaleReceipt class
	instanceVariableNames: ''!

!SaleReceipt class methodsFor: 'instance creation' stamp: 'fr 12/3/2020 07:37:10'!
for: aCustomer containing: aSalesReceiptEntriesList 
	
	^self new initializeFor: aCustomer containing: aSalesReceiptEntriesList! !


!classDefinition: #SaleReceiptEntry category: 'TusLibros - Exercise - III'!
Object subclass: #SaleReceiptEntry
	instanceVariableNames: 'quantity item price'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - III'!

!SaleReceiptEntry methodsFor: 'initialization' stamp: 'fr 11/30/2020 01:54:06'!
initializeFor: aQuantity of: anItem costing: aPrice 
	
	quantity _ aQuantity.
	item _ anItem.
	price _ aPrice.! !


!SaleReceiptEntry methodsFor: 'accessing' stamp: 'fr 11/30/2020 02:07:20'!
item
	
	^item! !

!SaleReceiptEntry methodsFor: 'accessing' stamp: 'fr 11/30/2020 02:07:29'!
quantity
	
	^quantity! !


!SaleReceiptEntry methodsFor: 'total' stamp: 'fr 11/30/2020 02:11:57'!
subtotal
	
	^quantity * price! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SaleReceiptEntry class' category: 'TusLibros - Exercise - III'!
SaleReceiptEntry class
	instanceVariableNames: ''!

!SaleReceiptEntry class methodsFor: 'instance creation' stamp: 'fr 11/30/2020 01:53:32'!
for: aQuantity of: anItem costing: aPrice 
	
	^self new initializeFor: aQuantity of: anItem costing: aPrice ! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros - Exercise - III'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - III'!

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

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'fr 12/3/2020 05:10:58'!
invalidCartId
	
	^Object new! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'fr 11/30/2020 02:45:01'!
cardExpirationDate

	^Month month: self today monthIndex year: self today yearNumber + 1	
	! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'fr 11/30/2020 02:44:25'!
cardNumber
	
	^'1111 2222 3333 4444'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'fr 12/3/2020 03:45:57'!
cardOwner
	
	^'Federico Rosende'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'fr 12/3/2020 04:43:40'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)
			     withNumber: self cardNumber 
			     ownedBy: self cardOwner ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'fr 12/3/2020 04:43:58'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)
			     withNumber: self cardNumber 
			     ownedBy: self cardOwner ! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'clock' stamp: 'fr 12/3/2020 02:03:33'!
defaultClock
	
	^Clock for: DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'credentials' stamp: 'fr 11/30/2020 02:40:07'!
defaultCredentials

	^Dictionary new add: self validUser -> self validPassword; yourself! !

!StoreTestObjectsFactory methodsFor: 'credentials' stamp: 'fr 11/30/2020 02:39:41'!
defaultSalesBook
	
	^OrderedCollection new! !

!StoreTestObjectsFactory methodsFor: 'credentials' stamp: 'fr 12/3/2020 00:56:46'!
invalidPassword

	^Object new! !

!StoreTestObjectsFactory methodsFor: 'credentials' stamp: 'fr 12/3/2020 00:56:36'!
invalidUser
	
	^Object new! !

!StoreTestObjectsFactory methodsFor: 'credentials' stamp: 'fr 11/30/2020 02:36:17'!
validPassword
	
	^'validPassword'! !

!StoreTestObjectsFactory methodsFor: 'credentials' stamp: 'fr 11/30/2020 02:35:58'!
validUser
	
	^'validUsername'! !


!classDefinition: #TusLibrosFacade category: 'TusLibros - Exercise - III'!
Object subclass: #TusLibrosFacade
	instanceVariableNames: 'cartsSessions catalogue authenticator currentCartId merchantProcessor salesBook clock currentTransactionId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros - Exercise - III'!

!TusLibrosFacade methodsFor: 'cart management' stamp: 'fr 12/3/2020 16:37:33'!
add: aQuantity of: anItem toCart: aCartId 
	
	self do: [:aCartSession | aCartSession add: aQuantity of: anItem] forCartSessionFor: aCartId 
	! !

!TusLibrosFacade methodsFor: 'cart management' stamp: 'fr 12/3/2020 16:37:33'!
checkoutCart: aCartId withCard: aCardNumber expiringOn: anExpirationDate forOwner: aCardOwner 
	
	^self do: [:aCartSession | 	aCartSession 
							checkoutWithCard: aCardNumber 
							expiringOn: anExpirationDate 
							forOwner: aCardOwner 
							through: merchantProcessor 
							registeringOn: salesBook.
						self removeCart: aCartId.
						^self newTransactionId] 
					
		 forCartSessionFor: aCartId 

		! !

!TusLibrosFacade methodsFor: 'cart management' stamp: 'fr 12/3/2020 16:37:33'!
listCart: aCartId 
	
	^self do: [:aCartSession | aCartSession listCart] forCartSessionFor: aCartId 
	! !

!TusLibrosFacade methodsFor: 'cart management' stamp: 'fr 12/3/2020 00:18:22'!
newCart

	^ Cart acceptingItemsOf: catalogue! !

!TusLibrosFacade methodsFor: 'cart management' stamp: 'fr 12/3/2020 11:16:32'!
newCartForUser: aUsername andPassword: aPassword 
	
	self validateUsername: aPassword withPassword: aUsername.
	self updateCartId.
	cartsSessions add: currentCartId -> (self newCartSessionFor: aUsername).
	^currentCartId .
 ! !


!TusLibrosFacade methodsFor: 'initialization' stamp: 'fr 12/3/2020 11:15:05'!
initializeAcceptingItemsOf: aCatalogue validatingUsersThrough: anAuthenticator registeringSalesOn: aSalesBook chargingThrough: aMerchantProcessor withClock: aClock 
	
	catalogue _ aCatalogue.
	authenticator _ anAuthenticator.
	salesBook _ aSalesBook.
	merchantProcessor _ aMerchantProcessor.
	clock _ aClock.
	
	cartsSessions _ Dictionary new.
	currentCartId _ 1.
	currentTransactionId _ 1
! !


!TusLibrosFacade methodsFor: 'time' stamp: 'fr 12/2/2020 21:02:36'!
currentMonth
	
	^clock currentMonth
	! !

!TusLibrosFacade methodsFor: 'time' stamp: 'fr 11/30/2020 19:32:26'!
now
	
	^clock now! !

!TusLibrosFacade methodsFor: 'time' stamp: 'fr 12/3/2020 11:21:01'!
sessionDuration
	
	^30 minutes! !


!TusLibrosFacade methodsFor: 'purchase listing - private' stamp: 'fr 12/3/2020 16:41:46'!
itemsWithCountsFor: salesForCustomer

	^ (self itemsWithCountsForAllSales: salesForCustomer) contents ! !

!TusLibrosFacade methodsFor: 'purchase listing - private' stamp: 'fr 12/3/2020 04:31:52'!
itemsWithCountsForAllSales: salesForCustomer

	^ salesForCustomer inject: Bag new into: [:totalItemsWithCounts :aSale | totalItemsWithCounts addAll: aSale itemsWithCounts]! !

!TusLibrosFacade methodsFor: 'purchase listing - private' stamp: 'fr 12/3/2020 04:15:50'!
listPurchasesForCustomer: aUsername

	| salesForCustomer |
	salesForCustomer _ self salesForCustomer: aUsername.

	^ {self itemsWithCountsFor: salesForCustomer. self totalFor: salesForCustomer}! !

!TusLibrosFacade methodsFor: 'purchase listing - private' stamp: 'fr 12/3/2020 04:03:48'!
totalFor: salesForCustomer

	^ (salesForCustomer) sum: [:aSale | aSale total] ifEmpty: [0]! !


!TusLibrosFacade methodsFor: 'purchase listing' stamp: 'fr 12/3/2020 05:05:14'!
listPurchasesOfUser: aUsername withPassword: aPassword 

	self validateUsername: aPassword withPassword: aUsername.
	^self listPurchasesForCustomer: aUsername
	! !

!TusLibrosFacade methodsFor: 'purchase listing' stamp: 'fr 11/30/2020 02:25:34'!
salesForCustomer: aUsername

	^ salesBook select: [:aSale | aSale doneFor: aUsername]! !

!TusLibrosFacade methodsFor: 'purchase listing' stamp: 'fr 12/3/2020 05:05:36'!
validateUsername: aPassword withPassword: aUsername

	^ authenticator validateUsername: aUsername withPassword: aPassword! !


!TusLibrosFacade methodsFor: 'cart session management' stamp: 'fr 12/3/2020 01:41:46'!
cartSessionForCartId: aCartId

	^cartsSessions at: aCartId ifAbsent: [self error: self class invalidCartIdErrorDescription]! !

!TusLibrosFacade methodsFor: 'cart session management' stamp: 'fr 12/3/2020 16:37:33'!
do: aBlock forCartSessionFor: aCartId
	
	^aBlock value: (self cartSessionForCartId: aCartId) 
	! !

!TusLibrosFacade methodsFor: 'cart session management' stamp: 'fr 12/3/2020 03:32:31'!
newCartSessionFor: aUsername 
	
	^ CartSession for: self newCart on: self user: aUsername! !

!TusLibrosFacade methodsFor: 'cart session management' stamp: 'fr 12/3/2020 02:25:46'!
removeCart: aCartId 

	cartsSessions removeKey: aCartId 
	
	! !


!TusLibrosFacade methodsFor: 'testing' stamp: 'fr 12/3/2020 07:40:41'!
lastTransactionWas: aTransactionId 

	^currentTransactionId = aTransactionId 
	
	! !


!TusLibrosFacade methodsFor: 'id' stamp: 'fr 12/3/2020 07:43:44'!
newTransactionId
	
	currentTransactionId _ currentTransactionId + 1.
	^currentTransactionId ! !

!TusLibrosFacade methodsFor: 'id' stamp: 'fr 12/3/2020 11:16:32'!
updateCartId
	
	currentCartId _ currentCartId + 1.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosFacade class' category: 'TusLibros - Exercise - III'!
TusLibrosFacade class
	instanceVariableNames: ''!

!TusLibrosFacade class methodsFor: 'instance creation' stamp: 'fr 12/3/2020 01:42:57'!
acceptingItemsOf: aCatalogue validatingUsersThrough: anAuthenticator registeringSalesOn: aSalesBook chargingThrough: aMerchantProcessor withClock: aClock 
	
	^self new initializeAcceptingItemsOf: aCatalogue validatingUsersThrough: anAuthenticator registeringSalesOn: aSalesBook chargingThrough: aMerchantProcessor withClock: aClock ! !


!TusLibrosFacade class methodsFor: 'error description' stamp: 'fr 11/30/2020 19:21:47'!
cartExpiredErrorDescription
	
	^'Cart session expired'! !

!TusLibrosFacade class methodsFor: 'error description' stamp: 'fr 11/28/2020 21:12:40'!
invalidCartIdErrorDescription
	
	^'Invalid cart id'! !

!TusLibrosFacade class methodsFor: 'error description' stamp: 'fr 11/28/2020 20:40:18'!
invalidCredentialsErrorDescription
	
	^'Invalid credentials'! !
