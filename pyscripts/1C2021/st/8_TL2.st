!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'debitSimulator validCreditCard expiredCreditCard invalidNameCreditCard invalidNumberCreditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'ijgt 6/15/2021 17:04:11'!
test01canNotCheckoutEmptyCart

	|aCatalogue aCashier aCart aSalesLog|
	aCatalogue := Dictionary new at: 'aBook' put: 5; yourself.
	aSalesLog := OrderedCollection new.
	aCashier := Cashier with: aCatalogue onDate: (Date today) andSalesLog: aSalesLog andMerchantProcessor: self.
	aCart := Cart acceptingItemsOf: aCatalogue keys.
	self should: [
		aCashier checkout: aCart payingWith: expiredCreditCard
		] 
	raise: Error withExceptionDo: [:anError |
		self assert: anError messageText equals: Cashier canNotCheckoutEmptyCartErrorDescription.
		self assert: aSalesLog isEmpty.
		].! !

!CashierTest methodsFor: 'tests' stamp: 'ijgt 6/15/2021 17:04:34'!
test02canNotCheckoutExpiredCreditCard

	|aCatalogue aCashier aCart aSalesLog|
	aCatalogue := Dictionary new at: 'aBook' put: 5; yourself.
	aSalesLog := OrderedCollection new.
	aCashier := Cashier with: aCatalogue onDate: (Date today) andSalesLog: aSalesLog andMerchantProcessor: self.
	aCart := Cart acceptingItemsOf: aCatalogue keys.
	aCart add: 'aBook'.
	self should: [
		aCashier checkout: aCart payingWith: expiredCreditCard
		] 
	raise: Error withExceptionDo: [:anError |
		self assert: anError messageText equals: Cashier canNotCheckoutWithExpiredCreditCardErrorDescription.
		self assert: aSalesLog isEmpty.
		].! !

!CashierTest methodsFor: 'tests' stamp: 'ijgt 6/15/2021 17:05:09'!
test03checkoutLogsSaleWithCorrectPrice

	|aCatalogue aCashier aCart aSalesLog aSale creditCard debitAmount|
	aCatalogue := Dictionary new at: 'aBook' put: 5; yourself.
	aSalesLog := OrderedCollection new.
	aCashier := Cashier with: aCatalogue onDate: (Date today) andSalesLog: aSalesLog andMerchantProcessor: self.
	aCart := Cart acceptingItemsOf: aCatalogue keys.
	aCart add: 'aBook'.
	debitSimulator := [:anAmount :aCreditCard | debitAmount := anAmount. creditCard := aCreditCard ].
	
	aSale := aCashier checkout: aCart payingWith: validCreditCard.
	self assert: creditCard equals: validCreditCard.
	self assert: debitAmount equals: 5.
	self assert: aSalesLog includes: aSale.
	self assert: aSalesLog size equals: 1.
	self assert: aSale price equals: 5! !

!CashierTest methodsFor: 'tests' stamp: 'ijgt 6/15/2021 17:06:35'!
test04canNotCheckoutWithCreditCardWithInsufficientFunds

	|aCatalogue aCashier aCart aSalesLog |
	aCatalogue := Dictionary new at: 'aBook' put: 5; yourself.
	aSalesLog := OrderedCollection new.
	aCashier := Cashier with: aCatalogue onDate: (Date today) andSalesLog: aSalesLog andMerchantProcessor: self.
	debitSimulator := [:anAmount :aCreditCard | 
		self error: Cashier canNotCheckoutCreditCardWithInsufficientFundsErrorDescription ].
	aCart := Cart acceptingItemsOf: aCatalogue keys.
	aCart add: 'aBook'.
	aCashier addCreditCardSimulator: self.
	
	self should: [
		aCashier checkout: aCart payingWith: validCreditCard .
		] 
	raise: Error withExceptionDo: [:anError |
		self assert: anError messageText equals: Cashier canNotCheckoutCreditCardWithInsufficientFundsErrorDescription.
		self assert: aSalesLog isEmpty.
		].! !

!CashierTest methodsFor: 'tests' stamp: 'ijgt 6/15/2021 17:06:24'!
test05canNotCheckoutWithStolenCreditCard

	|aCatalogue aCashier aCart aSalesLog |
	aCatalogue := Dictionary new at: 'aBook' put: 5; yourself.
	aSalesLog := OrderedCollection new.
	aCashier := Cashier with: aCatalogue onDate: (Date today) andSalesLog: aSalesLog andMerchantProcessor: self.
	debitSimulator := [:anAmount :aCreditCard | self error: Cashier canNotDebitWithStolenCreditCardErrorDescription].
	aCart := Cart acceptingItemsOf: aCatalogue keys.
	aCart add: 'aBook'.
	aCashier addCreditCardSimulator: self.
	
	self should: [
		aCashier checkout: aCart payingWith: validCreditCard .
		] 
	raise: Error withExceptionDo: [:anError |
		self assert: anError messageText equals: Cashier canNotDebitWithStolenCreditCardErrorDescription.
		self assert: aSalesLog isEmpty.
		].! !

