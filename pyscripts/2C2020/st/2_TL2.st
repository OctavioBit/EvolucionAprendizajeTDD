!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'aBook anotherBook invalidBook aCatalog aBookPrice anotherBookPrice'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'FC 11/16/2020 19:31:19'!
test01newCartShouldBeEmpty
	|aCart|
	
	aCart := Cart withCatalog: aCatalog.
	
	self assert: aCart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'FC 11/16/2020 19:31:34'!
test02canAddOneCopyOfValidBook
	|aCart|
	
	aCart := Cart withCatalog: aCatalog.
	
	aCart add: 1 copiesOf:aBook.
	
	self deny: aCart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'FC 11/16/2020 19:31:51'!
test03canAddOneCopyOfManyValidBooks
	|aCart|
	
	aCart := Cart withCatalog: aCatalog.
	
	aCart add: 1 copiesOf: aBook.
	aCart add: 1 copiesOf: anotherBook.
	
	self deny: aCart isEmpty.
	self assert: (aCart contains: aBook).
	self assert: (aCart contains: anotherBook).! !

!CartTest methodsFor: 'tests' stamp: 'FC 11/16/2020 19:32:13'!
test04canNotAddCopiesOfBookNotInCatalog
	|aCart|
	
	aCart := Cart withCatalog: aCatalog.
	
	self should: [ aCart add: 1 copiesOf: invalidBook ] raise: Error withMessageText: Cart invalidBookMessage.
	
	self assert: aCart isEmpty. 
! !

!CartTest methodsFor: 'tests' stamp: 'FC 11/16/2020 19:32:32'!
test05canNotAddNegativeCopiesOfABook
	|aCart|
	
	aCart := Cart withCatalog: aCatalog.
	
	self should: [ aCart add: -1 copiesOf: aBook ] raise: Error withMessageText: Cart invalidQuantity.
	
	self assert: aCart isEmpty. 
! !

!CartTest methodsFor: 'tests' stamp: 'FC 11/16/2020 19:32:50'!
test06canNotAddZeroCopiesOfABook
	|aCart|
	
	aCart := Cart withCatalog: aCatalog.
	
	self should: [ aCart add: 0 copiesOf: aBook ] raise: Error withMessageText: Cart invalidQuantity.
	
	self assert: aCart isEmpty. 
! !

!CartTest methodsFor: 'tests' stamp: 'FC 11/16/2020 19:33:03'!
test07canAddMultipleCopiesOfOneValidBook
	|aCart|
	
	aCart := Cart withCatalog: aCatalog.
	
	aCart add: 2 copiesOf: aBook.

	self deny: aCart isEmpty.
	self assert: (aCart copiesOf: aBook) equals: 2.
! !

!CartTest methodsFor: 'tests' stamp: 'FC 11/19/2020 18:47:22'!
test08canNotAddNonIntegerCopiesOfABook
	|aCart|
	
	aCart := Cart withCatalog: aCatalog.
	
	self should: [aCart add: 1.5 copiesOf: aBook] raise: Error withMessageText: Cart invalidQuantity.

	self assert: (aCart isEmpty).
! !


!CartTest methodsFor: 'setUp/tearDown' stamp: 'FC 11/19/2020 19:00:16'!
setUp
	
	aBook := 'Librito'.
	aBookPrice := 20.
	anotherBook := 'Design Patterns'.
	anotherBookPrice :=  500.
	invalidBook := 'Computer Networks: A systems approach'.
	aCatalog := Dictionary new.
	aCatalog add: aBook->aBookPrice; add: anotherBook->anotherBookPrice.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testCatalog aBook aBookPrice anotherBook anotherBookPrice invalidBook aCatalog anExpiredCreditCard aValidCreditCard aMerchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'FC 11/21/2020 17:14:11'!
test01CanNotCheckOutEmptyCart
	| aCart |
	
	aCart := Cart withCatalog: testCatalog.
	
	self should: [ Cashier for: aCart using: aValidCreditCard withMerchantProcessor: aMerchantProcessor ] raise: Error withMessageText: Cashier emptyCartMessage.
	
	
	
	
! !

!CashierTest methodsFor: 'tests' stamp: 'FC 11/21/2020 17:14:44'!
test02checkOutReturnsTotalPriceOfOneItem
	| aCart aCashier total|
	
	aCart := Cart withCatalog: aCatalog .
	
	aCart add: 1 copiesOf: aBook.
	
	aCashier := Cashier for: aCart using: aValidCreditCard withMerchantProcessor: aMerchantProcessor.
	
	total := aCashier checkOut.
	
	self assert: total equals: aBookPrice.
	
! !

!CashierTest methodsFor: 'tests' stamp: 'FC 11/21/2020 17:14:58'!
test03checkOutReturnsTotalPriceOfManyItems
	| aCart aCashier total|
	
	aCart := Cart withCatalog: aCatalog .
	
	aCart add: 2 copiesOf: aBook.
	
	aCashier := Cashier for: aCart using: aValidCreditCard withMerchantProcessor: aMerchantProcessor.
	
	total := aCashier checkOut.
	
	self assert: total equals: aBookPrice * 2.
	
! !

!CashierTest methodsFor: 'tests' stamp: 'FC 11/21/2020 17:15:16'!
test04CanNotCheckoutWithExpiredCard
	| aCart |
	
	aCart := Cart withCatalog: aCatalog .
	aCart add: 1 copiesOf: aBook.
	
	
	self should: [Cashier for: aCart using: anExpiredCreditCard withMerchantProcessor: aMerchantProcessor] raise: Error withMessageText: Cashier creditCardExpiredMessage.
	! !

!CashierTest methodsFor: 'tests' stamp: 'FC 11/21/2020 17:15:27'!
test05ValidTransactionGetsBilledCorrectly
	| aCart aCashier total|
	
	aCart := Cart withCatalog: aCatalog .
	
	aCart add: 2 copiesOf: aBook.
	
	aCashier := Cashier for: aCart using: aValidCreditCard withMerchantProcessor: aMerchantProcessor.
	
	total := aCashier checkOut.
	
	self assert: total equals: aBookPrice * 2.
	self assert: aMerchantProcessor amountBilled equals: total.
	
! !

!CashierTest methodsFor: 'tests' stamp: 'FC 11/21/2020 17:15:56'!
test06CanNotCheckoutWithCardWithInsufficientFunds
	| aCart aCashier anInvalidTransactionMerchantProcessor |
	
	aCart := Cart withCatalog: aCatalog .
	
	anInvalidTransactionMerchantProcessor := InsufficientFundsMerchantProcessorDouble new.
	
	aCart add: 2 copiesOf: aBook.
	
	aCashier := Cashier for: aCart using: aValidCreditCard withMerchantProcessor: anInvalidTransactionMerchantProcessor.
	
	self should: [aCashier checkOut] raise: Error withMessageText: Cashier insufficientFundsMessage.
	! !


!CashierTest methodsFor: 'setUp/tearDown' stamp: 'FC 11/21/2020 17:11:09'!
setUp
	aBook := 'Librito'.
	aBookPrice := 20.
	anotherBook := 'Design Patterns'.
	anotherBookPrice :=  500.
	invalidBook := 'Computer Networks: A systems approach'.
	aCatalog := Dictionary new.
	aCatalog add: aBook->aBookPrice; add: anotherBook->anotherBookPrice.
	anExpiredCreditCard := CreditCard withOwner: 'Felipe Curti' Number: '4555123490908765'  ExpirationDate: (GregorianMonthOfYear year: (GregorianYear createYear: 2020) month: May). 
	aValidCreditCard := CreditCard withOwner: 'Tinchoni' Number: '4554623490908765'  ExpirationDate: (GregorianMonthOfYear year: (GregorianYear createYear: 2022) month: May). 
	aMerchantProcessor := ValidTransactionMerchantProcessorDouble new.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'contents catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'testing' stamp: 'FC 11/16/2020 19:38:55'!
contains: aBook
	^contents includes: aBook.! !

!Cart methodsFor: 'testing' stamp: 'FC 11/16/2020 18:57:38'!
isEmpty
	^contents isEmpty.! !


!Cart methodsFor: 'initialization' stamp: 'FC 11/16/2020 19:42:27'!
initializeFor: aCatalog
	catalog := aCatalog.
	contents := Bag new.! !


!Cart methodsFor: 'adding' stamp: 'FC 11/19/2020 18:48:06'!
add: aQuantity copiesOf: aBook

	self validateBook: aBook.
	self validateQuantity: aQuantity.
	contents add: aBook withOccurrences: aQuantity.! !

!Cart methodsFor: 'adding' stamp: 'FC 11/19/2020 19:05:28'!
catalog
	^catalog copy.! !

!Cart methodsFor: 'adding' stamp: 'FC 11/19/2020 19:04:34'!
listBooks
	^contents copy.! !

!Cart methodsFor: 'adding' stamp: 'FC 11/19/2020 19:00:33'!
validateBook: aBook

	^ (catalog includesKey: aBook) ifFalse:[self error: self class invalidBookMessage]! !

!Cart methodsFor: 'adding' stamp: 'FC 11/19/2020 18:48:38'!
validateQuantity: aQuantity

	^ ((aQuantity <= 0) or: [(aQuantity isInteger) not ]) ifTrue: [self error: self class invalidQuantity]! !


!Cart methodsFor: 'accessing' stamp: 'FC 11/16/2020 19:39:15'!
copiesOf: aBook
	^contents occurrencesOf: aBook.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'FC 11/16/2020 19:10:18'!
withCatalog: aCatalog
	^self new initializeFor: aCatalog.! !


!Cart class methodsFor: 'error' stamp: 'FC 11/16/2020 19:09:50'!
invalidBookMessage
	^'Book not in catalog'.! !

!Cart class methodsFor: 'error' stamp: 'FC 11/16/2020 19:28:39'!
invalidQuantity
	^'Book quantity must be positive'.! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart creditCard merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkOut' stamp: 'FC 11/21/2020 17:10:41'!
checkOut
	| total catalog |
	catalog := cart catalog.
	total := 0.
	cart listBooks do: [ :aBook | total := total + catalog at: aBook ].
	
	merchantProcessor debit: total for: creditCard.
	
	^ total.! !


!Cashier methodsFor: 'initialization' stamp: 'FC 11/21/2020 17:07:27'!
initializeFor: aCart using: aCreditCard withMerchantProcessor: aMerchantProcessor.
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'FC 11/21/2020 17:06:47'!
for: aCart using: aCreditCard withMerchantProcessor: aMerchantProcessor.
	
	aCart isEmpty ifTrue: [
		self error: self emptyCartMessage.
	].
	
	aCreditCard isExpired ifTrue: [
		self error: self creditCardExpiredMessage.
	].
	
	^self new initializeFor: aCart using: aCreditCard withMerchantProcessor: aMerchantProcessor.! !


!Cashier class methodsFor: 'error' stamp: 'FC 11/19/2020 19:19:06'!
creditCardExpiredMessage
	^'Credit Card is expired'! !

!Cashier class methodsFor: 'error' stamp: 'FC 11/19/2020 18:54:09'!
emptyCartMessage
	^'Cart is empty'! !

!Cashier class methodsFor: 'error' stamp: 'FC 11/21/2020 17:10:02'!
insufficientFundsMessage
	^'Card has insufficient funds'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationDate ownerName cardNumber'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'FC 11/21/2020 16:50:56'!
initializeWithOwner: aName Number: aCardNumber ExpirationDate: aMonthOfYear
	ownerName = aName.
	cardNumber = aCardNumber.
	expirationDate := aMonthOfYear.! !


!CreditCard methodsFor: 'testing' stamp: 'FC 11/19/2020 19:23:39'!
isExpired
	| currentMonth |
	currentMonth := GregorianMonthOfYear current.
	^currentMonth > expirationDate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'FC 11/21/2020 16:57:06'!
emptyNameMessage
	^'Name can not be empty'.! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'FC 11/21/2020 16:57:22'!
invalidCardNumberMessage
	^'Card number is invalid'.! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'FC 11/21/2020 16:56:41'!
validateCardNumber: aCardNumber

	^ aCardNumber size < 16 ifTrue: [self error: self invalidCardNumberMessage ]! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'FC 11/21/2020 16:56:50'!
validateOwnerName: aName

	^ aName size = 0 ifTrue: [self error: self emptyNameMessage]! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'FC 11/19/2020 19:18:11'!
withExpirationDate: aMonthOfYear
	^self new initializeWithExpirationDate: aMonthOfYear.! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'FC 11/21/2020 16:56:50'!
withOwner: aName Number: aCardNumber ExpirationDate: aMonthOfYear
	self validateOwnerName: aName.
	self validateCardNumber: aCardNumber.
	^self new initializeWithOwner: aName Number: aCardNumber ExpirationDate: aMonthOfYear! !


!classDefinition: #MerchantProcessorDouble category: 'TusLibros'!
Object subclass: #MerchantProcessorDouble
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorDouble methodsFor: 'debit' stamp: 'FC 11/21/2020 17:17:59'!
debit: anAmount for: aCreditCard
	self subclassResponsibility.! !


!classDefinition: #InsufficientFundsMerchantProcessorDouble category: 'TusLibros'!
MerchantProcessorDouble subclass: #InsufficientFundsMerchantProcessorDouble
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InsufficientFundsMerchantProcessorDouble methodsFor: 'debit' stamp: 'FC 11/21/2020 17:09:36'!
debit: anAmount for: aCreditCard
	self error: Cashier insufficientFundsMessage.! !


!classDefinition: #ValidTransactionMerchantProcessorDouble category: 'TusLibros'!
MerchantProcessorDouble subclass: #ValidTransactionMerchantProcessorDouble
	instanceVariableNames: 'billedAmount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ValidTransactionMerchantProcessorDouble methodsFor: 'debit' stamp: 'FC 11/21/2020 17:08:54'!
debit: anAmount for: aCreditCard
	billedAmount := anAmount.! !


!ValidTransactionMerchantProcessorDouble methodsFor: 'accessing' stamp: 'FC 11/21/2020 17:11:24'!
amountBilled
	^billedAmount.! !
