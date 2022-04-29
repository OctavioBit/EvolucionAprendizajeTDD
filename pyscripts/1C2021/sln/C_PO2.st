!classDefinition: #AccountSummaryTest category: #'Portfolio2-Solucion-Tests'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion-Tests'!

!AccountSummaryTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 18:30:47'!
test01AccountSummaryOfAccountWithoutTransactionsShowsBalanceOnly

	| account accountSummary lines |
	
	account := ReceptiveAccount new.
	
	accountSummary := AccountSummary on: account.
	lines := accountSummary lines.
	
	self assert: 1 equals: lines size.
	self assert: 'Balance = 0' equals: lines first! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 18:30:01'!
test02DepositIsShownInAccountSummary

	| account accountSummary lines |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	accountSummary := AccountSummary on: account.
	lines := accountSummary lines.
	
	self assert: 2 equals: lines size.
	self assert: 'Depósito por 100' equals: lines first.
	self assert: 'Balance = 100' equals: lines second! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 18:31:15'!
test03WithdrawIsShownInAccountSummary

	| account accountSummary lines |
	
	account := ReceptiveAccount new.
	Withdraw register: 50 on: account.
	
	accountSummary := AccountSummary on: account.
	lines := accountSummary lines.
	
	self assert: 2 equals: lines size.
	self assert: 'Extracción por 50' equals: lines first.
	self assert: 'Balance = -50' equals: lines second! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 18:43:30'!
test04TransferWithdrawIsShownInAccountSummary

	| fromAccount accountSummary lines toAccount |
	
	fromAccount := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.
	Transfer register: 20 from: fromAccount to: toAccount.
	
	accountSummary := AccountSummary on: fromAccount.
	lines := accountSummary lines.
	
	self assert: 2 equals: lines size.
	self assert: 'Salida por transferencia de 20' equals: lines first.
	self assert: 'Balance = -20' equals: lines second! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 18:31:46'!
test05TransferDepositIsShownInAccountSummary

	| fromAccount accountSummary lines toAccount |
	
	fromAccount := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.
	Transfer register: 30 from: fromAccount to: toAccount.
	
	accountSummary := AccountSummary on: toAccount.
	lines := accountSummary lines.
	
	self assert: 2 equals: lines size.
	self assert: 'Entrada por transferencia de 30' equals: lines first.
	self assert: 'Balance = 30' equals: lines second! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 18:44:28'!
test06AccountSummaryShowsAllTransactions

	| account accountSummary lines  |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 20 on: account.
		
	accountSummary := AccountSummary on: account.
	lines := accountSummary lines.
	
	self assert: 3 equals: lines size.
	self assert: 'Depósito por 100' equals: lines first.
	self assert: 'Extracción por 20' equals: lines second.
	self assert: 'Balance = 80' equals: lines third ! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 18:46:47'!
test07AccountSummaryWorksOnPortfolios

	| account accountSummary lines  anotherAccount simplePortfolio |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 20 on: anotherAccount.
	simplePortfolio := Portfolio with: account with: anotherAccount.
	
	accountSummary := AccountSummary on: simplePortfolio.
	lines := accountSummary lines.
	
	self assert: 3 equals: lines size.
	self assert: 'Depósito por 100' equals: lines first.
	self assert: 'Extracción por 20' equals: lines second.
	self assert: 'Balance = 80' equals: lines third ! !


!classDefinition: #AccountTransferNetTest category: #'Portfolio2-Solucion-Tests'!
TestCase subclass: #AccountTransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion-Tests'!

!AccountTransferNetTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 19:07:37'!
test01TransferNetOnAccountWithoutTransactionsIsZero

	| account accountTransferNet transferNet |
	
	account := ReceptiveAccount new.
	
	accountTransferNet := AccountTransferNet on: account.
	transferNet := accountTransferNet value.
	
	self assert: 0 equals: transferNet ! !

!AccountTransferNetTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 19:09:41'!
test02DepositDoesNotAffectTransferNet

	| account accountTransferNet transferNet |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	accountTransferNet := AccountTransferNet on: account.
	transferNet := accountTransferNet value.
	
	self assert: 0 equals: transferNet 
	! !

!AccountTransferNetTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 19:10:27'!
test03WithdrawDoesNotAffectTransferNet

	| account accountTransferNet transferNet |
	
	account := ReceptiveAccount new.
	Withdraw register: 50 on: account.
	
	accountTransferNet := AccountTransferNet on: account.
	transferNet := accountTransferNet value.
	
	self assert: 0 equals: transferNet
	! !

!AccountTransferNetTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 19:11:13'!
test04TransferWithdrawSubstractsInTransferNet

	| fromAccount accountTransferNet transferNet toAccount |
	
	fromAccount := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.
	Transfer register: 20 from: fromAccount to: toAccount.
	
	accountTransferNet := AccountTransferNet on: fromAccount.
	transferNet := accountTransferNet value.
	
	self assert: -20 equals: transferNet 
	! !

!AccountTransferNetTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 19:13:53'!
test05TransferDepositAddToTransferNet

	| fromAccount accountTransferNet transferNet toAccount |
	
	fromAccount := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.
	Transfer register: 30 from: fromAccount to: toAccount.
	
	accountTransferNet := AccountTransferNet on: toAccount.
	transferNet := accountTransferNet value.
	
	self assert: 30 equals: transferNet 
	! !

!AccountTransferNetTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 19:15:13'!
test06TransferNetIsCalculatedOnAllTransactions

	| fromAccount accountTransferNet transferNet toAccount |
	
	fromAccount := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.
	Transfer register: 30 from: fromAccount to: toAccount.
	Transfer register: 50 from: fromAccount to: toAccount.
	
	accountTransferNet := AccountTransferNet on: fromAccount.
	transferNet := accountTransferNet value.
	
	self assert: -80 equals: transferNet 
	! !

!AccountTransferNetTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 19:16:48'!
test07TransferNetWorksOnPortfolios

	| account accountTransferNet transferNet  anotherAccount simplePortfolio |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	Transfer register: 30 from: account to: anotherAccount.
	Transfer register: 50 from: account to: anotherAccount.
	simplePortfolio := Portfolio with: account with: anotherAccount.
	
	accountTransferNet := AccountTransferNet on: simplePortfolio.
	transferNet := accountTransferNet value.
	
	self assert: 0 equals: transferNet ! !


!classDefinition: #PortfolioSummaryTest category: #'Portfolio2-Solucion-Tests'!
TestCase subclass: #PortfolioSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion-Tests'!

!PortfolioSummaryTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 19:56:25'!
test01ShowsNameAndBalanceForAnEmptyPortfolio

	| lines portfolioName |
	
	portfolioName := 'Portfolio de la familia'.
	lines := (PortfolioSummary on: (Portfolio named: portfolioName)) lines.
	
	self assert: 2 equals: lines size.
	self assert: portfolioName equals: lines first.
	self assert: '   Balance = 0' equals: lines second.
	
	! !

!PortfolioSummaryTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 15:51:49'!
test02ShowsPortfolioAccountsRecursively

	| lines familyPortfolioName familyPortfolio johnsAccount johnsAccountName angiesAccount angiesAccountName childrenPortfolio childrenPortfolioName myAccount myAccountName expectedSummary |
	
	familyPortfolioName := 'Portfolio de la familia'.
	johnsAccountName := 'Cuenta de Juan'.
	angiesAccountName := 'Cuenta de Angeles'.
	childrenPortfolioName := 'Portfolio de hijos'.
	myAccountName := 'Cuenta Mia'.
	johnsAccount := ReceptiveAccount named: johnsAccountName.
	angiesAccount := ReceptiveAccount named: angiesAccountName.
	childrenPortfolio := Portfolio named: childrenPortfolioName with: johnsAccount with: angiesAccount.
	myAccount := ReceptiveAccount named: myAccountName.
	familyPortfolio := Portfolio named: familyPortfolioName with: childrenPortfolio with: myAccount.

	Deposit register: 100 on: johnsAccount.
	Withdraw register: 20 on: angiesAccount.
	Transfer register: 50 from: myAccount to: johnsAccount.
	
	lines := (PortfolioSummary on: familyPortfolio) lines.
	
	expectedSummary := { 
'Portfolio de la familia'.
'   Portfolio de hijos'.
'      Cuenta de Juan'.
'         Depósito por 100'.
'         Entrada por transferencia de 50'.
'         Balance = 150'.
'      Cuenta de Angeles'.
'         Extracción por 20'.
'         Balance = -20'.
'      Balance = 130'.
'   Cuenta Mia'.
'      Salida por transferencia de 50'.
'      Balance = -50'.
'   Balance = 80'. }.

	self assert: expectedSummary size equals: lines size.
	1 to: expectedSummary size do: [:index |
		self assert: (expectedSummary at: index) equals: (lines at: index) ]
! !


!classDefinition: #PortfolioTest category: #'Portfolio2-Solucion-Tests'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion-Tests'!

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

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:15'!
test08PortfolioTransasctionsIncludesAllItsAccountsTransactions

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

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:32:29'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:32:36'!
test16TransactionsAreEmptyForAnEmptyPortolio

	self assert: Portfolio new transactionsIsEmpty ! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:32:40'!
test17TransactionsIsEmptyIsCalculatedRecursevely

	self assert: (Portfolio with: ReceptiveAccount new with: Portfolio new) transactionsIsEmpty ! !


!classDefinition: #PortfolioTreePrinterTest category: #'Portfolio2-Solucion-Tests'!
TestCase subclass: #PortfolioTreePrinterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion-Tests'!

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 19:25:49'!
test01PortolioTreePrinterShowsNameOfPortfolioForAnEmptyPortfolio

	| lines portfolioName |
	
	portfolioName := 'Portfolio de la familia'.
	lines := (PortfolioTreePrinter on: (Portfolio named: portfolioName)) lines.
	
	self assert: 1 equals: lines size.
	self assert: portfolioName equals: lines first
	
	! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 19:31:11'!
test02PortfolioWithOneAccountShowAccountNameIndented

	| lines portfolioName familyPortfolio johnsAccount johnsAccountName |
	
	portfolioName := 'Portfolio de la familia'.
	johnsAccountName := 'Cuenta de Juan'.
	johnsAccount := ReceptiveAccount named: johnsAccountName.
	familyPortfolio := Portfolio named: portfolioName with: johnsAccount.
	
	lines := (PortfolioTreePrinter on: familyPortfolio) lines.
	
	self assert: 2 equals: lines size.
	self assert: portfolioName equals: lines first.
	self assert: '   ', johnsAccountName equals: lines second	
! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'HAW 5/26/2019 19:47:42'!
test03AfterShowingAPortfolioIndentationIsDecremented

	| lines familyPortfolioName familyPortfolio johnsAccount johnsAccountName childrenPortfolio childrenPortfolioName myAccount myAccountName |
	
	familyPortfolioName := 'Portfolio de la familia'.
	johnsAccountName := 'Cuenta de Juan'.
	childrenPortfolioName := 'Portfolio de los hijos'.
	myAccountName := 'Cuenta mia'.
	johnsAccount := ReceptiveAccount named: johnsAccountName.
	childrenPortfolio := Portfolio named: childrenPortfolioName with: johnsAccount.
	myAccount := ReceptiveAccount named: myAccountName.
	familyPortfolio := Portfolio named: familyPortfolioName with: childrenPortfolio with: myAccount.
	
	lines := (PortfolioTreePrinter on: familyPortfolio) lines.
	
	self assert: 4 equals: lines size.
	self assert: familyPortfolioName equals: lines first.
	self assert: '   ', childrenPortfolioName equals: lines second.	
	self assert: '      ', johnsAccountName equals: lines third.
	self assert: '   ', myAccountName equals: lines fourth.
		
! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio2-Solucion-Tests'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion-Tests'!

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


!classDefinition: #TransferTest category: #'Portfolio2-Solucion-Tests'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion-Tests'!

!TransferTest methodsFor: 'test' stamp: 'LL 6/29/2020 16:28:23'!
test01TransferWithdrawsFromOriginAccountAndDepositsIntoDestinationAccount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	Transfer register: 100 from: originAccount to: destinationAccount.
	
	self assert: -100 equals: originAccount balance.
	self assert: 100 equals: destinationAccount balance! !

!TransferTest methodsFor: 'test' stamp: 'LL 6/29/2020 16:29:05'!
test02TransferLegsAreRegisteredInAccounts

	| originAccount destinationAccount transfer |
	
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	transfer := Transfer register: 100 from: originAccount to: destinationAccount.
	
	self assert: (originAccount hasRegistered: transfer withdrawLeg).
	self assert: (destinationAccount hasRegistered: transfer depositLeg).! !

!TransferTest methodsFor: 'test' stamp: 'HAW 5/26/2019 18:11:02'!
test03CanGoFromWithdrawLegToDepositLeg

	| transfer |
		
	transfer := Transfer for: 100.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'test' stamp: 'HAW 5/26/2019 18:11:17'!
test04CanGoFromDepositLegToWithdrawLeg

	| transfer |
	
	transfer := Transfer for: 100.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'test' stamp: 'HAW 5/26/2019 18:12:03'!
test05LegsHaveSameTransfer

	| transfer |
	
	transfer := Transfer for: 100.
	
	self assert: transfer withdrawLeg transfer equals: transfer depositLeg transfer! !

!TransferTest methodsFor: 'test' stamp: 'HAW 5/26/2019 18:50:19'!
test06CanNotTransferBetweenSameAccounts

	| account |
	
	account := ReceptiveAccount new.
	
	self 
		should: [ Transfer register: 100 from: account to: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer canNotTransferBetweenSameAccountsErrorMessage equals: anError messageText.
			self assert: account transactionsIsEmpty ]
	
! !

!TransferTest methodsFor: 'test' stamp: 'LL 6/29/2020 16:30:26'!
test07CanTransferStrictlyPositiveValuesOnly

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	self 
		should: [ Transfer register: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer transferValueMustBeStrictlyPositiveErrorMessage equals: anError messageText.
			self assert: originAccount transactionsIsEmpty. 
			self assert: destinationAccount transactionsIsEmpty ]
	
! !
