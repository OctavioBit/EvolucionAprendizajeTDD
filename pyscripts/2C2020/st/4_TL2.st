!classDefinition: #CajeroTest category: 'TusLibros'!
TestCase subclass: #CajeroTest
	instanceVariableNames: 'cashier cashier2 cart catalog cashierValidatedCreditCard expiredCreditCard negativeNumberCreditCard noOwnerCreditCard emptyCart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CajeroTest methodsFor: 'tests' stamp: 'GR 11/24/2020 15:13:16'!
test01CantCheckOutAnEmptyCart
	
	cart := Carrito withCatalog: catalog.
	
	self
		should: [ cashier checkOutCart: cart withCreditCard: cashierValidatedCreditCard ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Cajero emptyCartError.! !

!CajeroTest methodsFor: 'tests' stamp: 'GR 11/24/2020 15:13:16'!
test02CanCheckOutCartWithOneElement

	cart := Carrito withCatalog: catalog.
	
	cart addToCart: #Libro1 withAmount: 1.

	self assert: 10 equals: (cashier checkOutCart: cart withCreditCard: cashierValidatedCreditCard)! !

!CajeroTest methodsFor: 'tests' stamp: 'GR 11/24/2020 15:13:16'!
test03CanCheckOutCartWithMoreThanOneElement
	
	self assert: 30 equals: (cashier checkOutCart: cart withCreditCard: cashierValidatedCreditCard)! !

!CajeroTest methodsFor: 'tests' stamp: 'GR 11/24/2020 15:05:09'!
test04CanNotCheckOutWithExpiredCreditCard
	
	self 
		should: [ cashier checkOutCart: cart withCreditCard: expiredCreditCard ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Cajero invalidCreditCard.
	
	
	
	! !

!CajeroTest methodsFor: 'tests' stamp: 'GR 11/24/2020 15:05:09'!
test05CanNotCheckOutACreditCardWithNoOwner
	
	self 
		should: [ cashier checkOutCart: cart withCreditCard: noOwnerCreditCard ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Cajero invalidCreditCard.
	
	
	
	! !

!CajeroTest methodsFor: 'tests' stamp: 'GR 11/24/2020 15:05:09'!
test06CanNotCheckOutWithNegativeCardNumber
	
	self 
		should: [ cashier checkOutCart: cart withCreditCard: negativeNumberCreditCard ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Cajero invalidCreditCard.
	
	
	
	! !

!CajeroTest methodsFor: 'tests' stamp: 'GR 11/24/2020 15:13:16'!
test07CanNotCheckoutIfMerchantProcessorDoesNotValidateCreditCard
	
	cashier := Cajero with: (MerchantProcesorSimulator with: [ :aCreditCard | false ]).
	
	self 
		should: [ cashier checkOutCart: cart withCreditCard: cashierValidatedCreditCard ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Cajero invalidCreditCard.
	
	
	
	! !


!CajeroTest methodsFor: 'setUp' stamp: 'GR 11/24/2020 15:13:16'!
setUp

	catalog := Catalogo with: (Dictionary with: #Libro1->10).
	
	cashier := Cajero with: (MerchantProcesorSimulator with: [ :aCreditCard | true]).
	
	cart := Carrito withCatalog: catalog.
	
	cart addToCart: #Libro1 withAmount: 3.

	cashierValidatedCreditCard := TarjetaDeCredito number: 4659540000978462 withExpiration: August, 2021 withOwner: 'Matias Morales'.
	
	expiredCreditCard := TarjetaDeCredito number: 4659540000978462 withExpiration: August, 2012 withOwner: 'Matias Morales'.
	
	negativeNumberCreditCard := TarjetaDeCredito number: -4659540000978462 withExpiration: August, 2021 withOwner: 'Matias Morales'.
	
	noOwnerCreditCard := TarjetaDeCredito number: 4659540000978462 withExpiration: August, 2021 withOwner: ''.! !


!classDefinition: #CarritoTest category: 'TusLibros'!
TestCase subclass: #CarritoTest
	instanceVariableNames: 'cart catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CarritoTest methodsFor: 'tests' stamp: 'GR 11/24/2020 15:30:05'!
test01CanCreateNewCartWithNoProducts

	self assert: 0 equals: cart productAmount.! !

!CarritoTest methodsFor: 'tests' stamp: 'GR 11/24/2020 15:30:05'!
test02CanAddAProductToCart

	cart addToCart: #Libro1 withAmount: 1.
	
	self assert: 1 equals: cart productAmount.
	self assert: (cart products includes: #Libro1)! !

!CarritoTest methodsFor: 'tests' stamp: 'GR 11/24/2020 15:30:05'!
test03CanAddAProductToCartMultipleTimes

	cart addToCart: #Libro1 withAmount: 3.
	
	self assert: 3 equals: cart productAmount.
	self assert: 3 equals: (cart products occurrencesOf: #Libro1)! !

!CarritoTest methodsFor: 'tests' stamp: 'GR 11/24/2020 15:30:05'!
test04AddAProductThatIsAlreadyInTheCart

	cart addToCart: #Libro1 withAmount: 3.
	cart addToCart: #Libro1 withAmount: 1.
	
	self assert: 4 equals: cart productAmount.
	self assert: 4 equals: (cart products occurrencesOf: #Libro1)! !

!CarritoTest methodsFor: 'tests' stamp: 'GR 11/24/2020 15:30:05'!
test05CanNotAddABookThatIsNotInTheCatalog

	cart addToCart: #Libro1 withAmount: 3.
	
	self
		should: [ cart addToCart: #Libro2 withAmount: 1. ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Carrito productNotInTheCatalog = anError messageText.
			self assert: 3 equals: cart productAmount.
			self assert: 0 equals: (cart products occurrencesOf: #Libro2) ].
	
	
	! !

!CarritoTest methodsFor: 'tests' stamp: 'GR 11/24/2020 15:30:05'!
test06EmptyCartListsNoItems

	self assert: Dictionary new equals: cart listCart
	
	
	! !

!CarritoTest methodsFor: 'tests' stamp: 'GR 11/24/2020 15:30:05'!
test07CartCanListEveryProductInIt

	| list |
	
	cart addToCart: #Libro1 withAmount: 3.
	
	list := Dictionary with: #Libro1->3.
	
	self assert: list equals: cart listCart
	
	
	! !

!CarritoTest methodsFor: 'tests' stamp: 'GR 11/24/2020 15:30:05'!
test08CanNotAddNegativeAmountOfProducts

	self 
		should: [ cart addToCart: #Libro1 withAmount: -2. ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Carrito invalidAmountOfProductsError 
	
	
	! !

!CarritoTest methodsFor: 'tests' stamp: 'GR 11/24/2020 15:30:05'!
test09CanNotAddCeroAmountOfProducts

	self 
		should: [ cart addToCart: #Libro1 withAmount: 0. ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Carrito invalidAmountOfProductsError.
	
	
	! !

!CarritoTest methodsFor: 'tests' stamp: 'GR 11/24/2020 15:30:05'!
test10CanNotAddNonIntegerAmountOfProducts

	self 
		should: [ cart addToCart: #Libro1 withAmount: 1.5. ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Carrito invalidAmountOfProductsError.! !


!CarritoTest methodsFor: 'setUp' stamp: 'GR 11/24/2020 15:30:26'!
setUp

	catalog := Catalogo with: (Dictionary with: #Libro1->10).
	
	cart := Carrito withCatalog: catalog.! !


!classDefinition: #CatalogoTest category: 'TusLibros'!
TestCase subclass: #CatalogoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CatalogoTest methodsFor: 'tests' stamp: 'GR 11/19/2020 20:25:03'!
test01CanNotCreateACatalogWithInvalidPriceOfAnyProduct

	self 
		should: [ Catalogo with: (Dictionary with: #Libro1->-1) ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Catalogo invalidProductPrice
	! !


!classDefinition: #Cajero category: 'TusLibros'!
Object subclass: #Cajero
	instanceVariableNames: 'catalog merchantProcesor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cajero methodsFor: 'operations' stamp: 'GR 11/24/2020 15:24:47'!
checkOutCart: aCarrito withCreditCard: aCreditCard  
	
	| totalPrice |
	
	self validateCart: aCarrito.
	
	self validateCreditCard: aCreditCard.
	
	totalPrice := aCarrito purchaseValue.
	
	( merchantProcesor processPurchase: totalPrice withCreditCard: aCreditCard ) ifFalse: [ self error: self class invalidCreditCard ].
	
	^ totalPrice
			! !


!Cajero methodsFor: 'private -- operations' stamp: 'GR 11/22/2020 17:19:11'!
validateCart: aCarrito

	^ (aCarrito isEmpty) ifTrue: [ self error: self class emptyCartError ]! !

!Cajero methodsFor: 'private -- operations' stamp: 'GR 11/24/2020 14:27:13'!
validateCreditCard: aCreditCard

	(aCreditCard number >= 0) ifFalse: [ self error: self class invalidCreditCard ].
	
	(aCreditCard expirationDate < GregorianMonthOfYear current) ifTrue: [ self error: self class invalidCreditCard ].
	
	(aCreditCard owner = '' ) ifTrue: [ self error: self class invalidCreditCard ]! !


!Cajero methodsFor: 'initialization' stamp: 'GR 11/24/2020 15:08:32'!
initializeWith: aMerchantProcesor 
	
	merchantProcesor := aMerchantProcesor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cajero class' category: 'TusLibros'!
Cajero class
	instanceVariableNames: ''!

!Cajero class methodsFor: 'error handling' stamp: 'GR 11/19/2020 19:19:43'!
emptyCartError
	
	^ 'You can not checkout an empty cart'! !

!Cajero class methodsFor: 'error handling' stamp: 'GR 11/22/2020 17:09:49'!
invalidCreditCard
	
	^ 'Your credit card is invalid'! !

!Cajero class methodsFor: 'error handling' stamp: 'GR 11/22/2020 18:35:36'!
priceOutOfBound
	
	^ 'You can not buy for that amount!!'! !


!Cajero class methodsFor: 'instance creation' stamp: 'GR 11/24/2020 15:08:21'!
with: aMerchantProcesor
	
	^self new initializeWith: aMerchantProcesor! !


!classDefinition: #Carrito category: 'TusLibros'!
Object subclass: #Carrito
	instanceVariableNames: 'products catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Carrito methodsFor: 'accessing' stamp: 'GR 11/19/2020 19:41:59'!
catalog
	
	^catalog! !

!Carrito methodsFor: 'accessing' stamp: 'GR 11/18/2020 16:07:04'!
listCart
	
	^ products contents! !

!Carrito methodsFor: 'accessing' stamp: 'GR 11/16/2020 19:43:44'!
productAmount
	
	^ products size.! !

!Carrito methodsFor: 'accessing' stamp: 'GR 11/16/2020 19:08:32'!
products
	
	^products! !


!Carrito methodsFor: 'initialization' stamp: 'GR 11/18/2020 14:40:31'!
initializeWithCatalog: aCatalog 
	
	products := Bag new.
	catalog := aCatalog.! !


!Carrito methodsFor: 'operations' stamp: 'GR 11/19/2020 19:05:58'!
addToCart: aProduct withAmount: aProductAmount 
	
	self validateAmount: aProductAmount.
	
	self validateProduct: aProduct.
	
	products add: aProduct withOccurrences: aProductAmount.
	
	! !

!Carrito methodsFor: 'operations' stamp: 'GR 11/24/2020 14:48:17'!
purchaseValue
	
	^ products 
		inject: 0 
		into: [ :total :aProduct | 
			total + (catalog valueOf: aProduct) ].! !


!Carrito methodsFor: 'testing' stamp: 'GR 11/19/2020 19:23:00'!
isEmpty
	
	^ products isEmpty.! !

!Carrito methodsFor: 'testing' stamp: 'GR 11/19/2020 19:05:32'!
validateAmount: aProductAmount

	(aProductAmount <= 0) ifTrue: [ self error: self class invalidAmountOfProductsError ].
	
	(aProductAmount isInteger ) ifFalse: [ self error: self class invalidAmountOfProductsError ]! !

!Carrito methodsFor: 'testing' stamp: 'GR 11/19/2020 20:07:15'!
validateProduct: aProduct

	^ (catalog includes: aProduct) ifFalse: [self error: self class productNotInTheCatalog ]! !


!Carrito methodsFor: 'as yet unclassified' stamp: 'GR 11/24/2020 14:40:16'!
totalValue
	self shouldBeImplemented.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Carrito class' category: 'TusLibros'!
Carrito class
	instanceVariableNames: ''!

!Carrito class methodsFor: 'instance creation' stamp: 'GR 11/18/2020 14:40:01'!
withCatalog: aCatalog 
	
	^self new initializeWithCatalog: aCatalog ! !


!Carrito class methodsFor: 'error handling' stamp: 'GR 11/19/2020 17:14:17'!
invalidAmountOfProductsError
	
	^ 'You are adding an invalid amount of products to the cart'! !

!Carrito class methodsFor: 'error handling' stamp: 'GR 11/18/2020 14:41:59'!
productNotInTheCatalog
	
	^ 'The book is not in the catalog'! !


!classDefinition: #Catalogo category: 'TusLibros'!
Object subclass: #Catalogo
	instanceVariableNames: 'items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Catalogo methodsFor: 'initialization' stamp: 'GR 11/19/2020 20:08:28'!
initializeWith: aDictionary 
	
	items := aDictionary.! !


!Catalogo methodsFor: 'accessing' stamp: 'GR 11/19/2020 20:08:00'!
includes: aProduct

	^ items includesKey: aProduct 
	! !

!Catalogo methodsFor: 'accessing' stamp: 'GR 11/19/2020 20:10:55'!
priceOf: aProduct

	^ items at: aProduct.
	! !

!Catalogo methodsFor: 'accessing' stamp: 'GR 11/24/2020 14:47:57'!
valueOf: aProduct
	
	^ items at: aProduct! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Catalogo class' category: 'TusLibros'!
Catalogo class
	instanceVariableNames: ''!

!Catalogo class methodsFor: 'instance creation' stamp: 'GR 11/19/2020 20:05:38'!
with: aDictionary 
	
	aDictionary do: [ :aValue | (aValue <= 0) ifTrue: [ self error: self invalidProductPrice ] ].
	
	^self new initializeWith: aDictionary ! !


!Catalogo class methodsFor: 'error handling' stamp: 'GR 11/19/2020 20:25:49'!
invalidProductPrice
	
	^ 'You are adding products with invalid prices'! !


!classDefinition: #MerchantProcesorSimulator category: 'TusLibros'!
Object subclass: #MerchantProcesorSimulator
	instanceVariableNames: 'validationCondition'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcesorSimulator methodsFor: 'initialization' stamp: 'GR 11/24/2020 15:08:01'!
initializeWith: aValidationCondition 
	
	validationCondition := aValidationCondition.! !


!MerchantProcesorSimulator methodsFor: 'operations' stamp: 'GR 11/24/2020 15:24:06'!
processPurchase: aTotalPrice withCreditCard: aCreditCard
	
	^ validationCondition value: aCreditCard! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcesorSimulator class' category: 'TusLibros'!
MerchantProcesorSimulator class
	instanceVariableNames: ''!

!MerchantProcesorSimulator class methodsFor: 'instance creation' stamp: 'GR 11/24/2020 15:07:49'!
with: aValidationCondition 
	
	^self new initializeWith: aValidationCondition ! !


!classDefinition: #TarjetaDeCredito category: 'TusLibros'!
Object subclass: #TarjetaDeCredito
	instanceVariableNames: 'number expiration owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TarjetaDeCredito methodsFor: 'initialization' stamp: 'GR 11/22/2020 16:53:06'!
initializeNumber: aCreditCardNumber withExpiration: anExpirationDate withOwner: aName 
	
	number := aCreditCardNumber.
	expiration := anExpirationDate.
	owner := aName.! !


!TarjetaDeCredito methodsFor: 'accessing' stamp: 'GR 11/22/2020 17:15:10'!
expirationDate
	
	^ expiration ! !

!TarjetaDeCredito methodsFor: 'accessing' stamp: 'GR 11/22/2020 17:13:10'!
number
	
	^number! !

!TarjetaDeCredito methodsFor: 'accessing' stamp: 'GR 11/22/2020 17:18:19'!
owner
	
	^owner! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TarjetaDeCredito class' category: 'TusLibros'!
TarjetaDeCredito class
	instanceVariableNames: ''!

!TarjetaDeCredito class methodsFor: 'instance creation' stamp: 'GR 11/22/2020 16:51:35'!
number: aSmallInteger withExpiration: aPoint withOwner: aString 
	
	^self new initializeNumber: aSmallInteger withExpiration: aPoint withOwner: aString ! !
