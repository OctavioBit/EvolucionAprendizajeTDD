!classDefinition: #CheckOutTest category: 'Tus-Libros'!
TestCase subclass: #CheckOutTest
	instanceVariableNames: 'creditCardNumber cardOwner validCreditCard book1 book2 expiredCreditCard currentMonth today expiredThisMonthCreditCard mockAlwaysStolenCardMerchantProcessor mockAlwaysOkMerchantProcessor mockAlwaysFakeCardMerchantProcessor mockAlwaysWithoutCreditCardMerchantProcessor invalidNumberCreditCard emptyOwnerCreditCard emptyOwnerCreditCard2 stubs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!CheckOutTest methodsFor: 'valid checkout' stamp: 'nz 6/23/2021 01:25:02'!
test02CheckoutACartWithOneItem

	| aCashier bookPrices cart receipt receiptBook |
	
	bookPrices _ PriceList new.
	bookPrices set: book1 price: 124.
	
	receiptBook _ OrderedCollection new.
	
	aCashier _ Cashier withPrices: bookPrices receiptBook: receiptBook merchantProcessor: mockAlwaysOkMerchantProcessor.
	
	cart _ ShoppingCart new.
	cart add: 1 of: book1.
	
	receipt _ aCashier checkOut: cart payingWith: validCreditCard on: today.
	
	self assert: 124 equals: receipt total.
	self assert: 1 equals: receipt items size.
	self assert: 1 equals: (receipt items occurrencesOf: book1).
	
	self assert: receipt isTheOnlyIn: receiptBook.! !

!CheckOutTest methodsFor: 'valid checkout' stamp: 'nz 6/23/2021 01:27:57'!
test03CheckoutACartWithMultipleItems

	| aCashier bookPrices cart receipt receiptBook |
	
	bookPrices _ PriceList new.
	bookPrices set: book1 price: 100.
	bookPrices set: book2 price: 25.
	
	receiptBook _ OrderedCollection new.
	
	aCashier _ Cashier withPrices: bookPrices receiptBook: receiptBook merchantProcessor: mockAlwaysOkMerchantProcessor.
	
	cart _ ShoppingCart new.
	cart add: 1 of: book1.
	cart add: 2 of: book2.
	
	receipt _ aCashier checkOut: cart payingWith: validCreditCard on: today.
	
	self assert: 150 equals: receipt total.
	self assert: 3 equals: receipt items size.
	self assert: 1 equals: (receipt items occurrencesOf: book1).
	self assert: 2 equals: (receipt items occurrencesOf: book2).

	self assert: receipt isTheOnlyIn: receiptBook.
	! !


!CheckOutTest methodsFor: 'assertions' stamp: 'AW 6/14/2021 21:59:15'!
assert: anItem isTheOnlyIn: aCollection

	self assert: aCollection size equals: 1.
	self assert: aCollection includes: anItem! !


!CheckOutTest methodsFor: 'card validation' stamp: 'nz 6/16/2021 00:42:38'!
test05CheckoutWithExpiredCardShouldRaiseError

	| aCashier bookPrices cart receiptBook |
	
	bookPrices _ PriceList new.
	bookPrices set: book1 price: 50.
	
	receiptBook _ OrderedCollection new.
	
	aCashier _ Cashier withPrices: bookPrices receiptBook: receiptBook merchantProcessor: mockAlwaysOkMerchantProcessor .
	
	cart _ ShoppingCart new.
	cart add: 3 of: book1.
	
	self should: [ aCashier checkOut: cart payingWith: expiredCreditCard on: today. ]
		raise: Error - MessageNotUnderstood
		withMessageText: Cashier cantCheckWithExpiredCardErrorDescription.
		
	self assert: receiptBook isEmpty.! !

!CheckOutTest methodsFor: 'card validation' stamp: 'nz 6/16/2021 00:45:20'!
test06CheckoutWithCardExpiredThisMonthShouldRaiseError

	| aCashier bookPrices cart receiptBook |
	
	bookPrices _ PriceList new.
	bookPrices set: book1 price: 50.
	
	receiptBook _ OrderedCollection new.
	
	aCashier _ Cashier withPrices: bookPrices receiptBook: receiptBook merchantProcessor: mockAlwaysOkMerchantProcessor.
	
	cart _ ShoppingCart new.
	cart add: 3 of: book1.
	
	self should: [ aCashier checkOut: cart payingWith: expiredThisMonthCreditCard on: today. ]
		raise: Error - MessageNotUnderstood
		withMessageText: Cashier cantCheckWithExpiredCardErrorDescription.
		
	self assert: receiptBook isEmpty.! !

!CheckOutTest methodsFor: 'card validation' stamp: 'nz 6/16/2021 00:48:37'!
test10CheckoutWithInvalidCardNumberShouldRaiseError

	| aCashier bookPrices cart receiptBook |
	
	bookPrices _ PriceList new.
	bookPrices set: book1 price: 50.
	
	receiptBook _ OrderedCollection new.
	
	aCashier _ Cashier withPrices: bookPrices receiptBook: receiptBook merchantProcessor: mockAlwaysOkMerchantProcessor.
	
	cart _ ShoppingCart new.
	cart add: 3 of: book1.
	
	self should: [ aCashier checkOut: cart payingWith: invalidNumberCreditCard on: today. ]
		raise: Error - MessageNotUnderstood
		withMessageText: Cashier invalidCreditCardNumberErrorDescription.
		
	self assert: receiptBook isEmpty.! !

!CheckOutTest methodsFor: 'card validation' stamp: 'nz 6/16/2021 00:50:15'!
test11CheckoutWithEmptyCardOwnerNameShouldRaiseError

	| aCashier bookPrices cart receiptBook |
	
	bookPrices _ PriceList new.
	bookPrices set: book1 price: 50.
	
	receiptBook _ OrderedCollection new.
	
	aCashier _ Cashier withPrices: bookPrices receiptBook: receiptBook merchantProcessor: mockAlwaysOkMerchantProcessor.
	
	cart _ ShoppingCart new.
	cart add: 3 of: book1.
	
	self should: [ aCashier checkOut: cart payingWith: emptyOwnerCreditCard on: today. ]
		raise: Error - MessageNotUnderstood
		withMessageText: Cashier invalidCreditCardOwnerNameErrorDescription.
		
	self assert: receiptBook isEmpty.! !

!CheckOutTest methodsFor: 'card validation' stamp: 'nz 6/16/2021 00:50:50'!
test12CheckoutWithBlankCardOwnerNameShouldRaiseError

	| aCashier bookPrices cart receiptBook |
	
	bookPrices _ PriceList new.
	bookPrices set: book1 price: 50.
	
	receiptBook _ OrderedCollection new.
	
	aCashier _ Cashier withPrices: bookPrices receiptBook: receiptBook merchantProcessor: mockAlwaysOkMerchantProcessor.
	
	cart _ ShoppingCart new.
	cart add: 3 of: book1.
	
	self should: [ aCashier checkOut: cart payingWith: emptyOwnerCreditCard2 on: today. ]
		raise: Error - MessageNotUnderstood
		withMessageText: Cashier invalidCreditCardOwnerNameErrorDescription.
		
	self assert: receiptBook isEmpty.! !


