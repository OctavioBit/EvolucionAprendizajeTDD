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

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

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

!CashierTest methodsFor: 'ErrorsTests' stamp: 'D S 11/26/2020 09:45:19'!
test01CannotCheckOutEmptyCart
	| aCashier aMerchantProcessor aCart aCatalog aCreditCard anExpirationDate priceList|
	priceList := Dictionary new.
	aMerchantProcessor:= MerchantProcessorValidCard new.
	aCashier := Cashier withMerchantProcessor: aMerchantProcessor andPriceList: priceList.
	aCatalog := Bag with: 'validBook' with: 'anotherValidBook'.
	aCart := Cart acceptingItemsOf: aCatalog.
	anExpirationDate := GregorianMonthOfYear yearNumber: 2022 monthNumber: 02.
	aCreditCard := CreditCard withOwner: 'anotherOwner' expirationDate: anExpirationDate andNumber: 12345678906542345.
	
	^[aCashier checkout: aCart withCreditCard: aCreditCard.
		self fail]
	on: Error
	do: [: anError | anError messageText = Cashier errorDescriptionEmptyCart ]
	
	! !

!CashierTest methodsFor: 'ErrorsTests' stamp: 'D S 11/26/2020 09:47:45'!
test05RaiseErrorWhenCreditCardDoesntHaveEnoughCredit
	| aCashier aMerchantProcessor aCart aCatalog aCreditCard anExpirationDate aPriceList|
	
	aPriceList := Dictionary new.
	aPriceList add: 'validBook' -> (8@80).
	aMerchantProcessor:= MerchantProcessorNotEnoughtCredit new.
	aCashier := Cashier withMerchantProcessor: aMerchantProcessor andPriceList: aPriceList.
	aCatalog := Bag with: 'validBook' with: 'anotherValidBook'.
	aCart := Cart acceptingItemsOf: aCatalog.
	aCart add: 4 of: 'validBook'.
	anExpirationDate := GregorianMonthOfYear yearNumber: 2022 monthNumber: 02.
	aCreditCard := CreditCard withOwner: 'anotherOwner' expirationDate: anExpirationDate andNumber: 12345678906542345.
	
	^[aCashier checkout: aCart withCreditCard: aCreditCard.
		 self fail]
	on: Error
	do: [: anError| self assert: (anError messageText = MerchantProcessorNotEnoughtCredit errorDescriptionNotEnoughCredit)].
	
	! !

!CashierTest methodsFor: 'ErrorsTests' stamp: 'D S 11/26/2020 09:48:17'!
test06RaiseErrorWhenTheCreditCardIsStolen
	| aCashier aMerchantProcessor aCart aCatalog aCreditCard anExpirationDate aPriceList|
	
	aPriceList := Dictionary new.
	aPriceList add: 'validBook' -> (8@80).
	aMerchantProcessor:= MerchantProcessorStolenCard new.
	aCashier := Cashier withMerchantProcessor: aMerchantProcessor andPriceList: aPriceList.
	aCatalog := Bag with: 'validBook' with: 'anotherValidBook'.
	aCart := Cart acceptingItemsOf: aCatalog.
	aCart add: 4 of: 'validBook'.
	anExpirationDate := GregorianMonthOfYear yearNumber: 2022 monthNumber: 02.
	aCreditCard := CreditCard withOwner: 'anotherOwner' expirationDate: anExpirationDate andNumber: 12345678906542345.
	
	^[aCashier checkout: aCart withCreditCard: aCreditCard.
		 self fail]
	on: Error
	do: [: anError| self assert: (anError messageText = MerchantProcessorStolenCard errorDescriptionStolenCard)].
	
	! !

!CashierTest methodsFor: 'ErrorsTests' stamp: 'D S 11/26/2020 10:26:21'!
test07RaiseErrorWhenTheCreditCardValidationDateIsExpiredForMonths
	| aCashier aMerchantProcessor aCart aCatalog aCreditCard anExpirationDate aPriceList|
	
	aPriceList := Dictionary new.
	aPriceList add: 'validBook' -> (8@80).
	aMerchantProcessor:= MerchantProcessorStolenCard new.
	aCashier := Cashier withMerchantProcessor: aMerchantProcessor andPriceList: aPriceList.
	aCatalog := Bag with: 'validBook' with: 'anotherValidBook'.
	aCart := Cart acceptingItemsOf: aCatalog.
	aCart add: 4 of: 'validBook'.
	anExpirationDate := GregorianMonthOfYear yearNumber: 2020 monthNumber: 02.
	aCreditCard := CreditCard withOwner: 'anotherOwner' expirationDate: anExpirationDate andNumber: 12345678906542345.
	
	^[aCashier checkout: aCart withCreditCard: aCreditCard.
		 self fail]
	on: Error
	do: [: anError| self assert: (anError messageText = Cashier errorDescriptionExpiredCard)].
	
	! !

