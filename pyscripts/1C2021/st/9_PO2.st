!classDefinition: #AccountSummaryTest category: 'Portfolio-Solucion'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'GR 6/3/2021 16:54:12'!
test01EmptyReceptiveAccountSummaryHasBalanceOnly

	|account report|
	
	account := ReceptiveAccount new.
	
	report := account accountSummary.
	
	self assert: report includes: 'Balance = 0'! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'GR 6/3/2021 17:03:14'!
test02AccountSummaryGivesCorrectBalance

	|account report|
	
	account := ReceptiveAccount new.
	
	Deposit register: 100 on: account.
	
	report := (AccountSummary for: account) generateReport.
	
	
	
	self assert: report includes: 'Balance = 100'! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'GR 6/3/2021 17:03:33'!
test03AccountSummaryShowsDepositLines

	|account report|
	
	account := ReceptiveAccount new.
	
	Deposit register: 100 on: account.
	
	Deposit register: 200 on: account.
	
	report := (AccountSummary for: account) generateReport.
	
	self assert: report includes: 'Deposito por 100'.

	self assert: report includes: 'Deposito por 200'.! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'GR 6/3/2021 17:03:38'!
test04AccountShowsWithdrawLine

	|account report|
	
	account := ReceptiveAccount new.
	
	Withdraw register: 200 on: account.
	
	report := (AccountSummary for: account) generateReport.

	self assert: report includes: 'Extraccion por 200'.! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'GR 6/3/2021 17:03:43'!
test05AccountSummaryShowsOutgoingTransferLeg

	|account report|
	
	account := ReceptiveAccount new.
	
	Transfer register: 100 from: account to: ReceptiveAccount new.
	
	report := (AccountSummary for: account) generateReport.
	
	self assert: report includes: 'Salida por transferencia de 100'.! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'GR 6/3/2021 17:03:50'!
test06AccountSummaryShowsIncomingTransferLeg

	|account report|
	
	account := ReceptiveAccount new.
	
	Transfer register: 100 from: ReceptiveAccount new to: account.
	
	report := (AccountSummary for: account) generateReport.
	
	self assert: report includes: 'Entrada por transferencia de 100'.! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'GR 6/3/2021 17:04:32'!
test07EmptyPortfolioSummaryHasBalanceOnly

	| portfolio report  |
	
	portfolio := Portfolio new.
	
	report := (AccountSummary for: portfolio) generateReport.
	
	self assert: report includes: 'Balance = 0'! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'GR 6/3/2021 17:04:57'!
test08PortfolioSummaryDoesNotShowAccountBalance

	| portfolio account summary |
	
	account := ReceptiveAccount new.
	
	Deposit register: 100 on: account .
	
	portfolio := Portfolio new.
	
	portfolio add: account .
		
	summary := (AccountSummary for: portfolio) generateReport.
	
	self deny: (summary includes: 'Balance = 0').
	
	self assert: summary includes: 'Deposito por 100'.
	
	self assert: summary includes: 'Balance = 100'.! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'GR 6/3/2021 17:05:12'!
test09NotEmptyPortfolioShowsTransactionsAndPortfolioBalance

	| portfolio account1 account2 summary |
	
	account1 := ReceptiveAccount new.
	
	Deposit register: 100 on: account1 .
	
	account2 := ReceptiveAccount new.
	
	Deposit register: 200 on: account2 .
	
	portfolio := Portfolio new.
	
	portfolio add: account1 .
	
	portfolio add: account2 .
	
	summary := (AccountSummary for: portfolio) generateReport.
		
	self assert: summary includes: 'Deposito por 100'.
	
	self assert: summary includes: 'Deposito por 200'.
	
	self assert: summary includes: 'Balance = 300'.! !


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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'GR 6/3/2021 16:04:33'!
test08IncomingTransferIncreasesBalance

	|account|
	
	account := ReceptiveAccount new.
	
	Transfer register: 100 from: ReceptiveAccount new to: account.
	
	self assert: 100 equals: account balance! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'GR 6/3/2021 16:05:04'!
test09OutgoingTransferDecreasesBalance

	|account|
	
	account := ReceptiveAccount new.
	
	Transfer register: 100 from: account to: ReceptiveAccount new.
		
	self assert: -100 equals: account balance! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'GR 6/3/2021 16:05:42'!
test10OutgoingTransferLegIsRegistered

	|account transfer|
	
	account := ReceptiveAccount new.
	
	transfer := Transfer register: 100 from: account to: ReceptiveAccount new.
	
	self assert: (account hasRegistered: transfer outgoingLeg).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'GR 6/3/2021 16:05:59'!
test11IncomingTransferLegIsRegistered

	|account transfer|
	
	account := ReceptiveAccount new.
	
	transfer := Transfer register: 100 from: ReceptiveAccount new to: account.
	
	self assert: (account hasRegistered: transfer incomingLeg).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'GR 6/3/2021 16:09:02'!
test12CanMoveFromOutgoingLegToIncomingLeg

	|account transfer incomingLeg outgoingLeg|
	
	account := ReceptiveAccount new.
	
	transfer := Transfer register: 100 from: account to: ReceptiveAccount new.
	
	outgoingLeg := transfer outgoingLeg.
	
	incomingLeg := transfer incomingLeg.
	
	self assert: incomingLeg equals: outgoingLeg transfer incomingLeg .! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'GR 6/3/2021 16:09:52'!
test13CanMoveFromIncomingLegToOutgoingLeg

	|account transfer incomingLeg outgoingLeg|
	
	account := ReceptiveAccount new.
	
	transfer := Transfer register: 100 from: account to: ReceptiveAccount new.
	
	outgoingLeg := transfer outgoingLeg.
	
	incomingLeg := transfer incomingLeg.
	
	self assert: outgoingLeg equals: incomingLeg transfer outgoingLeg .! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'GR 6/3/2021 16:10:12'!
test14TransferValueIsStoredOnce

	|account transfer outgoingLeg incomingLeg|
	
	account := ReceptiveAccount new.
	
	transfer := Transfer register: 1/3 from: ReceptiveAccount new to: account .
	
	outgoingLeg := transfer outgoingLeg.
	
	incomingLeg := transfer incomingLeg.
	
	self assert: (outgoingLeg value == incomingLeg value)
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'GR 6/3/2021 16:59:23'!
test15CannotTransferToSelf

	| account |
	
	account := ReceptiveAccount new.
	
	self 
		should: [Transfer register: 100 from: account to: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer canNotTransferToSameAccount equals: anError messageText.
			self assert: 0 equals: account transactions size.]! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'GR 6/3/2021 16:59:30'!
test16TransferAmountHasToBeGreaterThanZero

	| account |
	
	account := ReceptiveAccount new.
	
	self 
		should: [Transfer register: -100 from: ReceptiveAccount new to: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer amountHasToBeGreaterThanZero equals: anError messageText.
			self assert: 0 equals: account transactions size.]! !


!classDefinition: #TransferNetTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'GR 6/3/2021 17:06:27'!
test01EmptyAccountTransferNetIsZero

	|account transferNet|
	
	account := ReceptiveAccount new.
	
	transferNet := (TransferNet for: account ) generateReport.
	
	self assert: 0 equals: transferNet.! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'GR 6/3/2021 17:06:43'!
test02AccountWithIncomingTransfersGetsCorrectTransferNet

	|account transferNet |
	
	account := ReceptiveAccount new.
	
	Transfer register: 200 from: ReceptiveAccount new to: account.
	
	Transfer register: 100 from: ReceptiveAccount new to: account.
	
	transferNet := (TransferNet for: account ) generateReport.
	
	self assert: 300 equals: transferNet 
	
	! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'GR 6/3/2021 17:06:55'!
test03AccountWithOutgoingTransferGetsGetsNegativeTransferNet

	|account transferNet |
	
	account := ReceptiveAccount new.
	
	Transfer register: 100 from: account to: ReceptiveAccount new.
	
	transferNet := (TransferNet for: account ) generateReport.
	
	self assert: -100 equals: transferNet 
	
	! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'GR 6/3/2021 17:07:07'!
test04DepositsDoNotAffectTransferNet

	|account transferNet |
	
	account := ReceptiveAccount new.
	
	Transfer register: 100 from: account to: ReceptiveAccount new.
	
	Deposit register: 100 on: account .
	
	transferNet := (TransferNet for: account ) generateReport.
	
	self assert: -100 equals: transferNet 
	
	! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'GR 6/3/2021 17:07:30'!
test05WithdrawDoNotAffectTransferNet

	|account transferNet |
	
	account := ReceptiveAccount new.
	
	Transfer register: 100 from: account to: ReceptiveAccount new.
	
	Withdraw register: 100 on: account .
	
	transferNet := (TransferNet for: account ) generateReport.
	
	self assert: -100 equals: transferNet 
	
	! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'GR 6/3/2021 17:07:43'!
test06EmptyPortfolioTransferNetIsZero

	| portfolio transferNet |
	
	portfolio := Portfolio new.
	
	transferNet := (TransferNet for: portfolio ) generateReport.
	
	
	self assert: 0 equals: transferNet.! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'GR 6/3/2021 17:08:04'!
test07PortfolioWithTransferShowsCorrectTransferNet

	| portfolio account transferNet |
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	
	Transfer 	register: 100 from: ReceptiveAccount new to: account .
	
	Transfer 	register: 200 from: ReceptiveAccount new to: account .
	
	portfolio add: account .
	
	transferNet := (TransferNet for: portfolio ) generateReport.
	
	self assert: 300 equals: transferNet.! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'GR 6/3/2021 17:09:17'!
test08PortfolioWithMultipleAccountsShowsCorrectTransferNet

	| portfolio account1 account2 transferNet |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	
	Transfer 	register: 100 from: ReceptiveAccount new to: account1 .
	
	account2 := ReceptiveAccount new.
	
	Transfer 	register: 200 from: ReceptiveAccount new to: account2 .
	
	
	portfolio add: account1 .
	
	portfolio add: account2 .
	
	transferNet := (TransferNet for: portfolio ) generateReport.
	
	self assert: 300 equals: transferNet.! !


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


!Account methodsFor: 'report' stamp: 'GR 6/3/2021 16:35:23'!
generateReport: aReport

	^self subclassResponsibility .! !


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


!Portfolio methodsFor: 'reports' stamp: 'GR 6/3/2021 15:41:02'!
accountSummary
	| summary |
	
	summary := AccountSummary for: self.
	
	^summary generateReport! !

!Portfolio methodsFor: 'reports' stamp: 'GR 6/3/2021 16:35:23'!
generateReport: aReport

	accounts do: [:anAccount | anAccount affectReport: aReport].

	! !

!Portfolio methodsFor: 'reports' stamp: 'GR 6/3/2021 16:47:12'!
transferNet
	| transferNet |
	
	transferNet := TransferNet for: self.
	
	^transferNet generateReport! !

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


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'GR 6/3/2021 15:25:31'!
accountSummary
	
	| summary |
	
	summary := AccountSummary for: self.
	
	^summary generateReport
	
	! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'GR 6/3/2021 16:50:19'!
affectReport: aReport

	aReport affectReportWithReceptiveAccount: self.
	

	! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'GR 6/3/2021 16:35:23'!
generateReport: aReport

	transactions do: [:aTransaction | aTransaction affectReport: aReport ].
	

	! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'GR 6/3/2021 16:46:17'!
transferNet
	| transferNet |
	
	transferNet := TransferNet for: self.
	
	^transferNet generateReport! !


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


!AccountTransaction methodsFor: 'report' stamp: 'GR 6/3/2021 16:32:37'!
affectReport: aReport

	^self subclassResponsibility ! !

!AccountTransaction methodsFor: 'report' stamp: 'GR 6/3/2021 13:16:40'!
affectTransferNet: aTransferNet

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


!Deposit methodsFor: 'reports' stamp: 'GR 6/3/2021 13:25:46'!
accountSummaryLine

	^'Deposito por ', self value asString
		! !

!Deposit methodsFor: 'reports' stamp: 'GR 6/3/2021 16:32:37'!
affectReport: aReport

	^aReport affectReportWithDeposit: self.
		! !

!Deposit methodsFor: 'reports' stamp: 'GR 6/3/2021 13:17:01'!
affectTransferNet: aTransferNet

	^aTransferNet ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLeg category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferLeg methodsFor: 'initialization' stamp: 'GR 6/3/2021 13:07:31'!
initializeFromTransfer: aTransfer 
	transfer := aTransfer.! !


!TransferLeg methodsFor: 'accessing' stamp: 'GR 5/31/2021 16:45:33'!
transfer

	^transfer! !

!TransferLeg methodsFor: 'accessing' stamp: 'GR 6/3/2021 13:04:44'!
value

	^transfer value ! !


!TransferLeg methodsFor: 'balance' stamp: 'GR 6/3/2021 13:18:25'!
affectBalance: aBalance

	self subclassResponsibility ! !


!TransferLeg methodsFor: 'reports' stamp: 'GR 6/3/2021 13:26:16'!
accountSummaryLine

	^self subclassResponsibility ! !

!TransferLeg methodsFor: 'reports' stamp: 'GR 6/3/2021 16:32:37'!
affectReport: aReport

	^self subclassResponsibility ! !

!TransferLeg methodsFor: 'reports' stamp: 'GR 6/3/2021 13:18:17'!
affectTransferNet: aTransferNet

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'Portfolio-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'GR 6/3/2021 13:07:14'!
fromTransfer: aTransfer 
	
	^self new initializeFromTransfer: aTransfer.! !


!classDefinition: #IncomingTransferLeg category: 'Portfolio-Solucion'!
TransferLeg subclass: #IncomingTransferLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!IncomingTransferLeg methodsFor: 'balance' stamp: 'GR 6/3/2021 13:08:13'!
affectBalance: aBalance

	^aBalance + self value.! !


!IncomingTransferLeg methodsFor: 'reports' stamp: 'GR 6/3/2021 13:26:43'!
accountSummaryLine

	^'Entrada por transferencia de ', self value asString! !

!IncomingTransferLeg methodsFor: 'reports' stamp: 'GR 6/3/2021 16:32:37'!
affectReport: aReport

	^aReport affectReportWithIncomingTransferLeg: self
		! !

!IncomingTransferLeg methodsFor: 'reports' stamp: 'GR 6/3/2021 13:17:22'!
affectTransferNet: aTransferNet

	^aTransferNet + self value.! !


!classDefinition: #OutgoingTransferLeg category: 'Portfolio-Solucion'!
TransferLeg subclass: #OutgoingTransferLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!OutgoingTransferLeg methodsFor: 'balance' stamp: 'GR 6/3/2021 13:08:20'!
affectBalance: aBalance

	^aBalance - self value.! !


!OutgoingTransferLeg methodsFor: 'reports' stamp: 'GR 6/3/2021 13:27:13'!
accountSummaryLine

	^'Salida por transferencia de ', self value asString! !

!OutgoingTransferLeg methodsFor: 'reports' stamp: 'GR 6/3/2021 16:32:37'!
affectReport: aReport

	^aReport affectReportWithOutgoingTransferLeg: self.
		! !

!OutgoingTransferLeg methodsFor: 'reports' stamp: 'GR 6/3/2021 13:17:38'!
affectTransferNet: aTransferNet

	^aTransferNet - self value.! !


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


!Withdraw methodsFor: 'reports' stamp: 'GR 6/3/2021 13:27:35'!
accountSummaryLine

	^'Extraccion por ', self value asString! !

!Withdraw methodsFor: 'reports' stamp: 'GR 6/3/2021 16:32:37'!
affectReport: aReport

	^aReport affectReportWithWithdraw: self
		! !

!Withdraw methodsFor: 'reports' stamp: 'GR 6/3/2021 13:17:56'!
affectTransferNet: aTransferNet

	^aTransferNet! !

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

!Report methodsFor: 'transactions' stamp: 'GR 6/3/2021 16:30:52'!
affectReportWithDeposit: aDeposit

	^self subclassResponsibility ! !

!Report methodsFor: 'transactions' stamp: 'GR 6/3/2021 16:31:19'!
affectReportWithIncomingTransferLeg: anIncomingTransferLeg

	^self subclassResponsibility ! !

!Report methodsFor: 'transactions' stamp: 'GR 6/3/2021 16:31:32'!
affectReportWithOutgoingTransferLeg: anOutgoingTransferLeg

	^self subclassResponsibility ! !

!Report methodsFor: 'transactions' stamp: 'GR 6/3/2021 16:31:45'!
affectReportWithWithdraw: aWithdraw

	^self subclassResponsibility ! !


!Report methodsFor: 'report generation' stamp: 'GR 6/3/2021 16:41:21'!
generateReport

	^self subclassResponsibility ! !


!Report methodsFor: 'accounts' stamp: 'GR 6/3/2021 16:49:46'!
affectReportWithReceptiveAccount: aReceptiveAccount

	^self subclassResponsibility ! !


!Report methodsFor: 'initialization' stamp: 'GR 6/3/2021 16:41:31'!
initializeFor: anAccount

	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'Portfolio-Solucion'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'instance creation' stamp: 'GR 6/3/2021 16:42:24'!
for: anAccount

	^self subclassResponsibility ! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: 'account summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'report lines' stamp: 'GR 6/3/2021 15:40:22'!
addBalanceLine

	summary add: 'Balance = ', account balance asString.! !

!AccountSummary methodsFor: 'report lines' stamp: 'GR 6/3/2021 16:30:52'!
affectReportWithDeposit: aDeposit

	summary add: 'Deposito por ', aDeposit value asString! !

!AccountSummary methodsFor: 'report lines' stamp: 'GR 6/3/2021 16:31:19'!
affectReportWithIncomingTransferLeg: anIncomingTransferLeg

	summary add: 'Entrada por transferencia de ', anIncomingTransferLeg value asString

	! !

!AccountSummary methodsFor: 'report lines' stamp: 'GR 6/3/2021 16:31:32'!
affectReportWithOutgoingTransferLeg: anOutgoingTransferLeg

	summary add: 'Salida por transferencia de ', anOutgoingTransferLeg value asString

! !

!AccountSummary methodsFor: 'report lines' stamp: 'GR 6/3/2021 16:49:24'!
affectReportWithReceptiveAccount: aReceptiveAccount

	aReceptiveAccount generateReport: self.
	
	! !

!AccountSummary methodsFor: 'report lines' stamp: 'GR 6/3/2021 16:31:45'!
affectReportWithWithdraw: aWithdraw

	summary add: 'Extraccion por ', aWithdraw value asString! !

!AccountSummary methodsFor: 'report lines' stamp: 'GR 6/3/2021 16:35:23'!
receptiveAccountLines: aReceptiveAccount

	aReceptiveAccount generateReport: self.
	
	! !


!AccountSummary methodsFor: 'report generation' stamp: 'GR 6/3/2021 16:35:24'!
generateReport

	account generateReport: self.
	
	self addBalanceLine.
	
	^summary ! !


!AccountSummary methodsFor: 'initialization' stamp: 'GR 6/3/2021 15:18:51'!
initializeFor: anAccount

	account := anAccount.
	
	summary := OrderedCollection new.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'GR 6/3/2021 15:17:52'!
for: anAccount

	^self new initializeFor: anAccount! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
Report subclass: #TransferNet
	instanceVariableNames: 'account net'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'transactions' stamp: 'GR 6/3/2021 16:39:10'!
affectReportWithDeposit: aDeposit! !

!TransferNet methodsFor: 'transactions' stamp: 'GR 6/3/2021 16:40:05'!
affectReportWithIncomingTransferLeg: anIncomingTransferLeg

	net := net + anIncomingTransferLeg value.! !

!TransferNet methodsFor: 'transactions' stamp: 'GR 6/3/2021 16:40:29'!
affectReportWithOutgoingTransferLeg: anOutgoingTransferLeg

	net := net - anOutgoingTransferLeg value.! !

!TransferNet methodsFor: 'transactions' stamp: 'GR 6/3/2021 16:39:27'!
affectReportWithWithdraw: aWithdraw! !


!TransferNet methodsFor: 'initialization' stamp: 'GR 6/3/2021 16:38:08'!
initializeFor: anAccount

	account := anAccount .
	net := 0.! !


!TransferNet methodsFor: 'account' stamp: 'GR 6/3/2021 16:45:22'!
affectReportWithReceptiveAccount: aReceptiveAccount

	aReceptiveAccount generateReport: self.

! !


!TransferNet methodsFor: 'report generation' stamp: 'GR 6/3/2021 16:44:42'!
generateReport

	account generateReport: self.
	
	^net
	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'Portfolio-Solucion'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'instance creation' stamp: 'GR 6/3/2021 16:37:28'!
for: anAccount

	^self new initializeFor: anAccount.! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'outgoing value incoming'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'GR 5/31/2021 16:24:55'!
incomingLeg

	^incoming! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'GR 6/3/2021 13:06:51'!
initializeFor: anAmount from: aSenderAccount to: aReceivingAccount

	value := anAmount .

	outgoing := OutgoingTransferLeg fromTransfer: self.
	
	aSenderAccount register: outgoing.
	
	incoming := IncomingTransferLeg fromTransfer: self.
	
	aReceivingAccount register: incoming.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'GR 5/31/2021 16:22:59'!
outgoingLeg

	^outgoing! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'GR 6/3/2021 13:04:57'!
value

	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'GR 6/3/2021 16:02:54'!
amountHasToBeGreaterThanZero
	^'Transfer amount must be greater than 0'! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'GR 6/3/2021 15:59:17'!
canNotTransferToSameAccount
	^'Cannot transfer to same account'! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'GR 6/3/2021 16:02:20'!
register: anAmount from: aSenderAccount to: aReceivingAccount

	(aSenderAccount == aReceivingAccount ) ifTrue: [self error: self canNotTransferToSameAccount].
	(anAmount > 0) ifFalse: [self error: self amountHasToBeGreaterThanZero].

	^self new initializeFor: anAmount from: aSenderAccount to: aReceivingAccount .
	
	
	
	! !
