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


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'setup' stamp: 'GR 6/24/2021 02:40:21'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.! !


!CreditCardTest methodsFor: 'tests' stamp: 'GR 6/24/2021 02:44:02'!
test01invalidCardNumberShouldFail

	self should: [testObjectsFactory invalidNumberCreditCard ]
		raise: Error - MessageNotUnderstood withMessageText: CreditCard invalidCardNumberErrorDescription.

	! !

!CreditCardTest methodsFor: 'tests' stamp: 'GR 6/24/2021 02:47:49'!
test02emptyOwnerNameShouldFail

	self should: [testObjectsFactory emptyNameCreditCard ]
		raise: Error - MessageNotUnderstood withMessageText: CreditCard nameIsEmptyErrorDescription .

	! !

!CreditCardTest methodsFor: 'tests' stamp: 'GR 6/24/2021 02:48:18'!
test03ownerNameTooLongShouldFail

	self should: [testObjectsFactory nameTooLongCreditCard ]
		raise: Error - MessageNotUnderstood withMessageText: CreditCard nameTooLongErrorDescription .

	! !


!classDefinition: #StoreTest category: 'TusLibros'!
TestCase subclass: #StoreTest
	instanceVariableNames: 'testObjectsFactory time'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTest methodsFor: 'tests' stamp: 'GR 6/24/2021 15:49:20'!
test01CreateCartCreatesAnEmptyCartWhenLoginIsValid

	|interface cartID|
	
	interface := testObjectsFactory defaultStoreForTest: self.
	
	cartID := interface createCartForClientID: '1234' withPassword: '1234'.
	
	self assert: (interface listCart: cartID) isEmpty. 

	! !

!StoreTest methodsFor: 'tests' stamp: 'GR 6/24/2021 15:50:15'!
test02CartKnowsBooksAdded

	|interface cartID cartList|

	interface := testObjectsFactory defaultStoreForTest: self.
	cartID := interface createCartForClientID: '1234' withPassword: '1234'.
	
	interface addToCart: cartID bookISBN: testObjectsFactory itemSellByTheStore bookQuantity: 1.	
	cartList := interface listCart: cartID.
	
	self assert: 1 equals: cartList size.
	self assert: 1 equals: (cartList occurrencesOf: testObjectsFactory itemSellByTheStore).

	! !

!StoreTest methodsFor: 'tests' stamp: 'GR 6/24/2021 15:53:16'!
test03CartIDIsNotUsedTwice

	|interface cartIDA cartIDB|

	interface := testObjectsFactory defaultStoreForTest: self.
	cartIDA := interface createCartForClientID: '1234' withPassword: '1234'.
	cartIDB := interface createCartForClientID: '1234' withPassword: '1234'.
	
	self deny: (cartIDA = cartIDB).
	! !

!StoreTest methodsFor: 'tests' stamp: 'GR 6/24/2021 15:53:45'!
test04CartsHaveDifferentLists

	|interface cartIDA cartIDB listCartA listCartB book|
	
	book := testObjectsFactory itemSellByTheStore .
	interface := testObjectsFactory defaultStoreForTest: self.
	cartIDA := interface createCartForClientID: '1234' withPassword: '1234'.
	cartIDB := interface createCartForClientID: '1234' withPassword: '1234'.
	
	interface addToCart: cartIDA bookISBN: book bookQuantity: 1.
	interface addToCart: cartIDB bookISBN: book bookQuantity: 2.	
	
	listCartA := interface listCart: cartIDA.
	listCartB := interface listCart: cartIDB.

	self assert: 1 equals: (listCartA occurrencesOf: book).
	self assert: 2 equals: (listCartB occurrencesOf: book).	! !

!StoreTest methodsFor: 'tests' stamp: 'GR 6/24/2021 15:54:25'!
test05InvalidLoginGetsInvalidLoginError

	|interface|
	
	interface := testObjectsFactory defaultStoreForTest: self.
	
	self should: [interface createCartForClientID: '4321' withPassword: '1234'.]
		raise: Error - MessageNotUnderstood withMessageText: Store invalidLoginErrorDescription.
	
	! !

!StoreTest methodsFor: 'tests' stamp: 'GR 6/24/2021 15:54:53'!
test06CannotListNonExistingCart

	|interface |
	
	interface := testObjectsFactory defaultStoreForTest: self.
	
	self should: [interface listCart: 1]
		raise: Error - MessageNotUnderstood withMessageText: Store invalidCartIDErrorDescription.
	
	! !

!StoreTest methodsFor: 'tests' stamp: 'GR 6/24/2021 16:01:09'!
test07CartExpiresAfterThirtyMinutes

	|interface cartID|

	interface := testObjectsFactory defaultStoreForTest: self.
	cartID := interface createCartForClientID: '1234' withPassword: '1234'.
	self advanceTimeBy: 30 minutes.
	
	self should: [interface addToCart: cartID bookISBN: testObjectsFactory itemSellByTheStore bookQuantity: 1.]
		raise: Error - MessageNotUnderstood withMessageText: Store cartLifespanExceededErrorMessage.
		
	
	
	
	! !

!StoreTest methodsFor: 'tests' stamp: 'GR 6/24/2021 16:01:15'!
test08DifferentCartsHaveDifferentExpiration

	|interface cartIDA cartIDB book listCartB|
	
	book := testObjectsFactory itemSellByTheStore.
	interface := testObjectsFactory defaultStoreForTest: self.
	cartIDA := interface createCartForClientID: '1234' withPassword: '1234'.
	self advanceTimeBy: 5 minutes.
	cartIDB := interface createCartForClientID: '1234' withPassword: '1234'.
	self advanceTimeBy: 26 minutes.
	
	self should: [interface addToCart: cartIDA bookISBN: book bookQuantity: 1.]
		raise: Error - MessageNotUnderstood withMessageText: Store cartLifespanExceededErrorMessage.
		
	interface addToCart: cartIDB bookISBN: book bookQuantity: 1.
	listCartB := interface listCart: cartIDB .
	self assert: 1 equals: (listCartB occurrencesOf: book).
	
		
	
	
	
	! !

!StoreTest methodsFor: 'tests' stamp: 'GR 6/24/2021 16:01:27'!
test09SalesGetRegistered

	|interface cartID book purchasesList clientID password|
	clientID := '1234'.
	password := '1234'.
	
	book := testObjectsFactory itemSellByTheStore .
	interface := testObjectsFactory defaultStoreForTest: self.
	cartID := interface createCartForClientID: clientID withPassword: password .
	interface addToCart: cartID bookISBN: book bookQuantity: 1.
	
	interface checkOutCart: cartID 
			usingCardNumbered: 1234567812345678 
			expiringOn: testObjectsFactory futureMonthOfYear 
			ownedBy: 'Jose Hernandez'.
			
	purchasesList := 			interface listPurchasesFrom: clientID using: password .
	self assert: 1 equals: (purchasesList items occurrencesOf: book) .
	self assert: 1 equals: purchasesList size.
	self assert: testObjectsFactory itemSellByTheStorePrice equals: purchasesList total.
	
	
	
	
		
	
	
	
	! !

!StoreTest methodsFor: 'tests' stamp: 'GR 6/24/2021 16:00:59'!
test10DifferentUsersGetDifferentPurchaseRegister

	|interface book cartIDA  purchasesListA clientIDA passwordA cartIDB  purchasesListB clientIDB passwordB|
	clientIDA := '1234'.
	passwordA := '1234'.
	
	clientIDB := '2345'.
	passwordB := '2345'.
	
	book := testObjectsFactory itemSellByTheStore .
	interface := testObjectsFactory defaultStoreForTest: self.
	
	cartIDA := interface createCartForClientID: clientIDA withPassword: passwordA .
	interface addToCart: cartIDA bookISBN: book bookQuantity: 1.
	
	cartIDB := interface createCartForClientID: clientIDB withPassword: passwordB .
	interface addToCart: cartIDB bookISBN: book bookQuantity: 2.
	
	interface checkOutCart: cartIDA 
			usingCardNumbered: 1234567812345678 
			expiringOn: testObjectsFactory futureMonthOfYear 
			ownedBy: 'Jose Hernandez'.
			
	interface checkOutCart: cartIDB 
			usingCardNumbered: 1234567812345679 
			expiringOn: testObjectsFactory futureMonthOfYear 
			ownedBy: 'Juan Hernandez'.
			
	purchasesListA := 			interface listPurchasesFrom: clientIDA using: passwordA .
	self assert: 1 equals: (purchasesListA items occurrencesOf: book) .
	self assert: 1 equals: purchasesListA size.
	self assert: testObjectsFactory itemSellByTheStorePrice equals: purchasesListA total.
	
	purchasesListB := 			interface listPurchasesFrom: clientIDB using: passwordB .
	self assert: 2 equals: (purchasesListB items occurrencesOf: book) .
	self assert: 2 equals: purchasesListB size.
	self assert: (2 * testObjectsFactory itemSellByTheStorePrice) equals: purchasesListB total.
	
	
	
	
		
	
	
	
	! !


!StoreTest methodsFor: 'setup' stamp: 'GR 6/24/2021 03:28:25'!
setUp 
	testObjectsFactory := StoreTestObjectsFactory new.
	time := testObjectsFactory today.
	
	
	! !


!StoreTest methodsFor: 'mocking' stamp: 'GR 6/24/2021 03:30:39'!
advanceTimeBy: anAmountOfTime

	time := time + anAmountOfTime .! !

!StoreTest methodsFor: 'mocking' stamp: 'GR 6/23/2021 18:57:25'!
check: aUserID with: aPassword

	^(aUserID = '4321') not.
	
	! !

!StoreTest methodsFor: 'mocking' stamp: 'GR 6/24/2021 06:03:51'!
debit: anAmount from: aCreditCard ! !

!StoreTest methodsFor: 'mocking' stamp: 'GR 6/24/2021 03:30:53'!
time
	^time.! !

!StoreTest methodsFor: 'mocking' stamp: 'GR 6/24/2021 06:07:12'!
today
	^time.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items owner'
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


!Cart methodsFor: 'initialization' stamp: 'GR 6/24/2021 16:50:17'!
initializeAcceptingItemsOf: aCatalog for: aCustomer 

	catalog := aCatalog.
	items := OrderedCollection new.
	owner := aCustomer .! !


!Cart methodsFor: 'queries' stamp: 'GR 6/23/2021 17:22:02'!
listItems
	^items! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'GR 6/24/2021 16:50:28'!
owner

	^owner ! !


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

!Cart class methodsFor: 'instance creation' stamp: 'GR 6/24/2021 16:32:28'!
acceptingItemsOf: aCatalog for: aCustomer 

	^self new initializeAcceptingItemsOf: aCatalog for: aCustomer ! !


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

!Cashier methodsFor: 'checkout - private' stamp: 'GR 6/24/2021 05:52:14'!
createSale

	^ Sale of: cart listItems totaling: total
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
	instanceVariableNames: 'expiration number owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'GR 6/24/2021 02:20:25'!
initializeExpiringOn: aMonth numbered: aCardNumber ownedBy: aName   
	
	expiration := aMonth.
	number := aCardNumber.
	owner := aName.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'GR 6/24/2021 02:31:59'!
expiringOn: aMonth numbered: aCardNumber ownedBy: aName   

	self assertNameIsValid: aName.
	self assertCardIsValid: aCardNumber.
	
	^self new initializeExpiringOn: aMonth numbered: aCardNumber ownedBy: aName! !


!CreditCard class methodsFor: 'assertions' stamp: 'GR 6/24/2021 02:35:05'!
assertCardIsValid: aCardNumber

	((aCardNumber numberOfDigitsInBase: 10) = 16) ifFalse: [self error: self invalidCardNumberErrorDescription].! !

!CreditCard class methodsFor: 'assertions' stamp: 'GR 6/24/2021 02:50:13'!
assertNameIsValid: aName

	(aName withBlanksTrimmed) isEmpty ifTrue: [self error: self nameIsEmptyErrorDescription].
	(aName size > 30) ifTrue: [self error: self nameTooLongErrorDescription].! !


!CreditCard class methodsFor: 'error descriptions' stamp: 'GR 6/24/2021 02:34:58'!
invalidCardNumberErrorDescription

	^'Card number must be 16 digits long'! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'GR 6/24/2021 02:30:34'!
