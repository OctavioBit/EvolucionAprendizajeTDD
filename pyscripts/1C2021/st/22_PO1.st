!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'CD 5/18/2021 18:34:45'!
test01aPortfolioWithoutAccountsHasABalanceOfZero

	self assert: Portfolio new balance equals: 0.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'CD 5/18/2021 19:10:35'!
test02aPortfolioWithOneAccountBalanceEqualsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 1000 on: account.
	portfolio := Portfolio with: account.
	
	self assert: portfolio balance equals: account balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'CD 5/18/2021 19:10:55'!
test03aPortfolioBalanceIsCalculatedRecursivelyOnItsAccountsBalances

	| anAccount anotherAccount aSimplePortfolio aComposedPortfolio |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 1000 on: anAccount .
	aSimplePortfolio := Portfolio with: anAccount.
	
	anotherAccount := ReceptiveAccount new.
	Withdraw register: 100 on: anotherAccount .
	aComposedPortfolio := Portfolio with: aSimplePortfolio with: anotherAccount.
	
	self assert: aComposedPortfolio balance equals: (aSimplePortfolio balance + anotherAccount balance).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'CD 5/19/2021 19:41:22'!
test04aPortfolioWithoutAccountsDoesNotHaveRegisteredTransactions

	self assert: ((Portfolio new hasRegistered: (Deposit for: 10)) not).
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'CD 5/19/2021 19:51:53'!
test05aPortfolioWithOneAccountHasRegisteredItsTransactions

	| portfolio account transaction |
	
	account := ReceptiveAccount new.
	transaction := Deposit register: 10 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: transaction).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'CD 5/19/2021 20:00:51'!
test06aPortfolioCalculatesRecursivelyItsRegisteredTransactions

	| anAccount portfolio anotherAccount composedPortfolio withdrawTransaction depositTransaction |
	
	anAccount := ReceptiveAccount new.
	depositTransaction := Deposit register: 10 on: anAccount .
	portfolio := Portfolio with: anAccount.
	
	anotherAccount := ReceptiveAccount new.
	withdrawTransaction := Withdraw register: 50 on: anotherAccount.
	composedPortfolio := Portfolio with: portfolio with: anotherAccount.
	
	self assert: (composedPortfolio hasRegistered: depositTransaction).
	self assert: (composedPortfolio hasRegistered: withdrawTransaction).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'CD 5/19/2021 20:19:32'!
test07aPortfolioWithoutAccountsDoesNotHaveTransactions

	self assert: Portfolio new transactions isEmpty.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'CD 5/19/2021 21:21:33'!
test08aPortfolioWithOneAccountHasSameTransactionsAsAccount

	| portfolio portfolioTransactions account  accountTransaction anotherAccount  anotherAccountTransaction |
	
	account := ReceptiveAccount new.
	accountTransaction := Deposit register: 10 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountTransaction := Withdraw register: 10 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountTransaction ).
	self assert: (portfolioTransactions includes: anotherAccountTransaction ).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'CD 5/20/2021 20:25:57'!
test09aPortfolioTransactionsIsSumOfItsAccountsTransactions

	|  portfolio composedPortfolio composedPortfolioTransactions  account anotherAccount accountTransaction anotherAccountTransaction  |
	
	account := ReceptiveAccount new.
	accountTransaction := Deposit register: 10 on: account .
	portfolio := Portfolio with: account .
	anotherAccount := ReceptiveAccount new.
	anotherAccountTransaction := Withdraw register: 10 on: anotherAccount .
	composedPortfolio := Portfolio with: portfolio with: anotherAccount .
	
	composedPortfolioTransactions := composedPortfolio transactions.
	
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: accountTransaction ).
	self assert: (composedPortfolioTransactions includes: anotherAccountTransaction ).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'CD 5/20/2021 20:42:51'!
test10aPortfolioCannotContainTheSameAccountTwice

	| aPortfolio anAccount |
	anAccount := ReceptiveAccount new.
	Deposit register: 10 on: anAccount.
	aPortfolio := Portfolio with: anAccount.
	
	self 
		should: [ aPortfolio add: anAccount ] 
		raise: Error 
		withMessageText: Portfolio errorMessageAlreadyAddedAccount.
	
 
	

	
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'CD 5/20/2021 20:52:33'!
test11aPortfolioCannotContainItself

	| aPortfolio anAccount |
	anAccount := ReceptiveAccount new.
	Deposit register: 10 on: anAccount.
	aPortfolio := Portfolio with: anAccount.
	
	self 
		should: [ aPortfolio add: aPortfolio ] 
		raise: Error 
		withMessageText: Portfolio errorMessageAlreadyAddedAccount.
	
 
	

	
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'CD 5/20/2021 20:57:38'!
test12aPortfolioCannotAddAccountOwnedByIncludedPortfolio

	| aComposedPortfolio aPortfolio anAccount |
	anAccount := ReceptiveAccount new.
	Deposit register: 10 on: anAccount.
	aPortfolio := Portfolio with: anAccount.
	aComposedPortfolio := Portfolio with: aPortfolio.
	
	self 
		should: [ aComposedPortfolio add: anAccount ] 
		raise: Error 
		withMessageText: Portfolio errorMessageAlreadyAddedAccount.
	
 
	

	
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'CD 5/24/2021 07:49:40'!
test13aPortfolioCannotHaveAncestorPortfolioAccount

	| account portfolio ancestorPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	ancestorPortfolio := Portfolio with: portfolio.
	ancestorPortfolio add: account.
	
	self 
		should: [portfolio add: account] 
		raise: Error 
		withMessageText: Portfolio errorMessageAlreadyAddedAccount.
	
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


!classDefinition: #Account category: 'Portfolio-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Account methodsFor: 'as yet unclassified' stamp: 'CD 5/20/2021 20:34:46'!
addAllTransactionsTo: transactionsCollection

	^ self subclassResponsibility.! !

!Account methodsFor: 'as yet unclassified' stamp: 'CD 5/24/2021 07:54:02'!
addAsParent: account

	^ self subclassResponsibility.! !

!Account methodsFor: 'as yet unclassified' stamp: 'CD 5/20/2021 20:32:38'!
balance

	^ self subclassResponsibility.! !

!Account methodsFor: 'as yet unclassified' stamp: 'CD 5/24/2021 07:54:34'!
has: account

	^ self subclassResponsibility.! !

!Account methodsFor: 'as yet unclassified' stamp: 'CD 5/20/2021 20:33:15'!
hasRegistered: anAccount

	^ self subclassResponsibility.! !

!Account methodsFor: 'as yet unclassified' stamp: 'CD 5/20/2021 20:32:52'!
transactions
	
	^ self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'CD 5/18/2021 18:48:37'!
balance

	^ accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'CD 5/24/2021 07:55:46'!
canAddAccount: account

	(self anyAncestorHas: account) ifTrue: [self error: Portfolio errorMessageAlreadyAddedAccount ].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'CD 5/19/2021 20:06:24'!
hasRegistered: aTransaction

	^ accounts anySatisfy: [ :anAccount | (anAccount hasRegistered: aTransaction) ].! !


!Portfolio methodsFor: 'initializers' stamp: 'CD 5/24/2021 07:50:51'!
initialize

	accounts := OrderedCollection new.
	parents := Set new.! !


!Portfolio methodsFor: 'accounts' stamp: 'CD 5/24/2021 07:52:36'!
add: account
	
	self canAddAccount: account.
	accounts add: account.
	account addAsParent: self.! !


!Portfolio methodsFor: 'transactions' stamp: 'CD 5/19/2021 20:32:55'!
addAllTransactionsTo: transactionsCollection

	accounts do: [ :anAccount | anAccount addAllTransactionsTo: transactionsCollection ].! !

!Portfolio methodsFor: 'transactions' stamp: 'CD 5/20/2021 20:34:12'!
transactions

	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addAllTransactionsTo: transactions].
	
	^ transactions.! !


!Portfolio methodsFor: 'auxiliars' stamp: 'CD 5/23/2021 18:04:11'!
addAncestorsTo: anAncestorsCollection

	parents 
		ifEmpty: [ anAncestorsCollection add: self ] 
		ifNotEmpty: [ parents do: [ :parent | parent addAncestorsTo: anAncestorsCollection ]].! !

!Portfolio methodsFor: 'auxiliars' stamp: 'CD 5/24/2021 07:52:57'!
addAsParent: account

	parents add: account.! !

!Portfolio methodsFor: 'auxiliars' stamp: 'CD 5/23/2021 18:02:38'!
ancestors

	| ancestors |
	
	ancestors := OrderedCollection new.
	self addAncestorsTo: ancestors.
	
	^ ancestors.! !

!Portfolio methodsFor: 'auxiliars' stamp: 'CD 5/23/2021 17:59:10'!
anyAncestorHas: account

	^ self ancestors anySatisfy: [ :anAncestor | anAncestor has: account].! !

!Portfolio methodsFor: 'auxiliars' stamp: 'CD 5/24/2021 07:46:34'!
has: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :account | (account has: anAccount) or: [anAccount has: account]]].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'initializers' stamp: 'CD 5/18/2021 19:10:12'!
with: account

	^ Portfolio new add: account.! !

!Portfolio class methodsFor: 'initializers' stamp: 'CD 5/18/2021 19:13:47'!
with: anAccount with: anotherAccount

	^ (self new 
		add: anAccount)
		add: anotherAccount.! !


!Portfolio class methodsFor: 'error-messages' stamp: 'CD 5/20/2021 20:41:59'!
errorMessageAlreadyAddedAccount

	^ 'Cannot add already existing account on this portfolio'.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'CD 5/19/2021 20:24:12'!
addAllTransactionsTo: transactionsCollection

	transactionsCollection addAll: transactions.! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'CD 5/17/2021 21:16:23'!
balance
	
	^ transactions inject: 0 into: [:temporalBalance :transaction | transaction updateBalance: temporalBalance]. 
! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'auxiliars' stamp: 'CD 5/24/2021 07:53:11'!
addAsParent: account

	! !

!ReceptiveAccount methodsFor: 'auxiliars' stamp: 'CD 5/23/2021 18:06:33'!
has: anAccount

	^ self = anAccount.! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'CD 5/17/2021 21:16:40'!
updateBalance: aBalance

	^ self subclassResponsibility. ! !

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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'CD 5/17/2021 21:18:13'!
updateBalance: aBalance

	^ aBalance + value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'CD 5/17/2021 21:18:08'!
updateBalance: aBalance

	^ aBalance - value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !
