!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testSupport'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'JPF 6/12/2021 09:28:52'!
test01NewCartsAreCreatedEmpty

	self assert: testSupport createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'JPF 6/12/2021 09:29:08'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testSupport createCart.
	
	self 
		should: [ cart add: testSupport itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'JPF 6/12/2021 09:29:19'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testSupport createCart.
	
	cart add: testSupport itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'JPF 6/12/2021 09:29:28'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testSupport createCart.
	
	self 
		should: [cart add: 0 of: testSupport itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'JPF 6/12/2021 09:29:38'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testSupport createCart.
	
	self 
		should: [cart add: 2 of: testSupport itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'JPF 6/12/2021 09:29:49'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testSupport createCart.
	
	cart add: testSupport itemSellByTheStore.
	self assert: (cart includes: testSupport itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'JPF 6/12/2021 09:29:57'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testSupport createCart.
	
	self deny: (cart includes: testSupport itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'JPF 6/12/2021 09:30:08'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testSupport createCart.
	
	cart add: 2 of: testSupport itemSellByTheStore.
	self assert: (cart occurrencesOf: testSupport itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setUp' stamp: 'JPF 6/12/2021 09:27:46'!
setUp
	
	testSupport := MarketTestSupport new! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testSupport'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'JPF 6/14/2021 19:31:53'!
test01FailWhenTryToCheckoutAnEmptyCart

	| cart cashier salesBook |
	
	cart := testSupport createCart.
	
	salesBook := testSupport salesBook.
	
	cashier := testSupport createCashierRegisteringOn: salesBook.
	
	self 
		should: [ cashier checkout: cart payingWith: testSupport validCreditCard ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error | 
			self assert: Cashier canNotCheckoutEmptyCartErrorDescription equals: error messageText.
			self assert: salesBook isEmpty
			]
	
	
	

	! !

!CashierTest methodsFor: 'tests' stamp: 'JPF 6/14/2021 19:42:46'!
test02ShouldCalculateTheCorrectTotalOfTheCartAndSaveIt

	| cart cashier salesBook |
	
	cart := testSupport createCart.
	
	cart add: 2 of: testSupport itemSellByTheStore.
	
	salesBook := testSupport salesBook.
	
	cashier := testSupport createCashierRegisteringOn: salesBook.
	
	self assert: 100 equals: (cashier checkout: cart payingWith: testSupport validCreditCard).
	self assert: 100 equals: salesBook first.
	self assert: 1 equals: salesBook size.
		

	! !

!CashierTest methodsFor: 'tests' stamp: 'JPF 6/14/2021 20:00:40'!
test03ShouldFailWhenTheCreditCardIsExpired

	| cart cashier salesBook |
	
	cart := testSupport createCartWithValidItems.
	
	salesBook := testSupport salesBook.
	
	cashier := testSupport createCashierRegisteringOn: salesBook.
	
	self 
		should: [ cashier checkout: cart payingWith: testSupport expiredCreditCard ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error | 
			self assert: Cashier canNotCheckoutWithAnExpiredCreditCard equals: error messageText.
			self assert: salesBook isEmpty
			]. 
		

	! !

!CashierTest methodsFor: 'tests' stamp: 'JPF 6/15/2021 18:45:42'!
test04ShouldNotRegisterTheSaleAndPassTheErrorWhenTheMerchantProcessorFails

	| cart cashier salesBook |
	
	cart := testSupport createCartWithValidItems.
	
	salesBook := testSupport salesBook.
	
	cashier := testSupport
		createCashierRegisteringOn: salesBook
		using: testSupport createMerchantProcessorNoCredit.
	
	self 
		should: [ cashier checkout: cart payingWith: testSupport validCreditCard ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error | 
			self assert: MerchantProcessor creditCardHasNotCredit equals: error messageText.
			self assert: salesBook isEmpty
			].
	
	
	cashier := testSupport 
		createCashierRegisteringOn: salesBook
		using: testSupport createMerchantProcessorFakeCreditCard.
	
	self 
		should: [ cashier checkout: cart payingWith: testSupport validCreditCard ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error | 
			self assert: MerchantProcessor creditCardIsFake equals: error messageText.
			self assert: salesBook isEmpty
			].
		
	cashier := testSupport 
		createCashierRegisteringOn: salesBook
		using: testSupport createMerchantProcessorStolenCreditCard.
	
	self 
		should: [ cashier checkout: cart payingWith: testSupport validCreditCard ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error | 
			self assert: MerchantProcessor creditCardIsStolen equals: error messageText.
			self assert: salesBook isEmpty
			].
		

	! !


!CashierTest methodsFor: 'set up' stamp: 'JPF 6/12/2021 09:27:46'!
setUp

	testSupport := MarketTestSupport new! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'testSupport'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'setUp' stamp: 'JPF 6/12/2021 09:48:47'!
setUp
	
	testSupport := MarketTestSupport new! !


!CreditCardTest methodsFor: 'tests' stamp: 'JPF 6/14/2021 19:24:44'!
test01ShouldFailWhenTheNameIsEmpty

	self 
		should: [ 
			CreditCard
				withName: ''
				number: testSupport validCardNumber
				expiration: testSupport expirationMonth ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard canNotCreateACreditCardWithEmptyName! !

!CreditCardTest methodsFor: 'tests' stamp: 'JPF 6/14/2021 19:24:51'!
test02ShouldFailWhenTheNameIsAllEmptySpaces

	self 
		should: [ 
			CreditCard
				withName: '       '
				number: testSupport validCardNumber
				expiration: testSupport expirationMonth ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard canNotCreateACreditCardWithANameWithAllEmptySpaces! !

!CreditCardTest methodsFor: 'tests' stamp: 'JPF 6/14/2021 19:25:00'!
test03ShouldFailWhenTheNameWithMoreThan30Characters

	self 
		should: [ 
			CreditCard
				withName: 'NameWithMoreThanThirtyCharacter'
				number: testSupport validCardNumber
				expiration: testSupport expirationMonth ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard canNotCreateACreditCardWithANameWithMoreThan30Characters.! !

!CreditCardTest methodsFor: 'tests' stamp: 'JPF 6/15/2021 19:56:13'!
test04ShouldFailWhenTheNumberHasNot16Digits

	self 
		should: [ 
			CreditCard
				withName: testSupport validCardName
				number: 11118888111188881
				expiration: testSupport expirationMonth ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard canNotCreateACreditCardWithANumberThatHasNot16Digits.
		
	self 
		should: [ 
			CreditCard
				withName: testSupport validCardName
				number: 111188881111888
				expiration: testSupport expirationMonth ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard canNotCreateACreditCardWithANumberThatHasNot16Digits.! !


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


!Cart methodsFor: 'assertions' stamp: 'JPF 6/12/2021 09:25:22'!
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

!Cart methodsFor: 'queries' stamp: 'JPF 6/12/2021 09:16:19'!
total
	
	^ items sum: [ :item | catalog at: item ] ifEmpty: [ 0 ]! !


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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'today salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout' stamp: 'JPF 6/15/2021 19:40:11'!
checkout: aCart payingWith: aCreditCard
	
	| cartTotal |
	
	self assertCartIsNotEmpty: aCart.
	self assertCreditCardIsNotExpired: aCreditCard.
	
	cartTotal := aCart total.
	
	merchantProcessor processPaymentWith: aCreditCard for: cartTotal.
	
	self registerSale: cartTotal.
	
	^ cartTotal! !


!Cashier methodsFor: 'assertions' stamp: 'JPF 6/10/2021 20:00:05'!
assertCartIsNotEmpty: aCart

	^ aCart isEmpty ifTrue: [ self error: self class canNotCheckoutEmptyCartErrorDescription ]! !

!Cashier methodsFor: 'assertions' stamp: 'JPF 6/15/2021 20:02:39'!
assertCreditCardIsNotExpired: aCreditCard

	^ (aCreditCard isExpiredComparingTo: today) 
		ifTrue: [ self error: self class canNotCheckoutWithAnExpiredCreditCard ]! !


!Cashier methodsFor: 'initialization' stamp: 'JPF 6/15/2021 19:14:03'!
initializeFor: aDate registeringOn: aSalesBook using: aMerchantProcessor  
	
	today := aDate.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.! !


!Cashier methodsFor: 'checkout - private' stamp: 'JPF 6/15/2021 19:40:11'!
registerSale: cartTotal

	^ salesBook add: cartTotal! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error descriptions' stamp: 'JPF 6/10/2021 19:57:42'!
canNotCheckoutEmptyCartErrorDescription
	
	^ 'Can not checkout an empty cart'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'JPF 6/12/2021 10:06:20'!
canNotCheckoutWithAnExpiredCreditCard
	
	^ 'Can not checkout with an expired credit card'! !


!Cashier class methodsFor: 'instance creation' stamp: 'JPF 6/15/2021 19:13:26'!
for: aDate registeringOn: aSalesBook using: aMerchantProcessor  
	
	^ self new initializeFor: aDate registeringOn: aSalesBook using: aMerchantProcessor! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'name creditCardNumber month'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'JPF 6/12/2021 09:52:57'!
initializeWithName: aName number: aCreditCardNumber expiration: aMonth
	
	self assertNameIsValid: aName.
	self assertNumberIsValid: aCreditCardNumber.
	
	name := aName.
	creditCardNumber := aCreditCardNumber.
	month := aMonth.! !


!CreditCard methodsFor: 'assertions' stamp: 'JPF 6/15/2021 19:57:13'!
assertCreditCardNumberHas16Digits: aCreditCardNumber

	^ (aCreditCardNumber numberOfDigitsInBase: 10) ~= 16
		ifTrue: [ self error: self class canNotCreateACreditCardWithANumberThatHasNot16Digits ]! !

!CreditCard methodsFor: 'assertions' stamp: 'JPF 6/12/2021 09:34:36'!
assertNameHasNotMoreThan30Characters: aName

	^ aName size > 30 
		ifTrue: [ self error: self class canNotCreateACreditCardWithANameWithMoreThan30Characters ]! !

!CreditCard methodsFor: 'assertions' stamp: 'JPF 6/15/2021 20:02:17'!
assertNameHasNotOnlyEmptySpaces: aName

	^ aName withBlanksTrimmed isEmpty
		ifTrue: [ self error: self class canNotCreateACreditCardWithANameWithAllEmptySpaces ]! !

!CreditCard methodsFor: 'assertions' stamp: 'JPF 6/10/2021 20:48:10'!
assertNameIsNotEmpty: aName

	^ aName isEmpty 
		ifTrue: [ self error: self class canNotCreateACreditCardWithEmptyName ]! !

!CreditCard methodsFor: 'assertions' stamp: 'JPF 6/14/2021 19:06:27'!
assertNameIsValid: aName

	self assertNameIsNotEmpty: aName.
	self assertNameHasNotOnlyEmptySpaces: aName.
	self assertNameHasNotMoreThan30Characters: aName! !

!CreditCard methodsFor: 'assertions' stamp: 'JPF 6/15/2021 19:58:20'!
assertNumberIsValid: aCreditCardNumber

	self assertCreditCardNumberHas16Digits: aCreditCardNumber.! !


!CreditCard methodsFor: 'testing' stamp: 'JPF 6/12/2021 10:18:12'!
isExpiredComparingTo: aDate
	
	^ aDate > month lastDate! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'error descriptions' stamp: 'JPF 6/14/2021 19:03:11'!
canNotCreateACreditCardWithANameWithAllEmptySpaces
	
	^ 'Can not create a credit card with a name with all empty spaces'! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'JPF 6/12/2021 09:09:58'!
canNotCreateACreditCardWithANameWithMoreThan30Characters

	^ 'Can not create a credit card with a name with more than 30 characters'! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'JPF 6/14/2021 18:42:57'!
canNotCreateACreditCardWithANumberThatHasNot16Digits
	
	^ 'Can not create a credit card with a number that has not 16 digits'! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'JPF 6/14/2021 18:58:21'!
canNotCreateACreditCardWithANumberWithEmptySpaces
	
	^ 'Can not create a card with a number with empty spaces'.! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'JPF 6/12/2021 09:50:25'!
canNotCreateACreditCardWithANumberWithLessThan13Digits
	
	^ 'Can not create a credit card with a number with less than 13 digits'! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'JPF 6/10/2021 20:44:07'!
canNotCreateACreditCardWithEmptyName

	^ 'Can not create a credit card with an empty name'! !


!CreditCard class methodsFor: 'instance creation' stamp: 'JPF 6/10/2021 20:45:18'!
withName: aName number: aCreditCardNumber expiration: aMonth
	
	^self new initializeWithName: aName number: aCreditCardNumber expiration: aMonth! !


!classDefinition: #MarketTestSupport category: 'TusLibros'!
Object subclass: #MarketTestSupport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MarketTestSupport methodsFor: 'catalogue' stamp: 'JPF 6/12/2021 09:12:19'!
defaultCatalog
	
	^ Dictionary with: (self itemSellByTheStore -> self itemSellByTheStorePrice)! !

!MarketTestSupport methodsFor: 'catalogue' stamp: 'JPF 6/10/2021 19:50:19'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!MarketTestSupport methodsFor: 'catalogue' stamp: 'JPF 6/12/2021 09:23:05'!
itemSellByTheStore
	
	^ 'validItem'! !

!MarketTestSupport methodsFor: 'catalogue' stamp: 'JPF 6/12/2021 09:13:07'!
itemSellByTheStorePrice

	^ 50! !


!MarketTestSupport methodsFor: 'cart' stamp: 'JPF 6/10/2021 19:49:06'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!MarketTestSupport methodsFor: 'cart' stamp: 'JPF 6/14/2021 20:03:21'!
createCartWithValidItems

	| cart |	
	
	cart := self createCart.
	cart add: 2 of: self itemSellByTheStore.
	
	^ cart! !


!MarketTestSupport methodsFor: 'cashier' stamp: 'JPF 6/14/2021 19:38:38'!
cashierDate

	^ July / 1 / 2020

	
	! !

!MarketTestSupport methodsFor: 'cashier' stamp: 'JPF 6/15/2021 19:36:26'!
createCashier
	
	^ Cashier for: self cashierDate registeringOn: self salesBook using: self createMerchantProcessorOk.! !

!MarketTestSupport methodsFor: 'cashier' stamp: 'JPF 6/15/2021 19:37:29'!
createCashierRegisteringOn: aSalesBook

	^ Cashier for: self cashierDate registeringOn: aSalesBook using: self createMerchantProcessorOk.

	
	! !

!MarketTestSupport methodsFor: 'cashier' stamp: 'JPF 6/15/2021 19:19:04'!
createCashierRegisteringOn: aSalesBook using: aMerchantProcessor

	^ Cashier for: self cashierDate registeringOn: aSalesBook using: aMerchantProcessor.

	
	! !

!MarketTestSupport methodsFor: 'cashier' stamp: 'JPF 6/14/2021 19:30:01'!
salesBook
	
	^ OrderedCollection new.! !


!MarketTestSupport methodsFor: 'creditCard' stamp: 'JPF 6/12/2021 10:54:24'!
expirationMonth

	^ June ofYear: (GregorianYear number: 2022)! !

!MarketTestSupport methodsFor: 'creditCard' stamp: 'JPF 6/12/2021 10:02:24'!
expiredCreditCard

	^ CreditCard
		withName: self validCardName
		number: self validCardNumber
		expiration: self expiredMonth.! !

!MarketTestSupport methodsFor: 'creditCard' stamp: 'JPF 6/12/2021 10:54:46'!
expiredMonth

	^ June ofYear: (GregorianYear number: 2020)! !

!MarketTestSupport methodsFor: 'creditCard' stamp: 'JPF 6/12/2021 09:44:13'!
validCardName

	^ 'Valid Name'! !

!MarketTestSupport methodsFor: 'creditCard' stamp: 'JPF 6/15/2021 19:55:46'!
validCardNumber

	^ 1111888811118888! !

!MarketTestSupport methodsFor: 'creditCard' stamp: 'JPF 6/12/2021 10:02:02'!
validCreditCard

	^ CreditCard
		withName: self validCardName
		number: self validCardNumber
		expiration: self expirationMonth.! !


!MarketTestSupport methodsFor: 'merchantProcessor' stamp: 'JPF 6/15/2021 19:29:52'!
createMerchantProcessorFakeCreditCard
	^ MerchantProcessorSimulator with: [ :selfRef |
		selfRef error: MerchantProcessor creditCardIsFake ].! !

!MarketTestSupport methodsFor: 'merchantProcessor' stamp: 'JPF 6/15/2021 19:07:10'!
createMerchantProcessorNoCredit
	^ MerchantProcessorSimulator with: [ :selfRef | 
		selfRef error: MerchantProcessor creditCardHasNotCredit ].! !

!MarketTestSupport methodsFor: 'merchantProcessor' stamp: 'JPF 6/15/2021 19:38:08'!
createMerchantProcessorOk
	^ MerchantProcessorSimulator with: [ :selfVar | ]! !

!MarketTestSupport methodsFor: 'merchantProcessor' stamp: 'JPF 6/15/2021 19:33:35'!
createMerchantProcessorStolenCreditCard
	^ MerchantProcessorSimulator with: [ :selfVar |
		selfVar error: MerchantProcessor creditCardIsStolen ]! !


!classDefinition: #MerchantProcessor category: 'TusLibros'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'payment' stamp: 'JPF 6/15/2021 19:59:31'!
processPaymentWith: aCreditCard for: aTotal

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: 'TusLibros'!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'error descriptions' stamp: 'JPF 6/15/2021 19:22:01'!
creditCardHasNotCredit
	
	^ 'Credit card has not credit'! !

!MerchantProcessor class methodsFor: 'error descriptions' stamp: 'JPF 6/15/2021 19:31:13'!
creditCardIsFake
	
	^ 'Credit card is fake'! !

!MerchantProcessor class methodsFor: 'error descriptions' stamp: 'JPF 6/15/2021 19:34:05'!
creditCardIsStolen
	
	^ 'Credit card is stolen'! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
MerchantProcessor subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'blockClosureToRun'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'payment' stamp: 'JPF 6/15/2021 19:16:58'!
processPaymentWith: aCreditCard for: aTotal
	
	^ blockClosureToRun value: self.! !


!MerchantProcessorSimulator methodsFor: 'initialization' stamp: 'JPF 6/15/2021 19:08:30'!
initializeWith: aBlockClosureToRun 
	
	blockClosureToRun := aBlockClosureToRun.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: 'TusLibros'!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'instance creation' stamp: 'JPF 6/15/2021 19:08:02'!
with: aBlockClosureToRun 
	
	^self new initializeWith: aBlockClosureToRun! !
