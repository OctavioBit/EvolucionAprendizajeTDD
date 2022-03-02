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


!classDefinition: #InnerUserInterfaceTest category: 'TusLibros'!
TestCase subclass: #InnerUserInterfaceTest
	instanceVariableNames: 'credentialValidatorValid credentialValidatorInvalid testObjectsFactory debitBehavior after30Minutes'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InnerUserInterfaceTest methodsFor: 'testing' stamp: 'ENC 6/24/2021 02:43:28'!
test01cannotCreateACartWithInvalidCredentials

	| interface |

	interface := testObjectsFactory interfaceForInvalidCredentialsWith: self.
	
	self shouldRaiseInvalidCredentialsErrorWhile: [ testObjectsFactory createCartWithInvalidCredentialsFor: interface ] ! !

!InnerUserInterfaceTest methodsFor: 'testing' stamp: 'ENC 6/24/2021 02:16:32'!
test02createdCartWithValidCredentialsIsEmpty

	| interface cartID |

	interface := testObjectsFactory interfaceForValidCredentialsWith: self.
	cartID := testObjectsFactory createCartWithValidCredentialsFor: interface.
	
	self assert: (testObjectsFactory listCart: cartID for: interface) isEmpty.! !

!InnerUserInterfaceTest methodsFor: 'testing' stamp: 'ENC 6/24/2021 02:27:26'!
test03addingAnItemInCartIsListed

	| interface cartID |

	interface := testObjectsFactory interfaceForValidCredentialsWith: self.
	cartID := testObjectsFactory cartWithAValidItemFor: interface.
	
	self assert: (testObjectsFactory listCart: cartID for: interface) size equals: 1.
	self assert: (testObjectsFactory listCart: cartID for: interface) includes: testObjectsFactory itemSellByTheStore.
	! !

!InnerUserInterfaceTest methodsFor: 'testing' stamp: 'ENC 6/24/2021 02:41:28'!
test04cannotAddItemsToInvalidCart

	| interface |
	
	interface := testObjectsFactory interfaceForValidCredentialsWith: self.
	
	self shouldRaiseInvalidCartIDErrorWhile: [ testObjectsFactory addValidItemToCart: 1 for: interface ]! !

!InnerUserInterfaceTest methodsFor: 'testing' stamp: 'ENC 6/24/2021 02:41:41'!
test05cannotListItemsOfInvalidCart

	| interface |

	interface := testObjectsFactory interfaceForValidCredentialsWith: self.
	
	self shouldRaiseInvalidCartIDErrorWhile: [ testObjectsFactory listCart: 1 for: interface ]! !

!InnerUserInterfaceTest methodsFor: 'testing' stamp: 'ENC 6/24/2021 02:42:00'!
test06cannotAddItemsToExpiredCart

	| interface cartID |

	interface := testObjectsFactory interfaceForValidCredentialsWith: self.
	cartID := testObjectsFactory createCartWithValidCredentialsFor: interface.
	
	self shouldRaiseInvalidCartIDErrorWhile: [ interface add: 1 of: testObjectsFactory itemSellByTheStore toCart: cartID at: after30Minutes. ]! !

!InnerUserInterfaceTest methodsFor: 'testing' stamp: 'ENC 6/24/2021 02:42:12'!
test07cannotListItemsOfExpiredCart

	| interface cartID |
	
	interface := testObjectsFactory interfaceForValidCredentialsWith: self.
	cartID := testObjectsFactory createCartWithValidCredentialsFor: interface.
	
	self shouldRaiseInvalidCartIDErrorWhile: [ testObjectsFactory listExpiredCart: cartID for: interface ]
	! !

!InnerUserInterfaceTest methodsFor: 'testing' stamp: 'ENC 6/24/2021 02:44:36'!
test08cannotCheckoutACartWithInvalidCard

	| interface cartID |

	interface := testObjectsFactory interfaceForValidCredentialsWith: self.
	cartID := testObjectsFactory createCartWithValidCredentialsFor: interface.
	
	self shouldRaiseInvalidCreditCardErrorWhile: [ testObjectsFactory checkoutWithInvalidCard: cartID for: interface ]
	! !

!InnerUserInterfaceTest methodsFor: 'testing' stamp: 'ENC 6/24/2021 02:42:32'!
test09cannotCheckoutAnInvalidCart

	| interface |
	
	interface := testObjectsFactory interfaceForValidCredentialsWith: self.
	
	self shouldRaiseInvalidCartIDErrorWhile: [ testObjectsFactory checkoutWithValidCard: 1 for: interface ]! !

!InnerUserInterfaceTest methodsFor: 'testing' stamp: 'ENC 6/24/2021 02:30:10'!
test10listPurchasesOfUserWithNoSalesIsEmpty

	| interface listOfPurchases |
	
	interface := testObjectsFactory interfaceForValidCredentialsWith: self.
	listOfPurchases := testObjectsFactory listPurchasesOfValidUserFor: interface.

	self assert: listOfPurchases first isEmpty.	
	self assert: listOfPurchases second equals: 0.	! !

!InnerUserInterfaceTest methodsFor: 'testing' stamp: 'ENC 6/24/2021 02:39:00'!
test11checkoutACartIsListedInPurchases

	| interface transactionID listOfPurchases |
	
	interface := testObjectsFactory interfaceForValidCredentialsWith: self.
	transactionID := testObjectsFactory checkoutCartWithValidCardfor: interface.
	
	self assert: transactionID > 0.
	
	listOfPurchases := testObjectsFactory listPurchasesOfValidUserFor: interface.
	
	self assert: listOfPurchases first includes: testObjectsFactory itemSellByTheStore.
	self assert: listOfPurchases second equals: testObjectsFactory itemSellByTheStorePrice.
	! !

!InnerUserInterfaceTest methodsFor: 'testing' stamp: 'ENC 6/24/2021 02:43:46'!
test12cannotlistPurchasesWithInvalidCredentials

	| interface |
	
	interface := testObjectsFactory interfaceForInvalidCredentialsWith: self.

	self shouldRaiseInvalidCredentialsErrorWhile: [ interface listPurchasesOf: testObjectsFactory invalidUser withPassword: testObjectsFactory validUserPassword ]! !

!InnerUserInterfaceTest methodsFor: 'testing' stamp: 'ENC 6/24/2021 02:38:03'!
test13checkoutMoreThanOneCartGetDifferentTransactionIDs

	| interface transactionIdA transactionIdB |
	
	interface := testObjectsFactory interfaceForValidCredentialsWith: self.
	transactionIdA := testObjectsFactory checkoutCartWithValidCardfor: interface.
	transactionIdB := testObjectsFactory checkoutCartWithValidCardfor: interface.
	
	self deny: transactionIdA = transactionIdB 
	! !


!InnerUserInterfaceTest methodsFor: 'setup' stamp: 'ENC 6/24/2021 01:49:14'!
setUp
	| debitedAmout debitedCreditCard | 
	
	credentialValidatorValid := CredentialValidatorSimulatorValidCredentials new.
	credentialValidatorInvalid := CredentialValidatorSimulatorInvalidCredentials new.
	testObjectsFactory := StoreTestObjectsFactory new.
	
	after30Minutes := testObjectsFactory dateTimeTodayAfter30Minutes.
	
	debitBehavior := [ :anAmount :aCreditCard | 		debitedAmout := anAmount. 		debitedCreditCard := aCreditCard ].! !


!InnerUserInterfaceTest methodsFor: 'merchant processor protocol' stamp: 'ENC 6/24/2021 01:22:31'!
debit: anAmount from: aCreditCard 

	^ debitBehavior value: anAmount value: aCreditCard ! !


!InnerUserInterfaceTest methodsFor: 'testing - private' stamp: 'ENC 6/24/2021 02:40:57'!
shouldRaiseInvalidCartIDErrorWhile: aBlock

	self
		should: aBlock 
		raise: Error
		withMessageText: InnerUserInterface invalidCartId.! !

!InnerUserInterfaceTest methodsFor: 'testing - private' stamp: 'ENC 6/24/2021 02:43:13'!
shouldRaiseInvalidCredentialsErrorWhile: aBlock

	self
		should: aBlock 
		raise: Error
		withMessageText: CredentialValidatorSimulator errorInvalidUsernameOrPassword.! !

!InnerUserInterfaceTest methodsFor: 'testing - private' stamp: 'ENC 6/24/2021 02:44:22'!
shouldRaiseInvalidCreditCardErrorWhile: aBlock

	self
		should: aBlock 
		raise: Error
		withMessageText: CreditCard invalidCreditCard.! !


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


!Cart methodsFor: 'queries' stamp: 'MS 6/19/2021 23:29:10'!
listItems
	^items copy.! !

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

!Cashier methodsFor: 'checkout - private' stamp: 'MS 6/23/2021 02:14:21'!
createSale

	^ Sale of: total for: cart listItems.
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


!classDefinition: #CredentialValidatorSimulator category: 'TusLibros'!
Object subclass: #CredentialValidatorSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CredentialValidatorSimulator methodsFor: 'log' stamp: 'ENC 6/17/2021 21:15:51'!
logWith: aUsername and: aPassword

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CredentialValidatorSimulator class' category: 'TusLibros'!
CredentialValidatorSimulator class
	instanceVariableNames: ''!

!CredentialValidatorSimulator class methodsFor: 'error description' stamp: 'ENC 6/17/2021 21:18:49'!
errorInvalidUsernameOrPassword

	^ 'El usuario o contraseña ingresados son inválidos'! !


!classDefinition: #CredentialValidatorSimulatorInvalidCredentials category: 'TusLibros'!
CredentialValidatorSimulator subclass: #CredentialValidatorSimulatorInvalidCredentials
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CredentialValidatorSimulatorInvalidCredentials methodsFor: 'log' stamp: 'ENC 6/17/2021 21:17:30'!
logWith: aUsername and: aPassword

	self error: self class errorInvalidUsernameOrPassword ! !


!classDefinition: #CredentialValidatorSimulatorValidCredentials category: 'TusLibros'!
CredentialValidatorSimulator subclass: #CredentialValidatorSimulatorValidCredentials
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CredentialValidatorSimulatorValidCredentials methodsFor: 'log' stamp: 'ENC 6/17/2021 21:19:45'!
logWith: aUsername and: aPassword

	! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'ENC 6/24/2021 01:21:32'!
isExpiredOn: aDate 
	
	^ expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'signaling' stamp: 'MS 6/23/2021 00:49:18'!
signalInvalidCreditCard

	^ self error: self class invalidCreditCard.! !


!CreditCard methodsFor: 'initialization' stamp: 'ENC 6/24/2021 01:20:38'!
initializeWith: aCardNumber from: anOwnerName expiringOn: anExpirationDate

	(anOwnerName withBlanksTrimmed isEmpty) ifTrue: [ self signalInvalidCreditCard ].
	((aCardNumber numberOfDigitsInBase: 10) = 16) ifFalse: [ self signalInvalidCreditCard ].
	(anExpirationDate size = 6) ifFalse: [ self signalInvalidCreditCard ].

	owner := anOwnerName.
	number := aCardNumber.
	expiration := Month month: ((anExpirationDate first: 2) asNumber) year: ((anExpirationDate last: 4) asNumber).
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'error' stamp: 'MS 6/23/2021 00:37:06'!
invalidCreditCard
	^ 'No se puede comprar con una tarjeta inválida.'! !


!CreditCard class methodsFor: 'instance creation' stamp: 'MS 6/23/2021 01:03:16'!
number: aCardNumber from: anOwnerName expiringOn: anExpirationDate 
	
	^self new initializeWith: aCardNumber from: anOwnerName expiringOn: anExpirationDate.! !


!classDefinition: #InnerUserInterface category: 'TusLibros'!
Object subclass: #InnerUserInterface
	instanceVariableNames: 'credentialValidator carts merchantProcessor salesBooks catalog lastCartId lastTransactionId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InnerUserInterface methodsFor: 'checkout' stamp: 'ENC 6/24/2021 11:17:11'!
checkout: aCartID at: aTime withCard: aCardNumber from: aCardOwner expiringOn: aDate
	
	| creditCard salesBook userID cart cashier |
	
	creditCard := CreditCard number: aCardNumber from: aCardOwner expiringOn: aDate.
	
	self assertCartID: aCartID isValidAt: aTime.
	self updateLasTimeUsedFor: aCartID with: aTime.
	
	cart := self cartOf: aCartID.
	userID := self userIdOf: aCartID.
	
	salesBook := salesBooks at: userID ifAbsent: [salesBooks at: userID put: OrderedCollection new].
	
	cashier := Cashier toCheckout: cart charging: creditCard throught: merchantProcessor on: aTime registeringOn: salesBook.
	
	cashier checkOut.
	
	^ self generateTransactionID.! !

