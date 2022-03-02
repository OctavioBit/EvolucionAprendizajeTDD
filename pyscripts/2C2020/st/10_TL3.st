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
	instanceVariableNames: 'testObjectsFactory debitBehavior merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'db 12/2/2020 19:51:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: merchantProcessor 
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'db 12/2/2020 19:51:53'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: merchantProcessor
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'db 12/2/2020 19:51:56'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: merchantProcessor
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'db 12/2/2020 19:51:59'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: merchantProcessor
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'db 12/2/2020 20:05:33'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook specialMerchantProcessor total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
	
	specialMerchantProcessor := MerchantProcessorSimulator withDebitBehavior: [:anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard
	].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: specialMerchantProcessor
		on: testObjectsFactory today
		registeringOn: salesBook.
	
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'db 12/2/2020 20:06:12'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard specialMerchantProcessor |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
	
	specialMerchantProcessor := MerchantProcessorSimulator withDebitBehavior: [ 
		:anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage
	].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: specialMerchantProcessor
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'db 12/2/2020 19:51:22'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ].
	merchantProcessor := MerchantProcessorSimulator new.! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'testObjectFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'testing' stamp: 'db 12/2/2020 19:50:01'!
test01CreditCardNumberShouldHave16digits

	| creditCard |
	self  should: [CreditCard with: '1234' expiration: testObjectFactory notExpiredDate creditCardOwner: 'owner' ] 
		 raise: Error 
		 withMessageText: CreditCard creditCardNumberInvalidLengthNumberErrorDescription.
	 
	creditCard := CreditCard with: '4545123455647789' expiration: testObjectFactory notExpiredDate creditCardOwner: 'owner'.
	self assert: '4545123455647789' equals: (creditCard creditCardNumber ).
	self assert: 16 equals: (creditCard creditCardNumber size).
	! !

!CreditCardTest methodsFor: 'testing' stamp: 'db 12/2/2020 17:24:16'!
test02CreditCardOwnerCannotBeEmpty


	self  should: [CreditCard with: '4545124512456598' expiration: testObjectFactory notExpiredDate creditCardOwner: ''] 
		 raise: Error 
		 withMessageText: CreditCard creditCardOwnerCannotBeEmptyErrorDescription.
		! !

!CreditCardTest methodsFor: 'testing' stamp: 'db 12/2/2020 19:50:19'!
test03CreditCardOwnerNameCantBeLongerThan30Letters


	self  should: [CreditCard with: '4545124512456598' expiration: testObjectFactory notExpiredDate creditCardOwner: 'dfafasdfadfadsfasdfassdfadsfafas dasdfad'] 
		 raise: Error 
		 withMessageText: CreditCard creditCardOwnerNameCantBeLongerThanThirtyErrorDescription.
		! !


!CreditCardTest methodsFor: 'setUp/tearDown' stamp: 'db 12/2/2020 17:18:16'!
setUp

	testObjectFactory := StoreTestObjectsFactory new.! !


!classDefinition: #InternalApiTest category: 'TusLibros'!
TestCase subclass: #InternalApiTest
	instanceVariableNames: 'testObjectFactory authenticatedClients merchantProcessor defaultClock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalApiTest methodsFor: 'doubles methods' stamp: 'db 11/30/2020 23:30:24'!
authenticate: aClientID withPassword: aPassword

	| password |
	[password := authenticatedClients at: aClientID] on: Error do: [:anError | ^false].
	^password = aPassword .! !


!InternalApiTest methodsFor: 'setUp' stamp: 'db 12/1/2020 17:57:41'!
setUp

	testObjectFactory := StoreTestObjectsFactory new.
	
	authenticatedClients := Dictionary new.
	authenticatedClients at: testObjectFactory defaultClientID put: testObjectFactory defaultPassword.
	
	merchantProcessor := MerchantProcessorSimulator new.
	
	defaultClock := ClockSimulator with: GregorianDateTime now.! !


