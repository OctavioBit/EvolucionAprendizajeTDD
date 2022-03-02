!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'depositOf100 depositOf150'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'testing - private' stamp: 'ENC 5/24/2021 23:53:18'!
accountWith: aTransaction

	| account |
	
	account := ReceptiveAccount new.	
	account register: aTransaction.
		
	^ account ! !

!PortfolioTest methodsFor: 'testing - private' stamp: 'ENC 5/25/2021 00:07:28'!
portfolioWith: aFinantialAsset

	| portfolio |
	
	portfolio := Portfolio new.
	portfolio register: aFinantialAsset .
	
	^ portfolio ! !

!PortfolioTest methodsFor: 'testing - private' stamp: 'ENC 5/25/2021 15:21:31'!
portfolioWithSubportofolioWith: aFinantialAsset

	| portfolio subportfolio |
	
	subportfolio := self portfolioWith: aFinantialAsset.
	portfolio := self portfolioWith: subportfolio.
	
	^ portfolio! !

!PortfolioTest methodsFor: 'testing - private' stamp: 'ENC 5/25/2021 00:13:49'!
shouldRaiseErrorAlreadyRegisteredFor: aBlock
	
	self
		should: aBlock 
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio errorAlreadyRegistered ].! !


!PortfolioTest methodsFor: 'testing' stamp: 'ENC 5/20/2021 20:50:26'!
setUp

	depositOf100 := Deposit for: 100.
	depositOf150 := Deposit for: 150.! !

!PortfolioTest methodsFor: 'testing' stamp: 'ENC 5/25/2021 15:36:23'!
test01BalanceOfEmptyPortfolioIsZero

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: 0 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'testing' stamp: 'ENC 5/25/2021 15:53:49'!
test02BalanceOfAPortfolioWithADepositOf100Is100

	| portfolio |
	
	portfolio := self portfolioWith: (self accountWith: depositOf100).
	
	self assert: 100 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'testing' stamp: 'ENC 5/25/2021 15:54:13'!
test03BalanceOfAPortfolioWithMultipleAccountsIsTheSumOfTheirBalances

	| portfolio |
	
	portfolio := self portfolioWith: (self accountWith: depositOf100).
	portfolio register: (self accountWith: depositOf150).
	
	self assert: 250 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'testing' stamp: 'ENC 5/25/2021 15:40:16'!
test04AnEmptyPortfolioDoesNotHasRegisteredAnyTransaction

	| portfolio |
	
	portfolio := Portfolio new.
	
	self deny: (portfolio hasRegistered: depositOf100).! !

!PortfolioTest methodsFor: 'testing' stamp: 'ENC 5/25/2021 15:40:46'!
test05APortfolioWithADepositOf100HasRegisteredTheDepositOf100

	| portfolio |
	
	portfolio := self portfolioWith: (self accountWith: depositOf100).
	
	self assert: (portfolio hasRegistered: depositOf100).! !

!PortfolioTest methodsFor: 'testing' stamp: 'ENC 5/25/2021 15:41:14'!
test06AnEmptyPortfolioReturnEmptyCollectionOfTransactions

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: portfolio transactions isEmpty.! !

!PortfolioTest methodsFor: 'testing' stamp: 'ENC 5/25/2021 15:57:53'!
test07APortfolioWithADepositOf100IncludesOnlyTheDepositOf100

	| portfolio |
	
	portfolio := self portfolioWith: (self accountWith: depositOf100).	
	
	self assert: 1 equals: portfolio transactions size.
	self assert: (portfolio transactions includes: depositOf100).! !

!PortfolioTest methodsFor: 'testing' stamp: 'ENC 5/25/2021 15:58:50'!
test08BalanceOfAPortfolioIncludesBalanceOfSubportfolios

	| portfolio |
	
	portfolio := self portfolioWithSubportofolioWith: (self accountWith: depositOf100). 
	
	self assert: 100 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'testing' stamp: 'ENC 5/25/2021 16:01:07'!
test09APortfolioHasRegisteredTheTransactionsOfSubporfolio

	| portfolio |
	
	portfolio := self portfolioWithSubportofolioWith: (self accountWith: depositOf100). 
	
	self assert: (portfolio hasRegistered: depositOf100).! !

!PortfolioTest methodsFor: 'testing' stamp: 'ENC 5/25/2021 16:00:42'!
test10TransactionsOfAPortfolioIncludesTransactionsOfSubportfolio

	| portfolio |
	
	portfolio := self portfolioWithSubportofolioWith: (self accountWith: depositOf100). 
	
	self assert: 1 equals: portfolio transactions size.
	self assert: (portfolio transactions includes: depositOf100).! !

!PortfolioTest methodsFor: 'testing' stamp: 'ENC 5/25/2021 15:46:53'!
test11RaiseErrorWhenRegisteringTwiceTheSameAccount

	| portfolio account |
	
	account := self accountWith: depositOf100.
	portfolio := self portfolioWith: account.
	
	self shouldRaiseErrorAlreadyRegisteredFor: [ portfolio register: account. ]	.! !

!PortfolioTest methodsFor: 'testing' stamp: 'ENC 5/25/2021 15:48:24'!
test12RaiseErrorWhenRegisteringAccountOnSubportfolioAndPortfolio

	| portfolio account |
	
	account := self accountWith: depositOf100.
	portfolio := self portfolioWithSubportofolioWith: account. 
	
	self shouldRaiseErrorAlreadyRegisteredFor: [ portfolio register: account. ].! !

!PortfolioTest methodsFor: 'testing' stamp: 'ENC 5/25/2021 15:49:25'!
test13RaiseErrorWhenRegisteringTwiceASubsubportfolio

	| portfolio subsubportfolio |
	
	subsubportfolio := self portfolioWith: (self accountWith: depositOf100).
	portfolio := self portfolioWithSubportofolioWith: subsubportfolio. 
	
	self shouldRaiseErrorAlreadyRegisteredFor: [ portfolio register: subsubportfolio. ].! !

!PortfolioTest methodsFor: 'testing' stamp: 'ENC 5/25/2021 15:50:09'!
test14RaiseErrorWhenRegisteringAccountOnPortfolioAndSubportfolio

	| portfolio subportfolio account |
	
	account := self accountWith: depositOf100.
	portfolio := self portfolioWith: account.
	subportfolio := Portfolio new.
	portfolio register: subportfolio.
	
	self shouldRaiseErrorAlreadyRegisteredFor: [ subportfolio register: account. ]! !

!PortfolioTest methodsFor: 'testing' stamp: 'ENC 5/25/2021 15:51:18'!
test15RaiseErrorWhenRegisteringASubportfolioWithAnAccountAlreadyRegisteredInPortfolio

	| portfolio account subportfolio |
	
	account := self accountWith: depositOf100.
	subportfolio := self portfolioWith: account.
	portfolio := self portfolioWithSubportofolioWith: account. 
	
	self shouldRaiseErrorAlreadyRegisteredFor: [ portfolio register: subportfolio. ]! !

!PortfolioTest methodsFor: 'testing' stamp: 'ENC 5/25/2021 15:52:52'!
test16RaiseErrorWhenRegisteringAccountAlreadyRegisteredOnAParent

	| subportfolio account portfolioA portfolioB |
	
	account := self accountWith: depositOf100.
	subportfolio := Portfolio new.
	
	portfolioA := self portfolioWith: subportfolio.
	portfolioA register: account.
	portfolioB := self portfolioWith: subportfolio.
	
	self shouldRaiseErrorAlreadyRegisteredFor: [ subportfolio register: account. ]! !


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
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'ENC 5/24/2021 23:21:59'!
value

	^ value! !


!AccountTransaction methodsFor: 'balance' stamp: 'ENC 5/24/2021 22:50:20'!
addValueTo: aPartialBalance

	self subclassResponsibility.! !


!AccountTransaction methodsFor: 'initialization' stamp: 'ENC 5/24/2021 23:21:52'!
initializeFor: aValue
	
	value := aValue ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'ENC 5/24/2021 23:23:04'!
for: aValue

	^ self new initializeFor: aValue ! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'balance' stamp: 'ENC 5/24/2021 22:50:07'!
addValueTo: aPartialBalance

	^ aPartialBalance + value! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'balance' stamp: 'ENC 5/24/2021 22:50:14'!
addValueTo: aPartialBalance

	^ aPartialBalance - value! !


!classDefinition: #FinantialAsset category: 'Portfolio-Ejercicio'!
Object subclass: #FinantialAsset
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinantialAsset methodsFor: 'initialization' stamp: 'ENC 5/24/2021 23:06:31'!
initialize

	self subclassResponsibility ! !

!FinantialAsset methodsFor: 'initialization' stamp: 'ENC 5/24/2021 23:06:34'!
registerAsParent: aPortfolio

	self subclassResponsibility ! !


!FinantialAsset methodsFor: 'operations' stamp: 'ENC 5/24/2021 23:06:53'!
balance

	self subclassResponsibility ! !

!FinantialAsset methodsFor: 'operations' stamp: 'ENC 5/24/2021 23:06:38'!
hasAssociated: aFinantialAsset

	self subclassResponsibility ! !

!FinantialAsset methodsFor: 'operations' stamp: 'ENC 5/24/2021 23:06:42'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!FinantialAsset methodsFor: 'operations' stamp: 'ENC 5/24/2021 23:06:45'!
register: aFinantialAsset

	self subclassResponsibility ! !

!FinantialAsset methodsFor: 'operations' stamp: 'ENC 5/24/2021 23:06:49'!
transactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinantialAsset subclass: #Portfolio
	instanceVariableNames: 'finantialAssets state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'MS 5/24/2021 00:18:25'!
initialize
	
	finantialAssets := 	OrderedCollection new.
	state := PortfolioStateRoot new.! !

!Portfolio methodsFor: 'initialization' stamp: 'ENC 5/24/2021 23:05:01'!
registerAsParent: aPortfolio

	state register: aPortfolio asNewParentOf: self.! !

!Portfolio methodsFor: 'initialization' stamp: 'ENC 5/24/2021 23:04:54'!
subportfolioOf: aParentPortfolio

	state := PortfolioStateSubPortfolio withParent: aParentPortfolio.
	! !


!Portfolio methodsFor: 'operations - private' stamp: 'ENC 5/25/2021 15:32:04'!
detectIfAny: aBlock
	
	finantialAssets detect: [ :finantialAsset | aBlock value: finantialAsset ] 
	ifFound: [ :foundFinantialAsset | ^ true ] 
	ifNone: [ ^ false ].! !

!Portfolio methodsFor: 'operations - private' stamp: 'ENC 5/24/2021 23:05:27'!
hasAssociated: aFinantialAsset in: parents

	parents do: [ :aParent | (aParent hasParentAssociatedWith: aFinantialAsset) ifTrue: [ ^true ] ].
	
	^ false.
	! !

!Portfolio methodsFor: 'operations - private' stamp: 'ENC 5/25/2021 15:31:16'!
hasParentAssociatedWith: aFinantialAsset

	^ state checkIf: aFinantialAsset isAssociatedInParentsOf: self.! !

!Portfolio methodsFor: 'operations - private' stamp: 'ENC 5/25/2021 16:02:32'!
transactionsForPortfolio
	
	^ self transactions! !


!Portfolio methodsFor: 'operations' stamp: 'MS 5/23/2021 23:17:21'!
balance
	
	^ finantialAssets sum: [ :aFinantialAsset | aFinantialAsset balance ] ifEmpty: [ 0 ].! !

!Portfolio methodsFor: 'operations' stamp: 'ENC 5/24/2021 23:46:11'!
checkInnerFinantialAssetsAssociatedWith: aPortfolio
	
	^ finantialAssets do: [ :aFinantialAsset | aPortfolio hasAssociated: aFinantialAsset ].! !

!Portfolio methodsFor: 'operations' stamp: 'ENC 5/24/2021 23:44:23'!
hasAssociated: anotherFinantialAsset

	(finantialAssets includes: anotherFinantialAsset) ifTrue: [ ^ self error: self class errorAlreadyRegistered ].

	anotherFinantialAsset checkInnerFinantialAssetsAssociatedWith: self.
	
	^ self detectIfAny: [ :aFinantialAsset | aFinantialAsset hasAssociated: anotherFinantialAsset ].! !

!Portfolio methodsFor: 'operations' stamp: 'ENC 5/24/2021 23:39:28'!
hasRegistered: aTransaction
	
	^ self detectIfAny: [ :aFinantialAsset | aFinantialAsset hasRegistered: aTransaction ].! !

!Portfolio methodsFor: 'operations' stamp: 'ENC 5/25/2021 15:31:16'!
register: aFinantialAsset 

	state checkIf: aFinantialAsset isAssociatedInParentsOf: self.
	
	aFinantialAsset registerAsParent: self.
	finantialAssets add: aFinantialAsset.! !

!Portfolio methodsFor: 'operations' stamp: 'ENC 5/25/2021 16:04:54'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.	
	
	finantialAssets do: [ :aFinantialAsset | transactions := transactions, aFinantialAsset transactionsForPortfolio ].
	
	^ transactions.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'ENC 5/20/2021 20:47:57'!
errorAlreadyRegistered

	^ 'Ya se encuentra registrado en el portfolio'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinantialAsset subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'MS 5/24/2021 00:40:11'!
registerAsParent: aPortfolio
! !


!ReceptiveAccount methodsFor: 'operations - private' stamp: 'ENC 5/25/2021 16:01:56'!
transactionsForPortfolio 

	^ transactions! !


!ReceptiveAccount methodsFor: 'operations' stamp: 'ENC 5/24/2021 23:06:10'!
balance

	| partialBalance |
	
	partialBalance := 0.
	
	transactions do: [ :aTransaction | partialBalance := aTransaction addValueTo: partialBalance ].
	
	^ partialBalance! !

!ReceptiveAccount methodsFor: 'operations' stamp: 'MS 5/24/2021 16:49:56'!
checkInnerFinantialAssetsAssociatedWith: aPortfolio! !

!ReceptiveAccount methodsFor: 'operations' stamp: 'MS 5/24/2021 00:00:01'!
hasAssociated: aReceptiveAccount

	^ self = aReceptiveAccount ! !

!ReceptiveAccount methodsFor: 'operations' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'operations' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'operations' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!classDefinition: #PortfolioState category: 'Portfolio-Ejercicio'!
Object subclass: #PortfolioState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioState methodsFor: 'parenting' stamp: 'ENC 5/25/2021 15:31:16'!
checkIf: aFinantialAsset isAssociatedInParentsOf: aPortfolio

	self subclassResponsibility ! !

!PortfolioState methodsFor: 'parenting' stamp: 'ENC 5/24/2021 23:07:40'!
register: aParentPortfolio asNewParentOf: aPortfolio

	self subclassResponsibility! !


!classDefinition: #PortfolioStateRoot category: 'Portfolio-Ejercicio'!
PortfolioState subclass: #PortfolioStateRoot
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioStateRoot methodsFor: 'parenting' stamp: 'ENC 5/25/2021 15:31:16'!
checkIf: aFinantialAsset isAssociatedInParentsOf: aPortfolio

	^ aPortfolio hasAssociated: aFinantialAsset.! !

!PortfolioStateRoot methodsFor: 'parenting' stamp: 'ENC 5/24/2021 23:08:25'!
register: aParentPortfolio asNewParentOf: aPortfolio

	aPortfolio subportfolioOf: aParentPortfolio! !


!classDefinition: #PortfolioStateSubPortfolio category: 'Portfolio-Ejercicio'!
PortfolioState subclass: #PortfolioStateSubPortfolio
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioStateSubPortfolio methodsFor: 'initialization' stamp: 'MS 5/24/2021 16:55:51'!
initializeWithParent: aPortfolio

	parents := OrderedCollection new.
	parents add: aPortfolio.! !


!PortfolioStateSubPortfolio methodsFor: 'parenting' stamp: 'ENC 5/25/2021 15:31:16'!
checkIf: aFinantialAsset isAssociatedInParentsOf: aPortfolio

	^ aPortfolio hasAssociated: aFinantialAsset in: parents.! !

!PortfolioStateSubPortfolio methodsFor: 'parenting' stamp: 'ENC 5/24/2021 23:08:32'!
register: aParentPortfolio asNewParentOf: aPortfolio

	parents add: aParentPortfolio.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioStateSubPortfolio class' category: 'Portfolio-Ejercicio'!
PortfolioStateSubPortfolio class
	instanceVariableNames: ''!

!PortfolioStateSubPortfolio class methodsFor: 'class initialization' stamp: 'ENC 5/24/2021 23:15:38'!
withParent: aParentPortfolio

	^ self new initializeWithParent: aParentPortfolio.! !
