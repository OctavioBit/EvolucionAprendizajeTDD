!classDefinition: #PortfolioTest category: 'Portfolio2'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

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


!classDefinition: #ReceptiveAccountTest category: 'Portfolio2'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

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


!classDefinition: #TranferTest category: 'Portfolio2'!
TestCase subclass: #TranferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!TranferTest methodsFor: 'testing error - negative transfer' stamp: 'CS 6/3/2021 00:14:40'!
test02ShouldSendAnErrorWhenYouWantToTransferANegativeAmount

	|transfer accountTransfering accountReceiving|
	
	transfer  := Transfer new.
	
	accountTransfering := ReceptiveAccount new.
	Deposit register: 100 on: accountTransfering.
	
	accountReceiving := ReceptiveAccount new.
	
	self should: [ transfer transferFromTheAccount: accountTransfering toAccount: accountReceiving withAmount: -100. ]
		raise: Error
		withMessageText: ReceptiveAccount describeErrorMessage! !


!TranferTest methodsFor: 'testing - balance' stamp: 'CS 6/3/2021 00:09:30'!
test01AssertBalanceOfAccountsWithTransfer

	| transfer accountTransfering accountReceiving |
	
	transfer  := Transfer new.
	
	accountTransfering := ReceptiveAccount new.
	Deposit register: 100 on: accountTransfering.
	
	accountReceiving := ReceptiveAccount new.
	
	transfer transferFromTheAccount: accountTransfering toAccount: accountReceiving withAmount: 60.
	
	self assert: accountTransfering balance equals: 40.
	self assert: accountReceiving balance equals: 60.! !


!TranferTest methodsFor: 'testing - hasRegistered' stamp: 'CS 6/3/2021 15:52:36'!
test03AssertHasRegisteredOfAccountsWithTransfer

	self checkHasRegisteredOnTheInstanceOfAccountWithTransfer:
	
	[:accountTransfering :accountReceiving :depositLeg :withdrawLeg|
		
		self assert: (accountReceiving  hasRegistered: depositLeg).
		self assert: (accountTransfering  hasRegistered: withdrawLeg)].! !

!TranferTest methodsFor: 'testing - hasRegistered' stamp: 'CS 6/3/2021 15:53:26'!
test04DenyHasRegisteredOfAccountsWithTransfer

    self checkHasRegisteredOnTheInstanceOfAccountWithTransfer:

	[:accountTransfering :accountReceiving :depositLeg :withdrawLeg| 

		self deny: (accountTransfering hasRegistered: depositLeg).
		self deny: (accountReceiving  hasRegistered: withdrawLeg).].! !


!TranferTest methodsFor: 'testing - AccountSummary' stamp: 'CS 6/3/2021 15:07:44'!
test05AccountSummaryForAReceptiveAccountWithoutTransactions

	| accountSummary accountSummaryReporter account |
	
	account := ReceptiveAccount new.

	accountSummaryReporter := AccountSummary for: account.
	accountSummary := accountSummaryReporter accountSummary.
	
	self assert: (accountSummary at: 1) equals: 'Balance = 0'.
	self assert: (accountSummary size) equals: 1.! !

!TranferTest methodsFor: 'testing - AccountSummary' stamp: 'CS 6/3/2021 15:27:26'!
test06AccountSummaryForReceptiveAccountsWithOnlyADeposit

	| accountTransfering accountSummary accountSummaryReporter |
	
	accountTransfering := ReceptiveAccount new.
	Deposit register: 100 on: accountTransfering.

	accountSummaryReporter := AccountSummary for: accountTransfering.
	accountSummary := accountSummaryReporter accountSummary.
	
	self assert: (accountSummary at: 1) equals: 'Deposito por 100'.
	self assert: (accountSummary at: 2) equals: 'Balance = 100'.
	self assert: (accountSummary size) equals: 2.! !

!TranferTest methodsFor: 'testing - AccountSummary' stamp: 'CS 6/3/2021 15:27:46'!
test07AccountSummaryForReceptiveAccountsWithOnlyAWithdraw

	| accountTransfering accountSummary accountSummaryReporter |
	
	accountTransfering := ReceptiveAccount new.
	Withdraw register: 50 on: accountTransfering.

	accountSummaryReporter := AccountSummary for: accountTransfering.
	accountSummary := accountSummaryReporter accountSummary.
	
	self assert: (accountSummary at: 1) equals: 'Extraccion por 50'.
	self assert: (accountSummary at: 2) equals: 'Balance = -50'.
	self assert: (accountSummary size) equals: 2.! !

!TranferTest methodsFor: 'testing - AccountSummary' stamp: 'CS 6/3/2021 15:27:59'!
test08AccountSummaryForReceptiveAccountsWithOnlyAWithdrawLeg

	| accountReceiving accountTransfering transfer accountSummary accountSummaryReporter |
	
	accountTransfering := ReceptiveAccount new.
	
	accountReceiving := ReceptiveAccount new.

	transfer := Transfer new.
	transfer transferFromTheAccount: accountTransfering toAccount: accountReceiving withAmount: 10.

	accountSummaryReporter := AccountSummary for: accountTransfering.
	accountSummary := accountSummaryReporter accountSummary.
	
	self assert: (accountSummary at: 1) equals: 'Salida por transferencia de 10'.
	self assert: (accountSummary at: 2) equals: 'Balance = -10'.
	self assert: (accountSummary size) equals: 2.! !

!TranferTest methodsFor: 'testing - AccountSummary' stamp: 'CS 6/3/2021 15:28:16'!
test09AccountSummaryForReceptiveAccountsWithOnlyADepositLeg

	| accountReceiving accountTransfering transfer accountSummary accountSummaryReporter |
	
	accountTransfering := ReceptiveAccount new.
	
	accountReceiving := ReceptiveAccount new.

	transfer := Transfer new.
	transfer transferFromTheAccount: accountTransfering toAccount: accountReceiving withAmount: 10.

	accountSummaryReporter := AccountSummary for: accountReceiving.
	accountSummary := accountSummaryReporter accountSummary.
	
	self assert: (accountSummary at: 1) equals: 'Entrada por transferencia de 10'.
	self assert: (accountSummary at: 2) equals: 'Balance = 10'.
	self assert: (accountSummary size) equals: 2.! !

!TranferTest methodsFor: 'testing - AccountSummary' stamp: 'CS 6/3/2021 15:41:04'!
test10AccountSumaryForReceptiveAccountsWithManyDiferentsTransactions

	| accountSummary accountSummaryReporter account |

	account := self instanceOfAccountWithManyTransactions.
	
	accountSummaryReporter := AccountSummary for: account.
	accountSummary := accountSummaryReporter accountSummary.
	
	self assert: (accountSummary at: 1) equals: 'Deposito por 100'.
	self assert: (accountSummary at: 2) equals: 'Extraccion por 50'.
	self assert: (accountSummary at: 3) equals: 'Salida por transferencia de 10'.
	self assert: (accountSummary at: 4) equals: 'Entrada por transferencia de 30'.
	self assert: (accountSummary at: 5) equals: 'Balance = 70'.
	self assert: (accountSummary size) equals: 5.! !

!TranferTest methodsFor: 'testing - AccountSummary' stamp: 'CS 6/3/2021 15:28:43'!
test11AccountSumaryForPortfolioWithAccount
	| account2 account1 portfolio1 transfer accountSummary accountSummaryReporter |
	
	account1 := ReceptiveAccount new.
	portfolio1 := Portfolio with: account1.
		
	transfer := Transfer new.
	
	account2 := ReceptiveAccount new.

	transfer transferFromTheAccount: account1 toAccount: account2 withAmount: 10.

	accountSummaryReporter := AccountSummary for: portfolio1.
	accountSummary := accountSummaryReporter accountSummary.
	
	self assert: (accountSummary at: 1) equals: 'Salida por transferencia de 10'.
	self assert: (accountSummary at: 2) equals: 'Balance = -10'.
	self assert: (accountSummary size) equals: 2.! !

!TranferTest methodsFor: 'testing - AccountSummary' stamp: 'CS 6/3/2021 15:45:58'!
test12AccountSumaryPortfoliosWithPortfolios
	
	| accountSummary composedPortfolio accountSummaryReporter |

	composedPortfolio := self instanceOfPortfolioWithPortfolio.

	accountSummaryReporter := AccountSummary for: composedPortfolio.
	accountSummary := accountSummaryReporter accountSummary.

	self assert: (accountSummary at: 1) equals: 'Deposito por 50'.
	self assert: (accountSummary at: 2) equals: 'Entrada por transferencia de 10'.
	self assert: (accountSummary at: 3) equals: 'Balance = 60'.
	self assert: (accountSummary size) equals: 3.! !


!TranferTest methodsFor: 'testing - TransferNet' stamp: 'CS 6/3/2021 01:16:01'!
test13TransferNetForAReceptiveAccountWithoutTransactions

	| account transferNetReporter |
	
	account := ReceptiveAccount new.
	
	transferNetReporter := TransferNet for: account.

	self assert: (transferNetReporter transferNet) equals: 0.! !

!TranferTest methodsFor: 'testing - TransferNet' stamp: 'CS 6/3/2021 01:22:28'!
test14TransferNetForReceptiveAccountsWithOnlyADeposit

	| accountTransfering transferNetReporter transferNet |
	
	accountTransfering := ReceptiveAccount new.
	Deposit register: 100 on: accountTransfering.

	transferNetReporter := TransferNet for: accountTransfering.
	transferNet := transferNetReporter transferNet.

	self assert: transferNet equals: 0.! !

!TranferTest methodsFor: 'testing - TransferNet' stamp: 'CS 6/3/2021 01:28:12'!
test15TransferNetForReceptiveAccountsWithOnlyAWithdraw

	| accountTransfering transferNetReporter transferNet |
	
	accountTransfering := ReceptiveAccount new.
	Withdraw register: 50 on: accountTransfering.

	transferNetReporter := TransferNet for: accountTransfering.
	transferNet := transferNetReporter transferNet.

	self assert: transferNet equals: 0.! !

!TranferTest methodsFor: 'testing - TransferNet' stamp: 'CS 6/3/2021 01:29:49'!
test16TransferNetForReceptiveAccountsWithOnlyADepositLeg

	| accountReceiving accountTransfering transfer transferNet transferNetReporter |
	
	accountTransfering := ReceptiveAccount new.
	
	accountReceiving := ReceptiveAccount new.

	transfer := Transfer new.
	transfer transferFromTheAccount: accountTransfering toAccount: accountReceiving withAmount: 10.

	transferNetReporter := TransferNet for: accountTransfering.
	transferNet := transferNetReporter transferNet.

	self assert: transferNet equals: -10.! !

!TranferTest methodsFor: 'testing - TransferNet' stamp: 'CS 6/3/2021 01:34:10'!
test17TransferNetForReceptiveAccountsWithOnlyAWithdrawLeg

	| accountReceiving accountTransfering transfer transferNet transferNetReporter |
	
	accountTransfering := ReceptiveAccount new.
	
	accountReceiving := ReceptiveAccount new.

	transfer := Transfer new.
	transfer transferFromTheAccount: accountTransfering toAccount: accountReceiving withAmount: 10.

	transferNetReporter := TransferNet for: accountTransfering.
	transferNet := transferNetReporter transferNet.

	self assert: transferNet equals: -10.! !

!TranferTest methodsFor: 'testing - TransferNet' stamp: 'CS 6/3/2021 15:43:16'!
test18TransferNetForReceptiveAccountsWithDiferentsTransactions

	| account transfer transferNet transferNetReporter |

	account := self instanceOfAccountWithManyTransactions.

	transferNetReporter := TransferNet for: account.
	transferNet := transferNetReporter transferNet.

	self assert: transferNet equals: 20.! !

!TranferTest methodsFor: 'testing - TransferNet' stamp: 'CS 6/3/2021 01:36:07'!
test19TransferNetForPortfolioWithAccount

	| account2 account1 portfolio1 transfer transferNet transferNetReporter |
	
	account1 := ReceptiveAccount new.
	portfolio1 := Portfolio with: account1.
		
	transfer := Transfer new.
	
	account2 := ReceptiveAccount new.

	transfer transferFromTheAccount: account1 toAccount: account2 withAmount: 10.

	transferNetReporter := TransferNet for: portfolio1.
	transferNet := transferNetReporter transferNet.

	self assert: transferNet equals: -10.! !

!TranferTest methodsFor: 'testing - TransferNet' stamp: 'CS 6/3/2021 15:46:35'!
test20TransferNetForPortfolioWithPortfolios
	
	| composedPortfolio transferNet transferNetReporter |
	
	composedPortfolio := self instanceOfPortfolioWithPortfolio.

	transferNetReporter := TransferNet for: composedPortfolio.
	transferNet := transferNetReporter transferNet.

	self assert: transferNet equals: 10.! !


!TranferTest methodsFor: 'initialize instance account' stamp: 'CS 6/3/2021 15:41:59'!
instanceOfAccountWithManyTransactions

	| accountReceiving accountTransfering transfer |
	
	accountTransfering := ReceptiveAccount new.
	transfer := Transfer new.

	Deposit register: 100 on: accountTransfering.
	Withdraw register: 50 on: accountTransfering.
	
	accountReceiving := ReceptiveAccount new.

	transfer transferFromTheAccount: accountTransfering toAccount: accountReceiving withAmount: 10.
	transfer transferFromTheAccount: accountReceiving toAccount: accountTransfering withAmount: 30.
	
	^ accountTransfering! !


!TranferTest methodsFor: 'initialize instance portfolio with portfolio' stamp: 'CS 6/3/2021 15:45:26'!
instanceOfPortfolioWithPortfolio

	| account1 account2 composedPortfolio simplePortfolio transfer |
	account1 := ReceptiveAccount new.
	Deposit register: 50 on: account1.
	
	simplePortfolio := Portfolio with: account1.

	composedPortfolio := Portfolio with: simplePortfolio.
	
	account2 := ReceptiveAccount new.

	transfer := Transfer new.
	transfer transferFromTheAccount: account2 toAccount: account1 withAmount: 10.
	
	^ composedPortfolio.! !


!TranferTest methodsFor: 'check has registered in account with transfer' stamp: 'CS 6/3/2021 15:56:58'!
checkHasRegisteredOnTheInstanceOfAccountWithTransfer: conditionsToCheck

    | transfer accountTransfering accountReceiving depositLeg withdrawLeg | 

    transfer  := Transfer new.

    accountTransfering := ReceptiveAccount new.
    Deposit register: 100 on: accountTransfering.

    accountReceiving := ReceptiveAccount new.

    transfer transferFromTheAccount: accountTransfering toAccount: accountReceiving withAmount: 60.
    depositLeg := transfer depositLeg.
    withdrawLeg := transfer withdrawLeg.

    ^ conditionsToCheck value:accountTransfering value:accountReceiving value:depositLeg value:withdrawLeg! !

!TranferTest methodsFor: 'check has registered in account with transfer' stamp: 'CS 6/3/2021 15:48:49'!
instanceForCheckHasRegisteredOfAccountsWithTransfer! !


!classDefinition: #Account category: 'Portfolio2'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

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


!classDefinition: #Portfolio category: 'Portfolio2'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

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


!Portfolio methodsFor: 'report' stamp: 'CS 6/3/2021 15:18:01'!
doReportTo: anAccountSummaryReporter

	accounts do: [ :anAccount | anAccount doReportTo: anAccountSummaryReporter]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio2'!
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


!classDefinition: #ReceptiveAccount category: 'Portfolio2'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

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

!ReceptiveAccount methodsFor: 'transactions' stamp: 'ms 6/1/2021 20:06:08'!
transactions

	^transactions ! !


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


!ReceptiveAccount methodsFor: 'report' stamp: 'CS 6/2/2021 23:06:12'!
doReportTo: anAccountSummaryReporter

	transactions do: [ : transaction  |	 transaction contributesToTheReportOf: anAccountSummaryReporter].
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio2'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'ms 5/27/2021 21:46:37'!
describeErrorMessage

	^'No puede ser cero o negativo'! !


!classDefinition: #AccountTransaction category: 'Portfolio2'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'reports' stamp: 'CS 6/2/2021 23:04:19'!
contributesToTheReportOf: anAccountSummaryReporter

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio2'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio2'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value totalDeposit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!Deposit methodsFor: 'initialization' stamp: 'CS 6/2/2021 22:44:30'!
initializeFor: aValue

	value := aValue.! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'CS 5/30/2021 11:07:32'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'reports' stamp: 'CS 6/2/2021 23:05:59'!
contributesToTheReportOf: anAccountSummaryReporter

	^ anAccountSummaryReporter visitDeposit: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio2'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLegs category: 'Portfolio2'!
AccountTransaction subclass: #TransferLegs
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!TransferLegs methodsFor: 'balance' stamp: 'CS 6/2/2021 23:08:02'!
affectBalance: aBalance

	self subclassResponsibility! !


!TransferLegs methodsFor: 'reports' stamp: 'CS 6/2/2021 23:09:01'!
contributesToTheReportOf: anAccountSummaryReporter

	self subclassResponsibility! !


!TransferLegs methodsFor: 'value' stamp: 'CS 6/2/2021 23:09:37'!
value

	self subclassResponsibility! !


!TransferLegs methodsFor: 'initialization' stamp: 'CS 6/2/2021 23:50:32'!
initializeFor: aValue

	value := aValue! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLegs class' category: 'Portfolio2'!
TransferLegs class
	instanceVariableNames: ''!

!TransferLegs class methodsFor: 'registered' stamp: 'CS 6/3/2021 00:44:01'!
register: aTransfer on: anAccount

	| transaction |
	
	transaction := self for: aTransfer value.
	anAccount register: transaction.
		
	^ transaction! !


!classDefinition: #DepositLeg category: 'Portfolio2'!
TransferLegs subclass: #DepositLeg
	instanceVariableNames: 'totalDepositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!DepositLeg methodsFor: 'balance' stamp: 'CS 5/30/2021 10:53:34'!
affectBalance: aBalance

	^aBalance + value! !


!DepositLeg methodsFor: 'reports' stamp: 'CS 6/2/2021 23:06:21'!
contributesToTheReportOf: anAccountSummaryReporter

	^ anAccountSummaryReporter visitDepositLeg: self! !


!DepositLeg methodsFor: 'value' stamp: 'CS 5/30/2021 10:54:59'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DepositLeg class' category: 'Portfolio2'!
DepositLeg class
	instanceVariableNames: ''!

!DepositLeg class methodsFor: 'initialization' stamp: 'CS 5/30/2021 13:06:42'!
for: aValue

	^ self new initializeFor: aValue! !


!classDefinition: #WithdrawLeg category: 'Portfolio2'!
TransferLegs subclass: #WithdrawLeg
	instanceVariableNames: 'totalWithdrawLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!WithdrawLeg methodsFor: 'balance' stamp: 'CS 5/30/2021 10:54:00'!
affectBalance: aBalance

	^aBalance - value! !


!WithdrawLeg methodsFor: 'value' stamp: 'CS 6/2/2021 20:48:21'!
value

	^ value! !


!WithdrawLeg methodsFor: 'reports' stamp: 'CS 6/2/2021 23:06:38'!
contributesToTheReportOf: anAccountSummaryReporter

	^ anAccountSummaryReporter visitWithdrawLeg: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WithdrawLeg class' category: 'Portfolio2'!
WithdrawLeg class
	instanceVariableNames: ''!

!WithdrawLeg class methodsFor: 'initialization' stamp: 'CS 5/30/2021 13:06:46'!
for: aValue

	^ self new initializeFor: aValue! !


!classDefinition: #Withdraw category: 'Portfolio2'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value totalWithdraw'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!Withdraw methodsFor: 'initialization' stamp: 'CS 6/2/2021 22:44:35'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'reports' stamp: 'CS 6/2/2021 23:06:51'!
contributesToTheReportOf: anAccountSummaryReporter

	^ anAccountSummaryReporter visitWithdraw: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio2'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #ReportVisitor category: 'Portfolio2'!
Object subclass: #ReportVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!ReportVisitor methodsFor: 'visit Transactions' stamp: 'CS 6/2/2021 15:37:04'!
visitDeposit: aDeposit

	self subclassResponsibility! !

!ReportVisitor methodsFor: 'visit Transactions' stamp: 'CS 6/2/2021 15:37:38'!
visitDepositLeg: aDepositLeg

	self subclassResponsibility! !

!ReportVisitor methodsFor: 'visit Transactions' stamp: 'CS 6/2/2021 15:37:19'!
visitWithdraw: aWithdraw

	self subclassResponsibility! !

!ReportVisitor methodsFor: 'visit Transactions' stamp: 'CS 6/2/2021 15:37:58'!
visitWithdrawLeg: aWithdrawLeg

	self subclassResponsibility! !


!classDefinition: #AccountSummary category: 'Portfolio2'!
ReportVisitor subclass: #AccountSummary
	instanceVariableNames: 'summary account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!AccountSummary methodsFor: 'initialization' stamp: 'CS 6/2/2021 23:24:17'!
initializeWith: anAccount

	account := anAccount.! !


!AccountSummary methodsFor: 'accountSummary' stamp: 'CS 6/2/2021 23:21:05'!
accountSummary

	summary := OrderedCollection new.
	account doReportTo: self.
	summary add: ('Balance = ', (account balance) printString).
	
	^ summary.! !


!AccountSummary methodsFor: 'visit Transactions' stamp: 'CS 6/2/2021 21:58:27'!
visitDeposit: aDeposit

	summary add: 'Deposito por ', aDeposit value printString! !

!AccountSummary methodsFor: 'visit Transactions' stamp: 'CS 6/2/2021 22:02:07'!
visitDepositLeg: aDepositLeg

	summary add: 'Entrada por transferencia de ', aDepositLeg value printString.! !

!AccountSummary methodsFor: 'visit Transactions' stamp: 'CS 6/2/2021 22:02:26'!
visitWithdraw: aWithdraw

	summary add: 'Extraccion por ', aWithdraw value printString.! !

!AccountSummary methodsFor: 'visit Transactions' stamp: 'CS 6/2/2021 22:03:04'!
visitWithdrawLeg: aWithdrawLeg

	summary add: 'Salida por transferencia de ', aWithdrawLeg value printString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio2'!
AccountSummary class
	instanceVariableNames: 'receptiveAccount'!

!AccountSummary class methodsFor: 'initialization' stamp: 'CS 6/2/2021 23:19:43'!
for: anAccount

	^ self new initializeWith: anAccount.! !


!classDefinition: #TransferNet category: 'Portfolio2'!
ReportVisitor subclass: #TransferNet
	instanceVariableNames: 'neto account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!TransferNet methodsFor: 'initialization' stamp: 'CS 6/2/2021 23:21:38'!
initializeWith: anAccount

	account := anAccount! !


!TransferNet methodsFor: 'transferNet' stamp: 'CS 6/2/2021 23:21:26'!
transferNet

	neto := 0.
	account doReportTo: self.
		
	^ neto.! !


!TransferNet methodsFor: 'visit Transactions' stamp: 'CS 6/2/2021 22:27:26'!
visitDeposit: aDeposit! !

!TransferNet methodsFor: 'visit Transactions' stamp: 'CS 6/2/2021 22:27:57'!
visitDepositLeg: aDepositLeg

	neto := neto + aDepositLeg value! !

!TransferNet methodsFor: 'visit Transactions' stamp: 'CS 6/2/2021 22:28:12'!
visitWithdraw: aWithdraw! !

!TransferNet methodsFor: 'visit Transactions' stamp: 'CS 6/2/2021 22:36:33'!
visitWithdrawLeg: aWithdrawLeg

	neto := neto - aWithdrawLeg value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'Portfolio2'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'initialization' stamp: 'CS 6/2/2021 23:19:56'!
for: anAccount

	^ self new initializeWith: anAccount.! !


!classDefinition: #Transfer category: 'Portfolio2'!
Object subclass: #Transfer
	instanceVariableNames: 'value depositLeg withdrawLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!Transfer methodsFor: 'value' stamp: 'CS 6/1/2021 22:12:26'!
value

	^ value! !


!Transfer methodsFor: 'legs' stamp: 'CS 6/2/2021 23:34:15'!
depositLeg

	^ depositLeg! !

!Transfer methodsFor: 'legs' stamp: 'CS 6/2/2021 23:34:28'!
withdrawLeg

	^ withdrawLeg! !


!Transfer methodsFor: 'initialize transfer' stamp: 'CS 6/2/2021 23:46:14'!
transferFromTheAccount: accountTransfering toAccount: accountReceiving withAmount: anAmount.

	(anAmount <= 0) ifTrue: [^Error signal: (	accountTransfering class) describeErrorMessage ].
	value := anAmount.
	depositLeg := DepositLeg register: self on: accountReceiving.
	withdrawLeg := WithdrawLeg register: self on: accountTransfering.
	! !
