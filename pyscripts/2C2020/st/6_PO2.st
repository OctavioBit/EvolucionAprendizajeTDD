!classDefinition: #AccountSummaryTest category: 'Portfolio2-Ejercicio'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: 'account1 account2 portfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!AccountSummaryTest methodsFor: 'account summary' stamp: 'as 11/14/2020 19:10:34'!
test01AccountSummaryForAnEmptyReceptiveAccount
	
	self assert: (AccountSummarizer newFor: account1) summarize equals: (OrderedCollection with: 'Balance = 0').! !

!AccountSummaryTest methodsFor: 'account summary' stamp: 'as 11/14/2020 19:10:34'!
test02AccountSummaryForAReceptiveAccountWithADeposit
	
	Deposit register: 100 on: account1.
	
	self assert: (AccountSummarizer newFor: account1) summarize equals: (OrderedCollection with: 'Depósito por 100.' with: 'Balance = 100').! !

!AccountSummaryTest methodsFor: 'account summary' stamp: 'as 11/14/2020 19:10:34'!
test03AccountSummaryForAReceptiveAccountWithTwoDeposit

	Deposit register: 100 on: account1.
	Deposit register: 100 on: account1.	
	
	self assert: (AccountSummarizer newFor: account1) summarize equals: (OrderedCollection with: 'Depósito por 100.' with: 'Depósito por 100.' with: 'Balance = 200').! !

!AccountSummaryTest methodsFor: 'account summary' stamp: 'as 11/14/2020 19:10:34'!
test04AccountSummaryForAReceptiveAccountWithWithdraw
	
	Withdraw register: 100 on: account1.	
	
	self assert: (AccountSummarizer newFor: account1) summarize equals: (OrderedCollection with: 'Extracción por 100.' with: 'Balance = -100').! !

!AccountSummaryTest methodsFor: 'account summary' stamp: 'as 11/14/2020 19:10:41'!
test05AccountSummaryForAReceptiveAccountWithTransferWithdraw
	
	Transfer anAmountOf: 100 from: account1 to: account2.
	
	self assert: (AccountSummarizer newFor: account1) summarize equals: (OrderedCollection with: 'Salida por transferencia de 100.' with: 'Balance = -100').! !

!AccountSummaryTest methodsFor: 'account summary' stamp: 'as 11/14/2020 19:10:41'!
test06AccountSummaryForAReceptiveAccountWithTransferDeposit
	
	Transfer anAmountOf: 100 from: account1 to: account2.
	
	self assert: (AccountSummarizer newFor: account2) summarize equals: (OrderedCollection with: 'Entrada por transferencia de 100.' with: 'Balance = 100').! !

!AccountSummaryTest methodsFor: 'account summary' stamp: 'as 11/14/2020 19:10:41'!
test07AccountSummaryForAReceptiveAccountWithTransferDepositWithADifferentAmount
	
	Transfer anAmountOf: 50 from: account1 to: account2.
	
	self assert: (AccountSummarizer newFor: account2) summarize equals: (OrderedCollection with: 'Entrada por transferencia de 50.' with: 'Balance = 50').! !


!AccountSummaryTest methodsFor: 'setUp' stamp: 'as 11/14/2020 19:12:51'!
setUp
	
	account1 := ReceptiveAccount new.	
	account2 := ReceptiveAccount new.		
	portfolio := Portfolio new.! !


!AccountSummaryTest methodsFor: 'portfolio summary' stamp: 'as 11/14/2020 19:12:51'!
test08AccountSummaryForAnEmptyPortfolio
		
	self assert: (AccountSummarizer newFor: portfolio) summarize equals: (OrderedCollection with: 'Balance = 0').! !

!AccountSummaryTest methodsFor: 'portfolio summary' stamp: 'as 11/14/2020 19:12:51'!
test09AccountSummaryForAPortfolioWithOneDepositAccount 
		
	Deposit register: 100 on: account1.
	portfolio add: account1.
	
	self assert: (AccountSummarizer newFor: portfolio) summarize equals: (OrderedCollection with: 'Depósito por 100.' with: 'Balance = 100').! !

!AccountSummaryTest methodsFor: 'portfolio summary' stamp: 'as 11/14/2020 19:12:51'!
test10AccountSummaryForAPortfolioWithTwoDepositAccount 
		
	Deposit register: 100 on: account1.
	Deposit register: 100 on: account1.
	portfolio add: account1.
	
	self assert:(AccountSummarizer newFor: portfolio) summarize equals: (OrderedCollection with: 'Depósito por 100.' with: 'Depósito por 100.' with: 'Balance = 200').! !

!AccountSummaryTest methodsFor: 'portfolio summary' stamp: 'as 11/14/2020 19:12:51'!
test11AccountSummaryForAPortfolioWithTwoAccounts
	
	Deposit register: 100 on: account1.
	Deposit register: 100 on: account2.
	portfolio add: account1.
	portfolio add: account2.
	
	self assert: (AccountSummarizer newFor: portfolio) summarize equals: (OrderedCollection with: 'Depósito por 100.' with: 'Depósito por 100.' with: 'Balance = 200').! !


!classDefinition: #PortfolioTest category: 'Portfolio2-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio2-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/9/2020 06:00:12'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/9/2020 06:02:30'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: account.
		
	self assert: 1 equals: account transactions size .
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #TransferNetTest category: 'Portfolio2-Ejercicio'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: 'account1 account2 portfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!TransferNetTest methodsFor: 'account transfer net' stamp: 'as 11/14/2020 19:16:44'!
test01TransferNetForEmptyReceptiveAccount

	self assert: (TransferNetCalculator newFor: account1) calculateTransferNet equals: 0.
	! !

!TransferNetTest methodsFor: 'account transfer net' stamp: 'as 11/14/2020 19:18:42'!
test02TransferNetForReceptiveAccountWithTransferDeposit

	self transfer100FromAccount1ToAccount2.
	
	self assert: (TransferNetCalculator newFor: account2) calculateTransferNet equals: 100.
	! !

!TransferNetTest methodsFor: 'account transfer net' stamp: 'as 11/14/2020 19:18:22'!
test03TransferNetForReceptiveAccountWithTwoTransferDeposit

	self transfer100FromAccount1ToAccount2.
	self transfer100FromAccount1ToAccount2.
	
	self assert: (TransferNetCalculator newFor: account2) calculateTransferNet equals: 200.
	! !

!TransferNetTest methodsFor: 'account transfer net' stamp: 'as 11/14/2020 19:19:00'!
test04TransferNetForReceptiveAccountWithTransferWithdraw

	self transfer100FromAccount1ToAccount2.
	
	self assert: (TransferNetCalculator newFor: account1) calculateTransferNet equals: -100.
	! !


!TransferNetTest methodsFor: 'portfolio transfer net' stamp: 'as 11/14/2020 19:16:54'!
test05TransferNetForEmptyPortfolio

	self assert: (TransferNetCalculator newFor: portfolio) calculateTransferNet equals: 0.
	! !

!TransferNetTest methodsFor: 'portfolio transfer net' stamp: 'as 11/14/2020 19:19:12'!
test06TransferNetForAPortfolioWithAOneTransferAccount
	
	portfolio add: account2.
	self transfer100FromAccount1ToAccount2.
	
	self assert:  (TransferNetCalculator newFor: portfolio) calculateTransferNet equals: 100.
	! !

!TransferNetTest methodsFor: 'portfolio transfer net' stamp: 'as 11/14/2020 19:19:31'!
test07TransferNetForAPortfolioWithATwoTransferAccount
	
	portfolio add: account2.
	self transfer100FromAccount1ToAccount2.
	self transfer100FromAccount1ToAccount2.
	
	self assert:  (TransferNetCalculator newFor: portfolio) calculateTransferNet equals: 200.
	! !


!TransferNetTest methodsFor: 'setUp' stamp: 'as 11/14/2020 19:24:11'!
setUp
	
	account1 := ReceptiveAccount new.	
	account2 := ReceptiveAccount new.		
	portfolio := Portfolio new.! !


!TransferNetTest methodsFor: 'private operations' stamp: 'as 11/14/2020 19:18:04'!
transfer100FromAccount1ToAccount2
	Transfer anAmountOf: 100 from: account1 to: account2! !


!classDefinition: #TransferTest category: 'Portfolio2-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: 'account1 account2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!TransferTest methodsFor: 'tests' stamp: 'as 11/14/2020 19:24:44'!
test01ReceptiveAccountsInvolvedInTransferHaveCorrectBalanceAfterTransfer

	Transfer anAmountOf: 100 from: account1 to: account2.
	
	self assert: account1 balance equals: -100.
	self assert: account2 balance equals: 100.	
	
	! !

!TransferTest methodsFor: 'tests' stamp: 'as 11/14/2020 19:24:44'!
test02AccountTransactionsAreRegisteredInReceptiveAccountsInvolvedAfterTransfer

	| transfer|
	
	transfer := Transfer anAmountOf: 100 from: account1 to: account2.

	self assert: (account1 hasRegistered: transfer withdraw).
	self assert: (account2 hasRegistered: transfer deposit).	
	! !

!TransferTest methodsFor: 'tests' stamp: 'as 11/14/2020 19:24:44'!
test03AccountTransactionsInTransferAreConnected

	| transfer|
	
	transfer := Transfer anAmountOf: 100 from: account1 to: account2.

	self assert: transfer withdraw transferDepositAssociated equals: transfer deposit.
	self assert: transfer deposit transferWithdrawAssociated equals: transfer withdraw.	
	
! !

!TransferTest methodsFor: 'tests' stamp: 'as 11/14/2020 19:24:38'!
test04AccountCannotTransferToItself
	
	self 
		should: [ Transfer anAmountOf: 100 from: account1 to: account1. ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: Transfer invalidTransferErrorMessage equals: anError messageText. ]

	! !

!TransferTest methodsFor: 'tests' stamp: 'as 11/14/2020 19:24:44'!
test05AccountCannotTransferInvalidAmount
	
	self 
		should: [ Transfer anAmountOf: -100 from: account1 to: account2. ]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: Transfer invalidTransferErrorMessage equals: anError messageText. ]

	! !


!TransferTest methodsFor: 'setUp' stamp: 'as 11/14/2020 19:24:44'!
setUp
	
	account1 := ReceptiveAccount new.	
	account2 := ReceptiveAccount new.		! !


!classDefinition: #Account category: 'Portfolio2-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'reporting' stamp: 'as 11/14/2020 18:40:17'!
generateReportWith: anAccountReporter
	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio2-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'reporting' stamp: 'as 11/14/2020 18:35:57'!
generateReportWith: anAccountReporter
	
	accounts do: [:account | anAccountReporter accumulateAccount: account].
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio2-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'NR 11/9/2020 06:01:26'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio!!'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio2-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'NR 11/9/2020 05:56:36'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions copy! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'as 11/9/2020 20:18:50'!
hasTransfer: aTransfer
	transactions anySatisfy: [:transaction | transaction belongsTo: aTransfer].! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'reporting' stamp: 'as 11/14/2020 18:37:31'!
generateReportWith: anAccountReporter

	transactions do: [:transaction | transaction accumulateTo: anAccountReporter].! !



!classDefinition: #AccountReporter category: 'Portfolio2-Ejercicio'!
Object subclass: #AccountReporter
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!AccountReporter methodsFor: 'initialization' stamp: 'as 11/14/2020 18:43:33'!
initializeFor: anAccount
	self subclassResponsibility ! !


!AccountReporter methodsFor: 'accumulate account' stamp: 'as 11/14/2020 18:41:51'!
accumulateAccount: anAccount
	self subclassResponsibility ! !


!AccountReporter methodsFor: 'accumulate transaction' stamp: 'as 11/14/2020 18:42:17'!
accumulateDeposit: aDeposit
	self subclassResponsibility ! !

!AccountReporter methodsFor: 'accumulate transaction' stamp: 'as 11/14/2020 18:42:39'!
accumulateTransferDeposit: aTransferDeposit
	self subclassResponsibility ! !

