!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'FC 11/2/2020 19:25:38'!
test01PortfolioHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := Portfolio new.

	self assert: 0 equals: account balance.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'FC 11/2/2020 19:28:16'!
test02PortfolioHaveBalanceOfAddedReceptiveAccount 

	| account receptiveAccount |
	
	account := Portfolio new.
	receptiveAccount := ReceptiveAccount new.
	Deposit register: 100 on: receptiveAccount.
	account add: receptiveAccount.
	self assert: receptiveAccount balance equals: account balance.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'FC 11/2/2020 20:31:27'!
test03PortfolioHaveBalanceOfManyAddedReceptiveAccounts

	| account receptiveAccount aPortfolio portfolioReceptiveAccount |
	
	account := Portfolio new.
	receptiveAccount := ReceptiveAccount new.
	aPortfolio := Portfolio new.
	portfolioReceptiveAccount := ReceptiveAccount new.
	
	Deposit register: 100 on: receptiveAccount.
	Deposit register: 150 on: portfolioReceptiveAccount.
	
	aPortfolio add: portfolioReceptiveAccount.
	
	account add: receptiveAccount.
	account add: aPortfolio.
	
	self assert: 250 equals: account balance.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'FC 11/2/2020 20:19:25'!
test04PortfolioKnowsRegisteredTransactionsOfAnAccount 

	| account receptiveAccount deposit |
	
	account := Portfolio new.
	receptiveAccount := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: receptiveAccount.
	
	account add: receptiveAccount.
	
	self assert: (account hasRegistered: deposit).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'FC 11/2/2020 20:24:22'!
test05PortfolioKnowsRegisteredTransactionsOfManyAccounts 

	| account aPortfolio receptiveAccount deposit anotherDeposit 
	portfolioReceptiveAccount |
	
	account := Portfolio new.
	receptiveAccount := ReceptiveAccount new.
	aPortfolio := Portfolio new.
	portfolioReceptiveAccount := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: receptiveAccount.
	anotherDeposit := Deposit register: 150 on: portfolioReceptiveAccount.
	
	aPortfolio add: portfolioReceptiveAccount.
	
	account add: receptiveAccount.
	account add: aPortfolio.
	
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: anotherDeposit).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'FC 11/2/2020 20:19:33'!
test06PortfolioDoesNotKnowNotRegisteredTransactionsOfItsAccounts 

	| account receptiveAccount deposit |
	
	account := Portfolio new.
	receptiveAccount := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: receptiveAccount.
	
	
	self deny: (account hasRegistered: deposit).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'FC 11/2/2020 20:19:40'!
test07PortfolioKnowsItsTransactions 

	| account receptiveAccount deposit |
	
	account := Portfolio new.
	receptiveAccount := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: receptiveAccount.
	
	account add: receptiveAccount.
	
	self assert: account transactions size equals: 1.
	self assert: (account transactions includes: deposit).

! !

!PortfolioTest methodsFor: 'tests' stamp: 'FC 11/2/2020 20:19:45'!
test08PortfolioKnowsTransactionsOfMoreThanOneAccount 

	| account receptiveAccount deposit anotherReceptiveAccount anotherDeposit |
	
	account := Portfolio new.
	receptiveAccount := ReceptiveAccount new.
	anotherReceptiveAccount := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: receptiveAccount.
	anotherDeposit := Deposit register: 200 on: anotherReceptiveAccount.
	
	account add: receptiveAccount.
	account add: anotherReceptiveAccount.
	
	self assert: account transactions size equals: 2.
	self assert: (account transactions includes: deposit).
	self assert: (account transactions includes: anotherDeposit).

! !

!PortfolioTest methodsFor: 'tests' stamp: 'FC 11/2/2020 20:36:40'!
test09CantAddSameReceptiveAccountTwiceOnPortfolio
	| account  receptiveAccount |
	
	account := Portfolio new.
	receptiveAccount := ReceptiveAccount new.
	
	account add: receptiveAccount.
	
	self should: [account add: receptiveAccount ] raise: Error withMessageText: Portfolio duplicateAccountMessage.
	

! !

!PortfolioTest methodsFor: 'tests' stamp: 'FC 11/2/2020 20:45:58'!
test10CantAddSameReceptiveAccountTwiceOnDifferentLevels
	| account receptiveAccount aPortfolio |
	
	account := Portfolio new.
	aPortfolio := Portfolio new.
	receptiveAccount := ReceptiveAccount new.
	
	aPortfolio add: receptiveAccount.
	account add: aPortfolio.
	
	self should: [account add: receptiveAccount ] raise: Error withMessageText: Portfolio duplicateAccountMessage.
	

! !

!PortfolioTest methodsFor: 'tests' stamp: 'FC 11/2/2020 20:47:51'!
test11PortfolioCantAddToItself
	| account |
	
	account := Portfolio new.
	
	self should: [	account add: account.] raise: Error withMessageText: Portfolio duplicateAccountMessage.
	

! !

!PortfolioTest methodsFor: 'tests' stamp: 'FC 11/2/2020 21:06:01'!
test12PortfolioCantAddToItselfOnChild
	| account aPortfolio |
	
	account := Portfolio new.
	aPortfolio := Portfolio new.
	account add: aPortfolio.
	
	self should: [	aPortfolio add: account.] raise: Error withMessageText: Portfolio duplicateAccountMessage.
	

