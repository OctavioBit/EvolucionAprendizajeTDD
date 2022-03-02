!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'registered transactions - testing' stamp: 'CS 5/25/2021 12:02:31'!
test07PortfolioKnowsRegisteredTransactionsOfYourAccount

	| portfolio account deposit |

	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 50 on: account.
	portfolio add: account.

	self assert: (portfolio hasRegistered: deposit).! !

!PortfolioTest methodsFor: 'registered transactions - testing' stamp: 'CS 5/25/2021 14:23:12'!
test08PortfolioKnowsRegisteredTransactionsOfYourPortfolios

self createAnInstanceOfFinancialAssetsAndTest: [:portfolio1 : deposit1 :deposit2 :withdraw |
	self assert: (portfolio1 hasRegistered: deposit1).
	self assert: (portfolio1 hasRegistered: deposit2).
	self assert: (portfolio1 hasRegistered: withdraw)]! !

!PortfolioTest methodsFor: 'registered transactions - testing' stamp: 'CS 5/25/2021 12:16:28'!
test09PortfolioDoNotKnowNotRegisteredTransactions

	| portfolio account deposit |

	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 50 on: account.

	self deny: (portfolio hasRegistered: deposit).! !


!PortfolioTest methodsFor: 'balance - testing' stamp: 'CS 5/25/2021 10:26:25'!
test01PortfolioHaveZeroAsBalanceWhenCreated

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: portfolio balance equals: 0! !

!PortfolioTest methodsFor: 'balance - testing' stamp: 'CS 5/25/2021 14:44:45'!
test02AddAnAccountToPortfolioIncreasesBalanceOnTransactionsValues

	| portfolio |

	portfolio := self createPortfolioWithAccount1.

	self assert: portfolio balance equals: 100.! !

!PortfolioTest methodsFor: 'balance - testing' stamp: 'CS 5/25/2021 14:51:52'!
test03AddManyAccountsToPortfolioIncreasesBalanceOnTransactionsValues

	| portfolio account2 |

	portfolio := self createPortfolioWithAccount1.
	account2 := self createAccount2.

	portfolio add: account2.
	
	self assert: portfolio balance equals: 125! !

!PortfolioTest methodsFor: 'balance - testing' stamp: 'CS 5/25/2021 14:51:55'!
test04AddAPortfolioToPortfolioIncreasesBalanceWithYourBalance

	| portfolio1 portfolio2 |

	portfolio1 := Portfolio new.
	portfolio2 := self createPortfolioWithAccount1.

	portfolio1 add: portfolio2.	
	
	self assert: portfolio1 balance equals: 100! !

!PortfolioTest methodsFor: 'balance - testing' stamp: 'CS 5/25/2021 14:51:44'!
test05AddManyPortfoliosToPortfolioIncreasesBalanceWithYoursBalances

	| portfolio1 portfolio2 portfolio3 |

	portfolio1 := Portfolio new.

	portfolio2 := self createPortfolioWithAccount1.
	portfolio3 := self createPortfolioWithAccount2.
	
	portfolio1 add: portfolio2.	
	portfolio1 add: portfolio3.	

	self assert: portfolio1 balance equals: 125! !

!PortfolioTest methodsFor: 'balance - testing' stamp: 'CS 5/25/2021 14:51:37'!
test06AddAccountsAndPortfoliosToPortfolioIncreasesBalanceWithTheTransactionsValuesAndBalances

	| portfolio1 portfolio2 portfolio3 account3 |

	portfolio1 := Portfolio new.
	
	portfolio2 := self createPortfolioWithAccount1.
	portfolio3 := self createPortfolioWithAccount2.
	account3 := self createAccount3.

	portfolio1 add: portfolio2.	
	portfolio1 add: portfolio3.	
	portfolio1 add: account3.

	self assert: portfolio1 balance equals: 221! !


!PortfolioTest methodsFor: 'transactions - testing' stamp: 'CS 5/25/2021 12:14:20'!
test10PortfolioKnowsYourAccountTransactions

	| portfolio account deposit |

	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 50 on: account.
	portfolio add: account.

	self assert: 1 equals: portfolio transactions size.
	self assert: (portfolio transactions includes: deposit).! !

!PortfolioTest methodsFor: 'transactions - testing' stamp: 'CS 5/25/2021 14:24:01'!
test11PortfolioKnowsYourPortfoliosTransactions

self createAnInstanceOfFinancialAssetsAndTest: [:portfolio1 : deposit1 :deposit2 :withdraw |
	self assert: 3 equals: portfolio1 transactions size.
	self assert: (portfolio1 hasRegistered: deposit1).
	self assert: (portfolio1 hasRegistered: deposit2).
	self assert: (portfolio1 hasRegistered: withdraw)].! !

!PortfolioTest methodsFor: 'transactions - testing' stamp: 'CS 5/25/2021 18:24:21'!
test12PortfolioDoNotKnowsYourAccountTransactions

	| portfolio account deposit |

	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 50 on: account.

	self deny: (portfolio transactions includes: deposit).! !


!PortfolioTest methodsFor: 'information duplication - testing' stamp: 'CS 5/25/2021 18:24:35'!
test13WhenAPortfolioIsModifiedItCanNotGenerateDuplicationOfInformation

	| portfolio1 portfolio2 account2 portfolio3 |
	
	portfolio1 := Portfolio new.

	portfolio2 := Portfolio new.
	account2 := self createAccount2.
	portfolio2 add: account2.

	portfolio3 := self createPortfolioWithAccount1.
	
	portfolio1 add: portfolio3.
	portfolio2 add: portfolio3.
	
self should: [portfolio3 add: account2.]
		raise: Error
		withMessageText: Portfolio describeErrorCantHaveRepeated.! !


!PortfolioTest methodsFor: 'accounts create' stamp: 'CS 5/25/2021 12:28:26'!
createAccount1

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	^ account.! !

!PortfolioTest methodsFor: 'accounts create' stamp: 'CS 5/25/2021 12:30:23'!
createAccount2

	| account2 |
	
	account2 := ReceptiveAccount new.
	Deposit register: 50 on: account2.
	Withdraw register: 25 on: account2.
	
	^ account2.! !

!PortfolioTest methodsFor: 'accounts create' stamp: 'CS 5/25/2021 13:39:01'!
createAccount3

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 200 on: account.
	Withdraw register: 104 on: account.
	
	^ account.! !


!PortfolioTest methodsFor: 'create instance for testing' stamp: 'CS 5/25/2021 14:21:04'!
createAnInstanceOfFinancialAssetsAndTest: aBlockWithAsserts 

	| portfolio1 portfolio2 portfolio3 account1 account2 deposit1 deposit2 withdraw |

	portfolio1 := Portfolio new.

	portfolio2 := Portfolio new.
	account1 := ReceptiveAccount new.
	deposit1 := Deposit register: 50 on: account1.
	portfolio2 add: account1.

	portfolio3 := Portfolio new.
	account2 := ReceptiveAccount new.
	deposit2 := Deposit register: 100 on: account2.
	withdraw := Withdraw register: 25 on: account2.
	portfolio3 add: account2.
	
	portfolio1 add: portfolio2.	
	portfolio1 add: portfolio3.
	
	aBlockWithAsserts value: portfolio1 value: deposit1 value: deposit2 value: withdraw.! !


!PortfolioTest methodsFor: 'portfolios create' stamp: 'CS 5/25/2021 14:45:24'!
createPortfolioWithAccount1

	| account1 portfolio |
	
	portfolio := Portfolio new.
	
	account1 := self createAccount1.

	portfolio add: account1.
	
	^ portfolio.! !

!PortfolioTest methodsFor: 'portfolios create' stamp: 'CS 5/25/2021 14:49:38'!
createPortfolioWithAccount2

	| account2 portfolio |
	
	portfolio := Portfolio new.
	
	account2 := self createAccount2.
	
	portfolio add: account2.
	
	^ portfolio.! !


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


!AccountTransaction methodsFor: 'balance' stamp: 'CS 5/22/2021 17:38:48'!
modifyTheBalance: actualBalance

	self subclassResponsibility! !

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


!Deposit methodsFor: 'balance' stamp: 'CS 5/22/2021 17:38:20'!
modifyTheBalance: actualBalance

	^ actualBalance + value! !

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


!Withdraw methodsFor: 'balance' stamp: 'CS 5/22/2021 17:38:32'!
modifyTheBalance: actualBalance

	^ actualBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialAssets category: 'Portfolio-Ejercicio'!
Object subclass: #FinancialAssets
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialAssets methodsFor: 'balance' stamp: 'CS 5/25/2021 09:51:59'!
balance

	self subclassResponsibility! !


!FinancialAssets methodsFor: 'testing' stamp: 'CS 5/25/2021 09:52:28'!
hasRegistered: aTransaction

	self subclassResponsibility! !

!FinancialAssets methodsFor: 'testing' stamp: 'CS 5/25/2021 11:50:36'!
includes: aFinancialAssents

	self subclassResponsibility! !


!FinancialAssets methodsFor: 'transactions' stamp: 'CS 5/25/2021 09:52:46'!
transactions

	self subclassResponsibility! !


!FinancialAssets methodsFor: 'parents' stamp: 'CS 5/25/2021 11:49:09'!
addParent: aPortfolio

	self subclassResponsibility! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialAssets subclass: #Portfolio
	instanceVariableNames: 'transactions childrens parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'CS 5/25/2021 09:54:36'!
balance

	^ childrens sum: [: aChild | aChild balance] ifEmpty: 0.! !


!Portfolio methodsFor: 'add' stamp: 'CS 5/25/2021 10:09:41'!
add: aFinancialAssents

	| parentsRoots |

	parentsRoots := self parentsRoots.

	self checkIf: parentsRoots include: aFinancialAssents.
	
	aFinancialAssents addParent: self.
	childrens addLast: aFinancialAssents.! !


!Portfolio methodsFor: 'initialization' stamp: 'CS 5/25/2021 09:54:06'!
initialize
	
	transactions := OrderedCollection new.
	childrens := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'testing' stamp: 'CS 5/25/2021 09:55:28'!
hasRegistered: aTransaction

	^ childrens anySatisfy: [ : aChild | aChild hasRegistered: aTransaction].! !


!Portfolio methodsFor: 'transactions' stamp: 'CS 5/25/2021 09:55:46'!
transactions

	childrens do: [ :aChild | transactions addAllLast: (aChild transactions) ].

	^ transactions! !


!Portfolio methodsFor: 'parents' stamp: 'CS 5/25/2021 09:56:36'!
addParent: aPortfolio

	parents addLast: aPortfolio! !

!Portfolio methodsFor: 'parents' stamp: 'CS 5/25/2021 10:11:06'!
parentsRoots

	| roots |
	
	roots := OrderedCollection new.
										
	(parents isEmpty) ifTrue: [roots addLast: self]
			    	    ifFalse:	[parents do: [:aParent | roots addAllLast: (aParent parentsRoots)]].
	^ roots! !


!Portfolio methodsFor: 'checks to add' stamp: 'CS 5/25/2021 09:59:32'!
checkChildrensInclusion: aFinancialAssents
	
	^ childrens anySatisfy: [ :aChild | (aChild includes: aFinancialAssents) or: (aFinancialAssents includes: aChild)].! !

!Portfolio methodsFor: 'checks to add' stamp: 'CS 5/25/2021 10:24:14'!
checkIf: aParentsRoots include: aFinancialAssents

	^ (aParentsRoots anySatisfy: [:aRoot | (aRoot includes: aFinancialAssents)]) 
							    		     ifTrue: [^Error signal: self class describeErrorCantHaveRepeated].! !

!Portfolio methodsFor: 'checks to add' stamp: 'CS 5/25/2021 09:58:54'!
checkRootInclusion: aFinancialAssents

	^ aFinancialAssents = self! !

!Portfolio methodsFor: 'checks to add' stamp: 'CS 5/25/2021 09:58:36'!
includes: aFinancialAssents

	 ^ (self checkRootInclusion: aFinancialAssents) or: 	(self checkChildrensInclusion: aFinancialAssents).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'describe error' stamp: 'CS 5/25/2021 09:49:04'!
describeErrorCantHaveRepeated

	^ 'Adding it generates duplication of information'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialAssets subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'CS 5/25/2021 10:02:31'!
initialize

	transactions := OrderedCollection new.
	parents := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'CS 5/22/2021 17:39:32'!
balance

	^ transactions inject: 0
	   into: [:actualBalance  :aTransaction | aTransaction modifyTheBalance: actualBalance]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'parents' stamp: 'CS 5/25/2021 10:03:22'!
addParent: aPortfolio

	parents addLast: aPortfolio! !

!ReceptiveAccount methodsFor: 'parents' stamp: 'CS 5/25/2021 10:03:10'!
includes: aFinancialAssents

	^ (aFinancialAssents = self)! !
