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

!CashierTest methodsFor: 'tests' stamp: 'ja 6/23/2021 17:01:16'!
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
			ownedBy: testObjectsFactory user]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'ja 6/23/2021 17:01:47'!
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
		ownedBy: testObjectsFactory user.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'ja 6/23/2021 17:01:53'!
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
				ownedBy: testObjectsFactory user ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'ja 6/23/2021 17:01:59'!
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
		registeringOn: salesBook 
		ownedBy: testObjectsFactory user.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'ja 6/23/2021 17:02:04'!
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
		registeringOn: salesBook 
		ownedBy: testObjectsFactory user.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'ja 6/23/2021 17:02:10'!
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
		ownedBy: testObjectsFactory user.
		
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


!classDefinition: #TusLibrosFacadeTest category: 'TusLibros'!
TestCase subclass: #TusLibrosFacadeTest
	instanceVariableNames: 'facade testObjectFactory debitBehavior customClock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosFacadeTest methodsFor: 'setUp/tearDown' stamp: 'ja 6/23/2021 19:24:30'!
setUp
	
	testObjectFactory _ StoreTestObjectsFactory new.
	customClock _ CustomClock from: testObjectFactory today.
	debitBehavior _ [:anAmount :aCreditCart | ].
	facade _ TusLibrosFacade 
			authenticatingOver: self validUsersAndPasswords
			withCatalog: testObjectFactory defaultCatalog 
			trought: self
			registiringOn: OrderedCollection new 
			withClock: customClock.! !


!TusLibrosFacadeTest methodsFor: 'create cart test' stamp: 'ja 6/21/2021 16:19:51'!
test01CanNotCreateCartWithAnInvalidUser

	self should:[ facade createCartFor: self invalidUser withPassword: self validPassword ]  
		raise: Error
	       withExceptionDo: [:anError | 
			self assert: anError messageText equals: TusLibrosFacade invalidUserOrPasswordErrorDescription ]! !

!TusLibrosFacadeTest methodsFor: 'create cart test' stamp: 'ja 6/21/2021 16:20:09'!
test02CanNotCreateCartWithAnInvalidPassword

	self should:[ facade createCartFor: self validUser withPassword: self invalidPassword ]  
		raise: Error
	       withExceptionDo: [:anError | 
			self assert: anError messageText equals: TusLibrosFacade invalidUserOrPasswordErrorDescription ]! !

!TusLibrosFacadeTest methodsFor: 'create cart test' stamp: 'ja 6/21/2021 16:19:35'!
test03CanCreateCartWithAValidUserAndPassword

	| cartId |

	cartId _	 facade createCartFor: self validUser withPassword: self validPassword .
	self assert: (facade listCartById: cartId) isEmpty.
	
		! !


!TusLibrosFacadeTest methodsFor: 'add cart test' stamp: 'ja 6/21/2021 16:57:48'!
test04CanAddABookToACart

	| cartId |
	
	cartId _ facade createCartFor: self validUser withPassword: 	self validPassword .
	
	facade add: 1 of: self validBook to: cartId.
	self assert: ((facade listCartById: cartId) occurrencesOf: self validBook) = 1 .
		! !

!TusLibrosFacadeTest methodsFor: 'add cart test' stamp: 'ja 6/21/2021 17:01:57'!
test05CanNotAddABookNotSellByTheStore

	| cartId |
	
	cartId _ facade createCartFor: self validUser withPassword: 	self validPassword .
	
	self should: [facade add: 1 of: self invalidBook to: cartId.] 
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: facade canNotAddABookNotSellByTheStoreErrorDescription.
			self assert: (facade listCartById: cartId) isEmpty ]
	
		! !

!TusLibrosFacadeTest methodsFor: 'add cart test' stamp: 'ja 6/21/2021 17:28:09'!
test06CanNotAddABookToAnInvalidCartId

	facade createCartFor: self validUser withPassword: 	self validPassword .
	
	self should: [facade add: 1 of: self validBook to: self invalidCartId] 
		raise: Error 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: facade invalidCartIdErrorDescription]
	
		! !

