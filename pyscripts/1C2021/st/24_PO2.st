!classDefinition: #AccountSummaryTest category: 'Portfolio-Ejercicio-2'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio-2'!

!AccountSummaryTest methodsFor: 'many' stamp: 'AW 6/3/2021 01:04:37'!
test06SummaryWithTwoTransactionShouldHaveBoth

	| account report |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	report := (AccountSummary for: account) createReport.
		
	self assert: 3 equals: report size .
	self assert: 'Depósito por 100.' equals: report first .
	self assert: 'Extracción por 50.' equals: report second .
	self assert: 'Balance = 50.' equals: report third .
! !

!AccountSummaryTest methodsFor: 'many' stamp: 'AW 6/3/2021 01:05:05'!
test07SummaryWithMultipleTransactionsShouldHaveAllOfThem

	| account anotherAccount report |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	Transfer amount: 30 from: anotherAccount to: account.
	Transfer amount: 20 from: account to: anotherAccount.
		
	report := (AccountSummary for: account) createReport.
		
	self assert: 5 equals: report size .
	self assert: 'Depósito por 100.' equals: report first .
	self assert: 'Extracción por 50.' equals: report second .
	self assert: 'Entrada por transferencia de 30.' equals: report third .
	self assert: 'Salida por transferencia de 20.' equals: report fourth .
	self assert: 'Balance = 60.' equals: report fifth .
! !


!AccountSummaryTest methodsFor: 'one' stamp: 'AW 6/3/2021 01:02:01'!
test02SummaryWithADepositShouldHaveALineForDeposit
	| account report |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
		
	report := (AccountSummary for: account) createReport.
		
	self assert: 2 equals: report size .
	self assert: 'Depósito por 100.' equals: report first .
	self assert: 'Balance = 100.' equals: report second .
! !

!AccountSummaryTest methodsFor: 'one' stamp: 'AW 6/3/2021 01:02:59'!
test03SummaryWithWithdrawShouldHaveALineForWithdraw
	| account report |
	
	account := ReceptiveAccount new.
	Withdraw register: 50 on: account.
		
	report := (AccountSummary for: account) createReport.
		
	self assert: 2 equals: report size .
	self assert: 'Extracción por 50.' equals: report first .
	self assert: 'Balance = -50.' equals: report second .
! !

!AccountSummaryTest methodsFor: 'one' stamp: 'AW 6/3/2021 01:03:30'!
test04SummaryWithAnIncomingTransactionShouldHaveALineForIt

	| account report anotherAccount |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Transfer amount: 30 from: anotherAccount to: account.
		
	report := (AccountSummary for: account) createReport.
		
	self assert: 2 equals: report size .
	self assert: 'Entrada por transferencia de 30.' equals: report first .
	self assert: 'Balance = 30.' equals: report second .
! !

!AccountSummaryTest methodsFor: 'one' stamp: 'AW 6/3/2021 01:03:55'!
test05SummaryWithOutgoingTransactionShouldHaveALineForIt

	| account report anotherAccount |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Transfer amount: 20 from: account to: anotherAccount.
		
	report := (AccountSummary for: account) createReport.
		
	self assert: 2 equals: report size .
	self assert: 'Salida por transferencia de 20.' equals: report first .
	self assert: 'Balance = -20.' equals: report second .
! !


!AccountSummaryTest methodsFor: 'empty' stamp: 'AW 6/3/2021 01:01:04'!
test01SummaryWithNoTransactionsOnlyHastBalanceLine

	| account report |
	
	account := ReceptiveAccount new.
		
	report := (AccountSummary for: account) createReport.
		
	self assert: 1 equals: report size .
	self assert: 'Balance = 0.' equals: report first .
! !


!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio-2'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio-2'!

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


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio-2'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio-2'!

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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AW 6/3/2021 02:39:56'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) amount
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


!classDefinition: #TransferNetTest category: 'Portfolio-Ejercicio-2'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio-2'!

!TransferNetTest methodsFor: 'empty' stamp: 'AW 6/3/2021 02:41:56'!
test01TransferNetForEmptyAccountIsZero

	| account report |
	
	account := ReceptiveAccount new.
		
	report := (TransferNet for: account) createReport.
		

	self assert: 0 equals: report .

! !


!TransferNetTest methodsFor: 'many' stamp: 'AW 6/3/2021 02:45:06'!
test04TransferNetForAPortfolioWithOnlyInternalTransactionsIsZero

	| portfolio account anotherAccount report |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	portfolio := Portfolio with: account with: anotherAccount.
	
	Transfer amount: 42 from: anotherAccount to: account.
		
	report := (TransferNet for: portfolio) createReport.		

	self assert: 0 equals: report .

! !

!TransferNetTest methodsFor: 'many' stamp: 'AW 6/3/2021 02:49:24'!
test05TransferNetWithMultipleTransactionsIsTheSumOfTheAmounts

	| portfolio account anotherAccount report |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	Transfer amount: 131 from: anotherAccount to: account.
	Transfer amount: 222 from: anotherAccount to: account.
	Transfer amount: 313 from: anotherAccount to: account.
		
	report := (TransferNet for: portfolio) createReport.		

	self assert: 666 equals: report .

! !


!TransferNetTest methodsFor: 'one' stamp: 'AW 6/3/2021 02:42:26'!
test02TransferNetForAccountWithOneOutgoingTransactionIsTheAmountOfIt

	| account anotherAccount report |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Transfer amount: 42 from: account to: anotherAccount.
		
	report := (TransferNet for: account) createReport.		

	self assert: -42 equals: report .

! !

!TransferNetTest methodsFor: 'one' stamp: 'AW 6/3/2021 02:43:01'!
test03TransferNetForAccountWithOneIncomingTransactionIsTheAmountOfIt

	| account anotherAccount report |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Transfer amount: 42 from: anotherAccount to: account.
		
	report := (TransferNet for: account) createReport.		

	self assert: 42 equals: report .

! !


!TransferNetTest methodsFor: 'irrelevant transactions' stamp: 'AW 6/3/2021 02:49:28'!
test06TransferNetIsNotAffectedByDeposits

	| account anotherAccount report |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Transfer amount: 42 from: anotherAccount to: account.
	Deposit register: 20 on: account.
		
	report := (TransferNet for: account) createReport.		

	self assert: 42 equals: report .

! !

!TransferNetTest methodsFor: 'irrelevant transactions' stamp: 'AW 6/3/2021 02:49:35'!
test07TransferNetIsNotAffectedByWithdraws

	| account anotherAccount report |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Transfer amount: 42 from: anotherAccount to: account.
	Withdraw register: 20 on: account.
		
	report := (TransferNet for: account) createReport.		

	self assert: 42 equals: report .

! !


!classDefinition: #TransferTest category: 'Portfolio-Ejercicio-2'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio-2'!

!TransferTest methodsFor: 'leg navigation' stamp: 'nz 6/2/2021 23:32:23'!
test03TransferCanRetrieveTheReceiver

	| senderAccount receiverAccount transfer |
	
	senderAccount := ReceptiveAccount  new.
	receiverAccount := ReceptiveAccount  new.
	
	transfer := Transfer amount: 100 from: senderAccount to: receiverAccount.
	
	self assert: transfer receiver equals: receiverAccount.

! !

!TransferTest methodsFor: 'leg navigation' stamp: 'nz 6/2/2021 23:33:15'!
test05TransferCanRetrieveTheSender

	| senderAccount receiverAccount transfer |
	
	senderAccount := ReceptiveAccount  new.
	receiverAccount := ReceptiveAccount  new.
	
	transfer := Transfer amount: 100 from: senderAccount to: receiverAccount.
	
	self assert: transfer sender equals: senderAccount.! !

!TransferTest methodsFor: 'leg navigation' stamp: 'nz 6/2/2021 23:35:57'!
test06IncomingTransactionCanRetrieveTheSender

	| senderAccount receiverAccount |
	
	senderAccount := ReceptiveAccount  new.
	receiverAccount := ReceptiveAccount  new.
	
	Transfer amount: 100 from: senderAccount to: receiverAccount.
	
	self assert: receiverAccount transactions first sender equals: senderAccount.

! !

!TransferTest methodsFor: 'leg navigation' stamp: 'nz 6/2/2021 23:37:17'!
test07OutgoingTransactionCanRetrieveTheReceiver

	| senderAccount receiverAccount |
	
	senderAccount := ReceptiveAccount  new.
	receiverAccount := ReceptiveAccount  new.
	
	Transfer amount: 100 from: senderAccount to: receiverAccount.
	
	self assert: senderAccount transactions first receiver equals: receiverAccount .

! !


!TransferTest methodsFor: 'transaction registration' stamp: 'nz 6/2/2021 23:31:23'!
test02TransferRegistersAnOutgoingTransactionInSenderAccount

	| senderAccount receiverAccount transfer |
	
	senderAccount := ReceptiveAccount  new.
	receiverAccount := ReceptiveAccount  new.
	
	transfer := Transfer amount: 100 from: senderAccount to: receiverAccount.
	
	self assert: (senderAccount hasRegistered: transfer outgoingTransaction).

! !

!TransferTest methodsFor: 'transaction registration' stamp: 'nz 6/2/2021 23:32:57'!
test04TransferRegistersAnIncomingTransactionInReceiverAccount

	| senderAccount receiverAccount transfer |
	
	senderAccount := ReceptiveAccount  new.
	receiverAccount := ReceptiveAccount  new.
	
	transfer := Transfer amount: 100 from: senderAccount to: receiverAccount.
	
	self assert: (receiverAccount hasRegistered: transfer incomingTransaction).

! !


!TransferTest methodsFor: 'balance' stamp: 'nz 6/2/2021 23:30:05'!
test01TransferAffectsBothBalances

	| senderAccount receiverAccount |
	
	senderAccount := ReceptiveAccount  new.
	receiverAccount := ReceptiveAccount  new.
	
	Transfer amount: 100 from: senderAccount to: receiverAccount.
		
	self assert: -100 equals: senderAccount balance .
	self assert: 100 equals: receiverAccount balance .
! !


!TransferTest methodsFor: 'validations' stamp: 'nz 6/2/2021 23:37:45'!
test08TransferWithNegativeAmountShouldRaiseError

	| senderAccount receiverAccount |
	
	senderAccount := ReceptiveAccount  new.
	receiverAccount := ReceptiveAccount  new.
	
	self
		should: [Transfer amount: -100 from: senderAccount to: receiverAccount.] 
		raise: Error
		description: Transfer transferAmountMustBePositiveErrorDescription.
	


! !

!TransferTest methodsFor: 'validations' stamp: 'nz 6/2/2021 23:38:18'!
test09ZeroAmountTransferShouldRaiseError

	| senderAccount receiverAccount |
	
	senderAccount := ReceptiveAccount  new.
	receiverAccount := ReceptiveAccount  new.
	
	self
		should: [Transfer amount: 0 from: senderAccount to: receiverAccount.] 
		raise: Error
		description: Transfer transferAmountMustBePositiveErrorDescription.
	


! !

!TransferTest methodsFor: 'validations' stamp: 'nz 6/2/2021 23:39:46'!
test10SelfTransferShouldRaiseError

	| senderAccount receiverAccount |
	
	senderAccount := ReceptiveAccount  new.
	receiverAccount := senderAccount.
	
	self
		should: [Transfer amount: 100 from: senderAccount to: receiverAccount.] 
		raise: Error
		description: Transfer transferReceiverAndSenderCannotBeTheSameErrorDescription.
	


! !


!classDefinition: #Account category: 'Portfolio-Ejercicio-2'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio-2'!

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


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio-2'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio-2'!

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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio-2'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'HAW 5/25/2019 11:48:55'!
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


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio-2'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio-2'!

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


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio-2'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio-2'!

!AccountTransaction methodsFor: 'amount' stamp: 'AW 6/3/2021 02:39:56'!
amount 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'visit' stamp: 'AW 6/3/2021 02:07:43'!
visit: aVisitor
	self subclassResponsibility.! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio-2'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio-2'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio-2'!

!Deposit methodsFor: 'initialization' stamp: 'AW 6/3/2021 02:40:47'!
initializeFor: aValue

	amount := aValue ! !


!Deposit methodsFor: 'amount' stamp: 'AW 6/3/2021 02:40:47'!
amount

	^ amount! !


!Deposit methodsFor: 'balance' stamp: 'AW 6/3/2021 02:40:47'!
affectBalance: aBalance

	^aBalance + amount ! !


!Deposit methodsFor: 'visit' stamp: 'AW 6/3/2021 02:15:18'!
visit: aVisitor

	aVisitor visitDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio-2'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #IncomingTransaction category: 'Portfolio-Ejercicio-2'!
AccountTransaction subclass: #IncomingTransaction
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio-2'!

!IncomingTransaction methodsFor: 'initialization' stamp: 'AW 6/1/2021 00:22:08'!
initializeFor: aTransfer 
	
	transfer := aTransfer.! !


!IncomingTransaction methodsFor: 'transfer' stamp: 'AW 6/1/2021 00:24:38'!
sender
	^transfer sender .! !


!IncomingTransaction methodsFor: 'balance' stamp: 'AW 6/1/2021 00:22:16'!
affectBalance: aBalance

	^aBalance + transfer amount.! !


!IncomingTransaction methodsFor: 'amount' stamp: 'AW 6/1/2021 00:22:08'!
amount

	^transfer amount.! !


!IncomingTransaction methodsFor: 'visit' stamp: 'AW 6/3/2021 02:08:26'!
visit: aVisitor
	
	aVisitor visitIncomingTransaction: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IncomingTransaction class' category: 'Portfolio-Ejercicio-2'!
IncomingTransaction class
	instanceVariableNames: ''!

!IncomingTransaction class methodsFor: 'instance creation' stamp: 'AW 6/1/2021 00:24:10'!
for: aTransfer
	| incomingTransaction |
	
	incomingTransaction _ self new initializeFor: aTransfer.
	aTransfer receiver register: incomingTransaction.
	^incomingTransaction.! !


!classDefinition: #OutgoingTransaction category: 'Portfolio-Ejercicio-2'!
AccountTransaction subclass: #OutgoingTransaction
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio-2'!

!OutgoingTransaction methodsFor: 'initialization' stamp: 'AW 6/1/2021 00:03:14'!
initializeFor: aTransfer 
	
	transfer := aTransfer.! !


!OutgoingTransaction methodsFor: 'transfer' stamp: 'AW 6/1/2021 00:25:40'!
receiver
	^transfer receiver.! !


!OutgoingTransaction methodsFor: 'balance' stamp: 'AW 6/1/2021 00:06:39'!
affectBalance: aBalance

	^aBalance - transfer amount.! !


!OutgoingTransaction methodsFor: 'amount' stamp: 'AW 6/1/2021 00:09:56'!
amount

	^transfer amount.! !


!OutgoingTransaction methodsFor: 'visit' stamp: 'AW 6/3/2021 02:08:49'!
visit: aVisitor
	
	aVisitor visitOutgoingTransaction: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OutgoingTransaction class' category: 'Portfolio-Ejercicio-2'!
OutgoingTransaction class
	instanceVariableNames: ''!

!OutgoingTransaction class methodsFor: 'instance creation' stamp: 'AW 5/31/2021 23:55:07'!
for: aTransfer
	| outgoingTransaction |
	
	outgoingTransaction _ self new initializeFor: aTransfer.
	aTransfer sender register: outgoingTransaction.
	^outgoingTransaction.! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio-2'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio-2'!

!Withdraw methodsFor: 'initialization' stamp: 'AW 6/3/2021 02:40:52'!
initializeFor: aValue

	amount := aValue ! !


!Withdraw methodsFor: 'amount' stamp: 'AW 6/3/2021 02:40:52'!
amount

	^ amount! !


!Withdraw methodsFor: 'balance' stamp: 'AW 6/3/2021 02:40:52'!
affectBalance: aBalance

	^aBalance - amount! !


!Withdraw methodsFor: 'visit' stamp: 'AW 6/3/2021 02:15:06'!
visit: aVisitor

	aVisitor visitWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio-2'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #ReportGenerator category: 'Portfolio-Ejercicio-2'!
Object subclass: #ReportGenerator
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio-2'!

!ReportGenerator methodsFor: 'visit' stamp: 'AW 6/3/2021 02:35:34'!
visitDeposit: aDeposit 

	self subclassResponsibility.! !

!ReportGenerator methodsFor: 'visit' stamp: 'AW 6/3/2021 02:35:46'!
visitIncomingTransaction: anIncomingTransaction 
	self subclassResponsibility.! !

!ReportGenerator methodsFor: 'visit' stamp: 'AW 6/3/2021 02:35:56'!
visitOutgoingTransaction: anOutgoingTransaction 
	self subclassResponsibility.! !

!ReportGenerator methodsFor: 'visit' stamp: 'AW 6/3/2021 02:36:04'!
visitWithdraw: aWithdraw 
	self subclassResponsibility.! !


!ReportGenerator methodsFor: 'report generation' stamp: 'AW 6/3/2021 02:34:49'!
createReport

	account transactions do: [ :transaction |
		transaction visit: self.
	].
	
	^self postReportCreation.
	! !

!ReportGenerator methodsFor: 'report generation' stamp: 'AW 6/3/2021 02:34:33'!
postReportCreation
	
	self subclassResponsibility.! !


!classDefinition: #AccountSummary category: 'Portfolio-Ejercicio-2'!
ReportGenerator subclass: #AccountSummary
	instanceVariableNames: 'report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio-2'!

!AccountSummary methodsFor: 'report generation' stamp: 'AW 6/3/2021 02:30:07'!
postReportCreation

	report add: 'Balance = ', account balance asString, '.'.
	^report.! !


!AccountSummary methodsFor: 'visit' stamp: 'AW 6/3/2021 02:39:56'!
visitDeposit: aDeposit 
	report add: 'Depósito por ', aDeposit amount asString, '.'.! !

!AccountSummary methodsFor: 'visit' stamp: 'AW 6/3/2021 02:19:32'!
visitIncomingTransaction: anIncomingTransaction 
	report add: 'Entrada por transferencia de ', anIncomingTransaction amount asString, '.'.! !

!AccountSummary methodsFor: 'visit' stamp: 'AW 6/3/2021 02:19:59'!
visitOutgoingTransaction: anOutgoingTransaction 
	report add: 'Salida por transferencia de ', anOutgoingTransaction amount asString, '.'.! !

!AccountSummary methodsFor: 'visit' stamp: 'AW 6/3/2021 02:39:56'!
visitWithdraw: aWithdraw 
	report add: 'Extracción por ', aWithdraw amount asString, '.'.! !


!AccountSummary methodsFor: 'initialization' stamp: 'AW 6/3/2021 02:34:05'!
intializeFor: aReceptiveAccount 
	
	account := aReceptiveAccount .
	report := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio-Ejercicio-2'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'AW 6/3/2021 02:31:56'!
for: aReceptiveAccount 
	
	^self new intializeFor: aReceptiveAccount.! !


!classDefinition: #TransferNet category: 'Portfolio-Ejercicio-2'!
ReportGenerator subclass: #TransferNet
	instanceVariableNames: 'net'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio-2'!

!TransferNet methodsFor: 'initialization' stamp: 'AW 6/3/2021 02:37:40'!
initializeFor: anAccount 
	
	account := anAccount.
	net := 0.
! !


!TransferNet methodsFor: 'report generation' stamp: 'AW 6/3/2021 02:30:19'!
postReportCreation

	^net.! !


!TransferNet methodsFor: 'visit' stamp: 'AW 6/3/2021 02:16:14'!
visitDeposit: aDeposit ! !

!TransferNet methodsFor: 'visit' stamp: 'AW 6/3/2021 02:11:44'!
visitIncomingTransaction: aIncomingTransaction

	net := net + aIncomingTransaction amount.			! !

!TransferNet methodsFor: 'visit' stamp: 'AW 6/3/2021 02:12:20'!
visitOutgoingTransaction: aOutgoingTransaction

	net := net - 	aOutgoingTransaction amount.			! !

!TransferNet methodsFor: 'visit' stamp: 'AW 6/3/2021 02:17:13'!
visitWithdraw: aWithdraw 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'Portfolio-Ejercicio-2'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'instance creation' stamp: 'AW 6/3/2021 01:09:09'!
for: anAccount 

	^self new initializeFor: anAccount ! !


!classDefinition: #Transfer category: 'Portfolio-Ejercicio-2'!
Object subclass: #Transfer
	instanceVariableNames: 'outgoingTransaction amount sender receiver incomingTransaction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio-2'!

!Transfer methodsFor: 'initialization' stamp: 'AW 6/1/2021 00:08:27'!
initializeAmount: anAmountToTransfer from: aSenderAccount to: aReceiverAccount 

	amount := anAmountToTransfer.
	sender := aSenderAccount.
	receiver := aReceiverAccount.! !


!Transfer methodsFor: 'accessing' stamp: 'AW 6/1/2021 00:08:27'!
amount
	^amount.! !

!Transfer methodsFor: 'accessing' stamp: 'AW 6/1/2021 00:13:15'!
incomingTransaction
	
	^incomingTransaction.! !

!Transfer methodsFor: 'accessing' stamp: 'AW 5/31/2021 21:56:20'!
outgoingTransaction
	^outgoingTransaction.! !

!Transfer methodsFor: 'accessing' stamp: 'AW 6/1/2021 00:04:47'!
receiver
	
	^receiver! !

!Transfer methodsFor: 'accessing' stamp: 'AW 6/1/2021 00:03:32'!
sender
	
	^sender! !


!Transfer methodsFor: 'private' stamp: 'AW 6/1/2021 00:14:54'!
setOutgoing: anOutgoingTransaction andIncoming: aDeposit 
	
	outgoingTransaction _ anOutgoingTransaction.
	incomingTransaction _ aDeposit.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Ejercicio-2'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'nz 6/2/2021 23:27:06'!
amount: anAmountToTransfer from: aSenderAccount to: aReceiverAccount 
	| transfer outgoingTransaction incomingTransaction |
	
	self validateTransferWithAmount: anAmountToTransfer from: aReceiverAccount to: aSenderAccount.
	
	transfer _ self new initializeAmount: anAmountToTransfer from: aSenderAccount to: aReceiverAccount.
	
	outgoingTransaction := OutgoingTransaction for: transfer.
	incomingTransaction := IncomingTransaction for: transfer.
	
	transfer setOutgoing: outgoingTransaction andIncoming: incomingTransaction.
	^transfer.! !


!Transfer class methodsFor: 'error descriptions' stamp: 'nz 6/2/2021 22:05:44'!
transferAmountMustBePositiveErrorDescription
	^'Transfer amount must be positive'.! !

!Transfer class methodsFor: 'error descriptions' stamp: 'nz 6/2/2021 23:23:11'!
transferReceiverAndSenderCannotBeTheSameErrorDescription
	^'Receiver and Sender cannot be the same'.! !


!Transfer class methodsFor: 'validations' stamp: 'nz 6/2/2021 23:27:16'!
validateTransferWithAmount: anAmountToTransfer from: aReceiverAccount to: aSenderAccount

	(anAmountToTransfer <= 0)
		ifTrue: [ self error: self class transferAmountMustBePositiveErrorDescription ].
		
	(aSenderAccount = aReceiverAccount)
		ifTrue: [ self error: self class transferReceiverAndSenderCannotBeTheSameErrorDescription ]! !