!InternalApiTest methodsFor: 'assertions' stamp: 'db 12/2/2020 22:35:42'!
assertIsNotAuthenticatedClientFor: aOperationBlock

	self 
		should: [aOperationBlock value] 
		raise: Error - MessageNotUnderstood
	 	withExceptionDo: [:anError | 
			self assert: anError messageText = InternalApi notAuthenticatedClientErrorDescription ]
	! !

!InternalApiTest methodsFor: 'assertions' stamp: 'db 12/1/2020 17:53:05'!
assertOperationOnExpiredCart: operationBlock

	self 
		should: [operationBlock value] 
		raise: Error - MessageNotUnderstood
	 	withExceptionDo: [:anError | 
			self assert: anError messageText = InternalApi operationOnExpiredCartErrorDescription ]
! !

!InternalApiTest methodsFor: 'assertions' stamp: 'db 12/2/2020 22:48:04'!
denyCartSessionExpiredAfter30MinutesOfCreated: cartID through: apiCaller using: aClock

	|  cartSession  |
	aClock advance: 1.
	
	cartSession := apiCaller currentCartSession: cartID.
	
	self deny: (cartSession isExpiredOn: aClock now)
	
	
		
	! !


!InternalApiTest methodsFor: 'testing - invalid cartID' stamp: 'db 12/1/2020 17:01:21'!
test05CannotAddItemsToAnInvalidCartID

	| apiCaller |
	apiCaller := InternalApi withAuthenticator: self throught: merchantProcessor withCatalog: testObjectFactory defaultCatalog andClock: defaultClock.
	
	self 
		should: [apiCaller add: 4 to: testObjectFactory invalidCartID of: testObjectFactory itemSellByTheStore ] 
		raise: Error - MessageNotUnderstood
	 	withExceptionDo: [:anError | 
			self assert: anError messageText = InternalApi cartNotFoundErrorDescription]
	! !

!InternalApiTest methodsFor: 'testing - invalid cartID' stamp: 'db 12/1/2020 17:01:25'!
test06CannotCheckoutACartWithAnInvalidCartID

	| apiCaller |
	apiCaller := InternalApi withAuthenticator: self throught: merchantProcessor withCatalog: testObjectFactory defaultCatalog andClock: defaultClock.
	
	self 
		should: [apiCaller 
			checkout: testObjectFactory invalidCartID 
			withCreditCardNumber: testObjectFactory defaultCreditCardNumber
			andCreditCardExpirationDate: testObjectFactory notExpiredDate
			andCreditCardOwner: testObjectFactory defaultCreditCardOwner] 
		raise: Error - MessageNotUnderstood
	 	withExceptionDo: [:anError | 
			self assert: anError messageText = InternalApi cartNotFoundErrorDescription]
	! !

!InternalApiTest methodsFor: 'testing - invalid cartID' stamp: 'db 12/2/2020 17:38:33'!
test13CannotListACartWithAnInvalidCartID

	| apiCaller |
	apiCaller := InternalApi withAuthenticator: self throught: merchantProcessor withCatalog: testObjectFactory defaultCatalog andClock: defaultClock.
	
	self 
		should: [apiCaller listCart:  testObjectFactory invalidCartID ] 
		raise: Error - MessageNotUnderstood
	 	withExceptionDo: [:anError | 
			self assert: anError messageText = InternalApi cartNotFoundErrorDescription]
	! !


!InternalApiTest methodsFor: 'testing - interface' stamp: 'db 12/2/2020 22:35:22'!
test01CannotCreateACartWithAnInvalidUserID

	| apiCaller |
	apiCaller := InternalApi withAuthenticator: self throught: merchantProcessor withCatalog: testObjectFactory defaultCatalog andClock: defaultClock .

	self assertIsNotAuthenticatedClientFor: [apiCaller createCartFor: testObjectFactory invalidClientID withPassword: testObjectFactory invalidPassword].
! !

!InternalApiTest methodsFor: 'testing - interface' stamp: 'db 12/2/2020 22:35:22'!
test02CannotCreateACartWithAnInvalidPassword

	| apiCaller |
	apiCaller := InternalApi withAuthenticator: self throught: merchantProcessor withCatalog: testObjectFactory defaultCatalog andClock:  defaultClock.

	self assertIsNotAuthenticatedClientFor: [apiCaller createCartFor: testObjectFactory defaultClientID withPassword: testObjectFactory invalidPassword].
	! !

