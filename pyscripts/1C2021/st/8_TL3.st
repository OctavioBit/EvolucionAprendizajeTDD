!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

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


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'LEC 6/19/2021 19:50:17'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := SalesBook new.
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

!CashierTest methodsFor: 'tests' stamp: 'LEC 6/19/2021 19:50:31'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: SalesBook new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'LEC 6/19/2021 19:50:50'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := SalesBook new.
	
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

!CashierTest methodsFor: 'tests' stamp: 'LEC 6/20/2021 20:15:37'!
test04CheckoutRegistersASale

	| cart cashier salesBook aSale |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := SalesBook new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	cashier checkOut.
	aSale := OrderedCollection with: {testObjectsFactory itemSellByTheStore. 1.} with:testObjectsFactory itemSellByTheStorePrice. 
					
	self assert: (salesBook listPurchasesByClient: '') equals: aSale.! !

!CashierTest methodsFor: 'tests' stamp: 'LEC 6/19/2021 19:51:13'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := SalesBook new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
	
	merchantProcessor := MerchantProcessorSimulator withDebitBehavior:  [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'LEC 6/19/2021 19:51:21'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := SalesBook new.
 	merchantProcessor := MerchantProcessorSimulator withDebitBehavior: [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
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


!CashierTest methodsFor: 'setup' stamp: 'LEC 6/18/2021 17:44:23'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	merchantProcessor := MerchantProcessorSimulator withDebitBehavior:  [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'LEC 6/18/2021 17:45:05'!
debit: anAmount from: aCreditCard 

	^merchantProcessor debit: anAmount from: aCreditCard ! !


!classDefinition: #EditorialTest category: 'TusLibros'!
TestCase subclass: #EditorialTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!EditorialTest methodsFor: 'testing session expiration' stamp: 'LEC 6/21/2021 17:15:30'!
test10editorialCannotAddItemsInACartWithExpiredSession

	| editorial  cartId clockSimulator sessionDuration aCatalogue aCreditCard aDataBaseOfUsers aMerchantProcessor |
	clockSimulator := ClockSimulator time: (GregorianDateTime now).
	sessionDuration := 30*minute .
	aCreditCard := CreditCard expiringOn: (GregorianDateTime now monthOfYear next).
	aDataBaseOfUsers := Dictionary new at: 'an user' put:'contraseña';yourself.
	aCatalogue := Dictionary new at:'a book' put:5;yourself.
	aMerchantProcessor := MerchantProcessorSimulator withDebitBehavior: [:credit :date|].
	editorial := EditorialInterface withCatalogue: aCatalogue withUsers: aDataBaseOfUsers withProcessor: aMerchantProcessor andTime: clockSimulator .
	cartId := editorial createCartForClient: 'an user' withPassword: 'contraseña'.
	
	clockSimulator advanceMinutes: sessionDuration + (1*minute).
	
	self should: [editorial addToCart: cartId book: 'a book' withAmount: 10.]
	raise: Error
	withMessageText: EditorialInterface expiredSessionErrorDescription.
	! !

!EditorialTest methodsFor: 'testing session expiration' stamp: 'LEC 6/21/2021 17:16:13'!
test11editorialUpdateTheUserSession

	| editorial  cartId clockSimulator aCatalogue  aDataBaseOfUsers aMerchantProcessor |
	clockSimulator := ClockSimulator time: (GregorianDateTime now).
	aDataBaseOfUsers := Dictionary new at: 'an user' put:'contraseña';yourself.
	aCatalogue := Dictionary new at:'a book' put:5;yourself.
	aMerchantProcessor := MerchantProcessorSimulator withDebitBehavior: [:credit :date|].
	editorial := EditorialInterface withCatalogue: aCatalogue withUsers: aDataBaseOfUsers withProcessor: aMerchantProcessor andTime: clockSimulator .
	cartId := editorial createCartForClient: 'an user' withPassword: 'contraseña'.
	
	clockSimulator advanceMinutes: (20*minute).
	editorial addToCart: cartId book: 'a book' withAmount: 10.
	clockSimulator advanceMinutes: (20*minute).
	self assert:(self shouldAcceptAddToCart: editorial  to: cartId book: 'a book' times: 10).
	! !

!EditorialTest methodsFor: 'testing session expiration' stamp: 'LEC 6/21/2021 17:16:50'!
test12editorialCanNotAccesToACartWithExpiredSession

	| editorial  cartId clockSimulator aCatalogue  aDataBaseOfUsers aMerchantProcessor |
	clockSimulator := ClockSimulator time: (GregorianDateTime now).
	aDataBaseOfUsers := Dictionary new at: 'an user' put:'contraseña';yourself.
	aCatalogue := Dictionary new at:'a book' put:5;yourself.
	aMerchantProcessor := MerchantProcessorSimulator withDebitBehavior: [:credit :date|].
	editorial := EditorialInterface withCatalogue: aCatalogue withUsers: aDataBaseOfUsers withProcessor: aMerchantProcessor andTime: clockSimulator .
	cartId := editorial createCartForClient: 'an user' withPassword: 'contraseña'.
	
	clockSimulator advanceMinutes: (32*minute).
	
	self should:  [editorial listCart: cartId]
	raise:  Error
	withMessageText: EditorialInterface expiredSessionErrorDescription .
	self assert: (editorial isAClient: 'an user' withPassword: 'contraseña').! !


!EditorialTest methodsFor: 'testing adding clients' stamp: 'LEC 6/21/2021 17:13:06'!
test08editorialCanAddMoreClients

	| aCatalogue aDataBaseOfUsers aMerchantProcessor editorial |
	aDataBaseOfUsers := Dictionary new.
	aCatalogue := Dictionary new at:'a book' put:5;yourself.
	aMerchantProcessor := MerchantProcessorSimulator withDebitBehavior: [:credit :date|].
	editorial := EditorialInterface withCatalogue: aCatalogue withUsers: aDataBaseOfUsers withProcessor: aMerchantProcessor andTime: GregorianDateTime now.
	
	editorial addClient:'an user' withPassword:'contraseña'.
	self assert: (editorial isAClient: 'an user' withPassword: 'contraseña').
	
	
	
	
	! !

!EditorialTest methodsFor: 'testing adding clients' stamp: 'LEC 6/21/2021 17:14:43'!
test09editorialCannotAddTwiceTheSameClient

	| aCatalogue aDataBaseOfUsers aMerchantProcessor editorial |
	aDataBaseOfUsers := Dictionary new.
	aCatalogue := Dictionary new at:'a book' put:5;yourself.
	aMerchantProcessor := MerchantProcessorSimulator withDebitBehavior: [:credit :date|].
	editorial := EditorialInterface withCatalogue: aCatalogue withUsers: aDataBaseOfUsers withProcessor: aMerchantProcessor andTime: GregorianDateTime now.
	
	editorial addClient:'an user' withPassword:'contraseña'.
	
	self should:  [editorial addClient:'an user' withPassword:'otraContra'.]
	raise:  Error
	withMessageText: EditorialInterface cannotAddTheSameUserNameTwiceErrorDescription.
	self assert: (editorial isAClient: 'an user' withPassword: 'contraseña').
	
	
	
	! !


!EditorialTest methodsFor: 'testing checkout' stamp: 'LEC 6/21/2021 17:11:49'!
test06editorialCannotCheckoutWithAnInvalidCartId

	| aCatalogue aDataBaseOfUsers aMerchantProcessor editorial cartId |
	aDataBaseOfUsers := Dictionary new at: 'an user' put:'contraseña';yourself.
	aCatalogue := Dictionary new at:'a book' put:5;yourself.
	aMerchantProcessor := MerchantProcessorSimulator withDebitBehavior: [:credit :date|].
	editorial := EditorialInterface withCatalogue: aCatalogue withUsers: aDataBaseOfUsers withProcessor: aMerchantProcessor andTime: GregorianDateTime now.
	cartId := -1.
	
	self should:  [editorial checkoutCart: cartId withCreditCard:nil.]
	raise:  Error
	withMessageText: EditorialInterface invalidCartIdErrorDescription 
	
	
	! !

!EditorialTest methodsFor: 'testing checkout' stamp: 'LEC 6/21/2021 17:12:38'!
test07editorialCannotCheckoutTwiceTheSameCart

	| aCatalogue aDataBaseOfUsers aMerchantProcessor editorial cartId aCreditCard |
	aDataBaseOfUsers := Dictionary new at: 'an user' put:'contraseña';yourself.
	aCatalogue := Dictionary new at:'a book' put:5;yourself.
	aMerchantProcessor := MerchantProcessorSimulator withDebitBehavior: [:credit :date|].
	editorial := EditorialInterface withCatalogue: aCatalogue withUsers: aDataBaseOfUsers withProcessor: aMerchantProcessor andTime: GregorianDateTime now.
	cartId := editorial createCartForClient: 'an user' withPassword: 'contraseña'.
	aCreditCard := CreditCard expiringOn: GregorianMonthOfYear current next.
	editorial addToCart: cartId book: 'a book' withAmount: 10.
	editorial checkoutCart: cartId withCreditCard: aCreditCard.
	
	
	self should:  [editorial checkoutCart: cartId withCreditCard: aCreditCard.]
	raise:  Error
	withMessageText: EditorialInterface invalidCartIdErrorDescription 
	
	
	! !


!EditorialTest methodsFor: 'testing list cart' stamp: 'LEC 6/21/2021 17:03:59'!
test03editorialCanListAnEmptyCart

	| aCatalogue aDataBaseOfUsers aMerchantProcessor editorial cartId |
	aDataBaseOfUsers := Dictionary new at: 'an user' put:'contraseña';yourself.
	aCatalogue := Dictionary new at:'a book' put:5;yourself.
	editorial := EditorialInterface withCatalogue: aCatalogue withUsers: aDataBaseOfUsers withProcessor: aMerchantProcessor andTime: GregorianDateTime now.
	
	cartId := editorial createCartForClient: 'an user' withPassword: 'contraseña'.
	
	self assert: (editorial listCart: cartId) equals: Dictionary new
	
	
	! !

!EditorialTest methodsFor: 'testing list cart' stamp: 'LEC 6/21/2021 17:04:27'!
test04editorialCanListACartWithItems

	| aCatalogue aDataBaseOfUsers aMerchantProcessor editorial cartId |
	aDataBaseOfUsers := Dictionary new at: 'an user' put:'contraseña';yourself.
	aCatalogue := Dictionary new at:'a book' put:5;yourself.
	aMerchantProcessor := MerchantProcessorSimulator withDebitBehavior: [].
	editorial := EditorialInterface withCatalogue: aCatalogue withUsers: aDataBaseOfUsers withProcessor: aMerchantProcessor andTime: GregorianDateTime now.
	
	cartId := editorial createCartForClient: 'an user' withPassword: 'contraseña'.
	editorial addToCart: cartId book: 'a book' withAmount: 10.
	
	self assert: (editorial listCart: cartId) equals: (Dictionary new at:'a book' put:10;yourself)
	
	
	! !


!EditorialTest methodsFor: 'testing cart creation' stamp: 'LEC 6/21/2021 17:02:50'!
test01editorialCannotCreateACartWithInvalidUsername

	| aCatalogue aDataBaseOfUsers aMerchantProcessor editorial cartId invalidClient |
	aDataBaseOfUsers := Dictionary new.
	aCatalogue := Dictionary new at:'a book' put:5;yourself.
	invalidClient := 'an invalid client'.
	editorial := EditorialInterface withCatalogue: aCatalogue withUsers: aDataBaseOfUsers withProcessor: aMerchantProcessor andTime: GregorianDateTime now.
	
	self should: [ cartId := editorial createCartForClient: invalidClient withPassword: 'aPassword'] 
	raise: Error
	withMessageText:EditorialInterface invalidClientErrorDescription .
	
	self should: [  editorial addToCart:cartId book:'a book' withAmount:10] 
	raise: Error
	withMessageText:  EditorialInterface invalidCartIdErrorDescription
	
	
	! !

!EditorialTest methodsFor: 'testing cart creation' stamp: 'LEC 6/21/2021 17:03:14'!
test02editorialCannotCreateACartWithInvalidPassword

	| aCatalogue aDataBaseOfUsers aMerchantProcessor editorial cartId |
	aDataBaseOfUsers := Dictionary new at: 'an user' put:'contraseña';yourself.
	aCatalogue := Dictionary new at:'a book' put:5;yourself.
	editorial := EditorialInterface withCatalogue: aCatalogue withUsers: aDataBaseOfUsers withProcessor: aMerchantProcessor andTime: GregorianDateTime now.
	
	self should: [ cartId := editorial createCartForClient: 'an user' withPassword: 'invalid password'] 
	raise: Error
	withMessageText:EditorialInterface invalidClientErrorDescription .
	
	self should: [  editorial addToCart:cartId book:'a book' withAmount:10] 
	raise: Error
	withMessageText:  EditorialInterface invalidCartIdErrorDescription
	
	
	! !


!EditorialTest methodsFor: 'testing purchases by client' stamp: 'LEC 6/21/2021 17:11:15'!
test05editorialCanDoPurchasesByClient

	| aCatalogue aDataBaseOfUsers aMerchantProcessor editorial cartId aCreditCard purchasesOfClient |
	aDataBaseOfUsers := Dictionary new at: 'an user' put:'contraseña';yourself.
	aCatalogue := Dictionary new at:'a book' put:5;yourself.
	aMerchantProcessor := MerchantProcessorSimulator withDebitBehavior: [:credit :date|].
	editorial := EditorialInterface withCatalogue: aCatalogue withUsers: aDataBaseOfUsers withProcessor: aMerchantProcessor andTime: GregorianDateTime now.
	cartId := editorial createCartForClient: 'an user' withPassword: 'contraseña'.
	aCreditCard := CreditCard expiringOn: GregorianMonthOfYear current next.
	editorial addToCart: cartId book: 'a book' withAmount: 10.
	editorial checkoutCart: cartId withCreditCard: aCreditCard.
	purchasesOfClient := OrderedCollection with:{'a book'. 10} with:50.
	self assert: (editorial purchasesByClient: 'an user' withPassword: 'contraseña') equals: purchasesOfClient.
	
	
	! !


!EditorialTest methodsFor: 'should accept' stamp: 'LEC 6/21/2021 15:43:27'!
shouldAcceptAddToCart: editorial  to: cartId book: aBook times: times

	[editorial addToCart: cartId book: aBook withAmount: times] on: Error do:[^false].
	^true! !

!EditorialTest methodsFor: 'should accept' stamp: 'LEC 6/18/2021 18:01:11'!
shouldAcceptListCart: editorial  to: cartId

	[editorial listCart: cartId] on: Error do:[^false].
	^true! !


!classDefinition: #SaleBookTest category: 'TusLibros'!
TestCase subclass: #SaleBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SaleBookTest methodsFor: 'testing' stamp: 'LEC 6/21/2021 16:52:34'!
test01SaleBookCalculatePriceWithoutSales

	| salesBook aClient |
	salesBook := SalesBook new.
	aClient := 'a client'.
	
	self assert: 0 equals: (salesBook totalBoughtPriceForClient: aClient).! !

!SaleBookTest methodsFor: 'testing' stamp: 'LEC 6/21/2021 16:52:42'!
test02SaleBookCalculateTheTotalPrice

	| salesBook cart sale aClient catalogue anotherCart anotherSale |
	salesBook := SalesBook new.
	aClient := 'a client'.
	catalogue := Dictionary new at: 'a book' put:5;yourself.
	cart := Cart acceptingItemsOf: catalogue.
	cart add: 10 of: 'a book'. 
	sale := Sale itemsBoughtFromCart: cart.
	salesBook registerSale: sale  from: aClient.
	anotherCart := Cart acceptingItemsOf: catalogue.
	anotherCart add: 10 of: 'a book'. 
	anotherSale := Sale itemsBoughtFromCart: anotherCart.
	
	salesBook registerSale: anotherSale  from: aClient.
	self assert: 10*5*2 equals: (salesBook totalBoughtPriceForClient: aClient).! !

!SaleBookTest methodsFor: 'testing' stamp: 'LEC 6/21/2021 16:52:52'!
test03SaleBookListPurchasesWithoutSales

	| salesBook aClient |
	salesBook := SalesBook new.
	aClient := 'a client'.

	self assert: (salesBook listPurchasesByClient: aClient) equals: (OrderedCollection with:0)! !

!SaleBookTest methodsFor: 'testing' stamp: 'LEC 6/21/2021 16:53:00'!
test04SaleBookCanListPurchasesWithSales

	| salesBook cart purchases sale aClient catalogue |
	salesBook := SalesBook new.
	aClient := 'a client'.
	catalogue := Dictionary new at: 'a book' put:5;yourself.
	cart := Cart acceptingItemsOf: catalogue.
	cart add: 10 of: 'a book'. 
	sale := Sale itemsBoughtFromCart: cart.
	salesBook registerSale: sale  from: aClient.
	
	purchases := salesBook listPurchasesByClient: aClient.
	self assert: purchases equals:(OrderedCollection with:{'a book'. 10.} with:50);yourself! !

!SaleBookTest methodsFor: 'testing' stamp: 'LEC 6/21/2021 16:53:09'!
test05SaleBookCanListPurchasesWithSalesStacked

	| salesBook cart sale aClient catalogue anotherCart anotherSale purchases |
	salesBook := SalesBook new.
	aClient := 'a client'.
	catalogue := Dictionary new at: 'a book' put:5;yourself.
	cart := Cart acceptingItemsOf: catalogue.
	cart add: 10 of: 'a book'. 
	sale := Sale itemsBoughtFromCart: cart.
	salesBook registerSale: sale  from: aClient.
	anotherCart := Cart acceptingItemsOf: catalogue.
	anotherCart add: 10 of: 'a book'. 
	anotherSale := Sale itemsBoughtFromCart: anotherCart.
	
	salesBook registerSale: anotherSale  from: aClient.
	
	purchases := salesBook listPurchasesByClient: aClient.
	self assert: purchases equals:(OrderedCollection with:{'a book'. 20.} with:100);yourself! !


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


!Cart methodsFor: 'assertions' stamp: 'LEC 6/18/2021 18:48:17'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'LEC 6/18/2021 18:34:50'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Dictionary new.! !


!Cart methodsFor: 'queries' stamp: 'LEC 6/18/2021 18:31:55'!
items

	^items! !

!Cart methodsFor: 'queries' stamp: 'LEC 6/18/2021 18:43:32'!
occurrencesOf: anItem

	^items at: anItem ifAbsent: [0]! !


!Cart methodsFor: 'testing' stamp: 'LEC 6/18/2021 18:43:04'!
includes: anItem

	^items includesKey: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'LEC 6/18/2021 18:55:00'!
totalPrice

	^ items keys sum: [ :anItem | (catalog at: anItem) * (self occurrencesOf: anItem)]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'LEC 6/18/2021 18:42:12'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items at: anItem put: (self occurrencesOf: anItem) + aQuantity.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'LEC 6/18/2021 18:55:00'!
calculateTotal

	total := cart totalPrice.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'LEC 6/19/2021 16:42:14'!
createSale

	^ Sale itemsBoughtFromCart: cart 
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'LEC 6/19/2021 17:36:13'!
registerSaleForClient: aClient

	salesBook registerSale: self createSale from: aClient! !


!Cashier methodsFor: 'checkout' stamp: 'LEC 6/19/2021 17:34:48'!
checkOut

	^self checkOutForClient: ''.! !

!Cashier methodsFor: 'checkout' stamp: 'LEC 6/19/2021 17:34:21'!
checkOutForClient: aClient

	self calculateTotal.
	self debitTotal.
	self registerSaleForClient: aClient.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'LEC 6/20/2021 23:29:12'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate monthOfYear) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


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


!classDefinition: #ClockSimulator category: 'TusLibros'!
Object subclass: #ClockSimulator
	instanceVariableNames: 'dateTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ClockSimulator methodsFor: 'initialization' stamp: 'LEC 6/20/2021 20:39:19'!
initializeWithTime: aGregorianDateTime 
	
	dateTime := aGregorianDateTime.! !


!ClockSimulator methodsFor: 'forward time' stamp: 'LEC 6/20/2021 20:41:40'!
advanceMinutes: aTimeInMinutes
	
	dateTime := dateTime next: aTimeInMinutes! !


!ClockSimulator methodsFor: 'comparation' stamp: 'LEC 6/20/2021 23:19:56'!
>=aGregorianTime

	^dateTime >= aGregorianTime! !


!ClockSimulator methodsFor: 'now' stamp: 'LEC 6/20/2021 21:04:20'!
now

	^dateTime! !


!ClockSimulator methodsFor: 'next' stamp: 'LEC 6/21/2021 15:58:04'!
next: aTimeMeasure
	
	^dateTime next: aTimeMeasure .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ClockSimulator class' category: 'TusLibros'!
ClockSimulator class
	instanceVariableNames: ''!

!ClockSimulator class methodsFor: 'instance creation' stamp: 'LEC 6/20/2021 20:38:33'!
time: aGregorianDateTime 
	
	^self new initializeWithTime: aGregorianDateTime ! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'LEC 6/20/2021 23:34:54'!
isExpiredOn: aDate 
	
	^expiration  < aDate! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #EditorialInterface category: 'TusLibros'!
Object subclass: #EditorialInterface
	instanceVariableNames: 'catalogue merchantProcessor date users carts lastCartId saleBook sessionForCartId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!EditorialInterface methodsFor: 'initialization' stamp: 'LEC 6/21/2021 16:43:06'!
getCartForId: cartId

	(self isAValidCartId: cartId) ifFalse:[self error: self class invalidCartIdErrorDescription].
	(self isExpiredSessionForCartId: cartId) ifTrue:[self error: self class expiredSessionErrorDescription ].
	self updateSessionForCartId: cartId.
	^(carts at: cartId)! !

!EditorialInterface methodsFor: 'initialization' stamp: 'LEC 6/20/2021 23:21:49'!
initializeWith: aCatalogue withUsers: aDBOfUsers withProcessor: aMerchantProcessor andTime: aDate 
	
	catalogue := aCatalogue.
	users := aDBOfUsers.
	merchantProcessor := aMerchantProcessor.
	date := aDate.
	carts:= OrderedCollection new.
	lastCartId := 0.
	saleBook := SalesBook new.
	sessionForCartId := Dictionary new.! !

!EditorialInterface methodsFor: 'initialization' stamp: 'LEC 6/21/2021 16:13:06'!
updateSessionForCartId: cartId

	^ (sessionForCartId at: cartId) updateSessionWith: date! !


!EditorialInterface methodsFor: 'adding to the cart' stamp: 'LEC 6/21/2021 16:28:26'!
addToCart:cartId book: aBook withAmount: anAmount

	(self getCartForId: cartId) add:anAmount of:aBook.
	
! !


!EditorialInterface methodsFor: 'editorial interface' stamp: 'LEC 6/21/2021 16:43:25'!
checkoutCart: aCartId withCreditCard: aCreditCard 
	
	| aCart aCashier aSession |
	aCart := self getCartForId: aCartId .
	aCashier := Cashier toCheckout: aCart charging: aCreditCard throught: merchantProcessor on: date registeringOn: saleBook .	
	aSession := sessionForCartId at: aCartId .
	aCashier checkOutForClient: (aSession client).
	 sessionForCartId removeKey: aCartId ! !

!EditorialInterface methodsFor: 'editorial interface' stamp: 'LEC 6/21/2021 16:09:01'!
createCartForClient: aClient withPassword: aPassword

	| session |
	(self validateClient: aClient withPassword: aPassword) ifFalse:[self error: self class invalidClientErrorDescription].
	
	carts add: (Cart acceptingItemsOf: catalogue ).
	session := Session createSessionForClient: aClient withTime: date copy.
	sessionForCartId at: lastCartId + 1 put: session.
	^lastCartId := lastCartId + 1.
	! !

!EditorialInterface methodsFor: 'editorial interface' stamp: 'LEC 6/21/2021 16:25:26'!
listCart: cartId

	^(self getCartForId:cartId) items! !

!EditorialInterface methodsFor: 'editorial interface' stamp: 'LEC 6/20/2021 20:06:03'!
purchasesByClient: aClient withPassword: aPassword 

	(self validateClient:aClient withPassword: aPassword) ifFalse:[self error: self class invalidClientErrorDescription ].
	^saleBook listPurchasesByClient: aClient! !


!EditorialInterface methodsFor: 'testing' stamp: 'LEC 6/19/2021 17:20:21'!
validateClient: aClient withPassword: aPassword

	^ (users includesKey: aClient) and:[((users at: aClient) = aPassword)]! !


!EditorialInterface methodsFor: 'validations' stamp: 'LEC 6/21/2021 16:51:12'!
isAClient: aClient withPassword: aPassword

	^self validateClient: aClient withPassword: aPassword.
		! !

!EditorialInterface methodsFor: 'validations' stamp: 'LEC 6/20/2021 23:21:49'!
isAValidCartId: aCartId

	^sessionForCartId keys includes: aCartId ! !

!EditorialInterface methodsFor: 'validations' stamp: 'LEC 6/21/2021 15:58:56'!
isExpiredSessionForCartId: cartId

	^date  >= ((sessionForCartId at: cartId) dateTime next: 30*minute) ! !


!EditorialInterface methodsFor: 'adding client' stamp: 'LEC 6/19/2021 20:49:19'!
addClient: aClient withPassword: aPassword

	(users keys includes:aClient)  ifTrue:[self error: self class cannotAddTheSameUserNameTwiceErrorDescription ].
	users at: aClient put: aPassword.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EditorialInterface class' category: 'TusLibros'!
EditorialInterface class
	instanceVariableNames: ''!

!EditorialInterface class methodsFor: 'instance creation' stamp: 'LEC 6/18/2021 13:19:13'!
withCatalogue: aCatalogue withUsers: aDBOfUsers withProcessor: aMerchantProcessor andTime: aDate 
	
	^self new initializeWith: aCatalogue withUsers: aDBOfUsers withProcessor: aMerchantProcessor andTime: aDate ! !


!EditorialInterface class methodsFor: 'error handling' stamp: 'LEC 6/19/2021 20:48:46'!
cannotAddTheSameUserNameTwiceErrorDescription

	^'This user name already exists.'! !

!EditorialInterface class methodsFor: 'error handling' stamp: 'LEC 6/20/2021 20:42:27'!
expiredSessionErrorDescription
	
	^'The session is expired.'! !

!EditorialInterface class methodsFor: 'error handling' stamp: 'LEC 6/18/2021 13:24:00'!
invalidCartIdErrorDescription
	
	^'Invalid cart Id'! !

!EditorialInterface class methodsFor: 'error handling' stamp: 'LEC 6/18/2021 13:20:56'!
invalidClientErrorDescription

	^ 'The client or password are incorrect'! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'debitBehavior blockClosure'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'debit' stamp: 'LEC 6/18/2021 17:42:19'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!MerchantProcessorSimulator methodsFor: 'initialization' stamp: 'LEC 6/18/2021 17:46:44'!
initializeWithDebitBehavior: aDebitBehavior
	
	debitBehavior := aDebitBehavior ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: 'TusLibros'!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'instance creation' stamp: 'LEC 6/18/2021 17:45:43'!
withDebitBehavior: aBlockClosure 
	
	^self new initializeWithDebitBehavior: aBlockClosure ! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'boughtItems totalPrice'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'LEC 6/19/2021 16:25:51'!
totalPrice
	
	^ totalPrice! !


!Sale methodsFor: 'initialization' stamp: 'LEC 6/19/2021 17:05:45'!
boughtItems
	
	^boughtItems
	! !

!Sale methodsFor: 'initialization' stamp: 'LEC 6/19/2021 20:21:15'!
initializeSaleWithCart: aCart 
	
	boughtItems := aCart items copy.
	totalPrice := aCart totalPrice.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'LEC 6/19/2021 15:40:38'!
itemsBoughtFromCart: aCart 
	
	^self new initializeSaleWithCart: aCart! !


!classDefinition: #SalesBook category: 'TusLibros'!
Object subclass: #SalesBook
	instanceVariableNames: 'users'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SalesBook methodsFor: 'total price' stamp: 'LEC 6/19/2021 16:23:38'!
totalBoughtPriceForClient: aClient
	
	^(users at: aClient ifAbsent:[^0]) inject: 0 into:[:totalBoughtPrice :spent| totalBoughtPrice + (spent totalPrice)] .! !


!SalesBook methodsFor: 'initialization' stamp: 'LEC 6/19/2021 15:52:38'!
initialize

	users := Dictionary new.! !


!SalesBook methodsFor: 'purchases by client' stamp: 'LEC 6/20/2021 19:59:28'!
listPurchasesByClient: aClient
	
	| purchasesByClient priceOfAllSales |
	(users includesKey:aClient) ifFalse:[ ^OrderedCollection with:0].
	purchasesByClient := Dictionary new.
	priceOfAllSales := 0.
	(users at: aClient) do:[:aSale|
		self mergeSales: purchasesByClient withSale: aSale boughtItems.
		priceOfAllSales := priceOfAllSales + (aSale totalPrice) 
		].
	purchasesByClient  := self  purchasesToOrderedCollection: purchasesByClient. 
	purchasesByClient add: priceOfAllSales.
	^purchasesByClient 
	! !

!SalesBook methodsFor: 'purchases by client' stamp: 'LEC 6/20/2021 19:57:56'!
mergeSales: purchasesByClient withSale: dictionaryOfItems

	dictionaryOfItems keysAndValuesDo: [:aKey :value|
		(purchasesByClient at: aKey put:value +(purchasesByClient at:aKey  ifAbsent:[0])) .
		]! !

!SalesBook methodsFor: 'purchases by client' stamp: 'LEC 6/20/2021 20:01:24'!
purchasesToOrderedCollection: purchasesByClient

	| orderedCollectionOfPurchases |
	orderedCollectionOfPurchases := OrderedCollection new.
	purchasesByClient keysAndValuesDo: [:aKey :aValue|
		orderedCollectionOfPurchases add: {aKey.  aValue.}.
		].
	^orderedCollectionOfPurchases ! !


!SalesBook methodsFor: 'is empty' stamp: 'LEC 6/19/2021 19:52:33'!
isEmpty

	^users keys isEmpty ! !


!SalesBook methodsFor: 'register sale' stamp: 'LEC 6/19/2021 15:51:36'!
registerSale: aSale from: aClient

	(users includesKey: aClient)
		ifTrue:[(users at: aClient) add: aSale]
		ifFalse:[users at: aClient put:(OrderedCollection with: aSale)]
		
		
	
	! !


!classDefinition: #Session category: 'TusLibros'!
Object subclass: #Session
	instanceVariableNames: 'client dateTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Session methodsFor: 'initialization' stamp: 'LEC 6/20/2021 20:50:52'!
initializeWithClient: aClient andDateTime: aDateTime 

	client := aClient .
	dateTime := aDateTime .! !


!Session methodsFor: 'client' stamp: 'LEC 6/20/2021 23:14:08'!
client
	
	^client! !


!Session methodsFor: 'date' stamp: 'LEC 6/20/2021 20:56:16'!
dateTime
	
	^dateTime! !


!Session methodsFor: 'update' stamp: 'LEC 6/21/2021 15:49:37'!
updateSessionWith: aDate

	^dateTime := aDate! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Session class' category: 'TusLibros'!
Session class
	instanceVariableNames: ''!

!Session class methodsFor: 'instance creation' stamp: 'LEC 6/20/2021 20:49:49'!
createSessionForClient: aClient withTime: aDateTime

	^self new initializeWithClient: aClient andDateTime: aDateTime 
	! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'LEC 6/21/2021 00:06:22'!
expiredCreditCard
	
	^CreditCard expiringOn: GregorianMonthOfYear current previous ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'LEC 6/20/2021 23:26:31'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (GregorianDateTime now monthOfYear next)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'LEC 6/20/2021 23:27:45'!
initialize

	today := GregorianDateTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