!TusLibrosFacadeTest methodsFor: 'add cart test' stamp: 'ja 6/21/2021 17:33:21'!
test07CanNotAddAnInvalidQuantityOfABook

	| cartId |
	
	cartId _ facade createCartFor: self validUser withPassword: 	self validPassword .
	
	self should: [facade add: 0 of: self validBook to: cartId.] 
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: facade canNotAddAnInvalidQuantityOfABookErrorDescription.
			self assert: (facade listCartById: cartId) isEmpty ]
	
		! !


!TusLibrosFacadeTest methodsFor: 'list cart test' stamp: 'ja 6/21/2021 17:36:31'!
test08CanNotListCartOfAnInvalidCartId

	facade createCartFor: self validUser withPassword: 	self validPassword.
	
	self should: [facade listCartById: self invalidCartId .] 
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: facade invalidCartIdErrorDescription]
	
		! !

!TusLibrosFacadeTest methodsFor: 'list cart test' stamp: 'ja 6/21/2021 17:45:19'!
test09ListCartReturnsTheCorrectQuantityOfAllAddedBooks

	| cartId books |
	cartId _ facade createCartFor: self validUser withPassword: 	self validPassword.
	facade add: 1 of: self validBook to: cartId.
	facade add: 2 of: self otherValidBook to: cartId.
	
	books _ facade listCartById: cartId 	.
	self assert: (books occurrencesOf: self validBook) = 1.
	self assert: (books occurrencesOf: self otherValidBook) = 2.	
		! !


!TusLibrosFacadeTest methodsFor: 'checkout test' stamp: 'ja 6/23/2021 21:53:42'!
test10CanCheckOutACart

	| cartId |
	
	cartId _ facade createCartFor: self validUser withPassword: 	self validPassword.
	facade add: 1 of: self validBook to: cartId.
	facade add: 2 of: self otherValidBook to: cartId.
	
	facade checkout: cartId
		withCreditCardNumber: testObjectFactory notExpiredCreditCardNumber 
		expiringOn: testObjectFactory notExpiredCreditCardExpiringDate
		withOwner: testObjectFactory notExpiredCreditCardOwner.
	
	self deny: (facade listPurchasesOf: self validUser withPassword: self validPassword) purchases isEmpty .
	
	
	
		! !

!TusLibrosFacadeTest methodsFor: 'checkout test' stamp: 'ja 6/23/2021 21:53:51'!
test11CanNotCheckoutWithAnInvalidCartId

	self 
		should: [facade checkout: self invalidCartId 
			withCreditCardNumber: testObjectFactory notExpiredCreditCardNumber 
			expiringOn: testObjectFactory notExpiredCreditCardExpiringDate
			withOwner: testObjectFactory notExpiredCreditCardOwner] 
		raise: Error 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: facade invalidCartIdErrorDescription.
			self assert: (facade listPurchasesOf: self validUser withPassword: self validPassword) purchases isEmpty ]
	
		! !

!TusLibrosFacadeTest methodsFor: 'checkout test' stamp: 'ja 6/23/2021 21:54:05'!
test12CanNotCheckoutWithAnEmptyCart

	| cartId |
	
	cartId _ facade createCartFor: self validUser withPassword: 	self validPassword.

	self should: [facade checkout: cartId
			withCreditCardNumber: testObjectFactory notExpiredCreditCardNumber 
			expiringOn: testObjectFactory notExpiredCreditCardExpiringDate
			withOwner: testObjectFactory notExpiredCreditCardOwner] 
		raise: Error 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: facade canNotCheckoutWithAnEmptyCartErrorDescription.
			self assert: (facade listPurchasesOf: self validUser withPassword: self validPassword) purchases isEmpty]
	
		! !

!TusLibrosFacadeTest methodsFor: 'checkout test' stamp: 'ja 6/23/2021 21:54:11'!
test13CanNotCheckoutWithAnExpiredCreditCard

	| cartId |
	
	cartId _ facade createCartFor: self validUser withPassword: 	self validPassword.
	facade add: 1 of: self validBook to: cartId.

	self should: [facade checkout: cartId
			withCreditCardNumber: testObjectFactory notExpiredCreditCardNumber 
			expiringOn: testObjectFactory expiredCreditCardExpiringDate
			withOwner: testObjectFactory notExpiredCreditCardOwner] 
		raise: Error 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: facade canNotCheckoutWithAnExpiredCreditCardErrorDescription.
			self assert: (facade listPurchasesOf: self validUser withPassword: self validPassword) purchases isEmpty]
	
		! !

!TusLibrosFacadeTest methodsFor: 'checkout test' stamp: 'ja 6/23/2021 21:54:18'!
test14CanNotCheckoutWithAnInvalidCreditCard

	| cartId |
	
	cartId _ facade createCartFor: self validUser withPassword: 	self validPassword.
	facade add: 1 of: self validBook to: cartId.
	debitBehavior _ [:anAmount :aCreditCard | self error: Cashier invalidCreditCardErrorDescription].

	self should: [facade checkout: cartId
			withCreditCardNumber: testObjectFactory invalidCreditCardNumber 
			expiringOn: testObjectFactory notExpiredCreditCardExpiringDate 
			withOwner: testObjectFactory invalidCreditCardOwner] 
		raise: Error 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: facade canNotCheckoutWithAnInvalidCreditCardErrorDescription.
			self assert: (facade listPurchasesOf: self validUser withPassword: self validPassword) purchases isEmpty]
	
		! !

!TusLibrosFacadeTest methodsFor: 'checkout test' stamp: 'ja 6/23/2021 21:54:25'!
test15CanNotCheckoutWithAStolenCreditCard

	| cartId |
	
	cartId _ facade createCartFor: self validUser withPassword: 	self validPassword.
	facade add: 1 of: self validBook to: cartId.
	debitBehavior _ [:anAmount :aCreditCard | self error: Cashier stolenCreditCardErrorDescription].

	self should: [facade checkout: cartId
			withCreditCardNumber: testObjectFactory notExpiredCreditCardNumber 
			expiringOn: testObjectFactory notExpiredCreditCardExpiringDate 
			withOwner: testObjectFactory notExpiredCreditCardOwner] 
		raise: Error 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: facade canNotCheckoutWithAStolenCreditCardErrorDescription.
			self assert: (facade listPurchasesOf: self validUser withPassword: self validPassword) purchases isEmpty]
	
		! !

!TusLibrosFacadeTest methodsFor: 'checkout test' stamp: 'ja 6/23/2021 21:54:32'!
test16CanNotCheckoutWhenCreditCardHasNoCredit

	| cartId |
	
	cartId _ facade createCartFor: self validUser withPassword: 	self validPassword.
	facade add: 1 of: self validBook to: cartId.
	debitBehavior _ [:anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].

	self should: [facade checkout: cartId
			withCreditCardNumber: testObjectFactory notExpiredCreditCardNumber 
			expiringOn: testObjectFactory notExpiredCreditCardExpiringDate 
			withOwner: testObjectFactory notExpiredCreditCardOwner] 
		raise: Error 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: facade canNotCheckoutWhenCreditCardHasNoCreditErrorDescription.
			self assert: (facade listPurchasesOf: self validUser withPassword: self validPassword) purchases isEmpty]
	
		! !


!TusLibrosFacadeTest methodsFor: 'list purchases test' stamp: 'ja 6/23/2021 18:31:24'!
test17CanNotListPurchasesWithAnInvalidUser

	self should: [facade listPurchasesOf: self invalidUser withPassword: self validPassword ] 
		raise: Error 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: TusLibrosFacade invalidUserOrPasswordErrorDescription]
	
		! !

!TusLibrosFacadeTest methodsFor: 'list purchases test' stamp: 'ja 6/23/2021 16:32:32'!
test18CanNotListPurchasesWithAnInvalidPassword

	self should: [facade listPurchasesOf: self validUser withPassword: self invalidPassword ] 
		raise: Error 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: TusLibrosFacade invalidUserOrPasswordErrorDescription]
	
		! !

