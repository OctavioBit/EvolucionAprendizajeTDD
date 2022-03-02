!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'f 5/22/2021 15:11:55'!
test01newPortfolioBalanceEqualsCero

	|newPortfolio|
	newPortfolio := Portfolio new.
	self assert: newPortfolio balance equals: 0.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'f 5/22/2021 15:15:11'!
test02PortfolioBalancewithOneaccount

	|newPortfolio  account|
	
	newPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	newPortfolio add: account.
	self assert: newPortfolio balance equals: 50.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'f 5/22/2021 15:21:11'!
test03PortfolioBalancewithTwoAccounts

	|newPortfolio  account account2|
	
	newPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Deposit register: 50 on: account2.
	Withdraw register: 50 on: account.
	newPortfolio add: account.
	newPortfolio add: account2.
	self assert: newPortfolio balance equals: 100.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'f 5/22/2021 15:27:36'!
test04PortfolioBalancewith1account1EmptyPortfolio

	|newPortfolio  account portfolio2 |
	
	newPortfolio := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	newPortfolio add: account.
	
	newPortfolio add: portfolio2.
	self assert: newPortfolio balance equals: 50.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'f 5/22/2021 15:29:51'!
test05PortfolioBalancewith1account1Portfolio

	|newPortfolio  account  account2 portfolio2 |
	
	newPortfolio := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	account2:= ReceptiveAccount new.
	Deposit register: 100 on: account2.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	newPortfolio add: account.
	portfolio2 add: account2.
	newPortfolio add: portfolio2.
	self assert: newPortfolio balance equals: 150.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'f 5/22/2021 15:59:53'!
test06PortfolioTransactionwith1account1Portfolio

	|newPortfolio  account  account2 portfolio2 transactions|
	
	newPortfolio := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	account2:= ReceptiveAccount new.
	transactions:= OrderedCollection  new.
	
	transactions add:(Withdraw register: 50 on: account).
	transactions add:(Deposit register: 100 on: account).
	transactions add:(Deposit register: 100 on: account2).
	
	
	newPortfolio add: account.
	portfolio2 add: account2.
	newPortfolio add: portfolio2.
	
	self assert: newPortfolio transactions equals: transactions.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'f 5/22/2021 16:05:02'!
test07PortfolioRegistersTransaction

	|newPortfolio  account  account2 portfolio2 transaction|
	
	newPortfolio := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	account2:= ReceptiveAccount new.
	
	
	transaction :=(Withdraw register: 50 on: account).
	Deposit register: 100 on: account.
	Deposit register: 100 on: account2.
	
	
	newPortfolio add: account.
	portfolio2 add: account2.
	newPortfolio add: portfolio2.
	
	self assert: (newPortfolio hasRegistered: transaction).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'f 5/22/2021 16:13:23'!
test08PortfolioDoesntaddDuplicatedAccount

	|newPortfolio  account   portfolio2  |
	
	newPortfolio := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	
	Deposit register: 100 on: account.
	
	newPortfolio add: account.
	portfolio2 add: account.
	
	
		self should: [newPortfolio add: portfolio2.]
		 raise:  Error
		withMessageText: Portfolio duplicatedAccountNotValid.! !


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

!Deposit methodsFor: 'value' stamp: 'f 5/22/2021 15:07:59'!
valueForBalance

	^value! !

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


!Withdraw methodsFor: 'value' stamp: 'f 5/22/2021 15:07:25'!
value

	^ value.! !

!Withdraw methodsFor: 'value' stamp: 'f 5/22/2021 15:07:40'!
valueForBalance

	^ value negated! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accountsorPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'f 5/22/2021 16:21:35'!
accounts

	    |accounts accountsPortfolio|

	accounts := OrderedCollection  new.
	1 to: (accountsorPortfolios size) do: [:a | accountsPortfolio := ((accountsorPortfolios at: a) accounts).
		1 to: (accountsPortfolio  size) do: [:b| accounts  add: (accountsPortfolio  at:b).].
		]. 
	
	^accounts.
	! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'f 5/22/2021 16:29:33'!
add: accountorPortfolio
        
	|accounts| 
	accounts :=self accounts.
	
       1 to: ((accountorPortfolio accounts) size) do:[: a |(accounts includes: ((accountorPortfolio accounts)at: a)) ifTrue: [^self raiseCantAddDuplicatedAccountError].].
               
       
	accountsorPortfolios add: accountorPortfolio.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'f 5/22/2021 15:19:44'!
balance
	
	^accountsorPortfolios sum: [ :anAccountOrPortfolio | anAccountOrPortfolio balance ] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'f 5/22/2021 16:05:55'!
hasRegistered: aTransaction
	^((self transactions) includes: aTransaction)! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'f 5/22/2021 15:18:05'!
initialize


	accountsorPortfolios := OrderedCollection  new.
! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'f 5/22/2021 16:18:09'!
raiseCantAddDuplicatedAccountError

	^self error: self class duplicatedAccountNotValid.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'f 5/22/2021 15:51:10'!
transactions
    |transactions accountTransactions|

	transactions := OrderedCollection  new.
	1 to: (accountsorPortfolios size) do: [:a | accountTransactions := ((accountsorPortfolios at: a) transactions).
		1 to: (accountTransactions  size) do: [:b| transactions  add: (accountTransactions  at:b).].
		]. 
	
	^transactions.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'f 5/22/2021 16:18:42'!
duplicatedAccountNotValid

	^'Cant add an Account thats already in the portfolio'.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'f 5/22/2021 15:17:28'!
initialize

	^self new initialize.! !


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


!ReceptiveAccount methodsFor: 'balance' stamp: 'f 5/22/2021 15:07:10'!
balance

	^transactions sum: [ :aTransaction | aTransaction valueForBalance ] ifEmpty: [ 0 ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'f 5/22/2021 16:23:21'!
accounts
	^(OrderedCollection with: self)! !

Portfolio initialize!