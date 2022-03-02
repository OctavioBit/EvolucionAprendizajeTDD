!classDefinition: #CreditCardTest category: 'Ejercicio-20-Tus-Libros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!CreditCardTest methodsFor: 'tests' stamp: 'LH 11/23/2020 18:34:52'!
test01ACreditCardCanBeNotExpired

	|aCreditCard|
	
	aCreditCard := self validCreditCardWithTheExpirationDate: self validMonthOfYear.
	
	self deny: aCreditCard isExpired.

	! !

!CreditCardTest methodsFor: 'tests' stamp: 'LH 11/23/2020 18:22:06'!
test02ACreditCardWithExpirationDatingThisMonthAndYearIsExpired
	|aCreditCard|
	
	aCreditCard := self validCreditCardWithTheExpirationDate: GregorianMonthOfYear current.
	
	self assert: aCreditCard isExpired.

	! !

!CreditCardTest methodsFor: 'tests' stamp: 'LH 11/23/2020 18:28:50'!
test03ACreditCardWithExpirationDatedInThePastIsExpired
	|aCreditCard|
	
	aCreditCard := self validCreditCardWithTheExpirationDate: GregorianMonthOfYear current previous.
	
	self assert: aCreditCard isExpired.

	! !

!CreditCardTest methodsFor: 'tests' stamp: 'LH 11/23/2020 18:29:51'!
test04CreditCarNumberCantHaveAnythingBut16Symbols
	
	self assertInvalidCardNumberErrorWithNumber: '00000000000000000'.
	self assertInvalidCardNumberErrorWithNumber: '000000000000000'.
	! !

!CreditCardTest methodsFor: 'tests' stamp: 'LH 11/23/2020 18:29:57'!
test05CreditCarNumberCantHaveAnythingButNumbers
	
	self assertInvalidCardNumberErrorWithNumber: '000000000000000O'.
	
	! !

!CreditCardTest methodsFor: 'tests' stamp: 'LH 11/23/2020 18:35:04'!
test06TheNameOfACreditCardOwnerCanNotBeBlank
	
	self should: [CreditCard withNumber: '0000000000000000'
		expirationDate: self validMonthOfYear
		belongingTo: ''.]
		raise: Error
		withMessageText: CreditCard invalidCreditCardOwnerName.
	
	! !

!CreditCardTest methodsFor: 'tests' stamp: 'LH 11/23/2020 18:34:35'!
validMonthOfYear

	^GregorianMonthOfYear current next
	! !


!CreditCardTest methodsFor: 'util' stamp: 'LH 11/23/2020 18:35:22'!
assertInvalidCardNumberErrorWithNumber: aCCNumber 
	
	self should: [CreditCard         withNumber: aCCNumber
							expirationDate: self validMonthOfYear 
							belongingTo: 'Juan Pablo'.]
		raise: Error
		withMessageText: CreditCard invalidCreditCardNumber.
	
	! !

!CreditCardTest methodsFor: 'util' stamp: 'IO 11/22/2020 16:41:27'!
validCreditCardWithTheExpirationDate: anExpirationDate
	
	 ^CreditCard  withNumber: '0000000000000000' 
				expirationDate: anExpirationDate 
				belongingTo: 'Juan Pablo'.
	


	! !


!classDefinition: #ShoppingCartTest category: 'Ejercicio-20-Tus-Libros'!
TestCase subclass: #ShoppingCartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!ShoppingCartTest methodsFor: 'tests' stamp: 'IO 11/22/2020 16:47:09'!
test01NewCartIsEmpty
	|aCart|
	
	aCart := self newShoppingCartWithAProduct.
	
	self assert: 0 equals: aCart listCart size.! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'IO 11/22/2020 16:47:16'!
test02CanAddABookToACart
	|aCart|
	
	aCart := self newShoppingCartWithAProduct.
	aCart add: '0-7645-2641-3'.
	
	self assert: 1 equals: aCart listCart size.
	self assert: (aCart listCart includes: '0-7645-2641-3').! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'LH 11/23/2020 18:44:36'!
test03CanAddManyBooksToACart
	|aCart|
	
	aCart := self newShoppingCartWithTwoProducts .
	aCart add: '0-7645-2641-3'.
	aCart add: '0-7645-2641-4'.
	
	self assert: 2 equals: aCart listCart size.
	self assert: (aCart listCart includes: '0-7645-2641-3').
	self assert: (aCart listCart includes: '0-7645-2641-4').! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'IO 11/22/2020 16:47:43'!
test04CanMoreThanOneFromTheSameBookToACart
	|aCart|
	
	aCart := self newShoppingCartWithAProduct.
	aCart add: '0-7645-2641-3' withQuantity: 2.
	
	self assert: 2 equals: aCart listCart size.
	
	aCart add: '0-7645-2641-3'.
	
	self assert: 3 equals: aCart listCart size.! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'LH 11/23/2020 17:49:29'!
test05CanNotAddABookWithInvalidISBN
	|aCart|
	
	aCart := ShoppingCart withCatalogue: (Dictionary new).
	
	self should: [aCart add: '0-7645-2641-3']
		raise: Error
		withMessageText: ShoppingCart invalidISBNErrorMessage.
	
! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'IO 11/22/2020 16:47:51'!
test06CanNotAdd0Books
	|aCart|
	
	aCart := self newShoppingCartWithAProduct.
	
	self should: [aCart add: '0-7645-2641-3' withQuantity: 0]
		raise: Error
		withMessageText: ShoppingCart invalidQuantityErrorMessage.
	
! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'IO 11/22/2020 16:47:58'!
test07CanNotAddMinusBooks
	|aCart|
	
	aCart := self newShoppingCartWithAProduct.
	
	self should: [aCart add: '0-7645-2641-3' withQuantity: -1]
		raise: Error
		withMessageText: ShoppingCart invalidQuantityErrorMessage.
	
! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'IO 11/22/2020 16:48:02'!
test08CanNotAddNotWholeBooks
	|aCart|
	
	aCart := self newShoppingCartWithAProduct.
	
	self should: [aCart add: '0-7645-2641-3' withQuantity: 1.5]
		raise: Error
		withMessageText: ShoppingCart invalidQuantityErrorMessage.
	
! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'LH 11/23/2020 18:44:54'!
test09CannotEditCartList
	| aCart list |
	
	
	aCart := self newShoppingCartWithTwoProducts.
	aCart add: '0-7645-2641-3'.

	
	list := aCart listCart.
	list add: '0-7645-2641-4'.

	self assert: 1 equals: aCart listCart size.

	self assert: (aCart listCart includes: '0-7645-2641-3').
	self deny: (aCart listCart includes: '0-7645-2641-4').! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'LH 11/23/2020 18:40:03'!
test10TheValueOfAnEmptyCartsProductsIs0
	| aCart |
	
	aCart := ShoppingCart withCatalogue: (Dictionary new).
	self assert: 0 equals: aCart valueOfProducts.! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'LH 11/23/2020 18:40:32'!
test11TheValueOfProductsOfACartWithOneProductShouldBeThatProduct
	| aCart |
	
	aCart := self newShoppingCartWithAProduct .	aCart add: '0-7645-2641-3'.
	
	self assert: 100 equals: aCart valueOfProducts.! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'LH 11/23/2020 18:45:15'!
test12TheValueOfProductsOfACartWithManyProductShouldBeTheirSum
	| aCart |
	
	aCart := self newShoppingCartWithTwoProducts .	aCart add: '0-7645-2641-3' withQuantity: 2.
	aCart add: '0-7645-2641-4' withQuantity: 2.
	
	self assert: 300 equals: aCart valueOfProducts.! !


!ShoppingCartTest methodsFor: 'util' stamp: 'LH 11/23/2020 17:47:05'!
newShoppingCartWithAProduct
	
	^ShoppingCart withCatalogue: (Dictionary newFromPairs: #('0-7645-2641-3' 100)).
! !

!ShoppingCartTest methodsFor: 'util' stamp: 'LH 11/23/2020 18:43:51'!
newShoppingCartWithTwoProducts
	
	^ShoppingCart withCatalogue: (Dictionary newFromPairs: #('0-7645-2641-3' 100 '0-7645-2641-4' 50))
! !


!classDefinition: #ShoppingCashierTest category: 'Ejercicio-20-Tus-Libros'!
TestCase subclass: #ShoppingCashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!ShoppingCashierTest methodsFor: 'tests' stamp: 'LH 11/23/2020 19:01:56'!
test01AnEmptyCartCannotBeCheckedOut
	|aCashier aCart aCreditCard|
	
	aCart := ShoppingCart withCatalogue: Dictionary new.
	aCreditCard := CreditCard withNumber: '0000000000000000' expirationDate: self validDate belongingTo: 'Juan Pablo'. 
	
	aCashier := ShoppingCashier withMerchanProcessor: NullMerchantProcessor new.
	
	self should: [aCashier checkOut: aCart withCreditCard: aCreditCard]
		raise: Error
		withMessageText: ShoppingCashier invalidCartErrorMessage.! !

!ShoppingCashierTest methodsFor: 'tests' stamp: 'LH 11/23/2020 19:03:39'!
test02ACartWith1BookWillCheckOutCorrectly
	|aCashier aCart aCreditCard|
	
	aCart := ShoppingCart withCatalogue: (Dictionary newFromPairs: #('0-7645-2641-3' 100)).
	aCart add: '0-7645-2641-3'.
	aCreditCard := CreditCard withNumber: '0000000000000000' expirationDate: self validDate belongingTo: 'Juan Pablo'.
	
	aCashier := ShoppingCashier withMerchanProcessor: NullMerchantProcessor new .
	
	self assert: 100 equals: (aCashier checkOut: aCart withCreditCard: aCreditCard).! !

!ShoppingCashierTest methodsFor: 'tests' stamp: 'LH 11/23/2020 19:03:47'!
test03ACartWithManyBooksWillCheckOutCorrectly
	|aCashier aCart aCreditCard|
	
	aCart := ShoppingCart withCatalogue: (Dictionary newFromPairs: #('0-7645-2641-3' 100 '0-7645-2641-4' 100)).
	aCart add: '0-7645-2641-3' withQuantity: 2.
	aCart add: '0-7645-2641-4'.
	aCreditCard := CreditCard withNumber: '0000000000000000' expirationDate: self validDate belongingTo: 'Juan Pablo'.
	
	aCashier := ShoppingCashier withMerchanProcessor: NullMerchantProcessor new .
	
	self assert: 300 equals: (aCashier checkOut: aCart withCreditCard: aCreditCard).! !

!ShoppingCashierTest methodsFor: 'tests' stamp: 'LH 11/23/2020 19:03:53'!
test04TheCardShouldNotBeExpired
	|aCashier aCart aCreditCard|
	
	aCart := ShoppingCart withCatalogue: (Dictionary newFromPairs: #('0-7645-2641-3' 100)).
	aCart add: '0-7645-2641-3'.
	aCreditCard := CreditCard withNumber: '0000000000000000' expirationDate: self invalidDate belongingTo: 'Juan Pablo'.
	
	aCashier := ShoppingCashier withMerchanProcessor: NullMerchantProcessor new .
	
	self should:[ aCashier checkOut: aCart withCreditCard: aCreditCard]
		raise: Error
		withMessageText: ShoppingCashier invalidCreditCard.
		! !

!ShoppingCashierTest methodsFor: 'tests' stamp: 'LH 11/23/2020 19:04:37'!
test05ACartShouldNotCheckoutIfMerchantProcessorFails

	|aCashier aCart aCreditCard|
	
	aCart := ShoppingCart withCatalogue: (Dictionary newFromPairs: #('0-7645-2641-3' 100 '0-7645-2641-4' 100)).
	aCart add: '0-7645-2641-3' withQuantity: 2.
	aCart add: '0-7645-2641-4'.
	aCreditCard := CreditCard withNumber: '0000000000000000' expirationDate: self validDate belongingTo: 'Juan Pablo'.

	aCashier := ShoppingCashier withMerchanProcessor: ErroredMerchantProcessor new.
	
	
	self should: [aCashier checkOut: aCart withCreditCard: aCreditCard]
		raise: Error
		withMessageText: ErroredMerchantProcessor dummyErrorMessage.
		
	
! !


!ShoppingCashierTest methodsFor: 'util' stamp: 'LH 11/23/2020 18:32:10'!
invalidDate

	^GregorianMonthOfYear current previous
		! !

!ShoppingCashierTest methodsFor: 'util' stamp: 'LH 11/23/2020 18:32:26'!
validDate

	^GregorianMonthOfYear current next
		! !


!classDefinition: #CreditCard category: 'Ejercicio-20-Tus-Libros'!
Object subclass: #CreditCard
	instanceVariableNames: 'creditCardNumber expirationDate nameOfOwner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!CreditCard methodsFor: 'initialization' stamp: 'IO 11/22/2020 16:26:39'!
initializeWithNumber: aCCNumber expirationDate: anExpirationDate belongingTo: aName 
	
	creditCardNumber := aCCNumber.
	expirationDate := anExpirationDate.
	nameOfOwner := aName.
! !


!CreditCard methodsFor: 'testing' stamp: 'LH 11/23/2020 18:31:29'!
isExpired
	"returns if this credit card is expired"
	
	^expirationDate < GregorianMonthOfYear current or: expirationDate = GregorianMonthOfYear current.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'Ejercicio-20-Tus-Libros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'IO 11/22/2020 18:12:01'!
withNumber: aCCNumber expirationDate: anExpirationDate belongingTo: aName 
	
	(
		(aCCNumber allSatisfy: [ :aDigit | aDigit isDigit ]) and:
		aCCNumber size = 16
	) ifFalse: [^self error: CreditCard invalidCreditCardNumber].

	(aName notEmpty) ifFalse: [^self error: CreditCard invalidCreditCardOwnerName].

	^self new initializeWithNumber: aCCNumber expirationDate: anExpirationDate belongingTo: aName.
! !


!CreditCard class methodsFor: 'error description' stamp: 'LH 11/21/2020 18:05:13'!
invalidCreditCardNumber
	^'CreditCard number can only have exactly 16 numbers and nothing else'! !

!CreditCard class methodsFor: 'error description' stamp: 'LH 11/21/2020 18:25:03'!
invalidCreditCardOwnerName
	^'The Name of the Owner can not be blank'! !


!classDefinition: #MerchantProcessor category: 'Ejercicio-20-Tus-Libros'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!MerchantProcessor methodsFor: 'debit operations' stamp: 'LH 11/23/2020 18:54:56'!
debitWith: aCreditCard for: anAmount	"simulator for an interaction with a Merchant Procesor"
	^self subclassResponsibility.
! !


!classDefinition: #ErroredMerchantProcessor category: 'Ejercicio-20-Tus-Libros'!
MerchantProcessor subclass: #ErroredMerchantProcessor
	instanceVariableNames: 'failure'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!ErroredMerchantProcessor methodsFor: 'debit operaions' stamp: 'LH 11/23/2020 18:55:39'!
debitWith: aCreditCard for: anAmount	"see superclass"
	^self error: ErroredMerchantProcessor dummyErrorMessage.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ErroredMerchantProcessor class' category: 'Ejercicio-20-Tus-Libros'!
ErroredMerchantProcessor class
	instanceVariableNames: ''!

!ErroredMerchantProcessor class methodsFor: 'as yet unclassified' stamp: 'IO 11/22/2020 17:33:01'!
dummyErrorMessage
	^'Merchant Processor error message'.
! !


!classDefinition: #NullMerchantProcessor category: 'Ejercicio-20-Tus-Libros'!
MerchantProcessor subclass: #NullMerchantProcessor
	instanceVariableNames: 'failure'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!NullMerchantProcessor methodsFor: 'debit operations' stamp: 'LH 11/23/2020 18:55:51'!
debitWith: aCreditCard for: anAmount
	"see superclass"
	^anAmount
! !


!classDefinition: #ShoppingCart category: 'Ejercicio-20-Tus-Libros'!
Object subclass: #ShoppingCart
	instanceVariableNames: 'books catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!ShoppingCart methodsFor: 'initialization' stamp: 'LH 11/23/2020 18:46:33'!
initializeWithCatalogue: aCatalgue 

	catalogue := aCatalgue.
	books := Bag new.! !


!ShoppingCart methodsFor: 'accessing' stamp: 'IO 11/22/2020 16:51:08'!
listCart
	^books copy.! !


!ShoppingCart methodsFor: 'adding' stamp: 'LH 11/23/2020 17:51:34'!
add: anISBN 

	^self add: anISBN withQuantity:1.! !

!ShoppingCart methodsFor: 'adding' stamp: 'LH 11/23/2020 18:57:03'!
add: anISBN withQuantity: aQuantity 	"adds a quantity of the ISBN's book to this cart"

	(aQuantity isInteger and: aQuantity > 0) ifFalse:[^self error: ShoppingCart invalidQuantityErrorMessage ].
	self validateISBNInCatalogue: anISBN.
	
	books add: anISBN withOccurrences: aQuantity.! !


!ShoppingCart methodsFor: 'validations' stamp: 'LH 11/23/2020 18:46:33'!
validateISBNInCatalogue: anISBN

	(catalogue includesKey: anISBN) ifFalse:[^self error: ShoppingCart invalidISBNErrorMessage].
	! !


!ShoppingCart methodsFor: 'product value' stamp: 'LH 11/23/2020 18:56:13'!
valueOfProducts
	"returns the accumulated value of all products in this cart"
	
	^books inject: 0 into: [:theSum :anISBN | theSum + catalogue at: anISBN]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCart class' category: 'Ejercicio-20-Tus-Libros'!
ShoppingCart class
	instanceVariableNames: ''!

!ShoppingCart class methodsFor: 'instance creation' stamp: 'LH 11/19/2020 18:04:15'!
withCatalogue: anOrderedCollection 

	^self new initializeWithCatalogue: anOrderedCollection ! !


!ShoppingCart class methodsFor: 'Error Description' stamp: 'LH 11/19/2020 18:05:22'!
invalidISBNErrorMessage
	^'ISBN is no in the Catalogue'! !

!ShoppingCart class methodsFor: 'Error Description' stamp: 'LH 11/19/2020 18:12:19'!
invalidQuantityErrorMessage
	^'Should only add a positive whole number of books'! !


!classDefinition: #ShoppingCashier category: 'Ejercicio-20-Tus-Libros'!
Object subclass: #ShoppingCashier
	instanceVariableNames: 'merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!ShoppingCashier methodsFor: 'checkOut' stamp: 'LH 11/23/2020 18:57:57'!
checkOut: aShoppingCart withCreditCard: aCreditCard
	"debits the credit card for the contents of the cart"
	
	aShoppingCart listCart size = 0 ifTrue: [^self error: ShoppingCashier invalidCartErrorMessage].
	aCreditCard isExpired ifTrue: [^self error: ShoppingCashier invalidCreditCard].
	
	^merchantProcessor debitWith: aCreditCard for: aShoppingCart valueOfProducts.! !


!ShoppingCashier methodsFor: 'initialization' stamp: 'LH 11/23/2020 19:03:13'!
initializeWithMerchanProcessor: aMerchantProcessor 

	merchantProcessor := aMerchantProcessor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCashier class' category: 'Ejercicio-20-Tus-Libros'!
ShoppingCashier class
	instanceVariableNames: ''!

!ShoppingCashier class methodsFor: 'error Description' stamp: 'LH 11/19/2020 18:54:33'!
invalidCartErrorMessage
	^'The Cart Has no Books'! !

!ShoppingCashier class methodsFor: 'error Description' stamp: 'LH 11/19/2020 20:52:32'!
invalidCreditCard
	^'invalid credit card information'! !


!ShoppingCashier class methodsFor: 'instance creation' stamp: 'LH 11/23/2020 19:02:50'!
withMerchanProcessor: aMerchantProcessor 

	^self new initializeWithMerchanProcessor: aMerchantProcessor ! !
