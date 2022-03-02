!classDefinition: #NotEnoughCreditError category: #TusLibros!
Error subclass: #NotEnoughCreditError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!classDefinition: #StolenCreditCardError category: #TusLibros!
Error subclass: #StolenCreditCardError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!classDefinition: #CartTest category: #TusLibros!
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

!CartTest methodsFor: 'support' stamp: 'eb 11/26/2020 17:31:00'!
defaultCatalog
	| catalog |
	
	catalog _ Dictionary new .
	
	catalog at: self itemSellByTheStore put: 10.
	^ catalog .! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'setUp/tearDown' stamp: 'ja 11/21/2020 17:59:08'!
setUp

	merchantProcessor _ MerchantProcessorSimulator new.! !


!CashierTest methodsFor: 'test' stamp: 'eb 11/26/2020 16:52:56'!
test01CashierCanNotCheckoutWithEmptyCart
	| cashier cart aCatalog creditCard previousTransactionId |
	
	cashier _ Cashier new.
	aCatalog _ Dictionary new.
	creditCard  _ CreditCard of: 'Alan Kay' withNumber: 1234567891011121 andExpiration: GregorianMonthOfYear current.
	cart _ Cart acceptingItemsOf: aCatalog.
	previousTransactionId _ cashier lastTransactionId .
	
	self should: [ cashier checkout: cart with: creditCard using: merchantProcessor . self fail] 
		raise: Error
		withMessageText: Cashier canNotCheckoutForEmptyCartErrorDescription.
		
	self assert: cashier lastTransactionId equals: previousTransactionId .
! !

!CashierTest methodsFor: 'test' stamp: 'eb 11/26/2020 16:49:02'!
test02CashierCheckoutWithCartWithAnElement

	| cashier cart aCatalog creditCard ticket |
	
	cashier _ Cashier new.
	aCatalog _ Dictionary new.
	aCatalog add: 'book1' -> 2.
	creditCard  _ CreditCard of: 'Alan Kay' withNumber: 1234567891011121 andExpiration: GregorianMonthOfYear current.
	cart _ Cart acceptingItemsOf: aCatalog.
	cart add: 'book1' .
	ticket _ cashier checkout: cart with: creditCard using: merchantProcessor.
	
	self assert: cart price equals: ticket amount.
	self assert: cashier lastTransactionId equals: ticket transactionId.! !

!CashierTest methodsFor: 'test' stamp: 'eb 11/26/2020 16:49:30'!
test03CashierCheckoutWithCartWithManyElements
	| cashier cart aCatalog creditCard ticket |
	cashier _ Cashier new.
	aCatalog _ Dictionary new.
	aCatalog add: 'book1' -> 2; add: 'book2' -> 3; add: 'book3' -> 4.
	creditCard  _ CreditCard of: 'Alan Kay' withNumber: 1234567891011121 andExpiration: GregorianMonthOfYear current.
	cart _ Cart acceptingItemsOf: aCatalog.
	cart add: 'book1'.
	cart add: 2 of: 'book2'. 
	ticket _ cashier checkout: cart with: creditCard using: merchantProcessor.
	
	self assert: cart price equals: ticket amount.
	
	self assert: cashier lastTransactionId equals: ticket transactionId.! !

!CashierTest methodsFor: 'test' stamp: 'eb 11/26/2020 17:10:13'!
test04CanNotBuyWithStolenCreditCard
	| cashier cart aCatalog creditCard previousTransactionId |
	cashier _ Cashier new.
	aCatalog _ Dictionary new.
	aCatalog add: 'book1' -> 2; add: 'book2' -> 3; add: 'book3' -> 4.
	creditCard  _ CreditCard of: 'Alan Kay' withNumber: 1234567891011121 andExpiration: GregorianMonthOfYear current.
	cart _ Cart acceptingItemsOf: aCatalog.
	cart add: 'book1'.
	
	previousTransactionId _ cashier lastTransactionId .
	self should: [cashier checkout: cart with: creditCard using: merchantProcessor withStolenCreditCard . self fail]
		raise: Error  
		withMessageText: Cashier canNotCheckoutWithStolenCreditCardErrorDescription .
	self assert: cashier lastTransactionId equals: previousTransactionId .	
