!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'CS 6/21/2021 23:12:54'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'CS 6/21/2021 23:23:32'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'CS 6/21/2021 23:12:58'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
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


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'cartObjectTest'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'testing' stamp: 'ms 6/22/2021 15:45:20'!
test01CanNotCreateCreditCardWithEmptyName

	|  aExpirationDate|
	
	aExpirationDate := cartObjectTest notExpiredDate.
	
	self should: [CreditCard expiringOn: aExpirationDate withOwner: '' andWithNumber: 1234567887654321]
	raise: Error
	withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard errorDescribeEmptyName . ]
	
	! !

!CreditCardTest methodsFor: 'testing' stamp: 'ms 6/22/2021 15:47:22'!
test02CanNotCreateCreditCardWithANumberSizeOtherThan16

	| aExpirationDate |
	
	aExpirationDate := cartObjectTest notExpiredDate.
	
	self should: [CreditCard expiringOn: aExpirationDate withOwner: cartObjectTest validUserId andWithNumber: 12345678]
	raise: Error
	withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard errorDescribeinvalidCreditCardNumber ]! !

!CreditCardTest methodsFor: 'testing' stamp: 'ms 6/22/2021 15:45:12'!
test03CreditCardWasCreatedCorrectlyAndWeCanAccessToNameNumberAndExpirationDate

	| aCreditCard aExpirationDate owner creditCardNumber|
	
	aExpirationDate := cartObjectTest notExpiredDate.
	owner := cartObjectTest validUserId .
	creditCardNumber := 1234567887654321.
	
	aCreditCard := CreditCard expiringOn: aExpirationDate withOwner:  owner andWithNumber:creditCardNumber .
	
	self assert: (aCreditCard owner) equals: owner.
	self assert: (aCreditCard creditCardNumber) equals: creditCardNumber.
	self assert: (aCreditCard expirationDate) equals: aExpirationDate
	! !


!CreditCardTest methodsFor: 'SetUp' stamp: 'ms 6/22/2021 15:28:43'!
setUp

	cartObjectTest := StoreTestObjectsFactory new! !


!classDefinition: #RestInterfaceTest category: 'TusLibros'!
TestCase subclass: #RestInterfaceTest
	instanceVariableNames: 'lastClientId lastIsbn storeTestObject debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceTest methodsFor: 'testing' stamp: 'ms 6/24/2021 16:01:32'!
test01CanNotCreateCartWithInvalidUserID

	| invalidUserID userPassword interface |

	interface := self defaultInterface.
	invalidUserID := 'David West'. 
	userPassword := storeTestObject validUserPassword.

	self should:[interface createCartFor: invalidUserID authenticatedBy: userPassword]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = RestInterface describeErroInvalidUserIDOrPassword.]
	! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'ms 6/24/2021 16:01:46'!
test02CanNotCreateCartWithInvalidUserPassword

	| invalidUserPassword userID interface |

	interface := self defaultInterface.
	userID := storeTestObject validUserId.
	invalidUserPassword := 'California'. 
	
	self should:[interface createCartFor: userID authenticatedBy: invalidUserPassword]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = RestInterface describeErroInvalidUserIDOrPassword.]
	! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'ms 6/24/2021 16:01:50'!
test03CanCreateCartWithValidUser

	| userID userPassword cartID interface |

	interface := self defaultInterface.
	userID := storeTestObject validUserId.
	userPassword := storeTestObject validUserPassword.
	
	cartID := interface createCartFor: userID authenticatedBy: userPassword.

	self assert: (interface listCart: cartID) isEmpty.! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'ms 6/24/2021 16:01:54'!
test04CanAddItemsToCart

    | cartID isbn items userID userPassword interface |

	interface := self defaultInterface.
	userID := storeTestObject validUserId. 
	userPassword := storeTestObject validUserPassword.
	isbn := storeTestObject itemSellByTheStore.
	
	cartID := interface createCartFor: userID authenticatedBy: userPassword.

    	interface addToCart: cartID aBookId: isbn  withQuantity: 1.

    	items := interface listCart: cartID.
	
	self assert: (items includes: isbn).
	self assert: (items occurrencesOf: isbn) equals: 1.! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'ms 6/24/2021 16:01:57'!
