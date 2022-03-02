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

!CashierTest methodsFor: 'tests' stamp: 'FC 12/2/2020 16:36:44'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook withBuyer: testObjectsFactory defaultUser]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'FC 12/2/2020 16:36:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new withBuyer: testObjectsFactory defaultUser.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'FC 12/2/2020 16:36:55'!
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
				registeringOn: salesBook withBuyer: testObjectsFactory defaultUser ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'FC 12/2/2020 16:36:59'!
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
		registeringOn: salesBook withBuyer: testObjectsFactory defaultUser.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'FC 12/2/2020 16:37:06'!
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
		registeringOn: salesBook withBuyer: testObjectsFactory defaultUser.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'FC 12/2/2020 16:37:15'!
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
		registeringOn: salesBook withBuyer: testObjectsFactory defaultUser.
		
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


!classDefinition: #TusLibrosInterfaceTest category: 'TusLibros'!
TestCase subclass: #TusLibrosInterfaceTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInterfaceTest methodsFor: 'merchant processor protocol' stamp: 'FC 11/29/2020 17:33:58'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'FC 11/30/2020 18:39:35'!
test01InterfaceCreatesEmptyCart
	
	|cartId tusLibros|
	
	tusLibros := TusLibrosInterface 
				forCatalog: (testObjectsFactory defaultCatalog) 
				withUsers: (testObjectsFactory defaultUsers) 
				through: self 
				on: (TimeSimulator startingAt: testObjectsFactory today) 
				registeringOn: OrderedCollection new.
	
	cartId := tusLibros createCartForUser: 'validUser' withPassword: 'asasas'.
	
	self assert: (tusLibros listCartForId: cartId) isEmpty.! !

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'FC 11/30/2020 18:41:07'!
test02CanNotCreateCartWithInvalidPassword
	
	|tusLibros|
	
	tusLibros := TusLibrosInterface 
				forCatalog: (testObjectsFactory defaultCatalog) 
				withUsers: (testObjectsFactory defaultUsers) 
				through: self 
				on: (TimeSimulator startingAt: testObjectsFactory today) 
				registeringOn: OrderedCollection new.
	
	self should: [tusLibros createCartForUser: 'validUser' withPassword: 'a'] raise: Error withMessageText: TusLibrosInterface invalidPasswordMessage.
	
 	
! !

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'FC 11/30/2020 18:41:16'!
test03CanNotCreateCartWithInvalidUsername
	
	|tusLibros|
	
	tusLibros := TusLibrosInterface 
				forCatalog: (testObjectsFactory defaultCatalog) 
				withUsers: (testObjectsFactory defaultUsers) 
				through: self 
				on: (TimeSimulator startingAt: testObjectsFactory today) 
				registeringOn: OrderedCollection new.
	
	self should: [tusLibros createCartForUser: 'a' withPassword: 'a'] raise: Error withMessageText: TusLibrosInterface invalidUserMessage.
	
 	
! !

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'FC 11/30/2020 18:41:22'!
test04InterfaceListsOneItem
	
	|cartId tusLibros|
	
	tusLibros := TusLibrosInterface 
				forCatalog: (testObjectsFactory defaultCatalog) 
				withUsers: (testObjectsFactory defaultUsers) 
				through: self 
				on: (TimeSimulator startingAt: testObjectsFactory today) 
				registeringOn: OrderedCollection new.
	
	cartId := tusLibros createCartForUser: 'validUser' withPassword: 'asasas'.
	
	tusLibros addToCart: 1 of: (testObjectsFactory itemSellByTheStore) forId: cartId.
	
	self assert: (tusLibros listCartForId: cartId) includes: testObjectsFactory itemSellByTheStore .! !

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'FC 11/30/2020 18:41:26'!
test06CanNotListInvalidCart
	
	|tusLibros|
	
	tusLibros := TusLibrosInterface 
				forCatalog: (testObjectsFactory defaultCatalog) 
				withUsers: (testObjectsFactory defaultUsers) 
				through: self 
				on: (TimeSimulator startingAt: testObjectsFactory today) 
				registeringOn: OrderedCollection new.
	
	self should: [tusLibros listCartForId: 1] raise: Error withMessageText: TusLibrosInterface cartNotFoundMessage.! !

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'FC 11/30/2020 18:41:30'!
test07CanNotAddToInvalidCart
	
	|tusLibros|
	
	tusLibros := TusLibrosInterface 
				forCatalog: (testObjectsFactory defaultCatalog) 
				withUsers: (testObjectsFactory defaultUsers) 
				through: self 
				on: (TimeSimulator startingAt: testObjectsFactory today) 
				registeringOn: OrderedCollection new.
	
	
	self should: [tusLibros addToCart: 1 of: testObjectsFactory itemNotSellByTheStore forId: 1] raise: Error withMessageText: TusLibrosInterface cartNotFoundMessage.! !

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'FC 11/30/2020 18:41:35'!
test08CheckOutReturnsTotal
	
	|cartId tusLibros total |
	
	tusLibros := TusLibrosInterface 
				forCatalog: (testObjectsFactory defaultCatalog) 
				withUsers: (testObjectsFactory defaultUsers) 
				through: self 
				on: (TimeSimulator startingAt: testObjectsFactory today) 
				registeringOn: OrderedCollection new.
	
	cartId := tusLibros createCartForUser: 'validUser' withPassword: 'asasas'.
	
	tusLibros addToCart: 1 of: (testObjectsFactory itemSellByTheStore) forId: cartId.
	
	total := tusLibros checkOutCartId: cartId payingWith: testObjectsFactory notExpiredCreditCard.
	
	self assert: total equals: testObjectsFactory itemSellByTheStorePrice.! !

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'FC 11/30/2020 19:38:07'!
test09CanNotOperateWithExpiredCart
	
	|cartId tusLibros aTimeSimulator |
	
	aTimeSimulator := TimeSimulator startingAt: testObjectsFactory today.
	tusLibros := TusLibrosInterface 
				forCatalog: (testObjectsFactory defaultCatalog) 
				withUsers: (testObjectsFactory defaultUsers) 
				through: self 
				on: (aTimeSimulator) 
				registeringOn: OrderedCollection new.
	
	cartId := tusLibros createCartForUser: 'validUser' withPassword: 'asasas'.
	
	aTimeSimulator passMinutes: 31.
	
	self should: [tusLibros listCartForId: cartId] raise: Error withMessageText: TusLibrosInterface sessionExpiredMessage.! !

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'FC 11/30/2020 19:37:49'!
test10ExpirationTimeRefreshesAfterUse
	
	|cartId tusLibros aTimeSimulator |
	
	aTimeSimulator := TimeSimulator startingAt: testObjectsFactory today.
	tusLibros := TusLibrosInterface 
				forCatalog: (testObjectsFactory defaultCatalog) 
				withUsers: (testObjectsFactory defaultUsers) 
				through: self 
				on: (aTimeSimulator) 
				registeringOn: OrderedCollection new.
	
	cartId := tusLibros createCartForUser: 'validUser' withPassword: 'asasas'.
	
	aTimeSimulator passMinutes: 28.
	
	tusLibros listCartForId: cartId.
	
	aTimeSimulator passMinutes: 3.
	
	self assert: (tusLibros listCartForId: cartId) isEmpty.! !

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'FC 12/2/2020 16:58:31'!
test11listPurchasesListsPurchasesCorrectly
	
	|cartId tusLibros total purchases |
	
	tusLibros := TusLibrosInterface 
				forCatalog: (testObjectsFactory defaultCatalog) 
				withUsers: (testObjectsFactory defaultUsers) 
				through: self 
				on: (TimeSimulator startingAt: testObjectsFactory today) 
				registeringOn: OrderedCollection new.
	
	cartId := tusLibros createCartForUser: 'validUser' withPassword: 'asasas'.
	
	tusLibros addToCart: 1 of: (testObjectsFactory itemSellByTheStore) forId: cartId.
	
	total := tusLibros checkOutCartId: cartId payingWith: testObjectsFactory notExpiredCreditCard.
	
	purchases := tusLibros listPurchasesFor: 'validUser' withPassword: 'asasas'.
	
	self assert: purchases total equals: total.
	self assert: purchases items includes: testObjectsFactory itemSellByTheStore.! !


!TusLibrosInterfaceTest methodsFor: 'setUp/tearDown' stamp: 'FC 11/29/2020 17:34:26'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


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


!Cart methodsFor: 'queries' stamp: 'FC 11/29/2020 16:58:29'!
items
	^items.! !

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
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total buyer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'FC 12/2/2020 16:41:51'!
createSale

	^ Sale of: total withBuyer: buyer buying: cart items
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


