!classDefinition: #AccountReporterTest category: 'Portfolio-Solucion'!
TestCase subclass: #AccountReporterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountReporterTest methodsFor: 'tests' stamp: 'GDH 6/3/2021 00:32:54'!
test01AccountSummaryForEmptyAccountShowsOnlyBalanceInZero
	
	| expectedSummary anAccountSummaryGenerator |
	
	expectedSummary := OrderedCollection with: 'Balance = 0'.  
	
	anAccountSummaryGenerator := AccountSummaryReporter for: ReceptiveAccount new.
	
	self assert: expectedSummary = anAccountSummaryGenerator accountSummary .! !

!AccountReporterTest methodsFor: 'tests' stamp: 'GDH 6/3/2021 00:49:32'!
test02AccountSummaryForAccountWithDepositShowsDepositTransactionAndBalance

	| expectedSummary account anAccountSummaryGenerator |
	
	expectedSummary := OrderedCollection with: 'Depósito por 100.' with: 'Balance = 100'. 
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account .
	
	anAccountSummaryGenerator := AccountSummaryReporter for: account.
	
	self assert: expectedSummary = anAccountSummaryGenerator accountSummary.! !

!AccountReporterTest methodsFor: 'tests' stamp: 'GDH 6/3/2021 00:49:35'!
test03AccountSummaryForAccountWithWithdrawShowsWithdrawTransactionAndBalance

	| expectedSummary account anAccountSummaryGenerator |
	
	expectedSummary := OrderedCollection with: 'Extracción por 100.' with: 'Balance = -100'. 
	
	account := ReceptiveAccount new.
	Withdraw register: 100 on: account.
	
	anAccountSummaryGenerator := AccountSummaryReporter for: account.
	
	self assert: expectedSummary = anAccountSummaryGenerator accountSummary.! !

!AccountReporterTest methodsFor: 'tests' stamp: 'GDH 6/3/2021 00:49:38'!
test04AccountSummaryForAccountWithSendingTransferShowsReceivingTransferAndBalance

	| expectedSummary account anAccountSummaryGenerator |
	
	expectedSummary := OrderedCollection with: 'Salida por transferencia de 100.' with: 'Balance = -100'. 
	
	account := ReceptiveAccount new.
	
	AccountTransfer register: 100 from: account to: ReceptiveAccount new.
	
	anAccountSummaryGenerator := AccountSummaryReporter for: account.
	
	self assert: expectedSummary = anAccountSummaryGenerator accountSummary.! !

!AccountReporterTest methodsFor: 'tests' stamp: 'GDH 6/3/2021 00:49:42'!
test05AccountSummaryForAccountWithReceivingTransferShowsReceivingTransferAndBalance

	| expectedSummary account anAccountSummaryGenerator |
	
	expectedSummary := OrderedCollection with: 'Entrada por transferencia de 100.' with: 'Balance = 100'. 
	
	account := ReceptiveAccount new.
	
	AccountTransfer register: 100 from: ReceptiveAccount new to: account.
	
	anAccountSummaryGenerator := AccountSummaryReporter for: account.
	
	self assert: expectedSummary = anAccountSummaryGenerator accountSummary.! !

!AccountReporterTest methodsFor: 'tests' stamp: 'GDH 6/3/2021 00:49:48'!
test06TransferNetForEmptyAccountIsZero
	
	| expectedTransferNet aTransferNetGenerator |
	
	expectedTransferNet := 0.  
	
	aTransferNetGenerator := TransferNetReporter for: ReceptiveAccount new.
	
	self assert: expectedTransferNet = aTransferNetGenerator transferNet .! !

!AccountReporterTest methodsFor: 'tests' stamp: 'GDH 6/3/2021 00:49:53'!
test07TransferNetForAccountWithOnlyRecevingTransfersShouldBeTransfersValues
	
	| expectedTransferNet account aTransferNetGenerator |
	
	expectedTransferNet := 100.
	
	account := ReceptiveAccount new.
	
	AccountTransfer register: 100 from: ReceptiveAccount new to: account .
	
	aTransferNetGenerator := TransferNetReporter for: account.
	
	self assert: expectedTransferNet = aTransferNetGenerator transferNet.! !

!AccountReporterTest methodsFor: 'tests' stamp: 'GDH 6/3/2021 00:49:55'!
test08TransferNetForAccountWithOnlySendingTransfersShouldBeNegativeTransfersValues
	
	| expectedTransferNet account aTransferNetGenerator |
	
	expectedTransferNet := -100.
	
	account := ReceptiveAccount new.
	
	AccountTransfer register: 100 from: account to: ReceptiveAccount new.
	
	aTransferNetGenerator := TransferNetReporter for: account.
	
	self assert: expectedTransferNet = aTransferNetGenerator transferNet.! !

!AccountReporterTest methodsFor: 'tests' stamp: 'GDH 6/3/2021 00:49:59'!
test09TransferNetForAccountWithSendingAndReceivingTransfersShouldBeNetValue
	
	| expectedTransferNet account aTransferNetGenerator |
	
	expectedTransferNet := 50.
	
	account := ReceptiveAccount new.
	
	AccountTransfer register: 50 from: account to: ReceptiveAccount new.
	AccountTransfer register: 100 from: ReceptiveAccount new to: account.
	
	aTransferNetGenerator := TransferNetReporter for: account.
	
	self assert: expectedTransferNet = aTransferNetGenerator transferNet.! !

!AccountReporterTest methodsFor: 'tests' stamp: 'GDH 6/3/2021 00:50:01'!
test10TransferNetShouldNotTakeInAccountDepositAndWithdrawTransactions
	
	| expectedTransferNet account aTransferNetGenerator |
	
	expectedTransferNet := 50.
	
	account := ReceptiveAccount new.
	
	AccountTransfer register: 50 from: account to: ReceptiveAccount new.
	AccountTransfer register: 100 from: ReceptiveAccount new to: account.
	Deposit register: 25 on: account .
	Withdraw register: 80 on: account .
	
	aTransferNetGenerator := TransferNetReporter for: account .
	
	self assert: expectedTransferNet = aTransferNetGenerator transferNet.! !

!AccountReporterTest methodsFor: 'tests' stamp: 'GDH 6/3/2021 01:18:44'!
test11AccountSummaryForPortfolioShowsAllTransactionsAndBalance
	
	| expectedAccountSummary childSummary anAccountSummaryReporter parentPortfolio childPortfolio parentAccount childAccount |
	
	expectedAccountSummary := OrderedCollection 
		with: 'Depósito por 100.'
		with: 'Extracción por 50.'
		with: 'Salida por transferencia de 20.'
		with: 'Entrada por transferencia de 30.'
		with: 'Balance = 60'.
	
	childSummary := OrderedCollection
		with: 'Depósito por 50.'
		with: 'Balance = 50'.
		
	expectedAccountSummary addAll: childSummary .
	
	expectedAccountSummary add: 'Balance = 50'.
	expectedAccountSummary add: 'Balance = 110'.
		
	parentAccount := ReceptiveAccount new.
	childAccount := ReceptiveAccount new.
	parentPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	
	parentPortfolio add: parentAccount.
	childPortfolio add: childAccount.
	parentPortfolio add: childPortfolio .
	
	Deposit register: 100 on: parentAccount .
	Withdraw register: 50 on: parentAccount .
	AccountTransfer register: 20 from: parentAccount to: ReceptiveAccount new.
	AccountTransfer register: 30 from: ReceptiveAccount new to: parentAccount .
	
	Deposit register: 50 on: childAccount .
	
	anAccountSummaryReporter := AccountSummaryReporter for: parentPortfolio .
	
	self assert: expectedAccountSummary = anAccountSummaryReporter accountSummary .! !

!AccountReporterTest methodsFor: 'tests' stamp: 'GDH 6/3/2021 00:50:10'!
test12TransferNetForPortfolioCalculatesNetValueOfTransferTransactions
	
	| expectedTransferNet aTransferNetReporter portfolio account |
	
	expectedTransferNet := 10.
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	portfolio add: account.
	
	Deposit register: 100 on: account .
	Withdraw register: 50 on: account .
	AccountTransfer register: 20 from: account to: ReceptiveAccount new.
	AccountTransfer register: 30 from: ReceptiveAccount new to: account .
	
	aTransferNetReporter := TransferNetReporter for: portfolio .
	
	self assert: expectedTransferNet = aTransferNetReporter transferNet.! !


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


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'tests' stamp: 'GDH 6/3/2021 16:25:45'!
test01TransferFromAccountAAddsToAccountB
	
	| senderAccount receiverAccount |
	
	senderAccount := ReceptiveAccount new. 
	receiverAccount := ReceptiveAccount new.
	
	AccountTransfer register: 50 from: senderAccount to: receiverAccount.
	
	self assert: senderAccount balance = -50.
	self assert: receiverAccount balance = 50.! !

!TransferTest methodsFor: 'tests' stamp: 'GDH 6/3/2021 16:26:03'!
test02TransferKnowsBothLegs
	
	| transfer senderAccount receiverAccount |
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	transfer := AccountTransfer register: 50 from: senderAccount to: receiverAccount.
	
	self assert: ( senderAccount hasRegistered: transfer senderLeg ).
	self deny: ( senderAccount hasRegistered: transfer receiverLeg ).
	
	self assert: ( receiverAccount hasRegistered: transfer receiverLeg ).
	self deny: ( receiverAccount hasRegistered: transfer senderLeg ).! !

!TransferTest methodsFor: 'tests' stamp: 'GDH 6/3/2021 16:26:17'!
test03TransferLegsCanReachOppositeLegs
	
	| transfer senderAccount receiverAccount |
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	transfer := AccountTransfer register: 50 from: senderAccount to: receiverAccount.
	
	self assert: ( transfer receiverLeg = transfer senderLeg oppositeLeg ).
	self assert: ( transfer senderLeg = transfer receiverLeg oppositeLeg ).! !


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


!Account methodsFor: 'report' stamp: 'GDH 6/3/2021 01:26:12'!
makeReport: anAccountReporter

	self subclassResponsibility ! !

!Account methodsFor: 'report' stamp: 'GDH 6/3/2021 01:26:05'!
reportTransactions: anAccountReporter

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


!Portfolio methodsFor: 'report' stamp: 'GDH 6/3/2021 01:26:17'!
makeReport: anAccountReporter

	anAccountReporter report: self.! !

!Portfolio methodsFor: 'report' stamp: 'GDH 6/3/2021 01:15:45'!
reportTransactions: anAccountReporter

	accounts do: [ :anAccount | anAccountReporter report: anAccount ].! !

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


!ReceptiveAccount methodsFor: 'reports' stamp: 'GDH 6/3/2021 01:16:14'!
makeReport: anAccountReporter
	
	anAccountReporter report: self
! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'GDH 6/3/2021 00:44:53'!
reportTransactions: anAccountReporter
	
	self transactions do: [ :aTransaction | aTransaction reportTransaction: anAccountReporter. ].
! !


!classDefinition: #AccountReporter category: 'Portfolio-Solucion'!
Object subclass: #AccountReporter
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountReporter methodsFor: 'initialization' stamp: 'GDH 6/2/2021 21:59:59'!
initializeFor: aReceptiveAccount

	account := aReceptiveAccount! !


!AccountReporter methodsFor: 'visit transaction operations' stamp: 'GDH 6/2/2021 21:40:56'!
reportDeposit: aDeposit
	
	^self subclassResponsibility! !

!AccountReporter methodsFor: 'visit transaction operations' stamp: 'GDH 6/2/2021 21:41:24'!
reportTransferReceiverLeg: aTransferReceiverLeg
	
	^self subclassResponsibility! !

!AccountReporter methodsFor: 'visit transaction operations' stamp: 'GDH 6/2/2021 21:41:33'!
reportTransferSenderLeg: aTransferSenderLeg
	
	^self subclassResponsibility! !

!AccountReporter methodsFor: 'visit transaction operations' stamp: 'GDH 6/2/2021 21:41:46'!
reportWithdraw: aWithdraw
	
	^self subclassResponsibility! !


!AccountReporter methodsFor: 'report' stamp: 'GDH 6/2/2021 21:39:18'!
report
	
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReporter class' category: 'Portfolio-Solucion'!
AccountReporter class
	instanceVariableNames: ''!

!AccountReporter class methodsFor: 'instance creation' stamp: 'GDH 6/2/2021 21:38:13'!
for: anAccount

	^self new initializeFor: anAccount.! !


!classDefinition: #AccountSummaryReporter category: 'Portfolio-Solucion'!
AccountReporter subclass: #AccountSummaryReporter
	instanceVariableNames: 'accountSummary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryReporter methodsFor: 'report' stamp: 'GDH 6/3/2021 00:31:03'!
accountSummary
	
	accountSummary := OrderedCollection new.

	account makeReport: self.
		
	^accountSummary ! !

!AccountSummaryReporter methodsFor: 'report' stamp: 'GDH 6/3/2021 01:15:11'!
report: anAccount

	anAccount reportTransactions: self.
	
	accountSummary add: 'Balance = ' , anAccount balance asString .! !


!AccountSummaryReporter methodsFor: 'visit transaction operations' stamp: 'GDH 6/2/2021 22:39:59'!
reportDeposit: aDeposit

	accountSummary add: 'Depósito por ' , aDeposit value asString , '.'.! !

!AccountSummaryReporter methodsFor: 'visit transaction operations' stamp: 'GDH 6/2/2021 22:40:58'!
reportTransferReceiverLeg: aTransferReceiverLeg

	accountSummary add: 'Entrada por transferencia de ' , aTransferReceiverLeg value asString , '.'.
	! !

!AccountSummaryReporter methodsFor: 'visit transaction operations' stamp: 'GDH 6/2/2021 22:41:30'!
reportTransferSenderLeg: aTransferSenderLeg

	accountSummary add: 'Salida por transferencia de ' , aTransferSenderLeg value asString , '.'.
	! !

!AccountSummaryReporter methodsFor: 'visit transaction operations' stamp: 'GDH 6/2/2021 22:41:11'!
reportWithdraw: aWithdraw

	accountSummary add: 'Extracción por ' , aWithdraw value asString , '.'.! !


!classDefinition: #TransferNetReporter category: 'Portfolio-Solucion'!
AccountReporter subclass: #TransferNetReporter
	instanceVariableNames: 'transferNetAccumulated'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetReporter methodsFor: 'report' stamp: 'GDH 6/3/2021 01:22:11'!
report: anAccount

	anAccount reportTransactions: self! !

!TransferNetReporter methodsFor: 'report' stamp: 'GDH 6/3/2021 00:48:30'!
transferNet

	transferNetAccumulated := 0.

	account makeReport: self.
	
	^transferNetAccumulated! !


!TransferNetReporter methodsFor: 'visit transaction operations' stamp: 'GDH 6/2/2021 22:26:00'!
reportDeposit: aDeposit

	transferNetAccumulated := transferNetAccumulated + 0.! !

!TransferNetReporter methodsFor: 'visit transaction operations' stamp: 'GDH 6/2/2021 22:25:52'!
reportTransferReceiverLeg: aTransferReceiverLeg

	transferNetAccumulated := aTransferReceiverLeg value + transferNetAccumulated.! !

!TransferNetReporter methodsFor: 'visit transaction operations' stamp: 'GDH 6/2/2021 22:26:10'!
reportTransferSenderLeg: aTransferSenderLeg
	
	transferNetAccumulated := aTransferSenderLeg value negated + transferNetAccumulated.! !

!TransferNetReporter methodsFor: 'visit transaction operations' stamp: 'GDH 6/2/2021 22:26:18'!
reportWithdraw: aWithdraw

	transferNetAccumulated := transferNetAccumulated + 0.! !


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


!AccountTransaction methodsFor: 'reports' stamp: 'GDH 6/2/2021 21:55:45'!
reportTransaction: aReceptiveAccountReporter

	^self subclassResponsibility.! !

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


!Deposit methodsFor: 'reports' stamp: 'GDH 6/2/2021 21:55:20'!
reportTransaction: aReceptiveAccountReporter

	^aReceptiveAccountReporter reportDeposit: self.! !

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

!TransferLeg methodsFor: 'navigation' stamp: 'GDH 6/2/2021 23:21:19'!
oppositeLeg
	
	self subclassResponsibility .! !


!TransferLeg methodsFor: 'initialization' stamp: 'GDH 6/2/2021 23:20:13'!
initializeFor: aTransfer
	
	transfer := aTransfer .! !


!TransferLeg methodsFor: 'value' stamp: 'GDH 6/3/2021 00:14:27'!
value
	
	^transfer value.! !


!TransferLeg methodsFor: 'reports' stamp: 'GDH 6/3/2021 16:22:02'!
reportTransaction: aReceptiveAccountReporter

	self subclassResponsibility ! !


!classDefinition: #TransferReceiverLeg category: 'Portfolio-Solucion'!
TransferLeg subclass: #TransferReceiverLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferReceiverLeg methodsFor: 'balance' stamp: 'GDH 6/2/2021 23:21:05'!
affectBalance: aBalance

	^aBalance + transfer value. ! !


!TransferReceiverLeg methodsFor: 'navigation' stamp: 'GDH 6/2/2021 23:19:57'!
oppositeLeg
	
	^transfer senderLeg.! !


!TransferReceiverLeg methodsFor: 'reports' stamp: 'GDH 6/3/2021 16:21:55'!
reportTransaction: aReceptiveAccountReporter

	^aReceptiveAccountReporter reportTransferReceiverLeg: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferReceiverLeg class' category: 'Portfolio-Solucion'!
TransferReceiverLeg class
	instanceVariableNames: ''!

!TransferReceiverLeg class methodsFor: 'as yet unclassified' stamp: 'GDH 5/30/2021 18:07:24'!
for: aTransfer
	
	^ self new initializeFor: aTransfer.! !


!classDefinition: #TransferSenderLeg category: 'Portfolio-Solucion'!
TransferLeg subclass: #TransferSenderLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferSenderLeg methodsFor: 'balance' stamp: 'GDH 5/30/2021 18:05:42'!
affectBalance: aBalance

	^aBalance - transfer value. ! !


!TransferSenderLeg methodsFor: 'navigation' stamp: 'MS 6/2/2021 15:35:28'!
oppositeLeg
	
	^transfer receiverLeg.! !


!TransferSenderLeg methodsFor: 'reports' stamp: 'GDH 6/2/2021 21:56:19'!
reportTransaction: aReceptiveAccountReporter

	^aReceptiveAccountReporter reportTransferSenderLeg: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferSenderLeg class' category: 'Portfolio-Solucion'!
TransferSenderLeg class
	instanceVariableNames: ''!

!TransferSenderLeg class methodsFor: 'as yet unclassified' stamp: 'GDH 5/30/2021 18:06:37'!
for: aTransfer
	
	^ self new initializeFor: aTransfer.! !


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


!Withdraw methodsFor: 'reports' stamp: 'GDH 6/2/2021 21:56:38'!
reportTransaction: aReceptiveAccountReporter

	^aReceptiveAccountReporter reportWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #AccountTransfer category: 'Portfolio-Solucion'!
Object subclass: #AccountTransfer
	instanceVariableNames: 'senderLeg receiverLeg value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransfer methodsFor: 'initialization' stamp: 'MS 6/2/2021 15:34:48'!
initializeWith: aValue
	
	senderLeg := TransferSenderLeg for: self.
	receiverLeg := TransferReceiverLeg for: self.
	
	value := aValue.! !


!AccountTransfer methodsFor: 'value' stamp: 'GDH 5/30/2021 18:12:53'!
value
	
	^value! !


!AccountTransfer methodsFor: 'navigation' stamp: 'MS 6/2/2021 15:35:28'!
receiverLeg
	
	^receiverLeg! !

!AccountTransfer methodsFor: 'navigation' stamp: 'MS 6/2/2021 15:35:56'!
senderLeg
	
	^senderLeg! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransfer class' category: 'Portfolio-Solucion'!
AccountTransfer class
	instanceVariableNames: ''!

!AccountTransfer class methodsFor: 'instance creation' stamp: 'MS 6/2/2021 15:35:56'!
register: aValue from: senderAccount to: receiverAccount
	
	| instance |
	
	instance := self new initializeWith: aValue.
	
	senderAccount register: instance senderLeg.
	receiverAccount register: instance receiverLeg.
	
	^instance 
	! !
