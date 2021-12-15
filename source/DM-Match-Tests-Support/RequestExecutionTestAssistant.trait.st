Trait {
	#name : #RequestExecutionTestAssistant,
	#category : #'DM-Match-Tests-Support'
}

{ #category : #'private - test support' }
RequestExecutionTestAssistant >> attack: anOpponentCreatureCard with: aCreatureCard [

	self match execute: ( AttackCreatureRequest attacking: anOpponentCreatureCard with: aCreatureCard )
		requestedBy: self turnPlayer
]

{ #category : #'private - test support' }
RequestExecutionTestAssistant >> changeCurrentStepTo: aTurnStep [

	self match execute: ( ChangeCurrentStepRequest changingTo: aTurnStep ) requestedBy: self turnPlayer
]

{ #category : #'private - test support' }
RequestExecutionTestAssistant >> chargeManaWith: aCard [

	self match execute: ( ChargeManaRequest chargingManaWith: aCard ) requestedBy: self turnPlayer
]

{ #category : #'private - test support' }
RequestExecutionTestAssistant >> chargeManaWithAll: aCardCollection [

	aCardCollection do: [ :aCard | 
		self chargeManaWith: aCard.
		2 timesRepeat: [ 
			self
				endTurn;
				changeCurrentStepTo: DrawCardStep new;
				drawCard;
				changeCurrentStepTo: ChargeManaStep new
			]
		]
]

{ #category : #'private - test support' }
RequestExecutionTestAssistant >> directAttackFrom: aCreatureCard [

	self match execute: ( DirectAttackRequest attackingWith: aCreatureCard )
		requestedBy: self turnPlayer
]

{ #category : #'private - test support' }
RequestExecutionTestAssistant >> drawCard [

	self match execute: DrawCardRequest new requestedBy: self turnPlayer
]

{ #category : #'private - test support' }
RequestExecutionTestAssistant >> endTurn [

	self match execute: EndTurnRequest new requestedBy: self turnPlayer
]

{ #category : #'private - accessing' }
RequestExecutionTestAssistant >> match [

	self subclassResponsibility
]

{ #category : #'private - test support' }
RequestExecutionTestAssistant >> summon: aCreatureCard tapping: aCard [

	self summon: aCreatureCard tappingAll: { aCard }
]

{ #category : #'private - test support' }
RequestExecutionTestAssistant >> summon: aCreatureCard tappingAll: aCardCollection [

	self match execute: ( SummonCreatureRequest summoning: aCreatureCard tappingAll: aCardCollection )
		requestedBy: self turnPlayer
]

{ #category : #'private - accessing' }
RequestExecutionTestAssistant >> turnPlayer [

	^ self match currentPlayer
]
