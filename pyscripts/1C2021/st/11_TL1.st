!classDefinition: #CartTests category: 'TusLibros'!
TestCase subclass: #CartTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTests methodsFor: 'as yet unclassified' stamp: 'ERMC 6/8/2021 20:05:02'!
createCatalog
	
	| catalog |
	catalog _ OrderedCollection new.
	
	catalog add: 'The Lord Of The Rings' .
	catalog add: 'Harry Potter'.
	
	^catalog ! !

!CartTests methodsFor: 'as yet unclassified' stamp: 'ERMC 6/8/2021 20:17:25'!
test01CreateAnEmptyCartWithCatalog
	
	| cart |
	cart _ Cart with: self createCatalog.
	
	self assert: cart isEmpty.! !

!CartTests methodsFor: 'as yet unclassified' stamp: 'ERMC 6/8/2021 20:18:42'!
test02CreateACartAnAddABook

	| aBook cart |
	cart _ Cart with: self createCatalog.
	aBook _ 'The Lord Of The Rings'.
	
	cart add: aBook withQuantity: 1.
	
	self assert: (cart has: aBook).
	self deny: (cart isEmpty).! !

!CartTests methodsFor: 'as yet unclassified' stamp: 'ERMC 6/8/2021 20:18:53'!
test03CanNotAddABookThatIsNotOnTheCatalog
	
	| aBook cart catalog lordOfTheRing |
	
	catalog _ self createCatalog. 
	cart _ Cart with: catalog.
	
	aBook _ 'Revolution'.
	lordOfTheRing _ 'The Lord Of The Rings'.
	cart add: lordOfTheRing withQuantity: 1.
	
	
	self should: [cart add: aBook withQuantity: 1 ]
		 raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: anError messageText equals: Cart canNotAddABookThatIsNotInTheCatalogErrorDescription.
						self assert: (cart has: lordOfTheRing).
						self deny: (cart has: aBook).]
	
	! !

!CartTests methodsFor: 'as yet unclassified' stamp: 'ERMC 6/8/2021 19:48:24'!
test04WhenABookIsAddedIsSavedWithQuantity
	
	| aBook cart |

	cart _ Cart with: self createCatalog.
	
	aBook _ 'Harry Potter'.
	cart add: aBook withQuantity: 5.
	
	self assert: (cart cantOf: aBook) equals: 5.
	
	
	! !

!CartTests methodsFor: 'as yet unclassified' stamp: 'ERMC 6/8/2021 20:18:10'!
test05CanAskForTheContentOfTheCart
	
	| aBook cart |

	cart _ Cart with: self createCatalog.
	
	aBook _ 'Harry Potter'.
	cart add: aBook withQuantity: 1.
	
	self assert: (cart has: aBook)
	
	
	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'contents catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'ERMC 6/8/2021 19:02:47'!
add: aBook
	
	(catalog includes: aBook) ifFalse: [^self error: self class canNotAddABookThatIsNotInTheCatalogErrorDescription].
	contents add: aBook 
	! !

!Cart methodsFor: 'as yet unclassified' stamp: 'ERMC 6/8/2021 20:12:27'!
add: aBook withQuantity: aBookQuantity
	
	(catalog includes: aBook) ifFalse: [^self error: self class canNotAddABookThatIsNotInTheCatalogErrorDescription].
	contents add: aBook->aBookQuantity.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'ERMC 6/8/2021 20:06:12'!
cantOf: aBook
	
	^contents at: aBook ifAbsent: [^false.]
	
	! !

!Cart methodsFor: 'as yet unclassified' stamp: 'ERMC 6/8/2021 20:16:21'!
has: aBook
	
	^contents includesKey: aBook 
		
	! !

!Cart methodsFor: 'as yet unclassified' stamp: 'ERMC 6/8/2021 20:09:49'!
isEmpty
	
	^ contents isEmpty ! !


!Cart methodsFor: 'initialization' stamp: 'ERMC 6/8/2021 20:01:25'!
initializeWith: aCatalog 

	catalog _ aCatalog.
	contents _ Dictionary new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'ERMC 6/8/2021 19:03:24'!
canNotAddABookThatIsNotInTheCatalogErrorDescription
	
	^'Can not add a book that is not in the Catalog'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'ERMC 6/8/2021 19:00:33'!
with: aCatalog
	
	^self new initializeWith: aCatalog! !