!InternalApiTest methodsFor: 'testing - interface' stamp: 'db 12/1/2020 17:01:14'!
test03NewCartsAreCreatedEmpty

	| apiCaller cartID |
	apiCaller := InternalApi withAuthenticator: self throught: merchantProcessor withCatalog: testObjectFactory defaultCatalog andClock: defaultClock.
	
	cartID := apiCaller createCartFor: testObjectFactory defaultClientID withPassword: testObjectFactory defaultPassword .
	
	self assert: (apiCaller listCart: cartID) isEmpty.
	
	! !

!InternalApiTest methodsFor: 'testing - interface' stamp: 'db 12/1/2020 17:01:17'!
test04AfterRequestingToAddAnItemTheCartIsNotEmptyAnymore

	| apiCaller cartID items |
	apiCaller := InternalApi withAuthenticator: self throught: merchantProcessor withCatalog: testObjectFactory defaultCatalog andClock: defaultClock.
	
	cartID := apiCaller createCartFor: testObjectFactory defaultClientID withPassword: testObjectFactory defaultPassword .
	
	apiCaller add: 2 to: cartID of: testObjectFactory itemSellByTheStore .
	items := apiCaller listCart: cartID.
	
	self deny: items isEmpty.
	self assert: items includes: testObjectFactory itemSellByTheStore.! !

!InternalApiTest methodsFor: 'testing - interface' stamp: 'db 12/1/2020 17:01:28'!
test07AfterSucessfulCheckoutThePurchaseIsSaved

	| apiCaller cartID purchases |
	apiCaller := InternalApi withAuthenticator: self throught: merchantProcessor withCatalog: testObjectFactory defaultCatalog andClock: defaultClock.
	
	cartID := apiCaller createCartFor: testObjectFactory defaultClientID withPassword: testObjectFactory defaultPassword.
	
	apiCaller add: 5 to: cartID of: testObjectFactory itemSellByTheStore.
	
	apiCaller 
		checkout: cartID 
		withCreditCardNumber: testObjectFactory defaultCreditCardNumber 
		andCreditCardExpirationDate: testObjectFactory notExpiredDate
		andCreditCardOwner: testObjectFactory defaultCreditCardOwner.
		
	purchases := apiCaller listPurchasesOf: testObjectFactory defaultClientID withPassword: testObjectFactory defaultPassword.
	
	self deny:  purchases isEmpty.
	self assert: 50 equals: purchases first total.
	self assert: purchases first items includes: testObjectFactory itemSellByTheStore.
	
	! !

!InternalApiTest methodsFor: 'testing - interface' stamp: 'db 12/2/2020 22:35:22'!
test08CannotListPurchasesOfNonAuthenticatedClient

	| apiCaller |
	apiCaller := InternalApi withAuthenticator: self throught: merchantProcessor withCatalog: testObjectFactory defaultCatalog andClock: defaultClock.
	
	self assertIsNotAuthenticatedClientFor: [apiCaller 
				listPurchasesOf: testObjectFactory defaultClientID 
				withPassword: testObjectFactory invalidPassword].

		
	! !


!InternalApiTest methodsFor: 'testing - expired cart' stamp: 'db 12/1/2020 18:01:39'!
test09CannotAddToCartToAnExpiredCart

	| apiCaller cartID clock |
	clock := ClockSimulator with: GregorianDateTime now.
	
	
	apiCaller := InternalApi withAuthenticator: self throught: merchantProcessor withCatalog: testObjectFactory defaultCatalog andClock: clock.
	
	cartID := apiCaller createCartFor: testObjectFactory defaultClientID withPassword: testObjectFactory defaultPassword .

	clock advance: 30.
	
	self assertOperationOnExpiredCart: [apiCaller add: 2 to: cartID of: testObjectFactory itemSellByTheStore].! !

