!classDefinition: #TestPortfolio category: 'Portfolio-2'!
TestCase subclass: #TestPortfolio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!TestPortfolio methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!TestPortfolio methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!TestPortfolio methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!TestPortfolio methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!TestPortfolio methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!TestPortfolio methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
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

!TestPortfolio methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!TestPortfolio methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
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

!TestPortfolio methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
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

!TestPortfolio methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
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

!TestPortfolio methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
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

!TestPortfolio methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
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

!TestPortfolio methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
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

!TestPortfolio methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
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

!TestPortfolio methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
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


!classDefinition: #TestReceptiveAccount category: 'Portfolio-2'!
TestCase subclass: #TestReceptiveAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!TestReceptiveAccount methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!TestReceptiveAccount methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!TestReceptiveAccount methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!TestReceptiveAccount methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!TestReceptiveAccount methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!TestReceptiveAccount methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!TestReceptiveAccount methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #TestSummary category: 'Portfolio-2'!
TestCase subclass: #TestSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!TestSummary methodsFor: 'tests' stamp: 'BW 6/2/2021 19:01:59'!
test01NewAccountGeneratesEmptySummary
	|account|
	account := ReceptiveAccount new.
	self assert: (Summary  for: account) equals: (OrderedCollection with: 'Balance = 0').! !

!TestSummary methodsFor: 'tests' stamp: 'BW 6/2/2021 19:01:59'!
test02SummaryRegistresSingeDeposit
	|account|
	account := ReceptiveAccount new.
	Deposit register: 10 on: account. 
	self assert: (Summary  for: account) equals: (OrderedCollection with: 'Depósito por 10' with: 'Balance = 10').! !

!TestSummary methodsFor: 'tests' stamp: 'BW 6/2/2021 19:01:58'!
test03SummaryRegistresMultipleDeposits
	|account|
	account := ReceptiveAccount new.
	Deposit register: 10 on: account. 
	Deposit register: 138 on: account.
	self assert: (Summary  for: account) equals: (OrderedCollection with: 'Depósito por 10' with: 'Depósito por 138' with: 'Balance = 148').! !

!TestSummary methodsFor: 'tests' stamp: 'BW 6/2/2021 19:01:59'!
test04SummaryRegistresSingleWithdraw
	|account|
	account := ReceptiveAccount new.
	Withdraw register: 10 on: account.
	self assert: (Summary  for: account) equals: (OrderedCollection with: 'Extracción por 10' with: 'Balance = -10').! !

!TestSummary methodsFor: 'tests' stamp: 'BW 6/2/2021 19:01:58'!
test05SummaryRegistresMultipleWithdraws
	|account|
	account := ReceptiveAccount new.
	Withdraw register: 10 on: account.
	Withdraw register: 32 on: account.
	self assert: (Summary  for: account) equals: (OrderedCollection with: 'Extracción por 10' with: 'Extracción por 32' with: 'Balance = -42').! !

!TestSummary methodsFor: 'tests' stamp: 'BW 6/2/2021 19:01:58'!
test06SummaryRegistresSingeExitTransference
	|account1 account2|
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Transference from: account1 to: account2 for: 10.
	self assert: (Summary  for: account1) equals: (OrderedCollection with: 'Salida por transferencia de 10'  with: 'Balance = -10').! !

!TestSummary methodsFor: 'tests' stamp: 'BW 6/2/2021 19:01:58'!
test07SummaryRegistresMultipleExitTransferences
	|account1 account2|
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Transference from: account1 to: account2 for: 10.
	Transference from: account1 to: account2 for: 20.
	self assert: (Summary  for: account1) equals: (OrderedCollection with: 'Salida por transferencia de 10' with: 'Salida por transferencia de 20'  with: 'Balance = -30').! !

!TestSummary methodsFor: 'tests' stamp: 'BW 6/2/2021 19:01:59'!
test08SummaryRegistresSingleEntryTransference
	|account1 account2|
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Transference from: account1 to: account2 for: 10.
	self assert: (Summary  for: account2) equals: (OrderedCollection with: 'Entrada por transferencia de 10'  with: 'Balance = 10').! !

!TestSummary methodsFor: 'tests' stamp: 'BW 6/2/2021 19:01:58'!
test09SummaryRegistresMultipleEntryTransferences
	|account1 account2|
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Transference from: account1 to: account2 for: 10.
	Transference from: account1 to: account2 for: 20.
	self assert: (Summary  for: account2) equals: (OrderedCollection with: 'Entrada por transferencia de 10' with: 'Entrada por transferencia de 20' with: 'Balance = 30').! !

!TestSummary methodsFor: 'tests' stamp: 'BW 6/2/2021 19:57:08'!
test10NewPortfolioGeneratesEmptySummary

	|portfolio|
	portfolio := Portfolio new.
	self assert: (Summary  for: portfolio) equals: (OrderedCollection with: 'Balance = 0').! !

!TestSummary methodsFor: 'tests' stamp: 'BW 6/2/2021 20:08:26'!
test11SummaryRegistersASingleReceptiveAccountSummaryInPortfolio

	|portfolio account|
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account.
	Deposit register: 10 on: account.
	self assert: (Summary  for: portfolio) equals: (OrderedCollection with: 'Depósito por 10' with: 'Balance = 10').! !

!TestSummary methodsFor: 'tests' stamp: 'BW 6/2/2021 20:08:34'!
test12SummaryRegistersMultipleReceptiveAccountSummariesInPortfolio

	|portfolio account1 account2|
	portfolio := Portfolio new.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio add: account1.
	portfolio add: account2.
	Deposit register: 10 on: account1.
	Withdraw register: 30 on: account2.
	
	self assert: (Summary  for: portfolio) equals: (OrderedCollection with: 'Depósito por 10' with: 'Extracción por 30' with: 'Balance = -20').! !

!TestSummary methodsFor: 'tests' stamp: 'BW 6/2/2021 20:01:48'!
test13SummaryRegistersAllAccountsSummariesInPortfolio
	
	|account1 account2 portfolio1 portfolio2|
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	portfolio1 add: portfolio2.
	
	portfolio1 add: account1.
	portfolio2 add: account2.
	
	Deposit register: 10 on: account1.
	Withdraw register: 20 on: account2.
	
	self assert: (Summary  for: portfolio1) equals: (OrderedCollection with: 'Extracción por 20' with: 'Depósito por 10' with: 'Balance = -10').! !


!classDefinition: #TestTransferNet category: 'Portfolio-2'!
TestCase subclass: #TestTransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!TestTransferNet methodsFor: 'tests' stamp: 'BW 6/2/2021 19:01:33'!
test01TransferNetIsZeroForNewAccount

	|account1 |
	account1 := ReceptiveAccount new.
	
	self assert: (TransferNet  for: account1) equals: 'Neto de transferencias = 0'.! !

!TestTransferNet methodsFor: 'tests' stamp: 'BW 6/2/2021 19:01:33'!
test02TransferNetRegistersASingeExitTransference

	|account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transference from: account1 to: account2 for: 10.
	
	self assert: (TransferNet  for: account1) equals: 'Neto de transferencias = -10'.! !

!TestTransferNet methodsFor: 'tests' stamp: 'BW 6/2/2021 19:01:34'!
test03TransferNetRegistersMultipleExitTransferences

	|account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transference from: account1 to: account2 for: 10.
	Transference from: account1 to: account2 for: 20.
	
	self assert: (TransferNet  for: account1) equals: 'Neto de transferencias = -30'.! !

!TestTransferNet methodsFor: 'tests' stamp: 'BW 6/2/2021 19:01:33'!
test04TransferNetRegistersASingleEntryTransference

	|account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transference from: account1 to: account2 for: 10.
	
	self assert: (TransferNet  for: account2) equals: 'Neto de transferencias = 10'.! !

!TestTransferNet methodsFor: 'tests' stamp: 'BW 6/2/2021 19:01:34'!
test05TransferNetRegistersMultipleEntryTransferences

	|account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transference from: account1 to: account2 for: 10.
	Transference from: account1 to: account2 for: 20.
	
	self assert: (TransferNet  for: account2) equals: 'Neto de transferencias = 30'.! !

!TestTransferNet methodsFor: 'tests' stamp: 'BW 6/2/2021 19:01:33'!
test06TransferNetDoesNotRegisterNonTransferenceTransactions

	|account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transference from: account1 to: account2 for: 10.
	Deposit register: 10 on: account2. 
	Withdraw register: 300 on: account2.
	
	self assert: (TransferNet  for: account2) equals: 'Neto de transferencias = 10'.
	self assert: (TransferNet  for: account1) equals: 'Neto de transferencias = -10'.! !

!TestTransferNet methodsFor: 'tests' stamp: 'BW 6/2/2021 20:02:26'!
test07TransferNetIsZeroForNewPortfolio

	|portfolio|
	portfolio := Portfolio new.

	self assert: (TransferNet  for: portfolio) equals:  'Neto de transferencias = 0'! !

!TestTransferNet methodsFor: 'tests' stamp: 'BW 6/2/2021 20:05:56'!
test08TransferNetRegistersASingleTransferenceInPortfolio

	|account1 account2 portfolio|
	portfolio := Portfolio new.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio add: account1.
	Transference from: account1 to: account2 for: 10.

	self assert: (TransferNet  for: portfolio) equals:  'Neto de transferencias = -10'! !

!TestTransferNet methodsFor: 'tests' stamp: 'BW 6/2/2021 20:06:02'!
test09TransferNetRegistersMultipleTransferencesInAPortfoliosOnlyAccount

	|account1 account2 portfolio|
	portfolio := Portfolio new.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio add: account1.
	Transference from: account1 to: account2 for: 10.
	Transference from: account1 to: account2 for: 20.
	
	self assert: (TransferNet  for: portfolio) equals:  'Neto de transferencias = -30'! !

!TestTransferNet methodsFor: 'tests' stamp: 'BW 6/2/2021 20:06:39'!
test10TransferNetDoesNotRegisterNonTransferenceTransactionsInPortfolio

	|account1 portfolio|
	portfolio := Portfolio new.
	account1 := ReceptiveAccount new.
	portfolio add: account1.
	Deposit register: 100 on: account1.
	Withdraw register: 500 on: account1.
	
	self assert: (TransferNet  for: portfolio) equals:  'Neto de transferencias = 0'! !

!TestTransferNet methodsFor: 'tests' stamp: 'BW 6/2/2021 20:09:20'!
test11TransferNetRegistresMultipleReceptiveAccountNetInPortfolio

	|account1 account2 account3 portfolio|
	portfolio := Portfolio new.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	portfolio add: account1.
	portfolio add: account2.
	
	Transference from: account1 to: account3 for: 10.
	Transference from: account3 to: account2 for: 50.	
	
	
	self assert: (TransferNet  for: portfolio) equals:  'Neto de transferencias = 40'! !

!TestTransferNet methodsFor: 'tests' stamp: 'BW 6/2/2021 20:10:00'!
test12TransferNetRegistresAllAccountNetInPortfolio

	|account1 account2 account3 portfolio1 portfolio2|
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio1 add: portfolio2.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	portfolio1 add: account1.
	portfolio2 add: account2.
	
	Transference from: account1 to: account3 for: 10.
	Transference from: account3 to: account2 for: 50.	
	
	
	self assert: (TransferNet  for: portfolio1) equals:  'Neto de transferencias = 40'! !


!classDefinition: #TestTransference category: 'Portfolio-2'!
TestCase subclass: #TestTransference
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!TestTransference methodsFor: 'tests' stamp: 'BW 5/31/2021 21:45:03'!
test01transferenceValueAppliesCorrectlyInEnvolvedAccounts
	|account1 account2 |

	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transference from: account1 to: account2 for: 10.
	
	self assert: account1 balance equals: -10.
	self assert: account2 balance equals: 10.! !

!TestTransference methodsFor: 'tests' stamp: 'BW 5/31/2021 21:46:48'!
test02valueCannotBeNegative
	|account1 account2 |

	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	self 
		should: [ Transference from: account1 to: account2 for: -10 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transference ceroOrNegativeTransactionErrorMessage equals: anError messageText.
			self assert: account1 balance equals: 0. 
			self assert: account2 balance equals: 0 ].
		! !

!TestTransference methodsFor: 'tests' stamp: 'BW 5/31/2021 21:47:58'!
test03valueCannotBeZero
	|account1 account2 |

	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	self 
		should: [ Transference from: account1 to: account2 for: 0 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transference ceroOrNegativeTransactionErrorMessage equals: anError messageText.
			self assert: account1 balance equals: 0. 
			self assert: account2 balance equals: 0 ].
		
	! !

!TestTransference methodsFor: 'tests' stamp: 'BW 5/31/2021 21:48:40'!
test04transferenceKnowsInvolvedAccountsAndValue
	|account1 account2 transference|

	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	transference := Transference from: account1 to: account2 for: 10.
	
	self assert: transference value equals: 10.
	self assert: (transference originAccount = account1).
	self assert: (transference destinationAccount = account2).! !

!TestTransference methodsFor: 'tests' stamp: 'BW 6/3/2021 15:20:04'!
test05transferenceIsRegisteredInInvolvedAccounts
	|account1 account2 transference|

	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	transference := Transference from: account1 to: account2 for: 10.
	
	self assert: (account1 hasRegistered: transference originEnd).
	self assert: (account2 hasRegistered: transference destinationEnd).	
! !

!TestTransference methodsFor: 'tests' stamp: 'BW 6/3/2021 15:14:36'!
test06transferenceCannotHaveSameSenderAndReceiver
	|account |

	account := ReceptiveAccount new.
	
	self should: [Transference from: account to: account for: 10] raise: Error -MessageNotUnderstood withMessageText: Transference sameAccountErrorMessage
	
	
	
! !


!classDefinition: #TestTreeStructure category: 'Portfolio-2'!
TestCase subclass: #TestTreeStructure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!TestTreeStructure methodsFor: 'as yet unclassified' stamp: 'BW 6/3/2021 00:06:30'!
test01StructureShowsNewPortfolioAlone
	| portfolio |
	portfolio := Portfolio named: 'PortfolioTest'.
	self assert: (TreeStructure for: portfolio) equals: (OrderedCollection with: 'PortfolioTest').! !

!TestTreeStructure methodsFor: 'as yet unclassified' stamp: 'BW 6/3/2021 00:06:30'!
test02StructureIndentsFirstLevelAccountsCorrectly
	| portfolio account|
	portfolio := Portfolio named: 'PortfolioTest'.
	account := ReceptiveAccount named: 'AccountTest'.
	portfolio add: account.
	self assert: (TreeStructure for: portfolio) equals: (OrderedCollection with: 'PortfolioTest' with: '   AccountTest').
	! !

!TestTreeStructure methodsFor: 'as yet unclassified' stamp: 'BW 6/3/2021 00:06:30'!
test03StructureIndentsFirstLevelPortfoliosCorrectly
	|portfolio portfolio2|
	portfolio := Portfolio named: 'PortfolioPadre'.
	portfolio2 := Portfolio named: 'PortfolioHijo'.
	portfolio add: portfolio2.
	self assert: (TreeStructure for: portfolio) equals: (OrderedCollection with: 'PortfolioPadre' with: '   PortfolioHijo').! !

!TestTreeStructure methodsFor: 'as yet unclassified' stamp: 'BW 6/3/2021 00:06:30'!
test04StructureIdentsAnyLevelAccountCorrectly
	|portfolio portfolio2 account portfolio3 |
	portfolio := Portfolio named: 'PortfolioPadre'.
	portfolio2 := Portfolio named: 'PortfolioHijo'.
	portfolio3 := Portfolio named: 'PortfolioNieto'.
	account := ReceptiveAccount named: 'CuentaNieta'.
	portfolio add: portfolio2.
	portfolio2 add: account.
	portfolio2 add: portfolio3.
	self assert: (TreeStructure for: portfolio) equals: (OrderedCollection with: 'PortfolioPadre' with: '   PortfolioHijo' with: '      CuentaNieta' with: '      PortfolioNieto').! !

!TestTreeStructure methodsFor: 'as yet unclassified' stamp: 'BW 6/3/2021 00:06:30'!
test05EjemploDelEnunciado
	| angiesAccount childrenPortfolio familyPortfolio johnsAccount myAccount |
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.
	childrenPortfolio := Portfolio named: 'Portfolio de hijos'.
	childrenPortfolio add: johnsAccount.
	childrenPortfolio add: angiesAccount.
	myAccount := ReceptiveAccount named: 'Cuenta mia'.
	familyPortfolio := Portfolio named: 'Portfolio de la familia'.
	familyPortfolio add: myAccount.
	familyPortfolio add: childrenPortfolio.
	
	self assert: (TreeStructure for: familyPortfolio ) equals: (OrderedCollection with: 'Portfolio de la familia' with: '   Cuenta mia' with: '   Portfolio de hijos' with: '      Cuenta de Juan' with: '      Cuenta de Angeles').! !


!classDefinition: #TestTreeStructureWithSummary category: 'Portfolio-2'!
TestCase subclass: #TestTreeStructureWithSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!TestTreeStructureWithSummary methodsFor: 'as yet unclassified' stamp: 'BW 6/3/2021 00:07:14'!
test01StructureShowsNewPortfolioAlone
	| portfolio |
	portfolio := Portfolio named: 'PortfolioTest'.
	self assert: (TreeStructureWithSummary for: portfolio) equals: (OrderedCollection with: 'PortfolioTest' with: '   Balance = 0').! !

!TestTreeStructureWithSummary methodsFor: 'as yet unclassified' stamp: 'BW 6/3/2021 00:07:14'!
test02StructureIndentsFirstLevelEmptyAccountsCorrectly
	| portfolio account|
	portfolio := Portfolio named: 'PortfolioTest'.
	account := ReceptiveAccount named: 'AccountTest'.
	portfolio add: account.
	self assert: (TreeStructureWithSummary for: portfolio) equals: (OrderedCollection with: 'PortfolioTest' 
															       with: '   AccountTest'
															       with: '      Balance = 0'
																with: '   Balance = 0').! !

!TestTreeStructureWithSummary methodsFor: 'as yet unclassified' stamp: 'BW 6/3/2021 00:41:45'!
test03StructureIdentsFirstLevelTransactionsCorrectly
	| portfolio account |
	portfolio := Portfolio named: 'PortfolioTest'.
	account := ReceptiveAccount named: 'AccountTest'.
	Deposit register: 10 on: account.
	portfolio add: account.
	self assert: (TreeStructureWithSummary for: portfolio) equals: (OrderedCollection with: 'PortfolioTest' 
															       with: '   AccountTest' 
															       with: '      Depósito por 10' 
															       with: '      Balance = 10'
															       with: '   Balance = 10').! !

!TestTreeStructureWithSummary methodsFor: 'as yet unclassified' stamp: 'BW 6/3/2021 00:42:20'!
test04tructureIdentsAnyLevelTransactionsCorrectly
	|portfolio portfolio2 account portfolio3 expected |
	portfolio := Portfolio named: 'PortfolioPadre'.
	portfolio2 := Portfolio named: 'PortfolioHijo'.
	portfolio3 := Portfolio named: 'PortfolioNieto'.
	account := ReceptiveAccount named: 'CuentaBisnieta'.
	Deposit register: 10 on: account. 
	portfolio add: portfolio2.
	portfolio2 add: portfolio3.
	portfolio3 add: account.
	expected := OrderedCollection      with: 'PortfolioPadre' 
								 with: '   PortfolioHijo'
								 with: '      PortfolioNieto'
								 with: '         CuentaBisnieta' 
								 with: '            Depósito por 10' 
								 with: '            Balance = 10'.
						  expected add: '         Balance = 10'.
						  expected add: '      Balance = 10'.
	                                       expected add: '   Balance = 10'	.
	self assert: (TreeStructureWithSummary for: portfolio) equals: expected.
	
	! !


!classDefinition: #Account category: 'Portfolio-2'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

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


!Account methodsFor: 'report interaction' stamp: 'BW 6/3/2021 00:36:46'!
acceptReport: aReport
	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'Portfolio-2'!
Account subclass: #Portfolio
	instanceVariableNames: 'parents name accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

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


!Portfolio methodsFor: 'initialization' stamp: 'BW 6/2/2021 20:31:52'!
initialize

	self initializeNamed: 'UnnamedPortfolio'.! !

!Portfolio methodsFor: 'initialization' stamp: 'BW 6/2/2021 20:31:22'!
initializeNamed: aName 
	name := aName.
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


!Portfolio methodsFor: 'report interaction' stamp: 'BW 6/3/2021 00:36:46'!
acceptReport: aReport
	aReport reportForPortfolio: self.! !

!Portfolio methodsFor: 'report interaction' stamp: 'BW 6/3/2021 00:39:19'!
reportForAllAccounts: aReport
	accounts do: [:anAccount | anAccount acceptReport: aReport]! !


!Portfolio methodsFor: 'name' stamp: 'BW 6/2/2021 20:34:39'!
name
	^name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-2'!
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


!Portfolio class methodsFor: 'instance creation' stamp: 'BW 6/2/2021 20:26:35'!
named: aName
	
	^self new initializeNamed: aName! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-2'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'BW 6/2/2021 20:39:01'!
initialize

	self initializeNamed: 'UnnamedReceptiveAccount'! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'BW 6/2/2021 20:38:42'!
initializeNamed: aName 
	
	name := aName.
	super initialize.
	transactions := OrderedCollection new.! !


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


!ReceptiveAccount methodsFor: 'report interaction' stamp: 'BW 6/3/2021 00:36:46'!
acceptReport: aReport
	^aReport reportForReceptiveAccount: self.! !

!ReceptiveAccount methodsFor: 'report interaction' stamp: 'BW 6/3/2021 00:39:45'!
reportForAllTransactions: aReport
	transactions do: [:aTransaction | aTransaction acceptReport: aReport]! !


!ReceptiveAccount methodsFor: 'name' stamp: 'BW 6/2/2021 20:48:32'!
name
	^name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-2'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'BW 6/2/2021 20:37:55'!
named: aName
	^self new initializeNamed: aName! !


!classDefinition: #AccountTransaction category: 'Portfolio-2'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'BW 5/31/2021 23:45:25'!
affectBalance: aBalance
	self subclassResponsibility.! !


!AccountTransaction methodsFor: 'report interaction' stamp: 'BW 6/3/2021 00:36:46'!
acceptReport: aReport
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-2'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-2'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!Deposit methodsFor: 'initialization' stamp: 'BW 5/31/2021 23:45:38'!
initializeFor: aValue
	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'report interaction' stamp: 'BW 6/3/2021 00:36:46'!
acceptReport: aReport
	^aReport reportForDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-2'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferenceEnd category: 'Portfolio-2'!
AccountTransaction subclass: #TransferenceEnd
	instanceVariableNames: 'account transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!TransferenceEnd methodsFor: 'value' stamp: 'BW 5/31/2021 23:23:28'!
value 
	^transference value! !


!TransferenceEnd methodsFor: 'testing' stamp: 'BW 5/31/2021 23:22:13'!
account
	^account! !


!TransferenceEnd methodsFor: 'initialization' stamp: 'BW 6/1/2021 18:11:12'!
account: anAccount
	account := anAccount.! !

!TransferenceEnd methodsFor: 'initialization' stamp: 'BW 5/31/2021 23:23:02'!
setTransference: aTransference
	transference := aTransference.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceEnd class' category: 'Portfolio-2'!
TransferenceEnd class
	instanceVariableNames: ''!

!TransferenceEnd class methodsFor: 'as yet unclassified' stamp: 'BW 5/31/2021 23:48:22'!
registerOn: anAccount  
	
	| withdrawTransference |
	withdrawTransference := self new account: anAccount.
	anAccount register: withdrawTransference.
	^withdrawTransference.! !


!classDefinition: #DepositTransference category: 'Portfolio-2'!
TransferenceEnd subclass: #DepositTransference
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!DepositTransference methodsFor: 'report interaction' stamp: 'BW 6/3/2021 00:36:46'!
acceptReport: aReport
	^aReport reportForDepositTransference: self.! !


!DepositTransference methodsFor: 'balance' stamp: 'BW 5/31/2021 22:11:40'!
affectBalance: aBalance

	^aBalance + self value ! !


!classDefinition: #WithdrawTransference category: 'Portfolio-2'!
TransferenceEnd subclass: #WithdrawTransference
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!WithdrawTransference methodsFor: 'report interaction' stamp: 'BW 6/3/2021 00:36:46'!
acceptReport: aReport
	^aReport reportForWithdrawTransference: self.! !


!WithdrawTransference methodsFor: 'balance' stamp: 'BW 5/31/2021 22:11:59'!
affectBalance: aBalance

	^aBalance - self value! !


!classDefinition: #Withdraw category: 'Portfolio-2'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'report interaction' stamp: 'BW 6/3/2021 00:36:46'!
acceptReport: aReport
	^aReport reportForWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-2'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: 'Portfolio-2'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!Report methodsFor: 'report' stamp: 'BW 6/2/2021 18:55:15'!
reportForPortfolio: aPortfolio
	self subclassResponsibility.! !

!Report methodsFor: 'report' stamp: 'BW 6/2/2021 18:55:31'!
reportForReceptiveAccount: aReceptiveAccount.
	self subclassResponsibility.! !


!Report methodsFor: 'inicialization' stamp: 'BW 6/2/2021 19:04:17'!
initializeFor: anAccount
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'Portfolio-2'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'instance creation' stamp: 'BW 6/2/2021 19:03:05'!
for: anAccount
	^self new initializeFor: anAccount.! !


!classDefinition: #IndentedReport category: 'Portfolio-2'!
Report subclass: #IndentedReport
	instanceVariableNames: 'jerarquia indentacion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!IndentedReport methodsFor: 'initialization' stamp: 'BW 6/3/2021 00:36:46'!
initializeFor: aPortfolio 
	jerarquia := OrderedCollection new.
	indentacion := ''.
	aPortfolio acceptReport: self.
	^jerarquia.! !


!IndentedReport methodsFor: 'report' stamp: 'BW 6/3/2021 00:14:17'!
decrementIndentation

	^ indentacion := indentacion copyFrom: 4 to: indentacion size! !

!IndentedReport methodsFor: 'report' stamp: 'BW 6/3/2021 00:14:29'!
incrementIndentation

	^ indentacion := indentacion, '   '! !


!classDefinition: #TreeStructure category: 'Portfolio-2'!
IndentedReport subclass: #TreeStructure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!


!TreeStructure methodsFor: 'report' stamp: 'BW 6/3/2021 00:39:19'!
reportForPortfolio: aPortfolio
 	
	jerarquia add: indentacion, aPortfolio name.
	self incrementIndentation.
	aPortfolio reportForAllAccounts: self.
	self decrementIndentation.
	
	! !

!TreeStructure methodsFor: 'report' stamp: 'BW 6/2/2021 21:05:41'!
reportForReceptiveAccount: aReceptiveAccount 
	
	jerarquia add: indentacion, aReceptiveAccount name.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TreeStructure class' category: 'Portfolio-2'!
TreeStructure class
	instanceVariableNames: ''!

!TreeStructure class methodsFor: 'instance creation' stamp: 'BW 6/2/2021 20:28:27'!
for: aPortfolio 
	^self new initializeFor: aPortfolio ! !


!classDefinition: #TreeStructureWithSummary category: 'Portfolio-2'!
IndentedReport subclass: #TreeStructureWithSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!


!TreeStructureWithSummary methodsFor: 'report' stamp: 'BW 6/3/2021 00:39:20'!
reportForPortfolio: aPortfolio 
	jerarquia add: indentacion, aPortfolio name. 
	self incrementIndentation.
	aPortfolio reportForAllAccounts: self.
	jerarquia add: indentacion, 'Balance = ', aPortfolio balance asString.
	self decrementIndentation.
	! !

!TreeStructureWithSummary methodsFor: 'report' stamp: 'BW 6/3/2021 00:15:01'!
reportForReceptiveAccount: aReceptiveAccount 
	
	jerarquia add: indentacion, aReceptiveAccount name. 
	self incrementIndentation.
	(Summary for: aReceptiveAccount) do: [:aString | jerarquia add: indentacion, aString].
	self decrementIndentation.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TreeStructureWithSummary class' category: 'Portfolio-2'!
TreeStructureWithSummary class
	instanceVariableNames: ''!

!TreeStructureWithSummary class methodsFor: 'instance creation' stamp: 'BW 6/2/2021 22:24:22'!
for: aPortfolio 
	^self new initializeFor: aPortfolio ! !


!classDefinition: #PlainReport category: 'Portfolio-2'!
Report subclass: #PlainReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!PlainReport methodsFor: 'transference management' stamp: 'BW 6/3/2021 00:08:52'!
reportForDeposit: aDeposit
	self subclassResponsibility.! !

!PlainReport methodsFor: 'transference management' stamp: 'BW 6/3/2021 00:07:49'!
reportForDepositTransference: aDepositTransference
	self subclassResponsibility.! !

!PlainReport methodsFor: 'transference management' stamp: 'BW 6/3/2021 00:09:14'!
reportForWithdraw: aWithdraw
	self subclassResponsibility.! !

!PlainReport methodsFor: 'transference management' stamp: 'BW 6/3/2021 00:08:17'!
reportForWithdrawTransference: aWithdrawTransference
	self subclassResponsibility.! !


!PlainReport methodsFor: 'report' stamp: 'BW 6/3/2021 00:39:20'!
reportForPortfolio: aPortfolio
	aPortfolio reportForAllAccounts: self.! !

!PlainReport methodsFor: 'report' stamp: 'BW 6/3/2021 00:39:45'!
reportForReceptiveAccount: aReceptiveAccount.
	aReceptiveAccount reportForAllTransactions: self.
	
	
	! !


!classDefinition: #Summary category: 'Portfolio-2'!
PlainReport subclass: #Summary
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!Summary methodsFor: 'inicialization' stamp: 'BW 6/3/2021 00:36:46'!
initializeFor: anAccount
	summary := OrderedCollection new.
	anAccount acceptReport: self.
	summary add: 'Balance = ', anAccount balance asString.
	^summary! !


!Summary methodsFor: 'transference management' stamp: 'BW 6/2/2021 19:46:21'!
reportForDeposit: aDeposit
	summary add: 'Depósito por ', aDeposit value asString
	
	
	! !

!Summary methodsFor: 'transference management' stamp: 'BW 6/2/2021 19:47:27'!
reportForDepositTransference: aDepositTransference
	summary add: 'Entrada por transferencia de ', aDepositTransference value asString
	
	
	
	! !

!Summary methodsFor: 'transference management' stamp: 'BW 6/2/2021 19:46:56'!
reportForWithdraw: aWithdraw
	summary add: 'Extracción por ', aWithdraw value asString.
	
	
	! !

!Summary methodsFor: 'transference management' stamp: 'BW 6/2/2021 19:48:04'!
reportForWithdrawTransference: aWithdrawTransference
	summary add: 'Salida por transferencia de ', aWithdrawTransference value asString
	
	
	
	! !


!classDefinition: #TransferNet category: 'Portfolio-2'!
PlainReport subclass: #TransferNet
	instanceVariableNames: 'neto'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!TransferNet methodsFor: 'inicialization' stamp: 'BW 6/3/2021 00:36:46'!
initializeFor: anAccount
	neto := 0.
	anAccount acceptReport: self.
	^'Neto de transferencias = ', neto asString. ! !


!TransferNet methodsFor: 'transference management' stamp: 'BW 6/2/2021 19:51:33'!
reportForDeposit: aDeposit
	
	
	! !

!TransferNet methodsFor: 'transference management' stamp: 'BW 6/2/2021 19:52:06'!
reportForDepositTransference: aDepositTransference
	neto := neto + aDepositTransference value.
	! !

!TransferNet methodsFor: 'transference management' stamp: 'BW 6/2/2021 19:51:43'!
reportForWithdraw: aWithdraw
	
	
	! !

!TransferNet methodsFor: 'transference management' stamp: 'BW 6/2/2021 19:52:33'!
reportForWithdrawTransference: aWithdrawTransference
	neto := neto - aWithdrawTransference value.
	
	! !


!classDefinition: #Transference category: 'Portfolio-2'!
Object subclass: #Transference
	instanceVariableNames: 'value origin destination'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-2'!

!Transference methodsFor: 'initialization' stamp: 'BW 6/3/2021 15:24:34'!
initializeFrom: anOriginAccount to: aDestinationAccount for: aValue

	origin := anOriginAccount .
	destination := aDestinationAccount.
	value := aValue.
	
	origin setTransference: self.
	destination setTransference: self.! !


!Transference methodsFor: 'value' stamp: 'BW 5/31/2021 21:49:42'!
value
	^value! !


!Transference methodsFor: 'accounts' stamp: 'BW 5/31/2021 22:06:42'!
destinationAccount
	^destination account! !

!Transference methodsFor: 'accounts' stamp: 'BW 5/31/2021 22:06:36'!
originAccount
	^origin account! !


!Transference methodsFor: 'transference ends' stamp: 'BW 6/3/2021 15:19:31'!
destinationEnd
	^destination! !

!Transference methodsFor: 'transference ends' stamp: 'BW 6/3/2021 15:20:04'!
originEnd 
	^origin! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: 'Portfolio-2'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'instance creation' stamp: 'BW 6/3/2021 15:24:34'!
from: anOriginAccount to: aDestinationAccount for: aValue

	| aDepositTransference aWithdrawTransference newTransference |
	aValue <= 0 ifTrue: [self error: self ceroOrNegativeTransactionErrorMessage ].
	anOriginAccount  = aDestinationAccount ifTrue: [self error: self sameAccountErrorMessage ].
	
	aDepositTransference := DepositTransference registerOn: aDestinationAccount.
	aWithdrawTransference := WithdrawTransference registerOn: anOriginAccount.
	
	newTransference := self new initializeFrom: aWithdrawTransference to: aDepositTransference for: aValue.
	
	^newTransference.! !


!Transference class methodsFor: 'error message' stamp: 'BW 5/31/2021 21:47:13'!
ceroOrNegativeTransactionErrorMessage
	^'error: transaction value must be positive'! !

!Transference class methodsFor: 'error message' stamp: 'BW 6/3/2021 15:15:46'!
sameAccountErrorMessage
	^'Error: sender and receiver must differ'! !
