!classDefinition: #ApplicationFacadeTest category: 'TusLibros'!
TestCase subclass: #ApplicationFacadeTest
	instanceVariableNames: 'testObjectsFactory validExpirationDate merchantProcessorSuccess merchantProcessorFail validIsbn invalidUserID validUserID wrongPassword correctPassword validCardNumber validCardOwner invalidCardNumber expiratedExpirationDate invalidIsbn defaultCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ApplicationFacadeTest methodsFor: 'tests' stamp: 'plp 6/24/2021 00:02:32'!
setUp 

	| validYear validMonth |

	testObjectsFactory := StoreTestObjectsFactory new.
	defaultCatalog := testObjectsFactory defaultCatalog.

	merchantProcessorSuccess := MerchantProcessorSimulatorSuccess new.
	merchantProcessorFail := MerchantProcessorSimulatorFailed new.
	
	validYear := (GregorianDateTime now year number + 1) asString .
	validMonth := GregorianDateTime now monthOfYear monthNumber + 1 .
	validMonth < 10 ifTrue: [ validMonth := '0', validMonth asString ] ifFalse: [ validMonth := validMonth asString ].
	validExpirationDate := validMonth , validYear .
	validCardNumber := 1234567890123456.
	validCardOwner := 'Bjarne Stroustrup'.
	
	invalidCardNumber := 1111.
	expiratedExpirationDate := '122020'.

	validIsbn := testObjectsFactory itemSellByTheStore .
	invalidIsbn := '1111111111111'.	
	
	invalidUserID := 'Non-registered id'.
	wrongPassword := 'WrongPassword'.
	
	validUserID := '12345'.
	correctPassword := 'CorrectPassword'.
	
	now := self now.! !

!ApplicationFacadeTest methodsFor: 'tests' stamp: 'jn 6/24/2021 13:48:44'!
test01CanNotCreateCartWithInvalidCredentials

	| app |
	
	app := self createDefaultCatalogedApp.
	
	self assertErrorCreateCartIn: app with: invalidUserID .
	self assertErrorCreateCartIn: app with: validUserID .! !

!ApplicationFacadeTest methodsFor: 'tests' stamp: 'jn 6/24/2021 16:18:03'!
test02CartIsEmptyBeforeCreateCartForValidCredentials

	| app cartId |
	
	app := self createDefaultCatalogedApp.
	
	cartId := self createCartForValidCredentialsIn: app createAt: self now.
	
	self assert: (app listCartFor: cartId on: self now) isEmpty .! !

!ApplicationFacadeTest methodsFor: 'tests' stamp: 'jn 6/24/2021 13:25:58'!
test03CartsIdNotEqualsWhenCreateMultipleCarts

	| app oneCartId anotherCartId |
	
	app := self createDefaultCatalogedApp.
	
	oneCartId := self createCartForValidCredentialsIn: app createAt: self now.
	anotherCartId := self createCartForValidCredentialsIn: app createAt: self now.
	
	self deny: (oneCartId = anotherCartId).! !

!ApplicationFacadeTest methodsFor: 'tests' stamp: 'jn 6/24/2021 13:26:15'!
test04CanNotAddToCartToInvalidCartId

	| app |
	
	app := self createDefaultCatalogedApp.
	
	self 
		should: [ app addToCart: 0 with: invalidIsbn quantity: 1 on: self now ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = ApplicationFacade invalidCartIdErrorDescription ].! !

!ApplicationFacadeTest methodsFor: 'tests' stamp: 'jn 6/24/2021 16:18:12'!
test05ListCartHasItemAndQuantityAddedToCart

	| app cartId expectedList |
	
	app := self createDefaultCatalogedApp.
	cartId := self createCartForValidCredentialsIn: app createAt: self now.
	self add: 1 ofValidItemToCart: cartId in: app.
	
	expectedList := OrderedCollection new.
	expectedList add: (1@validIsbn).
	
	self assert: (app listCartFor: cartId on: self now) equals: expectedList.! !

