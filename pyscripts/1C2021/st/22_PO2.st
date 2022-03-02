!classDefinition: #AccountSummaryTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountSummaryTest methodsFor: 'tests' stamp: 'CD 6/1/2021 16:44:49'!
test01anAccountSummaryOfanAccountWithNoTransactionsShowsOnlyBalance

	| account accountSummary lines |
	account := ReceptiveAccount new.
	accountSummary := AccountSummary over: account.
	
	lines := accountSummary lines.
	
	self assert: 1 equals: lines size.
	self assert: 'Balance = 0' equals: lines first! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'CD 6/2/2021 01:26:35'!
test02anAccountSummaryShowsDeposit

	| account accountSummary lines |
	account := ReceptiveAccount new.
	Deposit register: 10 on: account.
	accountSummary := AccountSummary over: account.
	
	lines := accountSummary lines.
	
	self assert: 2 equals: lines size.
	self assert: 'Depósito por 10' equals: lines first.
	self assert: 'Balance = 10' equals: lines second! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'CD 6/2/2021 01:45:07'!
test03anAccountSummaryShowsWithDraw

	| account accountSummary lines |
	account := ReceptiveAccount new.
	Withdraw register: 10 on: account.
	accountSummary := AccountSummary over: account.
	
	lines := accountSummary lines.
	
	self assert: 2 equals: lines size.
	self assert: 'Extracción por 10' equals: lines first.
	self assert: 'Balance = -10' equals: lines second! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'CD 6/2/2021 01:49:27'!
test04anAccountSummaryShowsDepositTransfer

	| sourceAccount destinationAccount accountSummary lines |
	sourceAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	Transfer from: sourceAccount to: destinationAccount withValue: 10. 
	accountSummary := AccountSummary over: destinationAccount.
	
	lines := accountSummary lines.
	
	self assert: 2 equals: lines size.
	self assert: 'Entrada por transferencia de 10' equals: lines first.
	self assert: 'Balance = 10' equals: lines second.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'CD 6/2/2021 01:52:05'!
test05anAccountSummaryShowsWithdrawTransfer

	| sourceAccount destinationAccount accountSummary lines |
	sourceAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	Transfer from: sourceAccount to: destinationAccount withValue: 10. 
	accountSummary := AccountSummary over: sourceAccount.
	
	lines := accountSummary lines.
	
	self assert: 2 equals: lines size.
	self assert: 'Salida por transferencia de 10' equals: lines first.
	self assert: 'Balance = -10' equals: lines second.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'CD 6/2/2021 01:59:00'!
test06AccountSummaryIsResultOfAllTransactions

	| account anotherAccount accountSummary lines |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	Transfer from: account to: anotherAccount withValue: 100.
	Transfer from: anotherAccount to: account withValue: 30.
	Deposit register: 10  on: account.
	accountSummary := AccountSummary over: account.
	
	lines := accountSummary lines.
	
	self assert: 4 equals: lines size.
	self assert: 'Salida por transferencia de 100' equals: lines first.
	self assert: 'Entrada por transferencia de 30' equals: lines second.
	self assert: 'Depósito por 10' equals: lines third.
	self assert: 'Balance = -60' equals: lines fourth.
	 ! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'CD 6/2/2021 02:06:39'!
test07AccountSummaryIsCalculatedOnPortfolio

	| portfolio account anotherAccount accountSummary lines |
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	Transfer from: account to: anotherAccount withValue: 100.
	Deposit register: 50 on: account.
	portfolio := Portfolio with: account 	with: anotherAccount.
	accountSummary := AccountSummary over: portfolio.
	
	lines := accountSummary lines.
	
	self assert: 4 equals: lines size.
	self assert: 'Salida por transferencia de 100' equals: lines first.
	self assert: 'Depósito por 50' equals: lines second.
	self assert: 'Entrada por transferencia de 100' equals: lines third.
	self assert: 'Balance = 50' equals: lines fourth.
	! !


!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'CD 5/18/2021 18:34:45'!
test01aPortfolioWithoutAccountsHasABalanceOfZero

	self assert: Portfolio new balance equals: 0.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'CD 5/18/2021 19:10:35'!
test02aPortfolioWithOneAccountBalanceEqualsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 1000 on: account.
	portfolio := Portfolio with: account.
	
	self assert: portfolio balance equals: account balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'CD 5/18/2021 19:10:55'!
test03aPortfolioBalanceIsCalculatedRecursivelyOnItsAccountsBalances

	| anAccount anotherAccount aSimplePortfolio aComposedPortfolio |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 1000 on: anAccount .
	aSimplePortfolio := Portfolio with: anAccount.
	
	anotherAccount := ReceptiveAccount new.
	Withdraw register: 100 on: anotherAccount .
	aComposedPortfolio := Portfolio with: aSimplePortfolio with: anotherAccount.
	
	self assert: aComposedPortfolio balance equals: (aSimplePortfolio balance + anotherAccount balance).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'CD 5/19/2021 19:41:22'!
test04aPortfolioWithoutAccountsDoesNotHaveRegisteredTransactions

	self assert: ((Portfolio new hasRegistered: (Deposit for: 10)) not).
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'CD 5/19/2021 19:51:53'!
test05aPortfolioWithOneAccountHasRegisteredItsTransactions

	| portfolio account transaction |
	
	account := ReceptiveAccount new.
	transaction := Deposit register: 10 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: transaction).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'CD 5/19/2021 20:00:51'!
test06aPortfolioCalculatesRecursivelyItsRegisteredTransactions

	| anAccount portfolio anotherAccount composedPortfolio withdrawTransaction depositTransaction |
	
	anAccount := ReceptiveAccount new.
	depositTransaction := Deposit register: 10 on: anAccount .
	portfolio := Portfolio with: anAccount.
	
	anotherAccount := ReceptiveAccount new.
	withdrawTransaction := Withdraw register: 50 on: anotherAccount.
	composedPortfolio := Portfolio with: portfolio with: anotherAccount.
	
	self assert: (composedPortfolio hasRegistered: depositTransaction).
	self assert: (composedPortfolio hasRegistered: withdrawTransaction).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'CD 5/19/2021 20:19:32'!
test07aPortfolioWithoutAccountsDoesNotHaveTransactions

	self assert: Portfolio new transactions isEmpty.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'CD 5/19/2021 21:21:33'!
test08aPortfolioWithOneAccountHasSameTransactionsAsAccount

	| portfolio portfolioTransactions account  accountTransaction anotherAccount  anotherAccountTransaction |
	
	account := ReceptiveAccount new.
	accountTransaction := Deposit register: 10 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountTransaction := Withdraw register: 10 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountTransaction ).
	self assert: (portfolioTransactions includes: anotherAccountTransaction ).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'CD 5/20/2021 20:25:57'!
test09aPortfolioTransactionsIsSumOfItsAccountsTransactions

	|  portfolio composedPortfolio composedPortfolioTransactions  account anotherAccount accountTransaction anotherAccountTransaction  |
	
	account := ReceptiveAccount new.
	accountTransaction := Deposit register: 10 on: account .
	portfolio := Portfolio with: account .
	anotherAccount := ReceptiveAccount new.
	anotherAccountTransaction := Withdraw register: 10 on: anotherAccount .
	composedPortfolio := Portfolio with: portfolio with: anotherAccount .
	
	composedPortfolioTransactions := composedPortfolio transactions.
	
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: accountTransaction ).
	self assert: (composedPortfolioTransactions includes: anotherAccountTransaction ).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'CD 5/20/2021 20:42:51'!
