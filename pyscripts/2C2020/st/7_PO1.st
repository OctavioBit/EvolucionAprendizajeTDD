!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'creation' stamp: 'ja 11/9/2020 16:18:30'!
test01PortfolioHasNotAccountsWhenCreated
	| portfolio |
	portfolio _ Portfolio new.
	self assert: portfolio isEmpty.
	self assert: 0 equals: portfolio balance.! !


!PortfolioTest methodsFor: 'accounts-adding' stamp: 'ja 11/9/2020 16:40:29'!
test02EmptyAccountCanBeAddedToPortfolio
	| portfolio account |
	portfolio _ Portfolio new.
	account  _ ReceptiveAccount new.
	portfolio register: account.
	
	self assertWhenAPortfolio: portfolio hasAmountOfAccounts: 1 andBalance: 0.! !

!PortfolioTest methodsFor: 'accounts-adding' stamp: 'ja 11/9/2020 16:47:20'!
test03DepositeOnlyAccountCanBeAddedToPortfolio
	| portfolio account |
	portfolio _ Portfolio new.
	account  _ ReceptiveAccount new.
	Deposit register: 100 on: account.
	Deposit register: 100 on: account.
	Deposit register: 100 on: account.
	portfolio register: account.
	
	self assertWhenAPortfolio: portfolio hasAmountOfAccounts: 1 andBalance: 300.! !

!PortfolioTest methodsFor: 'accounts-adding' stamp: 'ja 11/9/2020 16:47:49'!
test04WithdrawOnlyAccountCanBeAddedToPortfolio
	| portfolio account |
	portfolio _ Portfolio new.
	account  _ ReceptiveAccount new.
	Deposit register: 1000 on: account.
	Withdraw register: 50 on: account.
	Withdraw register: 50 on: account.
	Withdraw register: 50 on: account.
	portfolio register: account.
	self assertWhenAPortfolio: portfolio hasAmountOfAccounts: 1 andBalance: 850.! !

!PortfolioTest methodsFor: 'accounts-adding' stamp: 'ja 11/9/2020 16:48:12'!
test05MultipleTransactionsAccountCanBeAddedToPortfolio
	| portfolio account |
	portfolio _ Portfolio new.
	account  _ ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.	
	portfolio register: account.
	self assertWhenAPortfolio: portfolio hasAmountOfAccounts: 1  andBalance: 150.! !

!PortfolioTest methodsFor: 'accounts-adding' stamp: 'ja 11/9/2020 16:48:38'!
test06MultipleAccountsCanBeAddedToPortfolio
	| portfolio account1 account2 account3 totalBalance |
	portfolio _ Portfolio new.
	account1  _ self accountWithBalanceOf50 .
	account2  _ self accountWithBalanceOf50 .
	account3  _ self accountWithBalanceOf50 .
	portfolio register: account1.
	portfolio register: account2.
	portfolio register: account3.
	totalBalance _ account1 balance + account2 balance + account3 balance.
	
	self assertWhenAPortfolio: portfolio hasAmountOfAccounts: 3 andBalance: totalBalance .! !


!PortfolioTest methodsFor: 'portfolios-adding' stamp: 'ja 11/9/2020 16:46:40'!
test07EmptyPortfolioCanBeAddedToPortfolio
	| portfolio1 portfolio2 |
	portfolio1 _ Portfolio new.
	portfolio2  _ Portfolio new.
	portfolio1 register: portfolio2.
	
	self assertWhenAPortfolio: portfolio1 hasAmountOfPortfolios: 1 andBalance: 0.! !

