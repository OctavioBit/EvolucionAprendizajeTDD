!classDefinition: #TusLibrosExerciseTests category: 'Ejercicio-TusLibros.com'!
TestCase subclass: #TusLibrosExerciseTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-TusLibros.com'!

!TusLibrosExerciseTests methodsFor: 'as yet unclassified' stamp: 'LNB 11/19/2020 19:14:41'!
should: aBlockThatShouldFail raisingAnErrorAndAsserting: aVerificationBlock
	
	[aBlockThatShouldFail value. self fail.]
		on: Error
		do: aVerificationBlock.! !


!classDefinition: #CartTests category: 'Ejercicio-TusLibros.com'!
TusLibrosExerciseTests subclass: #CartTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-TusLibros.com'!

!CartTests methodsFor: 'cart tests' stamp: 'LNB 11/21/2020 18:30:33'!
test01NewCartShouldBeEmpty

	| cart catalogue |
	
	catalogue := Dictionary new.
	cart := Cart with: catalogue.
	
	self assert: cart isEmpty. ! !

!CartTests methodsFor: 'cart tests' stamp: 'LNB 11/21/2020 18:32:44'!
test02CartWithABookShouldNotBeEmpty

	| cart catalogue book |
	
	book := 'Book'.
	catalogue := Dictionary new.
	catalogue add: book -> 100.
		
	cart := Cart with: catalogue.
	
	cart add: 10 of: book.
	
	self assert: cart isEmpty not. ! !

!CartTests methodsFor: 'cart tests' stamp: 'LNB 11/21/2020 18:33:06'!
test03EmptyCartDoesntHasABook

	| cart catalogue book |
	
	book := 'Book'.
	catalogue := Dictionary new.
	catalogue add: book -> 100.
	
	cart := Cart with: catalogue.
	
	self assert: (cart has: book) not.! !

!CartTests methodsFor: 'cart tests' stamp: 'LNB 11/21/2020 18:33:22'!
test04CartShouldHaveAddedBook

	| cart catalogue book |
	
	book := 'Book'.
	catalogue := Dictionary new.
	catalogue add: book -> 100.
	
	cart := Cart with: catalogue.
	
	cart add: 10 of: book. 
	
	self assert: (cart has: book).! !

!CartTests methodsFor: 'cart tests' stamp: 'LNB 11/21/2020 18:34:10'!
test05CartShouldNotHaveNonAddedBook

	| cart catalogue historyBook mathBook |
	
	mathBook := 'MathBook'.
	historyBook := 'HistoryBook'.
	catalogue := Dictionary new.
	catalogue add: mathBook -> 100.
	catalogue add: historyBook -> 100.
	
	cart := Cart with: catalogue.
	
	cart add: 10 of: historyBook. 
	
	self assert: (cart has: mathBook) not.
	! !

!CartTests methodsFor: 'cart tests' stamp: 'LNB 11/21/2020 18:34:33'!
test06CartShouldAnswerQuantityOfAnAddedBook

	| cart catalogue historyBook mathBook|
	
	historyBook := 'HistoryBook'.
	mathBook := 'MathBook'.
	catalogue := Dictionary new.
	catalogue add: mathBook -> 100.
	catalogue add: historyBook -> 100.
	
	cart := Cart with: catalogue.
		
	cart add: 100 of: historyBook.
	cart add: 50 of: mathBook. 
	
	self assert: (cart quantityOf: historyBook) equals: 100.
	self assert: (cart quantityOf: mathBook) equals: 50.
	! !

!CartTests methodsFor: 'cart tests' stamp: 'LNB 11/21/2020 18:35:13'!
test07CartShouldProperlyAddMoreCopiesOfAnAlreadyAddedBook

	| cart catalogue book|
	
	book := 'Book'.
	catalogue := Dictionary new.
	catalogue add: book -> 100.
	
	cart := Cart with: catalogue .
		
	cart add: 50 of: book. 
	cart add: 150 of: book.
		
	self assert: (cart quantityOf: book) equals: 200.! !

!CartTests methodsFor: 'cart tests' stamp: 'LNB 11/21/2020 18:35:48'!
test08CartShouldBeAbleToAnswerWhatBooksItHas

	| cart catalogue mathBook historyBook|
	
	mathBook := 'MathBook'.
	historyBook := 'HistoryBook'.		
	
	catalogue := Dictionary new.
	catalogue add: mathBook -> 100.
	catalogue add: historyBook -> 100.
	
	cart := Cart with: catalogue.
	
	cart add: 50 of: mathBook.
		
	self assert: cart books size equals: 50.
	self assert: (cart books includes: mathBook).
	
	cart add: 100 of: historyBook.
	
	self assert: cart books size equals: 150.
	self assert: (cart books includes: historyBook).
	! !

!CartTests methodsFor: 'cart tests' stamp: 'LNB 11/21/2020 18:36:06'!
test09CartCantAddBookThatAreNotInTheCatalogue

	| cart catalogue mathBook historyBook|
	
	mathBook := 'MathBook'.
	historyBook := 'HistoryBook'.	
	
	catalogue := Dictionary new.
	catalogue add: mathBook -> 100.
	cart := Cart with: catalogue.
	
	[cart add: 100 of: historyBook. self fail]
		on: Error
		do: [:anError | self assert: anError messageText equals: Cart cantAddBooksThatAreNotInTheCatalogue. ].	
! !

!CartTests methodsFor: 'cart tests' stamp: 'LNB 11/21/2020 18:36:23'!
test10CartCantAddANonIntegerAmountOfBooks

	| cart catalogue mathBook|
	
	mathBook := 'MathBook'.
	
	catalogue := Dictionary new.
	catalogue add: mathBook -> 100.
	cart := Cart with: catalogue.
	
	[cart add: 2.5 of: mathBook. self fail]
		on: Error
		do: [:anError | self assert: anError messageText equals: Cart cantAddANonIntegerAmountOfBooks. ].	
! !

!CartTests methodsFor: 'cart tests' stamp: 'LNB 11/21/2020 18:36:35'!
test11CartCantAddANonPositiveAmountOfBooks

	| cart catalogue mathBook|
	
	mathBook := 'MathBook'.
	
	catalogue := Dictionary new.
	catalogue add: mathBook -> 100.
	cart := Cart with: catalogue.
	
	
	self should: [cart add: 0 of: mathBook] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: Cart cantAddANonPositiveAmountOfBooks. ]
	! !


!classDefinition: #CashierTests category: 'Ejercicio-TusLibros.com'!
TusLibrosExerciseTests subclass: #CashierTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-TusLibros.com'!

!CashierTests methodsFor: 'as yet unclassified' stamp: 'LNB 11/25/2020 20:18:34'!
test01CantCheckoutWithAnEmptyCart

	| cart cashier creditCard |
	
	creditCard := CreditCard 
		withPlasticNumber: '0000000000000000' 
		namedAfter: 'Pepito'
		validThrough: (GregorianMonthOfYear novemberOf: (GregorianYear createYear: 2024)).
		
	cart := Cart with: Set new.
	cashier := Cashier new.
	
	self should: [cashier checkout: cart payingWith: creditCard.] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: Cashier cantCheckoutWithAnEmptyCart. ]! !

!CashierTests methodsFor: 'as yet unclassified' stamp: 'LNB 11/25/2020 20:19:33'!
test02CheckingOutACartWithABookReturnsItsPrice

	| cart cashier catalogue mathBook creditCard |
	
	creditCard := CreditCard 
		withPlasticNumber: '0000000000000000' 
		namedAfter: 'Pepito'
		validThrough: (GregorianMonthOfYear novemberOf: (GregorianYear createYear: 2024)).
		
	mathBook := 'MathBook'.
	
	catalogue := Dictionary new.
	catalogue add: mathBook -> 100.
	
	cart := Cart with: catalogue.
	cart add: 1 of: mathBook. 
	
	cashier := Cashier new.
	
	self assert: (cashier checkout: cart payingWith: creditCard) equals: 100.! !

!CashierTests methodsFor: 'as yet unclassified' stamp: 'LNB 11/25/2020 20:20:23'!
test03CheckingOutWithTwoDifferentBooksReturnsTheSumOfBothPrices
	
	| cart cashier catalogue mathBook historyBook creditCard |
	
	creditCard := CreditCard 
		withPlasticNumber: '0000000000000000' 
		namedAfter: 'Pepito'
		validThrough: (GregorianMonthOfYear novemberOf: (GregorianYear createYear: 2024)).
	
	mathBook := 'MathBook'.
	historyBook := 'HistoryBook'.	
	
	catalogue := Dictionary new.
	catalogue add: mathBook -> 100.
	catalogue add: historyBook -> 75.
	
	cart := Cart with: catalogue.
	cart add: 1 of: mathBook.
	cart add: 1 of: historyBook.
	
	cashier := Cashier new.
	
	self assert: (cashier checkout: cart payingWith: creditCard ) equals: 175.! !

