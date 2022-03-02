!classDefinition: #CartTest category: 'LosLibros- Excersice'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'LosLibros- Excersice'!

!CartTest methodsFor: 'testing' stamp: 'CS 6/10/2021 15:39:48'!
test01AssertNewCartCreatedIsEmpty

	| cart |
	
	cart := self createCart.
	
	self assert: cart isEmpty! !

!CartTest methodsFor: 'testing' stamp: 'CS 6/10/2021 15:05:59'!
test02AssertTheCartIsNotEmptyWhenAddABook

	| cart book |
	
	cart := self createCart.

	book := 'Desing Patterns'.
	cart addToCart: book withQuantity: 1.

	self deny: cart isEmpty.! !

!CartTest methodsFor: 'testing' stamp: 'CS 6/10/2021 16:00:26'!
test03AssertTheCartAddMoreThanOneProduct

	|cart book quantityBook |
	
	cart := self createCart.

	book := 'Desing Patterns'.
	quantityBook := 2.
	cart addToCart: book withQuantity: quantityBook.
	
	self assert: ((cart list) at: book) equals: quantityBook.! !

!CartTest methodsFor: 'testing' stamp: 'CS 6/10/2021 16:24:21'!
test04CanNotAddProductsWithNegativeOrZeroQuantity

self canNotAddProductsWithInvalidQuantityThrowError:
	[:cart :book | self should: [  cart addToCart: book withQuantity: -1.]
        				   raise: Error
        				   withExceptionDo: [ :anError |
            							self assert: anError messageText = Cart
												errorDescribesCanNotAddProductsWithNegativeOrZeroQuantity.
            							self assert: cart isEmpty].]
! !

!CartTest methodsFor: 'testing' stamp: 'CS 6/10/2021 16:17:44'!
test05CanNotAddProductsThatDoNotBelongeToTheCatalogue

	|cart bookOutOfCatalogue quantityBook |

	cart := self createCart.
	
	bookOutOfCatalogue := 'Introduction to algorithms'.
	quantityBook := 1.
		
	self 	should: [cart addToCart: bookOutOfCatalogue withQuantity: quantityBook]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart errorDescribesCanNotAddProductsThatDoNotBelongeToTheCatalogue.
			self assert: cart isEmpty].! !

!CartTest methodsFor: 'testing' stamp: 'CS 6/10/2021 16:21:23'!
test06CanNotAddProductsWithFractionQuantity

	self canNotAddProductsWithInvalidQuantityThrowError:
		[ :cart :book | self should: [cart addToCart: book withQuantity: 1/2]
	   				    raise: Error
 	                                  withExceptionDo: [ :anError |
  	          						self assert: anError messageText = 
												Cart errorDescribesCanNotAddProductsWithFractionQuantity.
   	         						self assert: cart isEmpty].]
! !


!CartTest methodsFor: 'create catalogue' stamp: 'CS 6/10/2021 15:02:22'!
createCatalogue

	| catalogue book1 book2 |
	
	catalogue := OrderedCollection new.
	
	book1 := 'Desing Patterns'.
	book2 := 'Smalltalk Best Practices Patterns'.
	
	catalogue add: book1.
	catalogue add: book2.

	^ catalogue.! !


!CartTest methodsFor: 'create cart' stamp: 'CS 6/10/2021 15:03:33'!
createCart

	^ Cart new initializeWith: self createCatalogue.! !


!CartTest methodsFor: 'private - invalid quantity' stamp: 'CS 6/10/2021 16:25:05'!
canNotAddProductsWithInvalidQuantityThrowError: anErrorBlock

    | cart book |

    cart := self createCart.

    book := 'Desing Patterns'.

    anErrorBlock value: cart value: book! !


!classDefinition: #Cart category: 'LosLibros- Excersice'!
Object subclass: #Cart
	instanceVariableNames: 'books catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'LosLibros- Excersice'!

!Cart methodsFor: 'initialization' stamp: 'CS 6/10/2021 15:44:28'!
initializeWith: aCatalogue

	books := Bag new.
	catalogue := aCatalogue! !


!Cart methodsFor: 'add book' stamp: 'CS 6/10/2021 15:46:12'!
addToCart: aBook withQuantity: bookQuantity.

	self isValidQuantity: bookQuantity. 
	self isValidBook: aBook.

	books add: aBook withOccurrences: bookQuantity.! !


!Cart methodsFor: 'list' stamp: 'CS 6/10/2021 16:01:53'!
list

	| list |
	
	list := Dictionary new.
	books do: [ :aBook | list at: aBook
					put: (books occurrencesOf: aBook)].

	^ list
! !


!Cart methodsFor: 'testing' stamp: 'CS 6/10/2021 14:38:34'!
isEmpty

	^ books isEmpty! !


!Cart methodsFor: 'validating' stamp: 'CS 6/10/2021 15:19:26'!
isValidBook: aBook

	^ (catalogue includes: aBook) ifFalse:
						     [Error signal: self class errorDescribesCanNotAddProductsThatDoNotBelongeToTheCatalogue]! !

!Cart methodsFor: 'validating' stamp: 'CS 6/10/2021 15:16:09'!
isValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self class errorDescribesCanNotAddProductsWithNegativeOrZeroQuantity].
	aQuantity isFraction ifTrue: [ self error: self class errorDescribesCanNotAddProductsWithFractionQuantity].
! !


!Cart methodsFor: 'catalogue' stamp: 'CS 6/10/2021 15:54:36'!
catalogue

	^ catalogue! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'LosLibros- Excersice'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error describes' stamp: 'CS 6/10/2021 15:09:04'!
errorDescribesCanNotAddProductsThatDoNotBelongeToTheCatalogue

	^ 'Can not add books that do not belonge to the catalogue'! !

!Cart class methodsFor: 'error describes' stamp: 'CS 6/10/2021 15:09:28'!
errorDescribesCanNotAddProductsWithFractionQuantity

	^ 'Can not add books with fraction quantity'! !

!Cart class methodsFor: 'error describes' stamp: 'CS 6/10/2021 15:09:50'!
errorDescribesCanNotAddProductsWithNegativeOrZeroQuantity

	^'Can not add books with negative or zero quantity'! !
