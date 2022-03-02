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


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'FR 11/26/2020 14:33:21'!
defaultCatalog
	
	^ Dictionary with: (Association key: self itemSellByTheStore value: 50)! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'FR 11/26/2020 15:44:11'!
test01CannotCheckOutAnEmptyCart

	self  assertCheckingOutCart: self anEmptyShoppingCart
		withCreditCard: self aValidCreditCard
		shouldRaiseErrorWithMessage: Cashier emptyCartErrorDescription
! !

!CashierTest methodsFor: 'tests' stamp: 'FR 11/26/2020 15:44:23'!
test02CannotCheckOutWithExpiredCreditCard

	self  assertCheckingOutCart: self aNonEmptyShoppingCart
		withCreditCard: self anExpiredCreditCard
		shouldRaiseErrorWithMessage: Cashier expiredCreditCardErrorDescription! !

!CashierTest methodsFor: 'tests' stamp: 'FR 11/26/2020 15:44:28'!
test03CannotCheckOutWithStolenCreditCard

	self assertCheckingOutShouldRaiseErrorWithMessage: 'El merchant processor detectó que la tarjeta está robada!!'! !

!CashierTest methodsFor: 'tests' stamp: 'FR 11/26/2020 15:44:32'!
test04CannotCheckOutWithCreditCardWithNoCredit

	self assertCheckingOutShouldRaiseErrorWithMessage: 'El merchant processor detectó que la tarjeta no tiene crédito!!'! !

!CashierTest methodsFor: 'tests' stamp: 'FR 11/26/2020 15:44:36'!
test05CashierCorrectlyChecksOutCartWithOneItem

	self  assertCheckingOutWIthCart: self aNonEmptyShoppingCart
		shouldHaveReceipt: 50! !

!CashierTest methodsFor: 'tests' stamp: 'FR 11/26/2020 15:44:42'!
test06CashierCorrectlyChecksOutCartWithMultipleItems

	self  assertCheckingOutWIthCart: self aShoppingCartWithMultipleBooks
		shouldHaveReceipt: 1250! !


!CashierTest methodsFor: 'tests - instances' stamp: 'FR 11/26/2020 14:50:05'!
aBook

	^ 9! !

!CashierTest methodsFor: 'tests - instances' stamp: 'FR 11/26/2020 14:50:09'!
aDifferentBook

	^ 8! !

!CashierTest methodsFor: 'tests - instances' stamp: 'FR 11/26/2020 14:51:12'!
aNonEmptyShoppingCart
	
	^ self anEmptyShoppingCart add: self aBook! !

!CashierTest methodsFor: 'tests - instances' stamp: 'FR 11/26/2020 14:50:40'!
aShoppingCartWithMultipleBooks

	^ (self anEmptyShoppingCart add: 5 of: self aBook) add: 10 of: self aDifferentBook! !

!CashierTest methodsFor: 'tests - instances' stamp: 'FR 11/26/2020 14:20:53'!
aValidCreditCard

	^ CreditCard ownedBy: 'Juan' withNumber: '1234567890123456' andExpirationMonthAndYear: (GregorianMonthOfYear aprilOf: GregorianYear current next)! !

!CashierTest methodsFor: 'tests - instances' stamp: 'FR 11/26/2020 14:49:59'!
anEmptyShoppingCart
	
	^ Cart acceptingItemsOf: (Dictionary with: (Association key: self aBook value: 50) with: (Association key: self aDifferentBook value: 100))! !

!CashierTest methodsFor: 'tests - instances' stamp: 'FR 11/26/2020 14:21:16'!
anExpiredCreditCard

	^ CreditCard ownedBy: 'Juan' withNumber: '1234567890123456' andExpirationMonthAndYear: (GregorianMonthOfYear aprilOf: GregorianYear current)! !

!CashierTest methodsFor: 'tests - instances' stamp: 'FR 11/26/2020 11:40:54'!
functionalError

	^ Error - MessageNotUnderstood! !


!CashierTest methodsFor: 'tests - assertions' stamp: 'FR 11/26/2020 15:39:06'!
assertCheckingOutCart: aShoppingCart withCreditCard: aCreditCard shouldRaiseErrorWithMessage: expectedErrorMessage

	| aMerchantProcessor |
	
	aMerchantProcessor := MerchantProcessorSimulator successfullyValidates.

	self  assertCheckingOutCart: aShoppingCart
		withCreditCard: aCreditCard
		usingMerchantProcessor: aMerchantProcessor
		shouldRaiseErrorWithMessage: expectedErrorMessage.

	self deny: aMerchantProcessor hasBeenUsed.! !

!CashierTest methodsFor: 'tests - assertions' stamp: 'FR 11/26/2020 15:36:45'!
assertCheckingOutCart: aShoppingCart withCreditCard: aCreditCard usingMerchantProcessor: aMerchantProcessor shouldRaiseErrorWithMessage: expectedErrorMessage

	| aCashier aReceipt |
	
	aReceipt := 'No se completó la venta'.
	
	aCashier := Cashier withMerchantProcessor: aMerchantProcessor.
	
	self  should: [ aReceipt := aCashier checkout: aShoppingCart with: aCreditCard ]
		raise: self functionalError
		withMessageText: expectedErrorMessage.
	
	self assert: aReceipt equals: 'No se completó la venta'.! !

!CashierTest methodsFor: 'tests - assertions' stamp: 'FR 11/26/2020 15:40:30'!
assertCheckingOutShouldRaiseErrorWithMessage: expectedErrorMessage

	| aMerchantProcessor |
	
	aMerchantProcessor := MerchantProcessorSimulator raisesErrorWithMessage: expectedErrorMessage.

	self  assertCheckingOutCart: self aNonEmptyShoppingCart
		withCreditCard: self aValidCreditCard
		usingMerchantProcessor: aMerchantProcessor
		shouldRaiseErrorWithMessage: expectedErrorMessage.

	self assert: aMerchantProcessor hasBeenUsed.! !

!CashierTest methodsFor: 'tests - assertions' stamp: 'FR 11/26/2020 15:27:15'!
assertCheckingOutWIthCart: aShoppingCart shouldHaveReceipt: expectedReceipt

	| aCashier aMerchantProcessor aReceipt |
	
	aMerchantProcessor := MerchantProcessorSimulator successfullyValidates.
	
	aCashier := Cashier withMerchantProcessor: aMerchantProcessor.
		
	aReceipt := aCashier checkout: aShoppingCart with: self aValidCreditCard.
	
	self assert: aReceipt = expectedReceipt.
	self assert: aMerchantProcessor hasBeenUsed! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'FR 11/26/2020 14:21:55'!
test01CreditCardNumberCannotHaveLessThanSixteenDigits

	self  should: [ CreditCard ownedBy: 'Juan Rodriguez' withNumber: '123456789012345' andExpirationMonthAndYear: GregorianMonthOfYear current ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard invalidNumberErrorDescription! !

!CreditCardTest methodsFor: 'tests' stamp: 'FR 11/26/2020 14:24:01'!
test02CreditCardNameCannotBeEmpty

	self  should: [ CreditCard ownedBy: '' withNumber: '1234567890123456' andExpirationMonthAndYear: GregorianMonthOfYear current ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard invalidNameErrorDescription! !

!CreditCardTest methodsFor: 'tests' stamp: 'FR 11/26/2020 14:25:26'!
test03CreditCardNumberCannotHaveMoreThanSixteenDigits

	self  should: [ CreditCard ownedBy: 'Juan Rodriguez' withNumber: '12345678901234567' andExpirationMonthAndYear: GregorianMonthOfYear current ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard invalidNumberErrorDescription! !

!CreditCardTest methodsFor: 'tests' stamp: 'FR 11/26/2020 14:26:40'!
test04CreditCardWithValidInfoIsCorrectlyCreated

	| aCreditCard |
	
	aCreditCard := CreditCard ownedBy: 'Juan Rodriguez' withNumber: '1234567890123456' andExpirationMonthAndYear: GregorianMonthOfYear current.
	
	self assert: aCreditCard owner = 'Juan Rodriguez'.
	self assert: aCreditCard number = '1234567890123456'.
	self assert: aCreditCard expirationMonthAndYear = GregorianMonthOfYear current.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'pricelist items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'FR 11/26/2020 14:31:28'!
assertIsValidItem: anItem

	(pricelist keys includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'FR 11/26/2020 14:31:11'!
initializeAcceptingItemsOf: aCatalog

	pricelist := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'FR 11/26/2020 14:31:57'!
totalCost
	
	^ items sum: [ :aBook | pricelist at: aBook ] ifEmpty: [^0].! !


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
	instanceVariableNames: 'merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout' stamp: 'FR 11/26/2020 14:54:05'!
assertCartIsNotEmpty: aShoppingCart

	^ aShoppingCart isEmpty ifTrue: [ self error: self class emptyCartErrorDescription ]! !

!Cashier methodsFor: 'checkout' stamp: 'FR 11/26/2020 14:54:17'!
assertCreditCardIsNotExpired: aCreditCard

	^ aCreditCard expirationMonthAndYear < GregorianMonthOfYear current ifTrue: [ self error: self class expiredCreditCardErrorDescription ]! !

!Cashier methodsFor: 'checkout' stamp: 'FR 11/26/2020 14:54:17'!
checkout: aShoppingCart with: aCreditCard
	
	| amount |
	
	self assertCartIsNotEmpty: aShoppingCart.
	self assertCreditCardIsNotExpired: aCreditCard.
	
	amount := aShoppingCart totalCost.
	
	merchantProcessor debit: amount from: aCreditCard.
	
	^amount! !


!Cashier methodsFor: 'initialization' stamp: 'FR 11/26/2020 14:19:15'!
initializeWithMerchantProcessor: aMerchantProcessor 

	merchantProcessor := aMerchantProcessor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error descriptions' stamp: 'FR 11/26/2020 11:41:13'!
emptyCartErrorDescription
	
	^ 'The cashier detected that the shopping cart is empty!!'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'FR 11/26/2020 12:17:51'!
expiredCreditCardErrorDescription
	
	^ 'The cashier detected that the credit card has expired!!'! !


!Cashier class methodsFor: 'instance creation' stamp: 'FR 11/26/2020 14:18:55'!
withMerchantProcessor: aMerchantProcessor

	^self new initializeWithMerchantProcessor: aMerchantProcessor! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'owner number expirationMonthAndYear'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'FR 11/26/2020 14:27:15'!
initializeWithOwner: anOwnerName number: aCreditCardNumber andExpirationMonthAndYear: anExpirationMonthAndYear

	owner := anOwnerName.
	number := aCreditCardNumber.
	expirationMonthAndYear := anExpirationMonthAndYear.! !


!CreditCard methodsFor: 'accessing' stamp: 'FR 11/26/2020 14:27:57'!
expirationMonthAndYear

	^ expirationMonthAndYear copy! !

!CreditCard methodsFor: 'accessing' stamp: 'FR 11/26/2020 14:27:47'!
number

	^ number copy! !

!CreditCard methodsFor: 'accessing' stamp: 'FR 11/26/2020 14:27:37'!
owner

	^ owner copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'error descriptions' stamp: 'FR 11/26/2020 14:24:20'!
invalidNameErrorDescription
	
	^ 'Name is not valid!!'! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'FR 11/26/2020 14:22:18'!
invalidNumberErrorDescription
	
	^ 'Credit card number is invalid!!'! !


!CreditCard class methodsFor: 'instance creation' stamp: 'FR 11/26/2020 14:53:24'!
assertNameIsValid: anOwnerName

	^ anOwnerName ifEmpty: [ self error: self invalidNameErrorDescription ]! !

!CreditCard class methodsFor: 'instance creation' stamp: 'FR 11/26/2020 14:53:15'!
assertNumberIsValid: aCreditCardNumber

	^ aCreditCardNumber size ~= 16 ifTrue: [ self error: self invalidNumberErrorDescription ]! !

!CreditCard class methodsFor: 'instance creation' stamp: 'FR 11/26/2020 14:53:25'!
ownedBy: anOwnerName withNumber: aCreditCardNumber andExpirationMonthAndYear: anExpirationMonthAndYear
	
	self assertNumberIsValid: aCreditCardNumber.
	self assertNameIsValid: anOwnerName.
	
	^ self new initializeWithOwner: anOwnerName number: aCreditCardNumber andExpirationMonthAndYear: anExpirationMonthAndYear.! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'message type used'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'initialization' stamp: 'FR 11/26/2020 14:59:17'!
initializeErrorWithMessage: errorMessageText 
	
	used := false.
	type := #Error.
	message := errorMessageText.! !

!MerchantProcessorSimulator methodsFor: 'initialization' stamp: 'FR 11/26/2020 14:59:23'!
initializeSuccessfullyValidates

	used := false.
	type := #Successful.
	message := 'OK'.! !


!MerchantProcessorSimulator methodsFor: 'debit' stamp: 'FR 11/26/2020 14:59:40'!
debit: anAmount from: aCreditCard

	used := true.
	type = #Error ifTrue: [ self error: message ].
	type = #Successful ifTrue: [ ^ message ]! !


!MerchantProcessorSimulator methodsFor: 'testing' stamp: 'FR 11/26/2020 14:59:01'!
hasBeenUsed

	^ used copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: 'TusLibros'!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'instance creation' stamp: 'FR 11/26/2020 14:17:28'!
raisesErrorWithMessage: errorMessageText
	
	^ self new initializeErrorWithMessage: errorMessageText! !

!MerchantProcessorSimulator class methodsFor: 'instance creation' stamp: 'FR 11/26/2020 14:47:04'!
successfullyValidates

	^ self new initializeSuccessfullyValidates! !
