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

!PortfolioTest methodsFor: 'tests' stamp: 'PGTA 11/14/2020 22:49:17'!
test16PortfolioCanHaveAName
	
	| johnsPortfolio accountName |
	accountName := 'Cuenta de Juan'.
	johnsPortfolio := Portfolio named: accountName.
	
	self assert: accountName equals: johnsPortfolio accountName.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'PGTA 11/14/2020 22:57:00'!
test17PortfolioWithAnAccountCanHaveAName
	
	| johnsPortfolio portfolioName account |
	account := ReceptiveAccount new.
	portfolioName := 'Cuenta de Juan'.
	johnsPortfolio := Portfolio named: portfolioName with: account.
	
	self assert: portfolioName equals: johnsPortfolio accountName.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'PGTA 11/14/2020 23:05:23'!
test18PortfolioWithTwoAccountsCanHaveAName
	
	| johnsPortfolio portfolioName account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	portfolioName := 'Cuenta de Juan'.
	johnsPortfolio := Portfolio named: portfolioName with: account1 with: account2.
	
	self assert: portfolioName equals: johnsPortfolio accountName.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'PJ 11/15/2020 18:29:38'!
test19PortfolioWithoutANameReturnsDefault
	
	| johnsPortfolio portfolioName |
	portfolioName := 'a Portfolio'.
	johnsPortfolio := Portfolio new.
	
	self assert: portfolioName equals: johnsPortfolio accountName.
! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'account tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'account tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'account tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'account tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'account tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'account tests' stamp: 'NR 11/9/2020 06:00:12'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'account tests' stamp: 'NR 11/9/2020 06:02:30'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: account.
		
	self assert: 1 equals: account transactions size .
	self assert: (account transactions includes: deposit).
! !

!ReceptiveAccountTest methodsFor: 'account tests' stamp: 'PGTA 11/14/2020 22:42:38'!
test12ReceptiveAccountCanHaveAName
	
	| johnsAccount accountName |
	accountName := 'Cuenta de Juan'.
	johnsAccount := ReceptiveAccount named: accountName.
	
	self assert: accountName equals: johnsAccount accountName.
! !

!ReceptiveAccountTest methodsFor: 'account tests' stamp: 'PJ 11/15/2020 18:27:06'!
test13ReceptiveAccountWithoutANameReturnsDefault
	
	| johnsAccount accountName |
	accountName := 'a Receptive Account'.
	johnsAccount := ReceptiveAccount new.
	
	self assert: accountName equals: johnsAccount accountName.
! !


!ReceptiveAccountTest methodsFor: 'transfer tests' stamp: 'PJ 11/10/2020 21:16:50'!
test08TransferSenderAccountAcknowledgesTransferTransactions 

	| senderAccount receiverAccount transfer|
	
	senderAccount := ReceptiveAccount new.
	Deposit register: 100 on: senderAccount.
	
	receiverAccount := ReceptiveAccount new.
	
	transfer := Transfer from: senderAccount to: receiverAccount amount: 10.
		
	self assert: 90 equals: senderAccount balance.
	self assert: (senderAccount hasRegistered: (transfer withdraw)).
! !

!ReceptiveAccountTest methodsFor: 'transfer tests' stamp: 'PJ 11/10/2020 21:17:27'!
test09TransferReceiverAccountAcknowledgesTransferTransactions 

	| senderAccount receiverAccount transfer |
	
	senderAccount := ReceptiveAccount new.
	Deposit register: 100 on: senderAccount.
	
	receiverAccount := ReceptiveAccount new.
	
	transfer := Transfer from: senderAccount to: receiverAccount amount: 10.
		
	self assert: 10 equals: receiverAccount balance.
	self assert: (receiverAccount hasRegistered: (transfer deposit) ).
! !

!ReceptiveAccountTest methodsFor: 'transfer tests' stamp: 'PJ 11/10/2020 21:16:10'!
test10TransferDepositAndWithdrawCanNavigateToTransfer

	| senderAccount receiverAccount transfer deposit withdraw |
	
	senderAccount := ReceptiveAccount new.
	Deposit register: 100 on: senderAccount.
	
	receiverAccount := ReceptiveAccount new.
	
	transfer := Transfer from: senderAccount to: receiverAccount amount: 10.
	
	deposit := transfer deposit.
	withdraw  := transfer withdraw.
	
	self assert: transfer equals: deposit transfer.
	self assert: transfer equals: withdraw transfer.
