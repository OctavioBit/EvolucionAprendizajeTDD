!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'testing' stamp: 'nt 11/2/2020 20:58:24'!
test01EmptyPortfolioBalanceEqual0
	|portfolio|
	portfolio:=Portfolio new.
	self assert:(portfolio balance=0)! !

!PortfolioTest methodsFor: 'testing' stamp: 'nt 11/8/2020 15:52:28'!
test02AddAnAccountToAPortfolioAndCalculateBalance
	|portfolio account|
	portfolio:=Portfolio new.
	account:=ReceptiveAccount new.
	
	Deposit register: 100 on: account.
	portfolio addAccountOrPortfolio:account.
		
	self assert: 100 equals: portfolio balance.
	! !

!PortfolioTest methodsFor: 'testing' stamp: 'nt 11/8/2020 15:52:28'!
test03AddAnEmptyPortfolioToAPortfolioAndCalculateBalanceEqual0
	|portfolio portfolio1|
	portfolio:=Portfolio new.
	portfolio1:=Portfolio new..
	
	portfolio addAccountOrPortfolio:portfolio1.
		
	self assert: 0 equals: portfolio balance.
	! !

!PortfolioTest methodsFor: 'testing' stamp: 'nt 11/8/2020 15:52:28'!
test04AddAPortfolioWithAnAccountToAPortfolioAndCalculateBalance
	|portfolio portfolio1 account|
	portfolio:=Portfolio new.
	portfolio1:=Portfolio new.
	account:=ReceptiveAccount new.
	portfolio1 addAccountOrPortfolio:account.
	Deposit register:100 on:account.
	
	portfolio addAccountOrPortfolio:portfolio1.
		
	self assert: 100 equals: portfolio balance.
	! !

!PortfolioTest methodsFor: 'testing' stamp: 'nt 11/8/2020 15:52:28'!
test05PortfolioKnowsRegisteredTransactions 

	| portfolio account deposit withdraw |
	portfolio:=Portfolio new.
	account := ReceptiveAccount new.
	portfolio addAccountOrPortfolio:account.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (portfolio hasRegistered: deposit).
	self assert: (portfolio hasRegistered: withdraw).
! !

!PortfolioTest methodsFor: 'testing' stamp: 'nt 11/7/2020 16:15:16'!
test06PortfolioDoNotKnowNotRegisteredAccounts

	| portfolio account deposit withdraw |
	portfolio:=Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
	
	self deny: (portfolio hasRegistered:deposit).
	self deny: (portfolio hasRegistered:withdraw).
! !

!PortfolioTest methodsFor: 'testing' stamp: 'nt 11/8/2020 15:52:28'!
test07PortfolioKnowsItsAccountsTransactionsWithOneAccount 

	| portfolio account1 deposit1 |
	
	portfolio:=Portfolio new.
	account1 := ReceptiveAccount new.
	portfolio addAccountOrPortfolio:account1.
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: portfolio transactions size.
	self assert: (portfolio transactions includes: deposit1).
! !

!PortfolioTest methodsFor: 'testing' stamp: 'nt 11/8/2020 15:52:28'!
test08PortfolioKnowsItsAccountsTransactionsWithManyAccounts

	| portfolio account1 account2 deposit1 deposit2 |
	
	portfolio:=Portfolio new.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio addAccountOrPortfolio:account1.
	portfolio addAccountOrPortfolio:account2.
	deposit1 := Deposit register: 50 on: account1.
	deposit2 := Deposit register: 50 on: account2.
		
	self assert: 2 equals: portfolio transactions size.
	self assert: (portfolio transactions includes: deposit1).
	self assert: (portfolio transactions includes: deposit2).
! !

!PortfolioTest methodsFor: 'testing' stamp: 'nt 11/8/2020 15:52:28'!
test09PortfolioBalanceWithManyAccounts

	| portfolio account1 account2 deposit1 deposit2 |
	
	portfolio:=Portfolio new.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio addAccountOrPortfolio:account1.
	portfolio addAccountOrPortfolio:account2.
	deposit1 := Deposit register: 50 on: account1.
	deposit2 := Deposit register: 50 on: account2.
		
	self assert: 100 equals: portfolio balance.
	
