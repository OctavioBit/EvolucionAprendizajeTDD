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

!CashierTest methodsFor: 'tests' stamp: 'LM 6/24/2021 14:40:19'!
test07CanNotCheckoutWhenSaleTotalIsNotPositive

	| cart cashier salesBook creditCard |

	cart := Cart acceptingItemsOf: (Dictionary newFromPairs: { testObjectsFactory itemSellByTheStore . 0 }).
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
	
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
			self assert: anError messageText = Sale totalMustBeStrictlyPositiveErrorDescription.
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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'LM 6/22/2021 09:17:09'!
test01CannotCreateCreditCardWithEmptyOwner

	self should: [ CreditCard number: 5574822318795416 expiringOn: (December of: 3000) owner: '' ]
		raise: Error - MessageNotUnderstood
		withMessageText: CreditCard ownerCannotBeEmptyErrorDescription.! !

!CreditCardTest methodsFor: 'tests' stamp: 'LM 6/22/2021 09:17:19'!
test02CannotCreateCreditCardWithNumberSizeDifferentTo16

	self should: [ CreditCard number: 557482231416 expiringOn: (December of: 3000) owner: 'Dan Ingalls' ]
		raise: Error - MessageNotUnderstood
		withMessageText: CreditCard numberMustHave16DigitsErrorDescription.! !


!classDefinition: #StoreTest category: 'TusLibros'!
TestCase subclass: #StoreTest
	instanceVariableNames: 'authenticationBehavior testObjectsFactory timerBehavior now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTest methodsFor: 'setUp/tearDown' stamp: 'LM 6/24/2021 16:19:47'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	authenticationBehavior := [ :aClientID :aPassword |  ].
	timerBehavior := [ :aDuration :aBlock |  ].
	now := testObjectsFactory today.! !


!StoreTest methodsFor: 'tests' stamp: 'LM 6/24/2021 16:03:19'!
test01CannotCreateCartWithInvalidCredentials

	| clientID store password |
	
	clientID := 234589.
	password := 'password'.
	authenticationBehavior := [ :aClientID :aPassword | self error: 'Invalid credentials' ].
	store := Store authenticatingWith: self withCatalog: testObjectsFactory defaultCatalog through: self measuringTimeWith: self.
	
	self should: [ store createCartFor: clientID withPassword: password. ]
		raise: Error - MessageNotUnderstood
		withMessageText: 'Invalid credentials'.! !

!StoreTest methodsFor: 'tests' stamp: 'LM 6/24/2021 16:01:44'!
test02IDOfNewCartReferencesThatCart

	| clientID store password cartID |
	
	clientID := 234589.
	password := 'password'.
	store := Store authenticatingWith: self withCatalog: testObjectsFactory defaultCatalog through: self measuringTimeWith: self.
	cartID := store createCartFor: clientID withPassword: password.
	
	self assert: (store listCart: cartID) isEmpty.! !

!StoreTest methodsFor: 'tests' stamp: 'LM 6/24/2021 16:01:51'!
test03BooksAddedToCartAppearInCartList

	| clientID store password cartID expectedList |
	
	expectedList := Bag new.
	expectedList add: testObjectsFactory itemSellByTheStore withOccurrences: 2.
	clientID := 234589.
	password := 'password'.
	store := Store authenticatingWith: self withCatalog: testObjectsFactory defaultCatalog through: self measuringTimeWith: self.
	cartID := store createCartFor: clientID withPassword: password.
	store addToCart: cartID book: testObjectsFactory itemSellByTheStore quantity: 2.
	
	self assert: expectedList equals: (store listCart: cartID).! !

!StoreTest methodsFor: 'tests' stamp: 'LM 6/24/2021 16:03:32'!
test04DifferentCheckoutsHaveDifferentTransactionIDs

	| clientID store password cartID firstTransactionID secondTransactionID |
	
	clientID := 234589.
	password := 'password'.
	store := Store authenticatingWith: self withCatalog: testObjectsFactory defaultCatalog through: self measuringTimeWith: self.
	cartID := store createCartFor: clientID withPassword: password.
	store addToCart: cartID book: testObjectsFactory itemSellByTheStore quantity: 2.
	firstTransactionID := store checkOutCart: cartID
							chargingCCNumber: testObjectsFactory ccNumber
							ccExpiration: testObjectsFactory ccNotExpiredMonth
							ccOwner: testObjectsFactory ccOwner.
	secondTransactionID := store checkOutCart: cartID
							chargingCCNumber: testObjectsFactory ccNumber
							ccExpiration: testObjectsFactory ccNotExpiredMonth
							ccOwner: testObjectsFactory ccOwner.
	
	self assert: firstTransactionID ~= secondTransactionID.! !

