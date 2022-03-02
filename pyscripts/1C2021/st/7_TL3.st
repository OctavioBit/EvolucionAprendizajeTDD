!classDefinition: #TestsTusLibros category: 'TusLibros'!
TestCase subclass: #TestsTusLibros
	instanceVariableNames: 'merchantProcessor cart cashier salesList ISBNCormen ISBNBible ISBNWatkins CormenPrice WatkinsPrice validCardNumber validExpiration validName invalidNumber invalidName todayMonthOfYear innerInterface validClientId validClientPassword cartId invalidClientId invalidClientPassword actualTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestsTusLibros methodsFor: 'testsCart' stamp: 'AM 6/14/2021 21:49:22'!
test01createdCartIsInitializedEmpty
	|aCart |
	
	
	aCart:= self createCart.
	self assert: aCart isEmpty equals: true.! !

!TestsTusLibros methodsFor: 'testsCart' stamp: 'AM 6/14/2021 21:49:38'!
test02addingBookFromCatalogIsRegistered
	cart addToCart: ISBNCormen withQuantity: 1.
	
	self assert: cart size equals: 1.
	self assert:( cart contains: ISBNCormen withQuantity: 1) equals: true.! !

!TestsTusLibros methodsFor: 'testsCart' stamp: 'AM 6/14/2021 21:49:52'!
test03cantAddBookNotFromCatalog
	self 
		should: [	cart addToCart: ISBNBible withQuantity: 1. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
				self assert: Cart invalidISBNError equals: anError messageText.
				self assert: cart size = 0.
			]! !

!TestsTusLibros methodsFor: 'testsCart' stamp: 'AM 6/14/2021 21:50:03'!
test04cantAddZeroBooksToCart
	self 
		should: [	cart addToCart: ISBNCormen withQuantity: 0. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
				self assert: Cart zeroBooksAddedError equals: anError messageText.
				self assert: cart size = 0.
			]! !

!TestsTusLibros methodsFor: 'testsCart' stamp: 'AM 6/14/2021 21:50:22'!
test05CartCanListAllBooksCorrectly

	cart addToCart: ISBNCormen withQuantity: 3.
	cart addToCart: ISBNWatkins withQuantity: 2.
	
	self assert: cart listCart equals:( OrderedCollection with: {ISBNCormen . 3} with: {ISBNWatkins . 2}).! !

!TestsTusLibros methodsFor: 'testsCart' stamp: 'AM 6/14/2021 21:50:40'!
test06EmptyCartGivesPriceSummary0
	
	self assert: cart priceSummary equals:0.! !

!TestsTusLibros methodsFor: 'testsCart' stamp: 'AM 6/17/2021 12:43:06'!
test07CartWithBooksGivesPriceSummaryCorrectly
	
	cart addToCart: ISBNCormen withQuantity: 2. 
	self assert: cart priceSummary equals: CormenPrice * 2.! !

!TestsTusLibros methodsFor: 'testsCart' stamp: 'AM 6/17/2021 12:43:52'!
test08DenyCartHasDifferentQuantityOfBookThanAdded
	cart addToCart: ISBNCormen withQuantity: 10.
	
	self deny:( cart contains: ISBNCormen withQuantity: 1)! !


!TestsTusLibros methodsFor: 'private-create' stamp: 'AM 6/17/2021 13:18:06'!
assertCheckoutWithCard: aCreditCard doesntRegisterToSalesListAndThrowsError: anErrorMessage 
	self 
		should: [	cashier checkOutCart: cart usingCreditCard: aCreditCard onMonthOfYear: todayMonthOfYear andRegisterOn: salesList ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
				self assert: anErrorMessage equals: anError messageText.
				self assert: salesList isEmpty .
			]! !

!TestsTusLibros methodsFor: 'private-create' stamp: 'AM 6/17/2021 12:51:27'!
assertWhen: creditCardCreationBlock raiseError: anErrorMessage 
	self 
		should: creditCardCreationBlock
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anErrorMessage equals: anError messageText.
			
			]! !

!TestsTusLibros methodsFor: 'private-create' stamp: 'sb 6/10/2021 19:46:01'!
createCart
	^ Cart withCatalog: self defaultCatalog.! !

!TestsTusLibros methodsFor: 'private-create' stamp: 'AM 6/24/2021 14:45:21'!
createCartInInterfaceWithValidCredentials
	^innerInterface createCartWithClientId: validClientId andPassword: validClientPassword atTime: actualTime.
	! !

!TestsTusLibros methodsFor: 'private-create' stamp: 'AM 6/17/2021 20:42:41'!
createCashier
	^Cashier createWithMerchantProcessor: merchantProcessor .! !

!TestsTusLibros methodsFor: 'private-create' stamp: 'sb 6/14/2021 13:28:29'!
createCreditCardWithInvalidName
	^ CreditCard withNumber: validCardNumber expiring: validExpiration  andName: invalidName.! !