! !

!ReceptiveAccountTest methodsFor: 'transfer tests' stamp: 'PJ 11/10/2020 22:22:28'!
test11TransferDepositAndWithdrawKnowTheTransferAmount

	| senderAccount receiverAccount transfer deposit withdraw |
	
	senderAccount := ReceptiveAccount new.
	Deposit register: 100 on: senderAccount.
	
	receiverAccount := ReceptiveAccount new.
	
	transfer := Transfer from: senderAccount to: receiverAccount amount: 10.
	
	deposit := transfer deposit.
	withdraw  := transfer withdraw.
	
	self assert: 10 equals: deposit value.
	self assert: 10 equals: withdraw value.
! !


!classDefinition: #ReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTest methodsFor: 'transfer net' stamp: 'PJ 11/10/2020 23:08:36'!
test06TransferNetFromANewAccountReturnsZero

	|account report|
	
	account := ReceptiveAccount new.
	report := TransferNet for: account.
	
	self assert: 'Transfer Net: 0' equals: report.! !

!ReportTest methodsFor: 'transfer net' stamp: 'PJ 11/12/2020 22:16:33'!
test07TransferNetReturnsAReportFromAnAccountWithADeposit

	|account report|
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	report := TransferNet for: account.
	
	self assert: 'Transfer Net: 0' equals: report.! !

!ReportTest methodsFor: 'transfer net' stamp: 'PJ 11/12/2020 22:30:12'!
test08TransferNetReturnsAReportFromAnAccountWithAWithdraw

	|account report|
	
	account := ReceptiveAccount new.
	Withdraw register: 100 on: account.
	
	report := TransferNet for: account.
	
	self assert: 'Transfer Net: 0' equals: report.! !

!ReportTest methodsFor: 'transfer net' stamp: 'PJ 11/12/2020 22:28:56'!
test09TransferNetReturnsAReportFromAnAccountWithATransferWithdraw

	|senderAccount receiverAccount report|
	
	receiverAccount := ReceptiveAccount new.
	senderAccount := ReceptiveAccount new.
	Transfer from: senderAccount to: receiverAccount amount: 20.
	
	report := TransferNet for: senderAccount.
	
	self assert: 'Transfer Net: -20' equals: report.! !

!ReportTest methodsFor: 'transfer net' stamp: 'PJ 11/12/2020 22:34:36'!
test10TransferNetReturnsAReportFromAnAccountWithATransferDeposit

	|senderAccount receiverAccount report|
	
	receiverAccount := ReceptiveAccount new.
	senderAccount := ReceptiveAccount new.
	Transfer from: senderAccount to: receiverAccount amount: 20.
		
	report := TransferNet for: receiverAccount.
	
	self assert: 'Transfer Net: 20' equals: report.! !

!ReportTest methodsFor: 'transfer net' stamp: 'PJ 11/12/2020 23:34:11'!
test11TransferNetWorksWithAPortfolio

	|portfolio account account2 report|
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: 100 on: account.
	Transfer from: account to: account2 amount: 50. 
	Transfer from: account2 to: account amount: 5. 
		
	portfolio := Portfolio with: account.
		
	report := TransferNet for: portfolio .
	
	self assert: 'Transfer Net: -45' equals: report.! !


!ReportTest methodsFor: 'account summary' stamp: 'PJ 11/10/2020 21:47:09'!
test01AccountSummaryFromANewAccountReturnsBalance0

	|account report|
	
	account := ReceptiveAccount new.
	report := AccountSummary for: account.
	
	self assert: 1 equals: report size.
	self assert: 'Balance = 0' equals: report first.! !

!ReportTest methodsFor: 'account summary' stamp: 'PJ 11/10/2020 21:57:55'!
test02AccountSummaryReturnsAReportFromAnAccountWithADeposit

	|account report|
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	report := AccountSummary for: account.
	
	self assert: 2 equals: report size.
	self assert: 'Depósito por 100' equals: (report at: 1).
	self assert: 'Balance = 100' equals: (report at: 2).! !

!ReportTest methodsFor: 'account summary' stamp: 'PJ 11/10/2020 22:08:03'!
test03AccountSummaryReturnsAReportFromAnAccountWithAWithdraw

	|account report|
	
	account := ReceptiveAccount new.
	Withdraw register: 50 on: account.
	
	report := AccountSummary for: account.
	
	self assert: 2 equals: report size.
	self assert: 'Extracción por 50' equals: (report at: 1).
	self assert: 'Balance = -50' equals: (report at: 2).! !

!ReportTest methodsFor: 'account summary' stamp: 'PJ 11/10/2020 22:15:11'!
test04AccountSummaryReturnsAReportFromAnAccountWithATransferWithdraw

	|senderAccount receiverAccount report|
	
	receiverAccount := ReceptiveAccount new.
	senderAccount := ReceptiveAccount new.
	Transfer from: senderAccount to: receiverAccount amount: 20.
	
	report := AccountSummary for: senderAccount.
	
	self assert: 2 equals: report size.
	self assert: 'Salida por transferencia de 20' equals: (report at: 1).
	self assert: 'Balance = -20' equals: (report at: 2).! !

!ReportTest methodsFor: 'account summary' stamp: 'PJ 11/12/2020 22:19:53'!
test05AccountSummaryReturnsAReportFromAnAccountWithATransferDeposit

	|senderAccount receiverAccount report|
	
	receiverAccount := ReceptiveAccount new.
	senderAccount := ReceptiveAccount new.
	Transfer from: senderAccount to: receiverAccount amount: 20.
	
	report := AccountSummary for: receiverAccount.
	
	self assert: 2 equals: report size.
	self assert: 'Entrada por transferencia de 20' equals: (report at: 1).
	self assert: 'Balance = 20' equals: (report at: 2).! !


!ReportTest methodsFor: 'portfolio tree' stamp: 'PGTA 11/15/2020 19:29:34'!
test12PortfolioStructureWithoutAccountsReturnsPortfolioName

	| portfolio portfolioName report |
	
	portfolioName := 'Portfolio de Juan'.
	portfolio := Portfolio named: portfolioName.
		
	report := PortfolioStructure for: portfolio.
	
	self assert: portfolioName equals: report first.! !

!ReportTest methodsFor: 'portfolio tree' stamp: 'PGTA 11/15/2020 19:01:27'!
test13PortfolioStructureWithOneAccount

	| portfolio portfolioName report account accountName |
	
	accountName := 'Cuenta de Juan'.
	account := 	ReceptiveAccount named: accountName.
	
	portfolioName := 'Portfolio de Juan'.
	portfolio := Portfolio named: portfolioName with: account.
	
	report := PortfolioStructure for: portfolio.
	
	self assert: portfolioName equals: (report at: 1).
	self assert: ('	', accountName) equals: (report at: 2).! !

!ReportTest methodsFor: 'portfolio tree' stamp: 'PGTA 11/15/2020 19:33:34'!
test14PortfolioStructureWithOnePortfolioIndentsCorrectly

	| portfolio1 portfolio2 portfolioName1 portfolioName2 report |
	
	portfolioName1 := 'Portfolio hijo'.
	portfolio1 := Portfolio named: portfolioName1.
	
	portfolioName2 := 'Portfolio padre'.
	portfolio2 := Portfolio named: portfolioName2 with: portfolio1.
	
	report := PortfolioStructure for: portfolio2.
	
	self assert: portfolioName2 equals: (report at: 1).
	self assert: ('	', portfolioName1) equals: (report at: 2).! !

!ReportTest methodsFor: 'portfolio tree' stamp: 'PGTA 11/15/2020 21:03:09'!
test15PortfolioStructureCatedra
	| johnsAccount angiesAccount childrenPortfolio myAccount familyPortfolio report stringReport |

	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount.
	myAccount := ReceptiveAccount named: 'Cuenta mia'.
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	
	report := PortfolioStructure for: familyPortfolio.
	stringReport := 'Portfolio de la familia
	Cuenta mia
	Portfolio de hijos
		Cuenta de Juan
		Cuenta de Angeles'.
			
	self assert: stringReport equals: (report printStringWithNewline).! !

!ReportTest methodsFor: 'portfolio tree' stamp: 'PGTA 11/15/2020 21:08:58'!
test16SpecialSummaryReportForOnePortfolio
	| johnsPortfolio report stringReport |
	
	stringReport := 'Portfolio de Juan'.
	johnsPortfolio := Portfolio named: stringReport.
	
	report := SpecialSummary for: johnsPortfolio.
	self assert: stringReport equals: (report first).! !

!ReportTest methodsFor: 'portfolio tree' stamp: 'PGTA 11/15/2020 21:33:40'!
test17SpecialSummaryReportForOnePortfolioWithOneAccount
	| johnsPortfolio report stringReport account account2 |
	
	account := ReceptiveAccount named: 'Cuenta de Juan'.
	account2 := ReceptiveAccount new.
	
	Deposit register: 100 on: account.
	Transfer from: account2 to: account amount: 30.
	Withdraw register: 20 on: account.
	Transfer from: account to: account2 amount: 15.
	
	johnsPortfolio := Portfolio named: 'Portfolio de Juan' with: account.
	
	report := SpecialSummary for: johnsPortfolio.
	
	stringReport := 'Portfolio de Juan
	Cuenta de Juan
		Depósito por 100
		Entrada por transferencia de 30
		Extracción por 20
		Salida por transferencia de 15
		Balance = 95'.
		
	self assert: stringReport equals: (report printStringWithNewline).! !


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

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'reports' stamp: 'PJ 11/14/2020 20:55:18'!
report: myTransactions To: aReport 
	myTransactions do: [:aTransaction |aTransaction reportTo: aReport ].! !

!Account methodsFor: 'reports' stamp: 'PJ 11/12/2020 23:19:40'!
reportTo: aReport 
	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name accountName'
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


!Portfolio methodsFor: 'initialization' stamp: 'PJ 11/15/2020 18:30:32'!
initialize

	accountName := 'a Portfolio'.
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'PGTA 11/14/2020 22:50:56'!
initializeWithName: aName 
	self initialize.
	accountName := aName.! !


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


!Portfolio methodsFor: 'reports' stamp: 'PGTA 11/14/2020 22:51:15'!
accountName
	^accountName! !

!Portfolio methodsFor: 'reports' stamp: 'PGTA 11/15/2020 20:31:05'!
reportStructureTo: aReport  forLevel: aLevel
	aReport reportAsPortfolio: self forLevel: aLevel.
	accounts do: [:anAccount | anAccount reportStructureTo: aReport  forLevel: (aLevel+1)].! !

!Portfolio methodsFor: 'reports' stamp: 'PJ 11/14/2020 20:33:55'!
reportTo: aReport 
	self report: self transactions To: aReport .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'NR 11/9/2020 06:01:26'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio!!'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'PGTA 11/14/2020 22:50:18'!
named: aName 
	^self new initializeWithName: aName.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'PGTA 11/14/2020 23:02:50'!
named: aName with: anAccount 
	
	^self new initializeWithName: aName;
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'PGTA 11/14/2020 23:05:06'!
named: aName with: anAccount with: anotherAccount
	
	^self new initializeWithName: aName;
		add: anAccount;
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


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions accountName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'PJ 11/15/2020 18:27:55'!
initialize

	super initialize.
	accountName := 'a Receptive Account'.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'PGTA 11/14/2020 22:48:04'!
initializeWithName: aName 
	self initialize.
	accountName := aName.! !


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


!ReceptiveAccount methodsFor: 'balance' stamp: 'PGTA 11/9/2020 21:30:32'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]
		! !


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


!ReceptiveAccount methodsFor: 'reports' stamp: 'PGTA 11/14/2020 22:45:53'!
accountName
	^accountName.! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'PGTA 11/15/2020 20:40:52'!
reportStructureTo: aReport forLevel: aLevel
	aReport reportAsReceptiveAccount: self forLevel: aLevel.! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'PJ 11/14/2020 20:34:15'!
reportTo: aReport 
	self report: transactions To: aReport .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'PGTA 11/14/2020 22:47:12'!
named: aName
	^self new initializeWithName: aName.! !


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


!AccountTransaction methodsFor: 'reports' stamp: 'PJ 11/12/2020 21:45:00'!
reportTo: anAccountSummary 
	self subclassResponsibility.! !

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


!Deposit methodsFor: 'reports' stamp: 'PJ 11/12/2020 21:51:39'!
reportTo: aReport 
	^aReport reportAsDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferTransaction category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferTransaction
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTransaction methodsFor: 'private' stamp: 'PJ 11/10/2020 21:19:11'!
transfer
	^transfer! !

!TransferTransaction methodsFor: 'private' stamp: 'PJ 11/10/2020 22:23:50'!
value
	^transfer value.! !


!TransferTransaction methodsFor: 'initialization' stamp: 'PJ 11/10/2020 21:20:23'!
initializeOn: aReceiverAccount for: aTransfer

	transfer := aTransfer.
	aReceiverAccount register: self.! !


!TransferTransaction methodsFor: 'reports' stamp: 'PJ 11/12/2020 22:03:00'!
reportTo: aReport
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTransaction class' category: 'Portfolio-Solucion'!
TransferTransaction class
	instanceVariableNames: ''!

!TransferTransaction class methodsFor: 'as yet unclassified' stamp: 'PGTA 11/9/2020 22:51:15'!
registerOn: aReceiverAccount for: aTransfer
	
	^self new initializeOn: aReceiverAccount for: aTransfer.
	! !


!classDefinition: #TransferDeposit category: 'Portfolio-Solucion'!
TransferTransaction subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDeposit methodsFor: 'balance' stamp: 'PJ 11/10/2020 21:20:14'!
affectBalance: aBalance

	^aBalance + transfer value.! !


!TransferDeposit methodsFor: 'reports' stamp: 'PJ 11/12/2020 22:05:36'!
reportTo: aReport
	^aReport reportAsTransferDeposit: self.! !


!classDefinition: #TransferWithdraw category: 'Portfolio-Solucion'!
TransferTransaction subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferWithdraw methodsFor: 'reports' stamp: 'PJ 11/12/2020 22:02:10'!
reportTo: aReport 
	^aReport reportAsTransferWithdraw: self.! !


!TransferWithdraw methodsFor: 'balance' stamp: 'PJ 11/10/2020 21:19:54'!
affectBalance: aBalance

	^aBalance - transfer value.! !


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


!Withdraw methodsFor: 'reports' stamp: 'PJ 11/12/2020 21:54:02'!
reportTo: aReport 
	^aReport reportAsWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: 'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'private' stamp: 'PGTA 11/15/2020 21:24:53'!
generateIndentationFor: aLevel
	^'' padded: #left to: aLevel with: $	! !

!Report methodsFor: 'private' stamp: 'PJ 11/10/2020 23:11:11'!
generateReportFor: anAccount
	self subclassResponsibility ! !


!Report methodsFor: 'transaction report' stamp: 'PJ 11/12/2020 21:48:32'!
reportAsDeposit: aDeposit 
	self subclassResponsibility.! !

!Report methodsFor: 'transaction report' stamp: 'PJ 11/12/2020 22:07:39'!
reportAsTransferDeposit: aTransaction
	self subclassResponsibility ! !

!Report methodsFor: 'transaction report' stamp: 'PJ 11/12/2020 22:00:41'!
reportAsTransferWithdraw: aTransaction
	self subclassResponsibility .! !

!Report methodsFor: 'transaction report' stamp: 'PJ 11/12/2020 22:09:57'!
reportAsWithdraw: aWithdraw 
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'Portfolio-Solucion'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'instance creation' stamp: 'PJ 11/10/2020 23:12:22'!
for: anAccount 
	^self new generateReportFor: anAccount ! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'private' stamp: 'PJ 11/14/2020 21:14:01'!
generateReportFor: anAccount 
	
	summary := OrderedCollection new.
	
	anAccount reportTo: self.
	
	summary add: ('Balance = ', anAccount balance asString).
	^summary! !


!AccountSummary methodsFor: 'transaction report' stamp: 'PJ 11/14/2020 21:02:39'!
reportAsDeposit: aTransaction 
	summary add: ('Depósito por ', aTransaction value asString)! !

!AccountSummary methodsFor: 'transaction report' stamp: 'PJ 11/14/2020 21:02:53'!
reportAsTransferDeposit: aTransaction
	summary add: ('Entrada por transferencia de ', aTransaction value asString)! !

!AccountSummary methodsFor: 'transaction report' stamp: 'PJ 11/14/2020 21:03:01'!
reportAsTransferWithdraw: aTransaction 
	summary add: ('Salida por transferencia de ', aTransaction value asString)! !

!AccountSummary methodsFor: 'transaction report' stamp: 'PJ 11/14/2020 21:04:00'!
reportAsWithdraw: aWithdraw 
	summary add: ('Extracción por ', aWithdraw value asString)! !


!classDefinition: #PortfolioStructure category: 'Portfolio-Solucion'!
Report subclass: #PortfolioStructure
	instanceVariableNames: 'structure'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioStructure methodsFor: 'account report' stamp: 'PGTA 11/15/2020 20:28:53'!
generateReportFor: aPortfolio 
	structure := OrderedCollection new.
	aPortfolio reportStructureTo: self forLevel: 0.
	^structure.! !

!PortfolioStructure methodsFor: 'account report' stamp: 'PGTA 11/15/2020 20:41:58'!
reportAsReceptiveAccount: aReceptiveAccount forLevel: aLevel
	| accountString |
	accountString := self generateIndentationFor: aLevel.
	structure add: (accountString, aReceptiveAccount accountName).! !


!PortfolioStructure methodsFor: 'private' stamp: 'PGTA 11/15/2020 20:34:07'!
reportAsPortfolio: aPortfolio forLevel: aLevel
	| accountString |
	accountString := self generateIndentationFor: aLevel.
	structure add: (accountString, aPortfolio accountName).! !


!classDefinition: #SpecialSummary category: 'Portfolio-Solucion'!
Report subclass: #SpecialSummary
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SpecialSummary methodsFor: 'account report' stamp: 'PGTA 11/15/2020 21:24:04'!
reportAsPortfolio: aPortfolio forLevel: aLevel
	| accountString |
	accountString := self generateIndentationFor: aLevel.
	summary add: (accountString, aPortfolio accountName).! !

!SpecialSummary methodsFor: 'account report' stamp: 'PGTA 11/15/2020 21:32:25'!
reportAsReceptiveAccount: aReceptiveAccount forLevel: aLevel
	| accountString accountSummary|
	accountString := self generateIndentationFor: aLevel.
	summary add: (accountString, aReceptiveAccount accountName).
	
	accountSummary := AccountSummary for: aReceptiveAccount.
	accountSummary do: [:transactionDescription | 
		accountString := self generateIndentationFor: (aLevel+1).
		summary add: (accountString, transactionDescription).]! !


!SpecialSummary methodsFor: 'private' stamp: 'PGTA 11/15/2020 21:23:01'!
generateReportFor: aPortfolio
	summary := OrderedCollection new.
	aPortfolio reportStructureTo: self forLevel: 0.
	^summary.! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
Report subclass: #TransferNet
	instanceVariableNames: 'netValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'private' stamp: 'PJ 11/12/2020 23:15:28'!
generateReportFor: anAccount 
	
	netValue := 0.
	
	anAccount reportTo: self.
		
	^'Transfer Net: ', netValue asString. ! !

!TransferNet methodsFor: 'private' stamp: 'PJ 11/14/2020 20:54:58'!
reportAffectedBalance: aTransaction
	
	^netValue := aTransaction affectBalance: netValue.! !


!TransferNet methodsFor: 'transaction report' stamp: 'PJ 11/14/2020 20:53:44'!
reportAsDeposit: aTransaction 
	! !

!TransferNet methodsFor: 'transaction report' stamp: 'PJ 11/14/2020 20:43:41'!
reportAsTransferDeposit: aTransaction 
	^self reportAffectedBalance: aTransaction! !

!TransferNet methodsFor: 'transaction report' stamp: 'PJ 11/14/2020 20:44:00'!
reportAsTransferWithdraw: aTransaction 
	^self reportAffectedBalance: aTransaction! !

!TransferNet methodsFor: 'transaction report' stamp: 'PJ 11/14/2020 20:53:51'!
reportAsWithdraw: aTransaction 
	! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value receivedTransaction sendTransaction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'private' stamp: 'PGTA 11/16/2020 16:22:52'!
deposit
	
	^receivedTransaction.! !

!Transfer methodsFor: 'private' stamp: 'PGTA 11/16/2020 16:22:34'!
initializeFrom: aSenderAccount to: aReceiverAccount amount: anAmount
	
	value := anAmount.
	receivedTransaction := TransferDeposit registerOn: aReceiverAccount for: self.
	sendTransaction := TransferWithdraw registerOn: aSenderAccount for: self.! !

!Transfer methodsFor: 'private' stamp: 'PJ 11/10/2020 22:26:04'!
value
	^value! !

!Transfer methodsFor: 'private' stamp: 'PGTA 11/16/2020 16:23:06'!
withdraw
	
	^sendTransaction.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'PGTA 11/9/2020 21:21:45'!
from: aSenderAccount to: aReceiverAccount amount: anAmount
	^self new initializeFrom: aSenderAccount to: aReceiverAccount amount: anAmount.
	
	! !
