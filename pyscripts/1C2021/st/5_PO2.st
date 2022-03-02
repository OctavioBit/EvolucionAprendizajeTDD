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


!classDefinition: #ReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTest methodsFor: 'do report' stamp: 'JPF 6/3/2021 07:24:42'!
accountSummaryFor: anAccount
	
	^ (SummaryVisitor for: anAccount) doOperation! !

!ReportTest methodsFor: 'do report' stamp: 'JPF 6/3/2021 07:25:19'!
netTransferValueFor: anAccount
	
	^ (NetTransferValueVisitor for: anAccount) doOperation! !


!ReportTest methodsFor: 'net transfer value tests' stamp: 'JPF 6/3/2021 07:26:20'!
test01ShouldInform0ForAnAccountWithoutTransfers
	
	| account |
	
	account _ ReceptiveAccount new.
	account register: (Deposit for: 50).
	account register: (Withdraw for: 100).
	
	self assert: 0 equals: (self netTransferValueFor: account)! !

!ReportTest methodsFor: 'net transfer value tests' stamp: 'JPF 6/3/2021 07:26:47'!
test02ShouldInform50ForAnAccountWithA50TransferEntry
	
	| account account2 |
	
	account _ ReceptiveAccount new.
	account register: (Withdraw for: 50).
	account register: (Deposit for: 100).
	
	account2 _ ReceptiveAccount new.
	
	account2 transfer: 50 to: account.
	
	self assert: 50 equals: (self netTransferValueFor: account)! !

!ReportTest methodsFor: 'net transfer value tests' stamp: 'JPF 6/3/2021 07:26:54'!
test03ShouldInform10ForAnAccountWithA50TransferEntryAnd40TransferOutput
	
	| account account2 |
	
	account _ ReceptiveAccount new.
	account register: (Withdraw for: 50).
	account register: (Deposit for: 100).
	
	account2 _ ReceptiveAccount new.
	
	account2 transfer: 50 to: account.
	account transfer: 40 to: account2.
	
	self assert: 10 equals: (self netTransferValueFor: account)! !

!ReportTest methodsFor: 'net transfer value tests' stamp: 'JPF 6/3/2021 07:27:07'!
test04ShouldInformCorrectValueForAPortfolioWithAReceptiveAccountAndAnotherPortfolioHavingAllTypeOfTransactions
	
	| portfolio portfolioChild account account2 account3 |
	
	account _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	account3 _ ReceptiveAccount new.
	
	portfolioChild _ Portfolio with: account2.
	portfolio _ Portfolio with: portfolioChild with: account.
	
	account register: (Deposit for: 100).
	account2 register: (Withdraw for: 50).
	
	account transfer: 50 to: account2.
	account3 transfer: 100 to: account.
	account2 transfer: 50 to: account3.
	
	self assert: 50 equals: (self netTransferValueFor: portfolio) ! !


!ReportTest methodsFor: 'account summary tests' stamp: 'JPF 6/3/2021 07:27:46'!
test01ShouldInformBalance0ForAnAccountWithoutTransactions
	
	| account |
	
	account _ ReceptiveAccount new.
	
	self
		assert: (OrderedCollection with: 'Balance = 0')
		equals: (self accountSummaryFor: account)! !

!ReportTest methodsFor: 'account summary tests' stamp: 'JPF 6/3/2021 07:28:23'!
test02ShouldInformBalance50AndA50DepositForAnAccountWithA50Deposit
	
	| account |
	
	account _ ReceptiveAccount new.
	account register: (Deposit for: 50).
	
	self
		assert: (OrderedCollection with: 'Depósito por 50.' with: 'Balance = 50')
		equals: (self accountSummaryFor: account)! !

!ReportTest methodsFor: 'account summary tests' stamp: 'JPF 6/3/2021 07:28:36'!
test03ShouldInformBalance0A50DepositA50WithdrawForAnAccountWithA50DepositAnd50Withdraw
	
	| account |
	
	account _ ReceptiveAccount new.
	account register: (Deposit for: 50).
	account register: (Withdraw for: 50).
	
	self 
		assert:
		(OrderedCollection
			with: 'Depósito por 50.'
			with: 'Extracción por 50.'
			with: 'Balance = 0')
		equals: (self accountSummaryFor: account)! !

!ReportTest methodsFor: 'account summary tests' stamp: 'JPF 6/3/2021 07:28:44'!
test04ShouldInformBalance0A50DepositA50WithdrawA50TransferEntryA50TransferOutputForAnAccountWithThoseTransactions
	
	| account account2 |
	
	account _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	
	account register: (Deposit for: 50).
	account register: (Withdraw for: 50).
	
	account2 transfer: 50 to: account.
	account transfer: 50 to: account2.
	
	self 
		assert:
		(OrderedCollection
			with: 'Depósito por 50.'
			with: 'Extracción por 50.'
			with: 'Entrada por transferencia de 50.'
			with: 'Salida por transferencia de 50.'
			with: 'Balance = 0')
		equals: (self accountSummaryFor: account)! !

!ReportTest methodsFor: 'account summary tests' stamp: 'JPF 6/3/2021 07:28:58'!
test05ShouldInformCorrectBalanceForAPortfolioWithAReceptiveAccountAndAnotherPortfolioHavingAllTypeOfTransactions
	
	| portfolio portfolioChild account account2 |
	
	account _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	
	portfolioChild _ Portfolio with: account2.
	portfolio _ Portfolio with: portfolioChild with: account.
	
	account register: (Deposit for: 100).
	account register: (Withdraw for: 50).
	
	account transfer: 50 to: account2.
	
	self 
		assert:
		(OrderedCollection
			with: 'Entrada por transferencia de 50.'
			with: 'Depósito por 100.'
			with: 'Extracción por 50.'
			with: 'Salida por transferencia de 50.'
			with: 'Balance = 50')
		equals: (self accountSummaryFor: portfolio)! !


!classDefinition: #TransactionIteratorTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransactionIteratorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransactionIteratorTest methodsFor: 'tests' stamp: 'JPF 6/1/2021 19:44:44'!
test01IteratorForAnAccountWithoutTransactionsHasNotNext
	
	| iterator |
	
	iterator _ (ReceptiveAccount new) transactionIterator.
	
	self deny: iterator hasNext! !

!TransactionIteratorTest methodsFor: 'tests' stamp: 'JPF 6/1/2021 19:44:36'!
test02IteratorForAnAccountWithOneTransactionHasNext
	
	| iterator account |
	
	account _ ReceptiveAccount new.
	account register: (Deposit for: 50).
	
	iterator _ account transactionIterator.
	
	self assert: iterator hasNext! !

!TransactionIteratorTest methodsFor: 'tests' stamp: 'JPF 6/1/2021 19:53:22'!
test03IteratorForAnAccountWithOneTransactionHasNotNextWhenWasAskedForNextOnce
	
	| iterator account |
	
	account _ ReceptiveAccount new.
	account register: (Deposit for: 50).
	
	iterator _ account transactionIterator.
	iterator next.
	
	self deny: iterator hasNext! !

!TransactionIteratorTest methodsFor: 'tests' stamp: 'JPF 6/1/2021 20:04:50'!
test04IteratorForAnAccountWithOneTransactionShouldReturnThatTransactionWhenAskForNext
	
	| iterator account transaction |
	
	account _ ReceptiveAccount new.
	transaction _ Deposit for: 50.
	account register: transaction.
	
	iterator _ account transactionIterator.
	
	self assert: transaction equals: iterator next! !

!TransactionIteratorTest methodsFor: 'tests' stamp: 'JPF 6/1/2021 20:14:44'!
test05NextShouldRaiseAnErrorWhenHasNotNext
	
	| iterator account transaction |
	
	account _ ReceptiveAccount new.
	transaction _ Deposit for: 50.
	account register: transaction.
	
	iterator _ account transactionIterator.
	iterator next.
	
	self deny: iterator hasNext.
	self should: [ iterator next ] raise: Error - MessageNotUnderstood withMessageText: TransactionIterator notNextTransationErrorDescription.
	! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'tests' stamp: 'JPF 5/27/2021 20:56:19'!
test01ShouldIncreaseTargetAccountBalanceAndDecreaseSourceAccountBalanceInTheSameAmount
	
	| sourceAccount targetAccount |
	
	sourceAccount _ ReceptiveAccount new.
	sourceAccount register: (Deposit for: 100).
	
	targetAccount _ ReceptiveAccount new.
	
	sourceAccount transfer: 50 to: targetAccount.
	
	self assert: 50 equals: sourceAccount balance.
	self assert: 50 equals: targetAccount balance! !

!TransferTest methodsFor: 'tests' stamp: 'JPF 5/27/2021 21:07:25'!
test02ShouldNotAddDepositsToTargetAccountOrWithdrawToSourceAccount
	
	| sourceAccount targetAccount |
	
	sourceAccount _ ReceptiveAccount new.
	sourceAccount register: (Deposit for: 100).
	
	targetAccount _ ReceptiveAccount new.
	
	sourceAccount transfer: 50 to: targetAccount.
	
	self deny: (sourceAccount transactions anySatisfy: [ :transaction | transaction isKindOf: Withdraw ]).
	self deny: (targetAccount transactions anySatisfy: [ :transaction | transaction isKindOf: Deposit ]).! !

!TransferTest methodsFor: 'tests' stamp: 'JPF 5/30/2021 10:41:30'!
test03ShouldReturnATransferWithTheTransferOutputAndTheTransferEntry
	
	| sourceAccount targetAccount transfer |
	
	sourceAccount _ ReceptiveAccount new.
	sourceAccount register: (Deposit for: 100).
	
	targetAccount _ ReceptiveAccount new.
	
	transfer _ sourceAccount transfer: 50 to: targetAccount.
	
	self assert: (sourceAccount transactions anySatisfy: [ :transaction | transaction = transfer output ]).
	self assert: (targetAccount transactions anySatisfy: [ :transaction | transaction = transfer entry ]).! !

!TransferTest methodsFor: 'tests' stamp: 'JPF 5/31/2021 21:47:06'!
test04ShouldObtainTheSameTransferFromTheTransferOutputAndTheTransferEntry
	
	| sourceAccount targetAccount transfer |
	
	sourceAccount _ ReceptiveAccount new.
	
	targetAccount _ ReceptiveAccount new.
	
	transfer _ sourceAccount transfer: 50 to: targetAccount.
	
	self assert: transfer output transfer equals: transfer entry transfer.
	self assert: sourceAccount transactions first transfer equals: targetAccount transactions first transfer! !

!TransferTest methodsFor: 'tests' stamp: 'JPF 6/1/2021 20:15:52'!
test05ShouldRaiseAnErrorIfTheTargetAndSourceAccountAreTheSameAccount
	
	| account |
	
	account _ ReceptiveAccount new.
	
	self
		should: [ account transfer: 50 to: account ]	
		raise: Error
		withMessageText: ReceptiveAccount transferToSourceAccountErrorDescription.! !

!TransferTest methodsFor: 'tests' stamp: 'JPF 6/1/2021 20:15:43'!
test06ShouldRaiseAnErrorIfAnAccountTransferANegativeAmount
	
	| sourceAccount targetAccount |
	
	sourceAccount _ ReceptiveAccount new.
	sourceAccount register: (Deposit for: 100).
	
	targetAccount _ ReceptiveAccount new.
	
	self
		should: [ sourceAccount transfer: -1 to: targetAccount ]	
		raise: Error
		withMessageText: ReceptiveAccount invalidAmountErrorDescription.! !

!TransferTest methodsFor: 'tests' stamp: 'JPF 6/1/2021 20:15:36'!
test07ShouldRaiseAnErrorIfAnAccountTransferZeroAsAmount
	
	| sourceAccount targetAccount |
	
	sourceAccount _ ReceptiveAccount new.
	sourceAccount register: (Deposit for: 100).
	
	targetAccount _ ReceptiveAccount new.
	
	self
		should: [ sourceAccount transfer: 0 to: targetAccount ]	
		raise: Error
		withMessageText: ReceptiveAccount invalidAmountErrorDescription.! !


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


!Account methodsFor: 'transaction iterator' stamp: 'JPF 6/2/2021 18:50:21'!
transactionIterator
	
	^ TransactionIterator with: self transactions! !


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


!ReceptiveAccount methodsFor: 'balance' stamp: 'JPF 5/27/2021 22:04:24'!
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


!ReceptiveAccount methodsFor: 'transfer' stamp: 'JPF 6/1/2021 18:52:33'!
transfer: aValue to: targetReceptiveAccount 
	
	| transfer |
	
	self assertSourceAndTargetAccountAreNotTheSameAccount: targetReceptiveAccount.
	self assertTheAmountTransferedIsValid: aValue.
	
	transfer _ Transfer for: aValue from: self to: targetReceptiveAccount.
	
	^ transfer
	! !


!ReceptiveAccount methodsFor: 'assertions' stamp: 'JPF 6/1/2021 18:51:49'!
assertSourceAndTargetAccountAreNotTheSameAccount: targetReceptiveAccount

	^ (targetReceptiveAccount = self) ifTrue: [ self error: self class transferToSourceAccountErrorDescription ]! !

!ReceptiveAccount methodsFor: 'assertions' stamp: 'JPF 6/1/2021 18:52:33'!
assertTheAmountTransferedIsValid: aValue

	^ (aValue <= 0) ifTrue: [ self error: self class invalidAmountErrorDescription ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'error descriptions' stamp: 'JPF 6/1/2021 18:49:46'!
invalidAmountErrorDescription

	^ 'Cannot transfer a negative amount'! !

!ReceptiveAccount class methodsFor: 'error descriptions' stamp: 'JPF 6/1/2021 18:40:42'!
transferToSourceAccountErrorDescription
	
	^ 'Cannot transfer to the source account'.! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'JPF 5/27/2021 22:04:24'!
affectBalance: aBalance  

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'visitor' stamp: 'JPF 6/1/2021 19:03:18'!
accept: aVisitor
	
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


!Deposit methodsFor: 'balance' stamp: 'JPF 5/27/2021 22:04:24'!
affectBalance: aBalance  

	^aBalance + value ! !


!Deposit methodsFor: 'visitor' stamp: 'JPF 6/2/2021 19:07:26'!
accept: aVisitor
	
	aVisitor visitDeposit: self! !

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

!TransferLeg methodsFor: 'transfer' stamp: 'JPF 6/2/2021 19:39:10'!
transfer

	^transfer! !


!TransferLeg methodsFor: 'initialization' stamp: 'JPF 6/2/2021 19:41:58'!
initializeFor: aTransfer

	transfer := aTransfer ! !


!TransferLeg methodsFor: 'value' stamp: 'JPF 6/2/2021 19:43:09'!
value
	
	^ transfer value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'Portfolio-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'JPF 6/2/2021 19:41:20'!
for: aTransfer

	^ self new initializeFor: aTransfer! !


!classDefinition: #TransferEntry category: 'Portfolio-Solucion'!
TransferLeg subclass: #TransferEntry
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferEntry methodsFor: 'balance' stamp: 'JPF 5/30/2021 12:11:41'!
affectBalance: aBalance  

	^aBalance + self value! !


!TransferEntry methodsFor: 'visitor' stamp: 'JPF 6/2/2021 19:08:14'!
accept: aVisitor
	
	aVisitor visitTransferEntry: self! !


!classDefinition: #TransferOutput category: 'Portfolio-Solucion'!
TransferLeg subclass: #TransferOutput
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferOutput methodsFor: 'balance' stamp: 'JPF 5/30/2021 10:59:11'!
affectBalance: aBalance  

	^aBalance - self value! !


!TransferOutput methodsFor: 'visitor' stamp: 'JPF 6/2/2021 19:08:05'!
accept: aVisitor
	
	aVisitor visitTransferOutput: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferOutput class' category: 'Portfolio-Solucion'!
TransferOutput class
	instanceVariableNames: ''!

!TransferOutput class methodsFor: 'instance creation' stamp: 'JPF 5/30/2021 10:56:49'!
for: aTransfer

	^ self new initializeFor: aTransfer! !


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


!Withdraw methodsFor: 'balance' stamp: 'JPF 5/27/2021 22:04:24'!
affectBalance: aBalance  

	^aBalance - value! !


!Withdraw methodsFor: 'visitor' stamp: 'JPF 6/2/2021 19:07:49'!
accept: aVisitor
	
	aVisitor visitWithdraw: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #AccountVisitor category: 'Portfolio-Solucion'!
Object subclass: #AccountVisitor
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountVisitor methodsFor: 'visit transaction - private' stamp: 'JPF 6/2/2021 19:22:06'!
visitDeposit
	
	^ self subclassResponsibility ! !

!AccountVisitor methodsFor: 'visit transaction - private' stamp: 'JPF 6/2/2021 19:33:26'!
visitTransactions

	| transactionIterator |
	
	transactionIterator _ account transactionIterator.
	
	[ transactionIterator hasNext ] whileTrue: [ | currentTransaction |
		currentTransaction _ transactionIterator next.
		currentTransaction accept: self
		]! !

!AccountVisitor methodsFor: 'visit transaction - private' stamp: 'JPF 6/2/2021 19:22:18'!
visitTransferEntry
	
	^ self subclassResponsibility ! !

!AccountVisitor methodsFor: 'visit transaction - private' stamp: 'JPF 6/2/2021 19:22:23'!
visitTransferOutput
	
	^ self subclassResponsibility ! !

!AccountVisitor methodsFor: 'visit transaction - private' stamp: 'JPF 6/2/2021 19:22:12'!
visitWithdraw
	
	^ self subclassResponsibility ! !


!AccountVisitor methodsFor: 'operation' stamp: 'JPF 6/2/2021 19:22:45'!
doOperation
	
	self subclassResponsibility! !


!classDefinition: #NetTransferValueVisitor category: 'Portfolio-Solucion'!
AccountVisitor subclass: #NetTransferValueVisitor
	instanceVariableNames: 'netTransferValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!NetTransferValueVisitor methodsFor: 'operation' stamp: 'JPF 6/2/2021 19:29:58'!
doOperation
	
	self visitTransactions.
	
	^ netTransferValue ! !


!NetTransferValueVisitor methodsFor: 'initialization' stamp: 'JPF 6/2/2021 18:59:50'!
initializeFor: anAccount
	
	account := anAccount.
	netTransferValue := 0! !


!NetTransferValueVisitor methodsFor: 'visit transaction - private' stamp: 'JPF 6/2/2021 19:02:55'!
visitDeposit: aDeposit
! !

!NetTransferValueVisitor methodsFor: 'visit transaction - private' stamp: 'JPF 6/2/2021 19:09:18'!
visitTransferEntry: aTransferEntry

	netTransferValue _ aTransferEntry affectBalance: netTransferValue! !

!NetTransferValueVisitor methodsFor: 'visit transaction - private' stamp: 'JPF 6/2/2021 19:09:32'!
visitTransferOutput: aTransferOutput

	netTransferValue _ aTransferOutput affectBalance: netTransferValue! !

!NetTransferValueVisitor methodsFor: 'visit transaction - private' stamp: 'JPF 6/2/2021 19:03:12'!
visitWithdraw: aWithdraw
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NetTransferValueVisitor class' category: 'Portfolio-Solucion'!
NetTransferValueVisitor class
	instanceVariableNames: ''!

!NetTransferValueVisitor class methodsFor: 'instance creation' stamp: 'JPF 6/2/2021 18:58:14'!
for: anAccount
	
	^ self new initializeFor: anAccount! !


!classDefinition: #SummaryVisitor category: 'Portfolio-Solucion'!
AccountVisitor subclass: #SummaryVisitor
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SummaryVisitor methodsFor: 'initialization' stamp: 'JPF 6/1/2021 19:19:32'!
initializeFor: anAccount
	
	account := anAccount.
	summary := OrderedCollection new! !


!SummaryVisitor methodsFor: 'operation' stamp: 'JPF 6/2/2021 19:31:29'!
doOperation

	self visitTransactions.
	
	summary add: 'Balance = ', account balance asString.
	
	^ summary
	
	
	! !


!SummaryVisitor methodsFor: 'visit transaction - private' stamp: 'JPF 6/2/2021 19:07:26'!
visitDeposit: aDeposit
	
	summary add: 'Depósito por ' , aDeposit value asString , '.'! !

!SummaryVisitor methodsFor: 'visit transaction - private' stamp: 'JPF 6/2/2021 19:08:14'!
visitTransferEntry: aTransferEntry
	
	summary add: 'Entrada por transferencia de ' , aTransferEntry value asString , '.'! !

!SummaryVisitor methodsFor: 'visit transaction - private' stamp: 'JPF 6/2/2021 19:08:05'!
visitTransferOutput: aTransferOutput
	
	summary add: 'Salida por transferencia de ' , aTransferOutput value asString , '.'! !

!SummaryVisitor methodsFor: 'visit transaction - private' stamp: 'JPF 6/2/2021 19:07:49'!
visitWithdraw: aWithdraw
	
	summary add: 'Extracción por ' , aWithdraw value asString , '.'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SummaryVisitor class' category: 'Portfolio-Solucion'!
SummaryVisitor class
	instanceVariableNames: ''!

!SummaryVisitor class methodsFor: 'instance creation' stamp: 'JPF 6/1/2021 19:18:39'!
for: anAccount
	
	^ self new initializeFor: anAccount! !


!classDefinition: #TransactionIterator category: 'Portfolio-Solucion'!
Object subclass: #TransactionIterator
	instanceVariableNames: 'transactions index'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransactionIterator methodsFor: 'testing' stamp: 'JPF 6/1/2021 20:01:08'!
hasNext
	
	^ index <= transactions size! !


!TransactionIterator methodsFor: 'initialization' stamp: 'JPF 6/1/2021 19:59:37'!
initializeWith: transactionCollection
	
	transactions _ transactionCollection.
	index _ 1! !


!TransactionIterator methodsFor: 'next' stamp: 'JPF 6/1/2021 20:19:54'!
assertHasNext

	^ (self hasNext) ifFalse: [ self error: self class notNextTransationErrorDescription ]! !

!TransactionIterator methodsFor: 'next' stamp: 'JPF 6/1/2021 20:19:54'!
next
	
	| currentTransaction |
	
	self assertHasNext.
	
	currentTransaction _ transactions at: index.
	index _ index + 1.
	
	^ currentTransaction
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransactionIterator class' category: 'Portfolio-Solucion'!
TransactionIterator class
	instanceVariableNames: ''!

!TransactionIterator class methodsFor: 'instance creation' stamp: 'JPF 6/1/2021 19:49:38'!
with: transactions
	
	^ self new initializeWith: transactions! !


!TransactionIterator class methodsFor: 'error descriptions' stamp: 'JPF 6/1/2021 20:11:34'!
notNextTransationErrorDescription
	
	^ 'Cannot ask for next when iterator has not next'! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value entry output'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'JPF 5/30/2021 10:54:47'!
initializeFor: aValue from: aSourceReceptiveAccount to: aTargetReceptiveAccount

	value := aValue.
	output := TransferOutput for: self.
	entry := TransferEntry for: self.
	
	aSourceReceptiveAccount register: output.
	aTargetReceptiveAccount register: entry.
	
	! !


!Transfer methodsFor: 'value' stamp: 'JPF 5/30/2021 11:01:17'!
value

	^ value! !


!Transfer methodsFor: 'entry output' stamp: 'JPF 5/30/2021 11:02:09'!
entry
	
	^ entry! !

!Transfer methodsFor: 'entry output' stamp: 'JPF 5/30/2021 11:02:21'!
output
	
	^ output! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'JPF 5/30/2021 10:49:55'!
for: aValue from: aSourceReceptiveAccount to: aTargetReceptiveAccount
 
	^ self new initializeFor: aValue from: aSourceReceptiveAccount to: aTargetReceptiveAccount! !
