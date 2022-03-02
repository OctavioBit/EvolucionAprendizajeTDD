!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'adding accounts' stamp: 'LH 11/9/2020 14:15:17'!
test01AnAccountCanBeAddedToAPortfolio

	"una cuenta puede ser agregada a un prtfolio"

	|anAccount aPortfolio|
	
	anAccount :=  ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	
	aPortfolio := Portfolio new.
	aPortfolio addAccount: anAccount.
	
	self assert: (aPortfolio includes: anAccount).
! !

!PortfolioTest methodsFor: 'adding accounts' stamp: 'LH 11/9/2020 14:15:51'!
test02APortfolioHasNoAccountsInitially
	"un portfolio no tiene cuentas inicialmente"

	|anAccount1 aPortfolio|
	
	anAccount1 :=  ReceptiveAccount new.
	Deposit register: 100 on: anAccount1.
	
	aPortfolio := Portfolio new.

	self deny: (aPortfolio includes: anAccount1).
! !

!PortfolioTest methodsFor: 'adding accounts' stamp: 'LH 11/9/2020 14:16:11'!
test03APortfolioDoesNotHaveMoreAccountsThanAdded

	"una cuenta que no fue agregada a un portfolio no esta en un portfolio"

	|anAccount1 anAccount2 aPortfolio|
	
	anAccount1 :=  ReceptiveAccount new.
	Deposit register: 100 on: anAccount1.
	anAccount2 :=  ReceptiveAccount new.
	Deposit register: 200 on: anAccount2.
	
	aPortfolio := Portfolio new.
	aPortfolio addAccount: anAccount1.

	self deny: (aPortfolio includes: anAccount2).
! !

!PortfolioTest methodsFor: 'adding accounts' stamp: 'LH 11/9/2020 14:16:32'!
test04MoreThanOneAccountCanBeAddedToAPortfolio

	"se puede agregar mas de una cuenta a un portfolio"

	|anAccount1 anAccount2 aPortfolio|
	
	anAccount1 :=  ReceptiveAccount new.
	Deposit register: 100 on: anAccount1.
	anAccount2 :=  ReceptiveAccount new.
	Deposit register: 200 on: anAccount2.
	
	aPortfolio := Portfolio new.
	aPortfolio addAccount: anAccount1.
	aPortfolio addAccount: anAccount2.
	
	self assert: (aPortfolio includes: anAccount1).
	self assert: (aPortfolio includes: anAccount2).
! !


!PortfolioTest methodsFor: 'adding portfolios' stamp: 'LH 11/8/2020 21:35:47'!
test05APortfolioDoesNotHavePortfoliosInitialy
	
	"un portfolio no tiene portfolios inicialmente"
	
	| portfolio1 portfolio2 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	self deny: (portfolio1 includes: portfolio2).
! !

!PortfolioTest methodsFor: 'adding portfolios' stamp: 'LH 11/8/2020 21:35:52'!
test06AnEmptyPortfolioCanBeAddedToAPortfolio
	
	"a un portfolio se le puede agregar un portfolio sin cuentas"
	
	| portfolio1 portfolio2 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	portfolio1 addPortfolio: portfolio2.
	
	self assert: (portfolio1 includes: portfolio2).
! !

!PortfolioTest methodsFor: 'adding portfolios' stamp: 'LH 11/8/2020 21:35:58'!
test07VariousEmptyPortfoliosCanBeAddedToAPortfolio
	
	"a un portfolio se le puede agregar mas de un portfolio sin cuentas"
	
	| portfolio1 portfolio2 portfolio3 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	
	portfolio1 addPortfolio: portfolio2.
	portfolio1 addPortfolio: portfolio3.
	
	self assert: (portfolio1 includes: portfolio2).
	self assert: (portfolio1 includes: portfolio3).
! !

!PortfolioTest methodsFor: 'adding portfolios' stamp: 'LH 11/8/2020 21:35:36'!
test08PortfoliosCanBeAddedToAPortfolio
	
	"a un portfolio se le pueden agregar portfolios"
	
	| portfolio1 portfolio2 portfolio3 portfolio4 account1 account2 account3 account4 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	portfolio4 := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	account4 := ReceptiveAccount new.
	
	portfolio1 addPortfolio: portfolio2.
	portfolio1 addPortfolio: portfolio3.
	portfolio2 addPortfolio: portfolio4. "portfolio anidado"
	
	portfolio2 addAccount: account1.
	portfolio2 addAccount: account2.
	portfolio3 addAccount: account3.
	portfolio4 addAccount: account4.
	
	self assert: (portfolio1 includes: account1).
	self assert: (portfolio1 includes: account2).
	self assert: (portfolio1 includes: account3).
	self assert: (portfolio1 includes: account4).
! !

!PortfolioTest methodsFor: 'adding portfolios' stamp: 'LH 11/8/2020 21:36:02'!
test09APortfolioWithPortfoliosCanBeAddedToAportfolio
	
	"a un portfolio se le pueden agregar portfolios con portfolios"
	
	| portfolio1 portfolio2 portfolio3 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.

	portfolio1 addPortfolio: portfolio2.
	portfolio2 addPortfolio: portfolio3.

	self assert: (portfolio1 includes: portfolio3).

! !


!PortfolioTest methodsFor: 'errors adding accounts by children' stamp: 'LH 11/7/2020 21:22:42'!
test10CanNotAddAnAccountToAPortfolioWhosePortfolioHasTheAccount
	
	"no se pueden agregar una cueanta a un portfolio (padre) con un portfolio (hijo), cuando la cuenta ya estaba en el portfolio (hijo)"
	
	| portfolio1 portfolio2 account1 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	account1 := ReceptiveAccount new.
	
	portfolio2 addAccount: account1.
	portfolio1 addPortfolio: portfolio2.

	self should: [	portfolio1 addAccount: account1.] raise: Error withMessageText: Portfolio errorMessageAccountAlreadyAdded.
! !

!PortfolioTest methodsFor: 'errors adding accounts by children' stamp: 'LH 11/7/2020 21:23:19'!
test11CanNotAddAnAccountToAPortfolioWhoHasAPortfolioWithTheAccount
	
	"no se pueden agregar una cueanta a un portfolio (padre) con un portfolio (hijo) con un portfolio (nieto), cuando la cuenta ya estaba en el portfolio (nieto)"
	
	| portfolio1 portfolio2 portfolio3 account1 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.	

	account1 := ReceptiveAccount new.
	
	portfolio3 addAccount: account1.
	portfolio1 addPortfolio: portfolio2.
	portfolio2 addPortfolio: portfolio3.

	self should: [	portfolio1 addAccount: account1.] raise: Error withMessageText: Portfolio errorMessageAccountAlreadyAdded.
! !


!PortfolioTest methodsFor: 'errors adding portfolios by childern' stamp: 'LH 11/7/2020 21:20:31'!
test12APortfolioCantHaveRepeatedAccounts
	
	"no pueden haber cuentas repetidas en un portfolio"
	
	| portfolio1 portfolio2 account1 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	account1 := ReceptiveAccount new.
	
	portfolio1 addPortfolio: portfolio2.
	portfolio2 addAccount: account1.

	
	self should: [portfolio1 addAccount: account1] raise: Error withMessageText: Portfolio errorMessageAccountAlreadyAdded.

! !

!PortfolioTest methodsFor: 'errors adding portfolios by childern' stamp: 'LH 11/7/2020 21:20:56'!
test13APortfolioCanNotHaveRepeatedPortfolios
	
	"no pueden haber prtfolios repetidos en un portfolio"
	
	| portfolio1 portfolio2 portfolio3 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	
	portfolio1 addPortfolio: portfolio2.
	portfolio2 addPortfolio: portfolio3.

	self should: [portfolio1 addPortfolio: portfolio3] raise: Error withMessageText: Portfolio errorMessagePortfolioAlreadyAdded.

! !

!PortfolioTest methodsFor: 'errors adding portfolios by childern' stamp: 'LH 11/7/2020 22:13:32'!
test14APortffolioCantHaveItself
	"un portfolio no se puede tener a si mismo"
	
	| portfolio1 |
	
	portfolio1 := Portfolio new.
	
	self should: [portfolio1 addPortfolio: portfolio1] raise: Error withMessageText: Portfolio errorMessagePortfolioAlreadyAdded.
! !


!PortfolioTest methodsFor: 'errors adding accounts by parents' stamp: 'LH 11/7/2020 21:24:41'!
test15CanNotAddAnAccountToAPortfolioWithAParentThatHasTheAccount
	
	"no se pueden agregar una cueanta a un portfolio (hijo) de un portfolio (padre), cuando la cuenta ya estaba en el portfolio (padre), con varios padres"
	
	| portfolio1 portfolio2 portfolio3 account1 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	
	account1 := ReceptiveAccount new.
	
	portfolio2 addAccount: account1.
	portfolio2 addPortfolio: portfolio3.
	portfolio1 addPortfolio: portfolio3.

	self should: [	portfolio3 addAccount: account1.] raise: Error withMessageText: Portfolio errorMessageAccountAlreadyAdded.
! !

!PortfolioTest methodsFor: 'errors adding accounts by parents' stamp: 'LH 11/7/2020 22:16:09'!
test16CanNotAddAnAccountToAPortfolioWhoseParentHasTheAccount
	
	"no se pueden agregar una cueanta a un portfolio (hijo) de un portfolio (padre), cuando la cuenta ya estaba en el portfolio (padre)"
	
	| portfolio1 portfolio2 account1 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	account1 := ReceptiveAccount new.
	
	portfolio1 addAccount: account1.
	portfolio1 addPortfolio: portfolio2.

	self should: [	portfolio2 addAccount: account1.] raise: Error withMessageText: Portfolio errorMessageAccountAlreadyAdded.
! !

!PortfolioTest methodsFor: 'errors adding accounts by parents' stamp: 'LH 11/7/2020 22:16:14'!
test17CanNotAddAnAccountToAPortfolioWithAPredecesorsThatHasTheAccount
	
	"no se pueden agregar una cueanta a un hijo si esa cuenta está en el padre de su padre"
	
	| portfolio1 portfolio2 portfolio3 account1 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	
	account1 := ReceptiveAccount new.
	
	portfolio1 addAccount: account1.
	portfolio1 addPortfolio: portfolio2.
	portfolio2 addPortfolio: portfolio3.

	self should: [	portfolio3 addAccount: account1.] raise: Error withMessageText: Portfolio errorMessageAccountAlreadyAdded.
! !


!PortfolioTest methodsFor: 'errors adding portfolios by parents' stamp: 'LH 11/7/2020 22:16:21'!
test18CantAddAPortfolioWhenItIsAParent
	
	"
		no se pueden agregar un portfolio cuando el padre ya tiene ese portfolio
		p1 ->  p2 -> p1
	"
	
	| portfolio1 portfolio2 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.

	portfolio1 addPortfolio: portfolio2.

	self should: [	portfolio2 addPortfolio: portfolio1.] raise: Error withMessageText: Portfolio errorMessagePortfolioAlreadyAdded.
! !

!PortfolioTest methodsFor: 'errors adding portfolios by parents' stamp: 'LH 11/7/2020 22:18:37'!
test19CantAddAPortfolioWhenItIsAPredecesor
	
	"
		no se pueden agregar un portfolio cuando el padre del padre ya tiene ese portfolio
		p1 ->  p2 -> p3 -> p1
	"
	
	| portfolio1 portfolio2 portfolio3 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.

	portfolio1 addPortfolio: portfolio2.
	portfolio2 addPortfolio: portfolio3.

	self should: [	portfolio3 addPortfolio: portfolio1.] raise: Error withMessageText: Portfolio errorMessagePortfolioAlreadyAdded.
! !

!PortfolioTest methodsFor: 'errors adding portfolios by parents' stamp: 'LH 11/7/2020 22:18:32'!
test20CantAddAPortfolioWhenAPredecesorAlredyHasIt
	
	"
		no se pueden agregar un portfolio cuando el padre del padre ya tiene ese portfolio
		p1 ->  p2
		p1 ->  p3 -> p2
	"
	
	| portfolio1 portfolio2 portfolio3 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.

	portfolio1 addPortfolio: portfolio2.
	portfolio1 addPortfolio: portfolio3.

	self should: [	portfolio3 addPortfolio: portfolio2.] raise: Error withMessageText: Portfolio errorMessagePortfolioAlreadyAdded.
! !

!PortfolioTest methodsFor: 'errors adding portfolios by parents' stamp: 'IO 11/8/2020 19:55:02'!
test35CanNotAddAPortfolioWithAccountsInFirstLevelAlredyInTheParentsOfTheReceiver
	
	"
		no se pueden agregar un portfolio que tiene cuentas en si mismo repetidas en los padres del receptor 
		p1 [a1] x> p4 [a1]
	"
	
	| portfolio1 portfolio2 account1 |
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account1 := ReceptiveAccount new.
	
	portfolio1 addAccount: account1.
	portfolio2 addAccount: account1.

	self should: [	portfolio1 addPortfolio: portfolio2.] raise: Error withMessageText: Portfolio errorMessageAccountAlreadyAdded.
! !

!PortfolioTest methodsFor: 'errors adding portfolios by parents' stamp: 'IO 11/8/2020 19:56:30'!
test36CanNotAddAPortfolioWithAccountsInDeeperLevelAlredyInTheParentsOfTheReceiver
	
	"
		no se pueden agregar un portfolio que tiene cuentas en sus portfolios repetidas en los padres del receptor 
		p1 [a1] x> p3 -> p4 [a1]
	"
	
	| portfolio1 portfolio2 portfolio3 account1 |
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	account1 := ReceptiveAccount new.
	
	portfolio1 addAccount: account1.
	portfolio2 addPortfolio: portfolio3.
	portfolio3 addAccount: account1.

	self should: [	portfolio1 addPortfolio: portfolio2.] raise: Error withMessageText: Portfolio errorMessageAccountAlreadyAdded.
! !


!PortfolioTest methodsFor: 'accounts' stamp: 'LH 11/7/2020 22:18:22'!
test22APortfolioKnowsItsDirectAccounts
	
	"un portfolio expone sus cuentas"
	
	| portfolio1 account1 account2 |
	
	portfolio1 := Portfolio new.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	portfolio1 addAccount: account1.
	portfolio1 addAccount: account2.	

	self assert: (portfolio1 accounts includesAllOf: (OrderedCollection with: account1 with: account2)).

	
! !

!PortfolioTest methodsFor: 'accounts' stamp: 'LH 11/7/2020 22:18:17'!
test22APortfolioKnowsTheAccountsOfHisPortfolios
	
	"un portfolio expone las cuentas de sus portfolios"
	
	| portfolio1 portfolio2 portfolio3 portfolio4 account1 account2 account3 account4 |

	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	portfolio4 := Portfolio new.

	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.	
	account4 := ReceptiveAccount new.	

	portfolio2 addAccount: account1.
	portfolio2 addAccount: account2.	
	portfolio3 addAccount: account3.
	portfolio4 addAccount: account4.

	portfolio1 addPortfolio: portfolio2.
	portfolio1 addPortfolio: portfolio3.
	portfolio2 addPortfolio: portfolio4.

	self assert: (portfolio1 accounts includesAllOf: (OrderedCollection with: account1 with: account2 with: account3 with: account4)).

	
! !


!PortfolioTest methodsFor: 'balance' stamp: 'LH 11/7/2020 22:18:10'!
test23AnEmptyPortfolioHasABalanceOf0

	"un portfolio vacio responde balance 0"

	| portfolio1 |

	portfolio1 := Portfolio new.

	self assert: (portfolio1 balance) equals: 0.
! !

!PortfolioTest methodsFor: 'balance' stamp: 'LH 11/7/2020 22:18:06'!
test24APortfolioWithOneAccountHasTheBalanceOfThatAccount

	"un portfolio reponde por el balance de su unico hijo"

	| portfolio1 account1 |
	
	account1 := ReceptiveAccount new.
	
	Deposit register: 100 on: account1.
	Withdraw register: 50 on: account1.

	portfolio1 := Portfolio new.

	portfolio1 addAccount: account1.

	self assert: (portfolio1 balance) equals: 50.
! !

!PortfolioTest methodsFor: 'balance' stamp: 'LH 11/7/2020 22:18:02'!
test25TheBalanceOfAPortfolioWithNoPortfoliosIsTheSumOfHisAccounts

	"un portfolio reponde por el balance de sus hijos"

	| portfolio1 account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	Deposit register: 100 on: account1.
	Withdraw register: 50 on: account1.
	Deposit register: 100 on: account2.

	portfolio1 := Portfolio new.

	portfolio1 addAccount: account1.
	portfolio1 addAccount: account2.

	self assert: (portfolio1 balance) equals: 150.
! !

!PortfolioTest methodsFor: 'balance' stamp: 'LH 11/7/2020 22:17:55'!
test26TheBalanceOfAPortfolioIsTheSumOfHisAccountsAndPortfolios

	"un portfolio reponde por el balance de los hijos de sus portfolios"

	| portfolio1 portfolio2 account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	Deposit register: 100 on: account1.
	Withdraw register: 50 on: account1.
	Deposit register: 100 on: account2.

	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.

	portfolio1 addPortfolio: portfolio2.

	portfolio2 addAccount: account1.
	portfolio2 addAccount: account2.

	self assert: (portfolio1 balance) equals: 150.
! !


!PortfolioTest methodsFor: 'has registered' stamp: 'LH 11/7/2020 22:17:47'!
test27AnEmptyPortfolioHasNoRegisteredTransactions

	"un portfolio vacio no registro ninguna transaccion"
	
	| deposit withdraw portfolio1 |
	
	portfolio1 := Portfolio new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (portfolio1 hasRegistered: deposit).
	self deny: (portfolio1 hasRegistered:withdraw).
! !

!PortfolioTest methodsFor: 'has registered' stamp: 'LH 11/7/2020 22:17:37'!
test28APortfolioWithOneAccountHasItsRegisteredTransactions

	"un portfolio con una cuenta registro sus transacciones"
	
	| deposit withdraw account1 portfolio1 |
	
	account1 := ReceptiveAccount new.
	deposit :=  Deposit register: 100 on: account1.
	withdraw := Withdraw register: 50 on: account1.
	
	portfolio1 := Portfolio new.
	portfolio1 addAccount: account1.

	self assert: (portfolio1 hasRegistered: deposit).
	self assert: (portfolio1 hasRegistered:withdraw).
! !

!PortfolioTest methodsFor: 'has registered' stamp: 'LH 11/7/2020 22:17:29'!
test29APortfolioWithManyAccountsHasItsAccountsRegisteredTransactions

	"un portfolio con varias cuentas registro todas sus transacciones"
	
	| deposit1 deposit2 withdraw1 withdraw2 account1 account2 portfolio1 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	deposit1 :=  Deposit register: 100 on: account1.
	withdraw1 := Withdraw register: 50 on: account1.
	deposit2 :=  Deposit register: 30 on: account2.
	withdraw2 := Withdraw register: 20 on: account2.

	portfolio1 := Portfolio new.
	portfolio1 addAccount: account1.
	portfolio1 addAccount: account2.

	self assert: (portfolio1 hasRegistered: deposit1).
	self assert: (portfolio1 hasRegistered:withdraw1).
	self assert: (portfolio1 hasRegistered: deposit2).
	self assert: (portfolio1 hasRegistered:withdraw2).
! !

!PortfolioTest methodsFor: 'has registered' stamp: 'LH 11/7/2020 22:17:22'!
test30APortfolioHasItsPortfoliosAndAccountsRegisteredTransactions

	"un portfolio con varias cuentas en sus portfolios registro todas sus transacciones"
	
	| deposit1 deposit2 withdraw1 withdraw2 account1 account2 portfolio1 portfolio2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	deposit1 :=  Deposit register: 100 on: account1.
	withdraw1 := Withdraw register: 50 on: account1.
	deposit2 :=  Deposit register: 30 on: account2.
	withdraw2 := Withdraw register: 20 on: account2.

	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.

	portfolio1 addAccount: account1.
	portfolio1 addAccount: account2.
	
	portfolio2 addPortfolio: portfolio1.

	self assert: (portfolio2 hasRegistered: deposit1).
	self assert: (portfolio2 hasRegistered:withdraw1).
	self assert: (portfolio2 hasRegistered: deposit2).
	self assert: (portfolio2 hasRegistered:withdraw2).
! !


!PortfolioTest methodsFor: 'transactions' stamp: 'LH 11/7/2020 22:17:11'!
test31AnEmptyPortfolioHasNoTransactions

	"un portfolio vacio no tiene transacciones"
	
	| portfolio1 |
	
	portfolio1 := Portfolio new.
		
	self assert: (portfolio1 transactions size) equals: 0.

! !

!PortfolioTest methodsFor: 'transactions' stamp: 'LH 11/7/2020 22:17:01'!
test32APortfolioWithOneAccountHasItsTransactions

	"un portfolio con una cuenta retorna sus transacciones"
	
	| deposit withdraw account1 portfolio1 |
	
	account1 := ReceptiveAccount new.
	deposit :=  Deposit register: 100 on: account1.
	withdraw := Withdraw register: 50 on: account1.
	
	portfolio1 := Portfolio new.
	portfolio1 addAccount: account1.

	self assert: (portfolio1 transactions includesAllOf: (OrderedCollection with: deposit with: withdraw)).

! !

!PortfolioTest methodsFor: 'transactions' stamp: 'LH 11/7/2020 22:16:55'!
test33APortfolioWithManyAccountsHasItsAccountsTransactions

	"un portfolio con varias cuentas retorna todas sus transacciones"
	
	| deposit1 deposit2 withdraw1 withdraw2 account1 account2 portfolio1 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	deposit1 :=  Deposit register: 100 on: account1.
	withdraw1 := Withdraw register: 50 on: account1.
	deposit2 :=  Deposit register: 30 on: account2.
	withdraw2 := Withdraw register: 20 on: account2.

	portfolio1 := Portfolio new.
	portfolio1 addAccount: account1.
	portfolio1 addAccount: account2.

	self assert: (portfolio1 transactions includesAllOf: (OrderedCollection with: deposit1 with: withdraw1 with: deposit2 with: withdraw2)).

! !

!PortfolioTest methodsFor: 'transactions' stamp: 'LH 11/7/2020 22:16:38'!
test34APortfolioHasItsPortfoliosAndAccountsTransaction

	"un portfolio con varias cuentas en sus portfolios retorna todas sus transacciones"
	
	| deposit1 deposit2 withdraw1 withdraw2 account1 account2 portfolio1 portfolio2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	deposit1 :=  Deposit register: 100 on: account1.
	withdraw1 := Withdraw register: 50 on: account1.
	deposit2 :=  Deposit register: 30 on: account2.
	withdraw2 := Withdraw register: 20 on: account2.

	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.

	portfolio1 addAccount: account1.
	portfolio1 addAccount: account2.
	
	portfolio2 addPortfolio: portfolio1.

	self assert: (portfolio2 transactions includesAllOf: (OrderedCollection with: deposit1 with: withdraw1 with: deposit2 with: withdraw2)).

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
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'balance operations' stamp: 'IO 11/8/2020 18:04:58'!
addToBalance: aBalance

	"returns the resulting balance after aplying the net value of this transaction"	

	self subclassResponsibility.
! !


!AccountTransaction methodsFor: 'accessing' stamp: 'IO 11/8/2020 18:08:05'!
value

	"returns the value of a transaction. it is always postitive, it is not the net value"

	^value.

! !


!AccountTransaction methodsFor: 'initialization' stamp: 'IO 11/8/2020 18:07:39'!
initializeFor: aValue

	"initialize a transaction with a given value"

	value := aValue.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'IO 11/8/2020 18:18:49'!
for: aValue

	"create a transaction. use register:on: to create it for an account"

	^self new initializeFor: aValue.
! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'IO 11/8/2020 18:17:29'!
register: aValue on: account

	"create a transaction and register it in an account"

	| transaction |

	transaction := self for: aValue.
	account register: transaction.

	^transaction.
! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'balance operations' stamp: 'IO 11/8/2020 18:09:12'!
addToBalance: aBalance

	"see superclass"

	^aBalance + value.
! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'balance operations' stamp: 'IO 11/8/2020 18:09:19'!
addToBalance: aBalance

	"see superclass"

	^aBalance - value.
! !


!classDefinition: #ParentPortfolios category: 'Portfolio-Ejercicio'!
Object subclass: #ParentPortfolios
	instanceVariableNames: 'childPortfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ParentPortfolios methodsFor: 'validations' stamp: 'IO 11/9/2020 01:34:17'!
validateBeforeAdding: aTransactionContainer

	"validate that the given transaction container and its accounts are not in this portfolio, neither in children's portfolios, nor in parents' portfolios"

	^self subclassResponsibility.
! !


!ParentPortfolios methodsFor: 'adding' stamp: 'IO 11/9/2020 01:33:48'!
addAsParent: aPortfolio

	"add a portfolio as parent of this parent portfolio"

	^self subclassResponsibility.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ParentPortfolios class' category: 'Portfolio-Ejercicio'!
ParentPortfolios class
	instanceVariableNames: ''!

!ParentPortfolios class methodsFor: 'instance creation' stamp: 'IO 11/9/2020 02:36:50'!
newFor: aPortfolio

	"create the parent portfolio for a given portfolio"

	^Root new initializeFor: aPortfolio! !


!classDefinition: #Body category: 'Portfolio-Ejercicio'!
ParentPortfolios subclass: #Body
	instanceVariableNames: 'parentPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Body methodsFor: 'validations' stamp: 'IO 11/9/2020 01:54:46'!
validateBeforeAdding: aTransactionContainer

	"see superclass"

	parentPortfolios do: [ :parentPortfolio | parentPortfolio validateBeforeAdding: aTransactionContainer].
! !


!Body methodsFor: 'intiliazing' stamp: 'IO 11/9/2020 02:37:49'!
initializeFor: aPortfolio with: aParentPortfolio

	"initialize the parents of a portfolio with a given parent portfolio as its parent"

	parentPortfolios := OrderedCollection with: aParentPortfolio.
	childPortfolio := aPortfolio.
! !


!Body methodsFor: 'adding' stamp: 'IO 11/9/2020 00:10:44'!
addAsParent: aPortfolio

	"see superclass"

	parentPortfolios add: aPortfolio.
	^self.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Body class' category: 'Portfolio-Ejercicio'!
Body class
	instanceVariableNames: ''!

!Body class methodsFor: 'instance creation' stamp: 'IO 11/9/2020 02:37:27'!
newFor: aPortfolio with: aParentPortfolio

	"create the parent portfolio of a portfolio with a given parent portfolio as its parent"

	^self basicNew initializeFor: aPortfolio with: aParentPortfolio.
! !


!classDefinition: #Root category: 'Portfolio-Ejercicio'!
ParentPortfolios subclass: #Root
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Root methodsFor: 'initialization' stamp: 'IO 11/9/2020 01:31:48'!
initializeFor: aPortfolio

	"initialize the parent portfolios of a given portfolio"

	childPortfolio := aPortfolio.
! !


!Root methodsFor: 'validations' stamp: 'IO 11/9/2020 02:49:13'!
validateBeforeAdding: aTransactionContainer

	"
		see superclass
		implementation details: this method will search that the portfolio to be added is not in the portfolio's children, and will
			also validate that none of its children portfolios has one of the accounts of the portfolio to be added.
			this method performs lookup twice on all the children when the validation passes.
	"

	self validateTransactionContainerNotIncludedIn: aTransactionContainer.
	aTransactionContainer accounts do: [ :account | self validateTransactionContainerNotIncludedIn: account].
! !

!Root methodsFor: 'validations' stamp: 'LH 11/9/2020 14:13:12'!
validateTransactionContainerNotIncludedIn: aTransactionContainer

	"validate the given transaction container is not in included in the child of this parent portfolio"

	(childPortfolio includes: aTransactionContainer) ifTrue: [^self error: aTransactionContainer class errorMessageAlreadyAdded].

! !


!Root methodsFor: 'adding' stamp: 'IO 11/9/2020 01:30:15'!
addAsParent: aPortfolio

	"
		see superclass
		implementation details: this parent portfolio has no parent portfolios. when the portfolio of this parent portfolios is
			added as a child of another portfolio, it will have parent portfolios. it is not a root anymore.
	"

	^Body newFor: childPortfolio with: aPortfolio.
! !


!classDefinition: #TransactionContainer category: 'Portfolio-Ejercicio'!
Object subclass: #TransactionContainer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransactionContainer methodsFor: 'accesing' stamp: 'IO 11/9/2020 01:13:44'!
accounts

	"return all the accounts asociated with this container"
	
	self subclassResponsibility.
! !

!TransactionContainer methodsFor: 'accesing' stamp: 'IO 11/9/2020 01:13:51'!
balance

	"return the balance of all transactions included in this container"
	
	^self subclassResponsibility.
! !

!TransactionContainer methodsFor: 'accesing' stamp: 'IO 11/9/2020 01:13:57'!
transactions

	"return all transactions registered in this container"

	^self subclassResponsibility.
! !


!TransactionContainer methodsFor: 'testing' stamp: 'IO 11/9/2020 01:14:11'!
hasRegistered: aTransaction

	"return true if a given transaction is registered in this container"

	^self subclassResponsibility.
! !

!TransactionContainer methodsFor: 'testing' stamp: 'IO 11/9/2020 01:14:41'!
includes: aTransactionContainer

	"return true if this container includes a given transaction container"
	
	self subclassResponsibility.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransactionContainer class' category: 'Portfolio-Ejercicio'!
TransactionContainer class
	instanceVariableNames: ''!

!TransactionContainer class methodsFor: 'as yet unclassified' stamp: 'IO 11/9/2020 00:56:12'!
errorMessageAlreadyAdded

	"return the error message when the transaction container was already added"
	
	self subclassResponsibility.
! !


!TransactionContainer class methodsFor: 'error messages' stamp: 'IO 11/9/2020 00:57:36'!
errorMessageAccountAlreadyAdded
	^'This protfolio already includes this account.'! !

!TransactionContainer class methodsFor: 'error messages' stamp: 'IO 11/9/2020 00:57:56'!
errorMessagePortfolioAlreadyAdded
	^'This protfolio already includes the given portfolio.'! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
TransactionContainer subclass: #Portfolio
	instanceVariableNames: 'children parentPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'IO 11/9/2020 01:32:51'!
initialize

	"create a portfolio with no accounts and no sub-portfolios"

	children := OrderedCollection new.
	parentPortfolios := ParentPortfolios newFor: self.
! !


!Portfolio methodsFor: 'validations' stamp: 'LH 11/9/2020 14:11:06'!
validateBeforeAdding: aTransactionContainer

	"
		validate a portfolio before adding it to this portfolio
		implementation details: will first check if this protfolio is the same as the one to be added, then will ask its parent
			prtfolios to lookup for tthe portfolio to be added and its accounts
	"

	(self = aTransactionContainer) ifTrue: [^self error: Portfolio errorMessagePortfolioAlreadyAdded].
	parentPortfolios validateBeforeAdding: aTransactionContainer.
! !


!Portfolio methodsFor: 'accessing' stamp: 'IO 11/9/2020 01:25:41'!
accounts

	"see superclass"

	^self childrenCollectResultsOfMessage: #accounts.
! !

!Portfolio methodsFor: 'accessing' stamp: 'LH 11/8/2020 21:43:19'!
balance

	"
		see superclass
		implementation detials: return the balance of this portfolio. it will sum this portfolio accounts and the children
		portfolio's accounts balances
	"
	
	| balance |

	balance := 0.
	self childrenDo: [ :aTransactionContainer | balance := balance + aTransactionContainer balance].

	^balance.
! !

!Portfolio methodsFor: 'accessing' stamp: 'IO 11/9/2020 01:25:41'!
transactions

	"see superclass"
	
	^self childrenCollectResultsOfMessage: #transactions.
! !


!Portfolio methodsFor: 'testing' stamp: 'IO 11/8/2020 19:58:51'!
hasRegistered: aTransaction

	"see superclass"

	^self transactions includes: aTransaction.
	
! !

!Portfolio methodsFor: 'testing' stamp: 'IO 11/9/2020 01:17:55'!
includes: aTransactionContainer

	"see superclass"

	self childrenDo: [ :child | (child includes: aTransactionContainer) ifTrue: [^true]].
	^self = aTransactionContainer.
! !


!Portfolio methodsFor: 'iterating' stamp: 'IO 11/9/2020 02:43:06'!
childrenCollectResultsOfMessage: aMessage

	"collect the results of sending a message to each child of a transaction container"

	| collectedResults |

	collectedResults := OrderedCollection new.
	self childrenDo: [ :child | collectedResults addAll: (aMessage sendTo: child )].

	^collectedResults.
! !

!Portfolio methodsFor: 'iterating' stamp: 'IO 11/9/2020 02:46:45'!
childrenDo: aBlock

	"
		activate a given block on each child supplying the child as unique argument. it is not recursive on all the containers,
		only activates on the first level below this container
	"

	children do: [ :child | aBlock value: child ].
! !


!Portfolio methodsFor: 'adding' stamp: 'IO 11/9/2020 02:40:30'!
add: aTransactionContainer

	"add a transaction container to this portfolio"

	self validateBeforeAdding: aTransactionContainer.
	children add: aTransactionContainer.

! !

!Portfolio methodsFor: 'adding' stamp: 'IO 11/9/2020 01:11:05'!
addAccount: anAccount

	"add anAccount to this Portfolio"

	self add: anAccount.

! !

!Portfolio methodsFor: 'adding' stamp: 'IO 11/9/2020 01:11:12'!
addPortfolio: aPortfolio

	"add aPortfolio to this Portfolio"

	self add: aPortfolio.
	aPortfolio addAsParent: self.
! !


!Portfolio methodsFor: 'private' stamp: 'IO 11/8/2020 18:59:25'!
addAsParent: aPortfolio

	"add a portfolio as this prtfolio's parent"
	
	parentPortfolios := parentPortfolios addAsParent: aPortfolio.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error messages' stamp: 'IO 11/9/2020 01:09:34'!
errorMessageAlreadyAdded

	^TransactionContainer errorMessagePortfolioAlreadyAdded.
! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
TransactionContainer subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'IO 11/9/2020 01:15:07'!
initialize

	"initialize an account with no transactions regitered"

	transactions := OrderedCollection new.
! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'IO 11/8/2020 18:12:38'!
register: aTransaction

	"register a transaction in this account"

	transactions add: aTransaction.
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'IO 11/8/2020 18:12:54'!
transactions

	"see superclass"

	^transactions copy.
! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'IO 11/8/2020 18:11:23'!
balance

	"see superclass"

	| aBalance |

	aBalance := 0.
	transactions do: [ :aTransaction | aBalance:= aTransaction addToBalance: aBalance].

	^aBalance.
! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'IO 11/8/2020 18:11:47'!
hasRegistered: aTransaction

	"see superclass"

	^transactions includes: aTransaction.

! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'IO 11/9/2020 01:16:20'!
includes: aTransactionContainer

	"see superclass"

	^self = aTransactionContainer.
! !


!ReceptiveAccount methodsFor: 'accesing' stamp: 'IO 11/9/2020 01:17:08'!
accounts

	"
		see superclass
		implementation details: returns the accounts asociated with this account: itself
	"

	^OrderedCollection with: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Ejercicio'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'IO 11/9/2020 01:09:50'!
errorMessageAlreadyAdded

	^TransactionContainer errorMessageAccountAlreadyAdded.
! !
