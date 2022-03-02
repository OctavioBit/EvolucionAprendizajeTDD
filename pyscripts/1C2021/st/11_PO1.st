!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests - adding' stamp: 'ERMC 5/25/2021 20:07:53'!
test13APortfolioCanNotHaveDuplicatedAccount

	|aPortfolio  account |
	
	account _ ReceptiveAccount new.	
	aPortfolio _ Portfolio with: account.
	
	self should: [aPortfolio add: account ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anErrorMessage |
			self assert: Portfolio canNotAddDuplicatedAccountErrorMessage equals: anErrorMessage messageText]
 ! !

!PortfolioTest methodsFor: 'tests - adding' stamp: 'ERMC 5/25/2021 20:07:48'!
test14APortfolioCanNotIncludeItSelf

	|aPortfolio  account |
	
	account _ ReceptiveAccount new.	
	aPortfolio _ Portfolio with: account.
	
	self should: [aPortfolio add: aPortfolio] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anErrorMessage |
			self assert: Portfolio canNotAddDuplicatedAccountErrorMessage equals: anErrorMessage messageText]
 ! !

!PortfolioTest methodsFor: 'tests - adding' stamp: 'ERMC 5/25/2021 20:07:43'!
test15APortfolioWithManyAccountCanNotConteintDuplicatedAccount

	|aPortfolio  account mainPortfolio |
	
	account _ ReceptiveAccount new.	
	aPortfolio _ Portfolio with: account.
	
	mainPortfolio _ Portfolio with: aPortfolio.
	
	self should: [mainPortfolio add: account] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anErrorMessage |
			self assert: Portfolio canNotAddDuplicatedAccountErrorMessage equals: anErrorMessage messageText]
 ! !

!PortfolioTest methodsFor: 'tests - adding' stamp: 'ERMC 5/25/2021 20:07:37'!
test16APortfolioCanNotAddAPortfolioThatContaintsADuplicatedAccount

	|aPortfolio  account mainPortfolio |
	
	account _ ReceptiveAccount new.	
	mainPortfolio _ Portfolio with: account.
	
	aPortfolio _ Portfolio with: account.
			
	self should: [mainPortfolio add: aPortfolio] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anErrorMessage |
			self assert: Portfolio canNotAddDuplicatedAccountErrorMessage equals: anErrorMessage messageText]
 ! !

!PortfolioTest methodsFor: 'tests - adding' stamp: 'ERMC 5/25/2021 21:35:38'!
test17CanNotAddAnAccountIfAnyParentsHasIt

	|aPortfolio  account rootPortfolio |
	
	account _ ReceptiveAccount new.	
	aPortfolio _ Portfolio new.
	rootPortfolio _ Portfolio with: aPortfolio.
	rootPortfolio add: account. 
	
	self should: [aPortfolio add: account] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anErrorMessage |
			self assert: Portfolio canNotAddDuplicatedAccountErrorMessage equals: anErrorMessage messageText]
 ! !


!PortfolioTest methodsFor: 'tests - balance' stamp: 'ERMC 5/25/2021 18:20:14'!
test01APortfolioCanBeCreatedEmptyAndItBalanceIsZero
	| aPortfolio |
	
	aPortfolio _ Portfolio new.
	
	self assert: 0 equals: aPortfolio balance ! !

!PortfolioTest methodsFor: 'tests - balance' stamp: 'ERMC 5/25/2021 18:45:20'!
test02APortfolioWithOneAccountHasABalanceOfHisAccountBalance
	|portfolio|
	
	portfolio _ Portfolio with: (self createReceptiveAccountWith: (Deposit for: 50)).
		
	self assert: 50 equals: portfolio balance.
! !