!CashierTest methodsFor: 'ErrorsTests' stamp: 'D S 11/26/2020 10:26:06'!
test08RaiseErrorWhenTheCreditCardValidationDateIsExpiredForYears
	| aCashier aMerchantProcessor aCart aCatalog aCreditCard anExpirationDate aPriceList|
	
	aPriceList := Dictionary new.
	aPriceList add: 'validBook' -> (8@80).
	aMerchantProcessor:= MerchantProcessorStolenCard new.
	aCashier := Cashier withMerchantProcessor: aMerchantProcessor andPriceList: aPriceList.
	aCatalog := Bag with: 'validBook' with: 'anotherValidBook'.
	aCart := Cart acceptingItemsOf: aCatalog.
	aCart add: 4 of: 'validBook'.
	anExpirationDate := GregorianMonthOfYear yearNumber: 2000 monthNumber: 02.
	aCreditCard := CreditCard withOwner: 'anotherOwner' expirationDate: anExpirationDate andNumber: 12345678906542345.
	
	^[aCashier checkout: aCart withCreditCard: aCreditCard.
		 self fail]
	on: Error
	do: [: anError| self assert: (anError messageText = Cashier errorDescriptionExpiredCard)].
	
	! !


!CashierTest methodsFor: 'CheckOutTests' stamp: 'D S 11/26/2020 09:45:49'!
test02ReturnsPriceOfOneBookCorrectly
	| aCashier aMerchantProcessor aCart aCatalog aCreditCard anExpirationDate aPriceList|
	
	aPriceList := Dictionary new.
	aPriceList add: 'validBook' -> (8@80).
	aMerchantProcessor:= MerchantProcessorValidCard new.
	aCashier := Cashier withMerchantProcessor: aMerchantProcessor andPriceList: aPriceList.
	aCatalog := Bag with: 'validBook' with: 'anotherValidBook'.
	aCart := Cart acceptingItemsOf: aCatalog.
	aCart add: 'validBook'.
	anExpirationDate := GregorianMonthOfYear yearNumber: 2022 monthNumber: 02.
	aCreditCard := CreditCard withOwner: 'anotherOwner' expirationDate: anExpirationDate andNumber: 12345678906542345.
	
	self assert: (8@80) equals: (aCashier checkout: aCart withCreditCard: aCreditCard).
	
	! !

!CashierTest methodsFor: 'CheckOutTests' stamp: 'D S 11/26/2020 09:47:05'!
test03ReturnsTotalToPayCorrectlyWhenCartHas2DifferentBook
	| aCashier aMerchantProcessor aCart aCatalog aCreditCard anExpirationDate aPriceList|
	
	aPriceList := Dictionary new.
	aPriceList add: 'validBook' -> (8@80).
	aPriceList add: 'anotherValidBook' -> (2@30).
	aMerchantProcessor:= MerchantProcessorValidCard new.
	aCashier := Cashier withMerchantProcessor: aMerchantProcessor andPriceList: aPriceList.
	aCatalog := Bag with: 'validBook' with: 'anotherValidBook'.
	aCart := Cart acceptingItemsOf: aCatalog.
	aCart add: 'validBook'.
	aCart add: 'anotherValidBook'.
	anExpirationDate := GregorianMonthOfYear yearNumber: 2022 monthNumber: 02.
	aCreditCard := CreditCard withOwner: 'anotherOwner' expirationDate: anExpirationDate andNumber: 12345678906542345.
	
	self assert: (11@10) equals: (aCashier checkout: aCart withCreditCard: aCreditCard).
	
	! !

!CashierTest methodsFor: 'CheckOutTests' stamp: 'D S 11/26/2020 09:47:17'!
test04ReturnsTotalToPayCorrectlyWhenCartHasMoreThanOneOfSameBook
	| aCashier aMerchantProcessor aCart aCatalog aCreditCard anExpirationDate aPriceList|
	
	aPriceList := Dictionary new.
	aPriceList add: 'validBook' -> (8@80).
	aMerchantProcessor:= MerchantProcessorValidCard new.
	aCashier := Cashier withMerchantProcessor: aMerchantProcessor andPriceList: aPriceList.
	aCatalog := Bag with: 'validBook' with: 'anotherValidBook'.
	aCart := Cart acceptingItemsOf: aCatalog.
	aCart add: 4 of: 'validBook'.
	anExpirationDate := GregorianMonthOfYear yearNumber: 2022 monthNumber: 02.
	aCreditCard := CreditCard withOwner: 'anotherOwner' expirationDate: anExpirationDate andNumber: 12345678906542345.
	
	self assert: (35@20) equals: (aCashier checkout: aCart withCreditCard: aCreditCard).
	
	! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'ErrorTests' stamp: 'D S 11/26/2020 09:49:39'!
test02RaiseErrorWhenOwnerNameIsEmpty
	|aCreditCard anExpirationDate|
	anExpirationDate := GregorianMonthOfYear yearNumber: 2023 monthNumber: 02.
	
	^[aCreditCard := CreditCard withOwner: '' expirationDate: anExpirationDate andNumber: 12345987606542345.
	self fail]
	on: Error
	do:[:anError | self assert: anError messageText = CreditCard errorDescriptionEmptyName.]! !

!CreditCardTest methodsFor: 'ErrorTests' stamp: 'D S 11/26/2020 09:50:09'!
test03RaiseErrorWhenNumberHasNotEnoughDigits
	|aCreditCard anExpirationDate|
	anExpirationDate := GregorianMonthOfYear yearNumber: 2023 monthNumber: 02.
	
	^[aCreditCard := CreditCard withOwner: '' expirationDate: anExpirationDate andNumber: 123456789101.
	self fail]
	on: Error
	do:[:anError | self assert: anError messageText = CreditCard errorDescriptionInvalidNumberLessDigits.]! !

!CreditCardTest methodsFor: 'ErrorTests' stamp: 'D S 11/26/2020 09:50:37'!
test04RaiseErrorWhenNumberHasTooMuchDigits
	|aCreditCard anExpirationDate|
	anExpirationDate := GregorianMonthOfYear yearNumber: 2023 monthNumber: 02.
	
	^[aCreditCard := CreditCard withOwner: '' expirationDate: anExpirationDate andNumber: 123456789101234567892.
	self fail]
	on: Error
	do:[:anError | self assert: anError messageText = CreditCard errorDescriptionInvalidNumberMoreDigits.]! !


!CreditCardTest methodsFor: 'InitializationTests' stamp: 'D S 11/26/2020 09:49:17'!
test01generateCreditCardCorrectly
	|aCreditCard anExpirationDate|
	anExpirationDate := GregorianMonthOfYear yearNumber: 2022 monthNumber: 02.
	aCreditCard := CreditCard withOwner: 'anOwner' expirationDate: anExpirationDate andNumber: 12345678906542345.
	
	self assert: 'anOwner' equals: aCreditCard owner.
	self assert: (GregorianMonthOfYear yearNumber: 2022 monthNumber: 02) equals: aCreditCard expirationDate.
	self assert: 12345678906542345 equals: aCreditCard cardNumber.! !


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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'merchantProcessorSimulator priceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'SendData --Private--' stamp: 'D S 11/26/2020 14:49:33'!
sendDataToMerchantProcessorOf: aCreditCard ToExtract: anAmount
	| cardNumber cardOwner cardExpirationDate |
	
	cardNumber := aCreditCard cardNumber.
	(((aCreditCard owner) size) > 30) ifTrue:[cardOwner := (aCreditCard owner) copyFrom: 1 to: 30.]
							ifFalse:[cardOwner := aCreditCard owner].
	cardExpirationDate := aCreditCard expirationDate.

	merchantProcessorSimulator extractFromACreditCardWithNumber: cardNumber WhichExpiresIn: cardExpirationDate WithOwner: cardOwner AnAmountOf: anAmount.! !