!CashierTests methodsFor: 'as yet unclassified' stamp: 'LNB 11/25/2020 20:21:22'!
test04CheckingOutMultipleCopiesOfTheSameBookReturnsItsPriceTimesTheQuantity

	| cart cashier catalogue mathBook creditCard |
	
	creditCard := CreditCard 
		withPlasticNumber: '0000000000000000' 
		namedAfter: 'Pepito'
		validThrough: (GregorianMonthOfYear novemberOf: (GregorianYear createYear: 2024)).
	
	mathBook := 'MathBook'.	
	
	catalogue := Dictionary new.
	catalogue add: mathBook -> 100.
	
	cart := Cart with: catalogue.
	cart add: 3 of: mathBook.
	
	cashier := Cashier new.
	
	self assert: (cashier checkout: cart payingWith: creditCard ) equals: 300.! !

!CashierTests methodsFor: 'as yet unclassified' stamp: 'LNB 11/25/2020 20:22:01'!
test05CantCheckoutWithAnExpiredCreditCard
	
	| cart cashier catalogue mathBook creditCard |
	
	creditCard := CreditCard 
		withPlasticNumber: '0000000000000000' 
		namedAfter: 'Pepito' 
		validThrough: (GregorianMonthOfYear decemberOf: (GregorianYear createYear: 2019)).
	
	mathBook := 'MathBook'.
	
	catalogue := Dictionary new.
	catalogue add: mathBook -> 100.
	
	cart := Cart with: catalogue.
	cart add: 1 of: mathBook.
	
	cashier := Cashier new.
	
	self should: [cashier checkout: cart payingWith: creditCard.] 
		raisingAnErrorAndAsserting: [ :anError | self assert: anError messageText equals: Cashier creditCardHasExpired. ].	
	
	! !

!CashierTests methodsFor: 'as yet unclassified' stamp: 'LNB 11/25/2020 20:23:54'!
test06CantCheckoutWhenTotalAmountToPayHasMoreThan15Digits
	| cart cashier catalogue mathBook creditCard |
	
	creditCard := CreditCard 
		withPlasticNumber: '0000000000000000' 
		namedAfter: 'Pepito' 
		validThrough: (GregorianMonthOfYear decemberOf: (GregorianYear createYear: 2021)).
	
	mathBook := 'MathBook'.
	
	catalogue := Dictionary new.
	catalogue add: mathBook -> 1000000000000000.
	
	cart := Cart with: catalogue.
	cart add: 1 of: mathBook.
	
	cashier := Cashier new.
	
	self should: [cashier checkout: cart payingWith: creditCard] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: Cashier amountToBigToProcess. ].
	
	! !

!CashierTests methodsFor: 'as yet unclassified' stamp: 'LNB 11/25/2020 20:24:48'!
test07CentsMustBeRoundedUpToTwoDigits
	| cart cashier catalogue mathBook creditCard |
	
	creditCard := CreditCard 
		withPlasticNumber: '0000000000000000' 
		namedAfter: 'Pepito'
		validThrough: (GregorianMonthOfYear novemberOf: (GregorianYear createYear: 2024)).
	
	mathBook := 'MathBook'.	
	
	catalogue := Dictionary new.
	catalogue add: mathBook -> 100.002.
	
	cart := Cart with: catalogue.
	cart add: 1 of: mathBook.
	
	cashier := Cashier new.
	
	self assert: (cashier checkout: cart payingWith: creditCard ) equals: 100.01.! !

!CashierTests methodsFor: 'as yet unclassified' stamp: 'LNB 11/25/2020 20:25:23'!
test08CantCheckOutIfPurchaseIsInvalidatedByMerchantProcessorBecauseOfInvalidParameter
	
	| cart cashier catalogue mathBook creditCard |
	
	creditCard := CreditCard 
		withPlasticNumber: '1234567890123456' 
		namedAfter: 'Nombre Incorrecto' 
		validThrough: (GregorianMonthOfYear decemberOf: (GregorianYear createYear: 2024)).
	
	mathBook := 'MathBook'.
	
	catalogue := Dictionary new.
	catalogue add: mathBook -> 100.
	
	cart := Cart with: catalogue.
	cart add: 1 of: mathBook.
	
	cashier := Cashier new.
	
	self should: [cashier checkout: cart payingWith: creditCard] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: Cashier purchaseInvalidatedByMerchantProcessorBecauseOfInvalidParameter . ].
	
	! !

