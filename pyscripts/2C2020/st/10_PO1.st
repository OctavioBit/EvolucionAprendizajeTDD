!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'hasRegistered' stamp: 'DB 11/8/2020 21:34:45'!
allTransactionOf: anAccount NotIn: aPortfolio

	anAccount transactions do: [ :aTransaction |
		self deny: (aPortfolio hasRegistered: aTransaction )
	].! !

!PortfolioTest methodsFor: 'hasRegistered' stamp: 'DB 11/8/2020 21:35:12'!
allTransactionsOf: anAccount In: aPortfolio

	anAccount transactions do: [ :aTransaction |
		self assert: (aPortfolio hasRegistered: aTransaction )
	].! !

!PortfolioTest methodsFor: 'hasRegistered' stamp: 'DB 11/8/2020 21:34:45'!
test06HasRegisteredReturnsFalseWithAnEmptyPortfolio

	| portfolio account1 |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount  new.
	Deposit register: 75 on: account1.
	
	self allTransactionOf: account1 NotIn: portfolio.! !

!PortfolioTest methodsFor: 'hasRegistered' stamp: 'DB 11/8/2020 21:35:12'!
test07HasRegisteredReturnsTrueWhenPortfolioHasOneTransaction

	| portfolio account1 |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount  new.
	Deposit register: 75 on: account1.
	
	portfolio add: account1.
	
	self allTransactionsOf: account1 In: portfolio .! !

!PortfolioTest methodsFor: 'hasRegistered' stamp: 'DB 11/8/2020 21:34:45'!
test08HasRegisteredReturnsFalseWhenPortfolioHasMoreThanOneTransaction

	| portfolio account1 account2 |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount  new.
	account2:= ReceptiveAccount  new.
	Deposit register: 75 on: account1.
	
	Deposit register: 89 on: account2.
	Deposit register: 78 on: account2.
	Deposit register: 56 on: account2.
	
	portfolio add: account1.
	
	self allTransactionOf: account2 NotIn: portfolio .! !


!PortfolioTest methodsFor: 'transactions' stamp: 'DB 11/4/2020 21:08:00'!
test09PortfolioHaveZeroTransactionsWhenIsCreated

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: (portfolio transactions isEmpty)! !

!PortfolioTest methodsFor: 'transactions' stamp: 'DB 11/8/2020 21:35:12'!
test10PortfolioHaveTheSameTransactionsThanYoursChild
	
	| portfolio  account |
	
	portfolio := Portfolio new.

	account := ReceptiveAccount  new.
	
	Deposit register: 89 on: account.
	Deposit register: 78 on: account.
	Deposit register: 56 on: account.
	
	portfolio add: account.
	
	self allTransactionsOf: account In: portfolio .! !

!PortfolioTest methodsFor: 'transactions' stamp: 'DB 11/8/2020 21:35:12'!
test11PortfolioHaveTheSameTransactionsThanYoursChilds
	
	| portfolio account1 account2 |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount  new.
	account2:= ReceptiveAccount  new.
	Deposit register: 75 on: account1.
	
	Deposit register: 89 on: account2.
	Deposit register: 78 on: account2.
	Deposit register: 56 on: account2.
	
	portfolio add: account1.
	portfolio add: account2.
	
	self allTransactionsOf: account1 In: portfolio .
	self allTransactionsOf: account2 In: portfolio.! !


!PortfolioTest methodsFor: 'tree' stamp: 'DB 11/8/2020 13:35:45'!
checkNoDuplicatedAsset:  anAsset1 in: anAsset2
	
	self should: [anAsset1 add: anAsset2.] 
		raise: Error 
		withMessageText: Portfolio duplicatedAccountOrPortfolioErrorDescription.
	! !

!PortfolioTest methodsFor: 'tree' stamp: 'DB 11/8/2020 13:35:45'!
test12DuplicatedAccountOrPortfolioError
	
	| portfolio |
	
	portfolio := Portfolio new.
	
	self checkNoDuplicatedAsset: portfolio in: portfolio.! !

!PortfolioTest methodsFor: 'tree' stamp: 'DB 11/8/2020 13:35:45'!
test13DuplicatedAccountOrPortfolioErrorWhenTryingToAddTheSameAccountTwice
	
	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account.
	
	self checkNoDuplicatedAsset: portfolio in: account.! !

!PortfolioTest methodsFor: 'tree' stamp: 'DB 11/8/2020 13:35:45'!
test14TwoPortfoliosCantContaintEachother 
	
	| portfolio1 portfolio2 |
	
	portfolio1 := Portfolio new.
	
	portfolio2 := Portfolio new.
	
	portfolio1 add: portfolio2.
	
	self checkNoDuplicatedAsset: portfolio2 in: portfolio1 .
	! !

!PortfolioTest methodsFor: 'tree' stamp: 'DB 11/8/2020 13:35:45'!
test15CannotCreateOneWayCycle 
	
	| portfolio1 portfolio2 portfolio3 |
	
	portfolio1 := Portfolio new.
	
	portfolio2 := Portfolio new.
	
	portfolio3 := Portfolio new.
	
	portfolio1 add: portfolio2.
	
	portfolio2 add: portfolio3.
	
	self checkNoDuplicatedAsset: portfolio3 in: portfolio1.! !

!PortfolioTest methodsFor: 'tree' stamp: 'DB 11/8/2020 13:37:48'!
test16ParentAndChildCannotContainSameTheAccount 

	
	| portfolio1 portfolio2 account |
	
	portfolio1 := Portfolio new.
	
	portfolio2 := Portfolio new.
	
	account := ReceptiveAccount new.
	
	portfolio1 add: account.
	
	portfolio1 add: portfolio2.
	
	self checkNoDuplicatedAsset: portfolio2 in: account.
	! !

!PortfolioTest methodsFor: 'tree' stamp: 'DB 11/8/2020 13:38:12'!
test17CannotCreateACycleWithMultipleRoots

	
	| rootPortfolio1 rootPortfolio2 rootPortfolio3 portfolio4 portfolio5 account |
	
	rootPortfolio1 := Portfolio new.
	rootPortfolio2 := Portfolio new.
	rootPortfolio3 := Portfolio new.
	portfolio4 := Portfolio new.
	portfolio5 := Portfolio new.
	
	account := ReceptiveAccount new.
	
	rootPortfolio1 add: portfolio4 .
	rootPortfolio2 add: portfolio4 .
	rootPortfolio3 add: portfolio4 .
	
	portfolio4 add: account .
	portfolio4 add: portfolio5 .
	
	self checkNoDuplicatedAsset: rootPortfolio1 in: account.
	self checkNoDuplicatedAsset: rootPortfolio2 in: account.
	self checkNoDuplicatedAsset: rootPortfolio3 in: account.
	self checkNoDuplicatedAsset: portfolio5 in: rootPortfolio1 .! !


!PortfolioTest methodsFor: 'balance' stamp: 'DB 11/8/2020 13:11:19'!
createEmptyPortfolioAndCheckBalance

	| portfolio |
	
	portfolio := Portfolio new.

	self assert: 0 equals: portfolio balance! !

!PortfolioTest methodsFor: 'balance' stamp: 'DB 11/8/2020 13:11:19'!
test01PortfolioHaveZeroAsBalanceWhenCreated 

	self createEmptyPortfolioAndCheckBalance.
! !

!PortfolioTest methodsFor: 'balance' stamp: 'DB 11/4/2020 20:10:17'!
test02PortfolioHasTheSameBalanceAsTheReceptiveAccount

	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	
	portfolio add: account.
		
	self assert: 100 equals: portfolio balance.
! !

!PortfolioTest methodsFor: 'balance' stamp: 'DB 11/4/2020 20:44:31'!
test03PortfolioHasTheSameBalanceWithMoreThanOneReceptiveAccount

	| portfolio  account1 account2 |
	
	portfolio := Portfolio new.
	account1 := ReceptiveAccount  new.
	Deposit register: 100 on: account1.
	
	account2 := ReceptiveAccount  new.
	Deposit register: 50 on: account2.
	
	portfolio add: account1.
	portfolio add: account2.
		
	self assert: 150 equals: portfolio balance.
! !

!PortfolioTest methodsFor: 'balance' stamp: 'DB 11/4/2020 20:48:58'!
test04PortfolioHasTheSameBalanceAsThePortfolioChild

	| portfolio  child account |
	
	portfolio := Portfolio new.
	child := Portfolio new.
	account := ReceptiveAccount  new.
	Deposit register: 75 on: account..
	
	child add: account.
	portfolio add: child.
		
	self assert: 75 equals: portfolio balance.
! !

!PortfolioTest methodsFor: 'balance' stamp: 'DB 11/4/2020 20:50:55'!
test05PortfolioHasTheSameBalanceWithMoreThanOneAsset

	| portfolio  child account1 account2 |
	
	portfolio := Portfolio new.
	child := Portfolio new.
	account1 := ReceptiveAccount  new.
	Deposit register: 75 on: account1.
	
	account2 := ReceptiveAccount new.
	Deposit register: 30 on: account2.
	
	child add: account1.
	portfolio add: child.
	portfolio add: account2.
		
	self assert: 105 equals: portfolio balance.
! !


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


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'DB 11/4/2020 20:03:44'!
contributeToBalance: aBalance 
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


!Deposit methodsFor: 'as yet unclassified' stamp: 'DB 11/4/2020 20:04:05'!
contributeToBalance: aBalance 
	^aBalance + value! !

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


!Withdraw methodsFor: 'as yet unclassified' stamp: 'DB 11/4/2020 20:04:53'!
contributeToBalance: aBalance 
	^aBalance - value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Asset category: 'Portfolio-Ejercicio'!
Object subclass: #Asset
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Asset methodsFor: 'initialization' stamp: 'DB 11/8/2020 11:22:04'!
initialize

	parents := OrderedCollection new.! !


!Asset methodsFor: 'tree' stamp: 'DB 11/7/2020 18:39:25'!
addParent: aParent
	parents add: aParent ! !

!Asset methodsFor: 'tree' stamp: 'DB 11/8/2020 13:43:34'!
anySatisfy: anAsset
	^self subclassResponsibility ! !

!Asset methodsFor: 'tree' stamp: 'DB 11/8/2020 13:39:09'!
includes: anAsset
	^false! !

!Asset methodsFor: 'tree' stamp: 'DB 11/8/2020 11:33:34'!
isRoot 
	^parents size = 0! !

!Asset methodsFor: 'tree' stamp: 'DB 11/8/2020 21:25:13'!
roots 
	| roots |	
	
	roots := OrderedCollection new.
	
	parents do: [:aParent | 
		(aParent isRoot) ifTrue: [ roots add: aParent ] ifFalse: [ roots addAllFirst: aParent roots ]
	].

	^roots.! !


!Asset methodsFor: 'operations' stamp: 'DB 11/8/2020 12:43:05'!
balance
	^self subclassResponsibility ! !

!Asset methodsFor: 'operations' stamp: 'DB 11/8/2020 12:45:22'!
hasRegistered: aTransaction
	^self subclassResponsibility ! !

!Asset methodsFor: 'operations' stamp: 'DB 11/8/2020 12:44:43'!
transactions
	^self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Asset subclass: #Portfolio
	instanceVariableNames: 'assets'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'DB 11/7/2020 18:34:25'!
initialize
	
	assets := OrderedCollection new.
	
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'transactions' stamp: 'DB 11/7/2020 18:42:22'!
hasRegistered: aTransaction 

	assets do: [:anAssets | 
		(anAssets value transactions includes: aTransaction) ifTrue: [^true]
	].

	^false.! !

!Portfolio methodsFor: 'transactions' stamp: 'DB 11/8/2020 14:03:28'!
transactions

	| transactions |
	transactions := OrderedCollection new.
	assets do: [:anAsset | 
		transactions addAll: (anAsset transactions)
	].
	^transactions.! !


!Portfolio methodsFor: 'operations' stamp: 'DB 11/8/2020 13:54:41'!
add: anAsset 

	self assertNoDuplicated: anAsset.
	
	self addTo: anAsset.! !

!Portfolio methodsFor: 'operations' stamp: 'DB 11/8/2020 13:53:17'!
addTo: anAsset 

	assets add: anAsset.
	anAsset addParent: self.! !

!Portfolio methodsFor: 'operations' stamp: 'DB 11/8/2020 13:43:34'!
anySatisfy: anAsset 

	^self includes: anAsset 
	
	

	! !

!Portfolio methodsFor: 'operations' stamp: 'DB 11/8/2020 13:44:12'!
includes: anAsset 
	
	(self = anAsset) ifTrue: [^true].

	assets do: [ :aChildAsset | 
		(aChildAsset anySatisfy: anAsset) ifTrue: [^true]
	].

	^false.
	
	
	

	! !


!Portfolio methodsFor: 'balance' stamp: 'DB 11/4/2020 20:48:45'!
balance

	^assets sum: [:anAssets |  anAssets balance.] ifEmpty: [0]

	
	! !


!Portfolio methodsFor: 'asserts' stamp: 'DB 11/8/2020 13:56:08'!
assertNoDuplicated: anAsset 
	
	((anAsset = self) or: (assets includes: anAsset) or: (anAsset includes: self)) ifTrue: [^self class signalDuplicatedAccountOrPortfolio ].
	
	self assertNoDuplicatedFromRoots: anAsset.
	! !

!Portfolio methodsFor: 'asserts' stamp: 'DB 11/8/2020 13:55:54'!
assertNoDuplicatedFromRoots: anAsset 
	
	anAsset roots do: [:aRootAsset | 
		(aRootAsset includes: self ) ifTrue: [^self class signalDuplicatedAccountOrPortfolio ]
	].

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'DB 11/4/2020 21:27:12'!
duplicatedAccountOrPortfolioErrorDescription
	^'Duplicated account or portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'DB 11/4/2020 21:27:57'!
signalDuplicatedAccountOrPortfolio
	self error: self duplicatedAccountOrPortfolioErrorDescription ! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Asset subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'DB 11/8/2020 11:28:11'!
initialize

	transactions := OrderedCollection new.
	super initialize ! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'DB 11/8/2020 13:43:34'!
anySatisfy: anAsset		
	^self  = anAsset ! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'DB 11/4/2020 20:02:55'!
balance

	| balance |
	balance := 0.
	
	transactions do: [ :aTransaction |
		balance := aTransaction contributeToBalance: balance.
	].
	
	^balance.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
