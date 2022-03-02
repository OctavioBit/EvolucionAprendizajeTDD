!classDefinition: #TusLibrosExerciseTests category: 'Ejercicio-TusLibros.com'!
TestCase subclass: #TusLibrosExerciseTests
	instanceVariableNames: 'builder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-TusLibros.com'!

!TusLibrosExerciseTests methodsFor: 'testing' stamp: 'LNB 11/29/2020 15:54:08'!
setUp

	builder := TestObjectBuilder at: DateAndTime now.! !

!TusLibrosExerciseTests methodsFor: 'testing' stamp: 'LNB 11/19/2020 19:14:41'!
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

!CartTests methodsFor: 'cart tests' stamp: 'FG 12/2/2020 14:09:47'!
test01NewCartShouldBeEmpty

	| cart catalogue |
	
	catalogue := builder emptyCatalogue.
	cart := Cart with: catalogue at: (SimulatedClock new now).
	
	self assert: cart isEmpty. ! !

!CartTests methodsFor: 'cart tests' stamp: 'FG 12/2/2020 14:15:16'!
test02CartWithABookShouldNotBeEmpty

	| cart catalogue |
	
	catalogue := builder catalogueWithABook. 
		
	cart := Cart with: catalogue at: (SimulatedClock new now).
	
	cart add: 10 of: builder catalogueFirstBook.
	
	self assert: cart isEmpty not. ! !

!CartTests methodsFor: 'cart tests' stamp: 'FG 12/2/2020 14:16:14'!
test03EmptyCartDoesntHasABook

	| cart catalogue |
	
	catalogue := builder catalogueWithABook.
	
	cart := Cart with: catalogue at: (SimulatedClock new now).
	
	self assert: (cart has: builder catalogueFirstBook) not.! !

!CartTests methodsFor: 'cart tests' stamp: 'FG 12/2/2020 14:18:00'!
test04CartShouldHaveAddedBook

	| cart catalogue |
	
	catalogue := builder catalogueWithABook. 
	
	cart := Cart with: catalogue at: (SimulatedClock new now).
	
	cart add: 10 of: builder catalogueFirstBook. 
	
	self assert: (cart has: builder catalogueFirstBook).! !

!CartTests methodsFor: 'cart tests' stamp: 'FG 12/2/2020 14:18:59'!
test05CartShouldNotHaveNonAddedBook

	| cart catalogue |
	
	catalogue := builder catalogueWithTwoBooks.
	
	cart := Cart with: catalogue at: (SimulatedClock new now).
	
	cart add: 10 of: builder catalogueSecondBook. 
	
	self assert: (cart has: builder catalogueFirstBook) not.
	! !

!CartTests methodsFor: 'cart tests' stamp: 'FG 12/2/2020 14:20:36'!
test06CartShouldAnswerQuantityOfAnAddedBook

	| cart catalogue |
	
	catalogue := builder catalogueWithTwoBooks.
	
	cart := Cart with: catalogue at: (SimulatedClock new now).
		
	cart add: 100 of: builder catalogueSecondBook.
	cart add: 50 of: builder catalogueFirstBook. 
	
	self assert: (cart quantityOf: builder catalogueSecondBook ) equals: 100.
	self assert: (cart quantityOf: builder catalogueFirstBook ) equals: 50.
	! !

!CartTests methodsFor: 'cart tests' stamp: 'FG 12/2/2020 14:21:37'!
test07CartShouldProperlyAddMoreCopiesOfAnAlreadyAddedBook

	| cart catalogue |
	
	catalogue := builder catalogueWithABook.
	
	cart := Cart with: catalogue at: (SimulatedClock new now).
		
	cart add: 50 of: builder catalogueFirstBook . 
	cart add: 150 of: builder catalogueFirstBook .
		
	self assert: (cart quantityOf: builder catalogueFirstBook ) equals: 200.! !

!CartTests methodsFor: 'cart tests' stamp: 'FG 12/2/2020 14:22:51'!
test08CartShouldBeAbleToAnswerWhatBooksItHas

	| cart catalogue |
	
	catalogue := builder catalogueWithTwoBooks.
	
	cart := Cart with: catalogue at: (SimulatedClock new now).
	
	cart add: 50 of: builder catalogueFirstBook.
		
	self assert: cart books size equals: 50.
	self assert: (cart books includes: builder catalogueFirstBook ).
	
	cart add: 100 of: builder catalogueSecondBook .
	
	self assert: cart books size equals: 150.
	self assert: (cart books includes: builder catalogueSecondBook ).
	! !

!CartTests methodsFor: 'cart tests' stamp: 'FG 12/2/2020 14:24:30'!
test09CartCantAddBookThatAreNotInTheCatalogue

	| cart catalogue |
	
	catalogue := builder catalogueWithABook.
	
	cart := Cart with: catalogue at: (SimulatedClock new now).
	
	self should: [cart add: 100 of: builder catalogueSecondBook.] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: Cart cantAddBooksThatAreNotInTheCatalogue. ].	
! !

!CartTests methodsFor: 'cart tests' stamp: 'FG 12/2/2020 14:26:01'!
test10CartCantAddANonIntegerAmountOfBooks

	| cart catalogue |
	
	catalogue := builder catalogueWithABook.
	
	cart := Cart with: catalogue at: (SimulatedClock new now).
	
	self should: [cart add: 2.5 of: builder catalogueFirstBook.] 
		 raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: Cart cantAddANonIntegerAmountOfBooks. ].	
! !

!CartTests methodsFor: 'cart tests' stamp: 'FG 12/2/2020 14:26:45'!
test11CartCantAddANonPositiveAmountOfBooks

	| cart catalogue |
	
	catalogue := builder catalogueWithABook.
	
	cart := Cart with: catalogue at: (SimulatedClock new now).
	
	self should: [cart add: 0 of: builder catalogueFirstBook.] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: Cart cantAddANonPositiveAmountOfBooks. ]
	! !


!classDefinition: #CashierTests category: 'Ejercicio-TusLibros.com'!
TusLibrosExerciseTests subclass: #CashierTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-TusLibros.com'!

!CashierTests methodsFor: 'cashier tests' stamp: 'FG 12/2/2020 14:28:55'!
test01CantCheckoutWithAnEmptyCart

	| cart cashier creditCard |
	
	creditCard := builder validCreditCard.
	cart := Cart with: builder emptyCatalogue at: (SimulatedClock new now).
	
	cashier := Cashier payingThrough: OutputInterfaceSimulator new.
	
	self should: [cashier checkout: cart payingWith: creditCard at: builder currentMonthOfYear.] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: Cashier cantCheckoutWithAnEmptyCart. ]! !

!CashierTests methodsFor: 'cashier tests' stamp: 'FG 12/2/2020 14:28:37'!
test02CheckingOutACartWithABookReturnsItsPrice

	| cart cashier catalogue creditCard |
	
	creditCard := builder validCreditCard.
	catalogue := builder catalogueWithABook.
	
	cart := Cart with: catalogue at: (SimulatedClock new now).
	cart add: 1 of: builder catalogueFirstBook. 
	
	cashier := Cashier payingThrough: OutputInterfaceSimulator new.
	
	self assert: (cashier checkout: cart payingWith: creditCard at: builder currentMonthOfYear) total equals: 100.! !

!CashierTests methodsFor: 'cashier tests' stamp: 'FG 12/2/2020 14:30:20'!
test03CheckingOutWithTwoDifferentBooksReturnsTheSumOfBothPrices
	
	| cart cashier catalogue creditCard |
	
	creditCard := builder validCreditCard.
	catalogue := builder catalogueWithTwoBooks.
	
	cart := Cart with: catalogue at: (SimulatedClock new now).
	cart add: 1 of: builder catalogueFirstBook.
	cart add: 1 of: builder catalogueSecondBook.
	
	cashier := Cashier payingThrough: OutputInterfaceSimulator new.
	
	self assert: (cashier checkout: cart payingWith: creditCard at: builder currentMonthOfYear) total equals: 300.! !

!CashierTests methodsFor: 'cashier tests' stamp: 'FG 12/2/2020 14:31:31'!
test04CheckingOutMultipleCopiesOfTheSameBookReturnsItsPriceTimesTheQuantity

	| cart cashier catalogue creditCard |
	
	creditCard := builder validCreditCard.
	catalogue := builder catalogueWithABook.
	
	cart := Cart with: catalogue at: (SimulatedClock new now).
	cart add: 3 of: builder catalogueFirstBook.
	
	cashier := Cashier payingThrough: OutputInterfaceSimulator new.
	
	self assert: (cashier checkout: cart payingWith: creditCard at: builder currentMonthOfYear) total equals: 300.! !

!CashierTests methodsFor: 'cashier tests' stamp: 'FG 12/2/2020 14:33:06'!
test05CantCheckoutWithAnExpiredCreditCard
	
	| cart cashier catalogue creditCard |
	
	creditCard := builder expiredCreditCard.
	catalogue := builder catalogueWithABook.
	
	cart := Cart with: catalogue at: (SimulatedClock new now).
	cart add: 1 of: builder catalogueFirstBook.
	
	cashier := Cashier payingThrough: OutputInterfaceSimulator new.
	
	self should: [cashier checkout: cart payingWith: creditCard at: builder currentMonthOfYear.] 
		raisingAnErrorAndAsserting: [ :anError | self assert: anError messageText equals: Cashier creditCardHasExpired. ].	
	
	! !

!CashierTests methodsFor: 'cashier tests' stamp: 'FG 12/2/2020 14:34:53'!
test06CantCheckoutWhenTotalAmountToPayHasMoreThan15Digits
	| cart cashier catalogue creditCard |
	
	creditCard := builder validCreditCard.
	catalogue := builder catalogueWithOverlyExpensiveBook.
	
	cart := Cart with: catalogue at: (SimulatedClock new now).
	cart add: 1 of: builder catalogueFirstBook.
	
	cashier := Cashier payingThrough: OutputInterfaceSimulator new.
	
	self should: [cashier checkout: cart payingWith: creditCard at: builder currentMonthOfYear] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: Cashier amountToBigToProcess. ].
	
	! !

!CashierTests methodsFor: 'cashier tests' stamp: 'FG 12/2/2020 14:37:30'!
test07CentsMustBeRoundedUpToTwoDigits
	| cart cashier catalogue creditCard |
	
	creditCard := builder validCreditCard.
	catalogue := builder catalogueWithABookWithAnOverlySpecificPrice. 
	
	cart := Cart with: catalogue at: (SimulatedClock new now).
	cart add: 1 of: builder catalogueFirstBook.
	
	cashier := Cashier payingThrough: OutputInterfaceSimulator new.
	
	self assert: (cashier checkout: cart payingWith: creditCard at: builder currentMonthOfYear) total equals: 100.01.! !

!CashierTests methodsFor: 'cashier tests' stamp: 'FG 12/2/2020 14:38:28'!
test08CantCheckOutIfPurchaseIsInvalidatedByMerchantProcessorBecauseOfInvalidParameter
	
	| cart cashier catalogue creditCard |
	
	creditCard := builder validCreditCard.
	catalogue := builder catalogueWithABook.
	
	cart := Cart with: catalogue at: (SimulatedClock new now).
	cart add: 1 of: builder catalogueFirstBook.
	
	cashier := Cashier payingThrough: OutputInterfaceSimulator new invalidateNextPurchasesBecauseOfInvalidParameters.
	
	self should: [cashier checkout: cart payingWith: creditCard at: builder currentMonthOfYear] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: Cashier purchaseInvalidatedByMerchantProcessorBecauseOfInvalidParameter . ].
	
	! !

!CashierTests methodsFor: 'cashier tests' stamp: 'FG 12/2/2020 14:39:45'!
test09CantCheckOutIfPurchaseIsInvalidatedByMerchantProcessorBecauseOfAGivenError
	| cart cashier catalogue creditCard |
	
	creditCard := builder validCreditCard.
	catalogue := builder catalogueWithABook.
	
	cart := Cart with: catalogue at: (SimulatedClock new now).
	cart add: 1 of: builder catalogueFirstBook.
	
	cashier := Cashier payingThrough: (OutputInterfaceSimulator new invalidateNextPurchaseForACustomErrorDescription: 'Tarjeta Robada').
	
	self should: [cashier checkout: cart payingWith: creditCard at: builder currentMonthOfYear] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: 'Tarjeta Robada'. ].
	
	! !


!classDefinition: #CreditCardTests category: 'Ejercicio-TusLibros.com'!
TusLibrosExerciseTests subclass: #CreditCardTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-TusLibros.com'!

!CreditCardTests methodsFor: 'credit card tests' stamp: 'LNB 11/29/2020 16:05:16'!
test01CreditCardNumberMustBeComposedOfDigits

	self should: [	builder creditCardWithInvalidPlasticNumber.] 
		raisingAnErrorAndAsserting: [ :anError | self assert: anError messageText equals: CreditCard plasticNumberMustBeMadeOfDigits. ].	! !

!CreditCardTests methodsFor: 'credit card tests' stamp: 'LNB 11/29/2020 16:05:39'!
test02CreditCardNumberShouldHaveExactlySixteenDigits

	self should: [	builder creditCardWithLessThan16DigitsInItsPlasticNumber.] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: CreditCard plasticNumberMustHaveSixteenDigits. ].	
	
	self should: [	builder creditCardWithMoreThan16DigitsInItsPlasticNumber.] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: CreditCard plasticNumberMustHaveSixteenDigits. ].! !

!CreditCardTests methodsFor: 'credit card tests' stamp: 'LNB 11/29/2020 16:05:50'!
test03CreditCardOwnerNameCanNotBeEmpty

	self should: [	builder creditCardWithEmptyOwnerName.] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: CreditCard plasticOwnerMustHaveAName. ].	
	! !

