!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'JR 6/17/2021 11:54:50'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'JR 6/17/2021 11:54:57'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'JR 6/17/2021 11:55:03'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'JR 6/17/2021 11:55:09'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'JR 6/17/2021 11:55:14'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'JR 6/17/2021 11:55:21'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'JR 6/17/2021 11:55:29'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'JR 6/17/2021 11:55:38'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'JR 6/17/2021 11:54:44'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CheckOutTest category: 'TusLibros'!
TestCase subclass: #CheckOutTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CheckOutTest methodsFor: 'tests' stamp: 'JR 6/17/2021 11:51:01'!
test01CanNotCheckOutEmptyCart

	| cart cashier creditCard salesBook|
	
	cart := testObjectsFactory createCart.
	cashier := testObjectsFactory createCashier.
	creditCard := testObjectsFactory createCreditCard.
	salesBook := OrderedCollection new.
	
	self 
		should: [cashier checkOut: cart with: creditCard registerOn: salesBook]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cashier emptyCartErrorMessage.
			self assert: salesBook isEmpty]	! !

!CheckOutTest methodsFor: 'tests' stamp: 'JR 6/17/2021 11:51:37'!
test02CheckOutCartRegistersTotalToPay

	| cart cashier creditCard salesBook|
	
	cart := testObjectsFactory createCart.
	cashier := testObjectsFactory createCashier.
	creditCard := testObjectsFactory createCreditCard.
	salesBook := OrderedCollection new.
	
	cart add: 3 of: testObjectsFactory itemSellByTheStore.	
	cashier checkOut: cart with: creditCard registerOn: salesBook .
	
	self assert: salesBook size equals: 1.
	self assert: salesBook includes: 7500  
		! !

!CheckOutTest methodsFor: 'tests' stamp: 'JR 6/17/2021 11:53:50'!
test03CheckingOutWithExpiredCreditCardRaisesError

	| cart cashier salesBook|
	
	cart := testObjectsFactory createCart.
	cashier := testObjectsFactory createCashier.
	cart add: 3 of: testObjectsFactory itemSellByTheStore.	
	salesBook := OrderedCollection new.
	
	self 
		should: [cashier checkOut: cart with: testObjectsFactory createExpiredCreditCard registerOn: salesBook]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cashier expiredCreditCardErrorMessage.
			self assert: salesBook isEmpty]	! !

!CheckOutTest methodsFor: 'tests' stamp: 'JR 6/14/2021 18:52:34'!
test04CreatingCreditCardWithInvalidNumberRaisesError
	
	self 
		should: [CreditCard withNumber: '4' ownedBy: 'Matias' expiring: (Date today + 3 days).]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard invalidNumberErrorMessage]	! !

!CheckOutTest methodsFor: 'tests' stamp: 'JR 6/14/2021 18:52:14'!
test05CreatingCreditCardWithEmptyOwnerRaisesError
	
	self 
		should: [CreditCard withNumber: '1111222233334444' ownedBy: ' ' expiring: (Date today + 3 days).]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard invalidOwnerErrorMessage]	! !

!CheckOutTest methodsFor: 'tests' stamp: 'JR 6/17/2021 11:52:08'!
test06MerchantProcessorRegistersStolenCreditCard

	|merchantProcessor creditCard|
	
	creditCard := testObjectsFactory createCreditCard.
	
	merchantProcessor := MerchantProcessor new.
	merchantProcessor registerCreditCardAsStolen: creditCard .
	
	self assert: merchantProcessor stolenCreditCards size equals: 1.
	self assert: merchantProcessor stolenCreditCards includes: creditCard ! !

!CheckOutTest methodsFor: 'tests' stamp: 'JR 6/17/2021 11:52:12'!
test07MerchantProcessorRegistersFakeCreditCard

	|merchantProcessor creditCard|
	
	creditCard := testObjectsFactory createCreditCard.
	
	merchantProcessor := MerchantProcessor new.
	merchantProcessor registerCreditCardAsFake: creditCard .
	
	self assert: merchantProcessor fakeCreditCards size equals: 1.
	self assert: merchantProcessor fakeCreditCards includes: creditCard ! !

!CheckOutTest methodsFor: 'tests' stamp: 'JR 6/17/2021 12:39:25'!
test08MerchantProcessorRegistersCreditCardWithInsufficientBalance

	|merchantProcessor creditCard|
	
	creditCard := testObjectsFactory createCreditCard.
	
	merchantProcessor := MerchantProcessor new.
	merchantProcessor registerCreditCardWithInsufficientBalance: creditCard .
	
	self assert: merchantProcessor creditCardsWithInsufficientBalance size equals: 1.
	self assert: merchantProcessor creditCardsWithInsufficientBalance includes: creditCard ! !

!CheckOutTest methodsFor: 'tests' stamp: 'JR 6/17/2021 12:36:51'!
test09CanNotCheckOutWithFakeCreditCard

	| cart cashier salesBook merchantProcessor fakeCreditCard|
	
	cart := testObjectsFactory createCart.
	cart add: 3 of: testObjectsFactory itemSellByTheStore.	
	salesBook := OrderedCollection new.
	fakeCreditCard := testObjectsFactory createCreditCard .
	merchantProcessor := MerchantProcessor new.
	merchantProcessor registerCreditCardAsFake: fakeCreditCard .
	
	cashier := Cashier with: merchantProcessor .
	
	self 
		should: [cashier checkOut: cart with: fakeCreditCard registerOn: salesBook]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = merchantProcessor fakeCreditCardErrorMessage.
			self assert: salesBook isEmpty]	! !

!CheckOutTest methodsFor: 'tests' stamp: 'JR 6/17/2021 12:36:46'!
test10CanNotCheckOutWithStolenCreditCard

	| cart cashier salesBook merchantProcessor stolenCreditCard|
	
	cart := testObjectsFactory createCart.
	cart add: 3 of: testObjectsFactory itemSellByTheStore.	
	salesBook := OrderedCollection new.
	stolenCreditCard := testObjectsFactory createCreditCard .
	merchantProcessor := MerchantProcessor new.
	merchantProcessor registerCreditCardAsStolen: stolenCreditCard .
	
	cashier := Cashier with: merchantProcessor .
	
	self 
		should: [cashier checkOut: cart with: stolenCreditCard registerOn: salesBook]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = merchantProcessor stolenCreditCardErrorMessage.
			self assert: salesBook isEmpty]	! !

!CheckOutTest methodsFor: 'tests' stamp: 'JR 6/17/2021 12:42:09'!
test11CanNotCheckOutWithCreditCardWithInsufficientBalance

	| cart cashier salesBook merchantProcessor creditCardWithInsufficientBalance|
	
	cart := testObjectsFactory createCart.
	cart add: 3 of: testObjectsFactory itemSellByTheStore.	
	salesBook := OrderedCollection new.
	creditCardWithInsufficientBalance := testObjectsFactory createCreditCard .
	merchantProcessor := MerchantProcessor new.
	merchantProcessor registerCreditCardWithInsufficientBalance: creditCardWithInsufficientBalance .
	
	cashier := Cashier with: merchantProcessor .
	
	self 
		should: [cashier checkOut: cart with: creditCardWithInsufficientBalance registerOn: salesBook]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = merchantProcessor creditCardWithInsufficientBalanceErrorMessage.
			self assert: salesBook isEmpty]	! !


!CheckOutTest methodsFor: 'setup' stamp: 'JR 6/17/2021 11:53:30'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.! !


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


!Cart methodsFor: 'assertions' stamp: 'JR 6/14/2021 16:40:21'!
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


!Cart methodsFor: 'total' stamp: 'JR 6/14/2021 16:38:51'!
totalPriceOfProducts
	|totalToPay|
	
	totalToPay := 0.
	
	catalog keysAndValuesDo: [:item :price | (self includes: item) 
			ifTrue: [ totalToPay := totalToPay + price * (self occurrencesOf: item)] ].
		
	^totalToPay ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'check out' stamp: 'JR 6/17/2021 12:35:42'!
checkOut: aCart with: aCreditCard registerOn: aSalesBook
	
	self assertCartIsNotEmpty: aCart.
	self assertCreditCardIsNotExpired: aCreditCard.
	
	merchantProcessor charge: aCreditCard.
	
	aSalesBook add: aCart totalPriceOfProducts.
	
	^aSalesBook! !


!Cashier methodsFor: 'initialization' stamp: 'JR 6/16/2021 16:05:26'!
initializeWith: aMerchantProcessor

	merchantProcessor := aMerchantProcessor ! !


!Cashier methodsFor: 'assertions' stamp: 'JR 6/10/2021 20:50:29'!
assertCartIsNotEmpty: aCart

	aCart isEmpty ifTrue: [self error: self emptyCartErrorMessage].! !

!Cashier methodsFor: 'assertions' stamp: 'JR 6/17/2021 12:02:35'!
assertCreditCardIsNotExpired: aCreditCard

	(aCreditCard isExpiredOn: (Month month: Date today monthIndex year: Date today yearNumber)) 
		ifTrue: [self error: self expiredCreditCardErrorMessage ]! !


!Cashier methodsFor: 'error messages' stamp: 'JR 6/10/2021 20:07:26'!
emptyCartErrorMessage

	^'Can not check out empty cart'! !

!Cashier methodsFor: 'error messages' stamp: 'JR 6/10/2021 20:57:05'!
expiredCreditCardErrorMessage

	^'The credit card is expired'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'JR 6/16/2021 16:04:58'!
with: aMerchantProcessor

	^self new initializeWith: aMerchantProcessor ! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'number expiringDate owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'JR 6/17/2021 12:15:54'!
isExpiredOn: aDate
	
	^(expiringDate yearNumber < aDate yearNumber) or: [(expiringDate yearNumber = aDate yearNumber) and: [expiringDate month < aDate month]]
	! !


!CreditCard methodsFor: 'initialization' stamp: 'JR 6/14/2021 18:38:30'!
initializeWith: aNumber owner: anOwner andExpiringDate: aDate
	
	owner := anOwner .
	number := aNumber.
	expiringDate := aDate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'JR 6/14/2021 18:53:43'!
withNumber: aNumber ownedBy: anOwner expiring: aDate

	self assertNumberHas16Digits: aNumber.
	self assertOwnerIsNotEmpty: anOwner.
	
	^self new initializeWith: aNumber owner: anOwner andExpiringDate: aDate! !


!CreditCard class methodsFor: 'assertions' stamp: 'JR 6/14/2021 18:52:34'!
assertNumberHas16Digits: aNumber

	((aNumber allSatisfy: [:a | a isDigit]) and: [aNumber size = 16]) ifFalse: [self error: self invalidNumberErrorMessage]! !

!CreditCard class methodsFor: 'assertions' stamp: 'JR 6/14/2021 19:04:53'!
assertOwnerIsNotEmpty: aName

	(aName withoutLeadingBlanks isEmpty) ifTrue: [self error: self invalidOwnerErrorMessage ]! !


!CreditCard class methodsFor: 'error messages' stamp: 'JR 6/14/2021 18:52:48'!
invalidNumberErrorMessage

	^'The number must have 16 digits'! !

!CreditCard class methodsFor: 'error messages' stamp: 'JR 6/14/2021 18:53:21'!
invalidOwnerErrorMessage

	^'Owner can not be empty'! !


!classDefinition: #MerchantProcessor category: 'TusLibros'!
Object subclass: #MerchantProcessor
	instanceVariableNames: 'stolenCreditCards fakeCreditCards creditCardsWithInsufficientBalance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'accessing' stamp: 'JR 6/17/2021 12:41:10'!
creditCardsWithInsufficientBalance

	^creditCardsWithInsufficientBalance copy! !

!MerchantProcessor methodsFor: 'accessing' stamp: 'JR 6/16/2021 15:59:15'!
fakeCreditCards

	^fakeCreditCards copy! !

!MerchantProcessor methodsFor: 'accessing' stamp: 'JR 6/16/2021 15:56:16'!
stolenCreditCards

	^stolenCreditCards copy! !


!MerchantProcessor methodsFor: 'initialization' stamp: 'JR 6/17/2021 12:40:20'!
initialize

	stolenCreditCards := OrderedCollection new.
	fakeCreditCards := OrderedCollection new.
	creditCardsWithInsufficientBalance := OrderedCollection new.! !


!MerchantProcessor methodsFor: 'register cards' stamp: 'JR 6/16/2021 15:58:59'!
registerCreditCardAsFake: aCreditCard 

	fakeCreditCards add: aCreditCard ! !

!MerchantProcessor methodsFor: 'register cards' stamp: 'JR 6/16/2021 15:55:33'!
registerCreditCardAsStolen: aCreditCard

	stolenCreditCards add: aCreditCard ! !

!MerchantProcessor methodsFor: 'register cards' stamp: 'JR 6/17/2021 12:40:04'!
registerCreditCardWithInsufficientBalance: aCreditCard

	creditCardsWithInsufficientBalance add: aCreditCard ! !


!MerchantProcessor methodsFor: 'error messages' stamp: 'JR 6/17/2021 12:42:27'!
creditCardWithInsufficientBalanceErrorMessage
	
	^'Credit card has insufficient balance'! !

!MerchantProcessor methodsFor: 'error messages' stamp: 'JR 6/17/2021 12:34:43'!
fakeCreditCardErrorMessage
	
	^'Credit card is fake'! !

!MerchantProcessor methodsFor: 'error messages' stamp: 'JR 6/17/2021 12:34:51'!
stolenCreditCardErrorMessage
	
	^'Credit card is stolen'! !


!MerchantProcessor methodsFor: 'assertions' stamp: 'JR 6/17/2021 12:43:58'!
assertCreditCardHasSufficientBalance: aCreditCard 

	(creditCardsWithInsufficientBalance includes: aCreditCard) 
		ifTrue: [self error: self creditCardWithInsufficientBalanceErrorMessage]! !

!MerchantProcessor methodsFor: 'assertions' stamp: 'JR 6/17/2021 12:34:17'!
assertCreditCardIsNotFake: aCreditCard

	(fakeCreditCards includes: aCreditCard) ifTrue: [self error: self fakeCreditCardErrorMessage]! !

!MerchantProcessor methodsFor: 'assertions' stamp: 'JR 6/17/2021 12:33:42'!
assertCreditCardIsNotStolen: aCreditCard

	(stolenCreditCards includes: aCreditCard) ifTrue: [self error: self stolenCreditCardErrorMessage]! !


!MerchantProcessor methodsFor: 'charging' stamp: 'JR 6/17/2021 12:43:00'!
charge: aCreditCard

	self assertCreditCardIsNotStolen: aCreditCard .
	self assertCreditCardIsNotFake: aCreditCard .
	self assertCreditCardHasSufficientBalance: aCreditCard ! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'JR 6/17/2021 11:46:25'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'JR 6/17/2021 11:47:57'!
createCashier
	
	
	^Cashier with: (MerchantProcessor new).! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'JR 6/17/2021 12:01:43'!
createCreditCard
	
	^CreditCard withNumber: '1111222233334444' 
			ownedBy: 'Matias'
			expiring: (Month month: Date today monthIndex year: Date today yearNumber + 1)! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'JR 6/17/2021 12:01:25'!
createExpiredCreditCard
	
	^CreditCard withNumber: '1111222233334444' 
			ownedBy: 'Matias'
			expiring: (Month month: Date today monthIndex year: Date today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'JR 6/17/2021 11:46:05'!
defaultCatalog
	
	|priceList|
	
	priceList := Dictionary new		.
	priceList add: #validBook->2500.
	
	^priceList ! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'JR 6/17/2021 11:48:52'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'JR 6/17/2021 11:48:12'!
itemSellByTheStore
	
	^ 'validBook'! !
