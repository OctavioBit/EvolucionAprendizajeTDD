!classDefinition: #AccountHierarchyTest category: 'Portfolio-Solucion'!
TestCase subclass: #AccountHierarchyTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountHierarchyTest methodsFor: 'tests' stamp: 'FR 11/15/2020 09:35:34'!
test01PortfolioWithNoAccountsHasHierarchyWithOnlyItsName

	self  assertAccountHierarchyFor: (Portfolio named: 'Un Portfolio')
		is: (OrderedCollection with: 'Un Portfolio')! !

!AccountHierarchyTest methodsFor: 'tests' stamp: 'FR 11/15/2020 09:35:39'!
test02PortfolioWithReceptiveAccountsHasCorrectHierarchy
	
	self  assertAccountHierarchyFor: self portfolioWithReceptiveAccount
		is: (OrderedCollection with: 'Un Portfolio' with: '	Un ReceptiveAccount')! !

!AccountHierarchyTest methodsFor: 'tests' stamp: 'FR 11/15/2020 00:21:48'!
test03PortfolioWithPortfoliosHasCorrectHierarchy

	| aPortfolio expectedHierarchyOne expectedHierarchyTwo portfolioHierarchy |
	
	aPortfolio := self portfolioWithReceptiveAccountAndPortfolio.
	
	expectedHierarchyOne := OrderedCollection with: 'Un Portfolio' with: '	Un ReceptiveAccount' with: '	Otro Portfolio' with: '		Otro ReceptiveAccount'.
	expectedHierarchyTwo := OrderedCollection with: 'Un Portfolio' with: '	Otro Portfolio' with: '		Otro ReceptiveAccount' with: '	Un ReceptiveAccount'.

	portfolioHierarchy := AccountHierarchy reportFor: aPortfolio.

	self assert: (portfolioHierarchy = expectedHierarchyOne or: [ portfolioHierarchy = expectedHierarchyTwo ])! !


!AccountHierarchyTest methodsFor: 'tests - assertions' stamp: 'FR 11/15/2020 00:01:10'!
assertAccountHierarchyFor: aPortfolio is: expectedHierarchy

	self assert: (AccountHierarchy reportFor: aPortfolio) equals: expectedHierarchy! !


!AccountHierarchyTest methodsFor: 'tests - portfolio instances' stamp: 'FR 11/15/2020 09:22:16'!
portfolioWithReceptiveAccount
	
	| aPortfolio |
	
	aPortfolio := Portfolio named: 'Un Portfolio'.
	
	aPortfolio add: (ReceptiveAccount named: 'Un ReceptiveAccount').
	
	^ aPortfolio! !

!AccountHierarchyTest methodsFor: 'tests - portfolio instances' stamp: 'FR 11/15/2020 09:23:13'!
portfolioWithReceptiveAccountAndPortfolio
	
	| aPortfolio anotherPortfolio |
	
	aPortfolio := self portfolioWithReceptiveAccount.
	anotherPortfolio := Portfolio named: 'Otro Portfolio'.

	aPortfolio add: anotherPortfolio.
	anotherPortfolio add: (ReceptiveAccount named: 'Otro ReceptiveAccount').
	
	^ aPortfolio! !


!classDefinition: #AccountSummaryTest category: 'Portfolio-Solucion'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryTest methodsFor: 'tests - ReceptiveAccount' stamp: 'FR 11/15/2020 09:34:16'!
test01ReceptiveAccountWithNoTransactionsHasCorrectSummary

	self  assertAccountSummaryFor: ReceptiveAccount new
		is: (OrderedCollection with: 'Balance = 0')! !

!AccountSummaryTest methodsFor: 'tests - ReceptiveAccount' stamp: 'FR 11/15/2020 09:34:23'!
test02ReceptiveAccountWithDepositsHasCorrectSummary
	
	self  assertAccountSummaryFor: self receptiveAccountWithDeposits
		hasTransactions: (Set with: 'Depósito por 50.' with: 'Depósito por 100.')! !

!AccountSummaryTest methodsFor: 'tests - ReceptiveAccount' stamp: 'FR 11/15/2020 09:34:29'!
test03ReceptiveAccountWithWithdrawHasCorrectSummary

	self  assertAccountSummaryFor: self receptiveAccountWithWithdraw
		hasTransactions: (Set with: 'Extracción por 50.')! !

!AccountSummaryTest methodsFor: 'tests - ReceptiveAccount' stamp: 'FR 11/15/2020 09:34:48'!
test04ReceptiveAccountWithOutgoingTransferHasCorrectSummary
	
	self  assertAccountSummaryFor: self receptiveAccountWithOutgoingTransfer
		hasTransactions: (Set with: 'Salida por transferencia de 50.')! !

!AccountSummaryTest methodsFor: 'tests - ReceptiveAccount' stamp: 'FR 11/15/2020 09:34:54'!
test05ReceptiveAccountWithIncomingTransferHasCorrectSummary
	
	self  assertAccountSummaryFor: self receptiveAccountWithIncomingTransfer
		hasTransactions: (Set with: 'Entrada por transferencia de 50.')! !


!AccountSummaryTest methodsFor: 'private - Portfolio instances' stamp: 'FR 11/15/2020 00:32:29'!
portfolioWithAccounts
	
	| aPortfolio anAccount anotherAccount |
	
	aPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	aPortfolio add: anAccount.
	aPortfolio add: anotherAccount.
	
	Deposit register: 100 on: anAccount.
	Withdraw register: 50 on: anotherAccount.
	Transfer register: 50 from: anAccount to: anotherAccount.
	
	^ aPortfolio! !


!AccountSummaryTest methodsFor: 'tests - Portfolio' stamp: 'FR 11/15/2020 09:35:03'!
test06PortfolioWithNoAccountsHasCorrectSummary
	
	self  assertAccountSummaryFor: (Portfolio new)
		is: (OrderedCollection with: 'Balance = 0')! !

!AccountSummaryTest methodsFor: 'tests - Portfolio' stamp: 'FR 11/15/2020 09:35:09'!
test07PortfolioWithAccountsHasCorrectSummary
	
	self  assertAccountSummaryFor: self portfolioWithAccounts
		hasTransactions: (Set with: 'Depósito por 100.' with: 'Salida por transferencia de 50.' with: 'Extracción por 50.' with: 'Entrada por transferencia de 50.')! !


!AccountSummaryTest methodsFor: 'private - assertions' stamp: 'FR 11/15/2020 00:08:25'!
assertAccountSummaryFor: anAccount hasTransactions: expectedTransactions

	| balanceLine expectedLines accountSummary |	
	
	balanceLine := 'Balance = ', anAccount balance asString.
	expectedLines := expectedTransactions copy.
	expectedLines add: balanceLine.
	
	accountSummary := AccountSummary reportFor: anAccount.
	
	self assert: accountSummary asSet equals: expectedLines.
	self assert: accountSummary last equals: balanceLine.! !

!AccountSummaryTest methodsFor: 'private - assertions' stamp: 'FR 11/15/2020 00:04:13'!
assertAccountSummaryFor: anAccount is: expectedAccountSummary

	self assert: (AccountSummary reportFor: anAccount) equals: expectedAccountSummary! !


!AccountSummaryTest methodsFor: 'private - ReceptiveAccount instances' stamp: 'FR 11/15/2020 09:31:34'!
pairOfReceptiveAccountsModifiedBy: aBlock
	
	| anAccount anotherAccount |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.

	aBlock value: anAccount value: anotherAccount.
	
	^ anAccount! !

!AccountSummaryTest methodsFor: 'private - ReceptiveAccount instances' stamp: 'FR 11/15/2020 09:28:41'!
receptiveAccountModifiedBy: aBlock
	
	| anAccount |
	
	anAccount := ReceptiveAccount new.
	
	aBlock value: anAccount.
	
	^ anAccount! !

!AccountSummaryTest methodsFor: 'private - ReceptiveAccount instances' stamp: 'FR 11/15/2020 09:29:47'!
receptiveAccountWithDeposits

	^ self receptiveAccountModifiedBy: [ :account |
		Deposit register: 50 on: account.
		Deposit register: 100 on: account.
	]! !

!AccountSummaryTest methodsFor: 'private - ReceptiveAccount instances' stamp: 'FR 11/15/2020 09:32:19'!
receptiveAccountWithIncomingTransfer

	^ self pairOfReceptiveAccountsModifiedBy: [ :anAccount :anotherAccount |
		Transfer register: 50 from: anotherAccount to: anAccount.
	]! !

!AccountSummaryTest methodsFor: 'private - ReceptiveAccount instances' stamp: 'FR 11/15/2020 09:32:38'!
receptiveAccountWithOutgoingTransfer

	^ self pairOfReceptiveAccountsModifiedBy: [ :anAccount :anotherAccount |
		Transfer register: 50 from: anAccount to: anotherAccount.
	]! !

!AccountSummaryTest methodsFor: 'private - ReceptiveAccount instances' stamp: 'FR 11/15/2020 09:30:15'!
receptiveAccountWithWithdraw

	^ self receptiveAccountModifiedBy: [ :account |
		Withdraw register: 50 on: account.
	]! !


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


!classDefinition: #TransactionHierarchyTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransactionHierarchyTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransactionHierarchyTest methodsFor: 'tests - Portfolio instances' stamp: 'FR 11/15/2020 09:48:15'!
portfolioWithAccountModifiedBy: aBlock
	
	| aPortfolio aReceptiveAccount |
	
	aPortfolio := Portfolio named: 'Un Portfolio'.
	aReceptiveAccount := ReceptiveAccount named: 'Un ReceptiveAccount'.

	aPortfolio add: aReceptiveAccount.
	
	aBlock value: aReceptiveAccount.
	
	^ aPortfolio! !

!TransactionHierarchyTest methodsFor: 'tests - Portfolio instances' stamp: 'FR 11/15/2020 09:49:48'!
portfolioWithEmptyAccount
	
	^ self portfolioWithAccountModifiedBy: [ :account | ]! !

!TransactionHierarchyTest methodsFor: 'tests - Portfolio instances' stamp: 'FR 11/15/2020 09:37:28'!
portfolioWithNonEmptyPortfolio
	
	| aPortfolio anotherPortfolio |
	
	aPortfolio := self portfolioWithEmptyAccount.
	anotherPortfolio := Portfolio named: 'Otro Portfolio'.

	aPortfolio add: anotherPortfolio.
	anotherPortfolio add: (ReceptiveAccount named: 'Otro ReceptiveAccount').
	
	^ aPortfolio! !

!TransactionHierarchyTest methodsFor: 'tests - Portfolio instances' stamp: 'FR 11/15/2020 09:49:55'!
portfolioWithTransactions
	
	^ self portfolioWithAccountModifiedBy: [ :account |
		Deposit register: 50 on: account
	]! !


!TransactionHierarchyTest methodsFor: 'tests' stamp: 'FR 11/15/2020 09:36:22'!
test01PortfolioWithNoAccountsHasTransactionHierarchyWithOnlyItsNameAndBalance
	
	self  assertTransactionHierarchyFor: (Portfolio named: 'Un Portfolio')
		is: (OrderedCollection with: 'Un Portfolio' with: '	Balance = 0')! !

!TransactionHierarchyTest methodsFor: 'tests' stamp: 'FR 11/15/2020 09:36:28'!
test02PortfolioWithEmptyAccountHasCorrectTransactionHierarchy

	self  assertTransactionHierarchyFor: self portfolioWithEmptyAccount
		is: (OrderedCollection with: 'Un Portfolio' with: '	Un ReceptiveAccount' with: '		Balance = 0' with: '	Balance = 0')! !

!TransactionHierarchyTest methodsFor: 'tests' stamp: 'FR 11/15/2020 00:37:15'!
test03PortfolioWithNonEmptyPortfolioHasCorrectTransactionHierarchy

	| expectedTransactionHierarchyOne expectedTransactionHierarchyTwo portfolioTransactionHierarchy |

	expectedTransactionHierarchyOne := OrderedCollection newFrom: {'Un Portfolio'. '	Un ReceptiveAccount'. '		Balance = 0'. '	Otro Portfolio'. '		Otro ReceptiveAccount'. '			Balance = 0'. '		Balance = 0'. '	Balance = 0'}.
	expectedTransactionHierarchyTwo := OrderedCollection newFrom: {'Un Portfolio'. '	Otro Portfolio'. '		Otro ReceptiveAccount'. '			Balance = 0'. '		Balance = 0'. '	Un ReceptiveAccount'. '		Balance = 0'. '	Balance = 0'}.
	
	portfolioTransactionHierarchy := TransactionHierarchy reportFor: self portfolioWithNonEmptyPortfolio.

	self assert: (portfolioTransactionHierarchy = expectedTransactionHierarchyOne or: [ portfolioTransactionHierarchy = expectedTransactionHierarchyTwo ])! !

!TransactionHierarchyTest methodsFor: 'tests' stamp: 'FR 11/15/2020 09:38:44'!
test04PortfolioWithTransactionsHasCorrectTransactionHierarchy
	
	self  assertTransactionHierarchyFor: self portfolioWithTransactions
		is: (OrderedCollection newFrom: {'Un Portfolio'. '	Un ReceptiveAccount'. '		Depósito por 50.'. '		Balance = 50'. '	Balance = 50'})
! !


!TransactionHierarchyTest methodsFor: 'tests - assertions' stamp: 'FR 11/15/2020 00:15:09'!
assertTransactionHierarchyFor: aPortfolio is: expectedTransactionHierarchy

	self assert: (TransactionHierarchy reportFor: aPortfolio) equals: expectedTransactionHierarchy! !


!classDefinition: #TransferNetTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetTest methodsFor: 'private - Portfolio instances' stamp: 'FR 11/15/2020 00:44:34'!
portfolioWithAccounts

	| aSuperPortfolio aPortfolio anotherPortfolio receptiveAccountOne receptiveAccountTwo receptiveAccountThree receptiveAccountFour |
	
	aSuperPortfolio := Portfolio new.
	aPortfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	receptiveAccountOne := ReceptiveAccount new.
	receptiveAccountTwo := ReceptiveAccount new.
	receptiveAccountThree := ReceptiveAccount new.
	receptiveAccountFour := ReceptiveAccount new.
	
	aSuperPortfolio add: aPortfolio.
	aSuperPortfolio add: anotherPortfolio.
	aSuperPortfolio add: receptiveAccountOne.
	aPortfolio add: receptiveAccountTwo.
	anotherPortfolio add: receptiveAccountThree.
	
	Deposit register: 100 on: receptiveAccountFour.
	Transfer register: 40 from: receptiveAccountFour to: receptiveAccountOne.
	Transfer register: 30 from: receptiveAccountOne to: receptiveAccountTwo.
	Transfer register: 20 from: receptiveAccountTwo to: receptiveAccountThree.
	Transfer register: 10 from: receptiveAccountThree to: receptiveAccountFour.
	
	^ aSuperPortfolio! !


!TransferNetTest methodsFor: 'tests - Portfolio' stamp: 'FR 11/15/2020 09:40:29'!
test03PortfolioWithNoAccountsHasZeroNetTransfer
	
	self  assertTransferNetOf: Portfolio new
		is: 0! !

!TransferNetTest methodsFor: 'tests - Portfolio' stamp: 'FR 11/15/2020 09:40:34'!
test04PortfolioWithAccountsHasCorrectNetTransfer
	
	self  assertTransferNetOf: self portfolioWithAccounts
		is: 30! !


!TransferNetTest methodsFor: 'private - assertions' stamp: 'FR 11/14/2020 23:56:34'!
assertTransferNetOf: anAccount is: aTransferNet

	self assert: (TransferNet reportFor: anAccount) equals: aTransferNet! !


!TransferNetTest methodsFor: 'tests - ReceptiveAccount' stamp: 'FR 11/15/2020 09:40:14'!
test01ReceptiveAccountWithNoTransfersHasZeroNetTransfer
	
	self  assertTransferNetOf: self receptiveAccountWithNoTransfers
		is: 0! !

!TransferNetTest methodsFor: 'tests - ReceptiveAccount' stamp: 'FR 11/15/2020 09:40:20'!
test02ReceptiveAccountWithTransfersHasCorrectNetTransfer
	
	self  assertTransferNetOf: self receptiveAccountWithTransfers
		is: -60! !


!TransferNetTest methodsFor: 'private - ReceptiveAccount instances' stamp: 'FR 11/16/2020 10:18:36'!
receptiveAccount: aReceptiveAccount modifiedBy: aBlock
		
	aBlock value: aReceptiveAccount.
		
	^ aReceptiveAccount! !

!TransferNetTest methodsFor: 'private - ReceptiveAccount instances' stamp: 'FR 11/16/2020 10:19:36'!
receptiveAccountWithDeposit
	
	^self receptiveAccount: (ReceptiveAccount new) modifiedBy: [ :account |
		Deposit register: 100 on: account
	]! !

!TransferNetTest methodsFor: 'private - ReceptiveAccount instances' stamp: 'FR 11/16/2020 10:20:05'!
receptiveAccountWithNoTransfers
	
	^self receptiveAccount: (self receptiveAccountWithDeposit) modifiedBy: [ :account |
		Withdraw register: 50 on: account.
	]! !

!TransferNetTest methodsFor: 'private - ReceptiveAccount instances' stamp: 'FR 11/15/2020 09:42:08'!
receptiveAccountWithTransfers
	
	| aReceptiveAccount anotherReceptiveAccount |
	
	aReceptiveAccount := self receptiveAccountWithDeposit.
	anotherReceptiveAccount := ReceptiveAccount new.
	
	Transfer register: 50 from: aReceptiveAccount to: anotherReceptiveAccount.
	Transfer register: 10 from: anotherReceptiveAccount to: aReceptiveAccount.
	Transfer register: 30 from: aReceptiveAccount to: anotherReceptiveAccount.
	Transfer register: 10 from: anotherReceptiveAccount to: aReceptiveAccount.
	
	^ aReceptiveAccount! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'tests' stamp: 'FR 11/15/2020 09:45:16'!
test01BalanceOfPayerAndPayeeChangesCorrectlyAfterTransfer

	self  registerTransferOf: 50
		fromPayerToPayeeAndAssert: [ :payer :payee :transfer |
			payer balance = -50 and: [ payee balance = 50 ]
		]! !

!TransferTest methodsFor: 'tests' stamp: 'FR 11/15/2020 09:45:16'!
test02PayerAndPayeeRegisterTransfer

	self  registerTransferOf: 100
		fromPayerToPayeeAndAssert: [ :payer :payee :transfer |
			(payer hasRegistered: transfer payerEnd) and: [
				payee hasRegistered: transfer payeeEnd
			]
		]! !

!TransferTest methodsFor: 'tests' stamp: 'FR 11/15/2020 09:45:16'!
test03CanGetFromOneTransferEndToTheOther

	self  registerTransferOf: 100
		fromPayerToPayeeAndAssert: [ :payer :payee :transfer |
			transfer payerEnd otherEnd = transfer payeeEnd and: [
				transfer payeeEnd otherEnd = transfer payerEnd
			]
		]! !

!TransferTest methodsFor: 'tests' stamp: 'FR 11/14/2020 23:45:50'!
test04CannotTransferToSelf

	| anAccount |
	
	anAccount := ReceptiveAccount new.
	
	self  transferring: 50
		from: anAccount
		to: anAccount
		shouldErrorWithMessage: Transfer transferToSelfErrorDescription! !

!TransferTest methodsFor: 'tests' stamp: 'FR 11/14/2020 23:27:52'!
test05CannotTransferAnAmountOfZero

	self assertShouldBeInvalidTransferAmount: 0! !

!TransferTest methodsFor: 'tests' stamp: 'FR 11/14/2020 23:28:00'!
test06CannotTransferANegativeAmount

	self assertShouldBeInvalidTransferAmount: -50! !


!TransferTest methodsFor: 'tests - assertions' stamp: 'FR 11/14/2020 23:34:48'!
assertShouldBeInvalidTransferAmount: anAmount

	| payerAccount payeeAccount |
	
	payerAccount := ReceptiveAccount new.
	payeeAccount := ReceptiveAccount new.
	
	self transferring: anAmount from: payerAccount to: payeeAccount shouldErrorWithMessage: Transfer invalidTransferAmountErrorDescription! !

!TransferTest methodsFor: 'tests - assertions' stamp: 'FR 11/15/2020 09:45:16'!
registerTransferOf: anAmount fromPayerToPayeeAndAssert: aBlock

	| payerAccount payeeAccount aTransfer |
	
	payerAccount := ReceptiveAccount new.
	payeeAccount := ReceptiveAccount new.
	
	aTransfer := Transfer register: anAmount from: payerAccount to: payeeAccount.
	
	self assert: (aBlock value: payerAccount value: payeeAccount value: aTransfer)! !

!TransferTest methodsFor: 'tests - assertions' stamp: 'FR 11/14/2020 23:34:29'!
transferring: anAmount from: payerAccount to: payeeAccount shouldErrorWithMessage: messageText
	
	self  should: [ Transfer register: anAmount from: payerAccount to: payeeAccount ]
		raise: Error - MessageNotUnderstood
		withMessageText: messageText! !


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


!Account methodsFor: 'reporting' stamp: 'FR 11/14/2020 23:14:22'!
reportTo: aReport

	self subclassResponsibility! !

!Account methodsFor: 'reporting' stamp: 'FR 11/14/2020 09:33:13'!
reportTransactions: aReport

	self subclassResponsibility! !


!Account methodsFor: 'initialization' stamp: 'FR 11/14/2020 09:17:52'!
initializeWithName: aName

	name := aName! !


!Account methodsFor: 'accessing' stamp: 'FR 11/14/2020 09:50:07'!
name

	^ name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'Portfolio-Solucion'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'instance creation' stamp: 'FR 11/14/2020 23:20:17'!
named: aName

	^ super new initializeWithName: aName! !

!Account class methodsFor: 'instance creation' stamp: 'FR 11/14/2020 23:22:01'!
new

	^ self named: self defaultName! !


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


!Portfolio methodsFor: 'reporting' stamp: 'FR 11/14/2020 09:35:51'!
reportAccounts: aReport

	accounts do: [ :anAccount | anAccount reportTo: aReport ]! !

!Portfolio methodsFor: 'reporting' stamp: 'FR 11/14/2020 09:35:31'!
reportTo: aReport

	aReport reportPortfolio: self! !

!Portfolio methodsFor: 'reporting' stamp: 'FR 11/14/2020 09:33:13'!
reportTransactions: aReport

	accounts do: [ :anAccount | anAccount reportTransactions: aReport ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error description' stamp: 'NR 11/9/2020 06:01:26'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio!!'! !


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


!Portfolio class methodsFor: 'name' stamp: 'FR 11/14/2020 23:18:51'!
defaultName

	^ 'Un Portfolio'! !


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


!ReceptiveAccount methodsFor: 'reporting' stamp: 'FR 11/14/2020 09:40:26'!
reportTo: aReport

	aReport reportReceptiveAccount: self! !

!ReceptiveAccount methodsFor: 'reporting' stamp: 'FR 11/14/2020 09:33:13'!
reportTransactions: aReport

	transactions do: [ :aTransaction | aTransaction reportTo: aReport ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'name' stamp: 'FR 11/14/2020 23:19:06'!
defaultName

	^ 'Una ReceptiveAccount'! !


!classDefinition: #AccountReport category: 'Portfolio-Solucion'!
Object subclass: #AccountReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountReport methodsFor: 'reporting' stamp: 'FR 11/14/2020 11:10:10'!
addNameToHierarchy: anAccount

	self subclassResponsibility! !

!AccountReport methodsFor: 'reporting' stamp: 'FR 11/14/2020 11:10:36'!
getReport: aPortfolio

	self subclassResponsibility! !


!AccountReport methodsFor: 'private - reporting' stamp: 'FR 11/14/2020 11:10:52'!
reportPortfolio: aPortfolio

	self subclassResponsibility! !

!AccountReport methodsFor: 'private - reporting' stamp: 'FR 11/14/2020 11:11:14'!
reportReceptiveAccount: aReceptiveAccount

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReport class' category: 'Portfolio-Solucion'!
AccountReport class
	instanceVariableNames: ''!

!AccountReport class methodsFor: 'reporting' stamp: 'FR 11/14/2020 11:10:20'!
reportFor: aPortfolio

	^ self new getReport: aPortfolio! !


!classDefinition: #AccountHierarchy category: 'Portfolio-Solucion'!
AccountReport subclass: #AccountHierarchy
	instanceVariableNames: 'accountHierarchy indentDepth'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountHierarchy methodsFor: 'private - reporting' stamp: 'FR 11/14/2020 11:02:24'!
reportPortfolio: aPortfolio

	self addNameToHierarchy: aPortfolio.
	
	indentDepth := indentDepth + 1.
	
	aPortfolio reportAccounts: self.
	
	indentDepth := indentDepth - 1.! !

!AccountHierarchy methodsFor: 'private - reporting' stamp: 'FR 11/14/2020 11:02:24'!
reportReceptiveAccount: aReceptiveAccount

	self addNameToHierarchy: aReceptiveAccount.
! !


!AccountHierarchy methodsFor: 'reporting' stamp: 'FR 11/16/2020 10:08:56'!
addNameToHierarchy: anAccount

	| lineToAdd |
	
	lineToAdd := ''.
	
	indentDepth timesRepeat: [
		lineToAdd := lineToAdd, '	'
	].

	lineToAdd := lineToAdd, anAccount name.
	
	accountHierarchy add: lineToAdd! !

!AccountHierarchy methodsFor: 'reporting' stamp: 'FR 11/16/2020 10:08:56'!
getReport: aPortfolio

	indentDepth := 0.
	accountHierarchy := OrderedCollection new.
	
	aPortfolio reportTo: self.
		
	^ accountHierarchy! !


!classDefinition: #TransactionHierarchy category: 'Portfolio-Solucion'!
AccountReport subclass: #TransactionHierarchy
	instanceVariableNames: 'transactionHierarchy indentDepth'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransactionHierarchy methodsFor: 'reporting' stamp: 'FR 11/14/2020 10:57:20'!
addBalanceToHierarchy: aReceptiveAccount

	self addLineToHierarchy: 'Balance = ', aReceptiveAccount balance asString! !

!TransactionHierarchy methodsFor: 'reporting' stamp: 'FR 11/14/2020 10:57:20'!
addLineToHierarchy: aLine
	
	| lineToAdd |
	
	lineToAdd := ''.
	
	indentDepth timesRepeat: [
		lineToAdd := lineToAdd, '	'
	].

	lineToAdd := lineToAdd, aLine.
	
	transactionHierarchy add: lineToAdd! !

!TransactionHierarchy methodsFor: 'reporting' stamp: 'FR 11/14/2020 10:57:40'!
addNameToHierarchy: anAccount

	self addLineToHierarchy: anAccount name! !

!TransactionHierarchy methodsFor: 'reporting' stamp: 'FR 11/14/2020 10:57:48'!
addSummaryToHierarchy: aReceptiveAccount

	| accountSummary |
	
	accountSummary := AccountSummary reportFor: aReceptiveAccount.
	accountSummary do: [ :aLine | self addLineToHierarchy: aLine ].! !

!TransactionHierarchy methodsFor: 'reporting' stamp: 'FR 11/14/2020 10:57:00'!
getReport: aPortfolio

	indentDepth := 0.
	transactionHierarchy := OrderedCollection new.

	aPortfolio reportTo: self.
	
	^ transactionHierarchy! !


!TransactionHierarchy methodsFor: 'private - reporting' stamp: 'FR 11/14/2020 10:57:40'!
reportPortfolio: aPortfolio

	self addNameToHierarchy: aPortfolio.
	
	indentDepth := indentDepth + 1.
	
	aPortfolio reportAccounts: self.
		
	self addBalanceToHierarchy: aPortfolio.
	
	indentDepth := indentDepth - 1.! !

!TransactionHierarchy methodsFor: 'private - reporting' stamp: 'FR 11/14/2020 10:57:48'!
reportReceptiveAccount: aReceptiveAccount

	self addNameToHierarchy: aReceptiveAccount.
	
	indentDepth := indentDepth + 1.
	
	self addSummaryToHierarchy: 	aReceptiveAccount.
	
	indentDepth := indentDepth - 1.! !


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


!AccountTransaction methodsFor: 'reporting' stamp: 'FR 11/13/2020 16:29:20'!
reportTo: aReport

	self subclassResponsibility! !

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


!Deposit methodsFor: 'reporting' stamp: 'FR 11/13/2020 16:29:32'!
reportTo: aReport

	aReport reportDeposit: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferEnd category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferEnd
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferEnd methodsFor: 'value' stamp: 'FR 11/12/2020 09:22:22'!
value

	^ transfer amount! !


!TransferEnd methodsFor: 'initialization' stamp: 'FR 11/12/2020 09:22:51'!
initializeFor: aTransfer

	transfer := aTransfer! !


!TransferEnd methodsFor: 'reporting' stamp: 'FR 11/13/2020 16:29:39'!
reportTo: aReport

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferEnd class' category: 'Portfolio-Solucion'!
TransferEnd class
	instanceVariableNames: ''!

!TransferEnd class methodsFor: 'instance creation' stamp: 'FR 11/14/2020 23:15:18'!
for: aTransfer

	^ self new initializeFor: aTransfer! !


!classDefinition: #IncomingTransfer category: 'Portfolio-Solucion'!
TransferEnd subclass: #IncomingTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!IncomingTransfer methodsFor: 'balance' stamp: 'FR 11/12/2020 09:03:24'!
affectBalance: aBalance

	^aBalance + self value! !


!IncomingTransfer methodsFor: 'accessing' stamp: 'FR 11/12/2020 09:12:29'!
otherEnd
	
	^ transfer payerEnd! !


!IncomingTransfer methodsFor: 'reporting' stamp: 'FR 11/13/2020 16:29:45'!
reportTo: aReport

	aReport reportIncomingTransfer: self! !


!classDefinition: #OutgoingTransfer category: 'Portfolio-Solucion'!
TransferEnd subclass: #OutgoingTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!OutgoingTransfer methodsFor: 'balance' stamp: 'FR 11/12/2020 09:03:33'!
affectBalance: aBalance

	^aBalance - self value! !


!OutgoingTransfer methodsFor: 'accessing' stamp: 'FR 11/12/2020 09:12:15'!
otherEnd
	
	^ transfer payeeEnd! !


!OutgoingTransfer methodsFor: 'reporting' stamp: 'FR 11/13/2020 16:29:51'!
reportTo: aReport

	aReport reportOutgoingTransfer: self! !


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


!Withdraw methodsFor: 'reporting' stamp: 'FR 11/13/2020 16:29:59'!
reportTo: aReport

	aReport reportWithdraw: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransactionReport category: 'Portfolio-Solucion'!
Object subclass: #TransactionReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransactionReport methodsFor: 'reporting' stamp: 'FR 11/13/2020 16:37:45'!
getReport: anAccount

	self subclassResponsibility! !


!TransactionReport methodsFor: 'private - reporting' stamp: 'FR 11/13/2020 16:38:22'!
reportDeposit: aDeposit

	self subclassResponsibility! !

!TransactionReport methodsFor: 'private - reporting' stamp: 'FR 11/13/2020 16:39:16'!
reportIncomingTransfer: anIncomingTransfer

	self subclassResponsibility! !

!TransactionReport methodsFor: 'private - reporting' stamp: 'FR 11/13/2020 16:39:23'!
reportOutgoingTransfer: anOutgoingTransfer

	self subclassResponsibility! !

!TransactionReport methodsFor: 'private - reporting' stamp: 'FR 11/13/2020 16:39:10'!
reportWithdraw: aWithdraw

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransactionReport class' category: 'Portfolio-Solucion'!
TransactionReport class
	instanceVariableNames: ''!

!TransactionReport class methodsFor: 'reporting' stamp: 'FR 11/13/2020 16:37:23'!
reportFor: anAccount

	^ self new getReport: anAccount! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
TransactionReport subclass: #AccountSummary
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'reporting' stamp: 'FR 11/14/2020 09:33:13'!
getReport: anAccount

	summary := OrderedCollection new.
	
	anAccount reportTransactions: self.
	
	summary add: 'Balance = ', anAccount balance asString.
	
	^ summary! !


!AccountSummary methodsFor: 'private - reporting' stamp: 'FR 11/13/2020 16:25:10'!
reportDeposit: aDeposit

	summary add: 'Depósito por ', aDeposit value asString, '.'! !

!AccountSummary methodsFor: 'private - reporting' stamp: 'FR 11/13/2020 16:25:18'!
reportIncomingTransfer: anIncomingTransfer

	summary add: 'Entrada por transferencia de ', anIncomingTransfer value asString, '.'! !

!AccountSummary methodsFor: 'private - reporting' stamp: 'FR 11/13/2020 16:25:26'!
reportOutgoingTransfer: anOutgoingTransfer

	summary add: 'Salida por transferencia de ', anOutgoingTransfer value asString, '.'! !

!AccountSummary methodsFor: 'private - reporting' stamp: 'FR 11/13/2020 16:25:37'!
reportWithdraw: aWithdraw

	summary add: 'Extracción por ', aWithdraw value asString, '.'! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
TransactionReport subclass: #TransferNet
	instanceVariableNames: 'transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'private - reporting' stamp: 'FR 11/13/2020 16:33:44'!
reportDeposit: aDeposit! !

!TransferNet methodsFor: 'private - reporting' stamp: 'FR 11/13/2020 16:33:50'!
reportIncomingTransfer: anIncomingTransfer

	transferNet := anIncomingTransfer affectBalance: transferNet.! !

!TransferNet methodsFor: 'private - reporting' stamp: 'FR 11/13/2020 16:33:55'!
reportOutgoingTransfer: anOutgoingTransfer

	transferNet := anOutgoingTransfer affectBalance: transferNet.! !

!TransferNet methodsFor: 'private - reporting' stamp: 'FR 11/13/2020 16:34:00'!
reportWithdraw: aWithdraw! !


!TransferNet methodsFor: 'reporting' stamp: 'FR 11/14/2020 09:33:13'!
getReport: anAccount
	
	transferNet := 0.

	anAccount reportTransactions: self.
	
	^ transferNet! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'payerEnd payeeEnd amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'FR 11/12/2020 09:10:05'!
initializeWithAmount: transferAmount from: transferPayer to: transferPayee

	payerEnd := OutgoingTransfer for: self.
	payeeEnd := IncomingTransfer for: self.
	
	transferPayer register: payerEnd.
	transferPayee register: payeeEnd.
	
	amount := transferAmount.! !


!Transfer methodsFor: 'accessing' stamp: 'FR 11/16/2020 10:06:46'!
amount

	^ amount copy! !

!Transfer methodsFor: 'accessing' stamp: 'FR 11/12/2020 09:09:23'!
payeeEnd

	^ payeeEnd! !

!Transfer methodsFor: 'accessing' stamp: 'FR 11/12/2020 09:09:28'!
payerEnd

	^ payerEnd! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'FR 11/12/2020 09:19:12'!
register: transferAmount from: transferPayer to: transferPayee 

	transferPayer = transferPayee ifTrue: [ self transferToSelfError ].
	transferAmount <= 0 ifTrue: [ self invalidTransferAmountError ].

	^ self new initializeWithAmount: transferAmount from: transferPayer to: transferPayee! !


!Transfer class methodsFor: 'error descriptions' stamp: 'FR 11/12/2020 09:19:25'!
invalidTransferAmountErrorDescription
	
	^ 'Transfer amount must be strictly positive!!' ! !

!Transfer class methodsFor: 'error descriptions' stamp: 'FR 11/12/2020 09:13:44'!
transferToSelfErrorDescription
	
	^ 'Cannot transfer to myself!!'! !


!Transfer class methodsFor: 'errors' stamp: 'FR 11/12/2020 09:18:22'!
invalidTransferAmountError

	^ self error: self invalidTransferAmountErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'FR 11/12/2020 09:14:48'!
transferToSelfError

	^ self error: self transferToSelfErrorDescription! !