!CheckOutTest methodsFor: 'shopping cart validation' stamp: 'nz 6/16/2021 00:46:51'!
test01CheckoutEmptyCartShouldRaiseError

	| aCashier bookPrices cart  receiptBook |
	
	bookPrices _ PriceList new.
	
	receiptBook _ OrderedCollection new.
	
	aCashier _ Cashier withPrices: bookPrices receiptBook: receiptBook merchantProcessor: mockAlwaysOkMerchantProcessor .
	
	cart _ ShoppingCart new.
	
	self should: [ aCashier checkOut: cart payingWith: validCreditCard on: today. ]
		raise: Error - MessageNotUnderstood
		withMessageText: Cashier cantCheckoutEmptyCartErrorDescription.
		
	self assert: receiptBook isEmpty.! !

!CheckOutTest methodsFor: 'shopping cart validation' stamp: 'nz 6/16/2021 00:42:03'!
test04CheckoutItemWithoutPricesShouldRaiseError

	| aCashier bookPrices cart receiptBook |
	
	bookPrices _ PriceList new.
	receiptBook _ OrderedCollection new.
	
	aCashier _ Cashier withPrices: bookPrices receiptBook: receiptBook merchantProcessor: mockAlwaysOkMerchantProcessor.
	
	cart _ ShoppingCart new.
	cart add: 3 of: book1.
	
	self should: [ aCashier checkOut: cart payingWith: validCreditCard on: today. ]
		raise: Error - MessageNotUnderstood
		withMessageText: Cashier cantCheckoutItemWithNoPriceForItErrorDescription.
		
	self assert: receiptBook isEmpty.! !


!CheckOutTest methodsFor: 'setUp/tearDown' stamp: 'nz 6/24/2021 21:45:35'!
setUp

	today _ FixedGregorianDate today.
	currentMonth _ today monthOfYear.
	
	creditCardNumber _ '4182418241824182'.
	cardOwner _ 'PEPE SANCHEZ'.

	stubs := TestStubs new.

	validCreditCard _ CreditCard
		number: creditCardNumber
		owner: cardOwner
		expiration: currentMonth next.
	
	expiredCreditCard _ CreditCard
		number: creditCardNumber
		owner: cardOwner
		expiration: currentMonth previous.
		
	expiredThisMonthCreditCard _ CreditCard
		number: creditCardNumber
		owner: cardOwner
		expiration: currentMonth.
		
	invalidNumberCreditCard _ stubs invalidNumberCreditCard.
		
	emptyOwnerCreditCard _ CreditCard
		number: creditCardNumber
		owner: ''
		expiration: currentMonth next.
		
	emptyOwnerCreditCard2 _ CreditCard
		number: creditCardNumber
		owner: '            '
		expiration: currentMonth next.
		
	book1 := stubs book1.
	book2 := stubs book2.
	
	mockAlwaysStolenCardMerchantProcessor _ MockAlwaysStolenCardMerchantProcessor new.
	mockAlwaysOkMerchantProcessor _ stubs mockAlwaysOkMerchantProcessor.
	mockAlwaysFakeCardMerchantProcessor _ MockAlwaysFakeCardMerchantProcessor new.
	mockAlwaysWithoutCreditCardMerchantProcessor _ MockAlwaysWithoutCreditCardMerchantProcessor new.! !


!CheckOutTest methodsFor: 'merchant processor' stamp: 'nz 6/16/2021 00:46:43'!
test07CheckoutWithStolenCardShouldRaiseError

	| aCashier bookPrices cart receiptBook |
	
	bookPrices _ PriceList new.
	bookPrices set: book1 price: 50.
	
	receiptBook _ OrderedCollection new.
	
	aCashier _ Cashier withPrices: bookPrices receiptBook: receiptBook merchantProcessor: mockAlwaysStolenCardMerchantProcessor.
	
	cart _ ShoppingCart new.
	cart add: 3 of: book1.
	
	self should: [ aCashier checkOut: cart payingWith: validCreditCard on: today. ]
		raise: Error - MessageNotUnderstood
		withMessageText: MerchantProcessor stolenCreditCardErrorDescription.
		
	self assert: receiptBook isEmpty.! !

!CheckOutTest methodsFor: 'merchant processor' stamp: 'nz 6/16/2021 00:47:45'!
test08CheckoutWithFakeCardShouldRaiseError

	| aCashier bookPrices cart receiptBook |
	
	bookPrices _ PriceList new.
	bookPrices set: book1 price: 50.
	
	receiptBook _ OrderedCollection new.
	
	aCashier _ Cashier withPrices: bookPrices receiptBook: receiptBook merchantProcessor: mockAlwaysFakeCardMerchantProcessor.
	
	cart _ ShoppingCart new.
	cart add: 3 of: book1.
	
	self should: [ aCashier checkOut: cart payingWith: validCreditCard on: today. ]
		raise: Error - MessageNotUnderstood
		withMessageText: MerchantProcessor fakeCreditCardErrorDescription.
		
	self assert: receiptBook isEmpty.! !

!CheckOutTest methodsFor: 'merchant processor' stamp: 'nz 6/16/2021 00:47:36'!
test09CheckoutWithInsufficientFundsShouldRaiseError

	| aCashier bookPrices cart receiptBook |
	
	bookPrices _ PriceList new.
	bookPrices set: book1 price: 50.
	
	receiptBook _ OrderedCollection new.
	
	aCashier _ Cashier withPrices: bookPrices receiptBook: receiptBook merchantProcessor: mockAlwaysWithoutCreditCardMerchantProcessor.
	
	cart _ ShoppingCart new.
	cart add: 3 of: book1.
	
	self should: [ aCashier checkOut: cart payingWith: validCreditCard on: today. ]
		raise: Error - MessageNotUnderstood
		withMessageText: MerchantProcessor insufficientFundsCreditCardErrorDescription.
		
	self assert: receiptBook isEmpty.! !


!classDefinition: #PriceListTest category: 'Tus-Libros'!
TestCase subclass: #PriceListTest
	instanceVariableNames: 'book1 book2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!PriceListTest methodsFor: 'price validation' stamp: 'nz 6/16/2021 01:25:23'!
test01AddItemWithNegativePriceShouldRaiseError

	| priceList |
	
	priceList _ PriceList new.
	
	self should: [ priceList set: book1 price: -100.]
		raise: Error - MessageNotUnderstood
		withMessageText: PriceList itemPriceMustBePositiveErrorDescription.! !

!PriceListTest methodsFor: 'price validation' stamp: 'nz 6/16/2021 01:25:37'!
test02AddItemWithZeroPriceShouldRaiseError

	| priceList |
	
	priceList _ PriceList new.
	
	self should: [ priceList set: book1 price: 0.]
		raise: Error - MessageNotUnderstood
		withMessageText: PriceList itemPriceMustBePositiveErrorDescription.! !


!PriceListTest methodsFor: 'setUp/tearDown' stamp: 'nz 6/16/2021 01:15:07'!
setUp
	
	book1 := 'ISBN1'.
	book2 := 'ISBN2'.! !


!classDefinition: #ShopTest category: 'Tus-Libros'!
TestCase subclass: #ShopTest
	instanceVariableNames: 'creditCard1 stubs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!ShopTest methodsFor: 'cart creation and listing' stamp: 'AW 6/24/2021 01:32:59'!
