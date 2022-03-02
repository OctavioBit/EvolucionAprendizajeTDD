!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'private' stamp: 'ET 5/25/2021 02:15:09'!
portfolioWithOneAccountWith100Deposit

	|portfolio|
	
	portfolio := Portfolio new.
	
	portfolio addFinancialEntity: self receptiveAccountWith100Deposit.
	
	
	^portfolio! !

!PortfolioTest methodsFor: 'private' stamp: 'ET 5/25/2021 01:53:02'!
receptiveAccountWith100Deposit

	|account|
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	^account.! !


!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 01:24:04'!
test01NewPortfolioHasZeroBalance

	|portfolio|
	
	portfolio := Portfolio new.
	
	self assert: 0 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 02:13:53'!
test02PortfolioWithOneAccountHasTheSameBalanceAsTheAccount

	|portfolio|
	
	portfolio := self portfolioWithOneAccountWith100Deposit.
	
	self assert: 100 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 02:15:38'!
test03PortfolioWithTwoAccountsHasBalanceTheSumOfTheBalancesOfItsAccounts

	|portfolio|
	
	portfolio := self portfolioWithOneAccountWith100Deposit.
	portfolio addFinancialEntity: self receptiveAccountWith100Deposit.
	
	self assert: 200 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 01:30:49'!
test04PortfolioRegistersTransactionsOfItsOnlyAddedAccount

	|portfolio account deposit|
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	
	portfolio addFinancialEntity: account.
	
	
	self assert: (portfolio hasRegistered: deposit).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 01:34:40'!
test05PortfolioHasOnlyRegisteredTransactionsOfItsAccounts

	|portfolio account deposit|
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	deposit := Deposit for: 100.
	
	portfolio addFinancialEntity: account.
	
	
	self deny: (portfolio hasRegistered: deposit).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 02:16:43'!
test06PortfolioRegistersTransactionsOfAllOfItsAccounts

	|portfolio account  deposit|
	
	portfolio := self portfolioWithOneAccountWith100Deposit.
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: account.
	
	portfolio addFinancialEntity: account.
	
	
	self assert: (portfolio hasRegistered: deposit).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 02:17:15'!
test07PortfolioKnowsTransactionOfItsOnlyAccount

	|portfolio account deposit|
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.

	deposit := Deposit register: 100 on: account.
	
	portfolio addFinancialEntity: account.
		
	self assert: 1 equals: portfolio transactions size.
	self assert: (portfolio transactions includes: deposit).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 01:51:01'!
test08PortfolioKnowsTransactionOfAllOfItsAccounts

	|portfolio account1 account2 deposit withdraw |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	
	account2 := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: account1.
	
	withdraw := Withdraw register: 100 on: account2.
	
	portfolio addFinancialEntity: account1.
	portfolio addFinancialEntity: account2.
		
	self assert: 2 equals: portfolio transactions size.
	self assert: (portfolio transactions includes: deposit).
	self assert: (portfolio transactions includes: withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 01:35:18'!
test09PortfolioWithEmptyPortfolioHasZeroBalance

	|portfolioParent portfolioChild|
	
	portfolioParent := Portfolio new.
	
	portfolioChild := Portfolio new.
	
	portfolioParent addFinancialEntity: portfolioChild.
	
	
		
	self assert: 0 equals: portfolioParent balance.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 02:19:11'!
test10PortfolioWithNonEmptyPortfolioHasItsBalance

	|portfolioParent portfolioChild|
	
	portfolioParent := Portfolio new.
	
	portfolioChild := self portfolioWithOneAccountWith100Deposit.
	
	portfolioParent addFinancialEntity: portfolioChild.
	
	
		
	self assert: 100 equals: portfolioParent balance.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 02:19:40'!
test11PortfolioWithTwoPortfoliosHasBalanceTheSumOfTheBalancesOfItsPortfolios

	|portfolioParent portfolioChild1 portfolioChild2|
	
	portfolioParent := Portfolio new.
	
	portfolioChild1 := self portfolioWithOneAccountWith100Deposit.
	
	portfolioChild2 := self portfolioWithOneAccountWith100Deposit.
	
	portfolioParent addFinancialEntity: portfolioChild1.
	
	portfolioParent addFinancialEntity: portfolioChild2.
	
	
		
	self assert: 200 equals: portfolioParent balance.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 02:20:26'!
test12PortfolioWithAnAccountAndAPortfolioHasBalanceSumOfItsEntitiesBalance

	|portfolioParent portfolioChild|
	
	portfolioParent := self portfolioWithOneAccountWith100Deposit.
	
	portfolioChild := Portfolio new.
	
	portfolioParent addFinancialEntity: portfolioChild.
	
		
	self assert: 100 equals: portfolioParent balance.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 01:40:44'!
test13PortfolioWithNonEmptyPortfolioKnowsRegisteredTransactionsOfItsAccounts

	|portfolioParent portfolioChild account deposit|
	
	portfolioParent := Portfolio new.
	
	portfolioChild := Portfolio new.
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	
	portfolioChild addFinancialEntity: account.
	
	portfolioParent addFinancialEntity: portfolioChild.
	
	
	self assert: (portfolioParent hasRegistered: deposit).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 01:51:17'!
test14PortfolioWithNonEmptyPortfolioKnowsTransactionsOfItsAccounts

	|portfolioParent portfolioChild account deposit |
	
	portfolioParent := Portfolio new.
	
	portfolioChild := Portfolio new.
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: account.
	
	portfolioChild addFinancialEntity: account.
	
	portfolioParent addFinancialEntity: portfolioChild.
		
	self assert: 1 equals: portfolioParent transactions size.
	self assert: (portfolioParent transactions includes: deposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 01:41:16'!
test15CannotAddAlreadyAddedAccount

	|portfolio account|
	
	portfolio:= Portfolio new.
	
	account := ReceptiveAccount new.
	
	portfolio addFinancialEntity: account.
	
	self should:[portfolio addFinancialEntity: account]
	raise: Error 
	withExceptionDo: [ :anError | self assert: anError messageText equals: (Portfolio canNotAddAlreadyAddedFinancialEntity) ].! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 01:45:15'!
test16PortfolioXWithNonEmptyPortfolioYCannotAddAccountsOfItsPortfolioY

	|portfolioParent portfolioChild account|
	
	portfolioParent := Portfolio new.
	
	portfolioChild := Portfolio new.
	
	account := ReceptiveAccount new.
	
	portfolioChild addFinancialEntity: account.
	
	portfolioParent addFinancialEntity: portfolioChild.
	
	self should:[portfolioParent addFinancialEntity: account]
	raise: Error 
	withExceptionDo: [ :anError | self assert: anError messageText equals: (Portfolio canNotAddAlreadyAddedFinancialEntity) ].! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 01:47:26'!
test17CannotAddPortfolioWithAccountsAlreadyInside

	|portfolioParent portfolioChild portfolioChild2 account|
	
	portfolioParent := Portfolio new.
	
	portfolioChild := Portfolio new.
	
	portfolioChild2 := Portfolio new.
	
	account := ReceptiveAccount new.
	
	portfolioChild addFinancialEntity: account.
	
	portfolioChild2 addFinancialEntity: account.
	
	portfolioParent addFinancialEntity: portfolioChild.
	
	
	self should:[portfolioParent addFinancialEntity: portfolioChild2]
	raise: Error 
	withExceptionDo: [ :anError | self assert: anError messageText equals: (Portfolio canNotAddAlreadyAddedFinancialEntity) ].! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 01:48:41'!
test18CannotAddAccountThatHasBeenAddedByAParentPortfolio

	|portfolioParent portfolioChild account|
	
	portfolioParent := Portfolio new.
	
	account := ReceptiveAccount new.
	
	portfolioParent addFinancialEntity: account.
	
	portfolioChild := Portfolio new.
	
	portfolioParent addFinancialEntity: portfolioChild.
	
	
	self should:[portfolioChild addFinancialEntity: account]
	raise: Error 
	withExceptionDo: [ :anError | self assert: anError messageText equals: (Portfolio canNotAddAlreadyAddedFinancialEntity) ].! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 01:49:15'!
test19CannotAddItself

	|portfolio|
	
	portfolio := Portfolio new.
	
	
	self should:[portfolio addFinancialEntity: portfolio]
	raise: Error 
	withExceptionDo: [ :anError | self assert: anError messageText equals: (Portfolio canNotAddAlreadyAddedFinancialEntity) ].! !


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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
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

!AccountTransaction methodsFor: 'value' stamp: 'ET 5/22/2021 17:32:35'!
modifiesBalance: balance 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

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


!Deposit methodsFor: 'value' stamp: 'ET 5/22/2021 17:32:09'!
modifiesBalance: balance

	^balance + value.! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

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


!Withdraw methodsFor: 'value' stamp: 'ET 5/22/2021 17:32:18'!
modifiesBalance: balance

	^balance - value.! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialEntity category: 'Portfolio-Ejercicio'!
Object subclass: #FinancialEntity
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialEntity methodsFor: 'balance' stamp: 'ET 5/22/2021 17:35:47'!
balance

	self subclassResponsibility.! !


!FinancialEntity methodsFor: 'testing' stamp: 'ET 5/22/2021 17:36:18'!
hasRegistered: aTransaction

	self subclassResponsibility.! !

!FinancialEntity methodsFor: 'testing' stamp: 'ET 5/25/2021 01:19:55'!
includes: aFinancialEntity

	self subclassResponsibility.! !


!FinancialEntity methodsFor: 'transcations - private' stamp: 'ET 5/25/2021 01:21:27'!
putAllTransactionsInto: aTransactionsCollection

	self subclassResponsibility.! !


!FinancialEntity methodsFor: 'transactions' stamp: 'ET 5/22/2021 17:36:31'!
transactions

	self subclassResponsibility.! !


!FinancialEntity methodsFor: 'assertions' stamp: 'ET 5/25/2021 01:19:13'!
ensureItDoesntHaveAnythingOn: aPortfolio

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FinancialEntity class' category: 'Portfolio-Ejercicio'!
FinancialEntity class
	instanceVariableNames: ''!

!FinancialEntity class methodsFor: 'as yet unclassified' stamp: 'ET 5/22/2021 18:29:10'!
canNotAddAlreadyAddedFinancialEntity
	
	^'This financial entity has been added in this structure before!!!!'! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialEntity subclass: #Portfolio
	instanceVariableNames: 'financialEntities portfolioParents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'ET 5/22/2021 17:51:04'!
balance
	
	^(financialEntities sum: [:aFinancialEntity | aFinancialEntity balance] ifEmpty: [0])! !


!Portfolio methodsFor: 'testing' stamp: 'ET 5/22/2021 17:50:48'!
hasRegistered: aTransaction 
	
	^(financialEntities anySatisfy: [:aFinancialEntity | aFinancialEntity hasRegistered: aTransaction])! !

!Portfolio methodsFor: 'testing' stamp: 'ET 5/22/2021 18:48:56'!
includes: aFinancialEntity

	^ (aFinancialEntity  = self) or: [financialEntities anySatisfy: [:financialEntity | financialEntity includes: aFinancialEntity]].! !


!Portfolio methodsFor: 'transactions - private' stamp: 'ET 5/22/2021 19:37:08'!
putAllTransactionsInto: aTransactionsCollection
	
	financialEntities do: [:aFinancialEntity | aFinancialEntity putAllTransactionsInto: aTransactionsCollection].! !


!Portfolio methodsFor: 'transactions' stamp: 'ET 5/22/2021 19:39:30'!
transactions

	|transactions|
	transactions := OrderedCollection new.
	self putAllTransactionsInto: transactions.
	
	^transactions.! !


!Portfolio methodsFor: 'assertions' stamp: 'ET 5/25/2021 01:07:02'!
assertFinancialEntityHasNotBeenAdded: aFinancialEntity

	portfolioParents ifEmpty: [aFinancialEntity ensureItDoesntHaveAnythingOn: self]
	ifNotEmpty: [portfolioParents do: [:aPortfolio | aPortfolio assertFinancialEntityHasNotBeenAdded: aFinancialEntity]].! !

!Portfolio methodsFor: 'assertions' stamp: 'ET 5/25/2021 01:07:02'!
ensureItDoesntHaveAnythingOn: aPortfolio
	
	(aPortfolio includes: self) ifTrue: [self error: self class canNotAddAlreadyAddedFinancialEntity]
	ifFalse: [
		financialEntities do: [:aFinancialEntity | aFinancialEntity ensureItDoesntHaveAnythingOn: aPortfolio]
		
		]! !


!Portfolio methodsFor: 'initialization' stamp: 'ET 5/22/2021 19:03:29'!
initialize

	financialEntities := OrderedCollection new.
	portfolioParents := OrderedCollection new.! !


!Portfolio methodsFor: 'adding - private' stamp: 'ET 5/25/2021 01:12:13'!
isAddedInto: aPortfolio

	portfolioParents add: aPortfolio.
	aPortfolio addAssertedFinancialEntity: self.! !


!Portfolio methodsFor: 'adding' stamp: 'ET 5/25/2021 01:10:09'!
addAssertedFinancialEntity: aFinancialEntity

	financialEntities add: aFinancialEntity.! !

!Portfolio methodsFor: 'adding' stamp: 'ET 5/25/2021 01:08:01'!
addFinancialEntity: aFinancialEntity

	self assertFinancialEntityHasNotBeenAdded: aFinancialEntity.
	
	aFinancialEntity isAddedInto: self.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialEntity subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions - private' stamp: 'ET 5/22/2021 19:36:55'!
putAllTransactionsInto: aTransactionsCollection
	
	aTransactionsCollection addAllFirst: (self transactions).! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'ET 5/22/2021 17:33:11'!
balance

	^transactions inject: 0 into: [:balance :aTransaction |  aTransaction modifiesBalance: balance ].! !


!ReceptiveAccount methodsFor: 'private' stamp: 'ET 5/25/2021 01:10:50'!
isAddedInto: aPortfolio

	aPortfolio addAssertedFinancialEntity: self.
! !


!ReceptiveAccount methodsFor: 'assertions' stamp: 'ET 5/25/2021 01:07:02'!
ensureItDoesntHaveAnythingOn: aPortfolio
	
	(aPortfolio includes: self) ifTrue: [self error: self class canNotAddAlreadyAddedFinancialEntity]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'ET 5/22/2021 18:57:05'!
includes: aFinancialEntity

	^self = aFinancialEntity.
! !
