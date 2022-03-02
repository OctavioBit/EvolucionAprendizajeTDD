!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'DV 6/14/2021 14:32:33'!
setUp 
	testObjects := StoreTestObjects  new! !

!CartTest methodsFor: 'tests' stamp: 'UC 6/16/2021 23:03:59'!
test01NewCartsAreCreatedEmpty

	self assert: testObjects emptyCartWithDefaultCatalogue isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'DV 6/17/2021 13:50:27'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjects emptyCartWithDefaultCatalogue.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: Cart invalidItemErrorMessage equals: anError messageText.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'UC 6/16/2021 23:04:11'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjects emptyCartWithDefaultCatalogue.
	
	cart add: testObjects itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'DV 6/17/2021 13:50:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjects emptyCartWithDefaultCatalogue.
	
	self 
		should: [cart add: 0 of: testObjects itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert:   Cart invalidQuantityErrorMessage equals: anError messageText.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'DV 6/17/2021 13:50:49'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjects emptyCartWithDefaultCatalogue.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: Cart invalidItemErrorMessage equals: anError messageText .
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'UC 6/16/2021 23:04:27'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjects emptyCartWithDefaultCatalogue.
	
	cart add: testObjects itemSellByTheStore.
	self assert: (cart includes: testObjects itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'UC 6/16/2021 23:04:31'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjects emptyCartWithDefaultCatalogue.
	
	self deny: (cart includes: testObjects itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'UC 6/16/2021 23:04:35'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjects emptyCartWithDefaultCatalogue.
	
	cart add: 2 of: testObjects itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjects itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'UC 6/16/2021 23:04:41'!
test09EmptyCartTotalIsZero

	| cart |
	
	cart := testObjects emptyCartWithDefaultCatalogue.
	
	self assert: 0 equals: cart total.! !

!CartTest methodsFor: 'tests' stamp: 'DV 6/17/2021 13:49:41'!
test10CartCanotUseCatalogueWIthNonPositivePrices

	| cart 	 catalogueWithZero catalogueWithNegativePrice |
	catalogueWithZero:=  Dictionary new.
	catalogueWithZero at: 'validBook' put: 0.

	self 
		should: [ cart := Cart  acceptingItemsOf:  catalogueWithZero. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: Cart invalidCatalogueMessage equals: anError messageText.
			self assert: cart isNil].
		
	catalogueWithNegativePrice:=  Dictionary new.
	catalogueWithNegativePrice at: 'validBook' put: -1.

	self 
		should: [ cart := Cart  acceptingItemsOf: catalogueWithNegativePrice. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: Cart invalidCatalogueMessage equals: anError messageText.
			self assert: cart isNil].! !


!CartTest methodsFor: 'support' stamp: 'DV 6/14/2021 14:34:34'!
itemNotSellByTheStore
	
	^ 'InvalidBook'! !


!classDefinition: #CashierPerSaleTest category: 'TusLibros'!
TestCase subclass: #CashierPerSaleTest
	instanceVariableNames: 'testObjects today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierPerSaleTest methodsFor: 'tests' stamp: 'UC 6/16/2021 23:06:53'!
setUp
	testObjects := StoreTestObjects new.! !

!CashierPerSaleTest methodsFor: 'tests' stamp: 'UC 6/16/2021 23:05:38'!
test01CreatingACashierPerSaleWithEmptyCartRaisesError

	| salesBook |
	salesBook := OrderedCollection new.
	self should: [self 
		cashierWith: testObjects emptyCartWithDefaultCatalogue 
		registeringOn: salesBook 
	] raise: Error 
	withExceptionDo:[:error | self assert: error messageText equals: CashierPerSale cannotCheckoutEmptyCart].
	
	self assert: salesBook isEmpty.
	! !

!CashierPerSaleTest methodsFor: 'tests' stamp: 'UC 6/16/2021 23:07:25'!
test02CheckOutMultipleItemsWithNonExpiredCardReturnsTotal

	| cashier multipleItemCart salesBook newCatalogue |

	newCatalogue :=  testObjects defaultCatalogue. 
	newCatalogue at: 'anotherBook' put: 200.
	
	salesBook := OrderedCollection new.
	multipleItemCart := Cart acceptingItemsOf: newCatalogue.
	
	multipleItemCart add: testObjects itemSellByTheStore.
	2 timesRepeat: [multipleItemCart add: 'anotherBook'].
	
	cashier := self cashierWith: multipleItemCart 
				registeringOn: salesBook.
	self assert: testObjects itemSellByTheStorePrice + 200 + 200 equals: cashier checkout.
! !

!CashierPerSaleTest methodsFor: 'tests' stamp: 'UC 6/16/2021 21:06:40'!
test03CreatingACashierPerSaleWithExpiredCreditCardRaisesError

	| oneItemCart salesBook |
	salesBook := OrderedCollection new.
	oneItemCart := self oneItemCart.

	self 
		should: [self 
				cashierWith: oneItemCart 
				chargingTo: self expiredCard 
				registeringOn: salesBook 
				with: MPSimulator answerWithOk 
			]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: CashierPerSale cannotCheckoutWithExpiredCard equals: anError messageText
		].
	self assert: salesBook isEmpty ! !

!CashierPerSaleTest methodsFor: 'tests' stamp: 'UC 6/16/2021 21:30:36'!
test04CheckOutClearsCart

	| cashier oneItemCart salesBook |
	salesBook := OrderedCollection new.
	oneItemCart := self oneItemCart.

	cashier := self cashierWith: oneItemCart 
				registeringOn: salesBook.
	cashier checkout.
	
	self assert: oneItemCart isEmpty! !

!CashierPerSaleTest methodsFor: 'tests' stamp: 'UC 6/16/2021 21:30:49'!
test05CheckOutRegistersASale
	| cashier oneItemCart salesBook total |
	salesBook := OrderedCollection new.
	oneItemCart := self oneItemCart.

	cashier := self cashierWith: oneItemCart 
				registeringOn: salesBook.
				
	total := cashier checkout.
	
	self assert: 1 equals: salesBook size.
	self assert:  total equals: salesBook first.
	! !

!CashierPerSaleTest methodsFor: 'tests' stamp: 'UC 6/16/2021 21:31:00'!
test06CheckingOutWIthCashierPerSaleTwiceRaisesError

	| oneItemCart salesBook cashier |
	salesBook := OrderedCollection new.
	oneItemCart := self oneItemCart.
	cashier := self cashierWith: oneItemCart 
				registeringOn: salesBook.
				
	cashier checkout.
	self 
		should: [ cashier checkout ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: CashierPerSale cannotCheckoutTwice equals: anError messageText
		].
	
	self assert: 1 equals: salesBook size! !

!CashierPerSaleTest methodsFor: 'tests' stamp: 'UC 6/16/2021 21:34:41'!
test07CheckOutWithStolenCardRaisesErrorAndLeavesUntouchedSalesBook

	| cashier oneItemCart salesBook |
	
	salesBook := OrderedCollection new.
	oneItemCart := self oneItemCart.
	cashier := self cashierWith: oneItemCart 
				registeringOn: salesBook 
				with: MPSimulator answerWithStolenCard.
	
	self should: [	cashier checkout.] 
		raise: Error
		      withExceptionDo: [:anError | self assert: MPSimulator cannotChargeStolenCard equals: anError messageText].
		
	self assert: salesBook isEmpty.
	self assert: oneItemCart isEmpty not.! !

!CashierPerSaleTest methodsFor: 'tests' stamp: 'UC 6/16/2021 21:34:37'!
test08CheckOutWithFakeCardRaisesErrorAndLeavesUntouchedSalesBook

	| cashier oneItemCart salesBook |
	
	salesBook := OrderedCollection new.
	oneItemCart := self oneItemCart.
	cashier := self cashierWith: oneItemCart 
				registeringOn: salesBook 
				with: MPSimulator answerWithFakeCard.
	
	self should: [	cashier checkout.] 
		raise: Error
		      withExceptionDo: [:anError | self assert: MPSimulator cannotChargeFakeCard equals: anError messageText].
		
	self assert: salesBook isEmpty.
	self assert: oneItemCart isEmpty not.! !

!CashierPerSaleTest methodsFor: 'tests' stamp: 'UC 6/16/2021 22:28:18'!
test09CheckOutWithInsolventCardRaisesErrorAndLeavesUntouchedSalesBook

	| cashier oneItemCart salesBook |
	
	salesBook := OrderedCollection new.
	oneItemCart := self oneItemCart.
	cashier := self cashierWith: oneItemCart 
				registeringOn: salesBook 
				with: MPSimulator answerWithInsolventCard.
	
	self should: [	cashier checkout.] 
		raise: Error
		      withExceptionDo: [:anError | self assert: MPSimulator cannotChargeInsolventCard equals: anError messageText].
		
	self assert: salesBook isEmpty.
	self assert: oneItemCart isEmpty not.! !

!CashierPerSaleTest methodsFor: 'tests' stamp: 'DV 6/17/2021 13:30:34'!
test10CheckOutWithInvalidSmallAmountRaisesErrorAndLeavesUntouchedSalesBook

	| cashier salesBook verySmallPriceCart newCatalogue |
	
	salesBook := OrderedCollection new.
	
	newCatalogue :=  testObjects defaultCatalogue. 
	newCatalogue at: 'anotherBook' put: 0.0001.
	
	verySmallPriceCart := Cart acceptingItemsOf: newCatalogue.
	
	verySmallPriceCart add: 'anotherBook'.


	cashier := self cashierWith: verySmallPriceCart
				registeringOn: salesBook 
				with: MPSimulator answerWithOk.
	
	self should: [	cashier checkout.] 
		raise: Error
		      withExceptionDo: [:anError | self assert: MPSimulator cannotChargeInvalidAmount  equals: anError messageText].
		
	self assert: salesBook isEmpty.
	self assert: verySmallPriceCart isEmpty not.! !

!CashierPerSaleTest methodsFor: 'tests' stamp: 'DV 6/17/2021 13:31:29'!
test11CheckOutWithInvalidBigAmountRaisesErrorAndLeavesUntouchedSalesBook

	| cashier salesBook veryBigPriceCart newCatalogue |
	
	salesBook := OrderedCollection new.
	
	newCatalogue :=  testObjects defaultCatalogue. 
	newCatalogue at: 'anotherBook' put: 99999999999999999999.
	
	veryBigPriceCart := Cart acceptingItemsOf: newCatalogue.
	
	veryBigPriceCart add: 'anotherBook'.


	cashier := self cashierWith: veryBigPriceCart
				registeringOn: salesBook 
				with: MPSimulator answerWithOk.
	
	self should: [	cashier checkout.] 
		raise: Error
		      withExceptionDo: [:anError | self assert: MPSimulator cannotChargeInvalidAmount  equals: anError messageText].
		
	self assert: salesBook isEmpty.
	self assert: veryBigPriceCart isEmpty not.! !


!CashierPerSaleTest methodsFor: 'support' stamp: 'UC 6/16/2021 21:44:23'!
cashierWith: aCart chargingTo: aCreditCard registeringOn: aSalesbook with: aMerchantProcessor 
	^ CashierPerSale 
		forCheckoutWith: aCart 
		chargingTo: aCreditCard 
		onDate: Date today 
		registeringOn: aSalesbook 
		with: aMerchantProcessor ! !

!CashierPerSaleTest methodsFor: 'support' stamp: 'UC 6/16/2021 23:08:23'!
cashierWith: aCart registeringOn: aSalesbook
	^ CashierPerSale 
		forCheckoutWith: aCart 
		chargingTo: testObjects validCreditCard 
		onDate: Date today 
		registeringOn: aSalesbook 
		with: MPSimulator answerWithOk! !

!CashierPerSaleTest methodsFor: 'support' stamp: 'UC 6/16/2021 23:08:38'!
cashierWith: aCart registeringOn: aSalesbook with: aMerchantProcessor 
	^ CashierPerSale 
		forCheckoutWith: aCart 
		chargingTo: testObjects validCreditCard
		onDate: Date today 
		registeringOn: aSalesbook 
		with: aMerchantProcessor 
		! !

!CashierPerSaleTest methodsFor: 'support' stamp: 'UC 6/16/2021 23:08:45'!
expiredCard
	^ CreditCard withName: testObjects validCardName withNumber: testObjects validCardNumber withExpirationDate: testObjects expiredMonthOfYear ! !

!CashierPerSaleTest methodsFor: 'support' stamp: 'UC 6/16/2021 23:07:50'!
oneItemCart

	^ testObjects emptyCartWithDefaultCatalogue add: testObjects itemSellByTheStore! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'testObjects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'UC 6/16/2021 23:06:53'!
setUp
	testObjects := StoreTestObjects new.! !

!CreditCardTest methodsFor: 'tests' stamp: 'UC 6/16/2021 23:05:45'!
test01CreatingACardWithANameLongerThan30CharactersRaisesError

	self should:[CreditCard 
				withName:  'ABSAKJHAFSKJASFAJKSHFKJSAHFASKJFHSAFKJHSAFKJH'
				withNumber:  testObjects validCardNumber 
				withExpirationDate: testObjects notExpiredMonthOfYear
			] 
		raise: Error 
		withExceptionDo:[:anError |self assert: CreditCard invalidNameErrorMessage equals: anError messageText].
		
	
	! !

!CreditCardTest methodsFor: 'tests' stamp: 'UC 6/16/2021 23:05:50'!
test02CreatingACardWithEmptyNameRaisesError


	self should:[
			CreditCard withName:  ''
					    	withNumber: testObjects validCardNumber 
					 	withExpirationDate: testObjects notExpiredMonthOfYear 
		] 
		raise: Error 
		withExceptionDo:[:anError |self assert: anError messageText equals: CreditCard invalidNameErrorMessage]
! !

!CreditCardTest methodsFor: 'tests' stamp: 'UC 6/16/2021 23:06:01'!
test03CreatingACardWithANumberDifferentThan16DigitsRaisesError

	self should:[ 
			CreditCard withName: testObjects validCardName
				withNumber: 44546
				withExpirationDate: testObjects notExpiredMonthOfYear
		] 		
		raise: Error 
		withExceptionDo:[:anError |self assert: anError messageText equals: CreditCard invalidNumberErrorMessage].
	
	self should:[
			CreditCard withName: testObjects validCardName
				withNumber: 4454666678364872364327846327846324786
				withExpirationDate: testObjects notExpiredMonthOfYear
		] 		
		raise: Error 
		withExceptionDo:[:anError |self assert: anError messageText equals: CreditCard invalidNumberErrorMessage]! !

!CreditCardTest methodsFor: 'tests' stamp: 'UC 6/16/2021 23:05:33'!
test04CreatingACardWithValidNameAndValidNumberAndValidDateIsCorrect

	|card|
	
	card := testObjects  validCreditCard.
	
	self assert: testObjects validCardName equals: card name.
	self assert: testObjects validCardNumber equals: card number.
	self assert: testObjects notExpiredMonthOfYear equals: card date.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'assertions' stamp: 'DV 6/17/2021 13:45:43'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self class invalidItemErrorMessage]! !

!Cart methodsFor: 'assertions' stamp: 'DV 6/17/2021 13:40:39'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self class invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'DV 6/13/2021 16:19:42'!
clear
	^items removeAll! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'DV 6/10/2021 20:42:53'!
total
	^items sum: [:item| catalog at: item] ifEmpty: 0! !


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

!Cart class methodsFor: 'instance creation' stamp: 'DV 6/17/2021 13:38:41'!
acceptingItemsOf: aCatalog
	self assertCatalogueHasOnlyPositivePrices: aCatalog.
	^self new initializeAcceptingItemsOf: aCatalog  ! !


!Cart class methodsFor: 'error messages' stamp: 'DV 6/17/2021 13:38:05'!
invalidCatalogueMessage
	
	^'El catalogo no debe contener precios con valores no positivos.'! !

!Cart class methodsFor: 'error messages' stamp: 'DV 6/17/2021 13:37:32'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'DV 6/17/2021 13:37:39'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart class methodsFor: 'assertions' stamp: 'DV 6/17/2021 13:48:54'!
assertCatalogueHasOnlyPositivePrices: aCatalogue
	aCatalogue do: [ :value | value strictlyPositive ifFalse:[self error: self invalidCatalogueMessage ]]

	 ! !


!classDefinition: #CashierPerSale category: 'TusLibros'!
Object subclass: #CashierPerSale
	instanceVariableNames: 'catalog items priceChart cart creditCard salesbook used merchantProcessor total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierPerSale methodsFor: 'initialization' stamp: 'DV 6/16/2021 18:43:10'!
initializeWith: aCart chargingTo: aCreditCard registeringOn: aSalesbook with: aMerchantProcessor

	cart := aCart.
	creditCard := aCreditCard. 
	salesbook := aSalesbook.
	merchantProcessor := aMerchantProcessor.
	used := false.! !


!CashierPerSale methodsFor: 'checkout' stamp: 'DV 6/16/2021 16:15:37'!
assertHasNotBeenUsedBefore.
	used ifTrue:[self error: self class cannotCheckoutTwice]! !

!CashierPerSale methodsFor: 'checkout' stamp: 'UC 6/16/2021 22:47:46'!
checkout
	self assertHasNotBeenUsedBefore.
	
	total := cart total.
	merchantProcessor charge: total on: creditCard.
	
	^self registerEndOfCheckout.
! !

!CashierPerSale methodsFor: 'checkout' stamp: 'UC 6/16/2021 22:47:46'!
registerEndOfCheckout
	cart clear.
	used := true.
	salesbook add: total.
	^total.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CashierPerSale class' category: 'TusLibros'!
CashierPerSale class
	instanceVariableNames: ''!

!CashierPerSale class methodsFor: 'instance creation' stamp: 'DV 6/16/2021 18:42:22'!
forCheckoutWith: aCart chargingTo: aCreditCard onDate: aDate registeringOn:aSalesbook with: aMerchantProcessor 
	self assertACartIsNotEmpty: aCart.
	self assertCardDateIsNotExpired: aCreditCard onDate: aDate.
	
	^ self new initializeWith: aCart chargingTo: aCreditCard registeringOn: aSalesbook with: aMerchantProcessor.! !


!CashierPerSale class methodsFor: 'error' stamp: 'DV 6/10/2021 20:18:19'!
cannotCheckoutEmptyCart
	^'No se puede facturar un carrito vacio'.! !

!CashierPerSale class methodsFor: 'error' stamp: 'DV 6/16/2021 16:13:20'!
cannotCheckoutTwice
	^'El cajero por venta se puede usar solo una vez'.! !

!CashierPerSale class methodsFor: 'error' stamp: 'DV 6/13/2021 14:49:27'!
cannotCheckoutWithExpiredCard
	^'No se puede facturar una tarjeta vencida'.! !


!CashierPerSale class methodsFor: 'assertions' stamp: 'DV 6/16/2021 13:35:10'!
assertACartIsNotEmpty: aCart

	aCart isEmpty ifTrue:[self error: self cannotCheckoutEmptyCart]! !

!CashierPerSale class methodsFor: 'assertions' stamp: 'DV 6/16/2021 15:30:41'!
assertCardDateIsNotExpired: aCard onDate: aDate
	| monthOfYear |
	monthOfYear:= GregorianMonthOfYear yearNumber: (aDate yearNumber) monthNumber: (aDate month monthIndex).
	(aCard isExpiredOn: monthOfYear) ifTrue: [self error: self cannotCheckoutWithExpiredCard]! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'name number date'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'DV 6/14/2021 11:10:19'!
initializeWithName: aName withNumber: aNumber withDate: aDate 
	name := aName.
	number := aNumber.
	date := aDate.! !


!CreditCard methodsFor: 'accessing' stamp: 'DV 6/14/2021 12:13:13'!
date
	^date! !

!CreditCard methodsFor: 'accessing' stamp: 'DV 6/14/2021 17:46:14'!
isExpiredOn: aMonthOfYear
	^(date < aMonthOfYear)! !

!CreditCard methodsFor: 'accessing' stamp: 'DV 6/14/2021 11:10:49'!
name 
	^name! !

!CreditCard methodsFor: 'accessing' stamp: 'DV 6/14/2021 12:12:58'!
number
	^number! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'DV 6/16/2021 15:20:42'!
withName: aName withNumber: aNumber withExpirationDate: aDate
	self assertCardNameIsNotEmptyAndNotLongerThan30Characters: aName.
	self assertCardNumberSizeis16Digits: aNumber.
	^self new initializeWithName: aName withNumber: aNumber withDate: aDate.! !


!CreditCard class methodsFor: 'error messages' stamp: 'DV 6/16/2021 14:30:55'!
invalidNameErrorMessage
	^'El nombre debe contener como máximo 30 caracteres y no ser vacío.'! !

!CreditCard class methodsFor: 'error messages' stamp: 'DV 6/14/2021 11:40:55'!
invalidNumberErrorMessage
	^'El número de tarjeta debe ser un NÚMERO con 16 dígitos.'! !


!CreditCard class methodsFor: 'assertions' stamp: 'DV 6/16/2021 14:44:51'!
assertCardNameIsNotEmpty:aName
	(aName withBlanksTrimmed isEmpty) ifTrue: [self error: self invalidNameErrorMessage]! !

!CreditCard class methodsFor: 'assertions' stamp: 'DV 6/16/2021 15:20:42'!
assertCardNameIsNotEmptyAndNotLongerThan30Characters: aName
	self assertCardNameIsNotEmpty:aName.
	self assertCardNameIsNotLongerThan30Characters: aName.! !

!CreditCard class methodsFor: 'assertions' stamp: 'DV 6/16/2021 14:44:36'!
assertCardNameIsNotLongerThan30Characters: aName

	(aName size > 30) ifTrue: [self error: self invalidNameErrorMessage]! !

!CreditCard class methodsFor: 'assertions' stamp: 'DV 6/16/2021 15:16:56'!
assertCardNumberSizeis16Digits: aNumber
	((aNumber numberOfDigitsInBase: 10) ~= 16) ifTrue: [self error: self invalidNumberErrorMessage]! !


!classDefinition: #MPSimulator category: 'TusLibros'!
Object subclass: #MPSimulator
	instanceVariableNames: 'stolenCards answerOk answerFake errorMessage'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!
!MPSimulator commentStamp: '<historical>' prior: 0!
Merchant Procesor Simulator!


!MPSimulator methodsFor: 'operations' stamp: 'DV 6/17/2021 13:01:45'!
assertAmountIsValid: anAmount. 
	((anAmount < 0.01) or:[(anAmount numberOfDigitsInBase: 10) > 15 ]) ifTrue:[self error: self class cannotChargeInvalidAmount]! !

!MPSimulator methodsFor: 'operations' stamp: 'DV 6/17/2021 12:57:57'!
charge: anAmount on: aCreditCard
	self assertAmountIsValid: anAmount. 
	answerOk ifFalse: [ self error: errorMessage].! !


!MPSimulator methodsFor: 'initialization' stamp: 'UC 6/16/2021 22:33:10'!
initializeWithFakeCard
	self setUpErrorMessage: self class cannotChargeFakeCard.! !

!MPSimulator methodsFor: 'initialization' stamp: 'UC 6/16/2021 22:33:36'!
initializeWithInsolventCard
	self setUpErrorMessage: self class cannotChargeInsolventCard.! !

!MPSimulator methodsFor: 'initialization' stamp: 'UC 6/16/2021 20:27:50'!
initializeWithOk
	answerOk := true.! !

!MPSimulator methodsFor: 'initialization' stamp: 'UC 6/16/2021 22:33:55'!
initializeWithStolenCard
	self setUpErrorMessage: self class cannotChargeStolenCard.! !

!MPSimulator methodsFor: 'initialization' stamp: 'UC 6/16/2021 22:33:20'!
setUpErrorMessage: anErrorMessage

	errorMessage := anErrorMessage.
	answerOk := false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MPSimulator class' category: 'TusLibros'!
MPSimulator class
	instanceVariableNames: ''!

!MPSimulator class methodsFor: 'instance creation' stamp: 'DV 6/16/2021 18:55:41'!
answerWithFakeCard
	^self new initializeWithFakeCard ! !

!MPSimulator class methodsFor: 'instance creation' stamp: 'UC 6/16/2021 22:28:18'!
answerWithInsolventCard
	^self new initializeWithInsolventCard! !

!MPSimulator class methodsFor: 'instance creation' stamp: 'DV 6/16/2021 18:40:32'!
answerWithOk
	^ self new initializeWithOk! !

!MPSimulator class methodsFor: 'instance creation' stamp: 'DV 6/16/2021 16:31:33'!
answerWithStolenCard
	^ self new initializeWithStolenCard! !


!MPSimulator class methodsFor: 'error messages' stamp: 'DV 6/16/2021 18:52:26'!
cannotChargeFakeCard
	^'La tarjeta se encuentra reportada como falsa por el MerchantProcessor'.! !

!MPSimulator class methodsFor: 'error messages' stamp: 'UC 6/16/2021 20:34:44'!
cannotChargeInsolventCard
	^'La tarjeta se encuentra reportada como insolvente por el MerchantProcessor'! !

!MPSimulator class methodsFor: 'error messages' stamp: 'DV 6/17/2021 13:02:15'!
cannotChargeInvalidAmount
	^'El monto a cobrar debe ser mayor a 0.01 y tener menos de 15 digitos'.! !

!MPSimulator class methodsFor: 'error messages' stamp: 'DV 6/16/2021 16:43:50'!
cannotChargeStolenCard
	^'La tarjeta se encuentra reportada como robada por el MerchantProcessor'.! !


!classDefinition: #StoreTestObjects category: 'TusLibros'!
Object subclass: #StoreTestObjects
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!
!StoreTestObjects commentStamp: '<historical>' prior: 0!
Simulador del Merchant Procesor!


!StoreTestObjects methodsFor: 'cart' stamp: 'UC 6/16/2021 23:02:52'!
defaultCatalogue
	| dict |
	dict:=  Dictionary new.
	dict at: self itemSellByTheStore put: self itemSellByTheStorePrice.
	^dict! !

!StoreTestObjects methodsFor: 'cart' stamp: 'UC 6/16/2021 23:03:06'!
emptyCartWithDefaultCatalogue
	^Cart acceptingItemsOf: self defaultCatalogue! !

!StoreTestObjects methodsFor: 'cart' stamp: 'UC 6/16/2021 23:03:18'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjects methodsFor: 'cart' stamp: 'UC 6/16/2021 23:03:21'!
itemSellByTheStorePrice
	
	^ 100! !


!StoreTestObjects methodsFor: 'dates' stamp: 'UC 6/16/2021 23:03:10'!
expiredDate
	^Date fromSeconds: (Date today secondsSinceSqueakEpoch  + 100000000)! !

!StoreTestObjects methodsFor: 'dates' stamp: 'UC 6/16/2021 23:03:14'!
expiredMonthOfYear
	^GregorianMonthOfYear yearNumber: (Date today yearNumber) - 5 monthNumber: (Date today month monthIndex)! !

!StoreTestObjects methodsFor: 'dates' stamp: 'UC 6/16/2021 23:03:26'!
notExpiredMonthOfYear
	^GregorianMonthOfYear yearNumber: (Date today yearNumber) + 5 monthNumber: (Date today month monthIndex)! !


!StoreTestObjects methodsFor: 'card' stamp: 'UC 6/16/2021 23:03:35'!
validCardName
	^ 'Simón Bolívar'! !

!StoreTestObjects methodsFor: 'card' stamp: 'UC 6/16/2021 23:03:41'!
validCardNumber
	^5555555555554444 ! !

!StoreTestObjects methodsFor: 'card' stamp: 'UC 6/16/2021 23:03:45'!
validCreditCard
	
	^ CreditCard withName: self validCardName withNumber: self validCardNumber withExpirationDate: self notExpiredMonthOfYear ! !