!PortfolioTest methodsFor: 'tests - balance' stamp: 'ERMC 5/25/2021 19:50:33'!
test03APortfolioWithManyAccountsHasTheSumOTheAccountBalances
	 |portfolio account1 account2|
	 
	 account1 _ self createReceptiveAccountWith: (Deposit for: 50).
	 account2 _ self createReceptiveAccountWith: (Deposit for: 50).
	 portfolio _ Portfolio with: account1 .
	 portfolio add: account2.
	  
	 self assert: 100 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests - balance' stamp: 'ERMC 5/25/2021 19:53:06'!
test04APortfolioWithOnePortfolio
	|rootPortfolio aPortfolio|
	
	aPortfolio _ Portfolio with: (self createReceptiveAccountWith: (Deposit for: 50)).
	rootPortfolio _ Portfolio with: aPortfolio.
			
	self assert: 50 equals: rootPortfolio balance.
! !

!PortfolioTest methodsFor: 'tests - balance' stamp: 'ERMC 5/25/2021 19:54:10'!
test05APortfolioWithManyAccountHasTheSumOfTheBalance

	|rootPortfolio aPortfolio anotherPortfolio|
	
	aPortfolio _ Portfolio with: self createReceptiveAccountWithDepositAndWithdraw.
	anotherPortfolio _ Portfolio with: aPortfolio.
		
	rootPortfolio _ Portfolio with: anotherPortfolio. 
	rootPortfolio add: (self createReceptiveAccountWith: (Deposit for: 30)).
	
	self assert: 160 equals: rootPortfolio balance.
! !


!PortfolioTest methodsFor: 'tests - private' stamp: 'ERMC 5/25/2021 18:44:48'!
createReceptiveAccountWith: aTransaction

	|account|
	
	account _ ReceptiveAccount new.
	
	^account register: aTransaction
	! !

!PortfolioTest methodsFor: 'tests - private' stamp: 'ERMC 5/25/2021 18:23:39'!
createReceptiveAccountWithDepositAndWithdraw

	|account|
	
	account _ ReceptiveAccount new.
	Deposit register: 150 on: account.
	Withdraw register: 20 on: account.
	
	^account ! !


!PortfolioTest methodsFor: 'tests - hasRegistered' stamp: 'ERMC 5/25/2021 18:49:12'!
test06APortfolioWithOneAccountWithATransactionKnowsTransaction

	|aPortfolio aDeposit account |
	
	account _ ReceptiveAccount new.	
	aDeposit _ Deposit register: 150 on: account.
	aPortfolio _ Portfolio with: account .
	
	self assert: (aPortfolio hasRegistered: aDeposit)
! !

!PortfolioTest methodsFor: 'tests - hasRegistered' stamp: 'ERMC 5/25/2021 19:55:01'!
test07AnEmptyPortfolioDoNotKnowAnyTransaction

	|aPortfolio aDeposit |
	
	aDeposit _ Deposit for: 150.
	aPortfolio _ Portfolio new.
	
	self deny: (aPortfolio hasRegistered: aDeposit)
! !

!PortfolioTest methodsFor: 'tests - hasRegistered' stamp: 'ERMC 5/25/2021 19:59:57'!
test08APortfolioWithManyAccountsKnowsAccountTransactions

	 |aPortfolio aDeposit account aWithdraw account2 |
	 
	 account _ ReceptiveAccount new. 
	 aDeposit _ Deposit register: 150 on: account.
	 
	 account2 _ ReceptiveAccount new.
	 aWithdraw _ Withdraw register: 50 on: account2.  
	 
	 aPortfolio _ Portfolio with: account.
	 aPortfolio add: account2.

	 self assert: (aPortfolio hasRegistered: aDeposit).
	 self assert: (aPortfolio hasRegistered: aWithdraw).! !

!PortfolioTest methodsFor: 'tests - hasRegistered' stamp: 'ERMC 5/25/2021 20:01:23'!
test09APortfolioWithManyAccountsAndPortfolioKnowsAllTransaction

	|aPortfolio rootPortfolio aDeposit account aWithdraw account2 aDeposit2 |
	
	account _ ReceptiveAccount new.	
	aDeposit _ Deposit register: 150 on: account.
	aPortfolio _ Portfolio with: account.
	
	account2 _ ReceptiveAccount new.
	aDeposit2 _ Deposit register: 100 on: account2. 
	aWithdraw _ Withdraw register: 50 on: account2.  
	
	rootPortfolio _ Portfolio with: aPortfolio.
	rootPortfolio add: account2.
	
	self assert: (rootPortfolio hasRegistered: aDeposit).
	self assert: (rootPortfolio hasRegistered: aDeposit2).
	self assert: (rootPortfolio hasRegistered: aWithdraw).
! !


!PortfolioTest methodsFor: 'tests - transactions' stamp: 'ERMC 5/25/2021 20:02:27'!
test10APortfolioWithotAnAccountHasNotAnyTransaction

	|aPortfolio |
	
	aPortfolio _ Portfolio new.

	self assert: aPortfolio transactions isEmpty
! !

!PortfolioTest methodsFor: 'tests - transactions' stamp: 'ERMC 5/25/2021 20:02:34'!
test11APortfolioWithOneAccountHasCorrectTransactions

	|aPortfolio aPortfolioTransactions account deposit withdraw |
	
	account _ ReceptiveAccount new.
	deposit _ Deposit register: 100 on: account.
	withdraw _ Withdraw register: 50 on: account.
	
	aPortfolio _ Portfolio with: account. 
	aPortfolioTransactions _ aPortfolio transactions. 
	
	self assert: 2 equals: (aPortfolioTransactions) size.
	self assert: (aPortfolio transactions includes: deposit).
	self assert: (aPortfolio transactions includes: withdraw).
! !

!PortfolioTest methodsFor: 'tests - transactions' stamp: 'ERMC 5/25/2021 20:06:18'!
test12APortfolioWithManyAccountsReturnsAllTransactions

	|aPortfolio mainPortfolio aDeposit account aWithdraw account2 aPortfolioTransactions deposit2 |
	
	account _ ReceptiveAccount new.	
	aDeposit _ Deposit register: 150 on: account.
	aPortfolio _ Portfolio with: account.
	
	account2 _ ReceptiveAccount new.
	deposit2 _ Deposit register: 100 on: account2. 
	aWithdraw _ Withdraw register: 50 on: account2.  
	
	mainPortfolio _ Portfolio with: account2.
	mainPortfolio add: aPortfolio.
	
	aPortfolioTransactions _ mainPortfolio transactions.
	
	self assert: 3 equals: (aPortfolioTransactions) size.
	self assert: (mainPortfolio transactions includes: aDeposit).
	self assert: (mainPortfolio transactions includes: aWithdraw).
	self assert: (mainPortfolio transactions includes: deposit2).
	
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

!AccountTransaction methodsFor: 'value' stamp: 'ERMC 5/25/2021 23:04:47'!
affectBalance: aBalance

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


!Deposit methodsFor: 'value' stamp: 'ERMC 5/17/2021 22:05:47'!
addTo: aBalance
	
	^aBalance + value! !

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


!Withdraw methodsFor: 'value' stamp: 'ERMC 5/17/2021 22:05:31'!
addTo: aBalance
	
	^aBalance - value! !

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


!classDefinition: #BankAccount category: 'Portfolio-Ejercicio'!
Object subclass: #BankAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!BankAccount methodsFor: 'accesing' stamp: 'ERMC 5/25/2021 22:52:00'!
balance
	
	self subclassResponsibility ! !

!BankAccount methodsFor: 'accesing' stamp: 'ERMC 5/25/2021 22:52:16'!
hasRegistered: aTransaction
	
	self subclassResponsibility ! !


!BankAccount methodsFor: 'adding - private' stamp: 'ERMC 5/25/2021 22:52:38'!
isAnyAccountThatIncludes: anAccount 

	self subclassResponsibility ! !


!BankAccount methodsFor: 'adding' stamp: 'ERMC 5/25/2021 22:51:50'!
addAsParent: anAccount
	
	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
