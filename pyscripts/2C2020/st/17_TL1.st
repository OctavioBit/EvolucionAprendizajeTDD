!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'aCart anISBN anotherISBN aClientID aCartID anotherCart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'BT 11/19/2020 02:49:02'!
setUp
	
	aClientID := 12.
	aCartID := 13.
	aCart := Cart withID: aCartID ofClient: aClientID .
	anISBN := 123.
	anotherISBN := 127.
	
	anotherCart := Cart withID: aCartID ofClient: aClientID .! !

!CartTest methodsFor: 'tests' stamp: 'BT 11/19/2020 16:28:09'!
test01CreateCartWithClientIDAndCartIDWorksCorrectly
	| JohnsCartID clientJohnID JohnsCart |
	clientJohnID := 12.
	JohnsCartID := 13.
	JohnsCart := Cart withID: JohnsCartID ofClient: clientJohnID.
	
	self assert: (JohnsCart belongsTo: clientJohnID).
	self assert: (JohnsCart idIs: JohnsCartID).
	 ! !

!CartTest methodsFor: 'tests' stamp: 'BT 11/19/2020 02:48:32'!
test02AddingOneBookOneTimeToCartWorksCorrectly	

	aCart add: anISBN times: 1.
	
	self assert: (aCart hasBook: anISBN times: 1).
	! !

!CartTest methodsFor: 'tests' stamp: 'BT 11/19/2020 02:48:42'!
test03AddingManyBooksOneTimeToCartWorksCorrectly

	aCart add: anISBN times: 1.	
	aCart add: anotherISBN times: 1.
	
	self assert: (aCart hasBook: anISBN times: 1).
	self assert: (aCart hasBook: anotherISBN times: 1).
	 ! !

!CartTest methodsFor: 'tests' stamp: 'BT 11/19/2020 02:48:32'!
test04AddingOneBookMultipleTimesToCartWorksCorrectly

	aCart add: anISBN times: 1.
	aCart add: anISBN times: 5.
	
	self assert: (aCart hasBook: anISBN times: 6).

	 ! !

!CartTest methodsFor: 'tests' stamp: 'BT 11/19/2020 16:29:10'!
test05AddingManyBooksManyTimesToCartWorksCorrectly
	
	aCart add: anISBN times: 1.	
	aCart add: anotherISBN times: 1.
	
	aCart add: anISBN times: 4.	
	aCart add: anotherISBN times: 5.
	
	self assert: (aCart hasBook: anISBN times: 5).
	self assert: (aCart hasBook: anotherISBN times: 6).
	 ! !

!CartTest methodsFor: 'tests' stamp: 'BT 11/19/2020 02:48:32'!
test06AddingNegativeQuantityOfBooksRaisesError
	
	self should: [aCart add: anISBN times: -1.] 
	raise: Error
	withMessageText: ( Cart cantAddNegativeQuantityOfBooks).
	! !

!CartTest methodsFor: 'tests' stamp: 'CR 11/19/2020 15:12:33'!
test07ListEmptyCartGivesEmptyList
	
	self assert: aCart listBooks = 'The cart has no items'.! !

!CartTest methodsFor: 'tests' stamp: 'CR 11/19/2020 15:23:33'!
test08ListCartWithOneBookWorksCorrectly
	
	aCart add: anISBN times: 1.
	
	self assert: aCart listBooks = '#(''ISBN #123'' -> 1)'.! !

!CartTest methodsFor: 'tests' stamp: 'CR 11/19/2020 15:23:40'!
test09ListCartWithOneBookMultipleTimesWorksCorrectly
	
	aCart add: anISBN times: 1.
	aCart add: anISBN times: 5.
	
	self assert: aCart listBooks = '#(''ISBN #123'' -> 6)'.! !

!CartTest methodsFor: 'tests' stamp: 'CR 11/19/2020 15:23:43'!
test10ListCartWithManyBooksMultipleTimesWorksCorrectly
	
	aCart add: anISBN times: 1.	
	aCart add: anotherISBN times: 1.
	
	aCart add: anISBN times: 4.	
	aCart add: anotherISBN times: 5.
	
	self assert: aCart listBooks = '#(''ISBN #127'' -> 6 ''ISBN #123'' -> 5)'.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'cartID ownerClientID booksInCart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'instance creation' stamp: 'BT 11/19/2020 01:57:53'!
initializeWithID: aCartID ofClient: anOwnerClientID 
	cartID := aCartID.
	ownerClientID := anOwnerClientID.
	booksInCart := Dictionary new.! !


!Cart methodsFor: 'accessing' stamp: 'BT 11/19/2020 00:52:12'!
belongsTo: aClientIDToBeCompared 
	^ ownerClientID = aClientIDToBeCompared! !

!Cart methodsFor: 'accessing' stamp: 'BT 11/19/2020 02:11:09'!
hasBook: anISBN times: quantity 
	^ (booksInCart at: (self getBookKeyFor: anISBN)) = quantity.! !

!Cart methodsFor: 'accessing' stamp: 'BT 11/19/2020 00:50:39'!
idIs: aCartID
	^ cartID = aCartID.! !


!Cart methodsFor: 'signals' stamp: 'BT 11/19/2020 02:18:27'!
signalInvalidQuantityOfBooks
	^ self error: (self class cantAddNegativeQuantityOfBooks).! !


!Cart methodsFor: 'verifications' stamp: 'BT 11/19/2020 02:17:42'!
verifyValidQuantityOfBook: bookQuantityToAdd.
	(bookQuantityToAdd <= 0) ifTrue: [ self signalInvalidQuantityOfBooks].! !


!Cart methodsFor: 'private' stamp: 'BT 11/19/2020 02:09:12'!
addNewBook: anISBN times: bookQuantityToAdd

	^ booksInCart at: (self getBookKeyFor: anISBN) put: bookQuantityToAdd! !

!Cart methodsFor: 'private' stamp: 'BT 11/19/2020 02:22:57'!
checkIfPresent: anISBN andAdd: bookQuantityToAdd.
	booksInCart at: (self getBookKeyFor: anISBN) ifPresent: [ :previousQuantity | self updateBookQuantity: (previousQuantity + bookQuantityToAdd) To: anISBN] ifAbsent: [ self addNewBook: anISBN times: bookQuantityToAdd]. 
	
	
	! !

!Cart methodsFor: 'private' stamp: 'BT 11/19/2020 01:56:29'!
getBookKeyFor: anISBN

	^ 'ISBN #', (anISBN asString)! !

!Cart methodsFor: 'private' stamp: 'BT 11/19/2020 02:08:35'!
updateBookQuantity: newBookQuantity To: anISBN
	booksInCart at: (self getBookKeyFor: anISBN) put: newBookQuantity! !


!Cart methodsFor: 'actions' stamp: 'BT 11/19/2020 02:22:25'!
add: anISBN times: bookQuantityToAdd
	self verifyValidQuantityOfBook: bookQuantityToAdd.
	self checkIfPresent: anISBN andAdd: bookQuantityToAdd.
	
	! !

!Cart methodsFor: 'actions' stamp: 'CR 11/19/2020 15:23:26'!
listBooks 
	booksInCart ifEmpty: [^ 'The cart has no items'].
	^ booksInCart associations asString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'BT 11/19/2020 00:48:38'!
withID: aCartID ofClient: anOwnerClientID 
	^ self new initializeWithID: aCartID ofClient: anOwnerClientID.! !


!Cart class methodsFor: 'as yet unclassified' stamp: 'BT 11/19/2020 02:14:37'!
cantAddNegativeQuantityOfBooks
	^ 'Cant add negative quantity of books!!!!'! !