!InnerUserInterface methodsFor: 'checkout' stamp: 'MS 6/23/2021 23:30:58'!
listPurchasesOf: anUserID withPassword: anUserPassword

	| sales purchases total |
	
	credentialValidator logWith: anUserID and: anUserPassword.
	
	sales := salesBooks at: anUserID ifAbsent: [OrderedCollection new].
	
	purchases := sales inject: OrderedCollection new addingAll: [ :aSale | aSale purchase].
	total := sales inject: 0 into: [ :totalAmount :aSale | totalAmount + aSale total].
	
	^ OrderedCollection with: purchases with: total.! !


!InnerUserInterface methodsFor: 'private' stamp: 'ENC 6/24/2021 02:45:23'!
cartOf: aCartID

	^ (carts at: aCartID) at: 1.! !

!InnerUserInterface methodsFor: 'private' stamp: 'ENC 6/24/2021 02:45:16'!
lastTimeUsedOf: aCartID

	^ (carts at: aCartID) at: 2.! !

!InnerUserInterface methodsFor: 'private' stamp: 'ENC 6/24/2021 02:45:08'!
userIdOf: aCartID

	^ (carts at: aCartID) at: 3.! !


!InnerUserInterface methodsFor: 'cart' stamp: 'ENC 6/24/2021 11:16:28'!
add: amountOfItems of: item toCart: aCartID at: aTime
	
	| cart |
	
	self assertCartID: aCartID isValidAt: aTime.
	self updateLasTimeUsedFor: aCartID with: aTime.
	
	cart := self cartOf: aCartID.
	cart add: amountOfItems of: item.
	
	
	! !

!InnerUserInterface methodsFor: 'cart' stamp: 'ENC 6/24/2021 11:16:05'!
createCartForUser: userID withPassword: userPassword at: aTime

	| cart cartID |
	
	credentialValidator logWith: userID and: userPassword.
	
	cart := Cart acceptingItemsOf: catalog.
	
	cartID := self generateCartID.
	
	carts at: cartID put: (OrderedCollection with: cart with: aTime with: userID).
	
	^ cartID
	
	! !

!InnerUserInterface methodsFor: 'cart' stamp: 'ENC 6/24/2021 11:15:55'!
listCart: aCartID at: aTime
		
	self assertCartID: aCartID isValidAt: aTime.
	self updateLasTimeUsedFor: aCartID with: aTime.
	
	^ (self cartOf: aCartID) listItems.! !

!InnerUserInterface methodsFor: 'cart' stamp: 'ENC 6/24/2021 11:15:07'!
updateLasTimeUsedFor: aCartID with: aTime
		
	(carts at: aCartID) at: 2 put: aTime.
	
	
	! !


!InnerUserInterface methodsFor: 'initialization' stamp: 'ENC 6/24/2021 11:12:24'!
initializeWith: aCredentialValidator acceptingItemsOf: aCatalog throughtMP: aMerchantProcessor.

	credentialValidator := aCredentialValidator.
	catalog := aCatalog.
	merchantProcessor  := aMerchantProcessor.
	
	carts := Dictionary new.
	salesBooks := Dictionary new.
	
	lastCartId := 0.
	lastTransactionId := 0.! !


!InnerUserInterface methodsFor: 'signaling' stamp: 'ENC 6/24/2021 11:12:31'!
signalInvalidCartId

	^ self error: self class invalidCartId.! !


!InnerUserInterface methodsFor: 'id generation' stamp: 'ENC 6/24/2021 11:12:50'!
generateCartID

	lastCartId := lastCartId + 1.
	
	^ lastCartId.! !

!InnerUserInterface methodsFor: 'id generation' stamp: 'ENC 6/24/2021 11:13:01'!
generateTransactionID

	lastTransactionId := lastTransactionId + 1.
	
	^ lastTransactionId.! !


!InnerUserInterface methodsFor: 'asserting' stamp: 'MS 6/23/2021 23:05:38'!
assertCartID: aCartID isValidAt: aTime

	(carts includesKey: aCartID) ifFalse: [^ self signalInvalidCartId ].
	(self assertCartIsTimedOut: (self lastTimeUsedOf: aCartID) at: aTime) ifTrue: [^ self signalInvalidCartId ].
	
	! !

!InnerUserInterface methodsFor: 'asserting' stamp: 'MS 6/22/2021 23:59:24'!
assertCartIsTimedOut: aCartTime at: aTime

	^ (aTime - aCartTime) totalMinutes > 30! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InnerUserInterface class' category: 'TusLibros'!
InnerUserInterface class
	instanceVariableNames: ''!

!InnerUserInterface class methodsFor: 'instance creation' stamp: 'MS 6/23/2021 23:10:05'!
with: aCredentialValidator acceptingItemsOf: aCatalog throughtMP: aMerchantProcessor

	^ self new initializeWith: aCredentialValidator acceptingItemsOf: aCatalog throughtMP: aMerchantProcessor .! !


!InnerUserInterface class methodsFor: 'error description' stamp: 'MS 6/19/2021 23:38:43'!
invalidCartId
	^ 'El Id no corresponde a un carrito válido.'! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'purchase' stamp: 'ENC 6/24/2021 01:19:02'!
purchase

	^ items! !


!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'ENC 6/24/2021 01:19:11'!
initializeTotal: aTotal for: aListOfItems

	total := aTotal.
	items := aListOfItems.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'ENC 6/24/2021 01:20:18'!
of: aTotal for: aListOfItems

	"should assert total is not negative or 0!!"
	^ self new initializeTotal: aTotal for: aListOfItems.! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'ENC 6/24/2021 01:19:36'!
itemNotSellByTheStore
	
	^ 'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'ENC 6/24/2021 01:19:31'!
itemSellByTheStorePrice
	
	^ 10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'ENC 6/24/2021 01:19:26'!
createCart
	
	^ Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ENC 6/24/2021 00:44:01'!
createCardExpiredOn: aMonthInString

	^ CreditCard number: 1234567812345678 from: 'anOwner' expiringOn: aMonthInString ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ENC 6/24/2021 00:43:30'!
expiredCreditCard
	
	^ self createCardExpiredOn: self todayExpiredMonthAsString.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ENC 6/24/2021 00:43:45'!
notExpiredCreditCard
	
	^ self createCardExpiredOn: self todayMonthAsString.! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'ENC 6/24/2021 01:15:53'!
dateTimeAtMinute: aMinute
	
	^ DateAndTime date: today time: (Time hour: 19 minute: aMinute second: 00).! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'ENC 6/24/2021 01:16:07'!
dateTimeToday
	
	^ self dateTimeAtMinute: 0.! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'ENC 6/24/2021 01:16:17'!
dateTimeTodayAfter30Minutes
	
	^ self dateTimeAtMinute: 31.! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'ENC 6/24/2021 01:17:32'!
monthAsStringFor: aYear
	
	| monthString yearString |
	
	monthString := today monthIndex asString.
	yearString := aYear asString.
	
	(monthString size = 1) ifTrue: [ monthString := '0', monthString ].
	
	^ monthString, yearString! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'ENC 6/24/2021 01:17:58'!
todayExpiredMonthAsString
	
	^ self monthAsStringFor: today yearNumber - 1.! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'ENC 6/24/2021 01:18:19'!
todayMonthAsString
	
	^ self monthAsStringFor: today yearNumber ! !


!StoreTestObjectsFactory methodsFor: 'inner interface' stamp: 'ENC 6/24/2021 01:42:01'!
addValidItemToCart: aCartId for: anInnerInterface

	^ anInnerInterface 
		add: 1 of: self itemSellByTheStore 
		toCart: aCartId 
		at: self dateTimeToday.! !

!StoreTestObjectsFactory methodsFor: 'inner interface' stamp: 'ENC 6/24/2021 02:10:25'!
cartWithAValidItemFor: anInnerInterface

	| cartID |
	
	cartID := self createCartWithValidCredentialsFor: anInnerInterface.
	self addValidItemToCart: cartID for: anInnerInterface.

	^ cartID 
	! !

