!classDefinition: #Portfolio2Test category: 'Portfolio-Solucion'!
TestCase subclass: #Portfolio2Test
	instanceVariableNames: 'portfolio portfolio1 portfolio2 account1 account2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio2Test methodsFor: 'transferTests' stamp: 'SB 6/3/2021 11:39:20'!
test01transfer100ModifiesRecieverBalance

	Transfer from: account1 to:account2 withAmount: 100.
	self assert: (account2 balance = 100).
	
	
	

	
	! !

!Portfolio2Test methodsFor: 'transferTests' stamp: 'SB 6/3/2021 11:39:35'!
test02transfer100ModifiesSenderBalance
	

	Transfer from: account1 to:account2 withAmount: 100.
	self assert: (account1 balance = -100).
	
	
	

	
	! !

!Portfolio2Test methodsFor: 'transferTests' stamp: 'SB 6/3/2021 11:40:09'!
test03transferSenderCannotBeEqualToReceiver

	self 
		should: [ Transfer from: account1 to:account1 withAmount: 100. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
				self assert: Transfer sameLegsTransfer equals: anError messageText.
			]
	
	! !

!Portfolio2Test methodsFor: 'transferTests' stamp: 'SB 6/3/2021 11:40:38'!
test04SenderLegKnowsRecieverLeg
	|transfer senderLeg|
	
	transfer:=Transfer from: account1 to:account2 withAmount: 100.
	senderLeg:= transfer senderLeg.
	self assert: (senderLeg otherLeg = transfer recieverLeg).

	
	
	

	
	! !

!Portfolio2Test methodsFor: 'transferTests' stamp: 'SB 6/3/2021 11:40:53'!
test05tRecieverLegKnowsSenderLeg
	| transfer recieverLeg|
	
	transfer:=Transfer from: account1 to:account2 withAmount: 100.
	recieverLeg:= transfer recieverLeg.
	self assert: (recieverLeg otherLeg = transfer senderLeg).

	
	
	

	
	! !

!Portfolio2Test methodsFor: 'transferTests' stamp: 'SB 6/3/2021 11:42:34'!
test06transferRegitersValue
	
	|transfer|
	transfer:=Transfer from: account1 to:account2 withAmount: 100.
	self assert: transfer value equals: 100
	
	

	
	
	

	
	! !

!Portfolio2Test methodsFor: 'transferTests' stamp: 'SB 6/3/2021 11:42:49'!
test07transferCantTakeNegativeValues
	
	self 
		should: [ Transfer from: account1 to:account2 withAmount: -100. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
				self assert: Transfer negativeValueTransfer equals: anError messageText.
			]
	
	

	
	
	

	
	! !

!Portfolio2Test methodsFor: 'transferTests' stamp: 'SB 6/3/2021 15:42:41'!
test23transferHasOnlyOneValue
	|transfer recieverLeg senderLeg|
	transfer:=Transfer from: account1 to:account2 withAmount: 10000 factorial.
	recieverLeg:= transfer recieverLeg.
	senderLeg := transfer senderLeg.
	
	self assert: (recieverLeg value == senderLeg value) equals:  true.
	

	
	
	

	
	! !


!Portfolio2Test methodsFor: 'transferNetTest' stamp: 'SB 6/3/2021 15:22:45'!
test15transferNetNoTransaction
	
	self assert: (account1 generateReport: TransferNetReport new)  equals: 0.
	
	

	

	
	
	

	
	! !

!Portfolio2Test methodsFor: 'transferNetTest' stamp: 'SB 6/3/2021 15:22:45'!
test16transferNetInboundTransaction100
	

	Transfer from: account1 to:account2  	withAmount:100.
	self assert: (account2 generateReport: TransferNetReport new)  equals: 100.
	
	

	

	
	
	

	
	! !

!Portfolio2Test methodsFor: 'transferNetTest' stamp: 'SB 6/3/2021 15:22:45'!
test17transferNetOutboundTransaction100
	
	Transfer from: account1 to:account2  	withAmount:100.
	self assert: (account1 generateReport: TransferNetReport new)  equals: 100 negated.
	
	

	

	
	
	

	
	! !

!Portfolio2Test methodsFor: 'transferNetTest' stamp: 'SB 6/3/2021 15:28:09'!
test22transferNetWithDepositAndWithdrawAreNotConsidered
	
	Withdraw register: 100 on: account1.
	Deposit register: 100 on: account1.

	self assert: (account1 generateReport: TransferNetReport new)  equals: 0 .
	
	

	

	
	
	

	
	! !

!Portfolio2Test methodsFor: 'transferNetTest' stamp: 'SB 6/3/2021 15:58:21'!
test25transferNetWithPortfolioIncludingAccount

	Deposit register: 100 on: account1.
	Withdraw register: 200 on: account1.
	Transfer from: account1 to:account2 withAmount: 100.
	Transfer from: account2 to:account1 withAmount: 300.
	portfolio1 := Portfolio with: account1.
				
	self assert: (portfolio1 generateReport: TransferNetReport new) equals: 200 .
	
	

	

	
	
	

	
	! !

!Portfolio2Test methodsFor: 'transferNetTest' stamp: 'SB 6/3/2021 15:58:16'!
test26transferNetWithPortfolioWithPortfolio

	Deposit register: 100 on: account1.
	Withdraw register: 200 on: account1.
	Transfer from: account1 to:account2 withAmount: 100.
	Transfer from: account2 to:account1 withAmount: 400.

	portfolio1 := Portfolio with: account1.
	portfolio2 := Portfolio with: portfolio1.			
	self assert: (portfolio2 generateReport: TransferNetReport new) equals: 300 .
	
	

	

	
	
	

	
	! !

!Portfolio2Test methodsFor: 'transferNetTest' stamp: 'SB 6/3/2021 15:58:07'!
test27transferNetWithPortfolioWithTwoPortfolioAndOneAccountOnEach	
	Transfer from: account1 to:account2 withAmount: 100.
	Transfer from: account2 to:account1 withAmount: 400.
	portfolio1 := Portfolio with: account1.
	portfolio2 := Portfolio with: account2.
	portfolio add: portfolio1 .
	portfolio add: portfolio2 .
	
	self assert: (portfolio generateReport: TransferNetReport new) equals: 0 .
	
	

	

	
	
	

	
	! !


!Portfolio2Test methodsFor: 'accountSummaryTest' stamp: 'SB 6/3/2021 15:22:29'!
test08accountSummaryBalanceAmount0
	
self assertReport: (account1 generateReport: 		AccountSummaryReport  new)         EqualsExpectedReport:(OrderedCollection with: 'Balance = 0')
	

	
	
	

	
	! !

!Portfolio2Test methodsFor: 'accountSummaryTest' stamp: 'SB 6/3/2021 15:22:29'!
test09accountSummaryDepositAmount100
	
	Deposit register: 100 on: account1.
	
	self assertReport: (account1 generateReport: 		AccountSummaryReport  new)         EqualsExpectedReport:(OrderedCollection with: 'Deposito por 100' with:'Balance = 100')
	

	

	
	
	

	
	! !

!Portfolio2Test methodsFor: 'accountSummaryTest' stamp: 'SB 6/3/2021 15:22:29'!
test10accountSummaryTwoDepositAmount250
	
	Deposit register: 100 on: account1.
	Deposit register: 150 on: account1.

	self assertReport: (account1 generateReport: 		AccountSummaryReport  new)         EqualsExpectedReport:(OrderedCollection with: 'Deposito por 100' with: 'Deposito por 150'with: 'Balance = 250')
	

	

	
	
	

	
	! !

!Portfolio2Test methodsFor: 'accountSummaryTest' stamp: 'SB 6/3/2021 15:22:29'!
test11accountSummaryWithdrawAmount100
	
	Withdraw register: 100 on: account1.

	self assertReport: (account1 generateReport: 		AccountSummaryReport  new)         EqualsExpectedReport:(OrderedCollection with: 'Extraccion por 100' with:'Balance = -100')

	

	
	
	

	
	! !

!Portfolio2Test methodsFor: 'accountSummaryTest' stamp: 'SB 6/3/2021 15:22:29'!
test12accountSummaryTwoWithdrawAmount100

	Withdraw register: 100 on: account1.
	Withdraw register: 150 on: account1.

	self assertReport: (account1 generateReport: 		AccountSummaryReport  new) EqualsExpectedReport:(OrderedCollection with: 'Extraccion por 100' with: 'Extraccion por 150' with:'Balance = -250')

	

	
	
	

	
	! !

!Portfolio2Test methodsFor: 'accountSummaryTest' stamp: 'SB 6/3/2021 15:22:29'!
test13accountSummaryOutboundTransfer
	
	Transfer from: account1 to: account2  withAmount: 200.	
	
	self assertReport: (account1 generateReport: 		AccountSummaryReport  new) EqualsExpectedReport:( OrderedCollection with: 'Salida por transferencia de 200'with:'Balance = -200')

	

	
	
	

	
	! !

!Portfolio2Test methodsFor: 'accountSummaryTest' stamp: 'SB 6/3/2021 15:22:29'!
test14accountSummaryInboundTransfer
	
	Transfer from: account1 to: account2  withAmount: 200.	
	
	self assertReport: (account2 generateReport: 		AccountSummaryReport  new) EqualsExpectedReport:( OrderedCollection with: 'Entrada por transferencia de 200'with: 'Balance = 200')

	

	
	
	

	
	! !

!Portfolio2Test methodsFor: 'accountSummaryTest' stamp: 'SB 6/3/2021 15:22:29'!
test18accountSummaryEmptyPortfolio
	
self assertReport: (account2 generateReport: 		AccountSummaryReport  new) EqualsExpectedReport: (OrderedCollection with: 'Balance = 0')
	

	
	
	

	
	! !

!Portfolio2Test methodsFor: 'accountSummaryTest' stamp: 'SB 6/3/2021 15:22:29'!
test19accountSummaryPortfolioWithOneAccount
	
	Deposit register: 100 on: account1.
	Withdraw register: 150 on: account1.
	Transfer from: account1 to: account2 withAmount: 150.
	Transfer from: account2 to: account1 withAmount: 350.
	portfolio1 add: account1.
	
	self assert: ((portfolio1 generateReport: 		AccountSummaryReport  new) = (account1 generateReport: 		AccountSummaryReport  new)) .

	

	
	
	

	
	! !

!Portfolio2Test methodsFor: 'accountSummaryTest' stamp: 'SB 6/3/2021 15:22:29'!
test20accountSummaryPortfolioWithTwoAccount
	| mensajeEsperado|
	
	portfolio1 add: account1.
	portfolio1 add: account2.
	Deposit register: 150 on: account1.
	Withdraw register: 100 on: account2.
	Transfer from: account1 to: account2 withAmount: 300.
	
	mensajeEsperado:= OrderedCollection with: 'Deposito por 150' with: 'Salida por transferencia de 300' with: 'Extraccion por 100' with: 'Entrada por transferencia de 300' with: 'Balance = 50'.
	self assert: (portfolio1 generateReport: 		AccountSummaryReport  new) equals: mensajeEsperado .

	

	
	
	

	
	! !

!Portfolio2Test methodsFor: 'accountSummaryTest' stamp: 'SB 6/3/2021 15:22:29'!
test21accountSummaryPortfolioWithPortfolio
	| mensajeEsperado|
	
	portfolio1 add: account1.
	portfolio2 add: portfolio1.
	Deposit register: 150 on: account1.
	Withdraw register: 100 on: account1.
	Transfer from: account1 to: account2 withAmount: 300.
	
	mensajeEsperado:= OrderedCollection with: 'Deposito por 150' with: 'Extraccion por 100' with: 'Salida por transferencia de 300' with: 'Balance = -250'.	
	self assert: (portfolio2 generateReport: 		AccountSummaryReport  new) equals: mensajeEsperado .
	
	

	
	
	

	
	! !


!Portfolio2Test methodsFor: 'setUp' stamp: 'SB 6/3/2021 11:38:09'!
setUp
	portfolio := Portfolio  new.
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account1 := ReceptiveAccount  new.
	account2 := ReceptiveAccount new.
	! !


!Portfolio2Test methodsFor: 'private - assertion' stamp: 'SB 6/3/2021 11:55:33'!
assertReport: aReport EqualsExpectedReport: aExpectedReport
	self assert: aReport = aExpectedReport ! !


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


!Account methodsFor: 'transactions' stamp: 'SB 6/3/2021 10:15:48'!
addTransactionsTo: aCollectionOfTransactions
	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'SB 6/3/2021 10:15:55'!
addedTo: aPortfolio
	self subclassResponsibility ! !


!Account methodsFor: 'report' stamp: 'SB 6/3/2021 14:33:33'!
generatePartialReport: aReportGenerator
	self subclassResponsibility .! !

!Account methodsFor: 'report' stamp: 'SB 6/3/2021 14:36:21'!
generateReport: aReportGenerator
	self subclassResponsibility .! !


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


!Portfolio methodsFor: 'report' stamp: 'SB 6/3/2021 14:36:11'!
generatePartialReport: aReportMethod

	accounts do:[:anAccount| anAccount generatePartialReport: aReportMethod].
! !

!Portfolio methodsFor: 'report' stamp: 'SB 6/3/2021 14:36:00'!
generateReport: aReportMethod 

	self generatePartialReport:  aReportMethod .
	^aReportMethod finishReport.! !

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
	instanceVariableNames: 'transactions transfers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'Am 5/27/2021 21:08:46'!
initialize

	super initialize.
	transactions := OrderedCollection new.
	transfers := OrderedCollection new.! !


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


!ReceptiveAccount methodsFor: 'balance' stamp: 'Am 6/2/2021 17:26:32'!
balance
	
	^(transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance]).! !


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


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'Am 6/2/2021 15:21:35'!
registerTransfer: aTransfer 
	transactions add: aTransfer.! !


!ReceptiveAccount methodsFor: 'report' stamp: 'SB 6/3/2021 14:34:32'!
generatePartialReport: aReportGenerator
	transactions do: [:aTransaction| aTransaction reportTo: aReportGenerator].
	! !

!ReceptiveAccount methodsFor: 'report' stamp: 'SB 6/3/2021 14:34:46'!
generateReport: aReportGenerator
	self generatePartialReport: aReportGenerator .
	^aReportGenerator finishReport.
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


!AccountTransaction methodsFor: 'report' stamp: 'Am 6/2/2021 18:20:03'!
reportTo: aReportSet
self subclassResponsibility 
	! !

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


!Deposit methodsFor: 'report' stamp: 'Am 6/2/2021 20:07:27'!
reportTo: aMethodAccountSummary
	aMethodAccountSummary reportDeposit: self.! !

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

!TransferLeg methodsFor: 'accesing' stamp: 'Am 6/2/2021 17:47:08'!
otherLeg
	self subclassResponsibility ! !


!TransferLeg methodsFor: 'balance' stamp: 'Am 6/2/2021 17:25:34'!
affectBalance: aBalance

	self subclassResponsibility ! !


!TransferLeg methodsFor: 'value' stamp: 'Am 6/2/2021 17:23:11'!
value
	self subclassResponsibility ! !


!TransferLeg methodsFor: 'report' stamp: 'Am 6/2/2021 18:20:24'!
reportTo: aReportSet
	self subclassResponsibility ! !


!TransferLeg methodsFor: 'initialization' stamp: 'Am 6/2/2021 17:39:39'!
initializeFor: aTransfer
	transfer := aTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'Portfolio-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'Am 6/2/2021 17:12:19'!
forTransfer: aTransfer
	^ self new initializeFor: aTransfer! !


!classDefinition: #RecieverLeg category: 'Portfolio-Solucion'!
TransferLeg subclass: #RecieverLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!RecieverLeg methodsFor: 'balance' stamp: 'Am 6/2/2021 17:25:45'!
affectBalance: aBalance

	^aBalance + transfer value ! !


!RecieverLeg methodsFor: 'value' stamp: 'Am 6/2/2021 17:23:26'!
value
	^transfer value.! !


!RecieverLeg methodsFor: 'report' stamp: 'SB 6/3/2021 10:20:19'!
reportTo: aMethodAccountSummary
	aMethodAccountSummary reportRecieverLeg: self.! !


!RecieverLeg methodsFor: 'accesing' stamp: 'Am 6/2/2021 17:54:12'!
otherLeg
	^transfer  senderLeg.! !


!classDefinition: #SenderLeg category: 'Portfolio-Solucion'!
TransferLeg subclass: #SenderLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SenderLeg methodsFor: 'balance' stamp: 'Am 6/2/2021 17:25:57'!
affectBalance: aBalance

	^aBalance - transfer value ! !


!SenderLeg methodsFor: 'report' stamp: 'Am 6/2/2021 20:08:56'!
reportTo: aMethodAccountSummary
	
	aMethodAccountSummary reportSenderLeg: self.! !


!SenderLeg methodsFor: 'value' stamp: 'Am 6/2/2021 17:23:44'!
value
	^transfer value! !


!SenderLeg methodsFor: 'accesing' stamp: 'Am 6/2/2021 17:53:49'!
otherLeg	

^transfer recieverLeg.! !


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


!Withdraw methodsFor: 'balance' stamp: 'SB 6/3/2021 10:15:34'!
affectBalance: aBalance
	^aBalance - value! !


!Withdraw methodsFor: 'report' stamp: 'Am 6/2/2021 20:09:53'!
reportTo: aMethodAccountSummary
	aMethodAccountSummary reportWithdraw: self.! !

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

!Report methodsFor: 'initialization' stamp: 'Am 6/2/2021 20:55:20'!
initialize
	
	self subclassResponsibility .! !


!Report methodsFor: 'evaluating' stamp: 'Am 6/2/2021 20:55:09'!
finishReport										
	self subclassResponsibility .! !


!Report methodsFor: 'report' stamp: 'Am 6/2/2021 20:55:34'!
reportDeposit: aDeposit 
	self subclassResponsibility .
	
	! !

!Report methodsFor: 'report' stamp: 'Am 6/2/2021 20:55:38'!
reportRecieverLeg: aRecieverLeg 
	
	self subclassResponsibility .! !

!Report methodsFor: 'report' stamp: 'Am 6/2/2021 20:55:41'!
reportSenderLeg: aSenderLeg 
	
	self subclassResponsibility .! !

!Report methodsFor: 'report' stamp: 'Am 6/2/2021 20:55:50'!
reportWithdraw: aWithdraw 
 		self subclassResponsibility .
	! !


!classDefinition: #AccountSummaryReport category: 'Portfolio-Solucion'!
Report subclass: #AccountSummaryReport
	instanceVariableNames: 'reporte balance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryReport methodsFor: 'initialization' stamp: 'Am 6/2/2021 20:40:03'!
initialize
	reporte :=OrderedCollection new.
	balance:=0.! !


!AccountSummaryReport methodsFor: 'evaluating' stamp: 'Am 6/2/2021 20:42:07'!
finishReport										
	reporte addLast: ('Balance = ', balance asString).
	^ reporte.! !


!AccountSummaryReport methodsFor: 'report' stamp: 'Am 6/2/2021 20:41:05'!
reportDeposit: aDeposit 
	reporte add: ('Deposito por ', aDeposit value asString).
	balance:= balance+aDeposit value.
	! !

!AccountSummaryReport methodsFor: 'report' stamp: 'Am 6/2/2021 20:40:56'!
reportRecieverLeg: aRecieverLeg 
	reporte add: ('Entrada por transferencia de ', aRecieverLeg value asString).
	balance:= balance+ aRecieverLeg value.! !

!AccountSummaryReport methodsFor: 'report' stamp: 'Am 6/2/2021 20:41:25'!
reportSenderLeg: aSenderLeg 
	reporte add: ('Salida por transferencia de ', aSenderLeg value asString).
	balance:= balance -aSenderLeg value.! !

!AccountSummaryReport methodsFor: 'report' stamp: 'Am 6/2/2021 20:41:50'!
reportWithdraw: aWithdraw 
	reporte add: ('Extraccion por ', aWithdraw value asString).
	balance:= balance - aWithdraw value.! !


!classDefinition: #TransferNetReport category: 'Portfolio-Solucion'!
Report subclass: #TransferNetReport
	instanceVariableNames: 'balance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetReport methodsFor: 'initialization' stamp: 'Am 6/2/2021 20:48:56'!
initialize
	
	balance:=0.! !


!TransferNetReport methodsFor: 'evaluating' stamp: 'Am 6/2/2021 20:48:39'!
finishReport										
	^ balance.! !


!TransferNetReport methodsFor: 'report' stamp: 'Am 6/2/2021 20:49:07'!
reportDeposit: aDeposit 
	
	! !

!TransferNetReport methodsFor: 'report' stamp: 'Am 6/2/2021 20:49:28'!
reportRecieverLeg: aRecieverLeg 
	
	balance:= balance+ aRecieverLeg value.! !

!TransferNetReport methodsFor: 'report' stamp: 'Am 6/2/2021 20:49:35'!
reportSenderLeg: aSenderLeg 
	
	balance:= balance -aSenderLeg value.! !

!TransferNetReport methodsFor: 'report' stamp: 'SB 6/3/2021 15:30:24'!
reportWithdraw: aWithdraw 
	! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'reciever sender amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'SB 6/3/2021 10:47:42'!
madeFrom: aSenderAccount to: aRecieverAccount withAmount: anAmount 

	self assertValidTransferWithSender: aSenderAccount aReceiver: aRecieverAccount andAmount: anAmount.
	
	self setTransferLegsUsingSenderLeg: aRecieverAccount andReceiverLeg: aSenderAccount.
	amount:= anAmount.! !


!Transfer methodsFor: 'accesing' stamp: 'Am 6/2/2021 17:48:00'!
recieverLeg
	^reciever.! !

!Transfer methodsFor: 'accesing' stamp: 'Am 6/2/2021 17:47:33'!
senderLeg
	^sender! !

!Transfer methodsFor: 'accesing' stamp: 'Am 5/30/2021 18:31:45'!
value
	^amount.! !


!Transfer methodsFor: 'assert' stamp: 'SB 6/3/2021 10:48:20'!
assertValidTransferWithSender: aSender aReceiver: aReceiver andAmount: anAmount

	anAmount <=0 ifTrue:[self error: self class negativeValueTransfer ].
	aSender = aReceiver ifTrue:[self error: self class sameLegsTransfer ].
	

! !


!Transfer methodsFor: 'private' stamp: 'SB 6/3/2021 10:47:10'!
setTransferLegsUsingSenderLeg: aRecieverAccount andReceiverLeg: aSenderAccount

	sender:=SenderLeg forTransfer: self.
	reciever:= RecieverLeg forTransfer: self.
	aSenderAccount registerTransfer: sender.
	aRecieverAccount registerTransfer: reciever! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'initialization' stamp: 'Am 5/30/2021 18:27:15'!
from: aReceptiveAccount to: aReceptiveAccount2 withAmount: anAmount 
	|aTransfer|
	aTransfer:=Transfer new.
	aTransfer madeFrom: aReceptiveAccount to: aReceptiveAccount2  withAmount: anAmount.
	^aTransfer.
	! !


!Transfer class methodsFor: 'errors' stamp: 'SB 6/3/2021 10:33:54'!
negativeValueTransfer
	^'Cannot do a negative value transfer'! !

!Transfer class methodsFor: 'errors' stamp: 'SB 6/3/2021 10:40:29'!
sameLegsTransfer
	^ 'Sender leg cannot be the same as the receiver leg'! !
