!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'transaction1 transaction2 transaction3 transaction4 transaction5'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'MS 5/20/2021 20:21:00'!
test01EmptyPortfolioShouldHaveCeroBalance

	self assert: (Portfolio new balance = 0).! !

!PortfolioTest methodsFor: 'tests' stamp: 'GDH 5/24/2021 20:11:07'!
test02BalanceOfPortfolioContainingOnlyAccountsShouldBeSumOfAccountBalances

	| portfolio |

	portfolio := Portfolio new.
	
	portfolio add: self account1 .
	portfolio add: self account2 .
	
	self assert: (portfolio balance = 40).
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'GDH 5/24/2021 20:21:00'!
test03BalanceOfPortfolioContainingAccountsAndPortfoliosShouldBeSumOfAccountAndPortfoliosBalances

	| portfolio1 portfolio2 |

	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	portfolio2 add: self account3.
	
	portfolio1 add: self account1 .
	portfolio1 add: self account2 .
	portfolio1 add: portfolio2.
	
	self assert: (portfolio1 balance = 190).
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'MS 5/23/2021 17:37:33'!
test04EmptyPortfolioShouldHaveNoTransactions

	self assert: (Portfolio new transactions isEmpty).! !

!PortfolioTest methodsFor: 'tests' stamp: 'GDH 5/24/2021 20:22:09'!
test05TransactionsOfPortfolioContainingOnlyAccountsShouldBeUnionOfAccountTransactions

	| portfolio expectedPortfolioTransactions | 
	
	portfolio := Portfolio new.

	portfolio add: self account1 .
	portfolio add: self account2 .

	expectedPortfolioTransactions := OrderedCollection with: transaction1 with: transaction2 with: transaction3 with: transaction4.
	
	self assert: (portfolio transactions includesAllOf: expectedPortfolioTransactions).
	self assert: (expectedPortfolioTransactions includesAllOf: portfolio transactions).
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'GDH 5/24/2021 20:22:14'!
test06TransactionsOfPortfolioContainingAccountsAndPortfoliosShouldBeUnionOfAccountAndPortfoliosTransactions

	| portfolio1 portfolio2 expectedPortfolioTransactions | 
	
	portfolio1 := Portfolio new.
	
	portfolio1 add: self account1.
	portfolio1 add: self account2.
	
	portfolio2 := Portfolio new.
	portfolio2 add: self account3.
	
	portfolio1 add: portfolio2.

	expectedPortfolioTransactions := OrderedCollection with: transaction1 with: transaction2 with: transaction3 with: transaction4 with: transaction5 with: transaction2.
	
	self assert: (portfolio1 transactions includesAllOf: expectedPortfolioTransactions).
	self assert: (expectedPortfolioTransactions includesAllOf: portfolio1 transactions).
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'GDH 5/24/2021 20:21:40'!
test07EmptyPortfolioShouldHaveNotRegisteredTransactions

	self deny: (Portfolio new hasRegistered: transaction1 ).! !

!PortfolioTest methodsFor: 'tests' stamp: 'GDH 5/24/2021 20:21:57'!
test08HasRegisteredWithPortfolioContainingOnlyAccountsShouldCheckAccountsTransactions

	| portfolio1 account1 |
	
	portfolio1 := Portfolio new.
	account1 := (ReceptiveAccount new register: transaction1).
	
	portfolio1 add: account1.

	self assert: ( portfolio1 hasRegistered: transaction1 ).
	self deny: ( portfolio1 hasRegistered: transaction2 ).! !

!PortfolioTest methodsFor: 'tests' stamp: 'GDH 5/24/2021 20:22:03'!
test09HasRegisteredWithPortfolioContainingAccountsAndPortfoliosShouldCheckAccountsAndPortfoliosTransactions

	| portfolio1 portfolio2 account2 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	account2 := (ReceptiveAccount new register: transaction2).
	
	portfolio1 add: self account1 .
	
	portfolio2 add: account2.
	
	portfolio1 add: portfolio2.

	self assert: ( portfolio1 hasRegistered: transaction2 ).
	self deny: ( portfolio1 hasRegistered: transaction3 ).! !

!PortfolioTest methodsFor: 'tests' stamp: 'GDH 5/24/2021 20:19:02'!
test10CanNotAddRepeatedAccountToPortfolioContainingOnlyAccounts

	|  portfolio1 account1 |
	
	portfolio1 := Portfolio new.
	account1 := self account1 .
	
	portfolio1 add: account1.
		
	portfolio1 add: self account2 .
	
	self 
		should: [ portfolio1 add: account1 ] 
		raise: Error 
		withExceptionDo: [ :anError | self assert: anError messageText equals: Portfolio canNotAddPortfolioEntryExceptionMessage ].! !

!PortfolioTest methodsFor: 'tests' stamp: 'GDH 5/24/2021 20:20:06'!
test11CanNotAddPortfolioContainingOnlyAccountsToPortfolioContainingOnlyAccountsIfTheyShareAccounts

	| portfolio1 portfolio2 account1 |
	
	portfolio1 := Portfolio new.
	account1 := self account1 .
	
	portfolio1 add: account1.
	
	portfolio1 add: self account2 .
	
	portfolio2 := Portfolio new.
	portfolio2 add: account1.

	self 
		should: [ portfolio1 add: portfolio2 ] 
		raise: Error 
		withExceptionDo: [ :anError | self assert: anError messageText equals: Portfolio canNotAddPortfolioEntryExceptionMessage ].! !

!PortfolioTest methodsFor: 'tests' stamp: 'GDH 5/24/2021 20:20:48'!
test12CanNotAddPortfolioEntryToPortfolioHierarchyIfGeneratesRepeatedAccounts

	| portfolio1 portfolio2 account1 |

	portfolio1 := Portfolio new.
	account1 := self account1 .
	
	portfolio1 add: account1.
	
	portfolio2 := Portfolio new.
	portfolio2 add: self account2 .
	
	portfolio1 add: portfolio2.

	self 
		should: [ portfolio2 add: account1 ] 
		raise: Error 
		withExceptionDo: [ :anError | self assert: anError messageText equals: Portfolio canNotAddPortfolioEntryExceptionMessage ].! !


!PortfolioTest methodsFor: 'accounts' stamp: 'GDH 5/24/2021 20:21:57'!
account1
	
	^(ReceptiveAccount new register: transaction1) register: transaction2 . "50"! !

!PortfolioTest methodsFor: 'accounts' stamp: 'GDH 5/24/2021 20:22:09'!
account2
	
	^( ReceptiveAccount new register: transaction3 ) register: transaction4 . "-10"! !

!PortfolioTest methodsFor: 'accounts' stamp: 'GDH 5/24/2021 20:22:14'!
account3
	
	^(ReceptiveAccount new register: transaction5 ) register: transaction2 . "150"! !


!PortfolioTest methodsFor: 'setUp' stamp: 'GDH 5/24/2021 20:22:13'!
setUp
	
	transaction1 := Deposit for: 100.
	transaction2 := Withdraw for: 50.
	transaction3 := Deposit for: 10.
	transaction4 := Withdraw for: 20.
	transaction5 := Deposit for: 200.
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


!AccountTransaction methodsFor: 'actions' stamp: 'MS 5/23/2021 17:28:46'!
makeTransaction: currentBalance

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

!Deposit methodsFor: 'initialization' stamp: 'GDH 5/24/2021 20:22:42'!
initializeFor: aValue
	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'GDH 5/24/2021 20:22:58'!
value
	^ value! !



!Deposit methodsFor: 'actions' stamp: 'MS 5/23/2021 17:28:21'!
makeTransaction: currentBalance

	^currentBalance + value.! !

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


!Withdraw methodsFor: 'actions' stamp: 'MS 5/23/2021 17:28:29'!
makeTransaction: currentBalance

	^currentBalance - value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #PortfolioEntry category: 'Portfolio-Ejercicio'!
Object subclass: #PortfolioEntry
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioEntry methodsFor: 'transactions' stamp: 'MS 5/23/2021 20:00:50'!
transactions

	^self subclassResponsibility.! !


!PortfolioEntry methodsFor: 'balance' stamp: 'MS 5/23/2021 20:00:17'!
balance

	^self subclassResponsibility.! !


!PortfolioEntry methodsFor: 'testing' stamp: 'MS 5/23/2021 20:00:41'!
hasRegistered: aTransaction

	^self subclassResponsibility.! !


!PortfolioEntry methodsFor: 'assertion - private' stamp: 'GDH 5/24/2021 18:58:01'!
assertCanAdd: aPortfolioEntry ifCanNotAddEvaluate: onFailureClosure

	^self subclassResponsibility.! !

!PortfolioEntry methodsFor: 'assertion - private' stamp: 'GDH 5/24/2021 19:11:31'!
doesNotCreateRepetitionWith: aReceptiveAccount ifRepeats: onFailureClosure
	
	^self subclassResponsibility ! !


!PortfolioEntry methodsFor: 'adding - private' stamp: 'GDH 5/24/2021 19:34:27'!
addNewParent: aPortfolioEntry

	parents add: aPortfolioEntry.
! !


!PortfolioEntry methodsFor: 'initialization' stamp: 'GDH 5/24/2021 19:38:01'!
initialize
	
	parents := OrderedCollection new.! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
PortfolioEntry subclass: #Portfolio
	instanceVariableNames: 'entries'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'error - private' stamp: 'MS 5/24/2021 16:31:42'!
raiseCanNotAddPortfolioEntryException

	self error: self class canNotAddPortfolioEntryExceptionMessage.! !


!Portfolio methodsFor: 'adding' stamp: 'GDH 5/24/2021 19:29:48'!
add: aPortfolioEntry

	"Buscamos todas las raices de self y le pedimos el assertCanAdd"
	self findRoots do: [ :aPortfolioRoot | aPortfolioRoot assertCanAdd: aPortfolioEntry 
									 ifCanNotAddEvaluate: [ self raiseCanNotAddPortfolioEntryException ] ].

	entries add: aPortfolioEntry.
	
	aPortfolioEntry addNewParent: self.
! !


!Portfolio methodsFor: 'balance' stamp: 'GDH 5/24/2021 17:44:27'!
balance

	^entries sum: [ :anEntry | anEntry balance ] ifEmpty: [ 0 ].
! !


!Portfolio methodsFor: 'testing' stamp: 'MS 5/23/2021 20:18:58'!
hasRegistered: aTransaction

	^self transactions includes: aTransaction.
! !


!Portfolio methodsFor: 'initialization' stamp: 'GDH 5/24/2021 19:38:14'!
initialize
	
	super initialize .
	
	entries := OrderedCollection new.! !


!Portfolio methodsFor: 'transactions' stamp: 'MS 5/23/2021 20:19:04'!
transactions

	^(entries collect: [ :anEntry | anEntry transactions]) flatten.
	! !


!Portfolio methodsFor: 'assertion - private' stamp: 'GDH 5/24/2021 18:58:14'!
assertCanAdd: aPortfolioEntry ifCanNotAddEvaluate: onFailureClosure
	
	entries do: [ :anEntry | anEntry assertCanAdd: aPortfolioEntry ifCanNotAddEvaluate: onFailureClosure ].! !

!Portfolio methodsFor: 'assertion - private' stamp: 'GDH 5/24/2021 19:12:57'!
doesNotCreateRepetitionWith: aReceptiveAccount ifRepeats: onFailureClosure
	
	"Genera una repeticion si no lo puede agregar"
	self assertCanAdd: aReceptiveAccount ifCanNotAddEvaluate: onFailureClosure.! !


!Portfolio methodsFor: 'accessing - private' stamp: 'GDH 5/24/2021 19:40:33'!
findRoots

	parents ifEmpty: [ ^OrderedCollection with: self ].
	
	^( parents collect: [ :aPortfolioParent | aPortfolioParent findRoots ] ) flatten.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'MS 5/24/2021 16:32:26'!
canNotAddPortfolioEntryExceptionMessage

	^'Can not add repeated entry to portfolio'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
PortfolioEntry subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'GDH 5/24/2021 19:38:42'!
initialize
	super initialize .

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'MS 5/23/2021 20:19:27'!
register: aTransaction
	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'MS 5/23/2021 20:19:24'!
transactions 
	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'MS 5/23/2021 20:19:14'!
balance
	^transactions inject: 0 into: [ :accumulatedBalance :aTransaction | aTransaction makeTransaction: accumulatedBalance ].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'GDH 5/24/2021 17:45:01'!
hasRegistered: aTransaction
	^transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'assertion - private' stamp: 'GDH 5/24/2021 19:11:31'!
assertCanAdd: aPortfolioEntry ifCanNotAddEvaluate: onFailureClosure
	
	aPortfolioEntry doesNotCreateRepetitionWith: self ifRepeats: onFailureClosure.! !

!ReceptiveAccount methodsFor: 'assertion - private' stamp: 'GDH 5/24/2021 19:11:31'!
doesNotCreateRepetitionWith: aReceptiveAccount ifRepeats: onFailureClosure
	
	( aReceptiveAccount = self ) ifTrue: [ onFailureClosure value ].! !