! !

!CashierTest methodsFor: 'test' stamp: 'eb 11/26/2020 17:10:25'!
test05CanNotBuyWithNotEnoughCredit
	| cashier cart aCatalog creditCard previousTransactionId |
	cashier _ Cashier new.
	aCatalog _ Dictionary new.
	aCatalog add: 'book1' -> 2; add: 'book2' -> 3; add: 'book3' -> 4.
	creditCard  _ CreditCard of: 'Alan Kay' withNumber: 1234567891011121 andExpiration: GregorianMonthOfYear current.
	cart _ Cart acceptingItemsOf: aCatalog.
	cart add: 'book1'.
	
	previousTransactionId _ cashier lastTransactionId .
	self should: [cashier checkout: cart with: creditCard using: merchantProcessor withNotEnoughCredit . self fail]
		raise: Error  
		withMessageText: Cashier canNotCheckoutWithNotEnoughCreditErrorDescription .
	self assert: cashier lastTransactionId equals: previousTransactionId .	
! !


!classDefinition: #CreditCardTest category: #TusLibros!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'test' stamp: 'eb 11/26/2020 16:23:53'!
test01CreditCardOwnerNameCanNotBeEmpty

	self should:[ CreditCard of: '' withNumber: 1234567891011121 andExpiration: GregorianMonthOfYear current. self fail]
		raise: Error
		withMessageText: CreditCard ownerNameCanNotBeEmptyErrorDescription.! !

!CreditCardTest methodsFor: 'test' stamp: 'eb 11/26/2020 16:24:02'!
test02CreditCardNumberMustHaveSixteenDigits

	self should:[ CreditCard of: 'Alan Kay' withNumber: 0 andExpiration: GregorianMonthOfYear current. self fail]
		raise: Error
		withMessageText: CreditCard numberMustHaveSixteenDigitsErrorDescription.! !

!CreditCardTest methodsFor: 'test' stamp: 'eb 11/26/2020 16:26:19'!
test03CreditCardExpirationMonthCanNotBeLessThanCurrent

	self should:[ CreditCard of: 'Alan Kay' withNumber: 1234567891011121 andExpiration: (GregorianMonthOfYear yearNumber: 2020 monthNumber: 1). self fail]
		raise: Error
		withMessageText: CreditCard monthCanNotBeLessThanCurrentErrorDescription.! !


!classDefinition: #Cart category: #TusLibros!
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


!Cart methodsFor: 'assertions' stamp: 'ja 11/21/2020 18:04:41'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'eb 11/26/2020 17:26:51'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'eb 11/26/2020 17:26:40'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'ja 11/21/2020 18:17:16'!
price

	^ items sum:[ :item| catalog at: item ] ifEmpty: [0].! !


!Cart methodsFor: 'testing' stamp: 'eb 11/26/2020 17:26:56'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'eb 11/26/2020 17:27:52'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ] .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'lastTransactionId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout' stamp: 'eb 11/26/2020 17:15:48'!
checkout: aCart with: aCreditCard using: aMerchantProcessor
	| price |
	(aCart isEmpty) ifTrue: [ self error: self class canNotCheckoutForEmptyCartErrorDescription ].
	price _ aCart price.
	[ aMerchantProcessor pay: price with: aCreditCard ] 
		on: StolenCreditCardError 
		do: [ self error: self class canNotCheckoutWithStolenCreditCardErrorDescription ]
		on: NotEnoughCreditError 
		do: [ self error: self class canNotCheckoutWithNotEnoughCreditErrorDescription ].
		
	lastTransactionId _ lastTransactionId + 1.
		
	^ Ticket with: lastTransactionId of: price .! !


!Cashier methodsFor: 'initialization' stamp: 'eb 11/26/2020 16:46:05'!
initialize
	
	super initialize .
	
	lastTransactionId _ 0.! !


