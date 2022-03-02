!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'portfolio account transaction childPortfolio parentPortfolio grandchildPortfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'setUp' stamp: 'as 11/7/2020 18:42:31'!
setUp
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	transaction := Deposit register: 100 on: account.
	childPortfolio := Portfolio new.
	parentPortfolio := Portfolio new.
	grandchildPortfolio := Portfolio new.! !


!PortfolioTest methodsFor: 'one level portfolio tests' stamp: 'as 11/7/2020 18:28:05'!
test01NewPortfolioHasBalanceZero
	self assert: portfolio balance equals: 0.! !

!PortfolioTest methodsFor: 'one level portfolio tests' stamp: 'as 11/7/2020 18:39:43'!
test02PortfolioWithOneAccountHasSameBalanceAsAccount
	portfolio add: account.
	self assert: portfolio balance equals: account balance.! !

!PortfolioTest methodsFor: 'one level portfolio tests' stamp: 'as 11/7/2020 18:40:49'!
test03PortfolioWithTwoAccountsHasTheAccumulatedBalanceOfTheAccounts
	| account2 |
	account2 := ReceptiveAccount new.
	Deposit register: 100 on: account2.
	portfolio add: account.
	portfolio add: account2.
	self assert: portfolio balance equals: account balance + account2 balance.! !

!PortfolioTest methodsFor: 'one level portfolio tests' stamp: 'as 11/7/2020 18:41:05'!
test04PortfolioWithOneTransactionAccountHasSameTransactionsRegistered
	portfolio add: account.
	self assert: (portfolio hasRegistered: transaction).! !

!PortfolioTest methodsFor: 'one level portfolio tests' stamp: 'as 11/7/2020 18:44:53'!
test05PortfolioHasNotRegisteredTransactionNotRegisteredInItsAccount
	portfolio add: ReceptiveAccount new.
	self deny: (portfolio hasRegistered: transaction).! !

!PortfolioTest methodsFor: 'one level portfolio tests' stamp: 'as 11/7/2020 18:28:34'!
test06NewPortfolioHasNoTransactions	
	self assert: portfolio transactions isEmpty.! !

!PortfolioTest methodsFor: 'one level portfolio tests' stamp: 'as 11/7/2020 18:41:23'!
test07PortfolioWithOneTransactionReturnsTransaction
	portfolio add: account.
	self assert: (portfolio transactions includes: transaction).! !

!PortfolioTest methodsFor: 'one level portfolio tests' stamp: 'as 11/7/2020 18:41:34'!
test08PortfolioDoesntAddAccountThatAlreadyIsOnPortfolio
	portfolio add: account.
	self
		should: [ portfolio add: account ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio elementAlreadyInPortfolioErrorDescription ]
		! !


!PortfolioTest methodsFor: 'multilevel portfolio tests' stamp: 'as 11/7/2020 18:45:21'!
test09PortfolioDoesntAddAccountPresentOnChildPortfolio
	childPortfolio add: account.
	parentPortfolio add: childPortfolio.
	
	self
		should: [ parentPortfolio add: account ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio elementAlreadyInPortfolioErrorDescription ]
		! !

!PortfolioTest methodsFor: 'multilevel portfolio tests' stamp: 'as 11/7/2020 18:43:03'!
test10PortfolioDoesntAddAccountPresentOnGrandchildPortfolio
	grandchildPortfolio add: account.	
	childPortfolio add: grandchildPortfolio.
	parentPortfolio add: childPortfolio.
	
	self
		should: [ parentPortfolio add: account ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio elementAlreadyInPortfolioErrorDescription ]
		! !

!PortfolioTest methodsFor: 'multilevel portfolio tests' stamp: 'as 11/7/2020 18:43:17'!
test11PortfolioDoesntAddAccountPresentOnPortfolioTree
	parentPortfolio add: childPortfolio.
	parentPortfolio add: account.
	
	self
		should: [ childPortfolio add: account ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio elementAlreadyInPortfolioErrorDescription ]
		! !

!PortfolioTest methodsFor: 'multilevel portfolio tests' stamp: 'as 11/7/2020 18:43:28'!
test12PortfolioContainingAnAlreadyPresentAccountIsntAddedToOriginalPortfolio
	parentPortfolio add: account.
	childPortfolio add: account.
	
	self
		should: [ parentPortfolio add: childPortfolio ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio elementAlreadyInPortfolioErrorDescription ]
		! !

!PortfolioTest methodsFor: 'multilevel portfolio tests' stamp: 'as 11/8/2020 10:25:11'!
test13PortfolioDoesntAddPortfolioAlreadyPresent

	parentPortfolio add: childPortfolio.
	
	self
		should: [childPortfolio  add: parentPortfolio]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio elementAlreadyInPortfolioErrorDescription ]
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

!AccountTransaction methodsFor: 'value' stamp: 'as 11/7/2020 18:18:19'!
value 
	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'RL 11/2/2020 20:36:04'!
accumulateTo: aBalance
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


!Deposit methodsFor: 'as yet unclassified' stamp: 'RL 11/2/2020 20:36:33'!
accumulateTo: aBalance
	^aBalance + value.! !

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


!Withdraw methodsFor: 'as yet unclassified' stamp: 'RL 11/2/2020 20:36:42'!
accumulateTo: aBalance
	^aBalance - value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #BankAsset category: 'Portfolio-Ejercicio'!
Object subclass: #BankAsset
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!BankAsset methodsFor: 'private operations' stamp: 'as 11/8/2020 10:34:48'!
addParent: aPortfolio
	self subclassResponsibility.! !

!BankAsset methodsFor: 'private operations' stamp: 'as 11/8/2020 10:33:58'!
validateAssetNotPresentInChildren: anAsset
	self subclassResponsibility.! !


!BankAsset methodsFor: 'public interface' stamp: 'as 11/8/2020 10:36:06'!
balance
	self subclassResponsibility.! !

!BankAsset methodsFor: 'public interface' stamp: 'as 11/8/2020 10:36:24'!
hasRegistered: aTransaction
	self subclassResponsibility.! !

!BankAsset methodsFor: 'public interface' stamp: 'as 11/8/2020 10:36:57'!
transactions
	self subclassResponsibility.! !


!BankAsset methodsFor: 'initialization' stamp: 'as 11/8/2020 10:37:02'!
initialize
	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
BankAsset subclass: #Portfolio
	instanceVariableNames: 'assets parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'validation' stamp: 'as 11/7/2020 18:06:15'!
validateAssetNotPresentInChildren: anAsset
	self validateStartingFrom: assets asset: anAsset.! !

!Portfolio methodsFor: 'validation' stamp: 'as 11/7/2020 18:06:00'!
validateAssetSetWhenAddingTo: aPortfolio
	assets do: [:asset | aPortfolio validateTreeDoesntContain: asset.]! !

!Portfolio methodsFor: 'validation' stamp: 'as 11/8/2020 10:24:25'!
validateStartingFrom: aPortfolioSet asset: anAsset
	aPortfolioSet do: [:elem | 
		elem = anAsset ifTrue: [^Error signal: self class elementAlreadyInPortfolioErrorDescription ].
		elem validateAssetNotPresentInChildren: anAsset
		].! !

!Portfolio methodsFor: 'validation' stamp: 'as 11/7/2020 18:06:15'!
validateTreeDoesntContain: anAsset	
	self validateStartingFrom: self roots asset: anAsset.! !


!Portfolio methodsFor: 'initialization' stamp: 'as 11/7/2020 16:50:06'!
initialize
	assets := OrderedCollection new.
	parents  := OrderedCollection new.! !


!Portfolio methodsFor: 'public interface' stamp: 'as 11/8/2020 10:43:51'!
add: anAsset

	self validateTreeDoesntContain: anAsset.

	anAsset validateAssetSetWhenAddingTo: self.
	
	assets add: anAsset.
	
	anAsset addParent: self.! !

!Portfolio methodsFor: 'public interface' stamp: 'as 11/7/2020 12:23:33'!
balance
	^assets sum: [ :anAccount | anAccount balance ] ifEmpty: [0]! !

!Portfolio methodsFor: 'public interface' stamp: 'as 11/7/2020 17:27:46'!
hasRegistered: aTransaction
	assets detect: [:asset | asset hasRegistered: aTransaction] ifNone: [^false].	
	^true.! !

!Portfolio methodsFor: 'public interface' stamp: 'as 11/8/2020 10:45:36'!
transactions
	|allTransactions|
	allTransactions := OrderedCollection new.
	assets do: [:asset | allTransactions  := (asset transactions),allTransactions ].
	^allTransactions.! !


!Portfolio methodsFor: 'private operations' stamp: 'as 11/7/2020 16:44:16'!
addParent: aPortfolio
	parents add: aPortfolio.! !

!Portfolio methodsFor: 'private operations' stamp: 'as 11/7/2020 12:40:30'!
includesAsset: anAsset
	^assets includes: anAsset.! !

!Portfolio methodsFor: 'private operations' stamp: 'as 11/7/2020 17:49:32'!
roots
	|portfolioRoots|
	portfolioRoots := OrderedCollection new.
	parents ifEmpty: [^OrderedCollection with: self].
	parents do: [:aParent | portfolioRoots := aParent roots,portfolioRoots].
	^portfolioRoots.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'as 11/7/2020 12:33:46'!
elementAlreadyInPortfolioErrorDescription
	^'The element is already in the portfolio!!'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
BankAsset subclass: #ReceptiveAccount
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


!ReceptiveAccount methodsFor: 'private operations' stamp: 'as 11/8/2020 10:38:03'!
addParent: aPortfolio
	! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'RL 11/2/2020 20:38:19'!
balance
	| accumulatedBalance |
	accumulatedBalance := 0.
	transactions do: [ :aTransaction | 	accumulatedBalance := aTransaction accumulateTo: accumulatedBalance. 	].
	^accumulatedBalance ! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'validations' stamp: 'as 11/7/2020 12:58:05'!
validateAssetNotPresentInChildren: anAsset
	self = anAsset ifTrue: [^Error signal: Portfolio elementAlreadyInPortfolioErrorDescription ].! !

!ReceptiveAccount methodsFor: 'validations' stamp: 'as 11/8/2020 10:40:00'!
validateAssetSetWhenAddingTo: anAsset
! !