test10aPortfolioCannotContainTheSameAccountTwice

	| aPortfolio anAccount |
	anAccount := ReceptiveAccount new.
	Deposit register: 10 on: anAccount.
	aPortfolio := Portfolio with: anAccount.
	
	self 
		should: [ aPortfolio add: anAccount ] 
		raise: Error 
		withMessageText: Portfolio errorMessageAlreadyAddedAccount.
	
 
	

	
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'CD 5/20/2021 20:52:33'!
test11aPortfolioCannotContainItself

	| aPortfolio anAccount |
	anAccount := ReceptiveAccount new.
	Deposit register: 10 on: anAccount.
	aPortfolio := Portfolio with: anAccount.
	
	self 
		should: [ aPortfolio add: aPortfolio ] 
		raise: Error 
		withMessageText: Portfolio errorMessageAlreadyAddedAccount.
	
 
	

	
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'CD 5/20/2021 20:57:38'!
test12aPortfolioCannotAddAccountOwnedByIncludedPortfolio

	| aComposedPortfolio aPortfolio anAccount |
	anAccount := ReceptiveAccount new.
	Deposit register: 10 on: anAccount.
	aPortfolio := Portfolio with: anAccount.
	aComposedPortfolio := Portfolio with: aPortfolio.
	
	self 
		should: [ aComposedPortfolio add: anAccount ] 
		raise: Error 
		withMessageText: Portfolio errorMessageAlreadyAddedAccount.
	
 
	

	
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'CD 5/24/2021 07:49:40'!
test13aPortfolioCannotHaveAncestorPortfolioAccount

	| account portfolio ancestorPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	ancestorPortfolio := Portfolio with: portfolio.
	ancestorPortfolio add: account.
	
	self 
		should: [portfolio add: account] 
		raise: Error 
		withMessageText: Portfolio errorMessageAlreadyAddedAccount.
	
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


!classDefinition: #TransferNetTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferNetTest methodsFor: 'tests' stamp: 'CD 6/1/2021 09:13:59'!
test01aTransferNetOverAccountWithoutTransactionsIsZero

	| account transferNet transferNetValue |
	
	account := ReceptiveAccount new.
	transferNet := TransferNet over: account.
	transferNetValue := transferNet value.
	
	self assert: 0 equals: transferNetValue.! !

!TransferNetTest methodsFor: 'tests' stamp: 'CD 6/1/2021 09:14:36'!
test02aDepositDoesNotAlterTransferNet

	| account transferNet transferNetValue |
	
	account := ReceptiveAccount new.
	Deposit register: 50 on: account.
	transferNet := TransferNet over: account.
	transferNetValue := transferNet value.
	
	self assert: 0 equals: transferNetValue.! !

!TransferNetTest methodsFor: 'tests' stamp: 'CD 6/1/2021 09:15:15'!
test03aWithdrawDoesNotAlterTransferNet

	| account transferNet transferNetValue |
	
	account := ReceptiveAccount new.
	Withdraw register: 50 on: account.
	transferNet := TransferNet over: account.
	transferNetValue := transferNet value.
	
	self assert: 0 equals: transferNetValue.! !

!TransferNetTest methodsFor: 'tests' stamp: 'CD 6/1/2021 09:56:53'!
test04aTransferIncrementsTransferNetOnDestinationAccount

	| sourceAccount destinationAccount transferNet transferNetValue  |
	
	sourceAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	Transfer from: sourceAccount to: destinationAccount withValue: 100.
	
	transferNet := TransferNet over: destinationAccount .
	transferNetValue := transferNet value.
	
	self assert: 100 equals: transferNetValue ! !

!TransferNetTest methodsFor: 'tests' stamp: 'CD 6/1/2021 09:57:10'!
test05aTransferDecrementsTransferNetOnSourceAccount

	| sourceAccount destinationAccount transferNet transferNetValue  |
	
	sourceAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	Transfer from: sourceAccount to: destinationAccount withValue: 100.
	
	transferNet := TransferNet over: sourceAccount.
	transferNetValue := transferNet value.
	
	self assert: -100 equals: transferNetValue ! !

!TransferNetTest methodsFor: 'tests' stamp: 'CD 6/1/2021 10:02:25'!
test06TransferNetIsResultOfAllTransactions

	| sourceAccount destinationAccount transferNet transferNetValue |
	
	sourceAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	Transfer from: sourceAccount to: destinationAccount withValue: 100.
	Transfer from: sourceAccount to: destinationAccount withValue: 30.
	
	transferNet := TransferNet over: sourceAccount .
	transferNetValue := transferNet value.
	
	self assert: -130 equals: transferNetValue.! !

!TransferNetTest methodsFor: 'tests' stamp: 'CD 6/1/2021 10:15:02'!
test07TransferNetIsCalculatedOnPortfolio

	| portfolio sourceAccount destinationAccount transferNet transferNetValue |
	
	sourceAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	Transfer from: sourceAccount to: destinationAccount withValue: 100.
	Transfer from: sourceAccount to: destinationAccount withValue: 30.
	portfolio := Portfolio with: sourceAccount 	with: destinationAccount.
	
	transferNet := TransferNet over: portfolio.
	transferNetValue := transferNet value.
	
	self assert: 0 equals: transferNetValue.! !


!classDefinition: #TransferTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferTest methodsFor: 'tests' stamp: 'CD 5/29/2021 15:39:01'!
test01aTransferDepositsInTransferedToAccountAndWithdrawsFromTransferedFromAccount

	| sourceAccount destinationAccount |
	sourceAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	Transfer from: sourceAccount to: destinationAccount withValue: 100.
	
	self assert: -100 equals: sourceAccount balance.
	self assert: 100 equals: destinationAccount balance.! !

!TransferTest methodsFor: 'tests' stamp: 'CD 6/2/2021 19:17:32'!
test02aTransferWithdrawEndCanGetToDepositEnd

	| transfer account anotherAccount |
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.		
	transfer := Transfer from: account to: anotherAccount  withValue: 10.
	
	self assert: transfer depositEnd equals: transfer withdrawEnd depositEnd.! !

!TransferTest methodsFor: 'tests' stamp: 'CD 6/2/2021 19:14:31'!
test03aTransferDepositEndCanGetToWithdrawEnd

	| transfer account anotherAccount |
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.		
	transfer := Transfer from: account to: anotherAccount  withValue: 10.
	
	self assert: transfer withdrawEnd equals: transfer depositEnd withdrawEnd.! !

!TransferTest methodsFor: 'tests' stamp: 'CD 6/2/2021 19:25:05'!
test04TransferEndsMustHaveSameTransfer

	| transfer account anotherAccount |
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.		
	transfer := Transfer from: account to: anotherAccount  withValue: 10.
	
	self assert: transfer withdrawEnd transfer equals: transfer depositEnd transfer.! !

!TransferTest methodsFor: 'tests' stamp: 'CD 6/2/2021 19:36:59'!
test05TransferEndsAreRegisteredInAccountsFromTransference

	| transfer account anotherAccount |
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.		
	transfer := Transfer from: account to: anotherAccount  withValue: 10.
	
	self assert: (account hasRegistered: transfer withdrawEnd).
	self assert: (anotherAccount hasRegistered: transfer depositEnd).! !


!classDefinition: #Account category: 'Portfolio-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Account methodsFor: 'auxiliars' stamp: 'CD 5/24/2021 07:54:02'!
addAsParent: account

	^ self subclassResponsibility.! !

!Account methodsFor: 'auxiliars' stamp: 'CD 5/24/2021 07:54:34'!
has: account

	^ self subclassResponsibility.! !


!Account methodsFor: 'transactions' stamp: 'CD 5/20/2021 20:34:46'!
addAllTransactionsTo: transactionsCollection

	^ self subclassResponsibility.! !

!Account methodsFor: 'transactions' stamp: 'CD 5/20/2021 20:32:52'!
transactions
	
	^ self subclassResponsibility.! !


!Account methodsFor: 'balance' stamp: 'CD 5/20/2021 20:32:38'!
balance

	^ self subclassResponsibility.! !


!Account methodsFor: 'registrations' stamp: 'CD 5/20/2021 20:33:15'!
hasRegistered: anAccount

	^ self subclassResponsibility.! !


!Account methodsFor: 'accept-visitor' stamp: 'CD 6/2/2021 19:02:26'!
visitTransactionsWith: anAccountVisitor

	^ self subclassResponsibility.

	! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'registrations' stamp: 'CD 5/19/2021 20:06:24'!
hasRegistered: aTransaction

	^ accounts anySatisfy: [ :anAccount | (anAccount hasRegistered: aTransaction) ].! !


!Portfolio methodsFor: 'initializers' stamp: 'CD 5/24/2021 07:50:51'!
initialize

	accounts := OrderedCollection new.
	parents := Set new.! !


!Portfolio methodsFor: 'accounts' stamp: 'CD 5/24/2021 07:52:36'!
add: account
	
	self canAddAccount: account.
	accounts add: account.
	account addAsParent: self.! !


!Portfolio methodsFor: 'transactions' stamp: 'CD 5/19/2021 20:32:55'!
addAllTransactionsTo: transactionsCollection

	accounts do: [ :anAccount | anAccount addAllTransactionsTo: transactionsCollection ].! !

!Portfolio methodsFor: 'transactions' stamp: 'CD 5/20/2021 20:34:12'!
transactions

	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addAllTransactionsTo: transactions].
	
	^ transactions.! !


!Portfolio methodsFor: 'auxiliars' stamp: 'CD 5/23/2021 18:04:11'!
addAncestorsTo: anAncestorsCollection

	parents 
		ifEmpty: [ anAncestorsCollection add: self ] 
		ifNotEmpty: [ parents do: [ :parent | parent addAncestorsTo: anAncestorsCollection ]].! !

!Portfolio methodsFor: 'auxiliars' stamp: 'CD 5/24/2021 07:52:57'!
addAsParent: account

	parents add: account.! !

!Portfolio methodsFor: 'auxiliars' stamp: 'CD 5/23/2021 18:02:38'!
ancestors

	| ancestors |
	
	ancestors := OrderedCollection new.
	self addAncestorsTo: ancestors.
	
	^ ancestors.! !

!Portfolio methodsFor: 'auxiliars' stamp: 'CD 5/23/2021 17:59:10'!
anyAncestorHas: account

	^ self ancestors anySatisfy: [ :anAncestor | anAncestor has: account].! !

!Portfolio methodsFor: 'auxiliars' stamp: 'CD 5/24/2021 07:55:46'!
canAddAccount: account

	(self anyAncestorHas: account) ifTrue: [self error: Portfolio errorMessageAlreadyAddedAccount ].! !

!Portfolio methodsFor: 'auxiliars' stamp: 'CD 5/24/2021 07:46:34'!
has: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :account | (account has: anAccount) or: [anAccount has: account]]].! !


!Portfolio methodsFor: 'balance' stamp: 'CD 5/18/2021 18:48:37'!
balance

	^ accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ].! !


!Portfolio methodsFor: 'accept-visitor' stamp: 'CD 6/2/2021 19:02:05'!
visitTransactionsWith: anAccountVisitor

	accounts do: [ :anAccount | anAccount visitTransactionsWith: anAccountVisitor].

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'initializers' stamp: 'CD 5/18/2021 19:10:12'!
with: account

	^ Portfolio new add: account.! !

!Portfolio class methodsFor: 'initializers' stamp: 'CD 5/18/2021 19:13:47'!
with: anAccount with: anotherAccount

	^ (self new 
		add: anAccount)
		add: anotherAccount.! !


!Portfolio class methodsFor: 'error-messages' stamp: 'CD 5/20/2021 20:41:59'!
errorMessageAlreadyAddedAccount

	^ 'Cannot add already existing account on this portfolio'.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'CD 5/19/2021 20:24:12'!
addAllTransactionsTo: transactionsCollection

	transactionsCollection addAll: transactions.! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'CD 5/17/2021 21:16:23'!
balance
	
	^ transactions inject: 0 into: [:temporalBalance :transaction | transaction updateBalance: temporalBalance]. 
! !


!ReceptiveAccount methodsFor: 'registration' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'auxiliars' stamp: 'CD 5/24/2021 07:53:11'!
addAsParent: account

	! !

!ReceptiveAccount methodsFor: 'auxiliars' stamp: 'CD 5/23/2021 18:06:33'!
has: anAccount

	^ self = anAccount.! !


!ReceptiveAccount methodsFor: 'accept-visitor' stamp: 'CD 6/2/2021 19:01:43'!
visitTransactionsWith: anAccountVisitor

	transactions do: [ :aTransaction | aTransaction visitedBy: anAccountVisitor].! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'CD 6/1/2021 09:22:13'!
value 

	^ self subclassResponsibility.! !


!AccountTransaction methodsFor: 'balance' stamp: 'CD 5/17/2021 21:16:40'!
updateBalance: aBalance

	^ self subclassResponsibility. ! !


!AccountTransaction methodsFor: 'accept-visitor' stamp: 'CD 6/2/2021 02:18:59'!
visitedBy: anAccountVisitor

	^ self subclassResponsibility.! !

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


!Deposit methodsFor: 'balance' stamp: 'CD 5/17/2021 21:18:13'!
updateBalance: aBalance

	^ aBalance + value.! !


!Deposit methodsFor: 'accept-visitor' stamp: 'CD 6/2/2021 02:19:21'!
visitedBy: anAccountVisitor

	^ anAccountVisitor visitDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferEnd category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #TransferEnd
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferEnd methodsFor: 'initializers' stamp: 'CD 5/29/2021 16:30:43'!
with: aTransfer

	transfer := aTransfer.! !


!TransferEnd methodsFor: 'balance' stamp: 'CD 6/1/2021 08:43:49'!
updateBalance: aBalance

	^ self subclassResponsibility.! !


!TransferEnd methodsFor: 'accept-visitor' stamp: 'CD 6/2/2021 02:19:39'!
visitedBy: anAccountVisitor

	^ self subclassResponsibility.! !


!TransferEnd methodsFor: 'value' stamp: 'CD 6/1/2021 09:27:34'!
value

	^ transfer amount.! !


!TransferEnd methodsFor: 'transfer' stamp: 'CD 6/2/2021 19:24:47'!
transfer

	^ transfer.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferEnd class' category: 'Portfolio-Ejercicio'!
TransferEnd class
	instanceVariableNames: ''!

!TransferEnd class methodsFor: 'as yet unclassified' stamp: 'CD 5/29/2021 16:30:13'!
with: transfer

	^ self new with: transfer.! !


!classDefinition: #DepositTransfer category: 'Portfolio-Ejercicio'!
TransferEnd subclass: #DepositTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!DepositTransfer methodsFor: 'balance' stamp: 'CD 5/29/2021 16:33:09'!
updateBalance: aBalance

	^ aBalance + transfer amount.! !


!DepositTransfer methodsFor: 'accept-visitor' stamp: 'CD 6/2/2021 02:19:48'!
visitedBy: anAccountVisitor

	^ anAccountVisitor visitDepositTransfer: self.! !


!DepositTransfer methodsFor: 'withdraw-end' stamp: 'CD 6/2/2021 19:16:43'!
withdrawEnd

	^ transfer withdrawEnd.! !


!classDefinition: #WithdrawTransfer category: 'Portfolio-Ejercicio'!
TransferEnd subclass: #WithdrawTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!WithdrawTransfer methodsFor: 'balance' stamp: 'CD 5/29/2021 16:33:27'!
updateBalance: aBalance

	^ aBalance - transfer amount.! !


!WithdrawTransfer methodsFor: 'accept-visitor' stamp: 'CD 6/2/2021 02:19:57'!
visitedBy: anAccountVisitor

	^ anAccountVisitor visitWithdrawTransfer: self.! !


!WithdrawTransfer methodsFor: 'deposit-end' stamp: 'CD 6/2/2021 19:15:52'!
depositEnd

	^ transfer depositEnd.! !


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


!Withdraw methodsFor: 'balance' stamp: 'CD 5/17/2021 21:18:08'!
updateBalance: aBalance

	^ aBalance - value.! !


!Withdraw methodsFor: 'accept-visitor' stamp: 'CD 6/2/2021 02:20:10'!
visitedBy: anAccountVisitor

	^ anAccountVisitor visitWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #AccountVisitor category: 'Portfolio-Ejercicio'!
Object subclass: #AccountVisitor
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountVisitor methodsFor: 'initializers' stamp: 'CD 6/2/2021 02:13:59'!
over: anAccount

	account := anAccount.

	! !


!AccountVisitor methodsFor: 'visit-transaction' stamp: 'CD 6/2/2021 02:16:42'!
visitDeposit: aDeposit

	^ self subclassResponsibility.! !

!AccountVisitor methodsFor: 'visit-transaction' stamp: 'CD 6/2/2021 02:17:21'!
visitDepositTransfer: aDepositTransfer

	^ self subclassResponsibility.
! !

!AccountVisitor methodsFor: 'visit-transaction' stamp: 'CD 6/2/2021 02:16:58'!
visitWithdraw: aWithdraw

	^ self subclassResponsibility.! !

!AccountVisitor methodsFor: 'visit-transaction' stamp: 'CD 6/2/2021 02:17:38'!
visitWithdrawTransfer: aWithdrawTransfer

	^ self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountVisitor class' category: 'Portfolio-Ejercicio'!
AccountVisitor class
	instanceVariableNames: ''!

!AccountVisitor class methodsFor: 'initializers' stamp: 'CD 6/2/2021 02:15:17'!
over: anAccount

	^ self new over: anAccount.! !


!classDefinition: #AccountSummary category: 'Portfolio-Ejercicio'!
AccountVisitor subclass: #AccountSummary
	instanceVariableNames: 'lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountSummary methodsFor: 'initializers' stamp: 'CD 6/1/2021 17:10:20'!
over: anAccount

	account := anAccount.! !


!AccountSummary methodsFor: 'summary' stamp: 'CD 6/2/2021 19:03:09'!
lines

	lines := OrderedCollection new.	
	account visitTransactionsWith: self.
	lines add: ('Balance = ', account balance printString).
	
	^lines

	! !


!AccountSummary methodsFor: 'visit-transaction' stamp: 'CD 6/2/2021 01:43:42'!
visitDeposit: aDeposit

	lines add: ('Depósito por ', aDeposit value printString).! !

!AccountSummary methodsFor: 'visit-transaction' stamp: 'CD 6/2/2021 01:51:24'!
visitDepositTransfer: aDepositTransfer

	lines add: ('Entrada por transferencia de ', aDepositTransfer value printString).
! !

!AccountSummary methodsFor: 'visit-transaction' stamp: 'CD 6/2/2021 01:45:56'!
visitWithdraw: aWithdraw

	lines add: ('Extracción por ', aWithdraw value printString).! !

!AccountSummary methodsFor: 'visit-transaction' stamp: 'CD 6/2/2021 01:52:54'!
visitWithdrawTransfer: aWithdrawTransfer

	lines add: ('Salida por transferencia de ', aWithdrawTransfer value printString).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio-Ejercicio'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'initializers' stamp: 'CD 6/1/2021 17:03:50'!
over: anAccount

	^ self new over: anAccount.! !


!classDefinition: #TransferNet category: 'Portfolio-Ejercicio'!
AccountVisitor subclass: #TransferNet
	instanceVariableNames: 'transferNetValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferNet methodsFor: 'value' stamp: 'CD 6/2/2021 19:03:01'!
value

	transferNetValue := 0.
	account visitTransactionsWith: self.
	
	^ transferNetValue.! !


!TransferNet methodsFor: 'visit-transaction' stamp: 'CD 6/1/2021 08:49:09'!
visitDeposit: aDeposit

	! !

!TransferNet methodsFor: 'visit-transaction' stamp: 'CD 6/1/2021 09:24:36'!
visitDepositTransfer: aDepositTransfer

	transferNetValue := transferNetValue + (aDepositTransfer value).! !

!TransferNet methodsFor: 'visit-transaction' stamp: 'CD 6/1/2021 08:49:16'!
visitWithdraw: aWithdraw
! !

!TransferNet methodsFor: 'visit-transaction' stamp: 'CD 6/1/2021 09:53:09'!
visitWithdrawTransfer: aWithdrawTransfer

	transferNetValue := transferNetValue - aWithdrawTransfer value.! !


!TransferNet methodsFor: 'initializers' stamp: 'CD 6/1/2021 09:07:00'!
over: anAccount

	account := anAccount.

	! !


!classDefinition: #Transfer category: 'Portfolio-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'amount depositEnd withdrawEnd'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Transfer methodsFor: 'initializers' stamp: 'CD 5/29/2021 16:21:33'!
with: anAmount

	amount := anAmount.
	withdrawEnd := WithdrawTransfer with: self.
	depositEnd := DepositTransfer with: self! !


!Transfer methodsFor: 'transfer-legs' stamp: 'CD 5/29/2021 16:37:51'!
depositEnd

	^ depositEnd.! !

!Transfer methodsFor: 'transfer-legs' stamp: 'CD 5/29/2021 16:38:06'!
withdrawEnd

	^ withdrawEnd.! !


!Transfer methodsFor: 'amount' stamp: 'CD 5/29/2021 16:38:35'!
amount

	^ amount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'initializers' stamp: 'CD 6/2/2021 19:12:02'!
from: sourceAccount to: destinationAccount withValue: value

	| transfer |
	transfer := self with: value.
	
	sourceAccount register: transfer withdrawEnd.
	destinationAccount register: transfer depositEnd.
	
	^ transfer.
! !

!Transfer class methodsFor: 'initializers' stamp: 'CD 5/29/2021 16:38:54'!
with: amount

	^ self new with: amount.! !
