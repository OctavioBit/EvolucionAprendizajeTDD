!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'testing' stamp: 'Lb 5/25/2021 20:48:05'!
test01NewPortfolioShouldBeEmptyAndHaveZeroBalance
	| portfolio |
	
	portfolio := Portfolio new.

	self assert: portfolio hasBalance: 0 totalAccounts: 0 totalChildPortfolios: 0! !

!PortfolioTest methodsFor: 'testing' stamp: 'Lb 5/25/2021 20:48:14'!
test02AddEmptyAccountShouldRegisterAccountWithNoBalance
	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account.
	
	self assert: portfolio hasBalance: 0 totalAccounts: 1 totalChildPortfolios: 0! !

!PortfolioTest methodsFor: 'testing' stamp: 'Lb 5/25/2021 20:48:25'!
test03PortfolioCantAddSameAccountMoreThanOnce
	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account.
	
	self should: [portfolio add: account] raise: Error - MessageNotUnderstood withMessageText: Portfolio errorElementAlreadyAddedMessage.
	
	self assert: portfolio hasBalance: 0 totalAccounts: 1 totalChildPortfolios: 0! !

!PortfolioTest methodsFor: 'testing' stamp: 'Lb 5/25/2021 20:48:35'!
test04PortfolioShouldBeAbleToAddAnAccountWithANonZeroBalance
	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolio add: account.
	
	self assert: portfolio hasBalance: 100 totalAccounts: 1 totalChildPortfolios: 0! !

!PortfolioTest methodsFor: 'testing' stamp: 'Lb 5/25/2021 20:48:49'!
test05PortfolioShouldRecognizeTransactionInAnAlreadyExistingAccount
	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account.
	Deposit register: 100 on: account.
	
	self assert: portfolio hasBalance: 100 totalAccounts: 1 totalChildPortfolios: 0! !

!PortfolioTest methodsFor: 'testing' stamp: 'Lb 5/25/2021 20:49:00'!
test06PortfolioBalanceShouldBeTheSumOfItsAccountsBalances
	| portfolio account account2|
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account.
	Deposit register: 100 on: account.
	
	account2 := ReceptiveAccount new.
	portfolio add: account2.
	Deposit register: 50 on: account2.
	
	self assert: portfolio hasBalance: 150 totalAccounts: 2 totalChildPortfolios: 0! !

!PortfolioTest methodsFor: 'testing' stamp: 'Lb 5/25/2021 20:49:24'!
test07PortfolioShouldKnowItsAccounts
	| portfolio account account2|
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account.
	Deposit register: 100 on: account.
	
	account2 := ReceptiveAccount new.
	portfolio add: account2.
	Deposit register: 50 on: account2.
	
	self assert: portfolio hasBalance: 150 totalAccounts: 2 totalChildPortfolios: 0.
	
	self assert: (portfolio includes: account).
	self assert: (portfolio includes: account2).! !

!PortfolioTest methodsFor: 'testing' stamp: 'Lb 5/25/2021 20:49:35'!
test08PortfolioShouldKnowOnlyItsAccounts
	| portfolio account account2|
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account.
	Deposit register: 100 on: account.
	
	account2 := ReceptiveAccount new.
	Deposit register: 50 on: account2.
	
	self assert: portfolio hasBalance: 100 totalAccounts: 1 totalChildPortfolios: 0.
	self assert: (portfolio includes: account).
	self deny: (portfolio includes: account2).! !

!PortfolioTest methodsFor: 'testing' stamp: 'LB 5/22/2021 19:02:01'!
test09PortfolioShouldRecognizeATransactionInOneOfItsAccounts
	| portfolio account aTransaction|
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account.
	aTransaction := Deposit register: 100 on: account.
	
	self assert: (portfolio hasRegistered: aTransaction).! !

!PortfolioTest methodsFor: 'testing' stamp: 'LB 5/20/2021 20:19:13'!
test10PortfolioShouldKnowOnlyItsAccountsTransactions
	| portfolio account aTransaction|
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	aTransaction := Deposit register: 100 on: account.
	
	self deny: (portfolio hasRegistered: aTransaction).! !

