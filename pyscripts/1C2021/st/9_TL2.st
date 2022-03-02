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

!CartTest methodsFor: 'tests' stamp: 'TPL 6/17/2021 02:24:22'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: (self itemSellByTheStore).
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

!CartTest methodsFor: 'tests' stamp: 'TPL 6/17/2021 16:38:58'!
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

!CartTest methodsFor: 'tests' stamp: 'TPL 6/17/2021 16:39:05'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'TPL 6/17/2021 02:02:16'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'TPL 6/17/2021 16:37:06'!
defaultCatalog
	|d|
	d := Dictionary new.
	d add: 'validBook'->5.
	^d.! !

!CartTest methodsFor: 'support' stamp: 'TPL 6/17/2021 16:38:40'!
itemNotSellByTheStore
	
	^ 'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'TPL 6/17/2021 16:38:44'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'test' stamp: 'TPL 6/17/2021 16:39:22'!
test01CheckoutEmptyCart
	|cart cashier creditCard catalog|
	
	cashier:= Cashier with: (MerchantProcesorSimulator with: 'Success').
	cart:= Cart acceptingItemsOf: Array new.
	catalog:= Dictionary new.
	creditCard := CreditCard withNumber: 1234567891011121 ofOwner: 'Fulanito' withMonthExpiration: 9 andYearExpirationDate: 2020.
	
		self 
		should: [	cashier checkout: cart from: catalog with: creditCard onMonth: 8 andYear:2020.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier invalidAmountOfItemsToCheckOut.]
	! !

!CashierTest methodsFor: 'test' stamp: 'TPL 6/17/2021 16:42:19'!
test02OnCheckoutSuccessfullyCalculationOfTotalAmountToPay
	|cart cashier creditCard catalog|
	
	cashier:= Cashier with: (MerchantProcesorSimulator with: 'Success').
	catalog:= Dictionary new.
	catalog add: '223'-> 456.00; add: '189'-> 12.00; yourself.
	cart:= Cart acceptingItemsOf: catalog.
	creditCard := CreditCard withNumber: 1234567891011121 ofOwner: 'Fulanito' withMonthExpiration: 9 andYearExpirationDate: 2020.
	
	self assert: OrderedCollection new equals: cashier operations.
	
	cart add: 1 of: '223'.
	cart add: 1 of: '189'.
	cashier checkout: cart from: catalog with: creditCard onMonth: 8 andYear: 2020.
	self assert:  (OrderedCollection with: 468.00) equals: cashier operations.
	! !

!CashierTest methodsFor: 'test' stamp: 'TPL 6/17/2021 16:42:54'!
test03CorrectRegistrationOfAGroupOfValidSales
	|cart1 cart2 cashier creditCard catalog|
	
	cashier:= Cashier with: (MerchantProcesorSimulator with: 'Success').
	catalog:= Dictionary new.
	catalog add: '123'-> 456.00; add: '789'-> 12.00; add: '1'->3.00; yourself.
	cart1:= Cart acceptingItemsOf: catalog.
	cart2:= Cart acceptingItemsOf: catalog.
	creditCard := CreditCard withNumber: 1234567891011121 ofOwner: 'Fulanito' withMonthExpiration: 9 andYearExpirationDate: 2020.
	
	self assert: OrderedCollection new equals: cashier operations.
	
	cart1 add: 1 of: '123'.
	cart1 add: 1 of: '789'.
	cashier checkout: cart1 from: catalog with: creditCard onMonth: 8 andYear:2020.
	
	cart2 add: 3 of: '1'.
	cashier checkout: cart2 from: catalog with: creditCard onMonth: 8 andYear:2020.
	self assert:  (OrderedCollection with: 468.00 with: 9.00) equals: cashier operations.
	! !

!CashierTest methodsFor: 'test' stamp: 'TPL 6/17/2021 16:43:05'!
test04CantDoCheckOutWithExpiredCard
	|cart cashier creditCard catalog|
	
	cashier:= Cashier with: (MerchantProcesorSimulator with: 'Success').
	catalog:= Dictionary new.
	catalog add: '123'-> 456.00; add: '789'-> 12.00; add: '1'->3.00; yourself.
	cart:= Cart acceptingItemsOf: catalog.
	creditCard := CreditCard withNumber: 1234567891011121 ofOwner: 'Fulanito' withMonthExpiration: 9 andYearExpirationDate: 2020.
	cart add: 1 of: '123'.
	
	self 
		should: [cashier checkout: cart from: catalog with: creditCard onMonth: 10 andYear:2020]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cantCheckoutWithExpiredCard.].
	
	self assert: OrderedCollection new equals: cashier operations.
! !

!CashierTest methodsFor: 'test' stamp: 'TPL 6/17/2021 16:43:12'!
test05CantDoCheckOutWithNotExpiredCard
	|cart cashier creditCard catalog|
	
	cashier:= Cashier with: (MerchantProcesorSimulator with: 'Success').
	catalog:= Dictionary new.
	catalog add: '123'-> 456.00; add: '789'-> 12.00; add: '1'->3.00; yourself.
	cart:= Cart acceptingItemsOf: catalog.
	creditCard := CreditCard withNumber: 1234567891011121 ofOwner: 'Fulanito' withMonthExpiration: 9 andYearExpirationDate: 2020.
	cart add: 1 of: '123'.
	
	cashier checkout: cart from: catalog with: creditCard onMonth: 8 andYear:2020.
	
	self assert: (OrderedCollection with: 456) equals: cashier operations.
! !

!CashierTest methodsFor: 'test' stamp: 'TPL 6/17/2021 16:43:19'!
test06CantDoCheckOutWhenMerchantProcesorIsDown
	|cart cashier creditCard catalog|

	cashier:= Cashier with: (MerchantProcesorSimulator with: 'MerchantProcesorDown').
	catalog:= Dictionary new.
	catalog add: '123'-> 456.00; add: '789'-> 12.00; add: '1'->3.00; yourself.
	cart:= Cart acceptingItemsOf: catalog.
	creditCard := CreditCard withNumber: 1234567891011121 ofOwner: 'Fulanito' withMonthExpiration: 9 andYearExpirationDate: 2020.
	cart add: 1 of: '123'.
	
	self 
	should: [cashier checkout: cart from: catalog with: creditCard onMonth: 8 andYear:2020.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = MerchantProcesorSimulator merchantProcesorDownMessageError.].
		
	self assert: OrderedCollection new equals: cashier operations.
! !

!CashierTest methodsFor: 'test' stamp: 'TPL 6/17/2021 16:43:25'!
test07CantDoCheckOutWhenCardIsStolen

	|cart cashier creditCard catalog|
	
	cashier:= Cashier with: (MerchantProcesorSimulator with: 'StolenCard').
	catalog:= Dictionary new.
	catalog add: '123'-> 456.00; add: '789'-> 12.00; add: '1'->3.00; yourself.
	cart:= Cart acceptingItemsOf: catalog.
	creditCard := CreditCard withNumber: 1234567891011121 ofOwner: 'Fulanito' withMonthExpiration: 9 andYearExpirationDate: 2020.
	cart add: 1 of: '123'.
	
	self 
	should: [cashier checkout: cart from: catalog with: creditCard onMonth: 8 andYear:2020.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = MerchantProcesorSimulator stolenCardMessageError .].
		
	self assert: OrderedCollection new equals: cashier operations.
! !

!CashierTest methodsFor: 'test' stamp: 'TPL 6/17/2021 16:43:33'!
test08CantDoCheckOutWhenCardIsFake

	|cart cashier creditCard catalog|
	
	cashier:= Cashier with: (MerchantProcesorSimulator with: 'FakeCard').
	catalog:= Dictionary new.
	catalog add: '123'-> 456.00; add: '789'-> 12.00; add: '1'->3.00; yourself.
	cart:= Cart acceptingItemsOf: catalog.
	creditCard := CreditCard withNumber: 1234567891011121 ofOwner: 'Fulanito' withMonthExpiration: 9 andYearExpirationDate: 2020.
	cart add: 1 of: '123'.
	
	self 
	should: [cashier checkout: cart from: catalog with: creditCard onMonth: 8 andYear:2020.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = MerchantProcesorSimulator fakeCardMessageError .].
		
	self assert: OrderedCollection new equals: cashier operations.
! !

!CashierTest methodsFor: 'test' stamp: 'TPL 6/17/2021 16:43:44'!
test09CantDoCheckOutWhitNoFundsCard

	|cart cashier creditCard catalog|
	
	cashier:= Cashier with: (MerchantProcesorSimulator with: 'NoFundsCard').
	catalog:= Dictionary new.
	catalog add: '123'-> 456.00; add: '789'-> 12.00; add: '1'->3.00; yourself.
	cart:= Cart acceptingItemsOf: catalog.
	creditCard := CreditCard withNumber: 1234567891011121 ofOwner: 'Fulanito' withMonthExpiration: 9 andYearExpirationDate: 2020.
	cart add: 1 of: '123'.
	
	self 
	should: [cashier checkout: cart from: catalog with: creditCard onMonth: 8 andYear:2020.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = MerchantProcesorSimulator noFundsCardMessageError .].
		
	self assert: OrderedCollection new equals: cashier operations.
! !

