!classDefinition: #AccountSummaryTest category: 'Portfolio-Solucion'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: 'oneTab twoTabs threeTabs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryTest methodsFor: 'account summary test' stamp: 'Fs 11/16/2020 14:45:35'!
test01EmptyReceptiveAccountReportsZeroBalanceSummary
	
	| account summary |
	
	account _ ReceptiveAccount new.
	summary _ AccountSummary for: account.
	
	self assert: summary report last equals: (self balaceStringFor: 0)
	! !

!AccountSummaryTest methodsFor: 'account summary test' stamp: 'Fs 11/16/2020 14:45:24'!
test02ReceptiveAccountReportsDepositSummary
	
	| account summary |
	
	account _ ReceptiveAccount new.
	Deposit register: 500 on: account. 
	summary _ AccountSummary for: account.
	
	self assert: summary report first equals: (self depositStringFor: 500).
	self assert: summary report last equals: (self balaceStringFor: 500)! !

!AccountSummaryTest methodsFor: 'account summary test' stamp: 'Fs 11/16/2020 14:44:53'!
test03ReceptiveAccountReportsTransferOperations
	
	| srcAccount summary dstAccount |
	
	srcAccount _ ReceptiveAccount new.
	Deposit register: 500 on: srcAccount. 
	Withdraw register: 100 on: srcAccount. 
	dstAccount _ ReceptiveAccount new.
	
	Transference from: dstAccount to: srcAccount  registerWithValue: 500.
	Transference from: srcAccount to: dstAccount  registerWithValue: 500.
	  
	summary _ AccountSummary for: srcAccount.
	
	self assert: summary report first equals: (self depositStringFor: 500).
	self assert: summary report second equals: (self withdrawStringFor: 100).
	self assert: summary report third equals: (self incomeTransferStringFor: 500).
	self assert: summary report fourth equals: (self exitTransferStringFor: 500).
	self assert: summary report fifth equals: (self balaceStringFor: 400).! !

!AccountSummaryTest methodsFor: 'account summary test' stamp: 'Fs 11/16/2020 14:43:47'!
test04PortfolioReportsTransferOperations
	
	| account portfolio summary dstAccount |
	
	account _ ReceptiveAccount new.
	dstAccount _ ReceptiveAccount new.
	Deposit register: 500 on: account. 
	Withdraw register: 100 on: account. 
	
	Transference from: account to: dstAccount  registerWithValue: 500.
	Transference from: dstAccount to: account  registerWithValue: 500.

	portfolio _ Portfolio new.
	portfolio add: account.
	
	summary _ AccountSummary for: portfolio.
	
	self assert: summary report first equals: (self depositStringFor: 500).
	self assert: summary report second equals: (self withdrawStringFor: 100).
	self assert: summary report third equals: (self exitTransferStringFor: 500).
	self assert: summary report fourth equals: (self incomeTransferStringFor: 500).
	self assert: summary report fifth equals: (self balaceStringFor: 400)	! !


!AccountSummaryTest methodsFor: 'transfer net test' stamp: 'HG 11/15/2020 17:56:11'!
test05EmptyAccountReportsZeroTransferNet
	
	| srcAccount summary |
	
	srcAccount _ ReceptiveAccount new.
	summary _ TransferNetSummary for: srcAccount.
	
	self assert: summary report equals: 0.! !

!AccountSummaryTest methodsFor: 'transfer net test' stamp: 'HG 11/15/2020 18:01:06'!
test06AccountReportsOneTransferenceValueAsTransferNetSummary
	
	| srcAccount summary dstAccount |
	
	srcAccount _ ReceptiveAccount new.
	dstAccount _ ReceptiveAccount new.
	
	Transference from: srcAccount to: dstAccount  registerWithValue: 400.
	Transference from: dstAccount to: srcAccount  registerWithValue: 500.
	
	summary _ TransferNetSummary for: srcAccount.
	
	self assert: summary report equals: 100.! !

!AccountSummaryTest methodsFor: 'transfer net test' stamp: 'HG 11/15/2020 18:01:39'!
test07AccountReportsMultipleTransferencesBalanceAsTransferNetSummary
	
	| srcAccount summary dstAccount |
	
	srcAccount _ ReceptiveAccount new.
	dstAccount _ ReceptiveAccount new.
	
	Transference from: srcAccount to: dstAccount  registerWithValue: 400.
	Transference from: srcAccount to: dstAccount  registerWithValue: 400.
	Transference from: dstAccount to: srcAccount  registerWithValue: 500.
	
	summary _ TransferNetSummary for: srcAccount.
	
	self assert: summary report equals: -300.! !

!AccountSummaryTest methodsFor: 'transfer net test' stamp: 'HG 11/15/2020 18:02:02'!
test08PortfolioReportsTransferencesBalanceAsTransferNetSummary
	
	| srcAccount summary dstAccount portfolio |
	
	srcAccount _ ReceptiveAccount new.
	dstAccount _ ReceptiveAccount new.
	
	Transference from: srcAccount to: dstAccount  registerWithValue: 400.
	Transference from: srcAccount to: dstAccount  registerWithValue: 400.
	Transference from: dstAccount to: srcAccount  registerWithValue: 500.
	
	portfolio _ Portfolio new.
	portfolio add: srcAccount. 
	
	summary _ TransferNetSummary for: portfolio.
	
	self assert: summary report equals: -300.! !


!AccountSummaryTest methodsFor: 'setup' stamp: 'Fs 11/16/2020 14:30:13'!
setUp

	oneTab _ String tab.
	twoTabs _ oneTab, String tab.
	threeTabs _ twoTabs, String tab.
! !


!AccountSummaryTest methodsFor: 'portfolio tree test' stamp: 'HG 11/15/2020 18:03:55'!
test09EmptyPortfolioReportsItsNameAsPortfolioTree
	
	| portfolio summary portfolioName |
	
	portfolioName _ 'Portfolio vacío'.
	portfolio _ Portfolio named: portfolioName.
	summary _ PorfolioTreeSummary for: portfolio.
	
	self assert: summary report first equals: portfolioName.! !

!AccountSummaryTest methodsFor: 'portfolio tree test' stamp: 'HG 11/15/2020 18:04:22'!
test10PortfolioWithAccountReportsHierarchyCorrectly
	
	| portfolio summary portfolioName account accountName |
	
	portfolioName _ 'Portfolio principal'.
	accountName _ 'Cuenta de prueba'.
	account _ ReceptiveAccount named: accountName.
	portfolio _ Portfolio named: portfolioName.
	portfolio add: account.
	
	summary _ PorfolioTreeSummary for: portfolio.
	
	self assert: summary report first equals: portfolioName.	
	self assert: summary report second equals: (oneTab,accountName).! !

!AccountSummaryTest methodsFor: 'portfolio tree test' stamp: 'HG 11/15/2020 18:04:57'!
test11MultipleLevelChildPortfolioReturnsHierarchyCorrectly
	
	| portfolio summary portfolioName account accountName childPortfolioName portfolioChild childAccount |
	
	portfolioName _ 'Portfolio principal'.
	accountName _ 'Cuenta de prueba'.
	childPortfolioName _ 'Portfolio hijo'.
	account _ ReceptiveAccount named: accountName.
	childAccount _ ReceptiveAccount named: accountName.
	portfolio _ Portfolio named: portfolioName.
	portfolioChild _ Portfolio named: childPortfolioName. 
	portfolioChild add: childAccount.
	portfolio add: account.
	portfolio add: portfolioChild.
	
	summary _ PorfolioTreeSummary for: portfolio.
	
	self assert: summary report first equals: portfolioName.	
	self assert: summary report second equals: (oneTab,accountName).
	self assert: summary report third equals: (oneTab,childPortfolioName).
	self assert: summary report fourth equals: (twoTabs,accountName).
! !

!AccountSummaryTest methodsFor: 'portfolio tree test' stamp: 'HG 11/15/2020 18:38:27'!
test12ReceptiveAccountCantReportAPortfolioTreeSummary
	
	| account accountName summary |
	accountName _ 'Cuenta de prueba'.
	account _ ReceptiveAccount named: accountName.
	
	summary _ PorfolioTreeSummary for: account.
	
	self
		should: [ summary report ]
		raise: Error
		withMessageText: ReceptiveAccount receptiveAccountCantReportPortfolioTreeErrorDescription.
! !

!AccountSummaryTest methodsFor: 'portfolio tree test' stamp: 'Fs 11/16/2020 14:41:53'!
test13DetailedTreeReportsCorrectlyOnDiversePortfolio
	
	| anAccount anAccountName anotherAccount anotherAccountName childPortfolioName portfolio portfolioChild portfolioName  summary actualSummaryReport expectedReport |
	
	portfolioName _ 'Portfolio principal'.
	childPortfolioName _ 'Un portfolio hijo'.
	anAccountName _ 'Una cuenta de prueba'.
	anotherAccountName _ 'Otra cuenta de prueba'.

	anAccount _ ReceptiveAccount named: anAccountName.
	anotherAccount _ ReceptiveAccount named: anotherAccountName.
	portfolio _ Portfolio named: portfolioName.
	portfolioChild _ Portfolio named: childPortfolioName. 
	
	portfolio add: anAccount .
	portfolioChild add: anotherAccount.
	portfolio add: portfolioChild.

	Deposit register: 1000 on: anAccount.
	Withdraw register: 200 on: anAccount.
	Transference from: anotherAccount to:  anAccount registerWithValue: 50.
	Transference from: anAccount to:  anotherAccount registerWithValue: 20.
	
	summary _ DetailedTreeSummary for: portfolio.
	
	expectedReport _ OrderedCollection new.
	expectedReport add: portfolioName ;
				add: (oneTab,anAccountName);
				add: (twoTabs, (self depositStringFor: 1000) );
				add: (twoTabs, (self withdrawStringFor: 200));
				add: (twoTabs, (self incomeTransferStringFor: 50));
				add: (twoTabs, (self exitTransferStringFor: 20));
				add: (twoTabs, (self balaceStringFor: 830));
				add: (oneTab,childPortfolioName);
				add: (twoTabs,anotherAccountName );
				add: (threeTabs, (self exitTransferStringFor: 50));
				add: (threeTabs, (self incomeTransferStringFor: 20));
				add: (threeTabs, (self balaceStringFor: -30));
				add: (twoTabs, (self balaceStringFor: -30));
				add: (oneTab, (self balaceStringFor: 800)).
	actualSummaryReport _ summary report.
	
	self assert: expectedReport equals: actualSummaryReport.
! !

!AccountSummaryTest methodsFor: 'portfolio tree test' stamp: 'Fs 11/16/2020 03:30:00'!
test14ReceptiveAccountCantReportADetailedTreeSummary
	
	| account accountName summary |
	accountName _ 'Cuenta de prueba'.
	account _ ReceptiveAccount named: accountName.
	
	summary _ DetailedTreeSummary for: account.
	
	self
		should: [ summary report ]
		raise: Error
		withMessageText: ReceptiveAccount receptiveAccountCantReportPortfolioTreeErrorDescription.
! !


!AccountSummaryTest methodsFor: 'summary strings -- private' stamp: 'Fs 11/16/2020 14:36:41'!
balaceStringFor: aValue
	^'Balance = ' , (aValue asString).! !

!AccountSummaryTest methodsFor: 'summary strings -- private' stamp: 'Fs 11/16/2020 14:39:07'!
depositStringFor: aValue
	^'Depósito por ' , (aValue asString).! !

!AccountSummaryTest methodsFor: 'summary strings -- private' stamp: 'Fs 11/16/2020 14:40:06'!
exitTransferStringFor: aValue
	^'Salida por transferencia de ', (aValue asString).! !

!AccountSummaryTest methodsFor: 'summary strings -- private' stamp: 'Fs 11/16/2020 14:40:09'!
incomeTransferStringFor: aValue
	^'Entrada por transferencia de ', (aValue asString).! !

!AccountSummaryTest methodsFor: 'summary strings -- private' stamp: 'Fs 11/16/2020 14:38:25'!
withdrawStringFor: aValue
	^'Extracción por ', (aValue asString).! !


!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

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


!classDefinition: #TransferenceTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferenceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceTest methodsFor: 'tests' stamp: 'HG 11/14/2020 09:51:41'!
test01EmptyReceptiveAccountReportsZeroBalanceSummary
	| destinationAccount sourceAccount |
	sourceAccount _ ReceptiveAccount new.
	Deposit register: 100 on: sourceAccount .
	
	destinationAccount _ ReceptiveAccount new.
	
	Transference from: sourceAccount  to: destinationAccount registerWithValue: 60.
	
	self assert: sourceAccount balance equals: 40.
	self assert: destinationAccount balance equals: 60.
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'HG 11/15/2020 17:54:28'!
test02ReceptiveAccountReportsDepositSummary
	| destinationAccount sourceAccount |
	sourceAccount _ ReceptiveAccount new.
	Deposit register: 100 on: sourceAccount .
	
	destinationAccount _ ReceptiveAccount new.
	
	self should:[Transference from: sourceAccount  to: destinationAccount registerWithValue: -10] 
		raise:Error
		withMessageText: (Transference cannotTransferNegativeMoneyErrorDescription).
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'HG 11/15/2020 17:55:00'!
test03ReceptiveAccountReportsTransferOperations
	| anAccount |
	anAccount _ ReceptiveAccount new.
	Deposit register: 100 on: anAccount .
		
	self should:[Transference from: anAccount to:  anAccount registerWithValue: 100]
		raise:Error
		withMessageText: Transference cannotTransferFromAccountToSameAccount.! !

!TransferenceTest methodsFor: 'tests' stamp: 'HG 11/15/2020 17:55:19'!
test04PortfolioReportsTransferOperations
	| srcAccount dstAccount transference |
	srcAccount _ ReceptiveAccount new.
	dstAccount _ ReceptiveAccount new.
	
	transference _ Transference from: srcAccount to: dstAccount registerWithValue: 100. 
	
	self assert: srcAccount transactions includes: transference withdrawOperation.
	self assert: dstAccount transactions includes: transference depositOperation.! !

!TransferenceTest methodsFor: 'tests' stamp: 'HG 11/15/2020 17:56:11'!
test05EmptyAccountReportsZeroTransferNet

	| srcAccount dstAccount transference |
	srcAccount _ ReceptiveAccount new.
	dstAccount _ ReceptiveAccount new.
	
	transference _ Transference from: srcAccount to: dstAccount registerWithValue: 100. 
	
	self assert: srcAccount transactions first transferenceFrom equals: transference.
	self assert: dstAccount transactions first transferenceFrom equals: transference.
	self assert: transference value equals: 100.! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
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


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

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


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'HG 11/15/2020 16:27:06'!
initializeWithName: aName 
	name := aName.! !


!Portfolio methodsFor: 'exceptions' stamp: 'HG 11/6/2020 19:31:25'!
signalCantAddAlreadyAddedAsset
	^self error: self class alreadyAddedAssetErrorDescription. ! !


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


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


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


!Portfolio methodsFor: 'summary -- private' stamp: 'Fs 11/16/2020 14:07:15'!
reportDetailedTreeSummaryTo: aDetailedTreeSummary 
	^self reportDetailedTreeSummaryTo: aDetailedTreeSummary fromHeight: 0   .
	! !

!Portfolio methodsFor: 'summary -- private' stamp: 'Fs 11/16/2020 14:49:04'!
reportDetailedTreeSummaryTo: aDetailedTreeSummary fromHeight: aTreeHeight

	| nextHeight reportingBlock |
	nextHeight _ aTreeHeight +1.
	reportingBlock _ [:anAccount | anAccount reportDetailedTreeSummaryTo: aDetailedTreeSummary fromHeight: nextHeight. 	].
	
	self reportMyNameTo:  aDetailedTreeSummary fromHeight: aTreeHeight   andWithAccountsDo: reportingBlock.
	aDetailedTreeSummary reportBalance: self balance fromHeight: nextHeight.
	! !

!Portfolio methodsFor: 'summary -- private' stamp: 'Fs 11/16/2020 14:07:07'!
reportMyNameTo: aTextSummary fromHeight: aTreeHeight andWithAccountsDo: aBlockToDoOnAccounts
	
	aTextSummary reportName: name fromHeight: aTreeHeight. 
	accounts do: 		aBlockToDoOnAccounts . 
	.
	! !

!Portfolio methodsFor: 'summary -- private' stamp: 'Fs 11/16/2020 04:56:16'!
reportTransactionsTo: anAccountSummary 
	accounts do: [:anAccount | anAccount reportTransactionsTo: anAccountSummary. ] . ! !

!Portfolio methodsFor: 'summary -- private' stamp: 'Fs 11/16/2020 05:23:11'!
reportTreeSummaryTo: aPorfolioTreeSummary 
	self reportTreeSummaryTo: aPorfolioTreeSummary fromHeight:  0   .
	! !

!Portfolio methodsFor: 'summary -- private' stamp: 'Fs 11/16/2020 14:10:27'!
reportTreeSummaryTo: aPorfolioTreeSummary fromHeight: aTreeHeight
	
	|  reportingBlock |
	reportingBlock _ [:anAccount | anAccount reportTreeSummaryTo: aPorfolioTreeSummary fromHeight: aTreeHeight +1. ] .
	
	self reportMyNameTo: aPorfolioTreeSummary fromHeight: aTreeHeight andWithAccountsDo: reportingBlock
 
	.
	! !


!Portfolio methodsFor: 'accesing' stamp: 'HG 11/15/2020 17:06:13'!
name
	^name.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error description' stamp: 'HG 11/6/2020 19:29:34'!
alreadyAddedAssetErrorDescription
	^'You cant add an already added asset.'.! !


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


!Portfolio class methodsFor: 'instance creation' stamp: 'HG 11/15/2020 16:26:46'!
named: aName 
	^self new initializeWithName: aName.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HG 11/15/2020 17:04:09'!
initializeNamed: aName 
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


!ReceptiveAccount methodsFor: 'accesing' stamp: 'HG 11/15/2020 17:06:20'!
name
	^name.! !


!ReceptiveAccount methodsFor: 'adding -- private' stamp: 'Fs 11/9/2020 01:53:41'!
addParentPortfolio: aPortfolioWhoAddTheAsset
	^nil.! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'summary -- private' stamp: 'Fs 11/16/2020 03:29:36'!
reportDetailedTreeSummaryTo: aPorfolioTreeSummary 
	^self signalCantGeneratePortfolioTreeSummaryFromAccount.
	! !

!ReceptiveAccount methodsFor: 'summary -- private' stamp: 'Fs 11/16/2020 14:48:19'!
reportDetailedTreeSummaryTo: aPorfolioTreeSummary fromHeight: aTreeHeight
	
	|   nextTreeHeight |
	
	aPorfolioTreeSummary reportName: name fromHeight: aTreeHeight.
	
	nextTreeHeight _   aTreeHeight + 1.
	aPorfolioTreeSummary addReportOf: self fromHeight: nextTreeHeight.

	
	! !

!ReceptiveAccount methodsFor: 'summary -- private' stamp: 'Fs 11/16/2020 04:31:17'!
reportTransactionsTo: anAccountSummary 
	transactions do: [:aTransaction | aTransaction reportMeIn: anAccountSummary.].! !

!ReceptiveAccount methodsFor: 'summary -- private' stamp: 'HG 11/15/2020 18:28:34'!
reportTreeSummaryTo: aPorfolioTreeSummary 
	^self signalCantGeneratePortfolioTreeSummaryFromAccount.
	! !

!ReceptiveAccount methodsFor: 'summary -- private' stamp: 'Fs 11/16/2020 05:18:57'!
reportTreeSummaryTo: aPorfolioTreeSummary fromHeight: aTreeHeight
	
	aPorfolioTreeSummary reportName: name fromHeight: aTreeHeight.
	! !


!ReceptiveAccount methodsFor: 'exceptions' stamp: 'HG 11/15/2020 18:37:19'!
signalCantGeneratePortfolioTreeSummaryFromAccount
	^self error: self class receptiveAccountCantReportPortfolioTreeErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'HG 11/15/2020 17:03:55'!
named: aName
	^self new initializeNamed: aName ! !


!ReceptiveAccount class methodsFor: 'error description' stamp: 'HG 11/15/2020 18:37:50'!
receptiveAccountCantReportPortfolioTreeErrorDescription
	^'A Receptive Account cant generate a PortfolioTree report.'.! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'summary' stamp: 'Fs 11/16/2020 04:31:17'!
reportMeIn: anAccountSummary
	self subclassResponsibility. ! !

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


!Deposit methodsFor: 'summary' stamp: 'Fs 11/16/2020 04:31:17'!
reportMeIn: aSummary
	^aSummary reportAsDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferTransaction category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferTransaction
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTransaction methodsFor: 'value' stamp: 'HG 11/12/2020 21:46:33'!
value
	^transference value.! !


!TransferTransaction methodsFor: 'balance' stamp: 'HG 11/12/2020 21:45:46'!
affectBalance: aBalance
	self subclassResponsibility. ! !


!TransferTransaction methodsFor: 'accesing' stamp: 'HG 11/12/2020 21:50:22'!
transferenceFrom
	^transference. ! !


!TransferTransaction methodsFor: 'initialization' stamp: 'HG 11/12/2020 21:50:50'!
initializeFor: aTransference 
	transference := aTransference.! !


!TransferTransaction methodsFor: 'summary' stamp: 'Fs 11/16/2020 04:31:17'!
reportMeIn: aSummary
	self subclassResponsibility. ! !


!classDefinition: #DepositOfTransference category: 'Portfolio-Solucion'!
TransferTransaction subclass: #DepositOfTransference
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!DepositOfTransference methodsFor: 'balance' stamp: 'HG 11/12/2020 21:47:16'!
affectBalance: aBalance
	^aBalance + self value.! !


!DepositOfTransference methodsFor: 'summary' stamp: 'Fs 11/16/2020 04:31:17'!
reportMeIn: aSummary
	^aSummary reportAsDepositTransference: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DepositOfTransference class' category: 'Portfolio-Solucion'!
DepositOfTransference class
	instanceVariableNames: ''!

!DepositOfTransference class methodsFor: 'instance creation' stamp: 'HG 11/12/2020 21:48:51'!
for: aTransference 
	^self new initializeFor: aTransference ! !


!classDefinition: #WithdrawOfTransference category: 'Portfolio-Solucion'!
TransferTransaction subclass: #WithdrawOfTransference
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WithdrawOfTransference methodsFor: 'balance' stamp: 'HG 11/12/2020 21:47:25'!
affectBalance: aBalance
	^aBalance - self value.! !


!WithdrawOfTransference methodsFor: 'summary' stamp: 'Fs 11/16/2020 04:31:17'!
reportMeIn: aSummary
	^aSummary reportAsWithdrawTransference: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WithdrawOfTransference class' category: 'Portfolio-Solucion'!
WithdrawOfTransference class
	instanceVariableNames: ''!

!WithdrawOfTransference class methodsFor: 'instance creation' stamp: 'HG 11/12/2020 21:49:18'!
for: aTransference 
	^self new initializeFor: aTransference ! !


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


!Withdraw methodsFor: 'summary' stamp: 'Fs 11/16/2020 04:31:17'!
reportMeIn: aSummary
	^aSummary reportAsWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Summary category: 'Portfolio-Solucion'!
Object subclass: #Summary
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Summary class' category: 'Portfolio-Solucion'!
Summary class
	instanceVariableNames: ''!

!Summary class methodsFor: 'instance creation' stamp: 'HG 11/13/2020 18:34:09'!
for: anAccount 
	^self new initializeFor: anAccount ! !


!classDefinition: #BalanceSummary category: 'Portfolio-Solucion'!
Summary subclass: #BalanceSummary
	instanceVariableNames: 'calculatedBalance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!BalanceSummary methodsFor: 'initialization' stamp: 'Fs 11/16/2020 04:39:29'!
initializeFor: anAccount
	account _ anAccount.
	calculatedBalance _ 0! !


!classDefinition: #TransferNetSummary category: 'Portfolio-Solucion'!
BalanceSummary subclass: #TransferNetSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetSummary methodsFor: 'summary' stamp: 'Fs 11/16/2020 14:14:37'!
report
	
	account reportTransactionsTo: self.
	^ calculatedBalance 
	! !


!TransferNetSummary methodsFor: 'balance reporting -- private' stamp: 'Fs 11/16/2020 04:45:27'!
reportAsDeposit: aDepositToReport
! !

!TransferNetSummary methodsFor: 'balance reporting -- private' stamp: 'Fs 11/16/2020 04:45:49'!
reportAsDepositTransference: aDepositTransferenceToReport
	calculatedBalance _ calculatedBalance +aDepositTransferenceToReport value.! !

!TransferNetSummary methodsFor: 'balance reporting -- private' stamp: 'Fs 11/16/2020 04:45:32'!
reportAsWithdraw: aWithdrawToReport
	 ! !

!TransferNetSummary methodsFor: 'balance reporting -- private' stamp: 'Fs 11/16/2020 04:45:41'!
reportAsWithdrawTransference: aWithdrawTransferenceToReport
	calculatedBalance _ calculatedBalance + aWithdrawTransferenceToReport value negated.! !


!classDefinition: #TextSummary category: 'Portfolio-Solucion'!
Summary subclass: #TextSummary
	instanceVariableNames: 'generatedReport'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TextSummary methodsFor: 'initialization' stamp: 'Fs 11/16/2020 04:39:53'!
initializeFor: anAccount
	account _ anAccount .
	generatedReport _ OrderedCollection new.! !


!TextSummary methodsFor: 'text reporting -- private' stamp: 'Fs 11/16/2020 05:29:11'!
reportName: anAccountName fromHeight: aTreeHeight
	| aTabString |
	aTabString _ self calculateIndentationForHeight: aTreeHeight.
	
	generatedReport add: (aTabString , anAccountName).! !


!TextSummary methodsFor: 'indentation -- private' stamp: 'Fs 11/16/2020 05:31:15'!
calculateIndentationForHeight: aTreeHeight
	| indentation |
	indentation _ '' .
	aTreeHeight timesRepeat: [indentation _(String tab, indentation)].
	^indentation
	
	! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
TextSummary subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'summary' stamp: 'Fs 11/16/2020 14:14:47'!
report
	 
	self reportTransactions. 
	self addBalanceToReport.
	^generatedReport .! !


!AccountSummary methodsFor: 'text reporting -- private' stamp: 'Fs 11/16/2020 04:41:25'!
addBalanceToReport

	 generatedReport add: ('Balance = ', account balance asString)! !

!AccountSummary methodsFor: 'text reporting -- private' stamp: 'Fs 11/16/2020 04:38:09'!
reportAsDeposit: aDepositToReport
	generatedReport add: 'Depósito por ', aDepositToReport value asString.! !

!AccountSummary methodsFor: 'text reporting -- private' stamp: 'Fs 11/16/2020 04:38:11'!
reportAsDepositTransference: aDepositTransferenceToReport
	generatedReport add:'Entrada por transferencia de ', aDepositTransferenceToReport value asString.! !

!AccountSummary methodsFor: 'text reporting -- private' stamp: 'Fs 11/16/2020 04:38:13'!
reportAsWithdraw: aWithdrawToReport
	generatedReport add:'Extracción por ', aWithdrawToReport value asString.! !

!AccountSummary methodsFor: 'text reporting -- private' stamp: 'Fs 11/16/2020 04:38:16'!
reportAsWithdrawTransference: aWithdrawTransferenceToReport
	generatedReport add: 'Salida por transferencia de ', aWithdrawTransferenceToReport value asString.! !

!AccountSummary methodsFor: 'text reporting -- private' stamp: 'Fs 11/16/2020 04:27:52'!
reportTransactions
	account reportTransactionsTo: self.	
	 ! !


!classDefinition: #DetailedTreeSummary category: 'Portfolio-Solucion'!
TextSummary subclass: #DetailedTreeSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!DetailedTreeSummary methodsFor: 'summary' stamp: 'Fs 11/16/2020 14:25:00'!
report
	account reportDetailedTreeSummaryTo: self.
	^generatedReport ! !


!DetailedTreeSummary methodsFor: 'text reporting -- private' stamp: 'Fs 11/16/2020 05:27:20'!
addReportOf: aReceptiveAccount fromHeight: aTreeHeight
	| aReceptiveAccountReport aStringTab |
	aReceptiveAccountReport _  (AccountSummary for: aReceptiveAccount) report.
	
	aStringTab _ self calculateIndentationForHeight: aTreeHeight .
	aReceptiveAccountReport do: [ :aReportLine |   generatedReport add: (aStringTab, aReportLine)].
! !

!DetailedTreeSummary methodsFor: 'text reporting -- private' stamp: 'Fs 11/16/2020 05:27:47'!
reportBalance: aBalanceToReport fromHeight: aTreeHeight
	
	| aStringTab |
	aStringTab _ self calculateIndentationForHeight: aTreeHeight .
	generatedReport add: (aStringTab, 'Balance = ', aBalanceToReport asString).! !


!classDefinition: #PorfolioTreeSummary category: 'Portfolio-Solucion'!
TextSummary subclass: #PorfolioTreeSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PorfolioTreeSummary methodsFor: 'summary' stamp: 'Fs 11/16/2020 14:14:56'!
report

	account reportTreeSummaryTo: self.
	^generatedReport ! !


!classDefinition: #Transference category: 'Portfolio-Solucion'!
Object subclass: #Transference
	instanceVariableNames: 'deposit withdraw value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transference methodsFor: 'assertions' stamp: 'HG 11/12/2020 21:54:37'!
assertAnAccount: aDestinationAccount isDifferentTo: aSourceAccount

	^ aSourceAccount = aDestinationAccount 
		ifTrue:[self error: self class cannotTransferFromAccountToSameAccount ]! !

!Transference methodsFor: 'assertions' stamp: 'HG 11/12/2020 21:53:25'!
assertPositiveTransferenceValue: aTransferenceValue

	^ aTransferenceValue <= 0 
		ifTrue:[self error: self class cannotTransferNegativeMoneyErrorDescription ]! !


!Transference methodsFor: 'initialization' stamp: 'HG 11/12/2020 21:54:37'!
initializeFrom: aSourceAccount to: aDestinationAccount withValue: aTransferenceValue 
	
	self assertPositiveTransferenceValue: aTransferenceValue.
	self assertAnAccount: aDestinationAccount isDifferentTo: aSourceAccount.

	deposit _ DepositOfTransference register: self on: aDestinationAccount.
	withdraw _ WithdrawOfTransference register: self on: aSourceAccount.
	value _ aTransferenceValue. 
	 ! !


!Transference methodsFor: 'accessing' stamp: 'HG 11/12/2020 21:34:31'!
depositOperation
	^deposit.! !

!Transference methodsFor: 'accessing' stamp: 'HG 11/12/2020 21:51:31'!
value
	^value. ! !

!Transference methodsFor: 'accessing' stamp: 'HG 11/12/2020 21:35:53'!
withdrawOperation
	^withdraw.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: 'Portfolio-Solucion'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'instance creation' stamp: 'Fs 11/9/2020 19:43:46'!
from: aSourceAccount to: aDestinationAccount registerWithValue: aTransferenceValue

	^self new initializeFrom: aSourceAccount to: aDestinationAccount withValue: aTransferenceValue ! !


!Transference class methodsFor: 'error handling' stamp: 'Fs 11/9/2020 19:42:46'!
error: aString 
	self shouldBeImplemented.! !


!Transference class methodsFor: 'error description' stamp: 'Fs 11/9/2020 20:10:14'!
cannotTransferFromAccountToSameAccount
	^'You cannot make a transfer from an account to the same account'! !

!Transference class methodsFor: 'error description' stamp: 'Fs 11/9/2020 20:05:29'!
cannotTransferNegativeMoneyErrorDescription
	^'You cannot transfer negative money!!'! !
