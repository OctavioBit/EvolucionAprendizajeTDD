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


!CartTest methodsFor: 'set up' stamp: 'EMI 11/18/2020 18:16:25'!
setUp
	catalogue _ Set with: 'El principito' with: 'El principote'.
	carrito _ Cart createUsingCatalogue: catalogue.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'listaPrecios catalogo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'setUp' stamp: 'EMI 11/24/2020 18:27:32'!
setUp
	listaPrecios _ Dictionary new.
	listaPrecios add: '1234'->1.
	catalogo _ listaPrecios keys.! !


!CashierTest methodsFor: 'tests' stamp: 'EMI 11/24/2020 18:27:57'!
test01CashierCannotCheckoutEmptyCart
	| cashier card mp cart |
	cart _ Cart createUsingCatalogue: catalogo.
	mp _ AlwaysValidMerchantProcessorSimulator new.
	cashier _ Cashier withPriceList: listaPrecios withMerchantProcessor: mp.
	card _ CreditCard of: 'Pepito' withID: 1234 withExpirationDate: GregorianMonthOfYear current.
	
	self should: [cashier checkout: cart usingCard: card.] 
	raise: Error 
	withExceptionDo: [:anError | self assert: anError messageText equals: Cashier cannotCheckoutEmptyCartMessage].! !

!CashierTest methodsFor: 'tests' stamp: 'EMI 11/24/2020 18:28:02'!
test02CashierCanCheckoutCartWithOneBook
	| cashier mp card cart |
	card _ CreditCard of: 'Pepo' withID: 1111 withExpirationDate: GregorianMonthOfYear current.
	cart _ Cart createUsingCatalogue: catalogo.
	cart add: '1234'.
	mp _ AlwaysValidMerchantProcessorSimulator new.
	cashier _ Cashier withPriceList: listaPrecios withMerchantProcessor: mp.
	
	self assert: (cashier checkout: cart usingCard: card) equals: 1.! !

!CashierTest methodsFor: 'tests' stamp: 'EMI 11/24/2020 18:28:07'!
test03CashierCanCheckoutCartWithMoreThanOneBook
	| cashier mp card cart |
	card _ CreditCard of: 'Pepo' withID: 1111 withExpirationDate: GregorianMonthOfYear current.

	cart _ Cart createUsingCatalogue: catalogo.
	cart add: '1234' amount: 50.
	mp _ AlwaysValidMerchantProcessorSimulator new.
	cashier _ Cashier withPriceList: listaPrecios withMerchantProcessor: mp.
	
	self assert: (cashier checkout: cart usingCard: card) equals: 50.! !

!CashierTest methodsFor: 'tests' stamp: 'EMI 11/24/2020 18:28:12'!
test04CashierCannotCheckoutWithInvalidCard
	| cashier mp card cart |
	card _ CreditCard of: 'Tito' withID: 1112 withExpirationDate: GregorianMonthOfYear current.

	cart _ Cart createUsingCatalogue: catalogo.
	cart add: '1234' amount: 50.
	mp _ OnlyChecksIDsMerchantProcessorSimulator initialize: (Set with: 1111).
	cashier _ Cashier withPriceList: listaPrecios withMerchantProcessor: mp.
	
	self should: [cashier checkout: cart usingCard: card]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: mp class cannotDebitFromCreditCardWithInvalidIDMessage].! !

!CashierTest methodsFor: 'tests' stamp: 'EMI 11/24/2020 18:28:17'!
test05CashierCannotCheckoutWithExpiredCard
	| cashier mp card carrito |
	card _ CreditCard of: 'Tito' withID: 1112 withExpirationDate: (GregorianMonthOfYear yearNumber: 2020 monthNumber: 1).
	
	carrito _ Cart createUsingCatalogue: catalogo.
	carrito add: '1234' amount: 50.
	
	mp _ AlwaysValidMerchantProcessorSimulator new.
	cashier _ Cashier withPriceList: listaPrecios withMerchantProcessor: mp.
	
	self should: [cashier checkout: carrito usingCard: card]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: Cashier cannotCheckoutWithExpiredCardMessage].! !

!CashierTest methodsFor: 'tests' stamp: 'EMI 11/24/2020 18:28:22'!
test06CashierCannotCheckoutWithIncorrectNameOnCard
	| cashier mp card carrito idsToNamesDictionary |
	card _ CreditCard of: 'NombreInvalido' withID: 1112 withExpirationDate: (GregorianMonthOfYear current).
	
	carrito _ Cart createUsingCatalogue: catalogo.
	carrito add: '1234' amount: 50.
	
	idsToNamesDictionary _ Dictionary new.
	idsToNamesDictionary add:1112->'NombreValido'.
	mp _ OnlyChecksIDsAndNamesMerchantProcessorSimulator initialize: idsToNamesDictionary.
	cashier _ Cashier withPriceList: listaPrecios withMerchantProcessor: mp.
	
	self should: [cashier checkout: carrito usingCard: card]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: MerchantProcessorSimulator cannotDebitUsingCardWithIncorrectNameMessage].! !