!InternalApiTest methodsFor: 'testing - expired cart' stamp: 'db 12/1/2020 18:02:05'!
test10CannotListCartToAnExpiredCart

	| apiCaller cartID clock |
	clock := ClockSimulator with: GregorianDateTime now.
	
	apiCaller := InternalApi withAuthenticator: self throught: merchantProcessor withCatalog: testObjectFactory defaultCatalog andClock: clock.
	
	cartID := apiCaller createCartFor: testObjectFactory defaultClientID withPassword: testObjectFactory defaultPassword .

	clock advance: 30.
	
	self assertOperationOnExpiredCart: [apiCaller listCart: cartID]! !

!InternalApiTest methodsFor: 'testing - expired cart' stamp: 'db 12/1/2020 18:02:23'!
test11CannotCheckoutToAnExpiredCart

	| apiCaller cartID clock |
	clock := ClockSimulator with: GregorianDateTime now.
	
	apiCaller := InternalApi withAuthenticator: self throught: merchantProcessor withCatalog: testObjectFactory defaultCatalog andClock: clock.
	
	cartID := apiCaller createCartFor: testObjectFactory defaultClientID withPassword: testObjectFactory defaultPassword .

	clock advance: 30.

	self assertOperationOnExpiredCart: [apiCaller 
			checkout: cartID 
			withCreditCardNumber: testObjectFactory defaultCreditCardNumber 
			andCreditCardExpirationDate: testObjectFactory notExpiredDate
			andCreditCardOwner: testObjectFactory defaultCreditCardOwner]
! !

!InternalApiTest methodsFor: 'testing - expired cart' stamp: 'db 12/1/2020 18:02:32'!
test12ExpiredCartShouldBeRemoved

	| apiCaller cartID clock |
	clock := ClockSimulator with: GregorianDateTime now.
	
	apiCaller := InternalApi withAuthenticator: self throught: merchantProcessor withCatalog: testObjectFactory defaultCatalog andClock: clock.
	
	cartID := apiCaller createCartFor: testObjectFactory defaultClientID withPassword: testObjectFactory defaultPassword .

	clock advance: 30.

	self assertOperationOnExpiredCart: [apiCaller listCart: cartID].
		
	self 
		should: [	apiCaller listCart: cartID.] 
		raise: Error - MessageNotUnderstood
	 	withExceptionDo: [:anError | 
			self assert: anError messageText = InternalApi cartNotFoundErrorDescription ]	.
	! !

!InternalApiTest methodsFor: 'testing - expired cart' stamp: 'db 12/2/2020 22:48:27'!
test14AfterExecutingAddToCartTheExpirationTimeIsExtended

	| apiCaller cartID clock |
	clock := ClockSimulator with: GregorianDateTime now.
	
	apiCaller := InternalApi withAuthenticator: self throught: merchantProcessor withCatalog: testObjectFactory defaultCatalog andClock: clock.
	
	cartID := apiCaller createCartFor: testObjectFactory defaultClientID withPassword: testObjectFactory defaultPassword.
	
	clock advance: 29.
	
	apiCaller add: 2 to: cartID of: testObjectFactory itemSellByTheStore.
	
	self denyCartSessionExpiredAfter30MinutesOfCreated: cartID through: apiCaller using: clock.
	
		
	! !

!InternalApiTest methodsFor: 'testing - expired cart' stamp: 'db 12/2/2020 22:48:57'!
test15AfterExecutingListCartTheExpirationTimeIsExtended

	| apiCaller cartID clock |
	clock := ClockSimulator with: GregorianDateTime now.
	
	apiCaller := InternalApi withAuthenticator: self throught: merchantProcessor withCatalog: testObjectFactory defaultCatalog andClock: clock.
	
	cartID := apiCaller createCartFor: testObjectFactory defaultClientID withPassword: testObjectFactory defaultPassword.
	
	clock advance: 29.
	
	apiCaller listCart: cartID.
	
	
	self denyCartSessionExpiredAfter30MinutesOfCreated: cartID through: apiCaller using: clock.
	
		
	! !