!PortfolioTest methodsFor: 'testing' stamp: 'LB 5/22/2021 19:02:01'!
test11PortfolioShouldKnowItsAccountsTransactions
	| portfolio account aTransaction account2 aTransaction2|
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account.
	aTransaction := Deposit register: 100 on: account.
	
	account2 := ReceptiveAccount new.
	portfolio add: account2.
	aTransaction2 := Withdraw register: 100 on: account2.
	
	self assert: (portfolio hasRegistered: aTransaction).
	self assert: (portfolio hasRegistered: aTransaction2).! !

!PortfolioTest methodsFor: 'testing' stamp: 'LB 5/22/2021 19:02:01'!
test12PortfolioShouldIncludeTheTransactionOfItsOnlyAccount
	| portfolio account aTransaction|
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account.
	aTransaction := Deposit register: 100 on: account.
	
	self assert: (portfolio transactions includes: aTransaction).! !

!PortfolioTest methodsFor: 'testing' stamp: 'LB 5/22/2021 12:15:21'!
test13PortfolioShouldIncludeOnlyItsAccountsTransactions
	| portfolio account aTransaction|
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	aTransaction := Deposit register: 100 on: account.
	
	self deny: (portfolio transactions includes: aTransaction).! !

!PortfolioTest methodsFor: 'testing' stamp: 'LB 5/22/2021 19:02:01'!
test14PortfolioShouldIncludeItsAccountsTransactions
	| portfolio account aTransaction account2 aTransaction2|
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account.
	aTransaction := Deposit register: 100 on: account.
	
	account2 := ReceptiveAccount new.
	portfolio add: account2.
	aTransaction2 := Withdraw register: 100 on: account2.
	
	self assert: (portfolio transactions includes: aTransaction).
	self assert: (portfolio transactions includes: aTransaction2).! !

!PortfolioTest methodsFor: 'testing' stamp: 'Lb 5/25/2021 20:50:08'!
test15PortfolioShouldBeAbleToAddAChildPortfolio
	| portfolio childPortfolio |
	
	portfolio := Portfolio new.
	childPortfolio := Portfolio new.
	portfolio add: childPortfolio.
	
	self assert: portfolio hasBalance: 0 totalAccounts: 0 totalChildPortfolios: 1.! !

!PortfolioTest methodsFor: 'testing' stamp: 'Lb 5/25/2021 20:50:19'!
test16PortfolioCantAddSameChildPorfolioMoreThanOnce
	| portfolio childPortfolio |
	
	portfolio := Portfolio new.
	childPortfolio := Portfolio new.
	portfolio add: childPortfolio.

	self should: [portfolio add: childPortfolio.] raise: Error - MessageNotUnderstood withMessageText: Portfolio errorElementAlreadyAddedMessage.
	
	self assert: portfolio hasBalance: 0 totalAccounts: 0 totalChildPortfolios: 1.! !

!PortfolioTest methodsFor: 'testing' stamp: 'Lb 5/25/2021 20:50:31'!
test17PortfolioShouldBeAbleToAddMultipleChildPortfolios
	| portfolio childPortfolio1 childPortfolio2 |
	
	portfolio := Portfolio new.
	childPortfolio1 := Portfolio new.
	childPortfolio2 := Portfolio new.
	portfolio add: childPortfolio1.
	portfolio add: childPortfolio2.

	self assert: portfolio hasBalance: 0 totalAccounts: 0 totalChildPortfolios: 2.! !

!PortfolioTest methodsFor: 'testing' stamp: 'Lb 5/25/2021 20:50:43'!
test18PortfolioBalanceShouldConsiderItsChildPortfoliosBalances
	| portfolio childPortfolio account |
	
	portfolio := Portfolio new.
	childPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	childPortfolio add: account.
	Deposit register: 100 on: account.
	
	portfolio add: childPortfolio.
	
	self assert: portfolio hasBalance: 100 totalAccounts: 1 totalChildPortfolios: 1.! !

!PortfolioTest methodsFor: 'testing' stamp: 'Lb 5/25/2021 20:50:51'!
test19PortfolioAccountsShouldBeOfTypeAccount
	| portfolio |
	
	portfolio := Portfolio new.
	
	self should: [portfolio add: 'test'] raise: Error - MessageNotUnderstood withMessageText: Portfolio errorInvalidTypeMessage.
	
	self assert: portfolio hasBalance: 0 totalAccounts: 0 totalChildPortfolios: 0.! !

!PortfolioTest methodsFor: 'testing' stamp: 'Lb 5/25/2021 20:51:01'!
test20ChildPortfoliosShouldBeOfTypePortfolio
	| portfolio |
	
	portfolio := Portfolio new.
	
	self should: [portfolio add: 'test'] raise: Error - MessageNotUnderstood withMessageText: Portfolio errorInvalidTypeMessage.

	self assert: portfolio hasBalance: 0 totalAccounts: 0 totalChildPortfolios: 0.! !

!PortfolioTest methodsFor: 'testing' stamp: 'Lb 5/25/2021 20:51:16'!
test21PortfolioShouldKnowItsChildPortfoliosAccounts
	| portfolio childPortfolio childPortfolio2 account account2|
	
	portfolio := Portfolio new.
	childPortfolio := Portfolio new.
	childPortfolio2 := Portfolio new.
	
	account := ReceptiveAccount new.
	childPortfolio add: account.
	Deposit register: 100 on: account.
	
	account2 := ReceptiveAccount new.
	childPortfolio2 add: account2.
	Deposit register: 50 on: account2.
	
	portfolio add: childPortfolio.
	portfolio add: childPortfolio2.

	self assert: portfolio hasBalance: 150 totalAccounts: 2 totalChildPortfolios: 2.
	
	self assert: (portfolio includes: account).
	self assert: (portfolio includes: account2).! !

!PortfolioTest methodsFor: 'testing' stamp: 'LB 5/22/2021 19:02:28'!
test22PortfolioShouldIncludeItsChildPorfoliosAccountsTransactions
	| portfolio childPortfolio childPortfolio2 account account2 aTransaction aTransaction2|
	
	portfolio := Portfolio new.
	childPortfolio := Portfolio new.
	childPortfolio2 := Portfolio new.
	
	account := ReceptiveAccount new.
	childPortfolio add: account.
	aTransaction := Deposit register: 100 on: account.
	
	account2 := ReceptiveAccount new.
	childPortfolio2 add: account2.
	aTransaction2 := Withdraw register: 50 on: account2.
	
	portfolio add: childPortfolio.
	portfolio add: childPortfolio2.
	
	self assert: (portfolio transactions includes: aTransaction).
	self assert: (portfolio  transactions includes: aTransaction2).! !

!PortfolioTest methodsFor: 'testing' stamp: 'LB 5/22/2021 19:03:56'!
test23PortfolioCannotAddItself
	| portfolio |
	
	portfolio := Portfolio new.
	
	self should: [portfolio add: portfolio.] raise: Error - MessageNotUnderstood withMessageText: Portfolio errorElementAlreadyAddedMessage.
	! !

!PortfolioTest methodsFor: 'testing' stamp: 'LB 5/22/2021 19:04:21'!
test24PortfolioCannotAddAnAccountAlreadyAddedToItsFather
	| portfolio childPortfolio account |
	
	portfolio := Portfolio new.
	childPortfolio := Portfolio new.
	portfolio add: childPortfolio.
	
	account := ReceptiveAccount new.
	portfolio add: account.
	
	self should: [childPortfolio add: account] raise: Error - MessageNotUnderstood withMessageText: Portfolio errorElementAlreadyAddedMessage.
	
	self assert: 1 equals: portfolio totalAccounts.
	self assert: 0 equals: childPortfolio totalAccounts.! !

!PortfolioTest methodsFor: 'testing' stamp: 'LB 5/22/2021 19:02:28'!
test25PortfolioShouldKnowItsOnlyPortfolio
	| portfolio childPortfolio |
	
	portfolio := Portfolio new.
	childPortfolio := Portfolio new.
	portfolio add: childPortfolio.

	self assert: (portfolio includes: childPortfolio).! !

!PortfolioTest methodsFor: 'testing' stamp: 'lb 5/24/2021 16:40:24'!
test26PortfolioShouldKnowItsPortfolios
	| portfolio childPortfolio grandchildPortfolio|
	
	portfolio := Portfolio new.
	childPortfolio := Portfolio new.
	grandchildPortfolio := Portfolio new.
	
	portfolio add: childPortfolio.
	childPortfolio add: grandchildPortfolio.

	self assert: (portfolio includes: grandchildPortfolio).
	self assert: 2 equals: portfolio totalChildPortfolios.! !

!PortfolioTest methodsFor: 'testing' stamp: 'lb 5/24/2021 16:40:24'!
test27PortfolioCannotAddAPortfolioKnownByItsFather
	| portfolio childPortfolio |
	
	portfolio := Portfolio new.
	childPortfolio := Portfolio new.
	portfolio add: childPortfolio.
	
	self should: [childPortfolio add: portfolio] raise: Error - MessageNotUnderstood withMessageText: Portfolio errorElementAlreadyAddedMessage .
	
	self assert: 1 equals: portfolio totalChildPortfolios .
	self assert: 0 equals: childPortfolio totalChildPortfolios.! !

!PortfolioTest methodsFor: 'testing' stamp: 'LB 5/22/2021 19:04:21'!
test28PortfolioCannotAddAnAccountAlreadyKnownByItsAncestors
	| portfolio childPortfolio grandchildPortfolio account|
	
	portfolio := Portfolio new.
	childPortfolio := Portfolio new.
	grandchildPortfolio := Portfolio new.
	portfolio add: childPortfolio.
	childPortfolio add: grandchildPortfolio.
	
	account := ReceptiveAccount new.
	portfolio add: account.
	
	self should: [grandchildPortfolio add: account] raise: Error - MessageNotUnderstood withMessageText: Portfolio errorElementAlreadyAddedMessage .! !

!PortfolioTest methodsFor: 'testing' stamp: 'LB 5/22/2021 19:03:56'!
test29PortfolioCannotAddAPortfolioAlreadyKnownByItsAncestors
	| portfolio childPortfolio grandchildPortfolio conflictingPortfolio|
	
	portfolio := Portfolio new.
	childPortfolio := Portfolio new.
	grandchildPortfolio := Portfolio new.
	portfolio add: childPortfolio.
	childPortfolio add: grandchildPortfolio.
	
	conflictingPortfolio := Portfolio new.
	portfolio add: conflictingPortfolio.
	
	self should: [grandchildPortfolio add: conflictingPortfolio] raise: Error - MessageNotUnderstood withMessageText: Portfolio errorElementAlreadyAddedMessage .! !

!PortfolioTest methodsFor: 'testing' stamp: 'LB 5/22/2021 19:03:56'!
test30PortfolioCanBeAddedToMultiplePortfolios
	| father1 father2 portfolio conflictingPortfolio|
	
	father1 := Portfolio new.
	father2 := Portfolio new.
	portfolio := Portfolio new.
	conflictingPortfolio := Portfolio new.
	
	father1 add: conflictingPortfolio.
	father1 add: portfolio.
	father2 add: portfolio.
	
	self should: [portfolio add: conflictingPortfolio] raise: Error - MessageNotUnderstood withMessageText: Portfolio errorElementAlreadyAddedMessage .! !

!PortfolioTest methodsFor: 'testing' stamp: 'Lb 5/25/2021 20:31:31'!
test31PortfolioCannotRegisterSameTransactionMoreThanOnce
	| portfolio account transaction |

	portfolio := Portfolio new.
	account :=  ReceptiveAccount new.
	transaction := Deposit register: 10 on: account.

	self should: [portfolio register: transaction] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Portfolio errorTransactionCantBeAddedMessage .! !

!PortfolioTest methodsFor: 'testing' stamp: 'Lb 5/25/2021 20:32:28'!
test32PortfolioCannotRegisterTransactionOfExternalAccount
	| portfolio account transaction |

	portfolio := Portfolio new.
	account :=  ReceptiveAccount new.
	transaction := Deposit register: 10 on: account.
	portfolio add: account.

	self should: [portfolio register: transaction] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Portfolio errorTransactionCantBeAddedMessage .! !

!PortfolioTest methodsFor: 'testing' stamp: 'Lb 5/25/2021 20:34:44'!
test33PortfolioShouldKnowItsGrandchildPortfolios
	| portfolio portfolio1 portfolio2 portfolio3 portfolio4 account account1 account2 |

	portfolio := Portfolio new.
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	portfolio4 := Portfolio new.
	
	account :=  ReceptiveAccount new.
	account1 :=  ReceptiveAccount new.
	account2 :=  ReceptiveAccount new.
	
	portfolio add: account.
	portfolio add: portfolio1.
	portfolio add: portfolio2.
	portfolio2 add: portfolio3.
	portfolio2 add: portfolio4.
	portfolio3 add: account1.
	portfolio3 add: account2.
	
	self assert: 4 equals: portfolio totalChildPortfolios.! !


!PortfolioTest methodsFor: 'asserts' stamp: 'Lb 5/25/2021 20:47:41'!
assert: aPortfolio hasBalance: aBalance totalAccounts: aNumberOfAccounts totalChildPortfolios: aNumberOfPortfolios

	self assert: aBalance equals: aPortfolio balance.
	self assert: aNumberOfAccounts equals: aPortfolio totalAccounts.
	self assert: aNumberOfPortfolios equals: aPortfolio totalChildPortfolios.! !


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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'Lb 5/25/2021 16:53:55'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account account2 |
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	deposit :=  Deposit register: 200 on: account2.
	withdraw := Withdraw register: 50 on: account2.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LB 5/22/2021 12:15:53'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'lb 5/24/2021 17:18:51'!
test08AccountTransactionValueShouldBeNumeric
	| account1 |
	
	account1 := ReceptiveAccount new.
	
	self should: [Deposit register: 'ocho' on: account1] raise: Error - MessageNotUnderstood withMessageText: AccountTransaction invalidTypeMessage.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'lb 5/24/2021 17:20:24'!
test09AccountTransactionShouldBeRegisteredToAReceptiveAccount

	self should: [Withdraw register: 100 on: 'This is an account. Trust me.'] raise: Error - MessageNotUnderstood withMessageText: AccountTransaction invalidTypeMessage.! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'accesing' stamp: 'Lb 5/24/2021 21:49:20'!
account

	^ account! !

!AccountTransaction methodsFor: 'accesing' stamp: 'Lb 5/24/2021 21:47:30'!
value

	^ value! !


!AccountTransaction methodsFor: 'initialization' stamp: 'Lb 5/25/2021 16:55:11'!
initializeFor: aValue on: anAccount 

	value := aValue.
	account := anAccount! !


!AccountTransaction methodsFor: 'operations' stamp: 'LB 5/17/2021 21:53:19'!
addTo: aBalanceValue
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'Lb 5/25/2021 16:55:11'!
register: aValue on: account

	| transaction |
	
	((aValue isKindOf: Number) and: [account isKindOf: ReceptiveAccount])	 ifFalse: [^self error: self invalidTypeMessage].
	
	transaction := self new initializeFor: aValue on: account.
	account register: transaction.
		
	^ transaction! !


!AccountTransaction class methodsFor: 'as yet unclassified' stamp: 'lb 5/24/2021 17:09:37'!
invalidTypeMessage
	^ 'Invalid type'! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'operations' stamp: 'LB 5/17/2021 21:53:54'!
addTo: aBalanceValue
	^aBalanceValue + value! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'operations' stamp: 'LB 5/17/2021 21:54:04'!
addTo: aBalanceValue
	^aBalanceValue - value! !


!classDefinition: #PortfolioEntry category: 'Portfolio-Ejercicio'!
Object subclass: #PortfolioEntry
	instanceVariableNames: 'parentPortfolios transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioEntry methodsFor: 'initialization' stamp: 'Lb 5/25/2021 16:59:25'!
initialize
	parentPortfolios := OrderedCollection new.
	transactions := OrderedCollection new.! !


!PortfolioEntry methodsFor: 'testing' stamp: 'LB 5/24/2021 20:16:13'!
includes: aPortfolioEntry
	self subclassResponsibility ! !

!PortfolioEntry methodsFor: 'testing' stamp: 'lb 5/24/2021 16:57:26'!
totalAccounts 
	self subclassResponsibility ! !

!PortfolioEntry methodsFor: 'testing' stamp: 'LB 5/24/2021 20:33:53'!
totalPortfolios 
	self subclassResponsibility ! !


!PortfolioEntry methodsFor: 'transactions' stamp: 'lb 5/24/2021 16:21:55'!
hasRegistered: aTransaction
	self subclassResponsibility ! !

!PortfolioEntry methodsFor: 'transactions' stamp: 'LB 5/22/2021 17:40:43'!
transactions
	self subclassResponsibility ! !


!PortfolioEntry methodsFor: 'balance' stamp: 'LB 5/22/2021 17:40:11'!
balance
	self subclassResponsibility ! !


!PortfolioEntry methodsFor: 'private' stamp: 'Lb 5/24/2021 21:32:28'!
beAddedTo: aPortfolio
	self subclassResponsibility ! !

!PortfolioEntry methodsFor: 'private' stamp: 'Lb 5/25/2021 17:07:21'!
optimizedTransactions
	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
PortfolioEntry subclass: #Portfolio
	instanceVariableNames: 'childElements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'Lb 5/25/2021 16:59:21'!
initialize
	super initialize.
	childElements := OrderedCollection new.! !


!Portfolio methodsFor: 'transactions' stamp: 'Lb 5/25/2021 20:40:32'!
register: aTransaction
	self assertPortfolioIncludesTransactionAccountDirectly: aTransaction .
	self assertTransactionNotRegistered: aTransaction.
	transactions add: aTransaction.! !

!Portfolio methodsFor: 'transactions' stamp: 'Lb 5/25/2021 17:08:08'!
transactions
	^self optimizedTransactions! !


!Portfolio methodsFor: 'testing' stamp: 'Lb 5/24/2021 21:17:54'!
hasRegistered: aTransaction
	^self transactions includes: aTransaction.! !

!Portfolio methodsFor: 'testing' stamp: 'Lb 5/25/2021 20:35:25'!
includes: aPortfolioEntry
	^(self = aPortfolioEntry) or: [self exists: aPortfolioEntry in: childElements].! !

!Portfolio methodsFor: 'testing' stamp: 'Lb 5/24/2021 21:17:54'!
totalAccounts
	^childElements sum: [:aPortfolioEntry | aPortfolioEntry totalAccounts] ifEmpty: [0].! !

!Portfolio methodsFor: 'testing' stamp: 'Lb 5/24/2021 21:17:54'!
totalChildPortfolios
	^childElements sum: [:aPortfolioEntry | aPortfolioEntry totalPortfolios] ifEmpty: [0].! !

!Portfolio methodsFor: 'testing' stamp: 'Lb 5/25/2021 20:29:44'!
totalPortfolios
	^1 + self totalChildPortfolios.! !


!Portfolio methodsFor: 'balance' stamp: 'Lb 5/24/2021 21:17:54'!
balance
	^ childElements sum: [:aPortfolioEntry | aPortfolioEntry balance] ifEmpty: [0]. ! !


!Portfolio methodsFor: 'private searching' stamp: 'Lb 5/25/2021 20:17:42'!
exists: aPortfolioEntry in: porfolioEntries
		^porfolioEntries anySatisfy: [:aChildElement | aChildElement includes: aPortfolioEntry].! !

!Portfolio methodsFor: 'private searching' stamp: 'Lb 5/25/2021 17:49:38'!
existsInParents: aPortfolioEntry
	^parentPortfolios anySatisfy: [:aParentPortfolio | aParentPortfolio searchInParents: aPortfolioEntry withoutSubtree: self]! !

!Portfolio methodsFor: 'private searching' stamp: 'Lb 5/25/2021 20:16:27'!
includes: aPortfolioEntry exceptuating: anExceptuatedEntry
	|portfolioEntries|
	portfolioEntries := childElements copy.
	portfolioEntries remove: anExceptuatedEntry ifAbsent: [].
	
	^(self = aPortfolioEntry) or: [self exists: aPortfolioEntry in: portfolioEntries].! !

!Portfolio methodsFor: 'private searching' stamp: 'Lb 5/25/2021 17:49:38'!
searchInParents: aPortfolioEntry withoutSubtree: anExceptuatedEntry

	^ (self includes: aPortfolioEntry exceptuating: anExceptuatedEntry) or: [self existsInParents: aPortfolioEntry]! !