!CashierTest methodsFor: 'tests' stamp: 'ijgt 6/16/2021 22:43:24'!
test06creditCardInvalidName

    |aCatalogue aCashier aCart aSalesLog|
    aCatalogue := Dictionary new at: 'aBook' put: 5; yourself.
    aSalesLog := OrderedCollection new.
    aCashier := Cashier with: aCatalogue onDate: (Date today) andSalesLog: aSalesLog andMerchantProcessor: self.
    aCart := Cart acceptingItemsOf: aCatalogue keys.
    aCart add: 'aBook'.
    self should: [
        aCashier checkout: aCart payingWith: invalidNameCreditCard 
        ] 
    raise: Error withExceptionDo: [:anError |
        self assert: anError messageText equals: Cashier canNotCheckoutWithInvalidNameCreditCardErrorDescription.
        self assert: aSalesLog isEmpty.
        ]! !

!CashierTest methodsFor: 'tests' stamp: 'ijgt 6/16/2021 22:43:57'!
test07creditCardInvalidNumberContainsSeparators

    |aCatalogue aCashier aCart aSalesLog|
    aCatalogue := Dictionary new at: 'aBook' put: 5; yourself.
    aSalesLog := OrderedCollection new.
    aCashier := Cashier with: aCatalogue onDate: (Date today) andSalesLog: aSalesLog andMerchantProcessor: self.
    aCart := Cart acceptingItemsOf: aCatalogue keys.
    aCart add: 'aBook'.
    self should: [
        aCashier checkout: aCart payingWith: invalidNumberCreditCard 
        ] 
    raise: Error withExceptionDo: [:anError |
        self assert: anError messageText equals: Cashier canNotCheckoutWithInvalidNumberCreditCardErrorDescription.
        self assert: aSalesLog isEmpty.
        ].! !


!CashierTest methodsFor: 'mp simulator' stamp: 'ijgt 6/15/2021 16:26:29'!
debit: aPrice with: aCreditCard

	^ debitSimulator value: aPrice value: aCreditCard! !


!CashierTest methodsFor: 'setUp' stamp: 'ijgt 6/16/2021 22:46:01'!
setUp

	validCreditCard := CreditCard withExpirationDate: (Date today next) andName: 'Mr' andNumber: '111'.
	expiredCreditCard := CreditCard withExpirationDate: (Date today previous) andName: 'Mr' andNumber: '111'.
	invalidNameCreditCard := CreditCard withExpirationDate: (Date today next) andName: 'Ignacio Javier González Tafler Bolainas' andNumber: '111'.
	invalidNumberCreditCard := CreditCard withExpirationDate: (Date today next) andName: 'Calle Falsa' andNumber: '1 1 1'! !


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


!Cart methodsFor: 'assertions' stamp: 'ijgt 6/14/2021 16:06:21'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'ijgt 6/14/2021 15:51:12'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Dictionary new.! !


!Cart methodsFor: 'calculatePrice' stamp: 'ijgt 6/14/2021 19:40:15'!
calculatePriceWithCashier: aCashier

	^ aCashier totalPriceOf: items! !


!Cart methodsFor: 'queries' stamp: 'ijgt 6/14/2021 15:53:56'!
occurrencesOf: anItem

	^items at: anItem ifAbsent: [0]! !


!Cart methodsFor: 'testing' stamp: 'ijgt 6/14/2021 15:54:17'!
includes: anItem

	^items includesKey: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'ijgt 6/14/2021 16:03:56'!
add: anItem

	^ self add: 1 of: anItem! !

!Cart methodsFor: 'adding' stamp: 'ijgt 6/14/2021 15:59:53'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items at: anItem put: (self occurrencesOf: anItem) + aQuantity.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'catalogue date salesLog merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialize' stamp: 'ijgt 6/15/2021 16:33:55'!
initializeWithCatalogue: aCatalogue onDate: aDate andSalesLog: aSalesLog andMerchantProcessor: aMerchantProcessor 
	catalogue := aCatalogue.
	date := aDate.
	salesLog := aSalesLog.
	merchantProcessor := aMerchantProcessor.! !


!Cashier methodsFor: 'totalPrice' stamp: 'ijgt 6/14/2021 19:32:52'!
totalPriceOf: cartItems

	^ cartItems keys sum: [:item | (catalogue at: item) * (cartItems at: item)]! !


!Cashier methodsFor: 'checkout' stamp: 'ijgt 6/16/2021 22:54:34'!
checkout: aCart payingWith: aCreditCard

	|totalPrice|
	
	aCart isEmpty ifTrue: [self error: self class canNotCheckoutEmptyCartErrorDescription.].
	self isAValidCreditCard: aCreditCard.
	
	totalPrice := aCart calculatePriceWithCashier: self.
	merchantProcessor debit: totalPrice with: aCreditCard.
	^ salesLog add: (Sale with: totalPrice).! !


!Cashier methodsFor: 'add card simulator' stamp: 'ijgt 6/14/2021 19:02:43'!
addCreditCardSimulator: aMerchantProcessorSimulator

	merchantProcessor := aMerchantProcessorSimulator ! !


!Cashier methodsFor: 'credit card validation' stamp: 'ijgt 6/16/2021 22:49:06'!
isAValidCreditCard: aCreditCard

    (aCreditCard isExpiredAt: date) ifTrue: [self error: self class canNotCheckoutWithExpiredCreditCardErrorDescription.].
    (aCreditCard hasAValidName) ifFalse:[self error: self class canNotCheckoutWithInvalidNameCreditCardErrorDescription ].
    (aCreditCard hasAValidNumber) ifFalse:[self error: self class canNotCheckoutWithInvalidNumberCreditCardErrorDescription ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'creation' stamp: 'ijgt 6/15/2021 16:33:40'!
with: aCatalogue onDate: aDate andSalesLog: aSalesLog andMerchantProcessor: aMerchantProcessor 

	^ self new initializeWithCatalogue: aCatalogue onDate: aDate andSalesLog: aSalesLog andMerchantProcessor: aMerchantProcessor! !


!Cashier class methodsFor: 'error descriptions' stamp: 'ijgt 6/14/2021 19:09:26'!
canNotCheckoutCreditCardWithInsufficientFundsErrorDescription
	
	^ 'Credit card with insufficient funds.'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'ijgt 6/10/2021 20:34:30'!
canNotCheckoutEmptyCartErrorDescription
	
	^ 'Can not checkout an empty cart.'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'ijgt 6/10/2021 20:45:57'!
canNotCheckoutWithExpiredCreditCardErrorDescription

	^ 'Can not checkout with an expired credit card.'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'ijgt 6/16/2021 22:56:11'!
canNotCheckoutWithInvalidNameCreditCardErrorDescription

	^'Invalid name for a credit card.'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'ijgt 6/16/2021 22:56:39'!
canNotCheckoutWithInvalidNumberCreditCardErrorDescription

   	^'Can not checkout with an invalid credit card number'! !


!Cashier class methodsFor: 'error handling' stamp: 'ijgt 6/15/2021 16:42:31'!
canNotDebitWithStolenCreditCardErrorDescription
	
	^ 'Can not debit with stolen credit card.'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationDate name number'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialize' stamp: 'ijgt 6/15/2021 17:03:22'!
initializeWith: aDate andName: aName andNumber: aNumber  

	expirationDate := aDate.
	name := aName.
	number := aNumber.! !


!CreditCard methodsFor: 'queries' stamp: 'ijgt 6/16/2021 22:50:46'!
hasAValidName

	^ name size between: 1 and: 30! !

!CreditCard methodsFor: 'queries' stamp: 'ijgt 6/16/2021 22:52:37'!
hasAValidNumber

	^ (number = number withoutSeparators) and: (number allSatisfy: [:aChar | aChar isDigit])! !

!CreditCard methodsFor: 'queries' stamp: 'ijgt 6/10/2021 20:48:20'!
isExpiredAt: aDate

	^ expirationDate < aDate! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'creation' stamp: 'ijgt 6/16/2021 22:46:36'!
withExpirationDate: aDate andName: aName andNumber: aNumber  

	^ self new initializeWith: aDate andName: aName andNumber: aNumber! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'price'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'initialization' stamp: 'ijgt 6/15/2021 17:01:26'!
initializeWith: aPrice andName: aName andNumber: aNumber  

	price := aPrice ! !


!Sale methodsFor: 'price' stamp: 'ijgt 6/14/2021 18:39:17'!
price
	
	^ price! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'creation' stamp: 'ijgt 6/15/2021 17:01:26'!
with: aPrice

	^ self new initializeWith: aPrice andName: 'Mr' andNumber: 1111! !
