!classDefinition: #CartTest category: 'Tus Libros.com'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus Libros.com'!


!CartTest methodsFor: 'cart-tests' stamp: 'DB 11/18/2020 19:54:31'!
test01EmptyCartHasNoItems

	| cart |
	cart := Cart new.
	
	self assert: 0 equals: cart amountOfItems.! !

!CartTest methodsFor: 'cart-tests' stamp: 'db 11/19/2020 19:21:39'!
test02ACartWithOneItemHasOneItem

	| cart aCatalog |
	aCatalog := Set new.
	aCatalog add: '978-3-9820137-0-1'.
	cart := Cart with: aCatalog.
	
	cart add:  '978-3-9820137-0-1'.
	self assert: 1 equals: (cart amountOfItems).
	! !

!CartTest methodsFor: 'cart-tests' stamp: 'db 11/19/2020 19:21:44'!
test03ACartWithMoreThanOneItemHasTheCorrectAmountOfItems

	| cart aCatalog |
	aCatalog := Set new.
	aCatalog add: '978-3-9820137-0-1'.
	aCatalog add: '978-3-9820137-0-2'.
	cart := Cart with: aCatalog.
	
	cart add: '978-3-9820137-0-1' amount: 5.
	cart add: '978-3-9820137-0-2' amount: 3.
	
	self assert: 8 equals: (cart amountOfItems).! !

!CartTest methodsFor: 'cart-tests' stamp: 'db 11/19/2020 19:21:48'!
test04CannotAddABookWithNonValidISBN

	| cart aCatalog |
	aCatalog := Set new.
	aCatalog add: '978-3-9820137-0-2'.
	cart := Cart with: aCatalog.
	
	self  should: [cart add: '978-3-9820137-X-X' amount: 5.] 
		 raise: Error 
		 withMessageText: Cart ISBNDoesntBelongToCatalogErrorDescription.
	! !

!CartTest methodsFor: 'cart-tests' stamp: 'db 11/19/2020 19:21:51'!
test05CannotAddABookWithNegativeOrZeroAmount

	| aCatalog cart |
	aCatalog := Set new.
	aCatalog add: '978-3-9820137-0-2'.
	cart := Cart with: aCatalog.
	
	self  should: [cart add: '978-3-9820137-0-1' amount: -5.] 
		 raise: Error 
		 withMessageText: Cart doesntAllowNegativeOrZeroAmountToBeAddedErrorDescription.! !

!CartTest methodsFor: 'cart-tests' stamp: 'DB 11/18/2020 20:01:45'!
test06ListItemsOfEmptyCartReturnsAnEmptyList

	| cart items |
	cart := Cart new.
	
	items := cart listItems.
	
	self assert: items isEmpty.! !

!CartTest methodsFor: 'cart-tests' stamp: 'db 11/19/2020 19:21:59'!
test07ListItemsOfACartWithOneItemReturnsAListWithAllBooksAdded

	| cart aCatalog items |
	aCatalog := Set new.
	aCatalog add: '978-3-9820137-0-1'.
	cart := Cart with: aCatalog.
	
	cart add: '978-3-9820137-0-1'.
	
	items := cart listItems.
	
	self assert: 1 equals: items size.
	self assert: items includes: '978-3-9820137-0-1'.
	self assert: 1 equals: (items occurrencesOf: '978-3-9820137-0-1').! !

!CartTest methodsFor: 'cart-tests' stamp: 'db 11/19/2020 19:22:02'!
test08ListItemsOfACartWithMoreThanOneItemReturnsAListWithAllBooksAdded

	| cart aCatalog items |
	aCatalog := Set new.
	aCatalog add: '978-3-9820137-0-1'.
	aCatalog add: '978-3-9820137-0-2'.
	aCatalog add: '978-3-9820137-0-3'.
	cart := Cart with: aCatalog.
	cart add: '978-3-9820137-0-1' amount: 2.
	cart add: '978-3-9820137-0-2' amount: 3.
	cart add: '978-3-9820137-0-3' amount: 5.
	
	items := cart listItems.
	
	self assert: 10 equals: items size.
	self assert: items includes: '978-3-9820137-0-1'.
	self assert: 2 equals: (items occurrencesOf: '978-3-9820137-0-1').
	self assert: items includes: '978-3-9820137-0-2' .
	self assert: 3 equals: (items occurrencesOf: '978-3-9820137-0-2').
	self assert: items includes: '978-3-9820137-0-3'.
	self assert: 5 equals: (items occurrencesOf: '978-3-9820137-0-3').
	
	
	
	! !


!classDefinition: #CashierTest category: 'Tus Libros.com'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'defaultCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus Libros.com'!

!CashierTest methodsFor: 'testing' stamp: 'db 11/24/2020 18:13:25'!
setUp

	defaultCatalog := Dictionary new.
	defaultCatalog at: '978-3-9820137-0-2' put: 100.
	defaultCatalog at: '978-3-9820137-0-3' put: 45.
	! !

!CashierTest methodsFor: 'testing' stamp: 'db 11/23/2020 16:57:01'!
test01CannotCheckoutWithAnEmptyCart
	
	| cart cashier aCreditCard |
	cart := Cart new.
	cashier := Cashier new.
	
	aCreditCard := CreditCard with: 4545787845458989 expirationMonth: 12  expirationYear: 2050 creditCardOwner: 'juan de los palotes'.
	
	self  should: [cashier checkout: cart creditCard: aCreditCard] 
		 raise: Error 
		 withMessageText: Cashier cannotCheckoutWithAnEmptyCartErrorDescription.
	! !

!CashierTest methodsFor: 'testing' stamp: 'db 11/24/2020 18:14:58'!
test02CheckoutCartWithOneItem
	
	| cart cashier catalog aCreditCard totalAmount mp |
	
	catalog := Dictionary new.
	catalog at: '978-3-9820137-0-2' put: 100.
	
	cart := Cart with: catalog.
	cart add: '978-3-9820137-0-2'.
	
	mp := MerchantProcessorSimulator with: ''.
	
	cashier := Cashier with: mp.
	
	aCreditCard := CreditCard with: 3445454545454545 expirationMonth: 10 expirationYear: 2030  creditCardOwner: 'Juan de los palotes'.
	totalAmount := cashier checkout: cart creditCard: aCreditCard.
	
	self assert: 100 equals: totalAmount
	
	! !

!CashierTest methodsFor: 'testing' stamp: 'db 11/24/2020 18:15:17'!
test03CheckoutMoreThanOneItem
	
	| cart cashier aCreditCard totalAmount mp |
	
	cart := Cart with: defaultCatalog.
	cart add: '978-3-9820137-0-2'.
	cart add: '978-3-9820137-0-3'.

	mp := MerchantProcessorSimulator with: ''.
	
	cashier := Cashier with: mp.
	aCreditCard := CreditCard with: 3445454545454545 expirationMonth: 10 expirationYear: 2030  creditCardOwner: 'Juan de los palotes'.
	totalAmount := cashier checkout: cart creditCard: aCreditCard.
	
	self assert: 145 equals: totalAmount
	
	! !

!CashierTest methodsFor: 'testing' stamp: 'db 11/24/2020 18:14:30'!
test04CreditCardShouldHaveANonExpiredExpirationDate
	
	| cart cashier expiredCC |
	
	cart := Cart with: defaultCatalog.
	cart add: '978-3-9820137-0-2'.
	cart add: '978-3-9820137-0-3'.

	cashier := Cashier new.
	expiredCC := CreditCard with: 3445454545454545 expirationMonth: 10 expirationYear: 2020  creditCardOwner: 'Juan de los palotes'.
	
	self  should: [cashier checkout: cart creditCard: expiredCC.] 
		 raise: Error 
		 withMessageText: Cashier creditCardExpiredErrorDescription.
	
	
	! !

!CashierTest methodsFor: 'testing' stamp: 'db 11/24/2020 18:21:18'!
test05WhenMPThrowsAnErrorThePurchaseDoesntGetCarriedOut

	"Ante un error del mp el cajero no realizo la venta"
	
	| cart mp cashier expiredCC receipt|
	
	cart := Cart with: defaultCatalog.
	cart add: '978-3-9820137-0-2'.
	cart add: '978-3-9820137-0-3'.
	
	mp := MerchantProcessorSimulator with: 'insuficient amount'.
	
	cashier := Cashier with: mp.
	expiredCC := CreditCard with: 3445454545454545 expirationMonth: 10 expirationYear: 2050  creditCardOwner: 'Juan de los palotes'.
	
	self should: [ receipt := cashier checkout: cart creditCard: expiredCC.] 
		 raise: Error 
		 withMessageText: 'insuficient amount'.
		
	self assert: receipt isNil .
	
	
	! !

!CashierTest methodsFor: 'testing' stamp: 'db 11/24/2020 18:12:09'!
test06SucessfulCheckoutWhenMPDoesntThrownsAnError

	"Ante un error del mp el cajero no realizo la venta"
	
	| cart mp cashier expiredCC receipt |
	
	cart := Cart with: defaultCatalog.
	cart add: '978-3-9820137-0-2'.
	cart add: '978-3-9820137-0-3'.
	
	mp := MerchantProcessorSimulator with: ''.
	
	cashier := Cashier with: mp.
	expiredCC := CreditCard with: 3445454545454545 expirationMonth: 10 expirationYear: 2050  creditCardOwner: 'Juan de los palotes'.
	
	receipt := cashier checkout: cart creditCard: expiredCC.

	self assert: 145 equals: receipt .
	
	
	! !

!CashierTest methodsFor: 'testing' stamp: 'db 11/23/2020 17:09:04'!
_testxxx
	
	| cart cashier |
	cart := Cart new.
	cashier := Cashier new.
	
	"
	Catalogo -> Carrito -> Cashier. 
	
	expirationDate := Date year: aYear month: aMonth day: 1.
	expirationDate > Date today ifFalse: [^self class signalExpiredCreditCard ].
	
	creditCard := CreditCard Number: 121313123 expiration: 122025 owner: 'Juan de los palotes'.
	
	- Validar 16 dígitos.
	- Owner not empty
	- No validar fecha de expiración. Lo valida el cashier.
	
	cashier checkout: cart with: creditCard.
	
	Return ticket or Amount.
	
	carrito vacio
	checkout robada
	checkout sin fondo
	 
	
	"
	
	"
	cashier checkout: cart creditCardNumber: '13213' creditCardExpiration: '122023' creditCardOwner: 'J kennedy'.
	
	
	Merchant Processor:
		- Tarjeta Robada
		- Tiene crédito.
		
	Simular la cara interna de la interfaz.

	"
	
	! !


!classDefinition: #CreditCartTest category: 'Tus Libros.com'!
TestCase subclass: #CreditCartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus Libros.com'!

!CreditCartTest methodsFor: 'testing' stamp: 'db 11/23/2020 16:31:27'!
test01CreditCardNumberShouldHave16digitsIfNotAnErrorShouldBeRaised

	| creditCard |
	self  should: [CreditCard with: 1234 expirationMonth: 45 expirationYear: 8888 creditCardOwner: 'owner' ] 
		 raise: Error 
		 withMessageText: CreditCard creditCardNumberInvalidLengthNumberErrorDescription.
	 
	creditCard := CreditCard with: 4545123455647789 expirationMonth: 12 expirationYear: 2025 creditCardOwner: 'owner'.
	self assert: 4545123455647789 equals: (creditCard PAN).
	self assert: 16 equals: (creditCard PAN asString size).
	
	
	! !

!CreditCartTest methodsFor: 'testing' stamp: 'db 11/23/2020 16:31:27'!
test02CreditCardNumberShouldOnlyHaveNumbers

	self  should: [CreditCard with: '789**'  expirationMonth: 10 expirationYear: 3000 creditCardOwner: 'owner' ] 
		 raise: Error 
		 withMessageText: CreditCard creditCardNumberShouldOnlyHaveNumbersErrorDescription
		
	 
	! !

!CreditCartTest methodsFor: 'testing' stamp: 'db 11/24/2020 18:03:41'!
test03ExpirationDateShouldHaveTwoDigitsForMonthAndFourDigitsForYear

	self validateExpirationDate: 456 expirationYear: 8888 message: CreditCard expirationMonthShoudHaveTwoDigitsErrorDescription.
	self validateExpirationDate: 12 expirationYear: 79879 message: CreditCard expirationYearShouldHaveFourDigitsErrorDescription.
		
	 
	! !

!CreditCartTest methodsFor: 'testing' stamp: 'db 11/24/2020 18:04:17'!
test04ExpirationDateShouldHaveAValidMonth


	self validateExpirationDate: 13 expirationYear: 8888 message: CreditCard nonValidExpirationMonthErrorDescription.
	self validateExpirationDate: -01 expirationYear: 8888 message: CreditCard nonValidExpirationMonthErrorDescription.
		! !

!CreditCartTest methodsFor: 'testing' stamp: 'db 11/23/2020 16:32:34'!
test06CreditCardOwnerCannotBeEmpty


	self  should: [CreditCard with: 4545124512456598 expirationMonth: 10 expirationYear: 2050 creditCardOwner: ''] 
		 raise: Error 
		 withMessageText: CreditCard creditCardOwnerCannotBeEmptyErrorDescription.
		! !

!CreditCartTest methodsFor: 'testing' stamp: 'db 11/24/2020 23:54:25'!
test07CreditCardOwnerNameCantBeLongerThan30Letters

	self  should: [CreditCard with: 4545124512456598 expirationMonth: 10 expirationYear: 2050 creditCardOwner: 'dfafasdfadfadsfasdfassdfadsfafas dasdfad'] 
		 raise: Error 
		 withMessageText: CreditCard creditCardOwnerNameCantBeLongerThanThirtyErrorDescription.
		! !

!CreditCartTest methodsFor: 'testing' stamp: 'db 11/24/2020 18:02:18'!
validateExpirationDate: aMonth expirationYear: aYear message: aMessage

	self  should: [CreditCard with: 4545124512456598 expirationMonth: aMonth expirationYear: aYear creditCardOwner: 'owner' ] 
		 raise: Error 
		 withMessageText: aMessage.
		! !


!classDefinition: #Cart category: 'Tus Libros.com'!
Object subclass: #Cart
	instanceVariableNames: 'items catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus Libros.com'!

!Cart methodsFor: 'testing' stamp: 'DB 11/16/2020 19:11:13'!
amountOfItems
	^items size! !

!Cart methodsFor: 'testing' stamp: 'db 11/23/2020 16:59:56'!
isEmpty
	^items isEmpty ! !

!Cart methodsFor: 'testing' stamp: 'db 11/23/2020 16:42:03'!
totalAmountToPay 

	| totalAmount |
	
	totalAmount := 0.
	
	items sum:  [ :anItem | totalAmount := totalAmount + catalog at: anItem].
	
	^totalAmount.! !


!Cart methodsFor: 'operations' stamp: 'DB 11/16/2020 19:12:45'!
add: aBook 
	self add: aBook amount: 1
	! !

!Cart methodsFor: 'operations' stamp: 'DB 11/18/2020 19:44:15'!
add: aBook amount: anAmount 

	self assertCanAdd: aBook amount: anAmount.

	items add: aBook withOccurrences: anAmount! !

!Cart methodsFor: 'operations' stamp: 'DB 11/18/2020 19:36:29'!
listItems
	^items copy! !


!Cart methodsFor: 'operations private' stamp: 'db 11/19/2020 19:41:19'!
assertCanAdd: aBook amount: anAmount

	(anAmount <= 0) ifTrue: [^self class signalDoesntAllowNegativeOrZeroAmountToBeAdded ].
	(catalog includesKey: aBook) ifFalse: [^self class signalISBNDoesntBelongToCatalog].

! !


!Cart methodsFor: 'initialization' stamp: 'db 11/19/2020 19:21:24'!
initialize
	catalog := Set new.
	items := Bag new.! !

!Cart methodsFor: 'initialization' stamp: 'DB 11/18/2020 19:37:36'!
initializeWith: aCatalog
	catalog := aCatalog.
	items := Bag new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'Tus Libros.com'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'DB 11/17/2020 18:17:47'!
ISBNDoesntBelongToCatalogErrorDescription
	^'ISBN doesnt belong to catalog'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'db 11/19/2020 18:54:56'!
cannotCheckoutWithAnEmptyCart
	self shouldBeImplemented.! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'DB 11/17/2020 18:31:31'!
doesntAllowNegativeOrZeroAmountToBeAddedErrorDescription
	^'doesnt allow negative or zero amount to be added'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'DB 11/17/2020 18:32:01'!
signalDoesntAllowNegativeOrZeroAmountToBeAdded
	self error: self doesntAllowNegativeOrZeroAmountToBeAddedErrorDescription ! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'DB 11/17/2020 18:19:27'!
signalISBNDoesntBelongToCatalog
	self error: self ISBNDoesntBelongToCatalogErrorDescription ! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'DB 11/18/2020 19:37:18'!
with: aCatalog
	^self new initializeWith: aCatalog ! !


!classDefinition: #Cashier category: 'Tus Libros.com'!
Object subclass: #Cashier
	instanceVariableNames: 'prices merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus Libros.com'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'db 11/24/2020 18:19:17'!
checkout: aCart creditCard: aCreditCard 

	| expirationDate |
	aCart isEmpty ifTrue: [^self class signalCannotCheckoutWithAnEmptyCart].
	
	expirationDate := Date year: (aCreditCard expirationYear ) month: (aCreditCard expirationMonth) day: 1.
	expirationDate < (Date today) ifTrue: [^self class signalCreditCardExpired ].
	
	merchantProcessor debit: aCart  totalAmountToPay from: aCreditCard.

	"[merchantProcessor debit: aCart  totalAmountToPay from: aCreditCard] on: Error do: [^self class siganlMerchantProcessorFail]."
	
	^aCart totalAmountToPay 
	
	
	 ! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'db 11/23/2020 17:43:21'!
initializeWith: aMerchantProcessor	
	merchantProcessor := aMerchantProcessor .
	 ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'Tus Libros.com'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'db 11/19/2020 18:58:30'!
cannotCheckoutWithAnEmptyCartErrorDescription
	^'cannot checkout with an empty cart'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'db 11/23/2020 16:55:37'!
creditCardExpiredErrorDescription
	^'credit card expired'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'db 11/23/2020 17:46:02'!
merchantProcessorFailErrorDescription
	^'merchant processor fail'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'db 11/23/2020 17:46:35'!
siganlMerchantProcessorFail
	^self error: self merchantProcessorFailErrorDescription ! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'db 11/19/2020 18:58:34'!
signalCannotCheckoutWithAnEmptyCart
	self error: self cannotCheckoutWithAnEmptyCartErrorDescription .! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'db 11/23/2020 16:56:06'!
signalCreditCardExpired
	^self error: self creditCardExpiredErrorDescription ! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'db 11/23/2020 17:45:16'!
with: aMerchantProcesor
	^Cashier new initializeWith: aMerchantProcesor ! !


!classDefinition: #CreditCard category: 'Tus Libros.com'!
Object subclass: #CreditCard
	instanceVariableNames: 'pan expirationMonth expirationYear creditCardOwner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus Libros.com'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'db 11/23/2020 15:35:34'!
PAN
	^pan! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'db 11/23/2020 16:48:27'!
expirationMonth
	^expirationMonth 

	! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'db 11/23/2020 16:48:37'!
expirationYear
	^expirationYear

	! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'db 11/24/2020 23:58:05'!
initializeWith: aPan expirationMonth: aMonth expirationYear: aYear creditCardOwner: aCreditCardOwner 
	
	
	(aPan isNumber) ifFalse: [^self class signalCreditCardNumberShouldOnlyHaveNumbers ].
	(aPan asString size = 16) ifFalse: [^self class signalCreditCardNumberInvalidLengthNumber].
	
	(aMonth asString size = 2) ifFalse: [^self class signalExpirationMonthShoudHaveTwoDigits ].
	(aMonth between: 1 and: 12) ifFalse: [^self class signalNonValidExpirationMonth ].
	
	(aYear asString size = 4) ifFalse: [^self class signalExpirationYearShoudHaveFourDigits ].
	
	aCreditCardOwner isEmpty ifTrue: [^self class signalCreditCardOwnerCannotBeEmpty ].
	
	aCreditCardOwner size <= 30 ifFalse: [^self class signalCreditCardOwnerNameCantBeLongerThanThirty ].
	
	pan := aPan.
	expirationMonth := aMonth. 
	expirationYear := aYear.
	creditCardOwner := aCreditCardOwner.
	
	GregorianMonthOfYear year: 2020 month: 12 
	

	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'Tus Libros.com'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'db 11/23/2020 15:25:33'!
creditCardNumberInvalidLengthNumberErrorDescription
	^'Invalid length number'! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'db 11/23/2020 15:42:14'!
creditCardNumberShouldOnlyHaveNumbersErrorDescription
	^'credit card number should only have numbers'! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'db 11/23/2020 16:25:47'!
creditCardOwnerCannotBeEmptyErrorDescription
	^'credit card owner cannot be empty'! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'db 11/23/2020 16:36:13'!
creditCardOwnerNameCantBeLongerThanThirtyErrorDescription
	^'credit card owner name cant be longer than thirty '! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'db 11/23/2020 15:56:05'!
expirationMonthShoudHaveTwoDigitsErrorDescription
	^'expiration month should have two digits'! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'db 11/23/2020 16:01:23'!
expirationYearShouldHaveFourDigitsErrorDescription
	^'expiration year should have four digits'! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'db 11/23/2020 16:15:14'!
expiredCreditCardErrorDescription
	^'expired credit card'! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'db 11/23/2020 16:06:46'!
nonValidExpirationMonthErrorDescription
	^'month should be between 1 and 12'! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'db 11/23/2020 15:25:59'!
signalCreditCardNumberInvalidLengthNumber

	^self error: self creditCardNumberInvalidLengthNumberErrorDescription ! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'db 11/23/2020 15:43:03'!
signalCreditCardNumberShouldOnlyHaveNumbers
	^self error: self creditCardNumberShouldOnlyHaveNumbersErrorDescription ! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'db 11/23/2020 16:25:38'!
signalCreditCardOwnerCannotBeEmpty
	^self error: self creditCardOwnerCannotBeEmptyErrorDescription ! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'db 11/23/2020 16:36:42'!
signalCreditCardOwnerNameCantBeLongerThanThirty
	^self error: self creditCardOwnerNameCantBeLongerThanThirtyErrorDescription ! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'db 11/23/2020 15:57:26'!
signalExpirationMonthShoudHaveTwoDigits
	^self error: self expirationMonthShoudHaveTwoDigitsErrorDescription ! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'db 11/23/2020 16:01:23'!
signalExpirationYearShoudHaveFourDigits
	^self error: self expirationYearShouldHaveFourDigitsErrorDescription ! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'db 11/23/2020 16:15:37'!
signalExpiredCreditCard
	^self error: self expiredCreditCardErrorDescription ! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'db 11/23/2020 16:07:17'!
signalNonValidExpirationMonth
	^self error: self nonValidExpirationMonthErrorDescription ! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'db 11/23/2020 16:31:58'!
with: aPan expirationMonth: aMonth expirationYear: aYear creditCardOwner: aCreditCardOwner 
	
	^CreditCard new initializeWith: aPan expirationMonth: aMonth expirationYear: aYear creditCardOwner: aCreditCardOwner.! !


!classDefinition: #MerchantProcessorSimulator category: 'Tus Libros.com'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'exception'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus Libros.com'!

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'db 11/23/2020 17:41:11'!
debit: anAmount from: aCreditCard

	exception notEmpty ifTrue: [^self error: exception].
! !

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'db 11/23/2020 17:23:26'!
initializeWith: anException
	exception := anException 
	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: 'Tus Libros.com'!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'as yet unclassified' stamp: 'db 11/23/2020 17:21:02'!
with: anException
	^MerchantProcessorSimulator new initializeWith: anException 
	! !
