!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'test' stamp: 'sc 6/9/2021 14:39:05'!
test01createdCartIsEmpty
	|cart|
	cart _ Cart new.
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'test' stamp: 'sc 6/9/2021 16:04:13'!
test02WhenAddingABookToEmptyCartItOnlyContainsThatBook
	|cart aBook|
	aBook _ Book new. 
	cart _ Cart newWith: (OrderedCollection  with: aBook).
	cart add: aBook.
	self deny: cart isEmpty.
	self assert: cart includes: aBook.
	self assert: cart amoutOfBooks equals: 1.! !

!CartTest methodsFor: 'test' stamp: 'sc 6/9/2021 16:04:33'!
test03WhenAddingMultipleBooksToEmptyCartItContainsThoseBooks
	|cart aBook1 aBook2|
	aBook1 _ Book new.
	aBook2 _ Book new.
	cart _ Cart newWith: (OrderedCollection  with: aBook1 with: aBook2 ).
	cart add: aBook1.
	cart add: aBook2.
	self assert: cart includes: aBook1.
	self assert: cart includes: aBook2.
	self assert: cart amoutOfBooks equals: 2.! !

!CartTest methodsFor: 'test' stamp: 'sc 6/9/2021 16:04:50'!
test04AddingSameBookMultipleTimesContainsMultipleCopiesOfthatBook
	|cart aBook|
	aBook _ Book new.
	cart _ Cart newWith: (OrderedCollection  with: aBook).
	cart add: aBook.
	cart add: aBook.
	cart add: aBook.
	self assert: (cart quantityOf: aBook) equals: 3.
	self assert: cart amoutOfBooks equals: 3.! !

!CartTest methodsFor: 'test' stamp: 'sc 6/9/2021 15:57:15'!
test05CantAddBookThatWeDoNotWantToSell
	|cart anUnavaibleBook avaibleBookCollection|
	anUnavaibleBook _ Book new.
	avaibleBookCollection  _ OrderedCollection  new.
	cart _ Cart newWith: avaibleBookCollection.
	self should:[cart add: anUnavaibleBook.]
	raise: Error
	 withExceptionDo:[:anError| self assert: anError messageText  equals: Cart cantAddBookNotForSaleErrorDescription] ! !

!CartTest methodsFor: 'test' stamp: 'sc 6/9/2021 16:13:06'!
test06ListingCartElementsOfEmptyCartReturnsEmptyReport
	|cart  |

	cart _ Cart newWith: OrderedCollection  new.
	self assert: (cart list isEmpty)! !

!CartTest methodsFor: 'test' stamp: 'sc 6/9/2021 16:18:34'!
test07ListingCartElementsOfCartWithABookReturnsCorrectReport
	|cart aBook |
	"El mensaje ISBN no está implementado, es temporal"
	aBook _ Book new.
	cart _ Cart newWith: (OrderedCollection  with: aBook).
	cart add: aBook.
	self assert: (cart list) equals: (OrderedCollection with: aBook ISBN with: 1).! !

!CartTest methodsFor: 'test' stamp: 'sc 6/9/2021 16:21:50'!
test08ListingCartElementsOfCartWithTwoBookCopiesReturnsCorrectReport
	|cart aBook |
	"El mensaje ISBN no está implementado, es temporal"
	aBook _ Book new.
	cart _ Cart newWith: (OrderedCollection  with: aBook).
	cart add: aBook.
	cart add: aBook.
	self assert: (cart list) equals: (OrderedCollection with: aBook ISBN with: 2).! !


!classDefinition: #Book category: 'TusLibros'!
Object subclass: #Book
	instanceVariableNames: 'isbn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Book methodsFor: 'accesing' stamp: 'sc 6/9/2021 16:16:27'!
ISBN! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books avaibleBooks'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'testing' stamp: 'sc 6/9/2021 14:56:01'!
includes: aBook 
	^books includes: aBook ! !

!Cart methodsFor: 'testing' stamp: 'sc 6/9/2021 14:55:16'!
isEmpty
	^books isEmpty.! !


!Cart methodsFor: 'initialization' stamp: 'sc 6/9/2021 15:44:51'!
initialize
	books _ OrderedCollection new.! !

!Cart methodsFor: 'initialization' stamp: 'sc 6/9/2021 15:58:35'!
initializeWith: avaibleBookCollection
	books _ OrderedCollection new.
	avaibleBooks _ avaibleBookCollection.! !


!Cart methodsFor: 'error' stamp: 'sc 6/9/2021 16:06:10'!
raiseErrorIfBookIsNotForSale: aBook
	(avaibleBooks includes: aBook) ifFalse: [self error: self class cantAddBookNotForSaleErrorDescription].
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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'sc 6/9/2021 15:58:09'!
newWith: anOrderedCollection 
	^self new initializeWith: anOrderedCollection ! !


!Cart class methodsFor: 'error descriptions' stamp: 'sc 6/9/2021 16:00:01'!
cantAddBookNotForSaleErrorDescription
	^'Si no lo vendemo mirá si vas a poder ponerlo en el carro papá'! !


!classDefinition: #NameOfSubclass category: 'TusLibros'!
Object subclass: #NameOfSubclass
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!
!NameOfSubclass commentStamp: '<historical>' prior: 0!
Primer test, el carrito recién creado está vacio (isEmpty devuelve true). El carrito no conoce al usuario.
!