!ApplicationFacadeTest methodsFor: 'tests' stamp: 'jn 6/24/2021 13:44:03'!
test06SalesBookHasRegisteredCheckOut

	| app sale salesBook transactionId |
	
	app := self createDefaultCatalogedApp.
	transactionId := (self checkoutCartWith: 1 ofItemin: app createAt: self now checkOutAt: self now) .
		
	sale := (Sale of: StoreTestObjectsFactory new itemSellByTheStorePrice).
	salesBook := app salesBook.
	
	self assert: transactionId equals: 1.
	self assert: (salesBook first total) equals: sale total.
! !

!ApplicationFacadeTest methodsFor: 'tests' stamp: 'jn 6/24/2021 13:47:29'!
test07TransactionsIdsNotEqualesWhenCheckOutMultipleCarts

	| app |
	
	app := self createDefaultCatalogedApp.
			
	self deny: (self checkoutCartWith: 1 ofItemin: app) = (self checkoutCartWith: 2 ofItemin: app)
! !

!ApplicationFacadeTest methodsFor: 'tests' stamp: 'jn 6/24/2021 13:49:02'!
test08CanNotListPurchasesWithInvalidCredentials

	| app |
	
	app := self createDefaultCatalogedApp.
	
	self assertErrorListPurchaseIn: app withUser: invalidUserID andPassword: correctPassword.
	self assertErrorListPurchaseIn: app withUser: validUserID andPassword: wrongPassword .! !

!ApplicationFacadeTest methodsFor: 'tests' stamp: 'jn 6/24/2021 16:07:03'!
test09EmptyListPurchasesOfValidUserWithoutPurchases

	| app purchases |
	
	app := self createDefaultCatalogedApp.
	
	purchases := app listPurchasesFor: validUserID withPassword: correctPassword .
	
	self assert: purchases equals: 0@Dictionary new.! !

!ApplicationFacadeTest methodsFor: 'tests' stamp: 'jn 6/24/2021 16:07:25'!
test10ListPurchasesKnowsItemsQuantityAndTotalOfUserUniquePurchase

	| app purchases expectedDictPurchases |
	
	app := self createDefaultCatalogedApp.
	self checkoutCartWith: 1 ofItemin: app .
	
	purchases := app listPurchasesFor: validUserID withPassword: correctPassword .
	
	expectedDictPurchases := self listPurchasesWith: 1 of: validIsbn total: 10.
	
	self assert: purchases equals: expectedDictPurchases.! !

!ApplicationFacadeTest methodsFor: 'tests' stamp: 'jn 6/24/2021 14:06:54'!
test11ListPurchasesKnowsItemsQuantityAndTotalOfUserMultiplePurchases

	| app purchases expectedListPurchases |
	
	app := self createDefaultCatalogedApp.
	
	self checkoutCartWith: 1 ofItemin: app .
	self checkoutCartWith: 2 ofItemin: app .
	
	purchases := app listPurchasesFor: validUserID withPassword: correctPassword .

	expectedListPurchases := self listPurchasesWith: 3 of: validIsbn total: 30.

	self assert: purchases equals: expectedListPurchases.! !

!ApplicationFacadeTest methodsFor: 'tests' stamp: 'jn 6/24/2021 16:28:10'!
test15ListPurchasesOfMultipleUsers

	| app anotherValidUser anotherCartId purchasesAnotherUser purchasesFirstUser expectedListPurchasesAnotherUser expectedListPurchasesFirstUser |
	
	app := self createDefaultCatalogedApp.
	
	
	self checkoutCartWith: 1 ofItemin: app  .
	
	anotherValidUser := '54321' .
	anotherCartId := app createCartForUser: anotherValidUser password: correctPassword on: self now.
	self add: 2 ofValidItemToCart: anotherCartId in: app.
	app checkOutCart: anotherCartId 
		withCardNumber: validCardNumber 
		owner: validCardOwner 
		expiresOn: validExpirationDate 
		trought: merchantProcessorSuccess 
		on: self now .
	
	purchasesFirstUser := app listPurchasesFor: validUserID withPassword: correctPassword .
	purchasesAnotherUser := app listPurchasesFor: anotherValidUser withPassword: correctPassword .
	
	expectedListPurchasesFirstUser := self listPurchasesWith: 1 of: validIsbn total: 10.
	expectedListPurchasesAnotherUser := self listPurchasesWith: 2 of: validIsbn total: 20.
	
	self assert: purchasesFirstUser equals: expectedListPurchasesFirstUser.
	self assert: purchasesAnotherUser equals: expectedListPurchasesAnotherUser.! !