!Cashier methodsFor: 'CheckOut' stamp: 'D S 11/26/2020 14:15:29'!
checkout: aCart withCreditCard: aCreditCard
	|total|
	
	"Hasta donde tengo entendido, si ocurre un error se para la ejecución. Entonces ¿porque habría que verificar que no se hizo.?"
	self checkCartIsNotEmpty: aCart.
	self checkCardIsNotExpired: aCreditCard.
	total := self calculateTotalToPayForCart: aCart.
	total := self transformEvery100CentInto1FromTheAmount: total.
	self sendDataToMerchantProcessorOf: aCreditCard ToExtract: total.
	^total.! !


!Cashier methodsFor: 'Testing --Private--' stamp: 'D S 11/26/2020 10:25:09'!
checkCardIsNotExpired: aCreditCard

	((aCreditCard expirationDate year ) < (GregorianMonthOfYear current year) or: 
	(self checkCardSameYearButExpiredByMonth: aCreditCard))  ifTrue:[self error: self class errorDescriptionExpiredCard].! !

!Cashier methodsFor: 'Testing --Private--' stamp: 'D S 11/26/2020 10:25:42'!
checkCardSameYearButExpiredByMonth: aCreditCard

	^((aCreditCard expirationDate year) = (GregorianMonthOfYear current year)) and: ((aCreditCard expirationDate month) < (GregorianMonthOfYear current month)).! !

!Cashier methodsFor: 'Testing --Private--' stamp: 'D S 11/26/2020 09:53:18'!
checkCartIsNotEmpty: aCart

	^ (aCart isEmpty) ifTrue:[self error: self class errorDescriptionEmptyCart]! !

!Cashier methodsFor: 'Testing --Private--' stamp: 'D S 11/26/2020 10:23:07'!
checkYearOfExpiration: aCreditCard

	^((aCreditCard expirationDate year ) < (GregorianMonthOfYear current year))! !


!Cashier methodsFor: 'initialization' stamp: 'D S 11/24/2020 22:10:31'!
initializeWithMerchantProcessor: aMerchantProcessor andPriceList: aPriceList 

	merchantProcessorSimulator := aMerchantProcessor.
	priceList := aPriceList.! !


!Cashier methodsFor: 'Calculate --Private--' stamp: 'D S 11/26/2020 10:01:04'!
calculateTotalToPayForCart: aCart
	|total|
	total := 0.
	priceList keysAndValuesDo: [: anItem :aItemPrice|  
		(aCart includes: anItem) ifTrue:[total := total + (aItemPrice * (aCart occurrencesOf: anItem))].
		].
	^total
! !

