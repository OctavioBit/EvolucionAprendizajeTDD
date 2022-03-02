!classDefinition: #PortfolioExerciseTests category: #'Portfolio2-Solucion'!
TestCase subclass: #PortfolioExerciseTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!


!classDefinition: #AccountReportsTest category: #'Portfolio2-Solucion'!
PortfolioExerciseTests subclass: #AccountReportsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!AccountReportsTest methodsFor: 'account summary' stamp: 'FG 11/15/2020 14:41:04'!
test01AnAccountSummaryOfANewAccountShouldOnlyBeHisBalance

	| report receptiveAccount |
	
	receptiveAccount := ReceptiveAccount new.
	report := OrderedCollection new.
	report add: 'Balance = 0'.
	
	self assert: (AccountSummary of: receptiveAccount) accountSummary equals: report. 
	
	 ! !

!AccountReportsTest methodsFor: 'account summary' stamp: 'FG 11/15/2020 14:41:11'!
test02AnAccountSummaryShouldDisplayDeposits

	| report receptiveAccount |
	
	receptiveAccount := ReceptiveAccount new.
	Deposit register: 100 on: receptiveAccount.
	
	report := OrderedCollection new.
	report add: 'Depósito por 100'.
	report add: 'Balance = 100'.
	
	self assert: (AccountSummary of: receptiveAccount) accountSummary equals: report. 
	
	 ! !

!AccountReportsTest methodsFor: 'account summary' stamp: 'FG 11/15/2020 14:41:17'!
test03AnAccountSummaryShouldDisplayWithdraws

	| report receptiveAccount |
	
	receptiveAccount := ReceptiveAccount new.
	Withdraw register: 100 on: receptiveAccount.
	
	report := OrderedCollection new.
	report add: 'Extracción por 100'.
	report add: 'Balance = -100'.
	
	self assert: (AccountSummary of: receptiveAccount) accountSummary equals: report. 
	
	 ! !

!AccountReportsTest methodsFor: 'account summary' stamp: 'FG 11/15/2020 14:41:27'!
test04ATransferenceShouldBeDisplayedInBothParticipantsAccountSummaries

	| reportSender reportReceiver receptiveAccountSender receptiveAccountReceiver |
	
	receptiveAccountSender := ReceptiveAccount new.
	receptiveAccountReceiver := ReceptiveAccount new.
	Transference register: 100 from: receptiveAccountSender  to: receptiveAccountReceiver.
	
	reportSender := OrderedCollection new.
	reportSender add: 'Salida por transferencia de 100'.
	reportSender add: 'Balance = -100'.
	
	reportReceiver := OrderedCollection new.
	reportReceiver add: 'Entrada por transferencia de 100'.
	reportReceiver add: 'Balance = 100'.
	
		
	self assert: (AccountSummary of: receptiveAccountSender) accountSummary equals: reportSender.
	self assert: (AccountSummary of: receptiveAccountReceiver) accountSummary equals: reportReceiver.
	 
	
	 ! !


!AccountReportsTest methodsFor: 'transference net value' stamp: 'FG 11/15/2020 14:41:36'!
test05ATransferenceShouldAffectTransferenceNetValueReportForBothAccounts

	| receptiveAccountSender receptiveAccountReceiver |
	
	receptiveAccountSender := ReceptiveAccount new.
	receptiveAccountReceiver := ReceptiveAccount new.
	
	Transference register: 100 from: receptiveAccountSender  to: receptiveAccountReceiver.
	
	self assert: (TransferenceNetValue of: receptiveAccountReceiver) transferenceNetValueReport equals: 100.
	self assert: (TransferenceNetValue of: receptiveAccountSender) transferenceNetValueReport equals: -100.
	 
	
	 ! !

!AccountReportsTest methodsFor: 'transference net value' stamp: 'FG 11/15/2020 14:41:46'!
test06ANonTransferenceTransactionShouldNotAffectTransferenceNetValueReport

	| receptiveAccountWithDeposit receptiveAccountWithWithdraw |
	
	receptiveAccountWithDeposit := ReceptiveAccount new.
	receptiveAccountWithWithdraw := ReceptiveAccount new.
	
	Deposit register: 100 on: receptiveAccountWithDeposit.
	Withdraw register: 50 on: receptiveAccountWithWithdraw.
	
	self assert: (TransferenceNetValue of: receptiveAccountWithDeposit ) transferenceNetValueReport equals: 0.
	self assert: (TransferenceNetValue of: receptiveAccountWithWithdraw) transferenceNetValueReport equals: 0.
	 
	
	 ! !


