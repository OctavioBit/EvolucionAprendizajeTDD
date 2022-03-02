!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/23/2021 18:54:11'!
test01PortfolioHaveZeroAsBalanceWhenCreated 

	| portfolio |
	
	portfolio := Portfolio new.

	self assert: 0 equals: portfolio balance.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/23/2021 21:25:09'!
test02AddingAccountIncreasesBalanceOnAccountsBalance

	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolio add: account.

	self assert: 100 equals: portfolio balance.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/23/2021 21:31:36'!
test03AddingTwoAccountsIncreasesBalanceOnSumOfAccountsBalance

	| portfolio account1 account2 |
	
	portfolio := Portfolio new.
	account1 := ReceptiveAccount new.
	Deposit register: 100 on: account1.
	account2 := ReceptiveAccount new.
	Deposit register: 75 on: account2.
	
	portfolio add: account1.
	portfolio add: account2.

	self assert: 175 equals: portfolio balance.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/23/2021 21:36:33'!
test04PortfolioKnowsRegisteredTransactionsOnItsAccounts

	| portfolio account1 account2 depositInAccount1 |
	
	portfolio := Portfolio new.
	account1 := ReceptiveAccount new.
	depositInAccount1 := Deposit register: 100 on: account1.
	account2 := ReceptiveAccount new.
	Deposit register: 75 on: account2.
	
	portfolio add: account1.
	portfolio add: account2.

	self assert: (portfolio hasRegistered: depositInAccount1).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/23/2021 21:38:23'!
test05PortfolioDoesNotKnowNotRegisteredTransactionsOnItsAccounts

	| portfolio account deposit withdraw |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit for: 100.
	withdraw := Withdraw for: 75.
	
	portfolio add: account.

	self deny: (portfolio hasRegistered: deposit).
	self deny: (portfolio hasRegistered: withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/24/2021 18:42:56'!
test06PortfolioKnowsItsAccountsTransactions

	| portfolio account1 depositInAccount1 account2 withdrawInAccount2 |
	
	portfolio := Portfolio new.
	account1 := ReceptiveAccount new.
	depositInAccount1 := Deposit register: 100 on: account1.
	account2 := ReceptiveAccount new.
	withdrawInAccount2 := Withdraw register: 75 on: account2.
	
	portfolio add: account1.
	portfolio add: account2.

	self assert: 2 equals: portfolio transactions size.
	self assert: (portfolio transactions includes: depositInAccount1).
	self assert: (portfolio transactions includes: withdrawInAccount2).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/24/2021 17:30:43'!
test07AddingPortfolioIncreasesBalanceOnPortfoliosBalance

	| account childPortfolio parentPortfolio |
	
	parentPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	childPortfolio add: account.
	parentPortfolio add: childPortfolio.

	self assert: 100 equals: parentPortfolio balance.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/23/2021 21:51:26'!
test08PortfolioKnowsRegisteredTransactionsOnItsPortfolios

	| account childPortfolio deposit parentPortfolio |
	
	parentPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	
	childPortfolio add: account.
	parentPortfolio add: childPortfolio.

	self assert: (parentPortfolio hasRegistered: deposit).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/24/2021 17:30:19'!
test09PortfolioKnowsItsPortfoliosTransactions

	| account childPortfolio deposit parentPortfolio |
	
	parentPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	
	childPortfolio add: account.
	parentPortfolio add: childPortfolio.

	self assert: 1 equals: parentPortfolio transactions size.
	self assert: parentPortfolio transactions includes: deposit.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/24/2021 17:29:54'!
test10AddingAccountAlreadyInChildPortfolioRaisesError

	| account childPortfolio parentPortfolio |
	
	parentPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	childPortfolio add: account.
	parentPortfolio add: childPortfolio.
	self should: [ parentPortfolio add: account. ]
		raise: Error - MessageNotUnderstood
		withMessageText: [ Portfolio errorDescriptionCannotAddDuplicates ].
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/24/2021 17:29:40'!
test11AddingPortfolioWithAccountAlreadyInThisPortfolioRaisesError

	| account childPortfolio parentPortfolio |
	
	parentPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	childPortfolio add: account.
	parentPortfolio add: account.
	self should: [ parentPortfolio add: childPortfolio. ]
		raise: Error - MessageNotUnderstood
		withMessageText: [ Portfolio errorDescriptionCannotAddDuplicates ].
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/24/2021 17:29:32'!
test12AddingTwoPortfoliosWithASharedAccountRaisesError

	| account parentPortfolio childPortfolio1 childPortfolio2 |
	
	parentPortfolio := Portfolio new.
	childPortfolio1 := Portfolio new.
	childPortfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	childPortfolio1 add: account.
	childPortfolio2 add: account.
	parentPortfolio add: childPortfolio1.
	self should: [ parentPortfolio add: childPortfolio2. ]
		raise: Error - MessageNotUnderstood
		withMessageText: [ Portfolio errorDescriptionCannotAddDuplicates ].
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/24/2021 22:03:34'!
test13AddingAccountAlreadyInParentRaisesError

	| account childPortfolio parentPortfolio |
	
	parentPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	parentPortfolio add: account.
	parentPortfolio add: childPortfolio.
	self should: [ childPortfolio add: account. ]
		raise: Error - MessageNotUnderstood
		withMessageText: [ Portfolio errorDescriptionCannotAddDuplicates ].
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/24/2021 21:59:14'!
test14AddingAccountToSharedPortfolioAlreadyInOneParentRaisesError

	| account childPortfolio parentPortfolio1 parentPortfolio2 |
	
	parentPortfolio1 := Portfolio new.
	parentPortfolio2 := Portfolio new.
	childPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	parentPortfolio1 add: account.
	parentPortfolio1 add: childPortfolio.
	parentPortfolio2 add: childPortfolio.
	self should: [ childPortfolio add: account. ]
		raise: Error - MessageNotUnderstood
		withMessageText: [ Portfolio errorDescriptionCannotAddDuplicates ].
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/24/2021 22:05:11'!
test15AddingAccountAlreadyInUpperLevelRaisesError

	| account parentPortfolio childPortfolio1 childPortfolio2 |
	
	parentPortfolio := Portfolio new.
	childPortfolio1 := Portfolio new.
	childPortfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	parentPortfolio add: account.
	parentPortfolio add: childPortfolio1.
	childPortfolio1 add: childPortfolio2.
	self should: [ childPortfolio2 add: account. ]
		raise: Error - MessageNotUnderstood
		withMessageText: [ Portfolio errorDescriptionCannotAddDuplicates ].
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LM 5/24/2021 22:14:46'!
test16MergingTreesAndAddingExistentAccountToSubtreeRaisesError

	| account parentPortfolio childPortfolio1 childPortfolio2 |
	
	parentPortfolio := Portfolio new.
	childPortfolio1 := Portfolio new.
	childPortfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	parentPortfolio add: account.
	childPortfolio1 add: childPortfolio2.
	parentPortfolio add: childPortfolio1.
	self should: [ childPortfolio2 add: account. ]
		raise: Error - MessageNotUnderstood
		withMessageText: [ Portfolio errorDescriptionCannotAddDuplicates ].
! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LM 5/24/2021 18:43:16'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'balance' stamp: 'LM 5/17/2021 21:48:17'!
sumToBalance: aBalance

	self subclassResponsibility! !


!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
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


!Deposit methodsFor: 'balance' stamp: 'LM 5/17/2021 21:47:50'!
sumToBalance: aBalance

	^aBalance + value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


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


!Withdraw methodsFor: 'balance' stamp: 'LM 5/17/2021 21:48:05'!
sumToBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialAsset category: 'Portfolio-Ejercicio'!
Object subclass: #FinancialAsset
	instanceVariableNames: 'parentPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialAsset methodsFor: 'collision-testing-private' stamp: 'LM 5/24/2021 21:51:20'!
collisionsWithAccount: anAccount

	self subclassResponsibility! !

!FinancialAsset methodsFor: 'collision-testing-private' stamp: 'LM 5/24/2021 21:51:40'!
collisionsWithPortfolio: aPortfolio

	self subclassResponsibility! !


!FinancialAsset methodsFor: 'adding-private' stamp: 'LM 5/24/2021 21:49:06'!
addParentPortfolio: aPortfolio

	parentPortfolios add: aPortfolio.! !


!FinancialAsset methodsFor: 'balance' stamp: 'LM 5/24/2021 21:49:57'!
balance

	self subclassResponsibility! !


!FinancialAsset methodsFor: 'transactions' stamp: 'LM 5/24/2021 21:52:54'!
transactions

	self subclassResponsibility! !


!FinancialAsset methodsFor: 'testing' stamp: 'LM 5/24/2021 21:52:06'!
hasRegistered: aTransaction

	self subclassResponsibility! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialAsset subclass: #Portfolio
	instanceVariableNames: 'assets'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'adding' stamp: 'LM 5/24/2021 21:39:02'!
add: anAsset

	self rootPortfolios do: [ :rootPortfolio | rootPortfolio checkCollisionWith: anAsset ].
	
	assets add: anAsset.
	anAsset addParentPortfolio: self.! !


!Portfolio methodsFor: 'collision-asserting-private' stamp: 'LM 5/24/2021 18:54:44'!
checkCollisionWith: anAsset

	(anAsset collisionsWithPortfolio: self	) ifTrue: [ self signalDuplicateAccounts ].! !


!Portfolio methodsFor: 'signaling' stamp: 'LM 5/23/2021 19:38:54'!
signalDuplicateAccounts

	self error: self class errorDescriptionCannotAddDuplicates.! !


!Portfolio methodsFor: 'accessing' stamp: 'LM 5/24/2021 21:38:45'!
rootPortfolios

	parentPortfolios ifEmpty: [^Set with: self].
	^parentPortfolios inject: Set new addingAll: [ :aPortfolio | aPortfolio rootPortfolios ].! !


!Portfolio methodsFor: 'balance' stamp: 'LM 5/23/2021 18:48:58'!
balance

	^assets sum: [ :anAsset | anAsset balance ] ifEmpty: [0]! !


!Portfolio methodsFor: 'collision-testing-private' stamp: 'LM 5/24/2021 18:46:39'!
collisionsWithAccount: anAccount

	^assets anySatisfy: [ :eachAsset | eachAsset collisionsWithAccount: anAccount 	]! !

!Portfolio methodsFor: 'collision-testing-private' stamp: 'LM 5/24/2021 18:45:39'!
collisionsWithPortfolio: aPortfolio 

	^assets anySatisfy: [ :eachAsset | eachAsset collisionsWithPortfolio: aPortfolio ]! !


!Portfolio methodsFor: 'testing' stamp: 'LM 5/23/2021 18:48:58'!
hasRegistered: aTransaction

	^assets anySatisfy: [ :anAsset | anAsset hasRegistered: aTransaction ]! !


!Portfolio methodsFor: 'initialization' stamp: 'LM 5/24/2021 21:31:31'!
initialize

	assets := OrderedCollection new.
	parentPortfolios := Set new.! !


!Portfolio methodsFor: 'transactions' stamp: 'LM 5/23/2021 18:48:58'!
transactions

	^assets inject: OrderedCollection new addingAll: [ :anAsset | anAsset transactions ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'LM 5/23/2021 19:39:55'!
errorDescriptionCannotAddDuplicates

	^'No se puede agregar cuentas repetidas.'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialAsset subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'LM 5/24/2021 21:31:40'!
initialize

	transactions := OrderedCollection new.
	parentPortfolios := Set new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'LM 5/17/2021 21:59:40'!
balance

	^transactions inject: 0 into: [ :aSubBalance :aTransaction | aTransaction sumToBalance: aSubBalance 	]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'LM 5/24/2021 18:43:07'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'collision-testing-private' stamp: 'LM 5/24/2021 18:40:32'!
collisionsWithAccount: anAccount

	^self = anAccount! !

!ReceptiveAccount methodsFor: 'collision-testing-private' stamp: 'LM 5/24/2021 18:49:23'!
collisionsWithPortfolio: aPortfolio

	^aPortfolio collisionsWithAccount: self.! !