!CashierTests methodsFor: 'as yet unclassified' stamp: 'LNB 11/25/2020 20:25:55'!
test09CantCheckOutIfPurchaseIsInvalidatedByMerchantProcessorBecauseOfAGivenError
	| cart cashier catalogue mathBook creditCard |
	
	creditCard := CreditCard 
		withPlasticNumber: '1234567890123456' 
		namedAfter: 'TarjetaRobada' 
		validThrough: (GregorianMonthOfYear decemberOf: (GregorianYear createYear: 2024)).
	
	mathBook := 'MathBook'.
	
	catalogue := Dictionary new.
	catalogue add: mathBook -> 100.
	
	cart := Cart with: catalogue.
	cart add: 1 of: mathBook.
	
	cashier := Cashier new.
	
	self should: [cashier checkout: cart payingWith: creditCard] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: 'Tarjeta Robada'. ].
	
	! !


!classDefinition: #CreditCardTests category: 'Ejercicio-TusLibros.com'!
TusLibrosExerciseTests subclass: #CreditCardTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-TusLibros.com'!

!CreditCardTests methodsFor: 'credit card tests' stamp: 'FG 11/25/2020 13:51:03'!
test01CreditCardNumberMustBeComposedOfDigits

	self should: [	CreditCard 
				withPlasticNumber: 'No soy un número'
				namedAfter: 'Pepito'
				validThrough: (GregorianMonthOfYear novemberOf: (GregorianYear createYear: 2024)).] 
		raisingAnErrorAndAsserting: [ :anError | self assert: anError messageText equals: CreditCard plasticNumberMustBeMadeOfDigits. ].	! !

!CreditCardTests methodsFor: 'credit card tests' stamp: 'FG 11/25/2020 13:53:16'!
test02CreditCardNumberShouldHaveExactlySixteenDigits

	self should: [	CreditCard 
				withPlasticNumber: '000000000900000' 
				namedAfter: 'Pepito'
				validThrough: (GregorianMonthOfYear novemberOf: (GregorianYear createYear: 2024)).] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: CreditCard plasticNumberMustHaveSixteenDigits. ].	
	
	self should: [	CreditCard 
				withPlasticNumber: '00000000090000000'
				namedAfter: 'Pepito'
				validThrough: (GregorianMonthOfYear novemberOf: (GregorianYear createYear: 2024)).] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: CreditCard plasticNumberMustHaveSixteenDigits. ].! !

!CreditCardTests methodsFor: 'credit card tests' stamp: 'FG 11/25/2020 13:55:05'!
test03CreditCardOwnerNameCanNotBeEmpty

	self should: [	CreditCard 
				withPlasticNumber: '0000000009000000' 
				namedAfter: ''
				validThrough: (GregorianMonthOfYear novemberOf: (GregorianYear createYear: 2024)).] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: CreditCard plasticOwnerMustHaveAName. ].	
	! !

!CreditCardTests methodsFor: 'credit card tests' stamp: 'FG 11/25/2020 13:57:42'!
test04CreditCardCanShowTheirOwnerName

	| ownerName creditCard |
	
	ownerName := 'Pepito'.
	
	creditCard := CreditCard 
		withPlasticNumber: '0000000009000000' 
		namedAfter: ownerName
		validThrough: (GregorianMonthOfYear novemberOf: (GregorianYear createYear: 2024)).
	
	self assert: creditCard ownerName equals: ownerName.
	
	
	! !

!CreditCardTests methodsFor: 'credit card tests' stamp: 'FG 11/25/2020 17:55:31'!
test05IfOwnerNameHasMoreThanThirtyCharactersThenItGetsTruncated

	| ownerName truncatedOwnerName creditCard |
	
	ownerName := 'Pepito Gabriel de la Santisima Trinidad'.
	truncatedOwnerName := 'Pepito Gabriel de la Santisima'.
	
	creditCard := CreditCard 
		withPlasticNumber: '0000000009000000' 
		namedAfter: ownerName
		validThrough: (GregorianMonthOfYear novemberOf: (GregorianYear createYear: 2024)).
	
	self assert: creditCard ownerName equals: truncatedOwnerName.
	
	
	! !

!CreditCardTests methodsFor: 'credit card tests' stamp: 'FG 11/25/2020 14:05:27'!
test06CreditCardCanShowTheirPlasticNumber
	
	| creditCard creditCardNumber |
	
	creditCardNumber := '0000000009000000'.
	
	creditCard := CreditCard 
		withPlasticNumber: creditCardNumber 
		namedAfter: 'Pepito'
		validThrough: (GregorianMonthOfYear novemberOf: (GregorianYear createYear: 2024)).
	
	self assert: creditCard plasticNumber equals: creditCardNumber.
	
	
	! !

!CreditCardTests methodsFor: 'credit card tests' stamp: 'FG 11/25/2020 14:05:55'!
test07CreditCarCanShowExpirationDate

	| creditCard creditCardExpiration |
	
	creditCardExpiration := GregorianMonthOfYear novemberOf: (GregorianYear createYear: 2024).
	
	creditCard := CreditCard 
		withPlasticNumber: '0000000000000000' 
		namedAfter: 'Pepito' 
		validThrough: creditCardExpiration.
	
	self assert: creditCard expirationDate equals: creditCardExpiration.! !

!CreditCardTests methodsFor: 'credit card tests' stamp: 'FG 11/25/2020 18:00:32'!
test08CreditCardExpirationDateIsKindaOfGregorianMonthOfYear
	
	self should: [ CreditCard 
		withPlasticNumber: '0000000000000000' 
		namedAfter: 'Pepito' 
		validThrough: 0596. ] 
	raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: CreditCard expirationDateShouldBeGregorianMonthOfYear. ]. 
	! !


!classDefinition: #Cart category: 'Ejercicio-TusLibros.com'!
Object subclass: #Cart
	instanceVariableNames: 'books catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-TusLibros.com'!

!Cart methodsFor: 'adding' stamp: 'LNB 11/19/2020 19:01:59'!
add: aQuantity of: aBook 

	self assertIsInCatalogue: aBook.
	self assertIsValidQuantity: aQuantity.
	
	^ books add: aBook withOccurrences: aQuantity.! !


!Cart methodsFor: 'accesing' stamp: 'FG 11/18/2020 17:46:38'!
books
	^ books copy.! !

!Cart methodsFor: 'accesing' stamp: 'LNB 11/21/2020 18:47:15'!
catalogue
	^ catalogue copy.! !

!Cart methodsFor: 'accesing' stamp: 'FG 11/16/2020 19:15:54'!
has: aBook
	^ books includes: aBook.! !

!Cart methodsFor: 'accesing' stamp: 'FG 11/16/2020 19:15:27'!
isEmpty
	^ books isEmpty.! !

!Cart methodsFor: 'accesing' stamp: 'FG 11/16/2020 19:26:32'!
quantityOf: aBook
	^ books occurrencesOf: aBook.! !


!Cart methodsFor: 'asserting' stamp: 'LNB 11/21/2020 18:30:01'!
assertIsInCatalogue: aBook

	^ (catalogue includesKey: aBook) ifFalse: [self error: Cart cantAddBooksThatAreNotInTheCatalogue]! !

!Cart methodsFor: 'asserting' stamp: 'LNB 11/19/2020 18:59:07'!
assertIsValidQuantity: aQuantity

	aQuantity isInteger ifFalse: [self error: Cart cantAddANonIntegerAmountOfBooks].
	aQuantity strictlyPositive ifFalse: [self error: Cart cantAddANonPositiveAmountOfBooks ]! !


!Cart methodsFor: 'initialization' stamp: 'FG 11/18/2020 18:02:03'!
initializeWith: aCatalogue

	catalogue := aCatalogue.
	books := Bag new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'Ejercicio-TusLibros.com'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'intialization' stamp: 'FG 11/18/2020 18:01:21'!
with: aCatalogue
	^ self basicNew initializeWith: aCatalogue.! !


!Cart class methodsFor: 'error checking' stamp: 'LNB 11/19/2020 17:47:17'!
cantAddANonIntegerAmountOfBooks
	^ 'Cant add a non integer amount of books'.! !

!Cart class methodsFor: 'error checking' stamp: 'LNB 11/19/2020 18:55:50'!
cantAddANonPositiveAmountOfBooks
	^ 'Cant add a non positive amount of books'.! !

!Cart class methodsFor: 'error checking' stamp: 'FG 11/18/2020 18:05:15'!
cantAddBooksThatAreNotInTheCatalogue
	^ 'Cant add book because is not in the catalogue'.! !


!classDefinition: #Cashier category: 'Ejercicio-TusLibros.com'!
Object subclass: #Cashier
	instanceVariableNames: 'interface'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-TusLibros.com'!

!Cashier methodsFor: 'checkout' stamp: 'LNB 11/25/2020 19:30:14'!
assertThatAmountIsNotTooBig: aCart
	
	((self purchaseTotalOf: aCart) < 1000000000000000) ifFalse:[self error: Cashier amountToBigToProcess].! !

!Cashier methodsFor: 'checkout' stamp: 'FG 11/25/2020 14:15:58'!
assertThatCartIsNotEmpty: aCart
	
	aCart isEmpty ifTrue: [self error: Cashier cantCheckoutWithAnEmptyCart].! !

!Cashier methodsFor: 'checkout' stamp: 'LNB 11/25/2020 18:49:37'!
assertThatCreditCardHasNotExpired: aCreditCard	
	
	(aCreditCard expirationDate < GregorianMonthOfYear current) ifTrue: [ self error: Cashier creditCardHasExpired ].! !

!Cashier methodsFor: 'checkout' stamp: 'LNB 11/25/2020 19:50:03'!
checkout: aCart payingWith: aCreditCard
	
	self assertThatCreditCardHasNotExpired: aCreditCard.
	self assertThatCartIsNotEmpty: aCart.
	self assertThatAmountIsNotTooBig: aCart.
	
	^ interface payWith: aCreditCard for: (self purchaseTotalOf: aCart) requestedBy: self.! !

!Cashier methodsFor: 'checkout' stamp: 'LNB 11/25/2020 18:50:15'!
checkoutWithTicket: aCart payingWith: aCreditCard
	
	self assertThatCreditCardHasNotExpired: aCreditCard.
	self assertThatCartIsNotEmpty: aCart.
	self assertThatAmountIsNotTooBig: aCart.
	
	^ self ticketOf: aCart.! !

!Cashier methodsFor: 'checkout' stamp: 'LNB 11/25/2020 19:45:59'!
initialize
	
	interface := InterfaceSimulator new.! !

!Cashier methodsFor: 'checkout' stamp: 'LNB 11/25/2020 20:13:53'!
invalidatePurchaseBecauseOf: anError.
	
	self error: anError.! !

!Cashier methodsFor: 'checkout' stamp: 'LNB 11/25/2020 20:06:46'!
invalidatePurchaseBecauseOfInvalidParameter
	
	self error: Cashier purchaseInvalidatedByMerchantProcessorBecauseOfInvalidParameter.! !

!Cashier methodsFor: 'checkout' stamp: 'LNB 11/25/2020 18:46:50'!
purchaseTotalOf: aCart
	
	| total |
	
	total := 0.
	aCart books do: [:aBook | total := total + (aCart catalogue at: aBook)].
	^total roundUpTo: 0.01.! !

!Cashier methodsFor: 'checkout' stamp: 'LNB 11/25/2020 19:54:47'!
reportPayment: anAmount
	^ anAmount.
	! !

!Cashier methodsFor: 'checkout' stamp: 'FG 11/25/2020 18:12:21'!
ticketOf: aCart
	
	| ticket |
	
	ticket := OrderedCollection new.
	aCart books asSet do: [:aBook | ticket add: (aCart quantityOf: aBook asString ,(aBook , '   ')) , ((aCart catalogue at: aBook) * (aCart quantityOf: aBook) ) asString].
	ticket add: 'Total   ' , (self purchaseTotalOf: aCart) asString.
	
	^ ticket.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'Ejercicio-TusLibros.com'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'FG 11/25/2020 17:47:20'!
amountToBigToProcess
	^ 'Total amount to pay should be below the Sixteen digits'.! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LNB 11/19/2020 19:18:38'!
cantCheckoutWithAnEmptyCart
	^'Cant checkout with an empty cart'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LNB 11/23/2020 17:44:32'!
creditCardHasExpired
	^'Cant checkout with an expired Credit Card'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LNB 11/25/2020 19:44:51'!
new
	^self basicNew initialize.! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LNB 11/25/2020 20:04:19'!
purchaseInvalidatedByMerchantProcessorBecauseOfInvalidParameter
	^ 'The Merchant Processor invalidated your purchase because of an invalid Parameter'.! !


!classDefinition: #CreditCard category: 'Ejercicio-TusLibros.com'!
Object subclass: #CreditCard
	instanceVariableNames: 'plasticNumber ownerName expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-TusLibros.com'!

!CreditCard methodsFor: 'accessing' stamp: 'FG 11/25/2020 12:38:53'!
expirationDate

	^ expirationDate copy.! !

!CreditCard methodsFor: 'accessing' stamp: 'FG 11/25/2020 12:39:36'!
ownerName

	^ ownerName copy.! !

!CreditCard methodsFor: 'accessing' stamp: 'LNB 11/21/2020 20:26:11'!
plasticNumber

	^ plasticNumber copy.! !


!CreditCard methodsFor: 'initialization' stamp: 'FG 11/25/2020 18:02:11'!
assertThatExpirationDateIsGregorianMonthOfYear: creditCardExpiration.
	
	(creditCardExpiration isKindOf: GregorianMonthOfYear) ifFalse: [self error: CreditCard expirationDateShouldBeGregorianMonthOfYear ].! !

!CreditCard methodsFor: 'initialization' stamp: 'FG 11/25/2020 13:46:54'!
assertThatIsValidCreditCardNumber: aCreditCardNumber
	
	(aCreditCardNumber size = 16) ifFalse: [ self error: CreditCard plasticNumberMustHaveSixteenDigits ].
	aCreditCardNumber do: [:aCharacter | (aCharacter isDigit) ifFalse: [self error: CreditCard plasticNumberMustBeMadeOfDigits] ].
	! !

!CreditCard methodsFor: 'initialization' stamp: 'FG 11/25/2020 13:05:56'!
assertThatIsValidOwnerName: anOwnerName.

	anOwnerName isEmpty ifTrue: [ self error: CreditCard plasticOwnerMustHaveAName ].! !

!CreditCard methodsFor: 'initialization' stamp: 'FG 11/25/2020 17:58:03'!
initializeWithPlasticNumber: aCreditCardNumber namedAfter: anOwnerName validThrough: 	creditCardExpiration
	
	self assertThatIsValidCreditCardNumber: aCreditCardNumber.
	self assertThatIsValidOwnerName: anOwnerName.
	self assertThatExpirationDateIsGregorianMonthOfYear: creditCardExpiration.
	
	plasticNumber := aCreditCardNumber.
	ownerName := anOwnerName truncateTo: 30.
	expirationDate := creditCardExpiration. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'Ejercicio-TusLibros.com'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'error texts' stamp: 'FG 11/25/2020 18:01:06'!
expirationDateShouldBeGregorianMonthOfYear
	^ 'Expiration Date should be kind of Gregorian Month Of Year'.! !

!CreditCard class methodsFor: 'error texts' stamp: 'LNB 11/21/2020 19:50:47'!
plasticNumberMustBeMadeOfDigits
	^'Credit Card number must be made of digits.'.! !

!CreditCard class methodsFor: 'error texts' stamp: 'LNB 11/21/2020 19:45:32'!
plasticNumberMustHaveSixteenDigits
	^'Credit Card number must have 16 digits.'.! !

!CreditCard class methodsFor: 'error texts' stamp: 'LNB 11/21/2020 19:57:19'!
plasticOwnerMustHaveAName
	'Plastic owner must have a name'.! !


!CreditCard class methodsFor: 'initialization' stamp: 'LNB 11/23/2020 17:30:02'!
withPlasticNumber: aCreditCardNumber namedAfter: anOwnerName validThrough: creditCardExpiration

	^self basicNew initializeWithPlasticNumber: aCreditCardNumber namedAfter: anOwnerName validThrough: creditCardExpiration.! !


!classDefinition: #InterfaceSimulator category: 'Ejercicio-TusLibros.com'!
Object subclass: #InterfaceSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-TusLibros.com'!

!InterfaceSimulator methodsFor: 'as yet unclassified' stamp: 'LNB 11/25/2020 20:12:37'!
payWith: aCreditCard for: anAmount requestedBy: aCashier

	"mandar al merchantProcesor"
	
	(aCreditCard ownerName = 'Nombre Incorrecto') ifTrue: [aCashier invalidatePurchaseBecauseOfInvalidParameter.].
	(aCreditCard ownerName = 'TarjetaRobada') ifTrue: [aCashier invalidatePurchaseBecauseOf: 'Tarjeta Robada'.].
	
	^aCashier reportPayment: anAmount.
	! !
