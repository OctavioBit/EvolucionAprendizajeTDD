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


!classDefinition: #ReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTest methodsFor: 'tests' stamp: 'jn 6/2/2021 20:42:42'!
test01accountSummaryWithNoneTransactions

		| account |
		account := ReceptiveAccount new.
		
		self assert: account accountSummary equals: #('Balance = 0') asOrderedCollection .


	! !

!ReportTest methodsFor: 'tests' stamp: 'jn 6/2/2021 21:04:17'!
test02accountSummaryWithDeposits

		| account |
		account := ReceptiveAccount new.
		Deposit register: 50 on: account.
		Deposit register: 100 on: account.
		
		self assert: account accountSummary equals: #('Depósito por 50.' 'Depósito por 100.' 'Balance = 150') asOrderedCollection .


	! !

!ReportTest methodsFor: 'tests' stamp: 'jn 6/2/2021 21:04:24'!
test03accountSummaryWithDepositsAndWithdraws

		| account |
		account := ReceptiveAccount new.
		Deposit register: 50 on: account.
		Withdraw register: 25 on: account.
		
		self assert: account accountSummary equals: #('Depósito por 50.' 'Extracción por 25.' 'Balance = 25') asOrderedCollection .


	! !

!ReportTest methodsFor: 'tests' stamp: 'jn 6/2/2021 21:03:06'!
test04accountSummaryWithTransferWithdraw

		| account anotherAccount |
		account := ReceptiveAccount new.
		anotherAccount := ReceptiveAccount new.

		Deposit register: 50 on: account.
		Withdraw register: 25 on: account.
		Transfer from: account to: anotherAccount value: 5.
		
		self assert: account accountSummary equals: #('Depósito por 50.' 'Extracción por 25.' 'Salida por transferencia de 5.' 'Balance = 20') asOrderedCollection .


	! !

!ReportTest methodsFor: 'tests' stamp: 'jn 6/2/2021 21:08:42'!
test05accountSummaryWithTransferDeposit

		| account anotherAccount |
		account := ReceptiveAccount new.
		anotherAccount := ReceptiveAccount new.

		Deposit register: 50 on: account.
		Withdraw register: 25 on: account.
		Transfer from: account to: anotherAccount value: 5.
		Transfer from: anotherAccount to: account value: 10.

		self assert: account accountSummary equals: #('Depósito por 50.' 'Extracción por 25.' 'Salida por transferencia de 5.' 'Entrada por transferencia de 10.' 'Balance = 30') asOrderedCollection .


	! !

!ReportTest methodsFor: 'tests' stamp: 'jn 6/2/2021 21:49:00'!
test06transferNetWithNoneTransfers

		| account |
		account := ReceptiveAccount new.
		
		self assert: account transferNet equals: 0.


	! !

!ReportTest methodsFor: 'tests' stamp: 'jn 6/2/2021 22:11:18'!
test07transferNetWithMultipleTransferDeposit

		| account anotherAccount |
		account := ReceptiveAccount new.
		anotherAccount := ReceptiveAccount new.
		
		Transfer from: anotherAccount to: account value: 5.
		Transfer from: anotherAccount to: account value: 10.
		Transfer from: anotherAccount to: account value: 20.

		self assert: account transferNet equals: 35.



	! !

!ReportTest methodsFor: 'tests' stamp: 'jn 6/2/2021 22:18:05'!
test08transferNetWithMultipleTransactions

		| account anotherAccount |
		account := ReceptiveAccount new.
		anotherAccount := ReceptiveAccount new.
		
		Transfer from: anotherAccount to: account value: 5.
		Transfer from: account to: anotherAccount value: 10.
		Transfer from: anotherAccount to: account value: 20.

		self assert: account transferNet equals: 15.
		self assert: anotherAccount transferNet equals: -15.



	! !

!ReportTest methodsFor: 'tests' stamp: 'jn 6/2/2021 22:18:24'!
test09transferNetWithMultipleTransferDepositAndWithdraw

		| account anotherAccount |
		account := ReceptiveAccount new.
		anotherAccount := ReceptiveAccount new.
		
		Transfer from: anotherAccount to: account value: 5.
		Transfer from: account to: anotherAccount value: 10.
		Transfer from: anotherAccount to: account value: 20.
		Deposit register: 50 on: account.
		Withdraw register: 25 on: account.

		self assert: account transferNet equals: 15.
		self assert: anotherAccount transferNet equals: -15.



	! !

!ReportTest methodsFor: 'tests' stamp: 'jn 6/2/2021 23:19:09'!
test10AccountSummaryInEmptyPortfolio

		| portfolio |
	
		portfolio := Portfolio new.

		self assert: portfolio accountSummary equals: #('Balance = 0') asOrderedCollection .



	! !

!ReportTest methodsFor: 'tests' stamp: 'jn 6/2/2021 23:24:41'!
test11accountSummaryInNonEmptyPortfolio

		| account anotherAccount portfolio |
		account := ReceptiveAccount new.
		anotherAccount := ReceptiveAccount new.
		
		Transfer from: anotherAccount to: account value: 5.
		Transfer from: account to: anotherAccount value: 10.
		Transfer from: anotherAccount to: account value: 20.
		Deposit register: 50 on: account.
		Withdraw register: 25 on: account.
		
		portfolio := Portfolio with: account.

		self assert: portfolio accountSummary equals: #('Entrada por transferencia de 5.' 'Salida por transferencia de 10.' 'Entrada por transferencia de 20.' 'Depósito por 50.' 'Extracción por 25.' 'Balance = 40') asOrderedCollection .




	! !

!ReportTest methodsFor: 'tests' stamp: 'jn 6/2/2021 23:25:46'!
test12TransferNetInEmptyPortfolio

		| portfolio |
	
		portfolio := Portfolio new.

		self assert: portfolio transferNet equals: 0.



	! !

!ReportTest methodsFor: 'tests' stamp: 'jn 6/2/2021 23:26:27'!
test13transferNetInNonEmptyPortfolio

		| account anotherAccount portfolio |
		account := ReceptiveAccount new.
		anotherAccount := ReceptiveAccount new.
		
		Transfer from: anotherAccount to: account value: 5.
		Transfer from: account to: anotherAccount value: 10.
		Transfer from: anotherAccount to: account value: 20.
		Deposit register: 50 on: account.
		Withdraw register: 25 on: account.
		
		portfolio := Portfolio with: account.

		self assert: portfolio transferNet equals: 15 .




	! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'tests' stamp: 'jn 5/30/2021 20:05:35'!
test01transferAffectsBalanceFromAccounts

	| accountSender accountReciever |
	
	accountSender := ReceptiveAccount new.
	accountReciever := ReceptiveAccount new.
	
	Transfer from: accountSender to: accountReciever value: 50.

	self assert: (accountSender balance = -50 and: accountReciever balance = 50)

! !

!TransferTest methodsFor: 'tests' stamp: 'jn 5/30/2021 20:29:25'!
test02receptiveAccountKnowsRegisteredTransactionLeg

	| account anotherAccount transfer |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.

	transfer :=		Transfer from: account to: anotherAccount value: 100.

	self assert: (transfer isRegisteredAsFromIn: account andToIn: anotherAccount).

! !

!TransferTest methodsFor: 'tests' stamp: 'jn 5/30/2021 20:18:39'!
test03transferHasTwoNavegableLegs 

	| account anotherAccount transfer |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.

	transfer :=		Transfer from: account to: anotherAccount value: 100.

	self assert: (transfer legsBelongsTo: transfer).
! !

!TransferTest methodsFor: 'tests' stamp: 'jn 6/2/2021 20:30:00'!
test04transferNegativeValueMustFail

	| account anotherAccount |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.

	self 
		should: [ Transfer from: account to: anotherAccount value: 0 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer canNotTransferInvalidValue equals: anError messageText.
			 ].
		
	self 
		should: [ Transfer from: account to: anotherAccount value: -100 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer canNotTransferInvalidValue equals: anError messageText.
			 ]
		
		

! !

!TransferTest methodsFor: 'tests' stamp: 'jn 6/2/2021 20:30:58'!
test05transferToSameAccountMustFail

	| account |
	
	account := ReceptiveAccount new.

	self 
		should: [ Transfer from: account to: account value: 100 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer canNotTransferToSameAccount equals: anError messageText.
			 ].
	

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


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'report' stamp: 'jn 6/3/2021 10:40:24'!
accountSummary
	
	^(SummaryReporter for: self) evaluate! !

!Account methodsFor: 'report' stamp: 'jn 6/3/2021 16:27:53'!
doReport: aReporter

	self subclassResponsibility.! !

!Account methodsFor: 'report' stamp: 'jn 6/3/2021 10:42:46'!
transferNet

	^(TransferNetReporter for: self) evaluate! !


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


!Portfolio methodsFor: 'report' stamp: 'jn 6/3/2021 16:13:42'!
doReport: aReporter

	accounts do: [ :anAccount | anAccount doReport: aReporter ].! !

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


!ReceptiveAccount methodsFor: 'report' stamp: 'jn 6/3/2021 16:20:05'!
doReport: aReporter

	transactions do: [:aTransaction | aTransaction doReport: aReporter ].
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


!AccountTransaction methodsFor: 'report' stamp: 'jn 6/3/2021 16:28:54'!
doReport: aReporter

	self subclassResponsibility.! !


!AccountTransaction methodsFor: 'initialization' stamp: 'jn 6/3/2021 16:29:49'!
initializeFor: aValue

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


!Deposit methodsFor: 'report' stamp: 'jn 6/3/2021 16:21:21'!
doReport: aReporter

	aReporter doReportForDeposit: self value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
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


!Withdraw methodsFor: 'report' stamp: 'jn 6/3/2021 16:21:45'!
doReport: aReporter

	aReporter doReportForWithdraw: self value.! !

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

!Report methodsFor: 'report' stamp: 'jn 6/3/2021 16:32:07'!
doReportForDeposit: aDepositValue

	self subclassResponsibility.! !

!Report methodsFor: 'report' stamp: 'jn 6/3/2021 16:32:15'!
doReportForDepositLeg: aDepositLegValue

	self subclassResponsibility.! !

!Report methodsFor: 'report' stamp: 'jn 6/3/2021 16:32:32'!
doReportForWithdraw: aWithdrawValue

	self subclassResponsibility.! !

!Report methodsFor: 'report' stamp: 'jn 6/3/2021 16:32:27'!
doReportForWithdrawLeg: aWithdrawLegValue

	self subclassResponsibility.! !


!Report methodsFor: 'evaluating' stamp: 'jn 6/3/2021 16:31:19'!
evaluate
	
	self subclassResponsibility.! !


!Report methodsFor: 'initialization' stamp: 'jn 6/3/2021 16:31:37'!
initializeFor: anAccount
	
	self subclassResponsibility.! !


!classDefinition: #SummaryReporter category: 'Portfolio-Solucion'!
Report subclass: #SummaryReporter
	instanceVariableNames: 'account summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SummaryReporter methodsFor: 'initialization' stamp: 'jn 6/3/2021 00:35:19'!
initializeFor: anAccount
	account := anAccount.
	summary := OrderedCollection new.! !


!SummaryReporter methodsFor: 'report' stamp: 'jn 6/3/2021 16:32:48'!
doReportForDeposit: aDepositValue

	summary add: 'Depósito por ', aDepositValue asString, '.'.! !

!SummaryReporter methodsFor: 'report' stamp: 'jn 6/3/2021 16:32:57'!
doReportForDepositLeg: aDepositLegValue

	summary add: 'Entrada por transferencia de ', aDepositLegValue asString, '.'.! !

!SummaryReporter methodsFor: 'report' stamp: 'jn 6/3/2021 16:33:06'!
doReportForWithdraw: aWithdrawValue

	summary add: 'Extracción por ', aWithdrawValue asString, '.'.! !

!SummaryReporter methodsFor: 'report' stamp: 'jn 6/3/2021 16:33:14'!
doReportForWithdrawLeg: aWithdrawLegValue

	summary add: 'Salida por transferencia de ', aWithdrawLegValue asString, '.'.! !


!SummaryReporter methodsFor: 'evaluating' stamp: 'jn 6/3/2021 16:13:07'!
evaluate
	
	account doReport: self.
		
	summary add: 'Balance = ', (account balance asString).
	
	^ summary.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SummaryReporter class' category: 'Portfolio-Solucion'!
SummaryReporter class
	instanceVariableNames: ''!

!SummaryReporter class methodsFor: 'instance creation' stamp: 'jn 6/3/2021 00:36:06'!
for: anAccount
	^self new initializeFor: anAccount! !


!classDefinition: #TransferNetReporter category: 'Portfolio-Solucion'!
Report subclass: #TransferNetReporter
	instanceVariableNames: 'account transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetReporter methodsFor: 'report' stamp: 'jn 6/3/2021 16:33:42'!
doReportForDeposit: aDepositValue


	! !

!TransferNetReporter methodsFor: 'report' stamp: 'jn 6/3/2021 16:33:37'!
doReportForDepositLeg: aDepositLegValue

	transferNet := transferNet + aDepositLegValue.

	! !

!TransferNetReporter methodsFor: 'report' stamp: 'jn 6/3/2021 16:33:28'!
doReportForWithdraw: aWithdrawValue


	! !

!TransferNetReporter methodsFor: 'report' stamp: 'jn 6/3/2021 16:33:22'!
doReportForWithdrawLeg: aWithdrawLegValue

	transferNet := transferNet - aWithdrawLegValue.

	! !


!TransferNetReporter methodsFor: 'initialization' stamp: 'jn 6/3/2021 00:27:57'!
initializeFor: anAccount
	account := anAccount.
	transferNet := 0.! !


!TransferNetReporter methodsFor: 'evaluating' stamp: 'jn 6/3/2021 16:15:23'!
evaluate
	
	account doReport: self.
	^transferNet 
	
		
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNetReporter class' category: 'Portfolio-Solucion'!
TransferNetReporter class
	instanceVariableNames: ''!

!TransferNetReporter class methodsFor: 'instance creation' stamp: 'jn 6/3/2021 00:19:45'!
for: anAccount

	^self new initializeFor: anAccount! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'getters' stamp: 'jn 5/30/2021 20:13:21'!
value
	
	^ value ! !


!Transfer methodsFor: 'initialization' stamp: 'jn 6/2/2021 20:31:42'!
initializeFrom: anAccountSending to: anAccountRecieving value: aValue

	aValue <= 0 ifTrue: [ self error: Transfer canNotTransferInvalidValue ].
	anAccountSending == anAccountRecieving ifTrue: [ self error: Transfer canNotTransferToSameAccount ].

	withdrawLeg := WithdrawLeg for: self and: anAccountSending.
	depositLeg := DepositLeg for: self and: anAccountRecieving.
	value := aValue.

	
	! !


!Transfer methodsFor: 'balance' stamp: 'jn 5/30/2021 20:22:56'!
addToBalance: aBalance

	^ aBalance + value.! !

!Transfer methodsFor: 'balance' stamp: 'jn 5/30/2021 20:23:03'!
substractToBalance: aBalance

	^ aBalance - value.! !


!Transfer methodsFor: 'testing' stamp: 'jn 5/30/2021 20:30:09'!
isRegisteredAsFromIn: anAccount andToIn: anotherAccount

	^ (anAccount hasRegistered: withdrawLeg) and: 
          (anotherAccount hasRegistered: depositLeg)
! !

!Transfer methodsFor: 'testing' stamp: 'jn 5/30/2021 20:20:07'!
legsBelongsTo: aTransfer
	
	^ (withdrawLeg belongsTo: aTransfer) and: (depositLeg belongsTo: aTransfer).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'jn 6/2/2021 20:29:03'!
canNotTransferInvalidValue

	^  'Can not transfer invalid value'.
	


	! !

!Transfer class methodsFor: 'instance creation' stamp: 'jn 6/2/2021 20:32:00'!
canNotTransferToSameAccount

	^  'Can not transfer to same account'.
	


	! !

!Transfer class methodsFor: 'instance creation' stamp: 'jn 6/2/2021 20:27:33'!
from: anAccountSending to: anAccountRecieving value: aValue
	
	^ self new initializeFrom: anAccountSending to: anAccountRecieving value: aValue
	


	! !


!classDefinition: #TransferLeg category: 'Portfolio-Solucion'!
Object subclass: #TransferLeg
	instanceVariableNames: 'transfer receptiveAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferLeg methodsFor: 'testing' stamp: 'jn 5/30/2021 20:19:17'!
belongsTo: aTransfer

	^ transfer = aTransfer.
! !


!TransferLeg methodsFor: 'initialization' stamp: 'jn 5/30/2021 20:09:32'!
initializeFor: aTransfer and: aReceptiveAccount

	transfer := aTransfer.
	receptiveAccount := aReceptiveAccount.
	
	aReceptiveAccount register: self.
! !


!TransferLeg methodsFor: 'report' stamp: 'jn 6/3/2021 16:35:36'!
doReport: aReporter

	self subclassResponsibility.! !


!TransferLeg methodsFor: 'balance' stamp: 'jn 5/30/2021 20:15:01'!
affectBalance: aBalance
	
	self subclassResponsibility.! !

!TransferLeg methodsFor: 'balance' stamp: 'jn 6/2/2021 21:05:37'!
value 
	
	^ transfer value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'Portfolio-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'jn 5/30/2021 19:56:31'!
for: aTransfer and: aTransaction

	^ self new initializeFor: aTransfer and: aTransaction. ! !


!classDefinition: #DepositLeg category: 'Portfolio-Solucion'!
TransferLeg subclass: #DepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!DepositLeg methodsFor: 'balance' stamp: 'jn 5/30/2021 20:21:41'!
affectBalance: aBalance
	
	^ transfer addToBalance: aBalance.! !


!DepositLeg methodsFor: 'report' stamp: 'jn 6/3/2021 16:22:04'!
doReport: aReporter

	aReporter doReportForDepositLeg: self value.! !


!classDefinition: #WithdrawLeg category: 'Portfolio-Solucion'!
TransferLeg subclass: #WithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WithdrawLeg methodsFor: 'balance' stamp: 'jn 5/30/2021 20:22:25'!
affectBalance: aBalance
	
	^ transfer substractToBalance: aBalance.! !


!WithdrawLeg methodsFor: 'report' stamp: 'jn 6/3/2021 16:22:18'!
doReport: aReporter

	aReporter doReportForWithdrawLeg: self value.! !
