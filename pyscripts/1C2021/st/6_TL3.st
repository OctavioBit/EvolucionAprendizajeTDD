!classDefinition: #TusLibrosTest category: 'TusLibros'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'support controller cashier validCreditCard expiredCreditCard failedCreditCard user1 user2 merchantProcessor now time35MinutesLater book1 book2 book1Price book2Price validPass invalidPass'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'cashier tests' stamp: 'BW 6/24/2021 11:06:54'!
test01CheckoutOfEmptyCartShouldRaiseError
	|cart   salesBook|
	cart := support createCart.
	
	salesBook := support createSalesBook.
	
	self should: [cashier checkout: cart withCard: validCreditCard onDate: support today registerOn: salesBook processWith: support createMerchantProcessor] 
		raise: Error-MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart cantCheckoutEmptyCartError].
		
	self assert: salesBook isEmpty.
	! !

!TusLibrosTest methodsFor: 'cashier tests' stamp: 'BW 6/24/2021 11:06:51'!
test02CheckoutOf1ProductShouldReturnProductPrice
	|cart  total |
	cart := support createCart.
	
	cart add: book1.
	total := cashier checkout: cart withCard: validCreditCard onDate: support today registerOn: support createSalesBook processWith: support createMerchantProcessor.
	
	self assert: total equals: (support itemSellByTheStorePrice).! !

!TusLibrosTest methodsFor: 'cashier tests' stamp: 'BW 6/24/2021 11:06:54'!
test03CheckoutOfMultipleProductsShouldReturnTotal
	|cart total expectedTotal |
	cart := support createCheckoutCart.
	
	total := cashier checkout: cart withCard: validCreditCard onDate: support today registerOn: support createSalesBook processWith: support createMerchantProcessor.
	expectedTotal := support itemSellByTheStorePrice * 2 + support item2SellByTheStorePrice.
	
	self assert: total equals: expectedTotal.! !

!TusLibrosTest methodsFor: 'cashier tests' stamp: 'BW 6/24/2021 11:06:53'!
test04ExpiredCreditCardShouldRaiseError
	|cart  |
	cart := support createCheckoutCart.
	
	self should: [cashier checkout: cart withCard: expiredCreditCard onDate: support today registerOn: support createSalesBook processWith: support createMerchantProcessor]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			anError messageText = Cashier expiredCreditCardErrorMessage]
		! !

!TusLibrosTest methodsFor: 'cashier tests' stamp: 'BW 6/24/2021 11:06:52'!
test05CashierRegisteresASingleSell
	|cart  salesBook |
	cart := support createCheckoutCart.
	

	salesBook := support createSalesBook.
	
	cashier checkout: cart withCard: validCreditCard onDate: support today registerOn: salesBook processWith: support createMerchantProcessor.
	
	self assert: (salesBook includes: (CompletedSale for: cart)).
		! !

!TusLibrosTest methodsFor: 'cashier tests' stamp: 'BW 6/24/2021 11:06:52'!
test06CashierRegistersItsSells
	|cart cart2  salesBook|
	cart := support createCheckoutCart.
	cart2 := support createCheckoutCart.
	salesBook := support createSalesBook.
	
	cashier checkout: cart withCard: validCreditCard onDate: support today registerOn: salesBook processWith: support createMerchantProcessor.
	cashier checkout: cart2 withCard: validCreditCard onDate: support today registerOn: salesBook processWith: support createMerchantProcessor.
	
	self assert: (salesBook includes: (CompletedSale for: cart)).
	self assert: (salesBook includes: (CompletedSale for: cart2)).
		! !

!TusLibrosTest methodsFor: 'cashier tests' stamp: 'BW 6/24/2021 11:06:54'!
test07PaymentFailureShouldRaiseError
	|cart   salesBook|
	cart := support createCheckoutCart.	
	salesBook := support createSalesBook.
	
	self should:  [cashier checkout: cart withCard: failedCreditCard onDate: support today registerOn: salesBook processWith: support createMerchantProcessor]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			anError messageText = MerchantProcessorSimulator paymentFailureErrorMessage].
		
	self assert: salesBook isEmpty.! !


