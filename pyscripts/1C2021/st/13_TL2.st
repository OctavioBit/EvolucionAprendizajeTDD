!classDefinition: #Xxxxxx category: 'TusLibros'!
TestCase subclass: #Xxxxxx
	instanceVariableNames: 'aValidCreditCard anExpiredCreditCard merchantProcessorSimulator aFundlessCreditCard aMerchantProcessorSimulation aStolenCreditCard aFakeCreditCard aBookIsbn1 today yesterday'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Xxxxxx methodsFor: 'setUp/tearDown' stamp: 'E.V 6/14/2021 19:32:46'!
setUp
today _ FixedGregorianDate today.
yesterday _ FixedGregorianDate yesterday .

aValidCreditCard _ CreditCard number: '1234567891234567' owner:'Santiago Corley' expirationDate: today.
anExpiredCreditCard _ CreditCard number: '1234567891234568' owner:'Enzo Vigneti' expirationDate: yesterday.
aStolenCreditCard _ CreditCard number: '1234567891234569' owner:'Santiago Corley' expirationDate: today.
aFakeCreditCard  _ CreditCard number: '1234567891234561' owner:'Santiago Corley' expirationDate: today.
aFundlessCreditCard _ CreditCard number: '1234567891234562' owner:'Enzo Vigneti' expirationDate: today.

aMerchantProcessorSimulation _ MerchantProcessorSimulator new fundlessCard: aFundlessCreditCard; stolenCard:aStolenCreditCard; fakeCard: aFakeCreditCard.

aBookIsbn1  _ 'isbn1'.! !


!classDefinition: #CartTest category: 'TusLibros'!
Xxxxxx subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'test' stamp: 'E.V 6/11/2021 14:54:38'!
test01createdCartIsEmpty
	|cart|
	cart _ Cart newWith:(Dictionary new).
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'test' stamp: 'E.V 6/11/2021 14:55:18'!
test02WhenAddingABookToEmptyCartItOnlyContainsThatBook
	|cart aBook|
	aBook _ 'isbn1'.
	cart _ Cart newWith: (Dictionary with: aBook -> 10).
	cart add: aBook.
	self deny: cart isEmpty.
	self assert: cart includes: aBook.
	self assert: cart amoutOfBooks equals: 1.! !

!CartTest methodsFor: 'test' stamp: 'E.V 6/11/2021 14:55:45'!
test03WhenAddingMultipleBooksToEmptyCartItContainsThoseBooks
	|cart aBook1 aBook2|
	aBook1 _ 'isbn1'.
	aBook2 _ 'isbn2'.
	cart _ Cart newWith: (Dictionary  with: aBook1->10 with: aBook2->20 ).
	cart add: aBook1.
	cart add: aBook2.
	self assert: cart includes: aBook1.
	self assert: cart includes: aBook2.
	self assert: cart amoutOfBooks equals: 2.! !

!CartTest methodsFor: 'test' stamp: 'E.V 6/11/2021 14:55:58'!
test04AddingSameBookMultipleTimesContainsMultipleCopiesOfthatBook
	|cart aBook|
	aBook _ 'isbn1'.
	cart _ Cart newWith: (Dictionary  with: aBook->10).
	cart add: aBook.
	cart add: aBook.
	cart add: aBook.
	self assert: (cart quantityOf: aBook) equals: 3.
	self assert: cart amoutOfBooks equals: 3.! !

!CartTest methodsFor: 'test' stamp: 'E.V 6/11/2021 14:56:29'!
test05CantAddBookThatWeDoNotWantToSell
	|cart anUnavaibleBook |
	anUnavaibleBook _ 'isbn1'.
	cart _ Cart newWith: (Dictionary new).
	self should:[cart add: anUnavaibleBook.]
	raise: Error
	 withExceptionDo:[:anError| self assert: anError messageText  equals: Cart cantAddBookNotForSaleErrorDescription] ! !

!CartTest methodsFor: 'test' stamp: 'E.V 6/11/2021 14:56:42'!
test06ListingCartElementsOfEmptyCartReturnsEmptyReport
	|cart  |

	cart _ Cart newWith: Dictionary  new.
	self assert: (cart list isEmpty)! !

!CartTest methodsFor: 'test' stamp: 'E.V 6/11/2021 14:57:14'!
test07ListingCartElementsOfCartWithABookReturnsCorrectReport
	|cart aBook |
	"El mensaje ISBN no está implementado, es temporal"
	aBook _ 'isbn1'.
	cart _ Cart newWith: (Dictionary  with: aBook->10).
	cart add: aBook.
	self assert: (cart list) equals: (OrderedCollection with: aBook  with: 1).! !

!CartTest methodsFor: 'test' stamp: 'E.V 6/11/2021 14:57:43'!
test08ListingCartElementsOfCartWithTwoBookCopiesReturnsCorrectReport
	|cart aBook |
	"El mensaje ISBN no está implementado, es temporal"
	aBook _ 'isbn1'.
	cart _ Cart newWith: (Dictionary  with: aBook -> 10).
	cart add: aBook.
	cart add: aBook.
	self assert: (cart list) equals: (OrderedCollection with: aBook with: 2).! !


!classDefinition: #CashierTest category: 'TusLibros'!
Xxxxxx subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!CashierTest methodsFor: 'aux' stamp: 'E.V 6/14/2021 21:05:54'!
tryToCheckOutWith:aCreditCard andFailWithError:anErrorDescription
|aCart aCashier aCatalog salesBook |

	salesBook _ OrderedCollection new.	

	aCatalog _ Dictionary with: aBookIsbn1 -> 10 .
	aCart  _ Cart newWith:(aCatalog).
	aCashier _ Cashier newWith: (aMerchantProcessorSimulation).
	aCart add: aBookIsbn1.
	
	
	self should:[ salesBook add: (aCashier checkOut: aCart payingWith:aCreditCard On: today )]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError | self assert: anError messageText equals: 
						anErrorDescription ].
					
	self assert: salesBook isEmpty .
	! !


!CashierTest methodsFor: 'test' stamp: 'E.V 6/14/2021 20:55:59'!
test01CheckingOutEmptyCartRaisesError
	|aCart aCashier salesBook |
	salesBook _ OrderedCollection new.
	aCart  _ Cart newWith:(OrderedCollection new).
	aCashier _ Cashier newWith: MerchantProcessorSimulator new.
	
	
	self should:[salesBook add: (aCashier checkOut: aCart payingWith:aValidCreditCard On:  today).]
	raise: Error - MessageNotUnderstood
	withExceptionDo:[:anError | self assert:  anError messageText equals:
									 Cashier cantCheckOutAEmptyCartErrorDescription].
	
	self assert: salesBook isEmpty ! !

!CashierTest methodsFor: 'test' stamp: 'E.V 6/14/2021 20:50:33'!
test02CheckingOutACartWithOneItemReturnsATotalEqualToTheItemPrice
	|aCart aCashier aCatalog salesBook |
	
	salesBook _ OrderedCollection new.
	aCatalog _ Dictionary new.
	aCatalog add: aBookIsbn1 -> 10.
	aCart  _ Cart newWith:(aCatalog).
	aCashier _ Cashier newWith: MerchantProcessorSimulator new.
	
	aCart add: aBookIsbn1 .

	salesBook add: ( aCashier checkOut: aCart payingWith:aValidCreditCard On:  today).
	
	self assert: salesBook includes: 10.
	self assert: salesBook size equals:1.

	! !

!CashierTest methodsFor: 'test' stamp: 'E.V 6/14/2021 20:57:30'!
test03CheckingOutACartWithMultipleCopiesOfOneItemReturnsATotalEqualToTheItemPrice
	|aCart aCashier aCatalog salesBook |
	
	salesBook _ OrderedCollection new.
	
	aCatalog _ Dictionary new.
	aCatalog add: aBookIsbn1 -> 10.
	aCart  _ Cart newWith:(aCatalog).
	aCashier _ Cashier newWith: MerchantProcessorSimulator new.
	
	aCart add: aBookIsbn1.
	aCart add: aBookIsbn1.

	salesBook add: (aCashier checkOut: aCart payingWith:aValidCreditCard On:  today).
	self assert: salesBook includes: 20.
	self assert: salesBook size equals: 1.

	! !

!CashierTest methodsFor: 'test' stamp: 'E.V 6/14/2021 21:05:05'!
test04CheckingOutACartWithAnExpiredCreditCardRaisesError
	
	self tryToCheckOutWith:anExpiredCreditCard andFailWithError: Cashier cantProcessAnExpiredCreditCardErrorDescription 
	! !

!CashierTest methodsFor: 'test' stamp: 'E.V 6/14/2021 21:03:56'!
test05CheckingOutACartWithAFundlessCreditCardRaisesError
	
	self tryToCheckOutWith:aFundlessCreditCard andFailWithError: MerchantProcessorSimulator cantProcessAFundlessCreditCardErrorDescription 
	! !

!CashierTest methodsFor: 'test' stamp: 'E.V 6/14/2021 21:03:40'!
test06CheckingOutACartWithAStolenCreditCardRaisesError

	self tryToCheckOutWith:aStolenCreditCard andFailWithError: MerchantProcessorSimulator cantProcessAStolenCreditCardErrorDescription 
	! !

!CashierTest methodsFor: 'test' stamp: 'E.V 6/14/2021 21:03:19'!
test07CheckingOutACartWithAFakeCreditCardRaisesError


	self tryToCheckOutWith:aFakeCreditCard andFailWithError: MerchantProcessorSimulator cantProcessAFakeCreditCardErrorDescription 
	

	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'testing' stamp: 'sc 6/9/2021 14:56:01'!
includes: aBook 
	^books includes: aBook ! !

!Cart methodsFor: 'testing' stamp: 'sc 6/9/2021 14:55:16'!
isEmpty
	^books isEmpty.! !


!Cart methodsFor: 'initialization' stamp: 'E.V 6/11/2021 14:45:28'!
initializeWith: aCatalog
	books _ OrderedCollection new.
	catalog _ aCatalog.! !


!Cart methodsFor: 'error' stamp: 'E.V 6/11/2021 14:53:57'!
raiseErrorIfBookIsNotForSale: aBook
	(catalog includesKey: aBook) ifFalse: [self error: self class cantAddBookNotForSaleErrorDescription].
	! !


!Cart methodsFor: 'operations' stamp: 'sc 6/9/2021 16:00:57'!
add: aBook 
	self raiseErrorIfBookIsNotForSale: aBook.
	books add: aBook.! !

!Cart methodsFor: 'operations' stamp: 'sc 6/9/2021 16:31:01'!
add: aBook WithAparitionsIfNotIncludedIn: listedElements
	(listedElements includes: aBook) ifFalse:
						[listedElements add: aBook. 
						listedElements add: (books occurrencesOf: aBook) ].
		! !

!Cart methodsFor: 'operations' stamp: 'sc 6/9/2021 14:56:26'!
amoutOfBooks
	^books size.! !

!Cart methodsFor: 'operations' stamp: 'sc 6/9/2021 16:29:01'!
list
	|listedElements|
	listedElements _ OrderedCollection new.
	
	books do: [:aBook| self add: aBook WithAparitionsIfNotIncludedIn: listedElements ].
	^listedElements.
	! !

!Cart methodsFor: 'operations' stamp: 'sc 6/9/2021 15:33:51'!
quantityOf: aBook 
	^ books occurrencesOf: aBook.! !

!Cart methodsFor: 'operations' stamp: 'E.V 6/11/2021 14:48:36'!
totalPrice
	^ books sum: [:aBook | catalog at: aBook].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'E.V 6/11/2021 14:50:37'!
newWith: aCataloge 
	^self new initializeWith: aCataloge ! !


!Cart class methodsFor: 'error descriptions' stamp: 'sc 6/9/2021 16:00:01'!
cantAddBookNotForSaleErrorDescription
	^'Si no lo vendemo mirá si vas a poder ponerlo en el carro papá'! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'processing' stamp: 'E.V 6/14/2021 18:44:39'!
checkOut: aCart payingWith: aCreditCard On: aDate 
        |aTotalPurchaseValue | 
	self raiseCantCheckOutAnEmptyCart:aCart.
	self raiseErrorIF: aCreditCard IsExpiredOn: aDate.
	aTotalPurchaseValue  _ aCart totalPrice.
	merchantProcessor processPurchaseFor:aTotalPurchaseValue payingWith:aCreditCard .
	^ aTotalPurchaseValue
! !

!Cashier methodsFor: 'processing' stamp: 'E.V 6/11/2021 15:18:47'!
priceOf: aBook 
	^ merchantProcessor at: aBook! !

!Cashier methodsFor: 'processing' stamp: 'E.V 6/14/2021 19:10:48'!
raiseErrorIF: aCreditCard IsExpiredOn: aDate

	 (aCreditCard isExpiredOn:aDate) ifTrue:[ self error: self class cantProcessAnExpiredCreditCardErrorDescription ]! !


!Cashier methodsFor: 'error' stamp: 'E.V 6/10/2021 20:17:12'!
raiseCantCheckOutAnEmptyCart: aCart
	aCart isEmpty ifTrue: [self error: self class cantCheckOutAEmptyCartErrorDescription] .! !


!Cashier methodsFor: 'initialization' stamp: 'E.V 6/11/2021 15:18:46'!
initializeWith: aMerchantProcessor 
	merchantProcessor := aMerchantProcessor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error' stamp: 'E.V 6/10/2021 20:01:47'!
cantCheckOutAEmptyCartErrorDescription
	^ ' La proxima que vayas a hacer compras y no lleves nada no salgas de tu casa papá, no ves que estamos en pandemia?!!?!!?!!?!!? '! !

!Cashier class methodsFor: 'error' stamp: 'E.V 6/14/2021 19:07:52'!
cantProcessAnExpiredCreditCardErrorDescription
	^ 'Che amigo esta tarjeta esta mas vencida que las manaos de uva que tengo en el almacen'! !


!Cashier class methodsFor: 'instance creation' stamp: 'E.V 6/10/2021 20:14:26'!
newWith: aDictionary 

	^self new initializeWith: aDictionary ! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'owner creditCardNumber expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'E.V 6/14/2021 18:54:34'!
initializeWithNumber: aCreditCardNumber owner:aName expirationDate: anExpirationDate.
	creditCardNumber  _ aCreditCardNumber .
	owner  _ aName .
	expirationDate  _ anExpirationDate .
	 ! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'E.V 6/14/2021 19:11:27'!
isExpiredOn: aDate
	^ expirationDate < aDate! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'E.V 6/14/2021 19:26:52'!
invalidDataErrorDescription
	^'Datos de creacion de tarjeta invalidos'
! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'E.V 6/14/2021 19:27:55'!
number: aCreditCardNumber owner:aName expirationDate: anExpirationDate.
	
	
	self raiseErrorIfIsInvalidName: aName.
	self raiseErrorIfIsInvalidNumber: aCreditCardNumber .	
		
	 ^self new initializeWithNumber: aCreditCardNumber owner:aName expirationDate: anExpirationDate.
! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'E.V 6/14/2021 19:29:38'!
raiseErrorIfIsInvalidName: aName
	aName = '' ifTrue: [self error: self invalidDataErrorDescription].
 	((aName occurrencesOf: ' ') = aName size) ifTrue:[self error: self invalidDataErrorDescription].! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'E.V 6/14/2021 19:29:49'!
raiseErrorIfIsInvalidNumber: aCreditCardNumber
	aCreditCardNumber size ~= 16 ifTrue:[self error: self invalidDataErrorDescription].! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'fundlessCreditCard aStolenCreditCard aFakeCreditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'processing' stamp: 'E.V 6/14/2021 19:30:14'!
processPurchaseFor: aTotalPrice payingWith: aCreditCard 
	self raiseCantProcessAFundlessCreditCardError: aCreditCard.
	self raiseCantProcessAStolenCreditCardError: aCreditCard.
	self raiseCantProcessAFakeCreditCardError: aCreditCard ! !


!MerchantProcessorSimulator methodsFor: 'error' stamp: 'E.V 6/11/2021 16:16:15'!
raiseCantProcessAFakeCreditCardError: aCreditCard 
	aFakeCreditCard = aCreditCard ifTrue:[self error: self class cantProcessAFakeCreditCardErrorDescription ]! !

!MerchantProcessorSimulator methodsFor: 'error' stamp: 'E.V 6/14/2021 19:34:16'!
raiseCantProcessAFundlessCreditCardError: aCreditCard 

fundlessCreditCard = aCreditCard ifTrue:[self error: self class cantProcessAFundlessCreditCardErrorDescription ]! !

!MerchantProcessorSimulator methodsFor: 'error' stamp: 'E.V 6/11/2021 16:09:42'!
raiseCantProcessAStolenCreditCardError: aCreditCard 
	aStolenCreditCard = aCreditCard ifTrue:[self error: self class cantProcessAStolenCreditCardErrorDescription ]! !


!MerchantProcessorSimulator methodsFor: 'set' stamp: 'E.V 6/11/2021 15:39:13'!
expiredCard: aCreditCard
	anExpiredCreditCard _ aCreditCard .! !

!MerchantProcessorSimulator methodsFor: 'set' stamp: 'E.V 6/11/2021 16:15:24'!
fakeCard: aCreditCard
  		aFakeCreditCard _ aCreditCard ! !

!MerchantProcessorSimulator methodsFor: 'set' stamp: 'E.V 6/11/2021 15:48:56'!
fundlessCard: aCreditCard
	fundlessCreditCard _ aCreditCard ! !

!MerchantProcessorSimulator methodsFor: 'set' stamp: 'E.V 6/11/2021 16:03:34'!
stolenCard: aCreditCard
	aStolenCreditCard _ aCreditCard .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: 'TusLibros'!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'error' stamp: 'E.V 6/11/2021 16:17:24'!
cantProcessAFakeCreditCardErrorDescription
	^ ' Che amigo la sube sirve para el bondi nomas.'! !

!MerchantProcessorSimulator class methodsFor: 'error' stamp: 'E.V 6/11/2021 15:56:51'!
cantProcessAFundlessCreditCardErrorDescription
	^ 'Uh mil disculpas boludo, se ve que en esta no tenes nada. Sabemos que esta dificil el tema, ojala te puedas levantar.'.! !

!MerchantProcessorSimulator class methodsFor: 'error' stamp: 'E.V 6/11/2021 16:04:43'!
cantProcessAStolenCreditCardErrorDescription
	^ 'En 15 llega la yuta, raja de aca'! !


!classDefinition: #TestObjectGenerator category: 'TusLibros'!
Object subclass: #TestObjectGenerator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!
