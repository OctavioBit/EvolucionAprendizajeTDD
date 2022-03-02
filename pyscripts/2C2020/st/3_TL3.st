!classDefinition: #CartTest category: 'TusLibros-Solucion'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

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


!classDefinition: #CashierTest category: 'TusLibros-Solucion'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

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

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
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


!classDefinition: #CreditCardTest category: 'TusLibros-Solucion'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!CreditCardTest methodsFor: 'tests' stamp: 'DS 11/29/2020 17:54:55'!
assertCreateCreditCardWithNumber: anNumber withOwner: anOwner expiringOn: aMonth shouldRaiseErrorDescription: anErrorDescription 

	self should: [ CreditCard withNumber: anNumber withOwner: anOwner expiringOn: aMonth. ]
		raise: Error
		withMessageText: anErrorDescription.! !

!CreditCardTest methodsFor: 'tests' stamp: 'DS 11/29/2020 17:55:13'!
test01CreditCardNumberShouldHave16Characters

	self
		assertCreateCreditCardWithNumber: '123412341234123'
		withOwner: 'FedeSaba S.A.'
		expiringOn: February, 2021
		shouldRaiseErrorDescription: CreditCard invalidNumberErrorDescription.! !

!CreditCardTest methodsFor: 'tests' stamp: 'DS 11/29/2020 17:55:28'!
test02CreditCardOwnerCanNotBeEmpty

	self 
		assertCreateCreditCardWithNumber: '1234123412341234'
		withOwner:  ''
		expiringOn:  February, 2021
		shouldRaiseErrorDescription: CreditCard invalidOwnerErrorDescription.! !


!classDefinition: #InternalRestInterfaceTest category: 'TusLibros-Solucion'!
TestCase subclass: #InternalRestInterfaceTest
	instanceVariableNames: 'testObjectsFactory debitBehavior clockBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!InternalRestInterfaceTest methodsFor: 'setup' stamp: 'FedericoSabatini 11/30/2020 21:12:28'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.
	
	debitBehavior := [ :anAmount :aCreditCard | ].
	clockBehavior := [ testObjectsFactory now ].! !


!InternalRestInterfaceTest methodsFor: 'merchant processor protocol' stamp: 'DS 11/29/2020 17:35:13'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!InternalRestInterfaceTest methodsFor: 'expiration clock protocol' stamp: 'FedericoSabatini 11/30/2020 20:32:30'!
now
	^clockBehavior value.! !


!InternalRestInterfaceTest methodsFor: 'create' stamp: 'DS 12/2/2020 22:12:42'!
test01CreateCartHaveEmptyList

	| tusLibros sessionCartID |

	tusLibros := testObjectsFactory tusLibros.
	sessionCartID := testObjectsFactory createCartForAnyUser: tusLibros.

	self assert: (Bag new) equals: (tusLibros listCartFor: sessionCartID).! !

!InternalRestInterfaceTest methodsFor: 'create' stamp: 'DS 11/30/2020 22:16:51'!
test02CannotCreateCartWithInvalidPassword

	| tusLibros |

	tusLibros := testObjectsFactory tusLibros.

	self should: [ tusLibros createCartForUser: 1 withPassword: 'bad password'.]
		raise: Error
 		withMessageText: InternalRestInterface badAuthenticationErrorDescription.! !

!InternalRestInterfaceTest methodsFor: 'create' stamp: 'DS 11/30/2020 22:16:51'!
test03CannotCreateCartWithUnknownUser

	| tusLibros |

	tusLibros := testObjectsFactory tusLibros.

	self should: [ tusLibros createCartForUser: 3 withPassword: 'pass'. ]
		raise: Error
		withMessageText: InternalRestInterface badAuthenticationErrorDescription.! !

