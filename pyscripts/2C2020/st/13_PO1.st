!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'AM 11/2/2020 19:29:45'!
test01EmptyPortfolioHasZeroBalance

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: (portfolio balance) equals: 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'AM 11/7/2020 01:34:24'!
test02PortfolioWithOneAccountMatchesAccountBalance

	| portfolio account |
	
	portfolio := Portfolio new.
	
	account := PortfolioAccount for: (ReceptiveAccount new).
	account register: (Deposit for: 300).
	
	portfolio add: account.
	
	self assert: (account balance) equals: (portfolio balance).! !

!PortfolioTest methodsFor: 'tests' stamp: 'AM 11/7/2020 01:35:08'!
test03PortfolioWithOnePortfolioMatchesPortFolioBalance

	| portfolioChild portfolioParent account |
	
	account := PortfolioAccount for: (ReceptiveAccount new).
	account register: (Deposit for: 300).
	portfolioChild := Portfolio new.
	portfolioChild add: account.
	
	portfolioParent := Portfolio new.
	
	portfolioParent add: portfolioChild.
	
	self assert: (portfolioChild balance) equals: (portfolioParent balance).! !

!PortfolioTest methodsFor: 'tests' stamp: 'AM 11/9/2020 14:05:28'!
test04FindsAccountInPortfolioTransactionCorrectly

	| portfolio account transaction|
	
	portfolio := Portfolio new.
	transaction := (Deposit for: 300).
	account := PortfolioAccount for: (ReceptiveAccount new).
	account register: transaction.
	
	portfolio add: account.
	
	self assert: (portfolio hasRegistered: transaction).! !

!PortfolioTest methodsFor: 'tests' stamp: 'AM 11/9/2020 14:05:48'!
test05FindsAccountTransactionCorrectly

	| portfolio account transaction|
	
	portfolio := Portfolio new.
	transaction := (Deposit for: 300).
	account := PortfolioAccount for: (ReceptiveAccount new).
	account register: transaction.
	
	portfolio add: account.
	
	self assert: (portfolio hasRegistered: transaction).! !

!PortfolioTest methodsFor: 'tests' stamp: 'AM 11/9/2020 14:05:59'!
test06CantRegisterDuplicateAccounts

	| portfolio account |
	
	portfolio := Portfolio new.
	account := PortfolioAccount for: (ReceptiveAccount new).
	account register: (Deposit for: 300).
	
	portfolio add: account.
	
	self
	should: [portfolio add: account.]
	raise: Error
	withMessageText: Portfolio duplicateAccountErrorDescription.! !

!PortfolioTest methodsFor: 'tests' stamp: 'AM 11/9/2020 14:07:09'!
test07CantAddAccountPresentInChildPortfolio

	| portfolioChild portfolioParent account|
	
	account := PortfolioAccount for: (ReceptiveAccount new).
	account register: (Deposit for: 300).
	
	portfolioChild := Portfolio new.
	portfolioChild add: account.
	
	portfolioParent := Portfolio new.
	portfolioParent add: portfolioChild.
	
	self
	should: [portfolioParent add: account.]
	raise: Error
	withMessageText: Portfolio duplicateAccountErrorDescription.! !

!PortfolioTest methodsFor: 'tests' stamp: 'AM 11/9/2020 14:06:45'!
test08CantAddPortfolioContainingAccountAlreadyPresent

	| portfolio portfolioToAdd account|
	
	account := PortfolioAccount for: (ReceptiveAccount new).
	account register: (Deposit for: 300).
	
	portfolio := Portfolio new.
	portfolio add: account.
	
	portfolioToAdd := Portfolio new.
	portfolioToAdd add: account.
	
	self
	should: [portfolio add: portfolioToAdd.]
	raise: Error
	withMessageText: Portfolio duplicateAccountErrorDescription.! !

!PortfolioTest methodsFor: 'tests' stamp: 'AM 11/9/2020 14:06:39'!
test09CantAddPortfolioThatSharesAccountsWithPortfolioAlreadyPresent

	| portfolio portfolioChild portfolioToAdd account|
	
	account := PortfolioAccount for: (ReceptiveAccount new).
	account register: (Deposit for: 300).
	
	portfolioChild := Portfolio new.
	portfolioChild add: account.
	
	portfolio := Portfolio new.
	portfolio add: portfolioChild.
	
	portfolioToAdd := Portfolio new.
	portfolioToAdd add: account.
	
	self
	should: [portfolio add: portfolioToAdd.]
	raise: Error
	withMessageText: Portfolio duplicateAccountErrorDescription.! !

!PortfolioTest methodsFor: 'tests' stamp: 'AM 11/9/2020 14:07:34'!
test10EmptyPortfolioHasNoTransactions

	| portfolio |
	
	portfolio := Portfolio new.
	self assert: (portfolio transactions) equals: OrderedCollection new.! !

!PortfolioTest methodsFor: 'tests' stamp: 'AM 11/9/2020 14:06:25'!
test11PortfolioTransactionsMatchesAccountTransactions
	| portfolio account transaction |
	
	transaction := Deposit for: 300.
	
	account := PortfolioAccount for: (ReceptiveAccount new).
	account register: transaction.
	
	portfolio := Portfolio new.
	portfolio add: account.
	
	self assert: (portfolio transactions) equals: (OrderedCollection with: transaction).! !

!PortfolioTest methodsFor: 'tests' stamp: 'AM 11/9/2020 14:06:19'!
test12PortfolioTransactionsMatchesAccountAndPortfolioTransactions
	
	| portfolio portfolioChild transaction1 transaction2 account1 account2 |
	
	transaction1 := Deposit for: 300.
	transaction2 := Deposit for: 150.
	
	account1 := PortfolioAccount for: (ReceptiveAccount new).
	account1 register: transaction1.
	
	account2 := PortfolioAccount for: (ReceptiveAccount new).
	account2 register: transaction2.
	
	portfolioChild := Portfolio new.
	portfolioChild add: account1.
	
	portfolio := Portfolio new.
	portfolio add: portfolioChild.
	portfolio add: account2.
	
	self assert: (portfolio transactions) equals: (OrderedCollection with: transaction1 with: transaction2).! !


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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:15'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
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


!Deposit methodsFor: 'value' stamp: 'AM 11/2/2020 20:31:48'!
applyToBalance: aBalanceValue

	^ aBalanceValue + self value.! !

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


!Withdraw methodsFor: 'value' stamp: 'AM 11/2/2020 20:30:54'!
applyToBalance: aBalanceValue

	^ aBalanceValue - self value.! !

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


!classDefinition: #PortfolioElement category: 'Portfolio-Ejercicio'!
Object subclass: #PortfolioElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioElement methodsFor: 'as yet unclassified' stamp: 'AM 11/9/2020 14:09:18'!
assertNoDuplicates: anAccountOrPortfolio

	self subclassResponsibility.! !

!PortfolioElement methodsFor: 'as yet unclassified' stamp: 'AM 11/9/2020 14:09:27'!
assertNoDuplicatesInHierarchy: anAccountOrPortfolio

	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
PortfolioElement subclass: #Portfolio
	instanceVariableNames: 'portfolioElements parentPortfolios isRoot'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'AM 11/7/2020 01:25:26'!
balance
	
	^portfolioElements sum: [:element | element balance] ifEmpty: [0].! !


!Portfolio methodsFor: 'initialization' stamp: 'AM 11/9/2020 11:28:10'!
initialize 

	portfolioElements := OrderedCollection new.
	parentPortfolios := OrderedCollection with: (RootPortfolio for: self).
	isRoot := true.! !


!Portfolio methodsFor: 'transactions private' stamp: 'AM 11/9/2020 14:03:40'!
addTransactionsTo: aCollectionOfTransactions

	portfolioElements do: [:element | element addTransactionsTo: aCollectionOfTransactions ].! !


!Portfolio methodsFor: 'adding private' stamp: 'AM 11/7/2020 01:19:43'!
addParent: aPortfolio
	
	isRoot ifTrue: [parentPortfolios removeFirst.
				isRoot := false].
	parentPortfolios add: aPortfolio.! !


!Portfolio methodsFor: 'adding' stamp: 'AM 11/7/2020 00:35:39'!
add: aPortfolioElement 
	
	self assertNoDuplicatesInHierarchy: aPortfolioElement.
	aPortfolioElement addParent: self.
	portfolioElements add: aPortfolioElement.! !


!Portfolio methodsFor: 'assertions' stamp: 'AM 11/7/2020 00:42:42'!
assertNoDuplicates: aPortfolioElement

	portfolioElements detect: [:element | element assertNoDuplicates: aPortfolioElement] ifNone: [^false].
	self signalDuplicateAccount.! !

!Portfolio methodsFor: 'assertions' stamp: 'AM 11/7/2020 01:04:02'!
assertNoDuplicatesInHierarchy: aPortfolioElement
	
	parentPortfolios do: [:parentPortfolio | parentPortfolio assertNoDuplicatesInHierarchy: aPortfolioElement].! !


!Portfolio methodsFor: 'testing' stamp: 'AM 11/7/2020 01:38:03'!
hasRegistered: aTransaction
	
	portfolioElements detect: [:element | element hasRegistered: aTransaction] ifNone: [^false].
	^true.! !

!Portfolio methodsFor: 'testing' stamp: 'AM 11/7/2020 01:50:01'!
includesOrIsAccount: aPortfolioAccount

	portfolioElements detect: [:element | element includesOrIsAccount: aPortfolioAccount] ifNone: [^false].
	^true.! !


!Portfolio methodsFor: 'signals' stamp: 'AM 11/2/2020 20:40:09'!
signalDuplicateAccount

	^self error: self class duplicateAccountErrorDescription.! !


!Portfolio methodsFor: 'transactions' stamp: 'AM 11/9/2020 13:53:33'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	portfolioElements do: [:element | element addTransactionsTo: transactions].
	
	^transactions.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error messages' stamp: 'AM 11/2/2020 20:35:45'!
duplicateAccountErrorDescription
	
	^'Account is duplicate'! !


!classDefinition: #PortfolioAccount category: 'Portfolio-Ejercicio'!
PortfolioElement subclass: #PortfolioAccount
	instanceVariableNames: 'receptiveAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioAccount methodsFor: 'initialization' stamp: 'AM 11/9/2020 12:24:11'!
initializeFor: aReceptiveAccount

	receptiveAccount := aReceptiveAccount.! !


!PortfolioAccount methodsFor: 'assertions' stamp: 'AM 11/7/2020 00:50:00'!
assertNoDuplicates: aPortfolioElement

	^aPortfolioElement includesOrIsAccount: self.! !


!PortfolioAccount methodsFor: 'adding' stamp: 'AM 11/9/2020 12:25:39'!
addParent: aPortfolio

	"No es necesario registrar a que portfolio pertenece la cuenta"! !


!PortfolioAccount methodsFor: 'accesing' stamp: 'AM 11/7/2020 01:25:03'!
balance 

	^receptiveAccount balance.! !


!PortfolioAccount methodsFor: 'transactions' stamp: 'AM 11/7/2020 01:31:50'!
register: aTransaction

	receptiveAccount register: aTransaction.! !

!PortfolioAccount methodsFor: 'transactions' stamp: 'AM 11/7/2020 01:32:19'!
transactions

	^receptiveAccount transactions.! !


!PortfolioAccount methodsFor: 'transactions private' stamp: 'AM 11/9/2020 13:55:18'!
addTransactionsTo: aCollectionOfTransactions

	self transactions do: [:transaction | aCollectionOfTransactions add: transaction ].! !


!PortfolioAccount methodsFor: 'testing' stamp: 'AM 11/7/2020 01:32:47'!
hasRegistered: aTransaction

	^receptiveAccount hasRegistered: aTransaction.! !

!PortfolioAccount methodsFor: 'testing' stamp: 'AM 11/7/2020 00:59:24'!
includesOrIsAccount: aPortfolioAccount

	
	^self == aPortfolioAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioAccount class' category: 'Portfolio-Ejercicio'!
PortfolioAccount class
	instanceVariableNames: ''!

!PortfolioAccount class methodsFor: 'instance creation' stamp: 'AM 11/7/2020 01:22:08'!
for: anAccount
	
	^self new initializeFor: anAccount.! !


!classDefinition: #RootPortfolio category: 'Portfolio-Ejercicio'!
PortfolioElement subclass: #RootPortfolio
	instanceVariableNames: 'childPortfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!RootPortfolio methodsFor: 'initialization' stamp: 'AM 11/7/2020 01:02:41'!
initializeFor: aPortfolio

	childPortfolio := aPortfolio.! !


!RootPortfolio methodsFor: 'assertions' stamp: 'AM 11/7/2020 01:15:12'!
assertNoDuplicates: aPortfolioElement

	^false.! !

!RootPortfolio methodsFor: 'assertions' stamp: 'AM 11/7/2020 00:35:01'!
assertNoDuplicatesInHierarchy: aPortfolioElement

	childPortfolio assertNoDuplicates: aPortfolioElement.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RootPortfolio class' category: 'Portfolio-Ejercicio'!
RootPortfolio class
	instanceVariableNames: ''!

!RootPortfolio class methodsFor: 'as yet unclassified' stamp: 'AM 11/7/2020 01:26:45'!
for: aPortfolio
	
	^self new initializeFor: aPortfolio.
	! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'AM 11/7/2020 01:29:04'!
balance

	| balance |
	balance := 0.
	transactions do: [:aTransaction | balance := aTransaction applyToBalance: balance].
	
	^balance.
	! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
