!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'GDH 6/17/2021 01:05:35'!
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


!CartTest methodsFor: 'support' stamp: 'GDH 6/17/2021 01:05:26'!
createCart
	
	^testObjectsFactory cartWithDefaultCatalog ! !

!CartTest methodsFor: 'support' stamp: 'GDH 6/17/2021 01:05:01'!
defaultCatalog
	
	^ testObjectsFactory defaultCatalog ! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'GDH 6/17/2021 01:05:11'!
itemSellByTheStore
	
	^ '1'! !


!CartTest methodsFor: 'setUp/tearDown' stamp: 'GDH 6/17/2021 01:03:10'!
setUp
	
	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #StoreTest category: 'TusLibros'!
TestCase subclass: #StoreTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTest methodsFor: 'assertions' stamp: 'GDH 6/16/2021 23:59:07'!
assertCheckout: aCart WithCreditCard: aCreditCard ShouldRaiseErrorWithMessageText: aMessageText
	
	| salesBook |
		
	salesBook := testObjectsFactory emptySalesbook .
	
	self 
		should: [ Cashier new checkout: aCart withCard: aCreditCard on: testObjectsFactory today registeringOn: salesBook processingWith: NoErrorMerchantProcessor new ]
		raise:  Error - MessageNotUnderstood 
		withMessageText: aMessageText.
	
	self assert: salesBook isEmpty 
	! !

!StoreTest methodsFor: 'assertions' stamp: 'GDH 6/16/2021 23:59:07'!
assertCheckout: aCart WithCreditCardCreatedAs: creditCardCreationClosure ShouldRaiseErrorWithMessageText: aMessageText
	
	| salesBook |
	
	salesBook := testObjectsFactory emptySalesbook .
	
	self 
		should: [ Cashier new checkout: aCart 
						  withCard: creditCardCreationClosure value 
						  on: testObjectsFactory today 
						  registeringOn: salesBook processingWith: NoErrorMerchantProcessor new ]
		raise:  Error - MessageNotUnderstood 
		withMessageText: aMessageText.
	
	self assert: salesBook isEmpty 
	! !


!StoreTest methodsFor: 'testing' stamp: 'GDH 6/16/2021 22:42:43'!
test01CheckoutWithEmptyCartShouldRaiseAnError
				
	self assertCheckout: testObjectsFactory cartWithDefaultCatalog 
		WithCreditCard: testObjectsFactory creditCardValidAndNotExpired 
		ShouldRaiseErrorWithMessageText: Cashier checkoutWithEmptyCartErrorMessage.! !

!StoreTest methodsFor: 'testing' stamp: 'GDH 6/16/2021 23:59:07'!
test02CheckoutCartWithOneItemShouldReturnCartTotalValue

	| cart creditCard |
		
	cart := testObjectsFactory cartWithDefaultCatalog .
	cart add: '1'.
	
	creditCard := testObjectsFactory creditCardValidAndNotExpired .
	
	self assert: (Cashier new 
				checkout: cart 
				withCard: creditCard 
				on: testObjectsFactory today 
				registeringOn: testObjectsFactory emptySalesbook processingWith: NoErrorMerchantProcessor new ) 
		equals: 10.
	
	
	
	
	
	! !

!StoreTest methodsFor: 'testing' stamp: 'GDH 6/16/2021 23:59:07'!
test03CheckoutCartWithManyItemShouldReturnCartTotalValue

	| cart creditCard |
	
	cart := testObjectsFactory cartWithDefaultCatalog .
	cart add: '1'.
	cart add: '2'.
	
	creditCard := testObjectsFactory creditCardValidAndNotExpired .
	
	self assert: (Cashier new checkout: cart 
				withCard: creditCard 
				on: testObjectsFactory today 
				registeringOn: testObjectsFactory emptySalesbook processingWith: NoErrorMerchantProcessor new ) 
		equals: 30.
	
	
	
	
	
	! !

!StoreTest methodsFor: 'testing' stamp: 'GDH 6/16/2021 22:54:47'!
test04CheckOutWithInvalidLengthCreditCardNumberShouldRaiseAnError
	
	self assertCheckout: testObjectsFactory cartWithDefaultCatalogAndProducts 
		 WithCreditCardCreatedAs: [ CreditCard number: 111122223333444455556666 
											expiring: testObjectsFactory today 
											for: 'Gabriel Hayon' ]
		 ShouldRaiseErrorWithMessageText: CreditCard invalidCreditCardNumberLengthErrorDescription
	
	
	
	
	! !

!StoreTest methodsFor: 'testing' stamp: 'GDH 6/16/2021 22:54:42'!
test05CheckOutWithNegativeCreditCardNumberShouldRaiseAnError

	self assertCheckout: testObjectsFactory cartWithDefaultCatalogAndProducts 
		 WithCreditCardCreatedAs: [ CreditCard number: -1111222233334444 
											expiring: testObjectsFactory today 
											for: 'Matias Sandacz' ]
		 ShouldRaiseErrorWithMessageText: CreditCard creditCardNumberMustBePositiveErrorDescription
	
	
	
	
	! !

!StoreTest methodsFor: 'testing' stamp: 'GDH 6/16/2021 22:54:37'!
test06CheckOutWithNonIntegerCreditCardNumberShouldRaiseAnError

	self assertCheckout: testObjectsFactory cartWithDefaultCatalogAndProducts 
		 WithCreditCardCreatedAs: [ CreditCard number: 1.2 
											expiring: testObjectsFactory today
											for: 'Matias Sandacz' ]
		 ShouldRaiseErrorWithMessageText: CreditCard invalidCreditCardNumberTypeErrorDescription
	
	
	
	
	! !

!StoreTest methodsFor: 'testing' stamp: 'GDH 6/17/2021 01:07:37'!
test07CheckOutWithInvalidCreditCardNameShouldRaiseAnError

	self assertCheckout: testObjectsFactory cartWithDefaultCatalogAndProducts 
		 WithCreditCardCreatedAs: [ CreditCard number: 1111222233334444
									expiring: testObjectsFactory today
									for: 'Este nombre es muy largo para una tarjeta de credito' ]
		 ShouldRaiseErrorWithMessageText: CreditCard invalidCreditCardNameErrorDescription
	
	
	
	
	! !

!StoreTest methodsFor: 'testing' stamp: 'GDH 6/17/2021 01:07:45'!
test08CheckOutWithExpiredCardShouldRaiseAnError

	self assertCheckout: testObjectsFactory cartWithDefaultCatalogAndProducts 
		 WithCreditCard: testObjectsFactory creditCardValidButExpired
		 ShouldRaiseErrorWithMessageText: Cashier expiredCreditCardErrorMessage
	
	
	
	
	! !

!StoreTest methodsFor: 'testing' stamp: 'GDH 6/17/2021 01:07:52'!
test09SuccessfulCheckoutShouldRegisterSaleOnSalesBook
		
	| cart salesBook |
	
	cart := testObjectsFactory cartWithDefaultCatalog .
	cart add: '1'.
	cart add: '2'.
	
	salesBook := testObjectsFactory emptySalesbook .
	
	Cashier new 
		checkout: cart 
		withCard: testObjectsFactory creditCardValidAndNotExpired 
		on: testObjectsFactory today 
		registeringOn: salesBook processingWith: NoErrorMerchantProcessor new .
		
	self assert: ( salesBook includes: cart totalValue ).
	
	
	
	
	! !

!StoreTest methodsFor: 'testing' stamp: 'GDH 6/17/2021 01:07:58'!
test10CheckoutWithValidCartAndCreditCardShouldProcessSuccesfullyOnMerchantProcessor
	
	| salesBook cart |
		
	salesBook := testObjectsFactory emptySalesbook .
	cart  := testObjectsFactory cartWithDefaultCatalogAndProducts .
	
	Cashier new checkout: cart 
				withCard: testObjectsFactory creditCardValidAndNotExpired 
				on: testObjectsFactory today 
				registeringOn: salesBook 
				processingWith: NoErrorMerchantProcessor new.
	
	self assert: salesBook includes: cart totalValue 
	
	
	
	
	! !

!StoreTest methodsFor: 'testing' stamp: 'GDH 6/17/2021 01:08:03'!
test11CheckoutWithCreditCardErrorsOnProcessShouldRaiseAServerError
	
	| salesBook cart |
		
	salesBook := testObjectsFactory emptySalesbook .
	cart  := testObjectsFactory cartWithDefaultCatalogAndProducts .
		
	self should: [ Cashier new checkout: cart 
				withCard: testObjectsFactory creditCardValidAndNotExpired 
				on: testObjectsFactory today 
				registeringOn: salesBook 
				processingWith: ErrorMerchantProcessor new. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | self assert: (anError messageText beginsWith: MerchantProcessor formatServerErrorMessageText) ].
				
	self assert: salesBook isEmpty 
	
	
	
	
	! !

!StoreTest methodsFor: 'testing' stamp: 'GDH 6/17/2021 01:08:08'!
test12ProcessWithInvalidParametersShouldRaiseABadParametersError
	
	| salesBook cart |
		
	salesBook := testObjectsFactory emptySalesbook .
	cart  := testObjectsFactory cartWithDefaultCatalogAndProducts .
		
	self should: [ Cashier new checkout: cart 
				withCard: testObjectsFactory creditCardValidAndNotExpired 
				on: testObjectsFactory today 
				registeringOn: salesBook 
				processingWith: SimulatedBadParametersErrorMerchantProcessor new. ]
		raise: Error - MessageNotUnderstood
		withMessageText: MerchantProcessor badParamateresErrorMessageText.
				
	self assert: salesBook isEmpty 
	
	
	
	
	! !


!StoreTest methodsFor: 'setUp' stamp: 'GDH 6/17/2021 00:56:40'!
setUp
	
	testObjectsFactory := StoreTestObjectsFactory new.! !


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


!Cart methodsFor: 'assertions' stamp: 'MS 6/10/2021 20:31:50'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


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


!Cart methodsFor: 'value' stamp: 'GDH 6/16/2021 16:44:46'!
totalValue

	^(items collect: [ :anItem | catalog at: anItem ]) sum.! !

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

!Cashier methodsFor: 'checkout' stamp: 'GDH 6/17/2021 00:58:52'!
checkout: aCart withCard: aCreditCard on: purchaseGregorianMonthOfYear registeringOn: aSalesbook processingWith: aMerchantProcessor     
	
	(aCart isEmpty) ifTrue: [ ^self error: self class checkoutWithEmptyCartErrorMessage ].
	
	(aCreditCard isExpiredOn: purchaseGregorianMonthOfYear) ifTrue: [ ^self error: Cashier expiredCreditCardErrorMessage ].
	
	aMerchantProcessor process: aCart debitFrom: aCreditCard .
	
	aSalesbook add: aCart totalValue.
	
	^ aCart totalValue.
	
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'exceptions' stamp: 'MS 6/10/2021 19:53:45'!
checkoutWithEmptyCartErrorMessage
	
	^'Can not checkout with empty cart'.! !


!Cashier class methodsFor: 'as yet unclassified' stamp: 'MS 6/14/2021 19:31:10'!
expiredCreditCardErrorMessage

	^'Credit card is expired'.! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'creditCardNumber expirationDate userName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'instance creation' stamp: 'MS 6/14/2021 19:10:21'!
initializeNumber: aCreditCardNumber expiring: aGregorianMonthOfYear for: aUserName
	
	creditCardNumber := aCreditCardNumber.
	
	expirationDate := aGregorianMonthOfYear.
	
	userName := aUserName.
	! !


!CreditCard methodsFor: 'as yet unclassified' stamp: 'GDH 6/16/2021 16:59:58'!
isExpiredOn: aGregorianMonthOfYear

	^expirationDate < aGregorianMonthOfYear or: [ expirationDate = aGregorianMonthOfYear ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'GDH 6/17/2021 01:07:07'!
number: aCreditCardNumber expiring: anExpirationDate for: aUserName   

	self assertCreditCardNumberIsValid: aCreditCardNumber .
		
	self assertUserNameSizeIsValid: aUserName.
	
	^self new initializeNumber: aCreditCardNumber expiring: anExpirationDate for: aUserName.! !


!CreditCard class methodsFor: 'assertions' stamp: 'MS 6/13/2021 20:12:09'!
assertCreditCardNumberHas16Digits: aCreditCardNumber

	((aCreditCardNumber numberOfDigitsInBase: 10) isEqualTo: 16) ifFalse: [self error: CreditCard invalidCreditCardNumberLengthErrorDescription].
! !

!CreditCard class methodsFor: 'assertions' stamp: 'MS 6/13/2021 20:11:40'!
assertCreditCardNumberIsInteger: aCreditCardNumber

	(aCreditCardNumber isInteger) ifFalse: [self error: CreditCard invalidCreditCardNumberTypeErrorDescription].
	! !

!CreditCard class methodsFor: 'assertions' stamp: 'MS 6/13/2021 20:12:33'!
assertCreditCardNumberIsPositive: aCreditCardNumber

	(aCreditCardNumber positive) ifFalse: [self error: CreditCard creditCardNumberMustBePositiveErrorDescription ].
! !

!CreditCard class methodsFor: 'assertions' stamp: 'MS 6/13/2021 20:12:46'!
assertCreditCardNumberIsValid: aCreditCardNumber

	self assertCreditCardNumberIsInteger: aCreditCardNumber.
	
	self assertCreditCardNumberHas16Digits: aCreditCardNumber.
	
	self assertCreditCardNumberIsPositive: aCreditCardNumber.
! !

!CreditCard class methodsFor: 'assertions' stamp: 'MS 6/13/2021 21:08:32'!
assertUserNameSizeIsValid: aUserName

	(aUserName size > 30) ifTrue: [self error: self invalidCreditCardNameErrorDescription ].
	! !


!CreditCard class methodsFor: 'exceptions' stamp: 'MS 6/13/2021 20:09:41'!
creditCardNumberMustBePositiveErrorDescription
	
	^'Credit card number should be positive'.! !

!CreditCard class methodsFor: 'exceptions' stamp: 'MS 6/13/2021 20:56:25'!
invalidCreditCardNameErrorDescription
	^'Name should have less than 30 characters'.! !

!CreditCard class methodsFor: 'exceptions' stamp: 'MS 6/13/2021 20:09:15'!
invalidCreditCardNumberLengthErrorDescription
	
	^'Credit Card number should have 16 digits'! !

!CreditCard class methodsFor: 'exceptions' stamp: 'MS 6/13/2021 18:18:04'!
invalidCreditCardNumberTypeErrorDescription
	^'Credit card number must be an integer'.! !

!CreditCard class methodsFor: 'exceptions' stamp: 'MS 6/13/2021 20:22:53'!
invalidCreditCardYearErrorDescription
	'Credit card expiration year should have 4 digits'! !


!classDefinition: #MerchantProcessor category: 'TusLibros'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'processing' stamp: 'GDH 6/17/2021 00:58:52'!
process: aCart debitFrom: aCreditCard
	
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: 'TusLibros'!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'erorr messages' stamp: 'GDH 6/17/2021 00:51:30'!
badParamateresErrorMessageText
	
	^self formatServerErrorMessageText , 'los parámetros tienen mal formato.'! !

!MerchantProcessor class methodsFor: 'erorr messages' stamp: 'GDH 6/17/2021 00:31:18'!
formatServerErrorMessageText
	
	^'Error de server: '! !


!classDefinition: #ErrorMerchantProcessor category: 'TusLibros'!
MerchantProcessor subclass: #ErrorMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ErrorMerchantProcessor methodsFor: 'processing' stamp: 'GDH 6/17/2021 00:58:52'!
process: aCart debitFrom: aCreditCard
	
	^self error: self class formatServerErrorMessageText , ' error simulado. '! !


!classDefinition: #NoErrorMerchantProcessor category: 'TusLibros'!
MerchantProcessor subclass: #NoErrorMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!NoErrorMerchantProcessor methodsFor: 'processing' stamp: 'GDH 6/17/2021 00:58:52'!
process: aCart debitFrom: aCreditCard
	
	"Simula que salió bien"! !


!classDefinition: #SimulatedBadParametersErrorMerchantProcessor category: 'TusLibros'!
MerchantProcessor subclass: #SimulatedBadParametersErrorMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SimulatedBadParametersErrorMerchantProcessor methodsFor: 'processing' stamp: 'GDH 6/17/2021 00:58:52'!
process: aCart debitFrom: aCreditCard
	
	^self error: self class badParamateresErrorMessageText ! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'GDH 6/16/2021 16:31:31'!
cartWithDefaultCatalog
	
	^Cart acceptingItemsOf: self defaultCatalog .! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'GDH 6/16/2021 22:46:32'!
cartWithDefaultCatalogAndProducts
	
	| cart |
	
	cart  := Cart acceptingItemsOf: self defaultCatalog .
	cart add: '1'.
	cart add: '2'.
		
	^cart ! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'GDH 6/16/2021 16:26:07'!
creditCardValidAndNotExpired
	
	^CreditCard number: 1111222233334444 
				expiring: (GregorianMonthOfYear yearNumber: today yearNumber + 1 monthNumber: today monthIndex ) 
				for: 'Matias Hayon'.! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'GDH 6/16/2021 16:24:52'!
creditCardValidButExpired
	
	^CreditCard number: 1111222233334444
				expiring: (GregorianMonthOfYear yearNumber: today yearNumber monthNumber: today monthIndex - 1) 
				for: 'Matias Sandacz'.! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'GDH 6/16/2021 16:30:32'!
defaultCatalog
	
	| catalog |
	
	catalog := Dictionary new.
	catalog add: '1' -> 10.
	catalog add: '2' -> 20.
	
	^catalog ! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'GDH 6/16/2021 16:35:16'!
emptySalesbook
	
	^OrderedCollection new.! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'GDH 6/16/2021 16:16:23'!
initialize
	
	today := DateAndTime now.! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'GDH 6/16/2021 16:33:49'!
today
	
	^GregorianMonthOfYear yearNumber: today yearNumber  monthNumber: today monthIndex! !