!AccountReporter methodsFor: 'accumulate transaction' stamp: 'as 11/14/2020 18:42:52'!
accumulateTransferWithdraw: aTransferWithdraw
	self subclassResponsibility ! !

!AccountReporter methodsFor: 'accumulate transaction' stamp: 'as 11/14/2020 18:42:59'!
accumulateWithdraw: aWithdraw
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReporter class' category: 'Portfolio2-Ejercicio'!
AccountReporter class
	instanceVariableNames: ''!

!AccountReporter class methodsFor: 'initialization' stamp: 'as 11/14/2020 18:47:36'!
newFor: anAccount
	^ self new initializeFor: anAccount.! !


!classDefinition: #AccountSummarizer category: 'Portfolio2-Ejercicio'!
AccountReporter subclass: #AccountSummarizer
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!AccountSummarizer methodsFor: 'reporting operations' stamp: 'as 11/14/2020 18:38:01'!
summarize
	account generateReportWith: self.
	summary add: 'Balance = ', account balance asString.
	^summary.! !


!AccountSummarizer methodsFor: 'accumulate account' stamp: 'as 11/14/2020 17:30:05'!
accumulateAccount: anAccount
	summary := summary, (AccountSummarizer newFor: anAccount) summarize.
	summary removeLast.
	 ! !


!AccountSummarizer methodsFor: 'accumulate transaction' stamp: 'as 11/14/2020 17:58:26'!
accumulateDeposit: aDeposit
	summary add: 'Depósito por ', aDeposit value asString, '.'.! !

!AccountSummarizer methodsFor: 'accumulate transaction' stamp: 'as 11/14/2020 17:59:28'!
accumulateTransferDeposit: aTransferDeposit
	summary add: 'Entrada por transferencia de ', aTransferDeposit value asString, '.'.! !

!AccountSummarizer methodsFor: 'accumulate transaction' stamp: 'as 11/14/2020 17:59:49'!
accumulateTransferWithdraw: aTransferWithdraw
	summary add: 'Salida por transferencia de ', aTransferWithdraw value asString, '.'.! !

!AccountSummarizer methodsFor: 'accumulate transaction' stamp: 'as 11/14/2020 18:00:31'!
accumulateWithdraw: aWithdraw
	summary add: 'Extracción por ', aWithdraw value asString, '.'.! !


!AccountSummarizer methodsFor: 'initialization' stamp: 'as 11/14/2020 17:14:52'!
initializeFor: anAccount
	account := anAccount.
	summary := OrderedCollection new.
	! !


!classDefinition: #TransferNetCalculator category: 'Portfolio2-Ejercicio'!
AccountReporter subclass: #TransferNetCalculator
	instanceVariableNames: 'transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!TransferNetCalculator methodsFor: 'accumulate transaction' stamp: 'as 11/14/2020 17:49:21'!
accumulateDeposit: aDeposit
! !

!TransferNetCalculator methodsFor: 'accumulate transaction' stamp: 'as 11/14/2020 18:07:10'!
accumulateTransferDeposit: aTransferDeposit
	transferNet := transferNet + aTransferDeposit value.! !

!TransferNetCalculator methodsFor: 'accumulate transaction' stamp: 'as 11/14/2020 18:07:19'!
accumulateTransferWithdraw: aTransferWithdraw
	transferNet := transferNet - aTransferWithdraw value.! !

!TransferNetCalculator methodsFor: 'accumulate transaction' stamp: 'as 11/14/2020 17:49:27'!
accumulateWithdraw: aWithdraw
! !


!TransferNetCalculator methodsFor: 'reporting operations' stamp: 'as 11/14/2020 18:38:15'!
calculateTransferNet
	account generateReportWith: self.
	^transferNet.! !


!TransferNetCalculator methodsFor: 'accumulate account' stamp: 'as 11/14/2020 17:52:09'!
accumulateAccount: anAccount
	transferNet := transferNet + (TransferNetCalculator newFor: anAccount) calculateTransferNet.
	! !