!Cashier methodsFor: 'initialization' stamp: 'FC 12/2/2020 16:38:57'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook withBuyer: aBuyer 
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook.
	buyer := aBuyer! !

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


!Cashier class methodsFor: 'instance creation' stamp: 'FC 12/2/2020 16:38:49'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook withBuyer: aBuyer 
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook withBuyer: aBuyer! !


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
	instanceVariableNames: 'expiration ownerName cardNumber'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'FC 12/2/2020 16:17:40'!
initializeWithOwner: aName withCCNumber: aCCNumber expiringOn: aMonth 
	
	expiration := aMonth.
	ownerName := aName.
	cardNumber := aCCNumber.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'FC 12/2/2020 16:19:29'!
emptyNameMessage
	^'Name can not be empty'.! !

!CreditCard class methodsFor: 'instance creation' stamp: 'FC 12/2/2020 16:19:25'!
invalidCardNumberMessage
	^'Card number is invalid'.! !

!CreditCard class methodsFor: 'instance creation' stamp: 'FC 12/2/2020 16:19:19'!
validateCardNumber: aCardNumber

	^ aCardNumber size < 16 ifTrue: [self error: self invalidCardNumberMessage ]! !

!CreditCard class methodsFor: 'instance creation' stamp: 'FC 12/2/2020 16:19:12'!
validateOwnerName: aName

	^ aName size = 0 ifTrue: [self error: self emptyNameMessage]! !

!CreditCard class methodsFor: 'instance creation' stamp: 'FC 12/2/2020 16:18:53'!
withOwner: aName withCCNumber: aCCNumber expiringOn: aMonth 
	self validateOwnerName: aName.
	self validateCardNumber: aCCNumber.
	^self new initializeWithOwner: aName withCCNumber: aCCNumber expiringOn: aMonth! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total buyer soldItems'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'FC 12/2/2020 16:43:55'!
buyer
	^ buyer! !

!Sale methodsFor: 'total' stamp: 'FC 12/2/2020 16:43:44'!
soldItems
	
	^ soldItems! !

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'FC 12/2/2020 16:42:26'!
initializeTotal: aTotal withBuyer: aBuyer buying: items

	total := aTotal. 
	buyer := aBuyer.
	soldItems := items.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'FC 12/2/2020 16:41:57'!
of: aTotal withBuyer: aBuyer buying: items  

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal withBuyer: aBuyer buying: items.! !


!classDefinition: #SalesSummary category: 'TusLibros'!
Object subclass: #SalesSummary
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SalesSummary methodsFor: 'initialization' stamp: 'FC 12/2/2020 16:50:42'!
initializeFor: aListOfItems withTotal: aTotal.
	items := aListOfItems.
	total := aTotal.! !


!SalesSummary methodsFor: 'accessing' stamp: 'FC 12/2/2020 16:51:49'!
items
	^items.! !

!SalesSummary methodsFor: 'accessing' stamp: 'FC 12/2/2020 16:50:54'!
total
	^total.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SalesSummary class' category: 'TusLibros'!
SalesSummary class
	instanceVariableNames: ''!

!SalesSummary class methodsFor: 'as yet unclassified' stamp: 'FC 12/2/2020 16:50:25'!
for: aListOfItems withTotal: aTotal.
	^self new initializeFor: aListOfItems withTotal: aTotal.! !


!classDefinition: #Session category: 'TusLibros'!
Object subclass: #Session
	instanceVariableNames: 'cart lastAccessTime buyer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Session methodsFor: 'testing' stamp: 'FC 11/30/2020 20:37:54'!
isExpiredAt: aDateTime
	^((aDateTime - lastAccessTime) > self expirationTime)! !


!Session methodsFor: 'accessing' stamp: 'FC 11/30/2020 20:39:28'!
accessedAt: aDateTime
	lastAccessTime := aDateTime.! !

!Session methodsFor: 'accessing' stamp: 'FC 12/2/2020 16:33:55'!
buyer
	^buyer! !

!Session methodsFor: 'accessing' stamp: 'FC 11/30/2020 20:26:54'!
cart
	^cart.! !

!Session methodsFor: 'accessing' stamp: 'FC 11/30/2020 20:37:03'!
expirationTime
	^ 30 minutes.! !


!Session methodsFor: 'initialization' stamp: 'FC 12/2/2020 16:33:29'!
initializeFor: aCart createdAt: aDateTime withBuyer: aBuyer 
	cart := aCart. 
	lastAccessTime := aDateTime.
	buyer := aBuyer.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Session class' category: 'TusLibros'!
Session class
	instanceVariableNames: ''!

!Session class methodsFor: 'instance creation' stamp: 'FC 12/2/2020 16:33:23'!
for: aCart createdAt: aDateTime withBuyer: aBuyer .
	^self new initializeFor: aCart createdAt: aDateTime withBuyer: aBuyer.! !


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


!StoreTestObjectsFactory methodsFor: 'authentication' stamp: 'FC 12/2/2020 16:36:24'!
defaultUser
	
	^'validUser'
! !

!StoreTestObjectsFactory methodsFor: 'authentication' stamp: 'FC 11/29/2020 16:55:29'!
defaultUsers
	
	| users |
	users := Dictionary new. 
	users add: ('validUser'->'asasas').
	^users! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'FC 12/2/2020 16:18:23'!
expiredCreditCard
	
	^CreditCard withOwner: 'Juan' withCCNumber: '4555123412346666' expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'FC 12/2/2020 16:18:23'!
notExpiredCreditCard
	
	^CreditCard withOwner: 'Juan' withCCNumber: '4555123412346666' expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!classDefinition: #TimeSimulator category: 'TusLibros'!
Object subclass: #TimeSimulator
	instanceVariableNames: 'currentDateTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TimeSimulator methodsFor: 'initialization' stamp: 'FC 11/30/2020 18:26:44'!
initializeStartingAt: aDateTime
	currentDateTime := aDateTime.! !

!TimeSimulator methodsFor: 'initialization' stamp: 'FC 11/30/2020 18:27:19'!
now
	^currentDateTime.! !

!TimeSimulator methodsFor: 'initialization' stamp: 'FC 11/30/2020 18:52:55'!
passMinutes: aTimeInMinutes.
	currentDateTime := currentDateTime + aTimeInMinutes minutes.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TimeSimulator class' category: 'TusLibros'!
TimeSimulator class
	instanceVariableNames: ''!

!TimeSimulator class methodsFor: 'instance creation' stamp: 'FC 11/30/2020 18:22:18'!
startingAt: aDateTime
	^self new initializeStartingAt: aDateTime.! !


!classDefinition: #TusLibrosInterface category: 'TusLibros'!
Object subclass: #TusLibrosInterface
	instanceVariableNames: 'catalog validUsers merchantProcessor lastId activeSessions salesBook currentDateTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInterface methodsFor: 'initialization' stamp: 'FC 12/2/2020 16:42:46'!
initializeForCatalog: aCatalog withUsers: registeredUsers through: aMerchantProcessor on: aDate registeringOn: aSalesBook  

	catalog := aCatalog.
	validUsers := registeredUsers.
	merchantProcessor := aMerchantProcessor.
	lastId  := 0.
	activeSessions := Dictionary new.
	salesBook := aSalesBook.
	currentDateTime := aDate.! !


!TusLibrosInterface methodsFor: 'accessing - private' stamp: 'FC 12/2/2020 16:56:23'!
getBuyerFor: aCartId
	
	self validateCart: aCartId.
	self updateSessionAccessTime: aCartId.
	^ (activeSessions at: aCartId) buyer! !

!TusLibrosInterface methodsFor: 'accessing - private' stamp: 'FC 12/2/2020 16:56:16'!
getCartAt: aCartId
	
	self validateCart: aCartId.
	self updateSessionAccessTime: aCartId.
	^ (activeSessions at: aCartId) cart! !

!TusLibrosInterface methodsFor: 'accessing - private' stamp: 'FC 11/29/2020 17:07:32'!
getNewId

	lastId := lastId +1.
	^lastId! !


!TusLibrosInterface methodsFor: 'cart' stamp: 'FC 11/29/2020 17:05:57'!
authenticateUser: aUsername withPassword: aPassword
	
	|actualPassword| 
	actualPassword := validUsers at: aUsername ifAbsent: [self error: self class invalidUserMessage].
	actualPassword = aPassword ifFalse: [self error: self class invalidPasswordMessage].! !

!TusLibrosInterface methodsFor: 'cart' stamp: 'FC 12/2/2020 16:32:35'!
createCartForUser: aUser withPassword: aPassword 
	
	| cartId |
	self authenticateUser: aUser withPassword: aPassword.
	
	cartId := self getNewId.

	activeSessions add: cartId->(Session for: self newCart createdAt: currentDateTime now withBuyer: aUser).
	
	^cartId.! !

!TusLibrosInterface methodsFor: 'cart' stamp: 'FC 11/30/2020 20:31:15'!
newCart

	^ Cart acceptingItemsOf: catalog! !


!TusLibrosInterface methodsFor: 'accessing' stamp: 'FC 11/29/2020 17:15:03'!
listCartForId: aCartId 
	
	|aCart|
	
	aCart := 	self getCartAt: aCartId.
	
	^aCart items.! !

!TusLibrosInterface methodsFor: 'accessing' stamp: 'FC 12/2/2020 16:57:13'!
listPurchasesFor: aUser withPassword: aPassword
	| userSales total itemsBought |
	self authenticateUser: aUser withPassword: aPassword.
	
	userSales := salesBook select: [ :aSale | aSale buyer = aUser ].
	
	total := userSales sum: [ :aSale | aSale total ] ifEmpty: [0].
	
	itemsBought := userSales inject: #()  into: [ :totalSales :aSale  | totalSales , aSale soldItems ].
	
	 ^SalesSummary for: itemsBought withTotal: total.! !


!TusLibrosInterface methodsFor: 'validation' stamp: 'FC 11/30/2020 20:41:53'!
validateCart: aCartId

	| session |
	session := activeSessions at: aCartId ifAbsent: [self error: self class cartNotFoundMessage].
	(session isExpiredAt: currentDateTime now) ifTrue: [
		self removeSession: aCartId.
		self error: self class sessionExpiredMessage ].
! !



!TusLibrosInterface methodsFor: 'session handling - private' stamp: 'FC 11/30/2020 20:43:41'!
removeSession: aCartId
	activeSessions removeKey: aCartId.! !

!TusLibrosInterface methodsFor: 'session handling - private' stamp: 'FC 11/30/2020 20:39:52'!
updateSessionAccessTime: aCartId

	^(activeSessions at: aCartId) accessedAt: currentDateTime now.! !


!TusLibrosInterface methodsFor: 'adding' stamp: 'FC 11/29/2020 17:14:35'!
addToCart: aQuantity of: aBook forId: aCartId
	
	| aCart |
	aCart := 	self getCartAt: aCartId.
	
	aCart add: aQuantity of: aBook.
	
	! !


!TusLibrosInterface methodsFor: 'checkOut' stamp: 'FC 12/2/2020 16:55:52'!
checkOutCartId: aCartId payingWith: aCreditCard 
	
	| cart cashier total buyer |
	cart := self getCartAt: aCartId.
	buyer := self getBuyerFor: aCartId.
	cashier := Cashier toCheckout: cart  charging: aCreditCard  throught: merchantProcessor  on: currentDateTime now registeringOn: salesBook withBuyer: buyer.
	
	total := cashier checkOut.
	
	self removeSession: aCartId.
	^total.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosInterface class' category: 'TusLibros'!
TusLibrosInterface class
	instanceVariableNames: ''!

!TusLibrosInterface class methodsFor: 'instance creation' stamp: 'FC 11/29/2020 17:33:18'!
forCatalog: aCatalog withUsers: registeredUsers through: aMerchantProcessor on: aDate registeringOn: aSalesBook  

	^self new initializeForCatalog: aCatalog withUsers: registeredUsers through: aMerchantProcessor on: aDate registeringOn: aSalesBook. ! !


!TusLibrosInterface class methodsFor: 'error' stamp: 'FC 11/29/2020 17:13:56'!
cartNotFoundMessage
	^'Cart not found'.! !

!TusLibrosInterface class methodsFor: 'error' stamp: 'FC 11/29/2020 17:00:49'!
invalidPasswordMessage
	^'Passwor is invalid'.! !

!TusLibrosInterface class methodsFor: 'error' stamp: 'FC 11/29/2020 17:02:23'!
invalidUserMessage
	^'User not found'.! !

!TusLibrosInterface class methodsFor: 'error' stamp: 'FC 11/30/2020 18:53:12'!
sessionExpiredMessage
	^'Session Expired'.! !


!TusLibrosInterface class methodsFor: 'constants' stamp: 'FC 11/30/2020 20:35:57'!
expirationTime

	^ 30 minutes! !