!TusLibrosTest methodsFor: 'cart tests' stamp: 'BW 6/24/2021 11:06:51'!
test01NewCartsAreCreatedEmpty

	self assert: support createCart isEmpty! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'BW 6/24/2021 11:06:53'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := support createCart.
	
	self 
		should: [ cart add: support itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'BW 6/24/2021 11:06:51'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := support createCart.
	
	cart add: book1.
	self deny: cart isEmpty ! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'BW 6/24/2021 11:06:51'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := support createCart.
	
	self 
		should: [cart add: 0 of: support itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'BW 6/24/2021 11:06:53'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := support createCart.
	
	self 
		should: [cart add: 2 of: support itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'BW 6/24/2021 11:06:53'!
test06CartRemembersAddedItems

	| cart |
	
	cart := support createCart.
	
	cart add: book1.
	self assert: (cart includes: support itemSellByTheStore)! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'BW 6/24/2021 11:06:51'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := support createCart.
	
	self deny: (cart includes: support itemSellByTheStore)! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'BW 6/24/2021 11:06:53'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := support createCart.
	
	cart add: 2 of: book1.
	self assert: (cart occurrencesOf: support itemSellByTheStore) = 2! !


!TusLibrosTest methodsFor: 'credit card tests' stamp: 'BW 6/24/2021 11:06:54'!
shouldBeInvalidCard: aCardCreatingBlock
	
	self should: aCardCreatingBlock 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			anError messageText = CreditCardData invalidCreditCardErrorMessage]
		! !

!TusLibrosTest methodsFor: 'credit card tests' stamp: 'BW 6/24/2021 11:06:51'!
test01CreditCardWithInvalidNumberLongitudShouldRaiseError
	
	self shouldBeInvalidCard: [support createInvalidNumberLongitudCreditCard]
	
		! !

!TusLibrosTest methodsFor: 'credit card tests' stamp: 'BW 6/24/2021 11:06:53'!
test02CreditCardWithInvalidNameLongitudShouldRaiseError
	
	self shouldBeInvalidCard: [support createInvalidNameLongitudCreditCard.]
	! !

!TusLibrosTest methodsFor: 'credit card tests' stamp: 'BW 6/24/2021 11:06:51'!
test03CreditCardWithInvalidNameCharactersShouldRaiseError

	self shouldBeInvalidCard: [support createInvalidNameCreditCard.]
		! !

!TusLibrosTest methodsFor: 'credit card tests' stamp: 'BW 6/24/2021 11:06:52'!
test04CreditCardWithInvalidNumberShouldRaiseError
	
	self shouldBeInvalidCard: [support createInvalidNumberCreditCard]
		
		! !

!TusLibrosTest methodsFor: 'credit card tests' stamp: 'BW 6/24/2021 11:06:52'!
test05CreditCardWithInvalidDateShouldRaiseError
	
	self shouldBeInvalidCard: [support createInvalidDateCreditCard]
		
		! !

!TusLibrosTest methodsFor: 'credit card tests' stamp: 'BW 6/24/2021 11:06:54'!
test06CreditCardWithSpacesAsNameShouldRaiseError
	
	self shouldBeInvalidCard: [support createSpacesAsNameCreditCard]
		
		! !


!TusLibrosTest methodsFor: 'controller tests' stamp: 'BW 6/24/2021 11:11:43'!
test01incorrectUserOrPasswordCannotCreateCart
	
	| tusLibrosController |
	tusLibrosController := support createDefaultTusLibrosController.
	self should: [tusLibrosController createCartForClient: support createInvalidUserID pass: invalidPass dateTime: now.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: TusLibrosController invalidUserOrPasswordErrorDescription equals: anError messageText.
			].
		
	
	
	! !

!TusLibrosTest methodsFor: 'controller tests' stamp: 'BW 6/24/2021 11:09:19'!
test02newlyCreatedCartShouldBeEmpty
	
	| tusLibrosController id |
	tusLibrosController := support createDefaultTusLibrosController.
	id := tusLibrosController createCartForClient: user1 pass: validPass dateTime: now.
	
	self assert: (tusLibrosController listCart: id dateTime: now) isEmpty.
		
	
	
	
	! !

!TusLibrosTest methodsFor: 'controller tests' stamp: 'BW 6/24/2021 11:09:36'!
test03listCartCanRetrieveItemsWhenASingleCartWasCreated
	
	| tusLibrosController id expectedList |
	
	tusLibrosController := support createDefaultTusLibrosController.
	
	id := tusLibrosController createCartForClient: user1 pass: validPass dateTime: now.
	tusLibrosController addToCart: id isbn: book1 quantity: 1 dateTime: now.
	
	expectedList := Dictionary with: (Association key: book1 value: 1).
	
	self assert: (expectedList) equals: (tusLibrosController listCart: id dateTime: now).
		
	
	! !

!TusLibrosTest methodsFor: 'controller tests' stamp: 'BW 6/24/2021 11:09:51'!
test04TusLibrosCreatesAndManagesMoreThanOneCart
	
	| tusLibrosController id1 id2 expectedList1 |
	
	tusLibrosController := support createDefaultTusLibrosController.
	id1 := tusLibrosController createCartForClient: user1 pass: validPass dateTime: now.
	id2 := tusLibrosController createCartForClient: user2 pass: validPass dateTime: now.
	
	tusLibrosController addToCart: id1 isbn: book1 quantity: 1 dateTime: now.
	
	expectedList1 := Dictionary with: (Association key: book1 value: 1).
	
	self assert: expectedList1 equals: (tusLibrosController listCart: id1 dateTime: now).
	self assert: (tusLibrosController listCart: id2 dateTime: now) isEmpty.
		
	
	! !

!TusLibrosTest methodsFor: 'controller tests' stamp: 'BW 6/24/2021 11:06:55'!
test05CannotAddBookToNonExistentCart
	
	| tusLibrosController id |
	id := 'id que no existe'.
	
	tusLibrosController := support createDefaultTusLibrosController.
	
	self should: [tusLibrosController addToCart: id isbn: book1 quantity: 1 dateTime: now.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: TusLibrosController cartNotCreatedErrorDescription equals: anError messageText.	
		].
	
	
		! !

!TusLibrosTest methodsFor: 'controller tests' stamp: 'BW 6/24/2021 11:06:54'!
test06CannotListNonExistentCart
	
	| tusLibrosController id |
	id := 'id que no existe'.
	tusLibrosController := support createDefaultTusLibrosController.
	
	self should: [tusLibrosController listCart: id dateTime: now] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: TusLibrosController cartNotCreatedErrorDescription equals: anError messageText.	
		].
	
	
		
		! !

!TusLibrosTest methodsFor: 'controller tests' stamp: 'BW 6/24/2021 11:06:52'!
test07CannotCheckoutNonExistentCart
	
	| tusLibros id  |
	
	tusLibros := support createDefaultTusLibrosController.
	id := 1.
	
	self should: [tusLibros checkOutCart: id withCard: validCreditCard dateTime: support today.] 
	      raise: Error - MessageNotUnderstood 
	      withExceptionDo: [:anError |
		self assert: TusLibrosController cartNotCreatedErrorDescription equals: anError messageText. 
		]
	
	
		
	
	
		! !

!TusLibrosTest methodsFor: 'controller tests' stamp: 'BW 6/24/2021 11:10:30'!
test08SingleUserSellIsRegistered
	
	| tusLibros cartID  expectedSells bookValue expectedValue |
		
	bookValue := support itemSellByTheStorePrice.
	tusLibros := support createDefaultTusLibrosController.
	
	expectedSells := Dictionary new.
	expectedSells at: book1 put: 1.
	expectedValue := bookValue.
	
	cartID := tusLibros createCartForClient: user1 pass: validPass dateTime: now.
	tusLibros addToCart: cartID isbn: book1 quantity: 1 dateTime: now.
	
	tusLibros checkOutCart: cartID withCard: validCreditCard dateTime: now.
	
	self assert: (tusLibros listPurchases: user1 pass: validPass) equals: (Association key: expectedSells value: expectedValue).
		
	
	
		
	
	
		! !

!TusLibrosTest methodsFor: 'controller tests' stamp: 'BW 6/24/2021 11:11:04'!
test09SingleUserManySellsAreRegistered
	
	| tusLibros expectedSells cart1ID cart2ID expectedValue |
	
	tusLibros := support createDefaultTusLibrosController.
	
	expectedSells := Dictionary new.
	expectedSells at: book1 put: 2.
	expectedSells at: book2 put: 1.
	expectedValue := 2*book1Price + book2Price.
	
	cart1ID := tusLibros createCartForClient: user1 pass: validPass dateTime: now.
	tusLibros addToCart: cart1ID isbn: book1 quantity: 1 dateTime: now.
	
	cart2ID := tusLibros createCartForClient: user1 pass: validPass dateTime: now.
	tusLibros addToCart: cart2ID isbn: book1 quantity: 1 dateTime: now.
	tusLibros addToCart: cart2ID isbn: book2 quantity: 1 dateTime: now.
	
	tusLibros checkOutCart: cart1ID withCard: validCreditCard dateTime: now.
	tusLibros checkOutCart: cart2ID withCard: validCreditCard dateTime: now.
		
	self assert: (tusLibros listPurchases: user1 pass: validPass) equals: (Association key: expectedSells value: expectedValue).! !

!TusLibrosTest methodsFor: 'controller tests' stamp: 'BW 6/24/2021 11:12:43'!
test10ManySellsAreAssociatedToItsUsers
	
	| tusLibros cart1ID cart2ID cart3ID cart4ID expectedSells1 expectedSells2 expectedValue1 expectedValue2   |

	tusLibros := support createDefaultTusLibrosController.
	
	expectedSells1 := Dictionary new.
	expectedSells1 at: book1 put: 2.
	expectedSells1 at: book2 put: 1.
	expectedValue1 := 2*book1Price + book2Price.
	
	cart1ID := tusLibros createCartForClient: user1 pass: validPass dateTime: now.
	tusLibros addToCart: cart1ID isbn: book1 quantity: 1 dateTime: now.
	
	cart2ID := tusLibros createCartForClient: user1 pass: validPass dateTime: now.
	tusLibros addToCart: cart2ID isbn: book1 quantity: 1 dateTime: now.
	tusLibros addToCart: cart2ID isbn: book2 quantity: 1 dateTime: now.
	
	tusLibros checkOutCart: cart1ID withCard: validCreditCard dateTime: now.
	tusLibros checkOutCart: cart2ID withCard: validCreditCard dateTime: now.
	
	"-------------------------------------------------"
	
	expectedSells2 := Dictionary new.
	expectedSells2 at: book1 put: 1.
	expectedSells2 at: book2 put: 2.
	expectedValue2 := book1Price + (2*book2Price).
	
	cart3ID := tusLibros createCartForClient: user2 pass: validPass dateTime: now.
	tusLibros addToCart: cart3ID isbn: book2 quantity: 1 dateTime: now.
	
	cart4ID := tusLibros createCartForClient: user2 pass: validPass dateTime: now.
	tusLibros addToCart: cart4ID isbn: book1 quantity: 1 dateTime: now.
	tusLibros addToCart: cart4ID isbn: book2 quantity: 1 dateTime: now.
	
	tusLibros checkOutCart: cart3ID withCard: validCreditCard dateTime: now.
	tusLibros checkOutCart: cart4ID withCard: validCreditCard dateTime: now.
	
	"---------------------------------------------"
		
	self assert: (tusLibros listPurchases: user1 pass: validPass) equals: (Association key: expectedSells1 value: expectedValue1).
	self assert: (tusLibros listPurchases: user2 pass: validPass) equals: (Association key: expectedSells2 value: expectedValue2).		
	
	! !

!TusLibrosTest methodsFor: 'controller tests' stamp: 'BW 6/24/2021 11:13:06'!
test11CannotCheckOutACartManyTimes
	
	| tusLibros cart1ID expectedSells1 expectedValue1 |

	tusLibros := support createDefaultTusLibrosController.
	
	expectedSells1 := Dictionary new.
	expectedSells1 at: book1 put: 2.
	expectedSells1 at: book2 put: 1.
	expectedValue1 := 2*book1Price + book2Price.
	
	cart1ID := tusLibros createCartForClient: user1 pass: validPass dateTime: now.
	tusLibros addToCart: cart1ID isbn: book1 quantity: 2 dateTime: now.	
	tusLibros addToCart: cart1ID isbn: book2 quantity: 1 dateTime: now.	
	tusLibros checkOutCart: cart1ID withCard: validCreditCard dateTime: now.
	
	self should: [tusLibros checkOutCart: cart1ID withCard: validCreditCard dateTime: now]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anException |
			self assert: anException messageText equals: TusLibrosController cartNotCreatedErrorDescription. 
			self assert: (tusLibros listPurchases: user1 pass: validPass) equals: (Association key: expectedSells1 value: expectedValue1).
			]
	
	
	
	! !

!TusLibrosTest methodsFor: 'controller tests' stamp: 'BW 6/24/2021 11:13:18'!
test12CannotAddToCartWhenTimeExceeded
	
	| tusLibros cart1ID|
	
	tusLibros := support createDefaultTusLibrosController.
	
	cart1ID := tusLibros createCartForClient: user1 pass: validPass dateTime: now.
	
	
	self should: [tusLibros addToCart: cart1ID isbn: book1 quantity: 2 dateTime: time35MinutesLater	]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anException |
			self assert: anException messageText equals: SaleInProgress cartTimeoutErrorDescription. 
			]
	
	
! !

!TusLibrosTest methodsFor: 'controller tests' stamp: 'BW 6/24/2021 11:13:30'!
test13CannotListCartWhenTimeExceeded
	
	| tusLibros cart1ID |
	
	tusLibros := support createDefaultTusLibrosController.
	
	cart1ID := tusLibros createCartForClient: user1 pass: validPass dateTime: now.
	tusLibros addToCart: cart1ID isbn: book1 quantity: 2 dateTime: now.
	
	self should: [tusLibros listCart: cart1ID dateTime: time35MinutesLater	]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anException |
			self assert: anException messageText equals: SaleInProgress cartTimeoutErrorDescription. 
			]
	
	