!PortfolioTest methodsFor: 'portfolios-adding' stamp: 'ja 11/9/2020 16:49:11'!
test08NotEmptyPortfolioCanBeAddedToPortfolio
	| rootPortfolio childPortfolio account1 account2 account3 |
	
	rootPortfolio _ Portfolio new.
	childPortfolio  _ Portfolio new.
	account1  _ self accountWithBalanceOf50 .
	account2  _ self accountWithBalanceOf50 .
	account3  _ self accountWithBalanceOf50 .
	
	childPortfolio register: account1.
	childPortfolio register: account2.
	childPortfolio register: account3.
	rootPortfolio register: childPortfolio.
	self assertWhenAPortfolio: rootPortfolio hasAmountOfPortfolios: 1 andBalance: 150.
	
	! !

!PortfolioTest methodsFor: 'portfolios-adding' stamp: 'ja 11/9/2020 16:49:35'!
test09MultiplePortfoliosCanBeAddedToPortfolio
	| portfolioRoot portfolioChild1 portfolioChild2 account1 account2|
	portfolioRoot _ Portfolio new.
	portfolioChild1 _ Portfolio new.
	portfolioChild2 _ Portfolio new.
	account1  _ self accountWithBalanceOf50 .
	account2  _ self accountWithBalanceOf50 .
	portfolioChild1 register: account1.
	portfolioChild2  register: account2.
	portfolioRoot register: portfolioChild1.
	portfolioRoot register: portfolioChild2.
	self assertWhenAPortfolio: portfolioRoot hasAmountOfPortfolios: 2 andBalance: 100.
	
	! !


!PortfolioTest methodsFor: 'portfolios-adding policies' stamp: 'ja 11/9/2020 16:32:59'!
test10ChildCouldHaveManyParents
	| portfolioRoot1 portfolioRoot2 portfolioChild1 portfolioChild2 account1 account2 |
	portfolioRoot1 _ Portfolio new.
	portfolioRoot2 _ Portfolio new.
	portfolioChild1 _ Portfolio new.
	portfolioChild2 _ Portfolio new.
	account1  _ self accountWithBalanceOf50 .
	account2  _ self accountWithBalanceOf50 .
	portfolioChild1 register: account1.
	portfolioChild2  register: account2.
	portfolioRoot1 register: portfolioChild1.
	portfolioRoot1 register: portfolioChild2.
	portfolioRoot2 register: portfolioChild1.
	portfolioRoot2 register: portfolioChild2.
	self deny: portfolioRoot1 isEmpty.
	self deny: portfolioRoot2 isEmpty.
	self assert: 2 equals: portfolioRoot1 amountOfPortfolios.
	self assert: 2 equals: portfolioRoot2 amountOfPortfolios.
	self assert: 100 equals: portfolioRoot1 balance.
	self assert: 100 equals: portfolioRoot2 balance.	
	! !

!PortfolioTest methodsFor: 'portfolios-adding policies' stamp: 'ja 11/9/2020 17:07:56'!
test11ChildrenCouldHaveManyParents
	| portfolioRoot1 portfolioRoot2 portfolioRoot3 
	 portfolioChild1 portfolioChild2  portfolioChild3 
	 account1 account2 account3 |
	portfolioRoot1 _ Portfolio new.
	portfolioRoot2 _ Portfolio new.
	portfolioRoot3 _ Portfolio new.
	portfolioChild1 _ Portfolio new.
	portfolioChild2 _ Portfolio new.
	portfolioChild3 _ Portfolio new.
	account1  _ self accountWithSingleDepositOf: 200 andSingleWithdrawOf: 50.
	account2  _ self accountWithSingleDepositOf: 150 andSingleWithdrawOf: 50.
	account3  _ self accountWithBalanceOf50 .
	portfolioChild1 register: account1.
	portfolioChild1  register: portfolioChild3. 
	portfolioChild2  register: account2.
	portfolioChild3 register: account3.
	portfolioRoot1 register: portfolioChild1.
	portfolioRoot1 register: portfolioChild2.
	portfolioRoot2 register: portfolioChild2.
	portfolioRoot3 register: portfolioChild3 .
	self deny: portfolioRoot1 isEmpty.
	self deny: portfolioRoot2 isEmpty.
	self deny: portfolioRoot3 isEmpty.
	self assert: 2 equals: portfolioRoot1 amountOfPortfolios.
	self assert: 1 equals: portfolioRoot2 amountOfPortfolios.
	self assert: 1 equals: portfolioRoot3 amountOfPortfolios.
	self assert: 300 equals: portfolioRoot1 balance.
	self assert: 100 equals: portfolioRoot2 balance.	
	self assert: 50 equals: portfolioRoot3 balance.		! !

!PortfolioTest methodsFor: 'portfolios-adding policies' stamp: 'ja 11/9/2020 16:51:35'!
test12PortofolioCantAddItself
	| portfolioRoot |
	portfolioRoot _ Portfolio new.
	self should: [ portfolioRoot register: portfolioRoot . self fail]  
		raise: Error
		withMessageText: Portfolio cantAddPortfolioErrorDescription .
	self assert: 0 equals: portfolioRoot amountOfAccounts.
	self assert: 0 equals: portfolioRoot balance.! !

!PortfolioTest methodsFor: 'portfolios-adding policies' stamp: 'ja 11/9/2020 17:09:39'!
test13PortfolioCantBeAddedTwiceToSameParent
	| portfolioRoot1 portfolioChild1 account1 |
	portfolioRoot1 _ Portfolio new.
	portfolioChild1 _ Portfolio new.
	account1  _ self accountWithSingleDepositOf: 200 andSingleWithdrawOf: 50.
	portfolioRoot1 register: account1.
	portfolioRoot1 register: portfolioChild1.
	self should: [ portfolioRoot1 register: portfolioChild1 . self fail]  
		raise: Error
		withMessageText: Portfolio cantAddPortfolioErrorDescription .
	self deny: portfolioRoot1 isEmpty.
	self assert: 1 equals: portfolioRoot1 amountOfPortfolios.
	self assert: 1 equals: portfolioRoot1 amountOfAccounts.
	self assert: 150 equals: portfolioRoot1 balance.
	self assert: 0 equals: portfolioChild1 balance.! !

!PortfolioTest methodsFor: 'portfolios-adding policies' stamp: 'ja 11/9/2020 17:09:03'!
test14CyclesWithParentOnSingleParentNodeAreForbidden	
	| portfolioRoot1 portfolioChild1 portfolioChild2 account1 |
	
	portfolioRoot1 _ Portfolio new.
	
	portfolioChild1 _ Portfolio new.
	
	portfolioChild2 _ Portfolio new.
	
	account1  _ self accountWithSingleDepositOf: 200 andSingleWithdrawOf: 50.
	
	portfolioRoot1 register: account1 .
	
	portfolioRoot1 register: portfolioChild1.
	
	portfolioChild1 register: portfolioChild2.
	
	self should: [ portfolioChild2 register: portfolioRoot1. self fail]  
		raise: Error
		withMessageText: Portfolio cantAddPortfolioErrorDescription. .! !

!PortfolioTest methodsFor: 'portfolios-adding policies' stamp: 'ja 11/9/2020 16:50:41'!
test15CyclesWithOtherNodeOnSingleParentNodeAreForbidden
	| portfolioRoot1 portfolioChild1 portfolioChild2 portfolioChild3 portfolioChild4 |
	portfolioRoot1 _ Portfolio new.
	portfolioChild1 _ Portfolio new.
	portfolioChild2 _ Portfolio new.
	portfolioChild3 _ Portfolio new.
	portfolioChild4 _ Portfolio new.
	portfolioRoot1 register: portfolioChild1.
	portfolioChild1 register: portfolioChild2.
	portfolioChild1 register: portfolioChild3.
	portfolioChild3 register: portfolioChild4.
	self should: [ portfolioChild4 register: portfolioChild2 . self fail]  
		raise: Error
		withMessageText: Portfolio cantAddPortfolioErrorDescription .
! !

!PortfolioTest methodsFor: 'portfolios-adding policies' stamp: 'ja 11/9/2020 16:26:22'!
test16CyclesWithParentOnMultipleParentNodeAreForbidden
	| portfolioRoot1 portfolioRoot2 portfolioRoot3 portfolioChild1 portfolioChild2 portfolioChild3 portfolioChild4 |
	portfolioRoot1 _ Portfolio new.
	portfolioRoot2 _ Portfolio new.
	portfolioRoot3 _ Portfolio new.
	portfolioChild1 _ Portfolio new.
	portfolioChild2 _ Portfolio new.
	portfolioChild3 _ Portfolio new.
	portfolioChild4 _ Portfolio new.
	portfolioRoot1 register: portfolioChild1.
	portfolioRoot2 register: portfolioChild4.
	portfolioRoot3 register: portfolioChild4.
	portfolioChild1 register: portfolioChild2.
	portfolioChild1 register: portfolioChild3.
	portfolioChild3 register: portfolioChild4.
	self should: [ portfolioChild4 register: portfolioRoot1 . self fail]  
		raise: Error
		withMessageText: Portfolio cantAddPortfolioErrorDescription .! !

!PortfolioTest methodsFor: 'portfolios-adding policies' stamp: 'ja 11/9/2020 16:34:25'!
test17CyclesWithOtherNodeOnMultipleParentNodeAreForbidden
	| portfolioRoot1 portfolioRoot2 portfolioRoot3 portfolioChild1 portfolioChild2 portfolioChild3 portfolioChild4 |
	portfolioRoot1 _ Portfolio new.
	portfolioRoot2 _ Portfolio new.
	portfolioRoot3 _ Portfolio new.
	portfolioChild1 _ Portfolio new.
	portfolioChild2 _ Portfolio new.
	portfolioChild3 _ Portfolio new.
	portfolioChild4 _ Portfolio new.
	portfolioRoot1 register: portfolioChild1.
	portfolioRoot2 register: portfolioChild4.
	portfolioRoot3 register: portfolioChild4.
	portfolioChild1 register: portfolioChild2.
	portfolioChild1 register: portfolioChild3.
	portfolioChild3 register: portfolioChild4.
	self should: [ portfolioChild4 register: portfolioChild2 . self fail]  
		raise: Error
		withMessageText: Portfolio cantAddPortfolioErrorDescription .! !


!PortfolioTest methodsFor: 'accounts-adding policies' stamp: 'ja 11/9/2020 17:06:09'!
test18AccountAlreadyInPortfolioCantBeAddedToAnotherPortfolioOfSameTree
	| portfolioRoot1 portfolioChild1 account1 |
	portfolioRoot1 _ Portfolio new.
	portfolioChild1 _ Portfolio new.			
	account1  _ self accountWithSingleDepositOf: 200 andSingleWithdrawOf: 50.
	portfolioRoot1 register: account1.
	portfolioRoot1 register: portfolioChild1.
	self should: [ portfolioChild1 register: account1 . self fail]  
		raise: Error
		withMessageText: ReceptiveAccount cantAddAccountErrorDescription .! !


!PortfolioTest methodsFor: 'portfolio-multilevel operations' stamp: 'eb 11/8/2020 23:50:16'!
test19MultilevelBalance

	| rootPortfolio childPortfolio1 childPortfolio2 account1 account2 |
	
	account1  _ self  accountWithBalanceOf50 .
	
	account2  _ self  accountWithBalanceOf50 .
	
	rootPortfolio _ Portfolio new .
	
	childPortfolio1 _ Portfolio new.
	
	childPortfolio2 _ Portfolio  new.
	
	childPortfolio1 register: account1.
	
	childPortfolio2 register: account2 .
	
	rootPortfolio register: childPortfolio1 .
	
	rootPortfolio register:  childPortfolio2.
		
	self assert: 100 equals: rootPortfolio balance.
	
	
	
	! !

!PortfolioTest methodsFor: 'portfolio-multilevel operations' stamp: 'eb 11/8/2020 23:50:20'!
test20MultilevelTransactions

	| rootPortfolio childPortfolio1 childPortfolio2 account1 account2 deposit1 deposit2 withdraw1 withdraw2 |
	
	account1 _ ReceptiveAccount new.
	
	account2 _ ReceptiveAccount new.
	
	childPortfolio1 _ Portfolio new.
	
	childPortfolio2 _ Portfolio new.
	
	rootPortfolio _ Portfolio new.
	
	childPortfolio1 register: account1 .
	
	childPortfolio2 register: account2.
	
	rootPortfolio register: childPortfolio1.
	
	rootPortfolio register: childPortfolio2.
	
	deposit1 _ Deposit register: 100 on: account1 .
	
	deposit2 _ Deposit register: 200 on: account2 .
	
	withdraw1 _ Withdraw register: 50 on: account1 .
	
	withdraw2 _ Withdraw register: 100 on: account2 .
	
	self assert: (Set with: deposit1 with: deposit2 with: withdraw1 with: withdraw2)
		equals: rootPortfolio transactions .
	
	! !

!PortfolioTest methodsFor: 'portfolio-multilevel operations' stamp: 'eb 11/8/2020 23:50:25'!
test21MultilevelHasRegistered

	| rootPortfolio childPortfolio1 childPortfolio2 account1 account2 deposit1 deposit2 withdraw1 withdraw2 |
	
	account1 _ ReceptiveAccount new.
	
	account2 _ ReceptiveAccount new.
	
	childPortfolio1 _ Portfolio new.
	
	childPortfolio2 _ Portfolio new.
	
	rootPortfolio _ Portfolio new.
	
	childPortfolio1 register: account1 .
	
	childPortfolio2 register: account2.
	
	rootPortfolio register: childPortfolio1.
	
	rootPortfolio register: childPortfolio2.
	
	deposit1 _ Deposit register: 100 on: account1 .
	
	deposit2 _ Deposit register: 200 on: account2 .
	
	withdraw1 _ Withdraw register: 50 on: account1 .
	
	withdraw2 _ Withdraw register: 100 on: account2 .
	
	self assert: (rootPortfolio hasRegistered: deposit1).
	
	self assert: (childPortfolio1 hasRegistered: deposit1).
	
	self deny: (childPortfolio2 hasRegistered: deposit1).! !


!PortfolioTest methodsFor: 'private' stamp: 'eb 11/8/2020 23:11:10'!
accountWithBalanceOf50
	
	^ self accountWithSingleDepositOf: 100  andSingleWithdrawOf: 50.! !

!PortfolioTest methodsFor: 'private' stamp: 'eb 11/8/2020 23:10:33'!
accountWithSingleDepositOf: aDepositValue andSingleWithdrawOf: aWithdrawValue
	
	| account |
	
	account  _ ReceptiveAccount new.
	
	Deposit register: aDepositValue on: account.
	
	Withdraw register: aWithdrawValue on: account.
	
	^ account .
	! !

!PortfolioTest methodsFor: 'private' stamp: 'ja 11/9/2020 16:39:51'!
assertWhenAPortfolio: aPortfolio hasAmountOfAccounts: amountOfAccounts andBalance: valueBalance
	
	self deny: aPortfolio isEmpty.
	self assert: amountOfAccounts equals: aPortfolio amountOfAccounts.
	self assert: valueBalance equals: aPortfolio balance.! !

!PortfolioTest methodsFor: 'private' stamp: 'ja 11/9/2020 16:46:29'!
assertWhenAPortfolio: aPortfolio hasAmountOfPortfolios: amountOfPortfolios andBalance: valueBalance
	
	self deny: aPortfolio isEmpty.
	self assert: amountOfPortfolios equals: aPortfolio amountOfPortfolios .
	self assert: valueBalance equals: aPortfolio balance.! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ja 11/9/2020 16:27:08'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 
	| account |
	account := ReceptiveAccount new.
	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ja 11/9/2020 16:27:24'!
test02DepositIncreasesBalanceOnTransactionValue 
	| account |
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ja 11/9/2020 16:27:35'!
test03WithdrawDecreasesBalanceOnTransactionValue 
	| account |
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ja 11/9/2020 16:27:44'!
test04WithdrawValueMustBePositive 
	| account withdrawValue |
	account := ReceptiveAccount new.
	withdrawValue := 50.
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ja 11/9/2020 16:27:55'!
test05ReceptiveAccountKnowsRegisteredTransactions 
	| account deposit withdraw |
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ja 11/9/2020 16:28:04'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions
	| deposit withdraw account |
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ja 11/9/2020 16:28:14'!
test07AccountKnowsItsTransactions 
	| account1 deposit1 |
	account1 := ReceptiveAccount new.
	deposit1 := Deposit register: 50 on: account1.
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'eb 11/8/2020 21:36:25'!
value 
	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'eb 11/8/2020 21:43:41'!
valueInBalance
	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'initialization' stamp: 'eb 11/8/2020 21:38:03'!
initializeFor: aValue

	value _ aValue .

! !

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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'value' stamp: 'eb 11/8/2020 21:36:45'!
value
	^ value! !

!Deposit methodsFor: 'value' stamp: 'eb 11/8/2020 21:43:41'!
valueInBalance
	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'value' stamp: 'eb 11/8/2020 21:36:58'!
value
	^ value! !

!Withdraw methodsFor: 'value' stamp: 'eb 11/8/2020 21:43:41'!
valueInBalance
	^ value * (-1)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialInvestment category: #'Portfolio-Ejercicio'!
Object subclass: #FinancialInvestment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialInvestment methodsFor: 'management' stamp: 'ja 11/9/2020 16:29:16'!
balance
	self subclassResponsibility ! !

!FinancialInvestment methodsFor: 'management' stamp: 'eb 11/8/2020 23:47:22'!
hasRegistered: aTransaction
	self subclassResponsibility ! !

!FinancialInvestment methodsFor: 'management' stamp: 'ja 11/9/2020 16:29:24'!
register: aFinancialInvestment
	self subclassResponsibility ! !

!FinancialInvestment methodsFor: 'management' stamp: 'eb 11/8/2020 21:59:38'!
transactions
	
	self subclassResponsibility .! !


!FinancialInvestment methodsFor: 'register-private' stamp: 'ja 11/9/2020 16:29:08'!
registerAsChildOf: aPortfolio
	self subclassResponsibility .! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
FinancialInvestment subclass: #Portfolio
	instanceVariableNames: 'accounts childrenPortfolios parentsPortfolios state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'eb 11/8/2020 21:24:44'!
amountOfAccounts
	^ accounts size.! !

!Portfolio methodsFor: 'testing' stamp: 'eb 11/8/2020 21:31:51'!
amountOfPortfolios
	^ childrenPortfolios size.! !

!Portfolio methodsFor: 'testing' stamp: 'eb 11/8/2020 21:31:56'!
isEmpty
	^ (accounts size = 0) and: [ childrenPortfolios size = 0].! !


!Portfolio methodsFor: 'management' stamp: 'eb 11/8/2020 23:14:18'!
balance
	
	| childrenBalance |
	
	childrenBalance _ childrenPortfolios sum: [ :portfolio | portfolio balance ] ifEmpty: [0].
	
	^ childrenBalance + (self balanceOf: accounts)  .
		
		! !

!Portfolio methodsFor: 'management' stamp: 'eb 11/8/2020 23:49:22'!
hasRegistered: aTransaction
	
	^ self transactions includes: aTransaction .
	! !

!Portfolio methodsFor: 'management' stamp: 'eb 11/8/2020 20:40:27'!
register: aFinancialInvestment 	
	aFinancialInvestment registerAsChildOf: self.

! !

!Portfolio methodsFor: 'management' stamp: 'eb 11/8/2020 23:39:59'!
saveTransactionsInto: aTransactionCollection

	accounts do: [ :account | aTransactionCollection addAll: account transactions ].
	
	childrenPortfolios do: [ :portfolio | portfolio saveTransactionsInto: aTransactionCollection].! !

!Portfolio methodsFor: 'management' stamp: 'eb 11/8/2020 23:41:27'!
transactions

	| transactions |
	
	transactions _ Set new.
	
	self saveTransactionsInto: transactions .
	
	^ transactions.! !


!Portfolio methodsFor: 'accesing' stamp: 'eb 11/8/2020 21:24:39'!
accounts
	^ accounts copy.! !

!Portfolio methodsFor: 'accesing' stamp: 'eb 11/8/2020 21:25:11'!
portfolios
	^ childrenPortfolios copy.! !


!Portfolio methodsFor: 'register-private' stamp: 'eb 11/8/2020 19:34:40'!
registerAccount: aReceptiveAccount	
	accounts add: aReceptiveAccount ! !

!Portfolio methodsFor: 'register-private' stamp: 'eb 11/8/2020 22:43:08'!
registerAsChildOf: aParentPortfolio

	(aParentPortfolio itsHierarchyHasPortfolio: self) ifTrue: [ self error: self class cantAddPortfolioErrorDescription. ]. 
	
	aParentPortfolio registerChildPortfolio: self. 
	
	state _ NotRootPortfolio new.
	! !

!Portfolio methodsFor: 'register-private' stamp: 'eb 11/8/2020 21:30:55'!
registerChildPortfolio: aChildPortfolio
	aChildPortfolio registerParentPortfolio: self.
	childrenPortfolios add: aChildPortfolio . ! !

!Portfolio methodsFor: 'register-private' stamp: 'eb 11/8/2020 21:30:55'!
registerParentPortfolio: aParentPorfolio 
	parentsPortfolios add: aParentPorfolio .! !


!Portfolio methodsFor: 'initialization' stamp: 'eb 11/8/2020 21:27:18'!
initialize
	accounts _ OrderedCollection new.
	childrenPortfolios _ OrderedCollection new.
	parentsPortfolios _ OrderedCollection new. 
	state _ RootPortfolio new.! !


!Portfolio methodsFor: 'moving into hierarchy' stamp: 'eb 11/8/2020 22:43:59'!
itsHierarchyHasAccount: anAccount
	^ state lookForAccount: anAccount intoHierarchyOf: self.
! !

!Portfolio methodsFor: 'moving into hierarchy' stamp: 'eb 11/8/2020 22:44:15'!
itsHierarchyHasPortfolio: aPortfolio
	^ state lookForPortfolio: aPortfolio intoHierarchyOf: self.
! !

!Portfolio methodsFor: 'moving into hierarchy' stamp: 'eb 11/8/2020 22:48:31'!
searchAccountBelow: anAccount
	
	(accounts includes: anAccount) ifFalse: [
		childrenPortfolios detect: [ :portfolio | portfolio searchAccountBelow: anAccount ] ifNone:[^ false ].
	].

	^ true .
! !

!Portfolio methodsFor: 'moving into hierarchy' stamp: 'eb 11/8/2020 22:49:12'!
searchAccountFromAbove: anAccount
	parentsPortfolios detect: [ :portfolio | portfolio itsHierarchyHasAccount: anAccount ] ifNone: [^ false ] .
	
	^ true .! !

!Portfolio methodsFor: 'moving into hierarchy' stamp: 'eb 11/8/2020 22:45:47'!
searchPortfolioBelow: aPortfolio
	(self = aPortfolio) ifFalse: [ 
		childrenPortfolios detect:[ :children | children searchPortfolioBelow: aPortfolio ] ifNone:[^ false ]. 
		^ true .
	].
	
	^ true .
! !

!Portfolio methodsFor: 'moving into hierarchy' stamp: 'eb 11/8/2020 22:45:59'!
searchPortfolioFromAbove: aPortfolio
	parentsPortfolios detect: [ :portfolio | portfolio itsHierarchyHasPortfolio: aPortfolio ] ifNone: [^ false ] .
	
	^ true .! !


!Portfolio methodsFor: 'management-private' stamp: 'eb 11/8/2020 21:35:22'!
balanceOf: aFinancialInvestmentCollection

	^ aFinancialInvestmentCollection sum: [ :aFinancialInvestment | aFinancialInvestment balance] ifEmpty: [0].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'eb 11/8/2020 19:10:45'!
cantAddPortfolioErrorDescription
	
	^ 'Portfolio cant be added.'.! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
FinancialInvestment subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'ja 11/9/2020 16:28:37'!
initialize
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'management' stamp: 'eb 11/8/2020 23:04:55'!
balance
	^ transactions sum: [ :transaction | transaction valueInBalance ] ifEmpty: [0].
	! !

!ReceptiveAccount methodsFor: 'management' stamp: 'eb 11/8/2020 21:40:16'!
hasRegistered: aTransaction
	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'management' stamp: 'eb 11/8/2020 21:40:11'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'management' stamp: 'eb 11/8/2020 21:39:40'!
transactions 
	^ transactions copy! !


!ReceptiveAccount methodsFor: 'register-private' stamp: 'eb 11/8/2020 22:42:51'!
registerAsChildOf: aParentPortfolio
	(aParentPortfolio itsHierarchyHasAccount: self) ifTrue: [ self error: self class cantAddAccountErrorDescription . ]. 
	
	aParentPortfolio registerAccount: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: #'Portfolio-Ejercicio'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'error descriptions' stamp: 'eb 11/8/2020 22:53:36'!
cantAddAccountErrorDescription
	
	^ 'Account cant be added'.! !


!classDefinition: #PortfolioState category: #'Portfolio-Ejercicio'!
Object subclass: #PortfolioState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioState methodsFor: 'moving into hierarchy' stamp: 'eb 11/8/2020 22:44:51'!
lookForAccount: anAccount intoHierarchyOf: aParentPortfolio
	self subclassResponsibility .! !

!PortfolioState methodsFor: 'moving into hierarchy' stamp: 'eb 11/8/2020 22:44:15'!
lookForPortfolio: aPotentialChildPortfolio intoHierarchyOf: aPotentialParentPortfolio
	self subclassResponsibility .! !


!classDefinition: #NotRootPortfolio category: #'Portfolio-Ejercicio'!
PortfolioState subclass: #NotRootPortfolio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!NotRootPortfolio methodsFor: 'moving into hierarchy' stamp: 'eb 11/8/2020 22:45:19'!
lookForAccount: anAccount intoHierarchyOf: aParentPortfolio

	^ aParentPortfolio searchAccountFromAbove: anAccount .! !

!NotRootPortfolio methodsFor: 'moving into hierarchy' stamp: 'eb 11/8/2020 22:45:59'!
lookForPortfolio: aPotentialChildPortfolio intoHierarchyOf: aPotentialParentPortfolio
	^ aPotentialParentPortfolio searchPortfolioFromAbove: aPotentialChildPortfolio .! !


!classDefinition: #RootPortfolio category: #'Portfolio-Ejercicio'!
PortfolioState subclass: #RootPortfolio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!RootPortfolio methodsFor: 'moving into hierarchy' stamp: 'eb 11/8/2020 22:45:36'!
lookForAccount: anAccount intoHierarchyOf: aParentPortfolio

	^ aParentPortfolio searchAccountBelow: anAccount .! !

!RootPortfolio methodsFor: 'moving into hierarchy' stamp: 'eb 11/8/2020 22:45:47'!
lookForPortfolio: aPotentialChildPortfolio intoHierarchyOf: aPotentialParentPortfolio
	^ aPotentialParentPortfolio searchPortfolioBelow: aPotentialChildPortfolio .! !