!StoreTestObjectsFactory methodsFor: 'inner interface' stamp: 'ENC 6/24/2021 02:35:06'!
checkoutCartWithValidCardfor: anInnerInterface

	| cartID |

	cartID := self cartWithAValidItemFor: anInnerInterface.
	
	^ self checkoutWithValidCard: cartID for: anInnerInterface.! !

!StoreTestObjectsFactory methodsFor: 'inner interface' stamp: 'ENC 6/24/2021 02:21:09'!
checkoutWithInvalidCard: aCartID for: anInnerInterface

	^ anInnerInterface 
		checkout: aCartID at: self dateTimeToday 
		withCard: 0 from: '' expiringOn: '' ! !

!StoreTestObjectsFactory methodsFor: 'inner interface' stamp: 'ENC 6/24/2021 02:24:39'!
checkoutWithValidCard: aCartID for: anInnerInterface

	^ anInnerInterface 
		checkout: aCartID at: self dateTimeToday 
		withCard: 1234567812345678 from: 'anOwner' expiringOn: self todayMonthAsString ! !

!StoreTestObjectsFactory methodsFor: 'inner interface' stamp: 'ENC 6/24/2021 01:36:52'!
createCartWithInvalidCredentialsFor: anInnerInterface

	^ anInnerInterface 
		createCartForUser: self invalidUser 
		withPassword: self validUserPassword 
		at: self dateTimeToday! !

!StoreTestObjectsFactory methodsFor: 'inner interface' stamp: 'ENC 6/24/2021 01:37:16'!
createCartWithValidCredentialsFor: anInnerInterface

	^ anInnerInterface 
		createCartForUser: self validUser 
		withPassword: self validUserPassword 
		at: self dateTimeToday! !

!StoreTestObjectsFactory methodsFor: 'inner interface' stamp: 'ENC 6/24/2021 01:33:45'!
credentialValidatorForInvalidCredentials

	^ CredentialValidatorSimulatorInvalidCredentials new! !

!StoreTestObjectsFactory methodsFor: 'inner interface' stamp: 'ENC 6/24/2021 01:33:53'!
credentialValidatorForValidCredentials

	^ CredentialValidatorSimulatorValidCredentials new! !

!StoreTestObjectsFactory methodsFor: 'inner interface' stamp: 'ENC 6/24/2021 01:37:39'!
interfaceForInvalidCredentialsWith: aMerchantProcessor

	^ InnerUserInterface 
		with: self credentialValidatorForInvalidCredentials 
		acceptingItemsOf: self defaultCatalog 
		throughtMP: aMerchantProcessor .! !

!StoreTestObjectsFactory methodsFor: 'inner interface' stamp: 'ENC 6/24/2021 01:37:49'!
interfaceForValidCredentialsWith: aMerchantProcessor

	^ InnerUserInterface 
		with: self credentialValidatorForValidCredentials 
		acceptingItemsOf: self defaultCatalog 
		throughtMP: aMerchantProcessor .! !

!StoreTestObjectsFactory methodsFor: 'inner interface' stamp: 'ENC 6/24/2021 01:25:21'!
invalidUser

	^ 'invalidUser'! !

!StoreTestObjectsFactory methodsFor: 'inner interface' stamp: 'ENC 6/24/2021 02:15:28'!
listCart: aCartID for: anInnerInterface

	^ anInnerInterface listCart: aCartID at: self dateTimeToday! !

!StoreTestObjectsFactory methodsFor: 'inner interface' stamp: 'ENC 6/24/2021 02:16:00'!
listExpiredCart: aCartID for: anInnerInterface

	^ anInnerInterface listCart: aCartID at: self dateTimeTodayAfter30Minutes ! !

!StoreTestObjectsFactory methodsFor: 'inner interface' stamp: 'ENC 6/24/2021 02:04:48'!
listPurchasesOfValidUserFor: anInnerInterface

	^ anInnerInterface 
		listPurchasesOf: self validUser 
		withPassword: self validUserPassword ! !

!StoreTestObjectsFactory methodsFor: 'inner interface' stamp: 'ENC 6/24/2021 01:25:17'!
validUser

	^ 'validUser'! !

!StoreTestObjectsFactory methodsFor: 'inner interface' stamp: 'ENC 6/24/2021 01:25:32'!
validUserPassword

	^ 'password'! !
