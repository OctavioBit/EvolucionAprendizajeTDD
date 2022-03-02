!classDefinition: #FinancialAssetTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #FinancialAssetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialAssetTest methodsFor: 'testAuxiliarFunctions' stamp: 'E.V 6/3/2021 11:25:54'!
addFinancialAssets: aFinancialAssetCollection to: aPortfolio
	aFinancialAssetCollection do:[:aFinancialAsset| aPortfolio  add: aFinancialAsset].! !

!FinancialAssetTest methodsFor: 'testAuxiliarFunctions' stamp: 'E.V 6/3/2021 11:26:23'!
createAccountWithDeposits: aDepositValueCollection
	^self createAccountWithTransaction: Deposit withValues: aDepositValueCollection! !

!FinancialAssetTest methodsFor: 'testAuxiliarFunctions' stamp: 'E.V 6/3/2021 11:26:41'!
createAccountWithTransaction: anAccountTransaction withValues: anAccountTransactionValueList
	|account|
	account := ReceptiveAccount new.
	anAccountTransactionValueList do:[:accountTransactionValue| anAccountTransaction register: accountTransactionValue on: account].
	^account ! !

!FinancialAssetTest methodsFor: 'testAuxiliarFunctions' stamp: 'E.V 6/3/2021 11:27:12'!
createAccountWithWithdraws: aWithdrawValueCollection
	^self createAccountWithTransaction: Withdraw withValues: aWithdrawValueCollection! !


!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
FinancialAssetTest subclass: #PortfolioTest
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

!PortfolioTest methodsFor: 'tests' stamp: 'E.V 6/3/2021 11:23:55'!
test03PortfolioConDosCuentasTieneElMismoBalanceQueLaSumaDeAmbas
	|aPortfolio account1 account2|
	aPortfolio  := Portfolio new.	
	account1 := self createAccountWithDeposits: (OrderedCollection with: 100).
	account2 := self createAccountWithDeposits: (OrderedCollection with: 50).
	
	self addFinancialAssets: (OrderedCollection with:account1 with:account2 )  to: aPortfolio .

	self assert: aPortfolio balance equals: 150.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'E.V 6/2/2021 21:29:55'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'E.V 6/3/2021 11:31:30'!
test12NoSePuedeMeterUnaCuentaAUnPortfolioQueYaLaTiene
	|portfolio  account|
	portfolio := Portfolio new.
	account  := ReceptiveAccount new.
	portfolio add: account .
	self should: [portfolio add: account.]
		raise: Error
		withExceptionDo: 
		[:anError| self assert: anError  messageText  equals:
			 Portfolio cantAddFinancialAssetToPortfolioWithSharedFinancialAssetErrorDescription].
		
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'E.V 6/3/2021 11:31:29'!
test13NoSePuedeMeterUnPortfolioEnSiMismo
	|portfolio |
	portfolio := Portfolio new.
	self should: [portfolio add: portfolio.]
		raise: Error
		withExceptionDo: 
		[:anError| self assert: anError  messageText  equals:
			 Portfolio cantAddFinancialAssetToPortfolioWithSharedFinancialAssetErrorDescription  ].
		
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'E.V 6/3/2021 11:31:30'!
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
			 Portfolio cantAddFinancialAssetToPortfolioWithSharedFinancialAssetErrorDescription].
		
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'E.V 6/3/2021 11:31:30'!
test15NoSePuedeAgregarPortfolio3APortfolio2SiAmbosPertenecenAPortfolio1
	|portfolio1 portfolio2 portfolio3|
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	
	self addFinancialAssets: (OrderedCollection with: portfolio2 with: portfolio3 ) to: portfolio1. 
	self should: [portfolio2 add: portfolio3 ]
		raise: Error
		withExceptionDo: 
		[:anError| self assert: anError  messageText  equals:
			 Portfolio cantAddFinancialAssetToPortfolioWithSharedFinancialAssetErrorDescription].
		
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'E.V 6/3/2021 11:31:30'!
test16NoSePuedeAgregarPortfolio2APortfolio3SiAbuelodePortfolio3EsPadreDeP2
	|abuelo padre hijo receptor | "abuelo es tambien padre de aAgregar"
	abuelo := Portfolio new.
	padre := Portfolio new.
	hijo := Portfolio new.
	receptor := Portfolio new.
	
	padre add: hijo.
	self addFinancialAssets: (OrderedCollection with: padre with: receptor) to: abuelo. 	
	
	self should: [receptor add: hijo]
		raise: Error
		withExceptionDo: 
		[:anError| self assert: anError  messageText  equals:
			 Portfolio cantAddFinancialAssetToPortfolioWithSharedFinancialAssetErrorDescription].
		
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'E.V 6/3/2021 11:31:30'!
test17NoSePuedeAgregarPortfolio2APortfolio3SiAbuelodePortfolio3EsPadreDeP2
	|abuelo padre hijo aAgregar | "abuelo es tambien padre de aAgregar"
	abuelo := Portfolio new.
	padre := Portfolio new.
	hijo := Portfolio new.
	aAgregar := Portfolio new.
	
	self addFinancialAssets: (OrderedCollection with: padre with: aAgregar ) to: abuelo. 	
	padre add: hijo.
	
	self should: [hijo add: aAgregar]
		raise: Error
		withExceptionDo: 
		[:anError| self assert: anError  messageText  equals:
			 Portfolio cantAddFinancialAssetToPortfolioWithSharedFinancialAssetErrorDescription].
		
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'E.V 6/3/2021 11:31:30'!
test18NoSePuedeAgregarUnPortfolioAOtroSiElPrimeroDosPadresYCompartenUno
	|padre1 padre2 padre3 hijo1 hijo2 |
	padre1 := Portfolio new.
	padre2 := Portfolio new.
	padre3 := Portfolio new.
	hijo1 := Portfolio new.
	hijo2 := Portfolio new.
	
	self addFinancialAssets: (OrderedCollection with: hijo1 with: hijo2) to: padre1. 	
	padre3 add: hijo1.
	padre2 add: hijo2.
		
	self should: [hijo1 add: hijo2]
		raise: Error
		withExceptionDo: 
		[:anError| self assert: anError  messageText  equals:
			 Portfolio cantAddFinancialAssetToPortfolioWithSharedFinancialAssetErrorDescription ].
		
	! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
FinancialAssetTest subclass: #ReceptiveAccountTest
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'E.V 6/2/2021 21:32:34'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := self createAccountWithDeposits:(OrderedCollection with:100). 
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'E.V 6/2/2021 21:32:01'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := self createAccountWithDeposits:(OrderedCollection with:100). 
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


!classDefinition: #ResumeTest category: 'Portfolio-Ejercicio'!
FinancialAssetTest subclass: #ResumeTest
	instanceVariableNames: 'balance0 deposito100 balance100 balance100negativo entradaTransferencia100 salidaTransferencia100 juanAccountName familyPortfolioName sonPortfolioName myAccountName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ResumeTest methodsFor: 'aux' stamp: 'E.V 6/1/2021 21:14:24'!
summaryReportOf:aPortfolio hasSameTransactionsthan: aFinancialServiceCollection
	|aPortfolioSummary aFinancialServicesSummary|
	aPortfolioSummary _ aPortfolio accountSummaryReport .
	aPortfolioSummary removeLast .
	aFinancialServicesSummary _ OrderedCollection new.
	aFinancialServiceCollection do: [:aFinancialService | | summary | 
		summary _  aFinancialService accountSummaryReport .
		summary removeLast.
		aFinancialServicesSummary addAll: summary ].
	^aPortfolioSummary = aFinancialServicesSummary .
	
	! !


!ResumeTest methodsFor: 'accountSummary test' stamp: 'E.V 6/2/2021 21:02:00'!
test00HacerSummaryDeAccountVaciaDaBalance0
	|account  |
	account  _ ReceptiveAccount new.
	self assert: (account  accountSummaryReport at:1) = balance0 .
	! !

!ResumeTest methodsFor: 'accountSummary test' stamp: 'E.V 6/2/2021 21:08:49'!
test01AlDepositarEnCuentaVaciaSeReflejaEnElResumen
	|account  |
	account  _ self createAccountWithDeposits: (OrderedCollection with:100).
	
	
	self assert: (account  accountSummaryReport at:1) = deposito100 .
	self assert: (account  accountSummaryReport at:2) = balance100 .
	! !

!ResumeTest methodsFor: 'accountSummary test' stamp: 'E.V 6/2/2021 21:09:15'!
test02AlDepositarVariasVecesEnCuentaVaciaSeReflejaEnElResumen
	|account  resultadoBalance|
	account  _ self createAccountWithDeposits: (OrderedCollection with:100 with:100).
	resultadoBalance  _ 'Balance = 200'.
	self assert: (account  accountSummaryReport at:1) = deposito100 .
	self assert: (account  accountSummaryReport at:2) = deposito100 .
	self assert: (account  accountSummaryReport at:3) = resultadoBalance .
	! !

!ResumeTest methodsFor: 'accountSummary test' stamp: 'E.V 6/2/2021 21:13:15'!
test03AlRetirarUnaVezDeCuentaVaciaSeReflejaEnElResumen
	|account resultadoRetiro |
	account  _ self createAccountWithWithdraws: (OrderedCollection with:100).

	resultadoRetiro  _ 'Extraccion por 100'.

	
	self assert: (account  accountSummaryReport at:1) = resultadoRetiro .

	self assert: (account  accountSummaryReport at:2) = balance100negativo .
	! !

!ResumeTest methodsFor: 'accountSummary test' stamp: 'E.V 6/2/2021 21:15:47'!
test04AlHacerTransferenciaSeReflejaEnElResumen
	|senderaccount receptorAccount  | 
	senderaccount  _ ReceptiveAccount new.
	receptorAccount _ ReceptiveAccount new.
	Transfer amount:100  from:senderaccount  to:receptorAccount .
	
	self assert: (senderaccount  accountSummaryReport at:1) = salidaTransferencia100 .
	self assert: (senderaccount  accountSummaryReport at:2) = balance100negativo .

	self assert: (receptorAccount  accountSummaryReport at:1) = entradaTransferencia100 .
	self assert: (receptorAccount  accountSummaryReport at:2) = balance100 .

! !

!ResumeTest methodsFor: 'accountSummary test' stamp: 'E.V 6/2/2021 21:17:23'!
test10PortfolioVacioTieneResumenConBalance0
	|aPortfolio|
	aPortfolio _  Portfolio new.
	self assert: (aPortfolio accountSummaryReport at:1) equals: balance0 .
	



! !

!ResumeTest methodsFor: 'accountSummary test' stamp: 'E.V 6/2/2021 21:18:56'!
test11PortfolioConUnaCuentaTieneElMismoResumenQueLaMisma
	|aPortfolio anAccount|
	aPortfolio _  Portfolio new.
	anAccount _ self createAccountWithDeposits: (OrderedCollection with:100).
	aPortfolio  add: anAccount .
	self assert: (aPortfolio accountSummaryReport) equals: (anAccount accountSummaryReport) .
	



! !

!ResumeTest methodsFor: 'accountSummary test' stamp: 'E.V 6/3/2021 11:23:55'!
test12PortfolioConDosCuentasTieneElMismoResumenQueSusResumenesCombinadosExceptoPorElBalance
	|aPortfolio anAccount anotherAccount|
	aPortfolio _  Portfolio new.
	anAccount _ self createAccountWithDeposits: (OrderedCollection with:100).
	anotherAccount _ self createAccountWithWithdraws: (OrderedCollection with:100).
	self addFinancialAssets: (OrderedCollection with: anAccount  with:anotherAccount )  to:aPortfolio .

	self assert: (self summaryReportOf: aPortfolio hasSameTransactionsthan: (OrderedCollection with:anAccount with:anotherAccount )).

	self assert: (aPortfolio accountSummaryReport last) equals: balance0 
	



! !

!ResumeTest methodsFor: 'accountSummary test' stamp: 'E.V 6/3/2021 11:23:55'!
test13AccountSummaryDeUnPortfolioConOtroDentroEsLaConjuncionDeSuResumenConElDeSuPortfolioInterior
	|anExternalPortfolio anInterlanPortfolio anAccount anotherAccount|
	anExternalPortfolio _  Portfolio new.
	anInterlanPortfolio _  Portfolio new.
	anAccount _ self createAccountWithDeposits: (OrderedCollection with:100).
	anotherAccount _ self createAccountWithWithdraws: (OrderedCollection with:100).
	
	self addFinancialAssets:(OrderedCollection with:anAccount )  to: anInterlanPortfolio .
	self addFinancialAssets:(OrderedCollection with:anotherAccount with:anInterlanPortfolio )  to: anExternalPortfolio .


	self assert: (self summaryReportOf: anExternalPortfolio hasSameTransactionsthan: (OrderedCollection with:anotherAccount with:anInterlanPortfolio )).

	self assert: (anExternalPortfolio accountSummaryReport last) equals: ('Balance = ' , anExternalPortfolio balance asString)
	



! !


!ResumeTest methodsFor: 'netTransfer test' stamp: 'E.V 6/1/2021 15:37:32'!
test05SiNoHayTransferenciasElNetTransferReportEs0
	|senderaccount receptorAccount | 
	senderaccount  _ ReceptiveAccount new.
	receptorAccount _ ReceptiveAccount new.

	self assert: senderaccount  netTransferReport = 0 .
	self assert: receptorAccount  netTransferReport = 0 .


! !

!ResumeTest methodsFor: 'netTransfer test' stamp: 'E.V 6/1/2021 15:36:38'!
test06AlHacerTransferenciaSeReflejaEnElReporteDeTransferencias
	|senderaccount receptorAccount | 
	senderaccount  _ ReceptiveAccount new.
	receptorAccount _ ReceptiveAccount new.
	Transfer amount:100  from:senderaccount  to:receptorAccount .

	self assert: senderaccount  netTransferReport = -100 .


	self assert: receptorAccount  netTransferReport = 100 .


! !

!ResumeTest methodsFor: 'netTransfer test' stamp: 'E.V 6/1/2021 15:36:45'!
test07AlHacer2TransferenciaSeReflejaEnElReporteDeTransferencias
	|senderaccount receptorAccount | 
	senderaccount  _ ReceptiveAccount new.
	receptorAccount _ ReceptiveAccount new.
	Transfer amount:100  from:senderaccount  to:receptorAccount .
	Transfer amount:1000  from:senderaccount  to:receptorAccount .

	self assert: senderaccount  netTransferReport equals: -1100 .


	self assert: receptorAccount  netTransferReport = 1100 .


! !

!ResumeTest methodsFor: 'netTransfer test' stamp: 'E.V 6/2/2021 21:23:54'!
test08AlHacerTransferenciaYUnDepositoElDepositoNoSeReflejaEnElReporteDeTransferencias
	|senderaccount receptorAccount | 
	senderaccount  _ ReceptiveAccount new.
	receptorAccount _ self createAccountWithDeposits: (OrderedCollection with:100).
	Transfer amount:100  from:senderaccount  to:receptorAccount .

	self assert: receptorAccount  netTransferReport equals: 100 .


! !

!ResumeTest methodsFor: 'netTransfer test' stamp: 'E.V 6/2/2021 21:24:21'!
test09AlHacerTransferenciaYUnRetiroElRetiroNoSeReflejaEnElReporteDeTransferencias
	|senderaccount receptorAccount | 
	senderaccount  _ ReceptiveAccount new.
	receptorAccount _ self createAccountWithWithdraws: (OrderedCollection with:100).
	Transfer amount:100  from:senderaccount  to:receptorAccount .


	self assert: receptorAccount  netTransferReport equals: 100 .


! !

!ResumeTest methodsFor: 'netTransfer test' stamp: 'E.V 6/2/2021 20:08:47'!
test14PortfolioVacioTieneTransferNetResume0
	|aPortfolio|
	aPortfolio _  Portfolio new.
	self assert: (aPortfolio netTransferReport) equals: 0.
	



! !

!ResumeTest methodsFor: 'netTransfer test' stamp: 'E.V 6/2/2021 20:12:08'!
test15PortfolioConUnaCuentaCon1TransferenciaTieneElNetTransferResumeQueLaMisma
	|aPortfolio aSenderAccount aRecieverAccount|
	aPortfolio _  Portfolio new.
	aSenderAccount _ ReceptiveAccount new.
	aRecieverAccount _ ReceptiveAccount new.
	Transfer amount: 100 from: aSenderAccount  to: aRecieverAccount .
	aPortfolio  add: aSenderAccount .
	self assert: (aPortfolio netTransferReport ) equals: (aSenderAccount netTransferReport ) .
	



! !

!ResumeTest methodsFor: 'netTransfer test' stamp: 'E.V 6/3/2021 11:23:55'!
test16PortfolioConDosCuentasCon1TransferenciaTieneElNetTransferResumeQueLaMisma
	|aPortfolio aSenderAccount aRecieverAccount|
	aPortfolio _  Portfolio new.
	aSenderAccount _ ReceptiveAccount new.
	aRecieverAccount _ ReceptiveAccount new.
	Transfer amount: 100 from: aSenderAccount  to: aRecieverAccount .
	
	self addFinancialAssets: (OrderedCollection with:aSenderAccount with:aRecieverAccount) to: aPortfolio .

	self assert: (aPortfolio netTransferReport ) equals: 
		(aSenderAccount netTransferReport  + aRecieverAccount netTransferReport ) .
	



! !

!ResumeTest methodsFor: 'netTransfer test' stamp: 'E.V 6/3/2021 11:23:55'!
test17NetTransferResumeDeUnPortfolioConOtroDentroEsLaSumaNetTransferResumeDelRestoDeLosElementosDelPrimeroConElDelSegundo
	|anExternalPortfolio anInterlanPortfolio aSenderAccount aReceiverAccount|
	anExternalPortfolio _  Portfolio new.
	anInterlanPortfolio _  Portfolio new.
	aSenderAccount _ ReceptiveAccount new.
	aReceiverAccount _ ReceptiveAccount new.
	Transfer amount: 100 from:aSenderAccount  to:aReceiverAccount .
	
	anInterlanPortfolio  add: aSenderAccount .
	self addFinancialAssets: (OrderedCollection with:aReceiverAccount with:anInterlanPortfolio) to: anExternalPortfolio .

	self assert: anExternalPortfolio netTransferReport equals: 
		(anInterlanPortfolio netTransferReport + aReceiverAccount  netTransferReport )




! !


!ResumeTest methodsFor: 'setUp/tearDown' stamp: 'E.V 6/3/2021 11:14:04'!
setUp

deposito100  _ 'Depósito por 100'.	


balance0  _ 'Balance = 0'.
balance100  _ 'Balance = 100'.
balance100negativo  _ 'Balance = -100'.


salidaTransferencia100  _ 'Salida por transferencia de 100'.
entradaTransferencia100 _ 'Entrada por transferencia de 100'.

juanAccountName _ 'Cuenta de Juan'.
myAccountName _ 'Cuenta Mia'.
familyPortfolioName _ 'Portfolio de la familia'.
sonPortfolioName  _ 'Portfolio de hijos'.! !



!ResumeTest methodsFor: 'treeReport test' stamp: 'E.V 6/3/2021 11:04:39'!
test01ElTreeReportDeUnaCuentaEsElNombreDeLaMisma
	|anAccount |
	.
	anAccount  _ ReceptiveAccount named: juanAccountName.
	self assert: (anAccount treeReport size) equals:1.
	self assert: (anAccount treeReport ) includes: juanAccountName.
! !

!ResumeTest methodsFor: 'treeReport test' stamp: 'E.V 6/3/2021 11:06:41'!
test02ElTreeReportDeUnPortfolioVacioEsSuNombre
	|aPortfolio |
	aPortfolio  _ Portfolio named: familyPortfolioName.
	
	self assert: (aPortfolio treeReport) includes: familyPortfolioName.
	self assert: aPortfolio treeReport size equals:1.
	! !

!ResumeTest methodsFor: 'treeReport test' stamp: 'E.V 6/3/2021 11:11:40'!
test03ElTreeReportDeUnPortfolioConUnaCuentaTieneEstructuraDeArbol
	|aPortfolio anAccount aPortfolioTreeReport|
	aPortfolio  _ Portfolio named: familyPortfolioName .
	
	anAccount  _ ReceptiveAccount named: juanAccountName .
	aPortfolio add: anAccount .
	aPortfolioTreeReport _ aPortfolio treeReport.
	
	
	self assert: aPortfolioTreeReport size equals:2.
	self assert: (aPortfolioTreeReport at:1) equals: familyPortfolioName .
	
	self assert: ((aPortfolioTreeReport at:2) size) equals: 1.
	self assert: ((aPortfolioTreeReport at:2) at:1) equals: juanAccountName .
	! !

!ResumeTest methodsFor: 'treeReport test' stamp: 'E.V 6/3/2021 11:23:55'!
test04ElTreeReportDeUnPortfolioConUnaCuentaYUnPortfolioConUnaCuentaTieneEstructuraDeArbol
	|aPortfolio anotherPortfolio anAccount anotherAccount aPortfolioTreeReport aPortfolioTreeReportLvl2
	aPortfolioTreeReportLvl3 
	|
	aPortfolio  _ Portfolio named: familyPortfolioName .
	anotherPortfolio  _ Portfolio named: sonPortfolioName .
	
	anAccount  _ ReceptiveAccount  named: myAccountName .
	anotherAccount  _ ReceptiveAccount new named: juanAccountName .
	
	anotherPortfolio add: anotherAccount .
	self addFinancialAssets: (OrderedCollection with: anAccount with:anotherPortfolio ) to: aPortfolio .
	
	aPortfolioTreeReport _ aPortfolio treeReport.
	aPortfolioTreeReportLvl2 _ OrderedCollection with: (aPortfolioTreeReport at:2) with: (aPortfolioTreeReport at:3).