!Cashier methodsFor: 'accessing' stamp: 'eb 11/26/2020 16:46:34'!
lastTransactionId
	
	^ lastTransactionId .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'ja 11/21/2020 17:33:32'!
canNotCheckoutForEmptyCartErrorDescription
	
	^ 'Can not checkout for empty cart'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'eb 11/26/2020 17:09:38'!
canNotCheckoutWithNotEnoughCreditErrorDescription
	
	^ 'Can not checkout with not enough credit'.! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'eb 11/26/2020 17:09:43'!
canNotCheckoutWithStolenCreditCardErrorDescription
	
	^ 'Can not checkout with stolen credit card'.! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'number expiration owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'ja 11/21/2020 17:04:35'!
of: anOwner withNumber: aNumber andExpiration: anExpiration 

	number _ aNumber .
	owner _ anOwner .
	expiration _ anExpiration .	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'eb 11/26/2020 16:21:51'!
of: anOwner withNumber: aNumber andExpiration: anExpiration

	(anOwner isEmpty) ifTrue: [ self error: self ownerNameCanNotBeEmptyErrorDescription ].
	(aNumber asString size ~= 16) ifTrue: [ self error: self numberMustHaveSixteenDigitsErrorDescription ].
	(anExpiration < GregorianMonthOfYear current) ifTrue: [ self error: self monthCanNotBeLessThanCurrentErrorDescription ].

	^ self new of: anOwner withNumber: aNumber andExpiration: anExpiration .! !


!CreditCard class methodsFor: 'error descriptions' stamp: 'eb 11/26/2020 16:21:51'!
monthCanNotBeLessThanCurrentErrorDescription
	
	^ 'Date can not be less than today'! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'ja 11/21/2020 17:08:56'!
numberMustHaveSixteenDigitsErrorDescription
	
	^ ' Number must have sixteen digits '! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'eb 11/26/2020 16:19:01'!
ownerNameCanNotBeEmptyErrorDescription
	
	^ 'Owner name can not be empty'! !


!classDefinition: #MerchantProcessorSimulator category: #TusLibros!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'operations' stamp: 'eb 11/26/2020 17:21:35'!
pay: aPrice with: aCreditCard 
	(state = #StolenCreditCard) ifTrue: [ StolenCreditCardError signal ] .
	
	(state = #NotEnoughCredit) ifTrue: [ NotEnoughCreditError signal ] .
	^ self .
! !


!MerchantProcessorSimulator methodsFor: 'initialization' stamp: 'eb 11/26/2020 16:58:51'!
initialize
	state _ #WorkingNormal. ! !


!MerchantProcessorSimulator methodsFor: 'state' stamp: 'eb 11/26/2020 17:08:13'!
withNotEnoughCredit
	
	state _ #NotEnoughCredit.
	
	^ self .! !

!MerchantProcessorSimulator methodsFor: 'state' stamp: 'eb 11/26/2020 17:06:53'!
withStolenCreditCard
	
	state _ #StolenCreditCard.
	
	^ self .! !


!classDefinition: #Ticket category: #TusLibros!
Object subclass: #Ticket
	instanceVariableNames: 'transactionId amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Ticket methodsFor: 'initialization' stamp: 'eb 11/26/2020 16:41:29'!
initializeWith: aTransactionId of: anAmount

	transactionId _ aTransactionId .
	
	amount _ anAmount .! !


!Ticket methodsFor: 'accessing' stamp: 'eb 11/26/2020 16:40:44'!
amount

	^ amount .! !

!Ticket methodsFor: 'accessing' stamp: 'eb 11/26/2020 16:40:32'!
transactionId

	^ transactionId .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ticket class' category: #TusLibros!
Ticket class
	instanceVariableNames: ''!

!Ticket class methodsFor: 'instance creation' stamp: 'eb 11/26/2020 16:42:17'!
with: aTransactionId of: anAmount

	^ self new initializeWith: aTransactionId of: anAmount .! !