!ApplicationFacadeTest methodsFor: 'tests' stamp: 'jn 6/24/2021 16:48:03'!
test16AddToCartFailsAfter30MinutesOfInactivity

	| app cartId |
	
	app := self createDefaultCatalogedApp.
	
	cartId := self createCartForValidCredentialsIn: app createAt: self now.
	
	self 
		should: [ app addToCart: cartId with: validIsbn quantity: 1 on: (self now + 30 minutes). ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = ApplicationFacade cartOutOfTimeErrorDescription ]! !

!ApplicationFacadeTest methodsFor: 'tests' stamp: 'jn 6/24/2021 17:04:57'!
test17CheckOutCartFailsAfter30MinutesOfInactivity

	| app now |
	
	app := self createDefaultCatalogedApp.
	now := self now.
	
	self 
		should: [ self checkoutCartWith: 1 ofItemin: app createAt: now checkOutAt: (now + 31 minutes). ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = ApplicationFacade cartOutOfTimeErrorDescription ]! !

!ApplicationFacadeTest methodsFor: 'tests' stamp: 'jn 6/24/2021 16:48:18'!
test18ListCartFailsAfter30MinutesOfInactivity

	| app now cartId |
	
	app := self createDefaultCatalogedApp.
	cartId := self createCartForValidCredentialsIn: app createAt: self now.
	self add: 1 ofValidItemToCart: cartId in: app.
	now := self now.

	self 
		should: [ app listCartFor: cartId on: (now + 30 minutes). ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = ApplicationFacade cartOutOfTimeErrorDescription ]! !

!ApplicationFacadeTest methodsFor: 'tests' stamp: 'jn 6/24/2021 16:33:06'!
test19CanNotCheckoutTwiceSameCart

	| app cartId |
	
	app := self createDefaultCatalogedApp.
	
	cartId := self createCartForValidCredentialsIn: app createAt: self now.
	self add: 1 ofValidItemToCart: cartId in: app.
	app checkOutCart: cartId 
			withCardNumber: validCardNumber 
			owner: validCardOwner 
			expiresOn: validExpirationDate 
			trought: merchantProcessorSuccess on: self now .
	
	self 
		should: [ app checkOutCart: cartId 
			withCardNumber: validCardNumber 
			owner: validCardOwner 
			expiresOn: validExpirationDate 
			trought: merchantProcessorSuccess on: self now .]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = ApplicationFacade canNotCheckoutTwiceSameCartErrorDescription ]! !

!ApplicationFacadeTest methodsFor: 'tests' stamp: 'jn 6/24/2021 16:57:25'!
test20EventFailsAfter30MinutesOfInactivity

	| app now cartId expectedList |
	now := self now.
	app := self createDefaultCatalogedApp.
	cartId := self createCartForValidCredentialsIn: app createAt: now.
	app addToCart: cartId with: validIsbn quantity: 2 on: (now + 15 minutes).
	
	expectedList := OrderedCollection new.
	expectedList add: (2@validIsbn).
	
	self assert: (app listCartFor: cartId on: (self now + 30 minutes)) equals: expectedList.
		! !


!ApplicationFacadeTest methodsFor: 'private' stamp: 'jn 6/24/2021 13:13:00'!
add: aQuantity ofValidItemToCart: aCartID in: anApp  
	
	anApp addToCart: aCartID with: validIsbn quantity: aQuantity on: self now.! !

