!classDefinition: #AccountSummaryReporterTest category: 'Portfolio'!
TestCase subclass: #AccountSummaryReporterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountSummaryReporterTest methodsFor: 'tests -- portfolio' stamp: 'NNH 11/13/2020 23:37:05'!
test04EmptyPortfolioBalanceShouldOnlyPrintBalance

	| aPortfolio anEmptyPortfolioAccountSummary |
	
	aPortfolio := Portfolio new.
	
	anEmptyPortfolioAccountSummary := (AccountSummaryReporter for: aPortfolio) report.
	
	self assert: (anEmptyPortfolioAccountSummary hasEqualElements: { 'Balance = 0' } )! !

!AccountSummaryReporterTest methodsFor: 'tests -- portfolio' stamp: 'AM 11/13/2020 17:47:55'!
test05AccountSummaryOfPortfolioWithReceptiveAccountsShowsTheirTransactionsAndBalance

	| aPortfolio anAccount anotherAccount expectedAccountSummary aPortfolioAccountSummary |
	
	aPortfolio := Portfolio new.
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	Withdraw register: 50 on: anAccount.
	
	anotherAccount := ReceptiveAccount new.
	Deposit register: 30 on: anotherAccount.
	
	expectedAccountSummary := OrderedCollection with: 'Depósito por 100'
													with: 'Extracción por 50'
													with: 'Depósito por 30'
													with: 'Balance = 80'.
	aPortfolio add: anAccount.
	aPortfolio add: anotherAccount.
		
	aPortfolioAccountSummary := (AccountSummaryReporter for: aPortfolio) report.

	self assert: 'Balance = 80' equals:aPortfolioAccountSummary last.
	self assert: (aPortfolioAccountSummary hasEqualElements: expectedAccountSummary).! !

!AccountSummaryReporterTest methodsFor: 'tests -- portfolio' stamp: 'AM 11/13/2020 17:48:06'!
test06PortfolioAccountSummaryIsCalculatedRecursively

	| aPortfolio anAccount anotherAccount expectedAccountSummary anotherPortfolio aPortfolioAccountSummary |
	
	aPortfolio := Portfolio new.
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	Withdraw register: 50 on: anAccount.
	
	anotherAccount := ReceptiveAccount new.
	Deposit register: 30 on: anotherAccount.
	
	anotherPortfolio := Portfolio new.
	anotherPortfolio add: anAccount.
	anotherPortfolio add: anotherAccount.
	
	aPortfolio add: anotherPortfolio.
	
	expectedAccountSummary := OrderedCollection with: 'Depósito por 100'
													with: 'Extracción por 50'
													with: 'Depósito por 30'
													with: 'Balance = 80'.
	
	aPortfolioAccountSummary := (AccountSummaryReporter for: aPortfolio) report.


	self assert: 'Balance = 80' equals:  aPortfolioAccountSummary last.
	self assert: (aPortfolioAccountSummary hasEqualElements: expectedAccountSummary).! !


!AccountSummaryReporterTest methodsFor: 'tests -- receptive account' stamp: 'NNH 11/13/2020 23:31:13'!
test01EmptyAccountSummaryShouldOnlyPrintBalance

	| anEmptyAccount anEmptyAccountSummaryAccount |
	
	anEmptyAccount := ReceptiveAccount new.
	
	anEmptyAccountSummaryAccount := (AccountSummaryReporter for: anEmptyAccount) report.
	
	self assert: anEmptyAccountSummaryAccount size equals: 1.
	self assert: anEmptyAccountSummaryAccount includes: 'Balance = 0'.! !

!AccountSummaryReporterTest methodsFor: 'tests -- receptive account' stamp: 'NNH 11/13/2020 23:37:46'!
test02AReceptiveAccountWithOneTransactionShowsItInSummary

	| anAccount expectedAccountSummary anAccountSummaryAccount |
	
	anAccount := ReceptiveAccount new.
	
	Deposit register: 10  on: anAccount.
	
	expectedAccountSummary := OrderedCollection with: 'Depósito por 10' with:  'Balance = 10'.
	anAccountSummaryAccount :=  (AccountSummaryReporter for: anAccount) report.
	
	self assert: expectedAccountSummary equals: anAccountSummaryAccount.! !

!AccountSummaryReporterTest methodsFor: 'tests -- receptive account' stamp: 'NNH 11/13/2020 23:38:18'!
test03AReceptiveAccountWithMoreThanOneTransactionShowsThemInAccountSummary

	| anAccount expectedAccountSummary anotherAccount anAccountSummaryAccount |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Deposit register: 10  on: anAccount.
	Withdraw register: 40  on: anAccount.
	Transfer from: anAccount to: anotherAccount for: 100.
	Transfer from: anotherAccount to: anAccount for: 50.
	
	expectedAccountSummary := OrderedCollection with: 'Depósito por 10'
												with: 'Extracción por 40'
												with: 'Salida por transferencia de 100'
												with: 'Entrada por transferencia de 50'
												with: 'Balance = -80'.
												
	anAccountSummaryAccount := (AccountSummaryReporter for: anAccount) report.
												
	self assert: (anAccountSummaryAccount hasEqualElements: expectedAccountSummary).
	self assert: anAccountSummaryAccount last equals: 'Balance = -80'.
	! !


!classDefinition: #DetailedTreeStructureReporterTest category: 'Portfolio'!
TestCase subclass: #DetailedTreeStructureReporterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!DetailedTreeStructureReporterTest methodsFor: 'tests -- portfolio' stamp: 'NNH 11/13/2020 23:44:39'!
test03DetailedReportOnEmptyPortfolioShowsNameAndBalance

	| anEmptyPortfolio portfolioDetailedTreeStructure |
	
	anEmptyPortfolio := Portfolio named: 'Cuenta de Hernán'.
	
	portfolioDetailedTreeStructure := ( DetailedTreeStructureReporter for: anEmptyPortfolio ) report.
	
	self assert: (portfolioDetailedTreeStructure hasEqualElements: { 'Cuenta de Hernán'. '\tBalance = 0' }).
	self assert: portfolioDetailedTreeStructure first equals: 'Cuenta de Hernán'.! !

!DetailedTreeStructureReporterTest methodsFor: 'tests -- portfolio' stamp: 'NNH 11/13/2020 23:45:06'!
test04DetailedReportOnPortoflioWithReceptiveAccountsShowsTheirNamesAndBalances

	| pepitoPortfolio pepeReceptiveAccount pepoteReceptiveAccount pepitoPortfolioTreeStructure expectedPortfolioTreeStructure |
	
	pepitoPortfolio := Portfolio named: 'Portfolio de Hernán'.
	
	pepeReceptiveAccount := ReceptiveAccount named: 'Cuenta de Agustín'.
	pepoteReceptiveAccount := ReceptiveAccount named: 'Cuenta de Nahuel'.
	
	pepitoPortfolio add: pepeReceptiveAccount.
	pepitoPortfolio add: pepoteReceptiveAccount.
	
	pepitoPortfolioTreeStructure :=  (DetailedTreeStructureReporter for: pepitoPortfolio) report.
	expectedPortfolioTreeStructure := OrderedCollection with: 'Portfolio de Hernán' with: '\tCuenta de Agustín' with: '\t\tBalance = 0' with: '\tCuenta de Nahuel' with: '\t\tBalance = 0' with: '\tBalance = 0'.

	self assert:  pepitoPortfolioTreeStructure equals: expectedPortfolioTreeStructure.! !

!DetailedTreeStructureReporterTest methodsFor: 'tests -- portfolio' stamp: 'AM 11/13/2020 21:01:18'!
test05DetailedReportIsRecursiveOnPortfolio

	| agustinPortfolioTreeStructure agustinPortfolio hernanReceptiveAccount nahuelPortfolio expectedPortfolioTreeStructure |
	
	agustinPortfolio := Portfolio named: 'Portfolio de Agustin'.
	nahuelPortfolio := Portfolio named: 'Portfolio de Nahuel'.
	
	hernanReceptiveAccount := ReceptiveAccount named: 'Cuenta de Hernan'.
	
	Deposit register: 100 on: hernanReceptiveAccount.
	
	agustinPortfolio add: nahuelPortfolio.
	nahuelPortfolio add: hernanReceptiveAccount.
	
	agustinPortfolioTreeStructure :=  (DetailedTreeStructureReporter for: agustinPortfolio) report.
	
	expectedPortfolioTreeStructure := OrderedCollection with: 'Portfolio de Agustin' with:  '\tPortfolio de Nahuel' with: '\t\tCuenta de Hernan' with: '\t\t\tDepósito por 100' with: '\t\t\tBalance = 100' with: '\t\tBalance = 100'.
	expectedPortfolioTreeStructure add: '\tBalance = 100'.
	self assert:  agustinPortfolioTreeStructure equals: expectedPortfolioTreeStructure.! !

!DetailedTreeStructureReporterTest methodsFor: 'tests -- portfolio' stamp: 'AM 11/16/2020 00:10:38'!
test07UnnamedPortfolioShowsDefaultName

	| portfolio portfolioTreeStructure |
	
	portfolio := Portfolio new.
	
	portfolioTreeStructure :=  (DetailedTreeStructureReporter for: portfolio) report.

	self assert:  (portfolioTreeStructure hasEqualElements: { 'Portfolio sin nombre'. '\tBalance = 0'}).! !


!DetailedTreeStructureReporterTest methodsFor: 'tests -- receptive account' stamp: 'NNH 11/13/2020 23:43:50'!
test01DetailedReportShowsNameAndBalanceOnEmptyReceptiveAccount

	| aReceptiveAccount aReceptiveAccountTreeStructure |
	
	aReceptiveAccount := ReceptiveAccount named: 'Cuenta Hernán'.
	
	aReceptiveAccountTreeStructure :=  (DetailedTreeStructureReporter for: aReceptiveAccount) report.
	
	self assert: (aReceptiveAccountTreeStructure hasEqualElements: {'Cuenta Hernán'. '\tBalance = 0'}).
	self assert: aReceptiveAccountTreeStructure first equals: 'Cuenta Hernán'.! !

!DetailedTreeStructureReporterTest methodsFor: 'tests -- receptive account' stamp: 'NNH 11/13/2020 23:45:58'!
test02DetailedReportShowsEveryTransactionOnReceptiveAccount

	| aReceptiveAccount aReceptiveAccountTreeStructure anotherReceptiveAccount expectedAccountTreeStructure |
	
	aReceptiveAccount := ReceptiveAccount named: 'Cuenta Hernán'.
	anotherReceptiveAccount := ReceptiveAccount named: 'Cuenta Pepe Botellas'.
	
	Deposit register: 100 on: aReceptiveAccount.
	Withdraw register: 50 on: aReceptiveAccount.
	Transfer from: aReceptiveAccount to: anotherReceptiveAccount for: 100.
	Transfer from: anotherReceptiveAccount to: aReceptiveAccount for: 100.
	
	aReceptiveAccountTreeStructure :=  (DetailedTreeStructureReporter for: aReceptiveAccount) report.
	expectedAccountTreeStructure := OrderedCollection 				with: 'Cuenta Hernán' with: '\tDepósito por 100' with: '\tExtracción por 50' with: '\tSalida por transferencia de 100' with: '\tEntrada por transferencia de 100'  with: '\tBalance = 50'.
	
	self assert: (aReceptiveAccountTreeStructure hasEqualElements: expectedAccountTreeStructure).
	self assert: aReceptiveAccountTreeStructure first equals: expectedAccountTreeStructure first.
	self assert: aReceptiveAccountTreeStructure last equals: expectedAccountTreeStructure last.! !

!DetailedTreeStructureReporterTest methodsFor: 'tests -- receptive account' stamp: 'AM 11/16/2020 00:11:43'!
test06UnnamedReceptiveAccountShowsDefaultName

	| receptiveAccount receptiveAccountTreeStructure |
	
	receptiveAccount := ReceptiveAccount new.
	
	receptiveAccountTreeStructure :=  (DetailedTreeStructureReporter for: receptiveAccount) report.

	self assert:  (receptiveAccountTreeStructure hasEqualElements: { 'Cuenta corriente sin nombre'. '\tBalance = 0'}).! !


!classDefinition: #NetTransferReporterTest category: 'Portfolio'!
TestCase subclass: #NetTransferReporterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!NetTransferReporterTest methodsFor: 'tests -- portfolio' stamp: 'AM 11/13/2020 17:53:15'!
test04NetTransferOfEmptyPortfolioIsZero

	| anEmptyPortfolio emptyPortfolioNetTransfer |
	
	anEmptyPortfolio := Portfolio new.
	
	emptyPortfolioNetTransfer :=  (NetTransferReporter for: anEmptyPortfolio) report.

	self assert:  emptyPortfolioNetTransfer equals: 0.! !

!NetTransferReporterTest methodsFor: 'tests -- portfolio' stamp: 'NNH 11/13/2020 23:41:04'!
test05NetTransferOfComposedPortfolioIsSumOfNetTransfers

	| aPortfolio anAccount anotherAccount aPortfolioNetTransfer |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	Transfer from: anAccount to: anotherAccount for: 100.
	
	aPortfolio := Portfolio with: anAccount.
	
	aPortfolioNetTransfer :=  (NetTransferReporter for: aPortfolio) report.

	
	self assert: aPortfolioNetTransfer equals: -100.! !

!NetTransferReporterTest methodsFor: 'tests -- portfolio' stamp: 'AM 11/13/2020 17:53:27'!
test06NetTransferIsCalculatedRecursivelyInAPortfolio

	| aPortfolio anAccount anotherAccount aPortfolioNetTransfer |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	Transfer from: anAccount to: anotherAccount for: 100.
	
	aPortfolio := Portfolio with: anAccount with: anotherAccount.
	
	aPortfolioNetTransfer :=  (NetTransferReporter for: aPortfolio) report.
	
	self assert: aPortfolioNetTransfer equals: 0.! !


!NetTransferReporterTest methodsFor: 'tests -- receptive account' stamp: 'AM 11/13/2020 17:51:52'!
test01AnEmptyReceptiveAccountHasZeroNetTransfer

	| anEmptyAccount emptyAccountNetTransfer |
	
	anEmptyAccount := ReceptiveAccount new.
	
	emptyAccountNetTransfer :=  (NetTransferReporter for: anEmptyAccount) report.
	
	self assert: emptyAccountNetTransfer equals: 0.! !

!NetTransferReporterTest methodsFor: 'tests -- receptive account' stamp: 'NNH 11/13/2020 23:41:37'!
test02NetTransferIsAffectedCorrectlyInReceptiveAccount

	| anAccount anotherAccount anAccountNetTransferReport anotherAccountNetTransferReport |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Transfer from: anAccount to: anotherAccount for: 500.
	anAccountNetTransferReport := (NetTransferReporter for: anAccount) report.
	anotherAccountNetTransferReport := (NetTransferReporter for: anotherAccount) report.
	
	self assert: anAccountNetTransferReport equals: -500.
	self assert: anotherAccountNetTransferReport equals: 500.! !

!NetTransferReporterTest methodsFor: 'tests -- receptive account' stamp: 'NNH 11/13/2020 23:40:09'!
test03NetTransferIsOnlyAffectedByTransfersInReceptiveAccount

	| anAccount anotherAccount anAccountNetTransferReport |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Transfer from: anotherAccount to: anAccount for: 500.
	Deposit register: 50 on: anAccount.
	Withdraw register: 20 on: anAccount.
	
	anAccountNetTransferReport := (NetTransferReporter for: anAccount) report.
	
	self assert: anAccountNetTransferReport equals: 500.
	! !


!classDefinition: #PortfolioTest category: 'Portfolio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

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

!PortfolioTest methodsFor: 'tests' stamp: 'NNH 11/15/2020 23:19:41'!
test16NamedPortfolioShouldKnowItsName
	
	| portfolio |
	
	portfolio := Portfolio named: 'Portfolio de Hernán'.
	
	self assert: portfolio accountName equals: 'Portfolio de Hernán'.
	self assert: portfolio isNamed.! !

!PortfolioTest methodsFor: 'tests' stamp: 'AM 11/16/2020 00:15:30'!
test17UnnamedPortfolioShouldNotBeNamedAndSignalNoName
	
	| portfolio |
	
	portfolio := Portfolio new.
	
	self deny: portfolio isNamed.

	self should: [portfolio accountName]  
		raise: Error
		withMessageText: Portfolio canNotRetrieveNameOfUnnamedPortfolioErrorDescription
	! !


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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NNH 11/15/2020 23:07:55'!
test15NamedReceptiveAccountShouldKnowItsName
	
	| aReceptiveAccount |
	
	aReceptiveAccount := ReceptiveAccount named: 'Cuenta de Hernán'.
	
	self assert: aReceptiveAccount accountName equals: 'Cuenta de Hernán'.
	self assert: aReceptiveAccount isNamed.
	
	
	
		! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AM 11/16/2020 00:36:10'!
test16UnnamedReceptiveAccountShouldNotBeNamedAndSignalNoName
	
	| aReceptiveAccount |
	
	aReceptiveAccount := ReceptiveAccount new.
	
	self deny: aReceptiveAccount isNamed.

	self should: [aReceptiveAccount accountName]  
		raise: Error
		withMessageText: ReceptiveAccount canNotRetrieveNameOfUnnamedReceptiveAccountErrorDescription.
	
	
	
		! !


!ReceptiveAccountTest methodsFor: 'tests - transfers' stamp: 'AM 11/10/2020 22:53:39'!
test08BalanceShouldBeDecreasedOnTransferSendingAccount
	
	| aReceivingAccount aSendingAccount |
	
	aSendingAccount := ReceptiveAccount new.
	aReceivingAccount := ReceptiveAccount new.
	
	Transfer from: aSendingAccount to: aReceivingAccount for: 100.
	
	self assert: aSendingAccount 	balance equals: -100.
! !

!ReceptiveAccountTest methodsFor: 'tests - transfers' stamp: 'AM 11/10/2020 22:54:26'!
test09BalanceShouldBeIncreasedOnTransferReceivingAccount
	
	| aReceivingAccount aSendingAccount |
	
	aSendingAccount := ReceptiveAccount new.
	aReceivingAccount := ReceptiveAccount new.
	
	Transfer from: aSendingAccount to: aReceivingAccount for: 100.
	
	self assert: aReceivingAccount 	balance equals: 100.
! !

!ReceptiveAccountTest methodsFor: 'tests - transfers' stamp: 'AM 11/10/2020 22:54:59'!
test10BalanceOfAnAccountIsAffectedBySendingAndReceivingTransfers
	
	| aReceivingAccount aSendingAccount |
	
	aSendingAccount := ReceptiveAccount new.
	aReceivingAccount := ReceptiveAccount new.
	
	Transfer from: aSendingAccount to: aReceivingAccount for: 100.
	Transfer from: aReceivingAccount to: aSendingAccount for: 50.
	
	self assert: aSendingAccount 	balance equals: -50.
! !

!ReceptiveAccountTest methodsFor: 'tests - transfers' stamp: 'NNH 11/13/2020 23:33:41'!
test11AccountsRegisterTransfersOnlyWhenAffected
	
	| aReceivingAccount aSendingAccount transfer |
	
	aSendingAccount := ReceptiveAccount new.
	aReceivingAccount := ReceptiveAccount new.
	
	transfer := Transfer from: aSendingAccount to: aReceivingAccount for: 100.
	
	self assert: (aReceivingAccount 	hasRegistered: transfer sending).
	self deny:   (aSendingAccount   	hasRegistered: transfer sending).
	
	self assert: (aSendingAccount 	  hasRegistered: transfer receiving).
	self deny:   (aReceivingAccount 	hasRegistered: transfer receiving).! !

!ReceptiveAccountTest methodsFor: 'tests - transfers' stamp: 'AM 11/12/2020 21:39:28'!
test12TransferComponentsKnowTheirTransfer
	
	| aReceivingAccount aSendingAccount transfer deposit withdrawal |
	
	aSendingAccount := ReceptiveAccount new.
	aReceivingAccount := ReceptiveAccount new.
	
	transfer := Transfer from: aSendingAccount to: aReceivingAccount for: 100.
	
	deposit := transfer sending.
	withdrawal := transfer receiving .
	
	self assert: deposit transfer equals: transfer.
	self assert: withdrawal transfer equals: transfer.! !

!ReceptiveAccountTest methodsFor: 'tests - transfers' stamp: 'AM 11/10/2020 22:59:13'!
test13AnAccountShouldNotTransferToItself
	
	| anAccount |
	
	anAccount := ReceptiveAccount new.
	
	self should: [ Transfer from: anAccount to: anAccount for: 100 ]
		raise: Error
		withMessageText: Transfer canNotTransferFromAnAccountToItselfErrorDescription.
		! !

!ReceptiveAccountTest methodsFor: 'tests - transfers' stamp: 'NNH 11/13/2020 23:34:49'!
test14TransferValueMustBePositive
	
	| aReceivingAccount aSendingAccount |
	
	aSendingAccount := ReceptiveAccount new.
	aReceivingAccount := ReceptiveAccount new.
	
	self should: [ Transfer from: aSendingAccount to: aReceivingAccount for: 0 ]
		raise: Error
		withMessageText: Transfer canNotTransferNonPositiveAmountErrorDescription.
		! !


!classDefinition: #SimpleTreeStructureReporterTest category: 'Portfolio'!
TestCase subclass: #SimpleTreeStructureReporterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!SimpleTreeStructureReporterTest methodsFor: 'tests -- portfolio' stamp: 'NNH 11/13/2020 23:47:01'!
test02TreeStructureOfEmptyPortfolioOnlyShowsItsName

	| anEmptyPortfolio emptyPortfolioTreeStructure |
	
	anEmptyPortfolio := Portfolio named: 'Portfolio de Hernán'.
	
	emptyPortfolioTreeStructure :=  (SimpleTreeStructureReporter for: anEmptyPortfolio) report.

	self assert:  (emptyPortfolioTreeStructure hasEqualElements: { 'Portfolio de Hernán' } ).! !

!SimpleTreeStructureReporterTest methodsFor: 'tests -- portfolio' stamp: 'NNH 11/13/2020 23:43:17'!
test03APortfolioWithReceptiveAccountsShowsTreeStructure

	| pepitoPortfolio pepeReceptiveAccount pepoteReceptiveAccount pepitoPortfolioTreeStructure |
	
	pepitoPortfolio := Portfolio named: 'Portfolio de Hernán'.
	
	pepeReceptiveAccount := ReceptiveAccount named: 'Cuenta de Agustín'.
	pepoteReceptiveAccount := ReceptiveAccount named: 'Cuenta de Nahuel'.
	
	pepitoPortfolio add: pepeReceptiveAccount.
	pepitoPortfolio add: pepoteReceptiveAccount.
	
	pepitoPortfolioTreeStructure :=  (SimpleTreeStructureReporter for: pepitoPortfolio) report.

	self assert:  (pepitoPortfolioTreeStructure hasEqualElements: { 'Portfolio de Hernán'. '\tCuenta de Agustín'. '\tCuenta de Nahuel'}).
	self assert:   pepitoPortfolioTreeStructure first equals: 'Portfolio de Hernán'.! !

!SimpleTreeStructureReporterTest methodsFor: 'tests -- portfolio' stamp: 'AM 11/13/2020 20:56:49'!
test04TreeStructureIsCalculatedRecursivelyInPortfolio

	| agustinPortfolioTreeStructure agustinPortfolio hernanReceptiveAccount nahuelPortfolio |
	
	agustinPortfolio := Portfolio named: 'Portfolio de Agustin'.
	nahuelPortfolio := Portfolio named: 'Portfolio de Nahuel'.
	
	hernanReceptiveAccount := ReceptiveAccount named: 'Cuenta de Hernan'.
	
	agustinPortfolio add: nahuelPortfolio.
	nahuelPortfolio add: hernanReceptiveAccount.
	
	agustinPortfolioTreeStructure :=  (SimpleTreeStructureReporter for: agustinPortfolio) report.

	self assert:  (agustinPortfolioTreeStructure hasEqualElements: { 'Portfolio de Agustin'. '\tPortfolio de Nahuel'. '\t\tCuenta de Hernan'}).
	self assert:   agustinPortfolioTreeStructure first equals: 'Portfolio de Agustin'.
	self assert:   agustinPortfolioTreeStructure last equals: '\t\tCuenta de Hernan'.! !

!SimpleTreeStructureReporterTest methodsFor: 'tests -- portfolio' stamp: 'AM 11/16/2020 00:07:09'!
test06UnnamedPortfolioShowsDefaultName

	| portfolio portfolioTreeStructure |
	
	portfolio := Portfolio new.
	
	portfolioTreeStructure :=  (SimpleTreeStructureReporter for: portfolio) report.

	self assert:  (portfolioTreeStructure hasEqualElements: { 'Portfolio sin nombre'}).! !


!SimpleTreeStructureReporterTest methodsFor: 'tests -- receptive account' stamp: 'NNH 11/13/2020 23:46:53'!
test01AReceptiveAccountShowsItselfOnTreeStructure

	| aReceptiveAccount aReceptiveAccountTreeStructure |
	
	aReceptiveAccount := ReceptiveAccount named: 'Cuenta Hernán'.
	
	aReceptiveAccountTreeStructure :=  (SimpleTreeStructureReporter for: aReceptiveAccount) report.
	
	self assert: (aReceptiveAccountTreeStructure hasEqualElements: {'Cuenta Hernán'}).! !

!SimpleTreeStructureReporterTest methodsFor: 'tests -- receptive account' stamp: 'AM 11/16/2020 00:07:51'!
test05UnnamedReceptiveAccountShowsDefaultName

	| receptiveAccount receptiveAccountTreeStructure |
	
	receptiveAccount := ReceptiveAccount new.
	
	receptiveAccountTreeStructure :=  (SimpleTreeStructureReporter for: receptiveAccount) report.

	self assert:  (receptiveAccountTreeStructure hasEqualElements: { 'Cuenta corriente sin nombre'}).! !


!classDefinition: #Account category: 'Portfolio'!
Object subclass: #Account
	instanceVariableNames: 'accountName isNamed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Account methodsFor: 'accessing' stamp: 'AM 11/16/2020 14:53:10'!
accountName
	
	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'reports' stamp: 'AM 11/12/2020 21:45:08'!
report: aReporter

	self subclassResponsibility.! !


!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'Portfolio'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'instance creations' stamp: 'AM 11/12/2020 22:55:51'!
named: anAccountName 
	
	^ self new initializeNamed: anAccountName! !


!classDefinition: #Portfolio category: 'Portfolio'!
Account subclass: #Portfolio
	instanceVariableNames: 'parents accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Portfolio methodsFor: 'accessing' stamp: 'NNH 11/16/2020 12:47:41'!
accountName

	isNamed ifFalse: [self signalCanNotRetrieveNameOfUnnamedPortfolio ].
	^ accountName! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !


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


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'initialization' stamp: 'NNH 11/16/2020 12:45:29'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	isNamed := false.! !

!Portfolio methodsFor: 'initialization' stamp: 'NNH 11/16/2020 12:45:38'!
initializeNamed: anAccountName 
	
	accountName := anAccountName.
	isNamed := true.! !


!Portfolio methodsFor: 'iterating' stamp: 'AM 11/13/2020 20:36:41'!
onAccountsDo: aBlockToExecuteOnAccounts

	accounts do: aBlockToExecuteOnAccounts ! !


!Portfolio methodsFor: 'reports' stamp: 'AM 11/12/2020 21:45:17'!
report: aReporter

	aReporter reportPortfolio: self.! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'testing' stamp: 'NNH 11/16/2020 12:45:55'!
isNamed
	^ isNamed.! !


!Portfolio methodsFor: 'signaling' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

!Portfolio methodsFor: 'signaling' stamp: 'NNH 11/16/2020 12:47:41'!
signalCanNotRetrieveNameOfUnnamedPortfolio

	^ self error: self class canNotRetrieveNameOfUnnamedPortfolioErrorDescription! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'NR 11/9/2020 06:01:26'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio!!'! !

!Portfolio class methodsFor: 'error descriptions' stamp: 'NNH 11/15/2020 23:22:25'!
canNotRetrieveNameOfUnnamedPortfolioErrorDescription
	^ 'Can not retrieve name of unnamed portfolio'.! !


!Portfolio class methodsFor: 'instance creations' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creations' stamp: 'HAW 5/25/2019 11:23:59'!
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

!ReceptiveAccount methodsFor: 'accessing' stamp: 'NNH 11/16/2020 12:49:00'!
accountName

	isNamed ifFalse: [self signalCanNotRetrieveNameOfUnnamedReceptiveAccount ].
	^ accountName! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'AM 11/10/2020 10:46:31'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ].! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'initialization' stamp: 'NNH 11/16/2020 12:44:51'!
initialize

	transactions := OrderedCollection new.
	isNamed := false.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NNH 11/16/2020 12:45:00'!
initializeNamed: aReceptiveAccountName 
	
	accountName := aReceptiveAccountName.
	isNamed := true.! !


!ReceptiveAccount methodsFor: 'iterating' stamp: 'AM 11/13/2020 20:41:16'!
onTransactionsDo: aBlockToExecuteOnTransactions

	transactions do: aBlockToExecuteOnTransactions! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'AM 11/12/2020 21:45:28'!
report: aReporter

	aReporter reportReceptiveAccount: self.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'AM 11/10/2020 10:46:38'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'NNH 11/16/2020 12:45:10'!
isNamed
	
	^ isNamed.! !


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


!ReceptiveAccount methodsFor: 'signaling' stamp: 'NNH 11/16/2020 12:49:00'!
signalCanNotRetrieveNameOfUnnamedReceptiveAccount

	^ self error: self class canNotRetrieveNameOfUnnamedReceptiveAccountErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'error descriptions' stamp: 'AM 11/16/2020 00:32:33'!
canNotRetrieveNameOfUnnamedReceptiveAccountErrorDescription

	^ 'Cannot retrieve name of unnamed receptive account'! !


!classDefinition: #AccountTransaction category: 'Portfolio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'reports' stamp: 'AM 11/12/2020 21:45:42'!
report: aReporter

	self subclassResponsibility 
	
	! !


!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'reports' stamp: 'AM 11/12/2020 21:45:48'!
report: aReporter

	aReporter reportDeposit: self.! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferComponent category: 'Portfolio'!
AccountTransaction subclass: #TransferComponent
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!TransferComponent methodsFor: 'accessing' stamp: 'AM 11/10/2020 22:26:46'!
transfer
	^ transfer! !

!TransferComponent methodsFor: 'accessing' stamp: 'AM 11/10/2020 23:45:29'!
value
	^ transfer value! !


!TransferComponent methodsFor: 'initializing' stamp: 'AM 11/16/2020 00:30:55'!
initializeFor: aTransfer on: aReceptiveAccount 
	
	aReceptiveAccount register: self.
	transfer := aTransfer.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferComponent class' category: 'Portfolio'!
TransferComponent class
	instanceVariableNames: ''!

!TransferComponent class methodsFor: 'instance creation' stamp: 'NNH 11/13/2020 22:50:25'!
for: aTransfer on: aReceptiveAccount 
	
	^self new initializeFor: aTransfer on: aReceptiveAccount ! !


!classDefinition: #ReceivingTransferComponent category: 'Portfolio'!
TransferComponent subclass: #ReceivingTransferComponent
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!ReceivingTransferComponent methodsFor: 'balance' stamp: 'AM 11/10/2020 10:52:43'!
affectBalance: aBalance 
	
	^aBalance + (transfer value)! !


!ReceivingTransferComponent methodsFor: 'reports' stamp: 'AM 11/12/2020 21:46:01'!
report: aReporter
	
	aReporter reportReceivingTransferComponent: self.! !


!classDefinition: #SendingTransferComponent category: 'Portfolio'!
TransferComponent subclass: #SendingTransferComponent
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!SendingTransferComponent methodsFor: 'balance' stamp: 'AM 11/10/2020 10:52:51'!
affectBalance: aBalance
	
	^aBalance - (transfer value) 
	! !


!SendingTransferComponent methodsFor: 'reports' stamp: 'AM 11/12/2020 21:46:09'!
report: aReporter

	aReporter reportSendingTransferComponent: self.! !


!classDefinition: #Withdraw category: 'Portfolio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'reports' stamp: 'AM 11/12/2020 21:46:16'!
report: aReporter

	aReporter reportWithdraw: self.! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Reporter category: 'Portfolio'!
Object subclass: #Reporter
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Reporter methodsFor: 'formatting -- private' stamp: 'NNH 11/13/2020 22:57:48'!
formatBalance: anAccountOrTransaction

	^ 'Balance = ', anAccountOrTransaction balance asString.! !

!Reporter methodsFor: 'formatting -- private' stamp: 'AM 11/13/2020 21:13:35'!
formatDeposit: aDeposit

	^ 'Depósito por ', aDeposit value asString. ! !

!Reporter methodsFor: 'formatting -- private' stamp: 'NNH 11/13/2020 22:42:34'!
formatReceivingTransferComponent: aReceivingTransferComponent

	^ 'Entrada por transferencia de ', aReceivingTransferComponent value asString.! !

!Reporter methodsFor: 'formatting -- private' stamp: 'AM 11/13/2020 21:16:00'!
formatSendingTransferComponent: aSendingTransferComponent

	^ 'Salida por transferencia de ', aSendingTransferComponent value asString.! !

!Reporter methodsFor: 'formatting -- private' stamp: 'AM 11/13/2020 21:14:59'!
formatWithdraw: aWithdraw

	^ 'Extracción por ', aWithdraw value asString.! !


!Reporter methodsFor: 'initializing' stamp: 'AM 11/12/2020 20:58:38'!
initializeFor: anAccount
	
	account := anAccount! !


!Reporter methodsFor: 'reporting' stamp: 'AM 11/12/2020 21:19:41'!
report

	self subclassResponsibility ! !


!Reporter methodsFor: 'reporting -- private' stamp: 'NNH 11/13/2020 23:19:22'!
reportAccountsRecursively: aPortfolio	
	
	aPortfolio onAccountsDo: [:anAccount | anAccount report: self] .! !

!Reporter methodsFor: 'reporting -- private' stamp: 'AM 11/12/2020 00:28:31'!
reportDeposit: aDeposit

	self subclassResponsibility! !

!Reporter methodsFor: 'reporting -- private' stamp: 'AM 11/12/2020 00:28:45'!
reportPortfolio: aPortfolio

	self subclassResponsibility! !

!Reporter methodsFor: 'reporting -- private' stamp: 'AM 11/12/2020 00:28:55'!
reportReceivingTransferComponent: aReceivingTransferComponent

	self subclassResponsibility! !

!Reporter methodsFor: 'reporting -- private' stamp: 'AM 11/12/2020 00:29:04'!
reportReceptiveAccount: aReceptiveAccount

	self subclassResponsibility! !

!Reporter methodsFor: 'reporting -- private' stamp: 'AM 11/12/2020 00:29:13'!
reportSendingTransferComponent: aSendingTransferComponent

	self subclassResponsibility! !

!Reporter methodsFor: 'reporting -- private' stamp: 'NNH 11/13/2020 23:19:49'!
reportTransactionsRecursively: aReceptiveAccount
	
	aReceptiveAccount onTransactionsDo: [:aTransaction | aTransaction report: self].! !

!Reporter methodsFor: 'reporting -- private' stamp: 'AM 11/12/2020 00:29:22'!
reportWithdraw: aWithdraw

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Reporter class' category: 'Portfolio'!
Reporter class
	instanceVariableNames: ''!

!Reporter class methodsFor: 'instance creation' stamp: 'AM 11/12/2020 20:58:17'!
for: anAccount

	^ self new initializeFor: anAccount! !


!classDefinition: #AccountSummaryReporter category: 'Portfolio'!
Reporter subclass: #AccountSummaryReporter
	instanceVariableNames: 'accountSummary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!AccountSummaryReporter methodsFor: 'reporting' stamp: 'NNH 11/13/2020 22:56:07'!
report

	accountSummary := OrderedCollection new.
	
	account report: self.
	accountSummary add: (self formatBalance: account).
	
	^ accountSummary.! !


!AccountSummaryReporter methodsFor: 'reporting -- private' stamp: 'AM 11/13/2020 21:17:38'!
reportDeposit: aDeposit
	
	accountSummary add: (self formatDeposit: aDeposit)
	
	! !

!AccountSummaryReporter methodsFor: 'reporting -- private' stamp: 'NNH 11/13/2020 23:20:18'!
reportPortfolio: aPortfolio

	self reportAccountsRecursively: aPortfolio.
	
	! !

!AccountSummaryReporter methodsFor: 'reporting -- private' stamp: 'AM 11/13/2020 21:17:56'!
reportReceivingTransferComponent: aReceivingTransferComponent
 
	accountSummary add: (self formatReceivingTransferComponent: aReceivingTransferComponent)
	
	! !

!AccountSummaryReporter methodsFor: 'reporting -- private' stamp: 'NNH 11/13/2020 23:22:32'!
reportReceptiveAccount: aReceptiveAccount
	
	self reportTransactionsRecursively: aReceptiveAccount.
	
	! !

!AccountSummaryReporter methodsFor: 'reporting -- private' stamp: 'AM 11/13/2020 21:18:09'!
reportSendingTransferComponent: aSendingTransferComponent
 
	accountSummary add: (self formatSendingTransferComponent: aSendingTransferComponent)
	
	! !

!AccountSummaryReporter methodsFor: 'reporting -- private' stamp: 'AM 11/13/2020 21:18:24'!
reportWithdraw: aWithdraw

	accountSummary add: (self formatWithdraw: aWithdraw)
	
	
	! !


!classDefinition: #NetTransferReporter category: 'Portfolio'!
Reporter subclass: #NetTransferReporter
	instanceVariableNames: 'netTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!NetTransferReporter methodsFor: 'reporting' stamp: 'AM 11/12/2020 21:19:29'!
report

	netTransfer := 0.
	account report: self. 
	
	^ netTransfer
	
	! !


!NetTransferReporter methodsFor: 'reporting -- private' stamp: 'AM 11/12/2020 00:28:32'!
reportDeposit: aDeposit ! !

!NetTransferReporter methodsFor: 'reporting -- private' stamp: 'NNH 11/13/2020 23:20:36'!
reportPortfolio: aPortfolio 
	
	self reportAccountsRecursively: aPortfolio.
! !

!NetTransferReporter methodsFor: 'reporting -- private' stamp: 'AM 11/12/2020 00:28:54'!
reportReceivingTransferComponent: aReceivingTransferComponent 
	
	netTransfer := netTransfer + aReceivingTransferComponent value! !

!NetTransferReporter methodsFor: 'reporting -- private' stamp: 'NNH 11/13/2020 23:22:39'!
reportReceptiveAccount: aReceptiveAccount 
	
	self reportTransactionsRecursively: aReceptiveAccount.
! !

!NetTransferReporter methodsFor: 'reporting -- private' stamp: 'AM 11/12/2020 00:29:13'!
reportSendingTransferComponent: aSendingTransferComponent 
	
	netTransfer := netTransfer - aSendingTransferComponent value! !

!NetTransferReporter methodsFor: 'reporting -- private' stamp: 'AM 11/12/2020 00:29:22'!
reportWithdraw: aWithdraw ! !


!classDefinition: #TreeStructureReporter category: 'Portfolio'!
Reporter subclass: #TreeStructureReporter
	instanceVariableNames: 'numberOfLeadingTabs treeStructure'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!TreeStructureReporter methodsFor: 'formatting -- private' stamp: 'AM 11/16/2020 00:04:57'!
formatPortfolio: aPortfolio 
	
	^ [ aPortfolio accountName ]
		on: Error
		do: [ 'Portfolio sin nombre' ]! !

!TreeStructureReporter methodsFor: 'formatting -- private' stamp: 'AM 11/16/2020 00:02:43'!
formatReceptiveAccount: aReceptiveAccount
	
	^ [ aReceptiveAccount accountName ] 
		on: Error 
		do: [ 'Cuenta corriente sin nombre'].
! !

!TreeStructureReporter methodsFor: 'formatting -- private' stamp: 'AM 11/13/2020 20:18:31'!
leadingTabs
	
	| leadingTabs |
	
	leadingTabs := ''.
	numberOfLeadingTabs timesRepeat: [leadingTabs := leadingTabs, '\t'].
	
	^leadingTabs ! !


!TreeStructureReporter methodsFor: 'reporting' stamp: 'AM 11/13/2020 20:19:54'!
report

	numberOfLeadingTabs := 0.
	
	treeStructure := OrderedCollection new.
	account report: self.
	
	^ treeStructure ! !


!TreeStructureReporter methodsFor: 'reporting -- private' stamp: 'AM 11/16/2020 00:35:45'!
reportAccount: anAccount formatWith: formatForAccount evaluating: aBlock
		
	treeStructure add: (self leadingTabs, formatForAccount).
	
	numberOfLeadingTabs := numberOfLeadingTabs + 1.
	
	aBlock value.
	
	numberOfLeadingTabs := numberOfLeadingTabs - 1.! !


!classDefinition: #DetailedTreeStructureReporter category: 'Portfolio'!
TreeStructureReporter subclass: #DetailedTreeStructureReporter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!DetailedTreeStructureReporter methodsFor: 'reporting -- private' stamp: 'AM 11/16/2020 00:29:31'!
reportDeposit: aDeposit 
		
	treeStructure add: 
		(self leadingTabs, (self formatDeposit: aDeposit)).! !

!DetailedTreeStructureReporter methodsFor: 'reporting -- private' stamp: 'AM 11/16/2020 00:35:45'!
reportPortfolio: aPortfolio 
	
	self reportAccount: aPortfolio 
		formatWith: (self formatPortfolio: aPortfolio)
		evaluating: [	self reportAccountsRecursively: aPortfolio].
	
	treeStructure add: (self leadingTabs , '\t', (self formatBalance: aPortfolio))! !

!DetailedTreeStructureReporter methodsFor: 'reporting -- private' stamp: 'AM 11/16/2020 00:08:47'!
reportReceivingTransferComponent: aReceivingTransferComponent 
	
	treeStructure add: 
		(self leadingTabs, (self formatReceivingTransferComponent: aReceivingTransferComponent))! !

!DetailedTreeStructureReporter methodsFor: 'reporting -- private' stamp: 'AM 11/16/2020 00:35:45'!
reportReceptiveAccount: aReceptiveAccount 
	
	 self reportAccount: aReceptiveAccount 
		formatWith: ( self formatReceptiveAccount: aReceptiveAccount)
		evaluating: [ 	self reportTransactionsRecursively: aReceptiveAccount ].
		
	treeStructure add:
		(self leadingTabs , '\t', (self formatBalance: aReceptiveAccount))! !

!DetailedTreeStructureReporter methodsFor: 'reporting -- private' stamp: 'AM 11/16/2020 00:09:05'!
reportSendingTransferComponent: aSendingTransferComponent 

	treeStructure add: 
		(self leadingTabs, (self formatSendingTransferComponent: aSendingTransferComponent) )
		! !

!DetailedTreeStructureReporter methodsFor: 'reporting -- private' stamp: 'AM 11/16/2020 00:09:22'!
reportWithdraw: aWithdraw 
	
	treeStructure add: 
		(self leadingTabs, (self formatWithdraw: aWithdraw) ) ! !


!classDefinition: #SimpleTreeStructureReporter category: 'Portfolio'!
TreeStructureReporter subclass: #SimpleTreeStructureReporter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!SimpleTreeStructureReporter methodsFor: 'reporting -- private' stamp: 'AM 11/16/2020 00:35:45'!
reportPortfolio: aPortfolio 
	
	self reportAccount: aPortfolio
		 formatWith: (self formatPortfolio: aPortfolio) 
		 evaluating:  [ self reportAccountsRecursively: aPortfolio ].! !

!SimpleTreeStructureReporter methodsFor: 'reporting -- private' stamp: 'AM 11/16/2020 00:29:21'!
reportReceptiveAccount: aReceptiveAccount 	
	
	treeStructure add: 
		(self leadingTabs, (self formatReceptiveAccount: aReceptiveAccount ))! !


!classDefinition: #Transfer category: 'Portfolio'!
Object subclass: #Transfer
	instanceVariableNames: 'value sending receiving'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio'!

!Transfer methodsFor: 'accessing' stamp: 'AM 11/12/2020 21:39:14'!
receiving
	
	^ receiving! !

!Transfer methodsFor: 'accessing' stamp: 'AM 11/12/2020 21:39:34'!
sending
	
	^ sending! !

!Transfer methodsFor: 'accessing' stamp: 'AM 11/10/2020 10:34:16'!
value
	^ value! !


!Transfer methodsFor: 'initializing' stamp: 'NNH 11/13/2020 22:52:24'!
initializeFrom: aSendingReceptiveAccount to: aReceivingReceptiveAccount for: aValue 

	receiving := SendingTransferComponent for: self on: aSendingReceptiveAccount.
	sending := ReceivingTransferComponent for: self on: aReceivingReceptiveAccount. 
	value := aValue.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'error descriptions' stamp: 'AM 11/10/2020 22:35:06'!
canNotTransferFromAnAccountToItselfErrorDescription
	^ 'Can not transfer from an account to itself'! !

!Transfer class methodsFor: 'error descriptions' stamp: 'AM 11/10/2020 22:46:05'!
canNotTransferNonPositiveAmountErrorDescription
	^ 'Can not transfer when amount is not a positive value'! !


!Transfer class methodsFor: 'instance creation' stamp: 'AM 11/10/2020 22:47:09'!
from: aSendingReceptiveAccount to: aReceivingReceptiveAccount for: aValue 
	
	aSendingReceptiveAccount = aReceivingReceptiveAccount ifTrue: [ ^ self error: self canNotTransferFromAnAccountToItselfErrorDescription ].
	aValue <= 0 ifTrue: [ ^ self error: self canNotTransferNonPositiveAmountErrorDescription ].
	
	^self new initializeFrom: aSendingReceptiveAccount to: aReceivingReceptiveAccount for: aValue ! !
