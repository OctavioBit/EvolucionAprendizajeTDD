!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'NNH 11/27/2020 21:03:53'!
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

!CartTest methodsFor: 'tests' stamp: 'NNH 11/27/2020 21:03:59'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'NNH 11/27/2020 21:04:03'!
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


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'tests' stamp: 'AM 11/30/2020 22:43:50'!
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

!CashierTest methodsFor: 'tests' stamp: 'AM 11/30/2020 22:43:51'!
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

!CashierTest methodsFor: 'tests' stamp: 'AM 11/30/2020 22:43:50'!
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

!CashierTest methodsFor: 'tests' stamp: 'AM 11/30/2020 22:43:50'!
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

!CashierTest methodsFor: 'tests' stamp: 'AM 11/30/2020 22:43:50'!
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

!CashierTest methodsFor: 'tests' stamp: 'AM 11/30/2020 22:43:50'!
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


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'setUp/tearDown' stamp: 'AM 11/30/2020 20:09:04'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.
	

	! !


!CreditCardTest methodsFor: 'tests - accessing' stamp: 'AM 11/30/2020 22:45:48'!
test07ValidCardPropertiesAreCorrect
	
	| creditCard |
	
	creditCard := CreditCard withNumber: testObjectsFactory validCardId
							expiringOn:  testObjectsFactory futureExpirationDate 
							owner: testObjectsFactory validOwner.
	
	self assert: testObjectsFactory validCardId equals: creditCard number .
	self assert: testObjectsFactory futureExpirationDate equals: creditCard expirationDate .
	self assert: testObjectsFactory validOwner equals: creditCard owner..

	! !


!CreditCardTest methodsFor: 'tests - validations' stamp: 'AM 11/30/2020 22:45:09'!
test01CardNumberShouldNotHaveLessThan16Digits

	| invalidCardId |
	
	invalidCardId := 10 ^ 15 - 1.
	
	self should: [ CreditCard withNumber: invalidCardId 
						expiringOn: testObjectsFactory futureExpirationDate
						owner: testObjectsFactory validOwner ]
	raise: Error - MessageNotUnderstood
	withMessageText: CreditCard invalidCardNumberErrorDescription .
	

	! !

!CreditCardTest methodsFor: 'tests - validations' stamp: 'AM 11/30/2020 22:45:20'!
test02CardNumberShouldNotHaveMoreThan16Digits

	| invalidCardId |
	
	invalidCardId := 10 ^ 16.
	
	self should: [ CreditCard withNumber: invalidCardId 
						expiringOn: testObjectsFactory futureExpirationDate
						owner: testObjectsFactory validOwner ]
	raise: Error
	withMessageText: CreditCard invalidCardNumberErrorDescription .
	

	! !

!CreditCardTest methodsFor: 'tests - validations' stamp: 'AM 11/30/2020 22:45:24'!
test03CardNumberShouldBeAnInteger

	| invalidCardId |
	
	invalidCardId := 0.5.
	
	self should: [ CreditCard withNumber: invalidCardId 
						expiringOn: testObjectsFactory futureExpirationDate
						owner: testObjectsFactory validOwner ]
	raise: Error
	withMessageText: CreditCard invalidCardNumberErrorDescription .
	

	! !

!CreditCardTest methodsFor: 'tests - validations' stamp: 'AM 11/30/2020 22:45:30'!
test04CardExpirationDateShouldBeAMonthOfAnYear

	| aDayInAMonthOfAnYear |
	
	aDayInAMonthOfAnYear := January/01/2021.
	
	self should: [ CreditCard withNumber: testObjectsFactory validCardId
						expiringOn: aDayInAMonthOfAnYear
						owner: testObjectsFactory validOwner ]
	raise: Error
	withMessageText: CreditCard invalidExpirationDateErrorDescription .
	! !

!CreditCardTest methodsFor: 'tests - validations' stamp: 'AM 11/30/2020 22:45:33'!
test05OwnerNameShouldNotBeEmpty
	
	self should: [ CreditCard withNumber: testObjectsFactory validCardId
						expiringOn: testObjectsFactory futureExpirationDate 
						owner: '' ]
	raise: Error
	withMessageText: CreditCard invalidOwnerNameErrorDescription .
	! !

!CreditCardTest methodsFor: 'tests - validations' stamp: 'AM 11/30/2020 22:45:42'!
test06OwnerNameShouldNotBeBlank
	
	self should: [ CreditCard withNumber: testObjectsFactory validCardId
						expiringOn: testObjectsFactory futureExpirationDate 
						owner: '            ' ]
	raise: Error
	withMessageText: CreditCard invalidOwnerNameErrorDescription .
	! !


