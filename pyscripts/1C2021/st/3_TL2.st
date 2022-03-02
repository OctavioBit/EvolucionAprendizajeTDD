!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'FG 6/14/2021 14:49:55'!
test09CartShouldBeAbleToTellTheTotalValueOfProductsInsideIt

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart total) = 100.! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'FG 6/10/2021 20:11:50'!
defaultCatalog
	
	|catalogue|
	
	catalogue := Dictionary new.
	
	catalogue at: self itemSellByTheStore put: 50.
	
	^ catalogue! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #MisLibrosStoreTest category: 'TusLibros'!
TestCase subclass: #MisLibrosStoreTest
	instanceVariableNames: 'builder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MisLibrosStoreTest methodsFor: 'initialization' stamp: 'FG 6/16/2021 00:15:37'!
initialize

	builder := StoreTestObjectFactory on: GregorianMonthOfYear current.! !


!classDefinition: #CashierTest category: 'TusLibros'!
MisLibrosStoreTest subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'lmalvarez 6/16/2021 21:14:07'!
test01CannotCheckoutAnEmptyCart

	| cashier salesBook |
	
	cashier := Cashier with: MerchantProcessorInnerInterface new.
	salesBook := OrderedCollection new.
	
	self should: [ cashier checkout: builder emptyCart 
					charging: builder validCreditCard 
					on: builder today 
					registeringOn: salesBook ]
		raise: Error
		withExceptionDo: [ :anError | 
				self assert: anError messageText equals: cashier cannotCheckoutAnEmptyCartSignalError.
				self assert: salesBook isEmpty. ].
	! !

!CashierTest methodsFor: 'tests' stamp: 'lmalvarez 6/16/2021 21:14:11'!
test02CheckoutACartWithOnlyOneItem

	| cashier salesBook total |
	
	cashier := Cashier with: MerchantProcessorInnerInterface new.
	salesBook := OrderedCollection new.
	
	total := cashier checkout: builder oneProductCart 
				charging: builder validCreditCard 
				on: builder today
				registeringOn: salesBook.
	
	self assert: salesBook size equals: 1.
	self assert: salesBook first equals: total.! !

!CashierTest methodsFor: 'tests' stamp: 'lmalvarez 6/16/2021 21:14:16'!
test03CheckoutACartWithManyItems

	| cashier salesBook total |
	
	cashier := Cashier with: MerchantProcessorInnerInterface new.
	salesBook := OrderedCollection new.
	
	total := cashier checkout: builder twoProductCart 
				charging: builder validCreditCard 
				on: builder today 
				registeringOn: salesBook.
	
	self assert: salesBook size equals: 1.
	self assert: salesBook first equals: total.! !

!CashierTest methodsFor: 'tests' stamp: 'lmalvarez 6/16/2021 21:14:19'!
test04CashierShouldNotCheckOutAnExpiredCreditCard

	| cashier salesBook |
	
	cashier := Cashier with: MerchantProcessorInnerInterface new.
	salesBook := OrderedCollection new.
	
	self should: [ cashier checkout: builder oneProductCart 
					charging: builder expiredCreditCard 
					on: builder today
					registeringOn: salesBook. ]	
		raise: Error
		withExceptionDo: [ :anError | 
				self assert: anError messageText equals: cashier expiredCreditCardSignalError.
				self assert: salesBook isEmpty. ].
		
		! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
MisLibrosStoreTest subclass: #CreditCardTest
	instanceVariableNames: 'errorMessage builderMessage'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'lmalvarez 6/16/2021 22:02:48'!
test01CreditCardMustHaveNumberWith16Digits

	builderMessage := #validCreditCardWithNumber:.
	errorMessage := CreditCard invalidCreditCardNumberSignalError.

	self assertInvalidCreditCardField:  '00001111222233334'.
	self assertInvalidCreditCardField:  '000011112222333'.
	self assertInvalidCreditCardField:  '000011112222333A'.
			
		! !

!CreditCardTest methodsFor: 'tests' stamp: 'lmalvarez 6/16/2021 22:04:01'!
test02CreditCardMustHaveAnOwnerNameWithAtLeastOneLetter

	builderMessage := #validCreditCardWithOwner:.
	errorMessage := CreditCard invalidOwnerNameSignalError.
	
	self assertInvalidCreditCardField: '  '.! !

!CreditCardTest methodsFor: 'tests' stamp: 'lmalvarez 6/16/2021 22:04:47'!
test03CreditCardMustHaveSecurityNumberWith3Digits

	builderMessage := #validCreditCardWithSecurityNumber:.
	errorMessage := CreditCard invalidCreditCardSecurityNumberSignalError.

	self assertInvalidCreditCardField:  '1234'.
	self assertInvalidCreditCardField:  '12'.
	self assertInvalidCreditCardField:  '12A'.
			
		! !


!CreditCardTest methodsFor: 'assertions' stamp: 'lmalvarez 6/16/2021 22:00:57'!
assertInvalidCreditCardField: aCreditCardField

	self should: [ (builderMessage asMessageWith: aCreditCardField) sendTo: builder ]
		raise: Error
		withMessageText: errorMessage.
! !


!classDefinition: #MerchantProcessorInnerInterfaceTest category: 'TusLibros'!
MisLibrosStoreTest subclass: #MerchantProcessorInnerInterfaceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorInnerInterfaceTest methodsFor: 'tests' stamp: 'lmalvarez 6/16/2021 21:57:51'!
test01StolenCreditCardShouldBeRejected

	| innerInterface |
	
	innerInterface := MerchantProcessorInnerInterface new.
	innerInterface rejectAllCreditCardsForBeingStolen.
	
	self should: [ innerInterface validatePurcharseFor: 500
						    payingWith: builder validCreditCard 
						    requestedBy: (Cashier with: innerInterface)
						    registeringOn: OrderedCollection new ]
		raise: Error
		withMessageText: innerInterface stolenCreditCardSignalError.! !

!MerchantProcessorInnerInterfaceTest methodsFor: 'tests' stamp: 'lmalvarez 6/16/2021 21:57:32'!
test02FalseCreditCardShouldBeRejected

	|  innerInterface |
	
	innerInterface := MerchantProcessorInnerInterface new.
	innerInterface rejectAllCreditCardsForFalsification.
	
	self should: [innerInterface validatePurcharseFor: 500
						    payingWith: builder validCreditCard 
						    requestedBy: (Cashier with: innerInterface)
						    registeringOn: OrderedCollection new]
		raise: Error
		withMessageText: innerInterface falseCreditCardSignalError.! !

!MerchantProcessorInnerInterfaceTest methodsFor: 'tests' stamp: 'lmalvarez 6/16/2021 21:57:06'!
test03CreditCardWithInsufficientCreditShouldBeRejected

	|  innerInterface |
	
	innerInterface := MerchantProcessorInnerInterface new.
	innerInterface rejectAllCreditCardsForNotSufficientCredit.
	
	self should: [ innerInterface validatePurcharseFor: 500
						    payingWith: builder validCreditCard 
						    requestedBy: (Cashier with: innerInterface)
						    registeringOn: OrderedCollection new ]
		raise: Error
		withMessageText: innerInterface creditNotSufficientSignalError.! !


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


!Cart methodsFor: 'assertions' stamp: 'FG 6/10/2021 20:12:48'!
assertIsValidItem: anItem

	(catalog keys includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'FG 6/10/2021 20:18:43'!
items

	^ items copy.! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'as yet unclassified' stamp: 'FG 6/10/2021 20:51:37'!
checkCatalogues: aCashier

	aCashier compareCatalogues: catalog.! !


!Cart methodsFor: 'total' stamp: 'FG 6/14/2021 14:57:08'!
total
	
	^ items sum: [:anItem | catalog at: anItem ] ifEmpty: [0].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'innerInterface'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'error messages' stamp: 'FG 6/15/2021 23:17:45'!
cannotCheckoutAnEmptyCartSignalError

	^ 'Error - Cannot checkout an empty cart'.! !

!Cashier methodsFor: 'error messages' stamp: 'lmalvarez 6/16/2021 21:29:57'!
executeError: anInterfaceError

	self error: anInterfaceError.! !

!Cashier methodsFor: 'error messages' stamp: 'FG 6/14/2021 16:25:13'!
expiredCreditCardSignalError

	^ 'Error - Expired Credit Card'. 
	! !


!Cashier methodsFor: 'checkout' stamp: 'FG 6/14/2021 19:27:20'!
assertThat: aCreditCard isExpiredOn: aMonthOfYear.
		
	( aCreditCard isExpiredOn: aMonthOfYear) ifTrue: [self error: self expiredCreditCardSignalError].	! !

!Cashier methodsFor: 'checkout' stamp: 'FG 6/10/2021 20:02:04'!
assertThatCartIsEmpty: aCart

	^ (aCart isEmpty) ifTrue: [self error: self cannotCheckoutAnEmptyCartSignalError]! !

!Cashier methodsFor: 'checkout' stamp: 'lmalvarez 6/16/2021 21:48:32'!
checkout: aCart charging: aCreditCard on: aMonthOfYear registeringOn: aSalesBook

	self assertThatCartIsEmpty: aCart.
	self assertThat: aCreditCard isExpiredOn: aMonthOfYear.

	^ innerInterface validatePurcharseFor: aCart total payingWith: aCreditCard requestedBy: self registeringOn: aSalesBook .

	! !

!Cashier methodsFor: 'checkout' stamp: 'lmalvarez 6/16/2021 21:34:36'!
finishPurchaseOf: anAmount registeringOn: aSalesBook

	aSalesBook add: anAmount.
		
	^ anAmount .
	! !


!Cashier methodsFor: 'initialization' stamp: 'lmalvarez 6/16/2021 21:06:36'!
initializeWith: anInnerInterface

	innerInterface := anInnerInterface.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'lmalvarez 6/16/2021 21:13:44'!
with: anInnerInterface

	^ self new initializeWith: anInnerInterface .! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'number owner securityNumber expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'FG 6/15/2021 23:15:13'!
initializeWithNumber: aCreditCardNumber ownedBy: anOwner withSecurityNumber: aSecurityNumber expiringOn: anExpirationDate

	number := aCreditCardNumber.
	owner := anOwner.	
	securityNumber := aSecurityNumber.
	expirationDate := anExpirationDate.! !


!CreditCard methodsFor: 'accessing' stamp: 'FG 6/14/2021 19:19:02'!
isExpiredOn: aMonthOfYear

	^ expirationDate < aMonthOfYear! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'FG 6/15/2021 23:15:13'!
withNumber: aCreditCardNumber ownedBy: anOwner withSecurityNumber: aSecurityNumber expiringOn: anExpirationDate

	self assertCreditCardNumberIsValid: aCreditCardNumber .
	self assertOwnerNameIsValid: anOwner.
	self assertCreditCardSecurityNumberIsValid: aSecurityNumber.

	^ self new initializeWithNumber: aCreditCardNumber ownedBy: anOwner withSecurityNumber: aSecurityNumber expiringOn: anExpirationDate.! !


!CreditCard class methodsFor: 'assertions' stamp: 'FG 6/14/2021 18:49:10'!
assertCreditCardNumberIsValid: aCreditCardNumber

	self assertThatNumberIsValid: aCreditCardNumber withSize: 16  raising: self invalidCreditCardNumberSignalError.! !

!CreditCard class methodsFor: 'assertions' stamp: 'FG 6/14/2021 18:49:54'!
assertCreditCardSecurityNumberIsValid: aSecurityNumber

	self assertThatNumberIsValid: aSecurityNumber withSize: 3  raising: self invalidCreditCardSecurityNumberSignalError.! !

!CreditCard class methodsFor: 'assertions' stamp: 'FG 6/14/2021 18:51:14'!
assertOwnerNameIsValid: anOwnerName

	^ anOwnerName withBlanksTrimmed isEmpty  ifTrue: [self error: 	self invalidOwnerNameSignalError]! !

!CreditCard class methodsFor: 'assertions' stamp: 'FG 6/14/2021 18:51:59'!
assertThatNumberIsValid: aNumber withSize: aSize raising: anError

	( (aNumber size = aSize) and: [aNumber allSatisfy: [:aDigit | aDigit isDigit]] ) 
		ifFalse: [self error: anError].
	! !


!CreditCard class methodsFor: 'error signals' stamp: 'FG 6/14/2021 18:54:00'!
invalidCreditCardNumberSignalError

	^ 'Error - Invalid Card Number'.! !

!CreditCard class methodsFor: 'error signals' stamp: 'FG 6/14/2021 18:54:34'!
invalidCreditCardSecurityNumberSignalError

	^ 'Error - Invalid Credit Card Security Number'.! !

!CreditCard class methodsFor: 'error signals' stamp: 'FG 6/14/2021 18:54:17'!
invalidOwnerNameSignalError

	^ 'Error - Invalid Owner Name'. ! !


!classDefinition: #MerchantProcessorInnerInterface category: 'TusLibros'!
Object subclass: #MerchantProcessorInnerInterface
	instanceVariableNames: 'behaviour'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorInnerInterface methodsFor: 'validate purchase' stamp: 'lmalvarez 6/16/2021 21:48:44'!
validatePurcharseFor: anAmountToPay payingWith: aCreditCard requestedBy: aCashier registeringOn: aSalesBook
	
	^ behaviour value: aCashier value: anAmountToPay value: aSalesBook .! !


!MerchantProcessorInnerInterface methodsFor: 'initialization' stamp: 'lmalvarez 6/16/2021 21:37:47'!
initialize

	behaviour := [:aCashier :aPurchase :aSalesBook | aCashier finishPurchaseOf: aPurchase registeringOn: aSalesBook ].! !


!MerchantProcessorInnerInterface methodsFor: 'error signals' stamp: 'lmalvarez 6/16/2021 21:01:29'!
creditNotSufficientSignalError
	
	^ ' Error - Not Enogh Credit '! !

!MerchantProcessorInnerInterface methodsFor: 'error signals' stamp: 'lmalvarez 6/16/2021 20:47:32'!
falseCreditCardSignalError
	
	^ ' Error - False Credit Card '! !

!MerchantProcessorInnerInterface methodsFor: 'error signals' stamp: 'lmalvarez 6/16/2021 20:38:46'!
stolenCreditCardSignalError
	
	^ ' Error - Stolen Credit Card ' ! !


!MerchantProcessorInnerInterface methodsFor: 'behaviour' stamp: 'lmalvarez 6/16/2021 21:43:57'!
rejectAllCreditCardsForBeingStolen

	behaviour := [:aCashier :aPurchase :aSalesBook  | aCashier executeError: self stolenCreditCardSignalError ]! !

!MerchantProcessorInnerInterface methodsFor: 'behaviour' stamp: 'lmalvarez 6/16/2021 21:44:02'!
rejectAllCreditCardsForFalsification
	
	behaviour := [:aCashier :aPurchase :aSalesBook  | aCashier executeError: self falseCreditCardSignalError]! !

!MerchantProcessorInnerInterface methodsFor: 'behaviour' stamp: 'lmalvarez 6/16/2021 21:44:06'!
rejectAllCreditCardsForNotSufficientCredit

	behaviour := [:aCashier :aPurchase :aSalesBook  | aCashier executeError: self creditNotSufficientSignalError ]! !


!classDefinition: #StoreTestObjectFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectFactory
	instanceVariableNames: 'today nextYear previousYear'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectFactory methodsFor: 'books' stamp: 'FG 6/14/2021 18:37:40'!
fantasyBook

	^ 'Fantasy Book'
	! !

!StoreTestObjectFactory methodsFor: 'books' stamp: 'FG 6/14/2021 18:37:20'!
horrorBook

	^ 'Horror Book'.! !


!StoreTestObjectFactory methodsFor: 'catalogues' stamp: 'FG 6/14/2021 19:50:21'!
catalogueWithProducts

	|catalogue|
	
	catalogue := Dictionary new.
	
	catalogue at: self fantasyBook put: 50.
	catalogue at: self horrorBook put: 20.
	
	^ catalogue.! !

!StoreTestObjectFactory methodsFor: 'catalogues' stamp: 'FG 6/14/2021 18:37:56'!
emptyCatalogue

	^ Dictionary new.! !


!StoreTestObjectFactory methodsFor: 'initialization' stamp: 'FG 6/15/2021 22:50:13'!
initializeOn: aMonthOfYear

	today := aMonthOfYear.
	nextYear := aMonthOfYear nextMonth: aMonthOfYear month.
	previousYear := aMonthOfYear previousMonth: aMonthOfYear month.! !


!StoreTestObjectFactory methodsFor: 'credit cards' stamp: 'FG 6/15/2021 15:04:26'!
expiredCreditCard

	^ CreditCard withNumber: '1111222233334444' ownedBy: 'Hernan' withSecurityNumber: '123' expiringOn: previousYear. ! !

!StoreTestObjectFactory methodsFor: 'credit cards' stamp: 'FG 6/15/2021 15:04:03'!
validCreditCard

	^ CreditCard withNumber: '1111222233334444' ownedBy: 'Hernan' withSecurityNumber: '123' expiringOn: nextYear. ! !

!StoreTestObjectFactory methodsFor: 'credit cards' stamp: 'FG 6/15/2021 23:21:28'!
validCreditCardWithNumber: aCreditCardNumber

	^ CreditCard withNumber: aCreditCardNumber ownedBy: 'Hernan' withSecurityNumber: '123' expiringOn: nextYear. 

	! !

!StoreTestObjectFactory methodsFor: 'credit cards' stamp: 'FG 6/16/2021 00:11:25'!
validCreditCardWithOwner: anOwner

	^ CreditCard withNumber:'0000111122223333' ownedBy: anOwner withSecurityNumber: '123' expiringOn: nextYear. 

	! !

!StoreTestObjectFactory methodsFor: 'credit cards' stamp: 'FG 6/15/2021 23:22:04'!
validCreditCardWithSecurityNumber: aCreditCardSecurityNumber

	^ CreditCard withNumber: '0000111122223333' ownedBy: 'Hernan' withSecurityNumber: aCreditCardSecurityNumber expiringOn: nextYear. 

	! !


!StoreTestObjectFactory methodsFor: 'carts' stamp: 'FG 6/14/2021 19:21:57'!
emptyCart

	^ Cart acceptingItemsOf: self emptyCatalogue.! !

!StoreTestObjectFactory methodsFor: 'carts' stamp: 'FG 6/14/2021 19:50:47'!
oneProductCart

 	| cart |
	
	cart := Cart acceptingItemsOf: self catalogueWithProducts.
	
	cart add: self fantasyBook.
	
	^ cart.! !

!StoreTestObjectFactory methodsFor: 'carts' stamp: 'FG 6/14/2021 19:50:58'!
twoProductCart

 	| cart |
	
	cart := Cart acceptingItemsOf: self catalogueWithProducts.
	
	cart add: self fantasyBook.
	cart add: self horrorBook.
	
	^ cart.! !


!StoreTestObjectFactory methodsFor: 'dates' stamp: 'FG 6/15/2021 15:03:11'!
nextYear

	^ nextYear.! !

!StoreTestObjectFactory methodsFor: 'dates' stamp: 'FG 6/15/2021 15:03:44'!
previousYear
	
	^ previousYear.! !

!StoreTestObjectFactory methodsFor: 'dates' stamp: 'FG 6/14/2021 19:42:08'!
today

	^ today.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StoreTestObjectFactory class' category: 'TusLibros'!
StoreTestObjectFactory class
	instanceVariableNames: ''!

!StoreTestObjectFactory class methodsFor: 'instance creation' stamp: 'FG 6/15/2021 15:06:01'!
on: aMonthOfYear

	^ self new initializeOn: aMonthOfYear.! !
