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

!CartTest methodsFor: 'tests' stamp: 'FR 12/3/2020 10:46:00'!
test09CanNotAddNonIntegerNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0.5 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

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

!CashierTest methodsFor: 'tests' stamp: 'FR 12/2/2020 17:29:55'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

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


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'FR 11/29/2020 23:56:00'!
test01CreditCardNumberCannotHaveLessThanSixteenDigits

	self  should: [ CreditCard ownedBy: 'Juan Rodriguez' withNumber: '123456789012345' andExpirationMonthAndYear: GregorianMonthOfYear current ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard invalidNumberErrorDescription! !

!CreditCardTest methodsFor: 'tests' stamp: 'FR 11/29/2020 23:56:09'!
test02CreditCardNameCannotBeEmpty

	self  should: [ CreditCard ownedBy: '' withNumber: '1234567890123456' andExpirationMonthAndYear: GregorianMonthOfYear current ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard invalidNameErrorDescription! !

!CreditCardTest methodsFor: 'tests' stamp: 'FR 11/29/2020 23:56:14'!
test03CreditCardNumberCannotHaveMoreThanSixteenDigits

	self  should: [ CreditCard ownedBy: 'Juan Rodriguez' withNumber: '12345678901234567' andExpirationMonthAndYear: GregorianMonthOfYear current ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard invalidNumberErrorDescription! !

!CreditCardTest methodsFor: 'tests' stamp: 'FR 11/29/2020 23:56:21'!
test04CreditCardWithValidInfoIsCorrectlyCreated

	| aCreditCard |
	
	aCreditCard := CreditCard ownedBy: 'Juan Rodriguez' withNumber: '1234567890123456' andExpirationMonthAndYear: GregorianMonthOfYear current.
	
	self assert: aCreditCard owner = 'Juan Rodriguez'.
	self assert: aCreditCard number = '1234567890123456'.
	self assert: aCreditCard expirationMonthAndYear = GregorianMonthOfYear current.! !


!classDefinition: #TusLibrosInterfaceTest category: 'TusLibros'!
TestCase subclass: #TusLibrosInterfaceTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInterfaceTest methodsFor: 'tests - listing purchases' stamp: 'FR 12/3/2020 15:15:31'!
test11CannotListPurchasesForInvalidClientID

	self listingPurchasesForClientWithID: testObjectsFactory anInvalidClientID
	      andPassword: testObjectsFactory aCorrectPassword
	      on: testObjectsFactory tusLibrosInterfaceWithInvalidClientID
	      shouldRaiseErrorWithMessage: TusLibrosInterface invalidClientIDErrorDescription! !

!TusLibrosInterfaceTest methodsFor: 'tests - listing purchases' stamp: 'FR 12/3/2020 15:15:31'!
test12CannotListPurchasesForClientWithIncorrectPassword

	self listingPurchasesForClientWithID: testObjectsFactory aValidClientID
	      andPassword: testObjectsFactory anIncorrectPassword
	      on: testObjectsFactory tusLibrosInterfaceWithInvalidClientPassword
	      shouldRaiseErrorWithMessage: TusLibrosInterface incorrectPasswordErrorDescription! !

!TusLibrosInterfaceTest methodsFor: 'tests - listing purchases' stamp: 'FR 12/3/2020 15:58:50'!
test13MultiplePurchasesBySameClientAreListedCorrectly

	| aTusLibrosInterface |
	
	aTusLibrosInterface := testObjectsFactory tusLibrosInterfaceWithCorrectCredentials.

	self  checkoutPurchaseOf: 1
		of: testObjectsFactory aBookSoldByPublisher
		forClient: testObjectsFactory aValidClientID
		onInterface: aTusLibrosInterface.

	self  checkoutPurchaseOf: 4
		of: testObjectsFactory anotherBookSoldByPublisher
		forClient: testObjectsFactory aValidClientID
		onInterface: aTusLibrosInterface.

	self  assertPurchaseListFor: testObjectsFactory aValidClientID
		on: aTusLibrosInterface
		hasTotalCost: 450
		andBooks: (Dictionary with: (testObjectsFactory aBookSoldByPublisher) -> 1
						    with: (testObjectsFactory anotherBookSoldByPublisher)->4).! !

!TusLibrosInterfaceTest methodsFor: 'tests - listing purchases' stamp: 'FR 12/3/2020 16:00:37'!
test14PurchasesByMultipleClientsAreListedCorrectly

	| aTusLibrosInterface |
	
	aTusLibrosInterface := testObjectsFactory tusLibrosInterfaceWithCorrectCredentials.

	self  checkoutPurchaseOf: 1
		of: testObjectsFactory aBookSoldByPublisher
		forClient: testObjectsFactory aValidClientID
		onInterface: aTusLibrosInterface.

	self  checkoutPurchaseOf: 4
		of: testObjectsFactory anotherBookSoldByPublisher
		forClient: testObjectsFactory anotherValidClientID
		onInterface: aTusLibrosInterface.
	
	self  assertPurchaseListFor: testObjectsFactory aValidClientID
		on: aTusLibrosInterface
		hasTotalCost: 50
		andBooks: (Dictionary with: (testObjectsFactory aBookSoldByPublisher) -> 1).

	self  assertPurchaseListFor: testObjectsFactory anotherValidClientID
		on: aTusLibrosInterface
		hasTotalCost: 400
		andBooks: (Dictionary with: (testObjectsFactory anotherBookSoldByPublisher) -> 4).! !

!TusLibrosInterfaceTest methodsFor: 'tests - listing purchases' stamp: 'FR 12/3/2020 16:01:29'!
test15PurchaseListForClientThatNeverCreatedCartIsEmpty

	| aTusLibrosInterface |
	
	aTusLibrosInterface := testObjectsFactory tusLibrosInterfaceWithCorrectCredentials.
	
	self  assertPurchaseListFor: testObjectsFactory aValidClientID
		on: aTusLibrosInterface
		hasTotalCost: 0
		andBooks: (Dictionary new).! !

!TusLibrosInterfaceTest methodsFor: 'tests - listing purchases' stamp: 'FR 12/3/2020 16:01:59'!
test16PurchaseListOnlyShowsCheckedOutItems

	| aTusLibrosInterface aCartID |
	
	aTusLibrosInterface := testObjectsFactory tusLibrosInterfaceWithCorrectCredentials.
	
	aCartID := aTusLibrosInterface createCartForClientWithID: testObjectsFactory aValidClientID 
	  	    		      			 andPassword: testObjectsFactory aCorrectPassword.
	
	aTusLibrosInterface add: 1 of: testObjectsFactory aBookSoldByPublisher toCart: aCartID.
			
	self  assertPurchaseListFor: testObjectsFactory aValidClientID
		on: aTusLibrosInterface
		hasTotalCost: 0
		andBooks: (Dictionary new).! !


!TusLibrosInterfaceTest methodsFor: 'tests - listing cart' stamp: 'FR 12/3/2020 15:24:36'!
test07CannotListWithInvalidCartID

	self  listingCartWithID: testObjectsFactory anInvalidCartID
		shouldRaiseErrorWithMessage: TusLibrosInterface invalidCartIDErrorDescription! !


!TusLibrosInterfaceTest methodsFor: 'tests - adding' stamp: 'FR 12/3/2020 15:16:10'!
test04CannotAddToCartWithInvalidCartID

	self  addingToCartWithID: testObjectsFactory anInvalidCartID
		shouldRaiseErrorWithMessage: TusLibrosInterface invalidCartIDErrorDescription! !

!TusLibrosInterfaceTest methodsFor: 'tests - adding' stamp: 'FR 12/3/2020 15:21:19'!
test05BookIsAddedSuccessfully

	self listAfterAdding: 1 of: testObjectsFactory aBookSoldByPublisher
	      shouldBe: (Bag with: testObjectsFactory aBookSoldByPublisher)! !

!TusLibrosInterfaceTest methodsFor: 'tests - adding' stamp: 'FR 12/3/2020 15:22:02'!
test06MultipleBooksAreAddedSuccessfully

	self listAfterAdding: 5 of: testObjectsFactory aBookSoldByPublisher
	      shouldBe: (Bag new add: testObjectsFactory aBookSoldByPublisher withOccurrences: 5; yourself)! !


!TusLibrosInterfaceTest methodsFor: 'private - assertions' stamp: 'FR 12/3/2020 15:15:22'!
addingToCartWithID: aClientID shouldRaiseErrorWithMessage: anErrorMessage

	self  doing: [ :interface | interface add: 1
					  		    of: testObjectsFactory aBookSoldByPublisher
					   		    toCart: testObjectsFactory anInvalidCartID]
		on: testObjectsFactory tusLibrosInterfaceWithCorrectCredentials
		shouldRaiseErrorWithMessage: anErrorMessage.! !

!TusLibrosInterfaceTest methodsFor: 'private - assertions' stamp: 'FR 12/3/2020 16:23:21'!
assertDoing: aBlock refreshesTimeoutwithExpectedCartList: expectedList
	
	| aTusLibrosInterface aCartID aClock |
	
	aClock := Clock new.
		
	aTusLibrosInterface := testObjectsFactory tusLibrosInterfaceWithCorrectCredentialsAndClock: aClock.
	
	aCartID := aTusLibrosInterface createCartForClientWithID: testObjectsFactory aValidClientID 
	  	    		      andPassword: testObjectsFactory aCorrectPassword.
	
	aClock jumpAheadMinutes: 29. 
		
	aBlock value: aTusLibrosInterface value: aCartID.
	
	aClock jumpAheadMinutes: 29. 
	
	aBlock value: aTusLibrosInterface value: aCartID.
		
	self assert: (aTusLibrosInterface listCart: aCartID) equals: expectedList! !

!TusLibrosInterfaceTest methodsFor: 'private - assertions' stamp: 'FR 12/3/2020 15:44:23'!
assertPurchaseList: aPurchaseList IsMadeBy: aClientID withTotalCost: expectedTotal andBooks: expectedBooks

	self assert: (aPurchaseList wasMadeBy: aClientID).
	self assert: aPurchaseList total equals: expectedTotal.
	expectedBooks values isEmpty ifTrue: [
		self assert: aPurchaseList booksWithQuantities size equals: 0.
	] ifFalse: [
		self assert: aPurchaseList booksWithQuantities size equals: expectedBooks values sum
	].
	expectedBooks keysDo: [ :aKey | 
		self assert: (aPurchaseList quantityOf: aKey) = (expectedBooks at: aKey)
	].! !

!TusLibrosInterfaceTest methodsFor: 'private - assertions' stamp: 'FR 12/3/2020 15:56:22'!
assertPurchaseListFor: aClientID on: aTusLibrosInterface hasTotalCost: expectedTotal andBooks: expectedBooks

	| aPurchaseList |
	
	aPurchaseList := aTusLibrosInterface listPurchasesFor: aClientID 
				       	    			  withPassword: testObjectsFactory aCorrectPassword.

	self assert: (aPurchaseList wasMadeBy: aClientID).
	self assert: aPurchaseList total equals: expectedTotal.
	expectedBooks values isEmpty ifTrue: [
		self assert: aPurchaseList booksWithQuantities size equals: 0.
	] ifFalse: [
		self assert: aPurchaseList booksWithQuantities size equals: expectedBooks values sum
	].
	expectedBooks keysDo: [ :aKey | 
		self assert: (aPurchaseList quantityOf: aKey) = (expectedBooks at: aKey)
	].! !

!TusLibrosInterfaceTest methodsFor: 'private - assertions' stamp: 'FR 12/3/2020 15:30:55'!
checkingOutCartWithID: aCartID shouldRaiseErrorWithMessage: anErrorMessage

	self  doing: [ :interface |
			interface checkout: aCartID
					withCreditCard: testObjectsFactory aValidCreditCardNumber
					expiring: testObjectsFactory aNonExpiredDate
					withOwner: testObjectsFactory aValidOwnerName ]
		on: testObjectsFactory tusLibrosInterfaceWithCorrectCredentials
		shouldRaiseErrorWithMessage: anErrorMessage.! !

!TusLibrosInterfaceTest methodsFor: 'private - assertions' stamp: 'FR 12/3/2020 16:03:15'!
checkoutPurchaseOf: anAmount of: aBook forClient: aClientID onInterface: aTusLibrosInterface
	
	| aCartID |
		
	aCartID := aTusLibrosInterface createCartForClientWithID: aClientID
	  	    		     			 andPassword: testObjectsFactory aCorrectPassword.

	aTusLibrosInterface add: anAmount
		    			of: aBook 
		    			toCart: aCartID.

 	^ aTusLibrosInterface checkout: aCartID 
		    withCreditCard: testObjectsFactory aValidCreditCardNumber
		    expiring: testObjectsFactory aNonExpiredDate
		    withOwner: testObjectsFactory aValidOwnerName.! !

!TusLibrosInterfaceTest methodsFor: 'private - assertions' stamp: 'FR 12/3/2020 15:06:37'!
creatingCartWithID: aClientID andPassword: aPassword on: aTusLibrosInterface shouldRaiseErrorWithMessage: anErrorMessage
			
	self  doing: [ :interface | interface createCartForClientWithID: aClientID 
							   andPassword: aPassword]
		on: aTusLibrosInterface
		shouldRaiseErrorWithMessage: anErrorMessage.! !

!TusLibrosInterfaceTest methodsFor: 'private - assertions' stamp: 'FR 12/3/2020 15:05:30'!
doing: aBlock on: aTusLibrosInterface shouldRaiseErrorWithMessage: anErrorMessage
			
	self  should: [ aBlock value: aTusLibrosInterface ]
		raise: testObjectsFactory functionalError
		withMessageText: anErrorMessage! !

!TusLibrosInterfaceTest methodsFor: 'private - assertions' stamp: 'FR 12/3/2020 16:10:26'!
listAfterAdding: anAmount of: aBook shouldBe: expectedList

	self  listAfterDoing: [ :interface :cartID |
			interface add: anAmount of: aBook toCart: cartID
		]
		toCreatedCartShouldBe: expectedList! !

!TusLibrosInterfaceTest methodsFor: 'private - assertions' stamp: 'FR 12/3/2020 16:10:26'!
listAfterDoing: aBlock toCreatedCartShouldBe: expectedList

	| aTusLibrosInterface aCartID |
	
	aTusLibrosInterface := testObjectsFactory tusLibrosInterfaceWithCorrectCredentials.
	
	aCartID := aTusLibrosInterface createCartForClientWithID: testObjectsFactory aValidClientID
				     			 andPassword: testObjectsFactory aCorrectPassword.

	aBlock value: aTusLibrosInterface value: aCartID.

	self  assert: (aTusLibrosInterface listCart: aCartID) 
		equals: expectedList! !

!TusLibrosInterfaceTest methodsFor: 'private - assertions' stamp: 'FR 12/3/2020 15:24:03'!
listingCartWithID: aCartID shouldRaiseErrorWithMessage: anErrorMessage

	self  doing: [ :interface | interface listCart: aCartID ]
		on: testObjectsFactory tusLibrosInterfaceWithCorrectCredentials
		shouldRaiseErrorWithMessage: anErrorMessage.! !

!TusLibrosInterfaceTest methodsFor: 'private - assertions' stamp: 'FR 12/3/2020 15:15:30'!
listingPurchasesForClientWithID: aClientID andPassword: aPassword on: aTusLibrosInterface shouldRaiseErrorWithMessage: anErrorMessage

	self  doing: [ :interface | interface listPurchasesFor: aClientID 
							    withPassword: aPassword]
		on: aTusLibrosInterface
		shouldRaiseErrorWithMessage: anErrorMessage.! !

!TusLibrosInterfaceTest methodsFor: 'private - assertions' stamp: 'FR 12/3/2020 14:56:45'!
shouldRaiseTimeoutErrorAfterThirtyMinutes: blockThatShouldRaiseError

	| aTusLibrosInterface aCartID aClock |
	
	aClock := Clock new.
		
	aTusLibrosInterface := testObjectsFactory tusLibrosInterfaceWithCorrectCredentialsAndClock: aClock.
	
	aCartID := aTusLibrosInterface createCartForClientWithID: testObjectsFactory aValidClientID 
	  	    		      andPassword: testObjectsFactory aCorrectPassword.
	
	aClock jumpAheadMinutes: 30. 
	
	self  should: [ blockThatShouldRaiseError value: aTusLibrosInterface value: aCartID ]
		raise:  testObjectsFactory functionalError
		withMessageText: TusLibrosInterface timeoutErrorDescription! !


!TusLibrosInterfaceTest methodsFor: 'tests - creation' stamp: 'FR 12/3/2020 14:46:04'!
test01CannotCreateCartWithInvalidID

	self  creatingCartWithID: testObjectsFactory anInvalidClientID
		andPassword: testObjectsFactory aCorrectPassword
		on: testObjectsFactory tusLibrosInterfaceWithInvalidClientID
		shouldRaiseErrorWithMessage: TusLibrosInterface invalidClientIDErrorDescription! !

!TusLibrosInterfaceTest methodsFor: 'tests - creation' stamp: 'FR 12/3/2020 14:46:39'!
test02CannotCreateCartWithIncorrectPassword

	self  creatingCartWithID: testObjectsFactory aValidClientID
		andPassword: testObjectsFactory anIncorrectPassword
		on: testObjectsFactory tusLibrosInterfaceWithInvalidClientPassword
		shouldRaiseErrorWithMessage: TusLibrosInterface incorrectPasswordErrorDescription! !

!TusLibrosInterfaceTest methodsFor: 'tests - creation' stamp: 'FR 12/3/2020 16:10:26'!
test03SuccessfulyCreatedCartIsEmpty

	self listAfterDoing: [ :interface :cartID | ] toCreatedCartShouldBe: testObjectsFactory anEmptyBag! !


!TusLibrosInterfaceTest methodsFor: 'setUp' stamp: 'FR 11/29/2020 22:18:44'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!TusLibrosInterfaceTest methodsFor: 'tests - checkout' stamp: 'FR 12/3/2020 15:31:35'!
test08CannotCheckOutWithInvalidCartID

	self checkingOutCartWithID: testObjectsFactory anInvalidCartID
	      shouldRaiseErrorWithMessage: TusLibrosInterface invalidCartIDErrorDescription! !

!TusLibrosInterfaceTest methodsFor: 'tests - checkout' stamp: 'FR 12/3/2020 16:08:10'!
test09SuccessfulCheckoutIsDoneCorrectly

	| aTusLibrosInterface |
	
	aTusLibrosInterface := testObjectsFactory tusLibrosInterfaceWithCorrectCredentials.
	
	self  checkoutPurchaseOf: 1
		of: testObjectsFactory aBookSoldByPublisher
		forClient: testObjectsFactory aValidClientID
		onInterface: aTusLibrosInterface.
	
	self  assertPurchaseListFor: testObjectsFactory aValidClientID
		on: aTusLibrosInterface
		hasTotalCost: 50
		andBooks: (Dictionary with: testObjectsFactory aBookSoldByPublisher -> 1).! !

!TusLibrosInterfaceTest methodsFor: 'tests - checkout' stamp: 'FR 12/3/2020 16:05:43'!
test10TransactionIDIsDifferentEachTime

	| aTusLibrosInterface firstTransactionID secondTransactionID thirdTransactionID |
	
	aTusLibrosInterface := testObjectsFactory tusLibrosInterfaceWithCorrectCredentials.
	
	firstTransactionID := self checkoutPurchaseOf: 1
						of: testObjectsFactory aBookSoldByPublisher
						forClient: testObjectsFactory aValidClientID
						onInterface: aTusLibrosInterface.
	
	secondTransactionID := 	self checkoutPurchaseOf: 4
						     of: testObjectsFactory anotherBookSoldByPublisher
						     forClient: testObjectsFactory aValidClientID
						     onInterface: aTusLibrosInterface.
	
	thirdTransactionID := 	self checkoutPurchaseOf: 2
						     of: testObjectsFactory aBookSoldByPublisher
						     forClient: testObjectsFactory aValidClientID
						     onInterface: aTusLibrosInterface.

	self assert: {firstTransactionID. secondTransactionID. thirdTransactionID} asSet size equals: 3.! !


!TusLibrosInterfaceTest methodsFor: 'tests - timeout' stamp: 'FR 12/3/2020 14:58:14'!
test17CannotAddToCartAfterTimeout

	self shouldRaiseTimeoutErrorAfterThirtyMinutes: [ :interface :cartID |
		interface add: 1
			      of: testObjectsFactory aBookSoldByPublisher
			      toCart: cartID
	]! !

!TusLibrosInterfaceTest methodsFor: 'tests - timeout' stamp: 'FR 12/3/2020 14:58:20'!
test18CannotListCartAfterTimeout

	self shouldRaiseTimeoutErrorAfterThirtyMinutes: [ :interface :cartID |
		interface listCart: cartID
	]! !

!TusLibrosInterfaceTest methodsFor: 'tests - timeout' stamp: 'FR 12/3/2020 14:58:33'!
test19CannotCheckoutCartAfterTimeout

	self shouldRaiseTimeoutErrorAfterThirtyMinutes: [ :interface :cartID |
		interface checkout: cartID
			      withCreditCard: testObjectsFactory aValidCreditCardNumber
			      expiring: testObjectsFactory aNonExpiredDate
			      withOwner: testObjectsFactory aValidOwnerName
	]! !

!TusLibrosInterfaceTest methodsFor: 'tests - timeout' stamp: 'FR 12/3/2020 16:23:21'!
test20AddingToCartRefreshesTimeout

	self  assertDoing: [ :interface :cartID | 
			interface add: 1 of: testObjectsFactory aBookSoldByPublisher toCart: cartID.
		]
		refreshesTimeoutwithExpectedCartList: {testObjectsFactory aBookSoldByPublisher. testObjectsFactory aBookSoldByPublisher} asBag! !

!TusLibrosInterfaceTest methodsFor: 'tests - timeout' stamp: 'FR 12/3/2020 16:23:21'!
test21ListingCartRefreshesTimeout

	self  assertDoing: [ :interface :cartID | 
			interface listCart: cartID.
		]
		refreshesTimeoutwithExpectedCartList: testObjectsFactory anEmptyBag! !


!classDefinition: #Authenticator category: 'TusLibros'!
Object subclass: #Authenticator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Authenticator methodsFor: 'authentication' stamp: 'FR 12/1/2020 22:14:31'!
authenticateWithID: aClientID andPassword: aPassword

	self subclassResponsibility! !


!classDefinition: #AuthenticatorSimulator category: 'TusLibros'!
Authenticator subclass: #AuthenticatorSimulator
	instanceVariableNames: 'authenticationBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!AuthenticatorSimulator methodsFor: 'authentication' stamp: 'FR 12/1/2020 22:03:28'!
authenticateWithID: aClientID andPassword: aPassword

	authenticationBehavior value! !


!AuthenticatorSimulator methodsFor: 'initialization' stamp: 'FR 12/1/2020 22:03:28'!
initializeWith: aBlock

	authenticationBehavior := aBlock! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AuthenticatorSimulator class' category: 'TusLibros'!
AuthenticatorSimulator class
	instanceVariableNames: ''!

!AuthenticatorSimulator class methodsFor: 'instance creation' stamp: 'FR 12/3/2020 00:53:33'!
invalidClientID

	^ self new initializeWith: [ self error: TusLibrosInterface invalidClientIDErrorDescription ]! !

!AuthenticatorSimulator class methodsFor: 'instance creation' stamp: 'FR 12/3/2020 00:53:33'!
invalidClientPassword

	^ self new initializeWith: [ self error: TusLibrosInterface incorrectPasswordErrorDescription ]! !

!AuthenticatorSimulator class methodsFor: 'instance creation' stamp: 'FR 12/1/2020 21:15:19'!
successfulAuthentication

	^ self new initializeWith: [ ]! !


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

!Cart methodsFor: 'assertions' stamp: 'FR 12/3/2020 10:46:30'!
assertIsValidQuantity: aQuantity

	(aQuantity isInteger and: [aQuantity strictlyPositive]) ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'FR 11/30/2020 00:58:28'!
books

	^items copy! !

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

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'FR 12/3/2020 10:14:06'!
registerSale

	salesBook add: (Sale withTotal: cart total andBooks: cart books asBag)! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'FR 12/2/2020 16:55:37'!
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


!Cashier class methodsFor: 'instance creation' stamp: 'FR 12/2/2020 16:55:43'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: salesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: salesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #Clock category: 'TusLibros'!
Object subclass: #Clock
	instanceVariableNames: 'timeOffset'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'jumping' stamp: 'FR 12/1/2020 20:56:13'!
jumpAheadMinutes: anAmountOfMinutes

	timeOffset := timeOffset + (anAmountOfMinutes*minute).	! !


!Clock methodsFor: 'initialization' stamp: 'FR 12/1/2020 20:29:58'!
initialize

	timeOffset := 0*minute! !


!Clock methodsFor: 'accessing' stamp: 'FR 12/1/2020 20:41:56'!
now

	^ GregorianDateTime now next: timeOffset! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'owner number expirationMonthAndYear'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'FR 11/30/2020 00:09:55'!
isExpiredOn: aDate 
	
	^ aDate monthOfYear >= self expirationMonthAndYear! !


!CreditCard methodsFor: 'initialization' stamp: 'FR 11/29/2020 23:58:57'!
initializeWithOwner: anOwnerName number: aCreditCardNumber andExpirationMonthAndYear: anExpirationMonthAndYear

	owner := anOwnerName.
	number := aCreditCardNumber.
	expirationMonthAndYear := anExpirationMonthAndYear.! !


!CreditCard methodsFor: 'accessing' stamp: 'FR 11/30/2020 00:04:44'!
expirationMonthAndYear

	^ expirationMonthAndYear copy! !

!CreditCard methodsFor: 'accessing' stamp: 'FR 11/30/2020 00:04:47'!
number

	^ number copy! !

!CreditCard methodsFor: 'accessing' stamp: 'FR 11/30/2020 00:04:52'!
owner

	^ owner copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'assertions' stamp: 'FR 11/29/2020 23:58:34'!
assertNameIsValid: anOwnerName

	^ anOwnerName ifEmpty: [ self error: self invalidNameErrorDescription ]! !

!CreditCard class methodsFor: 'assertions' stamp: 'FR 11/29/2020 23:58:38'!
assertNumberIsValid: aCreditCardNumber

	^ aCreditCardNumber size ~= 16 ifTrue: [ self error: self invalidNumberErrorDescription ]! !


!CreditCard class methodsFor: 'instance creation' stamp: 'FR 11/29/2020 23:56:35'!
ownedBy: anOwnerName withNumber: aCreditCardNumber andExpirationMonthAndYear: anExpirationMonthAndYear
	
	self assertNumberIsValid: aCreditCardNumber.
	self assertNameIsValid: anOwnerName.
	
	^ self new initializeWithOwner: anOwnerName number: aCreditCardNumber andExpirationMonthAndYear: anExpirationMonthAndYear.! !


!CreditCard class methodsFor: 'error descriptions' stamp: 'FR 11/29/2020 23:58:12'!
invalidNameErrorDescription
	
	^ 'Name is not valid!!'! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'FR 11/29/2020 23:58:18'!
invalidNumberErrorDescription
	
	^ 'Credit card number is invalid!!'! !


!classDefinition: #MerchantProcessor category: 'TusLibros'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'debit' stamp: 'FR 12/1/2020 22:13:24'!
debit: anAmount from: aCreditCard

	self subclassResponsibility! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
MerchantProcessor subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'behavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'debit' stamp: 'FR 11/30/2020 01:02:42'!
debit: anAmount from: aCreditCard

	behavior value! !


!MerchantProcessorSimulator methodsFor: 'initialization' stamp: 'FR 11/30/2020 01:03:34'!
initializeWithBehavior: aBlock

	behavior := aBlock! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: 'TusLibros'!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'instance creation' stamp: 'FR 11/30/2020 01:03:12'!
successfulValidation

	^ self new initializeWithBehavior: []! !


!classDefinition: #Purchase category: 'TusLibros'!
Object subclass: #Purchase
	instanceVariableNames: 'client sale'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Purchase methodsFor: 'initialization' stamp: 'FR 12/2/2020 17:00:35'!
initializeWithClientID: aClientID andSale: aSale

	client := aClientID.
	sale := aSale.
	! !


!Purchase methodsFor: 'accessing' stamp: 'FR 12/2/2020 17:02:12'!
books

	^ sale books! !

!Purchase methodsFor: 'accessing' stamp: 'FR 12/3/2020 10:39:55'!
booksWithQuantities

	^ sale booksWithQuantities! !

!Purchase methodsFor: 'accessing' stamp: 'FR 12/2/2020 17:03:15'!
quantityOf: aBook

	^ sale quantityOf: aBook! !

!Purchase methodsFor: 'accessing' stamp: 'FR 12/2/2020 17:43:32'!
total

	^ sale total! !


!Purchase methodsFor: 'testing' stamp: 'FR 12/2/2020 17:11:49'!
wasMadeBy: aClientID

	^ client = aClientID! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Purchase class' category: 'TusLibros'!
Purchase class
	instanceVariableNames: ''!

!Purchase class methodsFor: 'instance creation' stamp: 'FR 12/2/2020 17:00:17'!
from: aClientID with: aSale

	^ self new initializeWithClientID: aClientID andSale: aSale! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total booksWithQuantities'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'initialization' stamp: 'FR 12/3/2020 10:14:53'!
initializeWithTotal: totalCost andItems: booksWithTheirQuantities

	total := totalCost.
	booksWithQuantities := booksWithTheirQuantities.! !


!Sale methodsFor: 'accessing' stamp: 'FR 12/3/2020 10:15:23'!
books

	^ booksWithQuantities asSet! !

!Sale methodsFor: 'accessing' stamp: 'FR 12/3/2020 10:39:42'!
booksWithQuantities

	^ booksWithQuantities copy! !

!Sale methodsFor: 'accessing' stamp: 'FR 12/3/2020 10:15:47'!
quantityOf: aBook

	^ booksWithQuantities occurrencesOf: aBook! !

!Sale methodsFor: 'accessing' stamp: 'FR 12/2/2020 17:30:15'!
total

	^ total copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'FR 12/3/2020 10:14:06'!
withTotal: totalCost andBooks: booksWithTheirQuantities

	^ self new initializeWithTotal: totalCost andItems: booksWithTheirQuantities! !


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


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'FR 11/30/2020 00:07:06'!
expiredCreditCard
	
	^CreditCard ownedBy: 'Juan Pérez'
			     withNumber: '1234567890123456'
			     andExpirationMonthAndYear: self anExpiredDate! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'FR 11/30/2020 00:06:51'!
notExpiredCreditCard
	
	^CreditCard ownedBy: 'Juan Pérez'
			     withNumber: '1234567890123456'
			     andExpirationMonthAndYear: self aNonExpiredDate! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'FR 11/29/2020 23:35:17'!
initialize

	today := GregorianDateTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'FR 11/29/2020 23:35:38'!
aNonExpiredDate
	
	^ self today monthOfYear next next! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'FR 11/30/2020 00:07:42'!
anExpiredDate
	
	^ self today monthOfYear previous! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'errors' stamp: 'FR 11/29/2020 22:25:58'!
functionalError
	
	^ Error - MessageNotUnderstood! !


!StoreTestObjectsFactory methodsFor: 'client IDs' stamp: 'FR 11/29/2020 22:33:01'!
aValidClientID
	
	^ 'a valid client ID'! !

!StoreTestObjectsFactory methodsFor: 'client IDs' stamp: 'FR 11/29/2020 22:28:14'!
anInvalidClientID
	
	^ 'an invalid client ID'! !

!StoreTestObjectsFactory methodsFor: 'client IDs' stamp: 'FR 11/30/2020 01:14:32'!
anotherValidClientID
	
	^ 'another valid client ID'! !


!StoreTestObjectsFactory methodsFor: 'client passwords' stamp: 'FR 11/29/2020 22:28:33'!
aCorrectPassword
	
	^ 'a correct password'! !

!StoreTestObjectsFactory methodsFor: 'client passwords' stamp: 'FR 11/29/2020 22:33:16'!
anIncorrectPassword
	
	^ 'an incorrect password'! !


!StoreTestObjectsFactory methodsFor: 'books' stamp: 'FR 11/29/2020 22:50:52'!
aBookNotSoldByPublisher
	
	^ 'a book not sold by this publisher'! !

!StoreTestObjectsFactory methodsFor: 'books' stamp: 'FR 11/29/2020 22:43:55'!
aBookSoldByPublisher
	
	^ 'a book sold by this publisher'! !

!StoreTestObjectsFactory methodsFor: 'books' stamp: 'FR 11/30/2020 00:41:41'!
anotherBookSoldByPublisher
	
	^ 'another book sold by this publisher'! !


!StoreTestObjectsFactory methodsFor: 'cart IDs' stamp: 'FR 11/29/2020 22:44:12'!
anInvalidCartID
	
	^ 'an invalid cart ID'! !


!StoreTestObjectsFactory methodsFor: 'catalogs' stamp: 'FR 11/30/2020 01:11:21'!
aCatalog
	
	^ Dictionary with: self aBookSoldByPublisher -> 50 with: self anotherBookSoldByPublisher -> 100! !


!StoreTestObjectsFactory methodsFor: 'credit card numbers' stamp: 'FR 11/29/2020 23:33:54'!
aValidCreditCardNumber
	
	^ '1234567890123456'! !

!StoreTestObjectsFactory methodsFor: 'credit card numbers' stamp: 'FR 11/29/2020 23:43:18'!
anInvalidCreditCardNumber
	
	^ '1'! !


!StoreTestObjectsFactory methodsFor: 'credit card owner name' stamp: 'FR 11/29/2020 23:36:22'!
aValidOwnerName
	
	^ 'Juan Pérez'! !


!StoreTestObjectsFactory methodsFor: 'bags' stamp: 'FR 12/1/2020 17:39:03'!
anEmptyBag

	^ Bag new! !


!StoreTestObjectsFactory methodsFor: 'TusLibros interfaces' stamp: 'FR 12/3/2020 14:51:20'!
tusLibrosInterfaceWithCorrectCredentials

	^ self tusLibrosInterfaceWithCorrectCredentialsAndClock: Clock new.! !

!StoreTestObjectsFactory methodsFor: 'TusLibros interfaces' stamp: 'FR 12/3/2020 14:51:09'!
tusLibrosInterfaceWithCorrectCredentialsAndClock: aClock

	^ TusLibrosInterface withAuthenticator: AuthenticatorSimulator successfulAuthentication
			catalog: self aCatalog
			merchantProcessor: MerchantProcessorSimulator successfulValidation
			andClock: aClock! !

!StoreTestObjectsFactory methodsFor: 'TusLibros interfaces' stamp: 'FR 12/3/2020 14:40:07'!
tusLibrosInterfaceWithInvalidClientID

	^ TusLibrosInterface withAuthenticator: AuthenticatorSimulator invalidClientID
			catalog: self aCatalog
			merchantProcessor: MerchantProcessorSimulator successfulValidation 
			andClock: Clock new.! !

!StoreTestObjectsFactory methodsFor: 'TusLibros interfaces' stamp: 'FR 12/3/2020 14:41:39'!
tusLibrosInterfaceWithInvalidClientPassword

	^ TusLibrosInterface withAuthenticator: AuthenticatorSimulator invalidClientPassword
			catalog: self aCatalog
			merchantProcessor: MerchantProcessorSimulator successfulValidation
			andClock: Clock new! !


!classDefinition: #TusLibrosInterface category: 'TusLibros'!
Object subclass: #TusLibrosInterface
	instanceVariableNames: 'authenticator catalog merchantProcessor clock currentCartID sessionsByCartID purchases'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInterface methodsFor: 'initialization' stamp: 'FR 12/3/2020 08:31:05'!
initializeWithAuthenticator: anAuthenticator catalog: aCatalog merchantProcessor: aMerchantProcessor andClock: aClock 

	authenticator := anAuthenticator.
	catalog := aCatalog.
	merchantProcessor := aMerchantProcessor.
	clock := aClock.
	
	currentCartID := 0.
	sessionsByCartID := Dictionary new.
	purchases := Bag new.! !


!TusLibrosInterface methodsFor: 'creating' stamp: 'FR 11/30/2020 14:10:16'!
createCartForClientWithID: aClientID andPassword: aPassword

	authenticator authenticateWithID: aClientID andPassword: aPassword.
	
	self createCartFor: aClientID.
	
	^ currentCartID copy! !


!TusLibrosInterface methodsFor: 'listing' stamp: 'FR 12/3/2020 00:37:24'!
listCart: aCartID
	
	self assertCartIDIsValid: aCartID.
	self assertCartHasNotExpired: aCartID.
		
	^ (self sessionWithID: aCartID) list! !

!TusLibrosInterface methodsFor: 'listing' stamp: 'FR 12/3/2020 11:57:23'!
listPurchasesFor: aClientID withPassword: aPassword
	
	authenticator authenticateWithID: aClientID andPassword: aPassword.
	
	^ self purchaseSummaryFor: aClientID! !


!TusLibrosInterface methodsFor: 'private - assertions' stamp: 'FR 12/3/2020 08:30:51'!
assertCartHasNotExpired: aCartID

	(self sessionWithID: aCartID) ifExpired: [
		self retireSession: aCartID.
		self error: self class timeoutErrorDescription
	].! !

!TusLibrosInterface methodsFor: 'private - assertions' stamp: 'FR 12/3/2020 08:31:04'!
assertCartIDIsValid: aCartID

	^ (sessionsByCartID includesKey: aCartID) ifFalse: [ self error: self class invalidCartIDErrorDescription ]! !


!TusLibrosInterface methodsFor: 'adding' stamp: 'FR 12/3/2020 00:37:24'!
add: anAmount of: aBook toCart: aCartID

	self assertCartIDIsValid: aCartID.
	self assertCartHasNotExpired: aCartID.
	
	(self sessionWithID: aCartID) add: anAmount of: aBook.! !


!TusLibrosInterface methodsFor: 'checkout' stamp: 'FR 12/3/2020 09:54:46'!
checkout: aCartID withCreditCard: aCreditCardNumber expiring: anExpirationDate withOwner: anOwnerName 
	
	| clientCreditCard |
	
	self assertCartIDIsValid: aCartID.
	self assertCartHasNotExpired: aCartID.
	
	clientCreditCard := CreditCard ownedBy: anOwnerName
							  withNumber: aCreditCardNumber
							  andExpirationMonthAndYear: anExpirationDate.
	
	self checkout: aCartID withCreditCard: clientCreditCard.	
	self retireSession: aCartID.
	
	^ aCartID! !


!TusLibrosInterface methodsFor: 'accessing' stamp: 'FR 12/3/2020 12:03:21'!
booksBoughtBy: aClientID

	| clientBooks |
	
	clientBooks := Bag new.
	(self purchasesFrom: aClientID) do: [ :aPurchase | clientBooks addAll: aPurchase booksWithQuantities].
	
	^ clientBooks! !

!TusLibrosInterface methodsFor: 'accessing' stamp: 'FR 12/2/2020 15:43:12'!
currentTime

	^ clock now! !

!TusLibrosInterface methodsFor: 'accessing' stamp: 'FR 12/1/2020 22:19:30'!
inactivityTimeLimit

	^ 30*minute! !

!TusLibrosInterface methodsFor: 'accessing' stamp: 'FR 12/3/2020 00:44:24'!
inactivityTimeOf: aCartID

	^ ((self sessionWithID: aCartID) timestamp) distanceTo: clock now! !

!TusLibrosInterface methodsFor: 'accessing' stamp: 'FR 12/2/2020 15:53:52'!
merchantProcessor

	^ merchantProcessor! !

!TusLibrosInterface methodsFor: 'accessing' stamp: 'FR 12/3/2020 12:01:17'!
purchaseSummaryFor: aClientID
	
	| clientTotal clientBooks clientSale clientPurchase |
		
	clientTotal := self totalSpentBy: aClientID.
	clientBooks := self booksBoughtBy: aClientID..
	
	clientSale := Sale withTotal: clientTotal andBooks: clientBooks.
	clientPurchase := Purchase from: aClientID with: clientSale.
	
	^ clientPurchase.! !

!TusLibrosInterface methodsFor: 'accessing' stamp: 'FR 12/3/2020 11:57:50'!
purchasesFrom: aClientID

	^ purchases select: [ :aPurchase | aPurchase wasMadeBy: aClientID ]! !

!TusLibrosInterface methodsFor: 'accessing' stamp: 'FR 12/3/2020 08:31:05'!
sessionWithID: aCartID

	^ (sessionsByCartID at: aCartID)! !

!TusLibrosInterface methodsFor: 'accessing' stamp: 'FR 12/3/2020 11:59:22'!
totalSpentBy: aClientID

	^ (self purchasesFrom: aClientID) inject: 0 into: [ :total :aPurchase | total + aPurchase total ]! !


!TusLibrosInterface methodsFor: 'private - other' stamp: 'FR 12/3/2020 00:40:40'!
checkout: aCartID withCreditCard: aCreditCard

	(self sessionWithID: aCartID) checkoutWithCreditCard: aCreditCard
						     registeringOn: purchases.! !

!TusLibrosInterface methodsFor: 'private - other' stamp: 'FR 12/3/2020 08:31:58'!
createCartFor: aClientID
	
	| cartID |
	
	cartID := self newCartID.
		
	sessionsByCartID at: cartID
				   put: (TusLibrosSession withCart: (Cart acceptingItemsOf: catalog)
								     	  ID: cartID
								    	  clientID: aClientID
								     	  andInterface: self).

! !

!TusLibrosInterface methodsFor: 'private - other' stamp: 'FR 12/3/2020 00:43:29'!
newCartID

	currentCartID := currentCartID + 1.
	^ currentCartID! !

!TusLibrosInterface methodsFor: 'private - other' stamp: 'FR 12/3/2020 08:31:05'!
retireSession: aCartID

	sessionsByCartID removeKey: aCartID.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosInterface class' category: 'TusLibros'!
TusLibrosInterface class
	instanceVariableNames: ''!

!TusLibrosInterface class methodsFor: 'instance creation' stamp: 'FR 12/1/2020 23:13:28'!
withAuthenticator: anAuthenticator catalog: aCatalog merchantProcessor: aMerchantProcessor andClock: aClock  

	^self new initializeWithAuthenticator: anAuthenticator
			catalog: aCatalog
			merchantProcessor: aMerchantProcessor
			andClock: aClock! !


!TusLibrosInterface class methodsFor: 'error descriptions' stamp: 'FR 11/29/2020 22:32:39'!
incorrectPasswordErrorDescription
	
	^ 'Password is incorrect!!'! !

!TusLibrosInterface class methodsFor: 'error descriptions' stamp: 'FR 11/29/2020 22:43:33'!
invalidCartIDErrorDescription
	
	^ 'Cart ID is invalid!!'! !

!TusLibrosInterface class methodsFor: 'error descriptions' stamp: 'FR 11/29/2020 22:26:19'!
invalidClientIDErrorDescription
	
	^ 'Client ID is invalid!!'! !

!TusLibrosInterface class methodsFor: 'error descriptions' stamp: 'FR 12/1/2020 20:27:13'!
timeoutErrorDescription

	^ 'Cart has timed out!!'! !


!classDefinition: #TusLibrosSession category: 'TusLibros'!
Object subclass: #TusLibrosSession
	instanceVariableNames: 'cart cartID clientID timestamp interface'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosSession methodsFor: 'initialization' stamp: 'FR 12/3/2020 00:46:54'!
initializeWithCart: aCart ID: aCartID clientID: aClientID andInterface: anInternalTusLibrosInterface

	cart := aCart.
	cartID := aCartID.
	clientID := aClientID.
	timestamp := anInternalTusLibrosInterface currentTime.
	interface := anInternalTusLibrosInterface.! !


!TusLibrosSession methodsFor: 'timestamp' stamp: 'FR 12/3/2020 00:47:54'!
ifExpired: aBlock

	^ self isExpired ifTrue: aBlock! !

!TusLibrosSession methodsFor: 'timestamp' stamp: 'FR 12/2/2020 17:32:34'!
inactivityTime

	^ timestamp distanceTo: interface currentTime! !

!TusLibrosSession methodsFor: 'timestamp' stamp: 'FR 12/2/2020 17:33:58'!
isExpired

	^ self inactivityTime >= interface inactivityTimeLimit! !

!TusLibrosSession methodsFor: 'timestamp' stamp: 'FR 12/2/2020 15:44:10'!
refreshTimestamp

	timestamp := interface currentTime! !


!TusLibrosSession methodsFor: 'adding' stamp: 'FR 12/2/2020 17:35:48'!
add: anAmount of: aBook

	self refreshTimestamp.
	cart add: anAmount of: aBook.
! !


!TusLibrosSession methodsFor: 'checkout' stamp: 'FR 12/2/2020 16:59:42'!
checkoutWithCreditCard: aCreditCard registeringOn: aPurchaseList
	
	| saleBook |
	
	saleBook := OrderedCollection new.
	
	(Cashier toCheckout: cart
		     charging: aCreditCard
		     throught: interface merchantProcessor
		     on: interface currentTime
		     registeringOn: saleBook) checkOut.
	
	aPurchaseList add: (Purchase from: clientID with: saleBook first )! !


!TusLibrosSession methodsFor: 'listing' stamp: 'FR 12/2/2020 17:35:40'!
list

	self refreshTimestamp.
	^ cart books asBag! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosSession class' category: 'TusLibros'!
TusLibrosSession class
	instanceVariableNames: ''!

!TusLibrosSession class methodsFor: 'instance creation' stamp: 'FR 12/2/2020 15:42:03'!
withCart: aCart ID: aCartID clientID: aClientID andInterface: anInternalTusLibrosInterface

	^ self new initializeWithCart: aCart ID: aCartID clientID: aClientID andInterface: anInternalTusLibrosInterface! !
