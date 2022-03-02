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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'ET 6/16/2021 18:26:03'!
test01CanNotCheckoutEmptyCart

	|cart cashier aSalesBook |

	cart := self createCart.
	
	aSalesBook := OrderedCollection new.
	cashier := self newCashierWithSalesBook: aSalesBook.
	
	self should: [cashier checkout: cart withCreditCard: self validCreditCard.]
	 raise: Error
	 withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier emptyCartErrorDescription. 
			self assert: aSalesBook isEmpty.]! !

!CashierTest methodsFor: 'tests' stamp: 'ET 6/16/2021 18:16:46'!
test02CanNotCheckoutCartWithNonPricedItem

	|cart cashier aSalesBook |
	
	cart := self createCart.
	cart add: self itemInStore.
	
	aSalesBook := OrderedCollection new.
	
	cashier := self newCashierWithPriceList: Dictionary new salesBook: aSalesBook.
	
	self should: [cashier checkout: cart withCreditCard: self validCreditCard]
	 raise: Error
	 withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier itemNotInPriceListErrorDescription. 
			self assert: aSalesBook isEmpty]! !

!CashierTest methodsFor: 'tests' stamp: 'ET 6/16/2021 18:27:08'!
test03CheckoutCartWithOneItemReturnsThePriceOfThatItem

	|cart cashier aSalesBook |
	
	cart := self createCart.
	cart add: self itemInStore.
	
	
	aSalesBook := OrderedCollection new.
	cashier := self newCashierWithSalesBook: aSalesBook.
	
	self assert: 1 equals:  (cashier checkout: cart withCreditCard: self validCreditCard).
	self assert: 1 equals: aSalesBook size.
	self assert: self itemInStorePrice equals: aSalesBook first.! !

!CashierTest methodsFor: 'tests' stamp: 'ET 6/16/2021 18:27:16'!
test04CheckoutCartWithManyItemsReturnsTheSumOfThePricesOfThoseItems

	|cart cashier aSalesBook |

	cart := self createCart.
	cart add: 2 of: self itemInStore.
	
	
	aSalesBook := OrderedCollection new.
	cashier := self newCashierWithSalesBook: aSalesBook.
	self assert: 2 equals:  (cashier checkout: cart withCreditCard: self validCreditCard).
	self assert: 1 equals: aSalesBook size.
	self assert: 2 * self itemInStorePrice equals: aSalesBook first.! !

!CashierTest methodsFor: 'tests' stamp: 'ET 6/16/2021 18:27:26'!
test05CanNotCheckoutWithExpiredCreditCard

	|cart cashier aSalesBook |
	
	cart := self createCart.
	cart add: self itemInStore.
	
	aSalesBook := OrderedCollection new.
	cashier := self newCashierWithSalesBook: aSalesBook.
	
	self should: [ (cashier checkout: cart withCreditCard: self expiredCreditCard)]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier expiredCreditCardErrorDescription.
			self assert: aSalesBook isEmpty ]	.
		
		
		! !

!CashierTest methodsFor: 'tests' stamp: 'ET 6/16/2021 18:28:26'!
test06CanNotCheckoutIfMerchantProcessorRaisesError

	|cart cashier aSalesBook messageError |

	cart := self createCart.
	cart add: self itemInStore.

	messageError := 'Something unexpected happened'.
	
	aSalesBook := OrderedCollection new.
	cashier := Cashier with: self defaultPriceList registerSalesOn: aSalesBook merchantProcessor: (self createMerchantProcessorThatRaisesError: messageError).
	
	
	self should: [ (cashier checkout: cart withCreditCard: self validCreditCard )]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
			self assert: anError messageText = messageError.
			self assert: aSalesBook isEmpty ]	.
		
		
		! !


!CashierTest methodsFor: 'support' stamp: 'ET 6/16/2021 18:16:22'!
createCart

	^Cart acceptingItemsOf: self defaultPriceList keys.! !

!CashierTest methodsFor: 'support' stamp: 'ET 6/16/2021 18:29:03'!
createMerchantProcessorThatRaisesError: messageError
	|aMerchantProcessor|
	aMerchantProcessor := MerchantProcessorSimulator new.
	aMerchantProcessor raiseErrorOnCharge: messageError.
	^aMerchantProcessor

		
		
		! !

!CashierTest methodsFor: 'support' stamp: 'ET 6/16/2021 18:12:36'!
defaultPriceList

	^Dictionary with: self itemInStore -> self itemInStorePrice.! !

!CashierTest methodsFor: 'support' stamp: 'ET 6/10/2021 20:40:54'!
expiredCreditCard

	^ CreditCard owner: 'owner' number: '1234567891011121' expiration: GregorianMonthOfYear current previous.! !

!CashierTest methodsFor: 'support' stamp: 'ET 6/16/2021 18:12:56'!
itemInStore

	^'book in store'.! !

!CashierTest methodsFor: 'support' stamp: 'ET 6/16/2021 18:13:19'!
itemInStorePrice

	^1.! !

!CashierTest methodsFor: 'support' stamp: 'ET 6/16/2021 17:19:41'!
newCashierWithPriceList: aPriceList salesBook: aSalesBook
	
	^Cashier with: aPriceList registerSalesOn: aSalesBook merchantProcessor: MerchantProcessorSimulator new.
		
		! !

!CashierTest methodsFor: 'support' stamp: 'ET 6/16/2021 18:35:23'!
newCashierWithSalesBook: aSalesBook
	
	^self newCashierWithPriceList: self defaultPriceList salesBook: aSalesBook.
		
		! !

!CashierTest methodsFor: 'support' stamp: 'ET 6/10/2021 20:38:58'!
validCreditCard

	^ CreditCard owner: 'owner' number: '1234567891011121' expiration: GregorianMonthOfYear current next! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'ET 6/16/2021 17:58:33'!
test01CanNotCreateCreditCardWithIncorrectSizeNumber
	
	self assertCreditCardInstanceCreationRaisesErrorWhenOwnedBy: 'Juan' withNumber: '1234'.! !

!CreditCardTest methodsFor: 'tests' stamp: 'ET 6/16/2021 17:58:33'!
test02CanNotCreateCreditCardWithAlphaNumericNumber

	self assertCreditCardInstanceCreationRaisesErrorWhenOwnedBy: 'Juan' withNumber: '1234567890ABCDEF'.! !

!CreditCardTest methodsFor: 'tests' stamp: 'ET 6/16/2021 17:58:33'!
test03CanNotCreateCreditCardWithBlankOwner

	self assertCreditCardInstanceCreationRaisesErrorWhenOwnedBy: '    ' withNumber: '1234567890123456'.! !

!CreditCardTest methodsFor: 'tests' stamp: 'ET 6/16/2021 20:53:07'!
test04ExpiredCreditCardIsExpired

	| creditCard |
	creditCard := CreditCard owner: 'Juan'  number: '1234567890123456' expiration: GregorianMonthOfYear current previous.
	
	
	self assert: (creditCard isExpiredOn: Date today).
	! !

!CreditCardTest methodsFor: 'tests' stamp: 'ET 6/16/2021 20:53:01'!
test05NonExpiredCreditCardIsNotExpired

	| creditCard |
	creditCard := CreditCard owner: 'Juan'  number: '1234567890123456' expiration: GregorianMonthOfYear current next.
	
	
	self deny: (creditCard isExpiredOn: Date today).
	! !


!CreditCardTest methodsFor: 'assertions' stamp: 'ET 6/16/2021 17:58:33'!
assertCreditCardInstanceCreationRaisesErrorWhenOwnedBy: anOwner withNumber: aStringNumber
	self should: [CreditCard owner: anOwner  number: aStringNumber expiration: GregorianMonthOfYear current]
	 	raise: Error - MessageNotUnderstood
		withExceptionDo:[ :anError| self assert: CreditCard invalidCreditCardErrorDescription equals: anError messageText	] ! !


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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'ET 6/10/2021 20:09:25'!
do: aBlockClosure

	items do: aBlockClosure.! !

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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'priceList salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'ET 6/16/2021 17:43:07'!
initializeWith: aPriceList registerSalesOn: aSalesBook merchantProcessor: aMerchantProcessor 
	
	priceList := aPriceList.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.! !


!Cashier methodsFor: 'checkout' stamp: 'ET 6/16/2021 17:42:56'!
checkout: aCart withCreditCard: aCreditCard 
	|totalPrice|
	self assertCartIsNotEmpty: aCart.
	self assertCreditCardIsNotExpired: aCreditCard.
	totalPrice := 0.
	aCart do: [:anElement | totalPrice := totalPrice + priceList at: anElement ifAbsent: [self raiseItemNotInPriceListError].].
	merchantProcessor charge: totalPrice  on: aCreditCard .
	salesBook add: totalPrice .
	^totalPrice.! !


!Cashier methodsFor: 'raise error' stamp: 'ET 6/16/2021 17:42:04'!
raiseItemNotInPriceListError

	^ self error: self class itemNotInPriceListErrorDescription! !


!Cashier methodsFor: 'assertions' stamp: 'ET 6/16/2021 17:39:23'!
assertCartIsNotEmpty: aCart

	^ aCart isEmpty ifTrue: [	self error: self class emptyCartErrorDescription]! !

!Cashier methodsFor: 'assertions' stamp: 'ET 6/16/2021 20:56:27'!
assertCreditCardIsNotExpired: aCreditCard
	
	(aCreditCard isExpiredOn: Date today) ifTrue: [self error: self class expiredCreditCardErrorDescription].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'ET 6/16/2021 17:43:19'!
with: aPriceList registerSalesOn: aSalesBook merchantProcessor: aMerchantProcessor 
	^self new initializeWith: aPriceList registerSalesOn: aSalesBook merchantProcessor: aMerchantProcessor ! !


!Cashier class methodsFor: 'error messages' stamp: 'ET 6/16/2021 17:39:23'!
emptyCartErrorDescription
	^'The cart is empty'.! !

!Cashier class methodsFor: 'error messages' stamp: 'ET 6/16/2021 17:39:07'!
expiredCreditCardErrorDescription
	^'The credit card is expired'.! !

!Cashier class methodsFor: 'error messages' stamp: 'ET 6/16/2021 17:38:56'!
itemNotInPriceListErrorDescription
	^'An item in the cart is not in the price list'.! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'ownerString creditCardNumberString expirationMonthOfYear'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'ET 6/16/2021 20:57:10'!
initializeOwner: anOwnerString number: aCreditCardNumberString expiration: aGregorianMonthOfYear 

	ownerString := anOwnerString.
	creditCardNumberString := aCreditCardNumberString.
	expirationMonthOfYear := aGregorianMonthOfYear.! !


!CreditCard methodsFor: 'as yet unclassified' stamp: 'ET 6/16/2021 20:57:10'!
isExpiredOn: aDate 
	
	^(GregorianMonthOfYear yearNumber: aDate yearNumber monthNumber: aDate monthIndex) > expirationMonthOfYear.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'JA 6/14/2021 19:59:51'!
owner: anOwnerString number: aCreditCardNumberString expiration: aGregorianMonthOfYear 
	self assertCreditCardNumberIsValid: aCreditCardNumberString.
	self assertNonBlankOwner: anOwnerString.
	^self new initializeOwner: anOwnerString number: aCreditCardNumberString expiration: aGregorianMonthOfYear ! !


!CreditCard class methodsFor: 'assertions' stamp: 'ET 6/16/2021 17:44:16'!
assertCreditCardNumberIsValid: aString 
	
	aString size = 16 ifFalse: [self error: self invalidCreditCardErrorDescription ].
	(aString allSatisfy: [:aDigit | aDigit isDigit]	) ifFalse: [self error: self invalidCreditCardErrorDescription ].! !

!CreditCard class methodsFor: 'assertions' stamp: 'ET 6/16/2021 17:44:16'!
assertNonBlankOwner: anOwnerString
	anOwnerString withBlanksTrimmed isEmpty ifTrue: [self error: self invalidCreditCardErrorDescription ]
	
	! !


!CreditCard class methodsFor: 'error messages' stamp: 'ET 6/16/2021 17:44:16'!
invalidCreditCardErrorDescription
	^'Los datos de la tarjeta de crédito son inválidos'! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'messageError'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'charge' stamp: 'JA 6/14/2021 19:21:11'!
charge: aCharge on: aCreditCard 
	messageError ifNotNil: [	self error: messageError].! !


!MerchantProcessorSimulator methodsFor: 'error simulation' stamp: 'JA 6/14/2021 19:20:19'!
raiseErrorOnCharge: aMessageError 
	messageError := aMessageError.! !