.
	
	aPortfolioTreeReportLvl3 _ OrderedCollection new.
	aPortfolioTreeReportLvl3 addAll: ((aPortfolioTreeReportLvl2 at:2)at:2).
	
	self assert: aPortfolioTreeReport size equals:3.
	self assert: aPortfolioTreeReport  includes: familyPortfolioName .
	
	self assert: (aPortfolioTreeReportLvl2 size) equals: 2.
	self assert: (aPortfolioTreeReportLvl2 at:1) includes: myAccountName.
	self assert: (aPortfolioTreeReportLvl2 at:2) includes: sonPortfolioName .
	
	self assert: aPortfolioTreeReportLvl3 size equals: 1.
	self assert: (aPortfolioTreeReportLvl3) includes: juanAccountName .
	
	! !


!ResumeTest methodsFor: 'special tree report test' stamp: 'E.V 6/3/2021 11:10:53'!
test01ElSpecialTreeReportDeUnAccountEsSuNombreYBalanceEn0
	|anAccount |
	anAccount  _ ReceptiveAccount  named: juanAccountName .
	
	self assert: (anAccount accountSpecialTreeReport size) equals:2.
	self assert: (anAccount accountSpecialTreeReport ) includes: juanAccountName .
	self assert: (anAccount accountSpecialTreeReport at:2 ) includes: balance0 .
	self assert: ((anAccount accountSpecialTreeReport at:2) size ) equals: 1 .
	
	! !

!ResumeTest methodsFor: 'special tree report test' stamp: 'E.V 6/3/2021 11:07:50'!
test02ElSpecialTreeReportDeUnPortfolioVacioEsSuNombreYElBalance0
	|aPortfolio|
	aPortfolio  _ Portfolio named: familyPortfolioName .
	
	self assert: (aPortfolio accountSpecialTreeReport size) equals: 2.
	self assert: (aPortfolio accountSpecialTreeReport ) includes: familyPortfolioName.
	self assert: (aPortfolio accountSpecialTreeReport at:2) includes: balance0 .! !

!ResumeTest methodsFor: 'special tree report test' stamp: 'E.V 6/3/2021 11:09:03'!
test03ElSpecialTreeReportDeUnPortfolioConUnaCuentaTieneEstructuraDeArbol
	|aPortfolio anAccount aPortfolioTreeReport|
	aPortfolio  _ Portfolio named: familyPortfolioName .
	
	anAccount  _ ReceptiveAccount named: juanAccountName .
	Deposit register:100  on:anAccount .
	aPortfolio add: anAccount .
	
	aPortfolioTreeReport _ aPortfolio accountSpecialTreeReport .
	
	
	self assert: aPortfolioTreeReport size equals:3.
	self assert: aPortfolioTreeReport includes: familyPortfolioName .
	self assert: (aPortfolioTreeReport at:3) includes: balance100 .
	
	self assert: ((aPortfolioTreeReport at:2) size) equals: 2.
	self assert: (aPortfolioTreeReport at:2) includes: juanAccountName .
	

	self assert: ((aPortfolioTreeReport at:2)at:2) size equals: 2.	
	self assert: ((aPortfolioTreeReport at:2)at:2) includes: deposito100 .
	self assert: ((aPortfolioTreeReport at:2)at:2) includes: balance100 .	! !

!ResumeTest methodsFor: 'special tree report test' stamp: 'E.V 6/3/2021 11:23:55'!
test04ElSpecialTreeReportDeUnPortfolioConUnaCuentaYUnPortfolioConUnaCuentaTieneEstructuraDeArbol
	|aPortfolio anotherPortfolio anAccount anotherAccount aPortfolioSpecialTreeReport           aPortfolioSpecialTreeReportLvl2  aPortfolioSpecialTreeReportLvl3 aPortfolioSpecialTreeReportLvl4 |
	
	aPortfolio  _ Portfolio named:familyPortfolioName .
	anotherPortfolio  _ Portfolio  named: sonPortfolioName.
	
	anAccount  _ ReceptiveAccount  named: myAccountName .
	anotherAccount  _ ReceptiveAccount  named: juanAccountName .
	Deposit register: 100 on: anotherAccount .
	
	anotherPortfolio add: anotherAccount .	
	self addFinancialAssets: (OrderedCollection with: anAccount with:anotherPortfolio ) to: aPortfolio .
	
	aPortfolioSpecialTreeReport _ aPortfolio accountSpecialTreeReport .
	aPortfolioSpecialTreeReportLvl2 _ OrderedCollection with: (aPortfolioSpecialTreeReport at:2) with: (aPortfolioSpecialTreeReport at:3) with: (aPortfolioSpecialTreeReport at:4).
.
	
	aPortfolioSpecialTreeReportLvl3 _ OrderedCollection new.
	aPortfolioSpecialTreeReportLvl3 add: ((aPortfolioSpecialTreeReportLvl2 at:1) at:2).
	aPortfolioSpecialTreeReportLvl3 add: ((aPortfolioSpecialTreeReportLvl2 at:2) at:2).
	
	aPortfolioSpecialTreeReportLvl4 _ OrderedCollection new.
	aPortfolioSpecialTreeReportLvl4 add: ((aPortfolioSpecialTreeReportLvl3 at:2) at:2).
	
	self assert: aPortfolioSpecialTreeReport size equals:4.
	self assert: aPortfolioSpecialTreeReport  includes: familyPortfolioName .
	
	self assert: (aPortfolioSpecialTreeReportLvl2 size) equals: 3.
	self assert: (aPortfolioSpecialTreeReportLvl2 at:1) includes: myAccountName .
	self assert: (aPortfolioSpecialTreeReportLvl2 at:2) includes: sonPortfolioName .
	self assert: (aPortfolioSpecialTreeReportLvl2 at:3) includes: balance100 .	
	
	self assert: aPortfolioSpecialTreeReportLvl3 size equals: 2.
	self assert: (aPortfolioSpecialTreeReportLvl3 at:1) includes: balance0 .
	self assert: (aPortfolioSpecialTreeReportLvl3 at:1) size equals: 1.
	
	self assert: (aPortfolioSpecialTreeReportLvl3 at:2) includes: juanAccountName .
	self assert: (aPortfolioSpecialTreeReportLvl3 at:2) size equals: 2.
	
	self assert: (aPortfolioSpecialTreeReportLvl4 at:1) size equals: 2.
	self assert: (aPortfolioSpecialTreeReportLvl4 at:1) includes: deposito100 .
	self assert: (aPortfolioSpecialTreeReportLvl4 at:1) includes: balance100 .! !


!classDefinition: #TransferTest category: 'Portfolio-Ejercicio'!
FinancialAssetTest subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferTest methodsFor: 'test' stamp: 'E.V 5/27/2021 20:46:36'!
test01TransferirEntreAccountsCambiaElBalanceCorrectamente
	|receptorAccount senderAccount|
	receptorAccount := ReceptiveAccount new.
	senderAccount := ReceptiveAccount new.
	
	Transfer amount:10 from:senderAccount  to:receptorAccount .
	
	self assert: receptorAccount balance = 10.
	self assert: senderAccount  balance = -10.! !

!TransferTest methodsFor: 'test' stamp: 'E.V 5/27/2021 21:11:42'!
test02AlRecibirUnaTransferenciaSeTieneEseDepositoRegistrado
	|receptorAccount senderAccount aTransfer|
	receptorAccount := ReceptiveAccount new.
	senderAccount := ReceptiveAccount new.
	
	aTransfer _ Transfer amount:10 from:senderAccount  to:receptorAccount .
	self assert: (receptorAccount hasRegistered: aTransfer deposit).! !

