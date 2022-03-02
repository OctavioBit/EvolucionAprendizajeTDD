!classDefinition: #AccountSpecialReportTest category: 'Portfolio2-Ejercicio'!
TestCase subclass: #AccountSpecialReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!AccountSpecialReportTest methodsFor: 'tests' stamp: 'EMI 11/16/2020 16:38:04'!
test01EmptyPortfolioOnlyShowsName
	| portfolio report expectedResult |
	portfolio _ Portfolio new.
	report _ AccountSpecialReport of: portfolio.
	expectedResult _ OrderedCollection with: 'Portfolio de Unnamed Portfolio'
								    with: (self class identString: 'Balance = 0' byLevel: 1).
	self assert: report report equals: expectedResult.! !

!AccountSpecialReportTest methodsFor: 'tests' stamp: 'EMI 11/16/2020 16:40:38'!
test02PortfolioWithAnAccountWithADepositShowsNamesAndIdentation
	| portfolio account report expectedResult |
	portfolio _ Portfolio withName: 'Compania de Pepe'.
	account _ ReceptiveAccount withName: 'Suiza'.
	Deposit register: 10 on: account.
	portfolio add: account.
	report _ AccountSpecialReport of: portfolio.
	expectedResult _ OrderedCollection with: 'Portfolio de Compania de Pepe' 
								    with: (self class identString: 'Cuenta de Suiza' byLevel:1) 
								    with: (self class identString: 'Depósito por 10.' byLevel: 2) 
								    with: (self class identString: 'Balance = 10.' byLevel: 2)
								    with: (self class identString: 'Balance = 10' byLevel: 1).
	self assert: report report equals: expectedResult.! !

!AccountSpecialReportTest methodsFor: 'tests' stamp: 'EMI 11/16/2020 16:44:24'!
test03PortfolioWithAnEmptyPortfolioAndAnAccountWithADepositShowsNamesAndIdentation
	| portfolio portfolioChild account report expectedResult |
	portfolio _ Portfolio withName: 'Compania de Pepe'.
	portfolioChild _ Portfolio withName: 'Testaferro de Pepe'.
	portfolio add: portfolioChild.
	account _ ReceptiveAccount withName: 'Suiza'.
	Deposit register: 10 on: account.
	portfolio add: account.
	report _ AccountSpecialReport of: portfolio.
	expectedResult _ OrderedCollection with: 'Portfolio de Compania de Pepe'
								    with: (self class identString: 'Portfolio de Testaferro de Pepe' byLevel:1) 
								    with: (self class identString: 'Balance = 0' byLevel:2)
								    with: (self class identString: 'Cuenta de Suiza' byLevel:1) 
								    with: (self class identString: 'Depósito por 10.' byLevel: 2) 
								    with: (self class identString: 'Balance = 10.' byLevel: 2).
	expectedResult add: (self class identString: 'Balance = 10' byLevel: 1).
	self assert: report report equals: expectedResult.! !

!AccountSpecialReportTest methodsFor: 'tests' stamp: 'EMI 11/16/2020 16:46:08'!
test04PortfolioWithAPortfolioAndAnAccountWithADepositShowsNamesAndIdentation
	| portfolio portfolioChild account report expectedResult |
	portfolio _ Portfolio withName: 'Compania de Pepe'.
	portfolioChild _ Portfolio withName: 'Testaferro de Pepe'.
	portfolio add: portfolioChild.
	account _ ReceptiveAccount withName: 'Suiza'.
	Deposit register: 10 on: account.
	portfolioChild add: account.
	report _ AccountSpecialReport of: portfolio.
	expectedResult _ OrderedCollection with: 'Portfolio de Compania de Pepe'
								    with: (self class identString: 'Portfolio de Testaferro de Pepe' byLevel:1) 
								    with: (self class identString: 'Cuenta de Suiza' byLevel:2) 
								    with: (self class identString: 'Depósito por 10.' byLevel:3)
								    with: (self class identString: 'Balance = 10.' byLevel: 3)
								    with: (self class identString: 'Balance = 10' byLevel:2).
	expectedResult add: (self class identString: 'Balance = 10' byLevel: 1).
	self assert: report report equals: expectedResult.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSpecialReportTest class' category: 'Portfolio2-Ejercicio'!
AccountSpecialReportTest class
	instanceVariableNames: ''!

!AccountSpecialReportTest class methodsFor: 'as yet unclassified' stamp: 'EMI 11/16/2020 16:37:32'!
identString: aString byLevel: anIdentationLevel
	^aString identByAmount: Report identationSpacesPerLevel * anIdentationLevel! !


!classDefinition: #AccountSummaryTest category: 'Portfolio2-Ejercicio'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!AccountSummaryTest methodsFor: 'tests' stamp: 'EMI 11/13/2020 20:57:08'!
test01AccountSummaryOfEmptyAccountOnlyShowsBalance
	| accountSummary account |
	account _ ReceptiveAccount new.
	accountSummary _ AccountSummaryReport of: account.
	 
	self deny: accountSummary report isEmpty.
	self assert: accountSummary report first equals: 'Balance = 0.'.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'EMI 11/13/2020 20:57:09'!
test02AccountSummaryOfAccountWithADepositShowDepositInfo
	| accountSummary account resultSummary |
	account _ ReceptiveAccount new.
	accountSummary _ AccountSummaryReport of: account.
	
	Deposit register: 10 on: account.
	
	resultSummary _ OrderedCollection with: 'Depósito por 10.' with: 'Balance = 10.'.
	
	self assert: accountSummary report equals: resultSummary.
	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'EMI 11/13/2020 20:57:08'!
test03AccountSummaryOfAccountWithAWithdrawShowWithdrawInfo
	| accountSummary account resultSummary |
	account _ ReceptiveAccount new.
	accountSummary _ AccountSummaryReport of: account.
	
	Withdraw register: 10 on: account.
	
	resultSummary _ OrderedCollection with: 'Extracción por 10.' with: 'Balance = -10.'.
	
	self assert: accountSummary report equals: resultSummary.
	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'EMI 11/13/2020 20:57:09'!
test04AccountSummaryOfAccountWithAExtractionTransferShowExtractionTransferInfo
	| accountSummary accountOrigin accountDestination resultSummary |
	accountOrigin _ ReceptiveAccount new.
	accountDestination _ ReceptiveAccount new.
	accountSummary _ AccountSummaryReport of: accountOrigin.
	
	Transfer from: accountOrigin to: accountDestination amount: 10.
	
	resultSummary _ OrderedCollection with: 'Salida por transferencia de 10.' with: 'Balance = -10.'.
	
	self assert: accountSummary report equals: resultSummary.
	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'EMI 11/13/2020 20:57:09'!
test05AccountSummaryOfAccountWithADepositTransferShowDepositTransferInfo
	| accountSummary accountOrigin accountDestination resultSummary |
	accountOrigin _ ReceptiveAccount new.
	accountDestination _ ReceptiveAccount new.
	accountSummary _ AccountSummaryReport of: accountDestination.
	
	Transfer from: accountOrigin to: accountDestination amount: 10.
	
	resultSummary _ OrderedCollection with: 'Entrada por transferencia de 10.' with: 'Balance = 10.'.
	
	self assert: accountSummary report equals: resultSummary.
	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'EMI 11/13/2020 20:57:08'!
test06AccountSummaryOfAccountWithOneOfEachTransactionShowsCorrectInfo
	| accountSummary accountOrigin accountDestination resultSummary |
	accountOrigin _ ReceptiveAccount new.
	accountDestination _ ReceptiveAccount new.
	accountSummary _ AccountSummaryReport of: accountOrigin.
	
	Deposit register: 50  on: accountOrigin.
	Withdraw register: 10 on: accountOrigin.
	Transfer from: accountOrigin to: accountDestination amount: 20.
	Transfer from: accountDestination to: accountOrigin amount: 5.
	
	resultSummary _ OrderedCollection with: 'Depósito por 50.' with: 'Extracción por 10.' with: 'Salida por transferencia de 20.' with: 'Entrada por transferencia de 5.' with: 'Balance = 25.'.
	
	self assert: accountSummary report equals: resultSummary.
	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'EMI 11/13/2020 20:57:08'!
test07AccountSummaryOfEmptyPortfolioOnlyShowsBalance
	| accountSummary portfolio |
	portfolio _ Portfolio new.
	accountSummary _ AccountSummaryReport of: portfolio.
	 
	self deny: accountSummary report isEmpty.
	self assert: accountSummary report first equals: 'Balance = 0.'.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'EMI 11/13/2020 20:57:09'!
test08AccountSummaryOfPortfolioWithADeposit
	| accountSummary portfolio account expectedResult |
	portfolio _ Portfolio new.
	account _ ReceptiveAccount new.
	accountSummary _ AccountSummaryReport of: portfolio.
	Deposit register: 10 on: account.
	portfolio add: account.
	 
	expectedResult _ OrderedCollection with: 'Depósito por 10.' with: 'Balance = 10.'.
	
	self deny: accountSummary report isEmpty.
	self assert: accountSummary report equals: expectedResult.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'EMI 11/13/2020 20:57:08'!
test09AccountSummaryOfPortfolioWithAWithdraw
	| accountSummary portfolio account expectedResult |
	portfolio _ Portfolio new.
	account _ ReceptiveAccount new.
	accountSummary _ AccountSummaryReport of: portfolio.
	Withdraw register: 10 on: account.
	portfolio add: account.
	 
	expectedResult _ OrderedCollection with: 'Extracción por 10.' with: 'Balance = -10.'.
	
	self deny: accountSummary report isEmpty.
	self assert: accountSummary report equals: expectedResult.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'EMI 11/13/2020 20:57:08'!
test10AccountSummaryOfPortfolioWithADepositTransfer
	| accountSummary portfolio accountOrigin accountDestination expectedResult |
	portfolio _ Portfolio new.
	accountOrigin _ ReceptiveAccount new.
	accountDestination _ ReceptiveAccount new.
	accountSummary _ AccountSummaryReport of: portfolio.
	
	portfolio add: accountOrigin.
	
	Transfer from: accountOrigin to: accountDestination amount: 10.
	 
	expectedResult _ OrderedCollection with: 'Salida por transferencia de 10.' with: 'Balance = -10.'.
	
	self deny: accountSummary report isEmpty.
	self assert: accountSummary report equals: expectedResult.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'EMI 11/13/2020 20:57:09'!
test11AccountSummaryOfPortfolioWithAExtractionTransfer
	| accountSummary portfolio accountOrigin accountDestination expectedResult |
	portfolio _ Portfolio new.
	accountOrigin _ ReceptiveAccount new.
	accountDestination _ ReceptiveAccount new.
	accountSummary _ AccountSummaryReport of: portfolio.
	
	portfolio add: accountDestination.
	
	Transfer from: accountOrigin to: accountDestination amount: 10.
	 
	expectedResult _ OrderedCollection with: 'Entrada por transferencia de 10.' with: 'Balance = 10.'.
	
	self deny: accountSummary report isEmpty.
	self assert: accountSummary report equals: expectedResult.! !


!classDefinition: #NetTransfersReportTest category: 'Portfolio2-Ejercicio'!
TestCase subclass: #NetTransfersReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!NetTransfersReportTest methodsFor: 'tests' stamp: 'EMI 11/13/2020 19:54:55'!
test01NetTransferReportOfEmptyAccountReturnsZero
	| account netTransfer |
	account _ ReceptiveAccount new.
	netTransfer  _ NetTransfersReport of: account.

	self assert: netTransfer report equals: 0.! !

!NetTransfersReportTest methodsFor: 'tests' stamp: 'EMI 11/13/2020 20:26:57'!
test02NetTransferReportOfAccountWithADepositTransferReturnsCorrectly
	| accountOrigin accountDestination netTransfer |
	accountOrigin _ ReceptiveAccount new.
	accountDestination _ ReceptiveAccount new.
	netTransfer  _ NetTransfersReport of: accountDestination.

	Transfer from: accountOrigin to: accountDestination amount: 10.

	self assert: netTransfer report equals: 10.! !

!NetTransfersReportTest methodsFor: 'tests' stamp: 'EMI 11/13/2020 20:27:35'!
test03NetTransferReportOfAccountWithAExtractionTransferReturnsCorrectly
	| accountOrigin accountDestination netTransfer |
	accountOrigin _ ReceptiveAccount new.
	accountDestination _ ReceptiveAccount new.
	netTransfer  _ NetTransfersReport of: accountOrigin.

	Transfer from: accountOrigin to: accountDestination amount: 10.

	self assert: netTransfer report equals: -10.! !

!NetTransfersReportTest methodsFor: 'tests' stamp: 'EMI 11/13/2020 19:57:18'!
test04NetTransferReportOfAccountWithADepositReturnsZero
	| account netTransfer |
	account _ ReceptiveAccount new.
	netTransfer  _ NetTransfersReport of: account.
	Deposit register: 10 on: account.

	self assert: netTransfer report equals: 0.! !

!NetTransfersReportTest methodsFor: 'tests' stamp: 'EMI 11/13/2020 20:47:43'!
test05NetTransferReportOfEmptyPortfolioReturnsZero
	| portfolio netTransfer |
	portfolio _ Portfolio new.
	netTransfer  _ NetTransfersReport of: portfolio.

	self assert: netTransfer report equals: 0.! !

!NetTransfersReportTest methodsFor: 'tests' stamp: 'EMI 11/13/2020 20:50:47'!
test06NetTransferReportOfPortfolioWithAccountAndATransferReturnsCorrectly
	| portfolio netTransfer accountOrigin accountDestination|
	portfolio _ Portfolio new.
	netTransfer  _ NetTransfersReport of: portfolio.
	
	accountOrigin _ ReceptiveAccount new.
	accountDestination _ ReceptiveAccount new.
	Transfer from: accountOrigin to: accountDestination amount: 10.
	portfolio add: accountOrigin .

	self assert: netTransfer report equals: -10.! !

!NetTransfersReportTest methodsFor: 'tests' stamp: 'EMI 11/13/2020 20:52:34'!
test07NetTransferReportOfPortfoliosWithAccountAndATransferReturnsCorrectly
	| portfolioRoot portfolioChild netTransfer accountOrigin accountDestination|
	portfolioRoot _ Portfolio new.
	portfolioChild _ Portfolio new.
	netTransfer  _ NetTransfersReport of: portfolioRoot.
	
	accountOrigin _ ReceptiveAccount new.
	accountDestination _ ReceptiveAccount new.
	Transfer from: accountOrigin to: accountDestination amount: 10.
	portfolioChild add: accountDestination .
	portfolioRoot add: portfolioChild.

	self assert: netTransfer report equals: 10.! !

!NetTransfersReportTest methodsFor: 'tests' stamp: 'EMI 11/13/2020 21:04:09'!
test08NetTransferReportOfPortfolioTreeOfHeightThreeReturnsCorrectly
	| portfolioRoot portfolioChildLeft portfolioChildRight portfolioGrandChildLeft portfolioGrandChildRight netTransfer accountOrigin accountDestination |
	portfolioRoot _ Portfolio new.
	portfolioChildLeft _ Portfolio new.
	portfolioGrandChildLeft _ Portfolio new.
	portfolioChildRight _ Portfolio new.
	portfolioGrandChildRight _ Portfolio new.
	netTransfer  _ NetTransfersReport of: portfolioRoot.
	
	accountOrigin _ ReceptiveAccount new.
	accountDestination _ ReceptiveAccount new.
	Transfer from: accountOrigin to: accountDestination amount: 10.
	portfolioGrandChildLeft add: accountDestination .
	portfolioGrandChildRight add: accountOrigin.
	portfolioChildLeft add: portfolioGrandChildLeft.
	portfolioChildRight add: portfolioGrandChildRight.
	portfolioRoot add: portfolioChildLeft.
	portfolioRoot add: portfolioChildRight.

	self assert: netTransfer report equals: 0.! !


!classDefinition: #PortfolioStructureReportTest category: 'Portfolio2-Ejercicio'!
TestCase subclass: #PortfolioStructureReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!PortfolioStructureReportTest methodsFor: 'tests' stamp: 'EMI 11/15/2020 18:42:31'!
test01ReportOfAnEmptyPortfolioStructureHasCorrectName
	| portfolio report expectedResult |
	portfolio _ Portfolio new.
	report _ PortfolioStructureReport of: portfolio.
	
	expectedResult _ OrderedCollection with: 'Portfolio de Unnamed Portfolio'.
	self assert: report report equals: expectedResult.! !

!PortfolioStructureReportTest methodsFor: 'tests' stamp: 'EMI 11/16/2020 16:34:27'!
test02ReportOfASimplePortfolioStructureHasCorrectNamesAndIdentation
	| portfolio account report expectedResult |
	portfolio _ Portfolio new.
	account _ ReceptiveAccount new.
	portfolio add: account.
	report _ PortfolioStructureReport of: portfolio.
	
	expectedResult _ OrderedCollection with: 'Portfolio de Unnamed Portfolio' 
								    with: (self class identString:  'Cuenta de Unnamed Account' byLevel: 1).
	self assert: report report equals: expectedResult.! !

!PortfolioStructureReportTest methodsFor: 'tests' stamp: 'EMI 11/16/2020 16:35:09'!
test03ReportOfAListPortfolioStructureHasCorrectNamesAndIdentation
	| portfolio portfolioChild account report expectedResult |
	portfolio _ Portfolio new.
	portfolioChild _ Portfolio new.
	account _ ReceptiveAccount new.
	portfolioChild add: account.
	portfolio add: portfolioChild.
	report _ PortfolioStructureReport of: portfolio.
	
	expectedResult _ OrderedCollection with: 'Portfolio de Unnamed Portfolio' 
	                                             							    with: (self class identString: 'Portfolio de Unnamed Portfolio'  byLevel: 1) 
								    with: (self class identString: 'Cuenta de Unnamed Account' byLevel: 2).
	self assert: report report equals: expectedResult.! !

!PortfolioStructureReportTest methodsFor: 'tests' stamp: 'EMI 11/16/2020 16:36:16'!
test04ReportOfAListOfNamedPortfolioStructureHasCorrectNamesAndIdentation
	| portfolio portfolioChild account report expectedResult |
	portfolio _ Portfolio withName: 'Compania 1'.
	portfolioChild _ Portfolio withName: 'Pepe'.
	account _ ReceptiveAccount withName: 'Lavado de dinero'.
	portfolioChild add: account.
	portfolio add: portfolioChild.
	report _ PortfolioStructureReport of: portfolio.
	
	expectedResult _ OrderedCollection with: 'Portfolio de Compania 1' 
								    with: (self class identString: 'Portfolio de Pepe' byLevel: 1)
								    with: (self class identString: 'Cuenta de Lavado de dinero' byLevel: 2).
	self assert: report report equals: expectedResult.! !

!PortfolioStructureReportTest methodsFor: 'tests' stamp: 'EMI 11/16/2020 16:37:10'!
test05ReportOfAListOfNamedPortfolioStructureHasCorrectNamesAndIdentation
	| portfolio portfolioChildLeft portfolioChildRight report expectedResult |
	portfolio _ Portfolio withName: 'Compania 1'.
	portfolioChildLeft _ Portfolio withName: 'Pepe'.
	portfolioChildRight _ Portfolio withName: 'Jose'.
	portfolio add: portfolioChildLeft.
	portfolio add: portfolioChildRight.
	report _ PortfolioStructureReport of: portfolio.
	
	expectedResult _ OrderedCollection with: 'Portfolio de Compania 1' 
								    with: (self class identString: 'Portfolio de Pepe' byLevel: 1) 
								    with: (self class identString: 'Portfolio de Jose' byLevel: 1) .
	self assert: report report equals: expectedResult.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioStructureReportTest class' category: 'Portfolio2-Ejercicio'!
PortfolioStructureReportTest class
	instanceVariableNames: ''!

!PortfolioStructureReportTest class methodsFor: 'as yet unclassified' stamp: 'EMI 11/16/2020 16:34:00'!
identString: aString byLevel: anIdentationLevel
	^aString identByAmount: Report identationSpacesPerLevel * anIdentationLevel.! !


!classDefinition: #PortfolioTest category: 'Portfolio2-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

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

!PortfolioTest methodsFor: 'tests' stamp: 'EMI 11/16/2020 15:58:05'!
test16PortfolioHasDefaultName
	| portfolio |
	
	portfolio _ Portfolio new.
	
	self assert: portfolio accountName equals: 'Unnamed Portfolio'.! !

!PortfolioTest methodsFor: 'tests' stamp: 'EMI 11/16/2020 15:57:24'!
test17CanCreatePortfolioWithName
	| portfolio |
	
	portfolio _ Portfolio withName: 'Test Portfolio'.
	
	self assert: portfolio accountName equals: 'Test Portfolio'.! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio2-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests - account transfers' stamp: 'EMI 11/9/2020 21:22:31'!
test08AccountCanTransferToAnotherAccountWithPositiveAmount
	| accountOrigin accountDestination |
	
	accountOrigin _ ReceptiveAccount new.
	accountDestination _ ReceptiveAccount new.
	
	Deposit register: 10 on: accountOrigin.
	
	Transfer from: accountOrigin to: accountDestination amount: 10.
	
	self assert: accountOrigin transactions size equals: 2.
	self assert: accountDestination transactions size equals: 1.
	self assert: accountOrigin balance equals: 0.
	self assert: accountDestination balance equals: 10.
! !

!ReceptiveAccountTest methodsFor: 'tests - account transfers' stamp: 'EMI 11/9/2020 21:22:25'!
test09AccountsWithTransferKnowsOriginAndDestination
	| accountOrigin accountDestination |
	
	accountOrigin _ ReceptiveAccount new.
	accountDestination _ ReceptiveAccount new.
	
	Transfer from: accountOrigin to: accountDestination amount: 10.
	Deposit register: 10 on: accountOrigin.

	self assert: (accountOrigin transactions 	first) origin equals: accountOrigin.
	self assert: (accountOrigin transactions 	first) destination equals: accountDestination.
	self assert: (accountDestination transactions 	first) origin equals: accountOrigin.
	self assert: (accountDestination transactions 	first) destination equals: accountDestination.
! !

!ReceptiveAccountTest methodsFor: 'tests - account transfers' stamp: 'EMI 11/9/2020 21:22:22'!
test10AccountsCannotTransferInvalidAmounts
	| accountOrigin accountDestination |
	
	accountOrigin _ ReceptiveAccount new.
	accountDestination _ ReceptiveAccount new.
	
	self should: [Transfer from: accountOrigin to: accountDestination amount: 0] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: Transfer cannotTransferInvalidAmountMessage.
		self assert: accountOrigin transactions isEmpty.
		self assert: accountDestination transactions isEmpty.
		self assert: accountOrigin balance equals: 0.
		self assert: accountDestination balance equals: 0.
	].

	self should: [Transfer from: accountOrigin to: accountDestination amount: -10] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: Transfer cannotTransferInvalidAmountMessage.
		self assert: accountOrigin transactions isEmpty.
		self assert: accountDestination transactions isEmpty.
		self assert: accountOrigin balance equals: 0.
		self assert: accountDestination balance equals: 0.
	].

	
! !

!ReceptiveAccountTest methodsFor: 'tests - account transfers' stamp: 'EMI 11/9/2020 21:22:18'!
test11AccountsCannotTransferToThemselves
	| account |
	account _ ReceptiveAccount new.
	self should: [Transfer from: account to: account amount: 10] 
	raise: Error 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: Transfer cannotTransferWhenOriginAndDestinationAreSame.
		self assert: account transactions isEmpty.
		self assert: account balance equals: 0.
	].

	
! !


!ReceptiveAccountTest methodsFor: 'tests - account' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests - account' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests - account' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests - account' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests - account' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests - account' stamp: 'NR 11/9/2020 06:00:12'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests - account' stamp: 'NR 11/9/2020 06:02:30'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: account.
		
	self assert: 1 equals: account transactions size .
	self assert: (account transactions includes: deposit).
! !

!ReceptiveAccountTest methodsFor: 'tests - account' stamp: 'EMI 11/16/2020 15:58:17'!
test12AccountHasDefaultName
	| account |
	account _ ReceptiveAccount new.
	
	self assert: account accountName equals: 'Unnamed Account'.! !

!ReceptiveAccountTest methodsFor: 'tests - account' stamp: 'EMI 11/16/2020 15:57:52'!
test13CanCreateAccountWithName
	| account |
	account _ ReceptiveAccount withName: 'Test account'.
	
	self assert: account accountName equals: 'Test account'.! !


!classDefinition: #Account category: 'Portfolio2-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

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


!Account methodsFor: 'reports' stamp: 'EMI 11/12/2020 21:12:58'!
reportTo: aReport
	^self subclassResponsibility.! !


!Account methodsFor: 'names' stamp: 'EMI 11/16/2020 15:58:50'!
accountName
	^name.! !


!classDefinition: #Portfolio category: 'Portfolio2-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

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


!Portfolio methodsFor: 'initialization' stamp: 'EMI 11/16/2020 15:55:34'!
initialize
	name _ 'Unnamed Portfolio'.
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'EMI 11/16/2020 15:55:34'!
initializeWithName: aString 
	self initialize.
	name := aString.! !


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


!Portfolio methodsFor: 'reports' stamp: 'EMI 11/16/2020 00:04:10'!
reportTo: aReport
	aReport beginReportPortfolio: self.
	accounts do:[:anAccount | anAccount reportTo: aReport].
	aReport endReportPortfolio: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio2-Ejercicio'!
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


!Portfolio class methodsFor: 'instance creation' stamp: 'EMI 11/15/2020 18:27:21'!
withName: aString 
	^self new initializeWithName: aString ! !


!classDefinition: #ReceptiveAccount category: 'Portfolio2-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'EMI 11/16/2020 15:55:34'!
initialize
	super initialize.
	transactions := OrderedCollection new.
	name _ 'Unnamed Account'.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'EMI 11/16/2020 15:55:34'!
initializeWithName: aString 
	self initialize.
	name _ aString.! !


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


!ReceptiveAccount methodsFor: 'reports' stamp: 'EMI 11/16/2020 16:02:00'!
reportTo: aReport
	aReport reportReceptiveAccount: self.
	transactions do:[:aTransaction |aTransaction reportTo: aReport].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio2-Ejercicio'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'EMI 11/15/2020 18:21:23'!
withName: aString 
	^self new initializeWithName: aString ! !


!classDefinition: #AccountTransaction category: 'Portfolio2-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'reports' stamp: 'EMI 11/12/2020 21:17:53'!
reportTo: aReport
	^self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio2-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio2-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'reports' stamp: 'EMI 11/12/2020 21:18:03'!
reportTo: aReport
	^aReport reportDepositTransaction: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio2-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferOperations category: 'Portfolio2-Ejercicio'!
AccountTransaction subclass: #TransferOperations
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!TransferOperations methodsFor: 'initialization' stamp: 'EMI 11/9/2020 21:01:56'!
initializeFor: aTransfer
	transfer _ aTransfer.! !


!TransferOperations methodsFor: 'balance' stamp: 'EMI 11/9/2020 20:10:06'!
affectBalance: aBalance 
	^self subclassResponsibility.! !


!TransferOperations methodsFor: 'transfer participants' stamp: 'EMI 11/9/2020 20:59:17'!
destination
	^transfer destination.! !

!TransferOperations methodsFor: 'transfer participants' stamp: 'EMI 11/9/2020 20:59:22'!
origin
	^transfer origin.! !


!TransferOperations methodsFor: 'value' stamp: 'EMI 11/9/2020 20:59:30'!
value
	^transfer value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferOperations class' category: 'Portfolio2-Ejercicio'!
TransferOperations class
	instanceVariableNames: ''!

!TransferOperations class methodsFor: 'initialization' stamp: 'EMI 11/9/2020 21:01:28'!
fromTransfer: aTransfer
	^self new initializeFor: aTransfer.! !


!classDefinition: #DepositTransfer category: 'Portfolio2-Ejercicio'!
TransferOperations subclass: #DepositTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!DepositTransfer methodsFor: 'balance' stamp: 'EMI 11/9/2020 20:02:17'!
affectBalance: aBalance
	^aBalance + transfer value.! !


!DepositTransfer methodsFor: 'reports' stamp: 'EMI 11/12/2020 21:18:46'!
reportTo: aReport
	^aReport reportDepositTransferTransaction: self.! !


!classDefinition: #ExtractionTransfer category: 'Portfolio2-Ejercicio'!
TransferOperations subclass: #ExtractionTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!ExtractionTransfer methodsFor: 'balance' stamp: 'EMI 11/9/2020 20:04:09'!
affectBalance: aBalance
	^aBalance - transfer value.! !


!ExtractionTransfer methodsFor: 'reports' stamp: 'EMI 11/12/2020 21:19:03'!
reportTo: aReport
	^aReport reportExtractionTransferTransaction: self.! !


!classDefinition: #Withdraw category: 'Portfolio2-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'reports' stamp: 'EMI 11/12/2020 21:22:21'!
reportTo: aReport
	^aReport reportWithdrawTransaction: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio2-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: 'Portfolio2-Ejercicio'!
Object subclass: #Report
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Report methodsFor: 'reporting - private' stamp: 'EMI 11/16/2020 00:00:43'!
beginReportPortfolio: aPortfolio.
	self subclassResponsibility.! !

!Report methodsFor: 'reporting - private' stamp: 'EMI 11/16/2020 00:00:50'!
endReportPortfolio: aPortfolio.
	self subclassResponsibility.! !

!Report methodsFor: 'reporting - private' stamp: 'EMI 11/13/2020 20:56:22'!
reportDepositTransaction: aDepositTransaction
	^self subclassResponsibility.! !

!Report methodsFor: 'reporting - private' stamp: 'EMI 11/12/2020 21:54:07'!
reportDepositTransferTransaction: aDepositTransferTransaction
	^self subclassResponsibility.! !

!Report methodsFor: 'reporting - private' stamp: 'EMI 11/12/2020 21:54:20'!
reportExtractionTransferTransaction: aExtractionTransferTransaction
	^self subclassResponsibility.! !

!Report methodsFor: 'reporting - private' stamp: 'EMI 11/16/2020 16:02:00'!
reportReceptiveAccount: anAccount.
	self subclassResponsibility.! !

!Report methodsFor: 'reporting - private' stamp: 'EMI 11/12/2020 21:53:17'!
reportWithdrawTransaction: aWithdrawTransaction
	^self subclassResponsibility.! !


!Report methodsFor: 'reporting' stamp: 'EMI 11/12/2020 21:52:41'!
report
	^self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'Portfolio2-Ejercicio'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'initialization' stamp: 'EMI 11/12/2020 21:55:36'!
of: aAccount 
	^self new initializeOf: aAccount ! !


!Report class methodsFor: 'as yet unclassified' stamp: 'EMI 11/16/2020 16:24:30'!
identationSpacesPerLevel
	^3.! !


!classDefinition: #AccountSpecialReport category: 'Portfolio2-Ejercicio'!
Report subclass: #AccountSpecialReport
	instanceVariableNames: 'summaryCollection currentIdentationLevel'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!AccountSpecialReport methodsFor: 'initialization' stamp: 'EMI 11/15/2020 23:19:54'!
initializeOf: anAccount
	account _ anAccount.! !


!AccountSpecialReport methodsFor: 'reporting - private' stamp: 'EMI 11/16/2020 16:24:47'!
beginReportPortfolio: aPortfolio 
	summaryCollection add: (('Portfolio de ', aPortfolio accountName) identByAmount: currentIdentationLevel).
	currentIdentationLevel _ currentIdentationLevel + self class identationSpacesPerLevel.! !

!AccountSpecialReport methodsFor: 'reporting - private' stamp: 'EMI 11/16/2020 16:24:54'!
endReportPortfolio: aPortfolio.
	summaryCollection add: (('Balance = ', aPortfolio balance asString) identByAmount: currentIdentationLevel).
	currentIdentationLevel _ currentIdentationLevel - self class identationSpacesPerLevel.! !

!AccountSpecialReport methodsFor: 'reporting - private' stamp: 'EMI 11/15/2020 23:49:45'!
reportDepositTransaction: aDepositTransaction! !

!AccountSpecialReport methodsFor: 'reporting - private' stamp: 'EMI 11/15/2020 23:49:56'!
reportDepositTransferTransaction: aDepositTransferTransaction! !

!AccountSpecialReport methodsFor: 'reporting - private' stamp: 'EMI 11/15/2020 23:50:07'!
reportExtractionTransferTransaction: aExtractionTransferTransaction! !

!AccountSpecialReport methodsFor: 'reporting - private' stamp: 'EMI 11/16/2020 16:25:15'!
reportReceptiveAccount: aReceptiveAccount 
	| summary summaryReport|
	summaryCollection add: (('Cuenta de ', aReceptiveAccount accountName) identByAmount: currentIdentationLevel).
	
	summary _ AccountSummaryReport of: aReceptiveAccount.
	summaryReport _ summary report.
	summaryReport do: [:aSummaryLine | summaryCollection add: (aSummaryLine identByAmount: (currentIdentationLevel + self class identationSpacesPerLevel))].! !

!AccountSpecialReport methodsFor: 'reporting - private' stamp: 'EMI 11/15/2020 23:50:18'!
reportWithdrawTransaction: aWithdrawTransaction! !


!AccountSpecialReport methodsFor: 'reporting' stamp: 'EMI 11/16/2020 16:06:07'!
report
       summaryCollection _ OrderedCollection new.
	currentIdentationLevel _ 0.
	account reportTo: self.
	^summaryCollection.! !


!classDefinition: #AccountSummaryReport category: 'Portfolio2-Ejercicio'!
Report subclass: #AccountSummaryReport
	instanceVariableNames: 'summaryCollection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!AccountSummaryReport methodsFor: 'initialization' stamp: 'EMI 11/9/2020 21:28:29'!
initializeOf: aReceptiveAccount
	account _ aReceptiveAccount.! !


!AccountSummaryReport methodsFor: 'reporting' stamp: 'EMI 11/15/2020 22:54:53'!
report
	summaryCollection _ OrderedCollection new.
	account reportTo: self.
	summaryCollection add: 'Balance = ', account balance asString, '.'.
	^summaryCollection.! !


!AccountSummaryReport methodsFor: 'reporting - private' stamp: 'EMI 11/16/2020 00:00:43'!
beginReportPortfolio: aPortfolio ! !

!AccountSummaryReport methodsFor: 'reporting - private' stamp: 'EMI 11/16/2020 00:01:00'!
endReportPortfolio: aPortfolio.! !

!AccountSummaryReport methodsFor: 'reporting - private' stamp: 'EMI 11/15/2020 22:55:13'!
reportDepositTransaction: aDepositTransaction
	summaryCollection add: ('Depósito por ', aDepositTransaction value asString, '.').! !

!AccountSummaryReport methodsFor: 'reporting - private' stamp: 'EMI 11/15/2020 22:55:54'!
reportDepositTransferTransaction: aDepositTransferTransaction
	summaryCollection add: ('Entrada por transferencia de ', aDepositTransferTransaction value asString, '.')! !

!AccountSummaryReport methodsFor: 'reporting - private' stamp: 'EMI 11/15/2020 22:55:35'!
reportExtractionTransferTransaction: aExtractionTransferTransaction
	summaryCollection add: ('Salida por transferencia de ', aExtractionTransferTransaction value asString, '.')! !

!AccountSummaryReport methodsFor: 'reporting - private' stamp: 'EMI 11/16/2020 16:02:00'!
reportReceptiveAccount: aReceptiveAccount! !

!AccountSummaryReport methodsFor: 'reporting - private' stamp: 'EMI 11/15/2020 22:55:46'!
reportWithdrawTransaction: aWithdrawTransaction
	summaryCollection add: ('Extracción por ', aWithdrawTransaction value asString, '.')! !


!classDefinition: #NetTransfersReport category: 'Portfolio2-Ejercicio'!
Report subclass: #NetTransfersReport
	instanceVariableNames: 'transfersCollection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!NetTransfersReport methodsFor: 'initialization' stamp: 'EMI 11/13/2020 19:53:03'!
initializeOf: aAccount 
	account := aAccount.! !


!NetTransfersReport methodsFor: 'reporting' stamp: 'EMI 11/15/2020 23:01:06'!
report
	transfersCollection _ OrderedCollection new.
	account reportTo: self.
	^transfersCollection sum: [:aTransferAmount | aTransferAmount] ifEmpty: [0].
	! !


!NetTransfersReport methodsFor: 'reporting - private' stamp: 'EMI 11/16/2020 00:00:43'!
beginReportPortfolio: aPortfolio! !

!NetTransfersReport methodsFor: 'reporting - private' stamp: 'EMI 11/16/2020 00:01:05'!
endReportPortfolio: aPortfolio.! !

!NetTransfersReport methodsFor: 'reporting - private' stamp: 'EMI 11/15/2020 23:01:30'!
reportDepositTransaction: aDepositTransaction
	transfersCollection add: 0.! !

!NetTransfersReport methodsFor: 'reporting - private' stamp: 'EMI 11/15/2020 23:01:53'!
reportDepositTransferTransaction: aDepositTransferTransaction
	transfersCollection add: aDepositTransferTransaction value.! !

!NetTransfersReport methodsFor: 'reporting - private' stamp: 'EMI 11/15/2020 23:01:57'!
reportExtractionTransferTransaction: aExtractionTransferTransaction
	transfersCollection add: aExtractionTransferTransaction value negated.! !

!NetTransfersReport methodsFor: 'reporting - private' stamp: 'EMI 11/16/2020 16:02:00'!
reportReceptiveAccount: aReceptiveAccount ! !

!NetTransfersReport methodsFor: 'reporting - private' stamp: 'EMI 11/15/2020 23:02:06'!
reportWithdrawTransaction: aWithdrawTransaction
	transfersCollection add: 0! !


!classDefinition: #PortfolioStructureReport category: 'Portfolio2-Ejercicio'!
Report subclass: #PortfolioStructureReport
	instanceVariableNames: 'reportCollection currentIdentationLevel'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!PortfolioStructureReport methodsFor: 'initialization' stamp: 'EMI 11/15/2020 18:37:17'!
initializeOf: anAccount
	account _ anAccount.! !


!PortfolioStructureReport methodsFor: 'reporting' stamp: 'EMI 11/16/2020 16:05:55'!
report
	reportCollection _ OrderedCollection new.
	currentIdentationLevel _ 0.
	account reportTo: self.
	^reportCollection.! !


!PortfolioStructureReport methodsFor: 'reporting - private' stamp: 'EMI 11/16/2020 16:25:01'!
beginReportPortfolio: aPortfolio
	reportCollection add: (('Portfolio de ', aPortfolio accountName) identByAmount: currentIdentationLevel).
	currentIdentationLevel _ currentIdentationLevel + self class identationSpacesPerLevel.! !

!PortfolioStructureReport methodsFor: 'reporting - private' stamp: 'EMI 11/16/2020 16:25:05'!
endReportPortfolio: aPortfolio.
	currentIdentationLevel _ currentIdentationLevel - self class identationSpacesPerLevel.! !

!PortfolioStructureReport methodsFor: 'reporting - private' stamp: 'EMI 11/15/2020 22:25:50'!
reportDepositTransaction: aDepositTransaction! !

!PortfolioStructureReport methodsFor: 'reporting - private' stamp: 'EMI 11/15/2020 22:49:28'!
reportDepositTransferTransaction: aDepositTransferTransactions! !

!PortfolioStructureReport methodsFor: 'reporting - private' stamp: 'EMI 11/15/2020 22:49:42'!
reportExtractionTransferTransaction: aExtractionTransferTransaction! !

!PortfolioStructureReport methodsFor: 'reporting - private' stamp: 'EMI 11/16/2020 16:22:05'!
reportReceptiveAccount: aReceptiveAccount
	reportCollection add: (('Cuenta de ', aReceptiveAccount accountName) identByAmount: currentIdentationLevel).! !

!PortfolioStructureReport methodsFor: 'reporting - private' stamp: 'EMI 11/15/2020 22:49:54'!
reportWithdrawTransaction: aWithdrawTransaction! !


!classDefinition: #Transfer category: 'Portfolio2-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'origin destination amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Transfer methodsFor: 'participants' stamp: 'EMI 11/9/2020 20:57:41'!
destination
	^destination! !

!Transfer methodsFor: 'participants' stamp: 'EMI 11/9/2020 20:57:32'!
origin
	^origin! !


!Transfer methodsFor: 'accessing' stamp: 'EMI 11/9/2020 20:57:22'!
value
	^amount! !


!Transfer methodsFor: 'initialize' stamp: 'EMI 11/9/2020 21:00:12'!
initializeFor: aPositiveNumber withOrigin: anOriginReceptiveAccount withDestination: aDestinationReceptiveAccount
	amount _ aPositiveNumber.
	origin _ anOriginReceptiveAccount.
	destination _ aDestinationReceptiveAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio2-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'EMI 11/9/2020 21:15:45'!
cannotTransferInvalidAmountMessage
	^'Cannot transfer invalid amount.'.! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'EMI 11/9/2020 21:21:56'!
cannotTransferWhenOriginAndDestinationAreSame
	^'Cannot transfer when origin and destination ase the same.'! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'EMI 11/9/2020 21:22:05'!
from: anOriginReceptiveAccount to: aDestinationReceptiveAccount amount: aPositiveNumber
	| instance |
	
	anOriginReceptiveAccount = aDestinationReceptiveAccount ifTrue: [^Error signal: self cannotTransferWhenOriginAndDestinationAreSame].
	aPositiveNumber > 0 ifFalse: [^Error signal: self cannotTransferInvalidAmountMessage].
	
	instance _ self new initializeFor: aPositiveNumber withOrigin: anOriginReceptiveAccount withDestination: aDestinationReceptiveAccount.
	anOriginReceptiveAccount register: (ExtractionTransfer fromTransfer: instance).
	aDestinationReceptiveAccount register: (DepositTransfer fromTransfer: instance).
	^instance.! !
