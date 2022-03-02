!classDefinition: #CardTest category: 'TusLibros'!
TestCase subclass: #CardTest
	instanceVariableNames: 'expirationDate validOwner validNumber'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CardTest methodsFor: 'tests' stamp: 'jn 6/14/2021 19:11:45'!
test01CanNotCreateACardWithNumberDigitsNotEqualsTo16

	self 
		should: [ Card withNumber: 1234567890123456123543154154 owner: validOwner expiresOn: expirationDate ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | self assert: anError messageText = Card invalidCardErrorMessage. ].
		
	self 
		should: [ Card withNumber: 123 owner: validOwner expiresOn: expirationDate ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | self assert: anError messageText = Card invalidCardErrorMessage. ].
	! !

!CardTest methodsFor: 'tests' stamp: 'jn 6/14/2021 19:14:34'!
test02CanNotCreateACardWithEmptyOwner

	self 
		should: [ Card withNumber: validNumber owner: '' expiresOn: expirationDate ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | self assert: anError messageText = Card invalidCardErrorMessage. ].
		
	self 
		should: [ Card withNumber: validNumber owner: '    ' expiresOn: expirationDate ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | self assert: anError messageText = Card invalidCardErrorMessage. ].
	! !

!CardTest methodsFor: 'tests' stamp: 'jn 6/14/2021 19:14:41'!
test03CanCreateACardWithValidNumberAndOwner

	|card |
	card := Card withNumber: validNumber owner: validOwner expiresOn: expirationDate.
	
	self assert: card number equals: validNumber.
	self assert: card owner equals: validOwner.
	self assert: card expiresOn equals: expirationDate.

	
	! !

!CardTest methodsFor: 'tests' stamp: 'jn 6/16/2021 23:29:13'!
test04CanNotCreateACardWithExceededLengthOwner

	self 
		should: [ 
			Card withNumber: validNumber 
				owner: 'este nombre es mas largo de 30 caracteres' 
				expiresOn: expirationDate ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | self assert: anError messageText = Card invalidCardErrorMessage. ].
		
	! !


!CardTest methodsFor: 'setUp' stamp: 'jn 6/14/2021 20:24:39'!
setUp
	
	| today |
	today := GregorianMonthOfYear current.
	expirationDate := GregorianMonthOfYear yearNumber: (today year number) +1 monthNumber: today monthNumber.
	validOwner := 'Alan Kay'.
	validNumber := 1234567890123456.
! !


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

!CartTest methodsFor: 'tests' stamp: 'jn 6/16/2021 22:19:24'!
test09CartCanRetrieveItemsWithQuantity

	| cart listItems |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.

	listItems := OrderedCollection new.
	listItems add: (2 @ self itemSellByTheStore).
	
	self assert: cart listItems equals: listItems.! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'jn 6/16/2021 22:08:07'!
defaultCatalog
	
	| dictionary |
	dictionary := Dictionary new.
	dictionary add: (self itemSellByTheStore)->500.
	^ dictionary.! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'emptyCart validCard nonEmptyCart expiredCard today totalNonEmptyCart invalidCard paymentsProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'jn 6/17/2021 16:36:45'!
checkOutWith: merchantProcessor raises: errorMessage

	| cashier salesBook |
	
	cashier := Cashier new.
	salesBook := OrderedCollection new.
		
	self  should: [ 	cashier checkOut: nonEmptyCart 
						chargingOn: validCard 
						registerOn: salesBook 
						onDate: today
						withProcessor: merchantProcessor. ]
	 	raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = errorMessage . 
			self assert: salesBook isEmpty.
			]
	! !

!CashierTest methodsFor: 'tests' stamp: 'jn 6/17/2021 01:08:14'!
test01CanNotCheckOutAnEmptyCart

	| cashier salesBook |
	
	cashier := Cashier new.
	salesBook := OrderedCollection new.

	self  should: [ cashier checkOut: emptyCart chargingOn: validCard registerOn: salesBook onDate: today withProcessor: paymentsProcessor ]
	 	raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = cashier emptyCartErrorMessage. 
			self assert: salesBook isEmpty.
			]! !

!CashierTest methodsFor: 'tests' stamp: 'jn 6/17/2021 01:08:03'!
test02CheckOutTotalAmount

	| cashier salesBook total |
	
	cashier := Cashier new.
	salesBook := OrderedCollection new.

	total := cashier checkOut: nonEmptyCart chargingOn: validCard registerOn: salesBook onDate: today withProcessor: paymentsProcessor.
	
	self assert: total equals: totalNonEmptyCart
		! !

!CashierTest methodsFor: 'tests' stamp: 'jn 6/17/2021 01:08:18'!
test03CanNotCheckOutWithExpiredCard

	| cashier salesBook |
	
	cashier := Cashier new.
	salesBook := OrderedCollection new.

	self  should: [ cashier checkOut: nonEmptyCart chargingOn: expiredCard registerOn: salesBook onDate: today withProcessor: paymentsProcessor ]
	 	raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = cashier expiredCardErrorMessage. 
			self assert: salesBook isEmpty.
			]
		! !

!CashierTest methodsFor: 'tests' stamp: 'jn 6/17/2021 01:08:21'!
test04CheckOutRegisterSaleInSalesBook

	| cashier salesBook |
	
	cashier := Cashier new.
	salesBook := OrderedCollection new.

	cashier checkOut: nonEmptyCart chargingOn: validCard registerOn: salesBook onDate: today withProcessor: paymentsProcessor.
	
	self assert: (salesBook at: 1) equals: totalNonEmptyCart.
		! !

!CashierTest methodsFor: 'tests' stamp: 'jn 6/17/2021 16:38:21'!
test05MerchantProcessorCanNotDebitFromInvalidCard

	| merchantProcessor |
	
	merchantProcessor := MerchantProcessorInvalidCard new.

	self checkOutWith: merchantProcessor raises: merchantProcessor invalidCardErrorMessage.
	

	! !

!CashierTest methodsFor: 'tests' stamp: 'jn 6/17/2021 16:38:59'!
test06MerchantProcessorRespondsBadFormat

	| merchantProcessor |
	
	merchantProcessor := MerchantProcessorBadRequest new.

	self checkOutWith: merchantProcessor raises: merchantProcessor badRequestErrorMessage.
	
	! !


!CashierTest methodsFor: 'setUp' stamp: 'jn 6/17/2021 01:05:57'!
setUp
	
	| catalog expiredDate nonExpiredDate validNumber validOwner |
	catalog := Dictionary new.
	catalog add: 'validBook'->500.
	catalog add: 'Cormen'->20000.

	nonEmptyCart := Cart acceptingItemsOf: catalog.
	nonEmptyCart add: 'validBook'.
	nonEmptyCart add: 'Cormen'.
	totalNonEmptyCart := 20500.
	
	emptyCart := Cart acceptingItemsOf: catalog.
	
	today := GregorianMonthOfYear current.
	nonExpiredDate := GregorianMonthOfYear yearNumber: (today year number) +1 monthNumber: today monthNumber.
	expiredDate := GregorianMonthOfYear yearNumber: (today year number) -1 monthNumber: today monthNumber.

	validOwner := 'Alan Kay'.
	validNumber := 1234567890123456.
	validCard := Card withNumber: validNumber owner: validOwner expiresOn: nonExpiredDate.
	expiredCard := Card withNumber: validNumber owner: validOwner expiresOn: expiredDate.
	
	paymentsProcessor := MerchantProcessorOK new.! !


!classDefinition: #Card category: 'TusLibros'!
Object subclass: #Card
	instanceVariableNames: 'number owner expiresOn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Card methodsFor: 'testing - private' stamp: 'jn 6/14/2021 19:05:26'!
expiresOn
	^expiresOn! !

!Card methodsFor: 'testing - private' stamp: 'jn 6/14/2021 18:53:51'!
number
	^ number! !

!Card methodsFor: 'testing - private' stamp: 'jn 6/14/2021 18:59:45'!
owner
	^owner! !


!Card methodsFor: 'expiration' stamp: 'jn 6/14/2021 20:26:40'!
isExpiredOn: aDate

	^ (expiresOn < aDate)! !


!Card methodsFor: 'initialization' stamp: 'jn 6/14/2021 19:04:41'!
forNumber: aCardNumber owner: anOwner expiresOn: aMonthOfYear 

	number := aCardNumber. 
	owner := anOwner.
	expiresOn := aMonthOfYear.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Card class' category: 'TusLibros'!
Card class
	instanceVariableNames: ''!

!Card class methodsFor: 'as yet unclassified' stamp: 'jn 6/14/2021 18:48:53'!
assertCardNumber: aCardNumber
	
	((aCardNumber numberOfDigitsInBase: 10) = 16) ifFalse: [ self error: self invalidCardErrorMessage ].! !

!Card class methodsFor: 'as yet unclassified' stamp: 'jn 6/16/2021 23:28:17'!
assertCardOwner: anOwner
	
	((anOwner withBlanksTrimmed isEmpty) or: (anOwner size > 30))
		ifTrue: [ self error: self invalidCardErrorMessage ].
! !

!Card class methodsFor: 'as yet unclassified' stamp: 'jn 6/14/2021 18:48:53'!
invalidCardErrorMessage

	^'Invalid card'.! !

!Card class methodsFor: 'as yet unclassified' stamp: 'jn 6/14/2021 18:43:16'!
withNumber: aCardNumber 
	
	self assertCardNumber: aCardNumber.
	^ self new forNumber: aCardNumber.! !

!Card class methodsFor: 'as yet unclassified' stamp: 'jn 6/14/2021 18:55:45'!
withNumber: aCardNumber owner: anOwner 
			
	self assertCardNumber: aCardNumber.
	self assertCardOwner: anOwner.

	^ self new forNumber: aCardNumber owner: anOwner.! !

!Card class methodsFor: 'as yet unclassified' stamp: 'jn 6/14/2021 19:03:55'!
withNumber: aCardNumber owner: anOwner expiresOn: aMonthOfYear
				
	self assertCardNumber: aCardNumber.
	self assertCardOwner: anOwner.

	^ self new forNumber: aCardNumber owner: anOwner expiresOn: aMonthOfYear.! !


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


!Cart methodsFor: 'assertions' stamp: 'jn 6/10/2021 20:54:51'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'jn 6/16/2021 22:17:54'!
listItems
	
	| list |
	list := OrderedCollection new.
	items asSet do: [:item | list add: ((self occurrencesOf: item) @ item)].
	^list! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'jn 6/13/2021 18:18:52'!
totalAmount
	
	^ items sum: [ :item | catalog at: item ]! !


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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout' stamp: 'jn 6/16/2021 23:52:30'!
checkOut: aCart chargingOn: aCard registerOn: aSalesBook onDate: aDate withProcessor: processorAPI  

	| total |
	self assertCartIsNotEmpty: aCart.
	self assertCardIsNotExpired: aCard onDate: aDate.
		
	total := aCart totalAmount.
	
	processorAPI debitFrom: aCard transactionAmout: total.
	
	aSalesBook add: total.
	^total.
	! !

!Cashier methodsFor: 'checkout' stamp: 'jn 6/16/2021 23:49:15'!
checkOut: aCart registerOn: aSalesBook withProcessor: processorAPI 
	
	| total |
	total := aCart totalAmount.
	aSalesBook add: total.
	^total.! !


!Cashier methodsFor: 'errors' stamp: 'jn 6/10/2021 20:48:58'!
emptyCartErrorMessage
	
	^'Cart is empty.'! !

!Cashier methodsFor: 'errors' stamp: 'jn 6/14/2021 19:54:02'!
expiredCardErrorMessage
	
	^'Card is expired.'! !


!Cashier methodsFor: 'assertions' stamp: 'jn 6/14/2021 19:53:47'!
assertCardIsNotExpired: aCard onDate: aDate
	
	(aCard isExpiredOn: aDate) ifTrue: [ self error: self expiredCardErrorMessage ].
	
	! !

!Cashier methodsFor: 'assertions' stamp: 'jn 6/14/2021 19:28:51'!
assertCartIsNotEmpty: aCart

	aCart isEmpty ifTrue: [ 	self error: self emptyCartErrorMessage. ].

	! !


!classDefinition: #MerchantProcessorInterfaceSimulator category: 'TusLibros'!
Object subclass: #MerchantProcessorInterfaceSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorInterfaceSimulator methodsFor: 'debit' stamp: 'jn 6/17/2021 01:13:53'!
debitFrom: aCard transactionAmout: aTotalAmount 
	
	self subclassResponsibility .! !


!classDefinition: #MerchantProcessorBadRequest category: 'TusLibros'!
MerchantProcessorInterfaceSimulator subclass: #MerchantProcessorBadRequest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorBadRequest methodsFor: 'errors' stamp: 'jn 6/17/2021 01:27:52'!
badRequestErrorMessage

	^'Error in parameters format'.! !


!MerchantProcessorBadRequest methodsFor: 'debit' stamp: 'jn 6/17/2021 01:27:11'!
debitFrom: aCard transactionAmout: aTotalAmount 

	self error: self badRequestErrorMessage .! !


!classDefinition: #MerchantProcessorInvalidCard category: 'TusLibros'!
MerchantProcessorInterfaceSimulator subclass: #MerchantProcessorInvalidCard
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorInvalidCard methodsFor: 'debit' stamp: 'jn 6/17/2021 00:06:00'!
debitFrom: aCard transactionAmout: aTotalAmount 
	
	self error: self invalidCardErrorMessage.
	! !


!MerchantProcessorInvalidCard methodsFor: 'errors' stamp: 'jn 6/17/2021 00:06:59'!
invalidCardErrorMessage

	^'1|INVALID CARD'! !


!classDefinition: #MerchantProcessorOK category: 'TusLibros'!
MerchantProcessorInterfaceSimulator subclass: #MerchantProcessorOK
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorOK methodsFor: 'debit' stamp: 'jn 6/17/2021 01:08:51'!
debitFrom: aCard transactionAmout: aTotalAmount 

! !
