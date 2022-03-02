!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'catalogue1'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'nt 11/18/2020 17:29:42'!
setUp
	catalogue1:= OrderedCollection new.
	catalogue1 add: 12345.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'nt 11/18/2020 17:30:50'!
test01CartIsEmptyWhenCreated
	|Cart1 |
	
	Cart1:= Cart newWithId:123 and:catalogue1.
	
	self assert:Cart1 listProductsInCart isEmpty! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'nt 11/18/2020 17:31:28'!
test02AddBookToCart
	|Cart1 aBook1 |
	Cart1:= Cart newWithId:123 and: catalogue1.
	aBook1:=12345.
	Cart1 add:aBook1 quantity:1.
	self assert:Cart1 listProductsInCart size=1.
	self assert:(Cart1 listProductsInCart allSatisfy: [:aBookAndAQuantity|aBookAndAQuantity =(aBook1@1)]).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'nt 11/18/2020 17:31:55'!
test03AddBookToCartWithInvalidQuantity
	|Cart1 aBook1 |
	
	Cart1:= Cart newWithId:123 and: catalogue1.
	aBook1:=12345.
	
	self should:[Cart1 add:aBook1 quantity:0.]
	raise: Error
	withExceptionDo:[:anError|self assert:(anError messageText= Cart invalidQuantityOfProductsErrorDescription )].
	! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'nt 11/18/2020 17:44:55'!
test04AddBookThatIsNotInCatalogueToCart
	|Cart1 aBook1 |
	
	Cart1:= Cart newWithId:123 and: catalogue1.
	aBook1:=22356.
	
	self should:[Cart1 add:aBook1 quantity:1.]
	raise: Error
	withExceptionDo:[:anError|self assert:(anError messageText= Cart ISBNisNotInCatalogueErrorDescription )].
	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'items iD catalogue timer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'nt 11/18/2020 18:28:21'!
add:aBook quantity:aQuantity
self validateBookInCatalogue:aBook.
self validateQuantity:aQuantity.
self validateTimer.
items add: aBook@aQuantity.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'nt 11/18/2020 18:01:50'!
initializeWith:aCartId and:aCatalogue
	items:= Bag new.
	iD:=aCartId.
	catalogue:=aCatalogue. 
	timer:=Time now  
	
! !

!Cart methodsFor: 'as yet unclassified' stamp: 'nt 11/18/2020 18:43:53'!
listProductsInCart
self validateTimer.
^items copy.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'nt 11/18/2020 17:45:31'!
validateBookInCatalogue:aBook.
	(catalogue includes:aBook) ifFalse:[self error:Cart ISBNisNotInCatalogueErrorDescription ].! !

!Cart methodsFor: 'as yet unclassified' stamp: 'nt 11/18/2020 17:05:07'!
validateQuantity:aQuantity
	(aQuantity >= 1) ifFalse:[ self error: Cart invalidQuantityOfProductsErrorDescription]! !

!Cart methodsFor: 'as yet unclassified' stamp: 'nt 11/18/2020 18:41:52'!
validateTimer
	((Time now -timer) minutes < Cart maxTime minutes  ) ifFalse:[self error: Cart expiredTimeErrorMessage] .
	timer:= Time now.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'creation' stamp: 'nt 11/18/2020 18:06:20'!
maxTime
^Duration days:0 hours:0 minutes:30 seconds:0
	! !

!Cart class methodsFor: 'creation' stamp: 'nt 11/18/2020 17:20:08'!
newWithId: aCartId and:aCatalogue
	^self new initializeWith:aCartId and:aCatalogue.! !


!Cart class methodsFor: 'as yet unclassified' stamp: 'nt 11/18/2020 17:36:33'!
ISBNisNotInCatalogueErrorDescription
	'El libro que quiere agregar no pertenece a la editorial'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'nt 11/18/2020 18:13:36'!
expiredTimeErrorMessage
	'El tiempo para agregar productos al carrito expiró'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'nt 11/18/2020 17:05:50'!
invalidQuantityOfProductsErrorDescription
	' La cantidad de productos debe ser mayor o igual a uno'! !
