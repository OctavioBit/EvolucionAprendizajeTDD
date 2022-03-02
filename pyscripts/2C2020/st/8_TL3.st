!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'catalogue carrito'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'EMI 11/18/2020 18:20:23'!
test01NewCartIsEmpty
	self assert: (carrito isEmpty).! !

!CartTest methodsFor: 'tests' stamp: 'EMI 11/18/2020 18:16:25'!
test02CartCanAddOneBook
	carrito add: 'El principito'.
	self deny: (carrito isEmpty).
	self assert: (carrito productsAmount) equals: 1.! !

!CartTest methodsFor: 'tests' stamp: 'EMI 11/18/2020 18:16:25'!
test03CartCanAddMoreThanOneCopyOfABookAtOnce
	carrito add: 'El principito' amount: 2.
	self deny: (carrito isEmpty).
	self assert: (carrito productsAmount) equals: 2.
	self assert: (carrito copiesOf: 'El principito') equals: 2.! !

!CartTest methodsFor: 'tests' stamp: 'EMI 11/18/2020 18:16:57'!
test04CartCanAddMoreThanOneBook
	carrito add: 'El principito'.
	carrito add: 'El principote'.
	self deny: (carrito isEmpty).
	self assert: (carrito productsAmount) equals: 2.
	self assert: (carrito contains: 'El principito').
	self assert: (carrito contains: 'El principote').! !

!CartTest methodsFor: 'tests' stamp: 'EMI 11/18/2020 18:16:25'!
test05CartCanAddMoreThanOneBookWithDifferentAmountOfCopies
	carrito add: 'El principito'.
	carrito add: 'El principito' amount: 2.
	carrito add: 'El principote'.
	self deny: (carrito isEmpty).
	self assert: (carrito productsAmount) equals: 4.
	self assert: (carrito contains: 'El principito').
	self assert: (carrito contains: 'El principote').
	self assert: (carrito copiesOf: 'El principito') equals: 3.
	self assert: (carrito copiesOf: 'El principote') equals: 1.! !

!CartTest methodsFor: 'tests' stamp: 'EMI 11/18/2020 18:16:25'!
test06CartCanShowContents
	| expectedResult |
	
	carrito add: 'El principito'.
	carrito add: 'El principito' amount: 2.
	carrito add: 'El principote'.
	
	expectedResult _ Bag with: 'El principote'.
	expectedResult add: 'El principito' withOccurrences: 3.
	
	self assert: (carrito contents) equals: expectedResult.! !

!CartTest methodsFor: 'tests' stamp: 'EMI 11/24/2020 18:37:01'!
test07CartCannotAddBookMissingFromCatalogue
	self should: [carrito add: 'La celula'] 
	raise: Error 
	withExceptionDo: [:anError| 
		self assert: anError messageText equals: Cart itemNotFoundInCatalogueMessage.
		self assert: carrito isEmpty.
		].! !

!CartTest methodsFor: 'tests' stamp: 'EMI 11/24/2020 18:36:39'!
test08CartCannotAddInvalidAmountOfBooks
	self should: [carrito add: 'El principito' amount: 2.5] 
	raise: Error 
	withExceptionDo: [:anError| 
		self assert: anError messageText equals: Cart itemAmountMustBeIntegerMessage.
		self assert: carrito isEmpty.
		].
	self should: [carrito add: 'El principito' amount: -1] 
	raise: Error 
	withExceptionDo: [:anError| 
		self assert: anError messageText equals: Cart itemAmountMustBePositiveMessage.
		self assert: carrito isEmpty.
		].! !


!CartTest methodsFor: 'set up' stamp: 'EMI 11/26/2020 20:42:49'!
setUp
	catalogue _ Dictionary with: 'El principito'->1 with: 'El principote'->2.
	carrito _ Cart createUsingPriceList: catalogue.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'listaPrecios salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'setUp' stamp: 'EMI 11/26/2020 21:08:53'!
setUp
	listaPrecios _ Dictionary new.
	listaPrecios add: '1234'->1.
	salesBook _ OrderedCollection new.! !


!CashierTest methodsFor: 'tests' stamp: 'EMI 11/26/2020 21:09:02'!
test01CashierCannotCheckoutEmptyCart
	| cashier card mp cart |
	cart _ Cart createUsingPriceList: listaPrecios.
	mp _ AlwaysValidMerchantProcessorSimulator new.
	cashier _ Cashier withPriceList: listaPrecios withMerchantProcessor: mp.
	card _ CreditCard of: 'Pepito' withID: '1234' withExpirationDate: self nonExpiredCardDate.
	
	self should: [cashier checkout: cart usingCard: card onDate: GregorianMonthOfYear current usingSalesBook: salesBook] 
	raise: Error 
	withExceptionDo: [:anError | self assert: anError messageText equals: Cashier cannotCheckoutEmptyCartMessage].! !

!CashierTest methodsFor: 'tests' stamp: 'EMI 11/26/2020 21:13:37'!
test02CashierCanCheckoutCartWithOneBook
	| cashier mp card cart |
	card _ CreditCard of: 'Pepo' withID: '1111' withExpirationDate: self nonExpiredCardDate.
	cart _ Cart createUsingPriceList: listaPrecios.
	cart add: '1234'.
	mp _ AlwaysValidMerchantProcessorSimulator new.
	cashier _ Cashier withPriceList: listaPrecios withMerchantProcessor: mp.
	cashier checkout: cart usingCard: card onDate: GregorianMonthOfYear current usingSalesBook: salesBook.
	self deny: salesBook isEmpty.
	self assert: salesBook last equals: 1.! !

!CashierTest methodsFor: 'tests' stamp: 'EMI 11/26/2020 21:14:12'!
test03CashierCanCheckoutCartWithMoreThanOneBook
	| cashier mp card cart |
	card _ CreditCard of: 'Pepo' withID: '1111' withExpirationDate: self nonExpiredCardDate.

	cart _ Cart createUsingPriceList: listaPrecios.
	cart add: '1234' amount: 50.
	mp _ AlwaysValidMerchantProcessorSimulator new.
	cashier _ Cashier withPriceList: listaPrecios withMerchantProcessor: mp.
	cashier checkout: cart usingCard: card onDate: GregorianMonthOfYear current usingSalesBook: salesBook.
	self deny: salesBook isEmpty.
	self assert: salesBook last equals: 50.! !

!CashierTest methodsFor: 'tests' stamp: 'EMI 11/26/2020 21:14:41'!
test04CashierCannotCheckoutWithInvalidCard
	| cashier mp card cart |
	card _ CreditCard of: 'Tito' withID: '1112' withExpirationDate: self nonExpiredCardDate.

	cart _ Cart createUsingPriceList: listaPrecios.
	cart add: '1234' amount: 50.
	mp _ OnlyChecksIDsMerchantProcessorSimulator initialize: (Set with: '1111').
	cashier _ Cashier withPriceList: listaPrecios withMerchantProcessor: mp.
	
	self should: [cashier checkout: cart usingCard: card onDate: GregorianMonthOfYear current usingSalesBook: salesBook]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: mp class cannotDebitFromCreditCardWithInvalidIDMessage].
	
	self assert: salesBook isEmpty.! !

!CashierTest methodsFor: 'tests' stamp: 'EMI 11/26/2020 21:15:02'!
test05CashierCannotCheckoutWithExpiredCard
	| cashier mp card carrito |
	card _ CreditCard of: 'Tito' withID: '1112' withExpirationDate: self expiredCardDate.
	
	carrito _ Cart createUsingPriceList: listaPrecios.
	carrito add: '1234' amount: 50.
	
	mp _ AlwaysValidMerchantProcessorSimulator new.
	cashier _ Cashier withPriceList: listaPrecios withMerchantProcessor: mp.
	
	self should: [cashier checkout: carrito usingCard: card onDate: GregorianMonthOfYear current usingSalesBook: salesBook]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: Cashier cannotCheckoutWithExpiredCardMessage].
	self assert: salesBook isEmpty.! !

!CashierTest methodsFor: 'tests' stamp: 'EMI 11/26/2020 21:15:17'!
test06CashierCannotCheckoutWithIncorrectNameOnCard
	| cashier mp card carrito idsToNamesDictionary |
	card _ CreditCard of: 'NombreInvalido' withID: '1112' withExpirationDate: self nonExpiredCardDate.
	
	carrito _ Cart createUsingPriceList: listaPrecios.
	carrito add: '1234' amount: 50.
	
	idsToNamesDictionary _ Dictionary new.
	idsToNamesDictionary add:'1112'->'NombreValido'.
	mp _ OnlyChecksIDsAndNamesMerchantProcessorSimulator initialize: idsToNamesDictionary.
	cashier _ Cashier withPriceList: listaPrecios withMerchantProcessor: mp.
	
	self should: [cashier checkout: carrito usingCard: card onDate: GregorianMonthOfYear current usingSalesBook: salesBook]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: MerchantProcessorSimulator cannotDebitUsingCardWithIncorrectNameMessage].
	
	self assert: salesBook isEmpty.! !

!CashierTest methodsFor: 'tests' stamp: 'EMI 11/26/2020 21:15:26'!
test07CashierCannotCheckoutUsingCardWithoutFunds
	| cashier mp card cart idsToFundsDictionary |
	card _ CreditCard of: 'NombreValido' withID: '1112' withExpirationDate: self nonExpiredCardDate.
	
	cart _ Cart createUsingPriceList: listaPrecios.
	cart add: '1234' amount: 50.
	
	idsToFundsDictionary _ Dictionary new.
	idsToFundsDictionary add:'1112'->49.
	mp _ OnlyChecksIDsAndFundsMerchantProcessorSimulator initialize: idsToFundsDictionary.
	cashier _ Cashier withPriceList: listaPrecios withMerchantProcessor: mp.
	
	self should: [cashier checkout: cart usingCard: card onDate: GregorianMonthOfYear current usingSalesBook: salesBook]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: MerchantProcessorSimulator cannotDebitUsingCardWithInsufficientFundsMessage].
	self assert: salesBook isEmpty.! !


!CashierTest methodsFor: 'aux' stamp: 'EMI 11/26/2020 20:51:16'!
expiredCardDate
	^GregorianMonthOfYear current previous.! !

!CashierTest methodsFor: 'aux' stamp: 'EMI 11/26/2020 20:51:58'!
nonExpiredCardDate
	^GregorianMonthOfYear current next.! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'EMI 11/26/2020 20:58:55'!
test01CannotCreateCardWithInvalidIDFormat
	self should:[CreditCard of: 'Bob' withID: '' withExpirationDate: GregorianMonthOfYear current.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: CreditCard cannotCreateCardWithInvalidIDMessage].! !

!CreditCardTest methodsFor: 'tests' stamp: 'EMI 11/26/2020 20:59:02'!
test02CannotCreateCardWithInvalidName
	self should:[CreditCard of: '' withID: '1' withExpirationDate: GregorianMonthOfYear current.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: CreditCard cannotCreateCardWithInvalidNameMessage].! !

!CreditCardTest methodsFor: 'tests' stamp: 'EMI 11/26/2020 20:59:06'!
test03CannotCreateCardWithInvalidDateFormat
	self should:[CreditCard of: 'Pepo' withID: '1' withExpirationDate: Date today]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: CreditCard cannotCreateCardWithInvalidDateFormatMessage].! !


!classDefinition: #RESTInterfaceTest category: 'TusLibros'!
TestCase subclass: #RESTInterfaceTest
	instanceVariableNames: 'factory defaultClock interface'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RESTInterfaceTest methodsFor: 'tests - add to cart' stamp: 'EMI 12/2/2020 17:02:37'!
test04CanAddOneProductToValidCart
	| cartID |
	cartID _ interface createCart: factory validClientID withPassword: factory validClientPassword.
	interface addToCart: cartID productName: factory validProductName quantity: 1.
	
	self assert: (interface listCart: cartID) size equals: 1.! !

!RESTInterfaceTest methodsFor: 'tests - add to cart' stamp: 'EMI 12/2/2020 17:07:10'!
test05CanHaveMoreThanOneValidCart
	| cartID cartID2 |
	
	cartID _ interface createCart: factory validClientID withPassword: factory validClientPassword.
	interface addToCart: cartID productName: factory validProductName quantity: 1.
	
	cartID2 _ interface createCart: factory anotherValidClientID withPassword: factory validClientPassword.
	interface addToCart: cartID2 productName: factory anotherValidProductName quantity: 5.
	
	self assert: (interface listCart: cartID) size equals: 1.
	self assert: ((interface listCart: cartID) includes: factory validProductName).
	self assert: (interface listCart: cartID2) size equals: 5.
	self assert: ((interface listCart: cartID2) includes: factory anotherValidProductName).
! !