!CashierTest methodsFor: 'test' stamp: 'TPL 6/17/2021 17:01:46'!
test10CantDoCheckOutWhitInvalidCardOwnerName
	
	self 
	should: [CreditCard withNumber: 1234567891011121 ofOwner: 'FulanitoMenganitoYSultanitoFulanitoMenganitoYSultanito' withMonthExpiration: 9 andYearExpirationDate: 2020]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = CreditCard invalidOwnerName .].
		
! !

!CashierTest methodsFor: 'test' stamp: 'TPL 6/17/2021 17:02:05'!
test11CantDoCheckOutWhitEmptyCardOwnerName
	
	self 
	should: [CreditCard withNumber: 1234567891011121 ofOwner: '                             ' withMonthExpiration: 9 andYearExpirationDate: 2020]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = CreditCard invalidOwnerName .].
		
! !

!CashierTest methodsFor: 'test' stamp: 'TPL 6/17/2021 17:03:14'!
test12CantDoCheckOutInvalidCardNumber
	
	self 
	should: [CreditCard withNumber: 1234567890123456789 ofOwner: 'Fulanito' withMonthExpiration: 9 andYearExpirationDate: 2020]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = CreditCard invalidIdentificator.].
		
! !


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


!Cart methodsFor: 'assertions' stamp: 'TPL 6/17/2021 02:26:37'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'TPL 6/17/2021 02:56:37'!
items
	^items.! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'TPL 6/17/2021 02:23:24'!
add: anItem

	^ self add: 1 of: anItem.! !

!Cart methodsFor: 'adding' stamp: 'TPL 6/17/2021 16:33:39'!
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
	instanceVariableNames: 'operations mp'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'operations' stamp: 'TPL 6/17/2021 16:25:14'!
checkout: aCart from: aCatalog with: aCreditCard onMonth: aMonthNumber andYear: aYearNumber 
	|total|
	(aCreditCard isExpiredOnCurrentMonth: aMonthNumber andCurrentYear: aYearNumber) ifTrue:[self error: self class cantCheckoutWithExpiredCard].
	(aCart isEmpty) ifTrue: [self error: self class invalidAmountOfItemsToCheckOut ].
	
	total:=0.
	total _ 0. aCart items do: [:anItem | total _ total + (aCatalog at: anItem)].

	mp processPaymentFor:	 total with: aCreditCard.

	operations add: total.! !

!Cashier methodsFor: 'operations' stamp: 'TPL 6/17/2021 01:52:35'!
operations
	^operations.! !



!Cashier methodsFor: 'initialization' stamp: 'TPL 6/17/2021 13:43:47'!
initializeWithMerchantProcessor: aMerchantProcesor
	operations:= OrderedCollection new.
	mp _ aMerchantProcesor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'TPL 6/17/2021 15:56:30'!
with: aMerchantProcesor

	^self new initializeWithMerchantProcessor: aMerchantProcesor.! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'TPL 6/17/2021 03:04:10'!
withListOfSales

	^self new initializeWithLisOfSales: OrderedCollection new.! !


!Cashier class methodsFor: 'errors' stamp: 'TPL 6/17/2021 16:02:59'!
cantCheckoutWithExpiredCard
	^'Invalid checkout. Card expired'.! !

!Cashier class methodsFor: 'errors' stamp: 'TPL 6/17/2021 16:05:43'!
invalidAmountOfItemsToCheckOut
	^'Invalid checkout. Cart is empty'.! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'number monthExpiration yearExpiration owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'TPL 6/17/2021 16:58:51'!
assertCardNumberSize: aNumber.
	((aNumber numberOfDigitsInBase: 10) = 16) ifFalse: [self error: self class invalidIdentificator].
! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'TPL 6/17/2021 16:59:23'!
assertCardOwnerName: aName.
	((aName withBlanksTrimmed isEmpty) or: aName size > 30)  ifTrue: [self error: self class invalidOwnerName].
! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'TPL 6/17/2021 16:55:30'!
initializeWithId: aNumber aName: aName aMonthExpiration: aMonthNumber andYearExpirationDate: aYearhNumber
	self assertCardNumberSize: aNumber.
	self assertCardOwnerName: aName.
	number:= aNumber.
	monthExpiration:= aMonthNumber. 
	yearExpiration:= aYearhNumber.
	owner:= aName.! !


!CreditCard methodsFor: 'querys' stamp: 'TPL 6/17/2021 04:34:57'!
isExpiredOnCurrentMonth: aMonthNumber andCurrentYear: aYearNumber 
	(yearExpiration < aYearNumber) ifTrue:[^true].
	(yearExpiration = aYearNumber and: monthExpiration < aMonthNumber) ifTrue:[^true].	
	^false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'TPL 6/17/2021 16:58:34'!
invalidIdentificator
	^'Invalid card number'.! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'TPL 6/17/2021 16:57:59'!
invalidOwnerName
	^'Invalid owner name'.! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'TPL 6/17/2021 04:31:25'!
withNumber: anIdentificator ofOwner: aName withMonthExpiration: aMonthNumber andYearExpirationDate: aYearhNumber.
	^self new initializeWithId: anIdentificator aName: aName aMonthExpiration: aMonthNumber andYearExpirationDate:aYearhNumber.
! !



!classDefinition: #MerchantProcesorSimulator category: 'TusLibros'!
Object subclass: #MerchantProcesorSimulator
	instanceVariableNames: 'merchantProcesorSimulator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!MerchantProcesorSimulator methodsFor: 'as yet unclassified' stamp: 'TPL 6/17/2021 17:03:58'!
processPaymentFor: aValue with: aCreditCard 
 ^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcesorSimulator class' category: 'TusLibros'!
MerchantProcesorSimulator class
	instanceVariableNames: 'merchantProcesorSimulator'!

!MerchantProcesorSimulator class methodsFor: 'as yet unclassified' stamp: 'TPL 6/17/2021 15:23:47'!
fakeCardMessageError
	^'Card does not exist'.! !

!MerchantProcesorSimulator class methodsFor: 'as yet unclassified' stamp: 'TPL 6/17/2021 15:22:38'!
merchantProcesorDownMessageError
	^'Merchant Procesor is down'.! !

!MerchantProcesorSimulator class methodsFor: 'as yet unclassified' stamp: 'TPL 6/17/2021 16:00:37'!
noFundsCardMessageError
	^'Card does not have enough funds'.! !

!MerchantProcesorSimulator class methodsFor: 'as yet unclassified' stamp: 'TPL 6/17/2021 15:22:34'!
stolenCardMessageError
	^'Stolen card'.! !


!MerchantProcesorSimulator class methodsFor: 'initialization' stamp: 'TPL 6/17/2021 15:58:18'!
with: aMerchantProcesorSimulator 
	(aMerchantProcesorSimulator='MerchantProcesorDown') ifTrue:[^ DownMerchantProcesor new].
	(aMerchantProcesorSimulator='Success') ifTrue:[^ SuccessMerchantProcesor new].
	(aMerchantProcesorSimulator='StolenCard') ifTrue:[^ StolenCardMerchantProcesor new].
	(aMerchantProcesorSimulator='FakeCard') ifTrue:[^ FakeCardMerchantProcesor new].
	(aMerchantProcesorSimulator='NoFundsCard') ifTrue:[^ NoFundsCardMerchantProcesor new].! !


!classDefinition: #DownMerchantProcesor category: 'TusLibros'!
MerchantProcesorSimulator subclass: #DownMerchantProcesor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!DownMerchantProcesor methodsFor: 'operations' stamp: 'TPL 6/17/2021 15:40:06'!
processPaymentFor: aValue with: aCreditCard 
	self error: (super class merchantProcesorDownMessageError).! !


!classDefinition: #FakeCardMerchantProcesor category: 'TusLibros'!
MerchantProcesorSimulator subclass: #FakeCardMerchantProcesor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!FakeCardMerchantProcesor methodsFor: 'as yet unclassified' stamp: 'TPL 6/17/2021 15:51:13'!
processPaymentFor: aValue with: aCreditCard 
	self error: (super class fakeCardMessageError ).! !


!classDefinition: #NoFundsCardMerchantProcesor category: 'TusLibros'!
MerchantProcesorSimulator subclass: #NoFundsCardMerchantProcesor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!NoFundsCardMerchantProcesor methodsFor: 'as yet unclassified' stamp: 'TPL 6/17/2021 16:00:37'!
processPaymentFor: aValue with: aCreditCard 
	self error: (super class noFundsCardMessageError).! !


!classDefinition: #StolenCardMerchantProcesor category: 'TusLibros'!
MerchantProcesorSimulator subclass: #StolenCardMerchantProcesor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StolenCardMerchantProcesor methodsFor: 'as yet unclassified' stamp: 'TPL 6/17/2021 15:51:28'!
processPaymentFor: aValue with: aCreditCard 
	self error: (super class stolenCardMessageError ).! !


!classDefinition: #SuccessMerchantProcesor category: 'TusLibros'!
MerchantProcesorSimulator subclass: #SuccessMerchantProcesor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SuccessMerchantProcesor methodsFor: 'as yet unclassified' stamp: 'TPL 6/17/2021 16:48:32'!
processPaymentFor: aValue with: aCreditCard ! !
