!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'JR 6/9/2021 16:43:00'!
test01NewCartShouldBeEmpty

	|emptyCart emptyCatalog|
	
	emptyCatalog := OrderedCollection new.
	
	emptyCart := TusLibrosCart with: emptyCatalog.
	
	self assert: emptyCart isEmpty! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JR 6/9/2021 16:43:36'!
test02ACartKnowsBooksAddedToIt

	|aCart aBook aCatalog|
	
	aBook := 'Design Patterns'.
	aCatalog := OrderedCollection new.
	aCatalog add: aBook .
	aCart := TusLibrosCart with: aCatalog.
	
	aCart add: aBook quantity: 1.
	
	self assert: aCart books size equals: 1. 
	self assert: aCart books includes: aBook.
	self deny: aCart isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JR 6/9/2021 16:42:14'!
test03ACartKnowsMultipleBooksAddedToIt

	|aCart aCatalog|
	
	aCatalog := OrderedCollection new.
	aCatalog add: 'Design Patterns'.
	aCatalog add: 'La sombra del viento'.
	aCart := TusLibrosCart with: aCatalog .
	
	aCatalog do: [:book | aCart add: book quantity: 1].
	
	self assert: aCatalog equals: aCart books. 
	self deny: aCart isEmpty! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JR 6/9/2021 16:45:30'!
test04AddingABookThatIsNotInCatalogShouldRaiseError

	|aCart aCatalog|
	
	aCatalog := OrderedCollection new..
	aCart := TusLibrosCart with: aCatalog.
	
	self 
		should: [aCart add: 'Design Patterns' quantity: 1.]
		raise: Error
		withExceptionDo: [:anError |
			self assert: TusLibrosCart invalidBookErrorDescription equals: anError messageText.
			self assert: aCart isEmpty ]! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JR 6/9/2021 16:51:19'!
test05ListOfEmptyCartShouldBeEmpty

	|emptyCart emptyCatalog|
	
	emptyCatalog := OrderedCollection new.
	
	emptyCart := TusLibrosCart with: emptyCatalog.
	
	self assert: emptyCart listCart isEmpty ! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JR 6/9/2021 17:18:03'!
test06ListOfCartShouldIncludeItsBooksWithQuantities

	|aCart aCatalog expectedList|
	
	aCatalog := OrderedCollection new.
	expectedList := OrderedCollection new.
	aCatalog add: 'Design Patterns'.
	aCatalog add: 'La sombra del viento'.
	aCart := TusLibrosCart with: aCatalog .
	
	aCatalog do: [:book | aCart add: book quantity: 3].
	
	expectedList add: 'Design Patterns'.
	expectedList add: 3.
	expectedList add: 'La sombra del viento'.
	expectedList add: 3.
	
	self assert: expectedList equals: aCart listCart ! !


!classDefinition: #TusLibrosCart category: 'TusLibros'!
Object subclass: #TusLibrosCart
	instanceVariableNames: 'books catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosCart methodsFor: 'as yet unclassified' stamp: 'JR 6/9/2021 16:47:47'!
add: aBook quantity: aQuantity
	
	aQuantity timesRepeat: [
		(catalog includes: aBook) ifTrue: [books add: aBook] ifFalse: 
		[self error: self class invalidBookErrorDescription ] ]! !

!TusLibrosCart methodsFor: 'as yet unclassified' stamp: 'JR 6/9/2021 16:18:40'!
books
	
	^books ! !

!TusLibrosCart methodsFor: 'as yet unclassified' stamp: 'JR 6/9/2021 16:20:46'!
isEmpty

	^books isEmpty ! !

!TusLibrosCart methodsFor: 'as yet unclassified' stamp: 'JR 6/9/2021 17:22:54'!
listCart

	|list|
	
	list := OrderedCollection new.
	
	books do: [:book | (list includes: book) ifTrue: [self modifyNextElementOf: book in: list]
			ifFalse: [list add: book.
				list add: 1.] ].
		
	^list! !

!TusLibrosCart methodsFor: 'as yet unclassified' stamp: 'JR 6/9/2021 17:26:19'!
modifyNextElementOf: book in: list
	
	|indexOfElement|
	
	indexOfElement := list indexOf: book.
	
	list at: (indexOfElement +1) put: ((list at: (indexOfElement +1)) +1).
	
	^list
	! !


!TusLibrosCart methodsFor: 'initialization' stamp: 'JR 6/9/2021 16:48:33'!
initializeWith: aCatalog
	
	books := OrderedCollection new.
	catalog := aCatalog ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosCart class' category: 'TusLibros'!
TusLibrosCart class
	instanceVariableNames: ''!

!TusLibrosCart class methodsFor: 'as yet unclassified' stamp: 'JR 6/9/2021 16:46:09'!
invalidBookErrorDescription

	^'El libro no está en el catálogo'! !


!TusLibrosCart class methodsFor: 'instance creation' stamp: 'JR 6/9/2021 16:48:17'!
with: aCatalog

	^self new initializeWith: aCatalog ! !