!classDefinition: #InternalRestInterfaceTest category: 'TusLibros'!
TestCase subclass: #InternalRestInterfaceTest
	instanceVariableNames: 'testObjectsFactory interface clockSimulator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalRestInterfaceTest methodsFor: 'setUp - tearDown' stamp: 'AM 12/2/2020 20:33:09'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new .
	
	clockSimulator := testObjectsFactory clockSimulator.	
	
	interface := testObjectsFactory tusLibrosInterfaceWithClock: clockSimulator.
! !


!InternalRestInterfaceTest methodsFor: 'tests - cart management' stamp: 'AM 12/2/2020 20:53:45'!
createValidCart

	^ interface createCartFor: testObjectsFactory validClientId 
						using: testObjectsFactory validPassword! !

!InternalRestInterfaceTest methodsFor: 'tests - cart management' stamp: 'AM 12/2/2020 20:33:27'!
test03NewCartShouldBeEmpty
	
	| aCartId |
	
	aCartId := self createValidCart.

	self assert: ( interface listCart: aCartId ) isEmpty .
	
	
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests - cart management' stamp: 'AM 12/2/2020 20:40:33'!
test04AddingToCartSuccessfullyAddsToOneCart
	
	| aCartId |
	
	aCartId := self createValidCart.
	
	self addValidProductTo: aCartId .
	interface addToCart: aCartId 
			product: testObjectsFactory itemSellByTheStore 
			withOcurrences: 2.


	self assert: (interface listCart: aCartId ) equals: { testObjectsFactory itemSellByTheStore. 
												 testObjectsFactory itemSellByTheStore. 
												 testObjectsFactory itemSellByTheStore} asBag.
	
	
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests - cart management' stamp: 'AM 12/2/2020 20:50:42'!
test05AddingToCartSuccessfullyAddsToManyCarts
	
	| fortCartId maradonaCartId |
	
	maradonaCartId := self createValidCart.
	fortCartId := interface createCartFor: testObjectsFactory anotherValidClientId 
						using: testObjectsFactory anotherValidPassword .
	
	self addValidProductTo: maradonaCartId. .

	self assert: ( interface listCart: maradonaCartId ) equals: { testObjectsFactory itemSellByTheStore } asBag.
	self assert: ( ( interface listCart: fortCartId ) isEmpty ).

	
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests - cart management' stamp: 'AM 12/2/2020 20:33:09'!
test06ListingCartShouldNotListOnInvalidCartId
	
	self should: [ interface listCart: testObjectsFactory invalidCartId ]
		raise: Error - MessageNotUnderstood 
		withMessageText: InternalRestInterface invalidCartIdErrorDescription .

	
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests - cart management' stamp: 'AM 12/2/2020 20:41:10'!
test07ShouldNotAddToInvalidCartId
	
	self should: [ 	self addValidProductTo: testObjectsFactory invalidCartId ]
		raise: Error - MessageNotUnderstood 
		withMessageText: InternalRestInterface invalidCartIdErrorDescription .

	
	
	! !


!InternalRestInterfaceTest methodsFor: 'tests - checkout' stamp: 'AM 12/2/2020 20:33:10'!
invalidCheckout: aCartId 

	^ interface checkOut:  aCartId
			withCCN:  testObjectsFactory validCardId 
			CCED:  testObjectsFactory pastExpirationDate 
			CCO:  testObjectsFactory validOwner 
			on: testObjectsFactory today! !

!InternalRestInterfaceTest methodsFor: 'tests - checkout' stamp: 'AM 12/2/2020 20:39:49'!
test08CheckOutSuccessfullyChecksOutOneCart
	
	| aCartId |
	
	aCartId :=self createValidCart.
	self addValidProductTo: aCartId .
	self validCheckout: aCartId .
	
	self assert: testObjectsFactory merchantProccessorHasBeenUsed
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests - checkout' stamp: 'AM 12/2/2020 20:39:59'!
test09ShouldNotCheckOutAnAlreadyCheckedOutCart
	
	| aCartId |
	
	aCartId := self createValidCart.
	self addValidProductTo: aCartId .
	self validCheckout: aCartId .
	
	self should: [ self validCheckout: aCartId ]
		raise: Error
		withMessageText: InternalRestInterface invalidCartIdErrorDescription . 
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests - checkout' stamp: 'AM 12/2/2020 20:40:07'!
test10FailedCheckOutShouldNotInvalidateFutureCheckOut
	
	| aCartId |
	
	aCartId := self createValidCart.
	self addValidProductTo: aCartId .
	
	self should: [ self invalidCheckout: aCartId ]
		raise: Error
		withExceptionDo: [ :anError |
				self validCheckout: aCartId .
				self assert: testObjectsFactory merchantProccessorHasBeenUsed 
			].
	! !

!InternalRestInterfaceTest methodsFor: 'tests - checkout' stamp: 'AM 12/2/2020 20:40:16'!
test21DifferentCheckoutsShouldCreateDifferentTransactionIds
	
	| aCartId transactionsIds |
					
	transactionsIds := OrderedCollection new.
	
	3 timesRepeat: [
		aCartId  := self createValidCart.
		self addValidProductTo: aCartId .
		transactionsIds add: ( self validCheckout: aCartId ).
		].
	
	self assert: transactionsIds asSet size equals: 3.
	! !

