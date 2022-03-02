!classDefinition: #CartTests category: #'Ejercicio - TusLibros.com'!
TestCase subclass: #CartTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio - TusLibros.com'!

!CartTests methodsFor: 'cart tests' stamp: 'FG 11/18/2020 18:24:29'!
test01NewCartShouldBeEmpty

	| cart catalogue |
	
	catalogue := Set new.
	cart := Cart with: catalogue.
	
	self assert: cart isEmpty. ! !

!CartTests methodsFor: 'cart tests' stamp: 'FG 11/18/2020 18:24:54'!
test02CartWithABookShouldNotBeEmpty

	| cart catalogue book |
	
	book := 'Book'.
	catalogue := Set with: book.
	
	cart := Cart with: catalogue.
	
	cart add: 10 of: book.
	
	self assert: cart isEmpty not. ! !

!CartTests methodsFor: 'cart tests' stamp: 'FG 11/18/2020 18:26:17'!
test03EmptyCartDoesntHasABook

	| cart catalogue book |
	
	book := 'Book'.
	catalogue := Set with: book.
	
	cart := Cart with: catalogue.
	
	self assert: (cart has: book) not.! !

!CartTests methodsFor: 'cart tests' stamp: 'FG 11/18/2020 18:28:49'!
test04CartShouldHaveAddedBook

	| cart catalogue book |
	
	book := 'Book'.
	catalogue := Set with: book.
	
	cart := Cart with: catalogue.
	
	cart add: 10 of: book. 
	
	self assert: (cart has: book).! !

!CartTests methodsFor: 'cart tests' stamp: 'FG 11/18/2020 18:27:59'!
test05CartShouldNotHaveNonAddedBook

	| cart catalogue historyBook mathBook |
	
	mathBook := 'MathBook'.
	historyBook := 'HistoryBook'.
	catalogue := Set with: mathBook with: historyBook.
	
	cart := Cart with: catalogue.
	
	cart add: 10 of: historyBook. 
	
	self assert: (cart has: mathBook) not.
	! !

!CartTests methodsFor: 'cart tests' stamp: 'FG 11/18/2020 18:31:53'!
test06CartShouldAnswerQuantityOfAnAddedBook

	| cart catalogue historyBook mathBook|
	
	historyBook := 'HistoryBook'.
	mathBook := 'MathBook'.
	catalogue := Set with: mathBook with: historyBook.
	
	cart := Cart with: catalogue.
		
	cart add: 100 of: historyBook.
	cart add: 50 of: mathBook. 
	
	self assert: (cart quantityOf: historyBook) equals: 100.
	self assert: (cart quantityOf: mathBook) equals: 50.
	! !

!CartTests methodsFor: 'cart tests' stamp: 'FG 11/18/2020 18:33:28'!
test07CartShouldProperlyAddMoreCopiesOfAnAlreadyAddedBook

	| cart catalogue book|
	
	book := 'Book'.
	catalogue := Set with: book.
	
	cart := Cart with: catalogue .
		
	cart add: 50 of: book. 
	cart add: 150 of: book.
		
	self assert: (cart quantityOf: book) equals: 200.! !

!CartTests methodsFor: 'cart tests' stamp: 'FG 11/18/2020 18:34:18'!
test08CartShouldBeAbleToAnswerWhatBooksItHas

	| cart catalogue mathBook historyBook|
	
	mathBook := 'MathBook'.
	historyBook := 'HistoryBook'.		
	
	catalogue := Set with: mathBook with: historyBook.
	
	cart := Cart with: catalogue.
	
	cart add: 50 of: mathBook.
		
	self assert: cart books size equals: 50.
	self assert: (cart books includes: mathBook).
	
	cart add: 100 of: historyBook.
	
	self assert: cart books size equals: 150.
	self assert: (cart books includes: historyBook).
	! !

!CartTests methodsFor: 'cart tests' stamp: 'FG 11/18/2020 18:34:35'!
test09CartCantAddBookThatAreNotInTheCatalogue

	| cart catalogue mathBook historyBook|
	
	mathBook := 'MathBook'.
	historyBook := 'HistoryBook'.	
	
	catalogue := Set with: mathBook.
	cart := Cart with: catalogue.
	
	[cart add: 100 of: historyBook. self fail]
		on: Error
		do: [:anError | self assert: anError messageText equals: Cart cantAddBooksThatAreNotInTheCatalogue. ].	
! !


!classDefinition: #Cart category: #'Ejercicio - TusLibros.com'!
Object subclass: #Cart
	instanceVariableNames: 'books catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio - TusLibros.com'!

!Cart methodsFor: 'adding' stamp: 'FG 11/18/2020 18:21:15'!
add: aQuantity of: aBook 

	(catalogue includes: aBook) ifFalse: [self error: Cart cantAddBooksThatAreNotInTheCatalogue].
	
	^ books add: aBook withOccurrences: aQuantity.! !


!Cart methodsFor: 'accesing' stamp: 'FG 11/18/2020 17:46:38'!
books
	^ books copy.! !

!Cart methodsFor: 'accesing' stamp: 'FG 11/16/2020 19:15:54'!
has: aBook
	^ books includes: aBook.! !

!Cart methodsFor: 'accesing' stamp: 'FG 11/16/2020 19:15:27'!
isEmpty
	^ books isEmpty.! !

!Cart methodsFor: 'accesing' stamp: 'FG 11/16/2020 19:26:32'!
quantityOf: aBook
	^ books occurrencesOf: aBook.! !


!Cart methodsFor: 'initialization' stamp: 'FG 11/18/2020 18:02:03'!
initializeWith: aCatalogue

	catalogue := aCatalogue.
	books := Bag new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'Ejercicio - TusLibros.com'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'intialization' stamp: 'FG 11/18/2020 18:01:21'!
with: aCatalogue
	^ self basicNew initializeWith: aCatalogue.! !


!Cart class methodsFor: 'error checking' stamp: 'FG 11/18/2020 18:05:15'!
cantAddBooksThatAreNotInTheCatalogue
	^ 'Cant add book because is not in the catalogue'.! !
