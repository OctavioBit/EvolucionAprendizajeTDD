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


!classDefinition: #IntefaceTest category: 'TusLibros'!
TestCase subclass: #IntefaceTest
	instanceVariableNames: 'authenticationBehaviour testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!IntefaceTest methodsFor: 'set up' stamp: 'JR 6/23/2021 16:46:38'!
setUp
	
	testObjectsFactory := StoreTestObjectsFactory new.
	authenticationBehaviour := [:aUser :aPassword | ]! !


!IntefaceTest methodsFor: 'authenticator protocol' stamp: 'JR 6/21/2021 16:16:53'!
authenticate: aClientId with: aPassword

	authenticationBehaviour value: aClientId value: aPassword ! !


!IntefaceTest methodsFor: 'default objects' stamp: 'JR 6/23/2021 16:48:43'!
defaultInterface
	
	^Interface withCatalog: testObjectsFactory defaultCatalog 
			merchantProcessor: MerchantProcessor new 
			andAuthenticator: self! !


!IntefaceTest methodsFor: 'tests' stamp: 'JR 6/21/2021 16:48:49'!
test01CreateCartWithValidUserAndPasswordShouldReturnCartID

	|interface clientId password|
	
	interface  := self defaultInterface.
	clientId := 'Hernan Wilkinson'.
	password := 'inge1pasion'.
	
	self assert: 1 equals: (interface createCartFor: clientId authenticateWith: password) 
! !

!IntefaceTest methodsFor: 'tests' stamp: 'JR 6/21/2021 16:49:18'!
test02CartIDShouldBeUnique

	|interface clientId password cartId1 cartId2|
	
	interface  := self defaultInterface .
	clientId := 'Hernan Wilkinson'.
	password := 'inge1pasion'.
	cartId1 := interface createCartFor: clientId authenticateWith: password.
	cartId2 := interface createCartFor: clientId authenticateWith: password.
	
	self deny: cartId1 = cartId2
! !

!IntefaceTest methodsFor: 'tests' stamp: 'JR 6/21/2021 16:49:27'!
test03CreateCartWithInvalidUserOrPasswordShouldRaiseError

	|interface clientId password|
	
	interface  := self defaultInterface .
	clientId := 'Hernan Wilkinson'.
	password := 'inge1pasion'.
	authenticationBehaviour := [ :aUser :aPassword | self error:  Interface invalidUserOrPasswordErrorMessage].
	
	self 
		should: [interface createCartFor: clientId authenticateWith: password]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Interface invalidUserOrPasswordErrorMessage.
			self assert: interface lastCartId equals: 0]  ! !

!IntefaceTest methodsFor: 'tests' stamp: 'JR 6/23/2021 16:54:52'!
test04ListCartOfEmptyCartShouldBeEmpty

	|interface cartId|
	
	interface := self defaultInterface.
	cartId := interface createCartFor: 'Hernan Wilkinson' authenticateWith: 'inge1pasion'.
	
	self assert: (interface listCart: cartId) isEmpty
! !

!IntefaceTest methodsFor: 'tests' stamp: 'JR 6/23/2021 16:55:07'!
test05ItemAddedToCartShouldAppearInListCart

	|interface cartId|
	
	interface := self defaultInterface.
	cartId := interface createCartFor: 'Hernan Wilkinson' authenticateWith: 'inge1pasion'.
	
	interface add: 3 of: testObjectsFactory itemSellByTheStore to: cartId.
	
	self assert: ((interface listCart: cartId) includesKey: testObjectsFactory itemSellByTheStore).
	self assert: ((interface listCart: cartId) at: testObjectsFactory itemSellByTheStore) equals: 3! !

!IntefaceTest methodsFor: 'tests' stamp: 'JR 6/23/2021 16:56:04'!
test06CheckingOutCartShouldAppearInClientsPurchases

	|interface clientId password cartId expextedPurchasesList|
	
	interface := self defaultInterface.
	clientId := 'Hernan Wilkinson'.
	password := 'inge1pasion'.
	cartId := interface createCartFor: clientId authenticateWith: password.
	
	interface add: 3 of: testObjectsFactory itemSellByTheStore to: cartId.
	expextedPurchasesList := interface listCart: cartId.
	
	interface 	checkOutCart: cartId 
			withCreditCard: '1111222233334444' 
			expiring: (Month month: Date today monthIndex year: Date today yearNumber + 1) 
			ownedBy: 'Hernan Wilkinson'.
	
	self assert: (interface listPurchasesOf: clientId authenticateWith: password) equals: expextedPurchasesList ! !

!IntefaceTest methodsFor: 'tests' stamp: 'JR 6/23/2021 16:56:16'!
test07CanNotUseCart30MinutesAfterLastOperation

	|interface cartId clientId password |
	
	interface := self defaultInterface.
	clientId := 'Hernan Wilkinson'.
	password := 'inge1pasion'.
	cartId := interface createCartFor: clientId authenticateWith: password.
	
	interface setTimeToCart: cartId. "mensaje privado para poder testear que cuando pasa media hora no se pueda usar el cart"
	
	self
		should: [interface add: 3 of: testObjectsFactory itemSellByTheStore to: cartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Interface cartsTimeLimitExceededErrorMessage.
			self assert: (interface listCart: cartId) isEmpty]  ! !

!IntefaceTest methodsFor: 'tests' stamp: 'JR 6/23/2021 16:47:30'!
test08CanNotCheckOutCart30MinutesAfterLastOperation

	|interface clientId password cartId|
	
	interface := self defaultInterface.
	clientId := 'Hernan Wilkinson'.
	password := 'inge1pasion'.
	cartId := interface createCartFor: clientId authenticateWith: password.
	
	interface add: 3 of: testObjectsFactory itemSellByTheStore to: cartId.
	interface setTimeToCart: cartId. 
	
	self
		should: [interface checkOutCart: cartId 
			withCreditCard: '1111222233334444' 
			expiring: (Month month: Date today monthIndex year: Date today yearNumber + 1) 
			ownedBy: 'Hernan Wilkinson'.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Interface cartsTimeLimitExceededErrorMessage.
			self assert: (interface listPurchasesOf: clientId authenticateWith: password) isEmpty]  ! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items lastUsed'
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

!Cart methodsFor: 'assertions' stamp: 'JR 6/23/2021 16:39:05'!
assertTimeLimitIsNotExceeded

	((lastUsed + 30 minutes) < DateAndTime now) ifTrue: [self error: Interface cartsTimeLimitExceededErrorMessage ]! !


!Cart methodsFor: 'time - private' stamp: 'JR 6/23/2021 16:35:29'!
timeOfLastUse: aTime

	lastUsed := aTime! !


!Cart methodsFor: 'initialization' stamp: 'JR 6/23/2021 16:34:35'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.
	lastUsed := DateAndTime now.! !


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


!Cart methodsFor: 'adding' stamp: 'JR 6/23/2021 16:36:30'!
add: anItem

	self assertTimeLimitIsNotExceeded.
	
	self timeOfLastUse: DateAndTime now.

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'JR 6/23/2021 16:36:55'!
add: aQuantity of: anItem
	
	self assertTimeLimitIsNotExceeded.
	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.
	
	self timeOfLastUse: DateAndTime now.

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


!Cashier methodsFor: 'checkout' stamp: 'JR 6/23/2021 16:41:09'!
checkOut
	
	cart assertTimeLimitIsNotExceeded.
	cart timeOfLastUse: DateAndTime now.
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


!classDefinition: #Client category: 'TusLibros'!
Object subclass: #Client
	instanceVariableNames: 'cartId purchases'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Client methodsFor: 'initialization' stamp: 'JR 6/21/2021 17:29:54'!
initializeWith: aCartId 

	cartId := aCartId .
	purchases := Dictionary new.! !


!Client methodsFor: 'adding' stamp: 'JR 6/21/2021 17:47:19'!
addPurchase: aPurchase

	aPurchase keysAndValuesDo: [:aKey :aValue | purchases at: aKey put: ((purchases at: aKey ifAbsent: [0]) + aValue )]. ! !


!Client methodsFor: 'accessing' stamp: 'JR 6/21/2021 17:47:50'!
cartId
	
	^cartId ! !

!Client methodsFor: 'accessing' stamp: 'JR 6/21/2021 17:30:47'!
listPurchases
	
	^purchases ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Client class' category: 'TusLibros'!
Client class
	instanceVariableNames: ''!

!Client class methodsFor: 'instance creation' stamp: 'JR 6/21/2021 17:29:19'!
with: cartId

	^self new initializeWith: cartId ! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'JR 6/24/2021 16:44:14'!
initializeWith: aNumber owner: anOwner andExpiringDate: aDate
	
	expiration := aDate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'JR 6/23/2021 15:46:12'!
assertNumberHas16Digits: aNumber

	((aNumber allSatisfy: [:a | a isDigit]) and: [aNumber size = 16]) ifFalse: [self error: self invalidNumberErrorMessage]! !

!CreditCard class methodsFor: 'instance creation' stamp: 'JR 6/23/2021 15:45:59'!
assertOwnerIsNotEmpty: aName

	(aName withoutLeadingBlanks isEmpty) ifTrue: [self error: self invalidOwnerErrorMessage ]! !

!CreditCard class methodsFor: 'instance creation' stamp: 'JR 6/23/2021 15:45:45'!
invalidNumberErrorMessage

	^'The number must have 16 digits'! !

!CreditCard class methodsFor: 'instance creation' stamp: 'JR 6/23/2021 15:45:37'!
invalidOwnerErrorMessage

	^'Owner can not be empty'! !

!CreditCard class methodsFor: 'instance creation' stamp: 'JR 6/23/2021 15:45:22'!
withNumber: aNumber ownedBy: anOwner expiringOn: aDate

	self assertNumberHas16Digits: aNumber.
	self assertOwnerIsNotEmpty: anOwner.
	
	^self new initializeWith: aNumber owner: anOwner andExpiringDate: aDate
	! !


!classDefinition: #Interface category: 'TusLibros'!
Object subclass: #Interface
	instanceVariableNames: 'lastCartId userAuthenticator cartIds catalog clients merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Interface methodsFor: 'initialization' stamp: 'JR 6/23/2021 16:01:53'!
initializeWithCatalog: aCatalog merchantProcessor: aMerchantProcessor andAuthenticator: anAuthenticator 

	lastCartId := 0.
	userAuthenticator := anAuthenticator.
	merchantProcessor := aMerchantProcessor .
	cartIds := Dictionary new.
	catalog := aCatalog.
	clients := Dictionary new.
	! !


!Interface methodsFor: 'check out' stamp: 'JR 6/23/2021 15:57:20'!
addPurchaseToClientOwnerOfCart: cartId

	clients values do: [:client | (client cartId = cartId) ifTrue: [client addPurchase: (self listCart: cartId)]].
	
	
		
	! !

!Interface methodsFor: 'check out' stamp: 'JR 6/24/2021 16:47:29'!
checkOutCart: cartId withCreditCard: aNumber 	expiring: anExpirationDate ownedBy: anOwner

	|creditCard cashier salesBook|
	
	creditCard := 	CreditCard withNumber: aNumber ownedBy: anOwner expiringOn: anExpirationDate.
	salesBook := OrderedCollection new.
	cashier := Cashier 
		toCheckout: (cartIds at: cartId)
		charging: creditCard 
		throught: merchantProcessor 
		on:  DateAndTime now
		registeringOn: salesBook.
		
	cashier checkOut.
	self addPurchaseToClientOwnerOfCart: cartId.
	"devolvemos el cartId como transactionId dado que todavía no hay comportamiento sobre el transactionId"
	^cartId! !


!Interface methodsFor: 'cart' stamp: 'JR 6/21/2021 16:52:40'!
add: aQuantity of: anItem to: cartId

	(cartIds at: cartId) add: aQuantity of: anItem! !

!Interface methodsFor: 'cart' stamp: 'JR 6/21/2021 17:26:45'!
createCartFor: clientId authenticateWith: password

	|cart|

	userAuthenticator authenticate: clientId with: password.

	lastCartId := lastCartId + 1.
	
	cart := Cart acceptingItemsOf: catalog.
	
	cartIds at: lastCartId put: cart.
	clients at: clientId put: (Client with: lastCartId).
	
	^lastCartId ! !

!Interface methodsFor: 'cart' stamp: 'JR 6/21/2021 16:58:17'!
listCart: cartId

	|list cart|
	
	list := Dictionary new.
	cart := (cartIds at: cartId).
	
	catalog keys do: [:item | ((cart occurrencesOf: item) > 0) ifTrue: [list at: item put: (cart occurrencesOf: item)]].
	
	^list
	
	
		
	! !


!Interface methodsFor: 'clients purchases' stamp: 'JR 6/21/2021 17:24:49'!
listPurchasesOf: clientId authenticateWith: password
	
	userAuthenticator authenticate: clientId with: password.
	
	^(clients at: clientId) listPurchases
	
	
	
		
	! !


!Interface methodsFor: 'cart - private' stamp: 'JR 6/23/2021 16:33:57'!
setTimeToCart: cartId

	(cartIds at: cartId) timeOfLastUse: DateAndTime now - 30 minutes! !


!Interface methodsFor: 'accessing' stamp: 'JR 6/21/2021 16:10:04'!
lastCartId

	^lastCartId ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Interface class' category: 'TusLibros'!
Interface class
	instanceVariableNames: ''!

!Interface class methodsFor: 'instance creation' stamp: 'JR 6/23/2021 16:01:23'!
withCatalog: aCatalog merchantProcessor: aMerchantProcessor andAuthenticator: anAuthenticator

	^self new initializeWithCatalog: aCatalog merchantProcessor: aMerchantProcessor andAuthenticator: anAuthenticator ! !


!Interface class methodsFor: 'error messages' stamp: 'JR 6/23/2021 16:19:28'!
cartsTimeLimitExceededErrorMessage

	^'Can not use cart after 30 minutes have passed'! !

!Interface class methodsFor: 'error messages' stamp: 'JR 6/21/2021 16:10:55'!
invalidUserOrPasswordErrorMessage

	^'Invalid user or password error message'! !


!classDefinition: #MerchantProcessor category: 'TusLibros'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'JR 6/21/2021 17:41:23'!
debit: total from: creditCard! !


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


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'JR 6/23/2021 15:48:35'!
expiredCreditCard
	
	^CreditCard withNumber: '1111222233334444' 
			ownedBy: 'Hernan' 
			expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'JR 6/23/2021 15:48:47'!
notExpiredCreditCard
	
	^CreditCard withNumber: '1111222233334444' 
			ownedBy: 'Hernan' 
			expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
