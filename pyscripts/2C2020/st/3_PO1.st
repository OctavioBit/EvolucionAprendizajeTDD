!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'balance tests' stamp: 'DS 11/8/2020 22:00:06'!
test01PortfolioStartsWithNoIncome

	| aPortfolio |
	aPortfolio := Portfolio new.
	
	self assert: 0 equals: aPortfolio balance.! !

!PortfolioTest methodsFor: 'balance tests' stamp: 'DS 11/8/2020 22:00:03'!
test02BalanceCountAccountTransactions

	| aPortfolio anAccount |
	
	aPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	
	aPortfolio add: anAccount.
	Deposit register: 100 on: anAccount.
		
	self assert: 100 equals: aPortfolio balance.

! !

!PortfolioTest methodsFor: 'balance tests' stamp: 'DS 11/8/2020 21:59:58'!
test03BalanceCountPortafolioAndAccountTransactions

	| aRootPortfolio anotherPortfolio aPortfolioAccount aMainAccount |
	
	aRootPortfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	
	aMainAccount := ReceptiveAccount new.
	aPortfolioAccount  := ReceptiveAccount new.
	
	anotherPortfolio add: aPortfolioAccount.
	aRootPortfolio add: aMainAccount.
	aRootPortfolio add: anotherPortfolio.

	Deposit register: 100 on: aMainAccount.
	Deposit register: 100 on: aPortfolioAccount.
		
	self assert: 200 equals: aRootPortfolio balance.

! !


!PortfolioTest methodsFor: 'hasRegistered tests' stamp: 'Federico 11/6/2020 11:55:34'!
test04PortfolioDoesNotRegisterUnknownTransaction

	| aPortfolio aTransaction |
	
	aPortfolio := Portfolio new.
	
	aTransaction :=  Deposit for: 100.
		
	self deny: (aPortfolio hasRegistered: aTransaction).

! !

!PortfolioTest methodsFor: 'hasRegistered tests' stamp: 'DS 11/8/2020 22:00:11'!
test05PortfolioHasRegisteredAccountTransactions

	| aPortfolio anAccount aTransaction |
	
	aPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	
	aTransaction := Deposit register: 100 on: anAccount.
	aPortfolio add: anAccount.
		
	self assert: (aPortfolio hasRegistered: aTransaction).

! !

!PortfolioTest methodsFor: 'hasRegistered tests' stamp: 'Federico 11/6/2020 11:56:43'!
test06PortfolioHasRegisteredAnotherPortfolioTransactions

	| aMainPortfolio anotherPortfolio aPortfolioAccount aMainAccount aTransaction secondTransaction |
	
	aMainPortfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	
	aMainAccount := ReceptiveAccount new.
	aPortfolioAccount  := ReceptiveAccount new.
	
	anotherPortfolio add: aPortfolioAccount.
	
	aMainPortfolio add: aMainAccount.
	aMainPortfolio add: anotherPortfolio.

	aTransaction := Deposit register: 100 on: aPortfolioAccount.	
	secondTransaction := Deposit register: 100 on: aMainAccount.

	self assert: (anotherPortfolio hasRegistered: aTransaction).
	self assert: (aMainPortfolio hasRegistered: secondTransaction).
	self assert: (aMainPortfolio hasRegistered: aTransaction).


! !


!PortfolioTest methodsFor: 'transactions tests' stamp: 'DS 11/8/2020 21:59:10'!
test07PortfolioStartsWithNoTransactions
	| aPortfolio |
	
	aPortfolio := Portfolio new.

	self assert: (aPortfolio transactions) isEmpty.

! !

!PortfolioTest methodsFor: 'transactions tests' stamp: 'Federico 11/6/2020 11:58:13'!
test08PortfolioIncludesAccountTransactions
	| aPortfolio anAccount aTransaction |
	
	aPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	
	aPortfolio add: anAccount.
	aTransaction := Deposit register: 50 on: anAccount.
		
	self assert: 1 equals: anAccount transactions size.
	self assert: (aPortfolio transactions includes: aTransaction).
		

! !

!PortfolioTest methodsFor: 'transactions tests' stamp: 'DS 11/8/2020 21:59:24'!
test09PortfolioIncludesAnotherPortfolioTransactions
	| aRootPortfolio anotherPortfolio aMainAccount aPortfolioAccount aTransaction secondTransaction |
	
	aRootPortfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	
	aPortfolioAccount  := ReceptiveAccount new.
	aMainAccount  := ReceptiveAccount new.
	
	anotherPortfolio add: aPortfolioAccount.
	
	aRootPortfolio add: anotherPortfolio.
	aRootPortfolio add: aMainAccount.

	aTransaction := Deposit register: 100 on: aPortfolioAccount.	
	secondTransaction := Deposit register: 200 on: aMainAccount.	
		
	self assert: 2 equals: aRootPortfolio transactions size.
	self assert: (aRootPortfolio transactions includes: aTransaction).
	self assert: (aRootPortfolio transactions includes: secondTransaction).
		

! !


!PortfolioTest methodsFor: 'add tests' stamp: 'DS 11/8/2020 21:51:34'!
shouldNotHaveRepeatedBankRecordWhen: aPortfolio add: aBankRecord
	self 
		should: [ aPortfolio add: aBankRecord. ]
		raise: Error
		withMessageText: Portfolio shouldNotHaveRepeatedBankRecordsErrorDescription
! !

!PortfolioTest methodsFor: 'add tests' stamp: 'DS 11/8/2020 21:52:55'!
test10PortafolioShouldNotBeAddedToHimself

	| rootPortfolio |
	
	rootPortfolio := Portfolio new.

	self shouldNotHaveRepeatedBankRecordWhen: rootPortfolio add: rootPortfolio.! !

!PortfolioTest methodsFor: 'add tests' stamp: 'DS 11/8/2020 21:58:45'!
test11AddedPortfolioShouldNotContainRepeatedChilds

	| rootPortfolio secondPortfolio |
	
	rootPortfolio := Portfolio new.
	secondPortfolio := Portfolio new.
	
	rootPortfolio add: secondPortfolio.

	self shouldNotHaveRepeatedBankRecordWhen: secondPortfolio add: rootPortfolio.! !

!PortfolioTest methodsFor: 'add tests' stamp: 'DS 11/8/2020 21:58:38'!
test12AddedPortafolioShouldNotContainSuccesiveRepeatedChilds

	| rootPortfolio secondPortfolio thirdPortfolio |
	
	rootPortfolio := Portfolio new.
	secondPortfolio := Portfolio new.
	thirdPortfolio := Portfolio new.
	
	rootPortfolio add: secondPortfolio.
	secondPortfolio add: thirdPortfolio.

	self shouldNotHaveRepeatedBankRecordWhen: thirdPortfolio add: rootPortfolio.! !

!PortfolioTest methodsFor: 'add tests' stamp: 'DS 11/8/2020 21:58:32'!
test13AddedPortafolioShouldNotBeInHisChilds

	| rootPortfolio aRepeatedPortfolio |
	
	rootPortfolio := Portfolio new.
	aRepeatedPortfolio  := Portfolio new.
	
	rootPortfolio add: aRepeatedPortfolio.

	self shouldNotHaveRepeatedBankRecordWhen: rootPortfolio add: aRepeatedPortfolio.! !

!PortfolioTest methodsFor: 'add tests' stamp: 'DS 11/8/2020 21:54:16'!
test14AddedPortafolioShouldNotBeInHisSuccesiveChilds

	| rootPortfolio secondPortfolio aRepeatedPortfolio |
	
	rootPortfolio := Portfolio new.
	secondPortfolio := Portfolio new.
	aRepeatedPortfolio  := Portfolio new.
	
	rootPortfolio add: secondPortfolio. 
	secondPortfolio add: aRepeatedPortfolio.

	self shouldNotHaveRepeatedBankRecordWhen: rootPortfolio add: aRepeatedPortfolio.! !

!PortfolioTest methodsFor: 'add tests' stamp: 'DS 11/8/2020 21:55:03'!
test15AddedPortfolioChildsShouldNotBeInPortfolioChilds
	
	| rootPortfolio secondPortfolio aRepeatedBankRecord |
	
	rootPortfolio := Portfolio new.
	secondPortfolio  := Portfolio new.
	
	aRepeatedBankRecord := ReceptiveAccount new.
	
	secondPortfolio add: aRepeatedBankRecord.
	rootPortfolio add: aRepeatedBankRecord.
	
	self shouldNotHaveRepeatedBankRecordWhen: rootPortfolio add: secondPortfolio.! !

!PortfolioTest methodsFor: 'add tests' stamp: 'DS 11/8/2020 21:55:50'!
test16AddedPortfolioHerarchyShouldNotBeInHisHerarchy
	
	| rootPortfolio secondPortfolio thirdPortfolio aRepeatedBankRecord |
	
	rootPortfolio := Portfolio new.
	secondPortfolio  := Portfolio new.
	thirdPortfolio := Portfolio new.
	
	aRepeatedBankRecord := ReceptiveAccount new.
	
	thirdPortfolio add: aRepeatedBankRecord.
	secondPortfolio add: aRepeatedBankRecord.
	
	rootPortfolio add: secondPortfolio.
	
	self shouldNotHaveRepeatedBankRecordWhen: rootPortfolio add: thirdPortfolio.! !

!PortfolioTest methodsFor: 'add tests' stamp: 'DS 11/8/2020 21:56:05'!
test17AddedPortfolioShouldNotHasSameParent
	
	| rootPortfolio secondPortfolio thirdPortfolio  |
	
	rootPortfolio := Portfolio new.
	secondPortfolio  := Portfolio new.
	thirdPortfolio := Portfolio new.

	rootPortfolio add: secondPortfolio.
	rootPortfolio add: thirdPortfolio.
	
	self shouldNotHaveRepeatedBankRecordWhen: secondPortfolio add: thirdPortfolio.! !

!PortfolioTest methodsFor: 'add tests' stamp: 'DS 11/8/2020 21:57:14'!
test18AddedBankRecordShouldNotBeInLastHerachyOfBrotherBranch
	
	| rootPortfolio secondPortfolio thirdPortfolio fourthPortfolio aRepeatedBankRecord |
	
	rootPortfolio := Portfolio new.
	secondPortfolio  := Portfolio new.
	thirdPortfolio := Portfolio new.
	
	fourthPortfolio := Portfolio new.
	aRepeatedBankRecord := ReceptiveAccount new.
	
	rootPortfolio add: secondPortfolio.
	rootPortfolio add: thirdPortfolio.
	
	secondPortfolio add: aRepeatedBankRecord.
	thirdPortfolio add: fourthPortfolio.
	
	self shouldNotHaveRepeatedBankRecordWhen: fourthPortfolio add: aRepeatedBankRecord.! !

!PortfolioTest methodsFor: 'add tests' stamp: 'DS 11/8/2020 21:57:50'!
test19ShouldNotAddABankRecordWhenAnyOfParentsHaveIt
	
	| rootPortfolio1 rootPortfolio2 aPortfolio aRepeatedAccount |
	
	rootPortfolio1 := Portfolio new.
	rootPortfolio2 := Portfolio new.

	aPortfolio := Portfolio new.
	aRepeatedAccount := ReceptiveAccount new.

	rootPortfolio1 add: aPortfolio.
	rootPortfolio1 add: aRepeatedAccount.	
	rootPortfolio2 add: aPortfolio.

	self shouldNotHaveRepeatedBankRecordWhen: aPortfolio add: aRepeatedAccount.! !


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


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'Federico 11/2/2020 20:48:56'!
countFor: aBalance
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

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'Federico 11/2/2020 20:48:17'!
countFor: aBalance
	^aBalance + value ! !

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


!Withdraw methodsFor: 'value' stamp: 'Federico 11/2/2020 19:20:48'!
value

	^ value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'Federico 11/2/2020 20:48:37'!
countFor: aBalance
	^aBalance - value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #BankRecord category: 'Portfolio-Ejercicio'!
Object subclass: #BankRecord
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!BankRecord methodsFor: 'transactions' stamp: 'DS 11/8/2020 22:01:19'!
transactions

	self subclassResponsibility ! !


!BankRecord methodsFor: 'balance' stamp: 'DS 11/8/2020 22:01:04'!
balance

	self subclassResponsibility ! !


!BankRecord methodsFor: 'testing' stamp: 'DS 11/8/2020 22:01:07'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!BankRecord methodsFor: 'adding' stamp: 'DS 11/8/2020 20:59:10'!
addTo: aPortfolio

	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
BankRecord subclass: #Portfolio
	instanceVariableNames: 'bankRecords parentPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'DS 11/8/2020 21:40:39'!
hasBankRecord: aBankRecord

	^self = aBankRecord
	or: [ self collection: bankRecords
		isNotEmptyWhenSelect: [ :childRegisters | 
			(aBankRecord  hasBankRecord: childRegisters) or: [ childRegisters  hasBankRecord: aBankRecord ]]
	].
	! !

!Portfolio methodsFor: 'testing' stamp: 'DS 11/8/2020 21:37:09'!
hasRegistered: aTransaction

	^ self	collection: bankRecords
		 isNotEmptyWhenSelect: [ :aBankRecord | aBankRecord  hasRegistered: aTransaction ].
! !


!Portfolio methodsFor: 'initialization' stamp: 'DS 11/8/2020 20:00:29'!
initialize

	bankRecords := OrderedCollection new.
	parentPortfolios := RootParentPortfolio for: self.! !


!Portfolio methodsFor: 'transactions' stamp: 'DS 11/8/2020 20:49:37'!
transactions
	^(bankRecords collect: [ :aBankRecord | aBankRecord transactions ]) flatten.
	! !


!Portfolio methodsFor: 'balance' stamp: 'DS 11/8/2020 20:48:06'!
balance
	^bankRecords sum: [ :aBankRecord | aBankRecord balance.] ifEmpty: [0].
	
	! !


!Portfolio methodsFor: 'private testing' stamp: 'DS 11/8/2020 21:30:17'!
collection: aCollection isNotEmptyWhenSelect: aSelectBlock

	^(aCollection select: aSelectBlock) isEmpty not.! !


!Portfolio methodsFor: 'assert / errors' stamp: 'DS 11/8/2020 21:33:55'!
assertRepeatedBankRecord: aBankRecord

	(self 	collection: self rootPortfolios
		isNotEmptyWhenSelect: [:rootPorfolio | rootPorfolio hasBankRecord: aBankRecord]
	) ifTrue: [self signalShouldNotHaveRepeatedBankRecords].! !

!Portfolio methodsFor: 'assert / errors' stamp: 'DS 11/8/2020 20:02:22'!
signalShouldNotHaveRepeatedBankRecords

	^ self error: self class shouldNotHaveRepeatedBankRecordsErrorDescription! !


!Portfolio methodsFor: 'adding' stamp: 'DS 11/8/2020 20:01:05'!
add: aBankRecord

	self assertRepeatedBankRecord: aBankRecord.

	aBankRecord addTo: self.	! !

!Portfolio methodsFor: 'adding' stamp: 'DS 11/8/2020 20:00:47'!
addSecure: aBankRecord

	bankRecords add: aBankRecord.! !

!Portfolio methodsFor: 'adding' stamp: 'DS 11/8/2020 19:41:10'!
addTo: aPortfolio

	parentPortfolios := 	parentPortfolios addParent: aPortfolio.

	aPortfolio addSecure: self.! !


!Portfolio methodsFor: 'roots' stamp: 'DS 11/8/2020 19:45:47'!
rootPortfolios

	^parentPortfolios roots.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'DS 11/8/2020 20:02:32'!
shouldNotHaveRepeatedBankRecordsErrorDescription
	^'A portfolio should not have repeated bank records'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
BankRecord subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions parentRegisters'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'DS 11/8/2020 18:14:01'!
initialize

	transactions := OrderedCollection new.
	parentRegisters  := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'Federico 11/2/2020 20:46:39'!
balance

    | balance |
    balance := 0.

    transactions do: [ :aTransaction | balance := aTransaction countFor: balance ].

    ^balance.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'DS 11/8/2020 20:56:19'!
hasBankRecord: aBankRecord

	^self = aBankRecord.! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'Federico 11/7/2020 16:15:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'adding' stamp: 'DS 11/8/2020 19:09:51'!
addTo: aPortfolio

	aPortfolio addSecure: self.! !


!classDefinition: #ParentPortfolio category: 'Portfolio-Ejercicio'!
Object subclass: #ParentPortfolio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ParentPortfolio methodsFor: 'roots' stamp: 'DS 11/8/2020 21:06:19'!
roots

	self subclassResponsibility.! !


!ParentPortfolio methodsFor: 'adding' stamp: 'DS 11/8/2020 21:05:37'!
addParent: aParentPortfolio

	self subclassResponsibility.! !


!classDefinition: #CollectionParentPortfolio category: 'Portfolio-Ejercicio'!
ParentPortfolio subclass: #CollectionParentPortfolio
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!CollectionParentPortfolio methodsFor: 'initialization' stamp: 'DS 11/8/2020 21:04:13'!
initializeAdding: aParentPortfolio

	parents := OrderedCollection with: aParentPortfolio.! !


!CollectionParentPortfolio methodsFor: 'roots' stamp: 'DS 11/8/2020 19:39:31'!
roots

	^(parents collect: [ :parentPortfolio | parentPortfolio rootPortfolios ]) flatten.! !


!CollectionParentPortfolio methodsFor: 'adding' stamp: 'DS 11/8/2020 19:38:50'!
addParent: aParentPortfolio

	parents add: aParentPortfolio.
	^self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CollectionParentPortfolio class' category: 'Portfolio-Ejercicio'!
CollectionParentPortfolio class
	instanceVariableNames: ''!

!CollectionParentPortfolio class methodsFor: 'instance creation' stamp: 'DS 11/8/2020 21:03:53'!
adding: aParentPortfolio

	^self new initializeAdding: aParentPortfolio.! !


!classDefinition: #RootParentPortfolio category: 'Portfolio-Ejercicio'!
ParentPortfolio subclass: #RootParentPortfolio
	instanceVariableNames: 'root'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!RootParentPortfolio methodsFor: 'initialization' stamp: 'DS 11/8/2020 21:04:45'!
initializateFor: aPortfolio

	root := aPortfolio.! !


!RootParentPortfolio methodsFor: 'adding' stamp: 'DS 11/8/2020 21:03:35'!
addParent: aParentPortfolio

	^CollectionParentPortfolio adding: aParentPortfolio.! !


!RootParentPortfolio methodsFor: 'roots' stamp: 'DS 11/8/2020 21:04:58'!
roots

	^OrderedCollection with: root.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RootParentPortfolio class' category: 'Portfolio-Ejercicio'!
RootParentPortfolio class
	instanceVariableNames: ''!

!RootParentPortfolio class methodsFor: 'instance creation' stamp: 'DS 11/8/2020 19:44:38'!
for: aPortfolio

	^self new initializateFor: aPortfolio.! !
