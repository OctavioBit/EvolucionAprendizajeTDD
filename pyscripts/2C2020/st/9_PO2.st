!classDefinition: #AccountTest category: 'Portfolio'!
TestCase subclass: #AccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!


!classDefinition: #PortfolioTest category: 'Portfolio'!
AccountTest subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

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


!classDefinition: #ReceptiveAccountTest category: 'Portfolio'!
AccountTest subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

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


!classDefinition: #ReportTest category: 'Portfolio'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!


!classDefinition: #AccountSummaryTest category: 'Portfolio'!
ReportTest subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'FD 11/14/2020 17:45:21'!
test01AccountSummaryOfAnEmptyPortfolioOnlyShowsBalance

	| summary | 
	
	summary := AccountSummary for: Portfolio new.
	
	self assert: summary report size equals: 1.
	self assert: summary report first equals: 'Balance = 0'.! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'FD 11/14/2020 17:45:42'!
test02AccountSummaryOfAPortfolioWithADepositAddsIt

	| summary account portfolio | 
	
	
	account := ReceptiveAccount new.
	
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	summary := AccountSummary for: portfolio.
	
	self assert: summary report first equals: 'Depósito por 100'.! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'FD 11/14/2020 17:46:00'!
test03AccountSummaryOfAPortfolioWithAWithdrawalAddsIt

	| summary account portfolio | 
	
	
	account := ReceptiveAccount new.
	
	Withdraw register: 50 on: account.
	portfolio := Portfolio with: account.
	
	summary := AccountSummary for: portfolio.
	
	self assert: summary report first equals: 'Extracción por 50'.! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'FD 11/14/2020 17:46:08'!
test04AccountSummaryOfAPortfolioWithASendingTransferAddsIt

	| summary sendingAccount receivingAccount | 
	
	
	sendingAccount := ReceptiveAccount new.
	receivingAccount := ReceptiveAccount new.
	
	Transfer register: 20 on: sendingAccount  to: receivingAccount.
	
	summary := AccountSummary for: sendingAccount .
	
	
	self assert: summary report first equals: 'Salida por transferencia de 20'.! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'FD 11/14/2020 17:46:20'!
test05AccountSummaryOfAPortfolioWithAReceivingTransferAddsIt

	| summary sendingAccount receivingAccount | 
	
	
	sendingAccount := ReceptiveAccount new.
	receivingAccount := ReceptiveAccount new.
	
	Transfer register: 30 on: sendingAccount  to: receivingAccount.
	
	summary := AccountSummary for: receivingAccount .
	
	
	self assert: summary report first equals: 'Entrada por transferencia de 30'.! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'FD 11/14/2020 17:46:31'!
test06AccountSummaryShowsTheBalance

	| summary account portfolio | 
	
	
	account := ReceptiveAccount new.
	
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	summary := AccountSummary for: portfolio.
	
	self assert: summary report last equals: 'Balance = 100'.! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'FD 11/14/2020 17:47:00'!
test07AccountSummaryOfAnAccountWithMultipleTransactionsAddsThemAll

	| summary account portfolio | 
	
	
	account := ReceptiveAccount new.
	
	Deposit register: 50 on: account.
	Withdraw register: 30 on: account.
	
	portfolio := Portfolio with: account.
	
	summary := AccountSummary for: portfolio.
	
	self assert: summary report size equals: 3.
	self assert: summary report first equals: 'Depósito por 50'.
	self assert: summary report second equals: 'Extracción por 30'.
	self assert: summary report last equals: 'Balance = 20'.! !


!classDefinition: #AccountTreeStructureTest category: 'Portfolio'!
ReportTest subclass: #AccountTreeStructureTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountTreeStructureTest methodsFor: 'as yet unclassified' stamp: 'FD 11/15/2020 15:19:08'!
test01ReportOnlyShowsTheRootNameWhenPortfolioDoesNotHaveAccounts

	| accountTreeStructure portfolio | 
	
	portfolio := Portfolio named: 'test portfolio'.
	
	accountTreeStructure := AccountTreeStructure for: portfolio.
	
	self assert: accountTreeStructure report size equals: 1.
	self assert: accountTreeStructure report first equals: 'test portfolio'.! !

!AccountTreeStructureTest methodsFor: 'as yet unclassified' stamp: 'FD 11/15/2020 15:35:23'!
test02ReportOnlyShowsTheRootNameWhenUsedOnAnAccount

	| accountTreeStructure account | 
	
	account := ReceptiveAccount named: 'test account'.
	
	accountTreeStructure := AccountTreeStructure for: account.
	
	self assert: accountTreeStructure report size equals: 1.
	self assert: accountTreeStructure report first equals: 'test account'.! !

!AccountTreeStructureTest methodsFor: 'as yet unclassified' stamp: 'FD 11/15/2020 15:38:22'!
test03ReportDoesNotShowTransactions

	| accountTreeStructure account | 
	
	account := ReceptiveAccount named: 'test account'.
	Deposit register: 100 on: account.
	
	accountTreeStructure := AccountTreeStructure for: account.
	
	self assert: accountTreeStructure report size equals: 1.
	self assert: accountTreeStructure report first equals: 'test account'.! !

!AccountTreeStructureTest methodsFor: 'as yet unclassified' stamp: 'FD 11/15/2020 16:25:31'!
test04ChildAccountIsIndented

	| accountTreeStructure portfolio | 
	
	portfolio := Portfolio named: 'a portfolio' with: (ReceptiveAccount named: 'an account').
	
	
	accountTreeStructure := AccountTreeStructure for: portfolio.
	
	self assert: accountTreeStructure report second equals: '   an account'.! !

!AccountTreeStructureTest methodsFor: 'as yet unclassified' stamp: 'FD 11/15/2020 16:33:01'!
test05ChildAccountsAreIndented

	| accountTreeStructure childPortfolio portfolio | 
	
	childPortfolio := Portfolio named: 'a portfolio' with: (ReceptiveAccount named: 'an account').
	portfolio := Portfolio named: 'parent portfolio' with: childPortfolio .
	portfolio add: (ReceptiveAccount named: 'another account').
	
	
	accountTreeStructure := AccountTreeStructure for: portfolio.
	
	self assert: accountTreeStructure report second equals: '   a portfolio'.
	self assert: accountTreeStructure report third equals: '      an account'.
	self assert: accountTreeStructure report fourth equals: '   another account'.! !


!classDefinition: #AccountTreeStructureWithSummaryTest category: 'Portfolio'!
ReportTest subclass: #AccountTreeStructureWithSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountTreeStructureWithSummaryTest methodsFor: 'as yet unclassified' stamp: 'FD 11/15/2020 16:36:27'!
test01ReportOnlyShowsTheRootNameWhenPortfolioDoesNotHaveAccounts

	| accountTreeStructure portfolio | 
	
	portfolio := Portfolio named: 'test portfolio'.
	
	accountTreeStructure := AccountTreeStructureWithSummary for: portfolio.
	
	self assert: accountTreeStructure report size equals: 1.
	self assert: accountTreeStructure report first equals: 'test portfolio'.! !

!AccountTreeStructureWithSummaryTest methodsFor: 'as yet unclassified' stamp: 'FD 11/15/2020 16:56:11'!
test02ShowsEachAccountsSummary

	| accountTreeStructure account1 account2 portfolio| 
	
	account1 := ReceptiveAccount named: 'test account1'.
	Deposit register: 100 on: account1.
	
	account2 := ReceptiveAccount named: 'test account2'.
	Withdraw register: 50 on: account2.
	
	portfolio := Portfolio named: 'a portfolio'.
	portfolio add: account1.
	portfolio add: account2.
	
	accountTreeStructure := AccountTreeStructureWithSummary for: portfolio .
	
	self assert: accountTreeStructure report size equals: 7.
	self assert: accountTreeStructure report first equals: 'a portfolio'.
	self assert: accountTreeStructure report second equals: '   test account1'.
	self assert: accountTreeStructure report third equals: '      Depósito por 100'.
	self assert: accountTreeStructure report fourth equals: '      Balance = 100'.
	self assert: accountTreeStructure report fifth equals: '   test account2'.
	self assert: accountTreeStructure report sixth equals: '      Extracción por 50'.
	self assert: accountTreeStructure report seventh equals: '      Balance = -50'.! !


!classDefinition: #NetTransferTest category: 'Portfolio'!
ReportTest subclass: #NetTransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!NetTransferTest methodsFor: 'as yet unclassified' stamp: 'FD 11/14/2020 19:55:18'!
test01NetTransferReportForAnAccountWithoutTransfersReturnsZero

	| netTransferReport account portfolio | 
	
	
	account := ReceptiveAccount new.
	
	Deposit register: 50 on: account.
	Withdraw register: 30 on: account.
	
	portfolio := Portfolio with: account.
	
	netTransferReport := NetTransferReport for: portfolio.
	
	self assert: netTransferReport report equals: 0.! !

!NetTransferTest methodsFor: 'as yet unclassified' stamp: 'FD 11/14/2020 19:55:29'!
test02NetTransferReportForAnAccountWithTransfersReturnsTheNetValue

	| netTransferReport account1 account2 | 
	
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer register: 30 on: account1  to: account2.
	Transfer register: 40 on: account2  to: account1.
	
	netTransferReport := NetTransferReport for: account1 .
	
	self assert: netTransferReport report equals: 10.! !


!classDefinition: #TransferTest category: 'Portfolio'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'FD 11/9/2020 20:55:05'!
test01ARegisteredTransferToAnotherAccountDiminishesBalance


	| account anotherAccount |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Transfer register: 100 on: account to: anotherAccount.
		
	self assert: -100 equals: account balance .
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'FD 11/9/2020 20:55:08'!
test02ARegisteredTransferFromAnotherAccountIncreasesBalance


	| account anotherAccount |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Transfer register: 100 on: anotherAccount to: account.
		
	self assert: 100 equals: account balance .
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'FD 11/9/2020 21:22:33'!
test03SenderKnowsItsTransfer


	| account anotherAccount transfer |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	transfer := Transfer register: 100 on: account to: anotherAccount.
		
	self assert: (account hasRegistered: transfer sending)
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'FD 11/9/2020 21:22:40'!
test04ReceiverKnowsItsTransfer


	| account anotherAccount transfer |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	transfer := Transfer register: 100 on: account to: anotherAccount.
		
	self assert: (anotherAccount hasRegistered: transfer reception)
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'FD 11/9/2020 20:55:50'!
test05AnAccountCannotTransferToItself


	| account |
	
	account := ReceptiveAccount new.
		
		self 
		should: [ Transfer register: 100 on: account to: account ]
		raise: Error - MessageNotUnderstood 
		withMessageText: [ Transfer accountsMustBeDifferentErrorDescription ]! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'FD 11/9/2020 21:31:45'!
test06TransferAmountShouldBeGreaterThanZero


	| account anotherAccount |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
		
		self 
		should: [ Transfer register: 0 on: account to: anotherAccount ]
		raise: Error - MessageNotUnderstood 
		withMessageText: [ Transfer amountShouldBeGreaterThanZeroErrorDescription ]! !


!classDefinition: #Account category: 'Portfolio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

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


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'report building' stamp: 'FD 11/14/2020 19:02:22'!
buildReport: reportInstructions from: aReportToBuildOnto

	self subclassResponsibility ! !


!Account methodsFor: 'accessing' stamp: 'FD 11/15/2020 15:31:39'!
name

	self subclassResponsibility .! !


!classDefinition: #Portfolio category: 'Portfolio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

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

!Portfolio methodsFor: 'initialization' stamp: 'FD 11/15/2020 15:22:23'!
name: aName

	name := aName.
	! !


!Portfolio methodsFor: 'balance' stamp: 'FD 11/14/2020 19:48:52'!
balance

	^(Balance for: self) report.! !


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


!Portfolio methodsFor: 'report building' stamp: 'FD 11/15/2020 16:57:36'!
buildReport: reportInstructions from: aReportToBuildOnto

	| reportInProgess |
	
	reportInProgess := reportInstructions affectReport: aReportToBuildOnto FromPortfolio: self.
		
	reportInProgess := accounts
	inject: reportInProgess 
	into: [:report :transaction | transaction buildReport: reportInstructions from: report].
	
	reportInstructions cleanAfterAffectReport.
	
	^reportInProgess.! !


!Portfolio methodsFor: 'accessing' stamp: 'FD 11/15/2020 15:31:21'!
name

	^name.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'NR 11/9/2020 06:01:26'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio!!'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'FD 11/15/2020 15:21:57'!
named: aName

	^self new 
		name: aName;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'FD 11/15/2020 15:46:05'!
named: aName with: anotherAccount

	^self new 
		name: aName;
		add: anotherAccount;
		yourself! !

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


!classDefinition: #ReceptiveAccount category: 'Portfolio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'FD 11/15/2020 15:23:24'!
name: aName

	name := aName.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'NR 11/9/2020 05:56:36'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions copy! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'FD 11/14/2020 19:42:38'!
balance

	^(Balance for: self) report.! !


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


!ReceptiveAccount methodsFor: 'report building' stamp: 'FD 11/15/2020 16:57:36'!
buildReport: reportInstructions from: aReportToBuildOnto

	| reportInProgess |
	
	reportInProgess := reportInstructions affectReport: aReportToBuildOnto FromAccount: self.
	
	reportInProgess := transactions
	inject: reportInProgess 
	into: [:report :transaction | transaction buildReport: reportInstructions from: report].
	
	reportInstructions cleanAfterAffectReport.
	
	^reportInProgess.! !


!ReceptiveAccount methodsFor: 'accessing' stamp: 'FD 11/15/2020 15:31:53'!
name 
	
	^ name.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'initialization' stamp: 'FD 11/15/2020 15:26:11'!
named: aName

	^self new name: aName.! !


!classDefinition: #AccountTransaction category: 'Portfolio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'report building' stamp: 'FD 11/14/2020 19:50:02'!
buildReport: buildingInstructions from: aReportToBuildOnto

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'reportBuilding' stamp: 'FD 11/14/2020 19:48:19'!
buildReport: buildingInstructions from: aReportToBuildOnto

	^buildingInstructions affectReport: aReportToBuildOnto FromDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'report building' stamp: 'FD 11/14/2020 19:50:47'!
buildReport: buildingInstructions from: aReportToBuildOnto

	^buildingInstructions affectReport: aReportToBuildOnto FromWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: 'Portfolio'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!


!Report methodsFor: 'report building' stamp: 'FD 11/14/2020 19:09:30'!
affectReport: aReportInProgress FromDeposit: aDeposit

	self subclassResponsibility .! !

!Report methodsFor: 'report building' stamp: 'FD 11/14/2020 19:09:40'!
affectReport: aReportInProgress FromTransferReception: aTransferReception

	self subclassResponsibility .! !

!Report methodsFor: 'report building' stamp: 'FD 11/14/2020 19:09:50'!
affectReport: aReportInProgress FromTransferSending: aTransferSending

	self subclassResponsibility .! !

!Report methodsFor: 'report building' stamp: 'FD 11/14/2020 19:09:59'!
affectReport: aReportInProgress FromWithdraw: aWithdraw

	self subclassResponsibility .! !


!Report methodsFor: 'action' stamp: 'FD 11/14/2020 19:10:12'!
report

	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'Portfolio'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'as yet unclassified' stamp: 'FD 11/12/2020 21:43:08'!
for: anAccount 
	^self new initializeWith: anAccount.! !


!classDefinition: #AccountSummary category: 'Portfolio'!
Report subclass: #AccountSummary
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountSummary methodsFor: 'report building' stamp: 'FD 11/14/2020 19:22:33'!
addBalanceEntry: aSummary
	
	aSummary add: ('Balance = ', account balance printString ).
	
	^aSummary.! !

!AccountSummary methodsFor: 'report building' stamp: 'FD 11/15/2020 15:37:14'!
affectReport: aReportInProgress FromAccount: aAccount

	^aReportInProgress.! !

!AccountSummary methodsFor: 'report building' stamp: 'FD 11/14/2020 19:19:16'!
affectReport: aReportInProgress FromDeposit: aDeposit

	aReportInProgress add: 'Depósito por ', aDeposit value printString.	
	
	^aReportInProgress.! !

!AccountSummary methodsFor: 'report building' stamp: 'FD 11/15/2020 15:33:44'!
affectReport: aReportInProgress FromPortfolio: aPortfolio

	^aReportInProgress.! !

!AccountSummary methodsFor: 'report building' stamp: 'FD 11/14/2020 18:45:55'!
affectReport: aReportInProgress FromTransferReception: aTransferReception

	aReportInProgress add: 'Entrada por transferencia de ', aTransferReception value printString.	
	
	^aReportInProgress.! !

!AccountSummary methodsFor: 'report building' stamp: 'FD 11/14/2020 18:46:01'!
affectReport: aReportInProgress FromTransferSending: aTransferSending

	aReportInProgress add: 'Salida por transferencia de ', aTransferSending value printString.	
	
	^aReportInProgress.! !

!AccountSummary methodsFor: 'report building' stamp: 'FD 11/14/2020 18:46:07'!
affectReport: aReportInProgress FromWithdraw: aWithdraw

	aReportInProgress add: 'Extracción por ', aWithdraw value printString.	
	
	^aReportInProgress.! !

!AccountSummary methodsFor: 'report building' stamp: 'FD 11/15/2020 16:57:36'!
cleanAfterAffectReport! !


!AccountSummary methodsFor: 'action' stamp: 'FD 11/14/2020 19:23:06'!
report

	| summary |
	
	summary := OrderedCollection new.

	account buildReport: self from: summary.
	
	self addBalanceEntry: summary.
	
	^summary.! !


!AccountSummary methodsFor: 'initialization' stamp: 'FD 11/14/2020 19:14:51'!
initializeWith: anAccount 
	
	account := anAccount.! !


!classDefinition: #AccountTreeStructure category: 'Portfolio'!
Report subclass: #AccountTreeStructure
	instanceVariableNames: 'account indentationLevel'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountTreeStructure methodsFor: 'initialization' stamp: 'FD 11/15/2020 16:04:13'!
initializeWith: anAccount 
	
	account := anAccount.
	indentationLevel := 0.! !


!AccountTreeStructure methodsFor: 'action' stamp: 'FD 11/15/2020 17:00:05'!
report

	| structure |
	
	structure := OrderedCollection new.

	account buildReport: self from: structure.
	
	self resetIndentationLevel.
	^structure.! !


!AccountTreeStructure methodsFor: 'report building' stamp: 'FD 11/15/2020 16:58:54'!
affectReport: aReportInProgress FromAccount: anAccount

	aReportInProgress add: (self indent: anAccount name).	
	self increaseIndentationLevel.
	
	^aReportInProgress.! !

!AccountTreeStructure methodsFor: 'report building' stamp: 'FD 11/15/2020 15:39:04'!
affectReport: aReportInProgress FromDeposit: aDeposit

	^aReportInProgress.! !

!AccountTreeStructure methodsFor: 'report building' stamp: 'FD 11/15/2020 16:59:08'!
affectReport: aReportInProgress FromPortfolio: aPortfolio

	aReportInProgress add: (self indent: aPortfolio name).	
	self increaseIndentationLevel.
	
	^aReportInProgress.! !

!AccountTreeStructure methodsFor: 'report building' stamp: 'FD 11/15/2020 15:39:38'!
affectReport: aReportInProgress FromTransferReception: aTransferReception

	^aReportInProgress.! !

!AccountTreeStructure methodsFor: 'report building' stamp: 'FD 11/15/2020 15:39:49'!
affectReport: aReportInProgress FromTransferSending: aTransferSending

	^aReportInProgress.! !

!AccountTreeStructure methodsFor: 'report building' stamp: 'FD 11/15/2020 15:39:26'!
affectReport: aReportInProgress FromWithdraw: aWithdraw

	^aReportInProgress.! !

!AccountTreeStructure methodsFor: 'report building' stamp: 'FD 11/15/2020 16:59:48'!
cleanAfterAffectReport

	self decreaseIndentationLevel.! !


!AccountTreeStructure methodsFor: 'report building -- private' stamp: 'FD 11/15/2020 16:59:48'!
decreaseIndentationLevel

	^ indentationLevel := indentationLevel - 1! !

