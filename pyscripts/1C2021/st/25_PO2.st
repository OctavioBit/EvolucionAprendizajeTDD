!classDefinition: #AccountSummaryTest category: 'Portfolio'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountSummaryTest methodsFor: 'tests' stamp: 'LM 6/3/2021 16:15:08'!
test01summaryForAccountWithDeposit

	| account result summaryBuilder |
	
	account := ReceptiveAccount new.
	summaryBuilder := SummaryBuilder new.
	Deposit register: 100 on: account.
	result := OrderedCollection with: 'Depósito por 100.' with: 'Balance = 100'.
	
	self assert: result equals: (account getReport: summaryBuilder).! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'LM 6/3/2021 16:15:23'!
test02summaryForAccountWithWithdraw

	| account result summaryBuilder |
	
	account := ReceptiveAccount new.
	summaryBuilder := SummaryBuilder new.
	Withdraw register: 50 on: account.
	result := OrderedCollection with: 'Extracción por 50.' with: 'Balance = -50'.
	
	self assert: result equals: (account getReport: summaryBuilder).! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'LM 6/3/2021 16:16:01'!
test03summaryForAccountWithOutboundTransferLeg

	| account1 result account2 summaryBuilder |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	summaryBuilder := SummaryBuilder new.
	Transfer from: account1 to: account2 for: 20.
	result := OrderedCollection with: 'Salida por transferencia de 20.' with: 'Balance = -20'.
	
	self assert: result equals: (account1 getReport: summaryBuilder).! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'LM 6/3/2021 16:16:13'!
test04summaryForAccountWithInboundTransferLeg

	| account1 result account2 summaryBuilder |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	summaryBuilder := SummaryBuilder new.
	Transfer from: account1 to: account2 for: 20.
	result := OrderedCollection with: 'Entrada por transferencia de 20.' with: 'Balance = 20'.
	
	self assert: result equals: (account2 getReport: summaryBuilder).! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'LM 6/3/2021 16:17:16'!
test05summaryForAccountWithSeveralTransactions

	| account1 result account2 summaryBuilder |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	summaryBuilder := SummaryBuilder new.
	Deposit register: 100 on: account1.
	Withdraw register: 50 on: account1.
	Transfer from: account1 to: account2 for: 20.
	
	result := OrderedCollection with: 'Depósito por 100.'
						      with: 'Extracción por 50.'
						      with: 'Salida por transferencia de 20.'
						      with: 'Balance = 30'.
	
	self assert: result equals: (account1 getReport: summaryBuilder).! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'LM 6/3/2021 16:17:55'!
test06summaryForPortfolio

	| account1 result account2 portfolio summaryBuilder |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio := Portfolio with: account1 with: account2.
	summaryBuilder := SummaryBuilder new.
	Deposit register: 100 on: account1.
	Withdraw register: 50 on: account1.
	Transfer from: account1 to: account2 for: 20.
	
	result := OrderedCollection with: 'Depósito por 100.'
						      with: 'Extracción por 50.'
						      with: 'Salida por transferencia de 20.'
						      with: 'Entrada por transferencia de 20.'
						      with: 'Balance = 50'.
	
	self assert: result equals: (portfolio getReport: summaryBuilder).! !


!classDefinition: #PortfolioTest category: 'Portfolio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

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


!classDefinition: #ReceptiveAccountTest category: 'Portfolio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

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


!classDefinition: #TransferNetTest category: 'Portfolio'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!TransferNetTest methodsFor: 'tests' stamp: 'LM 6/3/2021 16:06:36'!
test01transferNetForAccountWithoutTransfersIsZero

	| account transferNetCalculator |
	
	account := ReceptiveAccount new.
	transferNetCalculator := TransferNetCalculator new.
	
	self assert: 0 equals: (account getReport: transferNetCalculator).! !

!TransferNetTest methodsFor: 'tests' stamp: 'LM 6/3/2021 16:06:46'!
test02inboundTransferIncreasesTranferNetByTransferValue

	| account1 account2 transferNetCalculator |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	transferNetCalculator := TransferNetCalculator new.
	Transfer from: account1 to: account2 for: 100.
	
	self assert: 100 equals: (account2 getReport: transferNetCalculator).! !

!TransferNetTest methodsFor: 'tests' stamp: 'LM 6/3/2021 16:06:53'!
test03outboundTransferReducesTranferNetByTransferValue

	| account1 account2 transferNetCalculator |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	transferNetCalculator := TransferNetCalculator new.
	Transfer from: account1 to: account2 for: 100.
	
	self assert: -100 equals: (account1 getReport: transferNetCalculator).! !

!TransferNetTest methodsFor: 'tests' stamp: 'LM 6/3/2021 16:06:58'!
test04tranferNetIsBalanceOfOutboundAndInboundTransfers

	| account1 account2 transferNetCalculator |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	transferNetCalculator := TransferNetCalculator new.
	Transfer from: account1 to: account2 for: 100.
	Transfer from: account2 to: account1 for: 50.
	
	self assert: -50 equals: (account1 getReport: transferNetCalculator).! !

!TransferNetTest methodsFor: 'tests' stamp: 'LM 6/3/2021 16:07:04'!
test05tranferNetIsTotalOfPortfolioAccountsTransferNets

	| account1 account2 portfolio transferNetCalculator |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio := Portfolio with: account1 with: account2.
	transferNetCalculator := TransferNetCalculator new.
	Transfer from: account1 to: account2 for: 100.
	Transfer from: account2 to: account1 for: 50.
	
	self assert: 0 equals: (portfolio getReport: transferNetCalculator).! !


!classDefinition: #TransferTest category: 'Portfolio'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!TransferTest methodsFor: 'tests' stamp: 'LM 6/3/2021 16:11:28'!
test01transferAffectsAccountsBalances

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Transfer from: account1 to: account2 for: 100.
	
	self assert: -100 equals: account1 balance.
	self assert: 100 equals: account2 balance.! !

!TransferTest methodsFor: 'tests' stamp: 'LM 6/3/2021 16:12:28'!
test02legsCanReachEachOther

	| account1 account2 deposit withdraw |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Transfer from: account1 to: account2 for: 100.
	withdraw := account1 transactions first.
	deposit := account2 transactions first.
	
	self assert: deposit equals: (withdraw destinationLeg).
	self assert: withdraw equals: (deposit sourceLeg).! !

!TransferTest methodsFor: 'tests' stamp: 'LM 6/3/2021 16:13:48'!
test03legsKnowTheirTransfersValue

	| account1 account2 deposit withdraw |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Transfer from: account1 to: account2 for: 100.
	withdraw := account1 transactions first.
	deposit := account2 transactions first.
	
	self assert: 100 equals: (withdraw value).
	self assert: 100 equals: (deposit value).! !


!classDefinition: #Account category: 'Portfolio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

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


!Account methodsFor: 'reporting - private' stamp: 'LM 6/3/2021 16:50:26'!
doFor: aReporter

	self subclassResponsibility! !


!Account methodsFor: 'reporting' stamp: 'LM 6/3/2021 16:19:22'!
getReport: aReporter

	self subclassResponsibility! !


!classDefinition: #Portfolio category: 'Portfolio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

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


!Portfolio methodsFor: 'reporting - private' stamp: 'LM 6/3/2021 16:49:19'!
doFor: aReporter

	aReporter doForPortfolio: self.! !

!Portfolio methodsFor: 'reporting - private' stamp: 'LM 6/3/2021 16:52:55'!
forEachAccountDoFor: aReporter

	accounts do: [ :account | account doFor: aReporter ].! !


!Portfolio methodsFor: 'reporting' stamp: 'LM 6/3/2021 14:33:09'!
getReport: aReporter

	^aReporter getReportForPortfolio: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error description' stamp: 'HAW 5/25/2019 11:48:55'!
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


!classDefinition: #ReceptiveAccount category: 'Portfolio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

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


!ReceptiveAccount methodsFor: 'reporting - private' stamp: 'LM 6/3/2021 16:49:57'!
doFor: aReporter

	aReporter doForReceptiveAccount: self.! !

!ReceptiveAccount methodsFor: 'reporting - private' stamp: 'LM 6/3/2021 16:53:41'!
forEachTransactionDoFor: aReporter

	transactions do: [ :transaction | transaction doFor: aReporter ].! !


!ReceptiveAccount methodsFor: 'reporting' stamp: 'LM 6/3/2021 14:54:07'!
getReport: aReporter

	^aReporter getReportForReceptiveAccount: self! !


!classDefinition: #AccountTransaction category: 'Portfolio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'reporting - private' stamp: 'LM 6/2/2021 22:39:57'!
doFor: aReporter

	self subclassResponsibility! !


!classDefinition: #Deposit category: 'Portfolio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'reporting - private' stamp: 'LM 6/2/2021 22:45:30'!
doFor: aReporter

	^aReporter doForDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'LM 6/2/2021 18:24:53'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferLeg category: 'Portfolio'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!TransferLeg methodsFor: 'initialization' stamp: 'LM 6/2/2021 18:29:56'!
initializeFor: aTransfer

	transfer := aTransfer.! !


!TransferLeg methodsFor: 'value' stamp: 'LM 6/2/2021 18:30:01'!
value

	^transfer value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'Portfolio'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'LM 6/2/2021 18:30:39'!
for: aTransfer

	^self new initializeFor: aTransfer! !

!TransferLeg class methodsFor: 'instance creation' stamp: 'LM 6/2/2021 18:30:44'!
registerFor: aTransfer on: account 

	| transaction |
	
	transaction := self for: aTransfer.
	account register: transaction.
	^transaction! !


!classDefinition: #InboundLeg category: 'Portfolio'!
TransferLeg subclass: #InboundLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!


!InboundLeg methodsFor: 'balance' stamp: 'LM 5/31/2021 15:38:05'!
affectBalance: aBalance

	^aBalance + transfer value! !


!InboundLeg methodsFor: 'accessing' stamp: 'LM 6/2/2021 18:23:25'!
sourceLeg

	^transfer sourceLeg! !



!InboundLeg methodsFor: 'reporting - private' stamp: 'LM 6/2/2021 22:45:35'!
doFor: aReporter

	^aReporter doForInboundLeg: self.! !


!classDefinition: #OutboundLeg category: 'Portfolio'!
TransferLeg subclass: #OutboundLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!


!OutboundLeg methodsFor: 'accessing' stamp: 'LM 6/2/2021 18:21:41'!
destinationLeg

	^transfer destinationLeg! !


!OutboundLeg methodsFor: 'balance' stamp: 'LM 5/31/2021 15:38:50'!
affectBalance: aBalance

	^aBalance - transfer value! !



!OutboundLeg methodsFor: 'reporting - private' stamp: 'LM 6/2/2021 22:45:41'!
doFor: aReporter

	^aReporter doForOutboundLeg: self.! !


!classDefinition: #Withdraw category: 'Portfolio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'reporting - private' stamp: 'LM 6/2/2021 22:45:46'!
doFor: aReporter

	^aReporter doForWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'LM 6/2/2021 18:24:53'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Reporter category: 'Portfolio'!
Object subclass: #Reporter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Reporter methodsFor: 'reporting' stamp: 'LM 6/3/2021 16:28:36'!
doForDeposit: aDeposit

	self subclassResponsibility! !

!Reporter methodsFor: 'reporting' stamp: 'LM 6/3/2021 16:28:53'!
doForInboundLeg: anInboundLeg

	self subclassResponsibility! !

!Reporter methodsFor: 'reporting' stamp: 'LM 6/3/2021 16:29:09'!
doForOutboundLeg: anOutboundLeg

	self subclassResponsibility! !

!Reporter methodsFor: 'reporting' stamp: 'LM 6/3/2021 16:50:49'!
doForPortfolio: aPortfolio

	self subclassResponsibility! !

!Reporter methodsFor: 'reporting' stamp: 'LM 6/3/2021 16:51:07'!
doForReceptiveAccount: aReceptiveAccount

	self subclassResponsibility! !

!Reporter methodsFor: 'reporting' stamp: 'LM 6/3/2021 16:29:22'!
doForWithdraw: aWithdraw

	self subclassResponsibility! !

!Reporter methodsFor: 'reporting' stamp: 'LM 6/3/2021 16:04:28'!
getReportForPortfolio: aPortfolio

	self subclassResponsibility! !

!Reporter methodsFor: 'reporting' stamp: 'LM 6/3/2021 14:54:07'!
getReportForReceptiveAccount: aReceptiveAccount

	self subclassResponsibility! !


!classDefinition: #SummaryBuilder category: 'Portfolio'!
Reporter subclass: #SummaryBuilder
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!SummaryBuilder methodsFor: 'initialization' stamp: 'LM 6/3/2021 16:09:15'!
initialize 

	summary := OrderedCollection new.! !


!SummaryBuilder methodsFor: 'reporting' stamp: 'LM 6/3/2021 15:01:01'!
doForDeposit: aDeposit

	summary add: 'Depósito por ', aDeposit value asString, '.'.! !

!SummaryBuilder methodsFor: 'reporting' stamp: 'LM 6/3/2021 15:01:12'!
doForInboundLeg: anInboundLeg

	summary add: 'Entrada por transferencia de ', anInboundLeg value asString, '.'.! !

!SummaryBuilder methodsFor: 'reporting' stamp: 'LM 6/3/2021 15:01:25'!
doForOutboundLeg: anOutboundLeg

	summary add: 'Salida por transferencia de ', anOutboundLeg value asString, '.'.! !

!SummaryBuilder methodsFor: 'reporting' stamp: 'LM 6/3/2021 16:44:51'!
doForPortfolio: aPortfolio

	aPortfolio forEachAccountDoFor: self.! !

!SummaryBuilder methodsFor: 'reporting' stamp: 'LM 6/3/2021 16:45:33'!
doForReceptiveAccount: aReceptiveAccount

	aReceptiveAccount forEachTransactionDoFor: self.! !

!SummaryBuilder methodsFor: 'reporting' stamp: 'LM 6/3/2021 15:01:33'!
doForWithdraw: aWithdraw

	summary add: 'Extracción por ', aWithdraw value asString, '.'.! !

!SummaryBuilder methodsFor: 'reporting' stamp: 'LM 6/3/2021 16:42:37'!
getReportForPortfolio: aPortfolio

	aPortfolio forEachAccountDoFor: self.
	
	summary add: 'Balance = ', aPortfolio balance asString.
	
	^summary! !

!SummaryBuilder methodsFor: 'reporting' stamp: 'LM 6/3/2021 16:45:53'!
getReportForReceptiveAccount: aReceptiveAccount

	aReceptiveAccount forEachTransactionDoFor: self.
	
	summary add: 'Balance = ', aReceptiveAccount balance asString.
	
	^summary! !


!classDefinition: #TransferNetCalculator category: 'Portfolio'!
Reporter subclass: #TransferNetCalculator
	instanceVariableNames: 'transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!TransferNetCalculator methodsFor: 'initialization' stamp: 'LM 6/3/2021 16:09:26'!
initialize 

	transferNet := 0.! !


!TransferNetCalculator methodsFor: 'reporting' stamp: 'LM 6/3/2021 15:01:57'!
doForDeposit: aDeposit

	! !

!TransferNetCalculator methodsFor: 'reporting' stamp: 'LM 6/3/2021 15:03:11'!
doForInboundLeg: anInboundLeg

	transferNet := transferNet + anInboundLeg value.! !

!TransferNetCalculator methodsFor: 'reporting' stamp: 'LM 6/3/2021 15:03:30'!
doForOutboundLeg: anOutboundLeg

	transferNet := transferNet - anOutboundLeg value.! !

!TransferNetCalculator methodsFor: 'reporting' stamp: 'LM 6/3/2021 16:47:16'!
doForPortfolio: aPortfolio

	aPortfolio forEachAccountDoFor: self.

	! !

!TransferNetCalculator methodsFor: 'reporting' stamp: 'LM 6/3/2021 16:48:02'!
doForReceptiveAccount: aReceptiveAccount

	aReceptiveAccount forEachTransactionDoFor: self.! !

!TransferNetCalculator methodsFor: 'reporting' stamp: 'LM 6/3/2021 15:02:16'!
doForWithdraw: aWithdraw

	! !

!TransferNetCalculator methodsFor: 'reporting' stamp: 'LM 6/3/2021 16:46:13'!
getReportForPortfolio: aPortfolio

	aPortfolio forEachAccountDoFor: self.
	
	^transferNet! !

!TransferNetCalculator methodsFor: 'reporting' stamp: 'LM 6/3/2021 16:46:27'!
getReportForReceptiveAccount: aReceptiveAccount

	aReceptiveAccount forEachTransactionDoFor: self.
	
	^transferNet! !


!classDefinition: #Transfer category: 'Portfolio'!
Object subclass: #Transfer
	instanceVariableNames: 'value sourceLeg destinationLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Transfer methodsFor: 'initialization' stamp: 'LM 6/2/2021 18:22:44'!
initializeFrom: sourceAccount to: destinationAccount for: aValue

	value := aValue.
	sourceLeg := OutboundLeg registerFor: self on: sourceAccount.
	destinationLeg := InboundLeg registerFor: self on: destinationAccount.! !


!Transfer methodsFor: 'accessing' stamp: 'LM 6/2/2021 18:22:07'!
destinationLeg

	^destinationLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LM 6/2/2021 18:22:44'!
sourceLeg

	^sourceLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LM 5/31/2021 15:38:24'!
value

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'LM 5/31/2021 15:57:42'!
from: sourceAccount to: destinationAccount for: aValue

	^self new initializeFrom: sourceAccount to: destinationAccount for: aValue.! !
