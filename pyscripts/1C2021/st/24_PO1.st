!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'account transactions' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'account transactions' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'account transactions' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!ReceptiveAccountTest methodsFor: 'account withdraw' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !


!ReceptiveAccountTest methodsFor: 'account balance' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'account balance' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'account balance' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !


!ReceptiveAccountTest methodsFor: 'portfolio balance' stamp: 'nz 5/24/2021 21:40:55'!
test08EmptyPortfolioHasZeroBalance
	
	| portfolio |
	
	portfolio _ Portfolio new.
	
	self assert: portfolio balance equals: 0.
! !

!ReceptiveAccountTest methodsFor: 'portfolio balance' stamp: 'nz 5/24/2021 21:43:55'!
test09BalanceOfPortfolioWithOneAccountEqualsToAccountBalance
	
	| portfolio anAccount |
	
	portfolio _ Portfolio new.
	
	anAccount _ ReceptiveAccount new.
	
	Deposit register: 100 on: anAccount.
	
	portfolio addAsset: anAccount.
	
	self assert: portfolio balance equals: 100.
! !

!ReceptiveAccountTest methodsFor: 'portfolio balance' stamp: 'nz 5/24/2021 21:44:44'!
test10BalanceOfPortfolioWithManyAccountsEqualsToTheSumOfTheirBalances
	
	| portfolio anAccount anotherAccount |
	
	portfolio _ Portfolio new.
	
	anAccount _ ReceptiveAccount new.
	anotherAccount _ ReceptiveAccount new.
	
	Deposit register: 100 on: anAccount.
	Deposit register: 50 on: anAccount.
	
	portfolio addAsset: anAccount.
	portfolio addAsset: anotherAccount .
	
	self assert: portfolio balance equals: 150.
! !


!ReceptiveAccountTest methodsFor: 'portfolio transactions' stamp: 'nz 5/24/2021 21:46:02'!
test11PortfolioWithOneAccountHasRegisteredTheTransactionsOfThatAccount
	
	| portfolio anAccount aTransaction |
	
	portfolio _ Portfolio new.
	
	anAccount _ ReceptiveAccount new.
	
	aTransaction _ Deposit register: 500 on: anAccount.
	
	portfolio addAsset: anAccount.
	
	self assert: (portfolio hasRegistered: aTransaction).
! !

!ReceptiveAccountTest methodsFor: 'portfolio transactions' stamp: 'nz 5/24/2021 21:57:59'!
test12EmptyPortfolioHasNotRegisteredATransactionOfAnExternalAccount
	
	| portfolio anAccount aTransaction |
	
	portfolio _ Portfolio new.
	
	anAccount _ ReceptiveAccount new.
	
	aTransaction _ Deposit register: 500 on: anAccount.
	
	self deny: (portfolio hasRegistered: aTransaction).
! !

!ReceptiveAccountTest methodsFor: 'portfolio transactions' stamp: 'nz 5/24/2021 21:50:43'!
test13PortfolioWithMultipleAccountsHasRegisteredAllTheirTransactions
	
	| portfolio anAccount anotherAccount aTransaction anotherTransaction |
	
	portfolio _ Portfolio new.
	
	anAccount _ ReceptiveAccount new.
	anotherAccount _ ReceptiveAccount new.
	
	aTransaction _ Deposit register: 500 on: anAccount.
	anotherTransaction _ Deposit register: 200 on: anotherAccount.
	
	portfolio addAsset: anAccount.
	portfolio addAsset: anotherAccount.
	
	self assert: (portfolio hasRegistered: aTransaction).
	self assert: (portfolio hasRegistered: anotherTransaction).
! !

!ReceptiveAccountTest methodsFor: 'portfolio transactions' stamp: 'nz 5/24/2021 21:53:57'!
test14PortfolioWithNestedPortfolioHasRegisteredAccountTransactions
	
	| portfolio anotherPortfolio anAccount aTransaction |
	
	portfolio _ Portfolio new.
	
	anotherPortfolio _ Portfolio new.
	portfolio addAsset: anotherPortfolio.
	
	anAccount _ ReceptiveAccount new.
	anotherPortfolio addAsset: anAccount.
	
	aTransaction _ Deposit register: 500 on: anAccount.
	
	self assert: (portfolio hasRegistered: aTransaction).
! !

!ReceptiveAccountTest methodsFor: 'portfolio transactions' stamp: 'nz 5/24/2021 21:57:48'!
test15NotEmptyPortfolioHasNotRegisteredATransactionOfAnExternalAccount
	
	| portfolio emptyPortfolio anAccount aTransaction |
	
	portfolio _ Portfolio new.
	emptyPortfolio _ Portfolio new.
	
	anAccount _ ReceptiveAccount new.
	
	aTransaction _ Deposit register: 500 on: anAccount.
	
	portfolio addAsset: emptyPortfolio.
	
	self deny: (portfolio hasRegistered: aTransaction).
! !

!ReceptiveAccountTest methodsFor: 'portfolio transactions' stamp: 'nz 5/24/2021 22:03:38'!
test16PortfolioWithMultipleNestedPortfoliosHasRegisteredAllTheirTransactions
	
	| mainPortfolio secondPortfolio thirdPortfolio anotherAccount anAccount aTransaction anotherTransaction |
	
	mainPortfolio _ Portfolio new.
	secondPortfolio _ Portfolio new.
	thirdPortfolio _ Portfolio new.
	
	anAccount _ ReceptiveAccount new.
	aTransaction _ Deposit register: 500 on: anAccount.
	secondPortfolio addAsset: anAccount.
	
	anotherAccount _ ReceptiveAccount new.
	anotherTransaction _ Deposit register: 300 on: anotherAccount.
	thirdPortfolio addAsset: anotherAccount.
	
	mainPortfolio addAsset: secondPortfolio.
	mainPortfolio addAsset: thirdPortfolio.
	
	self assert: (mainPortfolio hasRegistered: aTransaction).
	self assert: (mainPortfolio hasRegistered: anotherTransaction).
! !

!ReceptiveAccountTest methodsFor: 'portfolio transactions' stamp: 'nz 5/24/2021 22:05:01'!
test17PortfolioWithAnAccountAndAnEmptyPortfolioHasAccountTransactions
	
	| mainPortfolio secondPortfolio anAccount aTransaction |
	
	mainPortfolio _ Portfolio new.
	
	secondPortfolio _ Portfolio new.
	mainPortfolio addAsset: secondPortfolio.
	
	anAccount _ ReceptiveAccount new.
	mainPortfolio addAsset: anAccount.
	
	aTransaction _ Deposit register: 500 on: anAccount.
	
	self assert: (mainPortfolio hasRegistered: aTransaction).
! !

!ReceptiveAccountTest methodsFor: 'portfolio transactions' stamp: 'nz 5/24/2021 22:23:45'!
test24EmptyPortfolioHasNoTransactions
	
	| aPortfolio |
	
	aPortfolio _ Portfolio new.
	
	self assert: aPortfolio transactions isEmpty.! !

!ReceptiveAccountTest methodsFor: 'portfolio transactions' stamp: 'nz 5/24/2021 22:24:14'!
test25PortfolioWithOneAccountHasAllItsTransactions
	
	| aPortfolio anAccount aTransaction |
	
	aPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	aPortfolio addAsset: anAccount.
	
	aTransaction _ Deposit register: 200 on: anAccount.
	
	self assert: aPortfolio transactions size equals: 1.
	self assert: aPortfolio transactions first equals: aTransaction.! !


!ReceptiveAccountTest methodsFor: 'portfolio addAsset validation' stamp: 'nz 5/24/2021 22:05:51'!
test18CannotAddAnAccountTwiceToAPortfolio
	
	| mainPortfolio anAccount |
	
	mainPortfolio _ Portfolio new.
	
	anAccount _ ReceptiveAccount new.
	mainPortfolio addAsset: anAccount.
	
	self should: [mainPortfolio addAsset: anAccount.]
		raise: Error
		withMessageText: Portfolio duplicatedAssetErrorDescription.
! !

!ReceptiveAccountTest methodsFor: 'portfolio addAsset validation' stamp: 'nz 5/24/2021 22:06:14'!
test19CantAddPortfolioToItself
	
	| mainPortfolio |
	
	mainPortfolio _ Portfolio new.
		
	self should: [ 	mainPortfolio addAsset: mainPortfolio. ]
		raise: Error
		withMessageText: Portfolio duplicatedAssetErrorDescription.
! !

!ReceptiveAccountTest methodsFor: 'portfolio addAsset validation' stamp: 'nz 5/24/2021 22:10:03'!
test20CantAddAnAccountThatIsInANestedPortfolio
	
	| mainPortfolio innerPortfolio anAccount |
	
	mainPortfolio _ Portfolio new.
	innerPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	
	mainPortfolio addAsset: innerPortfolio.
	innerPortfolio addAsset: anAccount.
		
	self should: [ 	mainPortfolio addAsset: anAccount. ]
		raise: Error
		withMessageText: Portfolio duplicatedAssetErrorDescription.
! !

!ReceptiveAccountTest methodsFor: 'portfolio addAsset validation' stamp: 'nz 5/24/2021 22:21:07'!
test21CantAddAnAccountThatIsInAPortfolioALevelAbove
	
	| mainPortfolio innerPortfolio anAccount |
	
	mainPortfolio _ Portfolio new.
	innerPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	
	mainPortfolio addAsset: innerPortfolio.
	mainPortfolio addAsset: anAccount.
		
	self should: [ 		innerPortfolio addAsset: anAccount. ]
		raise: Error
		withMessageText: Portfolio duplicatedAssetErrorDescription.
! !

!ReceptiveAccountTest methodsFor: 'portfolio addAsset validation' stamp: 'nz 5/24/2021 22:19:38'!
test22CantAddAnAccountThatIsInAPortfolioManyLevelsAbove
	
	| rootPortfolio childPortfolio grandChildPortfolio anAccount |
	
	rootPortfolio _ Portfolio new.
	childPortfolio _ Portfolio new.
	grandChildPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	
	rootPortfolio addAsset: childPortfolio .
	rootPortfolio addAsset: anAccount.
	childPortfolio addAsset: grandChildPortfolio.
		
	self should: [ 		grandChildPortfolio addAsset: anAccount. ]
		raise: Error
		withMessageText: Portfolio duplicatedAssetErrorDescription.
! !

!ReceptiveAccountTest methodsFor: 'portfolio addAsset validation' stamp: 'nz 5/24/2021 22:23:03'!
test23CantAddAPortfolioWithDuplicatedAccount
	
	| rootPortfolio leftPortfolio rightPortfolio anAccount |
	
	rootPortfolio _ Portfolio new.
	leftPortfolio _ Portfolio new.
	rightPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
		
	rootPortfolio addAsset: leftPortfolio.
	leftPortfolio addAsset: anAccount.
	rightPortfolio addAsset: anAccount.
		
	self should: [ rootPortfolio addAsset: rightPortfolio. ]
		raise: Error
		withMessageText: Portfolio duplicatedAssetErrorDescription.
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'AW 5/17/2021 20:34:53'!
applyOnBalance: aBalance

	self subclassResponsibility.! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'AW 5/23/2021 19:36:17'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account registerTransaction: transaction.
		
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


!Deposit methodsFor: 'value' stamp: 'AW 5/17/2021 20:35:53'!
applyOnBalance: aBalance

	^aBalance + self value.! !

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


!Withdraw methodsFor: 'value' stamp: 'AW 5/17/2021 20:36:06'!
applyOnBalance: aBalance

	^aBalance - self value.! !

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


!classDefinition: #FinancialAsset category: 'Portfolio-Ejercicio'!
Object subclass: #FinancialAsset
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialAsset methodsFor: 'balance' stamp: 'AW 5/23/2021 20:12:07'!
balance
	self subclassResponsibility.! !


!FinancialAsset methodsFor: 'private' stamp: 'nz 5/24/2021 21:29:16'!
addedToPortfolio: aPortfolio

	self subclassResponsibility .! !

!FinancialAsset methodsFor: 'private' stamp: 'AW 5/23/2021 20:11:34'!
hasAsset: anAsset
	self subclassResponsibility.! !

!FinancialAsset methodsFor: 'private' stamp: 'nz 5/24/2021 21:08:13'!
leaves

	self subclassResponsibility .! !


!FinancialAsset methodsFor: 'transactions' stamp: 'AW 5/23/2021 20:12:41'!
hasRegistered: aTransaction

	self subclassResponsibility.! !

!FinancialAsset methodsFor: 'transactions' stamp: 'nz 5/24/2021 21:24:27'!
transactions

	self subclassResponsibility .! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialAsset subclass: #Portfolio
	instanceVariableNames: 'financialAssets rootPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'validation' stamp: 'nz 5/24/2021 20:54:43'!
assetGeneratesDuplication: aFinancialAsset

	"Usamos `leaves` porque reduce busquedas"
	^ aFinancialAsset leaves anySatisfy: [ :asset | self isOnAnotherPortfolioThatIncludesMe: asset ]! !

!Portfolio methodsFor: 'validation' stamp: 'nz 5/24/2021 20:51:20'!
isOnAnotherPortfolioThatIncludesMe: aFinancialAsset

	^ rootPortfolios anySatisfy: [ :aPortfolio | aPortfolio isSelfOrIsInPortfolio: aFinancialAsset ]! !

!Portfolio methodsFor: 'validation' stamp: 'nz 5/24/2021 20:55:11'!
validateAssetInclusion: aFinancialAsset
	
	(self assetGeneratesDuplication: aFinancialAsset)
		ifTrue: [^self error: self class duplicatedAssetErrorDescription ].! !


!Portfolio methodsFor: 'assets' stamp: 'nz 5/24/2021 21:04:44'!
addAsset: aFinancialAsset 
	
	self validateAssetInclusion: aFinancialAsset.

	financialAssets add: aFinancialAsset.
	aFinancialAsset addedToPortfolio: self.! !


!Portfolio methodsFor: 'initialization' stamp: 'AW 5/23/2021 21:08:05'!
initialize

	financialAssets _ OrderedCollection new.
	rootPortfolios _ OrderedCollection with: self.! !


!Portfolio methodsFor: 'balance' stamp: 'AW 5/23/2021 19:30:12'!
balance
	
	^ financialAssets sum: [ :financialAsset | financialAsset balance ] ifEmpty: [ 0 ].! !


!Portfolio methodsFor: 'private' stamp: 'AW 5/23/2021 21:08:05'!
addedToPortfolio: aPortfolio 
	
	rootPortfolios addAll: aPortfolio rootPorfolios.! !

!Portfolio methodsFor: 'private' stamp: 'AW 5/23/2021 20:03:14'!
hasAsset: aFinancialAsset

	^(financialAssets includes: aFinancialAsset) or: [ financialAssets anySatisfy: [ :anAsset | anAsset hasAsset: aFinancialAsset ] ].! !

!Portfolio methodsFor: 'private' stamp: 'AW 5/23/2021 21:24:33'!
isSelfOrIsInPortfolio: aFinancialAsset 

	^(self = aFinancialAsset) or: [ self hasAsset: aFinancialAsset ]! !

!Portfolio methodsFor: 'private' stamp: 'AW 5/23/2021 22:30:06'!
leaves
	^financialAssets 
		ifEmpty: [ OrderedCollection with: self ] 
		ifNotEmpty: [ (financialAssets collect: [ :asset | asset leaves ]) flatten ]! !

!Portfolio methodsFor: 'private' stamp: 'AW 5/23/2021 21:08:05'!
rootPorfolios
	^rootPortfolios .! !


!Portfolio methodsFor: 'transactions' stamp: 'AW 5/23/2021 19:28:55'!
hasRegistered: aTransaction 
	
	^financialAssets anySatisfy: [ :anAsset | anAsset hasRegistered: aTransaction ].! !

!Portfolio methodsFor: 'transactions' stamp: 'AW 5/23/2021 22:29:28'!
transactions
	^(financialAssets collect: [ :anAsset | anAsset transactions. ]) flatten.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'errors' stamp: 'AW 5/23/2021 21:58:40'!
duplicatedAssetErrorDescription
	^'This leads to an asset being duplicated in a portfolio.'.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialAsset subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'AW 5/23/2021 19:35:54'!
registerTransaction: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'AW 5/17/2021 20:37:02'!
balance

	^transactions inject: 0 into: [ :currentBalance :aTransaction | aTransaction applyOnBalance: currentBalance  ]! !


!ReceptiveAccount methodsFor: 'private' stamp: 'AW 5/23/2021 20:31:42'!
addedToPortfolio: aPortfolio ! !

!ReceptiveAccount methodsFor: 'private' stamp: 'AW 5/23/2021 20:05:05'!
hasAsset: anAsset 
	^false.! !

!ReceptiveAccount methodsFor: 'private' stamp: 'AW 5/23/2021 21:51:29'!
leaves
	^OrderedCollection with: self.! !