!CreditCardTests methodsFor: 'credit card tests' stamp: 'LNB 11/29/2020 16:08:05'!
test04IfOwnerNameHasMoreThanThirtyCharactersThenItGetsTruncated

	| ownerName truncatedOwnerName creditCard |
	
	ownerName := 'Pepito Gabriel de la Santisima Trinidad'.
	truncatedOwnerName := 'Pepito Gabriel de la Santisima'.
	
	creditCard := builder creditCardWithCustomOwnerName: ownerName.
	
	self assert: creditCard ownerName equals: truncatedOwnerName.
	
	
	! !

!CreditCardTests methodsFor: 'credit card tests' stamp: 'LNB 11/29/2020 16:08:13'!
test05CreditCardExpirationDateIsKindaOfGregorianMonthOfYear
	
	self should: [ builder creditCardWithInvalidExpirationDate ] 
	raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: CreditCard expirationDateShouldBeGregorianMonthOfYear. ]. 
	! !


!classDefinition: #InputInterfaceTests category: 'Ejercicio-TusLibros.com'!
TusLibrosExerciseTests subclass: #InputInterfaceTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-TusLibros.com'!

!InputInterfaceTests methodsFor: 'input interface tests' stamp: 'FG 12/2/2020 13:42:49'!
test01CreateACartGeneratesAValidCartID

	| inputInterface users catalogue cartID|
	
	users := builder users.
	catalogue := builder emptyCatalogue.
	
	inputInterface := InputInterface newWith: users andACatalogue: catalogue withClock: SimulatedClock new andCartExpirationOf:(Duration minutes: 30) .
	
	cartID := inputInterface createCartFor: 'Username' withPassword: 'Password'.
	
	self assert: (inputInterface isValidCartID: cartID).! !

!InputInterfaceTests methodsFor: 'input interface tests' stamp: 'FG 12/2/2020 13:46:10'!
test02CantCreateACardForAnInvalidUsername

	| inputInterface users catalogue |
	
	users := builder users.
	catalogue := builder emptyCatalogue.
	
	inputInterface := InputInterface newWith: users andACatalogue: catalogue withClock: SimulatedClock new andCartExpirationOf:(Duration minutes: 30).
	
	self should: [inputInterface createCartFor: 'WrongUser' withPassword: 'Password'] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: InputInterface wrongUsername. ].! !

!InputInterfaceTests methodsFor: 'input interface tests' stamp: 'FG 12/2/2020 13:46:03'!
test03CantCreateACardForAnInvalidPassword

	| inputInterface users catalogue |
	
	users := builder users.
	catalogue := builder emptyCatalogue.
	
	inputInterface := InputInterface newWith: users andACatalogue: catalogue withClock: SimulatedClock new andCartExpirationOf:(Duration minutes: 30).
	
	self should: [inputInterface createCartFor: 'Username' withPassword: 'Wrong Password'] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: InputInterface wrongPassword. ].! !

!InputInterfaceTests methodsFor: 'input interface tests' stamp: 'FG 12/2/2020 13:47:30'!
test04TwoCreatedCartsHaveDifferentIDs

	| inputInterface users catalogue cartID1 cartID2 |
	
	users := builder users.
	catalogue := builder emptyCatalogue.
	
	inputInterface := InputInterface newWith: users andACatalogue: catalogue withClock: SimulatedClock new andCartExpirationOf:(Duration minutes: 30).
	
	cartID1 := inputInterface createCartFor: 'Username' withPassword: 'Password'.
	cartID2 := inputInterface createCartFor: 'Username' withPassword: 'Password'.
	
	self assert: (cartID1 = cartID2) not.! !

!InputInterfaceTests methodsFor: 'input interface tests' stamp: 'FG 12/2/2020 13:49:15'!
test05ListingANewCartShouldReturnAnEmptyBag

	| inputInterface users catalogue cartID |
	
	users := builder users.
	catalogue := builder emptyCatalogue.
	
	inputInterface := InputInterface newWith: users andACatalogue: catalogue withClock: SimulatedClock new andCartExpirationOf:(Duration minutes: 30).
	
	cartID := inputInterface createCartFor: 'Username' withPassword: 'Password'.
	
	self assert: (inputInterface listCart: cartID) equals: Bag new.! !

!InputInterfaceTests methodsFor: 'input interface tests' stamp: 'FG 12/2/2020 14:00:59'!
test06CantListAnInvalidCart

	| inputInterface users catalogue cartID |
	
	users := builder users.
	catalogue := builder emptyCatalogue.
	
	inputInterface := InputInterface newWith: users andACatalogue: catalogue withClock: SimulatedClock new andCartExpirationOf:(Duration minutes: 30).
	
	cartID := 'Este no es un ID'.
	
	self should: [inputInterface listCart: cartID] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: InputInterface wrongCartID. ].! !

!InputInterfaceTests methodsFor: 'input interface tests' stamp: 'FG 12/2/2020 14:12:12'!
test07ListShouldDisplayAddedBooksToTheCart

	| inputInterface users catalogue cartID resultingContents |
	
	users := builder users.
	catalogue := builder catalogueWithABook.
	
	inputInterface := InputInterface newWith: users andACatalogue: catalogue withClock: SimulatedClock new andCartExpirationOf:(Duration minutes: 30).
	
	cartID := inputInterface createCartFor: 'Username' withPassword: 'Password'.
	
	inputInterface addToCart: cartID anAmount: 1 ofABookISBN: builder catalogueFirstBook.
	
	resultingContents := Bag new.
	resultingContents add: builder catalogueFirstBook withOccurrences: 1.
	
	self assert: (inputInterface listCart: cartID) equals: resultingContents.! !

!InputInterfaceTests methodsFor: 'input interface tests' stamp: 'FG 12/2/2020 14:12:20'!
test08CantAddToAnInvalidCart

	| inputInterface users catalogue cartID |
	
	users := builder users.
	catalogue := builder catalogueWithABook.
	
	inputInterface := InputInterface newWith: users andACatalogue: catalogue withClock: SimulatedClock new andCartExpirationOf:(Duration minutes: 30).
	
	cartID := 'Este no es un ID'.
	
	self should: [inputInterface addToCart: cartID anAmount: 1 ofABookISBN: builder catalogueFirstBook.] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: InputInterface wrongCartID. ].! !

!InputInterfaceTests methodsFor: 'input interface tests' stamp: 'FG 12/2/2020 14:12:26'!
test09CantAddToAnExpiredCart

	| inputInterface users catalogue cartID adulteratedClock |
	
	users := builder users.
	catalogue := builder catalogueWithABook.
	
	adulteratedClock := SimulatedClock new.
	
	inputInterface := InputInterface newWith: users andACatalogue: catalogue withClock: adulteratedClock andCartExpirationOf:(Duration minutes: 30).
	
	cartID := inputInterface createCartFor: 'Username' withPassword: 'Password'.
	
	adulteratedClock offsetTimeTo: (Duration minutes: 31).
	
	self should: [inputInterface addToCart: cartID anAmount: 1 ofABookISBN: builder catalogueFirstBook.] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: InputInterface cartAuthenticationExpired. ].! !

