!classDefinition: #AccountSummaryTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountSummaryTest methodsFor: 'tests' stamp: 'lmalvarez 6/2/2021 20:57:08'!
test01NewAccountShouldHaveASummaryWithNoTransactionsAndABalanceOfCero

	| accountSummary |
	
	accountSummary := AccountSummary for: ReceptiveAccount new.
	
	self assert: accountSummary summary = (OrderedCollection with: ('Balance = 0')).! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'lmalvarez 6/2/2021 20:59:38'!
test02SummaryOfAnAccountWithOneDepositShouldIncludeThatDeposit

	| account expectedSummary deposit |
	
	account := ReceptiveAccount new.
	
	expectedSummary := OrderedCollection new.
	deposit := Deposit register: 100 on: account. 
	
	expectedSummary add: ('Depósito por ', deposit value asString).
	expectedSummary add: ('Balance = 100').
	
	self assert: (AccountSummary for: account) summary = expectedSummary.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'lmalvarez 6/2/2021 21:00:10'!
test03SummaryOfAnAccountWithMultipleDepositsShouldIncludeEachDeposit

	| account expectedSummary |
	
	account := ReceptiveAccount new.
	
	expectedSummary := OrderedCollection new.
	Deposit register: 100 on: account. 
	Deposit register: 500 on: account. 
	Deposit register: 1000 on: account. 
	
	expectedSummary add: ('Depósito por 100').
	expectedSummary add: ('Depósito por 500').
	expectedSummary add: ('Depósito por 1000').
	expectedSummary add: ('Balance = 1600').
	
	self assert: (AccountSummary for: account) summary = expectedSummary.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'lmalvarez 6/2/2021 21:00:41'!
test04SummaryOfAnAccountWithOneWithdrawShouldIncludeThatWithdraw

	| account expectedSummary |
	
	account := ReceptiveAccount new.
	
	expectedSummary := OrderedCollection new.
	Withdraw register: 100 on: account. 
	
	expectedSummary add: ('Extracción por 100').
	expectedSummary add: ('Balance = -100').
	
	self assert: (AccountSummary for: account) summary = expectedSummary.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'lmalvarez 6/2/2021 21:01:36'!
test05SummaryOfTwoAccountsThatMadeATransferenceShouldEachIncludeThatTransference

	| accountA accountB expectedSummaryA expectedSummaryB |
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.
	
	expectedSummaryA := OrderedCollection new.
	expectedSummaryB := OrderedCollection new.
	Transference from: accountA to: accountB  anAmountOf: 100.
	
	expectedSummaryA add: ('Salida por transferencia de 100').
	expectedSummaryA add: ('Balance = -100').
	expectedSummaryB add: ('Entrada por transferencia de 100').
	expectedSummaryB add: ('Balance = 100').
	
	self assert: (AccountSummary for: accountA ) summary = expectedSummaryA.
	self assert: (AccountSummary for: accountB ) summary = expectedSummaryB.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'lmalvarez 6/3/2021 00:12:06'!
test06SummaryOfAPortfolioShouldIncludeEachOfItsAccountsTransaction

	| accountA accountB portfolio expectedSummary |
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.
	portfolio := Portfolio new.
	portfolio add: accountA.
	portfolio add: accountB.
	
	expectedSummary := OrderedCollection new.
	Deposit register: 1000 on: accountA.
	Deposit register: 100 on: accountA.
	Deposit register: 1000 on: accountB.
	Deposit register: 100 on: accountB.
	
	Withdraw register: 500 on: accountA.
	Withdraw register: 500 on: accountB.
	
	expectedSummary add: ('Depósito por 1000').
	expectedSummary add: ('Depósito por 100').
	expectedSummary add: ('Extracción por 500').
	expectedSummary add: ('Depósito por 1000').
	expectedSummary add: ('Depósito por 100').
	expectedSummary add: ('Extracción por 500').
	expectedSummary add: ('Balance = 1200').
	
	self assert: (AccountSummary for: portfolio ) summary = expectedSummary.! !


!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

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


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

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


!classDefinition: #TransferNetTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferNetTest methodsFor: 'tests' stamp: 'lmalvarez 6/2/2021 21:03:27'!
test01NetReportOfANewAccountShouldReturnCero

	| transferNet |
	
	transferNet := TransferNet for: ReceptiveAccount new.
	
	self assert: transferNet summary = 0.! !

!TransferNetTest methodsFor: 'tests' stamp: 'lmalvarez 6/2/2021 21:04:28'!
test02NetReportOfEachAccountInATransferenceShouldReturnTheSameValueNegated

	| transferNetA transferNetB accountA accountB |
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.
	
	transferNetA := TransferNet for: accountA.
	transferNetB := TransferNet for: accountB.
	
	Transference from: accountA to: accountB anAmountOf: 100.
	
	self assert: transferNetA summary = -100.
	self assert: transferNetB summary = 100.! !

!TransferNetTest methodsFor: 'tests' stamp: 'lmalvarez 6/2/2021 21:05:46'!
test03NetReportOfEachAccountInATransferenceShouldNotCountNormalTransactions

	| transferNetA transferNetB accountA accountB |
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.
	
	transferNetA := TransferNet for: accountA.
	transferNetB := TransferNet for: accountB.
	
	Deposit register: 500 on: accountA.
	Withdraw register: 600 on: accountB.
	
	Transference from: accountA to: accountB anAmountOf: 100.
	
	self assert: transferNetA summary = -100.
	self assert: transferNetB summary = 100.! !

!TransferNetTest methodsFor: 'tests' stamp: 'lmalvarez 6/3/2021 00:13:52'!
test04NetReportOfAPortfolioShouldReturnTheTotalSumOfEachAccountNetValue

	| transferNet portfolio accountA accountB accountC |
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.
	accountC := ReceptiveAccount new.
	portfolio := Portfolio new.
	portfolio add: accountA.
	portfolio add: accountB.
	
	transferNet := TransferNet for: portfolio.
	
	Transference from: accountC to: accountA anAmountOf: 900.
	Transference from: accountB to: accountC anAmountOf: 500.
	
	self assert: transferNet summary = 400.! !


!classDefinition: #TransferenceTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #TransferenceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferenceTest methodsFor: 'tests' stamp: 'lmalvarez 5/27/2021 21:17:12'!
emptyReceptiveAccount

	^ ReceptiveAccount new.! !

!TransferenceTest methodsFor: 'tests' stamp: 'lmalvarez 5/29/2021 20:20:07'!
test01TransferenceBetweenTwoAccountsRetailsTheAmountSpecified
	
	| transference |
	
	transference := Transference from: self emptyReceptiveAccount
							 to: self emptyReceptiveAccount
							 anAmountOf: 100.
	
	self assert: transference value equals: 100.! !

!TransferenceTest methodsFor: 'tests' stamp: 'lmalvarez 5/29/2021 20:22:34'!
test02TransferenceBetweenTwoAccountsRetailsAnyAmount
	
	| transference |
	
	transference := Transference from: self emptyReceptiveAccount
							 to: self emptyReceptiveAccount
							 anAmountOf: 500.
	
	self assert: transference value equals: 500.! !

!TransferenceTest methodsFor: 'tests' stamp: 'lmalvarez 5/29/2021 20:24:57'!
test03TransferenceAppearsInBothAccountsTransactionsAndAffectsTheirBalanceAsItShould
	
	| transference accountA accountB |
	
	accountA := self emptyReceptiveAccount.
	accountB := self emptyReceptiveAccount.
	
	transference := Transference from: accountA to: accountB anAmountOf: 100.
	
	self assert: accountA transactions includes: transference withdraw.
	self assert: accountB transactions includes: transference deposit.
	
	self assert: accountA balance equals: -100.
	self assert: accountB balance equals: 100.! !

!TransferenceTest methodsFor: 'tests' stamp: 'lmalvarez 5/29/2021 20:26:13'!
test04TransferenceTransactionsCanBeAccessedBetweenEachOther
	
	| transference |
	
	transference := Transference from: self emptyReceptiveAccount
							 to: self emptyReceptiveAccount
							 anAmountOf: 100.
	
	self assert: transference deposit equals: (transference withdraw sibling).
	self assert: transference withdraw equals: (transference deposit sibling).! !


!classDefinition: #Account category: 'Portfolio-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

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


!Account methodsFor: 'reports' stamp: 'lmalvarez 6/2/2021 22:40:58'!
answerReport: aReport

	| reportsCollection |
	
	reportsCollection := OrderedCollection new.
	
	self transactions do: [:aTransaction | reportsCollection add: (aTransaction answerReport: aReport) ].
	
	^reportsCollection! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
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


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

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


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'reports' stamp: 'lmalvarez 5/31/2021 21:41:06'!
answerReport: aReport 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
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


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'reports' stamp: 'lmalvarez 5/31/2021 21:48:14'!
answerReport: aReport

	^ aReport reportADeposit: self value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferenceDeposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #TransferenceDeposit
	instanceVariableNames: 'value transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferenceDeposit methodsFor: 'initialization' stamp: 'lmalvarez 5/27/2021 21:24:03'!
initializeFor: aTransference

	transference := aTransference.! !


!TransferenceDeposit methodsFor: 'balance' stamp: 'lmalvarez 5/29/2021 20:14:28'!
affectBalance: aBalance

	^aBalance + transference value! !

!TransferenceDeposit methodsFor: 'balance' stamp: 'lmalvarez 5/31/2021 15:27:47'!
value
	
	^ transference value! !


!TransferenceDeposit methodsFor: 'sibling' stamp: 'lmalvarez 5/27/2021 21:25:09'!
sibling

	^ transference withdraw! !


!TransferenceDeposit methodsFor: 'reports' stamp: 'lmalvarez 5/31/2021 21:48:19'!
answerReport: aReport

	^ aReport reportATransferenceDeposit: self value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceDeposit class' category: 'Portfolio-Ejercicio'!
TransferenceDeposit class
	instanceVariableNames: ''!

!TransferenceDeposit class methodsFor: 'instance creation' stamp: 'lmalvarez 5/27/2021 21:30:26'!
for: aTransference

	^ self new initializeFor: aTransference ! !


!classDefinition: #TransferenceWithdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #TransferenceWithdraw
	instanceVariableNames: 'value transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferenceWithdraw methodsFor: 'initialization' stamp: 'lmalvarez 5/27/2021 21:24:39'!
initializeFor: aTransference

	transference := aTransference.! !


!TransferenceWithdraw methodsFor: 'balance' stamp: 'lmalvarez 5/29/2021 20:14:42'!
affectBalance: aBalance

	^aBalance - transference value! !

!TransferenceWithdraw methodsFor: 'balance' stamp: 'lmalvarez 5/31/2021 15:28:09'!
value

	^ transference value! !


!TransferenceWithdraw methodsFor: 'sibling' stamp: 'lmalvarez 5/27/2021 21:25:19'!
sibling

	^ transference deposit! !


!TransferenceWithdraw methodsFor: 'reports' stamp: 'lmalvarez 5/31/2021 21:48:24'!
answerReport: aReport

	^ aReport reportATransferenceWithdraw: self value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceWithdraw class' category: 'Portfolio-Ejercicio'!
TransferenceWithdraw class
	instanceVariableNames: ''!

!TransferenceWithdraw class methodsFor: 'instance creation' stamp: 'lmalvarez 5/27/2021 21:30:30'!
for: aTransference

	^ self new initializeFor: aTransference ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'reports' stamp: 'lmalvarez 5/31/2021 21:48:28'!
answerReport: aReport

	^ aReport reportAWithdraw: self value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: 'Portfolio-Ejercicio'!
Object subclass: #Report
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Report methodsFor: 'reports' stamp: 'lmalvarez 5/31/2021 21:56:59'!
reportADeposit: aDepositValue

	self subclassResponsibility ! !

!Report methodsFor: 'reports' stamp: 'lmalvarez 5/31/2021 21:57:12'!
reportATransferenceDeposit: aTransferenceDepositValue

	self subclassResponsibility ! !

!Report methodsFor: 'reports' stamp: 'lmalvarez 5/31/2021 21:57:20'!
reportATransferenceWithdraw: aTransferenceWithdrawValue

	self subclassResponsibility ! !

!Report methodsFor: 'reports' stamp: 'lmalvarez 5/31/2021 21:57:30'!
reportAWithdraw: aWithdrawValue

	self subclassResponsibility ! !


!Report methodsFor: 'initialization' stamp: 'lmalvarez 5/31/2021 21:58:44'!
initializeFor: anAccount

	account := anAccount.! !


!classDefinition: #AccountSummary category: 'Portfolio-Ejercicio'!
Report subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountSummary methodsFor: 'reports' stamp: 'lmalvarez 5/31/2021 21:49:56'!
reportADeposit: aDepositValue

	^ 'Depósito por ' , aDepositValue asString.! !

!AccountSummary methodsFor: 'reports' stamp: 'lmalvarez 5/31/2021 21:51:03'!
reportATransferenceDeposit: aTransferenceDepositValue

	^ 'Entrada por transferencia de ' , aTransferenceDepositValue asString.! !

!AccountSummary methodsFor: 'reports' stamp: 'lmalvarez 5/31/2021 21:51:51'!
reportATransferenceWithdraw: aTransferenceWithdrawValue

	^ 'Salida por transferencia de ' , aTransferenceWithdrawValue asString.! !

!AccountSummary methodsFor: 'reports' stamp: 'lmalvarez 5/31/2021 21:50:23'!
reportAWithdraw: aWithdrawValue

	^ 'Extracción por ' , aWithdrawValue asString.! !

!AccountSummary methodsFor: 'reports' stamp: 'lmalvarez 6/2/2021 22:35:33'!
summary

	| accountSummary |
	
	accountSummary := account answerReport: self.
	
	accountSummary add: ('Balance = ', account balance asString).
	
	^ accountSummary! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio-Ejercicio'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'as yet unclassified' stamp: 'lmalvarez 5/31/2021 15:48:10'!
for: anAccount

	^ self new initializeFor: anAccount.! !


!classDefinition: #TransferNet category: 'Portfolio-Ejercicio'!
Report subclass: #TransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferNet methodsFor: 'reports' stamp: 'lmalvarez 6/1/2021 15:42:49'!
reportADeposit: aDepositValue

	^ 0! !

!TransferNet methodsFor: 'reports' stamp: 'lmalvarez 6/1/2021 15:41:40'!
reportATransferenceDeposit: aTransferenceDepositValue

	^ aTransferenceDepositValue ! !

!TransferNet methodsFor: 'reports' stamp: 'lmalvarez 6/1/2021 15:41:59'!
reportATransferenceWithdraw: aTransferenceWithdrawValue

	^ aTransferenceWithdrawValue negated! !

!TransferNet methodsFor: 'reports' stamp: 'lmalvarez 6/1/2021 15:42:58'!
reportAWithdraw: aWithdrawValue

	^0
! !

!TransferNet methodsFor: 'reports' stamp: 'lmalvarez 6/2/2021 22:35:42'!
summary
	
	| netValue |
	
	netValue := (account answerReport: self) inject: 0 into: [:anAdder :anAmount | anAdder + anAmount].
	
	^netValue
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'Portfolio-Ejercicio'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'as yet unclassified' stamp: 'lmalvarez 5/31/2021 16:10:28'!
for: anAccount
	^ self new initializeFor: anAccount! !


!classDefinition: #Transference category: 'Portfolio-Ejercicio'!
Object subclass: #Transference
	instanceVariableNames: 'value deposit withdraw'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Transference methodsFor: 'accessing' stamp: 'lmalvarez 5/27/2021 21:15:09'!
deposit

	^deposit! !

!Transference methodsFor: 'accessing' stamp: 'lmalvarez 5/27/2021 21:01:25'!
value

	^ value! !

!Transference methodsFor: 'accessing' stamp: 'lmalvarez 5/27/2021 21:15:19'!
withdraw

	^withdraw ! !


!Transference methodsFor: 'initialization' stamp: 'lmalvarez 5/27/2021 21:29:56'!
initializeFrom: aSenderAccount to: aReceiverAccount anAmountOf: anAmount

	withdraw := TransferenceWithdraw register: self on: aSenderAccount.
	deposit := TransferenceDeposit register: self on: aReceiverAccount.
	value := anAmount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: 'Portfolio-Ejercicio'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'initialize' stamp: 'lmalvarez 5/27/2021 21:14:40'!
from: aSenderAccount to: aReceiverAccount anAmountOf: anAmount

	^ self new initializeFrom: aSenderAccount to: aReceiverAccount anAmountOf: anAmount.
	! !
