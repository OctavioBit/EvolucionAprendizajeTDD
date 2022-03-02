!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'harryPotter lordOfTheRings ageOfEmpires harryPotterCatalogue threeBookCatalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'setUp/tearDown' stamp: 'NNH 11/25/2020 19:36:41'!
setUp

	harryPotter := #HarryPotter.
	lordOfTheRings := #LordOfTheRings.
	ageOfEmpires := #AgeOfEmpires.
	
	harryPotterCatalogue := Catalogue new.
	harryPotterCatalogue add: harryPotter withPrice: 100.
	threeBookCatalogue := Catalogue new.
	threeBookCatalogue add: harryPotter withPrice: 100;
					add: lordOfTheRings withPrice: 50;
					add: ageOfEmpires withPrice: 25.
								
	! !


!CartTest methodsFor: 'tests - adding' stamp: 'AM 11/23/2020 11:19:54'!
test01NewCartIsEmpty

	| anEmptyCart catalogue |
	
	catalogue := Catalogue new.
	
	anEmptyCart := Cart withCatalogue: catalogue.
	
	self assert: anEmptyCart isEmpty.
	self assert: anEmptyCart listCart isEmpty.! !

!CartTest methodsFor: 'tests - adding' stamp: 'NNH 11/25/2020 21:36:10'!
test02AProductAddedToCartIsSuccessfullyAdded

	| aCart |
	
	aCart := Cart withCatalogue: harryPotterCatalogue.
	
	aCart addToCart: harryPotter.
	
	self deny: aCart isEmpty.
	self assert: ( aCart listCart hasEqualElements: {harryPotter} )! !

!CartTest methodsFor: 'tests - adding' stamp: 'NNH 11/25/2020 21:36:20'!
test03ManyProductsAddedToCartAreSuccessfullyAdded

	| aCart |
	
	aCart := Cart withCatalogue: threeBookCatalogue .
	
	aCart addToCart: harryPotter .
	aCart addToCart: lordOfTheRings .
	aCart addToCart: ageOfEmpires .
	
	self deny: aCart isEmpty.
	self assert: ( aCart listCart hasEqualElements: {harryPotter. lordOfTheRings. ageOfEmpires} )! !

!CartTest methodsFor: 'tests - adding' stamp: 'NNH 11/25/2020 21:37:04'!
test05AProductAddedMoreThanOnceIsSuccessfullyAddedMoreThanOnce

	| aCart |
	
	aCart := Cart withCatalogue: harryPotterCatalogue.
	
	aCart addToCart: harryPotter withOccurrences: 2. 
	
	self assert: ( aCart listCart hasEqualElements: {harryPotter. harryPotter} )! !

!CartTest methodsFor: 'tests - adding' stamp: 'NNH 11/25/2020 21:37:14'!
test08ExternallyAddingProductToCartListShouldNotModifyCart

	| anEmptyCart emptyCartList |
	
	anEmptyCart := Cart withCatalogue: harryPotterCatalogue.
	emptyCartList := anEmptyCart listCart.
	emptyCartList add: harryPotter.
	
	self assert: anEmptyCart isEmpty.
	self assert: anEmptyCart listCart isEmpty.! !


!CartTest methodsFor: 'tests - errors' stamp: 'NNH 11/25/2020 21:36:34'!
test04AProductShouldNotBeAddedWhenNotForSale

	| aCart |
	
	aCart := Cart withCatalogue: harryPotterCatalogue.
	
	self should: [ aCart addToCart: lordOfTheRings ]
		raise: Error
		withMessageText: Cart productIsNotForSaleErrorDescription.
		
	self assert: aCart isEmpty. ! !

!CartTest methodsFor: 'tests - errors' stamp: 'NNH 11/25/2020 21:36:45'!
test06AProductShouldNotBeAddedWithNonIntegerQuantity

	| aCart |
	
	aCart := Cart withCatalogue: harryPotterCatalogue.
	
	self should: [ aCart addToCart: harryPotter withOccurrences: 0.5 ]
		raise: Error
		withMessageText: Cart productCanNotBeAddedANonNaturalNumberOfTimesErrorDescription.
		
	self assert: aCart isEmpty. ! !

!CartTest methodsFor: 'tests - errors' stamp: 'NNH 11/25/2020 21:36:53'!
test07AProductShouldNotBeAddedWithNonPositiveQuantity

	| aCart |
	
	aCart := Cart withCatalogue: harryPotterCatalogue.
	
	self should: [ aCart addToCart: harryPotter withOccurrences: 0 ]
		raise: Error
		withMessageText: Cart productCanNotBeAddedANonNaturalNumberOfTimesErrorDescription.
		
	self assert: aCart isEmpty. ! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'harryPotterBook lordOfTheRingsBook ageOfEmpiresBook harryPotterCatalogue threeBookCatalogue simpleMerchantProcessorDouble validCreditCard expiredCreditCard emptyCart harryPotterCart threeBookCart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'merchant processor doubles' stamp: 'NNH 11/25/2020 23:27:05'!
merchantProcessorDoubleToTestCollaboratorsFor: anExpectedTotal
		
	^ MerchantProcessorDouble withSimulationBlockForDebitFrom: [ :aTotal :aCard | 
		self assert: aTotal equals: anExpectedTotal.
		self assert: aCard = validCreditCard. 
		].
	
! !


!CashierTest methodsFor: 'setUp / tearDown' stamp: 'NNH 11/25/2020 23:20:53'!
setUp
	
	harryPotterBook := #HarryPotter.
	lordOfTheRingsBook := #LordOfTheRings.
	ageOfEmpiresBook := #AgeOfEmpires.
	
	harryPotterCatalogue := Catalogue new.
	harryPotterCatalogue add: harryPotterBook withPrice: 100.
	threeBookCatalogue := Catalogue new.
	threeBookCatalogue add: harryPotterBook withPrice: 100;
					add: lordOfTheRingsBook withPrice: 50;
					add: ageOfEmpiresBook withPrice: 25.
					
	emptyCart := Cart withCatalogue: Catalogue new.	
	harryPotterCart := Cart withCatalogue: harryPotterCatalogue .
	harryPotterCart addToCart: harryPotterBook withOccurrences: 1.	
	threeBookCart := Cart withCatalogue: threeBookCatalogue .
	threeBookCart addToCart: harryPotterBook withOccurrences: 1.
	threeBookCart addToCart: lordOfTheRingsBook withOccurrences: 1.
	threeBookCart addToCart: ageOfEmpiresBook withOccurrences: 1.
					
	validCreditCard := CreditCard withNumber: 4444444444444444 expirationDate: January, 2021 owner: 'Hernán'.  
	expiredCreditCard := CreditCard withNumber: 4444444444444444 expirationDate: October, 2020 owner: 'Hernán'.  

	simpleMerchantProcessorDouble := MerchantProcessorDouble new.
! !


!CashierTest methodsFor: 'tests - merchant processor handling' stamp: 'NNH 11/25/2020 23:20:54'!
test03CashierShouldUseMerchantProcessorOnValidConditions
	
	| aCashier |
		
	aCashier := Cashier withProcessor: simpleMerchantProcessorDouble catalogue: harryPotterCatalogue .
	
	aCashier checkOut: harryPotterCart with: validCreditCard.

	self assert: (simpleMerchantProcessorDouble messagesRecieved hasEqualElements: { #debit:from:. } ) .
! !

!CashierTest methodsFor: 'tests - merchant processor handling' stamp: 'NNH 11/25/2020 23:29:37'!
test04CashierSuccessfullyProcessesOneElementCart
	
	| aCashier aMerchantProcessorDouble receipt |
	
	aMerchantProcessorDouble := self merchantProcessorDoubleToTestCollaboratorsFor: 100.
	
	aCashier := Cashier withProcessor: aMerchantProcessorDouble catalogue: harryPotterCatalogue .
		
	receipt := aCashier checkOut: harryPotterCart with: validCreditCard .

	self assert: receipt total equals: 100 .
	self assert: ( receipt products hasEqualElements: { harryPotterBook } ) .
! !

!CashierTest methodsFor: 'tests - merchant processor handling' stamp: 'NNH 11/25/2020 23:29:48'!
test05CashierSuccessfullyProcessesManyElementsCart
	
	| aCashier aMerchantProcessorDouble receipt |
	
	aMerchantProcessorDouble := self merchantProcessorDoubleToTestCollaboratorsFor: 175.

	aCashier := Cashier withProcessor: aMerchantProcessorDouble catalogue: threeBookCatalogue .
	
	receipt := aCashier checkOut: threeBookCart with: validCreditCard .

	self assert: receipt total equals: 175 .
	self assert: ( receipt products hasEqualElements: { harryPotterBook . lordOfTheRingsBook . ageOfEmpiresBook } ) .
! !

!CashierTest methodsFor: 'tests - merchant processor handling' stamp: 'NNH 11/25/2020 23:29:55'!
test06CashierHandlesMerchantProcessorException
	
	| aCashier aMerchantProcessorDouble receipt |
	

	aMerchantProcessorDouble := MerchantProcessorDouble withSimulationBlockForDebitFrom: [ :aTotal :aCard | 
		self error: 'Credit card is stolen'.
		].
		
	aCashier := Cashier withProcessor: aMerchantProcessorDouble catalogue: harryPotterCatalogue .	

	self should: [ receipt := aCashier checkOut: harryPotterCart with: validCreditCard ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: 'Credit card is stolen' .
		self assert: anError receiver equals: aCashier .
		self assert: receipt isNil .
		 ].
	
	

! !


!CashierTest methodsFor: 'tests - validations' stamp: 'NNH 11/25/2020 23:20:54'!
test01CashierShouldNotDispatchEmptyCart
	
	| aCashier |
	
	aCashier := Cashier withProcessor: simpleMerchantProcessorDouble catalogue: Catalogue new.
	
	self should: [ aCashier checkOut: emptyCart with: validCreditCard ]
	raise: Error
	withMessageText: Cashier canNotCheckOutAnEmptyCartErrorDescription .
	
	self deny: simpleMerchantProcessorDouble receivedAMessage.
! !

!CashierTest methodsFor: 'tests - validations' stamp: 'NNH 11/25/2020 23:20:54'!
test02CashierShouldNotDispatchExpiredCreditCard
	
	| aCashier |
	
	aCashier := Cashier withProcessor: simpleMerchantProcessorDouble catalogue: Catalogue new.
	
	self should: [ aCashier checkOut: emptyCart with: expiredCreditCard ]
	raise: Error
	withMessageText: Cashier creditCardHasExpiredErrorDescription.

	self deny: simpleMerchantProcessorDouble receivedAMessage.
! !

!CashierTest methodsFor: 'tests - validations' stamp: 'NNH 11/25/2020 23:20:53'!
test08CashierShouldNotProcessProductWhenItIsNotInCatalogue
	
	| aCashier |


	aCashier := Cashier withProcessor: simpleMerchantProcessorDouble catalogue: harryPotterCatalogue .
	
	self should: [ aCashier checkOut: threeBookCart with: validCreditCard ]
	raise: Error
	withMessageText: Cashier productInCartIsNotForSaleErrorDescription .! !


!classDefinition: #CatalogueTest category: 'TusLibros'!
TestCase subclass: #CatalogueTest
	instanceVariableNames: 'harryPotter lordOfTheRings ageOfEmpires'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CatalogueTest methodsFor: 'setUp/tearDown' stamp: 'AM 11/23/2020 11:23:30'!
setUp

	harryPotter := 'Harry Potter'.
	lordOfTheRings := 'Lord Of The Rings'.
	ageOfEmpires := 'Age Of Empires'.! !


!CatalogueTest methodsFor: 'tests - adding' stamp: 'NNH 11/25/2020 21:38:57'!
test01EmptyCatalogueContainsNoProduct
	
	| aCatalogue |
	
	aCatalogue := Catalogue new.
	
	self deny: ( aCatalogue includes: harryPotter ).! !

!CatalogueTest methodsFor: 'tests - adding' stamp: 'NNH 11/25/2020 21:38:11'!
test02OneProductCatalogueContainsItsOnlyElement
	
	| aCatalogue |
	
	aCatalogue := Catalogue new.
	
	aCatalogue add: harryPotter withPrice: 100.
	
	self assert: ( aCatalogue includes: harryPotter ).
	self assert: ( aCatalogue priceOf: harryPotter ) equals: 100.! !

!CatalogueTest methodsFor: 'tests - adding' stamp: 'NNH 11/25/2020 21:39:13'!
test03ACatalogueWithManyProductsIncludesAllOfThem
	
	| aCatalogue |
	
	aCatalogue := Catalogue new.
	
	aCatalogue add: harryPotter withPrice: 100.
	aCatalogue add: lordOfTheRings withPrice: 50.
	aCatalogue add: ageOfEmpires withPrice: 25.
	
	self assert: ( aCatalogue includes: harryPotter ).
	self assert: ( aCatalogue includes: lordOfTheRings ).
	self assert: ( aCatalogue includes: ageOfEmpires ).

	self assert: ( aCatalogue priceOf: harryPotter ) equals: 100.
	self assert: ( aCatalogue priceOf: lordOfTheRings ) equals: 50.
	self assert: ( aCatalogue priceOf: ageOfEmpires ) equals: 25.! !

!CatalogueTest methodsFor: 'tests - adding' stamp: 'NNH 11/25/2020 23:39:00'!
test04ShouldNotAddAProductWithNonPositivePrice
	
	| aCatalogue |
	
	aCatalogue := Catalogue new.
	
	self should: [ aCatalogue add: harryPotter withPrice: 0 ]
	raise: Error
	withMessageText: Catalogue canNotAddProductWithNonPositivePriceErrorDescription.
	
	self deny: ( aCatalogue includes: harryPotter ) .
! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'validCardNumber futureMonthInACalendar hernan validCreditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'setUp/tearDown' stamp: 'NNH 11/25/2020 19:33:10'!
setUp
	
	validCardNumber := 4444444444444444.
	futureMonthInACalendar := January, 2021.
	hernan := 'Hernán'.
	
	validCreditCard := CreditCard withNumber: validCardNumber expirationDate: futureMonthInACalendar owner: hernan.
	
	! !


!CreditCardTest methodsFor: 'tests - accessing' stamp: 'NNH 11/25/2020 21:27:06'!
test01ValidCardRetrievesPropertiesCorrectly
	
	self assert: validCreditCard number equals: validCardNumber .
	self assert: validCreditCard expirationDate equals: futureMonthInACalendar .
	self assert: validCreditCard owner equals: hernan.

	! !


!CreditCardTest methodsFor: 'tests - validations' stamp: 'NNH 11/25/2020 19:33:38'!
test02CardNumberShouldNotHaveLessThan16Digits

	| anInvalidCardNumber |
	
	anInvalidCardNumber := 10 ^ 15 - 1.
	
	self should: [ CreditCard withNumber: anInvalidCardNumber expirationDate: futureMonthInACalendar owner: hernan ]
	raise: Error
	withMessageText: CreditCard invalidCardNumberErrorDescription .
	

	! !

!CreditCardTest methodsFor: 'tests - validations' stamp: 'AM 11/20/2020 19:24:01'!
test03CardExpirationDateShouldBeAMonthOfAnYear

	| aDayInAMonthOfAnYear |
	
	aDayInAMonthOfAnYear := January/01/2021.
	
	self should: [ CreditCard withNumber: validCardNumber expirationDate: aDayInAMonthOfAnYear owner: hernan ]
	raise: Error
	withMessageText: CreditCard invalidExpirationDateErrorDescription .
	

	! !

!CreditCardTest methodsFor: 'tests - validations' stamp: 'NNH 11/25/2020 19:33:10'!
test04CardNumberShouldBeAnInteger

	| aNonIntegerCardNumber |
	
	aNonIntegerCardNumber := 0.5 .
	
	self should: [ CreditCard withNumber: aNonIntegerCardNumber expirationDate: futureMonthInACalendar owner: hernan ]
	raise: Error
	withMessageText: CreditCard invalidCardNumberErrorDescription .
	

	! !

!CreditCardTest methodsFor: 'tests - validations' stamp: 'NNH 11/25/2020 19:33:10'!
test05CardNumberShouldNotHaveMoreThan16Digits

	| anInvalidCardNumber |
	
	anInvalidCardNumber := 10 ^ 16.
	
	self should: [ CreditCard withNumber: anInvalidCardNumber expirationDate: futureMonthInACalendar owner: hernan ]
	raise: Error
	withMessageText: CreditCard invalidCardNumberErrorDescription .
	

	! !

!CreditCardTest methodsFor: 'tests - validations' stamp: 'NNH 11/25/2020 19:33:10'!
test06OwnerNameShouldNotBeEmpty
	
	self should: [ CreditCard withNumber: validCardNumber expirationDate: futureMonthInACalendar owner: '' ]
	raise: Error
	withMessageText: CreditCard invalidOwnerNameErrorDescription .
	

	! !

!CreditCardTest methodsFor: 'tests - validations' stamp: 'NNH 11/25/2020 19:33:10'!
test07OwnerNameShouldNotBeBlank.
	
	self should: [ CreditCard withNumber: validCardNumber expirationDate: futureMonthInACalendar owner: '      ' ]
	raise: Error
	withMessageText: CreditCard invalidOwnerNameErrorDescription .
	

	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'products catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'accessing' stamp: 'NNH 11/25/2020 21:33:08'!
listCart
	
	^ products copy! !


!Cart methodsFor: 'adding books' stamp: 'NNH 11/25/2020 21:30:47'!
addToCart: aProduct 
	
	self addToCart: aProduct withOccurrences: 1.! !

!Cart methodsFor: 'adding books' stamp: 'NNH 11/25/2020 21:33:24'!
addToCart: aProduct withOccurrences: aNumberOfOccurences

	self assertThatCanBeAdded: aProduct withOccurences: aNumberOfOccurences.
		
	products add: aProduct withOccurrences: aNumberOfOccurences 
	
	! !


!Cart methodsFor: 'assertions' stamp: 'NNH 11/25/2020 21:34:12'!
assertThatCanBeAdded: aProduct withOccurences: aNumberOfOccurrences

	(catalogue includes: aProduct ) ifFalse: [ self signalProductIsNotForSale ].
		
	(aNumberOfOccurrences isInteger and: [ aNumberOfOccurrences > 0 ] ) 
		ifFalse: [ self signalProductCanNotBeAddedANonNaturalNumberOfTimes ].! !


!Cart methodsFor: 'error signaling' stamp: 'NNH 11/25/2020 21:34:36'!
signalProductCanNotBeAddedANonNaturalNumberOfTimes

	^ self error: self class productCanNotBeAddedANonNaturalNumberOfTimesErrorDescription! !

!Cart methodsFor: 'error signaling' stamp: 'NNH 11/25/2020 21:34:52'!
signalProductIsNotForSale

	^ self error: self class productIsNotForSaleErrorDescription! !


!Cart methodsFor: 'initialization' stamp: 'NNH 11/25/2020 21:33:08'!
initializeWithCatalogue: aCatalogue
	
	catalogue := aCatalogue.
	products := OrderedCollection new.! !


!Cart methodsFor: 'testing' stamp: 'NNH 11/25/2020 21:33:08'!
isEmpty
	
	^ products isEmpty! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'AM 11/16/2020 21:28:41'!
withCatalogue: aCatalogue

	^self new initializeWithCatalogue: aCatalogue ! !


!Cart class methodsFor: 'error descriptions' stamp: 'NNH 11/25/2020 21:35:37'!
productCanNotBeAddedANonNaturalNumberOfTimesErrorDescription
	
	^ 'Product can not be added with a non natural number of occurrences'! !

!Cart class methodsFor: 'error descriptions' stamp: 'NNH 11/25/2020 21:34:55'!
productIsNotForSaleErrorDescription
	
	^ 'Product is not for sale'.! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'merchantProcessor catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'assertions' stamp: 'NNH 11/25/2020 21:52:53'!
assertCard: aCreditCard canCheckOut: aCart

	self assertCardIsNotExpired: aCreditCard .
	
	self assertCartIsNotEmpty: aCart .
	
	self assertCartProductsAreInCatalogue: aCart .! !

!Cashier methodsFor: 'assertions' stamp: 'NNH 11/25/2020 21:54:02'!
assertCardIsNotExpired: aCreditCard

	^ (aCreditCard expirationDate < FixedGregorianDate today) ifTrue: [ self error: self class creditCardHasExpiredErrorDescription ]! !

!Cashier methodsFor: 'assertions' stamp: 'NNH 11/25/2020 21:51:33'!
assertCartIsNotEmpty: aCart

	^ aCart isEmpty ifTrue: [ self error: self class canNotCheckOutAnEmptyCartErrorDescription ]! !

!Cashier methodsFor: 'assertions' stamp: 'NNH 11/25/2020 21:52:22'!
assertCartProductsAreInCatalogue: aCart	
	
	( aCart listCart allSatisfy: [ :aProduct | catalogue includes: aProduct ] ) ifFalse: [ self error: self class productInCartIsNotForSaleErrorDescription ] .! !


!Cashier methodsFor: 'cart processing' stamp: 'NNH 11/25/2020 23:30:06'!
checkOut: aCart with: aCreditCard
	
	| total |
	
	self assertCard: aCreditCard canCheckOut: aCart .
	
	total := aCart listCart sum: [ :aProduct | catalogue priceOf: aProduct ].
	
	[ merchantProcessor debit: total from: aCreditCard ] 
		on: Error 
		do: [:anError | self error: anError messageText		] .

	^ Receipt total: total products: aCart listCart .! !


!Cashier methodsFor: 'initialization' stamp: 'NNH 11/20/2020 18:43:39'!
initializeWithProcessor: aMerchantProcessor andCatalogue: aCatalogue 
	
	merchantProcessor := aMerchantProcessor.
	catalogue := aCatalogue.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error descriptions' stamp: 'NNH 11/19/2020 19:01:23'!
canNotCheckOutAnEmptyCartErrorDescription
	^ 'A cashier can not check out an empty cart'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'NNH 11/25/2020 21:54:19'!
creditCardHasExpiredErrorDescription
	
	^ 'Credit card has expired'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'NNH 11/25/2020 20:59:54'!
productInCartIsNotForSaleErrorDescription
	
	^ 'Product in cart is not for sale' .! !


!Cashier class methodsFor: 'instance creation' stamp: 'NNH 11/20/2020 18:48:56'!
withProcessor: aMerchantProcessor catalogue: aCatalogue 
	
	^ self new initializeWithProcessor: aMerchantProcessor andCatalogue: aCatalogue ! !


!classDefinition: #Catalogue category: 'TusLibros'!
Object subclass: #Catalogue
	instanceVariableNames: 'products'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Catalogue methodsFor: 'accessing' stamp: 'NNH 11/25/2020 21:38:11'!
priceOf: aProduct 
	
	^ products at: aProduct .! !


!Catalogue methodsFor: 'initialization' stamp: 'NNH 11/23/2020 10:33:53'!
initialize
	
	products := Dictionary new.! !


!Catalogue methodsFor: 'operations' stamp: 'NNH 11/25/2020 23:38:37'!
add: aProduct withPrice: aPrice 

	aPrice <= 0 ifTrue: [ self signalCanNotAddProductWithNonPositivePrice ].
	products add: aProduct -> aPrice .! !


!Catalogue methodsFor: 'testing' stamp: 'NNH 11/23/2020 10:32:35'!
includes: aProduct 
	
	^ products includesKey: aProduct .! !


!Catalogue methodsFor: 'signaling' stamp: 'NNH 11/25/2020 23:39:00'!
signalCanNotAddProductWithNonPositivePrice

	^ self error: self class canNotAddProductWithNonPositivePriceErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Catalogue class' category: 'TusLibros'!
Catalogue class
	instanceVariableNames: ''!

!Catalogue class methodsFor: 'error descriptions' stamp: 'NNH 11/25/2020 23:39:00'!
canNotAddProductWithNonPositivePriceErrorDescription
	
	^ 'Can not add product with a non positive price'. ! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'number expirationDate owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'NNH 11/19/2020 19:34:56'!
initializeWithNumber: aNumber expirationDate: aMonthOfYear owner: aPerson 
	
	number := aNumber.
	expirationDate := aMonthOfYear.
	owner := aPerson.! !


!CreditCard methodsFor: 'accessing' stamp: 'NNH 11/19/2020 19:26:39'!
expirationDate

	^ expirationDate! !

!CreditCard methodsFor: 'accessing' stamp: 'NNH 11/19/2020 19:26:26'!
number

	^ number! !

!CreditCard methodsFor: 'accessing' stamp: 'NNH 11/19/2020 19:26:51'!
owner

	^ owner! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'assertions' stamp: 'NNH 11/25/2020 21:43:25'!
assertCardNumberIsValid: aNumber
	
	( aNumber isInteger and: [ aNumber between: 10 ^ 15 and: 10 ^ 16 - 1 ] ) ifFalse: [ self error: self invalidCardNumberErrorDescription ] .! !

!CreditCard class methodsFor: 'assertions' stamp: 'NNH 11/25/2020 21:44:26'!
assertExpirationDateIsValid: aMonthOfYear
		
	( aMonthOfYear isKindOf: GregorianMonthOfYear ) ifFalse: [ self error: self invalidExpirationDateErrorDescription ] .
! !

!CreditCard class methodsFor: 'assertions' stamp: 'NNH 11/25/2020 21:45:06'!
assertOwnerNameIsValid: aPerson 

	aPerson withoutTrailingBlanks isEmpty ifTrue: [ self error: self invalidOwnerNameErrorDescription ] .! !


!CreditCard class methodsFor: 'instance creation' stamp: 'NNH 11/25/2020 21:45:19'!
withNumber: aNumber expirationDate: aMonthOfYear owner: aPerson 
	
	self assertCardNumberIsValid: aNumber .
		
	self assertExpirationDateIsValid: aMonthOfYear .
	
	self assertOwnerNameIsValid: aPerson .
	
	^ self new initializeWithNumber: aNumber expirationDate: aMonthOfYear owner: aPerson . ! !


!CreditCard class methodsFor: 'error descriptions' stamp: 'NNH 11/19/2020 19:29:51'!
invalidCardNumberErrorDescription
	
	^ 'Credit card number must be a positive integer' .! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'NNH 11/19/2020 19:37:40'!
invalidExpirationDateErrorDescription
	
	^ 'Expiration date must be a moth of year' .! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'NNH 11/19/2020 21:14:32'!
invalidOwnerNameErrorDescription
	
	^ 'Credit card should not have an invalid owner name'! !


!classDefinition: #MerchantProcessorDouble category: 'TusLibros'!
Object subclass: #MerchantProcessorDouble
	instanceVariableNames: 'messages blockToExecuteOnDebitFrom'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorDouble methodsFor: 'error handling' stamp: 'NNH 11/20/2020 18:32:19'!
doesNotUnderstand: aMessage
	
	messages add: aMessage asString ! !


!MerchantProcessorDouble methodsFor: 'initialization' stamp: 'NNH 11/25/2020 23:11:24'!
initialize
	
	messages := OrderedCollection new.
	blockToExecuteOnDebitFrom := [:aTotal :aCard | ] .! !

!MerchantProcessorDouble methodsFor: 'initialization' stamp: 'NNH 11/25/2020 23:17:03'!
initializeWithSimulationBlockForDebitFrom: aBlockToExecuteOnDebitFrom
	
	messages := OrderedCollection new.
	blockToExecuteOnDebitFrom := aBlockToExecuteOnDebitFrom .! !


!MerchantProcessorDouble methodsFor: 'testing' stamp: 'NNH 11/25/2020 20:30:39'!
messagesRecieved

	^ messages .! !

!MerchantProcessorDouble methodsFor: 'testing' stamp: 'AM 11/20/2020 19:18:09'!
receivedAMessage

	^ messages notEmpty .! !


!MerchantProcessorDouble methodsFor: 'transaction processing' stamp: 'NNH 11/25/2020 23:11:24'!
debit: anAmount from: aCreditCard

	messages add: #debit:from: .
	blockToExecuteOnDebitFrom value: anAmount value: aCreditCard .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorDouble class' category: 'TusLibros'!
MerchantProcessorDouble class
	instanceVariableNames: ''!

!MerchantProcessorDouble class methodsFor: 'instance creation' stamp: 'NNH 11/25/2020 23:17:57'!
withSimulationBlockForDebitFrom: aBlockToExecuteOnDebitFrom

	^self new initializeWithSimulationBlockForDebitFrom: aBlockToExecuteOnDebitFrom ! !


!classDefinition: #Receipt category: 'TusLibros'!
Object subclass: #Receipt
	instanceVariableNames: 'total products'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Receipt methodsFor: 'initialization' stamp: 'NNH 11/20/2020 18:56:21'!
initializeTotal: aTotal products: aCollectionOfProducts 
	
	total := aTotal.
	products := aCollectionOfProducts.! !


!Receipt methodsFor: 'accessing' stamp: 'NNH 11/20/2020 18:56:21'!
products

	^ products ! !

!Receipt methodsFor: 'accessing' stamp: 'NNH 11/20/2020 18:55:17'!
total
	
	^ total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Receipt class' category: 'TusLibros'!
Receipt class
	instanceVariableNames: ''!

!Receipt class methodsFor: 'instance creation' stamp: 'NNH 11/20/2020 18:54:43'!
total: aTotal products: aCollectionOfProducts 
	
	^self new initializeTotal: aTotal products: aCollectionOfProducts ! !