!TestsTusLibros methodsFor: 'private-create' stamp: 'sb 6/14/2021 13:27:53'!
createCreditCardWithInvalidNumber
	^ CreditCard withNumber: invalidNumber expiring: validExpiration andName: invalidName .! !

!TestsTusLibros methodsFor: 'private-create' stamp: 'sb 6/14/2021 14:58:58'!
createCreditCardWithoutFunds
	^ CreditCard withNumber: '0000000000000000' expiring: validExpiration  andName: validName.! !

!TestsTusLibros methodsFor: 'private-create' stamp: 'AM 6/14/2021 19:14:25'!
createExpiredCreditCard
	^ CreditCard withNumber: validCardNumber expiring: (todayMonthOfYear previous: 25*month) andName: validName.  ! !

!TestsTusLibros methodsFor: 'private-create' stamp: 'sb 6/14/2021 15:39:52'!
createFakeCreditCard
	^ CreditCard withNumber: '0000000000000002' expiring: validExpiration andName: validName.  ! !

!TestsTusLibros methodsFor: 'private-create' stamp: 'sb 6/10/2021 20:20:04'!
createPricelist
	|pricelist|
	pricelist := Dictionary new.
	pricelist add: ISBNCormen -> CormenPrice .
	pricelist add: ISBNWatkins -> WatkinsPrice.
	^pricelist .! !

!TestsTusLibros methodsFor: 'private-create' stamp: 'sb 6/14/2021 15:37:08'!
createStolenCreditCard
		^ CreditCard withNumber: '0000000000000001'  expiring: validExpiration andName: validName.  ! !

!TestsTusLibros methodsFor: 'private-create' stamp: 'sb 6/11/2021 20:16:34'!
createValidCreditCard
	^ CreditCard withNumber: validCardNumber expiring: validExpiration andName: validName.  ! !

!TestsTusLibros methodsFor: 'private-create' stamp: 'sb 6/11/2021 19:29:29'!
defaultCatalog
	|catalog|
	catalog := Dictionary new .
	catalog add: ISBNCormen->CormenPrice; add: ISBNWatkins->WatkinsPrice.
	^ catalog.! !

!TestsTusLibros methodsFor: 'private-create' stamp: 'AM 6/24/2021 14:39:48'!
setUp
	
	ISBNCormen :='9780262033848'.
	ISBNBible := '9780840700551'.
	ISBNWatkins:= '9780470528334'.
	CormenPrice := 60.
	WatkinsPrice := 30.
	validCardNumber  := '1234456712345678'.
	validName := 'Alejandro Mercado'.
	invalidNumber := '12134' .
	invalidName := 'asjdklsajkldsajlkdasjlkdasjlksajd'.
	todayMonthOfYear := FixedGregorianDate today monthOfYear.
	validExpiration := todayMonthOfYear next: 40*month.
	salesList:= OrderedCollection new.
	merchantProcessor := MerchantProcessor new.
	cart:= self createCart .
	cashier:= self createCashier .
	innerInterface := self createInnerInterface.
	validClientId := 123456.
	validClientPassword := 'password'.
	actualTime:= GregorianDateTime now.
	
	! !


!TestsTusLibros methodsFor: 'testCreditCard' stamp: 'AM 6/17/2021 12:51:35'!
test01CantCreateCreditCardWithInvalidNumber

self assertWhen: [self createCreditCardWithInvalidNumber] raiseError: CreditCard invalidCardNumber.


	
	! !

!TestsTusLibros methodsFor: 'testCreditCard' stamp: 'AM 6/17/2021 12:52:06'!
test02CantCreateCreditCardWithInvalidName

self assertWhen: [ self createCreditCardWithInvalidName] raiseError: CreditCard invalidCardName.


	
	! !

!TestsTusLibros methodsFor: 'testCreditCard' stamp: 'AM 6/14/2021 19:24:21'!
test03CreditCardKnowsIsExpiredIfExpired
	self assert: (self createExpiredCreditCard isExpiredOn: todayMonthOfYear ) equals: true

! !

!TestsTusLibros methodsFor: 'testCreditCard' stamp: 'AM 6/14/2021 19:24:42'!
test04CreditCardKnowsIsNotExpiredIfNotExpired
	self assert: (self createValidCreditCard isExpiredOn: todayMonthOfYear ) equals: false

! !


!TestsTusLibros methodsFor: 'testCashier' stamp: 'AM 6/17/2021 13:18:06'!
test01CheckoutEmptyCarShouldRaiseError

self assertCheckoutWithCard:  self createValidCreditCard doesntRegisterToSalesListAndThrowsError: Cashier emptyCartError.	
	! !