! !

!PortfolioTest methodsFor: 'tests' stamp: 'FC 11/4/2020 18:00:40'!
test13PortfolioCantAddAccountWhenParentHasIt
	| account receptiveAccount aPortfolio |
	
	account := Portfolio new.
	aPortfolio := Portfolio new.
	receptiveAccount := ReceptiveAccount new.

	account add: receptiveAccount.
	account add: aPortfolio.

	self should: [	aPortfolio add: receptiveAccount ] raise: Error withMessageText: Portfolio duplicateAccountMessage.
	

! !

!PortfolioTest methodsFor: 'tests' stamp: 'FC 11/4/2020 18:05:26'!
test14PortfolioCantAddAccountWhenManyParentsHasIt
	| rootPortfolio1 receptiveAccount rootPortfolio2  childPortfolio grandChildPortfolio|
	
	rootPortfolio1 := Portfolio new.
	rootPortfolio2 := Portfolio new.
	childPortfolio := Portfolio new.
	grandChildPortfolio := Portfolio new.
	receptiveAccount := ReceptiveAccount new.
		
	rootPortfolio1 add: childPortfolio.
	rootPortfolio2 add: childPortfolio.
	childPortfolio add: receptiveAccount.
	childPortfolio add: grandChildPortfolio.

	self should: [	grandChildPortfolio add: receptiveAccount ] raise: Error withMessageText: Portfolio duplicateAccountMessage.
	

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


!classDefinition: #Account category: 'Portfolio-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Account methodsFor: 'balance' stamp: 'FC 11/2/2020 20:52:39'!
balance
	self subclassResponsibility.! !


!Account methodsFor: 'testing' stamp: 'FC 11/2/2020 20:52:30'!
hasRegistered: aTransaction
	self subclassResponsibility.! !


!Account methodsFor: 'transactions' stamp: 'FC 11/2/2020 20:52:54'!
transactions
	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'testing - private' stamp: 'FC 11/2/2020 20:48:44'!
isPresent: anAccount
	^self = anAccount or: [ accounts anySatisfy: [ :account | account isPresent: anAccount ]]! !

!Portfolio methodsFor: 'testing - private' stamp: 'FC 11/4/2020 17:57:57'!
validateAdd: anAccount

	^ (self roots anySatisfy: [ :aRoot | aRoot isPresent: anAccount ])		ifTrue: [self error: self class duplicateAccountMessage ]. 
	! !


!Portfolio methodsFor: 'transactions' stamp: 'FC 11/2/2020 19:45:57'!
transactions
	^accounts inject: #() into: [ :transactions :anAccount | transactions,anAccount transactions] . ! !


!Portfolio methodsFor: 'parent - private' stamp: 'FC 11/4/2020 17:47:40'!
roots
	parents isEmpty ifTrue: [^Array with: self].
	^parents inject: #() into: [ :roots :aParent |  roots , aParent roots  ]! !


!Portfolio methodsFor: 'adding' stamp: 'FC 11/4/2020 17:41:05'!
add: anAccount

	self validateAdd: anAccount.
	anAccount addParent: self.
	
	accounts add: anAccount.! !


!Portfolio methodsFor: 'initialization' stamp: 'FC 11/4/2020 17:31:55'!
initialize
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'FC 11/2/2020 19:32:42'!
balance
	^accounts sum: [:anAccount | anAccount balance ] ifEmpty: [0]! !


!Portfolio methodsFor: 'testing' stamp: 'FC 11/2/2020 19:39:08'!
hasRegistered: aTransaction
	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ].! !


!Portfolio methodsFor: 'adding - private' stamp: 'FC 11/4/2020 17:35:32'!
addParent: anAccount
	parents add: anAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error' stamp: 'FC 11/2/2020 20:37:11'!
duplicateAccountMessage
	^'Cuenta ya presente en el Portfolio'.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'balance - private' stamp: 'FC 11/2/2020 20:01:12'!
addDeposit: aDeposit
	^ aDeposit value.! !

!ReceptiveAccount methodsFor: 'balance - private' stamp: 'FC 11/2/2020 20:01:33'!
addWithdraw: aWithdrawal
	^ aWithdrawal value * -1.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'FC 11/2/2020 20:01:59'!
balance

	^transactions sum: [ :aTransaction | 
		aTransaction addBalanceFor: self.] ifEmpty: [ 0 ]! !


!ReceptiveAccount methodsFor: 'testing - private' stamp: 'FC 11/2/2020 20:44:24'!
isPresent: anAccount
	^anAccount = self.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'adding - private' stamp: 'FC 11/4/2020 17:34:56'!
addParent: anAccount! !


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


!Deposit methodsFor: 'Account Interaction - private' stamp: 'FC 11/2/2020 20:00:02'!
addBalanceFor: anAccount

	^ anAccount addDeposit: self.! !

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


!Withdraw methodsFor: 'Account Interaction - private' stamp: 'FC 11/2/2020 20:00:38'!
addBalanceFor: anAccount

	^ anAccount addWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !
