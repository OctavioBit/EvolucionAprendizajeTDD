!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests - transactions' stamp: 'FR 11/5/2020 23:07:56'!
test04EmptyPortfolioHasNoTransactions

	| aPortfolio |
	
	aPortfolio := Portfolio new.
		
	self assert: aPortfolio transactions isEmpty! !

!PortfolioTest methodsFor: 'tests - transactions' stamp: 'FR 11/8/2020 20:52:02'!
test05PortfolioWithChildrenHasTheirTransactions

	| aPortfolio aSubportfolio anAccount anotherAccount aTransaction anotherTransaction expectedTransactions|
	
	aPortfolio := Portfolio new.
	aSubportfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	aPortfolio addAsset: anAccount.
	aPortfolio addAsset: aSubportfolio.
	aSubportfolio addAsset: anotherAccount.
	
	aTransaction := Deposit register: 50 on: anAccount.
	anotherTransaction := Deposit register: 10 on: anotherAccount.
	
	expectedTransactions := Set new.
	expectedTransactions add: aTransaction.
	expectedTransactions add: anotherTransaction.
	
	self assert: aPortfolio transactions equals: expectedTransactions! !


!PortfolioTest methodsFor: 'tests - balance' stamp: 'FR 11/5/2020 22:56:12'!
test01EmptyPortfolioHasBalanceZero

	| aPortfolio |
	
	aPortfolio := Portfolio new.
	
	self assert: aPortfolio balance equals: 0.! !

!PortfolioTest methodsFor: 'tests - balance' stamp: 'FR 11/8/2020 20:52:02'!
test02PortfolioWithAccountHasCorrectBalance

	| aPortfolio anAccount |
	
	aPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	
	aPortfolio addAsset: anAccount.
	
	Deposit register: 50 on: anAccount.
	
	self assert: aPortfolio balance equals: (anAccount balance).! !

!PortfolioTest methodsFor: 'tests - balance' stamp: 'FR 11/8/2020 20:52:02'!
test03PortfolioWithPortfoliosHasCorrectBalance

	| aPortfolio aSubPortfolio anotherSubPortfolio anAccount anotherAccount |
	
	aPortfolio := Portfolio new.
	aSubPortfolio := Portfolio new.
	anotherSubPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.

	aPortfolio addAsset: aSubPortfolio.
	aPortfolio addAsset: anotherSubPortfolio.

	aSubPortfolio addAsset: anAccount.
	anotherSubPortfolio addAsset: anotherAccount.
		
	Deposit register: 50 on: anAccount.
	Deposit register: 100 on: anotherAccount.

	self assert: aPortfolio balance equals: (anAccount balance + anotherAccount balance).! !


!PortfolioTest methodsFor: 'tests - hasRegistered' stamp: 'FR 11/5/2020 23:11:09'!
test06EmptyPortfolioHasntRegisteredTransactions

	| aPortfolio aTransaction |
	
	aPortfolio := Portfolio new.
	
	aTransaction := Deposit for: 50.
	
	self deny: (aPortfolio hasRegistered: aTransaction)! !

!PortfolioTest methodsFor: 'tests - hasRegistered' stamp: 'FR 11/8/2020 20:52:02'!
test07PortfolioWithAccountRegistersItsTransactions

	| aPortfolio anAccount aTransaction |
	
	aPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	
	aPortfolio addAsset: anAccount.
	
	aTransaction := Deposit register: 100 on: anAccount.
	
	self assert: (aPortfolio hasRegistered: aTransaction).! !

!PortfolioTest methodsFor: 'tests - hasRegistered' stamp: 'FR 11/8/2020 20:52:02'!
test08PortfolioWithPortfoliosRegistersItsTransactions

	| aPortfolio aSubPortfolio anotherSubPortfolio anAccount anotherAccount transactionOne transactionTwo transactionThree transactionFour |
	
	aPortfolio := Portfolio new.
	aSubPortfolio := Portfolio new.
	anotherSubPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.

	aPortfolio addAsset: aSubPortfolio.
	aPortfolio addAsset: anotherSubPortfolio.

	aSubPortfolio addAsset: anAccount.
	anotherSubPortfolio addAsset: anotherAccount.
		
	transactionOne := Deposit register: 50 on: anAccount.
	transactionTwo := Deposit register: 100 on: anotherAccount.
	transactionThree := Withdraw register: 10 on: anotherAccount.
	transactionFour := Withdraw for: 100.

	self assert: (aPortfolio hasRegistered: transactionOne).
	self assert: (aPortfolio hasRegistered: transactionTwo).
	self assert: (aPortfolio hasRegistered: transactionThree).
	self deny: (aPortfolio hasRegistered: transactionFour).! !


!PortfolioTest methodsFor: 'tests - addChild' stamp: 'FR 11/8/2020 11:14:41'!
test09CantAddMyself

	| aPortfolio |
	
	aPortfolio := Portfolio new.
	
	self assertCannotAdd: aPortfolio asChildTo: aPortfolio! !

!PortfolioTest methodsFor: 'tests - addChild' stamp: 'FR 11/8/2020 20:52:02'!
test10CantAddOneOfMyChildren

	| aPortfolio anAccount |
	
	aPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	
	aPortfolio addAsset: anAccount.
	
	self assertCannotAdd: anAccount asChildTo: aPortfolio! !

!PortfolioTest methodsFor: 'tests - addChild' stamp: 'FR 11/8/2020 20:52:02'!
test11CantAddSuccessor

	| aPortfolio anotherPortfolio anAccount |
	
	aPortfolio := Portfolio new.
	anotherPortfolio := Portfolio new.	
	anAccount := ReceptiveAccount new.
	
	aPortfolio addAsset: anotherPortfolio.
	anotherPortfolio addAsset: anAccount.
		
	self assertCannotAdd: anAccount asChildTo: aPortfolio! !

!PortfolioTest methodsFor: 'tests - addChild' stamp: 'FR 11/8/2020 20:52:02'!
test12CantAddOneOfMyParents

	| aPortfolio anotherPortfolio |
	
	aPortfolio := Portfolio new.
	anotherPortfolio := Portfolio new.	
	
	anotherPortfolio addAsset: aPortfolio.
	
	self assertCannotAdd: anotherPortfolio asChildTo: aPortfolio! !

!PortfolioTest methodsFor: 'tests - addChild' stamp: 'FR 11/8/2020 20:52:02'!
test13CantAddAnyOfMyParents

	| aSuperPortfolio anotherSuperPortfolio aPortfolio |
	
	aPortfolio := Portfolio new.
	aSuperPortfolio := Portfolio new.	
	anotherSuperPortfolio := Portfolio new.	
	
	aSuperPortfolio addAsset: aPortfolio.
	anotherSuperPortfolio addAsset: aPortfolio.

	self assertCannotAdd: aSuperPortfolio asChildTo: aPortfolio.
	self assertCannotAdd: anotherSuperPortfolio asChildTo: aPortfolio! !

!PortfolioTest methodsFor: 'tests - addChild' stamp: 'FR 11/8/2020 20:52:02'!
test14CantAddPredecessor

	| aSuperSuperPortfolio aSuperPortfolio aPortfolio |
	
	aPortfolio := Portfolio new.
	aSuperPortfolio := Portfolio new.	
	aSuperSuperPortfolio := Portfolio new.	
	
	aSuperSuperPortfolio addAsset: aSuperPortfolio.
	aSuperPortfolio addAsset: aPortfolio.

	self assertCannotAdd: aSuperSuperPortfolio asChildTo: aPortfolio! !

!PortfolioTest methodsFor: 'tests - addChild' stamp: 'FR 11/8/2020 20:52:02'!
test15CantAddPortfolioThatSharesSuccessorsWithMe

	| aPortfolio anotherPortfolio anAccount |
	
	aPortfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.

	aPortfolio addAsset: anAccount.
	anotherPortfolio addAsset: anAccount.

	self assertCannotAdd: anotherPortfolio asChildTo: aPortfolio! !

!PortfolioTest methodsFor: 'tests - addChild' stamp: 'FR 11/8/2020 20:52:02'!
test16CantAddPortfolioThatSharesSuccessorsWithOneOfMyPredecessors

	| portfolioOne portfolioTwo portfolioThree portfolioFour anAccount |
	
	portfolioOne := Portfolio new.
	portfolioTwo := Portfolio new.
	portfolioThree := Portfolio new.
	portfolioFour := Portfolio new.
	anAccount := ReceptiveAccount new.

	portfolioOne addAsset: anAccount.
	portfolioOne addAsset: portfolioThree.
	portfolioTwo addAsset: anAccount.
	portfolioThree addAsset: portfolioFour.

	self assertCannotAdd: portfolioTwo asChildTo: portfolioFour! !


!PortfolioTest methodsFor: 'private - assertions' stamp: 'FR 11/8/2020 20:52:02'!
assertCannotAdd: aBankAsset asChildTo: anotherBankAsset

	^ self  should: [ anotherBankAsset addAsset: aBankAsset ]
		raise: Error - MessageNotUnderstood
		withMessageText: Portfolio cannotAddChildErrorDescription! !


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


!AccountTransaction methodsFor: 'balance' stamp: 'FR 11/8/2020 20:44:19'!
evaluateOnBalance: aBalance
	
	^ self subclassResponsibility! !

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


!Deposit methodsFor: 'balance' stamp: 'FR 11/8/2020 20:44:19'!
evaluateOnBalance: aBalance
	
	^ aBalance + self value! !

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


!Withdraw methodsFor: 'balance' stamp: 'FR 11/8/2020 20:44:19'!
evaluateOnBalance: aBalance
	
	^ aBalance - self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #BankAsset category: 'Portfolio-Ejercicio'!
Object subclass: #BankAsset
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!BankAsset methodsFor: 'private - transactions' stamp: 'FR 11/8/2020 11:36:39'!
addTransactionsTo: aTransactionsCollection

	self subclassResponsibility! !


!BankAsset methodsFor: 'private - adding' stamp: 'FR 11/8/2020 11:57:22'!
addParent: aPortfolio

	parents add: aPortfolio! !

!BankAsset methodsFor: 'private - adding' stamp: 'FR 11/8/2020 11:35:40'!
successors

	self subclassResponsibility! !


!BankAsset methodsFor: 'initialization' stamp: 'FR 11/8/2020 11:33:05'!
initialize

	self subclassResponsibility! !


!BankAsset methodsFor: 'balance' stamp: 'FR 11/8/2020 11:33:25'!
balance

	self subclassResponsibility! !


!BankAsset methodsFor: 'transactions' stamp: 'FR 11/8/2020 11:37:32'!
transactions

	self subclassResponsibility! !


!BankAsset methodsFor: 'testing' stamp: 'FR 11/8/2020 11:38:00'!
hasRegistered: aTransaction

	self subclassResponsibility! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
BankAsset subclass: #Portfolio
	instanceVariableNames: 'assets'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'FR 11/8/2020 20:42:14'!
initialize

	assets := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'FR 11/8/2020 20:53:51'!
balance
	
	^assets sum: [ :aBankAsset | aBankAsset balance ] ifEmpty: [0]! !


!Portfolio methodsFor: 'assertions' stamp: 'FR 11/8/2020 20:53:34'!
assertCanAddAsset: aBankAssetToAdd

	(self sharesAssetsWithMyRootPredecessors: aBankAssetToAdd) ifTrue: [ self cannotAddChildError ]! !


!Portfolio methodsFor: 'modifying' stamp: 'FR 11/8/2020 20:52:31'!
addAsset: aBankAssetToAdd

	self assertCanAddAsset: aBankAssetToAdd.
	
	aBankAssetToAdd addParent: self.
	assets add: aBankAssetToAdd! !


!Portfolio methodsFor: 'testing' stamp: 'FR 11/5/2020 23:13:55'!
hasRegistered: aTransaction
	
	^ self transactions includes: aTransaction! !


!Portfolio methodsFor: 'transactions' stamp: 'FR 11/8/2020 20:56:12'!
transactions
	
	| myTransactions |
	
	myTransactions := Set new.
	
	assets do: [ :aBankAsset | aBankAsset addTransactionsTo: myTransactions ].
	
	^myTransactions! !


!Portfolio methodsFor: 'errors' stamp: 'FR 11/8/2020 12:10:03'!
cannotAddChildError

	self error: self class cannotAddChildErrorDescription! !


!Portfolio methodsFor: 'private - transactions' stamp: 'FR 11/8/2020 20:52:59'!
addTransactionsTo: aTransactionCollection

	assets do: [ :aBankAsset | aBankAsset addTransactionsTo: aTransactionCollection ].! !


!Portfolio methodsFor: 'private - adding' stamp: 'FR 11/8/2020 22:21:10'!
rootPredecessors

	| myRootPredecessors |
	
	myRootPredecessors := Set new.
	
	parents ifEmpty: [
		myRootPredecessors add: self
	]
	ifNotEmpty: [
		parents do: [ :aParent | myRootPredecessors addAll: aParent rootPredecessors ]
	].
	
	^myRootPredecessors! !

!Portfolio methodsFor: 'private - adding' stamp: 'FR 11/8/2020 20:55:39'!
sharesAssetsWith: aBankAsset

	| myAssets otherAssets |
	
	myAssets := Set new.
	myAssets addAll: self successors.
	myAssets add: self.
	
	otherAssets := Set new.
	otherAssets addAll: aBankAsset successors.
	otherAssets add: aBankAsset.
	
	^ (myAssets intersection: otherAssets) isEmpty not! !

!Portfolio methodsFor: 'private - adding' stamp: 'FR 11/8/2020 20:55:51'!
sharesAssetsWithMyRootPredecessors: aBankAsset

	^ self rootPredecessors anySatisfy: [ :aRootPredecessor | aRootPredecessor sharesAssetsWith: aBankAsset ]! !

!Portfolio methodsFor: 'private - adding' stamp: 'FR 11/8/2020 20:56:00'!
successors

	| mySuccessors |
	
	mySuccessors := assets copy.
	assets do: [ :aBankAsset | mySuccessors addAll: aBankAsset successors ].
	
	^mySuccessors! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'FR 11/8/2020 09:53:56'!
cannotAddChildErrorDescription

	^ 'Cannot add this child: adding it would duplicate information!!'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
BankAsset subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'FR 11/8/2020 10:15:46'!
initialize

	transactions := OrderedCollection new.
	parents := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'private - transactions' stamp: 'FR 11/8/2020 12:16:35'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'FR 11/8/2020 20:44:19'!
balance

	| myBalance |
	
	myBalance := 0.

	transactions do: [ :aTransaction | myBalance := aTransaction evaluateOnBalance: myBalance ].
	
	^myBalance! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'private - adding' stamp: 'FR 11/8/2020 10:52:23'!
successors

	^ OrderedCollection new! !