!TransferTest methodsFor: 'test' stamp: 'E.V 5/27/2021 21:19:20'!
test03AlEnviarUnaTransferenciaSeTieneEseWithdrawRegistrado
	|receptorAccount senderAccount aTransfer|
	receptorAccount := ReceptiveAccount new.
	senderAccount := ReceptiveAccount new.
	
	aTransfer _ Transfer amount:10 from:senderAccount  to:receptorAccount .
	self assert: (senderAccount hasRegistered: aTransfer withdraw).! !

!TransferTest methodsFor: 'test' stamp: 'E.V 5/28/2021 15:56:19'!
test04AlHacerUnaTransferenciaSePuedeObtenerALaTransferenciaDesdeElDeposito
	|receptorAccount senderAccount aTransfer aDeposit|
	receptorAccount := ReceptiveAccount new.
	senderAccount := ReceptiveAccount new.
	
	aTransfer _ Transfer amount:10 from:senderAccount  to:receptorAccount .
	aDeposit _ aTransfer deposit.
	self assert: (aDeposit isMyTransfer: aTransfer ).! !

!TransferTest methodsFor: 'test' stamp: 'E.V 5/28/2021 15:57:28'!
test05AlHacerUnaTransferenciaSePuedeObtenerALaTransferenciaDesdeElWithdraw
	|receptorAccount senderAccount aTransfer aWithdraw|
	receptorAccount := ReceptiveAccount new.
	senderAccount := ReceptiveAccount new.
	
	aTransfer _ Transfer amount:10 from:senderAccount  to:receptorAccount .
	aWithdraw _ aTransfer withdraw.
	self assert: (aWithdraw isMyTransfer: aTransfer ).! !

!TransferTest methodsFor: 'test' stamp: 'E.V 6/2/2021 20:52:49'!
test06AlHacerUnaTransferenciaSePuedeAccederAAmbasPatas
	|receptorAccount senderAccount aTransfer aWithdraw aDeposit|
	receptorAccount := ReceptiveAccount new.
	senderAccount := ReceptiveAccount new.
	
	aTransfer _ Transfer amount:10 from:senderAccount  to:receptorAccount .
	aWithdraw _ aTransfer withdraw.
	aDeposit _ aTransfer deposit.
	self assert: (aWithdraw isMyOtherLeg: aDeposit ).
	self assert: (aDeposit isMyOtherLeg: aWithdraw ).! !

!TransferTest methodsFor: 'test' stamp: 'E.V 6/1/2021 20:03:17'!
test07NoSePuedeHacerUnaTransferenciaPor0
	|receptorAccount senderAccount |
	receptorAccount := ReceptiveAccount new.
	senderAccount := ReceptiveAccount new.
	
	
	self should: [Transfer amount:0 from:senderAccount  to:receptorAccount .]
		raise: Error
		withExceptionDo: 
		[:anError| self assert: anError  messageText  equals:
			 Transfer cantTransferFor0OrLessErrorDescription ].
	! !

!TransferTest methodsFor: 'test' stamp: 'E.V 6/1/2021 20:03:17'!
test08NoSePuedeHacerUnaTransferenciaPorUnValorNegativo
	|receptorAccount senderAccount |
	receptorAccount := ReceptiveAccount new.
	senderAccount := ReceptiveAccount new.
	
	
	self should: [Transfer amount: -1000 from:senderAccount  to:receptorAccount .]
		raise: Error
		withExceptionDo: 
		[:anError| self assert: anError  messageText  equals:
			 Transfer cantTransferFor0OrLessErrorDescription ].
	! !

!TransferTest methodsFor: 'test' stamp: 'E.V 6/1/2021 20:05:20'!
test09NoSePuedenHacerTransferenciasAunoMismo
	|receptorAccount senderAccount |
	receptorAccount := ReceptiveAccount new.
	senderAccount := receptorAccount .
	
	
	self should: [Transfer amount: 1000 from:senderAccount  to:receptorAccount .]
		raise: Error
		withExceptionDo: 
		[:anError| self assert: anError  messageText  equals:
			 Transfer anAccountCantTransferToItself ].
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


!AccountTransaction methodsFor: 'testing' stamp: 'E.V 6/3/2021 11:32:50'!
includes: aFinancialAsset
	^ (self == aFinancialAsset).! !


!AccountTransaction methodsFor: 'report' stamp: 'E.V 6/1/2021 15:15:58'!
getSummaryFor:aReportGenerator
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


!Deposit methodsFor: 'report' stamp: 'E.V 6/1/2021 15:17:16'!
getSummaryFor:aReportGenerator
	aReportGenerator depositReport: self! !


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


!classDefinition: #TransferTransaction category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #TransferTransaction
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferTransaction methodsFor: 'value' stamp: 'E.V 5/31/2021 21:56:42'!
value 

	^ transfer value! !


!TransferTransaction methodsFor: 'testing' stamp: 'E.V 5/30/2021 15:09:29'!
isMyOtherLeg:aTransferTransactions
	self subclassResponsibility ! !

!TransferTransaction methodsFor: 'testing' stamp: 'E.V 5/31/2021 21:56:42'!
isMyTransfer: aTransfer
	^ aTransfer == transfer .! !



!TransferTransaction methodsFor: 'initialization' stamp: 'E.V 5/31/2021 21:56:42'!
initializeFor: aTransfer
	transfer _ aTransfer.! !


!classDefinition: #TransferDeposit category: 'Portfolio-Ejercicio'!
TransferTransaction subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferDeposit methodsFor: 'testing' stamp: 'E.V 5/31/2021 21:56:42'!
isMyOtherLeg:aWithdraw
	^transfer isMyWithdraw: aWithdraw .! !



!TransferDeposit methodsFor: 'report' stamp: 'E.V 6/1/2021 15:33:29'!
getSummaryFor: aReportGenerator 
	aReportGenerator transferDepositReport: self.! !


!TransferDeposit methodsFor: 'value' stamp: 'E.V 5/31/2021 21:56:42'!
addToBalance: actualBalance
	^ transfer addToBalance:actualBalance ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: 'Portfolio-Ejercicio'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'as yet unclassified' stamp: 'E.V 5/30/2021 15:15:39'!
for: aValue with: aTransfer

	^ self new initializeFor: aTransfer.! !

!TransferDeposit class methodsFor: 'as yet unclassified' stamp: 'E.V 5/28/2021 15:46:08'!
register: aValue on: account with:aTrasfer

	| transaction |
	
	transaction := self for: aValue with: aTrasfer.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferWithdraw category: 'Portfolio-Ejercicio'!
TransferTransaction subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!


!TransferWithdraw methodsFor: 'value' stamp: 'E.V 5/31/2021 21:56:42'!
addToBalance: actualBalance
	^ transfer decreaseBalance:actualBalance ! !


!TransferWithdraw methodsFor: 'report' stamp: 'E.V 6/1/2021 15:31:01'!
getSummaryFor: reportGenerator 
	reportGenerator transferWithdrawReport: self! !


!TransferWithdraw methodsFor: 'testing' stamp: 'E.V 6/2/2021 20:38:55'!
isMyOtherLeg:aDeposit
	^transfer isMyDeposit: aDeposit .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: 'Portfolio-Ejercicio'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'as yet unclassified' stamp: 'E.V 5/30/2021 15:15:54'!
for: aValue with: aTransfer

	^ self new initializeFor: aTransfer.! !

