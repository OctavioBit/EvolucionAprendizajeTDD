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
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'JPF 6/21/2021 11:20:37'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: testObjectsFactory createMerchantProcessor
			on: testObjectsFactory today
			registeringOn:  salesBook
			generatingTransactionIdWith: testObjectsFactory transactionIdGenerator ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'JPF 6/21/2021 12:33:17'!
test02CalculatedTotalIsCorrect

	| cart cashier salesBook transactionId |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedDictionary new.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: testObjectsFactory createMerchantProcessor
		on: testObjectsFactory today 
		registeringOn: salesBook
		generatingTransactionIdWith: testObjectsFactory transactionIdGenerator.
		
	transactionId := cashier checkOut.
		
	self assert: (salesBook at: transactionId) total = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'JPF 6/21/2021 11:20:42'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: testObjectsFactory createMerchantProcessor
				on: testObjectsFactory today
				registeringOn: salesBook
				generatingTransactionIdWith: testObjectsFactory transactionIdGenerator ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'JPF 6/21/2021 12:37:10'!
test04CheckoutRegistersASale

	| cart cashier salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedDictionary new.
 
	cashier := Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: testObjectsFactory createMerchantProcessor
		on: testObjectsFactory today
		registeringOn: salesBook
		generatingTransactionIdWith: testObjectsFactory transactionIdGenerator.
		
	cashier checkOut.

	self assert: salesBook size = 1.! !

!CashierTest methodsFor: 'tests' stamp: 'JPF 6/21/2021 12:39:01'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook creditCard debitedAmout debitedCreditCard  transactionId |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedDictionary new.
	
	testObjectsFactory debitBehavior: [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	
 	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: testObjectsFactory createMerchantProcessor
		on: testObjectsFactory today
		registeringOn: salesBook
		generatingTransactionIdWith: testObjectsFactory transactionIdGenerator.	
		
	transactionId := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = (salesBook at: transactionId) total.! !

!CashierTest methodsFor: 'tests' stamp: 'JPF 6/21/2021 12:48:27'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	testObjectsFactory debitBehavior: [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedDictionary new.
 	
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: testObjectsFactory createMerchantProcessor
		on: testObjectsFactory today
		registeringOn: salesBook
		generatingTransactionIdWith: testObjectsFactory transactionIdGenerator.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'JPF 6/20/2021 13:16:56'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'setUp' stamp: 'JPF 6/20/2021 10:50:30'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.! !


!CreditCardTest methodsFor: 'tests' stamp: 'JPF 6/20/2021 11:04:47'!
test01ShouldFailWhenTheNameIsEmpty

	self 
		should: [ 
			CreditCard
				withNumber: testObjectsFactory validCreditCardNumber
				of: ''
				expiringOn: testObjectsFactory notExpiredCreditCardMonth ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard canNotCreateACreditCardWithEmptyName.! !

!CreditCardTest methodsFor: 'tests' stamp: 'JPF 6/20/2021 11:10:50'!
test02ShouldFailWhenTheNameIsAllWithespaceCharacters

	self 
		should: [ 
			CreditCard
				withNumber: testObjectsFactory validCreditCardNumber
				of: '       '
				expiringOn: testObjectsFactory notExpiredCreditCardMonth ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard canNotCreateACreditCardWithAllWithespaceCharacters! !

!CreditCardTest methodsFor: 'tests' stamp: 'JPF 6/20/2021 11:14:27'!
test03ShouldFailWhenTheNameHasMoreThan30Characters

	self 
		should: [ 
			CreditCard
				withNumber: testObjectsFactory validCreditCardNumber
				of: 'NameWithMoreThanThirtyCharacter'
				expiringOn: testObjectsFactory notExpiredCreditCardMonth ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard canNotCreateACreditCardWithANameWithMoreThan30Characters.! !

!CreditCardTest methodsFor: 'tests' stamp: 'JPF 6/20/2021 11:17:25'!
test04ShouldFailWhenTheNumberHasNot16Digits

	self 
		should: [ 
			CreditCard
				withNumber: 11118888111188881
				of: testObjectsFactory validCreditCardName
				expiringOn: testObjectsFactory notExpiredCreditCardMonth ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard canNotCreateACreditCardWithANumberThatHasNot16Digits.
		
	self 
		should: [ 
			CreditCard
				withNumber: 111188881111888
				of: testObjectsFactory validCreditCardName
				expiringOn: testObjectsFactory notExpiredCreditCardMonth ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard canNotCreateACreditCardWithANumberThatHasNot16Digits.! !


!classDefinition: #StoreFacadeTest category: 'TusLibros'!
TestCase subclass: #StoreFacadeTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreFacadeTest methodsFor: 'tests' stamp: 'JPF 6/20/2021 12:08:30'!
test01ShouldFailToCreateCartWhenClientIdOrPasswordAreIncorrect

	| clientId password validatedClientId validatedPassword storeFacade |
	
	clientId := 'clientId'.
	password := 'password'.
	
	testObjectsFactory validateUserBehaviour: [ :clientIdArg :passwordArg |
		validatedClientId := clientIdArg.
		validatedPassword := passwordArg.
		self error: ClientValidator clientIdOrPasswordAreIncorrect.
		].
	
	storeFacade := testObjectsFactory createStoreFacade.
	
	self 
		should: [ storeFacade createCartFor: clientId withPassword: password ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: ClientValidator clientIdOrPasswordAreIncorrect.
		
	self assert: password = validatedPassword.
	self assert: clientId = validatedClientId.! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'JPF 6/21/2021 14:09:07'!
test02ShouldCreateACartAndBeEmptyWhenListed

	| storeFacade cartDetail cartId |
	
	storeFacade := testObjectsFactory createStoreFacade.
	
	cartId := storeFacade createCartFor: testObjectsFactory clientId withPassword: testObjectsFactory password.
	
	cartDetail := storeFacade listCart: cartId.
	
	self assert: cartDetail isEmpty! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'JPF 6/21/2021 14:09:54'!
test03ShouldAddAnItemToTheCart

	| storeFacade cartDetail cartId |
	
	storeFacade := testObjectsFactory createStoreFacade.
	
	cartId := storeFacade createCartFor: testObjectsFactory clientId withPassword: testObjectsFactory password.
	
	storeFacade add: 3 of: testObjectsFactory itemSellByTheStore to: cartId.
	
	cartDetail := storeFacade listCart: cartId.
	
	self assert: cartDetail size = 1.
	self assert: (cartDetail at: testObjectsFactory itemSellByTheStore) = 3.! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'JPF 6/20/2021 10:17:52'!
test04ShouldFailWhenTryToAddItemsToAnInexistentCart

	| storeFacade |
	
	storeFacade := testObjectsFactory createStoreFacade.
	
	self 
		should: [ storeFacade add: 3 of: testObjectsFactory itemSellByTheStore to: 0 ]
		raise: Error - MessageNotUnderstood
		withMessageText: StoreFacade inexistentCartErrorMessage.
		
	
	! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'JPF 6/20/2021 10:18:01'!
test05ShouldFailWhenTryToListAnInexistentCart

	| storeFacade |
	
	storeFacade := testObjectsFactory createStoreFacade.
	
	self 
		should: [ storeFacade listCart: 0 ]
		raise: Error - MessageNotUnderstood
		withMessageText: StoreFacade inexistentCartErrorMessage.
		
	
	! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'JPF 6/21/2021 14:10:42'!
test06ShouldAddAnItemToTheCorrectCart

	| storeFacade cartDetailNotEmpty cartIdToAdd cartIdEmpty cartDetailEmpty |
	
	storeFacade := testObjectsFactory createStoreFacade.
	
	cartIdEmpty := storeFacade createCartFor: testObjectsFactory clientId withPassword: testObjectsFactory password.
	cartIdToAdd := storeFacade createCartFor: testObjectsFactory clientId withPassword: testObjectsFactory password.
	
	storeFacade add: 3 of: testObjectsFactory itemSellByTheStore to: cartIdToAdd.
	cartDetailNotEmpty := storeFacade listCart: cartIdToAdd.
	
	cartDetailEmpty := storeFacade listCart: cartIdEmpty.

	self assert: cartDetailNotEmpty size = 1.
	self assert: (cartDetailNotEmpty at: testObjectsFactory itemSellByTheStore) = 3.

	self assert: cartDetailEmpty isEmpty! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'JPF 6/21/2021 22:08:48'!
test07ShouldReturnADifferentTransactionIdPerCheckout

	| storeFacade cartId1 cartId2 transactionId1 transactionId2 clientId |
	
	clientId := testObjectsFactory clientId.
	
	storeFacade := testObjectsFactory createStoreFacade.

	cartId1 := storeFacade createCartFor: clientId withPassword: testObjectsFactory password.
	storeFacade add: 3 of: testObjectsFactory itemSellByTheStore to: cartId1.
	transactionId1 := storeFacade
		checkOutCart: cartId1
		payingWithCardNumber: testObjectsFactory validCreditCardNumber 
		of: testObjectsFactory validCreditCardName
		expiringOn: testObjectsFactory notExpiredCreditCardMonth
		.
	
	cartId2 := storeFacade createCartFor: clientId withPassword: testObjectsFactory password.
	storeFacade add: 2 of: testObjectsFactory itemSellByTheStore to: cartId2.
	
	transactionId2 := storeFacade
		checkOutCart: cartId2
		payingWithCardNumber: testObjectsFactory validCreditCardNumber 
		of: testObjectsFactory validCreditCardName
		expiringOn: testObjectsFactory notExpiredCreditCardMonth
		.
		
	self deny: transactionId1 = transactionId2.
	
	

! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'JPF 6/21/2021 22:08:48'!
test08ShouldFailWhenTryToCheckoutTheSameCartTwice

	| storeFacade cartId clientId |
	
	clientId := testObjectsFactory clientId.
	storeFacade := testObjectsFactory createStoreFacade.

	cartId := storeFacade createCartFor: clientId withPassword: testObjectsFactory password.
	storeFacade add: 3 of: testObjectsFactory itemSellByTheStore to: cartId.
	storeFacade
		checkOutCart: cartId
		payingWithCardNumber: testObjectsFactory validCreditCardNumber 
		of: testObjectsFactory validCreditCardName
		expiringOn: testObjectsFactory notExpiredCreditCardMonth
		.
		
	self
		should: [
		storeFacade
			checkOutCart: cartId
			payingWithCardNumber: testObjectsFactory validCreditCardNumber 
			of: testObjectsFactory validCreditCardName
			expiringOn: testObjectsFactory notExpiredCreditCardMonth
			]
		raise: Error - MessageNotUnderstood 
		withMessageText: StoreFacade inexistentCartErrorMessage
	
	
	

! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'JPF 6/20/2021 12:09:50'!
test09ShouldFailWhenListPurchasesForAnIncorrectClientIdOrPassword

	| clientId password validatedClientId validatedPassword storeFacade |
	
	clientId := 'clientId'.
	password := 'password'.
	
	testObjectsFactory validateUserBehaviour: [ :clientIdArg :passwordArg |
		validatedClientId := clientIdArg.
		validatedPassword := passwordArg.
		self error: ClientValidator clientIdOrPasswordAreIncorrect.
		].
	
	storeFacade := testObjectsFactory createStoreFacade.
	
	self 
		should: [ storeFacade listPurchasesOf: clientId withPassword: password ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: ClientValidator clientIdOrPasswordAreIncorrect.
		
	self assert: password = validatedPassword.
	self assert: clientId = validatedClientId.
	
	
	

! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'JPF 6/20/2021 12:28:41'!
test10ShouldReturnEmptyListOfPurchasesWhenClientDidNotMakeAnyPurchase

	| storeFacade cartId  purchasesByClient |
	
	storeFacade := testObjectsFactory createStoreFacade.

	cartId := storeFacade createCartFor: testObjectsFactory clientId withPassword: testObjectsFactory password.
	storeFacade add: 3 of: testObjectsFactory itemSellByTheStore to: cartId.
	storeFacade add: 1 of: testObjectsFactory itemSellByTheStore2 to: cartId.

	purchasesByClient := storeFacade
		listPurchasesOf: testObjectsFactory
		clientId withPassword: testObjectsFactory password.
		
	self assert: purchasesByClient isEmpty.
	
		
	! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'JPF 6/21/2021 22:08:48'!
test11ShouldListClientPurchases

	| storeFacade cartId1  cartId2 purchasesDetailOfClient clientId anotherClientId anotherClientCartId |
	
	clientId := testObjectsFactory clientId.
	storeFacade := testObjectsFactory createStoreFacade.

	cartId1 := storeFacade createCartFor: clientId withPassword: testObjectsFactory password.
	storeFacade add: 3 of: testObjectsFactory itemSellByTheStore to: cartId1.
	storeFacade add: 1 of: testObjectsFactory itemSellByTheStore2 to: cartId1.
	storeFacade
		checkOutCart: cartId1
		payingWithCardNumber: testObjectsFactory validCreditCardNumber 
		of: testObjectsFactory validCreditCardName
		expiringOn: testObjectsFactory notExpiredCreditCardMonth
		.
		
	cartId2 := storeFacade createCartFor: clientId withPassword: testObjectsFactory password.
	storeFacade add: 1 of: testObjectsFactory itemSellByTheStore to: cartId2.
	storeFacade add: 2 of: testObjectsFactory itemSellByTheStore2 to: cartId2.
	storeFacade
		checkOutCart: cartId2
		payingWithCardNumber: testObjectsFactory validCreditCardNumber 
		of: testObjectsFactory validCreditCardName
		expiringOn: testObjectsFactory notExpiredCreditCardMonth
		.
		
	anotherClientId := 'anotherClientId'.
	
	anotherClientCartId := storeFacade createCartFor: anotherClientId withPassword: testObjectsFactory password.
	storeFacade add: 1 of: testObjectsFactory itemSellByTheStore to: anotherClientCartId.
	storeFacade add: 1 of: testObjectsFactory itemSellByTheStore2 to: anotherClientCartId.
	storeFacade
		checkOutCart: anotherClientCartId
		payingWithCardNumber: testObjectsFactory validCreditCardNumber 
		of: testObjectsFactory validCreditCardName
		expiringOn: testObjectsFactory notExpiredCreditCardMonth
		.
		
	purchasesDetailOfClient := storeFacade
		listPurchasesOf: testObjectsFactory
		clientId withPassword: testObjectsFactory password.
		
	self assert: 100 equals: purchasesDetailOfClient total.
	self assert: 2 equals: purchasesDetailOfClient items size.
	
	self assert: 4 equals: (purchasesDetailOfClient items at: testObjectsFactory itemSellByTheStore).
	self assert: 3 equals: (purchasesDetailOfClient items at: testObjectsFactory itemSellByTheStore2).

		
	! !

!StoreFacadeTest methodsFor: 'tests' stamp: 'JPF 6/21/2021 14:02:15'!
test12ShouldFailWhenTryToAccessACartAfter30MinutesFromTheLastAccess

	| storeFacade cartId  clientId today |
	
	clientId := testObjectsFactory clientId.
	storeFacade := testObjectsFactory createStoreFacade.
	
	today := testObjectsFactory today.

	testObjectsFactory clockBehaviour: [ today ].
	cartId := storeFacade createCartFor: clientId withPassword: testObjectsFactory password.
	testObjectsFactory clockBehaviour: [ today + (Duration minutes: 30) ].
	self 
		should: [ storeFacade listCart: cartId ]
		raise: Error - MessageNotUnderstood
		withMessageText: StoreFacade inexistentCartErrorMessage.
	
	testObjectsFactory clockBehaviour: [ today ].	
	cartId := storeFacade createCartFor: clientId withPassword: testObjectsFactory password.
	testObjectsFactory clockBehaviour: [ today + (Duration minutes: 30) ].
	self 
		should: [ storeFacade add: 1 of: testObjectsFactory itemSellByTheStore to: cartId ]
		raise: Error - MessageNotUnderstood
		withMessageText: StoreFacade inexistentCartErrorMessage.
	
	testObjectsFactory clockBehaviour: [ today ].	
	cartId := storeFacade createCartFor: clientId withPassword: testObjectsFactory password.
	testObjectsFactory clockBehaviour: [ today + (Duration minutes: 29) ].
	storeFacade add: 3 of: testObjectsFactory itemSellByTheStore to: cartId.
	testObjectsFactory clockBehaviour: [ today + (Duration minutes: 59) ].
	self 
		should: [ storeFacade listCart: cartId ]
		raise: Error - MessageNotUnderstood
		withMessageText: StoreFacade inexistentCartErrorMessage.
	
	testObjectsFactory clockBehaviour: [ today ].	
	cartId := storeFacade createCartFor: clientId withPassword: testObjectsFactory password.
	testObjectsFactory clockBehaviour: [ today + (Duration minutes: 29) ].
	storeFacade listCart: cartId.
	testObjectsFactory clockBehaviour: [ today + (Duration minutes: 59) ].
	self 
		should: [ storeFacade add: 3 of: testObjectsFactory itemSellByTheStore to: cartId ]
		raise: Error - MessageNotUnderstood
		withMessageText: StoreFacade inexistentCartErrorMessage.
		
	testObjectsFactory clockBehaviour: [ today + (Duration minutes: 62) ].
	self 
		should: [ storeFacade listCart: cartId. ]
		raise: Error - MessageNotUnderstood
		withMessageText: StoreFacade inexistentCartErrorMessage.
		
	

		
	! !


!StoreFacadeTest methodsFor: 'setUp' stamp: 'JPF 6/20/2021 10:09:01'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	! !


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


!Cart methodsFor: 'initialization' stamp: 'JPF 6/20/2021 13:52:16'!
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


!Cart methodsFor: 'accessing' stamp: 'JPF 6/21/2021 10:08:03'!
cartDetail

	| cartDetail |
	
	cartDetail := OrderedDictionary new.

	items do: [ :item |
		cartDetail at: item put: (items occurrencesOf: item)
		].
	
	^ cartDetail! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total transactionIdGenerator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'JPF 6/21/2021 10:04:02'!
createSale

	^ Sale of: cart cartDetail totalizing: total.
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'JPF 6/21/2021 11:16:32'!
registerSale

	| sale transactionId |
	
	sale := self createSale.
	transactionId := transactionIdGenerator nextTransactionId.

	salesBook at: transactionId put: sale.
	
	^ transactionId.! !


!Cashier methodsFor: 'checkout' stamp: 'JPF 6/21/2021 10:48:29'!
checkOut

	| transactionId |
	
	self calculateTotal.
	self debitTotal.
	transactionId := self registerSale.

	^ transactionId.! !


!Cashier methodsFor: 'initialization' stamp: 'JPF 6/21/2021 11:32:39'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook generatingTransactionIdWith: aTransactionIdGenerator 
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook.
	transactionIdGenerator := aTransactionIdGenerator.! !


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


!Cashier class methodsFor: 'instance creation' stamp: 'JPF 6/21/2021 11:31:57'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook generatingTransactionIdWith: aTransactionIdGenerator 
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook generatingTransactionIdWith: aTransactionIdGenerator! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #ClientValidator category: 'TusLibros'!
Object subclass: #ClientValidator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ClientValidator methodsFor: 'validation' stamp: 'JPF 6/20/2021 12:12:26'!
validateClient: aClientId withPassword: aPassword

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ClientValidator class' category: 'TusLibros'!
ClientValidator class
	instanceVariableNames: ''!

!ClientValidator class methodsFor: 'error descriptions' stamp: 'JPF 6/17/2021 21:23:45'!
clientIdOrPasswordAreIncorrect
	
	^ 'ClientId or password are incorrect'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'JPF 6/20/2021 11:20:07'!
initializeWithNumber: aCreditCardNumber of: aName expiringOn: aMonth

	self assertNameIsValid: aName.
	self assertCreditCardNumberIsValid: aCreditCardNumber.
	
	expiration := aMonth.
	number := aCreditCardNumber.
	name := aName.! !


!CreditCard methodsFor: 'assertions' stamp: 'JPF 6/20/2021 11:20:07'!
assertCreditCardNumberIsValid: aCreditCardNumber

	^ (aCreditCardNumber numberOfDigitsInBase: 10) ~= 16
		ifTrue: [ self error: self class canNotCreateACreditCardWithANumberThatHasNot16Digits ]! !

!CreditCard methodsFor: 'assertions' stamp: 'JPF 6/20/2021 11:21:40'!
assertNameHasNotMoreThan30Characters: aName

	^ aName size > 30 
		ifTrue: [ self error: self class canNotCreateACreditCardWithANameWithMoreThan30Characters ]! !

!CreditCard methodsFor: 'assertions' stamp: 'JPF 6/20/2021 11:21:14'!
assertNameHasNotOnlyWithspaceCharacters: aName

	^ aName withBlanksTrimmed isEmpty
		ifTrue: [ self error: self class canNotCreateACreditCardWithAllWithespaceCharacters ]! !

!CreditCard methodsFor: 'assertions' stamp: 'JPF 6/20/2021 11:20:39'!
assertNameIsNotEmpty: aName

	^ aName isEmpty 
		ifTrue: [ self error: self class canNotCreateACreditCardWithEmptyName ]! !

!CreditCard methodsFor: 'assertions' stamp: 'JPF 6/20/2021 11:21:40'!
assertNameIsValid: aName

	self assertNameIsNotEmpty: aName.
	self assertNameHasNotOnlyWithspaceCharacters: aName.
	self assertNameHasNotMoreThan30Characters: aName! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'JPF 6/20/2021 11:00:04'!
withNumber: aCreditCardNumber of: aName expiringOn: aMonth 
	
	^self new initializeWithNumber: aCreditCardNumber of: aName expiringOn: aMonth.! !


!CreditCard class methodsFor: 'error descriptions' stamp: 'JPF 6/20/2021 11:15:08'!
canNotCreateACreditCardWithANameWithMoreThan30Characters
	
	^ 'Credit card can not have a name with more than 30 characters'! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'JPF 6/20/2021 11:18:10'!
canNotCreateACreditCardWithANumberThatHasNot16Digits
	
	^ 'Credit card number should have 16 digits'! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'JPF 6/20/2021 11:11:46'!
canNotCreateACreditCardWithAllWithespaceCharacters
	
	^ 'Credit card can not have a name with all whitespaces characters'! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'JPF 6/20/2021 10:54:45'!
canNotCreateACreditCardWithEmptyName
	
	^ 'Credit card can not have an empty name'! !


!classDefinition: #PurchasesDetail category: 'TusLibros'!
Object subclass: #PurchasesDetail
	instanceVariableNames: 'items total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!PurchasesDetail methodsFor: 'initialization' stamp: 'JPF 6/23/2021 18:25:13'!
initializeFor: sales
	
	total := 0.
	items := OrderedDictionary new.
	
	sales do: [ :sale |
		sale items associationsDo: [ :saleItem || purchasesDetailItemQuantity |
			purchasesDetailItemQuantity := items at: saleItem key ifAbsent: [ 0 ].
			items at: saleItem key put: purchasesDetailItemQuantity + saleItem value
			].
		total := total + sale total.
		].
! !


!PurchasesDetail methodsFor: 'accessing' stamp: 'JPF 6/21/2021 12:28:35'!
items
	
	^items! !

!PurchasesDetail methodsFor: 'accessing' stamp: 'JPF 6/21/2021 12:27:38'!
total
	
	^total! !


!PurchasesDetail methodsFor: 'testing' stamp: 'JPF 6/21/2021 12:40:10'!
isEmpty
	
	^ items isEmpty! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PurchasesDetail class' category: 'TusLibros'!
PurchasesDetail class
	instanceVariableNames: ''!

!PurchasesDetail class methodsFor: 'instance creation' stamp: 'JPF 6/23/2021 18:25:13'!
for: sales
	
	^self new initializeFor: sales! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'JPF 6/21/2021 11:23:15'!
initializeOf: itemsOfSale totalizing: aTotal

	total := aTotal.
	items := itemsOfSale.
	! !


!Sale methodsFor: 'accessing' stamp: 'JPF 6/21/2021 12:21:50'!
items
	
	^ items! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'JPF 6/20/2021 13:03:02'!
of: items totalizing: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeOf: items totalizing: aTotal! !


!classDefinition: #StoreFacade category: 'TusLibros'!
Object subclass: #StoreFacade
	instanceVariableNames: 'clientValidator cartRepository cartIdSequence catalog transactionIdSequence merchantProcessor salesBook transactionsByClient transactionIdGenerator clock lastCartAccessRegistry clientOfCarts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreFacade methodsFor: 'initialization' stamp: 'JPF 6/21/2021 22:15:27'!
initializeValidatingWith: aClientValidator having: aCatalog processingPaymentsWith: aMerchantProcessor accessingTimeThrough: aClock  

	clientValidator := aClientValidator.
	catalog := aCatalog.
	cartRepository := Dictionary new.
	cartIdSequence := 1.
	transactionIdSequence :=1.
	salesBook := OrderedDictionary new.
	transactionsByClient := Dictionary new.
	merchantProcessor := aMerchantProcessor.
	clock := aClock.
	lastCartAccessRegistry := Dictionary new.
	clientOfCarts := Dictionary new.! !

!StoreFacade methodsFor: 'initialization' stamp: 'JPF 6/23/2021 17:21:02'!
saleCorrespondingTo: transactionId

	^ salesBook at: transactionId! !


!StoreFacade methodsFor: 'private - id generation' stamp: 'JPF 6/19/2021 10:13:57'!
nextCartId
	
	| cartId |
	
	cartId := cartIdSequence.
	cartIdSequence := cartIdSequence + 1.
	
	^ cartId! !

!StoreFacade methodsFor: 'private - id generation' stamp: 'JPF 6/20/2021 11:54:44'!
nextTransactionId

	| transactionId |
	
	transactionId := transactionIdSequence.
	transactionIdSequence := transactionIdSequence + 1.
	
	^ transactionId! !


!StoreFacade methodsFor: 'private - cart' stamp: 'JPF 6/23/2021 17:28:20'!
createNewCart: cartId for: aClientId 

	cartRepository at: cartId put: (Cart acceptingItemsOf: catalog).
	clientOfCarts at: cartId put: aClientId.
	self updateLastAccessFor: cartId.! !

!StoreFacade methodsFor: 'private - cart' stamp: 'JPF 6/21/2021 14:05:15'!
findCart: aCartId

	| cart |
	
	cart := cartRepository at: aCartId ifAbsent: [ self error: self class inexistentCartErrorMessage ].
	self assertCartWasAccessedInTheLast30Minutes: aCartId.
	self updateLastAccessFor: aCartId.
	
	^ cart
	! !

!StoreFacade methodsFor: 'private - cart' stamp: 'JPF 6/21/2021 22:49:00'!
removeCart: aCartId
	
	cartRepository removeKey: aCartId.
	lastCartAccessRegistry removeKey: aCartId.! !

!StoreFacade methodsFor: 'private - cart' stamp: 'JPF 6/21/2021 14:05:15'!
updateLastAccessFor: aCartId

	^ lastCartAccessRegistry at: aCartId put: clock now! !


!StoreFacade methodsFor: 'private - client' stamp: 'JPF 6/21/2021 22:44:27'!
register: aTransactionId for: aClientId

	| transactionsOfClient |
	
	transactionsOfClient := transactionsByClient at: aClientId ifAbsent: [ OrderedCollection new ].
	transactionsOfClient add: aTransactionId.
	transactionsByClient at: aClientId put: transactionsOfClient.
! !

!StoreFacade methodsFor: 'private - client' stamp: 'JPF 6/23/2021 17:13:48'!
registerSaleForTheClientOf: aCartId with: aTransactionId

	| clientId |
	
	clientId := clientOfCarts removeKey: aCartId.
	
	self register: aTransactionId for: clientId.
	
	self removeCart: aCartId.
! !

!StoreFacade methodsFor: 'private - client' stamp: 'JPF 6/23/2021 18:20:03'!
salesOf: aClientId

	| transactionsOfClient |
	
	transactionsOfClient := self transactionsOf: aClientId.
	^ transactionsOfClient collect: [ :transactionId | self saleCorrespondingTo: transactionId ]! !

!StoreFacade methodsFor: 'private - client' stamp: 'JPF 6/23/2021 18:19:40'!
transactionsOf: aClientId

	^ transactionsByClient at: aClientId ifAbsent: [ OrderedCollection new ].
	! !


!StoreFacade methodsFor: 'actions' stamp: 'JPF 6/19/2021 10:06:39'!
add: aQuantity of: anItem to: aCartId 
	
	| cart |
	
	cart := self findCart: aCartId.
	
	cart add: aQuantity of: anItem.! !

!StoreFacade methodsFor: 'actions' stamp: 'JPF 6/21/2021 22:41:34'!
checkOutCart: aCartId payingWithCardNumber: aCreditCardNumber of: aName expiringOn: aMonth  

	| cart cashier transactionId |
	
	cart := self findCart: aCartId.
	
	cashier := Cashier 
		toCheckout: cart 
		charging: (CreditCard 
			withNumber: aCreditCardNumber
			of: aName
			expiringOn: aMonth)
		throught: merchantProcessor
		on: clock now
		registeringOn: salesBook
		generatingTransactionIdWith: self.
		
	transactionId := cashier checkOut.
	
	self registerSaleForTheClientOf: aCartId with: transactionId .
	
	^ transactionId.! !

!StoreFacade methodsFor: 'actions' stamp: 'JPF 6/23/2021 17:28:07'!
createCartFor: aClientId withPassword: aPassword

	| cartId |
	
	clientValidator validateClient: aClientId withPassword: aPassword.
	
	cartId := self nextCartId.
	
	self createNewCart: cartId for: aClientId.
	
	^ cartId! !


!StoreFacade methodsFor: 'queries' stamp: 'JPF 6/21/2021 10:04:02'!
listCart: aCartId
	
	^ (self findCart: aCartId) cartDetail.! !

!StoreFacade methodsFor: 'queries' stamp: 'JPF 6/23/2021 18:24:55'!
listPurchasesOf: aClientId withPassword: aPassword

	clientValidator validateClient: aClientId withPassword: aPassword.
	
	^ PurchasesDetail for: (self salesOf: aClientId)! !


!StoreFacade methodsFor: 'assertions' stamp: 'JPF 6/21/2021 22:49:18'!
assertCartWasAccessedInTheLast30Minutes: aCartId

	^ (clock now - (lastCartAccessRegistry at: aCartId)) >= (Duration minutes: 30) ifTrue: [
		self removeCart: aCartId.
		self error: self class inexistentCartErrorMessage
		]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StoreFacade class' category: 'TusLibros'!
StoreFacade class
	instanceVariableNames: ''!

!StoreFacade class methodsFor: 'instance creation' stamp: 'JPF 6/21/2021 13:46:04'!
validatingWith: aClientValidator having: aCatalog processingPaymentsWith: aMerchantProcessor accessingTimeThrough: aClock    
	
	^self new initializeValidatingWith: aClientValidator having: aCatalog processingPaymentsWith: aMerchantProcessor accessingTimeThrough: aClock ! !


!StoreFacade class methodsFor: 'error descriptions' stamp: 'JPF 6/19/2021 10:01:36'!
inexistentCartErrorMessage
	
	^ 'Inexistent cart'! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today validateClientBehaviour debitBehavior transactionIdSequence clockBehaviour'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'JPF 6/20/2021 12:23:57'!
itemSellByTheStore2
	
	^ 'validBook2'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'JPF 6/20/2021 12:24:09'!
itemSellByTheStore2Price
	
	^20! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'JPF 6/20/2021 12:24:34'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self itemSellByTheStore2 put: self itemSellByTheStore2Price;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'JPF 6/20/2021 11:27:35'!
expiredCreditCard
	
	^ CreditCard
		withNumber: self validCreditCardNumber 
		of: self validCreditCardName
		expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'JPF 6/20/2021 11:01:12'!
notExpiredCreditCard
	
	^CreditCard
		withNumber: self validCreditCardNumber
		of: self validCreditCardName
		expiringOn: self notExpiredCreditCardMonth! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'JPF 6/20/2021 10:36:28'!
notExpiredCreditCardMonth

	^ Month month: today monthIndex year: today yearNumber + 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'JPF 6/20/2021 11:01:52'!
validCreditCardName
	
	^ 'Valid Name'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'JPF 6/20/2021 11:24:53'!
validCreditCardNumber
	
	^ 1111888811118888! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'JPF 6/21/2021 13:42:49'!
initialize

	today := DateAndTime now.
	validateClientBehaviour := [ :clientIdArg :passwordArg | ].
	debitBehavior := [ :anAmount :aCreditCard | ].
	clockBehaviour := [ DateAndTime now ].
	transactionIdSequence := 1.! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'client' stamp: 'JPF 6/19/2021 09:13:36'!
clientId
	
	^ 'clientId'.! !

!StoreTestObjectsFactory methodsFor: 'client' stamp: 'JPF 6/19/2021 09:14:08'!
password
	
	^ 'password'.! !


!StoreTestObjectsFactory methodsFor: 'storeFacade' stamp: 'JPF 6/21/2021 13:45:08'!
createStoreFacade
	
	^ StoreFacade validatingWith: self having: self defaultCatalog processingPaymentsWith: self accessingTimeThrough: self.! !


!StoreTestObjectsFactory methodsFor: 'client validator protocol' stamp: 'JPF 6/20/2021 12:12:58'!
validateClient: aClientId withPassword: aPassword

	validateClientBehaviour value: aClientId value: aPassword! !

!StoreTestObjectsFactory methodsFor: 'client validator protocol' stamp: 'JPF 6/20/2021 12:13:08'!
validateUserBehaviour: aValidateClientBehaviour

	validateClientBehaviour := aValidateClientBehaviour ! !


!StoreTestObjectsFactory methodsFor: 'merchantProcessor' stamp: 'JPF 6/20/2021 13:21:05'!
createMerchantProcessor

	^ self! !


!StoreTestObjectsFactory methodsFor: 'merchant processor protocol' stamp: 'JPF 6/20/2021 13:16:36'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !

!StoreTestObjectsFactory methodsFor: 'merchant processor protocol' stamp: 'JPF 6/20/2021 13:18:01'!
debitBehavior: aDebitBehavior

	debitBehavior := aDebitBehavior! !


!StoreTestObjectsFactory methodsFor: 'transactionIdGenerator' stamp: 'JPF 6/21/2021 11:20:00'!
transactionIdGenerator

	^ self! !


!StoreTestObjectsFactory methodsFor: 'transaction id generator protocol' stamp: 'JPF 6/21/2021 11:18:49'!
nextTransactionId

	| transactionId |
	
	transactionId := transactionIdSequence.
	transactionIdSequence := transactionIdSequence + 1.
	
	^ transactionId

	! !


!StoreTestObjectsFactory methodsFor: 'clock protocol' stamp: 'JPF 6/21/2021 13:58:51'!
clockBehaviour: aClockBehaviour 
	
	clockBehaviour := aClockBehaviour! !

!StoreTestObjectsFactory methodsFor: 'clock protocol' stamp: 'JPF 6/21/2021 13:42:05'!
now

	^ clockBehaviour value
! !
