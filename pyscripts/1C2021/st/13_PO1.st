!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'sc 5/17/2021 21:45:35'!
test01PortfolioVacioTieneBalance0
	|portfolio|
	portfolio  := Portfolio new.
	self assert: portfolio balance equals: 0.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'sc 5/24/2021 16:13:07'!
test02PortfolioConUnaCuentaConSaldoPositivoTieneElMismoBalanceQueLaMisma
	|portfolio account|
	portfolio  := Portfolio new.	
	account := self createAccountWithDeposits: (OrderedCollection with: 100).
	portfolio add: account.
	self assert: portfolio balance equals: 100.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'sc 5/24/2021 16:13:56'!
test03PortfolioConDosCuentasTieneElMismoBalanceQueLaSumaDeAmbas
	|portfolio account1 account2|
	portfolio  := Portfolio new.	
	account1 := self createAccountWithDeposits: (OrderedCollection with: 100).
	account2 := self createAccountWithDeposits: (OrderedCollection with: 50).
	
	portfolio add: account1.
	portfolio add: account2.
	self assert: portfolio balance equals: 150.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'sc 5/24/2021 16:14:34'!
test04PortfolioVacioNoTieneTransaccionesRegistradas
	|portfolio deposito account|
	portfolio  := Portfolio new.
	account  := ReceptiveAccount new.
	deposito := Deposit register: 100 on: account.
	self deny: (portfolio hasRegistered: deposito).
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'sc 5/23/2021 17:32:21'!
test05PortfolioConUnaCuentaConUnaTransaccionLaTieneRegistrada
	|portfolio deposito account|
	portfolio  := Portfolio new.
	account  := ReceptiveAccount new.
	deposito := Deposit register: 100 on: account.
	portfolio add: account .
	self assert: (portfolio hasRegistered: deposito).
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'sc 5/23/2021 16:52:48'!
test06PortfolioConUnPortfolioVacioTieneBalance0
	"Aca vamos a meter un portfolio en una lista nueva en vez de usar  la misma, para no apurarnos"
	|portfolio1 portfolio2|
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio1 add: portfolio2.
	self assert: portfolio1  balance equals: 0.
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'sc 5/24/2021 16:15:22'!
test07PortfolioTieneElMismoBalanceQueElunicoPortfolioQueContiene
	|portfolio1 portfolio2 account|
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account := self createAccountWithDeposits: (OrderedCollection with: 100).
	portfolio2 add: account .
	portfolio1 add: portfolio2.
	self assert: portfolio1  balance equals: 100.
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'sc 5/23/2021 17:32:21'!
test08PortfolioTieneLaMismasTransaccionesQueElUnicoPortfolioQueContiene
	|portfolio1 portfolio2 account deposito|
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account  := ReceptiveAccount new.
	deposito := Deposit register: 100 on: account.
	portfolio2 add: account .
	portfolio1 add: portfolio2.
	self assert: (portfolio1 hasRegistered: deposito). 
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'sc 5/19/2021 15:11:45'!
test09PortfolioVacioNoTieneTransacciones
	|portfolio1|
	portfolio1 := Portfolio new.
	self assert: portfolio1 transactions isEmpty.
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'sc 5/24/2021 16:15:49'!
test10PortfolioConCuentaConUnaTransaccionSoloContieneEstaTransaccion
	|portfolio1 account|
	portfolio1 := Portfolio new.
	account := self createAccountWithDeposits: (OrderedCollection with: 100).
	portfolio1 add: account .
	self assert: portfolio1 transactions equals: account transactions.
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'sc 5/24/2021 16:16:08'!
test11PortfolioConUnPortfolioConUnaTransaccionTieneALaMisma
	|portfolio1 portfolio2 account|
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account := self createAccountWithDeposits: (OrderedCollection with: 100).
	portfolio2 add: account.
	portfolio1 add: portfolio2.
	self assert: portfolio1 transactions equals: account transactions.
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'sc 5/24/2021 14:48:01'!
test12NoSePuedeMeterUnaCuentaAUnPortfolioQueYaLaTiene
	|portfolio  account|
	portfolio := Portfolio new.
	account  := ReceptiveAccount new.
	portfolio add: account .
	self should: [portfolio add: account.]
		raise: Error
		withExceptionDo: 
		[:anError| self assert: anError  messageText  equals:
			 Portfolio cantAddFinancialServiceToPortfolioWithSharedFinancialService].
		
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'sc 5/23/2021 17:49:40'!
test13NoSePuedeMeterUnPortfolioEnSiMismo
	|portfolio |
	portfolio := Portfolio new.
	self should: [portfolio add: portfolio.]
		raise: Error
		withExceptionDo: 
		[:anError| self assert: anError  messageText  equals:
			 Portfolio cantAddFinancialServiceToPortfolioWithSharedFinancialService  ].
		
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'sc 5/23/2021 17:49:35'!
test14NoSePuedeAgregarPortfolioQueComparteUnaCuenta
	|portfolio1 portfolio2 account|
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account  := ReceptiveAccount new.
	portfolio1 add: account.
	portfolio2 add: account.
	self should: [portfolio1 add: portfolio2 ]
		raise: Error
		withExceptionDo: 
		[:anError| self assert: anError  messageText  equals:
			 Portfolio cantAddFinancialServiceToPortfolioWithSharedFinancialService].
		
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'sc 5/24/2021 16:26:01'!
test15NoSePuedeAgregarPortfolio3APortfolio2SiAmbosPertenecenAPortfolio1
	|portfolio1 portfolio2 portfolio3|
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	
	self addFinancialServices: (OrderedCollection with: portfolio2 with: portfolio3 ) to: portfolio1. 
	self should: [portfolio2 add: portfolio3 ]
		raise: Error
		withExceptionDo: 
		[:anError| self assert: anError  messageText  equals:
			 Portfolio cantAddFinancialServiceToPortfolioWithSharedFinancialService].
		
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'sc 5/24/2021 16:24:49'!
test16NoSePuedeAgregarPortfolio2APortfolio3SiAbuelodePortfolio3EsPadreDeP2
	|abuelo padre hijo receptor | "abuelo es tambien padre de aAgregar"
	abuelo := Portfolio new.
	padre := Portfolio new.
	hijo := Portfolio new.
	receptor := Portfolio new.
	
	padre add: hijo.
	self addFinancialServices: (OrderedCollection with: padre with: receptor) to: abuelo. 	
	
	self should: [receptor add: hijo]
		raise: Error
		withExceptionDo: 
		[:anError| self assert: anError  messageText  equals:
			 Portfolio cantAddFinancialServiceToPortfolioWithSharedFinancialService].
		
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'sc 5/24/2021 16:24:25'!
test17NoSePuedeAgregarPortfolio2APortfolio3SiAbuelodePortfolio3EsPadreDeP2
	|abuelo padre hijo aAgregar | "abuelo es tambien padre de aAgregar"
	abuelo := Portfolio new.
	padre := Portfolio new.
	hijo := Portfolio new.
	aAgregar := Portfolio new.
	
	self addFinancialServices: (OrderedCollection with: padre with: aAgregar ) to: abuelo. 	
	padre add: hijo.
	
	self should: [hijo add: aAgregar]
		raise: Error
		withExceptionDo: 
		[:anError| self assert: anError  messageText  equals:
			 Portfolio cantAddFinancialServiceToPortfolioWithSharedFinancialService].
		
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'sc 5/24/2021 16:23:37'!
test18NoSePuedeAgregarUnPortfolioAOtroSiElPrimeroDosPadresYCompartenUno
	|padre1 padre2 padre3 hijo1 hijo2 |
	padre1 := Portfolio new.
	padre2 := Portfolio new.
	padre3 := Portfolio new.
	hijo1 := Portfolio new.
	hijo2 := Portfolio new.
	
	self addFinancialServices: (OrderedCollection with: hijo1 with: hijo2) to: padre1. 	
	padre3 add: hijo1.
	padre2 add: hijo2.
		
	self should: [hijo1 add: hijo2]
		raise: Error
		withExceptionDo: 
		[:anError| self assert: anError  messageText  equals:
			 Portfolio cantAddFinancialServiceToPortfolioWithSharedFinancialService ].
		
	! !


!PortfolioTest methodsFor: 'testAuxiliarFunctions' stamp: 'sc 5/24/2021 16:22:26'!
addFinancialServices: financialServicesList to: portfolio
	financialServicesList  do:[:aFinancialService|portfolio  add: aFinancialService].! !

!PortfolioTest methodsFor: 'testAuxiliarFunctions' stamp: 'sc 5/24/2021 16:11:46'!
createAccountWithDeposits: depositList
	|account|
	account := ReceptiveAccount new.
	depositList do:[:aDepositValue| Deposit register: aDepositValue on: account].
	^account ! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'sc 5/17/2021 20:12:57'!
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

!AccountTransaction methodsFor: 'value' stamp: 'sc 5/17/2021 20:32:26'!
addToBalance: actualBalance
	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'sc 5/23/2021 15:53:03'!
includes: aPortfolioOAccount
	^ (self == aPortfolioOAccount).! !

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


!Deposit methodsFor: 'value' stamp: 'sc 5/17/2021 20:40:43'!
addToBalance: actualBalance
	^actualBalance  + value. ! !

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


!Withdraw methodsFor: 'value' stamp: 'sc 5/17/2021 20:39:42'!
addToBalance: actualBalance
	^actualBalance - value.! !

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


!classDefinition: #FinancialService category: 'Portfolio-Ejercicio'!
Object subclass: #FinancialService
	instanceVariableNames: 'father'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialService methodsFor: 'balance' stamp: 'sc 5/23/2021 17:15:25'!
balance
	self subclassResponsibility.! !


!FinancialService methodsFor: 'testing' stamp: 'sc 5/23/2021 17:13:45'!
hasRegistered: aTransaction
	self subclassResponsibility.! !

!FinancialService methodsFor: 'testing' stamp: 'sc 5/24/2021 15:41:39'!
myRootsShareDecendenceWith: portfolioRoot
	^ self roots anySatisfy:[:aRoot| aRoot sharesDescendenceWith: portfolioRoot.]
	"Dos roots compartend descendencia si son iguales o si algunos de sus descendientes son iguales"! !

!FinancialService methodsFor: 'testing' stamp: 'sc 5/24/2021 16:06:06'!
sharesFinancialServicesWith: aFinancialService
	^ self roots anySatisfy: 	[:aRoot| aFinancialService myRootsShareDecendenceWith: aRoot.]! !


!FinancialService methodsFor: 'operations' stamp: 'sc 5/23/2021 17:16:37'!
addFather: aPortfolio
	father add: aPortfolio.! !

!FinancialService methodsFor: 'operations' stamp: 'sc 5/24/2021 15:15:22'!
roots
	self subclassResponsibility ! !

!FinancialService methodsFor: 'operations' stamp: 'sc 5/24/2021 15:54:59'!
sharesDescendenceWith: aPortfolioRoot
	self subclassResponsibility ! !


!FinancialService methodsFor: 'initialize' stamp: 'sc 5/24/2021 16:00:33'!
initialize
	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialService subclass: #Portfolio
	instanceVariableNames: 'portfolioElements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'sc 5/23/2021 16:44:20'!
hasRegistered: aDeposit 
	^ (portfolioElements anySatisfy: [:anAccountOrPotfolio| anAccountOrPotfolio hasRegistered: aDeposit]) .! !

!Portfolio methodsFor: 'testing' stamp: 'sc 5/24/2021 15:23:15'!
includes: aFinancialServiceToFind
	 ^self = aFinancialServiceToFind  or:
	  (portfolioElements anySatisfy:
					 [:aPortfolioOrAccount | aPortfolioOrAccount includes: aFinancialServiceToFind])
	
	! !

!Portfolio methodsFor: 'testing' stamp: 'sc 5/24/2021 15:53:47'!
sharesDescendenceWith: aPortfolioRoot
	^ (aPortfolioRoot includes: self) or:  (portfolioElements anySatisfy: [:AFinancialService| aPortfolioRoot sharesDescendenceWith: AFinancialService]).! !


!Portfolio methodsFor: 'error handling' stamp: 'sc 5/23/2021 17:59:17'!
raiseErrorIfPortfolioHasSharedFinancialService: aFinancialService
	(self sharesFinancialServicesWith: aFinancialService )	
	ifTrue: [self error: self class cantAddFinancialServiceToPortfolioWithSharedFinancialService ].
	! !


!Portfolio methodsFor: 'operations' stamp: 'sc 5/24/2021 16:04:00'!
add: anElement
	self raiseErrorIfPortfolioHasSharedFinancialService: anElement.
	anElement addFather: self.
	portfolioElements add: anElement.
	! !

!Portfolio methodsFor: 'operations' stamp: 'sc 5/23/2021 16:44:19'!
balance
	|balance|
	balance := portfolioElements sum:[:anAccountOrPortfolio| anAccountOrPortfolio balance] ifEmpty: [0].
	^balance! !

!Portfolio methodsFor: 'operations' stamp: 'sc 5/24/2021 15:15:05'!
roots
	|rootsList|
	rootsList := OrderedCollection new.
	father do: [:aFather| rootsList addAll: aFather roots].
	(father isEmpty) ifTrue: [rootsList add: self].
	^rootsList.! !

!Portfolio methodsFor: 'operations' stamp: 'sc 5/23/2021 16:44:19'!
transactions
	|transactions|
	transactions := OrderedCollection  new.
	portfolioElements do: [:anAccountOrPortfolio | transactions  addAll: (anAccountOrPortfolio transactions)].
	^transactions .
	! !


!Portfolio methodsFor: 'initialize' stamp: 'sc 5/23/2021 16:44:20'!
initialize
	portfolioElements := OrderedCollection new.
	father := OrderedCollection  new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'sc 5/23/2021 17:48:48'!
cantAddFinancialServiceToPortfolioWithSharedFinancialService
	^ 'No me vayas a agregar un portfolio de la misma familia capo, ni a patadas'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialService subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialize' stamp: 'sc 5/23/2021 17:09:04'!
initialize
	father := OrderedCollection new.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'sc 5/17/2021 20:42:26'!
balance
	|balanceValue|
	balanceValue := 0.
	transactions do: [:aTransaction| balanceValue := aTransaction addToBalance: balanceValue ].
	^balanceValue .! !


!ReceptiveAccount methodsFor: 'operations' stamp: 'sc 5/24/2021 15:14:46'!
roots
	|rootsList|
	rootsList := OrderedCollection new.
	father do: [:aFather| rootsList addAll: aFather roots].
	^rootsList.! !

!ReceptiveAccount methodsFor: 'operations' stamp: 'sc 5/24/2021 15:54:04'!
sharesDescendenceWith: aPortfolioRoot
	^ (aPortfolioRoot includes: self)! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'sc 5/24/2021 16:01:38'!
hasRegistered: aTransaction
	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'sc 5/23/2021 17:45:50'!
includes: aFinancialService
	^aFinancialService = self.! !
