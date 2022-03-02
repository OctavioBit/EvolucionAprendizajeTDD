!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests - has registered' stamp: 'EMI 11/6/2020 18:18:11'!
test04PortfolioHasNoRegisteredTransactions
	| portfolio |
	portfolio _ Portfolio new.

	self deny: (portfolio hasRegistered: (Deposit for: 100)).
	self deny: (portfolio hasRegistered: (Withdraw for: 100)).
	self assert: portfolio balance equals: 0.! !

!PortfolioTest methodsFor: 'tests - has registered' stamp: 'EMI 11/8/2020 17:56:42'!
test05PortfolioHasOneAccountWithOneRegisteredTransaction
	| portfolio account transaction|
	portfolio _ Portfolio new.
	account _ ReceptiveAccount new.
	transaction _ Deposit register: 100 on: account.
	
	self assertAdd: account To: portfolio.
	self assert: (portfolio hasRegistered: transaction).
	self assert: portfolio balance equals: 100.! !

!PortfolioTest methodsFor: 'tests - has registered' stamp: 'EMI 11/8/2020 17:57:10'!
test06PortfolioMoreThanOneAccountWithRegisteredTransactions
	| portfolio account1 account2 transaction1 transaction2|
	portfolio _ Portfolio new.
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	transaction1 _ Deposit register: 100 on: account1.
	transaction2 _ Deposit register: 50 on: account2.
	
	self assertAdd: account1 To: portfolio.
	self assertAdd: account2 To: portfolio.
	self assert: (portfolio hasRegistered: transaction1).
	self assert: (portfolio hasRegistered: transaction2).
	self assert: portfolio balance equals: 150.! !


!PortfolioTest methodsFor: 'tests - transactions' stamp: 'EMI 11/6/2020 18:27:41'!
test07EmptyPortfolioHasNoTransactions
	| portfolio |
	portfolio _ Portfolio new.

	self assert: portfolio transactions isEmpty.
	self assert: portfolio balance equals: 0.! !

!PortfolioTest methodsFor: 'tests - transactions' stamp: 'EMI 11/8/2020 17:57:31'!
test08PortfolioWithOneAccountHasOneTransaction
	| portfolio account deposit |
	portfolio _ Portfolio new.
	account _  ReceptiveAccount new.
	deposit _ Deposit register: 100 on: account.
	
	self assertAdd: account To: portfolio.
	self assert: portfolio transactions size equals: 1.
	self assert: (portfolio transactions includes: deposit).
	self assert: portfolio balance equals: 100.! !

!PortfolioTest methodsFor: 'tests - transactions' stamp: 'EMI 11/8/2020 17:57:54'!
test09PortfolioWithMoreThanOneAccountHasMoreThanOneTransactions
	| portfolio account1 account2 deposit withdraw |
	portfolio _ Portfolio new.
	account1 _  ReceptiveAccount new.
	account2 _  ReceptiveAccount new.
	deposit _ Deposit register: 100 on: account1.
	withdraw _ Withdraw register: 50 on: account2.
	
	self assertAdd: account1 To: portfolio.
	self assertAdd: account2 To: portfolio.
	self assert: portfolio transactions size equals: 2.
	self assert: (portfolio transactions includes: deposit).
	self assert: (portfolio transactions includes: withdraw ).
	self assert: portfolio balance equals: 50.! !


!PortfolioTest methodsFor: 'private' stamp: 'EMI 11/8/2020 18:32:41'!
assertAdd: anAsset To: anotherAsset
	self assert: (anotherAsset add: anAsset).
	! !

!PortfolioTest methodsFor: 'private' stamp: 'EMI 11/8/2020 18:32:08'!
denyAdd: anAsset To: anotherAsset
	self should: [anotherAsset add: anAsset ]
	raise: Error
	withExceptionDo:[:anError | self assert: anError messageText equals: Asset cannotAddAssetErrorMessage].! !


!PortfolioTest methodsFor: 'tests - tree structure' stamp: 'EMI 11/8/2020 17:59:05'!
test10PortfolioHasOneChildPortfolioWithAnAccountAndADeposit
	| portfolio portfolioChild account|
	portfolio _ Portfolio new.
	portfolioChild _ Portfolio new.
	account _  ReceptiveAccount new.
	Deposit register: 100 on: account. 
	
	self assertAdd: account To: portfolioChild. 
	self assertAdd: portfolioChild To: portfolio.
	self assert: portfolioChild balance equals: 100.
	self assert: portfolio balance equals: 100.

	 