! !

!TusLibrosTest methodsFor: 'controller tests' stamp: 'BW 6/24/2021 11:13:42'!
test14CannotCheckOutCartWhenTimeExceeded
	
	| tusLibros cart1ID  |
	
	tusLibros := support createDefaultTusLibrosController.
	
	
	cart1ID := tusLibros createCartForClient: user1 pass: validPass dateTime: now.
	tusLibros addToCart: cart1ID isbn: book1 quantity: 2 dateTime: now.
	
	self should: [tusLibros checkOutCart: cart1ID withCard: validCreditCard dateTime:  time35MinutesLater	]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anException |
			self assert: anException messageText equals: SaleInProgress cartTimeoutErrorDescription. 
			]
	
	
! !

!TusLibrosTest methodsFor: 'controller tests' stamp: 'BW 6/24/2021 11:13:54'!
test15TimeStampShouldBeUpdatedOnEveryCartOperation
	
	| tusLibros cart1ID  expectedSells1 expectedValue1 |
	
	tusLibros := support createDefaultTusLibrosController. 
	
	expectedSells1:= Dictionary new.
	expectedSells1 at: book1 put: 2.
	expectedValue1 := 2*book1Price.
	
	cart1ID := tusLibros createCartForClient: user1 pass: validPass dateTime: now.
	tusLibros addToCart: cart1ID isbn: book1 quantity: 2 dateTime: (now next: 29*minute).
	tusLibros listCart: cart1ID dateTime: (now next: 29*2*minute).
	tusLibros checkOutCart: cart1ID withCard: validCreditCard dateTime: (now next: 29*3*minute).
	
	self assert: (tusLibros listPurchases: user1 pass: validPass) equals: (Association key: expectedSells1 value: expectedValue1).
	
	
! !

!TusLibrosTest methodsFor: 'controller tests' stamp: 'BW 6/24/2021 11:14:05'!
test16TransactionIDsAreUnique
	
	| tusLibros cart1ID  cart2ID transactionID1 transactionID2 |

	tusLibros := support createDefaultTusLibrosController. 
	
	cart1ID := tusLibros createCartForClient: user1 pass: validPass dateTime: now.
	cart2ID := tusLibros createCartForClient: user2 pass: validPass dateTime: now.
	tusLibros addToCart: cart1ID isbn: book1 quantity: 2 dateTime: now.
	tusLibros addToCart: cart2ID isbn: book1 quantity: 2 dateTime: now.	
	
	transactionID1 := tusLibros checkOutCart: cart1ID withCard: validCreditCard dateTime: now.
	transactionID2 := tusLibros checkOutCart: cart2ID withCard: validCreditCard dateTime: now.	
	
	self assert: transactionID1 ~= transactionID2.
! !

!TusLibrosTest methodsFor: 'controller tests' stamp: 'BW 6/24/2021 11:14:42'!
test17incorrectUserOrPasswordCannotListPurchases
	
	| tusLibros  invalidUser |
	invalidUser := support createInvalidUserID. 
	tusLibros := support createDefaultTusLibrosController. 
	
	self should: [tusLibros listPurchases: invalidUser pass: invalidPass]
		raise:  Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: anError messageText equals: self class invalidUserOrPasswordErrorDescription.
			]! !

!TusLibrosTest methodsFor: 'controller tests' stamp: 'BW 6/24/2021 11:14:57'!
test18UserWithoutPurchasesGetsEmptyPurchasesHistory	
	| tusLibros |
	
	tusLibros := support createDefaultTusLibrosController. 
	
	self assert: (Association key: Dictionary new value: 0) equals: (tusLibros listPurchases: user1 pass: validPass).
	

		! !