!TransferNetCalculator methodsFor: 'initialization' stamp: 'as 11/14/2020 17:35:13'!
initializeFor: anAccount
	account := anAccount.
	transferNet := 0.
	! !


!classDefinition: #AccountTransaction category: 'Portfolio2-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'reporting operations' stamp: 'as 11/14/2020 19:01:42'!
accumulateTo: anAccountReporter

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio2-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'as 11/9/2020 21:34:48'!
register: aValue on: account for: aTransfer

	| transaction |
	
	transaction := self for: aValue for: aTransfer.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio2-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'reporting operations' stamp: 'as 11/14/2020 19:01:57'!
accumulateTo: anAccountReporter

	anAccountReporter accumulateDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio2-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'as 11/9/2020 21:36:23'!
for: aValue for: aTransfer

	^ TransferDeposit new initializeFor: aValue for: aTransfer.! !


!classDefinition: #TransferDeposit category: 'Portfolio2-Ejercicio'!
Deposit subclass: #TransferDeposit
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!TransferDeposit methodsFor: 'initialization' stamp: 'as 11/9/2020 21:37:33'!
initializeFor: aValue for: aTransfer
	value := aValue.
	transfer := aTransfer.! !


!TransferDeposit methodsFor: 'transfer queries' stamp: 'as 11/9/2020 21:32:59'!
transferWithdrawAssociated
	^transfer withdraw.! !


!TransferDeposit methodsFor: 'reporting operations' stamp: 'as 11/14/2020 18:52:39'!
accumulateTo: anAccountReporter
	anAccountReporter accumulateTransferDeposit: self.! !


!classDefinition: #Withdraw category: 'Portfolio2-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'reporting operations' stamp: 'as 11/14/2020 19:02:20'!
accumulateTo: anAccountReporter

	anAccountReporter accumulateWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio2-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'as 11/9/2020 21:38:08'!
for: aValue for: aTransfer

	^ TransferWithdraw new initializeFor: aValue for: aTransfer.! !


!classDefinition: #TransferWithdraw category: 'Portfolio2-Ejercicio'!
Withdraw subclass: #TransferWithdraw
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!TransferWithdraw methodsFor: 'transfer queries' stamp: 'as 11/9/2020 21:32:35'!
transferDepositAssociated
	^transfer deposit.! !


!TransferWithdraw methodsFor: 'initialization' stamp: 'as 11/9/2020 21:37:43'!
initializeFor: aValue for: aTransfer
	value := aValue.
	transfer := aTransfer.! !


!TransferWithdraw methodsFor: 'reporting operations' stamp: 'as 11/14/2020 17:48:15'!
accumulateTo: aTransferNetCalculator
	aTransferNetCalculator accumulateTransferWithdraw: self.! !


!classDefinition: #Transfer category: 'Portfolio2-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'deposit withdraw'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Transfer methodsFor: 'transfer components' stamp: 'as 11/9/2020 21:16:25'!
deposit
	^deposit.
	
	
	
	
	! !

!Transfer methodsFor: 'transfer components' stamp: 'as 11/9/2020 21:16:11'!
withdraw
	^withdraw.
	
	
	
	
	! !


!Transfer methodsFor: 'initialization' stamp: 'as 11/9/2020 21:33:57'!
initializeWith: anAmount from: originAccount to: destinationAccount

	deposit := Deposit register: anAmount on: destinationAccount for: self.
	withdraw := Withdraw register: anAmount on: originAccount for: self.
	
	
	
	
	
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio2-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'as 11/12/2020 21:34:52'!
anAmountOf: anAmount from: originAccount to: destinationAccount
	
	self validateTransferCollaboratorsIn: [originAccount = destinationAccount].
	self validateTransferCollaboratorsIn: [anAmount <= 0].
	
	^self new initializeWith: anAmount from: originAccount to: destinationAccount.! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'as 11/12/2020 21:22:52'!
invalidTransferErrorMessage
	^'transfer is invalid'.! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'as 11/12/2020 21:33:46'!
validateTransferCollaboratorsIn: aBlockToValidate
	aBlockToValidate value ifTrue: [^ Error signal: self invalidTransferErrorMessage ].	! !
