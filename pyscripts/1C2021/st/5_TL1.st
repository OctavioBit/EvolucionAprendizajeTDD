!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'test data' stamp: 'JPF 6/8/2021 19:40:04'!
isbn1
	
	^ '978-83-21221-93-0'! !

!CartTest methodsFor: 'test data' stamp: 'JPF 6/8/2021 19:47:02'!
isbn2
	
	^ '998-83-51221-93-1'! !


!CartTest methodsFor: 'tests' stamp: 'JPF 6/8/2021 20:47:32'!
test01WhenCartIsCreatedItShouldBeEmpty

	| cart |
	
	cart _ Cart withCatalogue: (Catalogue with: {}) andId: 1.
	
	self assert: cart isEmtpy! !

!CartTest methodsFor: 'tests' stamp: 'JPF 6/8/2021 20:47:59'!
test02ShouldAddABookWithAQuantityWhenItIsInTheCatalogue

	| cart book firstCartItem catalogue |
	
	catalogue _ Catalogue with: { self isbn1 }.
	cart _ Cart withCatalogue: catalogue andId: 1.
	book _ Book of: self isbn1.
	
	cart add: 2 of: book.
	
	firstCartItem _ cart items first.
	
	self deny: cart isEmtpy.
	self assert: book equals: firstCartItem book.
	self assert: 2 equals: firstCartItem quantity.
	self assert: 1 equals: cart size! !

!CartTest methodsFor: 'tests' stamp: 'JPF 6/8/2021 20:48:17'!
test03ShouldNotAddABookAndRaiseAnExceptionWhenItIsNotInTheCatalogue

	| cart book catalogue |
	
	catalogue _ Catalogue with: { self isbn1 }.
	
	cart _ Cart withCatalogue: catalogue andId: 1.
	book _ Book of: self isbn2.
	
	self
		should: [ cart add: 2 of: book ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: Cart bookIsNotInCatalgueErrorDescription equals: error messageText.
			self assert: cart isEmtpy
			]
! !

!CartTest methodsFor: 'tests' stamp: 'JPF 6/8/2021 20:48:28'!
test04ShouldNotAddABookAndRaiseAnExceptionWhenTheGivenQuantityIsNotPositive

	| cart book catalogue |
	
	catalogue _ Catalogue with: { self isbn1 }.
	
	cart _ Cart withCatalogue: catalogue andId: 1.
	book _ Book of: self isbn1.
	
	self
		should: [ cart add: 0 of: book ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: Cart quantityMustBePositiveErrorDescription equals: error messageText.
			self assert: cart isEmtpy
			]
! !

!CartTest methodsFor: 'tests' stamp: 'JPF 6/8/2021 20:48:37'!
test05ShouldAddTheQuantityWhenTheBookIsAlreadyInTheCart

	| cart book1 book2 firstCartItem secondCartItem catalogue |
	
	catalogue _ Catalogue with: { self isbn1. self isbn2 }.
	cart _ Cart withCatalogue: catalogue andId: 1.
	
	book1 _ Book of: self isbn1.
	book2 _ Book of: self isbn2.
	
	cart add: 1 of: book1.
	cart add: 2 of: book2.
	cart add: 3 of: book1.
	
	firstCartItem _ cart items first.
	secondCartItem _ cart items second.
	
	self assert: book1 equals: firstCartItem book.
	self assert: 4 equals: firstCartItem quantity.

	self assert: book2 equals: secondCartItem book.
	self assert: 2 equals: secondCartItem quantity.
	
	self assert: 2 equals: cart size.! !

!CartTest methodsFor: 'tests' stamp: 'JPF 6/8/2021 20:46:13'!
test06WhenCartIsCreatedItShouldHaveTheGivenId

	| cart |
	
	cart _ Cart withCatalogue: (Catalogue with: {}) andId: 1.
	
	self assert: cart id equals: 1.! !


!classDefinition: #Book category: 'TusLibros'!
Object subclass: #Book
	instanceVariableNames: 'isbn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Book methodsFor: 'initialization' stamp: 'JPF 6/8/2021 19:48:32'!
initializeOf: aIsbn 

	isbn := aIsbn.! !


!Book methodsFor: 'accessing' stamp: 'JPF 6/8/2021 19:50:37'!
isbn

	^isbn! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Book class' category: 'TusLibros'!
Book class
	instanceVariableNames: ''!

!Book class methodsFor: 'instance creation' stamp: 'JPF 6/8/2021 19:48:04'!
of: aIsbn

	^self new initializeOf: aIsbn! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'items catalogue id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'testing' stamp: 'JPF 6/8/2021 19:23:13'!
isEmtpy
		
		^ self size = 0! !

!Cart methodsFor: 'testing' stamp: 'JPF 6/8/2021 19:23:00'!
size
	
	^ items size! !


!Cart methodsFor: 'adding' stamp: 'JPF 6/8/2021 20:31:10'!
add: aQuantity of: aBook

	| selectedBooks |

	self assertBookIsInCatalogue: aBook.
	self assertQuantityIsPositive: aQuantity.
	
	selectedBooks _ items select: [ :item | item book = aBook ].
	
	selectedBooks
		ifEmpty: [ items add: (CartItem for: aQuantity of: aBook) ]
		ifNotEmpty: [ selectedBooks first addQuantity: aQuantity ]
	
	
	! !


!Cart methodsFor: 'items' stamp: 'JPF 6/8/2021 19:21:29'!
items
	
	^ items copy! !


!Cart methodsFor: 'initialization' stamp: 'JPF 6/8/2021 20:47:06'!
initializeWithCatalogue: aCatalogue andId: anId 

	items := OrderedCollection new.
	catalogue := aCatalogue.
	id := anId.! !


!Cart methodsFor: 'assertions' stamp: 'JPF 6/8/2021 20:09:17'!
assertBookIsInCatalogue: aBook

	^ (catalogue has: aBook isbn) ifFalse: [ self error: self class bookIsNotInCatalgueErrorDescription ]! !

!Cart methodsFor: 'assertions' stamp: 'JPF 6/8/2021 20:13:10'!
assertQuantityIsPositive: aQuantity

	^ aQuantity < 1 ifTrue: [ self error: self class quantityMustBePositiveErrorDescription ]! !


!Cart methodsFor: 'accessing' stamp: 'JPF 6/8/2021 20:44:59'!
id

	^ id! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'JPF 6/8/2021 20:46:46'!
withCatalogue: aCatalogue andId: anId

	^self new initializeWithCatalogue: aCatalogue andId: anId! !


!Cart class methodsFor: 'error descriptions' stamp: 'JPF 6/8/2021 20:03:26'!
bookIsNotInCatalgueErrorDescription

	^ 'The book is not in the catalogue'.! !

!Cart class methodsFor: 'error descriptions' stamp: 'JPF 6/8/2021 20:11:35'!
quantityMustBePositiveErrorDescription
	
	^ 'Quantity must be a positive value'! !


!classDefinition: #CartItem category: 'TusLibros'!
Object subclass: #CartItem
	instanceVariableNames: 'book quantity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartItem methodsFor: 'initialization' stamp: 'JPF 6/8/2021 19:09:49'!
initializeFor: aQuantity of: aBook

	book := aBook.
	quantity := aQuantity.! !


!CartItem methodsFor: 'accessing' stamp: 'JPF 6/8/2021 19:18:51'!
book

	^ book! !

!CartItem methodsFor: 'accessing' stamp: 'JPF 6/8/2021 19:19:00'!
quantity

	^ quantity! !


!CartItem methodsFor: 'adding quantity' stamp: 'JPF 6/8/2021 20:32:07'!
addQuantity: aQuantity
 
	quantity := quantity + aQuantity! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartItem class' category: 'TusLibros'!
CartItem class
	instanceVariableNames: ''!

!CartItem class methodsFor: 'instance creation' stamp: 'JPF 6/8/2021 19:10:37'!
for: aQuantity of: aBook
	
	^ self new initializeFor: aQuantity of: aBook! !


!classDefinition: #Catalogue category: 'TusLibros'!
Object subclass: #Catalogue
	instanceVariableNames: 'isbns'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Catalogue methodsFor: 'initialization' stamp: 'JPF 6/8/2021 19:45:18'!
initializeWith: listOfIsbns

	isbns := listOfIsbns! !


!Catalogue methodsFor: 'testing' stamp: 'JPF 6/8/2021 19:52:11'!
has: aIsbn

	^ isbns includes: aIsbn! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Catalogue class' category: 'TusLibros'!
Catalogue class
	instanceVariableNames: ''!

!Catalogue class methodsFor: 'instance creation' stamp: 'JPF 6/8/2021 19:43:46'!
with: isbns
	
	^self new initializeWith: isbns! !