!InternalRestInterfaceTest methodsFor: 'create' stamp: 'DS 12/2/2020 22:13:42'!
test04CannotAssignSameIDForDifferentCarts

	| tusLibros firstSessionCartID secondSessionCartID |

	tusLibros := testObjectsFactory tusLibros.

	firstSessionCartID := testObjectsFactory createCartForAnyUser: tusLibros.
	secondSessionCartID := testObjectsFactory createCartForAnotherUser: tusLibros.

	self deny: firstSessionCartID = secondSessionCartID.! !


!InternalRestInterfaceTest methodsFor: 'adding' stamp: 'DS 12/2/2020 22:14:58'!
test05AddedItemIsIncludedInCartList

	| tusLibros sessionCartID expectedCartList |

	expectedCartList := Bag new.
	expectedCartList add: testObjectsFactory itemSellByTheStore withOccurrences: 5.

	tusLibros := testObjectsFactory tusLibros.	
	sessionCartID := testObjectsFactory createCartForAnyUser: tusLibros.

	tusLibros addToCart: sessionCartID aQuantity: 5 of: testObjectsFactory itemSellByTheStore.
	self assert: expectedCartList equals: (tusLibros listCartFor: sessionCartID).! !

!InternalRestInterfaceTest methodsFor: 'adding' stamp: 'DS 12/2/2020 22:14:12'!
test06AddedItemsInDifferentsCartsAreInRespectiveLists

	| tusLibros firstSessionCartID secondSessionCartID expectedFirstCart expectedSecondCart |

	expectedFirstCart := Bag new.
	expectedFirstCart add: testObjectsFactory itemSellByTheStore withOccurrences: 5.
	expectedSecondCart := Bag new. 
	expectedSecondCart add: testObjectsFactory itemSellByTheStore withOccurrences: 10.

	tusLibros := testObjectsFactory tusLibros.	
	firstSessionCartID := testObjectsFactory createCartForAnyUser: tusLibros.
	secondSessionCartID := testObjectsFactory createCartForAnotherUser: tusLibros.

	tusLibros addToCart: firstSessionCartID aQuantity: 5 of: testObjectsFactory itemSellByTheStore.
	tusLibros addToCart: secondSessionCartID aQuantity: 10 of: testObjectsFactory itemSellByTheStore.
	
	self assert: expectedFirstCart equals: (tusLibros listCartFor: firstSessionCartID).
	self assert: expectedSecondCart equals: (tusLibros listCartFor: secondSessionCartID).! !

!InternalRestInterfaceTest methodsFor: 'adding' stamp: 'DS 11/30/2020 22:16:51'!
test07CannotAddToUnknownCartID

	| tusLibros |

	tusLibros := testObjectsFactory tusLibros.

	self should: [tusLibros addToCart: 1 aQuantity: 5 of: testObjectsFactory itemSellByTheStore]
		raise: Error
		withMessageText: InternalRestInterface unknownCartIDErrorDescription.! !


!InternalRestInterfaceTest methodsFor: 'checkout' stamp: 'DS 12/2/2020 22:17:02'!
test08CheckoutShouldBeRegisterInSalesBook

	| tusLibros sessionCartID |

	tusLibros := testObjectsFactory tusLibros.
	sessionCartID := testObjectsFactory createCartForAnyUser: tusLibros.
	
	tusLibros addToCart: sessionCartID aQuantity: 10 of: testObjectsFactory itemSellByTheStore.
	self tusLibros: tusLibros checkoutSessionCartID: sessionCartID.

	self assert: 100 equals: (tusLibros salesBook first total).
	self assert: 1 equals: (tusLibros salesBook size).! !

!InternalRestInterfaceTest methodsFor: 'checkout' stamp: 'DS 12/2/2020 22:17:02'!
test09CannotCheckoutWhnCreditCardHasNotCredit

	| tusLibros sessionCartID |

	tusLibros := testObjectsFactory tusLibros.
	sessionCartID := testObjectsFactory createCartForAnyUser: tusLibros.

	tusLibros addToCart: sessionCartID aQuantity: 1 of: testObjectsFactory itemSellByTheStore.

	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	self should: [ self tusLibros: tusLibros checkoutSessionCartID: sessionCartID ]
		raise: Error
		withMessageText: Cashier creditCardHasNoCreditErrorMessage.
		
	self assert: tusLibros salesBook isEmpty.! !

