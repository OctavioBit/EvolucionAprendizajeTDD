!classDefinition: #CartTest category: 'Tus-Libros-Iteracion2'!
TestCase subclass: #CartTest
	instanceVariableNames: 'isbn1 isbn2 catalog1 cart1'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Iteracion2'!

!CartTest methodsFor: 'setUp/tearDown' stamp: 'PGTA 11/22/2020 18:43:40'!
setUp
	
	isbn1 := 12345.
	isbn2 := 123456.
	
	catalog1 := Dictionary newFromPairs: (OrderedCollection with: isbn1 with: 100 with: isbn2 with: 30).
	
	cart1 := Cart withCatalog: catalog1.
	! !


!CartTest methodsFor: 'tests' stamp: 'PJ 11/18/2020 22:05:25'!
test01_newCartIsAnEmptyCart
	
	self assert: cart1 isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'PGTA 11/19/2020 19:34:19'!
test02_cartWithOneBookIsNotEmpty

	cart1 add: isbn1 quantity: 1.
	self assert: (cart1 isEmpty not).! !

!CartTest methodsFor: 'tests' stamp: 'PGTA 11/19/2020 19:34:19'!
test03_cannotAddISBNOutsideTheCatalogIntoCart
	
	cart1 add: isbn1 quantity: 1.
	cart1 add: isbn2 quantity: 1.
	
	self should: [cart1 add: 1234567 quantity: 1] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Cart ISBNNotInCatalogErrorDescription.! !

!CartTest methodsFor: 'tests' stamp: 'PGTA 11/19/2020 19:34:19'!
test04_cartContainsAllAddedBooksISBN
	
	cart1 add: isbn1 quantity: 1.
	cart1 add: isbn2 quantity: 1.
	
	self assert: (cart1 content includesKey: isbn1).
	self assert: (cart1 content includesKey: isbn2).! !

!CartTest methodsFor: 'tests' stamp: 'PGTA 11/19/2020 19:34:19'!
test05_aCartCanAddANumberOfCopiesOfTheSameBookISBN
	
	cart1 add: isbn1 quantity: 2.
	cart1 add: isbn2 quantity: 5.
	
	self assert: 2 equals: (cart1 content at: isbn1).
	self assert: 5 equals: (cart1 content at: isbn2).! !

!CartTest methodsFor: 'tests' stamp: 'PGTA 11/19/2020 19:34:19'!
test06_theNumberOfCopiesToAddOfABookISBNMustBePositive
	
	self should: [cart1 add: isbn1 quantity: 0]
		raise: Error - MessageNotUnderstood
		withMessageText: Cart numberOfCopiesMustBePositiveErrorDescription.! !

!CartTest methodsFor: 'tests' stamp: 'PGTA 11/19/2020 19:34:19'!
test07_theNumberOfCopiesToAddOfABookISBNMustBeInteger
	
	self should: [cart1 add: isbn1 quantity: 3.141592654]
		raise: Error - MessageNotUnderstood
		withMessageText: Cart numberOfCopiesMustBeIntegerErrorDescription.! !

!CartTest methodsFor: 'tests' stamp: 'PGTA 11/24/2020 18:30:07'!
test08_cartKnowsTotalPurchaseValue
	
	| total |
	cart1 add: isbn1 quantity: 2.
	cart1 add: isbn2 quantity: 3.
	
	total := (2*100) + (3*30).
	
	self assert: total equals: cart1 purchaseValue.! !


!classDefinition: #CashierTest category: 'Tus-Libros-Iteracion2'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'enabledCreditCard catalog cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Iteracion2'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'PJ 11/25/2020 21:09:58'!
test01_cashierCannotCheckoutAnEmptyCart
	
	| cashier register merchantIface emptyCart|
	
	merchantIface := MPInterfaceSimulatorOpSuccess new.
	register := OrderedCollection new.
	emptyCart := Cart withCatalog: catalog.
	
	cashier := Cashier withRegister: register withMerchant: merchantIface.
	
	self should: [ cashier checkOut: emptyCart withCard: enabledCreditCard ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Cashier cannotCheckoutAnEmptyCartErrorDescription.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'PJ 11/25/2020 21:06:04'!
test02_cashierReturnsSuccessWithValidTransaction
	
	| cashier register merchantIface |
	
	merchantIface := MPInterfaceSimulatorOpSuccess new.
	register := OrderedCollection new.
	
	cashier := Cashier withRegister: register withMerchant: merchantIface.
	
	self assert: (cashier checkOut: cart withCard: enabledCreditCard) equals: (Cashier okTransactionMessage).! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'PJ 11/25/2020 21:07:06'!
test03_cashierRejectsTransactionWithExpiredCreditCard
	
	| cashier expiredCreditCard register merchantIface |
	
	merchantIface := MPInterfaceSimulatorOpSuccess new.
	register := OrderedCollection new.
	
	cashier := Cashier withRegister: register withMerchant: merchantIface.
	
	expiredCreditCard := CreditCard withNumber: '1234567812345678' owner: 'Juan el irresistible'  expirationDate: '062010'.
	
	self should: [ cashier checkOut: cart withCard: expiredCreditCard ]
		raise: Error - MessageNotUnderstood! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'PJ 11/24/2020 20:32:09'!
test04_cashierLogsTransactionIfMerchantProcessorSaysOK
	
	| cashier register merchantIface |
	
	merchantIface := MPInterfaceSimulatorOpSuccess new.
	register := OrderedCollection new.
	
	cashier := Cashier withRegister: register withMerchant: merchantIface.
	
	cashier checkOut: cart withCard: enabledCreditCard.
	
	self assert: register first equals: cart.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'PJ 11/25/2020 22:12:25'!
test05_cashierFailsTransactionIfMerchantProcessorSaysStolenCard
	
	| cashier register merchantIface |
	
	merchantIface := MPInterfaceSimulatorNoFundsCard new.
	register := OrderedCollection new.
	
	cashier := Cashier withRegister: register withMerchant: merchantIface.
	
	self should: [cashier checkOut: cart withCard: enabledCreditCard.]
		raise: Error - MessageNotUnderstood
		withMessageText: Cashier unableToCompleteTransactionErrorDescription.
	
	self assert: register isEmpty.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'PJ 11/25/2020 22:12:12'!
test06_cashierFailsTransactionIfMerchantProcessorCardwithNoFunds
	
	| cashier register merchantIface |
	
	merchantIface := MPInterfaceSimulatorStolenCard new.
	register := OrderedCollection new.
	
	cashier := Cashier withRegister: register withMerchant: merchantIface.
	
	self should: [cashier checkOut: cart withCard: enabledCreditCard.]
		raise: Error - MessageNotUnderstood
		withMessageText: Cashier unableToCompleteTransactionErrorDescription.
	
	self assert: register isEmpty.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'PJ 11/25/2020 22:41:14'!
test07_cashierSavesBatchTransactionIfMerchantProcessorIsDown
	
	| cashier register merchantIface |
	
	merchantIface := MPInterfaceSimulatorDown new.
	register := OrderedCollection new.
	
	cashier := Cashier withRegister: register withMerchant: merchantIface.
	
	self should: [cashier checkOut: cart withCard: enabledCreditCard.]
		raise: Error - MessageNotUnderstood
		withMessageText: Cashier transactionWillBeMadeLaterErrorDescription.
	
	self assert: register isEmpty.! !


!CashierTest methodsFor: 'setUp/tearDown' stamp: 'PGTA 11/22/2020 18:32:08'!
setUp
	| isbn1 isbn2 |
	isbn1 := 1234512345.
	isbn2 := 5432154321.
	
	enabledCreditCard := CreditCard withNumber: '1234567812345678' owner: 'Pepe el payaso'  expirationDate: '062021'.
	
	catalog := Dictionary new.
	catalog at: isbn1 put: 300.
	catalog at: isbn2 put: 600.
	
	cart := Cart withCatalog: catalog.
	cart add: isbn1 quantity: 1.
	cart add: isbn2 quantity: 2.
	! !


!classDefinition: #CreditCardTest category: 'Tus-Libros-Iteracion2'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Iteracion2'!

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'PGTA 11/22/2020 15:32:02'!
test01_newCreditCardCantHaveEmptyNumber
	
	
	self should: [ CreditCard withNumber: '' owner: 'Pepe Sánchez' expirationDate: '022021'. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard wrongCreditCardNumberErrorDescription.! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'PGTA 11/22/2020 15:54:30'!
test02_cannotCreateCreditCardWithEmptyExpirationDate
	
	self should: [ CreditCard withNumber: '1234123' owner: 'Pepe Sánchez' expirationDate: ''. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard wrongCreditCardExpirationDateErrorDescription.! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'PGTA 11/22/2020 16:03:00'!
test03_cannotCreateCreditCardWithInvalidInputExpirationDate
	
	self should: [ CreditCard withNumber: '1234123' owner: 'Pepe Sánchez' expirationDate: '022021abc'. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard wrongCreditCardExpirationDateErrorDescription.! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'PGTA 11/22/2020 16:03:55'!
test04_cannotCreateCreditCardWithInvalidInputStringInNumber
	
	self should: [ CreditCard withNumber: '1234dfgh123' owner: 'Pepe Sánchez' expirationDate: '022021'. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard wrongCreditCardNumberErrorDescription.! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'PGTA 11/22/2020 16:06:24'!
test05_cannotCreateCreditCardWithMoreThanSixDigitsInExpirationDate
	
	self should: [ CreditCard withNumber: '1234123' owner: 'Pepe Sánchez' expirationDate: '022021111'. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard wrongCreditCardExpirationDateErrorDescription.! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'PGTA 11/22/2020 17:00:06'!
test06_cannotCreateCreditCardWithInvalidMonthExpirationDate
	
	self should: [ CreditCard withNumber: '1234123' owner: 'Pepe Sánchez' expirationDate: '232050'. ]
		raise: Error.! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'PGTA 11/22/2020 17:01:27'!
test07_cannotCreateCreditCardWithEmptyOwnerString
	
	self should: [ CreditCard withNumber: '1234123' owner: '' expirationDate: '022021'. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard wrongCreditCardOwnerErrorDescription.! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'PGTA 11/22/2020 17:08:41'!
test08_creditCardKnowsItsCardNumber
	| ccard |
	
	ccard := CreditCard withNumber: '1234123' owner: 'Pepe' expirationDate: '022021'.
	self assert: '1234123' equals: ccard cardNumber.! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'PGTA 11/22/2020 17:14:07'!
test09_creditCardKnowsItsOwnerName
	| ccard |
	
	ccard := CreditCard withNumber: '1234123' owner: 'Pepe' expirationDate: '022021'.
	self assert: 'Pepe' equals: ccard ownerName.! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'PJ 11/26/2020 00:09:07'!
test10_creditCardKnowsItsExpirationDate
	| ccard expDate |
	
	"expDate := GregorianMonthOfYear yearNumber: 2021 monthNumber: 2."
	expDate := '102021'.
	
	ccard := CreditCard withNumber: '1234123' owner: 'Pepe' expirationDate: expDate.
	self assert: expDate = ccard expirationDate! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'PGTA 11/22/2020 17:31:45'!
test11_creditCardKnowsIfItsExpired
	| ccard |
	
	ccard := CreditCard withNumber: '1234123' owner: 'Pepe' expirationDate: '022019'.
	self assert: ccard isExpired.! !


!classDefinition: #Cart category: 'Tus-Libros-Iteracion2'!
Object subclass: #Cart
	instanceVariableNames: 'content catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Iteracion2'!

!Cart methodsFor: 'testing' stamp: 'PGTA 11/16/2020 19:25:24'!
isEmpty
	^content isEmpty.! !


!Cart methodsFor: 'initialization' stamp: 'PJ 11/18/2020 21:19:01'!
initializeWithCatalog: aCatalog
	
	content := Bag new.
	catalog := aCatalog.! !


!Cart methodsFor: 'cart operations' stamp: 'PGTA 11/22/2020 18:38:33'!
add: anISBN quantity: aNumberOfCopies 
	
	(catalog includesKey: anISBN) ifFalse: [ ^self error: self class ISBNNotInCatalogErrorDescription ].
	(aNumberOfCopies > 0) ifFalse: [ ^self error: self class numberOfCopiesMustBePositiveErrorDescription ].
	(aNumberOfCopies isKindOf: Integer) ifFalse: [ ^self error: self class numberOfCopiesMustBeIntegerErrorDescription ].
	content add: anISBN withOccurrences: aNumberOfCopies.! !

!Cart methodsFor: 'cart operations' stamp: 'PGTA 11/24/2020 18:29:13'!
purchaseValue
	| total |
	total := 0.
	content do: [:item | total := (total + (catalog at: item)) ].
	^total! !


!Cart methodsFor: 'list cart' stamp: 'PJ 11/18/2020 21:21:55'!
content
	^content contents copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'Tus-Libros-Iteracion2'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'errors' stamp: 'PGTA 11/18/2020 19:09:26'!
ISBNNotInCatalogErrorDescription
	^'ISBN not in catalog.'! !

!Cart class methodsFor: 'errors' stamp: 'PGTA 11/19/2020 19:29:31'!
numberOfCopiesMustBeIntegerErrorDescription
	^'Number of copies must be integer'! !

!Cart class methodsFor: 'errors' stamp: 'PJ 11/18/2020 21:38:16'!
numberOfCopiesMustBePositiveErrorDescription
	^'Number of copies must be positive'! !


!Cart class methodsFor: 'instance creation' stamp: 'PGTA 11/18/2020 19:10:57'!
withCatalog: aCatalog

	^self new initializeWithCatalog: aCatalog ! !


!classDefinition: #Cashier category: 'Tus-Libros-Iteracion2'!
Object subclass: #Cashier
	instanceVariableNames: 'catalog register merchantProcesorInterface'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Iteracion2'!

!Cashier methodsFor: 'operations' stamp: 'PJ 11/25/2020 23:55:47'!
checkOut: aCart withCard: aCreditCard
 
	|answer|
	aCart isEmpty ifTrue: [^self error: self class cannotCheckoutAnEmptyCartErrorDescription. ].
	aCreditCard isExpired ifTrue: [^self error: self class expiredCardErrorDescription ].
	
	answer := merchantProcesorInterface debit: aCart purchaseValue from: aCreditCard.
	(answer isKindOf: MPError) ifTrue: [^self error: self class unableToCompleteTransactionErrorDescription ].
	(answer isKindOf: MPOffline ) ifTrue: [ "|aFilenameString today|
		today := FixedGregorianDate today.
		aFilenameString := 'TUSLIBROS_INPUT_', today year number asString, today month number asString , today dayNumber asString , '.csv'.
		aFilenameString asFileName appendStreamDo:[:stream | stream nextPutAll: ('2', aCreditCard cardNumber, aCreditCard expirationDate, aCreditCard ownerName)]."
		^self error: self class transactionWillBeMadeLaterErrorDescription
	].
	
	register add: aCart.
	^self class okTransactionMessage! !


!Cashier methodsFor: 'initialization' stamp: 'PJ 11/24/2020 20:45:42'!
initializeWithRegister: aRegister withMerchant: aMerchantProcesorInterface
	register := aRegister.
	merchantProcesorInterface := aMerchantProcesorInterface.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'Tus-Libros-Iteracion2'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'errors' stamp: 'PGTA 11/19/2020 19:46:50'!
cannotCheckoutAnEmptyCartErrorDescription
	^'Cannot checkout an empty cart'.! !

!Cashier class methodsFor: 'errors' stamp: 'PGTA 11/22/2020 19:15:39'!
expiredCardErrorDescription
	^'Sorry Bob, card is expired'! !

!Cashier class methodsFor: 'errors' stamp: 'PJ 11/25/2020 21:52:52'!
noFundsCardErrorDescription
	^'The card has no funds!!'! !

!Cashier class methodsFor: 'errors' stamp: 'PJ 11/25/2020 21:40:15'!
stolenCardErrorDescription
	^'Stolen Card'! !

!Cashier class methodsFor: 'errors' stamp: 'PJ 11/25/2020 22:43:16'!
transactionWillBeMadeLaterErrorDescription
	^'Merchant Processor Interface Simulator'.! !

!Cashier class methodsFor: 'errors' stamp: 'PJ 11/25/2020 22:10:44'!
unableToCompleteTransactionErrorDescription
	^'Unable To Complete Transaction'! !


!Cashier class methodsFor: 'messages' stamp: 'PGTA 11/22/2020 18:59:19'!
okTransactionMessage
	^'Transaction successful'! !


!Cashier class methodsFor: 'instance creation' stamp: 'PGTA 11/22/2020 18:54:15'!
withCatalog: aCatalog 
	
	^self new initializeWithCatalog: aCatalog! !

!Cashier class methodsFor: 'instance creation' stamp: 'PJ 11/24/2020 20:44:36'!
withRegister: aRegister withMerchant: aMerchantProcesorInterface
	
	^self new initializeWithRegister: aRegister withMerchant: aMerchantProcesorInterface ! !


!classDefinition: #CreditCard category: 'Tus-Libros-Iteracion2'!
Object subclass: #CreditCard
	instanceVariableNames: 'number ownerName expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Iteracion2'!

!CreditCard methodsFor: 'initialization' stamp: 'PJ 11/25/2020 23:53:35'!
initializeWithNumber: aCreditCardNumberString owner: aCreditCardOwnerName expirationDate: aCreditCardExpirationDateString 

	| yearNumber monthNumber |
	
	aCreditCardNumberString isEmpty ifTrue: [ ^self error: self class wrongCreditCardNumberErrorDescription ].
	aCreditCardNumberString do: [:aChar | aChar isDigit ifFalse: [ ^self error: self class wrongCreditCardNumberErrorDescription ] ].

	aCreditCardOwnerName isEmpty ifTrue: [ ^self error: self class wrongCreditCardOwnerErrorDescription ].
	
	aCreditCardExpirationDateString isEmpty ifTrue: [ ^self error: self class wrongCreditCardExpirationDateErrorDescription ].
	aCreditCardExpirationDateString do: [:aChar | aChar isDigit ifFalse: [ ^self error: self class wrongCreditCardExpirationDateErrorDescription ] ].
	aCreditCardExpirationDateString size > 6 ifTrue: [^self error: self class wrongCreditCardExpirationDateErrorDescription].
	
	monthNumber := (aCreditCardExpirationDateString collect: [:digit | digit] from: 1 to: 2) asNumber.
	yearNumber := (aCreditCardExpirationDateString collect: [:digit | digit] from: 3 to: 6) asNumber.

	expirationDate := GregorianMonthOfYear yearNumber: yearNumber monthNumber: monthNumber.
	number := aCreditCardNumberString.
	ownerName := aCreditCardOwnerName.
	! !


!CreditCard methodsFor: 'accessing' stamp: 'PGTA 11/22/2020 17:08:00'!
cardNumber
	^number.! !

!CreditCard methodsFor: 'accessing' stamp: 'PJ 11/25/2020 23:57:49'!
expirationDate

	^expirationDate monthNumber asString, expirationDate year number asString ! !

!CreditCard methodsFor: 'accessing' stamp: 'PGTA 11/22/2020 17:14:32'!
ownerName
	^ownerName! !


!CreditCard methodsFor: 'testing' stamp: 'PGTA 11/22/2020 17:31:35'!
isExpired
	| today |
	today := FixedGregorianDate today.
	
	^expirationDate < (GregorianMonthOfYear year: today year month: today month).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'Tus-Libros-Iteracion2'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'error' stamp: 'PGTA 11/22/2020 15:55:17'!
wrongCreditCardExpirationDateErrorDescription
	^'Wrong credit card expiration date'! !

!CreditCard class methodsFor: 'error' stamp: 'PGTA 11/22/2020 15:33:15'!
wrongCreditCardNumberErrorDescription
	^'Wrong credit card number'! !

!CreditCard class methodsFor: 'error' stamp: 'PGTA 11/22/2020 17:02:29'!
wrongCreditCardOwnerErrorDescription
	^'Invalid credit card owner'! !


!CreditCard class methodsFor: 'instance creation' stamp: 'PGTA 11/22/2020 15:34:49'!
withNumber: aCreditCardNumberString owner: aCreditCardOwnerName expirationDate: aCreditCardExpirationDateString
	
	^self new initializeWithNumber: aCreditCardNumberString owner: aCreditCardOwnerName expirationDate: aCreditCardExpirationDateString ! !


!classDefinition: #MPException category: 'Tus-Libros-Iteracion2'!
Object subclass: #MPException
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Iteracion2'!


!classDefinition: #MPError category: 'Tus-Libros-Iteracion2'!
MPException subclass: #MPError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Iteracion2'!


!classDefinition: #MPOffline category: 'Tus-Libros-Iteracion2'!
MPException subclass: #MPOffline
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Iteracion2'!


!classDefinition: #MPOk category: 'Tus-Libros-Iteracion2'!
MPException subclass: #MPOk
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Iteracion2'!


!classDefinition: #MerchantProcessorInterfaceSimulator category: 'Tus-Libros-Iteracion2'!
Object subclass: #MerchantProcessorInterfaceSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Iteracion2'!

!MerchantProcessorInterfaceSimulator methodsFor: 'testing' stamp: 'PJ 11/25/2020 21:28:25'!
debit: aPurchaseValue from: aCreditCard 
	self subclassResponsibility.! !


!classDefinition: #MPInterfaceSimulatorDown category: 'Tus-Libros-Iteracion2'!
MerchantProcessorInterfaceSimulator subclass: #MPInterfaceSimulatorDown
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Iteracion2'!

!MPInterfaceSimulatorDown methodsFor: 'as yet unclassified' stamp: 'PJ 11/25/2020 23:39:47'!
debit: aPurchaseValue from: aCreditCard 
	"^self error: 'MP: Offline'."
	^MPOffline new.! !


!classDefinition: #MPInterfaceSimulatorNoFundsCard category: 'Tus-Libros-Iteracion2'!
MerchantProcessorInterfaceSimulator subclass: #MPInterfaceSimulatorNoFundsCard
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Iteracion2'!

!MPInterfaceSimulatorNoFundsCard methodsFor: 'as yet unclassified' stamp: 'PJ 11/25/2020 23:39:55'!
debit: aPurchaseValue from: aCreditCard 
	"^self error: 'MP: No Funds'."
	^MPError new ! !


!classDefinition: #MPInterfaceSimulatorOpSuccess category: 'Tus-Libros-Iteracion2'!
MerchantProcessorInterfaceSimulator subclass: #MPInterfaceSimulatorOpSuccess
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Iteracion2'!

!MPInterfaceSimulatorOpSuccess methodsFor: 'testing' stamp: 'PJ 11/25/2020 23:40:08'!
debit: aPurchaseValue from: aCreditCard 
	^MPOk new! !


!classDefinition: #MPInterfaceSimulatorStolenCard category: 'Tus-Libros-Iteracion2'!
MerchantProcessorInterfaceSimulator subclass: #MPInterfaceSimulatorStolenCard
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Iteracion2'!

!MPInterfaceSimulatorStolenCard methodsFor: 'as yet unclassified' stamp: 'PJ 11/25/2020 23:40:16'!
debit: aPurchaseValue from: aCreditCard 
	"^self error: 'MP: Stolen Card'."
	^MPError new! !
