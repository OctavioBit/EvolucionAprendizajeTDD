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


!classDefinition: #ReportsTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportsTest methodsFor: 'as yet unclassified' stamp: 'JR 6/3/2021 11:24:03'!
test01SummaryOfEmptyAccountShouldBeBalanceEqualsZero

	|anEmptyAccount expectedSummary|
	
	anEmptyAccount := ReceptiveAccount new. 
	expectedSummary := OrderedCollection new.
	
	expectedSummary add: 'Balance = 0'.
	
	self assert: expectedSummary equals: anEmptyAccount accountSummary.! !

!ReportsTest methodsFor: 'as yet unclassified' stamp: 'JR 6/3/2021 11:29:39'!
test02SummaryShouldReflectDepositOnAccount

	|anAccount expectedSummary|
	
	anAccount := ReceptiveAccount new. 
	expectedSummary := OrderedCollection new.
	
	Deposit register: 100 on: anAccount.
	
	expectedSummary add: 'Deposito por 100'.
	expectedSummary add: 'Balance = 100'.
	
	self assert: expectedSummary equals: anAccount accountSummary.! !

!ReportsTest methodsFor: 'as yet unclassified' stamp: 'JR 6/3/2021 11:34:43'!
test03SummaryShouldReflectWithdrawOnAccount

	|anAccount expectedSummary|
	
	anAccount := ReceptiveAccount new. 
	expectedSummary := OrderedCollection new.
	
	Withdraw register: 50 on: anAccount.
	
	expectedSummary add: 'Extraccion por 50'.
	expectedSummary add: 'Balance = -50'.
	
	self assert: expectedSummary equals: anAccount accountSummary.! !

!ReportsTest methodsFor: 'as yet unclassified' stamp: 'JR 6/3/2021 11:39:13'!
test04SummaryShouldReflectTransferFromAccount

	|originAccount destinyAccount expectedSummary|
	
	originAccount := ReceptiveAccount new. 
	destinyAccount := ReceptiveAccount new.
	expectedSummary := OrderedCollection new.
	
	Transfer register: 20 from: originAccount to: destinyAccount.
	
	expectedSummary add: 'Salida por transferencia de 20'.
	expectedSummary add: 'Balance = -20'.
	
	self assert: expectedSummary equals: originAccount accountSummary.! !

!ReportsTest methodsFor: 'as yet unclassified' stamp: 'JR 6/3/2021 11:43:16'!
test05SummaryShouldReflectTransferToAccount

	|originAccount destinyAccount expectedSummary|
	
	originAccount := ReceptiveAccount new. 
	destinyAccount := ReceptiveAccount new.
	expectedSummary := OrderedCollection new.
	
	Transfer register: 30 from: originAccount to: destinyAccount.
	
	expectedSummary add: 'Entrada por transferencia de 30'.
	expectedSummary add: 'Balance = 30'.
	
	self assert: expectedSummary equals: destinyAccount accountSummary.! !

!ReportsTest methodsFor: 'as yet unclassified' stamp: 'JR 6/3/2021 11:45:56'!
test06SummaryShouldReflectMultipleDepositsOnAccount

	|anAccount expectedSummary|
	
	anAccount := ReceptiveAccount new. 
	expectedSummary := OrderedCollection new.
	
	Deposit register: 100 on: anAccount.
	Deposit register: 100 on: anAccount.
	
	expectedSummary add: 'Deposito por 100'.
	expectedSummary add: 'Deposito por 100'.
	expectedSummary add: 'Balance = 200'.
	
	self assert: expectedSummary equals: anAccount accountSummary.! !

!ReportsTest methodsFor: 'as yet unclassified' stamp: 'JR 6/3/2021 12:11:44'!
test07TransferNetOfEmptyAccountShouldBeZero

	|anEmptyAccount|
	
	anEmptyAccount := ReceptiveAccount new. 
	
	self assert: 0 equals: anEmptyAccount accountTransferNet.! !

!ReportsTest methodsFor: 'as yet unclassified' stamp: 'JR 6/3/2021 12:14:21'!
test08TransferNetShouldReflectTransferFromAccount

	|originAccount destinyAccount|
	
	originAccount := ReceptiveAccount new. 
	destinyAccount := ReceptiveAccount new.
	
	Transfer register: 20 from: originAccount to: destinyAccount.
	
	self assert: -20 equals: originAccount accountTransferNet.! !

!ReportsTest methodsFor: 'as yet unclassified' stamp: 'JR 6/3/2021 12:15:42'!
test09TransferNetShouldReflectTransferToAccount

	|originAccount destinyAccount|
	
	originAccount := ReceptiveAccount new. 
	destinyAccount := ReceptiveAccount new.
	
	Transfer register: 20 from: originAccount to: destinyAccount.
	
	self assert: 20 equals: destinyAccount accountTransferNet.! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'JR 6/3/2021 13:28:04'!
test01TransferShouldAffectBalanceOfBothAccounts

	|originAccount destinyAccount|
	
	originAccount := ReceptiveAccount new.
	destinyAccount := ReceptiveAccount new.
	
	Transfer register: 200 from: originAccount to: destinyAccount.
	
	self assert: 200 equals: destinyAccount balance.
	self assert: -200 equals: originAccount balance.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'JR 6/3/2021 13:29:41'!
test02AnAccountShouldKnowItsTransfersAndTheirKind

	|originAccount destinyAccount|
	
	originAccount := ReceptiveAccount new.
	destinyAccount := ReceptiveAccount new.
	
	Transfer register: 200 from: originAccount to: destinyAccount.
	
	self assert: (destinyAccount transactions anySatisfy: [:transaction | transaction isKindOf: TransferDeposit]).
	self assert: (originAccount transactions anySatisfy: [:transaction | transaction isKindOf: TransferWithdraw]).! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'JR 6/3/2021 13:30:35'!
test03TransferDepositsAndWithdrawsShouldKnowTheirTransfer

	|originAccount destinyAccount transfer|
	
	originAccount := ReceptiveAccount new.
	destinyAccount := ReceptiveAccount new.
	
	transfer := Transfer register: 200 from: originAccount to: destinyAccount.
	
	self assert: (destinyAccount transactions anySatisfy: [:transaction | (transaction isKindOf: TransferDeposit) and: 		[transaction myTransfer = transfer]]).
	self assert: (originAccount transactions anySatisfy: [:transaction | (transaction isKindOf: TransferWithdraw) and: 		[transaction myTransfer = transfer]]).! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'JR 6/3/2021 13:31:27'!
test04TransfersShouldKnowBothItsLegs

	|originAccount destinyAccount transfer|
	
	originAccount := ReceptiveAccount new.
	destinyAccount := ReceptiveAccount new.
	
	transfer := Transfer register: 200 from: originAccount to: destinyAccount.
	
	self assert: (destinyAccount transactions anySatisfy: [:transaction | (transaction isKindOf: TransferDeposit) and: 		[transaction = transfer deposit]]).
	self assert: (originAccount transactions anySatisfy: [:transaction | (transaction isKindOf: TransferWithdraw) and: 		[transaction = transfer withdraw]]).! !


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
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

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


!ReceptiveAccount methodsFor: 'reports' stamp: 'JR 6/3/2021 12:43:49'!
accountSummary
	
	^(AccountSummary for: self with: transactions) accountSummary! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'JR 6/3/2021 13:06:48'!
accountTransferNet
	^(TransferNet with: transactions) accountTransferNet! !


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


!AccountTransaction methodsFor: 'reports' stamp: 'JR 6/3/2021 12:22:29'!
affectTransferNet: aTransferNet

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'reports' stamp: 'JR 6/3/2021 12:05:50'!
includeInAccountSummary: aSummary

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'reports' stamp: 'JR 6/3/2021 13:21:20'!
includeInReport: aReport

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'JR 5/30/2021 23:58:46'!
register: aValueOrTransfer on: account

	| transaction |
	
	transaction := self for: aValueOrTransfer.
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


!Deposit methodsFor: 'reports' stamp: 'JR 6/3/2021 13:22:08'!
includeInReport: aReport

	^aReport includeDeposit: self! !

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

!TransferLeg methodsFor: 'initialization' stamp: 'JR 5/30/2021 23:56:17'!
initializeFor: aTransfer 

	transfer := aTransfer ! !


!TransferLeg methodsFor: 'accessing' stamp: 'JR 5/30/2021 23:40:24'!
myTransfer

	^transfer! !

!TransferLeg methodsFor: 'accessing' stamp: 'JR 6/3/2021 11:56:49'!
value
	
	^self myTransfer value! !


!TransferLeg methodsFor: 'balance' stamp: 'JR 5/30/2021 23:40:50'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'Portfolio-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'JR 5/30/2021 23:59:26'!
for: aTransfer

	^self new initializeFor: aTransfer.
	! !


!classDefinition: #TransferDeposit category: 'Portfolio-Solucion'!
TransferLeg subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDeposit methodsFor: 'balance' stamp: 'JR 5/30/2021 23:56:52'!
affectBalance: aBalance

	^aBalance + transfer value ! !


!TransferDeposit methodsFor: 'reports' stamp: 'JR 6/3/2021 13:22:02'!
includeInReport: aReport

	^aReport includeTransferDeposit: self
	
	! !


!classDefinition: #TransferWithdraw category: 'Portfolio-Solucion'!
TransferLeg subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferWithdraw methodsFor: 'balance' stamp: 'JR 5/30/2021 23:56:47'!
affectBalance: aBalance

	^aBalance - transfer value ! !


!TransferWithdraw methodsFor: 'reports' stamp: 'JR 6/3/2021 13:21:20'!
includeInReport: aReport

	^aReport includeTransferWithdraw: self ! !


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


!Withdraw methodsFor: 'reports' stamp: 'JR 6/3/2021 13:22:31'!
includeInReport: aReport

	^aReport includeWithdraw: self! !


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


!classDefinition: #Reports category: 'Portfolio-Solucion'!
Object subclass: #Reports
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Reports methodsFor: 'evaluating' stamp: 'JR 6/3/2021 13:18:12'!
includeDeposit: aDeposit

	self subclassResponsibility ! !

!Reports methodsFor: 'evaluating' stamp: 'JR 6/3/2021 13:18:25'!
includeTransferDeposit: aTransferDeposit

	self subclassResponsibility ! !

!Reports methodsFor: 'evaluating' stamp: 'JR 6/3/2021 13:17:57'!
includeTransferWithdraw: aTransferWithdraw

	self subclassResponsibility ! !

!Reports methodsFor: 'evaluating' stamp: 'JR 6/3/2021 13:18:04'!
includeWithdraw: aWithdraw

	self subclassResponsibility ! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
Reports subclass: #AccountSummary
	instanceVariableNames: 'accountTransactions account mySummary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'initialization' stamp: 'JR 6/3/2021 12:55:23'!
initializeFor: anAccount with: transactions

	accountTransactions := transactions.
	account := anAccount.
	mySummary := OrderedCollection new.
	! !


!AccountSummary methodsFor: 'evaluating' stamp: 'JR 6/3/2021 13:22:54'!
accountSummary
	
	
	accountTransactions do: [:transaction | transaction includeInReport: self].
	mySummary add: 'Balance = ' , account balance asString.
	
	^mySummary! !

!AccountSummary methodsFor: 'evaluating' stamp: 'JR 6/3/2021 12:56:21'!
includeDeposit: aDeposit

	mySummary add: 'Deposito por ' , aDeposit value asString.
	^mySummary! !

!AccountSummary methodsFor: 'evaluating' stamp: 'JR 6/3/2021 12:58:33'!
includeTransferDeposit: aTransferDeposit

	mySummary add: 'Entrada por transferencia de ' , aTransferDeposit value asString.
	^mySummary! !

!AccountSummary methodsFor: 'evaluating' stamp: 'JR 6/3/2021 12:58:56'!
includeTransferWithdraw: aTransferWithdraw

	mySummary add: 'Salida por transferencia de ' , aTransferWithdraw value asString.
	^mySummary! !

!AccountSummary methodsFor: 'evaluating' stamp: 'JR 6/3/2021 12:56:55'!
includeWithdraw: aWithdraw

	mySummary add: 'Extraccion por ' , aWithdraw value asString.
	^mySummary! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'JR 6/3/2021 12:45:13'!
for: anAccount with: transactions

	^self new initializeFor: anAccount with: transactions! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
Reports subclass: #TransferNet
	instanceVariableNames: 'accountTransactions transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'initialization' stamp: 'JR 6/3/2021 13:09:15'!
initializeWith: aTransactions
	accountTransactions := aTransactions.
	transferNet := 0.! !


!TransferNet methodsFor: 'evaluating' stamp: 'JR 6/3/2021 13:23:06'!
accountTransferNet
	
	accountTransactions do: [ :transaction | transaction includeInReport: self ].
	
	^transferNet 
! !

!TransferNet methodsFor: 'evaluating' stamp: 'JR 6/3/2021 13:14:35'!
includeDeposit: aDeposit
	
	
! !

!TransferNet methodsFor: 'evaluating' stamp: 'JR 6/3/2021 13:12:27'!
includeTransferDeposit: aTransferDeposit

	transferNet := transferNet + aTransferDeposit value
	
! !

!TransferNet methodsFor: 'evaluating' stamp: 'JR 6/3/2021 13:12:14'!
includeTransferWithdraw: aTransferWithdraw

	transferNet := transferNet - aTransferWithdraw value
	
	
! !

!TransferNet methodsFor: 'evaluating' stamp: 'JR 6/3/2021 13:14:47'!
includeWithdraw: aWithdraw
	
	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'Portfolio-Solucion'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'instance creation' stamp: 'JR 6/3/2021 13:06:48'!
with: aTransactions
	^self new initializeWith: aTransactions! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'deposit withdraw value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'JR 5/30/2021 23:55:13'!
initializeFor: aValue origin: originAccount destiny: destinyAccount
	
	|aDeposit aWithdraw|
	
	aDeposit := TransferDeposit register: self on: destinyAccount.
	aWithdraw := TransferWithdraw register: self on: originAccount.
	
	value := aValue.
	deposit := aDeposit.
	withdraw := aWithdraw ! !


!Transfer methodsFor: 'accessing' stamp: 'JR 5/30/2021 23:44:05'!
deposit

	^deposit ! !

!Transfer methodsFor: 'accessing' stamp: 'JR 5/30/2021 23:57:06'!
value 

	^value! !

!Transfer methodsFor: 'accessing' stamp: 'JR 5/30/2021 23:44:17'!
withdraw

	^withdraw ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'JR 5/30/2021 23:52:12'!
register: aValue from: originAccount to: destinyAccount

	|transfer|
	
	transfer := self new initializeFor: aValue origin: originAccount destiny: destinyAccount.
	
	^transfer
	
	! !
