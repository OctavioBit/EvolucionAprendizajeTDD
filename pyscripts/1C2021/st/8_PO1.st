!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'portfolio secondPortfolio anAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'ijgt 5/22/2021 18:12:23'!
test01newPortfolioShouldBeEmpty

	self assert: (portfolio accounts isEmpty)! !

!PortfolioTest methodsFor: 'tests' stamp: 'ijgt 5/22/2021 18:12:45'!
test02newPortfolioCanAddAccount
	
	portfolio addAccount: anAccount.
	self assert: (portfolio accounts includes: anAccount) .! !

!PortfolioTest methodsFor: 'tests' stamp: 'ijgt 5/22/2021 18:13:09'!
test03portfolioCanCalculateBalanceWithOneAccount

	Deposit register: 100 on: anAccount.
	
	portfolio addAccount: anAccount.
	self assert: (portfolio balance) equals: 100! !

!PortfolioTest methodsFor: 'tests' stamp: 'ijgt 5/22/2021 18:13:31'!
test04portfolioCanNotAddSameAccountTwice

	Deposit register: 100 on: anAccount.
	
	portfolio addAccount: anAccount.
	self should: [portfolio addAccount: anAccount] raise: Error withExceptionDo: [:anError | self assert: (anError messageText) equals: portfolio accountCanNotBeAddedErrorDescription]! !

!PortfolioTest methodsFor: 'tests' stamp: 'ijgt 5/22/2021 18:14:06'!
test05portfolioCanCalculateBalanceRecursively

	Deposit register: 100 on: anAccount.
	
	portfolio addAccount: anAccount.
	portfolio addAccount: secondPortfolio.
	self assert: (portfolio balance) equals: 100! !

!PortfolioTest methodsFor: 'tests' stamp: 'ijgt 5/22/2021 18:14:22'!
test06portfolioCanNotAddItself

	self should: [portfolio addAccount: portfolio] raise: Error withExceptionDo: [:anError | self assert: (anError messageText) equals: portfolio accountCanNotBeAddedErrorDescription].! !

!PortfolioTest methodsFor: 'tests' stamp: 'ijgt 5/22/2021 18:14:53'!
test07portfolioCanNotContainItselfRecursively
	
	portfolio addAccount: secondPortfolio.
	self should: [secondPortfolio addAccount: portfolio] raise: Error withExceptionDo: [:anError | self assert: (anError messageText) equals: portfolio accountCanNotBeAddedErrorDescription].
	self assert: secondPortfolio accounts isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'ijgt 5/22/2021 18:16:10'!
test08portfolioCanNotAddPortfolioWithRepeatedAccount
	
	portfolio addAccount: anAccount.
	secondPortfolio addAccount: anAccount.
	self should: [portfolio addAccount: secondPortfolio] raise: Error withExceptionDo: [:anError | self assert: (anError messageText) equals: portfolio accountCanNotBeAddedErrorDescription].
	self assert: portfolio accounts size equals: 1.! !

!PortfolioTest methodsFor: 'tests' stamp: 'ijgt 5/22/2021 18:16:26'!
test09newPortfolioHasNoTransactions

	self assert: (portfolio transactions) isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'ijgt 5/22/2021 18:17:10'!
test10portfolioCanReturnTransactionsWithOneAccount

	|transaction|
	transaction := Deposit register: 100 on: anAccount.
	portfolio addAccount: anAccount.
	
	self assert: (portfolio transactions) size equals: 1.
	self assert: portfolio transactions includes: transaction.! !

!PortfolioTest methodsFor: 'tests' stamp: 'ijgt 5/22/2021 18:17:55'!
test11portfolioCanReturnTransactionsWithTwoAccounts

	| account2 transaction1 transaction2|
	account2 := ReceptiveAccount new.
	transaction1 := Deposit register: 100 on: anAccount.
	transaction2 := Withdraw register: 100 on: account2.
	portfolio addAccount: anAccount.
	portfolio addAccount: account2.

	self assert: (portfolio transactions) size equals: 2.
	self assert: portfolio transactions includes: transaction1.
	self assert: portfolio transactions includes: transaction2.! !

!PortfolioTest methodsFor: 'tests' stamp: 'ijgt 5/22/2021 18:18:27'!
test12newPortfolioHasNotRegisteredDeposit

	self deny: (portfolio hasRegistered: (Deposit for: 100) )! !

!PortfolioTest methodsFor: 'tests' stamp: 'ijgt 5/22/2021 18:18:53'!
test13portfolioHasRegisteredTransaction

	| transaction|
	transaction := (Deposit register: 100 on: anAccount).
	portfolio addAccount: anAccount.
	
	self assert: (portfolio hasRegistered: transaction)! !

!PortfolioTest methodsFor: 'tests' stamp: 'ijgt 5/22/2021 18:19:36'!
test14portfolioCanNotAddAccountAlreadyInParentPortfolio

	"Test escrito después de TDD."

	portfolio addAccount: anAccount.
	portfolio addAccount: secondPortfolio.
	self should: [secondPortfolio addAccount: anAccount] raise: Error withExceptionDo: [:anError | self assert: (anError messageText) equals: portfolio accountCanNotBeAddedErrorDescription].
	self assert: (portfolio containsAccount: anAccount).
	self assert: portfolio accounts size equals: 2.
	self assert: secondPortfolio accounts isEmpty.! !

!PortfolioTest methodsFor: 'tests' stamp: 'ijgt 5/22/2021 18:23:33'!
test15portfolioCanNotAddAccountAlreadyInMultipleParentPortfolios

	"Test escrito después de TDD."

	|aLeftRootPortfolio aRightRootPortfolio |
	aLeftRootPortfolio := Portfolio new.
	aRightRootPortfolio := Portfolio new.
	
	aLeftRootPortfolio addAccount: anAccount.
	aRightRootPortfolio addAccount: anAccount.
	aLeftRootPortfolio addAccount: portfolio .
	aRightRootPortfolio addAccount: portfolio .
	
	self should: [portfolio addAccount: anAccount] raise: Error withExceptionDo: [:anError | self assert: (anError messageText) equals: portfolio accountCanNotBeAddedErrorDescription].
	self assert: (aRightRootPortfolio containsAccount: anAccount).
	self assert: aRightRootPortfolio accounts size equals: 2.
	self assert: (aLeftRootPortfolio containsAccount: anAccount).
	self assert: aLeftRootPortfolio accounts size equals: 2.
	self assert: portfolio accounts isEmpty.! !


!PortfolioTest methodsFor: 'setUp' stamp: 'ijgt 5/22/2021 18:32:36'!
setUp

	portfolio := Portfolio new.
	secondPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.! !


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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ijgt 5/17/2021 20:46:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).! !


!classDefinition: #Account category: 'Portfolio-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Account methodsFor: 'transactions' stamp: 'ijgt 5/21/2021 17:44:55'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'add' stamp: 'ijgt 5/21/2021 17:54:08'!
addAccount: anAccount

	self subclassResponsibility ! !

!Account methodsFor: 'add' stamp: 'ijgt 5/22/2021 17:33:46'!
addRootPortfolios: anOrderedCollection ofParent: aPortfolio 
	
	self subclassResponsibility! !


!Account methodsFor: 'register' stamp: 'ijgt 5/21/2021 17:54:13'!
register: aTransaction

	self subclassResponsibility ! !


!Account methodsFor: 'testing' stamp: 'ijgt 5/21/2021 17:45:59'!
containsAccount: anAccount

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'ijgt 5/22/2021 17:36:20'!
hasRegistered: aTransaction

	self subclassResponsibility! !


!Account methodsFor: 'balance' stamp: 'ijgt 5/21/2021 17:43:04'!
balance

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts rootPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'transactions' stamp: 'ijgt 5/22/2021 16:52:30'!
transactions
	
	^ accounts inject: OrderedCollection new into: [:transactions :account | transactions addAll: account transactions. transactions].! !


!Portfolio methodsFor: 'testing' stamp: 'ijgt 5/17/2021 20:56:23'!
accounts

	^ accounts ! !

!Portfolio methodsFor: 'testing' stamp: 'ijgt 5/22/2021 17:17:43'!
assertCanAddAccount: anAccount

	^ (rootPortfolios allSatisfy: [:portfolio | (portfolio containsAccount: anAccount) not]) and: [(self containsAccount: anAccount) not]
	! !

!Portfolio methodsFor: 'testing' stamp: 'ijgt 5/22/2021 16:25:49'!
containsAccount: anAccount
	
	^ self = anAccount or: [accounts anySatisfy: [:account | (account containsAccount: anAccount) or: [anAccount containsAccount: account] ] ]! !

!Portfolio methodsFor: 'testing' stamp: 'ijgt 5/22/2021 17:36:08'!
hasRegistered: aTransaction

	^ self transactions includes: aTransaction! !


!Portfolio methodsFor: 'initialize' stamp: 'ijgt 5/20/2021 22:00:33'!
initialize

	accounts := OrderedCollection new.
	rootPortfolios := OrderedCollection new.! !


!Portfolio methodsFor: 'add' stamp: 'ijgt 5/21/2021 17:53:36'!
addAccount: anAccount

	(self assertCanAddAccount: anAccount) ifFalse: [self error: self accountCanNotBeAddedErrorDescription].
	anAccount addRootPortfolios: rootPortfolios ofParent: self.
	accounts add: anAccount! !

!Portfolio methodsFor: 'add' stamp: 'ijgt 5/21/2021 16:50:56'!
addRootPortfolios: aPortfolioCollection ofParent: aParentPortfolio

	aPortfolioCollection ifEmpty: [rootPortfolios add: aParentPortfolio ] ifNotEmpty: [aPortfolioCollection do:[:aPortfolio | rootPortfolios add: aPortfolio] ].
	 

! !


!Portfolio methodsFor: 'error descriptions' stamp: 'ijgt 5/20/2021 20:28:38'!
accountCanNotBeAddedErrorDescription

	^ 'Account already exists in Portfolio, or is the Portfolio itself.'! !


!Portfolio methodsFor: 'balance' stamp: 'ijgt 5/20/2021 16:30:51'!
balance
	
	^ accounts sum: [:account | account balance] ifEmpty: [0]! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'ijgt 5/17/2021 20:33:46'!
balance

	^ self depositsBalance - (self withdrawalsBalance)! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'ijgt 5/17/2021 21:43:37'!
depositsBalance

	^ (transactions select: [:aTransaction | aTransaction isKindOf: Deposit ]) sum: [:aTransaction | aTransaction value] ifEmpty: [0]! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'ijgt 5/17/2021 21:43:26'!
withdrawalsBalance

	^ (transactions select: [:aTransaction | aTransaction isKindOf: Withdraw]) sum: [:aTransaction | aTransaction value] ifEmpty: [0]! !


!ReceptiveAccount methodsFor: 'register' stamp: 'ijgt 5/21/2021 17:51:49'!
register: aTransaction

	transactions add: aTransaction 
! !


!ReceptiveAccount methodsFor: 'add' stamp: 'ijgt 5/21/2021 17:52:30'!
addAccount: anAccount

	! !

!ReceptiveAccount methodsFor: 'add' stamp: 'ijgt 5/21/2021 17:57:13'!
addRootPortfolios: anOrderedCollection ofParent: aPortfolio 
	! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'ijgt 5/22/2021 16:26:03'!
containsAccount: anAccount

	^ self = anAccount! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'ijgt 5/21/2021 17:51:49'!
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


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !
