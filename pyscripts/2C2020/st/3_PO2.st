!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'test name' stamp: 'DS 11/15/2020 21:42:04'!
test16PortfolioWithoutNameShouldInitializeWithDefaultName

	| account |
	
	account := Portfolio new.
	
	self assert: 'A Portfolio' equals: account yourName.! !


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


!ReceptiveAccountTest methodsFor: 'test name' stamp: 'DS 11/15/2020 21:34:15'!
test08ReceptiveAccountWithoutNameShouldInitializeWithDefaultName

	| account |
	
	account := ReceptiveAccount new.
	
	self assert: 'A Receptive Account' equals: account yourName.! !


!classDefinition: #ReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: 'tab'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTest methodsFor: 'setup' stamp: 'DS 11/15/2020 21:17:35'!
setUp

	tab := '    '.! !


!ReportTest methodsFor: 'account summary' stamp: 'DS 11/15/2020 23:53:37'!
test01EmptyAccountShouldHaveAccountSummarytWithBalanceInZero

	| accountSummary expectedAccountSummary |

	accountSummary := AccountSummary for: (ReceptiveAccount new).
	expectedAccountSummary := OrderedCollection with: 'Balance = 0'.

	self assert: expectedAccountSummary equals: accountSummary make.! !

!ReportTest methodsFor: 'account summary' stamp: 'DS 11/15/2020 23:53:37'!
test02AccountWithTransactionsShouldHaveAffectedHisAccountSummary

	| accountSummary account expectedAccountSummary |

	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 100 on: account.
	
	accountSummary := AccountSummary for: account.

	expectedAccountSummary := OrderedCollection with: 'Deposito por 100' with: 'Extraccion por 100' with: 'Balance = 0'.

	self assert: expectedAccountSummary equals: accountSummary make.! !

!ReportTest methodsFor: 'account summary' stamp: 'DS 11/15/2020 23:53:37'!
test03TransferShouldAffectAccountSummaryOfBothComponents

	| accountSummaryFrom accountSummaryTo aFromAccount aToAccount expectedAccountSummaryFrom expectedAccountSummaryTo |
	
	aFromAccount := ReceptiveAccount new.
	aToAccount := ReceptiveAccount new.
	Transfer register: 100 from: aFromAccount to: aToAccount.
	
	accountSummaryFrom := AccountSummary for: aFromAccount.
	expectedAccountSummaryFrom := OrderedCollection with: 'Salida por transferencia de 100' with: 'Balance = -100'.

	accountSummaryTo := AccountSummary for: aToAccount.
	expectedAccountSummaryTo := OrderedCollection with: 'Entrada por transferencia de 100' with: 'Balance = 100'.	

	self assert: expectedAccountSummaryFrom equals: accountSummaryFrom make.
	self assert: expectedAccountSummaryTo equals: accountSummaryTo make.! !

!ReportTest methodsFor: 'account summary' stamp: 'DS 11/15/2020 23:53:37'!
test04TransactionsInPortfolioShouldAffectHisAccountSummary

	| accountSummary portfolio firstAccount secondAccount expectedAccountSummary |

	portfolio := Portfolio new.
	firstAccount := ReceptiveAccount new.
	secondAccount := ReceptiveAccount new.

	Deposit register: 100 on: firstAccount.
	Withdraw register: 50 on: secondAccount.

	portfolio add: firstAccount.
	portfolio add: secondAccount.

	accountSummary := AccountSummary for: portfolio.
	expectedAccountSummary := OrderedCollection with: 'Deposito por 100' with: 'Extraccion por 50' with: 'Balance = 50'.

	self assert: expectedAccountSummary equals: accountSummary make.! !


!ReportTest methodsFor: 'net of transference' stamp: 'DS 11/15/2020 23:53:57'!
test05EmptyAccountShouldHaveNetTrasnferencesInZero

	| account netOfTrasnferences |
	
	account := ReceptiveAccount new.
	netOfTrasnferences := NetOfTrasnferences for: account.

	self assert: 0 equals: netOfTrasnferences make.! !

!ReportTest methodsFor: 'net of transference' stamp: 'DS 11/15/2020 23:53:57'!
test06TransferShouldAffectNetTransferencesOfBothComponents

	| accountFrom accountTo netOfTransferencesFrom netOfTransferencesTo |

	accountFrom := ReceptiveAccount new.
	accountTo := ReceptiveAccount new.
	Transfer register: 100 from: accountFrom to: accountTo.

	netOfTransferencesFrom := NetOfTrasnferences for: accountFrom.
	netOfTransferencesTo := NetOfTrasnferences for: accountTo.

	self assert: -100 equals: netOfTransferencesFrom make.
	self assert: 100 equals: netOfTransferencesTo make.! !

!ReportTest methodsFor: 'net of transference' stamp: 'DS 11/15/2020 23:53:57'!
test07PortfolioNetOfTransferencesShouldBeAffectedByHisAccounts

	| portfolio fromAccount toAccount netOfTrnasference |

	portfolio := Portfolio new.
	fromAccount := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.

	portfolio add: toAccount.

	Transfer register: 100 from: fromAccount to: toAccount.
	Deposit register: 100 on: toAccount.
	Withdraw register: 100 on: toAccount.
	
	netOfTrnasference := NetOfTrasnferences for: portfolio.

	self assert: 100 equals: netOfTrnasference make.! !


!ReportTest methodsFor: 'accounts tree' stamp: 'DS 11/15/2020 23:54:29'!
test08PortfolioWithoutAccountsShouldHaveAccountsTreeWithOnlyHisName

	| namedPortfolio portfolioTree expectedPortfolioTree |
	
	namedPortfolio := Portfolio named: 'Portfolio Diego'. 
	
	portfolioTree := AccountsTree for: namedPortfolio.
	expectedPortfolioTree := OrderedCollection with: 'Portfolio Diego'.

	self assert: expectedPortfolioTree equals: portfolioTree make.! !

!ReportTest methodsFor: 'accounts tree' stamp: 'DS 11/15/2020 23:54:29'!
test09PortfolioWithOneLevelShouldHaveAccountTreeWithOneTab

	| namedPortfolio namedAccount portfolioTree expectedPortfolioTree |
	
	namedAccount := ReceptiveAccount named: 'Cuenta Fede'.
	namedPortfolio := Portfolio named: 'Portfolio Diego' with: namedAccount. 
	
	portfolioTree := AccountsTree for: namedPortfolio.

	expectedPortfolioTree := OrderedCollection with: 'Portfolio Diego' with: (tab, 'Cuenta Fede').

	self assert: expectedPortfolioTree equals: portfolioTree make.! !

!ReportTest methodsFor: 'accounts tree' stamp: 'DS 11/15/2020 23:54:29'!
test10PortfolioWithMoreThanOneLevelShouldHaveAccountsTreeWithRespectiveTabs

	| expectedPortfolioTree accountsTree rootPortfolio secondPorfolio thirdPortfolio receptiveAccount |

	receptiveAccount := ReceptiveAccount named: 'Cuenta de Fede'.
	thirdPortfolio := Portfolio named: 'Portfolio 3er nivel' with: receptiveAccount.
	secondPorfolio := Portfolio named: 'Portfolio 2do nivel' with: thirdPortfolio.
	rootPortfolio := Portfolio named: 'Root Portfolio' with: secondPorfolio.
	
	expectedPortfolioTree := OrderedCollection with: 'Root Portfolio'
		with: (tab, 'Portfolio 2do nivel')
		with: (tab, tab, 'Portfolio 3er nivel')
		with: (tab, tab, tab, 'Cuenta de Fede').
		
	accountsTree := AccountsTree for: rootPortfolio.

	self assert: expectedPortfolioTree equals:  accountsTree make.! !


!ReportTest methodsFor: 'accounts summary tree' stamp: 'DS 11/15/2020 23:54:17'!
test11EmptyPortfolioShouldHaveAccountsSummaryTreeWithHisNameAndZeroBalance

	| accountsSummaryTree expectedPortfolioTree portfolio |
	
	portfolio := Portfolio named: 'Portfolio Fede'.

	accountsSummaryTree := AccountsSummaryTree for: portfolio.
	expectedPortfolioTree := OrderedCollection with: 'Portfolio Fede' with: 'Balance = 0'.

	self assert: expectedPortfolioTree equals: accountsSummaryTree make.! !

!ReportTest methodsFor: 'accounts summary tree' stamp: 'DS 11/15/2020 23:54:17'!
test12PortfolioWithOneLevelShouldHaveAccountSummaryTreeWithOneTab

	| accountsSummaryTree expectedPortfolioTree portfolio account |
	
	portfolio := Portfolio named: 'Portfolio Fede'.
	account := ReceptiveAccount named: 'Cuenta Diego'.

	portfolio add: account.
	Deposit register: 100 on: account.	
	Withdraw register: 50 on: account.

	accountsSummaryTree := AccountsSummaryTree for: portfolio.
	expectedPortfolioTree := OrderedCollection
		with: 'Portfolio Fede'
		with: (tab, 'Cuenta Diego')
		with: (tab, 'Deposito por 100')
		with: (tab, 'Extraccion por 50')
		with: (tab, 'Balance = 50')
		with: 'Balance = 50'.

	self assert: expectedPortfolioTree equals: accountsSummaryTree make.! !

!ReportTest methodsFor: 'accounts summary tree' stamp: 'DS 11/15/2020 23:54:17'!
test13PortfolioWithMoreThanOneLevelShouldHaveAccountsSummaryTreeWithRespectiveTabs

	| expectedPortfolioTree accountsSumaryTree rootPortfolio secondPorfolio thirdPortfolio fedeAccount diegoAccount |

	fedeAccount := ReceptiveAccount named: 'Cuenta de Fede'.
	diegoAccount := ReceptiveAccount named: 'Cuenta de Diego'.
	thirdPortfolio := Portfolio named: 'Portfolio 3er nivel' with: fedeAccount.
	secondPorfolio := Portfolio named: 'Portfolio 2do nivel' with: thirdPortfolio.
	rootPortfolio := Portfolio named: 'Root Portfolio' with: secondPorfolio.

	Deposit register: 100 on: fedeAccount.
	Transfer register: 100 from: fedeAccount to: diegoAccount.
	
	expectedPortfolioTree := OrderedCollection new.
	expectedPortfolioTree add: 'Root Portfolio'.
	expectedPortfolioTree add: (tab, 'Portfolio 2do nivel').
	expectedPortfolioTree add: (tab, tab, 'Portfolio 3er nivel').
	expectedPortfolioTree add: (tab, tab, tab, 'Cuenta de Fede').
	expectedPortfolioTree add: (tab, tab, tab, 'Deposito por 100').
	expectedPortfolioTree add: (tab, tab, tab, 'Salida por transferencia de 100').
	expectedPortfolioTree add: (tab, tab, tab, 'Balance = 0').
	expectedPortfolioTree add: (tab, tab, 'Balance = 0').
	expectedPortfolioTree add: (tab, 'Balance = 0').
	expectedPortfolioTree add: ('Balance = 0').

	accountsSumaryTree := AccountsSummaryTree for: rootPortfolio.

	self assert: expectedPortfolioTree equals:  accountsSumaryTree make.! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'tests' stamp: 'DS 11/12/2020 21:34:46'!
test01ParticipantsShouldHaveTheirRespectiveTransferComponent

	| accountFrom accountTo transfer |

	accountFrom := ReceptiveAccount new.
	accountTo := ReceptiveAccount new.

	Deposit register: 100 on: accountFrom.

	transfer := Transfer register: 100 from: accountFrom to: accountTo.	

	self assert: (transfer depositTransaction value) equals: 100.
	self assert: (transfer withdrawTransaction value) equals: 100.
	self assert: (accountFrom hasRegistered: transfer depositTransaction).
	self assert: (accountTo hasRegistered: transfer withdrawTransaction).! !

!TransferTest methodsFor: 'tests' stamp: 'DS 11/12/2020 21:24:51'!
test02TransferShouldHaveAffectedBalanceOfParticipants

	| accountFrom accountTo |

	accountFrom := ReceptiveAccount new.
	accountTo := ReceptiveAccount new.

	Transfer register: 100 from: accountFrom to: accountTo.	

	self assert: (accountFrom balance) equals: -100.
	self assert: (accountTo balance) equals: 100.! !

!TransferTest methodsFor: 'tests' stamp: 'DS 11/12/2020 21:27:35'!
test03TransferComponentsCanNavigateToTheirPairComponent

	| accountFrom accountTo transference depositTransference withdrawTransference |

	accountFrom := ReceptiveAccount new.
	accountTo := ReceptiveAccount new.

	transference := Transfer register: 100 from: accountFrom to: accountTo.	
	
	depositTransference := transference depositTransaction.
	withdrawTransference := transference withdrawTransaction.

	self assert: (withdrawTransference transferPair ) equals: depositTransference.
	self assert: (depositTransference transferPair ) equals: withdrawTransference.! !

!TransferTest methodsFor: 'tests' stamp: 'DS 11/12/2020 21:46:49'!
test04TransferShouldNotHaveTheSameOriginAndDestinyAccount

	| account |

	account := ReceptiveAccount new.

	self should: [Transfer register: 100 from: account to: account .	]
	raise: Error
	withMessageText: Transfer canNotRegisterATransferToHimselfErrorDescription.! !

!TransferTest methodsFor: 'tests' stamp: 'DS 11/15/2020 17:52:01'!
test05TransferShouldNotRegisterANegativeAmmount

	| aFromAccount aToAccount |

	aFromAccount := ReceptiveAccount new.
	aToAccount := ReceptiveAccount new.

	self should: [Transfer register: -1 from: aFromAccount to: aToAccount .	]
	raise: Error
	withMessageText: Transfer canNotTransferNegativeAmountErrorDescription.! !


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


!Account methodsFor: 'affect report' stamp: 'DS 11/15/2020 23:17:07'!
affectReport: anAccountReport

	self subclassResponsibility.! !

!Account methodsFor: 'affect report' stamp: 'DS 11/15/2020 23:17:21'!
affectReportUsingTransactions: anAccountReport

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'Portfolio-Solucion'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'default name' stamp: 'DS 11/15/2020 21:40:03'!
defaultName

	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name account anotherAccount_CHANGE_ME'
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


!Portfolio methodsFor: 'initialization' stamp: 'DS 11/15/2020 21:40:41'!
initialize

	self initializeNamed: (self class defaultName).! !

!Portfolio methodsFor: 'initialization' stamp: 'FedericoSabatini 11/15/2020 19:19:20'!
initializeNamed: aName 

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := aName.! !

!Portfolio methodsFor: 'initialization' stamp: 'FedericoSabatini 11/15/2020 19:19:49'!
initializeNamed: aName with: anAccount

	accounts := OrderedCollection with: anAccount.
	parents := OrderedCollection new.
	name := aName.! !

!Portfolio methodsFor: 'initialization' stamp: 'DS 11/15/2020 20:45:38'!
initializeNamed: aName with: anAccount with: anotherAccount 

	accounts := OrderedCollection with: anAccount with: anotherAccount.
	parents := OrderedCollection new.
	name := aName.! !


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


!Portfolio methodsFor: 'accesing' stamp: 'FedericoSabatini 11/15/2020 20:26:55'!
yourName
	^name.! !


!Portfolio methodsFor: 'affect report' stamp: 'DS 11/15/2020 20:49:37'!
affectReport: anAccountReport

	^anAccountReport affectReportForPortfolio: self.
! !

!Portfolio methodsFor: 'affect report' stamp: 'FedericoSabatini 11/15/2020 20:22:50'!
affectReportUsingAccounts: anAccountsReport
	^accounts collect: [ :anAccount | anAccountsReport affectUsing: anAccount ].! !

!Portfolio methodsFor: 'affect report' stamp: 'FedericoSabatini 11/15/2020 20:17:11'!
affectReportUsingTransactions: anAccountReport

    ^self transactions collect: [ :aTransaction | aTransaction affectReport: anAccountReport ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'FedericoSabatini 11/15/2020 19:20:23'!
named: aName 

	^self new initializeNamed: aName ! !

!Portfolio class methodsFor: 'instance creation' stamp: 'FedericoSabatini 11/15/2020 19:20:50'!
named: aName with: anAccount 

	^self new initializeNamed: aName with: anAccount ! !

!Portfolio class methodsFor: 'instance creation' stamp: 'DS 11/15/2020 20:44:44'!
named: aName with: anAccount with: anotherAccount

	^self new initializeNamed: aName with: anAccount with: anotherAccount.! !

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


!Portfolio class methodsFor: 'error description' stamp: 'NR 11/9/2020 06:01:26'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio!!'! !


!Portfolio class methodsFor: 'default name' stamp: 'DS 11/15/2020 21:39:33'!
defaultName

	^'A Portfolio'.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'DS 11/15/2020 21:41:26'!
initialize

	self initializeNamed: (self class defaultName).! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'FedericoSabatini 11/15/2020 19:15:58'!
initializeNamed: aName 

	super initialize.
	transactions := OrderedCollection new.
	name := aName.! !


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


!ReceptiveAccount methodsFor: 'balance' stamp: 'DS 11/9/2020 20:56:24'!
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


!ReceptiveAccount methodsFor: 'accessing' stamp: 'FedericoSabatini 11/15/2020 20:29:29'!
yourName
	^name.! !


!ReceptiveAccount methodsFor: 'affect report' stamp: 'DS 11/15/2020 20:48:18'!
affectReport: anAccountReport

	^anAccountReport affectReportForReceptiveAccount: self.! !

!ReceptiveAccount methodsFor: 'affect report' stamp: 'FedericoSabatini 11/15/2020 20:17:18'!
affectReportUsingTransactions: anAccountReport

    ^transactions collect: [ :aTransaction | anAccountReport affectUsing: aTransaction ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'default name' stamp: 'DS 11/15/2020 21:39:03'!
defaultName

	^'A Receptive Account'.! !


!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'FedericoSabatini 11/15/2020 19:15:26'!
named: aName 
	^self new initializeNamed: aName ! !


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


!AccountTransaction methodsFor: 'affect report' stamp: 'DS 11/15/2020 17:49:39'!
affectReport: anAccountReport

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


!Deposit methodsFor: 'affect report' stamp: 'DS 11/15/2020 17:33:59'!
affectReport: anAccountReport

	^anAccountReport affectReportForDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferComponent category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferComponent
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferComponent methodsFor: 'initialization' stamp: 'DS 11/12/2020 21:30:41'!
initializeFor: aTransfer

	transfer := aTransfer.! !


!TransferComponent methodsFor: 'component' stamp: 'DS 11/12/2020 21:32:12'!
transferPair

	self subclassResponsibility.! !


!TransferComponent methodsFor: 'value' stamp: 'DS 11/12/2020 21:35:25'!
value

	^transfer value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferComponent class' category: 'Portfolio-Solucion'!
TransferComponent class
	instanceVariableNames: ''!

!TransferComponent class methodsFor: 'instance creation' stamp: 'DS 11/12/2020 21:30:57'!
for: aTransfer

	^self new initializeFor: aTransfer.! !


!classDefinition: #TransferDeposit category: 'Portfolio-Solucion'!
TransferComponent subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDeposit methodsFor: 'component' stamp: 'DS 11/12/2020 21:29:45'!
transferPair

	^transfer withdrawTransaction.! !


!TransferDeposit methodsFor: 'balance' stamp: 'DS 11/9/2020 21:26:30'!
affectBalance: aBalance

	^aBalance - transfer value.! !


!TransferDeposit methodsFor: 'affect report' stamp: 'DS 11/15/2020 17:40:43'!
affectReport: anAccountReport

	^anAccountReport affectReportForTransferDeposit: self.! !


!classDefinition: #TransferWithdraw category: 'Portfolio-Solucion'!
TransferComponent subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferWithdraw methodsFor: 'component' stamp: 'DS 11/12/2020 21:29:31'!
transferPair

	^transfer depositTransaction.! !


!TransferWithdraw methodsFor: 'balance' stamp: 'DS 11/9/2020 21:26:56'!
affectBalance: aBalance

	^aBalance + transfer value.! !


!TransferWithdraw methodsFor: 'affect report' stamp: 'DS 11/15/2020 17:41:09'!
affectReport: anAccountReport

	^anAccountReport affectReportForTransferWithdraw: self.! !


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


!Withdraw methodsFor: 'affect report' stamp: 'DS 11/15/2020 17:41:37'!
affectReport: anAccountReport

	^anAccountReport affectReportForWithdraw: self.! !

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

!Report methodsFor: 'making' stamp: 'DS 11/15/2020 23:44:40'!
make

	self subclassResponsibility.! !


!Report methodsFor: 'string balance' stamp: 'DS 11/16/2020 00:04:11'!
balanceAsString: anAccount

	^'Balance = ', (anAccount balance asString).! !

!Report methodsFor: 'string balance' stamp: 'DS 11/16/2020 00:04:00'!
balanceOf: anAccount

	^'Balance = ', (anAccount balance asString).! !


!classDefinition: #AccountReport category: 'Portfolio-Solucion'!
Report subclass: #AccountReport
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountReport methodsFor: 'initialization' stamp: 'DS 11/15/2020 17:23:10'!
initializeFor: anAccount

	account := anAccount.! !


!AccountReport methodsFor: 'affect' stamp: 'DS 11/15/2020 17:34:07'!
affectReportForDeposit: aDeposit

	self subclassResponsibility.! !

!AccountReport methodsFor: 'affect' stamp: 'DS 11/15/2020 17:34:12'!
affectReportForTransferDeposit: aTransferDeposit

	self subclassResponsibility.! !

!AccountReport methodsFor: 'affect' stamp: 'DS 11/15/2020 17:34:17'!
affectReportForTransferWithdraw: aTransferWithdraw

	self subclassResponsibility.! !

!AccountReport methodsFor: 'affect' stamp: 'DS 11/15/2020 17:34:24'!
affectReportForWithdraw: aWithdraw

	self subclassResponsibility.! !


!AccountReport methodsFor: 'affect using' stamp: 'DS 11/15/2020 23:47:39'!
affectUsing: aTransaction

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReport class' category: 'Portfolio-Solucion'!
AccountReport class
	instanceVariableNames: ''!

!AccountReport class methodsFor: 'instance creation' stamp: 'DS 11/15/2020 17:24:08'!
for: anAccount

	^self new initializeFor: anAccount.! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
AccountReport subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'affect' stamp: 'DS 11/15/2020 17:37:51'!
affectReportForDeposit: aDeposit

	^'Deposito por ', (aDeposit value asString).! !

!AccountSummary methodsFor: 'affect' stamp: 'DS 11/15/2020 17:38:11'!
affectReportForTransferDeposit: aTransferDeposit

	^'Salida por transferencia de ', (aTransferDeposit value asString ).! !

!AccountSummary methodsFor: 'affect' stamp: 'DS 11/15/2020 17:38:23'!
affectReportForTransferWithdraw: aTransferWithdraw

	^'Entrada por transferencia de ', (aTransferWithdraw value asString)! !

!AccountSummary methodsFor: 'affect' stamp: 'DS 11/15/2020 17:38:33'!
affectReportForWithdraw: aWithdraw

	^'Extraccion por ', (aWithdraw value asString).! !


!AccountSummary methodsFor: 'affect using' stamp: 'DS 11/15/2020 23:55:26'!
affectUsing: aTransaction

	^aTransaction affectReport: self.! !


!AccountSummary methodsFor: 'making' stamp: 'DS 11/16/2020 00:04:35'!
make

	| summary |

	summary := account affectReportUsingTransactions: self.
	summary addLast: (self balanceAsString: account).

	^summary.! !


!classDefinition: #NetOfTrasnferences category: 'Portfolio-Solucion'!
AccountReport subclass: #NetOfTrasnferences
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!NetOfTrasnferences methodsFor: 'affect' stamp: 'DS 11/15/2020 17:38:46'!
affectReportForDeposit: aDeposit

	^0.! !

!NetOfTrasnferences methodsFor: 'affect' stamp: 'DS 11/15/2020 17:38:54'!
affectReportForTransferDeposit: aTransferDeposit

	^aTransferDeposit value negated.! !

!NetOfTrasnferences methodsFor: 'affect' stamp: 'DS 11/15/2020 17:39:01'!
affectReportForTransferWithdraw: aTransferWithdraw

	^aTransferWithdraw value.! !

!NetOfTrasnferences methodsFor: 'affect' stamp: 'DS 11/15/2020 17:39:09'!
affectReportForWithdraw: aWithdraw

	^0.! !


!NetOfTrasnferences methodsFor: 'affect using' stamp: 'FedericoSabatini 11/15/2020 20:18:29'!
affectUsing: aTransaction

    ^aTransaction affectReport: self.! !


!NetOfTrasnferences methodsFor: 'making' stamp: 'DS 11/15/2020 23:53:57'!
make

    ^(account affectReportUsingTransactions: self) sum: [ :aValueTransaction | aValueTransaction ] ifEmpty: [ 0 ].! !


!classDefinition: #PortfolioReport category: 'Portfolio-Solucion'!
Report subclass: #PortfolioReport
	instanceVariableNames: 'portfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioReport methodsFor: 'initialization' stamp: 'DS 11/15/2020 21:20:18'!
initializeFor: aPortfolio

	portfolio := aPortfolio.! !


!PortfolioReport methodsFor: 'affect' stamp: 'DS 11/15/2020 23:49:16'!
affectReportForPortfolio: aPortfolio

	self subclassResponsibility.! !

!PortfolioReport methodsFor: 'affect' stamp: 'DS 11/15/2020 23:49:01'!
affectReportForReceptiveAccount: aReceptiveAccount

	self subclassResponsibility.! !


!PortfolioReport methodsFor: 'tab' stamp: 'DS 11/15/2020 23:58:14'!
tab: aString

	^'    ', aString.! !


!PortfolioReport methodsFor: 'private' stamp: 'DS 11/16/2020 00:12:08'!
makeTreeFor: aPortfolio

	| childrenNames |

	childrenNames := (aPortfolio affectReportUsingAccounts: self) flatten.
	childrenNames addFirst: aPortfolio yourName.
	childrenNames := childrenNames collect: [ :aName | self tab: aName ].	
	
	^childrenNames.! !


!PortfolioReport methodsFor: 'affect using' stamp: 'DS 11/15/2020 23:48:19'!
affectUsing: anAccount

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioReport class' category: 'Portfolio-Solucion'!
PortfolioReport class
	instanceVariableNames: ''!

!PortfolioReport class methodsFor: 'instance creation' stamp: 'DS 11/15/2020 21:20:01'!
for: aPortfolio

	^self new initializeFor: aPortfolio.! !


!classDefinition: #AccountsSummaryTree category: 'Portfolio-Solucion'!
PortfolioReport subclass: #AccountsSummaryTree
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountsSummaryTree methodsFor: 'affect' stamp: 'DS 11/16/2020 00:12:39'!
affectReportForPortfolio: aPortfolio

	| childrenNames |

	childrenNames := self makeTreeFor: aPortfolio.
	childrenNames addLast: (self tab: (self balanceAsString: aPortfolio)).

	^childrenNames.! !

!AccountsSummaryTree methodsFor: 'affect' stamp: 'DS 11/16/2020 00:01:04'!
affectReportForReceptiveAccount: aReceptiveAccount 

	| summary |

	summary := (AccountSummary for: aReceptiveAccount) make.
	summary addFirst: aReceptiveAccount yourName.
	summary := summary collect: [ :aSummaryLine | self tab: aSummaryLine ].

	^summary.! !


!AccountsSummaryTree methodsFor: 'affect using' stamp: 'DS 11/15/2020 23:21:46'!
affectUsing: anAccount

	^anAccount affectReport: self.! !


!AccountsSummaryTree methodsFor: 'making' stamp: 'DS 11/16/2020 00:05:00'!
make
 	| tree |
	tree := (portfolio affectReportUsingAccounts: self) flatten.
	
	tree addFirst: portfolio yourName.
	tree addLast: (self balanceAsString: portfolio).
	^tree! !


!classDefinition: #AccountsTree category: 'Portfolio-Solucion'!
PortfolioReport subclass: #AccountsTree
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountsTree methodsFor: 'affect' stamp: 'DS 11/16/2020 00:12:57'!
affectReportForPortfolio: aPortfolio

	^self makeTreeFor: aPortfolio.! !

!AccountsTree methodsFor: 'affect' stamp: 'DS 11/16/2020 00:06:40'!
affectReportForReceptiveAccount: aReceptiveAccount 

	^self tab: aReceptiveAccount yourName.! !


!AccountsTree methodsFor: 'affect using' stamp: 'DS 11/15/2020 20:54:09'!
affectUsing: anAccount

	^anAccount affectReport: self.! !


!AccountsTree methodsFor: 'making' stamp: 'DS 11/15/2020 23:56:59'!
make

 	| tree |

	tree := (portfolio affectReportUsingAccounts: self) flatten.	
	tree addFirst: portfolio yourName.

	^tree! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value deposit withdraw'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialize' stamp: 'DS 11/15/2020 17:56:55'!
initializeRegister: aValue withDeposit: aDeposit andWithdraw: aWithdraw

	value := aValue.
	deposit := aDeposit.
	withdraw := aWithdraw.! !


!Transfer methodsFor: 'value' stamp: 'DS 11/9/2020 21:00:24'!
value

	^value.! !


!Transfer methodsFor: 'components' stamp: 'DS 11/12/2020 20:29:27'!
depositTransaction

	^deposit.! !

!Transfer methodsFor: 'components' stamp: 'DS 11/12/2020 20:29:40'!
withdrawTransaction

	^withdraw.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'assertions' stamp: 'DS 11/12/2020 21:45:14'!
assertAccount: aFromReceptiveAccount isNotTheSameAccount: aToReceptiveAccount

	^ aFromReceptiveAccount = aToReceptiveAccount ifTrue: [self error: self canNotRegisterATransferToHimselfErrorDescription ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'DS 11/12/2020 21:54:44'!
assertNegativeAmount: aValue

	^ aValue < 0 ifTrue: [self error: self canNotTransferNegativeAmountErrorDescription ]! !

!Transfer class methodsFor: 'instance creation' stamp: 'DS 11/15/2020 18:00:38'!
register: aValue from: aFromReceptiveAccount to: aToReceptiveAccount

	| transfer deposit withdraw |

	self assertAccount: aFromReceptiveAccount isNotTheSameAccount: aToReceptiveAccount.
	self assertNegativeAmount: aValue.

	transfer := self new.	

	deposit := TransferDeposit for: transfer.
	withdraw := TransferWithdraw for: transfer.

	aFromReceptiveAccount register: deposit.
	aToReceptiveAccount register: withdraw.

	^transfer initializeRegister: aValue withDeposit: deposit andWithdraw: withdraw.! !


!Transfer class methodsFor: 'error descriptions' stamp: 'DS 11/12/2020 21:41:46'!
canNotRegisterATransferToHimselfErrorDescription

	^'Can not register a transfer to himself'.! !

!Transfer class methodsFor: 'error descriptions' stamp: 'DS 11/12/2020 21:51:26'!
canNotTransferNegativeAmountErrorDescription

	^'Can not transfer negative amount'! !
