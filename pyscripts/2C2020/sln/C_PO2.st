!classDefinition: #Account category: #'Portfolio2-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/26/2019 19:00:30'!
transactionsIsEmpty

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/26/2019 19:00:23'!
visitTransactionsWith: aTransactionVisitor

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !

!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'visitor accepting' stamp: 'HAW 5/26/2019 19:41:02'!
accept: anAccountVisitor

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: #'Portfolio2-Solucion'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 19:40:23'!
named: aName

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio2-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/26/2019 19:27:43'!
initializedNamed: aName

	name := aName.
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


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


!Portfolio methodsFor: 'accounts management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'accounts management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'accounts management - private' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'accounts management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'name' stamp: 'HAW 5/26/2019 19:26:14'!
name

	^name! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/26/2019 19:01:47'!
transactionsIsEmpty
	
	^accounts allSatisfy: [ :anAccount | anAccount transactionsIsEmpty ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/26/2019 18:47:32'!
visitTransactionsWith: aTransactionVisitor

	accounts do: [ :anAccount | anAccount visitTransactionsWith: aTransactionVisitor ]! !


!Portfolio methodsFor: 'transactions - private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'visitor accepting' stamp: 'HAW 5/26/2019 19:34:04'!
accept: anAccountVisitor

	anAccountVisitor visitPortfolio: self! !

!Portfolio methodsFor: 'visitor accepting' stamp: 'HAW 5/26/2019 19:35:42'!
visitAccountsWith: anAccountVisitor

	accounts do: [ :anAccount | anAccount accept: anAccountVisitor ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio2-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 19:23:13'!
named: aName

	^super new initializedNamed: aName! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 19:32:34'!
named: aName with: anAccount

	^(self named: aName) 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 19:47:25'!
named: aName with: anAccount with: anotherAccount

	^(self named: aName)
		add: anAccount;
		add: anotherAccount;
		yourself ! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 19:53:08'!
new

	^self named: self unnamedPortfolio ! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 19:52:32'!
unnamedPortfolio

	^'Unnamed portfolio'.! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 19:52:18'!
with: anAccount

	^self named: self unnamedPortfolio with: anAccount ! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 19:53:01'!
with: anAccount with: anotherAccount

	^self named: self unnamedPortfolio with: anAccount with: anotherAccount ! !


!classDefinition: #ReceptiveAccount category: #'Portfolio2-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HAW 5/26/2019 19:39:38'!
initializedNamed: aName

	name := aName.
	transactions := OrderedCollection new! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'name' stamp: 'HAW 5/26/2019 19:39:16'!
name

	^name! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/26/2019 18:53:27'!
transactionsIsEmpty
	
	^transactions isEmpty ! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/26/2019 18:18:53'!
visitTransactionsWith: aTransactionVisitor

	transactions do: [ :aTransaction | aTransaction accept: aTransactionVisitor ]! !


!ReceptiveAccount methodsFor: 'transactions - private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'visitor accepting' stamp: 'HAW 5/26/2019 19:36:05'!
accept: anAccountVisitor

	anAccountVisitor visitReceptiveAccount: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: #'Portfolio2-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 19:31:42'!
named: aName

	^super new initializedNamed: aName! !

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 19:40:00'!
new

	^self named: 'unnamed receptive account'! !


!classDefinition: #AccountTransaction category: #'Portfolio2-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'visitor accepting' stamp: 'HAW 5/26/2019 19:05:10'!
accept: aTransactionVisitor

	self subclassResponsibility ! !


!classDefinition: #Deposit category: #'Portfolio2-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'visitor accepting' stamp: 'HAW 5/26/2019 18:19:21'!
accept: aTransactionVisitor

	aTransactionVisitor visitDeposit: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio2-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!Deposit class methodsFor: 'registration' stamp: 'NR 11/9/2019 16:22:48'!
register: aValue on: account

	| deposit |
	
	deposit := self for: aValue.
	account register: deposit.
		
	^ deposit! !


!classDefinition: #TransferLeg category: #'Portfolio2-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!TransferLeg methodsFor: 'initialization' stamp: 'HAW 5/25/2019 20:02:09'!
initializeAsPartOf: aTransfer 
	
	transfer := aTransfer ! !


!TransferLeg methodsFor: 'value' stamp: 'HAW 5/25/2019 20:03:40'!
value

	^transfer value! !


!TransferLeg methodsFor: 'accessing' stamp: 'HAW 5/26/2019 18:12:15'!
transfer

	^transfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: #'Portfolio2-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 20:01:58'!
asPartOf: aTransfer 

	^self new initializeAsPartOf: aTransfer ! !


!classDefinition: #TransferDeposit category: #'Portfolio2-Solucion'!
TransferLeg subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!TransferDeposit methodsFor: 'leg' stamp: 'HAW 5/25/2019 20:01:26'!
withdrawLeg
	
	^transfer withdrawLeg ! !


!TransferDeposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 20:01:20'!
affectBalance: aBalance

	^aBalance + self value! !


!TransferDeposit methodsFor: 'visitor accepting' stamp: 'HAW 5/26/2019 18:25:22'!
accept: aTransactionVisitor

	aTransactionVisitor visitTransferDeposit: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: #'Portfolio2-Solucion'!
TransferDeposit class
	instanceVariableNames: 'value trasfer'!


!classDefinition: #TransferWithdraw category: #'Portfolio2-Solucion'!
TransferLeg subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!TransferWithdraw methodsFor: 'leg' stamp: 'HAW 5/25/2019 20:03:27'!
depositLeg

	^transfer depositLeg ! !


!TransferWithdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 20:03:11'!
affectBalance: aBalance

	^aBalance - self value! !


!TransferWithdraw methodsFor: 'visitor accepting' stamp: 'HAW 5/26/2019 18:23:16'!
accept: aTransactionVisitor

	aTransactionVisitor visitTransferWithdraw: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: #'Portfolio2-Solucion'!
TransferWithdraw class
	instanceVariableNames: 'value transfer'!


!classDefinition: #Withdraw category: #'Portfolio2-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'visitor accepting' stamp: 'HAW 5/26/2019 18:21:15'!
accept: aTransactionVisitor

	aTransactionVisitor visitWithdraw: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio2-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!Withdraw class methodsFor: 'registration' stamp: 'HAW 5/26/2019 18:08:21'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #AccountVisitor category: #'Portfolio2-Solucion'!
Object subclass: #AccountVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!AccountVisitor methodsFor: 'account visiting' stamp: 'HAW 5/26/2019 19:50:42'!
visitPortfolio: aPortfolio

	self subclassResponsibility ! !

!AccountVisitor methodsFor: 'account visiting' stamp: 'HAW 5/26/2019 19:50:54'!
visitReceptiveAccount: aReceptiveAccount

	self subclassResponsibility ! !


!classDefinition: #PortfolioSummary category: #'Portfolio2-Solucion'!
AccountVisitor subclass: #PortfolioSummary
	instanceVariableNames: 'portfolio lines spaces'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!PortfolioSummary methodsFor: 'initialization' stamp: 'HAW 5/26/2019 19:57:04'!
initializeOn: aPortfolio 
	
	portfolio := aPortfolio ! !


!PortfolioSummary methodsFor: 'line management' stamp: 'HAW 5/29/2019 16:03:04'!
addNameOf: anAccount

	self addToLines: anAccount name! !

!PortfolioSummary methodsFor: 'line management' stamp: 'HAW 5/29/2019 16:02:51'!
addToLines: aLine
	
	lines add: spaces, aLine! !

!PortfolioSummary methodsFor: 'line management' stamp: 'HAW 5/29/2019 16:01:41'!
incrementIdentatioWhile: aBlock

	spaces := spaces, '   '.
	aBlock ensure: [ spaces := spaces allButLast: 3 ]! !


!PortfolioSummary methodsFor: 'account visiting' stamp: 'HAW 5/29/2019 16:03:23'!
visitPortfolio: aPortfolio 
	
	self addNameOf: aPortfolio.
	self incrementIdentatioWhile: [
		aPortfolio visitAccountsWith: self.
		self addToLines: 'Balance = ', aPortfolio balance printString ].
	
	! !

!PortfolioSummary methodsFor: 'account visiting' stamp: 'HAW 5/29/2019 16:02:41'!
visitReceptiveAccount: aReceptiveAccount 
	
	| accountSummaryLines |
	
	self addNameOf: aReceptiveAccount.
	accountSummaryLines := (AccountSummary on: aReceptiveAccount) lines.
	self incrementIdentatioWhile: [ accountSummaryLines do: [ :aLine | self addToLines: aLine ]]
	! !


!PortfolioSummary methodsFor: 'evaluating' stamp: 'HAW 5/26/2019 19:57:43'!
lines
	
	lines := OrderedCollection new.
	spaces := ''.
	
	portfolio accept: self.
	
	^lines! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioSummary class' category: #'Portfolio2-Solucion'!
PortfolioSummary class
	instanceVariableNames: ''!

!PortfolioSummary class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 19:56:53'!
on: aPortfolio 
	
	^self new initializeOn: aPortfolio ! !


!classDefinition: #PortfolioTreePrinter category: #'Portfolio2-Solucion'!
AccountVisitor subclass: #PortfolioTreePrinter
	instanceVariableNames: 'portfolio lines spaces'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!PortfolioTreePrinter methodsFor: 'initialization' stamp: 'HAW 5/26/2019 19:24:13'!
initializeOn: aPortfolio 
	
	portfolio := aPortfolio ! !


!PortfolioTreePrinter methodsFor: 'lines' stamp: 'HAW 5/26/2019 19:38:40'!
lines
	
	lines := OrderedCollection new.
	spaces := ''.
	
	portfolio accept: self.
	
	^lines! !


!PortfolioTreePrinter methodsFor: 'account visiting' stamp: 'HAW 5/26/2019 19:37:47'!
addNameOf: anAccount

	lines add: spaces, anAccount name! !

!PortfolioTreePrinter methodsFor: 'account visiting' stamp: 'HAW 5/26/2019 19:49:24'!
visitPortfolio: aPortfolio 
	
	self addNameOf: aPortfolio.
	spaces := spaces, '   '.
	aPortfolio visitAccountsWith: self.
	spaces := spaces allButLast: 3! !

!PortfolioTreePrinter methodsFor: 'account visiting' stamp: 'HAW 5/26/2019 19:37:23'!
visitReceptiveAccount: aReceptiveAccount 
	
	self addNameOf: aReceptiveAccount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreePrinter class' category: #'Portfolio2-Solucion'!
PortfolioTreePrinter class
	instanceVariableNames: ''!

!PortfolioTreePrinter class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 19:20:07'!
on: aPortfolio 
	
	^self new initializeOn: aPortfolio ! !


!classDefinition: #TransactionVisitor category: #'Portfolio2-Solucion'!
Object subclass: #TransactionVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!TransactionVisitor methodsFor: 'transaction visiting' stamp: 'HAW 5/26/2019 19:04:05'!
visitDeposit: aDeposit

	self subclassResponsibility ! !

!TransactionVisitor methodsFor: 'transaction visiting' stamp: 'HAW 5/26/2019 19:04:12'!
visitTransferDeposit: aTransferDeposit

	self subclassResponsibility ! !

!TransactionVisitor methodsFor: 'transaction visiting' stamp: 'HAW 5/26/2019 19:04:21'!
visitTransferWithdraw: aTransferWithdraw

	self subclassResponsibility ! !

!TransactionVisitor methodsFor: 'transaction visiting' stamp: 'HAW 5/26/2019 19:04:27'!
visitWithdraw: aWithdraw

	self subclassResponsibility ! !


!classDefinition: #AccountSummary category: #'Portfolio2-Solucion'!
TransactionVisitor subclass: #AccountSummary
	instanceVariableNames: 'account lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!AccountSummary methodsFor: 'initialization' stamp: 'HAW 5/26/2019 18:17:08'!
initializeOn: anAccount

	account := anAccount ! !


!AccountSummary methodsFor: 'evaluating' stamp: 'HAW 5/26/2019 18:29:36'!
lines
	
	lines := OrderedCollection new.
	
	account visitTransactionsWith: self.
	lines add: ('Balance = ', account balance printString).
	
	^lines! !


!AccountSummary methodsFor: 'transaction visiting' stamp: 'HAW 5/26/2019 18:20:17'!
visitDeposit: aDeposit 
	
	^lines add: ('Depósito por ', aDeposit value printString)! !

!AccountSummary methodsFor: 'transaction visiting' stamp: 'HAW 5/26/2019 18:25:45'!
visitTransferDeposit: aTransferDeposit 
	
	lines add: ('Entrada por transferencia de ', aTransferDeposit value printString)! !

!AccountSummary methodsFor: 'transaction visiting' stamp: 'HAW 5/26/2019 18:23:38'!
visitTransferWithdraw: aTransferWithdraw 
	
	lines add: ('Salida por transferencia de ', aTransferWithdraw value printString)! !

!AccountSummary methodsFor: 'transaction visiting' stamp: 'HAW 5/26/2019 18:21:47'!
visitWithdraw: aWithdraw 
	
	lines add: ('Extracción por ', aWithdraw value printString)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: #'Portfolio2-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 18:16:54'!
on: anAccount
	
	^self new initializeOn: anAccount ! !


!classDefinition: #AccountTransferNet category: #'Portfolio2-Solucion'!
TransactionVisitor subclass: #AccountTransferNet
	instanceVariableNames: 'account transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!AccountTransferNet methodsFor: 'initialization' stamp: 'HAW 5/26/2019 19:08:10'!
initializeOn: anAccount

	account := anAccount ! !


!AccountTransferNet methodsFor: 'evaluating' stamp: 'HAW 5/26/2019 19:11:58'!
value 

	transferNet := 0.
	
	account visitTransactionsWith: self.
	
	^transferNet! !


!AccountTransferNet methodsFor: 'transaction visiting' stamp: 'HAW 5/26/2019 19:12:45'!
visitDeposit: aDeposit 
	
	! !

!AccountTransferNet methodsFor: 'transaction visiting' stamp: 'HAW 5/26/2019 19:14:10'!
visitTransferDeposit: aTransferDeposit 
	
	transferNet := transferNet + aTransferDeposit value! !

!AccountTransferNet methodsFor: 'transaction visiting' stamp: 'HAW 5/26/2019 19:12:37'!
visitTransferWithdraw: aTransferWithdraw 
	
	transferNet := transferNet - aTransferWithdraw value! !

!AccountTransferNet methodsFor: 'transaction visiting' stamp: 'HAW 5/26/2019 19:12:52'!
visitWithdraw: aWithdraw 
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransferNet class' category: #'Portfolio2-Solucion'!
AccountTransferNet class
	instanceVariableNames: ''!

!AccountTransferNet class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 19:07:59'!
on: anAccount

	^self new initializeOn: anAccount ! !


!classDefinition: #Transfer category: #'Portfolio2-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'withdrawLeg depositLeg value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Solucion'!

!Transfer methodsFor: 'value' stamp: 'HAW 5/25/2019 20:03:55'!
value

	^value ! !


!Transfer methodsFor: 'initialization' stamp: 'HAW 5/26/2019 18:05:14'!
initializeFor: anAmount  

	value := anAmount.
	withdrawLeg := TransferWithdraw asPartOf: self.
	depositLeg := TransferDeposit asPartOf: self
	! !


!Transfer methodsFor: 'legs' stamp: 'HAW 5/25/2019 19:50:46'!
depositLeg
	
	^depositLeg! !

!Transfer methodsFor: 'legs' stamp: 'HAW 5/25/2019 19:50:39'!
withdrawLeg
	
	^withdrawLeg! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'Portfolio2-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'HAW 5/26/2019 18:05:47'!
for: anAmount  

	^self new initializeFor: anAmount ! !


!Transfer class methodsFor: 'registration' stamp: 'HAW 5/26/2019 18:55:30'!
register: anAmount from: fromAccount to: toAccount

	| transfer |
	
	self assertCanTransfer: anAmount.
	self assertCanTransferFrom: fromAccount to: toAccount.
	
	transfer := self for: anAmount .
	
	fromAccount register: transfer withdrawLeg.
	toAccount register: transfer depositLeg.
	
	^transfer! !


!Transfer class methodsFor: 'exceptions' stamp: 'HAW 5/26/2019 18:53:15'!
canNotTransferBetweenSameAccountsErrorMessage
	
	^'No se puede transferir entre la misma cuenta'! !

!Transfer class methodsFor: 'exceptions' stamp: 'HAW 5/26/2019 18:52:55'!
signalCanNotTransferBetweenSameAccount
	
	self error: self canNotTransferBetweenSameAccountsErrorMessage! !

!Transfer class methodsFor: 'exceptions' stamp: 'HAW 5/26/2019 18:58:43'!
signalTransferValueMustBeStrictlyPositive
	
	self error: self transferValueMustBeStrictlyPositiveErrorMessage! !

!Transfer class methodsFor: 'exceptions' stamp: 'HAW 5/26/2019 18:58:15'!
transferValueMustBeStrictlyPositiveErrorMessage
	
	^'El valor de la transferencia debe ser estrictramente positivo'! !


!Transfer class methodsFor: 'instance creation pre-conditions' stamp: 'HAW 5/26/2019 18:58:43'!
assertCanTransfer: anAmount

	anAmount strictlyPositive ifFalse: [ self signalTransferValueMustBeStrictlyPositive ]! !

!Transfer class methodsFor: 'instance creation pre-conditions' stamp: 'HAW 5/26/2019 18:52:33'!
assertCanTransferFrom: aFromAccout to: aToAccount

	aFromAccout = aToAccount ifTrue: [ self signalCanNotTransferBetweenSameAccount ]! !
