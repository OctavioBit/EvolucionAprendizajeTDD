!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'objectsBuilder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'LM 6/14/2021 09:41:58'!
test01NewCartsAreCreatedEmpty

	self assert: objectsBuilder createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'LM 6/14/2021 09:42:11'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := objectsBuilder createCart.
	
	self 
		should: [ cart add: objectsBuilder itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'LM 6/14/2021 09:42:21'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := objectsBuilder createCart.
	
	cart add: objectsBuilder itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'LM 6/14/2021 09:42:33'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := objectsBuilder createCart.
	
	self 
		should: [cart add: 0 of: objectsBuilder itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'LM 6/14/2021 09:42:40'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := objectsBuilder createCart.
	
	self 
		should: [cart add: 2 of: objectsBuilder itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'LM 6/14/2021 09:42:53'!
test06CartRemembersAddedItems

	| cart |
	
	cart := objectsBuilder createCart.
	
	cart add: objectsBuilder itemSellByTheStore.
	self assert: (cart includes: objectsBuilder itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'LM 6/14/2021 09:42:59'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := objectsBuilder createCart.
	
	self deny: (cart includes: objectsBuilder itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'LM 6/14/2021 09:43:07'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := objectsBuilder createCart.
	
	cart add: 2 of: objectsBuilder itemSellByTheStore.
	self assert: (cart occurrencesOf: objectsBuilder itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setUp' stamp: 'LM 6/14/2021 09:45:45'!
setUp

	objectsBuilder := TestObjectsBuilder new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'objectsBuilder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'LM 6/17/2021 14:17:47'!
test01CannotCheckOutEmptyCart

	| cart cashier creditCard salesBook mockMerchantProcessor |
	
	creditCard := objectsBuilder createNotExpiredCreditCard.
	mockMerchantProcessor := ValidCCMerchantProcessor new.
	cart := objectsBuilder createCart.
	cashier := objectsBuilder createCashier: mockMerchantProcessor.
	salesBook := OrderedCollection new.
	
	self should: [ cashier checkOut: cart payingWith: creditCard on: objectsBuilder today registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withMessageText: Cashier cannotCheckOutEmptyCartErrorDescription.! !

!CashierTest methodsFor: 'tests' stamp: 'LM 6/17/2021 14:17:38'!
test02CheckOutAmountOfCartWithItemsEqualsTotalOfItemsPrices

	| cart cashier creditCard expectedTotal salesBook mockMerchantProcessor |
	
	creditCard := objectsBuilder createNotExpiredCreditCard.
	expectedTotal := objectsBuilder defaultPriceList at: objectsBuilder itemSellByTheStore.
	mockMerchantProcessor := ValidCCMerchantProcessor new.
	cart := objectsBuilder createCart.
	cashier := objectsBuilder createCashier: mockMerchantProcessor.
	salesBook := OrderedCollection new.
	
	cart add: objectsBuilder itemSellByTheStore.
	
	self assert: expectedTotal equals: (cashier checkOut: cart payingWith: creditCard on: objectsBuilder today registeringOn: salesBook).! !

!CashierTest methodsFor: 'tests' stamp: 'LM 6/17/2021 14:17:29'!
test03CannotCheckOutWithExpiredCreditCard

	| cart cashier creditCard salesBook mockMerchantProcessor |
	
	creditCard := objectsBuilder createExpiredCreditCard.
	mockMerchantProcessor := ValidCCMerchantProcessor new.
	cart := objectsBuilder createCart.
	cashier := objectsBuilder createCashier: mockMerchantProcessor.
	salesBook := OrderedCollection new.
	
	cart add: objectsBuilder itemSellByTheStore.
	
	self should: [ cashier checkOut: cart
					payingWith: creditCard
					on: objectsBuilder today
					registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: Cashier expiredCreditCardErrorDescription equals: error messageText.
			self assert: salesBook isEmpty.
		]! !

!CashierTest methodsFor: 'tests' stamp: 'LM 6/17/2021 14:17:15'!
test04CheckOutRegistersSale

	| cart cashier creditCard expectedTotal salesBook mockMerchantProcessor |
	
	creditCard := objectsBuilder createNotExpiredCreditCard.
	expectedTotal := objectsBuilder defaultPriceList at: objectsBuilder itemSellByTheStore.
	mockMerchantProcessor := ValidCCMerchantProcessor new.
	cart := objectsBuilder createCart.
	cashier := objectsBuilder createCashier: mockMerchantProcessor.
	salesBook := OrderedCollection new.
	
	cart add: objectsBuilder itemSellByTheStore.
	cashier checkOut: cart payingWith: creditCard on: objectsBuilder today registeringOn: salesBook.
	
	self assert: 1 equals: salesBook size.
	self assert: expectedTotal equals: salesBook first.! !

!CashierTest methodsFor: 'tests' stamp: 'LM 6/17/2021 14:16:48'!
test05CannotCheckOutWhenCreditCardHasNotEnoughFunds

	| cart cashier creditCard salesBook mockMerchantProcessor |
	
	creditCard := objectsBuilder createNotExpiredCreditCard.
	mockMerchantProcessor := NotEnoughFundsMerchantProcessor new.
	cart := objectsBuilder createCart.
	cashier := objectsBuilder createCashier: mockMerchantProcessor.
	salesBook := OrderedCollection new.
	
	cart add: objectsBuilder itemSellByTheStore.
	
	self should: [ cashier checkOut: cart payingWith: creditCard on: objectsBuilder today registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withMessageText: NotEnoughFundsMerchantProcessor creditCardHasNotEnoughFundsErrorDescription.! !

!CashierTest methodsFor: 'tests' stamp: 'LM 6/17/2021 14:16:44'!
test06CannotCheckOutWhenCreditCardHasBeenStolen

	| cart cashier creditCard salesBook mockMerchantProcessor |
	
	creditCard := objectsBuilder createNotExpiredCreditCard.
	mockMerchantProcessor := StolenCCMerchantProcessor new.
	cart := objectsBuilder createCart.
	cashier := objectsBuilder createCashier: mockMerchantProcessor.
	salesBook := OrderedCollection new.
	
	cart add: objectsBuilder itemSellByTheStore.
	
	self should: [ cashier checkOut: cart payingWith: creditCard on: objectsBuilder today registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withMessageText: StolenCCMerchantProcessor creditCardHasBeenStolenErrorDescription.! !

!CashierTest methodsFor: 'tests' stamp: 'LM 6/17/2021 14:15:53'!
test07CannotCheckOutWhenCreditCardIsFake

	| cart cashier creditCard salesBook mockMerchantProcessor |
	
	creditCard := objectsBuilder createNotExpiredCreditCard.
	mockMerchantProcessor := FakeCCMerchantProcessor new.
	cart := objectsBuilder createCart.
	cashier := objectsBuilder createCashier: mockMerchantProcessor.
	salesBook := OrderedCollection new.
	
	cart add: objectsBuilder itemSellByTheStore.
	
	self should: [ cashier checkOut: cart payingWith: creditCard on: objectsBuilder today registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withMessageText: FakeCCMerchantProcessor creditCardIsFakeErrorDescription.! !


!CashierTest methodsFor: 'setUp' stamp: 'LM 6/14/2021 09:45:55'!
setUp

	objectsBuilder := TestObjectsBuilder new.! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'LM 6/17/2021 14:29:22'!
test01CannotCreateCreditCardWithEmptyOwner

	self should: [ CreditCard number: 5574822318795416 validThru: (December of: 3000) owner: '' ]
		raise: Error - MessageNotUnderstood
		withMessageText: CreditCard ownerCannotBeEmptyErrorDescription.! !

!CreditCardTest methodsFor: 'tests' stamp: 'LM 6/17/2021 14:29:22'!
test02CannotCreateCreditCardWithNumberSizeDifferentTo16

	self should: [ CreditCard number: 557482231416 validThru: (December of: 3000) owner: 'Dan Ingalls' ]
		raise: Error - MessageNotUnderstood
		withMessageText: CreditCard numberMustHave16DigitsErrorDescription.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'priceList items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'LM 6/14/2021 09:25:35'!
assertIsValidItem: anItem

	(priceList includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'LM 6/14/2021 09:25:47'!
initializeAcceptingItemsOf: aPriceList

	priceList := aPriceList.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'LM 6/14/2021 09:31:02'!
totalPrice

	^items sum: [ :anItem | priceList at: anItem ] ifEmpty: [0 * peso]! !


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

!Cart class methodsFor: 'instance creation' stamp: 'LM 6/14/2021 09:26:07'!
acceptingItemsOf: aPriceList

	^self new initializeAcceptingItemsOf: aPriceList ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'assertions' stamp: 'LM 6/14/2021 10:34:34'!
assertCartIsNotEmpty: aCart

	^ aCart isEmpty ifTrue: [ self error: self class cannotCheckOutEmptyCartErrorDescription ]! !

!Cashier methodsFor: 'assertions' stamp: 'LM 6/14/2021 18:56:30'!
assertCreditCardHasNotExpired: aCreditCard on: aDate 

	^ (aCreditCard hasExpiredOn: aDate) ifTrue: [ self error: self class expiredCreditCardErrorDescription ]! !


!Cashier methodsFor: 'checkOut' stamp: 'LM 6/17/2021 13:53:13'!
checkOut: aCart payingWith: aCreditCard on: aDate registeringOn: aSalesBook  

	| totalPrice |
	
	self assertCartIsNotEmpty: aCart.
	self assertCreditCardHasNotExpired: aCreditCard on: aDate.
	
	totalPrice := aCart totalPrice.
	merchantProcessor charge: totalPrice to: aCreditCard.
	aSalesBook add: totalPrice.
	^totalPrice! !


!Cashier methodsFor: 'initialization' stamp: 'LM 6/17/2021 13:51:13'!
initializeWith: aMerchantProcessor

	merchantProcessor := aMerchantProcessor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error description' stamp: 'LM 6/10/2021 20:01:40'!
cannotCheckOutEmptyCartErrorDescription

	^'Cannot check out empty cart'! !

!Cashier class methodsFor: 'error description' stamp: 'LM 6/14/2021 10:22:23'!
expiredCreditCardErrorDescription

	^'This credit card has expired'! !


!Cashier class methodsFor: 'instance creation' stamp: 'LM 6/17/2021 13:50:45'!
with: aMerchantProcessor

	^self new initializeWith: aMerchantProcessor! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'LM 6/17/2021 14:31:29'!
initializeValidThru: aCCExpirationDate  

	expiration := aCCExpirationDate.! !


!CreditCard methodsFor: 'testing' stamp: 'LM 6/17/2021 14:29:57'!
hasExpiredOn: aDate

	^expiration < aDate monthOfYear! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'LM 6/14/2021 18:59:47'!
assertIsValidNumber: aCCNumber

	^ (aCCNumber numberOfDigitsInBase: 10) ~= 16 ifTrue: [ self error: self numberMustHave16DigitsErrorDescription ]! !

!CreditCard class methodsFor: 'instance creation' stamp: 'LM 6/14/2021 19:02:05'!
assertIsValidOwner: aCCOwner

	^ aCCOwner withBlanksTrimmed isEmpty ifTrue: [ self error: self ownerCannotBeEmptyErrorDescription ]! !

!CreditCard class methodsFor: 'instance creation' stamp: 'LM 6/17/2021 14:31:29'!
number: aCCNumber validThru: aCCExpirationDate owner: aCCOwner

	self assertIsValidOwner: aCCOwner.
	self assertIsValidNumber: aCCNumber.
	
	^self new initializeValidThru: aCCExpirationDate ! !


!CreditCard class methodsFor: 'error description' stamp: 'LM 6/14/2021 10:54:48'!
numberMustHave16DigitsErrorDescription

	^'Card number must have 16 digits'! !

!CreditCard class methodsFor: 'error description' stamp: 'LM 6/14/2021 10:49:11'!
ownerCannotBeEmptyErrorDescription

	^'Owner cannot be empty'! !


!classDefinition: #MerchantProcessor category: 'TusLibros'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'payments' stamp: 'LM 6/17/2021 14:09:27'!
charge: aPrice to: aCreditCard

	self subclassResponsibility! !


!classDefinition: #FakeCCMerchantProcessor category: 'TusLibros'!
MerchantProcessor subclass: #FakeCCMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!FakeCCMerchantProcessor methodsFor: 'payments' stamp: 'LM 6/17/2021 14:12:06'!
charge: aPrice to: aCreditCard

	self error: self class creditCardIsFakeErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FakeCCMerchantProcessor class' category: 'TusLibros'!
FakeCCMerchantProcessor class
	instanceVariableNames: ''!

!FakeCCMerchantProcessor class methodsFor: 'error description' stamp: 'LM 6/17/2021 14:11:34'!
creditCardIsFakeErrorDescription

	^'This credit card is fake'! !


!classDefinition: #NotEnoughFundsMerchantProcessor category: 'TusLibros'!
MerchantProcessor subclass: #NotEnoughFundsMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!NotEnoughFundsMerchantProcessor methodsFor: 'payments' stamp: 'LM 6/17/2021 14:12:11'!
charge: aPrice to: aCreditCard

	self error: self class creditCardHasNotEnoughFundsErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NotEnoughFundsMerchantProcessor class' category: 'TusLibros'!
NotEnoughFundsMerchantProcessor class
	instanceVariableNames: ''!

!NotEnoughFundsMerchantProcessor class methodsFor: 'error description' stamp: 'LM 6/17/2021 14:11:09'!
creditCardHasNotEnoughFundsErrorDescription

	^'This credit card has not got enough funds'! !


!classDefinition: #StolenCCMerchantProcessor category: 'TusLibros'!
MerchantProcessor subclass: #StolenCCMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StolenCCMerchantProcessor methodsFor: 'payments' stamp: 'LM 6/17/2021 14:12:17'!
charge: aPrice to: aCreditCard

	self error: self class creditCardHasBeenStolenErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StolenCCMerchantProcessor class' category: 'TusLibros'!
StolenCCMerchantProcessor class
	instanceVariableNames: ''!

!StolenCCMerchantProcessor class methodsFor: 'error description' stamp: 'LM 6/17/2021 14:10:50'!
creditCardHasBeenStolenErrorDescription

	^'This credit card has been stolen'! !


!classDefinition: #ValidCCMerchantProcessor category: 'TusLibros'!
MerchantProcessor subclass: #ValidCCMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ValidCCMerchantProcessor methodsFor: 'payments' stamp: 'LM 6/17/2021 14:00:05'!
charge: aPrice to: aCreditCard 

	! !


!classDefinition: #TestObjectsBuilder category: 'TusLibros'!
Object subclass: #TestObjectsBuilder
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestObjectsBuilder methodsFor: 'initialization' stamp: 'LM 6/17/2021 13:14:54'!
initialize

	today := FixedGregorianDate today.! !


!TestObjectsBuilder methodsFor: 'objects creation' stamp: 'LM 6/14/2021 09:38:47'!
createCart

	^Cart acceptingItemsOf: self defaultPriceList! !

!TestObjectsBuilder methodsFor: 'objects creation' stamp: 'LM 6/17/2021 13:50:13'!
createCashier: aMerchantProcessor

	^Cashier with: aMerchantProcessor! !

!TestObjectsBuilder methodsFor: 'objects creation' stamp: 'LM 6/17/2021 14:29:22'!
createExpiredCreditCard

	^CreditCard number: 5574822318795416 validThru: (self currentMonthOfYear next: -1 * month) owner: 'Dan Ingalls'! !

!TestObjectsBuilder methodsFor: 'objects creation' stamp: 'LM 6/17/2021 14:29:22'!
createNotExpiredCreditCard

	^CreditCard number: 5574822318795416 validThru: (self currentMonthOfYear next: 1 * month) owner: 'Dan Ingalls'! !

!TestObjectsBuilder methodsFor: 'objects creation' stamp: 'LM 6/14/2021 09:39:07'!
defaultPriceList
	
	^ Dictionary newFromPairs: {self itemSellByTheStore . 400 * peso}! !

!TestObjectsBuilder methodsFor: 'objects creation' stamp: 'LM 6/14/2021 09:39:32'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!TestObjectsBuilder methodsFor: 'objects creation' stamp: 'LM 6/14/2021 09:39:18'!
itemSellByTheStore

	^'validBook'! !


!TestObjectsBuilder methodsFor: 'date' stamp: 'LM 6/17/2021 13:15:34'!
currentMonthOfYear

	^today monthOfYear! !

!TestObjectsBuilder methodsFor: 'date' stamp: 'LM 6/17/2021 13:15:18'!
today

	^today! !