nameIsEmptyErrorDescription

	^'Name cannot be empty'! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'GR 6/24/2021 02:31:16'!
nameTooLongErrorDescription

	^'Name cannot be more than thirty characters long'! !


!classDefinition: #Customer category: 'TusLibros'!
Object subclass: #Customer
	instanceVariableNames: 'carts purchases id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Customer methodsFor: 'as yet unclassified' stamp: 'GR 6/24/2021 16:55:47'!
initialize

	purchases := SaleList new.! !

!Customer methodsFor: 'as yet unclassified' stamp: 'GR 6/24/2021 16:51:15'!
purchases 

	^purchases ! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'accessing' stamp: 'GR 6/24/2021 05:55:20'!
items

	^items.! !

!Sale methodsFor: 'accessing' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'GR 6/24/2021 05:55:06'!
initializeOf: aListOfItems totaling: aTotal

	total := aTotal .
	items := aListOfItems .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'error messages' stamp: 'GR 6/24/2021 05:49:02'!
totalIsNotPositiveErrorDescription

	^'Sale total must be greater than zero'.! !


!Sale class methodsFor: 'assertions' stamp: 'GR 6/24/2021 05:48:39'!
assertTotalIsPositive: aTotal

	(aTotal > 0) ifFalse: [self error: self totalIsNotPositiveErrorDescription]! !


!Sale class methodsFor: 'instance creation' stamp: 'GR 6/24/2021 05:54:19'!
of: aListOfItems totaling: aTotal

	"should assert total is not negative or 0!!"
	self assertTotalIsPositive: aTotal.
	^self new initializeOf: aListOfItems totaling: aTotal ! !


!classDefinition: #SaleList category: 'TusLibros'!
Object subclass: #SaleList
	instanceVariableNames: 'items total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SaleList methodsFor: 'accessing' stamp: 'GR 6/24/2021 06:28:48'!
items

	^items .! !

!SaleList methodsFor: 'accessing' stamp: 'GR 6/24/2021 06:30:15'!
size

	^items size! !

!SaleList methodsFor: 'accessing' stamp: 'GR 6/24/2021 06:28:40'!
total

	^total! !


!SaleList methodsFor: 'operations' stamp: 'GR 6/24/2021 16:13:35'!
add: aSale

	items addAll: aSale items.
	total := total + aSale total.! !


!SaleList methodsFor: 'initialization' stamp: 'GR 6/24/2021 06:22:30'!
initialize

	items := Bag new.
	total := 0.! !


!classDefinition: #Store category: 'TusLibros'!
Object subclass: #Store
	instanceVariableNames: 'catalog lastCart carts authenticator clock timeCreated cartCreation salesBook merchantProcessor cartOwners customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Store methodsFor: 'initialization' stamp: 'GR 6/24/2021 16:55:12'!
initializeWithCatalog: aCatalog authenticator: anAuthenticator merchantProcessor: anMP andClock: aClock .
	
	lastCart := 0.
	carts := Dictionary new.
	cartCreation := Dictionary new.
	
	customers := Dictionary new.
	
	catalog := aCatalog.
	authenticator := anAuthenticator.
	merchantProcessor := anMP.
	clock := aClock .! !


!Store methodsFor: 'assertions' stamp: 'GR 6/24/2021 06:13:34'!
assertValidLoginFor: aUserID using: aPassword

	(authenticator check: aUserID with: aPassword) ifFalse: [self error: self class invalidLoginErrorDescription ].! !


!Store methodsFor: 'accessing - private' stamp: 'GR 6/24/2021 04:17:42'!
getCartFromID: aCartID

	|creationTime|
	
	creationTime := cartCreation at: aCartID ifAbsent: [self error: self class invalidCartIDErrorDescription ].
	((clock time) - creationTime < 30 minutes) ifFalse: [self error: self class cartLifespanExceededErrorMessage ].

	^carts at: aCartID ifAbsent: [self error: self class invalidCartIDErrorDescription ].! !


!Store methodsFor: 'operations' stamp: 'GR 6/24/2021 04:18:31'!
addToCart: aCartID bookISBN: anISBN bookQuantity: aQuantity
	|cart|
	
	cart := self getCartFromID: aCartID .
	
	cart add: aQuantity of: anISBN.! !

!Store methodsFor: 'operations' stamp: 'GR 6/24/2021 16:52:52'!
checkOutCart: aCartID usingCardNumbered: aCardNumber expiringOn: aMonthOfYear ownedBy: aName
	|cashier creditCard cart clientSalesBook |
	
	cart := self getCartFromID: aCartID .
		
	creditCard := CreditCard expiringOn: aMonthOfYear numbered: aCardNumber ownedBy: aName.
	
	clientSalesBook := cart owner purchases .
	
	cashier := Cashier 
		toCheckout: cart
		charging: creditCard 
		throught: merchantProcessor 
		on: clock today
		registeringOn: clientSalesBook .
		
	cashier checkOut.
	
	^aCartID.! !

!Store methodsFor: 'operations' stamp: 'GR 6/24/2021 16:56:43'!
createCartForClientID: aUserID withPassword: aPassword
	
	|customer|
	self assertValidLoginFor: aUserID using: aPassword .
	customer := customers at: aUserID ifAbsentPut: [Customer new].

	lastCart := lastCart + 1.
	carts at: lastCart put: (Cart acceptingItemsOf: catalog for: customer).
	cartCreation at: lastCart put: clock time.
	
	^lastCart.! !

!Store methodsFor: 'operations' stamp: 'GR 6/24/2021 06:23:27'!
listCart: aCartID
	| cart |
	
	cart := self getCartFromID: aCartID .

	^cart listItems asBag.
	! !

!Store methodsFor: 'operations' stamp: 'GR 6/24/2021 16:59:56'!
listPurchasesFrom: aUserID using: aPassword

	|customer|

	self assertValidLoginFor: aUserID using: aPassword .
	
	customer := customers at: aUserID ifAbsent:[^SaleList new.].
	
	^customer purchases
	
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Store class' category: 'TusLibros'!
Store class
	instanceVariableNames: ''!

!Store class methodsFor: 'instance creation' stamp: 'GR 6/24/2021 06:01:38'!
withCatalog: aCatalog authenticator: anAuthenticator merchantProcessor: anMP andClock: aClock  

	^self new initializeWithCatalog: aCatalog authenticator: anAuthenticator merchantProcessor: anMP andClock: aClock.! !


!Store class methodsFor: 'error messages' stamp: 'GR 6/24/2021 03:10:42'!
cartLifespanExceededErrorMessage

	^'Cart was created more than 30 minutes ago'! !

!Store class methodsFor: 'error messages' stamp: 'GR 6/23/2021 19:00:20'!
invalidCartIDErrorDescription

	^'Cart ID not existent'! !

!Store class methodsFor: 'error messages' stamp: 'GR 6/23/2021 18:54:25'!
invalidLoginErrorDescription

	^'Invalid user or password'! !


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


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'GR 6/24/2021 16:58:26'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog for: self createCustomer .! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'GR 6/24/2021 02:44:53'!
emptyNameCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1) numbered: 1234567812345678 ownedBy: '   '! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'GR 6/24/2021 02:14:09'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1) numbered: 1234567812345678 ownedBy: 'Jose Hernandez'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'GR 6/24/2021 02:39:25'!
invalidNumberCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1) numbered: 12342345678 ownedBy: 'Jose Hernandez'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'GR 6/24/2021 02:45:43'!
nameTooLongCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1) numbered: 1234567812345678 ownedBy: '1234567890123456789012345678901'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'GR 6/24/2021 02:14:09'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1) numbered: 1234567812345678 ownedBy: 'Jose Hernandez'! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'GR 6/24/2021 03:27:20'!
initialize

	today := DateAndTime now.! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'GR 6/24/2021 05:22:39'!
futureMonthOfYear

	^Month month: today monthIndex year: today yearNumber + 1

	! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'store' stamp: 'GR 6/24/2021 06:00:41'!
defaultStoreForTest: aTest

	^Store withCatalog: self defaultCatalog  authenticator: aTest merchantProcessor: aTest andClock: aTest.! !


!StoreTestObjectsFactory methodsFor: 'customer' stamp: 'GR 6/24/2021 16:58:38'!
createCustomer

	^Customer new.! !