! !

!PortfolioTest methodsFor: 'tests - tree structure' stamp: 'EMI 11/8/2020 18:00:30'!
test11PortfolioHasMoreThanOneChildPortfolioWithAnAccountAndADeposit
	| portfolio portfolioChildLeft  portfolioChildRight account account2|
	portfolio _ Portfolio new.
	portfolioChildLeft _ Portfolio new.
	portfolioChildRight _ Portfolio new.
	account _  ReceptiveAccount new.
	account2 _  ReceptiveAccount new.
	Deposit register: 100 on: account.
	Deposit register: 100 on: account2.
	
	self assertAdd: account To: portfolioChildLeft. 
	self assertAdd: account2 To: portfolioChildRight.
	self assertAdd: portfolioChildLeft To: portfolio.
	self assertAdd: portfolioChildRight To: portfolio.
	self assert: portfolioChildLeft balance equals: 100.
	self assert: portfolioChildRight balance equals: 100.
	self assert: portfolio balance equals: 200.
	 
! !

!PortfolioTest methodsFor: 'tests - tree structure' stamp: 'EMI 11/8/2020 18:01:33'!
test12PortfolioHasOneChildPortfolioWithAnAccountAndADepositRegistered
	| portfolio portfolioChild account transaction |
	portfolio _ Portfolio new.
	portfolioChild _ Portfolio new.
	account _  ReceptiveAccount new.
	transaction _ Deposit register: 100 on: account. 
	
	self assertAdd: account To: portfolioChild.
	self assertAdd: portfolioChild To: portfolio.
	self assert: portfolio balance equals: 100.
	self assert: (portfolio hasRegistered: transaction).
	self assert: (portfolio transactions size) equals: 1.
	self assert: (portfolio transactions includes: transaction).

	 
! !

!PortfolioTest methodsFor: 'tests - tree structure' stamp: 'EMI 11/8/2020 18:39:56'!
test13PortfolioHasOneGrandChildPortfolioWithAnAccountAndADepositRegistered
	| portfolio portfolioChild portfolioGrandChild account transaction |
	portfolio _ Portfolio new.
	portfolioChild _ Portfolio new.
	portfolioGrandChild _ Portfolio new.
	account _  ReceptiveAccount new.
	transaction _ Deposit register: 100 on: account. 
	
	self assertAdd: account To: portfolioGrandChild.
	self assertAdd: portfolioGrandChild To: portfolioChild.
	self assertAdd: portfolioChild To: portfolio.
	self assert: (portfolio balance ) equals: 100.
	self assert: (portfolio hasRegistered: transaction).
	self assert: (portfolio transactions size) equals: 1.
	self assert: (portfolio transactions includes: transaction).

	 
! !

!PortfolioTest methodsFor: 'tests - tree structure' stamp: 'EMI 11/8/2020 18:39:48'!
test14PortfolioHasMoreThanOneChildPortfolioWithAnAccountAndADepositRegistered
	| portfolio portfolioChildLeft  portfolioChildRight account1 account2 transaction1 transaction2|
	portfolio _ Portfolio new.
	portfolioChildLeft _ Portfolio new.
	portfolioChildRight _ Portfolio new.
	account1 _  ReceptiveAccount new.
	account2 _  ReceptiveAccount new.
	transaction1 _ Deposit register: 100 on: account1.
	transaction2 _ Deposit register: 100 on: account2.
	
	self assertAdd: account1 To: portfolioChildLeft.
	self assertAdd: account2 To: portfolioChildRight.
	self assertAdd: portfolioChildLeft To: portfolio.
	self assertAdd: portfolioChildRight To: portfolio.
	self assert: (portfolio hasRegistered: transaction1).
	self assert: (portfolio hasRegistered: transaction2).
	self assert: (portfolio transactions size) equals: 2.
	self assert: (portfolio transactions includes: transaction1).
	self assert: (portfolio transactions includes: transaction2).
	 
	 
! !

!PortfolioTest methodsFor: 'tests - tree structure' stamp: 'EMI 11/8/2020 18:39:38'!
test15PortfolioHasMoreThanOneGrandChildPortfolioWithAnAccountAndADepositRegistered
	| portfolio portfolioChild portfolioGrandChildLeft  portfolioGrandChildRight account1 account2 transaction1 transaction2|
	portfolio _ Portfolio new.
	portfolioChild _ Portfolio new.
	portfolioGrandChildLeft _ Portfolio new.
	portfolioGrandChildRight _ Portfolio new.
	account1 _  ReceptiveAccount new.
	account2 _  ReceptiveAccount new.
	transaction1 _ Deposit register: 100 on: account1.
	transaction2 _ Deposit register: 100 on: account2.
	.
	self assertAdd: account1 To: portfolioGrandChildLeft.
	self assertAdd: account2 To: portfolioGrandChildRight.
	self assertAdd: portfolioGrandChildLeft To: portfolioChild.
	self assertAdd: portfolioGrandChildRight To: portfolioChild.
	self assertAdd: portfolioChild To: portfolio.
	self assert: (portfolio balance ) equals: 200.
	self assert: (portfolio hasRegistered: transaction1).
	self assert: (portfolio hasRegistered: transaction2).
	self assert: (portfolio transactions size) equals: 2.
	self assert: (portfolio transactions includes: transaction1).
	self assert: (portfolio transactions includes: transaction2).
	 
! !

!PortfolioTest methodsFor: 'tests - tree structure' stamp: 'EMI 11/8/2020 18:39:23'!
test16PortfolioCannotAddSameEmptyAssetTwice
	| portfolio portfolio2 account|
	portfolio _ Portfolio new.
	account _  ReceptiveAccount new.
	
	self assertAdd: account To: portfolio.
	self denyAdd: account To: portfolio.
	
	portfolio2 _ Portfolio new.
	
	self assertAdd: portfolio2 To: portfolio.
	self denyAdd: portfolio2 To: portfolio.


	 
! !

!PortfolioTest methodsFor: 'tests - tree structure' stamp: 'EMI 11/8/2020 18:39:17'!
test17PortfolioCannotAddChildPortfolioWithSameAccount
	| portfolio portfolio2 account|
	portfolio _ Portfolio new.
	account _  ReceptiveAccount new.
	self assertAdd: account To: portfolio.
	
	portfolio2 _ Portfolio new.
	self assertAdd: account To: portfolio2.
	
	self denyAdd: portfolio2 To: portfolio.


	 
! !

!PortfolioTest methodsFor: 'tests - tree structure' stamp: 'EMI 11/8/2020 18:39:09'!
test18PortfolioCannotAddBothChildrenPortfoliosWithSameAccount
	| portfolio portfolioChildLeft portfolioChildRight account|
	portfolio _ Portfolio new.
	account _  ReceptiveAccount new.
	
	portfolioChildLeft _ Portfolio new.
	self assertAdd: account To: portfolioChildLeft.
	
	portfolioChildRight _ Portfolio new.
	self assertAdd: account To: portfolioChildRight.
	
	self assertAdd: portfolioChildLeft To: portfolio.
	self denyAdd: portfolioChildRight To: portfolio.



	 
! !

!PortfolioTest methodsFor: 'tests - tree structure' stamp: 'EMI 11/8/2020 18:38:55'!
test19PortfolioWith2ChildrenPortfoliosCannotAddAThirdWithSameAccount
	| portfolioRoot portfolioChildWithAccount portfolioChildWithoutAccount portfolioToAddWithSameAccount account|
	portfolioRoot _ Portfolio new.
	account _  ReceptiveAccount new.
	
	portfolioChildWithoutAccount _ Portfolio new.
	
	portfolioChildWithAccount _ Portfolio new.
	self assertAdd: account To: portfolioChildWithAccount.
	
	portfolioToAddWithSameAccount _ Portfolio new.
	self assertAdd: account To: portfolioToAddWithSameAccount.
	
	self assertAdd: portfolioChildWithoutAccount To: portfolioRoot.
	self assertAdd: portfolioChildWithAccount To: portfolioRoot.
	self denyAdd: portfolioToAddWithSameAccount To: portfolioRoot.



	 
! !

!PortfolioTest methodsFor: 'tests - tree structure' stamp: 'EMI 11/8/2020 18:38:37'!
test20TwoDisjointPortfoliosCanUseSameAccount
	| portfolio portfolio2 account|
	
	portfolio _ Portfolio new.
	portfolio2 _ Portfolio new.
	account _ ReceptiveAccount new.
	
	self assertAdd: account To: portfolio.
	self assertAdd: account To: portfolio2.
	self assert: account parentAssets includes: portfolio.
	self assert: account parentAssets includes: portfolio2.
	


	 
! !

