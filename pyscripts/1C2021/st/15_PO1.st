!classDefinition: #PortofolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortofolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortofolioTest methodsFor: 'test - has registered' stamp: 'dv 5/19/2021 21:11:38'!
test07AnEmptyPortfolioHasNotRegisteredATransaction
	| aPortfolio |
	aPortfolio := Portfolio new.
	self deny: (aPortfolio hasRegistered: (Deposit register: 100 on: ReceptiveAccount new)).! !

!PortofolioTest methodsFor: 'test - has registered' stamp: 'dv 5/24/2021 18:14:21'!
test08APortfolioWithAccountHasRegisteredAccountTransactions
	| aPortfolio anAccount |
	aPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	aPortfolio  add: anAccount.
	self assert: (aPortfolio hasRegistered: (Deposit register: 100 on: anAccount)).! !

!PortofolioTest methodsFor: 'test - has registered' stamp: 'dv 5/24/2021 18:14:22'!
test09APortfolioWithAccountHasNotRegisteredAnotherTransaction
	| aPortfolio anAccount aTransaction |
	aPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	aPortfolio  add: anAccount.
	aTransaction := Deposit register: 100 on: ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	self deny: (aPortfolio hasRegistered: aTransaction).! !

!PortofolioTest methodsFor: 'test - has registered' stamp: 'dv 5/24/2021 18:14:21'!
test10APortfolioWithMultipleAccountsHasRegisteredAccountTransactions
	| aPortfolio anAccount anotherAccount aTransaction |
	aPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	aPortfolio  add: anAccount.
	Deposit register: 100 on: anAccount.
	anotherAccount := ReceptiveAccount new.
	aTransaction := Withdraw register: 100 on: anotherAccount.
	Deposit register: 50 on: anotherAccount.
	aPortfolio  add: anotherAccount.

	self assert: (aPortfolio hasRegistered: aTransaction).
	self assert: (aPortfolio hasRegistered: (Deposit register: 50 on: anAccount)).! !

!PortofolioTest methodsFor: 'test - has registered' stamp: 'dv 5/24/2021 18:14:22'!
test11APortfolioWithPortfolioHasRegisteredPortfolioTransactions
	| aPortfolio anAccount anotherPortfolio |
	aPortfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	anotherPortfolio add: anAccount.
	
	aPortfolio  add:  anotherPortfolio .
	self assert: (aPortfolio hasRegistered: (Deposit register: 100 on: anAccount)).! !

!PortofolioTest methodsFor: 'test - has registered' stamp: 'dv 5/24/2021 18:14:21'!
test12APortfolioWithPortfolioHasNotRegisteredOtherTransactions
	| aPortfolio anAccount anotherPortfolio |
	aPortfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	anotherPortfolio add: anAccount.
	
	aPortfolio  add:  anotherPortfolio .
	self deny: (aPortfolio hasRegistered: (Deposit register: 100 on: ReceptiveAccount new)).! !

!PortofolioTest methodsFor: 'test - has registered' stamp: 'dv 5/25/2021 16:55:54'!
test13APortfolioWithMultiplePortfoliosHasRegisteresPortfoliosTransactions
	| aPortfolio anAccount anotherAccount anotherPortfolio aParentPortfolio |
	aParentPortfolio := Portfolio new.
	
	aPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	Deposit register: 50 on: anAccount.
	aPortfolio add: anAccount.

	anotherPortfolio := Portfolio new.
	anotherAccount := ReceptiveAccount new.	
	Deposit register: 100 on: anotherAccount.
	anotherPortfolio add: anotherAccount.

	aParentPortfolio  add: aPortfolio. 
	aParentPortfolio  add: anotherPortfolio.

	self assert: (aParentPortfolio hasRegistered: (Withdraw register: 100 on: anotherAccount )).
	self assert: (aParentPortfolio hasRegistered: (Withdraw register: 1 on: anAccount )).! !

!PortofolioTest methodsFor: 'test - has registered' stamp: 'dv 5/24/2021 18:14:21'!
test14APortfolioWithAccountAndPortfolioHasREgisteredAccountAndPortfolioTransactions
	| aPortfolio anAccount anotherAccount aParentPortfolio |
	aParentPortfolio := Portfolio new.
	

	aPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	Deposit register: 50 on: anAccount.
	aPortfolio add: anAccount.

	anotherAccount := ReceptiveAccount new.	
	Deposit register: 100 on: anotherAccount.	
	
	aParentPortfolio  add: aPortfolio. 
	aParentPortfolio  add: anotherAccount.

	self assert: (aParentPortfolio hasRegistered: (Withdraw register: 100 on: anotherAccount )).
	self assert: (aParentPortfolio hasRegistered: (Withdraw register: 100 on: anAccount )).! !


!PortofolioTest methodsFor: 'tests - balance' stamp: 'dv 5/25/2021 16:57:34'!
test01EmptyPortfolioHasBalanceZero
	"Existen varios tests que se pueden borrar pero los dejamos para que se aprecie mejor el proceso de como hicimos TDD de manera incremental.
	 Originalmente Portfolio y Account eran ideas distintas."
	|aPortfolio|
	aPortfolio := 	Portfolio new.
	self assert: aPortfolio balance = 0 ! !

!PortofolioTest methodsFor: 'tests - balance' stamp: 'dv 5/19/2021 19:36:01'!
test02APortfolioWIthAccountBalanceIsEqualToAccountBalance
	|aPortfolio |
	aPortfolio := 	self createPortfolioWithNumberOfAccounts: 1 andBalanceForAccount: 100.
	self assert: aPortfolio balance equals: 100 ! !

!PortofolioTest methodsFor: 'tests - balance' stamp: 'dv 5/24/2021 18:14:21'!
test03APortfolioWithPortfolioBalanceIsEqualToPortfolioBalance
	|aPortfolio anAccount anotherPortfolio |
	aPortfolio := 	Portfolio new.
	
	anAccount := ReceptiveAccount  new.
	Deposit register: 100 on: anAccount.
	
	anotherPortfolio := 	Portfolio new.
	anotherPortfolio add: anAccount.
	aPortfolio add: anotherPortfolio.
	
	self assert: 100 equals: aPortfolio balance! !

!PortofolioTest methodsFor: 'tests - balance' stamp: 'dv 5/19/2021 19:37:40'!
test04APortfolioWithMoreThanOneAccountBalanceIsEqualToSumOfAccountsBalance
	|aPortfolio |
	aPortfolio := 	self createPortfolioWithNumberOfAccounts: 2 andBalanceForAccount: 100.	
	self assert: 200 equals: aPortfolio balance
! !

!PortofolioTest methodsFor: 'tests - balance' stamp: 'dv 5/24/2021 18:14:21'!
test05APortfolioWithMoreThanOnePortfolioBalanceIsEqualToSumOfPortfolioBalance
	|aPortfolio anAccount anotherAccount anotherPortfolio parentPortfolio |
	aPortfolio := 	Portfolio new.
	anAccount := ReceptiveAccount  new.
	Deposit register: 150 on: anAccount.
	aPortfolio add: anAccount.
	
	anotherPortfolio := 	Portfolio new.
	anotherAccount := ReceptiveAccount  new.
	Deposit register: 150 on: anotherAccount.
	anotherPortfolio add: anotherAccount .  
	
	parentPortfolio := 	Portfolio new.

 	parentPortfolio  add:  anotherPortfolio.
	parentPortfolio  add:  aPortfolio.
	
	self assert: 300 equals: parentPortfolio balance
! !

!PortofolioTest methodsFor: 'tests - balance' stamp: 'dv 5/24/2021 18:14:21'!
test06APortfolioWithAccountAndPortfolioBalanceIsEqualToAccountAndPortfolioBalance
	|aPortfolio parentPortfolio |

	parentPortfolio := 	self createPortfolioWithNumberOfAccounts:  1 andBalanceForAccount:100. 
	aPortfolio := self createPortfolioWithNumberOfAccounts: 1  andBalanceForAccount: 150.

	parentPortfolio  add:  aPortfolio.
	self assert: 250 equals: parentPortfolio balance
! !