!TusLibrosTest methodsFor: 'initialization' stamp: 'BW 6/24/2021 11:08:18'!
setUp
	support := TusLibrosTestsSupport new.
	cashier := support createCashier.
	merchantProcessor := support createMerchantProcessor. 
	
	now := support now.
	time35MinutesLater := support time35MinutesLater. 
	
	book1 := support itemSellByTheStore.
	book2 := support item2SellByTheStore.
	book1Price := support itemSellByTheStorePrice.
	book2Price := support item2SellByTheStorePrice.
	
	validCreditCard := support createCreditCard.
	expiredCreditCard := support createExpiredCreditCard.
	failedCreditCard := support createCreditCardToFail. 
	
	user1 := support createValidUserID.
	user2 := support createValidUserID2.
	validPass := support createValidUserPass.
	invalidPass := support createInvalidUserPass.! !


!TusLibrosTest methodsFor: 'user manager interface' stamp: 'BW 6/24/2021 11:06:53'!
validateClient: aClient pass: aPassword
	(aClient = 1 and: [aPassword = 1]) ifTrue: [self error: self class invalidUserOrPasswordErrorDescription].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosTest class' category: 'TusLibros'!
TusLibrosTest class
	instanceVariableNames: ''!

!TusLibrosTest class methodsFor: 'user simulator error' stamp: 'BW 6/21/2021 13:18:15'!
invalidUserOrPasswordErrorDescription
	^'invalid user or password'! !


!classDefinition: #TusLibrosTestsSupport category: 'TusLibros'!
TestCase subclass: #TusLibrosTestsSupport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTestsSupport methodsFor: 'users' stamp: 'BW 6/19/2021 11:14:11'!
createInvalidUserID
	^1! !

!TusLibrosTestsSupport methodsFor: 'users' stamp: 'BW 6/19/2021 11:05:48'!
createInvalidUserPass
	^1! !

!TusLibrosTestsSupport methodsFor: 'users' stamp: 'BW 6/19/2021 11:05:30'!
createValidUserID
	^2! !

!TusLibrosTestsSupport methodsFor: 'users' stamp: 'BW 6/19/2021 11:14:19'!
createValidUserID2
	^3! !

!TusLibrosTestsSupport methodsFor: 'users' stamp: 'BW 6/19/2021 11:05:40'!
createValidUserPass
	^12345! !


!TusLibrosTestsSupport methodsFor: 'controller' stamp: 'BW 6/23/2021 18:17:26'!
createDefaultTusLibrosController 
	^TusLibrosController withCatalog: self defaultCatalog merchantProcessor: self createMerchantProcessor validateWith: TusLibrosTest new.! !


!TusLibrosTestsSupport methodsFor: 'credit card' stamp: 'BW 6/21/2021 13:22:55'!
createCreditCard
	^ CreditCardData withNumber: '1234567891234567' withExpirationDate: self nextYear withOwner: 'Roberto the Owner'
	! !

!TusLibrosTestsSupport methodsFor: 'credit card' stamp: 'BW 6/21/2021 13:39:11'!
createCreditCardToFail
	^ CreditCardData withNumber: '1111111111111111' withExpirationDate: self nextYear withOwner: 'Soy una tarjeta sin credito'! !

!TusLibrosTestsSupport methodsFor: 'credit card' stamp: 'BW 6/21/2021 13:23:08'!
createExpiredCreditCard
	
	^ CreditCardData withNumber: '1234567891234567' withExpirationDate: self lastYear withOwner: 'Roberto the Owner'
	! !

!TusLibrosTestsSupport methodsFor: 'credit card' stamp: 'BW 6/21/2021 13:23:21'!
createInvalidDateCreditCard
	^ CreditCardData withNumber: '1234567891234567' withExpirationDate: 'falsa fecha' withOwner: 'Roberto the Owner'
	! !

!TusLibrosTestsSupport methodsFor: 'credit card' stamp: 'BW 6/21/2021 13:23:28'!
createInvalidNameCreditCard
	
	^ CreditCardData withNumber: '1234567891234567' withExpirationDate: self nextYear withOwner: 'I am an invalid {name}'.
	! !

!TusLibrosTestsSupport methodsFor: 'credit card' stamp: 'BW 6/21/2021 13:23:35'!
createInvalidNameLongitudCreditCard
	
	^ CreditCardData withNumber: '1234567891234567' withExpirationDate: self nextYear withOwner: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum'.
	! !

!TusLibrosTestsSupport methodsFor: 'credit card' stamp: 'BW 6/21/2021 13:23:41'!
createInvalidNumberCreditCard
	
	^ CreditCardData withNumber: '1234abcd1234[]{}' withExpirationDate: self nextYear withOwner: 'Roberto the Owner'
	! !

!TusLibrosTestsSupport methodsFor: 'credit card' stamp: 'BW 6/21/2021 13:23:47'!
createInvalidNumberLongitudCreditCard
	
	^ CreditCardData withNumber: '1234' withExpirationDate: self nextYear withOwner: 'Roberto the Owner'
	! !

!TusLibrosTestsSupport methodsFor: 'credit card' stamp: 'BW 6/21/2021 13:24:05'!
createSpacesAsNameCreditCard
	
	^ CreditCardData withNumber: '1234567891234567' withExpirationDate: self nextYear withOwner: '                '.
	! !


!TusLibrosTestsSupport methodsFor: 'date time' stamp: 'BW 6/21/2021 13:24:51'!
lastYear
	^self today previousMonth: (self today month).! !

!TusLibrosTestsSupport methodsFor: 'date time' stamp: 'BW 6/21/2021 13:24:56'!
nextYear
	^self today nextMonth: (self today month).! !

!TusLibrosTestsSupport methodsFor: 'date time' stamp: 'BW 6/21/2021 20:01:08'!
now
	^GregorianDateTime now.! !

!TusLibrosTestsSupport methodsFor: 'date time' stamp: 'BW 6/21/2021 20:05:40'!
time35MinutesLater
	^GregorianDateTime now next: 35*minute. ! !

!TusLibrosTestsSupport methodsFor: 'date time' stamp: 'BW 6/21/2021 13:25:02'!
today
	^GregorianMonthOfYear current.! !


!TusLibrosTestsSupport methodsFor: 'catalog' stamp: 'BW 6/21/2021 13:24:18'!
defaultCatalog
	|catalog|
	catalog := Dictionary new.
	catalog at: self itemSellByTheStore 	put: self itemSellByTheStorePrice.
	catalog at: self item2SellByTheStore 	put: self item2SellByTheStorePrice.
	^ catalog! !

!TusLibrosTestsSupport methodsFor: 'catalog' stamp: 'BW 6/21/2021 13:24:23'!
item2SellByTheStore
	^'El libro de bruno'.! !

!TusLibrosTestsSupport methodsFor: 'catalog' stamp: 'BW 6/21/2021 13:24:31'!
item2SellByTheStorePrice
	^20! !

!TusLibrosTestsSupport methodsFor: 'catalog' stamp: 'BW 6/21/2021 13:24:36'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!TusLibrosTestsSupport methodsFor: 'catalog' stamp: 'BW 6/21/2021 13:24:41'!
itemSellByTheStore
	
	^ 'validBook'! !

!TusLibrosTestsSupport methodsFor: 'catalog' stamp: 'BW 6/21/2021 13:24:45'!
itemSellByTheStorePrice
	^50! !


!TusLibrosTestsSupport methodsFor: 'simulator' stamp: 'BW 6/21/2021 13:23:52'!
createMerchantProcessor
	^MerchantProcessorSimulator new.! !


!TusLibrosTestsSupport methodsFor: 'cart' stamp: 'BW 6/21/2021 13:22:36'!
createCart
	^Cart acceptingItemsOf: self defaultCatalog! !

!TusLibrosTestsSupport methodsFor: 'cart' stamp: 'BW 6/21/2021 13:22:47'!
createCheckoutCart
	|checkoutCart|
	checkoutCart := self createCart.
	checkoutCart add: 2 of: self itemSellByTheStore.
	checkoutCart add: self item2SellByTheStore.
	^checkoutCart! !


!TusLibrosTestsSupport methodsFor: 'cashier' stamp: 'BW 6/21/2021 13:22:42'!
createCashier

	^Cashier new.! !


!TusLibrosTestsSupport methodsFor: 'sales' stamp: 'BW 6/21/2021 13:24:00'!
createSalesBook

	^OrderedCollection new.! !


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


!Cart methodsFor: 'assertions' stamp: 'LB 6/12/2021 10:42:18'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'BW 6/24/2021 10:47:32'!
addToDicc: aDictionary

	items do: [:anItem |
		aDictionary at: anItem 
				ifPresent: [:aValue | aDictionary at: anItem put: aValue + 1] 
				ifAbsent:		[aDictionary at: 		anItem put: 1]
	].
	^aDictionary! !

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


!Cart methodsFor: 'checkout' stamp: 'LB 6/12/2021 10:57:56'!
checkoutTotal
	(self isEmpty) ifTrue: [^self error: self class cantCheckoutEmptyCartError].
	^items inject: 0 into: [:aTotal :anItem | aTotal + (catalog at: anItem)].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!Cart class methodsFor: 'error' stamp: 'LB 6/12/2021 10:56:13'!
cantCheckoutEmptyCartError
	^'Error: Cant checkout empty cart.'! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout' stamp: 'BW 6/23/2021 17:37:39'!
checkout: aCart withCard: aCreditCard onDate: date registerOn: salesBook processWith: aMerchantProcessor
	|total|
	(aCreditCard isExpiredOn: date) ifTrue: [^ self error: self class expiredCreditCardErrorMessage].
	total := aCart checkoutTotal.
	aMerchantProcessor makeTransactionWith: aCreditCard for: total.
	salesBook add: (CompletedSale for: aCart).
	
	^total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error' stamp: 'LB 6/10/2021 20:53:14'!
expiredCreditCardErrorMessage
	^'Error: credit card is expired'.! !


!classDefinition: #CompletedSale category: 'TusLibros'!
Object subclass: #CompletedSale
	instanceVariableNames: 'itemsPurchased total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CompletedSale methodsFor: 'comparing' stamp: 'BW 6/22/2021 23:29:15'!
= anotherCompletedSale
	^(total = anotherCompletedSale total) and: [itemsPurchased = anotherCompletedSale itemsPurchased]! !


!CompletedSale methodsFor: 'testing' stamp: 'BW 6/22/2021 23:29:57'!
itemsPurchased
	^itemsPurchased! !

!CompletedSale methodsFor: 'testing' stamp: 'BW 6/22/2021 23:29:41'!
total
	^total! !


!CompletedSale methodsFor: 'adding' stamp: 'BW 6/22/2021 23:24:25'!
addItemsTo: aDictionary
	itemsPurchased associationsDo: [:anAssociation |
		aDictionary at: anAssociation key ifPresent: [:aValue | aDictionary at: anAssociation key put: anAssociation value + aValue] ifAbsent:		[aDictionary at: anAssociation key put: anAssociation value]
	] ! !

!CompletedSale methodsFor: 'adding' stamp: 'BW 6/22/2021 23:17:20'!
addTotalTo: aTotal
	^aTotal + total.! !


!CompletedSale methodsFor: 'initialization' stamp: 'BW 6/24/2021 11:30:09'!
initializeFor: aCart
	total := aCart checkoutTotal.
	itemsPurchased := aCart addToDicc: Dictionary new.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CompletedSale class' category: 'TusLibros'!
CompletedSale class
	instanceVariableNames: ''!

!CompletedSale class methodsFor: 'instance creation' stamp: 'BW 6/22/2021 23:03:54'!
for: aCart
	^self new initializeFor: aCart
	! !


!classDefinition: #CreditCardData category: 'TusLibros'!
Object subclass: #CreditCardData
	instanceVariableNames: 'number expiration owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardData methodsFor: 'initialization' stamp: 'LB 6/12/2021 11:53:31'!
initiliazeWithNumber: aNumberAsString withExpirationDate: anExpirationDate withOwner: anOwner
	number := aNumberAsString.
	expiration := anExpirationDate.
	owner := anOwner.! !


!CreditCardData methodsFor: 'expiration' stamp: 'LB 6/14/2021 18:55:31'!
isExpiredOn: date
	^date > self expiration! !


!CreditCardData methodsFor: 'testing' stamp: 'LB 6/12/2021 11:58:45'!
expiration
	^expiration! !

!CreditCardData methodsFor: 'testing' stamp: 'LB 6/12/2021 18:31:25'!
number
	^number! !

!CreditCardData methodsFor: 'testing' stamp: 'LB 6/12/2021 18:07:03'!
owner
	^owner! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCardData class' category: 'TusLibros'!
CreditCardData class
	instanceVariableNames: ''!

!CreditCardData class methodsFor: 'validation' stamp: 'LB 6/13/2021 12:12:56'!
validateDate: anExpirationDate.
	(anExpirationDate isKindOf: 	GregorianMonthOfYear) ifFalse: [^self error: self invalidCreditCardErrorMessage]! !

!CreditCardData class methodsFor: 'validation' stamp: 'LB 6/13/2021 11:42:36'!
validateNumber: aNumberAsString.
	(aNumberAsString size = 16) ifFalse: [^ self error: self invalidCreditCardErrorMessage].
	aNumberAsString do: [:aChar | (aChar isDigit) ifFalse: [^ self error: self invalidCreditCardErrorMessage]]
	! !

!CreditCardData class methodsFor: 'validation' stamp: 'LB 6/13/2021 11:37:30'!
validateOwner: anOwner.
	(anOwner size between: 1 and: 30) ifFalse: [^ self error: self invalidCreditCardErrorMessage].
	anOwner do: [:aChar | ((aChar isLetter) or: [aChar asString = ' ']) ifFalse: [^ self error: self invalidCreditCardErrorMessage]]! !


!CreditCardData class methodsFor: 'error' stamp: 'LB 6/12/2021 11:59:26'!
invalidCreditCardErrorMessage
	^'Error: credit card is invalid'.! !


!CreditCardData class methodsFor: 'instance creation' stamp: 'LB 6/14/2021 18:50:01'!
withNumber: aNumberAsString withExpirationDate: anExpirationDate withOwner: anOwner
	self validateNumber: aNumberAsString.
	self validateOwner: anOwner withBlanksTrimmed.
	self validateDate: anExpirationDate.
	
	^self new initiliazeWithNumber: aNumberAsString withExpirationDate: anExpirationDate withOwner: anOwner withBlanksTrimmed! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'transaction' stamp: 'LB 6/17/2021 14:57:49'!
makeTransactionWith: aCreditCard for: anAmount
	((aCreditCard number = '1111111111111111') or: 
		[aCreditCard number = '2222222222222222'] or: 
			[aCreditCard number = '3333333333333333']) 
		ifTrue: [^self error: self class paymentFailureErrorMessage].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: 'TusLibros'!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'error' stamp: 'LB 6/17/2021 14:57:49'!
paymentFailureErrorMessage
	^'Error: Payment could not be completed'.! !


!classDefinition: #SaleInProgress category: 'TusLibros'!
Object subclass: #SaleInProgress
	instanceVariableNames: 'cart userID timestamp cashier'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SaleInProgress methodsFor: 'operations' stamp: 'BW 6/23/2021 17:59:46'!
add: aQuantity of: anISBN dateTime: aDateTime

	self validateAndRefreshTimestamp: aDateTime.
	
	cart add: aQuantity of: anISBN.
	
	! !

!SaleInProgress methodsFor: 'operations' stamp: 'BW 6/23/2021 18:01:01'!
checkoutWithCard: aCreditCard dateTime: aDateTime registerOn: aSalesBook processWith: merchantProcessor.

	self validateAndRefreshTimestamp: aDateTime.
	
	(aSalesBook includesKey: userID) ifFalse: [aSalesBook at: userID put: OrderedCollection new].
	cashier checkout: cart withCard: aCreditCard onDate: aDateTime monthOfYear registerOn: (aSalesBook at: userID) processWith: merchantProcessor.
	
	
! !


!SaleInProgress methodsFor: 'initialization' stamp: 'BW 6/22/2021 18:12:07'!
initializeWithUser: anUserID dateTime: aDateTime catalog: aCatalog .
	userID := anUserID .
	timestamp := aDateTime.
	cashier := Cashier new.
	cart := Cart acceptingItemsOf: aCatalog.
	! !


!SaleInProgress methodsFor: 'listing' stamp: 'BW 6/24/2021 11:29:20'!
listAddedItemsAt: aDateTime

	self validateAndRefreshTimestamp: aDateTime.
	
	^cart addToDicc: Dictionary new.! !


!SaleInProgress methodsFor: 'private' stamp: 'BW 6/23/2021 18:01:54'!
validateAndRefreshTimestamp: aDateTime 

	aDateTime > (timestamp next: 30*minute) ifTrue: [self error: self class cartTimeoutErrorDescription].
	timestamp := aDateTime.
	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SaleInProgress class' category: 'TusLibros'!
SaleInProgress class
	instanceVariableNames: ''!

!SaleInProgress class methodsFor: 'instance creation' stamp: 'BW 6/23/2021 18:02:54'!
cartTimeoutErrorDescription
	^'Session expired'! !

!SaleInProgress class methodsFor: 'instance creation' stamp: 'BW 6/22/2021 18:11:41'!
withUser: anUserID dateTime: aDateTime catalog: aCatalog  
	^self new initializeWithUser: anUserID dateTime: aDateTime catalog: aCatalog.! !


!classDefinition: #TusLibrosController category: 'TusLibros'!
Object subclass: #TusLibrosController
	instanceVariableNames: 'catalog nextCart merchantProcessor currentSales salesBook usersValidator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosController methodsFor: 'initialization' stamp: 'BW 6/23/2021 18:15:51'!
initialize: aCatalog merchantProcessor: aMerchantProcessor validateWith: aUserValidator  
	
	currentSales := Dictionary new. 
	salesBook := Dictionary new. 
	
	usersValidator := aUserValidator.
	catalog := aCatalog.
	nextCart := 1.
	merchantProcessor := aMerchantProcessor.
	! !


!TusLibrosController methodsFor: 'facade' stamp: 'BW 6/23/2021 18:04:19'!
addToCart: aCartID isbn: anISBN quantity: aQuantity dateTime: aDateTime  

	self assertCartExists: aCartID.	
	(currentSales at: aCartID) add: aQuantity of: anISBN dateTime: aDateTime.
	! !

!TusLibrosController methodsFor: 'facade' stamp: 'BW 6/23/2021 18:04:33'!
checkOutCart: aCartID withCard: aCreditCard dateTime: aDateTime 
	
	self assertCartExists: aCartID.	
	(currentSales at: aCartID) checkoutWithCard: aCreditCard dateTime: aDateTime registerOn: salesBook processWith: merchantProcessor.
	currentSales removeKey: aCartID.
	^aCartID! !

!TusLibrosController methodsFor: 'facade' stamp: 'BW 6/24/2021 11:24:13'!
createCartForClient: aUserID pass: aPassword dateTime: aDateTime   
	|cartID|
	usersValidator validateClient: aUserID pass: aPassword. 
	cartID := self incrementCartID.
	currentSales at: cartID put: (SaleInProgress withUser: aUserID dateTime: aDateTime catalog: catalog).
	
	^cartID! !

!TusLibrosController methodsFor: 'facade' stamp: 'BW 6/23/2021 18:04:40'!
listCart: aCartID dateTime: aDateTime  

	self assertCartExists: aCartID.	
	^(currentSales at: aCartID) listAddedItemsAt: aDateTime.
	
	
	! !

!TusLibrosController methodsFor: 'facade' stamp: 'BW 6/24/2021 11:26:19'!
listPurchases: aUserID pass: aPassword
	| sells total |
	usersValidator validateClient: aUserID pass: aPassword. 
	
	sells := Dictionary new.
	total := 0.
	
	salesBook at: aUserID ifPresent: [:userSales | 
		userSales do: [:aCompletedSale |
			aCompletedSale addItemsTo: sells.
			total := aCompletedSale addTotalTo: total
			]
		].
	
	^Association key: sells value: total.! !


!TusLibrosController methodsFor: 'private' stamp: 'BW 6/23/2021 18:04:19'!
assertCartExists: aCartID

	^ (currentSales includesKey: aCartID) ifFalse: [self error: self class cartNotCreatedErrorDescription]! !

!TusLibrosController methodsFor: 'private' stamp: 'BW 6/23/2021 18:07:37'!
incrementCartID
	|nextID|
	nextID := nextCart.
	nextCart := nextCart + 1.
	^nextID! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosController class' category: 'TusLibros'!
TusLibrosController class
	instanceVariableNames: ''!

!TusLibrosController class methodsFor: 'error' stamp: 'BW 6/19/2021 11:29:03'!
cartNotCreatedErrorDescription
	^'404 cart not found'! !

!TusLibrosController class methodsFor: 'error' stamp: 'BW 6/17/2021 20:55:42'!
invalidUserOrPasswordErrorDescription
	^'invalid user or password'! !


!TusLibrosController class methodsFor: 'instance creation' stamp: 'BW 6/23/2021 18:19:00'!
withCatalog: aCatalog merchantProcessor: aMerchantProcessor validateWith: aUserValidator 
	^self new initialize: aCatalog merchantProcessor: aMerchantProcessor validateWith: aUserValidator! !