!PortfolioTest methodsFor: 'tests - tree structure' stamp: 'EMI 11/8/2020 18:38:24'!
test21CannotUniteTwoDisjointPortfoliosWithSameAccount
	| portfolio portfolio2 portfolioRoot account|
	
	portfolio _ Portfolio new.
	portfolio2 _ Portfolio new.
	portfolioRoot _ Portfolio new.
	account _ ReceptiveAccount new.
	
	self assertAdd: account To: portfolio.
	self assertAdd: account To: portfolio2.
	self assertAdd: portfolio To: portfolioRoot.
	self denyAdd: portfolio2 To: portfolioRoot.


	 
! !

!PortfolioTest methodsFor: 'tests - tree structure' stamp: 'EMI 11/8/2020 18:38:09'!
test22TwoDisjointPortfoliosCanHaveSameChildPortfolio
	| portfolio portfolio2 portfolioChild|
	
	portfolio _ Portfolio new.
	portfolio2 _ Portfolio new.
	portfolioChild _ Portfolio new.
	
	self assertAdd: portfolioChild To: portfolio.
	self assertAdd: portfolioChild To: portfolio2.
	self assert: portfolioChild parentAssets includes: portfolio.
	self assert: portfolioChild parentAssets includes: portfolio2.
	


	 
! !

!PortfolioTest methodsFor: 'tests - tree structure' stamp: 'EMI 11/8/2020 18:38:00'!
test23CannotUniteTwoDisjointPortfoliosWithSameChildPortfolio
	| portfolio portfolio2 portfolioRoot portfolioChild |
	
	portfolio _ Portfolio new.
	portfolio2 _ Portfolio new.
	portfolioRoot _ Portfolio new.
	portfolioChild _ Portfolio new.
	
	self assertAdd: portfolioChild To: portfolio.
	self assertAdd: portfolioChild To: portfolio2.
	self assertAdd:  portfolio To: portfolioRoot.
	self denyAdd: portfolio2 To: portfolioRoot.
	


	 
! !

!PortfolioTest methodsFor: 'tests - tree structure' stamp: 'EMI 11/8/2020 18:37:53'!
test24PortfolioCannotAddBothGrandChildrenPortfoliosWithSameAccount
	| portfolio portfolioChildLeft portfolioChildRight portfolioGrandChildLeft portfolioGrandChildRight account|
	portfolio _ Portfolio new.
	account _  ReceptiveAccount new.
	
	portfolioChildLeft _ Portfolio new.
	portfolioChildRight _ Portfolio new.
	
	portfolioGrandChildLeft _ Portfolio new.
	self assertAdd: account To: portfolioGrandChildLeft.
	
	portfolioGrandChildRight _ Portfolio new.
	self assertAdd: account To: portfolioGrandChildRight.
	
	self assertAdd: portfolioChildLeft To: portfolio.
	self assertAdd: portfolioChildRight To: portfolio.
	self assertAdd: portfolioGrandChildLeft To: portfolioChildLeft.
	self denyAdd: portfolioGrandChildRight To: portfolioChildRight.


	 
! !

!PortfolioTest methodsFor: 'tests - tree structure' stamp: 'EMI 11/8/2020 18:37:45'!
test25PortfolioCannotAddGrandChildPortfolioWithSameAccountAsChild
	| portfolio portfolioChildLeft portfolioChildRight portfolioGrandChildRight account|
	portfolio _ Portfolio new.
	account _  ReceptiveAccount new.
	
	portfolioChildLeft _ Portfolio new.
	portfolioChildRight _ Portfolio new.
	
	self assertAdd: account To: portfolioChildLeft.
	
	portfolioGrandChildRight _ Portfolio new.
	self assertAdd: account To: portfolioGrandChildRight.
	
	self assertAdd: portfolioChildLeft To: portfolio.
	self assertAdd: portfolioChildRight To: portfolio.
	self denyAdd: portfolioGrandChildRight To: portfolioChildRight.

	 
! !

!PortfolioTest methodsFor: 'tests - tree structure' stamp: 'EMI 11/8/2020 18:37:16'!
test26PortfolioWith2ChildrenPortfoliosCannotAddAThirdWithAParentWithSameAccount
	| portfolioRoot portfolioChildWithAccount portfolioChildWithoutAccount 
	portfolioToAdd portfolioWithSameAccount account|
	
	portfolioRoot _ Portfolio new.
	account _  ReceptiveAccount new.
	
	portfolioChildWithoutAccount _ Portfolio new.
	
	portfolioChildWithAccount _ Portfolio new.
	self assertAdd: account To: portfolioChildWithAccount.
	
	portfolioToAdd _ Portfolio new.
	portfolioWithSameAccount _ Portfolio new.
	self assertAdd: account To: portfolioWithSameAccount.
	self assertAdd: portfolioToAdd To: portfolioWithSameAccount.
	
	self assertAdd: portfolioChildWithoutAccount To: portfolioRoot.
	self assertAdd: portfolioChildWithAccount To: portfolioRoot.
	self denyAdd: portfolioToAdd To: portfolioRoot.


	 
! !

!PortfolioTest methodsFor: 'tests - tree structure' stamp: 'EMI 11/8/2020 18:37:05'!
test27PortfolioWith2GrandChildrenPortfoliosCannotAddAThirdWithAGrandParentWithSameAccount
	| portfolioRoot portfolioChildLeft portfolioChildRight 
	portfolioGrandChildRight portfolioGrandChildLeft 
	portfolioRootAnotherTree portfolioChildAnotherTree portfolioGrandChildAnotherTree account|
	
	portfolioRoot _ Portfolio new.
	portfolioRootAnotherTree  _ Portfolio new.
	account _  ReceptiveAccount new.
	
	self assertAdd: account To: portfolioRoot.
	self assertAdd: account To: portfolioRootAnotherTree.
	
	portfolioChildLeft  _ Portfolio new.
	portfolioChildRight _ Portfolio new.
	self assertAdd: portfolioChildLeft To: portfolioRoot.
	self assertAdd: portfolioChildRight To: portfolioRoot.
	
	portfolioGrandChildLeft _ Portfolio new.
	portfolioGrandChildRight _ Portfolio new.
	self assertAdd: portfolioGrandChildLeft To: portfolioChildLeft .
	self assertAdd: portfolioGrandChildRight To: portfolioChildRight.
	
	portfolioChildAnotherTree _ Portfolio new.
	self assertAdd: portfolioChildAnotherTree To: portfolioRootAnotherTree.
	
	portfolioGrandChildAnotherTree _ Portfolio new.
	self assertAdd: portfolioGrandChildAnotherTree To: portfolioChildAnotherTree.
	
	self denyAdd: portfolioGrandChildAnotherTree To: portfolioGrandChildRight 


	 
! !


!PortfolioTest methodsFor: 'tests - initialization' stamp: 'EMI 11/7/2020 18:39:42'!
test01NewPortfolioHasNoAccountsAndNoPortfolios
	| portfolio |
	portfolio _ Portfolio new.
	
	self assert: portfolio balance equals: 0.
	self assert: portfolio parentAssets isEmpty.! !

!PortfolioTest methodsFor: 'tests - initialization' stamp: 'EMI 11/8/2020 17:55:24'!
test02PortfolioAddEmptyAccount
	| portfolio account|
	portfolio _ Portfolio new.
	account _ ReceptiveAccount new.
	
	self assertAdd: account To: portfolio.
	self assert: portfolio balance equals: 0.
	self assert: portfolio parentAssets isEmpty.
	self assert: account parentAssets size equals: 1.
	self assert: account parentAssets includes: portfolio.! !

!PortfolioTest methodsFor: 'tests - initialization' stamp: 'EMI 11/8/2020 17:55:49'!
test03PortfolioAddEmptyPortfolio
	| portfolio portfolioChild |
	portfolio _ Portfolio new.
	portfolioChild _ Portfolio new.
	
	self assertAdd: portfolioChild To: portfolio.
	self assert: portfolio balance equals: 0.
	self assert: portfolio parentAssets isEmpty.
	self assert: portfolioChild parentAssets size equals: 1.
	self assert: portfolioChild parentAssets includes: portfolio.! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'EMI 11/2/2020 21:03:47'!
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'EMI 11/2/2020 19:55:15'!
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

!AccountTransaction methodsFor: 'value' stamp: 'EMI 11/2/2020 20:31:23'!
calculateBalance: aBalance

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


!Deposit methodsFor: 'value' stamp: 'EMI 11/2/2020 20:32:03'!
calculateBalance: aBalance
	^aBalance + value.! !

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


!Withdraw methodsFor: 'value' stamp: 'EMI 11/2/2020 20:32:14'!
calculateBalance: aBalance
	^aBalance - value.! !

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


!classDefinition: #Asset category: 'Portfolio-Ejercicio'!
Object subclass: #Asset
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Asset methodsFor: 'testing' stamp: 'EMI 11/6/2020 19:51:09'!
balance
	^self subclassResponsibility.! !

!Asset methodsFor: 'testing' stamp: 'EMI 11/6/2020 20:27:10'!
hasAsset: anAsset
	^self subclassResponsibility.! !

!Asset methodsFor: 'testing' stamp: 'EMI 11/6/2020 19:51:27'!
hasRegistered: aTransaction
	^self subclassResponsibility.! !


!Asset methodsFor: 'accesing' stamp: 'EMI 11/6/2020 19:51:39'!
transactions
	^self subclassResponsibility.! !


!Asset methodsFor: 'tree operations' stamp: 'EMI 11/7/2020 17:30:57'!
addAsSubassetOf: aParentAsset
	parents add: aParentAsset.! !

!Asset methodsFor: 'tree operations' stamp: 'EMI 11/7/2020 18:38:38'!
assetTreeRoots
	| rootParents|
	rootParents _ OrderedCollection new.
	
	parents isEmpty ifTrue: [rootParents add: self].
	parents do: [:aParent | 
		rootParents addAll: aParent assetTreeRoots.
	].

	^rootParents.! !

!Asset methodsFor: 'tree operations' stamp: 'EMI 11/7/2020 18:58:04'!
hasAssetIntersectionWith: anAsset
	^(self hasAsset: anAsset) or: [anAsset hasAsset: self].! !

!Asset methodsFor: 'tree operations' stamp: 'EMI 11/7/2020 18:38:57'!
parentAssets
	^parents! !


!Asset methodsFor: 'adding' stamp: 'EMI 11/8/2020 18:41:54'!
add: anAsset
	^self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Asset class' category: 'Portfolio-Ejercicio'!
Asset class
	instanceVariableNames: ''!

!Asset class methodsFor: 'errorMessages' stamp: 'EMI 11/8/2020 18:25:41'!
cannotAddAssetErrorMessage
	^'Cannot add asset already present in assets tree'.! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Asset subclass: #Portfolio
	instanceVariableNames: 'assets'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'accessing' stamp: 'EMI 11/7/2020 17:57:47'!
transactions
	| res |
	res _ OrderedCollection new.
	assets do: [:anAsset | res addAll: anAsset transactions  ].
	^res.! !


!Portfolio methodsFor: 'adding' stamp: 'EMI 11/8/2020 18:27:49'!
add: anAsset
	| rootParents rootParentsOther |
	rootParents _ (self assetTreeRoots).
	rootParentsOther _ (anAsset assetTreeRoots).
	
	rootParents do: [:aParent |
		rootParentsOther do: [:aParentOther |
			(aParent hasAsset: aParentOther) ifTrue:[^Error signal: self class cannotAddAssetErrorMessage.].
			(aParentOther hasAsset: aParent) ifTrue:[^Error signal: self class cannotAddAssetErrorMessage.]
		].
	].
	
	assets add: anAsset.
	anAsset addAsSubassetOf: self.
	^true.! !


!Portfolio methodsFor: 'initialization' stamp: 'EMI 11/7/2020 17:31:59'!
initialize
	assets _ OrderedCollection new.
	parents _ OrderedCollection new.! !


!Portfolio methodsFor: 'testing' stamp: 'EMI 11/6/2020 19:54:47'!
balance
	^(assets sum: [:anAsset | anAsset balance] ifEmpty:[0]).! !

!Portfolio methodsFor: 'testing' stamp: 'EMI 11/7/2020 18:48:32'!
hasAsset: anAsset
	| estaEnMisHijosDirectos |
	estaEnMisHijosDirectos _ assets includes: anAsset.
	^estaEnMisHijosDirectos or: [(assets select: [:aChildAsset | aChildAsset hasAssetIntersectionWith: anAsset]) isEmpty not.].
	! !

!Portfolio methodsFor: 'testing' stamp: 'EMI 11/6/2020 19:55:28'!
hasRegistered: aTransaction
	assets detect: [:anAsset | anAsset hasRegistered: aTransaction ] ifNone: [^false].
	^true.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Asset subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'adding' stamp: 'EMI 11/8/2020 18:41:22'!
add: anAsset
	^self.! !


!ReceptiveAccount methodsFor: 'initialization' stamp: 'EMI 11/7/2020 17:31:48'!
initialize

	transactions := OrderedCollection new.
	parents _ OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'EMI 11/2/2020 20:33:55'!
balance
	| balance |
	balance _ 0.
	transactions do: [ :aTransaction | balance _ aTransaction calculateBalance: balance	].
	^balance! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'EMI 11/6/2020 20:27:30'!
hasAsset: anAsset
	^false.! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !
