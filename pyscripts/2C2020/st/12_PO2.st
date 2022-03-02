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


!classDefinition: #ReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTest methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 16:22:45'!
test01SummaryOnAnEmptyAccount
|account1 report text |
account1:=ReceptiveAccount new.

report := AccountSummaryReport for:account1. 
text:= report generateReport.
self assert:(text allSatisfy: [:a | a='Balance = 0']).



 ! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 16:24:10'!
test02SummaryforDepositOnAccount
|account1 report text |
account1:=ReceptiveAccount new.

Deposit register: 100 on:account1 .

report := AccountSummaryReport for:account1. 
text:= report generateReport.
self assert: (text size=2).
self assert:(text anySatisfy: [:a | a='Balance = 100']).
self assert:(text anySatisfy: [:a | a='Depósito por 100'.]).



 ! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 16:25:00'!
test03SummaryforWithdrawOnAccount
|account1 report text |
account1:=ReceptiveAccount new.

Deposit register: 100 on:account1 .
Withdraw register: 100 on:account1.

report := AccountSummaryReport for:account1. 
text:= report generateReport.
self assert: (text size=3).
self assert:(text anySatisfy: [:a | a='Balance = 0']).
self assert:(text anySatisfy: [:a | a='Depósito por 100'.]).
self assert:(text anySatisfy: [:a | a='Extracción por 100'.]).


 ! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 16:25:41'!
test04SummaryfromTransferOnAccount
|account1 account2 report1 report2 text |
account1:=ReceptiveAccount new.
account2:=ReceptiveAccount new.

Transfer amount: 100 from:account1  to:account2 .

report1 := AccountSummaryReport for:account1. 
report2 := AccountSummaryReport for:account2. 
text:= report1 generateReport.
self assert: (text size=2).
self assert:(text anySatisfy: [:a | a='Balance = -100']).
self assert:(text anySatisfy: [:a | a='Salida por transferencia de 100'.]).
text:= report2 generateReport.
self assert: (text size=2).
self assert:(text anySatisfy: [:a | a='Balance = 100']).
self assert:(text anySatisfy: [:a | a='Entrada por transferencia de 100'.]).


 ! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 16:26:24'!
test05TransferNetOnEmptyAccount
|account1 report   |
account1:=ReceptiveAccount new.

report:=TransferNetReport for:account1. 

self assert:(report generateReport=0).



 ! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 16:27:15'!
test06TransferNetForDepositOrWithdrawOnAccount
|account1 report   |
account1:=ReceptiveAccount new.

Deposit register: 100 on:account1 .
Withdraw register: 100 on:account1.

report:=TransferNetReport for:account1. 

self assert:(report generateReport=0).



 ! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 16:28:09'!
test07TransferNetForTransferOnAccount
|account1 account2 report1  report2 |
account1:=ReceptiveAccount new.
account2:=ReceptiveAccount new.

Transfer amount:100 from:account1 to:account2.

report1:=TransferNetReport for:account1. 
report2:=TransferNetReport for:account2. 

self assert:(report1 generateReport=-100).
self assert:(report2 generateReport=100).


 ! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 16:34:55'!
test08TransferNetForTransferOnPortfolio
|account1 account2 report1  portfolio |
account1:=ReceptiveAccount new.
account2:=ReceptiveAccount new.
portfolio:=Portfolio new.
portfolio add:account1.
portfolio add:account2.

Transfer amount:100 from:account1 to:account2.

report1:=TransferNetReport for:portfolio. 

self assert:(report1 generateReport=0).



 ! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 16:41:51'!
test09SummaryfromTransferOnPortfolio
|account1 account2 report1  text portfolio |
account1:=ReceptiveAccount new.
account2:=ReceptiveAccount new.
portfolio:=Portfolio new.
portfolio add:account1.
portfolio add:account2.

Transfer amount: 100 from:account1  to:account2 .

report1 := AccountSummaryReport for:portfolio. 
text:= report1 generateReport.
self assert: (text size=3).
self assert:(text anySatisfy: [:a | a='Balance = 0']).
self assert:(text anySatisfy: [:a | a='Salida por transferencia de 100'.]).
self assert:(text anySatisfy: [:a | a='Entrada por transferencia de 100'.]).


 ! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'nt 11/14/2020 15:52:09'!
test01TransferAffectsBalance
	|account1 account2|
	account1:=ReceptiveAccount new.
	account2:=ReceptiveAccount new.
	
	Transfer amount: 100 from: account1 to:account2.
	self assert: account1 balance equals: -100.
	self assert: account2 balance equals: 100! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'nt 11/14/2020 15:52:58'!
test02TransferGetsRegisterToAccountTransactions
	|account1 account2 transfer|
	account1:=ReceptiveAccount new.
	account2:=ReceptiveAccount new.
		
	transfer:=Transfer amount: 100 from: account1 to:account2.
	
	self assert: (account1 hasRegistered:transfer debiterTransaction ).
	self assert: (account2 hasRegistered:transfer crediterTransaction )! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'nt 11/14/2020 15:36:08'!
test03TransferToTheSameAccount
	|account1  |
	account1:=ReceptiveAccount new.
	
	
	self should: [Transfer amount: 100 from: account1 to:account1]
	raise:Error
	withExceptionDo:[:anError |
			self assert: anError messageText = Transfer sameAccountErrorDescription]! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'nt 11/14/2020 15:46:48'!
test04TransferAmountEqualsZero
	|account1  account2|
	account1:=ReceptiveAccount new.
	account2:=ReceptiveAccount new.
	
	
	self should: [Transfer amount: 0 from: account1 to:account2]
	raise:Error
	withExceptionDo:[:anError |
			self assert: anError messageText = Transfer transferAmountErrorDescription]! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'nt 11/14/2020 15:50:27'!
test05TransferNegtiveAmount
	|account1  account2|
	account1:=ReceptiveAccount new.
	account2:=ReceptiveAccount new.
	
	
	self should: [Transfer amount: -100 from: account1 to:account2]
	raise:Error
	withExceptionDo:[:anError |
			self assert: anError messageText = Transfer transferAmountErrorDescription]! !


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


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'as yet unclassified' stamp: 'nt 11/14/2020 16:39:00'!
generateReport:aReport
	self subclassResponsibility.! !


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


!Portfolio methodsFor: 'as yet unclassified' stamp: 'nt 11/14/2020 16:41:04'!
generateReport:aReport
	accounts do: [ :anAccount | anAccount generateReport: aReport ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
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


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


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


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'nt 11/14/2020 16:42:23'!
generateReport:aReport
transactions do: [ :aTransaction| aTransaction generateReport: aReport ].
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

!Deposit methodsFor: 'balance' stamp: 'nt 11/14/2020 16:49:41'!
generateReport:aReport
	aReport reportDeposit:self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLink category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferLink
	instanceVariableNames: 'transferLink'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferLink methodsFor: 'initialization' stamp: 'nt 11/9/2020 21:33:33'!
initializeFor: aParentTransfer

	transferLink := aParentTransfer ! !


!TransferLink methodsFor: 'value' stamp: 'nt 11/9/2020 21:34:57'!
value

	^ transferLink value.! !


!TransferLink methodsFor: 'as yet unclassified' stamp: 'nt 11/10/2020 16:36:20'!
affectBalance: aBalance

	self subclassResponsibility ! !


!TransferLink methodsFor: 'balance' stamp: 'nt 11/14/2020 16:47:59'!
generateReport:aReport
	! !


!classDefinition: #CreditTransferLink category: 'Portfolio-Solucion'!
TransferLink subclass: #CreditTransferLink
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!CreditTransferLink methodsFor: 'as yet unclassified' stamp: 'nt 11/11/2020 11:59:10'!
affectBalance: aBalance

	^aBalance + transferLink value ! !

!CreditTransferLink methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 15:34:37'!
generateReport:aReport
	aReport reportCreditTransfer:self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditTransferLink class' category: 'Portfolio-Solucion'!
CreditTransferLink class
	instanceVariableNames: 'value'!

!CreditTransferLink class methodsFor: 'as yet unclassified' stamp: 'nt 11/10/2020 07:00:55'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #DebitTransferLink category: 'Portfolio-Solucion'!
TransferLink subclass: #DebitTransferLink
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!DebitTransferLink methodsFor: 'as yet unclassified' stamp: 'nt 11/11/2020 11:59:19'!
affectBalance: aBalance

	^aBalance - transferLink value! !

!DebitTransferLink methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 15:35:26'!
generateReport:aReport
	aReport reportDebitTransfer: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DebitTransferLink class' category: 'Portfolio-Solucion'!
DebitTransferLink class
	instanceVariableNames: 'value'!

!DebitTransferLink class methodsFor: 'as yet unclassified' stamp: 'nt 11/10/2020 07:01:25'!
for: aValue

	^ self new initializeFor: aValue ! !


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

!Withdraw methodsFor: 'balance' stamp: 'nt 11/15/2020 15:33:43'!
generateReport:aReport
aReport reportWithdraw: self.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: 'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: 'account reportText'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 16:05:25'!
reportCreditTransfer:aCreditTransfer
	self subclassResponsibility.! !

!Report methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 16:05:42'!
reportDebitTransfer:aDebitTransfer
self subclassResponsibility 
	! !

!Report methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 16:05:59'!
reportDeposit:aDeposit
	self subclassResponsibility ! !

!Report methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 16:06:09'!
reportWithdraw:aWithDraw
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'Portfolio-Solucion'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 15:54:38'!
for:anAccount
	self subclassResponsibility ! !


!classDefinition: #AccountSummaryReport category: 'Portfolio-Solucion'!
Report subclass: #AccountSummaryReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 15:12:56'!
generateReport
reportText:= OrderedCollection new.
account generateReport:self.
reportText add:'Balance = ', account balance asString.
^reportText .! !

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 15:56:02'!
initializeWith:anAccount

account:=anAccount.


	! !

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 15:30:24'!
reportCreditTransfer:aCredit
	
	reportText add:'Entrada por transferencia de ', aCredit value asString.! !

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 15:29:57'!
reportDebitTransfer:aDebit
	
	reportText add:'Salida por transferencia de ', aDebit value asString.! !

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 15:23:16'!
reportDeposit:aDeposit
	
	reportText add:'Depósito por ', aDeposit value asString.! !

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 15:28:27'!
reportWithdraw:aWithdraw
	
	reportText add:'Extracción por ', aWithdraw value asString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummaryReport class' category: 'Portfolio-Solucion'!
AccountSummaryReport class
	instanceVariableNames: ''!

!AccountSummaryReport class methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 15:54:03'!
for:anAccount
^ self new initializeWith:anAccount 
! !


!classDefinition: #TransferNetReport category: 'Portfolio-Solucion'!
Report subclass: #TransferNetReport
	instanceVariableNames: 'transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 15:59:59'!
generateReport
transferNet:=0.
account generateReport:self.
^transferNet.
! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 15:57:06'!
initializeWith:anAccount

account:=anAccount.! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 16:20:35'!
reportCreditTransfer:aCreditTransfer
transferNet :=transferNet + aCreditTransfer value.! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 16:18:42'!
reportDebitTransfer:aDebitTransfer
transferNet :=transferNet -aDebitTransfer value.! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 16:08:59'!
reportDeposit:aDeposit! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 16:09:24'!
reportWithdraw:aWithdraw! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNetReport class' category: 'Portfolio-Solucion'!
TransferNetReport class
	instanceVariableNames: ''!

!TransferNetReport class methodsFor: 'as yet unclassified' stamp: 'nt 11/15/2020 15:55:24'!
for:anAccount
^ self new initializeWith:anAccount.! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value crediterLink debiterLink'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'nt 11/14/2020 15:19:58'!
initializeFor: aValue from:aDebiterLink to:aCrediterLink

	value := aValue.
	debiterLink :=aDebiterLink.
	crediterLink :=aCrediterLink! !


!Transfer methodsFor: 'testing' stamp: 'nt 11/14/2020 15:26:31'!
crediterTransaction
	^crediterLink ! !

!Transfer methodsFor: 'testing' stamp: 'nt 11/14/2020 15:26:10'!
debiterTransaction
	^debiterLink ! !


!Transfer methodsFor: 'value' stamp: 'nt 11/9/2020 21:37:53'!
value
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'nt 11/14/2020 15:51:05'!
amount: aValue from:aDebitAccount to: aCreditAccount

	| transaction |

	(aDebitAccount ==aCreditAccount ) ifTrue: [self error: self sameAccountErrorDescription ].	
	(aValue<=0) ifTrue: [self error: self transferAmountErrorDescription ].
	transaction := self new.
	transaction  initializeFor: aValue from:(DebitTransferLink register:transaction on: aDebitAccount)
	to:(CreditTransferLink register:transaction on: aCreditAccount).
		
	^ transaction! !


!Transfer class methodsFor: 'error' stamp: 'nt 11/14/2020 15:37:08'!
sameAccountErrorDescription
	'No se puede realizar una transferencia a la misma cuenta'! !

!Transfer class methodsFor: 'error' stamp: 'nt 11/14/2020 15:47:36'!
transferAmountErrorDescription
	'No se puede realizar una transferencia con monto igual a cero'! !