test05CanNotAddItemsToCartWithInvalidID

    | isbn userID userPassword interface invalidCartID |

	interface := self defaultInterface.
	userID := storeTestObject validUserId. 
	userPassword := storeTestObject validUserPassword.
	invalidCartID := 0.
	
	interface createCartFor: userID authenticatedBy: userPassword.
	isbn := storeTestObject itemSellByTheStore.

	self should:[interface addToCart: invalidCartID aBookId: isbn withQuantity: 1]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = RestInterface describeErroInvalidCartID.]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'ms 6/24/2021 16:02:02'!
test06CanNotAddInvalidItemsToCart

    | userID userPassword interface cartID invalidItem |

	interface := self defaultInterface.
	userID := storeTestObject validUserId. 
	userPassword := storeTestObject validUserPassword.
	invalidItem := 'Design Patterns'.
	
	cartID := interface createCartFor: userID authenticatedBy: userPassword.

	self should:[interface addToCart: cartID aBookId: invalidItem withQuantity: 1]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = RestInterface describeErroInvalidItem.]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'ms 6/24/2021 16:02:06'!
test07CanNotAddInvalidQuantityOfItemToCart

    | userID userPassword interface cartID isbn invalidQuantity |

	interface := self defaultInterface.
	userID := storeTestObject validUserId. 
	userPassword := storeTestObject validUserPassword.
	isbn := storeTestObject itemSellByTheStore.
	invalidQuantity := -1.

	cartID := interface createCartFor: userID authenticatedBy: userPassword.

	self should:[interface addToCart: cartID aBookId: isbn withQuantity: invalidQuantity]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = RestInterface describeErroInvalidQuantity.]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'ms 6/24/2021 16:02:10'!
test08CanNotListCarWithInvalidCartID

    | interface invalidCartID |

	interface := self defaultInterface.
	invalidCartID := 0.
	
	self should:[interface listCart: invalidCartID]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = RestInterface describeErroInvalidCartID .]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'ms 6/24/2021 16:02:13'!
test09CanListCartAndHasTheCorrectAmountOfItems

	| userID userPassword cartID isbn1 isbn2 interface |

	interface := self defaultInterface.
	userID := storeTestObject validUserId.
	userPassword := storeTestObject validUserPassword.

	isbn1 := storeTestObject itemSellByTheStore.
	isbn2 := storeTestObject otherItemSellByTheStore.

	cartID := interface createCartFor: userID authenticatedBy: userPassword.
	interface addToCart: cartID aBookId: isbn1 withQuantity: 2.
	interface addToCart: cartID aBookId: isbn2 withQuantity: 3.
		
	self assert: ((interface listCart: cartID) occurrencesOf: isbn1) equals: 2.
	self assert: ((interface listCart: cartID) occurrencesOf: isbn2) equals: 3.! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'ms 6/24/2021 16:02:17'!
test10listPurchasesWithEmptyCart

	| userID userPassword items interface |

	interface := self defaultInterface.
	userID := storeTestObject validUserId. 
	userPassword := storeTestObject validUserPassword.

	interface createCartFor: userID authenticatedBy: userPassword.

	items := interface listPurchasesWithID: userID andPassword: userPassword.
	self assert: (items size) equals: 1.
	self assert: (items at: 1) equals: 0.! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'ms 6/24/2021 16:02:21'!
test11listPurchasesUserWithManyCarts

	| userID userPassword cart1ID cart2ID isbn1 isbn2 interface purchases |

	interface := self defaultInterface.
	userID := storeTestObject validUserId. 
	userPassword := storeTestObject validUserPassword.

	isbn1 := storeTestObject itemSellByTheStore.
	isbn2 := storeTestObject otherItemSellByTheStore.

	cart1ID := interface createCartFor: userID authenticatedBy: userPassword.
	interface addToCart: cart1ID aBookId: isbn1  withQuantity: 2.

	cart2ID := interface createCartFor: userID authenticatedBy: userPassword.
	interface addToCart: cart2ID aBookId: isbn2  withQuantity: 1.
	
	purchases := interface listPurchasesWithID: userID andPassword: userPassword.
	self deny: purchases isEmpty.
	self assert: purchases size equals: 4.
	self assert: (purchases at: 1) equals: isbn1.
	self assert: (purchases at: 2) equals: isbn1.
	self assert: (purchases at: 3) equals: isbn2.
	self assert: (purchases at: 4) equals: 40.
! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'ms 6/24/2021 16:02:25'!
test12listPurchasesWithInvalidUser

	| userID userPassword cartID isbn interface invalidUserID |

	interface := self defaultInterface.
	userID := storeTestObject validUserId.
	invalidUserID := 'David West'. 
	userPassword := storeTestObject validUserPassword.
	isbn := storeTestObject itemSellByTheStore.

	cartID := interface createCartFor: userID authenticatedBy: userPassword.
	interface addToCart: cartID aBookId: isbn  withQuantity: 2.

	self should:[	interface listPurchasesWithID: invalidUserID andPassword: userPassword]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = RestInterface describeErroInvalidUserIDOrPassword.]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'ms 6/24/2021 16:02:30'!
test13listPurchasesWithInvalidUserPassword

	| userID invalidUserPassword cartID isbn interface userPassword |

	interface := self defaultInterface.
	userID := storeTestObject validUserId.
	userPassword := storeTestObject validUserPassword.
	invalidUserPassword := 'Florida'.
	isbn := storeTestObject itemSellByTheStore.

	cartID := interface createCartFor: userID authenticatedBy: userPassword.
	interface addToCart: cartID aBookId: isbn  withQuantity: 2.

	self should:[	interface listPurchasesWithID: userID andPassword: invalidUserPassword]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = RestInterface describeErroInvalidUserIDOrPassword.]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'ms 6/24/2021 16:00:36'!
test14CanCheckOutCart

	| userID userPassword cartID isbn interface creditCard transactionID|

	interface :=  self defaultInterface.
	userID := storeTestObject validUserId.
	userPassword := storeTestObject validUserPassword.
	isbn := storeTestObject itemSellByTheStore.

	creditCard := storeTestObject notExpiredCreditCard.

	cartID := interface createCartFor: userID authenticatedBy: userPassword.
	interface addToCart: cartID aBookId: isbn  withQuantity: 2.
	
	transactionID := interface checkOutACart: cartID withCreditCard: creditCard andWith: self. 
	
	self assert: transactionID equals: 1.! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'ms 6/24/2021 16:02:34'!
test15CanNotCheckOutAnEmptyCart

	| userID userPassword cartID interface creditCard |

	interface := self defaultInterface.
	userID := storeTestObject validUserId.
	userPassword := storeTestObject validUserPassword.
	
	creditCard := storeTestObject notExpiredCreditCard.

	cartID := interface createCartFor: userID authenticatedBy: userPassword.
	
	self should:[	interface checkOutACart: cartID withCreditCard: creditCard andWith: self]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = RestInterface describeErrorCartCanNotBeEmpty.]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'ms 6/24/2021 16:02:38'!
test16CanNotCheckOutWithInvalidCartID

	| invalidCartID interface creditCard |

	interface := self defaultInterface.
	creditCard := storeTestObject notExpiredCreditCard.
	invalidCartID := 0.	

	self should:[	interface checkOutACart: invalidCartID withCreditCard: creditCard andWith: self]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = RestInterface describeErroInvalidCartID]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'ms 6/24/2021 16:02:41'!
test17CanNotAddItemsWithAnExpiredCartID

	| userID userPassword cartID isbn interface  |

	interface := self defaultInterface.
	userID := storeTestObject validUserId.
	userPassword := storeTestObject validUserPassword.

	isbn := storeTestObject itemSellByTheStore.

	cartID := interface createCartFor: userID authenticatedBy: userPassword.
	
	(interface sessionCartBy: cartID) forwardTime: 35. 
	
	self should:[		interface addToCart: cartID aBookId: isbn  withQuantity: 2.]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = RestInterface describeErrorSessionCartIsExpired]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'ms 6/24/2021 16:02:44'!
test18CanNotCheckOutWithInvalidCreditCard

	| userID userPassword cartID isbn interface creditCard |

	interface := self defaultInterface.
	userID := storeTestObject validUserId.
	userPassword := storeTestObject validUserPassword.

	isbn := storeTestObject itemSellByTheStore.
	
	creditCard := storeTestObject expiredCreditCard.

	cartID := interface createCartFor: userID authenticatedBy: userPassword.
	interface addToCart: cartID aBookId: isbn  withQuantity: 2.

	self should:[	interface checkOutACart: cartID withCreditCard: creditCard andWith: self]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = RestInterface describeErrorCanNotChargeAnExpiredCreditCard]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'ms 6/24/2021 16:02:48'!
test19CanNotListCartItemsWithAnExpiredCartID

	| userID userPassword cartID isbn interface  |

	interface := self defaultInterface.
	userID := storeTestObject validUserId.
	userPassword := storeTestObject validUserPassword.

	isbn := storeTestObject itemSellByTheStore.

	cartID := interface createCartFor: userID authenticatedBy: userPassword.
	
	interface addToCart: cartID aBookId: isbn  withQuantity: 2.
	
	(interface sessionCartBy: cartID) forwardTime: 35. 
	
	self should:[		interface listCart: cartID]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = RestInterface describeErrorSessionCartIsExpired]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'ms 6/24/2021 16:02:51'!
test20CanNotCheckOutWithAnExpiredCartID

	| userID userPassword cartID isbn interface creditCard |

	interface := self defaultInterface.
	userID := storeTestObject validUserId.
	userPassword := storeTestObject validUserPassword.

	isbn := storeTestObject itemSellByTheStore.
	
	creditCard := storeTestObject expiredCreditCard.

	cartID := interface createCartFor: userID authenticatedBy: userPassword.
	
	interface addToCart: cartID aBookId: isbn  withQuantity: 2.
	
	(interface sessionCartBy: cartID) forwardTime: 35. 
	
	self should:[interface checkOutACart: cartID withCreditCard: creditCard andWith: self]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = RestInterface describeErrorSessionCartIsExpired]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'ms 6/24/2021 16:02:56'!
test21CanNotListPurchasesFromAClientWhoHasAnExpiredCartID

	| userID userPassword cartID isbn interface  |

	interface := self defaultInterface.
	userID := storeTestObject validUserId.
	userPassword := storeTestObject validUserPassword.

	isbn := storeTestObject itemSellByTheStore.

	cartID := interface createCartFor: userID authenticatedBy: userPassword.
	
	interface addToCart: cartID aBookId: isbn  withQuantity: 2.
	
	(interface sessionCartBy: cartID) forwardTime: 35. 
	
	self should:[		interface listPurchasesWithID: userID andPassword: userPassword]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText = RestInterface describeErrorSessionCartIsExpired]! !


!RestInterfaceTest methodsFor: 'set up' stamp: 'ms 6/22/2021 22:34:07'!
setUp

	lastClientId := 1.
	storeTestObject := StoreTestObjectsFactory new.	
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!RestInterfaceTest methodsFor: 'merchant processor protocol' stamp: 'ms 6/22/2021 22:33:28'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!RestInterfaceTest methodsFor: 'initialization' stamp: 'ms 6/24/2021 16:01:40'!
defaultInterface

	^RestInterface authenticateWith: storeTestObject validUsers AcceptingItemsOf: storeTestObject defaultCatalog registeringOn: OrderedCollection new throught: self .! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'assertions' stamp: 'CS 6/21/2021 23:12:37'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self class invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'CS 6/21/2021 23:23:27'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self class invalidQuantityErrorMessage ].
	aQuantity isFraction ifTrue: [ self error: self class invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'CS 6/24/2021 14:15:56'!
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


!Cart methodsFor: 'total' stamp: 'CS 6/24/2021 15:31:55'!
total

	^ items sum: [ :anItem | catalog at: anItem ] ifEmpty: 0.! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'CS 6/24/2021 14:17:34'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity.! !


!Cart methodsFor: 'items' stamp: 'CS 6/21/2021 10:50:18'!
listItems

	^ items.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!Cart class methodsFor: 'describe errors' stamp: 'CS 6/21/2021 23:11:26'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart class methodsFor: 'describe errors' stamp: 'CS 6/21/2021 23:19:01'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


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


!classDefinition: #Clock category: 'TusLibros'!
Object subclass: #Clock
	instanceVariableNames: 'time'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'initialization' stamp: 'ms 6/24/2021 15:43:38'!
initialize

	time := 0.! !


!Clock methodsFor: 'time' stamp: 'CS 6/24/2021 14:25:55'!
forwardTime: anAmountOfTime

	time := time + anAmountOfTime.! !

!Clock methodsFor: 'time' stamp: 'CS 6/24/2021 14:43:56'!
time

	^ time! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration owner number'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !

!CreditCard methodsFor: 'testing' stamp: 'ms 6/22/2021 15:41:39'!
validateCreditCardNumber: aCreditCardNumber.

	((aCreditCardNumber numberOfDigitsInBase: 10) ~= 16) ifTrue: [^Error signal: self class errorDescribeinvalidCreditCardNumber]! !

!CreditCard methodsFor: 'testing' stamp: 'ms 6/22/2021 15:41:48'!
validateName: aOwner

	aOwner isEmpty ifTrue: [^Error signal: self class errorDescribeEmptyName]! !


!CreditCard methodsFor: 'initialization' stamp: 'ms 6/22/2021 15:46:51'!
initializeExpiringOn: aMonth withOwner: anOwner withNumber: aNumber   
	
	self validateName: anOwner.
	self validateCreditCardNumber: aNumber.
	
	expiration := aMonth .
	owner  := anOwner .
	number := aNumber ! !


!CreditCard methodsFor: 'creditCard features' stamp: 'ms 6/22/2021 15:41:08'!
creditCardNumber

	^number ! !

!CreditCard methodsFor: 'creditCard features' stamp: 'ms 6/22/2021 15:41:01'!
expirationDate

	^expiration ! !

!CreditCard methodsFor: 'creditCard features' stamp: 'ms 6/22/2021 15:40:50'!
owner

	^owner ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'ms 6/22/2021 15:39:33'!
expiringOn: aMonth withOwner: anOwner andWithNumber: aNumber   
	
	^self new initializeExpiringOn: aMonth withOwner: anOwner withNumber: aNumber! !


!CreditCard class methodsFor: 'error describes' stamp: 'ms 6/22/2021 15:37:24'!
errorDescribeEmptyName

	^'Can not create credit cart with an empty name'! !

!CreditCard class methodsFor: 'error describes' stamp: 'ms 6/22/2021 15:37:36'!
errorDescribeinvalidCreditCardNumber

	^'Can not create a credit card with invalid credit card number'! !


!classDefinition: #RestInterface category: 'TusLibros'!
Object subclass: #RestInterface
	instanceVariableNames: 'autenticationSistem lastCartId carts listPurchases validUsers lastTransactionId catalog sessionCarts saleBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterface methodsFor: 'list purchases' stamp: 'ms 6/24/2021 16:15:18'!
listPurchasesWithID: userID andPassword: userPassword 

	| listCarts listPur totalAmount |

	totalAmount := 0.

	self validateUser: userID with: userPassword.
	
	listPur := OrderedCollection new.
	
	listCarts := listPurchases at: userID ifAbsent: [OrderedCollection new].
	listCarts do: [ :cartID | 
		
		listPur addAllLast: (self listCart: cartID ).
		totalAmount := totalAmount + (carts at: cartID) total.

        ].

	listPur add: totalAmount.
	
	^ listPur
! !


!RestInterface methodsFor: 'cart' stamp: 'ms 6/24/2021 16:21:28'!
addToCart: aCartId aBookId: anIsbn withQuantity: aQuantity
	
    | cart |
	
    cart := self validateAndReturnCartOf: aCartId. 

    cart add: aQuantity of: anIsbn.! !

!RestInterface methodsFor: 'cart' stamp: 'ms 6/24/2021 16:13:33'!
createCartFor: aUserID  authenticatedBy: aUserPassword  

	| cart cartsOfUser |
	
	self validateUser: aUserID with: aUserPassword.
	
	lastCartId := lastCartId +1.
	cart := Cart acceptingItemsOf: catalog .
	sessionCarts at: lastCartId put: (SessionCart createSeasionWithCartID: lastCartId).
	carts at: lastCartId put: cart.
	
	cartsOfUser := listPurchases at: aUserID ifAbsent: [OrderedCollection new].
	cartsOfUser add: lastCartId.
	listPurchases at: aUserID put: cartsOfUser.
	
	^ lastCartId! !

!RestInterface methodsFor: 'cart' stamp: 'ms 6/24/2021 16:21:34'!
listCart: aCartId  

	| cart |

	cart := self validateAndReturnCartOf: aCartId.
	
	^ cart listItems.
! !


!RestInterface methodsFor: 'initialization' stamp: 'ms 6/24/2021 15:59:51'!
initializeAuthenticateWith: users acceptingItemsOf: aCatalog registeringOn: aSalesBook throught: aMerchantProssesor   

	validUsers := users.
	catalog := aCatalog.
	saleBook := aSalesBook.
	merchantProcessor := aMerchantProssesor  .
	lastCartId := 0.
	lastTransactionId := 0.
	carts  := Dictionary new.
	listPurchases := Dictionary new.
	sessionCarts  := Dictionary new.
! !


!RestInterface methodsFor: 'check out' stamp: 'ms 6/24/2021 16:21:39'!
checkOutACart: aCartID withCreditCard: aCreditCard andWith: aMerchanProcessor 
	
	| cart cashier |
	
	cart := self validateAndReturnCartOf: aCartID.
	
	cashier :=  Cashier toCheckout: cart charging: aCreditCard throught: aMerchanProcessor on: (DateAndTime now) registeringOn: saleBook.
	
	cashier checkOut.
	
	lastTransactionId := lastTransactionId +1.
	^ lastTransactionId 
! !


!RestInterface methodsFor: 'validations' stamp: 'ms 6/24/2021 16:14:25'!
validate: aUserId with: aPassword 

	(validUsers includesKey: aUserId) 
	ifTrue: [ ^ aPassword isEqualTo: (validUsers at: aUserId )] .
	
	^ false.! !

!RestInterface methodsFor: 'validations' stamp: 'ms 6/24/2021 16:21:17'!
validateAndReturnCartOf: aCartID
	
	|cart|
	
   	cart := carts at: aCartID ifAbsent: [^Error signal: self class describeErroInvalidCartID].

	self validateCartIDIsExpired: aCartID.
	
	^ cart! !

!RestInterface methodsFor: 'validations' stamp: 'ms 6/23/2021 19:37:13'!
validateCartIDIsExpired: aCartID

	|sesionCart|
	
	sesionCart := sessionCarts at:aCartID.
	
	((sesionCart time) > 30) ifTrue: [^ Error signal: self class describeErrorSessionCartIsExpired ].
	! !

!RestInterface methodsFor: 'validations' stamp: 'ms 6/24/2021 16:13:24'!
validateUser: aUserID with: aUserPassword
	
	(self validate: aUserID with: aUserPassword) ifFalse: [^Error signal: self class describeErroInvalidUserIDOrPassword].! !


!RestInterface methodsFor: 'session cart' stamp: 'ms 6/23/2021 19:26:37'!
sessionCartBy: cartID 

	^ sessionCarts at: cartID ifAbsent: [^ Error signal: self class describeErroInvalidCartID]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterface class' category: 'TusLibros'!
RestInterface class
	instanceVariableNames: ''!

!RestInterface class methodsFor: 'describe errors' stamp: 'CS 6/21/2021 22:46:57'!
describeErroInvalidCartID

	^ 'Invalid cart ID'! !

!RestInterface class methodsFor: 'describe errors' stamp: 'CS 6/21/2021 23:12:02'!
describeErroInvalidItem

	^ Cart invalidItemErrorMessage.! !

!RestInterface class methodsFor: 'describe errors' stamp: 'CS 6/21/2021 23:19:26'!
describeErroInvalidQuantity

	^ Cart invalidQuantityErrorMessage.! !

!RestInterface class methodsFor: 'describe errors' stamp: 'CS 6/21/2021 21:38:11'!
describeErroInvalidUserIDOrPassword

	^ 'Invalid user ID or password'! !

!RestInterface class methodsFor: 'describe errors' stamp: 'ms 6/22/2021 22:52:22'!
describeErrorCanNotChargeAnExpiredCreditCard

	^'Can not charge an expired credit card'.! !

!RestInterface class methodsFor: 'describe errors' stamp: 'ms 6/22/2021 22:46:50'!
describeErrorCartCanNotBeEmpty

	^ 'Can not check out an empty cart'! !

!RestInterface class methodsFor: 'describe errors' stamp: 'ms 6/23/2021 19:24:02'!
describeErrorSessionCartIsExpired

	^'Session Cart Is Expired'! !


!RestInterface class methodsFor: 'initialization' stamp: 'ms 6/24/2021 15:59:51'!
authenticateWith: validUsers AcceptingItemsOf: aCatalog registeringOn: aSalesBook throught: aMerchantProssesor   

	^ self new initializeAuthenticateWith: validUsers acceptingItemsOf: aCatalog registeringOn: aSalesBook throught: aMerchantProssesor! !


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


!classDefinition: #SessionCart category: 'TusLibros'!
Object subclass: #SessionCart
	instanceVariableNames: 'clock cartID'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SessionCart methodsFor: 'time reference' stamp: 'ms 6/24/2021 15:44:28'!
forwardTime: anAmountOfTime

	clock forwardTime: anAmountOfTime! !

!SessionCart methodsFor: 'time reference' stamp: 'ms 6/24/2021 15:44:21'!
time

	^clock time! !


!SessionCart methodsFor: 'initialize' stamp: 'ms 6/24/2021 15:44:17'!
createSessionWith: aCartID

	cartID := aCartID .
	clock:= Clock new.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SessionCart class' category: 'TusLibros'!
SessionCart class
	instanceVariableNames: ''!

!SessionCart class methodsFor: 'instance creation' stamp: 'ms 6/23/2021 19:20:50'!
createSeasionWithCartID: aCartID

	^ self new createSessionWith: aCartID.! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today validUsers'
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

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'CS 6/21/2021 11:48:54'!
otherItemSellByTheStore
	
	^ 'otherValidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'CS 6/21/2021 11:49:06'!
otherItemSellByTheStorePrice
	
	^20! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'CS 6/21/2021 11:49:45'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self otherItemSellByTheStore put: self otherItemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ms 6/22/2021 15:44:20'!
expiredCreditCard
	
	^CreditCard expiringOn: (self expiredDate) withOwner: (self validUserId) andWithNumber: 1234567887654321! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ms 6/22/2021 15:45:02'!
expiredDate
	
	^(Month month: today monthIndex year: today yearNumber - 1)
	! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ms 6/22/2021 15:44:46'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (self notExpiredDate) withOwner: (self validUserId) andWithNumber: 1234567887654321! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ms 6/22/2021 15:44:53'!
notExpiredDate

	^(Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'users - interface' stamp: 'CS 6/21/2021 10:19:01'!
validUserId

	^ 'Alan Kay'! !

!StoreTestObjectsFactory methodsFor: 'users - interface' stamp: 'CS 6/21/2021 10:27:48'!
validUserPassword

	^ 'Massachusetts'! !

!StoreTestObjectsFactory methodsFor: 'users - interface' stamp: 'CS 6/21/2021 21:52:28'!
validUsers

	validUsers := Dictionary new.
	validUsers at: self validUserId put: self validUserPassword.
	
	^ validUsers.! !