!ApplicationFacadeTest methodsFor: 'private' stamp: 'jn 6/24/2021 13:06:35'!
assertErrorCreateCartIn: anApp with: anUserID
	
	self 
		should: [ anApp createCartForUser: anUserID password: wrongPassword on: self now ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = ApplicationFacade authenticationFailedErrorDescription ].! !

!ApplicationFacadeTest methodsFor: 'private' stamp: 'jn 6/24/2021 13:13:45'!
assertErrorListPurchaseIn: anApp withUser: aUserId andPassword: aPassword

	self 
		should: [ anApp listPurchasesFor: aUserId withPassword: aPassword ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = ApplicationFacade authenticationFailedErrorDescription ].! !

!ApplicationFacadeTest methodsFor: 'private' stamp: 'jn 6/24/2021 13:45:43'!
checkoutCartWith: aQuantity ofItemin: anApp 

  	^ self checkoutCartWith: aQuantity ofItemin: anApp createAt: self now checkOutAt: self now 
! !

!ApplicationFacadeTest methodsFor: 'private' stamp: 'jn 6/24/2021 13:44:03'!
checkoutCartWith: aQuantity ofItemin: anApp createAt: aCreationTime checkOutAt: aCheckOutTime
	
	| cartId |
	cartId := self createCartForValidCredentialsIn: anApp createAt: aCreationTime.
	self add: aQuantity ofValidItemToCart: cartId in: anApp.
	^ anApp checkOutCart: cartId 
			withCardNumber: validCardNumber 
			owner: validCardOwner 
			expiresOn: validExpirationDate 
			trought: merchantProcessorSuccess on: aCheckOutTime .! !

!ApplicationFacadeTest methodsFor: 'private' stamp: 'jn 6/24/2021 13:14:53'!
createCartForValidCredentialsIn: anApp createAt: aCreationTime

	^ anApp createCartForUser: validUserID password: correctPassword on: aCreationTime.
	! !

!ApplicationFacadeTest methodsFor: 'private' stamp: 'plp 6/24/2021 00:22:34'!
createDefaultCatalogedApp

	^ApplicationFacade forCatalog: defaultCatalog.
! !

!ApplicationFacadeTest methodsFor: 'private' stamp: 'jn 6/24/2021 16:08:07'!
listPurchasesWith: aQuantity of: anIsbn total: total 

	| itemsPurchased |
	itemsPurchased := Dictionary new.
	itemsPurchased add: (anIsbn->aQuantity).
	^ total@itemsPurchased.! !

!ApplicationFacadeTest methodsFor: 'private' stamp: 'plp 6/24/2021 00:00:50'!
now

	^ DateAndTime now ! !


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
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'plp 6/22/2021 19:52:37'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: MerchantProcessorSimulatorSuccess new
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'plp 6/22/2021 19:52:37'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: MerchantProcessorSimulatorSuccess new
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'plp 6/22/2021 19:52:37'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: MerchantProcessorSimulatorSuccess new
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'plp 6/22/2021 19:52:37'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: MerchantProcessorSimulatorSuccess new
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'plp 6/22/2021 19:52:37'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard merchantProcessor |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
	merchantProcessor := MerchantProcessorSimulatorSuccess new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: merchantProcessor
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
	debitedAmout := merchantProcessor debitedAmount.
	debitedCreditCard := merchantProcessor debitedCreditCard.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'plp 6/22/2021 19:53:17'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard merchantProcessor |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
	merchantProcessor := MerchantProcessorSimulatorFailed new.
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: merchantProcessor
		on: testObjectsFactory today
		registeringOn: salesBook.
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'plp 6/22/2021 19:56:53'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'expirationDate validOwner validNumber'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'plp 6/22/2021 20:16:28'!
setUp
	
	| today |
	today := GregorianMonthOfYear current.
	expirationDate := GregorianMonthOfYear yearNumber: (today year number) +1 monthNumber: today monthNumber.
	validOwner := 'Alan Kay'.
	validNumber := 1234567890123456.! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'plp 6/22/2021 20:15:29'!
