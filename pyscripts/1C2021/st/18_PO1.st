!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JR 5/25/2021 16:32:25'!
test01PortfolioHasZeroAsBalanceWhenCreated 

	|aPortfolio|
	
	aPortfolio := Portfolio new.
	
	self assert: aPortfolio balance equals: 0! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JR 5/25/2021 16:33:21'!
test02AddingAccountModifiesBalance

	|aPortfolio anAccount |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	Withdraw register: 50 on: anAccount.
	
	aPortfolio := Portfolio new.
	
	aPortfolio add: anAccount.
	
	self assert: aPortfolio balance equals: anAccount balance! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JR 5/25/2021 16:35:09'!
test03BalanceAfterAddingMultipleAccountsIsSumOfTheirBalances

	|aPortfolio anAccount1 anAccount2 |
	
	anAccount1 := ReceptiveAccount new.
	Deposit register: 100 on: anAccount1.
	Withdraw register: 50 on: anAccount1.
	
	anAccount2 := ReceptiveAccount new.
	Deposit register: 10 on: anAccount2.
	Withdraw register: 5 on: anAccount2.
	
	aPortfolio := Portfolio new.
	
	aPortfolio add: anAccount1.
	aPortfolio add: anAccount2.
	
	self assert: aPortfolio balance equals: (anAccount1 balance + anAccount2 balance)! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JR 5/25/2021 16:35:25'!
test04AddingPortfolioModifiesBalance

	|aPortfolio1 aPortfolio2 anAccount1 anAccount2 |
	
	anAccount1 := ReceptiveAccount new.
	Deposit register: 100 on: anAccount1.
	Withdraw register: 50 on: anAccount1.
	
	anAccount2 := ReceptiveAccount new.
	Deposit register: 10 on: anAccount2.
	Withdraw register: 5 on: anAccount2.
	
	aPortfolio1 := Portfolio new.
	
	aPortfolio1 add: anAccount1.
	aPortfolio1 add: anAccount2.
	
	aPortfolio2 := Portfolio new.
	
	aPortfolio2 add: aPortfolio1.
	
	self assert: aPortfolio2 balance equals: (aPortfolio1 balance)! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JR 5/25/2021 16:36:36'!
test05APortfolioKnowsItsAccountsRegisteredTransactions

	|aPortfolio anAccount1 anAccount2 aTransaction1 aTransaction2|
	
	anAccount1 := ReceptiveAccount new.
	aTransaction1 := Deposit register: 100 on: anAccount1.
	Withdraw register: 50 on: anAccount1.
	
	anAccount2 := ReceptiveAccount new.
	Deposit register: 10 on: anAccount2.
	aTransaction2 := Withdraw register: 5 on: anAccount2.
	
	aPortfolio := Portfolio new.
	
	aPortfolio add: anAccount1.
	aPortfolio add: anAccount2.
	
	self assert: (aPortfolio hasRegistered: aTransaction1).
	self assert: (aPortfolio hasRegistered: aTransaction2).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JR 5/25/2021 16:37:00'!
test06APortfolioKnowsItsPortfoliosRegisteredTransactions

	|aPortfolio1 aPortfolio2 anAccount1 anAccount2 aTransaction|
	
	anAccount1 := ReceptiveAccount new.
	aTransaction := Deposit register: 100 on: anAccount1.
	Withdraw register: 50 on: anAccount1.
	
	anAccount2 := ReceptiveAccount new.
	Deposit register: 10 on: anAccount2.
	Withdraw register: 5 on: anAccount2.
	
	aPortfolio1 := Portfolio new.
	
	aPortfolio1 add: anAccount1.
	aPortfolio1 add: anAccount2.
	
	aPortfolio2 := Portfolio new.
	
	aPortfolio2 add: aPortfolio1.
	
	self assert: (aPortfolio2 hasRegistered: aTransaction) ! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JR 5/25/2021 16:37:35'!
test07APortfolioKnowsItsAccountTransactions

	|aPortfolio anAccount1 anAccount2|
	
	anAccount1 := ReceptiveAccount new.
	Deposit register: 100 on: anAccount1.
	Withdraw register: 50 on: anAccount1.
	
	anAccount2 := ReceptiveAccount new.
	Deposit register: 10 on: anAccount2.
	Withdraw register: 5 on: anAccount2.
	
	aPortfolio := Portfolio new.
	
	aPortfolio add: anAccount1.
	aPortfolio add: anAccount2.
	
	self assert: aPortfolio transactions equals: (anAccount1 transactions , anAccount2 transactions) asOrderedCollection.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JR 5/25/2021 16:37:54'!
test08APortfolioKnowsItsPortfoliosTransactions

	|aPortfolio1 aPortfolio2 anAccount1 anAccount2 |
	
	anAccount1 := ReceptiveAccount new.
	Deposit register: 100 on: anAccount1.
	Withdraw register: 50 on: anAccount1.
	
	anAccount2 := ReceptiveAccount new.
	Deposit register: 10 on: anAccount2.
	Withdraw register: 5 on: anAccount2.
	
	aPortfolio1 := Portfolio new.
	
	aPortfolio1 add: anAccount1.
	aPortfolio1 add: anAccount2.
	
	aPortfolio2 := Portfolio new.
	
	aPortfolio2 add: aPortfolio1.
	
	self assert: aPortfolio2 transactions equals: aPortfolio1 transactions.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JR 5/25/2021 16:38:24'!
test09AccountsCanNotBeDuplicatedInPortfolio

	|aPortfolio1 anAccount1 aPortfolio2 |
	
	anAccount1 := ReceptiveAccount new.
	Deposit register: 100 on: anAccount1.
	Withdraw register: 50 on: anAccount1.
	
	aPortfolio2 := Portfolio new.
	aPortfolio2 add: anAccount1.
		
	aPortfolio1 := Portfolio new.
	aPortfolio1 add: anAccount1.
	
	self 
		should: [ aPortfolio1 add: anAccount1.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: Portfolio portfoliosLoopError equals: anError messageText.
			self assert: aPortfolio1 balance equals: anAccount1 balance]	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JR 5/25/2021 16:40:29'!
test10PortfoliosCanNotFormLoop

	|aPortfolio1 anAccount1 aPortfolio2 aPortfolio3 |
	
	anAccount1 := ReceptiveAccount new.
	Deposit register: 100 on: anAccount1.
	Withdraw register: 50 on: anAccount1.
	
	aPortfolio2 := Portfolio new.
	aPortfolio2 add: anAccount1.
		
	aPortfolio1 := Portfolio new.
	
	aPortfolio3 := Portfolio new.
	aPortfolio3 add: aPortfolio1.
	aPortfolio2 add: aPortfolio3.
	
	self 
		should: [ aPortfolio1 add: aPortfolio2.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: Portfolio portfoliosLoopError equals: anError messageText.
			self assert: aPortfolio1 balance equals: 0]	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JR 5/25/2021 16:41:58'!
test11PortfoliosCanNotFormLoopWithTheirChilds

	|aPortfolio1 anAccount1 aPortfolio2 aPortfolio3 aPortfolio4 aPortfolio5|
	
	anAccount1 := ReceptiveAccount new.
	Deposit register: 100 on: anAccount1.
	Withdraw register: 50 on: anAccount1.
	
	aPortfolio3 := Portfolio new.
	aPortfolio3 add: anAccount1.
	
	aPortfolio5 := Portfolio new.	
	aPortfolio5 add: aPortfolio3.
		
	aPortfolio4 := Portfolio new.
	aPortfolio4 add: aPortfolio5.
	
	aPortfolio1 := Portfolio new.
	aPortfolio1 add: aPortfolio3.
	
	aPortfolio2 := Portfolio new.
	aPortfolio2 add: aPortfolio3.
	
	self 
		should: [aPortfolio1 add: aPortfolio4] 
		raise:  Error - MessageNotUnderstood
		withExceptionDo: [:anError |
			self assert: Portfolio portfoliosLoopError equals: anError messageText.]	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTest class' category: 'Portfolio-Ejercicio'!
PortfolioTest class
	instanceVariableNames: ''!

!PortfolioTest class methodsFor: 'as yet unclassified' stamp: 'JR 5/24/2021 16:05:49'!
DoIt

|aPortfolio anAccount1 anAccount2 xxx|
	
	anAccount1 := ReceptiveAccount new.
	Deposit register: 100 on: anAccount1.
	Withdraw register: 50 on: anAccount1.
	
	anAccount2 := ReceptiveAccount new.
	Deposit register: 10 on: anAccount2.
	Withdraw register: 5 on: anAccount2.
	
	aPortfolio := Portfolio new.
	
	aPortfolio addAccount: anAccount1.
	aPortfolio addAccount: anAccount2.
	
	xxx := (anAccount1 transactions , anAccount2 transactions )asOrderedCollection .
	
	self assert: aPortfolio transactions equals: xxx.! !


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


!AccountTransaction methodsFor: 'balance' stamp: 'JR 5/17/2021 21:52:39'!
weighIn: aBalance

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


!Deposit methodsFor: 'balance' stamp: 'JR 5/17/2021 21:53:34'!
weighIn: aBalance

	^aBalance + value! !

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


!Withdraw methodsFor: 'value' stamp: 'JR 5/17/2021 20:29:46'!
value

	^ value ! !


!Withdraw methodsFor: 'balance' stamp: 'JR 5/17/2021 21:53:23'!
weighIn: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialAsset category: 'Portfolio-Ejercicio'!
Object subclass: #FinancialAsset
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialAsset methodsFor: 'assertions' stamp: 'JR 5/25/2021 16:16:14'!
assertDoesNotContain: aFinancialAsset

	self subclassResponsibility ! !

!FinancialAsset methodsFor: 'assertions' stamp: 'JR 5/25/2021 16:18:53'!
assertDoesNotContainAccount: anAccount

	self subclassResponsibility ! !

!FinancialAsset methodsFor: 'assertions' stamp: 'JR 5/25/2021 16:18:59'!
assertDoesNotContainPortfolio: aPortfolio

	self subclassResponsibility ! !


!FinancialAsset methodsFor: 'adding - private' stamp: 'JR 5/25/2021 15:15:26'!
beAddedTo: aPortfolio

	parents add: aPortfolio ! !


!FinancialAsset methodsFor: 'transactions' stamp: 'JR 5/25/2021 16:20:05'!
transactions

	self subclassResponsibility ! !


!FinancialAsset methodsFor: 'testing' stamp: 'JR 5/25/2021 16:20:23'!
hasRegistered: aTransactions

	self subclassResponsibility ! !


!FinancialAsset methodsFor: 'initialization' stamp: 'JR 5/25/2021 16:21:17'!
initialize

	self subclassResponsibility ! !


!FinancialAsset methodsFor: 'balance' stamp: 'JR 5/25/2021 16:19:40'!
balance

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialAsset subclass: #Portfolio
	instanceVariableNames: 'financialAssets'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'JR 5/24/2021 16:17:25'!
balance
	
	^ (financialAssets sum: [:asset | asset balance] ifEmpty: [0]) ! !


!Portfolio methodsFor: 'adding' stamp: 'JR 5/25/2021 16:15:05'!
add: aFinancialAsset 
	
	self assertCanBeAdded: aFinancialAsset .
	
	financialAssets add: aFinancialAsset.
	aFinancialAsset beAddedTo: self.
! !


!Portfolio methodsFor: 'initialization' stamp: 'JR 5/25/2021 15:16:30'!
initialize

	financialAssets := OrderedCollection new.
	parents := OrderedCollection new.
	! !


!Portfolio methodsFor: 'assertions' stamp: 'JR 5/25/2021 16:17:24'!
assertCanBeAdded: aFinancialAsset

	(parents isEmpty) 
	ifTrue: [	(aFinancialAsset  = self) ifTrue: [self error: Portfolio portfoliosLoopError].
		    financialAssets do: [:asset | asset assertDoesNotContain: aFinancialAsset].]
	ifFalse: [parents do: [:padre | padre assertCanBeAdded: aFinancialAsset]].! !

!Portfolio methodsFor: 'assertions' stamp: 'JR 5/25/2021 16:16:14'!
assertDoesNotContain: aFinancialAsset

	aFinancialAsset assertDoesNotContainPortfolio: self 
	! !

!Portfolio methodsFor: 'assertions' stamp: 'JR 5/25/2021 15:50:35'!
assertDoesNotContainAccount: anAccount

	financialAssets do: [:asset | asset assertDoesNotContainAccount: anAccount ]! !

!Portfolio methodsFor: 'assertions' stamp: 'JR 5/25/2021 16:16:14'!
assertDoesNotContainPortfolio: aPortfolio

	financialAssets do: [:asset | asset assertDoesNotContainPortfolio: aPortfolio.
			(aPortfolio financialAssets) do: [:hijo | asset assertDoesNotContain: hijo ]]! !


!Portfolio methodsFor: 'testing' stamp: 'JR 5/24/2021 16:18:02'!
hasRegistered: aTransaction

	^(financialAssets anySatisfy: [:asset | asset hasRegistered: aTransaction])! !


!Portfolio methodsFor: 'transactions' stamp: 'JR 5/25/2021 16:30:44'!
transactions
	
	|allTransactions|
	
	allTransactions := OrderedCollection new	.
	
	financialAssets do: [:asset | allTransactions addAll: asset transactions].
	
	^allTransactions  ! !


!Portfolio methodsFor: 'accessing' stamp: 'JR 5/25/2021 15:31:35'!
financialAssets

	^financialAssets copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'JR 5/24/2021 16:50:41'!
portfoliosLoopError

	^'Adding this portfolio is not allowed'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialAsset subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'JR 5/25/2021 15:16:41'!
initialize

	transactions := OrderedCollection new.
	parents := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'JR 5/17/2021 21:59:16'!
balance
	
	|currentBalance|
	
	currentBalance _ 0.
	
	transactions do: [:aTransaction | currentBalance _ aTransaction weighIn: currentBalance].
	
	^currentBalance ! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'assertions' stamp: 'JR 5/25/2021 16:17:51'!
assertDoesNotContain: aFinancialAsset

	aFinancialAsset assertDoesNotContainAccount: self ! !

!ReceptiveAccount methodsFor: 'assertions' stamp: 'JR 5/25/2021 15:49:31'!
assertDoesNotContainAccount: anAccount

		(self = anAccount) ifTrue: [self error: 	Portfolio portfoliosLoopError].! !

!ReceptiveAccount methodsFor: 'assertions' stamp: 'JR 5/25/2021 15:49:57'!
assertDoesNotContainPortfolio: aPortfolio

	aPortfolio assertDoesNotContainAccount: self! !