!StoreTest methodsFor: 'tests' stamp: 'LM 6/24/2021 16:03:51'!
test05CheckedOutBooksAppearInClientsPurchasesList

	| clientID store password cartID expectedCartList |
	
	expectedCartList := Bag new.
	expectedCartList add: testObjectsFactory itemSellByTheStore withOccurrences: 2.
	clientID := 234589.
	password := 'password'.
	store := Store authenticatingWith: self withCatalog: testObjectsFactory defaultCatalog through: self measuringTimeWith: self.
	cartID := store createCartFor: clientID withPassword: password.
	store addToCart: cartID book: testObjectsFactory itemSellByTheStore quantity: 1.
	store checkOutCart: cartID
		chargingCCNumber: testObjectsFactory ccNumber
		ccExpiration: testObjectsFactory ccNotExpiredMonth
		ccOwner: testObjectsFactory ccOwner.
	store checkOutCart: cartID
		chargingCCNumber: testObjectsFactory ccNumber
		ccExpiration: testObjectsFactory ccNotExpiredMonth
		ccOwner: testObjectsFactory ccOwner.
	
	self assert: (OrderedCollection with: expectedCartList
							with: testObjectsFactory itemSellByTheStorePrice * 2)
		equals: (store listPurchasesFrom: clientID withPassword: password).! !

!StoreTest methodsFor: 'tests' stamp: 'LM 6/24/2021 16:32:08'!
test06CartIDBecomesInvalidAfter30Minutes

	| clientID store password cartID |
	
	clientID := 234589.
	password := 'password'.
	store := Store authenticatingWith: self withCatalog: testObjectsFactory defaultCatalog through: self measuringTimeWith: self.
	
	cartID := store createCartFor: clientID withPassword: password.
	self assertCartInvalidAfterMinutes: 31 whenDoing: [ store addToCart: cartID book: testObjectsFactory itemSellByTheStore quantity: 1 ].
	
	cartID := store createCartFor: clientID withPassword: password.	
	store addToCart: cartID book: testObjectsFactory itemSellByTheStore quantity: 1.
	self assertCartInvalidAfterMinutes: 31 whenDoing: [ store checkOutCart: cartID chargingCCNumber: testObjectsFactory ccNumber ccExpiration: testObjectsFactory ccNotExpiredMonth ccOwner: testObjectsFactory ccOwner ].
	
	cartID := store createCartFor: clientID withPassword: password.
	self assertCartInvalidAfterMinutes: 31 whenDoing: [ store listCart: cartID ].! !

!StoreTest methodsFor: 'tests' stamp: 'LM 6/24/2021 16:52:58'!
test07OperatingWithCartRestoresItsLifetime

	| clientID store password cartID |
	
	clientID := 234589.
	password := 'password'.
	store := Store authenticatingWith: self withCatalog: testObjectsFactory defaultCatalog through: self measuringTimeWith: self.
	
	cartID := store createCartFor: clientID withPassword: password.
	self restartCartsLifetime: 30 byDoing: [ store addToCart: cartID book: testObjectsFactory itemSellByTheStore quantity: 1 ].
	self assert: (Bag with: testObjectsFactory itemSellByTheStore) equals: (store listCart: cartID).
	
	cartID := store createCartFor: clientID withPassword: password.
	store addToCart: cartID book: testObjectsFactory itemSellByTheStore quantity: 1.
	self restartCartsLifetime: 30 byDoing: [ store checkOutCart: cartID chargingCCNumber: testObjectsFactory ccNumber ccExpiration: testObjectsFactory ccNotExpiredMonth ccOwner: testObjectsFactory ccOwner ].
	self assert: (Bag with: testObjectsFactory itemSellByTheStore) equals: (store listCart: cartID).
	
	cartID := store createCartFor: clientID withPassword: password.
	self restartCartsLifetime: 30 byDoing: [ store listCart: cartID ].
	self assert: (Bag new) equals: (store listCart: cartID).! !


!StoreTest methodsFor: 'support' stamp: 'LM 6/24/2021 16:27:47'!
assertCartInvalidAfterMinutes: minutes whenDoing: aBlock

	now := now + (Duration minutes: minutes).
	
	self should: aBlock
		raise: Error - MessageNotUnderstood
		withMessageText: Dictionary keyNotFoundErrorDescription.! !

!StoreTest methodsFor: 'support' stamp: 'LM 6/24/2021 16:46:47'!
restartCartsLifetime: minutes byDoing: aBlock

	now := now + (Duration minutes: minutes).
	
	aBlock value.
	
	now := now + (Duration minutes: minutes).! !


!StoreTest methodsFor: 'authenticator' stamp: 'LM 6/21/2021 17:40:46'!
verifyID: aClientID andPassword: aPassword

	authenticationBehavior value: aClientID value: aPassword.! !


!StoreTest methodsFor: 'merchant processor protocol' stamp: 'LM 6/21/2021 22:45:29'!
debit: anAmount from: aCreditCard! !


!StoreTest methodsFor: 'time' stamp: 'LM 6/24/2021 16:19:54'!
now

	^now! !


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


!Cart methodsFor: 'initialization' stamp: 'LM 6/24/2021 14:10:42'!
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

!Cart methodsFor: 'adding' stamp: 'LM 6/24/2021 14:12:04'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity.! !


!Cart methodsFor: 'accessing' stamp: 'LM 6/21/2021 18:38:23'!
items

	^items copy! !

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

!Cashier methodsFor: 'checkout - private' stamp: 'LM 6/22/2021 09:16:48'!
createSale

	^ Sale of: total forItems: cart items
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

!CreditCard class methodsFor: 'instance creation' stamp: 'LM 6/21/2021 19:06:19'!
number: aCCNumber expiringOn: aMonth owner: aCCOwner  

	self assertIsValidOwner: aCCOwner.
	self assertIsValidNumber: aCCNumber.
	
	^self new initializeExpiringOn: aMonth! !


!CreditCard class methodsFor: 'assertions' stamp: 'LM 6/21/2021 19:09:06'!
assertIsValidNumber: aCCNumber

	^ (aCCNumber numberOfDigitsInBase: 10) ~= 16 ifTrue: [ self error: self numberMustHave16DigitsErrorDescription ]! !

!CreditCard class methodsFor: 'assertions' stamp: 'LM 6/21/2021 19:09:24'!
assertIsValidOwner: aCCOwner

	^ aCCOwner withBlanksTrimmed isEmpty ifTrue: [ self error: self ownerCannotBeEmptyErrorDescription ]! !


!CreditCard class methodsFor: 'error description' stamp: 'LM 6/21/2021 19:06:56'!
numberMustHave16DigitsErrorDescription

	^'Card number must have 16 digits'! !

!CreditCard class methodsFor: 'error description' stamp: 'LM 6/21/2021 19:07:08'!
ownerCannotBeEmptyErrorDescription

	^'Owner cannot be empty'! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'LM 6/22/2021 11:14:47'!
initializeTotal: aTotal forItems: soldItems 

	total := aTotal.
	items := soldItems.! !


!Sale methodsFor: 'accessing' stamp: 'LM 6/22/2021 09:14:20'!
items

	^items! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'LM 6/24/2021 14:45:34'!
assertTotalIsPositive: aTotal

	^ aTotal > 0 ifFalse: [ self error: self totalMustBeStrictlyPositiveErrorDescription ]! !

!Sale class methodsFor: 'instance creation' stamp: 'LM 6/24/2021 14:45:34'!
of: aTotal forItems: soldItems 

	self assertTotalIsPositive: aTotal.
	^self new initializeTotal: aTotal forItems: soldItems ! !


!Sale class methodsFor: 'error description' stamp: 'LM 6/24/2021 14:44:03'!
totalMustBeStrictlyPositiveErrorDescription

	^'A sale total must be strictly positive'! !


!classDefinition: #Store category: 'TusLibros'!
Object subclass: #Store
	instanceVariableNames: 'authenticator carts catalog lastCartID lastTransactionID merchantProcessor salesBook cartsClients clientsSales cartsLastReferences clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Store methodsFor: 'initialization' stamp: 'LM 6/24/2021 15:31:29'!
initializeAuthenticatingWith: anAuthenticator withCatalog: aCatalog through: aMerchantProcessor measuringTimeWith: aClock

	authenticator := anAuthenticator.
	catalog := aCatalog.
	carts := Dictionary new.
	cartsClients := Dictionary new.
	clientsSales := Dictionary new.
	cartsLastReferences := Dictionary new.
	merchantProcessor := aMerchantProcessor.
	clock := aClock.
	lastCartID := 0.
	lastTransactionID := 0.! !


!Store methodsFor: 'cart management' stamp: 'LM 6/24/2021 16:50:45'!
addToCart: aCartID book: anISBN quantity: aQuantity
	
	(self getCart: aCartID) add: aQuantity of: anISBN.! !

!Store methodsFor: 'cart management' stamp: 'LM 6/24/2021 15:59:49'!
createCartFor: aClientID withPassword: aPassword 

	| cartID |
	
	authenticator verifyID: aClientID andPassword: aPassword.
	
	cartID := self newCartID.	
	carts at: cartID put: (Cart acceptingItemsOf: catalog).
	cartsClients at: cartID put: aClientID.
	
	cartsLastReferences at: cartID put: clock now.
	^cartID! !

!Store methodsFor: 'cart management' stamp: 'LM 6/24/2021 16:50:26'!
getCart: aCartID

	| timeCurrently |
	
	timeCurrently := clock now.
	timeCurrently - (cartsLastReferences at: aCartID) > (Duration minutes: 30)
		ifTrue: [ carts removeKey: aCartID ] ifFalse: [ cartsLastReferences at: aCartID put: timeCurrently ].
	
	^(carts at: aCartID)! !

!Store methodsFor: 'cart management' stamp: 'LM 6/24/2021 16:50:12'!
listCart: aCartID

	^(self getCart: aCartID) items! !

!Store methodsFor: 'cart management' stamp: 'LM 6/21/2021 18:30:17'!
newCartID

	lastCartID := lastCartID + 1.
	^lastCartID! !


!Store methodsFor: 'check out' stamp: 'LM 6/24/2021 16:51:02'!
checkOutCart: aCartID chargingCCNumber: aCCNumber ccExpiration: aMonth ccOwner: aCCOwner

	| cart creditCard clientID clientsSalesBook |
	
	cart := self getCart: aCartID.
	clientID := cartsClients at: aCartID.
	clientsSalesBook := clientsSales at: clientID ifAbsentPut: [ OrderedCollection new ].
	creditCard := CreditCard number: aCCNumber expiringOn: aMonth owner: aCCOwner.
	(Cashier toCheckout: cart
			charging: creditCard
			throught: merchantProcessor
			on: DateAndTime today
			registeringOn: clientsSalesBook) checkOut.
	^self newTransactionID.! !

!Store methodsFor: 'check out' stamp: 'LM 6/21/2021 20:01:03'!
newTransactionID

	lastTransactionID := lastTransactionID + 1.
	^lastTransactionID! !


!Store methodsFor: 'purchases' stamp: 'LM 6/24/2021 14:29:28'!
listPurchasesFrom: aClientID withPassword: aPassword

	| purchasesList sales |
	
	authenticator verifyID: aClientID andPassword: aPassword.
	
	sales := clientsSales at: aClientID.
	purchasesList := OrderedCollection with: (sales inject: Bag new addingAll: [ :sale | sale items ]).
	purchasesList add: (sales sum: [ :sale | sale total ]).
	
	^purchasesList! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Store class' category: 'TusLibros'!
Store class
	instanceVariableNames: ''!

!Store class methodsFor: 'instance creation' stamp: 'LM 6/24/2021 15:31:01'!
authenticatingWith: anAuthenticator withCatalog: aCatalog through: aMerchantProcessor measuringTimeWith: aClock

	^self new initializeAuthenticatingWith: anAuthenticator withCatalog: aCatalog through: aMerchantProcessor measuringTimeWith: aClock! !


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


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'LM 6/21/2021 19:16:39'!
ccExpiredMonth

	^ Month month: today monthIndex year: today yearNumber - 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'LM 6/21/2021 19:18:25'!
ccNotExpiredMonth

	^ Month month: today monthIndex year: today yearNumber + 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'LM 6/21/2021 19:15:46'!
ccNumber

	^ 5574822318795416! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'LM 6/21/2021 19:16:52'!
ccOwner

	^ 'Dan Ingalls'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'LM 6/21/2021 19:17:17'!
expiredCreditCard
	
	^CreditCard number: self ccNumber expiringOn: self ccExpiredMonth owner: self ccOwner! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'LM 6/21/2021 19:18:53'!
notExpiredCreditCard
	
	^CreditCard number: self ccNumber expiringOn: self ccNotExpiredMonth owner: self ccOwner! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
