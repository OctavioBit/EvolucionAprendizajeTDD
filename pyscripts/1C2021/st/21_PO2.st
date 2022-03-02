!classDefinition: #PortfolioTest category: 'Portfolio-2'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

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


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-2'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

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


!classDefinition: #ReporterTest category: 'Portfolio-2'!
TestCase subclass: #ReporterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!ReporterTest methodsFor: 'testing' stamp: 'ENC 6/2/2021 23:25:12'!
test01AccountSummaryOfNewAccountIsEmpty

	| account report reporter |
	
	account := ReceptiveAccount new.	
	reporter := AccountSummaryReporter with: account.
	report := OrderedCollection new.
	report add: 'Balance = 0'.
	
	self assert: report equals: reporter doAccountSummary.! !

!ReporterTest methodsFor: 'testing' stamp: 'ENC 6/2/2021 23:25:37'!
test02TransferNetOfNewAccountIsZero

	| account report reporter |
	
	account := ReceptiveAccount new.	
	reporter := TransferNetReporter with: account.
	report := 0.
	
	self assert: report equals: reporter doTransferNet.! !

!ReporterTest methodsFor: 'testing' stamp: 'ENC 6/2/2021 23:27:33'!
test03AccountSummaryOfAccountHasEveryMovement

	| accountA accountB report reporter |
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.	
	
	Transfer from: accountA to: accountB of: 10.
	Transfer from: accountB to: accountA of: 15.
	Deposit register: 20 on: accountA.
	Withdraw register: 5 on: accountA.
	
	reporter := AccountSummaryReporter with: accountA.
	
	report := OrderedCollection new.
	report add: 'Salida por transferencia de 10'.
	report add: 'Entrada por transferencia de 15'.
	report add: 'Depósito por 20'.
	report add: 'Extracción por 5'.
	report add: 'Balance = 20'.
	
	self assert: report equals: reporter doAccountSummary.! !

!ReporterTest methodsFor: 'testing' stamp: 'ENC 6/2/2021 23:28:22'!
test04TransferNetOfAccountCalculatesTransferBalance

	| accountA accountB report reporter |
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.	
	
	Transfer from: accountA to: accountB of: 10.
	Transfer from: accountB to: accountA of: 15.
	Deposit register: 20 on: accountA.
	Withdraw register: 5 on: accountA.
	
	reporter := TransferNetReporter with: accountA.
	
	report := 5.
	
	self assert: report equals: reporter doTransferNet.! !

!ReporterTest methodsFor: 'testing' stamp: 'ENC 6/2/2021 23:35:28'!
test05AccountSummaryOfNewPortfolioIsEmpty

	| account report reporter portfolio |
	
	account := ReceptiveAccount new.	
	portfolio := Portfolio with: account.
	reporter := AccountSummaryReporter with: portfolio.
	report := OrderedCollection new.
	report add: 'Balance = 0'.
	report add: 'Balance = 0'.
	
	self assert: report equals: reporter doAccountSummary.! !

!ReporterTest methodsFor: 'testing' stamp: 'ENC 6/2/2021 23:36:15'!
test06TransferNetOfNewPortfolioIsZero

	| account report reporter portfolio |
	
	account := ReceptiveAccount new.	
	portfolio := Portfolio with: account.
	reporter := TransferNetReporter with: portfolio.
	report := 0.
	
	self assert: report equals: reporter doTransferNet.! !

!ReporterTest methodsFor: 'testing' stamp: 'ENC 6/2/2021 23:47:54'!
test07AccountSummaryOfPortfolioHasEveryMovements

	| accountA accountB reporter report portfolio |
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.	
	portfolio := Portfolio with: accountA.
	
	Transfer from: accountA to: accountB of: 10.
	Transfer from: accountB to: accountA of: 15.
	Deposit register: 20 on: accountA.
	Withdraw register: 10 on: accountA.
	
	reporter := AccountSummaryReporter with: portfolio.
	
	report := OrderedCollection new.
	report add: 'Salida por transferencia de 10'.
	report add: 'Entrada por transferencia de 15'.
	report add: 'Depósito por 20'.
	report add: 'Extracción por 10'.
	report add: 'Balance = 15'.
	report add: 'Balance = 15'.
		
	self assert: report equals: reporter doAccountSummary.! !

!ReporterTest methodsFor: 'testing' stamp: 'ENC 6/3/2021 00:58:59'!
test08TransferNetOfPortfolioCalculetesTransferBalance

	| accountA accountB reporter report portfolio |
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.	
	portfolio := Portfolio with: accountA.
	
	Transfer from: accountA to: accountB of: 10.
	Transfer from: accountB to: accountA of: 15.
	Deposit register: 20 on: accountA.
	Withdraw register: 10 on: accountA.
	
	reporter := TransferNetReporter with: portfolio.
	
	report := 5.
		
	self assert: report equals: reporter doTransferNet.! !


!classDefinition: #TransferTest category: 'Portfolio-2'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!TransferTest methodsFor: 'testing' stamp: 'ENC 6/2/2021 23:40:42'!
test01transferAffectAccountBalances

	| amount accountA accountB |
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.	
	amount := 10.
	
	Transfer from: accountA to: accountB of: amount.
	
	self assert: amount equals: accountB balance.
	self assert: amount negated equals: accountA balance.! !

!TransferTest methodsFor: 'testing' stamp: 'ENC 6/3/2021 00:37:51'!
test02TheAmountIsStoredJustInAPlace

	| largeAmount anotherLargeAmount accountA accountB transfer |
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.	
	largeAmount := 100000000000000000000.
	anotherLargeAmount := 100000000000000000001 - 1.
	
	transfer := Transfer from: accountA to: accountB of: largeAmount.
	
	self assert: (transfer amountIs: largeAmount).
	self assert: (transfer legsPointTheSameTransferAmount: largeAmount).
	self deny: (transfer amountIs: 0).
	self deny: (transfer legsPointTheSameTransferAmount: anotherLargeAmount).
	self assert: (largeAmount = anotherLargeAmount).! !

!TransferTest methodsFor: 'testing' stamp: 'ENC 6/3/2021 00:44:48'!
test03TransferLegsCanNavigateBetweenThem

	| remitentAccount beneficiaryAccount anotherAccount transfer anotherTransfer |
	
	remitentAccount := ReceptiveAccount new.
	beneficiaryAccount := ReceptiveAccount new.	
	anotherAccount := ReceptiveAccount new.
	
	transfer := Transfer from: remitentAccount to: beneficiaryAccount of: 10.
	anotherTransfer := Transfer from: remitentAccount to: beneficiaryAccount of: 10.
	
	self assert: (transfer isRegisteredAsCreditIn: remitentAccount andAsDebitIn: beneficiaryAccount).
	self deny: (transfer isRegisteredAsCreditIn: anotherAccount andAsDebitIn: anotherAccount).
	
	self assert: (transfer hasTheSameNavigableLegsThan: transfer).
	self deny: (transfer hasTheSameNavigableLegsThan: anotherTransfer)! !

!TransferTest methodsFor: 'testing' stamp: 'ENC 6/3/2021 00:51:55'!
test04shouldRaiseErrorWhenTransferNegativeAmount

	| accountA accountB |
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.	
	
	self 
		should: [ Transfer from: accountA to: accountB of: -10 ] 
		raise: Error 
		withMessageText: Transfer errorInvalidTransferAmount.! !

!TransferTest methodsFor: 'testing' stamp: 'ENC 6/3/2021 00:56:36'!
test05shouldRaiseErrorWhenTransferBetweenSameAccount

	| account |
	
	account := ReceptiveAccount new.
	
	self 
		should: [ Transfer from: account to: account of: 10 ] 
		raise: Error 
		withMessageText: Transfer errorInvalidTransferAccount.! !


!classDefinition: #Account category: 'Portfolio-2'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

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


!Account methodsFor: 'reports' stamp: 'ENC 6/2/2021 22:32:13'!
report: aReporter

	self subclassResponsibility ! !

!Account methodsFor: 'reports' stamp: 'ENC 6/2/2021 22:50:02'!
reportAccount: aReporter

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-2'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!Portfolio methodsFor: 'accounts management' stamp: 'ENC 5/27/2021 20:46:28'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'ENC 5/27/2021 20:46:28'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'ENC 5/27/2021 20:46:28'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'ENC 5/27/2021 20:46:28'!
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


!Portfolio methodsFor: 'initialization' stamp: 'ENC 5/27/2021 20:46:28'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'ENC 5/27/2021 20:46:28'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'ENC 5/27/2021 20:46:28'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'ENC 5/27/2021 20:46:28'!
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

!Portfolio methodsFor: 'testing' stamp: 'ENC 5/27/2021 20:46:28'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'ENC 5/27/2021 20:46:28'!
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


!Portfolio methodsFor: 'reports' stamp: 'ENC 6/3/2021 02:00:48'!
report: aReporter
	
	aReporter doReportAccount: self. ! !

!Portfolio methodsFor: 'reports' stamp: 'ENC 6/2/2021 22:50:02'!
reportAccount: aReporter
	
	accounts do: [ :account | account report: aReporter ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-2'!
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



!classDefinition: #ReceptiveAccount category: 'Portfolio-2'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

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


!ReceptiveAccount methodsFor: 'reports' stamp: 'ENC 6/3/2021 02:00:43'!
report: aReporter

	aReporter doReportAccount: self. ! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'ENC 6/2/2021 22:50:02'!
reportAccount: aReporter

	transactions do: [ :transaction |  transaction report: aReporter ].! !


!classDefinition: #AccountReporter category: 'Portfolio-2'!
Object subclass: #AccountReporter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!AccountReporter methodsFor: 'initialization' stamp: 'ENC 6/2/2021 22:19:35'!
initializeWith: anAccount

	self subclassResponsibility ! !


!AccountReporter methodsFor: 'operations' stamp: 'ENC 6/2/2021 22:49:19'!
doReportAccount: anAccount

	self subclassResponsibility ! !

!AccountReporter methodsFor: 'operations' stamp: 'ENC 6/2/2021 22:51:18'!
doReportCreditLeg: aCreditLeg

	self subclassResponsibility ! !

!AccountReporter methodsFor: 'operations' stamp: 'ENC 6/2/2021 22:51:28'!
doReportDebitLeg: aDebitLeg

	self subclassResponsibility ! !

!AccountReporter methodsFor: 'operations' stamp: 'ENC 6/2/2021 22:51:36'!
doReportDeposit: aDeposit

	self subclassResponsibility ! !

!AccountReporter methodsFor: 'operations' stamp: 'ENC 6/2/2021 22:51:44'!
doReportWithdraw: aWithdraw

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReporter class' category: 'Portfolio-2'!
AccountReporter class
	instanceVariableNames: ''!

!AccountReporter class methodsFor: 'instance creation' stamp: 'ENC 6/2/2021 22:19:08'!
with: anAccount

	^ self new initializeWith: anAccount. ! !


!classDefinition: #AccountSummaryReporter category: 'Portfolio-2'!
AccountReporter subclass: #AccountSummaryReporter
	instanceVariableNames: 'account report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!AccountSummaryReporter methodsFor: 'operations' stamp: 'ENC 6/2/2021 22:53:04'!
doAccountSummary

	account report: self.
		
	^ report! !

!AccountSummaryReporter methodsFor: 'operations' stamp: 'ENC 6/2/2021 22:49:27'!
doReportAccount: anAccount

	anAccount reportAccount: self.
	
	report add: 'Balance = ', anAccount balance asString.
	
	^ report! !

!AccountSummaryReporter methodsFor: 'operations' stamp: 'ENC 6/2/2021 22:51:18'!
doReportCreditLeg: aCreditLeg

	report add: 'Salida por transferencia de ', aCreditLeg value asString.! !

!AccountSummaryReporter methodsFor: 'operations' stamp: 'ENC 6/2/2021 22:51:28'!
doReportDebitLeg: aDebitLeg

	report add: 'Entrada por transferencia de ', aDebitLeg value asString.! !

!AccountSummaryReporter methodsFor: 'operations' stamp: 'ENC 6/2/2021 22:51:36'!
doReportDeposit: aDeposit

	report add: 'Depósito por ', aDeposit value asString.! !

!AccountSummaryReporter methodsFor: 'operations' stamp: 'ENC 6/2/2021 22:51:44'!
doReportWithdraw: aWithdraw

	report add: 'Extracción por ', aWithdraw value asString.! !


!AccountSummaryReporter methodsFor: 'initialization' stamp: 'ENC 6/2/2021 20:19:09'!
initializeWith: aReceptiveAccount

	account := aReceptiveAccount.
	report := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummaryReporter class' category: 'Portfolio-2'!
AccountSummaryReporter class
	instanceVariableNames: ''!

!AccountSummaryReporter class methodsFor: 'instance creation' stamp: 'ENC 6/2/2021 20:50:18'!
with: anAccount

	^ self new initializeWith: anAccount. ! !


!classDefinition: #TransferNetReporter category: 'Portfolio-2'!
AccountReporter subclass: #TransferNetReporter
	instanceVariableNames: 'account report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!TransferNetReporter methodsFor: 'operations' stamp: 'ENC 6/2/2021 22:49:35'!
doReportAccount: anAccount

	anAccount reportAccount: self.! !

!TransferNetReporter methodsFor: 'operations' stamp: 'ENC 6/2/2021 22:51:18'!
doReportCreditLeg: aCreditLeg
	
	report := report - aCreditLeg value! !

!TransferNetReporter methodsFor: 'operations' stamp: 'ENC 6/2/2021 22:51:28'!
doReportDebitLeg: aDebitLeg

	report := report + aDebitLeg value! !

!TransferNetReporter methodsFor: 'operations' stamp: 'ENC 6/2/2021 22:51:36'!
doReportDeposit: aDeposit
! !

!TransferNetReporter methodsFor: 'operations' stamp: 'ENC 6/2/2021 22:51:44'!
doReportWithdraw: aWithdraw
! !

!TransferNetReporter methodsFor: 'operations' stamp: 'ENC 6/2/2021 22:54:48'!
doTransferNet

	account report: self.
	
	^ report! !


!TransferNetReporter methodsFor: 'initialization' stamp: 'ENC 6/2/2021 20:50:03'!
initializeWith: anAccount

	account := anAccount.
	report := 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNetReporter class' category: 'Portfolio-2'!
TransferNetReporter class
	instanceVariableNames: ''!

!TransferNetReporter class methodsFor: 'instance creation' stamp: 'ENC 6/2/2021 20:50:28'!
with: anAccount

	^ self new initializeWith: anAccount. ! !


!classDefinition: #AccountTransaction category: 'Portfolio-2'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'report' stamp: 'ENC 6/2/2021 22:32:13'!
report: aReporter

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-2'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #CreditLeg category: 'Portfolio-2'!
AccountTransaction subclass: #CreditLeg
	instanceVariableNames: 'value transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!CreditLeg methodsFor: 'report' stamp: 'ENC 6/2/2021 22:51:18'!
report: aReporter

	aReporter doReportCreditLeg: self.! !


!CreditLeg methodsFor: 'initialization' stamp: 'ENC 6/3/2021 00:18:32'!
initializeFor: aValue from: aTransfer

	value := aValue.
	transfer := aTransfer. ! !


!CreditLeg methodsFor: 'value' stamp: 'ENC 6/1/2021 23:08:16'!
value

	^ value! !


!CreditLeg methodsFor: 'transfer' stamp: 'ENC 6/3/2021 00:17:27'!
belongsTo: aTransfer

	^ transfer = aTransfer.! !


!CreditLeg methodsFor: 'balance' stamp: 'ENC 6/1/2021 23:07:42'!
affectBalance: aBalance

	^aBalance - value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditLeg class' category: 'Portfolio-2'!
CreditLeg class
	instanceVariableNames: ''!

!CreditLeg class methodsFor: 'instance creation' stamp: 'ENC 6/3/2021 00:18:15'!
for: aValue from: aTransfer

	^ self new initializeFor: aValue from: aTransfer. ! !


!classDefinition: #DebitLeg category: 'Portfolio-2'!
AccountTransaction subclass: #DebitLeg
	instanceVariableNames: 'value transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!DebitLeg methodsFor: 'initialization' stamp: 'ENC 6/3/2021 00:18:58'!
initializeFor: aValue from: aTransfer

	value := aValue. 
	transfer := aTransfer. ! !


!DebitLeg methodsFor: 'report' stamp: 'ENC 6/2/2021 22:51:28'!
report: aReporter

	aReporter doReportDebitLeg: self.! !


!DebitLeg methodsFor: 'value' stamp: 'ENC 6/1/2021 23:08:13'!
value

	^ value! !


!DebitLeg methodsFor: 'balance' stamp: 'ENC 6/1/2021 23:07:34'!
affectBalance: aBalance

	^aBalance + value ! !


!DebitLeg methodsFor: 'transfer' stamp: 'ENC 6/3/2021 00:23:15'!
belongsTo: aTransfer

	^ transfer = aTransfer.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DebitLeg class' category: 'Portfolio-2'!
DebitLeg class
	instanceVariableNames: ''!

!DebitLeg class methodsFor: 'instance creation' stamp: 'ENC 6/3/2021 00:19:08'!
for: aValue from: aTransfer

	^ self new initializeFor: aValue from: aTransfer! !


!classDefinition: #Deposit category: 'Portfolio-2'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'report' stamp: 'ENC 6/2/2021 22:51:36'!
report: aReporter

	aReporter doReportDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-2'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-2'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'report' stamp: 'ENC 6/2/2021 22:51:44'!
report: aReporter

	aReporter doReportWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-2'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'Portfolio-2'!
Object subclass: #Transfer
	instanceVariableNames: 'amount debitLeg creditLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!


!Transfer methodsFor: 'comparing' stamp: 'ENC 5/30/2021 23:30:48'!
amountIs: anAmountOfMoney 
	
	^ amount = anAmountOfMoney.! !

!Transfer methodsFor: 'comparing' stamp: 'ENC 6/3/2021 00:24:06'!
hasTheSameNavigableLegsThan: anotherTransfer

	^ ( debitLeg belongsTo: anotherTransfer ) and: [ creditLeg belongsTo: anotherTransfer ].! !

!Transfer methodsFor: 'comparing' stamp: 'ENC 6/3/2021 00:24:06'!
isRegisteredAsCreditIn: aRemittentAccount andAsDebitIn: aBenefficiaryAccount 
	
	^ ( aRemittentAccount hasRegistered: creditLeg ) and: [ aBenefficiaryAccount hasRegistered: debitLeg ].! !

!Transfer methodsFor: 'comparing' stamp: 'ENC 6/3/2021 00:34:03'!
legsPointTheSameTransferAmount: anAmountOfMoney

	^ (debitLeg value == anAmountOfMoney) and: [ creditLeg value == anAmountOfMoney ].! !


!Transfer methodsFor: 'error signaling' stamp: 'ENC 6/3/2021 00:55:32'!
signalErrorInvalidTransferAccount

	^ self error: self class errorInvalidTransferAccount.! !

!Transfer methodsFor: 'error signaling' stamp: 'ENC 6/3/2021 00:50:18'!
signalErrorInvalidTransferAmount

	^ self error: self class errorInvalidTransferAmount.! !


!Transfer methodsFor: 'initialization' stamp: 'ENC 6/3/2021 01:02:00'!
initializeFrom: aRemitentAccount to: aReceptiveAccount of: anAmountOfMoney
	
	( anAmountOfMoney < 0 ) ifTrue: [ ^ self signalErrorInvalidTransferAmount ]. 
	( aRemitentAccount  = aReceptiveAccount ) ifTrue: [ ^ self signalErrorInvalidTransferAccount ].
	
	amount := anAmountOfMoney.
	
	debitLeg := DebitLeg for: anAmountOfMoney from: self.
	aReceptiveAccount register: debitLeg.
	
	creditLeg := CreditLeg for: anAmountOfMoney from: self.
	aRemitentAccount register: creditLeg.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-2'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'ENC 5/30/2021 23:28:41'!
from: aRemitenteAccount to: aReceiverAccount of: anAmountOfMoney

	^ self new initializeFrom: aRemitenteAccount to: aReceiverAccount of: anAmountOfMoney ! !


!Transfer class methodsFor: 'error descriptions' stamp: 'ENC 6/3/2021 00:55:47'!
errorInvalidTransferAccount

	^ 'No puede realizarse una transferencia entre la misma cuenta.' ! !

!Transfer class methodsFor: 'error descriptions' stamp: 'ENC 6/3/2021 00:50:09'!
errorInvalidTransferAmount

	^ 'No puede realizarse una transferencia de monto negativo.' ! !