! !

!PortfolioTest methodsFor: 'testing' stamp: 'nt 11/8/2020 15:52:28'!
test10PortfolioDoesNotAcceptRepeatedAccounts

	| portfolio account1  |
	
	portfolio:=Portfolio new.
	account1 := ReceptiveAccount new.
	portfolio addAccountOrPortfolio:account1.
				
	self should:[portfolio addAccountOrPortfolio:account1]
	raise:Error
	withExceptionDo:[:anError| 
		self assert: anError  messageText=Portfolio duplicateAccountorPortfolioMessageError]
	
! !

!PortfolioTest methodsFor: 'testing' stamp: 'nt 11/8/2020 15:52:28'!
test11PortfolioDoesNotAcceptRepeatedPortfolio

	| portfolio portfolio1 |
	
	portfolio:=Portfolio new.
	portfolio1:=Portfolio new.
	portfolio addAccountOrPortfolio:portfolio1.
			
	self should:[portfolio addAccountOrPortfolio:portfolio1]
	raise:Error
	withExceptionDo:[:anError| 
		self assert: anError  messageText=Portfolio duplicateAccountorPortfolioMessageError]
	
! !

!PortfolioTest methodsFor: 'testing' stamp: 'nt 11/8/2020 15:52:28'!
test12PortfoliosDoesNotAcceptPortfoliosThatSharesAccount

	| portfolio portfolio1 account1 |
	
	portfolio:=Portfolio new.
	portfolio1:=Portfolio new.
	account1:=ReceptiveAccount new.
	portfolio addAccountOrPortfolio:account1.
	portfolio1 addAccountOrPortfolio:account1.
			
	self should:[portfolio addAccountOrPortfolio:portfolio1]
	raise:Error
	withExceptionDo:[:anError| 
		self assert: anError  messageText=Portfolio duplicateAccountorPortfolioMessageError]
	
! !

!PortfolioTest methodsFor: 'testing' stamp: 'nt 11/8/2020 15:52:28'!
test13PortfolioDoesNotAcceptPortfolioCycle

	| portfolio portfolio1 |
	
	portfolio:=Portfolio new.
	portfolio1:=Portfolio new.
	portfolio addAccountOrPortfolio:portfolio1.
			
	self should:[portfolio1 addAccountOrPortfolio:portfolio]
	raise:Error
	withExceptionDo:[:anError| 
		self assert: anError  messageText=Portfolio duplicateAccountorPortfolioMessageError]
	
! !

!PortfolioTest methodsFor: 'testing' stamp: 'nt 11/8/2020 15:52:28'!
test14PortfoliosBalanceWithSharedAccount

	| portfolio portfolio1 account1 |
	
	portfolio:=Portfolio new.
	portfolio1:=Portfolio new.
	account1:=ReceptiveAccount new.
	portfolio addAccountOrPortfolio:account1.
	portfolio1 addAccountOrPortfolio:account1.
	Deposit register:100 on:account1.
			
	self assert: portfolio balance equals: portfolio1 balance.
	self assert: portfolio balance equals: account1 balance
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


!Deposit methodsFor: 'accesing' stamp: 'nt 11/7/2020 15:17:23'!
balance
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


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'accesing' stamp: 'nt 11/7/2020 15:17:23'!
balance
	^(value * -1)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accountsAndPortfolios parentPortfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'nt 11/7/2020 17:21:15'!
hasAccountOrPortfolio:anAccountOrPortfolio
	^(accountsAndPortfolios includes: anAccountOrPortfolio ) ! !

!Portfolio methodsFor: 'initialization' stamp: 'nt 11/7/2020 17:31:19'!
initialize

	accountsAndPortfolios := OrderedCollection new.
	parentPortfolio:=RootPortfolio new.! !

!Portfolio methodsFor: 'initialization' stamp: 'nt 11/7/2020 18:41:33'!
validateAccountOrPortfolio:anAccountOrPortfolio
|myAccountsAndPortfoliosCollection theirAccountsAndPortfoliosCollection|
myAccountsAndPortfoliosCollection:=self rootSearch:self.
theirAccountsAndPortfoliosCollection:=anAccountOrPortfolio rootSearch: anAccountOrPortfolio.
(myAccountsAndPortfoliosCollection noneSatisfy: [:myAccountOrPortfolio|theirAccountsAndPortfoliosCollection includes:myAccountOrPortfolio ] ) ifFalse: [self error:Portfolio duplicateAccountorPortfolioMessageError].
(myAccountsAndPortfoliosCollection includes: anAccountOrPortfolio ) ifTrue: [self error:Portfolio duplicateAccountorPortfolioMessageError].

	
	
	! !


!Portfolio methodsFor: 'transactions' stamp: 'nt 11/8/2020 15:52:28'!
addAccountOrPortfolio: anAccountOrPortfolio
	self validateAccountOrPortfolio:anAccountOrPortfolio.
	accountsAndPortfolios add: anAccountOrPortfolio.
	anAccountOrPortfolio assignParent:self.
! !

!Portfolio methodsFor: 'transactions' stamp: 'nt 11/7/2020 17:34:27'!
assignParent: aPortfolio
	parentPortfolio:=aPortfolio
! !

!Portfolio methodsFor: 'transactions' stamp: 'nt 11/7/2020 18:22:56'!
findAllAccountsAndPortfolios:allAccountsAndPortfoliosCollection
	accountsAndPortfolios do:[:anAccountOrPortfolio| allAccountsAndPortfoliosCollection add:anAccountOrPortfolio . 
		anAccountOrPortfolio findAllAccountsAndPortfolios:allAccountsAndPortfoliosCollection ]
! !

!Portfolio methodsFor: 'transactions' stamp: 'nt 11/7/2020 18:20:12'!
rootSearch:childPortfolio
^parentPortfolio rootSearch:self
	! !

!Portfolio methodsFor: 'transactions' stamp: 'nt 11/7/2020 16:38:31'!
transactions 
	|totalTransacctions|
	totalTransacctions:=OrderedCollection new.
	accountsAndPortfolios do: [:anAccountOrPortfolio| totalTransacctions addAll: anAccountOrPortfolio transactions ].
	^totalTransacctions.
	! !


!Portfolio methodsFor: 'balance' stamp: 'nt 11/7/2020 15:21:18'!
balance

	^accountsAndPortfolios sum: [ :anAccountOrPortfolio | anAccountOrPortfolio balance ]  
		 ifEmpty: [ 0 ] ! !


!Portfolio methodsFor: 'testing' stamp: 'nt 11/7/2020 16:06:17'!
hasRegistered: aTransaction

 ^accountsAndPortfolios anySatisfy: [:anAccountOrPortfolio|anAccountOrPortfolio hasRegistered: aTransaction]
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'nt 11/7/2020 17:07:58'!
duplicateAccountorPortfolioMessageError
	'La cuenta o portfolio que quiere agregar ya existe en el portfolio'! !


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


!ReceptiveAccount methodsFor: 'balance' stamp: 'nt 11/7/2020 15:17:23'!
balance

	^transactions sum: [ :aTransaction | aTransaction balance]
		 ifEmpty: [ 0 ] ! !


!ReceptiveAccount methodsFor: 'private' stamp: 'nt 11/7/2020 17:36:10'!
assignParent:aPortfolio
	! !

!ReceptiveAccount methodsFor: 'private' stamp: 'nt 11/7/2020 17:59:43'!
findAllAccountsAndPortfolios:allAccountsAndPortfoliosCollection! !

!ReceptiveAccount methodsFor: 'private' stamp: 'nt 11/7/2020 18:37:02'!
rootSearch:childPortfolio
	^OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!classDefinition: #RootPortfolio category: 'Portfolio-Ejercicio'!
Object subclass: #RootPortfolio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!RootPortfolio methodsFor: 'as yet unclassified' stamp: 'nt 11/7/2020 17:29:58'!
parentPortfolio
	! !

!RootPortfolio methodsFor: 'as yet unclassified' stamp: 'nt 11/7/2020 18:37:29'!
rootSearch:childPortfolio
|allAccountsAndPortfolios |
allAccountsAndPortfolios :=(OrderedCollection new).
childPortfolio findAllAccountsAndPortfolios:allAccountsAndPortfolios.
^allAccountsAndPortfolios.
	! !
