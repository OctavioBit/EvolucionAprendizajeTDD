!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'emptyPortfolio anAccountWithAHundredDollarsBalance aHundredDollarsDeposit aPortfolioWithAHundredDollarsAccount emptyAccount aPortfolioWithAFiftyAndAHundredDollarsAccounts anAccountWithAFiftyDollarsBalance aFiftyDollarsDeposit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'setUp / tearDown' stamp: 'NNH 11/6/2020 20:08:34'!
newPortfolioWith: aCollectionOfFinancialProducts
		
	| portfolio |

	portfolio := Portfolio new.
	
	aCollectionOfFinancialProducts do: [:aFinancialProduct | portfolio add: aFinancialProduct ].
	
	^ portfolio.
	! !

!PortfolioTest methodsFor: 'setUp / tearDown' stamp: 'NNH 11/6/2020 20:22:25'!
setUp
		
	emptyAccount := ReceptiveAccount new.
	anAccountWithAHundredDollarsBalance := ReceptiveAccount new.
	anAccountWithAFiftyDollarsBalance := ReceptiveAccount new.
	
	aHundredDollarsDeposit := Deposit register: 100 on: anAccountWithAHundredDollarsBalance.
	aFiftyDollarsDeposit := Deposit register: 50 on: anAccountWithAFiftyDollarsBalance.
	
	emptyPortfolio := Portfolio new.
	aPortfolioWithAHundredDollarsAccount := self newPortfolioWith: {anAccountWithAHundredDollarsBalance}.
	aPortfolioWithAFiftyAndAHundredDollarsAccounts := self newPortfolioWith: {anAccountWithAFiftyDollarsBalance. anAccountWithAHundredDollarsBalance}.

	
	! !


!PortfolioTest methodsFor: 'testing balance' stamp: 'NNH 11/6/2020 15:58:59'!
test01BalanceOfEmptyPortfolioIsZero
	
	self assert: 0 equals: emptyPortfolio balance.
	
	! !

!PortfolioTest methodsFor: 'testing balance' stamp: 'NNH 11/6/2020 20:17:49'!
test02BalanceOfPortfolioWithOneFinancialProductIsBalanceOfThatAccount
	
	self assert: 100 equals: aPortfolioWithAHundredDollarsAccount balance.
	
	! !

!PortfolioTest methodsFor: 'testing balance' stamp: 'NNH 11/6/2020 20:22:25'!
test03BalanceOfPortfolioWithMoreThanOneFinancialProductIsSumOfBalances

	self assert: 150 equals: aPortfolioWithAFiftyAndAHundredDollarsAccounts balance.
	
	! !


!PortfolioTest methodsFor: 'testing register operations' stamp: 'NNH 11/6/2020 20:14:54'!
test04EmptyPortfolioHasRegisteredNoTransactions

	self deny: (emptyPortfolio hasRegistered: aHundredDollarsDeposit).
	
	! !

!PortfolioTest methodsFor: 'testing register operations' stamp: 'NNH 11/6/2020 20:18:36'!
test05PortfolioWithOneFinancialProductRegistersATransactionOfThatAccount

	self assert: (aPortfolioWithAHundredDollarsAccount hasRegistered: aHundredDollarsDeposit ).
	
	! !

!PortfolioTest methodsFor: 'testing register operations' stamp: 'NNH 11/6/2020 20:22:47'!
test06APortfolioWithMoreThanOneFinancialProductRegistersAllTransactions

	self assert: (aPortfolioWithAFiftyAndAHundredDollarsAccounts hasRegistered: aFiftyDollarsDeposit).
	self assert: (aPortfolioWithAFiftyAndAHundredDollarsAccounts hasRegistered: aHundredDollarsDeposit).

	
	! !


!PortfolioTest methodsFor: 'testing transactions' stamp: 'NNH 11/6/2020 16:03:03'!
test07EmptyPortfolioHasNoTransactions

	self assert: emptyPortfolio transactions isEmpty.
	
	! !

!PortfolioTest methodsFor: 'testing transactions' stamp: 'NNH 11/6/2020 20:23:16'!
test08PortfolioWithOneFinancialProductHasTheTransactionsOfThatAccount

	self assert: 1 equals: aPortfolioWithAHundredDollarsAccount transactions size.
	self assert: aPortfolioWithAHundredDollarsAccount transactions includes: aHundredDollarsDeposit.
	
	! !

!PortfolioTest methodsFor: 'testing transactions' stamp: 'NNH 11/6/2020 20:23:28'!
test09APortfolioWithMoreThanOneFinancialProductHasTheTransactionsOfItsAccounts

	self assert: 2 equals: aPortfolioWithAFiftyAndAHundredDollarsAccounts transactions size.
	self assert: aPortfolioWithAFiftyAndAHundredDollarsAccounts transactions includes: aFiftyDollarsDeposit .
	self assert: aPortfolioWithAFiftyAndAHundredDollarsAccounts transactions includes: aHundredDollarsDeposit.

	
	! !


!PortfolioTest methodsFor: 'testing dependencies' stamp: 'NNH 11/6/2020 20:29:07'!
test10PortfolioShouldNotAddItself

	self should: [emptyPortfolio add: emptyPortfolio] 
	raise: Error
	withMessageText: Portfolio canNotAddAPortfolioToItselfErrorDescription.! !

!PortfolioTest methodsFor: 'testing dependencies' stamp: 'am 11/6/2020 20:57:33'!
test11PortfolioShouldNotAddAnOwnerPortfolio
	
	| aPortfolioWithEmptyPortfolio |
	
	aPortfolioWithEmptyPortfolio := self newPortfolioWith: {emptyPortfolio}.

	self should: [emptyPortfolio add: aPortfolioWithEmptyPortfolio] 
	raise: Error
	withMessageText: Portfolio canNotAddAPortfolioThatIncludesThePortfolioErrorDescription.! !

!PortfolioTest methodsFor: 'testing dependencies' stamp: 'am 11/6/2020 20:59:55'!
test12PortfolioShouldNotAddFinancialProductIfTheyBothBelongToAnotherPortfolio

	| aPortfolioOwningTwoPortfolios aPortfolio anotherPortfolio |

	aPortfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	
	aPortfolioOwningTwoPortfolios := self newPortfolioWith: {aPortfolio. anotherPortfolio }.

	self should: [aPortfolio add: anotherPortfolio ]
	raise: Error
	withMessageText: Portfolio canNotAddAPortfolioWhenTheyAreOwnedByACommonPortfolioErrorDescription.! !

!PortfolioTest methodsFor: 'testing dependencies' stamp: 'am 11/6/2020 21:00:53'!
test13PortfolioShouldNotAddAnotherPortfolioWhenTheyBothOwnAFinancialProduct
	
	| anOwningPortfolio anotherOwningPortfolio |

	anOwningPortfolio := self newPortfolioWith: {emptyPortfolio}.
	anotherOwningPortfolio := self newPortfolioWith: {emptyPortfolio}.

	self should: [anOwningPortfolio add: anotherOwningPortfolio]
	raise: Error
	withMessageText: Portfolio canNotAddAPortfolioWhenTheyOwnACommonFinancialProductErrorDescription.! !

!PortfolioTest methodsFor: 'testing dependencies' stamp: 'am 11/6/2020 21:04:48'!
test14APortfolioShouldNotAddAnotherFinancialProductWhenTheyAreOwnedIndirectlyByAnotherPortfolio
		
	| aPortfolioThatCanNotOwnEmptyPortfolio aMasterPortfolio anOwningPortfolio |
	
	anOwningPortfolio := self newPortfolioWith: {emptyPortfolio}.
	aPortfolioThatCanNotOwnEmptyPortfolio := Portfolio new.
	aMasterPortfolio := self newPortfolioWith: {anOwningPortfolio. aPortfolioThatCanNotOwnEmptyPortfolio} .

	self should: [aPortfolioThatCanNotOwnEmptyPortfolio add: emptyPortfolio]
	raise: Error
	withMessageText: Portfolio canNotAddAPortfolioWhenTheyAreOwnedByACommonPortfolioErrorDescription.! !

!PortfolioTest methodsFor: 'testing dependencies' stamp: 'am 11/6/2020 21:07:23'!
test15APortfolioShouldNotAddAPortfolioWhenTheyBothOwnTheSameFinancialProductIndirectly
		
	| aMasterPortfolio anOwningPortfolio anotherOwningPortfolio |
	
	anOwningPortfolio := self newPortfolioWith: {emptyPortfolio}.
	anotherOwningPortfolio := self newPortfolioWith: {emptyPortfolio}.
	aMasterPortfolio := self newPortfolioWith: {anOwningPortfolio.} .

	self should: [aMasterPortfolio add: anotherOwningPortfolio]
	raise: Error
	withMessageText: Portfolio canNotAddAPortfolioWhenTheyOwnACommonFinancialProductErrorDescription.! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:15'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance operations' stamp: 'NNH 11/2/2020 20:35:23'!
