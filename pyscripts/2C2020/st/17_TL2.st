!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'CR 11/26/2020 17:11:15'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'CR 11/26/2020 17:12:04'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'CR 11/26/2020 17:11:21'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
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


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'BT 11/24/2020 00:51:28'!
defaultCatalog
	
	| catalog |
	catalog := Dictionary new. 
	catalog at: (self itemSellByTheStore) put: 3.5. 
	^ catalog 
! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'initialization' stamp: 'BT 11/24/2020 02:13:53'!
createCartWithManyItems
	
	| cart |
	cart := Cart acceptingItemsOf: self defaultCatalog.

	cart add: 2 of: 'anItemToSell'. 
	cart add: 3 of: 'anotherItemToSell'. 
	
	^ cart
	! !

!CashierTest methodsFor: 'initialization' stamp: 'BT 11/24/2020 01:29:52'!
createCartWithOneItem
	
	| cart |
	cart := Cart acceptingItemsOf: self defaultCatalog.
	cart add: 'anItemToSell'. 
	^ cart
! !

!CashierTest methodsFor: 'initialization' stamp: 'BT 11/26/2020 16:28:31'!
createCashier
	^ Cashier new.! !

!CashierTest methodsFor: 'initialization' stamp: 'BT 11/24/2020 01:22:38'!
createInvalidCreditCard

	| monthOfExpiration |
	monthOfExpiration := GregorianMonthOfYear current previous.
	
	^ CreditCard of: 'Carlitos Ticona' expiratingOn: monthOfExpiration number: 009.! !

!CashierTest methodsFor: 'initialization' stamp: 'BT 11/24/2020 01:22:11'!
createValidCreditCard

	| monthOfExpiration |
	monthOfExpiration := GregorianMonthOfYear current next.
	
	^ CreditCard of: 'Carlitos Ticona' expiratingOn: monthOfExpiration number: 009.! !

!CashierTest methodsFor: 'initialization' stamp: 'BT 11/24/2020 00:55:31'!
defaultCatalog
	
	| catalog |
	catalog := Dictionary new. 
	catalog at: 'anItemToSell' put: 3.5. 
	catalog at: 'anotherItemToSell' put: 3.9. 
	^ catalog 
! !


!CashierTest methodsFor: 'checkout tests' stamp: 'CR 11/26/2020 17:23:04'!
test01checkOutCartWithOneItemWithValidCreditCardAndValidPaymentWorksCorrectly

	| cashier cartWithOneItem ticket creditCart |
	cashier := self createCashier.
	cashier perfomCheckOutsWith: MPSimulatorValidPayment new.
	cartWithOneItem := self createCartWithOneItem.
	creditCart := self createValidCreditCard.
	ticket := cashier checkOut: cartWithOneItem usingCreditCard: creditCart of: 'Carlitos Ticona' .
	
	self assert: (ticket amountCharged = 3.5).
	self assert: (ticket creditCardNumber = creditCart number).
	self assert: (ticket paidBy = 'Carlitos Ticona').
	self assert: cartWithOneItem alreadyCheckedOut.
	
	

	
! !

!CashierTest methodsFor: 'checkout tests' stamp: 'CR 11/26/2020 17:23:14'!
test02checkOutCartWithManyItemsWithValidCreditCardAndValidPaymentWorksCorrectly

	| cashier ticket creditCart cartWithManyItems |
	cashier := self createCashier.
	cashier perfomCheckOutsWith: MPSimulatorValidPayment new.
	cartWithManyItems := self createCartWithManyItems.
	creditCart := self createValidCreditCard.
	ticket := cashier checkOut: cartWithManyItems usingCreditCard: creditCart of: 'Carlitos Ticona' .
	
	self assert: (ticket amountCharged = 18.7).
	self assert: (ticket creditCardNumber = creditCart number).
	self assert: (ticket paidBy = 'Carlitos Ticona').
	self assert: cartWithManyItems alreadyCheckedOut.
	
	

	
! !

!CashierTest methodsFor: 'checkout tests' stamp: 'CR 11/26/2020 17:21:19'!
test03checkOutCartWithExpiredCreditCardRaisesError

	| cashier creditCart cartWithManyItems |
	cashier := self createCashier.
	cashier perfomCheckOutsWith: MPSimulatorValidPayment new.
	cartWithManyItems := self createCartWithManyItems.
	creditCart := self createInvalidCreditCard.

	self should: [cashier checkOut: cartWithManyItems usingCreditCard: creditCart of: 'Carlitos Ticona' .] 
	raise: Error 
	withExceptionDo: [: anError| 
		self assert: anError messageText = Cashier errorExpiredCreditCard.
		self deny: cartWithManyItems alreadyCheckedOut.
		].

	
! !

!CashierTest methodsFor: 'checkout tests' stamp: 'CR 11/26/2020 17:22:06'!
test04checkOutCartWhenNotOwnerIsPayingRaisesError

	| cashier creditCart cartWithManyItems |
	cashier := self createCashier.
	cashier perfomCheckOutsWith: MPSimulatorValidPayment new.
	cartWithManyItems := self createCartWithManyItems.
	creditCart := self createValidCreditCard .

	self should: [cashier checkOut: cartWithManyItems usingCreditCard: creditCart of: 'Fulano' .] 
	raise: Error 
	withExceptionDo: [: anError| 
		self assert: anError messageText = Cashier errorInvalidClientIsBuying.
		self deny: cartWithManyItems alreadyCheckedOut.
		].
	
! !

!CashierTest methodsFor: 'checkout tests' stamp: 'CR 11/26/2020 17:21:28'!
test05checkOutCartWithOneItemWithValidCreditCardButInvalidPaymentRaisesError

	| cashier cartWithOneItem creditCart |
	cashier := self createCashier.
	cashier perfomCheckOutsWith: MPSimulatorInvalidPayment new. 
	cartWithOneItem := self createCartWithOneItem.
	creditCart := self createValidCreditCard.
	
	self should: [cashier checkOut: cartWithOneItem usingCreditCard: creditCart of: 'Carlitos Ticona' .] 
	raise: Error 
	withExceptionDo: [: anError| 
		self assert: anError messageText = MPSimulatorInvalidPayment errorUnsuccesfulPayment.
		self deny: cartWithOneItem alreadyCheckedOut.
		].

	
! !

!CashierTest methodsFor: 'checkout tests' stamp: 'CR 11/26/2020 17:21:33'!
test06checkOutCartWithManyItemsWithValidCreditCardButInvalidPaymentRaisesError

	| cashier creditCart cartWithManyItems |
	cashier := self createCashier.
	cashier perfomCheckOutsWith: MPSimulatorInvalidPayment new.
	cartWithManyItems := self createCartWithManyItems.
	creditCart := self createValidCreditCard.
	
	self should: [cashier checkOut: cartWithManyItems usingCreditCard: creditCart of: 'Carlitos Ticona' .] 
	raise: Error 
	withExceptionDo: [: anError| 
		self assert: anError messageText = MPSimulatorInvalidPayment errorUnsuccesfulPayment.
		self deny: cartWithManyItems alreadyCheckedOut.
		].
	

	
! !

!CashierTest methodsFor: 'checkout tests' stamp: 'CR 11/26/2020 17:28:18'!
test07checkOutCartAlreadyCheckedOutRaisesError

	| cashier creditCart cartWithManyItems |
	cashier := self createCashier.
	cashier perfomCheckOutsWith: MPSimulatorValidPayment new.
	cartWithManyItems := self createCartWithManyItems.
	creditCart := self createValidCreditCard.
	cashier checkOut: cartWithManyItems usingCreditCard: creditCart of: 'Carlitos Ticona' .
	
	self should: [cashier checkOut: cartWithManyItems usingCreditCard: creditCart of: 'Carlitos Ticona' .] 
	raise: Error 
	withExceptionDo: [: anError| 
		self assert: anError messageText = Cashier errorCartAlreadyCheckedOut.
		].
	

	
! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items checkedout'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'assertions' stamp: 'CR 11/26/2020 17:10:43'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self class invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'CR 11/26/2020 17:10:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self class invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'CR 11/26/2020 17:09:11'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.
	checkedout := false.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'BT 11/24/2020 02:09:21'!
total
	^ items sum: [:anItem | catalog at: anItem ] ifEmpty: 0. ! !


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


!Cart methodsFor: 'cashier collaboration' stamp: 'CR 11/26/2020 17:10:03'!
alreadyCheckedOut
	^checkedout.! !

!Cart methodsFor: 'cashier collaboration' stamp: 'CR 11/26/2020 17:09:28'!
notifyCheckOut
	checkedout := true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!Cart class methodsFor: 'error messages' stamp: 'CR 11/26/2020 17:11:44'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'CR 11/26/2020 17:12:11'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'signals' stamp: 'CR 11/26/2020 17:07:19'!
signalCartAlreadyCheckedOut
	self error: self class errorCartAlreadyCheckedOut.
	! !

!Cashier methodsFor: 'signals' stamp: 'BT 11/24/2020 01:40:38'!
signalExpiredCreditCard
	self error: self class errorExpiredCreditCard.
	
	
	! !

!Cashier methodsFor: 'signals' stamp: 'BT 11/24/2020 01:37:43'!
signalInvalidClientIsBuying
	self error: self class errorInvalidClientIsBuying.
	
	! !


!Cashier methodsFor: 'actions' stamp: 'CR 11/26/2020 17:08:34'!
checkOut: aCart usingCreditCard: aCreditCard of: buyingClient
	| cartTotal idTransaction |
	self verifyOwnerOf: aCreditCard is: buyingClient.
	self verifyItIsaValidCreditCard: aCreditCard.
	self verifyCartIsNotAlreadyCheckedOut: aCart.
	cartTotal :=  aCart total.
	idTransaction := merchantProcessor charge: cartTotal to: aCreditCard.
	aCart notifyCheckOut. 
	^Ticket forTransaction: idTransaction doneBy: aCreditCard of: cartTotal.
	
	
	! !


!Cashier methodsFor: 'verifications' stamp: 'CR 11/26/2020 17:06:06'!
verifyCartIsNotAlreadyCheckedOut: aCart
	(aCart alreadyCheckedOut) ifTrue: [self signalCartAlreadyCheckedOut].
	! !

!Cashier methodsFor: 'verifications' stamp: 'BT 11/24/2020 01:40:08'!
verifyItIsaValidCreditCard: aCreditCard
	( GregorianMonthOfYear current < aCreditCard expiration) ifFalse: [ self signalExpiredCreditCard]
	
	
	
	! !

!Cashier methodsFor: 'verifications' stamp: 'BT 11/24/2020 01:36:57'!
verifyOwnerOf: aCreditCard is: buyingClient.
	(aCreditCard owner = buyingClient) ifFalse: [ self signalInvalidClientIsBuying]
	
	! !


!Cashier methodsFor: 'initialization' stamp: 'BT 11/26/2020 16:30:22'!
perfomCheckOutsWith: merchantProcessorToCollaborateWith
	merchantProcessor := merchantProcessorToCollaborateWith.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error messages' stamp: 'CR 11/26/2020 17:07:38'!
errorCartAlreadyCheckedOut
	^ 'The cart is already checked out'! !

!Cashier class methodsFor: 'error messages' stamp: 'BT 11/24/2020 01:41:09'!
errorExpiredCreditCard
	^ 'Paying with expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'BT 11/24/2020 01:38:13'!
errorInvalidClientIsBuying
	^ 'Invalid client is buying'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'BT 11/24/2020 01:11:37'!
of: cardOwner expiratingOn: monthOfExpiration number: cardNumber
	owner := cardOwner.
	expiration := monthOfExpiration.
	number := cardNumber.! !


!CreditCard methodsFor: 'accessing' stamp: 'BT 11/24/2020 01:35:48'!
expiration
	^ expiration ! !

!CreditCard methodsFor: 'accessing' stamp: 'BT 11/26/2020 16:20:02'!
number
	^ number ! !

!CreditCard methodsFor: 'accessing' stamp: 'BT 11/24/2020 01:35:38'!
owner
	^ owner! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'BT 11/24/2020 01:11:01'!
of: cardOwner expiratingOn: monthOfExpiration number: cardNumber
	^ self new of: cardOwner expiratingOn: monthOfExpiration number: cardNumber.! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'charge to credit card' stamp: 'BT 11/24/2020 01:57:28'!
charge: amountToPay to: aCreditCard
	self subclassResponsibility.! !


!classDefinition: #MPSimulatorInvalidPayment category: 'TusLibros'!
MerchantProcessorSimulator subclass: #MPSimulatorInvalidPayment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MPSimulatorInvalidPayment methodsFor: 'charge to credit card' stamp: 'BT 11/24/2020 01:58:09'!
charge: amountToPay to: aCreditCard
	self signalUnsuccesfulPayment.! !

!MPSimulatorInvalidPayment methodsFor: 'charge to credit card' stamp: 'BT 11/24/2020 02:00:13'!
signalUnsuccesfulPayment
	self error: self class errorUnsuccesfulPayment.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MPSimulatorInvalidPayment class' category: 'TusLibros'!
MPSimulatorInvalidPayment class
	instanceVariableNames: ''!

!MPSimulatorInvalidPayment class methodsFor: 'error messages' stamp: 'BT 11/24/2020 02:00:01'!
errorUnsuccesfulPayment
	^ 'Unsuccesful Payment'! !


!classDefinition: #MPSimulatorValidPayment category: 'TusLibros'!
MerchantProcessorSimulator subclass: #MPSimulatorValidPayment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MPSimulatorValidPayment methodsFor: 'charge to credit card' stamp: 'BT 11/26/2020 16:32:11'!
charge: amountToPay to: aCreditCard
	^ '0192'! !


!classDefinition: #Ticket category: 'TusLibros'!
Object subclass: #Ticket
	instanceVariableNames: 'client amountPaid creditCardNumber transaction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Ticket methodsFor: 'accessing' stamp: 'BT 11/26/2020 16:16:29'!
amountCharged
	^ amountPaid ! !

!Ticket methodsFor: 'accessing' stamp: 'BT 11/26/2020 16:39:21'!
creditCardNumber
	^ creditCardNumber.! !

!Ticket methodsFor: 'accessing' stamp: 'BT 11/26/2020 16:21:33'!
paidBy
	^ client ! !


!Ticket methodsFor: 'initialization' stamp: 'BT 11/26/2020 16:20:37'!
forTransaction: idTransaction doneBy: aCreditCard of: amount.
	transaction := idTransaction.
	creditCardNumber := aCreditCard number.
	amountPaid := 	amount.
	client := aCreditCard owner.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ticket class' category: 'TusLibros'!
Ticket class
	instanceVariableNames: ''!

!Ticket class methodsFor: 'instance creation' stamp: 'BT 11/26/2020 16:36:45'!
forTransaction: idTransaction doneBy: aCreditCard of: amountToPay
	^ self new forTransaction: idTransaction doneBy: aCreditCard of: amountToPay.! !
