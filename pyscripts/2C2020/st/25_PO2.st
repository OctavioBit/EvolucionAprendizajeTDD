!classDefinition: #AccountSummaryTest category: 'Portfolio2-Ejercicio'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'D S 11/14/2020 13:57:29'!
test01SummaryOfAccountWithoutTransactionsGenerateCorrectly
	|anAccountSummary anAccount|
	
	anAccount := ReceptiveAccount new.
	anAccountSummary := AccountSummary of: anAccount.
	
	self assert: (anAccountSummary summary) includes: 'Balance = 0'.
	self assert: (anAccountSummary relatedAccount) equals: anAccount! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'D S 11/14/2020 13:58:17'!
test02SummaryShowsCorrectBalance
	|anAccountSummary anAccount|
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	anAccountSummary := AccountSummary of: anAccount.

	
	self assert: (anAccountSummary summary) includes: 'Balance = 100'! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'D S 11/14/2020 13:58:49'!
test03SummaryShowsDepositAndItsValue
	|anAccountSummary anAccount|
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	anAccountSummary := AccountSummary of: anAccount.
	
	
	self assert: (anAccountSummary summary) includes: 'Deposito de 100'! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'D S 11/14/2020 13:59:15'!
test04SummaryDoesntShowInexistentTransactions
	|anAccountSummary anAccount|
	
	anAccount := ReceptiveAccount new.
	Deposit register: 150 on: anAccount.
	anAccountSummary := AccountSummary of: anAccount.
	
	self deny:( (anAccountSummary summary) includes: 'Deposito de 100')! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'D S 11/14/2020 13:59:32'!
test05SummaryShowsWithdrawAndItsValue
	|anAccountSummary anAccount|
	
	anAccount := ReceptiveAccount new.
	Withdraw register: 150 on: anAccount.
	anAccountSummary := AccountSummary of: anAccount.
	
	self assert:( (anAccountSummary summary) includes: 'Extraccion de 150')! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'D S 11/14/2020 14:00:06'!
test06SummaryShowsDepositEndOfTransferenceAndItsValue
	|anAccountSummary anAccount anAccount2|
	
	anAccount := ReceptiveAccount new.
	anAccount2 := ReceptiveAccount new.
	Transference from: anAccount2 to: anAccount amount: 150.
	anAccountSummary := AccountSummary of: anAccount.
	
	self assert:( (anAccountSummary summary) includes: 'Entrada por transferencia de 150')! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'D S 11/14/2020 14:00:24'!
test07SummaryShowsWithdrawEndOfTransferenceAndItsValue
	|anAccountSummary anAccount anAccount2|
	
	anAccount := ReceptiveAccount new.
	anAccount2 := ReceptiveAccount new.
	Transference from: anAccount to: anAccount2 amount: 150.
	anAccountSummary := AccountSummary of: anAccount.
	
	self assert:( (anAccountSummary summary) includes: 'Salida por transferencia de 150')! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'D S 11/14/2020 14:01:35'!
test08SummaryShowsMoreThanOneTransaction
	|anAccountSummary anAccount|
	
	anAccount := ReceptiveAccount new.
	Deposit register: 150 on: anAccount.
	Deposit register: 200 on: anAccount.

	anAccountSummary := AccountSummary of: anAccount.
	
	self assert:( (anAccountSummary summary) includes: 'Deposito de 200').
	self assert:( (anAccountSummary summary) includes: 'Deposito de 150')! !


!classDefinition: #DetailedAccountSummaryTest category: 'Portfolio2-Ejercicio'!
TestCase subclass: #DetailedAccountSummaryTest
	instanceVariableNames: 'summary account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!DetailedAccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'D S 11/15/2020 01:35:00'!
test01DetailedSummaryOfEmptyAccountGeneratesCorrectly
	|anAccount anDetailedSummary|
	
	anAccount := ReceptiveAccount named: 'Name'.
	anDetailedSummary := DetailedAccountSummary of: anAccount.
	
	self assert: (OrderedCollection with: 'Cuenta de Name' with: 'Balance = 0') equals: anDetailedSummary summary.
	self assert: (anAccount) equals: anDetailedSummary relatedAccount.! !

!DetailedAccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'D S 11/15/2020 01:35:24'!
test02SummaryOfAccountWithADepositGeneratesCorrectly
	|anAccount anDetailedSummary|
	
	anAccount := ReceptiveAccount named: 'Name'.
	Deposit register: 100 on: anAccount.
	anDetailedSummary := DetailedAccountSummary of: anAccount.
	
	self assert: (OrderedCollection with: 'Cuenta de Name' with: ' Deposito de 100'with: 'Balance = 100') equals: anDetailedSummary summary.! !

!DetailedAccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'D S 11/15/2020 01:36:19'!
test03SummaryOfAccountWithTwoDepositGeneratesCorrectly
	|anAccount anDetailedSummary|
	
	anAccount := ReceptiveAccount named: 'Name'.
	Deposit register: 100 on: anAccount.
	Deposit register: 200 on: anAccount.
	anDetailedSummary := DetailedAccountSummary of: anAccount.
	
	self assert: (OrderedCollection with: 'Cuenta de Name' with: ' Deposito de 100' with: ' Deposito de 200'with: 'Balance = 300') equals: anDetailedSummary summary.! !

!DetailedAccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'D S 11/15/2020 01:36:00'!
test04SummaryOfAccountWithAWithdrawGeneratesCorrectly
	|anAccount anDetailedSummary|
	
	anAccount := ReceptiveAccount named: 'Name'.
	Withdraw register: 100 on: anAccount.
	anDetailedSummary := DetailedAccountSummary of: anAccount.
	
	self assert: (OrderedCollection with: 'Cuenta de Name' with: ' Extraccion de 100'with: 'Balance = -100') equals: anDetailedSummary summary.! !

!DetailedAccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'D S 11/15/2020 01:36:42'!
test05SummaryOfAccountWithTwoWithdrawGeneratesCorrectly
	|anAccount anDetailedSummary|
	
	anAccount := ReceptiveAccount named: 'Name'.
	Withdraw register: 100 on: anAccount.
	Withdraw register: 200 on: anAccount.
	anDetailedSummary := DetailedAccountSummary of: anAccount.
	
	self assert: (OrderedCollection with: 'Cuenta de Name' with: ' Extraccion de 100' with: ' Extraccion de 200' with: 'Balance = -300') equals: anDetailedSummary summary.! !

!DetailedAccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'D S 11/15/2020 01:37:19'!
test06SummaryOfAccountWithDepositEndGeneratesCorrectly
	|anAccount anAccount2 anDetailedSummary|
	
	anAccount := ReceptiveAccount named: 'Name'.
	anAccount2 := ReceptiveAccount named: 'OtroName'.
	Transference from: anAccount2 to: anAccount  amount: 100. 
	anDetailedSummary := DetailedAccountSummary of: anAccount.
	
	self assert: (OrderedCollection with: 'Cuenta de Name' with: ' Entrada por transferencia de 100' with: 'Balance = 100') equals: anDetailedSummary summary.! !

!DetailedAccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'D S 11/15/2020 01:37:31'!
test07SummaryOfAccountWithTwoDepositEndGeneratesCorrectly
	|anAccount anAccount2 anDetailedSummary|
	
	anAccount := ReceptiveAccount named: 'Name'.
	anAccount2 := ReceptiveAccount named: 'OtroName'.
	Transference from: anAccount2 to: anAccount  amount: 100.
	Transference from: anAccount2 to: anAccount  amount: 200. 

	anDetailedSummary := DetailedAccountSummary of: anAccount.
	
	self assert: (OrderedCollection with: 'Cuenta de Name' with: ' Entrada por transferencia de 100' with: ' Entrada por transferencia de 200' with: 'Balance = 300') equals: anDetailedSummary summary.! !

!DetailedAccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'D S 11/15/2020 01:37:52'!
test08SummaryOfAccountWithWithdrawEndGeneratesCorrectly
	|anAccount anAccount2 anDetailedSummary|
	
	anAccount := ReceptiveAccount named: 'Name'.
	anAccount2 := ReceptiveAccount named: 'OtroName'.
	Transference from: anAccount to: anAccount2  amount: 100. 
	anDetailedSummary := DetailedAccountSummary of: anAccount.
	
	self assert: (OrderedCollection with: 'Cuenta de Name' with: ' Salida por transferencia de 100' with: 'Balance = -100') equals: anDetailedSummary summary.! !

!DetailedAccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'D S 11/15/2020 01:38:07'!
test09SummaryOfAccountWithTwoWithdrawEndGeneratesCorrectly
	|anAccount anAccount2 anDetailedSummary|
	
	anAccount := ReceptiveAccount named: 'Name'.
	anAccount2 := ReceptiveAccount named: 'OtroName'.
	Transference from: anAccount to: anAccount2  amount: 100. 
	Transference from: anAccount to: anAccount2  amount: 200. 	
	anDetailedSummary := DetailedAccountSummary of: anAccount.
	
	self assert: (OrderedCollection with: 'Cuenta de Name' with: ' Salida por transferencia de 100' with: ' Salida por transferencia de 200' with: 'Balance = -300') equals: anDetailedSummary summary.! !

!DetailedAccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'D S 11/15/2020 01:38:33'!
test10SummaryOfPortfolioWithAccountGeneratesCorrectly
	|anAccount anDetailedSummary aPortfolio|
	
	anAccount := ReceptiveAccount named: 'Name'.
	aPortfolio := Portfolio named: 'portfolio'.
	aPortfolio add: anAccount.
	anDetailedSummary := DetailedAccountSummary of: aPortfolio.
	
	self assert: (OrderedCollection with: 'Portfolio de portfolio' with: ' Cuenta de Name' with: ' Balance = 0' with: 'Balance = 0') equals: anDetailedSummary summary.! !

!DetailedAccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'D S 11/15/2020 01:46:31'!
test11SummaryIdentationOfAccountInsidePortfolioGeneratesCorrectly
	|anAccount anAccount2 anDetailedSummary aPortfolio expectedResult|
	
	anAccount := ReceptiveAccount named: 'Name'.
	anAccount2 := ReceptiveAccount named: 'OtherName'.
	aPortfolio := Portfolio named: 'portfolio'.
	aPortfolio add: anAccount.
	Deposit register: 100 on: anAccount.
	Withdraw register: 100 on: anAccount.
	Transference from: anAccount2 to: anAccount amount: 100. 
	Transference from: anAccount to: anAccount2 amount: 100. 
	anDetailedSummary := DetailedAccountSummary of: aPortfolio.
	expectedResult := OrderedCollection new.
	expectedResult addAll: #('Portfolio de portfolio' ' Cuenta de Name' '  Deposito de 100' '  Extraccion de 100' '  Entrada por transferencia de 100'  '  Salida por transferencia de 100'  ' Balance = 0'  'Balance = 0').
	
	self assert: (expectedResult) equals: anDetailedSummary summary.! !

!DetailedAccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'D S 11/15/2020 01:47:28'!
test12SummaryNameOfAccountIsCorrect
	|anAccount anDetailedSummary|
	
	anAccount := ReceptiveAccount named: 'OtherName'.
	anDetailedSummary := DetailedAccountSummary of: anAccount.
	
	self assert: (OrderedCollection with: 'Cuenta de OtherName' with: 'Balance = 0') equals: anDetailedSummary summary.! !

!DetailedAccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'D S 11/15/2020 01:47:40'!
test13SummaryNameOfPortfolioIsCorrect
	|anDetailedSummary aPortfolio aPortfolio2|
	
	aPortfolio2 := Portfolio named: 'OtroPortfolio2'.
	aPortfolio := Portfolio named: 'OtroPortfolio'.
	aPortfolio add: aPortfolio2.
	anDetailedSummary := DetailedAccountSummary of: aPortfolio.
	
	self assert: (OrderedCollection with: 'Portfolio de OtroPortfolio' with: ' Portfolio de OtroPortfolio2' with: ' Balance = 0' with: 'Balance = 0') equals: anDetailedSummary summary.! !

!DetailedAccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'D S 11/15/2020 01:49:40'!
test14SummaryRelatedAccountCannotBeEmpty
	|anAccount anDetailedSummary|
	
	anAccount := ReceptiveAccount named: 'Name'.
	anDetailedSummary := DetailedAccountSummary of: anAccount.
	
	self assert: (anAccount) equals: anDetailedSummary relatedAccount.! !


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

!PortfolioTest methodsFor: 'tests' stamp: 'D S 11/15/2020 02:02:43'!
test16AddNameCorrectly
	| aPortfolio |
	
	aPortfolio := Portfolio named: 'unNombre'.
	
	self assert: 'unNombre' equals: aPortfolio name! !

!PortfolioTest methodsFor: 'tests' stamp: 'D S 11/15/2020 02:03:05'!
test17AddNamePortfolioIfNameIsEmpty
	| aPortfolio |
	
	aPortfolio := Portfolio named: ''.
	
	self assert: 'portfolio' equals: aPortfolio name! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio2-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'D S 11/9/2020 22:20:41'!
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'D S 11/15/2020 01:59:02'!
test08AddNameCorrectly

	| account |
	
	account := ReceptiveAccount named: 'aName'.
		
	self assert: 'aName' equals: account name.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'D S 11/15/2020 01:59:18'!
test09AddNameReceptiveAccountIfNameIsEmpty

	| account |
	
	account := ReceptiveAccount named: ''.
		
	self assert: 'ReceptiveAccount' equals: account name.
! !


!classDefinition: #TransferNetTest category: 'Portfolio2-Ejercicio'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'D S 11/15/2020 12:43:36'!
test01TransferNetFromAnEmptyAccountReturns0
	|anAccount aTransferNet|
	
	anAccount:= ReceptiveAccount new.
	aTransferNet := TransferNet of: anAccount.
	
	self assert: (aTransferNet summary) equals: 0.! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'D S 11/15/2020 12:43:42'!
test02TransferNetForAnAccountWithATransferenceReturnsCorrectly
	|anAccountTransferNet anAccount anAccount2|
	
	anAccount := ReceptiveAccount new.
	anAccount2 := ReceptiveAccount new.
	Transference from: anAccount2 to: anAccount amount: 100.
	anAccountTransferNet := TransferNet of: anAccount.

	
	self assert: (anAccountTransferNet summary) equals: 100! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'D S 11/15/2020 12:43:48'!
test03TransferNetForAnAccountWithTwoTransferenceReturnsCorrectly
	|anAccountTransferNet anAccount anAccount2|
	
	anAccount := ReceptiveAccount new.
	anAccount2 := ReceptiveAccount new.
	Transference from: anAccount2 to: anAccount amount: 150.
	Transference from: anAccount2 to: anAccount amount: 100.

	anAccountTransferNet := TransferNet of: anAccount.

	
	self assert: (anAccountTransferNet summary) equals: 250! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'D S 11/15/2020 12:43:52'!
test04WithdrawEndAffectsNegatively
	|anAccountTransferNet anAccount anAccount2|
	
	anAccount := ReceptiveAccount new.
	anAccount2 := ReceptiveAccount new.
	Transference from: anAccount2 to: anAccount amount: 150.
	Transference from: anAccount to: anAccount2 amount: 100.

	anAccountTransferNet := TransferNet of: anAccount.

	
	self assert: (anAccountTransferNet summary) equals: 50! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'D S 11/15/2020 12:43:58'!
test05TransferNetOfAPortfolioReturnsCorrectly
	|anAccountTransferNet anAccount anAccount2 aPortfolio|
	
	anAccount := ReceptiveAccount new.
	anAccount2 := ReceptiveAccount new.
	aPortfolio := Portfolio new.
	Transference from: anAccount2 to: anAccount amount: 150.
	Transference from: anAccount to: anAccount2 amount: 100.
	aPortfolio add: anAccount.
	anAccountTransferNet := TransferNet of: aPortfolio.

	
	self assert: (anAccountTransferNet summary) equals: 50! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'D S 11/15/2020 12:44:03'!
test06TransferNetOfAnEmptyPortfolioReturnsCorrectly
	|anAccountTransferNet aPortfolio|
	
	aPortfolio := Portfolio new.
	anAccountTransferNet := TransferNet of: aPortfolio.
	
	self assert: (anAccountTransferNet summary) equals: 0! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'D S 11/15/2020 12:44:08'!
test07TransferNetOfAPortfolioWith2AccountsReturnsCorrectly
	|anAccountTransferNet anAccount anAccount2 aPortfolio|
	
	anAccount := ReceptiveAccount new.
	anAccount2 := ReceptiveAccount new.
	aPortfolio := Portfolio new.
	Transference from: anAccount2 to: anAccount amount: 150.
	Transference from: anAccount to: anAccount2 amount: 100.
	aPortfolio add: anAccount.
	aPortfolio add: anAccount2.
	anAccountTransferNet := TransferNet of: aPortfolio.

	self assert: 0 equals: (anAccountTransferNet summary)! !


!classDefinition: #TransferenceTest category: 'Portfolio2-Ejercicio'!
TestCase subclass: #TransferenceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!TransferenceTest methodsFor: 'as yet unclassified' stamp: 'D S 11/9/2020 22:37:20'!
test01TransactionInitializeCorrectly
	|anAccountToExtract anAccountToDeposit anTransaction|

	anAccountToExtract := ReceptiveAccount new.
	anAccountToDeposit := ReceptiveAccount new.
	anTransaction := Transference from: anAccountToExtract to: anAccountToDeposit amount: 100.
	
	self assert: 100 equals: anTransaction amountToTransfer.
	self assert: (anAccountToExtract = (anTransaction extractFrom)).
	self assert: (anAccountToDeposit = (anTransaction depositTo)).	! !

!TransferenceTest methodsFor: 'as yet unclassified' stamp: 'D S 11/9/2020 22:37:33'!
test02TransactionAffectsCorrectly
	|anAccountToExtract anAccountToDeposit |

	anAccountToExtract := ReceptiveAccount new.
	anAccountToDeposit := ReceptiveAccount new.
	Deposit register: 100 on: anAccountToExtract.
	Transference from: anAccountToExtract to: anAccountToDeposit amount: 50.
	
	self assert: 50 equals: anAccountToExtract balance.
	self assert: 50 equals: anAccountToDeposit balance.	! !

!TransferenceTest methodsFor: 'as yet unclassified' stamp: 'D S 11/9/2020 22:45:01'!
test03EachEndOfTransferenceAppearsCorrectlyInAccounts
	|anAccountToExtract anAccountToDeposit aTransference|

	anAccountToExtract := ReceptiveAccount new.
	anAccountToDeposit := ReceptiveAccount new.
	Deposit register: 100 on: anAccountToExtract.
	aTransference := Transference from: anAccountToExtract to: anAccountToDeposit amount: 50.
	
	self assert:((anAccountToExtract transactions) includes: (aTransference withdrawEnd)).	
	self assert:((anAccountToDeposit transactions) includes: (aTransference depositEnd)).! !

!TransferenceTest methodsFor: 'as yet unclassified' stamp: 'D S 11/9/2020 22:45:31'!
test04FromOneTransferenceEndCanReachToTheAnother
	|anAccountToExtract anAccountToDeposit aTransference|

	anAccountToExtract := ReceptiveAccount new.
	anAccountToDeposit := ReceptiveAccount new.
	Deposit register: 100 on: anAccountToExtract.
	aTransference := Transference from: anAccountToExtract to: anAccountToDeposit amount: 50.
	
	self assert: (aTransference depositEnd) equals: (aTransference withdrawEnd depositEnd).
	self assert: (aTransference withdrawEnd) equals: (aTransference depositEnd withdrawEnd ).	! !

!TransferenceTest methodsFor: 'as yet unclassified' stamp: 'D S 11/10/2020 19:02:19'!
test05ValueFromEachEndAreTheSame
	|anAccountToExtract anAccountToDeposit aTransference|

	anAccountToExtract := ReceptiveAccount new.
	anAccountToDeposit := ReceptiveAccount new.
	Deposit register: 100 on: anAccountToExtract.
	aTransference := Transference from: anAccountToExtract to: anAccountToDeposit amount: 50.
	
	self assert: (50) equals: (aTransference withdrawEnd value).
	self assert: (50) equals: (aTransference depositEnd value).
! !

!TransferenceTest methodsFor: 'as yet unclassified' stamp: 'D S 11/9/2020 22:46:34'!
test06RaiseErrorWhenAmountToTransferIsNEGATIVE
	|anAccountToExtract anAccountToDeposit |

	anAccountToExtract := ReceptiveAccount new.
	anAccountToDeposit := ReceptiveAccount new.
	Deposit register: 100 on: anAccountToExtract.
	
	self 
		should: [Transference from: anAccountToExtract to: anAccountToDeposit amount: -50.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: Transference errorMessageCannotBeNegative equals: anError messageText.]! !

!TransferenceTest methodsFor: 'as yet unclassified' stamp: 'D S 11/9/2020 22:47:45'!
test07RaiseErrorWhenAccountToTransferIsEqualToAccountToExtract
	|anAccount |

	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	
	self 
		should: [Transference from: anAccount to: anAccount amount: 50.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: Transference errorMessageCannotTransferToSelf equals: anError messageText.]! !

!TransferenceTest methodsFor: 'as yet unclassified' stamp: 'D S 11/10/2020 19:02:41'!
test08RaiseErrorWhenAmountToTransferIsZERO
	|anAccountToExtract anAccountToDeposit |

	anAccountToExtract := ReceptiveAccount new.
	anAccountToDeposit := ReceptiveAccount new.
	Deposit register: 100 on: anAccountToExtract.
	
	self 
		should: [Transference from: anAccountToExtract to: anAccountToDeposit amount: 0.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: Transference errorMessageCannotBeZero equals: anError messageText.]! !


!classDefinition: #TreeStructureTest category: 'Portfolio2-Ejercicio'!
TestCase subclass: #TreeStructureTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!TreeStructureTest methodsFor: 'as yet unclassified' stamp: 'D S 11/15/2020 13:09:36'!
test01TreeStructureOfAnAccountGeneratesCorrectly
	|aTreeReport anAccount|
	anAccount := ReceptiveAccount named: 'UnaCuentaVacia'.
	aTreeReport := TreeStructure of: anAccount.
	
	self assert: (aTreeReport summary) equals: (OrderedCollection with: 'Cuenta de UnaCuentaVacia').! !

!TreeStructureTest methodsFor: 'as yet unclassified' stamp: 'D S 11/15/2020 13:09:36'!
test02TreeStructureOfEmptyPortfolioGeneratesCorrectly
	|aTreeReport aPortfolio|
	aPortfolio := Portfolio named: 'NoName'.
	aTreeReport := TreeStructure of: aPortfolio.
	
	self assert: (OrderedCollection with: 'Portfolio de NoName') equals: (aTreeReport summary).! !

!TreeStructureTest methodsFor: 'as yet unclassified' stamp: 'D S 11/14/2020 23:40:05'!
test03RelatedAccountOfTheStructureIsCorrect
	|aTreeReport anAccount|
	anAccount := ReceptiveAccount named: 'UnaCuentaVacia'.
	aTreeReport := TreeStructure of: anAccount.
	
	self assert: (aTreeReport relatedAccount) equals: (anAccount).! !

!TreeStructureTest methodsFor: 'as yet unclassified' stamp: 'D S 11/15/2020 13:09:36'!
test04IdentationGeneratesCorrectly
	|aTreeReport anAccount aPortfolio|
	anAccount := ReceptiveAccount named: 'UnaCuentaVacia'.
	aPortfolio := Portfolio named: 'NoName'.
	aPortfolio add: anAccount.
	aTreeReport := TreeStructure of: aPortfolio.
	
	self assert: (OrderedCollection with: 'Portfolio de NoName' with: ' Cuenta de UnaCuentaVacia') equals: (aTreeReport summary).! !

!TreeStructureTest methodsFor: 'as yet unclassified' stamp: 'D S 11/16/2020 16:49:14'!
test05TreeStructureOfPortfolioWithMoreThanOneAccountGeneratesCorrectly
	|aTreeReport anAccount anAccount2 aPortfolio|
	anAccount := ReceptiveAccount named: 'Name'.
	anAccount2 := ReceptiveAccount named: 'AnotherName'.
	aPortfolio := Portfolio named: 'Amigos'.
	aPortfolio add: anAccount.
	aPortfolio add: anAccount2.
	aTreeReport := TreeStructure of: aPortfolio.
	
	self assert: (OrderedCollection  with: 'Portfolio de Amigos' with: ' Cuenta de Name' with: ' Cuenta de AnotherName') equals: (aTreeReport summary).! !

!TreeStructureTest methodsFor: 'as yet unclassified' stamp: 'D S 11/16/2020 16:49:36'!
test06TreeStructureOfAPortfolioWithOtherInsideEmptyGeneratesCorrectly
	|aTreeReport anAccount anAccount2 anAccount3 aPortfolio aPortfolio2|
	anAccount := ReceptiveAccount named: 'Name'.
	anAccount2 := ReceptiveAccount named: 'AnotherName'.
	anAccount3 := ReceptiveAccount named: 'Alguien'.
	aPortfolio := Portfolio named: 'Amigos'.
	aPortfolio2 := Portfolio named: 'Vacio'.
	aPortfolio add: anAccount.
	aPortfolio add: anAccount2.
	aPortfolio add: aPortfolio2.
	aPortfolio add: anAccount3.
	aTreeReport := TreeStructure of: aPortfolio.
	
	self assert: (OrderedCollection  with: 'Portfolio de Amigos' with: ' Cuenta de Name' with: ' Cuenta de AnotherName' 
	with: ' Portfolio de Vacio' with: ' Cuenta de Alguien') equals: (aTreeReport summary).! !


!classDefinition: #Account category: 'Portfolio2-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
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


!classDefinition: #Portfolio category: 'Portfolio2-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name'
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

!Portfolio methodsFor: 'accounts management' stamp: 'D S 11/15/2020 02:03:20'!
addName: aName
	aName = '' ifTrue:[name := 'portfolio']
	ifFalse: [name := aName.]! !

!Portfolio methodsFor: 'accounts management' stamp: 'D S 11/15/2020 02:02:24'!
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


!Portfolio methodsFor: 'report --Private--' stamp: 'D S 11/16/2020 16:45:29'!
sendMessagesToGenerateReport: aReport

	"Sin el punto opcional, solo estaria la linea de accounts do. "
	aReport addPortfolio: self.
	accounts do: [:anAccount| anAccount sendMessagesToGenerateReport: aReport].
	aReport executeActionsAfterProcessingAccountsInPortfolio: self.! !


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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio2-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'NR 11/9/2020 06:01:26'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio!!'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'D S 11/14/2020 21:45:10'!
named: aName

	^self new addName: aName! !

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


!classDefinition: #ReceptiveAccount category: 'Portfolio2-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'D S 11/15/2020 01:58:40'!
addName: aName
	aName = '' ifTrue:[name := 'ReceptiveAccount']
	ifFalse: [name := aName.]! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'NR 11/9/2020 05:56:36'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions copy! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'D S 11/14/2020 23:28:18'!
name
	
	^name! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'D S 11/10/2020 20:37:16'!
transferNet
	|balance|
	balance := 0.
	transactions do:[:aTransaction | 
		(aTransaction isKindOf: DepositEnd) 
			ifTrue:[balance := balance + aTransaction value].
		(aTransaction isKindOf: WithdrawEnd) 
			ifTrue:[balance := balance + ((aTransaction value) * (-1))]].
	^ balance! !


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


!ReceptiveAccount methodsFor: 'report --Private--' stamp: 'D S 11/16/2020 16:45:29'!
sendMessagesToGenerateReport: aReport

	"Sin el punto opcional, solo estaria la linea de transactions do"
	aReport addAccount: self.
	transactions do: [:aTransaction | aTransaction addToReport: aReport].
	aReport executeActionsAfterProcessingTransactionsInReceptiveAccount: self.! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio2-Ejercicio'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'D S 11/14/2020 21:31:43'!
named: aName

	^self new addName: aName	! !


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


!Deposit methodsFor: 'balance' stamp: 'D S 11/14/2020 16:17:00'!
addToReport: aSummary

	aSummary addDeposit: self.! !

!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio2-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


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


!Withdraw methodsFor: 'balance' stamp: 'D S 11/14/2020 16:17:29'!
addToReport: aSummary

	aSummary addWithdraw: self.! !

!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio2-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: 'Portfolio2-Ejercicio'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Report methodsFor: 'accessing' stamp: 'D S 11/15/2020 12:40:35'!
relatedAccount

	^self class subclassResponsibility.! !

!Report methodsFor: 'accessing' stamp: 'D S 11/15/2020 12:40:32'!
summary

	^self class subclassResponsibility.! !


!Report methodsFor: 'generateReport' stamp: 'D S 11/15/2020 12:50:41'!
generateReportOfAccount: anAccount

	^self class subclassResponsibility.! !


!Report methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 12:57:00'!
addAccount: aReceptiveAccount

	^self class subclassResponsibility.! !

!Report methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 12:39:53'!
addDeposit: aDeposit

	^self class subclassResponsibility.! !

!Report methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 12:40:15'!
addDepositEnd: aDepositEnd

	^self class subclassResponsibility.! !

!Report methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 12:38:26'!
addPortfolio: aPortfolio

	^self class subclassResponsibility.! !

!Report methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 12:40:04'!
addWithdraw: aWithdraw

	^self class subclassResponsibility.! !

!Report methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 12:40:08'!
addWithdrawEnd: aWithdrawEnd

	^self class subclassResponsibility.! !

!Report methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 13:00:54'!
executeActionsAfterProcessingAccountsInPortfolio: aPortfolio

	^self class subclassResponsibility.! !

!Report methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 12:56:48'!
executeActionsAfterProcessingTransactionsInReceptiveAccount: aReceptiveAccount

	^self class subclassResponsibility.! !


!classDefinition: #AccountSummary category: 'Portfolio2-Ejercicio'!
Report subclass: #AccountSummary
	instanceVariableNames: 'summary account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!AccountSummary methodsFor: 'accessing' stamp: 'D S 11/13/2020 14:02:56'!
relatedAccount

	^account! !

!AccountSummary methodsFor: 'accessing' stamp: 'D S 11/13/2020 14:10:56'!
summary

	^summary! !


!AccountSummary methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 14:50:49'!
addAccount: aReceptiveAccount
! !

!AccountSummary methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 14:51:10'!
addDeposit: aDeposit

	summary add: 'Deposito de ', aDeposit value asString! !

!AccountSummary methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 14:51:22'!
addDepositEnd: aDepositEnd
	
	summary add: 'Entrada por transferencia de ', aDepositEnd value asString! !

!AccountSummary methodsFor: 'generateReport --Private--' stamp: 'D S 11/14/2020 23:19:59'!
addPortfolio: aPortfolio
	
	! !

!AccountSummary methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 14:51:45'!
addWithdraw: aWithdraw

	summary add: 'Extraccion de ', aWithdraw value asString! !

!AccountSummary methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 14:51:55'!
addWithdrawEnd: aWithdrawEnd

	summary add: 'Salida por transferencia de ', aWithdrawEnd value asString! !

!AccountSummary methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 12:54:49'!
executeActionsAfterProcessingAccountsInPortfolio: anPortfolio
! !

!AccountSummary methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 14:52:03'!
executeActionsAfterProcessingTransactionsInReceptiveAccount: aReceptiveAccount
! !


!AccountSummary methodsFor: 'generateReport' stamp: 'D S 11/16/2020 16:45:29'!
generateReportOfAccount: anAccount

	account := anAccount.
	summary := OrderedCollection new.

	anAccount sendMessagesToGenerateReport: self.
	summary add: 'Balance = ', (account balance asString)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio2-Ejercicio'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'as yet unclassified' stamp: 'D S 11/15/2020 12:50:26'!
of: anAccount

	^self new generateReportOfAccount: anAccount! !


!classDefinition: #DetailedAccountSummary category: 'Portfolio2-Ejercicio'!
Report subclass: #DetailedAccountSummary
	instanceVariableNames: 'summary account identation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!DetailedAccountSummary methodsFor: 'accessing' stamp: 'D S 11/15/2020 01:33:55'!
relatedAccount

	^account.
! !

!DetailedAccountSummary methodsFor: 'accessing' stamp: 'D S 11/15/2020 00:31:18'!
summary

	^summary ! !


!DetailedAccountSummary methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 14:52:14'!
addAccount: aReceptiveAccount
	|initialSpace|
	
	initialSpace := String new.
	identation timesRepeat: [initialSpace:= initialSpace, ' '].
	summary add: (initialSpace, 'Cuenta de ', aReceptiveAccount name).
	identation := identation + 1! !

!DetailedAccountSummary methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 14:52:25'!
addDeposit: aDeposit
	|initialSpace|
	initialSpace := String new.
	identation timesRepeat: [initialSpace := initialSpace, ' '].
	summary add: (initialSpace, 'Deposito de ', aDeposit value asString).! !

!DetailedAccountSummary methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 14:52:36'!
addDepositEnd: aDepositEnd
	|initialSpace|
	initialSpace := String new.
	identation timesRepeat: [initialSpace := initialSpace, ' '].
	summary add: (initialSpace,'Entrada por transferencia de ', aDepositEnd value asString).! !

!DetailedAccountSummary methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 01:26:20'!
addPortfolio: anPortfolio
	|initialSpace|
	initialSpace := String new.
	identation timesRepeat: [initialSpace := initialSpace , ' '].
	summary add: (initialSpace,'Portfolio de ', anPortfolio name).
	identation := identation +1.! !

!DetailedAccountSummary methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 14:52:47'!
addWithdraw: aWithdraw
	|initialSpace|
	initialSpace := String new.
	identation timesRepeat: [initialSpace := initialSpace, ' '].
	summary add: (initialSpace, 'Extraccion de ', aWithdraw value asString).! !

!DetailedAccountSummary methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 14:53:01'!
addWithdrawEnd: aWithdrawEnd
	|initialSpace|
	initialSpace := String new.
	identation timesRepeat: [initialSpace := initialSpace, ' '].
	summary add: (initialSpace,'Salida por transferencia de ', aWithdrawEnd value asString).! !

!DetailedAccountSummary methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 12:54:49'!
executeActionsAfterProcessingAccountsInPortfolio: aPortfolio
	|initialSpace|
	identation := identation - 1.
	initialSpace := String new.
	identation timesRepeat: [initialSpace := initialSpace, ' '].
	summary add: (initialSpace,'Balance = ', aPortfolio balance asString).! !

!DetailedAccountSummary methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 14:53:11'!
executeActionsAfterProcessingTransactionsInReceptiveAccount: aReceptiveAccount
	|initialSpace|
	
	identation := identation - 1.
	initialSpace := String new.
	identation timesRepeat: [initialSpace:= initialSpace, ' '].
	summary add: (initialSpace,'Balance = ', aReceptiveAccount balance asString).! !


!DetailedAccountSummary methodsFor: 'generateReport' stamp: 'D S 11/16/2020 16:45:29'!
generateReportOfAccount: anAccount

	account := anAccount.
	identation := 0.
	summary := OrderedCollection new.
	anAccount sendMessagesToGenerateReport: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DetailedAccountSummary class' category: 'Portfolio2-Ejercicio'!
DetailedAccountSummary class
	instanceVariableNames: ''!

!DetailedAccountSummary class methodsFor: 'as yet unclassified' stamp: 'D S 11/15/2020 12:50:13'!
of: anAccount

	^self new generateReportOfAccount: anAccount.! !


!classDefinition: #TransferNet category: 'Portfolio2-Ejercicio'!
Report subclass: #TransferNet
	instanceVariableNames: 'summary account transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!TransferNet methodsFor: 'accessing' stamp: 'D S 11/14/2020 16:10:15'!
relatedAccount

	^account.! !

!TransferNet methodsFor: 'accessing' stamp: 'D S 11/15/2020 12:42:31'!
summary

	^transferNet.! !


!TransferNet methodsFor: 'generateReport' stamp: 'D S 11/16/2020 16:45:29'!
generateReportOfAccount: anAccount

	transferNet := 0.
	account := anAccount.
	account sendMessagesToGenerateReport: self! !


!TransferNet methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 14:54:05'!
addAccount: aReceptiveAccount
! !

!TransferNet methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 14:53:58'!
addDeposit: aDeposit

! !

!TransferNet methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 14:53:53'!
addDepositEnd: aDepositEnd

	transferNet := transferNet + aDepositEnd value! !

!TransferNet methodsFor: 'generateReport --Private--' stamp: 'D S 11/14/2020 23:20:06'!
addPortfolio: aPortfolio
! !

!TransferNet methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 14:53:41'!
addWithdraw: aWithdraw

! !

!TransferNet methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 14:53:33'!
addWithdrawEnd: aWithdrawEnd

	transferNet := transferNet - aWithdrawEnd value! !

!TransferNet methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 12:54:49'!
executeActionsAfterProcessingAccountsInPortfolio: aPortfolio

! !

!TransferNet methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 14:53:18'!
executeActionsAfterProcessingTransactionsInReceptiveAccount: aReceptiveAccount
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'Portfolio2-Ejercicio'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'as yet unclassified' stamp: 'D S 11/15/2020 12:49:48'!
of: anAccount

	^self new generateReportOfAccount: anAccount! !


!classDefinition: #TreeStructure category: 'Portfolio2-Ejercicio'!
Report subclass: #TreeStructure
	instanceVariableNames: 'summary account treeStructure identation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!TreeStructure methodsFor: 'accessing' stamp: 'D S 11/14/2020 21:50:12'!
relatedAccount

	^account.! !

!TreeStructure methodsFor: 'accessing' stamp: 'D S 11/15/2020 13:09:36'!
summary

	^treeStructure! !


!TreeStructure methodsFor: 'generateReport' stamp: 'D S 11/16/2020 16:45:29'!
generateReportOfAccount: anAccount

	account := anAccount.
	identation := 0.
	treeStructure := OrderedCollection new.
	anAccount sendMessagesToGenerateReport: self.! !


!TreeStructure methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 14:54:17'!
addAccount: aReceptiveAccount
	|initialSpace|
	
	initialSpace := String new.
	(identation timesRepeat: [initialSpace := initialSpace, ' ']).
	treeStructure add: (initialSpace , 'Cuenta de ',aReceptiveAccount name).
! !

!TreeStructure methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 14:54:22'!
addDeposit: aDeposit! !

!TreeStructure methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 14:54:27'!
addDepositEnd: aDepositEnd! !

!TreeStructure methodsFor: 'generateReport --Private--' stamp: 'D S 11/14/2020 23:32:56'!
addPortfolio: anPortfolio
	|initialSpace|
	
	initialSpace := String new.
	(identation timesRepeat: [initialSpace := initialSpace, ' ']).
	treeStructure add: (initialSpace ,'Portfolio de ',anPortfolio name).
	identation := identation +1.
! !

!TreeStructure methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 14:54:33'!
addWithdraw: aWithdraw! !

!TreeStructure methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 14:54:39'!
addWithdrawEnd: aWithdrawEnd! !

!TreeStructure methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 12:54:49'!
executeActionsAfterProcessingAccountsInPortfolio: aPortfolio

	identation := identation -1! !

!TreeStructure methodsFor: 'generateReport --Private--' stamp: 'D S 11/15/2020 14:54:46'!
executeActionsAfterProcessingTransactionsInReceptiveAccount: aReceptiveAccount

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TreeStructure class' category: 'Portfolio2-Ejercicio'!
TreeStructure class
	instanceVariableNames: ''!

!TreeStructure class methodsFor: 'as yet unclassified' stamp: 'D S 11/15/2020 12:49:28'!
of: anAccount

	^self new generateReportOfAccount: anAccount! !


!classDefinition: #Transference category: 'Portfolio2-Ejercicio'!
Object subclass: #Transference
	instanceVariableNames: 'amountToTransfer withdrawEnd depositEnd'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Transference methodsFor: 'as yet unclassified' stamp: 'D S 11/9/2020 20:28:11'!
amountToTransfer

	^amountToTransfer.! !

!Transference methodsFor: 'as yet unclassified' stamp: 'D S 11/9/2020 21:17:35'!
depositEnd

	^depositEnd .! !

!Transference methodsFor: 'as yet unclassified' stamp: 'D S 11/9/2020 20:56:53'!
depositTo

	^depositEnd depositTo.
! !

!Transference methodsFor: 'as yet unclassified' stamp: 'D S 11/9/2020 20:56:44'!
extractFrom

	^withdrawEnd extractFrom.
! !

!Transference methodsFor: 'as yet unclassified' stamp: 'D S 11/9/2020 22:33:40'!
extractFrom: anAccountToExtract andDepositFrom: anAccountToDeposit anAmountOf: anAmount

	(anAmount = 0) ifTrue:[self error: self class errorMessageCannotBeZero ].
	(anAmount < 0) ifTrue:[self error: self class errorMessageCannotBeNegative].
	(anAccountToExtract = anAccountToDeposit) ifTrue:[self error: self class errorMessageCannotTransferToSelf ].
	withdrawEnd := WithdrawEnd new withdrawFrom: anAccountToExtract fromTransaction: self. 
	depositEnd := DepositEnd new depositInto: anAccountToDeposit fromTransaction: self.
	amountToTransfer := anAmount.
	
	anAccountToExtract register: withdrawEnd.
	anAccountToDeposit register: depositEnd.! !

!Transference methodsFor: 'as yet unclassified' stamp: 'D S 11/9/2020 21:09:50'!
value

	^amountToTransfer.! !

!Transference methodsFor: 'as yet unclassified' stamp: 'D S 11/9/2020 21:17:01'!
withdrawEnd

	^withdrawEnd .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: 'Portfolio2-Ejercicio'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'as yet unclassified' stamp: 'D S 11/9/2020 22:27:57'!
errorMessageCannotBeNegative

	^'The amount cannot be negative!!'! !

!Transference class methodsFor: 'as yet unclassified' stamp: 'D S 11/9/2020 21:30:12'!
errorMessageCannotBeZero

	^'The amount cant be zero!!'! !

!Transference class methodsFor: 'as yet unclassified' stamp: 'D S 11/9/2020 22:32:28'!
errorMessageCannotTransferToSelf

	^'No se puede depositar dinero en la que se extrae'! !

!Transference class methodsFor: 'as yet unclassified' stamp: 'D S 11/9/2020 21:12:32'!
from: anAccountToExtract to: anAccountToDeposit amount: anAmount
	|transference|
	
	transference := self new extractFrom: anAccountToExtract andDepositFrom: anAccountToDeposit anAmountOf: anAmount.
	^transference.! !


!classDefinition: #DepositEnd category: 'Portfolio2-Ejercicio'!
Transference subclass: #DepositEnd
	instanceVariableNames: 'depositTo transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!DepositEnd methodsFor: 'as yet unclassified' stamp: 'D S 11/14/2020 16:17:42'!
addToReport: aSummary

	aSummary addDepositEnd: self.! !

!DepositEnd methodsFor: 'as yet unclassified' stamp: 'D S 11/9/2020 22:25:57'!
affectBalance: aBalance

	^aBalance + transference value! !

!DepositEnd methodsFor: 'as yet unclassified' stamp: 'D S 11/9/2020 21:08:18'!
depositInto: anAccount fromTransaction: anTransaction

	depositTo:= anAccount.
	transference := anTransaction! !

!DepositEnd methodsFor: 'as yet unclassified' stamp: 'D S 11/9/2020 20:58:23'!
depositTo

	^depositTo.! !

!DepositEnd methodsFor: 'as yet unclassified' stamp: 'D S 11/10/2020 19:01:45'!
value

	^transference value! !

!DepositEnd methodsFor: 'as yet unclassified' stamp: 'D S 11/9/2020 21:20:10'!
withdrawEnd

	^transference withdrawEnd.! !


!classDefinition: #WithdrawEnd category: 'Portfolio2-Ejercicio'!
Transference subclass: #WithdrawEnd
	instanceVariableNames: 'extractFrom transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!WithdrawEnd methodsFor: 'as yet unclassified' stamp: 'D S 11/14/2020 16:17:19'!
addToReport: aSummary

	aSummary addWithdrawEnd: self.! !

!WithdrawEnd methodsFor: 'as yet unclassified' stamp: 'D S 11/9/2020 22:25:49'!
affectBalance: aBalance

	^aBalance - transference value! !

!WithdrawEnd methodsFor: 'as yet unclassified' stamp: 'D S 11/9/2020 21:19:20'!
depositEnd

	^transference depositEnd.! !

!WithdrawEnd methodsFor: 'as yet unclassified' stamp: 'D S 11/9/2020 20:58:11'!
extractFrom

	^extractFrom! !

!WithdrawEnd methodsFor: 'as yet unclassified' stamp: 'D S 11/10/2020 19:01:14'!
value

	^transference value! !

!WithdrawEnd methodsFor: 'as yet unclassified' stamp: 'D S 11/9/2020 21:08:35'!
withdrawFrom: anAccount fromTransaction:anTransaction

	extractFrom := anAccount.
	transference := anTransaction! !
