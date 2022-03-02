!classDefinition: #TestCarrito category: 'TusLibros'!
TestCase subclass: #TestCarrito
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestCarrito methodsFor: 'as yet unclassified' stamp: 'MS 6/9/2021 23:42:18'!
test01newCartIsEmpty
	| carrito |
	
	carrito := Carrito new.
	
	self assert: carrito isEmpty.! !

!TestCarrito methodsFor: 'as yet unclassified' stamp: 'MS 6/9/2021 23:42:14'!
test02cartCanAddBookWhenIncludedInCatalog
	| carrito catalogo libro |
	
	carrito := Carrito new.
	
	libro := 'isbn'.
	
	catalogo := OrderedCollection new.
	catalogo add: libro.
		
	carrito addToCart: libro amount: 1 from: catalogo.
	
	self deny: carrito isEmpty.
	self assert: carrito size = 1.
	self assert: (carrito containsBook: libro amount: 1).
	self deny: (carrito containsBook: 'otroIsbn' amount: 1).! !

!TestCarrito methodsFor: 'as yet unclassified' stamp: 'MS 6/9/2021 23:42:10'!
test03cannotAddBookAbsentInCatalog
	| carrito catalogo libro |
	
	carrito := Carrito new.
	
	libro := 'isbn'.
	
	catalogo := OrderedCollection new.
		
	self should: [carrito addToCart: libro amount: 1 from: catalogo.] raise: Error withMessageText: Carrito cannotAddBookAbsentInCatalog.
	
! !

!TestCarrito methodsFor: 'as yet unclassified' stamp: 'MS 6/9/2021 23:42:50'!
test04cartCanAddMultipleBookCopiesWhenIncludedInCatalog
	| carrito catalogo libro |
	
	carrito := Carrito new.
	
	libro := 'isbn'.
	
	catalogo := OrderedCollection new.
	catalogo add: libro.
		
	carrito addToCart: libro amount: 2 from: catalogo.
	
	self assert: carrito size = 2.
	self assert: (carrito containsBook: libro amount: 2).
	self deny: (carrito containsBook: 'otroIsbn' amount: 1).! !

!TestCarrito methodsFor: 'as yet unclassified' stamp: 'MS 6/9/2021 23:43:16'!
test05cartCanAddDifferentBooksWhenIncludedInCatalog
	| carrito catalogo libro1 libro2 |
	
	carrito := Carrito new.
	
	libro1 := 'isbn1'.
	libro2 := 'isbn2'.
	
	catalogo := OrderedCollection new.
	catalogo add: libro1.
	catalogo add: libro2.
		
	carrito addToCart: libro1 amount: 1 from: catalogo.
	carrito addToCart: libro2 amount: 1 from: catalogo.
	
	self assert: carrito size = 2.
	self assert: (carrito containsBook: libro1 amount: 1).
	self assert: (carrito containsBook: libro2 amount: 1).
	self deny: (carrito containsBook: 'isbn3' amount: 3).! !


!classDefinition: #Carrito category: 'TusLibros'!
Object subclass: #Carrito
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Carrito methodsFor: 'initialization' stamp: 'MS 6/9/2021 23:15:33'!
initialize
	books := OrderedCollection new.! !


!Carrito methodsFor: 'comparing' stamp: 'MS 6/9/2021 23:34:15'!
containsBook: aBook amount: anAmountOfCopies
	^ (books select: [:book | book = aBook]) size = anAmountOfCopies.! !

!Carrito methodsFor: 'comparing' stamp: 'MS 6/9/2021 23:16:28'!
isEmpty
	^ books isEmpty! !

!Carrito methodsFor: 'comparing' stamp: 'MS 6/9/2021 23:16:03'!
size
	^ books size.! !


!Carrito methodsFor: 'adding' stamp: 'MS 6/9/2021 23:26:13'!
addToCart: aBook amount: anAmountOfCopies from: aCatalog
	(aCatalog includes: aBook) ifFalse: [^ self error: self class cannotAddBookAbsentInCatalog ].
	
	anAmountOfCopies timesRepeat: [books add: aBook].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Carrito class' category: 'TusLibros'!
Carrito class
	instanceVariableNames: ''!

!Carrito class methodsFor: 'error' stamp: 'MS 6/9/2021 23:19:10'!
cannotAddBookAbsentInCatalog
	^ 'No se pueden agregar libros que no estén en el catálogo'! !