!InternalApiTest methodsFor: 'testing - expired cart' stamp: 'db 12/2/2020 22:49:05'!
test16AfterExecutingCheckoutTheExpirationTimeIsExtended

	| apiCaller cartID clock |
	clock := ClockSimulator with: GregorianDateTime now.
	
	apiCaller := InternalApi withAuthenticator: self throught: merchantProcessor withCatalog: testObjectFactory defaultCatalog andClock: clock.
	
	cartID := apiCaller createCartFor: testObjectFactory defaultClientID withPassword: testObjectFactory defaultPassword.
	
	apiCaller add: 2 to: cartID of: testObjectFactory itemSellByTheStore.
	
	clock advance: 29.
	
	apiCaller 
			checkout: cartID 
			withCreditCardNumber: testObjectFactory defaultCreditCardNumber 
			andCreditCardExpirationDate: testObjectFactory notExpiredDate
			andCreditCardOwner: testObjectFactory defaultCreditCardOwner.
			
	self denyCartSessionExpiredAfter30MinutesOfCreated: cartID through: apiCaller using: clock.
	
		
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


!Cart methodsFor: 'initialization' stamp: 'db 11/29/2020 12:29:45'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'db 11/29/2020 12:23:35'!
items

	^ items! !

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

!Cashier methodsFor: 'checkout - private' stamp: 'db 12/1/2020 16:25:27'!
createSale

	^ Sale of: total withItems: cart items asBag 
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


!classDefinition: #ClockSimulator category: 'TusLibros'!
Object subclass: #ClockSimulator
	instanceVariableNames: 'now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ClockSimulator methodsFor: 'initialization' stamp: 'db 12/1/2020 18:00:55'!
initializeWith: aDateAndTime

	 now := aDateAndTime 
	! !


!ClockSimulator methodsFor: 'public methods' stamp: 'db 12/1/2020 17:56:36'!
advance: minutes

	 now := now next: (TimeUnits minute with: minutes).
	! !

!ClockSimulator methodsFor: 'public methods' stamp: 'db 11/30/2020 19:59:14'!
now
	^now! !

!ClockSimulator methodsFor: 'public methods' stamp: 'db 12/2/2020 19:32:20'!
today
	^Date today! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ClockSimulator class' category: 'TusLibros'!
ClockSimulator class
	instanceVariableNames: ''!

!ClockSimulator class methodsFor: 'as yet unclassified' stamp: 'db 12/1/2020 17:59:32'!
with: aDateAndTime
	^ClockSimulator new initializeWith: aDateAndTime ! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration ccn expirationMonth expirationYear creditCardOwner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'db 12/2/2020 16:49:35'!
creditCardNumber
	^ccn ! !

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'db 12/2/2020 17:15:37'!
initializeWith: aCreditCardNumber expiration: aMonth creditCartOwner: aCreditCardOwner.
	
	ccn := aCreditCardNumber.
	expiration := aMonth. 
	creditCardOwner := aCreditCardOwner.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'assertions' stamp: 'db 12/2/2020 16:47:40'!
assertCreditCardLength: aCreditCardNumber 

	(aCreditCardNumber size = 16) ifFalse: [^self error: self creditCardNumberInvalidLengthNumberErrorDescription].
	! !

!CreditCard class methodsFor: 'assertions' stamp: 'db 12/2/2020 17:07:56'!
assertEmptyCreditCardOwner: aCreditCardOwner

	aCreditCardOwner isEmpty ifTrue: [^self error: self creditCardOwnerCannotBeEmptyErrorDescription ].! !

!CreditCard class methodsFor: 'assertions' stamp: 'db 12/2/2020 17:13:24'!
assertWhenCreditCardOwnerAreLongerThanThirty: aCreditCardOwner

	aCreditCardOwner size <= 30 ifFalse: [^self error: self creditCardOwnerNameCantBeLongerThanThirtyErrorDescription].! !


!CreditCard class methodsFor: 'instance creation' stamp: 'db 12/2/2020 17:23:33'!
with: aCreditCardNumber expiration: aMonth creditCardOwner: aCreditCardOwner

	self assertCreditCardLength: aCreditCardNumber.
	self assertEmptyCreditCardOwner: aCreditCardOwner.
	self assertWhenCreditCardOwnerAreLongerThanThirty: aCreditCardOwner.
	
	^self new initializeWith: aCreditCardNumber expiration: aMonth creditCartOwner: aCreditCardOwner.! !


