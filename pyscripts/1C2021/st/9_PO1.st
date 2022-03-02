!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GR 5/25/2021 22:02:16'!
test01EmptyPortfolioShouldHaveZeroBalance

	|portfolio|
	
	portfolio := Portfolio new.
	
	self assert: 0 equals: portfolio balance.
	
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GR 5/25/2021 22:05:40'!
test02PortfolioWithOneAccountShouldHaveSameBalanceAsAccount

	|portfolio account|
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	
	Deposit register: 100 on: account. 
	
	portfolio add: account.
	
	self assert: 100 equals: portfolio balance.
	
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GR 5/25/2021 22:07:12'!
test03PortfolioShouldHaveSameBalanceAsSumOfAssetsBalance

	|portfolio account1 account2|
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	
	Deposit register: 100 on: account1. 
	
	portfolio add: account1.
	
	account2 := ReceptiveAccount new.
	
	Deposit register: 200 on: account2. 
	
	portfolio add: account2.
	
	self assert: 300 equals: portfolio balance.
	
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GR 5/25/2021 22:52:09'!
test04PortfolioShouldNotHaveResgisteredUnrelatedTransactions

	|portfolio account transaction|
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	
	transaction := Deposit for: 100. 
	
	portfolio add: account.
	
	self deny: (portfolio hasRegistered: transaction).
	
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GR 5/25/2021 22:52:15'!
test05EmptyPortfolioShouldNotHaveTransactions

	|portfolio|
	
	portfolio := Portfolio new.
	
	self assert: (portfolio transactions isEmpty).
	
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GR 5/25/2021 22:52:37'!
test06PortfolioShouldHaveRegisteredItsAssetsTransactions

	|portfolio1 portfolio2 account deposit|
	
	portfolio1 := Portfolio new.
	
	portfolio2 := Portfolio new.
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: account. 
	
	portfolio2 add: account.
	
	portfolio1 add: portfolio2.
	
	self assert: (portfolio1 hasRegistered: deposit).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GR 5/25/2021 22:52:42'!
test07CombinedPortfolioShouldKnowItsBalance

	|parentPortfolio childPortfolio1 childPortfolio2 account1 account2|
	
	childPortfolio1 := Portfolio new.
	
	childPortfolio2 := Portfolio new.
	
	parentPortfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	
	Deposit register: 100 on: account1. 
	
	childPortfolio1 add: account1.
	
	account2 := ReceptiveAccount new.
	
	Deposit register: 200 on: account2. 
	
	childPortfolio2 add: account2.
	
	parentPortfolio add: childPortfolio1 .
	
	parentPortfolio add: childPortfolio2.
	
	self assert: 300 equals: parentPortfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GR 5/25/2021 22:52:52'!
test08PortfolioShouldKnowItsAssetsTransactions

	|parentPortfolio childPortfolio account deposit transactions|
	
	parentPortfolio := Portfolio new.
	
	childPortfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: account. 
	
	childPortfolio add: account.
	
	parentPortfolio add: childPortfolio.
	
	transactions := parentPortfolio transactions.
	
	self assert: 1 equals: transactions size.
	
	self assert: (transactions includes: deposit ).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GR 5/25/2021 22:52:59'!
test09CannotAddSameAssetTwice

	|parentPortfolio childPortfolio|
	
	parentPortfolio := Portfolio new.
	
	childPortfolio := Portfolio new.
	
	parentPortfolio add: childPortfolio .
	
	self 
		should: [parentPortfolio add: childPortfolio]
		
		raise: Error
		
		withExceptionDo: [:anError | 
			
			self assert: anError messageText = Portfolio assetHasAssetsInCommonErrorDescription.
		].
	
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GR 5/25/2021 22:53:04'!
test10CannotAddAssetWithAssetsInCommon

	|childPortfolio1 childPortfolio2 parentPortfolio assetInCommon|
	
	childPortfolio1 := Portfolio new.
	
	childPortfolio2 := Portfolio new.

	parentPortfolio := Portfolio new.
	
	assetInCommon := Portfolio new.
	
	childPortfolio1 add: assetInCommon .
	
	childPortfolio2 add: assetInCommon .
	
	parentPortfolio add: childPortfolio1.
	
	self 
		should: [parentPortfolio add: childPortfolio2]
		
		raise: Error
		
		withExceptionDo: [:anError | 
			
			self assert: anError messageText = Portfolio assetHasAssetsInCommonErrorDescription.
		].
	
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GR 5/25/2021 22:53:08'!
test11CannotAddAssetWithAssetsInCommonWithAncestry

	|rootPortfolio middlePortfolio leafPortfolio portfolioWithAssetInCommon assetInCommon|
	
	rootPortfolio := Portfolio new.
	
	middlePortfolio := Portfolio new.
	
	leafPortfolio := Portfolio new.
	
	portfolioWithAssetInCommon := Portfolio new.

	assetInCommon := ReceptiveAccount new.
	
	portfolioWithAssetInCommon add: assetInCommon .
	
	rootPortfolio add: assetInCommon .
	
	rootPortfolio	 add: middlePortfolio.
	
	middlePortfolio add: leafPortfolio.
	
	self 
		should: [leafPortfolio add: portfolioWithAssetInCommon]
		
		raise: Error
		
		withExceptionDo: [:anError | 
			
			self assert: anError messageText = Portfolio ownerHasAssetsInCommonErrorDescription.
		].
	
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'GR 5/25/2021 22:53:14'!
test12CannotAddSelf

	|portfolio1|
	
	portfolio1 := Portfolio new.
	
	self 
		should: [portfolio1 add: portfolio1]
		
		raise: Error
		
		withExceptionDo: [:anError | 
			
			self assert: anError messageText = Portfolio assetIsSelfErrorDescription .
		].
	
	
	! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'GR 5/23/2021 11:38:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.
	
	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'GR 5/23/2021 11:39:13'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	
	Deposit register: 100 on: account.
	
	self assert: 100 equals: account balance.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'GR 5/23/2021 11:39:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	
	Deposit register: 100 on: account.
	
	Withdraw register: 50 on: account.
	
	self assert: 50 equals: account balance.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'GR 5/23/2021 11:41:08'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'GR 5/23/2021 11:41:43'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: account.
	
	withdraw := Withdraw register: 50 on: account.
	
	
	self assert: (account hasRegistered: deposit).
	
	self assert: (account hasRegistered: withdraw).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'GR 5/23/2021 11:42:12'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	
	deposit :=  Deposit for: 200.
	
	withdraw := Withdraw for: 50.
	
	self deny: (account hasRegistered: deposit).
	
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'GR 5/23/2021 11:45:18'!
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

!AccountTransaction methodsFor: 'value' stamp: 'GR 5/23/2021 11:36:39'!
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

!Deposit methodsFor: 'initialization' stamp: 'GR 5/23/2021 11:36:50'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'GR 5/23/2021 11:36:58'!
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

!Withdraw methodsFor: 'initialization' stamp: 'GR 5/23/2021 11:37:11'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'GR 5/23/2021 11:37:19'!
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
	instanceVariableNames: 'owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialAsset methodsFor: 'transactions' stamp: 'GR 5/24/2021 17:20:51'!
transactions

	^self subclassResponsibility ! !


!FinancialAsset methodsFor: 'testing' stamp: 'GR 5/25/2021 19:55:44'!
hasAssetsInCommonWith: anAsset


	^self subclassResponsibility ! !

!FinancialAsset methodsFor: 'testing' stamp: 'GR 5/24/2021 17:21:01'!
hasRegistered: aTransaction

	^self subclassResponsibility ! !

!FinancialAsset methodsFor: 'testing' stamp: 'GR 5/25/2021 21:22:34'!
ownerHasAssetsInCommonWith: anAsset 

	
	^owner ifEmpty: [self hasAssetsInCommonWith: anAsset] ifNotEmpty: [owner anySatisfy: [:anOwner | anOwner ownerHasAssetsInCommonWith: anAsset]]
	
	
	
	! !


!FinancialAsset methodsFor: 'owner' stamp: 'GR 5/25/2021 21:00:59'!
setOwnerTo: anOwner

	owner add: anOwner.! !


!FinancialAsset methodsFor: 'balance' stamp: 'GR 5/24/2021 17:20:45'!
balance

	^self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialAsset subclass: #Portfolio
	instanceVariableNames: 'assets'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'GR 5/25/2021 21:00:02'!
initialize

	assets := OrderedCollection new.
	
	owner := OrderedCollection new.! !


!Portfolio methodsFor: 'operations' stamp: 'GR 5/25/2021 22:33:16'!
add: anAssetToAdd

	(self == anAssetToAdd ) ifTrue: [^self error: Portfolio assetIsSelfErrorDescription].
	
	(self hasAssetsInCommonWith: anAssetToAdd) ifTrue: [^self error: Portfolio assetHasAssetsInCommonErrorDescription ].
	
	(owner anySatisfy: [:anOwner | anOwner ownerHasAssetsInCommonWith: anAssetToAdd]) ifTrue: [^self error: Portfolio ownerHasAssetsInCommonErrorDescription ].
	
	assets add: anAssetToAdd.
	
	anAssetToAdd setOwnerTo: self.! !


!Portfolio methodsFor: 'testing' stamp: 'GR 5/25/2021 20:03:10'!
hasAssetsInCommonWith: anAsset

	|myAssetsHaveAssetsInCommonWithAnAsset assetHasAssetsInCommonWithMyAssets isSelf|
	
	isSelf := anAsset == self.
	
	myAssetsHaveAssetsInCommonWithAnAsset := assets anySatisfy: [:myAsset| myAsset hasAssetsInCommonWith: anAsset].
	
	assetHasAssetsInCommonWithMyAssets := assets anySatisfy: [:myAsset | anAsset hasAssetsInCommonWith: myAsset ].
	
	^myAssetsHaveAssetsInCommonWithAnAsset or: assetHasAssetsInCommonWithMyAssets or: isSelf
	
	


! !

!Portfolio methodsFor: 'testing' stamp: 'GR 5/24/2021 17:24:27'!
hasRegistered: aTransaction

	^assets anySatisfy: [:anAsset | anAsset hasRegistered: aTransaction ].! !


!Portfolio methodsFor: 'transactions' stamp: 'GR 5/24/2021 17:23:58'!
transactions
	|transactions|
	transactions := OrderedCollection new.
	
	assets do: [:anAsset | transactions addAll: anAsset transactions ].
	
	^transactions.! !


!Portfolio methodsFor: 'balance' stamp: 'GR 5/24/2021 17:25:06'!
balance
	
	^assets sum: [:anAsset | anAsset balance] ifEmpty: [0].
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'GR 5/25/2021 20:19:35'!
assetHasAssetsInCommonErrorDescription

	^'Asset contains assets that already belong to portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'GR 5/25/2021 21:30:11'!
assetIsSelfErrorDescription
	
	^'Asset is self'.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'GR 5/25/2021 20:17:58'!
ownerHasAssetsInCommonErrorDescription

	^'Owner Has Assets In Common'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialAsset subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'GR 5/25/2021 21:06:09'!
initialize

	transactions := OrderedCollection new.
	
	owner := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'GR 5/23/2021 11:37:44'!
register: aTransaction

	transactions add: aTransaction 
	
	! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'GR 5/23/2021 11:37:50'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'GR 5/24/2021 16:19:07'!
balance

	|deposits withdrawals|
	
	deposits := self totalOf: Deposit.
	
	withdrawals := self totalOf: Withdraw.
	
	^deposits - withdrawals.! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'GR 5/24/2021 16:18:06'!
totalOf: aKindOfTransaction
	
	| transactionsOfKind |
	
	transactionsOfKind := transactions select: [:aTransaction | aTransaction isKindOf: aKindOfTransaction ].
	
	^transactionsOfKind sum: [ :aTransactionOfKind | aTransactionOfKind value ] ifEmpty: [ 0 ].
	! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'GR 5/25/2021 19:55:13'!
hasAssetsInCommonWith: anAsset

	^self == anAsset.! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'GR 5/23/2021 11:38:09'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction ! !
