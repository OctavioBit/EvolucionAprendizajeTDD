!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'sgs 6/16/2021 23:45:04'!
test01NewCartsAreCreatedEmpty

	self assert: (testObjects createCart) isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'sgs 6/16/2021 23:45:18'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjects createCart.
	
	self 
		should: [ cart add: testObjects itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'sgs 6/16/2021 23:45:23'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjects createCart.
	
	cart add: testObjects itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'sgs 6/16/2021 23:45:29'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjects createCart.
	
	self 
		should: [cart add: 0 of: testObjects itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'sgs 6/16/2021 23:45:35'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjects createCart.
	
	self 
		should: [cart add: 2 of: testObjects itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'sgs 6/16/2021 23:45:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjects createCart.
	
	cart add: testObjects itemSellByTheStore.
	self assert: (cart includes: testObjects itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'sgs 6/16/2021 23:45:52'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjects createCart.
	
	self deny: (cart includes: testObjects itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'sgs 6/16/2021 23:46:04'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjects createCart.
	
	cart add: 2 of: testObjects itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjects itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setUp' stamp: 'sgs 6/16/2021 23:43:53'!
setUp

	testObjects _ TestObject new.	
	
! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'MerchantProcessorSimulator testObjects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'test' stamp: 'sgs 6/16/2021 23:37:15'!
test01CheakOutWithEmptyCart
	|aCart aCashier salesBook |
	
	aCart _ testObjects createCart.
	aCashier _ Cashier new.
	
	salesBook _ OrderedCollection  new.

	
	 self
		
		should: [	aCashier 
				checkOut:aCart 
				with: testObjects aValidCreditCard 
				on: testObjects today 
				regiteringOn: salesBook. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = aCashier canNotCheakOutWithEmptyCart.].! !

!CashierTest methodsFor: 'test' stamp: 'sgs 6/16/2021 23:37:42'!
test02CheakOutWithOneItemInTheCart
	|aCart aCashier totalTransaction salesBook |
	
	aCart _ testObjects createCart.
	aCart add: 'validBook'.

	aCashier _ Cashier initializeWith:  self.

	salesBook _ OrderedCollection  new.

	totalTransaction _	aCashier 
					checkOut:aCart 
					with:testObjects aValidCreditCard 
					on: testObjects today 
					regiteringOn: salesBook.
	
	self assert: totalTransaction equals: 100.
	
	
	! !

!CashierTest methodsFor: 'test' stamp: 'sgs 6/16/2021 23:38:51'!
test03CheakOutWithManyItemsInTheCart
	|aCart aCashier totalTransaction salesBook |
	
	aCart _ testObjects createCart.
	aCart add: 4 of: testObjects itemSellByTheStore.

	aCashier _ Cashier initializeWith:  self.
	
	salesBook _ OrderedCollection new.
	
	totalTransaction _	aCashier
					checkOut:aCart 
					with: testObjects aValidCreditCard 
					on:  testObjects today 
					regiteringOn: salesBook.
	
	self assert: totalTransaction equals: 400.
	
	
	! !

!CashierTest methodsFor: 'test' stamp: 'sgs 6/16/2021 23:40:08'!
test04CanNotCheckoutWithAnExpiredCreditCart

	|aCart aCashier totalTransaction salesBook  |
	
	aCart _ testObjects createCart.
	aCart add: 4 of: testObjects itemSellByTheStore.

	aCashier _ Cashier new.
	salesBook _  OrderedCollection new.
	
	 self 
		should: [totalTransaction _	aCashier 
								checkOut:aCart 
								with:testObjects anExpiredCreditCard 
								on: testObjects today 
								regiteringOn: salesBook. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = aCashier canNotCheakOutWithAnExpiredCreditCard. 
			self assert: salesBook isEmpty.].
	
	
	
	! !

!CashierTest methodsFor: 'test' stamp: 'sgs 6/16/2021 23:40:43'!
test05CheckoutRegistersASales

	|aCart aCashier totalTransaction salesBook  |
	
	aCart _ testObjects createCart.
	aCart add: 4 of: testObjects itemSellByTheStore .

	aCashier _ Cashier initializeWith:  self.
	salesBook _  OrderedCollection new.
	
	 totalTransaction _	aCashier 
					checkOut:aCart 
					with: testObjects aValidCreditCard 
					on: testObjects today 
					regiteringOn: salesBook. 
		
	self assert: salesBook size equals: 1.
	self assert: salesBook first equals: totalTransaction .
	
	
	
	
	
	! !

!CashierTest methodsFor: 'test' stamp: 'sgs 6/16/2021 23:53:59'!
test06

	|aCart aCashier salesBook  debitCreditCard total debitAmout aCard |
	
	aCart _ testObjects createCart.
	aCart add: 4 of: testObjects  itemSellByTheStore .

	
	salesBook _  OrderedCollection new.
	aCard _ testObjects aValidCreditCard .
	MerchantProcessorSimulator := [ :anAmount :aCreditCard | 
		debitAmout := anAmount.
		debitCreditCard := aCreditCard ].
	
	aCashier _ Cashier initializeWith:  self.
	total := aCashier 
			checkOut: aCart 
			with:aCard
			on: testObjects today 
			regiteringOn: salesBook.
		
					
	self assert: debitAmout equals: total.
	self assert: debitCreditCard equals: aCard
	
	
	
	! !

!CashierTest methodsFor: 'test' stamp: 'sgs 6/16/2021 23:43:09'!
test07

	|aCart aCashier salesBook  |
	
	aCart _ testObjects createCart.
	aCart add: 4 of: testObjects itemSellByTheStore .

	
	salesBook _  OrderedCollection new.

	MerchantProcessorSimulator := [ :anAmount :aCreditCard | 
		self error: Cashier creditCardHasNoDebitErrorMessage ].
	aCashier _ Cashier initializeWith:  self.
				
	self 
		should: [	 aCashier 
				checkOut: aCart 
				with: testObjects aValidCreditCard 
				on: testObjects today 
				regiteringOn: salesBook. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoDebitErrorMessage.
			self assert: salesBook isEmpty ]	
		
	
	
	! !


!CashierTest methodsFor: 'debit' stamp: 'sgs 6/16/2021 23:22:29'!
debit: anAmount from: aCreditCard 

	^MerchantProcessorSimulator value: anAmount value: aCreditCard ! !


!CashierTest methodsFor: 'setUp' stamp: 'sgs 6/16/2021 23:35:24'!
setUp

	testObjects _ TestObject new.	
	MerchantProcessorSimulator _  [ :anAmount :aCreditCard | ]

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


!Cart methodsFor: 'assertions' stamp: 'sgs 6/11/2021 20:26:10'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'sgs 6/11/2021 21:02:56'!
assertIsValidQuantity: aQuantity

	(aQuantity strictlyPositive) ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


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


!Cart methodsFor: 'as yet unclassified' stamp: 'sgs 6/11/2021 21:02:14'!
totalAmount
	
	
	^items sum:[:aBook |catalog at: aBook] ifEmpty: [^0].
	 ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'error messages' stamp: 'sgs 6/14/2021 19:24:07'!
canNotCheakOutWithAnExpiredCreditCard
	
	^'Expired Card'! !

!Cashier methodsFor: 'error messages' stamp: 'sgs 6/10/2021 20:18:11'!
canNotCheakOutWithEmptyCart
	
	^'Invalidad Cart'! !


!Cashier methodsFor: 'assertions' stamp: 'sgs 6/15/2021 21:41:06'!
assertIsValidCard: aCreditCard on: aDate.

	(aCreditCard isExpiredOn: aDate)ifTrue: [self error: self canNotCheakOutWithAnExpiredCreditCard].

! !

!Cashier methodsFor: 'assertions' stamp: 'sgs 6/11/2021 20:39:49'!
assertIsValidCart: aCart

	^(aCart isEmpty) ifTrue: [ self error: self canNotCheakOutWithEmptyCart.].
! !


!Cashier methodsFor: 'as yet unclassified' stamp: 'sgs 6/15/2021 21:43:32'!
registerTotalAmount: total in: 	aSalesBook .
	
	aSalesBook addLast: total.! !


!Cashier methodsFor: 'checkOut' stamp: 'sgs 6/16/2021 22:48:28'!
calculateTotalOf: aCart

	^aCart totalAmount.! !

!Cashier methodsFor: 'checkOut' stamp: 'sgs 6/16/2021 23:00:02'!
checkOut: aCart with: aCreditCard on: aDate regiteringOn: aSalesBook	
	
	|total|
	
	self assertIsValidCart: aCart .
	self assertIsValidCard: aCreditCard on: aDate.
	
	total _ self calculateTotalOf: aCart.
	self debitTotal: total from: aCreditCard .
	self registerTotalAmount: total in: 	aSalesBook .
	
	^total.
	! !

!Cashier methodsFor: 'checkOut' stamp: 'sgs 6/16/2021 23:02:49'!
debitTotal: anAmount from: aCreditCard 

	^merchantProcessor debit: anAmount from: aCreditCard.! !


!Cashier methodsFor: 'initialization' stamp: 'sgs 6/16/2021 23:02:26'!
initializeWith: aMerchantProcessor
	
	
	merchantProcessor _ aMerchantProcessor.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error message' stamp: 'sgs 6/16/2021 23:43:09'!
creditCardHasNoDebitErrorMessage
	
	 ^'Payment cannot be made'! !


!Cashier class methodsFor: 'initialization' stamp: 'sgs 6/16/2021 23:01:42'!
initializeWith: aMerchantProcessor
	
	^self new initializeWith: aMerchantProcessor.! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'creditCardNumber creditCardOwner creditCardExpiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'assertion' stamp: 'sgs 6/15/2021 21:26:00'!
isExpiredOn: aDate

 	^creditCardExpiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'sgs 6/14/2021 19:16:19'!
initializeWithNumbered: aNumber owner:  aOwner expiredOn: anExpirationMonthOfYear.

	creditCardNumber _ aNumber.
	creditCardOwner _ aOwner.
	creditCardExpiration _ anExpirationMonthOfYear.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'assertions' stamp: 'sgs 6/14/2021 19:48:05'!
assertIsExpiredOn: anExpirationMonthOfYear
	

	! !

!CreditCard class methodsFor: 'assertions' stamp: 'sgs 6/14/2021 19:37:39'!
assertIsValidCreditCardWithNumbered: aNumber owner:  aOwner expiredOn: anExpirationMonthOfYear.

	self assertIsValidNumbered: aNumber.
	self assertIsValidOwner:  aOwner.
	self assertIsExpiredOn: anExpirationMonthOfYear.! !

!CreditCard class methodsFor: 'assertions' stamp: 'sgs 6/14/2021 19:36:21'!
assertIsValidNumbered: aNumber

	((aNumber asString) size =16 ) ifTrue:  [ self error: self class canNotCreatAnInvalidadCreditCard].

	! !

!CreditCard class methodsFor: 'assertions' stamp: 'sgs 6/14/2021 19:37:00'!
assertIsValidOwner:  aOwner

	(aOwner withBlanksTrimmed isEmpty) ifTrue:  [ self error: self class canNotCreatAnInvalidadCreditCard].
! !


!CreditCard class methodsFor: 'error messages' stamp: 'sgs 6/14/2021 19:29:19'!
canNotCreatAnInvalidadCreditCard
	
	^'Invalidad Card'! !


!CreditCard class methodsFor: 'initialize' stamp: 'sgs 6/14/2021 19:35:25'!
numbered: aNumber owner:  aOwner expiredOn: anExpirationMonthOfYear

	
	self assertIsValidCreditCardWithNumbered: aNumber owner:  aOwner expiredOn: anExpirationMonthOfYear.

	^self new initializeWithNumbered: aNumber owner:  aOwner expiredOn: anExpirationMonthOfYear.
! !


!classDefinition: #TestObject category: 'TusLibros'!
Object subclass: #TestObject
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestObject methodsFor: 'items' stamp: 'sgs 6/16/2021 23:30:01'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!TestObject methodsFor: 'items' stamp: 'sgs 6/16/2021 23:30:13'!
itemSellByTheStore
	
	^ 'validBook'! !


!TestObject methodsFor: 'card' stamp: 'sgs 6/16/2021 23:47:35'!
aValidCreditCard 
	
	
	^ CreditCard numbered: 010101010101 owner:  'Jill' expiredOn:(Month month: today monthIndex year: today yearNumber + 1).! !

!TestObject methodsFor: 'card' stamp: 'sgs 6/16/2021 23:47:35'!
anExpiredCreditCard 

	^CreditCard numbered: 010101010101 owner:  'Jill' expiredOn:(Month month: today monthIndex year: today yearNumber - 1).
	! !


!TestObject methodsFor: 'cart' stamp: 'sgs 6/16/2021 23:29:38'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog.! !

!TestObject methodsFor: 'cart' stamp: 'sgs 6/16/2021 23:29:46'!
defaultCatalog
	
	|aDictionary|
	aDictionary _ Dictionary new.
	
	^ aDictionary add: 'validBook' -> 100; yourself .! !


!TestObject methodsFor: 'date' stamp: 'sgs 6/16/2021 23:47:35'!
today
	^ today.! !


!TestObject methodsFor: 'initialization' stamp: 'sgs 6/16/2021 23:50:12'!
initialize

	today := DateAndTime now! !
