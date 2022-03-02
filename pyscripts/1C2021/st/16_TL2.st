!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'storeTestSimulator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'Ciro 6/13/2021 17:51:47'!
test01NewCartsAreCreatedEmpty

	self assert: storeTestSimulator createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'Ciro 6/13/2021 17:52:14'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := storeTestSimulator createCart.
	
	self 
		should: [ cart add: storeTestSimulator itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'Ciro 6/13/2021 17:51:54'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := storeTestSimulator createCart.
	
	cart add: storeTestSimulator itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'Ciro 6/13/2021 17:52:19'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := storeTestSimulator createCart.
	
	self 
		should: [cart add: 0 of: storeTestSimulator itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'Ciro 6/13/2021 17:52:22'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := storeTestSimulator createCart.
	
	self 
		should: [cart add: 2 of: storeTestSimulator itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'Ciro 6/13/2021 17:52:27'!
test06CartRemembersAddedItems

	| cart |
	
	cart := storeTestSimulator createCart.
	
	cart add: storeTestSimulator itemSellByTheStore.
	self assert: (cart includes: storeTestSimulator itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'Ciro 6/13/2021 17:52:30'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := storeTestSimulator createCart.
	
	self deny: (cart includes: storeTestSimulator itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'Ciro 6/13/2021 17:52:34'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := storeTestSimulator createCart.
	
	cart add: 2 of: storeTestSimulator itemSellByTheStore.
	self assert: (cart occurrencesOf: storeTestSimulator itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'Ciro 6/13/2021 17:51:39'!
setUp

	storeTestSimulator _ StoreTestSimulator new! !


!classDefinition: #CheckOutTest category: 'TusLibros'!
TestCase subclass: #CheckOutTest
	instanceVariableNames: 'storeTestSimulator isAStolenCreditCard creditCardCanDebitTheAmount debitedAmount debitedCreditCard isAnInvalidCreditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CheckOutTest methodsFor: 'tests' stamp: 'Ciro 6/15/2021 18:04:12'!
test01CanNotCheckoutWithAnEmptyCart

	| sales |
	
	sales _ OrderedCollection new.
	
	self should: [ Cashier 
			checkout: storeTestSimulator createCart 
			chargingOn: storeTestSimulator validCreditCard 
			on: DateAndTime today 
			registerOn: sales
			withMerchantProcessor: self ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier canNotCheckoutWithAnEmptyCartErrorDescription.
			self assert: sales isEmpty]! !

!CheckOutTest methodsFor: 'tests' stamp: 'Ciro 6/15/2021 18:04:16'!
test02CanNotCheckoutWithAnExpiredCreditCard

	| cart sales |
	
	cart _ storeTestSimulator createCart.
	cart add: storeTestSimulator itemSellByTheStore.
	sales _ OrderedCollection new.
	
	self should: [ Cashier 
			checkout: cart 
			chargingOn: storeTestSimulator expiredCreditCard
			on: DateAndTime today
			registerOn: sales
			withMerchantProcessor: self ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier canNotCheckoutWithAnExpiredCreditCardErrorDescription.
			self assert: sales isEmpty]! !

!CheckOutTest methodsFor: 'tests' stamp: 'Ciro 6/15/2021 18:04:20'!
test03CanNotCheckoutWithACreditCardWithInvalidNumberOfDigits

	| cart sales |
	
	cart _ storeTestSimulator createCart.
	cart add: storeTestSimulator itemSellByTheStore.
	sales _ OrderedCollection new.
	
	self should: [ Cashier 
			checkout: cart 
			chargingOn: storeTestSimulator creditCardWithInvalidNumberOfDigits 
			on: DateAndTime today
			registerOn: sales
			withMerchantProcessor: self ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard invalidNumberOfDigitsOfCreditCardErrorDescription .
			self assert: sales isEmpty]! !

!CheckOutTest methodsFor: 'tests' stamp: 'Ciro 6/15/2021 18:04:23'!
test04CanNotCheckoutWithACreditCardWithInvalidOwner

	| cart sales |
	
	cart _ storeTestSimulator createCart.
	cart add: storeTestSimulator itemSellByTheStore.
	sales _ OrderedCollection new.
	
	self should: [ Cashier 
			checkout: cart 
			chargingOn: storeTestSimulator creditCardWithInvalidOwner
			on: DateAndTime today
			registerOn: sales
			withMerchantProcessor: self ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard invalidOwnerOfCreditCardErrorDescription.
			self assert: sales isEmpty]! !

!CheckOutTest methodsFor: 'tests' stamp: 'Ciro 6/15/2021 19:11:18'!
test05CanNotCheckoutWithAStolenCreditCard

	| cashier cart sales |
	
	cart _ storeTestSimulator createCart.
	cart add: storeTestSimulator itemSellByTheStore.
	sales _ OrderedCollection new.
	cashier _ Cashier 
			checkout: cart 
			chargingOn: storeTestSimulator invalidCreditCard
			on: DateAndTime today
			registerOn: sales 
			withMerchantProcessor: self.
	isAStolenCreditCard _ true.
	
	self should: [ cashier checkOut ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier canNotDebitFromAStolenCreditCardErrorDescription .
			self assert: sales isEmpty]! !

!CheckOutTest methodsFor: 'tests' stamp: 'Ciro 6/15/2021 18:04:30'!
test06CalculateCheckoutIsCorrect

	| cart cashier sales |
	
	cart _ storeTestSimulator createCart.
	cart add: 3 of: storeTestSimulator itemSellByTheStore.
	sales _ OrderedCollection new.
	cashier _ Cashier 
		checkout: cart 
		chargingOn: storeTestSimulator validCreditCard
		on: DateAndTime today 
		registerOn: sales
		withMerchantProcessor: self.
	
	self assert: cashier checkOut equals: 30.
	self deny: sales isEmpty! !

!CheckOutTest methodsFor: 'tests' stamp: 'Ciro 6/15/2021 18:04:34'!
test07ValidCheckoutRegistersASale

	| cart cashier sales total |
	
	cart _ storeTestSimulator createCart.
	cart add: 3 of: storeTestSimulator itemSellByTheStore.
	sales _ OrderedCollection new.
	cashier _ Cashier 
		checkout: cart 
		chargingOn: storeTestSimulator validCreditCard 
		on: DateAndTime today 
		registerOn: sales
		withMerchantProcessor: self.
	total _ cashier checkOut.
	
	self deny: sales isEmpty.
	self assert: total = sales first.! !

!CheckOutTest methodsFor: 'tests' stamp: 'Ciro 6/15/2021 19:11:30'!
test08CanNotCheckoutWithACreditCardWithNoBalance

	| cart cashier sales |
	
	cart _ storeTestSimulator createCart.
	cart add: 3 of: storeTestSimulator itemSellByTheStore.
	sales _ OrderedCollection new.
	cashier _ Cashier 
			checkout: cart 
			chargingOn: storeTestSimulator invalidCreditCard
			on: DateAndTime today
			registerOn: sales 
			withMerchantProcessor: self.
	creditCardCanDebitTheAmount _ false.
	
	self should: [ cashier checkOut ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier canNotDebitFromACreditCardWithNoBalanceErrorDescription .
			self assert: sales isEmpty]! !

!CheckOutTest methodsFor: 'tests' stamp: 'Ciro 6/15/2021 19:02:34'!
test09ValidCheckoutDebitFromCreditCardCorrectly

	| cart cashier sales total creditCard |
	
	cart _ storeTestSimulator createCart.
	cart add: 3 of: storeTestSimulator itemSellByTheStore.
	sales _ OrderedCollection new.
	creditCard _ storeTestSimulator validCreditCard.
	cashier _ Cashier 
		checkout: cart 
		chargingOn: creditCard
		on: DateAndTime today 
		registerOn: sales
		withMerchantProcessor: self.
	total _ cashier checkOut.
	
	self deny: sales isEmpty.
	self assert: total = debitedAmount.
	self assert: creditCard = debitedCreditCard ! !

!CheckOutTest methodsFor: 'tests' stamp: 'Ciro 6/15/2021 19:11:24'!
test10CanNotCheckoutWithAnInvalidCreditCard

	| cashier cart sales |
	
	cart _ storeTestSimulator createCart.
	cart add: storeTestSimulator itemSellByTheStore.
	sales _ OrderedCollection new.
	cashier _ Cashier 
			checkout: cart 
			chargingOn: storeTestSimulator invalidCreditCard
			on: DateAndTime today
			registerOn: sales 
			withMerchantProcessor: self.
	isAnInvalidCreditCard _ true.
	
	self should: [ cashier checkOut ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier canNotDebitFromAnInvalidCreditCardErrorDescription .
			self assert: sales isEmpty]! !


!CheckOutTest methodsFor: 'debit' stamp: 'Ciro 6/15/2021 19:09:30'!
debit: aNumber from: aCreditCard

	isAStolenCreditCard ifTrue: [self error: Cashier canNotDebitFromAStolenCreditCardErrorDescription].
	
	creditCardCanDebitTheAmount ifFalse: [self error: Cashier canNotDebitFromACreditCardWithNoBalanceErrorDescription].
	
	isAnInvalidCreditCard ifTrue: [self error: Cashier canNotDebitFromAnInvalidCreditCardErrorDescription].
	
	debitedAmount _ aNumber.
	
	debitedCreditCard _ aCreditCard! !


!CheckOutTest methodsFor: 'set up' stamp: 'Ciro 6/15/2021 19:09:45'!
setUp

	storeTestSimulator _ StoreTestSimulator new.
	isAStolenCreditCard _ false.
	creditCardCanDebitTheAmount _ true.
	isAnInvalidCreditCard _ false.! !


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


!Cart methodsFor: 'assertions' stamp: 'Ciro 6/13/2021 17:43:26'!
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


!Cart methodsFor: 'item prices' stamp: 'Ciro 6/15/2021 19:01:02'!
priceFromItemsFor: aCashier

	items do: [ :anItem | aCashier addToTotal: (catalog at: anItem)]! !


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
	instanceVariableNames: 'cart creditCard salesCollection total date merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'Ciro 6/15/2021 18:58:37'!
initializeToCheckout: aCart chargingOn: aCreditCard on: aDate registerOn: aSalesCollection withMerchantProcessor: aMerchantProcessor 

	cart _ aCart.
	creditCard _ aCreditCard.
	date _ aDate.
	salesCollection _ aSalesCollection.
	merchantProcessor _ aMerchantProcessor.
	total _ 0! !


!Cashier methodsFor: 'total' stamp: 'Ciro 6/15/2021 19:01:02'!
addToTotal: aPrice

	total _ total + aPrice! !


!Cashier methodsFor: 'private' stamp: 'Ciro 6/15/2021 19:00:35'!
calculateTotal
	
	cart priceFromItemsFor: self! !

!Cashier methodsFor: 'private' stamp: 'Ciro 6/15/2021 18:07:58'!
debitFromCreditCard

	merchantProcessor debit: total from: creditCard! !

!Cashier methodsFor: 'private' stamp: 'Ciro 6/13/2021 18:09:42'!
registerSale

	salesCollection add: total! !


!Cashier methodsFor: 'check out' stamp: 'Ciro 6/15/2021 18:07:26'!
checkOut

	self calculateTotal.
	self debitFromCreditCard.
	self registerSale.
	
	^ total.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'Ciro 6/15/2021 18:31:47'!
checkout: aCart chargingOn: aCreditCard on: aDate registerOn: aSalesCollecion withMerchantProcessor: aMerchantProcessor

	self assertCartNotEmpty: aCart.
	
	self assertNotExpiredCreditCard: aCreditCard on: aDate.

	^ self new 
		initializeToCheckout: aCart 
		chargingOn: aCreditCard 
		on: aDate 
		registerOn: aSalesCollecion 
		withMerchantProcessor: aMerchantProcessor ! !


!Cashier class methodsFor: 'assertion' stamp: 'Ciro 6/13/2021 16:54:55'!
assertCartNotEmpty: aCart

	aCart isEmpty ifTrue: [ self error: self canNotCheckoutWithAnEmptyCartErrorDescription ]! !

!Cashier class methodsFor: 'assertion' stamp: 'Ciro 6/15/2021 17:42:11'!
assertNotExpiredCreditCard: aCreditCard on: aDate

	(aCreditCard isExpiredOn: aDate) ifTrue: [self error: self canNotCheckoutWithAnExpiredCreditCardErrorDescription]! !


!Cashier class methodsFor: 'error description' stamp: 'Ciro 6/13/2021 16:50:47'!
canNotCheckoutWithAnEmptyCartErrorDescription
	
	^ 'Can not checkout with an empty cart'! !

!Cashier class methodsFor: 'error description' stamp: 'Ciro 6/15/2021 17:42:25'!
canNotCheckoutWithAnExpiredCreditCardErrorDescription
	
	^ 'Can not checkout with an expired credit card'! !

!Cashier class methodsFor: 'error description' stamp: 'Ciro 6/15/2021 18:30:25'!
canNotDebitFromACreditCardWithNoBalanceErrorDescription
	
	^ 'Can not debit from a credit card with no balance'! !

!Cashier class methodsFor: 'error description' stamp: 'Ciro 6/15/2021 19:10:21'!
canNotDebitFromAStolenCreditCardErrorDescription
	
	^ 'Can not debit from a stolen credit card'! !

!Cashier class methodsFor: 'error description' stamp: 'Ciro 6/15/2021 19:10:32'!
canNotDebitFromAnInvalidCreditCardErrorDescription
	
	^ 'Can not debit from an invalid credit card'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'date expiredDate number owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'Ciro 6/15/2021 18:30:48'!
initializeWithNumber: aNumber owner: anOwner expiringOn: aDate
	
	number _ aNumber.
	owner _ anOwner.
	expiredDate _ aDate! !


!CreditCard methodsFor: 'expired' stamp: 'Ciro 6/15/2021 17:25:40'!
isExpiredOn: aDate

	^ expiredDate start < (Month month: aDate monthIndex year: aDate yearNumber) start! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'Ciro 6/15/2021 17:06:01'!
assertNumberOfDigits: aNumber

	(aNumber numberOfDigitsInBase: 10) = 16 ifFalse: [self error: self invalidNumberOfDigitsOfCreditCardErrorDescription]! !

!CreditCard class methodsFor: 'instance creation' stamp: 'Ciro 6/15/2021 17:08:18'!
assertOwner: anOwner

	anOwner withBlanksTrimmed isEmpty ifTrue: [self error: self invalidOwnerOfCreditCardErrorDescription ]! !

!CreditCard class methodsFor: 'instance creation' stamp: 'Ciro 6/15/2021 17:06:25'!
invalidNumberOfDigitsOfCreditCardErrorDescription

	^ 'Invalid number of digits of credit card'! !

!CreditCard class methodsFor: 'instance creation' stamp: 'Ciro 6/15/2021 17:07:38'!
invalidOwnerOfCreditCardErrorDescription

	^ 'Invalid owner of creditc ard'! !

!CreditCard class methodsFor: 'instance creation' stamp: 'Ciro 6/15/2021 18:30:38'!
numbered: aNumber owner: anOwner expireOn: aDate

	self assertNumberOfDigits: aNumber.
	self assertOwner: anOwner.
	
	^ self new initializeWithNumber: aNumber owner: anOwner expiringOn: aDate! !


!classDefinition: #StoreTestSimulator category: 'TusLibros'!
Object subclass: #StoreTestSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestSimulator methodsFor: 'cart' stamp: 'Ciro 6/13/2021 17:49:18'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !


!StoreTestSimulator methodsFor: 'items' stamp: 'Ciro 6/13/2021 17:37:25'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestSimulator methodsFor: 'items' stamp: 'Ciro 6/13/2021 17:37:33'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestSimulator methodsFor: 'items' stamp: 'Ciro 6/15/2021 18:53:38'!
itemSellByTheStorePrice

	^ 10! !


!StoreTestSimulator methodsFor: 'credit card' stamp: 'Ciro 6/15/2021 18:31:34'!
creditCardWithInvalidNumberOfDigits
	
	^ CreditCard 
		numbered: 1 
		owner: 'Ciro' 
		expireOn: (Month month: (DateAndTime now) monthIndex year: (DateAndTime now) yearNumber + 1)! !

!StoreTestSimulator methodsFor: 'credit card' stamp: 'Ciro 6/15/2021 18:31:30'!
creditCardWithInvalidOwner
	
	^ CreditCard 
		numbered: 1111111111111111 
		owner: '' 
		expireOn: (Month month: (DateAndTime now) monthIndex year: (DateAndTime now) yearNumber + 1)! !

!StoreTestSimulator methodsFor: 'credit card' stamp: 'Ciro 6/15/2021 18:31:28'!
expiredCreditCard
	
	^ CreditCard 
		numbered: 1111111111111111 
		owner: 'Ciro' 
		expireOn: (Month month: (DateAndTime now) monthIndex year: (DateAndTime now) yearNumber - 1)! !

!StoreTestSimulator methodsFor: 'credit card' stamp: 'Ciro 6/15/2021 19:11:11'!
invalidCreditCard
	
	^ CreditCard 
		numbered: 1111111111111111 
		owner: 'Ciro' 
		expireOn: (Month month: (DateAndTime now) monthIndex year: (DateAndTime now) yearNumber + 1)! !

!StoreTestSimulator methodsFor: 'credit card' stamp: 'Ciro 6/15/2021 18:31:25'!
validCreditCard
	
	^ CreditCard 
		numbered: 1111111111111111 
		owner: 'Ciro' 
		expireOn: (Month month: (DateAndTime now) monthIndex year: (DateAndTime now) yearNumber + 1)! !


!StoreTestSimulator methodsFor: 'catalog' stamp: 'Ciro 6/15/2021 18:53:38'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !
