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

!CartTest methodsFor: 'tests' stamp: 'nt 11/21/2020 19:22:01'!
test09CartCalculatesTotalPriceWhenCartIsEmpty

	| cart |
	
	cart := self createCart.
	
	
	self assert: (cart totalPrice = 0).! !

!CartTest methodsFor: 'tests' stamp: 'nt 11/21/2020 19:25:42'!
test10CartCalculatesTotalPriceWhenCartHasOneItem

	| cart |
	
	cart := self createCart.
	cart add: 1 of: self itemSellByTheStore.
	
	
	self assert: (cart totalPrice = 100).! !

!CartTest methodsFor: 'tests' stamp: 'nt 11/21/2020 19:27:05'!
test11CartCalculatesTotalPriceWhenCartHasMoreThanOneItem

	| cart |
	
	cart := self createCart.
	cart add: 5 of: self itemSellByTheStore.
	
	
	self assert: (cart totalPrice = 500).! !

!CartTest methodsFor: 'tests' stamp: 'nt 11/21/2020 19:45:18'!
test12TryToCreateCartWithInvalidCatalog
	| invalidCatalog |
	
	invalidCatalog:= Dictionary new.
	invalidCatalog at: 'ISBN12345' put: -100.
	self 	
		should: [ Cart acceptingItemsOf:invalidCatalog ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: (anError messageText = Cart invalidCatalogErrorMessage ) 
			 ].
		! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'nt 11/21/2020 19:09:30'!
defaultCatalog
	
	^ Dictionary with:(self itemSellByTheStore)->100.! !

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

!CashierTest methodsFor: 'as yet unclassified' stamp: 'nt 11/21/2020 18:38:00'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'nt 11/21/2020 20:04:08'!
defaultCatalog
	
	^ Dictionary with:(self validBook)->100.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 17:46:22'!
defaultCreditCard
^CreditCard newWith:  '1234567890123456' andOwner:'JuanPerez'  andExpMonth:12 andExpYear: 2021   andVerifDigit: '456'
! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 17:46:45'!
expiredCreditCard
^CreditCard newWith:  '1234567890123456' andOwner:'JuanPerez'   andExpMonth:10 andExpYear: 2020 andVerifDigit: '456'
! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 17:46:57'!
invalidCreditCardNumber
^CreditCard newWith:  '1&KL567890' andOwner:'JuanPerez'   andExpMonth:10 andExpYear: 2020 andVerifDigit: '456'
! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 17:58:50'!
invalidCreditCardOwner.
^CreditCard newWith:  '1234567890123456' andOwner:''  andExpMonth:12 andExpYear: 2021 andVerifDigit: '123'
! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 17:55:16'!
invalidCreditCardVerificationDigit.
^CreditCard newWith:  '1234567890123456' andOwner:'JuanPerez'   andExpMonth:10 andExpYear: 2020 andVerifDigit: 'AB123'
! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'nt 11/21/2020 18:40:32'!
test01CheckOutOfAnEmptyCart
	|cart1 creditCard cashier|
	
	cashier:= Cashier new.
	creditCard:= CreditCard new.
	cart1:=self createCart.
	
	
	self 
		should: [ cashier checkOut: cart1 with:creditCard ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: (anError messageText = Cashier checkoutWithEmptyCartErrorDescription) 
			 ].
		
		
! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'nt 11/21/2020 20:15:58'!
test02CheckOutOfACartWithOneProductAndValidCreditCard
	|cart1 creditCard cashier|
	
	cashier:= Cashier new.
	creditCard:= self defaultCreditCard.
	cart1:=self createCart.
	cart1 add:(self validBook ).
	self assert: ((cashier checkOut: cart1 with: creditCard )=100)
	
	
	
	
	
		
		
		
! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 15:13:45'!
test03CheckOutOfACartWithMoreThanOneProductAndValidCreditCard
	|cart1 creditCard cashier|
	
	cashier:= Cashier new.
	creditCard:= self defaultCreditCard.
	cart1:=self createCart.
	cart1 add:2 of:(self validBook ).
	self assert: ((cashier checkOut: cart1 with: creditCard )=200)
	
	
	
	
	
		
		
		
! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 16:56:37'!
test04CheckOutOfACartWithAnExpiredCreditCard
	|cart1 creditCard cashier|
	
	cashier:= Cashier new.
	creditCard:= self expiredCreditCard.
	cart1:=self createCart.
	cart1 add:2 of:(self validBook ).
	self 
		should: [ cashier checkOut: cart1 with:creditCard ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: (anError messageText = Cashier expiredCreditCardErrorDescription) 
			 ].
	
	
	
	
	
		
		
		
! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 16:57:50'!
test05CheckOutOfACartWithAnExpiredCreditCard
	|cart1 creditCard cashier|
	
	cashier:= Cashier new.
	creditCard:= self expiredCreditCard.
	cart1:=self createCart.
	cart1 add:2 of:(self validBook ).
	self 
		should: [ cashier checkOut: cart1 with:creditCard ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: (anError messageText = Cashier expiredCreditCardErrorDescription) 
			 ].
	
	
	
	
	
		
		
		
! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 17:37:42'!
test06CheckOutOfACartWithAnInvalidCreditCardNumber
	|cart1 creditCard cashier|
	
	cashier:= Cashier new.
	creditCard:= self invalidCreditCardNumber.
	cart1:=self createCart.
	cart1 add:2 of:(self validBook ).
	self 
		should: [ cashier checkOut: cart1 with:creditCard ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: (anError messageText = Cashier invalidCreditCardNumberErrorDescription) 
			 ].
	
	
	
	
	
		
		
		
! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 17:39:02'!
test07CheckOutOfACartWithAnInvalidCreditCardVerificationDigit
	|cart1 creditCard cashier|
	
	cashier:= Cashier new.
	creditCard:= self invalidCreditCardVerificationDigit.
	cart1:=self createCart.
	cart1 add:2 of:(self validBook ).
	self 
		should: [ cashier checkOut: cart1 with:creditCard ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: (anError messageText = Cashier invalidCreditCardVerificationDigitErrorDescription) 
			 ].
	
	
	
	
	
		
		
		
! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 17:51:47'!
test08CheckOutOfACartWithAnEmptyCreditCardOwner
	|cart1 creditCard cashier|
	
	cashier:= Cashier new.
	creditCard:= self invalidCreditCardOwner.
	cart1:=self createCart.
	cart1 add:2 of:(self validBook ).
	self 
		should: [ cashier checkOut: cart1 with:creditCard ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: (anError messageText = Cashier invalidCreditCardOwnerErrorDescription) 
			 ].
	
	
	
	
	
		
		
		
! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 19:05:24'!
test09CheckOutOfAnAuthorizedSale
	|cart1 creditCard cashier mProcessor|
	
	cashier:= Cashier new.
	creditCard:= self defaultCreditCard .
	cart1:=self createCart.
	mProcessor:= MPAuthorizedOperation new.
	cart1 add:2 of:(self validBook ).
	self assert:(		(cashier checkOut: cart1 with:creditCard andMP:mProcessor)=200)
		
	
	
	
	
	
		
! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 19:15:28'!
test10CheckOutOfANotAuthorizedSale
	|cart1 creditCard cashier mProcessor|
	
	cashier:= Cashier new.
	creditCard:= self defaultCreditCard .
	cart1:=self createCart.
	mProcessor:= MPCardLimitExcedeed new.
	cart1 add:2 of:(self validBook ).
	self should:[cashier checkOut: cart1 with:creditCard andMP:mProcessor]
	raise:Error
	withExceptionDo:[:anError|].
	self assert:(cashier salesLog isEmpty)
	
		
	
	
	
	
	
		
! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'nt 11/21/2020 18:45:38'!
validBook

	^ 'ISBN12345'! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'nt 11/21/2020 19:35:11'!
invalidCatalogErrorMessage
	
	^'Invalid price for some item'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'nt 11/21/2020 19:12:07'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'nt 11/21/2020 19:35:45'!
validateCatalog:aCatalog
(aCatalog values allSatisfy:[:aPrice|aPrice>0]) ifFalse:[self error: self invalidCatalogErrorMessage].! !


!Cart methodsFor: 'initialization' stamp: 'nt 11/21/2020 19:29:03'!
initializeAcceptingItemsOf: aCatalog
	self validateCatalog:aCatalog.
	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'nt 11/21/2020 19:23:43'!
totalPrice

	^items sum:[:anItem|catalog at: anItem ] ifEmpty: [0]! !


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

!Cart class methodsFor: 'instance creation' stamp: 'nt 11/21/2020 19:46:03'!
invalidCatalogErrorMessage
	
	^'Invalid price for some item'! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'saleLog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 16:52:09'!
checkExpiredCard: aCreditCard

(aCreditCard expirationYear < Date today yearNumber) ifTrue:[^true].
((aCreditCard expirationYear =Date today yearNumber) and: (aCreditCard expirationMonth < Date today monthIndex ))ifTrue:[^true].
^false
! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 17:28:29'!
checkInvalidNumberCard: aCreditCard

((aCreditCard number size  =16) and: (aCreditCard number allSatisfy:[:aChar|aChar isDigit]) ) ifTrue:[^false].
^true.
! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 18:05:40'!
checkInvalidOwnerCard: aCreditCard

^(aCreditCard owner isEmpty)or:(aCreditCard owner size>30)
 ! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 17:48:58'!
checkInvalidVDigitCard: aCreditCard 

((aCreditCard verificationDigit size  =3) and: (aCreditCard verificationDigit allSatisfy:[:aChar|aChar isDigit]) ) ifTrue:[^false].
^true.
! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 18:50:35'!
checkOut:aCart with:aCreditCard
	self validateCart: aCart .
	self validateCreditCard:aCreditCard .
	saleLog add: aCart totalPrice.
	^ aCart totalPrice.
	! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 18:54:07'!
checkOut:aCart with:aCreditCard andMP:aMerchantProcessor

	self validateCart: aCart .
	self validateCreditCard:aCreditCard.
	aMerchantProcessor debitFrom:aCreditCard amount: aCart totalPrice.
	saleLog add: aCart totalPrice. 
	^aCart totalPrice
	
	! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 18:49:08'!
initialize
	saleLog :=OrderedCollection new.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 19:10:32'!
salesLog
	^saleLog ! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'nt 11/21/2020 17:21:46'!
validateCart:aCart 
(aCart isEmpty) ifTrue:[self error: Cashier checkoutWithEmptyCartErrorDescription ]! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 18:06:11'!
validateCreditCard:aCreditCard

(self checkExpiredCard: aCreditCard ) ifTrue: [self error: Cashier expiredCreditCardErrorDescription ].
(self checkInvalidNumberCard: aCreditCard ) ifTrue: [self error: Cashier invalidCreditCardNumberErrorDescription ].
(self checkInvalidVDigitCard: aCreditCard ) ifTrue: [self error: Cashier invalidCreditCardVerificationDigitErrorDescription ].
(self checkInvalidOwnerCard: aCreditCard ) ifTrue: [self error: Cashier invalidCreditCardOwnerErrorDescription ].

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'nt 11/21/2020 17:04:58'!
checkoutWithEmptyCartErrorDescription
	'El carrito está vacio. No hay productos para procesar'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 15:55:50'!
expiredCreditCardErrorDescription
'The credit Card is expired'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 17:07:17'!
invalidCreditCardNumberErrorDescription
'The number of the credit Card is invalid'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 17:53:23'!
invalidCreditCardOwnerErrorDescription
	'The owner field is empty'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 17:39:58'!
invalidCreditCardVerificationDigitErrorDescription
	'The verification digit is invalid'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'number owner verificationDigit expirationMonth expirationYear'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 16:36:17'!
expirationMonth

^expirationMonth
 
	! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 16:36:29'!
expirationYear

^expirationYear
 
	! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 16:32:55'!
initializeWith: aNumber andOwner: anOwner andExpMonth:anExpirationMonth andExpYear: anExpirationYear andVerifDigit: aVerificationDigit.
number :=aNumber.
owner :=anOwner. 
expirationMonth:=anExpirationMonth.
expirationYear:=anExpirationYear .
verificationDigit :=aVerificationDigit 
	! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 15:27:34'!
number

^number 
 
	! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 15:27:10'!
owner

^owner 
 
	! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 15:27:54'!
verificationDigit

^verificationDigit 
 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 16:34:38'!
newWith:aNumber andOwner: anOwner andExpMonth:anExpirationMonth andExpYear: anExpirationYear  andVerifDigit: aVerificationDigit
	^self new initializeWith: aNumber andOwner: anOwner andExpMonth:anExpirationMonth andExpYear: anExpirationYear andVerifDigit: aVerificationDigit.! !


!classDefinition: #MPSimulator category: 'TusLibros'!
Object subclass: #MPSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MPSimulator methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 18:37:09'!
debitFrom:aCreditCard amount: aTotalPrice
self subclassResponsibility.! !


!classDefinition: #MPAuthorizedOperation category: 'TusLibros'!
MPSimulator subclass: #MPAuthorizedOperation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MPAuthorizedOperation methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 18:36:22'!
debitFrom:aCreditCard amount: aTotalPrice
! !


!classDefinition: #MPCardLimitExcedeed category: 'TusLibros'!
MPSimulator subclass: #MPCardLimitExcedeed
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MPCardLimitExcedeed methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 18:41:27'!
debitFrom:aCreditCard amount: aTotalPrice
self error: ' Not authorized purchase because of credit card excedeed limit'! !


!classDefinition: #MPStolenCardWarning category: 'TusLibros'!
MPSimulator subclass: #MPStolenCardWarning
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MPStolenCardWarning methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 18:41:08'!
debitFrom:aCreditCard amount: aTotalPrice
self error: ' Not authorized purchase because of the credit card was stolen'! !


!classDefinition: #MPTimeout category: 'TusLibros'!
MPSimulator subclass: #MPTimeout
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MPTimeout methodsFor: 'as yet unclassified' stamp: 'nt 11/22/2020 18:42:20'!
debitFrom:aCreditCard amount: aTotalPrice
self error: ' The merchant processor failed to respond'! !
