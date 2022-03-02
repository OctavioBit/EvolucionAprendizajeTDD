!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'private' stamp: 'ET 5/25/2021 02:15:09'!
portfolioWithOneAccountWith100Deposit

	|portfolio|
	
	portfolio := Portfolio new.
	
	portfolio addFinancialEntity: self receptiveAccountWith100Deposit.
	
	
	^portfolio! !

!PortfolioTest methodsFor: 'private' stamp: 'ET 5/25/2021 01:53:02'!
receptiveAccountWith100Deposit

	|account|
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	^account.! !


!PortfolioTest methodsFor: 'portfolio structure tests' stamp: 'ET 6/3/2021 01:01:16'!
test26PortfolioStructureReportOfNewPortfolioHasAName

	| portfolio |
	
	portfolio := Portfolio named: 'portfolio de la familia'.
	
	self assert: (PortfolioStructureReport for: portfolio) includes: 'portfolio de la familia'.
! !

!PortfolioTest methodsFor: 'portfolio structure tests' stamp: 'ET 6/3/2021 01:01:00'!
test27PortfolioStructureReportOfNewPortfolioHasTheNameOfThePortfolio

	| portfolio |
	
	portfolio := Portfolio named: 'portfolio de la ciudad'.
	
	self assert: (PortfolioStructureReport for: portfolio) includes: 'portfolio de la ciudad'.
! !

!PortfolioTest methodsFor: 'portfolio structure tests' stamp: 'ET 6/3/2021 01:01:39'!
test28PortfolioWithAccountStructureReport

	| portfolio account report|
	
	portfolio := Portfolio named: 'portfolio de la familia'.
	
	account := ReceptiveAccount named: 'cuenta de pepe'.
	
	portfolio addFinancialEntity: account.
	
	report := PortfolioStructureReport for: portfolio.
	
	self assert: report first equals: 'portfolio de la familia'.
	report removeFirst.
	self assert: report first equals: String tab, 'cuenta de pepe'.! !

!PortfolioTest methodsFor: 'portfolio structure tests' stamp: 'ET 6/3/2021 01:01:55'!
test29PortfolioWithTwoAccountsStructureReport

	| portfolio accountPepe accountPepa report|
	
	portfolio := Portfolio named: 'portfolio de la familia'.
	
	accountPepe := ReceptiveAccount named: 'cuenta de pepe'.
	
	accountPepa := ReceptiveAccount named: 'cuenta de pepa'.
	
	portfolio addFinancialEntity: accountPepe.
	
	portfolio addFinancialEntity: accountPepa.
	
	report := PortfolioStructureReport for: portfolio.
	
	self assert: report first equals: 'portfolio de la familia'.
	report removeFirst.
	self assert: report first equals: String tab, 'cuenta de pepe'.
	report removeFirst.
	self assert: report first equals: String tab, 'cuenta de pepa'.
	! !


!PortfolioTest methodsFor: 'summary report tests' stamp: 'ET 6/2/2021 23:36:01'!
test20SummaryReportOfNewPortfolio

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: (AccountSummaryReport for: portfolio) includes: 'Balance = 0'
! !

!PortfolioTest methodsFor: 'summary report tests' stamp: 'ET 6/2/2021 23:36:24'!
test21SummaryReportOfPortfolioWithTwoAccounts

	|portfolio report |
	
	portfolio := self portfolioWithOneAccountWith100Deposit.
	portfolio addFinancialEntity: self receptiveAccountWith100Deposit .
	
	report := AccountSummaryReport for: portfolio.
	
	self assert: 5 equals: report size.
	self assert: 'Balance = 200' equals: report last.
	report removeLast.	
	self assert: 'Balance = 100' equals: report last.
	report removeLast.
	self assert: 'Depósito por 100' equals: report last.
	report removeLast.
	self assert: 'Balance = 100' equals: report last.
	report removeLast.
	self assert: 'Depósito por 100' equals: report last.! !


!PortfolioTest methodsFor: 'transfer net report tests' stamp: 'ET 6/2/2021 23:37:00'!
test22TransferNetReportOfPortfolioWithAParticipantOfATransfer

	| portfolio accountOrigen accountDestino|
	
	portfolio := Portfolio new.
	accountOrigen := ReceptiveAccount new.
	accountDestino := ReceptiveAccount new.
	portfolio addFinancialEntity: accountDestino.
	
	Transfer from: accountOrigen to: accountDestino amount: 100.
	
	self assert: 100 equals: (TransferNetReport for: portfolio).
! !

!PortfolioTest methodsFor: 'transfer net report tests' stamp: 'ET 6/2/2021 23:37:19'!
test23TransferNetReportOfNewPortfolio

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: 0 equals: (TransferNetReport for: portfolio).
! !


!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 01:24:04'!
test01NewPortfolioHasZeroBalance

	|portfolio|
	
	portfolio := Portfolio new.
	
	self assert: 0 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 02:13:53'!
test02PortfolioWithOneAccountHasTheSameBalanceAsTheAccount

	|portfolio|
	
	portfolio := self portfolioWithOneAccountWith100Deposit.
	
	self assert: 100 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 02:15:38'!
test03PortfolioWithTwoAccountsHasBalanceTheSumOfTheBalancesOfItsAccounts

	|portfolio|
	
	portfolio := self portfolioWithOneAccountWith100Deposit.
	portfolio addFinancialEntity: self receptiveAccountWith100Deposit.
	
	self assert: 200 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 01:30:49'!
test04PortfolioRegistersTransactionsOfItsOnlyAddedAccount

	|portfolio account deposit|
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	
	portfolio addFinancialEntity: account.
	
	
	self assert: (portfolio hasRegistered: deposit).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 01:34:40'!
test05PortfolioHasOnlyRegisteredTransactionsOfItsAccounts

	|portfolio account deposit|
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	deposit := Deposit for: 100.
	
	portfolio addFinancialEntity: account.
	
	
	self deny: (portfolio hasRegistered: deposit).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 02:16:43'!
test06PortfolioRegistersTransactionsOfAllOfItsAccounts

	|portfolio account  deposit|
	
	portfolio := self portfolioWithOneAccountWith100Deposit.
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: account.
	
	portfolio addFinancialEntity: account.
	
	
	self assert: (portfolio hasRegistered: deposit).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 02:17:15'!
test07PortfolioKnowsTransactionOfItsOnlyAccount

	|portfolio account deposit|
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.

	deposit := Deposit register: 100 on: account.
	
	portfolio addFinancialEntity: account.
		
	self assert: 1 equals: portfolio transactions size.
	self assert: (portfolio transactions includes: deposit).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 01:51:01'!
test08PortfolioKnowsTransactionOfAllOfItsAccounts

	|portfolio account1 account2 deposit withdraw |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	
	account2 := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: account1.
	
	withdraw := Withdraw register: 100 on: account2.
	
	portfolio addFinancialEntity: account1.
	portfolio addFinancialEntity: account2.
		
	self assert: 2 equals: portfolio transactions size.
	self assert: (portfolio transactions includes: deposit).
	self assert: (portfolio transactions includes: withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 01:35:18'!
test09PortfolioWithEmptyPortfolioHasZeroBalance

	|portfolioParent portfolioChild|
	
	portfolioParent := Portfolio new.
	
	portfolioChild := Portfolio new.
	
	portfolioParent addFinancialEntity: portfolioChild.
	
	
		
	self assert: 0 equals: portfolioParent balance.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 02:19:11'!
test10PortfolioWithNonEmptyPortfolioHasItsBalance

	|portfolioParent portfolioChild|
	
	portfolioParent := Portfolio new.
	
	portfolioChild := self portfolioWithOneAccountWith100Deposit.
	
	portfolioParent addFinancialEntity: portfolioChild.
	
	
		
	self assert: 100 equals: portfolioParent balance.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 02:19:40'!
test11PortfolioWithTwoPortfoliosHasBalanceTheSumOfTheBalancesOfItsPortfolios

	|portfolioParent portfolioChild1 portfolioChild2|
	
	portfolioParent := Portfolio new.
	
	portfolioChild1 := self portfolioWithOneAccountWith100Deposit.
	
	portfolioChild2 := self portfolioWithOneAccountWith100Deposit.
	
	portfolioParent addFinancialEntity: portfolioChild1.
	
	portfolioParent addFinancialEntity: portfolioChild2.
	
	
		
	self assert: 200 equals: portfolioParent balance.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 02:20:26'!
test12PortfolioWithAnAccountAndAPortfolioHasBalanceSumOfItsEntitiesBalance

	|portfolioParent portfolioChild|
	
	portfolioParent := self portfolioWithOneAccountWith100Deposit.
	
	portfolioChild := Portfolio new.
	
	portfolioParent addFinancialEntity: portfolioChild.
	
		
	self assert: 100 equals: portfolioParent balance.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 01:40:44'!
test13PortfolioWithNonEmptyPortfolioKnowsRegisteredTransactionsOfItsAccounts

	|portfolioParent portfolioChild account deposit|
	
	portfolioParent := Portfolio new.
	
	portfolioChild := Portfolio new.
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	
	portfolioChild addFinancialEntity: account.
	
	portfolioParent addFinancialEntity: portfolioChild.
	
	
	self assert: (portfolioParent hasRegistered: deposit).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 01:51:17'!
test14PortfolioWithNonEmptyPortfolioKnowsTransactionsOfItsAccounts

	|portfolioParent portfolioChild account deposit |
	
	portfolioParent := Portfolio new.
	
	portfolioChild := Portfolio new.
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: account.
	
	portfolioChild addFinancialEntity: account.
	
	portfolioParent addFinancialEntity: portfolioChild.
		
	self assert: 1 equals: portfolioParent transactions size.
	self assert: (portfolioParent transactions includes: deposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 01:41:16'!
test15CannotAddAlreadyAddedAccount

	|portfolio account|
	
	portfolio:= Portfolio new.
	
	account := ReceptiveAccount new.
	
	portfolio addFinancialEntity: account.
	
	self should:[portfolio addFinancialEntity: account]
	raise: Error 
	withExceptionDo: [ :anError | self assert: anError messageText equals: (Portfolio canNotAddAlreadyAddedFinancialEntity) ].! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 01:45:15'!
test16PortfolioXWithNonEmptyPortfolioYCannotAddAccountsOfItsPortfolioY

	|portfolioParent portfolioChild account|
	
	portfolioParent := Portfolio new.
	
	portfolioChild := Portfolio new.
	
	account := ReceptiveAccount new.
	
	portfolioChild addFinancialEntity: account.
	
	portfolioParent addFinancialEntity: portfolioChild.
	
	self should:[portfolioParent addFinancialEntity: account]
	raise: Error 
	withExceptionDo: [ :anError | self assert: anError messageText equals: (Portfolio canNotAddAlreadyAddedFinancialEntity) ].! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 01:47:26'!
test17CannotAddPortfolioWithAccountsAlreadyInside

	|portfolioParent portfolioChild portfolioChild2 account|
	
	portfolioParent := Portfolio new.
	
	portfolioChild := Portfolio new.
	
	portfolioChild2 := Portfolio new.
	
	account := ReceptiveAccount new.
	
	portfolioChild addFinancialEntity: account.
	
	portfolioChild2 addFinancialEntity: account.
	
	portfolioParent addFinancialEntity: portfolioChild.
	
	
	self should:[portfolioParent addFinancialEntity: portfolioChild2]
	raise: Error 
	withExceptionDo: [ :anError | self assert: anError messageText equals: (Portfolio canNotAddAlreadyAddedFinancialEntity) ].! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 01:48:41'!
test18CannotAddAccountThatHasBeenAddedByAParentPortfolio

	|portfolioParent portfolioChild account|
	
	portfolioParent := Portfolio new.
	
	account := ReceptiveAccount new.
	
	portfolioParent addFinancialEntity: account.
	
	portfolioChild := Portfolio new.
	
	portfolioParent addFinancialEntity: portfolioChild.
	
	
	self should:[portfolioChild addFinancialEntity: account]
	raise: Error 
	withExceptionDo: [ :anError | self assert: anError messageText equals: (Portfolio canNotAddAlreadyAddedFinancialEntity) ].! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 5/25/2021 01:49:15'!
test19CannotAddItself

	|portfolio|
	
	portfolio := Portfolio new.
	
	
	self should:[portfolio addFinancialEntity: portfolio]
	raise: Error 
	withExceptionDo: [ :anError | self assert: anError messageText equals: (Portfolio canNotAddAlreadyAddedFinancialEntity) ].! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 6/3/2021 00:08:44'!
test24PortfolioCanBeNamed

	| portfolio |
	
	portfolio := Portfolio named: 'portfolio'.

	
	self assert: 'portfolio' equals: portfolio name.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'ET 6/3/2021 00:15:02'!
test25PortfolioNameIsWhatItWasNamed

	| portfolio |
	
	portfolio := Portfolio named: 'otroPortfolio'.

	
	self assert: 'otroPortfolio' equals: portfolio name.
! !


!PortfolioTest methodsFor: 'special summary report tests' stamp: 'ET 6/3/2021 02:09:08'!
test26SpecialSummaryReportOfNewPortfolio

	| portfolio report |
	
	portfolio := Portfolio named: 'cuenta de la familia'.

	report := SpecialSummaryReport for: portfolio.
	
	self assert: report includes: 'cuenta de la familia'.
	self assert: report includes: String tab, 'Balance = 0'.
	
! !

!PortfolioTest methodsFor: 'special summary report tests' stamp: 'ET 6/3/2021 02:09:45'!
test27SpecialSummaryReportOfPortfolioHasItsName

	| portfolio report |
	
	portfolio := Portfolio named: 'cuenta de la ciudad'.

	report := SpecialSummaryReport for: portfolio.
	
	self assert: report includes: 'cuenta de la ciudad'.
	self assert: report includes: String tab, 'Balance = 0'.
	
! !

!PortfolioTest methodsFor: 'special summary report tests' stamp: 'ET 6/3/2021 02:10:09'!
test28SpecialSummaryReportOfPortfolioWithNewAccount

	| portfolio account report |
	
	portfolio := Portfolio named: 'cuenta de la familia'.
	
	account := ReceptiveAccount named: 'cuenta de pepe'.
	
	portfolio addFinancialEntity: account.

	report := SpecialSummaryReport for: portfolio.
	
	
	self assert: report first equals: 'cuenta de la familia'.
	report removeFirst.
	self assert: report first equals: String tab, 'cuenta de pepe'.
	report removeFirst.
	self assert: report first equals: String tab, String tab, 'Balance = 0'.
	report removeFirst.
	self assert: report first equals: String tab, 'Balance = 0'.
	
! !

!PortfolioTest methodsFor: 'special summary report tests' stamp: 'ET 6/3/2021 02:16:20'!
test29SpecialSummaryReportOfPortfolioWithAccountWithRegisteredDeposit

	| portfolio account report |
	
	portfolio := Portfolio named: 'cuenta de la familia'.
	
	account := ReceptiveAccount named: 'cuenta de pepe'.
	Deposit register: 100  on: account.
	
	portfolio addFinancialEntity: account.

	report := SpecialSummaryReport for: portfolio.
	
	
	self assert: report last equals: String tab, 'Balance = 100'.
	
! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'summary report tests' stamp: 'ET 6/2/2021 23:24:31'!
test08SummaryReportWithNewReceptiveAccount

	| account |
	
	account := ReceptiveAccount new.
	
	self assert: (AccountSummaryReport for: account)  includes: 'Balance = 0'
! !

!ReceptiveAccountTest methodsFor: 'summary report tests' stamp: 'ET 6/2/2021 23:25:03'!
test09SummaryReportWithReceptiveAccountWithADeposit

	| account |
	
	account := ReceptiveAccount new.
	
	Deposit register: 100 on: account. 
	
	self assert: (AccountSummaryReport for: account) includes: 'Depósito por 100'
! !

!ReceptiveAccountTest methodsFor: 'summary report tests' stamp: 'ET 6/2/2021 23:25:24'!
test10SummaryReportWithReceptiveAccountWithAWithdraw

	| account |
	
	account := ReceptiveAccount new.
	
	Withdraw register: 50 on: account. 
	
	self assert: (AccountSummaryReport for: account) includes: 'Extracción por 50'
! !

!ReceptiveAccountTest methodsFor: 'summary report tests' stamp: 'ET 6/2/2021 23:25:53'!
test11SummaryReportWithReceptiveAccountWithDepositAndWithdraw

	| account |
	
	account := ReceptiveAccount new.
	
	Withdraw register: 50 on: account. 
	Deposit register: 100 on: account. 
	
	self assert: (AccountSummaryReport for: account) includes: 'Extracción por 50'.
	self assert: (AccountSummaryReport for: account) includes: 'Depósito por 100'.
	self assert: (AccountSummaryReport for: account) includes: 'Balance = 50'.! !

!ReceptiveAccountTest methodsFor: 'summary report tests' stamp: 'ET 6/2/2021 23:26:38'!
test12SummaryReportOOfBothAccountsInATransfer

	| accountDestino accountOrigen |
	
	accountOrigen := ReceptiveAccount new.
	accountDestino := ReceptiveAccount new.
	
	Transfer from:accountOrigen to:accountDestino amount: 100.
	
	self assert: (AccountSummaryReport for: accountOrigen) includes: 'Salida por transferencia de 100'.
	self assert: (AccountSummaryReport for: accountDestino) includes: 'Entrada por transferencia de 100'.
	self assert: (AccountSummaryReport for: accountOrigen) includes: 'Balance = -100'.
	self assert: (AccountSummaryReport for: accountDestino) includes: 'Balance = 100'.	! !

!ReceptiveAccountTest methodsFor: 'summary report tests' stamp: 'ET 6/2/2021 23:27:06'!
test13BalanceIsAtTheEndOfSummaryReport

	| account |
	
	account := ReceptiveAccount new.
	
	Deposit register: 100 on: account. 
	
	self assert: 'Balance = 100' equals: (AccountSummaryReport for: account) last .
! !


!ReceptiveAccountTest methodsFor: 'transfer net report tests' stamp: 'ET 6/2/2021 23:27:39'!
test14TransferNetReportWithNewReceptiveAccount

	| account |
	
	account := ReceptiveAccount new.
	
	self assert: 0 equals: (TransferNetReport for: account).
! !

!ReceptiveAccountTest methodsFor: 'transfer net report tests' stamp: 'ET 6/2/2021 23:34:55'!
test15TransferNetReportOfBothAccountsInATransfer

	| accountDestino accountOrigen |
	
	accountDestino := ReceptiveAccount new.
	accountOrigen := ReceptiveAccount new.
	Transfer from: accountOrigen to: accountDestino amount: 100.
	
	self assert: 100 equals: (TransferNetReport for: accountDestino).
	self assert: -100 equals: (TransferNetReport for: accountOrigen).
! !

!ReceptiveAccountTest methodsFor: 'transfer net report tests' stamp: 'ET 6/2/2021 23:35:40'!
test16NonTransferTransactionsDoesNotModifyTransferNetReport

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100  on: account. 
	
	self assert: 0 equals: (TransferNetReport for: account).
! !


!ReceptiveAccountTest methodsFor: 'special summary report tests' stamp: 'ET 6/3/2021 02:06:16'!
test19SpecialSummaryReportOfNewReceptiveAccount

	| account report |
	
	account := ReceptiveAccount named: 'cuenta de pepe'.
	
	report := SpecialSummaryReport for: account.
	
	self assert: report first equals: 'cuenta de pepe'.
	report removeFirst.
	self assert: report includes: String tab, 'Balance = 0'.
! !

!ReceptiveAccountTest methodsFor: 'special summary report tests' stamp: 'ET 6/3/2021 02:06:55'!
test20SpecialSummaryReportHasNameOfTheAccount

	| account report |
	
	account := ReceptiveAccount named: 'cuenta de pepa'.
	
	report := SpecialSummaryReport for: account.
	
	self assert: report first equals: 'cuenta de pepa'.
	report removeFirst.
	self assert: report includes: String tab, 'Balance = 0'.
! !

!ReceptiveAccountTest methodsFor: 'special summary report tests' stamp: 'ET 6/3/2021 02:08:10'!
test21SpecialSummaryReportOfAccountWithDeposit

	| account report |
	
	account := ReceptiveAccount named: 'cuenta de pepe'.
	Deposit register: 100 on: account.
	
	report := SpecialSummaryReport for: account.
	
	self assert: report first equals: 'cuenta de pepe'.
	report removeFirst.
	self assert: report first equals: String tab, 'Depósito por 100'.
	report removeFirst.
	self assert: report includes: String tab, 'Balance = 100'.
! !

!ReceptiveAccountTest methodsFor: 'special summary report tests' stamp: 'ET 6/3/2021 02:08:27'!
test22SpecialSummaryReportOfAccountWithWithdraw

	| account report |
	
	account := ReceptiveAccount named: 'cuenta de pepe'.
	Withdraw register: 100 on: account.
	
	report := SpecialSummaryReport for: account.
	
	self assert: report first equals: 'cuenta de pepe'.
	report removeFirst.
	self assert: report first equals: String tab, 'Extracción por 100'.
	report removeFirst.
	self assert: report includes: String tab, 'Balance = -100'.
! !

!ReceptiveAccountTest methodsFor: 'special summary report tests' stamp: 'ET 6/3/2021 02:08:43'!
test23SpecialSummaryReportOfBothAccountsInTransfer

	| accountDestino accountOrigen reportDestino reportOrigen |
	
	accountDestino := ReceptiveAccount named: 'cuenta de pepe'.
	accountOrigen := ReceptiveAccount named: 'cuenta de pepa'.
	Transfer from: accountOrigen  to: accountDestino  amount: 100.
	
	reportDestino := SpecialSummaryReport for: accountDestino.
	reportOrigen := SpecialSummaryReport for: accountOrigen.
	
	
	self assert: (reportOrigen at: 2) equals: String tab, 'Salida por extracción de 100'.
	self assert: reportOrigen last equals: String tab, 'Balance = -100'.
	
	self assert: (reportDestino at: 2) equals: String tab, 'Entrada por depósito de 100'.
	self assert: reportDestino last equals: String tab, 'Balance = 100'.! !


!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ET 6/2/2021 23:57:10'!
test17ReceptiveAccountCanBeNamed

	| account |
	
	account := ReceptiveAccount named: 'cuenta'.

	
	self assert: 'cuenta' equals: account name.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ET 6/3/2021 00:04:54'!
test18ReceptiveAccountNameIsWhatItWasNamed

	| account |
	
	account := ReceptiveAccount named: 'otro'.

	
	self assert: 'otro' equals: account name.
! !


!classDefinition: #TransferTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferTest methodsFor: 'tests' stamp: 'ET 6/2/2021 23:16:03'!
test01TransferChangesBalanceOfBothParticipantAccounts
	| accountDestino accountOrigen |
	accountOrigen := ReceptiveAccount new.
	accountDestino := ReceptiveAccount new.
	
	Transfer from:accountOrigen to:accountDestino amount: 100.
	
	self assert: 100 equals: (accountDestino balance).
	self assert: -100 equals: (accountOrigen balance).
	! !

!TransferTest methodsFor: 'tests' stamp: 'ET 6/2/2021 23:16:32'!
test02CanNotTransferWithZeroAmount
	| accountDestino accountOrigen |
	accountOrigen := ReceptiveAccount new.
	accountDestino := ReceptiveAccount new.
		
	self should:[Transfer from:accountOrigen to:accountDestino amount: 0.]
	raise: Error 
	withExceptionDo: [ :anError | self assert: anError messageText equals: (Transfer canNotTransferWithInvalidAmount) ].
	! !

!TransferTest methodsFor: 'tests' stamp: 'ET 6/2/2021 23:16:51'!
test03CanNotTransferNegativeAmount
	| accountDestino accountOrigen |
	accountOrigen := ReceptiveAccount new.
	accountDestino := ReceptiveAccount new.
		
	self should:[Transfer from:accountOrigen to:accountDestino amount: -100.]
	raise: Error 
	withExceptionDo: [ :anError | self assert: anError messageText equals: (Transfer canNotTransferWithInvalidAmount) ].
	! !

!TransferTest methodsFor: 'tests' stamp: 'ET 6/2/2021 23:17:47'!
test04TransferLegsAreRegisteredTransactionsOfItsParticipants
	| accountDestino accountOrigen aTransfer |
	accountOrigen := ReceptiveAccount new.
	accountDestino := ReceptiveAccount new.
	
	aTransfer := Transfer from:accountOrigen to:accountDestino amount: 100.
	
	self assert: (accountOrigen hasRegistered: (aTransfer withdraw)).
	self assert: (accountDestino hasRegistered: (aTransfer deposit)).
	! !

!TransferTest methodsFor: 'tests' stamp: 'ET 6/2/2021 23:20:11'!
test05CanTravelBetweenTransferAndItsLegs
	| accountDestino accountOrigen aTransfer |
	accountOrigen := ReceptiveAccount new.
	accountDestino := ReceptiveAccount new.
	
	aTransfer := Transfer from:accountOrigen to:accountDestino amount: 100.
	
	self assert: (accountOrigen hasRegistered: (aTransfer deposit transfer withdraw)).
	self assert: (accountDestino hasRegistered: (aTransfer withdraw transfer deposit)).
	! !

!TransferTest methodsFor: 'tests' stamp: 'ET 6/2/2021 23:20:39'!
test06CanNotTransferBetweenTheSameAccount
	| account |
	account := ReceptiveAccount new.
		
	self should:[Transfer from:account to:account amount: 100.]
	raise: Error 
	withExceptionDo: [ :anError | self assert: anError messageText equals: (Transfer canNotTransferToTheSameAccount) ].
	! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'report' stamp: 'ET 6/2/2021 22:59:34'!
report: aReport

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'value' stamp: 'ET 5/22/2021 17:32:35'!
modifiesBalance: balance 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'report' stamp: 'ET 6/2/2021 02:44:07'!
report: aReport

	^aReport reportDeposit: self.

	! !


!Deposit methodsFor: 'value' stamp: 'ET 5/22/2021 17:32:09'!
modifiesBalance: balance

	^balance + value.! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferDeposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #TransferDeposit
	instanceVariableNames: 'transfer receptiveAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferDeposit methodsFor: 'initialization' stamp: 'JA 5/30/2021 18:45:23'!
initializeFor: aTransfer on: aReceptiveAccount 
	
	transfer := aTransfer.
	receptiveAccount := aReceptiveAccount.! !


!TransferDeposit methodsFor: 'value' stamp: 'JA 5/30/2021 18:53:15'!
modifiesBalance: balance

	^balance + transfer amount.! !

!TransferDeposit methodsFor: 'value' stamp: 'JA 5/30/2021 18:57:32'!
value	
	^transfer amount.! !


!TransferDeposit methodsFor: 'transfer' stamp: 'JA 5/30/2021 18:45:52'!
transfer
	
	^transfer! !


!TransferDeposit methodsFor: 'report' stamp: 'ET 6/2/2021 02:44:18'!
report: aReport

	^aReport reportTransferDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: 'Portfolio-Ejercicio'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'instance creation' stamp: 'JA 5/30/2021 18:45:03'!
for: aTransfer on: aReceptiveAccount 
	
	^self new initializeFor: aTransfer on: aReceptiveAccount ! !


!classDefinition: #TransferWithdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #TransferWithdraw
	instanceVariableNames: 'transfer receptiveAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferWithdraw methodsFor: 'report' stamp: 'ET 6/2/2021 02:44:30'!
report: aReport

	^aReport reportTransferWithdraw: self.! !


!TransferWithdraw methodsFor: 'initialization' stamp: 'JA 5/30/2021 18:44:37'!
initializeFor: aTransfer on: aReceptiveAccount 
	
	transfer := aTransfer.
	receptiveAccount := aReceptiveAccount.! !


!TransferWithdraw methodsFor: 'value' stamp: 'JA 5/30/2021 18:54:08'!
modifiesBalance: balance

	^balance - transfer amount.! !

!TransferWithdraw methodsFor: 'value' stamp: 'JA 5/30/2021 18:57:43'!
value	
	^transfer amount.! !


!TransferWithdraw methodsFor: 'transfer' stamp: 'JA 5/30/2021 18:47:09'!
transfer	
	^transfer.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: 'Portfolio-Ejercicio'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'instance creation' stamp: 'JA 5/30/2021 18:38:05'!
for: aTransfer on: aReceptiveAccount 

	^self new initializeFor: aTransfer on: aReceptiveAccount ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'report' stamp: 'ET 6/2/2021 02:44:39'!
report: aReport

	^aReport reportWithdraw: self.! !


!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'ET 5/22/2021 17:32:18'!
modifiesBalance: balance

	^balance - value.! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialEntity category: 'Portfolio-Ejercicio'!
Object subclass: #FinancialEntity
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialEntity methodsFor: 'balance' stamp: 'ET 5/22/2021 17:35:47'!
balance

	self subclassResponsibility.! !


!FinancialEntity methodsFor: 'name' stamp: 'ET 6/3/2021 00:12:38'!
name

	^name.! !


!FinancialEntity methodsFor: 'testing' stamp: 'ET 5/22/2021 17:36:18'!
hasRegistered: aTransaction

	self subclassResponsibility.! !

!FinancialEntity methodsFor: 'testing' stamp: 'ET 5/25/2021 01:19:55'!
includes: aFinancialEntity

	self subclassResponsibility.! !


!FinancialEntity methodsFor: 'report' stamp: 'ET 6/2/2021 23:05:18'!
report: aReport

	self subclassResponsibility.! !


!FinancialEntity methodsFor: 'transcations - private' stamp: 'ET 5/25/2021 01:21:27'!
putAllTransactionsInto: aTransactionsCollection

	self subclassResponsibility.! !


!FinancialEntity methodsFor: 'transactions' stamp: 'ET 5/22/2021 17:36:31'!
transactions

	self subclassResponsibility.! !


!FinancialEntity methodsFor: 'assertions' stamp: 'ET 5/25/2021 01:19:13'!
ensureItDoesntHaveAnythingOn: aPortfolio

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FinancialEntity class' category: 'Portfolio-Ejercicio'!
FinancialEntity class
	instanceVariableNames: ''!

!FinancialEntity class methodsFor: 'as yet unclassified' stamp: 'ET 5/22/2021 18:29:10'!
canNotAddAlreadyAddedFinancialEntity
	
	^'This financial entity has been added in this structure before!!!!'! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialEntity subclass: #Portfolio
	instanceVariableNames: 'financialEntities portfolioParents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'ET 5/22/2021 17:51:04'!
balance
	
	^(financialEntities sum: [:aFinancialEntity | aFinancialEntity balance] ifEmpty: [0])! !


!Portfolio methodsFor: 'testing' stamp: 'ET 5/22/2021 17:50:48'!
hasRegistered: aTransaction 
	
	^(financialEntities anySatisfy: [:aFinancialEntity | aFinancialEntity hasRegistered: aTransaction])! !

!Portfolio methodsFor: 'testing' stamp: 'ET 5/22/2021 18:48:56'!
includes: aFinancialEntity

	^ (aFinancialEntity  = self) or: [financialEntities anySatisfy: [:financialEntity | financialEntity includes: aFinancialEntity]].! !


!Portfolio methodsFor: 'transactions - private' stamp: 'ET 5/22/2021 19:37:08'!
putAllTransactionsInto: aTransactionsCollection
	
	financialEntities do: [:aFinancialEntity | aFinancialEntity putAllTransactionsInto: aTransactionsCollection].! !


!Portfolio methodsFor: 'transactions' stamp: 'ET 5/22/2021 19:39:30'!
transactions

	|transactions|
	transactions := OrderedCollection new.
	self putAllTransactionsInto: transactions.
	
	^transactions.! !


!Portfolio methodsFor: 'assertions' stamp: 'ET 5/25/2021 01:07:02'!
assertFinancialEntityHasNotBeenAdded: aFinancialEntity

	portfolioParents ifEmpty: [aFinancialEntity ensureItDoesntHaveAnythingOn: self]
	ifNotEmpty: [portfolioParents do: [:aPortfolio | aPortfolio assertFinancialEntityHasNotBeenAdded: aFinancialEntity]].! !

!Portfolio methodsFor: 'assertions' stamp: 'ET 5/25/2021 01:07:02'!
ensureItDoesntHaveAnythingOn: aPortfolio
	
	(aPortfolio includes: self) ifTrue: [self error: self class canNotAddAlreadyAddedFinancialEntity]
	ifFalse: [
		financialEntities do: [:aFinancialEntity | aFinancialEntity ensureItDoesntHaveAnythingOn: aPortfolio]
		
		]! !


!Portfolio methodsFor: 'initialization' stamp: 'ET 5/22/2021 19:03:29'!
initialize

	financialEntities := OrderedCollection new.
	portfolioParents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'ET 6/3/2021 00:09:58'!
initializeNamed: aString 

	name := aString.! !


!Portfolio methodsFor: 'adding - private' stamp: 'ET 5/25/2021 01:12:13'!
isAddedInto: aPortfolio

	portfolioParents add: aPortfolio.
	aPortfolio addAssertedFinancialEntity: self.! !


!Portfolio methodsFor: 'adding' stamp: 'ET 5/25/2021 01:10:09'!
addAssertedFinancialEntity: aFinancialEntity

	financialEntities add: aFinancialEntity.! !

!Portfolio methodsFor: 'adding' stamp: 'ET 5/25/2021 01:08:01'!
addFinancialEntity: aFinancialEntity

	self assertFinancialEntityHasNotBeenAdded: aFinancialEntity.
	
	aFinancialEntity isAddedInto: self.! !


!Portfolio methodsFor: 'report' stamp: 'ET 6/2/2021 02:40:34'!
report: aReport

	^aReport reportPortfolio: self.! !


!Portfolio methodsFor: 'report - private' stamp: 'ET 6/2/2021 03:05:51'!
collectionReportsOfItsFinancialEntities: aReport
	| reports |
	reports := OrderedCollection new.
	financialEntities do:[ :aFinancialEntity |
			reports add: (aFinancialEntity report: aReport).
		].
	^ reports.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'ET 6/3/2021 00:07:08'!
named: aString 
	
	^self new initializeNamed: aString ! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialEntity subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'ET 6/2/2021 23:59:27'!
initializeNamed: aString 

	name := aString.! !


!ReceptiveAccount methodsFor: 'transactions - private' stamp: 'ET 5/22/2021 19:36:55'!
putAllTransactionsInto: aTransactionsCollection
	
	aTransactionsCollection addAllFirst: (self transactions).! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'ET 5/22/2021 17:33:11'!
balance

	^transactions inject: 0 into: [:balance :aTransaction |  aTransaction modifiesBalance: balance ].! !


!ReceptiveAccount methodsFor: 'private' stamp: 'ET 5/25/2021 01:10:50'!
isAddedInto: aPortfolio

	aPortfolio addAssertedFinancialEntity: self.
! !


!ReceptiveAccount methodsFor: 'assertions' stamp: 'ET 5/25/2021 01:07:02'!
ensureItDoesntHaveAnythingOn: aPortfolio
	
	(aPortfolio includes: self) ifTrue: [self error: self class canNotAddAlreadyAddedFinancialEntity]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'ET 5/22/2021 18:57:05'!
includes: aFinancialEntity

	^self = aFinancialEntity.
! !


!ReceptiveAccount methodsFor: 'report' stamp: 'ET 6/2/2021 02:41:10'!
report: aReport
	
	^aReport reportAccount: self.! !


!ReceptiveAccount methodsFor: 'report - private' stamp: 'ET 6/2/2021 02:43:29'!
collectionReportsOfItsTransactions: aReport
	
	|reports|
	
	reports := OrderedCollection new.
	
	transactions do: [:aTransaction | reports add: (aTransaction report: aReport)].
	
	^reports.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Ejercicio'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'ET 6/2/2021 23:58:03'!
named: aString 

	^self new initializeNamed: aString ! !


!classDefinition: #Report category: 'Portfolio-Ejercicio'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'Portfolio-Ejercicio'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'report' stamp: 'ET 6/2/2021 02:29:03'!
for: aFinancialEntity

	^aFinancialEntity report: self.! !


!Report class methodsFor: 'report - private' stamp: 'ET 6/2/2021 02:29:33'!
reportAccount: aReceptiveAccount

	self subclassResponsibility! !

!Report class methodsFor: 'report - private' stamp: 'ET 6/2/2021 02:30:51'!
reportDeposit: aDepositTransaction

	self subclassResponsibility! !

!Report class methodsFor: 'report - private' stamp: 'ET 6/2/2021 02:29:46'!
reportPortfolio: aPortfolio

	self subclassResponsibility! !

!Report class methodsFor: 'report - private' stamp: 'ET 6/2/2021 02:31:03'!
reportTransferDeposit: aTransferDepositTransaction

	self subclassResponsibility! !

!Report class methodsFor: 'report - private' stamp: 'ET 6/2/2021 02:31:13'!
reportTransferWithdraw: aTransferWithdrawTransaction

	self subclassResponsibility! !

!Report class methodsFor: 'report - private' stamp: 'ET 6/2/2021 02:30:29'!
reportWithdraw: aWithdrawTransaction

	self subclassResponsibility! !


!classDefinition: #AccountSummaryReport category: 'Portfolio-Ejercicio'!
Report subclass: #AccountSummaryReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummaryReport class' category: 'Portfolio-Ejercicio'!
AccountSummaryReport class
	instanceVariableNames: ''!

!AccountSummaryReport class methodsFor: 'report - private' stamp: 'ET 6/2/2021 02:38:54'!
reportAccount: aReceptiveAccount

	|report|
	report := aReceptiveAccount collectionReportsOfItsTransactions: self.
	report add:('Balance = ', aReceptiveAccount balance asString).
	^ report.
	! !

!AccountSummaryReport class methodsFor: 'report - private' stamp: 'ET 6/2/2021 02:47:22'!
reportDeposit: aDepositTransaction

	^'Depósito por ', aDepositTransaction value asString
	! !

!AccountSummaryReport class methodsFor: 'report - private' stamp: 'ET 6/2/2021 03:07:58'!
reportPortfolio: aPortfolio

	| finalReport reports |
	finalReport := OrderedCollection new.
	reports := aPortfolio collectionReportsOfItsFinancialEntities: self.
	reports do: [:aFinancialEntityReport | finalReport addAllLast: aFinancialEntityReport].
	
	finalReport add:'Balance = ', aPortfolio balance asString.
	^ finalReport.! !

!AccountSummaryReport class methodsFor: 'report - private' stamp: 'ET 6/2/2021 02:47:30'!
reportTransferDeposit: aTransferDepositTransaction

	^'Entrada por transferencia de ', aTransferDepositTransaction value asString
	! !

!AccountSummaryReport class methodsFor: 'report - private' stamp: 'ET 6/2/2021 02:47:35'!
reportTransferWithdraw: aTransferWithdrawTransaction

	^'Salida por transferencia de ', aTransferWithdrawTransaction value asString
	! !

!AccountSummaryReport class methodsFor: 'report - private' stamp: 'ET 6/2/2021 02:47:49'!
reportWithdraw: aWithdrawTransaction

	^'Extracción por ', aWithdrawTransaction value asString.
	! !


!classDefinition: #PortfolioStructureReport category: 'Portfolio-Ejercicio'!
Report subclass: #PortfolioStructureReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioStructureReport class' category: 'Portfolio-Ejercicio'!
PortfolioStructureReport class
	instanceVariableNames: ''!

!PortfolioStructureReport class methodsFor: 'report - private' stamp: 'ET 6/3/2021 00:53:51'!
reportAccount: aReceptiveAccount

	^OrderedCollection with: aReceptiveAccount name.! !

!PortfolioStructureReport class methodsFor: 'report - private' stamp: 'ET 6/3/2021 00:54:48'!
reportDeposit: aDepositTransaction! !

!PortfolioStructureReport class methodsFor: 'report - private' stamp: 'ET 6/3/2021 01:06:38'!
reportPortfolio: aPortfolio
	|reports finalReport|
	finalReport := OrderedCollection with: aPortfolio name.
	
	reports := aPortfolio collectionReportsOfItsFinancialEntities: self.
	
	reports do: [:aFinancialEntityReport | finalReport addAllLast: (aFinancialEntityReport collect: [:a | String tab, a]  )].
	
	^finalReport.! !

!PortfolioStructureReport class methodsFor: 'report - private' stamp: 'ET 6/3/2021 00:54:43'!
reportTransferDeposit: aTransferDepositTransaction! !

!PortfolioStructureReport class methodsFor: 'report - private' stamp: 'ET 6/3/2021 00:54:39'!
reportTransferWithdraw: aTransferWithdrawTransaction! !

!PortfolioStructureReport class methodsFor: 'report - private' stamp: 'ET 6/3/2021 00:54:34'!
reportWithdraw: aWithdrawTransaction! !


!classDefinition: #SpecialSummaryReport category: 'Portfolio-Ejercicio'!
Report subclass: #SpecialSummaryReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SpecialSummaryReport class' category: 'Portfolio-Ejercicio'!
SpecialSummaryReport class
	instanceVariableNames: ''!

!SpecialSummaryReport class methodsFor: 'report - private' stamp: 'ET 6/3/2021 01:22:48'!
reportAccount: aReceptiveAccount
	|reports finalReport|
	
	finalReport := OrderedCollection with: aReceptiveAccount name.
	reports := aReceptiveAccount collectionReportsOfItsTransactions: self.
	
	finalReport addAllLast: reports.
	
	finalReport add: String tab, 'Balance = ', aReceptiveAccount balance asString.

	^finalReport.! !

!SpecialSummaryReport class methodsFor: 'report - private' stamp: 'ET 6/3/2021 01:21:23'!
reportDeposit: aDepositTransaction

	^String tab, 'Depósito por ', aDepositTransaction value asString.! !

!SpecialSummaryReport class methodsFor: 'report - private' stamp: 'ET 6/3/2021 02:04:49'!
reportPortfolio: aPortfolio
	|reports finalReport|
	finalReport := OrderedCollection with: aPortfolio name.
	reports := aPortfolio collectionReportsOfItsFinancialEntities: self.
	
	reports do: [:aFinancialEntityReport | finalReport addAllLast: (aFinancialEntityReport collect: [:a | String tab, a]  )].
	
	finalReport add: String tab, 'Balance = ', aPortfolio balance asString.
	^finalReport.! !

!SpecialSummaryReport class methodsFor: 'report - private' stamp: 'ET 6/3/2021 01:36:02'!
reportTransferDeposit: aTransferDepositTransaction

	^String tab, 'Entrada por depósito de ', aTransferDepositTransaction value asString.! !

!SpecialSummaryReport class methodsFor: 'report - private' stamp: 'ET 6/3/2021 01:36:24'!
reportTransferWithdraw: aTransferWithdrawTransaction

	^String tab, 'Salida por extracción de ', aTransferWithdrawTransaction value asString.! !

!SpecialSummaryReport class methodsFor: 'report - private' stamp: 'ET 6/3/2021 01:29:09'!
reportWithdraw: aWithdrawTransaction

	^String tab, 'Extracción por ', aWithdrawTransaction value asString.! !


!classDefinition: #TransferNetReport category: 'Portfolio-Ejercicio'!
Report subclass: #TransferNetReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNetReport class' category: 'Portfolio-Ejercicio'!
TransferNetReport class
	instanceVariableNames: ''!

!TransferNetReport class methodsFor: 'report - private' stamp: 'ET 6/2/2021 02:54:27'!
reportAccount: aReceptiveAccount

	|report|
	report := aReceptiveAccount collectionReportsOfItsTransactions: self.
	^report sum: [:aTransactionReport | aTransactionReport ] ifEmpty: [0].! !

!TransferNetReport class methodsFor: 'report - private' stamp: 'ET 6/2/2021 02:52:43'!
reportDeposit: aDepositTransaction

	^0.! !

!TransferNetReport class methodsFor: 'report - private' stamp: 'ET 6/2/2021 22:58:03'!
reportPortfolio: aPortfolio

	| reports |
	reports := aPortfolio collectionReportsOfItsFinancialEntities: self.
	^reports sum: [:aFinancialEntityReport | aFinancialEntityReport] ifEmpty: [0].! !

!TransferNetReport class methodsFor: 'report - private' stamp: 'ET 6/2/2021 02:52:16'!
reportTransferDeposit: aTransferDepositTransaction

	^aTransferDepositTransaction value.! !

!TransferNetReport class methodsFor: 'report - private' stamp: 'ET 6/2/2021 02:52:30'!
reportTransferWithdraw: aTransferWithdrawTransaction

	^aTransferWithdrawTransaction value negated.! !

!TransferNetReport class methodsFor: 'report - private' stamp: 'ET 6/2/2021 02:52:00'!
reportWithdraw: aWithdrawTransaction

	^0.! !


!classDefinition: #Transfer category: 'Portfolio-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'transferDeposit transferWithdraw receptiveAccountOrigin receptiveAccountDestiny amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Transfer methodsFor: 'initialization' stamp: 'JA 5/30/2021 18:52:18'!
initializeWith: aReceptiveAccountOrigin and: aReceptiveAccountDestiny amount: anAmount 
	
	amount := anAmount.	
	transferWithdraw := TransferWithdraw for: self on: aReceptiveAccountOrigin.
	transferDeposit := TransferDeposit for: self on: aReceptiveAccountDestiny.
	aReceptiveAccountOrigin register: transferWithdraw.
	aReceptiveAccountDestiny register: transferDeposit.
	! !


!Transfer methodsFor: 'amount' stamp: 'JA 5/30/2021 18:53:39'!
amount
	
	^amount! !


!Transfer methodsFor: 'transfer legs' stamp: 'JA 5/27/2021 21:39:11'!
deposit
	^ transferDeposit .! !

!Transfer methodsFor: 'transfer legs' stamp: 'JA 5/27/2021 21:38:40'!
withdraw
	^ transferWithdraw .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'ET 6/2/2021 01:03:34'!
canNotTransferToTheSameAccount
	
	^'No podes transferir de una cuenta a la misma cuenta'.! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'JA 5/27/2021 21:22:26'!
canNotTransferWithInvalidAmount
	^ 'No se puede transferir con monto no positivo'.! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'ET 6/2/2021 01:02:07'!
from: aReceptiveAccountOrigin to: aReceptiveAccountDestiny amount: anAmount 
	
	
	anAmount <= 0 ifTrue: [self error: self canNotTransferWithInvalidAmount].
	
	aReceptiveAccountOrigin = aReceptiveAccountDestiny ifTrue: [self error: self canNotTransferToTheSameAccount].
	
	
	^ self new initializeWith: aReceptiveAccountOrigin and: aReceptiveAccountDestiny amount: anAmount.! !