test01InvalidClientShallNotPass
	
	| shop |
	
	shop := Shop
		withUserAuthenticator: (MockUserAuthenticator alwaysReturning: false) 
		prices: stubs priceList
		merchantProcessor: stubs mockAlwaysOkMerchantProcessor 
		timeProvider: stubs timeProvider.
	
	self should: [ shop createCartClientId: 3 password: '123'. ]
		raise: Error - MessageNotUnderstood
		withMessageText: Shop incorrectPasswordOrClientIdErrorDescription.	
	
	! !

!ShopTest methodsFor: 'cart creation and listing' stamp: 'AW 6/24/2021 01:37:38'!
test02NewCartsAreEmpty
	
	| shop cartId cartItems |
	
	shop := Shop 
		withUserAuthenticator: (MockUserAuthenticator alwaysReturning: true) 
		prices: stubs priceList 
		merchantProcessor: stubs mockAlwaysOkMerchantProcessor 
		timeProvider: stubs timeProvider.
	
	cartId := shop createCartClientId: 3 password: '1234'.
	
	cartItems := shop listCart: cartId.
	
	self assert: cartItems isEmpty.! !

!ShopTest methodsFor: 'cart creation and listing' stamp: 'AW 6/24/2021 01:38:17'!
test03ListCartWithOneItem
	
	| shop cartId cartItems bookIsbn quantity |
	
	shop := Shop 
		withUserAuthenticator: (MockUserAuthenticator alwaysReturning: true) 
		prices: stubs priceList 
		merchantProcessor: stubs mockAlwaysOkMerchantProcessor 
		timeProvider: stubs timeProvider.
	
	cartId := shop createCartClientId: 3 password: '1234'.
	
	quantity := 2.
	bookIsbn := 'book_isbn'.
		
	shop add: quantity of: bookIsbn to: cartId.
	
	cartItems := shop listCart: cartId.
	
	self assert: cartItems size equals: 1.
	self assert: cartItems first quantity equals: quantity.
	self assert: cartItems first item equals: bookIsbn.! !

!ShopTest methodsFor: 'cart creation and listing' stamp: 'AW 6/24/2021 01:38:40'!
test04ListInvalidCartShouldRaiseError
	
	| shop |
	
	shop := Shop withUserAuthenticator: (MockUserAuthenticator alwaysReturning: true) prices: stubs priceList merchantProcessor: stubs mockAlwaysOkMerchantProcessor timeProvider: stubs timeProvider.
	
	self should: [ shop listCart: 15 ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Shop invalidCartIdErrorDescription.
	! !

!ShopTest methodsFor: 'cart creation and listing' stamp: 'AW 6/24/2021 01:39:39'!
test05AddItemToCartDoesntModifyOtherCarts
	
	| shop bookIsbn cartId1 cartId2 quantity |
	
	shop := Shop withUserAuthenticator: (MockUserAuthenticator alwaysReturning: true) prices: stubs priceList merchantProcessor: stubs mockAlwaysOkMerchantProcessor timeProvider: stubs timeProvider.
	
	cartId1 := shop createCartClientId: 3 password: '1234'.
	cartId2 := shop createCartClientId: 4 password: '12345'.
	
	quantity := 2.
	bookIsbn := 'book_isbn'.
		
	shop add: quantity of: bookIsbn to: cartId1.
	
	self assert: (shop listCart: cartId2) isEmpty.
	! !


!ShopTest methodsFor: 'cart expiration' stamp: 'nz 6/24/2021 16:25:02'!
test14CheckingOutAnExpiredCardShouldFail
	
	| shop cartId password clientId timeProvider |
	
	timeProvider := stubs timeProvider.
	shop := Shop 
		withUserAuthenticator: (MockUserAuthenticator alwaysReturning: true) 
		prices: stubs priceList 
		merchantProcessor: stubs mockAlwaysOkMerchantProcessor 
		timeProvider: timeProvider.
		
	clientId := 15.
	password := '123456'.
	
	cartId := shop createCartClientId: clientId password: password.
	
	timeProvider toTheFuture: 31 * minute.
	
	self should: [ shop checkOut: cartId payingWith: stubs validCreditCard ]
		raise: Error - MessageNotUnderstood
		withMessageText: Shop expiredCartErrorDescription.
	
	! !

!ShopTest methodsFor: 'cart expiration' stamp: 'nz 6/24/2021 16:27:57'!
test15CheckingOutInADifferentPointInTimeShouldWorkAsIntended
	
	| shop cartId password clientId timeProvider |
	
	timeProvider := stubs timeProvider.
	shop := Shop 
		withUserAuthenticator: (MockUserAuthenticator alwaysReturning: true) 
		prices: stubs priceList 
		merchantProcessor: stubs mockAlwaysOkMerchantProcessor 
		timeProvider: timeProvider.
		
	clientId := 15.
	password := '123456'.
	
	timeProvider toTheFuture: 31 * minute.
	
	cartId := shop createCartClientId: clientId password: password.
		
	self should: [ shop checkOut: cartId payingWith: stubs validCreditCard ]
		raise: Error - MessageNotUnderstood
		withMessageText: Cashier cantCheckoutEmptyCartErrorDescription.
	
	! !

!ShopTest methodsFor: 'cart expiration' stamp: 'nz 6/24/2021 16:28:15'!
test16AddingItemsToAnExpiredCartShouldFail
	
	| shop cartId password clientId timeProvider |
	
	timeProvider := stubs timeProvider.
	shop := Shop 
		withUserAuthenticator: (MockUserAuthenticator alwaysReturning: true) 
		prices: stubs priceList 
		merchantProcessor: stubs mockAlwaysOkMerchantProcessor 
		timeProvider: timeProvider.
		
	clientId := 15.
	password := '123456'.
	
	cartId := shop createCartClientId: clientId password: password.
	
	timeProvider toTheFuture: 31 * minute.
	
	self should: [ shop add: 12 of: stubs book1 to: cartId ]
		raise: Error - MessageNotUnderstood
		withMessageText: Shop expiredCartErrorDescription.
	
	! !


!ShopTest methodsFor: 'check out and purchase listing' stamp: 'AW 6/24/2021 01:40:21'!
test06CheckoutInvalidCartIdShouldRaiseError
	
	| shop |
	
	shop := Shop withUserAuthenticator: (MockUserAuthenticator alwaysReturning: true) prices: stubs priceList merchantProcessor: stubs mockAlwaysOkMerchantProcessor timeProvider: stubs timeProvider.
	
	self should: [ shop checkOut: 16 payingWith: creditCard1 ]
		raise: Error - MessageNotUnderstood
		withMessageText: Shop invalidCartIdErrorDescription.
	! !

!ShopTest methodsFor: 'check out and purchase listing' stamp: 'AW 6/24/2021 01:40:45'!
test07CheckoutUsesTheCashier
	
	| shop cartId |
	
	shop := Shop withUserAuthenticator: (MockUserAuthenticator alwaysReturning: true) prices: stubs priceList merchantProcessor: stubs mockAlwaysOkMerchantProcessor timeProvider: stubs timeProvider.
	
	cartId := shop createCartClientId: 15 password: '1234'.
	
	self should: [ shop checkOut: cartId payingWith: stubs validCreditCard ]
		raise: Error - MessageNotUnderstood
		withMessageText: Cashier cantCheckoutEmptyCartErrorDescription.
	! !

!ShopTest methodsFor: 'check out and purchase listing' stamp: 'AW 6/24/2021 01:43:21'!
test08ListPurchasesOnOnlyOneBuyClient
	
	| shop cartId clientId password purchases |
	
	shop := Shop withUserAuthenticator: (MockUserAuthenticator alwaysReturning: true) prices: stubs priceList merchantProcessor: stubs mockAlwaysOkMerchantProcessor timeProvider: stubs timeProvider.
		
	clientId := 15.
	password := '123456'.
	cartId := shop createCartClientId: clientId password: password.
	
	shop add: 2 of: stubs book1 to: cartId.
	
	shop checkOut: cartId payingWith: stubs validCreditCard.
	
	purchases := shop listPurchasesOf: clientId with: password.
	self assert: purchases total equals: 100.
	self assert: purchases items size equals: 2.
	self assert: (purchases items occurrencesOf: stubs book1) equals: 2.
	! !

!ShopTest methodsFor: 'check out and purchase listing' stamp: 'nz 6/24/2021 16:21:59'!
test09ListPurchasesOfManyItemsByOneClient
	
	| shop cartId clientId password purchases |
	
	shop := Shop withUserAuthenticator: (MockUserAuthenticator alwaysReturning: true) prices: stubs priceList merchantProcessor: stubs mockAlwaysOkMerchantProcessor timeProvider: stubs timeProvider.
		
	clientId := 15.
	password := '123456'.
	cartId := shop createCartClientId: clientId password: password.
	
	shop add: 2 of: stubs book1 to: cartId.
	
	shop add: 1 of: stubs book2 to: cartId.
	
	shop add: 1 of: stubs book3 to: cartId.
	
	shop checkOut: cartId payingWith: stubs validCreditCard.
	
	purchases := shop listPurchasesOf: clientId with: password.
	self assert: purchases total equals: 150.
	self assert: purchases items size equals: 4.
	self assert: (purchases items occurrencesOf: stubs book1) equals: 2.
	self assert: (purchases items occurrencesOf: stubs book2) equals: 1.
	self assert: (purchases items occurrencesOf: stubs book3) equals: 1.
	! !

!ShopTest methodsFor: 'check out and purchase listing' stamp: 'nz 6/24/2021 16:22:34'!
test10CheckoutWithInvalidCreditCardShouldFail
	
	| shop cartId clientId password |
	
	shop := Shop withUserAuthenticator: (MockUserAuthenticator alwaysReturning: true) prices: stubs priceList merchantProcessor: stubs mockAlwaysOkMerchantProcessor timeProvider: stubs timeProvider.
		
	clientId := 15.
	password := '123456'.
	cartId := shop createCartClientId: clientId password: password.
	
	shop add: 1 of: stubs book1 to: cartId.
	
	self
		should: [ shop
				checkOut: cartId
				payingWith: stubs invalidNumberCreditCard. ]
		raise: Error - MessageNotUnderstood
		withMessageText: Cashier invalidCreditCardNumberErrorDescription.
	! !

!ShopTest methodsFor: 'check out and purchase listing' stamp: 'nz 6/24/2021 16:23:14'!
test11ListMultiplePurchasesOfTheSameClient
	
	| shop cartId clientId password purchases cartId2 |
	
	shop := Shop withUserAuthenticator: (MockUserAuthenticator alwaysReturning: true) prices: stubs priceList merchantProcessor: stubs mockAlwaysOkMerchantProcessor timeProvider: stubs timeProvider.
		
	clientId := 15.
	password := '123456'.
	
	cartId := shop createCartClientId: clientId password: password.
	shop add: 2 of: stubs book1 to: cartId.
	shop add: 1 of: stubs book2 to: cartId.
	shop add: 1 of: stubs book3 to: cartId.
	shop checkOut: cartId payingWith: stubs validCreditCard.
	
	cartId2 := shop createCartClientId: clientId password: password.
	shop add: 1 of: stubs book1 to: cartId2.
	shop add: 1 of: stubs book3 to: cartId2.
	shop checkOut: cartId2 payingWith: stubs validCreditCard.
	
	purchases := shop listPurchasesOf: clientId with: password.
	self assert: 230 equals: purchases total.
	self assert: 6 equals: purchases items size.
	self assert: (purchases items occurrencesOf: stubs book1) equals: 3.
	self assert: (purchases items occurrencesOf: stubs book2) equals: 1.
	self assert: (purchases items occurrencesOf: stubs book3) equals: 2.
	! !

!ShopTest methodsFor: 'check out and purchase listing' stamp: 'nz 6/24/2021 16:23:52'!
test12ListPurchasesOfIncorrectPasswordShouldFail
	
	| shop clientId password |
	
	shop := Shop withUserAuthenticator: (MockUserAuthenticator alwaysReturning: false) prices: stubs priceList merchantProcessor: stubs mockAlwaysOkMerchantProcessor timeProvider: stubs timeProvider.
		
	clientId := 15.
	password := '123456'.
	
	self should: [ shop listPurchasesOf: clientId with: password ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Shop incorrectPasswordOrClientIdErrorDescription.
	! !

!ShopTest methodsFor: 'check out and purchase listing' stamp: 'nz 6/24/2021 16:24:14'!
test13ListPurchasesOfDifferentClients
	
	| shop cartId clientId1 clientId2 password client1purchases cartId2 client2purchases |
	
	shop := Shop withUserAuthenticator: (MockUserAuthenticator alwaysReturning: true) prices: stubs priceList merchantProcessor: stubs mockAlwaysOkMerchantProcessor timeProvider: stubs timeProvider.
		
	clientId1 := 15.
	clientId2 := 42.
	password := '123456'.
	
	cartId := shop createCartClientId: clientId1 password: password.
	shop add: 2 of: stubs book1 to: cartId.
	shop add: 1 of: stubs book2 to: cartId.
	shop add: 1 of: stubs book3 to: cartId.
	shop checkOut: cartId payingWith: stubs validCreditCard.
	
	cartId2 := shop createCartClientId: clientId2 password: password.
	shop add: 1 of: stubs book1 to: cartId2.
	shop add: 1 of: stubs book3 to: cartId2.
	shop checkOut: cartId2 payingWith: stubs validCreditCard.
	
	client1purchases := shop listPurchasesOf: clientId1 with: password.
	self assert: 150 equals: client1purchases total.
	self assert: 4 equals: client1purchases items size.
	
	client2purchases := shop listPurchasesOf: clientId2 with: password.
	self assert: 80 equals: client2purchases total.
	self assert: 2 equals: client2purchases items size.
	! !


!ShopTest methodsFor: 'setUp/tearDown' stamp: 'nz 6/23/2021 00:46:42'!
setUp

	stubs := TestStubs new.! !


!classDefinition: #ShoppingCartTest category: 'Tus-Libros'!
TestCase subclass: #ShoppingCartTest
	instanceVariableNames: 'book1 book2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!ShoppingCartTest methodsFor: 'quantity errors' stamp: 'AW 6/14/2021 22:06:29'!
test04AddingANegativeQuantityRaisesError
	| shoppingCart |

	shoppingCart := ShoppingCart new.
	
	self  should: [ shoppingCart add: -2 of: book1. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: ShoppingCart itemQuantityMustBeGreaterThanZeroErrorDescription.
	! !

!ShoppingCartTest methodsFor: 'quantity errors' stamp: 'AW 6/14/2021 22:06:35'!
test05AddingZeroQuantityRaisesError
	| shoppingCart |

	shoppingCart := ShoppingCart new.
	
	self  should: [ shoppingCart add: 0 of: book1. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: ShoppingCart itemQuantityMustBeGreaterThanZeroErrorDescription.
	! !

!ShoppingCartTest methodsFor: 'quantity errors' stamp: 'AW 6/14/2021 22:08:22'!
test06AddingNonIntegerQuantityRaisesError
	| shoppingCart |

	shoppingCart := ShoppingCart new.
	
	self  should: [ shoppingCart add: 1.5 of: book1. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: ShoppingCart itemQuantyMustBeAnIntegerErrorDescription.
	! !


!ShoppingCartTest methodsFor: 'assertions' stamp: 'nz 6/14/2021 19:02:37'!
assert: shoppingCart has: quantity of: item

	self assert: (shoppingCart entries anySatisfy: [ :anShoppingCartItem | 
		anShoppingCartItem is: quantity of: item.
	] ).! !


!ShoppingCartTest methodsFor: 'adding items' stamp: 'nz 6/14/2021 19:02:37'!
test01EmptyCartHasNoItems

	| shoppingCart |
	shoppingCart := ShoppingCart new.
	
	self assert: shoppingCart entries size equals: 0. ! !

!ShoppingCartTest methodsFor: 'adding items' stamp: 'nz 6/14/2021 19:02:37'!
test02AddingAnItemToACart
	| shoppingCart quantity |

	shoppingCart := ShoppingCart new.
	quantity := 1.
	
	shoppingCart add: quantity of: book1.
	
	self assert: shoppingCart entries size equals: 1.
	self assert: shoppingCart has: quantity of: book1.! !

!ShoppingCartTest methodsFor: 'adding items' stamp: 'nz 6/14/2021 19:02:37'!
test03AddingMultipleItemsToACart
	| shoppingCart |

	shoppingCart := ShoppingCart new.
	
	shoppingCart add: 1 of: book1.
	shoppingCart add: 2 of: book2.
	
	self assert: shoppingCart entries size equals: 2.
	self assert: shoppingCart has: 1 of: book1.
	self assert: shoppingCart has: 2 of: book2.! !


!ShoppingCartTest methodsFor: 'setUp/tearDown' stamp: 'nz 6/16/2021 00:52:20'!
setUp
	
	book1 := 'ISBN1'.
	book2 := 'ISBN2'.! !


!classDefinition: #Cashier category: 'Tus-Libros'!
Object subclass: #Cashier
	instanceVariableNames: 'priceList receiptBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!Cashier methodsFor: 'initialization' stamp: 'AW 6/15/2021 23:05:59'!
initializePrices: aPriceList receiptBook: aReceiptBook merchantProcessor: aMerchantProcessor  
	
	priceList := aPriceList.
	receiptBook := aReceiptBook.
	merchantProcessor := aMerchantProcessor.! !


!Cashier methodsFor: 'private' stamp: 'nz 6/15/2021 23:47:15'!
calculateShoppingCartTotal: aShoppingCart

	^ aShoppingCart entries sum: [ :entry |
		self priceFor: entry.
	] ifEmpty: [
		self error: self class cantCheckoutEmptyCartErrorDescription .
	]! !

!Cashier methodsFor: 'private' stamp: 'nz 6/23/2021 01:34:27'!
createReceiptWithTotal: anAmountOfMoney cart: aShoppingCart 

	| receipt |
	
	receipt _ Receipt withTotal: anAmountOfMoney items: (self getEntriesAsBag: aShoppingCart).
	receiptBook add: receipt.
	
	^receipt .! !

!Cashier methodsFor: 'private' stamp: 'nz 6/23/2021 01:37:45'!
getEntriesAsBag: aShoppingCart 
	
	| aBag |
	aBag := Bag new.
	
	aShoppingCart entries do: [ :entry | aBag add: entry item withOccurrences: entry quantity ].
	
	^aBag.! !

!Cashier methodsFor: 'private' stamp: 'nz 6/14/2021 18:55:26'!
priceFor: aShoppingCartEntry
	
	^(priceList priceFor: aShoppingCartEntry item) * (aShoppingCartEntry quantity).! !


!Cashier methodsFor: 'checkout' stamp: 'nz 6/23/2021 01:31:18'!
checkOut: aShoppingCart payingWith: aCreditCard on: aGregorianDate  

	| total |

	self assertCanCheckout: aShoppingCart payingWith: aCreditCard on: aGregorianDate.
	
	total _ self calculateShoppingCartTotal: aShoppingCart.

	merchantProcessor debit: total from: aCreditCard. 

	^ self createReceiptWithTotal: total cart: aShoppingCart.
	! !


!Cashier methodsFor: 'validation' stamp: 'nz 6/14/2021 19:30:27'!
areAllItemsInPriceList: aCollectionOfShoppingCartEntries

	^ aCollectionOfShoppingCartEntries allSatisfy: [ :entry | priceList hasPriceFor: entry item ]! !

!Cashier methodsFor: 'validation' stamp: 'nz 6/14/2021 19:30:27'!
assertAllItemsInPriceList: aCollectionOfShoppingCartEntries

	(self areAllItemsInPriceList: aCollectionOfShoppingCartEntries)
		ifFalse: [ self error: self class cantCheckoutItemWithNoPriceForItErrorDescription ]
	
	! !

!Cashier methodsFor: 'validation' stamp: 'nz 6/16/2021 00:12:02'!
assertCanCheckout: aShoppingCart payingWith: aCreditCard on: aGregorianDate

	self assertAllItemsInPriceList: aShoppingCart entries.
	self assertCardIsValid: aCreditCard on: aGregorianDate.! !

!Cashier methodsFor: 'validation' stamp: 'nz 6/16/2021 00:21:41'!
assertCardIsValid: aCreditCard on: aGregorianDate 
	
	(aCreditCard isExpiredOn: aGregorianDate) ifTrue: [
		self error: self class cantCheckWithExpiredCardErrorDescription.	
	].
	aCreditCard hasValidNumber ifFalse: [
		self error: self class invalidCreditCardNumberErrorDescription.	
	].
	aCreditCard hasValidOwnerName ifFalse: [
		self error: self class invalidCreditCardOwnerNameErrorDescription.	
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'Tus-Libros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'AW 6/15/2021 23:06:29'!
withPrices: aPriceList receiptBook: aReceiptBook merchantProcessor: aMerchantProcessor  
	^self new initializePrices: aPriceList receiptBook: aReceiptBook merchantProcessor: aMerchantProcessor ! !


!Cashier class methodsFor: 'errors' stamp: 'AW 6/14/2021 22:11:12'!
cantCheckWithExpiredCardErrorDescription
	^'The card is expired!!'! !

!Cashier class methodsFor: 'errors' stamp: 'nz 6/10/2021 00:21:44'!
cantCheckoutEmptyCartErrorDescription
	^'Cannot checkout an empty shopping cart!!'.! !

!Cashier class methodsFor: 'errors' stamp: 'nz 6/14/2021 19:17:37'!
cantCheckoutItemWithNoPriceForItErrorDescription
	^'Cant checkout item with no price for it!!'.! !

!Cashier class methodsFor: 'errors' stamp: 'nz 6/15/2021 23:55:55'!
invalidCreditCardNumberErrorDescription
	^'The credit card number is invalid!!'.! !

!Cashier class methodsFor: 'errors' stamp: 'nz 6/16/2021 00:21:09'!
invalidCreditCardOwnerNameErrorDescription
	^'Invalid credit card owner name!!'.! !


!classDefinition: #CreditCard category: 'Tus-Libros'!
Object subclass: #CreditCard
	instanceVariableNames: 'number owner expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!CreditCard methodsFor: 'initialization' stamp: 'nz 6/10/2021 00:21:00'!
initializeNumber: aCreditCardNumber owner: anOwnerName expiration: anExpirationMonthOfYear 

	number := aCreditCardNumber.
	owner := anOwnerName.
	expiration := anExpirationMonthOfYear.! !


!CreditCard methodsFor: 'validations' stamp: 'nz 6/16/2021 00:17:53'!
hasValidNumber
	^number size = 16.! !

!CreditCard methodsFor: 'validations' stamp: 'nz 6/16/2021 00:32:49'!
hasValidOwnerName
	^owner withBlanksTrimmed isEmpty not.! !

!CreditCard methodsFor: 'validations' stamp: 'AW 6/14/2021 23:03:42'!
isExpiredOn: aGregorianDate 
	
	^expiration <= aGregorianDate monthOfYear.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'Tus-Libros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'nz 6/10/2021 00:20:07'!
number: aCreditCardNumber owner: anOwnerName expiration: anExpirationMonthOfYear 

	^self new initializeNumber: aCreditCardNumber owner: anOwnerName expiration: anExpirationMonthOfYear ! !


!classDefinition: #MerchantProcessor category: 'Tus-Libros'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!MerchantProcessor methodsFor: 'debit' stamp: 'AW 6/15/2021 23:11:55'!
debit: anAmountOfMoney from: aCreditCard
	
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: 'Tus-Libros'!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'errors' stamp: 'AW 6/15/2021 23:15:42'!
fakeCreditCardErrorDescription
	^'Cannot debit from a fake card!!'.! !

!MerchantProcessor class methodsFor: 'errors' stamp: 'nz 6/16/2021 01:04:01'!
insufficientFundsCreditCardErrorDescription
	^'Cannot debit from a credit card with insufficient funds!!'.! !

!MerchantProcessor class methodsFor: 'errors' stamp: 'nz 6/16/2021 01:04:04'!
stolenCreditCardErrorDescription
	^'Cannot debit from stolen credit card!!'.! !


!classDefinition: #MockAlwaysFakeCardMerchantProcessor category: 'Tus-Libros'!
MerchantProcessor subclass: #MockAlwaysFakeCardMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!MockAlwaysFakeCardMerchantProcessor methodsFor: 'debit' stamp: 'AW 6/15/2021 23:16:20'!
debit: anAmountOfMoney from: aCreditCard 
	
	^self error: self class fakeCreditCardErrorDescription .! !


!classDefinition: #MockAlwaysOkMerchantProcessor category: 'Tus-Libros'!
MerchantProcessor subclass: #MockAlwaysOkMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!MockAlwaysOkMerchantProcessor methodsFor: 'debit' stamp: 'AW 6/15/2021 23:10:31'!
debit: anAmountOfMoney from: aCreditCard ! !


!classDefinition: #MockAlwaysStolenCardMerchantProcessor category: 'Tus-Libros'!
MerchantProcessor subclass: #MockAlwaysStolenCardMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!MockAlwaysStolenCardMerchantProcessor methodsFor: 'debit' stamp: 'AW 6/15/2021 23:07:32'!
debit: anAmountOfMoney from: aCreditCard 
	
	^self error: self class stolenCreditCardErrorDescription.! !


!classDefinition: #MockAlwaysWithoutCreditCardMerchantProcessor category: 'Tus-Libros'!
MerchantProcessor subclass: #MockAlwaysWithoutCreditCardMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!MockAlwaysWithoutCreditCardMerchantProcessor methodsFor: 'debit' stamp: 'AW 6/15/2021 23:30:15'!
debit: anAmountOfMoney from: aCreditCard 
	
	^self error: self class insufficientFundsCreditCardErrorDescription .! !


!classDefinition: #MockTimeProvider category: 'Tus-Libros'!
Object subclass: #MockTimeProvider
	instanceVariableNames: 'now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!MockTimeProvider methodsFor: 'time traveling' stamp: 'AW 6/24/2021 00:57:56'!
toTheFuture: anAmountOfFuture
	now := now next: anAmountOfFuture.! !


!MockTimeProvider methodsFor: 'accessing time' stamp: 'AW 6/24/2021 00:59:41'!
now
	^now.! !


!MockTimeProvider methodsFor: 'initialization' stamp: 'AW 6/24/2021 00:59:25'!
initialize

	now := GregorianDateTime now.! !


!classDefinition: #MockUserAuthenticator category: 'Tus-Libros'!
Object subclass: #MockUserAuthenticator
	instanceVariableNames: 'authenticationResponse'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!MockUserAuthenticator methodsFor: 'initialization' stamp: 'nz 6/17/2021 21:25:35'!
initializeAlwaysReturning: anAuthenticationResponse 
	
	authenticationResponse := anAuthenticationResponse.! !


!MockUserAuthenticator methodsFor: 'as yet unclassified' stamp: 'nz 6/17/2021 21:31:32'!
authenticate: aSmallInteger password: aString 
	^authenticationResponse .! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MockUserAuthenticator class' category: 'Tus-Libros'!
MockUserAuthenticator class
	instanceVariableNames: ''!

!MockUserAuthenticator class methodsFor: 'instance creation' stamp: 'nz 6/17/2021 21:26:42'!
alwaysReturning: anAuthenticationResponse
	^self new initializeAlwaysReturning: anAuthenticationResponse ! !


!classDefinition: #PriceList category: 'Tus-Libros'!
Object subclass: #PriceList
	instanceVariableNames: 'prices'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!PriceList methodsFor: 'initialization' stamp: 'nz 6/14/2021 18:59:05'!
initialize

	prices _ Dictionary new.! !


!PriceList methodsFor: 'accessing' stamp: 'nz 6/14/2021 19:29:04'!
hasPriceFor: aBook 
	
	^prices includesKey: aBook.! !

!PriceList methodsFor: 'accessing' stamp: 'nz 6/14/2021 19:00:48'!
priceFor: aBook 
	
	^prices at: aBook.! !


!PriceList methodsFor: 'set prices' stamp: 'nz 6/16/2021 01:24:12'!
set: aBook price: aPrice 
	self assertPriceIsValid: aPrice.
	prices at: aBook put: aPrice.! !


!PriceList methodsFor: 'validation' stamp: 'nz 6/16/2021 01:24:12'!
assertPriceIsValid: aPrice

	^ (aPrice > 0) ifFalse: [ self error: self class itemPriceMustBePositiveErrorDescription. ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PriceList class' category: 'Tus-Libros'!
PriceList class
	instanceVariableNames: ''!

!PriceList class methodsFor: 'errors' stamp: 'nz 6/16/2021 01:21:09'!
itemPriceMustBePositiveErrorDescription
	^'Item price must be positive!!'.! !


!classDefinition: #PurchasesSummary category: 'Tus-Libros'!
Object subclass: #PurchasesSummary
	instanceVariableNames: 'items total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!PurchasesSummary methodsFor: 'accessing' stamp: 'nz 6/23/2021 00:25:00'!
items
	^ items. ! !

!PurchasesSummary methodsFor: 'accessing' stamp: 'nz 6/23/2021 00:24:54'!
total
	^total.! !


!PurchasesSummary methodsFor: 'initialization' stamp: 'AW 6/23/2021 23:14:32'!
initializeFor: aReceiptCollection

	total := 0.
	items := Bag new.
	aReceiptCollection do: [ :aReceipt | 
		items addAll: aReceipt items.
		total := total + aReceipt total.	
	].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PurchasesSummary class' category: 'Tus-Libros'!
PurchasesSummary class
	instanceVariableNames: ''!

!PurchasesSummary class methodsFor: 'instance creation' stamp: 'AW 6/23/2021 23:08:11'!
for: aReceiptCollection

	^self new initializeFor: aReceiptCollection.! !


!classDefinition: #Receipt category: 'Tus-Libros'!
Object subclass: #Receipt
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!Receipt methodsFor: 'initialization' stamp: 'nz 6/23/2021 01:40:10'!
initializeWithTotal: aTransactionTotal items: aBagOfItems  
	
	total := aTransactionTotal.
	items := aBagOfItems.! !


!Receipt methodsFor: 'accessing' stamp: 'nz 6/23/2021 01:40:20'!
items
	^items.! !

!Receipt methodsFor: 'accessing' stamp: 'nz 6/14/2021 18:49:08'!
total
	^total.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Receipt class' category: 'Tus-Libros'!
Receipt class
	instanceVariableNames: ''!

!Receipt class methodsFor: 'instance creation' stamp: 'nz 6/23/2021 01:39:45'!
withTotal: aTransactionTotal items: aBagOfItems  

	^self new initializeWithTotal: aTransactionTotal items: aBagOfItems ! !


!classDefinition: #Shop category: 'Tus-Libros'!
Object subclass: #Shop
	instanceVariableNames: 'userAuthenticator carts clientReceipts cashier cartsClients timeProvider cartCreationTimes'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!Shop methodsFor: 'facade' stamp: 'AW 6/23/2021 23:34:42'!
add: aQuantity of: anItem to: aShoppingCartId
	
	(self getCart: aShoppingCartId) add: aQuantity of: anItem! !

!Shop methodsFor: 'facade' stamp: 'nz 6/24/2021 16:38:48'!
checkOut: aShoppingCartId payingWith: aCreditCard 
	"
	Acá quedo expuesta la clase de la tarjeta de credito.
	"
	
	| cart clientId receipt |
	
	cart := self getCart: aShoppingCartId. 
	clientId := self getClientIdOf: aShoppingCartId.
	
	receipt := cashier checkOut: cart payingWith: aCreditCard on: self today.
	
	self registerReceipt: receipt for: clientId.
! !

!Shop methodsFor: 'facade' stamp: 'AW 6/24/2021 00:11:58'!
createCartClientId: aClientId password: aPassword

	self authenticateClient: aClientId withPassword: aPassword.

	^self createCartAndGetIdFor: aClientId.! !

!Shop methodsFor: 'facade' stamp: 'nz 6/24/2021 16:39:35'!
listCart: aShoppingCartId 
	"
	Aca nos quedo expuesta la clase ShoppingCartEntry
	Despues de definir PurchasesSummary pensamos en
	refactorizar el carrito para que use una Bag pero
	no llegamos con ese refactor.
	"
	(self cartExists: aShoppingCartId) ifTrue: [ self error: self class invalidCartIdErrorDescription ]. 
 	
	^self getCartEntries: aShoppingCartId.! !

!Shop methodsFor: 'facade' stamp: 'AW 6/23/2021 23:42:03'!
listPurchasesOf: aClientId with: aClientPassword
	
	self authenticateClient: aClientId withPassword: aClientPassword.
	
	^ PurchasesSummary for: (self receiptsFor: aClientId).! !


!Shop methodsFor: 'cart persistence' stamp: 'AW 6/24/2021 00:01:59'!
assertCartExists: aShoppingCartId
	
	(self cartExists: aShoppingCartId ) 
		ifTrue: [ self error: self class invalidCartIdErrorDescription ].
! !

!Shop methodsFor: 'cart persistence' stamp: 'AW 6/22/2021 22:06:13'!
cartExists: aShoppingCartId

	^ carts size < aShoppingCartId! !

!Shop methodsFor: 'cart persistence' stamp: 'AW 6/24/2021 01:22:56'!
createCartAndGetIdFor: aClientId
	| cartId |
	carts add: ShoppingCart new.
	
	cartId := carts size.
	
	cartsClients at: cartId put: aClientId. 
	cartCreationTimes at: cartId put: timeProvider now.
	
	^ cartId.! !

!Shop methodsFor: 'cart persistence' stamp: 'AW 6/24/2021 01:28:40'!
getCart: aShoppingCartId

	self assertCartExists: aShoppingCartId.
	self assertCartIsNotExpired: aShoppingCartId.
	
	^ carts at: aShoppingCartId! !

!Shop methodsFor: 'cart persistence' stamp: 'AW 6/22/2021 22:00:46'!
getCartEntries: aShoppingCartId

	^ (self getCart: aShoppingCartId) entries! !

!Shop methodsFor: 'cart persistence' stamp: 'AW 6/24/2021 00:08:15'!
getClientIdOf: aCartId 
	
	^cartsClients at: aCartId .! !


!Shop methodsFor: 'cart expiration' stamp: 'AW 6/24/2021 01:17:04'!
assertCartIsNotExpired: aCartId 
	| cartAge |
	cartAge := self getCartAgeFor: aCartId. 
	(cartAge > self maxCartAge) 
		ifTrue: [ self error: self class expiredCartErrorDescription ].! !

!Shop methodsFor: 'cart expiration' stamp: 'AW 6/24/2021 01:15:39'!
getCartAgeFor: aCartId
	| cartCreationTime now |
	
	cartCreationTime := self getCreationTime: aCartId.
	now := timeProvider now.
	
	^cartCreationTime distanceTo: now.! !

!Shop methodsFor: 'cart expiration' stamp: 'AW 6/24/2021 01:21:52'!
getCreationTime: aCartId 
	^cartCreationTimes at: aCartId.! !

!Shop methodsFor: 'cart expiration' stamp: 'AW 6/24/2021 01:13:32'!
maxCartAge

	^ 30 * minute! !



!Shop methodsFor: 'client receipts' stamp: 'AW 6/23/2021 23:41:33'!
receiptsFor: aClientId

	^ clientReceipts at: aClientId! !

!Shop methodsFor: 'client receipts' stamp: 'AW 6/23/2021 23:04:08'!
registerReceipt: aReceipt for: aClientId 
	| receipts |
	receipts := clientReceipts at: aClientId ifAbsentPut: OrderedCollection new.
	
	receipts add: aReceipt.! !


!Shop methodsFor: 'time provider' stamp: 'nz 6/23/2021 01:11:36'!
today
	^FixedGregorianDate today.! !


!Shop methodsFor: 'initialization' stamp: 'AW 6/24/2021 01:22:19'!
initializeWithUserAuthenticator: anUserAuthenticator prices: aPriceList merchantProcessor: aMerchantProcessor timeProvider: aTimeProvider    
	
	userAuthenticator := anUserAuthenticator.
	carts := OrderedCollection new.
	clientReceipts  := Dictionary new. 
	cartsClients := Dictionary new. 
	cartCreationTimes := Dictionary new. 
	timeProvider := aTimeProvider.		
	cashier := Cashier
		withPrices: aPriceList
		receiptBook: OrderedCollection new
		merchantProcessor: aMerchantProcessor.
		

		
	
		

		! !


!Shop methodsFor: 'user authentication' stamp: 'AW 6/23/2021 23:40:21'!
authenticateClient: aClientId withPassword: aPassword
	
	(userAuthenticator authenticate: aClientId password: aPassword) ifFalse: [
		self error: self class incorrectPasswordOrClientIdErrorDescription .
	]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Shop class' category: 'Tus-Libros'!
Shop class
	instanceVariableNames: ''!

!Shop class methodsFor: 'errors' stamp: 'AW 6/24/2021 00:38:25'!
expiredCartErrorDescription
	^'The cart is expired!!'.! !

!Shop class methodsFor: 'errors' stamp: 'nz 6/17/2021 21:10:15'!
incorrectPasswordOrClientIdErrorDescription
	^'Incorrect password or client id!!'.! !

!Shop class methodsFor: 'errors' stamp: 'AW 6/22/2021 21:33:52'!
invalidCartIdErrorDescription
	^'The cart id is invalid!!'! !


!Shop class methodsFor: 'instance creation' stamp: 'AW 6/24/2021 00:50:00'!
withUserAuthenticator: anUserAuthenticator prices: aPriceList merchantProcessor: aMerchantProcessor timeProvider: aTimeProvider    

	^self new initializeWithUserAuthenticator: anUserAuthenticator prices: aPriceList merchantProcessor: aMerchantProcessor timeProvider: aTimeProvider ! !


!classDefinition: #ShoppingCart category: 'Tus-Libros'!
Object subclass: #ShoppingCart
	instanceVariableNames: 'entries'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!ShoppingCart methodsFor: 'accessing' stamp: 'nz 6/14/2021 19:02:37'!
entries
	^entries.! !


!ShoppingCart methodsFor: 'adding' stamp: 'nz 6/14/2021 19:42:41'!
add: aQuantity of: anItem 

	self assertQuantityIsValid: aQuantity.
	
	entries add: (ShoppingCartEntry for: anItem quantity: aQuantity).! !


!ShoppingCart methodsFor: 'validations' stamp: 'AW 6/10/2021 20:09:49'!
assertQuantityIsValid: aQuantity

	aQuantity strictlyPositive
		ifFalse: [ self error: self class itemQuantityMustBeGreaterThanZeroErrorDescription ].
	
	aQuantity isInteger
		ifFalse: [ self error: self class itemQuantyMustBeAnIntegerErrorDescription ]! !


!ShoppingCart methodsFor: 'initialization' stamp: 'nz 6/14/2021 19:42:36'!
initialize

	entries := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCart class' category: 'Tus-Libros'!
ShoppingCart class
	instanceVariableNames: ''!

!ShoppingCart class methodsFor: 'errors' stamp: 'nz 6/9/2021 23:47:56'!
itemQuantityMustBeGreaterThanZeroErrorDescription
	^'Cannot add item with negative quantity!!'.! !

!ShoppingCart class methodsFor: 'errors' stamp: 'AW 6/10/2021 20:05:50'!
itemQuantyMustBeAnIntegerErrorDescription
	^'Quanty must be an integer!!'! !


!classDefinition: #ShoppingCartEntry category: 'Tus-Libros'!
Object subclass: #ShoppingCartEntry
	instanceVariableNames: 'item quantity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!ShoppingCartEntry methodsFor: 'initialization' stamp: 'AW 6/9/2021 00:31:25'!
initializeFor: anItem quantity: aQuantity 
	
	item := anItem.
	quantity := aQuantity.! !


!ShoppingCartEntry methodsFor: 'accessing' stamp: 'AW 6/9/2021 00:32:01'!
item
	
	^item! !

!ShoppingCartEntry methodsFor: 'accessing' stamp: 'AW 6/9/2021 00:32:11'!
quantity
	
	^quantity! !


!ShoppingCartEntry methodsFor: 'testing' stamp: 'AW 6/9/2021 00:54:31'!
is: aQuantity of: anItem 
	^(item = anItem) and: [ quantity = aQuantity ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCartEntry class' category: 'Tus-Libros'!
ShoppingCartEntry class
	instanceVariableNames: ''!

!ShoppingCartEntry class methodsFor: 'instance creation' stamp: 'AW 6/9/2021 00:31:03'!
for: anItem quantity: aQuantity 

	^self new initializeFor: anItem quantity: aQuantity ! !


!classDefinition: #TestStubs category: 'Tus-Libros'!
Object subclass: #TestStubs
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!TestStubs methodsFor: 'books' stamp: 'nz 6/23/2021 01:01:49'!
book1
	^'ISBN1'.! !

!TestStubs methodsFor: 'books' stamp: 'nz 6/23/2021 01:01:53'!
book2
	^'ISBN2'.! !

!TestStubs methodsFor: 'books' stamp: 'nz 6/23/2021 01:12:43'!
book3
	^'ISBN3'.! !

!TestStubs methodsFor: 'books' stamp: 'nz 6/23/2021 01:43:29'!
priceList

	| bookPrices |
	bookPrices _ PriceList new.
	bookPrices set: self book1 price: 50.
	bookPrices set: self book2 price: 20.
	bookPrices set: self book3 price: 30.
	^bookPrices.! !


!TestStubs methodsFor: 'cards' stamp: 'nz 6/23/2021 00:43:00'!
cardOwner
	^ 'PEPE SANCHEZ'.! !

!TestStubs methodsFor: 'cards' stamp: 'nz 6/23/2021 00:42:35'!
invalidNumberCreditCard

	^ CreditCard
		number: '418241'
		owner: self cardOwner
		expiration: self currentMonth next.! !

!TestStubs methodsFor: 'cards' stamp: 'AW 6/24/2021 00:25:18'!
mockAlwaysOkMerchantProcessor

	^MockAlwaysOkMerchantProcessor new.! !

!TestStubs methodsFor: 'cards' stamp: 'nz 6/23/2021 01:16:35'!
validCreditCard
	^CreditCard
		number: self validCreditCardNumber
		owner: self cardOwner
		expiration: self currentMonth next.! !

!TestStubs methodsFor: 'cards' stamp: 'nz 6/23/2021 01:16:56'!
validCreditCardNumber
	^'4182418241824182'.! !


!TestStubs methodsFor: 'time' stamp: 'nz 6/23/2021 00:43:27'!
currentMonth
	^ self today monthOfYear.! !

!TestStubs methodsFor: 'time' stamp: 'AW 6/24/2021 00:23:09'!
timeProvider
	^MockTimeProvider new.! !

!TestStubs methodsFor: 'time' stamp: 'nz 6/23/2021 00:43:41'!
today

	^ FixedGregorianDate today.! !
