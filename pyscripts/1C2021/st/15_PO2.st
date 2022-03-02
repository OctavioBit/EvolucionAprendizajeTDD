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

!PortfolioTest methodsFor: 'tests' stamp: 'UC 6/2/2021 19:56:00'!
test16NamedPortfolioIsCorrect
	self assert: 'port' equals: (Portfolio named: 'port') name.! !


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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'UC 5/29/2021 23:56:03'!
test08AccountsBalancesAfterTransferAreCorrect
	| receiver sender |
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	Transfer from: sender to: receiver for: 100.
	self assert: -100 equals: sender balance.
	self assert: 100 equals: receiver balance.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'UC 5/29/2021 23:56:48'!
test09AccountHasRegisteredTransferLegsCorrectly
	| receiver sender transfer |
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	transfer := Transfer from: sender to: receiver for: 100.
	self assert: (sender hasRegistered: transfer sendLeg).
	self assert: (receiver hasRegistered: transfer receiveLeg).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'UC 6/2/2021 19:49:42'!
test10UnnamedReceptiveAccountNameIsEmpty
	self assert: '' equals: ReceptiveAccount new name.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'UC 6/2/2021 19:52:51'!
test11NamedReceptiveAccountIsCorrect
	self assert: 'ra' equals: (ReceptiveAccount named: 'ra') name.! !


!classDefinition: #ReportsTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportsTest methodsFor: 'account summary - tests' stamp: 'UC 5/30/2021 00:38:22'!
test01AccountSummaryForEmptyAccount
	| emptyAccount report |
	emptyAccount := ReceptiveAccount new.
	report := self getAccountSummaryFor: emptyAccount.
	self assert: 1 equals: (report size)	.
	self assert: 'Balance = 0' equals: (report at: 1)	.! !

!ReportsTest methodsFor: 'account summary - tests' stamp: 'UC 5/30/2021 00:39:01'!
test02AccountSummaryForOneDepositInReceptiveAccount
	| account report |
	account := ReceptiveAccount new.
	Deposit register: 100 on: account. 
	report := self getAccountSummaryFor: account.
	self assert: 2 equals: (report size)	.
	self assert: 'Depósito por 100' equals: (report at: 1)	.
	self assert: 'Balance = 100' equals: (report at: 2)	.! !

!ReportsTest methodsFor: 'account summary - tests' stamp: 'UC 5/30/2021 00:39:06'!
test03AccountSummaryForOneWithdrawInReceptiveAccount
	| account report |
	account := ReceptiveAccount new.
	Withdraw register: 100 on: account. 
	report := self getAccountSummaryFor: account.
	self assert: 2 equals: (report size)	.
	self assert: 'Extracción por 100' equals: (report at: 1)	.
	self assert: 'Balance = -100' equals: (report at: 2)	.! !

!ReportsTest methodsFor: 'account summary - tests' stamp: 'UC 5/30/2021 00:39:10'!
test04AccountSummaryForOneSendInReceptiveAccount
	| account report |
	account := ReceptiveAccount new.
	Transfer from: account to: ReceptiveAccount new for: 100. 
	report := self getAccountSummaryFor: account.
	self assert: 2 equals: (report size)	.
	self assert: 'Salida por transferencia de 100' equals: (report at: 1)	.
	self assert: 'Balance = -100' equals: (report at: 2)	.! !

!ReportsTest methodsFor: 'account summary - tests' stamp: 'UC 5/30/2021 00:39:13'!
test05AccountSummaryForOneReceiveInReceptiveAccount
	| account report |
	account := ReceptiveAccount new.
	Transfer from: ReceptiveAccount new to: account for: 100. 
	report := self getAccountSummaryFor: account.
	self assert: 2 equals: (report size)	.
	self assert: 'Entrada por transferencia de 100' equals: (report at: 1)	.
	self assert: 'Balance = 100' equals: (report at: 2)	.! !

!ReportsTest methodsFor: 'account summary - tests' stamp: 'UC 5/30/2021 00:39:16'!
test06AccountSummaryForManyTransactionsInReceptiveAccount
	| account report |
	account := ReceptiveAccount new.
	Deposit register: 100 on: account. 
	Deposit register: 120 on: account. 
	report := self getAccountSummaryFor: account.
	self assert: 3 equals: (report size)	.
	self assert: 'Depósito por 100' equals: (report at: 1)	.
	self assert: 'Depósito por 120' equals: (report at: 2)	.
	self assert: 'Balance = 220' equals: (report at: 3)	.! !

!ReportsTest methodsFor: 'account summary - tests' stamp: 'UC 5/30/2021 00:37:50'!
test07AccountSummaryForEmptyPortfolio
	| report portfolio |
	portfolio := Portfolio new.
	
	report := self getAccountSummaryFor: portfolio.
	self assert: 1 equals: (report size)	.
	self assert: 'Balance = 0' equals: (report at: 1)	.! !

!ReportsTest methodsFor: 'account summary - tests' stamp: 'UC 5/30/2021 00:40:49'!
test08AccountSummaryForPortfolioWithOneReceptiveAccount
	| account report portfolio |
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account.
	
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	Transfer from: account to: ReceptiveAccount new for: 20. 
	Transfer from: ReceptiveAccount new to: account for: 30.
	report := self getAccountSummaryFor: portfolio.
	self assert: 5 equals: (report size)	.
	self assert: 'Depósito por 100' equals: (report at: 1)	.
	self assert: 'Extracción por 50' equals: (report at: 2)	.
	self assert: 'Salida por transferencia de 20' equals: (report at: 3)	.
	self assert: 'Entrada por transferencia de 30' equals: (report at: 4)	.
	self assert: 'Balance = 60' equals: (report at: 5)	.! !

!ReportsTest methodsFor: 'account summary - tests' stamp: 'UC 5/30/2021 00:44:14'!
test09AccountSummaryForPortfolioWithReceptiveAccountAndAnotherPortfolio
	| account anotherAccount report rootPortfolio leafPortfolio |
	rootPortfolio := Portfolio new.
	leafPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	leafPortfolio add: account.
	
	rootPortfolio add: leafPortfolio.
	rootPortfolio add: anotherAccount.
	
	Transfer from: account to: anotherAccount for: 100.
	report := self getAccountSummaryFor: rootPortfolio.
	self assert: 3 equals: (report size)	.
	self assert: report includes: 'Salida por transferencia de 100'	.
	self assert: report includes: 'Entrada por transferencia de 100'.
	self assert: 'Balance = 0' equals: (report last)	.! !


!ReportsTest methodsFor: 'initialization' stamp: 'UC 6/2/2021 18:01:19'!
getAccountSummaryFor: account
	^(AccountSummary for: account) do! !

!ReportsTest methodsFor: 'initialization' stamp: 'UC 6/2/2021 20:06:33'!
getPortfolioStructureFor: aPortfolio 
	^(PortfolioStructure for: aPortfolio) do.! !

!ReportsTest methodsFor: 'initialization' stamp: 'UC 6/2/2021 18:01:15'!
getTransferNetFor: account
	^(TransferNet for: account) do! !


!ReportsTest methodsFor: 'print' stamp: 'UC 6/2/2021 17:38:57'!
printReport: aReport
	|printedReport|	
	aReport do:[:line | ]! !


!ReportsTest methodsFor: 'transfer net - tests' stamp: 'UC 6/1/2021 19:50:49'!
test10transferNetForEmptyAccount
	| emptyAccount report |
	emptyAccount := ReceptiveAccount new.
	report := self getTransferNetFor: emptyAccount.
	self assert: 0 equals: report	.	
	
	! !

!ReportsTest methodsFor: 'transfer net - tests' stamp: 'UC 6/1/2021 19:55:23'!
test11transferNetForOneReceiveInReceptiveAccount
	| account report |
	account := ReceptiveAccount new.
	Transfer from: ReceptiveAccount new to: account for: 100. 
	report := self getTransferNetFor: account.
	self assert: 100 equals: report	.
	! !

