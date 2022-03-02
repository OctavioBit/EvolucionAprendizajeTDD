!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testSupport'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'FS 11/23/2020 15:26:10'!
test01NewCartsAreCreatedEmpty

	self assert: testSupport createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'FS 11/23/2020 15:26:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testSupport createCart.
	
	self 
		should: [ cart add: testSupport itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'FS 11/23/2020 15:26:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testSupport createCart.
	
	cart add: testSupport itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'FS 11/23/2020 15:26:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testSupport createCart.
	
	self 
		should: [cart add: 0 of: testSupport itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'FS 11/23/2020 15:26:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testSupport createCart.
	
	self 
		should: [cart add: 2 of: testSupport itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'FS 11/23/2020 15:26:10'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testSupport createCart.
	
	cart add: testSupport itemSellByTheStore.
	self assert: (cart includes: testSupport itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'FS 11/23/2020 15:26:10'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testSupport createCart.
	
	self deny: (cart includes: testSupport itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'FS 11/23/2020 15:26:10'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testSupport createCart.
	
	cart add: 2 of: testSupport itemSellByTheStore.
	self assert: (cart occurrencesOf: testSupport itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'FS 11/23/2020 15:26:10'!
test09CartCanNotBeInitializedWithNonPositivePriceInCatalog
	
	| nonPositivePriceCatalog |
	nonPositivePriceCatalog _  Dictionary newFromPairs: (Array with: testSupport itemSellByTheStore with: -100).
	
	self 
		should: [Cart acceptingItemsOf: nonPositivePriceCatalog.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart nonPositivePriceInCatalogErrorMessage. ]
	
	! !

!CartTest methodsFor: 'tests' stamp: 'FS 11/23/2020 15:26:10'!
test10CannotAddNonIntegerNumberOfItems

	| cart |
	
	cart := testSupport createCart.
	
	self 
		should: [cart add: 1.5 of: testSupport itemSellByTheStore ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart fractionQuantityErrorMessage.
			self assert: cart isEmpty ]! !


!CartTest methodsFor: 'setUp' stamp: 'FS 11/23/2020 15:26:10'!
setUp
	testSupport _ TestSupport new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testSupport'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'FS 11/23/2020 15:26:22'!
setUp
	testSupport _ TestSupport new.! !

!CashierTest methodsFor: 'tests' stamp: 'FS 11/23/2020 15:26:22'!
test01CannotCheckoutEmptyCart

	| cart cashier |
	cart _ testSupport createCart.
	cashier _ Cashier withProcessor: MerchantProcessorNullSimulator new.
	
	self 
		should: [cashier checkOutWithCart: cart usingCard: testSupport defaultNotExpiredCreditCard .]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText = cashier checkoutEmptyCartErrorMessage. ]! !

!CashierTest methodsFor: 'tests' stamp: 'FS 11/23/2020 15:26:22'!
test02CheckOutCartWithOneItemChargesCorrectAmount

	| cart cashier chargedAmount |
	cart _ testSupport createCart.
	cart add: testSupport itemSellByTheStore .
	
	cashier _ Cashier withProcessor: MerchantProcessorNullSimulator new.
	chargedAmount _ cashier checkOutWithCart: cart usingCard: testSupport defaultNotExpiredCreditCard .
	
	self assert: chargedAmount equals: testSupport itemSellByTheStorePrice .
		
	! !

!CashierTest methodsFor: 'tests' stamp: 'FS 11/23/2020 15:26:22'!
test03CheckOutCartWithOneItemWithMultipleOcurrencesChargesCorrectAmount

	| cart cashier chargedAmount quantityOfItem |
	cart _ testSupport createCart.
	quantityOfItem _ 13.
	cart add: quantityOfItem of: testSupport itemSellByTheStore .
	
	cashier _ Cashier withProcessor: MerchantProcessorNullSimulator new.
	chargedAmount _ cashier checkOutWithCart: cart usingCard: testSupport defaultNotExpiredCreditCard .
	
	self assert: chargedAmount equals: (testSupport itemSellByTheStorePrice * quantityOfItem) .
		
	! !

!CashierTest methodsFor: 'tests' stamp: 'FS 11/23/2020 15:26:22'!
test04CheckOutCartWithMultipleItemsChargesCorrectAmount

	| cart cashier chargedAmount quantityOfItem quantityOfanotherItem correctPriceChargedForAnotherItem correctPriceChargedForItem |
	cart _ testSupport createCartWithMultipleItems.
	quantityOfItem _ 13.
	quantityOfanotherItem _ 7.

	cart add: quantityOfItem of: testSupport itemSellByTheStore .
	cart add: quantityOfanotherItem of: testSupport anotherItemSellByTheStore .

	cashier _ Cashier withProcessor: MerchantProcessorNullSimulator new.
	chargedAmount _ cashier checkOutWithCart: cart usingCard: testSupport defaultNotExpiredCreditCard .
	
	correctPriceChargedForItem _ quantityOfItem * testSupport itemSellByTheStorePrice.
	correctPriceChargedForAnotherItem _ quantityOfanotherItem * testSupport anotherItemSellByTheStorePrice.
	
	self assert: chargedAmount equals: (correctPriceChargedForItem + correctPriceChargedForAnotherItem) .
		
	! !

!CashierTest methodsFor: 'tests' stamp: 'FS 11/23/2020 15:26:22'!
test05CannotCheckoutWithExpiredCreditCard
	| cart cashier expiredCard |
	cart _ testSupport createCart.
	cart add: testSupport itemSellByTheStore .
	
	cashier _ Cashier withProcessor: MerchantProcessorNullSimulator new.
	expiredCard _ testSupport expiredCard.
	
	self 
		should: [cashier checkOutWithCart: cart usingCard: expiredCard.]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText = cashier expiredCardErrorMessage. ]! !

!CashierTest methodsFor: 'tests' stamp: 'FS 11/23/2020 15:26:22'!
test06CannotCargeFromAStolenCard
	| cart cashier card |
	cart _ testSupport createCart.
	cart add: testSupport itemSellByTheStore .
	
	cashier _ Cashier withProcessor: StolenCardProcessorSimulator new.
	card _ testSupport defaultNotExpiredCreditCard .
	
	self 
		should: [cashier checkOutWithCart: cart usingCard: card.]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText = MerchantProcessorAdapter cardIsStolenErrorMessage ]! !

!CashierTest methodsFor: 'tests' stamp: 'FS 11/23/2020 15:26:22'!
test07CannotCargeOnACardWithNotEnoughMoney
	| cart cashier card |
	cart _ testSupport createCart.
	cart add: testSupport itemSellByTheStore .
	
	cashier _ Cashier withProcessor: NotEnoughMoneyProcessorSimulator new.
	card _ testSupport defaultNotExpiredCreditCard .
	
	self 
		should: [cashier checkOutWithCart: cart usingCard: card.]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText = MerchantProcessorAdapter notEnoughMoney ]! !

!CashierTest methodsFor: 'tests' stamp: 'FS 11/23/2020 15:26:22'!
test08ProcessorChargesCorrectAmmountOnOneCard

	| cart cashier chargedAmount processor card |
	cart _ testSupport createCart.
	cart add: testSupport itemSellByTheStore .
	card _ testSupport defaultNotExpiredCreditCard.
	
	processor _ MerchantProcessorSimulator new.
	cashier _ Cashier withProcessor: processor.
	chargedAmount _ cashier checkOutWithCart: cart usingCard:  card.
	
	self assert: (processor hasCharged: chargedAmount onCard: card).! !

!CashierTest methodsFor: 'tests' stamp: 'FS 11/23/2020 15:26:22'!
test09ProcessorChargesCorrectlyMultipleCheckoutsOnSameCard

	| cart cashier chargedAmount processor card |
	cart _ testSupport createCart.
	cart add: testSupport itemSellByTheStore .
	card _ testSupport defaultNotExpiredCreditCard.
	
	processor _ MerchantProcessorSimulator new.
	cashier _ Cashier withProcessor: processor.
	
	cashier checkOutWithCart: cart usingCard:  card.
	chargedAmount _ cashier checkOutWithCart: cart usingCard:  card.

	self assert: (processor hasCharged: chargedAmount*2 onCard: card).! !

!CashierTest methodsFor: 'tests' stamp: 'FS 11/23/2020 15:26:22'!
test10ProcessorChargesCorrectlyOnMultipleCards

	| xxxCart cashier processor xxxCard yyyCard yyyCart chargedAmountOnxxx chargedAmountOnyyy |
	xxxCart _ testSupport createCartWithMultipleItems.
	xxxCart add: testSupport itemSellByTheStore .

	yyyCart _ testSupport createCartWithMultipleItems.
	yyyCart add: testSupport anotherItemSellByTheStore .
	
	xxxCard _ testSupport defaultNotExpiredCreditCard.
	yyyCard _ testSupport alternativeNotExpiredCreditCard.

	processor _ MerchantProcessorSimulator new.
	cashier _ Cashier withProcessor: processor.
	
	chargedAmountOnxxx _ cashier checkOutWithCart: xxxCart usingCard:  xxxCard.
	chargedAmountOnyyy _ cashier checkOutWithCart: yyyCart usingCard:  yyyCard.

	self assert: (processor hasCharged: chargedAmountOnxxx onCard: xxxCard).
	self assert: (processor hasCharged: chargedAmountOnyyy onCard: yyyCard).! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'testSupport'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'FS 11/23/2020 15:26:32'!
test01CreditCardNumberHas16Digits
	self
		should: [CreditCard withNumber: 234 withName: testSupport defaultName withExpirationDate: testSupport defaultExpDate ]
		raise: Error
		withExceptionDo:[
			:anError | self assert: anError messageText equals: CreditCard invalidCardNumberErrorMessage].
! !

!CreditCardTest methodsFor: 'tests' stamp: 'FS 11/23/2020 15:26:32'!
test02CreditCardNumberisAnInteger
	self
		should: [CreditCard withNumber: 234.5 withName: testSupport defaultName withExpirationDate: testSupport defaultExpDate ]
		raise: Error
		withExceptionDo:[
			:anError | self assert: anError messageText equals: CreditCard invalidCardNumberErrorMessage].
! !

!CreditCardTest methodsFor: 'tests' stamp: 'FS 11/23/2020 15:26:32'!
test03CreditCardNameCannotBeBlank
	self
		should: [CreditCard withNumber: testSupport defaultCardNumber withName: '' withExpirationDate: testSupport defaultExpDate 
]
		raise: Error
		withExceptionDo:[
			:anError | self assert: anError messageText equals: CreditCard invalidCardOwnerNameErrorMessage].
! !

!CreditCardTest methodsFor: 'tests' stamp: 'FS 11/23/2020 15:26:32'!
test04CardRemembersItsInformation
	
	| aCreditCard |
	aCreditCard _ testSupport defaultNotExpiredCreditCard .
	
	self assert:  aCreditCard ownersName equals: testSupport defaultName .
	self assert:  aCreditCard expirationDate equals: testSupport defaultExpDate .
	self assert:  aCreditCard cardNumber equals: testSupport defaultCardNumber.

		! !


!CreditCardTest methodsFor: 'setUp' stamp: 'FS 11/23/2020 15:26:32'!
setUp
	testSupport _ TestSupport new.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'assertions' stamp: 'FS 11/23/2020 15:25:40'!
assertHasOnlyPositivePrices: aCatalog

	^ aCatalog do: [:aCatalogPrice | aCatalogPrice < 0 ifTrue: [self error: self class nonPositivePriceInCatalogErrorMessage ]]! !

!Cart methodsFor: 'assertions' stamp: 'FS 11/23/2020 15:24:39'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self class invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'FS 11/23/2020 15:24:46'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self class invalidQuantityErrorMessage ].
	aQuantity isFloat ifTrue: [ self error: self class fractionQuantityErrorMessage ].! !


!Cart methodsFor: 'initialization' stamp: 'FS 11/23/2020 15:25:40'!
initializeAcceptingItemsOf: aCatalog

	self assertHasOnlyPositivePrices: aCatalog.
	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'accessing' stamp: 'FS 11/21/2020 22:45:45'!
priceList
	^catalog copy.! !


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


!Cart class methodsFor: 'error description' stamp: 'FS 11/23/2020 15:22:57'!
fractionQuantityErrorMessage
	^'Can not add a non integer quantity'.! !

!Cart class methodsFor: 'error description' stamp: 'FS 11/23/2020 15:22:23'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart class methodsFor: 'error description' stamp: 'FS 11/23/2020 15:22:30'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !

!Cart class methodsFor: 'error description' stamp: 'FS 11/23/2020 15:22:42'!
nonPositivePriceInCatalogErrorMessage
	
	^'A Catalog can not be initalized with non positive prices'! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'processor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'error description' stamp: 'HG 11/21/2020 21:58:20'!
checkoutEmptyCartErrorMessage
	^'Can not checkout with empty cart'.! !

!Cashier methodsFor: 'error description' stamp: 'FS 11/23/2020 14:10:19'!
expiredCardErrorMessage
	^'Card is expired!!'! !


!Cashier methodsFor: 'assertions' stamp: 'FS 11/23/2020 14:11:48'!
assertCartIsNotEmpty: aCart

	^ (aCart isEmpty) ifTrue: [self error: self checkoutEmptyCartErrorMessage.]! !

!Cashier methodsFor: 'assertions' stamp: 'FS 11/23/2020 14:11:16'!
assertThatCardIsntExpired: aCreditCard
	(aCreditCard expirationDate < GregorianMonthOfYear current) ifTrue:[self error: self expiredCardErrorMessage ].
	^true.
	! !


!Cashier methodsFor: 'checkout' stamp: 'FS 11/23/2020 14:32:14'!
checkOutWithCart: aCart usingCard: aCreditCard
	| priceList amountToCharge |
	self assertThatCardIsntExpired: aCreditCard.
	self assertCartIsNotEmpty: aCart.
	
	priceList _ aCart priceList.
	amountToCharge _ 		self sumAmountOfCart: aCart usingPriceList: priceList.
	
	processor charge: amountToCharge on: aCreditCard.
	^amountToCharge.
	 ! !


!Cashier methodsFor: 'cart assessment -- private' stamp: 'FS 11/23/2020 15:12:34'!
sumAmountOfCart: aCart usingPriceList: aPriceList

	^ (aPriceList keys) 
		inject: 0 
		into: [ :totalAmount :anItem |
				(aCart includes: anItem) 
				ifTrue: [ totalAmount + ( (aPriceList at: anItem) * (aCart occurrencesOf:  anItem))]
				ifFalse:[0]
			]! !


!Cashier methodsFor: 'initialization' stamp: 'FS 11/23/2020 14:24:43'!
initializeWith: aMerchantProcessor
	processor _ aMerchantProcessor .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: 'processor'!

!Cashier class methodsFor: 'instance creations' stamp: 'FS 11/23/2020 14:24:21'!
withProcessor: aMerchantProcessor
	^self new initializeWith: aMerchantProcessor .! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'cardNumber ownerName expireDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'FS 11/23/2020 13:26:49'!
initializeWithNumber: aCreditCardNumber withName: ownersName withExpirationDate: aGregorianMonthOfYear
	cardNumber _ aCreditCardNumber .
	ownerName _ ownersName.
	expireDate _ aGregorianMonthOfYear.
	! !


!CreditCard methodsFor: 'testing' stamp: 'FS 11/23/2020 14:04:39'!
cardNumber   
	^cardNumber  ! !

!CreditCard methodsFor: 'testing' stamp: 'FS 11/23/2020 14:04:28'!
expirationDate 
	^expireDate  ! !

!CreditCard methodsFor: 'testing' stamp: 'FS 11/23/2020 14:04:52'!
ownersName 
	^ownerName  ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'error description' stamp: 'FS 11/23/2020 13:08:36'!
invalidCardNumberErrorMessage
	^'Card must be an integer of 16 digits only'! !

!CreditCard class methodsFor: 'error description' stamp: 'FS 11/23/2020 13:19:43'!
invalidCardOwnerNameErrorMessage
	^'Name cannot be blank!!'! !


!CreditCard class methodsFor: 'instance creations' stamp: 'FS 11/23/2020 13:25:59'!
withNumber: aNumberForCardID withName: aStringForName withExpirationDate: aGregorianMonthOfYear

	self assertIsAValidCreditCardNumber: aNumberForCardID.	
	self assertIsAValidCreditCardOwnerName: aStringForName.
	
	^self new initializeWithNumber: aNumberForCardID withName: aStringForName withExpirationDate: aGregorianMonthOfYear
	! !


!CreditCard class methodsFor: 'assertions' stamp: 'FS 11/23/2020 13:10:22'!
assertIsAValidCreditCardNumber: aNumber

	(aNumber isInteger ) ifFalse: [self error: self invalidCardNumberErrorMessage ].
	((aNumber numberOfDigitsInBase: 10 ) = 16 ) ifFalse: [self error: self invalidCardNumberErrorMessage ].
	
	^true! !

!CreditCard class methodsFor: 'assertions' stamp: 'FS 11/23/2020 13:18:17'!
assertIsAValidCreditCardOwnerName: aString

	(aString isEmpty ) ifTrue: [self error: self invalidCardOwnerNameErrorMessage ].
	
	^true! !


!classDefinition: #MerchantProcessorAdapter category: 'TusLibros'!
Object subclass: #MerchantProcessorAdapter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorAdapter methodsFor: 'charging operation' stamp: 'FS 11/23/2020 14:19:46'!
charge: anAmount on: aCreditCard
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorAdapter class' category: 'TusLibros'!
MerchantProcessorAdapter class
	instanceVariableNames: ''!

!MerchantProcessorAdapter class methodsFor: 'error description' stamp: 'FS 11/23/2020 14:27:22'!
cardIsStolenErrorMessage
	^'Stolen Card!!'! !

!MerchantProcessorAdapter class methodsFor: 'error description' stamp: 'FS 11/23/2020 14:35:56'!
notEnoughMoney
	^'Insufficient money on account!!'! !


!classDefinition: #MerchantProcessorNullSimulator category: 'TusLibros'!
MerchantProcessorAdapter subclass: #MerchantProcessorNullSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorNullSimulator methodsFor: 'charging' stamp: 'FS 11/23/2020 14:30:34'!
charge: anAmount on: aCreditCard! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
MerchantProcessorAdapter subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'chargingHistory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'charging operations' stamp: 'FS 11/23/2020 15:27:33'!
charge: anAmount on: aCreditCard
	
	| previousChargedAmount |
	
	previousChargedAmount _ self previousAmountOn: aCreditCard.
	chargingHistory at: aCreditCard put: anAmount + previousChargedAmount.
	
! !


!MerchantProcessorSimulator methodsFor: 'testing' stamp: 'FS 11/23/2020 15:21:22'!
hasCharged: anAmount onCard: aCreditCard
	^(chargingHistory includesKey: aCreditCard) and: (chargingHistory at: aCreditCard) = anAmount
	! !


!MerchantProcessorSimulator methodsFor: 'initialization' stamp: 'FS 11/23/2020 15:13:43'!
initialize
	chargingHistory _ Dictionary new.! !


!MerchantProcessorSimulator methodsFor: 'accessing -- private' stamp: 'FS 11/23/2020 15:18:55'!
previousAmountOn: aCreditCard
	^ chargingHistory at: aCreditCard  ifAbsent:[0].! !


!classDefinition: #NotEnoughMoneyProcessorSimulator category: 'TusLibros'!
MerchantProcessorAdapter subclass: #NotEnoughMoneyProcessorSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!NotEnoughMoneyProcessorSimulator methodsFor: 'charging' stamp: 'FS 11/23/2020 14:34:14'!
charge: anAmount on: aCreditCard
	^self error: self class notEnoughMoney.! !


!classDefinition: #StolenCardProcessorSimulator category: 'TusLibros'!
MerchantProcessorAdapter subclass: #StolenCardProcessorSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StolenCardProcessorSimulator methodsFor: 'charging' stamp: 'FS 11/23/2020 14:28:14'!
charge: anAmount on: aCreditCard
	self error: self class cardIsStolenErrorMessage .
	! !


!classDefinition: #TestSupport category: 'TusLibros'!
Object subclass: #TestSupport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestSupport methodsFor: 'creditcard test support' stamp: 'FS 11/23/2020 13:40:02'!
defaultCardNumber

	^ 1234567891234567! !

!TestSupport methodsFor: 'creditcard test support' stamp: 'FS 11/23/2020 14:07:54'!
defaultExpDate

	^ GregorianMonthOfYear current next! !

!TestSupport methodsFor: 'creditcard test support' stamp: 'FS 11/23/2020 13:39:45'!
defaultName

	^ 'Jorge'! !

!TestSupport methodsFor: 'creditcard test support' stamp: 'FS 11/23/2020 14:26:39'!
defaultNotExpiredCreditCard
	^CreditCard withNumber: self defaultCardNumber withName: self defaultName withExpirationDate: self defaultExpDate ! !


!TestSupport methodsFor: 'cart test support' stamp: 'FS 11/21/2020 22:35:42'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!TestSupport methodsFor: 'cart test support' stamp: 'FS 11/21/2020 22:36:22'!
defaultCatalog
	
	^ Dictionary newFromPairs: (Array with: self itemSellByTheStore with: self itemSellByTheStorePrice).! !

!TestSupport methodsFor: 'cart test support' stamp: 'FS 11/21/2020 22:34:41'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!TestSupport methodsFor: 'cart test support' stamp: 'FS 11/21/2020 22:34:27'!
itemSellByTheStore
	^'validBook'.! !


!TestSupport methodsFor: 'cashier test support' stamp: 'FS 11/23/2020 15:07:30'!
alternativeNotExpiredCreditCard
	^CreditCard withNumber: 1111111111111111 withName: 'Marina' withExpirationDate: self defaultExpDate ! !

!TestSupport methodsFor: 'cashier test support' stamp: 'FS 11/21/2020 22:57:45'!
anotherItemSellByTheStore
	^'anotherValidBook'! !

!TestSupport methodsFor: 'cashier test support' stamp: 'FS 11/21/2020 22:57:58'!
anotherItemSellByTheStorePrice
	
	^57! !

!TestSupport methodsFor: 'cashier test support' stamp: 'FS 11/21/2020 23:09:41'!
createCartWithMultipleItems
	
	^Cart acceptingItemsOf: (Dictionary newFromPairs: (
					Array with: self itemSellByTheStore with: self itemSellByTheStorePrice
						   with: self anotherItemSellByTheStore with: self anotherItemSellByTheStorePrice)).! !

!TestSupport methodsFor: 'cashier test support' stamp: 'FS 11/23/2020 14:00:36'!
expiredCard
	|  expiredDate |

	expiredDate _ GregorianMonthOfYear current previous .
	^CreditCard withNumber: self defaultCardNumber withName: self defaultName withExpirationDate: expiredDate
	
	! !

!TestSupport methodsFor: 'cashier test support' stamp: 'FS 11/21/2020 22:36:31'!
itemSellByTheStorePrice
	
	^100! !
