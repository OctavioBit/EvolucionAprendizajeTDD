!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'test data' stamp: 'JPF 5/22/2021 10:00:57'!
a50Deposit

	^ Deposit for: 50! !

!PortfolioTest methodsFor: 'test data' stamp: 'JPF 5/22/2021 10:34:00'!
a50Withdraw

	^ Withdraw for: 50! !

!PortfolioTest methodsFor: 'test data' stamp: 'JPF 5/22/2021 10:02:05'!
accountWith: transactions

	| account |
	
	account _ ReceptiveAccount new.
	transactions do: [ :aTransaction | account register: aTransaction ].
	
	^ account! !

!PortfolioTest methodsFor: 'test data' stamp: 'JPF 5/22/2021 09:12:28'!
accountWithBalance50

	| account |
	
	account _ ReceptiveAccount new.
	account register: (Deposit for: 50).
	
	^ account! !

!PortfolioTest methodsFor: 'test data' stamp: 'JPF 5/22/2021 11:52:30'!
portfolioWith: accountables

	| portfolio |
	
	portfolio _ Portfolio new.
	accountables do: [ :accountable | portfolio addAccountable: accountable ].
	
	^ portfolio! !

!PortfolioTest methodsFor: 'test data' stamp: 'JPF 5/22/2021 09:39:44'!
portfolioWithBalance50

	| portfolio |
	
	portfolio _ Portfolio new.
	portfolio addAccountable: (self accountWithBalance50).
	
	^ portfolio! !


!PortfolioTest methodsFor: 'tests - adding' stamp: 'JPF 5/23/2021 21:26:55'!
test15ShouldFailWhenAddingTheSameAccountTwiceToAPortfolio
	
	| portfolio account|
	
	account _ self accountWithBalance50.
	portfolio _ self portfolioWith: { account }.
	
	self 
		should: [ portfolio addAccountable: account ]
		raise: Error
		withExceptionDo: [ :error | self assert: 1 equals: portfolio accountables size ]
		description: Portfolio cantHaveRepeatedAccountablesErrorDescription.
	
	! !

!PortfolioTest methodsFor: 'tests - adding' stamp: 'JPF 5/23/2021 21:21:24'!
test16ShouldFailWhenAddingAnAccountToPortfolioThatIsAlreadyInsideAChildPortfolio

	| portfolio portfolio2 account|
	
	account _ self accountWithBalance50.
	portfolio2 _ self portfolioWith: { account }.
	portfolio _ self portfolioWith: { portfolio2 }.
	
	self assertCantAdd: account to: portfolio! !

!PortfolioTest methodsFor: 'tests - adding' stamp: 'JPF 5/23/2021 21:21:31'!
test17ShouldFailWhenAddingAPortfolioWithAnAccountToAPortfolioThatHasTheSameAccount
	| portfolio portfolio2 account|
	
	account _ self accountWithBalance50.
	portfolio2 _ self portfolioWith: { account }.
	portfolio _ self portfolioWith: { account }.
	
	self assertCantAdd: portfolio2 to: portfolio! !

!PortfolioTest methodsFor: 'tests - adding' stamp: 'JPF 5/23/2021 21:21:40'!
test18ShouldFailWhenAddingAPortfolioWithAnAccountToAPortfolioThatHasAFatherPortfolioWithTheSameAccount
	| porfolioRoot1 porfolioRoot2 portfolioToAdd portfolio account|
	
	account _ self accountWithBalance50.
	portfolio _ Portfolio new.
	porfolioRoot1 _ self portfolioWith: { account. portfolio }.
	porfolioRoot2 _ self portfolioWith: { portfolio }.
	portfolioToAdd _ self portfolioWith: { account }.
	
	self assertCantAdd: portfolioToAdd to: portfolio! !

