!classDefinition: #PortfolioReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioReportTest methodsFor: 'as yet unclassified' stamp: 'DB 11/16/2020 12:25:15'!
test01TreeReportForEmptyPortfolioReturnsEmptyReport

	|  portfolio report |
	
	portfolio :=  Portfolio named: 'Empty Portfolio'.
	
	report := (PortfolioTreeReport with: portfolio) familyTreeReport. 
 	
	self assert: 1 equals: report size.
	self assert:  'Empty Portfolio' equals: (report at: 1)

	! !

!PortfolioReportTest methodsFor: 'as yet unclassified' stamp: 'DB 11/16/2020 15:48:21'!
test02TreeReportForPortfolioWithOneChildReturns

	|  portfolio report myAccount |
	
	portfolio :=  Portfolio named: 'Portfolio de la familia'.
	
	myAccount := ReceptiveAccount named: 'Cuenta mia'.
	portfolio add: myAccount.
	
	report := (PortfolioTreeReport with: portfolio) familyTreeReport. 
 	
	self assert: 2 equals: report size.
	self assert:  'Portfolio de la familia' equals: (report at: 1).
	self assert:  Character tab asString,'Cuenta mia' equals: (report at: 2)

	! !

!PortfolioReportTest methodsFor: 'as yet unclassified' stamp: 'DB 11/16/2020 15:48:17'!
test03TreeReportForPortfolioWithMoreThanOneChildReturns

	|  familyPorfolio childPortfolio report  angelesAccount childAccount juansAccount |
	
	familyPorfolio :=  Portfolio named: 'Portfolio de la familia'.
	childPortfolio := Portfolio named: 'Portfolio de hijos'.
	
	childAccount := ReceptiveAccount named: 'Cuenta mia'.
	juansAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	angelesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.
	
	childPortfolio add: juansAccount.
	childPortfolio add: angelesAccount.
	
	familyPorfolio add: childAccount.
	familyPorfolio add: childPortfolio.
	
	report := (PortfolioTreeReport with: familyPorfolio) familyTreeReport. 
 	
	self assert: 5 equals: report size.
	self assert:  'Portfolio de la familia' equals: (report at: 1).
	self assert:  Character tab asString,'Cuenta mia' equals: (report at: 2).
	self assert:  Character tab asString,'Portfolio de hijos' equals: (report at: 3).	
	self assert:  Character tab asString,Character tab asString,'Cuenta de Juan' equals: (report at: 4).	
	self assert:  Character tab asString,Character tab asString,'Cuenta de Angeles' equals: (report at: 5).	


	! !

!PortfolioReportTest methodsFor: 'as yet unclassified' stamp: 'DB 11/16/2020 16:13:16'!
test04SpecialTreeReportForEmptyPortfolioReturnsEmptyReport

	|  portfolio report |
	
	portfolio :=  Portfolio named: 'Empty Portfolio'.
	
	report := (PortfolioSpecialTreeReport with: portfolio) specialTreeReport. 
 	
	self assert: 2 equals: report size.
	self assert:  'Empty Portfolio' equals: (report at: 1).
	self assert:  Character tab asString,'Balance = 0' equals: (report at: 2).

	! !

!PortfolioReportTest methodsFor: 'as yet unclassified' stamp: 'DB 11/16/2020 16:13:44'!
test05SpecialTreeReportForPortfolioWithOneChildReturns

	|  portfolio report myAccount |
	
	portfolio :=  Portfolio named: 'Portfolio de la familia'.
	
	myAccount := ReceptiveAccount named: 'Cuenta mia'.
	Deposit register: 100 on: myAccount. 
	Withdraw register: 50 on: myAccount.
	portfolio add: myAccount.
	
	report := (PortfolioSpecialTreeReport with: portfolio) specialTreeReport. 
 	
	
	self assert: 6 equals: report size.
	self assert: 'Portfolio de la familia' equals: (report at: 1).
	self assert: Character tab asString,'Cuenta mia' equals: (report at: 2).
	self assert: Character tab asString, Character tab asString,'Deposit for 100' equals: (report at: 3).
	self assert: Character tab asString, Character tab asString,'Extraction for 50' equals: (report at: 4).	
	self assert: Character tab asString, Character tab asString,'Balance = 50' equals: (report at: 5).
	self assert: Character tab asString, 'Balance = 50' equals: (report at: 6).

	! !

!PortfolioReportTest methodsFor: 'as yet unclassified' stamp: 'DB 11/16/2020 16:09:32'!
test06SpecialTreeReportForPortfolioWithOneChildAndPorfolioChild

	|  familyPorfolio childPortfolio report  angelesAccount childAccount juansAccount anotherAccount |
	
	familyPorfolio :=  Portfolio named: 'Portfolio de la familia'.
	childPortfolio := Portfolio named: 'Portfolio de hijos'.
	
	childAccount := ReceptiveAccount named: 'Cuenta mia'.
	Deposit register: 60 on: childAccount.
	Withdraw register: 20 on: childAccount.
	
	juansAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	angelesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.
	anotherAccount := ReceptiveAccount named: 'Ahother account'.
	
	Deposit register: 40 on: juansAccount .
	Withdraw register: 10 on: juansAccount .
	
	Transfer register: 50 from: angelesAccount  to: anotherAccount. 
	
	childPortfolio add: juansAccount.
	childPortfolio add: angelesAccount.
	
	familyPorfolio add: childAccount.
	familyPorfolio add: childPortfolio.
	
	
	report := (PortfolioSpecialTreeReport with: familyPorfolio) specialTreeReport. 
 	
	self assert: 15 equals: report size.
	self assert: 'Portfolio de la familia' equals: (report at: 1).
	self assert: Character tab asString,'Cuenta mia' equals: (report at: 2).
	self assert: Character tab asString, Character tab asString,'Deposit for 60' equals: (report at: 3).
	self assert: Character tab asString, Character tab asString,'Extraction for 20' equals: (report at: 4).	
	self assert: Character tab asString, Character tab asString,'Balance = 40' equals: (report at: 5).
	self assert: Character tab asString,'Portfolio de hijos' equals: (report at: 6).
	self assert: Character tab asString, Character tab asString,'Cuenta de Juan' equals: (report at: 7).
	self assert: Character tab asString, Character tab asString,Character tab asString,'Deposit for 40' equals: (report at: 8).
	self assert: Character tab asString, Character tab asString,Character tab asString,'Extraction for 10' equals: (report at: 9).	
	self assert: Character tab asString, Character tab asString,Character tab asString,'Balance = 30' equals: (report at: 10).	
	self assert: Character tab asString, Character tab asString,'Cuenta de Angeles' equals: (report at: 11).
	self assert: Character tab asString, Character tab asString,Character tab asString,'Output by transfer of 50' equals: (report at: 12).
	self assert: Character tab asString, Character tab asString,Character tab asString,'Balance = -50' equals: (report at: 13).	
	self assert: Character tab asString, Character tab asString,'Balance = -20' equals: (report at: 14).	
	self assert: Character tab asString,'Balance = 20' equals: (report at: 15).	
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


!classDefinition: #ReportSummaryTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportSummaryTest methodsFor: 'as yet unclassified' stamp: 'DB 11/14/2020 16:20:53'!
test06SummaryReportForEmptyAccountReturnsOnlyBalance

	| account report |
	
	account := ReceptiveAccount new.
	
	report := (SummaryReport with: account) summary. 
 	
	self assert: 1 equals: report size.
	self assert: 'Balance = 0' equals: (report at: 1)
	! !

!ReportSummaryTest methodsFor: 'as yet unclassified' stamp: 'DB 11/14/2020 16:21:06'!
test07SummaryReportForDepositReturnsBalanceAndDeposit

	| account report |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	report := (SummaryReport with: account) summary. 
 	
	self assert: 2 equals: report size.
	self assert: 'Deposit for 100' equals: (report at: 1).
	self assert: 'Balance = 100' equals: (report at: 2)
	! !

!ReportSummaryTest methodsFor: 'as yet unclassified' stamp: 'DB 11/14/2020 16:21:20'!
test08SummaryReportForWithdrawReturnsBalanceAndWithdraw

	| account report |
	
	account := ReceptiveAccount new.
	Withdraw register: 50 on: account.
	
	report := (SummaryReport with: account) summary. 
 	
	self assert: 2 equals: report size.
	self assert: 'Extraction for 50' equals: (report at: 1).
	self assert: 'Balance = -50' equals: (report at: 2)
	
	! !

!ReportSummaryTest methodsFor: 'as yet unclassified' stamp: 'DB 11/14/2020 16:21:33'!
test09SummaryReportForTransferReturnsBalanceAndTransferTransaction

	| sender receiver report |
	
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	Transfer register: 60 from: sender to: receiver.
	
	report := (SummaryReport with: sender) summary. 
 	
	self assert: 2 equals: report size.
	self assert: 'Output by transfer of 60' equals: (report at: 1).
	self assert: 'Balance = -60' equals: (report at: 2).
	
	report := (SummaryReport with: receiver) summary. 
 	
	self assert: 2 equals: report size.
	self assert: 'Entry by transfer of 60' equals: (report at: 1).
	self assert: 'Balance = 60' equals: (report at: 2)
	
	! !

!ReportSummaryTest methodsFor: 'as yet unclassified' stamp: 'DB 11/14/2020 16:21:46'!
test10SummaryOfPortfolioWithoutAccountsHasOnlyBalance

	| portfolio report |
	
	portfolio := Portfolio new.
	
	report := (SummaryReport with: portfolio) summary. 
 	
	self assert: 1 equals: report size.
	self assert: 'Balance = 0' equals: (report at: 1)
	
	! !

!ReportSummaryTest methodsFor: 'as yet unclassified' stamp: 'DB 11/14/2020 16:22:06'!
test11SummaryOfPortfolioWithOneAccount

	| account portfolio report |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	report := (SummaryReport with: portfolio) summary. 
 	
	self assert: 2 equals: report size.
	self assert: 'Deposit for 100' equals: (report at: 1).
	self assert: 'Balance = 100' equals: (report at: 2)
	
	! !

!ReportSummaryTest methodsFor: 'as yet unclassified' stamp: 'DB 11/14/2020 16:22:21'!
test12SummaryOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio report |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	report := (SummaryReport with: composedPortofolio) summary. 
 	
	self assert: 3 equals: report size.
	self assert: 'Deposit for 100' equals: (report at: 1).
	self assert: 'Extraction for 50' equals: (report at: 2).
	self assert: 'Balance = 50' equals: (report at: 3)
	
	! !


!classDefinition: #ReportTransferNetTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportTransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTransferNetTest methodsFor: 'as yet unclassified' stamp: 'DB 11/16/2020 13:05:07'!
assertTransferNetAccount: anAccount value: expectedValue
 	
	self assert: expectedValue equals: (TransferNetReport with: anAccount) transferNet..
	! !

!ReportTransferNetTest methodsFor: 'as yet unclassified' stamp: 'DB 11/16/2020 13:05:29'!
test01TransferNetReportForEmptyAccountReturnsOnlyBalance

	| account |
	
	account := ReceptiveAccount new.
	
	self assertTransferNetAccount: account value: 0.! !

!ReportTransferNetTest methodsFor: 'as yet unclassified' stamp: 'DB 11/16/2020 13:05:49'!
test02TransferNetReportForDepositReturnsZero

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	self assertTransferNetAccount: account value: 0.! !

!ReportTransferNetTest methodsFor: 'as yet unclassified' stamp: 'DB 11/16/2020 13:06:01'!
test03TransferNetReportForWithdrawReturnsZero

	| account |
	
	account := ReceptiveAccount new.
	Withdraw register: 50 on: account.
	
	self assertTransferNetAccount: account value: 0.
	
	! !

!ReportTransferNetTest methodsFor: 'as yet unclassified' stamp: 'DB 11/16/2020 13:06:37'!
test04TransferNetReportForATransferReturnsNetBalance

	| sender receiver |
	
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	Transfer register: 60 from: sender to: receiver.
	
	self assertTransferNetAccount: sender value: -60.
	self assertTransferNetAccount: receiver value: 60.
	! !

!ReportTransferNetTest methodsFor: 'as yet unclassified' stamp: 'DB 11/16/2020 13:06:51'!
test05TransferNetOfAPortfolioWithoutAccountsReturnsZero

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assertTransferNetAccount: portfolio value: 0.
	! !

!ReportTransferNetTest methodsFor: 'as yet unclassified' stamp: 'DB 11/16/2020 13:07:18'!
test06TransferNetOfAPortfolioWithOneAccountReturnsTransferNetAccountValue

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assertTransferNetAccount: portfolio value: 0.
	! !

!ReportTransferNetTest methodsFor: 'as yet unclassified' stamp: 'DB 11/16/2020 13:07:39'!
test07TransferNetOfAPortfolioWithMoreThanOneAccountReturnsTransferNetAccountValue

	| sender receiver |
	
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	Deposit register: 100 on: sender.
	Withdraw register: 50 on: sender.
	
	Transfer register: 20 from: sender to: receiver.
	Transfer register: 30 from: receiver to: sender.	
	
	self assertTransferNetAccount: sender value: 10.
	
	
	
	
	! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'DB 11/10/2020 19:48:28'!
test01TransferAffectBalance

	| sender receiver |
	
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	Transfer register: 200 from: sender to: receiver.
	
	self assert: -200 equals: sender balance.
	self assert: 200 equals: receiver balance.
	! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'DB 11/10/2020 19:53:19'!
test02SenderAndReceiverCantBeTheSameAccount

	| account |
	
	account := ReceptiveAccount new.
	
	self should: [Transfer register: 200 from: account to: account]
		raise: Error 
		description: Transfer senderAndReceiverCantBeTheSameAccountErrorDescription.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'DB 11/10/2020 20:02:02'!
test03TransferAmountCantBeZeroOrNegative

	| sender receiver |
	
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	self should: [Transfer register: 0 from: sender to: receiver]
		raise: Error 
		description: Transfer cantTransferNegativeOrZeroAmountErrorDescription .! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'DB 11/10/2020 20:38:08'!
test04TransferTransactionesWereRegisteredInTheAccounts

	| sender receiver transfer |
	
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	transfer := Transfer register: 200 from: sender to: receiver.
	
	self assert: (sender hasRegistered: transfer withdrawTransaction).
	self assert: (receiver hasRegistered: transfer depositTransaction).! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'DB 11/10/2020 20:53:00'!
test05SenderAndReceiverHaveTheSameTransfer

	| sender receiver transfer |
	
	sender := ReceptiveAccount new.
	receiver := ReceptiveAccount new.
	
	transfer := Transfer register: 200 from: sender to: receiver.
	
	self assert: 1 equals: sender transactions size.
	self assert: 1 equals: receiver transactions size.
 	
	self assert: transfer equals: (sender transactions at: 1) transfer.
	self assert: transfer equals: (receiver transactions at: 1) transfer.
	
	! !


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

!Account methodsFor: 'balance' stamp: 'DB 11/14/2020 16:48:47'!
name

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'DB 11/16/2020 20:54:37'!
reportTo: aReport

	self transactions do: [ :aTransaction | 
		aTransaction reportTo: aReport.
	].! !

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

!Portfolio methodsFor: 'accounts management' stamp: 'DB 11/14/2020 16:48:29'!
name

	^name! !

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

!Portfolio methodsFor: 'initialization' stamp: 'DB 11/14/2020 16:38:20'!
initializeWith: aName

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := aName ! !


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


!Portfolio methodsFor: 'reports' stamp: 'DB 11/16/2020 16:41:12'!
reportTo: aReport tabs: tabs
	aReport reportAsPortfolioPrefix: self tabs: tabs.
	accounts do: [:anAccount |
		anAccount reportTo: aReport tabs:(Character tab asString), tabs.
	].
	aReport reportAsPortfolioPostfix: self tabs: tabs.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'NR 11/9/2020 06:01:26'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio!!'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'DB 11/14/2020 16:38:47'!
named: aName

	^self new initializeWith: aName.! !

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

!ReceptiveAccount methodsFor: 'transactions' stamp: 'DB 11/14/2020 17:02:16'!
initializeWith: aName
	name  := aName ! !

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

!ReceptiveAccount methodsFor: 'balance' stamp: 'DB 11/14/2020 16:48:34'!
name

	^name! !


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


!ReceptiveAccount methodsFor: 'reports' stamp: 'DB 11/16/2020 16:31:43'!
reportTo: aReport tabs: tabs 
	aReport reportAsReceptiveAccount: self tabs: tabs.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'DB 11/14/2020 16:39:22'!
named: aName

	^self new initializeWith: aName.! !


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

!AccountTransaction methodsFor: 'balance' stamp: 'DB 11/14/2020 15:56:28'!
reportTo: aReport

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


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

!Deposit methodsFor: 'balance' stamp: 'DB 11/14/2020 15:58:35'!
reportTo: aReport
	aReport reportADeposit: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferTransaction category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferTransaction
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTransaction methodsFor: 'as yet unclassified' stamp: 'DB 11/10/2020 20:52:02'!
transfer
	^transfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTransaction class' category: 'Portfolio-Solucion'!
TransferTransaction class
	instanceVariableNames: ''!

!TransferTransaction class methodsFor: 'as yet unclassified' stamp: 'DB 11/10/2020 20:26:25'!
register: aTransfer on: account

	| transaction |
	
	transaction := self for: aTransfer.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferDeposit category: 'Portfolio-Solucion'!
TransferTransaction subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'DB 11/10/2020 20:35:01'!
affectBalance: aBalance
	^aBalance + transfer amount! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'DB 11/10/2020 20:27:48'!
initializeFor: aTransfer 
	transfer := aTransfer ! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'DB 11/14/2020 15:58:44'!
reportTo: aReport
	aReport reportATransferDeposit: self! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'DB 11/10/2020 21:17:29'!
value
	^transfer amount! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: 'Portfolio-Solucion'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'as yet unclassified' stamp: 'DB 11/10/2020 20:26:53'!
for: aTransfer

	^ self new initializeFor: aTransfer ! !


!classDefinition: #TransferWithdraw category: 'Portfolio-Solucion'!
TransferTransaction subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'DB 11/10/2020 20:34:53'!
affectBalance: aBalance

	^aBalance - transfer amount! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'DB 11/10/2020 20:28:21'!
initializeFor: aTransfer 
	transfer := aTransfer ! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'DB 11/14/2020 15:58:52'!
reportTo: aReport
	aReport reportATransferWithdraw: self! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'DB 11/10/2020 21:17:46'!
value
	^transfer amount! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: 'Portfolio-Solucion'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'as yet unclassified' stamp: 'DB 11/10/2020 20:27:15'!
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

!Withdraw methodsFor: 'initialization' stamp: 'DB 11/14/2020 15:59:02'!
reportTo: aReport
	aReport reportAWithdraw: self! !


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


!classDefinition: #PortfolioReport category: 'Portfolio-Solucion'!
Object subclass: #PortfolioReport
	instanceVariableNames: 'portfolio report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioReport methodsFor: 'initialization' stamp: 'DB 11/16/2020 16:53:01'!
initializeWith: aPortfolio
	portfolio := aPortfolio.
	report := OrderedCollection new.! !


!PortfolioReport methodsFor: 'operations' stamp: 'DB 11/16/2020 16:51:57'!
addMe: name
	report add: name.! !


!PortfolioReport methodsFor: 'reports' stamp: 'DB 11/16/2020 16:49:30'!
reportAsPortfolioPostfix: anAccount tabs: tabs
	self subclassResponsibility.! !

!PortfolioReport methodsFor: 'reports' stamp: 'DB 11/16/2020 16:49:57'!
reportAsPortfolioPrefix: anAccount tabs: tabs
	self subclassResponsibility.! !

!PortfolioReport methodsFor: 'reports' stamp: 'DB 11/16/2020 16:50:26'!
reportAsReceptiveAccount: anAccount tabs: tabs
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioReport class' category: 'Portfolio-Solucion'!
PortfolioReport class
	instanceVariableNames: ''!

!PortfolioReport class methodsFor: 'as yet unclassified' stamp: 'DB 11/16/2020 16:53:33'!
with: aPortfolio

	^self new initializeWith: aPortfolio 
	! !


!classDefinition: #PortfolioSpecialTreeReport category: 'Portfolio-Solucion'!
PortfolioReport subclass: #PortfolioSpecialTreeReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioSpecialTreeReport methodsFor: 'as yet unclassified' stamp: 'DB 11/16/2020 16:49:43'!
reportAsPortfolioPostfix: anAccount tabs: tabs
	
	self addMe: tabs,(Character tab asString), 'Balance = ',(anAccount balance asString).! !

!PortfolioSpecialTreeReport methodsFor: 'as yet unclassified' stamp: 'DB 11/16/2020 16:55:18'!
reportAsPortfolioPrefix: anAccount tabs: tabs

	self addMe: tabs,anAccount name
	! !

!PortfolioSpecialTreeReport methodsFor: 'as yet unclassified' stamp: 'DB 11/16/2020 16:44:59'!
reportAsReceptiveAccount: anAccount tabs: tabs

	| detail |.
	self addMe: tabs,(anAccount name).
			
	detail := (SummaryReport with: anAccount) summary.
	detail do: [ :aDetail |
		self addMe: tabs,(Character tab asString), aDetail.
	].! !

!PortfolioSpecialTreeReport methodsFor: 'as yet unclassified' stamp: 'DB 11/16/2020 16:42:30'!
specialTreeReport

	portfolio reportTo: self tabs: ''.
	^report.
	! !


!classDefinition: #PortfolioTreeReport category: 'Portfolio-Solucion'!
PortfolioReport subclass: #PortfolioTreeReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTreeReport methodsFor: 'as yet unclassified' stamp: 'DB 11/16/2020 16:23:52'!
familyTreeReport 

	portfolio reportTo: self tabs: ''.
	^report.
	! !

!PortfolioTreeReport methodsFor: 'as yet unclassified' stamp: 'DB 11/16/2020 16:27:53'!
reportAsPortfolioPostfix: anAccount tabs: tabs.
	
	! !

!PortfolioTreeReport methodsFor: 'as yet unclassified' stamp: 'DB 11/16/2020 16:38:05'!
reportAsPortfolioPrefix: anAccount tabs: tabs.
	self addMe: tabs,anAccount name
	! !

!PortfolioTreeReport methodsFor: 'as yet unclassified' stamp: 'DB 11/16/2020 16:55:43'!
reportAsReceptiveAccount: anAccount tabs: tabs.
	self addMe: tabs,anAccount name
	! !


!classDefinition: #Report category: 'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'as yet unclassified' stamp: 'DB 11/14/2020 15:57:10'!
reportADeposit: aDeposit
	self subclassResponsibility ! !

!Report methodsFor: 'as yet unclassified' stamp: 'DB 11/14/2020 15:57:32'!
reportATransferDeposit: aTransferDeposit
	self subclassResponsibility ! !

!Report methodsFor: 'as yet unclassified' stamp: 'DB 11/14/2020 15:57:52'!
reportATransferWithdraw: aTransferWithdraw
	self subclassResponsibility ! !

!Report methodsFor: 'as yet unclassified' stamp: 'DB 11/14/2020 15:58:09'!
reportAWithdraw: aTransferWithdraw
	self subclassResponsibility ! !


!classDefinition: #SummaryReport category: 'Portfolio-Solucion'!
Report subclass: #SummaryReport
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SummaryReport methodsFor: 'as yet unclassified' stamp: 'DB 11/12/2020 21:36:43'!
initializeWith: anAccount

	summary := OrderedCollection new.
	account := anAccount 
	! !

!SummaryReport methodsFor: 'as yet unclassified' stamp: 'DB 11/14/2020 15:57:10'!
reportADeposit: aDeposit
	summary add: 'Deposit for ', aDeposit value asString.! !

!SummaryReport methodsFor: 'as yet unclassified' stamp: 'DB 11/14/2020 15:57:32'!
reportATransferDeposit: aDeposit
	summary add: 'Entry by transfer of ', aDeposit value asString .! !

!SummaryReport methodsFor: 'as yet unclassified' stamp: 'DB 11/14/2020 15:59:56'!
reportATransferWithdraw: aDeposit
	summary add: 'Output by transfer of ', aDeposit value asString .! !

!SummaryReport methodsFor: 'as yet unclassified' stamp: 'DB 11/14/2020 15:59:51'!
reportAWithdraw: aDeposit
	summary add: 'Extraction for ', aDeposit value asString .! !

!SummaryReport methodsFor: 'as yet unclassified' stamp: 'DB 11/14/2020 15:56:04'!
summary

	account reportTo: self.
	summary add: 'Balance = ' , account balance asString .
	^summary.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SummaryReport class' category: 'Portfolio-Solucion'!
SummaryReport class
	instanceVariableNames: ''!

!SummaryReport class methodsFor: 'as yet unclassified' stamp: 'DB 11/16/2020 20:46:51'!
with: account

	^self new initializeWith: account.! !


!classDefinition: #TransferNetReport category: 'Portfolio-Solucion'!
Report subclass: #TransferNetReport
	instanceVariableNames: 'net'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'DB 11/12/2020 21:45:31'!
initializeWith: anAccount

	net := 0.
	account := anAccount 
	! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'DB 11/14/2020 15:57:10'!
reportADeposit: aDeposit
	! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'DB 11/14/2020 15:57:32'!
reportATransferDeposit: aDeposit
	net := net + aDeposit value.! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'DB 11/14/2020 15:57:52'!
reportATransferWithdraw: aTransferWithdraw
	net := net - aTransferWithdraw value.! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'DB 11/14/2020 15:58:09'!
reportAWithdraw: aDeposit
	! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'DB 11/14/2020 15:56:04'!
transferNet

	account reportTo: self.
	^net.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNetReport class' category: 'Portfolio-Solucion'!
TransferNetReport class
	instanceVariableNames: ''!

!TransferNetReport class methodsFor: 'as yet unclassified' stamp: 'DB 11/12/2020 21:46:11'!
with: anAccount

	^self new initializeWith: anAccount.! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'withdrawTransaction depositTransaction amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'operations' stamp: 'DB 11/10/2020 20:35:21'!
amount
	^amount
	
	
	! !

!Transfer methodsFor: 'operations' stamp: 'DB 11/10/2020 20:36:16'!
depositTransaction

	^depositTransaction 
	
	
	! !

!Transfer methodsFor: 'operations' stamp: 'DB 11/10/2020 20:36:05'!
withdrawTransaction

	^withdrawTransaction 
	
	
	! !


!Transfer methodsFor: 'initialization' stamp: 'DB 11/10/2020 20:30:03'!
initializeWith: anAmount From: aSenderAccount to: aReceiverAccount

	amount := anAmount.
	withdrawTransaction := TransferWithdraw register: self on: aSenderAccount .
	depositTransaction := TransferDeposit register: self on: aReceiverAccount.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: 'depositTransaction withdrawTransaction'!

!Transfer class methodsFor: 'instance creation' stamp: 'DB 11/10/2020 20:32:36'!
register: amount from: aSender to: aReceiver

	aSender = aReceiver ifTrue: [^self signalAndReceiverCantBeTheSameAccount ].
	
	amount <= 0 ifTrue: [^self signalCantTransferNegativeOrZeroAmount ].
	
	^self new initializeWith: amount From: aSender to: aReceiver.
	
! !


!Transfer class methodsFor: 'error handling' stamp: 'DB 11/10/2020 20:00:40'!
cantTransferNegativeOrZeroAmountErrorDescription
	^'Cant transfer zero or negative amount'! !

!Transfer class methodsFor: 'error handling' stamp: 'DB 11/10/2020 19:54:05'!
senderAndReceiverCantBeTheSameAccountErrorDescription
	^'Sender and receiver cant be the same account'! !

!Transfer class methodsFor: 'error handling' stamp: 'DB 11/10/2020 19:57:01'!
signalAndReceiverCantBeTheSameAccount
	^self error: self senderAndReceiverCantBeTheSameAccountErrorDescription 
	! !

!Transfer class methodsFor: 'error handling' stamp: 'DB 11/10/2020 20:00:40'!
signalCantTransferNegativeOrZeroAmount
	^self error: self cantTransferNegativeOrZeroAmountErrorDescription ! !