!Cashier methodsFor: 'Calculate --Private--' stamp: 'D S 11/26/2020 10:02:14'!
transformEvery100CentInto1FromTheAmount: anAmount
	|amountConverted|
	amountConverted := anAmount.
	(anAmount y > 99) ifTrue:[amountConverted := amountConverted + ((1@0)*(amountConverted y // 100)).
					amountConverted := amountConverted - ((0@100) * (amountConverted y //100)).].
	^amountConverted.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'D S 11/24/2020 22:02:55'!
errorDescriptionEmptyCart

	"Esto no tiene que tener 1| al inicio porque los errores que tira el merchant processor es el que debe contenerlo."	
	^'The cart is empty'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'D S 11/26/2020 10:16:38'!
errorDescriptionExpiredCard

	"Esto no tiene que tener 1| al inicio porque los errores que tira el merchant processor es el que debe contenerlo."	
	^'The card is expired'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'D S 11/24/2020 22:09:47'!
withMerchantProcessor: aMerchantProcessor andPriceList: priceList 

	^self new initializeWithMerchantProcessor: aMerchantProcessor andPriceList: priceList.! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'owner expirationDate cardNumber'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'Accessing' stamp: 'D S 11/26/2020 14:51:23'!
cardNumber

	^cardNumber copy.! !

!CreditCard methodsFor: 'Accessing' stamp: 'D S 11/26/2020 14:51:16'!
expirationDate

	^expirationDate copy.! !

!CreditCard methodsFor: 'Accessing' stamp: 'D S 11/26/2020 14:51:20'!
owner

	^owner copy.! !


!CreditCard methodsFor: 'initialization' stamp: 'D S 11/26/2020 14:51:57'!
initializeWithOwner: aName expirationDate: anMonthOfYear andNumber:aNumber
	
	self checkHasLessThan20Digits: aNumber.
	self checkHasMoreThan12Digits: aNumber.
	self checkNameIsNotEmpty: aName.
	expirationDate := anMonthOfYear.
	cardNumber := aNumber.
	owner := aName.! !


!CreditCard methodsFor: 'Testing --Private--' stamp: 'D S 11/26/2020 13:59:37'!
checkHasLessThan20Digits: aNumber

	^ (aNumber > 9999999999999999999) ifTrue: [self error: self class errorDescriptionInvalidNumberMoreDigits]! !

!CreditCard methodsFor: 'Testing --Private--' stamp: 'D S 11/26/2020 13:59:56'!
checkHasMoreThan12Digits: aNumber

	^ (aNumber < 1000000000000) ifTrue: [self error: self class errorDescriptionInvalidNumberLessDigits]! !

!CreditCard methodsFor: 'Testing --Private--' stamp: 'D S 11/26/2020 14:00:10'!
checkNameIsNotEmpty: aName

	^ (aName = '') ifTrue:[self error: self class errorDescriptionEmptyName]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'D S 11/24/2020 19:10:38'!
errorDescriptionEmptyName

	^'Owner name cannot be empty'! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'D S 11/24/2020 19:14:50'!
errorDescriptionInvalidNumberLessDigits

	^'Invalid Number: Less than 13 digits'! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'D S 11/24/2020 19:16:46'!
errorDescriptionInvalidNumberMoreDigits

	^'Invalid Number: More than 19 digits'! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'D S 11/24/2020 21:58:37'!
withOwner: aName expirationDate: anMonthOfYear andNumber: aNumber

	^self new initializeWithOwner: aName expirationDate: anMonthOfYear andNumber:aNumber.
! !


!classDefinition: #MerchantProcessor category: 'TusLibros'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'D S 11/26/2020 14:12:49'!
extractFromACreditCardWithNumber: aNumber WhichExpiresIn: aGregorianMonthOfYear WithOwner: aName AnAmountOf: anAmount.

	^self subclassResponsibility.! !


!classDefinition: #MerchantProcessorNotEnoughtCredit category: 'TusLibros'!
MerchantProcessor subclass: #MerchantProcessorNotEnoughtCredit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorNotEnoughtCredit methodsFor: 'as yet unclassified' stamp: 'D S 11/26/2020 14:12:58'!
extractFromACreditCardWithNumber: aNumber WhichExpiresIn: aGregorianMonthOfYear WithOwner: aName AnAmountOf: anAmount.
	self error: self class errorDescriptionNotEnoughCredit.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorNotEnoughtCredit class' category: 'TusLibros'!
MerchantProcessorNotEnoughtCredit class
	instanceVariableNames: ''!

!MerchantProcessorNotEnoughtCredit class methodsFor: 'as yet unclassified' stamp: 'D S 11/26/2020 08:54:57'!
errorDescriptionNotEnoughCredit

	^'1|La tarjeta no tiene credito suficiente'! !


!classDefinition: #MerchantProcessorStolenCard category: 'TusLibros'!
MerchantProcessor subclass: #MerchantProcessorStolenCard
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorStolenCard methodsFor: 'as yet unclassified' stamp: 'D S 11/26/2020 14:13:04'!
extractFromACreditCardWithNumber: aNumber WhichExpiresIn: aGregorianMonthOfYear WithOwner: aName AnAmountOf: anAmount.
	self error: self class errorDescriptionStolenCard.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorStolenCard class' category: 'TusLibros'!
MerchantProcessorStolenCard class
	instanceVariableNames: ''!

!MerchantProcessorStolenCard class methodsFor: 'as yet unclassified' stamp: 'D S 11/26/2020 08:56:42'!
errorDescriptionStolenCard

	^'1|Esta tarjeta fue robada'! !


!classDefinition: #MerchantProcessorValidCard category: 'TusLibros'!
MerchantProcessor subclass: #MerchantProcessorValidCard
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorValidCard methodsFor: 'as yet unclassified' stamp: 'D S 11/26/2020 14:13:13'!
extractFromACreditCardWithNumber: aNumber WhichExpiresIn: aGregorianMonthOfYear WithOwner: aName AnAmountOf: anAmount.! !
