!classDefinition: #CartTest category: 'TusLibros-Iteracion3'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'PJ 11/29/2020 18:48:23'!
test09CartDoesntAddAnyItemsIntoTheListWhenItIsEmpty

	| cart cartList|
	
	cart := testObjectsFactory createCart.
	cartList := OrderedCollection new.
	
	cart addItemsWithQuantityTo: cartList.
	self assert: cartList isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'PJ 11/29/2020 19:06:16'!
test10CartAddsItsItemsIntoTheListWhenItIsNotEmpty

	| cart cartList bookIsbn1 bookIsbn2|
	
	cartList := OrderedCollection new.
	cart := testObjectsFactory createCart.
	bookIsbn1 := testObjectsFactory itemSellByTheStore.
	bookIsbn2 := testObjectsFactory secondItemSellByTheStore.
	
	cart add: 3 of: bookIsbn1.
	cart add: 6 of: bookIsbn2.
	cart add: 2 of: bookIsbn1.
	
	cart addItemsWithQuantityTo: cartList.
	
	self assert: 4 equals: cartList size.
	
	self assert: bookIsbn1 equals: (cartList at: 1).
	self assert: 5 equals: (cartList at: 2).
	
	self assert: bookIsbn2 equals: (cartList at: 3).
	self assert: 6 equals: (cartList at: 4).! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros-Iteracion3'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'PJ 11/29/2020 20:05:17'!
test04CheckoutRegistersASale

	| cart cashier salesBook total cartList|

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 	cartList := OrderedCollection new.
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
	cart addItemsWithQuantityTo: cartList.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.
	self assert: salesBook first itemsSold = cartList.
	! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #CreditCardTest category: 'TusLibros-Iteracion3'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!CreditCardTest methodsFor: 'tests' stamp: 'PGTA 12/2/2020 23:55:31'!
test01_newCreditCardCantHaveEmptyNumber
	
	self should: [ CreditCard withNumber: '' owner: 'Pepe Sánchez' expirationDate: '022021'. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard wrongCreditCardNumberErrorDescription.! !

!CreditCardTest methodsFor: 'tests' stamp: 'PGTA 12/2/2020 23:56:01'!
test02_cannotCreateCreditCardWithEmptyExpirationDate
	
	self should: [ CreditCard withNumber: '1234123' owner: 'Pepe Sánchez' expirationDate: ''. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard wrongCreditCardExpirationDateErrorDescription.! !

!CreditCardTest methodsFor: 'tests' stamp: 'PGTA 12/2/2020 23:56:23'!
test03_cannotCreateCreditCardWithInvalidInputExpirationDate
	
	self should: [ CreditCard withNumber: '1234123' owner: 'Pepe Sánchez' expirationDate: '022021abc'. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard wrongCreditCardExpirationDateErrorDescription.! !

!CreditCardTest methodsFor: 'tests' stamp: 'PGTA 12/2/2020 23:57:02'!
test04_cannotCreateCreditCardWithInvalidInputStringInNumber
	
	self should: [ CreditCard withNumber: '1234dfgh123' owner: 'Pepe Sánchez' expirationDate: '022021'. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard wrongCreditCardNumberErrorDescription.! !

!CreditCardTest methodsFor: 'tests' stamp: 'PGTA 12/2/2020 23:57:16'!
test05_cannotCreateCreditCardWithMoreThanSixDigitsInExpirationDate
	
	self should: [ CreditCard withNumber: '1234123' owner: 'Pepe Sánchez' expirationDate: '022021111'. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard wrongCreditCardExpirationDateErrorDescription.! !

!CreditCardTest methodsFor: 'tests' stamp: 'PGTA 12/2/2020 23:57:28'!
test06_cannotCreateCreditCardWithInvalidMonthExpirationDate
	
	self should: [ CreditCard withNumber: '1234123' owner: 'Pepe Sánchez' expirationDate: '232050'. ]
		raise: Error.! !

!CreditCardTest methodsFor: 'tests' stamp: 'PGTA 12/2/2020 23:57:41'!
test07_cannotCreateCreditCardWithEmptyOwnerString
	
	self should: [ CreditCard withNumber: '1234123' owner: '' expirationDate: '022021'. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard wrongCreditCardOwnerErrorDescription.! !

!CreditCardTest methodsFor: 'tests' stamp: 'PGTA 12/2/2020 23:57:53'!
test08_creditCardKnowsItsCardNumber
	| ccard |
	
	ccard := CreditCard withNumber: '1234123' owner: 'Pepe' expirationDate: '022021'.
	self assert: '1234123' equals: ccard cardNumber.! !

!CreditCardTest methodsFor: 'tests' stamp: 'PGTA 12/2/2020 23:58:08'!
test09_creditCardKnowsItsOwnerName
	| ccard |
	
	ccard := CreditCard withNumber: '1234123' owner: 'Pepe' expirationDate: '022021'.
	self assert: 'Pepe' equals: ccard ownerName.! !

!CreditCardTest methodsFor: 'tests' stamp: 'PGTA 12/3/2020 00:21:00'!
test10_creditCardKnowsItsExpirationDate
	| ccard expDate |
	
	expDate := Month month: 02 year: 2021.
	
	ccard := CreditCard withNumber: '1234123' owner: 'Pepe' expirationDate: '022021'.
	self assert: expDate = ccard expirationDate! !

!CreditCardTest methodsFor: 'tests' stamp: 'PGTA 12/3/2020 00:22:10'!
test11_creditCardKnowsIfItsExpired
	| ccard |
	
	ccard := CreditCard withNumber: '1234123' owner: 'Pepe' expirationDate: '022019'.
	self assert: (ccard isExpiredOn: (Month month: 04 year: 2020)).! !


!classDefinition: #TusLibrosInterfaceTest category: 'TusLibros-Iteracion3'!
TestCase subclass: #TusLibrosInterfaceTest
	instanceVariableNames: 'testObjectsFactory authenticateBehavior clockSimulator tusLibrosIface'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!TusLibrosInterfaceTest methodsFor: 'setup' stamp: 'PGTA 12/1/2020 20:41:52'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	authenticateBehavior := [:aClientId :aPassword|].
	clockSimulator := DateAndTime now.
	tusLibrosIface := testObjectsFactory createTusLibrosInterfaceWith: self andMerchant: CashierTest new setUp clock: self.! !


!TusLibrosInterfaceTest methodsFor: 'clock simulator' stamp: 'PJ 11/30/2020 22:42:33'!
advance15minutes
	clockSimulator := clockSimulator + 15 minutes.! !

!TusLibrosInterfaceTest methodsFor: 'clock simulator' stamp: 'PJ 11/30/2020 20:52:35'!
advance30Minutes
	
	clockSimulator := clockSimulator + 30 minutes.! !

!TusLibrosInterfaceTest methodsFor: 'clock simulator' stamp: 'PJ 11/30/2020 20:44:10'!
now
	^clockSimulator.! !


!TusLibrosInterfaceTest methodsFor: 'authenticator simulator' stamp: 'PJ 11/28/2020 17:21:52'!
authenticate: aClientId password: aPassword 

	^authenticateBehavior value: aClientId value: aPassword ! !


!TusLibrosInterfaceTest methodsFor: '1-create and list cart' stamp: 'PGTA 12/1/2020 20:58:47'!
test01_CannotCreateCartWithInvalidClient

	authenticateBehavior := [:aClientId :aPassword| self error: TusLibrosInterface invalidClientErrorDescription ].
	
	self should: [tusLibrosIface createCartWithClient: 'invalid' password: 'test1234']
		raise: Error - MessageNotUnderstood
		withMessageText: TusLibrosInterface invalidClientErrorDescription.! !

!TusLibrosInterfaceTest methodsFor: '1-create and list cart' stamp: 'PGTA 12/1/2020 20:42:37'!
test02_CannotCreateCartWithInvalidPassword

	authenticateBehavior := [:aClientId :aPassword| self error: TusLibrosInterface invalidPasswordErrorDescription].
	
	self should: [tusLibrosIface createCartWithClient: '1239' password: 'invalid']
		raise: Error - MessageNotUnderstood
		withMessageText: TusLibrosInterface invalidPasswordErrorDescription.! !

!TusLibrosInterfaceTest methodsFor: '1-create and list cart' stamp: 'PGTA 12/1/2020 20:43:14'!
test03_InterfaceCanCreateACartAndIsEmpty

	| cartId cartList| 
	
	cartId := tusLibrosIface createCartWithClient: '1239' password: 'test123'.
	cartList := tusLibrosIface 	listCart: cartId.
	
	self assert: cartList isEmpty.
	! !

!TusLibrosInterfaceTest methodsFor: '1-create and list cart' stamp: 'PGTA 12/1/2020 21:02:41'!
test04_InterfaceCannotListAnInvalidCartId

	| cartId invalidCartId | 
	
	invalidCartId := 'invalid'.
	
	cartId := tusLibrosIface createCartWithClient: '1239' password: 'test123'.
	
	self assert: (cartId = invalidCartId) not.
	
	self should: [tusLibrosIface 	listCart: invalidCartId]
		raise: Error - MessageNotUnderstood
		withMessageText: TusLibrosInterface invalidCartIdErrorDescription.
	! !

!TusLibrosInterfaceTest methodsFor: '1-create and list cart' stamp: 'PGTA 12/1/2020 21:02:57'!
test05_InterfaceCanCreateManyCarts

	| cartId1 cartId2| 
	
	cartId1 := tusLibrosIface createCartWithClient: '1239' password: 'test123'.
	cartId2 := tusLibrosIface createCartWithClient: '1238' password: 'test123'.
	
	self assert: (tusLibrosIface 	listCart: cartId1) isEmpty.
	self assert: (tusLibrosIface 	listCart: cartId2) isEmpty.! !


!TusLibrosInterfaceTest methodsFor: '2-add books and list cart' stamp: 'PGTA 12/1/2020 21:06:03'!
test06_InterfaceCanAddBooksIntoACartAndListThem

	| cartId cartList bookIsbn | 
	
	bookIsbn := testObjectsFactory itemSellByTheStore.
	
	cartId := tusLibrosIface createCartWithClient: '1239' password: 'test123'.
	tusLibrosIface addToCart: cartId isbn: bookIsbn quantity: 5.
	
	cartList := tusLibrosIface 	listCart: cartId.
	
	self assert: 2 equals: cartList size.
	self assert: bookIsbn equals: (cartList at: 1).
	self assert: 5 equals: (cartList at: 2).	
	! !

!TusLibrosInterfaceTest methodsFor: '2-add books and list cart' stamp: 'PGTA 12/1/2020 21:11:26'!
test07_InterfaceCannotAddBooksIntoAnInvalidCart

	| cartId bookIsbn invalidCartId |
	
	invalidCartId := 'invalid'. 
	
	bookIsbn := testObjectsFactory itemSellByTheStore.
	
	cartId := tusLibrosIface createCartWithClient: '1239' password: 'test123'.
	
	self assert: (invalidCartId = cartId) not.
	
	self should: [tusLibrosIface addToCart: invalidCartId isbn: bookIsbn quantity: 5]
		raise: Error - MessageNotUnderstood 
		withMessageText: TusLibrosInterface invalidCartIdErrorDescription.
	
	! !


!TusLibrosInterfaceTest methodsFor: '3-checkout cart' stamp: 'PGTA 12/1/2020 21:58:08'!
test08_InterfaceCannotCheckoutAnInvalidCart

	| cartId bookIsbn invalidCartId|
	
	invalidCartId := 'invalid'. 
	
	bookIsbn := testObjectsFactory itemSellByTheStore.
	
	cartId := tusLibrosIface createCartWithClient: '1239' password: 'test123'.
	tusLibrosIface addToCart: cartId isbn: bookIsbn quantity: 2.
	
	self assert: (invalidCartId = cartId) not.
	
	self should: [tusLibrosIface checkoutCart: invalidCartId cardNumber: '12345458' expDate: '052025' ownerName: 'Pepe Sanchez']
		raise: Error - MessageNotUnderstood 
		withMessageText: TusLibrosInterface invalidCartIdErrorDescription.
	
	! !

!TusLibrosInterfaceTest methodsFor: '3-checkout cart' stamp: 'PGTA 12/1/2020 22:08:50'!
test09_InterfaceRaisesCashierErrorIfCartIsEmpty

	| cartId|
	
	cartId := tusLibrosIface createCartWithClient: '1239' password: 'test123'.
	
	self should: [tusLibrosIface checkoutCart: cartId cardNumber: '12345458' expDate: '052025' ownerName: 'Pepe Sanchez']
		raise: Error - MessageNotUnderstood 
		withMessageText: Cashier cartCanNotBeEmptyErrorMessage.
	
	! !

!TusLibrosInterfaceTest methodsFor: '3-checkout cart' stamp: 'PGTA 12/3/2020 00:36:06'!
test10b_InterfaceTransactionIDIsDifferentForDifferentCheckOuts

	| cartId bookIsbn transactionId1 transactionId2 |
	
	bookIsbn := testObjectsFactory itemSellByTheStore.
	
	cartId := tusLibrosIface createCartWithClient: '1239' password: 'test123'.
	tusLibrosIface addToCart: cartId isbn: bookIsbn quantity: 2.
	transactionId1 := tusLibrosIface checkoutCart: cartId cardNumber: '12345458' expDate: '052025' ownerName: 'Pepe Sanchez'.
	
	cartId := tusLibrosIface createCartWithClient: '1239' password: 'test123'.
	tusLibrosIface addToCart: cartId isbn: bookIsbn quantity: 2.
	transactionId2 := tusLibrosIface checkoutCart: cartId cardNumber: '12345458' expDate: '052025' ownerName: 'Pepe Sanchez'.
	
	self assert: (transactionId1 = transactionId2) not.! !

!TusLibrosInterfaceTest methodsFor: '3-checkout cart' stamp: 'PGTA 12/1/2020 21:58:08'!
test10_InterfaceSuccessfullyMakesASale

	| cartId bookIsbn transactionId|
	
	bookIsbn := testObjectsFactory itemSellByTheStore.
	
	cartId := tusLibrosIface createCartWithClient: '1239' password: 'test123'.
	tusLibrosIface addToCart: cartId isbn: bookIsbn quantity: 2.
	
	transactionId := tusLibrosIface checkoutCart: cartId cardNumber: '12345458' expDate: '052025' ownerName: 'Pepe Sanchez'.
	
	self assert: transactionId isEmpty not.
	
	! !


!TusLibrosInterfaceTest methodsFor: '4-list purchases' stamp: 'PGTA 12/1/2020 20:46:16'!
test11_NewInterfaceHasNoSales

	| purchaseList |
	
	purchaseList := 	tusLibrosIface listPurchasesFor: '1234' password: 'test1234'.
	
	self assert: purchaseList isEmpty.! !

!TusLibrosInterfaceTest methodsFor: '4-list purchases' stamp: 'PGTA 12/1/2020 20:46:48'!
test12_CannotListPurchasesForAnInvalidClient
	
	authenticateBehavior := [:aClientId :aPassword| self error: TusLibrosInterface invalidClientErrorDescription ].	
	
	self should: [tusLibrosIface listPurchasesFor: '1234' password: 'test1234']
		raise: Error - MessageNotUnderstood
		withMessageText: TusLibrosInterface invalidClientErrorDescription.! !

!TusLibrosInterfaceTest methodsFor: '4-list purchases' stamp: 'PGTA 12/1/2020 20:47:02'!
test13_CannotListPurchasesForAClientWithAnInvalidPassword
	
	authenticateBehavior := [:aClientId :aPassword| self error: TusLibrosInterface invalidPasswordErrorDescription].	
	
	self should: [tusLibrosIface listPurchasesFor: '1234' password: 'test1234']
		raise: Error - MessageNotUnderstood
		withMessageText: TusLibrosInterface invalidPasswordErrorDescription .! !

!TusLibrosInterfaceTest methodsFor: '4-list purchases' stamp: 'PGTA 12/1/2020 21:58:08'!
test14_InterfaceCanListOneClientPurchase

	| cartId bookIsbn purchaseList clientId password total quantity|
	
	clientId := '1239'.
	password := 'test123'.
	quantity := 2.
	bookIsbn := testObjectsFactory itemSellByTheStore.
	total := testObjectsFactory itemSellByTheStorePrice * quantity.
	
	cartId := tusLibrosIface createCartWithClient: clientId password: password .
	tusLibrosIface addToCart: cartId isbn: bookIsbn quantity: quantity.
	
	tusLibrosIface checkoutCart: cartId cardNumber: '12345458' expDate: '052025' ownerName: 'Pepe Sanchez'.
	
	purchaseList := tusLibrosIface listPurchasesFor: clientId password: password.
	
	self assert: 3 equals: purchaseList size.
	self assert: bookIsbn equals: (purchaseList at: 1).
	self assert: quantity equals: (purchaseList at: 2).
	self assert: total equals: (purchaseList at: 3).
	! !

!TusLibrosInterfaceTest methodsFor: '4-list purchases' stamp: 'PGTA 12/1/2020 21:58:08'!
test15_InterfaceCanListMoreThanOnePurchaseFromAClient

	| cartId1 cartId2 bookIsbn1 bookIsbn2 purchaseList clientId password total quantity|
	
	clientId := '1239'.
	password := 'test123'.
	quantity := 2.
	bookIsbn1 := testObjectsFactory itemSellByTheStore.
	bookIsbn2 := testObjectsFactory secondItemSellByTheStore.
	total := (testObjectsFactory itemSellByTheStorePrice * quantity) + (testObjectsFactory secondItemSellByTheStorePrice * (quantity + 1)).
		
	cartId1 := tusLibrosIface createCartWithClient: clientId password: password .
	tusLibrosIface addToCart: cartId1 isbn: bookIsbn1 quantity: quantity.
	tusLibrosIface checkoutCart: cartId1 cardNumber: '12345458' expDate: '052025' ownerName: 'Pepe Sanchez'.
	
	cartId2 := tusLibrosIface createCartWithClient: clientId password: password .
	tusLibrosIface addToCart: cartId2 isbn: bookIsbn2 quantity: (quantity + 1).
	tusLibrosIface checkoutCart: cartId2 cardNumber: '12345458' expDate: '052025' ownerName: 'Pepe Sanchez'.
	
	purchaseList := tusLibrosIface listPurchasesFor: clientId password: password.
	
	self assert: 5 equals: purchaseList size.
	self assert: bookIsbn1 equals: (purchaseList at: 1).
	self assert: quantity equals: (purchaseList at: 2).
	self assert: bookIsbn2 equals: (purchaseList at: 3).
	self assert: (quantity + 1) equals: (purchaseList at: 4).
	self assert: total equals: (purchaseList at: 5).
	! !

!TusLibrosInterfaceTest methodsFor: '4-list purchases' stamp: 'PGTA 12/1/2020 21:58:07'!
test16_InterfaceCanListPurchasesFromMoreThanOneClient
	
	| cartId1 cartId2 bookIsbn1 bookIsbn2 purchaseList1 purchaseList2 clientId1 clientId2 password total1 total2 quantity|
	
	clientId1 := '1239'.
	clientId2 := '5678'.
	password := 'test123'.
	quantity := 2.
	bookIsbn1 := testObjectsFactory itemSellByTheStore.
	bookIsbn2 := testObjectsFactory secondItemSellByTheStore.
	total1 := (testObjectsFactory itemSellByTheStorePrice * quantity).
	total2 := (testObjectsFactory secondItemSellByTheStorePrice * (quantity + 1)).
	
	cartId1 := tusLibrosIface createCartWithClient: clientId1 password: password .
	tusLibrosIface addToCart: cartId1 isbn: bookIsbn1 quantity: quantity.
	tusLibrosIface checkoutCart: cartId1 cardNumber: '12345458' expDate: '052025' ownerName: 'Pepe Sanchez'.
	
	purchaseList1 := tusLibrosIface listPurchasesFor: clientId1 password: password.
	
	cartId2 := tusLibrosIface createCartWithClient: clientId2 password: password .
	tusLibrosIface addToCart: cartId2 isbn: bookIsbn2 quantity: (quantity + 1).
	tusLibrosIface checkoutCart: cartId2 cardNumber: '14556458' expDate: '102030' ownerName: 'Ana Sanchez'.
	
	purchaseList2 := tusLibrosIface listPurchasesFor: clientId2 password: password.
	
	self assert: 3 equals: purchaseList1 size.
	self assert: bookIsbn1 equals: (purchaseList1 at: 1).
	self assert: quantity equals: (purchaseList1 at: 2).
	self assert: total1 equals: (purchaseList1 at: 3).
	
	self assert: 3 equals: purchaseList2 size.
	self assert: bookIsbn2 equals: (purchaseList2 at: 1).
	self assert: (quantity + 1) equals: (purchaseList2 at: 2).
	self assert: total2 equals: (purchaseList2 at: 3).
	! !


!TusLibrosInterfaceTest methodsFor: '5-cart expiration' stamp: 'PGTA 12/1/2020 20:48:43'!
test17_InterfaceCannotListAnExpiredCart
	
	| cartId1 clientId1 password |
	
	clientId1 := '1239'.
	password := 'test123'.
	
	cartId1 := tusLibrosIface createCartWithClient: clientId1 password: password.
	
	self advance30Minutes.
	
	self should: [tusLibrosIface listCart: cartId1]
		raise: Error - MessageNotUnderstood
		withMessageText: TusLibrosInterface expiredCartErrorDescription.
	
	
	! !

!TusLibrosInterfaceTest methodsFor: '5-cart expiration' stamp: 'PGTA 12/1/2020 20:49:04'!
test18_InterfaceCannotAddToAnExpiredCart
	
	| cartId1 clientId1 password bookIsbn|
	
	clientId1 := '1239'.
	password := 'test123'.
	bookIsbn := testObjectsFactory itemSellByTheStore.
	
	cartId1 := tusLibrosIface createCartWithClient: clientId1 password: password.
	
	self advance30Minutes.
	
	self should: [tusLibrosIface addToCart: cartId1 isbn: bookIsbn quantity: 5.]
		raise: Error - MessageNotUnderstood
		withMessageText: TusLibrosInterface expiredCartErrorDescription.
	
	
	
	! !

!TusLibrosInterfaceTest methodsFor: '5-cart expiration' stamp: 'PGTA 12/1/2020 21:58:07'!
test19_InterfaceCannotCheckoutAnExpiredCart
	
	| cartId1 clientId1 password bookIsbn|
	
	clientId1 := '1239'.
	password := 'test123'.
	bookIsbn := testObjectsFactory itemSellByTheStore.
	
	cartId1 := tusLibrosIface createCartWithClient: clientId1 password: password.
	tusLibrosIface addToCart: cartId1 isbn: bookIsbn quantity: 5.
	
	self advance30Minutes.
	
	self should: [tusLibrosIface checkoutCart: cartId1 cardNumber: '124345' expDate: '052025' ownerName: 'pepito']
		raise: Error - MessageNotUnderstood
		withMessageText: TusLibrosInterface expiredCartErrorDescription.
	
	
	
	! !

!TusLibrosInterfaceTest methodsFor: '5-cart expiration' stamp: 'PGTA 12/1/2020 21:58:07'!
test20_InterfaceUpdatesTheExpirationTimeAfterAddToCart
	
	| cartId1 clientId1 password bookIsbn|
	
	clientId1 := '1239'.
	password := 'test123'.
	bookIsbn := testObjectsFactory itemSellByTheStore.
	
	tusLibrosIface := testObjectsFactory createTusLibrosInterfaceWith: self andMerchant: (CashierTest new setUp) clock: self.
	
	cartId1 := tusLibrosIface createCartWithClient: clientId1 password: password.
	
	self advance15minutes.
	
	tusLibrosIface addToCart: cartId1 isbn: bookIsbn quantity: 5.
	
	self advance15minutes.
	
	self shouldnt: [tusLibrosIface addToCart: cartId1 isbn: bookIsbn quantity: 5] raise: Error.
	self shouldnt: [tusLibrosIface listCart: cartId1 ] raise: Error.
	self shouldnt: [tusLibrosIface checkoutCart: cartId1 cardNumber: '1213545' expDate: '052025' ownerName: 'alguien'] raise: Error.
	
	
	
	
	! !

!TusLibrosInterfaceTest methodsFor: '5-cart expiration' stamp: 'PGTA 12/1/2020 21:58:08'!
test21_InterfaceUpdatesTheExpirationTimeAfterListCart
	
	| cartId1 clientId1 password bookIsbn |
	
	clientId1 := '1239'.
	password := 'test123'.
	bookIsbn := testObjectsFactory itemSellByTheStore.
	
	cartId1 := tusLibrosIface createCartWithClient: clientId1 password: password.
	
	self advance15minutes.
	
	tusLibrosIface listCart: cartId1.
	
	self advance15minutes.
	
	self shouldnt: [tusLibrosIface listCart: cartId1.] raise: Error.
	self shouldnt: [tusLibrosIface addToCart: cartId1 isbn: bookIsbn quantity: 5] raise: Error.
	self shouldnt: [tusLibrosIface checkoutCart: cartId1 cardNumber: '1213545' expDate: '052025' ownerName: 'alguien'] raise: Error.
	
	
	
	! !

!TusLibrosInterfaceTest methodsFor: '5-cart expiration' stamp: 'PGTA 12/1/2020 21:58:08'!
test22_InterfaceCannotCheckOutSameCartTwice
	
	| cartId bookIsbn |	
	
	bookIsbn := testObjectsFactory itemSellByTheStore.
	
	cartId := tusLibrosIface createCartWithClient: '1239' password: 'test123'.
	tusLibrosIface addToCart: cartId isbn: bookIsbn quantity: 2.
	
	self  shouldnt: [tusLibrosIface checkoutCart: cartId cardNumber: '12345458' expDate: '052025' ownerName: 'Pepe Sanchez'.]
		raise: Error.
	
	self  should: [tusLibrosIface checkoutCart: cartId cardNumber: '12345458' expDate: '052025' ownerName: 'Pepe Sanchez'.]
		raise: Error - MessageNotUnderstood 
		withMessageText: TusLibrosInterface invalidCartIdErrorDescription.
	
	
	! !


!classDefinition: #Cart category: 'TusLibros-Iteracion3'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

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


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'accessing' stamp: 'PJ 11/30/2020 18:37:36'!
addItemsWithQuantityTo: anItemList
	items do: [:item |
		(anItemList includes: item) ifFalse: [
			anItemList add: item copy.
			anItemList add: (self occurrencesOf: item)
		]
	] 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros-Iteracion3'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros-Iteracion3'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'PJ 11/29/2020 20:12:57'!
createSale

	|cartList|
	
	cartList := OrderedCollection new.
	cart addItemsWithQuantityTo: cartList.
	
	^ Sale of: total withItems: cartList.
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros-Iteracion3'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #ClientOrder category: 'TusLibros-Iteracion3'!
Object subclass: #ClientOrder
	instanceVariableNames: 'cart salesBook expTime lastActivity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!ClientOrder methodsFor: 'initialization' stamp: 'PJ 11/30/2020 21:40:24'!
initializeWithCart: aCart salesBook: aSalesBook startTime: aDateAndTime 
	
	cart := aCart.
	salesBook := aSalesBook.
	lastActivity := aDateAndTime.
	expTime := 30 minutes.! !


!ClientOrder methodsFor: 'status' stamp: 'PJ 11/30/2020 21:55:31'!
isExpired: aTime
	^(lastActivity + expTime) <= aTime.! !

!ClientOrder methodsFor: 'status' stamp: 'PJ 11/30/2020 23:04:55'!
updateLastActivity: aDateAndTime 
	lastActivity := aDateAndTime.! !


!ClientOrder methodsFor: 'accessing' stamp: 'PJ 11/30/2020 21:50:49'!
cart
	^cart! !

!ClientOrder methodsFor: 'accessing' stamp: 'PJ 11/30/2020 22:02:56'!
salesBook
	^salesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ClientOrder class' category: 'TusLibros-Iteracion3'!
ClientOrder class
	instanceVariableNames: ''!

!ClientOrder class methodsFor: 'instance creation' stamp: 'PJ 11/30/2020 21:38:05'!
withCart: aCart salesBook: aSalesBook startTime: aDateAndTime 
	
	^self new initializeWithCart: aCart salesBook: aSalesBook startTime: aDateAndTime ! !


!classDefinition: #CreditCard category: 'TusLibros-Iteracion3'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number expirationDate ownerName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!CreditCard methodsFor: 'testing' stamp: 'PGTA 12/3/2020 00:19:35'!
isExpiredOn: aDate 
	
	^expirationDate start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'PGTA 12/3/2020 00:18:31'!
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

	expirationDate := Month month: monthNumber year: yearNumber.
	number := aCreditCardNumberString.
	ownerName := aCreditCardOwnerName.
	! !


!CreditCard methodsFor: 'accesing' stamp: 'PGTA 12/2/2020 23:59:19'!
cardNumber
	^number.! !

!CreditCard methodsFor: 'accesing' stamp: 'PGTA 12/2/2020 23:59:35'!
expirationDate

	^expirationDate! !

!CreditCard methodsFor: 'accesing' stamp: 'PGTA 12/3/2020 00:00:59'!
ownerName
	^ownerName! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros-Iteracion3'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'PGTA 12/3/2020 00:04:28'!
withNumber: aCreditCardNumberString owner: aCreditCardOwnerName expirationDate: aCreditCardExpirationDateString
	
	^self new initializeWithNumber: aCreditCardNumberString owner: aCreditCardOwnerName expirationDate: aCreditCardExpirationDateString ! !


!CreditCard class methodsFor: 'errors' stamp: 'PGTA 12/3/2020 00:05:05'!
wrongCreditCardExpirationDateErrorDescription
	^'Wrong credit card expiration date'! !

!CreditCard class methodsFor: 'errors' stamp: 'PGTA 12/3/2020 00:05:18'!
wrongCreditCardNumberErrorDescription
	^'Wrong credit card number'! !

!CreditCard class methodsFor: 'errors' stamp: 'PGTA 12/3/2020 00:05:28'!
wrongCreditCardOwnerErrorDescription
	^'Invalid credit card owner'! !


!classDefinition: #Sale category: 'TusLibros-Iteracion3'!
Object subclass: #Sale
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!Sale methodsFor: 'sale records' stamp: 'PJ 11/29/2020 20:06:33'!
itemsSold
	^items copy! !

!Sale methodsFor: 'sale records' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'PJ 11/29/2020 20:16:05'!
initializeTotal: aTotal withItems: aSoldItemsList 

	total := aTotal.
	items := aSoldItemsList.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros-Iteracion3'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'PJ 11/29/2020 20:14:40'!
of: aTotal withItems: aSoldItemsList 

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal withItems: aSoldItemsList ! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros-Iteracion3'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'PJ 11/29/2020 19:00:24'!
secondItemSellByTheStore
	
	^ 'validBook2'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'PJ 11/29/2020 19:01:07'!
secondItemSellByTheStorePrice
	
	^25! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'PJ 11/29/2020 19:02:10'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self secondItemSellByTheStore put: self secondItemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'PGTA 12/3/2020 00:28:57'!
expiredCreditCard
	
	^CreditCard withNumber: '123456' owner: 'Pepito' expirationDate: (today monthIndex) asString, (today yearNumber - 1) asString.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'PGTA 12/3/2020 00:28:04'!
notExpiredCreditCard
	
	^CreditCard withNumber: '123456' owner: 'Pepito' expirationDate: (today monthIndex) asString, (today yearNumber + 1) asString.! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'interface' stamp: 'PJ 11/30/2020 21:06:26'!
createTusLibrosInterfaceWith: anAuthenticator andMerchant: aMerchantProcessor clock: aClock  
	
	^TusLibrosInterface withCatalog: self defaultCatalog authenticator: anAuthenticator merchantProcessor: aMerchantProcessor clock: aClock! !


!classDefinition: #TusLibrosInterface category: 'TusLibros-Iteracion3'!
Object subclass: #TusLibrosInterface
	instanceVariableNames: 'catalog authenticator clientOrders cartId salesBook merchantProcessor transactionId clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!TusLibrosInterface methodsFor: 'initialization' stamp: 'PGTA 12/1/2020 20:28:18'!
initializeWithCatalog: aCatalog authenticator: anAuthenticator merchantProcessor: aMerchantProcessor clock: aClock   
	
	catalog := aCatalog.
	authenticator := anAuthenticator.
	merchantProcessor := aMerchantProcessor.
	clock := aClock.
	cartId := 0.
	transactionId := 0.
	clientOrders := Dictionary new.
	salesBook := Dictionary new.! !


!TusLibrosInterface methodsFor: 'asserts' stamp: 'PJ 11/30/2020 22:13:41'!
assertOnExpiredOrder: aClientOrder 

	(aClientOrder isExpired: clock now) ifTrue: [^self error: self class expiredCartErrorDescription]! !

!TusLibrosInterface methodsFor: 'asserts' stamp: 'PJ 11/30/2020 01:20:13'!
assertOnInvalidCartIdFor: aBlock
	
	aBlock on: Error 	do: [^self error: self class invalidCartIdErrorDescription.	]
	
	! !


!TusLibrosInterface methodsFor: 'operations' stamp: 'PGTA 12/1/2020 20:28:18'!
addToCart: aCartId isbn: aBookIsbn quantity: aBookQuantity
	
	|clientOrder cart|
	self assertOnInvalidCartIdFor: 	[		clientOrder := clientOrders at: aCartId	].
	self assertOnExpiredOrder: clientOrder.
	
	cart := clientOrder cart.
	cart add: aBookQuantity of: aBookIsbn.
	clientOrder updateLastActivity: clock now.
	
	! !

!TusLibrosInterface methodsFor: 'operations' stamp: 'PGTA 12/3/2020 00:10:31'!
checkoutCart: aCartId cardNumber: aCreditCardNumber expDate: anExpDate ownerName: aCreditCardOwner
	
	|clientOrder clientCart clientSalesBook cashier creditCard |
	
	self assertOnInvalidCartIdFor: [clientOrder := clientOrders at: aCartId ].
	self assertOnExpiredOrder: clientOrder.
	
	clientCart := clientOrder cart.
	clientSalesBook := clientOrder salesBook.
	
	creditCard := CreditCard withNumber: aCreditCardNumber owner: aCreditCardOwner expirationDate: anExpDate.
	
	cashier := Cashier toCheckout: clientCart charging: creditCard throught: merchantProcessor on: clock now registeringOn: clientSalesBook.
	cashier checkOut.
	
	clientOrders removeKey: aCartId.
	
	^self transactionId
	! !

!TusLibrosInterface methodsFor: 'operations' stamp: 'PGTA 12/1/2020 22:19:19'!
createCartWithClient: aClientId password: aPassword 
	
	|cart cartIdStr clientSalesBook clientOrder|
	authenticator authenticate: aClientId password: aPassword.
	
	clientSalesBook := salesBook at: aClientId ifAbsent: [salesBook at: aClientId put: OrderedCollection new].
	
	cart := Cart acceptingItemsOf: catalog.
	cartIdStr := self nextCartId.
	clientOrder := ClientOrder withCart: cart salesBook: clientSalesBook startTime: clock now.
	clientOrders at: cartIdStr put: clientOrder.
	
	^cartIdStr.! !

!TusLibrosInterface methodsFor: 'operations' stamp: 'PGTA 12/1/2020 22:20:36'!
listCart: aCartId
	|clientOrder clientCart|
	
	self assertOnInvalidCartIdFor: [clientOrder := clientOrders at: aCartId].
	self assertOnExpiredOrder: clientOrder.
	
	clientCart  := clientOrder cart.
	clientOrder updateLastActivity: clock now.
	^self listCartWithQuantity: clientCart .
	! !

!TusLibrosInterface methodsFor: 'operations' stamp: 'PJ 11/30/2020 00:27:13'!
listPurchasesFor: aClientId password: aPassword
	
	|purchaseList total clientSalesBook|
	
	authenticator authenticate: aClientId password: aPassword.
	
	total := 0.
	purchaseList := OrderedCollection new.
	
	clientSalesBook := salesBook at: aClientId ifAbsent: [^purchaseList ].
	
	clientSalesBook do: [:sale |
		purchaseList addAllLast: sale itemsSold.
		total := total + sale total.
	].
	
	purchaseList add: total.
	^purchaseList ! !


!TusLibrosInterface methodsFor: 'private operations' stamp: 'PJ 11/29/2020 16:02:54'!
listCartWithQuantity: aCart
	|cartList|
	
	cartList := OrderedCollection new.
	aCart addItemsWithQuantityTo: cartList.
	^cartList.
	! !

!TusLibrosInterface methodsFor: 'private operations' stamp: 'PJ 11/30/2020 00:41:33'!
nextCartId
	cartId := cartId + 1.
	^cartId asString! !

!TusLibrosInterface methodsFor: 'private operations' stamp: 'PJ 11/29/2020 18:18:52'!
transactionId
	transactionId := transactionId + 1.
	^transactionId asString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosInterface class' category: 'TusLibros-Iteracion3'!
TusLibrosInterface class
	instanceVariableNames: ''!

!TusLibrosInterface class methodsFor: 'instance creation' stamp: 'PJ 11/30/2020 21:02:54'!
withCatalog: aCatalog authenticator: anAuthenticator merchantProcessor: aMerchantProcessor clock: aClock  

	^self new initializeWithCatalog: aCatalog authenticator: anAuthenticator merchantProcessor: aMerchantProcessor clock: aClock ! !


!TusLibrosInterface class methodsFor: 'errors' stamp: 'PJ 11/29/2020 17:05:56'!
emptyCartErrorDescription
	^'Your cart is empty'! !

!TusLibrosInterface class methodsFor: 'errors' stamp: 'PJ 11/30/2020 21:07:42'!
expiredCartErrorDescription
	^'Expired cart'! !

!TusLibrosInterface class methodsFor: 'errors' stamp: 'PJ 11/28/2020 18:19:10'!
invalidCartIdErrorDescription
	^'Invalid CartId'! !

!TusLibrosInterface class methodsFor: 'errors' stamp: 'PJ 11/28/2020 16:54:43'!
invalidClientErrorDescription
	^'Invalid Client'! !

!TusLibrosInterface class methodsFor: 'errors' stamp: 'PJ 11/28/2020 17:00:13'!
invalidPasswordErrorDescription
	^'Invalid Password'! !