!TestsTusLibros methodsFor: 'testCashier' stamp: 'AM 6/14/2021 21:51:56'!
test02CheckoutOfCartIsTheSameAsCartSummaryPrice

	cart addToCart: ISBNCormen withQuantity: 10.
	cashier checkOutCart: cart usingCreditCard: self createValidCreditCard onMonthOfYear: todayMonthOfYear andRegisterOn: salesList.
	self assert: ( salesList first) equals: cart priceSummary.

	
	! !

!TestsTusLibros methodsFor: 'testCashier' stamp: 'AM 6/14/2021 21:52:18'!
test04CheckoutCartWithManyBooksAndQuantityIsTheSameAsCartSummaryPrice

	cart addToCart: ISBNCormen withQuantity: 10. 
	cart addToCart: ISBNWatkins withQuantity: 10. 
	cashier checkOutCart: cart usingCreditCard: self createValidCreditCard onMonthOfYear: todayMonthOfYear andRegisterOn: salesList.
	self assert: ( salesList first) equals: cart priceSummary.
	! !

!TestsTusLibros methodsFor: 'testCashier' stamp: 'AM 6/17/2021 13:18:06'!
test05CannotCheckoutCartWithExpiredCreditCard
	
	cart addToCart: ISBNCormen withQuantity: 10. 	
	self assertCheckoutWithCard: self createExpiredCreditCard doesntRegisterToSalesListAndThrowsError: Cashier expiredCardError.
	


	
	! !

!TestsTusLibros methodsFor: 'testCashier' stamp: 'AM 6/17/2021 13:18:06'!
test06CannotCheckoutCartWithCreditCardWithoutFunds

	cart addToCart: ISBNCormen withQuantity: 10. 
	self assertCheckoutWithCard: self createCreditCardWithoutFunds doesntRegisterToSalesListAndThrowsError: MerchantProcessor insufficientFundsError.



	
	! !

!TestsTusLibros methodsFor: 'testCashier' stamp: 'AM 6/17/2021 13:18:06'!
test07CannotCheckoutCartWithStolenCreditCard

	cart addToCart: ISBNCormen withQuantity: 10. 	
	self assertCheckoutWithCard: self createStolenCreditCard  doesntRegisterToSalesListAndThrowsError: MerchantProcessor stolenCardError .



	
	! !

!TestsTusLibros methodsFor: 'testCashier' stamp: 'AM 6/17/2021 13:18:06'!
test08CannotCheckoutCartWithFakeCreditCard

	cart addToCart: ISBNCormen withQuantity: 10. 	
	self assertCheckoutWithCard: self createFakeCreditCard  doesntRegisterToSalesListAndThrowsError: MerchantProcessor fakeCardError .


	
	! !


!TestsTusLibros methodsFor: 'testInnerInterface' stamp: 'sebas 6/21/2021 17:15:47'!
createInnerInterface
	^ ApplicationInnerInterface withCredentialsValidator: self withCatalog: self defaultCatalog andMerchantProcessor: merchantProcessor! !

!TestsTusLibros methodsFor: 'testInnerInterface' stamp: 'AM 6/24/2021 14:44:47'!
test01listCartOfNewCartIsEmpty
	cartId:=self createCartInInterfaceWithValidCredentials.
	self assert: (innerInterface listCart: cartId atTime: actualTime) isEmpty.
	! !

!TestsTusLibros methodsFor: 'testInnerInterface' stamp: 'AM 6/24/2021 14:41:38'!
test02createCartWithInvalidCredentialsThrowsError
	self 
		should: [	cartId:=innerInterface createCartWithClientId: invalidClientId andPassword: invalidClientPassword atTime: actualTime . ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
				self assert: ApplicationInnerInterface invalidCredentialsError equals: anError messageText.
			]
	! !

!TestsTusLibros methodsFor: 'testInnerInterface' stamp: 'AM 6/24/2021 14:45:45'!
test03listCartAfterAddingAProductGivesCorrectListCart
	cartId:=self createCartInInterfaceWithValidCredentials.
	innerInterface add: ISBNCormen toCart: cartId withQuantity: 5 atTime: actualTime. 
	self assert: (innerInterface listCart: cartId atTime: actualTime) first  equals: {ISBNCormen . 5}.
	! !

!TestsTusLibros methodsFor: 'testInnerInterface' stamp: 'AM 6/24/2021 14:45:57'!
test04createDifferentCartsWillHaveDifferentsID
	| cartId1 cartId2 |
	cartId1:=self createCartInInterfaceWithValidCredentials.
	cartId2:=self createCartInInterfaceWithValidCredentials.
	self deny: (cartId1  = cartId2)! !

