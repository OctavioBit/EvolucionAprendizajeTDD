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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'GR 11/9/2020 21:40:43'!
test08TranferRegistersInBothAccounts

	| account anotherAccount transfer |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	transfer := Transfer transfer: 100 from: account to: anotherAccount.
		
	self assert: 1 equals: account transactions size .
	self assert: (account hasRegistered: transfer exitTransfer).
	self assert: 1 equals: anotherAccount transactions size .
	self assert: (anotherAccount hasRegistered: transfer entryTransfer).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'GR 11/9/2020 20:03:05'!
test09TransfersModifiesBalance

	| account anotherAccount |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	Transfer transfer: 100 from: account to: anotherAccount.
		
	self assert: 0 equals: account balance .
	self assert: 100 equals: anotherAccount balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'GR 11/9/2020 21:33:11'!
test10CanNotTransferToSameAccount

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	self 
		should: [ Transfer transfer: 100 from: account to: account. ] 
		raise: Error 
		withMessageText: Transfer sameAccountError.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'GR 11/9/2020 21:39:36'!
test11CanNotTransferANegativeAmount

	| account account2 |
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	self 
		should: [ Transfer transfer: -100 from: account to: account2. ] 
		raise: Error 
		withMessageText: Transfer invalidAmountTransferError.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'GR 11/9/2020 21:40:56'!
test12CanNotTransferNoMoney

	| account account2 |
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	self 
		should: [ Transfer transfer: 0 from: account to: account2. ] 
		raise: Error 
		withMessageText: Transfer invalidAmountTransferError.! !


!classDefinition: #ReportsTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportsTest methodsFor: 'tests' stamp: 'GR 11/14/2020 15:29:45'!
test01ReportWith0Balance

	| account register |
	
	account := ReceptiveAccount new.
	
	register := OrderedCollection with: 'Balance = 0'.
		
	self assert: register equals: (AccountSummary for: account) summary .
! !

!ReportsTest methodsFor: 'tests' stamp: 'GR 11/14/2020 15:35:46'!
test02ReportWithADeposit

	| account register |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	register := OrderedCollection with: 'Deposito de 100' with: 'Balance = 100'.
		
	self assert: register equals: (AccountSummary for: account) summary.
! !

!ReportsTest methodsFor: 'tests' stamp: 'GR 11/14/2020 15:38:58'!
test03ReportWithAWithdraw

	| account register |
	
	account := ReceptiveAccount new.
	Withdraw register: 100 on: account.
	
	register := OrderedCollection with: 'Extraccion de 100' with: 'Balance = -100'.
		
	self assert: register equals: (AccountSummary for: account) summary.
! !

!ReportsTest methodsFor: 'tests' stamp: 'GR 11/14/2020 15:39:09'!
test04ReportWithATransfer

	| account anotherAccount entryRegister exitRegister |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	Transfer transfer: 100 from: account to: anotherAccount.
	
	entryRegister := OrderedCollection with: 'Entrada por transferencia de 100' with: 'Balance = 100'.
	exitRegister := OrderedCollection with: 'Salida por transferencia de 100' with: 'Balance = -100'.
		
	self assert: exitRegister equals: (AccountSummary for: account) summary.
	self assert: entryRegister equals: (AccountSummary for: anotherAccount ) summary.
! !

!ReportsTest methodsFor: 'tests' stamp: 'GR 11/14/2020 15:46:25'!
test05TransferNetOfNewAccountIsCero

	| account |
	
	account := ReceptiveAccount new.
		
	self assert: 0 equals: (TransferNet for: account) value.! !

!ReportsTest methodsFor: 'tests' stamp: 'GR 11/14/2020 15:42:12'!
test06ATransferModifiesTransferNet

	| account anotherAccount |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	Transfer transfer: 100 from: account to: anotherAccount.
		
	self assert: -100 equals: (TransferNet for: account) value.
	self assert: 100 equals: (TransferNet for: anotherAccount ) value.
! !

!ReportsTest methodsFor: 'tests' stamp: 'GR 11/14/2020 15:42:22'!
test07DepositDoesNotModifyTransferNet

	| account anotherAccount |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	Deposit register: 100 on: account.
		
	self assert: 0 equals: (TransferNet for: account) value.
	self assert: 0 equals: (TransferNet for: anotherAccount ) value.! !

!ReportsTest methodsFor: 'tests' stamp: 'GR 11/14/2020 15:42:32'!
test08WithdrawDoesNotModifyTransferNet

	| account anotherAccount |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	Withdraw register: 100 on: account.
		
	self assert: 0 equals: (TransferNet for: account) value.
	self assert: 0 equals: (TransferNet for: anotherAccount ) value.
! !

!ReportsTest methodsFor: 'tests' stamp: 'GR 11/14/2020 16:48:12'!
test09PortfolioWithNewAccountReportsSummary

	| portfolio account summary |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	summary := OrderedCollection with: (OrderedCollection with: 'Balance = 0') with: 'Balance = 0'.
	
	self assert: summary equals: (AccountSummary for: portfolio) summary! !

!ReportsTest methodsFor: 'tests' stamp: 'GR 11/14/2020 16:48:07'!
test10PortfolioWithTransactionMadeAccountReportsSummary

	| portfolio account summary accountSummary |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	accountSummary := OrderedCollection with: 'Deposito de 100'  with: 'Balance = 100'.
	summary := OrderedCollection with: accountSummary with: 'Balance = 100'.
	
	self assert: summary equals: (AccountSummary for: portfolio) summary! !

!ReportsTest methodsFor: 'tests' stamp: 'GR 11/14/2020 16:34:03'!
test11PortfolioWithNewAccountTransferNetEqualsCero

	| portfolio account |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self assert: 0 equals: (TransferNet for: portfolio ) value! !

!ReportsTest methodsFor: 'tests' stamp: 'GR 11/14/2020 16:23:51'!
test12PortfolioWithAccountTransferGivesItsTransferNet

	| portfolio account account2 |
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	Transfer transfer: 100 from: account to: account2.
	
	self assert: -100 equals: (TransferNet for: portfolio) value! !

!ReportsTest methodsFor: 'tests' stamp: 'GR 11/14/2020 17:33:29'!
test13PortfolioGivesSubAccountsTotalTransferNet

	| portfolio account account2 account3 |
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	portfolio := Portfolio with: account with: account2.
	Transfer transfer: 100 from: account to: account3.
	Transfer transfer: 50 from: account3 to: account2.
	
	self assert: -50 equals: (TransferNet for: portfolio) value! !


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


!Account methodsFor: 'report' stamp: 'GR 11/14/2020 16:15:20'!
makeReport: aReport

	self subclassResponsibility.! !

!Account methodsFor: 'report' stamp: 'GR 11/12/2020 21:52:35'!
transferNet

	self subclassResponsibility.! !


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


!Portfolio methodsFor: 'report' stamp: 'GR 11/14/2020 16:42:16'!
makeReport: aReport

	^ aReport portfolioReport: self
	
	! !


!Portfolio methodsFor: 'accessing' stamp: 'GR 11/14/2020 16:09:33'!
accounts
	
	^accounts! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
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


!ReceptiveAccount methodsFor: 'report' stamp: 'GR 11/9/2020 22:11:29'!
transferNet
	
	^ transactions inject: 0 into: [ :transferNet :aTransaction | aTransaction transferNet: transferNet].! !


!ReceptiveAccount methodsFor: 'operations' stamp: 'GR 11/14/2020 16:10:20'!
makeReport: aReport

	^ aReport accountReport: self
	
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


!AccountTransaction methodsFor: 'report' stamp: 'GR 11/14/2020 15:53:59'!
giveReport: aReport

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


!Deposit methodsFor: 'report' stamp: 'GR 11/14/2020 15:55:48'!
giveReport: aReport
	
	^ aReport depositReport: self! !


!Deposit methodsFor: 'transferNet' stamp: 'GR 11/9/2020 22:12:17'!
transferNet: aTransferNet 
	
	^aTransferNet! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferFeet category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferFeet
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferFeet methodsFor: 'balance' stamp: 'GR 11/9/2020 21:41:44'!
affectBalance: aBalance

	self subclassResponsibility.! !


!TransferFeet methodsFor: 'initialization' stamp: 'GR 11/9/2020 21:42:07'!
initializeFor: aTransfer from: anAccount 

	self subclassResponsibility.! !


!TransferFeet methodsFor: 'report' stamp: 'GR 11/14/2020 15:53:59'!
giveReport: aReport

	self subclassResponsibility.! !


!TransferFeet methodsFor: 'accessing' stamp: 'GR 11/14/2020 16:02:24'!
value
	
	^ transfer value! !


!classDefinition: #EntryTransfer category: 'Portfolio-Solucion'!
TransferFeet subclass: #EntryTransfer
	instanceVariableNames: 'transmitter'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!EntryTransfer methodsFor: 'initialization' stamp: 'GR 11/9/2020 21:24:56'!
initializeFor: aTransfer from: anAccount 
	
	transfer := aTransfer.
	transmitter := anAccount.! !


!EntryTransfer methodsFor: 'balance' stamp: 'GR 11/9/2020 21:29:40'!
affectBalance: aBalance 
	
	^ aBalance + transfer value.! !


!EntryTransfer methodsFor: 'report' stamp: 'GR 11/14/2020 15:56:54'!
giveReport: aReport
	
	^ aReport entryTransferReport: self.! !


!EntryTransfer methodsFor: 'transferNet' stamp: 'GR 11/9/2020 22:13:15'!
transferNet: aTransferNet

	^ aTransferNet + transfer value! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EntryTransfer class' category: 'Portfolio-Solucion'!
EntryTransfer class
	instanceVariableNames: ''!

!EntryTransfer class methodsFor: 'instance creation' stamp: 'GR 11/9/2020 21:24:48'!
for: aTransfer from: anAccount 
	
	^self new initializeFor: aTransfer from: anAccount ! !


!classDefinition: #ExitTransfer category: 'Portfolio-Solucion'!
TransferFeet subclass: #ExitTransfer
	instanceVariableNames: 'receiver'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ExitTransfer methodsFor: 'initialization' stamp: 'GR 11/9/2020 21:25:13'!
initializeFor: aTransfer to: anAccount 
	
	transfer := aTransfer.
	receiver := anAccount.! !


!ExitTransfer methodsFor: 'balance' stamp: 'GR 11/9/2020 21:28:06'!
affectBalance: aBalance 
	
	^ aBalance - transfer value.! !


!ExitTransfer methodsFor: 'report' stamp: 'GR 11/14/2020 15:59:11'!
giveReport: aReport
	
	^ aReport exitTransferReport: self.! !


!ExitTransfer methodsFor: 'transferNet' stamp: 'GR 11/9/2020 22:12:51'!
transferNet: aTransferNet
	
	^ aTransferNet - transfer value ! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ExitTransfer class' category: 'Portfolio-Solucion'!
ExitTransfer class
	instanceVariableNames: ''!

!ExitTransfer class methodsFor: 'instance creation' stamp: 'GR 11/9/2020 21:25:01'!
for: aTransfer to: anAccount 
	
	^self new initializeFor: aTransfer to: anAccount ! !


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


!Withdraw methodsFor: 'report' stamp: 'GR 11/14/2020 15:59:24'!
giveReport: aReport
	
	^ aReport withdrawReport: self.! !


!Withdraw methodsFor: 'transferNet' stamp: 'GR 11/9/2020 22:16:44'!
transferNet: aTransferNet 
	
	^ aTransferNet! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: 'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'Portfolio-Solucion'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'instance creation' stamp: 'GR 11/14/2020 15:41:16'!
for: anAccount 
	
	^self new initializeFor: anAccount ! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'initialization' stamp: 'GR 11/14/2020 16:31:59'!
initializeFor: anAccount 
	
	summary  := anAccount makeReport: self! !


!AccountSummary methodsFor: 'accessing' stamp: 'GR 11/14/2020 15:35:22'!
summary
	
	^summary! !


!AccountSummary methodsFor: 'operations' stamp: 'GR 11/14/2020 17:17:17'!
accountReport: aReceptiveAccount
	
	^ self report: aReceptiveAccount with: aReceptiveAccount transactions collecting: [ :aTransaction | aTransaction giveReport: self ].! !

!AccountSummary methodsFor: 'operations' stamp: 'GR 11/14/2020 17:17:06'!
portfolioReport: aPortfolio

	^ self report: aPortfolio with: aPortfolio accounts collecting: [ :anAccount | anAccount makeReport: self ]! !


!AccountSummary methodsFor: 'operations -- private' stamp: 'GR 11/14/2020 15:56:06'!
depositReport: aDeposit

	^ ('Deposito de ',aDeposit value asString)! !

!AccountSummary methodsFor: 'operations -- private' stamp: 'GR 11/14/2020 15:57:41'!
entryTransferReport: anEntryTransfer

	^ 'Entrada por transferencia de ', anEntryTransfer value asString.! !

!AccountSummary methodsFor: 'operations -- private' stamp: 'GR 11/14/2020 15:58:19'!
exitTransferReport: anExitTransfer

	^ 'Salida por transferencia de ', anExitTransfer value asString.! !

!AccountSummary methodsFor: 'operations -- private' stamp: 'GR 11/14/2020 17:17:29'!
report: anAccount with: anOrderedCollection collecting: aBlock

	| report |
	
	report := anOrderedCollection collect: aBlock.
	
	report add: 'Balance = ', anAccount balance asString.
	
	^report! !

!AccountSummary methodsFor: 'operations -- private' stamp: 'GR 11/14/2020 15:58:49'!
withdrawReport: aWithdraw

	^ ('Extraccion de ',aWithdraw value asString)! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
Report subclass: #TransferNet
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'initialization' stamp: 'GR 11/14/2020 16:32:48'!
initializeFor: anAccount 
	
	value := anAccount makeReport: self.! !


!TransferNet methodsFor: 'operations' stamp: 'GR 11/14/2020 16:44:18'!
accountReport: aReceptiveAccount
	
	^ self report: aReceptiveAccount! !

!TransferNet methodsFor: 'operations' stamp: 'GR 11/14/2020 16:45:05'!
portfolioReport: aPortfolio 
	
	^ self report: aPortfolio! !


!TransferNet methodsFor: 'accessing' stamp: 'GR 11/14/2020 15:45:41'!
value

	^ value ! !


!TransferNet methodsFor: 'operations -- private' stamp: 'GR 11/14/2020 16:44:32'!
report: anAccount

	^ anAccount transactions inject: 0 into: [ :transferNet :aTransaction | aTransaction transferNet: transferNet].! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value transferEntry transferExit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'GR 11/9/2020 21:40:20'!
initializeTransfer: aValue from: account to: anotherAccount 
	
	(account == anotherAccount ) ifTrue: [ self error: Transfer sameAccountError ].
	
	(aValue <= 0) ifTrue: [self error: Transfer invalidAmountTransferError ].
	
	transferEntry := EntryTransfer for: self from: account.
	transferExit := ExitTransfer for: self to: anotherAccount.
	
	account register: transferExit.
	anotherAccount register: transferEntry.
	
	value := aValue ! !


!Transfer methodsFor: 'accessing' stamp: 'GR 11/9/2020 21:20:14'!
entryTransfer
	
	^transferEntry ! !

!Transfer methodsFor: 'accessing' stamp: 'GR 11/9/2020 21:27:18'!
exitTransfer
	
	^transferExit.! !

!Transfer methodsFor: 'accessing' stamp: 'GR 11/9/2020 21:29:25'!
value

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: 'transferEntry transferExit'!

!Transfer class methodsFor: 'instance creation' stamp: 'GR 11/9/2020 21:19:11'!
transfer: aValue from: account to: anotherAccount 
	
	^self new initializeTransfer: aValue from: account to: anotherAccount ! !


!Transfer class methodsFor: 'as yet unclassified' stamp: 'GR 11/9/2020 21:18:31'!
entryTransfer
	self shouldBeImplemented.! !


!Transfer class methodsFor: 'error handling' stamp: 'GR 11/9/2020 21:39:36'!
invalidAmountTransferError
	
	^ 'You are trying to transfer an invalid amount'! !

!Transfer class methodsFor: 'error handling' stamp: 'GR 11/9/2020 21:33:47'!
sameAccountError
	
	^ 'You can not transfer to your oun account!!'! !
