!classDefinition: #PortfolioTest category: 'Portfolio2'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

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

!PortfolioTest methodsFor: 'tests' stamp: 'CR 11/16/2020 02:46:47'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: account .
	composedPortfolio add: simplePortfolio.
	
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


!classDefinition: #ReportTest category: 'Portfolio2'!
TestCase subclass: #ReportTest
	instanceVariableNames: 'accountWithDepositOf100 accountWithDepositOf200 emptyAccount emptyAccountSummary accountSummaryWithOnlyDepositOf100 accountWithManyTransactions accountSummaryManyTransactions accountWithTwoTransfers emptyPortfolio simplePortfolio composedPortfolio accountSummaryOfComposedPortfolio accountWithOneTransferDeposit accountWithOneTransferWithdraw transferNetOfAccountWithOneTransferDeposit transferNetOfAccountWithOneTransferWithdraw simplePortfolioWithOneTransfer composedPortfolioWithManyTransfers accountSummaryOfSimplePortfolio fedesTreeRepresentation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!ReportTest methodsFor: 'setup' stamp: 'CR 11/16/2020 19:05:37'!
setUp
	emptyPortfolio := Portfolio new.
	emptyAccountSummary := OrderedCollection with: 'Balance = 0'.
	accountWithDepositOf100 := ReceptiveAccount new.
	accountWithDepositOf200 := ReceptiveAccount new.
	accountWithManyTransactions := ReceptiveAccount new.
	accountWithTwoTransfers := ReceptiveAccount new.
	accountWithOneTransferDeposit := ReceptiveAccount new.
	accountWithOneTransferWithdraw := ReceptiveAccount new.
	emptyAccount := ReceptiveAccount new.
	simplePortfolio := Portfolio with: accountWithDepositOf100.
	simplePortfolioWithOneTransfer := Portfolio with: accountWithOneTransferDeposit.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolioWithManyTransfers := Portfolio with: simplePortfolioWithOneTransfer.
	composedPortfolioWithManyTransfers add: accountWithManyTransactions.
	composedPortfolio add: accountWithDepositOf200.
	
	Deposit register: 100 on: accountWithDepositOf100.
	Deposit register: 200 on: accountWithDepositOf200.
	Deposit register: 300 on: accountWithManyTransactions.
	Withdraw register: 50 on: accountWithManyTransactions.
	Transfer register: 75 from: accountWithManyTransactions to: accountWithTwoTransfers.
	Transfer register: 40 from: accountWithTwoTransfers to: accountWithManyTransactions.
	Transfer register: 50 from: accountWithOneTransferWithdraw to: accountWithOneTransferDeposit.
	
	accountSummaryWithOnlyDepositOf100 := OrderedCollection with: 'Depósito por 100' with: 'Balance = 100'.
	accountSummaryOfSimplePortfolio := OrderedCollection with: 'Depósito por 100' with: 'Balance = 100' with: 'Balance = 100'.
	accountSummaryManyTransactions := OrderedCollection with: 'Depósito por 300' with: 'Extracción por 50' with: 'Salida por transferencia de 75' with: 'Entrada por transferencia de 40' with: ('Balance = ', accountWithManyTransactions balance asString).
	accountSummaryOfComposedPortfolio := OrderedCollection with: 'Depósito por 100' with: 'Depósito por 200' with: 'Balance = 300' with: 'Balance = 100' with: 'Balance = 200' with: 'Balance = 100'.
	
	transferNetOfAccountWithOneTransferDeposit := OrderedCollection with: 'Entrada por transferencia de 50'.
	transferNetOfAccountWithOneTransferWithdraw := OrderedCollection with: 'Entrada por transferencia de 50'.
	
	fedesTreeRepresentation := (OrderedCollection with: 'Portfolio de fede' with: 'Balance = 50' with: ' Cuenta de fede' with: '  Depósito por 100' with: ' Balance = 100' with: ' Portfolio de juan' ).
 	fedesTreeRepresentation add: '  Cuenta de juan'.
	fedesTreeRepresentation add: ' Balance = -50'.
	fedesTreeRepresentation add: '   Extracción por 50'.
	fedesTreeRepresentation add: '  Balance = -50'.
	! !


!ReportTest methodsFor: 'account summary tests' stamp: 'CR 11/16/2020 03:07:45'!
test01AccountSummaryOfAnEmptyReceptiveAccountIsEmpty
	| accountSummaryOfEmptyAccount |
	accountSummaryOfEmptyAccount := AccountSummary for: emptyAccount. 
	self assert: emptyAccountSummary = accountSummaryOfEmptyAccount summary.! !

!ReportTest methodsFor: 'account summary tests' stamp: 'CR 11/16/2020 02:30:53'!
test02AccountSummaryOfAReceptiveAccountWithOneTransactionWorksCorrectly
	| accountSummaryOfAnAccount |
	accountSummaryOfAnAccount := AccountSummary for: accountWithDepositOf100. 
	self assert:  accountSummaryWithOnlyDepositOf100 = accountSummaryOfAnAccount summary.! !

!ReportTest methodsFor: 'account summary tests' stamp: 'CR 11/16/2020 02:30:37'!
test03AccountSummaryOfAReceptiveAccountWithManyTransactionsWorksCorrectly
	| accountSummaryOfAnAccountWithManyTransactions |
	accountSummaryOfAnAccountWithManyTransactions := AccountSummary for: accountWithManyTransactions.
	self assertThat:  accountSummaryManyTransactions isEqualTo: accountSummaryOfAnAccountWithManyTransactions summary.! !

!ReportTest methodsFor: 'account summary tests' stamp: 'CR 11/16/2020 02:32:02'!
test04AccountSummaryOfAnEmptyPortfolioIsEmpty
	| accountSummaryOfEmptyPorfolio |
	accountSummaryOfEmptyPorfolio := AccountSummary for: emptyPortfolio. 
	self assert: emptyAccountSummary = accountSummaryOfEmptyPorfolio summary.! !

!ReportTest methodsFor: 'account summary tests' stamp: 'CR 11/16/2020 16:44:47'!
test05AccountSummaryOfAPortfolioWithOneAccountWorksCorrectly
	| accountSummaryOfASimplePortfolio |
	accountSummaryOfASimplePortfolio := AccountSummary for: simplePortfolio. 
	self assert:  accountSummaryOfSimplePortfolio = accountSummaryOfASimplePortfolio summary.! !

!ReportTest methodsFor: 'account summary tests' stamp: 'CR 11/16/2020 16:50:15'!
test06AccountSummaryOfAPortfolioWithManyAccountsWorksCorrectly
	| accountSummaryOfAComposedPortfolio |
	accountSummaryOfAComposedPortfolio := AccountSummary for: composedPortfolio. 
	self assertThat:  accountSummaryOfComposedPortfolio isEqualTo:  accountSummaryOfAComposedPortfolio summary.! !


!ReportTest methodsFor: 'assertions' stamp: 'CR 11/16/2020 02:18:13'!
assertThat:  aCollection isEqualTo: aCollectionToBeComparedTo

	self assert: (aCollection size = aCollectionToBeComparedTo size).
	self assert: (aCollection allSatisfy: [:anElement | aCollectionToBeComparedTo includes: anElement ]).
	self assert: (aCollectionToBeComparedTo allSatisfy: [:anElement | aCollection includes: anElement ]).! !


!ReportTest methodsFor: 'tree representation tests' stamp: 'CR 11/16/2020 17:57:09'!
test13TreeRepresentationAccountOfAnEmptyReceptiveAccountIsItsName
	| treeRepresentationOfEmptyAccount fedesEmptyAccount |
	fedesEmptyAccount := ReceptiveAccount named: 'Cuenta vacia de Fede'.
	treeRepresentationOfEmptyAccount := TreeRepresentationAccounts for: fedesEmptyAccount. 
	self assertThat: (OrderedCollection with: 'Cuenta vacia de Fede' ) isEqualTo: treeRepresentationOfEmptyAccount tree.! !

!ReportTest methodsFor: 'tree representation tests' stamp: 'CR 11/16/2020 17:57:21'!
test14TreeRepresentationAccountOfAnEmptyPortfolioIsItsName
	| treeRepresentationOfEmptyPortfolio fedesEmptyPortfolio |
	fedesEmptyPortfolio := Portfolio named: 'Portfolio vacio de Fede'.
	treeRepresentationOfEmptyPortfolio := TreeRepresentationAccounts for: fedesEmptyPortfolio. 
	self assertThat: (OrderedCollection with: 'Portfolio vacio de Fede' ) isEqualTo: treeRepresentationOfEmptyPortfolio tree.! !

!ReportTest methodsFor: 'tree representation tests' stamp: 'CR 11/16/2020 17:57:29'!
test15TreeRepresentationAccountOfPortfolioWithOneAccountWorksCorrectly
	| treeRepresentationOfPortfolioWithOneAccount fedesPortfolio |
	fedesPortfolio := Portfolio named: 'Portfolio de Fede'.
	fedesPortfolio add: (ReceptiveAccount named: 'Cuenta de Juan'). 
	treeRepresentationOfPortfolioWithOneAccount := TreeRepresentationAccounts for: fedesPortfolio. 
	self assertThat: (OrderedCollection with: 'Portfolio de Fede' with: ' Cuenta de Juan') isEqualTo: treeRepresentationOfPortfolioWithOneAccount tree.! !

!ReportTest methodsFor: 'tree representation tests' stamp: 'CR 11/16/2020 17:57:37'!
test16TreeRepresentationAccountOfPortfolioWithManyAccountsWorksCorrectly
	| treeRepresentationOfPortfolioWithOneAccount fedesPortfolio juansPortfolio |
	fedesPortfolio := Portfolio named: 'Portfolio de Fede'.
	juansPortfolio := Portfolio named: 'Portfolio de Juan'.
	fedesPortfolio add: (ReceptiveAccount named: 'Cuenta de Fede').
	fedesPortfolio add: juansPortfolio.
	juansPortfolio add: (ReceptiveAccount named: 'Cuenta de Juan').	  
	treeRepresentationOfPortfolioWithOneAccount := TreeRepresentationAccounts for: fedesPortfolio. 
	self assertThat: (OrderedCollection with: 'Portfolio de Fede' with: ' Cuenta de Fede' with: ' Portfolio de Juan' with: '  Cuenta de Juan') isEqualTo: treeRepresentationOfPortfolioWithOneAccount tree.! !

!ReportTest methodsFor: 'tree representation tests' stamp: 'CR 11/16/2020 18:14:36'!
test17TreeRepresentationWithTransactionsOfAnEmptyReceptiveAccountIsItsName
	| treeRepresentationOfEmptyAccount fedesEmptyAccount |
	fedesEmptyAccount := ReceptiveAccount named: 'Cuenta vacia de Fede'.
	treeRepresentationOfEmptyAccount := TreeRepresentationWithTransactions for: fedesEmptyAccount. 
	self assertThat: (OrderedCollection with: 'Cuenta vacia de Fede' with: 'Balance = 0') isEqualTo: treeRepresentationOfEmptyAccount tree.! !

!ReportTest methodsFor: 'tree representation tests' stamp: 'CR 11/16/2020 18:37:01'!
test18TreeRepresentationWithTransactionsOfAnEmptyPortfolioIsItsName
	| treeRepresentationOfEmptyPortfolio fedesEmptyPortfolio |
	fedesEmptyPortfolio := Portfolio named: 'Portfolio vacio de Fede'.
	treeRepresentationOfEmptyPortfolio := TreeRepresentationWithTransactions for: fedesEmptyPortfolio. 
	self assertThat: (OrderedCollection with: 'Portfolio vacio de Fede' with: 'Balance = 0') isEqualTo: treeRepresentationOfEmptyPortfolio tree.! !

!ReportTest methodsFor: 'tree representation tests' stamp: 'CR 11/16/2020 18:54:42'!
test19TreeRepresentationWithTransactionsOfPortfolioWithOneTransactionWorksCorrectly
	| treeRepresentationOfPortfolio fedesPortfolio fedesAccount |
	fedesPortfolio := Portfolio named: 'Portfolio de fede'.
	fedesAccount := ReceptiveAccount named: 'Cuenta de fede'.
	Deposit register: 100 on: fedesAccount.
	fedesPortfolio add: fedesAccount.
	treeRepresentationOfPortfolio := TreeRepresentationWithTransactions for: fedesPortfolio. 
	self assertThat: (OrderedCollection with: 'Portfolio de fede' with: 'Balance = 100' with: ' Cuenta de fede' with: 
	'  Depósito por 100' with: ' Balance = 100') isEqualTo: treeRepresentationOfPortfolio tree.! !

!ReportTest methodsFor: 'tree representation tests' stamp: 'CR 11/16/2020 19:01:33'!
test20TreeRepresentationWithTransactionsOfPortfolioWithManyTransactionsWorksCorrectly
	| treeRepresentationOfPortfolioWithManyTransactions fedesPortfolio fedesAccount juansAccount juansPortfolio treeRepresentationOfPortfolio |
	fedesPortfolio := Portfolio named: 'Portfolio de fede'.
	juansPortfolio := Portfolio named: 'Portfolio de juan'.
	fedesAccount := ReceptiveAccount named: 'Cuenta de fede'.
	juansAccount := ReceptiveAccount named: 'Cuenta de juan'.
	Deposit register: 100 on: fedesAccount.
	Withdraw register: 50 on: juansAccount.
	fedesPortfolio add: fedesAccount.
	juansPortfolio add: juansAccount.
	fedesPortfolio add: juansPortfolio. 
	treeRepresentationOfPortfolioWithManyTransactions := TreeRepresentationWithTransactions for: fedesPortfolio. 
	self assertThat: fedesTreeRepresentation isEqualTo: treeRepresentationOfPortfolioWithManyTransactions tree.! !


!ReportTest methodsFor: 'transfer net tests' stamp: 'CR 11/16/2020 03:08:57'!
test07TransferNetOfAnEmptyReceptiveAccountIsEmpty
	| transferNetOfEmptyAccount |
	transferNetOfEmptyAccount := TransferNet for: emptyAccount. 
	self assert: 0 = transferNetOfEmptyAccount net.! !

!ReportTest methodsFor: 'transfer net tests' stamp: 'CR 11/16/2020 03:22:49'!
test08TransferNetBetweenReceptiveAccountsWithOneTransferWorksCorrectly
	| transferNetOfDestinationAccount transferNetOfSourceAccount |
	transferNetOfDestinationAccount := (TransferNet for: accountWithOneTransferDeposit) net.
	transferNetOfSourceAccount := (TransferNet for: accountWithOneTransferWithdraw) net.
	self assert:  transferNetOfDestinationAccount = 50.
	self assert:  transferNetOfSourceAccount = -50.
	! !

!ReportTest methodsFor: 'transfer net tests' stamp: 'CR 11/16/2020 03:27:36'!
test09TransferNetBetweenReceptiveAccountsWithManyTransfersWorksCorrectly
	| transferNetOfManyAccounts |
	transferNetOfManyAccounts := (TransferNet for: accountWithManyTransactions ) net.
	self assert:  transferNetOfManyAccounts = (40 - 75).
	! !

!ReportTest methodsFor: 'transfer net tests' stamp: 'CR 11/16/2020 03:28:52'!
test10TransferNetOfAnEmptyPortfolioIsZero
	| transferNetOfEmptyPorfolio |
	transferNetOfEmptyPorfolio := TransferNet for: emptyPortfolio. 
	self assert: 0 = transferNetOfEmptyPorfolio net.! !

!ReportTest methodsFor: 'transfer net tests' stamp: 'CR 11/16/2020 03:31:52'!
test11TransferNetOfAPortfolioWithOneTransferWorksCorrectly
	| transferNetOfASimplePortfolio |
	transferNetOfASimplePortfolio := TransferNet for: simplePortfolioWithOneTransfer. 
	self assert:  50 = transferNetOfASimplePortfolio net.! !

!ReportTest methodsFor: 'transfer net tests' stamp: 'CR 11/16/2020 03:35:59'!
test12TransferNetOfAPortfolioWithManyTransfersWorksCorrectly
	| transferNetOfAComposedPortfolioWithManyTransfers |
	transferNetOfAComposedPortfolioWithManyTransfers := TransferNet for: composedPortfolioWithManyTransfers. 
	self assert:  (50 + 40 - 75) = transferNetOfAComposedPortfolioWithManyTransfers net.! !


!classDefinition: #TransferTest category: 'Portfolio2'!
TestCase subclass: #TransferTest
	instanceVariableNames: 'accountWithDepositOf100 accountWithDepositOf200 emptyAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!TransferTest methodsFor: 'setup' stamp: 'CR 11/15/2020 21:20:29'!
setUp
	accountWithDepositOf100 := ReceptiveAccount new.
	accountWithDepositOf200 := ReceptiveAccount new.
	emptyAccount := ReceptiveAccount new.
	Deposit register: 100 on: accountWithDepositOf100.
	Deposit register: 200 on: accountWithDepositOf200.
	
	! !


!TransferTest methodsFor: 'tests' stamp: 'CR 11/15/2020 21:22:04'!
test01TransferZeroDoesNotChangeAccountsBalance
	| aTransferOfZero |
	aTransferOfZero := Transfer register: 0 from: accountWithDepositOf100 to: emptyAccount.
	self assert: (accountWithDepositOf100 balance = 100).
	self assert: (emptyAccount balance = 0).! !

!TransferTest methodsFor: 'tests' stamp: 'CR 11/15/2020 21:27:13'!
test02TransferUpdatesAccountsBalanceCorrectly
	| aTransferOf75 |
	aTransferOf75 := Transfer register: 75 from: accountWithDepositOf100 to: emptyAccount.
	self assert: (accountWithDepositOf100 balance = 25).
	self assert: (emptyAccount balance = 75).! !

!TransferTest methodsFor: 'tests' stamp: 'CR 11/16/2020 03:04:15'!
test03TransferIsRegisteredCorrectlyOnBothAccounts
	| aTransferOf75 |
	aTransferOf75 := Transfer register: 75 from: accountWithDepositOf100 to: emptyAccount.
	self assert: (accountWithDepositOf100 hasRegistered: aTransferOf75 withdrawTransfer).
	self assert: (emptyAccount hasRegistered: aTransferOf75 depositTransfer).! !

!TransferTest methodsFor: 'tests' stamp: 'CR 11/16/2020 03:04:15'!
test04TransferIsOnBothAccountsTransactions
	| aTransferOf75 |
	aTransferOf75 := Transfer register: 75 from: accountWithDepositOf100 to: emptyAccount.
	self assert: (accountWithDepositOf100 transactions includes: aTransferOf75 withdrawTransfer).
	self assert: (emptyAccount transactions includes: aTransferOf75 depositTransfer).! !

!TransferTest methodsFor: 'tests' stamp: 'CR 11/15/2020 21:47:45'!
test05TransferFromAndToSameAccountRaisesError
	| aTransferOf75 |
	self should: [aTransferOf75 := Transfer register: 75 from: emptyAccount to: emptyAccount.] 
	raise:  Error withMessageText: [Transfer cantTransferToSameAccountAsSource].! !

!TransferTest methodsFor: 'tests' stamp: 'CR 11/15/2020 21:55:48'!
test06TransferOfNegativeAmountRaisesError
	| aTransferOfNegativeAmount |
	self should: [aTransferOfNegativeAmount := Transfer register: -30 from: emptyAccount to: accountWithDepositOf100.] 
	raise:  Error withMessageText: [Transfer cantTransferNegativeAmount].! !

!TransferTest methodsFor: 'tests' stamp: 'CR 11/16/2020 03:07:07'!
test07CanNavigateFromTransferDepositToWithdrawAndViceversa
	"Consideramos que la navegación es parte de la funcionalidad deseada"
	| aTransferOf50 depositTransfer withdrawTransfer |
	aTransferOf50 := Transfer register: 50 from: accountWithDepositOf100 to: emptyAccount.
	depositTransfer := aTransferOf50 depositTransfer.
	withdrawTransfer := aTransferOf50 withdrawTransfer.
	self assert: (depositTransfer transfer = aTransferOf50).
	self assert: (withdrawTransfer transfer = aTransferOf50).
	
	
		! !


!classDefinition: #Account category: 'Portfolio2'!
Object subclass: #Account
	instanceVariableNames: 'name'
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


!Account methodsFor: 'report collaboration' stamp: 'CR 11/16/2020 16:09:36'!
collaborateWith: aReportToCollaborateWith onLevel: aTreeLevel
	| resultOfCollaboration | 
	resultOfCollaboration := self executeCollaboration: (aReportToCollaborateWith collaboration) onLevel: aTreeLevel. 
	aReportToCollaborateWith collaborationWithAccountResult: resultOfCollaboration.! !

!Account methodsFor: 'report collaboration' stamp: 'CR 11/16/2020 18:24:24'!
collaborateWithBalance: aReportToCollaborateWith onLevel: aTreeLevel
	aReportToCollaborateWith addBalance: self balance onLevel: aTreeLevel.! !


!Account methodsFor: 'accessing' stamp: 'CR 11/16/2020 16:23:03'!
name
	^name ! !


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

!Portfolio methodsFor: 'initialization' stamp: 'CR 11/16/2020 15:24:42'!
initializeWithName:  portfolioNameToBeInitializedWith

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := portfolioNameToBeInitializedWith. ! !


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


!Portfolio methodsFor: 'report collaboration' stamp: 'CR 11/16/2020 16:53:33'!
collaborateWith: aReportToCollaborateWith

	accounts do: [:anAccount | anAccount collaborateWith: aReportToCollaborateWith].
	aReportToCollaborateWith collaboratingAccount: self.! !

!Portfolio methodsFor: 'report collaboration' stamp: 'CR 11/16/2020 18:22:58'!
collaborateWithTreeLevel: aReportToCollaborateWith of: aTreeLevel
	
	self collaborateWith: aReportToCollaborateWith onLevel: aTreeLevel.
	accounts do: [:anAccount | anAccount collaborateWithTreeLevel: aReportToCollaborateWith  of: aTreeLevel + 1].
	self collaborateWithBalance: aReportToCollaborateWith onLevel: aTreeLevel.
	! !

!Portfolio methodsFor: 'report collaboration' stamp: 'CR 11/16/2020 15:57:45'!
executeCollaboration: aCollaborationToExecute onLevel: aTreeLevel
	^ aCollaborationToExecute collaboratingPortfolio: self onLevel: aTreeLevel.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio2'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'CR 11/16/2020 16:25:15'!
named: portfolioName
	^(self new initializeWithName:  portfolioName)
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'CR 11/16/2020 15:20:54'!
named: portfolioName with: anAccount

	^(self new initializeWithName:  portfolioName)
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'CR 11/16/2020 15:22:05'!
named: portfolioName with: anAccount with: anotherAccount

	^(self new initializeWithName: portfolioName) 
		add: anAccount;
		add: anotherAccount;
		yourself! !

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


!Portfolio class methodsFor: 'error messages' stamp: 'NR 11/9/2020 06:01:26'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio!!'! !


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

!ReceptiveAccount methodsFor: 'initialization' stamp: 'CR 11/16/2020 15:24:30'!
initializeWithName: receptiveAccountNameToBeInitializedWith

	super initialize.
	transactions := OrderedCollection new.
	name := receptiveAccountNameToBeInitializedWith.! !


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


!ReceptiveAccount methodsFor: 'report collaboration' stamp: 'CR 11/16/2020 16:54:54'!
collaborateWith: aReportToCollaborateWith
	transactions do: [:aTransaction | aTransaction collaborateWith: aReportToCollaborateWith].
	aReportToCollaborateWith collaboratingAccount: self.! !

!ReceptiveAccount methodsFor: 'report collaboration' stamp: 'CR 11/16/2020 18:23:16'!
collaborateWithTreeLevel: aReportToCollaborateWith of: aTreeLevel
	self collaborateWith: aReportToCollaborateWith onLevel: aTreeLevel.
	aReportToCollaborateWith transactionCollaboration: self onLevel: aTreeLevel.
	self collaborateWithBalance: aReportToCollaborateWith onLevel: aTreeLevel.! !

!ReceptiveAccount methodsFor: 'report collaboration' stamp: 'CR 11/16/2020 15:58:00'!
executeCollaboration: aCollaborationToExecute onLevel: aTreeLevel
	^ aCollaborationToExecute collaboratingReceptiveAccount: self onLevel: aTreeLevel.! !

!ReceptiveAccount methodsFor: 'report collaboration' stamp: 'CR 11/16/2020 17:23:42'!
transactionCollaborationWith:  aReportToCollaborateWith onLevel: aTreeLevel
	transactions do: [:aTransaction | aTransaction collaborateWith: aReportToCollaborateWith onLevel: aTreeLevel + 1].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio2'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'CR 11/16/2020 15:23:42'!
named: receptiveAccountName
	^self new initializeWithName: receptiveAccountName. ! !


!classDefinition: #AccountReport category: 'Portfolio2'!
Object subclass: #AccountReport
	instanceVariableNames: 'accountToMakeReportFor collaborationAction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!AccountReport methodsFor: 'collaboration' stamp: 'CR 11/16/2020 01:51:05'!
collaboration
	^ collaborationAction.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReport class' category: 'Portfolio2'!
AccountReport class
	instanceVariableNames: ''!

!AccountReport class methodsFor: 'instance creation' stamp: 'CR 11/16/2020 15:36:08'!
for: anAccount
	^self new initializeFor: anAccount.! !


!classDefinition: #AccountSummary category: 'Portfolio2'!
AccountReport subclass: #AccountSummary
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!AccountSummary methodsFor: 'initialization' stamp: 'CR 11/16/2020 01:49:08'!
initializeFor: anAccount 
	accountToMakeReportFor := anAccount.
	summary := OrderedCollection new.
	collaborationAction := SummaryString new.
	! !


!AccountSummary methodsFor: 'collaboration' stamp: 'CR 11/16/2020 16:37:56'!
addBalanceToReport: accountBalance
	summary add: ('Balance = ', accountBalance asString).! !

!AccountSummary methodsFor: 'collaboration' stamp: 'CR 11/16/2020 16:54:17'!
collaboratingAccount: anAccountThatColaborates
	summary add: ('Balance = ', anAccountThatColaborates balance asString).! !

!AccountSummary methodsFor: 'collaboration' stamp: 'CR 11/16/2020 01:40:52'!
collaborationWithTransactionResult: resultOfCollaboration
	summary add: resultOfCollaboration.! !

!AccountSummary methodsFor: 'collaboration' stamp: 'CR 11/16/2020 01:49:41'!
summary
	accountToMakeReportFor collaborateWith: self.  
	^summary.! !


!classDefinition: #TransferNet category: 'Portfolio2'!
AccountReport subclass: #TransferNet
	instanceVariableNames: 'transferNetAmount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!TransferNet methodsFor: 'initialization' stamp: 'CR 11/16/2020 01:50:00'!
initializeFor: anAccount
	accountToMakeReportFor := anAccount.
	transferNetAmount := 0.
	collaborationAction := CalculateNet new.
	! !


!TransferNet methodsFor: 'collaboration' stamp: 'CR 11/16/2020 16:54:28'!
collaboratingAccount: anAccountThatColaborates
! !

!TransferNet methodsFor: 'collaboration' stamp: 'CR 11/16/2020 01:41:36'!
collaborationWithTransactionResult: resultOfCollaboration
	transferNetAmount := transferNetAmount + resultOfCollaboration.! !

!TransferNet methodsFor: 'collaboration' stamp: 'CR 11/16/2020 01:49:49'!
net
	accountToMakeReportFor collaborateWith: self.  
	^transferNetAmount.! !


!classDefinition: #TreeRepresentation category: 'Portfolio2'!
AccountReport subclass: #TreeRepresentation
	instanceVariableNames: 'stringTree'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!TreeRepresentation methodsFor: 'collaboration' stamp: 'CR 11/16/2020 17:35:46'!
collaborationWithAccountResult: anAccountStringRepresentation
	stringTree add: anAccountStringRepresentation.! !

!TreeRepresentation methodsFor: 'collaboration' stamp: 'CR 11/16/2020 17:26:23'!
tree
	accountToMakeReportFor collaborateWithTreeLevel: self of: 0.
	^stringTree  ! !


!classDefinition: #TreeRepresentationAccounts category: 'Portfolio2'!
TreeRepresentation subclass: #TreeRepresentationAccounts
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!TreeRepresentationAccounts methodsFor: 'collaboration' stamp: 'CR 11/16/2020 18:32:36'!
addBalance: aBalanceToReport onLevel: aTreeLevel! !

!TreeRepresentationAccounts methodsFor: 'collaboration' stamp: 'CR 11/16/2020 17:15:53'!
transactionCollaboration: anAccount onLevel: aTreeLevel! !


!TreeRepresentationAccounts methodsFor: 'initialization' stamp: 'CR 11/16/2020 15:34:14'!
initializeFor: anAccount 
	accountToMakeReportFor := anAccount.
	stringTree := OrderedCollection new.
	collaborationAction := IndentedTreeString new.
	! !


!classDefinition: #TreeRepresentationWithTransactions category: 'Portfolio2'!
TreeRepresentation subclass: #TreeRepresentationWithTransactions
	instanceVariableNames: 'transactionCollaborationAction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!TreeRepresentationWithTransactions methodsFor: 'initialization' stamp: 'CR 11/16/2020 18:05:42'!
initializeFor: anAccount 
	accountToMakeReportFor := anAccount.
	stringTree := OrderedCollection new.
	collaborationAction := IndentedTreeString new.
	transactionCollaborationAction := SummaryString new.
	! !


!TreeRepresentationWithTransactions methodsFor: 'collaboration' stamp: 'CR 11/16/2020 18:35:02'!
addBalance: aBalanceToReport onLevel: anIdentationLevel
	| balanceReport |
	balanceReport := collaborationAction indentWithSpaces: anIdentationLevel andConcatenateName: 'Balance = ', aBalanceToReport asString.
	stringTree add: balanceReport.! !

!TreeRepresentationWithTransactions methodsFor: 'collaboration' stamp: 'CR 11/16/2020 18:05:55'!
transactionCollaboration
	^transactionCollaborationAction ! !

!TreeRepresentationWithTransactions methodsFor: 'collaboration' stamp: 'CR 11/16/2020 18:17:10'!
transactionCollaboration: aReceptiveAccount onLevel: aTreeLevel
	aReceptiveAccount transactionCollaborationWith:  self onLevel: aTreeLevel.! !


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


!AccountTransaction methodsFor: 'report collaboration' stamp: 'CR 11/16/2020 01:51:31'!
collaborateWith: aReportToCollaborateWith
	| resultOfCollaboration | 
	resultOfCollaboration := self executeCollaboration: (aReportToCollaborateWith collaboration). 
	aReportToCollaborateWith collaborationWithTransactionResult: resultOfCollaboration.! !

!AccountTransaction methodsFor: 'report collaboration' stamp: 'CR 11/16/2020 18:06:26'!
collaborateWith: aReportToCollaborateWith onLevel: aTreeLevel
	| resultOfCollaboration | 
	resultOfCollaboration := self executeCollaboration: (aReportToCollaborateWith transactionCollaboration) onLevel: aTreeLevel. 
	aReportToCollaborateWith collaborationWithAccountResult: resultOfCollaboration.! !

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
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'report collaboration' stamp: 'CR 11/16/2020 01:34:25'!
executeCollaboration: collaborationToPerform
	^ collaborationToPerform collaboratingDeposit: self.
	 ! !

!Deposit methodsFor: 'report collaboration' stamp: 'CR 11/16/2020 17:39:26'!
executeCollaboration: collaborationToPerform onLevel: aTreeLevel
	^ collaborationToPerform collaboratingDeposit: self onLevel: aTreeLevel.
	 ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio2'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferTransactions category: 'Portfolio2'!
AccountTransaction subclass: #TransferTransactions
	instanceVariableNames: 'value transferAttachedTo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!TransferTransactions methodsFor: 'value' stamp: 'CR 11/15/2020 21:13:28'!
value

	^ value! !


!TransferTransactions methodsFor: 'initialization' stamp: 'CR 11/15/2020 21:43:13'!
initializeFor: aValue by: aTransfer

	value := aValue.
	transferAttachedTo := aTransfer.! !


!TransferTransactions methodsFor: 'accessing' stamp: 'CR 11/16/2020 02:56:39'!
transfer
	^ transferAttachedTo.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTransactions class' category: 'Portfolio2'!
TransferTransactions class
	instanceVariableNames: ''!

!TransferTransactions class methodsFor: 'instance creation' stamp: 'CR 11/16/2020 03:45:17'!
register: aValue on: anAccount by: aTransfer 

	| transferTransaction |
	
	transferTransaction := self new initializeFor: aValue by: aTransfer.
	anAccount register: transferTransaction.
	
	^ transferTransaction.! !


!classDefinition: #TransferDeposit category: 'Portfolio2'!
TransferTransactions subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!TransferDeposit methodsFor: 'balance' stamp: 'CR 11/15/2020 21:13:13'!
affectBalance: aBalance

	^aBalance + value ! !


!TransferDeposit methodsFor: 'report collaboration' stamp: 'CR 11/16/2020 01:34:35'!
executeCollaboration: collaborationToPerform
	^ collaborationToPerform collaboratingTransferDeposit: self.
	 ! !

!TransferDeposit methodsFor: 'report collaboration' stamp: 'CR 11/16/2020 17:39:43'!
executeCollaboration: collaborationToPerform onLevel: aTreeLevel
	^ collaborationToPerform collaboratingTransferDeposit: self onLevel: aTreeLevel.
	 ! !


!classDefinition: #TransferWithdraw category: 'Portfolio2'!
TransferTransactions subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!TransferWithdraw methodsFor: 'balance' stamp: 'CR 11/15/2020 21:14:33'!
affectBalance: aBalance

	^aBalance - value ! !


!TransferWithdraw methodsFor: 'report collaboration' stamp: 'CR 11/16/2020 01:34:41'!
executeCollaboration: collaborationToPerform
	^ collaborationToPerform collaboratingTransferWithdraw: self.
	 ! !

!TransferWithdraw methodsFor: 'report collaboration' stamp: 'CR 11/16/2020 17:40:00'!
executeCollaboration: collaborationToPerform onLevel: aTreeLevel
	^ collaborationToPerform collaboratingTransferWithdraw: self onLevel: aTreeLevel.
	 ! !


!classDefinition: #Withdraw category: 'Portfolio2'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'report collaboration' stamp: 'CR 11/16/2020 01:34:54'!
executeCollaboration: collaborationToPerform
	^ collaborationToPerform collaboratingWithdraw: self.
	 ! !

!Withdraw methodsFor: 'report collaboration' stamp: 'CR 11/16/2020 17:40:20'!
executeCollaboration: collaborationToPerform onLevel: aTreeLevel
	^ collaborationToPerform collaboratingWithdraw: self onLevel: aTreeLevel.
	 ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio2'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #ReportAction category: 'Portfolio2'!
Object subclass: #ReportAction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!


!classDefinition: #CalculateNet category: 'Portfolio2'!
ReportAction subclass: #CalculateNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!CalculateNet methodsFor: 'transaction collaboration' stamp: 'CR 11/16/2020 01:35:53'!
collaboratingDeposit: aDeposit
	^  0.! !

!CalculateNet methodsFor: 'transaction collaboration' stamp: 'CR 11/16/2020 01:30:04'!
collaboratingTransferDeposit: aTransferDeposit
	^  aTransferDeposit value.! !

!CalculateNet methodsFor: 'transaction collaboration' stamp: 'CR 11/16/2020 03:24:33'!
collaboratingTransferWithdraw: aTransferWithdraw
	^  0 - aTransferWithdraw value.! !

!CalculateNet methodsFor: 'transaction collaboration' stamp: 'CR 11/16/2020 01:36:00'!
collaboratingWithdraw: aWithdraw
	^  0.! !


!classDefinition: #IndentedTreeString category: 'Portfolio2'!
ReportAction subclass: #IndentedTreeString
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!IndentedTreeString methodsFor: 'transaction collaboration' stamp: 'CR 11/16/2020 16:06:32'!
calculateIndentation: anIndentationLevel
	^ String new: anIndentationLevel withAll: $ . ! !

!IndentedTreeString methodsFor: 'transaction collaboration' stamp: 'CR 11/16/2020 18:20:19'!
collaboratingPortfolio: aPortfolio onLevel: anIndentationLevel
	^ self indentWithSpaces: anIndentationLevel andConcatenateName: aPortfolio name.! !

!IndentedTreeString methodsFor: 'transaction collaboration' stamp: 'CR 11/16/2020 16:08:30'!
collaboratingReceptiveAccount: aReceptiveAccount onLevel: anIndentationLevel
	^ self indentWithSpaces: anIndentationLevel andConcatenateName: aReceptiveAccount name.! !

!IndentedTreeString methodsFor: 'transaction collaboration' stamp: 'CR 11/16/2020 16:08:54'!
indentWithSpaces: anIndentationLevel andConcatenateName: aNameToConcatenateWith
	^ (self calculateIndentation: anIndentationLevel) , aNameToConcatenateWith.! !


!classDefinition: #SummaryString category: 'Portfolio2'!
ReportAction subclass: #SummaryString
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!SummaryString methodsFor: 'transaction collaboration' stamp: 'CR 11/16/2020 01:38:41'!
collaboratingDeposit: aDeposit
	^  'Depósito por ' , (aDeposit value) asString. ! !

!SummaryString methodsFor: 'transaction collaboration' stamp: 'CR 11/16/2020 17:46:32'!
collaboratingDeposit: aDeposit onLevel: anIndentationLevel
	^ self useIndentOn: (self collaboratingDeposit: aDeposit) onLevel: anIndentationLevel.! !

!SummaryString methodsFor: 'transaction collaboration' stamp: 'CR 11/16/2020 01:37:51'!
collaboratingTransferDeposit: aTransferDeposit
	^  'Entrada por transferencia de ' , (aTransferDeposit value) asString. ! !

!SummaryString methodsFor: 'transaction collaboration' stamp: 'CR 11/16/2020 17:48:22'!
collaboratingTransferDeposit: aTransferDeposit onLevel: anIndentationLevel
	^ self useIndentOn: (self collaboratingTransferDeposit: aTransferDeposit) onLevel: anIndentationLevel.! !

!SummaryString methodsFor: 'transaction collaboration' stamp: 'CR 11/16/2020 01:37:14'!
collaboratingTransferWithdraw: aTransferWithdraw
	^  'Salida por transferencia de ' , (aTransferWithdraw value) asString. ! !

!SummaryString methodsFor: 'transaction collaboration' stamp: 'CR 11/16/2020 17:47:46'!
collaboratingTransferWithdraw: aTransferWithdraw onLevel: anIndentationLevel
	^ self useIndentOn:  (self collaboratingTransferWithdraw: aTransferWithdraw) onLevel: anIndentationLevel.! !

!SummaryString methodsFor: 'transaction collaboration' stamp: 'CR 11/16/2020 01:38:58'!
collaboratingWithdraw: aWithdraw
	^  'Extracción por ' , (aWithdraw value) asString. ! !

!SummaryString methodsFor: 'transaction collaboration' stamp: 'CR 11/16/2020 17:47:20'!
collaboratingWithdraw: aWithdraw onLevel: anIndentationLevel
	^ self useIndentOn:  (self collaboratingWithdraw: aWithdraw) onLevel: anIndentationLevel.
	
	
	! !

!SummaryString methodsFor: 'transaction collaboration' stamp: 'CR 11/16/2020 18:47:35'!
useIndentOn: aName onLevel: anIndentationLevel
	| indentCollaborator |
	indentCollaborator := IndentedTreeString new.
	^ indentCollaborator indentWithSpaces: anIndentationLevel  andConcatenateName: aName.
	
	
	! !


!classDefinition: #Transfer category: 'Portfolio2'!
Object subclass: #Transfer
	instanceVariableNames: 'transferValue withdrawTransaction depositTransaction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!Transfer methodsFor: 'verifications' stamp: 'CR 11/15/2020 21:54:21'!
verify: destinationAccount isNotTheSameAs: sourceAccount

	(sourceAccount = destinationAccount) ifTrue: [self error: self class cantTransferToSameAccountAsSource ]! !

!Transfer methodsFor: 'verifications' stamp: 'CR 11/15/2020 21:54:34'!
verifyThatTransferAmountIsValid: aTransferValue.

	(aTransferValue < 0) ifTrue: [self error: self class cantTransferNegativeAmount ]! !


!Transfer methodsFor: 'initialization' stamp: 'CR 11/15/2020 21:53:43'!
initializeWith: aTransferValue from: sourceAccount to: destinationAccount

	self verify: destinationAccount isNotTheSameAs: sourceAccount.
	self verifyThatTransferAmountIsValid: aTransferValue.
	transferValue := aTransferValue.
	withdrawTransaction := TransferWithdraw register: aTransferValue on: sourceAccount by: self.
	depositTransaction := TransferDeposit register: aTransferValue on: destinationAccount by: self.! !


!Transfer methodsFor: 'value' stamp: 'CR 11/15/2020 21:34:42'!
value
	^transferValue.! !


!Transfer methodsFor: 'transactions' stamp: 'CR 11/16/2020 03:03:54'!
depositTransfer
	^depositTransaction! !

!Transfer methodsFor: 'transactions' stamp: 'CR 11/16/2020 03:04:15'!
withdrawTransfer
	^withdrawTransaction! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio2'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'CR 11/15/2020 21:06:20'!
register: aTransactionValue from: sourceAccount to: destinationAccount
	^ self new initializeWith: aTransactionValue from: sourceAccount to: destinationAccount.! !


!Transfer class methodsFor: 'error messages' stamp: 'CR 11/15/2020 21:53:02'!
cantTransferNegativeAmount
	^ 'A negative amount is invalid'! !

!Transfer class methodsFor: 'error messages' stamp: 'CR 11/15/2020 21:48:28'!
cantTransferToSameAccountAsSource
	^ 'Source account cant be the same as destination account'! !