!InternalRestInterfaceTest methodsFor: 'checkout' stamp: 'DS 12/2/2020 22:17:02'!
test10CannotCheckoutToUnknownSessionCartID

	| tusLibros |

	tusLibros := testObjectsFactory tusLibros.

	self should: [ self tusLibros: tusLibros checkoutSessionCartID: 1 ]
		raise: Error
		withMessageText: InternalRestInterface unknownCartIDErrorDescription.
		
	self assert: tusLibros salesBook isEmpty.! !

!InternalRestInterfaceTest methodsFor: 'checkout' stamp: 'DS 12/2/2020 22:16:48'!
test11CannotListAnUnknownSessionCartID

	| tusLibros |

	tusLibros := testObjectsFactory tusLibros.
	self should: [ tusLibros listCartFor: 1 ]
		raise: Error
		withMessageText: InternalRestInterface unknownCartIDErrorDescription .! !

!InternalRestInterfaceTest methodsFor: 'checkout' stamp: 'DS 12/2/2020 22:17:02'!
test12CannotAssignSameIDForDifferentCheckoutTransactions

	| tusLibros firstSessionCartID secondSessionCartID firstTransactionID secondTransactionID |

	tusLibros := testObjectsFactory tusLibros.
	firstSessionCartID := testObjectsFactory createCartForAnyUser: tusLibros.
	secondSessionCartID := testObjectsFactory createCartForAnotherUser: tusLibros.
	
	tusLibros addToCart: firstSessionCartID aQuantity: 10 of: testObjectsFactory itemSellByTheStore.
	tusLibros addToCart: secondSessionCartID aQuantity: 10 of: testObjectsFactory itemSellByTheStore.
	
	firstTransactionID := self tusLibros: tusLibros checkoutSessionCartID: firstSessionCartID.
	secondTransactionID := self tusLibros: tusLibros checkoutSessionCartID: secondSessionCartID.

	self deny: firstTransactionID = secondTransactionID.! !

!InternalRestInterfaceTest methodsFor: 'checkout' stamp: 'DS 12/2/2020 22:17:02'!
tusLibros: aFacadeTusLibros checkoutSessionCartID: aSessionCartID

	^aFacadeTusLibros
		checkOutCart: aSessionCartID
		withCCN: testObjectsFactory creditCardNumber 
		withCCED: testObjectsFactory notExpiredCreditCardDate 
		andCCO: testObjectsFactory creditCardOwner
		throught: self
		on: testObjectsFactory today.! !


!InternalRestInterfaceTest methodsFor: 'expiration tests' stamp: 'DS 12/2/2020 22:17:36'!
assertUpdatedTimeToCartAfter: aTusLibrosBlock

	| tusLibros sessionCartID checkIfExpired updatedTime |

	tusLibros := testObjectsFactory tusLibros: self.
	sessionCartID := testObjectsFactory createCartForAnyUser: tusLibros.
	tusLibros addToCart: sessionCartID aQuantity: 1 of: testObjectsFactory itemSellByTheStore.

	checkIfExpired := false.
	clockBehavior := [
		checkIfExpired
			ifFalse: [
				checkIfExpired := true.
				testObjectsFactory now next: 10*minute.
			] ifTrue: [
				updatedTime :=  testObjectsFactory now next: 5*minute.
				updatedTime.
			].		
	].
	aTusLibrosBlock value: tusLibros value: sessionCartID.

	self assert: (testObjectsFactory now next: 5*minute) equals: updatedTime.! !

!InternalRestInterfaceTest methodsFor: 'expiration tests' stamp: 'DS 12/2/2020 22:18:01'!
shouldRaiseCartTimeExpiredErrorWhen: aTusLibrosBlock

	| tusLibros sessionCartID |
	
	tusLibros := testObjectsFactory tusLibros: self.		
	sessionCartID := testObjectsFactory createCartForAnyUser: tusLibros.
	
	clockBehavior := [ testObjectsFactory now next: 31*minute ].

	self should: [ aTusLibrosBlock value: tusLibros value: sessionCartID ]
		raise: Error
		withMessageText: InternalRestInterface cartTimeExpiredErrorDescription.! !

!InternalRestInterfaceTest methodsFor: 'expiration tests' stamp: 'DS 12/2/2020 22:18:35'!
test12CannotAddOnExpiredCart

	self shouldRaiseCartTimeExpiredErrorWhen: [ :anInternalRestInterface :aSessionCartID | 
		anInternalRestInterface addToCart: aSessionCartID aQuantity: 1 of: testObjectsFactory itemSellByTheStore
	].! !

!InternalRestInterfaceTest methodsFor: 'expiration tests' stamp: 'DS 12/2/2020 22:18:41'!
test13CannotListOnExpiredCart

	self shouldRaiseCartTimeExpiredErrorWhen: [ :anInternalRestInterface :aSessionCartID |
		anInternalRestInterface listCartFor: aSessionCartID
	].! !

!InternalRestInterfaceTest methodsFor: 'expiration tests' stamp: 'DS 12/2/2020 22:18:46'!
test14CannotCheckoutOnExpiredCart

	self shouldRaiseCartTimeExpiredErrorWhen: [ :anInternalRestInterface :aSessionCartID |
		self tusLibros: anInternalRestInterface checkoutSessionCartID: aSessionCartID
	].! !

!InternalRestInterfaceTest methodsFor: 'expiration tests' stamp: 'DS 12/2/2020 22:18:53'!
test15AddAnItemShouldRestartExpirationTime

	self assertUpdatedTimeToCartAfter: [ :anInternalRestInterface :aSessionCartID | 
		anInternalRestInterface addToCart: aSessionCartID aQuantity: 1 of: testObjectsFactory itemSellByTheStore.
	].! !

!InternalRestInterfaceTest methodsFor: 'expiration tests' stamp: 'DS 12/2/2020 22:19:01'!
test16ListCartShouldRestartExpirationTime

	self assertUpdatedTimeToCartAfter: [ :anInternalRestInterface :aSessionCartID | anInternalRestInterface listCartFor: aSessionCartID ].! !

!InternalRestInterfaceTest methodsFor: 'expiration tests' stamp: 'DS 12/2/2020 22:19:07'!
test17CheckoutShouldRestartExpirationTime

	self assertUpdatedTimeToCartAfter: [ :anInternalRestInterface :aSessionCartID | self tusLibros: anInternalRestInterface checkoutSessionCartID: aSessionCartID].! !


!InternalRestInterfaceTest methodsFor: 'list purchases' stamp: 'DS 12/2/2020 21:45:38'!
test18ListPurchasesShouldReturnZeroWithNewUser

	| tusLibros expectedPurchases  |

	expectedPurchases := Dictionary with: ('total' -> 0).
	tusLibros := testObjectsFactory tusLibros.
	
	self assert: expectedPurchases equals: (tusLibros listPurchasesWithUser: 1 withPassword: 'pass').! !

!InternalRestInterfaceTest methodsFor: 'list purchases' stamp: 'DS 12/2/2020 22:19:35'!
test19ListPurchasesShouldIncludeItemsAndTotalAfterCheckout

	| tusLibros expectedPurchases sessionCartID |

	expectedPurchases := Dictionary 
		with: (testObjectsFactory itemSellByTheStore -> 1)
		with: 'total' -> testObjectsFactory itemSellByTheStorePrice.
		
	tusLibros := testObjectsFactory tusLibros.
	sessionCartID := testObjectsFactory createCartForAnyUser: tusLibros.
	
	tusLibros addToCart: sessionCartID aQuantity: 1 of: testObjectsFactory itemSellByTheStore.
	self tusLibros: tusLibros checkoutSessionCartID: sessionCartID.
	
	self assert: expectedPurchases equals: (tusLibros listPurchasesWithUser: 1 withPassword: 'pass').! !

!InternalRestInterfaceTest methodsFor: 'list purchases' stamp: 'DS 12/2/2020 22:20:18'!
test20ListPurchasesShouldIncludeItemsAndTotalAfterMultipleCheckout

	| tusLibros expectedPurchases firstSessionCartID secondSessionCartID |

	expectedPurchases := Dictionary 
		with: (testObjectsFactory itemSellByTheStore -> 8)
		with: 'total' -> (testObjectsFactory itemSellByTheStorePrice * 8).
	
	tusLibros := testObjectsFactory tusLibros.
	firstSessionCartID := testObjectsFactory createCartForAnyUser: tusLibros.
	secondSessionCartID := testObjectsFactory createCartForAnyUser: tusLibros.
	
	tusLibros addToCart: firstSessionCartID aQuantity: 5 of: testObjectsFactory itemSellByTheStore.
	tusLibros addToCart: secondSessionCartID aQuantity: 3 of: testObjectsFactory itemSellByTheStore.
	self tusLibros: tusLibros checkoutSessionCartID: firstSessionCartID.
	self tusLibros: tusLibros checkoutSessionCartID: secondSessionCartID.

	self assert: expectedPurchases equals: (tusLibros listPurchasesWithUser: 1 withPassword: 'pass').! !

!InternalRestInterfaceTest methodsFor: 'list purchases' stamp: 'FedericoSabatini 12/2/2020 16:58:13'!
test21CannotListPurchasesWithUnknownUser

	| tusLibros |

	tusLibros := testObjectsFactory tusLibros.

	self should: [ tusLibros listPurchasesWithUser: 3 withPassword: 'pass'. ]
		raise: Error
		withMessageText: InternalRestInterface badAuthenticationErrorDescription.! !


!classDefinition: #Cart category: 'TusLibros-Solucion'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

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


!Cart methodsFor: 'total' stamp: 'DS 12/2/2020 21:16:40'!
total
	
	^ items sum: [ :anItem | catalog at: anItem ].! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'accesing' stamp: 'FedericoSabatini 12/1/2020 18:19:05'!
items
	
	^items asBag.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros-Solucion'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros-Solucion'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

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

!classDefinition: 'Cashier class' category: 'TusLibros-Solucion'!
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


!classDefinition: #CreditCard category: 'TusLibros-Solucion'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'DS 11/29/2020 17:53:42'!
initializeWithNumber: aCreditCardNumber withOwner: anOwner expiringOn: aMonth

	number := aCreditCardNumber.
	expiration := aMonth.
	owner := anOwner.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros-Solucion'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'error descriptions' stamp: 'DS 11/29/2020 17:51:53'!
invalidExpirationDateErrorDescription

    ^'Invalid format of Expiration Date'.! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'DS 11/29/2020 17:51:58'!
invalidNumberErrorDescription

    ^'Invalid number of credit card'.! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'DS 11/29/2020 17:52:04'!
invalidOwnerErrorDescription

    ^'Owner can not be empty'.! !


!CreditCard class methodsFor: 'assertions' stamp: 'DS 11/29/2020 17:51:05'!
assertValidCreditCardNumber: aCreditCardNumber

	^(aCreditCardNumber size = 16) ifFalse: [ self error: self invalidNumberErrorDescription ].! !

!CreditCard class methodsFor: 'assertions' stamp: 'DS 11/29/2020 17:51:28'!
assertValidOwner: anOwner

	^anOwner ifEmpty: [ self error: self invalidOwnerErrorDescription ].! !


!CreditCard class methodsFor: 'instance creation' stamp: 'DS 11/29/2020 17:53:28'!
withNumber: aNumber withOwner: anOwner expiringOn: aMonth

    self assertValidCreditCardNumber: aNumber.
    self assertValidOwner: anOwner.

    ^self new initializeWithNumber: aNumber withOwner: anOwner expiringOn: aMonth.! !


!classDefinition: #InternalRestInterface category: 'TusLibros-Solucion'!
Object subclass: #InternalRestInterface
	instanceVariableNames: 'authenticator sessionCarts currentID catalog salesBook expiringTime clock purchasesByUser'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!InternalRestInterface methodsFor: 'initialization' stamp: 'DS 12/2/2020 20:43:06'!
initializeWithAuthenticator: anAuthenticator withCatalog: aCatalog usingClock: aClock 
	
	authenticator := anAuthenticator.
	catalog := aCatalog.
	
	clock := aClock.
	
	sessionCarts := Dictionary new.
	currentID := self initialAvailableID.
	salesBook := OrderedCollection new.
	
	purchasesByUser := Dictionary new. ! !


!InternalRestInterface methodsFor: 'api rest' stamp: 'DS 12/2/2020 21:54:10'!
addToCart: aSessionCartID aQuantity: aQuantity of: anItem
	
	| aSessionCart |

	aSessionCart := self sessionCartWith: aSessionCartID.
	aSessionCart add: aQuantity of: anItem.! !

!InternalRestInterface methodsFor: 'api rest' stamp: 'DS 12/2/2020 21:58:55'!
checkOutCart: aSessionCartID withCCN: anCCN withCCED: anCCED andCCO: anCCO throught: aMerchantProccesor on: aDate

	| creditCard aSessionCart purchases cashier |

	aSessionCart := self sessionCartWith: aSessionCartID.

	creditCard := CreditCard withNumber: anCCN withOwner: anCCO expiringOn: anCCED.

	cashier := Cashier
				toCheckout: aSessionCart cart 
				charging: creditCard
				throught: aMerchantProccesor
				on: aDate
				registeringOn: salesBook.
	cashier checkOut.

	purchases := self purchsesOfUser: aSessionCart userID.
	aSessionCart registeringOn: purchases.
	
	^aSessionCartID.! !

!InternalRestInterface methodsFor: 'api rest' stamp: 'DS 12/2/2020 20:46:34'!
createCartForUser: aUserID withPassword: aPassword 

	| cart aSessionCartID |

	self assertAuthenticate: aUserID withPassword: aPassword.

	cart := Cart acceptingItemsOf: catalog.
	aSessionCartID := self nextAvailableID.

	sessionCarts at: aSessionCartID
		put: (SessionCart for: cart withUser: aUserID using: clock).

	^aSessionCartID.! !

!InternalRestInterface methodsFor: 'api rest' stamp: 'DS 12/2/2020 21:53:39'!
listCartFor: aSessionCartID

	| aSessionCart |

	aSessionCart := self sessionCartWith: aSessionCartID.

	^aSessionCart items.! !

!InternalRestInterface methodsFor: 'api rest' stamp: 'DS 12/2/2020 21:44:32'!
listPurchasesWithUser: userID withPassword: aPassword

	| items purchases |

	self assertAuthenticate: userID withPassword: aPassword.

	purchases := purchasesByUser at: userID ifAbsent: [ OrderedCollection new ].

	items := self groupPurchasesByItem: purchases.
	items add: 'total' -> (purchases sum: [ :aCart | aCart total ] ifEmpty: [ 0 ]).

	^items.! !


!InternalRestInterface methodsFor: 'id management' stamp: 'DS 12/2/2020 20:29:35'!
initialAvailableID

	^1.! !

!InternalRestInterface methodsFor: 'id management' stamp: 'DS 12/2/2020 20:12:07'!
nextAvailableID

	| id |

	id := currentID.
	currentID := currentID + 1.

	^id.! !


!InternalRestInterface methodsFor: 'errors' stamp: 'DS 11/29/2020 18:52:50'!
signalBadAuthentication

	^ self error: self class badAuthenticationErrorDescription! !

!InternalRestInterface methodsFor: 'errors' stamp: 'DS 11/29/2020 18:21:02'!
signalUnknownCartID

	^ self error: self class unknownCartIDErrorDescription! !