!AccountReportsTest methodsFor: 'tree structure with account summary' stamp: 'FG 11/15/2020 23:06:16'!
test13StructureTreeWithAccountSummaryWithAReceptiveAccountOnlyDisplayTheAccountNameAndBalance

	| receptiveAccount treeStructureReport |
	
	receptiveAccount := ReceptiveAccount named: 'Cuenta de Prueba'.
	
	treeStructureReport := OrderedCollection new.
	treeStructureReport add: 'Cuenta de Prueba'.
	treeStructureReport add: String tab , 'Balance = 0'.
	
	self assert: treeStructureReport equals: (TreeStructure of: receptiveAccount) treeStructureWithAccountSummary.! !

!AccountReportsTest methodsFor: 'tree structure with account summary' stamp: 'FG 11/15/2020 23:07:45'!
test14StructureTreeWithAccountSummaryWithAReceptiveAccountWithTransactionsProperlyDisplaysAccountNameAndAccountSummary

	| receptiveAccount treeStructureReport |
	
	receptiveAccount := ReceptiveAccount named: 'Cuenta de Prueba'.
	Deposit register: 100 on: receptiveAccount.
	Withdraw register: 50 on: receptiveAccount.
	
	
	treeStructureReport := OrderedCollection new.
	treeStructureReport add: 'Cuenta de Prueba'.
	treeStructureReport add: String tab , 'Depósito por 100'.
	treeStructureReport add: String tab , 'Extracción por 50'.
	treeStructureReport add: String tab , 'Balance = 50'.
	
	self assert: treeStructureReport equals: (TreeStructure of: receptiveAccount) treeStructureWithAccountSummary.! !

!AccountReportsTest methodsFor: 'tree structure with account summary' stamp: 'FG 11/15/2020 23:09:20'!
test15StructureTreeWithAccountSummaryWithAPortfolioProperlyDisplaysPortfolioNameAndItsReceptiveAccounts

	| receptiveAccount portfolio treeStructureReport |
	
	receptiveAccount := ReceptiveAccount named: 'Cuenta de Prueba'.
	portfolio := Portfolio named: 'Portfolio de Prueba' with: receptiveAccount.
	Deposit register: 100 on: receptiveAccount.
	
	treeStructureReport := OrderedCollection new.
	treeStructureReport add: 'Portfolio de Prueba'.
	treeStructureReport add: String tab , 'Cuenta de Prueba'.
	treeStructureReport add: String tab , String tab , 'Depósito por 100'.
	treeStructureReport add: String tab , String tab , 'Balance = 100'.
	treeStructureReport add: String tab , 'Balance = 100'.
	
	self assert: treeStructureReport equals: (TreeStructure of: portfolio) treeStructureWithAccountSummary.! !

!AccountReportsTest methodsFor: 'tree structure with account summary' stamp: 'FG 11/15/2020 23:10:10'!
test16StructureTreeWithAccountSummaryDisplaysCorrectlyMultiplePortfolios

	| receptiveAccount1 receptiveAccount2 portfolio treeStructureReport |
	
	receptiveAccount1 := ReceptiveAccount named: 'Cuenta de Prueba1'.
	receptiveAccount2 := ReceptiveAccount named: 'Cuenta de Prueba2'.
	portfolio := Portfolio named: 'Portfolio de Prueba' with: receptiveAccount1 with: receptiveAccount2 .
	Deposit register: 100 on: receptiveAccount1.
	Deposit register: 150 on: receptiveAccount2.
	
	treeStructureReport := OrderedCollection new.
	treeStructureReport add: 'Portfolio de Prueba'.
	treeStructureReport add: String tab , 'Cuenta de Prueba1'.
	treeStructureReport add: String tab , String tab , 'Depósito por 100'.
	treeStructureReport add: String tab , String tab , 'Balance = 100'.
	treeStructureReport add: String tab , 'Cuenta de Prueba2'.
	treeStructureReport add: String tab , String tab , 'Depósito por 150'.
	treeStructureReport add: String tab , String tab , 'Balance = 150'.
	treeStructureReport add: String tab , 'Balance = 250'.
	
	self assert: treeStructureReport equals: (TreeStructure of: portfolio) treeStructureWithAccountSummary.! !

!AccountReportsTest methodsFor: 'tree structure with account summary' stamp: 'FG 11/15/2020 23:11:06'!
test17StructureTreeWithAccountSummaryResolvesExercisesExample

	| familyPortfolio johnsAccount angiesAccount childrenPorfolio myAccount treeStructureReport auxiliaryAccount |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	angiesAccount := 	ReceptiveAccount  named: 'Cuenta de Angeles'.
	childrenPorfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount.
	myAccount := ReceptiveAccount named: 'Cuenta mia'.
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPorfolio.
	auxiliaryAccount := ReceptiveAccount named: 'Cuenta auxiliar'.
	
	
	Deposit register: 100 on: myAccount.
	Withdraw register: 25 on: myAccount.
	
	Deposit register: 150 on: johnsAccount.
	Withdraw register: 50 on: johnsAccount.
	
	Transference register: 100 from: angiesAccount to: auxiliaryAccount.
	
	treeStructureReport := OrderedCollection new.
	treeStructureReport add: 'Portfolio de la familia'.
	treeStructureReport add: String tab , 'Cuenta mia'.
	treeStructureReport add: String tab , String tab , 'Depósito por 100'.
	treeStructureReport add: String tab , String tab , 'Extracción por 25'.
	treeStructureReport add: String tab , String tab , 'Balance = 75'.
	treeStructureReport add: String tab , 'Portfolio de hijos'.
	treeStructureReport add: String tab , String tab , 'Cuenta de Juan'.
	treeStructureReport add: String tab , String tab , String tab , 'Depósito por 150'.
	treeStructureReport add: String tab , String tab , String tab , 'Extracción por 50'.
	treeStructureReport add: String tab , String tab , String tab , 'Balance = 100'.
	treeStructureReport add: String tab , String tab , 'Cuenta de Angeles'.
	treeStructureReport add: String tab , String tab , String tab , 'Salida por transferencia de 100'.
	treeStructureReport add: String tab , String tab , String tab , 'Balance = -100'.
	treeStructureReport add: String tab , String tab , 'Balance = 0'.
	treeStructureReport add: String tab , 'Balance = 75'.
	
	self assert: treeStructureReport equals: (TreeStructure of: familyPortfolio ) treeStructureWithAccountSummary.! !


!AccountReportsTest methodsFor: 'tree structure' stamp: 'FG 11/15/2020 22:58:19'!
test07TreeStructureOfAnAccountDisplaysOnlyTheAccountName

	| receptiveAccount treeStructureReport |
	
	receptiveAccount := ReceptiveAccount named: 'Cuenta de Prueba'.
	
	treeStructureReport := OrderedCollection new.
	treeStructureReport add: 'Cuenta de Prueba'.
	
	self assert: treeStructureReport equals: (TreeStructure of: receptiveAccount) treeStructure.! !

!AccountReportsTest methodsFor: 'tree structure' stamp: 'FG 11/15/2020 22:58:57'!
test08TreeStructureOfAnAccountWithoutNameDisplaysOnlyTheAccountDefaultName

	| receptiveAccount treeStructureReport |
	
	receptiveAccount := ReceptiveAccount new.
	
	treeStructureReport := OrderedCollection new.
	treeStructureReport add: 'Cuenta corriente sin nombre'.
	
	self assert: treeStructureReport equals: (TreeStructure of: receptiveAccount) treeStructure.! !

!AccountReportsTest methodsFor: 'tree structure' stamp: 'FG 11/15/2020 23:00:05'!
test09TreeStructureOfAPortfolioWithAReceptiveAccountIsCorrectlyDisplay

	| receptiveAccount portfolio treeStructureReport |
	
	receptiveAccount := ReceptiveAccount named: 'Cuenta de Prueba'.
	portfolio := Portfolio named: 'Portfolio de Prueba' with: receptiveAccount.
	
	treeStructureReport := OrderedCollection new.
	treeStructureReport add: 'Portfolio de Prueba'.
	treeStructureReport add: String tab , 'Cuenta de Prueba'.
		
	self assert: treeStructureReport equals: (TreeStructure of: portfolio) treeStructure.! !

