!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'cartObjectTest'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'ms 6/13/2021 09:23:46'!
test01NewCartsAreCreatedEmpty

	self assert: cartObjectTest createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'ms 6/13/2021 09:24:30'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := cartObjectTest createCart.
	
	self 
		should: [ cart add: cartObjectTest itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'ms 6/13/2021 09:24:37'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := cartObjectTest createCart.
	
	cart add: cartObjectTest itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'ms 6/13/2021 09:24:40'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := cartObjectTest createCart.
	
	self 
		should: [cart add: 0 of: cartObjectTest itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'ms 6/13/2021 09:24:44'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := cartObjectTest createCart.
	
	self 
		should: [cart add: 2 of: cartObjectTest itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'ms 6/13/2021 09:24:50'!
test06CartRemembersAddedItems

	| cart |
	
	cart := cartObjectTest createCart.
	
	cart add: cartObjectTest itemSellByTheStore.
	self assert: (cart includes: cartObjectTest itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'ms 6/13/2021 09:24:53'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := cartObjectTest createCart.
	
	self deny: (cart includes: cartObjectTest itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'ms 6/13/2021 09:24:59'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := cartObjectTest createCart.
	
	cart add: 2 of: cartObjectTest itemSellByTheStore.
	self assert: (cart occurrencesOf: cartObjectTest itemSellByTheStore) = 2! !


!CartTest methodsFor: 'set up' stamp: 'CS 6/16/2021 16:17:26'!
setUp

	cartObjectTest := EditorialTestObject new ! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'cartObjectTest debit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'testing' stamp: 'CS 6/16/2021 20:14:45'!
test01CanNotCheckoutanEmptyCart

	| aCreditCard cart aSalesBook today |
	
	cart := cartObjectTest createCart.
	aCreditCard := cartObjectTest createValidCreditCard.
	today := cartObjectTest today.
	aSalesBook := OrderedCollection new.

	self should: [Cashier toCheckout: cart charging: aCreditCard on: today registeringOn: aSalesBook using: self]
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText = Cashier describeErrorCartEmpty.
					self assert: aSalesBook isEmpty]
	! !

!CashierTest methodsFor: 'testing' stamp: 'CS 6/16/2021 20:15:10'!
test02CheckOutACartWithOneItemAndTheTotalIsCorrect

	|cart aCreditCard totalAmount today aSalesBook cashier |
	
	cart := cartObjectTest createCart.
	cart add: cartObjectTest itemSellByTheStore.	
	aCreditCard := cartObjectTest createValidCreditCard.
	today := cartObjectTest today.
	aSalesBook := OrderedCollection new.
	
	cashier := Cashier toCheckout: cart charging: aCreditCard on: today registeringOn: aSalesBook using: self.

	totalAmount := cashier checkOut.

	self assert: totalAmount equals: 	10.
	self assert: aSalesBook first equals: 	totalAmount.
	self deny: aSalesBook isEmpty.
	
	! !

!CashierTest methodsFor: 'testing' stamp: 'CS 6/16/2021 21:54:37'!
test03ValidateDebitCorrectlyWithMPAndManyItemsOfCart

	| cart aCreditCard totalAmount today aSalesBook cashier |
	
	cart := cartObjectTest createCart.
	cart add: 5 of: cartObjectTest itemSellByTheStore.
	aCreditCard := cartObjectTest createValidCreditCard.
	today := cartObjectTest today.
	aSalesBook := OrderedCollection new.

 	debit := [ :totalToPay :theCreditCard | totalAmount := totalToPay].
	
	cashier := Cashier toCheckout: cart charging: aCreditCard on: today registeringOn: aSalesBook using: self.
	
	cashier checkOut.

	self assert: totalAmount equals: 	50.
	self assert: aSalesBook first equals: 	totalAmount.
	self deny: aSalesBook isEmpty.
	! !

!CashierTest methodsFor: 'testing' stamp: 'CS 6/16/2021 21:51:29'!
test04CanNotCheckoutWithAnExpiredCreditCart

	|cart aCreditCard today aSalesBook |
	
	cart := cartObjectTest createCart.
	cart add: cartObjectTest itemSellByTheStore.
	aCreditCard := cartObjectTest createExpiredCreditCard.
	today := cartObjectTest today.
	aSalesBook := OrderedCollection new.
	
	self should: [Cashier toCheckout: cart charging: aCreditCard on: today registeringOn: aSalesBook using: self]
	raise: Error
	withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier describeErrorExpiredCreditCard.
			self assert: aSalesBook isEmpty]
	
	! !

!CashierTest methodsFor: 'testing' stamp: 'CS 6/17/2021 14:16:16'!
test05CanNotCheckoutWhenTheCreditCartHasNoCredit

	debit := [ :totalToPay :theCreditCard | self error: Cashier describeErrorCreditCardHasNoCredit].
	
	self canNotCheckOutUsingDebit: debit shouldThrowError: [:cashier :aSalesBook |
		self should: [cashier checkOut ]
    		raise: Error
    		withExceptionDo: [ :anError | self assert: anError messageText = Cashier describeErrorCreditCardHasNoCredit.
                    							     self assert: aSalesBook isEmpty]]! !

!CashierTest methodsFor: 'testing' stamp: 'CS 6/17/2021 14:16:16'!
test06CanNotCheckoutWhenTheCreditCardIsStolen
	
	debit := [ :totalToPay :theCreditCard | self error: Cashier describeErrorCreditCardIsStolen].
	
	self canNotCheckOutUsingDebit: debit  shouldThrowError: [:cashier :aSalesBook |
		self should: [cashier checkOut ]
    		raise: Error
   		withExceptionDo: [ :anError | self assert: anError messageText = Cashier describeErrorCreditCardIsStolen.
                    							     self assert: aSalesBook isEmpty]]! !

!CashierTest methodsFor: 'testing' stamp: 'CS 6/17/2021 14:16:16'!
test07CanNotCheckoutWhenTheCreditCardIsFake

   	debit := [ :totalToPay :theCreditCard | self error: Cashier describeErrorCreditCardIsFake].
	
	self canNotCheckOutUsingDebit: debit shouldThrowError: [ :cashier :aSalesBook |
		self should: [cashier checkOut ]
    	        raise: Error
               withExceptionDo: [ :anError | self assert: anError messageText = Cashier describeErrorCreditCardIsFake.
                    						           self assert: aSalesBook isEmpty] ]! !


!CashierTest methodsFor: 'set up' stamp: 'CS 6/16/2021 20:06:20'!
setUp

	cartObjectTest := EditorialTestObject new.
	debit := [ :totalToPay :aCreditCard | ].! !


!CashierTest methodsFor: 'debit - mp' stamp: 'CS 6/16/2021 20:19:49'!
debit: totalToPay from: aCreditCard 

	^ debit value: totalToPay value: aCreditCard
! !


!CashierTest methodsFor: 'private testing checkOutWithMP' stamp: 'CS 6/17/2021 14:16:16'!
canNotCheckOutUsingDebit: aDebit shouldThrowError: anErrorBlock

 | creditCard cart aSalesBook cashier |

    	cart := cartObjectTest createCart.
    	cart add: cartObjectTest itemSellByTheStore.
	creditCard := cartObjectTest createValidCreditCard.
    	aSalesBook := OrderedCollection new.

 	debit := aDebit .

	cashier := Cashier toCheckout: cart charging: creditCard on: cartObjectTest today registeringOn: aSalesBook using: self.

    anErrorBlock value: cashier  value: aSalesBook 
! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'cartObjectTest'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'testing' stamp: 'CS 6/16/2021 21:59:57'!
test01CanNotCreateCreditCardWithEmptyName

	|  aExpirationDate|
	
	aExpirationDate := cartObjectTest createValidExpirationDate.
	
	self should: [CreditCard withOwner: '' withCreditCardNumber: 1234567887654321 withExpirationDate: aExpirationDate]
	raise: Error
	withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard errorDescribeEmptyName . ]
	
	! !

!CreditCardTest methodsFor: 'testing' stamp: 'CS 6/16/2021 21:57:43'!
test02CanNotCreateCreditCardWithANumberSizeOtherThan16

	| aExpirationDate |
	
	aExpirationDate := cartObjectTest createValidExpirationDate.
	
	self should: [CreditCard withOwner: 'Alan kay' withCreditCardNumber: 12345678 withExpirationDate: aExpirationDate]
	raise: Error
	withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard errorDescribeinvalidCreditCardNumber ]
	
	! !

!CreditCardTest methodsFor: 'testing' stamp: 'CS 6/16/2021 22:08:19'!
test03CreditCardWasCreatedCorrectlyAndWeCanAccessToNameNumberAndExpirationDate

	| aCreditCard aExpirationDate owner creditCardNumber|
	
	aExpirationDate := cartObjectTest createValidExpirationDate.
	owner := 'Alan kay' .
	creditCardNumber := 1234567887654321.
	
	aCreditCard := CreditCard withOwner: owner withCreditCardNumber: creditCardNumber withExpirationDate: aExpirationDate.
	
	self assert: (aCreditCard owner) equals: owner.
	self assert: (aCreditCard creditCardNumber) equals: creditCardNumber.
	self assert: (aCreditCard expirationDate) equals: aExpirationDate
	! !


!CreditCardTest methodsFor: 'set up' stamp: 'CS 6/16/2021 22:08:57'!
setUp

	cartObjectTest := EditorialTestObject new! !


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


!Cart methodsFor: 'assertions' stamp: 'ms 6/13/2021 09:20:29'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'ms 6/13/2021 09:43:44'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


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

!Cart methodsFor: 'adding' stamp: 'ms 6/13/2021 09:46:01'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	"1 to: aQuantity do: [ :aNumber | items add: anItem ]."
	items add: anItem withOccurrences: aQuantity.! !


!Cart methodsFor: 'total price' stamp: 'CS 6/14/2021 09:09:19'!
totalPrice

	| totalCartPrice |
	
	
	totalCartPrice := items sum: [ :cartItem | (catalog at: cartItem ) ] ifEmpty: [0].
	
	^ totalCartPrice 
	
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
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'check out' stamp: 'CS 6/16/2021 20:14:02'!
checkOut

	| totalToPay |

	totalToPay  := cart totalPrice.
	
	self debit: totalToPay.
	
	salesBook add: totalToPay.
	
	^ salesBook first.
	! !


!Cashier methodsFor: 'initialization' stamp: 'CS 6/14/2021 21:05:31'!
initializetoCheckout: aCart charging: aCreditCard registeringOn: aSalesBook using: mp 

	cart := aCart.
	salesBook := aSalesBook.
	creditCard := aCreditCard.
	merchantProcessor := mp.! !


!Cashier methodsFor: 'check out private' stamp: 'CS 6/16/2021 20:13:06'!
debit: totalToPay

	merchantProcessor debit: totalToPay from: creditCard! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error messagges' stamp: 'CS 6/16/2021 16:26:42'!
describeErrorCartEmpty

	^ 'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messagges' stamp: 'CS 6/16/2021 16:23:10'!
describeErrorCreditCardHasNoCredit

	^ 'The sale can not be made because the credit card has no credit'! !

!Cashier class methodsFor: 'error messagges' stamp: 'CS 6/16/2021 16:25:39'!
describeErrorCreditCardIsFake

	^ 'The sale can not be made because the credit card is fake'! !

!Cashier class methodsFor: 'error messagges' stamp: 'CS 6/16/2021 16:25:59'!
describeErrorCreditCardIsStolen

	^ 'The sale can not be made because the credit card is stolen'! !

!Cashier class methodsFor: 'error messagges' stamp: 'CS 6/16/2021 21:51:29'!
describeErrorExpiredCreditCard

	^ 'Can not check out with an expired card'! !


!Cashier class methodsFor: 'initialization' stamp: 'CS 6/14/2021 21:01:43'!
toCheckout: aCart charging: aCreditCard on: aDate registeringOn: aSalesBook using: mp 

	self assertIsValidCart: aCart.
	self assertIsValidCreditCard: aCreditCard on: aDate.
	
	^ self new initializetoCheckout: aCart charging: aCreditCard registeringOn: aSalesBook using: mp! !


!Cashier class methodsFor: 'validate' stamp: 'CS 6/14/2021 19:43:44'!
assertIsValidCart: aCart

	aCart isEmpty ifTrue: [^Error signal: self describeErrorCartEmpty ].! !

!Cashier class methodsFor: 'validate' stamp: 'CS 6/16/2021 21:51:29'!
assertIsValidCreditCard: aCreditCard on: today

	(aCreditCard isExpiredOn: today) ifTrue: [^Error signal: self describeErrorExpiredCreditCard ] .! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'owner number expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'creditCard features' stamp: 'ms 6/13/2021 10:11:55'!
creditCardNumber

	^number ! !

!CreditCard methodsFor: 'creditCard features' stamp: 'ms 6/13/2021 10:12:03'!
expirationDate

	^expirationDate ! !

!CreditCard methodsFor: 'creditCard features' stamp: 'ms 6/13/2021 10:11:49'!
owner

	^owner ! !


!CreditCard methodsFor: 'initialization' stamp: 'ms 6/13/2021 10:10:31'!
initializeWithOwner: aOwner withCreditCardNumber: aCreditCardNumber withExpirationDate: aExpirationDate

	self validateName: aOwner.
	self validateCreditCardNumber: aCreditCardNumber.
	
	owner := aOwner .
	number := aCreditCardNumber .
	expirationDate  := aExpirationDate .! !


!CreditCard methodsFor: 'validations' stamp: 'CS 6/14/2021 19:01:55'!
isExpiredOn: aDate

	^ expirationDate < (aDate monthOfYear).
	! !

!CreditCard methodsFor: 'validations' stamp: 'CS 6/14/2021 20:00:17'!
validateCreditCardNumber: aCreditCardNumber.

	((aCreditCardNumber numberOfDigitsInBase: 10) ~= 16) ifTrue: [^Error signal: self class errorDescribeinvalidCreditCardNumber]! !

!CreditCard methodsFor: 'validations' stamp: 'ms 6/13/2021 09:57:59'!
validateName: aOwner

	aOwner isEmpty ifTrue: [^Error signal: self class errorDescribeEmptyName]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'error messagges' stamp: 'ms 6/13/2021 09:58:27'!
errorDescribeEmptyName
	
	^'Can not create credit cart with an empty name'! !

!CreditCard class methodsFor: 'error messagges' stamp: 'ms 6/13/2021 10:03:40'!
errorDescribeinvalidCreditCardNumber

	^'Can not create a credit card with invalid credit card number'! !


!CreditCard class methodsFor: 'instance creation' stamp: 'ms 6/13/2021 09:56:24'!
withOwner: aOwner withCreditCardNumber: aCreditCardNumber withExpirationDate: aExpirationDate

	^ self new initializeWithOwner: aOwner withCreditCardNumber: aCreditCardNumber withExpirationDate: aExpirationDate! !


!classDefinition: #EditorialTestObject category: 'TusLibros'!
Object subclass: #EditorialTestObject
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!EditorialTestObject methodsFor: 'create instances' stamp: 'CS 6/14/2021 09:37:03'!
createCart
	
	^ Cart acceptingItemsOf: self defaultCatalog! !

!EditorialTestObject methodsFor: 'create instances' stamp: 'CS 6/16/2021 16:09:20'!
createExpiredCreditCard

	| aCreditCard aExpirationDate |

	aExpirationDate := self createExpiredDate.
	
	aCreditCard := CreditCard withOwner: 'Alan Kay' withCreditCardNumber: 1234567887654321 withExpirationDate: aExpirationDate.
	
	^ aCreditCard! !

!EditorialTestObject methodsFor: 'create instances' stamp: 'CS 6/14/2021 19:21:16'!
createExpiredDate

	^ today monthOfYear previous.! !

!EditorialTestObject methodsFor: 'create instances' stamp: 'ms 6/15/2021 20:18:48'!
createValidCreditCard

	| aCreditCard aExpirationDate |

	aExpirationDate := self createValidExpirationDate.
	
	aCreditCard := CreditCard withOwner: 'Alan Kay' withCreditCardNumber: 1234567887654321 withExpirationDate: aExpirationDate.
	
	^ aCreditCard! !

!EditorialTestObject methodsFor: 'create instances' stamp: 'CS 6/14/2021 19:21:22'!
createValidExpirationDate

	^ today monthOfYear next.! !

!EditorialTestObject methodsFor: 'create instances' stamp: 'CS 6/14/2021 09:32:06'!
defaultCatalog
	
	| catalog |
	catalog := Dictionary new.
	catalog at: self itemSellByTheStore put: self priceForValidItem.

	^catalog ! !

!EditorialTestObject methodsFor: 'create instances' stamp: 'ms 6/10/2021 20:33:16'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!EditorialTestObject methodsFor: 'create instances' stamp: 'ms 6/10/2021 20:33:21'!
itemSellByTheStore
	
	^ 'validBook'! !

!EditorialTestObject methodsFor: 'create instances' stamp: 'CS 6/14/2021 09:32:12'!
priceForValidItem

	^ 10! !

!EditorialTestObject methodsFor: 'create instances' stamp: 'CS 6/14/2021 19:20:56'!
today

	^ today! !


!EditorialTestObject methodsFor: 'initialization' stamp: 'CS 6/14/2021 19:20:40'!
initialize

	today := FixedGregorianDate today! !