!InternalRestInterfaceTest methodsFor: 'tests - checkout' stamp: 'AM 12/2/2020 20:33:11'!
validCheckout: aCartId 

	^ interface checkOut:  aCartId
			withCCN:  testObjectsFactory validCardId 
			CCED:  testObjectsFactory futureExpirationDate 
			CCO:  testObjectsFactory validOwner 
			on: testObjectsFactory today! !


!InternalRestInterfaceTest methodsFor: 'tests - cart timed out' stamp: 'AM 12/2/2020 20:37:45'!
test17ShouldNotAddWhenCartTimedOut
	
	| aCartId |
					
	aCartId := self createValidCart.
	
	clockSimulator addToTime: 30*minute.
	
	self should: [ 	self addValidProductTo: aCartId ]
		raise: Error
		withExceptionDo: [ :anError | 
			self should: [ interface listCart: aCartId] 
				raise: Error 
				withMessageText: InternalRestInterface invalidCartIdErrorDescription
			]
		description: InternalRestInterface cartHasTimedOutErrorDescription.
		
	! !

!InternalRestInterfaceTest methodsFor: 'tests - cart timed out' stamp: 'AM 12/2/2020 20:35:03'!
test18ShouldNotListATimedOutCart
	
	| aCartId |
					
	aCartId := self createValidCart.
	
	clockSimulator addToTime: 30*minute.
	
	self should: [ interface listCart: aCartId  ]
		raise: Error
		withExceptionDo: [ :anError | 
			self should: [ interface listCart: aCartId] raise: Error withMessageText: InternalRestInterface invalidCartIdErrorDescription]
		description: InternalRestInterface cartHasTimedOutErrorDescription.
		
	! !

!InternalRestInterfaceTest methodsFor: 'tests - cart timed out' stamp: 'AM 12/2/2020 20:37:59'!
test19ShouldNotCheckOutATimedOutCart
	
	| aCartId |
					
	aCartId := self createValidCart.
	self addValidProductTo: aCartId .

	
	clockSimulator addToTime: 30*minute.
	
	self should: [ self validCheckout: aCartId ]
		raise: Error
		withExceptionDo: [ :anError | 
			self should: [ interface listCart: aCartId] 
				raise: Error 
				withMessageText: InternalRestInterface invalidCartIdErrorDescription
			]
		description: InternalRestInterface cartHasTimedOutErrorDescription.
		
	! !

!InternalRestInterfaceTest methodsFor: 'tests - cart timed out' stamp: 'AM 12/2/2020 20:41:48'!
test20TimeOutTimeIsResetAfterAnyOperation
	
	| aCartId |
					
	aCartId := self createValidCart.	
	
	self shouldnt: [ clockSimulator addToTime: 29*minute.
				interface listCart: aCartId .
				clockSimulator addToTime: 29*minute.
				self addValidProductTo: aCartId .
				clockSimulator addToTime: 29*minute.
				[ self invalidCheckout: aCartId ] 
					on: Error 
					do: [:anError | ].
				clockSimulator addToTime: 29*minute.
				interface listCart: aCartId ]
		raise: Error
		description: InternalRestInterface cartHasTimedOutErrorDescription.
		
	! !


!InternalRestInterfaceTest methodsFor: 'tests - credentials' stamp: 'AM 12/2/2020 20:53:07'!
test01UnknownUserShouldNotCreateCart

	self should: [ interface createCartFor: testObjectsFactory invalidClientId using: testObjectsFactory invalidPassword ]
		raise: Error - MessageNotUnderstood
		withMessageText: AuthenticationSystemSimulator invalidUserErrorDescription.
	
	
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests - credentials' stamp: 'AM 12/2/2020 20:53:45'!
test02WrongPasswordShouldNotCreateCart
	
	self should: [ interface createCartFor: testObjectsFactory validClientId using: testObjectsFactory invalidPassword ]
		raise: Error
		withMessageText: AuthenticationSystemSimulator invalidPasswordErrorDescription.
	
	
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests - credentials' stamp: 'AM 12/2/2020 20:53:07'!
test15InvalidUserShouldNotListPurchases

	self should: [ interface listPurchasesOf: testObjectsFactory invalidClientId password: testObjectsFactory validPassword ]
		raise: Error
		withMessageText: AuthenticationSystemSimulator invalidUserErrorDescription .
		
	! !

!InternalRestInterfaceTest methodsFor: 'tests - credentials' stamp: 'AM 12/2/2020 20:53:45'!
test16InvalidPasswordShouldNotListPurchases
	
	self should: [ interface listPurchasesOf: testObjectsFactory validClientId password: testObjectsFactory invalidPassword ]
		raise: Error
		withMessageText: AuthenticationSystemSimulator invalidPasswordErrorDescription .
		
	! !


!InternalRestInterfaceTest methodsFor: 'tests - list purchases' stamp: 'AM 12/2/2020 20:36:37'!
addValidProductTo: aCartId

	^ interface addToCart: aCartId 
			product: testObjectsFactory itemSellByTheStore! !

!InternalRestInterfaceTest methodsFor: 'tests - list purchases' stamp: 'AM 12/2/2020 20:53:45'!
listPurchasesOfValidClient

	^ interface listPurchasesOf: testObjectsFactory validClientId password: testObjectsFactory validPassword! !

!InternalRestInterfaceTest methodsFor: 'tests - list purchases' stamp: 'AM 12/2/2020 20:44:14'!
test11ListZeroPurchasesSuccesfully
	
	| purchases |
	
	purchases := self listPurchasesOfValidClient.
	
	self assert: purchases total equals: 0.
	self assert: purchases products isEmpty.
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests - list purchases' stamp: 'AM 12/2/2020 20:44:31'!
test12ListOnePurchaseSuccessfully
	
	| aCartId purchases |
	
	aCartId := self createValidCart.
	self addValidProductTo: aCartId .
	self validCheckout: aCartId .
			
	purchases := self listPurchasesOfValidClient.
	
	self assert: purchases total equals: testObjectsFactory itemSellByTheStorePrice .
	self assert: purchases products equals: {testObjectsFactory itemSellByTheStore } asBag.
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests - list purchases' stamp: 'AM 12/2/2020 20:43:58'!
test13ListMoreThanOnePurchaseSuccessfully
	
	| aCartId purchases |
	
	2 timesRepeat: [ 
		aCartId := self createValidCart.
		self addValidProductTo: aCartId .
		self validCheckout: aCartId ].
	
	purchases := self listPurchasesOfValidClient .
	
	self assert: testObjectsFactory itemSellByTheStorePrice * 2 equals: purchases total.
	self assert: purchases products equals: { testObjectsFactory itemSellByTheStore. testObjectsFactory itemSellByTheStore } asBag.
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests - list purchases' stamp: 'AM 12/2/2020 20:50:42'!
test14ListPurchasesFromMoreThanOneClient
	
	| aCartId purchases |
	
	aCartId := self createValidCart.
	
	self addValidProductTo: aCartId .
	self addValidProductTo: aCartId .
	self validCheckout: aCartId .
	
	aCartId := interface createCartFor: testObjectsFactory anotherValidClientId 
					using: testObjectsFactory anotherValidPassword .
	self addValidProductTo: aCartId .
	self validCheckout: aCartId .
	
	purchases := self listPurchasesOfValidClient.
	
	self assert: testObjectsFactory itemSellByTheStorePrice * 2 equals: purchases total.
	self assert: purchases products equals: {testObjectsFactory itemSellByTheStore. testObjectsFactory itemSellByTheStore } asBag.
	
	purchases := interface listPurchasesOf: testObjectsFactory anotherValidClientId password: testObjectsFactory anotherValidPassword.
	
	self assert: purchases total equals: testObjectsFactory itemSellByTheStorePrice.
	self assert: purchases products equals: { testObjectsFactory itemSellByTheStore } asBag.
	
	
	
	! !


!classDefinition: #AuthenticationSystemSimulator category: 'TusLibros'!
Object subclass: #AuthenticationSystemSimulator
	instanceVariableNames: 'credentials'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!AuthenticationSystemSimulator methodsFor: 'authentication' stamp: 'NNH 11/29/2020 22:38:11'!
authenticate: aUser using: aPassword
	
	( credentials includesKey: aUser ) ifFalse: [ self error: self class invalidUserErrorDescription ] .
	
	( credentials at: aUser ) = aPassword ifFalse: [ self error: self class invalidPasswordErrorDescription ] .! !


!AuthenticationSystemSimulator methodsFor: 'initialization' stamp: 'NNH 11/29/2020 22:34:56'!
initializeWithCredentials: aCollectionOfCredentials
	
	credentials := aCollectionOfCredentials .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AuthenticationSystemSimulator class' category: 'TusLibros'!
AuthenticationSystemSimulator class
	instanceVariableNames: ''!

!AuthenticationSystemSimulator class methodsFor: 'error descriptions' stamp: 'NNH 11/29/2020 22:39:49'!
invalidPasswordErrorDescription
	
	^ 'Invalid Password'! !

!AuthenticationSystemSimulator class methodsFor: 'error descriptions' stamp: 'NNH 11/29/2020 22:39:58'!
invalidUserErrorDescription
	
	^ 'Invalid User'! !


!AuthenticationSystemSimulator class methodsFor: 'instance creation' stamp: 'NNH 11/29/2020 22:39:01'!
withCredentials: aCollectionOfCredentials

	^ self new initializeWithCredentials: aCollectionOfCredentials .! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'assertions' stamp: 'NNH 11/27/2020 21:03:35'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self class invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'NNH 11/27/2020 21:03:40'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self class invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
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

!Cart methodsFor: 'testing' stamp: 'NNH 11/26/2020 21:19:32'!
listCart
	
	^items copy ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!Cart class methodsFor: 'error messages' stamp: 'NNH 11/27/2020 21:02:56'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'NNH 11/27/2020 21:03:06'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'NNH 11/29/2020 23:43:57'!
createSale

	^ Sale of: total products: cart listCart .! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'initialization' stamp: 'AM 11/30/2020 22:43:39'!
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


!Cashier class methodsFor: 'instance creation' stamp: 'AM 11/30/2020 22:43:50'!
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


!classDefinition: #ClockSimulator category: 'TusLibros'!
Object subclass: #ClockSimulator
	instanceVariableNames: 'block time'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ClockSimulator methodsFor: 'initialization' stamp: 'AM 11/30/2020 18:44:34'!
initializeWithTime: aGregorianDateTime 
	
	time := aGregorianDateTime.! !


!ClockSimulator methodsFor: 'time operations' stamp: 'AM 11/30/2020 18:52:14'!
addToTime: aMeasureOfTime

	time := time next: aMeasureOfTime.
	
	! !

!ClockSimulator methodsFor: 'time operations' stamp: 'AM 11/30/2020 19:57:09'!
now

	^ time 
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ClockSimulator class' category: 'TusLibros'!
ClockSimulator class
	instanceVariableNames: ''!

!ClockSimulator class methodsFor: 'instance creation' stamp: 'AM 11/30/2020 18:43:57'!
withTime: aGregorianDateTime 
	
	^self new initializeWithTime: aGregorianDateTime ! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number expirationDate owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'accessing' stamp: 'AM 11/30/2020 20:36:26'!
expirationDate
	
	^ expirationDate! !

!CreditCard methodsFor: 'accessing' stamp: 'AM 11/30/2020 20:36:11'!
number
	
	^ number! !

!CreditCard methodsFor: 'accessing' stamp: 'AM 11/30/2020 20:36:40'!
owner
	
	^ owner! !


!CreditCard methodsFor: 'initialization' stamp: 'AM 11/30/2020 22:46:49'!
initializeWithNumber: aNumber expiringOn: aMonthOfYear owner: aPerson 
	
	number := aNumber.
	expirationDate := aMonthOfYear.
	owner := aPerson.! !


!CreditCard methodsFor: 'testing' stamp: 'AM 11/30/2020 20:58:52'!
isExpiredOn: aDate 
	
	^ expirationDate <  
		(GregorianMonthOfYear yearNumber: aDate yearNumber monthNumber: aDate monthIndex).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'assertions' stamp: 'AM 12/3/2020 14:37:42'!
assertThatCreditCardNumberIsValid: aNumber
	
	((aNumber between: 10^15 and: 10^16-1) and: [aNumber isInteger] )ifFalse: [ self error: self invalidCardNumberErrorDescription ].! !

!CreditCard class methodsFor: 'assertions' stamp: 'AM 12/3/2020 14:38:34'!
assertThatExpirationDateIsValid: aDate

	( aDate isKindOf: GregorianMonthOfYear ) ifFalse: [ self error: self invalidExpirationDateErrorDescription ] .! !

!CreditCard class methodsFor: 'assertions' stamp: 'AM 12/3/2020 14:39:10'!
assertThatNameIsValid: aName

	^ aName withoutTrailingBlanks isEmpty ifTrue: [ self error: self invalidOwnerNameErrorDescription ]! !


!CreditCard class methodsFor: 'instance creation' stamp: 'AM 12/3/2020 14:39:14'!
withNumber: aNumber expiringOn: aMonthOfYear owner: aName  
	
	self assertThatCreditCardNumberIsValid: aNumber.
	self assertThatExpirationDateIsValid: aMonthOfYear.
	self assertThatNameIsValid: aName .
	
	^ self new initializeWithNumber: aNumber expiringOn: aMonthOfYear owner: aName ! !


!CreditCard class methodsFor: 'error descriptions' stamp: 'AM 11/30/2020 20:13:51'!
invalidCardNumberErrorDescription
	
	^ 'Credit card number must have exactly 16 digits' .! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'AM 11/30/2020 20:21:25'!
invalidExpirationDateErrorDescription
	
	^ 'Expiration date must be a moth of year' .! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'AM 11/30/2020 20:26:30'!
invalidOwnerNameErrorDescription

	^ 'Credit card should not have an invalid owner name'! !


!classDefinition: #InterfaceCartData category: 'TusLibros'!
Object subclass: #InterfaceCartData
	instanceVariableNames: 'clientId cart lastTimeUsed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InterfaceCartData methodsFor: 'accessing' stamp: 'AM 11/30/2020 22:50:21'!
cart
	
	^ cart! !

!InterfaceCartData methodsFor: 'accessing' stamp: 'AM 12/2/2020 19:54:53'!
clientId
	
	^ clientId! !

!InterfaceCartData methodsFor: 'accessing' stamp: 'AM 11/30/2020 21:17:16'!
lastTimeUsed
	
	^ lastTimeUsed! !


!InterfaceCartData methodsFor: 'initialization' stamp: 'AM 12/2/2020 19:55:12'!
initializeCart: aCart clientId: aClientId lastTimeUsed: aTime 
	
	cart := aCart.
	clientId := aClientId.
	lastTimeUsed := aTime.! !


!InterfaceCartData methodsFor: 'updating' stamp: 'AM 11/30/2020 21:17:59'!
updateLastUseTo: aTime 
	
	lastTimeUsed := aTime ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InterfaceCartData class' category: 'TusLibros'!
InterfaceCartData class
	instanceVariableNames: ''!

!InterfaceCartData class methodsFor: 'instance creation' stamp: 'AM 12/2/2020 19:55:21'!
cart: aCart clientId: aClientId lastTimeUsed: aTime 
	
	^self new initializeCart: aCart clientId: aClientId lastTimeUsed: aTime ! !


!classDefinition: #InternalRestInterface category: 'TusLibros'!
Object subclass: #InternalRestInterface
	instanceVariableNames: 'authenticationSystem catalog carts merchantProcessor salesBooks clock nextCartId nextTransactionId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalRestInterface methodsFor: 'accessing - private' stamp: 'AM 12/2/2020 18:59:18'!
cartIdentifiedAs: aCartId

	^ (carts at: aCartId) cart. ! !

!InternalRestInterface methodsFor: 'accessing - private' stamp: 'AM 12/2/2020 19:54:44'!
clientUsing: aCartId

	^ (carts at: aCartId) clientId! !

!InternalRestInterface methodsFor: 'accessing - private' stamp: 'AM 12/2/2020 19:56:06'!
salesBookOf: aClientId 

	^ salesBooks at: aClientId ifAbsent: [ SalesBook new ]! !

!InternalRestInterface methodsFor: 'accessing - private' stamp: 'AM 12/2/2020 19:00:23'!
salesBookOfClientUsing: aCartId 
	
	^ self salesBookOf: (self clientUsing: aCartId)! !


!InternalRestInterface methodsFor: 'assertions' stamp: 'AM 12/2/2020 19:39:39'!
assertThatCartHasNotTimedOut: aCartId

	(self hasTimedOut: aCartId) ifTrue: [ 
		self removeCartIdentifiedAs: aCartId.
		self error: self class cartHasTimedOutErrorDescription ].! !

!InternalRestInterface methodsFor: 'assertions' stamp: 'AM 11/30/2020 19:08:29'!
assertThatCartIdIsValid: aCartId

	(carts includesKey: aCartId) ifFalse: [ self error: self class invalidCartIdErrorDescription ]! !


!InternalRestInterface methodsFor: 'cart management' stamp: 'NNH 11/29/2020 23:33:16'!
addToCart: aCartId product: aProduct
	
	self addToCart: aCartId product: aProduct withOcurrences: 1. ! !

!InternalRestInterface methodsFor: 'cart management' stamp: 'AM 12/2/2020 18:59:18'!
addToCart: aCartId product: aProduct withOcurrences: aNumberOfOccurrences 
	
	self assertThatCartIdIsValid: aCartId.
	self assertThatCartHasNotTimedOut: aCartId.
	
	self updateLastUseOf: aCartId.

	(self cartIdentifiedAs: aCartId)  add: aNumberOfOccurrences of: aProduct! !

!InternalRestInterface methodsFor: 'cart management' stamp: 'AM 12/2/2020 18:56:46'!
checkOut: aCartId withCCN: aCreditCardNumber CCED: anExpirationDate CCO: anOwner on: aDate 
	
	| aCreditCard |
	
	aCreditCard := CreditCard withNumber: aCreditCardNumber
							expiringOn:  anExpirationDate
							owner: anOwner.

	^ self checkOut: aCartId 
		with: aCreditCard 
		on: aDate.
! !

!InternalRestInterface methodsFor: 'cart management' stamp: 'AM 12/2/2020 19:53:19'!
createCartFor: aClientId using: aPassword 
	
	| newCartId |
	
	authenticationSystem authenticate: aClientId using: aPassword .
	
	newCartId := self nextCartId.
	
	carts at: newCartId put: (InterfaceCartData cart: (Cart acceptingItemsOf: catalog)
											clientId: aClientId
											lastTimeUsed: clock now).
	
	salesBooks at: aClientId ifAbsentPut: SalesBook new.
	
	^ newCartId. ! !

!InternalRestInterface methodsFor: 'cart management' stamp: 'AM 12/2/2020 18:59:18'!
listCart: aCartId 
	
	self assertThatCartIdIsValid: aCartId.
	self assertThatCartHasNotTimedOut: aCartId.
	
	self updateLastUseOf: aCartId.
	
	^ (self cartIdentifiedAs: aCartId) listCart asBag.! !


!InternalRestInterface methodsFor: 'cart management - private' stamp: 'AM 12/2/2020 19:15:56'!
cashierCheckOut: aCartId with: aCreditCard on: aDate

	^ (Cashier toCheckout: (self cartIdentifiedAs: aCartId) 
			charging:  aCreditCard 
			through:  merchantProcessor 
			on:  aDate
			registeringOn: (self salesBookOfClientUsing: aCartId)) checkOut! !

!InternalRestInterface methodsFor: 'cart management - private' stamp: 'AM 12/2/2020 20:05:06'!
checkOut: aCartId with: aCreditCard on: aDate

	self assertThatCartIdIsValid: aCartId.
	self assertThatCartHasNotTimedOut: aCartId.
	
	self updateLastUseOf: aCartId.
	
	self cashierCheckOut: aCartId with: aCreditCard on: aDate.
			
	self removeCartIdentifiedAs: aCartId .
	
	^ self nextTransactionId.! !

!InternalRestInterface methodsFor: 'cart management - private' stamp: 'AM 12/3/2020 14:30:32'!
nextCartId
	
	^ nextCartId := nextCartId + 1
	! !

!InternalRestInterface methodsFor: 'cart management - private' stamp: 'AM 12/3/2020 14:30:50'!
nextTransactionId
	
	^ nextTransactionId := nextTransactionId + 1! !

!InternalRestInterface methodsFor: 'cart management - private' stamp: 'AM 12/2/2020 19:11:19'!
removeCartIdentifiedAs: aCartId

	^ carts removeKey: aCartId! !


!InternalRestInterface methodsFor: 'client purchases' stamp: 'AM 12/2/2020 19:00:23'!
listPurchasesOf: aClientId password: aPassword 
	
	authenticationSystem authenticate: aClientId using: aPassword .
	
	^ self salesBookOf: aClientId ! !


!InternalRestInterface methodsFor: 'initialization' stamp: 'AM 12/3/2020 14:31:10'!
initializeWith: anAuthenticationSystem catalog: aCatalog through: aMerchantProcessor clock: aClock 
	
	authenticationSystem := anAuthenticationSystem.
	catalog := aCatalog.
	merchantProcessor := aMerchantProcessor.
	clock := aClock.
	
	nextTransactionId := 0.
	nextCartId := 0.
	
	carts := Dictionary new.
	
	salesBooks := Dictionary new.! !


!InternalRestInterface methodsFor: 'time out - private' stamp: 'AM 12/2/2020 20:02:42'!
hasTimedOut: aCartId
	
	^ self timeOutLimit <= (self timeSinceLastUseOf: aCartId).! !

!InternalRestInterface methodsFor: 'time out - private' stamp: 'AM 12/2/2020 20:03:02'!
lastTimeOf: aCartId

	^ (carts at: aCartId) lastTimeUsed.! !

!InternalRestInterface methodsFor: 'time out - private' stamp: 'AM 12/2/2020 20:01:26'!
timeOutLimit

	^ 30 * minute! !

!InternalRestInterface methodsFor: 'time out - private' stamp: 'AM 12/2/2020 20:03:02'!
timeSinceLastUseOf: aCartId

	^ (self lastTimeOf: aCartId) distanceTo: clock now! !

!InternalRestInterface methodsFor: 'time out - private' stamp: 'AM 11/30/2020 21:13:29'!
updateLastUseOf: aCartId

	(carts at: aCartId) updateLastUseTo: clock now.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InternalRestInterface class' category: 'TusLibros'!
InternalRestInterface class
	instanceVariableNames: ''!

!InternalRestInterface class methodsFor: 'error descriptions' stamp: 'AM 11/30/2020 18:32:23'!
cartHasTimedOutErrorDescription
	
	^ 'The cart has timed out'.! !

!InternalRestInterface class methodsFor: 'error descriptions' stamp: 'NNH 11/27/2020 20:50:51'!
invalidCartIdErrorDescription
	
	^ 'Invalid cart id'! !


!InternalRestInterface class methodsFor: 'instance creation' stamp: 'AM 12/2/2020 19:39:19'!
with: anAuthenticationSystem catalog: aCatalog through: aMerchantProcessor clock: aClock 

	^self new initializeWith: anAuthenticationSystem catalog: aCatalog through: aMerchantProcessor clock: aClock ! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total products'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'accessing' stamp: 'AM 11/30/2020 23:06:26'!
products
	
	^ products asBag! !

!Sale methodsFor: 'accessing' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'NNH 11/29/2020 23:47:34'!
initializeTotal: aTotal products: aCollectionOfProducts   

	total := aTotal .
	products := aCollectionOfProducts .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'NNH 11/28/2020 00:18:32'!
of: aTotal products: aCollectionOfProducts   

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal products: aCollectionOfProducts ! !


!classDefinition: #SalesBook category: 'TusLibros'!
Object subclass: #SalesBook
	instanceVariableNames: 'sales'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SalesBook methodsFor: 'initialization' stamp: 'AM 12/2/2020 19:42:31'!
initialize

	sales := OrderedCollection new.! !


!SalesBook methodsFor: 'accesing' stamp: 'AM 12/2/2020 19:48:29'!
products
	
	| products |
	
	products := Bag new.
	
	sales do: [ :aSale | products addAll: aSale products ].
	
	^ products.! !

!SalesBook methodsFor: 'accesing' stamp: 'AM 12/2/2020 18:27:54'!
total

	^ sales sum: [ :aSale | aSale total ] 
		ifEmpty: [ 0 ]! !


!SalesBook methodsFor: 'adding' stamp: 'AM 11/30/2020 23:52:14'!
add: aSale

	sales add: aSale! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today debitFromWasReceived'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'authentication system' stamp: 'AM 12/2/2020 20:50:42'!
anotherValidClientId
	
	^ 'RickyFort'! !

!StoreTestObjectsFactory methodsFor: 'authentication system' stamp: 'NNH 11/29/2020 22:51:55'!
anotherValidPassword
	
	^ 'Maiameee'! !

!StoreTestObjectsFactory methodsFor: 'authentication system' stamp: 'AM 12/2/2020 20:53:45'!
defaultAuthenticationSystem
	
	| credentials |
	
	credentials := Dictionary new.
	credentials at: self validClientId put: self validPassword.
	credentials at: self anotherValidClientId put: self anotherValidPassword.
	
	^ AuthenticationSystemSimulator withCredentials: credentials.! !

!StoreTestObjectsFactory methodsFor: 'authentication system' stamp: 'AM 12/2/2020 20:53:06'!
invalidClientId
	
	^ 'CristianU' ! !

!StoreTestObjectsFactory methodsFor: 'authentication system' stamp: 'NNH 11/29/2020 22:52:59'!
invalidPassword
	
	^ 'GranHermano'! !

!StoreTestObjectsFactory methodsFor: 'authentication system' stamp: 'AM 12/2/2020 20:53:45'!
validClientId
	
	^ 'Maradona' ! !

!StoreTestObjectsFactory methodsFor: 'authentication system' stamp: 'NNH 11/29/2020 22:51:08'!
validPassword
	
	^ 'SegurolaYHabana'! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !


!StoreTestObjectsFactory methodsFor: 'clock' stamp: 'AM 11/30/2020 18:57:04'!
clockSimulator

	^ ClockSimulator withTime:
		 ( GregorianDateTime date: November/25/2020 timeOfDay: 12:00:00 ).! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AM 11/30/2020 22:46:02'!
expiredCreditCard
	
	^CreditCard withNumber: self validCardId 
			expiringOn:  self pastExpirationDate
			owner: self validOwner.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AM 11/30/2020 20:32:03'!
futureExpirationDate
	
	^ GregorianMonthOfYear year: FixedGregorianDate today year next
							 month: FixedGregorianDate today month! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AM 11/30/2020 20:44:06'!
notExpiredCreditCard
	
	^CreditCard withNumber: self validCardId 
				expiringOn: self futureExpirationDate 
				owner: self validOwner! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AM 11/30/2020 20:38:38'!
pastExpirationDate
	
	^ GregorianMonthOfYear year: FixedGregorianDate today year previous
							 month: FixedGregorianDate today month! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AM 11/30/2020 20:21:54'!
validCardId
	
	^ 10^15 * 4! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AM 11/30/2020 19:45:36'!
validOwner
	
	^ 'Maradona'! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'AM 12/2/2020 19:23:13'!
initialize

	today := DateAndTime now.
	debitFromWasReceived := false! !


!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'merchant processor' stamp: 'AM 12/2/2020 19:23:40'!
debit: anAmount from: aCreditCard

	debitFromWasReceived  := true
! !

!StoreTestObjectsFactory methodsFor: 'merchant processor' stamp: 'AM 12/2/2020 19:22:14'!
merchantProccessorHasBeenUsed
	
	^ debitFromWasReceived! !


!StoreTestObjectsFactory methodsFor: 'tus libros interface' stamp: 'AM 11/30/2020 19:31:05'!
invalidCartId

	^ Object new.! !

!StoreTestObjectsFactory methodsFor: 'tus libros interface' stamp: 'AM 12/2/2020 20:52:20'!
tusLibrosInterfaceWithClock: aClockSimulator
	
	^ InternalRestInterface with: self defaultAuthenticationSystem 
					catalog: self defaultCatalog 
					through: self
					clock: aClockSimulator
! !
