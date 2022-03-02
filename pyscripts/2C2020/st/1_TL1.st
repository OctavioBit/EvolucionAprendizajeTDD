!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'harryPotter lordOfTheRings ageOfEmpires'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'setUp/tearDown' stamp: 'AM 11/17/2020 22:26:59'!
setUp

	harryPotter := #HarryPotter.
	lordOfTheRings := #LordOfTheRings.
	ageOfEmpires := #AgeOfEmpires
	! !


!CartTest methodsFor: 'tests - adding' stamp: 'AM 11/17/2020 22:35:26'!
test01NewCartIsEmpty

	| anEmptyCart catalogue |
	
	catalogue := OrderedCollection new.
	
	anEmptyCart := Cart withCatalogue: catalogue.
	
	self assert: anEmptyCart isEmpty.
	self assert: anEmptyCart listCart isEmpty.! !

!CartTest methodsFor: 'tests - adding' stamp: 'AM 11/17/2020 22:35:35'!
test02ABookAddedToCartIsSuccessfullyAdded

	| aCart catalogue |
	
	catalogue := OrderedCollection with: harryPotter.
	
	aCart := Cart withCatalogue: catalogue.
	
	aCart addToCart: harryPotter withOccurrences: 1.
	
	self deny: aCart isEmpty.
	self assert: ( aCart listCart hasEqualElements: {harryPotter} )! !

!CartTest methodsFor: 'tests - adding' stamp: 'AM 11/17/2020 22:59:37'!
test03ManyBooksAddedToCartAreSuccessfullyAdded

	| aCart catalogue |
	
	catalogue := OrderedCollection with: harryPotter 
									with: lordOfTheRings 
									with: ageOfEmpires .
	
	aCart := Cart withCatalogue: catalogue.
	
	aCart addToCart: harryPotter withOccurrences: 1. 
	aCart addToCart: lordOfTheRings withOccurrences: 1.
	aCart addToCart: ageOfEmpires withOccurrences: 1.
	
	self deny: aCart isEmpty.
	self assert: ( aCart listCart hasEqualElements: {harryPotter. lordOfTheRings. ageOfEmpires} )! !

!CartTest methodsFor: 'tests - adding' stamp: 'AM 11/17/2020 22:35:48'!
test05ABookAddedMoreThanOnceIsSuccessfullyAddedMoreThanOnce

	| aCart catalogue |
	
	catalogue := OrderedCollection with: harryPotter.
	
	aCart := Cart withCatalogue: catalogue.
	
	aCart addToCart: harryPotter withOccurrences: 2. 
	
	self assert: ( aCart listCart hasEqualElements: {harryPotter. harryPotter} )! !

!CartTest methodsFor: 'tests - adding' stamp: 'AM 11/18/2020 18:35:53'!
test08ExternallyAddingBookToCartListShouldNotModifyCart

	| anEmptyCart catalogue emptyCartList |
	
	catalogue := OrderedCollection with: harryPotter.
	
	anEmptyCart := Cart withCatalogue: catalogue.
	emptyCartList := anEmptyCart listCart.
	emptyCartList add: harryPotter.
	
	self assert: anEmptyCart isEmpty.
	self assert: anEmptyCart listCart isEmpty.! !


!CartTest methodsFor: 'tests - errors' stamp: 'AM 11/17/2020 23:00:37'!
test04ABookShouldNotBeAddedWhenNotForSale

	| aCart catalogue |
	
	catalogue := OrderedCollection with: harryPotter.
	
	aCart := Cart withCatalogue: catalogue.
	
	self should: [ aCart addToCart: lordOfTheRings withOccurrences: 1 ]
		raise: Error
		withMessageText: Cart bookIsNotForSaleErrorDescription.! !

!CartTest methodsFor: 'tests - errors' stamp: 'AM 11/17/2020 22:40:26'!
test06ABookShouldNotBeAddedWithNonIntegerQuantity

	| aCart catalogue |
	
	catalogue := OrderedCollection with: harryPotter.
	
	aCart := Cart withCatalogue: catalogue.
	
	self should: [ aCart addToCart: harryPotter withOccurrences: 0.5 ]
		raise: Error
		withMessageText: Cart bookCanNotBeAddedANonNaturalNumberOfTimesErrorDescription.! !

!CartTest methodsFor: 'tests - errors' stamp: 'AM 11/17/2020 22:46:03'!
test07ABookShouldNotBeAddedWithNonPositiveQuantity

	| aCart catalogue |
	
	catalogue := OrderedCollection with: harryPotter.
	
	aCart := Cart withCatalogue: catalogue.
	
	self should: [ aCart addToCart: harryPotter withOccurrences: 0 ]
		raise: Error
		withMessageText: Cart bookCanNotBeAddedANonNaturalNumberOfTimesErrorDescription.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'accessing' stamp: 'AM 11/18/2020 18:32:39'!
listCart
	
	^ books copy! !


!Cart methodsFor: 'adding books' stamp: 'AM 11/17/2020 22:54:35'!
addToCart: aBook withOccurrences: aNumberOfOccurences

	self assertThatCanBeAdded: aBook 
		withOccurences: aNumberOfOccurences.
		
	books add: aBook 
		withOccurrences: aNumberOfOccurences 
	
	! !


!Cart methodsFor: 'assertions' stamp: 'AM 11/17/2020 22:53:44'!
assertThatCanBeAdded: aBook withOccurences: aNumberOfOccurrences

	(catalogue includes: aBook ) 
		ifFalse: [ self signalBookIsNotForSale ].
		
	(aNumberOfOccurrences isInteger and: [ aNumberOfOccurrences > 0 ]) 
		ifFalse: [ self signalBookCanNotBeAddedANonNaturalNumberOfTimes ].! !


!Cart methodsFor: 'error signaling' stamp: 'AM 11/17/2020 22:52:59'!
signalBookCanNotBeAddedANonNaturalNumberOfTimes

	^ self error: self class bookCanNotBeAddedANonNaturalNumberOfTimesErrorDescription! !

!Cart methodsFor: 'error signaling' stamp: 'AM 11/17/2020 22:52:32'!
signalBookIsNotForSale

	^ self error: self class bookIsNotForSaleErrorDescription! !


!Cart methodsFor: 'initialization' stamp: 'AM 11/16/2020 21:28:23'!
initializeWithCatalogue: aCatalogue
	
	catalogue := aCatalogue.
	books := OrderedCollection new.! !


!Cart methodsFor: 'testing' stamp: 'AM 11/16/2020 19:06:48'!
isEmpty
	
	^ books isEmpty! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'AM 11/16/2020 21:28:41'!
withCatalogue: aCatalogue

	^self new initializeWithCatalogue: aCatalogue ! !


!Cart class methodsFor: 'error descriptions' stamp: 'AM 11/17/2020 22:41:12'!
bookCanNotBeAddedANonNaturalNumberOfTimesErrorDescription
	
	^ 'Books can not be added with a non natural number of occurrences'! !

!Cart class methodsFor: 'error descriptions' stamp: 'AM 11/16/2020 19:17:14'!
bookIsNotForSaleErrorDescription
	
	^ 'Book is not for sale'.! !