!CashierTest methodsFor: 'tests' stamp: 'EMI 11/24/2020 18:38:57'!
test07CashierCannotCheckoutUsingCardWithoutFunds
	| cashier mp card cart idsToFundsDictionary |
	card _ CreditCard of: 'NombreValido' withID: 1112 withExpirationDate: (GregorianMonthOfYear current).
	
	cart _ Cart createUsingCatalogue: catalogo.
	cart add: '1234' amount: 50.
	
	idsToFundsDictionary _ Dictionary new.
	idsToFundsDictionary add:1112->49.
	mp _ OnlyChecksIDsAndFundsMerchantProcessorSimulator initialize: idsToFundsDictionary.
	cashier _ Cashier withPriceList: listaPrecios withMerchantProcessor: mp.
	
	self should: [cashier checkout: cart usingCard: card]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: MerchantProcessorSimulator cannotDebitUsingCardWithInsufficientFundsMessage].! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'EMI 11/24/2020 17:36:00'!
test01CannotCreateCardWithInvalidIDFormat
	self should:[CreditCard of: 'Bob' withID: 1 negated withExpirationDate: GregorianMonthOfYear current.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: CreditCard cannotCreateCardWithInvalidIDMessage].
	
	self should:[CreditCard of: 'Bob' withID: 1.5 withExpirationDate: GregorianMonthOfYear current.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: CreditCard cannotCreateCardWithInvalidIDMessage].
	
	self should:[CreditCard of: 'Bob' withID: 0 withExpirationDate: GregorianMonthOfYear current.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: CreditCard cannotCreateCardWithInvalidIDMessage].! !

!CreditCardTest methodsFor: 'tests' stamp: 'EMI 11/24/2020 18:07:49'!
test02CannotCreateCardWithInvalidName
	self should:[CreditCard of: '' withID: 1 withExpirationDate: GregorianMonthOfYear current.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: CreditCard cannotCreateCardWithInvalidNameMessage].! !

!CreditCardTest methodsFor: 'tests' stamp: 'EMI 11/24/2020 17:36:17'!
test03CannotCreateCardWithInvalidDateFormat
	self should:[CreditCard of: 'Pepo' withID: 1 withExpirationDate: Date today]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: CreditCard cannotCreateCardWithInvalidDateFormatMessage].! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'items amount catalogue'
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


!Cart methodsFor: 'initialization' stamp: 'EMI 11/24/2020 18:34:18'!
initialize: aCatalogue
	amount _ 0.
	items _ Bag new.
	catalogue _ aCatalogue.! !


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


!Cart methodsFor: 'private' stamp: 'EMI 11/24/2020 18:35:48'!
checkIfItemIsInCatalogue: anItem
	^catalogue includes: anItem.! !


!Cart methodsFor: 'accessing' stamp: 'EMI 11/24/2020 18:34:18'!
contents
	^items copy.! !

!Cart methodsFor: 'accessing' stamp: 'EMI 11/24/2020 18:36:06'!
copiesOf: anItem
	^items occurrencesOf: anItem.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'EMI 11/18/2020 18:09:24'!
createUsingCatalogue: aCatalogue
	^self new initialize: aCatalogue.! !


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

!Cashier methodsFor: 'operations' stamp: 'EMI 11/24/2020 18:23:53'!
checkout: aCart usingCard: aCard
	| bill  |
	(aCart isEmpty) ifTrue: [^Error signal: self class cannotCheckoutEmptyCartMessage].
	(GregorianMonthOfYear current <= aCard expiration) ifFalse:[^Error signal: self class cannotCheckoutWithExpiredCardMessage.].
	bill _ 0.
	aCart contents do: [:aCartItem | bill _ bill + priceListDictionary at: aCartItem].
	merchantProcessor debit: bill from: aCard.
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


!CreditCard methodsFor: 'initialize' stamp: 'EMI 11/24/2020 18:32:21'!
initializeWithID: anID withExpirationDate: aDate ofOwner: aName.
	(anID <= 0 or:[anID isInteger not]) ifTrue: [^Error signal: self class cannotCreateCardWithInvalidIDMessage].
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
