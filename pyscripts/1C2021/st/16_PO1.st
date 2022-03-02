!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'Ciro 5/25/2021 17:03:24'!
test01PortfolioHaveZeroAsBalanceWhenCreated 

	| emptyPortfolio |
	
	emptyPortfolio := Portfolio new.

	self assert: 0 equals: emptyPortfolio balance.
	self assert: 0 equals: emptyPortfolio transactionsSize! !

!PortfolioTest methodsFor: 'tests' stamp: 'Ciro 5/25/2021 17:02:32'!
test02AddNewReceptiveAccount

	| simplePortfolio receptiveAccount |
	
	simplePortfolio _ Portfolio new.
	receptiveAccount _ ReceptiveAccount new.
	simplePortfolio addAccount: receptiveAccount.

	self assert: 0 equals: simplePortfolio balance.
	self assert: (simplePortfolio hasAccount: receptiveAccount).
	self assert: 1 equals: simplePortfolio allAccountsSize.! !

!PortfolioTest methodsFor: 'tests' stamp: 'Ciro 5/25/2021 17:02:23'!
test03PortfolioKnowsRegisteredTransactions 

	| simplePortfolio receptiveAccount deposit |
	
	simplePortfolio _ Portfolio new.
	receptiveAccount _ ReceptiveAccount  new.
	simplePortfolio addAccount: receptiveAccount.
	deposit _ Deposit register: 100 on: receptiveAccount.
		
	self assert: (simplePortfolio hasAccount: receptiveAccount).
	self assert: 100 equals: simplePortfolio balance.
	self assert: 1 equals: simplePortfolio transactionsSize.
	self assert: (simplePortfolio hasRegistered: deposit).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Ciro 5/25/2021 17:33:16'!
test04PortfolioDoNotKnowsNotRegisteredTransactions

	| emptyPortfolio deposit withdraw|
	
	emptyPortfolio _ Portfolio new.
	deposit _ Deposit for:100.
	withdraw _ Withdraw for: 50.
		
	self assert: 0 equals: emptyPortfolio balance.
	self assert: 0 equals: emptyPortfolio transactionsSize.
	self deny: (emptyPortfolio hasRegistered: deposit).
	self deny: (emptyPortfolio hasRegistered: withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Ciro 5/25/2021 17:34:25'!
test05AddMultipleTransactions

	|composedPortfolio aReceptiveAccount anotherReceptiveAccount aDeposit anotherDeposit withdraw |
	
	composedPortfolio _ Portfolio new.
	aReceptiveAccount _ ReceptiveAccount new.
	anotherReceptiveAccount _ ReceptiveAccount new.
	composedPortfolio addAccount: aReceptiveAccount.
	composedPortfolio addAccount: anotherReceptiveAccount.
	aDeposit _ Deposit register: 100 on: aReceptiveAccount. 
	anotherDeposit _ Deposit register: 200 on: anotherReceptiveAccount.
	withdraw _ Withdraw register: 50 on: anotherReceptiveAccount.
	
	self assert: 2 equals: composedPortfolio allAccountsSize.
	self assert: 3 equals: composedPortfolio transactionsSize.
	self assert: (composedPortfolio hasAccount: aReceptiveAccount).
	self assert: (composedPortfolio hasAccount: anotherReceptiveAccount).
	self assert: (composedPortfolio hasRegistered: aDeposit).
	self assert: (composedPortfolio hasRegistered: anotherDeposit).
	self assert: (composedPortfolio hasRegistered: withdraw).! !

!PortfolioTest methodsFor: 'tests' stamp: 'Ciro 5/25/2021 17:31:53'!
test06CreateSimplePortfolio

	| simplePortfolio emptyPortfolio |
	
	simplePortfolio _ Portfolio new.
	emptyPortfolio _ Portfolio new.
	simplePortfolio addAccount: emptyPortfolio.
	
	self assert: 1 equals: simplePortfolio allAccountsSize.
	self assert: (simplePortfolio hasAccount: emptyPortfolio).! !

!PortfolioTest methodsFor: 'tests' stamp: 'Ciro 5/25/2021 17:31:40'!
test07CreateComposedPortfolio

	| composedPortfolio simplePortfolio aReceptiveAccount anotherReceptiveAccount |
	
	composedPortfolio _ Portfolio new.
	simplePortfolio _ Portfolio new.
	aReceptiveAccount _ ReceptiveAccount new.
	anotherReceptiveAccount _ ReceptiveAccount new.
	composedPortfolio addAccount: aReceptiveAccount.
	simplePortfolio addAccount: anotherReceptiveAccount.
	composedPortfolio addAccount: simplePortfolio.
	
	self assert: 3 equals: composedPortfolio allAccountsSize.
	self assert: 1 equals: simplePortfolio allAccountsSize.
	self assert: (composedPortfolio hasAccount: aReceptiveAccount).
	self assert: (composedPortfolio hasAccount: simplePortfolio).
	self assert: (simplePortfolio hasAccount: anotherReceptiveAccount).! !

!PortfolioTest methodsFor: 'tests' stamp: 'Ciro 5/25/2021 17:31:14'!
test08BalanceFromAComposedPortfolio

	| composedPortfolio simplePortfolio aReceptiveAccount anotherReceptiveAccount deposit1 deposit2 |
	
	composedPortfolio _ Portfolio new.
	simplePortfolio _ Portfolio new.
	aReceptiveAccount _ ReceptiveAccount new.
	anotherReceptiveAccount _ ReceptiveAccount new.
	deposit1 _ Deposit register: 100 on: aReceptiveAccount.
	deposit2 _ Deposit register: 100 on: anotherReceptiveAccount. 
	composedPortfolio addAccount: aReceptiveAccount.
	simplePortfolio addAccount: anotherReceptiveAccount.
	composedPortfolio addAccount: simplePortfolio.
	
	self assert: 200 equals: composedPortfolio balance.
	self assert: 100 equals: simplePortfolio balance.
	self assert: 2 equals: composedPortfolio transactionsSize.
	self assert: 1 equals: simplePortfolio transactionsSize.
	self assert: (composedPortfolio hasRegistered: deposit1).
	self assert: (composedPortfolio hasRegistered: deposit2).
	self assert: (simplePortfolio hasRegistered: deposit2).! !

!PortfolioTest methodsFor: 'tests' stamp: 'Ciro 5/25/2021 17:30:39'!
test09ThereCanBeNoDuplicatedAccounts

	| composedPortfolio simplePortfolioInTheTree simplePortfolioOutTheTree aReceptiveAccount sharedReceptiveAccount  |
	
	composedPortfolio _ Portfolio new.
	simplePortfolioInTheTree _ Portfolio new.
	simplePortfolioOutTheTree _ Portfolio new.
	aReceptiveAccount _ ReceptiveAccount new.
	sharedReceptiveAccount _ ReceptiveAccount new. 
	composedPortfolio addAccount: aReceptiveAccount.
	simplePortfolioInTheTree addAccount: sharedReceptiveAccount.
	simplePortfolioOutTheTree addAccount: sharedReceptiveAccount.
	composedPortfolio addAccount: simplePortfolioInTheTree.
	
	self should: [ 	composedPortfolio addAccount: simplePortfolioOutTheTree ] 
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: composedPortfolio invalidAccountAddedErrorDescription.
			self assert: (composedPortfolio hasAccount: aReceptiveAccount).
			self assert: (composedPortfolio hasAccount: sharedReceptiveAccount).
			self assert: (simplePortfolioInTheTree hasAccount: sharedReceptiveAccount).
			self assert: (simplePortfolioOutTheTree hasAccount: sharedReceptiveAccount).
			self assert: (composedPortfolio hasAccount: simplePortfolioInTheTree).
			self deny: (composedPortfolio hasAccount: simplePortfolioOutTheTree).]! !

!PortfolioTest methodsFor: 'tests' stamp: 'Ciro 5/25/2021 17:28:16'!
test10CanNotAddMyParent

	| simplePortfolio emptyPortfolio |
	
	simplePortfolio _ Portfolio new.
	emptyPortfolio _ Portfolio new.
	simplePortfolio addAccount: emptyPortfolio.
	
	self should: [ 	emptyPortfolio addAccount: simplePortfolio. ] 
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: simplePortfolio invalidAccountAddedErrorDescription.
			self assert: (simplePortfolio hasAccount: emptyPortfolio).
			self deny: (emptyPortfolio hasAccount: simplePortfolio).]! !

!PortfolioTest methodsFor: 'tests' stamp: 'Ciro 5/25/2021 17:27:13'!
test11CanNotAddAnAccountThatBelongsToMyChildsAccounts

	| rootPortfolio fatherPortfolio childrenPortfolio |
	
	rootPortfolio _ Portfolio new.
	fatherPortfolio _ Portfolio new.
	childrenPortfolio _ Portfolio new.
	rootPortfolio addAccount: fatherPortfolio.
	fatherPortfolio addAccount: childrenPortfolio.
	
	self should: [ 	rootPortfolio addAccount: childrenPortfolio. ] 
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: rootPortfolio invalidAccountAddedErrorDescription.
			self assert: 2 equals: rootPortfolio allAccountsSize.
			self assert: 1 equals: fatherPortfolio allAccountsSize.
			self assert: 0 equals: childrenPortfolio allAccountsSize.]! !

!PortfolioTest methodsFor: 'tests' stamp: 'Ciro 5/25/2021 17:39:01'!
test12CanNotAddARootsChildrenToAChildren

	| childrenPortfolio aRootPortfolio anotherRootPortfolio sharedReceptiveAccount |
	
	childrenPortfolio _ Portfolio new.
	aRootPortfolio _ Portfolio new.	
	anotherRootPortfolio _ Portfolio new.	
	sharedReceptiveAccount _ ReceptiveAccount new.	
	aRootPortfolio addAccount: childrenPortfolio.
	anotherRootPortfolio addAccount: childrenPortfolio.
	aRootPortfolio addAccount: sharedReceptiveAccount.
	anotherRootPortfolio addAccount: sharedReceptiveAccount.
	
	self should: [ 	childrenPortfolio addAccount: sharedReceptiveAccount. ] 
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: childrenPortfolio invalidAccountAddedErrorDescription.
			self assert: (aRootPortfolio hasAccount: sharedReceptiveAccount).
			self assert: (anotherRootPortfolio hasAccount: sharedReceptiveAccount).
			self deny: (childrenPortfolio hasAccount: sharedReceptiveAccount).]! !

!PortfolioTest methodsFor: 'tests' stamp: 'Ciro 5/25/2021 17:19:40'!
test13CanNotAddMyself

	| emptyPortfolio |
	
	emptyPortfolio _ Portfolio new.
	
	self should: [ 	emptyPortfolio addAccount: emptyPortfolio. ] 
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: emptyPortfolio invalidAccountAddedErrorDescription.
			self deny: (emptyPortfolio hasAccount: emptyPortfolio).]! !

!PortfolioTest methodsFor: 'tests' stamp: 'Ciro 5/25/2021 17:27:24'!
test14CanNotAddToAChildrenAnAccountThatBelongsToTheFathersChildren

	| composedPortfolio emptyPortfolio receptiveAccount |
	
	composedPortfolio _ Portfolio new.
	emptyPortfolio _ Portfolio new.	
	receptiveAccount _ ReceptiveAccount new.	
	composedPortfolio addAccount: emptyPortfolio.
	composedPortfolio addAccount: receptiveAccount.
	
	self should: [ 	emptyPortfolio addAccount: receptiveAccount. ] 
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: emptyPortfolio invalidAccountAddedErrorDescription.
			self assert: (composedPortfolio hasAccount: receptiveAccount).
			self assert: (composedPortfolio hasAccount: emptyPortfolio).
			self deny: (emptyPortfolio hasAccount: receptiveAccount).]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'Ciro 5/19/2021 15:56:16'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'Ciro 5/19/2021 15:56:19'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'Ciro 5/19/2021 15:56:23'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'Ciro 5/19/2021 15:56:26'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'Ciro 5/19/2021 15:56:28'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'Ciro 5/19/2021 15:56:30'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'Ciro 5/19/2021 15:56:34'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #Account category: 'Portfolio-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Account methodsFor: 'private' stamp: 'Ciro 5/24/2021 16:33:02'!
accounts
	
	self subclassResponsibility 
		! !

!Account methodsFor: 'private' stamp: 'Ciro 5/24/2021 16:49:12'!
addChildrenTo: aSequenceOfAccounts

	self subclassResponsibility! !

!Account methodsFor: 'private' stamp: 'Ciro 5/24/2021 16:30:13'!
addParent: anAccount

	self subclassResponsibility ! !

!Account methodsFor: 'private' stamp: 'Ciro 5/24/2021 17:33:50'!
addTransactionTo: aSequenceOfAccounts

	self subclassResponsibility! !

!Account methodsFor: 'private' stamp: 'Ciro 5/24/2021 16:17:06'!
contains: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'Ciro 5/24/2021 17:19:09'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'Ciro 5/24/2021 17:18:36'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'testing' stamp: 'Ciro 5/24/2021 16:41:20'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'assertions' stamp: 'Ciro 5/24/2021 15:48:25'!
assertCanAdd: anAccount 

	(self checkFromRoot: anAccount) ifTrue: [ self error: self invalidAccountAddedErrorDescription ]! !


!Portfolio methodsFor: 'adding' stamp: 'Ciro 5/23/2021 20:48:40'!
addAccount: anAccount

	self assertCanAdd: anAccount.

	accounts add: anAccount.
	anAccount addParent: self.! !


!Portfolio methodsFor: 'error description' stamp: 'Ciro 5/23/2021 20:45:01'!
invalidAccountAddedErrorDescription

	^ 'Invalid account added'! !


!Portfolio methodsFor: 'initialization' stamp: 'Ciro 5/23/2021 20:56:13'!
initialize

	accounts _ OrderedCollection new.
	parents _ OrderedCollection  new.! !


!Portfolio methodsFor: 'balance' stamp: 'Ciro 5/23/2021 21:00:47'!
balance
	
	^ accounts sum:[ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'private' stamp: 'Ciro 5/24/2021 17:12:11'!
addChildrenTo: aSequenceOfAccounts
	
	aSequenceOfAccounts add: self.
	
	accounts do: [ :anAccount | anAccount addChildrenTo: aSequenceOfAccounts ]! !

!Portfolio methodsFor: 'private' stamp: 'Ciro 5/24/2021 16:29:48'!
addParent: anAccount

	parents add: anAccount! !

!Portfolio methodsFor: 'private' stamp: 'Ciro 5/24/2021 16:09:52'!
addRoots: aSequenceOfRoots

 	parents ifEmpty: [ aSequenceOfRoots add: self ]
		ifNotEmpty: [ parents do: [ :aParent | aParent addRoots: aSequenceOfRoots ]]! !

!Portfolio methodsFor: 'private' stamp: 'Ciro 5/24/2021 17:33:27'!
addTransactionTo: aSequenceOfAccounts
	
	accounts do: [ :anAccount | anAccount addTransactionTo: aSequenceOfAccounts ]! !

!Portfolio methodsFor: 'private' stamp: 'Ciro 5/24/2021 16:51:42'!
allAccounts
	
	| allAccounts |
	
	allAccounts _ OrderedCollection new.
	
	accounts do: [ :anAccount | anAccount addChildrenTo: allAccounts ].
	
	^ allAccounts! !

!Portfolio methodsFor: 'private' stamp: 'Ciro 5/24/2021 16:29:24'!
checkFromRoot: anAccount 

	^ self roots anySatisfy: [ :aRoot | aRoot contains: anAccount ]! !

!Portfolio methodsFor: 'private' stamp: 'Ciro 5/25/2021 17:43:20'!
contains: anAccount 

	^ self = anAccount 
		or: [ accounts anySatisfy: [ :anotherAccount | (anotherAccount contains: anAccount) 
			or: [anAccount contains: anotherAccount]]]! !

!Portfolio methodsFor: 'private' stamp: 'Ciro 5/24/2021 15:53:54'!
roots

	| allRoots |
	
	allRoots _ OrderedCollection new.

	self addRoots: allRoots.
	
	^ allRoots.! !


!Portfolio methodsFor: 'testing' stamp: 'Ciro 5/24/2021 17:15:30'!
allAccountsSize
	
	^ self allAccounts size! !

!Portfolio methodsFor: 'testing' stamp: 'Ciro 5/24/2021 17:13:29'!
hasAccount: anAccount
	
	^ self allAccounts includes: anAccount! !

!Portfolio methodsFor: 'testing' stamp: 'Ciro 5/24/2021 17:37:16'!
hasRegistered: anAccountTransaction

	^ self transactions includes: anAccountTransaction ! !

!Portfolio methodsFor: 'testing' stamp: 'Ciro 5/24/2021 17:34:57'!
transactionsSize
		
	^ self transactions size! !


!Portfolio methodsFor: 'transactions' stamp: 'Ciro 5/24/2021 17:32:55'!
transactions

	| transactions |
	
	transactions _ OrderedCollection new.
	
	accounts do: [ :anAccount | anAccount addTransactionTo: transactions ].
	
	^ transactions! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'Ciro 5/19/2021 15:56:58'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'Ciro 5/19/2021 15:56:50'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'Ciro 5/19/2021 15:56:54'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'Ciro 5/19/2021 16:23:21'!
balance

	^transactions
		inject: 0
		into: [:actualBalance :transaction | transaction modifyBalance: actualBalance]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'Ciro 5/19/2021 15:56:44'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'private' stamp: 'Ciro 5/24/2021 16:44:12'!
accounts

	^ self! !

!ReceptiveAccount methodsFor: 'private' stamp: 'Ciro 5/24/2021 17:12:20'!
addChildrenTo: aSequenceOfAccounts
	
	aSequenceOfAccounts add: self! !

!ReceptiveAccount methodsFor: 'private' stamp: 'Ciro 5/24/2021 16:30:21'!
addParent: anAccount! !

!ReceptiveAccount methodsFor: 'private' stamp: 'Ciro 5/24/2021 17:34:11'!
addTransactionTo: aSequenceOfAccounts
	
	aSequenceOfAccounts addAll: self transactions ! !

!ReceptiveAccount methodsFor: 'private' stamp: 'Ciro 5/24/2021 16:17:18'!
contains: anAccount

	^ self = anAccount ! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'Ciro 5/19/2021 16:24:13'!
modifyBalance: actualBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'Ciro 5/19/2021 15:57:22'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'Ciro 5/19/2021 15:57:25'!
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

!Deposit methodsFor: 'initialization' stamp: 'Ciro 5/19/2021 15:57:17'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'Ciro 5/19/2021 16:24:52'!
modifyBalance: actualBalance

	^ actualBalance + value! !

!Deposit methodsFor: 'value' stamp: 'Ciro 5/19/2021 15:57:14'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'Ciro 5/19/2021 15:57:30'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'Ciro 5/19/2021 15:57:02'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'Ciro 5/19/2021 16:25:02'!
modifyBalance: actualBalance

	^ actualBalance - value! !

!Withdraw methodsFor: 'value' stamp: 'Ciro 5/19/2021 15:57:08'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'Ciro 5/19/2021 15:57:33'!
for: aValue

	^ self new initializeFor: aValue ! !