!TransferWithdraw class methodsFor: 'as yet unclassified' stamp: 'E.V 5/28/2021 16:00:03'!
register: aValue on: account with:aTrasfer

	| transaction |
	
	transaction := self for: aValue with: aTrasfer.
	account register: transaction.
		
	^ transaction! !


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


!Withdraw methodsFor: 'report' stamp: 'E.V 6/1/2021 15:28:43'!
getSummaryFor: reportGenerator 
	reportGenerator withdrawReport: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialAsset category: 'Portfolio-Ejercicio'!
Object subclass: #FinancialAsset
	instanceVariableNames: 'father name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialAsset methodsFor: 'balance' stamp: 'sc 5/23/2021 17:15:25'!
balance
	self subclassResponsibility.! !


!FinancialAsset methodsFor: 'testing' stamp: 'sc 5/23/2021 17:13:45'!
hasRegistered: aTransaction
	self subclassResponsibility.! !

!FinancialAsset methodsFor: 'testing' stamp: 'E.V 6/3/2021 11:36:27'!
myRootsShareDecendenceWith: portfolioRoot
	^ self roots anySatisfy:[:aRoot| aRoot sharesDescendenceWith: portfolioRoot.]
	! !

!FinancialAsset methodsFor: 'testing' stamp: 'E.V 6/3/2021 11:29:12'!
sharesFinancialAssetWith: aFinancialAsset
	^ self roots anySatisfy: 	[:aRoot| aFinancialAsset myRootsShareDecendenceWith: aRoot.]! !


!FinancialAsset methodsFor: 'transactions' stamp: 'E.V 6/2/2021 20:42:07'!
transactions
	self subclassResponsibility ! !


!FinancialAsset methodsFor: 'operations' stamp: 'sc 5/23/2021 17:16:37'!
addFather: aPortfolio
	father add: aPortfolio.! !

!FinancialAsset methodsFor: 'operations' stamp: 'sc 5/24/2021 15:15:22'!
roots
	self subclassResponsibility ! !

!FinancialAsset methodsFor: 'operations' stamp: 'sc 5/24/2021 15:54:59'!
sharesDescendenceWith: aPortfolioRoot
	self subclassResponsibility ! !


!FinancialAsset methodsFor: 'setting' stamp: 'E.V 6/3/2021 11:00:06'!
named: aFinancialServiceName
	name _ aFinancialServiceName ! !


!FinancialAsset methodsFor: 'initialize' stamp: 'sc 5/24/2021 16:00:33'!
initialize
	self subclassResponsibility ! !


!FinancialAsset methodsFor: 'report' stamp: 'E.V 6/3/2021 10:47:27'!
accountSpecialTreeReport
	^ AccountSpecialTreeReportGenerator new generateReportFor: self.! !

!FinancialAsset methodsFor: 'report' stamp: 'E.V 6/3/2021 10:47:27'!
accountSummaryReport

	^ AccountSummaryGenerator new generateReportFor: self.
	! !

!FinancialAsset methodsFor: 'report' stamp: 'E.V 6/3/2021 11:28:18'!
financialAssetReportFor:aReportGenerator
	self subclassResponsibility ! !

!FinancialAsset methodsFor: 'report' stamp: 'E.V 6/3/2021 10:47:27'!
netTransferReport
	^ TransferNetGenerator new generateReportFor: self! !

!FinancialAsset methodsFor: 'report' stamp: 'E.V 6/2/2021 20:40:27'!
transactionReportFor: aReportGenerator
	self subclassResponsibility ! !

!FinancialAsset methodsFor: 'report' stamp: 'E.V 6/3/2021 10:47:27'!
treeReport
	^ TreeReportGenerator new generateReportFor: self.! !


!FinancialAsset methodsFor: 'accessing' stamp: 'E.V 6/2/2021 22:10:46'!
returnName
	^name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FinancialAsset class' category: 'Portfolio-Ejercicio'!
FinancialAsset class
	instanceVariableNames: ''!

!FinancialAsset class methodsFor: 'instance creation' stamp: 'E.V 6/3/2021 11:01:32'!
named: aFinancialServiceName
	^self new
		named:aFinancialServiceName;
		yourself 
! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialAsset subclass: #Portfolio
	instanceVariableNames: 'financialAssetCollection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'E.V 6/3/2021 11:40:16'!
hasRegistered: aDeposit 
	^ (financialAssetCollection anySatisfy: [:anAccountOrPotfolio| anAccountOrPotfolio hasRegistered: aDeposit]) .! !

!Portfolio methodsFor: 'testing' stamp: 'E.V 6/3/2021 11:40:16'!
includes: aFinancialServiceToFind
	 ^self = aFinancialServiceToFind  or:
	  (financialAssetCollection anySatisfy:
					 [:aPortfolioOrAccount | aPortfolioOrAccount includes: aFinancialServiceToFind])
	
	! !


!Portfolio methodsFor: 'error handling' stamp: 'E.V 6/3/2021 11:31:29'!
raiseErrorIfPortfolioHasSharedFinancialAsset: aFinancialAsset
	(self sharesFinancialAssetWith: aFinancialAsset )	
	ifTrue: [self error: self class cantAddFinancialAssetToPortfolioWithSharedFinancialAssetErrorDescription ].
	! !


!Portfolio methodsFor: 'balance' stamp: 'E.V 6/3/2021 11:40:16'!
balance
	|balance|
	balance := financialAssetCollection sum:[:anAccountOrPortfolio| anAccountOrPortfolio balance] ifEmpty: [0].
	^balance! !


!Portfolio methodsFor: 'operations' stamp: 'E.V 6/3/2021 11:40:16'!
add: aFinancialService
	self raiseErrorIfPortfolioHasSharedFinancialAsset: aFinancialService.
	aFinancialService addFather: self.
	financialAssetCollection add: aFinancialService.
	! !

!Portfolio methodsFor: 'operations' stamp: 'sc 5/24/2021 15:15:05'!
roots
	|rootsList|
	rootsList := OrderedCollection new.
	father do: [:aFather| rootsList addAll: aFather roots].
	(father isEmpty) ifTrue: [rootsList add: self].
	^rootsList.! !

!Portfolio methodsFor: 'operations' stamp: 'E.V 6/3/2021 11:40:16'!
sharesDescendenceWith: aPortfolioRoot
	^ (aPortfolioRoot includes: self) or:  (financialAssetCollection anySatisfy: [:AFinancialService| aPortfolioRoot sharesDescendenceWith: AFinancialService]).! !


!Portfolio methodsFor: 'initialize' stamp: 'E.V 6/3/2021 11:40:16'!
initialize
	financialAssetCollection := OrderedCollection new.
	father := OrderedCollection  new.! !


!Portfolio methodsFor: 'report' stamp: 'E.V 6/3/2021 11:40:16'!
addElementsToReport: aReportGenerator
		aReportGenerator portfolioElementsReport: financialAssetCollection .
	! !

!Portfolio methodsFor: 'report' stamp: 'E.V 6/3/2021 11:28:18'!
financialAssetReportFor:aReportGenerator
	aReportGenerator portfolioReport: self! !

!Portfolio methodsFor: 'report' stamp: 'E.V 6/3/2021 11:40:16'!
transactionReportFor: aReportGenerator
		financialAssetCollection do: [:aFinancialService | aFinancialService transactionReportFor:aReportGenerator]! !


!Portfolio methodsFor: 'transactions' stamp: 'E.V 6/3/2021 11:40:16'!
transactions
	|transactions|
	transactions := OrderedCollection  new.
	financialAssetCollection do: [:anAccountOrPortfolio | transactions  addAll: (anAccountOrPortfolio transactions)].
	^transactions .
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!


!Portfolio class methodsFor: 'error descriptions' stamp: 'E.V 6/3/2021 11:31:29'!
cantAddFinancialAssetToPortfolioWithSharedFinancialAssetErrorDescription
	^ 'No me vayas a agregar un portfolio de la misma familia capo, ni a patadas'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialAsset subclass: #ReceptiveAccount
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


!ReceptiveAccount methodsFor: 'report' stamp: 'E.V 6/3/2021 11:28:18'!
financialAssetReportFor:aReportGenerator
	aReportGenerator receptiveAccountReport: self! !

!ReceptiveAccount methodsFor: 'report' stamp: 'E.V 6/1/2021 15:49:52'!
transactionReportFor:aReportGenerator

	transactions  do: [:aTransaction| aTransaction getSummaryFor: aReportGenerator ]! !


!ReceptiveAccount methodsFor: 'operations' stamp: 'E.V 5/28/2021 15:41:43'!
receiveTransferFor: anAmount withTransfer: aTransfer  
	^TransferDeposit register:anAmount  on:self with:aTransfer . ! !

!ReceptiveAccount methodsFor: 'operations' stamp: 'sc 5/24/2021 15:14:46'!
roots
	|rootsList|
	rootsList := OrderedCollection new.
	father do: [:aFather| rootsList addAll: aFather roots].
	^rootsList.! !

!ReceptiveAccount methodsFor: 'operations' stamp: 'E.V 5/28/2021 16:02:02'!
sendTransferFor: anAmount withTransfer: aTransfer  
	^TransferWithdraw  register:anAmount  on: self with:aTransfer .! !

!ReceptiveAccount methodsFor: 'operations' stamp: 'sc 5/24/2021 15:54:04'!
sharesDescendenceWith: aPortfolioRoot
	^ (aPortfolioRoot includes: self)! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'sc 5/17/2021 20:42:26'!
balance
	|balanceValue|
	balanceValue := 0.
	transactions do: [:aTransaction| balanceValue := aTransaction addToBalance: balanceValue ].
	^balanceValue .! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'sc 5/24/2021 16:01:38'!
hasRegistered: aTransaction
	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'sc 5/23/2021 17:45:50'!
includes: aFinancialService
	^aFinancialService = self.! !


!classDefinition: #ReportGenerator category: 'Portfolio-Ejercicio'!
Object subclass: #ReportGenerator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReportGenerator methodsFor: 'initialization' stamp: 'E.V 6/3/2021 10:44:45'!
initialize
	self subclassResponsibility ! !


!ReportGenerator methodsFor: 'report' stamp: 'E.V 6/1/2021 15:17:46'!
depositReport: aDeposit
	self subclassResponsibility ! !

!ReportGenerator methodsFor: 'report' stamp: 'E.V 6/3/2021 10:47:27'!
generateReportFor:anAccount
	self subclassResponsibility ! !

!ReportGenerator methodsFor: 'report' stamp: 'E.V 6/3/2021 10:35:29'!
portfolioElementsReport: aFinancialServiceList
	self subclassResponsibility ! !

!ReportGenerator methodsFor: 'report' stamp: 'E.V 6/3/2021 10:36:00'!
portfolioReport:aPortfolio
	self subclassResponsibility ! !

!ReportGenerator methodsFor: 'report' stamp: 'E.V 6/3/2021 10:41:15'!
receptiveAccountReport: aReceptiveAccount
	self subclassResponsibility ! !

!ReportGenerator methodsFor: 'report' stamp: 'E.V 6/1/2021 15:46:10'!
transferDepositReport: aTransferDeposit 
	self subclassResponsibility ! !

!ReportGenerator methodsFor: 'report' stamp: 'E.V 6/1/2021 15:45:57'!
transferWithdrawReport: aTransferWithdraw 
	self subclassResponsibility ! !

!ReportGenerator methodsFor: 'report' stamp: 'E.V 6/1/2021 15:45:40'!
withdrawReport: aWithdraw 
	self subclassResponsibility ! !


!classDefinition: #AccountSummaryGenerator category: 'Portfolio-Ejercicio'!
ReportGenerator subclass: #AccountSummaryGenerator
	instanceVariableNames: 'report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountSummaryGenerator methodsFor: 'report' stamp: 'E.V 6/3/2021 10:48:14'!
depositReport: aDeposit
	report add: 'Depósito por ', (aDeposit value asString) ! !

!AccountSummaryGenerator methodsFor: 'report' stamp: 'E.V 6/3/2021 10:48:14'!
generateReportFor: aFinancialService
	
		aFinancialService transactionReportFor: self.
		report add: 'Balance = ', aFinancialService balance asString .
		^report 
		! !

!AccountSummaryGenerator methodsFor: 'report' stamp: 'E.V 6/3/2021 10:48:14'!
transferDepositReport: aTransferDeposit 
	report add: 'Entrada por transferencia de ', (aTransferDeposit value asString)! !

!AccountSummaryGenerator methodsFor: 'report' stamp: 'E.V 6/3/2021 10:48:14'!
transferWithdrawReport: aTransferWithdraw 
	report add: 'Salida por transferencia de ' , 				(aTransferWithdraw value asString)! !

!AccountSummaryGenerator methodsFor: 'report' stamp: 'E.V 6/3/2021 10:48:14'!
withdrawReport: aWithdraw 
	report add: 'Extraccion por ', (aWithdraw value asString)! !


!AccountSummaryGenerator methodsFor: 'not used' stamp: 'E.V 6/3/2021 10:40:02'!
portfolioElementsReport: aFinancialServiceList! !

!AccountSummaryGenerator methodsFor: 'not used' stamp: 'E.V 6/3/2021 10:40:43'!
portfolioReport:aPortfolio! !

!AccountSummaryGenerator methodsFor: 'not used' stamp: 'E.V 6/3/2021 10:41:23'!
receptiveAccountReport: aReceptiveAccount! !


!AccountSummaryGenerator methodsFor: 'initialization' stamp: 'E.V 6/3/2021 10:48:14'!
initialize
	report _ OrderedCollection new.! !


!classDefinition: #TransferNetGenerator category: 'Portfolio-Ejercicio'!
ReportGenerator subclass: #TransferNetGenerator
	instanceVariableNames: 'netValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferNetGenerator methodsFor: 'initialization' stamp: 'E.V 6/1/2021 15:44:34'!
initialize
	netValue  _ 0! !


!TransferNetGenerator methodsFor: 'report' stamp: 'E.V 6/3/2021 10:47:27'!
generateReportFor:aFinancialService

		aFinancialService transactionReportFor: self.
		^netValue ! !

!TransferNetGenerator methodsFor: 'report' stamp: 'E.V 6/1/2021 15:51:53'!
transferDepositReport: aTransferDeposit 
	netValue _ netValue  + aTransferDeposit value! !

!TransferNetGenerator methodsFor: 'report' stamp: 'E.V 6/1/2021 15:51:33'!
transferWithdrawReport: aTransferWithdraw 
	netValue  _ netValue - aTransferWithdraw value.! !


!TransferNetGenerator methodsFor: 'not used' stamp: 'E.V 6/1/2021 15:52:11'!
depositReport: aDeposit 
	! !

!TransferNetGenerator methodsFor: 'not used' stamp: 'E.V 6/3/2021 10:43:25'!
portfolioElementsReport: aFinancialServiceList
! !

!TransferNetGenerator methodsFor: 'not used' stamp: 'E.V 6/3/2021 10:43:53'!
portfolioReport:aPortfolio
	! !

!TransferNetGenerator methodsFor: 'not used' stamp: 'E.V 6/3/2021 10:44:06'!
receptiveAccountReport: aReceptiveAccount! !

!TransferNetGenerator methodsFor: 'not used' stamp: 'E.V 6/1/2021 15:53:11'!
withdrawReport: aWithdraw 
! !


!classDefinition: #TreeReportGenerator category: 'Portfolio-Ejercicio'!
ReportGenerator subclass: #TreeReportGenerator
	instanceVariableNames: 'reportTree'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TreeReportGenerator methodsFor: 'initialization' stamp: 'E.V 6/3/2021 10:48:59'!
initialize
	reportTree _ OrderedCollection new.! !


!TreeReportGenerator methodsFor: 'report' stamp: 'E.V 6/3/2021 11:28:18'!
generateReportFor:aFinancialService
		aFinancialService financialAssetReportFor: self.
		^reportTree! !

!TreeReportGenerator methodsFor: 'report' stamp: 'E.V 6/3/2021 10:31:07'!
newReportFor:aFinancialService

	^ aFinancialService treeReport .! !

!TreeReportGenerator methodsFor: 'report' stamp: 'E.V 6/3/2021 10:48:59'!
portfolioElementsReport: aFinancialServiceList
	aFinancialServiceList do: [:aFinancialService |  reportTree add: (self newReportFor:aFinancialService) ]! !

!TreeReportGenerator methodsFor: 'report' stamp: 'E.V 6/3/2021 10:48:59'!
portfolioReport:aPortfolio
	 reportTree add: aPortfolio returnName.
	 aPortfolio addElementsToReport: self
	 ! !

!TreeReportGenerator methodsFor: 'report' stamp: 'E.V 6/3/2021 10:48:59'!
receptiveAccountReport: aReceptiveAccount
	 reportTree add: aReceptiveAccount returnName.! !


!TreeReportGenerator methodsFor: 'not used' stamp: 'E.V 6/2/2021 21:58:02'!
depositReport: aDeposit ! !

!TreeReportGenerator methodsFor: 'not used' stamp: 'E.V 6/2/2021 21:58:17'!
transferDepositReport: aTransferDeposit ! !

!TreeReportGenerator methodsFor: 'not used' stamp: 'E.V 6/3/2021 11:46:30'!
transferWithdrawReport: aTransferWithdraw! !

!TreeReportGenerator methodsFor: 'not used' stamp: 'E.V 6/2/2021 21:58:58'!
withdrawReport: aWithdraw 
! !


!classDefinition: #AccountSpecialTreeReportGenerator category: 'Portfolio-Ejercicio'!
TreeReportGenerator subclass: #AccountSpecialTreeReportGenerator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountSpecialTreeReportGenerator methodsFor: 'report' stamp: 'E.V 6/3/2021 10:31:22'!
newReportFor: aFinancialService 
	^ aFinancialService accountSpecialTreeReport ! !

!AccountSpecialTreeReportGenerator methodsFor: 'report' stamp: 'E.V 6/3/2021 10:48:59'!
portfolioReport:aPortfolio
	super portfolioReport: aPortfolio .
	reportTree add: (OrderedCollection with:'Balance = ', aPortfolio balance asString).
	 ! !

!AccountSpecialTreeReportGenerator methodsFor: 'report' stamp: 'E.V 6/3/2021 10:48:59'!
receptiveAccountReport: aReceptiveAccount
	 super receptiveAccountReport: aReceptiveAccount .
	 reportTree add: aReceptiveAccount accountSummaryReport .! !


!classDefinition: #Transfer category: 'Portfolio-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'deposit withdraw value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Transfer methodsFor: 'values' stamp: 'E.V 5/30/2021 15:20:35'!
value
	^value! !


!Transfer methodsFor: 'testing' stamp: 'E.V 6/2/2021 20:52:00'!
isMyDeposit:aDeposit
	^ deposit == aDeposit .! !

!Transfer methodsFor: 'testing' stamp: 'E.V 5/28/2021 16:16:34'!
isMyWithdraw:aWithdraw
	^ withdraw == aWithdraw .! !


!Transfer methodsFor: 'initialization' stamp: 'E.V 5/30/2021 15:21:56'!
initializeWith: aDeposit with: aWithdraw withValue: aValue  
	deposit  _ aDeposit .
	withdraw  _ aWithdraw .
	value _ aValue ! !


!Transfer methodsFor: 'operations' stamp: 'E.V 5/30/2021 15:19:53'!
addToBalance: aBalance
	^ aBalance  + value! !

!Transfer methodsFor: 'operations' stamp: 'E.V 5/30/2021 15:19:15'!
decreaseBalance:aBalance 
	^ aBalance  - value! !


!Transfer methodsFor: 'accesing' stamp: 'E.V 5/27/2021 21:12:47'!
deposit
	^deposit.! !

!Transfer methodsFor: 'accesing' stamp: 'E.V 5/27/2021 21:22:32'!
withdraw
	
	^withdraw! !


!Transfer methodsFor: 'error' stamp: 'E.V 6/1/2021 20:10:32'!
raiseErrorIfSender:aSenderAccount IsTheSameAsReceiver:aReceiverAccount
  aSenderAccount == aReceiverAccount ifTrue: [self error: self class anAccountCantTransferToItself]! !

!Transfer methodsFor: 'error' stamp: 'E.V 6/1/2021 20:03:48'!
raiseErrorIfanAmountIsZeroOrLess:anAmount
	anAmount <= 0 ifTrue:[self error: self class cantTransferFor0OrLessErrorDescription ].! !

!Transfer methodsFor: 'error' stamp: 'E.V 6/1/2021 20:13:19'!
raiseTransferErrorIfAnyWithAmount:anAmount withSender:aSenderAccount withReciever:aRecieverAccount
	self raiseErrorIfanAmountIsZeroOrLess:anAmount.
	self raiseErrorIfSender:aSenderAccount IsTheSameAsReceiver:aRecieverAccount.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'aux' stamp: 'E.V 6/1/2021 20:15:46'!
amount: anAmount from: aSenderAccount to: aReceiverAccount 
	|aTransfer|
	aTransfer _ self new.
	
	aTransfer raiseTransferErrorIfAnyWithAmount: anAmount withSender:aSenderAccount  withReciever:                                                                                                                                                           aReceiverAccount .
	
	^ aTransfer initializeWith: (aReceiverAccount receiveTransferFor: anAmount withTransfer: aTransfer) 
				    with: (aSenderAccount  sendTransferFor: anAmount withTransfer: aTransfer) withValue: anAmount
				    ! !


!Transfer class methodsFor: 'error' stamp: 'E.V 6/1/2021 20:06:24'!
anAccountCantTransferToItself
	^ ' Queres sacar plata de tu cuenta para volverla a poner? Sos capo eh... '
	! !

!Transfer class methodsFor: 'error' stamp: 'E.V 6/1/2021 20:03:17'!
cantTransferFor0OrLessErrorDescription
	^ 'pa que vas a transferir 0 o menos? El verdadero quien pudiera. '
	! !