!PortofolioTest methodsFor: 'as yet unclassified' stamp: 'dv 5/24/2021 18:14:22'!
createPortfolioWithNumberOfAccounts: numberOfAccounts andBalanceForAccount: amount
	| aPortfolio anAccount |
	aPortfolio := 	Portfolio new.

	numberOfAccounts timesRepeat: [
		anAccount := ReceptiveAccount  new.
		Deposit register: amount on: anAccount.
		aPortfolio add: anAccount. 
	].
	^ aPortfolio ! !


!PortofolioTest methodsFor: 'tests - additions' stamp: 'dv 5/24/2021 18:14:21'!
test21AddARepeatedAccountInPortfolioRaisesDuplicatedAssetError
	| aPortfolio anAccount |

	aPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.

	aPortfolio  add: anAccount .
	
	self
		should: [aPortfolio add: anAccount . ]
		raise: Error
		withMessageText: Portfolio cannotAddDuplicatedAsset.! !

!PortofolioTest methodsFor: 'tests - additions' stamp: 'dv 5/24/2021 18:14:21'!
test22AddARepeatedPortfolioInPortfolioRaisesDuplicatedAssetError
	| aPortfolio anotherPortfolio |

	aPortfolio := Portfolio new.
	anotherPortfolio := Portfolio new.

	aPortfolio  add: anotherPortfolio.
	
	self
		should: [aPortfolio add: anotherPortfolio ]
		raise: Error
		withMessageText: Portfolio cannotAddDuplicatedAsset.! !

!PortofolioTest methodsFor: 'tests - additions' stamp: 'dv 5/24/2021 18:14:22'!
test23AddAPortfolioToItselfRaisesDuplicatedAssetError
	| aRootPortfolio |

	aRootPortfolio := Portfolio new.
	
	self
		should: [	aRootPortfolio  add: aRootPortfolio.]
		raise: Error
		withMessageText: Portfolio cannotAddDuplicatedAsset.! !

!PortofolioTest methodsFor: 'tests - additions' stamp: 'dv 5/24/2021 18:14:21'!
test24AddRootPortfolioToChildPortfolioRaisesDuplicatedAssetError
	| aRootPortfolio aMiddlePortfolio aLowerPortfolio |

	aRootPortfolio := Portfolio new.
	aMiddlePortfolio := Portfolio new.
	aLowerPortfolio := Portfolio new.
	
	aMiddlePortfolio add: aLowerPortfolio.
	aRootPortfolio add: aMiddlePortfolio.
		
	self
		should: [	aLowerPortfolio  add: aRootPortfolio.]
		raise: Error
		withMessageText: Portfolio cannotAddDuplicatedAsset.! !

!PortofolioTest methodsFor: 'tests - additions' stamp: 'dv 5/24/2021 18:14:21'!
test25AddRepeatedRootChildPortfolioToRootPortfolioRaisesDuplicatedAssetError
	| aRootPortfolio aMiddlePortfolio aLowerPortfolio |

	aRootPortfolio := Portfolio new.
	aMiddlePortfolio := Portfolio new.
	aLowerPortfolio := Portfolio new.
	
	aRootPortfolio add: aMiddlePortfolio.
	aMiddlePortfolio add: aLowerPortfolio.
	
	self
		should: [	aRootPortfolio  add: aLowerPortfolio.]
		raise: Error
		withMessageText: Portfolio cannotAddDuplicatedAsset.! !

!PortofolioTest methodsFor: 'tests - additions' stamp: 'dv 5/24/2021 18:14:22'!
test26AddRootChildPortfolioToAnotherRootChildPortfolioRaisesDuplicatedAssetError
	| aRootPortfolio aMiddlePortfolio anotherMiddlePortfolio |

	aRootPortfolio := Portfolio new.
	aMiddlePortfolio := Portfolio new.
	anotherMiddlePortfolio := Portfolio new.
	
	aRootPortfolio add: aMiddlePortfolio.
	aRootPortfolio add: anotherMiddlePortfolio.
	
	self
		should: [	aMiddlePortfolio  add: anotherMiddlePortfolio.]
		raise: Error
		withMessageText: Portfolio cannotAddDuplicatedAsset.! !

!PortofolioTest methodsFor: 'tests - additions' stamp: 'dv 5/25/2021 16:55:16'!
test27AddRootChildOfTreeToSharedPortfolioOfAnotherTreeRaisesDuplicatedAssetError
"	LP   RP
	  \   /  \
	  MP    A1
	   x
	  A1 
"
	| aLeftRootPortfolio aRightRootPortfolio aMiddlePortfolio anAccount|

	aLeftRootPortfolio := Portfolio new.
	aMiddlePortfolio := Portfolio new.
	aRightRootPortfolio := Portfolio new.
	anAccount  := ReceptiveAccount  new.
	
	aRightRootPortfolio add: aMiddlePortfolio.
	aLeftRootPortfolio add: aMiddlePortfolio.

	aRightRootPortfolio add: anAccount.
	
	self
		should: [	aMiddlePortfolio  add: anAccount.]
		raise: Error
		withMessageText: Portfolio cannotAddDuplicatedAsset.! !


!PortofolioTest methodsFor: 'tests - transactions' stamp: 'dv 5/19/2021 22:22:00'!
test15EmptyPortfolioTransactionsIsEmpty
	| aPortfolio |
	aPortfolio := Portfolio new.
	self assert: aPortfolio transactions isEmpty.! !

!PortofolioTest methodsFor: 'tests - transactions' stamp: 'dv 5/24/2021 18:14:21'!
test16APortfolioWithAccountTransactionsIncludesAccountTransactions
	| aPortfolio anAccount aTransaction |
	aPortfolio := Portfolio new.
	anAccount := ReceptiveAccount  new.
	aTransaction := Deposit register: 100 on: anAccount.
	aPortfolio  add: anAccount.
	self assert: aPortfolio transactions includes: aTransaction.! !

!PortofolioTest methodsFor: 'tests - transactions' stamp: 'dv 5/24/2021 18:14:21'!
test17APortfolioWithAccountsTransactionsIncludesAccountsTransactions
	| aPortfolio anAccount aTransaction anotherAccount anotherTransaction |
	aPortfolio := Portfolio new.
	
	anAccount := ReceptiveAccount  new.
	aTransaction := Deposit register: 100 on: anAccount.
	
	anotherAccount := ReceptiveAccount  new.
	anotherTransaction := Withdraw register: 100 on: anotherAccount.
	
	aPortfolio  add: anAccount.
	aPortfolio  add: anotherAccount.
	
	self assert: aPortfolio transactions includes: anotherTransaction.
	self assert: aPortfolio transactions includes: aTransaction.! !

!PortofolioTest methodsFor: 'tests - transactions' stamp: 'dv 5/24/2021 18:14:21'!
test18APortfolioWithPortfolioTransactionsHasPortfolioTransactions
	| aPortfolio anAccount aTransaction anotherPortfolio |
	aPortfolio := Portfolio new.
	
	anAccount := ReceptiveAccount  new.
	aTransaction := Deposit register: 100 on: anAccount.
	
	anotherPortfolio := Portfolio new.
	anotherPortfolio add: anAccount.
	
	aPortfolio  add: anotherPortfolio.
	.
	self assert: aPortfolio transactions includes: aTransaction.! !

!PortofolioTest methodsFor: 'tests - transactions' stamp: 'dv 5/24/2021 18:14:22'!
test19APortfolioWithPortfolioTransactionsHasPortfoliosTransactions
	| aPortfolio anAccount aTransaction anotherPortfolio aParentPortfolio anotherAccount anotherTransaction |
	aParentPortfolio := Portfolio new.
	
	aPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	aTransaction := Deposit register: 100 on: anAccount.
	aPortfolio  add: anAccount.
	
	anotherPortfolio := Portfolio new.
	anotherAccount := ReceptiveAccount new.
	anotherTransaction := Withdraw register: 100 on: anotherAccount.
	anotherPortfolio add: anotherAccount.
	
	aParentPortfolio  add: aPortfolio.
	aParentPortfolio  add: anotherPortfolio.
	
	self assert: aParentPortfolio transactions includes: aTransaction.
	self assert: aParentPortfolio transactions includes: anotherTransaction.! !

!PortofolioTest methodsFor: 'tests - transactions' stamp: 'dv 5/24/2021 18:14:21'!
test20APortfolioWithPortolioAndAccountTransactionsIncludesPortfolioAndAccountsTransactions
	| aPortfolio anAccount aTransaction aParentPortfolio anotherAccount anotherTransaction |
	aParentPortfolio := Portfolio new.
	
	aPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	aTransaction := Deposit register: 100 on: anAccount.
	aPortfolio  add: anAccount.
	
	anotherAccount := ReceptiveAccount new.
	anotherTransaction := Withdraw register: 100 on: anotherAccount.
	
	aParentPortfolio  add: aPortfolio.
	aParentPortfolio  add: anotherAccount .
	
	self assert: aParentPortfolio transactions includes: aTransaction.
	self assert: aParentPortfolio transactions includes: anotherTransaction.! !


!PortofolioTest methodsFor: 'tests - roots' stamp: 'dv 5/24/2021 19:43:50'!
test28AddPortfolioToRootPortfolioUpdatesRootsToRootPortfolio
	| aRootPortfolio aLowerPortfolio aMiddlePortfolio |
	aRootPortfolio := Portfolio  new.
	aMiddlePortfolio := Portfolio  new.
	aLowerPortfolio := Portfolio  new.
	
	aMiddlePortfolio add: aLowerPortfolio.
	aRootPortfolio add: aMiddlePortfolio.
	
	self assert: 1 equals: aLowerPortfolio  roots size.
	self assert: aLowerPortfolio roots includes: aRootPortfolio.! !

!PortofolioTest methodsFor: 'tests - roots' stamp: 'dv 5/24/2021 19:43:21'!
test29AddSecondRootToChildPortfolioUpdatesRootsToMany

	| aLeftRootPortfolio aRightRootPortfolio aMiddlePortfolio |

	aLeftRootPortfolio := Portfolio new.
	aMiddlePortfolio := Portfolio new.
	aRightRootPortfolio := Portfolio new.
	
	aRightRootPortfolio add: aMiddlePortfolio.
	aLeftRootPortfolio add: aMiddlePortfolio.
	
	self assert: 2 equals: aMiddlePortfolio roots size.
	self assert: aMiddlePortfolio roots includes: aLeftRootPortfolio.
	self assert: aMiddlePortfolio roots includes: aRightRootPortfolio.
	
	
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

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'private - operations' stamp: 'dv 5/19/2021 19:00:07'!
includeToBalance:aCurrentBalance
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'dv 5/17/2021 21:48:06'!
register:aValue on:account

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


!Deposit methodsFor: 'private - operations' stamp: 'dv 5/19/2021 19:00:57'!
includeToBalance: aCurrentBalance
	^ aCurrentBalance+ self value! !

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


!Withdraw methodsFor: 'private - operations' stamp: 'dv 5/19/2021 19:01:39'!
includeToBalance: aCurrentBalance
	^ aCurrentBalance - self value! !

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

!FinancialAsset methodsFor: 'balance' stamp: 'dv 5/23/2021 18:32:23'!
balance
	^ self transactions inject: 0 into: [:current :transaction| transaction includeToBalance: current]! !


!FinancialAsset methodsFor: 'transactions' stamp: 'dv 5/23/2021 15:33:47'!
hasRegistered: aTransaction 
	^ self transactions includes: aTransaction! !

!FinancialAsset methodsFor: 'transactions' stamp: 'dv 5/23/2021 15:24:11'!
transactions
	self subclassResponsibility ! !


!FinancialAsset methodsFor: 'comparing' stamp: 'dv 5/24/2021 18:25:22'!
includesAsset: anAsset
	self subclassResponsibility ! !


!FinancialAsset methodsFor: 'roots - private' stamp: 'dv 5/25/2021 16:50:03'!
updateRoots: roots
	
	self  subclassResponsibility ! !


!FinancialAsset methodsFor: 'transactions - private' stamp: 'dv 5/25/2021 16:47:01'!
includeTransactionsTo: accumulatedTransactions
	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialAsset subclass: #Portfolio
	instanceVariableNames: 'childAssets roots'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'assertions' stamp: 'dv 5/24/2021 18:11:45'!
assert: aRootPortfolio doesNotInclude:anAssetToStore
	(aRootPortfolio includesAsset: anAssetToStore) ifTrue: 		[self error: self class cannotAddDuplicatedAsset].! !

!Portfolio methodsFor: 'assertions' stamp: 'dv 5/24/2021 18:10:34'!
assertIsValidToStore: anAssetToStore
	roots do:[:root|self assert: root doesNotInclude:anAssetToStore].
	! !


!Portfolio methodsFor: 'initialize' stamp: 'dv 5/24/2021 18:36:54'!
initialize
	roots := Set with: self.
	childAssets := OrderedCollection new.! !


!Portfolio methodsFor: 'adding' stamp: 'dv 5/24/2021 18:17:30'!
add: anAssetToStore
	self assertIsValidToStore: anAssetToStore. 
	self safeAdd: anAssetToStore.
! !


!Portfolio methodsFor: 'comparing' stamp: 'dv 5/24/2021 18:47:30'!
any: assetsToSearch includes: anAsset

	^ assetsToSearch detect:[:asset| asset includesAsset: anAsset] 
		ifFound:[:unused|true] 
		ifNone:[false]! !

!Portfolio methodsFor: 'comparing' stamp: 'dv 5/24/2021 18:48:16'!
includesAsset: 		anAsset
	(self = anAsset ) ifTrue:[^true]. 
	^ self any: childAssets includes: anAsset.! !


!Portfolio methodsFor: 'roots - private' stamp: 'dv 5/24/2021 18:49:38'!
deleteRootsThatAreChildrenOf: newRoots

	^ roots do: 
		[:anOldRoot| (self any: newRoots includes: anOldRoot) 
			ifTrue: [roots remove: anOldRoot] ]! !

!Portfolio methodsFor: 'roots - private' stamp: 'dv 5/24/2021 18:37:22'!
updateChildrenRoots: aRootSet

	^ childAssets do: [:aChildAsset| aChildAsset updateRoots: aRootSet]! !

!Portfolio methodsFor: 'roots - private' stamp: 'dv 5/24/2021 18:49:38'!
updateRoots: 		newRoots

	self deleteRootsThatAreChildrenOf: newRoots.
	roots addAll: newRoots.
	self updateChildrenRoots: newRoots.! !


!Portfolio methodsFor: 'adding - private' stamp: 'dv 5/24/2021 18:36:54'!
safeAdd: anAssetToStore

	childAssets add: anAssetToStore.
	anAssetToStore updateRoots: roots.! !


!Portfolio methodsFor: 'testing - private' stamp: 'dv 5/23/2021 19:38:55'!
roots
	^roots! !


!Portfolio methodsFor: 'transactions - private' stamp: 'dv 5/25/2021 16:45:27'!
includeTransactionsTo: accumulatedTransactions
	childAssets do: [ :childAsset| childAsset includeTransactionsTo: accumulatedTransactions].
! !


!Portfolio methodsFor: 'transactions' stamp: 'dv 5/25/2021 16:45:27'!
transactions
	| accumulatedTransactions |
	accumulatedTransactions := 	OrderedCollection new.
	self includeTransactionsTo: accumulatedTransactions. 
	^ accumulatedTransactions! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error messages' stamp: 'dv 5/23/2021 15:40:06'!
cannotAddDuplicatedAsset
	^'Cannot Add Duplicated Asset'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialAsset subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'dv 5/24/2021 19:38:18'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'transactions - private' stamp: 'dv 5/25/2021 16:45:27'!
includeTransactionsTo: accumulatedTransactions

	accumulatedTransactions addAll: self transactions 
! !

!ReceptiveAccount methodsFor: 'transactions - private' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !


!ReceptiveAccount methodsFor: 'comparing' stamp: 'dv 5/23/2021 18:32:01'!
includesAsset: anAsset
	^self = anAsset ! !


!ReceptiveAccount methodsFor: 'roots - private' stamp: 'dv 5/24/2021 18:22:18'!
updateRoots: roots
"
	Por ahora los ReceptiveAccounts no necesitan saber su root
"! !
