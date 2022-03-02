!classDefinition: #ProtfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ProtfolioTest
	instanceVariableNames: 'portfolio portfolio2 portfolio3 account account2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ProtfolioTest methodsFor: 'testing' stamp: 'GR 11/7/2020 17:19:27'!
test01PortfolioStartsWithBalanceCero

	self assert: portfolio isEmpty.
	self assert: 0 equals: portfolio balance.! !

!ProtfolioTest methodsFor: 'testing' stamp: 'GR 11/7/2020 17:19:46'!
test02BalanceWithAnAccount

	Deposit register: 100 on: account.
	portfolio addAccount: account.
	
	self deny: portfolio isEmpty.
	self assert: 100 equals: portfolio balance.! !

!ProtfolioTest methodsFor: 'testing' stamp: 'GR 11/7/2020 17:20:04'!
test03BalanceWithAnAccountAndAPortfolio

	Deposit register: 100 on: account.
	Deposit register: 50 on: account2.
	
	portfolio addAccount: account.
	portfolio2 addAccount: account2.
	portfolio addPortfolio: portfolio2.
	
	self assert: 150 equals: portfolio balance.! !

!ProtfolioTest methodsFor: 'testing' stamp: 'GR 11/7/2020 17:19:27'!
test04TransactionsOfEmptyPortfolioReturnsNoTransactions

	self assert: OrderedCollection new equals: portfolio transactions.! !

!ProtfolioTest methodsFor: 'testing' stamp: 'GR 11/7/2020 17:19:46'!
test05TransactionsOfPortfolioWithAnAccountReturnsTransactionsOfThatAccount

	| deposit |
	
	deposit := Deposit register: 100 on: account.
	portfolio addAccount: account.
	
	self assert: (OrderedCollection with: deposit) equals: portfolio transactions.! !

!ProtfolioTest methodsFor: 'testing' stamp: 'GR 11/7/2020 17:19:51'!
test06TransactionsOfPortfolioWithAnAccountAndAPortfolioReturnsEveryTransaction

	| deposit1 deposit2 |
	
	deposit1 := Deposit register: 100 on: account.
	deposit2 := Deposit register: 50 on: account2.
	
	portfolio addAccount: account.
	portfolio2 addAccount: account2.
	portfolio addPortfolio: portfolio2 .
	
	self assert: (( portfolio transactions includes: deposit1 ) and: (portfolio transactions includes: deposit2)).! !

!ProtfolioTest methodsFor: 'testing' stamp: 'GR 11/7/2020 17:19:27'!
test07EmptyPortfolioHasNotARegisteredTransaction

	| deposit |
	
	deposit := Deposit for: 100.
	
	self deny: (portfolio hasRegistered: deposit).! !

!ProtfolioTest methodsFor: 'testing' stamp: 'GR 11/7/2020 17:19:46'!
test08PortfolioWithAccountHasARegisteredTransactionInAnyAccount

	| deposit |
	
	deposit := Deposit register: 100 on: account.
	
	portfolio addAccount: account.
	
	self assert: (portfolio hasRegistered: deposit).! !

!ProtfolioTest methodsFor: 'testing' stamp: 'GR 11/7/2020 17:19:51'!
test09PortfolioWithAccountAndAPortfolioHasARegisteredTransactionInAnyAccount

	| deposit |
	
	Deposit register: 100 on: account.
	deposit := Deposit register: 50 on: account2.
	
	portfolio addAccount: account.
	portfolio2 addAccount: account2.
	portfolio addPortfolio: portfolio2 .
	
	self assert: (portfolio hasRegistered: deposit).! !

!ProtfolioTest methodsFor: 'testing' stamp: 'GR 11/7/2020 17:19:27'!
test10CanNotAddAPortfolioToItself

	self
		should: [ portfolio addPortfolio: portfolio ]
		raise: Error
		withMessageText: Portfolio cycleHierarchyError! !

!ProtfolioTest methodsFor: 'testing' stamp: 'GR 11/7/2020 17:19:31'!
test11CanNotAddAPortfolioThatAlreadyExistsInThePortfolio

	
	portfolio addPortfolio: portfolio2.
	
	self
		should: [ portfolio addPortfolio: portfolio2 ]
		raise: Error
		withMessageText: Portfolio cycleHierarchyError! !

!ProtfolioTest methodsFor: 'testing' stamp: 'GR 11/7/2020 17:19:35'!
test12CanNotAddToPortfolioAnyOfItsParents

	portfolio addPortfolio: portfolio3.
	portfolio2 addPortfolio: portfolio3.
	
	self
		should: [ portfolio3 addPortfolio: portfolio ]
		raise: Error
		withMessageText: Portfolio cycleHierarchyError.
	
	self
		should: [ portfolio3 addPortfolio: portfolio2 ]
		raise: Error
		withMessageText: Portfolio cycleHierarchyError.! !

!ProtfolioTest methodsFor: 'testing' stamp: 'GR 11/7/2020 17:19:35'!
test13CanNotAddToPortfolioAnAlreadyGrandchildPortfolio

	portfolio addPortfolio: portfolio2.
	portfolio2 addPortfolio: portfolio3.
	
	self
		should: [ portfolio addPortfolio: portfolio3 ]
		raise: Error
		withMessageText: Portfolio cycleHierarchyError.! !

!ProtfolioTest methodsFor: 'testing' stamp: 'GR 11/7/2020 17:19:35'!
test14CanNotAddToPortfolioAnAlreadyGrandparentPortfolio

	portfolio addPortfolio: portfolio2.
	portfolio2 addPortfolio: portfolio3.
	
	self
		should: [ portfolio3 addPortfolio: portfolio ]
		raise: Error
		withMessageText: Portfolio cycleHierarchyError.! !

!ProtfolioTest methodsFor: 'testing' stamp: 'GR 11/7/2020 17:19:34'!
test15CanNotAddToPortfolioAPortfolioInAnotherBranch

	portfolio addPortfolio: portfolio2.
	portfolio addPortfolio: portfolio3.
	
	self
		should: [ portfolio2 addPortfolio: portfolio3 ]
		raise: Error
		withMessageText: Portfolio cycleHierarchyError.! !

!ProtfolioTest methodsFor: 'testing' stamp: 'GR 11/7/2020 17:19:35'!
test16CanNotAddToPortfolioAPortfolioThatContainsIt

	portfolio addPortfolio: portfolio2.
	portfolio3 addPortfolio: portfolio.
	
	self
		should: [ portfolio2 addPortfolio: portfolio3 ]
		raise: Error
		withMessageText: Portfolio cycleHierarchyError.! !

!ProtfolioTest methodsFor: 'testing' stamp: 'GR 11/7/2020 17:19:46'!
test17CanNotAddAnAccountToPortfolioThatAlreadyExistsInTheHierarchy

	portfolio addPortfolio: portfolio2.
	portfolio2 addAccount: account.
	
	self
		should: [ portfolio addAccount: account ]
		raise: Error
		withMessageText: Portfolio cycleHierarchyError.! !


!ProtfolioTest methodsFor: 'as yet unclassified' stamp: 'GR 11/7/2020 17:19:51'!
setUp

	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	account  := ReceptiveAccount new.
	account2  := ReceptiveAccount new.! !


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


!AccountTransaction methodsFor: 'private' stamp: 'GR 11/9/2020 17:39:47'!
addToBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'GR 11/2/2020 19:25:38'!
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


!Deposit methodsFor: 'private' stamp: 'GR 11/2/2020 20:17:36'!
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


!Withdraw methodsFor: 'private' stamp: 'GR 11/2/2020 20:17:17'!
addToBalance: aBalance

	^ aBalance - value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #BankingEntity category: 'Portfolio-Ejercicio'!
Object subclass: #BankingEntity
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!BankingEntity methodsFor: 'balance' stamp: 'GR 11/8/2020 18:36:47'!
balance

	self subclassResponsibility.! !


!BankingEntity methodsFor: 'testing' stamp: 'GR 11/8/2020 18:37:06'!
hasRegistered: aTransaction

	self subclassResponsibility.! !


!BankingEntity methodsFor: 'transactions' stamp: 'GR 11/8/2020 18:37:35'!
transactions

	self subclassResponsibility.! !


!BankingEntity methodsFor: 'private' stamp: 'GR 11/8/2020 18:34:41'!
addRootsOfParent: aPortfolio

	self subclassResponsibility.! !

!BankingEntity methodsFor: 'private' stamp: 'GR 11/8/2020 18:34:34'!
lookFor: bankingEntity 

	self subclassResponsibility.! !

!BankingEntity methodsFor: 'private' stamp: 'GR 11/8/2020 18:34:05'!
seeIfAlreadyInHierarchy: bankingEntity

	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
BankingEntity subclass: #Portfolio
	instanceVariableNames: 'bankingEntities rootPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'accessing' stamp: 'GR 11/7/2020 16:11:24'!
isEmpty
	
	^ bankingEntities isEmpty! !

!Portfolio methodsFor: 'accessing' stamp: 'GR 11/7/2020 16:18:07'!
rootPortfolios
	
	^rootPortfolios! !


!Portfolio methodsFor: 'initialization' stamp: 'GR 11/7/2020 16:21:33'!
initialize

	bankingEntities := Set new.
	rootPortfolios  := Set with: self.! !


!Portfolio methodsFor: 'adding' stamp: 'GR 11/9/2020 16:50:36'!
addAccount: aReceptiveAccount 
	
	self addBankingEntity: aReceptiveAccount ! !

!Portfolio methodsFor: 'adding' stamp: 'GR 11/9/2020 16:50:56'!
addPortfolio: aPortfolio 
	
	self addBankingEntity: aPortfolio.
	
	aPortfolio addRootsOfParent: self! !


!Portfolio methodsFor: 'testing' stamp: 'GR 11/9/2020 18:08:30'!
hasRegistered: aTransaction
	
	^ bankingEntities inject: false into: [ :hasRegistered :aBankingEntity |  hasRegistered or: (aBankingEntity  hasRegistered: aTransaction) ]! !


!Portfolio methodsFor: 'private' stamp: 'GR 11/7/2020 16:47:13'!
addRootsOfParent: aPortfolio 
	
	rootPortfolios addAll: aPortfolio rootPortfolios.
	bankingEntities do: [ :aBankingEntity | aBankingEntity addRootsOfParent: aPortfolio ].
	rootPortfolios remove: self ifAbsent: [].! !

!Portfolio methodsFor: 'private' stamp: 'GR 11/7/2020 16:51:51'!
lookFor: bankingEntity 
	
	bankingEntities 
		detect: [ :aBankingEntity | aBankingEntity lookFor: bankingEntity ]
		ifFound: [ :aBankingEntity | ^true ]
		ifNone: [ ^ self == bankingEntity ]! !

!Portfolio methodsFor: 'private' stamp: 'GR 11/9/2020 18:09:25'!
seeIfAlreadyInHierarchy: bankingEntity
	
	^ rootPortfolios inject: false into: [ :isInTheHierarchy :aRootPortfolio | isInTheHierarchy or: (aRootPortfolio lookFor: bankingEntity)]! !


!Portfolio methodsFor: 'transactions' stamp: 'GR 11/9/2020 18:15:20'!
transactions

	^ bankingEntities inject: OrderedCollection new addingAll: [:aBankingEntity | aBankingEntity transactions].! !


!Portfolio methodsFor: 'balance' stamp: 'GR 11/9/2020 18:08:19'!
balance
	
	^ bankingEntities inject: 0 into: [:totalBalance :aBankingEntity | totalBalance + aBankingEntity balance]! !


!Portfolio methodsFor: 'adding -- private' stamp: 'GR 11/9/2020 16:52:01'!
addBankingEntity: aBankingEntity

	(self seeIfAlreadyInHierarchy: aBankingEntity) ifTrue: [self error: self class cycleHierarchyError ].
	
	bankingEntities add: aBankingEntity! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error handling' stamp: 'GR 11/4/2020 15:15:00'!
cycleHierarchyError

	^ 'You are adding an account or portfolio that already exists in the hierarchy'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
BankingEntity subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'GR 11/9/2020 18:32:15'!
balance
	
	^ transactions inject: 0 into: [ :aBalance :aTransaction | aTransaction addToBalance: aBalance].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'private' stamp: 'GR 11/7/2020 16:55:19'!
addRootsOfParent: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'private' stamp: 'GR 11/7/2020 16:53:26'!
lookFor: aBankingEntity 
	
	^ self == aBankingEntity! !
