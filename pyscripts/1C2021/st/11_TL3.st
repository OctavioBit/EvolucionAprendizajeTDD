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


!classDefinition: #TusLibrosSystemTests category: 'TusLibros'!
TestCase subclass: #TusLibrosSystemTests
	instanceVariableNames: 'testObjectsFactory tusLibros'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosSystemTests methodsFor: 'tests - creating cart' stamp: 'ERMC 6/22/2021 21:33:58'!
test01_createCartWithValidUserIdAndPassword

	| cartId |
	
	cartId _ tusLibros createCartFor: self validUser withPassword: self validPassword.
	
	self assert: (tusLibros listCartById: cartId) isEmpty.
	! !

!TusLibrosSystemTests methodsFor: 'tests - creating cart' stamp: 'ERMC 6/22/2021 21:34:55'!
test02_CanNotCreateACartWithInvalidUser

	self 
		should: [tusLibros createCartFor: self invalidUser withPassword: self validPassword]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: tusLibros invalidUserPasswordErrorDescription equals: anError messageText.
			self assert: tusLibros carts isEmpty]
	
	

	! !

!TusLibrosSystemTests methodsFor: 'tests - creating cart' stamp: 'ERMC 6/22/2021 21:35:18'!
test03_CanNotCreateACartWithValidUserButIncorrectPassword

	self 
		should: [tusLibros createCartFor: self validUser withPassword: self invalidPassword .]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: tusLibros invalidUserPasswordErrorDescription equals: anError messageText.
			self assert: tusLibros carts isEmpty]
	
	

	! !


!TusLibrosSystemTests methodsFor: 'tests objects' stamp: 'ERMC 6/22/2021 20:17:27'!
defaultCatalog
	
	| storeTestObjectsFactory |
	
	storeTestObjectsFactory _ StoreTestObjectsFactory  new.
	
 	^storeTestObjectsFactory defaultCatalog ! !

!TusLibrosSystemTests methodsFor: 'tests objects' stamp: 'ERMC 6/22/2021 20:19:12'!
defaultSalesBook

	^Dictionary new.! !

!TusLibrosSystemTests methodsFor: 'tests objects' stamp: 'ERMC 6/22/2021 20:23:42'!
defaultUsersAndPaswords

	| usersAndPassword |
	
	usersAndPassword _ Dictionary new.
	
	usersAndPassword add: 'Pepe'->'Isw123';
					add: 'Ed'->'libertad2';
					yourself.

	^ usersAndPassword ! !

!TusLibrosSystemTests methodsFor: 'tests objects' stamp: 'ERMC 6/22/2021 21:33:47'!
invalidPassword
 
	^'123'.

	! !

!TusLibrosSystemTests methodsFor: 'tests objects' stamp: 'ERMC 6/22/2021 21:32:59'!
invalidUser

	^ 'Wilkinson'! !

!TusLibrosSystemTests methodsFor: 'tests objects' stamp: 'ERMC 6/22/2021 21:33:37'!
validPassword
 
	^'Isw123'.

	! !

!TusLibrosSystemTests methodsFor: 'tests objects' stamp: 'ERMC 6/22/2021 21:32:25'!
validUser

	^ 'Pepe'! !


!TusLibrosSystemTests methodsFor: 'tests - adding to cart' stamp: 'ERMC 6/22/2021 21:52:44'!
test04_CanNotAddAnItemInACartThatIsNotInTusLibros
	
	| invalidCartId |
	invalidCartId _ 1.
	
	self 
		should: [tusLibros addTocartId: invalidCartId bookIsbn: 'The ring' andQuantity: 1]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: tusLibros canNotAddItemsOfABookToInvalidCartErrorDescription equals: anError messageText]
		
		! !

!TusLibrosSystemTests methodsFor: 'tests - adding to cart' stamp: 'ERMC 6/22/2021 21:58:51'!
test05_CanNotAddItemThatIsNotInTheEditorialISBN
	
	| invalidBook cartId |
	
	invalidBook _ 'invalid book'.
	
	cartId _ tusLibros createCartFor: self validUser withPassword: self validPassword.
	
	self 
		should: [tusLibros addTocartId: cartId bookIsbn: invalidBook andQuantity: 1]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: tusLibros invalidBookISBNErrorDescription equals: anError messageText.
			self assert: (tusLibros listCartById: cartId) isEmpty]
		
		! !

!TusLibrosSystemTests methodsFor: 'tests - adding to cart' stamp: 'ERMC 6/22/2021 22:15:17'!
test06_CanAdddItemsToAValidCartCreated
	
	| validBook cartId |
	
	validBook _ 'validBook'.
	
	cartId _ tusLibros createCartFor: self validUser withPassword: self validPassword.

	tusLibros addTocartId: cartId bookIsbn: validBook andQuantity: 1.
	
	self assert: ((tusLibros listCartById: cartId) occurrencesOf: validBook) equals: 1
		! !


!TusLibrosSystemTests methodsFor: 'tests - check out cart' stamp: 'ERMC 6/23/2021 20:39:30'!
test10_CanNotCheckoutOfAnInvalidCart
	
	| invalidCartId |
	invalidCartId _ 1. 
	self 
		should: [tusLibros checkoutCartBy: invalidCartId
					    withCreditCardNumber: testObjectsFactory validCreditCartNumber 
					    ownedBy: testObjectsFactory validOwner 
					    expiredDate: testObjectsFactory validAndNotExpiredMonthOfYear] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: tusLibros invalidCartErrorDescription equals: anError messageText
			]! !

!TusLibrosSystemTests methodsFor: 'tests - check out cart' stamp: 'ERMC 6/23/2021 22:20:12'!
test11_CanNotCheckoutWithAnEmptyCart
	
	| cartId |
	cartId _ tusLibros createCartFor: self validUser withPassword: self validPassword.
	self 
		should: [tusLibros checkoutCartBy: cartId
					    withCreditCardNumber: testObjectsFactory validCreditCartNumber 
					    ownedBy: testObjectsFactory validOwner 
					    expiredDate: testObjectsFactory validAndNotExpiredMonthOfYear] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: tusLibros canNotCheckoutWithAnEmptyCartErrorDescription equals: anError messageText
			]! !

!TusLibrosSystemTests methodsFor: 'tests - check out cart' stamp: 'ERMC 6/24/2021 16:53:03'!
test12_CanCheckoutWithAnonEmptyCart
	
	"| cartId purchases |
	
	cartId _ tusLibros createCartFor: self validUser withPassword: self validPassword.
	
	tusLibros addTocartId: cartId bookIsbn: 'validBook'  andQuantity: 3.
	
	tusLibros checkoutCartBy: cartId
		    withCreditCardNumber: testObjectsFactory validCreditCartNumber 
		    ownedBy: testObjectsFactory validOwner 
		    expiredDate: testObjectsFactory validAndNotExpiredMonthOfYear.
		
	purchases _ tusLibros listItemsBuyedFrom: self validUser withPassword: self validPassword.
	
	self assert: (purchases at: 'validBook') equals: testObjectsFactory itemSellByTheStore."
	
	"llegamos hasta aca, nos quedamos si tiempo"! !


!TusLibrosSystemTests methodsFor: 'tests - listing cart' stamp: 'ERMC 6/23/2021 19:54:49'!
test07_ListingAnEmptyCartReturnsEmptyList
	
	| cartId |
	
	cartId _ tusLibros createCartFor: self validUser withPassword: self validPassword.
	
	self assert: (tusLibros listCartById: cartId) isEmpty.
		! !

!TusLibrosSystemTests methodsFor: 'tests - listing cart' stamp: 'ERMC 6/24/2021 15:45:40'!
test08_CanNotListACartItemsOfAnInvalidCartId
	
	| invalidCart |
	
	invalidCart _ 199.
	self 
		should: [tusLibros listCartById: invalidCart] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: tusLibros invalidBookISBNErrorDescription equals: anError messageText]! !

!TusLibrosSystemTests methodsFor: 'tests - listing cart' stamp: 'ERMC 6/23/2021 20:11:04'!
test09_ListingCartOfValidCartIdReturnsCorrectItems
	
	| cartId expectedItems |
	cartId _ tusLibros createCartFor: self validUser withPassword: self validPassword.
	
	tusLibros addTocartId: cartId bookIsbn: 'validBook' andQuantity: 1.
	tusLibros addTocartId: cartId bookIsbn: 'validBook2' andQuantity: 1.
	
	expectedItems _ tusLibros listCartById: cartId.
	
	self assert: (expectedItems occurrencesOf: 'validBook') equals: 1.
	self assert: (expectedItems occurrencesOf: 'validBook2') equals: 1.! !


!TusLibrosSystemTests methodsFor: 'setup' stamp: 'ERMC 6/23/2021 20:41:08'!
setUp
	
	tusLibros _ TusLibros 
		usersAndPasswords: self defaultUsersAndPaswords
		acceptingItemsOf: self defaultCatalog
		registeringOn: self defaultSalesBook.
		
	testObjectsFactory _ StoreTestObjectsFactory new.! !


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


!Cart methodsFor: 'as yet unclassified' stamp: 'ERMC 6/22/2021 20:50:29'!
listItems

	^items .! !

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


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


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


!classDefinition: #ShoppingCart category: 'TusLibros'!
Object subclass: #ShoppingCart
	instanceVariableNames: 'user tusLibros cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ShoppingCart methodsFor: 'initialization' stamp: 'ERMC 6/23/2021 23:02:46'!
initializeWithOwner: anUser for: aTusLibrosSystem with: aCart 

	user _ anUser.
	tusLibros _ aTusLibrosSystem.
	cart _ aCart.! !


!ShoppingCart methodsFor: 'accesing' stamp: 'ERMC 6/23/2021 23:19:09'!
listItems
	
	^cart listItems.! !


!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'ERMC 6/23/2021 23:21:23'!
add: aQuantity of: aBook 
	
	cart add: aQuantity of: aBook.! !

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'ERMC 6/24/2021 16:45:13'!
toCheckoutWithCreditCardNumber: aString ownedBy: aString2 expiredData: aMonth 
	self shouldBeImplemented.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCart class' category: 'TusLibros'!
ShoppingCart class
	instanceVariableNames: ''!

!ShoppingCart class methodsFor: 'as yet unclassified' stamp: 'ERMC 6/23/2021 23:01:19'!
owner: anUser for: tusLibrosSystem with: aCart 
	
	^self new initializeWithOwner: anUser for: tusLibrosSystem with: aCart.! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'ERMC 6/23/2021 20:08:08'!
item2SellByTheStore 

	^'validBook2'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'ERMC 6/23/2021 20:08:20'!
item2SellByTheStorePrice
	
	^10! !

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

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'ERMC 6/23/2021 20:20:42'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self item2SellByTheStore put: self item2SellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ERMC 6/23/2021 20:45:05'!
validAndNotExpiredMonthOfYear
	
	^(Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ERMC 6/23/2021 20:40:12'!
validCreditCartNumber
	
	^'012345678912'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ERMC 6/23/2021 20:34:16'!
validOwner
	
	^'Alan Kay'! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!classDefinition: #TusLibros category: 'TusLibros'!
Object subclass: #TusLibros
	instanceVariableNames: 'usersAndPasswords catalog salesBook shoppingCarts currentCartId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibros methodsFor: 'accesing' stamp: 'ERMC 6/23/2021 23:14:14'!
currentCartId

	^currentCartId! !

!TusLibros methodsFor: 'accesing' stamp: 'ERMC 6/23/2021 22:52:13'!
getCartId 
	
	currentCartId _ currentCartId + 1.
	^currentCartId ! !

!TusLibros methodsFor: 'accesing' stamp: 'ERMC 6/23/2021 23:14:50'!
listCartById: anId
	
	| cart |
	cart _ shoppingCarts at: (self currentCartId) ifAbsent: [^self error: self invalidBookISBNErrorDescription].
	^cart listItems.

	! !


!TusLibros methodsFor: 'errors' stamp: 'ERMC 6/22/2021 21:51:37'!
canNotAddItemsOfABookToInvalidCartErrorDescription

	^' can not add items of a book to an ivalid cart'! !

!TusLibros methodsFor: 'errors' stamp: 'ERMC 6/23/2021 22:41:17'!
canNotCheckoutWithAnEmptyCartErrorDescription
	
	^'can not check out with empty cart'.! !

!TusLibros methodsFor: 'errors' stamp: 'ERMC 6/22/2021 22:01:11'!
invalidBookISBNErrorDescription
	
	^' the book isbn is not in the catalog' ! !

!TusLibros methodsFor: 'errors' stamp: 'ERMC 6/23/2021 22:15:04'!
invalidCartErrorDescription
	
	^'ivalid cart Id'! !

!TusLibros methodsFor: 'errors' stamp: 'ERMC 6/22/2021 21:18:10'!
invalidUserErrorDescription
	
	^ 'the user is not valid. Please Sign up'! !

!TusLibros methodsFor: 'errors' stamp: 'ERMC 6/22/2021 21:18:50'!
invalidUserPasswordErrorDescription
	
	^'invalid password. Please check again' ! !


!TusLibros methodsFor: 'assertions' stamp: 'ERMC 6/22/2021 22:02:40'!
assertId: anId on: aContent
	
	aContent at: anId ifAbsent: [^false].
	^true! !

!TusLibros methodsFor: 'assertions' stamp: 'ERMC 6/22/2021 21:34:35'!
assertUser: anUser withPasswordValid: aPassword 
	
	| password |
	
	password _ usersAndPasswords at: anUser ifAbsent: [^false].
	
	^(aPassword = password)
	! !


!TusLibros methodsFor: 'initialization' stamp: 'ERMC 6/23/2021 22:51:24'!
InitializeWithUsersAndPasswords: XusersAndPasswords acceptingItemsOf: aCatalog registeringOn: aSalesBook

	usersAndPasswords  _ XusersAndPasswords.
	catalog _ aCatalog.
	salesBook _ aSalesBook.
	carts _ Dictionary new.
	currentCartId _ 0.
	
	shoppingCarts _ Dictionary new.! !


!TusLibros methodsFor: 'adding' stamp: 'ERMC 6/23/2021 23:20:26'!
addTocartId: cartId bookIsbn: anIsbn andQuantity: aQuantity
	
	| cart |
	(self assertId: cartId on: shoppingCarts) ifFalse: [^self error: self canNotAddItemsOfABookToInvalidCartErrorDescription].
	(self assertId: anIsbn on: catalog) ifFalse: [^self error: self invalidBookISBNErrorDescription].
	
	cart _ shoppingCarts at: cartId. 
		
	cart add: aQuantity of: anIsbn.
	
	^cart
	
	 
! !


!TusLibros methodsFor: 'checkout' stamp: 'ERMC 6/24/2021 16:45:05'!
checkoutCartBy: anId withCreditCardNumber: aCreditCarNumber ownedBy: anOwner expiredDate: aExpiredDate
 
	| shoppingCart |
	
	shoppingCart _ shoppingCarts at: anId ifAbsent: [	^self error: self invalidCartErrorDescription].
	((shoppingCart listItems) isEmpty) ifTrue: [^self error: self canNotCheckoutWithAnEmptyCartErrorDescription].
	
	shoppingCart toCheckoutWithCreditCardNumber: aCreditCarNumber
				ownedBy: anOwner
				expiredData: aExpiredDate.! !


!TusLibros methodsFor: 'creating' stamp: 'ERMC 6/23/2021 23:15:14'!
createCartFor: anUser withPassword: aPassword
	
	| shoppingCart cartId |
	
	(self assertUser: anUser withPasswordValid: aPassword) ifFalse: [^self error: self invalidUserPasswordErrorDescription].
			
	shoppingCart _ ShoppingCart owner: anUser for: self with: (Cart acceptingItemsOf: catalog).
	
	cartId _ self getCartId.
	shoppingCarts at: cartId put: shoppingCart.
	
	^cartId! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibros class' category: 'TusLibros'!
TusLibros class
	instanceVariableNames: ''!

!TusLibros class methodsFor: 'as yet unclassified' stamp: 'ERMC 6/22/2021 20:34:14'!
usersAndPasswords: usersAndPasswords 	acceptingItemsOf:  aCatalog 		registeringOn: aSalesBook
	
	^self new InitializeWithUsersAndPasswords: usersAndPasswords acceptingItemsOf: aCatalog registeringOn: aSalesBook! !