BankAccount subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'ERMC 5/25/2021 22:09:33'!
initialize
	
	accounts _ OrderedCollection new.
	parents _ OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'ERMC 5/25/2021 22:32:32'!
initializeWith: anAccount
	
	accounts _ OrderedCollection with: anAccount.
	anAccount addAsParent: self.! !


!Portfolio methodsFor: 'adding' stamp: 'ERMC 5/25/2021 23:06:01'!
add: anAccountToAdd 
	
	self assertCanAdd: anAccountToAdd. 
	accounts add: anAccountToAdd.
	anAccountToAdd addAsParent: self! !

!Portfolio methodsFor: 'adding' stamp: 'ERMC 5/25/2021 22:09:12'!
addAsParent: aPortfolio

	parents add: aPortfolio ! !


!Portfolio methodsFor: 'adding - private' stamp: 'ERMC 5/25/2021 22:27:57'!
anyParentHasAccount: anAccountToAdd 
	
	^parents anySatisfy: [ :aParent | (aParent accounts)  includes: anAccountToAdd]! !

!Portfolio methodsFor: 'adding - private' stamp: 'ERMC 5/25/2021 22:34:40'!
isAnyAccountThatIncludes: anAccountToAdd 

 	^ (anAccountToAdd = self) or: [
	accounts anySatisfy: [:anAccount | (anAccount isAnyAccountThatIncludes: anAccountToAdd) or: [anAccountToAdd isAnyAccountThatIncludes: anAccount]]]

	or: (self anyParentHasAccount: anAccountToAdd)! !


!Portfolio methodsFor: 'accesing' stamp: 'ERMC 5/23/2021 21:04:14'!
accounts

	^accounts! !

!Portfolio methodsFor: 'accesing' stamp: 'ERMC 5/22/2021 19:40:28'!
balance
	
	^accounts sum: [:account | account balance ] ifEmpty: [^0]! !

!Portfolio methodsFor: 'accesing' stamp: 'ERMC 5/22/2021 20:56:18'!
hasRegistered: aTransaction
	
	^accounts anySatisfy: [:anAccount | anAccount hasRegistered: aTransaction] ! !

!Portfolio methodsFor: 'accesing' stamp: 'ERMC 5/25/2021 22:04:44'!
parents
	
	^parents! !

!Portfolio methodsFor: 'accesing' stamp: 'ERMC 5/23/2021 12:56:22'!
transactions

	| transactions |
	transactions _ OrderedCollection new.
	
	accounts do: [:anAccount | transactions addAll: anAccount transactions ].
	
	^transactions 
	
! !


!Portfolio methodsFor: 'asserts' stamp: 'ERMC 5/25/2021 22:02:25'!
assertCanAdd: anAccountToAdd
	
	(self isAnyAccountThatIncludes: anAccountToAdd) ifTrue: [^self error: self class canNotAddDuplicatedAccountErrorMessage].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'ERMC 5/23/2021 20:20:58'!
canNotAddDuplicatedAccountErrorMessage

	^'can not add account'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'ERMC 5/25/2021 20:30:13'!
with: aReceptiveAccount 

	^self new initializeWith: aReceptiveAccount
	! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
BankAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'ERMC 5/23/2021 21:27:01'!
accounts
	
	^self! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'ERMC 5/23/2021 21:28:20'!
includes: anAccount

	^self = anAccount! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'ERMC 5/17/2021 22:06:17'!
balance

	| totalBalance |
	totalBalance _ 0.

	totalBalance _ transactions sum: [ :aTransaction | aTransaction addTo: totalBalance].
	
	^totalBalance! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'private' stamp: 'ERMC 5/25/2021 21:49:12'!
addAsParent: aPortfolio 
	
	parents _ aPortfolio ! !

!ReceptiveAccount methodsFor: 'private' stamp: 'ERMC 5/25/2021 22:35:23'!
isAnyAccountThatIncludes: anAccount 
	
	^self = anAccount. ! !