!AccountReportsTest methodsFor: 'tree structure' stamp: 'FG 11/15/2020 23:04:34'!
test10TreeStructureWithAPortfolioWithAnotherPortfolioInsideIsProperlyDisplay

	| receptiveAccount portfolioParent portfolioChild treeStructureReport |
	
	receptiveAccount := ReceptiveAccount named: 'Cuenta de Prueba'.
	portfolioChild := Portfolio named: 'Portfolio hijo' with: receptiveAccount.
	portfolioParent := Portfolio named: 'Portfolio padre' with: portfolioChild.
	
	treeStructureReport := OrderedCollection new.
	treeStructureReport add: 'Portfolio padre'.
	treeStructureReport add: String tab , 'Portfolio hijo'.
	treeStructureReport add: String tab , String tab , 'Cuenta de Prueba'.
		
	self assert: treeStructureReport equals: (TreeStructure of: portfolioParent) treeStructure.! !

!AccountReportsTest methodsFor: 'tree structure' stamp: 'FG 11/15/2020 23:04:58'!
test11TreeStructureWithAPortfolioWithMultiplePortfoliosInsideIsProperlyDisplay

	| receptiveAccount1 receptiveAccount2 portfolioParent portfolioChild1 portfolioChild2 treeStructureReport |
	
	receptiveAccount1 := ReceptiveAccount named: 'Cuenta de Prueba1'.
	receptiveAccount2 := ReceptiveAccount named: 'Cuenta de Prueba2'.
	portfolioChild1 := Portfolio named: 'Portfolio hijo1' with: receptiveAccount1.
	portfolioChild2 := Portfolio named: 'Portfolio hijo2' with: receptiveAccount2.
	portfolioParent := Portfolio named: 'Portfolio padre' with: portfolioChild1 with: portfolioChild2.
	
	treeStructureReport := OrderedCollection new.
	treeStructureReport add: 'Portfolio padre'.
	treeStructureReport add: String tab , 'Portfolio hijo1'.
	treeStructureReport add: String tab , String tab , 'Cuenta de Prueba1'.
	treeStructureReport add: String tab , 'Portfolio hijo2'.
	treeStructureReport add: String tab , String tab , 'Cuenta de Prueba2'.
		
	self assert: treeStructureReport equals: (TreeStructure of: portfolioParent) treeStructure.! !

!AccountReportsTest methodsFor: 'tree structure' stamp: 'FG 11/15/2020 23:03:32'!
test12TreeStructureWithAChainOfPortfoliosIsProperlyDisplay

	| receptiveAccount portfolioGrandParent portfolioParent portfolioChild treeStructureReport |
	
	receptiveAccount := ReceptiveAccount named: 'Cuenta de Prueba'.
	portfolioChild := Portfolio named: 'Portfolio hijo' with: receptiveAccount.
	portfolioParent := Portfolio named: 'Portfolio padre' with: portfolioChild.
	portfolioGrandParent := Portfolio named: 'Portfolio abuelo' with: portfolioParent.
	
	treeStructureReport := OrderedCollection new.
	treeStructureReport add: 'Portfolio abuelo'.
	treeStructureReport add: String tab , 'Portfolio padre'.
	treeStructureReport add: String tab , String tab , 'Portfolio hijo'.
	treeStructureReport add: String tab , String tab , String tab , 'Cuenta de Prueba'.
	
	self assert: treeStructureReport equals: (TreeStructure of: portfolioGrandParent) treeStructure.! !


!classDefinition: #PortfolioTest category: #'Portfolio2-Solucion'!
PortfolioExerciseTests subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

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


!classDefinition: #ReceptiveAccountTest category: #'Portfolio2-Solucion'!
PortfolioExerciseTests subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

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


!classDefinition: #TransferenceTest category: #'Portfolio2-Solucion'!
PortfolioExerciseTests subclass: #TransferenceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!TransferenceTest methodsFor: 'auxiliary messages' stamp: 'FG 11/9/2020 21:27:42'!
should: aBlockThatShouldFail raisingAnErrorAndAsserting: aVerificationBlock

    [aBlockThatShouldFail value. self fail.]
    on: Error
    do: aVerificationBlock.! !


!TransferenceTest methodsFor: 'tests' stamp: 'FG 11/14/2020 12:48:18'!
test01TransferingBetweenTwoAccountsShouldAffectTheirBalances

	| receptiveAccountReceiver receptiveAccountSender |
	
	receptiveAccountReceiver := ReceptiveAccount new.
	receptiveAccountSender := ReceptiveAccount new.
	
	Transference register: 100 from: receptiveAccountSender to: receptiveAccountReceiver.
	
	self assert: receptiveAccountSender balance equals: -100.
	self assert: receptiveAccountReceiver balance equals: 100.! !

!TransferenceTest methodsFor: 'tests' stamp: 'FG 11/14/2020 12:46:54'!
test02CanGoFromTransferenceToTransferenceLegsAndViceVersa

	| receptiveAccountReceiver receptiveAccountSender transference |
	
	receptiveAccountReceiver := ReceptiveAccount new.
	receptiveAccountSender := ReceptiveAccount new.
	
	transference := 	Transference register: 100 from: receptiveAccountSender to: receptiveAccountReceiver.
	
	self assert: receptiveAccountReceiver transactions includes: transference transferenceDeposit.
	self assert: receptiveAccountSender transactions includes: transference transferenceWithdraw.
	
	self assert: transference equals: transference transferenceDeposit transference.
	self assert: transference equals: transference transferenceWithdraw transference.
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'FG 11/14/2020 12:47:57'!
test03CantTransferToTheSameAccount

	| receptiveAccount |
	
	receptiveAccount := ReceptiveAccount new.
	
	
	self should: [Transference register: 1  from: receptiveAccount to: receptiveAccount ] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: Transference cantTransferToTheSameAccount]
	! !

!TransferenceTest methodsFor: 'tests' stamp: 'FG 11/14/2020 12:48:37'!
test04CantTransferANonPositiveAmount

	| receptiveAccountSender receptiveAccountReceiver |
	
	receptiveAccountSender := ReceptiveAccount new.
	receptiveAccountReceiver := ReceptiveAccount new.
	
	self should: [Transference register: -100  from: receptiveAccountSender to: receptiveAccountReceiver ] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: Transference cantTransferNonPositiveAmount].
	
	self should: [Transference register: 0  from: receptiveAccountSender to: receptiveAccountReceiver ] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText equals: Transference cantTransferNonPositiveAmount]
	! !


!classDefinition: #Account category: #'Portfolio2-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!Account methodsFor: 'accounts' stamp: 'FG 11/15/2020 15:02:04'!
accounts 
	self subclassResponsibility.! !


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

!Account methodsFor: 'transactions' stamp: 'FG 11/15/2020 14:52:14'!
name
	^ name.! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'report' stamp: 'FG 11/15/2020 21:07:46'!
makeReport: aReport withHeight: aHeight
	self subclassResponsibility.! !


!classDefinition: #Portfolio category: #'Portfolio2-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'FG 11/15/2020 15:02:20'!
accounts
	^ accounts copy.! !

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


!Portfolio methodsFor: 'initialization' stamp: 'FG 11/14/2020 15:38:25'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := 'Portafolio sin nombre'.! !

!Portfolio methodsFor: 'initialization' stamp: 'FG 11/14/2020 15:54:50'!
initializeWithName: aName

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := aName.! !


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


!Portfolio methodsFor: 'reports' stamp: 'FG 11/15/2020 21:09:42'!
makeReport: aReport withHeight: aHeight

	^ aReport reportPortfolio: self inHeight: aHeight.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio2-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'NR 11/9/2020 06:01:26'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio!!'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'FG 11/14/2020 15:55:29'!
named: aName 

	^ self basicNew initializeWithName: aName! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'FG 11/14/2020 15:53:40'!
named: aName with: anAccount

	^ (self basicNew initializeWithName: aName) add: anAccount.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'FG 11/14/2020 15:55:19'!
named: aName with: anAccount with: anotherAccount

	^ ((self basicNew initializeWithName: aName) add: anAccount) add: anotherAccount.! !

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


!classDefinition: #ReceptiveAccount category: #'Portfolio2-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'FG 11/15/2020 14:50:11'!
initialize

	super initialize.
	transactions := OrderedCollection new.
	name := 'Cuenta corriente sin nombre'! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'FG 11/14/2020 15:46:52'!
initializeWith: aName

	transactions := OrderedCollection new.
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


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'report' stamp: 'FG 11/15/2020 21:11:15'!
makeReport: aReport withHeight: aHeight
	^ aReport reportReceptiveAccount: self inHeight: aHeight. ! !


!ReceptiveAccount methodsFor: 'accounts' stamp: 'FG 11/15/2020 15:02:39'!
accounts
	^ OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: #'Portfolio2-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'FG 11/14/2020 15:45:50'!
named: aName

	^ self basicNew initializeWith: aName.! !


!classDefinition: #AccountReports category: #'Portfolio2-Solucion'!
Object subclass: #AccountReports
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!AccountReports methodsFor: 'initialization' stamp: 'FG 11/15/2020 14:39:44'!
initializeWith: anAccount
	account := anAccount.! !


!AccountReports methodsFor: 'report protocols' stamp: 'FG 11/14/2020 12:02:48'!
reportDeposit: aDeposit
	self subclassResponsibility.! !

!AccountReports methodsFor: 'report protocols' stamp: 'FG 11/15/2020 21:06:18'!
reportPortfolio: aPortfolio inHeight: aHeight
	self subclassResponsibility.! !

!AccountReports methodsFor: 'report protocols' stamp: 'FG 11/15/2020 21:06:37'!
reportReceptiveAccount: aReceptiveAccount inHeight: aHeight
	self subclassResponsibility.! !

!AccountReports methodsFor: 'report protocols' stamp: 'FG 11/14/2020 12:03:50'!
reportTransferenceDeposit: aTransferenceDeposit
	self subclassResponsibility.! !

!AccountReports methodsFor: 'report protocols' stamp: 'FG 11/14/2020 12:03:32'!
reportTransferenceWithdraw: aTransfereneWithdraw
	self subclassResponsibility.! !

!AccountReports methodsFor: 'report protocols' stamp: 'FG 11/14/2020 12:03:15'!
reportWithdraw: aWithdraw
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReports class' category: #'Portfolio2-Solucion'!
AccountReports class
	instanceVariableNames: ''!

!AccountReports class methodsFor: 'initialization' stamp: 'FG 11/15/2020 14:39:57'!
of: anAccount
 	^ self new initializeWith: anAccount.
	
	! !


!classDefinition: #AccountSummary category: #'Portfolio2-Solucion'!
AccountReports subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!AccountSummary methodsFor: 'account summary' stamp: 'FG 11/15/2020 14:40:24'!
accountSummary
	
	|newAccountSummary|
	
	newAccountSummary := OrderedCollection new.
	
	account transactions do:[:aTransaction | newAccountSummary add: (aTransaction makeReport: self)].
	
	newAccountSummary add: 'Balance = ' , account balance asString.
	
	^ newAccountSummary.! !


!AccountSummary methodsFor: 'report protocols' stamp: 'FG 11/14/2020 12:02:48'!
reportDeposit: aDeposit

	^ 'Depósito por ' , aDeposit value asString.! !

!AccountSummary methodsFor: 'report protocols' stamp: 'FG 11/14/2020 12:03:50'!
reportTransferenceDeposit: aTransferenceDeposit

	^ 'Entrada por transferencia de ' , aTransferenceDeposit transference value asString.! !

!AccountSummary methodsFor: 'report protocols' stamp: 'FG 11/14/2020 12:03:32'!
reportTransferenceWithdraw: aTransferenceWithdraw

	^ 'Salida por transferencia de ' , aTransferenceWithdraw transference value asString.! !

!AccountSummary methodsFor: 'report protocols' stamp: 'FG 11/14/2020 12:03:15'!
reportWithdraw: aWithdraw

	^ 'Extracción por ' , aWithdraw value asString.! !


!classDefinition: #TransferenceNetValue category: #'Portfolio2-Solucion'!
AccountReports subclass: #TransferenceNetValue
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!TransferenceNetValue methodsFor: 'transference net value report' stamp: 'FG 11/15/2020 14:40:40'!
transferenceNetValueReport
	
	| transferenceNetValue | 
	
	transferenceNetValue := 0.
	
	account transactions do:[:aTransaction | transferenceNetValue := transferenceNetValue + (aTransaction makeReport: self) ].
	
	^ transferenceNetValue.! !


!TransferenceNetValue methodsFor: 'report protocols' stamp: 'FG 11/14/2020 12:02:48'!
reportDeposit: aDeposit
	^ 0
! !

!TransferenceNetValue methodsFor: 'report protocols' stamp: 'FG 11/14/2020 12:03:50'!
reportTransferenceDeposit: aTransferenceDeposit

	^ aTransferenceDeposit affectBalance: 0.! !

!TransferenceNetValue methodsFor: 'report protocols' stamp: 'FG 11/14/2020 12:03:32'!
reportTransferenceWithdraw: aTransferenceWithdraw

	^ aTransferenceWithdraw affectBalance: 0.! !

!TransferenceNetValue methodsFor: 'report protocols' stamp: 'FG 11/14/2020 12:03:15'!
reportWithdraw: aWithdraw
 	^ 0.
! !


!classDefinition: #TreeStructure category: #'Portfolio2-Solucion'!
AccountReports subclass: #TreeStructure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!TreeStructure methodsFor: 'tree structure with account summary' stamp: 'FG 11/15/2020 22:49:10'!
innerTreeStructureWithAccountSummaryOf: anAccount inHeight: aHeight
	
	|innerTreeStructure|
	
	innerTreeStructure := OrderedCollection new.
	
	innerTreeStructure add: (self applyingTabulationsIn: (anAccount name) basedOn: aHeight).
	
	innerTreeStructure := innerTreeStructure addAll: ( anAccount makeReport: self withHeight: aHeight );yourself.
	
	^ innerTreeStructure! !

!TreeStructure methodsFor: 'tree structure with account summary' stamp: 'FG 11/15/2020 22:40:26'!
treeStructureWithAccountSummary

	^ self innerTreeStructureWithAccountSummaryOf: account inHeight: 0.
	
	! !


!TreeStructure methodsFor: 'name adjustment' stamp: 'FG 11/15/2020 22:49:09'!
applyingTabulationsIn: aName basedOn: numberOfTabulations

	| textForTree |
	
	textForTree := aName.
	
	numberOfTabulations timesRepeat: [textForTree := String tab , textForTree].
	
	^ textForTree.
	
! !


!TreeStructure methodsFor: 'default tree structure' stamp: 'FG 11/15/2020 22:49:10'!
innerTreeStructureOf: anAccount inHeight: aHeight
	
	|innerTreeStructure|
	
	innerTreeStructure := OrderedCollection new.
	
	innerTreeStructure add: (self applyingTabulationsIn: (anAccount name) basedOn: aHeight).

	anAccount accounts do:[:innerAccount | 
		innerTreeStructure := innerTreeStructure addAll: (self innerTreeStructureOf: innerAccount inHeight: aHeight +1) asArray; yourself 
	].
	
	^ innerTreeStructure! !

!TreeStructure methodsFor: 'default tree structure' stamp: 'FG 11/15/2020 22:37:37'!
treeStructure
	
	^ self innerTreeStructureOf: account inHeight: 0.
! !


!TreeStructure methodsFor: 'report protocols' stamp: 'FG 11/15/2020 22:49:10'!
reportPortfolio: aPortfolio inHeight: aHeight
	
	|innerTreeStructure|
	
	innerTreeStructure := OrderedCollection new.
	
	aPortfolio accounts do:[:innerAccount | 
		innerTreeStructure := innerTreeStructure addAll: (self innerTreeStructureWithAccountSummaryOf: innerAccount inHeight: aHeight +1); yourself ].
		innerTreeStructure add: (self applyingTabulationsIn: 'Balance = ' , aPortfolio balance asString basedOn: aHeight + 1).
	
	^ innerTreeStructure! !

!TreeStructure methodsFor: 'report protocols' stamp: 'FG 11/15/2020 22:49:10'!
reportReceptiveAccount: anAccount inHeight: aHeight
	
	|innerTreeStructure accountSummary|
	
	innerTreeStructure := OrderedCollection new.
	
	accountSummary := (AccountSummary of: anAccount) accountSummary.
	
	accountSummary do:[:accountSummaryLine | innerTreeStructure add: (self applyingTabulationsIn: accountSummaryLine basedOn: aHeight + 1)].		
	
	^ innerTreeStructure! !


!classDefinition: #AccountTransaction category: #'Portfolio2-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'report' stamp: 'FG 11/14/2020 12:08:34'!
makeReport: aReport

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio2-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio2-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'report' stamp: 'FG 11/14/2020 12:08:50'!
makeReport: aReport

	^ aReport reportDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio2-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferenceComponents category: #'Portfolio2-Solucion'!
AccountTransaction subclass: #TransferenceComponents
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!TransferenceComponents methodsFor: 'balance' stamp: 'FG 11/14/2020 12:13:25'!
affectBalance 
	self subclassResponsibility.! !


!TransferenceComponents methodsFor: 'value' stamp: 'FG 11/14/2020 12:12:54'!
value 
	^ transference value.! !


!TransferenceComponents methodsFor: 'initialization' stamp: 'FG 11/9/2020 21:10:25'!
initializeFor: aTransference

	transference := aTransference.! !


!TransferenceComponents methodsFor: 'transference' stamp: 'FG 11/9/2020 21:25:51'!
transference
 	^ transference.! !


!TransferenceComponents methodsFor: 'report' stamp: 'FG 11/14/2020 12:13:53'!
makeReport: aReport
	self subclassResponsibility.! !


!classDefinition: #TransferenceDeposit category: #'Portfolio2-Solucion'!
TransferenceComponents subclass: #TransferenceDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!TransferenceDeposit methodsFor: 'balance' stamp: 'FG 11/14/2020 12:14:13'!
affectBalance: aBalance

	^aBalance + self value.! !


!TransferenceDeposit methodsFor: 'report' stamp: 'FG 11/14/2020 12:09:07'!
makeReport: aReport

	^ aReport reportTransferenceDeposit: self. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceDeposit class' category: #'Portfolio2-Solucion'!
TransferenceDeposit class
	instanceVariableNames: ''!

!TransferenceDeposit class methodsFor: 'as yet unclassified' stamp: 'FG 11/9/2020 21:14:25'!
for: aTransference

	^ self new initializeFor: aTransference.! !


!classDefinition: #TransferenceWithdraw category: #'Portfolio2-Solucion'!
TransferenceComponents subclass: #TransferenceWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!TransferenceWithdraw methodsFor: 'balance' stamp: 'FG 11/14/2020 12:14:29'!
affectBalance: aBalance

	^aBalance - self value. ! !


!TransferenceWithdraw methodsFor: 'report' stamp: 'FG 11/14/2020 12:09:16'!
makeReport: aReport

	^ aReport reportTransferenceWithdraw: self. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceWithdraw class' category: #'Portfolio2-Solucion'!
TransferenceWithdraw class
	instanceVariableNames: ''!

!TransferenceWithdraw class methodsFor: 'as yet unclassified' stamp: 'FG 11/9/2020 21:14:19'!
for: aTransference

	^ self new initializeFor: aTransference.! !


!classDefinition: #Withdraw category: #'Portfolio2-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'report' stamp: 'FG 11/14/2020 12:09:25'!
makeReport: aReport

	^ aReport reportWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio2-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transference category: #'Portfolio2-Solucion'!
Object subclass: #Transference
	instanceVariableNames: 'value transferenceDeposit transferenceWithdraw'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!Transference methodsFor: 'value' stamp: 'FG 11/9/2020 21:12:06'!
value
	^ value.! !


!Transference methodsFor: 'transference legs' stamp: 'FG 11/9/2020 21:22:59'!
transferenceDeposit
	^ transferenceDeposit.! !

!Transference methodsFor: 'transference legs' stamp: 'FG 11/9/2020 21:23:11'!
transferenceWithdraw
	^ transferenceWithdraw.! !


!Transference methodsFor: 'initialization' stamp: 'FG 11/9/2020 21:08:34'!
initializeWith: anAmount from: aReceptiveAccountSender to: aReceptiveAccountReceiver

	transferenceWithdraw := 	TransferenceWithdraw register: self on: aReceptiveAccountSender.
	transferenceDeposit := TransferenceDeposit register: self on: aReceptiveAccountReceiver.
	value := anAmount.
	

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: #'Portfolio2-Solucion'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'error checking' stamp: 'FG 11/9/2020 21:37:50'!
cantTransferNonPositiveAmount
	^ ' Error - You can not transfer a non-positive amount' ! !

!Transference class methodsFor: 'error checking' stamp: 'FG 11/9/2020 21:31:08'!
cantTransferToTheSameAccount
	^ ' Error - You can not transfer to the same account you are transfering from' ! !


!Transference class methodsFor: 'initialization' stamp: 'FG 11/9/2020 21:38:49'!
register: anAmount from: aReceptiveAccountSender to: aReceptiveAccountReceiver
	
	(aReceptiveAccountSender  == aReceptiveAccountReceiver ) ifTrue: [self error: self cantTransferToTheSameAccount ].
	(anAmount  <= 0) ifTrue: [self error: self cantTransferNonPositiveAmount ].
	
	^ self new initializeWith: anAmount from: aReceptiveAccountSender to: aReceptiveAccountReceiver.! !