!AccountTreeStructure methodsFor: 'report building -- private' stamp: 'FD 11/15/2020 16:58:54'!
increaseIndentationLevel

	^ indentationLevel := indentationLevel + 1! !

!AccountTreeStructure methodsFor: 'report building -- private' stamp: 'FD 11/15/2020 16:20:11'!
indent: anEntry

	| indentedEntry |
	
	indentedEntry := anEntry.
	indentationLevel timesRepeat: [indentedEntry := '   ',indentedEntry ].
	
	^indentedEntry.! !

!AccountTreeStructure methodsFor: 'report building -- private' stamp: 'FD 11/15/2020 17:00:05'!
resetIndentationLevel

	^ indentationLevel := 0! !


!classDefinition: #AccountTreeStructureWithSummary category: 'Portfolio'!
Report subclass: #AccountTreeStructureWithSummary
	instanceVariableNames: 'account indentationLevel'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountTreeStructureWithSummary methodsFor: 'initialization' stamp: 'FD 11/15/2020 16:37:19'!
initializeWith: anAccount 
	
	account := anAccount.
	indentationLevel := 0.! !


!AccountTreeStructureWithSummary methodsFor: 'action' stamp: 'FD 11/15/2020 17:00:26'!
report

	| structure |
	
	structure := OrderedCollection new.

	account buildReport: self from: structure.
	
	self resetIndentationLevel.
	^structure.! !


!AccountTreeStructureWithSummary methodsFor: 'report building -- private' stamp: 'FD 11/15/2020 17:01:11'!
decreaseIndentationLevel

	^ indentationLevel := indentationLevel - 1! !

!AccountTreeStructureWithSummary methodsFor: 'report building -- private' stamp: 'FD 11/15/2020 17:00:43'!
increaseIndentationLevel

	^ indentationLevel := indentationLevel + 1! !

!AccountTreeStructureWithSummary methodsFor: 'report building -- private' stamp: 'FD 11/15/2020 16:37:52'!
indent: anEntry

	| indentedEntry |
	
	indentedEntry := anEntry.
	indentationLevel timesRepeat: [indentedEntry := '   ',indentedEntry ].
	
	^indentedEntry.! !

!AccountTreeStructureWithSummary methodsFor: 'report building -- private' stamp: 'FD 11/15/2020 16:52:40'!
indentCollection: aCollectionOfEntries

	^aCollectionOfEntries collect: [:anEntry | self indent: anEntry ].! !

!AccountTreeStructureWithSummary methodsFor: 'report building -- private' stamp: 'FD 11/15/2020 17:00:26'!
resetIndentationLevel

	^ indentationLevel := 0! !


!AccountTreeStructureWithSummary methodsFor: 'report building' stamp: 'FD 11/15/2020 17:00:43'!
affectReport: aReportInProgress FromAccount: anAccount

	aReportInProgress add: (self indent: anAccount name).	
	self increaseIndentationLevel.
	
	aReportInProgress addAll: ( self indentCollection: ( AccountSummary  for: anAccount ) report).
	
	^aReportInProgress.! !

!AccountTreeStructureWithSummary methodsFor: 'report building' stamp: 'FD 11/15/2020 16:38:31'!
affectReport: aReportInProgress FromDeposit: aDeposit

	^aReportInProgress.! !

!AccountTreeStructureWithSummary methodsFor: 'report building' stamp: 'FD 11/15/2020 17:00:57'!
affectReport: aReportInProgress FromPortfolio: aPortfolio

	aReportInProgress add: (self indent: aPortfolio name).	
	self increaseIndentationLevel.
	
	^aReportInProgress.! !

!AccountTreeStructureWithSummary methodsFor: 'report building' stamp: 'FD 11/15/2020 16:38:45'!
affectReport: aReportInProgress FromTransferReception: aTransferReception

	^aReportInProgress.! !

!AccountTreeStructureWithSummary methodsFor: 'report building' stamp: 'FD 11/15/2020 16:38:54'!
affectReport: aReportInProgress FromTransferSending: aTransferSending

	^aReportInProgress.! !

!AccountTreeStructureWithSummary methodsFor: 'report building' stamp: 'FD 11/15/2020 16:39:05'!
affectReport: aReportInProgress FromWithdraw: aWithdraw

	^aReportInProgress.! !

!AccountTreeStructureWithSummary methodsFor: 'report building' stamp: 'FD 11/15/2020 17:01:11'!
cleanAfterAffectReport

	self decreaseIndentationLevel.! !


!classDefinition: #Balance category: 'Portfolio'!
Report subclass: #Balance
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Balance methodsFor: 'action' stamp: 'FD 11/14/2020 19:39:27'!
report
	
	^account buildReport: self from: 0.! !


!Balance methodsFor: 'report building' stamp: 'FD 11/15/2020 15:37:20'!
affectReport: aReportInProgress FromAccount: aAccount

	^aReportInProgress.! !

!Balance methodsFor: 'report building' stamp: 'FD 11/14/2020 19:48:00'!
affectReport: aReportInProgress FromDeposit: aDeposit
	
	^aReportInProgress + aDeposit value.! !

!Balance methodsFor: 'report building' stamp: 'FD 11/15/2020 15:33:36'!
affectReport: aReportInProgress FromPortfolio: aPortfolio

	^aReportInProgress.! !

!Balance methodsFor: 'report building' stamp: 'FD 11/14/2020 19:40:54'!
affectReport: aReportInProgress FromTransferReception: aTransferReception
	
	^aReportInProgress + aTransferReception value.! !

!Balance methodsFor: 'report building' stamp: 'FD 11/14/2020 19:41:13'!
affectReport: aReportInProgress FromTransferSending: aTransferSending
	
	^aReportInProgress - aTransferSending value.! !

!Balance methodsFor: 'report building' stamp: 'FD 11/14/2020 19:47:56'!
affectReport: aReportInProgress FromWithdraw: aWithdraw
	
	^aReportInProgress - aWithdraw value.! !

!Balance methodsFor: 'report building' stamp: 'FD 11/15/2020 16:57:36'!
cleanAfterAffectReport! !


!Balance methodsFor: 'initialization' stamp: 'FD 11/14/2020 19:45:41'!
initializeWith: anAccount 
	
	account := anAccount.! !


!classDefinition: #NetTransferReport category: 'Portfolio'!
Report subclass: #NetTransferReport
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!NetTransferReport methodsFor: 'report building' stamp: 'FD 11/15/2020 15:37:25'!
affectReport: aReportInProgress FromAccount: aAccount

	^aReportInProgress.! !

!NetTransferReport methodsFor: 'report building' stamp: 'FD 11/14/2020 18:27:25'!
affectReport: aReportInProgress FromDeposit: aDeposit
	
	^aReportInProgress.! !

!NetTransferReport methodsFor: 'report building' stamp: 'FD 11/15/2020 15:33:30'!
affectReport: aReportInProgress FromPortfolio: aPortfolio

	^aReportInProgress.! !

!NetTransferReport methodsFor: 'report building' stamp: 'FD 11/14/2020 18:35:11'!
affectReport: aReportInProgress FromTransferReception: aTransferReception
	
	^aReportInProgress + aTransferReception value.! !

!NetTransferReport methodsFor: 'report building' stamp: 'FD 11/14/2020 18:27:54'!
affectReport: aReportInProgress FromTransferSending: aTransferSending
	
	^aReportInProgress - aTransferSending value.! !

!NetTransferReport methodsFor: 'report building' stamp: 'FD 11/14/2020 18:27:13'!
affectReport: aReportInProgress FromWithdraw: aWithdraw
	
	^aReportInProgress.! !

!NetTransferReport methodsFor: 'report building' stamp: 'FD 11/15/2020 16:57:36'!
cleanAfterAffectReport! !


!NetTransferReport methodsFor: 'action' stamp: 'FD 11/14/2020 18:28:26'!
report
	
	^account buildReport: self from: 0.! !


!NetTransferReport methodsFor: 'initialization' stamp: 'FD 11/14/2020 19:15:08'!
initializeWith: anAccount 
	
	account := anAccount.! !


!classDefinition: #Transfer category: 'Portfolio'!
Object subclass: #Transfer
	instanceVariableNames: 'value sending reception'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Transfer methodsFor: 'initialization' stamp: 'FD 11/9/2020 21:15:06'!
initializeFor: anAmount withSending: aTransferSending withReception: aTransferReception 
	
	
	value := anAmount.
	sending := aTransferSending.
	reception := aTransferReception.! !


!Transfer methodsFor: 'accessing' stamp: 'FD 11/9/2020 21:18:14'!
reception
	
	^reception! !

!Transfer methodsFor: 'accessing' stamp: 'FD 11/9/2020 21:17:41'!
sending
	
	^sending! !

!Transfer methodsFor: 'accessing' stamp: 'FD 11/14/2020 16:41:12'!
value

	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'FD 11/14/2020 19:27:57'!
assertAccount: aSenderAccount isDifferentFrom: aReceiverAccount

	^ aSenderAccount = aReceiverAccount ifTrue: [self error: self accountsMustBeDifferentErrorDescription ]! !

!Transfer class methodsFor: 'instance creation' stamp: 'FD 11/14/2020 19:28:33'!
assertAmountIsPositive: anAmount

	^ anAmount <= 0 ifTrue: [self error: self amountShouldBeGreaterThanZeroErrorDescription ]! !

!Transfer class methodsFor: 'instance creation' stamp: 'FD 11/14/2020 19:29:49'!
register: anAmount on: aSenderAccount to: aReceiverAccount 
	
	
	| transaction sending reception |
	
	self assertAccount: aSenderAccount isDifferentFrom: aReceiverAccount.
	self assertAmountIsPositive: anAmount.
	
	transaction := self new.
	
	sending := TransferSending new initializeFrom: transaction.
	reception := TransferReception new initializeFrom: transaction.
	transaction := transaction initializeFor: anAmount withSending: sending withReception: reception.

	
	aSenderAccount register: sending.
	aReceiverAccount register: reception.
	
	^ transaction! !


!Transfer class methodsFor: 'errors' stamp: 'FD 11/9/2020 20:21:47'!
accountsMustBeDifferentErrorDescription

 	^'accounts must be different'.! !

!Transfer class methodsFor: 'errors' stamp: 'FD 11/9/2020 21:32:06'!
amountShouldBeGreaterThanZeroErrorDescription

 	^'amount should be greater than zero'.! !


!classDefinition: #TransferEnd category: 'Portfolio'!
Object subclass: #TransferEnd
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!TransferEnd methodsFor: 'accessing' stamp: 'FD 11/14/2020 19:31:40'!
value
	self subclassResponsibility.! !


!TransferEnd methodsFor: 'report building' stamp: 'FD 11/14/2020 19:34:33'!
buildReport: buildingInstructions from: aReportToBuildOnto

	self subclassResponsibility ! !


!classDefinition: #TransferReception category: 'Portfolio'!
TransferEnd subclass: #TransferReception
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!TransferReception methodsFor: 'initialization' stamp: 'FD 11/14/2020 19:32:25'!
initializeFrom: aTransfer

	transfer := aTransfer.! !


!TransferReception methodsFor: 'accessing' stamp: 'FD 11/14/2020 19:33:09'!
value

	^transfer value.! !


!TransferReception methodsFor: 'report building' stamp: 'FD 11/14/2020 19:35:16'!
buildReport: buildingInstructions from: aReportToBuildOnto

	^buildingInstructions affectReport: aReportToBuildOnto FromTransferReception: self.! !


!classDefinition: #TransferSending category: 'Portfolio'!
TransferEnd subclass: #TransferSending
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!TransferSending methodsFor: 'initialization' stamp: 'FD 11/14/2020 19:32:44'!
initializeFrom: aTransfer

	transfer := aTransfer.! !


!TransferSending methodsFor: 'accessing' stamp: 'FD 11/14/2020 19:33:34'!
value

	^transfer value.! !


!TransferSending methodsFor: 'report building' stamp: 'FD 11/14/2020 19:35:43'!
buildReport: buildingInstructions from: aReportToBuildOnto

	^buildingInstructions affectReport: aReportToBuildOnto FromTransferSending: self.! !