!ReportsTest methodsFor: 'transfer net - tests' stamp: 'UC 6/1/2021 20:00:37'!
test12transferNetForOneDepositInReceptiveAccount
	| account report |
	account := ReceptiveAccount new.
	Deposit register: 100 on: account. 
	report := self getTransferNetFor: account.
	self assert: 0 equals: report! !

!ReportsTest methodsFor: 'transfer net - tests' stamp: 'UC 6/1/2021 20:03:07'!
test13transferNetForOneWithdrawInReceptiveAccount
	| account report |
	account := ReceptiveAccount new.
	Withdraw register: 100 on: account. 
	report := self getTransferNetFor: account.
	self assert: 0 equals: report! !

!ReportsTest methodsFor: 'transfer net - tests' stamp: 'UC 6/1/2021 20:04:19'!
test14transferNetForOneSendInReceptiveAccount
	| account report |
	account := ReceptiveAccount new.
	Transfer from: account to: ReceptiveAccount new for: 100. 
	report := self getTransferNetFor: account.
	self assert: -100 equals: report! !

!ReportsTest methodsFor: 'transfer net - tests' stamp: 'UC 6/1/2021 20:07:50'!
test15transferNetForManyTransactionsInReceptiveAccount
	| account report |
	account := ReceptiveAccount new.
	Transfer from: ReceptiveAccount new to: account for: 100. 
	Deposit register: 120 on: account. 
	Transfer from: account to: ReceptiveAccount new for: 10. 
	report := self getTransferNetFor: account.
	self assert: 90 equals: report	.! !

!ReportsTest methodsFor: 'transfer net - tests' stamp: 'UC 6/1/2021 20:08:46'!
test16transferNetForEmptyPortfolio
	| report portfolio |
	portfolio := Portfolio new.
	
	report := self getTransferNetFor: portfolio.
	self assert: 0 equals: report! !

!ReportsTest methodsFor: 'transfer net - tests' stamp: 'UC 6/1/2021 20:14:05'!
test17transferNetForPortfolioWithOneReceptiveAccount
	| account report portfolio |
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account.
	
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	Transfer from: account to: ReceptiveAccount new for: 20. 
	Transfer from: ReceptiveAccount new to: account for: 30.
	report := self getTransferNetFor: portfolio.
	self assert: 10 equals: report.! !

!ReportsTest methodsFor: 'transfer net - tests' stamp: 'UC 6/1/2021 20:17:25'!
test18transferNetForPortfolioWithReceptiveAccountAndAnotherPortfolio
	| account anotherAccount report rootPortfolio leafPortfolio |
	rootPortfolio := Portfolio new.
	leafPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	leafPortfolio add: account.
	
	rootPortfolio add: leafPortfolio.
	rootPortfolio add: anotherAccount.
	
	Transfer from: account to: ReceptiveAccount new for: 100.
	Transfer from: anotherAccount to: ReceptiveAccount new for: 100.
	Transfer from: ReceptiveAccount new to: anotherAccount for: 10.
	
	report := self getTransferNetFor: rootPortfolio.
	self assert: -190 equals: report.! !


!ReportsTest methodsFor: 'portfolio structure - tests' stamp: 'UC 6/2/2021 21:06:26'!
test19PortfolioStructureOfEmptyPortfolioIsPortfolioName
	|emptyPortfolio report|
	emptyPortfolio := Portfolio named: 'Portafolio Root'.
	report := self getPortfolioStructureFor: emptyPortfolio.
	self assert: 1 equals: report size.
	self assert: report includes: 'Portafolio Root'.
	
	! !

!ReportsTest methodsFor: 'portfolio structure - tests' stamp: 'UC 6/2/2021 21:07:49'!
test20PortfolioStructureOfPortfolioWithAccountsIsCorrect
	|rootPortfolio accountPepe accountJuana report|
	rootPortfolio := Portfolio named: 'Portafolio Root'.
	accountPepe := ReceptiveAccount named: 'Cuenta de pepe'.
	accountJuana := ReceptiveAccount named: 'Cuenta de juana'.
	rootPortfolio add: accountPepe.
	rootPortfolio add: accountJuana.
	
	report := self getPortfolioStructureFor: rootPortfolio.
	self assert: 3 equals: report size.
	self assert: (report at: 1) equals: 'Portafolio Root'.
	self assert: (report at: 2) equals: '  Cuenta de pepe'.
	self assert: (report at: 3) equals: '  Cuenta de juana'.
	
	! !

!ReportsTest methodsFor: 'portfolio structure - tests' stamp: 'UC 6/2/2021 21:08:18'!
test21PortfolioStructureOfPortfolioWithPortolfioWithAccountIsCorrect
	|rootPortfolio childPortfolio accountJuana report|
	childPortfolio := Portfolio named: 'Portafolio Hijo'.
	rootPortfolio := Portfolio named: 'Portafolio Root'.
	accountJuana := ReceptiveAccount named: 'Cuenta de juana'.
	rootPortfolio add: childPortfolio.
	childPortfolio add: accountJuana.
	
	report := self getPortfolioStructureFor: rootPortfolio.
	self assert: 3 equals: report size.
	self assert: (report at: 1) equals: 'Portafolio Root'.
	self assert: (report at: 2) equals: '  Portafolio Hijo'.
	self assert: (report at: 3) equals: '    Cuenta de juana'.
	! !

!ReportsTest methodsFor: 'portfolio structure - tests' stamp: 'UC 6/2/2021 21:12:00'!
test22PortfolioStructureOfMultipleHeightsPortfolioIsCorrect

	| angiesAccount childrenPortfolio familyPortfolio johnsAccount myAccount report davidsAccount |
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.
	davidsAccount := ReceptiveAccount named: 'Cuenta de David'.
	childrenPortfolio := Portfolio named: 'Portfolio de hijos'.
	childrenPortfolio add: johnsAccount.
	childrenPortfolio add: angiesAccount.
	
	myAccount := ReceptiveAccount named: 'Cuenta mia'.
	familyPortfolio := Portfolio named: 'Portfolio de la familia'.
	familyPortfolio add: myAccount.
	familyPortfolio add: childrenPortfolio.
	familyPortfolio add: davidsAccount.
	
	report := self getPortfolioStructureFor: familyPortfolio.
	self assert: 6 equals: report size.
	self assert: (report at: 1) equals: 'Portfolio de la familia'.
	self assert: (report at: 2) equals: '  Cuenta mia'.
	self assert: (report at: 3) equals: '  Portfolio de hijos'.
	self assert: (report at: 4) equals: '    Cuenta de Juan'.
	self assert: (report at: 5) equals: '    Cuenta de Angeles'.
	self assert: (report at: 6) equals: '  Cuenta de David'.
	! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'UC 6/2/2021 19:03:50'!
test01TransferLegCanObtainTransfer
	| receiver sender _transfer |
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	_transfer := Transfer from: sender to: receiver for: 100.
	self assert: (_transfer sendLeg transfer) equals:  (_transfer).
	self assert: (_transfer receiveLeg transfer) equals:  (_transfer).! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'UC 6/2/2021 19:04:11'!
test02TransferValueIsCorrect
	| receiver sender _transfer |
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	_transfer := Transfer from: sender to: receiver for: 100.
	self assert: 100 equals:  _transfer value.
	! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'UC 6/2/2021 19:04:38'!
test03TransferValueIsSavedOnce
 	| receiver sender _transfer |
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	_transfer := Transfer from: sender to: receiver for: 	1020202020000000000000000000000.
	self assert: _transfer sendLeg value == _transfer receiveLeg value.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'UC 6/2/2021 19:04:56'!
test04TransferFor0RaisesError
	| receiver sender |
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	self should: 
		[Transfer from: sender to: receiver for: 	0.] 
		raise:  Error
		withExceptionDo: [:error | self assert: Transfer transferAmountMustBeGreaterThan0 equals: error messageText ]! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'UC 6/2/2021 19:05:19'!
test05TransferForNegativeRaisesError
	| receiver sender |
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	self should: 
		[Transfer from: sender to: receiver for: -10.] 
		raise:  Error
		withExceptionDo: [:error | self assert: Transfer transferAmountMustBeGreaterThan0 equals: error messageText ]
		
	! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'UC 6/2/2021 19:05:50'!
test06TransferReceiverMustBeDifferentToSender
	| receiverAndSender |
	receiverAndSender := ReceptiveAccount new.
	self should: 
		[Transfer from: receiverAndSender to: receiverAndSender for: 10.] 
		raise:  Error
		withExceptionDo: [:error | self assert: Transfer receiverMustBeDifferentFromSender equals: error messageText ]! !


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


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'do' stamp: 'UC 6/2/2021 19:29:14'!
doFor: anOperation
	self subclassResponsibility.! !


!Account methodsFor: 'name' stamp: 'UC 6/2/2021 19:57:32'!
name
	^name! !


!Account methodsFor: 'initialization' stamp: 'UC 6/2/2021 19:59:20'!
initializeNamed: aName 
	self initialize.
	name := aName.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'Portfolio-Solucion'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'instance creation' stamp: 'UC 6/2/2021 19:58:03'!
named: aName 
	^self new initializeNamed: aName ! !


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


!Portfolio methodsFor: 'initialization' stamp: 'UC 6/2/2021 19:55:22'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := ''.! !


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


!Portfolio methodsFor: 'do' stamp: 'UC 6/2/2021 18:00:14'!
doFor: aReport
	^aReport doForPortfolio: self.! !

!Portfolio methodsFor: 'do' stamp: 'UC 6/2/2021 18:04:19'!
doForEachChildAccount: aReport 
	accounts do: [:account | aReport doForEachChildAccount: account].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'errors' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:23:59'!
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

!ReceptiveAccount methodsFor: 'initialization' stamp: 'UC 6/2/2021 19:50:05'!
initialize

	super initialize.
	transactions := OrderedCollection new.
	name := ''.! !


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


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'do' stamp: 'UC 6/2/2021 18:00:32'!
doFor: aReport
	^aReport doForReceptiveAccount: self.! !

!ReceptiveAccount methodsFor: 'do' stamp: 'UC 6/2/2021 17:56:29'!
doForEachTransaction: aReport
	transactions do: [:transaction | aReport doForEachTransaction: transaction]
	
	
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


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'do' stamp: 'UC 6/2/2021 17:59:24'!
doFor: aReport
	self subclassResponsibility.! !


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


!Deposit methodsFor: 'do' stamp: 'UC 6/2/2021 19:23:42'!
doFor: anOperation
	anOperation doForDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'UC 5/29/2021 23:35:50'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferLeg category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferLeg methodsFor: 'accessing' stamp: 'UC 6/2/2021 19:19:29'!
transfer
	^transfer! !

!TransferLeg methodsFor: 'accessing' stamp: 'UC 6/2/2021 19:19:43'!
value
	^transfer value.! !


!TransferLeg methodsFor: 'initialization' stamp: 'UC 6/2/2021 19:20:02'!
initializeFor: aTransfer
	transfer := aTransfer! !


!TransferLeg methodsFor: 'do' stamp: 'UC 6/2/2021 19:23:21'!
doFor: anOperation
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'Portfolio-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'UC 6/2/2021 19:24:22'!
for: aTransfer
	^self new initializeFor: aTransfer! !

!TransferLeg class methodsFor: 'instance creation' stamp: 'UC 6/2/2021 19:24:14'!
register: aTransfer on: account

	| transaction |
	
	transaction := self for: aTransfer.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #ReceiveLeg category: 'Portfolio-Solucion'!
TransferLeg subclass: #ReceiveLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceiveLeg methodsFor: 'balance' stamp: 'UC 5/29/2021 23:45:21'!
affectBalance: aBalance

	^aBalance + self value ! !


!ReceiveLeg methodsFor: 'do' stamp: 'UC 6/2/2021 19:23:28'!
doFor: anOperation
	anOperation doForReceiveLeg: self.! !


!classDefinition: #SendLeg category: 'Portfolio-Solucion'!
TransferLeg subclass: #SendLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SendLeg methodsFor: 'balance' stamp: 'UC 5/29/2021 23:45:32'!
affectBalance: aBalance

	^aBalance - self value ! !


!SendLeg methodsFor: 'do' stamp: 'UC 6/2/2021 19:23:33'!
doFor: anOperation
	anOperation doForSendLeg: self.! !


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


!Withdraw methodsFor: 'do' stamp: 'UC 6/2/2021 19:23:51'!
doFor: anOperation
	anOperation doForWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'UC 5/29/2021 23:35:54'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Report category: 'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'accounts' stamp: 'UC 6/2/2021 18:43:46'!
doForPortfolio: aPortfolio
	self subclassResponsibility.! !

!Report methodsFor: 'accounts' stamp: 'UC 6/2/2021 18:43:56'!
doForReceptiveAccount: aReceptiveAccount
	self subclassResponsibility.! !


!Report methodsFor: 'transactions' stamp: 'UC 6/2/2021 18:44:11'!
doForDeposit: aTransaction
	self subclassResponsibility.! !

!Report methodsFor: 'transactions' stamp: 'UC 6/2/2021 18:44:29'!
doForReceiveLeg: aTransaction
	self subclassResponsibility.! !

!Report methodsFor: 'transactions' stamp: 'UC 6/2/2021 18:44:38'!
doForSendLeg: aTransaction
	self subclassResponsibility.! !

!Report methodsFor: 'transactions' stamp: 'UC 6/2/2021 18:44:45'!
doForWithdraw: aTransaction
	self subclassResponsibility.! !


!Report methodsFor: 'iterators' stamp: 'UC 6/2/2021 18:45:01'!
doForEachChildAccount: aChildAccount
	self subclassResponsibility.! !

!Report methodsFor: 'iterators' stamp: 'UC 6/2/2021 18:45:09'!
doForEachTransaction: aTransaction
	self subclassResponsibility.! !


!Report methodsFor: 'do' stamp: 'UC 6/2/2021 18:20:19'!
do
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'Portfolio-Solucion'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'as yet unclassified' stamp: 'UC 6/1/2021 19:43:36'!
for: anAccount
	^self new initializeFor: anAccount.! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: 'account summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'transactions' stamp: 'UC 6/2/2021 17:59:54'!
doForDeposit: aTransaction
	summary add: 'Depósito por ' 	, (aTransaction value asString).
	! !

!AccountSummary methodsFor: 'transactions' stamp: 'UC 6/2/2021 18:00:22'!
doForReceiveLeg: aTransaction
	summary add: 'Entrada por transferencia de ' 	, (aTransaction value asString)
	! !

!AccountSummary methodsFor: 'transactions' stamp: 'UC 6/2/2021 18:00:41'!
doForSendLeg: aTransaction
	summary add: 'Salida por transferencia de ' 	, (aTransaction value asString) 
	! !

!AccountSummary methodsFor: 'transactions' stamp: 'UC 6/2/2021 18:00:49'!
doForWithdraw: aTransaction
	summary add: 'Extracción por ', (aTransaction value asString) 
	! !


!AccountSummary methodsFor: 'accounts' stamp: 'UC 6/2/2021 18:03:05'!
doForPortfolio: aPortfolio
	aPortfolio doForEachChildAccount: self.
	! !

!AccountSummary methodsFor: 'accounts' stamp: 'UC 6/2/2021 18:00:32'!
doForReceptiveAccount: aReceptiveAccount
	^aReceptiveAccount doForEachTransaction: self.
	! !


!AccountSummary methodsFor: 'initialization' stamp: 'UC 6/1/2021 18:56:34'!
initializeFor: anAccount
	account := anAccount.
	summary := OrderedCollection new.! !


!AccountSummary methodsFor: 'iterators' stamp: 'UC 6/2/2021 18:03:33'!
doForEachChildAccount: aChildAccount
	^aChildAccount doFor: self.
	! !

!AccountSummary methodsFor: 'iterators' stamp: 'UC 6/2/2021 18:24:52'!
doForEachTransaction: aTransaction
	^aTransaction doFor: self.
	! !


!AccountSummary methodsFor: 'do' stamp: 'UC 6/2/2021 17:58:33'!
do
	account doFor: self.
	summary add: 'Balance = ' 	, (account balance printString).
	^summary! !


!classDefinition: #PortfolioStructure category: 'Portfolio-Solucion'!
Report subclass: #PortfolioStructure
	instanceVariableNames: 'root childName structure tabSize'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioStructure methodsFor: 'indentation - private' stamp: 'UC 6/2/2021 21:03:42'!
decrementTabSize

	^ tabSize := tabSize - 1! !

!PortfolioStructure methodsFor: 'indentation - private' stamp: 'UC 6/2/2021 21:03:32'!
incrementTabSize

	^ tabSize := tabSize + 1! !

!PortfolioStructure methodsFor: 'indentation - private' stamp: 'UC 6/2/2021 20:47:51'!
indent: aString
	|result|
	result:=''.
	tabSize timesRepeat: [	result := '  ', result].
	^result , aString.! !


!PortfolioStructure methodsFor: 'initialization' stamp: 'UC 6/2/2021 20:48:44'!
initializeFor: aPortfolio
	root := aPortfolio.
	tabSize := 0.
	structure := OrderedCollection new.
	! !


!PortfolioStructure methodsFor: 'do' stamp: 'UC 6/2/2021 21:02:57'!
do
	self doForPortfolio: root.
	^structure! !


!PortfolioStructure methodsFor: 'iterators' stamp: 'UC 6/2/2021 20:52:38'!
doForEachChildAccount: aChildAccount
	^aChildAccount doFor: self! !

!PortfolioStructure methodsFor: 'iterators' stamp: 'UC 6/2/2021 21:16:55'!
doForEachTransaction: aTransaction! !


!PortfolioStructure methodsFor: 'accounts' stamp: 'UC 6/2/2021 21:06:02'!
doForPortfolio: aPortfolio
	structure add: (self indent: aPortfolio name).
	
	self incrementTabSize.
	
	aPortfolio doForEachChildAccount: self.
	
	self decrementTabSize.
	! !

!PortfolioStructure methodsFor: 'accounts' stamp: 'UC 6/2/2021 21:22:40'!
doForReceptiveAccount: aReceptiveAccount
	structure add: (self indent: aReceptiveAccount name)! !


!PortfolioStructure methodsFor: 'transactions' stamp: 'UC 6/2/2021 21:17:18'!
doForDeposit: aTransaction! !

!PortfolioStructure methodsFor: 'transactions' stamp: 'UC 6/2/2021 21:17:29'!
doForReceiveLeg: aTransaction! !

!PortfolioStructure methodsFor: 'transactions' stamp: 'UC 6/2/2021 21:17:32'!
doForSendLeg: aTransaction! !

!PortfolioStructure methodsFor: 'transactions' stamp: 'UC 6/2/2021 21:17:25'!
doForWithdraw: aTransaction! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
Report subclass: #TransferNet
	instanceVariableNames: 'account transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'initialization' stamp: 'UC 6/1/2021 19:57:37'!
initializeFor: anAccount
	account := anAccount.
	transferNet := 0.	! !


!TransferNet methodsFor: 'transactions' stamp: 'UC 6/2/2021 17:59:54'!
doForDeposit: aTransaction! !

!TransferNet methodsFor: 'transactions' stamp: 'UC 6/2/2021 18:00:22'!
doForReceiveLeg: aReceiveLeg
	transferNet := aReceiveLeg affectBalance: transferNet! !

!TransferNet methodsFor: 'transactions' stamp: 'UC 6/2/2021 18:00:41'!
doForSendLeg: aSendLeg
	transferNet := aSendLeg affectBalance: transferNet! !

!TransferNet methodsFor: 'transactions' stamp: 'UC 6/2/2021 18:00:49'!
doForWithdraw: aTransaction! !


!TransferNet methodsFor: 'do' stamp: 'UC 6/2/2021 18:01:01'!
do
	^account doFor: self.! !


!TransferNet methodsFor: 'iterators' stamp: 'UC 6/2/2021 18:05:27'!
doForEachChildAccount: aChildAccount
	^aChildAccount doFor: self! !

!TransferNet methodsFor: 'iterators' stamp: 'UC 6/2/2021 18:06:03'!
doForEachTransaction: aTransaction
	^aTransaction doFor: self.! !


!TransferNet methodsFor: 'accounts' stamp: 'UC 6/2/2021 18:05:04'!
doForPortfolio: aPortfolio
	aPortfolio doForEachChildAccount: self.
	^transferNet.! !

!TransferNet methodsFor: 'accounts' stamp: 'UC 6/2/2021 18:05:43'!
doForReceptiveAccount: aReceptiveAccount
	aReceptiveAccount doForEachTransaction: self.
	^transferNet.! !


!classDefinition: #ToDo category: 'Portfolio-Solucion'!
Object subclass: #ToDo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ToDo methodsFor: 'as yet unclassified' stamp: 'UC 6/2/2021 19:00:39'!
Pendientes
	"
	- Pensar si la solucion implementada funcionaria en un lenguaje estaticamente tipado
	- Bonus 
	"
	! !

!ToDo methodsFor: 'as yet unclassified' stamp: 'UC 6/2/2021 17:37:21'!
preguntas
	" - Nombres de los AccountTransaction que actuan como pata.
	Pata es un nombre tecnico
	- Hace falta una subjerarquia? tenemos codigo repetido
	Depende de si aporta o no al modelo. Una buena forma de ver si eso tiene un aporte es si la idea que reifica a ambas AccountTransactions tiene nombre. Solo por sacar codigo repetido no deberiamos hacer una superclase.
	- Tenemos que imprimir un \n al final?
	Podemos... Se hace poniendo enter en el string
	- Puede haber una cuenta sin nombre? Mantenemos ReceptiveAccount new como interfaz publica?
	Si
	- Que onda con imprimir OrderedCollection?
	No es necesario, solo importan los tests.
	
	-Elegir nombre para createReport:
	    perform
	    operate
	    calculate"
	! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'sendLeg receiveLeg value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'instance creation' stamp: 'UC 6/1/2021 18:17:42'!
initializeFrom: sender to: receiver for: _value 
	sendLeg := SendLeg register: self on: sender.
	receiveLeg := ReceiveLeg register: self on: receiver.
	value := _value.! !


!Transfer methodsFor: 'as yet unclassified' stamp: 'UC 5/29/2021 23:55:10'!
receiveLeg
	^receiveLeg! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'UC 5/29/2021 23:55:24'!
sendLeg
	^sendLeg! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'UC 5/29/2021 22:25:47'!
value
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'UC 6/2/2021 18:59:47'!
assert: sender isDifferentFrom: receiver

	^ sender = receiver ifTrue: [self error: self receiverMustBeDifferentFromSender]! !

!Transfer class methodsFor: 'instance creation' stamp: 'UC 6/2/2021 18:54:49'!
assertAmountIsGreaterThan0: amount

	^ amount <= 0 ifTrue: [self error: self transferAmountMustBeGreaterThan0]! !

!Transfer class methodsFor: 'instance creation' stamp: 'UC 6/2/2021 18:59:47'!
from: sender to: receiver for: amount 
	self assert: sender isDifferentFrom: receiver.
	self assertAmountIsGreaterThan0: amount.
	^self new initializeFrom: sender to: receiver for: amount ! !

!Transfer class methodsFor: 'instance creation' stamp: 'UC 6/2/2021 18:58:40'!
receiverMustBeDifferentFromSender
	^'Receiver must be different from sender'! !

!Transfer class methodsFor: 'instance creation' stamp: 'UC 6/2/2021 18:52:50'!
transferAmountMustBeGreaterThan0
	^'Transfer amount must be greater than 0'! !
