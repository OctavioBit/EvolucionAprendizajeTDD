!classDefinition: #PortafolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortafolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortafolioTest methodsFor: 'private - tests' stamp: 'FG 11/6/2020 19:44:36'!
should: aBlockThatShouldFail raisingAnErrorAndAsserting: aVerificationBlock

    [aBlockThatShouldFail value. self fail.]
    on: Error
    do: aVerificationBlock.! !


!PortafolioTest methodsFor: 'tests' stamp: 'LNB 11/9/2020 15:20:44'!
test01BalanceIsZeroWhenCreatingAPortfolio

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: portfolio balance equals: 0.! !

!PortafolioTest methodsFor: 'tests' stamp: 'LNB 11/9/2020 15:31:49'!
test02BalanceChangesAfterRegisteringTransactionsInAChildAccount

	| portfolio receptiveAccount|
	
	portfolio := Portfolio new.
	receptiveAccount := ReceptiveAccount new.
	portfolio register: receptiveAccount.
	Deposit register: 100 on: receptiveAccount. 
	
	self assert: portfolio balance equals: 100.! !

!PortafolioTest methodsFor: 'tests' stamp: 'LNB 11/9/2020 15:35:55'!
test03BalanceIncludesAllTransactionsFoundInChildrenAccounts

	"Test repetido"
	
	| portfolio firstReceptiveAccount secondReceptiveAccount|
	
	portfolio := Portfolio new.
	firstReceptiveAccount := ReceptiveAccount new.
	secondReceptiveAccount := ReceptiveAccount  new.
	
	portfolio register: firstReceptiveAccount.
	portfolio register: secondReceptiveAccount.
	
	Deposit register: 100 on: firstReceptiveAccount. 
	Deposit register: 500 on: secondReceptiveAccount.
	
	self assert: portfolio balance equals: 600.! !

!PortafolioTest methodsFor: 'tests' stamp: 'LNB 11/9/2020 15:36:29'!
test04BalanceChangesWhenAnyDescendantAccountRegistersTransactions
	
	| ParentPortfolio ChildPortfolio ChildReceptiveAccount|
	
	ParentPortfolio := Portfolio new.
	ChildPortfolio := Portfolio new.
	
	ParentPortfolio  register: ChildPortfolio.
	
	ChildReceptiveAccount := ReceptiveAccount new.
	ChildPortfolio register: 	ChildReceptiveAccount.
	
	Deposit register: 100 on: ChildReceptiveAccount.
	
	self assert: ParentPortfolio balance equals: 100.
	
	! !

!PortafolioTest methodsFor: 'tests' stamp: 'LNB 11/9/2020 15:37:22'!
test05PortfoliosAreAbleToFindAnyTransactionRegisteredByAnyDescendant
	
	| parentPortfolio childPortfolio receptiveAccount transaction|
	
	parentPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	receptiveAccount  := ReceptiveAccount new.
	
	parentPortfolio register: childPortfolio.
	childPortfolio register: receptiveAccount.
	
	transaction := Deposit register: 100 on: receptiveAccount.
	
	self assert: (parentPortfolio hasRegistered: transaction).	

	! !

!PortafolioTest methodsFor: 'tests' stamp: 'LNB 11/9/2020 15:38:04'!
test06PortfoliosCreatedWithAnEmptyTransactionLog
	
	| portfolio|
	
	portfolio := Portfolio new.
	
	self assert: portfolio transactions size equals: 0.	

	! !

!PortafolioTest methodsFor: 'tests' stamp: 'LNB 11/9/2020 15:38:33'!
test07TransactionsAreLoggedProperlyFromChildrenAccounts
	
	| portfolio receptiveAccount transaction|
	
	portfolio := Portfolio new.
	receptiveAccount  := ReceptiveAccount new.
	
	portfolio register: receptiveAccount.
	transaction := Deposit register: 100 on: receptiveAccount.
	
	self assert: portfolio transactions size equals: 1.
	self assert: portfolio  transactions includes: 	transaction.

	! !

!PortafolioTest methodsFor: 'tests' stamp: 'LNB 11/9/2020 15:39:17'!
test08TransactionsAreLoggedProperlyFromDescendantAccounts
	
	| parentPortfolio childPorfolio childReceptiveAccount parentReceptiveAccount parentTransaction childTransaction|
	
	parentPortfolio := Portfolio new.
	childPorfolio := Portfolio new.
	parentReceptiveAccount  := ReceptiveAccount new.
	childReceptiveAccount  := ReceptiveAccount new.
	
	parentPortfolio register: childPorfolio.
	parentPortfolio register: parentReceptiveAccount.
	childPorfolio  register: childReceptiveAccount.
	
	parentTransaction := Deposit register: 100 on: parentReceptiveAccount.
	
	self assert: parentPortfolio transactions size equals: 1.
	self assert: parentPortfolio transactions includes: 	parentTransaction.
	
	childTransaction := Deposit register: 150 on: childReceptiveAccount.
	
	self assert: parentPortfolio transactions size equals: 2.
	self assert: parentPortfolio transactions includes: 	parentTransaction.
	self assert: parentPortfolio transactions includes: childTransaction.
	! !

!PortafolioTest methodsFor: 'tests' stamp: 'LNB 11/9/2020 15:40:08'!
test09APortfolioCantRegisterToItselfAsAnAsset
	
	| parentPortfolio  |
	
	parentPortfolio := Portfolio new.

	self 
		should: [parentPortfolio register: parentPortfolio ] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TransactionRegister cantAddTransactionRegisterToPortfolio]. 
	! !

!PortafolioTest methodsFor: 'tests' stamp: 'LNB 11/9/2020 15:41:38'!
test10CantRegisterAPortfolioThatADescendantAlreadyOwns
	
	| parentPortfolio  childPortfolio grandParentPortfolio|
	
	parentPortfolio := Portfolio new.
	childPortfolio  := Portfolio new.
	grandParentPortfolio := Portfolio new.
	
	parentPortfolio register: childPortfolio.
	grandParentPortfolio  register: parentPortfolio.	

	self 
		should: [grandParentPortfolio register: childPortfolio ] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TransactionRegister cantAddTransactionRegisterToPortfolio]. 
	! !

!PortafolioTest methodsFor: 'tests' stamp: 'LNB 11/9/2020 15:52:22'!
test11CantRegisterAnAlreadyAscendantPortfolio
	
	| childPortfolio secondChildPortfolio parentPortfolio|
	
	secondChildPortfolio := Portfolio new.
	childPortfolio  := Portfolio new.
	parentPortfolio := Portfolio new.
	
	parentPortfolio register: childPortfolio.
	parentPortfolio  register: secondChildPortfolio.	

	self 
		should: [secondChildPortfolio register: childPortfolio ] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TransactionRegister cantAddTransactionRegisterToPortfolio]. 
	! !

!PortafolioTest methodsFor: 'tests' stamp: 'LNB 11/9/2020 15:53:39'!
test12CantRegisterAReceptiveAccountThatADescendantAlreadyOwns
	
	| parentPortfolio childPortfolio  receptiveAccount |
	
	parentPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	receptiveAccount  := ReceptiveAccount new.
	
	parentPortfolio  register: childPortfolio.
	childPortfolio  register: receptiveAccount.
		
	self 
		should: [parentPortfolio register: receptiveAccount ] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TransactionRegister cantAddTransactionRegisterToPortfolio]. 
	! !

!PortafolioTest methodsFor: 'tests' stamp: 'LNB 11/9/2020 15:54:36'!
test13CantRegisterAReceptiveAccountThatAnAscendantAlreadyOwns
	
	| parentPortfolio childPortfolio receptiveAccount |
	
	parentPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	receptiveAccount  := ReceptiveAccount new.
	
	parentPortfolio  register: childPortfolio.
	parentPortfolio  register: receptiveAccount.
		
	self 
		should: [childPortfolio register: receptiveAccount ] 
		raisingAnErrorAndAsserting: [:anError | self assert: anError messageText = TransactionRegister cantAddTransactionRegisterToPortfolio]. 
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


!AccountTransaction methodsFor: 'logging' stamp: 'LNB 11/9/2020 15:17:55'!
logTo: accountValue
	self subclassResponsibility.! !

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


!Deposit methodsFor: 'logging' stamp: 'LNB 11/9/2020 15:17:55'!
logTo: accountValue
	^ accountValue + value.! !

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

!Withdraw methodsFor: 'initialization' stamp: 'FG 11/2/2020 19:21:56'!
initializeFor: aValue
	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'FG 11/2/2020 19:21:51'!
value
	^ value! !


!Withdraw methodsFor: 'logging' stamp: 'LNB 11/9/2020 15:17:55'!
logTo: accountValue
 	^ accountValue - value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransactionRegister category: 'Portfolio-Ejercicio'!
Object subclass: #TransactionRegister
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransactionRegister methodsFor: 'as yet unclassified' stamp: 'FG 11/6/2020 18:46:01'!
balance
	self subclassResponsibility.! !

!TransactionRegister methodsFor: 'as yet unclassified' stamp: 'FG 11/6/2020 18:46:11'!
hasRegistered
	self subclassResponsibility.! !

!TransactionRegister methodsFor: 'as yet unclassified' stamp: 'FG 11/6/2020 18:46:40'!
register: aTransactionsRegister
	self subclassResponsibility.! !

!TransactionRegister methodsFor: 'as yet unclassified' stamp: 'FG 11/6/2020 18:46:24'!
transactions
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransactionRegister class' category: 'Portfolio-Ejercicio'!
TransactionRegister class
	instanceVariableNames: ''!

!TransactionRegister class methodsFor: 'as yet unclassified' stamp: 'FG 11/6/2020 19:40:43'!
cantAddTransactionRegisterToPortfolio
	^ ' Error - You cant add TransactionRegister to this Portfolio '! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
TransactionRegister subclass: #Portfolio
	instanceVariableNames: 'transactionsRegisters'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'FG 11/6/2020 19:50:31'!
initialize
	transactionsRegisters := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'transactions' stamp: 'FG 11/6/2020 19:55:42'!
register: aTransactionRegister

	(self checkIfInvalid: aTransactionRegister) ifTrue: [self error: TransactionRegister cantAddTransactionRegisterToPortfolio].

	transactionsRegisters add: aTransactionRegister.
	aTransactionRegister addParent: self.! !

!Portfolio methodsFor: 'transactions' stamp: 'FG 11/6/2020 18:43:55'!
transactions
	|allTransactions|
	
	allTransactions := OrderedCollection new.

	transactionsRegisters do: [:aTransactionsRegister | allTransactions addAll: aTransactionsRegister transactions asArray; yourself].
	
	^ allTransactions.! !


!Portfolio methodsFor: 'testing' stamp: 'FG 11/6/2020 18:43:23'!
hasRegistered: aTransaction 
	
	| registeredUpToNow |
	
	registeredUpToNow := false.
	
	transactionsRegisters do: [:anAccount | registeredUpToNow := (anAccount hasRegistered: aTransaction) or: [registeredUpToNow] ].
	
	^ registeredUpToNow.! !


!Portfolio methodsFor: 'error checking - register validation' stamp: 'FG 11/6/2020 20:10:35'!
addParent: aPortfolio
	parents add: aPortfolio.! !

!Portfolio methodsFor: 'error checking - register validation' stamp: 'FG 11/6/2020 20:17:56'!
checkIfInvalid:  aTransactionRegister
	
	| isAlreadyConnectedToMe |
	
 	isAlreadyConnectedToMe := (aTransactionRegister = self) or: [ self isAscendantOf: aTransactionRegister ].
	
	parents do:[:aParent | isAlreadyConnectedToMe := isAlreadyConnectedToMe or:[aParent checkIfInvalid: aTransactionRegister ]].
	
	^ isAlreadyConnectedToMe.! !

!Portfolio methodsFor: 'error checking - register validation' stamp: 'FG 11/6/2020 20:09:45'!
isAscendantOf: aTransactionRegister

	| isAscendant |
	
	isAscendant := false.
	
	transactionsRegisters do:[:anotherTransactionRegister | 
		isAscendant := (aTransactionRegister = anotherTransactionRegister) or: [isAscendant  or: [anotherTransactionRegister isAscendantOf: aTransactionRegister]] ].
	
	^ isAscendant.! !


!Portfolio methodsFor: 'balance' stamp: 'FG 11/6/2020 18:44:11'!
balance
	^ (transactionsRegisters sum: [:aTransactionsRegister | aTransactionsRegister balance] ifEmpty: [0])! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'FG 11/2/2020 19:55:31'!
new
	^ self basicNew initialize.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
TransactionRegister subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'FG 11/6/2020 19:50:44'!
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


!ReceptiveAccount methodsFor: 'balance' stamp: 'LNB 11/9/2020 15:17:55'!
balance

	|balance|
	balance := 0.
	transactions do: [ :aTransaction | balance := aTransaction logTo: balance ].
	^balance.! !


!ReceptiveAccount methodsFor: 'error checking - register validation' stamp: 'FG 11/6/2020 20:11:40'!
addParent: aPortfolio
	parents add: aPortfolio.! !

!ReceptiveAccount methodsFor: 'error checking - register validation' stamp: 'FG 11/6/2020 20:14:46'!
isAscendantOf: aTransactionRegister
	^ false.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
