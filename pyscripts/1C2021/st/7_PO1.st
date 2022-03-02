!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'portfolio4 portfolio1 portfolio2 portfolio3 account1 account2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'private' stamp: 'AM 5/24/2021 18:36:30'!
blockShouldTriggerFinancialObjectAlreadyRegistered: aBlock
	
	self
		should: aBlock
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio financialObjectAlreadyRegistered ]

	
! !

!PortfolioTest methodsFor: 'private' stamp: 'bocaccio 5/20/2021 20:33:31'!
createAccountWithDepositedAmount: anAmount 
	| anAccount|
	anAccount  := ReceptiveAccount  new.
	Deposit register: anAmount on: anAccount.
	^ anAccount 
	! !


!PortfolioTest methodsFor: 'test-balance' stamp: 'sb 5/24/2021 20:46:33'!
test01NewPortfolioHasBalance0
	self assert: portfolio1 balance equals: 0! !

!PortfolioTest methodsFor: 'test-balance' stamp: 'sb 5/24/2021 20:46:41'!
test02PortFolioWithOneAccountHasAccountBalance
	portfolio1 addFinancialObject: ( self createAccountWithDepositedAmount: 100).
	self assert: portfolio1 balance equals: 100! !

!PortfolioTest methodsFor: 'test-balance' stamp: 'sb 5/24/2021 20:46:50'!
test03PortfolioBalanceWithAPorfolioAndAccountBalance
	
	portfolio1 addFinancialObject: (self createAccountWithDepositedAmount: 100).
	portfolio2 addFinancialObject: portfolio1.
	portfolio2 addFinancialObject: (self createAccountWithDepositedAmount: 250).
	self assert: portfolio2 balance equals: 350! !


!PortfolioTest methodsFor: 'test-hasRegistered' stamp: 'sb 5/24/2021 20:47:13'!
test04PortfolioHasRegisteredAccountDeposit
	|deposit|
	deposit := Deposit register: 100 on: account1.
	portfolio1 addFinancialObject: account1 .
	self assert: (portfolio1 hasRegistered: deposit) equals: true.! !

!PortfolioTest methodsFor: 'test-hasRegistered' stamp: 'sb 5/24/2021 20:39:09'!
test05PortfolioShouldntHaveDepositAdded
	|deposit |
	account1 := ReceptiveAccount  new.
	deposit := Deposit register: 100 on: account1.
	self deny: (portfolio1 hasRegistered: deposit)! !


!PortfolioTest methodsFor: 'test-addRepeatedAccounts' stamp: 'sb 5/24/2021 20:47:38'!
test06PortfolioCantRegisterSameAccountTwice
	portfolio1  addFinancialObject: account1.
	self blockShouldTriggerFinancialObjectAlreadyRegistered: [ portfolio1 addFinancialObject: account1 ].

	
! !

!PortfolioTest methodsFor: 'test-addRepeatedAccounts' stamp: 'sb 5/24/2021 20:47:49'!
test07CannotAddAccountInPortfolioAlreadyInPortfolioFather
	
	portfolio1 addFinancialObject: account1.
	portfolio1 addFinancialObject: portfolio2.
	self blockShouldTriggerFinancialObjectAlreadyRegistered: [ portfolio2 addFinancialObject: account1 ].
	
! !

!PortfolioTest methodsFor: 'test-addRepeatedAccounts' stamp: 'sb 5/24/2021 20:47:53'!
test08CannotAddAccountInPorfolioAlreadyInPortfolioGrandfather
	
	portfolio1 addFinancialObject: account1.
	portfolio1 addFinancialObject: portfolio2.
	portfolio2 addFinancialObject: portfolio3.
	self blockShouldTriggerFinancialObjectAlreadyRegistered: [ portfolio3 addFinancialObject: account1 ].
	
! !

!PortfolioTest methodsFor: 'test-addRepeatedAccounts' stamp: 'sb 5/24/2021 20:48:05'!
test09CanAddAccountInPortfolioTreeWithouRepeatedAccount
	
	portfolio1 addFinancialObject: account1.
	portfolio1 addFinancialObject: portfolio2.
	portfolio2 addFinancialObject: portfolio3.
	portfolio3 addFinancialObject: account2.
	self assert: (portfolio3 includesFinancialObject: account2).
	
	
	


	
! !

!PortfolioTest methodsFor: 'test-addRepeatedAccounts' stamp: 'sb 5/24/2021 20:41:48'!
test10CannotAddAccountAlreadyInCousinLeaf

	portfolio1 addFinancialObject: portfolio2.
	portfolio1 addFinancialObject: portfolio3.
	portfolio2 addFinancialObject: account1.
	self blockShouldTriggerFinancialObjectAlreadyRegistered: [ portfolio3 addFinancialObject: account1 ].! !


!PortfolioTest methodsFor: 'setUp' stamp: 'sb 5/24/2021 20:35:57'!
setUp
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	account1 := ReceptiveAccount  new.
	account2 := ReceptiveAccount  new.
		

	

	
	
	


	
! !


!PortfolioTest methodsFor: 'test-transactions' stamp: 'sb 5/24/2021 21:03:16'!
test15EmptyPortfolioShouldHaveEmptyTransactions

	self assert: (portfolio1 transactions ) equals: Set new.! !

!PortfolioTest methodsFor: 'test-transactions' stamp: 'sb 5/24/2021 21:03:23'!
test16PortfolioWithAccountHasAccountsTransactions
	| deposit |

	deposit := Deposit register: 100 on: account1.
	portfolio1 addFinancialObject: account1 .
	self assert: (portfolio1 transactions) equals:  (Set with: deposit ).! !

!PortfolioTest methodsFor: 'test-transactions' stamp: 'sb 5/24/2021 21:03:32'!
test17PortfolioWithPortfolioHasHisSonTransactions
	| deposit |

	deposit := Deposit register: 100 on: account1.
	portfolio2 addFinancialObject: account1.
	portfolio1 addFinancialObject: portfolio2.
	self assert: (portfolio1 transactions) equals: (portfolio2 transactions).! !

!PortfolioTest methodsFor: 'test-transactions' stamp: 'sb 5/24/2021 21:01:57'!
test18PortfolioWithPortfolioHasHisGrandsonTransactions
	| deposit |

	deposit := Deposit register: 100 on: account1.
	portfolio2 addFinancialObject: account1.
	portfolio3 addFinancialObject: portfolio2.
	portfolio1 addFinancialObject: portfolio3 .
	self assert: (portfolio1 transactions) equals: (portfolio2 transactions).! !


!PortfolioTest methodsFor: 'test-addRepeatedPortfolios' stamp: 'sb 5/24/2021 20:42:36'!
test11CannotAddEmptyPortfolioTwiceInSamePorfolio

	portfolio1 addFinancialObject: portfolio2.
	self blockShouldTriggerFinancialObjectAlreadyRegistered: [ portfolio1 addFinancialObject: portfolio2 ].	
! !

!PortfolioTest methodsFor: 'test-addRepeatedPortfolios' stamp: 'sb 5/24/2021 20:48:14'!
test12CannotAddEmptyPortfolioInPortfolioAlreadyInPortfolioFather
	
	portfolio1 addFinancialObject: portfolio3 .
	portfolio1 addFinancialObject: portfolio2.
	self blockShouldTriggerFinancialObjectAlreadyRegistered: [ portfolio2 addFinancialObject: portfolio3 ].
	
! !

!PortfolioTest methodsFor: 'test-addRepeatedPortfolios' stamp: 'sb 5/24/2021 20:43:51'!
test13CannotAddPortfolioWhenSharesAccountWithFutureBrother

	portfolio2 addFinancialObject: account1.
	portfolio3 addFinancialObject: account1.
	portfolio1 addFinancialObject: portfolio2.
	self blockShouldTriggerFinancialObjectAlreadyRegistered: [ portfolio1 addFinancialObject: portfolio3 ].! !

!PortfolioTest methodsFor: 'test-addRepeatedPortfolios' stamp: 'sb 5/24/2021 21:02:50'!
test14CannotAddPortfolioWhenSharesAccountWithGreatUncle
	
	portfolio1 addFinancialObject: account1.
	portfolio3 addFinancialObject: account1.
	portfolio2 addFinancialObject: portfolio3.
	self blockShouldTriggerFinancialObjectAlreadyRegistered: [ portfolio1 addFinancialObject: portfolio2 ].! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AM 5/24/2021 18:53:21'!
createAccountWithDepositedAmount: anAmount 
	| anAccount|
	anAccount  := ReceptiveAccount  new.
	Deposit register: anAmount on: anAccount.
	^ anAccount ! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AM 5/24/2021 18:54:59'!
test02DepositIncreasesBalanceOnTransactionValue 

		
	self assert: 100 equals: (self createAccountWithDepositedAmount: 100) balance.
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

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'Sebas Bocaccio 5/24/2021 14:03:22'!
valueFor: aReceptiveAccount 
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'AM 5/22/2021 17:16:42'!
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

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

!Deposit methodsFor: 'value' stamp: 'Sebas Bocaccio 5/24/2021 14:03:22'!
valueFor: aReceptiveAccount 
	^ aReceptiveAccount valueOfADepositWithAmount: (self value). ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'bocaccio 5/17/2021 20:37:10'!
value

	^ value ! !

!Withdraw methodsFor: 'value' stamp: 'Sebas Bocaccio 5/24/2021 14:03:22'!
valueFor: aReceptiveAccount 
	^ aReceptiveAccount valueOfAWithdrawWithAmount: (self value).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialObject category: 'Portfolio-Ejercicio'!
Object subclass: #FinancialObject
	instanceVariableNames: 'portfoliosImIn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialObject methodsFor: 'balance' stamp: 'Sebas Bocaccio 5/24/2021 14:36:35'!
balance 
	^ self subclassResponsibility .! !


!FinancialObject methodsFor: 'transactions' stamp: 'Sebas Bocaccio 5/24/2021 12:05:24'!
transactions
	self subclassResponsibility.! !


!FinancialObject methodsFor: 'be added' stamp: 'Sebas Bocaccio 5/24/2021 15:05:07'!
addedToPortfolio: aPortfolio 

	portfoliosImIn add: aPortfolio.! !


!FinancialObject methodsFor: 'private' stamp: 'sb 5/25/2021 15:12:31'!
financialObjectsAddedTo
" Return all financial objects under me in the tree"
	self subclassResponsibility ! !

!FinancialObject methodsFor: 'private' stamp: 'sb 5/25/2021 15:08:16'!
financialObjectsInPortfoliosWhichImInAndArentInAnyOtherPortfolio
"Return all elements of the trees im in"

	|financialObjects supraPorfolios|
	financialObjects:= Set new.
	supraPorfolios:= self portfoliosWhichImInAndArentInAnyOtherPortfolio.
	supraPorfolios do: [:aSupraPortfolio| financialObjects add: aSupraPortfolio. 
		financialObjects addAll: aSupraPortfolio financialObjectsAddedTo].
	^financialObjects! !

!FinancialObject methodsFor: 'private' stamp: 'sb 5/25/2021 15:07:09'!
portfoliosWhichImInAndArentInAnyOtherPortfolio
"Returns the roots of the trees"

	|supraPortfolios|
	supraPortfolios:= Set new.
	portfoliosImIn ifEmpty: [supraPortfolios add:self].
	portfoliosImIn do: [:portfolio| supraPortfolios addAll: portfolio portfoliosWhichImInAndArentInAnyOtherPortfolio].
	^supraPortfolios.! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialObject subclass: #Portfolio
	instanceVariableNames: 'containedFinancialObjects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'private' stamp: 'sb 5/25/2021 15:12:25'!
financialObjectsAddedTo


	|childSet|
	childSet:= Set new.
	childSet addAll: containedFinancialObjects.
	
	containedFinancialObjects do: [:financialElement|childSet addAll: (financialElement financialObjectsAddedTo)].
	
	^childSet.
	
	! !

!Portfolio methodsFor: 'private' stamp: 'sb 5/25/2021 15:06:22'!
hasElementsInCommonWith: setWithFinancialObjects
	|hasElementsInCommon|
	hasElementsInCommon:=false.
	self financialObjectsInPortfoliosWhichImInAndArentInAnyOtherPortfolio do: [:anElement| hasElementsInCommon:=hasElementsInCommon or: (setWithFinancialObjects includes: anElement)].
	^hasElementsInCommon! !


!Portfolio methodsFor: 'initialization' stamp: 'sb 5/25/2021 15:02:00'!
initialize
	containedFinancialObjects:= Set new.
	portfoliosImIn := Set  new.
! !


!Portfolio methodsFor: 'transactions' stamp: 'AM 5/24/2021 19:23:01'!
transactions
	|transactions|
	transactions  := Set new.
	containedFinancialObjects do: [:aFinancialObject| transactions  addAll: aFinancialObject transactions].
	^ transactions ! !


!Portfolio methodsFor: 'balance' stamp: 'AM 5/24/2021 19:23:01'!
balance
	^ containedFinancialObjects sum:[:element| element balance] ifEmpty:[0]! !


!Portfolio methodsFor: 'testing' stamp: 'AM 5/24/2021 19:23:01'!
hasRegistered: aTransaction
	| isRegistered|
	isRegistered := false.
	containedFinancialObjects do: [:element| isRegistered := (element hasRegistered: aTransaction) or: isRegistered.  ] .
	^ isRegistered .
	! !

!Portfolio methodsFor: 'testing' stamp: 'AM 5/24/2021 18:12:25'!
includesFinancialObject:aFinancialObject
	^ self financialObjectsAddedTo includes: aFinancialObject.
	! !


!Portfolio methodsFor: 'be added' stamp: 'Sebas Bocaccio 5/24/2021 15:04:37'!
addedToPortfolio: aPortfolio 

	portfoliosImIn add: aPortfolio.! !


!Portfolio methodsFor: 'adding' stamp: 'sb 5/25/2021 15:04:31'!
addFinancialObject: aFinancialObject
	
	|treeToAdd|
	treeToAdd:=((aFinancialObject financialObjectsAddedTo)).
	treeToAdd add: aFinancialObject.
	
	(self hasElementsInCommonWith: (treeToAdd))ifTrue: [self error: Portfolio financialObjectAlreadyRegistered].
	containedFinancialObjects add:  aFinancialObject.
	aFinancialObject addedToPortfolio: self. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'AM 5/24/2021 18:36:30'!
financialObjectAlreadyRegistered
	^ 'You already registered the account'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialObject subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'Sebas Bocaccio 5/24/2021 15:21:23'!
initialize

	transactions := Set new.
	portfoliosImIn:= Set new.
	elements:= Set with: self
! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'AM 5/22/2021 17:16:04'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'Sebas Bocaccio 5/24/2021 14:04:06'!
balance

	^transactions sum: [ :aTransaction | aTransaction valueFor: self ] ifEmpty: [ 0 ]! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'bocaccio 5/22/2021 15:39:11'!
valueOfADepositWithAmount: aDepositValue
 ^ aDepositValue .
	! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'bocaccio 5/22/2021 15:42:47'!
valueOfAWithdrawWithAmount: aWithdrawValue 
	^ aWithdrawValue  negated.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'Sebas Bocaccio 5/24/2021 11:36:13'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction
! !


!ReceptiveAccount methodsFor: 'private' stamp: 'AM 5/24/2021 18:12:25'!
financialObjectsAddedTo
	^Set new.! !


!ReceptiveAccount methodsFor: 'be added' stamp: 'Sebas Bocaccio 5/24/2021 15:04:37'!
addedToPortfolio: aPortfolio 

	portfoliosImIn add: aPortfolio.! !