!TusLibrosFacadeTest methodsFor: 'list purchases test' stamp: 'ja 6/23/2021 21:55:35'!
test19CanListPurchasesAndSalesAreSaved

	| cartId listPurchases |
	
	cartId _ facade createCartFor: self validUser withPassword: 	self validPassword.
	facade add: 1 of: self validBook to: cartId.
	facade add: 2 of: self otherValidBook to: cartId.
	
	facade checkout: cartId
		withCreditCardNumber: testObjectFactory notExpiredCreditCardNumber 
		expiringOn: testObjectFactory notExpiredCreditCardExpiringDate
		withOwner: testObjectFactory notExpiredCreditCardOwner.
	
	listPurchases _ facade listPurchasesOf: self validUser withPassword: self validPassword.
	
	self deny: listPurchases purchases isEmpty.
	self assert: (listPurchases purchases at: self validBook) = 1.
	self assert: (listPurchases purchases at: self otherValidBook ) = 2.
	self assert: listPurchases total = (testObjectFactory itemSellByTheStorePrice + (testObjectFactory otherItemSellByTheStorePrice * 2)).! !


!TusLibrosFacadeTest methodsFor: 'session test' stamp: 'ja 6/23/2021 20:14:52'!
test20CanNotAddItemWhenSessionIsExpired

	| cartId |
	
	cartId _ facade createCartFor: self validUser withPassword: 	self validPassword.
	self adjustTime: [:aTime | aTime + 31 minutes].
	
	self should: [facade add: 1 of: self validBook to: cartId] 
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError  messageText equals: facade sessionHasExpiredErrorDescription.
			self adjustTime: [:aTime | aTime - 31 minutes].
			self assert: (facade listCartById: cartId) isEmpty]
	
	! !

!TusLibrosFacadeTest methodsFor: 'session test' stamp: 'ja 6/23/2021 20:04:06'!
test21CanNotListCartWhenSessionIsExpired

	| cartId |
	
	cartId _ facade createCartFor: self validUser withPassword: 	self validPassword.
	facade add: 1 of: self validBook to: cartId.
	self adjustTime: [:aTime | aTime + 31 minutes].
	
	self should: [facade listCartById: cartId] 
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError  messageText equals: facade sessionHasExpiredErrorDescription]
	
	! !

!TusLibrosFacadeTest methodsFor: 'session test' stamp: 'ja 6/23/2021 21:54:38'!
test22CanNotCheckoutWhenSessionIsExpired

	| cartId |
	
	cartId _ facade createCartFor: self validUser withPassword: 	self validPassword.
	facade add: 1 of: self validBook to: cartId.
	self adjustTime: [:aTime | aTime + 31 minutes].
	
	self should: [facade checkout: cartId
			withCreditCardNumber: testObjectFactory notExpiredCreditCardNumber 
			expiringOn: testObjectFactory notExpiredCreditCardExpiringDate
			withOwner: testObjectFactory notExpiredCreditCardOwner.] 
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError  messageText equals: facade sessionHasExpiredErrorDescription.
			self assert: (facade listPurchasesOf: self validUser withPassword: self validPassword) purchases isEmpty]
	
	! !


!TusLibrosFacadeTest methodsFor: 'private' stamp: 'ja 6/23/2021 19:19:12'!
adjustTime: aBlock

	customClock adjustTime: aBlock ! !

!TusLibrosFacadeTest methodsFor: 'private' stamp: 'ja 6/21/2021 17:02:15'!
invalidBook

	^ testObjectFactory itemNotSellByTheStore ! !

!TusLibrosFacadeTest methodsFor: 'private' stamp: 'ja 6/21/2021 17:15:02'!
invalidCartId

	^ 'invalidCartId'! !

!TusLibrosFacadeTest methodsFor: 'private' stamp: 'ja 6/21/2021 16:20:09'!
invalidPassword

	^ 'invalidPassword'! !

!TusLibrosFacadeTest methodsFor: 'private' stamp: 'ja 6/21/2021 16:19:51'!
invalidUser

	^ 'invalidUser'! !

!TusLibrosFacadeTest methodsFor: 'private' stamp: 'ja 6/21/2021 17:45:54'!
otherValidBook

	^ testObjectFactory otherItemSellByTheStore ! !

!TusLibrosFacadeTest methodsFor: 'private' stamp: 'ja 6/21/2021 16:54:18'!
validBook

	^ testObjectFactory itemSellByTheStore ! !

!TusLibrosFacadeTest methodsFor: 'private' stamp: 'ja 6/21/2021 16:19:35'!
validPassword

	^ 'validPassword'! !

!TusLibrosFacadeTest methodsFor: 'private' stamp: 'ja 6/21/2021 16:19:17'!
validUser

	^ 'validUser'! !

!TusLibrosFacadeTest methodsFor: 'private' stamp: 'ja 6/21/2021 16:18:48'!
validUsersAndPasswords

	^ Dictionary new at: self validUser put: self validPassword;
	yourself ! !


!TusLibrosFacadeTest methodsFor: 'merchant processor' stamp: 'ja 6/23/2021 16:09:49'!
debit: anAmount from: aCreditCard

	^ debitBehavior value: anAmount value: aCreditCard ! !


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


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'ja 6/21/2021 17:50:03'!
items

	^items copy! !

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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error description' stamp: 'ja 6/21/2021 17:09:23'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart class methodsFor: 'error description' stamp: 'ja 6/21/2021 17:33:54'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total owner purchase receipt'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'ja 6/23/2021 17:51:26'!
createSale

	^ Sale by: owner with: receipt 
	
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'ja 6/23/2021 17:48:57'!
checkOut

	self 
		calculateTotal;
		createReceipt;
		debitTotal;
		registerSale.

	^ total! !

!Cashier methodsFor: 'checkout' stamp: 'ja 6/23/2021 21:51:46'!
createReceipt

	| purchases |
	
	purchases _ Bag new.
	
	cart items do: [:anItem | purchases add: anItem ].
	
	receipt _ PurchaseReceipt with: purchases contents addingATotalOf: total .
	! !


!Cashier methodsFor: 'initialization' stamp: 'ja 6/23/2021 16:59:51'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook ownedBy: anOwner 
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook.
	owner _ anOwner ! !

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


!Cashier class methodsFor: 'instance creation' stamp: 'ja 6/23/2021 16:59:42'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook ownedBy: anOwner 
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook ownedBy: anOwner! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !

!Cashier class methodsFor: 'error messages' stamp: 'ja 6/23/2021 16:16:13'!
invalidCreditCardErrorDescription

	^ 'Invalid Credit Card'! !

!Cashier class methodsFor: 'error messages' stamp: 'ja 6/23/2021 16:19:27'!
stolenCreditCardErrorDescription

	^ 'Stolen Credit Card'! !


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


!classDefinition: #CustomClock category: 'TusLibros'!
Object subclass: #CustomClock
	instanceVariableNames: 'now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CustomClock methodsFor: 'accessing' stamp: 'ja 6/23/2021 19:20:53'!
adjustTime: aBlock 

	now _ aBlock value: now.! !

!CustomClock methodsFor: 'accessing' stamp: 'ja 6/23/2021 19:51:13'!
now

	^ now! !


!CustomClock methodsFor: 'initialization' stamp: 'ja 6/23/2021 19:15:17'!
initializeFrom: aDate 

	now _ aDate ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomClock class' category: 'TusLibros'!
CustomClock class
	instanceVariableNames: ''!

!CustomClock class methodsFor: 'as yet unclassified' stamp: 'ja 6/23/2021 19:15:07'!
from: aDate

	^ self new initializeFrom: aDate 
	
	! !


!classDefinition: #PurchaseReceipt category: 'TusLibros'!
Object subclass: #PurchaseReceipt
	instanceVariableNames: 'purchases total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!PurchaseReceipt methodsFor: 'initialization' stamp: 'ja 6/23/2021 17:50:54'!
initiliazeWith: aPurchases addingATotalOf: anAmount 

	purchases _ aPurchases .
	total  _ anAmount ! !


!PurchaseReceipt methodsFor: 'purchase' stamp: 'ja 6/23/2021 18:17:47'!
purchases
	
	^ purchases ! !


!PurchaseReceipt methodsFor: 'total' stamp: 'ja 6/23/2021 17:56:28'!
total 

	^ total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PurchaseReceipt class' category: 'TusLibros'!
PurchaseReceipt class
	instanceVariableNames: ''!

!PurchaseReceipt class methodsFor: 'instance creation' stamp: 'ja 6/23/2021 17:50:31'!
with: aPurchases addingATotalOf: anAmount 

	^ self new initiliazeWith: aPurchases addingATotalOf: anAmount ! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'owner receipt'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'ja 6/23/2021 18:18:32'!
purchases 

	^ receipt purchases ! !

!Sale methodsFor: 'total' stamp: 'ja 6/23/2021 17:56:15'!
total
	
	^ receipt total! !

!Sale methodsFor: 'total' stamp: 'ja 6/23/2021 18:03:24'!
wasMadeBy: anUser

	^ owner = anUser ! !


!Sale methodsFor: 'initialization' stamp: 'ja 6/23/2021 17:53:16'!
initializeBy: anOwner with: aReceipt

	owner _ anOwner .
	receipt _ aReceipt ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'ja 6/23/2021 17:52:53'!
by: anOwner with: aReceipt 

	^ self new initializeBy: anOwner with: aReceipt! !


!classDefinition: #Session category: 'TusLibros'!
Object subclass: #Session
	instanceVariableNames: 'owner cart facade lastTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Session methodsFor: 'initialization' stamp: 'ja 6/23/2021 19:57:57'!
initializeBy: anUser with: aCart on: aFacade

	owner  _ anUser .
	cart _ aCart.
	facade _ aFacade .
	lastTime _ facade now.! !


!Session methodsFor: 'error description' stamp: 'ja 6/23/2021 19:54:00'!
sessionHasExpiredErrorDescription

	^'Session has expired'! !


!Session methodsFor: 'protocol' stamp: 'ja 6/23/2021 19:43:07'!
add: anAmount of: aBook
	
	self assertIfExpired.
	cart add: anAmount of: aBook .! !

!Session methodsFor: 'protocol' stamp: 'ja 6/23/2021 20:13:22'!
checkoutWithCreditCardExpiringOn: aDate 

	self assertIfExpired.
	^ (Cashier 
		toCheckout: cart
		charging: (CreditCard expiringOn: aDate )
		throught: facade merchantProcessor
		on: facade now date
		registeringOn: facade salesBook
		ownedBy: owner) checkOut. ! !

!Session methodsFor: 'protocol' stamp: 'ja 6/23/2021 20:02:32'!
itemsOfCart
	
	self assertIfExpired.
	^ cart items! !


!Session methodsFor: 'assertions' stamp: 'ja 6/24/2021 15:25:51'!
assertIfExpired
	
	| now |
	now _ facade now.
	
	((lastTime + facade sessionDuration) < now) ifTrue:[self error: self sessionHasExpiredErrorDescription].
	
	lastTime _ now.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Session class' category: 'TusLibros'!
Session class
	instanceVariableNames: ''!

!Session class methodsFor: 'error description' stamp: 'ja 6/23/2021 19:53:40'!
sessionHasExpiredErrorDescription

	^'Session has expired'! !


!Session class methodsFor: 'instance creation' stamp: 'ja 6/23/2021 19:32:34'!
by: anUser with: aCart on: aFacade

	^ self new initializeBy: anUser with: aCart on: aFacade! !


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

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'ja 6/21/2021 17:47:05'!
otherItemSellByTheStore

	^ 'otherValidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'ja 6/21/2021 17:47:22'!
otherItemSellByTheStorePrice
	
	^23! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'ja 6/21/2021 17:47:56'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self otherItemSellByTheStore put: self otherItemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ja 6/23/2021 16:05:00'!
expiredCreditCardExpiringDate

	^ Month month: today monthIndex year: today yearNumber - 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ja 6/23/2021 16:14:26'!
invalidCreditCardNumber

	^ '1'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ja 6/23/2021 16:14:50'!
invalidCreditCardOwner

	^ 'invalidOwner'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ja 6/21/2021 18:12:35'!
notExpiredCreditCardExpiringDate

	^ Month month: today monthIndex year: today yearNumber + 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ja 6/21/2021 18:11:45'!
notExpiredCreditCardNumber
	
	^'1234567891234567' ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ja 6/23/2021 18:26:52'!
notExpiredCreditCardOwner

	^ 'validUser'! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'user' stamp: 'ja 6/23/2021 17:01:33'!
user

	^'user'! !


!classDefinition: #TusLibrosFacade category: 'TusLibros'!
Object subclass: #TusLibrosFacade
	instanceVariableNames: 'validAccounts catalog sessions lastId salesBook merchantProcesor clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosFacade methodsFor: 'initialization' stamp: 'ja 6/23/2021 19:39:44'!
initializeAuthenticatingOver: aValidAccounts withCatalog: aCatalog trought: aMerchantProcessor registiringOn: aSalesBook withClock: aClock 
	
	catalog _ aCatalog .
	validAccounts _ aValidAccounts.
	salesBook _ aSalesBook .
	merchantProcesor _ aMerchantProcessor .
	clock _ aClock.
	sessions _ Dictionary new.
	lastId  _ 0 ! !


!TusLibrosFacade methodsFor: 'error description' stamp: 'ja 6/21/2021 17:08:44'!
canNotAddABookNotSellByTheStoreErrorDescription

	^ Cart invalidItemErrorMessage ! !

!TusLibrosFacade methodsFor: 'error description' stamp: 'ja 6/21/2021 17:34:06'!
canNotAddAnInvalidQuantityOfABookErrorDescription

	^ Cart invalidQuantityErrorMessage ! !

!TusLibrosFacade methodsFor: 'error description' stamp: 'ja 6/23/2021 16:23:16'!
canNotCheckoutWhenCreditCardHasNoCreditErrorDescription

	^ Cashier creditCardHasNoCreditErrorMessage ! !

!TusLibrosFacade methodsFor: 'error description' stamp: 'ja 6/23/2021 16:20:04'!
canNotCheckoutWithAStolenCreditCardErrorDescription

	^ Cashier stolenCreditCardErrorDescription ! !

!TusLibrosFacade methodsFor: 'error description' stamp: 'ja 6/23/2021 15:53:15'!
canNotCheckoutWithAnEmptyCartErrorDescription

	^ Cashier cartCanNotBeEmptyErrorMessage ! !

!TusLibrosFacade methodsFor: 'error description' stamp: 'ja 6/23/2021 16:05:52'!
canNotCheckoutWithAnExpiredCreditCardErrorDescription

	^ Cashier canNotChargeAnExpiredCreditCardErrorMessage ! !

!TusLibrosFacade methodsFor: 'error description' stamp: 'ja 6/23/2021 16:16:38'!
canNotCheckoutWithAnInvalidCreditCardErrorDescription

	^ Cashier invalidCreditCardErrorDescription ! !

!TusLibrosFacade methodsFor: 'error description' stamp: 'ja 6/21/2021 17:28:47'!
invalidCartIdErrorDescription

	^ 'Cart was not found for the given CartId'! !

!TusLibrosFacade methodsFor: 'error description' stamp: 'ja 6/23/2021 19:53:17'!
sessionHasExpiredErrorDescription

	^ Session sessionHasExpiredErrorDescription! !


!TusLibrosFacade methodsFor: 'protocol' stamp: 'ja 6/23/2021 19:40:31'!
add: anAmount of: aBook to: aCartId
	
	| currentSession |
	
	currentSession _ self sessionsAt: aCartId.
	currentSession add: anAmount of: aBook.
	
	! !

!TusLibrosFacade methodsFor: 'protocol' stamp: 'ja 6/23/2021 20:13:08'!
checkout: aCartId withCreditCardNumber: aCreditCardNumber expiringOn: aDate withOwner: anOwner 
	
	| currentSession |
	currentSession _ self sessionsAt: aCartId.
	^ currentSession checkoutWithCreditCardExpiringOn: aDate. 
	! !

!TusLibrosFacade methodsFor: 'protocol' stamp: 'ja 6/23/2021 21:22:41'!
createCartFor: anUser withPassword: aPassword
	
	| cartId |
	
	self assertIf: anUser hasTheCorrect: aPassword.
	
	cartId _ self generateNewId.
	
	sessions at: cartId put: (Session by: anUser with: (Cart acceptingItemsOf: catalog) on: self).
	
	^ cartId
	
	
	
	! !

!TusLibrosFacade methodsFor: 'protocol' stamp: 'ja 6/23/2021 21:33:44'!
listCartById: aCartId

	^ (self sessionsAt: aCartId) itemsOfCart.
	
	! !

!TusLibrosFacade methodsFor: 'protocol' stamp: 'ja 6/23/2021 17:58:02'!
listPurchasesOf: anUser withPassword: aPassword

	self assertIf: anUser hasTheCorrect: aPassword.
	^ self salesOwnedBy: anUser.! !


!TusLibrosFacade methodsFor: 'authentication' stamp: 'ja 6/21/2021 16:30:04'!
assertIf: anUser hasTheCorrect: aPassword
	
	| password |
	password _ validAccounts at: anUser ifAbsent:[self error: self class invalidUserOrPasswordErrorDescription].
	password = aPassword ifFalse: [self error: self class invalidUserOrPasswordErrorDescription]
	! !


!TusLibrosFacade methodsFor: 'private' stamp: 'ja 6/21/2021 16:42:03'!
generateNewId

	^ lastId _ lastId + 1 ! !

!TusLibrosFacade methodsFor: 'private' stamp: 'ja 6/23/2021 21:52:37'!
salesOwnedBy: anUser
	
	| allSales purchases total |
	
	allSales _ salesBook select:[ :aSale | aSale wasMadeBy: anUser ].
	
	total _ 0.
	purchases _ Dictionary new.
	allSales do:[ :aSale | purchases addAll: aSale purchases.
		total _ total + aSale total ].
	
	^ PurchaseReceipt with: purchases addingATotalOf: total.! !

!TusLibrosFacade methodsFor: 'private' stamp: 'ja 6/23/2021 19:50:41'!
sessionDuration

	^ 30 minutes! !

!TusLibrosFacade methodsFor: 'private' stamp: 'ja 6/23/2021 19:40:17'!
sessionsAt: aCartId

	^ sessions at: aCartId ifAbsent: [self error: self invalidCartIdErrorDescription ]! !


!TusLibrosFacade methodsFor: 'accessing' stamp: 'ja 6/23/2021 20:10:55'!
merchantProcessor

	^ merchantProcesor ! !

!TusLibrosFacade methodsFor: 'accessing' stamp: 'ja 6/23/2021 19:50:50'!
now

	^ clock now! !

!TusLibrosFacade methodsFor: 'accessing' stamp: 'ja 6/23/2021 20:11:09'!
salesBook
	
	^ salesBook ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosFacade class' category: 'TusLibros'!
TusLibrosFacade class
	instanceVariableNames: ''!

!TusLibrosFacade class methodsFor: 'instance creation' stamp: 'ja 6/23/2021 19:25:18'!
authenticatingOver: aValidAccounts withCatalog: aCatalog trought: aMerchantProcessor registiringOn: aSalesBook withClock: aClock 

	^ self new initializeAuthenticatingOver: aValidAccounts withCatalog: aCatalog trought: aMerchantProcessor registiringOn: aSalesBook withClock: aClock! !


!TusLibrosFacade class methodsFor: 'error description' stamp: 'ja 6/21/2021 15:49:15'!
invalidUserOrPasswordErrorDescription
	
	^'Invalid user or password' ! !
