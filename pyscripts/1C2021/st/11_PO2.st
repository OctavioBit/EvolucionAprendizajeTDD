!classDefinition: #AccountSummaryTest category: 'Portfolio-Solucion'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryTest methodsFor: 'test' stamp: 'ERMC 6/2/2021 23:27:27'!
test01AnEmptyAccountReturnsEmptyAccountSummary

	| account  accountSummary expectiveReport|
	
	account := ReceptiveAccount new.
	accountSummary _ AccountSummary from: account.

	expectiveReport _ OrderedCollection with:  'Balance = 0'.
	
	self assert: accountSummary report  equals: expectiveReport.
! !

!AccountSummaryTest methodsFor: 'test' stamp: 'ERMC 6/2/2021 23:27:45'!
test02AnAccountWithOneDepositReturnsCorrectAccountSummary

	| account  expectiveReport accountSummary |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.

	expectiveReport _ OrderedCollection with: 'Depósito por 100.' with: 'Balance = 100'.
	accountSummary _ AccountSummary from: account.

	self assert: accountSummary report  equals: expectiveReport.
! !

!AccountSummaryTest methodsFor: 'test' stamp: 'ERMC 6/2/2021 23:23:47'!
test03AnAccountWithDepositAndWithdrawTransactionReturnsCorrectReport

	| account  expectiveReport accountSummary |
	
	account := ReceptiveAccount new.
	
	Deposit register: 100 on: account.
	Withdraw  register: 50 on: account.

	expectiveReport _ OrderedCollection with: 'Depósito por 100.' with: 'Extracción por 50.' with: 'Balance = 50' .
	
	accountSummary _ AccountSummary from: account.

	self assert: accountSummary report  equals: expectiveReport.

! !

!AccountSummaryTest methodsFor: 'test' stamp: 'ERMC 6/2/2021 23:25:27'!
test04AnAccountWithOneTransferAndMoreThanOneTransactionReturnsCorrectReport

	| account1 account2  expectiveReport accountSummary |
	
	account1 := ReceptiveAccount new.
	Deposit register: 100 on: account1.
	Withdraw  register: 50 on: account1.
	
	account2 := ReceptiveAccount new.
	
	Transfer register: 20 from: account1 to: account2.

	expectiveReport _ OrderedCollection with: 'Depósito por 100.' with: 'Extracción por 50.' with: 'Salida por transferencia de 20.' with: 'Balance = 30' .
	
	accountSummary _ AccountSummary from: account1.

	self assert: accountSummary report  equals: expectiveReport.

! !

!AccountSummaryTest methodsFor: 'test' stamp: 'ERMC 6/2/2021 23:25:52'!
test05AnAccountWithMoreThanOneTransferReturnsCorrectReport

	| account1 account2  expectiveReport accountSummary |
	
	account1 := ReceptiveAccount new.
	Deposit register: 100 on: account1.
	Withdraw  register: 50 on: account1.
	
	account2 := ReceptiveAccount new.
	
	Transfer register: 20 from: account1 to: account2.
	Transfer register: 30 from: account2 to: account1.
	

	expectiveReport _ OrderedCollection with: 'Depósito por 100.' with: 'Extracción por 50.' with: 'Salida por transferencia de 20.' with: 'Entrada por transferencia de 30.' with: 'Balance = 60' .

	accountSummary _ AccountSummary from: account1.

	self assert: accountSummary report  equals: expectiveReport.

! !

!AccountSummaryTest methodsFor: 'test' stamp: 'ERMC 6/2/2021 23:26:18'!
test06AnEmptyPortfolioHasEmptyAccountSummary

	| portfolio   expectiveReport accountSummary |
	
	portfolio := Portfolio new.

	expectiveReport _ OrderedCollection with: 'Balance = 0' .

	accountSummary _ AccountSummary from: portfolio .

	self assert: accountSummary report  equals: expectiveReport.
! !

!AccountSummaryTest methodsFor: 'test' stamp: 'ERMC 6/2/2021 23:26:51'!
test07APortfolioWithOneAccountReturnsCorrectAccountSummary

	| portfolio account1 account2  expectiveReport accountSummary |
	
	account1 := ReceptiveAccount new.
	Deposit register: 100 on: account1.
	Withdraw  register: 50 on: account1.
	portfolio _ Portfolio with: account1 .
	
	account2 := ReceptiveAccount new.
	
	Transfer register: 20 from: account1 to: account2.
	Transfer register: 30 from: account2 to: account1.
	

	expectiveReport _ OrderedCollection with: 'Depósito por 100.' with: 'Extracción por 50.' with: 'Salida por transferencia de 20.' with: 'Entrada por transferencia de 30.' with: 'Balance = 60' .

	accountSummary _ AccountSummary from: portfolio .
	self assert: accountSummary report  equals: expectiveReport.
! !

!AccountSummaryTest methodsFor: 'test' stamp: 'ERMC 6/2/2021 23:27:10'!
test08APortfolioWithMoreThanOneAccountReturnsCorrectReport

	| portfolio account1 account2  expectiveReport accountSummary |
	
	account1 := ReceptiveAccount new.
	Deposit register: 100 on: account1.
	Withdraw  register: 50 on: account1.
	portfolio _ Portfolio with: account1 .
	
	account2 := ReceptiveAccount new.
	
	Transfer register: 20 from: account1 to: account2.
	Transfer register: 30 from: account2 to: account1.
	

	expectiveReport _ OrderedCollection with: 'Depósito por 100.' with: 'Extracción por 50.' with: 'Salida por transferencia de 20.' with: 'Entrada por transferencia de 30.'.
	expectiveReport add: 'Entrada por transferencia de 20.'.
	expectiveReport  add: 'Salida por transferencia de 30.'.
	expectiveReport  add: 'Balance = 50' .

	portfolio add: account2.
	
	accountSummary _ AccountSummary from: portfolio .
	self assert: accountSummary report  equals: expectiveReport.
! !


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


!classDefinition: #TransferNetTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetTest methodsFor: 'test' stamp: 'sgs 6/2/2021 22:04:45'!
test01AccountWithoutTransferReturnZeroReport

	| anAccount |
	anAccount _ ReceptiveAccount new.
	
	self assert: 0 equals: (TransferNet from: anAccount)! !

!TransferNetTest methodsFor: 'test' stamp: 'sgs 6/2/2021 22:30:09'!
test02AnAccountWithOneTransferReturnsCorrenctTransferNet

	| anAccount anotherAccount expectedTransferNet |
	anAccount _ ReceptiveAccount new.
	anotherAccount _ ReceptiveAccount new.
	
	Transfer register: 50 from: anAccount to: anotherAccount.
	
	expectedTransferNet _ 50.
	
	self assert: expectedTransferNet equals: (TransferNet from: anotherAccount).! !

!TransferNetTest methodsFor: 'test' stamp: 'ERMC 6/3/2021 00:04:45'!
test03AnAccountWithManyTransfersReturnsCorrectTransferNet

	| srcAccount dstAccount |
	srcAccount _ ReceptiveAccount new.
	dstAccount _ ReceptiveAccount new.
	
	Deposit register: 200 on: srcAccount.
	
	Transfer register: 50 from: srcAccount to: dstAccount.
	Transfer register: 20 from: srcAccount to: dstAccount.
	Transfer register: 30 from: srcAccount to: dstAccount.
	Transfer register: 20 from: srcAccount to: dstAccount.
	
	
	self assert: 120 equals: (TransferNet from: dstAccount).
	self assert: -120 equals: (TransferNet from: srcAccount).! !

!TransferNetTest methodsFor: 'test' stamp: 'ERMC 6/3/2021 00:05:58'!
test04AnEmptyPortfolioReturnsZeroTransferNet

	| portfolio |
	portfolio _ Portfolio new.
	
	self assert: 0 equals: (TransferNet from: portfolio)! !

!TransferNetTest methodsFor: 'test' stamp: 'ERMC 6/3/2021 00:13:32'!
test05APortfolioWithOneAccountsReportsCorrectTransferNet

	| portfolio dstAccount srcAccount |
	
	srcAccount _ ReceptiveAccount new.
	dstAccount _ ReceptiveAccount new.
	
	Transfer register: 50 from: srcAccount to: dstAccount.
	
	portfolio _ Portfolio with: srcAccount.
	
	self assert: -50 equals: (TransferNet from: portfolio)! !

!TransferNetTest methodsFor: 'test' stamp: 'sgs 6/3/2021 14:58:57'!
test06APortfolioWithManyAccountReportsCorrectTransferNet

	| portfolio dstAccount srcAccount anotherAccount |
	
	srcAccount _ ReceptiveAccount new.
	dstAccount _ ReceptiveAccount new.
	anotherAccount _ ReceptiveAccount new.
	
	Transfer register: 50 from: srcAccount to: dstAccount.
	Transfer register: 20 from: srcAccount to: dstAccount.
	Transfer register: 30 from: srcAccount to: dstAccount.
	Transfer register: 20 from: srcAccount to: anotherAccount.
	
	portfolio _ Portfolio with: srcAccount with: anotherAccount.
	
	self assert: -100 equals: (TransferNet from: portfolio)! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'test' stamp: 'sgs 6/3/2021 16:34:09'!
test01ATransferWithZeroAmountIsInvalid
	| account1 account2|
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.	
	
	self 
		should: [ Transfer register: 0 from: account1 to: account2.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo:[ :anError |
			self assert: Transfer valueOfATransferMustBePositiveErrorMessage equals: anError messageText.
			self assert: account1 transactionsIsEmpty. 
			self assert: account1 transactionsIsEmpty ]
		 .
		
		
! !

!TransferTest methodsFor: 'test' stamp: 'sgs 6/3/2021 16:34:53'!
test02ATransferWithNegativeAmountIsInvalid
	| account1 account2|
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.	
	
	self 
	should: [ Transfer register: -1000 from: account1 to: account2.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo:[ :anError |
			self assert: Transfer valueOfATransferMustBePositiveErrorMessage equals: anError messageText.
			self assert: account1 transactionsIsEmpty. 
			self assert: account1 transactionsIsEmpty ]
	
! !

!TransferTest methodsFor: 'test' stamp: 'sgs 6/3/2021 16:35:17'!
test03ATransferBetweenAccountAffectsBalance
	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.	

	Deposit register: 100 on: account1.
	
	Transfer register: 50 from: account1 to: account2.
	
	self assert: 50 equals: account1 balance .
	self assert: 50 equals: account2 balance .

	
! !

!TransferTest methodsFor: 'test' stamp: 'sgs 6/3/2021 16:35:36'!
test04CanMakeATransferWithAmountBelow
	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.	
	
	Transfer register: 50 from: account1 to: account2	.
	
	self assert: -50 equals: account1 balance .
	self assert: 50 equals: account2 balance .

	
! !

!TransferTest methodsFor: 'test' stamp: 'sgs 6/3/2021 16:35:53'!
test05TransferBetweenAccountsSaveTheTransactionInBothAccounts
	| account1 account2 transfer |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.	
	
	transfer _ Transfer register: 50 from: account1 to: account2.
	
	self assert: (account1 hasRegistered: transfer withdrawLeg).
	self assert: (account2 hasRegistered: transfer depositLeg).

	
! !

!TransferTest methodsFor: 'test' stamp: 'sgs 6/3/2021 16:36:09'!
test06ASourceAccountKnowsHisTransferLeg
	| account1 account2 transfer |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.	
	
	transfer _ Transfer register: 50 from: account1 to: account2.
	
	self assert: (transfer withdrawLeg transferLeg) equals: (transfer depositLeg).
	! !

!TransferTest methodsFor: 'test' stamp: 'sgs 6/3/2021 16:36:29'!
test07ADestinyAccountKnowsHisTransferLeg
	| account1 account2 transfer |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.	
	
	transfer _ Transfer register: 50 from: account1 to: account2.
	
	
	self assert: (transfer depositLeg transferLeg) equals: (transfer withdrawLeg).! !


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

!Portfolio methodsFor: 'transactions' stamp: 'sgs 6/3/2021 16:06:45'!
transactionsIsEmpty
	

	^accounts allSatisfy: [ :anAccount | anAccount transactionsIsEmpty ]! !


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


!Portfolio methodsFor: 'reports' stamp: 'sgs 6/1/2021 23:11:31'!
accountSummary: aReport
	

	accounts do: [:anAccount |anAccount accountSummary: aReport.].
	
	^aReport .! !

!Portfolio methodsFor: 'reports' stamp: 'ERMC 6/3/2021 00:07:27'!
calcualteReportFor: aReport 
	
	accounts do: [:anAccount |anAccount accountSummary: aReport.]! !

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

!ReceptiveAccount methodsFor: 'testing' stamp: 'sgs 6/3/2021 16:07:09'!
transactionsIsEmpty
	
	^transactions isEmpty ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'ERMC 6/2/2021 23:35:17'!
accountSummary: aReport
	
	transactions do:[:aTransaction |aTransaction affectReport: aReport].
	
	
	! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'ERMC 6/2/2021 23:56:02'!
calcualteReportFor: aTransferNet
 
	transactions  do: [:aTransaction | 
		(aTransaction isKindOf: DepositTransfer) ifTrue: [aTransaction affectReport: aTransferNet].
		(aTransaction isKindOf: WithdrawTransfer) ifTrue: [aTransaction affectReport: aTransferNet]
		]
	! !


!classDefinition: #AccountOperationsReport category: 'Portfolio-Solucion'!
Object subclass: #AccountOperationsReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountOperationsReport methodsFor: 'initialization' stamp: 'ERMC 6/3/2021 00:18:36'!
initializeFor: anAmount

	self subclassResponsibility ! !


!AccountOperationsReport methodsFor: 'report' stamp: 'ERMC 6/3/2021 00:17:46'!
addFromDeposit: anAmount

	self subclassResponsibility ! !

!AccountOperationsReport methodsFor: 'report' stamp: 'ERMC 6/3/2021 00:18:13'!
addFromDepositTransfer: anAmount

	self subclassResponsibility ! !

!AccountOperationsReport methodsFor: 'report' stamp: 'ERMC 6/3/2021 00:17:58'!
addFromWithdraw: anAmount

	self subclassResponsibility ! !

!AccountOperationsReport methodsFor: 'report' stamp: 'ERMC 6/3/2021 00:18:06'!
addFromWithdrawTransfer: anAmount

	self subclassResponsibility ! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
AccountOperationsReport subclass: #AccountSummary
	instanceVariableNames: 'report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'report' stamp: 'ERMC 6/2/2021 23:48:36'!
addFromDeposit: anAmount
	
	^report add: 'Depósito por ', anAmount asString, '.'
	
	! !

!AccountSummary methodsFor: 'report' stamp: 'ERMC 6/2/2021 23:50:10'!
addFromDepositTransfer: anAmount
	
	^report add: 'Entrada por transferencia de ', anAmount value asString, '.'
	
	! !

!AccountSummary methodsFor: 'report' stamp: 'ERMC 6/2/2021 23:51:13'!
addFromWithdraw: anAmount
	
	^report add: 'Extracción por ', anAmount asString, '.'
	
	! !

!AccountSummary methodsFor: 'report' stamp: 'ERMC 6/2/2021 23:52:43'!
addFromWithdrawTransfer: anAmount
	
	^report add: 'Salida por transferencia de ', anAmount value asString, '.'
	
	! !

!AccountSummary methodsFor: 'report' stamp: 'sgs 6/1/2021 22:49:40'!
report
	^report.! !


!AccountSummary methodsFor: 'initialization' stamp: 'ERMC 6/2/2021 23:54:00'!
initializeFrom:anAccount

	report _ OrderedCollection new.
	anAccount accountSummary: self.
	report add: 'Balance = ', anAccount balance asString.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'as yet unclassified' stamp: 'sgs 6/1/2021 22:46:14'!
from: anAccount

	^self new initializeFrom:anAccount.! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
AccountOperationsReport subclass: #TransferNet
	instanceVariableNames: 'account transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'initialization' stamp: 'ERMC 6/2/2021 23:55:12'!
initializeWith: anAccount 
	
	transferNet _ 0.
	
	anAccount calcualteReportFor: self.
	
	^transferNet 
! !


!TransferNet methodsFor: 'reports' stamp: 'ERMC 6/3/2021 00:19:37'!
addFromDeposit: anAmount
! !

!TransferNet methodsFor: 'reports' stamp: 'ERMC 6/2/2021 23:57:37'!
addFromDepositTransfer: anAmount
	
	 transferNet _ transferNet + anAmount.
! !

!TransferNet methodsFor: 'reports' stamp: 'ERMC 6/3/2021 00:19:44'!
addFromWithdraw: anAmount
! !

!TransferNet methodsFor: 'reports' stamp: 'ERMC 6/3/2021 00:01:28'!
addFromWithdrawTransfer: anAmount 
		
	transferNet _ transferNet - anAmount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'Portfolio-Solucion'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'as yet unclassified' stamp: 'sgs 6/2/2021 22:05:32'!
from: anAccount

	^self new initializeWith: anAccount 
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


!AccountTransaction methodsFor: 'report' stamp: 'ERMC 6/2/2021 23:31:51'!
affectReport: aReportSummary

	self subclassResponsibility .! !

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


!Deposit methodsFor: 'report' stamp: 'ERMC 6/2/2021 23:46:56'!
affectReport: aReport
	
	^aReport addFromDeposit: value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #DepositTransfer category: 'Portfolio-Solucion'!
AccountTransaction subclass: #DepositTransfer
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!DepositTransfer methodsFor: 'initialization' stamp: 'ERMC 5/29/2021 21:50:48'!
initializeFor: aTransfer 

	transfer := aTransfer.! !


!DepositTransfer methodsFor: 'balance' stamp: 'sgs 6/1/2021 21:52:33'!
affectBalance: aBalance

	^aBalance + (transfer value).! !


!DepositTransfer methodsFor: 'accesing' stamp: 'sgs 6/1/2021 21:48:46'!
transfer

	^ transfer 
! !

!DepositTransfer methodsFor: 'accesing' stamp: 'ERMC 5/29/2021 21:53:54'!
transferLeg

	^ transfer withdrawLeg
! !


!DepositTransfer methodsFor: 'report' stamp: 'ERMC 6/2/2021 23:49:44'!
affectReport: aReport
	
	^aReport addFromDepositTransfer: transfer value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DepositTransfer class' category: 'Portfolio-Solucion'!
DepositTransfer class
	instanceVariableNames: ''!

!DepositTransfer class methodsFor: 'as yet unclassified' stamp: 'ERMC 6/3/2021 00:22:25'!
for: aTransfer 
	
	^ self new initializeFor: aTransfer ! !


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


!Withdraw methodsFor: 'report' stamp: 'ERMC 6/2/2021 23:54:30'!
affectReport: aReport
	
	^aReport addFromWithdraw: value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #WithdrawTransfer category: 'Portfolio-Solucion'!
AccountTransaction subclass: #WithdrawTransfer
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WithdrawTransfer methodsFor: 'initialization' stamp: 'ERMC 5/29/2021 21:51:04'!
initializeFor: aTransfer 

	transfer _ aTransfer.! !


!WithdrawTransfer methodsFor: 'balance' stamp: 'sgs 6/1/2021 21:53:03'!
affectBalance: aBalance

	^aBalance - (transfer value).! !


!WithdrawTransfer methodsFor: 'accesing' stamp: 'sgs 6/1/2021 21:49:41'!
transfer

	^transfer  ! !

!WithdrawTransfer methodsFor: 'accesing' stamp: 'ERMC 5/29/2021 21:54:10'!
transferLeg
	
	^transfer depositLeg ! !


!WithdrawTransfer methodsFor: 'report' stamp: 'ERMC 6/2/2021 23:52:05'!
affectReport: aReport
	
	^aReport addFromWithdrawTransfer: transfer value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WithdrawTransfer class' category: 'Portfolio-Solucion'!
WithdrawTransfer class
	instanceVariableNames: ''!

!WithdrawTransfer class methodsFor: 'as yet unclassified' stamp: 'ERMC 5/29/2021 20:49:30'!
for: anAmount 

	^ self new initializeFor: anAmount! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'value' stamp: 'sgs 6/1/2021 21:50:19'!
value
	
	^value ! !


!Transfer methodsFor: 'initialization' stamp: 'ERMC 5/29/2021 21:50:12'!
initializeWithAmount: anAmountToTransfer from: anOriginAccount to: aDstAccount 
	
	value _ anAmountToTransfer.
	withdrawLeg _ WithdrawTransfer register: self on: anOriginAccount.
	depositLeg _ DepositTransfer register: self on: aDstAccount.! !


!Transfer methodsFor: 'legs' stamp: 'ERMC 5/29/2021 20:27:33'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'legs' stamp: 'ERMC 5/29/2021 20:27:14'!
withdrawLeg

	^withdrawLeg! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'registration' stamp: 'sgs 6/3/2021 16:16:19'!
register: anAmountToTransfer from: anOriginAccount to: aDstAccount

	self assertCanTrasfer: anAmountToTransfer.
	^self new initializeWithAmount: anAmountToTransfer from: anOriginAccount to: aDstAccount.
	
	! !


!Transfer class methodsFor: 'assertions - precondition' stamp: 'sgs 6/3/2021 16:30:23'!
assertCanTrasfer: anAmount.
	
	(anAmount > 0) ifFalse: [self signalTransferValueMustBePositive]
	
	! !


!Transfer class methodsFor: 'exception' stamp: 'sgs 6/3/2021 16:30:43'!
signalTransferValueMustBePositive
	
	self error: self valueOfATransferMustBePositiveErrorMessage 
	
	! !

!Transfer class methodsFor: 'exception' stamp: 'sgs 6/3/2021 16:08:11'!
valueOfATransferMustBePositiveErrorMessage

	^'El valor a transferir debe ser estrictamente positivo.'! !