test01CanNotCreateACardWithNumberDigitsNotEqualsTo16

	self 
		should: [ CreditCard withNumber: 1234567890123456123543154154 owner: validOwner expiresOn: expirationDate ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | self assert: anError messageText = CreditCard invalidCardErrorMessage. ].
		
	self 
		should: [ CreditCard withNumber: 123 owner: validOwner expiresOn: expirationDate ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | self assert: anError messageText = CreditCard invalidCardErrorMessage. ].! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'plp 6/22/2021 20:15:48'!
test02CanNotCreateACardWithEmptyOwner

	self 
		should: [ CreditCard withNumber: validNumber owner: '' expiresOn: expirationDate ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | self assert: anError messageText = CreditCard invalidCardErrorMessage. ].
		
	self 
		should: [ CreditCard withNumber: validNumber owner: '    ' expiresOn: expirationDate ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | self assert: anError messageText = CreditCard invalidCardErrorMessage. ].
! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'plp 6/22/2021 20:16:00'!
test03CanCreateACardWithValidNumberAndOwner

	|card |
	card := CreditCard withNumber: validNumber owner: validOwner expiresOn: expirationDate.
	
	self assert: card number equals: validNumber.
	self assert: card owner equals: validOwner.
	self assert: card expiresOn equals: expirationDate.

! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'plp 6/22/2021 20:16:08'!
test04CanNotCreateACardWithExceededLengthOwner

	self 
		should: [ 
			CreditCard withNumber: validNumber 
				owner: 'este nombre es mas largo de 30 caracteres' 
				expiresOn: expirationDate ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | self assert: anError messageText = CreditCard invalidCardErrorMessage. ].
		
! !


!classDefinition: #ApplicationFacade category: 'TusLibros'!
Object subclass: #ApplicationFacade
	instanceVariableNames: 'lastCartId catalog carts salesBook lastTransactionId purchases cartsForUsers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ApplicationFacade methodsFor: 'initialization' stamp: 'jn 6/24/2021 16:06:39'!
initializeWith: aCatalog
	
	lastCartId := 0 .
	catalog := aCatalog .
	carts := Dictionary new .
	salesBook := OrderedCollection new .
	lastTransactionId := 0 .
	cartsForUsers := Dictionary new .
	purchases := Dictionary new . ! !

!ApplicationFacade methodsFor: 'initialization' stamp: 'plp 6/23/2021 21:53:19'!
today

	^ GregorianMonthOfYear current.! !


!ApplicationFacade methodsFor: 'communication' stamp: 'jn 6/24/2021 16:46:29'!
addToCart: aCartId with: anISBN quantity: aQuantity on: on 

	|cart|
	cart := self getCart: aCartId ifValidOn: on.
	cart add: aQuantity of: anISBN.
	! !

!ApplicationFacade methodsFor: 'communication' stamp: 'jn 6/24/2021 16:44:03'!
checkOutCart: aCartId withCardNumber: aCardNumber owner: aCardOwner expiresOn: aCardExpirationString trought: aProcessor on: on  

	| card cart cashier total |
	self assertCartNotCheckouted: aCartId.
	cart := self getCart: aCartId ifValidOn: on.
		
	card := self createCardWith: aCardNumber owner: aCardOwner expiresOn: aCardExpirationString .

	cashier := Cashier 
				toCheckout: cart
				charging: card
				throught: aProcessor
				on: self today
				registeringOn: salesBook .
				
	total := cashier checkOut .
	
	self add: aCartId ToPurchasesWithTotal: total. 
	
	^ self getTransactionId.! !

!ApplicationFacade methodsFor: 'communication' stamp: 'jn 6/24/2021 16:45:08'!
createCartForUser: aUserId password: aPassword on: aTimeStamp

	| newCartId newCart |

	self assertAuthentication: aUserId with: aPassword.
	
	newCartId := self getCartId .	
	newCart := Cart acceptingItemsOf: catalog.
	
	carts add: newCartId->(newCart->aTimeStamp) .
	self addCart: newCartId forUser: aUserId.
	
	^ newCartId ! !

!ApplicationFacade methodsFor: 'communication' stamp: 'jn 6/24/2021 16:17:40'!
listCartFor: aCartId on: aDateTime 

	| cart listItems |
	
	cart := self getCart: aCartId ifValidOn: aDateTime.
	listItems := OrderedCollection new.
	
	catalog keysDo: [ :item | |itemQuantity| 
		itemQuantity := (cart occurrencesOf: item).
		itemQuantity = 0 ifFalse: [ listItems add: ( itemQuantity @ item ) ] ].

	^ listItems! !

!ApplicationFacade methodsFor: 'communication' stamp: 'jn 6/24/2021 16:05:24'!
listPurchasesFor: aUserId withPassword: aPassword
	
	| total items userCartsIds |
	self assertAuthentication: aUserId with: aPassword .
	items := 	Dictionary new .
	total := 0 .
	
	userCartsIds := cartsForUsers at: aUserId ifAbsent: [ OrderedCollection new ].
	userCartsIds do: [ :aCartId |  
		(purchases includesKey: aCartId) ifTrue: [
			total := total + purchases at: aCartId. 
			self summarizeItemsFrom: aCartId to: items.
		].		
	].
	
	^ total@items.! !


!ApplicationFacade methodsFor: 'private' stamp: 'jn 6/24/2021 15:46:04'!
add: aCartId ToPurchasesWithTotal: total

	purchases add: aCartId->total .! !

!ApplicationFacade methodsFor: 'private' stamp: 'jn 6/24/2021 16:06:25'!
addCart: aCartId forUser: aUserId

	cartsForUsers at: aUserId ifAbsent: [ 
		cartsForUsers add: aUserId->OrderedCollection new ].
	(cartsForUsers at: aUserId) add: aCartId.
! !

!ApplicationFacade methodsFor: 'private' stamp: 'plp 6/23/2021 21:07:55'!
createCardWith: aCardNumber owner: aCardOwner expiresOn: aCardExpirationString
	
	| expirationMonth expirationYear expiration |
	
	expirationMonth := (aCardExpirationString 	copyFrom: 1 to: 2) asNumber .
	expirationYear := (aCardExpirationString 	copyFrom: 3 to: 6) asNumber .
	
	expiration := GregorianMonthOfYear yearNumber: expirationYear monthNumber: expirationMonth .
	
	^ CreditCard withNumber: aCardNumber owner: aCardOwner expiresOn: expiration ! !

!ApplicationFacade methodsFor: 'private' stamp: 'jn 6/24/2021 16:22:50'!
getCart: aCartId
	
	^ (carts at: aCartId ifAbsent: [ 	self error: ApplicationFacade invalidCartIdErrorDescription ]) key.
	! !

!ApplicationFacade methodsFor: 'private' stamp: 'jn 6/24/2021 17:03:24'!
getCart: aCartId ifValidOn: on

	| cartAndCreation cart |
	
	cartAndCreation := carts at: aCartId ifAbsent: [ 	self error: ApplicationFacade invalidCartIdErrorDescription ].
	self assertCartLastActivity: (cartAndCreation value) on: on .
	cart := cartAndCreation key.
	carts add: (aCartId -> (cart -> on)).
	^  cart.
	! !

!ApplicationFacade methodsFor: 'private' stamp: 'jn 6/24/2021 16:45:41'!
getCartId

	lastCartId := lastCartId + 1.
	^ lastCartId! !

!ApplicationFacade methodsFor: 'private' stamp: 'jn 6/24/2021 16:45:49'!
getTransactionId

	lastTransactionId := lastTransactionId + 1.
	^ lastTransactionId! !

!ApplicationFacade methodsFor: 'private' stamp: 'jn 6/24/2021 16:21:56'!
listCartFor: aCartId

	| cart listItems |
	
	cart := self getCart: aCartId.
	listItems := OrderedCollection new.
	
	catalog keysDo: [ :item | |itemQuantity| 
		itemQuantity := (cart occurrencesOf: item).
		itemQuantity = 0 ifFalse: [ listItems add: ( itemQuantity @ item ) ] ].

	^ listItems! !

!ApplicationFacade methodsFor: 'private' stamp: 'jn 6/24/2021 14:59:24'!
now

	^ DateAndTime now ! !

!ApplicationFacade methodsFor: 'private' stamp: 'jn 6/24/2021 16:19:44'!
summarizeItemsFrom: aCartId to: items

	(self listCartFor: aCartId) do: [ :item | | isbn quantity |
		isbn := item y. quantity := item x.
		items at: isbn ifAbsent: [			items add: isbn->0 ] .
		items at: isbn put: ( (items at: isbn) + quantity)]! !


!ApplicationFacade methodsFor: 'testing' stamp: 'plp 6/23/2021 22:08:37'!
salesBook
	
	^ salesBook! !


!ApplicationFacade methodsFor: 'assertions' stamp: 'plp 6/22/2021 18:34:47'!
assertAuthentication: aUserId with: aPassword

	AuthSimulator authenticateUserId: aUserId withPassword: aPassword.! !

!ApplicationFacade methodsFor: 'assertions' stamp: 'jn 6/24/2021 16:59:27'!
assertCartLastActivity: aCreationDateTime on: on
	
	| difference |
	difference := (on - aCreationDateTime) minutes.
	(difference >= 30) ifTrue: [ self error: ApplicationFacade cartOutOfTimeErrorDescription ].! !

!ApplicationFacade methodsFor: 'assertions' stamp: 'jn 6/24/2021 16:35:28'!
assertCartNotCheckouted: aCartId

	(purchases includesKey: aCartId) ifTrue: [ 
		self error: ApplicationFacade canNotCheckoutTwiceSameCartErrorDescription ].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ApplicationFacade class' category: 'TusLibros'!
ApplicationFacade class
	instanceVariableNames: ''!

!ApplicationFacade class methodsFor: 'as yet unclassified' stamp: 'plp 6/22/2021 18:21:02'!
authenticationFailedErrorDescription
	
	^ 'Wrong User or Password'! !

!ApplicationFacade class methodsFor: 'as yet unclassified' stamp: 'jn 6/24/2021 16:33:32'!
canNotCheckoutTwiceSameCartErrorDescription
	
	^ 'Can not checkout cart twice.'! !

!ApplicationFacade class methodsFor: 'as yet unclassified' stamp: 'plp 6/24/2021 00:07:01'!
cartOutOfTimeErrorDescription
	
	^ 'The cart has ran out of time due to inactivity'! !

!ApplicationFacade class methodsFor: 'as yet unclassified' stamp: 'plp 6/22/2021 18:41:04'!
forCatalog: aCatalog

	^ self new initializeWith: aCatalog.! !

!ApplicationFacade class methodsFor: 'as yet unclassified' stamp: 'plp 6/22/2021 18:55:57'!
invalidCartIdErrorDescription
	
	^ 'Invalid Cart ID'! !


!classDefinition: #AuthSimulator category: 'TusLibros'!
Object subclass: #AuthSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AuthSimulator class' category: 'TusLibros'!
AuthSimulator class
	instanceVariableNames: ''!

!AuthSimulator class methodsFor: 'as yet unclassified' stamp: 'plp 6/23/2021 23:38:22'!
authenticateUserId: aUserId withPassword: aPassword

	(aUserId = 'Non-registered id' or: (aPassword = 'WrongPassword')) ifTrue: [ self error: ApplicationFacade authenticationFailedErrorDescription ].! !


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

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
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

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'plp 6/23/2021 21:14:29'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^ self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'number owner expiresOn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'plp 6/22/2021 20:12:40'!
expiresOn
	^expiresOn! !

!CreditCard methodsFor: 'testing' stamp: 'plp 6/22/2021 20:23:41'!
isExpiredOn: aDate 
	
	^expiresOn < aDate.! !

!CreditCard methodsFor: 'testing' stamp: 'plp 6/22/2021 20:12:36'!
number
	^ number! !

!CreditCard methodsFor: 'testing' stamp: 'plp 6/22/2021 20:12:32'!
owner
	^owner! !


!CreditCard methodsFor: 'initialization' stamp: 'plp 6/22/2021 20:11:53'!
forNumber: aCardNumber owner: anOwner expiresOn: aMonthOfYear

	number := aCardNumber. 
	owner := anOwner.
	expiresOn := aMonthOfYear.! !

!CreditCard methodsFor: 'initialization' stamp: 'plp 6/22/2021 20:11:39'!
initializeExpiringOn: aMonth 
	
	expiresOn := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'plp 6/22/2021 20:13:34'!
withNumber: aCardNumber owner: anOwner expiresOn: aMonthOfYear
				
	self assertCardNumber: aCardNumber.
	self assertCardOwner: anOwner.

	^ self new forNumber: aCardNumber owner: anOwner expiresOn: aMonthOfYear! !


!CreditCard class methodsFor: 'assertions' stamp: 'plp 6/22/2021 20:13:02'!
assertCardNumber: aCardNumber
	
	((aCardNumber numberOfDigitsInBase: 10) = 16) ifFalse: [ self error: self invalidCardErrorMessage ].! !

!CreditCard class methodsFor: 'assertions' stamp: 'plp 6/22/2021 20:13:09'!
assertCardOwner: anOwner
	
	((anOwner withBlanksTrimmed isEmpty) or: (anOwner size > 30))
		ifTrue: [ self error: self invalidCardErrorMessage ].! !

!CreditCard class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!CreditCard class methodsFor: 'error-descriptions' stamp: 'plp 6/22/2021 20:13:13'!
invalidCardErrorMessage

	^'Invalid card'.! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'plp 6/22/2021 19:58:10'!
debit: anAmount from: aCreditCard

	self subclassResponsibility.! !


!classDefinition: #MerchantProcessorSimulatorFailed category: 'TusLibros'!
MerchantProcessorSimulator subclass: #MerchantProcessorSimulatorFailed
	instanceVariableNames: 'debitedAmount debitedCreditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulatorFailed methodsFor: 'as yet unclassified' stamp: 'plp 6/22/2021 19:53:34'!
debit: anAmount from: aCreditCard

	self error: Cashier creditCardHasNoCreditErrorMessage! !


!classDefinition: #MerchantProcessorSimulatorSuccess category: 'TusLibros'!
MerchantProcessorSimulator subclass: #MerchantProcessorSimulatorSuccess
	instanceVariableNames: 'debitedAmount debitedCreditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulatorSuccess methodsFor: 'as yet unclassified' stamp: 'plp 6/22/2021 19:45:45'!
debit: anAmount from: aCreditCard

	debitedAmount := anAmount .
	debitedCreditCard := aCreditCard .! !

!MerchantProcessorSimulatorSuccess methodsFor: 'as yet unclassified' stamp: 'plp 6/22/2021 19:48:53'!
debitedAmount

	^debitedAmount! !

!MerchantProcessorSimulatorSuccess methodsFor: 'as yet unclassified' stamp: 'plp 6/22/2021 19:49:04'!
debitedCreditCard
	
	^debitedCreditCard! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


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


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'plp 6/22/2021 20:21:07'!
expiredCreditCard

	| expirationDate validNumber validOwner |
	expirationDate := GregorianMonthOfYear yearNumber: (today year number) monthNumber: (today monthNumber) - 1.
	validOwner := 'Alan Kay'.
	validNumber := 1234567890123456.
	
	^ CreditCard withNumber: validNumber owner: validOwner expiresOn: expirationDate.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'plp 6/22/2021 20:19:20'!
notExpiredCreditCard
	
	| expirationDate validNumber validOwner |
	expirationDate := GregorianMonthOfYear yearNumber: (today year number) +1 monthNumber: today monthNumber.
	validOwner := 'Alan Kay'.
	validNumber := 1234567890123456.
	
	^ CreditCard withNumber: validNumber owner: validOwner expiresOn: expirationDate.! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'plp 6/22/2021 20:21:46'!
initialize

	today := GregorianMonthOfYear current.! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
