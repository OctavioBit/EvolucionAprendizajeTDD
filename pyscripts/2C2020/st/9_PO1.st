!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'accessing' stamp: 'MS 11/2/2020 19:54:41'!
test01PortfolioHasZeroAsBalanceWhenCreated 

	| aPortfolio |
	
	aPortfolio := Portfolio new.

	self assert: 0 equals: aPortfolio balance.
! !

!PortfolioTest methodsFor: 'accessing' stamp: 'MS 11/2/2020 21:00:07'!
test03PortfolioKnowsRegisteredTransactions 

	| aPortfolio  account deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	
	aPortfolio := Portfolio  new.
	aPortfolio add: account.
		
	self assert: (aPortfolio hasRegistered: deposit).! !

!PortfolioTest methodsFor: 'accessing' stamp: 'MS 11/3/2020 16:46:34'!
test04PortfolioDoesNotKnowNotRegisteredTransactions

	| deposit withdraw account aPortfolio |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
	
	aPortfolio := Portfolio  new.
	aPortfolio add: account.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!PortfolioTest methodsFor: 'accessing' stamp: 'MS 11/8/2020 17:05:08'!
test05PortfolioKnowsItsTransactions 

	| account deposit aPortfolio|
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 50 on: account.
	
	aPortfolio := Portfolio  new.
	aPortfolio add: account.
		
	self assert: 1 equals: aPortfolio transactions size.
	self assert: (aPortfolio transactions includes: deposit).
! !


!PortfolioTest methodsFor: 'actions' stamp: 'MS 11/2/2020 20:45:28'!
test02AddingAccountChangesBalanceByAccountBalance

	| aPortfolio  account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	aPortfolio := Portfolio  new.
	
	aPortfolio add: account.
		
	self assert: 100 equals: aPortfolio balance.


! !

!PortfolioTest methodsFor: 'actions' stamp: 'MS 11/3/2020 17:08:59'!
test06AddingPortfolioChangesBalanceByPortfolioBalance

	| aPortfolio aBiggerPortfolio account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	
	aPortfolio := Portfolio  new.
	aBiggerPortfolio := Portfolio  new.
	
	aPortfolio add: account.
	aBiggerPortfolio add: aPortfolio.
		
	self assert: 100 equals: aBiggerPortfolio balance.


! !

!PortfolioTest methodsFor: 'actions' stamp: 'MS 11/8/2020 16:52:10'!
test07AddingPortfolioDoesNotAddAccountsItAlreadyHas

	| aPortfolio aBiggerPortfolio account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	
	aPortfolio := Portfolio  new.
	aBiggerPortfolio := Portfolio  new.
	
	aPortfolio add: account.
	aBiggerPortfolio add: account.
	aBiggerPortfolio add: aPortfolio.
		
	self assert: 100 equals: aBiggerPortfolio balance.
	self assert: 1 equals: aBiggerPortfolio transactions size.
! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
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


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'MS 11/2/2020 19:39:32'!
accountForBalance
	
	self subclassResponsibility.! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'MS 11/2/2020 20:44:02'!
accountForBalance: balance
	^balance + self value.! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'MS 11/2/2020 20:36:22'!
accountForBalance: balance
	^balance - self value.! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'accessing' stamp: 'MS 11/3/2020 18:32:40'!
balance
       |balance|

	balance:= 0.	

	self transactions sum: [ :anItem | balance:= anItem accountForBalance: balance] ifEmpty: [ 0 ].
	
	^balance.! !

!Portfolio methodsFor: 'accessing' stamp: 'MS 11/8/2020 17:12:35'!
transactions
	
	|allTransactions|
	allTransactions := OrderedCollection new.

	allTransactions:=  self addUniqueTransactions: allTransactions.

	^allTransactions.
	! !


!Portfolio methodsFor: 'actions' stamp: 'MS 11/3/2020 17:10:33'!
add: anItem 
	
	contents add: anItem.! !

!Portfolio methodsFor: 'actions' stamp: 'MS 11/8/2020 17:12:35'!
addUniqueTransactions: aTransactionList
	
	|newTransactions|
	newTransactions := aTransactionList .

	contents do: [:anItem | newTransactions := anItem addUniqueTransactions: aTransactionList].

	^newTransactions.! !

!Portfolio methodsFor: 'actions' stamp: 'MS 11/3/2020 17:38:36'!
contents 
	
	^contents.! !

!Portfolio methodsFor: 'actions' stamp: 'MS 11/8/2020 17:06:59'!
hasRegistered: aDeposit 
	^ (contents select: [:anItem | anItem hasRegistered: aDeposit]) size = 1.! !


!Portfolio methodsFor: 'intialization' stamp: 'MS 11/2/2020 20:51:52'!
initialize

	contents := OrderedCollection new.! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
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


!ReceptiveAccount methodsFor: 'balance' stamp: 'MS 11/2/2020 20:43:10'!
balance
	
	|balance|

	balance:= 0.
	transactions do: [ :aTransaction | balance := aTransaction accountForBalance: balance].
	^balance.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'MS 11/8/2020 17:12:34'!
addUniqueTransactions: aTransactionList 
	|newTransactions result|
	
	newTransactions:= self transactions reject: [:aTransaction| aTransactionList includes: aTransaction].  
	
	result :=  aTransactionList copy. 
	result addAll: newTransactions.
	^result.! !
