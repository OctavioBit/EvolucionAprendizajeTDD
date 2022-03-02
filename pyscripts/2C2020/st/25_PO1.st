!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'balance' stamp: 'D S 11/5/2020 20:26:58'!
test02BalanceReturnTotalBalanceOfAllAccountsInPortfolio
	|aPortfolio anAccount anAccount2|
	
	aPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	anAccount2 := ReceptiveAccount new.
	Deposit register: 500 on: anAccount.
	Deposit register: 200 on: anAccount2.
	aPortfolio addAccount: anAccount.
	aPortfolio addAccount: anAccount2.
	
	self assert: 700 equals: aPortfolio balance. 
	! !

!PortfolioTest methodsFor: 'balance' stamp: 'D S 11/8/2020 17:08:19'!
test12WithdrawingFromAccountAffectPortfoliosWhoHasIncludedTheAccount
	|aPortfolio aPortfolio2 anAccount anAccount2|
	
	aPortfolio := Portfolio new.
	aPortfolio2 := Portfolio new.
	anAccount := ReceptiveAccount new.
	anAccount2 := ReceptiveAccount new.
	Deposit register: 500 on: anAccount.
	Deposit register: 200 on: anAccount2.
	aPortfolio addAccount: anAccount.
	aPortfolio2 addAccount: anAccount2.
	aPortfolio addPortfolio: aPortfolio2.
	Withdraw register: 100 on: anAccount2.
	
	self assert: 600 equals: aPortfolio balance. 
	! !


!PortfolioTest methodsFor: 'transaction' stamp: 'D S 11/5/2020 20:27:06'!
test03HasRegisterFoundTransactionCorrectly
	|aPortfolio anAccount anDeposit|
	
	aPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	anDeposit := Deposit register: 500 on: anAccount.
	aPortfolio addAccount: anAccount.
	
	self assert: (aPortfolio hasRegistered: anDeposit). 
	! !

!PortfolioTest methodsFor: 'transaction' stamp: 'D S 11/5/2020 20:27:09'!
test04HasRegisterDontFoundTransactionsOutOfPortfolio
	|aPortfolio anAccount anAccountNotInPortfolio|
	
	aPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	Deposit register: 500 on: anAccount.
	anAccountNotInPortfolio := ReceptiveAccount new.
	aPortfolio addAccount: anAccount.
	
	self deny: (aPortfolio hasRegistered: (Deposit register: 200 on: anAccountNotInPortfolio)). 
	! !

!PortfolioTest methodsFor: 'transaction' stamp: 'D S 11/5/2020 20:27:13'!
test05TransactionsObtainAllTransactionsInAccounts
	|aPortfolio anAccount anSecondAccount|
	
	aPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	anSecondAccount := ReceptiveAccount new.
	aPortfolio addAccount: anAccount.
	aPortfolio addAccount: anSecondAccount.
	
	self assert: (OrderedCollection with: (Deposit register: 500 on: anAccount) with: (Deposit register: 200 on: anSecondAccount)) equals: aPortfolio transactions 
	! !


!PortfolioTest methodsFor: 'initialize' stamp: 'D S 11/2/2020 20:50:36'!
test01initializeWithTotalBalance0
	|aPortfolio|
	
	aPortfolio := Portfolio new.
	self assert: 0 equals: aPortfolio balance. 
	! !


!PortfolioTest methodsFor: 'adding' stamp: 'D S 11/5/2020 20:27:18'!
test06RaiseErrorWhenTryingAddPortfolioToItself
	|aPortfolio |
	
	aPortfolio := Portfolio new.
	
	^[aPortfolio addPortfolio: aPortfolio.
	self fail] 
		on: Error
		do: [:anError | self assert: anError messageText = Portfolio errorDescriptionCantAddItself.] 
	! !

!PortfolioTest methodsFor: 'adding' stamp: 'D S 11/5/2020 20:27:26'!
test07RaiseErrorWhenTryingToAddAPortfolioWithAnAccountInBoth
	|aPortfolio aPortfolio2 anAccount|
	
	aPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	aPortfolio2 := Portfolio new.
	aPortfolio2 addAccount: anAccount.
	aPortfolio addAccount: anAccount.
	^[aPortfolio addPortfolio: aPortfolio2.
	self fail] 
		on: Error
		do: [:anError | self assert: anError messageText = Portfolio errorDescriptionAccountInBothPortfolios.] 
	! !

!PortfolioTest methodsFor: 'adding' stamp: 'D S 11/5/2020 20:27:32'!
test08RaiseErrorWhenTryingAddPortfolioAlreadyAdded
	|aPortfolio aPortfolio2|
	
	aPortfolio := Portfolio new.
	aPortfolio2 := Portfolio new.
	aPortfolio addPortfolio: aPortfolio2.
	^[aPortfolio addPortfolio: aPortfolio2.
	self fail] 
		on: Error
		do: [:anError | self assert: anError messageText = Portfolio errorDescriptionPortfolioAlreadyAdded.] 
	! !

!PortfolioTest methodsFor: 'adding' stamp: 'D S 11/5/2020 20:27:43'!
test09RaiseErrorWhenTryingToAddAPortfolioWithAPortfolioInBoth
	|aPortfolio aPortfolio2 aPortfolio3|
	
	aPortfolio := Portfolio new.
	aPortfolio2 := Portfolio new.
	aPortfolio3 := Portfolio new.
	aPortfolio2 addPortfolio: aPortfolio3.
	aPortfolio addPortfolio: aPortfolio3.
	^[aPortfolio addPortfolio: aPortfolio2.
	self fail] 
		on: Error
		do: [:anError | self assert: anError messageText = Portfolio errorDescriptionPortfolioInBothPortfolio.] 
	! !

!PortfolioTest methodsFor: 'adding' stamp: 'D S 11/5/2020 21:33:50'!
test10RaiseErrorWhenTryingToAddAnAccountInAPortfolioAlreadyAdded
	|aPortfolio aPortfolio2 anAccount|
	
	aPortfolio := Portfolio new.
	aPortfolio2 := Portfolio new.
	anAccount := ReceptiveAccount new.
	aPortfolio2 addAccount: anAccount.
	aPortfolio addPortfolio: aPortfolio2.
	
	^[aPortfolio addAccount: anAccount.
	self fail] 
		on: Error
		do: [:anError | self assert: anError messageText = Portfolio errorDescriptionAccountAlreadyInPortfolio.] 
	! !

!PortfolioTest methodsFor: 'adding' stamp: 'D S 11/8/2020 16:48:08'!
test11AddingAPortfolioIncreaseBalanceEqualToPortfolioBalance
	|aPortfolio aPortfolio2 anAccount anAccount2|
	
	aPortfolio := Portfolio new.
	aPortfolio2 := Portfolio new.
	anAccount := ReceptiveAccount new.
	anAccount2 := ReceptiveAccount new.
	Deposit register: 500 on: anAccount.
	Deposit register: 200 on: anAccount2.
	aPortfolio addAccount: anAccount.
	aPortfolio2 addAccount: anAccount2.
	aPortfolio addPortfolio: aPortfolio2.
	
	self assert: 700 equals: aPortfolio balance. 
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:15'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
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


!Deposit methodsFor: 'value' stamp: 'D S 11/2/2020 20:30:17'!
netValue

	^ value! !

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


!Withdraw methodsFor: 'value' stamp: 'D S 11/2/2020 20:30:11'!
netValue

	^ value * (-1)! !

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


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios transactionsInAccountsInsidePortfolio insidePortfolios totalBalance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'accessing --Private--' stamp: 'D S 11/5/2020 21:50:52'!
allAccounts

	^self obtain: accounts forEachPortfolioAdd: [:aPortfolio | aPortfolio allAccounts ].! !

!Portfolio methodsFor: 'accessing --Private--' stamp: 'D S 11/5/2020 21:50:40'!
allPortfolios

	^self obtain: portfolios forEachPortfolioAdd: [:aPortfolio | aPortfolio allPortfolios].! !

!Portfolio methodsFor: 'accessing --Private--' stamp: 'D S 11/8/2020 16:54:25'!
obtain: aCollection forEachPortfolioAdd: aClosure

	|items|
	items := OrderedCollection new.
	items addAll: aCollection.
	portfolios do: [:anPortfolio | items addAll: (aClosure value: anPortfolio)].
	^items! !


!Portfolio methodsFor: 'accessing' stamp: 'D S 11/8/2020 16:38:42'!
balance
	
	^totalBalance! !

!Portfolio methodsFor: 'accessing' stamp: 'D S 11/5/2020 22:28:08'!
hasRegistered: anTransaction

	^transactionsInAccountsInsidePortfolio includes: anTransaction.! !

!Portfolio methodsFor: 'accessing' stamp: 'D S 11/5/2020 22:28:08'!
transactions

	^transactionsInAccountsInsidePortfolio ! !


!Portfolio methodsFor: 'testing --Private--' stamp: 'D S 11/5/2020 20:36:34'!
checkDoesntHaveAnAccountIncludedInPortfolio: anPortfolio

	^ (self allAccounts) do: [:anAccount | ((anPortfolio allAccounts) includes: anAccount) ifTrue:[self error: self class errorDescriptionAccountInBothPortfolios ]]! !

!Portfolio methodsFor: 'testing --Private--' stamp: 'D S 11/5/2020 20:36:55'!
checkDoesntHaveAnPortfolioIncludedInPortfolio: anPortfolio

	^ (self allPortfolios) do: [:aPortfolio | ((anPortfolio allPortfolios) includes: aPortfolio) ifTrue:[self error: self class errorDescriptionPortfolioInBothPortfolio ]]! !

!Portfolio methodsFor: 'testing --Private--' stamp: 'D S 11/5/2020 20:34:59'!
checkNotSamePortfolios: anPortfolio

	^ (self == anPortfolio) ifTrue:[self error: self class errorDescriptionCantAddItself]! !

!Portfolio methodsFor: 'testing --Private--' stamp: 'D S 11/5/2020 21:00:06'!
checkPortfolioDontHaveTheAccount: anAccount

	^ ((self allAccounts) includes: anAccount) ifTrue:[self error: self class errorDescriptionAccountAlreadyInPortfolio]! !

!Portfolio methodsFor: 'testing --Private--' stamp: 'D S 11/5/2020 20:35:32'!
checkPortfolioDontHaveThePortfolio: anPortfolio

	^ (portfolios includes: anPortfolio) ifTrue: [self error: self class errorDescriptionPortfolioAlreadyAdded]! !


!Portfolio methodsFor: 'adding' stamp: 'D S 11/8/2020 16:55:40'!
addAccount: anAccount

	self checkPortfolioDontHaveTheAccount: anAccount.
	accounts add: anAccount.
	anAccount addIncludedPortfolio: self.
	transactionsInAccountsInsidePortfolio addAll: (anAccount transactions).
	totalBalance := totalBalance + anAccount balance.! !

!Portfolio methodsFor: 'adding' stamp: 'D S 11/8/2020 17:06:08'!
addPortfolio: anPortfolio

	self checkNotSamePortfolios: anPortfolio.
	self checkDoesntHaveAnPortfolioIncludedInPortfolio: anPortfolio.	
	self checkDoesntHaveAnAccountIncludedInPortfolio: anPortfolio.
	self checkPortfolioDontHaveThePortfolio: anPortfolio.
	portfolios add: anPortfolio.
	transactionsInAccountsInsidePortfolio addAll: anPortfolio transactions.
	totalBalance := totalBalance + anPortfolio balance.
	anPortfolio addIncludedIn: self.! !


!Portfolio methodsFor: 'initialize' stamp: 'D S 11/5/2020 22:31:12'!
initialize
	
	accounts := OrderedCollection new.
	portfolios := OrderedCollection new.
	transactionsInAccountsInsidePortfolio := OrderedCollection new.
	insidePortfolios := OrderedCollection new.
	totalBalance := 0! !


!Portfolio methodsFor: 'adding --Private--' stamp: 'D S 11/8/2020 17:06:40'!
addIncludedIn: aPortfolio

	insidePortfolios add: aPortfolio! !

!Portfolio methodsFor: 'adding --Private--' stamp: 'D S 11/8/2020 17:05:15'!
addNetValueToBalance: aNetValue

	totalBalance := totalBalance + aNetValue.
	insidePortfolios do: [:aPortfolio | aPortfolio addNetValueToBalance: aNetValue].! !

!Portfolio methodsFor: 'adding --Private--' stamp: 'D S 11/5/2020 22:28:08'!
addTransaction: aTransaction

	transactionsInAccountsInsidePortfolio add: aTransaction.
	insidePortfolios do: [:aPortfolio| aPortfolio addTransaction: aTransaction]

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'D S 11/5/2020 20:47:41'!
errorDescriptionAccountAlreadyInPortfolio

	^'The account already in portfolio'.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'D S 11/5/2020 18:57:50'!
errorDescriptionAccountInBothPortfolios

	^'Unable to add portfolio: anAccount is in both'.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'D S 11/5/2020 18:36:23'!
errorDescriptionCantAddItself

	^'You cant add the portfolio to itself'.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'D S 11/5/2020 19:21:59'!
errorDescriptionPortfolioAlreadyAdded

	^'The portfolio has been already added'.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'D S 11/5/2020 19:41:55'!
errorDescriptionPortfolioInBothPortfolio

	^'Unable to add portfolio: a Portfolio is in both'.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions includedInPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'D S 11/5/2020 22:27:22'!
initialize

	transactions := OrderedCollection new.
	includedInPortfolios := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'D S 11/5/2020 22:33:19'!
register: aTransaction

	includedInPortfolios do: [:aPortfolio | aPortfolio addTransaction: aTransaction.
								aPortfolio addNetValueToBalance: aTransaction netValue].
	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'D S 11/2/2020 20:29:56'!
balance

	^transactions sum: [ :aTransaction | aTransaction netValue] 
	ifEmpty: [ 0 ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'D S 11/5/2020 20:22:59'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
	! !


!ReceptiveAccount methodsFor: 'adding --Private--' stamp: 'D S 11/8/2020 16:55:21'!
addIncludedPortfolio: aPortfolio

	includedInPortfolios add: aPortfolio! !
