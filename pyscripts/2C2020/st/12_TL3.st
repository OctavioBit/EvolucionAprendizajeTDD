!classDefinition: #CartTest category: #TusLibros!
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


!classDefinition: #CashierTest category: #TusLibros!
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


!classDefinition: #FacadeTest category: #TusLibros!
TestCase subclass: #FacadeTest
	instanceVariableNames: 'testObjectsFactory timeNow'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!FacadeTest methodsFor: 'as yet unclassified' stamp: 'AC 12/3/2020 16:39:59'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	timeNow := DateAndTime now.! !

!FacadeTest methodsFor: 'as yet unclassified' stamp: 'AC 12/3/2020 16:12:17'!
test01TrytoCreateCartWithInvalidPasswordOrClient
|facade client password |


facade:= testObjectsFactory createFacade .

client:='JuanGomez'.
password:='45678'.

self should: [ facade createCartWith: client andPass:password  ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: (anError messageText = Facade  loginErrorMessageText).
			
			]! !

!FacadeTest methodsFor: 'as yet unclassified' stamp: 'AC 12/3/2020 16:12:17'!
test02CreateCartWithValidPasswordAndClient
|facade client password |

facade:= testObjectsFactory createFacade .
client:='JosePerez'.
password:='12345'.
 
self assert:((facade createCartWith: client andPass:password) ='1')
			! !

!FacadeTest methodsFor: 'as yet unclassified' stamp: 'AC 12/3/2020 16:39:59'!
test03TryToAddAProductToAValidCart
|facade client password cartId itemList|

facade:= testObjectsFactory createFacade .
client:='JosePerez'.
password:='12345'.
cartId:=facade createCartWith: client andPass:password.

facade addToCart:cartId product: testObjectsFactory itemSellByTheStore quantity: 2 at: timeNow.
itemList:=  facade listCart:cartId at: timeNow.

self assert:(itemList allSatisfy: [:anItem| anItem=testObjectsFactory itemSellByTheStore ]).
self assert:(itemList size= 2)
			! !

!FacadeTest methodsFor: 'as yet unclassified' stamp: 'AC 12/3/2020 16:39:59'!
test04TryToAddAProductToAnInvalidCart
|facade client password cartId |

facade:= testObjectsFactory createFacade .
client:='JosePerez'.
password:='12345'.
cartId:=facade createCartWith: client andPass:password.

[facade addToCart: -22 product: testObjectsFactory itemSellByTheStore quantity: 2 at: timeNow.
self fail ]
on: Error
do: [:anError| self assert: (anError messageText =Facade invalidCartIdErrorMessage). 
	self assert: (( facade listCart: cartId at: timeNow) isEmpty).  ]

			! !

!FacadeTest methodsFor: 'as yet unclassified' stamp: 'AC 12/3/2020 16:39:59'!
test05TryToListAnInvalidCart
|facade client password cartId |

facade:= testObjectsFactory createFacade .
client:='JosePerez'.
password:='12345'.
cartId:=facade createCartWith: client andPass:password.

[facade listCart: -22 at: timeNow .
self fail ]
on: Error
do: [:anError| self assert: (anError messageText =Facade invalidCartIdErrorMessage)	  ]

			! !

!FacadeTest methodsFor: 'as yet unclassified' stamp: 'AC 12/3/2020 16:39:59'!
test06CheckOutWithAValidCart
|facade client password cartId creditCard tID salesBook|

facade:= testObjectsFactory createFacade .
client:='JosePerez'.
password:='12345'.
cartId:=facade createCartWith: client andPass:password.
creditCard := testObjectsFactory createCreditCard.
facade addToCart:cartId product: testObjectsFactory itemSellByTheStore quantity: 2 at: timeNow.
tID:= facade checkOut: cartId  withCreditCard: creditCard at: timeNow.
salesBook :=facade obtainSalesBookForCartId: cartId.
self assert: tID equals:1 .
self assert:  salesBook size equals:1.
self assert: salesBook first total equals: 20
			! !

!FacadeTest methodsFor: 'as yet unclassified' stamp: 'AC 12/3/2020 16:39:59'!
test07CheckOutWithTwoCartHaveDifferentIdTransaction
|facade client password cartId1 cartId2 creditCard tID1 tID2 salesBook1 salesBook2|

facade:= testObjectsFactory createFacade .
client:='JosePerez'.
password:='12345'.
cartId1:=facade createCartWith: client andPass:password.
cartId2:=facade createCartWith: client andPass:password.

creditCard := testObjectsFactory createCreditCard.

facade addToCart:cartId1 product: testObjectsFactory itemSellByTheStore quantity: 2 at: timeNow.
facade addToCart:cartId2 product: testObjectsFactory itemSellByTheStore quantity: 10 at: timeNow.


tID1:= facade checkOut: cartId1  withCreditCard: creditCard at: timeNow.
tID2:= facade checkOut: cartId2  withCreditCard: creditCard at: timeNow.
salesBook1:= facade obtainSalesBookForCartId: cartId1.
salesBook2:= facade obtainSalesBookForCartId: cartId2.
self deny: (tID1 =tID2) .
self assert:( salesBook1 ==salesBook2).
self assert:  salesBook1 size equals:2.
self assert: salesBook1 first total equals: 20.
self assert:  salesBook1 last total equals: 100! !

!FacadeTest methodsFor: 'as yet unclassified' stamp: 'nt 12/3/2020 14:54:03'!
test08TrytoListPurchasesWithInvalidPasswordOrClient
|facade client password |


facade:= testObjectsFactory createFacade .

client:='JuanGomez'.
password:='45678'.

self should: [ facade listPurchases: client andPassword:password  ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: (anError messageText = Facade  loginErrorMessageText).
			
			]! !

!FacadeTest methodsFor: 'as yet unclassified' stamp: 'AC 12/3/2020 16:09:33'!
test09ListPurchasesZeroBooksBought
|facade client password booksAndTotal|


facade:= testObjectsFactory createFacade .

client:='JosePerez'.
password:='12345'.

booksAndTotal := facade listPurchases: client andPassword:password.

self assert: booksAndTotal size equals: 1.
self assert: (booksAndTotal includes: 0)! !

!FacadeTest methodsFor: 'as yet unclassified' stamp: 'AC 12/3/2020 16:39:59'!
test10ListPurchasesOneBooksBought
|facade client password cartId creditCard booksAndTotal|


facade:= testObjectsFactory createFacade .

client:='JosePerez'.
password:='12345'.

cartId:=facade createCartWith: client andPass:password.
creditCard := testObjectsFactory createCreditCard.
facade addToCart:cartId product: testObjectsFactory itemSellByTheStore quantity: 1 at: timeNow.
facade checkOut: cartId  withCreditCard: creditCard at: timeNow.
booksAndTotal := facade listPurchases: client andPassword:password.

self assert: booksAndTotal size equals: 2.
self assert: (booksAndTotal includes: 10).
self assert: (booksAndTotal includes: testObjectsFactory itemSellByTheStore)! !

!FacadeTest methodsFor: 'as yet unclassified' stamp: 'AC 12/3/2020 16:39:59'!
test11ListPurchases3BooksBought
|facade client password cartId creditCard booksAndTotal|


facade:= testObjectsFactory createFacade .

client:='JosePerez'.
password:='12345'.

cartId:=facade createCartWith: client andPass:password.
creditCard := testObjectsFactory createCreditCard.
facade addToCart:cartId product: testObjectsFactory itemSellByTheStore quantity: 3 at: timeNow.
facade checkOut: cartId  withCreditCard: creditCard at: timeNow.
booksAndTotal := facade listPurchases: client andPassword:password.

self assert: booksAndTotal size equals: 4.
self assert: (booksAndTotal includes: 30).
self assert: (booksAndTotal occurrencesOf: testObjectsFactory itemSellByTheStore) equals: 3! !

!FacadeTest methodsFor: 'as yet unclassified' stamp: 'AC 12/3/2020 16:54:01'!
test12sessionExpired
|facade client password cartId |


facade:= testObjectsFactory createFacade .

client:='JosePerez'.
password:='12345'.

cartId:=facade createCartWith: client andPass:password.
[facade addToCart:cartId product: testObjectsFactory itemSellByTheStore quantity: 3 at: DateAndTime now + 3 hours.
	self fail.]
on: Error
do:[:anError | anError messageText = Facade CartExpiredErrorMessage ]
! !


!classDefinition: #Cart category: #TusLibros!
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


!Cart methodsFor: 'initialization' stamp: 'nt 11/30/2020 18:11:43'!
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

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'nt 11/30/2020 18:11:21'!
acceptingItemsOf: aCatalog 

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartData category: #TusLibros!
Object subclass: #CartData
	instanceVariableNames: 'timeManager userId cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartData methodsFor: 'as yet unclassified' stamp: 'AC 12/3/2020 16:29:40'!
cart
^cart! !

!CartData methodsFor: 'as yet unclassified' stamp: 'AC 12/3/2020 16:50:12'!
checkExpiration: aTime for: aCartiD using: aFacade 
	(timeManager < aTime) ifTrue: [aFacade cartExpired: aCartiD].
	timeManager := aTime + 30minutes. ! !

!CartData methodsFor: 'as yet unclassified' stamp: 'AC 12/3/2020 16:29:06'!
initializeWith: aCart and: aUserID
	timeManager:= DateAndTime now+ 30 minutes.
	cart := aCart.
	userId := aUserID.! !

!CartData methodsFor: 'as yet unclassified' stamp: 'AC 12/3/2020 16:29:22'!
userId 
^userId! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartData class' category: #TusLibros!
CartData class
	instanceVariableNames: ''!

!CartData class methodsFor: 'as yet unclassified' stamp: 'AC 12/3/2020 16:28:04'!
newWith: aCart ownedBy: userID
	^self new initializeWith: aCart and: userID.! !


!classDefinition: #Cashier category: #TusLibros!
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

!classDefinition: 'Cashier class' category: #TusLibros!
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


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'number owner verificationDigit expirationMonth expirationYear expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

!CreditCard methodsFor: 'initialization' stamp: 'nt 12/2/2020 19:41:44'!
initializeExpiringOn: aMonth withOwner:anOwner andNumber:aNumber
self 	validateOwner:anOwner.
self validateNumber:aNumber.
	expiration := aMonth. 
	owner:=anOwner.
	number:=aNumber.! !


!CreditCard methodsFor: 'as yet unclassified' stamp: 'nt 12/2/2020 19:46:55'!
validateNumber:aNumber
((aNumber size  =16) and: (aNumber allSatisfy:[:aChar|aChar isDigit]) ) ifFalse:[ self error: CreditCard invalidNumber].! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'nt 12/2/2020 20:34:45'!
validateOwner:anOwner

((anOwner isEmpty)or:(anOwner size>30)) ifTrue: [self error: CreditCard invalidOwner]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !

!CreditCard class methodsFor: 'instance creation' stamp: 'nt 12/2/2020 19:37:41'!
expiringOn: aMonth owner: anOwner number: aNumber 
	
	^self new initializeExpiringOn: aMonth withOwner:anOwner andNumber:aNumber! !

!CreditCard class methodsFor: 'instance creation' stamp: 'nt 12/2/2020 19:47:39'!
invalidNumber
^'Invalid Credit Card Number'! !

!CreditCard class methodsFor: 'instance creation' stamp: 'nt 12/2/2020 19:48:10'!
invalidOwner
^'Invalid Credit Card Owner'! !


!classDefinition: #Facade category: #TusLibros!
Object subclass: #Facade
	instanceVariableNames: 'catalog usersDatabase carts merchantProcessor cartIdSeed transactionId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Facade methodsFor: 'public interface' stamp: 'AC 12/3/2020 16:37:57'!
addToCart:aCartId product: aProduct quantity: aQuantity at: aTime  
	(self obtainCartWithId: aCartId at: aTime) add:aQuantity of:aProduct.! !

!Facade methodsFor: 'public interface' stamp: 'AC 12/3/2020 16:37:57'!
checkOut: cartId withCreditCard:aCreditCard at: aTime  
|cart cashier salesBook|
cart:= self obtainCartWithId: cartId at: aTime.
salesBook := self obtainSalesBookForCartId: cartId.
cashier:= Cashier toCheckout: cart charging:aCreditCard  throught: merchantProcessor on: DateAndTime now  registeringOn: salesBook .
cashier checkOut.
self registerPurchasesFromCart:cartId withClient:(self obtainUserWithCartId: cartId).
^self generateTransactionID




	! !

!Facade methodsFor: 'public interface' stamp: 'AC 12/3/2020 16:30:22'!
createCartWith: aClient andPass:aPassword  
	|cartId cart |
	self validateClient: aClient andPassword: aPassword.
	cartId:= self generateCartId.
	cart:= Cart acceptingItemsOf: catalog.
	carts at:cartId put: (CartData newWith: cart ownedBy: aClient).
	^cartId
	
	
	
	! !

!Facade methodsFor: 'public interface' stamp: 'AC 12/3/2020 16:37:57'!
listCart: aCartId at: aTime  
|cart list itemsInCart|
cart:=self obtainCartWithId: aCartId at: aTime.
list:= Bag new.
itemsInCart:=self itemsInCart: cart.
self from: cart add: itemsInCart to: list.
^list
! !

!Facade methodsFor: 'public interface' stamp: 'AC 12/3/2020 15:57:08'!
listPurchases:anUserId andPassword:aPassword
| salesBook booksAndTotal |
self validateClient: anUserId andPassword: aPassword.
salesBook:= self salesBookFor: anUserId.
booksAndTotal := (self quantityFor: anUserId) copy. 
booksAndTotal add: (self totalSalesFor: salesBook).
^booksAndTotal.

! !


!Facade methodsFor: 'as yet unclassified' stamp: 'nt 12/2/2020 16:42:39'!
addTo: aList  quantity:aQuantity of: anItem

1 to: aQuantity do: [ :aNumber | aList add: anItem ]! !

!Facade methodsFor: 'as yet unclassified' stamp: 'AC 12/3/2020 16:46:40'!
cartExpired: aCartId

	carts removeKey: aCartId.
	self error: Facade cartExpiredErrorMessage.! !

!Facade methodsFor: 'as yet unclassified' stamp: 'nt 12/2/2020 21:45:27'!
createDatabase:usersAndPasswords
|database|
database:=Dictionary new.
usersAndPasswords keysAndValuesDo:[:anUser :aPassword | self createEntry: anUser withPassword:aPassword  inDatabase:database ].
^database ! !

!Facade methodsFor: 'as yet unclassified' stamp: 'nt 12/2/2020 21:55:26'!
createEntry:anUser withPassword:aPassword inDatabase:aDatabase
aDatabase at:anUser put:(UserData newWith: aPassword )! !

!Facade methodsFor: 'as yet unclassified' stamp: 'nt 12/2/2020 17:20:01'!
from: cart add: itemsInCart to: list

	 itemsInCart do: [:anItem| self addTo:list quantity: (cart occurrencesOf: anItem) of: anItem  ]! !

!Facade methodsFor: 'as yet unclassified' stamp: 'nt 11/30/2020 20:50:20'!
generateCartId   
	cartIdSeed := cartIdSeed +1.
	^cartIdSeed asString.
	
	
	
	! !

!Facade methodsFor: 'as yet unclassified' stamp: 'nt 12/2/2020 20:13:48'!
generateTransactionID

transactionId := transactionId + 1.
	^transactionId! !

!Facade methodsFor: 'as yet unclassified' stamp: 'nt 12/2/2020 21:53:31'!
initializeWith:anUserDatabase andCatalog: aCatalog andMProcessor: aMProcessor  
	catalog:=aCatalog.
	salesBook:= OrderedCollection new.
	merchantProcessor :=aMProcessor .
	usersDatabase:=self createDatabase: anUserDatabase .
	carts:=Dictionary new.
	cartIdSeed :=0.
	transactionId:=0.
	! !

!Facade methodsFor: 'as yet unclassified' stamp: 'nt 12/2/2020 17:12:01'!
itemsInCart: cart

	^ catalog keys select:[:anItem |cart includes:anItem ]; yourself! !

!Facade methodsFor: 'as yet unclassified' stamp: 'nt 12/3/2020 14:29:28'!
obtainCartData: aCartId

	^ carts at:aCartId ifAbsent:[self error: Facade invalidCartIdErrorMessage ]! !

!Facade methodsFor: 'as yet unclassified' stamp: 'AC 12/3/2020 16:38:27'!
obtainCartWithId: aCartId at: aTime 
	self verifyCartExpired: aCartId at: aTime.
	^ (self obtainCartData: aCartId)cart! !

!Facade methodsFor: 'as yet unclassified' stamp: 'nt 12/3/2020 14:35:26'!
obtainSalesBookForCartId: aCartId
|userId|
userId:=self obtainUserWithCartId: aCartId.
^self salesBookFor: userId




	! !

!Facade methodsFor: 'as yet unclassified' stamp: 'nt 12/3/2020 14:32:48'!
obtainUserData: aClient

	^ usersDatabase at: aClient ifAbsent: [self error:Facade loginErrorMessageText]! !

!Facade methodsFor: 'as yet unclassified' stamp: 'AC 12/3/2020 16:30:58'!
obtainUserWithCartId: aCartId

	^ (self obtainCartData: aCartId)userId! !

!Facade methodsFor: 'as yet unclassified' stamp: 'nt 12/3/2020 14:32:48'!
passwordFor: aClient

	^ (self obtainUserData: aClient)password! !

!Facade methodsFor: 'as yet unclassified' stamp: 'nt 12/3/2020 15:15:12'!
quantityFor: aClient

	^ (self obtainUserData: aClient)					bookPurchasedQuantity ! !

!Facade methodsFor: 'as yet unclassified' stamp: 'AC 12/3/2020 16:48:48'!
registerPurchasesFromCart:cartId withClient: aUserId
|booksPurchases|
booksPurchases:= self quantityFor: aUserId.
booksPurchases addAll: (self listCart:cartId at: DateAndTime now).




	! !

!Facade methodsFor: 'as yet unclassified' stamp: 'nt 12/3/2020 14:34:08'!
salesBookFor: aClient

	^ (self obtainUserData: aClient)saleBook ! !

!Facade methodsFor: 'as yet unclassified' stamp: 'AC 12/3/2020 16:06:22'!
totalSalesFor: aSalesBook
	^ aSalesBook inject: 0 into: [:c :aSale | aSale total + c]! !

!Facade methodsFor: 'as yet unclassified' stamp: 'nt 11/30/2020 19:19:02'!
validateClient: aClient andPassword: aPassword

	^ ((self passwordFor: aClient)=aPassword ) ifFalse:[self error:Facade loginErrorMessageText]! !

!Facade methodsFor: 'as yet unclassified' stamp: 'AC 12/3/2020 16:49:19'!
verifyCartExpired: aCartId at: aTime.
	(self obtainCartData: aCartId) checkExpiration: aTime for: aCartId using: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Facade class' category: #TusLibros!
Facade class
	instanceVariableNames: ''!

!Facade class methodsFor: 'as yet unclassified' stamp: 'AC 12/3/2020 16:46:56'!
CartExpiredErrorMessage
 ^'Cart expired'! !

!Facade class methodsFor: 'as yet unclassified' stamp: 'nt 12/2/2020 17:35:48'!
invalidCartIdErrorMessage
 ^'Invalid Cart Id'! !

!Facade class methodsFor: 'as yet unclassified' stamp: 'nt 11/29/2020 18:41:19'!
loginErrorMessageText
	'Wrong user or password'! !

!Facade class methodsFor: 'as yet unclassified' stamp: 'nt 12/2/2020 20:41:14'!
newWith:aValidator andCatalog:aCatalog andMProcessor:aMProcessor
	^self new initializeWith: aValidator andCatalog:aCatalog andMProcessor: aMProcessor.! !


!classDefinition: #MerchantProcessorMock category: #TusLibros!
Object subclass: #MerchantProcessorMock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorMock methodsFor: 'as yet unclassified' stamp: 'nt 12/2/2020 20:48:07'!
debit:anAmount from:aCreditCard
	! !


!classDefinition: #Sale category: #TusLibros!
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

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
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


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'nt 11/30/2020 18:10:52'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog ! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'nt 12/2/2020 20:29:39'!
createCreditCard.
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1) owner: 'JoseRodriguez' 		number:'1234567890123456'! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'nt 12/2/2020 20:48:52'!
createMerchantProcessor
^MerchantProcessorMock new.
	
	! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'validator' stamp: 'nt 11/30/2020 19:31:43'!
createValidator
	|validator|
	validator:=Dictionary new.
	validator add: ('JosePerez'->'12345').
	^validator! !


!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'nt 12/2/2020 20:52:56'!
createFacade
^Facade newWith: self  createValidator andCatalog: self  defaultCatalog andMProcessor: self createMerchantProcessor .! !


!classDefinition: #UserData category: #TusLibros!
Object subclass: #UserData
	instanceVariableNames: 'password saleBook bookPurchasedQuantity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!UserData methodsFor: 'as yet unclassified' stamp: 'nt 12/2/2020 21:52:19'!
bookPurchasedQuantity
^bookPurchasedQuantity 
! !

!UserData methodsFor: 'as yet unclassified' stamp: 'AC 12/3/2020 15:56:17'!
initializeWith:aPassword 
password :=aPassword.
saleBook:= OrderedCollection new.
bookPurchasedQuantity := Bag new.
! !

!UserData methodsFor: 'as yet unclassified' stamp: 'nt 12/2/2020 21:51:37'!
password
^password 
! !

!UserData methodsFor: 'as yet unclassified' stamp: 'nt 12/2/2020 21:51:53'!
saleBook
^saleBook 
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'UserData class' category: #TusLibros!
UserData class
	instanceVariableNames: ''!

!UserData class methodsFor: 'as yet unclassified' stamp: 'nt 12/2/2020 21:47:45'!
newWith:aPassword
^self new initializeWith:aPassword ! !
