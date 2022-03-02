!classDefinition: #PortfolioReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioReportTest methodsFor: 'portfolio tree' stamp: 'Ciro 6/2/2021 19:48:11'!
test01ReturnPortfolioTreeReportFromAnEmptyPortfolio

	| portfolioReport aPortfolio expectedReport|
	
	aPortfolio _ Portfolio named: 'Portfolio Vacío'.
	portfolioReport _ PortfolioTree for: aPortfolio.
	expectedReport _ OrderedCollection with: 'Portfolio Vacío'.
	
	self assert: expectedReport equals: portfolioReport execute.! !

!PortfolioReportTest methodsFor: 'portfolio tree' stamp: 'Ciro 6/2/2021 19:48:15'!
test02ReturnPortfolioTreeReportFromAPortfolioWithAReceptiveAccount

	| portfolioReport aPortfolio aReceptiveAccount expectedReport|
	
	aPortfolio _ Portfolio named: 'Portfolio Root'.
	aReceptiveAccount  _ ReceptiveAccount named: 'Cuenta Hijo'.
	aPortfolio add: aReceptiveAccount.
	portfolioReport _ PortfolioTree for: aPortfolio.
	expectedReport _ OrderedCollection with: 'Portfolio Root' with: '   Cuenta Hijo'.
	
	self assert: expectedReport equals: portfolioReport execute.! !

!PortfolioReportTest methodsFor: 'portfolio tree' stamp: 'Ciro 6/2/2021 19:48:19'!
test03ReturnPortfolioTreeReportFromAPortfolioWithAccounts

	| portfolioReport aPortfolioRoot aPortfolioChild aReceptiveAccount anotherReceptiveAccount expectedReport|
	
	aPortfolioRoot _ Portfolio named: 'Portfolio Root'.
	aPortfolioChild _ Portfolio named: 'Portfolio Hijo'.
	aReceptiveAccount  _ ReceptiveAccount named: 'Cuenta Hijo de Root'.
	anotherReceptiveAccount  _ ReceptiveAccount named: 'Cuenta Hijo de Portfolio Hijo'.
	aPortfolioRoot add: aReceptiveAccount.
	aPortfolioChild add: anotherReceptiveAccount.
	aPortfolioRoot add: aPortfolioChild.
	portfolioReport _ PortfolioTree for: aPortfolioRoot.
	expectedReport _ OrderedCollection 
		with: 'Portfolio Root' 
		with: '   Cuenta Hijo de Root' 
		with: '   Portfolio Hijo' 
		with: '      Cuenta Hijo de Portfolio Hijo'.
	
	self assert: expectedReport equals: portfolioReport execute.! !


!PortfolioReportTest methodsFor: 'portfolio summary tree' stamp: 'Ciro 6/2/2021 20:49:05'!
completeSummaryTree
	
	| summaryTree |
	
	summaryTree _ OrderedCollection new.
	summaryTree add: 'Portfolio Root'.
	summaryTree add: '   Cuenta Hijo de Root'.
	summaryTree add: '      Depósito por 100'.
	summaryTree add: '      Salida por transferencia de 20'.
	summaryTree add: '      Balance = 80'.
	summaryTree add: '   Portfolio Hijo'.
	summaryTree add: '      Cuenta Hijo de Portfolio Hijo'.
	summaryTree add: '         Extracción por 50'.
	summaryTree add: '         Entrada por transferencia de 20'.
	summaryTree add: '         Balance = -30'.
	summaryTree add: '      Balance = -30'.
	summaryTree add: '   Balance = 50'.
	
	^ summaryTree! !

!PortfolioReportTest methodsFor: 'portfolio summary tree' stamp: 'Ciro 6/2/2021 19:50:52'!
test04ReturnPortfolioSummaryTreeReportFromAnEmptyPortfolio

	| portfolioReport aPortfolio expectedReport|
	
	aPortfolio _ Portfolio named: 'Portfolio Vacío'.
	portfolioReport _ PortfolioSummaryTree for: aPortfolio.
	expectedReport _ OrderedCollection with: 'Portfolio Vacío' with: '   Balance = 0'.
	
	self assert: expectedReport equals: portfolioReport execute.! !

!PortfolioReportTest methodsFor: 'portfolio summary tree' stamp: 'Ciro 6/2/2021 19:52:39'!
test05ReturnPortfolioSummaryTreeReportWithARecepetiveAccount

	| portfolioReport aPortfolio aReceptiveAccount expectedReport|
	
	aPortfolio _ Portfolio named: 'Portfolio Root'.
	aReceptiveAccount _ ReceptiveAccount named: 'Cuenta Hijo'.
	aPortfolio add: aReceptiveAccount.
	portfolioReport _ PortfolioSummaryTree for: aPortfolio.
	expectedReport _ OrderedCollection 
		with: 'Portfolio Root' 
		with: '   Cuenta Hijo' 
		with: '      Balance = 0' 
		with: '   Balance = 0'.
	
	self assert: expectedReport equals: portfolioReport execute.! !

!PortfolioReportTest methodsFor: 'portfolio summary tree' stamp: 'Ciro 6/2/2021 20:28:53'!
test06ReturnPortfolioSummaryTreeReportWithAccountsAndTransactions

	| portfolioReport aPortfolioRoot aPortfolioChild aReceptiveAccount anotherReceptiveAccount expectedReport|
	
	aPortfolioRoot _ Portfolio named: 'Portfolio Root'.
	aPortfolioChild _ Portfolio named: 'Portfolio Hijo'.
	aReceptiveAccount  _ ReceptiveAccount named: 'Cuenta Hijo de Root'.
	anotherReceptiveAccount  _ ReceptiveAccount named: 'Cuenta Hijo de Portfolio Hijo'.
	Deposit register: 100 on: aReceptiveAccount.
	Withdraw register: 50 on: anotherReceptiveAccount.
	Transference from: aReceptiveAccount to: anotherReceptiveAccount withValue: 20.
	aPortfolioRoot add: aReceptiveAccount.
	aPortfolioChild add: anotherReceptiveAccount.
	aPortfolioRoot add: aPortfolioChild.
	portfolioReport _ PortfolioSummaryTree for: aPortfolioRoot.
	expectedReport _ self completeSummaryTree.
	
	self assert: expectedReport equals: portfolioReport execute.! !


!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

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


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTest methodsFor: 'account summary' stamp: 'Ciro 6/2/2021 17:46:11'!
collectionWithAllKindsOfTransactionsMessages

	^ OrderedCollection with: 'Depósito por 100' 
		with: 'Extracción por 50' 
		with: 'Salida por transferencia de 20' 
		with: 'Entrada por transferencia de 30' 
		with: 'Balance = 60'! !

!ReportTest methodsFor: 'account summary' stamp: 'Ciro 6/2/2021 18:51:05'!
test01ReturnReportFromAnEmptyReceptiveAccount

	| report receptiveAccount expectedReport |
	
	receptiveAccount _ ReceptiveAccount new.
	report _ AccountSummary for: receptiveAccount.
	expectedReport _ OrderedCollection with: 'Balance = 0'.
	
	self assert: 0 equals: receptiveAccount balance.
	self assert: expectedReport equals: report execute.! !

!ReportTest methodsFor: 'account summary' stamp: 'Ciro 6/2/2021 18:51:05'!
test02ReturnReportFromAReceptiveAccountWithADeposit

	| report receptiveAccount expectedReport |
	
	receptiveAccount _ ReceptiveAccount new.
	report _ AccountSummary for: receptiveAccount.
	Deposit register: 100 on: receptiveAccount. 
	expectedReport _ OrderedCollection with: 'Depósito por 100' with: 'Balance = 100'.
	
	self assert: expectedReport equals: report execute.! !

!ReportTest methodsFor: 'account summary' stamp: 'Ciro 6/2/2021 18:51:05'!
test03ReturnReportFromAReceptiveAccountWithAWithdraw

	| report receptiveAccount expectedReport |
	
	receptiveAccount _ ReceptiveAccount new.
	report _ AccountSummary for: receptiveAccount.
	Withdraw register: 100 on: receptiveAccount. 
	expectedReport _ OrderedCollection with: 'Extracción por 100' with: 'Balance = -100'.
	
	self assert: expectedReport equals: report execute.! !

!ReportTest methodsFor: 'account summary' stamp: 'Ciro 6/2/2021 18:51:05'!
test04ReturnReportFromAReceptiveAccountWithATransferenceDeposit

	| report receptiveAccountToReport anotherReceptiveAccount expectedReport |
	
	receptiveAccountToReport _ ReceptiveAccount new.
	anotherReceptiveAccount _ ReceptiveAccount new.
	report _ AccountSummary for: receptiveAccountToReport.
	Transference from: anotherReceptiveAccount to: receptiveAccountToReport withValue: 20.
	expectedReport _ OrderedCollection with: 'Entrada por transferencia de 20' with: 'Balance = 20'.
	
	self assert: expectedReport equals: report execute.! !

!ReportTest methodsFor: 'account summary' stamp: 'Ciro 6/2/2021 18:51:05'!
test05ReturnReportFromAReceptiveAccountWithATransferenceWithdraw

	| report receptiveAccountToReport anotherReceptiveAccount expectedReport |
	
	receptiveAccountToReport _ ReceptiveAccount new.
	anotherReceptiveAccount _ ReceptiveAccount new.
	report _ AccountSummary for: receptiveAccountToReport.
	Transference from: receptiveAccountToReport to: anotherReceptiveAccount withValue: 20.
	expectedReport _ OrderedCollection with: 'Salida por transferencia de 20' with: 'Balance = -20'.
	
	self assert: expectedReport equals: report execute.! !

!ReportTest methodsFor: 'account summary' stamp: 'Ciro 6/2/2021 18:51:05'!
test06ReturnReportFromAReceptiveAccountWithManyTransactions

	| report receptiveAccountToReport anotherReceptiveAccount expectedReport |
	
	receptiveAccountToReport _ ReceptiveAccount new.
	anotherReceptiveAccount _ ReceptiveAccount new.
	report _ AccountSummary for: receptiveAccountToReport.
	Deposit register: 100 on: receptiveAccountToReport.
	Withdraw register: 50 on: receptiveAccountToReport.
	Transference from: receptiveAccountToReport to: anotherReceptiveAccount withValue: 20.
	Transference from: anotherReceptiveAccount to: receptiveAccountToReport withValue: 30.
	expectedReport _ self collectionWithAllKindsOfTransactionsMessages.
	
	self assert: expectedReport equals: report execute.! !

!ReportTest methodsFor: 'account summary' stamp: 'Ciro 6/2/2021 18:51:05'!
test07ReturnReportFromAPortfolioWithManyTransactions

	| report aPortfolioToReport aReceptiveAccount1 aReceptiveAccount2 aReceptiveAccount3 expectedReport |
	
	aPortfolioToReport _ Portfolio new.
	aReceptiveAccount1 _ ReceptiveAccount new.
	aReceptiveAccount2 _ ReceptiveAccount new.
	aReceptiveAccount3 _ ReceptiveAccount new.
	aPortfolioToReport add: aReceptiveAccount1.
	aPortfolioToReport add: aReceptiveAccount2.
	report _ AccountSummary for: aPortfolioToReport.
	Deposit register: 100 on: aReceptiveAccount1.
	Withdraw register: 50 on: aReceptiveAccount1.
	Transference from: aReceptiveAccount2 to: aReceptiveAccount3 withValue: 20.
	Transference from: aReceptiveAccount3 to: aReceptiveAccount2 withValue: 30.
	expectedReport _ self collectionWithAllKindsOfTransactionsMessages.
	
	self assert: expectedReport equals: report execute.! !


!ReportTest methodsFor: 'transfer net' stamp: 'Ciro 6/2/2021 18:51:05'!
test08TransferNetReportFromEmptyAccount

	| report receptiveAccount |
	
	receptiveAccount _ ReceptiveAccount new.
	report _ TransferNet for: receptiveAccount.
	
	self assert: 0 equals: report execute.! !

!ReportTest methodsFor: 'transfer net' stamp: 'Ciro 6/2/2021 18:51:05'!
test09TransferNetReportFromAReceptiveAccountWithDeposit

	| report aReceptiveAccountToReport |
	
	aReceptiveAccountToReport _ ReceptiveAccount new.
	Deposit register: 100 on: aReceptiveAccountToReport.
	report _ TransferNet for: aReceptiveAccountToReport.
	
	self assert: 0 equals: report execute.! !

!ReportTest methodsFor: 'transfer net' stamp: 'Ciro 6/2/2021 18:51:05'!
test10TransferNetReportFromAReceptiveAccountWithWithdraw

	| report aReceptiveAccountToReport |
	
	aReceptiveAccountToReport _ ReceptiveAccount new.
	Withdraw register: 50 on: aReceptiveAccountToReport.
	report _ TransferNet for: aReceptiveAccountToReport.
	
	self assert: 0 equals: report execute.! !

!ReportTest methodsFor: 'transfer net' stamp: 'Ciro 6/2/2021 18:51:05'!
test11TransferNetReportFromAReceptiveAccountWithTransferenceDeposit

	| report aReceptiveAccountToReport anotherReceptiveAccount |
	
	aReceptiveAccountToReport _ ReceptiveAccount new.
	anotherReceptiveAccount _ ReceptiveAccount new.
	Transference from: anotherReceptiveAccount to: aReceptiveAccountToReport withValue: 30.
	report _ TransferNet for: aReceptiveAccountToReport.
	
	self assert: 30 equals: report execute.! !

!ReportTest methodsFor: 'transfer net' stamp: 'Ciro 6/2/2021 18:51:05'!
test12TransferNetReportFromAReceptiveAccountWithTransferenceWithdraw

	| report aReceptiveAccountToReport anotherReceptiveAccount |
	
	aReceptiveAccountToReport _ ReceptiveAccount new.
	anotherReceptiveAccount _ ReceptiveAccount new.
	Transference from: aReceptiveAccountToReport to: anotherReceptiveAccount withValue: 20.
	report _ TransferNet for: aReceptiveAccountToReport.
	
	self assert: -20 equals: report execute.! !

!ReportTest methodsFor: 'transfer net' stamp: 'Ciro 6/2/2021 18:51:05'!
test13TransferNetReportFromAReceptiveAccountWithTransferences

	| report aReceptiveAccountToReport anotherReceptiveAccount |
	
	aReceptiveAccountToReport _ ReceptiveAccount new.
	anotherReceptiveAccount _ ReceptiveAccount new.
	Deposit register: 100 on: aReceptiveAccountToReport.
	Withdraw register: 50 on: aReceptiveAccountToReport.
	Transference from: aReceptiveAccountToReport to: anotherReceptiveAccount withValue: 20.
	Transference from: anotherReceptiveAccount to: aReceptiveAccountToReport withValue: 30.
	report _ TransferNet for: aReceptiveAccountToReport.
	
	self assert: 10 equals: report execute.! !

!ReportTest methodsFor: 'transfer net' stamp: 'Ciro 6/2/2021 18:51:05'!
test14TransferNetReportFromAPortfolio

	| report aPortfolioToReport aReceptiveAccount1 aReceptiveAccount2 aReceptiveAccount3 |
	
	aPortfolioToReport _ Portfolio new.
	aReceptiveAccount1 _ ReceptiveAccount new.
	aReceptiveAccount2 _ ReceptiveAccount new.
	aReceptiveAccount3 _ ReceptiveAccount new.
	aPortfolioToReport add: aReceptiveAccount1.
	aPortfolioToReport add: aReceptiveAccount2.
	report _ TransferNet for: aPortfolioToReport.
	Deposit register: 100 on: aReceptiveAccount1.
	Withdraw register: 50 on: aReceptiveAccount1.
	Transference from: aReceptiveAccount2 to: aReceptiveAccount3 withValue: 20.
	Transference from: aReceptiveAccount3 to: aReceptiveAccount2 withValue: 30.
	
	self assert: 10 equals: report execute.! !


!classDefinition: #TransferenceTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferenceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceTest methodsFor: 'tests' stamp: 'Ciro 5/30/2021 17:25:19'!
test01NewTransferenceBetweenTwoReceptiveAccounts

	| transference senderAccount receivingAccount |
	
	senderAccount _ ReceptiveAccount new.
	receivingAccount _ ReceptiveAccount new.
	transference _ Transference from: senderAccount to: receivingAccount withValue: 100.
	
	self assert: 100 equals: transference value.
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'Ciro 6/2/2021 18:24:49'!
test02SenderAccountBalanceAfterTransference

	| transference senderAccount receivingAccount |
	
	senderAccount _ ReceptiveAccount new.
	receivingAccount _ ReceptiveAccount new.
	transference _ Transference from: senderAccount to: receivingAccount withValue: 100.
	
	self assert: 100 equals: transference value.
	self assert: -100 equals: senderAccount balance.
	self assert: (senderAccount hasRegistered: transference transferenceWithdrawLeg)
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'Ciro 6/2/2021 18:24:31'!
test03ReceiverAccountBalanceAfterTransference

	| transference senderAccount receivingAccount |
	
	senderAccount _ ReceptiveAccount new.
	receivingAccount _ ReceptiveAccount new.
	transference _ Transference from: senderAccount to: receivingAccount withValue: 100.
	
	self assert: 100 equals: transference value.
	self assert: 100 equals: receivingAccount balance.
	self assert: (receivingAccount hasRegistered: transference transferenceDepositLeg)
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'Ciro 6/2/2021 18:24:49'!
test04TransferenceWithdrawKnowsTransferenceDeposit

	| transference senderAccount receivingAccount |
	
	senderAccount _ ReceptiveAccount new.
	receivingAccount _ ReceptiveAccount new.
	transference _ Transference from: senderAccount to: receivingAccount withValue: 100.
	
	self assert: transference transferenceDepositLeg equals: transference transferenceWithdrawLeg transference transferenceDepositLeg.
	self assert: transference transferenceWithdrawLeg equals: transference transferenceDepositLeg transference transferenceWithdrawLeg	! !

!TransferenceTest methodsFor: 'tests' stamp: 'Ciro 5/30/2021 17:31:27'!
test05CanOnlyTransferPositiveValues

	| senderAccount receivingAccount |
	
	senderAccount _ ReceptiveAccount new.
	receivingAccount _ ReceptiveAccount new.
	
	self 
		should: [ Transference from: senderAccount to: receivingAccount withValue: -100 ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: Transference canOnlyTransferPositiveValuesErrorDescription equals: anError messageText ]
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'Ciro 5/30/2021 17:38:36'!
test06CanNotTransferBetweenTheSameReceptiveAccount

	| receptiveAccount |
	
	receptiveAccount _ ReceptiveAccount new.
	
	self 
		should: [ Transference from: receptiveAccount to: receptiveAccount withValue: 100 ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: Transference canNotTransferBetweenTheSameReceptiveAccountErrorDescription equals: anError messageText ]
	! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

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


!Account methodsFor: 'report' stamp: 'Ciro 6/2/2021 18:02:47'!
exploreTransactionsFor: aReport

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'initialization' stamp: 'Ciro 6/2/2021 18:50:07'!
initializeWithName: aName 

	name _  aName.! !


!Account methodsFor: 'accesing' stamp: 'Ciro 6/2/2021 19:10:25'!
name

	^ name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'Portfolio-Solucion'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'instance creation' stamp: 'Ciro 6/2/2021 18:49:01'!
named: aName 
	
	^self new initializeWithName: aName ! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

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


!Portfolio methodsFor: 'report' stamp: 'Ciro 6/2/2021 20:42:19'!
exploreAccountsFor: aPortfolioReport withCounter: aCounter

	aPortfolioReport takePortfolioName: self withCounter: aCounter.
	accounts do: [ :anAccount | anAccount exploreAccountsFor: aPortfolioReport withCounter: aCounter + 1].
	aPortfolioReport takePortfolioBalance: self withCounter: aCounter.! !

!Portfolio methodsFor: 'report' stamp: 'Ciro 6/2/2021 18:02:47'!
exploreTransactionsFor: aReport

	accounts do: [ :anAccount | anAccount exploreTransactionsFor: aReport]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

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



!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

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


!ReceptiveAccount methodsFor: 'report' stamp: 'Ciro 6/2/2021 19:59:16'!
exploreAccountsFor: aPortfolioReport withCounter: aCounter

	aPortfolioReport takeReceptiveAccountName: self withCounter: aCounter! !

!ReceptiveAccount methodsFor: 'report' stamp: 'Ciro 6/2/2021 18:07:42'!
exploreTransactionsFor: aReport

	transactions do: [ :aTransaction | aTransaction inspectFor: aReport ]! !

!ReceptiveAccount methodsFor: 'report' stamp: 'Ciro 6/2/2021 20:22:49'!
exploreTransactionsFor: aReport withCounter: aCounter

	transactions do: [ :aTransaction | aTransaction inspectFor: aReport withCounter: aCounter ]! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'report' stamp: 'Ciro 6/2/2021 18:07:42'!
inspectFor: aReport

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'report' stamp: 'Ciro 6/2/2021 18:10:12'!
inspectFor: aReport

	aReport takeDepositValueFrom: self! !

!Deposit methodsFor: 'report' stamp: 'Ciro 6/2/2021 20:23:07'!
inspectFor: aReport withCounter: aCounter

	aReport takeDepositValueFrom: self withCounter: aCounter! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferenceLeg category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferenceLeg
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceLeg methodsFor: 'initialize' stamp: 'Ciro 5/30/2021 17:20:41'!
initializeFor: aTransference in: aReceptiveAccount

	transference  _ aTransference.
	aReceptiveAccount register: self! !


!TransferenceLeg methodsFor: 'report' stamp: 'Ciro 6/2/2021 18:20:38'!
inspectFor: aReport

	self subclassResponsibility ! !

!TransferenceLeg methodsFor: 'report' stamp: 'Ciro 6/2/2021 20:23:20'!
inspectFor: aReport withCounter: aCounter

	self subclassResponsibility ! !


!TransferenceLeg methodsFor: 'value' stamp: 'Ciro 5/30/2021 17:28:43'!
value

	^ transference value! !


!TransferenceLeg methodsFor: 'balance' stamp: 'Ciro 5/30/2021 17:22:48'!
affectBalance: aBalance

	self subclassResponsibility ! !


!TransferenceLeg methodsFor: 'accesing' stamp: 'Ciro 5/30/2021 17:23:59'!
transference

	^ transference! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceLeg class' category: 'Portfolio-Solucion'!
TransferenceLeg class
	instanceVariableNames: ''!

!TransferenceLeg class methodsFor: 'instance creation' stamp: 'Ciro 5/30/2021 17:19:53'!
for: aTransference in: aReceptiveAccount

	^ self new initializeFor: aTransference in: aReceptiveAccount.! !


!classDefinition: #TransferenceDepositLeg category: 'Portfolio-Solucion'!
TransferenceLeg subclass: #TransferenceDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceDepositLeg methodsFor: 'report' stamp: 'Ciro 6/2/2021 18:25:50'!
inspectFor: aReport

	aReport takeTransferenceDepositLegValueFrom: self! !

!TransferenceDepositLeg methodsFor: 'report' stamp: 'Ciro 6/2/2021 20:23:26'!
inspectFor: aReport withCounter: aCounter

	aReport takeTransferenceDepositLegValueFrom: self withCounter: aCounter! !


!TransferenceDepositLeg methodsFor: 'balance' stamp: 'Ciro 5/30/2021 17:28:50'!
affectBalance: aBalance

	^aBalance + self value! !


!classDefinition: #TransferenceWithdrawLeg category: 'Portfolio-Solucion'!
TransferenceLeg subclass: #TransferenceWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceWithdrawLeg methodsFor: 'balance' stamp: 'Ciro 5/30/2021 17:28:54'!
affectBalance: aBalance

	^aBalance - self value! !


!TransferenceWithdrawLeg methodsFor: 'report' stamp: 'Ciro 6/2/2021 18:26:00'!
inspectFor: aReport

	aReport takeTransferenceWithdrawLegValueFrom: self! !

!TransferenceWithdrawLeg methodsFor: 'report' stamp: 'Ciro 6/2/2021 20:23:31'!
inspectFor: aReport withCounter: aCounter

	aReport takeTransferenceWithdrawLegValueFrom: self withCounter: aCounter! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'report' stamp: 'Ciro 6/2/2021 18:10:28'!
inspectFor: aReport

	aReport takeWithdrawValueFrom: self! !

!Withdraw methodsFor: 'report' stamp: 'Ciro 6/2/2021 20:23:35'!
inspectFor: aReport withCounter: aCounter

	aReport takeWithdrawValueFrom: self withCounter: aCounter! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #PortfolioReport category: 'Portfolio-Solucion'!
Object subclass: #PortfolioReport
	instanceVariableNames: 'account portfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioReport methodsFor: 'initialization' stamp: 'Ciro 6/2/2021 18:51:28'!
initializeFor: aPortfolio 

	portfolio _ aPortfolio.! !


!PortfolioReport methodsFor: 'execute' stamp: 'Ciro 6/2/2021 18:52:40'!
execute
	
	self subclassResponsibility ! !


!PortfolioReport methodsFor: 'private' stamp: 'Ciro 6/2/2021 19:58:21'!
takePortfolioName: aPortfolio withCounter: aCounter

	self subclassResponsibility! !

!PortfolioReport methodsFor: 'private' stamp: 'Ciro 6/2/2021 19:58:33'!
takeReceptiveAccountName: aReceptiveAccount withCounter: aCounter

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioReport class' category: 'Portfolio-Solucion'!
PortfolioReport class
	instanceVariableNames: ''!

!PortfolioReport class methodsFor: 'instance creation' stamp: 'Ciro 6/2/2021 18:51:05'!
for: aPortfolio 

	^self new initializeFor: aPortfolio ! !


!classDefinition: #PortfolioSummaryTree category: 'Portfolio-Solucion'!
PortfolioReport subclass: #PortfolioSummaryTree
	instanceVariableNames: 'summaryTree'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioSummaryTree methodsFor: 'execute' stamp: 'Ciro 6/2/2021 20:49:22'!
execute

	summaryTree _ OrderedCollection new.
	
	portfolio exploreAccountsFor: self withCounter: 0.
	
	^summaryTree! !


!PortfolioSummaryTree methodsFor: 'private' stamp: 'Ciro 6/2/2021 20:34:37'!
takeDepositValueFrom: aDeposit withCounter: aCounter

	| space |
	
	space _ ''.
	
	aCounter timesRepeat: [space _ '   ',space].
	
	summaryTree add: (space,'   ','Depósito por ', aDeposit value asString).! !

!PortfolioSummaryTree methodsFor: 'private' stamp: 'Ciro 6/2/2021 20:45:47'!
takePortfolioBalance: aPortfolio withCounter: aCounter

	| space |
	
	space _ ''.
	
	aCounter timesRepeat: [space _ '   ',space].
	
	summaryTree add: (space,'   Balance = ',aPortfolio balance asString).! !

!PortfolioSummaryTree methodsFor: 'private' stamp: 'Ciro 6/2/2021 19:56:04'!
takePortfolioName: aPortfolio withCounter: aCounter

	| space |
	
	space _ ''.
	
	aCounter timesRepeat: [space _ '   ',space].
	
	summaryTree add: (space,aPortfolio name).! !

!PortfolioSummaryTree methodsFor: 'private' stamp: 'Ciro 6/2/2021 20:46:13'!
takeReceptiveAccountName: aReceptiveAccount withCounter: aCounter

	| space |
	
	space _ ''.
	
	aCounter timesRepeat: [space _ '   ',space].
	
	summaryTree add: (space,aReceptiveAccount name).
	
	aReceptiveAccount exploreTransactionsFor: self withCounter: aCounter.
	
	summaryTree add: (space,'   Balance = ', aReceptiveAccount balance asString).! !

!PortfolioSummaryTree methodsFor: 'private' stamp: 'Ciro 6/2/2021 20:31:22'!
takeTransferenceDepositLegValueFrom: aTransferenceDepositLeg withCounter: aCounter

	| space |
	
	space _ ''.
	
	aCounter timesRepeat: [space _ '   ',space].
	
	summaryTree add: (space,'   ','Entrada por transferencia de ', aTransferenceDepositLeg value asString).! !

!PortfolioSummaryTree methodsFor: 'private' stamp: 'Ciro 6/2/2021 20:31:33'!
takeTransferenceWithdrawLegValueFrom: aTransferenceWithdrawLeg withCounter: aCounter

	| space |
	
	space _ ''.
	
	aCounter timesRepeat: [space _ '   ',space].
	
	summaryTree add: (space,'   ','Salida por transferencia de ', aTransferenceWithdrawLeg value asString).! !

!PortfolioSummaryTree methodsFor: 'private' stamp: 'Ciro 6/2/2021 20:31:40'!
takeWithdrawValueFrom: aWithdraw withCounter: aCounter

	| space |
	
	space _ ''.
	
	aCounter timesRepeat: [space _ '   ',space].
	
	summaryTree add: (space,'   ','Extracción por ', aWithdraw value asString).! !


!classDefinition: #PortfolioTree category: 'Portfolio-Solucion'!
PortfolioReport subclass: #PortfolioTree
	instanceVariableNames: 'tree'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTree methodsFor: 'execute' stamp: 'Ciro 6/2/2021 19:42:51'!
execute

	tree _ OrderedCollection new.
	
	portfolio exploreAccountsFor: self withCounter: 0.
	
	^tree! !


!PortfolioTree methodsFor: 'private' stamp: 'Ciro 6/2/2021 20:42:53'!
takePortfolioBalance: aPortfolio withCounter: aCounter! !

!PortfolioTree methodsFor: 'private' stamp: 'Ciro 6/2/2021 19:57:43'!
takePortfolioName: aPortfolio withCounter: aCounter

	| space |
	
	space _ ''.
	
	aCounter timesRepeat: [space _ '   ',space].
	
	tree add: (space,aPortfolio name).! !

!PortfolioTree methodsFor: 'private' stamp: 'Ciro 6/2/2021 19:58:00'!
takeReceptiveAccountName: aReceptiveAccount withCounter: aCounter

	| space |
	
	space _ ''.
	
	aCounter timesRepeat: [space _ '   ',space].
	
	tree add: (space,aReceptiveAccount name).! !


!classDefinition: #Report category: 'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'initialization' stamp: 'Ciro 5/30/2021 17:59:26'!
initializeFor: anAccount 

	account _ anAccount.! !


!Report methodsFor: 'execute' stamp: 'Ciro 6/2/2021 18:12:18'!
execute

	self subclassResponsibility! !


!Report methodsFor: 'private' stamp: 'Ciro 6/2/2021 18:10:12'!
takeDepositValueFrom: aDeposit

	self subclassResponsibility ! !

!Report methodsFor: 'private' stamp: 'Ciro 6/2/2021 18:25:50'!
takeTransferenceDepositLegValueFrom: aTransferenceDeposit

	self subclassResponsibility ! !

!Report methodsFor: 'private' stamp: 'Ciro 6/2/2021 18:26:00'!
takeTransferenceWithdrawLegValueFrom: aTransferenceWithdraw

	self subclassResponsibility ! !

!Report methodsFor: 'private' stamp: 'Ciro 6/2/2021 18:10:28'!
takeWithdrawValueFrom: aWithdraw

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'Portfolio-Solucion'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'instance creation' stamp: 'Ciro 6/2/2021 18:51:05'!
for: anAccount 
	
	^ self new initializeFor: anAccount! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'execute' stamp: 'Ciro 6/2/2021 18:12:18'!
execute
	
	summary _ OrderedCollection new.
	
	account exploreTransactionsFor: self.
	
	summary add: 'Balance = ', account balance asString.
	
	^ summary! !


!AccountSummary methodsFor: 'private' stamp: 'Ciro 6/2/2021 18:10:12'!
takeDepositValueFrom: aDeposit

	^ summary add: 'Depósito por ', aDeposit value asString! !

!AccountSummary methodsFor: 'private' stamp: 'Ciro 6/2/2021 18:25:50'!
takeTransferenceDepositLegValueFrom: aTransferenceDeposit

	^ summary add: 'Entrada por transferencia de ', aTransferenceDeposit value asString! !

!AccountSummary methodsFor: 'private' stamp: 'Ciro 6/2/2021 18:26:00'!
takeTransferenceWithdrawLegValueFrom: aTransferenceWithdraw

	^ summary add: 'Salida por transferencia de ', aTransferenceWithdraw value asString! !

!AccountSummary methodsFor: 'private' stamp: 'Ciro 6/2/2021 18:10:28'!
takeWithdrawValueFrom: aWithdraw

	^ summary add: 'Extracción por ', aWithdraw value asString! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
Report subclass: #TransferNet
	instanceVariableNames: 'transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'private' stamp: 'Ciro 6/2/2021 18:10:12'!
takeDepositValueFrom: aDeposit! !

!TransferNet methodsFor: 'private' stamp: 'Ciro 6/2/2021 18:25:50'!
takeTransferenceDepositLegValueFrom: aTransferenceDeposit

	transferNet _ transferNet + aTransferenceDeposit value! !

!TransferNet methodsFor: 'private' stamp: 'Ciro 6/2/2021 18:26:00'!
takeTransferenceWithdrawLegValueFrom: aTransferenceWithdraw

	transferNet _ transferNet - aTransferenceWithdraw value! !

!TransferNet methodsFor: 'private' stamp: 'Ciro 6/2/2021 18:10:28'!
takeWithdrawValueFrom: aWithdraw! !


!TransferNet methodsFor: 'execute' stamp: 'Ciro 6/2/2021 18:12:18'!
execute
	
	transferNet _ 0.
	
	account exploreTransactionsFor: self.
	
	^ transferNet! !


!classDefinition: #Transference category: 'Portfolio-Solucion'!
Object subclass: #Transference
	instanceVariableNames: 'transferenceWithdrawLeg transferenceDepositLeg value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transference methodsFor: 'accesing' stamp: 'Ciro 6/2/2021 18:24:31'!
transferenceDepositLeg
	
	^ transferenceDepositLeg! !

!Transference methodsFor: 'accesing' stamp: 'Ciro 6/2/2021 18:24:49'!
transferenceWithdrawLeg
	
	^ transferenceWithdrawLeg! !

!Transference methodsFor: 'accesing' stamp: 'Ciro 5/27/2021 21:11:00'!
value

	^ value! !


!Transference methodsFor: 'initialize' stamp: 'Ciro 6/2/2021 18:23:59'!
initializeWithSender: senderAccount andReceiver: receivingAccount withValue: aValue

	value _ aValue.	
	transferenceWithdrawLeg _ TransferenceWithdrawLeg for: self in: senderAccount.
	transferenceDepositLeg _ TransferenceDepositLeg for: self in: receivingAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: 'Portfolio-Solucion'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'assertions' stamp: 'Ciro 5/30/2021 17:35:23'!
assertCanOnlyTransferPositiveValues: aValue

	aValue < 0 ifTrue: [self error: self canOnlyTransferPositiveValuesErrorDescription ]! !

!Transference class methodsFor: 'assertions' stamp: 'Ciro 5/30/2021 17:42:16'!
assertCanTransferFrom: senderReceptiveAccount to: receiverReceptiveAccount.	

	senderReceptiveAccount = receiverReceptiveAccount ifTrue: [self error: self canNotTransferBetweenTheSameReceptiveAccountErrorDescription ]! !


!Transference class methodsFor: 'error description' stamp: 'Ciro 5/30/2021 17:39:09'!
canNotTransferBetweenTheSameReceptiveAccountErrorDescription

	^ 'Can Not Transfer Between The Same ReceptiveAccount'! !

!Transference class methodsFor: 'error description' stamp: 'Ciro 5/30/2021 17:32:00'!
canOnlyTransferPositiveValuesErrorDescription

	^ 'Can Only Transfer Positive Values'! !


!Transference class methodsFor: 'instance creation' stamp: 'Ciro 5/30/2021 17:41:51'!
from: senderAccount to: receivingAccount withValue: aValue

	self assertCanOnlyTransferPositiveValues: aValue.

	self assertCanTransferFrom: senderAccount to: receivingAccount.	

	^ self new initializeWithSender: senderAccount andReceiver: receivingAccount withValue: aValue! !