!PortfolioTest methodsFor: 'tests - adding' stamp: 'JPF 5/23/2021 21:22:46'!
test19ShouldFailWhenAddingAnEmptyPortfolioToItselfBeingInTwoPortfolios
	| portfolio fatherPorfolio1 fatherPorfolio2 |
	
	portfolio _ Portfolio new.
	fatherPorfolio1 _ self portfolioWith: { portfolio }.
	fatherPorfolio2 _ self portfolioWith: { portfolio }.
	
	self assertCantAdd: portfolio to: portfolio

	
	! !


!PortfolioTest methodsFor: 'assertions' stamp: 'JPF 5/23/2021 20:12:13'!
assert: aPortfolio hasOnly: transactions
	
	self assert: transactions size equals: aPortfolio transactions size.
	transactions do: [ :transaction | self assert: (aPortfolio transactions includes: transaction) ]
	! !

!PortfolioTest methodsFor: 'assertions' stamp: 'JPF 5/23/2021 20:12:02'!
assert: aPortfolio hasRegistered: transactions
	
	transactions do: [ :transaction | self assert: (aPortfolio hasRegistered: transaction) ]
	! !

!PortfolioTest methodsFor: 'assertions' stamp: 'JPF 5/23/2021 21:26:55'!
assertCantAdd: anAccountable to: aPortfolio
	
	self 
		should: [ aPortfolio addAccountable: anAccountable ]
		raise: Error
		withExceptionDo: [ :error | self deny: (aPortfolio accountables includes: anAccountable) ]
		description: Portfolio cantHaveRepeatedAccountablesErrorDescription.
	
	! !


!PortfolioTest methodsFor: 'tests - transactions' stamp: 'JPF 5/23/2021 20:04:28'!
test09PortfolioWithOneAccountWithOneTransactionHasOnlyThatTransaction
	
	| portfolio transaction account |
	
	portfolio _ Portfolio new.
	transaction _ self a50Deposit.
	account _ self accountWith: { transaction }.
	portfolio addAccountable: account.
	
	self assert: portfolio hasOnly: { transaction }.
	! !

!PortfolioTest methodsFor: 'tests - transactions' stamp: 'JPF 5/23/2021 20:06:56'!
test10PortfolioWithTwoAccountsWithOneTransactionHasOnlyThatTwoTransactions
	
	| portfolio transaction1 transaction2 account1 account2 |
	
	transaction1 _ self a50Deposit.
	account1 _ self accountWith: { transaction1 }.
	
	transaction2 _ self a50Deposit.
	account2 _ self accountWith: { transaction2 }.
	
	portfolio _ self portfolioWith: { account1. account2 }.
	
	self assert: portfolio hasOnly: { transaction1. transaction2 }.! !

!PortfolioTest methodsFor: 'tests - transactions' stamp: 'JPF 5/23/2021 20:10:45'!
test11PortfolioWithTwoPortfoliosWithTwoTransactionsHasOnlyThatFourTransactions
	
	| portfolio portfolio1 portfolio2 
		transaction1 transaction2 transaction3 transaction4
		account1 account2 |
	
	"portfolio _ Portfolio new."
	
	transaction1 _ self a50Deposit.
	transaction2 _ self a50Withdraw.
	account1 _ self accountWith: { transaction1. transaction2 }.
	portfolio1 _ self portfolioWith: { account1 }.
	
	transaction3 _ self a50Deposit.
	transaction4 _ self a50Withdraw.
	account2 _ self accountWith: { transaction3. transaction4 }.
	portfolio2 _ self portfolioWith: { account2 }.
	
	portfolio _ self portfolioWith: { portfolio1. portfolio2 }.
	
	self assert: portfolio 
		hasOnly: { 	transaction1. 	transaction2. 		transaction3. 	transaction4 	}! !

!PortfolioTest methodsFor: 'tests - transactions' stamp: 'JPF 5/22/2021 10:37:49'!
test12EmptyPortfolioHasNotRegisteredAnyTransactions
	
	| portfolio |
	
	portfolio _ Portfolio new.
	
	self deny: (portfolio hasRegistered: self a50Deposit).! !

!PortfolioTest methodsFor: 'tests - transactions' stamp: 'JPF 5/22/2021 10:40:30'!
test13PortfolioWithOneAccountWithOneTransactionHasRegisteredThatTransaction
	
	| portfolio transaction account |
	
	portfolio _ Portfolio new.
	transaction _ self a50Deposit.
	account _ self accountWith: { transaction }.
	portfolio addAccountable: account.
	
	self assert: (portfolio hasRegistered: transaction).
	! !

!PortfolioTest methodsFor: 'tests - transactions' stamp: 'JPF 5/23/2021 20:14:29'!
test14PortfolioWithTwoPortfoliosWithTwoTransactionsHasRegisteredThatFourTransactions
	
	| portfolio portfolio1 portfolio2 
		transaction1 transaction2 transaction3 transaction4
		account1 account2 |
	
	transaction1 _ self a50Deposit.
	transaction2 _ self a50Withdraw.
	account1 _ self accountWith: { transaction1. transaction2}.
	portfolio1 _ self portfolioWith: { account1 }.
	
	transaction3 _ self a50Deposit.
	transaction4 _ self a50Withdraw.
	account2 _ self accountWith: { transaction3. transaction4}.
	portfolio2 _ self portfolioWith: { account2 }.
	
	portfolio _ self portfolioWith: { portfolio1. portfolio2 }.
	
	self assert: portfolio
		hasRegistered: { transaction1. transaction2. transaction3. transaction4 }! !


!PortfolioTest methodsFor: 'tests - balance' stamp: 'JPF 5/22/2021 08:57:15'!
test01EmptyPortfolioHasBalance0
	
	| portfolio |
	
	portfolio _ Portfolio new.
	
	self assert: 0 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests - balance' stamp: 'JPF 5/22/2021 09:39:44'!
test02PortfolioWithOneAccountWithBalance50HasBalance50
	
	| portfolio |
	
	portfolio _ Portfolio new.
	portfolio addAccountable: self accountWithBalance50.
	
	self assert: 50 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests - balance' stamp: 'JPF 5/23/2021 20:15:01'!
test03PortfolioWithTwoAccountsWithBalance50HasBalance100
	
	| portfolio |
	
	portfolio _ self portfolioWith: { self accountWithBalance50. self accountWithBalance50 }.
	
	self assert: 100 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests - balance' stamp: 'JPF 5/23/2021 20:15:06'!
test04PortfolioWithOnePortfolioWithBalance50HasBalance50
	
	| portfolio |
	
	portfolio _ self portfolioWith: { self portfolioWithBalance50 }.
	
	self assert: 50 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests - balance' stamp: 'JPF 5/23/2021 20:14:52'!
test05PortfolioWithTwoPortfoliosWithBalance50HasBalance100
	
	| portfolio |
	
	portfolio _ self portfolioWith: { self portfolioWithBalance50. self portfolioWithBalance50 }.

	self assert: 100 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests - balance' stamp: 'JPF 5/23/2021 20:15:14'!
test06PortfolioWithOnePortfolioAndOneAccountWithBalance50HasBalance100
	
	| portfolio |
	
	portfolio _ self portfolioWith: { self portfolioWithBalance50. self accountWithBalance50 }.
	
	self assert: 100 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests - balance' stamp: 'JPF 5/23/2021 19:57:24'!
test07PortfolioWithTwoPortfoliosAndTwoAccountsWithBalance50HasBalance200
	
	| portfolio |
	
	portfolio _ self portfolioWith: {
		self portfolioWithBalance50.
		self portfolioWithBalance50.
		self accountWithBalance50.
		self accountWithBalance50
	}.
	
	self assert: 200 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests - balance' stamp: 'JPF 5/22/2021 09:52:09'!
test08EmptyPortfolioHasNoTransactions
	
	| portfolio |
	
	portfolio _ Portfolio new.
	
	self assert: portfolio transactions isEmpty! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
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


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'JPF 5/22/2021 08:53:18'!
addToBalance: aBalance
	
	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
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


!Deposit methodsFor: 'balance' stamp: 'JPF 5/22/2021 08:52:32'!
addToBalance: aBalance
	
	^ aBalance + value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
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


!Withdraw methodsFor: 'balance' stamp: 'JPF 5/22/2021 08:52:08'!
addToBalance: aBalance
	
	^ aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Accountable category: #'Portfolio-Ejercicio'!
Object subclass: #Accountable
	instanceVariableNames: 'fatherPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Accountable methodsFor: 'balance' stamp: 'JPF 5/22/2021 10:58:20'!
balance
	
	self subclassResponsibility! !


!Accountable methodsFor: 'transactions' stamp: 'JPF 5/22/2021 11:19:28'!
addTransactionsTo: incomeTransactions

	self subclassResponsibility! !

!Accountable methodsFor: 'transactions' stamp: 'JPF 5/22/2021 10:58:08'!
transactions
	
	self subclassResponsibility! !


!Accountable methodsFor: 'testing' stamp: 'JPF 5/22/2021 10:58:36'!
hasRegistered: aTransaction
	
	self subclassResponsibility! !


!Accountable methodsFor: 'father portfolios' stamp: 'JPF 5/23/2021 19:50:41'!
addTo: aPortfolio
	
	fatherPortfolios add: aPortfolio! !

!Accountable methodsFor: 'father portfolios' stamp: 'JPF 5/23/2021 20:37:48'!
fatherPortfolios
	
	^ fatherPortfolios! !

!Accountable methodsFor: 'father portfolios' stamp: 'JPF 5/23/2021 19:50:18'!
removeFrom: aPortfolio
	
	fatherPortfolios removeFirst: aPortfolio! !

!Accountable methodsFor: 'father portfolios' stamp: 'JPF 5/25/2021 10:12:28'!
rootPortfolios

	fatherPortfolios 
		ifEmpty: [ ^ OrderedCollection with: self ] 
		ifNotEmpty: [ ^ fatherPortfolios inject: OrderedCollection new into: [ :rootPortfolios :fatherPortfolio |
			rootPortfolios addAll: fatherPortfolio rootPortfolios.
			rootPortfolios.
		]]
	
	! !


!Accountable methodsFor: 'visitor' stamp: 'JPF 5/23/2021 20:34:00'!
accept: aVisitor
	
	self subclassResponsibility! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Accountable subclass: #Portfolio
	instanceVariableNames: 'accountables'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'JPF 5/22/2021 09:41:34'!
balance
	
	^ accountables sum: [:accountable | accountable balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'assertions' stamp: 'JPF 5/25/2021 09:47:52'!
assertRootPortfoliosWontHaveRepeatedAccountablesAfterAdding: anAccountable

	| aRootPortfolioHasRepeatedAccountables |
	
	self havingTemporary: anAccountable do: [ 
		aRootPortfolioHasRepeatedAccountables _			self anyRootPortfolioHasRepeatedAccountables.
		].
	
	aRootPortfolioHasRepeatedAccountables ifTrue: [
		self error: self class cantHaveRepeatedAccountablesErrorDescription.
		]! !


!Portfolio methodsFor: 'initialization' stamp: 'JPF 5/23/2021 19:49:49'!
initialize

	accountables _ OrderedCollection new.
	fatherPortfolios _ OrderedCollection new.! !


!Portfolio methodsFor: 'testing' stamp: 'JPF 5/22/2021 10:49:36'!
hasRegistered: aTransaction
	
	^ accountables anySatisfy: [ :accountable | accountable hasRegistered: aTransaction].! !


!Portfolio methodsFor: 'transactions' stamp: 'JPF 5/22/2021 11:13:07'!
addTransactionsTo: incomeTransactions

	^ accountables do: [ :accountable | 			accountable addTransactionsTo: incomeTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'JPF 5/23/2021 20:19:09'!
transactions

	^ accountables inject: OrderedCollection new
		into: [ :transactions :accountable |
			accountable addTransactionsTo: transactions.
			transactions ]! !


!Portfolio methodsFor: 'accountables private' stamp: 'JPF 5/25/2021 09:47:21'!
anyRootPortfolioHasRepeatedAccountables

	^ self rootPortfolios anySatisfy: [ :rootPortfolio | rootPortfolio hasRepeatedAccountables ]! !

!Portfolio methodsFor: 'accountables private' stamp: 'JPF 5/25/2021 09:35:21'!
havingTemporary: anAccountable do: aBlock

	accountables add: anAccountable.
	aBlock ensure: [ accountables remove: anAccountable ]! !


!Portfolio methodsFor: 'accountables' stamp: 'JPF 5/23/2021 12:53:07'!
accountables
	
	^ accountables! !

!Portfolio methodsFor: 'accountables' stamp: 'JPF 5/25/2021 09:42:26'!
addAccountable: anAccountable
	
	self assertRootPortfoliosWontHaveRepeatedAccountablesAfterAdding: anAccountable.
	
	accountables add: anAccountable.
	anAccountable addTo: self.! !

!Portfolio methodsFor: 'accountables' stamp: 'JPF 5/25/2021 10:14:09'!
hasRepeatedAccountables

	^ RepeatedAccountablesVisitor new hasRepeatedAccountables: self! !


!Portfolio methodsFor: 'visitor' stamp: 'JPF 5/23/2021 20:34:11'!
accept: aVisitor
	
	aVisitor visitPortfolio: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'JPF 5/23/2021 21:26:55'!
cantHaveRepeatedAccountablesErrorDescription

	^ 'a portfolio can not have reapeted accounts'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Accountable subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'JPF 5/23/2021 19:49:49'!
initialize

	transactions _ OrderedCollection new.
	fatherPortfolios _ OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'JPF 5/22/2021 11:16:29'!
addTransactionsTo: incomeTransactions

	^ incomeTransactions addAll: self transactions.! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'JPF 5/23/2021 13:52:51'!
balance

	^ transactions inject: 0 into: [ :partialBalance :aTransaction |
		aTransaction addToBalance: partialBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'visitor' stamp: 'JPF 5/23/2021 20:34:28'!
accept: aVisitor
	
	aVisitor visitAccount: self.! !


!classDefinition: #RepeatedAccountablesVisitor category: #'Portfolio-Ejercicio'!
Object subclass: #RepeatedAccountablesVisitor
	instanceVariableNames: 'visited hasRepeatedNodes'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!RepeatedAccountablesVisitor methodsFor: 'initialization' stamp: 'JPF 5/23/2021 12:51:05'!
initialize
	
	hasRepeatedNodes _ false.
	visited _ Set new.! !


!RepeatedAccountablesVisitor methodsFor: 'private' stamp: 'JPF 5/25/2021 10:40:52'!
visit: anAccountable ifNotVisitedDo: aBlock
	
	(visited includes: anAccountable)
		ifTrue: [ hasRepeatedNodes _ true ]
		ifFalse: [
			visited add: anAccountable.
			aBlock value
			].
	! !


!RepeatedAccountablesVisitor methodsFor: 'repeated nodes' stamp: 'JPF 5/23/2021 19:42:53'!
hasRepeatedAccountables: anAccountable
	
	anAccountable accept: self.
	^ hasRepeatedNodes.! !

!RepeatedAccountablesVisitor methodsFor: 'repeated nodes' stamp: 'JPF 5/25/2021 10:41:36'!
visitAccount: anAccount
	
	self visit: anAccount ifNotVisitedDo: []
	! !

!RepeatedAccountablesVisitor methodsFor: 'repeated nodes' stamp: 'JPF 5/25/2021 10:41:48'!
visitPortfolio: aPortfolio
	
	self visit: aPortfolio ifNotVisitedDo: [
		aPortfolio accountables do: [ :accountable | accountable accept: self ]
		]
	! !