!RESTInterfaceTest methodsFor: 'tests - add to cart' stamp: 'EMI 12/2/2020 17:06:36'!
test06CannotAddProductToCartWithInvalidCartID
	interface createCart: factory validClientID withPassword: factory validClientPassword.
	
	self should: [interface addToCart: factory invalidCartID productName: factory validProductName quantity: 1.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: RESTInterface cannotAddProductToCartWithInvalidCartIDMessage].! !

!RESTInterfaceTest methodsFor: 'tests - add to cart' stamp: 'EMI 12/2/2020 17:05:20'!
test11CannotAddProductToExpiredCart
	| cartID |
	cartID _ interface createCart: factory validClientID withPassword: factory validClientPassword.
	
	defaultClock foward30Minutes.
	
	self should: [interface addToCart: cartID productName: factory validProductName quantity: 1.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: RESTInterface cannotUseAnExpiredCartIDMessage].
	
	self should: [interface addToCart: cartID productName: factory validProductName quantity: 1.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: RESTInterface cannotAddProductToCartWithInvalidCartIDMessage].
	! !


!RESTInterfaceTest methodsFor: 'tests - timer reset' stamp: 'EMI 12/2/2020 17:05:53'!
test14UsingCartResetsClockExpiration
	| cartID |
	cartID _ interface createCart: factory validClientID withPassword: factory validClientPassword.

	defaultClock fowardMinutes: 15.
	
	interface addToCart: cartID productName: factory validProductName quantity: 1.
	
	defaultClock fowardMinutes: 15.
	
	self deny: (interface listCart: cartID) isEmpty.

	! !


!RESTInterfaceTest methodsFor: 'tests - create cart' stamp: 'EMI 12/2/2020 17:01:38'!
test01CanCreateEmptyCartUsingValidIDAndPassword
	| cartID |	
	cartID _ interface createCart: factory validClientID withPassword: factory validClientPassword.
	self assert: (interface listCart: cartID) isEmpty.! !

!RESTInterfaceTest methodsFor: 'tests - create cart' stamp: 'EMI 12/2/2020 17:01:53'!
test02CannotCreateCartUsingInvalidIDOrPassword
	self should: [interface createCart: factory invalidClientID withPassword: factory validClientPassword.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: AuthenticatorSimulator cannotOperateUsingInvalidClientIDMessage].
	
	self should: [interface createCart: factory validClientID withPassword: factory invalidClientPassword.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: AuthenticatorSimulator cannotOperateUsingInvalidPasswordMessage].
	! !


!RESTInterfaceTest methodsFor: 'tests - list purchases' stamp: 'EMI 12/2/2020 17:04:50'!
test09CanListPurchasesMadeBValidUser
	| cartID result |
	
	cartID _ interface createCart: factory validClientID withPassword: factory validClientPassword.
	
	interface addToCart: cartID productName: factory anotherValidProductName quantity: 1.

	interface checkout: cartID withCardNumber: factory validCardNumber withCardExpDate: factory validCardDate withCardOwnerName: factory validCardOwnerName.
	
	result _ interface listPurchases: factory validClientID withPassword: factory validClientPassword.
	
	self deny: result isEmpty.

	! !

!RESTInterfaceTest methodsFor: 'tests - list purchases' stamp: 'EMI 12/2/2020 17:05:09'!
test10CannotListPurchasesUsingInvalidClientIDOrPassword
	| cartID |
	cartID _ interface createCart: factory validClientID withPassword: factory validClientPassword.
	
	interface addToCart: cartID productName: factory anotherValidProductName quantity: 1.

	interface checkout: cartID withCardNumber: factory validCardNumber withCardExpDate: factory validCardDate withCardOwnerName: factory validCardOwnerName.
	
	self should: [interface listPurchases: factory invalidClientID withPassword: factory validClientPassword.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: AuthenticatorSimulator cannotOperateUsingInvalidClientIDMessage].
	
	self should: [interface listPurchases: factory validClientID withPassword: factory invalidClientPassword.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: AuthenticatorSimulator cannotOperateUsingInvalidPasswordMessage].


	! !


!RESTInterfaceTest methodsFor: 'tests - checkout' stamp: 'EMI 12/2/2020 17:04:18'!
test07CanCheckoutProductsOfAValidCart
	| cartID |
	cartID _ interface createCart: factory validClientID withPassword: factory validClientPassword.
	
	interface addToCart: cartID productName: factory anotherValidProductName quantity: 1.
	
	interface checkout: cartID withCardNumber: factory validCardNumber withCardExpDate: factory validCardDate withCardOwnerName: factory validCardOwnerName.

	self should: [interface listCart: cartID]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: RESTInterface cannotListCartWithInvalidCartIDMessage].
	! !

!RESTInterfaceTest methodsFor: 'tests - checkout' stamp: 'EMI 12/2/2020 17:06:54'!
test08CannotCheckoutProductsOfAnInvalidCart
	| cartID |
	cartID _ interface createCart: factory validClientID withPassword: factory validClientPassword.
	
	interface addToCart: cartID productName: factory anotherValidProductName quantity: 1.

	self should: [interface checkout: factory invalidCartID withCardNumber: factory validCardNumber withCardExpDate: factory validCardDate withCardOwnerName: factory validCardOwnerName.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: RESTInterface cannotCheckoutCartWithInvalidCartIDMessage].
	! !

!RESTInterfaceTest methodsFor: 'tests - checkout' stamp: 'EMI 12/2/2020 17:05:36'!
test12CannotCheckoutAnExpiredCart
	| cartID |
	cartID _ interface createCart: factory validClientID withPassword: factory validClientPassword.
	interface addToCart: cartID productName: factory validProductName quantity: 1.
	
	defaultClock foward30Minutes.
	
	self should: [interface checkout: cartID withCardNumber: factory validCardNumber withCardExpDate: factory validCardDate withCardOwnerName: factory validCardOwnerName]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: RESTInterface cannotUseAnExpiredCartIDMessage].
	
	self should: [interface addToCart: cartID productName: factory validProductName quantity: 1.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: RESTInterface cannotAddProductToCartWithInvalidCartIDMessage].
	! !

!RESTInterfaceTest methodsFor: 'tests - checkout' stamp: 'EMI 12/2/2020 22:14:41'!
test15DifferentCheckoutsAreMadeByDifferentTransactions
	| cartID transactionID1 transactionID2 |
	cartID _ interface createCart: factory validClientID withPassword: factory validClientPassword.
	
	interface addToCart: cartID productName: factory anotherValidProductName quantity: 1.
	
	transactionID1 _ interface checkout: cartID withCardNumber: factory validCardNumber withCardExpDate: factory validCardDate withCardOwnerName: factory validCardOwnerName.
	
	cartID _ interface createCart: factory validClientID withPassword: factory validClientPassword.
	
	interface addToCart: cartID productName: factory anotherValidProductName quantity: 1.
	
	transactionID2 _ interface checkout: cartID withCardNumber: factory validCardNumber withCardExpDate: factory validCardDate withCardOwnerName: factory validCardOwnerName.

	self deny: (transactionID1 = transactionID2).
	! !


!RESTInterfaceTest methodsFor: 'tests - list cart' stamp: 'EMI 12/2/2020 17:02:21'!
test03CannotListCartUsingInvalidCartID
	interface createCart: factory validClientID withPassword: factory validClientPassword.
	self should: [interface listCart: '2']
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: interface class cannotListCartWithInvalidCartIDMessage].
	! !

!RESTInterfaceTest methodsFor: 'tests - list cart' stamp: 'EMI 12/2/2020 17:05:45'!
test13CannotListAnExpiredCart
	| cartID |
	cartID _ interface createCart: factory validClientID withPassword: factory validClientPassword.
	interface addToCart: cartID productName: factory validProductName quantity: 1.
	
	defaultClock foward30Minutes.
	
	self should: [interface listCart: cartID]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: RESTInterface cannotUseAnExpiredCartIDMessage].
	
	self should: [interface addToCart: cartID productName: factory validProductName quantity: 1.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: RESTInterface cannotAddProductToCartWithInvalidCartIDMessage].
	! !


!RESTInterfaceTest methodsFor: 'setup' stamp: 'EMI 12/2/2020 22:17:41'!
setUp
	factory _ TestObjectsFactory new.
	defaultClock _ factory defaultClock.
	interface _ RESTInterface withAuthenticator: factory defaultAuthenticator withMarket: factory defaultMarket withClock: defaultClock.! !


!classDefinition: #AuthenticatorSimulator category: 'TusLibros'!
Object subclass: #AuthenticatorSimulator
	instanceVariableNames: 'validIdentities'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!AuthenticatorSimulator methodsFor: 'initialization' stamp: 'EMI 12/1/2020 20:46:25'!
initializeWithUsers: aUsersDictionary 
	validIdentities _ aUsersDictionary.! !


!AuthenticatorSimulator methodsFor: 'testing' stamp: 'EMI 12/2/2020 16:37:37'!
checkUser: aClientID withPassword: aPassword
	| password |
	password _ validIdentities at: aClientID ifAbsent:[^Error signal: self class cannotOperateUsingInvalidClientIDMessage].
	(password = aPassword ) ifFalse: [^Error signal: self class cannotOperateUsingInvalidPasswordMessage.].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AuthenticatorSimulator class' category: 'TusLibros'!
AuthenticatorSimulator class
	instanceVariableNames: ''!

!AuthenticatorSimulator class methodsFor: 'instance creation' stamp: 'EMI 12/1/2020 20:45:29'!
withUsers: aUsersDictionary 
	^self new initializeWithUsers: aUsersDictionary. ! !


!AuthenticatorSimulator class methodsFor: 'error messages' stamp: 'EMI 12/2/2020 16:37:25'!
cannotOperateUsingInvalidClientIDMessage
	^'Cannot operate using invalid Client ID'.! !

!AuthenticatorSimulator class methodsFor: 'error messages' stamp: 'EMI 12/2/2020 16:37:37'!
cannotOperateUsingInvalidPasswordMessage
	^'Cannot operate using invalid password'.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'items amount priceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'testing' stamp: 'EMI 11/24/2020 18:34:27'!
contains: anItem 
	^items includes: anItem.! !

!Cart methodsFor: 'testing' stamp: 'EMI 11/16/2020 19:09:19'!
isEmpty
	^amount = 0.! !

!Cart methodsFor: 'testing' stamp: 'EMI 11/16/2020 19:09:25'!
productsAmount
	^amount.! !


!Cart methodsFor: 'initialization' stamp: 'EMI 11/26/2020 20:37:42'!
initialize: aPriceList
	amount _ 0.
	items _ Bag new.
	priceList _ aPriceList.! !


!Cart methodsFor: 'adding' stamp: 'EMI 11/24/2020 18:34:49'!
add: anItem
	self add: anItem amount: 1.
	
	! !

!Cart methodsFor: 'adding' stamp: 'EMI 11/24/2020 18:37:01'!
add: anItem amount: aNumberOfItems 
	(self checkIfItemIsInCatalogue: anItem) ifFalse: [^Error signal: self class itemNotFoundInCatalogueMessage.].
	(aNumberOfItems isInteger) ifFalse: [^Error signal: self class itemAmountMustBeIntegerMessage.].
	(aNumberOfItems > 0) ifFalse: [^Error signal: self class itemAmountMustBePositiveMessage].
	amount _ amount + aNumberOfItems.
	items add: anItem withOccurrences: aNumberOfItems.! !


!Cart methodsFor: 'private' stamp: 'EMI 11/26/2020 20:38:32'!
checkIfItemIsInCatalogue: anItem
	^priceList includesKey: anItem.! !


!Cart methodsFor: 'accessing' stamp: 'EMI 11/24/2020 18:34:18'!
contents
	^items copy.! !

!Cart methodsFor: 'accessing' stamp: 'EMI 11/26/2020 20:42:01'!
contentsTotalPrice
	| total |
	total _ 0.
	items do:[:anItem | total _ total + priceList at: anItem].
	^total.! !

!Cart methodsFor: 'accessing' stamp: 'EMI 11/24/2020 18:36:06'!
copiesOf: anItem
	^items occurrencesOf: anItem.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'EMI 11/26/2020 20:37:16'!
createUsingPriceList: aPriceList
	^self new initialize: aPriceList.! !


!Cart class methodsFor: 'error messages' stamp: 'EMI 11/24/2020 18:37:18'!
itemAmountMustBeIntegerMessage
	^'Item amount must be an integer'.! !

!Cart class methodsFor: 'error messages' stamp: 'EMI 11/24/2020 18:37:23'!
itemAmountMustBePositiveMessage
	^'Item amount must be a positive integer'.! !

!Cart class methodsFor: 'error messages' stamp: 'EMI 11/24/2020 18:37:28'!
itemNotFoundInCatalogueMessage
	^'Cannot find requested item in catalogue.'! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'priceListDictionary merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'operations' stamp: 'EMI 11/26/2020 21:11:53'!
checkout: aCart usingCard: aCard onDate: aDate usingSalesBook: aSalesBook  
	| bill  |
	(aCart isEmpty) ifTrue: [^Error signal: self class cannotCheckoutEmptyCartMessage].
	(aCard isExpiredOn: aDate) ifTrue:[^Error signal: self class cannotCheckoutWithExpiredCardMessage.].
	bill _ aCart contentsTotalPrice.
	merchantProcessor debit: bill from: aCard.
	aSalesBook addAll: aCart contents asOrderedCollection.
	aSalesBook add: bill.
	^bill.! !


!Cashier methodsFor: 'initialization' stamp: 'EMI 11/24/2020 18:23:53'!
initializeWithPriceList: aPriceListDictionary withMerchantProcessor: aMerchantProcessor 
	priceListDictionary := aPriceListDictionary.
	merchantProcessor := aMerchantProcessor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error messages' stamp: 'EMI 11/24/2020 17:33:30'!
cannotCheckoutEmptyCartMessage
	^'Cannot checkout empty cart.'.! !

!Cashier class methodsFor: 'error messages' stamp: 'EMI 11/19/2020 19:46:32'!
cannotCheckoutWithExpiredCardMessage
	^'Cannot checkout with expired card.'.! !

!Cashier class methodsFor: 'error messages' stamp: 'EMI 11/19/2020 19:28:23'!
cannotCheckoutWithInvalidCardMessage
	^'Cannot checkout with invalid card.'.! !


!Cashier class methodsFor: 'instance creation' stamp: 'EMI 11/24/2020 18:24:03'!
withPriceList: aPriceListDictionary withMerchantProcessor: aMerchantProcessor 
	^self new initializeWithPriceList: aPriceListDictionary withMerchantProcessor: aMerchantProcessor ! !


!classDefinition: #Clock category: 'TusLibros'!
Object subclass: #Clock
	instanceVariableNames: 'time'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'initialization' stamp: 'EMI 12/1/2020 20:09:23'!
initialize
	time _ [DateAndTime now].! !


!Clock methodsFor: 'clock operations' stamp: 'EMI 12/1/2020 20:09:53'!
foward30Minutes
	time _ [DateAndTime now + 30 minutes].! !

!Clock methodsFor: 'clock operations' stamp: 'EMI 12/2/2020 23:11:54'!
fowardMinutes: aMinutesAmount
	(aMinutesAmount > 0 and:[aMinutesAmount isInteger]) ifFalse: [^Error signal: self class minutesAmountMustBePositiveIntegerMessage.].
	time _ [DateAndTime now + aMinutesAmount minutes].! !

!Clock methodsFor: 'clock operations' stamp: 'EMI 12/1/2020 20:09:59'!
now
	^time value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Clock class' category: 'TusLibros'!
Clock class
	instanceVariableNames: ''!

!Clock class methodsFor: 'instance creation' stamp: 'EMI 12/1/2020 20:07:29'!
now
	^self new initialize.! !


!Clock class methodsFor: 'error messages' stamp: 'EMI 12/2/2020 22:44:16'!
minutesAmountMustBePositiveIntegerMessage
	^'Minutes amount must be a positive integer.'.! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'id expirationDate name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'accessing' stamp: 'EMI 11/23/2020 20:18:47'!
expiration
	^expirationDate.! !

!CreditCard methodsFor: 'accessing' stamp: 'EMI 11/23/2020 19:59:01'!
expirationMonth
	^expirationDate monthNumber.! !

!CreditCard methodsFor: 'accessing' stamp: 'EMI 11/23/2020 19:58:50'!
expirationYear
	^expirationDate yearNumber.! !

!CreditCard methodsFor: 'accessing' stamp: 'EMI 11/19/2020 19:55:17'!
id
	^id.! !

!CreditCard methodsFor: 'accessing' stamp: 'EMI 11/19/2020 19:55:57'!
ownerFullName
	^name.! !


!CreditCard methodsFor: 'testing' stamp: 'EMI 11/26/2020 20:47:19'!
isExpiredOn: aDate
	^expirationDate  < aDate.! !


!CreditCard methodsFor: 'initialize' stamp: 'EMI 11/26/2020 20:56:32'!
initializeWithID: anID withExpirationDate: aDate ofOwner: aName.
	(anID isEmpty) ifTrue: [^Error signal: self class cannotCreateCardWithInvalidIDMessage].
	(aName isEmpty) ifTrue: [^Error signal: self class cannotCreateCardWithInvalidNameMessage].
	(aDate isKindOf: GregorianMonthOfYear) ifFalse: [^Error signal: self class cannotCreateCardWithInvalidDateFormatMessage.].
	
	id _ anID.
	expirationDate _ aDate.
	name _ aName copyFrom: 1 to: (30 min: aName size).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'error messages' stamp: 'EMI 11/24/2020 17:32:49'!
cannotCreateCardWithInvalidDateFormatMessage
	^'Cannot create card with invalid date format. Use GregorianMonthOfYear.'! !

!CreditCard class methodsFor: 'error messages' stamp: 'EMI 11/24/2020 17:33:00'!
cannotCreateCardWithInvalidIDMessage
	^'Cannot create card with invalid ID, must be a positive integer'.! !

!CreditCard class methodsFor: 'error messages' stamp: 'EMI 11/24/2020 17:33:12'!
cannotCreateCardWithInvalidNameMessage
	^'Cannot create card with invalid name. Must not be empty or exceed 30 characters.'.! !


!CreditCard class methodsFor: 'instance creation' stamp: 'EMI 11/19/2020 19:57:48'!
of: aName withID: anID withExpirationDate: aDate
	^self new initializeWithID: anID withExpirationDate: aDate ofOwner: aName. ! !


!classDefinition: #Market category: 'TusLibros'!
Object subclass: #Market
	instanceVariableNames: 'priceList merchantProcessor cashier carts currentCartID usedCartIDs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Market methodsFor: 'initialization' stamp: 'EMI 12/2/2020 23:09:08'!
initializeWith: aPriceList withMerchantProcessor: aMerchantProcessor
	priceList _ aPriceList.
	merchantProcessor _ aMerchantProcessor.
	cashier _ Cashier withPriceList: aPriceList withMerchantProcessor: aMerchantProcessor.
	currentCartID _ 1.
	carts _ Dictionary new.
	usedCartIDs _ OrderedCollection new.! !


!Market methodsFor: 'testing' stamp: 'EMI 12/2/2020 18:34:47'!
isCart: aCartID
	^carts includesKey: aCartID.! !

!Market methodsFor: 'testing' stamp: 'EMI 12/2/2020 22:18:41'!
priceOf: aProductName
	^priceList at: aProductName.! !


!Market methodsFor: 'private' stamp: 'EMI 12/2/2020 23:09:26'!
generateCartID
	| res |
	(usedCartIDs isEmpty) ifFalse: [^usedCartIDs removeFirst].
	res _ currentCartID.
	currentCartID _ currentCartID + 1.
	^res.! !


!Market methodsFor: 'cart managment' stamp: 'EMI 12/2/2020 18:46:44'!
addToCart: aCartID productName: aProductName quantity: aProductAmount
	| cart |
	cart _ carts at: aCartID.
	cart add: aProductName amount: aProductAmount.! !

!Market methodsFor: 'cart managment' stamp: 'EMI 12/3/2020 16:30:36'!
cartContents: aCartID
	(self isCart: aCartID) ifFalse:[^Error signal: self class cannotGetCartContentsWithInvalidCartIDMessage].
	^(carts at: aCartID) contents.! !

!Market methodsFor: 'cart managment' stamp: 'EMI 12/2/2020 18:25:37'!
checkoutCart: aCartID usingCard: aCard
	| cart salesBook |
	salesBook _ OrderedCollection new.
	cart _ carts at: aCartID.
	cashier checkout: cart usingCard: aCard onDate: (GregorianMonthOfYear current) usingSalesBook: salesBook.! !

!Market methodsFor: 'cart managment' stamp: 'EMI 12/2/2020 17:15:00'!
lendCart
	| cartID |
	cartID _ self generateCartID.
	carts add: cartID->(Cart createUsingPriceList: priceList).
	^cartID! !

!Market methodsFor: 'cart managment' stamp: 'EMI 12/2/2020 23:09:45'!
returnCart: aCartID
	usedCartIDs addLast: aCartID.
	carts removeKey: aCartID.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Market class' category: 'TusLibros'!
Market class
	instanceVariableNames: ''!

!Market class methodsFor: 'instance creation' stamp: 'EMI 12/1/2020 21:07:27'!
withPriceList: aPriceList withMerchantProcessor: aMerchantProcessor
	^self new initializeWith: aPriceList withMerchantProcessor: aMerchantProcessor.! !


!Market class methodsFor: 'error messages' stamp: 'EMI 12/3/2020 16:30:36'!
cannotGetCartContentsWithInvalidCartIDMessage
	^'Cannot get cart contents with invalid CartID'.! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'operations' stamp: 'EMI 11/23/2020 21:22:25'!
debit: anAmount from: aCreditCard
	^self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: 'TusLibros'!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'error messages' stamp: 'EMI 11/24/2020 17:34:19'!
cannotDebitFromCreditCardWithInvalidIDMessage
	^'Cannot debit from credit card with invalid ID.'! !

!MerchantProcessorSimulator class methodsFor: 'error messages' stamp: 'EMI 11/24/2020 17:34:30'!
cannotDebitUsingCardWithIncorrectNameMessage
	^'Cannot debit from credit card with incorrect name.'! !

!MerchantProcessorSimulator class methodsFor: 'error messages' stamp: 'EMI 11/24/2020 18:38:57'!
cannotDebitUsingCardWithInsufficientFundsMessage
	^'Cannot debit using card with insufficient funds.'.! !


!classDefinition: #AlwaysValidMerchantProcessorSimulator category: 'TusLibros'!
MerchantProcessorSimulator subclass: #AlwaysValidMerchantProcessorSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!AlwaysValidMerchantProcessorSimulator methodsFor: 'operations' stamp: 'EMI 11/23/2020 20:47:48'!
debit: anAmount from: aCreditCard
	^true.! !


!classDefinition: #OnlyChecksIDsAndFundsMerchantProcessorSimulator category: 'TusLibros'!
MerchantProcessorSimulator subclass: #OnlyChecksIDsAndFundsMerchantProcessorSimulator
	instanceVariableNames: 'registeredFundsForIDs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!OnlyChecksIDsAndFundsMerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'EMI 11/24/2020 18:38:57'!
debit: anAmount from: aCreditCard
	| funds |
	funds _ registeredFundsForIDs at: aCreditCard id ifAbsent:[^Error signal: self class cannotDebitFromCreditCardWithInvalidIDMessage.].
	(funds < anAmount) ifTrue: [^Error signal: self class cannotDebitUsingCardWithInsufficientFundsMessage.].
	^true.! !

!OnlyChecksIDsAndFundsMerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'EMI 11/24/2020 17:47:42'!
initialize: anIDToFundsDictionary
	registeredFundsForIDs _ anIDToFundsDictionary.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OnlyChecksIDsAndFundsMerchantProcessorSimulator class' category: 'TusLibros'!
OnlyChecksIDsAndFundsMerchantProcessorSimulator class
	instanceVariableNames: ''!

!OnlyChecksIDsAndFundsMerchantProcessorSimulator class methodsFor: 'as yet unclassified' stamp: 'EMI 11/24/2020 17:48:05'!
initialize: anIDToFundsDictionary
	^self new initialize: anIDToFundsDictionary.! !


!classDefinition: #OnlyChecksIDsAndNamesMerchantProcessorSimulator category: 'TusLibros'!
MerchantProcessorSimulator subclass: #OnlyChecksIDsAndNamesMerchantProcessorSimulator
	instanceVariableNames: 'registeredNamesForIDs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!OnlyChecksIDsAndNamesMerchantProcessorSimulator methodsFor: 'initialization' stamp: 'EMI 11/23/2020 21:28:46'!
initialize: anIDToNamesDictionary
	registeredNamesForIDs _ anIDToNamesDictionary.! !


!OnlyChecksIDsAndNamesMerchantProcessorSimulator methodsFor: 'operations' stamp: 'EMI 11/24/2020 17:34:30'!
debit: anAmount from: aCreditCard
	| validName |
	validName _ registeredNamesForIDs at: aCreditCard id ifAbsent:[^Error signal: self class cannotDebitFromCreditCardWithInvalidIDMessage.].
	(validName = aCreditCard ownerFullName) ifFalse: [^Error signal: self class cannotDebitUsingCardWithIncorrectNameMessage.].
	^true.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OnlyChecksIDsAndNamesMerchantProcessorSimulator class' category: 'TusLibros'!
OnlyChecksIDsAndNamesMerchantProcessorSimulator class
	instanceVariableNames: ''!

!OnlyChecksIDsAndNamesMerchantProcessorSimulator class methodsFor: 'instance creation' stamp: 'EMI 11/23/2020 21:28:35'!
initialize: anIDToNamesDictionary
	^self new initialize: anIDToNamesDictionary.! !


!classDefinition: #OnlyChecksIDsMerchantProcessorSimulator category: 'TusLibros'!
MerchantProcessorSimulator subclass: #OnlyChecksIDsMerchantProcessorSimulator
	instanceVariableNames: 'validIDs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!OnlyChecksIDsMerchantProcessorSimulator methodsFor: 'initialization' stamp: 'EMI 11/23/2020 20:57:26'!
initializeWith: aSetOfValidIDs
	validIDs _ aSetOfValidIDs.! !


!OnlyChecksIDsMerchantProcessorSimulator methodsFor: 'operations' stamp: 'EMI 11/24/2020 17:34:19'!
debit: anAmount from: aCreditCard
	(validIDs includes: aCreditCard id) ifFalse: [^Error signal: self class cannotDebitFromCreditCardWithInvalidIDMessage].
	^true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OnlyChecksIDsMerchantProcessorSimulator class' category: 'TusLibros'!
OnlyChecksIDsMerchantProcessorSimulator class
	instanceVariableNames: ''!

!OnlyChecksIDsMerchantProcessorSimulator class methodsFor: 'instance creation' stamp: 'EMI 11/23/2020 20:56:54'!
initialize: aSetOfValidIDs
	^self new initializeWith: aSetOfValidIDs.! !


!classDefinition: #RESTInterface category: 'TusLibros'!
Object subclass: #RESTInterface
	instanceVariableNames: 'authenticator currentCartID purchasesByClient clientIDbyCartID clock cartSessions market lastTransactionID'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RESTInterface methodsFor: 'API' stamp: 'EMI 12/3/2020 16:17:15'!
addToCart: aCartID productName: aProductName quantity: aProductAmount
	(market isCart: aCartID) ifFalse: [^Error signal: self class cannotAddProductToCartWithInvalidCartIDMessage.].
	
	self checkHasCartExpired: aCartID.
	self updateCartSession: aCartID.
	
	market addToCart: aCartID productName: aProductName quantity: aProductAmount.! !

!RESTInterface methodsFor: 'API' stamp: 'EMI 12/3/2020 16:28:40'!
checkout: aCartID withCardNumber: aCardNumber withCardExpDate: aCardDate withCardOwnerName: aCardOwnerName
	| card clientID|
	
	(market isCart: aCartID) ifFalse: [^Error signal: self class cannotCheckoutCartWithInvalidCartIDMessage.].
	self checkHasCartExpired: aCartID.
	
	card _ CreditCard of: aCardOwnerName withID: aCardNumber withExpirationDate: aCardDate.
	market checkoutCart: aCartID usingCard: card.
	
	clientID _ self clientUsingCart: aCartID.
	self registePurchaseMadeBy: clientID of: aCartID.
	
	self endCartSession: aCartID.
	self fromClientTakeCart: aCartID.
	market returnCart: aCartID.
	
	^self nextTransactionID.! !

!RESTInterface methodsFor: 'API' stamp: 'EMI 12/3/2020 16:32:33'!
createCart: anID withPassword: aPassword
	| cartID |
	authenticator checkUser: anID withPassword: aPassword.
	
	cartID _ market lendCart.

	self giveCart: cartID to: anID.
	
	(self hasClientMadeAPurchase: anID) ifFalse: [self clientHasNoPurchases: anID].
	
	self beginCartSession: cartID.
	
	^cartID.! !

!RESTInterface methodsFor: 'API' stamp: 'EMI 12/3/2020 16:17:27'!
listCart: aCartID
	(market isCart: aCartID) ifFalse: [^Error signal: self class cannotListCartWithInvalidCartIDMessage].
	
	self checkHasCartExpired: aCartID.
	self updateCartSession: aCartID.
	
	^(market cartContents: aCartID).! !

!RESTInterface methodsFor: 'API' stamp: 'EMI 12/3/2020 16:22:31'!
listPurchases: aClientID withPassword: aPassword
	| purchases bill products result|
	authenticator checkUser: aClientID withPassword: aPassword.
	
	result _ OrderedCollection new.
	purchases _ purchasesByClient at: aClientID ifAbsent:[result add: 0.^result].
	
	bill _ 0.
	purchases do: [:anItem | bill _ bill + (market priceOf: anItem)].
	
	
	products _ purchases asSet.
	products do:[:aProduct | result add: aProduct. 
					     result add: (purchases occurrencesOf: aProduct)].
	result add: bill.
	^result
	! !


!RESTInterface methodsFor: 'private' stamp: 'EMI 12/3/2020 16:33:27'!
beginCartSession: cartID

	^ cartSessions add: (cartID -> (clock now))! !

!RESTInterface methodsFor: 'private' stamp: 'EMI 12/3/2020 16:33:27'!
checkHasCartExpired: aCartID
	| lastUsed |
	lastUsed _ cartSessions at: aCartID.
	(clock now > (lastUsed + 30 minutes)) ifTrue: [
		cartSessions removeKey: aCartID.
		market returnCart: aCartID.
		clientIDbyCartID removeKey: aCartID.
		^Error signal: self class cannotUseAnExpiredCartIDMessage.
	].! !

!RESTInterface methodsFor: 'private' stamp: 'EMI 12/3/2020 16:32:33'!
clientHasNoPurchases: anID

	^ purchasesByClient add: anID->(Bag new)! !

!RESTInterface methodsFor: 'private' stamp: 'EMI 12/3/2020 16:20:57'!
clientUsingCart: aCartID

	^ clientIDbyCartID at: aCartID! !

!RESTInterface methodsFor: 'private' stamp: 'EMI 12/3/2020 16:33:27'!
endCartSession: aCartID

	^ cartSessions removeKey: aCartID! !

!RESTInterface methodsFor: 'private' stamp: 'EMI 12/3/2020 16:21:49'!
fromClientTakeCart: aCartID

	^ clientIDbyCartID removeKey: aCartID! !

!RESTInterface methodsFor: 'private' stamp: 'EMI 12/3/2020 16:29:42'!
giveCart: cartID to: anID

	^ clientIDbyCartID add: cartID->anID! !

!RESTInterface methodsFor: 'private' stamp: 'EMI 12/3/2020 16:23:57'!
hasClientMadeAPurchase: anID

	^ purchasesByClient includesKey: anID! !

!RESTInterface methodsFor: 'private' stamp: 'EMI 12/2/2020 22:11:55'!
nextTransactionID
	| transactionID |
	transactionID _ lastTransactionID.
	lastTransactionID _ lastTransactionID + 1.
	^transactionID.! !

!RESTInterface methodsFor: 'private' stamp: 'EMI 12/3/2020 16:28:17'!
registePurchaseMadeBy: aClientID of: aCartID
	(purchasesByClient at: aClientID) addAll: (market cartContents: aCartID).! !

!RESTInterface methodsFor: 'private' stamp: 'EMI 12/3/2020 16:33:27'!
updateCartSession: aCartID

	^ cartSessions at: aCartID put: clock now! !


!RESTInterface methodsFor: 'initialization' stamp: 'EMI 12/3/2020 16:33:27'!
initializeWithAuthenticator: anAuthenticator withMarket: aMarket withClock: aClock    
	authenticator _ anAuthenticator.
	purchasesByClient _ Dictionary new.
	clientIDbyCartID _ Dictionary new.
	cartSessions _ Dictionary new.
	clock _ aClock.
	market _ aMarket.
	lastTransactionID _ 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RESTInterface class' category: 'TusLibros'!
RESTInterface class
	instanceVariableNames: ''!

!RESTInterface class methodsFor: 'error messages' stamp: 'EMI 12/2/2020 16:39:03'!
cannotAddProductToCartWithInvalidCartIDMessage
	^'Cannot add product to cart with invalid CartID'.! !

!RESTInterface class methodsFor: 'error messages' stamp: 'EMI 12/2/2020 16:39:16'!
cannotCheckoutCartWithInvalidCartIDMessage
	^'Cannot checkout cart with invalid cartID'.! !

!RESTInterface class methodsFor: 'error messages' stamp: 'EMI 12/2/2020 16:39:25'!
cannotCreateCartWithInvalidIDMessage
	^'Cannot create cart with invalid ID'.! !

!RESTInterface class methodsFor: 'error messages' stamp: 'EMI 12/2/2020 16:39:37'!
cannotCreateCartWithInvalidPasswordMessage
	^'Cannot create cart with invalid password'.! !

!RESTInterface class methodsFor: 'error messages' stamp: 'EMI 12/2/2020 16:39:49'!
cannotListCartWithInvalidCartIDMessage
	^'Cannot list cart using invalid cart ID'.! !

!RESTInterface class methodsFor: 'error messages' stamp: 'EMI 12/2/2020 16:39:57'!
cannotListPurchasesUsingInvalidIDMessage
	^'Cannot ListPurchases using invalid ID'.! !

!RESTInterface class methodsFor: 'error messages' stamp: 'EMI 12/2/2020 16:40:05'!
cannotListPurchasesUsingInvalidPasswordMessage
	^'Cannot ListPurchases using invalid password'.! !

!RESTInterface class methodsFor: 'error messages' stamp: 'EMI 12/2/2020 16:40:17'!
cannotUseAnExpiredCartIDMessage
	^'Cannot use an expired cart ID.'.! !


!RESTInterface class methodsFor: 'instance creation' stamp: 'EMI 12/2/2020 22:15:28'!
withAuthenticator: anAuthenticator withMarket: aMarket withClock: aClock    
	^self new initializeWithAuthenticator: anAuthenticator withMarket: aMarket withClock: aClock ! !


!classDefinition: #TestObjectsFactory category: 'TusLibros'!
Object subclass: #TestObjectsFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestObjectsFactory methodsFor: 'object creation' stamp: 'EMI 12/2/2020 16:43:11'!
anotherValidClientID
	^'2'.! !

!TestObjectsFactory methodsFor: 'object creation' stamp: 'EMI 12/2/2020 22:20:20'!
anotherValidProductName
	^'El Principito'.! !

!TestObjectsFactory methodsFor: 'object creation' stamp: 'EMI 12/2/2020 16:43:38'!
defaultAuthenticator
	| validUsers |
	validUsers _ Dictionary with: self validClientID -> self validClientPassword with: self anotherValidClientID -> self validClientPassword.
	^AuthenticatorSimulator withUsers: validUsers.! !

!TestObjectsFactory methodsFor: 'object creation' stamp: 'EMI 12/2/2020 16:43:52'!
defaultCashier
	^Cashier withPriceList: self defaultPriceList withMerchantProcessor: AlwaysValidMerchantProcessorSimulator new.! !

!TestObjectsFactory methodsFor: 'object creation' stamp: 'EMI 12/2/2020 16:44:02'!
defaultClock
	^Clock now.! !

!TestObjectsFactory methodsFor: 'object creation' stamp: 'EMI 12/2/2020 22:17:00'!
defaultMarket
	^Market withPriceList: self defaultPriceList withMerchantProcessor: AlwaysValidMerchantProcessorSimulator new.! !

!TestObjectsFactory methodsFor: 'object creation' stamp: 'EMI 12/2/2020 22:21:27'!
defaultPriceList
	^Dictionary with: (self validProductName) -> 50 with: (self anotherValidProductName) -> 100.! !

!TestObjectsFactory methodsFor: 'object creation' stamp: 'EMI 12/2/2020 17:06:13'!
invalidCartID
	^Object new.! !

!TestObjectsFactory methodsFor: 'object creation' stamp: 'EMI 12/2/2020 16:44:23'!
invalidClientID
	^Object new.! !

!TestObjectsFactory methodsFor: 'object creation' stamp: 'EMI 12/2/2020 16:44:33'!
invalidClientPassword
	^Object new.! !

!TestObjectsFactory methodsFor: 'object creation' stamp: 'EMI 12/2/2020 18:14:47'!
validCardDate
	^(GregorianMonthOfYear current) next.
	! !

!TestObjectsFactory methodsFor: 'object creation' stamp: 'EMI 12/2/2020 16:44:50'!
validCardNumber
	^'123456789'! !

!TestObjectsFactory methodsFor: 'object creation' stamp: 'EMI 12/2/2020 16:45:04'!
validCardOwnerName
	^'El Principe'.! !

!TestObjectsFactory methodsFor: 'object creation' stamp: 'EMI 12/2/2020 16:45:14'!
validClientID
	^'1'.! !

!TestObjectsFactory methodsFor: 'object creation' stamp: 'EMI 12/2/2020 16:49:49'!
validClientPassword
	^'1234'.! !

!TestObjectsFactory methodsFor: 'object creation' stamp: 'EMI 12/2/2020 16:50:00'!
validProductName
	^'El Principote'.! !
