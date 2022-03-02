!classDefinition: #AccountSummaryGeneratorTest category: #'Portfolio-Solucion'!
TestCase subclass: #AccountSummaryGeneratorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryGeneratorTest methodsFor: 'receptive account' stamp: 'ja 11/14/2020 21:16:50'!
test01AccountSummaryForEmptyReceptiveAccount

	| aReceptiveAccount anAccountSummaryGenerator aSummary |
	
	aReceptiveAccount _ ReceptiveAccount new.
	anAccountSummaryGenerator _ AccountSummaryGenerator for: aReceptiveAccount.
	
	aSummary _ OrderedCollection with: 'Balance = 0'.
	
	self assert: aSummary equals: anAccountSummaryGenerator generate.! !

!AccountSummaryGeneratorTest methodsFor: 'receptive account' stamp: 'ja 11/14/2020 21:15:10'!
test02AccountSummaryForReceptiveAccountWithADeposit

	| aReceptiveAccount anAccountSummaryGenerator aSummary |
	
	aReceptiveAccount _ ReceptiveAccount new.
	anAccountSummaryGenerator _ AccountSummaryGenerator for: aReceptiveAccount.
	
	Deposit register: 100 on: aReceptiveAccount .
	
	aSummary _ OrderedCollection with: 'Deposito por 100' with: 'Balance = 100'.
	
	self assert: aSummary equals: anAccountSummaryGenerator generate.! !

!AccountSummaryGeneratorTest methodsFor: 'receptive account' stamp: 'ja 11/15/2020 13:29:33'!
test03AccountSummaryForReceptiveAccountWithADepositAndWithdraw

	| aReceptiveAccount anAccountSummaryGenerator aSummary |
	
	aReceptiveAccount _ ReceptiveAccount new.
	anAccountSummaryGenerator _ AccountSummaryGenerator for: aReceptiveAccount.
	
	Deposit register: 100 on: aReceptiveAccount .
	Withdraw register: 50 on: aReceptiveAccount .
	
	aSummary _ OrderedCollection with: 'Deposito por 100'  with: 'Extracción por 50' with: 'Balance = 50'.
	
	self assert: aSummary equals: anAccountSummaryGenerator generate.! !

!AccountSummaryGeneratorTest methodsFor: 'receptive account' stamp: 'ja 11/15/2020 13:37:10'!
test04AccountSummaryForReceptiveAccountWithATransfer

	| aSourceReceptiveAccount aDestinyReceptiveAccount anAccountSummaryGeneratorSource anAccountSummaryGeneratorDestiny aSummarySource aSummaryDestiny |
	
	aSourceReceptiveAccount _ ReceptiveAccount new.
	aDestinyReceptiveAccount _ ReceptiveAccount new.
	anAccountSummaryGeneratorSource _ AccountSummaryGenerator for: aSourceReceptiveAccount.
	anAccountSummaryGeneratorDestiny _ AccountSummaryGenerator for: aDestinyReceptiveAccount .
	
	Transfer from: aSourceReceptiveAccount to: aDestinyReceptiveAccount anAmountOf: 100.
	
	aSummarySource _ OrderedCollection with: 'Salida por transferencia de 100'  with: 'Balance = -100'.
	aSummaryDestiny _ OrderedCollection with: 'Entrada por transferencia de 100'  with: 'Balance = 100'.
	
	self assert: aSummarySource equals: anAccountSummaryGeneratorSource generate.
	self assert: aSummaryDestiny equals: anAccountSummaryGeneratorDestiny generate.! !

!AccountSummaryGeneratorTest methodsFor: 'receptive account' stamp: 'ja 11/15/2020 13:49:05'!
test05AccountSummaryForReceptiveAccountWithMultipleTransactions

	| aSourceReceptiveAccount aDestinyReceptiveAccount anAccountSummaryGeneratorSource anAccountSummaryGeneratorDestiny aSummarySource aSummaryDestiny |
	
	aSourceReceptiveAccount _ ReceptiveAccount new.
	aDestinyReceptiveAccount _ ReceptiveAccount new.
	anAccountSummaryGeneratorSource _ AccountSummaryGenerator for: aSourceReceptiveAccount.
	anAccountSummaryGeneratorDestiny _ AccountSummaryGenerator for: aDestinyReceptiveAccount .
	
	Deposit register: 100 on: aSourceReceptiveAccount .
	Withdraw register: 50 on: aSourceReceptiveAccount .
	
	Deposit register: 100 on: aDestinyReceptiveAccount .
	Withdraw register: 50 on: aDestinyReceptiveAccount .
	
	Transfer from: aSourceReceptiveAccount to: aDestinyReceptiveAccount anAmountOf: 50.
	
	aSummarySource _ OrderedCollection with: 'Deposito por 100'  with: 'Extracción por 50'  with: 'Salida por transferencia de 50'  with: 'Balance = 0'.
	aSummaryDestiny _ OrderedCollection with: 'Deposito por 100'  with: 'Extracción por 50'  with: 'Entrada por transferencia de 50'  with: 'Balance = 100'.
	
	self assert: aSummarySource equals: anAccountSummaryGeneratorSource generate.
	self assert: aSummaryDestiny equals: anAccountSummaryGeneratorDestiny generate.
	
	! !


!AccountSummaryGeneratorTest methodsFor: 'portfolio' stamp: 'ja 11/15/2020 14:34:42'!
test06AccountSummaryForEmptyPortfolio

	| aPortfolio anAccountSummaryGenerator aSummary|
	
	aPortfolio _ Portfolio new.
	anAccountSummaryGenerator _ AccountSummaryGenerator for: aPortfolio.
	
	aSummary _ OrderedCollection with: 'Balance = 0'.
	
	self assert: aSummary equals: anAccountSummaryGenerator generate.! !

!AccountSummaryGeneratorTest methodsFor: 'portfolio' stamp: 'ja 11/15/2020 16:06:01'!
test07AccountSummaryForPorfolioWithALevel

	| anAccountSummaryGenerator aSummary account simplePortfolio otherAccount |

	account _ ReceptiveAccount new.
	Deposit register: 100 on: account.
	otherAccount _ ReceptiveAccount new.
	Deposit register: 200 on: otherAccount .
	simplePortfolio _ Portfolio with: account with: otherAccount .
	
	anAccountSummaryGenerator _ AccountSummaryGenerator for: simplePortfolio .
	
	aSummary _ OrderedCollection with: 'Deposito por 100' with: 'Balance = 100' with: 'Deposito por 200' with: 'Balance = 200' with: 'Balance = 300'.
	
	self assert: aSummary equals: anAccountSummaryGenerator generate.! !

!AccountSummaryGeneratorTest methodsFor: 'portfolio' stamp: 'ja 11/15/2020 16:18:29'!
test08AccountSummaryForPorfolioWithMoreThanOneLevel

	| anAccountSummaryGenerator aSummary account portfolioRoot portfolioChild otherAccount |

	account _ ReceptiveAccount new.
	Deposit register: 100 on: account.
	otherAccount _ ReceptiveAccount new.
	Deposit register: 200 on: otherAccount .
	portfolioChild _ Portfolio with: otherAccount .
	portfolioRoot _ Portfolio with: account with: portfolioChild .
	
	anAccountSummaryGenerator _ AccountSummaryGenerator for: portfolioRoot .
	
	aSummary _ OrderedCollection with: 'Deposito por 100' with: 'Balance = 100' with: 'Deposito por 200' with: 'Balance = 200' with: 'Balance = 200' with: 'Balance = 300'.
	
	self assert: aSummary equals: anAccountSummaryGenerator generate.! !


!classDefinition: #PortfolioTest category: #'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/9/2020 06:00:12'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/9/2020 06:02:30'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: account.
		
	self assert: 1 equals: account transactions size .
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #TransferNetGeneratorTest category: #'Portfolio-Solucion'!
TestCase subclass: #TransferNetGeneratorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetGeneratorTest methodsFor: 'receptive account' stamp: 'eb 11/15/2020 20:09:40'!
test01TransferNetForEmptyReceptiveAccountIsZero
	| aReceptiveAccount aTransferNetGenerator |
	aReceptiveAccount _ ReceptiveAccount new.
	aTransferNetGenerator _ TransferNetGenerator for: aReceptiveAccount.
	self assert: 0 equals: aTransferNetGenerator generate.
	! !

!TransferNetGeneratorTest methodsFor: 'receptive account' stamp: 'eb 11/15/2020 20:12:13'!
test02TransferNetForReceptiveAccountWithOnlyDepositsIsZero

	| aReceptiveAccount aTransferNetGenerator |
	
	aReceptiveAccount _ ReceptiveAccount new.
	
	Deposit register: 100 on: aReceptiveAccount.
	
	aTransferNetGenerator _ TransferNetGenerator for: aReceptiveAccount.
	
	self assert: 0 equals: aTransferNetGenerator generate.
	! !

!TransferNetGeneratorTest methodsFor: 'receptive account' stamp: 'eb 11/15/2020 20:13:37'!
test03TransferNetForReceptiveAccountWithOnlyWithdrawsIsZero

	| aReceptiveAccount aTransferNetGenerator |
	
	aReceptiveAccount _ ReceptiveAccount new.
	
	Withdraw register: 100 on: aReceptiveAccount.
	
	aTransferNetGenerator _ TransferNetGenerator for: aReceptiveAccount.
	
	self assert: 0 equals: aTransferNetGenerator generate.
	! !

!TransferNetGeneratorTest methodsFor: 'receptive account' stamp: 'eb 11/15/2020 20:28:07'!
test04OneTransferAffectsTransferNet

	| aSourceAccount aDestinyAccount |
	
	aSourceAccount _ ReceptiveAccount new.
	
	aDestinyAccount _ ReceptiveAccount new.
	
	Transfer from: aSourceAccount to: aDestinyAccount anAmountOf: 100.
		
	self assert: -100 equals: (TransferNetGenerator for: aSourceAccount) generate.
	
	self assert: 100 equals: (TransferNetGenerator for: aDestinyAccount) generate.! !

!TransferNetGeneratorTest methodsFor: 'receptive account' stamp: 'eb 11/15/2020 20:28:55'!
test05MultipleTransfersAffectsTransferNet

	| aSourceAccount aDestinyAccount |
	
	aSourceAccount _ ReceptiveAccount new.
	
	aDestinyAccount _ ReceptiveAccount new.
	
	Transfer from: aSourceAccount to: aDestinyAccount anAmountOf: 100.
		
	Transfer from: aSourceAccount to: aDestinyAccount anAmountOf: 100.
	
	self assert: -200 equals: (TransferNetGenerator for: aSourceAccount) generate.
	
	self assert: 200 equals: (TransferNetGenerator for: aDestinyAccount) generate.! !


!TransferNetGeneratorTest methodsFor: 'portfolio' stamp: 'eb 11/15/2020 21:18:48'!
test06TransferNetForEmptyPortfolioIsZero
	self assert: 0 equals: (TransferNetGenerator for: Portfolio new) generate.
	! !

!TransferNetGeneratorTest methodsFor: 'portfolio' stamp: 'eb 11/15/2020 21:22:24'!
test07PortolioWithOneReceptiveAccountHasItsAccountTransferNet
	| aReceptiveAccount aPortfolio |
	
	aReceptiveAccount _ ReceptiveAccount new.
	
	TransferDeposit register: 100 on: aReceptiveAccount .
	aPortfolio _ Portfolio with: aReceptiveAccount.
	self assert: (TransferNetGenerator for: aReceptiveAccount) generate 
		equals: (TransferNetGenerator for: aPortfolio) generate .
	! !

!TransferNetGeneratorTest methodsFor: 'portfolio' stamp: 'eb 11/15/2020 21:21:55'!
test08PortolioWithOnePortfolioHasItsPortfolioTransferNet
	| aReceptiveAccount aChildPortfolio aParentPortfolio |
	
	aReceptiveAccount _ ReceptiveAccount new.
	
	TransferDeposit register: 100 on: aReceptiveAccount .
	aChildPortfolio _ Portfolio with: aReceptiveAccount.
	
	aParentPortfolio _ Portfolio with: aChildPortfolio .
	self assert: (TransferNetGenerator for: aChildPortfolio) generate 
		equals: (TransferNetGenerator for: aParentPortfolio) generate .
	! !

!TransferNetGeneratorTest methodsFor: 'portfolio' stamp: 'eb 11/15/2020 21:22:38'!
test09PortfolioWithManyTransferTransactionsTransferNet
	| aReceptiveAccountForChildPortfolio aReceptiveAccountForParentPortfolio aChildPortfolio aParentPortfolio |
	
	aReceptiveAccountForChildPortfolio _ ReceptiveAccount new.
	aReceptiveAccountForParentPortfolio _ ReceptiveAccount new .
	
	TransferDeposit register: 100 on: aReceptiveAccountForChildPortfolio .
	TransferDeposit register: 100 on: aReceptiveAccountForParentPortfolio .
	
	aChildPortfolio _ Portfolio with: aReceptiveAccountForChildPortfolio.
	aParentPortfolio _ Portfolio with: aChildPortfolio with: aReceptiveAccountForParentPortfolio.
	
	self assert: 200 equals: (TransferNetGenerator for: aParentPortfolio) generate .
	! !


!classDefinition: #TransferTest category: #'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'tests' stamp: 'ja 11/14/2020 16:42:57'!
test01TransferAffectsSourceAndDestinyBalance
	
	| sourceAccount destinyAccount |
	
	sourceAccount _ ReceptiveAccount new .
	
	destinyAccount _ ReceptiveAccount new .
	
	self assert: 0 equals: sourceAccount balance.
	self assert: 0 equals: destinyAccount balance.
	
	Transfer from: sourceAccount to: destinyAccount anAmountOf: 100.
	
	self assert: -100 equals: sourceAccount balance.
	self assert: 100 equals: destinyAccount balance.
! !

!TransferTest methodsFor: 'tests' stamp: 'eb 11/15/2020 21:36:55'!
test02CanNotTransferAnAmountOfZero 
	
	| sourceAccount destinyAccount |
	
	sourceAccount _ ReceptiveAccount new .
	
	destinyAccount _ ReceptiveAccount new .
	
	self should: [Transfer from: sourceAccount to: destinyAccount anAmountOf: 0. self fail] 
		raise: Error
		withMessageText: Transfer canNotTransferAnAmountOfZeroErrorDescription .! !

!TransferTest methodsFor: 'tests' stamp: 'eb 11/15/2020 21:37:02'!
test03CanNotTransferANegativeAmount
	
	| sourceAccount destinyAccount |
	
	sourceAccount _ ReceptiveAccount new .
	
	destinyAccount _ ReceptiveAccount new .
	
	self should: [Transfer from: sourceAccount to: destinyAccount anAmountOf: -100. self fail] 
		raise: Error
		withMessageText: Transfer canNotTransferANegativeAmountErrorDescription .! !

!TransferTest methodsFor: 'tests' stamp: 'ja 11/14/2020 17:38:11'!
test04TransferIsRegisteredIntoInvolvedAccounts
	
	| sourceAccount destinyAccount transfer |
	
	sourceAccount _ ReceptiveAccount new .
	
	destinyAccount _ ReceptiveAccount new .
	
	transfer _ Transfer from: sourceAccount to: destinyAccount anAmountOf: 100.
	
	self assert: sourceAccount transactions includes: transfer withdrawMade. 
	
	self assert: destinyAccount transactions includes: transfer depositMade.
	
	
	! !

!TransferTest methodsFor: 'tests' stamp: 'ja 11/14/2020 18:14:14'!
test05TransferValueIsNotReplicated
	
	| transfer sourceAccount destinyAccount |
	
	sourceAccount _ ReceptiveAccount new .
	
	destinyAccount _ ReceptiveAccount new .
	
	transfer  _ Transfer from: sourceAccount to: destinyAccount anAmountOf: 100.
	
	self assert: -100 equals: sourceAccount balance.
	self assert: 100 equals: destinyAccount balance.
		
	transfer changeValueTo: 10.
	
	self assert: -10 equals: sourceAccount balance.
	self assert: 10 equals: destinyAccount balance.
	! !


!classDefinition: #Account category: #'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'report' stamp: 'ja 11/15/2020 18:41:31'!
generateReportUsing: aReportGenerator

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'report' stamp: 'ja 11/15/2020 18:42:27'!
generateReportUsing: aReportGenerator

	accounts do:[:account | account generateReportUsing: aReportGenerator ].
	
	aReportGenerator generateForPortfolio: self .! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'NR 11/9/2020 06:01:26'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio!!'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'report' stamp: 'ja 11/15/2020 18:43:06'!
generateReportUsing: aReportGenerator
	
	transactions do:[:transaction | transaction generateReportUsing: aReportGenerator ].
	
	aReportGenerator generateForReceptiveAccount: self .
	
	! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'NR 11/9/2020 05:56:36'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions copy! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'ja 11/14/2020 15:30:39'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!classDefinition: #AccountReportGenerator category: #'Portfolio-Solucion'!
Object subclass: #AccountReportGenerator
	instanceVariableNames: 'account report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountReportGenerator methodsFor: 'initialization' stamp: 'ja 11/15/2020 19:18:26'!
initializeFor: anAccount 
	
	account _ anAccount.
	
! !


!AccountReportGenerator methodsFor: 'report generation' stamp: 'ja 11/15/2020 18:53:08'!
generate

	account generateReportUsing: self.

	^ report ! !

!AccountReportGenerator methodsFor: 'report generation' stamp: 'ja 11/15/2020 18:44:30'!
generateForDeposit: aDeposit 
	
	self subclassResponsibility ! !

!AccountReportGenerator methodsFor: 'report generation' stamp: 'ja 11/15/2020 18:44:36'!
generateForPortfolio: aPortfolio

	self subclassResponsibility ! !

!AccountReportGenerator methodsFor: 'report generation' stamp: 'ja 11/15/2020 18:44:43'!
generateForReceptiveAccount: aReceptiveAccount 

	self subclassResponsibility ! !

!AccountReportGenerator methodsFor: 'report generation' stamp: 'eb 11/15/2020 21:24:32'!
generateForTransferDeposit: aTransferDeposit

	self subclassResponsibility ! !

!AccountReportGenerator methodsFor: 'report generation' stamp: 'eb 11/15/2020 21:24:37'!
generateForTransferWithdraw: aTransferWithdraw 

	self subclassResponsibility ! !

!AccountReportGenerator methodsFor: 'report generation' stamp: 'ja 11/15/2020 18:45:08'!
generateForWithdraw: aWithdraw 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReportGenerator class' category: #'Portfolio-Solucion'!
AccountReportGenerator class
	instanceVariableNames: ''!

!AccountReportGenerator class methodsFor: 'instance creation' stamp: 'eb 11/15/2020 21:31:14'!
for: anAccount 

	^ self new initializeFor: anAccount! !


!classDefinition: #AccountSummaryGenerator category: #'Portfolio-Solucion'!
AccountReportGenerator subclass: #AccountSummaryGenerator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryGenerator methodsFor: 'initialization' stamp: 'eb 11/15/2020 19:52:58'!
initializeFor: anAccount 
	super initializeFor: anAccount.	
	report _ OrderedCollection new.
	! !


!AccountSummaryGenerator methodsFor: 'report generation' stamp: 'eb 11/15/2020 19:54:04'!
generateForDeposit: aDeposit  

	report add: 'Deposito por ', aDeposit value asString.! !

!AccountSummaryGenerator methodsFor: 'report generation' stamp: 'ja 11/15/2020 18:46:13'!
generateForPortfolio: aPortfolio 

	report  add: ('Balance = ', aPortfolio balance asString).! !

!AccountSummaryGenerator methodsFor: 'report generation' stamp: 'ja 11/15/2020 18:46:23'!
generateForReceptiveAccount: aReceptiveAccount 

	report  add: ('Balance = ', aReceptiveAccount balance asString).! !

!AccountSummaryGenerator methodsFor: 'report generation' stamp: 'ja 11/15/2020 18:46:35'!
generateForTransferDeposit: aWithdraw 

	report add: 'Entrada por transferencia de ', aWithdraw value asString.! !

!AccountSummaryGenerator methodsFor: 'report generation' stamp: 'ja 11/15/2020 18:46:42'!
generateForTransferWithdraw: aWithdraw 

	report add: 'Salida por transferencia de ', aWithdraw value asString.! !

!AccountSummaryGenerator methodsFor: 'report generation' stamp: 'ja 11/15/2020 18:46:50'!
generateForWithdraw: aWithdraw

	report add: 'Extracción por ', aWithdraw value asString.! !


!classDefinition: #TransferNetGenerator category: #'Portfolio-Solucion'!
AccountReportGenerator subclass: #TransferNetGenerator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetGenerator methodsFor: 'initialization' stamp: 'eb 11/15/2020 19:53:46'!
initializeFor: anAccount 

	super initializeFor: anAccount.	
	
	report _ 0.
! !


!TransferNetGenerator methodsFor: 'report generation' stamp: 'eb 11/15/2020 20:14:44'!
generateForDeposit: aDeposit  

	report _ report + 0 .! !

!TransferNetGenerator methodsFor: 'report generation' stamp: 'eb 11/15/2020 20:30:47'!
generateForPortfolio: aPortfolio 

	report _ report + 0 .! !

!TransferNetGenerator methodsFor: 'report generation' stamp: 'eb 11/15/2020 20:25:53'!
generateForReceptiveAccount: aReceptiveAccount 

	report _ report + 0 .! !

!TransferNetGenerator methodsFor: 'report generation' stamp: 'eb 11/15/2020 20:25:02'!
generateForTransferDeposit: aTransferDeposit

	report _ report + aTransferDeposit value.! !

!TransferNetGenerator methodsFor: 'report generation' stamp: 'eb 11/15/2020 20:24:47'!
generateForTransferWithdraw: aTransferWithdraw

	report _ report - aTransferWithdraw value.! !

!TransferNetGenerator methodsFor: 'report generation' stamp: 'eb 11/15/2020 20:26:27'!
generateForWithdraw: aWithdraw

	report _ report - 0 .! !


!classDefinition: #AccountTransaction category: #'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'report' stamp: 'eb 11/15/2020 21:26:37'!
generateReportUsing: aReportGenerator
	 
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'ja 11/14/2020 18:19:14'!
register: aValueOrTransfer on: account

	| transaction |
	
	transaction := self for: aValueOrTransfer.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'report' stamp: 'ja 11/15/2020 18:49:04'!
generateReportUsing: aReportGenerator

	aReportGenerator generateForDeposit: self.! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferTransaction category: #'Portfolio-Solucion'!
AccountTransaction subclass: #TransferTransaction
	instanceVariableNames: 'relatedTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTransaction methodsFor: 'value' stamp: 'ja 11/14/2020 17:56:29'!
value 

	^ relatedTransfer value! !


!TransferTransaction methodsFor: 'balance' stamp: 'ja 11/14/2020 17:06:54'!
affectBalance: aBalance

	self subclassResponsibility ! !


!TransferTransaction methodsFor: 'initialization' stamp: 'ja 11/14/2020 17:58:06'!
initializeFor: aTransfer

	relatedTransfer _ aTransfer ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTransaction class' category: #'Portfolio-Solucion'!
TransferTransaction class
	instanceVariableNames: ''!

!TransferTransaction class methodsFor: 'as yet unclassified' stamp: 'ja 11/14/2020 18:00:01'!
for: aTransfer

	^ self new initializeFor: aTransfer ! !


!classDefinition: #TransferDeposit category: #'Portfolio-Solucion'!
TransferTransaction subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDeposit methodsFor: 'report' stamp: 'ja 11/15/2020 18:49:33'!
generateReportUsing: aReportGenerator 

	aReportGenerator generateForTransferDeposit: self ! !


!TransferDeposit methodsFor: 'balance' stamp: 'ja 11/14/2020 19:45:00'!
affectBalance: aBalance

	^ aBalance + self value ! !


!classDefinition: #TransferWithdraw category: #'Portfolio-Solucion'!
TransferTransaction subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferWithdraw methodsFor: 'report' stamp: 'ja 11/15/2020 18:49:59'!
generateReportUsing: aReportGenerator 

	aReportGenerator generateForTransferWithdraw: self.! !


!TransferWithdraw methodsFor: 'balance' stamp: 'ja 11/14/2020 19:45:11'!
affectBalance: aBalance

	^ aBalance - self value ! !


!classDefinition: #Withdraw category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'report' stamp: 'ja 11/15/2020 18:50:44'!
generateReportUsing: aReportGenerator 

	aReportGenerator generateForWithdraw: self .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: #'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value depositMade withdrawMade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'eb 11/15/2020 21:30:25'!
initializeFrom: aSourceAccount to: aDestinyAccount anAmountOf: aValueToTransfer 
	depositMade _ TransferDeposit register: self on: aDestinyAccount .
	withdrawMade _ TransferWithdraw register: self on: aSourceAccount .
	value _ aValueToTransfer .! !


!Transfer methodsFor: 'testing' stamp: 'eb 11/15/2020 21:39:07'!
changeValueTo: aNewValue
	" Ya que no existe un mapeo con la realidad entre este mensaje y una verdadera transferencia bancaria
	afirmamos que éste no hace a la esencia de Transfer pero lo incorporamos para poder testear que el valor
	de las transferencias no está replicado "
	value _ aNewValue 

	! !


!Transfer methodsFor: 'accesing' stamp: 'eb 11/15/2020 21:39:38'!
depositMade
	^ depositMade .! !

!Transfer methodsFor: 'accesing' stamp: 'eb 11/15/2020 21:39:49'!
value 
	^ value .! !

!Transfer methodsFor: 'accesing' stamp: 'eb 11/15/2020 21:39:43'!
withdrawMade
	^withdrawMade .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'error descriptions' stamp: 'ja 11/14/2020 16:54:04'!
canNotTransferANegativeAmountErrorDescription
	
	^ ' Can not transfer a negative amount '! !

!Transfer class methodsFor: 'error descriptions' stamp: 'ja 11/14/2020 16:48:16'!
canNotTransferAnAmountOfZeroErrorDescription
	
	^ 'Can not transfer an amount of zero'! !


!Transfer class methodsFor: 'instance creation' stamp: 'ja 11/14/2020 16:55:01'!
from: aSourceAccount to: aDestinyAccount anAmountOf: valueToTransfer 

	(valueToTransfer = 0) ifTrue: [ self error: self canNotTransferAnAmountOfZeroErrorDescription ].
	(valueToTransfer  < 0) ifTrue: [ self error: self canNotTransferANegativeAmountErrorDescription ].
		
	^ Transfer new initializeFrom: aSourceAccount to: aDestinyAccount anAmountOf: valueToTransfer .! !