!CreditCard class methodsFor: 'error descriptions' stamp: 'db 12/2/2020 17:06:12'!
creditCardNumberInvalidLengthNumberErrorDescription
	^'Invalid length number'! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'db 12/2/2020 17:06:48'!
creditCardOwnerCannotBeEmptyErrorDescription
	^'credit card owner cannot be empty'! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'db 12/2/2020 17:10:48'!
creditCardOwnerNameCantBeLongerThanThirtyErrorDescription
	^'credit card owner name cant be longer than thirty '! !


!classDefinition: #InternalApi category: 'TusLibros'!
Object subclass: #InternalApi
	instanceVariableNames: 'authenticator merchantProcessor catalog carts sequence salesBook clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalApi methodsFor: 'initialization' stamp: 'db 12/2/2020 19:38:54'!
initializeWithAuthenticator: anAuthenticator throught: aMerchantProcessor withCatalog: aCatalog andClock: aClock   
	authenticator := anAuthenticator.
	catalog := aCatalog.
	merchantProcessor := aMerchantProcessor. 
	sequence := 0.
	carts := Dictionary new.
	salesBook := Dictionary new.
	clock := aClock ! !


!InternalApi methodsFor: 'salesBook' stamp: 'db 12/3/2020 00:42:14'!
salesBookFrom: aCartSession

	^salesBook at:	 aCartSession clientIDSession ifAbsent: [^OrderedCollection new.].
	
	! !

!InternalApi methodsFor: 'salesBook' stamp: 'db 12/3/2020 00:42:26'!
updateSalesbookOf: aCartSession with: aClientSalesBook 

	salesBook at: aCartSession clientIDSession put: aClientSalesBook.
	
	! !


!InternalApi methodsFor: 'privates' stamp: 'db 12/2/2020 19:32:07'!
checkoutTo: aCart payingWith: aCreditCard andRegisterIn: aSalesBook
	
	| cashier |
	cashier := Cashier 
		toCheckout: aCart
		charging: aCreditCard
		throught: merchantProcessor 
		on: clock today
		registeringOn: aSalesBook.
		
	cashier checkOut.
	
	! !

!InternalApi methodsFor: 'privates' stamp: 'db 12/2/2020 19:46:40'!
currentCartSession: aCartID 
	| sessionCart |
	sessionCart := carts at: aCartID ifAbsent: [^self class signalCartNotFound ].
	
	self assertIsNotExpiredCartAndRemoveItIfItIsExpired: aCartID.
	
	^sessionCart 
	
	! !

!InternalApi methodsFor: 'privates' stamp: 'db 11/30/2020 23:48:32'!
nextID
	sequence := sequence +1.
	^sequence.! !


!InternalApi methodsFor: 'assertions' stamp: 'db 12/2/2020 22:36:03'!
assertIsNotAuthenticatedClient: aClientID withPassword: aPassword  

	(authenticator authenticate: aClientID withPassword: aPassword) ifFalse: [^self class signalNotAuthenticatedClient].
! !

!InternalApi methodsFor: 'assertions' stamp: 'db 12/2/2020 19:44:01'!
assertIsNotExpiredCartAndRemoveItIfItIsExpired: aCartID 

	((carts at: aCartID) isExpiredOn: clock now) ifTrue: [
		carts removeKey: aCartID .
		^self class signalOperationOnExpiredCart].
	
	 
! !


!InternalApi methodsFor: 'client - methods' stamp: 'db 12/2/2020 21:42:39'!
createCartFor: aClientID withPassword: aPassword

	| cartID |
	
	self assertIsNotAuthenticatedClient: aClientID withPassword: aPassword.
	
	cartID := self nextID.
	
	carts at: cartID put: (CartSession with: (Cart acceptingItemsOf: catalog) associatedTo: aClientID createAt: clock now) .
	
	^cartID.! !

!InternalApi methodsFor: 'client - methods' stamp: 'db 12/2/2020 19:41:38'!
listPurchasesOf: aClientID withPassword: aPassword  

	self assertIsNotAuthenticatedClient: aClientID withPassword: aPassword.
	^salesBook at: aClientID ! !


!InternalApi methodsFor: 'cart - method' stamp: 'db 12/2/2020 22:27:23'!
add: aQuantity to: aCartID of: anItem
	
	| cartSession |
	cartSession := self currentCartSession: aCartID.
	
	cartSession add: aQuantity of: anItem.
	
	cartSession stamp: clock now.
	
	 
! !

!InternalApi methodsFor: 'cart - method' stamp: 'db 12/2/2020 22:34:28'!
checkout: aCartID withCreditCardNumber: aCCN andCreditCardExpirationDate: aCCED andCreditCardOwner: aCCO 
	
	| cartSession clientSalesBook |
	
	cartSession := self currentCartSession: aCartID.

	clientSalesBook := self salesBookFrom: cartSession.
	
	self checkoutTo: cartSession payingWith: (CreditCard with: aCCN expiration: aCCED creditCardOwner: aCCO) andRegisterIn: clientSalesBook.
	
	self updateSalesbookOf: cartSession with: clientSalesBook.
	
	cartSession stamp: clock now.
	! !

!InternalApi methodsFor: 'cart - method' stamp: 'db 12/2/2020 22:30:40'!
listCart: aCartID 
	
	| cartSession items |
	cartSession := self currentCartSession: aCartID.
	
	items := cartSession items asBag.
	
	cartSession stamp: clock now.
	
	^items! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InternalApi class' category: 'TusLibros'!
InternalApi class
	instanceVariableNames: ''!

!InternalApi class methodsFor: 'instance creation' stamp: 'db 12/1/2020 16:58:15'!
withAuthenticator: anAuthenticator throught: aMerchantProcessor withCatalog: aCatalog andClock: aClock   
	
	^self new initializeWithAuthenticator: anAuthenticator throught: aMerchantProcessor withCatalog: aCatalog andClock: aClock .! !


!InternalApi class methodsFor: 'error messages' stamp: 'db 12/2/2020 19:36:39'!
cartNotFoundErrorDescription
	^'Cart not found'! !

!InternalApi class methodsFor: 'error messages' stamp: 'db 12/2/2020 22:35:42'!
notAuthenticatedClientErrorDescription
	^'Non authenticated client'! !

!InternalApi class methodsFor: 'error messages' stamp: 'db 12/2/2020 19:38:27'!
operationOnExpiredCartErrorDescription
	^'cannot operate on an expired cart'! !


!InternalApi class methodsFor: 'signals' stamp: 'db 12/1/2020 00:13:37'!
signalCartNotFound
	
	^self error: self cartNotFoundErrorDescription ! !

!InternalApi class methodsFor: 'signals' stamp: 'db 12/2/2020 22:36:03'!
signalNotAuthenticatedClient
	
	^self error: self notAuthenticatedClientErrorDescription! !

!InternalApi class methodsFor: 'signals' stamp: 'db 12/1/2020 17:17:27'!
signalOperationOnExpiredCart
	
	^self error: self operationOnExpiredCartErrorDescription ! !


!classDefinition: #MerchantProcessor category: 'TusLibros'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'interface method' stamp: 'db 12/1/2020 01:33:11'!
debit: anAmount from: aCreditCard 

	self subclassResponsibility ! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
MerchantProcessor subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'initialization' stamp: 'db 12/1/2020 01:34:05'!
initialize
	debitBehavior := [ :anAmount :aCreditCard | ]! !

!MerchantProcessorSimulator methodsFor: 'initialization' stamp: 'db 12/2/2020 20:04:04'!
initializeWithDebitBehavior: aDebitBehavior

	debitBehavior := aDebitBehavior! !


!MerchantProcessorSimulator methodsFor: 'interface methods' stamp: 'db 12/1/2020 01:33:16'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: 'TusLibros'!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'as yet unclassified' stamp: 'db 12/2/2020 20:05:24'!
withDebitBehavior: aBehavior

	^MerchantProcessorSimulator new initializeWithDebitBehavior: aBehavior .! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'items total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'db 12/1/2020 16:22:33'!
items
	
	^ items! !

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'db 12/1/2020 16:22:05'!
initializeTotal: aTotal withItems: aListOfItems 

	total := aTotal .
	items := aListOfItems .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'db 12/1/2020 16:24:59'!
of: aTotal withItems: aListOfItems 

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal withItems: aListOfItems ! !


!classDefinition: #Session category: 'TusLibros'!
Object subclass: #Session
	instanceVariableNames: 'lastAccessedTime owner clientID'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Session methodsFor: 'private methods' stamp: 'db 12/3/2020 00:38:15'!
activeTimeFrom: aDate.

	^ (lastAccessedTime distanceTo: aDate) convertTo: minute.
	! !


!Session methodsFor: 'opeartions' stamp: 'db 12/3/2020 00:41:53'!
clientIDSession
	^clientID
	! !

!Session methodsFor: 'opeartions' stamp: 'db 12/2/2020 22:23:25'!
isExpiredOn: aDate
	
	^(self activeTimeFrom: aDate) >= (SimpleMeasure amount: 30 unit: minute).
	! !

!Session methodsFor: 'opeartions' stamp: 'db 12/3/2020 00:38:05'!
stamp: aDateAndTime

	lastAccessedTime := aDateAndTime.
	! !


!classDefinition: #CartSession category: 'TusLibros'!
Session subclass: #CartSession
	instanceVariableNames: 'cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartSession methodsFor: 'initialization' stamp: 'db 12/3/2020 00:41:30'!
initializeWith: aCart associatedTo: aClientID andCreatedAt: aDateAndTime

	cart := aCart.
	clientID := aClientID.
	lastAccessedTime := aDateAndTime.
	
	
	! !



!CartSession methodsFor: 'carts operations' stamp: 'db 12/2/2020 21:44:10'!
add: aQuantity of: anItem
	^cart add: aQuantity of: anItem! !

!CartSession methodsFor: 'carts operations' stamp: 'db 12/2/2020 21:44:35'!
isEmpty
	^cart isEmpty ! !

!CartSession methodsFor: 'carts operations' stamp: 'db 12/2/2020 21:43:19'!
items
	^cart items ! !

!CartSession methodsFor: 'carts operations' stamp: 'db 12/2/2020 21:45:51'!
total
	^cart total ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: 'TusLibros'!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'initialization' stamp: 'db 12/2/2020 21:41:35'!
with: aCart associatedTo: aClientID createAt: aDateAndTime

	^CartSession new initializeWith: aCart associatedTo: aClientID andCreatedAt: aDateAndTime! !


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


!StoreTestObjectsFactory methodsFor: 'client' stamp: 'db 11/26/2020 20:57:28'!
defaultClientID
	^1
	
	! !

!StoreTestObjectsFactory methodsFor: 'client' stamp: 'db 11/26/2020 20:58:14'!
defaultPassword
	^'miviejamula'
	
	! !

!StoreTestObjectsFactory methodsFor: 'client' stamp: 'db 11/30/2020 23:19:35'!
invalidClientID
	^Object new.
	
	! !

!StoreTestObjectsFactory methodsFor: 'client' stamp: 'db 11/30/2020 23:19:45'!
invalidPassword
	^Object new.
	
	! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'db 12/1/2020 00:10:21'!
invalidCartID
	
	^Object new.! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'db 12/2/2020 17:28:16'!
defaultCreditCardNumber
	
	^'4546789778787890'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'db 12/1/2020 00:30:58'!
defaultCreditCardOwner
	
	^'milhouse'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'db 12/2/2020 17:25:46'!
expiredCreditCard
	
	^CreditCard with: self defaultCreditCardNumber expiration:  (Month month: today monthIndex year: today yearNumber - 1) creditCardOwner: self defaultCreditCardOwner ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'db 12/2/2020 17:21:55'!
expiredDate
	
	^(Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'db 12/2/2020 17:26:42'!
notExpiredCreditCard
	
	^CreditCard with: self defaultCreditCardNumber expiration: self notExpiredDate creditCardOwner: self defaultCreditCardOwner! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'db 12/1/2020 00:30:29'!
notExpiredDate
	
	^(Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'db 12/2/2020 17:30:27'!
today
	^today! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !
