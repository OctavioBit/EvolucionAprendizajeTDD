!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'accountWithDepositAndWithdraw anotherAccountWithDeposit accountDeposit accountWithdraw anotherAccountDeposit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'private' stamp: 'jn 5/24/2021 17:16:56'!
addAccountTo: aChildPortfolio andAnotherAccountTo: aPortfolio

	aChildPortfolio add: accountWithDepositAndWithdraw .
	aPortfolio add: aChildPortfolio.
	aPortfolio add: anotherAccountWithDeposit.
	
		

	! !

!PortfolioTest methodsFor: 'private' stamp: 'jn 5/24/2021 17:11:04'!
addAndAssertDuplicatedAdd: anAddClosure
	
	anAddClosure value.
	
	self assertDuplicatedAdd: anAddClosure.

	

	! !

!PortfolioTest methodsFor: 'private' stamp: 'jn 5/24/2021 17:16:56'!
addTwoAccountsTo: aPortfolio

	aPortfolio add: accountWithDepositAndWithdraw.
	aPortfolio add: anotherAccountWithDeposit.
	
	
	! !

!PortfolioTest methodsFor: 'private' stamp: 'jn 5/24/2021 17:11:15'!
assertDuplicatedAdd: anAddClosure
	
	self should: [ 	anAddClosure value. ] 
		raise: Error
		withExceptionDo: [ :error | 
			self assert: error messageText equals: Portfolio financialAccountAlreadyExistsDescription  ] 

	

	! !

!PortfolioTest methodsFor: 'private' stamp: 'jn 5/24/2021 17:16:56'!
assertSumOfBalancesOfAccountsEqualstToBalanceOf: portfolio
	
	self assert: (accountWithDepositAndWithdraw balance + anotherAccountWithDeposit balance) equals: portfolio balance.
	
	! !

!PortfolioTest methodsFor: 'private' stamp: 'jn 5/24/2021 17:17:08'!
assertTransactionsOf: portfolio
	
	| transactions |
	transactions := portfolio transactions.
	
	self assert: transactions size equals: 3.
	self assert: transactions includes: accountDeposit.
	self assert: transactions includes: accountWithdraw.
	self assert: transactions includes: anotherAccountDeposit.
	! !


!PortfolioTest methodsFor: 'tests' stamp: 'jn 5/24/2021 17:17:08'!
setUp
	
	accountWithDepositAndWithdraw := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: accountWithDepositAndWithdraw.
	accountWithdraw := Withdraw register: 50 on: accountWithDepositAndWithdraw.
	
	anotherAccountWithDeposit := ReceptiveAccount new.
	anotherAccountDeposit := Deposit register: 30 on: anotherAccountWithDeposit.

	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jn 5/24/2021 16:46:23'!
test01portfolioHasZeroBalanceWhenCreated
	
	| portfolio |
	
	portfolio := Portfolio new.

	self assert: portfolio balance equals: 0.

	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jn 5/24/2021 16:46:33'!
test02portfolioHasNoneTransactionsWhenCreated

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: portfolio transactions equals: OrderedCollection new.

	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jn 5/24/2021 17:14:12'!
test03portfolioHasBalanceEqualsToSumOfAccountsBalance
	
	| portfolio |
	
	portfolio := Portfolio new.

	self addTwoAccountsTo: portfolio.

	self assertSumOfBalancesOfAccountsEqualstToBalanceOf: portfolio.
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jn 5/24/2021 17:14:18'!
test04portfolioTransactionsEqualsToAllAccountsTransactions

	| portfolio |
	
	portfolio := Portfolio new.
		
	self addTwoAccountsTo: portfolio.
	
	self assertTransactionsOf: portfolio.

	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jn 5/24/2021 17:17:08'!
test05portfolioKnowsRegisteredTransactionsInAccounts

	| portfolio |
	
	portfolio := Portfolio new.
	
	self addTwoAccountsTo: portfolio.
		
	self assert: (portfolio hasRegistered: accountDeposit).
	self assert: (portfolio hasRegistered: accountWithdraw).
	self assert: (portfolio hasRegistered: anotherAccountDeposit).

	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jn 5/24/2021 17:17:08'!
test06portfolioDoesNotKnowNotRegisteredTransactionsInAccounts

	| portfolio |
	
	portfolio := Portfolio new.
	
	self deny: (portfolio hasRegistered: accountDeposit).
	self deny: (portfolio hasRegistered: accountWithdraw).
	self deny: (portfolio hasRegistered: anotherAccountDeposit).
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jn 5/24/2021 16:47:19'!
test07portfolioOnlyAcceptsValidReceptiveAccounts

	| portfolio |
	
	portfolio := Portfolio new.
	
	self should: [ portfolio add: 'invalid account' ] 
		raise: Error
		withExceptionDo: [ :error | self assert: error class equals: MessageNotUnderstood ] 	

	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jn 5/24/2021 17:18:18'!
test08portolioDoesNotAcceptsDuplicatedAccounts

	| portfolio |
	
	portfolio := Portfolio new.

	self addAndAssertDuplicatedAdd: [	 portfolio add: accountWithDepositAndWithdraw. ].
	

	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jn 5/24/2021 17:16:08'!
test09portfolioHasBalanceEqualsToBalancesOfPortfoliosAndAccounts

	| portfolio childPortfolio |
	
	portfolio := Portfolio new.
	childPortfolio := Portfolio new.

	self addAccountTo: childPortfolio andAnotherAccountTo: portfolio.
	
	self assertSumOfBalancesOfAccountsEqualstToBalanceOf: portfolio.
		

	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jn 5/24/2021 17:16:18'!
test10portfolioTransactionsEqualsToTransactionsOfPortfoliosAndAccounts

	| portfolio childPortfolio |	
	
	portfolio := Portfolio new.
	childPortfolio := Portfolio new.

	self addAccountTo: childPortfolio andAnotherAccountTo: portfolio.
	
	self assertTransactionsOf: portfolio.

		

	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jn 5/24/2021 17:18:03'!
test11portfolioDoesNotAcceptsDuplicatedPortfolios

	| portfolio anotherPortfolio |
	
	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new.

	self addAndAssertDuplicatedAdd: [	 portfolio add: anotherPortfolio. ].
	

	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jn 5/24/2021 17:16:56'!
test12portfolioDoesNotAcceptsDuplicatedAccountingsRecursively

	| portfolio portfolio2 portfolio3 portfolio4 |
	
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	portfolio4 := Portfolio new.
	
	portfolio2 add: accountWithDepositAndWithdraw.
	portfolio4 add: anotherAccountWithDeposit.
	
	portfolio add: portfolio2.
	portfolio3 add: portfolio4.
	portfolio3 add: portfolio2.

	self assertDuplicatedAdd: [ 	portfolio add: portfolio3. ].
	self assertDuplicatedAdd: [ 		portfolio3 add: anotherAccountWithDeposit ].
		


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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
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

!AccountTransaction methodsFor: 'value' stamp: 'jn 5/17/2021 21:55:54'!
addToBalance: aBalance 

	self subclassResponsibility ! !

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


!Deposit methodsFor: 'value' stamp: 'jn 5/17/2021 21:50:40'!
addToBalance: aBalance

	^ aBalance + value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

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


!Withdraw methodsFor: 'value' stamp: 'jn 5/17/2021 21:45:23'!
addToBalance: aBalance

	^ aBalance - value! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialAccount category: 'Portfolio-Ejercicio'!
Object subclass: #FinancialAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialAccount methodsFor: 'duplicated - private' stamp: 'jn 5/24/2021 16:03:30'!
addParent: aFinancialAccount

	self subclassResponsibility ! !

!FinancialAccount methodsFor: 'duplicated - private' stamp: 'jn 5/24/2021 16:02:55'!
hasDuplicatedWith: aFinancialAccount

	self subclassResponsibility ! !

!FinancialAccount methodsFor: 'duplicated - private' stamp: 'jn 5/24/2021 16:02:44'!
relatedWith: aFinancialAccount

	self subclassResponsibility ! !


!FinancialAccount methodsFor: 'transactions' stamp: 'jn 5/24/2021 00:28:06'!
transactions

	self subclassResponsibility ! !


!FinancialAccount methodsFor: 'testing' stamp: 'jn 5/24/2021 00:29:15'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!FinancialAccount methodsFor: 'balance' stamp: 'jn 5/24/2021 00:28:29'!
balance

	self subclassResponsibility ! !


!FinancialAccount methodsFor: 'initialization' stamp: 'jn 5/24/2021 00:40:40'!
initialize
	
	self subclassResponsibility ! !


!FinancialAccount methodsFor: 'private' stamp: 'jn 5/24/2021 15:07:47'!
addToPortfolio: aPortfolio

	aPortfolio addFinancialAccount: self.! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialAccount subclass: #Portfolio
	instanceVariableNames: 'parents financialAccounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'jn 5/24/2021 15:23:13'!
initialize
	
	financialAccounts := Set new.	
	parents := Set new.
! !


!Portfolio methodsFor: 'balance' stamp: 'jn 5/24/2021 15:49:46'!
balance

	^ financialAccounts sum: [:aFinancialAccount | aFinancialAccount balance ] ifEmpty: [0].! !


!Portfolio methodsFor: 'transactions' stamp: 'jn 5/24/2021 15:58:52'!
transactions
	
	^ (financialAccounts collect: [ :aFinancialAccount | aFinancialAccount transactions ]) asOrderedCollection flatten copy.
	
! !


!Portfolio methodsFor: 'duplicated - private' stamp: 'jn 5/23/2021 19:01:30'!
addParent: aParentPortfolio 
	
	parents add: aParentPortfolio.
! !

!Portfolio methodsFor: 'duplicated - private' stamp: 'jn 5/24/2021 15:50:02'!
hasAnyDuplicatedWith: aFinancialAccountToAdd

	parents isEmpty 
		ifTrue: [ ^ self hasDuplicatesWith: aFinancialAccountToAdd ]
		ifFalse:[ ^ parents anySatisfy: [ :aPortfolio | aPortfolio hasAnyDuplicatedWith: aFinancialAccountToAdd ]]
! !

!Portfolio methodsFor: 'duplicated - private' stamp: 'jn 5/24/2021 15:49:55'!
hasDuplicatesWith: aFinancialAccountToAdd

	(aFinancialAccountToAdd relatedWith: self)
		ifTrue: [ ^ true ]
		ifFalse:[ ^ financialAccounts anySatisfy: [ :aFinancialAccount | 
				aFinancialAccount hasDuplicatesWith: aFinancialAccountToAdd ]].! !

!Portfolio methodsFor: 'duplicated - private' stamp: 'jn 5/24/2021 15:49:26'!
relatedWith: aFinancialAccount

	(self = aFinancialAccount)
		ifTrue: [ ^ true ]
		ifFalse:[ ^ financialAccounts anySatisfy: [ :aFinancialAccountToAdd | 
				aFinancialAccountToAdd relatedWith: aFinancialAccount ]].
! !


!Portfolio methodsFor: 'error' stamp: 'jn 5/24/2021 15:08:52'!
financialAccountAlreadyExistsInPortfolio

	self error: self class financialAccountAlreadyExistsDescription ! !


!Portfolio methodsFor: 'private' stamp: 'jn 5/24/2021 15:20:10'!
addFinancialAccount: aFinancialAccountToAdd
	
	(self hasAnyDuplicatedWith: aFinancialAccountToAdd) 
		ifTrue: [ self financialAccountAlreadyExistsInPortfolio ] 
		ifFalse: [ 
			financialAccounts add: aFinancialAccountToAdd. 
			aFinancialAccountToAdd addParent: self.
		]
! !


!Portfolio methodsFor: 'add' stamp: 'jn 5/24/2021 15:49:36'!
add: aFinancialAccount 
	
	aFinancialAccount addToPortfolio: self.
! !


!Portfolio methodsFor: 'testing' stamp: 'jn 5/24/2021 15:33:48'!
hasRegistered: aTransaction

	^ self transactions includes: aTransaction 
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'jn 5/24/2021 15:08:11'!
financialAccountAlreadyExistsDescription 
	
	^'Portfolio already exists in portfolio.'.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'jn 5/24/2021 02:04:22'!
initialize

	transactions := OrderedCollection new.
! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'jn 5/24/2021 15:58:13'!
balance

	^ transactions inject: 0 into: [ :totalBalance :aTransaction | aTransaction addToBalance: totalBalance]



! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'duplicated - private' stamp: 'jn 5/24/2021 16:00:19'!
addParent: aParentPortfolio

	" Este mensaje esta para que ReceptiveAccount sea polimorfico con Portfolio y asi evitar ifs a la hora 
	 de agregar parents a los portfolios. "! !

!ReceptiveAccount methodsFor: 'duplicated - private' stamp: 'jn 5/24/2021 15:19:39'!
hasDuplicatesWith: aFinancialAccount

	^ aFinancialAccount relatedWith: self
		! !

!ReceptiveAccount methodsFor: 'duplicated - private' stamp: 'jn 5/24/2021 15:19:13'!
relatedWith: aFinancialAccount
	
	^ self = aFinancialAccount
! !