!Portfolio methodsFor: 'private' stamp: 'Lb 5/24/2021 21:32:20'!
beAddedTo: aPortfolio
	aPortfolio safetlyAdd: self.
	parentPortfolios add: aPortfolio .! !

!Portfolio methodsFor: 'private' stamp: 'Lb 5/25/2021 17:08:08'!
optimizedTransactions
	| totalTransactions |
	totalTransactions := transactions copy.
	childElements do: [:aPortfolioEntry | totalTransactions addAll: aPortfolioEntry optimizedTransactions].
	^totalTransactions
	! !


!Portfolio methodsFor: 'adding' stamp: 'Lb 5/24/2021 21:17:54'!
add: aPortfolioEntry 
	self assertBelongsInPortfolio: aPortfolioEntry.
	self assertNotInTree: aPortfolioEntry.

	aPortfolioEntry beAddedTo: self.! !

!Portfolio methodsFor: 'adding' stamp: 'Lb 5/24/2021 21:17:54'!
safetlyAdd: aPortfolioEntry
	childElements add: aPortfolioEntry! !


!Portfolio methodsFor: 'asserts' stamp: 'Lb 5/24/2021 21:17:54'!
assertBelongsInPortfolio: aPortfolioEntry 
	(aPortfolioEntry isKindOf: PortfolioEntry) ifFalse: [^self error: self class errorInvalidTypeMessage].! !

!Portfolio methodsFor: 'asserts' stamp: 'Lb 5/25/2021 17:49:38'!
assertNotInTree: aPortfolioEntry 
	((self includes: aPortfolioEntry) or: [self existsInParents: aPortfolioEntry])
		ifTrue: [^self error: self class errorElementAlreadyAddedMessage ].! !

!Portfolio methodsFor: 'asserts' stamp: 'Lb 5/25/2021 20:40:32'!
assertPortfolioIncludesTransactionAccountDirectly: aTransaction
	(childElements includes: (aTransaction account))
		ifFalse: [^self error: self class errorTransactionCantBeAddedMessage ].! !

!Portfolio methodsFor: 'asserts' stamp: 'Lb 5/25/2021 17:10:52'!
assertTransactionNotRegistered: aTransaction
	(transactions includes: aTransaction)
		ifTrue: [^self error: self class errorTransactionCantBeAddedMessage ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'LB 5/22/2021 19:04:21'!
errorElementAlreadyAddedMessage
	^'Error account already added to this portfolio.'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'LB 5/22/2021 10:32:08'!
errorInvalidTypeMessage
	^'Error invalid type.'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'Lb 5/24/2021 22:00:49'!
errorTransactionCantBeAddedMessage
	^'error'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
PortfolioEntry subclass: #ReceptiveAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'transactions' stamp: 'Lb 5/24/2021 21:29:20'!
register: aTransaction
	transactions add: aTransaction.
	self registerOnParents: aTransaction.
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'LB 5/24/2021 20:49:36'!
balance
	^transactions inject: 0 into: [:balance :transaction | transaction addTo: balance ].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'LB 5/22/2021 12:15:50'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'LB 5/24/2021 20:17:43'!
includes: aPortfolioEntry
	^self = aPortfolioEntry! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'lb 5/24/2021 16:57:18'!
totalAccounts 
	^ 1! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'LB 5/24/2021 20:33:43'!
totalPortfolios 
	^ 0! !


!ReceptiveAccount methodsFor: 'private' stamp: 'Lb 5/24/2021 21:33:59'!
beAddedTo: aPortfolio
	aPortfolio safetlyAdd: self.
	parentPortfolios add: aPortfolio.
	transactions do: [:aTransaction | aPortfolio register: aTransaction].! !

!ReceptiveAccount methodsFor: 'private' stamp: 'Lb 5/25/2021 17:08:08'!
optimizedTransactions 
	^OrderedCollection new! !

!ReceptiveAccount methodsFor: 'private' stamp: 'Lb 5/24/2021 21:29:57'!
registerOnParents: aTransaction

	^ parentPortfolios do: [:aParentPortfolio | aParentPortfolio register: aTransaction]! !
