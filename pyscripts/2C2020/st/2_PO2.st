!classDefinition: #AccountSummaryTest category: 'Portfolio-Solucion'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryTest methodsFor: 'tests' stamp: 't 11/9/2020 22:03:37'!
test01AccountSummaryForAnAccountWithoutTransactionsHasBalance0
	|anAccount anAccountSummary|
	
	anAccount  := ReceptiveAccount new.
	anAccountSummary := AccountSummary for: anAccount.
	
	self assert: anAccountSummary entries size = 1.
	self assert: anAccountSummary entries first = 'balance = 0'.
	
	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 't 11/9/2020 22:06:09'!
test02AccountSummaryForAnAccountWithADepositPrintsCorrectly
	|anAccount anAccountSummary|
	
	anAccount  := ReceptiveAccount new.
	anAccountSummary := AccountSummary for: anAccount.
	
	Deposit register: 100 on: anAccount.
	
	self assert: anAccountSummary entries size = 2.
	self assert: anAccountSummary entries first = 'deposito por 100'.
	self assert: anAccountSummary entries last = 'balance = 100'.
	
	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 't 11/9/2020 22:06:28'!
test03AccountSummaryForAnAccountWithAWithdrawPrintsCorrectly
	|anAccount anAccountSummary|
	
	anAccount  := ReceptiveAccount new.
	anAccountSummary := AccountSummary for: anAccount.
	
	Withdraw register: 100 on: anAccount.
	
	self assert: anAccountSummary entries size = 2.
	self assert: anAccountSummary entries first = 'extraccion por 100'.
	self assert: anAccountSummary entries last = 'balance = -100'.
	
	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 't 11/9/2020 22:08:18'!
test04AccountSummaryForAnAccountThatSentATransferPrintsCorrectly
	|senderAccount receiverAccount anAccountSummary|
	
	senderAccount  := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	anAccountSummary := AccountSummary for: senderAccount.
	
	Transfer register: 100 from: senderAccount to: receiverAccount.
	
	self assert: anAccountSummary entries size = 2.
	self assert: anAccountSummary entries first = 'salida por transferencia de 100'.
	self assert: anAccountSummary entries last = 'balance = -100'.
	
	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 't 11/9/2020 22:08:48'!
test05AccountSummaryForAnAccountThatReceivedATransferPrintsCorrectly
	|senderAccount receiverAccount anAccountSummary|
	
	senderAccount  := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	anAccountSummary := AccountSummary for: receiverAccount.
	
	Transfer register: 100 from: senderAccount to: receiverAccount.
	
	self assert: anAccountSummary entries size = 2.
	self assert: anAccountSummary entries first = 'entrada por transferencia de 100'.
	self assert: anAccountSummary entries last = 'balance = 100'.
	
	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 't 11/9/2020 22:09:24'!
test06AccountSummaryForAnAccountWithManyTransactionsPrintsCorrectly
	|anAccount anAccountSummary|
	
	anAccount  := ReceptiveAccount new.
	anAccountSummary := AccountSummary for: anAccount.
	
	Deposit register: 100 on: anAccount.
	Withdraw register: 50 on: anAccount.
	
	self assert: anAccountSummary entries size = 3.
	self assert: anAccountSummary entries first = 'deposito por 100'.
	self assert: anAccountSummary entries second = 'extraccion por 50'.
	self assert: anAccountSummary entries last = 'balance = 50'.
	
	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 't 11/12/2020 21:29:37'!
test07AccountSummaryForAPortfolioPrintsCorrectly
	|anAccount anAccountSummary aPortfolio|
	
	anAccount  := ReceptiveAccount new.
	aPortfolio := Portfolio new.
	aPortfolio add: anAccount.
	anAccountSummary := AccountSummary for: aPortfolio.
	
	
	Deposit register: 100 on: anAccount.
	Withdraw register: 50 on: anAccount.
	
	self assert: anAccountSummary entries size = 3.
	self assert: anAccountSummary entries first = 'deposito por 100'.
	self assert: anAccountSummary entries second = 'extraccion por 50'.
	self assert: anAccountSummary entries last = 'balance = 50'.! !


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


!classDefinition: #TransferNetTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetTest methodsFor: 'tests' stamp: 't 11/12/2020 21:54:06'!
test01TransferNetWithNoOperationsIsZero
	|anAccount aTransferNet|
	
	anAccount  := ReceptiveAccount new.
	aTransferNet := TransferNet for: anAccount.
	
	self assert: aTransferNet value equals: 0.! !

!TransferNetTest methodsFor: 'tests' stamp: 't 11/12/2020 21:54:45'!
test02TransferNetForSenderWithTransferSubstracts
	|senderAccount receiverAccount aTransferNet|
	
	senderAccount  := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	aTransferNet := TransferNet for: senderAccount.
	
	Transfer register: 100 from: senderAccount to: receiverAccount.
	
	self assert: aTransferNet value equals: -100.! !

!TransferNetTest methodsFor: 'tests' stamp: 't 11/12/2020 21:55:11'!
test03TransferNetForReceiverWithTransferAdds
	|senderAccount receiverAccount aTransferNet|
	
	senderAccount  := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	aTransferNet := TransferNet for: receiverAccount.
	
	Transfer register: 100 from: senderAccount to: receiverAccount.
	Transfer register: 50 from: senderAccount to: receiverAccount.
	
	self assert: aTransferNet value equals: 150.! !

!TransferNetTest methodsFor: 'tests' stamp: 't 11/12/2020 21:57:30'!
test04TransferNetForManyTransfersCalculatesCorrectly
	|senderAccount receiverAccount aTransferNet|
	
	senderAccount  := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	aTransferNet := TransferNet for: receiverAccount.
	
	Transfer register: 100 from: senderAccount to: receiverAccount.
	Transfer register: 50 from: senderAccount to: receiverAccount.
	
	self assert: aTransferNet value equals: 150.! !

!TransferNetTest methodsFor: 'tests' stamp: 't 11/12/2020 21:57:53'!
test05TransferNetWithOnlyWithdrawIsZero
	|anAccount aTransferNet|
	
	anAccount  := ReceptiveAccount new.
	Withdraw register: 100 on: anAccount.
	aTransferNet := TransferNet for: anAccount.
	
	self assert: aTransferNet value equals: 0.! !

!TransferNetTest methodsFor: 'tests' stamp: 't 11/12/2020 21:58:07'!
test06TransferNetWithOnlyDepositIsZero
	|anAccount aTransferNet|
	
	anAccount  := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	aTransferNet := TransferNet for: anAccount.
	
	self assert: aTransferNet value equals: 0.! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'tests' stamp: 't 11/9/2020 22:17:52'!
test01TransferModifiesSenderAndReceiverAccountBalanceCorrectly
	|senderReceptiveAccount receiverReceptiveAccount|
	
	senderReceptiveAccount  := ReceptiveAccount new.
	receiverReceptiveAccount  := ReceptiveAccount new.
	Transfer register: 500 from: senderReceptiveAccount to: receiverReceptiveAccount.
	
	self assert: senderReceptiveAccount balance equals: -500.
	self assert: receiverReceptiveAccount balance equals: 500.! !

!TransferTest methodsFor: 'tests' stamp: 't 11/9/2020 20:07:56'!
test02TransferReceiverCanAccessToSendPart
	|senderReceptiveAccount receiverReceptiveAccount aTransfer|
	
	senderReceptiveAccount  := ReceptiveAccount new.
	receiverReceptiveAccount  := ReceptiveAccount new.
	aTransfer := Transfer register: 500 from: senderReceptiveAccount to: receiverReceptiveAccount.
	
	self assert: aTransfer sendPart equals: aTransfer receivePart sendPart.! !

!TransferTest methodsFor: 'tests' stamp: 't 11/9/2020 22:14:07'!
test03TransferSenderCanAccessToReceivePart
	|senderReceptiveAccount receiverReceptiveAccount aTransfer|
	
	senderReceptiveAccount  := ReceptiveAccount new.
	receiverReceptiveAccount  := ReceptiveAccount new.
	aTransfer := Transfer register: 500 from: senderReceptiveAccount to: receiverReceptiveAccount.
	
	self assert: aTransfer receivePart equals: aTransfer sendPart receivePart.! !

!TransferTest methodsFor: 'tests' stamp: 't 11/9/2020 22:13:29'!
test04TransferIsRegisteredOnSenderAndReceiverAccount
	|senderAccount receiverAccount aTransfer|
	
	senderAccount  := ReceptiveAccount new.
	receiverAccount  := ReceptiveAccount new.
	aTransfer := Transfer register: 500 from: senderAccount to: receiverAccount.
	
	self assert: (senderAccount hasRegistered: aTransfer sendPart).
	self assert: (receiverAccount hasRegistered: aTransfer receivePart).! !

!TransferTest methodsFor: 'tests' stamp: 't 11/9/2020 22:17:58'!
test05TransferCanNotHaveAnAccountAsSenderAndReceiverAtTheSameTime
	|anAccount |
	
	anAccount  := ReceptiveAccount new.
	
	self should: [Transfer register: 500 from: anAccount to: anAccount.] raise: Error withMessageText: Transfer selfTransferError.! !

!TransferTest methodsFor: 'tests' stamp: 't 11/9/2020 22:18:03'!
test06TransferCanNotHaveZeroAsValue
	|senderAccount receiverAccount |
	
	senderAccount  := ReceptiveAccount new.
	receiverAccount  := ReceptiveAccount new.
	
	self should: [Transfer register: 0 from: senderAccount to: receiverAccount.] raise: Error withMessageText: Transfer ZeroTransferError.! !

!TransferTest methodsFor: 'tests' stamp: 't 11/9/2020 22:18:05'!
test07TransferCanNotHaveNegativeValue
	|senderAccount receiverAccount |
	
	senderAccount  := ReceptiveAccount new.
	receiverAccount  := ReceptiveAccount new.
	
	self should: [Transfer register: -100 from: senderAccount to: receiverAccount.] raise: Error withMessageText: Transfer NegativeTransferError.! !


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


!Portfolio methodsFor: 'reporting' stamp: 't 11/15/2020 19:11:36'!
makeReportFor: aReport
	accounts do: [:anAccount | anAccount makeReportFor: aReport].
	! !

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


!ReceptiveAccount methodsFor: 'reporting' stamp: 't 11/15/2020 19:16:07'!
makeReportFor: aReport
	transactions do: [:aTransaction | 
		aTransaction handleReport: aReport].! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
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


!Deposit methodsFor: 'report' stamp: 't 11/15/2020 19:06:40'!
handleReport: aReport
	^aReport reportForDeposit: self.! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferPart category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferPart
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferPart methodsFor: 'value' stamp: 't 11/9/2020 20:29:00'!
value
	^transfer value.! !


!TransferPart methodsFor: 'initialization' stamp: 't 11/9/2020 20:21:04'!
initializeFor: aTransfer
	transfer := aTransfer.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferPart class' category: 'Portfolio-Solucion'!
TransferPart class
	instanceVariableNames: ''!

!TransferPart class methodsFor: 'instance creation' stamp: 't 11/9/2020 20:20:49'!
for: aTransfer
	^self new initializeFor: aTransfer.! !


!classDefinition: #TransferReceive category: 'Portfolio-Solucion'!
TransferPart subclass: #TransferReceive
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferReceive methodsFor: 'report' stamp: 't 11/15/2020 19:06:51'!
handleReport: aReport
	^aReport reportForTransferReceive: self.! !


!TransferReceive methodsFor: 'accessing' stamp: 't 11/9/2020 20:23:25'!
sendPart
	^ transfer sendPart! !


!TransferReceive methodsFor: 'balance' stamp: 't 11/9/2020 20:28:33'!
affectBalance: aBalance

	^aBalance + self value.! !


!classDefinition: #TransferSend category: 'Portfolio-Solucion'!
TransferPart subclass: #TransferSend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferSend methodsFor: 'balance' stamp: 't 11/9/2020 20:29:15'!
affectBalance: aBalance

	^aBalance - self value.! !


!TransferSend methodsFor: 'accessing' stamp: 't 11/9/2020 20:23:47'!
receivePart
	^transfer receivePart.! !


!TransferSend methodsFor: 'report' stamp: 't 11/15/2020 19:06:58'!
handleReport: aReport
	^aReport reportForTransferSend: self.! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'report' stamp: 't 11/15/2020 19:07:06'!
handleReport: aReport
	^aReport reportForWithdraw: self.! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Reports category: 'Portfolio-Solucion'!
Object subclass: #Reports
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Reports methodsFor: 'operations' stamp: 't 11/15/2020 19:06:40'!
reportForDeposit: aDeposit
	self subclassResponsibility.! !

!Reports methodsFor: 'operations' stamp: 't 11/15/2020 19:06:51'!
reportForTransferReceive: aTransferReceive
	self subclassResponsibility.
	! !

!Reports methodsFor: 'operations' stamp: 't 11/15/2020 19:06:58'!
reportForTransferSend: aTransferSend
	self subclassResponsibility.
	! !

!Reports methodsFor: 'operations' stamp: 't 11/15/2020 19:07:06'!
reportForWithdraw: aWithdraw
	self subclassResponsibility.
	! !


!Reports methodsFor: 'initialization' stamp: 't 11/12/2020 21:35:17'!
initializeFor: anAccount 
	account := anAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Reports class' category: 'Portfolio-Solucion'!
Reports class
	instanceVariableNames: ''!

!Reports class methodsFor: 'as yet unclassified' stamp: 't 11/12/2020 21:34:48'!
for: anAccount 
	^self new initializeFor: anAccount.! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
Reports subclass: #AccountSummary
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'operations' stamp: 't 11/15/2020 19:18:57'!
reportForDeposit: aDeposit
	summary add: 'deposito por ', aDeposit value asString.! !

!AccountSummary methodsFor: 'operations' stamp: 't 11/15/2020 19:19:03'!
reportForTransferReceive: aTransferReceive
	summary add: 'entrada por transferencia de ', aTransferReceive value asString.! !

!AccountSummary methodsFor: 'operations' stamp: 't 11/15/2020 19:19:08'!
reportForTransferSend: aTransferSend
	summary add: 'salida por transferencia de ', aTransferSend value asString.! !

!AccountSummary methodsFor: 'operations' stamp: 't 11/15/2020 19:19:14'!
reportForWithdraw: aWithdraw
	summary add: 'extraccion por ', aWithdraw value asString.! !


!AccountSummary methodsFor: 'accessing' stamp: 't 11/15/2020 19:18:24'!
entries	
	summary := OrderedCollection new.
	account makeReportFor: self.
	summary add: 'balance = ', account balance asString.
	^summary.! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
Reports subclass: #TransferNet
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'operations' stamp: 't 11/15/2020 19:13:45'!
reportForDeposit: aDeposit
! !

!TransferNet methodsFor: 'operations' stamp: 't 11/15/2020 19:14:04'!
reportForTransferReceive: aTransferReceive
	value:= value + aTransferReceive value.! !

!TransferNet methodsFor: 'operations' stamp: 't 11/15/2020 19:14:43'!
reportForTransferSend: aTransferSend
	value := value - aTransferSend value.! !

!TransferNet methodsFor: 'operations' stamp: 't 11/15/2020 19:14:46'!
reportForWithdraw: aWithdraw! !

!TransferNet methodsFor: 'operations' stamp: 't 11/15/2020 19:13:30'!
value
	value := 0.
	account makeReportFor: self.
	^value.! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'sendPart receivePart value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 't 11/9/2020 20:19:41'!
initializeFor: aValue
	value := aValue.
	sendPart := TransferSend for: self.
	receivePart := TransferReceive for: self.! !


!Transfer methodsFor: 'value' stamp: 't 11/9/2020 20:21:34'!
value
	^value.! !


!Transfer methodsFor: 'accessing' stamp: 't 11/9/2020 20:22:39'!
receivePart
	^receivePart.! !

!Transfer methodsFor: 'accessing' stamp: 't 11/9/2020 20:22:31'!
sendPart
	^sendPart ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 't 11/9/2020 20:14:32'!
for: aValue
	^self new initializeFor: aValue.! !

!Transfer class methodsFor: 'instance creation' stamp: 't 11/9/2020 21:07:40'!
register: aValue from: senderAccount to: receiverAccount
	
	| transfer |
	
	self validateTransfer: aValue from: senderAccount to: receiverAccount.
	
	transfer := self for: aValue.
	senderAccount register: transfer sendPart.
	receiverAccount register: transfer receivePart.
	^transfer.! !

!Transfer class methodsFor: 'instance creation' stamp: 't 11/9/2020 21:07:55'!
validateTransfer: aValue from: senderAccount to: receiverAccount

	senderAccount = receiverAccount  ifTrue: [self error: self selfTransferError].
	aValue = 0 ifTrue: [self error: self ZeroTransferError].
	aValue < 0 ifTrue: [self error: self NegativeTransferError].! !


!Transfer class methodsFor: 'error' stamp: 't 11/9/2020 21:06:05'!
NegativeTransferError
	^'Transfer can not be negative'.! !

!Transfer class methodsFor: 'error' stamp: 't 11/9/2020 21:04:34'!
ZeroTransferError
	^'Can not transfer a value that is zero'! !

!Transfer class methodsFor: 'error' stamp: 't 11/9/2020 21:01:02'!
selfTransferError
	^ 'Can not transfer to self'! !