addToBalance: aBalance
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance operations' stamp: 'NNH 11/2/2020 20:36:05'!
addToBalance: aBalance
	^ aBalance + value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance operations' stamp: 'NNH 11/2/2020 20:36:55'!
addToBalance: aBalance 
	^ aBalance - value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialProduct category: 'Portfolio-Ejercicio'!
Object subclass: #FinancialProduct
	instanceVariableNames: 'owners'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialProduct methodsFor: 'accessing dependencies' stamp: 'NNH 11/6/2020 19:22:39'!
addFinancialProductsTo: aCollectionOfFinancialProducts
		
	self subclassResponsibility.! !

!FinancialProduct methodsFor: 'accessing dependencies' stamp: 'NNH 11/6/2020 19:44:40'!
ownedFinancialProducts
	
	| ownedFinancialProducts |
	
	ownedFinancialProducts := OrderedCollection new.
	self addFinancialProductsTo: ownedFinancialProducts.
	
	^ ownedFinancialProducts.! !


!FinancialProduct methodsFor: 'balance' stamp: 'NNH 11/6/2020 15:39:55'!
balance

	self subclassResponsibility.! !


!FinancialProduct methodsFor: 'inserting - private' stamp: 'NNH 11/6/2020 19:19:42'!
addOwner: aPortfolio 
	
	owners add: aPortfolio.! !


!FinancialProduct methodsFor: 'testing' stamp: 'NNH 11/6/2020 15:40:19'!
hasRegistered: aTransaction

	self subclassResponsibility.! !


!FinancialProduct methodsFor: 'testing dependencies' stamp: 'NNH 11/6/2020 19:48:05'!
hasFinancialProductsInCommonWith: aFinancialProduct

	^ (self ownedFinancialProducts intersection: aFinancialProduct ownedFinancialProducts) isEmpty not! !

!FinancialProduct methodsFor: 'testing dependencies' stamp: 'NNH 11/6/2020 19:24:33'!
includesFinancialProduct: aFinancialProductToSearch
	
	self subclassResponsibility.! !

!FinancialProduct methodsFor: 'testing dependencies' stamp: 'NNH 11/6/2020 19:44:58'!
isInAPortfolioWith: aFinancialProduct
	
	^ (owners anySatisfy: [:anOwner | anOwner isInAPortfolioWith: aFinancialProduct ]) or: [
		self includesFinancialProduct: aFinancialProduct
		].
	
	
! !


!FinancialProduct methodsFor: 'transactions' stamp: 'NNH 11/6/2020 15:40:48'!
transactions

	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialProduct subclass: #Portfolio
	instanceVariableNames: 'financialProducts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'assertions' stamp: 'NNH 11/6/2020 20:31:46'!
assertFinancialProductCanBeAdded: aFinancialProduct

	(self = aFinancialProduct) ifTrue: [self signalCanNotAddAPortfolioToItself ].
	(aFinancialProduct includesFinancialProduct: self) ifTrue: [self signalCanNotAddAPortfolioThatIncludesThePortfolio ].
	(self isInAPortfolioWith: aFinancialProduct) ifTrue: [self signalCanNotAddAPortfolioWhenTheyAreOwnedByACommonPortfolio ].
	(self hasFinancialProductsInCommonWith: aFinancialProduct)	 ifTrue: [self signalCanNotAddAPortfolioWhenTheyOwnACommonFinancialProduct ].! !


!Portfolio methodsFor: 'balance' stamp: 'NNH 11/6/2020 19:49:04'!
balance

	^ financialProducts sum: [:aFinancialProduct | aFinancialProduct balance] ifEmpty: [0].! !


!Portfolio methodsFor: 'error signaling' stamp: 'NNH 11/6/2020 19:30:00'!
signalCanNotAddAPortfolioThatIncludesThePortfolio

	^ self error: self class canNotAddAPortfolioThatIncludesThePortfolioErrorDescription.! !

!Portfolio methodsFor: 'error signaling' stamp: 'NNH 11/6/2020 20:31:46'!
signalCanNotAddAPortfolioToItself

	^ self error: self class canNotAddAPortfolioToItselfErrorDescription ! !

!Portfolio methodsFor: 'error signaling' stamp: 'NNH 11/6/2020 20:30:59'!
signalCanNotAddAPortfolioWhenTheyAreOwnedByACommonPortfolio

	^ self error: self class canNotAddAPortfolioWhenTheyAreOwnedByACommonPortfolioErrorDescription! !

!Portfolio methodsFor: 'error signaling' stamp: 'NNH 11/6/2020 20:31:25'!
signalCanNotAddAPortfolioWhenTheyOwnACommonFinancialProduct

	^ self error: self class canNotAddAPortfolioWhenTheyOwnACommonFinancialProductErrorDescription! !


!Portfolio methodsFor: 'initializing' stamp: 'NNH 11/6/2020 19:19:23'!
initialize
	
	financialProducts := OrderedCollection new.
	owners := OrderedCollection new.! !


!Portfolio methodsFor: 'inserting' stamp: 'NNH 11/6/2020 19:21:44'!
add: aFinancialProduct 
	
	self assertFinancialProductCanBeAdded: aFinancialProduct.
	
	aFinancialProduct addOwner: self.	
	financialProducts add: aFinancialProduct.! !


!Portfolio methodsFor: 'testing' stamp: 'NNH 11/6/2020 19:49:13'!
hasRegistered: aTransaction

	^ financialProducts anySatisfy: [:aFinancialProduct | aFinancialProduct hasRegistered: aTransaction].! !


!Portfolio methodsFor: 'accessing dependencies' stamp: 'NNH 11/6/2020 19:22:39'!
addFinancialProductsTo: aCollectionOfFinancialProducts
		
	aCollectionOfFinancialProducts add: self.
	financialProducts do: [:aFinancialProduct | aFinancialProduct addFinancialProductsTo: aCollectionOfFinancialProducts].
	
	
	
! !


!Portfolio methodsFor: 'testing dependencies' stamp: 'NNH 11/6/2020 15:36:58'!
includesFinancialProduct: aFinancialProductToSearch
	
	^ (aFinancialProductToSearch == self) or: [
		financialProducts anySatisfy: [:aFinancialProduct | aFinancialProduct includesFinancialProduct: aFinancialProductToSearch]
		].
	
	
! !


!Portfolio methodsFor: 'transactions' stamp: 'NNH 11/4/2020 19:09:03'!
transactions
	
	| aCollectionOfTransactions |
	
	aCollectionOfTransactions := OrderedCollection new.
	self addTransactionsTo: aCollectionOfTransactions.
	
	^aCollectionOfTransactions.! !


!Portfolio methodsFor: 'transactions - private' stamp: 'NNH 11/6/2020 15:35:57'!
addTransactionsTo: aCollectionOfTransactions
	
	financialProducts do: [ :aFinancialProduct | aFinancialProduct addTransactionsTo: aCollectionOfTransactions ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'NNH 11/6/2020 19:29:21'!
canNotAddAPortfolioThatIncludesThePortfolioErrorDescription
	^ 'The portfolio cannot include a portfolio that includes the portfolio'.! !

!Portfolio class methodsFor: 'error descriptions' stamp: 'NNH 11/6/2020 20:29:07'!
canNotAddAPortfolioToItselfErrorDescription
	^ 'A portfolio cannot include itself'.! !

!Portfolio class methodsFor: 'error descriptions' stamp: 'NNH 11/6/2020 20:28:32'!
canNotAddAPortfolioWhenTheyAreOwnedByACommonPortfolioErrorDescription
	^ 'There is a portfolio containing both portfolios'! !

!Portfolio class methodsFor: 'error descriptions' stamp: 'NNH 11/6/2020 20:27:33'!
canNotAddAPortfolioWhenTheyOwnACommonFinancialProductErrorDescription
	^ 'Portfolios should not share an account'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialProduct subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'balance' stamp: 'NNH 11/2/2020 20:34:42'!
balance

	^ transactions inject: 0 into: [:balance :aTransaction | aTransaction addToBalance: balance].

! !


!ReceptiveAccount methodsFor: 'initialization' stamp: 'NNH 11/6/2020 19:19:23'!
initialize

	transactions := OrderedCollection new.
	owners := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'testing dependencies' stamp: 'NNH 11/6/2020 19:22:39'!
addFinancialProductsTo: aCollectionOfFinancialProducts
		
	aCollectionOfFinancialProducts add: self.! !

!ReceptiveAccount methodsFor: 'testing dependencies' stamp: 'NNH 11/6/2020 15:39:07'!
includesFinancialProduct: aFinancialProductToSearch
	
	^ aFinancialProductToSearch == self.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'transactions - private' stamp: 'NNH 11/5/2020 23:14:22'!
addTransactionsTo: aCollectionOfTransactions
	
	aCollectionOfTransactions addAllLast: self transactions.! !