!InputInterfaceTests methodsFor: 'input interface tests' stamp: 'FG 12/2/2020 14:03:15'!
test10CantListAnExpiredCart

	| inputInterface users catalogue cartID adulteratedClock |
	
	users := builder users.
	catalogue := builder catalogueWithABook.
	
	adulteratedClock := SimulatedClock new.
	
	inputInterface := InputInterface newWith: users andACatalogue: catalogue withClock: adulteratedClock andCartExpirationOf:(Duration minutes: 30).
	
	cartID := inputInterface createCartFor: 'Username' withPassword: 'Password'.
	
	adulteratedClock offsetTimeTo: (Duration minutes: 31).
	
	self should: [inputInterface listCart: cartID.] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: InputInterface cartAuthenticationExpired. ].! !

!InputInterfaceTests methodsFor: 'input interface tests' stamp: 'FG 12/2/2020 14:13:13'!
test11CheckingOutACartGeneratesAValidSaleID

	| inputInterface users catalogue cartID saleID|
	
	users := builder users.
	catalogue := builder catalogueWithABook.

	inputInterface := InputInterface newWith: users andACatalogue: catalogue withClock: SimulatedClock new andCartExpirationOf:(Duration minutes: 30).
	
	cartID := inputInterface createCartFor: 'Username' withPassword: 'Password'.
	inputInterface addToCart: cartID anAmount: 1 ofABookISBN: builder catalogueFirstBook.
	
	saleID := inputInterface checkoutCart: cartID withPlasticNumber: '0000111122223333' validThrough: '022021'  namedAfter: 'Valid Name'.
	
	self assert: (inputInterface isValidSaleID: saleID).! !

!InputInterfaceTests methodsFor: 'input interface tests' stamp: 'FG 12/2/2020 14:13:21'!
test12CantCheckoutAnExpiredCart

	| inputInterface users catalogue cartID adulteratedClock|
	
	users := builder users.
	catalogue := builder catalogueWithABook.

	adulteratedClock := SimulatedClock new.
	
	inputInterface := InputInterface newWith: users andACatalogue: catalogue withClock: adulteratedClock andCartExpirationOf:(Duration minutes: 30).
	
	cartID := inputInterface createCartFor: 'Username' withPassword: 'Password'.
	inputInterface addToCart: cartID anAmount: 1 ofABookISBN: builder catalogueFirstBook.
	
	adulteratedClock offsetTimeTo: (Duration minutes: 31).
	
	self should: [inputInterface checkoutCart: cartID withPlasticNumber: '0000111122223333' validThrough: '022021'  namedAfter: 'Valid Name'.] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: InputInterface cartAuthenticationExpired. ].! !

!InputInterfaceTests methodsFor: 'input interface tests' stamp: 'FG 12/2/2020 17:56:12'!
test13ListOfPurchasesShowBooksAndTotalAmountFromAllSalesDone

	| inputInterface users catalogue cartID books |
	
	users := builder users.
	catalogue := builder catalogueWithTwoBooks.
	
	inputInterface := InputInterface newWith: users andACatalogue: catalogue withClock: SimulatedClock new andCartExpirationOf:(Duration minutes: 30).
	
	cartID := inputInterface createCartFor: 'Username' withPassword: 'Password'.
	inputInterface addToCart: cartID anAmount: 1 ofABookISBN: builder catalogueFirstBook.
	inputInterface checkoutCart: cartID withPlasticNumber: '0000111122223333' validThrough: '022021'  namedAfter: 'Valid Name'.
	
	cartID := inputInterface createCartFor: 'Username' withPassword: 'Password'.
	inputInterface addToCart: cartID anAmount: 3 ofABookISBN: builder catalogueSecondBook .
	inputInterface checkoutCart: cartID withPlasticNumber: '0000111122223333' validThrough: '022021'  namedAfter: 'Valid Name'.
	
	books := Bag new.
	books add: builder catalogueFirstBook withOccurrences: 1.
	books add: builder catalogueSecondBook withOccurrences: 3.
	 	
	self assert: (inputInterface listPurchasesOf: 'Username' withPassword: 'Password') books equals: books.
	self assert: (inputInterface listPurchasesOf: 'Username' withPassword: 'Password') total equals: 700.0.
	! !

!InputInterfaceTests methodsFor: 'input interface tests' stamp: 'FG 12/2/2020 16:00:09'!
test14CartShouldBeRemovedAfterCheckout

	| inputInterface users catalogue cartID |
	
	users := builder users.
	catalogue := builder catalogueWithTwoBooks.
	
	inputInterface := InputInterface newWith: users andACatalogue: catalogue withClock: SimulatedClock new andCartExpirationOf:(Duration minutes: 30).
	
	cartID := inputInterface createCartFor: 'Username' withPassword: 'Password'.
	inputInterface addToCart: cartID anAmount: 1 ofABookISBN: builder catalogueFirstBook.
	inputInterface checkoutCart: cartID withPlasticNumber: '0000111122223333' validThrough: '022021'  namedAfter: 'Valid Name'.
	 	
	self assert: (inputInterface isValidCartID: cartID) not.! !

!InputInterfaceTests methodsFor: 'input interface tests' stamp: 'FG 12/2/2020 17:25:06'!
test15ExpiredCartShouldBeRemovedBeforeReporting

	| inputInterface users catalogue cartID adulteratedClock |
	
	users := builder users.
	catalogue := builder catalogueWithABook.
	
	adulteratedClock := SimulatedClock new.
	
	inputInterface := InputInterface newWith: users andACatalogue: catalogue withClock: adulteratedClock andCartExpirationOf:(Duration minutes: 30).
	
	cartID := inputInterface createCartFor: 'Username' withPassword: 'Password'.
	
	adulteratedClock offsetTimeTo: (Duration minutes: 31).
	 	
	self should: [inputInterface addToCart: cartID anAmount: 1 ofABookISBN: builder catalogueFirstBook.] 
		raisingAnErrorAndAsserting: [self assert: (inputInterface isValidCartID: cartID) not.].! !

!InputInterfaceTests methodsFor: 'input interface tests' stamp: 'FG 12/2/2020 18:15:57'!
test16CantCheckoutAnInvalidCart

	| inputInterface users catalogue cartID |
	
	users := builder users.
	catalogue := builder catalogueWithABook.

	inputInterface := InputInterface newWith: users andACatalogue: catalogue withClock: SimulatedClock new andCartExpirationOf:(Duration minutes: 30).
	
	cartID := 'Este no es un ID'	.
	
	self should: [inputInterface checkoutCart: cartID withPlasticNumber: '0000111122223333' validThrough: '022021'  namedAfter: 'Valid Name'.] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: InputInterface wrongCartID. ].! !


!classDefinition: #Cart category: 'Ejercicio-TusLibros.com'!
Object subclass: #Cart
	instanceVariableNames: 'books catalogue lastAccess'
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

!Cart methodsFor: 'accesing' stamp: 'FG 11/29/2020 19:42:16'!
total
	| total |
	
	total := 0.
	books do: [:aBook | total := total + (catalogue at: aBook)].
	^total roundUpTo: 0.01.! !


!Cart methodsFor: 'asserting' stamp: 'LNB 11/21/2020 18:30:01'!
assertIsInCatalogue: aBook

	^ (catalogue includesKey: aBook) ifFalse: [self error: Cart cantAddBooksThatAreNotInTheCatalogue]! !

!Cart methodsFor: 'asserting' stamp: 'LNB 11/19/2020 18:59:07'!
assertIsValidQuantity: aQuantity

	aQuantity isInteger ifFalse: [self error: Cart cantAddANonIntegerAmountOfBooks].
	aQuantity strictlyPositive ifFalse: [self error: Cart cantAddANonPositiveAmountOfBooks ]! !


!Cart methodsFor: 'last access control' stamp: 'FG 12/2/2020 00:29:33'!
lastAccessWasBefore: aDuration from: aCurrentDateAndTime 
	
	^ (lastAccess + aDuration < aCurrentDateAndTime)! !

!Cart methodsFor: 'last access control' stamp: 'LNB 12/1/2020 20:49:03'!
updateLastAccessTo: aCurrentDateAndTime
	
	lastAccess := aCurrentDateAndTime.! !


!Cart methodsFor: 'initialization' stamp: 'FG 12/2/2020 00:51:49'!
initializeWith: aCatalogue at: aDateAndTime 

	catalogue := aCatalogue.
	lastAccess := aDateAndTime.
	books := Bag new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'Ejercicio-TusLibros.com'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'intialization' stamp: 'FG 12/2/2020 00:51:35'!
with: aCatalogue at: aDateAndTime 
	^ self basicNew initializeWith: aCatalogue at: aDateAndTime.! !


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

!Cashier methodsFor: 'initialization' stamp: 'LNB 11/29/2020 16:19:41'!
initializeWith: aMerchantProcessor
	
	interface := aMerchantProcessor.! !


!Cashier methodsFor: 'checkout' stamp: 'FG 12/2/2020 02:36:01'!
checkout: aCart payingWith: aCreditCard at: aCurrentGregorianMonthOfYear 
	
	self assertThatCreditCardHasNotExpired: aCreditCard for: aCurrentGregorianMonthOfYear.
	self assertThatCartIsNotEmpty: aCart.
	self assertThatAmountIsNotTooBig: aCart.
	
	^ interface payWith: aCreditCard for: (Sale withProducts: aCart books forATotalOf: aCart total ) requestedBy: self.! !


!Cashier methodsFor: 'checkout reports' stamp: 'LNB 11/25/2020 20:13:53'!
invalidatePurchaseBecauseOf: anError.
	
	self error: anError.! !

!Cashier methodsFor: 'checkout reports' stamp: 'LNB 11/25/2020 20:06:46'!
invalidatePurchaseBecauseOfInvalidParameter
	
	self error: Cashier purchaseInvalidatedByMerchantProcessorBecauseOfInvalidParameter.! !

!Cashier methodsFor: 'checkout reports' stamp: 'FG 11/29/2020 20:03:15'!
reportPayment: aSale
	^ aSale.
	! !


!Cashier methodsFor: 'checkoutAssertions' stamp: 'FG 11/29/2020 20:12:29'!
assertThatAmountIsNotTooBig: aCart
	
	((aCart total) < 1000000000000000) ifFalse:[self error: Cashier amountToBigToProcess].! !

!Cashier methodsFor: 'checkoutAssertions' stamp: 'FG 11/25/2020 14:15:58'!
assertThatCartIsNotEmpty: aCart
	
	aCart isEmpty ifTrue: [self error: Cashier cantCheckoutWithAnEmptyCart].! !

!Cashier methodsFor: 'checkoutAssertions' stamp: 'LNB 11/30/2020 18:16:59'!
assertThatCreditCardHasNotExpired: aCreditCard for: aCurrentGregorianMonthOfYear 	
	
	(aCreditCard expirationDate < GregorianMonthOfYear current) ifTrue: [ self error: Cashier creditCardHasExpired ].! !

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

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LNB 11/29/2020 16:33:32'!
payingThrough: aMerchantProcessor
	^self basicNew initializeWith: aMerchantProcessor.! !

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


!CreditCard methodsFor: 'assertions' stamp: 'LNB 11/30/2020 18:15:31'!
assertNonExpiredCreditCardFor: aCurrentGregorianMonthOfYear
	
	(expirationDate < aCurrentGregorianMonthOfYear) ifTrue: [ self error: CreditCard plasticHasExpired ].! !

!CreditCard methodsFor: 'assertions' stamp: 'FG 11/25/2020 18:02:11'!
assertThatExpirationDateIsGregorianMonthOfYear: creditCardExpiration.
	
	(creditCardExpiration isKindOf: GregorianMonthOfYear) ifFalse: [self error: CreditCard expirationDateShouldBeGregorianMonthOfYear ].! !

!CreditCard methodsFor: 'assertions' stamp: 'FG 11/25/2020 13:46:54'!
assertThatIsValidCreditCardNumber: aCreditCardNumber
	
	(aCreditCardNumber size = 16) ifFalse: [ self error: CreditCard plasticNumberMustHaveSixteenDigits ].
	aCreditCardNumber do: [:aCharacter | (aCharacter isDigit) ifFalse: [self error: CreditCard plasticNumberMustBeMadeOfDigits] ].
	! !

!CreditCard methodsFor: 'assertions' stamp: 'FG 11/25/2020 13:05:56'!
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

!CreditCard class methodsFor: 'error texts' stamp: 'LNB 11/29/2020 16:11:25'!
plasticHasExpired
	^'Cant operate with an expired Credit Card'! !

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


!classDefinition: #Customer category: 'Ejercicio-TusLibros.com'!
Object subclass: #Customer
	instanceVariableNames: 'username password carts sales'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-TusLibros.com'!

!Customer methodsFor: 'initialization' stamp: 'FG 12/2/2020 00:11:58'!
initializeWith: anUsername and: aPassword 
	
	username  := anUsername.
	password  := aPassword.
	carts := Dictionary new.
	sales := Dictionary new.! !


!Customer methodsFor: 'accessing' stamp: 'FG 12/2/2020 01:10:23'!
cartAt: aCartID
	^ carts at: aCartID.! !

!Customer methodsFor: 'accessing' stamp: 'FG 11/29/2020 23:05:41'!
password
	^ password.! !

!Customer methodsFor: 'accessing' stamp: 'FG 12/2/2020 17:52:40'!
totalPurchases

	| totalBooks total |

	totalBooks := Bag new.
	total := 0.

	sales values do:[:aSale | 
			totalBooks addAll: aSale books.	
			total := total + aSale total.
		].
	
	^ Sale withProducts: totalBooks forATotalOf: total. 

	! !

!Customer methodsFor: 'accessing' stamp: 'FG 11/29/2020 23:02:08'!
username 
	^ username.! !


!Customer methodsFor: 'directory manipulation' stamp: 'FG 12/2/2020 01:05:33'!
add: anAmount of: aBookISBN to: aCartID

	| cart |

	cart := (carts at: aCartID).

	cart add: anAmount of: aBookISBN.! !

!Customer methodsFor: 'directory manipulation' stamp: 'FG 12/2/2020 00:56:26'!
addCart: aCart withID: aCartID

	carts add: aCartID -> aCart.! !

!Customer methodsFor: 'directory manipulation' stamp: 'FG 11/29/2020 23:48:15'!
addSale: sale withID: saleID.

	sales add: saleID -> sale.! !

!Customer methodsFor: 'directory manipulation' stamp: 'FG 12/2/2020 13:12:03'!
removeCart: aCartID

	carts removeKey: aCartID.! !

!Customer methodsFor: 'directory manipulation' stamp: 'FG 12/2/2020 01:05:20'!
updateCart: aCartID at: aDateAndTime
	(carts at: aCartID) updateLastAccessTo: aDateAndTime.! !


!Customer methodsFor: 'validation' stamp: 'FG 12/2/2020 00:41:32'!
cartHasExpired: aCartID at: aDateAndTime after: aDuration

	^ (carts at: aCartID) lastAccessWasBefore: aDuration from: aDateAndTime. 
	
	! !

!Customer methodsFor: 'validation' stamp: 'FG 12/1/2020 23:36:36'!
isValidCartID: cartID
	^ carts keys includes: cartID.! !

!Customer methodsFor: 'validation' stamp: 'FG 12/2/2020 01:33:29'!
isValidSaleID: saleID
	^ sales keys includes: saleID.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Customer class' category: 'Ejercicio-TusLibros.com'!
Customer class
	instanceVariableNames: ''!

!Customer class methodsFor: 'initialization' stamp: 'FG 12/2/2020 00:11:38'!
withUsername: anUsername andPassword: aPassword

	^ self basicNew initializeWith: anUsername and: aPassword.! !


!classDefinition: #IDGenerator category: 'Ejercicio-TusLibros.com'!
Object subclass: #IDGenerator
	instanceVariableNames: 'currentID generationProtocol'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-TusLibros.com'!

!IDGenerator methodsFor: 'id generation' stamp: 'FG 12/2/2020 12:36:43'!
generateNewID
	
	currentID := generationProtocol value: currentID.
	^ currentID.! !


!IDGenerator methodsFor: 'initialization' stamp: 'FG 12/2/2020 12:13:55'!
initializeWithID: anID withProtocol: aClosure.

	currentID := anID.
	generationProtocol := aClosure.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IDGenerator class' category: 'Ejercicio-TusLibros.com'!
IDGenerator class
	instanceVariableNames: ''!

!IDGenerator class methodsFor: 'initialization' stamp: 'FG 12/2/2020 12:13:55'!
startingWith: anID withProtocol: aClosure

	^ self basicNew initializeWithID: anID withProtocol: aClosure.! !


!classDefinition: #InputInterface category: 'Ejercicio-TusLibros.com'!
Object subclass: #InputInterface
	instanceVariableNames: 'catalogue cartIDGenerator saleIDGenerator users userByCart clock cartExpirationTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-TusLibros.com'!

!InputInterface methodsFor: 'private' stamp: 'FG 11/29/2020 23:53:32'!
changeDate: aMonthAndYearString

	|month year|
	
	month := (aMonthAndYearString copyFrom: 1 to: 2) asInteger.
	year :=  (aMonthAndYearString copyFrom: 3 to: 6) asInteger.
	
	^ GregorianMonthOfYear year: (GregorianYear createYear: year) month: month.

	! !

!InputInterface methodsFor: 'private' stamp: 'FG 12/2/2020 17:40:27'!
ownerOf: aCartID
	^ (users at: (userByCart at: aCartID)).
	! !

!InputInterface methodsFor: 'private' stamp: 'FG 12/2/2020 17:33:06'!
removeCart: aCartID

	(self ownerOf: aCartID) removeCart: aCartID.
	userByCart removeKey: aCartID.
	
	

	! !


!InputInterface methodsFor: 'initialization' stamp: 'FG 12/2/2020 17:32:28'!
createUserDirectoryFrom: anUsersCollection
	
	| userDirectory |
	
	userDirectory := Dictionary new.
	
	anUsersCollection do: [:anUser | userDirectory add: (anUser username) -> anUser ].
	
	^ userDirectory.
	! !

!InputInterface methodsFor: 'initialization' stamp: 'FG 12/2/2020 17:33:06'!
initializeWithUsers: anUsersCollection withCatalogue: aCatalogue withClock: aClock withCartExpirationOf: aDuration.

	users := self createUserDirectoryFrom: anUsersCollection.
	userByCart := Dictionary new.
	catalogue := aCatalogue.
	clock := aClock.
	cartExpirationTime := aDuration.
	cartIDGenerator := IDGenerator startingWith: '0' withProtocol: [:aCurrentID | (aCurrentID asInteger + 3) asString ].
	saleIDGenerator := IDGenerator startingWith: '5' withProtocol: [:aCurrentID | (aCurrentID asInteger + 1) asString ].! !


!InputInterface methodsFor: 'validations' stamp: 'FG 12/2/2020 17:33:06'!
isValidCartID: aCartID

	^ ((userByCart keys includes: aCartID) and: [(self ownerOf: aCartID) isValidCartID: aCartID])
	
	! !

!InputInterface methodsFor: 'validations' stamp: 'FG 12/2/2020 01:33:10'!
isValidSaleID: aSaleID

	^ (users values allSatisfy: [:user | (user isValidSaleID: aSaleID) not ]) not.	! !

!InputInterface methodsFor: 'validations' stamp: 'FG 12/1/2020 23:38:35'!
validateCartID: aCartID
	
	(self isValidCartID: aCartID) ifFalse: [self error: InputInterface wrongCartID].
	! !

!InputInterface methodsFor: 'validations' stamp: 'FG 12/1/2020 22:59:53'!
validatePassword: aPassword for: anUsername

	((users at: anUsername) password = aPassword) ifFalse: [self error: InputInterface wrongPassword].! !

!InputInterface methodsFor: 'validations' stamp: 'FG 12/2/2020 16:10:38'!
validateThatCartHasNotExpired: aCartID

	((self ownerOf: aCartID) cartHasExpired: aCartID at: clock now after: cartExpirationTime) 
		ifTrue: [
			self removeCart: aCartID.
			self error: InputInterface cartAuthenticationExpired. 
		].

	
	! !

!InputInterface methodsFor: 'validations' stamp: 'FG 12/1/2020 23:30:38'!
validateUsername: anUsername

	(users keys includes: anUsername) ifFalse: [self error: InputInterface wrongUsername].! !


!InputInterface methodsFor: 'export' stamp: 'FG 12/2/2020 17:44:47'!
addToCart: aCartID anAmount: anAmount ofABookISBN: aBookISBN

	self validateCartID: aCartID.
	self validateThatCartHasNotExpired: aCartID.

	(self ownerOf: aCartID) updateCart: aCartID at: clock now.
	(self ownerOf: aCartID) add: anAmount of: aBookISBN to: aCartID.
	! !

!InputInterface methodsFor: 'export' stamp: 'FG 12/2/2020 17:50:42'!
checkoutCart: aCartID withPlasticNumber: aPlasticNumber validThrough: aMonthAndYearString namedAfter: anOwnerName

	| sale saleID |

	self validateCartID: aCartID.
	self validateThatCartHasNotExpired: aCartID.
	
	sale := (Cashier payingThrough: OutputInterfaceSimulator new) 
				checkout: ((self ownerOf: aCartID) cartAt: aCartID) 
				payingWith: (CreditCard withPlasticNumber: aPlasticNumber namedAfter: anOwnerName validThrough: (self changeDate: aMonthAndYearString)) 
				at: clock now.
				
	saleID := saleIDGenerator generateNewID.
	
	(self ownerOf: aCartID) addSale: sale withID: saleID.
	self removeCart: aCartID.

	^ saleID.	! !

!InputInterface methodsFor: 'export' stamp: 'FG 12/2/2020 17:33:06'!
createCartFor: anUsername withPassword: aPassword
	
	| cartID |
	
	self validateUsername: anUsername.
	self validatePassword: aPassword for: anUsername.
	
	cartID := cartIDGenerator generateNewID.
	
	userByCart add: cartID -> anUsername.
	(users at: anUsername) addCart: (Cart with: catalogue at: clock now) withID: cartID.

	^ cartID.! !

!InputInterface methodsFor: 'export' stamp: 'FG 12/2/2020 01:20:05'!
listCart: aCartID

	self validateCartID: aCartID.
	self validateThatCartHasNotExpired: aCartID.
	
	(self ownerOf: aCartID) updateCart: aCartID at: clock now.
	^ ((self ownerOf: aCartID) cartAt: aCartID) books.! !

!InputInterface methodsFor: 'export' stamp: 'FG 12/2/2020 02:39:31'!
listPurchasesOf: anUsername withPassword: aPassword
	
	self validateUsername: anUsername.
	self validatePassword: aPassword for: anUsername.
	
	^ (users at: anUsername) totalPurchases.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InputInterface class' category: 'Ejercicio-TusLibros.com'!
InputInterface class
	instanceVariableNames: ''!

!InputInterface class methodsFor: 'errors' stamp: 'LNB 11/30/2020 19:30:46'!
cartAuthenticationExpired

	^'The authentication for this cart has expired.'! !

!InputInterface class methodsFor: 'errors' stamp: 'LNB 11/29/2020 18:14:03'!
wrongCartID

	^'Invalid CartID'! !

!InputInterface class methodsFor: 'errors' stamp: 'LNB 11/29/2020 17:18:35'!
wrongPassword

	^'Invalid password'! !

!InputInterface class methodsFor: 'errors' stamp: 'LNB 11/29/2020 17:13:34'!
wrongUsername

	^'Invalid username'! !


!InputInterface class methodsFor: 'initialization' stamp: 'FG 12/2/2020 01:14:13'!
newWith: anUsersCollection andACatalogue: aCatalogue withClock: aClock andCartExpirationOf: aDuration

	^self basicNew initializeWithUsers: anUsersCollection withCatalogue: aCatalogue withClock: aClock withCartExpirationOf: aDuration.! !


!classDefinition: #OutputInterfaceSimulator category: 'Ejercicio-TusLibros.com'!
Object subclass: #OutputInterfaceSimulator
	instanceVariableNames: 'expectedBehaviourBlock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-TusLibros.com'!

!OutputInterfaceSimulator methodsFor: 'change behaviour' stamp: 'FG 11/29/2020 20:09:27'!
invalidateNextPurchaseForACustomErrorDescription: anErrorDescription
	expectedBehaviourBlock _ [ :aCashier :aSale |
	aCashier invalidatePurchaseBecauseOf: anErrorDescription ].! !

!OutputInterfaceSimulator methodsFor: 'change behaviour' stamp: 'FG 11/29/2020 20:09:17'!
invalidateNextPurchasesBecauseOfInvalidParameters
	expectedBehaviourBlock _ [ :aCashier :aSale |
	aCashier invalidatePurchaseBecauseOfInvalidParameter ].! !

!OutputInterfaceSimulator methodsFor: 'change behaviour' stamp: 'FG 11/29/2020 20:09:08'!
nextPurchasesAreValidAndNeedToBeReported
	expectedBehaviourBlock _ [ :aCashier :aSale |
	aCashier reportPayment: aSale ].! !


!OutputInterfaceSimulator methodsFor: 'initialize' stamp: 'LNB 11/29/2020 16:01:18'!
initialize
	self nextPurchasesAreValidAndNeedToBeReported.! !


!OutputInterfaceSimulator methodsFor: 'simulate' stamp: 'FG 11/29/2020 20:08:45'!
payWith: aCreditCard for: aSale requestedBy: aCashier

	"mandar al merchantProcesor"
	
	^expectedBehaviourBlock value: aCashier value: aSale.
	! !


!classDefinition: #Sale category: 'Ejercicio-TusLibros.com'!
Object subclass: #Sale
	instanceVariableNames: 'total books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-TusLibros.com'!

!Sale methodsFor: 'accessing' stamp: 'FG 11/29/2020 20:00:19'!
books
	^ books. ! !

!Sale methodsFor: 'accessing' stamp: 'FG 11/29/2020 20:00:04'!
total
	^ total.! !


!Sale methodsFor: 'initialization' stamp: 'FG 12/2/2020 02:32:47'!
initializeWithProducts: aBagOfProducts forATotalOf: anAmount
	books := aBagOfProducts.
	total := anAmount.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'Ejercicio-TusLibros.com'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'initialization' stamp: 'FG 12/2/2020 02:30:58'!
withProducts: aBagOfProducts forATotalOf: anAmount
	^ self basicNew initializeWithProducts: aBagOfProducts forATotalOf: anAmount.! !


!classDefinition: #SimulatedClock category: 'Ejercicio-TusLibros.com'!
Object subclass: #SimulatedClock
	instanceVariableNames: 'offset'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-TusLibros.com'!

!SimulatedClock methodsFor: 'initialization' stamp: 'LNB 12/1/2020 20:55:35'!
initialize
	offset := Duration minutes: 0.! !


!SimulatedClock methodsFor: 'set offset' stamp: 'LNB 11/30/2020 19:29:10'!
offsetTimeTo: anOffsetDuration
	offset := anOffsetDuration.! !


!SimulatedClock methodsFor: 'now' stamp: 'LNB 11/30/2020 20:05:53'!
now
	^DateAndTime now + offset.! !


!classDefinition: #TestObjectBuilder category: 'Ejercicio-TusLibros.com'!
Object subclass: #TestObjectBuilder
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-TusLibros.com'!

!TestObjectBuilder methodsFor: 'build credit cards' stamp: 'LNB 11/29/2020 15:55:30'!
creditCardWithCustomExpirationDate: anExpirationDate
	^ CreditCard
		withPlasticNumber: '0000000000000000'
		namedAfter: 'Pepito'
		validThrough: anExpirationDate.! !

!TestObjectBuilder methodsFor: 'build credit cards' stamp: 'LNB 11/29/2020 15:56:12'!
creditCardWithCustomOwnerName: anOwnerName
	^ CreditCard
		withPlasticNumber: '0000000000000000'
		namedAfter: anOwnerName
		validThrough:
			(GregorianMonthOfYear
				year: (GregorianYear number: today yearNumber + 1)
				monthNumber: today monthIndex).! !

!TestObjectBuilder methodsFor: 'build credit cards' stamp: 'LNB 11/29/2020 15:57:04'!
creditCardWithEmptyOwnerName
	^ CreditCard
		withPlasticNumber: '0000000009000000'
		namedAfter: ''
		validThrough:
			(GregorianMonthOfYear
				year: (GregorianYear number: today yearNumber + 1)
				monthNumber: today monthIndex).! !

!TestObjectBuilder methodsFor: 'build credit cards' stamp: 'LNB 11/29/2020 15:57:24'!
creditCardWithInvalidExpirationDate
	^ CreditCard
		withPlasticNumber: '0000000000000000'
		namedAfter: 'Pepito'
		validThrough: 0596.! !

!TestObjectBuilder methodsFor: 'build credit cards' stamp: 'LNB 11/29/2020 15:57:59'!
creditCardWithInvalidPlasticNumber
	^ CreditCard
		withPlasticNumber: 'NaN %&/NaNNaNNaN'
		namedAfter: 'Pepito'
		validThrough:
			(GregorianMonthOfYear
				year: (GregorianYear number: today yearNumber + 1)
				monthNumber: today monthIndex).! !

!TestObjectBuilder methodsFor: 'build credit cards' stamp: 'LNB 11/29/2020 15:58:30'!
creditCardWithLessThan16DigitsInItsPlasticNumber
	^ CreditCard
		withPlasticNumber: '000000000900000'
		namedAfter: 'Pepito'
		validThrough:
			(GregorianMonthOfYear
				year: (GregorianYear number: today yearNumber + 1)
				monthNumber: today monthIndex).! !

!TestObjectBuilder methodsFor: 'build credit cards' stamp: 'LNB 11/29/2020 15:58:38'!
creditCardWithMoreThan16DigitsInItsPlasticNumber
	^ CreditCard
		withPlasticNumber: '00000000090000000'
		namedAfter: 'Pepito'
		validThrough:
			(GregorianMonthOfYear
				year: (GregorianYear number: today yearNumber + 1)
				monthNumber: today monthIndex).! !

!TestObjectBuilder methodsFor: 'build credit cards' stamp: 'LNB 11/29/2020 15:59:34'!
expiredCreditCard
	^CreditCard 
		withPlasticNumber: '0000000000000000' 
		namedAfter: 'Pepito'
		validThrough: (GregorianMonthOfYear year: (GregorianYear number: today yearNumber - 1) monthNumber: today monthIndex).! !

!TestObjectBuilder methodsFor: 'build credit cards' stamp: 'LNB 11/29/2020 15:59:54'!
validCreditCard
	^ CreditCard
		withPlasticNumber: '0000000000000000'
		namedAfter: 'Pepito'
		validThrough:
			(GregorianMonthOfYear
				year: (GregorianYear number: today yearNumber + 1)
				monthNumber: today monthIndex).! !


!TestObjectBuilder methodsFor: 'build time objects' stamp: 'LNB 11/30/2020 18:27:15'!
currentMonthOfYear

	^ (Month month: today monthIndex year: today yearNumber).! !


!TestObjectBuilder methodsFor: 'build users' stamp: 'FG 12/2/2020 13:38:38'!
users

	^ OrderedCollection with: (Customer withUsername: 'Username' andPassword: 'Password')
	! !


!TestObjectBuilder methodsFor: 'build catalogue' stamp: 'FG 12/2/2020 13:41:13'!
catalogueWithABook

	| catalogue |
	
	catalogue := Dictionary new.
	catalogue add: 'mathBook'->100.
	
	^ catalogue.
	! !

!TestObjectBuilder methodsFor: 'build catalogue' stamp: 'FG 12/2/2020 14:37:30'!
catalogueWithABookWithAnOverlySpecificPrice

	| catalogue |
	
	catalogue := Dictionary new.
	catalogue add: 'mathBook'->100.002.
	
	^ catalogue.! !

!TestObjectBuilder methodsFor: 'build catalogue' stamp: 'FG 12/2/2020 14:34:12'!
catalogueWithOverlyExpensiveBook

	| catalogue |
	
	catalogue := Dictionary new.
	catalogue add: 'mathBook'->1000000000000000.
	
	^ catalogue.! !

!TestObjectBuilder methodsFor: 'build catalogue' stamp: 'FG 12/2/2020 13:41:27'!
catalogueWithTwoBooks

	| catalogue |
	
	catalogue := Dictionary new.
	catalogue add: 'mathBook'->100.
	catalogue add: 'historyBook' -> 200.
	
	^ catalogue.
	! !

!TestObjectBuilder methodsFor: 'build catalogue' stamp: 'FG 12/2/2020 13:39:45'!
emptyCatalogue

	^ Dictionary new.
	! !


!TestObjectBuilder methodsFor: 'catalogue information' stamp: 'FG 12/2/2020 14:10:55'!
catalogueFirstBook
	^ 'mathBook'! !

!TestObjectBuilder methodsFor: 'catalogue information' stamp: 'FG 12/2/2020 14:11:04'!
catalogueSecondBook
	^ 'historyBook'! !


!TestObjectBuilder methodsFor: 'initialization' stamp: 'LNB 11/29/2020 15:56:33'!
initializeAt: aCurrentDateAndTime
	
	today := aCurrentDateAndTime.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TestObjectBuilder class' category: 'Ejercicio-TusLibros.com'!
TestObjectBuilder class
	instanceVariableNames: ''!

!TestObjectBuilder class methodsFor: 'as yet unclassified' stamp: 'LNB 11/29/2020 15:54:59'!
at: aCurrentDateAndTime
	^self basicNew initializeAt: aCurrentDateAndTime.! !
