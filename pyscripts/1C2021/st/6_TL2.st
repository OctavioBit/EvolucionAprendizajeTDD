!classDefinition: #TusLibrosTest category: 'TusLibros'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'cashier tests' stamp: 'LB 6/14/2021 19:54:18'!
test01CheckoutOfEmptyCartShouldRaiseError
	|cart cashier creditCard salesBook|
	cart := TusLibrosTestsSupport createCart.
	cashier := TusLibrosTestsSupport createCashier.
	creditCard := TusLibrosTestsSupport createCreditCard.
	salesBook := TusLibrosTestsSupport createSalesBook.
	
	self should: [cashier checkout: cart withCard: creditCard onDate: TusLibrosTestsSupport today registerOn: salesBook processWith: TusLibrosTestsSupport createMerchantProcessor] 
		raise: Error-MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart cantCheckoutEmptyCartError].
		
	self assert: salesBook isEmpty.
	! !

!TusLibrosTest methodsFor: 'cashier tests' stamp: 'LB 6/14/2021 19:50:37'!
test02CheckoutOf1ProductShouldReturnProductPrice
	|cart cashier total creditCard|
	cart := TusLibrosTestsSupport createCart.
	cashier := TusLibrosTestsSupport createCashier.
	creditCard := TusLibrosTestsSupport createCreditCard.
	
	cart add: TusLibrosTestsSupport itemSellByTheStore.
	total := cashier checkout: cart withCard: creditCard onDate: TusLibrosTestsSupport today registerOn: TusLibrosTestsSupport createSalesBook processWith: TusLibrosTestsSupport createMerchantProcessor.
	
	self assert: total equals: (TusLibrosTestsSupport itemSellByTheStorePrice).! !

!TusLibrosTest methodsFor: 'cashier tests' stamp: 'LB 6/14/2021 19:50:37'!
test03CheckoutOfMultipleProductsShouldReturnTotal
	|cart cashier total expectedTotal creditCard|
	cart := TusLibrosTestsSupport createCheckoutCart.
	cashier := TusLibrosTestsSupport createCashier.
	creditCard := TusLibrosTestsSupport createCreditCard.
	
	total := cashier checkout: cart withCard: creditCard onDate: TusLibrosTestsSupport today registerOn: TusLibrosTestsSupport createSalesBook processWith: TusLibrosTestsSupport createMerchantProcessor.
	expectedTotal := TusLibrosTestsSupport itemSellByTheStorePrice * 2 + TusLibrosTestsSupport item2SellByTheStorePrice.
	
	self assert: total equals: expectedTotal.! !

!TusLibrosTest methodsFor: 'cashier tests' stamp: 'LB 6/14/2021 19:50:37'!
test04ExpiredCreditCardShouldRaiseError
	|cart cashier creditCard|
	cart := TusLibrosTestsSupport createCheckoutCart.
	creditCard := TusLibrosTestsSupport createExpiredCreditCard.
	cashier := TusLibrosTestsSupport createCashier.
	
	self should: [cashier checkout: cart withCard: creditCard onDate: TusLibrosTestsSupport today registerOn: TusLibrosTestsSupport createSalesBook processWith: TusLibrosTestsSupport createMerchantProcessor]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			anError messageText = Cashier expiredCreditCardErrorMessage]
		! !

!TusLibrosTest methodsFor: 'cashier tests' stamp: 'LB 6/14/2021 20:02:50'!
test05CashierRegisteresASingleSell
	|cart cashier creditCard salesBook |
	cart := TusLibrosTestsSupport createCheckoutCart.
	cashier := TusLibrosTestsSupport createCashier.
	creditCard := TusLibrosTestsSupport createCreditCard.
	salesBook := TusLibrosTestsSupport createSalesBook.
	
	cashier checkout: cart withCard: creditCard onDate: TusLibrosTestsSupport today registerOn: salesBook processWith: TusLibrosTestsSupport createMerchantProcessor.
	
	self assert: (salesBook includes: (Association key: cart value: creditCard)).
		! !

!TusLibrosTest methodsFor: 'cashier tests' stamp: 'LB 6/14/2021 20:02:54'!
test06CashierRegistersItsSells
	|cart cart2 cashier creditCard salesBook|
	cart := TusLibrosTestsSupport createCheckoutCart.
	cart2 := TusLibrosTestsSupport createCheckoutCart.
	cashier := TusLibrosTestsSupport createCashier.
	creditCard := TusLibrosTestsSupport createCreditCard.
	salesBook := TusLibrosTestsSupport createSalesBook.
	
	cashier checkout: cart withCard: creditCard onDate: TusLibrosTestsSupport today registerOn: salesBook processWith: TusLibrosTestsSupport createMerchantProcessor.
	cashier checkout: cart2 withCard: creditCard onDate: TusLibrosTestsSupport today registerOn: salesBook processWith: TusLibrosTestsSupport createMerchantProcessor.
	
	self assert: (salesBook includes: (Association key: cart value: creditCard)).
	self assert: (salesBook includes: (Association key: cart2 value: creditCard)).
		! !

!TusLibrosTest methodsFor: 'cashier tests' stamp: 'LB 6/17/2021 14:57:49'!
test07CreditCardWithNoCreditShouldRaiseError
	|cart cashier creditCard salesBook|
	cart := TusLibrosTestsSupport createCheckoutCart.
	cashier := TusLibrosTestsSupport createCashier.
	creditCard := TusLibrosTestsSupport createCreditCardWithNoCredit.
	salesBook := TusLibrosTestsSupport createSalesBook.
	
	self should:  [cashier checkout: cart withCard: creditCard onDate: TusLibrosTestsSupport today registerOn: salesBook processWith: TusLibrosTestsSupport createMerchantProcessor]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			anError messageText = MerchantProcessorSimulator paymentFailureErrorMessage].
		
	self assert: salesBook isEmpty.! !

!TusLibrosTest methodsFor: 'cashier tests' stamp: 'LB 6/17/2021 14:57:49'!
test08StolenCreditCardShouldRaiseError
	|cart cashier creditCard salesBook|
	cart := TusLibrosTestsSupport createCheckoutCart.
	cashier := TusLibrosTestsSupport createCashier.
	creditCard := TusLibrosTestsSupport createStolenCreditCard.
	salesBook := TusLibrosTestsSupport createSalesBook.
	
	self should:  [cashier checkout: cart withCard: creditCard onDate: TusLibrosTestsSupport today registerOn: salesBook processWith: TusLibrosTestsSupport createMerchantProcessor.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			anError messageText = MerchantProcessorSimulator paymentFailureErrorMessage].
		
	self assert: salesBook isEmpty.! !

!TusLibrosTest methodsFor: 'cashier tests' stamp: 'LB 6/17/2021 14:57:49'!
test09FakeCreditCardShouldRaiseError
	|cart cashier creditCard salesBook|
	cart := TusLibrosTestsSupport createCheckoutCart.
	cashier := TusLibrosTestsSupport createCashier.
	creditCard := TusLibrosTestsSupport createFakeCreditCard.
	salesBook := TusLibrosTestsSupport createSalesBook.
	
	self should:  [cashier checkout: cart withCard: creditCard onDate: TusLibrosTestsSupport today registerOn: salesBook processWith: TusLibrosTestsSupport createMerchantProcessor.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			anError messageText = MerchantProcessorSimulator paymentFailureErrorMessage].
		
	self assert: salesBook isEmpty.! !


!TusLibrosTest methodsFor: 'cart tests' stamp: 'LB 6/14/2021 19:16:04'!
test01NewCartsAreCreatedEmpty

	self assert: TusLibrosTestsSupport createCart isEmpty! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'LB 6/14/2021 19:16:04'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := TusLibrosTestsSupport createCart.
	
	self 
		should: [ cart add: TusLibrosTestsSupport itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'LB 6/14/2021 19:16:04'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := TusLibrosTestsSupport createCart.
	
	cart add: TusLibrosTestsSupport itemSellByTheStore.
	self deny: cart isEmpty ! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'LB 6/14/2021 19:16:04'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := TusLibrosTestsSupport createCart.
	
	self 
		should: [cart add: 0 of: TusLibrosTestsSupport itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'LB 6/14/2021 19:16:04'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := TusLibrosTestsSupport createCart.
	
	self 
		should: [cart add: 2 of: TusLibrosTestsSupport itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'LB 6/14/2021 19:16:04'!
test06CartRemembersAddedItems

	| cart |
	
	cart := TusLibrosTestsSupport createCart.
	
	cart add: TusLibrosTestsSupport itemSellByTheStore.
	self assert: (cart includes: TusLibrosTestsSupport itemSellByTheStore)! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'LB 6/14/2021 19:16:04'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := TusLibrosTestsSupport createCart.
	
	self deny: (cart includes: TusLibrosTestsSupport itemSellByTheStore)! !

!TusLibrosTest methodsFor: 'cart tests' stamp: 'LB 6/14/2021 19:16:04'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := TusLibrosTestsSupport createCart.
	
	cart add: 2 of: TusLibrosTestsSupport itemSellByTheStore.
	self assert: (cart occurrencesOf: TusLibrosTestsSupport itemSellByTheStore) = 2! !


!TusLibrosTest methodsFor: 'credit card tests' stamp: 'LB 6/14/2021 19:16:04'!
test01CreditCardWithInvalidNumberLongitudShouldRaiseError
	
	self should: [TusLibrosTestsSupport createInvalidNumberLongitudCreditCard]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			anError messageText = CreditCardData invalidCreditCardErrorMessage]
		! !

!TusLibrosTest methodsFor: 'credit card tests' stamp: 'LB 6/14/2021 19:16:04'!
test02CreditCardWithInvalidNameLongitudShouldRaiseError

	self should: [TusLibrosTestsSupport createInvalidNameLongitudCreditCard.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			anError messageText = CreditCardData invalidCreditCardErrorMessage]
		! !

!TusLibrosTest methodsFor: 'credit card tests' stamp: 'LB 6/14/2021 19:16:04'!
test03CreditCardWithInvalidNameCharactersShouldRaiseError

	self should: [TusLibrosTestsSupport createInvalidNameCreditCard.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			anError messageText = CreditCardData invalidCreditCardErrorMessage]! !

!TusLibrosTest methodsFor: 'credit card tests' stamp: 'LB 6/14/2021 19:16:04'!
test04CreditCardWithInvalidNumberShouldRaiseError
	
	self should: [TusLibrosTestsSupport createInvalidNumberCreditCard]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			anError messageText = CreditCardData invalidCreditCardErrorMessage]
		! !

!TusLibrosTest methodsFor: 'credit card tests' stamp: 'LB 6/14/2021 19:16:04'!
test05CreditCardWithInvalidDateShouldRaiseError
	
	self should: [TusLibrosTestsSupport createInvalidDateCreditCard]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			anError messageText = CreditCardData invalidCreditCardErrorMessage]
		! !

!TusLibrosTest methodsFor: 'credit card tests' stamp: 'LB 6/14/2021 19:16:04'!
test06CreditCardWithSpacesAsNameShouldRaiseError
	
	self should: [TusLibrosTestsSupport createSpacesAsNameCreditCard]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			anError messageText = CreditCardData invalidCreditCardErrorMessage]
		! !


!classDefinition: #TusLibrosTestsSupport category: 'TusLibros'!
TestCase subclass: #TusLibrosTestsSupport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosTestsSupport class' category: 'TusLibros'!
TusLibrosTestsSupport class
	instanceVariableNames: ''!

!TusLibrosTestsSupport class methodsFor: 'cart' stamp: 'LB 6/13/2021 12:00:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!TusLibrosTestsSupport class methodsFor: 'cart' stamp: 'LB 6/13/2021 12:00:08'!
createCheckoutCart
	|checkoutCart|
	checkoutCart := self createCart.
	checkoutCart add: 2 of: self itemSellByTheStore.
	checkoutCart add: self item2SellByTheStore.
	^checkoutCart! !

!TusLibrosTestsSupport class methodsFor: 'cart' stamp: 'LB 6/13/2021 12:00:08'!
defaultCatalog
	|catalog|
	catalog := Dictionary new.
	catalog at: self itemSellByTheStore 	put: self itemSellByTheStorePrice.
	catalog at: self item2SellByTheStore 	put: self item2SellByTheStorePrice.
	^ catalog! !

!TusLibrosTestsSupport class methodsFor: 'cart' stamp: 'LB 6/13/2021 12:00:08'!
item2SellByTheStore
	^'El libro de bruno'.! !

!TusLibrosTestsSupport class methodsFor: 'cart' stamp: 'LB 6/13/2021 12:00:08'!
item2SellByTheStorePrice
	^20! !

!TusLibrosTestsSupport class methodsFor: 'cart' stamp: 'LB 6/13/2021 12:00:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!TusLibrosTestsSupport class methodsFor: 'cart' stamp: 'LB 6/13/2021 12:00:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!TusLibrosTestsSupport class methodsFor: 'cart' stamp: 'LB 6/13/2021 12:00:08'!
itemSellByTheStorePrice
	^50! !


!TusLibrosTestsSupport class methodsFor: 'cashier' stamp: 'LB 6/14/2021 19:51:23'!
createCashier

	^Cashier new.! !

!TusLibrosTestsSupport class methodsFor: 'cashier' stamp: 'LB 6/14/2021 19:51:03'!
createMerchantProcessor
	^MerchantProcessorSimulator new.! !

!TusLibrosTestsSupport class methodsFor: 'cashier' stamp: 'LB 6/14/2021 19:13:29'!
createSalesBook

	^OrderedCollection new.! !


!TusLibrosTestsSupport class methodsFor: 'credit card' stamp: 'LB 6/13/2021 12:00:08'!
createCreditCard
	^ CreditCardData withNumber: '1234567891234567' withExpirationDate: self nextYear withOwner: 'Roberto the Owner'
	! !

!TusLibrosTestsSupport class methodsFor: 'credit card' stamp: 'LB 6/13/2021 12:00:08'!
createCreditCardWithNoCredit
	^ CreditCardData withNumber: '1111111111111111' withExpirationDate: self nextYear withOwner: 'Soy una tarjeta sin credito'! !

!TusLibrosTestsSupport class methodsFor: 'credit card' stamp: 'LB 6/13/2021 12:00:08'!
createExpiredCreditCard
	
	^ CreditCardData withNumber: '1234567891234567' withExpirationDate: self lastYear withOwner: 'Roberto the Owner'
	! !

!TusLibrosTestsSupport class methodsFor: 'credit card' stamp: 'LB 6/13/2021 12:00:08'!
createFakeCreditCard
	
	^ CreditCardData withNumber: '3333333333333333' withExpirationDate: self lastYear withOwner: 'Roberto the scammer'
	! !

!TusLibrosTestsSupport class methodsFor: 'credit card' stamp: 'LB 6/13/2021 12:11:48'!
createInvalidDateCreditCard
	^ CreditCardData withNumber: '1234567891234567' withExpirationDate: 'falsa fecha' withOwner: 'Roberto the Owner'
	! !

!TusLibrosTestsSupport class methodsFor: 'credit card' stamp: 'LB 6/14/2021 18:48:33'!
createInvalidNameCreditCard
	
	^ CreditCardData withNumber: '1234567891234567' withExpirationDate: self nextYear withOwner: 'I am an invalid {name}'.
	! !

!TusLibrosTestsSupport class methodsFor: 'credit card' stamp: 'LB 6/13/2021 12:00:08'!
createInvalidNameLongitudCreditCard
	
	^ CreditCardData withNumber: '1234567891234567' withExpirationDate: self nextYear withOwner: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum'.
	! !

!TusLibrosTestsSupport class methodsFor: 'credit card' stamp: 'LB 6/13/2021 12:00:08'!
createInvalidNumberCreditCard
	
	^ CreditCardData withNumber: '1234abcd1234[]{}' withExpirationDate: self nextYear withOwner: 'Roberto the Owner'
	! !

!TusLibrosTestsSupport class methodsFor: 'credit card' stamp: 'LB 6/13/2021 12:00:08'!
createInvalidNumberLongitudCreditCard
	
	^ CreditCardData withNumber: '1234' withExpirationDate: self nextYear withOwner: 'Roberto the Owner'
	! !

!TusLibrosTestsSupport class methodsFor: 'credit card' stamp: 'LB 6/14/2021 18:49:35'!
createSpacesAsNameCreditCard
	
	^ CreditCardData withNumber: '1234567891234567' withExpirationDate: self nextYear withOwner: '                '.
	! !

!TusLibrosTestsSupport class methodsFor: 'credit card' stamp: 'LB 6/13/2021 12:00:08'!
createStolenCreditCard
	
	^ CreditCardData withNumber: '2222222222222222' withExpirationDate: self lastYear withOwner: 'Roberto the thief'
	! !


!TusLibrosTestsSupport class methodsFor: 'date' stamp: 'LB 6/13/2021 12:00:08'!
lastYear
	^self today previousMonth: (self today month).! !

!TusLibrosTestsSupport class methodsFor: 'date' stamp: 'LB 6/13/2021 12:00:08'!
nextYear
	^self today nextMonth: (self today month).! !

!TusLibrosTestsSupport class methodsFor: 'date' stamp: 'LB 6/13/2021 12:00:08'!
today
	^GregorianMonthOfYear current.! !


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

!Cashier methodsFor: 'checkout' stamp: 'LB 6/14/2021 19:52:32'!
checkout: aCart withCard: aCreditCard onDate: date registerOn: salesBook processWith: aMerchantProcessor    
	|total|
	(aCreditCard isExpiredOn: date) ifTrue: [^ self error: self class expiredCreditCardErrorMessage].
	total := aCart checkoutTotal.
	aMerchantProcessor makeTransactionWith: aCreditCard for: total.
	salesBook add: (Association key: aCart value: aCreditCard).
	^total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error' stamp: 'LB 6/10/2021 20:53:14'!
expiredCreditCardErrorMessage
	^'Error: credit card is expired'.! !


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