!InternalRestInterface methodsFor: 'assertions' stamp: 'DS 12/2/2020 22:09:08'!
assertAuthenticate: aUserID withPassword: aPassword

	(authenticator login: aUserID using: aPassword) ifFalse: [ self signalBadAuthentication ].! !


!InternalRestInterface methodsFor: 'private' stamp: 'DS 12/2/2020 21:43:40'!
groupPurchasesByItem: aPurchasesCollection

	^(aPurchasesCollection
		inject: Bag new
		into: [ :currentBag :aCart | 
				currentBag addAll: aCart items.
				currentBag.
		]
	 ) contents.! !

!InternalRestInterface methodsFor: 'private' stamp: 'DS 12/2/2020 20:38:11'!
purchsesOfUser: aUserID

	^purchasesByUser
		at: aUserID 
		ifAbsent: 	[ purchasesByUser at: aUserID put: OrderedCollection new ].! !

!InternalRestInterface methodsFor: 'private' stamp: 'DS 12/2/2020 20:43:06'!
sessionCartWith: aCartID

	| sessionCart |

	sessionCart := sessionCarts at: aCartID ifAbsent: [ self signalUnknownCartID ].	
	sessionCart allowContinueWithSession.

	^sessionCart.! !


!InternalRestInterface methodsFor: 'accessing' stamp: 'DS 11/29/2020 19:08:20'!
salesBook

	^salesBook.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InternalRestInterface class' category: 'TusLibros-Solucion'!
InternalRestInterface class
	instanceVariableNames: ''!

!InternalRestInterface class methodsFor: 'instance creation' stamp: 'FedericoSabatini 11/30/2020 20:34:34'!
withAuthenticator: anAuthenticator withCatalog: aCatalog usingClock: aClock
	^self new initializeWithAuthenticator: anAuthenticator withCatalog: aCatalog usingClock: aClock.! !


!InternalRestInterface class methodsFor: 'error descriptions' stamp: 'FedericoSabatini 11/29/2020 15:39:11'!
badAuthenticationErrorDescription

    ^'Dont exist an user with this password'.! !

!InternalRestInterface class methodsFor: 'error descriptions' stamp: 'DS 11/30/2020 18:24:49'!
cartTimeExpiredErrorDescription

	^'Your cart has expired'.! !

!InternalRestInterface class methodsFor: 'error descriptions' stamp: 'DS 11/29/2020 18:18:17'!
unknownCartIDErrorDescription
	^ 'Unknowed cart ID'.! !


!classDefinition: #Sale category: 'TusLibros-Solucion'!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros-Solucion'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #SessionCart category: 'TusLibros-Solucion'!
Object subclass: #SessionCart
	instanceVariableNames: 'cart expiringTimestamp userID clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

!SessionCart methodsFor: 'initialization' stamp: 'DS 12/2/2020 20:22:25'!
initializeFor: aCart withUser: anUserID using: aClock

	cart := aCart.
	userID := anUserID.
	clock := aClock.
	self refreshSession.! !


!SessionCart methodsFor: 'accesing' stamp: 'DS 11/30/2020 19:24:06'!
cart

	^cart.! !

!SessionCart methodsFor: 'accesing' stamp: 'DS 12/2/2020 21:17:52'!
userID

	^userID ! !


!SessionCart methodsFor: 'session' stamp: 'DS 12/2/2020 20:22:06'!
allowContinueWithSession

	self assertSessionExpired.
	self refreshSession.! !

!SessionCart methodsFor: 'session' stamp: 'DS 12/2/2020 20:22:11'!
refreshSession

	expiringTimestamp :=	clock now next: 30*minute.! !


!SessionCart methodsFor: 'assertions' stamp: 'DS 12/2/2020 20:17:47'!
assertSessionExpired

	^ (expiringTimestamp < clock now) ifTrue: [ self signalCartTimeExpired ].! !


!SessionCart methodsFor: 'errors' stamp: 'DS 12/2/2020 20:48:29'!
signalCartTimeExpired

	^self error: InternalRestInterface cartTimeExpiredErrorDescription.! !


!SessionCart methodsFor: 'checkout' stamp: 'DS 12/2/2020 21:59:31'!
registeringOn: aPurchaseCollection

	aPurchaseCollection addLast: cart.! !


!SessionCart methodsFor: 'cart actions' stamp: 'DS 12/2/2020 21:55:09'!
add: aQuantity of: anItem

	cart add: aQuantity of: anItem.! !

!SessionCart methodsFor: 'cart actions' stamp: 'DS 12/2/2020 21:55:16'!
items

	^cart items.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SessionCart class' category: 'TusLibros-Solucion'!
SessionCart class
	instanceVariableNames: ''!

!SessionCart class methodsFor: 'instance creation' stamp: 'DS 12/2/2020 20:07:03'!
for: aCart withUser: anUserID using: aClock

	^self new initializeFor: aCart withUser: anUserID using: aClock.! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros-Solucion'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today debitBehavior gregorianDateTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solucion'!

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


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'DS 11/29/2020 18:11:52'!
creditCardNumber

	^'1234123412341234'.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'DS 11/29/2020 18:11:45'!
creditCardOwner

	^'an buisines S.A.'.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'DS 11/29/2020 18:12:09'!
expiredCreditCard
	
	^CreditCard 
		withNumber: self creditCardNumber 
		withOwner: self creditCardOwner 
		expiringOn: self expiredCreditCardDate! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'DS 11/29/2020 18:05:26'!
expiredCreditCardDate
	
	^Month month: today monthIndex year: today yearNumber - 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'DS 11/29/2020 18:12:21'!
notExpiredCreditCard
	
	^CreditCard 
		withNumber: self creditCardNumber 
		withOwner: self creditCardOwner 
		expiringOn: self notExpiredCreditCardDate.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'DS 11/29/2020 18:07:07'!
notExpiredCreditCardDate
	
	^Month month: today monthIndex year: today yearNumber + 1.! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'FedericoSabatini 11/30/2020 20:46:25'!
initialize

	today := DateAndTime now.
	gregorianDateTime := GregorianDateTime date: FixedGregorianDate today timeOfDay: TimeOfDay now.! !


!StoreTestObjectsFactory methodsFor: 'session carts' stamp: 'DS 12/2/2020 22:11:56'!
createCartForAnotherUser: tusLibros

	^tusLibros createCartForUser: 2 withPassword: 'pass'.! !

!StoreTestObjectsFactory methodsFor: 'session carts' stamp: 'DS 12/2/2020 22:11:48'!
createCartForAnyUser: tusLibros

	^tusLibros createCartForUser: 1 withPassword: 'pass'.! !


!StoreTestObjectsFactory methodsFor: 'tusLibros' stamp: 'DS 12/2/2020 22:07:53'!
login: aUserID using: aPassword

	| realPassword |

	realPassword := self users at: aUserID ifAbsent: [ ^false ].

	^realPassword = aPassword.! !

!StoreTestObjectsFactory methodsFor: 'tusLibros' stamp: 'DS 12/2/2020 22:07:19'!
tusLibros

	^InternalRestInterface 
		withAuthenticator: self
		withCatalog: self defaultCatalog
		usingClock: self.! !

!StoreTestObjectsFactory methodsFor: 'tusLibros' stamp: 'DS 12/2/2020 22:07:23'!
tusLibros: aClock

	^InternalRestInterface 
		withAuthenticator: self
		withCatalog: self defaultCatalog
		usingClock: aClock.! !

!StoreTestObjectsFactory methodsFor: 'tusLibros' stamp: 'DS 12/2/2020 22:07:46'!
users

	^Dictionary with: 1 -> 'pass' with: 2 -> 'pass'.! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'FedericoSabatini 11/30/2020 20:59:02'!
now
	
	^gregorianDateTime! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
