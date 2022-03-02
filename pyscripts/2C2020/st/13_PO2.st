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


!classDefinition: #ReportTests category: 'Portfolio-Solucion'!
TestCase subclass: #ReportTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!


!classDefinition: #StructureReportTest category: 'Portfolio-Solucion'!
ReportTests subclass: #StructureReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!StructureReportTest methodsFor: 'tests' stamp: 'AM 11/15/2020 22:30:26'!
test01ReceptiveAccountStructureIsAccountName

	| account report expectedReport|
	
	account := ReceptiveAccount named: 'Account'.
	report := StructureReport for: account.
	
	expectedReport := OrderedCollection with: 'Account'.
	
	self assert: (report report) equals: expectedReport.! !

!StructureReportTest methodsFor: 'tests' stamp: 'AM 11/15/2020 22:42:37'!
test02PortfolioWithAccountDisplaysProperIndentation

	| portfolio account report expectedReport|
	
	account := ReceptiveAccount named: 'Account'.
	portfolio := Portfolio named: 'Portfolio' with: account.
	report := StructureReport for: portfolio.
	
	expectedReport := OrderedCollection   with: 'Portfolio' 
									with: '    Account'.
	
	self assert: (report report) equals: expectedReport.! !

!StructureReportTest methodsFor: 'tests' stamp: 'AM 11/15/2020 22:42:27'!
test03PortfolioWithTwoAccountsDisplaysAccountsWithEqualIndentation

	| portfolio account1 account2 report expectedReport|
	
	account1 := ReceptiveAccount named: 'Account1'.
	account2 := ReceptiveAccount named: 'Account2'.
	portfolio := Portfolio named: 'Portfolio' with: account1 with: account2.
	report := StructureReport for: portfolio.
	
	expectedReport := OrderedCollection   with: 'Portfolio' 
									with: '    Account1' 
									with: '    Account2'.
	
	self assert: (report report) equals: expectedReport.! !

!StructureReportTest methodsFor: 'tests' stamp: 'AM 11/15/2020 22:42:11'!
test04PortfolioWithChildPortfolioDisplaysProperIndentationForChildPortfolio

	| portfolio portfolioChild account report expectedReport|
	
	account := ReceptiveAccount named: 'Account'.
	portfolioChild := Portfolio named: 'Portfolio child' with: account.
	portfolio := Portfolio named: 'Portfolio' with: portfolioChild.
	report := StructureReport for: portfolio.
	
	expectedReport := OrderedCollection   with: 'Portfolio' 
									with: '    Portfolio child' 
									with: '        Account'.
	
	self assert: (report report) equals: expectedReport.! !

!StructureReportTest methodsFor: 'tests' stamp: 'AM 11/15/2020 22:41:54'!
test05PortfolioWithChildPortfolioDisplaysProperIndentationForAccountsAfterChildPortfolio

	| portfolio portfolioChild account1 account2 report expectedReport|
	
	account1 := ReceptiveAccount named: 'Account1'.
	account2 := ReceptiveAccount named: 'Account2'.
	portfolioChild := Portfolio named: 'Portfolio child' with: account1.
	portfolio := Portfolio named: 'Portfolio' with: portfolioChild with: account2.
	report := StructureReport for: portfolio.
	
	expectedReport := OrderedCollection   with: 'Portfolio' 
							  	     	with: '    Portfolio child' 
									with: '        Account1'
									with: '    Account2'.
	
	self assert: (report report) equals: expectedReport.! !


!classDefinition: #StructuredSummaryTest category: 'Portfolio-Solucion'!
ReportTests subclass: #StructuredSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!StructuredSummaryTest methodsFor: 'tests' stamp: 'AM 11/15/2020 23:12:40'!
test01AccountStructuredSummaryIncludesAccountSummary
	
	| account report expectedReport|
	
	account := ReceptiveAccount named: 'Account'.
	account register: (Deposit for: 100).
	report := StructuredSummaryReport for: account.
	
	expectedReport := OrderedCollection   with: 'Account' 
									with: '    Deposit for 100' 
									with: '    Balance = 100'.
	
	self assert: (report report) equals: expectedReport.! !

!StructuredSummaryTest methodsFor: 'tests' stamp: 'AM 11/15/2020 23:14:31'!
test02PortfolioStructuredSummaryIncludesAccountSummary
	
	| portfolio account report expectedReport|
	
	account := ReceptiveAccount named: 'Account'.
	account register: (Deposit for: 100).
	portfolio := Portfolio named: 'Portfolio' with: account.
	report := StructuredSummaryReport for: portfolio.
	
	expectedReport := OrderedCollection   with: 'Portfolio'
									with: '    Account' 
									with: '        Deposit for 100' 
									with: '        Balance = 100'.
	
	self assert: (report report) equals: expectedReport.! !

!StructuredSummaryTest methodsFor: 'tests' stamp: 'AM 11/15/2020 23:16:56'!
test03PortfolioWithChildPortfolioStructuredSummaryIncludesChildPortflioSummary
	
	| portfolio portfolioChild account report expectedReport|
	
	account := ReceptiveAccount named: 'Account'.
	account register: (Deposit for: 100).
	portfolioChild := Portfolio named: 'Portfolio child' with: account.
	portfolio := Portfolio named: 'Portfolio' with: portfolioChild.
	report := StructuredSummaryReport for: portfolio.
	
	expectedReport := OrderedCollection   with: 'Portfolio'
									with: '    Portfolio child'
									with: '        Account' 
									with: '            Deposit for 100' 
									with: '            Balance = 100'.
	
	self assert: (report report) equals: expectedReport.! !

!StructuredSummaryTest methodsFor: 'tests' stamp: 'AM 11/15/2020 23:22:56'!
test04PortfolioWithChildPortfolioStructuredSummaryShowsEqualIndentationForAccountsAndPortfolios
	
	| portfolio portfolioChild account1 account2 report expectedReport|
	
	account1 := ReceptiveAccount named: 'Account1'.
	account1 register: (Deposit for: 100).
	account2 := ReceptiveAccount named: 'Account2'.
	account2 register: (Deposit for: 200).
	portfolioChild := Portfolio named: 'Portfolio child' with: account1.
	portfolio := Portfolio named: 'Portfolio' with: portfolioChild with: account2.
	report := StructuredSummaryReport for: portfolio.
	
	expectedReport := OrderedCollection   with: 'Portfolio'
									with: '    Portfolio child'
									with: '        Account1' 
									with: '            Deposit for 100' 
									with: '            Balance = 100'.
					       expectedReport add: '    Account2'.
						expectedReport add: '        Deposit for 200'.
						expectedReport add: '        Balance = 200'.
									
	
	self assert: (report report) equals: expectedReport.! !


!classDefinition: #SummaryReportTest category: 'Portfolio-Solucion'!
ReportTests subclass: #SummaryReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SummaryReportTest methodsFor: 'tests' stamp: 'AM 11/15/2020 22:30:33'!
test01AccountSummaryForEmptyAccountIsZeroBalance

	| account accountSummary |
	account := ReceptiveAccount new.
	accountSummary := SummaryReport for: account.
	
	self assert: (OrderedCollection with: 'Balance = 0') equals: accountSummary report. ! !

!SummaryReportTest methodsFor: 'tests' stamp: 'AM 11/15/2020 22:30:33'!
test02AccountSummaryForAccountWithOneTransactionMatchesBalanceAndTransaction

	| account accountSummary expectedReport |
	
	account := ReceptiveAccount new.
	account register: (Deposit for: 100).
	accountSummary := SummaryReport for: account.
	expectedReport := OrderedCollection with: 'Deposit for 100' with: 'Balance = 100'.
	
	self assert: (expectedReport) equals: accountSummary report. ! !

!SummaryReportTest methodsFor: 'tests' stamp: 'AM 11/15/2020 22:30:33'!
test03AccountSummaryForAccountWithMultipleTransactionsShowsAllTransactions

	| account1 account2 accountSummary expectedReport |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account1 register: (Deposit for: 100).
	Transfer from: account1 to: account2 for: 50. 
	accountSummary := SummaryReport for: account1.
	expectedReport := OrderedCollection with: 'Deposit for 100' with: 'TransferWithdraw for 50' with: 'Balance = 50'.
	
	self assert: (expectedReport) equals: accountSummary report. ! !

!SummaryReportTest methodsFor: 'tests' stamp: 'AM 11/15/2020 22:30:33'!
test04SummaryForEmptyPorfolioIsZeroBalance

	| portfolio expectedReport accountSummary|
	
	portfolio := Portfolio new.
	expectedReport := OrderedCollection with: 'Balance = 0'.
	accountSummary := SummaryReport for: portfolio.
	
	self assert: (expectedReport) equals: accountSummary report. ! !

!SummaryReportTest methodsFor: 'tests' stamp: 'AM 11/15/2020 22:30:33'!
test05SummaryForPorfolioWithOneAccountMatchesAccountTransactionsAndBalance

	| portfolio account expectedReport accountSummary|
	
	account := ReceptiveAccount new.
	account register: (Deposit for: 100); register: (Withdraw for: 100) .
	portfolio := Portfolio new.
	portfolio add: account.
	
	expectedReport := OrderedCollection with: 'Deposit for 100' with: 'Withdraw for 100' with: 'Balance = 0'.
	accountSummary := SummaryReport for: portfolio.
	
	self assert: (expectedReport) equals: accountSummary report. ! !

!SummaryReportTest methodsFor: 'tests' stamp: 'AM 11/15/2020 22:30:33'!
test06SummaryForPorfolioWithOnePortfolioMatchesPortfolioTransactionsAndBalance

	| portfolioChild portfolio account expectedReport accountSummary|
	
	account := ReceptiveAccount new.
	account register: (Deposit for: 100); register: (Withdraw for: 100) .
	portfolioChild := Portfolio new.
	portfolioChild add: account.
	portfolio := Portfolio new.
	portfolio add: portfolioChild.
	
	expectedReport := OrderedCollection with: 'Deposit for 100' with: 'Withdraw for 100' with: 'Balance = 0'.
	accountSummary := SummaryReport for: portfolio.
	
	self assert: (expectedReport) equals: accountSummary report. ! !


!classDefinition: #TransferNetReportTest category: 'Portfolio-Solucion'!
ReportTests subclass: #TransferNetReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetReportTest methodsFor: 'tests' stamp: 'AM 11/15/2020 22:30:41'!
test01EmptyAccountTransferNetIsZero

	| account transferNetReport |
	
	account := ReceptiveAccount new.
	transferNetReport := TransferNetReport for: account.
	
	self assert: (transferNetReport report) equals: 0.! !

!TransferNetReportTest methodsFor: 'tests' stamp: 'AM 11/15/2020 22:30:41'!
test02TransferNetReportForAccountWithTransferWithdrawMatchesWithdrawAmount

	| account1 account2 transferNetReport |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer from: account1 to: account2 for: 500. 
	
	transferNetReport := TransferNetReport for: account1.
	
	self assert: (transferNetReport report) equals: -500.! !

!TransferNetReportTest methodsFor: 'tests' stamp: 'AM 11/15/2020 22:30:41'!
test03TransferNetReportForAccountWithTransferDepositMatchesDepositAmount

	| account1 account2 transferNetReport |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer from: account1 to: account2 for: 500. 
	
	transferNetReport := TransferNetReport for: account2.
	
	self assert: (transferNetReport report) equals: 500.! !

!TransferNetReportTest methodsFor: 'tests' stamp: 'AM 11/15/2020 22:30:41'!
test04NonTransferTransactionsDontAffectTrasferNet

	| account1 account2 transferNetReport |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account1 register: (Deposit for: 600).
	account1 register: (Withdraw for: 100).
	
	Transfer from: account1 to: account2 for: 500. 
	
	transferNetReport := TransferNetReport for: account1.
	
	self assert: (transferNetReport report) equals: -500.! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'tests' stamp: 'AM 11/9/2020 20:55:49'!
test01TransferKnowsTransferorAndTransferee

	| transfer transferor transferee|
	
	transferor := ReceptiveAccount new.
	transferee := ReceptiveAccount new.
	
	transfer := Transfer from: transferor to: transferee for: 500.
	
	self assert: transferor equals: (transfer transferor).
	self assert: transferee equals: (transfer transferee).! !

!TransferTest methodsFor: 'tests' stamp: 'AM 11/9/2020 20:55:50'!
test02TransferAmountReturnedCorrectly

	| transfer transferor transferee|
	
	transferor := ReceptiveAccount new.
	transferee := ReceptiveAccount new.
	
	transfer := Transfer from: transferor to: transferee for: 500.
	
	self assert: 500 equals: (transfer amount).! !

!TransferTest methodsFor: 'tests' stamp: 'AM 11/9/2020 21:16:14'!
test03TransferAffectsTransferorBalanceCorrectly

	| transferor transferee|
	
	transferor := ReceptiveAccount new.
	transferee := ReceptiveAccount new.
	
	Transfer from: transferor to: transferee for: 500.
	
	self assert: -500 equals: (transferor balance).! !

!TransferTest methodsFor: 'tests' stamp: 'AM 11/9/2020 21:16:06'!
test04TransferAffectsTransfereeBalanceCorrectly

	|  transferor transferee|
	
	transferor := ReceptiveAccount new.
	transferee := ReceptiveAccount new.
	
	Transfer from: transferor to: transferee for: 500.
	
	self assert: 500 equals: (transferee balance).! !

!TransferTest methodsFor: 'tests' stamp: 'AM 11/9/2020 21:15:56'!
test05TransferMustBeAPositiveNumber

	| transferor transferee|
	
	transferor := ReceptiveAccount new.
	transferee := ReceptiveAccount new.
	
	self 
		should: [Transfer from: transferor to: transferee for: -100]
		raise: Error
		withMessageText: Transfer invalidAmountErrorDescription.! !

!TransferTest methodsFor: 'tests' stamp: 'AM 11/9/2020 21:26:39'!
test06TransfersToAndFromTheSameAccountNotAllowed

	| account |
	
	account := ReceptiveAccount new.
	
	self 
		should: [Transfer from: account to: account for: 100]
		raise: Error
		withMessageText: Transfer cantTransferToSelfErrorDescription.! !


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


!Account methodsFor: 'name' stamp: 'AM 11/15/2020 23:52:59'!
name
	
	^name copy.
	! !


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


!Portfolio methodsFor: 'initialization' stamp: 'AM 11/15/2020 21:13:56'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	"Default name for portfolio"
	name := 'Portfolio'! !

!Portfolio methodsFor: 'initialization' stamp: 'AM 11/15/2020 21:13:25'!
initializeWithName: aName

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := aName.! !


!Portfolio methodsFor: 'balance' stamp: 'AM 11/14/2020 15:14:58'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ].! !


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


!Portfolio methodsFor: 'reports - private' stamp: 'AM 11/15/2020 23:33:48'!
reportTo: aReport
	
	aReport handlePortfolio: self.
	accounts do: [:account | account reportTo: aReport].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'NR 11/9/2020 06:01:26'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio!!'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'AM 11/15/2020 21:12:36'!
named: aName 

	^self new initializeWithName: aName! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'AM 11/15/2020 21:11:52'!
named: aName with: anAccount

	^(self new initializeWithName: aName)
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'AM 11/15/2020 21:12:18'!
named: aName with: anAccount with: anotherAccount

	^(self new initializeWithName: aName)
		add: anAccount;
		add: anotherAccount;
		yourself! !

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

!ReceptiveAccount methodsFor: 'initialization' stamp: 'AM 11/15/2020 21:14:04'!
initialize

	super initialize.
	transactions := OrderedCollection new.
	"Default name for accounts created without a name"
	name := 'Receptive account'! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'AM 11/15/2020 21:08:51'!
initializeWithName: aName

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


!ReceptiveAccount methodsFor: 'reports - private' stamp: 'AM 11/15/2020 23:34:24'!
reportTo: aReport
	
	aReport handleReceptiveAccount: self.
	transactions do: [:account | account reportTo: aReport].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'AM 11/15/2020 21:08:11'!
named: aName

	^self new initializeWithName: aName.! !


!classDefinition: #AccountReports category: 'Portfolio-Solucion'!
Object subclass: #AccountReports
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountReports methodsFor: 'report' stamp: 'AM 11/9/2020 21:43:01'!
report

	self subclassResponsibility.! !


!AccountReports methodsFor: 'initialization' stamp: 'AM 11/9/2020 21:42:04'!
initializeFor: anAccount

	account := anAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReports class' category: 'Portfolio-Solucion'!
AccountReports class
	instanceVariableNames: ''!

!AccountReports class methodsFor: 'as yet unclassified' stamp: 'AM 11/9/2020 21:40:53'!
for: anAccount

	^self new initializeFor: anAccount.! !


!classDefinition: #StructureReports category: 'Portfolio-Solucion'!
AccountReports subclass: #StructureReports
	instanceVariableNames: 'structure indentation treeLevelSize'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!StructureReports methodsFor: 'indentation - private' stamp: 'AM 11/16/2020 01:19:56'!
decreaseIndentation

	indentation := indentation copyFrom: 1 to: (indentation size - 4).! !

!StructureReports methodsFor: 'indentation - private' stamp: 'AM 11/16/2020 01:20:08'!
decreaseIndentationIfLastInLevel

	(treeLevelSize last = 0) ifTrue: [self decreaseIndentation.
							treeLevelSize removeLast.].
						
	! !

!StructureReports methodsFor: 'indentation - private' stamp: 'AM 11/16/2020 01:20:11'!
increaseIndentation
	
	indentation := indentation,'    '.! !

!StructureReports methodsFor: 'indentation - private' stamp: 'AM 11/16/2020 01:20:15'!
updateLastLevelSize

	| lastLevelSize |
	
	lastLevelSize := treeLevelSize last.
	treeLevelSize removeLast.
	treeLevelSize addLast: lastLevelSize -1.
	! !


!StructureReports methodsFor: 'initialization' stamp: 'AM 11/16/2020 01:21:11'!
initialize 

	structure := OrderedCollection new.
	treeLevelSize := OrderedCollection with: 1.
	indentation := ''.! !


!StructureReports methodsFor: 'report' stamp: 'AM 11/16/2020 01:21:25'!
report
	
	account reportTo: self.
	^structure.! !


!StructureReports methodsFor: 'report - private' stamp: 'AM 11/16/2020 01:23:09'!
handleDeposit: aDeposit

	! !

!StructureReports methodsFor: 'report - private' stamp: 'AM 11/16/2020 01:22:44'!
handlePortfolio: aPortfolio
	
	structure add: indentation, aPortfolio name.
	self updateLastLevelSize.
	treeLevelSize addLast: aPortfolio accountsSize.
	self increaseIndentation.! !

!StructureReports methodsFor: 'report - private' stamp: 'AM 11/16/2020 01:23:31'!
handleTransferDeposit: aTransferDeposit
! !

!StructureReports methodsFor: 'report - private' stamp: 'AM 11/16/2020 01:23:36'!
handleTransferWithdraw: aTransferWithdraw

	! !

!StructureReports methodsFor: 'report - private' stamp: 'AM 11/16/2020 01:23:39'!
handleWithdraw: aWithdraw
! !


!classDefinition: #StructureReport category: 'Portfolio-Solucion'!
StructureReports subclass: #StructureReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!StructureReport methodsFor: 'report - private' stamp: 'AM 11/16/2020 01:01:30'!
handleReceptiveAccount: aReceptiveAccount

	structure add: indentation, aReceptiveAccount name.
	self updateLastLevelSize.
	self decreaseIndentationIfLastInLevel.
	
	treeLevelSize isEmpty ifFalse: [self decreaseIndentationIfLastInLevel].
	! !


!classDefinition: #StructuredSummaryReport category: 'Portfolio-Solucion'!
StructureReports subclass: #StructuredSummaryReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!StructuredSummaryReport methodsFor: 'indentation - private' stamp: 'AM 11/16/2020 01:16:03'!
updateLastLevelSize

	| lastLevelSize |
	
	lastLevelSize := treeLevelSize last.
	treeLevelSize removeLast.
	treeLevelSize addLast: lastLevelSize -1.
	! !


!StructuredSummaryReport methodsFor: 'report - private' stamp: 'AM 11/15/2020 23:11:54'!
addSummaryFor: aReceptiveAccount withIndentation: anIndentationString

	| indentedSummary |
	
	indentedSummary := ((SummaryReport for: aReceptiveAccount) report) collect: [:summaryEntry | anIndentationString, summaryEntry].
	
	structure addAll: indentedSummary.
	
	! !

!StructuredSummaryReport methodsFor: 'report - private' stamp: 'AM 11/16/2020 01:11:52'!
handleReceptiveAccount: aReceptiveAccount

	structure add: indentation, aReceptiveAccount name.
	self addSummaryFor: aReceptiveAccount withIndentation: ('    ', indentation copy).
	self updateLastLevelSize.
	
	self decreaseIndentationIfLastInLevel.
	treeLevelSize isEmpty ifFalse: [self decreaseIndentationIfLastInLevel].
	! !


!StructuredSummaryReport methodsFor: 'report' stamp: 'AM 11/16/2020 01:14:42'!
report

	account reportTo: self.
	^structure.! !



!classDefinition: #SummaryReport category: 'Portfolio-Solucion'!
AccountReports subclass: #SummaryReport
	instanceVariableNames: 'summaryCollection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SummaryReport methodsFor: 'report - private' stamp: 'AM 11/14/2020 17:24:57'!
addStringRepresentationToSummary: aTransaction

	summaryCollection add: (aTransaction class asString), ' for ', aTransaction value asString.! !

!SummaryReport methodsFor: 'report - private' stamp: 'AM 11/14/2020 17:25:19'!
handleDeposit: aDeposit

	self addStringRepresentationToSummary: aDeposit.! !

!SummaryReport methodsFor: 'report - private' stamp: 'AM 11/15/2020 23:36:44'!
handlePortfolio: aPortfolio
! !

!SummaryReport methodsFor: 'report - private' stamp: 'AM 11/15/2020 23:35:20'!
handleReceptiveAccount: aReceptiveAccount
! !

!SummaryReport methodsFor: 'report - private' stamp: 'AM 11/14/2020 17:25:35'!
handleTransferDeposit: aTransferDeposit

	self addStringRepresentationToSummary: aTransferDeposit.! !

!SummaryReport methodsFor: 'report - private' stamp: 'AM 11/14/2020 17:25:49'!
handleTransferWithdraw: aTransferWithdraw

	self addStringRepresentationToSummary: aTransferWithdraw.! !

!SummaryReport methodsFor: 'report - private' stamp: 'AM 11/14/2020 17:25:59'!
handleWithdraw: aWithdraw

	self addStringRepresentationToSummary: aWithdraw.! !


!SummaryReport methodsFor: 'report' stamp: 'AM 11/15/2020 23:36:08'!
report

	account reportTo: self.
	summaryCollection add: 'Balance = ', account balance asString.
	^summaryCollection.! !


!SummaryReport methodsFor: 'initialization' stamp: 'AM 11/15/2020 22:56:20'!
initialize

	summaryCollection := OrderedCollection new.! !


!classDefinition: #TransferNetReport category: 'Portfolio-Solucion'!
AccountReports subclass: #TransferNetReport
	instanceVariableNames: 'netTotal'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetReport methodsFor: 'initialization' stamp: 'AM 11/15/2020 22:55:56'!
initialize

	netTotal := 0.! !


!TransferNetReport methodsFor: 'report - private' stamp: 'AM 11/14/2020 17:45:13'!
handleDeposit: aDepositTransaction
	
	"Deposits dont affect transfer net"! !

!TransferNetReport methodsFor: 'report - private' stamp: 'AM 11/15/2020 23:37:05'!
handlePortfolio: aPortfolio
	
	! !

!TransferNetReport methodsFor: 'report - private' stamp: 'AM 11/15/2020 23:37:39'!
handleReceptiveAccount: aReceptiveAccount
	
	! !

!TransferNetReport methodsFor: 'report - private' stamp: 'AM 11/14/2020 17:39:56'!
handleTransferDeposit: aTransferWithdraw

	netTotal := netTotal + aTransferWithdraw value.! !

!TransferNetReport methodsFor: 'report - private' stamp: 'AM 11/14/2020 17:37:37'!
handleTransferWithdraw: aTransferWithdraw

	netTotal := netTotal - aTransferWithdraw value.! !

!TransferNetReport methodsFor: 'report - private' stamp: 'AM 11/14/2020 17:45:04'!
handleWithdraw: aWithdrawTransaction
	
	"Withdraws dont affect transfer net"! !


!TransferNetReport methodsFor: 'report' stamp: 'AM 11/15/2020 23:37:57'!
report

	account reportTo: self.
	^netTotal.! !


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

!AccountTransaction methodsFor: 'balance' stamp: 'AM 11/14/2020 15:50:13'!
reportTo: aReport

	aReport perform: ('handle', self class asString,':') asSymbol with: self.! !


!AccountTransaction methodsFor: 'initialization' stamp: 'AM 11/15/2020 23:25:12'!
initializeFor: anAccount
	
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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferTransactions category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferTransactions
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTransactions methodsFor: 'initialization' stamp: 'AM 11/9/2020 21:05:06'!
initializeFor: aTransfer

	transfer := aTransfer.! !


!TransferTransactions methodsFor: 'value' stamp: 'AM 11/14/2020 15:25:50'!
value

	^transfer amount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTransactions class' category: 'Portfolio-Solucion'!
TransferTransactions class
	instanceVariableNames: ''!

!TransferTransactions class methodsFor: 'instance creation' stamp: 'AM 11/9/2020 21:04:06'!
for: aTransfer

	^self new initializeFor: aTransfer.! !


!classDefinition: #TransferDeposit category: 'Portfolio-Solucion'!
TransferTransactions subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDeposit methodsFor: 'balance' stamp: 'AM 11/9/2020 21:11:46'!
affectBalance: aBalance

	^aBalance + transfer amount.! !


!classDefinition: #TransferWithdraw category: 'Portfolio-Solucion'!
TransferTransactions subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferWithdraw methodsFor: 'balance' stamp: 'AM 11/9/2020 21:12:45'!
affectBalance: aBalance

	^aBalance - transfer amount.! !


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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'transferor transferee amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'AM 11/9/2020 21:22:15'!
initializeFrom: aTransferor to: aTransferee for: anAmount 
	
	transferor := aTransferor.
	transferee := aTransferee.
	amount := anAmount.
	
	transferor register: (TransferWithdraw for: self).
	transferee register: (TransferDeposit for: self).
	
	! !


!Transfer methodsFor: 'accessing' stamp: 'AM 11/9/2020 19:55:19'!
amount
	
	^amount! !

!Transfer methodsFor: 'accessing' stamp: 'AM 11/9/2020 19:51:32'!
transferee
	
	^transferee! !

!Transfer methodsFor: 'accessing' stamp: 'AM 11/9/2020 19:51:23'!
transferor
	
	^transferor! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'AM 11/9/2020 21:28:04'!
from: aTransferor to: aTransferee for: anAmount 
	
	(anAmount > 0) ifFalse: [ self signalInvalidTransferAmount ].
	(aTransferor == aTransferee) ifTrue: [self signalTransactionToSelfErrorDescription].
	
	^self new initializeFrom: aTransferor to: aTransferee for: anAmount.! !


!Transfer class methodsFor: 'error descriptions' stamp: 'AM 11/9/2020 21:29:10'!
cantTransferToSelfErrorDescription

 	^'Cant transfer from and to the same account'! !

!Transfer class methodsFor: 'error descriptions' stamp: 'AM 11/9/2020 21:17:21'!
invalidAmountErrorDescription
	
	^'Transfer amount must be greater than zero'! !


!Transfer class methodsFor: 'error signals' stamp: 'AM 11/9/2020 21:24:42'!
signalInvalidTransferAmount
	
	^self error: self invalidAmountErrorDescription.! !

!Transfer class methodsFor: 'error signals' stamp: 'AM 11/9/2020 21:30:11'!
signalTransactionToSelfErrorDescription

	^self error: self cantTransferToSelfErrorDescription.! !
