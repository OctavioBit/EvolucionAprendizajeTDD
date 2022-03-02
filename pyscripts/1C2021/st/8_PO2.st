!classDefinition: #PortfolioTest category: 'Portfolio-18'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-18'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

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


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-18'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-18'!

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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportTest category: 'Portfolio-18'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-18'!

!ReportTest methodsFor: 'tests netTransfer' stamp: 'ijgt 6/2/2021 20:54:08'!
test09netTransferAccountEmpty

	| accountReport |
	accountReport := NetTransfer for: ReceptiveAccount new.
	self assert: accountReport equals: ('El neto de transferencias es: 0')! !

!ReportTest methodsFor: 'tests netTransfer' stamp: 'ijgt 6/2/2021 20:55:45'!
test10netTransferAccountWithTransferDeposit

	| accountReport anAccount anotherAccount|
	anAccount :=	ReceptiveAccount new.
	anotherAccount :=	ReceptiveAccount new.
	Transfer from: anAccount to: anotherAccount withValue: 50.
	accountReport := NetTransfer for: anotherAccount.
	self assert: accountReport equals: ('El neto de transferencias es: 50')! !

!ReportTest methodsFor: 'tests netTransfer' stamp: 'ijgt 6/2/2021 20:55:58'!
test11netTransferAccountWithTransferWithdraw

	| accountReport anAccount anotherAccount|
	anAccount :=	ReceptiveAccount new.
	anotherAccount :=	ReceptiveAccount new.
	Transfer from: anAccount to: anotherAccount withValue: 50.
	accountReport := NetTransfer for: anAccount.
	self assert: accountReport equals: ('El neto de transferencias es: -50')! !

!ReportTest methodsFor: 'tests netTransfer' stamp: 'ijgt 6/2/2021 21:00:08'!
test12netTransferPortfolioWithTransferWithdraw

	| portfolioReport aPortfolio anAccount anotherAccount|
	anAccount :=	ReceptiveAccount new.
	anotherAccount :=	ReceptiveAccount new.
	aPortfolio := Portfolio with: anAccount.
	Transfer from: anAccount to: anotherAccount withValue: 50.
	portfolioReport := NetTransfer for: aPortfolio.
	self assert: portfolioReport equals: ('El neto de transferencias es: -50')! !

!ReportTest methodsFor: 'tests netTransfer' stamp: 'ijgt 6/2/2021 21:00:34'!
test13netTransferPortfolioWithTransferWithdraw

	| portfolioReport aPortfolio anAccount anotherAccount|
	anAccount :=	ReceptiveAccount new.
	anotherAccount :=	ReceptiveAccount new.
	aPortfolio := Portfolio with: anAccount.
	Transfer from: anotherAccount to: anAccount withValue: 50.
	portfolioReport := NetTransfer for: aPortfolio.
	self assert: portfolioReport equals: ('El neto de transferencias es: 50')! !

!ReportTest methodsFor: 'tests netTransfer' stamp: 'ijgt 6/2/2021 21:02:15'!
test14netTransferPortfolioTransferBetweenChildren

	| portfolioReport aPortfolio anAccount anotherAccount|
	anAccount :=	ReceptiveAccount new.
	anotherAccount :=	ReceptiveAccount new.
	aPortfolio := Portfolio with: anAccount with: anotherAccount.
	Transfer from: anotherAccount to: anAccount withValue: 50.
	portfolioReport := NetTransfer for: aPortfolio.
	self assert: portfolioReport equals: ('El neto de transferencias es: 0')! !


!ReportTest methodsFor: 'tests summary' stamp: 'ijgt 6/2/2021 20:46:24'!
test01summaryEmptyAccount

	| accountReport |
	accountReport := Summary for: ReceptiveAccount new.
	self assert: (accountReport at: 1) equals: ('Balance = 0').
	self assert: (accountReport size) equals: 1.! !

!ReportTest methodsFor: 'tests summary' stamp: 'ijgt 6/2/2021 20:47:24'!
test02summaryAccountWithDeposit

	| accountReport anAccount|
	anAccount :=	ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	accountReport := Summary for: (anAccount).
	self assert: (accountReport at: 1) equals: ('Depósito por 100.').
	self assert: (accountReport at: 2) equals: ('Balance = 100').
	self assert: (accountReport size) equals: 2.! !

!ReportTest methodsFor: 'tests summary' stamp: 'ijgt 6/2/2021 20:50:03'!
test03summaryTwoDeposits

	| accountReport anAccount|
	anAccount :=	ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	Deposit register: 50 on: anAccount.
	accountReport := Summary for: (anAccount).
	self assert: (accountReport at: 1) equals: ('Depósito por 100.').
	self assert: (accountReport at: 2) equals: ('Depósito por 50.').
	self assert: (accountReport at: 3) equals: ('Balance = 150').
	self assert: (accountReport size) equals: 3.! !

!ReportTest methodsFor: 'tests summary' stamp: 'ijgt 6/2/2021 20:50:25'!
test04summaryDepositAndWithdraw

	| accountReport anAccount|
	anAccount :=	ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	Withdraw register: 50 on: anAccount.
	accountReport := Summary for: (anAccount).
	self assert: (accountReport at: 1) equals: ('Depósito por 100.').
	self assert: (accountReport at: 2) equals: ('Extracción por 50.').
	self assert: (accountReport at: 3) equals: ('Balance = 50').
	self assert: (accountReport size) equals: 3.! !

!ReportTest methodsFor: 'tests summary' stamp: 'ijgt 6/2/2021 20:50:49'!
test05summaryTransferWithdraw

	| accountReport anAccount anotherAccount|
	anAccount :=	ReceptiveAccount new.
	anotherAccount :=	ReceptiveAccount new.
	Transfer from: anAccount to: anotherAccount withValue: 100.
	accountReport := Summary for: (anAccount).
	self assert: (accountReport at: 1) equals: ('Salida por transferencia de 100.').
	self assert: (accountReport at: 2) equals: ('Balance = -100').
	self assert: (accountReport size) equals: 2.! !

!ReportTest methodsFor: 'tests summary' stamp: 'ijgt 6/2/2021 20:51:08'!
test06summaryTransferDeposit

	| accountReport anAccount anotherAccount|
	anAccount :=	ReceptiveAccount new.
	anotherAccount :=	ReceptiveAccount new.
	Transfer from: anAccount to: anotherAccount withValue: 100.
	accountReport := Summary for: (anotherAccount).
	self assert: (accountReport at: 1) equals: ('Entrada por transferencia de 100.').
	self assert: (accountReport at: 2) equals: ('Balance = 100').
	self assert: (accountReport size) equals: 2.! !

!ReportTest methodsFor: 'tests summary' stamp: 'ijgt 6/2/2021 20:53:14'!
test07summaryPortfolioEmpty

	| accountReport |
	accountReport := Summary for: Portfolio new.
	self assert: (accountReport at: 1) equals: ('Balance = 0').
	self assert: (accountReport size) equals: 1.! !

!ReportTest methodsFor: 'tests summary' stamp: 'ijgt 6/2/2021 20:53:40'!
test08summaryPortfolioFull

	| anAccount aPortfolio portfolioReport|
	anAccount :=	ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	Withdraw register: 50 on: anAccount.
	aPortfolio := Portfolio with: anAccount.
	portfolioReport := Summary for: (aPortfolio).
	self assert: (portfolioReport at: 1) equals: ('Depósito por 100.').
	self assert: (portfolioReport at: 2) equals: ('Extracción por 50.').
	self assert: (portfolioReport at: 3) equals: ('Balance = 50').
	self assert: (portfolioReport at: 4) equals: ('Balance = 50').
	self assert: (portfolioReport size) equals: 4.! !


!ReportTest methodsFor: 'tests transactionsStructure' stamp: 'ijgt 6/3/2021 16:27:58'!
test18transactionsStructureEmptyPortfolio

	| anAccount aPortfolio portfolioStructureString |
	anAccount := ReceptiveAccount named: 'Una cuenta'.
	aPortfolio := Portfolio named: 'Un portfolio' with: anAccount.
	portfolioStructureString := String streamContents: [:str | str            
  		nextPutAll: 'Un portfolio', String newLineString;
  		nextPutAll: String tab,'Una cuenta', String newLineString;
		nextPutAll: String tab, String tab, 'Balance = 0', String newLineString;
		nextPutAll: String tab, 'Balance = 0'.
  	].
	self assert: (TransactionsStructure for: aPortfolio) equals: portfolioStructureString! !

!ReportTest methodsFor: 'tests transactionsStructure' stamp: 'ijgt 6/3/2021 16:28:20'!
test19transactionsStructureStackedPortfolio

	| anAccount anotherAccount aPortfolio aSecondPortfolio portfolioStructureString |
	anAccount := ReceptiveAccount named: 'Una cuenta'.
	anotherAccount := ReceptiveAccount named: 'Otra cuenta'.
	aPortfolio := Portfolio named: 'Un portfolio' with: anAccount.
	Deposit register: 100 on: anAccount.
	Transfer from: anotherAccount to: anAccount withValue: 50.
	aPortfolio add: anotherAccount.
	aSecondPortfolio := Portfolio named: 'Gran portfolio' with: aPortfolio.
	portfolioStructureString := String streamContents: [:str | str            
  		nextPutAll: 'Gran portfolio', String newLineString;
		nextPutAll: String tab, 'Un portfolio', String newLineString;
  		nextPutAll: String tab, String tab,'Una cuenta', String newLineString ;
		nextPutAll: String tab, String tab,String tab,'Depósito por 100.', String newLineString ;
		nextPutAll: String tab, String tab,String tab,'Entrada por transferencia de 50.', String newLineString ;
		nextPutAll: String tab, String tab,String tab,'Balance = 150', String newLineString ;
		nextPutAll: String tab, String tab,'Otra cuenta', String newLineString;
		nextPutAll: String tab, String tab,String tab,'Salida por transferencia de 50.', String newLineString ;
		nextPutAll: String tab, String tab,String tab,'Balance = -50', String newLineString ;
		nextPutAll: String tab, String tab,'Balance = 100', String newLineString ;
		nextPutAll: String tab, 'Balance = 100'.
  	].
	self assert: (TransactionsStructure for: aSecondPortfolio) equals: portfolioStructureString! !


!ReportTest methodsFor: 'tests portfolioStructure' stamp: 'ijgt 6/2/2021 21:03:26'!
test15portfolioStructureOneAccount

	| anAccount aPortfolio portfolioStructureString |
	anAccount := ReceptiveAccount named: 'Una cuenta'.
	aPortfolio := Portfolio named: 'Un portfolio' with: anAccount.
	portfolioStructureString := String streamContents: [:str | str            
  		nextPutAll: 'Un portfolio', String newLineString;
  		nextPutAll: String tab,'Una cuenta'
  	].
	self assert: (PortfolioStructure for: aPortfolio) equals: portfolioStructureString! !

!ReportTest methodsFor: 'tests portfolioStructure' stamp: 'ijgt 6/2/2021 21:03:45'!
test16portfolioStructureTwoAccounts

	| anAccount anotherAccount aPortfolio portfolioStructureString |
	anAccount := ReceptiveAccount named: 'Una cuenta'.
	anotherAccount := ReceptiveAccount named: 'Otra cuenta'.
	aPortfolio := Portfolio named: 'Un portfolio' with: anAccount.
	aPortfolio add: anotherAccount.
	portfolioStructureString := String streamContents: [:str | str            
  		nextPutAll: 'Un portfolio', String newLineString;
  		nextPutAll: String tab,'Una cuenta', String newLineString ;
		nextPutAll: String tab,'Otra cuenta'
  	].
	self assert: (PortfolioStructure for: aPortfolio) equals: portfolioStructureString! !

!ReportTest methodsFor: 'tests portfolioStructure' stamp: 'ijgt 6/2/2021 21:04:17'!
test17portfolioStructureStackedPortfolio

	| anAccount anotherAccount aPortfolio aSecondPortfolio portfolioStructureString |
	anAccount := ReceptiveAccount named: 'Una cuenta'.
	anotherAccount := ReceptiveAccount named: 'Otra cuenta'.
	aPortfolio := Portfolio named: 'Un portfolio' with: anAccount.
	aPortfolio add: anotherAccount.
	aSecondPortfolio := Portfolio named: 'Gran portfolio' with: aPortfolio.
	portfolioStructureString := String streamContents: [:str | str            
  		nextPutAll: 'Gran portfolio', String newLineString;
		nextPutAll: String tab, 'Un portfolio', String newLineString;
  		nextPutAll: String tab, String tab,'Una cuenta', String newLineString ;
		nextPutAll: String tab, String tab,'Otra cuenta'
  	].
	self assert: (PortfolioStructure for: aSecondPortfolio) equals: portfolioStructureString! !


!classDefinition: #TransferTest category: 'Portfolio-18'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-18'!

!TransferTest methodsFor: 'tests' stamp: 'ijgt 5/28/2021 17:33:20'!
test01

	|anAccount anotherAccount|
	anAccount  := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Transfer from: anAccount to: anotherAccount withValue: 50.
	self assert: (anotherAccount balance) equals: 50 ! !

!TransferTest methodsFor: 'tests' stamp: 'ijgt 5/28/2021 17:33:20'!
test02

	|anAccount anotherAccount|
	anAccount  := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Transfer from: anAccount to: anotherAccount withValue: 50.
	self assert: (anAccount balance) equals: (-50)! !

!TransferTest methodsFor: 'tests' stamp: 'ijgt 5/28/2021 17:33:20'!
test03

	|anAccount anotherAccount|
	anAccount  := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Transfer from: anAccount to: anotherAccount withValue: 60.
	self assert: (anAccount balance) equals: (-60)! !

!TransferTest methodsFor: 'tests' stamp: 'ijgt 5/28/2021 17:33:20'!
test04

	|anAccount anotherAccount|
	anAccount  := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	self should: [Transfer from: anAccount to: anotherAccount withValue: -60] 
		raise: Error 
		withExceptionDo: [:anError | self assert: (anError messageText) 
			equals: Transfer canNotTransferNegativeAmountErrorDescription]! !

!TransferTest methodsFor: 'tests' stamp: 'ijgt 5/28/2021 18:56:25'!
test05

	|anAccount anotherAccount transferencia|
	anAccount  := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	transferencia := Transfer from: anAccount to: anotherAccount withValue: 50.
	
	self assert: (transferencia withdrawLeg) equals: (transferencia depositLeg) withdrawLeg.! !

!TransferTest methodsFor: 'tests' stamp: 'ijgt 5/28/2021 19:01:53'!
test06

	|anAccount anotherAccount transferencia|
	anAccount  := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	transferencia := Transfer from: anAccount to: anotherAccount withValue: 50.
	
	self assert: (transferencia depositLeg ) equals: (transferencia withdrawLeg ) depositLeg .! !

!TransferTest methodsFor: 'tests' stamp: 'ijgt 5/31/2021 15:56:27'!
test07

	|anAccount|
	anAccount  := ReceptiveAccount new.
	self should: [Transfer from: anAccount to: anAccount withValue: 50] raise: Error withMessageText: [Transfer invalidAccountErrorDescription].! !


!classDefinition: #Account category: 'Portfolio-18'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-18'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'ijgt 6/2/2021 20:29:05'!
name

	^ name! !


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


!Account methodsFor: 'report' stamp: 'ijgt 6/2/2021 19:21:51'!
netTransfer: aNetTransfer

	self subclassResponsibility ! !

!Account methodsFor: 'report' stamp: 'ijgt 6/2/2021 19:22:03'!
netTransferValue: aNetTransfer

	self subclassResponsibility ! !

!Account methodsFor: 'report' stamp: 'ijgt 6/2/2021 20:18:46'!
portfolioStructureReport: aPortfolioStructureReport

	self subclassResponsibility! !

!Account methodsFor: 'report' stamp: 'ijgt 6/2/2021 18:33:04'!
summary: aReport
	
	self subclassResponsibility! !

!Account methodsFor: 'report' stamp: 'ijgt 6/3/2021 15:55:10'!
transactionsStructureReport: aTransactionsStructureReport

	self subclassResponsibility! !


!classDefinition: #Portfolio category: 'Portfolio-18'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-18'!

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


!Portfolio methodsFor: 'initialization' stamp: 'ijgt 6/2/2021 19:49:37'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := ''.! !

!Portfolio methodsFor: 'initialization' stamp: 'ijgt 6/2/2021 19:48:37'!
initializeWithName: aName

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := aName.! !


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


!Portfolio methodsFor: 'report' stamp: 'ijgt 6/2/2021 19:26:43'!
netTransfer: aNetTransfer

	^ 'El neto de transferencias es: ', (self netTransferValue: aNetTransfer) asString.! !

!Portfolio methodsFor: 'report' stamp: 'ijgt 6/2/2021 19:23:07'!
netTransferValue: aNetTransfer

	^ accounts sum: [:account | account netTransferValue: aNetTransfer] ifEmpty: [0].
! !

!Portfolio methodsFor: 'report' stamp: 'ijgt 6/2/2021 20:19:45'!
portfolioStructureReport: aPortfolioStrutureReport

	^ aPortfolioStrutureReport reportPortfolio: self withAccounts: accounts! !

!Portfolio methodsFor: 'report' stamp: 'ijgt 6/2/2021 18:38:14'!
summary: aSummary

	|aReport|
	aReport := OrderedCollection new.
	accounts do: [:account | aReport addAll: (account summary: aSummary)].
	aReport add: 'Balance = ', self balance asString.
	
	^ aReport! !

!Portfolio methodsFor: 'report' stamp: 'ijgt 6/3/2021 15:56:08'!
transactionsStructureReport: aTransactionsStrutureReport

	^ aTransactionsStrutureReport reportPortfolio: self withAccounts: accounts! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-18'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error description' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!Portfolio class methodsFor: 'creation' stamp: 'ijgt 6/2/2021 19:47:46'!
named: aName with: anAccount

	^self new initializeWithName: aName;
		add: anAccount ;
		yourself
	! !

!Portfolio class methodsFor: 'creation' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'creation' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-18'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-18'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'ijgt 6/2/2021 19:53:16'!
initialize

	super initialize.
	transactions := OrderedCollection new.
	name := ''.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'ijgt 6/2/2021 19:52:54'!
initializeWithName: aName

	super initialize.
	transactions := OrderedCollection new.
	name := aName.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
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


!ReceptiveAccount methodsFor: 'transfers' stamp: 'ijgt 6/1/2021 16:30:15'!
depositTransfer: aTransfer
	
	|transferLeg|
	
	transferLeg := TransferDepositLeg forTransfer: aTransfer.
	self register: transferLeg.
	^ transferLeg.! !

!ReceptiveAccount methodsFor: 'transfers' stamp: 'ijgt 6/1/2021 16:30:48'!
withdrawTransfer: aTransfer

	|transferLeg|
	
	transferLeg := TransferWithdrawLeg forTransfer: aTransfer.
	self register: transferLeg.
	^ transferLeg.! !


!ReceptiveAccount methodsFor: 'report' stamp: 'ijgt 6/2/2021 19:26:06'!
netTransfer: aNetTransfer

	^ 'El neto de transferencias es: ', (self netTransferValue: aNetTransfer) asString.! !

!ReceptiveAccount methodsFor: 'report' stamp: 'ijgt 6/2/2021 19:23:38'!
netTransferValue: aNetTransfer

	^ transactions sum: [:transaction | transaction valueAsTransfer: aNetTransfer] ifEmpty: [0].! !

!ReceptiveAccount methodsFor: 'report' stamp: 'ijgt 6/2/2021 20:20:17'!
portfolioStructureReport: aPortfolioStrutureReport

	^ aPortfolioStrutureReport reportReceptiveAccount: self! !

!ReceptiveAccount methodsFor: 'report' stamp: 'ijgt 6/2/2021 18:35:07'!
summary: aSummary

	|aReport|
	aReport := OrderedCollection new.
	transactions do: [:transaction| aReport add: (transaction asStringForSummary: aSummary)].
	aReport add: 'Balance = ', self balance asString.
	
	^ aReport! !

!ReceptiveAccount methodsFor: 'report' stamp: 'ijgt 6/3/2021 15:56:29'!
transactionsStructureReport: aTransactionsStrutureReport

	^ aTransactionsStrutureReport reportReceptiveAccount: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-18'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'creation' stamp: 'ijgt 6/2/2021 19:51:12'!
named: aName

	^ self new initializeWithName: aName! !


!classDefinition: #AccountTransaction category: 'Portfolio-18'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-18'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'report' stamp: 'ijgt 6/2/2021 18:19:51'!
asStringForSummary: aSummary

	self subclassResponsibility! !

!AccountTransaction methodsFor: 'report' stamp: 'ijgt 6/2/2021 18:57:28'!
valueAsTransfer: aNetTransfer

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-18'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-18'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-18'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'report' stamp: 'ijgt 6/2/2021 18:21:48'!
asStringForSummary: aSummary

	^ aSummary reportDeposit: self! !

!Deposit methodsFor: 'report' stamp: 'ijgt 6/2/2021 18:59:38'!
valueAsTransfer: aNetTransfer

	^ aNetTransfer netTransferValueForDeposit! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-18'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLegs category: 'Portfolio-18'!
AccountTransaction subclass: #TransferLegs
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-18'!

!TransferLegs methodsFor: 'initialize' stamp: 'ijgt 5/28/2021 18:55:03'!
initializeForTransfer: aTransfer

	transfer := aTransfer.! !


!TransferLegs methodsFor: 'affectBalance' stamp: 'ijgt 6/1/2021 16:09:57'!
affectBalance: aBalance

	self subclassResponsibility! !


!TransferLegs methodsFor: 'value' stamp: 'ijgt 6/1/2021 16:34:57'!
value

	^ transfer value! !


!TransferLegs methodsFor: 'report' stamp: 'ijgt 6/2/2021 18:19:50'!
asStringForSummary: aSummary

	self subclassResponsibility! !

!TransferLegs methodsFor: 'report' stamp: 'ijgt 6/2/2021 18:57:28'!
valueAsTransfer: aNetTransfer

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLegs class' category: 'Portfolio-18'!
TransferLegs class
	instanceVariableNames: ''!

!TransferLegs class methodsFor: 'creation' stamp: 'ijgt 6/1/2021 16:12:59'!
forTransfer: aTransfer 

	^ self new initializeForTransfer: aTransfer! !


!classDefinition: #TransferDepositLeg category: 'Portfolio-18'!
TransferLegs subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-18'!

!TransferDepositLeg methodsFor: 'affectBalance' stamp: 'ijgt 6/1/2021 16:09:25'!
affectBalance: aBalance

	^aBalance + transfer value! !


!TransferDepositLeg methodsFor: 'testing' stamp: 'ijgt 5/28/2021 18:45:42'!
withdrawLeg

	^ transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'report' stamp: 'ijgt 6/2/2021 18:26:04'!
asStringForSummary: aSummary

	^ aSummary reportTransferDeposit: self! !

!TransferDepositLeg methodsFor: 'report' stamp: 'ijgt 6/2/2021 19:03:10'!
valueAsTransfer: aNetTransfer

	^ aNetTransfer netTransferValueForTransferDeposit: transfer! !


!classDefinition: #TransferWithdrawLeg category: 'Portfolio-18'!
TransferLegs subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-18'!

!TransferWithdrawLeg methodsFor: 'affectBalance' stamp: 'ijgt 6/1/2021 16:17:25'!
affectBalance: aBalance

	^aBalance - transfer value ! !


!TransferWithdrawLeg methodsFor: 'testing' stamp: 'ijgt 5/28/2021 18:47:35'!
depositLeg

	^ transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'report' stamp: 'ijgt 6/2/2021 18:26:32'!
asStringForSummary: aSummary

	^ aSummary reportTransferWithdraw: self! !

!TransferWithdrawLeg methodsFor: 'report' stamp: 'ijgt 6/2/2021 19:03:44'!
valueAsTransfer: aNetTransfer

	^ aNetTransfer netTransferValueForTransferWithdraw: transfer! !


!classDefinition: #Withdraw category: 'Portfolio-18'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-18'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'report' stamp: 'ijgt 6/2/2021 18:25:28'!
asStringForSummary: aSummary

	^ aSummary reportWithdraw: self! !

!Withdraw methodsFor: 'report' stamp: 'ijgt 6/2/2021 19:00:02'!
valueAsTransfer: aNetTransfer

	^ aNetTransfer netTransferValueForWithdraw! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-18'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: 'Portfolio-18'!
Object subclass: #Report
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-18'!

!Report methodsFor: 'report' stamp: 'ijgt 6/1/2021 17:35:06'!
report

	self subclassResponsibility! !


!Report methodsFor: 'initialize' stamp: 'ijgt 6/1/2021 17:42:40'!
initializeFor: anAccount 
	
	account := anAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'Portfolio-18'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'creation' stamp: 'ijgt 6/1/2021 17:40:43'!
for: anAccount
	
	^self new initializeFor: anAccount ; report! !


!classDefinition: #NetTransfer category: 'Portfolio-18'!
Report subclass: #NetTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-18'!

!NetTransfer methodsFor: 'report' stamp: 'ijgt 6/2/2021 19:00:36'!
netTransferValueForDeposit

	^ 0! !

!NetTransfer methodsFor: 'report' stamp: 'ijgt 6/2/2021 19:05:51'!
netTransferValueForTransferDeposit: aTransfer

	^ aTransfer value! !

!NetTransfer methodsFor: 'report' stamp: 'ijgt 6/2/2021 19:05:37'!
netTransferValueForTransferWithdraw: aTransfer

	^ (-1)*aTransfer value! !

!NetTransfer methodsFor: 'report' stamp: 'ijgt 6/2/2021 19:00:43'!
netTransferValueForWithdraw

	^ 0! !

!NetTransfer methodsFor: 'report' stamp: 'ijgt 6/2/2021 19:00:22'!
report

	^ account netTransfer: self! !


!classDefinition: #StructureReport category: 'Portfolio-18'!
Report subclass: #StructureReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-18'!

!StructureReport methodsFor: 'report' stamp: 'ijgt 6/3/2021 16:37:05'!
portfolioStructureAsString: aPortfolio withAccounts: portfolioAccounts

	^ String streamContents: [:str | str
		nextPutAll: aPortfolio name, String newLineString.
  		portfolioAccounts do:[:anAccount |
   			(anAccount portfolioStructureReport: self) linesDo: [:aLine | str nextPutAll: String tab, aLine, String newLineString.]
   		].
  	]! !

!StructureReport methodsFor: 'report' stamp: 'ijgt 6/3/2021 16:30:53'!
report

	^ account portfolioStructureReport: self! !


!classDefinition: #PortfolioStructure category: 'Portfolio-18'!
StructureReport subclass: #PortfolioStructure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-18'!

!PortfolioStructure methodsFor: 'report' stamp: 'ijgt 6/3/2021 16:38:18'!
reportPortfolio: aPortfolio withAccounts: portfolioAccounts

 	|portfolioStructureString|
 	portfolioStructureString := self portfolioStructureAsString: aPortfolio withAccounts: portfolioAccounts.
 	^portfolioStructureString allButLast .! !

!PortfolioStructure methodsFor: 'report' stamp: 'ijgt 6/2/2021 20:34:57'!
reportReceptiveAccount: aReceptiveAccount

	|portfolioStructureString|
 	portfolioStructureString := String streamContents: [:str | str 
		nextPutAll: aReceptiveAccount name, String newLineString.
	].
 	^ portfolioStructureString allButLast.! !


!classDefinition: #TransactionsStructure category: 'Portfolio-18'!
StructureReport subclass: #TransactionsStructure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-18'!

!TransactionsStructure methodsFor: 'report' stamp: 'ijgt 6/3/2021 16:38:46'!
reportPortfolio: aPortfolio withAccounts: portfolioAccounts

	|portfolioStructureString|
 	portfolioStructureString := self portfolioStructureAsString: aPortfolio withAccounts: portfolioAccounts.
	portfolioStructureString allButLast.
	portfolioStructureString := portfolioStructureString, String tab, 'Balance = ', aPortfolio balance asString.
 	^portfolioStructureString! !

!TransactionsStructure methodsFor: 'report' stamp: 'ijgt 6/3/2021 16:00:37'!
reportReceptiveAccount: aReceptiveAccount

	|portfolioStructureString|
 	portfolioStructureString := String streamContents: [:str | str 
		nextPutAll: aReceptiveAccount name, String newLineString.
		(Summary for: aReceptiveAccount) do: [:aLine | str 
			nextPutAll: String tab,aLine,String newLineString.
		]. 
	].
 	^ portfolioStructureString allButLast.! !


!classDefinition: #Summary category: 'Portfolio-18'!
Report subclass: #Summary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-18'!

!Summary methodsFor: 'report' stamp: 'ijgt 6/2/2021 18:36:25'!
report

	^ account summary: self! !

!Summary methodsFor: 'report' stamp: 'ijgt 6/2/2021 18:22:33'!
reportDeposit: aDeposit

	^ 'Depósito por ', aDeposit value asString, '.'! !

!Summary methodsFor: 'report' stamp: 'ijgt 6/2/2021 18:24:30'!
reportTransferDeposit: aTransfer

	^ 'Entrada por transferencia de ', aTransfer value asString, '.'! !

!Summary methodsFor: 'report' stamp: 'ijgt 6/2/2021 18:24:49'!
reportTransferWithdraw: aTransfer

	^ 'Salida por transferencia de ', aTransfer value asString, '.'! !

!Summary methodsFor: 'report' stamp: 'ijgt 6/2/2021 18:23:09'!
reportWithdraw: aWithdraw

	^ 'Extracción por ', aWithdraw value asString, '.'! !


!classDefinition: #Transfer category: 'Portfolio-18'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-18'!

!Transfer methodsFor: 'initialize' stamp: 'ijgt 5/31/2021 16:05:32'!
assertTransferIsValidFrom: anAccount to: aSecondAccount withValue: anAmount

	(anAmount > 0) ifFalse: [^self error: self class canNotTransferNegativeAmountErrorDescription].
	(anAccount == aSecondAccount) ifTrue: [^ self error: self class invalidAccountErrorDescription]! !

!Transfer methodsFor: 'initialize' stamp: 'ijgt 6/1/2021 16:31:14'!
initializeFrom: aReceptiveAccount to: aSecondReceptiveAccount withValue: anAmount 

	self assertTransferIsValidFrom: aReceptiveAccount to: aSecondReceptiveAccount withValue: anAmount.
	withdrawLeg := aReceptiveAccount withdrawTransfer: self.
	depositLeg := aSecondReceptiveAccount depositTransfer: self.
	value := anAmount.! !


!Transfer methodsFor: 'testing patas' stamp: 'ijgt 5/28/2021 18:43:13'!
depositLeg
	
	^depositLeg! !

!Transfer methodsFor: 'testing patas' stamp: 'ijgt 5/28/2021 18:43:33'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'value' stamp: 'ijgt 6/1/2021 16:08:57'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-18'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'error descriptions' stamp: 'ijgt 5/27/2021 21:19:41'!
canNotTransferNegativeAmountErrorDescription

	^ 'Amount to transfer must be positive.'! !

!Transfer class methodsFor: 'error descriptions' stamp: 'ijgt 5/31/2021 16:00:04'!
invalidAccountErrorDescription

	^ 'Accounts in transfer must be different.'! !


!Transfer class methodsFor: 'instance creation' stamp: 'ijgt 5/27/2021 20:57:17'!
from: aReceptiveAccount to: aSecondReceptiveAccount withValue: anAmount

	^self new initializeFrom: aReceptiveAccount to: aSecondReceptiveAccount withValue: anAmount ! !