!TestsTusLibros methodsFor: 'testInnerInterface' stamp: 'AM 6/24/2021 14:46:27'!
test05DifferentCartsListContentCorrectly
	| cartId1 cartId2 |
	cartId1:=self createCartInInterfaceWithValidCredentials.
	innerInterface add: ISBNCormen toCart: cartId1 withQuantity: 5 atTime: actualTime. 
	cartId2:=self createCartInInterfaceWithValidCredentials.
	innerInterface add: ISBNWatkins toCart: cartId2 withQuantity: 100 atTime: actualTime. 
	
	self assert: (innerInterface listCart: cartId1 atTime: actualTime) first  equals: {ISBNCormen . 5}.
	self assert: (innerInterface listCart: cartId2 atTime: actualTime) first  equals: {ISBNWatkins . 100}.! !

!TestsTusLibros methodsFor: 'testInnerInterface' stamp: 'AM 6/24/2021 14:48:01'!
test06CheckOutTwoDifferentCartsHaveDifferentTransactionID
	| cartId1 cartId2 transactionID1 transactionID2 |
	cartId1:=self createCartInInterfaceWithValidCredentials.
	innerInterface add: ISBNCormen toCart: cartId1 withQuantity: 5 atTime: actualTime. 
	cartId2:=self createCartInInterfaceWithValidCredentials.
	innerInterface add: ISBNWatkins toCart: cartId2 withQuantity: 100 atTime:actualTime. 
 	transactionID1 := innerInterface checkOutCart: cartId1 withCreditCard: self createValidCreditCard atTime: actualTime. 
	transactionID2 := innerInterface checkOutCart: cartId2 withCreditCard: self createValidCreditCard atTime: actualTime. 
	self deny: (transactionID1 = transactionID2)
	
	! !

!TestsTusLibros methodsFor: 'testInnerInterface' stamp: 'AM 6/24/2021 14:48:08'!
test07ListPurchasesMustHaveValidCredentials
	cartId:=self createCartInInterfaceWithValidCredentials.
	self 
		should: [	innerInterface listPurchasesOfClient: validClientId andPassword: invalidClientPassword atTime: actualTime.  ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
				self assert: ApplicationInnerInterface invalidCredentialsError equals: anError messageText.
			]
	
	
	! !

!TestsTusLibros methodsFor: 'testInnerInterface' stamp: 'AM 6/24/2021 14:48:16'!
test08ListPurchasesOfClientWithoutPurchasesHasTotalAmountZero
	| listPurchases |
	cartId:=self createCartInInterfaceWithValidCredentials.
	listPurchases := innerInterface listPurchasesOfClient: validClientId andPassword: validClientPassword atTime: actualTime  .
	self assert: listPurchases size equals: 1.
	self assert: listPurchases last equals: 0.
	
	
	
	! !

!TestsTusLibros methodsFor: 'testInnerInterface' stamp: 'AM 6/24/2021 14:48:27'!
test09ListPurchasesOfClientWithOnePurchaseHasAllItemsAndCorrectAmount
	| listPurchases |
	cartId:=self createCartInInterfaceWithValidCredentials.
	innerInterface add: ISBNCormen toCart: cartId withQuantity: 5 atTime: actualTime. 
	innerInterface checkOutCart: cartId withCreditCard: self createValidCreditCard atTime: actualTime. 
		
	listPurchases := innerInterface listPurchasesOfClient: validClientId andPassword: validClientPassword atTime: actualTime. 
	
	self assert: listPurchases size equals: 2.
	self assert: listPurchases first equals: {ISBNCormen . 5}.
	self assert: listPurchases last equals: (CormenPrice * 5) 
	
	
	
	! !

!TestsTusLibros methodsFor: 'testInnerInterface' stamp: 'AM 6/24/2021 14:48:42'!
test10ListPurchasesOfClientWithManyPurchasesHasAllItemsAndCorrectAmount
	| listPurchases |
	cartId:=self createCartInInterfaceWithValidCredentials.
	innerInterface add: ISBNCormen toCart: cartId withQuantity: 5 atTime: actualTime. 
	innerInterface checkOutCart: cartId withCreditCard: self createValidCreditCard atTime: actualTime. 
	
	cartId:=self createCartInInterfaceWithValidCredentials.
	innerInterface add: ISBNWatkins toCart: cartId withQuantity: 10 atTime: actualTime. 
	innerInterface checkOutCart: cartId withCreditCard: self createValidCreditCard atTime: actualTime. 
	
	listPurchases := innerInterface listPurchasesOfClient: validClientId andPassword: validClientPassword atTime: actualTime. 
	
	self assert: listPurchases size equals: 3.
	self assert: listPurchases first equals: {ISBNCormen . 5}.
	self assert: listPurchases second equals: {ISBNWatkins . 10}.
	self assert: listPurchases last equals: (CormenPrice * 5) + (WatkinsPrice *10)
	
	
	
	
	! !

!TestsTusLibros methodsFor: 'testInnerInterface' stamp: 'AM 6/24/2021 14:50:07'!
test11ListCart30MinutesAfterCreationThrowsException

	cartId:=self createCartInInterfaceWithValidCredentials .
	self 
		should: [	innerInterface listCart: cartId atTime: (actualTime next: 31*minute)]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
				self assert: ApplicationInnerInterface cartTimeOutError equals: anError messageText.
			]
	
	
	
	
	
	
	
	! !

!TestsTusLibros methodsFor: 'testInnerInterface' stamp: 'AM 6/24/2021 14:59:26'!
test12AddBooksToCart30MinutesAfterCreationThrowsException

	cartId:=self createCartInInterfaceWithValidCredentials .
	self 
		should: [	innerInterface add: ISBNCormen  toCart: cartId  withQuantity: 1  atTime: (actualTime next: 31*minute)]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
				self assert: ApplicationInnerInterface cartTimeOutError equals: anError messageText.
			]
	
	
	
	
	
	
	
	! !

!TestsTusLibros methodsFor: 'testInnerInterface' stamp: 'AM 6/24/2021 15:15:50'!
test13CheckOutCart30MinutesAfterCreationThrowsException

	cartId:=self createCartInInterfaceWithValidCredentials .
	
	innerInterface add: ISBNCormen  toCart: cartId  withQuantity: 1  atTime: actualTime.
	self 
		should: [	innerInterface checkOutCart: cartId withCreditCard: self createValidCreditCard atTime: (actualTime next: 31*minute)]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
				self assert: ApplicationInnerInterface cartTimeOutError equals: anError messageText.
			]
	
	
	
	
	
	
	
	! !

!TestsTusLibros methodsFor: 'testInnerInterface' stamp: 'AM 6/24/2021 16:31:47'!
test14ListPurchasesOfClientWithPurchasesOfSameBookInDifferentCartsAreCountedCorrectly
	| listPurchases |
	cartId:=self createCartInInterfaceWithValidCredentials.
	innerInterface add: ISBNCormen toCart: cartId withQuantity: 5 atTime: actualTime. 
	innerInterface checkOutCart: cartId withCreditCard: self createValidCreditCard atTime: actualTime. 
	
	cartId:=self createCartInInterfaceWithValidCredentials.
	innerInterface add: ISBNCormen toCart: cartId withQuantity: 5 atTime: actualTime. 
	innerInterface checkOutCart: cartId withCreditCard: self createValidCreditCard atTime: actualTime. 
	
	listPurchases := innerInterface listPurchasesOfClient: validClientId andPassword: validClientPassword atTime: actualTime. 
	
	self assert: listPurchases size equals: 2.
	self assert: listPurchases first equals: {ISBNCormen . 10}.
	self assert: listPurchases last equals: (CormenPrice * 10).
	
	
	
	
	! !

!TestsTusLibros methodsFor: 'testInnerInterface' stamp: 'sebas 6/21/2021 17:33:17'!
validateId: aClientId andPassword: aPassword 
	((aClientId = invalidClientId ) or: (aPassword ~= validClientPassword)) ifTrue: [^false] ifFalse:[^true].
	! !


!classDefinition: #ApplicationInnerInterface category: 'TusLibros'!
Object subclass: #ApplicationInnerInterface
	instanceVariableNames: 'credentialsValidator cartDatabase catalog lastId merchantProcessor lastTransactionID clientPurchasedCarts cartsOwnerDatabase'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ApplicationInnerInterface methodsFor: 'assertion' stamp: 'AM 6/24/2021 15:03:25'!
assertCart: aCartID HasntTimedoutAtTime: aGregorianDateTime 
	[(cartDatabase at: aCartID) beingUsedAtTime: aGregorianDateTime ]on: Error do:[:error| self error: self class cartTimeOutError  ].! !

!ApplicationInnerInterface methodsFor: 'assertion' stamp: 'AM 6/17/2021 21:24:14'!
assertValidClientId: aClientId andPassword: aPassword 
	(credentialsValidator validateId: aClientId andPassword: aPassword ) ifFalse:[self error: self class invalidCredentialsError].! !


!ApplicationInnerInterface methodsFor: 'initialization' stamp: 'AM 6/24/2021 12:17:57'!
initializeWithCredentialsValidator: aCredentialsValidator withCatalog: aCatalog andMerchantProcessor: aMerchantProcessor   
	credentialsValidator := aCredentialsValidator.
	catalog := aCatalog.
	lastId := 0.
	cartDatabase := Dictionary  new.
	merchantProcessor := aMerchantProcessor.
	lastTransactionID := 0.
	clientPurchasedCarts := Dictionary new.
	cartsOwnerDatabase := Dictionary new! !


!ApplicationInnerInterface methodsFor: 'cart-operations' stamp: 'AM 6/24/2021 15:00:20'!
add: anISBN toCart: aCartID withQuantity: aQuantity atTime: aGregorianDateTime
	self assertCart: aCartID HasntTimedoutAtTime: aGregorianDateTime .  
	(cartDatabase at: aCartID) addToCart: anISBN withQuantity: aQuantity.
	! !

!ApplicationInnerInterface methodsFor: 'cart-operations' stamp: 'AM 6/24/2021 16:41:11'!
checkOutCart: aCartID withCreditCard: aCreditCard atTime: aGregorianDateTime 
	|cashier |
	self assertCart: aCartID HasntTimedoutAtTime: aGregorianDateTime .
	
	cashier  := Cashier createWithMerchantProcessor: merchantProcessor.
	cashier checkOutCart: (cartDatabase at: aCartID ) usingCreditCard: aCreditCard  onMonthOfYear: aGregorianDateTime monthOfYear andRegisterOn: OrderedCollection new.
	
	self addCartToClientPurchases: aCartID. 
	^ self nextTransactionID.! !

!ApplicationInnerInterface methodsFor: 'cart-operations' stamp: 'AM 6/24/2021 15:26:15'!
createCartWithClientId: aClientId andPassword: aPassword atTime: aGregorianDateTime  
	|newCart cartId|
	self assertValidClientId: aClientId  andPassword: 	aPassword.
	cartId := self nextCartId .
	newCart := TimedCart withCatalog: catalog atTime: aGregorianDateTime .
	cartDatabase add: cartId->newCart.
	cartsOwnerDatabase add: cartId-> aClientId.
	^cartId
	
! !

!ApplicationInnerInterface methodsFor: 'cart-operations' stamp: 'AM 6/24/2021 14:52:23'!
listCart: aCartId atTime: aGregorianDateTime

	self assertCart: aCartId HasntTimedoutAtTime: aGregorianDateTime .
	^ (cartDatabase at: aCartId) listCart.! !

!ApplicationInnerInterface methodsFor: 'cart-operations' stamp: 'AM 6/24/2021 16:54:29'!
listPurchasesOfClient: aClientID andPassword: aClientPassword atTime: aGregorianDateTime  
	|purchasesDictionary totalPurchased listPurchases|
	self assertValidClientId: aClientID andPassword: aClientPassword .
	
	purchasesDictionary :=Dictionary new.
	totalPurchased:= self addPurchasesFromClient: aClientID toDictionary: purchasesDictionary . 
	listPurchases := self listPurchasesDictionary: purchasesDictionary.
	listPurchases add: totalPurchased .
	^ listPurchases ! !


!ApplicationInnerInterface methodsFor: 'private' stamp: 'AM 6/24/2021 16:21:30'!
addCartPurchases: cartList to: aDictionary
	cartList do: [:aListTuple |aDictionary at: (aListTuple first) ifAbsent: [aDictionary add: (aListTuple first->0)].
						aDictionary at: (aListTuple  first) put: ((aDictionary at: (aListTuple  first))+ aListTuple second).
						]! !

!ApplicationInnerInterface methodsFor: 'private' stamp: 'AM 6/24/2021 16:40:49'!
addCartToClientPurchases: aCartID
	|aClientId|

	aClientId := cartsOwnerDatabase at: aCartID .
	(clientPurchasedCarts at: aClientId ifAbsent:[ clientPurchasedCarts at: aClientId put: OrderedCollection new]) add: (cartDatabase at: aCartID). ! !

!ApplicationInnerInterface methodsFor: 'private' stamp: 'AM 6/24/2021 16:55:37'!
addPurchasesFromClient: aClientID toDictionary: purchasesDictionary
	|totalPurchased|
	totalPurchased :=0.
	
	(clientPurchasedCarts at: aClientID ifAbsent:[OrderedCollection new]) do: 
	[:aPurchasedCart| self addCartPurchases: aPurchasedCart listCart to: purchasesDictionary. 
		totalPurchased := totalPurchased + aPurchasedCart priceSummary ].
	
	^totalPurchased.
! !

!ApplicationInnerInterface methodsFor: 'private' stamp: 'AM 6/24/2021 16:53:59'!
listPurchasesDictionary:  purchasesDictionary
	|listPurchases|
	listPurchases :=OrderedCollection new.
	purchasesDictionary keysDo: [:aBookIsbn| listPurchases add: {aBookIsbn. purchasesDictionary at: aBookIsbn}.].
	^listPurchases.! !

!ApplicationInnerInterface methodsFor: 'private' stamp: 'AM 6/24/2021 15:26:51'!
nextCartId
	lastId:=lastId+1.
	^lastId. 
	! !

!ApplicationInnerInterface methodsFor: 'private' stamp: 'sebas 6/21/2021 17:10:14'!
nextTransactionID
	lastTransactionID := lastTransactionID  + 1.
	^lastTransactionID 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ApplicationInnerInterface class' category: 'TusLibros'!
ApplicationInnerInterface class
	instanceVariableNames: ''!

!ApplicationInnerInterface class methodsFor: 'as yet unclassified' stamp: 'AM 6/24/2021 14:58:09'!
cartTimeOutError
	^'Cart has timed out'! !

!ApplicationInnerInterface class methodsFor: 'as yet unclassified' stamp: 'AM 6/17/2021 21:24:48'!
invalidCredentialsError
	^'Invalid password or ID'! !

!ApplicationInnerInterface class methodsFor: 'as yet unclassified' stamp: 'sebas 6/21/2021 17:17:57'!
withCredentialsValidator: aCredentialsValidator withCatalog: aCatalog andMerchantProcessor: aMerchantProcessor   
	^self new initializeWithCredentialsValidator: aCredentialsValidator withCatalog: aCatalog andMerchantProcessor: aMerchantProcessor.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog cartContent'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'testing' stamp: 'sb 6/11/2021 19:13:40'!
contains: anISBN withQuantity: aNumber 
	
	^aNumber = (cartContent occurrencesOf: anISBN)
	! !

!Cart methodsFor: 'testing' stamp: 'Am 6/10/2021 11:30:41'!
isEmpty
	^(self size = 0).! !


!Cart methodsFor: 'accessing' stamp: 'sb 6/11/2021 19:26:25'!
listCart
	|list|
	list := OrderedCollection new.
	cartContent asSet do: [ :aBook| list add: {aBook . cartContent occurrencesOf: aBook}].
	^list 
! !

!Cart methodsFor: 'accessing' stamp: 'sb 6/11/2021 19:46:34'!
priceSummary
	^ cartContent sum: [ :aBook| catalog at: aBook] ifEmpty:[0].! !

!Cart methodsFor: 'accessing' stamp: 'sb 6/11/2021 19:12:38'!
size
	^cartContent size.! !


!Cart methodsFor: 'adding' stamp: 'sb 6/11/2021 19:14:28'!
addToCart: anISBN withQuantity: aNumber 

	self assertISBNValid: anISBN.
	self assertValidQuantity: aNumber.
	
	 cartContent add: anISBN withOccurrences: aNumber.

	
	 ! !

!Cart methodsFor: 'adding' stamp: 'sb 6/11/2021 19:30:19'!
assertISBNValid: anISBN

	^ (catalog includesKey: anISBN) ifFalse:[self error: 	Cart invalidISBNError ]! !

!Cart methodsFor: 'adding' stamp: 'sb 6/10/2021 20:55:04'!
assertValidQuantity: aNumber

	^ (aNumber<1) ifTrue: [self error: 	Cart zeroBooksAddedError ]! !


!Cart methodsFor: 'initialization' stamp: 'sb 6/10/2021 20:51:01'!
initializeWithCatalog: aCatalog 
	catalog := aCatalog.
	cartContent:= Bag  new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'initialize' stamp: 'Am 6/10/2021 11:15:00'!
withCatalog: aCatalog 
	^self new initializeWithCatalog: aCatalog.! !


!Cart class methodsFor: 'error-description' stamp: 'Am 6/10/2021 11:41:16'!
invalidISBNError
	^'Book not in Catalog'! !

!Cart class methodsFor: 'error-description' stamp: 'Am 6/10/2021 11:46:25'!
zeroBooksAddedError
	^'Must add at least one book'! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkOut' stamp: 'AM 6/14/2021 19:56:26'!
checkOutCart: aCart usingCreditCard: aCreditCard onMonthOfYear: aMonthOfYear andRegisterOn: aSalesList    
	
	aCart isEmpty ifTrue: [self error: Cashier emptyCartError].
	(aCreditCard isExpiredOn: aMonthOfYear) ifTrue:[self error: Cashier expiredCardError ].
	
	
	[merchantProcessor debitCreditCard: aCreditCard forAmount:  aCart priceSummary] on: Error do:[:error| self error: (error messageText) ].
	aSalesList addLast: aCart priceSummary.! !


!Cashier methodsFor: 'initialization' stamp: 'AM 6/17/2021 20:42:18'!
initializeWithMerchantProcessor: aMerchantProcessor 
	merchantProcessor := aMerchantProcessor ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error-description' stamp: 'AM 6/17/2021 20:42:04'!
createWithMerchantProcessor: aMerchantProcessor
	^ self new initializeWithMerchantProcessor: aMerchantProcessor .! !

!Cashier class methodsFor: 'error-description' stamp: 'sb 6/10/2021 20:05:31'!
emptyCartError
	^ 'Empty cart cannot be checkout'! !

!Cashier class methodsFor: 'error-description' stamp: 'sb 6/14/2021 13:12:06'!
expiredCardError
	^'Expired card'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'number name expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'AM 6/14/2021 19:01:00'!
initializeWithNumber: aCreditCardNumber expiring: anExpirationDate andName: aName 

	number := aCreditCardNumber.
	expirationDate := anExpirationDate .
	name := aName.! !


!CreditCard methodsFor: 'testing' stamp: 'AM 6/14/2021 19:13:05'!
isExpiredOn: aMonthOfYear 
	^ aMonthOfYear>=expirationDate .! !


!CreditCard methodsFor: 'accessing' stamp: 'sb 6/14/2021 15:25:15'!
expirationDate
	^ expirationDate  copy! !

!CreditCard methodsFor: 'accessing' stamp: 'sb 6/11/2021 20:55:34'!
name
	^ name copy.! !

!CreditCard methodsFor: 'accessing' stamp: 'sb 6/11/2021 20:48:32'!
number
	^ number copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'AM 6/14/2021 19:01:10'!
withNumber: aCreditCardNumber expiring: anExpirationDate andName: aName 

	self assertValidNumber: aCreditCardNumber.
	self assertValidName: aName.

	^self new initializeWithNumber: aCreditCardNumber expiring: anExpirationDate andName: aName ! !


!CreditCard class methodsFor: 'asserting' stamp: 'AM 6/14/2021 19:02:17'!
assertValidName: aName
	(aName size > 30) ifTrue: [self error: self invalidCardName ]
	! !

!CreditCard class methodsFor: 'asserting' stamp: 'AM 6/14/2021 19:02:21'!
assertValidNumber: aCreditCardNumber
	(aCreditCardNumber size = 16 ) ifFalse: [ self error: self invalidCardNumber ].! !


!CreditCard class methodsFor: 'error-description' stamp: 'sb 6/14/2021 11:57:56'!
invalidCardName
	^'Invalid Name'! !

!CreditCard class methodsFor: 'error-description' stamp: 'sb 6/14/2021 11:55:00'!
invalidCardNumber
	^ 'Invalid creditCard Number'! !


!classDefinition: #MerchantProcessor category: 'TusLibros'!
Object subclass: #MerchantProcessor
	instanceVariableNames: 'stolenCard fakeCard fundlessCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'initialization' stamp: 'sb 6/14/2021 15:40:12'!
initialize 
	fundlessCard  := '0000000000000000'.
	stolenCard :=  '0000000000000001'  .
	fakeCard  := '0000000000000002'! !


!MerchantProcessor methodsFor: 'debit' stamp: 'AM 6/17/2021 13:00:55'!
debitCreditCard: aCreditCard forAmount: anAmount
	 aCreditCard number = fundlessCard ifTrue: [self error: self class insufficientFundsError ].
	aCreditCard number = stolenCard ifTrue: [self error: self class stolenCardError ].
	aCreditCard number = fakeCard ifTrue: [self error: self class fakeCardError ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: 'TusLibros'!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'error-description' stamp: 'AM 6/17/2021 12:59:38'!
fakeCardError
^'Fake CreditCard'! !

!MerchantProcessor class methodsFor: 'error-description' stamp: 'AM 6/17/2021 12:58:29'!
insufficientFundsError
	^'Insufficient funds'! !

!MerchantProcessor class methodsFor: 'error-description' stamp: 'AM 6/17/2021 12:59:12'!
stolenCardError
^'Stolen CreditCard'! !


!classDefinition: #TimedCart category: 'TusLibros'!
Object subclass: #TimedCart
	instanceVariableNames: 'lastTimeModified cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TimedCart methodsFor: 'testing' stamp: 'AM 6/24/2021 15:05:47'!
beingUsedAtTime: aGregorianDateTime
	
	(aGregorianDateTime > (lastTimeModified next: 30*minute)) ifTrue:[self error: 'Timeout'] ifFalse:[lastTimeModified := aGregorianDateTime.]
	
	! !


!TimedCart methodsFor: 'as yet unclassified' stamp: 'AM 6/24/2021 12:50:45'!
doesNotUnderstand: aMessage
	^aMessage sendTo: cart.! !


!TimedCart methodsFor: 'initialization' stamp: 'AM 6/24/2021 12:41:23'!
initializeTimedCartWithCatalog: aCatalog atTime: aGregorianDateTime
	cart:= Cart withCatalog: aCatalog.
	lastTimeModified := aGregorianDateTime.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TimedCart class' category: 'TusLibros'!
TimedCart class
	instanceVariableNames: ''!

!TimedCart class methodsFor: 'as yet unclassified' stamp: 'AM 6/24/2021 12:40:49'!
withCatalog: aCatalog atTime: aGregorianDateTime
	^self new initializeTimedCartWithCatalog: aCatalog atTime: aGregorianDateTime! !
